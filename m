Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4E0C19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 15:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E57C10E278;
	Thu, 27 Feb 2025 15:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RnFIsvx9";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046B710E278
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 15:32:04 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-22333fdc85aso2413725ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740670323; x=1741275123; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYsCEJzycLS0xqSPFP4fZrtQd+hszTDGJDgdPU1iCDQ=;
 b=RnFIsvx9CLkjCGUHxJ2YeAWuKTV5ZepDd8AyQwouDXGEWsOFkQORwCBkJugqSJGiUz
 mw/uAUNBYrijYqK0BqB7IYAlrOrY7/lO6YCEiLWUSXDeVOMKz75DCMVQAvN8bhhA9XJe
 a68VgP4sqdWaIIApEoppwTgwRZzz4HKGLGgpizHjTPyceVeIFV9Ao4TPSDkcmbvIsngA
 jaI0GfTgUFIXh7Afim7gdf5NRc8y797LL29vwPPVc1F40+wVtsKUWF9tUY0DW0j2O+9N
 x1vUcqDQtyWqy0SxbHZVuvFNen+++Rt2oz0phiXnBEr2UuTT0mn1egUu/v7MadCHNBF1
 YeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740670323; x=1741275123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYsCEJzycLS0xqSPFP4fZrtQd+hszTDGJDgdPU1iCDQ=;
 b=AUXRctnHYn6OhWTGaxarzpGDVn67dh8o7dYEFl2ghDYzS8IJ7IDfoHmaPKf90X4NLy
 W4c/Mzh0hJmnKv2lAxuxEv4W+r1Gpgptejcj0UGFl5joBlz/hE7wyfoOauMlsXbY33fO
 c8liCW9X64Z2aRY1BtE9cQ6ZndqQJBMdsWfKxHjf8PWiMBQvtGVJF5fvf8wOrt6O2QDQ
 S58kmePottur4NdCidATKSx8IhoHFq2Ao8DTrKGzaMNQuvbcaVK68LcWbn7iohVo0WDi
 sbHiXA3ML1TyduLf6lpe1YAIDhhXF3EFJPfg0KSx+jHM2wBbDhAUUR8U4u5ynkBjcrCj
 aqCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmrmzZhOSFuQXIRhIJRdO7qw3D2OALW4QawyJDUZK+2Q53ww8rnJHhcXoeiTlCocDF3MZvJt+Q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwA8qz/uAPM2uVZgD5PBrTGkniBDuAwwez9guT1yhHnWjyv9CLZ
 6E+qlu4ut7Y3aJuj6GDWs6jaTk/Xx/ank1RN6qNEmxWhT5yjH3VnhnWUkTzbbxcsRs42Rj7AdOy
 XIHD5xoiBiN8VYBxdP4GpG+YtXDvQiO4X
X-Gm-Gg: ASbGncvOvW1ZP6ZfomByj1ZxMqt1SSs2CkjoEIE3qt9W2vXVl9SnFSDyHuGkTuPN5P5
 fy2t4GtWu4ts5IGsMBt0gYYy/v2RYzf70V6FBOEVEFXHJg9HKxeC1evErdbEmiU1FscYl/Glu8R
 Mcadpeyoo=
X-Google-Smtp-Source: AGHT+IHOcnNpNfnAd4n8bLVBnpRwlt1kx0/WWWHRgbE1+FaPD7rhqvVZVnjjWhNzZRepbJHl6smwNsCWuIfb/Vfg/xw=
X-Received: by 2002:a17:903:1ce:b0:21f:356:758f with SMTP id
 d9443c01a7336-2219ff36196mr163927925ad.3.1740670323516; Thu, 27 Feb 2025
 07:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20250226014310.2426713-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250226014310.2426713-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2025 10:31:51 -0500
X-Gm-Features: AQ5f1JoJ4HhKDyx8BC8S-Ff6d70txEKL9lG7fGDuXqOp8BZLneAdYCh1TnH64DI
Message-ID: <CADnq5_OQkEs5MAMc+eOSBTFoCK9SwHmEZV3fQ6=vH+qxxGBRog@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix parameter annotations for VCN clock
 gating functions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Feb 25, 2025 at 8:43=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> The previous references to a non-existent `adev` parameter have been
> removed & corrected to reflect the use of the `vinst` pointer, which
> points to the VCN instance structure, in the below files:
>
> - vcn_v1_0.c
> - vcn_v2_0.c
> - vcn_v3_0.c
>
> Fixes the below with gcc W=3D1:
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:624: warning: Function parameter or=
 struct member 'vinst' not described in 'vcn_v1_0_enable_clock_gating'
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:624: warning: Excess function param=
eter 'adev' description in 'vcn_v1_0_enable_clock_gating'
> drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:376: warning: Function parameter or=
 struct member 'vinst' not described in 'vcn_v2_0_mc_resume'
> drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:376: warning: Excess function param=
eter 'adev' description in 'vcn_v2_0_mc_resume'
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:776: warning: Function parameter or=
 struct member 'vinst' not described in 'vcn_v3_0_disable_clock_gating'
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:776: warning: Excess function param=
eter 'adev' description in 'vcn_v3_0_disable_clock_gating'
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:776: warning: Excess function param=
eter 'inst' description in 'vcn_v3_0_disable_clock_gating'
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:965: warning: Function parameter or=
 struct member 'vinst' not described in 'vcn_v3_0_enable_clock_gating'
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:965: warning: Excess function param=
eter 'adev' description in 'vcn_v3_0_enable_clock_gating'
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:965: warning: Excess function param=
eter 'inst' description in 'vcn_v3_0_enable_clock_gating'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 6 ++----
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 8bad63282de4..21b57c29bf7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -616,7 +616,7 @@ static void vcn_v1_0_disable_clock_gating(struct amdg=
pu_vcn_inst *vinst)
>  /**
>   * vcn_v1_0_enable_clock_gating - enable VCN clock gating
>   *
> - * @adev: amdgpu_device pointer
> + * @vinst: Pointer to the VCN instance structure
>   *
>   * Enable clock gating for VCN block
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index f53feb60772e..8e7a36f26e9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -368,7 +368,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip=
_block)
>  /**
>   * vcn_v2_0_mc_resume - memory controller programming
>   *
> - * @adev: amdgpu_device pointer
> + * @vinst: Pointer to the VCN instance structure
>   *
>   * Let the VCN memory controller know it's offsets
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index a3f16fd69927..22ae1939476f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -767,8 +767,7 @@ static void vcn_v3_0_enable_static_power_gating(struc=
t amdgpu_vcn_inst *vinst)
>  /**
>   * vcn_v3_0_disable_clock_gating - disable VCN clock gating
>   *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: Pointer to the VCN instance structure
>   *
>   * Disable clock gating for VCN block
>   */
> @@ -956,8 +955,7 @@ static void vcn_v3_0_clock_gating_dpg_mode(struct amd=
gpu_vcn_inst *vinst,
>  /**
>   * vcn_v3_0_enable_clock_gating - enable VCN clock gating
>   *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: Pointer to the VCN instance structure
>   *
>   * Enable clock gating for VCN block
>   */
> --
> 2.34.1
>
