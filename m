Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C84C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 08:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875D1208C7
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 08:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="V53ZHKSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875D1208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D2A6E26F;
	Mon,  7 Sep 2020 08:27:50 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789496E26F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 08:27:49 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id y15so689209wmi.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2020 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+0Ns7FpW1fWrtEfS8uAJ2BaTCWzfAVO2EMwAD018HrU=;
 b=V53ZHKSm3ef2svG2FQciY5Jfg+d53HQSAQ4YL3Xf4NokU0/N1MvgBzkO5Vs4p3H6tc
 PBiTvkjTqhRStDctRS4vzor+b6c1Z5AFzONM8C8QYfBymZfK6o4X2mNlnBbM3upefyU9
 Ym8vRQr8bYkSO9oN0GNvJvt0+BcomTUznm0jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+0Ns7FpW1fWrtEfS8uAJ2BaTCWzfAVO2EMwAD018HrU=;
 b=iCXcvd5PmxyaJsh/VbIR+g2SBtQfJ8r0NKOB5LnVKpaTemmFGiPGIgNGXAkUqxl+Pu
 llq2AZwDyLakawojPTXvKSv/RbiHdc+BTt/SVbswDUvpSe2TrmYplyutwa4tGhZ6o6f4
 zhgeY4ftduqJTmHtaZ2EWI1qiD1H76eeHFBp5Y7ttcKD5c3+ZODTSBWrYOlx2R7PJWWk
 ZcmeAEvOCckP5Smc9oOBg1Bsg2RHHYSoWa7AcaIlZmL654DfaRFjXgwGDYzzE3nuvk4Q
 avzEo12LfFgyAiSk9Tu2MOoPs2QJeW5mBOel3zfom2cCXSM/9RZ3z97McSnUa96lbBmW
 HJbA==
X-Gm-Message-State: AOAM533uNMiQzP8ySByUTL7xhsoNyp6DvQ2UKdgUBud7Y+b2Q33UTZsu
 4DxK1/7B2LfB6vdbUKnFeTdZiw==
X-Google-Smtp-Source: ABdhPJy548ixNngiNHdRpyX9FZPwJwqsBhJqqfwZE/g1vU8+Bm19bKBLM35yRgnbPrzNLO1zLkbfOg==
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr20473680wmn.78.1599467268141; 
 Mon, 07 Sep 2020 01:27:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id z14sm24828578wrh.14.2020.09.07.01.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 01:27:47 -0700 (PDT)
Date: Mon, 7 Sep 2020 10:27:45 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: Re: [PATCH v2 00/11] amd/display: Add GFX9+ modifier support.
Message-ID: <20200907082745.GR2352366@phenom.ffwll.local>
References: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: amd-gfx@lists.freedesktop.org, maraeo@gmail.com, daniel@fooishbar.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexdeucher@gmail.com,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 04, 2020 at 06:06:58PM +0200, Bas Nieuwenhuizen wrote:
> This adds modifier support to radeonsi.
> It has been tested on
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
> v2:
> 
> Per suggestion from Daniel Vetter I added logic to get the tiling_flags at
> addfb2 time and convert them into modifiers for GFX9+.  Furthermore, the DCC
> constant econding modifers only get exposed on RAVEN2 and newer.

I read through the patches, lgtm.
-Daniel

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

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
