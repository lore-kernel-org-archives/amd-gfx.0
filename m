Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E987FC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 15:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B85A10E6AD;
	Fri, 21 Jul 2023 15:45:10 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FECA10E6AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 15:45:08 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a412653335so1373607b6e.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689954307; x=1690559107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSK02nzkij2SDqtlX1F4cZYOxPASiBQNl/QFEWbh0Ds=;
 b=rw/jSpv7hTLTWleC6MaqWV5UrLgnk+SCaFEDtr1SCOawzidGWm2HWXftvjR9UWPQx7
 P7elAmfyI+ioCCn0Dpc8ZEuGKdC/WqXlHsIIKTVeWlA78hdjnMIAewoKm3o4bUw65Eax
 ubg38j2+1wgIDEMrUCZp3Hsi84fgdSzZxmaYIPu//FxSMNZ+nqVx5xov29ddPu9GUAs3
 /ri+EWOOd1Dm/LUCg96hJ5zCqALMLO2Ex0T4bve2+22eL6PJH551u4+iOjC/WvHVf8jE
 IeX2Z1wgQAguq4EDvxUKJg1dFZ8ZR/oCahC7Qp2E6C9b+fV8oxV2VJNyHrSiBakgio2H
 5HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954307; x=1690559107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSK02nzkij2SDqtlX1F4cZYOxPASiBQNl/QFEWbh0Ds=;
 b=QZ4BRHNm4yNZ/jUeoxjpbrx6lvyTKFS5CsZBC6OvYz+sX+L1LQ+xTi3SrN71eG+sBZ
 VBW9YRzDjuQvnqezfWHJsMkU+5OeiTy9xZWZRgZTP6oq/kFHrGSWb0C1LJek0tFHGODg
 q7wVOM5p3DseJ1s9Mnz/R2rPumhCWIH6H7Khvg3lebpNlbIGczrM7eyMTxywLY3ggBGL
 cS3WjbQzp51nDo43IjnyUchwTaYI8tX4ru6XRtgBCnjhilEjMOQnmdxitFymbUapBOa6
 OV993ixjkc1OteuBxWOedySLufQZkwN2U3QHyaQIFigbnKNv6DVmkc30t1BgKyjUpJq4
 zx7Q==
X-Gm-Message-State: ABy/qLbL/nDNTNEAkxBXzutLcFBzhuuPCEsMJLxeudRcMz9FkRzdtyZl
 a2yd/lmAztuseUhgBHjNjVBKemldIAYcN7sZQay6W2GTvMc=
X-Google-Smtp-Source: APBJJlG2MgG7ZgVC7fBh2f2miri1MNApSMVW3sy+6Ndxm5Ha2p2mRzd6OnLInL/wDXukQIadTBSljgfuOM5o7f4fFsc=
X-Received: by 2002:a05:6808:2188:b0:3a1:dfa0:7e18 with SMTP id
 be8-20020a056808218800b003a1dfa07e18mr3243996oib.25.1689954307336; Fri, 21
 Jul 2023 08:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230715152618.946712-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230715152618.946712-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Jul 2023 11:44:56 -0400
Message-ID: <CADnq5_OFYSqZicwVDEE1NSiE3+KFvEtF1nseHXP5mZEA9vYhKg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Avoid externs & do not initialize globals to
 0 in radeon_drv.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jul 15, 2023 at 11:26=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following:
>
>  - WARNING: externs should be avoided in .c files
>  - ERROR: do not initialise globals to 0
>  - WARNING: Missing a blank line after declarations
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 51 ++++++++---------------------
>  drivers/gpu/drm/radeon/radeon_drv.h | 13 ++++++++
>  2 files changed, 27 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index e4374814f0ef..aa02697e5ea3 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -113,59 +113,32 @@
>  #define KMS_DRIVER_MAJOR       2
>  #define KMS_DRIVER_MINOR       50
>  #define KMS_DRIVER_PATCHLEVEL  0
> -int radeon_suspend_kms(struct drm_device *dev, bool suspend,
> -                      bool fbcon, bool freeze);
> -int radeon_resume_kms(struct drm_device *dev, bool resume, bool fbcon);
> -extern int radeon_get_crtc_scanoutpos(struct drm_device *dev, unsigned i=
nt crtc,
> -                                     unsigned int flags, int *vpos, int =
*hpos,
> -                                     ktime_t *stime, ktime_t *etime,
> -                                     const struct drm_display_mode *mode=
);
> -extern bool radeon_is_px(struct drm_device *dev);
> -int radeon_mode_dumb_mmap(struct drm_file *filp,
> -                         struct drm_device *dev,
> -                         uint32_t handle, uint64_t *offset_p);
> -int radeon_mode_dumb_create(struct drm_file *file_priv,
> -                           struct drm_device *dev,
> -                           struct drm_mode_create_dumb *args);
> -
> -/* atpx handler */
> -#if defined(CONFIG_VGA_SWITCHEROO)
> -void radeon_register_atpx_handler(void);
> -void radeon_unregister_atpx_handler(void);
> -bool radeon_has_atpx_dgpu_power_cntl(void);
> -bool radeon_is_atpx_hybrid(void);
> -#else
> -static inline void radeon_register_atpx_handler(void) {}
> -static inline void radeon_unregister_atpx_handler(void) {}
> -static inline bool radeon_has_atpx_dgpu_power_cntl(void) { return false;=
 }
> -static inline bool radeon_is_atpx_hybrid(void) { return false; }
> -#endif
>
>  int radeon_no_wb;
>  int radeon_modeset =3D -1;
>  int radeon_dynclks =3D -1;
> -int radeon_r4xx_atom =3D 0;
> +int radeon_r4xx_atom;
>  int radeon_agpmode =3D -1;
> -int radeon_vram_limit =3D 0;
> +int radeon_vram_limit;
>  int radeon_gart_size =3D -1; /* auto */
> -int radeon_benchmarking =3D 0;
> -int radeon_testing =3D 0;
> -int radeon_connector_table =3D 0;
> +int radeon_benchmarking;
> +int radeon_testing;
> +int radeon_connector_table;
>  int radeon_tv =3D 1;
>  int radeon_audio =3D -1;
> -int radeon_disp_priority =3D 0;
> -int radeon_hw_i2c =3D 0;
> +int radeon_disp_priority;
> +int radeon_hw_i2c;
>  int radeon_pcie_gen2 =3D -1;
>  int radeon_msi =3D -1;
>  int radeon_lockup_timeout =3D 10000;
> -int radeon_fastfb =3D 0;
> +int radeon_fastfb;
>  int radeon_dpm =3D -1;
>  int radeon_aspm =3D -1;
>  int radeon_runtime_pm =3D -1;
> -int radeon_hard_reset =3D 0;
> +int radeon_hard_reset;
>  int radeon_vm_size =3D 8;
>  int radeon_vm_block_size =3D -1;
> -int radeon_deep_color =3D 0;
> +int radeon_deep_color;
>  int radeon_use_pflipirq =3D 2;
>  int radeon_bapm =3D -1;
>  int radeon_backlight =3D -1;
> @@ -384,6 +357,7 @@ radeon_pci_shutdown(struct pci_dev *pdev)
>  static int radeon_pmops_suspend(struct device *dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> +
>         return radeon_suspend_kms(drm_dev, true, true, false);
>  }
>
> @@ -404,12 +378,14 @@ static int radeon_pmops_resume(struct device *dev)
>  static int radeon_pmops_freeze(struct device *dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> +
>         return radeon_suspend_kms(drm_dev, false, true, true);
>  }
>
>  static int radeon_pmops_thaw(struct device *dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> +
>         return radeon_resume_kms(drm_dev, false, true);
>  }
>
> @@ -494,6 +470,7 @@ long radeon_drm_ioctl(struct file *filp,
>         struct drm_file *file_priv =3D filp->private_data;
>         struct drm_device *dev;
>         long ret;
> +
>         dev =3D file_priv->minor->dev;
>         ret =3D pm_runtime_get_sync(dev->dev);
>         if (ret < 0) {
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.h b/drivers/gpu/drm/radeon=
/radeon_drv.h
> index 2ffe0975ee54..34a1c73d3938 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.h
> +++ b/drivers/gpu/drm/radeon/radeon_drv.h
> @@ -124,4 +124,17 @@ int radeon_driver_open_kms(struct drm_device *dev, s=
truct drm_file *file_priv);
>  void radeon_driver_postclose_kms(struct drm_device *dev,
>                                  struct drm_file *file_priv);
>
> +/* atpx handler */
> +#if defined(CONFIG_VGA_SWITCHEROO)
> +void radeon_register_atpx_handler(void);
> +void radeon_unregister_atpx_handler(void);
> +bool radeon_has_atpx_dgpu_power_cntl(void);
> +bool radeon_is_atpx_hybrid(void);
> +#else
> +static inline void radeon_register_atpx_handler(void) {}
> +static inline void radeon_unregister_atpx_handler(void) {}
> +static inline bool radeon_has_atpx_dgpu_power_cntl(void) { return false;=
 }
> +static inline bool radeon_is_atpx_hybrid(void) { return false; }
> +#endif
> +
>  #endif                         /* __RADEON_DRV_H__ */
> --
> 2.25.1
>
