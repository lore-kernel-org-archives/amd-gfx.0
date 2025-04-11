Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109D5C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 15:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77C910EC08;
	Fri, 11 Apr 2025 15:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z/RgrhuH";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EEA10EC08
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 15:54:42 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3054e2d13a7so396994a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744386882; x=1744991682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXfq03fmILwb9as3jlqgrORvtuPloMfvn4OmHtyDIvA=;
 b=Z/RgrhuHtKOZczrtTd9xQbnQ9kVlLVHLIt4pHtE/uILX5WlXOvDbQJjw9l02lnBEzI
 jNsfsEZrgz2/raZMWH3I1cTS5GEXf92Ruj3NA/V8sVrbH0VHRv9+w0KhbCcgfM/tAnce
 e0INHWCi8o0bj9FT422dHQJj7B9n4bfwEqJrMoHplMYSW0oCLRJLedDpQ0MTRS4MOrR6
 yq4cv1Y3QKTw3vMEDSUJLBADL267bAM2vHnkXE3Ddp017uC5zS6797IklgjwWV8dr+XV
 rXN3rTqI1LNZc7mYf7PNest+XwfW3nWGpvaCGBP5Oah2DMaftjprGzUMHsM0t/xfnfMX
 QKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744386882; x=1744991682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXfq03fmILwb9as3jlqgrORvtuPloMfvn4OmHtyDIvA=;
 b=XAjAbBZP48PoD80zfPOf3eomOxfIqWSHgHVoIXnu2AkuVWBBSQcXKCcNIX7dA4VefM
 61NGBA7SbKWz/f/YeMfHxTrtTL9mW2dmYOe6uMXr2c3zFTcD/Tib320RW0BVbg3glsiG
 IhWWBAej+0BmGY4MAqzynnShuUFMSjI8zuKn9YiX/qf7mAMm0/uJ0hC7d3i01B4m4Qf+
 7Ps4jHLDINAC/7BljAZP4xIHR9xIt8zdZ/3LP4juHC9ZC1WHcglJplEdjLk0whJp1vo3
 LQhiwUIpTIoiIfm9zcxZm9rkO5BUsgsagGSSxkPwfdCVn9MeIZ/Dfqg9vi05spyZ9cTe
 dV6A==
X-Gm-Message-State: AOJu0Yya+HvIx9lTOxFemGA4lxqBBgtNko2BlvVylZth8K/BRSI1sj99
 1rEfyTCReVeOVg75b52rTz54Cm99u9gUiigRJoVvJEeQ/pZvxntBKuSWIiaUFYtk7zZi2bZs5nK
 OxhZ6JMTTVGRqrjxDkM1cTDxt7BlDGI06
X-Gm-Gg: ASbGncsBwg8nJJnbPy5K2BD36bE0k7Ssqi6fhSYIeEpySmzGezFs3U/V+4KfEijjkn6
 sZol3GeTccmfVoEW8USA62yFYaShrH1FsgYJgYB7RyDw7Cb6KzDbpP6+H/ePT6g5GYg3kNZowA2
 H80OEe9JjZPbW2l6t2GUyruQ==
X-Google-Smtp-Source: AGHT+IFjBPMb9wDZ1zH7nT+x/yNuKS7HLmXQUBCifGXK09askqcmmoOgCP+K8397iUgt28SjknE9zCbz8LRwbILwKv8=
X-Received: by 2002:a17:90b:33cd:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-3082367472fmr2002341a91.4.1744386881742; Fri, 11 Apr 2025
 08:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
 <20250411082921.3228498-5-jesse.zhang@amd.com>
In-Reply-To: <20250411082921.3228498-5-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 11:54:30 -0400
X-Gm-Features: ATxdqUFSj4naUZ7I8FOmUGovoUd1bjnFrM_VVNI7bjgHL39E9YWvxPutZeuVsOg
Message-ID: <CADnq5_N2+-P1d+qzFYkgud7PpVn1SRdestcjY3MxRuDtV6494g@mail.gmail.com>
Subject: Re: [v5 5/6] drm/amdgpu: Implement SDMA soft reset directly for v5.x
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

On Fri, Apr 11, 2025 at 4:57=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 38 +++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 7139d574c23e..b271a0626886 100644
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
> @@ -554,6 +556,40 @@ void amdgpu_sdma_register_on_reset_callbacks(struct =
amdgpu_device *adev, struct
>         list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
>  }
>
> +static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instan=
ce_id)
> +{
> +       struct amdgpu_sdma_instance *sdma_instance =3D &adev->sdma.instan=
ce[instance_id];
> +       int r =3D 0;

r should default to an error, otherwise, we'll report success if
nothing happens.  with that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


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
> +               if (sdma_instance->funcs->soft_reset_kernel_queue)
> +                       r =3D sdma_instance->funcs->soft_reset_kernel_que=
ue(adev, instance_id);
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
> @@ -588,7 +624,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ad=
ev, uint32_t instance_id)
>                 sdma_instance->funcs->stop_kernel_queue(gfx_ring);
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
