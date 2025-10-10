Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F3ACCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 15:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4524710EC4D;
	Fri, 10 Oct 2025 15:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kgxsxwGl";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 456FC10EC4F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 15:32:12 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-280fc0e9f50so3770515ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760110332; x=1760715132; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Zsn+720mmsTuXhTVUS362E3q7AXxrqoTW50wucwfrI=;
 b=kgxsxwGlRdLlle4nDl4J2Th+H3UeQl5/YzMmqTa1KPlCCstri0VSvNG82RNfQOqx4X
 YTL1k8GeD1sMCi2EYw8wOBMRPwjpNAVuV0iCB1s4Z/I5hbftXbt5Wd/dXbVthc2njUHe
 gVNwFx+ksiqCtDXsTB9zxhv7ndehbl90D6hSD94XP+hDC/CvIh8Wd43Y6yvwUqleNjwV
 U+DTdbY5vyEHOAfn7KRO7Lsal8ADpNBwcjj7hhPLZQwHl3BHrFgZKBoHcIwxjjAnAKtt
 iwv9q2E+c23Xe3rmZifUQ3RBTKEKuZUWgIbOnY5199e4Gst11151nuSKS9MdLZOot58F
 OVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760110332; x=1760715132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Zsn+720mmsTuXhTVUS362E3q7AXxrqoTW50wucwfrI=;
 b=YR0pdyo3O/JGc51a3lysQuBnehVaXJeHyevmoBKUlv0QicQYTOFJQG3Su42FKVsPFx
 2bU5DP7JWwT0TXqfgRM3eYFt803nt/JWn6T10Xb/Jw84PQBZx6CxBXvbl9GSfWw+CFoA
 ocXkF+ELG5PRmizMx1lH1+hCv40U+aNNzYaJ2kbP8Oa5Tkl4fH/d+PYtMi/abcoHmbcj
 m2Yhfm8pRSC9q8Fn+hahWAFTj+IIK/7wHmK4UNNY3lP9Ymo+XP43D+ttTcUYHB9/c7Qt
 GqrmdSURTPrvDSlj5ip+HCmnc9qEWobrRquxQjrcasBBCXAkTk4x0aGpWPC8QPst3fLJ
 NdiA==
X-Gm-Message-State: AOJu0Yw8Can9kWOgFvZvXxpSZqcyu3KTAWBhzxyIfzbNfAPxdUpF+kSW
 JXXuP0uxQ2Hv6bLbVG7v+LkRq6E8UuqRi8QsGVKkZ/DZ9qCW8ewiIGsEneJrNDaE9ZByR3ZI/I9
 0d34e1Iv0iaK8Ic5YebPbtg0ajDA962s=
X-Gm-Gg: ASbGnctxeTMGZXebY1bQ0v0tK0qxRB2zGHzLlSMVUQ/IPzIWKko2G+0XzDmOo8Nz+9V
 /C9qmuWG1Yj/z5+j/9t0cg4m5lU8ZBKhKMdfz6FJ+wxEoFk6Uz0uoUXFKQ6Ek1XTUnZEZiiD+CU
 hmsqWUQcFgTizgjdn+ukC9fr04fJnsmvjdrUMoYBrkzfxhOHHAo4PVdaVUi1mCB0SrsRyCzryf3
 I3q1UcdslUhBQ9ryeQqOlItPQ==
X-Google-Smtp-Source: AGHT+IGNb3dsU2mSaCtT7jcvXe4kAxiOVurB5qXYtyrg3G00GAaMX0AHtVQqZEMfh7Z0zGwJdmZ4pmJqidWnPATPhkY=
X-Received: by 2002:a17:902:d4c1:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-290272e3d33mr95351375ad.6.1760110331251; Fri, 10 Oct 2025
 08:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251010044309.11822-1-yunru.pan@amd.com>
 <20251010044309.11822-6-yunru.pan@amd.com>
In-Reply-To: <20251010044309.11822-6-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Oct 2025 11:31:59 -0400
X-Gm-Features: AS18NWBk-kVAavOkhMQlgCujuSAL9KQwODca66u3FzGcQaTw0u3SZ6MHELivRsg
Message-ID: <CADnq5_NJ0d48ismMkWJKRVFNnVsLqbk68s3N-9E9tQHQrVNPFA@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: Add logic for VF data exchange region to
 init from dynamic crit_region offsets
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

On Fri, Oct 10, 2025 at 1:01=E2=80=AFAM Ellen Pan <yunru.pan@amd.com> wrote=
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
> index 67d5f15a72a1..f96382fb0070 100644
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

dev_err()

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
> @@ -1072,6 +1112,30 @@ bool amdgpu_virt_read_bios_from_vram(struct amdgpu=
_device *adev)
>         return true;
>  }
>
> +int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, =
uint32_t *pfvf_data)

This can be static as it's not used outside this file.

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

dev_err()

Alex

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
> index f2aa306f4192..ae456bde6a5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -440,6 +440,7 @@ void amdgpu_virt_init(struct amdgpu_device *adev);
>  int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
>  int amdgpu_virt_init_discovery_from_mem(struct amdgpu_device *adev, uint=
8_t *binary);
>  bool amdgpu_virt_read_bios_from_vram(struct amdgpu_device *adev);
> +int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, =
uint32_t *pfvf_data);
>
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>  int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
> --
> 2.34.1
>
