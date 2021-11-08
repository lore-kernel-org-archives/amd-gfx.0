Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E10C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAFF60F5A
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DAAFF60F5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F1756E9A0;
	Mon,  8 Nov 2021 14:21:12 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF49A6E9A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 14:21:11 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8963861EA191C;
 Mon,  8 Nov 2021 15:21:09 +0100 (CET)
Message-ID: <1843f7b1-b1f6-71e1-4898-7cec98ff965d@molgen.mpg.de>
Date: Mon, 8 Nov 2021 15:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: reject both non-zero src_x and src_y
 only for DCN1x
Content-Language: en-US
To: Shirish S <sshankar@amd.com>, Shirish S <shirish.s@amd.com>
References: <20211108081514.9925-1-shirish.s@amd.com>
 <94d54215-6500-e5df-1069-71706431e059@molgen.mpg.de>
 <33c6efa7-3c7e-be2c-6513-f9ec82e63faf@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <33c6efa7-3c7e-be2c-6513-f9ec82e63faf@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Which address should be used: sshankar@amd.com or shirish.s@amd.com?]

Dear Shirish,


Am 08.11.21 um 12:11 schrieb S, Shirish:

> On 11/8/2021 2:25 PM, Paul Menzel wrote:

>> Am 08.11.21 um 09:15 schrieb Shirish S:
>>> limit the MPO rejection only for DCN1x as its not required on later
>>
>> it’s
>>
>>> versions.
>>
>> Where is it documented, that it’s not required for later versions?
> 
> This is a workaround to avoid system hang & I've verified its not 
> required DCN2.0.

Please extend the commit message with that information, and also add how 
you verified, that it’s not required for DCN2.0 exactly. (Just test one 
system?)

> We generally don't have documentation for WA's.

WA is workaround?


Kind regards,

Paul


>> Shortly describing the implementation is also useful. Something like: 
>> Require `fill_dc_scaling_info()` to receive the device to be able to 
>> check the version.
>>
>>> Fixes: d89f6048bdcb ("drm/amd/display: Reject non-zero src_y and 
>>> src_x for video planes")
>>>
>>
>> I’d remove the blank line.
>>
>>> Signed-off-by: Shirish S <shirish.s@amd.com>
>>> ---
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++++---------
>>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 1e26d9be8993..26b29d561919 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -4572,7 +4572,8 @@ static void get_min_max_dc_plane_scaling(struct 
>>> drm_device *dev,
>>>   }
>>>     -static int fill_dc_scaling_info(const struct drm_plane_state 
>>> *state,
>>> +static int fill_dc_scaling_info(struct amdgpu_device *adev,
>>> +                const struct drm_plane_state *state,
>>>                   struct dc_scaling_info *scaling_info)
>>>   {
>>>       int scale_w, scale_h, min_downscale, max_upscale;
>>> @@ -4586,7 +4587,8 @@ static int fill_dc_scaling_info(const struct 
>>> drm_plane_state *state,
>>>       /*
>>>        * For reasons we don't (yet) fully understand a non-zero
>>>        * src_y coordinate into an NV12 buffer can cause a
>>> -     * system hang. To avoid hangs (and maybe be overly cautious)
>>> +     * system hang on DCN1x.
>>> +     * To avoid hangs (and maybe be overly cautious)
>>
>> I’d remove the added line break.
>>
>>>        * let's reject both non-zero src_x and src_y.
>>>        *
>>>        * We currently know of only one use-case to reproduce a
>>> @@ -4594,10 +4596,10 @@ static int fill_dc_scaling_info(const struct 
>>> drm_plane_state *state,
>>>        * is to gesture the YouTube Android app into full screen
>>>        * on ChromeOS.
>>>        */
>>> -    if (state->fb &&
>>> -        state->fb->format->format == DRM_FORMAT_NV12 &&
>>> -        (scaling_info->src_rect.x != 0 ||
>>> -         scaling_info->src_rect.y != 0))
>>> +    if (((adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 0)) ||
>>> +        (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 1))) &&
>>> +        (state->fb && state->fb->format->format == DRM_FORMAT_NV12 &&
>>> +        (scaling_info->src_rect.x != 0 || scaling_info->src_rect.y 
>>> != 0)))
>>>           return -EINVAL;
>>>         scaling_info->src_rect.width = state->src_w >> 16;
>>> @@ -5503,7 +5505,7 @@ static int fill_dc_plane_attributes(struct 
>>> amdgpu_device *adev,
>>>       int ret;
>>>       bool force_disable_dcc = false;
>>>   -    ret = fill_dc_scaling_info(plane_state, &scaling_info);
>>> +    ret = fill_dc_scaling_info(adev, plane_state, &scaling_info);
>>>       if (ret)
>>>           return ret;
>>>   @@ -7566,7 +7568,7 @@ static int dm_plane_atomic_check(struct 
>>> drm_plane *plane,
>>>       if (ret)
>>>           return ret;
>>>   -    ret = fill_dc_scaling_info(new_plane_state, &scaling_info);
>>> +    ret = fill_dc_scaling_info(adev, new_plane_state, &scaling_info);
>>>       if (ret)
>>>           return ret;
>>>   @@ -9014,7 +9016,7 @@ static void amdgpu_dm_commit_planes(struct 
>>> drm_atomic_state *state,
>>> bundle->surface_updates[planes_count].gamut_remap_matrix = 
>>> &dc_plane->gamut_remap_matrix;
>>>           }
>>>   -        fill_dc_scaling_info(new_plane_state,
>>> +        fill_dc_scaling_info(dm->adev, new_plane_state,
>>> &bundle->scaling_infos[planes_count]);
>>> bundle->surface_updates[planes_count].scaling_info =
>>>
