Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D52CCD192
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 13:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB40010E7CE;
	Wed, 15 Oct 2025 13:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7J/eqos";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E2010E7CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 13:03:14 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-27eda3a38ceso13134885ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 06:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760533394; x=1761138194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGaTWstuwnLj/l6hYhVAgbK8JObul5twC2h6HlpZBT0=;
 b=L7J/eqoszQ6TwYrAIIvb/EpN799Ygy058mzdVOHRM+VjqowKYQzdi3/kJdg7NSrfF9
 nREP6E9fMgwxpQ4qr3SMxRka+ZrBuMNIpdw43+JGCj+nITWE7jMjg64GsRdzsjFCwtNm
 U2e7YGWsaCDb2PBDJXGlH8kMY4UotxVMHlrDPZwypzwy+xLbM70aDOKF6ncWzVuQJ190
 SpKzgrWSnMXddG+alsMBXvyHb0WWuF31WGntYdjIrvpyyjbWfo85xsknWZ6evTWEKgzR
 5KcXx1HlTweNj+rfdNqJ1Zqrp3B+EZ6hikZYB6bKeiIKYjux7tWU0PFwL1e0npnnJwUK
 e1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760533394; x=1761138194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGaTWstuwnLj/l6hYhVAgbK8JObul5twC2h6HlpZBT0=;
 b=VME5FrTqzaWDiXS+fFxY/WgQejwcb26aYjJRyVWm81VEvNZSttapny5Oy6a+Qy14rf
 NOcjipzDogkQHQcR2/bp/a5TrG08JipJe69s2NeYoVfXGUB6zvIufjerDgfR1CIPNyMs
 wjjVAFyfa6AisEWw/UhvDW+YHxuSt9OslQdB6wGMiyl7LUfOe8Us5Tswn8d38haa8iA3
 us4ReXU4lmcMAWTHAoeESGov/FjlPV1rgj0wOFU/tWoE8dW6ZdBjku+sGUkd5UOHPEJJ
 uhbdEs1MJooIpsEM9uDEcCILExDPTa4shXhPRpM99Jh8nz2pLNGAGcRZdJHgBmacWwxx
 zzzw==
X-Gm-Message-State: AOJu0YyCddaYuJh9syexAAf+ZBQbO92y2sGoAfvzqCXYDZ4nqt8RdeiV
 ikJUHlHWPyDZdXV4X66E2LrBVY27pC+fL3maUPw6f7xI1iwjHOnR9GDj3ag9p+lE7Gzwdauo2WH
 XSxB9lO/zDKGvhgbhHcxdKLt/XpRRDR8=
X-Gm-Gg: ASbGncuxBixUXVqCNMGPR9u/xl+1qxZEvnIlpCoZ3IxHxmnbA6F1xGf1D0nTGZ/K3X0
 Is6UO4lmm7FflCIkhtrmNNYZrjI3+Hoc+5yqkMgB4Fu/KCs0vSlCl7M3agVl3uUlXyKVkSEgOOn
 H4jTnwvhWpY31rreypHBqp0Ou3AhVIa8OlKWteQlflx2FAZ65xiPs0mxLXUQQNz+19Aj4n0F3Sp
 x5WPjNqXYA39hBRUl9PvamKpH5LR6MWW5Gz
X-Google-Smtp-Source: AGHT+IF5ASKyLYL90/ypLWAYEKAhaamAyEPzQVS5a6Tgyeb5DcUtvkpdL+jE1svy2xFnp1J8M/enspm2UWnhPpyRStw=
X-Received: by 2002:a17:903:2f8e:b0:267:8b4f:df1f with SMTP id
 d9443c01a7336-290273c62d3mr188183055ad.1.1760533391466; Wed, 15 Oct 2025
 06:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251014201346.9422-1-yunru.pan@amd.com>
 <20251014201346.9422-2-yunru.pan@amd.com>
In-Reply-To: <20251014201346.9422-2-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Oct 2025 09:02:58 -0400
X-Gm-Features: AS18NWCx0DN68J2BBqa2Zalc2WLrMQfvDPMrIAR8k85PHc0ZhyKrnbIImXTMozM
Message-ID: <CADnq5_OYMu2UVhK20TnH3oChX9HA20oD5c_3B+29n8C1QOVDEg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] drm/amdgpu: Add SRIOV crit_region_version support
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

On Tue, Oct 14, 2025 at 4:21=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
> 1. Added enum amd_sriov_crit_region_version to support multi versions
> 2. Added logic in SRIOV mailbox to regonize crit_region version during
>    req_gpu_init_data
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  8 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       | 23 ++++++++++++++-------
>  4 files changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index e95adf0407a0..39ab7d00379b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -150,9 +150,10 @@ void amdgpu_virt_request_init_data(struct amdgpu_dev=
ice *adev)
>                 virt->ops->req_init_data(adev);
>
>         if (adev->virt.req_init_data_ver > 0)
> -               DRM_INFO("host supports REQ_INIT_DATA handshake\n");
> +               dev_info(adev->dev, "host supports REQ_INIT_DATA handshak=
e of critical_region_version %d\n",
> +                                adev->virt.req_init_data_ver);
>         else
> -               DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n"=
);
> +               dev_warn(adev->dev, "host doesn't support REQ_INIT_DATA h=
andshake\n");
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.h
> index d1172c8e58c4..36247a160aa6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -262,6 +262,11 @@ struct amdgpu_virt_ras {
>
>  DECLARE_ATTR_CAP_CLASS(amdgpu_virt, AMDGPU_VIRT_CAPS_LIST);
>
> +struct amdgpu_virt_region {
> +       uint32_t offset;
> +       uint32_t size_kb;
> +};
> +
>  /* GPU virtualization */
>  struct amdgpu_virt {
>         uint32_t                        caps;
> @@ -289,6 +294,9 @@ struct amdgpu_virt {
>         bool ras_init_done;
>         uint32_t reg_access;
>
> +       /* dynamic(v2) critical regions */
> +       struct amdgpu_virt_region init_data_header;
> +
>         /* vf2pf message */
>         struct delayed_work vf2pf_work;
>         uint32_t vf2pf_update_interval_ms;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgv_sriovmsg.h
> index 3b35154e2df6..b53caab5b706 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -65,6 +65,11 @@
>         (AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE=
_KB_V1 + \
>          AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
>
> +enum amd_sriov_crit_region_version {
> +       GPU_CRIT_REGION_V1 =3D 1,
> +       GPU_CRIT_REGION_V2 =3D 2,
> +};
> +
>  /*
>   * PF2VF history log:
>   * v1 defined in amdgim
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_nv.c
> index e5282a5d05d9..cd5b2f07edb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -222,12 +222,20 @@ static int xgpu_nv_send_access_requests_with_param(=
struct amdgpu_device *adev,
>                                 adev->virt.req_init_data_ver =3D 0;
>                 } else {
>                         if (req =3D=3D IDH_REQ_GPU_INIT_DATA) {
> -                               adev->virt.req_init_data_ver =3D
> -                                       RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RC=
V_DW1);
> -
> -                               /* assume V1 in case host doesn't set ver=
sion number */
> -                               if (adev->virt.req_init_data_ver < 1)
> -                                       adev->virt.req_init_data_ver =3D =
1;
> +                               switch (RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RC=
V_DW1)) {
> +                               case GPU_CRIT_REGION_V2:
> +                                       adev->virt.req_init_data_ver =3D =
GPU_CRIT_REGION_V2;
> +                                       adev->virt.init_data_header.offse=
t =3D
> +                                               RREG32_NO_KIQ(mmMAILBOX_M=
SGBUF_RCV_DW2);
> +                                       adev->virt.init_data_header.size_=
kb =3D
> +                                               RREG32_NO_KIQ(mmMAILBOX_M=
SGBUF_RCV_DW3);
> +                                       break;
> +                               default:
> +                                       adev->virt.req_init_data_ver =3D =
GPU_CRIT_REGION_V1;
> +                                       adev->virt.init_data_header.offse=
t =3D -1;
> +                                       adev->virt.init_data_header.size_=
kb =3D 0;
> +                                       break;
> +                               }
>                         }
>                 }
>
> @@ -285,7 +293,8 @@ static int xgpu_nv_release_full_gpu_access(struct amd=
gpu_device *adev,
>
>  static int xgpu_nv_request_init_data(struct amdgpu_device *adev)
>  {
> -       return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
> +       return xgpu_nv_send_access_requests_with_param(adev, IDH_REQ_GPU_=
INIT_DATA,
> +                       0, GPU_CRIT_REGION_V2, 0);
>  }
>
>  static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,
> --
> 2.34.1
>
