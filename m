Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0267DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 17:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4D110E010;
	Thu, 26 May 2022 17:50:52 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E6310E010
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 17:50:50 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-e656032735so3106851fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fMN1q5LX+q0GWN++xvXU/OAM3iwDE7Br4PuZ22YDA24=;
 b=a8rDkOZEH8wjHRrbNl4RGhkCLo3FtyJhUu83kskNI2lLxNp9yafXEQitVvNF5pLa8e
 DDwJUJLzLXB2tK1PvDuoekUgwNqjWqa/Z789Yz3RFxAZ1kzPofNTyZ+2qAThDWlwk07l
 Q2LcgPEoQTO9z6WRKcd9TtUUXEe4rLsraeJEHg4VjL6yNdKGv83AB+tkhWBpz2VlFS16
 fORYDeJH2JSXMT9Oy1mycaj+JUvpgs7tPMNmEvTYUA1P10ZeV3Qkrv1iRJDWaOJiHbNG
 DYPh30V4xLaxDNNOOWQokxCWqY0e9pZmkSSUX64qwA1gYGD9saYaM363GGDhKKxQXa3o
 hhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fMN1q5LX+q0GWN++xvXU/OAM3iwDE7Br4PuZ22YDA24=;
 b=KItxgNAPN6baKTyYXUPB0e0c7bZ8om6kw7zd5owAg8d79OJPAoUHa9WcMI3OZpEtia
 ky4TdmoWZMdvwpUYzqTei6S7lH2T0lBfPRFLF6dYr/s6ix10g46sOZEDoCQxK9zej4bY
 9hnspfio4WPEgyprcfkvu04da/7Gfn3dr+AQoqabbfEbLvlHLai7VSzNRuxuleplhNXE
 /yAzwpVvoymmidQ3hfrDHBSiyoOn6KGZh6iMn1aUrALl0KsxBJ/kVbLB02wzFlCXV9Yj
 y5611aWy8xHGq1FnUEMOo+LxrWCqMkv38G/1ef3iTVZaVs5b9CiAkULcY5+9XS5hWbFp
 hCJg==
X-Gm-Message-State: AOAM532mTEdZF4dmPNY8qiBzAtffjS4NqNKJJBlqFaQYmUNJC2+3ia5o
 K4+Ndi0n2qKzYCtHqsGFq9jSXoVKCC07mZv44RsXP3aj
X-Google-Smtp-Source: ABdhPJz+lhWGIBXnx8j+Ei6s+ZQvEn7ORDSQ4G+1vtYnDJZlpTKodMaOFNVOUzORwMWhcoKiPPmS16xb5BKaXu/ULxg=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr1982343oap.253.1653587450148; Thu, 26
 May 2022 10:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220520030405.1308133-1-ray.huang@amd.com>
 <20220520030405.1308133-2-ray.huang@amd.com>
In-Reply-To: <20220520030405.1308133-2-ray.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 May 2022 13:50:39 -0400
Message-ID: <CADnq5_OPSu+wFS7VDUjEFapxauyVMbP+f1pRv-h6qq0SzKm7ig@mail.gmail.com>
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

You can drop the stack variable i in this function now.  With that
fixed, the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

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
