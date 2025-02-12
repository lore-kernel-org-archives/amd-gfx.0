Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1968C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 19:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42AA910E96C;
	Wed, 12 Feb 2025 19:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hrZTn7G3";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B526F10E96C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 19:10:29 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fa18088594so24327a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 11:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739387429; x=1739992229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTdJW6GgHtWVhH3eGixDH48CqccwWzgyOH/QGxX/OZs=;
 b=hrZTn7G3J6S3ZJmu1tPy1P4Tyc1npytd0KW3GGPUM1+xsi3YHWqqMMegwRwXRBdIYL
 +RW4UIMvk6I0UvoTfzj2mYpiP6ZAmLyKnY44/lqALsp0sFQhWOsW4Ac1mCKVVQ1DAlhJ
 eYZlKI3GMUxgqeD/b/9Ez2ZDl9KfIVOUEf+lKFpRSqPqL8+eOBSZP6xngvDhdnKwIL7k
 fhxDqJMdhWSKg+klz2tKnCV9VzoWvN1FB5ke56a9IgyJPbqR/4YNIy8jRBfYHg5uScqH
 lE6IGXzRruXTvegUxdfs08L0x3GQGusGtgyHRS9/ok6CKmzixNSLPlFfLsJLBdUqrEac
 iv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739387429; x=1739992229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTdJW6GgHtWVhH3eGixDH48CqccwWzgyOH/QGxX/OZs=;
 b=h8hb1yXIzTVR0tFUPbxMeVIhDTvONdBd8oPr5H+R6Wg+TiRpyJVoppyqVIr5EthysH
 surfhMNeqVTQvMd+x++TPStMYgz6SQ5BEOKzZqlpVMII4+N0t+3tfT0D+dqDKaOffFxF
 7JiAnKRH6xmSh35+RxzWjl+6jGMfC/K97VhZpLSqbIAg2xPVN9DN5efOBngIWRwRedJz
 0EJbybV7evrqNCiy1k5ICH+paDwd+ZZXvtmkpjW7GBtnVokRILdLScroEbFACEu0/5NG
 v4xwgfnv77nxU51BnqSjMuH4QxgM7T9SVy+ckjtRn2oRS/t7Xa3JK842IelUrhhCc3Fg
 9anA==
X-Gm-Message-State: AOJu0YzloYiyumGYJ8D/NpHmFUEy501bhu9uIj4laJuE/hD5nz6ZwIQs
 7TwA9zAqXuZkFY46CCdg6cJBerFzXelv5pDFwXNExCB/4vU4gdErA7eGKVA/Q/Mp6QGylzdnfsT
 1uFGmDpjhcI+o7X4ZhJ6gem2NpIYPsg==
X-Gm-Gg: ASbGncslxt/DIflC3DFUmjKX08f2MzXsOL6dyS7V6ebJ0/4T/zWm2Dqh+xmevQbshEW
 rd5PxwapDmYQnT5uVwPIWcoKayc4nD5UC33djGw7QDEfheT/5Yz9NR5RmS6XR6xhz7nvNfezW
X-Google-Smtp-Source: AGHT+IFVsHGeaocHnTbxrJiX/jLELgfeWZ/M9LxDcCCJj7OHzBYupVaX9e7kIrZPygYM8gWP/RIUeskizGMjRvrqwFc=
X-Received: by 2002:a17:90b:4f8b:b0:2ee:6a70:c5d1 with SMTP id
 98e67ed59e1d1-2fbf5c64c71mr2523764a91.3.1739387429109; Wed, 12 Feb 2025
 11:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20250212042321.1612148-1-candice.li@amd.com>
In-Reply-To: <20250212042321.1612148-1-candice.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2025 14:10:17 -0500
X-Gm-Features: AWEUYZnSpmtEBUnZHFl_k-YEImtL3DP749NOU2eNlHyS09PExX8qT7YF79sHGUo
Message-ID: <CADnq5_O34zqgkTbU-U8x8n58kgVy7Zs2fmoL-vbRnEjPyU0HQw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Optimize the enablement of GECC
To: Candice Li <candice.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, Feb 11, 2025 at 11:42=E2=80=AFPM Candice Li <candice.li@amd.com> wr=
ote:
>
> Enable GECC only when the default memory ECC mode or
> the module parameter amdgpu_ras_enable is activated.
>
> Signed-off-by: Candice Li <candice.li@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 18 +++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 31 ++++++++++---------
>  3 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index c03a586eb5a26f..7f84cc66a19b34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1167,6 +1167,7 @@ struct amdgpu_device {
>         struct ratelimit_state          throttling_logging_rs;
>         uint32_t                        ras_hw_enabled;
>         uint32_t                        ras_enabled;
> +       bool                            ras_default_ecc_enabled;
>
>         bool                            no_hw_access;
>         struct pci_saved_state          *pci_state;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index f873dd3cae1606..eb015bdda8a749 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -549,9 +549,10 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct am=
dgpu_device *adev)
>         u16 data_offset, size;
>         union umc_info *umc_info;
>         u8 frev, crev;
> -       bool ecc_default_enabled =3D false;
> +       bool mem_ecc_enabled =3D false;
>         u8 umc_config;
>         u32 umc_config1;
> +       adev->ras_default_ecc_enabled =3D false;
>
>         index =3D get_index_into_master_table(atom_master_list_of_data_ta=
bles_v2_1,
>                         umc_info);
> @@ -563,20 +564,22 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct a=
mdgpu_device *adev)
>                         switch (crev) {
>                         case 1:
>                                 umc_config =3D le32_to_cpu(umc_info->v31.=
umc_config);
> -                               ecc_default_enabled =3D
> +                               mem_ecc_enabled =3D
>                                         (umc_config & UMC_CONFIG__DEFAULT=
_MEM_ECC_ENABLE) ? true : false;
>                                 break;
>                         case 2:
>                                 umc_config =3D le32_to_cpu(umc_info->v32.=
umc_config);
> -                               ecc_default_enabled =3D
> +                               mem_ecc_enabled =3D
>                                         (umc_config & UMC_CONFIG__DEFAULT=
_MEM_ECC_ENABLE) ? true : false;
>                                 break;
>                         case 3:
>                                 umc_config =3D le32_to_cpu(umc_info->v33.=
umc_config);
>                                 umc_config1 =3D le32_to_cpu(umc_info->v33=
.umc_config1);
> -                               ecc_default_enabled =3D
> +                               mem_ecc_enabled =3D
>                                         ((umc_config & UMC_CONFIG__DEFAUL=
T_MEM_ECC_ENABLE) ||
>                                          (umc_config1 & UMC_CONFIG1__ENAB=
LE_ECC_CAPABLE)) ? true : false;
> +                               adev->ras_default_ecc_enabled =3D
> +                                       (umc_config & UMC_CONFIG__DEFAULT=
_MEM_ECC_ENABLE) ? true : false;
>                                 break;
>                         default:
>                                 /* unsupported crev */
> @@ -585,9 +588,12 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct am=
dgpu_device *adev)
>                 } else if (frev =3D=3D 4) {
>                         switch (crev) {
>                         case 0:
> +                               umc_config =3D le32_to_cpu(umc_info->v40.=
umc_config);
>                                 umc_config1 =3D le32_to_cpu(umc_info->v40=
.umc_config1);
> -                               ecc_default_enabled =3D
> +                               mem_ecc_enabled =3D
>                                         (umc_config1 & UMC_CONFIG1__ENABL=
E_ECC_CAPABLE) ? true : false;
> +                               adev->ras_default_ecc_enabled =3D
> +                                       (umc_config & UMC_CONFIG__DEFAULT=
_MEM_ECC_ENABLE) ? true : false;
>                                 break;
>                         default:
>                                 /* unsupported crev */
> @@ -599,7 +605,7 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amd=
gpu_device *adev)
>                 }
>         }
>
> -       return ecc_default_enabled;
> +       return mem_ecc_enabled;
>  }
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 196b8dbffc2e28..06f6bbdc7f5e9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1794,7 +1794,22 @@ int psp_ras_initialize(struct psp_context *psp)
>                 if (ret)
>                         dev_warn(adev->dev, "PSP get boot config failed\n=
");
>
> -               if (!amdgpu_ras_is_supported(psp->adev, AMDGPU_RAS_BLOCK_=
_UMC)) {
> +               if ((adev->ras_default_ecc_enabled || amdgpu_ras_enable =
=3D=3D 1) &&
> +                   amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))=
 {
> +                       if (boot_cfg =3D=3D 1) {
> +                               dev_info(adev->dev, "GECC is enabled\n");
> +                       } else {
> +                               /* enable GECC in next boot cycle if it i=
s disabled
> +                                * in boot config, or force enable GECC i=
f failed to
> +                                * get boot configuration
> +                                */
> +                               ret =3D psp_boot_config_set(adev, BOOT_CO=
NFIG_GECC);
> +                               if (ret)
> +                                       dev_warn(adev->dev, "PSP set boot=
 config failed\n");
> +                               else
> +                                       dev_warn(adev->dev, "GECC will be=
 enabled in next boot cycle\n");
> +                       }
> +               } else {
>                         if (!boot_cfg) {
>                                 dev_info(adev->dev, "GECC is disabled\n")=
;
>                         } else {
> @@ -1809,20 +1824,6 @@ int psp_ras_initialize(struct psp_context *psp)
>                                 else
>                                         dev_warn(adev->dev, "GECC will be=
 disabled in next boot cycle if set amdgpu_ras_enable and/or amdgpu_ras_mas=
k to 0x0\n");
>                         }
> -               } else {
> -                       if (boot_cfg =3D=3D 1) {
> -                               dev_info(adev->dev, "GECC is enabled\n");
> -                       } else {
> -                               /* enable GECC in next boot cycle if it i=
s disabled
> -                                * in boot config, or force enable GECC i=
f failed to
> -                                * get boot configuration
> -                                */
> -                               ret =3D psp_boot_config_set(adev, BOOT_CO=
NFIG_GECC);
> -                               if (ret)
> -                                       dev_warn(adev->dev, "PSP set boot=
 config failed\n");
> -                               else
> -                                       dev_warn(adev->dev, "GECC will be=
 enabled in next boot cycle\n");
> -                       }
>                 }
>         }
>
> --
> 2.25.1
>
