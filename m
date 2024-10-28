Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31A2D5B144
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 20:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5374610E567;
	Mon, 28 Oct 2024 20:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wzl0iqnM";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B488F10E567
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 20:22:46 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-71e4eb91228so334068b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730146966; x=1730751766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCsaKQO5AckK9CwC1ps8Y3IVAg7K6kKIX1ghA2kHwEg=;
 b=Wzl0iqnMnS2A/OOemzLpoJjDqwkdRzZG1uPL31QdnQldJiuPSorGkjdB+ZW2vJLEDT
 e8koOZ6CCIsDXStsluNcU3hyMkbElnu5n5dxWkosnLyO3G5cQKu8yiHPKA4ckVdoq/ax
 4ixaEvsO/ftHRfNk5Bm7QvQU5AoGtzvCIIUAizbsh/KxgYuDnwSmoGg0w4L5aRpkXjNA
 xwBYiRx06G9CyCSOI+lgX0rlWoZu+wj8itfenk8y5+xjG1SkLqH47u92D7vkfG09D37S
 b/OQiitKvrZLxkk4PHtd6yKozEXD0ex0DXHDSkuv+gJdwjA58DrblF8gcZnCERInHIWw
 hu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730146966; x=1730751766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eCsaKQO5AckK9CwC1ps8Y3IVAg7K6kKIX1ghA2kHwEg=;
 b=HcNCfYZ5NNDt3YodDu6dfKTvVvRYmFfo/Cl8bgix6HK6vZasrVxvKoqkKn3Z2YBhr8
 hL8Hn03K3QHMBeGuUMgnvlLCcEku6cx6WdefoEEqSqaotTjyt88lCn1tRTOmw/hfwXmd
 U/hQnm/bgcBTv7bg3BtiebgYNTaSZzGActvNIiI31VXaIK9XD63XbMiu7kNqRp9ROEgW
 Cm4Q4geNOb07Ir563HL//R54xn5mDKeGTCmR9cxunITbGJHd6Q/xVowELq1zOCTjsqMW
 AK3qUAfWifcQB+boykob8BBGlF4EfXn2Q7lg4nRwkHTaaR0cCgwPMSI7403fERjmHItK
 DqPw==
X-Gm-Message-State: AOJu0Yxt43UlqgXwbwdnut88IvbX8+6lhN+e2DXA3t4POX1OPVp6VIdC
 CDmX4iDPJhKf3AQnRFGEWarPZQAYTRfhR2s4oatpkSgtZmFPqhGSe5SoP8WugQMADqqBpYH3CTs
 bUIStewWS1jjtVD2vFGlySrZbqSBh0w==
X-Google-Smtp-Source: AGHT+IFe441UYRBfX6dtdF1Hx14za6stKIxPD7/2UjTUAe3xB5owLkvebFy4OAUmuH5Od77HwZREN8AZ6XdhqlvzJJ8=
X-Received: by 2002:a05:6a00:2392:b0:71e:7bcc:a0de with SMTP id
 d2e1a72fcca58-72063028f5cmr5611448b3a.3.1730146966025; Mon, 28 Oct 2024
 13:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241024140331.398-1-shashank.sharma@amd.com>
In-Reply-To: <20241024140331.398-1-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 16:22:34 -0400
Message-ID: <CADnq5_PcpfybL0wBD9PWhH-o=owFF0PBWTGSP1H7cGnBYCymdA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: add new AMDGPU_INFO subquery for fw objects
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
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

On Thu, Oct 24, 2024 at 10:04=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> Currently, the shadow FW space size and alignment information is
> protected under a flag (adev->gfx.cp_gfx_shadow) which gets set
> only in case of SRIOV setups.
> if (amdgpu_sriov_vf(adev))
>         adev->gfx.cp_gfx_shadow =3D true;
>
> But we need this information for GFX Userqueues, so that user can
> create these objects while creating userqueue. This patch series
> creates a method to get this information bypassing the dependency
> on this check.
>
> This patch:
>  - adds a new subquery (AMDGPU_INFO_FW_OBJ_SZ) in
>    AMDGPU_INFO_IOCTL to get the size and alignment of shadow
>    and csa objects from the FW setup.
>  - adds a new input parameter flag to the gfx.funcs->get_gfx_shadow_info
>    fptr definition, so that it can accommodate the information without th=
e
>    check (adev->gfx.cp_gfx_shadow) on request.
>  - updates the existing definition of amdgpu_gfx_get_gfx_shadow_info to
>    adjust with this new flag.
>
> V2: Added Alex's suggestions and addressed review comments:
>     - make this query IP specific (GFX/SDMA etc)
>     - give a better title (AMDGPU_INFO_UQ_METADATA)
>     - restructured the code as per sample code shared by Alex
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 30 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 19 +++++++++++-----
>  include/uapi/drm/amdgpu_drm.h           | 24 ++++++++++++++++++++
>  4 files changed, 70 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index f710178a21bc..efea172c41b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -302,7 +302,8 @@ struct amdgpu_gfx_funcs {
>         void (*init_spm_golden)(struct amdgpu_device *adev);
>         void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enab=
le);
>         int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
> -                                  struct amdgpu_gfx_shadow_info *shadow_=
info);
> +                                  struct amdgpu_gfx_shadow_info *shadow_=
info,
> +                                  bool skip_check);
>         enum amdgpu_gfx_partition
>                         (*query_partition_mode)(struct amdgpu_device *ade=
v);
>         int (*switch_partition_mode)(struct amdgpu_device *adev,
> @@ -491,7 +492,7 @@ struct amdgpu_gfx_ras_mem_id_entry {
>  #define amdgpu_gfx_select_se_sh(adev, se, sh, instance, xcc_id) ((adev)-=
>gfx.funcs->select_se_sh((adev), (se), (sh), (instance), (xcc_id)))
>  #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid, xcc_id) ((a=
dev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid), (xcc_i=
d)))
>  #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_gol=
den((adev))
> -#define amdgpu_gfx_get_gfx_shadow_info(adev, si) ((adev)->gfx.funcs->get=
_gfx_shadow_info((adev), (si)))
> +#define amdgpu_gfx_get_gfx_shadow_info(adev, si) ((adev)->gfx.funcs->get=
_gfx_shadow_info((adev), (si), false))
>
>  /**
>   * amdgpu_gfx_create_bitmask - create a bitmask
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index b53c35992152..285149258882 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -371,6 +371,20 @@ static int amdgpu_firmware_info(struct drm_amdgpu_in=
fo_firmware *fw_info,
>         return 0;
>  }
>
> +static int amdgpu_userq_metadata_info_gfx(struct amdgpu_device *adev,
> +                            struct drm_amdgpu_info *info,
> +                            struct drm_amdgpu_info_uq_metadata_gfx *meta=
)
> +{
> +       int ret =3D -EOPNOTSUPP;
> +
> +       if (adev->gfx.funcs->get_gfx_shadow_info) {
> +               adev->gfx.funcs->get_gfx_shadow_info(adev, (struct amdgpu=
_gfx_shadow_info *)meta, true);
> +               ret =3D 0;
> +       }
> +
> +       return ret;
> +}
> +
>  static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>                              struct drm_amdgpu_info *info,
>                              struct drm_amdgpu_info_hw_ip *result)
> @@ -1282,6 +1296,22 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>                 return copy_to_user(out, &gpuvm_fault,
>                                     min((size_t)size, sizeof(gpuvm_fault)=
)) ? -EFAULT : 0;
>         }
> +       case AMDGPU_INFO_UQ_METADATA: {
> +               struct drm_amdgpu_info_uq_metadata meta_info =3D {};
> +
> +               switch (info->query_hw_ip.type) {
> +               case AMDGPU_HW_IP_GFX:
> +                       ret =3D amdgpu_userq_metadata_info_gfx(adev, info=
, &meta_info.gfx);
> +                       if (ret)
> +                               return ret;
> +
> +                       ret =3D copy_to_user(out, &meta_info,
> +                                               min((size_t)size, sizeof(=
meta_info))) ? -EFAULT : 0;
> +                       return 0;
> +               default:
> +                       return -ENOTSUPP;
> +               }
> +       }
>         default:
>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 1d5c873876f5..e5f5de8804b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1034,14 +1034,21 @@ static void gfx_v11_0_select_me_pipe_q(struct amd=
gpu_device *adev,
>  #define MQD_FWWORKAREA_SIZE       484
>  #define MQD_FWWORKAREA_ALIGNMENT  256
>
> -static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
> +static void gfx_v11_0_get_gfx_shadow_info_nocheck(struct amdgpu_device *=
adev,
>                                          struct amdgpu_gfx_shadow_info *s=
hadow_info)
>  {
> -       if (adev->gfx.cp_gfx_shadow) {
> -               shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
> -               shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNME=
NT;
> -               shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
> -               shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> +       shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
> +       shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNMENT;
> +       shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
> +       shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> +}
> +
> +static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
> +                                        struct amdgpu_gfx_shadow_info *s=
hadow_info,
> +                                        bool skip_check)
> +{
> +       if (adev->gfx.cp_gfx_shadow || skip_check) {
> +               gfx_v11_0_get_gfx_shadow_info_nocheck(adev, shadow_info);
>                 return 0;
>         } else {
>                 memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_in=
fo));
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index d9bff1c3b326..eda9b4cfdff6 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1052,6 +1052,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_MAX_IBS                    0x22
>  /* query last page fault info */
>  #define AMDGPU_INFO_GPUVM_FAULT                        0x23
> +/* query FW object size and alignment */
> +#define AMDGPU_INFO_UQ_METADATA                        0x24
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> @@ -1123,6 +1125,11 @@ struct drm_amdgpu_info {
>                 struct {
>                         __u32 type;
>                 } video_cap;
> +
> +               struct {
> +                       /** AMDGPU_HW_IP_* */
> +                       __u32 type;
> +               } uq_metadata;
>         };
>  };
>
> @@ -1391,6 +1398,23 @@ struct drm_amdgpu_info_gpuvm_fault {
>         __u32 vmhub;
>  };
>
> +struct drm_amdgpu_info_uq_metadata_gfx {
> +       /* shadow area size for gfx11 */
> +       __u32 shadow_size;
> +       /* shadow area base virtual alignment for gfx11 */
> +       __u32 shadow_alignment;
> +       /* context save area size for gfx11 */
> +       __u32 csa_size;
> +       /* context save area base virtual alignment for gfx11 */
> +       __u32 csa_alignment;
> +};
> +
> +struct drm_amdgpu_info_uq_metadata {
> +       union {
> +               struct drm_amdgpu_info_uq_metadata_gfx gfx;
> +       };
> +};
> +
>  /*
>   * Supported GPU families
>   */
> --
> 2.46.2
>
