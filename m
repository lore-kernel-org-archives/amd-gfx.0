Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8905CCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 13:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EFD10E076;
	Mon, 13 Oct 2025 13:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UdiV1DHj";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F1010E076
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 13:32:30 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2697051902fso9144295ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760362350; x=1760967150; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5RJuylPq4bluEbzfaLrBgsqmhkKmcim7u82r8QNzTk=;
 b=UdiV1DHjQLLcC6DA7h+w2UHrxxmRVcLGZq274NR6pqe+GnS42enrbG9IGU3cLFnqc+
 ojtVhTfbCgP0jP/kFfIVyU/LWpBPw7qrYwBuLqbl+OpS/60b/xMlsLztSoNA2Fqbzxb6
 CZDwGrG95jWQsrMDMSf9ChFfCT6g45LjJgpKu2uoh8eltRzt6zAiePm+nlmgDDLZqhCl
 RyETPkch/9mMmJKAoatS5xFGhRdNzN0KyK07fZ/+156ja2nf/WjgWagyBeXBlP75uL0E
 2el5Nxqh6fYyC51w0VEoOQhobyKkR+n8gv8W0cEZuukdnq1eZsg3Mxa+yPyBqrC3YTd2
 9IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760362350; x=1760967150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5RJuylPq4bluEbzfaLrBgsqmhkKmcim7u82r8QNzTk=;
 b=AW3XbsZrukCW4fH7YiLT5CjG9tLDqqssy1qZFQfoPENWEXBpNILj3XDl+IDxOeN7ae
 AZ9RIOwwyLlrt+MfVhOsxHZflsLtpLLHS/nAcrnKUbLc4FGYrL5Dtu8/Wk59iSxOVvW9
 J8XeADP2DeX4v30ZldQrBYnC2BiK1S1WRlbvsiV08kgtVlmJwk96bZp2hANxNXBYIwGO
 YtNdB9uSfiG7OzqJS6EkUgvbsKinO7bjkteq8hK5bREgMzmJxyXKQjemZoH5yiIGeKDe
 zWEfB+mR66nTqmtJcXAmLs7KKrBlvD5ZQLO5jq8lDF3N0F9br34uR4NK3kAH35rBaF4p
 23sw==
X-Gm-Message-State: AOJu0YzzgTt48+VTtmG0Hh7CfdV+Yhhjl5Gpq0zG7wFljGUUR0r23viE
 rXKhwTaC71NLbAytin7ev/FBxzlZJArs1q7d5MwoIQlLGgT+QhezcN1Xty+W8PSFb0NywIwZWTZ
 SQSwXqK8ZXTV2xYl5rvF1JjsB32qdqcnl5w==
X-Gm-Gg: ASbGncuRgXyiOIslhpV5wvwAAp16doxJkR/xZdFuQi9Xw3zOJnfQcju2N8Prm1ZgE5c
 OX4PDpj8pUMioXhREqN/M7v+kXnf3Q5tzHJAUc3sKMiSBgScKWVJFh2g/9vvm4J5LAuFiAMyE7n
 aMR74K5ygH3DDkaNfXqE2CpxUvA1y30xLYcT2pUl2ZCmcAJM9RaVacuW8ttZ6n9AjCevce3Ccuw
 S31+8cLA4nSSFjPF+0tHK0yqeeCuYJcJNPu
X-Google-Smtp-Source: AGHT+IF3uSYkUHiknF+oJ6z9vhHQjPXnGW9nSwsmNpGASejQUMhEmUynNK8owLx4NR/W7ma/5JtXV8eMfP11uxw4s1A=
X-Received: by 2002:a17:902:f541:b0:276:76e1:2e78 with SMTP id
 d9443c01a7336-29027336d54mr174003685ad.10.1760362349740; Mon, 13 Oct 2025
 06:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251010184849.9701-1-yunru.pan@amd.com>
In-Reply-To: <20251010184849.9701-1-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Oct 2025 09:32:17 -0400
X-Gm-Features: AS18NWD8ppvZSp3PJggrmOqtsJiX9CJtAW7oHGmgZQr3ek73UcT_7JkScOyR9Tw
Message-ID: <CADnq5_MbDRHpVZpXrY5qd1TDceAE_KF1W22DRPpBCKPBAunHvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] drm/amdgpu: Updated naming of SRIOV critical
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

On Fri, Oct 10, 2025 at 2:56=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
>  - This change prepares the later patches to intro  _v2 suffix to SRIOV c=
ritical regions
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

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
