Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7D606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqoTYXwx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7813410E465;
	Mon, 16 Nov 2026 19:33:40 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7223610E465
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:33:34 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-85d6d6d855bso408398a34.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 11:33:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794857613; cv=none;
 d=google.com; s=arc-20260327;
 b=sHDGWfm0R5N6BGGAheB/I7v7i07wDcvLMyrGtG6x7xYOS7KSLj99Es7oG1RlDH2he9
 crj4yOnLokbHTfr2Qu056bFK0YrM4Prz93J4o7m493aOYKzjfuOPBd30A5YAKwpW0UlJ
 Ury2SozZpKL0WFuJ9E06hI3xlpDkGZvrmSJpSuEykMzXz4BNQ5R0LGE4USgfx8EExf/8
 U/knULqDisqeXtdsWZMwzAG0tIeKY8WmHhZmX9xX3eAuS7fEPw8owVzT/jjQjSa9s2B4
 Tpx3gsuVdP6DluFeu9wF2MQqb/AwQergdtRE87PVCVGET56+Z65MC8sqOAj4CmYacYUu
 FiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/F1LSYew9CC0YSzgWpTLRnPO7iccZNFuvHdMrfdnZ8s=;
 fh=hxQk/uZpkXs5H9xvSBgSM9HoyHLdZh6wDCcQc548gy4=;
 b=dT8imye2Bo6/wsHI3WJCQnbd7QqFuJJugb/E+DnFaJK5ciiK6FsFMLZnUGztYSsr6r
 hGNfAkn9Pq1rTCkvAiL0j7T6EL+uHBxapmYsyLCbmRsSxp3+wqDr6iWn+0j+NDrUlaC8
 brJzLbhdpalTvThwQ+X9qlY3ttcyVEF3mcDXxpJFCOmi6iapGoz8MBx8dMZ4uR2cPIP4
 7BroEmVWII5Yf8W0NQX1GzhRK/MrtB9ccAHNILRAOuLUje3fczORjB7K34JvZnJD+wbh
 c5LsTLRDw6mAr3MHhLr9fKhsLmHxSM+wDcXy4UQj7ka1XrPeuxc0chieaWaKhMNzJeOK
 U3Cw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794857613; x=1795462413; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/F1LSYew9CC0YSzgWpTLRnPO7iccZNFuvHdMrfdnZ8s=;
 b=hqoTYXwxh57Yeed2iwiIYKJXt4GPVzmLmXa82f06OJohKz03K2jhSi9EWmJA3Z5Uim
 eIt8mSKYg6imZslnBYavZYlfwGvJmwfAOaQv9Ssb829QW3bbNXOT8RuQ3Rb6m9nReKVX
 pUDkSxRbQOY3TFzc2jofwNGM56tKSYAM/pZEkeQrKQKTNmJoZQOQfrVe/h2L/2hUTNax
 wtkMfS6d59P9ub5uLvg+tXxyIBHA6bRDzO8EohfgB63/JVAPzi3ByXKzyXwB1ybrjsaJ
 H7j2QeUOyc9Cjxa8j+RTBEepe+eELXJgCMB2+n1GJZwQsT6+3N6PEwYPB9IwwFrditRm
 mpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794857613; x=1795462413;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/F1LSYew9CC0YSzgWpTLRnPO7iccZNFuvHdMrfdnZ8s=;
 b=u1d5vyh7Lb6XL03Aek2ukG37r+fuSnA0LCMYs1UdB44XZFFR6wXGUBcErYJX7WL8t3
 rSHvpmGQihgg0Yhqq/b62qLDSZigJ1Xza/wT897kuWy7oARLduEuvGPf4B0WDpz3SvxG
 rANo9DkGvHh0fbRRtcUfDE9ZErB6z8VZGul4o73ljcJ2qQ/O4dXD2TEb3KMzbwc5ywBN
 IvKLnd621uy24IG08POze7KGRN8Dn6XL9xnMTqLXhRSD5qH8cFzAkzy+fXJyPD7+PGvM
 OgxI0fG6TcPoGGhfaCelks7wXobaI/6m2QoWBOgiUny63Pjl/KPArVfcocLOQWWfgiDX
 pLvA==
X-Gm-Message-State: APuU4Z/i464xRAQcrYkYKERt07M5QkBvUqF65OzROKyLSlcNQ5gxtFmz
 HbMXePC9yM4xDyWaQEMweWrMCy7nDYh87uK9FXsEcsWavAjw34atUjo6T1iEsjsTYb4Ztysg8xy
 2CCgrMDHG0saGVqjZFGEWXg4VxMV8/7G0yA==
X-Gm-Gg: AYBFou0Jbn82PQ6Jwyfa59gyKzU/scyb/jE6AAewSl1rOkm1qQvx4j/mYdfixBAA+QC
 e58T3hICCoE3KkxJpTeJiij0nc7qEFU8+I2gjILBsqz+mbBfGjPoR5p/IhRrhPljYWIU78OIu0T
 ACQ0PnXX7WcaI5jFmh5FH97fWJQFCgieX5j5zUdBjp1XHnMzkLJzpZqeiLdUWEAhHdlrLUnFOq+
 82krJHgwVKNmC5fiKdYWydFrfxz6HinGPGF8rM9KSLFrxKY1puH1qH1UZjmTtlkAALO7JaFxHra
 ch/Vq8W054D6/SDiHhz+5qxp9onwwOtcOW2YTvRzJqSAN/r0bWixyIw5AwypdF09HIU0R9b22JL
 yOSMQqUk+xB2fMzwlLYZzwf3m2IoKMaTzXYLpzX09HZynp6ACMbis5ccVjN6lasNnBV2w+7rWck
 vgOsKZv7mou7IO8+hyjoSTBxVEBzdyXVUPF4qZL+as8ZNB2NSjOrby32xlaMw=
X-Received: by 2002:a05:6809:8c:10b0:574:6f37:6720 with SMTP id
 5614622812f47-5746f3797aemr3363627b6e.2.1794857613085; Mon, 16 Nov 2026
 11:33:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116161310.3664509-1-siwei.he@amd.com>
In-Reply-To: <20261116161310.3664509-1-siwei.he@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2026 14:33:21 -0500
X-Gm-Features: AclHuK_OPv0vhJkOpjm3_Yj3Kafp4frh42XiuGFe27xHZL831sV_Bc9z_adsqUc
Message-ID: <CADnq5_OhEGn-Ec9F0cMA1WN0XX5zZk8fp=U=waXJT4-j61wr2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add AMDGPU_INFO_CU_BITMAP query for
 per-XCC CU masks
To: Siwei He <siwei.he@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, 
 harish.kasiviswanathan@amd.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 11:26=E2=80=AFAM Siwei He <siwei.he@amd.com> wrote:
>
> Add AMDGPU_INFO_CU_BITMAP, returning struct drm_amdgpu_info_cu_bitmap:
> a header carrying num_xcc, num_se, num_sa and xcc_mask, followed by a
> flexible array of num_xcc * num_se * num_sa active CU masks in un-folded
> [xcc][se][sa] order, indexed bitmap[(xcc * num_se + se) * num_sa + sa].

Please provide a link to the proposed userspace which will use this
new interface.

Alex

>
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
