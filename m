Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2C1606A327
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NXd4z6KD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C377F10E161;
	Mon, 26 Oct 2026 18:37:37 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768B210E161
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 18:37:31 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-15943c9be84so165274c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 11:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793039851; cv=none;
 d=google.com; s=arc-20260327;
 b=Wt7aZxW4UFURWjqtq6sWbGfnHgjVEKtiuF5ILxN+0wT++9nUgF0zutcxyaX7rsidnx
 zriq2uqQ9aow1BaqBtxX3JVMsEtYLhV/vHXW0f3RIr0c9wmEwhPeJlQ6ZTxgHfJeGuhu
 VY8sLM3U2Iq7riGmAVTH5uvQJurmzMbu2qfPBkbmc6mxwe/dB6ZWZ5ENawEFcltp6NbH
 YBTREow9ophqOY5gm6WoHKaniELoLqdmuCUpB7tsDkKYLlDlM65iJL8/WcbBlsAd1Tz+
 ptfWUjGDzy0nknSNU7UpZC5Fw+VCuwtBXpelYCQ05CH/z8I/qnuYNv5FKJKUkZEQhiQn
 3Uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bcgLXrUlnHpOFqiHdgBQ3icz8rvLrw5Gs+pVzMlm6b8=;
 fh=9/TMgaKTKqsWtPh2xnFpGLWe9nKpK0i7PlzvbkIbs/Q=;
 b=qJHcig7kA8jEa6n7r1XzFOyaAPnuEt2XemskbJcSWg0MGmZ/7w8LBSA51pb8LKVJGr
 7HnZzDR/fNe4GAHss6wH3cGQVZxEO9PurYXLwUvDVQ6fVdDJEr28//nCgReGGAYdGRs8
 TFe1/TGWphKpv49stzHU/hrq4tXaTFbCoNv/dMIPMJKGZ2ELa8GbZLxy+HcS9Ti5nuFE
 pXbIAoPF9mt4oyx3/Q4OtMhMRdVHANsqTKPVGDJhGjXYwceY5OGdCZskLqP+Nvb7Uw1e
 /GFw7cgsQAj87S18q2UZe16aY/6dNgh09OSWXMdbrVDPBOi1avdmFvV8VJaI1wUXQJO5
 hXIw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793039851; x=1793644651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bcgLXrUlnHpOFqiHdgBQ3icz8rvLrw5Gs+pVzMlm6b8=;
 b=NXd4z6KDb+A1gUvEPlSlWbjbPlXJBEFYkadFbZCIjcN9zuH8h5gLa/qRMNqeiePI7N
 /Defi7/KRXXhTLRoBuy8t6GAZKIRXJXA63rXqaG3uBAmt4ClwMhK7UoDHRm0XlbRLeqC
 X80N7YojvnQyq6cV+UFAr9CnKWHGh78gpGjI/FHhiws1XWbexZ5mTk/Sflax/NFN85Rs
 qH3qBhFrsLdD+fVupDhe50fzNsuHPhlwgnj90ZUxRvLdcctQre8KVPZB0COiKU7xBuu6
 Oq0FqBsrkUnhIrneiGeG25oF9MkZXspVlzioVmB0OGb0QMhKZSJKsPxkkKaStnsJHVNK
 avtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793039851; x=1793644651;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bcgLXrUlnHpOFqiHdgBQ3icz8rvLrw5Gs+pVzMlm6b8=;
 b=n/RuEyEmVMR/NjnRfpCgFXM54avoxjvGU4Aj22lRAmX60qYvVaIINgVHUKufhdfbGo
 OedewqiDHKoVKrfJOt7j0Fv5uUVIapEOoscqHYMY2oeXNtSXdcwlmrk4W0AsfrRgpYdp
 sjJgwTFREYOVWB5omezQ9P9UXy1hAJZ3WTRGSKGRC44KDhQnb1+BDP/T1QqFuPsmOyCU
 qUyOwV/gqWNkTISQ2bRrQSLHpXWpYicXCVk7iobJE/Qo9ArOBh7znoy7jIpR2J3v0SX/
 Isx38uZYp0jY6mj7WdS+5wrPUeE9DhylAFFPhxgssICHHAHdAj02248oHZ27NAmGax4U
 wVEQ==
X-Gm-Message-State: AFq9FYKoMpHPAgm5SEaWiqTiUOFwQhGoDhNOogeyNSfNWftW9bwG6MRa
 zFFuPk6Zwlr2ku6J9yfkZThZGP+/nwW9iTQ25gYOzs3hyjfsOCeLAhbBSF7qETzjJ+7vSRWP2cP
 rY7SElczBy7i/XPYtv9D/XIUvRGJMV3bb9For
X-Gm-Gg: AYBFou2Ze+060cWd7ZLJc0LA7xHSE0eH/vaC/JrtBL8SBr5QwsMadAMjwWFR7e569ov
 DtoK9t+puOjGH3GCFY4pmu6JpA7arpoOoJA0hhGXANz7rut7pSAlXgzK4LpwAAlOjCDrUtacrWD
 /0n8yEYfSwHwewMHFbYWOrsTSm7aCe8qdu5QcTrGXFnRrxh0KwZVxf5r7EtwHlacxL41Xevunsk
 8bXj/9M5yjbZ6/DrS5+3bJXM1fT0/62wTdlrvYQRSoR6st+UvtqoYK03eHxwFl6foeq1ebvG/g7
 0gRvIVDVE0J2L4i97eoF/rcDtijsBOse5nB7oDtzDupBeDrZ1p1R2EGPZeBCDYj+hjPrwyg93wj
 QK9PINTuTeJdjsOJFgFAgEFqg9B+zcEuRlnRpqPLP7pOkCXIJ93CjtpS5CSeOfx3tZsE8w+VCLt
 Vy/NquVmvC32v0LVHT/CroHW8=
X-Received: by 2002:a05:7022:7e0e:b0:183:d275:cf76 with SMTP id
 a92af1059eb24-19934a9266cmr19122981c88.2.1793039850157; Mon, 26 Oct 2026
 11:37:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022161822.758057-1-siwei.he@amd.com>
In-Reply-To: <20261022161822.758057-1-siwei.he@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 14:37:18 -0400
X-Gm-Features: AclHuK-332uaeZEFy9GZutp0-cYL6rAi80Pbas10kAiFp9mXvfS1NblLP1-08lc
Message-ID: <CADnq5_PbtfK-UO_y2nRbqLzUZk=L_9agxwcksDBtYMs3R_UuuQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add AMDGPU_INFO_CU_BITMAP query for per-XCC
 CU masks
To: Siwei He <siwei.he@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, 
 harish.kasiviswanathan@amd.com, mukul.joshi@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 12:18=E2=80=AFPM Siwei He <siwei.he@amd.com> wrote:
>
> Add AMDGPU_INFO_CU_BITMAP, returning struct drm_amdgpu_info_cu_bitmap:
> a header carrying num_xcc, num_se, num_sa and xcc_mask, followed by a
> flexible array of num_xcc * num_se * num_sa active CU masks in un-folded
> [xcc][se][sa] order, indexed bitmap[(xcc * num_se + se) * num_sa + sa].
>

Please provide a link in the commit message to the proposed userspace
side which uses this new query.  Other than that, looks good to me.

Alex


> Signed-off-by: Siwei He <siwei.he@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 69 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 50 ++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           | 32 ++++++++++++
>  4 files changed, 153 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 0ae6e990c310..7a0a1d5542ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2050,6 +2050,75 @@ static ssize_t amdgpu_gfx_get_gfx_reset_mask(struc=
t device *dev,
>         return amdgpu_show_reset_mask(buf, adev->gfx.gfx_supported_reset)=
;
>  }
>
> +/**
> + * amdgpu_gfx_get_cu_bitmap - un-fold the active CU bitmap for a set of =
XCCs
> + *
> + * @adev: amdgpu_device pointer
> + * @inst_mask: mask of logical GC (XCC) instances to report
> + * @out: destination, filled in [xcc][se][sa] row-major order
> + * @max_entries: capacity of @out, in u32 entries
> + *
> + * XCCs are written in ascending set-bit order of @inst_mask, densely pa=
cked,
> + * so entry (xcc * num_se + se) * num_sa + sa holds shader array @sa of
> + * shader engine @se on the @xcc'th set bit of @inst_mask.
> + *
> + * Returns the number of XCCs written, or a negative error code.
> + */
> +int amdgpu_gfx_get_cu_bitmap(struct amdgpu_device *adev, u32 inst_mask,
> +                            u32 *out, u32 max_entries)
> +{
> +       struct amdgpu_gfx_config *config =3D &adev->gfx.config;
> +       u32 gc_version =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> +       u32 num_se, num_sa, sh_mul, se, sa, n =3D 0;
> +       int xcc;
> +
> +       /* cu_info.bitmap[] only has AMDGPU_MAX_GC_INSTANCES slots */
> +       inst_mask &=3D GENMASK(AMDGPU_MAX_GC_INSTANCES - 1, 0);
> +       if (!inst_mask)
> +               return -ENODEV;
> +
> +       num_se =3D config->max_shader_engines;
> +       num_sa =3D config->max_sh_per_se;
> +       if (!num_se || !num_sa)
> +               return -ENODEV;
> +
> +       if (hweight32(inst_mask) * num_se * num_sa > max_entries)
> +               return -EINVAL;
> +
> +       /* gfx11/gfx12_0 fold SE4-7 into shader array columns 2 and 3 */
> +       sh_mul =3D (gc_version >=3D IP_VERSION(11, 0, 0) &&
> +                 gc_version < IP_VERSION(13, 0, 0)) ? 2 : 1;
> +
> +       /*
> +        * cu_info.bitmap[] stores a [4][4] tile per XCC, and the IP back=
end
> +        * packed (se, sa) into it with the fold above. The row index se =
% 4 is
> +        * in range by construction; the column must both stay inside the=
 tile
> +        * and not alias another shader engine's slot. Shader engines 4 a=
part
> +        * share a row and are separated by sh_mul columns, so num_sa > s=
h_mul
> +        * overlaps them. A topology failing either test lost data when t=
he
> +        * backend wrote the tile, and un-folding cannot recover it -- fa=
il
> +        * rather than report some other slot's mask as this shader array=
's.
> +        */
> +       if ((num_se > 4 && num_sa > sh_mul) ||
> +           (num_sa - 1) + ((num_se - 1) / 4) * sh_mul > 3) {
> +               dev_warn_once(adev->dev,
> +                             "unsupported CU bitmap topology %u SE x %u =
SA\n",
> +                             num_se, num_sa);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       for_each_inst(xcc, inst_mask) {
> +               for (se =3D 0; se < num_se; se++)
> +                       for (sa =3D 0; sa < num_sa; sa++)
> +                               out[(n * num_se + se) * num_sa + sa] =3D
> +                                       adev->gfx.cu_info.bitmap[xcc]
> +                                               [se % 4][sa + (se / 4) * =
sh_mul];
> +               n++;
> +       }
> +
> +       return n;
> +}
> +
>  static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
>                                                 struct device_attribute *=
attr,
>                                                 char *buf)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 5939e1fb3b24..bd2617dd4c56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -663,6 +663,8 @@ int amdgpu_gfx_poison_consumption_handler(struct amdg=
pu_device *adev,
>  bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
>  int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
>  void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
> +int amdgpu_gfx_get_cu_bitmap(struct amdgpu_device *adev, u32 inst_mask,
> +                            u32 *out, u32 max_entries);
>  int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>                                  struct amdgpu_ring *ring,
>                                  struct amdgpu_fence *guilty_fence,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 14a72a406d37..a8ebc85c9b88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1453,6 +1453,56 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>                         return -EINVAL;
>                 }
>         }
> +       case AMDGPU_INFO_CU_BITMAP: {
> +               struct drm_amdgpu_info_cu_bitmap *cu_bitmap;
> +               u32 num_xcc, num_se, num_sa, nent;
> +               size_t sz;
> +
> +               fpriv =3D (struct amdgpu_fpriv *)filp->driver_priv;
> +
> +               /* scope the reply to the partition this fd was opened ag=
ainst */
> +               if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
> +                   fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
> +                       xcp =3D &adev->xcp_mgr->xcp[fpriv->xcp_id];
> +                       ret =3D amdgpu_xcp_get_inst_details(xcp, AMDGPU_X=
CP_GFX,
> +                                                         &inst_mask);
> +                       if (ret)
> +                               return ret;
> +               } else {
> +                       inst_mask =3D adev->gfx.xcc_mask ? adev->gfx.xcc_=
mask : 1;
> +               }
> +
> +               inst_mask &=3D GENMASK(AMDGPU_MAX_GC_INSTANCES - 1, 0);
> +               num_xcc =3D hweight32(inst_mask);
> +               num_se =3D adev->gfx.config.max_shader_engines;
> +               num_sa =3D adev->gfx.config.max_sh_per_se;
> +               if (!num_xcc || !num_se || !num_sa)
> +                       return -ENODEV;
> +
> +               nent =3D num_xcc * num_se * num_sa;
> +               sz =3D struct_size(cu_bitmap, bitmap, nent);
> +
> +               cu_bitmap =3D kzalloc(sz, GFP_KERNEL);
> +               if (!cu_bitmap)
> +                       return -ENOMEM;
> +
> +               ret =3D amdgpu_gfx_get_cu_bitmap(adev, inst_mask,
> +                                              cu_bitmap->bitmap, nent);
> +               if (ret < 0) {
> +                       kfree(cu_bitmap);
> +                       return ret;
> +               }
> +
> +               cu_bitmap->num_xcc =3D ret;
> +               cu_bitmap->num_se =3D num_se;
> +               cu_bitmap->num_sa =3D num_sa;
> +               cu_bitmap->xcc_mask =3D inst_mask;
> +
> +               ret =3D copy_to_user(out, cu_bitmap, min_t(size_t, size, =
sz)) ?
> +                             -EFAULT : 0;
> +               kfree(cu_bitmap);
> +               return ret;
> +       }
>         default:
>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>                 return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 29009f6aabde..b726dc511491 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1289,6 +1289,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_GPUVM_FAULT                        0x23
>  /* query FW object size and alignment */
>  #define AMDGPU_INFO_UQ_FW_AREAS                        0x24
> +/* query the full per-XCC active CU bitmap */
> +#define AMDGPU_INFO_CU_BITMAP                  0x25
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> @@ -1363,6 +1365,36 @@ struct drm_amdgpu_info {
>         };
>  };
>
> +/*
> + * Reply to AMDGPU_INFO_CU_BITMAP.
> + *
> + * Reports every XCC visible to the file descriptor in
> + * un-folded [xcc][se][sa] order.
> + *
> + * On a partitioned device the reply covers only the XCCs belonging to t=
he
> + * partition the file descriptor was opened against.
> + *
> + * The reply is variable length and carries no fixed topology limits. Qu=
ery it
> + * twice: first with return_size =3D sizeof(struct drm_amdgpu_info_cu_bi=
tmap) to
> + * read the counts, then with return_size large enough for the trailing =
array.
> + */
> +struct drm_amdgpu_info_cu_bitmap {
> +       /** number of XCC slices described by bitmap[] */
> +       __u32 num_xcc;
> +       /** number of shader engines per XCC */
> +       __u32 num_se;
> +       /** number of shader arrays per shader engine */
> +       __u32 num_sa;
> +       /** mask of logical XCC instances this reply describes */
> +       __u32 xcc_mask;
> +       /**
> +        * active CU mask per shader array, num_xcc * num_se * num_sa ent=
ries
> +        * in [xcc][se][sa] row-major order. Index as
> +        * bitmap[(xcc * num_se + se) * num_sa + sa].
> +        */
> +       __u32 bitmap[];
> +};
> +
>  struct drm_amdgpu_info_gds {
>         /** GDS GFX partition size */
>         __u32 gds_gfx_partition_size;
> --
> 2.43.0
>
