Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7A606A323
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5uSCJWT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CDA10F0C9;
	Sat, 14 Nov 2026 19:11:02 +0000 (UTC)
Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3015110E38F
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 14:18:36 +0000 (UTC)
Received: by mail-wm2-f8.google.com with SMTP id
 5b1f17b1804b1-4a77811be24so6841595e9.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 06:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794665914; x=1795270714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qCLn+aRqPlhKjyBNsbMK/eyxZvcZo9cm8uyQg9JeKqo=;
 b=Q5uSCJWTQnMsKJj5f1ipVS98A7eRQ01iuHO3PX9sFtf0P/BAykzppKB+vxhadFqC6O
 hyPn5+4c4EFSjgpn0j0xlvk2/PxCRHIujYHHap55BBhdoW3lN0WG7YGUQ97oHWOLJUUJ
 wr5wKf9vm1zXbblXLwTd5M4D1kretmviD5P3bVaErqWl2p7FFw/5ATP3XUpN302Gkgr9
 hBVs6EDxuRoBE3EQsbnkDaUavu7KnmaVNUWsiYTkj5/Gipd8NB5vj3PguAWJMU3oh2GF
 xIciG6T2zq8QHGa5ZUwOAWgZgegyb+QjxJCt85UOiyOTiw9xrYCne/wNadO6vbKwUkt2
 l+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794665914; x=1795270714;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qCLn+aRqPlhKjyBNsbMK/eyxZvcZo9cm8uyQg9JeKqo=;
 b=nHEnOk92IHQEg6ia/pTlFp1pl9l7wwgWnr16quYIsw3sWnL20nHop3/2FFTQmOdnb7
 CoGApAROlzuUYOJCkEKrm+npUmZAkCugQRag6EHxEGhOhq5Gk7pQkxArn60scdl9oCGW
 Ubgn7GXYpNCuEDJAyGKCVqw1DmNmvG2f79uIEWn4x2GnJCf6LrUTsRRqC/CK7HrCbsGi
 Y0ETAenxFcDC/8doaQKicziIRthO73ISwe2dan7DiXGyYZssMBwXAE8TmKXDg5pL9g+7
 6q2vaZQvXFWc179kJR2XqAiKMNFAYXdLRMhLv/kXfby25FIgR5jSEW7Jq9IDHCe4MXtR
 UbvQ==
X-Gm-Message-State: APuU4Z8upNtjNdilpjaM/ofosBa8VrxkX7Cv0IGt8J25gPlu6GS0YH+8
 z/ncplg4iBC6vV3Px3RWKUhK9lf4UyfG27O0Sru3fsTPPy6uJiDtD+h8
X-Gm-Gg: AYBFou1CtZk6DE5zR73fWQDplb+3oDAtwlA3jxUNV0lD+vGBW860DynG8tziKTc/z7d
 tPlaIRD3tw0xm8MJfkASIg7XNBhcWnaIDkwLXnduXZk+yzMoh4i8zycKXG+sYvBTClcPqaV7frE
 iNEiJ++bg13hbV/OkImxC//0r80XqRxKRYczyNuUu7u2WS50HdxFyM3p93jJZ6y139F4VDQcaZI
 S7TtkTEneIZW9nlxgoqlCJJRKTuC78gyEvOLe60Cb8Qk74yfuSwiap/qx4EetTyG/kNPepuheJm
 0ksVw77pjFKQeikZWRYjFyVJlQzipBq8ME0sIgPenErYBzuZT1FYlA1A69RVsgNIWO3g4/tvY3M
 bk8QgFCGHYWHEWhZbojKUG6k0/cJCSw2v/dbeqE2hMZK7Mh1LCj77vV5c6uYosxS+ZV1BaE8klm
 oJ6bxhF5t2uYJ3SrHnEUggHRvJk7UL9IoJnH/5CypJ+jrvvbEyi9f+vVjWkuy0NOdotjMgK3ZhM
 tiuwTSuN48DdQR1aol7PC2sZsXZN7KY652dO2OYQKeTBF88CBt5ennmkLwDqx/0wxQjDN3mDZAQ
 7rrziTndhCAiJib42o5d5S8/GxuM3jbF+R8=
X-Received: by 2002:a05:600c:1f96:b0:4a2:150f:1601 with SMTP id
 5b1f17b1804b1-4bb55a4eb97mr116556465e9.12.1794665914303; 
 Sat, 14 Nov 2026 06:18:34 -0800 (PST)
Received: from [192.168.1.7] ([31.94.68.191]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6020bb0fsm10484086f8f.34.2026.11.14.06.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 06:18:33 -0800 (PST)
Message-ID: <5c3aeee1-1436-4b77-b742-ba916376b479@gmail.com>
Date: Sat, 14 Nov 2026 14:18:32 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amd/display: report synced displays to
 PowerPlay for MCLK switch
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
 <CADnq5_OrGuMJT4Tvt+wktPzTYEopdkCjyqq8sSdvJou40-HoKw@mail.gmail.com>
 <a6093dab-c38d-4dad-af3b-7173a6eaa78c@gmail.com>
 <CADnq5_MRA2bQG5x9xiGAT5ddh0jHMqg=u2OhCPvJxPr3ddTurA@mail.gmail.com>
 <b9f69d90-73ef-4a22-a347-0d70f014a7de@gmail.com>
 <CADnq5_PZ3B863S238TkrGSubWa_VExySu9pkh5xDfrST11y5GQ@mail.gmail.com>
Content-Language: en-US
From: Richard Lane <richardlanedev@gmail.com>
In-Reply-To: <CADnq5_PZ3B863S238TkrGSubWa_VExySu9pkh5xDfrST11y5GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 19:10:55 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/11/2026 14:05, Alex Deucher wrote:
> On Thu, Nov 12, 2026 at 7:15 PM Richard Lane <richardlanedev@gmail.com> wrote:
>>
>> On 10/11/2026 19:59, Alex Deucher wrote:
>>> On Tue, Nov 10, 2026 at 1:49 PM Richard Lane <richardlanedev@gmail.com> wrote:
>>>>
>>>> On 09/11/2026 20:34, Alex Deucher wrote:
>>>>> On Mon, Nov 2, 2026 at 3:31 AM Richard Lane <richardlanedev@gmail.com> wrote:
>>>>>>
>>>>>> When driving multiple displays or tiled panels with identical timings
>>>>>> (such as the two 2560x2880 tiles of an Apple 5K iMac panel), Display
>>>>>> Core's program_timing_sync() aligns the CRTCs into a timing sync group
>>>>>> in hardware during dc_commit_streams().
>>>>>>
>>>>>> However, on DCE < 12, Display Core leaves
>>>>>> pp_display_cfg.all_displays_in_sync unset. Because PowerPlay is not
>>>>>> informed that the streams have synchronized vertical blanking intervals,
>>>>>> SMU7 prevents MCLK switching at idle or causes modeset underflows.
>>>>>>
>>>>>> If all active streams belong to the same timing sync group
>>>>>> (timing_sync_info.group_size == params.stream_count), report
>>>>>> all_displays_in_sync = true to PowerPlay after committing the streams so
>>>>>> SMU7 can safely downclock MCLK at idle.
>>>>>>
>>>>>
>>>>> Looking at this a little deeper, the function bw_calcs() in
>>>>> dce_calcs.c already calculates all_displays_in_sync using the helper
>>>>> all_displays_in_sync().  Can you look into this and figure out why
>>>>> that is not working as expected?  My concern with this patch is that
>>>>> DCE and DCN have different logic for handling mclk switching so I'm
>>>>> not sure it's safe to call dm_pp_apply_display_requirements() directly
>>>>> from common code.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Alex
>>>>
>>>> Moving it to dce_clk_mgr.c and using resource_are_streams_timing_synchronizable() also works. Is that a solution?
>>>
>>> I think that would be preferred, but in general, why doesn't the
>>> current flow I described work?  The function bw_calcs() dce_calcs.c
>>> already calculates the all_displays_in_sync flag using the helper
>>> all_displays_in_sync().  Is all_displays_in_sync() not checking
>>> something properly or is the overall call timing wrong such that
>>> all_displays_in_sync() can't properly calculate whether all of the
>>> displays are synced at the point that it gets called?
>>>
>>> Alex
>>>
>>
>> I think this could be limited to DCE 6,8,10 rather than DCE < 12 as in these
>> cases DC uses dce100_validate_bandwdith() which doesn't call bw_calcs() and
>> dce_pplib_apply_display_requirements() in dce_clk_mgr.c so
>> pp_display_cfg->all_displays_in_sync is unset.
> 
> How about adding bw_calcs() to dce100_validate_bandwdith()?  Or if
> there are issues there, just add the all_displays_in_sync() checks to
> dce100_validate_bandwdith().
> 
> Alex
> 

bw_calcs() itself cannot be called in dce100_validate_bandwidth() because
bw_calcs_init() only initializes dc->bw_dceip and dc->bw_vbios on DCE
11.0, 11.2, and 12.0.

However, adding the all_displays_in_sync check directly to
dce100_validate_bandwidth() (which is shared by DCE 6, 8, and 10) and
copying context->bw_ctx.bw.dce.all_displays_in_sync to
pp_display_cfg->all_displays_in_sync in
dce_pplib_apply_display_requirements() works. Is this solution preferable?

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -320,6 +320,9 @@ static void dce_pplib_apply_display_requirements(
 {
 	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
 
+	pp_display_cfg->all_displays_in_sync =
+		context->bw_ctx.bw.dce.all_displays_in_sync;
+
 	dce110_fill_display_configs(context, pp_display_cfg);
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -692,6 +692,14 @@ enum dc_status dce100_validate_bandwidth(
 		/* TODO implement when needed but for now hardcode max value*/
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
+		context->bw_ctx.bw.dce.all_displays_in_sync = context->stream_count > 1;
+		for (i = 1; i < context->stream_count; i++) {
+			if (!resource_are_streams_timing_synchronizable(
+				    context->streams[0], context->streams[i])) {
+				context->bw_ctx.bw.dce.all_displays_in_sync = false;
+				break;
+			}
+		}
 	} else {
 		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
 		 * the DP clock, and shouldn't be turned off. Just select the display
@@ -703,6 +711,7 @@ enum dc_status dce100_validate_bandwidth(
 			context->bw_ctx.bw.dce.dispclk_khz = 0;
 
 		context->bw_ctx.bw.dce.yclk_khz = 0;
+		context->bw_ctx.bw.dce.all_displays_in_sync = false;
 	}
 
 	return DC_OK;

Richard

>>
>> Richard
>>
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>>>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>>>> @@ -31,6 +31,7 @@
>>>>  #include "dmcu.h"
>>>>  #include "core_types.h"
>>>>  #include "dal_asic_id.h"
>>>> +#include "resource.h"
>>>>
>>>>  /*
>>>>   * Currently the register shifts and masks in this file are used for dce100 and dce80
>>>> @@ -319,8 +320,17 @@ static void dce_pplib_apply_display_requirements(
>>>>         struct dc_state *context)
>>>>  {
>>>>         struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
>>>> +       int j;
>>>>
>>>>         dce110_fill_display_configs(context, pp_display_cfg);
>>>> +       pp_display_cfg->all_displays_in_sync = pp_display_cfg->display_count > 1;
>>>> +       for (j = 1; j < context->stream_count; j++) {
>>>> +               if (!resource_are_streams_timing_synchronizable(
>>>> +                           context->streams[0], context->streams[j])) {
>>>> +                       pp_display_cfg->all_displays_in_sync = false;
>>>> +                       break;
>>>> +               }
>>>> +       }
>>>>
>>>>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
>>>>                 dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
>>>>
>>>> Richard
>>>>
>>>>>
>>>>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
>>>>>>  1 file changed, 10 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> index 74cd88d8d580..b4531383437e 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> @@ -4777,6 +4777,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
>>>>>>         dc_exit_ips_for_hw_access(dm->dc);
>>>>>>         WARN_ON(!dc_commit_streams(dm->dc, &params));
>>>>>>
>>>>>> +       if (params.stream_count > 1 &&
>>>>>> +           dm->dc->current_state->stream_status[0].timing_sync_info.group_size ==
>>>>>> +           params.stream_count) {
>>>>>> +               struct dm_pp_display_configuration *pp_cfg =
>>>>>> +                       &dm->dc->current_state->pp_display_cfg;
>>>>>> +
>>>>>> +               pp_cfg->all_displays_in_sync = true;
>>>>>> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
>>>>>> +       }
>>>>>> +
>>>>>>         bool frl_stream_found = false;
>>>>>>
>>>>>>         for (i = 0; i < params.stream_count; i++) {
>>>>>> --
>>>>>> 2.55.0
>>>>
>>

