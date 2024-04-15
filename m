Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C3EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 15:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6F810EDC8;
	Mon, 15 Apr 2024 15:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PgTcf4vF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBA710EDC8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xaVI4nnyhMR/IR990rT4h/wfXSiILD07NB0LUwD4Z+E=; b=PgTcf4vFiroqT3mrwsbZd6Uh7i
 P0yCEbNndvdh96TtSmwivHTut3HgPNiWpHya5uA/pxs8mB8GNbf1pPjCw2PiMag9o0NhFw5hJcIdH
 Qrgakn7fDjEMs+XWF3Kgzl4TUTd/GN9M8ej03sO8ZSf+NxnWv6raL5Xb8Degqf5rhDqLlqDc1oy3o
 6vAOc5sVOLETCc0ij/t9uWi7jMx9JgmZYRnQjEE3y9jszSj95j0l7VJwRjRH9pL0AY1jK7IQdMKkb
 18s+pUmYEhwD1zB2TmnZiBJb4phdVwXWuaRL8CbvytxIPahtBQnrZUVdkIgcbr8x57ZMmGKzkRzCX
 HSUW3MuQ==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rwOFn-004oXw-RP; Mon, 15 Apr 2024 17:28:20 +0200
Date: Mon, 15 Apr 2024 12:27:40 -0300
From: Melissa Wen <mwen@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org, 
 Xaver Hugl <xaver.hugl@gmail.com>, Ethan Lee <flibitijibibo@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Enable ogam_ram for dcn32+dcn35+dcn351
Message-ID: <o23hy6szj4ikxixrizjth7w6cdg7z5r74c77gi6lucpqhba6sr@xurztpq6uiml>
References: <20240410221336.34627-1-joshua@froggi.es>
 <nhr535ncnm6n5btn7o6kkmblppnywvvnni6i4y3v6fmiazbopz@v5wo7kqarrlv>
 <d607ffb8-aca6-44c8-ab0f-e7bf8d3bed0d@froggi.es>
 <ql7dvtd4pa7plrk5e6xdtfs55wfkrsx5nv2bfxtnzfl5l7knek@kbcd2je5o7a2>
 <0d87bcf4-7ce5-407f-bba0-b6ba45ac36f9@amd.com>
 <c8635e5a-111d-4991-a89b-a40c9f64e376@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8635e5a-111d-4991-a89b-a40c9f64e376@amd.com>
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

On 04/12, Harry Wentland wrote:
> 
> 
> On 2024-04-12 16:22, Harry Wentland wrote:
> > 
> > 
> > On 2024-04-12 12:26, Melissa Wen wrote:
> >> On 04/12, Joshua Ashton wrote:
> >>>
> >>>
> >>> On 4/11/24 3:26 PM, Melissa Wen wrote:
> >>>> On 04/10, Joshua Ashton wrote:
> >>>>> The comment here states "no OGAM in DPP since DCN1", yet that is not
> >>>>> true.
> >>>>>
> >>>>> Testing on an RX 7900XTX (dcn32), it actually does exist in hardware and
> >>>>> works fine.
> >>>>> My best guess is the comment is confused with OGAM ROM for DPP, rather
> >>>>> than OGAM RAM.
> >>>>>
> >>>>> I did not test dcn35/351 as I do not have that hardware, but I assume
> >>>>> the same follows there given the seemingly erroneous comment.
> >>>>> Someone at AMD should check that before merging this commit.
> >>>>
> >>>> hmm... I don't have any of these hw versions, but AFAIU if there is
> >>>> ogam/blend lut block in dcn32, the helper implementation for programming
> >>>> it properly (i.e. dpp_program_blnd_lut) is also missing here:
> >>>> - https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c#L125
> >>>> right? So, it's good if AMD people can check it too.
> >>>>
> >>>> Melissa
> >>>
> >>> Hmm, yes. But, see dcn32_set_mcm_luts, that seems to handle per-plane blend
> >>> + shaper + 3D LUT state which is equivalent to what existed before?
> >>
> >> oh, cool! nice finding. blnd_lut is set on plane state, but programmed
> >> on MPC now.
> >>
> >> But I see the color pipeline changed in many stages from this version:
> >> - shaper + 3dlut before **or** after blending, but not before **and** after?
> >> - where post-blending gamut_remap_matrix is located now in this
> >>   pipeline with mpcc postblend_1dlut and shaper+3dlut with mutable
> >>   position?
> >>   I guess something like:
> >>   - [shaper -> 3dlut -> blnd_lut] -> ctm -> regamma ??
> > 
> > [1dlut -> 3dlut -> 1dlut] is now a movable block, called Movable CM
> > (color management), or MCM for short. It can occur before blending or
> > after. Because of that it moved to MPC (multi-plane combiner).
> > 
> > If it's positioned for pre-blending it looks like this:
> > 
> > DPP -> MCM -> BLND -> Blending -> Gamut Remap -> Out Gam -> OPP -> ...
> > 
> > If it's positioned for post-blending it looks like this:
> > 
> > DPP -> BLND -> Blending -> MCM -> Gamut Remap -> Out Gam -> OPP
> > 
> > This is the case since DCN 3.2.
> > 
> > Because of that you don't have an ogam_ram in dpp anymore for DCN 3.2
> > and newer.
> > 
> >>>
> >>> Therefore, I think I am actually wrong with enabling the ogam_ram in DPP cap
> >>> here, and the right solution is to change the check for exposing the
> >>> property to account for these LUTs being available per-plane with mcm.
> >>>
> >>> (what is mcm btw...? lots of acronyms and stuff moving around in hw hehe)
> >>
> >> yes, shaper, 3dlut, blend_lut don't seem DPP caps anymore. MCM looks
> >> like a component of MPC, so I think we need new mpc.color caps to
> >> describe them properly (?)
> >>
> >> I also didn't find in the Linux/AMD glossary or code comment that
> >> describe what MCM is...
> >>
> >>>
> >>> What's a good way for us to check for that? Seems like the caps don't help
> >>> much there. We could check for the literal function ptr I guess...?
> >>>
> >>> What are your thoughts, Harry and Melissa?
> >>
> > 
> > I wonder if it makes sense to add an mcm cap to mpc_color_caps. Will need to
> > chat with some people about that.
> > 
> 
> I dug through the code a bit and talked with our resident expert. It looks
> like all the programming for in_shaper_func, lut_3d_func, and blend_tf should
> still work and assume a fixed pre-blending mcm, which is what we want.

Hi Harry,

Thank you for explaning the latest changes in the color pipeline.
Since MCM is fixed pre-blending in the current dcn32 driver:

1. I understand that the implementation for post-blending shaper/3dlut
isn't available in the current dcn32 driver, right?

2. Does the dcn32 hardware itself support the configuration of both pre-
and post-blending shaper/3dlut at the same time? Or, for example, dcn32
will advertise two color pipelines: one with pre-blending 3dlut and no
post-blending, and another without pre-blending and only post-blending
3dlut? 

Melissa

> 
> Caps don't really reflect MCM very well yet. We could either add an mcm
> flag to mpc_color_caps or simply check that DCN is 3.2 or newer:
> 	amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 2, 0)
> 
> Harry
> 
> > Harry
> > 
> >> yeah, AFAIK color caps values are manually set and may contain
> >> misleading information. I'm unsure that using function ptr would solve
> >> the issue of having undocumented caps introduced to the color pipeline,
> >> such as MCM, but your suggestion seems more reliable.
> >>
> >> Anyway, the timing where the color pipeline was merged didn't help, but
> >> if new caps and functions are not documented and the DM handles are not
> >> updated accordingly, we will have the same issue in the future. 
> >> For example, I see two new ptrs were introduced and implemented here:
> >> - https://gitlab.freedesktop.org/agd5f/linux/-/commit/a820190204aef
> >> - https://gitlab.freedesktop.org/agd5f/linux/-/commit/90f33674a0756
> >> and we would need to update the DM color mgmt anyway to check these
> >> new/unknown functions.
> >>
> >> Seems okay if we check program_1dlut instead of ogam_ram caps, but what
> >> should we do for dpp/mpc shaper+3d lut in set_mcm_luts? I mean, should
> >> we enable plane or CRTC shaper+3dlut on DM? x_X
> >>
> >> Anyway, thanks for all these findings!
> >>
> >> I would like to hear more from AMD too.
> >>
> >> Melissa
> >>
> >>>
> >>> - Joshie 🐸✨
> >>>
> >>>>
> >>>>>
> >>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> >>>>>
> >>>>> Cc: Harry Wentland <harry.wentland@amd.com>
> >>>>> Cc: Xaver Hugl <xaver.hugl@gmail.com>
> >>>>> Cc: Melissa Wen <mwen@igalia.com>
> >>>>> Cc: Ethan Lee <flibitijibibo@gmail.com>
> >>>>> ---
> >>>>>   drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
> >>>>>   drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
> >>>>>   .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
> >>>>>   3 files changed, 3 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> >>>>> index 9aa39bd25be9..94f5d2b5aadf 100644
> >>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> >>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> >>>>> @@ -2182,7 +2182,7 @@ static bool dcn32_resource_construct(
> >>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
> >>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
> >>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
> >>>>> +	dc->caps.color.dpp.ogam_ram = 1;
> >>>>>   	// no OGAM ROM on DCN2 and later ASICs
> >>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
> >>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
> >>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> >>>>> index 25ac450944e7..708d63cc3f7f 100644
> >>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> >>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> >>>>> @@ -1861,7 +1861,7 @@ static bool dcn35_resource_construct(
> >>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
> >>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
> >>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
> >>>>> +	dc->caps.color.dpp.ogam_ram = 1;
> >>>>>   	// no OGAM ROM on DCN301
> >>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
> >>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
> >>>>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> >>>>> index 8a57adb27264..053e8ec6d1ef 100644
> >>>>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> >>>>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> >>>>> @@ -1841,7 +1841,7 @@ static bool dcn351_resource_construct(
> >>>>>   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
> >>>>>   	dc->caps.color.dpp.hw_3d_lut = 1;
> >>>>> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
> >>>>> +	dc->caps.color.dpp.ogam_ram = 1;
> >>>>>   	// no OGAM ROM on DCN301
> >>>>>   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
> >>>>>   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
> >>>>> -- 
> >>>>> 2.44.0
> >>>>>
> 
