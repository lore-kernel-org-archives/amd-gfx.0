Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66209C531CF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 13:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F047110E345;
	Thu, 23 Jul 2026 13:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AVkB9RIW";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B0110E345
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=64RHyCeBk3CU37E8pcucUvvEUKJc8fZfFu515/K+Z08=; b=AVkB9RIWMEW985XScBuO4cviJA
 zi+BMQ6mbrhyzMV4DPNnTkb8uxERT3laZZ6sF2UaimUWi7PW2C1U0DzwL69hnrmqrmmiKWQwP4FcZ
 qVFuGEgEs4iCNg9TMdkIx8pciL0iftuYEqja+2ipzuc4uWa1IaXCQxqJxkR50B9VjJl6r7tCN+ldq
 UdyLN/vKBnslpAdiShjXQF+RssRfFRn9YoCqpyD+e0PhH/OVsDNGXf7MywiQWDUj0zOMxCtRgerAu
 Qw8yhB74LXANLkFIHIOAKY1G9VM48AcdNyFowJhFokqJiPTRTWF8+36voLMGdtezjMAtFU8KrNPWl
 7eKrG1fg==;
Received: from [31.4.149.127] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wmtUi-003SCN-6H; Thu, 23 Jul 2026 15:29:48 +0200
Message-ID: <690771f2-d540-4e8f-a450-6a1f00b8df9a@igalia.com>
Date: Thu, 23 Jul 2026 15:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/amd/display: use a separate helper to
 translate degamma curves
To: Alex Hung <alex.hung@amd.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 Xaver Hugl <xaver.hugl@kde.org>, robert.mader@posteo.de,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260623160112.1636801-1-mwen@igalia.com>
 <20260623160112.1636801-4-mwen@igalia.com>
 <6a705b70-dc0d-42de-a18d-cbc1a4698f71@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <6a705b70-dc0d-42de-a18d-cbc1a4698f71@amd.com>
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



On 22/07/2026 20:27, Alex Hung wrote:
>
>
> On 6/23/26 09:58, Melissa Wen wrote:
>> In newer DCN families, there is no hw predefined curves for shaper,
>> blend and regamma. When userspace sets pre-defined curves for these
>> blocks, the driver uses AMD color module to program predefined curve as
>> LUT. However, it was using the same LUT segmentation for EOTF and
>> inverse EOTF by using the same color management helper. This is causing
>> banding on blend when PQ predefined curve is set. Besides that, degamma
>> predefined HW curve cannot be used with subsampled 4:2:0/4:2:2 formats
>> as it affects the linearity of color space in which HW scaler operates.
>>
>> To mitigate banding when using the blend block and better support
>> subsampled format on degamma, use different translation helpers when
>> linearizing and delinearizing.
>>
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>   .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c 
>> b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> index 1340f673ec3b..c2ea25927765 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> @@ -493,11 +493,9 @@ bool dcn32_set_mcm_luts(
>>       if (plane_state->cm.blend_func.type == TF_TYPE_HWPWL)
>>           lut_params = &plane_state->cm.blend_func.pwl;
>>       else if (plane_state->cm.blend_func.type == 
>> TF_TYPE_DISTRIBUTED_POINTS) {
>> -        result = cm3_helper_translate_curve_to_hw_format(
>> -            plane_state->ctx,
>> +        result = cm3_helper_translate_curve_to_degamma_hw_format(
>>               &plane_state->cm.blend_func,
>> -            &dpp_base->regamma_params,
>> -            false);
>> +            &dpp_base->regamma_params);
>>           if (!result)
>>               return result;
>
> The above change broke two IGT's kms_colorop subtests (tested on 
> DCN3.5) as below

Hi Alex,

Thanks for pointing it out.
I tested with DCN301 (all tests pass) and DCN321 (same failures).
I'm a bit curious about this difference, probably some differences in 
precision, etc. I'll leave that out.
>
> =====================================
> Starting subtest: plane-XR30-XR30-srgb_inv_eotf_lut-srgb_eotf_lut
> i 2569 j 0 shift 10 mask 3ff comp1 3bf comp2 3ff, pixel1 3bfeffbf 
> pixel2 3fffffff
> [79.216137] (kms_colorop:10824) CRITICAL: Test assertion failure 
> function colorop_plane_test, file ../tests/kms_colorop.c:281:
> [79.216143] (kms_colorop:10824) CRITICAL: Failed assertion: 
> compare_with_bracket(&sw_transform_fb, output_fb)
> [79.216165] (kms_colorop:10824) CRITICAL: Last errno: 38, Function not 
> implemented
> Stack trace: not implemented
> Subtest plane-XR30-XR30-srgb_inv_eotf_lut-srgb_eotf_lut failed.
>
> Starting subtest: plane-XR30-XR30-gamma_2_2-gamma_2_2_inv-gamma_2_2
> i 15390 j 0 shift 10 mask 3ff comp1 398 comp2 3b8, pixel1 398e6398 
> pixel2 3b8ee3b8
> [81.747233] (kms_colorop:10824) CRITICAL: Test assertion failure 
> function colorop_plane_test, file ../tests/kms_colorop.c:281:
> [81.747239] (kms_colorop:10824) CRITICAL: Failed assertion: 
> compare_with_bracket(&sw_transform_fb, output_fb)
> [81.747256] (kms_colorop:10824) CRITICAL: Last errno: 38, Function not 
> implemented
> Stack trace: not implemented
> Subtest plane-XR30-XR30-gamma_2_2-gamma_2_2_inv-gamma_2_2 failed.
> =====================================
>
> The root cause is from color delta increases, as also confirmed by the 
> following IGT POC change:
>
> --- tests/kms_colorop.c
> +++ tests/kms_colorop.c
> @@ -182,7 +182,7 @@ static bool compare_with_bracket(igt_fb_t *in, 
> igt_fb_t *out)
>                 return igt_cmp_fb_pixels(in, out, 1, 1);
>
>         if (is_amdgpu_device(in->fd))
> -               return igt_cmp_fb_pixels(in, out, 13, 13);
> +               return igt_cmp_fb_pixels(in, out, 70, 13);
>
>
> Is there any concerns on reverting above changes (or this patch)?
>
> Note: I am looking for early feedback because I have not yet tested on 
> other DCN hardware.

Reverting this patch is not ideal because it addresses an issue on HDR 
Ori game on gamescope with external HDR monitor for DCN301, DCN321 and 
also DCN35 (IIRC Matt has verified the issue and this series in this hw 
version).

I think the possible solution is making 
cm3_helper_translate_curve_to_degamma_hw_format() take the same segment 
distribution for PQ/SRGB to any pre-defined TF or LUT.
Something like removing the if/else clause in dcn30_cm_common and 
applying PQ/SRGB distribution to all cases, as below:

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c 
b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 66fe7f313ea3..1b4ce77fdd91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -332,6 +332,7 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
         int32_t region_start, region_end;
         int32_t i;
         uint32_t j, k, seg_distr[MAX_REGIONS_NUMBER], increment, 
start_index, hw_points;
+       const uint8_t SEG_COUNT = 9;  // 9 segments, segments are from 
2^-9 to 0

         if (output_tf == NULL || lut_params == NULL || output_tf->type 
== TF_TYPE_BYPASS)
                 return false;
@@ -343,31 +344,12 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
         memset(lut_params, 0, sizeof(struct pwl_params));
         memset(seg_distr, 0, sizeof(seg_distr));

-       if (output_tf->tf == TRANSFER_FUNCTION_PQ ||
-           output_tf->tf == TRANSFER_FUNCTION_SRGB) {
-               /* 9 segments
-                * segments are from 2^-9 to 0
-                */
-               const uint8_t SEG_COUNT = 9;
-               seg_distr[0] = 0; // Since we only have one point in 
darkest region
-               for (k = 1; k < SEG_COUNT; k++)
-                       seg_distr[k] = k - 1; // 2^(k-1) points per 
region; halves as k decreases
+       seg_distr[0] = 0; // Since we only have one point in darkest region
+       for (k = 1; k < SEG_COUNT; k++)
+               seg_distr[k] = k - 1; // 2^(k-1) points per region; 
halves as k decreases

-               region_start = -SEG_COUNT;
-               region_end = 0;
-       } else {
-               /* 12 segments
-                * segments are from 2^-12 to 2^0
-                * There are less than 256 points, for optimization
-                */
-               const uint8_t SEG_COUNT = 12;
-
-               for (i = 0; i < SEG_COUNT; i++)
-                       seg_distr[i] = 4;
-
-               region_start = -SEG_COUNT;
-               region_end = 0;
-       }
+       region_start = -SEG_COUNT;
+       region_end = 0;

         for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
                 seg_distr[i] = -1;

I'll check if there is any side effect on gamescope with this change 
ASAP, but I don't think so.

WDYT?

Melissa

>
>
>> @@ -554,9 +552,8 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
>>       if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
>>           params = &plane_state->in_transfer_func.pwl;
>>       else if (plane_state->in_transfer_func.type == 
>> TF_TYPE_DISTRIBUTED_POINTS &&
>> - cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>> - &plane_state->in_transfer_func,
>> -                            &dpp_base->degamma_params, false))
>> + 
>> cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->in_transfer_func,
>> + &dpp_base->degamma_params))
>>           params = &dpp_base->degamma_params;
>>         dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
>

