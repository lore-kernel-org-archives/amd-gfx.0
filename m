Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A2CD3424
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 13:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4535F10F505;
	Fri,  1 May 2026 13:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h8DJo5ee";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924A910F505
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 13:37:14 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2e92c54ba73so200157eec.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2026 06:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777642634; cv=none;
 d=google.com; s=arc-20240605;
 b=IvkcK9ouPRJpfEQkCAz9bwfa5jXn5a5PmMUJQNwgb6HGHZtaoIOqwVEt/hoFzSEbNI
 Dc3TO5sEyhaD1DFzO6jHTuEBf+aqJOQvQksGDxsnqACgctKdbIsY9HhJhYiQymAchWT+
 3It+JioX3RMBrMTUoF2hhTWBBC9CvRSt5yQ4APCk5QuQfaD/WE13K0rJHe+S74hUYHpf
 hUorfwc/OQAWjvIx/8CdSCAUnthPlp+AQirDb8W4yvzkr8TDr/aKU5q6rxU/ypvH6NCS
 oKxg01E+35j1poJ6oHhpHDZ30OZavF5HTIOonYSjsFEHtg+lqA6kMaZSVe+g/3y03AMQ
 NX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JcGJEYGRyaenVe9JUojvSfexc7x7TjNoYVQggMlGsnI=;
 fh=19QAqTxX756y5kTrENek2GMBPRLEoClE7zvNeW5VJQQ=;
 b=GccShDyS9sZslbTRrQPBgADhoyVYuK3mVQ54+uBkekDq8284hrgYw2D+5GHXXXcEfT
 LoKrRsbA4Fli/JV+50YrO+ZIVLRzGfxVe0wK88Wu+7TDIeNBb1ZRkZgEmH7qq9TGYxrB
 lC6ORLeOqRWi+U+XA1lJYv+IK0ToHy8Kuqc2Y+xtKOj43lMaHY3BukEIJotsBP8dan8S
 Gf+lQiJt+xA+th+hNGw27N+7br3hyNGubJSasVRDRTAa7CNwWiCWZzKTMh6/1yMu+nSi
 1VWOFF6kZoILR6uKZj1FfRoqxx0lirwqZLLH/LfuvL37Zd0gBGFtjuQqsTPnp3eR5BiC
 M3eA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777642634; x=1778247434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcGJEYGRyaenVe9JUojvSfexc7x7TjNoYVQggMlGsnI=;
 b=h8DJo5eeWBGtCzCWMWioGwFi3M9gi2fKDA69i2zJSb0nGeULhr+9ilm2FtI0ybUf1b
 n60sFPQGqGYvPirBVAd1ee2YqIbC/OyCDWD9pipnVRZIsSPawZI+nRHLVJ0phVOvcdaH
 SeIYC8FZBV9TMAgKOx2s9nW0CXnkOROyolwsYbYj6ZxoX3DOLuugtD3rHyU4YTxpDSEi
 nn7OtY/YIkqUbE9vHcvV9dIIB4Cqi/ohGshKTjIbywe3PDLVQg2Oa3ZcaiiLE4GdIcbS
 QH5nQZMTZ1mHdWItMe13xIuwohfjBF7cghXOmtv1XFktyBXKSn4sQHu4s5rNpZEI+wFp
 J/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777642634; x=1778247434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JcGJEYGRyaenVe9JUojvSfexc7x7TjNoYVQggMlGsnI=;
 b=CXnqbbjLdRVGYrlvZO0nTT2f16G37ytn583q/xI7VAjxDl+QOitg5YODQfnSueXKP/
 16KdcOkveaZQvLnKOmlLXwvVixllvGAK0g5Taep3aNam6nHoOr3cwaRm+N0QNauaygtV
 IDOfWowhQrHbqjJM03FDl5oHaX1d/Gbtw2czUxXrYtba/qg7+0ayWRx3P/LzpNFBcTAB
 hDJmhs6IWYgXjcOFU2Vz095aJzkAoprK/ugw1lv1tncBG2NVpAJ/s12Ig5T3fzlsTX6P
 YhzeQJXBBHJOVvDc1Oqm9Zv7PhyQbevADC9L8pKxAeeQa3lZVd/S02g4qVXCjkmeDLW4
 kdlQ==
X-Gm-Message-State: AOJu0Yy4QnebZ4BU6SbX0wrSzt6ucZUXAWayrQBoEeI25BAgTyPl2amH
 sD+zq69fsa7PpVRLKJn8gd7VYlYhsKF5s7ceaCP/4Ead0KLgQGSR2v6IHbr7/5YLZlb8sLqtfd5
 8jpsmATZnoHh8zYUPqlDXDfYnOinKKwU=
X-Gm-Gg: AeBDietxsUVHlmRbRWvEIFookVhAQIAGCLAHaYLmGTs7StNiUNN4xpxWLOCp6Rs6yhL
 dMUhjsdG24yJldBKRO9hicSg0xMB72arPEmfw+4+WlLZp/QXQpRLE8Z77QZmHDRv0s6nnvOVxAx
 6K1tY3phKZZLMjSKDfQAifpGnKuRNKr8+6aPLW8SiCE5jTs4aehsgc8qdd1G5PTsdJoA0G+H8UA
 I2otY2ijQ+Yhbaj5YV/34Dd6fLn2LsSYuauzcDBvONT8HWSfHSufF9XaNPxrNiRejZBusKiuc3O
 YNTRhQRy3B3EDbf0Wc1OyOdIRvRsPsE0HUs5+MzoXL+IimM/VnhMVb91M6ZT2BuQnkif39Y20AH
 baKqL
X-Received: by 2002:a05:7022:92c:b0:12b:f899:7178 with SMTP id
 a92af1059eb24-12dead457fdmr1468357c88.7.1777642633720; Fri, 01 May 2026
 06:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
 <20260430161146.2851078-6-Jesse.Zhang@amd.com>
In-Reply-To: <20260430161146.2851078-6-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 May 2026 09:37:02 -0400
X-Gm-Features: AVHnY4LMeSqaA9q2sJcGp8RbI7URB5ENQkzHiUJzp1EfFJFcdL-6IOOl4hswUPA
Message-ID: <CADnq5_NF0=PjsFXbqU9C5fVjLgtLpSa1tkso9Z7d_D9SL7VHGQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] drm/amdgpu: add AMDGPU_INFO_DOORBELL
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>
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

On Thu, Apr 30, 2026 at 12:29=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
>
> Use it to get the doorbell range and aggregated doorbell enablement
> and offset.  This patch only supports VCN for now.
>
> V2 - drop VPE and use vcn.agdb_offset saved in
>      umsch_mm_agdb_index_init() (suggested by Alex)
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>  include/uapi/drm/amdgpu_drm.h           | 13 +++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index d88e4994c8c1..a3beeff800bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1425,6 +1425,24 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>                         return -EINVAL;
>                 }
>         }
> +       case AMDGPU_INFO_DOORBELL: {
> +               struct drm_amdgpu_info_doorbell doorbell_info =3D {};
> +               /* note: may need to check asic_type */
> +               switch (info->query_hw_ip.type) {
> +               case AMDGPU_HW_IP_VCN_ENC:
> +                       if (adev->agdb_bo) {

I think this IOCTL should return an error adev->agdb_bo is NULL.  We
probably also need a per-IP flag to determine if the aggregated
doorbell is required or not.  That way we can easily support other IP
versions that may not require the aggregated doorbell.

> +                               doorbell_info.agdb_enable =3D 1;
> +                               doorbell_info.agdb_offset =3D adev->vcn.a=
gdb_offset;
> +                       }
> +                       doorbell_info.index_start =3D adev->doorbell_inde=
x.vcn.vcn_ring0_1 << 1;
> +                       doorbell_info.index_end =3D (adev->doorbell_index=
.vcn.vcn_ring6_7 << 1) + 1;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +               return copy_to_user(out, &doorbell_info,
> +                                   min((size_t)size, sizeof(doorbell_inf=
o))) ? -EFAULT : 0;
> +       }
>         default:
>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 82624b44e661..f07920594295 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -368,6 +368,7 @@ struct amdgpu_vcn {
>         struct mutex            workload_profile_mutex;
>         u32 reg_count;
>         const struct amdgpu_hwip_reg_entry *reg_list;
> +       uint32_t                agdb_offset;
>  };
>
>  struct amdgpu_fw_shared_rb_ptrs_struct {
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 062ae4741fd6..3ffdd2f8c418 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h

I'd split this part out as a separate patch.

Alex

> @@ -1276,6 +1276,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_GPUVM_FAULT                        0x23
>  /* query FW object size and alignment */
>  #define AMDGPU_INFO_UQ_FW_AREAS                        0x24
> +/* query doorbell info */
> +#define AMDGPU_INFO_DOORBELL                   0x25
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> @@ -1677,6 +1679,17 @@ struct drm_amdgpu_info_uq_metadata {
>  #define AMDGPU_FAMILY_GC_11_5_4                        154 /* GC 11.5.4 =
*/
>  #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 =
*/
>
> +/* for AMDGPU_INFO_DOORBELL query */
> +struct drm_amdgpu_info_doorbell {
> +       __u32 index_start;
> +       /* could be equal to index_start */
> +       __u32 index_end;
> +       /* aggregated doorbell, 0 for disable */
> +       __u32 agdb_enable;
> +       /* if agdb_enable, it is a value in [index_start, index_end] */
> +       __u32 agdb_offset;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> --
> 2.49.0
>
