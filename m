Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CD9CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 15:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1141110EC43;
	Fri, 10 Oct 2025 15:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m7k7fS50";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA5910EC43
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 15:04:30 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-26987b80720so4644715ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760108670; x=1760713470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYfj2Sy09OPlZ6KkpaUdcSsF0Mtg8CiWiWuiVtCHUtI=;
 b=m7k7fS50lnN85faPb/HlHG9A41xtBTik/yaYp488LoVIuJhndkEFWqP+dzhDZ+TE9o
 x9D3BPlBa7dUcsfAugAuL2RBQI3ml+f8L0Nl1t1T8LeIaaW1vqqqopSPprlpXuRK5Gw0
 +v7vcS6PEPEqrapkm17yYVosovvoxvstKgroZ0UHT31no+b2hhI/DgrvrP/aLfvh/I2o
 jKAUi7eCpWKkfE+MeiwfIgE2Ix0NiNn6V1wKW+1Qc2EAr9pJpcAn1KF7QlepGrKZA5Qi
 s2qck3npNiwKwcGQVCiD51chFazSYlzQOPjBGG1FiTUweRE0PT3WMDD7AWXVqt8K4fVX
 hJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760108670; x=1760713470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WYfj2Sy09OPlZ6KkpaUdcSsF0Mtg8CiWiWuiVtCHUtI=;
 b=DncPI38lg3XDYgQegGghK2eLXP9ElzFTUmtPWGS7k9wNSVh5VW6dhT56nWFuRmQHSb
 vnnUUMs1WVhbmLQYMIhqbiebKSWg3s2GesrRp+MBbAbcUY0iX3Pj5AippoRcwoX6U77k
 mIaZUKYqXl6/8WKL69khi+HQ/Eb1DXpm4QnG8jJMIdNe0EBkhvaDLYLbTmG4PFHfoiQn
 YVLdNH2LlF9upGQMnf1bfeKxnsDLgvb6Fp50VBfF0RuKvx33YxNuxK4HTN3XTrYPJADO
 hHib6prC1EvSJQtmH2dGjKuMDw7KPk7H0WX4nh6MwnH1k3oTDUiEyWrZMJ7HVdQ84RzA
 Qo1A==
X-Gm-Message-State: AOJu0YxNMszjLI5jd8KVU7f8fhRbN9bKurr9ixMzBfQUHa9t4KeXWdI5
 Z1ndv8i85fej06/COo8NHuygnEkYmGGPCmXvyanXzQ116C00e2jYhTcn8rWESY91wHyGcf4rsoU
 GnJhZMr6qHOB981W4Zl5OAvzM5Yo4Mr0=
X-Gm-Gg: ASbGncuZq8xkvJBVcb3zodBXstUVj+hpbfM75iYVUKxcFamKvAzJoHocPqwE6EwBIgz
 TzHfraYUTtPzqKi0gyCHE08FIgdlhCmV0P72idC7bkiTHWInsnOSrQTDfS6OVxhagdiJ3SKNp31
 Xf9uCeVcCbZXxCQkirPjQ1qm8KmgmeBklZGcQVoAaA6gh2ZL7X8e/MI+uOlB2dx1KOyG2DCFiGe
 zUUw3qEgXypF41s+JccYqBKh3ZwIe4zTABO
X-Google-Smtp-Source: AGHT+IF6GxCkpczs67HWwg759geS+A33A/f7E8ZhSK5N5VphYEXU5TiUjBezXO2hzhBMjpcT+uxURxRcArjNXvpXyqQ=
X-Received: by 2002:a17:902:c94c:b0:28e:aacb:e6f7 with SMTP id
 d9443c01a7336-2902723ca5dmr85710885ad.3.1760108670059; Fri, 10 Oct 2025
 08:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20251010044309.11822-1-yunru.pan@amd.com>
 <20251010044309.11822-3-yunru.pan@amd.com>
In-Reply-To: <20251010044309.11822-3-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Oct 2025 11:04:18 -0400
X-Gm-Features: AS18NWAdvrnup4o_pyDMkiWXSUUBXymlYWbzwEWTfqfLBdHRWECwJyiwxBTt_aM
Message-ID: <CADnq5_MxtuHUYeM_EHkd3Kg0pVVebh95jtNV1jMqL+0OmsYaXQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
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

On Fri, Oct 10, 2025 at 12:43=E2=80=AFAM Ellen Pan <yunru.pan@amd.com> wrot=
e:
>
>     1. Introduced amdgpu_virt_init_critical_region during VF init.
>      - VFs use init_data_header_offset and init_data_header_size_kb
>             transmitted via PF2VF mailbox to fetch the offset of
>             critical regions' offsets/sizes in VRAM and save to
>             adev->virt.crit_region_offsets and adev->virt.crit_region_siz=
es_kb.
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 113 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |   7 ++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++++
>  4 files changed, 155 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 929936c8d87c..351cfe03a1aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2754,6 +2754,10 @@ static int amdgpu_device_ip_early_init(struct amdg=
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
> index 3a6b0e1084d7..6eca5e8a7375 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -843,6 +843,119 @@ static void amdgpu_virt_init_ras(struct amdgpu_devi=
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
> +       uint64_t pos =3D 0;
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
> +       pos =3D (uint64_t)init_hdr_offset;
> +       amdgpu_device_vram_access(adev, pos, (uint32_t *)init_data_hdr,
> +                                       sizeof(struct amd_sriov_msg_init_=
data_header), false);
> +
> +       switch (init_data_hdr->version) {
> +       case GPU_CRIT_REGION_V2:
> +               if (strncmp(init_data_hdr->signature, "INDA", 4) !=3D 0) =
{
> +                       dev_err(adev->dev, "Invalid init data signature: =
%.4s\n",
> +                                       init_data_hdr->signature);
> +                       r =3D -EINVAL;
> +                       goto out;
> +               }
> +
> +               checksum =3D amdgpu_virt_crit_region_calc_checksum(
> +                               (uint8_t *)&init_data_hdr->initdata_offse=
t,
> +                               (uint8_t *)init_data_hdr +
> +                               sizeof(struct amd_sriov_msg_init_data_hea=
der));
> +               if (checksum !=3D init_data_hdr->checksum) {
> +                       dev_err(adev->dev, "Found unmatching checksum fro=
m calculation 0x%x and init_data 0x%x\n",
> +                                       checksum, init_data_hdr->checksum=
);
> +                       r =3D -EINVAL;
> +                       goto out;
> +               }
> +
> +               /* Initialize critical region offsets */
> +               adev->virt.crit_regn.offset =3D init_data_hdr->initdata_o=
ffset;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offs=
et =3D
> +                       init_data_hdr->ip_discovery_offset;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID=
].offset =3D
> +                       init_data_hdr->vbios_img_offset;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABL=
E_ID].offset =3D
> +                       init_data_hdr->ras_tele_info_offset;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE=
_ID].offset =3D
> +                       init_data_hdr->dataexchange_offset;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABL=
E_ID].offset =3D
> +                       init_data_hdr->bad_page_info_offset;
> +
> +               /* Initialize critical region sizes */
> +               adev->virt.crit_regn.size_kb =3D init_data_hdr->initdata_=
size_in_kb;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size=
_kb =3D
> +                       init_data_hdr->ip_discovery_size_in_kb;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID=
].size_kb =3D
> +                       init_data_hdr->vbios_img_size_in_kb;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABL=
E_ID].size_kb =3D
> +                       init_data_hdr->ras_tele_info_size_in_kb;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE=
_ID].size_kb =3D
> +                       init_data_hdr->dataexchange_size_in_kb;
> +               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABL=
E_ID].size_kb =3D
> +                       init_data_hdr->bad_page_size_in_kb;
> +
> +               adev->virt.is_dynamic_crit_regn_enabled =3D true;
> +               break;
> +       default:
> +               dev_err(adev->dev, "Invalid init header version: %u\n",
> +                               init_data_hdr->version);
> +               r =3D -EINVAL;
> +               goto out;
> +       }
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
> index 51ff73b1fcd5..bc1fc1c6daba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -52,6 +52,8 @@
>  /* tonga/fiji use this offset */
>  #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
>
> +#define mmRCC_CONFIG_MEMSIZE   0xde3

Better to put this in amdgpu_virt.c where it is used so we don't get
conflicts if amdgpu_virt.h is included with a register header
somewhere.  With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +
>  #define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
>
>  enum amdgpu_sriov_vf_mode {
> @@ -296,6 +298,9 @@ struct amdgpu_virt {
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
> @@ -432,6 +437,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *=
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
> index b53caab5b706..d15c256f9abd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -70,6 +70,37 @@ enum amd_sriov_crit_region_version {
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
