Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E98C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 22:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96E910EB24;
	Wed, 19 Apr 2023 22:12:41 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FBF810EB24
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 22:12:39 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-541fb831026so77972eaf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681942359; x=1684534359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hY3WhOutX2u96PX3AL2DPtZd4djtkUpglRPWPEEIwVY=;
 b=Ym4LoQSwz4sFXE0+WFHQ6BGuDIYntNZZFYOLPMmXJbXSP3vCnRgx6F3d9w9aKMmY9V
 gUbcL13kfqaVQ2do48irTfdITKgSf7yIdiDgPADO0JD1BNA/CccwMEMNYUfgvmfTPp6P
 YrzYrjxLIyHx2+U4qHRISTlaW+D2cz21WVEIbkDmaiuc2OKLu82lfOO6bm2NdzcsWfJ6
 MDeW1fdTXua7nJjgJaIxPCGLBZcHfxnx9pOHIxctJ/BJ2cPUklVDXSTKSvM/LC7yQR24
 bn3SsxICD6an9dk86dn6T3R/d4VsBA9ue6VoBUMiEDPQSYrOi4YmxrCmiYiIYlw3jeq1
 lCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681942359; x=1684534359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hY3WhOutX2u96PX3AL2DPtZd4djtkUpglRPWPEEIwVY=;
 b=UjJhOjaNo9Hgvqa8lZvKPU6muJo2v7MjpAat7N17Jf648g0FxbZqR4CSS5t10955BB
 xIhvCsWxjY0IvGV+zYBPKDBJ6O7T+k2LWVBcNGHSvBjc+UGLabGI61+JKyHuWY47V5ra
 MedlyXCCekrRZmRwEimFq7mZn76WVYpds+C/GVGDyBNG2g9VlGUxwl76YOIUbsUD3DC0
 4FuHcvPXr22ohEqXU7JyEkgRcHMZCOIeBh+XfS04VOqY2xwnupori9l1XPb7bgUJwSx+
 TCbHUPfm6keC6vQPnzCg5vbfAN+WyQFrwxvj6wyGKzvqx/9taAIlXleWxxEmxeLl/TSN
 JdbQ==
X-Gm-Message-State: AAQBX9djTU5QrtMfnySjscBR5m5wepRLgStGoDKbsG+Kvd275RTpiNrh
 X1RSQ9eAYtfjRf0LpBHKTGVE/dDCpjzqXW2YIuFYCgng
X-Google-Smtp-Source: AKy350acdW/UM3O8RBjxEHolCPJjqFMnhws0FLdckZhWTl0p1ypZSd3oSvdW77TtWy3NtrNPAnVOrZ9rl88Qi0wZP7E=
X-Received: by 2002:a05:6870:7029:b0:184:63b5:8643 with SMTP id
 u41-20020a056870702900b0018463b58643mr736777oae.40.1681942359028; Wed, 19 Apr
 2023 15:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-12-alexander.deucher@amd.com>
In-Reply-To: <20230330191750.1134210-12-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Apr 2023 18:12:28 -0400
Message-ID: <CADnq5_M28Kvgw8FtNTQ6LCusFdJjCDxSNOYkxyLtLd7RZkCKTg@mail.gmail.com>
Subject: Re: [PATCH 11/13] drm/amdgpu: bump driver version number for CP GFX
 shadow
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> So UMDs can determine whether the kernel supports this.
>
> Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21986
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 917926c8dc5f..c35baee082e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -111,9 +111,10 @@
>   *   3.52.0 - Add AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD, add device_in=
fo fields:
>   *            tcp_cache_size, num_sqc_per_wgp, sqc_data_cache_size, sqc_=
inst_cache_size,
>   *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pi=
pes_mask_hi
> + *   3.53.0 - Support for GFX11 CP GFX shadowing
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       52
> +#define KMS_DRIVER_MINOR       53
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  unsigned int amdgpu_vram_limit =3D UINT_MAX;
> --
> 2.39.2
>
