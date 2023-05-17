Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22D8C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 16:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A20B10E213;
	Wed, 17 May 2023 16:28:29 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723C310E213
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 16:28:27 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-39212bf4ff0so588536b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684340906; x=1686932906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WByKu/87Av4DhF2kuB/WtOYkKTvyNgwYpfZwIMk3dvc=;
 b=WOHnUSzmDRnFNC6aAcY/hEvHrdYOP16RLpibQB5/WeAs/2C6bO6F1FBXE6AQX+u+qn
 xYk8c8P2oDFkB+KTjTwOSJseZjJmIiyo12uNcgVohLhJr1mJnPqhCaZFSqOA5QjaG653
 XOiDtgzTLTIV8vRjdzQ6T1o9KAU9yPdWIrGAZ9+sSvHFxq6OpecXZeBghtxVBqtZo2RU
 KPp6+G1D0rz7PFaWyKLdmWs3docouMXWiI7II2yxxY93PvSVgxSUSY7O+auc0GcYXDPI
 DmMxbrFi5/IMFcfq6fDhu66an8J1306fOfboWSfQ96/ZW8ucxF7tA7SC9YGxGlOQY51U
 GOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684340906; x=1686932906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WByKu/87Av4DhF2kuB/WtOYkKTvyNgwYpfZwIMk3dvc=;
 b=Sqw2AqdcGbUx0PzdPoEYX5w2lk1G4x07deg45ZQIwf1vpW4HkGDSWPRvhjfmbuTChN
 Hj3onN0CD69Yg3IYK6Z+dZVaoYfdw4QX2mDYogSbFW+wKQJOK6WgPl0LldwDi+UN23Ni
 ULXIfL8i1LvqX6Fub3xgI0AUjYAoEIpjoJLW5xtAXiFfXhq8gpife480Zx78MrfoWHMM
 NtLQ1ikZ4kx1vmupFzKWp3gwHKSl/gciPBN8jJAdcqHAdLFz9O9Z7ZHuPHWcISs2emfu
 Z6A8eIh8ig/N4JYgAecHp6tJQ+YE/uvPLsnK+Kr2i1d+0vIdgqGvkMYpbi8PbALo2LNO
 ZO3w==
X-Gm-Message-State: AC+VfDytDGYEHHv5WufsHTWSBI0Zsl+eAUtxnIgRDTTfUAvqnXLbv3x6
 C85plQWu/M510CfGjIBDHcsV2xchnVKyBCljL+hkkFGt
X-Google-Smtp-Source: ACHHUZ7OzaaSCGWO3unsv3FcJvzFoCE3jpE1VqGaNCcivXj0x9/ksZi5ZeYjS23Yd4ODHsO6I1WzO+xLgP9Q0B8nsUI=
X-Received: by 2002:a54:4391:0:b0:395:f3ee:d191 with SMTP id
 u17-20020a544391000000b00395f3eed191mr6442251oiv.23.1684340905890; Wed, 17
 May 2023 09:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230517143130.3016720-1-alexander.deucher@amd.com>
 <BL3PR12MB64255F59A97B4E656F9CE387EE7E9@BL3PR12MB6425.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB64255F59A97B4E656F9CE387EE7E9@BL3PR12MB6425.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 May 2023 12:28:14 -0400
Message-ID: <CADnq5_PUqo6cPFA7ZMN=rMqDmy44YE8Ho55n_od=+uhh3APD_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 17, 2023 at 12:26=E2=80=AFPM Joshi, Mukul <Mukul.Joshi@amd.com>=
 wrote:
>
> [AMD Official Use Only - General]
>
>
> Hi Alex,
>
> ________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex D=
eucher <alexander.deucher@amd.com>
> Sent: Wednesday, May 17, 2023 10:31 AM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.=
Chen@amd.com>
> Subject: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> Rework logic or use do_div() to avoid problems on 32 bit.
>
> v2: add a missing case for XCP macro
>
> Acked-by: Guchun Chen <guchun.chen@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  9 ++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 11 ++++++-----
>  4 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 739eb7c0d133..fed545cdd1de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -794,3 +794,17 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *=
adev)
>  {
>         kgd2kfd_unlock_kfd();
>  }
> +
> +
> +u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id=
)
> +{
> +       u64 tmp;
> +
> +       if (adev->gmc.num_mem_partitions && xcp_id >=3D 0) {
> +               tmp =3D adev->gmc.mem_partitions[KFD_XCP_MEM_ID(adev, xcp=
_id)].size;
> +               do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
> +               return tmp;
> +       } else {
> +               return adev->gmc.real_vram_size;
> +       }
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.h
> index be43d71ba7ef..94cc456761e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -333,15 +333,14 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_d=
evice *adev,
>  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>                 uint64_t size, u32 alloc_flag, int8_t xcp_id);
>
> +u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id=
);
> +
>  #define KFD_XCP_MEM_ID(adev, xcp_id) \
>                 ((adev)->xcp_mgr && (xcp_id) >=3D 0 ?\
>                 (adev)->xcp_mgr->xcp[(xcp_id)].mem_id : -1)
>
> -#define KFD_XCP_MEMORY_SIZE(adev, xcp_id)\
> -               ((adev)->gmc.num_mem_partitions && (xcp_id) >=3D 0 ?\
> -               (adev)->gmc.mem_partitions[KFD_XCP_MEM_ID((adev), (xcp_id=
))].size /\
> -               (adev)->xcp_mgr->num_xcp_per_mem_partition :\
> -               (adev)->gmc.real_vram_size)
> +#define KFD_XCP_MEMORY_SIZE(adev, xcp_id) amdgpu_amdkfd_xcp_memory_size(=
(adev), (xcp_id))
> +
>
>  #if IS_ENABLED(CONFIG_HSA_AMD)
>  void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index ad664ef640ff..34724b771ace 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -818,11 +818,14 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct am=
dgpu_device *adev,
>         struct amdgpu_ttm_tt *gtt =3D (void *)ttm;
>         uint64_t total_pages =3D ttm->num_pages;
>         int num_xcc =3D max(1U, adev->gfx.num_xcc_per_xcp);
> -       uint64_t page_idx, pages_per_xcc =3D total_pages / num_xcc;
> +       uint64_t page_idx, pages_per_xcc;
>         int i;
>         uint64_t ctrl_flags =3D (flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
>                         AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
>
> +       pages_per_xcc =3D total_pages;
> +       do_div(pages_per_xcc, num_xcc);
> +
>         for (i =3D 0, page_idx =3D 0; i < num_xcc; i++, page_idx +=3D pag=
es_per_xcc) {
>                 /* MQD page: use default flags */
>                 amdgpu_gart_bind(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 938c8dba9057..d559e7bc0f09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1919,9 +1919,10 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device=
 *adev,
>         adev->gmc.num_mem_partitions =3D num_ranges;
>
>         /* If there is only partition, don't use entire size */
> -       if (adev->gmc.num_mem_partitions =3D=3D 1)
> -               mem_ranges[0].size =3D
> -                       (mem_ranges[0].size * (mem_groups - 1) / mem_grou=
ps);
> +       if (adev->gmc.num_mem_partitions =3D=3D 1) {
> +               mem_ranges[0].size =3D mem_ranges[0].size * (mem_groups -=
 1);
> +               do_div(mem_ranges[0].size, mem_groups);
> +       }
>  }
>
>  static void
> @@ -1953,8 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *a=
dev,
>                 break;
>         }
>
> -       size =3D (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) /
> -              adev->gmc.num_mem_partitions;
> +       size =3D adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT;
> +       size /=3D adev->gmc.num_mem_partitions;
>
> Did you miss using the do_div() here?

It's not needed here.  size is 32 bits IIRC.

Alex

>
> Thanks,
> Mukul
>
>         for (i =3D 0; i < adev->gmc.num_mem_partitions; ++i) {
>                 mem_ranges[i].range.fpfn =3D start_addr;
> --
> 2.40.1
>
