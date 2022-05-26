Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD8EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 14:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B398F10E622;
	Thu, 26 May 2022 14:49:55 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9F510E622
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 14:49:54 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-f16a3e0529so2468815fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I8bejh+dU9oiLlUCogSMJUQGO+PLd0P/tRGvDXKQt2k=;
 b=GBYVe9JfyorxovaUz/N3g5TA3XC+BP/sYgehRDt/c4MrSSVBKAJvc0Cj43m/ULPPqj
 P/4pe8qtZYRDanV/cBIVIiAo2lqpYnSvviklRpUcWg7zWBnVk4XkYd9g+BAapaT+dPdH
 +ryv03CDKlPX4W7izHqE9QvitOk1SCCmtluhxaQybEjmUAqkgOu7vg6NhWgcz/UVY9ua
 x4PM5rOiDEd/E141uZk2sFjw4/dVMv5AW+VeK6LwFJXKo7qJzCuZUdZfXHVRUtc8oJmX
 wd+qEonCCtC41i11OSu2d1p1WOb7kjq3+y/sdll1doOA8xsgBtKjnPLcM3igU94OOGPC
 +HZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I8bejh+dU9oiLlUCogSMJUQGO+PLd0P/tRGvDXKQt2k=;
 b=5WyGq5lY2A59SOYCONq2KUkEDkbqTlM5A2nXAZu4uMC2O49/OzFEsuc0RBYu8cy3e6
 upk3C9mNoST7GzgGQxs62RMokF5etQdOvG88+cQbBloCoi8m5CeczyRLFefIYiG86tHu
 h6WOBbmUSudrE1RZXFJ/DzjQ3dXPISl0M9C3hyZDh8LLKKFt359CWyZVDELsVD9Q+Wws
 Zw+DCBak2g2vcwBccng8jbDDL3EmElEG+9oaBYSsRLU6GUCiwbgrd5ovxocyyYjROQk3
 QPVYbSIaOiV15yKOU7ku1WP4P7wZWunv56gprOi3Up63I40DZm/AAlENk97GoJy9/5fz
 M9RQ==
X-Gm-Message-State: AOAM533vOkTq2913M/Y2F8SVpsqXNYs6sHVhFwTlhKbFM0jQxY9EiNGI
 2n6oZVsUrFGykg51MxKCl6admCueLZ9J+wimOSnoIWbx
X-Google-Smtp-Source: ABdhPJyfefsJ0MwqlxHX5uJVrgDbjIjoiWyiZpmJbFzkAGSR7dlppeLa6WlnUHeYOBZPEZ7NZOnZeudXJDAfn7gEiCY=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr1354567oaa.200.1653576593957; Thu, 26
 May 2022 07:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220520030405.1308133-1-ray.huang@amd.com>
 <20220520030405.1308133-2-ray.huang@amd.com>
In-Reply-To: <20220520030405.1308133-2-ray.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 May 2022 10:49:43 -0400
Message-ID: <CADnq5_Mt4QJYRt1AOCuoAtdX405OnNDrZdg6Gy-JgE9jW8smog@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: use the callback function for reset
 status polling on IMU
To: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is: Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 19, 2022 at 11:05 PM Huang Rui <ray.huang@amd.com> wrote:
>
> Switch to use the callback function to poll the reset status on IMU.
> Because it will have different sequency on other ASICs.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c  | 35 ++++++++++++++++---------
>  2 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
> index cfc4a92837f0..484e936812e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
> @@ -35,6 +35,7 @@ struct amdgpu_imu_funcs {
>      void (*setup_imu)(struct amdgpu_device *adev);
>      int (*start_imu)(struct amdgpu_device *adev);
>      void (*program_rlc_ram)(struct amdgpu_device *adev);
> +    int (*wait_for_reset_status)(struct amdgpu_device *adev);
>  };
>
>  struct imu_rlc_ram_golden {
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index da18d6724125..64da0ad688d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -117,6 +117,25 @@ static int imu_v11_0_load_microcode(struct amdgpu_device *adev)
>         return 0;
>  }
>
> +static int imu_v11_0_wait_for_reset_status(struct amdgpu_device *adev)
> +{
> +       int i, imu_reg_val = 0;
> +
> +       for (i = 0; i < adev->usec_timeout; i++) {
> +               imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
> +               if ((imu_reg_val & 0x1f) == 0x1f)
> +                       break;
> +               udelay(1);
> +       }
> +
> +       if (i >= adev->usec_timeout) {
> +               dev_err(adev->dev, "init imu: IMU start timeout\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 0;
> +}
> +
>  static void imu_v11_0_setup(struct amdgpu_device *adev)
>  {
>         int imu_reg_val;
> @@ -146,19 +165,8 @@ static int imu_v11_0_start(struct amdgpu_device *adev)
>         imu_reg_val &= 0xfffffffe;
>         WREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL, imu_reg_val);
>
> -       if (adev->gfx.imu.mode == DEBUG_MODE) {
> -               for (i = 0; i < adev->usec_timeout; i++) {
> -                       imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
> -                       if ((imu_reg_val & 0x1f) == 0x1f)
> -                               break;
> -                       udelay(1);
> -               }
> -
> -               if (i >= adev->usec_timeout) {
> -                       dev_err(adev->dev, "init imu: IMU start timeout\n");
> -                       return -ETIMEDOUT;
> -               }
> -       }
> +       if (adev->gfx.imu.mode == DEBUG_MODE)
> +               return imu_v11_0_wait_for_reset_status(adev);
>
>         return 0;
>  }
> @@ -368,4 +376,5 @@ const struct amdgpu_imu_funcs gfx_v11_0_imu_funcs = {
>         .setup_imu = imu_v11_0_setup,
>         .start_imu = imu_v11_0_start,
>         .program_rlc_ram = imu_v11_0_program_rlc_ram,
> +       .wait_for_reset_status = imu_v11_0_wait_for_reset_status,
>  };
> --
> 2.25.1
>
