Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AC9CCD199
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 13:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BF710E9DE;
	Thu, 16 Oct 2025 13:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hqDLCuXJ";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7840B10E9DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 13:08:14 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b47174b335bso60173a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 06:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760620094; x=1761224894; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dbDA+WLIcH5GrMJh4bhoHtUaJO3nZ6245R3dLltLDg=;
 b=hqDLCuXJxUWHgaoJYOeQBx4y3G1Fl90kNdUrv8FfFSoDC7/wEkXbCZkrlwqdM3rz6b
 5eWr02IqNFyfBJC3viRNunoaU92Bk1uz01XN/JPM5liHh1myVk39CNVx4+djdbhfk0GJ
 PL6LvYRnN+GObOWQYI5j9PICNyLG1fudaizm8/2HJWTp8WyTKTG5+gEIsXtLgJfXeFml
 15NsSAEKl0i5ogGs1dvB9vOwBBa/ow5otqhWzxeebuLfjHlpHqpt8UnWOW+kwwAoEutN
 2mZiBaHxI2PE5q+Y1QrpGAgSRQ+C0LgWKFOVdb61enfgAWMzCc6TV9HFUAxTFmq7WkWB
 4ZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760620094; x=1761224894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dbDA+WLIcH5GrMJh4bhoHtUaJO3nZ6245R3dLltLDg=;
 b=L+YQjv++nRoEGW7pzYT/nIoGy3DefTPZIbC37VdhAj0gpB9/fR2Do3GDGj+sHJeWXH
 QdTTR09Bx5a+WRdeuXchvltjdhGAuH2c5H9KUWY+ZbuC9amP3qEDw/UXM5gDIyqmMKWw
 cdoObXf8hs4HuTVbMzcqav/Cduw4gqDG337+PAXGfaRj/JGzNhTvYSwi6gCb1l21FE28
 KJtp2U78UY180Lq63B1zpi8dIDVlS7CvQmzF2ZqsxlMGwpVD5bxd8uwNbEEYFOW1HCcY
 Z8nKLcp6ntyuYslH+iIgwPrPgmVzFaVHzllizxB7vIp2DS7Idxd4eWGOLWYpxnIXDmfZ
 O98A==
X-Gm-Message-State: AOJu0YwBePzULOc3F+7UWYfNE3AlO8Q2wcGXYHZG0d91UEC0OFsbSQnf
 HRVjQmpJXr2+Y6aav36mRqqmKiwSq3PDCstk3h/yHOwv5k9yrBpCALDwf3hAV+68SNawCwBAbwG
 S0+APQFwZKHnP5o7/idfLj1LISOr2FV5b/A==
X-Gm-Gg: ASbGncvXEfNgCttFGn0jV47ufJy9YNmle7QCzweDe7hMlrIaP1JznceOWz3NhQqNjSU
 jIqbMyKjBWP+xT0vgk4NkE6MEbEY7HQhf+lXbSR4tcb/B73Xq0nHiBpio4mWPpRrRb3xIRyRtrT
 xjQ10y5PrZ9aj++ZDOsknQrCtHFeXHtSY9fWfH6U/KFiddS42HFAv9P5oMuN3XRoQWary9WTU0W
 3BJ/ymc2F2c6cfwIQKxy5bV+JXRALOa8MZ5O6PZEYPeWYWrHfP6n5++ApDj
X-Google-Smtp-Source: AGHT+IFeIUjDEByqrYIgBguTpycBvdojk6bmmpFmBU6bpZqfpnDXjiCe+7ck1DJotqrZYROZnGvYHIXPH462WkNwN6Y=
X-Received: by 2002:a17:903:110c:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-290272667a9mr239915105ad.4.1760620093691; Thu, 16 Oct 2025
 06:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251015214848.11580-1-yunru.pan@amd.com>
 <20251015214848.11580-5-yunru.pan@amd.com>
In-Reply-To: <20251015214848.11580-5-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Oct 2025 09:08:02 -0400
X-Gm-Features: AS18NWAJJUNXVASy-AJsUGefftGnnuhYJP0vGoN4qnma8VTs2j9luOFNOEWSMpI
Message-ID: <CADnq5_P8c3qPtkjMUZ4WXLuJze4HTTXdWJpq7sbCTk0mzYR5cw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/amdgpu: Add logic for VF data exchange region
 to init from dynamic crit_region offsets
To: Ellen Pan <yunru.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com, Jeffrey.Chan@amd.com
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

On Wed, Oct 15, 2025 at 5:49=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
> 1. Added VF logic to init data exchange region using the offsets from dyn=
amic(v2) critical regions;
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 104 ++++++++++++++++++-----
>  1 file changed, 85 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 15157ed5df29..fe9a806dbf34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -218,12 +218,12 @@ int amdgpu_virt_alloc_mm_table(struct amdgpu_device=
 *adev)
>                                     &adev->virt.mm_table.gpu_addr,
>                                     (void *)&adev->virt.mm_table.cpu_addr=
);
>         if (r) {
> -               DRM_ERROR("failed to alloc mm table and error =3D %d.\n",=
 r);
> +               dev_err(adev->dev, "failed to alloc mm table and error =
=3D %d.\n", r);
>                 return r;
>         }
>
>         memset((void *)adev->virt.mm_table.cpu_addr, 0, PAGE_SIZE);
> -       DRM_INFO("MM table gpu addr =3D 0x%llx, cpu addr =3D %p.\n",
> +       dev_info(adev->dev, "MM table gpu addr =3D 0x%llx, cpu addr =3D %=
p.\n",
>                  adev->virt.mm_table.gpu_addr,
>                  adev->virt.mm_table.cpu_addr);
>         return 0;
> @@ -403,7 +403,9 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu=
_device *adev)
>                         if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU=
_GPU_PAGE_SHIFT,
>                                                         AMDGPU_GPU_PAGE_S=
IZE,
>                                                         &bo, NULL))
> -                               DRM_DEBUG("RAS WARN: reserve vram for ret=
ired page %llx fail\n", bp);
> +                               dev_dbg(adev->dev,
> +                                               "RAS WARN: reserve vram f=
or retired page %llx fail\n",
> +                                               bp);
>                         data->bps_bo[i] =3D bo;
>                 }
>                 data->last_reserved =3D i + 1;
> @@ -671,10 +673,34 @@ static void amdgpu_virt_update_vf2pf_work_item(stru=
ct work_struct *work)
>         schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_=
update_interval_ms);
>  }
>
> +static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device =
*adev, uint32_t *pfvf_data)
> +{
> +       uint32_t dataexchange_offset =3D
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE=
_ID].offset;
> +       uint32_t dataexchange_size =3D
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE=
_ID].size_kb << 10;
> +       uint64_t pos =3D 0;
> +
> +       dev_info(adev->dev,
> +                       "Got data exchange info from dynamic crit_region_=
table at offset 0x%x with size of 0x%x bytes.\n",
> +                       dataexchange_offset, dataexchange_size);
> +
> +       if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchan=
ge_size, 4)) {
> +               dev_err(adev->dev, "Data exchange data not aligned to 4 b=
ytes\n");
> +               return -EINVAL;
> +       }
> +
> +       pos =3D (uint64_t)dataexchange_offset;
> +       amdgpu_device_vram_access(adev, pos, pfvf_data,
> +                       dataexchange_size, false);
> +
> +       return 0;
> +}
> +
>  void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
>  {
>         if (adev->virt.vf2pf_update_interval_ms !=3D 0) {
> -               DRM_INFO("clean up the vf2pf work item\n");
> +               dev_info(adev->dev, "clean up the vf2pf work item\n");
>                 cancel_delayed_work_sync(&adev->virt.vf2pf_work);
>                 adev->virt.vf2pf_update_interval_ms =3D 0;
>         }
> @@ -682,13 +708,15 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_d=
evice *adev)
>
>  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>  {
> +       uint32_t *pfvf_data =3D NULL;
> +
>         adev->virt.fw_reserve.p_pf2vf =3D NULL;
>         adev->virt.fw_reserve.p_vf2pf =3D NULL;
>         adev->virt.vf2pf_update_interval_ms =3D 0;
>         adev->virt.vf2pf_update_retry_cnt =3D 0;
>
>         if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) =
{
> -               DRM_WARN("Currently fw_vram and drv_vram should not have =
values at the same time!");
> +               dev_warn(adev->dev, "Currently fw_vram and drv_vram shoul=
d not have values at the same time!");
>         } else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usa=
ge_va) {
>                 /* go through this logic in ip_init and reset to init wor=
kqueue*/
>                 amdgpu_virt_exchange_data(adev);
> @@ -697,11 +725,34 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_d=
evice *adev)
>                 schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_=
jiffies(adev->virt.vf2pf_update_interval_ms));
>         } else if (adev->bios !=3D NULL) {
>                 /* got through this logic in early init stage to get nece=
ssary flags, e.g. rlcg_acc related*/
> -               adev->virt.fw_reserve.p_pf2vf =3D
> -                       (struct amd_sriov_msg_pf2vf_info_header *)
> -                       (adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 <=
< 10));
> +               if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V=
2) {
> +                       pfvf_data =3D
> +                               kzalloc(adev->virt.crit_regn_tbl[AMD_SRIO=
V_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
> +                                       GFP_KERNEL);
> +                       if (!pfvf_data) {
> +                               dev_err(adev->dev, "Failed to allocate me=
mory for pfvf_data\n");
> +                               return;
> +                       }
>
> -               amdgpu_virt_read_pf2vf_data(adev);
> +                       if (amdgpu_virt_read_exchange_data_from_mem(adev,=
 pfvf_data))
> +                               goto free_pfvf_data;
> +
> +                       adev->virt.fw_reserve.p_pf2vf =3D
> +                               (struct amd_sriov_msg_pf2vf_info_header *=
)pfvf_data;
> +
> +                       amdgpu_virt_read_pf2vf_data(adev);
> +
> +free_pfvf_data:
> +                       kfree(pfvf_data);
> +                       pfvf_data =3D NULL;
> +                       adev->virt.fw_reserve.p_pf2vf =3D NULL;
> +               } else {
> +                       adev->virt.fw_reserve.p_pf2vf =3D
> +                               (struct amd_sriov_msg_pf2vf_info_header *=
)
> +                               (adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET=
_KB_V1 << 10));
> +
> +                       amdgpu_virt_read_pf2vf_data(adev);
> +               }
>         }
>  }
>
> @@ -714,14 +765,29 @@ void amdgpu_virt_exchange_data(struct amdgpu_device=
 *adev)
>
>         if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) =
{
>                 if (adev->mman.fw_vram_usage_va) {
> -                       adev->virt.fw_reserve.p_pf2vf =3D
> -                               (struct amd_sriov_msg_pf2vf_info_header *=
)
> -                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_PF2VF_OFFSET_KB_V1 << 10));
> -                       adev->virt.fw_reserve.p_vf2pf =3D
> -                               (struct amd_sriov_msg_vf2pf_info_header *=
)
> -                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_VF2PF_OFFSET_KB_V1 << 10));
> -                       adev->virt.fw_reserve.ras_telemetry =3D
> -                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
> +                       if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_=
REGION_V2) {
> +                               adev->virt.fw_reserve.p_pf2vf =3D
> +                                       (struct amd_sriov_msg_pf2vf_info_=
header *)
> +                                       (adev->mman.fw_vram_usage_va +
> +                                       adev->virt.crit_regn_tbl[AMD_SRIO=
V_MSG_DATAEXCHANGE_TABLE_ID].offset);
> +                               adev->virt.fw_reserve.p_vf2pf =3D
> +                                       (struct amd_sriov_msg_vf2pf_info_=
header *)
> +                                       (adev->mman.fw_vram_usage_va +
> +                                       adev->virt.crit_regn_tbl[AMD_SRIO=
V_MSG_DATAEXCHANGE_TABLE_ID].offset +
> +                                       (AMD_SRIOV_MSG_SIZE_KB << 10));
> +                               adev->virt.fw_reserve.ras_telemetry =3D
> +                                       (adev->mman.fw_vram_usage_va +
> +                                       adev->virt.crit_regn_tbl[AMD_SRIO=
V_MSG_RAS_TELEMETRY_TABLE_ID].offset);
> +                       } else {
> +                               adev->virt.fw_reserve.p_pf2vf =3D
> +                                       (struct amd_sriov_msg_pf2vf_info_=
header *)
> +                                       (adev->mman.fw_vram_usage_va + (A=
MD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
> +                               adev->virt.fw_reserve.p_vf2pf =3D
> +                                       (struct amd_sriov_msg_vf2pf_info_=
header *)
> +                                       (adev->mman.fw_vram_usage_va + (A=
MD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
> +                               adev->virt.fw_reserve.ras_telemetry =3D
> +                                       (adev->mman.fw_vram_usage_va + (A=
MD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
> +                       }
>                 } else if (adev->mman.drv_vram_usage_va) {
>                         adev->virt.fw_reserve.p_pf2vf =3D
>                                 (struct amd_sriov_msg_pf2vf_info_header *=
)
> @@ -829,7 +895,7 @@ static bool amdgpu_virt_init_req_data(struct amdgpu_d=
evice *adev, u32 reg)
>                         break;
>                 default: /* other chip doesn't support SRIOV */
>                         is_sriov =3D false;
> -                       DRM_ERROR("Unknown asic type: %d!\n", adev->asic_=
type);
> +                       dev_err(adev->dev, "Unknown asic type: %d!\n", ad=
ev->asic_type);
>                         break;
>                 }
>         }
> @@ -1501,7 +1567,7 @@ amdgpu_ras_block_to_sriov(struct amdgpu_device *ade=
v, enum amdgpu_ras_block bloc
>         case AMDGPU_RAS_BLOCK__MPIO:
>                 return RAS_TELEMETRY_GPU_BLOCK_MPIO;
>         default:
> -               DRM_WARN_ONCE("Unsupported SRIOV RAS telemetry block 0x%x=
\n",
> +               dev_warn(adev->dev, "Unsupported SRIOV RAS telemetry bloc=
k 0x%x\n",
>                               block);
>                 return RAS_TELEMETRY_GPU_BLOCK_COUNT;
>         }
> --
> 2.34.1
>
