Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A4FC2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 17:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAA92072E
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 17:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAA92072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettle.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 580576E13A;
	Mon, 28 Sep 2020 17:40:34 +0000 (UTC)
X-Greylist: delayed 306 seconds by postgrey-1.36 at gabe;
 Mon, 28 Sep 2020 17:40:31 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC46A6E13A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 17:40:31 +0000 (UTC)
Received: from bender.cb.ettle ([143.159.226.37]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1Mzhax-1kacBa0LpZ-00vej9; Mon, 28 Sep 2020 19:35:19 +0200
Message-ID: <ad59a8c59d52c40a89b7b4fd032df043e0747f27.camel@ettle.org.uk>
Subject: Re: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
From: James Ettle <james@ettle.org.uk>
To: Harry Wentland <harry.wentland@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Date: Mon, 28 Sep 2020 18:35:17 +0100
In-Reply-To: <967f82b1-cf5b-473b-c9b3-d9f9df588cc7@amd.com>
References: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
 <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
 <286845a3-4903-c169-aa36-1eb986492ea3@ettle.org.uk>
 <CADnq5_O8Wzddr3LryTuQ5Jqc5yt51wqkxv6zbSbr0_RBSQCA4g@mail.gmail.com>
 <967f82b1-cf5b-473b-c9b3-d9f9df588cc7@amd.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:CYdc/NaxsbIAE5MkKFl5Gb3yIZUbdzBErKwVgDpmHLdYafavDDh
 qVbQLb3+rQaXn0gzeaR9bSRHsUIe38xgIyYibUhIXEAF5o8a1pTh1yopL8m5Ra5Qr9RrxNN
 88KqZoTCVeU63iPzbAM0CJOVF1OtDvxG8Ir6jCC+dEXiD/jbpyJw8z+UA3rSmEPhsfaqa11
 4D9VVV52trgGMA8JXknRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EkeyB0rtZd8=:wUGxbVhu3P5VAyDkoLw7zH
 lTdN15H9Zd3eCce6Qo3UZ8RRTbNAoBaChws8l7ibcNzRU3Nc0mvZSugAECgiR7XiCglV02+/y
 L3jBBaUPRc3xxVr0TkpDyOSNz5pZB1TiuHtoqTYXubdeTCxAY5RzT0N1VBBxofsDU0IYOiz/K
 PPeTU+KFBWr1MSifuPLY4nvcdJbDeeK55ZTqgetCBVTXcIofExaYHw6GXtNI0Lzo+CsE9d07g
 54qHAQUzMV1wAd7I4mkuismKfbfEFibzAnU8H7/1XhGjSpzCRU1fk+z3GRv65C9kqfDaFP5fj
 xrpH3Sjyfghpoc3aUYMrUlqR79hN8mJ3yOtXKIAV+R+iplYXuZLOFRR+VDVv5tYZB/QoX2i99
 0v6EERCbcGdrltSIo8x4Ka+1Ju9SYqBRMM2DMkF0MdyMsn6PfynomEtV9aPF9lnP5sf4ML2PT
 fDVnVbpAKgpdAq76ytjX+Xtj99XEyChls5rmEoSpt8w0L5cpG8Hxi2fUfP3URp1JcMhDVD2yB
 0LjoTaN4HW1senCBbNSI9L+3dxuD0Hk0dYdAEYT2V++ThkD5Z1hM6UexGmwc5UYlsEdgRJHDy
 NrRJEdBEWKs1yUUeG/OqzVBDeS/CZ/eimd811C/y6TYL8Kx0ArPK7grHBvYBWQNuHgaueny4P
 ui49orM/XBvNkBZKqRQT+JrXPSg5saxpucmpLON1puo7ivRS4UTsC1TqsX8NOSR/kQij5nqh8
 xpWz1WoY/+8SSJO6kL1UIuX1msP8UHLK34j4I6To9dMU7LKHqz6mXEtPE3hZYNgkXFq+HxTVO
 bbPqsbD0mNLpHsp7X4FRoHbozEaigq9UxA63uCQ/HF1/KEt8bSPsiqBCWosJuV2emd0DqzX
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <hwentlan@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 2020-09-28 at 10:26 -0400, Harry Wentland wrote:
> 
> On 2020-09-25 5:18 p.m., Alex Deucher wrote:
> > On Tue, Sep 22, 2020 at 4:51 PM James Ettle <james@ettle.org.uk>
> > wrote:
> > > On 22/09/2020 21:33, Alex Deucher wrote:
> > > > > +/**
> > > > > + * DOC: pixel_encoding (string)
> > > > > + * Specify the initial pixel encoding used by a connector.
> > > > > + */
> > > > > +static char amdgpu_pixel_encoding[MAX_INPUT];
> > > > > +MODULE_PARM_DESC(pixel_encoding, "Override pixel encoding");
> > > > > +module_param_string(pixel_encoding, amdgpu_pixel_encoding,
> > > > > sizeof(amdgpu_pixel_encoding), 0444);
> > > > 
> > > > You can drop this part.  We don't need a module parameter if we
> > > > have a
> > > > kms property.
> > > > 
> > > > Alex
> > > 
> > > OK, but is there then an alternative means of setting the pixel
> > > encoding to be used immediately on boot or when amdgpu loads?
> > > Also are there user tools other than xrandr to change a KMS
> > > property, for Wayland and console users?
> > 
> > You can force some things on the kernel command line, but I don't
> > recall whether that includes kms properties or not.  As for ways to
> > change properties, the KMS API provides a way.  those are exposed
> > via
> > randr when using X.  When using wayland compositors, it depends on
> > the
> > compositor.
> > 
> 
> I'm not aware of a way to specify KMS properties through the kernel
> command line. I don't think it's possible.
> 
> For atomic userspace the userspace wants to be the authority on the
> KMS
> config. I'm not sure there's a way to set these properties with
> Wayland
> unless a Wayland compositor plumbs them through.
> 
> Can you summarize on a higher level what problem you're trying to
> solve?
> I wonder if it'd be better solved with properties on a DRM level that
> all drivers can follow if desired.
> 
> Harry
> 
> > Alex
> > 

The problem this is trying to solve is that the pixel format defaults
to YCbCr444 on HDMI if the monitor claims to support it, in preference
to RGB. This behaviour is hard-coded (see the
comment fill_stream_properties_from_drm_display_mode) and there is no
way for the user to change the pixel format to RGB, other than hacking
the EDID to disable the YCbCr flags.

Using YCbCr (rather than RGB) has been reported to cause suboptimal
results for some users: colour quality issues or perceptible conversion
latency at the monitor end -- see:

https://gitlab.freedesktop.org/drm/amd/-/issues/476

for the full details.

This patch tries to solve this issue by adding a DRM property so Xorg
users can change the pixel encoding on-the-fly, and a module parameter
to set the default encoding at amdgpu's init for all users.

[I suppose an alternative here is to look into the rationale of
defaulting to YCbCr444 on HDMI when the monitor also supports RGB. For
reference although on my kit I see no detrimental effects from YCbCr,
I'm using onboard graphics with a motherboard that has just D-sub and
HDMI -- so DisplayPort's not an option.]

-James


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
