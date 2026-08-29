import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const { userId, actionType } = await req.json()
    
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Check current rate limit
    const { data: rateLimit } = await supabase
      .from('rate_limits')
      .select('*')
      .eq('user_id', userId)
      .eq('action_type', actionType)
      .single()

    const now = new Date()
    const windowStart = new Date(now.getTime() - 60000) // 1 minute window

    if (rateLimit && new Date(rateLimit.window_start) > windowStart) {
      if (rateLimit.count >= 10) { // Max 10 actions per minute
        return new Response(
          JSON.stringify({ allowed: false, message: 'Rate limit exceeded' }),
          { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      // Increment count
      await supabase
        .from('rate_limits')
        .update({ count: rateLimit.count + 1 })
        .eq('id', rateLimit.id)
    } else {
      // Create new rate limit record
      await supabase
        .from('rate_limits')
        .insert({
          user_id: userId,
          action_type: actionType,
          count: 1,
          window_start: now.toISOString()
        })
    }

    return new Response(
      JSON.stringify({ allowed: true }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 400 }
    )
  }
})
