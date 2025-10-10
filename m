Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40499CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 15:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66C910EC3B;
	Fri, 10 Oct 2025 15:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lgi3BPVm";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C07810EC3B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 15:00:45 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2698d47e6e7so3696465ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760108444; x=1760713244; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdIAtYskNZCxPF1awrD2SUh0uPQUzpPX+p1ZIgylOak=;
 b=lgi3BPVm8a3V3wm9udhjv8gurglQM3aNkCPtC1sR5BaC05Ijmjm2NlQwO1e9c7FwpL
 TyVEeLeoj6S4FAIPROsbtFDN9FWH6agynTjKCTvJcrYRY3VM1UrtIIL25QdVcN9v3aF+
 9KR90L2hdyaQy2HXs1GvrHz4xaEcDHfsClVbbSLGB65Rqw/mOiJz9QNvxPupLx7e3Wyf
 q4iIItZmQ8FJwknLNb9RSaoX0Mc08VBxD3leSBV8zc15cm2moM2YUtE0HMa9LpBfnsig
 Qp43rzG4qejKL/rbKpNLxwP2btuDqthtuiddxK/FqXRztUM7wZ7l+qL46AJ9z69aMCyP
 ngRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760108444; x=1760713244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdIAtYskNZCxPF1awrD2SUh0uPQUzpPX+p1ZIgylOak=;
 b=hUUVv4nGEH2mgtHBd5O4GhRvUdyEuFjvN5VunO7hXnbAnpJbYjcTkjXllHQra8ws+T
 auDJvWUejGBM4Q5yKFrCFulScMhcS6ODLEoXGhJutyEIG0Tk/uQl4CfWM+8CkE+QBNh8
 kRIzk8/PttGTMgwHDb4Ij3RM0y5VhJ9GkaV8fAj0utCtgtLnrUTTz4kyKWw2DgppC7+f
 V9JF/dCRqBhPSPpywkM5OFdvO8haAsE6ZNyCQY/DhlxTqwjB0M1QlNX+rccmZysJAODC
 yJHFdFh0gCrdGmtP3vGAc32Ay8EL3jF8eseXDc6BcGhxOBeYqaUCUpSBLU9UBABf2j+W
 Lg/g==
X-Gm-Message-State: AOJu0YzDP+t1JcGGhxwiSSEBIcq6v0Axe+4hRXIBeiPuwuMnFxCqIhjj
 PNl4zDC8twQUsJ1LQLnUwIPy+rnG9H4gZ6mU9ybA3HUKFD3Pc17DDTT5tL939+YXixGT6QDdXV6
 Yb6+slVUmf+Dgry9aZ3ogcIcXG/M7X32+eQ==
X-Gm-Gg: ASbGncu5PMvnuolcmlL0r5NTRL06KtUpEAlXOBNFHKMlMAWdvXs7UDRzNPXkkHZSfQn
 /A4wl0T+Cq3uyCbtP3U/3KQ4ZKqU0clspbkogN4lIXn9lv5vZX4mJzi0pzwSyixfDUv6p5SAghy
 YBc3mRULD7HsWTluC+7zBmYbHBfsFDZasfvGtQqy66J7Gmd74S8oDqdYnCvmTk3x2qDw2r62gyq
 WW1bFr2Likn4BmwWlWPCz5rVj3dGoeqAJ8V
X-Google-Smtp-Source: AGHT+IEsaTVC1Ln36ppN+vv6o92cirygl7DH079g+wuGIzA+AcOYgCypQvaA6cuSW/gtYj2EZ27P7yt5SbnFPKSteqU=
X-Received: by 2002:a17:903:120a:b0:261:500a:5742 with SMTP id
 d9443c01a7336-290274555bcmr74615725ad.10.1760108444271; Fri, 10 Oct 2025
 08:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251010044309.11822-1-yunru.pan@amd.com>
 <20251010044309.11822-2-yunru.pan@amd.com>
In-Reply-To: <20251010044309.11822-2-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Oct 2025 11:00:32 -0400
X-Gm-Features: AS18NWAlOuXOQXNRoPUxLTdXhCcqedUc8aUpFj_ornd4-A_m7NefL0C-iLLfmYY
Message-ID: <CADnq5_OxQiSDgWJfoiW8SrO1RwD9ZnQ+dY19yN-aJpqgApt2Vg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: Add SRIOV crit_region_version support
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
> 1. Added enum amd_sriov_crit_region_version to support multi versions
> 2. Added logic in SRIOV mailbox to regonize crit_region version during
>    req_gpu_init_data
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  8 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       | 23 ++++++++++++++-------
>  4 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index e95adf0407a0..3a6b0e1084d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -150,7 +150,8 @@ void amdgpu_virt_request_init_data(struct amdgpu_devi=
ce *adev)
>                 virt->ops->req_init_data(adev);
>
>         if (adev->virt.req_init_data_ver > 0)
> -               DRM_INFO("host supports REQ_INIT_DATA handshake\n");
> +               DRM_INFO("host supports REQ_INIT_DATA handshake of critic=
al_region_version %d\n",
> +                                adev->virt.req_init_data_ver);

dev_info() is preferred.

>         else
>                 DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n"=
);

Change this to dev_warn() while you are here.


>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.h
> index d1172c8e58c4..51ff73b1fcd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -262,6 +262,11 @@ struct amdgpu_virt_ras {
>
>  DECLARE_ATTR_CAP_CLASS(amdgpu_virt, AMDGPU_VIRT_CAPS_LIST);
>
> +struct amdgpu_virt_region {
> +       uint64_t offset;
> +       uint64_t size_kb;
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

What is this change for?  This parameter doesn't seem to be used.

Alex

>  }
>
>  static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,
> --
> 2.34.1
>
