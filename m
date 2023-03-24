Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B9AC6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 09:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA91110E525;
	Fri, 24 Mar 2023 09:48:12 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E523310EBA5
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 09:48:10 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id u1so725745wmn.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1679651289; x=1682243289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NruCG9KnEBTudzG21xlEqapBgxFRlVnIoA3g3lXbMf4=;
 b=K9WptdH4Dka+GOJLgz771LPXL0Z4zWEF9uffaxwPoA/ICo8Grbp08wKWcVAz7hPDQy
 a6fN3sPWc5Fv/2+Mc4HTPH1bSgJYL4RbnTRNYp/8CeYnYxg+icaDm29B+M/V1pG4kcqC
 +lBc+XYRCvmrGqaiGWLWOFmJSTefKDAg/uJW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679651289; x=1682243289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NruCG9KnEBTudzG21xlEqapBgxFRlVnIoA3g3lXbMf4=;
 b=2/r6JEwYVLpdGsN4P8mK3+UaO300rZVohA3kQ8esEh9K7BUvRajtKXJmjxUBPNWrl+
 97BAAC20qLWSxc04LkK34ZNpAPwn0x1pH3GuWOP7iB3i4UvZLQi3dQi1nMnVG7k5XYSN
 6BmsZv5sR5CV97Em9LGFIwWvI0CQQxrnjsNhtSF+oj0eS7XFLCKDPsxp8np8D2a5jTs9
 9UcMarav4+aIU9dliJY+CK4qRPH7e2zNDFAtrjbdqp30Mr/mEdUL9Knv8gJTwoASVmpU
 s3UKps7WfROTPOXz9LmkVRybz0ufc5rUqmBqdcTpyw4QcJEeIhD8/E3XOO1SlI71t4H4
 FIkQ==
X-Gm-Message-State: AO0yUKW39for0tI+hKJihcHaXly0nRylmWRfET/we1IzSLrsQiZA+7mJ
 tjRZVAXuyl9hCTEA9C5CelGrzA==
X-Google-Smtp-Source: AK7set+J8AsJ2UF7gxrywt8ctaJSq1LiiXCFCjJP0SP0S3+7w0pZbv8CoCU6O9ycBLo+wwAuh+eZkw==
X-Received: by 2002:a05:600c:1d03:b0:3e8:7ca3:8424 with SMTP id
 l3-20020a05600c1d0300b003e87ca38424mr2302906wms.1.1679651289429; 
 Fri, 24 Mar 2023 02:48:09 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 n17-20020a1c7211000000b003edf2dc7ca3sm4328779wmc.34.2023.03.24.02.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 02:48:09 -0700 (PDT)
Date: Fri, 24 Mar 2023 10:48:07 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [pull] amdgpu drm-fixes-6.3
Message-ID: <ZB1x19/Zuqt8Zh6r@phenom.ffwll.local>
References: <20230323161939.7751-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323161939.7751-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 6.1.0-6-amd64 
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

On Thu, Mar 23, 2023 at 12:19:39PM -0400, Alex Deucher wrote:
> Hi Dave, Daniel,
> 
> Fixes for 6.3.
> 
> The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:
> 
>   Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.3-2023-03-23
> 
> for you to fetch changes up to f9537b1fa7fb51c2162bc15ce469cbbf1ca0fbfe:
> 
>   drm/amd/display: Set dcn32 caps.seamless_odm (2023-03-23 09:39:34 -0400)

Pulled, thanks.
-Daniel

> 
> ----------------------------------------------------------------
> amd-drm-fixes-6.3-2023-03-23:
> 
> amdgpu:
> - S4 fix
> - Soft reset fixes
> - SR-IOV fix
> - Remove an out of date comment in the DC code
> - ASPM fix
> - DCN 3.2 fixes
> 
> ----------------------------------------------------------------
> Alex Hung (1):
>       drm/amd/display: remove outdated 8bpc comments
> 
> Hersen Wu (2):
>       drm/amd/display: fix wrong index used in dccg32_set_dpstreamclk
>       drm/amd/display: Set dcn32 caps.seamless_odm
> 
> Jane Jian (1):
>       drm/amdgpu/gfx: set cg flags to enter/exit safe mode
> 
> Kai-Heng Feng (1):
>       drm/amdgpu/nv: Apply ASPM quirk on Intel ADL + AMD Navi
> 
> Tim Huang (2):
>       drm/amdgpu: reposition the gpu reset checking for reuse
>       drm/amdgpu: skip ASIC reset for APUs when go to S4
> 
> Tong Liu01 (1):
>       drm/amdgpu: add mes resume when do gfx post soft reset
> 
> YuBiao Wang (1):
>       drm/amdgpu: Force signal hw_fences that are embedded in non-sched jobs
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  5 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           | 41 ++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 15 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |  9 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             | 14 ++++++++
>  drivers/gpu/drm/amd/amdgpu/nv.c                    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vi.c                    | 17 +--------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  1 -
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c  |  3 +-
>  .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |  1 +
>  11 files changed, 72 insertions(+), 41 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
