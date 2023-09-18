Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA92C46CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 14:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9787310E0C7;
	Mon, 18 Sep 2023 14:28:07 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3E910E0C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 14:28:05 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-573912a7b14so2751609eaf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695047285; x=1695652085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnu3xz+BTMLxah5q72FqDIrDllwbcvK/foikBS+0OKo=;
 b=QMlAp5DLsuoq8Pi829jilDQSzoJbnVqteRXjPyxZrVSwlpIblaquA7e3DqrE2f7/HY
 Wd63P4dFVEmGneO90aLMAETTIykT+dE3FRQ9fAtEPMQlTPBIR6/9TPAlYMrMWKdOFUlW
 9jYmSmWpZy2t7zXHgfHQpryQuCl4HPznnwO7Gk51cxjDpxLeKS2cf5JyTtM8xfNGSLGV
 iX2m1KT6kXSyDR9P7DUE+MPCt2Bujc+xboUEVSBnaRlXOcpOzDGZri+l0IeMEK3RLY4v
 JKxud1kj2oFV9nU5LGwf52hC5rD95+10HYrHNyx9IITjS14vxKunt9MoBAE8dv64+G9T
 B+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695047285; x=1695652085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnu3xz+BTMLxah5q72FqDIrDllwbcvK/foikBS+0OKo=;
 b=NPgH6qrw5R7YwsweYSEkURZKnCmXOzK7TTgZNoI+vTKypd7+gXYB0Vg+ouG5Y35BPJ
 XkGVwrjaAeaUcTafkqnPiczIgPjvoD5bEwEJ8pN7tbVWb+v3UA3Dor1Gs6OOhIZgjNtI
 AyQek4itkmybD3KUQ2JJp7amCvTEC/EJghbQSE8cIVXF3mhBNwN9Kp5ux5fE3NIKwNi1
 wHRV7N8+k9z5k7mvQzy6v7Fj2VF1ZRqRaIJorQ9e0fYLU5zD2gnKo8SEpodxdALWLMae
 w/diATgsMnKb5dJrkryeHoJiHfkT/sp19M8XsLB6nFzBSjEYP0hqr2jVZMB3WTTaTUDc
 myBg==
X-Gm-Message-State: AOJu0YykVmLLcYUc1tg6a6G4NIJGFVJ2dqeLzsdXwUyA5XDSoh3Nq/n9
 eWUu1W7bAjDHRBZcG83gm4goMxxzXZkdT7loAdTIdEq+YKU=
X-Google-Smtp-Source: AGHT+IHZvmiwZ7nCImckYI47pId5ny/ng4ileWSovaTNMmKSutYVjJLOTFD7b0KETZ5UAILwBOXF/ZRocR1v5QLtprY=
X-Received: by 2002:a05:6870:d153:b0:1d5:3fd3:390a with SMTP id
 f19-20020a056870d15300b001d53fd3390amr11095751oac.49.1695047284744; Mon, 18
 Sep 2023 07:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230915192421.3602660-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20230915192421.3602660-1-sathishkumar.sundararaju@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Sep 2023 10:27:53 -0400
Message-ID: <CADnq5_O6VkW+EGmXrAiMFeFb9yasPB_6cetRZ93JacFNfw2FYQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: update IP count INFO query
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

On Sat, Sep 16, 2023 at 11:01=E2=80=AFPM Sathishkumar S
<sathishkumar.sundararaju@amd.com> wrote:
>
> update the query to return the number of functional
> instances where there is more than an instance of the requested
> type and for others continue to return one.
>
> v2: count must reflect the actual number of engines (Alex)
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 92 +++++++++++++++++--------
>  1 file changed, 63 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 24d866ed5922..56273a7c9028 100644
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
> @@ -600,45 +638,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
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
> +                       count =3D (info->query_hw_ip.type =3D=3D AMDGPU_H=
W_IP_VCN_ENC) ?
> +                               adev->vcn.num_vcn_inst * adev->vcn.num_en=
c_rings :
> +                               adev->vcn.num_vcn_inst;

Is this correct?  JPEG has a 1:1 mapping from ring to engine, but I
think VCN is usually multiple rings per engine.  Shouldn't this just
return adev->vcn.num_vcn_inst?

Alex


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
