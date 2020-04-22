Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560DAC54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 13:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C932076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 13:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1uNS/at"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C932076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8A96E9FC;
	Wed, 22 Apr 2020 13:35:24 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D938C6E9FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 13:35:22 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id x17so1682025wrt.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6xUV5kdnix72NZm9SxMSgbg2LRNymedUcTJt3yIg2M0=;
 b=n1uNS/atBX8b7JYdDqqrdnItSoNnwDDfISmBw4rt1ZeLcqG6FB0I2bVJfwPFgzwooa
 crYp1ZPawXtvOO8SwCMqQrl5zLMMfyMnxTPVMv8KBvy6zTXjHMaFiC6lIPrCcT0DZh8W
 k4/yPgVYrIWyRoSmbSVoOqzmW2zO9W9dh+KqhLohsPRq3BdKwG0h4hGe4a9+vt19+/73
 hzPcBZONdNmnQhYFUyzjTUJtmty4K69tXowCEPf6JjV59AjMAZy/Qo7dtEV2798tD6v2
 tVyVfsXK1ziqQWI8hkjK9PoPQTA/7/deLSWcPZZlX6R6SeuYgNuov3BZqIgbFgg43ogx
 RGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6xUV5kdnix72NZm9SxMSgbg2LRNymedUcTJt3yIg2M0=;
 b=TfMZ+pd45Xb6G6viJHnhRGQVi1heLsaVRPf5RBlh6ckLFEoljdYqOux2Lf1zy2Vzlj
 qQzXeh4V/MGTRd2mw4JWd1wo+evbckE/pcc0nXTgJmKQFnUIiD+CbZFQ3vE7dWbXR2Wu
 mL3DjlXLgsHtzxfi3q6XyyMjthZLNfki/D1jYNMbjX09d+7UPu3wzKKqDZs0s+3otf6/
 W57PRGgcGU5WKHCC25Mz7UkfiBvfF+zdTVwFnkt4cN6c03nfoaQUzBTsIMPOgYS20tpV
 2V5a7306ugKK+8SxQbr0BwIMRyDGJsi90SMi7t2f0J6ggszL62GbeK+jeRFA/iKXp+/c
 /e3Q==
X-Gm-Message-State: AGi0Pua8Ev+zAiZYxsMqueeiMoFQ24whKAzHHZ3pzkBPHqyhlTxUSAEn
 tkNrJeBwCZ6GrrWisFw++Klb++7k7DMoHGh+Wq8mv4WA
X-Google-Smtp-Source: APiQypL0f50ASBH1jE7RuR2y+7qm+JjqsCTpTszSMpxqze4eL1FFYvxLprGnW9h2bY7uWDtORLAJFAe/HQ9ekqsofTY=
X-Received: by 2002:a5d:5352:: with SMTP id t18mr3133050wrv.111.1587562521353; 
 Wed, 22 Apr 2020 06:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200422024221.16914-1-evan.quan@amd.com>
In-Reply-To: <20200422024221.16914-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Apr 2020 09:35:09 -0400
Message-ID: <CADnq5_O8bNkDnUYYn=nAOOq+0qZUMgZgM2ZeCE4BWA2NWQ_Fdg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: put the audio codec into suspend state before
 gpu reset V2
To: Evan Quan <evan.quan@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 21, 2020 at 10:42 PM Evan Quan <evan.quan@amd.com> wrote:
>
> At default, the autosuspend delay of audio controller is 3S. If the
> gpu reset is triggered within 3S(after audio controller idle),
> the audio controller may be unable into suspended state. Then
> the sudden gpu reset will cause some audio errors. The change
> here is targeted to resolve this.
>
> However if the audio controller is in use when the gpu reset
> triggered, this change may be still not enough to put the
> audio controller into suspend state. Under this case, the
> gpu reset will still proceed but there will be a warning
> message printed("failed to suspend display audio").
>
> V2: limit this for BACO and mode1 reset only
>
> Change-Id: I33d85e6fcad1882eb33f9cde8916d57be8d5a87a
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2d4b78d96426..70f43b1aed78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -69,6 +69,7 @@
>
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> +#include <linux/pm_runtime.h>
>
>  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
> @@ -4146,6 +4147,59 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
>         mutex_unlock(&adev->lock_reset);
>  }
>
> +static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
> +{
> +       struct pci_dev *p = NULL;
> +
> +       p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> +                       adev->pdev->bus->number, 1);
> +       if (p) {
> +               pm_runtime_enable(&(p->dev));
> +               pm_runtime_resume(&(p->dev));
> +       }
> +}
> +
> +static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
> +{
> +       enum amd_reset_method reset_method;
> +       struct pci_dev *p = NULL;
> +       unsigned long end_jiffies;
> +
> +       /*
> +        * For now, only BACO and mode1 reset are confirmed
> +        * to suffer the audio issue without proper suspended.
> +        */
> +       reset_method = amdgpu_asic_reset_method(adev);
> +       if ((reset_method != AMD_RESET_METHOD_BACO) &&
> +            (reset_method != AMD_RESET_METHOD_MODE1))
> +               return -EINVAL;
> +
> +       p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> +                       adev->pdev->bus->number, 1);
> +       if (!p)
> +               return -ENODEV;
> +
> +       /*
> +        * 3S is the audio controller default autosuspend delay setting.
> +        * 4S used here is guaranteed to cover that.
> +        */

Instead of hardcoding 3S, we should probably use
pm_runtime_autosuspend_expiration() to query how much time is left and
then use that.  That way this will work even if userspace has changed
the delay.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex


> +       end_jiffies = msecs_to_jiffies(4000) + jiffies;
> +       while (!pm_runtime_status_suspended(&(p->dev))) {
> +               if (!pm_runtime_suspend(&(p->dev)))
> +                       break;
> +
> +               if (time_after(jiffies, end_jiffies)) {
> +                       dev_warn(adev->dev, "failed to suspend display audio\n");
> +                       /* TODO: abort the succeeding gpu reset? */
> +                       return -ETIMEDOUT;
> +               }
> +       }
> +
> +       pm_runtime_disable(&(p->dev));
> +
> +       return 0;
> +}
> +
>  /**
>   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *
> @@ -4170,6 +4224,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>         bool use_baco =
>                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
>                 true : false;
> +       bool audio_suspended = false;
>
>         /*
>          * Flush RAM to disk so that after reboot
> @@ -4227,6 +4282,19 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                         return 0;
>                 }
>
> +               /*
> +                * Try to put the audio codec into suspend state
> +                * before gpu reset started.
> +                *
> +                * Due to the power domain of the graphics device
> +                * is shared with AZ power domain. Without this,
> +                * we may change the audio hardware from behind
> +                * the audio driver's back. That will trigger
> +                * some audio codec errors.
> +                */
> +               if (!amdgpu_device_suspend_display_audio(tmp_adev))
> +                       audio_suspended = true;
> +
>                 amdgpu_ras_set_error_query_ready(tmp_adev, false);
>
>                 cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
> @@ -4339,6 +4407,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                 /*unlock kfd: SRIOV would do it separately */
>                 if (!(in_ras_intr && !use_baco) && !amdgpu_sriov_vf(tmp_adev))
>                         amdgpu_amdkfd_post_reset(tmp_adev);
> +               if (audio_suspended)
> +                       amdgpu_device_resume_display_audio(tmp_adev);
>                 amdgpu_device_unlock_adev(tmp_adev);
>         }
>
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
