Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D75C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 22:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A693510EDDC;
	Fri, 30 Sep 2022 22:21:07 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 265EF10EDD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 22:21:02 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id c30so7692353edn.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 15:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=6JNco3UAJVToGpvcvUOsNxLD+zLNOvfcoCbyAl5UnqY=;
 b=CqlmfYMPxg4X+ouC9tyJVxk5PNcjPLWqplPQHNuezs76StqzQ/4DHSn3hrjXmpsFOz
 HED/rrITJDFKkxduY/q8V3rsej0aHqd/JGFHwdrppNKX8oa3IZDKHgkDTOaMDclaa+cd
 ZYYJsYc6z1OSzvkN8ZAtSrEv9ibKZmaAgEuQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=6JNco3UAJVToGpvcvUOsNxLD+zLNOvfcoCbyAl5UnqY=;
 b=MpyqsJnTEGAazoVGolyeonE0Q8tp5i8VmCOOhcQJva6SZcw0r9yf20bmun0sMb40kA
 On16amFBL5izPKLUhcz7/f6DPtnJ2Q+mYdsmDBGmDlbXURbfjKpCoVl8IXOnyKD6jJzo
 zNlRJqGYgxOQYxUABK6fHqhdORGS9upPgtJgpVmFIl3cuKIHSFDPI1VBsE9jBMT7oqqE
 1pGDk6dB2o0mmsRJv79dXabQ1Ns9E5awPzcgqNhOjpTwsa43GtDVXeIOE3pEQpcW0s43
 8xSTJgiTbxGHwx/p2Kjq5gNrrUraRCfBXVQvgaLPReLr7A5jeuNL12q4Hs1XP12lOsvG
 7BZw==
X-Gm-Message-State: ACrzQf156CKSpqOj0DDxdhNda+/bdIaxR9lgHLfsZt3XAZVJvzm4sC5b
 ZOrzczousKlBHMSEitR9O3zzLQ==
X-Google-Smtp-Source: AMsMyM4wOc7ortJNRHF5bPY1SmaAaouIm6vjbEimiEeLA1t9yx/2enKxP8i8kdFWW+pp6RblL8Q4Kw==
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id
 es6-20020a056402380600b00450bad88cd5mr9656896edb.305.1664576460717; 
 Fri, 30 Sep 2022 15:21:00 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 17-20020a170906309100b0073d9a0d0cbcsm1769961ejv.72.2022.09.30.15.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Sep 2022 15:21:00 -0700 (PDT)
Date: Sat, 1 Oct 2022 00:20:58 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [pull] amdgpu drm-fixes-6.0
Message-ID: <YzdrymlDHGAeNqv5@phenom.ffwll.local>
References: <20220930210454.542719-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930210454.542719-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
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
Cc: daniel.vetter@ffwll.ch, airlied@gmail.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 30, 2022 at 05:04:54PM -0400, Alex Deucher wrote:
> Hi Dave, Daniel,
> 
> Sorry, some last minute changes to deal with updated firmwares/bioses and
> board revisions containing new IPs added in this cycle.  It required
> pulling in some cleanup patches for the RLC firmware handing, but they
> are only applied to GC 11 in this case.  I figured that would be cleaner
> then a bunch of local fixes that would cause merge conflicts for -next,
> and time was getting short for 6.0. They are only applied to GC 11, so no
> chance of regression on existing asics.
> 
> V2: fixed S-O-Bs.
> 
> The following changes since commit 83ca5fb40e758e0a0257bf4e3a1148dd52c6d0f2:
> 
>   drm/amd/display: Prevent OTG shutdown during PSR SU (2022-09-29 10:07:42 -0400)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.0-2022-09-30-1

Pullled and forwarded.

Cheers, Daniel

> 
> for you to fetch changes up to 0fd85e89b5bf18447e56099a010ee5be5dc9f2b0:
> 
>   drm/amdgpu/gfx11: switch to amdgpu_gfx_rlc_init_microcode (2022-09-30 16:59:06 -0400)
> 
> ----------------------------------------------------------------
> amd-drm-fixes-6.0-2022-09-30-1:
> 
> amdgpu:
> - VCN 4.x fixes
> - RLC fixes for GC 11.x
> 
> ----------------------------------------------------------------
> Hawking Zhang (8):
>       drm/amdgpu: save rlcv/rlcp ucode version in amdgpu_gfx
>       drm/amdgpu: add helper to init rlc fw in header v2_0
>       drm/amdgpu: add helper to init rlc fw in header v2_1
>       drm/amdgpu: add helper to init rlc fw in header v2_2
>       drm/amdgpu: add helper to init rlc fw in header v2_3
>       drm/amdgpu: add helper to init rlc fw in header v2_4
>       drm/amdgpu: add helper to init rlc firmware
>       drm/amdgpu/gfx11: switch to amdgpu_gfx_rlc_init_microcode
> 
> Sonny Jiang (2):
>       drm/amdgpu: Enable VCN DPG for GC11_0_1
>       drm/amdgpu: Enable sram on vcn_4_0_2
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c   | 264 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h   |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   |   2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 151 +----------------
>  drivers/gpu/drm/amd/amdgpu/soc21.c        |   1 +
>  7 files changed, 281 insertions(+), 149 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
