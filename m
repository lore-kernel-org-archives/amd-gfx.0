Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E402C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 16:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C27D010E4D3;
	Fri, 12 Apr 2024 16:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Gk4F8C7b";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4665B10E4D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 16:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RH5lqOcP3clYoN5Xy4PKklxT/QsGlzc0FCwIdTd74OI=; b=Gk4F8C7bj3PrV+PDe2xOPTnwQi
 i2DLmGZpVgQeFmt7Z31ML85IDVn6X59KWZx7KpDSf27eJtS6QPp6WD4TktaJOOge+ANc8UnSNMb7r
 UNY5dkh9I3z4ZsBBr2zaG74/xTktSRqd1xusCEqTFlR+b1yNcgb/IwmAlQ6erJk1zJFYYsDfNzRDD
 m9O++C6h3KLFaLa+DrMKnggWFjuDPLuhMzP8NVeohnBsDdIiPo2pwCAMPxzvVsolsYu3AI2ALjpn5
 fTZqgx5+NzC8rUoc4A4dZexp10bAtBwhjSVstvP/LK3e8hdJAwaoAk1CtZg0r2pUfOdsZUvy2fn29
 iVFixVvg==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rvJjz-003x2q-Hh; Fri, 12 Apr 2024 18:27:04 +0200
Date: Fri, 12 Apr 2024 13:26:03 -0300
From: Melissa Wen <mwen@igalia.com>
To: Joshua Ashton <joshua@froggi.es>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Xaver Hugl <xaver.hugl@gmail.com>, Ethan Lee <flibitijibibo@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Enable ogam_ram for dcn32+dcn35+dcn351
Message-ID: <ql7dvtd4pa7plrk5e6xdtfs55wfkrsx5nv2bfxtnzfl5l7knek@kbcd2je5o7a2>
References: <20240410221336.34627-1-joshua@froggi.es>
 <nhr535ncnm6n5btn7o6kkmblppnywvvnni6i4y3v6fmiazbopz@v5wo7kqarrlv>
 <d607ffb8-aca6-44c8-ab0f-e7bf8d3bed0d@froggi.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d607ffb8-aca6-44c8-ab0f-e7bf8d3bed0d@froggi.es>
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

On 04/12, Joshua Ashton wrote:
> 
> 
> On 4/11/24 3:26 PM, Melissa Wen wrote:
> > On 04/10, Joshua Ashton wrote:
> > > The comment here states "no OGAM in DPP since DCN1", yet that is not
> > > true.
> > > 
> > > Testing on an RX 7900XTX (dcn32), it actually does exist in hardware and
> > > works fine.
> > > My best guess is the comment is confused with OGAM ROM for DPP, rather
> > > than OGAM RAM.
> > > 
> > > I did not test dcn35/351 as I do not have that hardware, but I assume
> > > the same follows there given the seemingly erroneous comment.
> > > Someone at AMD should check that before merging this commit.
> > 
> > hmm... I don't have any of these hw versions, but AFAIU if there is
> > ogam/blend lut block in dcn32, the helper implementation for programming
> > it properly (i.e. dpp_program_blnd_lut) is also missing here:
> > - https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c#L125
> > right? So, it's good if AMD people can check it too.
> > 
> > Melissa
> 
> Hmm, yes. But, see dcn32_set_mcm_luts, that seems to handle per-plane blend
> + shaper + 3D LUT state which is equivalent to what existed before?

oh, cool! nice finding. blnd_lut is set on plane state, but programmed
on MPC now.

But I see the color pipeline changed in many stages from this version:
- shaper + 3dlut before **or** after blending, but not before **and** after?
- where post-blending gamut_remap_matrix is located now in this
  pipeline with mpcc postblend_1dlut and shaper+3dlut with mutable
  position?
  I guess something like:
  - [shaper -> 3dlut -> blnd_lut] -> ctm -> regamma ??
> 
> Therefore, I think I am actually wrong with enabling the ogam_ram in DPP cap
> here, and the right solution is to change the check for exposing the
> property to account for these LUTs being available per-plane with mcm.
> 
> (what is mcm btw...? lots of acronyms and stuff moving around in hw hehe)

yes, shaper, 3dlut, blend_lut don't seem DPP caps anymore. MCM looks
like a component of MPC, so I think we need new mpc.color caps to
describe them properly (?)

I also didn't find in the Linux/AMD glossary or code comment that
describe what MCM is...

> 
> What's a good way for us to check for that? Seems like the caps don't help
> much there. We could check for the literal function ptr I guess...?
> 
> What are your thoughts, Harry and Melissa?

yeah, AFAIK color caps values are manually set and may contain
misleading information. I'm unsure that using function ptr would solve
the issue of having undocumented caps introduced to the color pipeline,
such as MCM, but your suggestion seems more reliable.

Anyway, the timing where the color pipeline was merged didn't help, but
if new caps and functions are not documented and the DM handles are not
updated accordingly, we will have the same issue in the future. 
For example, I see two new ptrs were introduced and implemented here:
- https://gitlab.freedesktop.org/agd5f/linux/-/commit/a820190204aef
- https://gitlab.freedesktop.org/agd5f/linux/-/commit/90f33674a0756
and we would need to update the DM color mgmt anyway to check these
new/unknown functions.

Seems okay if we check program_1dlut instead of ogam_ram caps, but what
should we do for dpp/mpc shaper+3d lut in set_mcm_luts? I mean, should
we enable plane or CRTC shaper+3dlut on DM? x_X

Anyway, thanks for all these findings!

I would like to hear more from AMD too.

Melissa

> 
> - Joshie 🐸✨
> 
> > 
> > > 
> > > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > > 
> > > Cc: Harry Wentland <harry.wentland@amd.com>
> > > Cc: Xaver Hugl <xaver.hugl@gmail.com>
> > > Cc: Melissa Wen <mwen@igalia.com>
> > > Cc: Ethan Lee <flibitijibibo@gmail.com>
> > > ---
> > >   drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
> > >   drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
> > >   .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
> > >   3 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> > > index 9aa39bd25be9..94f5d2b5aadf 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> > > @@ -2182,7 +2182,7 @@ static bool dcn32_resource_construct(
> > >   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
> > >   	dc->caps.color.dpp.hw_3d_lut = 1;
> > > -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
> > > +	dc->caps.color.dpp.ogam_ram = 1;
> > >   	// no OGAM ROM on DCN2 and later ASICs
> > >   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
> > >   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
> > > diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> > > index 25ac450944e7..708d63cc3f7f 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> > > @@ -1861,7 +1861,7 @@ static bool dcn35_resource_construct(
> > >   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
> > >   	dc->caps.color.dpp.hw_3d_lut = 1;
> > > -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
> > > +	dc->caps.color.dpp.ogam_ram = 1;
> > >   	// no OGAM ROM on DCN301
> > >   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
> > >   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
> > > diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> > > index 8a57adb27264..053e8ec6d1ef 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> > > @@ -1841,7 +1841,7 @@ static bool dcn351_resource_construct(
> > >   	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
> > >   	dc->caps.color.dpp.hw_3d_lut = 1;
> > > -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
> > > +	dc->caps.color.dpp.ogam_ram = 1;
> > >   	// no OGAM ROM on DCN301
> > >   	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
> > >   	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
> > > -- 
> > > 2.44.0
> > > 
