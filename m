Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C53CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 07:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F178C10E29F;
	Wed,  1 Oct 2025 07:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHnmS1Zf";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1864410E29F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 07:32:04 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-27eda3a38ceso16615045ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Oct 2025 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759303923; x=1759908723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxK9Hu/6/m+1KkSixuGQQF/FKuYj5P4mjJ+2Jd5RtxM=;
 b=kHnmS1ZfC05Wy3ABqPgpzAwPhTJiWLPp/lBIECwSIaHWbwVMp/n2TeA9cdcemCIEZH
 w30Skkj+lnUhKlwKx7MVQrjRrR28URhVgu5Vw3g7VF8RVaR5ynAzKkCEv1B0zKX5MzSB
 EctnXqzSxVvBn1X/ntQOGYLl67A0TjZln6y/TVYXoz6a02FFLQrqQ84bx7qDMevrxG4Y
 yp8hkWZ9b+6/UXrIq/0gYPvVepqdz3l/GUXZv/4uQV/KArk6KmTQlcPK32IGDQ5WURE4
 D36VaSWrznjkC22GVyrlCwNDU+VAiWMoERdXjrfXGb2nZTVlr4ZAamHlLeJkqG/eM+RL
 7SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759303923; x=1759908723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxK9Hu/6/m+1KkSixuGQQF/FKuYj5P4mjJ+2Jd5RtxM=;
 b=lojuTvdrXEl+XZuxOJYbx/pN/HWLeJMMaxcf3IWUwqA1K3Q4TQDx0WklDYTnBdQRho
 wOcbPIyNqdrbek8N0kZUpnRUVdEvFviGMpZUYkXi8Sdy/NizYhf7/HC5wkI2bN2Xb5KH
 FtMPDNoTBGacM3fHlDdfEMdrhkdROygMsifVzCcJ45jlTZJP9HXrPjea351mXgsqn3yQ
 pNMmNZKwdI21Ht3Lgm5bKv5RH3Y5yx5Atl8bDudYp8ws4b7pR05EGrug53J6jMz5/r7W
 D3DgprFUXhZl9Ure05UU7Jv2Irc9ak1MRgfN1qANLzNqLF+ZPwpORWx4s9sMhLDDF7R3
 tGRg==
X-Gm-Message-State: AOJu0YzGCNjnLuzpgSZHj5z8UiUpmrtViee/HmVAQdxTImYxi1Hsen4j
 cSWiPuhiT9Ap7BH3W/8HFkg+Sh/lIX8JPjFYwXW5NA80XgQMgaO/7eDgR+9MJ7sLDdz2itcb2Be
 7iL7kwNrWyci84zGBWafAJERnepe6wYM=
X-Gm-Gg: ASbGncsaGuf8l7GVfx2gZwUEouQzEYQ9hz35jY+kJFm6QmPxODAJB/hv6erfSm+8aA9
 18GvGRrePFdQ4ISOOVYxZ8jfvtm6G6/RMUg6umTD6Z8oNrgebb4Kcf8OL/31OXrT5FZU9LUrs3v
 dR0EYolNerU33qLTYidZgdb2nTKbFQ5KKuF/nct8ySSUp7Z9hrnYgqzQ+ObZ7SHbs29BCFOQsx2
 LBGwaLINncy6Jr/r1pQoXZAQygfnA==
X-Google-Smtp-Source: AGHT+IERbF/E+j8TLOgExOffnv3he+aBum6fAGPFN/5+epzDeH1BwpElxGX9E/PAb5mhkYnfosbfvJ3rfmWlUrMUKQ8=
X-Received: by 2002:a17:902:ce8e:b0:27e:eee6:6df2 with SMTP id
 d9443c01a7336-28e7f2fe815mr18237305ad.7.1759303923485; Wed, 01 Oct 2025
 00:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250930082525.118197-1-YiPeng.Chai@amd.com>
 <20250930082525.118197-3-YiPeng.Chai@amd.com>
In-Reply-To: <20250930082525.118197-3-YiPeng.Chai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Oct 2025 03:31:52 -0400
X-Gm-Features: AS18NWCbVViXKwBlQuDDFvFgdThv0A1kDtYpkkqHuzHNH0Zja8jTxMlAjCy--OU
Message-ID: <CADnq5_Pw4450Oc1xGGebL=1skJAk5feDYNMzRaVqCW0C7b9Y4w@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Add amdgpu drm ras ioctl for ras module
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, 
 Candice.Li@amd.com, KevinYang.Wang@amd.com, Stanley.Yang@amd.com, 
 Jinzhou.Su@amd.com
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

On Tue, Sep 30, 2025 at 4:27=E2=80=AFAM YiPeng Chai <YiPeng.Chai@amd.com> w=
rote:
>
> Add amdgpu drm ras ioctl for ras module.

Please describe the IOCTL and how it is used and what functionality it
provides.  Additionally please provide a link to the proposed open
source userspace tools that will use it.  We can't merge the kernel
code until we have the userspace side available.  Additional comments
below.

>
> V2:
>   Updated ras ioctl structure and description.
>
> V3:
>   Rename the ras command.
>
> V4:
>   Remove some variables.
>
> V5:
>   Add null pointer check.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 44 +++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h                 | 32 ++++++++++++++
>  4 files changed, 80 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 2a0df4cabb99..55cd2f75333e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -718,6 +718,9 @@ int amdgpu_cs_wait_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *fi
>  int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
>                                 struct drm_file *filp);
>
> +int amdgpu_ras_mgr_ioctl(struct drm_device *dev, void *data,
> +                               struct drm_file *filp);
> +
>  /* VRAM scratch page for HDP bug, default vram page */
>  struct amdgpu_mem_scratch {
>         struct amdgpu_bo                *robj;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 4905efa63ddc..f7038ba8571e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3057,6 +3057,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
 {
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl,=
 DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM=
_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handle=
s_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_RAS, amdgpu_ras_mgr_ioctl, DRM_AUTH|DRM_=
RENDER_ALLOW),

Is this interface for administrators only?  If so, you should either
remove DRM_RENDER_ALLOW, or check CAP_ADMIN in the IOCTL.

Alex

>  };
>
>  static const struct drm_driver amdgpu_kms_driver =3D {
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/g=
pu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> index 195ca51a96d5..882b8ab7c843 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> @@ -361,3 +361,47 @@ int amdgpu_ras_cmd_ioctl_handler(struct ras_core_con=
text *ras_core,
>
>         return RAS_CMD__SUCCESS;
>  }
> +
> +static int amdgpu_ras_get_caps(struct amdgpu_device *adev,
> +                       struct drm_amdgpu_ras *cmd)
> +{
> +       void __user *output_ptr =3D u64_to_user_ptr(cmd->output_buf_ptr);
> +       struct drm_amdgpu_ras_caps caps;
> +
> +       memset(&caps, 0, sizeof(caps));
> +
> +       if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
> +               caps.oam_id =3D adev->smuio.funcs->get_socket_id(adev);
> +
> +       if (output_ptr && (cmd->output_buf_size >=3D sizeof(caps)) &&
> +           !copy_to_user(output_ptr, &caps, sizeof(caps)))
> +               return 0;
> +
> +       return -EINVAL;
> +}
> +
> +int amdgpu_ras_mgr_ioctl(struct drm_device *dev, void *data,
> +                               struct drm_file *filp)
> +{
> +       struct amdgpu_device *adev =3D drm_to_adev(dev);
> +       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(ade=
v);
> +       struct drm_amdgpu_ras *args =3D data;
> +       int res =3D RAS_CMD__ERROR_INVALID_CMD;
> +
> +       if (!ras_mgr || !ras_mgr->ras_core || !args)
> +               return -EPERM;
> +
> +       if (!ras_core_is_enabled(ras_mgr->ras_core))
> +               return RAS_CMD__ERROR_ACCESS_DENIED;
> +
> +       switch (args->cmd_id) {
> +       case AMDGPU_RAS_CMD_GET_CAPS:
> +               res =3D amdgpu_ras_get_caps(adev, args);
> +               break;
> +       default:
> +               res =3D RAS_CMD__ERROR_UKNOWN_CMD;
> +               break;
> +       }
> +
> +       return res;
> +}
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index cd7402e36b6d..71771755eca8 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -59,6 +59,9 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_WAIT          0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>
> +/* amdgpu ras ioctls */
> +#define DRM_AMDGPU_RAS                 0x5d
> +
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>  #define DRM_IOCTL_AMDGPU_CTX           DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_CTX, union drm_amdgpu_ctx)
> @@ -79,6 +82,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_RAS   DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_RA=
S, struct drm_amdgpu_ras)
>
>  /**
>   * DOC: memory domains
> @@ -1686,6 +1690,34 @@ struct drm_color_ctm_3x4 {
>         __u64 matrix[12];
>  };
>
> +/*
> + * Amdgpu ras command id
> + */
> +
> +/* Get amdgpu ras capabilities */
> +#define AMDGPU_RAS_CMD_GET_CAPS         0x01
> +
> +/* Input structure for amdgpu ras ioctl */
> +struct  drm_amdgpu_ras {
> +       /* Amdgpu ras version */
> +       __u32 version;
> +       /* AMDGPU_RAS_CMD_* */
> +       __u32 cmd_id;
> +       /* Pointer to input parameter buffer */
> +       __u64 input_buf_ptr;
> +       /* Pointer to output buffer */
> +       __u64 output_buf_ptr;
> +       /* Output buffer size */
> +       __u32 output_buf_size;
> +       __u32 pad;
> +};
> +
> +struct drm_amdgpu_ras_caps {
> +       /* OAM ID */
> +       __u32 oam_id;
> +       __u32 pad;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> --
> 2.34.1
>
