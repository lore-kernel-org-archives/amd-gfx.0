Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95562C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 15:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EA860524
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 15:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3EA860524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B05389993;
	Mon, 25 Oct 2021 15:12:33 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B98E89993
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 15:12:31 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3E46661EA191C;
 Mon, 25 Oct 2021 17:12:29 +0200 (CEST)
Message-ID: <b8adaf50-b856-3425-d8d9-5c2c6090cbf6@molgen.mpg.de>
Date: Mon, 25 Oct 2021 17:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 32/33] drm/amd/display: fix link training regression for 1
 or 2 lane
Content-Language: en-US
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aurabindo.Pillai@amd.com,
 qingqing.zhuo@amd.com, mikita.lipski@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, wayne.lin@amd.com, stylon.wang@amd.com,
 solomon.chiu@amd.com, pavle.kotarac@amd.com, agustin.gutierrez@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Eric Yang <eric.yang2@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
 <20211024133141.239861-33-Rodrigo.Siqueira@amd.com>
 <16010bef-7bf4-1da4-9f76-7b23d4296d5b@molgen.mpg.de>
 <93093738-86a1-056e-08fc-803aecee27f1@amd.com>
 <90804a63-686a-7f84-ba20-db06a101fbec@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <90804a63-686a-7f84-ba20-db06a101fbec@amd.com>
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

Dear Nicholas, dear Harry,


On 25.10.21 16:42, Kazlauskas, Nicholas wrote:
> On 2021-10-25 9:58 a.m., Harry Wentland wrote:

>> On 2021-10-25 07:25, Paul Menzel wrote:

>>> On 24.10.21 15:31, Rodrigo Siqueira wrote:
>>>> From: Wenjing Liu <wenjing.liu@amd.com>
>>>>
>>>> [why]
>>>> We have a regression that cause maximize lane settings to use
>>>> uninitialized data from unused lanes.
>>>
>>> Which commit caused the regression? Please amend the commit message.
>>>
>>>> This will cause link training to fail for 1 or 2 lanes because the lane
>>>> adjust is populated incorrectly sometimes.
>>>
>>> On what card did you test this, and how can it be reproduced?
>>>
>>> Please describe the fix/implemantation in the commit message.
>>>
>>>> Reviewed-by: Eric Yang <eric.yang2@amd.com>
>>>> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>>> Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
>>>> ---
>>>>    .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 35 +++++++++++++++++--
>>>>    1 file changed, 32 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c 
>>>> b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>>> index 653279ab96f4..f6ba7c734f54 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>>> @@ -108,6 +108,9 @@ static struct dc_link_settings 
>>>> get_common_supported_link_settings(
>>>>            struct dc_link_settings link_setting_b);
>>>>    static void maximize_lane_settings(const struct 
>>>> link_training_settings *lt_settings,
>>>>            struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
>>>> +static void override_lane_settings(const struct 
>>>> link_training_settings *lt_settings,
>>>> +        struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
>>>> +
>>>>    static uint32_t get_cr_training_aux_rd_interval(struct dc_link 
>>>> *link,
>>>>            const struct dc_link_settings *link_settings)
>>>>    {
>>>> @@ -734,15 +737,13 @@ void dp_decide_lane_settings(
>>>>            }
>>>>    #endif
>>>>        }
>>>> -
>>>> -    /* we find the maximum of the requested settings across all 
>>>> lanes*/
>>>> -    /* and set this maximum for all lanes*/
>>>>        dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, 
>>>> dpcd_lane_settings);
>>>>          if (lt_settings->disallow_per_lane_settings) {
>>>>            /* we find the maximum of the requested settings across 
>>>> all lanes*/
>>>>            /* and set this maximum for all lanes*/
>>>>            maximize_lane_settings(lt_settings, hw_lane_settings);
>>>> +        override_lane_settings(lt_settings, hw_lane_settings);
>>>>              if (lt_settings->always_match_dpcd_with_hw_lane_settings)
>>>>                dp_hw_to_dpcd_lane_settings(lt_settings, 
>>>> hw_lane_settings, dpcd_lane_settings);
>>>> @@ -833,6 +834,34 @@ static void maximize_lane_settings(const struct 
>>>> link_training_settings *lt_setti
>>>>        }
>>>>    }
>>>>    +static void override_lane_settings(const struct 
>>>> link_training_settings *lt_settings,
>>>> +        struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
>>>> +{
>>>> +    uint32_t lane;
>>>> +
>>>> +    if (lt_settings->voltage_swing == NULL &&
>>>> +            lt_settings->pre_emphasis == NULL &&
>>>> +#if defined(CONFIG_DRM_AMD_DC_DP2_0)
>>>> +            lt_settings->ffe_preset == NULL &&
>>>> +#endif
>>>> +            lt_settings->post_cursor2 == NULL)
>>>> +
>>>> +        return;
>>>> +
>>>> +    for (lane = 1; lane < LANE_COUNT_DP_MAX; lane++) {
>>>> +        if (lt_settings->voltage_swing)
>>>> +            lane_settings[lane].VOLTAGE_SWING = 
>>>> *lt_settings->voltage_swing;
>>>> +        if (lt_settings->pre_emphasis)
>>>> +            lane_settings[lane].PRE_EMPHASIS = 
>>>> *lt_settings->pre_emphasis;
>>>> +        if (lt_settings->post_cursor2)
>>>> +            lane_settings[lane].POST_CURSOR2 = 
>>>> *lt_settings->post_cursor2;
>>>> +#if defined(CONFIG_DRM_AMD_DC_DP2_0)
>>>> +        if (lt_settings->ffe_preset)
>>>> +            lane_settings[lane].FFE_PRESET = *lt_settings->ffe_preset;
>>>> +#endif
>>>
>>> Normally these checks should be done in C and not the preprocessor. 
>>> `if CONFIG(DRM_AMD_DC_DP2_0)` or similar should work.
>>>
>>
>> Interesting. I've never seen this before. Do you have an example or 
>> link to a doc? A cursory search doesn't yield any results but I might 
>> not be searching for the right thing.
>>
>> Harry
> 
> I'm curious about this too. The compiler with optimizations should 
> remove the constant check, but technically the C standard only permits 
> it - it doesn't guarantee that it happens.
> 
> However, this patch should actually be changed to drop these 
> CONFIG_DRM_AMD_DC_DP2_0 guards - this isn't a Kconfig option nor will 
> there be one specifically for DP2. This should be folded under the DCN 
> support.

 From the Linux kernel coding style [1][2]:

> Within code, where possible, use the IS_ENABLED macro to convert a
> Kconfig symbol into a C boolean expression, and use it in a normal C
> conditional:
> 
> if (IS_ENABLED(CONFIG_SOMETHING)) {
>         ...
> }


Kind regards,

Paul


>>>> +    }
>>>> +}
>>>> +
>>>>    enum dc_status dp_get_lane_status_and_lane_adjust(
>>>>        struct dc_link *link,
>>>>        const struct link_training_settings *link_training_setting,

[1]: 
https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation
[2]: Documentation/process/coding-style.rst
