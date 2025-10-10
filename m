Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F76CCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 14:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E64210EC2C;
	Fri, 10 Oct 2025 14:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g4DsEjjY";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD7110EC2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 14:51:40 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-269ba651d06so3370015ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760107900; x=1760712700; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTbQLV6dcsqXIag9pdZYdibeJOxkWk7+sO8JWwVRWys=;
 b=g4DsEjjYXVqzoEvAhmKLdc7fSga61sexwXygTBEx2I6m8lcWxkK0v7466hYSGMR2H8
 LNtmo6aCH7ia9NX7BGHfygGX6lKlGb1YnbG3S6DzeGtA+JpMdEva01ghvTYUDN137wpF
 joFy5wK5pdye58DhVopNWuDS9AcVLHlc0usDN751mG/kQ0Fza6om5nQrNQUlG0N7UKH2
 KM9YutVU7BNcITTty6Gb19OS9vHDopGJo0R4Z3UQkjgWW/Je+ecdpznF/lRcESwxEJCr
 8Vdc93CHWY/EPMkP8cqWv/ra+0mm22y5zT+Z0xvakhEx7UwYthBKXcTHTcRHkNtPPF0Q
 HZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107900; x=1760712700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mTbQLV6dcsqXIag9pdZYdibeJOxkWk7+sO8JWwVRWys=;
 b=ADwOCYvF1lm6oTkK77XLuPJ4vY4Y4lkzfZUpsdKvrBSZc51P6QTlYzhCzJ1hYMWPYH
 psVm1tAo5oFMAim+8qrr9Kx/BlfyV1OrU9ChLttTegv/vUJohXDMHshyRRLWWdYDWowu
 0IDLcPdaSYfSOxjag+Wj+1uNeFOVHeljFjnyy+qgCKKqLnS1zKJlLnQxp2S6xp3seUoL
 dD1vHerOGDsn1dk3I5lqRyBbIZs2y7dcGEk2vonrd+DNwhgYvn08w+HHDWMc2X1WXuds
 Z7KJTXjqvghY0ah0w1dnc9NDkbkc8lYcSA6GBK1UPuaHVFU3oxxcfTGwV+bALUmwxaHD
 02+w==
X-Gm-Message-State: AOJu0Yz/+TtPKqRLLOyHhXtqE4sV/HrMP/zk1cJnmJoaMrbV0x7nVPm4
 888YwscEGZBzgByvBQucYZHgxgsYmtBR7WGrlqGCUOqB73ol1F1eeaxaZNSK+eCA46tsIe6o3Qq
 9ASonihk30QbItNsYeRs/uQUIuGCme1U=
X-Gm-Gg: ASbGncttwCwuMjZ74P/e0dg/bCTxE33L4ZrvWSOAFSF6M0qzIpRvQuUQQtgbZe8I0y4
 ryOqQF5yOlkq920kPwtIG6Ib4r3Xqwu4dvvqWW7F/sadR5zvpnWNOkoj4NpveBrslzaqARq6+aa
 we/wyO2A95k6JwmpDAOftT7c9nszPHy286ZKoOWh/rnmE3K4gkkttuOPS5PNaC+q9JciGTUMeCu
 fvHE+OxUS6fnfVkC/2NvaccL94kRplUgkLB
X-Google-Smtp-Source: AGHT+IEz/eDA6zuBo25YQssraiB3SzXnZb7AwlpjFi5VK76X9bE2qxXK72TlwuYkHTAWzcQADtE9NlfStDrDhlga8bE=
X-Received: by 2002:a17:902:c404:b0:277:c230:bfca with SMTP id
 d9443c01a7336-290273e17bfmr86894715ad.4.1760107899486; Fri, 10 Oct 2025
 07:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251010044309.11822-1-yunru.pan@amd.com>
In-Reply-To: <20251010044309.11822-1-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Oct 2025 10:51:27 -0400
X-Gm-Features: AS18NWCq0a4CIwxtDUhJkvebGT7TdJW9GEk-B1gQRYykHnxgW_F_zj8ONZplggM
Message-ID: <CADnq5_NsJNBPOzxgNjw+-F2uOLuFLrRWOezhfBWfYSBK1UJ+6A@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: Updated naming of SRIOV critical region
 offsets/sizes with _V1 suffix
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

On Fri, Oct 10, 2025 at 12:43=E2=80=AFAM Ellen Pan <yunru.pan@amd.com> wrot=
e:
>
>  - This change prepares the later patches to intro  _v2 suffix to SRIOV c=
ritical regions
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 20 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 57 ++++++++++++++-------
>  2 files changed, 49 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 3328ab63376b..e95adf0407a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -686,7 +686,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_dev=
ice *adev)
>                 /* got through this logic in early init stage to get nece=
ssary flags, e.g. rlcg_acc related*/
>                 adev->virt.fw_reserve.p_pf2vf =3D
>                         (struct amd_sriov_msg_pf2vf_info_header *)
> -                       (adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 1=
0));
> +                       (adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 <=
< 10));
>
>                 amdgpu_virt_read_pf2vf_data(adev);
>         }
> @@ -703,21 +703,21 @@ void amdgpu_virt_exchange_data(struct amdgpu_device=
 *adev)
>                 if (adev->mman.fw_vram_usage_va) {
>                         adev->virt.fw_reserve.p_pf2vf =3D
>                                 (struct amd_sriov_msg_pf2vf_info_header *=
)
> -                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_PF2VF_OFFSET_KB << 10));
> +                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_PF2VF_OFFSET_KB_V1 << 10));
>                         adev->virt.fw_reserve.p_vf2pf =3D
>                                 (struct amd_sriov_msg_vf2pf_info_header *=
)
> -                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_VF2PF_OFFSET_KB << 10));
> +                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_VF2PF_OFFSET_KB_V1 << 10));
>                         adev->virt.fw_reserve.ras_telemetry =3D
> -                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
> +                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
>                 } else if (adev->mman.drv_vram_usage_va) {
>                         adev->virt.fw_reserve.p_pf2vf =3D
>                                 (struct amd_sriov_msg_pf2vf_info_header *=
)
> -                               (adev->mman.drv_vram_usage_va + (AMD_SRIO=
V_MSG_PF2VF_OFFSET_KB << 10));
> +                               (adev->mman.drv_vram_usage_va + (AMD_SRIO=
V_MSG_PF2VF_OFFSET_KB_V1 << 10));
>                         adev->virt.fw_reserve.p_vf2pf =3D
>                                 (struct amd_sriov_msg_vf2pf_info_header *=
)
> -                               (adev->mman.drv_vram_usage_va + (AMD_SRIO=
V_MSG_VF2PF_OFFSET_KB << 10));
> +                               (adev->mman.drv_vram_usage_va + (AMD_SRIO=
V_MSG_VF2PF_OFFSET_KB_V1 << 10));
>                         adev->virt.fw_reserve.ras_telemetry =3D
> -                               (adev->mman.drv_vram_usage_va + (AMD_SRIO=
V_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
> +                               (adev->mman.drv_vram_usage_va + (AMD_SRIO=
V_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
>                 }
>
>                 amdgpu_virt_read_pf2vf_data(adev);
> @@ -1304,7 +1304,7 @@ static int amdgpu_virt_cache_host_error_counts(stru=
ct amdgpu_device *adev,
>         checksum =3D host_telemetry->header.checksum;
>         used_size =3D host_telemetry->header.used_size;
>
> -       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +       if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
>                 return 0;
>
>         tmp =3D kmemdup(&host_telemetry->body.error_count, used_size, GFP=
_KERNEL);
> @@ -1383,7 +1383,7 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,
>         checksum =3D host_telemetry->header.checksum;
>         used_size =3D host_telemetry->header.used_size;
>
> -       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +       if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
>                 return -EINVAL;
>
>         cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size,=
 GFP_KERNEL);
> @@ -1515,7 +1515,7 @@ static int amdgpu_virt_cache_chk_criti_hit(struct a=
mdgpu_device *adev,
>         checksum =3D host_telemetry->header.checksum;
>         used_size =3D host_telemetry->header.used_size;
>
> -       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +       if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
>                 return 0;
>
>         tmp =3D kmemdup(&host_telemetry->body.chk_criti, used_size, GFP_K=
ERNEL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgv_sriovmsg.h
> index 3a79ed7d8031..3b35154e2df6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -23,26 +23,47 @@
>  #ifndef AMDGV_SRIOV_MSG__H_
>  #define AMDGV_SRIOV_MSG__H_
>
> -/* unit in kilobytes */
> -#define AMD_SRIOV_MSG_VBIOS_OFFSET          0
> -#define AMD_SRIOV_MSG_VBIOS_SIZE_KB         64
> -#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
> -#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
> -#define AMD_SRIOV_MSG_TMR_OFFSET_KB         2048
> -#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB      2
> -#define AMD_SRIOV_RAS_TELEMETRY_SIZE_KB             64
>  /*
> - * layout
> + * layout v1
>   * 0           64KB        65KB        66KB           68KB              =
     132KB
>   * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Re=
gion | ...
>   * |   64KB    |   1KB     |   1KB     |   2KB        | 64KB            =
     | ...
>   */
>
> -#define AMD_SRIOV_MSG_SIZE_KB                   1
> -#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB           AMD_SRIOV_MSG_DATAEXCHAN=
GE_OFFSET_KB
> -#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB           (AMD_SRIOV_MSG_PF2VF_OFF=
SET_KB + AMD_SRIOV_MSG_SIZE_KB)
> -#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB        (AMD_SRIOV_MSG_VF2PF_OFF=
SET_KB + AMD_SRIOV_MSG_SIZE_KB)
> -#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB   (AMD_SRIOV_MSG_BAD_PAGE_=
OFFSET_KB + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB)
> +/*
> + * layout v2 (offsets are dynamically allocated and the offsets below ar=
e examples)
> + * 0           1KB         64KB        65KB        66KB           68KB  =
                 132KB
> + * |  INITD_H  |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS =
Telemetry Region | ...
> + * |   1KB     |   64KB    |   1KB     |   1KB     |   2KB        | 64KB=
                 | ...
> + *
> + * Note: PF2VF + VF2PF + Bad Page =3D DataExchange region (allocated con=
tiguously)
> + */
> +
> +/* v1 layout sizes */
> +#define AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1                 64
> +#define AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1                 1
> +#define AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1                 1
> +#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1              2
> +#define AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1         64
> +#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1          \
> +       (AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1 + AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1 =
+ \
> +        AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
> +
> +/* v1 offsets */
> +#define AMD_SRIOV_MSG_VBIOS_OFFSET_V1                  0
> +#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1                AMD_SRIOV=
_MSG_VBIOS_SIZE_KB_V1
> +#define AMD_SRIOV_MSG_TMR_OFFSET_KB                    2048
> +#define AMD_SRIOV_MSG_SIZE_KB_V1                       1
> +#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1               AMD_SRIOV_MSG_DAT=
AEXCHANGE_OFFSET_KB_V1
> +#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1               \
> +       (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
> +#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1            \
> +       (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
> +#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1       \
> +       (AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1 + AMD_SRIOV_MSG_BAD_PAGE_SIZ=
E_KB_V1)
> +#define AMD_SRIOV_MSG_INIT_DATA_TOT_SIZE_KB_V1         \
> +       (AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE=
_KB_V1 + \
> +        AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
>
>  /*
>   * PF2VF history log:
> @@ -436,12 +457,12 @@ unsigned int amd_sriov_msg_checksum(void *obj, unsi=
gned long obj_size, unsigned
>  #define _stringification(s) #s
>
>  _Static_assert(
> -       sizeof(struct amd_sriov_msg_vf2pf_info) =3D=3D AMD_SRIOV_MSG_SIZE=
_KB << 10,
> -       "amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG=
_SIZE_KB) " KB");
> +       sizeof(struct amd_sriov_msg_vf2pf_info) =3D=3D AMD_SRIOV_MSG_SIZE=
_KB_V1 << 10,
> +       "amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG=
_SIZE_KB_V1) " KB");
>
>  _Static_assert(
> -       sizeof(struct amd_sriov_msg_pf2vf_info) =3D=3D AMD_SRIOV_MSG_SIZE=
_KB << 10,
> -       "amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG=
_SIZE_KB) " KB");
> +       sizeof(struct amd_sriov_msg_pf2vf_info) =3D=3D AMD_SRIOV_MSG_SIZE=
_KB_V1 << 10,
> +       "amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG=
_SIZE_KB_V1) " KB");
>
>  _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 =3D=3D 0,
>                "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
> --
> 2.34.1
>
