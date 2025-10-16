Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46DFCCD19A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 13:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C8510E9DF;
	Thu, 16 Oct 2025 13:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HWcWSjWb";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3978110E9DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 13:09:05 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-339d7c401d8so157798a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760620145; x=1761224945; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8cSqMBYQMpAUWJjoCdvA1lhKOSHEakXgOwgNTKAack=;
 b=HWcWSjWbGv15l3yZHlUXSyHYxoH0K21gqCEgr0T20DCG4yEpAd7JXnLFmg7iACCW78
 5ooQrq2xNIaIHo0oFTWtpw6McokF8Jzek94kHzlSMTDJd7jsUqJRu2Dmg5e1FklbcEsv
 sIbrzPnNXgFRaENZ6y0XmkCkHblTAOp3N4pr7b/60kVc2he0cYOtilZVv9u8r7ns30pm
 h0eW6TrBrNfZftvu7P/oE5m97zveXXEDwvLioAmbbV47DIYuxzjICP9H9v/3bHcG1pen
 4JlIJhQ7nPFJesBudBVHM8QcVhakemAQ305g/DB2NibowE8l4tCCWvG2wVNSQOM6LGWP
 98iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760620145; x=1761224945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I8cSqMBYQMpAUWJjoCdvA1lhKOSHEakXgOwgNTKAack=;
 b=tITVzuUsH+siIkMVIp5VzMf6DcfskcpSfOKo/y9tQd8JZaitL9GuPwaSyz4Dy1jWsB
 5oPye/bgtfp2Ur5Yq383pjpOr1EPsQOPXiK3+2oJbyiXPGjCAYwEbTPeviPuNVQtAfup
 kPgeG11H2yhWTFBe9bQ5Jdwx+voigfqOxU66+FDu0pvElXfqXh3goOa1TMJaL21uBIr5
 dzLpFruTBNOV14QGMG3K5nyfKFLZA+CD6WvJzzLl10qCeLIXswHBxL1OByCsUIwlUUf6
 OlpECJG+W7Qw4nD2ecvOLrci118jGiav54BIVfvR3ZcN+TgXOun6/xjf9SBFTCKzfDof
 ZWaw==
X-Gm-Message-State: AOJu0YxzXdqdNN3++m6lwzQI4lKxprcwc1geZUo9LSwUDxGXJ0q+SQAj
 Xx9691KjhHKv2VR8oO4o5rHwE/sXk7tM2nEv++/EN8MVQdW16r7c+1UZVIYpga0ON8jnr4czIQA
 X4Dgl/y3l6qpTEwYQFMMonWQqdRpidcE=
X-Gm-Gg: ASbGncsAh9mfmUQMKNASwlb61Jxsu1qq7VSS62SIw5ZdDZcec9nNfMVtPnRFTfcrRpQ
 6z9E+Ira9LvOG1qYGGEnwyVsMCzyl1efOLka/M6r63GjwmpZVfYf4sJ9vWQ9As8C9QFqvuRERFg
 ag/KXSkVRGhcsG9cZQBKBNNmHi7v7GtalJRVZEldlWUphzA1aYfQpMNe6aQlioWqJGTueFaMpfD
 H7JsnOVbH9YxZ0vtJrO3EJS2f6XiYHHMBlH5mDpfMxZUE8462HeRfTdhyof
X-Google-Smtp-Source: AGHT+IFO7WDD94hAmPS6mIhfV+V+L/u+tTCuJyvdAg0YbOjWhWSAWqY4g4kxbs5v0Vm6D713ZMac5W1sy+hOwM+zUTc=
X-Received: by 2002:a17:902:fb8b:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-2902743ae8fmr152710325ad.6.1760620144519; Thu, 16 Oct 2025
 06:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251015214848.11580-1-yunru.pan@amd.com>
 <20251015214848.11580-2-yunru.pan@amd.com>
In-Reply-To: <20251015214848.11580-2-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Oct 2025 09:08:52 -0400
X-Gm-Features: AS18NWDggbyrwKGzw8xlIRvrZxzdOHSbyWfDQu_QQxAOdqv057BGnmL6IUCUGtQ
Message-ID: <CADnq5_OPzxM7RF6Cmis9iNBfu8cvAxMU9NPb2TZW2=0WMnWcMQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
 during VF init
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
>     1. Introduced amdgpu_virt_init_critical_region during VF init.
>      - VFs use init_data_header_offset and init_data_header_size_kb
>             transmitted via PF2VF mailbox to fetch the offset of
>             critical regions' offsets/sizes in VRAM and save to
>             adev->virt.crit_region_offsets and adev->virt.crit_region_siz=
es_kb.
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 165 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  11 ++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++
>  4 files changed, 211 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a99185ed0642..3ffb9bb1ec0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2782,6 +2782,10 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>                 r =3D amdgpu_virt_request_full_gpu(adev, true);
>                 if (r)
>                         return r;
> +
> +               r =3D amdgpu_virt_init_critical_region(adev);
> +               if (r)
> +                       return r;
>         }
>
>         switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 56573fb27f63..805ecc69a8b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -44,6 +44,18 @@
>                 vf2pf_info->ucode_info[ucode].version =3D ver; \
>         } while (0)
>
> +#define mmRCC_CONFIG_MEMSIZE    0xde3
> +
> +const char *amdgpu_virt_dynamic_crit_table_name[] =3D {
> +       "IP DISCOVERY",
> +       "VBIOS IMG",
> +       "RAS TELEMETRY",
> +       "DATA EXCHANGE",
> +       "BAD PAGE INFO",
> +       "INIT HEADER",
> +       "LAST",
> +};
> +
>  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
>  {
>         /* By now all MMIO pages except mailbox are blocked */
> @@ -843,6 +855,159 @@ static void amdgpu_virt_init_ras(struct amdgpu_devi=
ce *adev)
>         adev->virt.ras.cper_rptr =3D 0;
>  }
>
> +static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start,=
 uint8_t *buf_end)
> +{
> +       uint32_t sum =3D 0;
> +
> +       if (buf_start >=3D buf_end)
> +               return 0;
> +
> +       for (; buf_start < buf_end; buf_start++)
> +               sum +=3D buf_start[0];
> +
> +       return 0xffffffff - sum;
> +}
> +
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
> +{
> +       struct amd_sriov_msg_init_data_header *init_data_hdr =3D NULL;
> +       uint32_t init_hdr_offset =3D adev->virt.init_data_header.offset;
> +       uint32_t init_hdr_size =3D adev->virt.init_data_header.size_kb <<=
 10;
> +       uint64_t vram_size;
> +       int r =3D 0;
> +       uint8_t checksum =3D 0;
> +
> +       /* Skip below init if critical region version !=3D v2 */
> +       if (adev->virt.req_init_data_ver !=3D GPU_CRIT_REGION_V2)
> +               return 0;
> +
> +       if (init_hdr_offset < 0) {
> +               dev_err(adev->dev, "Invalid init header offset\n");
> +               return -EINVAL;
> +       }
> +
> +       vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE);
> +       if (!vram_size || vram_size =3D=3D U32_MAX)
> +               return -EINVAL;
> +       vram_size <<=3D 20;
> +
> +       if ((init_hdr_offset + init_hdr_size) > vram_size) {
> +               dev_err(adev->dev, "init_data_header exceeds VRAM size, e=
xiting\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Allocate for init_data_hdr */
> +       init_data_hdr =3D kzalloc(sizeof(struct amd_sriov_msg_init_data_h=
eader), GFP_KERNEL);
> +       if (!init_data_hdr)
> +               return -ENOMEM;
> +
> +       amdgpu_device_vram_access(adev, (uint64_t)init_hdr_offset, (uint3=
2_t *)init_data_hdr,
> +                                       sizeof(struct amd_sriov_msg_init_=
data_header), false);
> +
> +       /* Table validation */
> +       if (strncmp(init_data_hdr->signature,
> +                               AMDGPU_SRIOV_CRIT_DATA_SIGNATURE,
> +                               AMDGPU_SRIOV_CRIT_DATA_SIG_LEN) !=3D 0) {
> +               dev_err(adev->dev, "Invalid init data signature: %.4s\n",
> +                       init_data_hdr->signature);
> +               r =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       checksum =3D amdgpu_virt_crit_region_calc_checksum(
> +                       (uint8_t *)&init_data_hdr->initdata_offset,
> +                       (uint8_t *)init_data_hdr +
> +                       sizeof(struct amd_sriov_msg_init_data_header));
> +       if (checksum !=3D init_data_hdr->checksum) {
> +               dev_err(adev->dev, "Found unmatching checksum from calcul=
ation 0x%x and init_data 0x%x\n",
> +                               checksum, init_data_hdr->checksum);
> +               r =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       memset(&adev->virt.crit_regn, 0, sizeof(adev->virt.crit_regn));
> +       memset(adev->virt.crit_regn_tbl, 0, sizeof(adev->virt.crit_regn_t=
bl));
> +
> +       adev->virt.crit_regn.offset =3D init_data_hdr->initdata_offset;
> +       adev->virt.crit_regn.size_kb =3D init_data_hdr->initdata_size_in_=
kb;
> +
> +       /* Validation and initialization for each table entry */
> +       if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_I=
PD_TABLE_ID)) {
> +               if (init_data_hdr->ip_discovery_size_in_kb > DISCOVERY_TM=
R_SIZE) {
> +                       dev_err(adev->dev, "Invalid IP discovery size: 0x=
%x\n",
> +                                       init_data_hdr->ip_discovery_size_=
in_kb);
> +                       r =3D -EINVAL;
> +                       goto out;
> +               }
> +
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offs=
et =3D
> +                       init_data_hdr->ip_discovery_offset;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size=
_kb =3D
> +                       init_data_hdr->ip_discovery_size_in_kb;
> +       } else {
> +               dev_err(adev->dev, "Missing dynamic %s info from critical=
 region v2.\n",
> +                       amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG=
_IPD_TABLE_ID]);
> +               r =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_V=
BIOS_IMG_TABLE_ID)) {
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID=
].offset =3D
> +                       init_data_hdr->vbios_img_offset;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID=
].size_kb =3D
> +                       init_data_hdr->vbios_img_size_in_kb;
> +       } else {
> +               dev_err(adev->dev, "Missing dynamic %s info from critical=
 region v2.\n",
> +                       amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG=
_VBIOS_IMG_TABLE_ID]);
> +               r =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_R=
AS_TELEMETRY_TABLE_ID)) {
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABL=
E_ID].offset =3D
> +                       init_data_hdr->ras_tele_info_offset;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABL=
E_ID].size_kb =3D
> +                       init_data_hdr->ras_tele_info_size_in_kb;
> +       } else {
> +               dev_err(adev->dev, "Missing dynamic %s info from critical=
 region v2.\n",
> +                       amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG=
_RAS_TELEMETRY_TABLE_ID]);
> +               r =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_D=
ATAEXCHANGE_TABLE_ID)) {
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE=
_ID].offset =3D
> +                       init_data_hdr->dataexchange_offset;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE=
_ID].size_kb =3D
> +                       init_data_hdr->dataexchange_size_in_kb;
> +       } else {
> +               dev_err(adev->dev, "Missing dynamic %s info from critical=
 region v2.\n",
> +                       amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG=
_DATAEXCHANGE_TABLE_ID]);
> +               r =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_B=
AD_PAGE_INFO_TABLE_ID)) {
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABL=
E_ID].offset =3D
> +                       init_data_hdr->bad_page_info_offset;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABL=
E_ID].size_kb =3D
> +                       init_data_hdr->bad_page_size_in_kb;
> +       } else {
> +               dev_err(adev->dev, "Missing dynamic %s info from critical=
 region v2.\n",
> +                       amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG=
_BAD_PAGE_INFO_TABLE_ID]);
> +               r =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       adev->virt.is_dynamic_crit_regn_enabled =3D true;
> +
> +out:
> +       kfree(init_data_hdr);
> +       init_data_hdr =3D NULL;
> +
> +       return r;
> +}
> +
>  void amdgpu_virt_init(struct amdgpu_device *adev)
>  {
>         bool is_sriov =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.h
> index 36247a160aa6..8d03a8620de9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -54,6 +54,12 @@
>
>  #define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
>
> +/* Signature used to validate the SR-IOV dynamic critical region init da=
ta header ("INDA") */
> +#define AMDGPU_SRIOV_CRIT_DATA_SIGNATURE "INDA"
> +#define AMDGPU_SRIOV_CRIT_DATA_SIG_LEN   4
> +
> +#define IS_SRIOV_CRIT_REGN_ENTRY_VALID(hdr, id) ((hdr)->valid_tables & (=
1 << (id)))
> +
>  enum amdgpu_sriov_vf_mode {
>         SRIOV_VF_MODE_BARE_METAL =3D 0,
>         SRIOV_VF_MODE_ONE_VF,
> @@ -296,6 +302,9 @@ struct amdgpu_virt {
>
>         /* dynamic(v2) critical regions */
>         struct amdgpu_virt_region init_data_header;
> +       struct amdgpu_virt_region crit_regn;
> +       struct amdgpu_virt_region crit_regn_tbl[AMD_SRIOV_MSG_MAX_TABLE_I=
D];
> +       bool is_dynamic_crit_regn_enabled;
>
>         /* vf2pf message */
>         struct delayed_work vf2pf_work;
> @@ -432,6 +441,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *=
adev);
>  void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>  void amdgpu_virt_init(struct amdgpu_device *adev);
>
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>  int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>  void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgv_sriovmsg.h
> index 9228fd2c6dfd..1cee083fb6bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -71,6 +71,37 @@ enum amd_sriov_crit_region_version {
>         GPU_CRIT_REGION_V2 =3D 2,
>  };
>
> +/* v2 layout offset enum (in order of allocation) */
> +enum amd_sriov_msg_table_id_enum {
> +       AMD_SRIOV_MSG_IPD_TABLE_ID =3D 0,
> +       AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
> +       AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
> +       AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
> +       AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
> +       AMD_SRIOV_MSG_INITD_H_TABLE_ID,
> +       AMD_SRIOV_MSG_MAX_TABLE_ID,
> +};
> +
> +struct amd_sriov_msg_init_data_header {
> +       char     signature[4];  /* "INDA"  */
> +       uint32_t version;
> +       uint32_t checksum;
> +       uint32_t initdata_offset; /* 0 */
> +       uint32_t initdata_size_in_kb; /* 5MB */
> +       uint32_t valid_tables;
> +       uint32_t vbios_img_offset;
> +       uint32_t vbios_img_size_in_kb;
> +       uint32_t dataexchange_offset;
> +       uint32_t dataexchange_size_in_kb;
> +       uint32_t ras_tele_info_offset;
> +       uint32_t ras_tele_info_size_in_kb;
> +       uint32_t ip_discovery_offset;
> +       uint32_t ip_discovery_size_in_kb;
> +       uint32_t bad_page_info_offset;
> +       uint32_t bad_page_size_in_kb;
> +       uint32_t reserved[8];
> +};
> +
>  /*
>   * PF2VF history log:
>   * v1 defined in amdgim
> --
> 2.34.1
>
