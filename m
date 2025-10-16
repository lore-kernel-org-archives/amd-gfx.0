Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE31CCD194
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 12:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631D610E9D9;
	Thu, 16 Oct 2025 12:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aw9i9nbj";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A30710E9D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 12:57:05 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b5ca0345de8so10076a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760619425; x=1761224225; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHjKWfIj6uxDI3Fw4lNU5p0hD8B+aogiHtlYtYyhMUk=;
 b=aw9i9nbjIj0SD3x9r2KyiLfSg0UyDBAiVd7n6PJE/iKVnY4jHDFybGQ3p0C6xD1rwo
 7oubCBEt0E9JjMbMJ9tGbGE5m3TvGx6DAo/WhQTnjt8VsivFaLhqQk1LHiPZ8Y0jfGCC
 H0F06w3JfCb9eTvabg/v1s8k0/0zZton3bSxQHxztzD3mEq02AONbiQRKpLXZL4AAakM
 WaZjyQLlAbXgZ3nvsQOe3d/JdmhhwzIWnf1znzn7RHLUp8pWdxR65QiduWqbptAhSp2N
 ri1oRjMAmrqrSzLLMwysSA860kiUlgrS0OtbwlpW/MigAzXgT6YtC9XZeudO83M2Gab9
 OuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760619425; x=1761224225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHjKWfIj6uxDI3Fw4lNU5p0hD8B+aogiHtlYtYyhMUk=;
 b=CWkJue68awBOnJHQtMea8Hh/sNF4RRvQB18ooTnJAyUmDwU2RIpe3waJqlHgIasoto
 TGfhfL/gX8y29groFcqelUuAKirrDgpWMnxWDH0Ltj2SFoJI8XuHOYD5Zzbb+dlwLVMP
 hzQ0c0CFfG0/PnCMZPUvMD8FvwAbymqTVvWPcLVi+NXTjCmadYDdSSbUjzihjfyZhu+p
 7P/raC3dhyM3QklNj7N30+eD6L2cxKZwyDNojW/WrrsL+obzNKvJhGE0kul5BcvLan58
 WHbysgf/1iBRvSqyUH70xdV3aVPLCM2y3qtXQF1paGiqyh/i6fkeRbFiWGTdsLQduX6b
 f+QQ==
X-Gm-Message-State: AOJu0Yw529q03m6jN71NpOXWfhXNqM4O7NOTyrWKnNvD958Z0pXnOGly
 qFyytSbzROyTwIbzibFa6AA13Me6GSuMBHziE/HSk/1d/vdI3WunvxHRx8APJ14yjiKJWTP4Vmq
 DDqxyhLrwp8U4AamJBMqsvFK09vse5OE=
X-Gm-Gg: ASbGnctITy809u5g03pFFV8eeyE8RcsyC+kodZczq4USUH4hKZV9Ji42voEOjH3lR8K
 hDsG27Tj5bxc/DTKikYNIWGezDLN8tcRBoAIw72UOsZTsge3azndnHqakLPm36ctTCt2ZenL1yQ
 stj2Hj0XCfmScLpzHQZS9CWnDqdeK5LCsL0j2+b1zrQzYfEUJIi6bQhqRIloxmuwyhBgbqJsWWs
 LOJbI4Kc6/lcQ+7a/31gjUugdLcDRyl9a13RrkPekqyIGoRMK5Ivfx+6bcFW9g4fDS94RM=
X-Google-Smtp-Source: AGHT+IG2arCLkmCnquXQeRk3EbFLPpwUKEhpJZAfz3sdVhBqcLcHlpRMPntpjgforVjtbf71t82/8PJ782FacROWioI=
X-Received: by 2002:a17:902:c404:b0:277:c230:bfca with SMTP id
 d9443c01a7336-290273e17bfmr238944805ad.4.1760619424741; Thu, 16 Oct 2025
 05:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251015214848.11580-1-yunru.pan@amd.com>
In-Reply-To: <20251015214848.11580-1-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Oct 2025 08:56:52 -0400
X-Gm-Features: AS18NWCzb4yuy-3ekEnNeoZxxS4GHIoDI3c7BKtodUo42fY9j8kMbPkwPGmwozY
Message-ID: <CADnq5_NCb8=Eoh3tM8B8vTjV9MXvHtuOCq3vF8O8h2P325yygg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] drm/amdgpu: Updated naming of SRIOV critical
 region offsets/sizes with _V1 suffix
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

On Wed, Oct 15, 2025 at 6:06=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
>  - This change prepares the later patches to intro  _v2 suffix to SRIOV c=
ritical regions
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 20 ++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 50 +++++++++++++++------
>  2 files changed, 46 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index f96beb96c75c..8cd02eb605c5 100644
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
> index 3a79ed7d8031..7509756b9ac5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -23,26 +23,48 @@
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
> +#define AMD_SRIOV_MSG_SIZE_KB                           1
> +
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
> +#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1               AMD_SRIOV_MSG_DAT=
AEXCHANGE_OFFSET_KB_V1
> +#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1               \
> +       (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB)
> +#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1            \
> +       (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB)
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
> --
> 2.34.1
>
