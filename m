Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1937ECE589
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 21:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2C510E6D0;
	Mon,  9 Sep 2024 21:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R8i8TaT3";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9554A10E6D0
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 21:38:23 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2054fea6f26so1866125ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 14:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725917903; x=1726522703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwgQq3/wE4+QAGgsMfeBK8oAOga2mGFmOMkQdhKEYzM=;
 b=R8i8TaT3ha8YVQoYSEsltQ+aOmg3XTRVPUoRHk8BzS5c49dmVl3mvDkTjnHPlzXuy6
 KJGw5HAWxNUWqr+Xg+6h38GUurCJQ61hCbZcFu3mBv2zc7sujwbJxdJ3JXKo4xW0FVwr
 4wRADbcu3mShuisxC9SHaE7S66g3t/jm2QY8X1MKF8Uf4Ann5E+l7v4t2lT/Qho5QvYE
 10tRSTSkPoHtSEudqouJ/Blx6sDYeN11J2HKmYeZ/FmTkslTK7Uul0LgxZymjH8IJUhm
 yNCIA+oPhe5w/KJaPGj251VT3HfnZ8gjMnkJMuf3a+Df9fhi3z8cwpCbGO7wBC4wdJ1c
 VX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725917903; x=1726522703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwgQq3/wE4+QAGgsMfeBK8oAOga2mGFmOMkQdhKEYzM=;
 b=kzK3d4Felx2BzJj2Hlsz8Hpcil3XldVgv6iLwzDoc2XPjNVetovBbvtxf8aS/h5AEC
 Bxo4gZGjGOolSz9s8BQq/hmURbaoFPo1+dWDC7rctSwQx424WoNQfOkiw+lV00kH8Van
 t9ugiRJPcolNKIduuDZjjDbpi8vY4xjy/rjpzx1e+YI+J+Vb+9iC6Sv5zf4IJ9JJkbOZ
 XbXXmH7oqRv1/htnb0XJkxNFLWKSh45SBBoly0neGDOkg7zXiiE9fJsHlNRLoe/KdZQA
 RoUiYoRlYyBlMUcBFYwwWDq5e565i7liJAqnGAb+XjhsqAIUgGme6MgFfz0aDdMSdA9L
 N6eA==
X-Gm-Message-State: AOJu0YxTGElp1+u+JjW3e03DZGbl4+LxJTcX2hjB3mf96MgFTYZrFtaf
 v/87kIph2zZB+SYxi0yL/ajNrEOUiE8MsUrr+Vr1f50fHB+WiNZ+uf7VjjjDWCScfbXo/AFtLVg
 MtOXVH5zH4b7GxmE5SHpMamp6Tl8=
X-Google-Smtp-Source: AGHT+IE1Qjnvv6jH16sQdofDs4v2NsLST3Q7RzwjOTIY3g6znfNvNJiC/I0YXPYv3FmMHabhoNCqTnqfU0Q4Y3dYlz0=
X-Received: by 2002:a17:902:d2c2:b0:205:76c9:795d with SMTP id
 d9443c01a7336-206f0605ebbmr63403125ad.6.1725917903044; Mon, 09 Sep 2024
 14:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-10-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-10-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 17:38:11 -0400
Message-ID: <CADnq5_PqnQ8n61UKaHfLNCs-HJnvOSV9dC=fh5bLG-PqZ0Pv-g@mail.gmail.com>
Subject: Re: [PATCH 09/10] drm/amdgpu: Add interface for TOS reload cases
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
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

On Mon, Sep 2, 2024 at 3:34=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add interface to check if a different TOS needs to be loaded than the
> one which is which is already active on the SOC. Presently the interface
> is restricted to specific variants of PSPv13.0.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +++
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 25 +++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 189574d53ebd..3623bea2b1e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2264,6 +2264,19 @@ bool amdgpu_psp_get_ras_capability(struct psp_cont=
ext *psp)
>         }
>  }
>
> +bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
> +{
> +       struct psp_context *psp =3D &adev->psp;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return false;
> +
> +       if (psp->funcs && psp->funcs->is_reload_needed)
> +               return psp->funcs->is_reload_needed(psp);
> +
> +       return false;
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)
>  {
>         struct amdgpu_device *adev =3D psp->adev;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 74a96516c913..23581c44e625 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -138,6 +138,7 @@ struct psp_funcs {
>         int (*vbflash_stat)(struct psp_context *psp);
>         int (*fatal_error_recovery_quirk)(struct psp_context *psp);
>         bool (*get_ras_capability)(struct psp_context *psp);
> +       bool (*is_reload_needed)(struct psp_context *psp);
>  };
>
>  struct ta_funcs {
> @@ -553,4 +554,6 @@ int is_psp_fw_valid(struct psp_bin_desc bin);
>
>  int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
>  bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
> +bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v13_0.c
> index 1251ee38a676..035e0ceda4c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -807,6 +807,30 @@ static bool psp_v13_0_get_ras_capability(struct psp_=
context *psp)
>         }
>  }
>
> +static bool psp_v13_0_is_reload_needed(struct psp_context *psp)
> +{
> +       uint32_t ucode_ver;
> +
> +       if (!psp_v13_0_is_sos_alive(psp))
> +               return false;
> +
> +       /* Restrict reload support only to specific IP versions */
> +       switch (amdgpu_ip_version(psp->adev, MP0_HWIP, 0)) {
> +       case IP_VERSION(13, 0, 2):
> +       case IP_VERSION(13, 0, 6):
> +       case IP_VERSION(13, 0, 14):
> +               /* TOS version read from microcode header */
> +               ucode_ver =3D psp->sos.fw_version;
> +               /* Read TOS version from hardware */
> +               psp_v13_0_init_sos_version(psp);
> +               return (ucode_ver !=3D psp->sos.fw_version);
> +       default:
> +               return false;
> +       }
> +
> +       return false;
> +}
> +
>  static const struct psp_funcs psp_v13_0_funcs =3D {
>         .init_microcode =3D psp_v13_0_init_microcode,
>         .wait_for_bootloader =3D psp_v13_0_wait_for_bootloader_steady_sta=
te,
> @@ -830,6 +854,7 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
>         .vbflash_stat =3D psp_v13_0_vbflash_status,
>         .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_qu=
irk,
>         .get_ras_capability =3D psp_v13_0_get_ras_capability,
> +       .is_reload_needed =3D psp_v13_0_is_reload_needed,
>  };
>
>  void psp_v13_0_set_psp_funcs(struct psp_context *psp)
> --
> 2.25.1
>
