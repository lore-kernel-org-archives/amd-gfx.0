Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E69CCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 13:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 446DD10E391;
	Mon, 13 Oct 2025 13:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dmGJZrRQ";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A3410E391
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 13:34:46 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b63e5da0fdeso305416a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760362486; x=1760967286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZBgn9V37+jDcIBJmmFPdtFnuySLe6ZltR7F9yPpTFU=;
 b=dmGJZrRQRjKYlQLdJfSox8pdaupRYA3mzv5igWxUzt5qsHP9b2RyzdEOAIOrxhAcLy
 obLYrFwJTM+DLbSIXkSzWrBpk4aaymzK5VfUySq+kodUPjU1RkI2H2J2WHRvMFlPLZoL
 gKYFOx8z01YwbPZzh09OqXMt2j9kxEUDSRjGKPyFSM9VzQAGomJFcKqFEzcgrXM7rqiX
 oiC4bCmaNFnEuqQ6X6DcJcJH52brTaGfMnSBUFrC1npzk8Y5FMhIiRYVoDGTWVuB4aON
 LCByq/jdeXgCSoSZcbUBg8+ylZFu48CDCEQzQ6rEEj331gaISdz+RNQrbPNEga+3nkAt
 N4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760362486; x=1760967286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZBgn9V37+jDcIBJmmFPdtFnuySLe6ZltR7F9yPpTFU=;
 b=iytwworShberUhKHjm/nCbBViGo7RulLitx2vDOjVD4VinnoBoVA6S6wO+5RfHNxsZ
 JKnEYVF4Ap7cZ0cy/ZTI5SnbSgw3QlbOFz5YGHL+BkgdTzWrQL7IOKT1QhsKK7lvFPeZ
 9tReJCE0zHolVjaHVbCvqj4kCNPl6B3Kq7ATnVN5+JjnzylbVJOTa7m0nVVO+bfIore1
 mB7BI136K1Jh5b6QGc5YLsgKOUw7mnQIEkEu0aHauNXVrT5BntBltqHsUpey6zkh2kMK
 YnvqVyuGSmGkoANdaCv1js62xl1dgJponb7qO5Pp8lOqA14CF4iGL3GbmBJLxsxmi60G
 DMCA==
X-Gm-Message-State: AOJu0Yy40rF4nFCrgN77YQvO3shbwoc2badoZgzbWL0m1qr5DYnKA66F
 Vp6xKUkFEWvJM8EOH02C3M8u9tuuXPMexj8s1XJpCB6VdsgwirRQzwQsW3jy+d8b69xVkvvEsaI
 rr8MmyaUGbFZVUDYx/BBAh8uyue3OfPw=
X-Gm-Gg: ASbGncvoAIHV5MV6oa0OhYKVZDdTyPU5glyhI96lTW+1kIYPiNNQbV2Ja/V8UHtoWNa
 DK3A7tjecgQd4sIeAmAYiT2xPik7Li5btwMgxloRznM3MmZIoTY7dal2pbVrZw79flS8cL+GHXm
 pqD802553dgJduJG5e53BkremVav5pa6El4iCCWMX6IU9rvB8wDuyADUBPyGG8X/nDiTSUJKgGS
 DpJvDF//Ge7zmvmhr0VgxCQEXGXCbFF7J+vyX0uSWSbD90=
X-Google-Smtp-Source: AGHT+IHr+d9oC9Il8vMffSAVygGguOftiBcoCUg73k3aim4hmHBv0fliOFirz4XzHo7pkFzek3oNb87mpULlTsCENc8=
X-Received: by 2002:a17:903:110c:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-290272667a9mr152721135ad.4.1760362485764; Mon, 13 Oct 2025
 06:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251010184849.9701-1-yunru.pan@amd.com>
 <20251010184849.9701-6-yunru.pan@amd.com>
In-Reply-To: <20251010184849.9701-6-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Oct 2025 09:34:34 -0400
X-Gm-Features: AS18NWC8y-5VwvcSUEgHJIGthPmD74i-5nIJVlGvBrftYC7HG0ov9LvuJKFWiX0
Message-ID: <CADnq5_O1Qz=44hSB160X0KxrqZX8_yybMJTeFxZL5fc3vWEDig@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drm/amdgpu: Add logic for VF data exchange region
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

On Fri, Oct 10, 2025 at 2:49=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
> 1. Added VF logic to init data exchange region using the offsets from dyn=
amic(v2) critical regions;
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 88 ++++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  1 +
>  2 files changed, 77 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 4a7125122ae7..d99120b98188 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -670,6 +670,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_dev=
ice *adev)
>
>  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>  {
> +       uint32_t *pfvf_data =3D NULL;
> +
>         adev->virt.fw_reserve.p_pf2vf =3D NULL;
>         adev->virt.fw_reserve.p_vf2pf =3D NULL;
>         adev->virt.vf2pf_update_interval_ms =3D 0;
> @@ -685,11 +687,34 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_d=
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
> +                               DRM_ERROR("Failed to allocate memory for =
pfvf_data\n");
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
> @@ -702,14 +727,29 @@ void amdgpu_virt_exchange_data(struct amdgpu_device=
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
> +                                       (AMD_SRIOV_MSG_SIZE_KB_V1 << 10))=
;
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
> @@ -1018,6 +1058,30 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgp=
u_device *adev,
>         return 0;
>  }
>
> +int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, =
uint32_t *pfvf_data)

This function can be static as it's only used in this file.

Alex

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
> +               DRM_ERROR("Data exchange data not aligned to 4 bytes\n");
> +               return -EINVAL;
> +       }
> +
> +       pos =3D (uint64_t)dataexchange_offset;
> +       amdgpu_device_vram_access(adev, pos, pfvf_data,
> +                                       dataexchange_size, false);
> +
> +       return 0;
> +}
> +
>  void amdgpu_virt_init(struct amdgpu_device *adev)
>  {
>         bool is_sriov =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.h
> index 5d8e3260f677..4e9489ff295c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -440,6 +440,7 @@ void amdgpu_virt_init(struct amdgpu_device *adev);
>  int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
>  int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
>         int data_id, uint8_t *binary, uint64_t *size);
> +int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, =
uint32_t *pfvf_data);
>
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>  int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
> --
> 2.34.1
>
