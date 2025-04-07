Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1807C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 20:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A565E10E560;
	Mon,  7 Apr 2025 20:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iRU9o0Lb";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C21510E560
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 20:03:32 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-736ac19918cso714419b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056212; x=1744661012; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StCj6ftNBVsbSvcWD8xj4Ol9eodzxKb3Un1ICdqa6io=;
 b=iRU9o0LbfAQxLoXzqJpnoCGrexcNHJgcnMAR6pmo3AL1jjCkP6zs/CzGvzeZWTIdGo
 Bt8OmApj8bQFGIigr1ORchTY3x2Edtl7Uvt05YyT60bX3wQwjKP1ZTxRtttB624Q0QzB
 laZXMGjwRTYQ29tNuBKf7EWBYHCUVFFhh89znqsHNR+5WYY3iO4XAq9ulIJ7Po/2bgD0
 xIchjZIfT5alQFj7E3QEazBR7BrxJmhuGLtNjFbsJJSIhB8hkLpiPm+1+abwn9fKcJ4n
 qd74dfZcUfrs32tclrpY/JDkGKX9IXY/90QNpTGP1iltRbJCq1AFsJdNPhxUuOVyo1lv
 AkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056212; x=1744661012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StCj6ftNBVsbSvcWD8xj4Ol9eodzxKb3Un1ICdqa6io=;
 b=qEwWYXo/Y5JjPioNDpe0vr3Tu+5eP14rAvKO+tfWTAKFRnSRO7DpfSOHEnIeqkpEgZ
 7oIxf8rOYln89oEl6tM5F8fzbPeLpBdpTx/DUAWmGpSfIDpNChmKrEU4QExJ+CNV/LI1
 QZIhz9JnlK0zkKPIcMvkxgWRai+p6rh3KhD1QRKdJs1coZMfH/SZTH93mwSWHISaPWm1
 SOYCxEsDh9HbpCBoGFRZtj8Zl+cgf9jaD9CYmCpEz7Y/ReDm0lz1SaLTm1oVVJQUiJmN
 OZzbsc4Dked1+0GbQR7UCBxVZvHigX62+gfcxqLT9m+YEUhTTsx+JwS8h7G5O3uOjRJ8
 Ojgw==
X-Gm-Message-State: AOJu0YyY7cg1YNTz5WvLr73UyE0YzdkAeTelFojZs6dJZNlVYsLAMw0O
 Q8KNKNd2bTVa1nHT4NCPQ3AE6BVpy2s8D6q33lLfZ4oBAcslZYAVyHToqBpxYy1/sIcBnde4D+/
 w6StEzIddIdECQylodXnegSY8565w3A==
X-Gm-Gg: ASbGnctbJrVU2IWdP8vvPHkB4bDadVhUIjOz4r0lBJ7MjU4c9NowU6YR83hZKUtlVvN
 z5jaRL99PiXxpsFkFy0whOY70Zk/DeSFXCOHFeq8n8/rNpgh+JoqKhwUuhXcKHMtQRtzYL6GAH0
 DSkmmThbXhEqRZ70oi1ijPcIYf1Q==
X-Google-Smtp-Source: AGHT+IEdja9UOSZvbjjsCCV3GMc70H3nOdzYAG0J+MuCsqoq1QaA3BLUlEU1GrDDOEHMt7tdMLRNX5NOW8WrKJ1p3w8=
X-Received: by 2002:a17:90b:4d06:b0:305:5f2c:c580 with SMTP id
 98e67ed59e1d1-306a485adb4mr7035802a91.2.1744056211363; Mon, 07 Apr 2025
 13:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
 <20250402091406.1641643-2-jesse.zhang@amd.com>
In-Reply-To: <20250402091406.1641643-2-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 16:03:20 -0400
X-Gm-Features: ATxdqUFQg44PbTWG0UtBxmlKqgQo7SuakK4et0ssY-8ZS1BWrPVOoa3skffb3oo
Message-ID: <CADnq5_ObdYGK3m8SiDFX2K74zp8223_c7zfGneywyL1UAk8kEQ@mail.gmail.com>
Subject: Re: [v3 2/7] drm/amd/amdgpu: Implement SDMA soft reset directly for
 sdma v5
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, jonathan.kim@amd.com,
 jiadong.zhu@amd.com
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

On Wed, Apr 2, 2025 at 5:23=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@amd=
.com> wrote:
>
> This patch introduces a new function `amdgpu_sdma_soft_reset` to handle S=
DMA soft resets directly,
> rather than relying on the DPM interface.
>
> 1. **New `amdgpu_sdma_soft_reset` Function**:
>    - Implements a soft reset for SDMA engines by directly writing to the =
hardware registers.
>    - Handles SDMA versions 4.x and 5.x separately:
>      - For SDMA 4.x, the existing `amdgpu_dpm_reset_sdma` function is use=
d for backward compatibility.
>      - For SDMA 5.x, the driver directly manipulates the `GRBM_SOFT_RESET=
` register to reset the specified SDMA instance.
>
> 2. **Integration into `amdgpu_sdma_reset_engine`**:
>    - The `amdgpu_sdma_soft_reset` function is called during the SDMA rese=
t process, replacing the previous call to `amdgpu_dpm_reset_sdma`.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 46 +++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index b51fe644940f..26d7c0aca9a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -26,6 +26,8 @@
>  #include "amdgpu_sdma.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_reset.h"
> +#include "gc/gc_10_1_0_offset.h"
> +#include "gc/gc_10_3_0_sh_mask.h"
>
>  #define AMDGPU_CSA_SDMA_SIZE 64
>  /* SDMA CSA reside in the 3rd page of CSA */
> @@ -553,6 +555,48 @@ void amdgpu_sdma_register_on_reset_callbacks(struct =
amdgpu_device *adev, struct
>         list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
>  }
>
> +static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instan=
ce_id)
> +{
> +       u32 soft_reset;
> +       int r =3D 0;
> +
> +       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
> +       case IP_VERSION(4, 4, 2):
> +       case IP_VERSION(4, 4, 4):
> +       case IP_VERSION(4, 4, 5):
> +               /* For SDMA 4.x, use the existing DPM interface for backw=
ard compatibility */
> +               r =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> +               break;
> +       case IP_VERSION(5, 0, 0):
> +       case IP_VERSION(5, 0, 1):
> +       case IP_VERSION(5, 0, 2):
> +       case IP_VERSION(5, 0, 5):
> +       case IP_VERSION(5, 2, 0):
> +       case IP_VERSION(5, 2, 2):
> +       case IP_VERSION(5, 2, 4):
> +       case IP_VERSION(5, 2, 5):
> +       case IP_VERSION(5, 2, 6):
> +       case IP_VERSION(5, 2, 3):
> +       case IP_VERSION(5, 2, 1):
> +       case IP_VERSION(5, 2, 7):
> +               /* For SDMA 5.x, directly manipulate the GRBM_SOFT_RESET =
register */
> +               soft_reset =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +               soft_reset |=3D 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__S=
HIFT << instance_id;
> +               /* Issue the soft reset */
> +               WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
> +
> +               udelay(50);
> +               /* Clear the soft reset bit */
> +               soft_reset &=3D ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0_=
_SHIFT << instance_id);
> +               WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);

I would move this into a helper function in sdma_v5_0.c and just call
that from here rather than including IP specific programming in this
file.  E.g.,

sdma_v5_0_soft_reset(adev, instance_id);

Alex

> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return r;
> +}
> +
>  /**
>   * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
>   * @adev: Pointer to the AMDGPU device
> @@ -587,7 +631,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ad=
ev, uint32_t instance_id)
>                 gfx_ring->funcs->stop_queue(gfx_ring);
>
>         /* Perform the SDMA reset for the specified instance */
> -       ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> +       ret =3D amdgpu_sdma_soft_reset(adev, instance_id);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to reset SDMA instance %u\n", =
instance_id);
>                 goto exit;
> --
> 2.25.1
>
