Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A90EE71083
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 14:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B687310E0EF;
	Thu, 21 Sep 2023 14:47:35 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3120010E0EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 14:47:35 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57129417cecso519353eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695307654; x=1695912454; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KLQ/xnaI4+3RA1YXnTzrkfLYoA/KTVRE9AjZd5QSKM=;
 b=ATiY3eOJxdBvbZoNds5JDxq5IIMGF9dTKbvyvz+A042XRzhTvyRnKguZF+SY55HMOV
 UiUGaxk+hmGgwicWokay4nififAw6i5mtXsIq7TS5NQxqj6LSA2jo7qDvWfttZCmdXc0
 gKOf8xdPP1kxbhTK4/PaVeA8pXORkzumRTC3wNcQ/vHybW7mVFs6JFlpIty9qepqhihr
 9ad8Bepwd8fKDwBZ4pMh3jbvFSsXEQuxNovluP4RJ7uHD5qiWBWaB7NTUc2yKC3CZ77f
 7bmfgFOa3iCknpdySR/sVxwFOfnw0jDrcq7azasdSXrX7mKB/8jyDBeFEKE5ZYZ+ygYi
 4vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695307654; x=1695912454;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KLQ/xnaI4+3RA1YXnTzrkfLYoA/KTVRE9AjZd5QSKM=;
 b=OwLLu4TduzfS2DnoxY+jUQjY16QWB2y45fGFPF1UHEA0CO6do5kdxA5ohDW0BzG1h2
 rarnNkVuBb8IkeGc87QAk6BjOyx0mJHvWMgkO7/AkA8eZ79+kWgEeZF9xkaPcyNSahfT
 ibinqf5WdkLp1RlbfWCv2moErLiSEfUIVa97tttv3+HofhtaoesuBv/OZmOqNBdkJ4/s
 JSCyseYa+zCz2sONtiGPlstcFIlxKWbozZZo/ka+n7pGLVGMwfJfpXp3wsOeXfwwFA5b
 OL7V4wGkOl+EOxgqKXmqL22gzNrbQJT9S5UWizmXCWnnzHcek7tUDtfiFvRR0RlVIkTP
 Y9mA==
X-Gm-Message-State: AOJu0YxKxfXaWNuskqsWU8PgRXYA+dTyif4Kq5FrkTbw1Qq3aXJr4QVi
 noUdLtCRYxWdjExg7jiWM+z5rI5/jh/xweUTgO0=
X-Google-Smtp-Source: AGHT+IHt44HVqhj9vYsZBzQpfHgmd4rzjFLvykMP0s5tH0vXIZ7rPWB5ZQRlXxg+gwQvGTMAVR0Ju/JLeS3heEfz8qg=
X-Received: by 2002:a05:6871:890:b0:1d6:ce75:d472 with SMTP id
 r16-20020a056871089000b001d6ce75d472mr5997487oaq.6.1695307654222; Thu, 21 Sep
 2023 07:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124929.1965750-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20230921124929.1965750-1-sathishkumar.sundararaju@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Sep 2023 10:47:22 -0400
Message-ID: <CADnq5_NTHMU5OAb_Rw1iWyHB0ksgv8v7C2J7A9TnUdgRt-1_Yg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix ip count query for xcp partitions
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
Cc: Kuehling Felix <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Srinath Rao <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 21, 2023 at 9:07=E2=80=AFAM Sathishkumar S
<sathishkumar.sundararaju@amd.com> wrote:
>
> fix wrong ip count INFO on spatial partitions. update the query
> to return the instance count corresponding to the partition id.
>
> v2:
>  initialize variables only when required to be (Christian)
>  move variable declarations to the beginning of function (Christian)
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 081bd28e2443..d4ccbe7c78d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -595,11 +595,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>         struct drm_amdgpu_info *info =3D data;
>         struct amdgpu_mode_info *minfo =3D &adev->mode_info;
>         void __user *out =3D (void __user *)(uintptr_t)info->return_point=
er;
> +       struct amdgpu_fpriv *fpriv;
> +       struct amdgpu_ip_block *ip_block;
> +       enum amd_ip_block_type type;
> +       struct amdgpu_xcp *xcp;
> +       uint32_t count, inst_mask;
>         uint32_t size =3D info->return_size;
>         struct drm_crtc *crtc;
>         uint32_t ui32 =3D 0;
>         uint64_t ui64 =3D 0;
> -       int i, found;
> +       int i, found, ret;
>         int ui32_size =3D sizeof(ui32);
>
>         if (!info->return_size || !info->return_pointer)
> @@ -627,7 +632,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>                 return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT =
: 0;
>         case AMDGPU_INFO_HW_IP_INFO: {
>                 struct drm_amdgpu_info_hw_ip ip =3D {};
> -               int ret;
>
>                 ret =3D amdgpu_hw_ip_info(adev, info, &ip);
>                 if (ret)
> @@ -637,15 +641,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>                 return ret ? -EFAULT : 0;
>         }
>         case AMDGPU_INFO_HW_IP_COUNT: {
> -               enum amd_ip_block_type type;
> -               struct amdgpu_ip_block *ip_block =3D NULL;
> -               uint32_t count =3D 0;
> -
> +               fpriv =3D (struct amdgpu_fpriv *) filp->driver_priv;
>                 type =3D amdgpu_ip_get_block_type(adev, info->query_hw_ip=
.type);
>                 ip_block =3D amdgpu_device_ip_get_ip_block(adev, type);
> +
>                 if (!ip_block || !ip_block->status.valid)
>                         return -EINVAL;
>
> +               if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
> +                       fpriv->xcp_id >=3D 0 && fpriv->xcp_id < adev->xcp=
_mgr->num_xcps) {
> +                       xcp =3D &adev->xcp_mgr->xcp[fpriv->xcp_id];
> +                       switch (type) {
> +                       case AMD_IP_BLOCK_TYPE_GFX:
> +                               ret =3D amdgpu_xcp_get_inst_details(xcp, =
AMDGPU_XCP_GFX, &inst_mask);
> +                               count =3D hweight32(inst_mask);
> +                               break;
> +                       case AMD_IP_BLOCK_TYPE_SDMA:
> +                               ret =3D amdgpu_xcp_get_inst_details(xcp, =
AMDGPU_XCP_SDMA, &inst_mask);
> +                               count =3D hweight32(inst_mask);
> +                               break;
> +                       case AMD_IP_BLOCK_TYPE_JPEG:
> +                               ret =3D amdgpu_xcp_get_inst_details(xcp, =
AMDGPU_XCP_VCN, &inst_mask);
> +                               count =3D hweight32(inst_mask) * adev->jp=
eg.num_jpeg_rings;
> +                               break;
> +                       case AMD_IP_BLOCK_TYPE_VCN:
> +                               ret =3D amdgpu_xcp_get_inst_details(xcp, =
AMDGPU_XCP_VCN, &inst_mask);
> +                               count =3D hweight32(inst_mask);
> +                               break;
> +                       default:
> +                               return -EINVAL;
> +                       }
> +                       if (ret)
> +                               return ret;
> +                       return copy_to_user(out, &count, min(size, 4u)) ?=
 -EFAULT : 0;
> +               }
> +
>                 switch (type) {
>                 case AMD_IP_BLOCK_TYPE_GFX:
>                 case AMD_IP_BLOCK_TYPE_VCE:
> @@ -678,7 +708,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>                 return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT =
: 0;
>         case AMDGPU_INFO_FW_VERSION: {
>                 struct drm_amdgpu_info_firmware fw_info;
> -               int ret;
>
>                 /* We only support one instance of each IP block right no=
w. */
>                 if (info->query_fw.ip_instance !=3D 0)
> @@ -823,7 +852,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>                 struct drm_amdgpu_info_device *dev_info;
>                 uint64_t vm_size;
>                 uint32_t pcie_gen_mask;
> -               int ret;
>
>                 dev_info =3D kzalloc(sizeof(*dev_info), GFP_KERNEL);
>                 if (!dev_info)
> --
> 2.25.1
>
