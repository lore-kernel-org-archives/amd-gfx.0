Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1210C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6799E10E2EC;
	Fri, 11 Jul 2025 22:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gsL//Qet";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFDBE10E2EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:35:21 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-31384c8ba66so513608a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752273321; x=1752878121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APQp9NUXICQOsRMmGXlqQUazhUvOA8vqpsj9shidyvU=;
 b=gsL//QetDFAVPEugZgwgBfos8wBDvTeyfu8bwccmyAuzCISFs/yJEr4RTFvAwiClzx
 ScKqOz576qc53A+4uIP6QQjbk6dtxm1R0rKZUeIpysv6NFIa90LHXSBjGmQjumV15mln
 HI/OD8N6eDaQ2adHq+HOCUveOPDlnAjtHpRlpVRtIL7IM0iyJrbB/P2l+xU9YSFW8+yH
 nUQW/r9NPHGWqEaMea39WlSKsaOKaeeoClqi8GFMf+VltAH3upS755l9t9uTqNRkIn+L
 aBum4Ht28ksjtfaCQj5P3M9OJ8DR3WLziMsNtQfO5F5kxCSJLLGjOWuXLowBFf1szzUW
 XnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752273321; x=1752878121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APQp9NUXICQOsRMmGXlqQUazhUvOA8vqpsj9shidyvU=;
 b=nWA0MsIa33y0sznoTbyjWVjBv8xCx4h6UUMX1SblnIxPPVoTtZv4IX5dkYUmjI/xKx
 StkgzOuBhCELS/G6OC8nkoKyBbJIWZH3FfWuqb8r69/Tyjfa1j05zEk71K8Vcw9hPD50
 PoReFeTTMVT8WeQCy0YRmE9xY+fyFI3G8VFx2mPHCYXYWiIBihI28Eui7yUptx86gHfY
 8lmgP7xVeW+r5tEFs7dsyQKCur3vqBfB7Xbp7JAfEJWzqCv4gzOndyjPByT0Tryn0/fC
 ezm51qQYEIcpOJR9Tvz82ja3S4cDh0kN5/JjCAu9QCbBkRxWOF6+whM9XebPGIUjyIUV
 xfNA==
X-Gm-Message-State: AOJu0YwavQr2/AViOJpMIekb79scEQmTrBuL9bE8oUVYSsT5N282iz9q
 sNJ25QleRG7fl4R9KS2FYPY0vYWNVZlJBNxQ2dxIg3cfHckfR6Qbc5bdPybeLBuH6CaPhAIpgC2
 7f78uvCHwGJQeQxCLrdvFZaHyjT/zrfo=
X-Gm-Gg: ASbGnctWyPlLeWMZoN5TScN1Xh2UARyCZFi/1fJf6+A5sN1ombh7V5atB2AcMxGCpNt
 HzAa7hv2s9gaZqSaSp/AFTvuk1+dm3A1oua8AMtbw3GA9oujpSA/BlgX6r+6VS83z8JDcwIdd5y
 tjQvfGcgFOsekty72nPz0APGh1H/wSnpQf6a4KBU27lgmZ1iNbfImCQyRVc/U+pAjx+XrEZCkzE
 af5U2IS
X-Google-Smtp-Source: AGHT+IGXj9E5bLhbb8j0z/xr5ZoSt1G5rzKlH408DrERwMFttHK5AyaWfJFsWh53aqzf3M7z0QoGJeWG60iCnDFjiWs=
X-Received: by 2002:a17:90b:3512:b0:312:e76f:520f with SMTP id
 98e67ed59e1d1-31c4f56e8e2mr2185383a91.8.1752273321028; Fri, 11 Jul 2025
 15:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250711083558.1372311-1-jesse.zhang@amd.com>
In-Reply-To: <20250711083558.1372311-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Jul 2025 18:35:09 -0400
X-Gm-Features: Ac12FXybv4mUiMdT4XC6BH1fZOhPTUvMl53GEWIo8KflWLaNU0dwbT-TKH_TqRU
Message-ID: <CADnq5_NrOASWfXg+Ofx3AB9MiVo2sNoQmUeffY6PoeWPDU6RLg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add atomic CPU-GPU clock counter correlation
To: Jesse Zhang <jesse.zhang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, 
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, lijo.lazar@amd.com
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

On Fri, Jul 11, 2025 at 5:13=E2=80=AFAM Jesse Zhang <jesse.zhang@amd.com> w=
rote:
>
> This patch introduces a new IOCTL to provide tightly correlated
> CPU and GPU timestamps for accurate performance measurements
> and synchronization between host and device timelines.
>
> Key improvements:
> 1. Adds AMDGPU_INFO_CLOCK_COUNTERS query type (0x06)
> 2. Implements atomic sampling of clocks with:
>    - preempt_disable()
>    - local IRQ disabling
>    - GPU timestamp sampled first (higher latency)
>    - CPU timestamps sampled immediately after
> 3. Provides three correlated clocks:
>    - GPU clock counter (ns)
>    - CPU raw monotonic time (ns)
>    - System boottime (ns)
> 4. Includes system clock frequency (1GHz) for reference
>
> The implementation addresses the need for precise CPU-GPU
> timestamp correlation in ROCm applications, particularly for:
> - Performance analysis tools
> - Compute pipeline synchronization
> - Graphics/compute interoperability
> - Low-latency VR/AR applications
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 +++++++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           | 19 +++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 931c52c918c4..8412c88aada9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -595,6 +595,43 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *a=
dev,
>         return 0;
>  }
>
> +/**
> + * get_cpu_gpu_counters - Atomically sample CPU and GPU clocks
> + * @adev: amdgpu device pointer
> + * @args: structure to store clock counters
> + *
> + * Samples CPU and GPU clocks as close to simultaneously as possible
> + * by disabling preemption and interrupts during the sampling.
> + * Returns 0 on success.
> + */
> +static int get_cpu_gpu_counters(struct amdgpu_device *adev,
> +                               struct drm_amdgpu_info_clock_counters *ar=
gs)

prefix this function with amdgpu_ for consistency.  Other than that,
it looks good to me.  Felix, Harish, this mirrors what we do in KFD.
Was there any other timing data you wanted to include?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +{
> +       unsigned long flags;
> +
> +       /* Disable preemption and interrupts on local CPU */
> +       preempt_disable();
> +       local_irq_save(flags);
> +
> +       if (adev->gfx.funcs->get_gpu_clock_counter)
> +               args->gpu_clock_counter =3D adev->gfx.funcs->get_gpu_cloc=
k_counter(adev);
> +       else
> +               args->gpu_clock_counter =3D 0;
> +
> +       /* No access to rdtsc. Using raw monotonic time */
> +       args->cpu_clock_counter =3D ktime_get_raw_ns();
> +       args->system_clock_counter =3D ktime_get_boottime_ns();
> +
> +       /* Since the counter is in nano-seconds we use 1GHz frequency */
> +       args->system_clock_freq =3D 1000000000;
> +
> +       /* Restore previous state */
> +       local_irq_restore(flags);
> +       preempt_enable();
> +
> +       return 0;
> +}
> +
>  /*
>   * Userspace get information ioctl
>   */
> @@ -734,6 +771,13 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
>         case AMDGPU_INFO_TIMESTAMP:
>                 ui64 =3D amdgpu_gfx_get_gpu_clock_counter(adev);
>                 return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT =
: 0;
> +       case AMDGPU_INFO_CLOCK_COUNTERS: {
> +               struct drm_amdgpu_info_clock_counters counters;
> +
> +                memset(&counters, 0, sizeof(counters));
> +               get_cpu_gpu_counters(adev, &counters);
> +               return copy_to_user(out, &counters, min(size, sizeof(coun=
ters))) ? -EFAULT : 0;
> +       }
>         case AMDGPU_INFO_FW_VERSION: {
>                 struct drm_amdgpu_info_firmware fw_info;
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index bdedbaccf776..e8adbbd076ca 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1056,6 +1056,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_HW_IP_COUNT                        0x03
>  /* timestamp for GL_ARB_timer_query */
>  #define AMDGPU_INFO_TIMESTAMP                  0x05
> +/* get synchronized CPU and GPU clock counters  */
> +#define AMDGPU_INFO_CLOCK_COUNTERS             0x06
>  /* Query the firmware version */
>  #define AMDGPU_INFO_FW_VERSION                 0x0e
>         /* Subquery id: Query VCE firmware version */
> @@ -1598,6 +1600,23 @@ struct drm_amdgpu_info_uq_metadata {
>         };
>  };
>
> +/**
> + * struct drm_amdgpu_info_clock_counters - Clock counter information
> + *
> + * Used to correlate timestamps between CPU and GPU with minimal skew.
> + * All counters are in nanoseconds for consistent comparison.
> + */
> +struct drm_amdgpu_info_clock_counters {
> +       /* GPU clock counter in nanoseconds */
> +       __u64 gpu_clock_counter;
> +       /* CPU clock counter (raw monotonic) in nanoseconds */
> +       __u64 cpu_clock_counter;
> +       /* System boottime clock counter in nanoseconds */
> +       __u64 system_clock_counter;
> +       /* System clock frequency in Hz (always 1GHz) */
> +       __u64 system_clock_freq;
> +};
> +
>  /*
>   * Supported GPU families
>   */
> --
> 2.34.1
>
