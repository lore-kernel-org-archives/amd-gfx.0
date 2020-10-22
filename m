Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31423C388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 16:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78CA24630
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 16:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2RRYAWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78CA24630
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1106E202;
	Thu, 22 Oct 2020 16:55:41 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 154CA6E202
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 16:55:40 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id k18so3049723wmj.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=94al3kBVlJmPlQMgiIKZoZouVaonQGcYk01tGfpUIL0=;
 b=U2RRYAWHbUem4gkdAoEiAjTaNLTUXc1YUKVbkv4jZHMpWuBt11IGazf6gknEZSDhxX
 eyazK8fylNsWU/RxXufEsxo2YxgOx0R/PpttY8Z/SAlSfqraHrkcZkAP/i39WHbBi/BO
 pNwWWEXaSxP8ZClE5CgiTVLdPlgLunBnMiaN4n1LmuRoTe+1+TMZLsSvZ/wgWV//4xXF
 4CZBb+xAW+/9bjcX0rubbTVpqdSm92UfzZrH3xWy/6sToJ/ladtJKiUA1W4IvkrazmwI
 vnXwbH35/R6re3ZklrzzUSGZHMFETzvHHseE/iCk6sLmPJqghwQLKBy4i5MT7bNW5fET
 B6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=94al3kBVlJmPlQMgiIKZoZouVaonQGcYk01tGfpUIL0=;
 b=sc/X6ksiBM3ck7ZM4QebfNIFiX7zQRWbcOwgPn9bPO+v3PbsFPBeaKvWMb6PCiurqD
 15psln/b8fCiHb9GIz7fPUjyWeJsOw/QbdbL6Vthw9E5T59cBGQ+gKvg2kVkRwYcXb0B
 E3kEAhVx108PtXZy1M4zjRvQaNW6VOsRf2uRotWsGthWHAT/Wtz1PdwlTYSZ1vL3sJO8
 b+H72GZUBwmet7zFyVzBRmn3tM26ZVpdHsj6bIzgb+3gQolUd+WuMZpwByuDtkeLFMgg
 jgnRYTLTjNoikSS3fUzmGGo4t8WWQTQtCaZI66p0NR6rbXvNTvlTWzammwGpcW7VSUsQ
 1VTg==
X-Gm-Message-State: AOAM533240V3bXB/SdmFtZgo/G8XxyzfbEK3YJv6wlhGVA638xAVB3lb
 Ja5QoeUxy2zq2JpCgE1OFEHWUf+i6qu+sP1EgUo=
X-Google-Smtp-Source: ABdhPJwXV24PYXeo1q7DVpqiY4EYyktRsJm0q1BxX5XZLedbPgci7TT9oielGbHEpXxgwAFW4t2pjxS/hhS8C2+NWP4=
X-Received: by 2002:a1c:a1c2:: with SMTP id k185mr3435855wme.39.1603385731048; 
 Thu, 22 Oct 2020 09:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2020 12:55:19 -0400
Message-ID: <CADnq5_OQLBuQhfH31Thw_gCBo5H_CgcaPGsG2RDmy=_t2jhOLw@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] amd/display: Add GFX9+ modifier support.
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
Cc: Marek Olsak <maraeo@gmail.com>, "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Wentland, Harry" <harry.wentland@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I don't claim to be an expert with modifiers, but the changes all look
logical to me.  With VGH added to patch 10, this series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


On Wed, Oct 21, 2020 at 7:31 PM Bas Nieuwenhuizen
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
