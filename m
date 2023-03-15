Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E7FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 14:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F8410E2B0;
	Wed, 15 Mar 2023 14:36:12 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D67010E2B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 14:36:09 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-17ac5ee3f9cso2416750fac.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678890968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UU/FEFaeIJTJzrJTiM7yDuD4xhTaoT5kSIt/scLPG9k=;
 b=MdsYKB3nA1jKmolGeY51h5uWy3K4g2+oT459fxK02H1+OFV3rPyOtn0TuxjM5sUrvI
 fWS6AsRHPpTz2jDYvmt3oT2Kz9QItAtjTb6Qopb07JDcQT2cG6TMqNdenZZHlo0vrJ0U
 qhuqeJI+NqI30/hb0tIxWY2nOUAiOkfwJKkQlklySvP8/38UYi3mJZCUrZh8RZ/N/SjD
 FA1dRgDYIgTWj9zbsl5AB1B97s+t6YLlVY9b1rC9/AgydRas6GbOcyvxZX60aaUAnLS/
 q+Xj7ClpeVu+cqD7WGxWZJDBcsIVbHY/id4TizCLDcFse3GOHvnXqNrV45QaXCF3ToQJ
 B4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678890968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UU/FEFaeIJTJzrJTiM7yDuD4xhTaoT5kSIt/scLPG9k=;
 b=S1F1XpK5OM6S4VMKPv4BJBXlzn+e4mKs2AfnBch5xBMxpZFYG4F9PAocrjFt0/gwLJ
 utjUmw1GbXgxKB839nZ2wQFZRR3JbflrMHYGT3Ar+fi+UFsgpQD2A6p9GN+wMroV3Pox
 U14r+d1TcTAzqLWI0JEzcsMmgcPDLTD218TLVtK7k6E3E2FBwy7nXiMxp3r9ZOg7mY3O
 TL3dJ1lElzehGc048EDJECbeEQKfZ3LmyPKKNNVxV/W4ta9SMmwOhn2slaY81wjZ1S3/
 9u/axQ9nXpZoM7W4tGTZYZaYry06E/UnC6CMhqgVb+frj2xbBwcc9/OdPkcvPf5r6VyK
 tagw==
X-Gm-Message-State: AO0yUKU91CtCGU5eC1AdNQPIgdhzWu/11mfa6VWPLyirDS78wqJ3tvFH
 husNvP4Cwg3+oE6STKEALbA8UUiY11U7sFLQS6g=
X-Google-Smtp-Source: AK7set9ZOO8M8Rei20GlxLjWoPSAqRPRn0mJ1mJ9KNDqzoP+HxaEE3OJpMwgYTzLL39zrTba885fLSlOrFOiNP2d7mg=
X-Received: by 2002:a05:6870:814:b0:177:a289:46b1 with SMTP id
 fw20-20020a056870081400b00177a28946b1mr4539516oab.3.1678890968460; Wed, 15
 Mar 2023 07:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230315110341.248166-1-tim.huang@amd.com>
In-Reply-To: <20230315110341.248166-1-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Mar 2023 10:35:56 -0400
Message-ID: <CADnq5_N30puWJBtw+_yLxu_Eyifvoti-C8G+exWaLG_8-S5pcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: reposition the gpu reset checking for
 reuse
To: Tim Huang <tim.huang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, mario.limonciello@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 15, 2023 at 7:05=E2=80=AFAM Tim Huang <tim.huang@amd.com> wrote=
:
>
> Move the amdgpu_acpi_should_gpu_reset out of
> CONFIG_SUSPEND to share it with hibernate case.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 40 +++++++++++++-----------
>  2 files changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 5c6132502f35..5bddc03332b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1392,10 +1392,12 @@ int amdgpu_acpi_smart_shift_update(struct drm_dev=
ice *dev, enum amdgpu_ss ss_sta
>  int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
>
>  void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *cap=
s);
> +bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
>  void amdgpu_acpi_detect(void);
>  #else
>  static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return =
0; }
>  static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
> +static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *ad=
ev) { return false; }
>  static inline void amdgpu_acpi_detect(void) { }
>  static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { =
return false; }
>  static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *=
adev,
> @@ -1406,11 +1408,9 @@ static inline int amdgpu_acpi_smart_shift_update(s=
truct drm_device *dev,
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
>  bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
> -bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
>  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>  #else
>  static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev=
) { return false; }
> -static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *ad=
ev) { return false; }
>  static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) =
{ return false; }
>  #endif
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 25e902077caf..065944bdeee4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -971,6 +971,28 @@ static bool amdgpu_atcs_pci_probe_handle(struct pci_=
dev *pdev)
>         return true;
>  }
>
> +
> +/**
> + * amdgpu_acpi_should_gpu_reset
> + *
> + * @adev: amdgpu_device_pointer
> + *
> + * returns true if should reset GPU, false if not
> + */
> +bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
> +{
> +       if (adev->flags & AMD_IS_APU)
> +               return false;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return false;
> +
> +#if IS_ENABLED(CONFIG_SUSPEND)
> +       return pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE;
> +#endif /* CONFIG_SUSPEND */
> +       return true;

Should probably be:
#if IS_ENABLED(CONFIG_SUSPEND)
    return pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE;
#else
    return true;
#endif

With that fixed, series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +}
> +
>  /*
>   * amdgpu_acpi_detect - detect ACPI ATIF/ATCS methods
>   *
> @@ -1042,24 +1064,6 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device=
 *adev)
>                 (pm_suspend_target_state =3D=3D PM_SUSPEND_MEM);
>  }
>
> -/**
> - * amdgpu_acpi_should_gpu_reset
> - *
> - * @adev: amdgpu_device_pointer
> - *
> - * returns true if should reset GPU, false if not
> - */
> -bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
> -{
> -       if (adev->flags & AMD_IS_APU)
> -               return false;
> -
> -       if (amdgpu_sriov_vf(adev))
> -               return false;
> -
> -       return pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE;
> -}
> -
>  /**
>   * amdgpu_acpi_is_s0ix_active
>   *
> --
> 2.25.1
>
