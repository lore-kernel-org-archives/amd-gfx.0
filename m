Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E30C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 15:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE88B2074F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 15:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZSwFUdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE88B2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F1A6EBE1;
	Thu,  9 Apr 2020 15:21:16 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60D86EBE1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 15:21:14 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id v5so12347567wrp.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2020 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iatm4g+lhsFd4XCzTwkDLd6jOsKF6ax5cfsoVf3UF4A=;
 b=vZSwFUdyVg0BllJbL8cR/U3pdopcaR4M3c5gy4ljf/9FwK6bCtxACKVhxLArMuvAIV
 kWbO/jXY4sXQ6vBsIUPfXg2iT82sBtbLjffnmS9AMA/ObTCduev7HaztMU3SdMknJn7k
 BGzg1oJUdqPC8mA1LBEzEjFWU/oWGTBz2LW+0/O7dqgEQ2En5SJFOsssNWvSo1xR3uHd
 ryGTcrlmpeHXnFKChm/tR+vgvqrcHU1k6IgMIUDnqPImjwv8gdqjNyhBcWTR6m6ulHrM
 8nEOOfwvBLNUR+Iy+SOx+EYWl1WVfRQbZOnSM8A2YONi5Ye5Ly8YccbxZSOSyKP1/mJt
 kquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iatm4g+lhsFd4XCzTwkDLd6jOsKF6ax5cfsoVf3UF4A=;
 b=NBXIe2gqmt7R6wzNF/RDj98E1iYaxTeIfZPMan0iK9JCUVEDAHU/QBa+5VJdSshvv7
 jrufvd9+WIobA8zhdGn5ZpoASIFhuvalPQ4SY1fHwanW8oePqWQtobLLcxqR9Ztda6Kl
 ver+ISbiLP1WCzclhZ9R3HyvtX1fcQISWYkx7Egx7lGBuEoJDgsPxfJjK04jcmaNY/YX
 Iv4Ju/x9cEZlMofu0WMPtA77Ur6fWZ/oOKijY/xJ3iG07HlyX8T83oGiG1vmFnszCt7U
 zG6Z4ZO6poYr7INEWfYwssgPWL7XUP2S1HF068yiVHcqomemZUhVzu/mQJ0BggklBjpt
 LhnA==
X-Gm-Message-State: AGi0Pua8CRAuzldxo92JsVrsg7ZDXIxC7rjsIScV6iU2hiiDgEIOU3YX
 QMLdql3KebcJR/RCPOGyKgJs/u6REw0TypwGc4COvnRh
X-Google-Smtp-Source: APiQypLAIkm03DsMrZEy36oSSlEjK/Bwz8O3GegBXsbTFOGMBQ048luqRK1n8THzRcTEAjJ2z6R/RHnD3+OPsnUCWcU=
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr292865wrj.419.1586445673396; 
 Thu, 09 Apr 2020 08:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200409145415.6837-1-yttao@amd.com>
In-Reply-To: <20200409145415.6837-1-yttao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Apr 2020 11:21:02 -0400
Message-ID: <CADnq5_Nydi5rJOyamULk_5vKuy6gK8DKZJ9aTSOND2T_acjeVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: restrict debugfs register access under SR-IOV
To: Yintian Tao <yttao@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 9, 2020 at 10:54 AM Yintian Tao <yttao@amd.com> wrote:
>
> Under bare metal, there is no more else to take
> care of the GPU register access through MMIO.
> Under Virtualization, to access GPU register is
> implemented through KIQ during run-time due to
> world-switch.
>
> Therefore, under SR-IOV user can only access
> debugfs to r/w GPU registers when meets all
> three conditions below.
> - amdgpu_gpu_recovery=0
> - TDR happened
> - in_gpu_reset=0
>
> v2: merge amdgpu_virt_can_access_debugfs() into
>     amdgpu_virt_enable_access_debugfs()
>
> Signed-off-by: Yintian Tao <yttao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 73 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  8 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 26 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  7 ++
>  4 files changed, 108 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index c0f9a651dc06..1a4894fa3693 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -152,11 +152,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>         if (r < 0)
>                 return r;
>
> +       r = amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0)
> +               return r;
> +
>         if (use_bank) {
>                 if ((sh_bank != 0xFFFFFFFF && sh_bank >= adev->gfx.config.max_sh_per_se) ||
>                     (se_bank != 0xFFFFFFFF && se_bank >= adev->gfx.config.max_shader_engines)) {
>                         pm_runtime_mark_last_busy(adev->ddev->dev);
>                         pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       amdgpu_virt_disable_access_debugfs(adev);
>                         return -EINVAL;
>                 }
>                 mutex_lock(&adev->grbm_idx_mutex);
> @@ -207,6 +212,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>         pm_runtime_mark_last_busy(adev->ddev->dev);
>         pm_runtime_put_autosuspend(adev->ddev->dev);
>
> +       amdgpu_virt_disable_access_debugfs(adev);
>         return result;
>  }
>
> @@ -255,6 +261,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>         if (r < 0)
>                 return r;
>
> +       r = amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0)
> +               return r;
> +
>         while (size) {
>                 uint32_t value;
>
> @@ -263,6 +273,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>                 if (r) {
>                         pm_runtime_mark_last_busy(adev->ddev->dev);
>                         pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
>
> @@ -275,6 +286,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>         pm_runtime_mark_last_busy(adev->ddev->dev);
>         pm_runtime_put_autosuspend(adev->ddev->dev);
>
> +       amdgpu_virt_disable_access_debugfs(adev);
>         return result;
>  }
>
> @@ -304,6 +316,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>         if (r < 0)
>                 return r;
>
> +       r = amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0)
> +               return r;
> +
>         while (size) {
>                 uint32_t value;
>
> @@ -311,6 +327,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>                 if (r) {
>                         pm_runtime_mark_last_busy(adev->ddev->dev);
>                         pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
>
> @@ -325,6 +342,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>         pm_runtime_mark_last_busy(adev->ddev->dev);
>         pm_runtime_put_autosuspend(adev->ddev->dev);
>
> +       amdgpu_virt_disable_access_debugfs(adev);
>         return result;
>  }
>
> @@ -354,6 +372,10 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>         if (r < 0)
>                 return r;
>
> +       r = amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0)
> +               return r;
> +
>         while (size) {
>                 uint32_t value;
>
> @@ -362,6 +384,7 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>                 if (r) {
>                         pm_runtime_mark_last_busy(adev->ddev->dev);
>                         pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
>
> @@ -374,6 +397,7 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>         pm_runtime_mark_last_busy(adev->ddev->dev);
>         pm_runtime_put_autosuspend(adev->ddev->dev);
>
> +       amdgpu_virt_disable_access_debugfs(adev);
>         return result;
>  }
>
> @@ -403,6 +427,10 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>         if (r < 0)
>                 return r;
>
> +       r = amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0)
> +               return r;
> +
>         while (size) {
>                 uint32_t value;
>
> @@ -410,6 +438,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>                 if (r) {
>                         pm_runtime_mark_last_busy(adev->ddev->dev);
>                         pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
>
> @@ -424,6 +453,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>         pm_runtime_mark_last_busy(adev->ddev->dev);
>         pm_runtime_put_autosuspend(adev->ddev->dev);
>
> +       amdgpu_virt_disable_access_debugfs(adev);
>         return result;
>  }
>
> @@ -453,6 +483,10 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>         if (r < 0)
>                 return r;
>
> +       r = amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0)
> +               return r;
> +
>         while (size) {
>                 uint32_t value;
>
> @@ -461,6 +495,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>                 if (r) {
>                         pm_runtime_mark_last_busy(adev->ddev->dev);
>                         pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
>
> @@ -473,6 +508,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>         pm_runtime_mark_last_busy(adev->ddev->dev);
>         pm_runtime_put_autosuspend(adev->ddev->dev);
>
> +       amdgpu_virt_disable_access_debugfs(adev);
>         return result;
>  }
>
> @@ -502,6 +538,10 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>         if (r < 0)
>                 return r;
>
> +       r = amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0)
> +               return r;
> +
>         while (size) {
>                 uint32_t value;
>
> @@ -509,6 +549,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>                 if (r) {
>                         pm_runtime_mark_last_busy(adev->ddev->dev);
>                         pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
>
> @@ -523,6 +564,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>         pm_runtime_mark_last_busy(adev->ddev->dev);
>         pm_runtime_put_autosuspend(adev->ddev->dev);
>
> +       amdgpu_virt_disable_access_debugfs(adev);
>         return result;
>  }
>
> @@ -651,16 +693,24 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
>         if (r < 0)
>                 return r;
>
> +       r = amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0)
> +               return r;
> +
>         r = amdgpu_dpm_read_sensor(adev, idx, &values[0], &valuesize);
>
>         pm_runtime_mark_last_busy(adev->ddev->dev);
>         pm_runtime_put_autosuspend(adev->ddev->dev);
>
> -       if (r)
> +       if (r) {
> +               amdgpu_virt_disable_access_debugfs(adev);
>                 return r;
> +       }
>
> -       if (size > valuesize)
> +       if (size > valuesize) {
> +               amdgpu_virt_disable_access_debugfs(adev);
>                 return -EINVAL;
> +       }
>
>         outsize = 0;
>         x = 0;
> @@ -673,6 +723,7 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
>                 }
>         }
>
> +       amdgpu_virt_disable_access_debugfs(adev);
>         return !r ? outsize : r;
>  }
>
> @@ -720,6 +771,10 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>         if (r < 0)
>                 return r;
>
> +       r = amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0)
> +               return r;
> +
>         /* switch to the specific se/sh/cu */
>         mutex_lock(&adev->grbm_idx_mutex);
>         amdgpu_gfx_select_se_sh(adev, se, sh, cu);
> @@ -734,16 +789,20 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>         pm_runtime_mark_last_busy(adev->ddev->dev);
>         pm_runtime_put_autosuspend(adev->ddev->dev);
>
> -       if (!x)
> +       if (!x) {
> +               amdgpu_virt_disable_access_debugfs(adev);
>                 return -EINVAL;
> +       }
>
>         while (size && (offset < x * 4)) {
>                 uint32_t value;
>
>                 value = data[offset >> 2];
>                 r = put_user(value, (uint32_t *)buf);
> -               if (r)
> +               if (r) {
> +                       amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
> +               }
>
>                 result += 4;
>                 buf += 4;
> @@ -751,6 +810,7 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>                 size -= 4;
>         }
>
> +       amdgpu_virt_disable_access_debugfs(adev);
>         return result;
>  }
>
> @@ -805,6 +865,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>         if (r < 0)
>                 return r;
>
> +       r = amdgpu_virt_enable_access_debugfs(adev);
> +       if (r < 0)
> +               return r;
> +
>         /* switch to the specific se/sh/cu */
>         mutex_lock(&adev->grbm_idx_mutex);
>         amdgpu_gfx_select_se_sh(adev, se, sh, cu);
> @@ -840,6 +904,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>
>  err:
>         kfree(data);
> +       amdgpu_virt_disable_access_debugfs(adev);
>         return result;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 2b99f5952375..35c381ec0423 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -33,6 +33,7 @@ static void amdgpu_job_timedout(struct drm_sched_job *s_job)
>         struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>         struct amdgpu_job *job = to_amdgpu_job(s_job);
>         struct amdgpu_task_info ti;
> +       struct amdgpu_device *adev = ring->adev;
>
>         memset(&ti, 0, sizeof(struct amdgpu_task_info));
>
> @@ -49,10 +50,13 @@ static void amdgpu_job_timedout(struct drm_sched_job *s_job)
>         DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
>                   ti.process_name, ti.tgid, ti.task_name, ti.pid);
>
> -       if (amdgpu_device_should_recover_gpu(ring->adev))
> +       if (amdgpu_device_should_recover_gpu(ring->adev)) {
>                 amdgpu_device_gpu_recover(ring->adev, job);
> -       else
> +       } else {
>                 drm_sched_suspend_timeout(&ring->sched);
> +               if (amdgpu_sriov_vf(adev))
> +                       adev->virt.tdr_debug = true;
> +       }
>  }
>
>  int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 4d06c79065bf..e8266847675b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -334,3 +334,29 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>                         adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>         }
>  }
> +
> +bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev)
> +{
> +       return amdgpu_sriov_is_debug(adev) ? true : false;
> +}
> +
> +int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev)
> +{
> +       int ret = 0;
> +
> +       if (!amdgpu_sriov_vf(adev))
> +               return ret;
> +
> +       if (amdgpu_virt_can_access_debugfs(adev))
> +               adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
> +       else
> +               ret = -EPERM;
> +
> +       return ret;

You can drop the ret variable in this function and just return
constants for each case.  E.g.,

> +       if (!amdgpu_sriov_vf(adev))
> +               return 0;
> +
> +       if (amdgpu_virt_can_access_debugfs(adev))
> +               adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
> +       else
> +               return -EPERM;
> +
> +       return 0;

Other than that the patch looks good to me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

> +}
> +
> +void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev)
> +{
> +       if (amdgpu_sriov_vf(adev))
> +               adev->virt.caps |= AMDGPU_SRIOV_CAPS_RUNTIME;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index f6ae3c656304..8f20e6dbd7a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -265,6 +265,7 @@ struct amdgpu_virt {
>         uint32_t gim_feature;
>         uint32_t reg_access_mode;
>         int req_init_data_ver;
> +       bool tdr_debug;
>  };
>
>  #define amdgpu_sriov_enabled(adev) \
> @@ -296,6 +297,8 @@ static inline bool is_virtual_machine(void)
>
>  #define amdgpu_sriov_is_pp_one_vf(adev) \
>         ((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
> +#define amdgpu_sriov_is_debug(adev) \
> +       ((!adev->in_gpu_reset) && adev->virt.tdr_debug)
>
>  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>  void amdgpu_virt_init_setting(struct amdgpu_device *adev);
> @@ -314,4 +317,8 @@ int amdgpu_virt_fw_reserve_get_checksum(void *obj, unsigned long obj_size,
>                                         unsigned int chksum);
>  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
>  void amdgpu_detect_virtualization(struct amdgpu_device *adev);
> +
> +bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
> +int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
> +void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
>  #endif
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
