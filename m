Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8F2CEFC33
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 17:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AC410E0DC;
	Tue,  8 Oct 2024 17:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jy3QTbu+";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33BDA10E0DC
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 17:05:34 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-20b0c5895aaso4071255ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Oct 2024 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728407133; x=1729011933; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qznj+iUsLWd6BuR1qO2nB/1MW40wu8wH1nwQHQgA+i4=;
 b=jy3QTbu+xE5ePVMTFQ/MHpD4iTqSVNdi1jexxAMU/AUVI30+hAbkqiqSye9mgLTLYQ
 Z15yVCVGLFghQB3E34LEnsqYySOwGUpUVpSZjxz3wXyXd/d4KRYcqguseVMVv9AcLSr5
 8EK8X/FPFgIvGdX4Ia3UwsirLiBnI9homM6IQNPQOGun9ITQdF4G2N8LnkfiB5HEUjR4
 QE/34C/nNAku00H0c41EbGKQNyRK608V+QTiq+RU0SBaZLMZi1fObRGcN4PqPltt9RGP
 67Uu3QBeP+CDwTH8V4mShUENlEH5zMtPJpVnGxs/hJTi/rbw7wYhL72QSMbDVpcRCmGw
 xYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728407133; x=1729011933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qznj+iUsLWd6BuR1qO2nB/1MW40wu8wH1nwQHQgA+i4=;
 b=UZvjcdSNHli3eJS3D8W/GrHMLksGxkAaFNoGieT4wfFpR2X1A00A9z/4d2QfG7ejGv
 +gQicGL8RFhuEmTPknIGOPKY7UMhV/Hxy7gyHTlIfc26YdjQr1NgomSKjLNzY9radFhC
 e3L3w2K/HxCLUIOwOX99A4XkeMHHaNSzC8fDLxiu5wJQ0EkWzi1ErQmpdY7IGE/ABe8W
 Rnk4AoeOacBdoFNdo2vm0+MMTEstBWK8/tX7c5UrWDATm1ycvkNp4j+hzc3Xe3E4Jgi3
 gU6Z42daJu4u+aJv07+YmqvMkD75mWMSwgD2LUJUhwLlVu3swpFz+u1B44V1/6siLpN6
 njGQ==
X-Gm-Message-State: AOJu0Yxu05lXdHLmlvgwbduCOeYgAxdbdax/VDdFSzE+jxi1vizCznMq
 4HLKh4qLM9e6ZG1WoaM6ms5WSatq++AIjHlzGQv2MKuPHDM82eHxk3q5oXAVUYTUH7tsmjeFGHC
 xYwfgeIGhwjYimVs302UgwA4Eb+k=
X-Google-Smtp-Source: AGHT+IGYMh33Xf/4yBfUk6njJbK9TVq++L7IrJOUqlpd9MIwTnochjjkkK7h8iIA2Pn92rhoILF1/v6am3a3WzVpKPA=
X-Received: by 2002:a17:903:32cc:b0:206:9f2e:1029 with SMTP id
 d9443c01a7336-20bfdf72cd1mr93815915ad.2.1728407133524; Tue, 08 Oct 2024
 10:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241008152929.734-1-shashank.sharma@amd.com>
In-Reply-To: <20241008152929.734-1-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Oct 2024 13:05:21 -0400
Message-ID: <CADnq5_OovcnNUk_9cXK3FFzagtY46BjDBSpbvz04eUu0S5t_=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add new AMDGPU_INFO subquery for fw objects
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Content-Type: multipart/mixed; boundary="00000000000038b1110623fa2525"
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

--00000000000038b1110623fa2525
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 11:30=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 19 +++++++++++++------
>  include/uapi/drm/amdgpu_drm.h           |  2 ++
>  4 files changed, 32 insertions(+), 8 deletions(-)
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
> index b53c35992152..8521b62cc136 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1282,6 +1282,20 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>                 return copy_to_user(out, &gpuvm_fault,
>                                     min((size_t)size, sizeof(gpuvm_fault)=
)) ? -EFAULT : 0;
>         }
> +       case AMDGPU_INFO_FW_OBJ_SZ: {
> +               struct amdgpu_gfx_shadow_info shadow_info;
> +
> +               memset(&shadow_info, 0, sizeof(shadow_info));
> +               if (adev->gfx.funcs->get_gfx_shadow_info) {
> +                       adev->gfx.funcs->get_gfx_shadow_info(adev, &shado=
w_info, true);
> +                       ret =3D copy_to_user(out, &shadow_info,
> +                                         min((size_t)size, sizeof(shadow=
_info))) ? -EFAULT : 0;
> +               } else {
> +                       ret =3D -EOPNOTSUPP;
> +               }
> +
> +               return ret;
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
> index d9bff1c3b326..ad35b41be250 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1052,6 +1052,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_MAX_IBS                    0x22
>  /* query last page fault info */
>  #define AMDGPU_INFO_GPUVM_FAULT                        0x23
> +/* query FW object size and alignment */
> +#define AMDGPU_INFO_FW_OBJ_SZ                  0x24

Maybe something like:
AMDGPU_INFO_UQ_METADATA to make it clearer what it's for.  Also I
think we want to make the input the IP type so we can extend this to
other IPs in the future if necessary.  We should also be explicit with
the output format so it's clear to userspace how to use the query.
Something like the attached patch.

Alex


>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> --
> 2.46.0
>

--00000000000038b1110623fa2525
Content-Type: text/x-patch; charset="US-ASCII"; name="uq_metadata.diff"
Content-Disposition: attachment; filename="uq_metadata.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m20oxq6h0>
X-Attachment-Id: f_m20oxq6h0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oIGIvaW5jbHVkZS91YXBp
L2RybS9hbWRncHVfZHJtLmgKaW5kZXggZWZlNWRlNmNlMjA4Li5mNjJiZTZmMzgwY2UgMTAwNjQ0
Ci0tLSBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCisrKyBiL2luY2x1ZGUvdWFwaS9k
cm0vYW1kZ3B1X2RybS5oCkBAIC05MjMsNiArOTIzLDggQEAgc3RydWN0IGRybV9hbWRncHVfY3Nf
Y2h1bmtfY3BfZ2Z4X3NoYWRvdyB7CiAjZGVmaW5lIEFNREdQVV9JTkZPX01BWF9JQlMJCQkweDIy
CiAvKiBxdWVyeSBsYXN0IHBhZ2UgZmF1bHQgaW5mbyAqLwogI2RlZmluZSBBTURHUFVfSU5GT19H
UFVWTV9GQVVMVAkJCTB4MjMKKy8qIHF1ZXJ5IHVzZXIgcXVldWUgbWV0YWRhdGEgKi8KKyNkZWZp
bmUgQU1ER1BVX0lORk9fR1BVVk1fRkFVTFQJCQkweDI0CiAKICNkZWZpbmUgQU1ER1BVX0lORk9f
TU1SX1NFX0lOREVYX1NISUZUCTAKICNkZWZpbmUgQU1ER1BVX0lORk9fTU1SX1NFX0lOREVYX01B
U0sJMHhmZgpAQCAtOTk0LDYgKzk5NiwxMSBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZvIHsKIAkJ
c3RydWN0IHsKIAkJCV9fdTMyIHR5cGU7CiAJCX0gdmlkZW9fY2FwOworCisJCXN0cnVjdCB7CisJ
CQkvKiogQU1ER1BVX0hXX0lQXyogKi8KKwkJCV9fdTMyIHR5cGU7CisJCX0gdXFfbWV0YWRhdGE7
CiAJfTsKIH07CiAKQEAgLTEyNjIsNiArMTI2OSwyMyBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZv
X2dwdXZtX2ZhdWx0IHsKIAlfX3UzMiB2bWh1YjsKIH07CiAKK3N0cnVjdCBkcm1fYW1kZ3B1X2lu
Zm9fdXFfbWV0YWRhdGFfZ2Z4IHsKKwkvKiBzaGFkb3cgYXJlYSBzaXplIGZvciBnZngxMSAqLwor
CV9fdTMyIHNoYWRvd19zaXplOworCS8qIHNoYWRvdyBhcmVhIGJhc2UgdmlydHVhbCBhbGlnbm1l
bnQgZm9yIGdmeDExICovCisJX191MzIgc2hhZG93X2FsaWdubWVudDsKKwkvKiBjb250ZXh0IHNh
dmUgYXJlYSBzaXplIGZvciBnZngxMSAqLworCV9fdTMyIGNzYV9zaXplOworCS8qIGNvbnRleHQg
c2F2ZSBhcmVhIGJhc2UgdmlydHVhbCBhbGlnbm1lbnQgZm9yIGdmeDExICovCisJX191MzIgY3Nh
X2FsaWdubWVudDsKK307CisKK3N0cnVjdCBkcm1fYW1kZ3B1X2luZm9fdXFfbWV0YWRhdGEgewor
CXVuaW9uIHsKKwkJc3RydWN0IGRybV9hbWRncHVfaW5mb191cV9tZXRhZGF0YV9nZnggZ2Z4Owor
CX07Cit9OworCiAvKgogICogU3VwcG9ydGVkIEdQVSBmYW1pbGllcwogICovCg==
--00000000000038b1110623fa2525--
