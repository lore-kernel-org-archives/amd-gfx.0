Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDE3C54FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 20:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2576B206B8
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 20:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Td+NVVw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2576B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32B76E330;
	Tue, 21 Apr 2020 20:18:18 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96FA6E330
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 20:18:17 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id g12so4983414wmh.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 13:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c0G3hj5wCH/6tChc+LgZxcgB5OPC/gqfGrVFo+0cXqk=;
 b=Td+NVVw2p2TK0ik9WU8gdltIyKJAsIC7eKsCX4f/oSGyeAL193/EM/D9Jmh8z0Xn31
 PhOckiusudx4nnf7i1OINC2TsyHRnMuVHM4trUN8K0KgCoeIkC7KtDdeBSu2e6lsjcCm
 YInzKITMriH+5Tjdm3SPNOEno78Rhjtpf0aHncq/RgzAmr7xtpO7cHiBTBB7lYW447qT
 SHwejfbGKHzYYOCt4wb1mWqV0GSsK1sRuTP5xGvfYkc033YDqNey+fiFgT9pTlW8dgQ3
 40k/MlUUk/ca9MLKy/1QoP8hh2ZphK/FVKFzK7axgRyrzOg1vJA43fbEFl5sh7Buly5s
 nGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c0G3hj5wCH/6tChc+LgZxcgB5OPC/gqfGrVFo+0cXqk=;
 b=WFYG5ajCix2+tWyQmZwuqgG0+AFOgmN3siXM2qsabggC9Lb96fhq2vATMUaNoI0Ihm
 1900ve43b0Z1DB6IEDeycxNt+D3L9EIkGTtn7gqtgNKGlLrtOlkV4GGU5/oGCfmfOMFY
 FTUw4nIVpg1NR9QWYNWPsiT2xpO9VSjJHtZYWVdGs9OEmFm6ga/TY7s8zo5pp1wuKsUe
 1Af7hZu4C30fRNtyIzE7WULJ1Flrvda3/U4GTTUmqnpwSL7UCrhMGrmyxW/FBt5dL7mz
 56EDzF0du2Dh2yDcubtEb6+nn+st+Sy4pnIS8htySPtUs1e4Id28LZfYnOeZKMshkByT
 EBbw==
X-Gm-Message-State: AGi0PuatX/ZRN1OvN7BZ0sV2/P1wmiVrZlE5poIFFne/9PzK3iD0F9bK
 vz8vQ9PXLr/JKkJd5ORddoPTiJqaO2iwRlOudfJ6DA==
X-Google-Smtp-Source: APiQypLzHkWtQIfXfJpwuwVnqkcTpo/6Dv5y6vXHnpMae7CPoxAAUse2j2gBzgcXbeZOQPAMqIW67zEiubqAHjO3StE=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr6620069wmh.39.1587500296430; 
 Tue, 21 Apr 2020 13:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200421120018.11399-1-evan.quan@amd.com>
In-Reply-To: <20200421120018.11399-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Apr 2020 16:18:05 -0400
Message-ID: <CADnq5_M_VLGcqySs07JecqmfK6dz5UGkb+iNs53iRgiYH01bsA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: put the audio codec into suspend state before
 gpu reset
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

On Tue, Apr 21, 2020 at 8:00 AM Evan Quan <evan.quan@amd.com> wrote:
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
> Change-Id: I33d85e6fcad1882eb33f9cde8916d57be8d5a87a
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2d4b78d96426..983e294d0300 100644
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
> @@ -4146,6 +4147,49 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
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
> +       struct pci_dev *p = NULL;
> +       unsigned long end_jiffies;
> +
> +       p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> +                       adev->pdev->bus->number, 1);
> +       if (!p)
> +               return -ENODEV;
> +

With mode1 reset affect this or just BACO?  If it's just BACO, we
should check the reset method here and return an error if not using
BACO.

Alex


> +       /*
> +        * 3S is the audio controller default autosuspend delay setting.
> +        * 4S used here is guaranteed to cover that.
> +        */
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
> @@ -4170,6 +4214,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>         bool use_baco =
>                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
>                 true : false;
> +       bool audio_suspended = false;
>
>         /*
>          * Flush RAM to disk so that after reboot
> @@ -4227,6 +4272,19 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
> @@ -4339,6 +4397,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
