Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C434C46CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 21:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8BA10E052;
	Mon, 18 Sep 2023 21:27:36 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49BC10E052
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 21:27:34 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1d66bf632bdso1710286fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695072454; x=1695677254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zpc+SxYvzojRaPgXwhmV/DwupF7Ll2YygevmsPAHcdw=;
 b=aJ1ZU8tpFKQ2rjPoYfBsOZtFeNJZsf4oPeGUf9DunbCR4sgOU85TsbZsGnkWEn/eLA
 YUKv0vTP6iSfAPRCdCB3Fqp7wkAQPqlwmtZA/9ZvwN14iH+00uv98eYKP+nSyqk1K2ph
 xN00DPeI12BBsVpOm1PODAKIjFhMMfxBz4qqzdLUpPBZLXVsvNLW1yu3RZ/VKaYZci1a
 CRbsq4ubM0iaFPbnuHcJncoUmTh9AwE4DmXmsRNbPOe0wSpF88Pl+feUy3EzlykSNHYa
 NbQafDoW1wnBzDyVIVqdTGb7s5fDIN6fhMBM1jMkEg2QWMIerIliN0uDhoBmTh24Uszq
 owyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695072454; x=1695677254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zpc+SxYvzojRaPgXwhmV/DwupF7Ll2YygevmsPAHcdw=;
 b=DgC6nI8N56OqJEtU6BkOh+LMtlGWKcpwuB34uMAysIX+CHZQV0VtGOABCONZ2IYO9+
 6l3OQ5PcU+rsJ2u46ntqAyp/epnXH8j5UKpOXAakH7E0N1R54elNrp3C/eOvrPPFBOwy
 sgdjvGD/LgmiLF6eCdDOB7UUAGOcNP0zHNX4NKMowi86MjZzvU5+5o+j0f30g9aNwkUL
 jEiT2bnSgfE4qVx9ZUpnJkvI5Ndf5y/eb4hg9qdvwsqCPTIHS1iv9AAKh9Qaf40uy8qT
 1i75fgCSuIB3WqpoG7MJBg1PPFESGniP3YeLkkLOn6D7GuPuLt8F3opdivaUUQ9Qeb/s
 p/iQ==
X-Gm-Message-State: AOJu0YxmExby7DDs/Db7Q4puaHHMUpgz/XruB3RduNXYRS7TQNpH3jER
 3CUXFcspTsAuHLJoGSC6ZpnjUkGbHLJJ9euE7gjGCv46
X-Google-Smtp-Source: AGHT+IEMyHnDcGfgHup+kaGfcBaqMFeExeGABqRlS4fM8xU2fL4Qk/VfQL/ix/pbl5u2YXqa30lg2BXE2E659RdjCXA=
X-Received: by 2002:a05:6870:7a9:b0:1d5:a377:f360 with SMTP id
 en41-20020a05687007a900b001d5a377f360mr10977464oab.41.1695072453978; Mon, 18
 Sep 2023 14:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230918165509.3852910-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20230918165509.3852910-1-sathishkumar.sundararaju@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Sep 2023 17:27:22 -0400
Message-ID: <CADnq5_NsCY12C9RebpT-Bn3rfQ6bQBguZZ=ExYHV=P96WgG84g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: update IP count INFO query
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Koenig Christian <Christian.Koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 18, 2023 at 4:32=E2=80=AFPM Sathishkumar S
<sathishkumar.sundararaju@amd.com> wrote:
>
> update the query to return the number of functional
> instances where there is more than an instance of the requested
> type and for others continue to return one.
>
> v2: count must reflect the actual number of engines (Alex)
> v3: fix wrong number of engines for vcn (Alex)
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Reviewed-by: Leo Liu <leo.liu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 90 +++++++++++++++++--------
>  1 file changed, 61 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 24d866ed5922..9d36f4d3fecb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -200,6 +200,44 @@ int amdgpu_driver_load_kms(struct amdgpu_device *ade=
v, unsigned long flags)
>         return r;
>  }
>
> +static enum amd_ip_block_type amdgpu_ip_get_block_type(
> +               struct amdgpu_device *adev, uint32_t ip)
> +{
> +       enum amd_ip_block_type type;
> +
> +       switch (ip) {
> +       case AMDGPU_HW_IP_GFX:
> +               type =3D AMD_IP_BLOCK_TYPE_GFX;
> +               break;
> +       case AMDGPU_HW_IP_COMPUTE:
> +               type =3D AMD_IP_BLOCK_TYPE_GFX;
> +               break;
> +       case AMDGPU_HW_IP_DMA:
> +               type =3D AMD_IP_BLOCK_TYPE_SDMA;
> +               break;
> +       case AMDGPU_HW_IP_UVD:
> +       case AMDGPU_HW_IP_UVD_ENC:
> +               type =3D AMD_IP_BLOCK_TYPE_UVD;
> +               break;
> +       case AMDGPU_HW_IP_VCE:
> +               type =3D AMD_IP_BLOCK_TYPE_VCE;
> +               break;
> +       case AMDGPU_HW_IP_VCN_DEC:
> +       case AMDGPU_HW_IP_VCN_ENC:
> +               type =3D AMD_IP_BLOCK_TYPE_VCN;
> +               break;
> +       case AMDGPU_HW_IP_VCN_JPEG:
> +               type =3D (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOC=
K_TYPE_JPEG)) ?
> +                                  AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_=
TYPE_VCN;
> +               break;
> +       default:
> +               type =3D AMD_IP_BLOCK_TYPE_NUM;
> +               break;
> +       }
> +
> +       return type;
> +}
> +
>  static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info=
,
>                                 struct drm_amdgpu_query_fw *query_fw,
>                                 struct amdgpu_device *adev)
> @@ -600,45 +638,39 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>         }
>         case AMDGPU_INFO_HW_IP_COUNT: {
>                 enum amd_ip_block_type type;
> +               struct amdgpu_ip_block *ip_block =3D NULL;
>                 uint32_t count =3D 0;
>
> -               switch (info->query_hw_ip.type) {
> -               case AMDGPU_HW_IP_GFX:
> -                       type =3D AMD_IP_BLOCK_TYPE_GFX;
> -                       break;
> -               case AMDGPU_HW_IP_COMPUTE:
> -                       type =3D AMD_IP_BLOCK_TYPE_GFX;
> -                       break;
> -               case AMDGPU_HW_IP_DMA:
> -                       type =3D AMD_IP_BLOCK_TYPE_SDMA;
> -                       break;
> -               case AMDGPU_HW_IP_UVD:
> -                       type =3D AMD_IP_BLOCK_TYPE_UVD;
> +               type =3D amdgpu_ip_get_block_type(adev, info->query_hw_ip=
.type);
> +               ip_block =3D amdgpu_device_ip_get_ip_block(adev, type);
> +               if (!ip_block || !ip_block->status.valid)
> +                       return -EINVAL;
> +
> +               switch (type) {
> +               case AMD_IP_BLOCK_TYPE_GFX:
> +               case AMD_IP_BLOCK_TYPE_VCE:
> +                       count =3D 1;
>                         break;
> -               case AMDGPU_HW_IP_VCE:
> -                       type =3D AMD_IP_BLOCK_TYPE_VCE;
> +               case AMD_IP_BLOCK_TYPE_SDMA:
> +                       count =3D adev->sdma.num_instances;
>                         break;
> -               case AMDGPU_HW_IP_UVD_ENC:
> -                       type =3D AMD_IP_BLOCK_TYPE_UVD;
> +               case AMD_IP_BLOCK_TYPE_JPEG:
> +                       count =3D adev->jpeg.num_jpeg_inst * adev->jpeg.n=
um_jpeg_rings;
>                         break;
> -               case AMDGPU_HW_IP_VCN_DEC:
> -               case AMDGPU_HW_IP_VCN_ENC:
> -                       type =3D AMD_IP_BLOCK_TYPE_VCN;
> +               case AMD_IP_BLOCK_TYPE_VCN:
> +                       count =3D adev->vcn.num_vcn_inst;
>                         break;
> -               case AMDGPU_HW_IP_VCN_JPEG:
> -                       type =3D (amdgpu_device_ip_get_ip_block(adev, AMD=
_IP_BLOCK_TYPE_JPEG)) ?
> -                               AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYP=
E_VCN;
> +               case AMD_IP_BLOCK_TYPE_UVD:
> +                       count =3D adev->uvd.num_uvd_inst;
>                         break;
> +               /* For all other IP block types not listed in the switch =
statement
> +                * the ip status is valid here and the instance count is =
one.
> +                */
>                 default:
> -                       return -EINVAL;
> +                       count =3D 1;
> +                       break;
>                 }
>
> -               for (i =3D 0; i < adev->num_ip_blocks; i++)
> -                       if (adev->ip_blocks[i].version->type =3D=3D type =
&&
> -                           adev->ip_blocks[i].status.valid &&
> -                           count < AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
> -                               count++;
> -
>                 return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT=
 : 0;
>         }
>         case AMDGPU_INFO_TIMESTAMP:
> --
> 2.25.1
>
