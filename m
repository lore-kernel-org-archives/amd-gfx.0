Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C29C00A89
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 16:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F47920725
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 16:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfCrJEKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F47920725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6553B6E9D2;
	Fri, 30 Oct 2020 16:47:45 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586206E9D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 16:47:44 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id s9so7170520wro.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2uEC3sN058VFPUoOiJ1kcrpv5pyB0GTS4w9W/u7mDU4=;
 b=mfCrJEKmze26EGhzqoDmRl8A09widY/XvQBM0VOCczkEVG8dYrjH9m6t5XxGJtV6vt
 Ri9JGYbcesZmyyRkHStSHMI5aKU/DkKq/P0iVSDBhgt2CTzMR5NIq6arlzL5al7WLD++
 10qysSx1NjSKaebRvRXLNn8wdezBlFL19Ec8BpG8gsewANpa8KtsTtXot4Z9qiWJG3xD
 HurFTwNvfMqNBoqcvfZW1V8jTWhgIoY0IuNC7Nieh5CjTLT+O1eeXlqrlJP55JGQjg+0
 kMyu7sEWtW7jwuLRYbqv5152x4+jVL6r+ESOwpUH+XJDOR8BTfZORMGiso5XRLWTftgZ
 hn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2uEC3sN058VFPUoOiJ1kcrpv5pyB0GTS4w9W/u7mDU4=;
 b=UQSJYDedRmy2A4f5Dc7x482V0AbHGeyPFdMynjlT8PJBJy3H5Xk+QUNsFFvo3Cns74
 929PXl8fqzmz0ewxHZilUOvZZlfGAxVEJhlVCyfIsCTXicOZUq5u2H6mrHjkO4M17LiJ
 2yg2iyrtEHqfYRIVLnjVAvhKMSALZwy9KavI2KkKIw+L3yoLRSpq3vxs5ceRPohEC7kW
 +dP6NJXf7vd2zO2tzsUQL1+fIDIBIXkQ2ANHfmIsBtvoFBJCSZ4IXWftGrXP5P2IULZR
 PdXZPVH8RO6XR8FnFzDmLdk5SiMpMrFHrN2hdVba6YAu2nfvc+6VtrwzTZMpMkZKBg10
 ncOg==
X-Gm-Message-State: AOAM532d4oDCOnPNlikcLLBnPsHK6YBibMYqOBHP735X9H3Z/c8zfPs+
 HjmgaCdSmOq+lYlsZdnkYRPqNga2GceXDhXUzD6QDgsc
X-Google-Smtp-Source: ABdhPJyJc7qsNfJ0Kk8JHIJqYbmLVQ1vZbVigy6+76be6awcRfoPF2MUV94rNKnZqaaQGJaE9/pCctVE6Bv6YbD7LUU=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr4285406wrn.362.1604076462978; 
 Fri, 30 Oct 2020 09:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Oct 2020 12:47:31 -0400
Message-ID: <CADnq5_Nig9DEf=OzV8iwns0=0p1p3zT+8N263+LCr+xJ8LXWoQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] amd/display: Add GFX9+ modifier support.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks for all of your hard work on this!

Alex

On Wed, Oct 28, 2020 at 7:52 PM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> This adds modifier support to the amdgpu kernel drivers for GFX9 and
> later GPUs. It has been tested on
>
> - VEGA10, RAVEN, NAVI14
> - weston, sway, X with xf86-video-amdgpu (i.e. legacy path still works)
>
> and includes some basic testing of the layout code.
>
> The main goal is to keep it somewhat simple and regression free, so
> on the display side this series only exposes what the current GPU
> can render to. While we could expose more I think that is more
> suitable for follow-up work as the benefit would be minimal and
> there are some more design discussion there to discuss that are
> orthogonal from the initial implementation.
>
> Similarly this series only exposes 32-bpp displayable DCC in the cases
> that radeonsi would use it and any extra capabilities here should be
> future work.
>
> I believe these are by far the most complicated modifiers we've seen
> up till now, mostly related to
>
> - GPU identification for cases where it matters wrt tiling.
> - Every generation having tiling layout changes
> - Compression settings.
>
> I believe the complexity is necessary as every layout should be different
> and all layouts should be the best in some situation (though not all
> combinations of GPU parameters will actually have an existing GPU).
>
> That said, on the render side the number of modifiers actually listed for
> a given GPU is ~10, and in the current implementation that is the same
> for the display side. (we could expose more actually differing layouts
> on the display side for cross-GPU compatibility, but I consider that
> out of scope for this initial work).
>
> This series can be found on
> https://github.com/BNieuwenhuizen/linux/tree/modifiers
>
> An userspace implementation in radeonsi can be found on
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/6176
>
> which has been reviewed and is ready for submission once these kernel
> patches land.
>
> v2:
>
> Per suggestion from Daniel Vetter I added logic to get the tiling_flags at
> addfb2 time and convert them into modifiers for GFX9+.  Furthermore, the DCC
> constant econding modifers only get exposed on RAVEN2 and newer.
>
> v3:
>
> Fixed some typos, rebased and CCing more people to actually get a review.
>
> v4:
>
> Changed an initialization from {0} to memset, fixed a missing switch case
> in the modifier enumeration and added review tags.
>
> Bas Nieuwenhuizen (11):
>   drm/amd/display: Do not silently accept DCC for multiplane formats.
>   drm/amd: Init modifier field of helper fb.
>   drm/amd/display: Honor the offset for plane 0.
>   drm/fourcc:  Add AMD DRM modifiers.
>   drm/amd/display: Store tiling_flags in the framebuffer.
>   drm/amd/display: Convert tiling_flags to modifiers.
>   drm/amd/display: Refactor surface tiling setup.
>   drm/amd/display: Set DC options from modifiers.
>   drm/amd/display: Add formats for DCC with 2/3 planes.
>   drm/amd/display: Expose modifiers.
>   drm/amd/display: Clean up GFX9 tiling_flags path.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 169 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   3 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 754 ++++++++++++++----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 -
>  include/uapi/drm/drm_fourcc.h                 | 115 +++
>  6 files changed, 880 insertions(+), 165 deletions(-)
>
> --
> 2.28.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
