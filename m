Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1983C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 15:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7550C10E6BE;
	Tue,  6 May 2025 15:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E0D66L9n";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B5410E6BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 15:17:47 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-af5499ca131so671586a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 May 2025 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746544667; x=1747149467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boi6lgPzMYtmgeoHrBOKS6st7PfgSsyj5O/f1viq2I8=;
 b=E0D66L9nU0V3GLZGFc5aYaC+aTESydaABWkilxllsdu8CZ7dCrGQE8SGWBGEpSRUSk
 NDawmuHtUdSke2QX5ScJbOyBh/8X0g/vUZPN7D3FHnoErXSK3FuAk1vXaCFLfo+FiRmA
 nD6qXnyJeorlIHq8ZoUDOgclOcbX1zorvZlR8GFdwZaaH2ik6tuxlOcgwBEJJUEoYtld
 7J/3c78QaHVpwa6xzj9b6kLZyE1zj2B6ieaFUQqDbmjTwjnEIaJUYuzqalqig16CJlr+
 uMxaOohySSSNqVPA1amArDNdWUZfuTz3mFNKjrzBPDVZV60mOn1LMOo3/VmaUaaTHQ5W
 zmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746544667; x=1747149467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=boi6lgPzMYtmgeoHrBOKS6st7PfgSsyj5O/f1viq2I8=;
 b=JwXzuIqaCbMb56e0VEKcZzZFU7fw/GvBUKqQynfJzuWtJQ4XZ4Wndo796ebyv7zGtn
 o7yugGfs1al7JTMg6pDs+1S3VEtMQaYNX/oz1VJCo9+ek+EbtFMV1qEtePHIxtAtMPZK
 qzE9czG7L8xzmNnS35pQu6DqQuw9MLC5xP6qb7vkh+WcfK8QRrAeSzkyrLmT9jvlXThf
 TNX5cl1duFngaYXiVH3TwB4bAbd1EGTXsFWvN87pFSWH1gyGvmMGvqSYskI7rjNcSYgQ
 LRIPwc+S7HVpQZufYi66kVuNH2eUEqzAxddpoexqiCtBOSQSOf1R3vRrc5F3rSA/nXCv
 A3Iw==
X-Gm-Message-State: AOJu0YyVV3GhelUXUu9APlmv5XEyEPei4obpJgOVYB88UP+r0qa2mQIg
 pSJJzlwoJ2jsOwccdD84lQ1Y5kG26ZyK8lbPI6+S1FN78ywmBUnM6a6WzV+i9H+4qbFVewT8V23
 28LFTcEm4zFqJAlEk81NG+0h0vHg=
X-Gm-Gg: ASbGncuXQbTfyag2Lynm+ctUJqL9ZNgMjI1FJRPyD0DB7YJBDM/Mq4btwQF+Aumax7+
 9mZc29u7NpgDwADnFMRUzyNeDtDpkibo+1xkgD7eQjD5q0PZWGi+kO06Jxd5H7qFeoK6wwOukDM
 bSVVO82Y0U72bvapW4Emlh3A==
X-Google-Smtp-Source: AGHT+IHuRPcKyPY+o6eUWqm5nkU7c9etNww+IJsgxph2iaIikAGoSeIlnkEgVCKOSzm8jQFcW28Rtq80nzFH+r1kJCo=
X-Received: by 2002:a17:90b:2247:b0:30a:2173:9f16 with SMTP id
 98e67ed59e1d1-30a4e57ae6fmr9392942a91.1.1746544666641; Tue, 06 May 2025
 08:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250505130459.1985637-1-alexander.deucher@amd.com>
In-Reply-To: <20250505130459.1985637-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 May 2025 11:17:35 -0400
X-Gm-Features: ATxdqUHfHi7F9xXUeq06IZKCME2DJrasYLVW7YJTB3SimOeAkg7FXLRFFhcDyA0
Message-ID: <CADnq5_M3k7RmOowRW+GDh9Kn9MrTXNv7Vc4b=Pd0UG0w22Qr5A@mail.gmail.com>
Subject: Re: [PATCH 1/7] Revert "drm/amdgpu: Use generic hdp flush function"
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping on this series?  This fixes a regression.

Alex

On Mon, May 5, 2025 at 9:05=E2=80=AFAM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> This reverts commit 18a878fd8aef0ec21648a3782f55a79790cd4073.
>
> Revert this temporarily to make it easier to fix a regression
> in the HDP handling.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 21 ---------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 --
>  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 13 ++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c   | 13 ++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c   | 13 ++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c   | 13 ++++++++++++-
>  6 files changed, 48 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_hdp.c
> index 7fd8f09c28e66..b6cf801939aa5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> @@ -22,7 +22,6 @@
>   */
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
> -#include <uapi/linux/kfd_ioctl.h>
>
>  int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
>  {
> @@ -47,23 +46,3 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
>         /* hdp ras follows amdgpu_ras_block_late_init_default for late in=
it */
>         return 0;
>  }
> -
> -void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
> -                             struct amdgpu_ring *ring)
> -{
> -       if (!ring || !ring->funcs->emit_wreg) {
> -               WREG32((adev->rmmio_remap.reg_offset +
> -                       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
> -                              2,
> -                      0);
> -               RREG32((adev->rmmio_remap.reg_offset +
> -                       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
> -                      2);
> -       } else {
> -               amdgpu_ring_emit_wreg(ring,
> -                                     (adev->rmmio_remap.reg_offset +
> -                                      KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL)=
 >>
> -                                             2,
> -                                     0);
> -       }
> -}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_hdp.h
> index 4cfd932b7e91e..7b8a6152dc8d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> @@ -44,6 +44,4 @@ struct amdgpu_hdp {
>  };
>
>  int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
> -void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
> -                             struct amdgpu_ring *ring);
>  #endif /* __AMDGPU_HDP_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/hdp_v4_0.c
> index e6c0d86d34865..f1dc13b3ab38e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> @@ -36,6 +36,17 @@
>  #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK     0x00020000L
>  #define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
>
> +static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
> +                               struct amdgpu_ring *ring)
> +{
> +       if (!ring || !ring->funcs->emit_wreg) {
> +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2, 0);
> +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2);
> +       } else {
> +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset=
 + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> +       }
> +}
> +
>  static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
>                                     struct amdgpu_ring *ring)
>  {
> @@ -169,7 +180,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
>  };
>
>  const struct amdgpu_hdp_funcs hdp_v4_0_funcs =3D {
> -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> +       .flush_hdp =3D hdp_v4_0_flush_hdp,
>         .invalidate_hdp =3D hdp_v4_0_invalidate_hdp,
>         .update_clock_gating =3D hdp_v4_0_update_clock_gating,
>         .get_clock_gating_state =3D hdp_v4_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/hdp_v5_0.c
> index 8bc001dc9f631..43195c0797480 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
> @@ -27,6 +27,17 @@
>  #include "hdp/hdp_5_0_0_sh_mask.h"
>  #include <uapi/linux/kfd_ioctl.h>
>
> +static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
> +                               struct amdgpu_ring *ring)
> +{
> +       if (!ring || !ring->funcs->emit_wreg) {
> +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2, 0);
> +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2);
> +       } else {
> +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset=
 + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> +       }
> +}
> +
>  static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
>                                     struct amdgpu_ring *ring)
>  {
> @@ -206,7 +217,7 @@ static void hdp_v5_0_init_registers(struct amdgpu_dev=
ice *adev)
>  }
>
>  const struct amdgpu_hdp_funcs hdp_v5_0_funcs =3D {
> -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> +       .flush_hdp =3D hdp_v5_0_flush_hdp,
>         .invalidate_hdp =3D hdp_v5_0_invalidate_hdp,
>         .update_clock_gating =3D hdp_v5_0_update_clock_gating,
>         .get_clock_gating_state =3D hdp_v5_0_get_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/hdp_v6_0.c
> index ec20daf4272c5..a88d25a06c29b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
> @@ -30,6 +30,17 @@
>  #define regHDP_CLK_CNTL_V6_1   0xd5
>  #define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
>
> +static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
> +                               struct amdgpu_ring *ring)
> +{
> +       if (!ring || !ring->funcs->emit_wreg) {
> +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2, 0);
> +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2);
> +       } else {
> +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset=
 + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> +       }
> +}
> +
>  static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
>                                          bool enable)
>  {
> @@ -138,7 +149,7 @@ static void hdp_v6_0_get_clockgating_state(struct amd=
gpu_device *adev,
>  }
>
>  const struct amdgpu_hdp_funcs hdp_v6_0_funcs =3D {
> -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> +       .flush_hdp =3D hdp_v6_0_flush_hdp,
>         .update_clock_gating =3D hdp_v6_0_update_clock_gating,
>         .get_clock_gating_state =3D hdp_v6_0_get_clockgating_state,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/hdp_v7_0.c
> index ed1debc035073..49f7eb4fbd117 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
> @@ -27,6 +27,17 @@
>  #include "hdp/hdp_7_0_0_sh_mask.h"
>  #include <uapi/linux/kfd_ioctl.h>
>
> +static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
> +                               struct amdgpu_ring *ring)
> +{
> +       if (!ring || !ring->funcs->emit_wreg) {
> +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2, 0);
> +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL) >> 2);
> +       } else {
> +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset=
 + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> +       }
> +}
> +
>  static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
>                                          bool enable)
>  {
> @@ -126,7 +137,7 @@ static void hdp_v7_0_get_clockgating_state(struct amd=
gpu_device *adev,
>  }
>
>  const struct amdgpu_hdp_funcs hdp_v7_0_funcs =3D {
> -       .flush_hdp =3D amdgpu_hdp_generic_flush,
> +       .flush_hdp =3D hdp_v7_0_flush_hdp,
>         .update_clock_gating =3D hdp_v7_0_update_clock_gating,
>         .get_clock_gating_state =3D hdp_v7_0_get_clockgating_state,
>  };
> --
> 2.49.0
>
