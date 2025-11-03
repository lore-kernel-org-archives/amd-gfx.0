Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E42CCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 21:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F0A10E4A8;
	Mon,  3 Nov 2025 21:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsw4a4av";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4F510E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 21:31:50 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-340bb45e37cso706198a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 13:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762205510; x=1762810310; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bKIHMLPwCiFaa/oip8+T7eUKLeK5i1ivUYnkcz6hpA=;
 b=nsw4a4avpWg5PR8Gv1Y31er340/w9ADgoFd66uOM51DFB1Yn4DMlLIpHt+BCowYRmP
 hcR1QDAvGoSQwHT1/O4SayzmmjnhE7HE6NOuj3ZvfzL7MYCWVxAoTkc37O2a8QaIt+b+
 KO3DafkfpwAoRx/CtN/5wKEqfiOGWOrw95F1nK/V8h1tr0O0sxGLQEcypyw79VFNrDiA
 9hQDilinR9Hv2ThFhFH1mM6Qx1rv8vZEql32t64B3yd/Lv1GlDJQBETByKtQraU1Sx/8
 mjkhcE9czf8Oow8QM529r4SfZS8ZV8hXg5iZ8uIf3KPsdGCqLpuRyCW1Jr/HUUdniPka
 b/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762205510; x=1762810310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bKIHMLPwCiFaa/oip8+T7eUKLeK5i1ivUYnkcz6hpA=;
 b=sXpY4Ifz/IcbYJjBVFAnK2hBzXUumvba17ZGLcuu/9HL9OrAATGiM+NKkGWd9ERJ9v
 XkUrYl+peoi8a/sCv92KPEmxg6T+Z7gL9QeHuGJg7kgJ2vo9FJPbAbUP6cPNjACMHkYV
 iRisJ2+WEjg+JOcYyIOI/evZHa3g7fKg7JdZ8RM0AtU+18r+65/fEfs2SB+iyhp00or6
 1qSDZlDdP155svpOlLe6XfFjlIg+VE0qcHNJFI6820ltKbJL3atniBwnF2Og6T1A0d4M
 pMjpKcIvaNgE3ECCBJdXaKLihOAvIkrVXR5lUI38n6MrPWG0ffJeXn6QgG18xo82sKsu
 DOTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXne1R4xVc6nT6SWuSIRxBuZ/Hc7KH20gs0B4T09UCysJVg8GyZbtDC0PFohO+MzxgcQFHbPkk7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgIrcrrh4H0G4UOY6c2dV2+vfLHQvIMBT6X75wftWkZYQGpYg+
 KxJoFL9PwDIxrDJsa5cZJJsmEDJvZ2AYVi0hBDeAX1a5SHIFl/6nbVPu5EonDQ4JvdlW8/oM//a
 /Vq6droIz9OLUshym/J+IqPV5pU6m22Q=
X-Gm-Gg: ASbGncsZVU1u2VQEB3HTtH2nEY2WBLv95l1+M3V8dmt5NAa5RVWpjaXwI7WWffOOMzS
 3i5GWzSv1bOIEiGElwz5/Vg8mGp6WMGSt3Zbk9JKhMIyV/bC1keP7G5udAaMp8kNruxht7xqk/V
 gM+PGcwRVJC8MzTrmajBz3tMSmSQKVDtO8hTlJjc0h7cqV1p/B5S7tKzVjgZknOKOKKaHSM4Muq
 UOcu9TXI2aiw5ko1TZ85BQFy97ci5CqbDmx8+cCs5YusX6TLp4m5Z5nDeOt
X-Google-Smtp-Source: AGHT+IGQ+WAEAOAt7yPwnBsO6GwUFhOLzUBtA6E5IO7SAf2ckogTYPBk0v+saDkGcIap7Gp10O+6qkg0VNBP4AGgSj8=
X-Received: by 2002:a17:902:da84:b0:290:c3a9:42b5 with SMTP id
 d9443c01a7336-2951a3d0c0cmr105768265ad.5.1762205509592; Mon, 03 Nov 2025
 13:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20251103-vram-carveout-tuning-for-upstream-v1-0-17e2a72639c5@amd.com>
 <20251103-vram-carveout-tuning-for-upstream-v1-3-17e2a72639c5@amd.com>
In-Reply-To: <20251103-vram-carveout-tuning-for-upstream-v1-3-17e2a72639c5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Nov 2025 16:31:38 -0500
X-Gm-Features: AWmQ_bmqu9YTyChudiOdhGZR8S8TU026e-QJNDnGb4DG53LrXogAIb3prVZPVn8
Message-ID: <CADnq5_PwPiMT+oh7ccLn+aL_zTgA0cFUQRiKQEM3V6AZHvBrOQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: add UMA allocation setting helpers
To: "Yo-Jung Leo Lin (AMD)" <Leo.Lin@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, anson.tsao@amd.com, superm1@kernel.org
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

On Mon, Nov 3, 2025 at 3:11=E2=80=AFAM Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.c=
om> wrote:
>
> On some platforms, UMA allocation size can be set using the ATCS
> methods. Add helper functions to interact with this functionality.
>
> Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  7 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 43 ++++++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/amd/include/amd_acpi.h   | 30 ++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a5574e84694b..3de520f0b5b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1686,12 +1686,14 @@ int amdgpu_acpi_init(struct amdgpu_device *adev);
>  void amdgpu_acpi_fini(struct amdgpu_device *adev);
>  bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_dev=
ice *adev);
>  bool amdgpu_acpi_is_power_shift_control_supported(void);
> +bool amdgpu_acpi_is_set_uma_allocation_size_supported(void);
>  int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
>                                                 u8 perf_req, bool adverti=
se);
>  int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
>                                     u8 dev_state, bool drv_state);
>  int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
>                                    enum amdgpu_ss ss_state);
> +int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 i=
ndex, u8 type);
>  int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
>  int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset=
,
>                              u64 *tmr_size);
> @@ -1720,6 +1722,7 @@ static inline bool amdgpu_acpi_should_gpu_reset(str=
uct amdgpu_device *adev) { re
>  static inline void amdgpu_acpi_detect(void) { }
>  static inline void amdgpu_acpi_release(void) { }
>  static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { =
return false; }
> +static inline bool amdgpu_acpi_is_set_uma_allocation_size_supported(void=
) { return false; }
>  static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *=
adev,
>                                                   u8 dev_state, bool drv_=
state) { return 0; }
>  static inline int amdgpu_acpi_smart_shift_update(struct amdgpu_device *a=
dev,
> @@ -1727,6 +1730,10 @@ static inline int amdgpu_acpi_smart_shift_update(s=
truct amdgpu_device *adev,
>  {
>         return 0;
>  }
> +int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 i=
ndex, u8 type)
> +{
> +       return -EINVAL;
> +}
>  static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backl=
ight_caps *caps) { }
>  #endif
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 0743fd8620e4..d53f7b33d619 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -669,6 +669,11 @@ bool amdgpu_acpi_is_power_shift_control_supported(vo=
id)
>         return amdgpu_acpi_priv.atcs.functions.power_shift_control;
>  }
>
> +bool amdgpu_acpi_is_set_uma_allocation_size_supported(void)
> +{
> +       return amdgpu_acpi_priv.atcs.functions.set_uma_allocation_size;
> +}
> +
>  /**
>   * amdgpu_acpi_pcie_notify_device_ready
>   *
> @@ -909,6 +914,44 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa=
_info(uint32_t pxm)
>  }
>  #endif
>
> +/**
> + * amdgpu_acpi_set_uma_allocation_size - Set Unified Memory Architecture=
 allocation size via ACPI
> + * @adev: Pointer to the amdgpu_device structure
> + * @index: Index specifying the UMA allocation
> + * @type: Type of UMA allocation
> + *
> + * This function configures the UMA allocation size for the specified de=
vice
> + * using ACPI methods. The allocation is determined by the provided inde=
x and type.
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int amdgpu_acpi_set_uma_allocation_size(struct amdgpu_device *adev, u8 i=
ndex, u8 type)
> +{
> +       struct atcs_set_uma_allocation_size_input atcs_input;
> +       struct amdgpu_atcs *atcs =3D &amdgpu_acpi_priv.atcs;
> +       struct acpi_buffer params;
> +       union acpi_object *info;
> +
> +       if (!amdgpu_acpi_is_set_uma_allocation_size_supported())
> +               return -EINVAL;
> +
> +       atcs_input.size =3D sizeof(struct atcs_set_uma_allocation_size_in=
put);
> +       atcs_input.uma_size_index =3D index;
> +       atcs_input.uma_size_type =3D type;
> +
> +       params.length =3D sizeof(struct atcs_set_uma_allocation_size_inpu=
t);
> +       params.pointer =3D &atcs_input;
> +
> +       info =3D amdgpu_atcs_call(atcs, ATCS_FUNCTION_SET_UMA_ALLOCATION_=
SIZE, &params);
> +       if (!info) {
> +               drm_err(adev_to_drm(adev), "ATCS UMA allocation size upda=
te failed\n");
> +               return -EIO;
> +       }
> +
> +       kfree(info);
> +
> +       return 0;
> +}
> +
>  /**
>   * amdgpu_acpi_get_node_id - obtain the NUMA node id for corresponding a=
mdgpu
>   * acpi device handle
> diff --git a/drivers/gpu/drm/amd/include/amd_acpi.h b/drivers/gpu/drm/amd=
/include/amd_acpi.h
> index e582339e8e8e..84933c07f720 100644
> --- a/drivers/gpu/drm/amd/include/amd_acpi.h
> +++ b/drivers/gpu/drm/amd/include/amd_acpi.h
> @@ -24,6 +24,8 @@
>  #ifndef AMD_ACPI_H
>  #define AMD_ACPI_H
>
> +#include <linux/types.h>
> +
>  #define ACPI_AC_CLASS           "ac_adapter"
>
>  struct atif_verify_interface {
> @@ -112,6 +114,17 @@ struct atcs_pwr_shift_input {
>         u8 drv_state;   /* 0 =3D operational, 1 =3D not operational */
>  } __packed;
>
> +struct atcs_get_uma_size_output {
> +       u16 size;               /* structure size in bytes (includes size=
 field) */
> +       u32 uma_size_mb;        /* allocated UMA size in MB */
> +} __packed;
> +
> +struct atcs_set_uma_allocation_size_input {
> +       u16 size;               /* structure size in bytes (includes size=
 field) */
> +       u8 uma_size_index;      /* UMA size index */
> +       u8 uma_size_type;       /* UMA size type */
> +} __packed;
> +
>  /* AMD hw uses four ACPI control methods:
>   * 1. ATIF
>   * ARG0: (ACPI_INTEGER) function code
> @@ -494,4 +507,21 @@ struct atcs_pwr_shift_input {
>   * OUTPUT: none
>   */
>
> +#define ATCS_FUNCTION_GET_UMA_SIZE                                 0x6
> +/* ARG0: ATCS_FUNCTION_GET_UMA_SIZE
> + * ARG1: none
> + * OUTPUT:
> + * WORD  - structure size in bytes (includes size field)
> + * DWORD - allocated UMA size in MB
> + */
> +
> +#define ATCS_FUNCTION_SET_UMA_ALLOCATION_SIZE                     0xA
> +/* ARG0: ATCS_FUNCTION_SET_UMA_ALLOCATION_SIZE
> + * ARG1:
> + * WORD  - structure size in bytes (includes size field)
> + * BYTE  - UMA size index
> + * BYTE  - UMA size type
> + * OUTPUT: none
> + */
> +
>  #endif
>
> --
> 2.43.0
>
