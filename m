Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5C4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25D761104
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B25D761104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3817E6E85A;
	Wed, 10 Nov 2021 15:14:13 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1166E85A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 15:14:11 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id q25so219900oiw.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 07:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=puvX0B0mwY4GudxROVnAkEYPvwc2bvNFG0dvhHDOVG8=;
 b=bA3diaynO74YtMuv8Afgye+IeCCbiFaSWVon0JM0ftmpY6TcblzSxDDuzCi6TJmSab
 QPWvRswrE2dBCROpBzZEahNdqBlIWQhpyfscs2/HLgrQCYtTfhnl6/6ALXlh/iftLIpi
 q5feyNj2Ipxtb61zJRyAosc8M9i5qjUONjK24hMVVvH+ndgvWE6i0YUn9NXnqHaCJeeD
 ARIvzEYVUnwx3V3uP5AroV10lEtQXXAS9zNYzM3g8AOMFHYPb+Vw7xEfl3l5o3hnHKas
 6a2gNDYnQipv4dDHunL1aKjh8fnyKWVnIdXaypj7nyaXVyoS581ERpLCjNtwwxn34ipG
 613Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=puvX0B0mwY4GudxROVnAkEYPvwc2bvNFG0dvhHDOVG8=;
 b=ByeJX5aUOs0RdoydGacz1dIgtM33eUaSkwEI5Ou/1Dl9uttFotJj5h+DtmGrvaco/7
 3sFCE2B+Iz+H7Mq0gcBO71fdczy5KLfX7gW9hLEpj08JgMCOwVOqlSYO5cNS4eqNjmeZ
 8dWme7XimcaLohw/9E7cuGPj9v0qAGHUJs8dGxsy0MLvxe2aMJHBnlm1VwCgRwN6XKB6
 pbh/i++1ImmdAZFdzEv280sPupx7Bfju3dY3fTblfBXY+6s8QLelcl081FVUUOGgxC92
 19QsG87qBXOqlU7EaJ3pd9BXUZ9h6q1ktt/GmJxt6hah9CIB/CEGm2+cdHF1pnDceSVS
 JQpQ==
X-Gm-Message-State: AOAM5333Xmzc9x0lWiYdIw68Lt6NZyLVMtJX8rginYSdK+13c3ym6Y8K
 8LX0jwKyNSsvNkfG7hsuXNt1C92SrnQDcbevHjJuZkWavc4=
X-Google-Smtp-Source: ABdhPJy9ajHIgf82ORp39FGPBZ9pwN1PS7wRPh+ndmmIf4jzkGE7llYbomEN4KXMAH0UPgdwE1CDR/BhVDfF2MrtC3A=
X-Received: by 2002:aca:180f:: with SMTP id h15mr45084oih.120.1636557250363;
 Wed, 10 Nov 2021 07:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20211110062343.10041-1-mario.limonciello@amd.com>
 <20211110062343.10041-3-mario.limonciello@amd.com>
In-Reply-To: <20211110062343.10041-3-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Nov 2021 10:13:59 -0500
Message-ID: <CADnq5_MGbOh_Xbg6y4hH6qrSok_YKMj0c4Ma6ZKAE835cm2-hw@mail.gmail.com>
Subject: Re: [RFC 2/2] drm/amd/pm: Add support for reacting to platform
 profile notification
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 10, 2021 at 1:24 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Various drivers provide platform profile support to let users set a hint
> in their GUI whether they want to run in a high performance, low battery
> life or balanced configuration.
>
> Drivers that provide this typically work with the firmware on their system
> to configure hardware.  In the case of AMDGPU however, the notification
> path doesn't come through firmware and can instead be provided directly
> to the driver from a notification chain.
>
> Use the information of the newly selected profile to tweak
> `dpm_force_performance_level` to that profile IFF the user hasn't manually
> selected `manual` or any other `profile_*` options.

I don't think we want to force the performance level.  This interface
forces various fixed clock configurations for debugging and profiling.
I think what we'd want to select here is the power profile (see
amdgpu_set_pp_power_profile_mode()).  For this interface you can
select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,
VIDEO, VR, COMPUTE, etc.).  These still use dynamic power management,
but they adjust the heuristics used by the GPU to select power states
so the GPU performance ramps up/down more or less aggressively.

Alex

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h |   3 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 105 +++++++++++++++++++++++-----
>  2 files changed, 90 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..27b0be23b6ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,9 @@ struct amdgpu_device {
>
>         struct amdgpu_reset_control     *reset_cntl;
>         uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> +
> +       /* platform profile notifications */
> +       struct notifier_block           platform_profile_notifier;
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 41472ed99253..33fc52b90d4c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -32,6 +32,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/nospec.h>
> +#include <linux/platform_profile.h>
>  #include <linux/pm_runtime.h>
>  #include <asm/processor.h>
>  #include "hwmgr.h"
> @@ -200,6 +201,33 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>         return count;
>  }
>
> +static int amdgpu_get_forced_level(struct device *dev, enum amd_dpm_forced_level *level)
> +{
> +       struct drm_device *ddev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(ddev);
> +       int ret;
> +
> +       if (amdgpu_in_reset(adev))
> +               return -EPERM;
> +       if (adev->in_suspend && !adev->in_runpm)
> +               return -EPERM;
> +
> +       ret = pm_runtime_get_sync(ddev->dev);
> +       if (ret < 0) {
> +               pm_runtime_put_autosuspend(ddev->dev);
> +               return ret;
> +       }
> +
> +       if (adev->powerplay.pp_funcs->get_performance_level)
> +               *level = amdgpu_dpm_get_performance_level(adev);
> +       else
> +               *level = adev->pm.dpm.forced_level;
> +
> +       pm_runtime_mark_last_busy(ddev->dev);
> +       pm_runtime_put_autosuspend(ddev->dev);
> +
> +       return 0;
> +}
>
>  /**
>   * DOC: power_dpm_force_performance_level
> @@ -264,29 +292,13 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>                                                             struct device_attribute *attr,
>                                                             char *buf)
>  {
> -       struct drm_device *ddev = dev_get_drvdata(dev);
> -       struct amdgpu_device *adev = drm_to_adev(ddev);
>         enum amd_dpm_forced_level level = 0xff;
>         int ret;
>
> -       if (amdgpu_in_reset(adev))
> -               return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> -               return -EPERM;
> +       ret = amdgpu_get_forced_level(dev, &level);
>
> -       ret = pm_runtime_get_sync(ddev->dev);
> -       if (ret < 0) {
> -               pm_runtime_put_autosuspend(ddev->dev);
> +       if (ret < 0)
>                 return ret;
> -       }
> -
> -       if (adev->powerplay.pp_funcs->get_performance_level)
> -               level = amdgpu_dpm_get_performance_level(adev);
> -       else
> -               level = adev->pm.dpm.forced_level;
> -
> -       pm_runtime_mark_last_busy(ddev->dev);
> -       pm_runtime_put_autosuspend(ddev->dev);
>
>         return sysfs_emit(buf, "%s\n",
>                           (level == AMD_DPM_FORCED_LEVEL_AUTO) ? "auto" :
> @@ -405,6 +417,59 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>         return count;
>  }
>
> +static void amdgpu_update_profile(struct device *dev, enum platform_profile_option *profile)
> +{
> +       enum amd_dpm_forced_level level;
> +       const char *str;
> +       int ret;
> +
> +       ret = amdgpu_get_forced_level(dev, &level);
> +       if (ret < 0)
> +               return;
> +
> +       /* only update profile if we're in fixed modes right now that need updating */
> +       switch (level) {
> +       case AMD_DPM_FORCED_LEVEL_LOW:
> +               if (*profile < PLATFORM_PROFILE_BALANCED)
> +                       return;
> +               break;
> +       case AMD_DPM_FORCED_LEVEL_HIGH:
> +               if (*profile > PLATFORM_PROFILE_BALANCED)
> +                       return;
> +               break;
> +       case AMD_DPM_FORCED_LEVEL_AUTO:
> +               if (*profile == PLATFORM_PROFILE_BALANCED)
> +                       return;
> +               break;
> +       default:
> +               dev_dbg(dev, "refusing to update amdgpu profile from %d\n", level);
> +               return;
> +       }
> +       if (*profile > PLATFORM_PROFILE_BALANCED)
> +               str = "high";
> +       else if (*profile < PLATFORM_PROFILE_BALANCED)
> +               str = "low";
> +       else
> +               str = "auto";
> +
> +       dev_dbg(dev, "updating platform profile to %s\n", str);
> +       amdgpu_set_power_dpm_force_performance_level(dev, NULL, str, 0);
> +}
> +
> +static int amdgpu_platform_profile_notifier_call(struct notifier_block *nb,
> +                                                 unsigned long action, void *data)
> +{
> +       if (action == PLATFORM_PROFILE_CHANGED) {
> +               enum platform_profile_option *profile = data;
> +               struct amdgpu_device *adev;
> +
> +               adev = container_of(nb, struct amdgpu_device, platform_profile_notifier);
> +               amdgpu_update_profile(adev->dev, profile);
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
>  static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>                 struct device_attribute *attr,
>                 char *buf)
> @@ -3506,6 +3571,9 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>         if (ret)
>                 return ret;
>
> +       adev->platform_profile_notifier.notifier_call = amdgpu_platform_profile_notifier_call;
> +       platform_profile_register_notifier(&adev->platform_profile_notifier);
> +
>         adev->pm.sysfs_initialized = true;
>
>         return 0;
> @@ -3519,6 +3587,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>         if (adev->pm.int_hwmon_dev)
>                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
>
> +       platform_profile_unregister_notifier(&adev->platform_profile_notifier);
>         amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>  }
>
> --
> 2.25.1
>
