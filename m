Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0678DC9EC7A
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 11:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF6410E3A8;
	Mon, 12 Jan 2026 11:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UPrVphnT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9684410E3A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Dr1/iCGI60NFObfkIZYGg8VzyE9cs563jDFAI1FjDUY=; b=UPrVphnTCeTgKgFlNnxijSAi15
 QBAo0RshUAMr7N7YdVTFvHnJfjpupVdjV5fqqxzU4DJD0IaPNW0RICao+AFPvQGhT/wFVY09DT120
 +LYh09duOXbn++CYrOK0V1xutMNj+NoI7H7Q/3XH+Hg8DDt9zyjFNOowcF7HU3KA1f/Rv1UqDArpy
 C4Zsas2eLkDa65nbcK8ITrTlt3fvkNDeMVVxD2vxuvacpBSyhAnDwS96KLGN26vYsX7EsG46/X3+q
 QX+GfJYhsY7LBSeseDRkla5h5hsSskZEiJuztDBFmfbgryViWJRTSO/w2B0vE12NuQqpNefECUKhX
 sFFW1vIw==;
Received: from [186.208.74.210] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vfGLK-004Nln-Kr; Mon, 12 Jan 2026 12:44:18 +0100
Message-ID: <73968fb1-9e8a-4289-bc75-e7ef0b882b5a@igalia.com>
Date: Mon, 12 Jan 2026 08:44:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] drm/amd/display: Fix and reenable
 UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL
From: Melissa Wen <mwen@igalia.com>
To: Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
 <20251216095723.39018-7-chen-yu.chen@amd.com>
 <531a3b9d-d63e-4d72-bc44-2e95907aecde@igalia.com>
Content-Language: en-US
In-Reply-To: <531a3b9d-d63e-4d72-bc44-2e95907aecde@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 06/01/2026 09:18, Melissa Wen wrote:
> Hi,
>
> This change reintroduce some glitches/screen corruption on DCN321 with 
> gamescope and a 4k@120Hz display, when transitioning from multiple 
> planes (primary + overlay, and pipe split) to single plane (no pipe 
> split).
> We see small white artifacts near the cursor in its first appearance 
> on the screen after boot, and eventually a corrupted,colorful strip 
> appears in "fast" transitions between single plane -> multi-plane -> 
> single plane, for example, when moving the cursor (single plane), 
> click on the Steam menu (multi planes) and moving the cursor just 
> after (single plane).
>
> The problem was previously solved by commit 24ddca9a3af1 
> ("drm/amd/display: Defer transitions from minimal state to final 
> state") [1] and reintroduced again by this patch here, i.e., I don't 
> see the issue if I revert this commit here in current asdn.
> Also, the issue isn't reproducible if you disable SubVP.

Just to reinforce that the situation I describe here affects this issue 
in a similar way:
- https://gitlab.freedesktop.org/drm/amd/-/issues/3614 ("[DCN32/7900XTX] 
when VRR is active + an overlay plane is in use, using a hardware cursor 
in gamescope-session causes artifacts during transition out of scan-out")

Melissa

>
> [1] https://gitlab.freedesktop.org/agd5f/linux/-/commit/24ddca9a3af1
>
> Best Regards,
>
> Melissa
>
> On 16/12/2025 06:56, Chenyu Chen wrote:
>> From: Dominik Kaszewski <dominik.kaszewski@amd.com>
>>
>> [Why]
>> Reenable new split implementation, previously partially reverted due
>> to issues with ODM on high-bandwidth displays 4k144Hz, resulting
>> in a corrupted gray screen.
>>
>> Minimal flows require two separate commits, with extra intermediate
>> commit to enable seamless transitions, each followed by a swap. Since
>> new design requires commit to be run in execute and swap in cleanup
>> stage, an attempt was made to reorder them from CSCS 
>> (Commit-Swap-Commit-Swap)
>> to CCSS (Commit-Commit-Swap-Swap). Not only is this not viable, but
>> was implemented incorrectly as CCS, one swap missing.
>>
>> [How]
>> * Change UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW/CURRENT to execute
>> and cleanup one commit, then run UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS,
>> which closely matches old implementation where minimal flows fall back
>> to seamless.
>> * Fix uninitialized variable error.
>>
>> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>> Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
>> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/core/dc.c | 80 ++++++++++++------------
>>   1 file changed, 39 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c 
>> b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index 1be5c1c15798..57f6a4c8afff 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -784,7 +784,7 @@ bool dc_stream_get_crc(struct dc *dc, struct 
>> dc_stream_state *stream, uint8_t id
>>                  uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
>>   {
>>       int i;
>> -    struct pipe_ctx *pipe;
>> +    struct pipe_ctx *pipe = NULL;
>>       struct timing_generator *tg;
>>         dc_exit_ips_for_hw_access(dc);
>> @@ -5437,35 +5437,23 @@ bool dc_update_planes_and_stream(struct dc *dc,
>>           struct dc_stream_state *stream,
>>           struct dc_stream_update *stream_update)
>>   {
>> -    bool ret = false;
>> +    struct dc_update_scratch_space *scratch = 
>> dc_update_planes_and_stream_init(
>> +            dc,
>> +            srf_updates,
>> +            surface_count,
>> +            stream,
>> +            stream_update
>> +    );
>> +    bool more = true;
>>   -    dc_exit_ips_for_hw_access(dc);
>> -    /*
>> -     * update planes and stream version 3 separates FULL and FAST 
>> updates
>> -     * to their own sequences. It aims to clean up frequent checks for
>> -     * update type resulting unnecessary branching in logic flow. It 
>> also
>> -     * adds a new commit minimal transition sequence, which detects 
>> the need
>> -     * for minimal transition based on the actual comparison of 
>> current and
>> -     * new states instead of "predicting" it based on per feature 
>> software
>> -     * policy.i.e could_mpcc_tree_change_for_active_pipes. The new 
>> commit
>> -     * minimal transition sequence is made universal to any power 
>> saving
>> -     * features that would use extra free pipes such as Dynamic ODM/MPC
>> -     * Combine, MPO or SubVp. Therefore there is no longer a need to
>> -     * specially handle compatibility problems with transitions 
>> among those
>> -     * features as they are now transparent to the new sequence.
>> -     */
>> -    if (dc->ctx->dce_version >= DCN_VERSION_4_01 || 
>> dc->ctx->dce_version == DCN_VERSION_3_2 ||
>> -            dc->ctx->dce_version == DCN_VERSION_3_21)
>> -        ret = update_planes_and_stream_v3(dc, srf_updates,
>> -                surface_count, stream, stream_update);
>> -    else
>> -        ret = update_planes_and_stream_v2(dc, srf_updates,
>> -            surface_count, stream, stream_update);
>> -    if (ret && (dc->ctx->dce_version >= DCN_VERSION_3_2 ||
>> -        dc->ctx->dce_version == DCN_VERSION_3_01))
>> -        clear_update_flags(srf_updates, surface_count, stream);
>> +    while (more) {
>> +        if (!dc_update_planes_and_stream_prepare(scratch))
>> +            return false;
>>   -    return ret;
>> +        dc_update_planes_and_stream_execute(scratch);
>> +        more = dc_update_planes_and_stream_cleanup(scratch);
>> +    }
>> +    return true;
>>   }
>>     void dc_commit_updates_for_stream(struct dc *dc,
>> @@ -7241,7 +7229,7 @@ static bool update_planes_and_stream_cleanup_v2(
>>       return false;
>>   }
>>   -static void update_planes_and_stream_cleanup_v3_intermediate(
>> +static void update_planes_and_stream_cleanup_v3_release_minimal(
>>           struct dc_update_scratch_space *scratch,
>>           bool backup
>>   );
>> @@ -7262,6 +7250,10 @@ static bool update_planes_and_stream_prepare_v3(
>>           struct dc_update_scratch_space *scratch
>>   )
>>   {
>> +    if (scratch->flow == UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS) {
>> +        return true;
>> +    }
>> +    ASSERT(scratch->flow == UPDATE_V3_FLOW_INVALID);
>>       dc_exit_ips_for_hw_access(scratch->dc);
>>         if (!update_planes_and_stream_state(
>> @@ -7327,11 +7319,11 @@ static bool update_planes_and_stream_prepare_v3(
>>               return true;
>>           }
>>   - update_planes_and_stream_cleanup_v3_intermediate(scratch, false);
>> + update_planes_and_stream_cleanup_v3_release_minimal(scratch, false);
>>       }
>>   - 
>> restore_planes_and_stream_state(&scratch->dc->scratch.current_state, 
>> scratch->stream);
>>       scratch->backup_context = scratch->dc->current_state;
>> + 
>> restore_planes_and_stream_state(&scratch->dc->scratch.current_state, 
>> scratch->stream);
>>       dc_state_retain(scratch->backup_context);
>>       scratch->intermediate_context = create_minimal_transition_state(
>>               scratch->dc,
>> @@ -7347,7 +7339,7 @@ static bool update_planes_and_stream_prepare_v3(
>>               return true;
>>           }
>>   - update_planes_and_stream_cleanup_v3_intermediate(scratch, true);
>> + update_planes_and_stream_cleanup_v3_release_minimal(scratch, true);
>>       }
>>         scratch->flow = UPDATE_V3_FLOW_INVALID;
>> @@ -7398,12 +7390,10 @@ static void update_planes_and_stream_execute_v3(
>>         case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW:
>>           update_planes_and_stream_execute_v3_commit(scratch, false, 
>> true);
>> -        update_planes_and_stream_execute_v3_commit(scratch, false, 
>> false);
>>           break;
>>         case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT:
>>           update_planes_and_stream_execute_v3_commit(scratch, true, 
>> true);
>> -        update_planes_and_stream_execute_v3_commit(scratch, false, 
>> false);
>>           break;
>>         case UPDATE_V3_FLOW_INVALID:
>> @@ -7419,7 +7409,7 @@ static void 
>> update_planes_and_stream_cleanup_v3_new_context(
>>       swap_and_release_current_context(scratch->dc, 
>> scratch->new_context, scratch->stream);
>>   }
>>   -static void update_planes_and_stream_cleanup_v3_intermediate(
>> +static void update_planes_and_stream_cleanup_v3_release_minimal(
>>           struct dc_update_scratch_space *scratch,
>>           bool backup
>>   )
>> @@ -7432,6 +7422,16 @@ static void 
>> update_planes_and_stream_cleanup_v3_intermediate(
>>       );
>>   }
>>   +static void update_planes_and_stream_cleanup_v3_intermediate(
>> +        struct dc_update_scratch_space *scratch,
>> +        bool backup
>> +)
>> +{
>> +    swap_and_release_current_context(scratch->dc, 
>> scratch->intermediate_context, scratch->stream);
>> +    dc_state_retain(scratch->dc->current_state);
>> + update_planes_and_stream_cleanup_v3_release_minimal(scratch, backup);
>> +}
>> +
>>   static bool update_planes_and_stream_cleanup_v3(
>>           struct dc_update_scratch_space *scratch
>>   )
>> @@ -7448,17 +7448,15 @@ static bool update_planes_and_stream_cleanup_v3(
>>         case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW:
>> update_planes_and_stream_cleanup_v3_intermediate(scratch, false);
>> - update_planes_and_stream_cleanup_v3_new_context(scratch);
>> -        break;
>> +        scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS;
>> +        return true;
>>         case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT:
>> -        swap_and_release_current_context(scratch->dc, 
>> scratch->intermediate_context, scratch->stream);
>> -        dc_state_retain(scratch->dc->current_state);
>> update_planes_and_stream_cleanup_v3_intermediate(scratch, true);
>>           dc_state_release(scratch->backup_context);
>> restore_planes_and_stream_state(&scratch->dc->scratch.new_state, 
>> scratch->stream);
>> - update_planes_and_stream_cleanup_v3_new_context(scratch);
>> -        break;
>> +        scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS;
>> +        return true;
>>         case UPDATE_V3_FLOW_INVALID:
>>       default:
>

