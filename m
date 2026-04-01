Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708DC1076389
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 17:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB8910EDCD;
	Wed,  1 Apr 2026 17:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kUKahqDa";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E1610EDCD
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 17:26:39 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-124a7216c9cso4840c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 10:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775064398; cv=none;
 d=google.com; s=arc-20240605;
 b=E5m0H6Zwbgr3udyjbsST4O64wzBCZIfFJgwavsxymgCpphQpTy11IIEjhJrkelU5A0
 477OdwIBuHLDHIOdfU0pkNVWcPz3iGUp/zR/a4l0uYRBoTfc7aU2x+Y7ewpASbSwmD7T
 vcyKtBzmGEXsWtuoCRrdPcAXfdbaOExhngSipnEaTyE10lXHts6XU3KiDIS8+ABTjUWr
 ju1LryYYdF4Rr9+zT2UcXY6C6hUJSoH2q1Y0T8VXyJt5I7ZZzOWsTBB/8K1VReemhX1L
 OM2rPA4lVupPfwfHfpGazI49qsR7kU0SsClCQ9U2g0rfUI62+gmalwUTY4LizgCiPdDG
 mTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mKiVoIEsRrzbt0in9YOYLz29z184YceU00yHVJgwhtg=;
 fh=oTojQkW1miF/NJeYaA/yxnBVyxkt9aKiOEfAQyM8dPk=;
 b=YFux8xLDph+cMlBln+YZAqcCtV1+EhlHWLt6oZek0O1pLBKnSMZ21pQ0KZvkYOnK7u
 YW3GoaoSXisLLMagw8j49Cnl2HQozqZ2hW2pF75E2vQ0WU10MU2b7ZCYblJRJxVrtEKh
 eBCi0HvM9BOnrTSoOea5ISUHfHil9olG9AKXuaXm/C8n3Is7DYAFLVxokAkAMv5RANfI
 8CoRgRjzjhoHX2BRKhA/JVTsP+wSnNEKZFlDkCrkzbgv2KbR5eNMel2MeWDMs1Xr+snr
 U00OFhCW4vI5LdLypEIK3cakMkqtnMJ26bWJV90Sl6YZcgm5RhGkE3dhPEVgjY6/3Xcq
 HrHQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775064398; x=1775669198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKiVoIEsRrzbt0in9YOYLz29z184YceU00yHVJgwhtg=;
 b=kUKahqDaL19Z8r+YlyCVU9BnBZ5ozFgDErH6FbO9aR0PtoCkr6HmlCfhbFZtfYJcPI
 /FJBKBytRGYyB4mwv4qMNCr6ZPQfEqqxJHeALHQGHEww8iATdcXKtjIzrl81Sn+2Ett/
 1/jk023oddyXVT4z2IKRdDjALfKgHIVN9niMtMGfi+Am0Qd8Z822Xp0SEwOrn5K5Vza4
 3rctIQMdr5mAQCRz4WIR6/JGs0QNBm13R8sgd/WDJFquaqOzsaC0bQHawe1h8X1YCAGP
 fHjCQ3H/K5uxO8crLDLeCrt7T95OiXweqWcOYI4DE/dcDR9qcyQS8RjWlwqex87xJ4i7
 fAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775064398; x=1775669198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mKiVoIEsRrzbt0in9YOYLz29z184YceU00yHVJgwhtg=;
 b=Ub6pQDXXRSnIUE18AaSmqglR22b2QoPcj980yP05IMTKw9CEw37ytJFwtZtNjWkzu/
 zdjHDgS5utLNvcRFalb4u1IlzFiVTWI7BP4+oa2ZfPnF4CQRAa0DCOu6EqHDw4ihX6Gc
 mNDUc9rjKdOBEgvigNgzvwCqTi2/psRt4cc8HMVKdT15e7WwTa59YRlFyMuJvguf3gG6
 gnb21PvqQEDLhmrbouA6qGXkOxCVF7/zKM8s9WUKVUI85VquxyR46He+jX4t6twrQVVe
 lrekYeSUPlW27o0LMn1VAa5tphx2t8zP20YtEdy/e1klafJIc8Aq8dIDHWTZMP3FpnPY
 /j3A==
X-Gm-Message-State: AOJu0YxCCS1wFJaBDQaZZxbweEl6AvVeR9v63Dpd0Qu1Xjp5GbDWcjLO
 nTkVbXoYlFPwKjZzOt2++OoFStL1L7tHZmCUagVzgIba6MB4LSe9g5IsOCWslp+qkg4m7adFYS+
 0odZz3LyCylDWPWGGJt/o6CkSVr74Gv0=
X-Gm-Gg: ATEYQzzRbyqnuLD3ajAESsc7X2nEHbFyG5y95fd+Py/zhGw3mLaBe1rBioFua2Tcap1
 28Gc9e9d1LxzcR2+q5+41n/33PUEVHfJ/mfnOrqYIAS+snbPVJTy6BhNHxR1L/5674NfV4CAz+H
 lLn5F5x/Fqoba+N74FzY3o5FGjXwfRX1yUi0z4eobpHFcZsCKF6niDgFMeQy785WPhmV55vh3xH
 I7Q52u6LyjrLRjdUIV57u3RE/u7w2Ryaecnx8MedZGPuFFPPixjiSl5PrZGuVsYuUo62Iwc5Qrq
 bz8MuaJMsXi6ufqceRH42/bZjxtq4rG9hunnPbx95ueM9todbbJhCqSF6uM44maPDlPrOQ==
X-Received: by 2002:a05:7022:698d:b0:12a:7181:2f12 with SMTP id
 a92af1059eb24-12be6551a54mr1024628c88.3.1775064398278; Wed, 01 Apr 2026
 10:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260401135322.541198-1-tom.stdenis@amd.com>
In-Reply-To: <20260401135322.541198-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Apr 2026 13:26:26 -0400
X-Gm-Features: AQROBzD8GYJ87Cn29KHpFO7AfqBCj6zXDdIqC2aZJTP_X8-E4LAVuLJrxzzsyG4
Message-ID: <CADnq5_NH4Q=Hn+-grvn503ydFXUi5qaVknkNjWD+wU_Csjhokw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Change gpu_metrics over to binary
To: Tom St Denis <tom.stdenis@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
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

+ a few more people

On Wed, Apr 1, 2026 at 9:53=E2=80=AFAM Tom St Denis <tom.stdenis@amd.com> w=
rote:
>
> The file is binary anyways but also because it reported previously
> as a static 4KB block it made correctly reading it hard since
> you can't error check on if your read succeeded or not.
>
> Tested on my Navi48.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 106 +++++++++++++++++++-----
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |   1 +
>  drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h  |   1 -
>  3 files changed, 88 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index a4d8e667eafb..7139983705bc 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -34,8 +34,17 @@
>  #include <linux/nospec.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/string_choices.h>
> +#include <linux/sysfs.h>
> +#include <linux/sizes.h>
>  #include <asm/processor.h>
>
> +/*
> + * Sysfs reports this as the file size (stat/ls); kernfs also uses it to=
 cap
> + * read offsets. Actual payload length is the return value of
> + * amdgpu_dpm_get_gpu_metrics() and must not exceed this.
> + */
> +#define AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ     SZ_128K
> +
>  #define MAX_NUM_OF_FEATURES_PER_SUBSET         8
>  #define MAX_NUM_OF_SUBSETS                     8
>
> @@ -1734,43 +1743,86 @@ static ssize_t amdgpu_get_pm_metrics(struct devic=
e *dev,
>   * DOC: gpu_metrics
>   *
>   * The amdgpu driver provides a sysfs API for retrieving current gpu
> - * metrics data. The file gpu_metrics is used for this. Reading the
> - * file will dump all the current gpu metrics data.
> + * metrics data. The binary sysfs file gpu_metrics is used for this.
> + * Reading the file returns the raw metrics blob; reads may be shorter
> + * than the full structure, so userspace should use read() until EOF
> + * when the buffer may exceed one page. The sysfs file size is an upper
> + * bound for inode metadata; the real length is the amount returned
> + * before EOF on sequential reads.
> + *
> + * Do not use stdio fread(3) as fread(buf, 128*1024, 1, fp): that asks f=
or
> + * one object of 128KiB and returns 0 if the payload is shorter (even wh=
en
> + * data was read). Use read(2), or fread(buf, 1, sizeof(buf), fp), or lo=
op
> + * until feof/short read.
>   *
>   * These data include temperature, frequency, engines utilization,
>   * power consume, throttler status, fan speed and cpu core statistics(
>   * available for APU only). That's it will give a snapshot of all sensor=
s
>   * at the same time.
>   */
> -static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
> -                                     struct device_attribute *attr,
> -                                     char *buf)
> +static bool amdgpu_pm_gpu_metrics_bin_visible(struct amdgpu_device *adev=
,
> +                                             uint32_t mask)
> +{
> +       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +       if (!((ATTR_FLAG_BASIC | ATTR_FLAG_ONEVF) & mask))
> +               return false;
> +
> +       return gc_ver >=3D IP_VERSION(9, 1, 0);
> +}
> +
> +static ssize_t amdgpu_sysfs_gpu_metrics_read(struct file *f, struct kobj=
ect *kobj,
> +                                            const struct bin_attribute *=
attr,
> +                                            char *buf, loff_t off, size_=
t count)
>  {
> +       struct device *dev =3D kobj_to_dev(kobj);
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         void *gpu_metrics;
> -       ssize_t size =3D 0;
> +       int len;
>         int ret;
>
> -       ret =3D amdgpu_pm_get_access_if_active(adev);
> +       (void)f;
> +       (void)attr;
> +
> +       /*
> +        * Kernfs invokes this once per chunk (at most PAGE_SIZE bytes pe=
r call)
> +        * for a single userspace read(). Use pm_runtime_resume_and_get v=
ia
> +        * amdgpu_pm_get_access so later chunks still succeed after the p=
rior
> +        * chunk's put_autosuspend =E2=80=94 get_if_active would return -=
EPERM once the
> +        * GPU had gone idle between chunks.
> +        */
> +       ret =3D amdgpu_pm_get_access(adev);
>         if (ret)
>                 return ret;
>
> -       size =3D amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
> -       if (size <=3D 0)
> -               goto out;
> +       len =3D amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
> +       if (len < 0) {
> +               amdgpu_pm_put_access(adev);
> +               return len;
> +       }
> +       if (len =3D=3D 0) {
> +               amdgpu_pm_put_access(adev);
> +               return 0;
> +       }
>
> -       if (size >=3D PAGE_SIZE)
> -               size =3D PAGE_SIZE - 1;
> +       if (off >=3D len) {
> +               amdgpu_pm_put_access(adev);
> +               return 0;
> +       }
>
> -       memcpy(buf, gpu_metrics, size);
> +       if (count > (size_t)(len - off))
> +               count =3D len - off;
>
> -out:
> +       memcpy(buf, (u8 *)gpu_metrics + off, count);
>         amdgpu_pm_put_access(adev);
>
> -       return size;
> +       return count;
>  }
>
> +static const BIN_ATTR(gpu_metrics, 0444, amdgpu_sysfs_gpu_metrics_read, =
NULL,
> +                     AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ);
> +
>  static int amdgpu_show_powershift_percent(struct device *dev,
>                                         char *buf, enum amd_pp_sensors se=
nsor)
>  {
> @@ -2579,7 +2631,6 @@ static struct amdgpu_device_attr amdgpu_device_attr=
s[] =3D {
>         AMDGPU_DEVICE_ATTR_RO(unique_id,                                A=
TTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>         AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,               A=
TTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>         AMDGPU_DEVICE_ATTR_RW(apu_thermal_cap,                          A=
TTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -       AMDGPU_DEVICE_ATTR_RO(gpu_metrics,                              A=
TTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>         AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,                     A=
TTR_FLAG_BASIC,
>                               .attr_update =3D ss_power_attr_update),
>         AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,                    A=
TTR_FLAG_BASIC,
> @@ -2657,9 +2708,6 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_
>                      gc_ver !=3D IP_VERSION(9, 4, 3)) ||
>                     gc_ver < IP_VERSION(9, 0, 0))
>                         *states =3D ATTR_STATE_UNSUPPORTED;
> -       } else if (DEVICE_ATTR_IS(gpu_metrics)) {
> -               if (gc_ver < IP_VERSION(9, 1, 0))
> -                       *states =3D ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>                 if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D =
-EOPNOTSUPP)
>                         *states =3D ATTR_STATE_UNSUPPORTED;
> @@ -4755,6 +4803,17 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *ade=
v)
>         if (ret)
>                 goto err_out0;
>
> +       if (amdgpu_pm_gpu_metrics_bin_visible(adev, mask)) {
> +               ret =3D sysfs_create_bin_file(&adev->dev->kobj, &bin_attr=
_gpu_metrics);
> +               if (ret) {
> +                       dev_err(adev->dev,
> +                               "failed to create gpu_metrics sysfs bin f=
ile, ret =3D %d\n",
> +                               ret);
> +                       goto err_out1;
> +               }
> +               adev->pm.gpu_metrics_bin_registered =3D true;
> +       }
> +
>         if (amdgpu_dpm_is_overdrive_supported(adev)) {
>                 ret =3D amdgpu_od_set_init(adev);
>                 if (ret)
> @@ -4806,6 +4865,10 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *ade=
v)
>         return 0;
>
>  err_out1:
> +       if (adev->pm.gpu_metrics_bin_registered) {
> +               sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_gpu_met=
rics);
> +               adev->pm.gpu_metrics_bin_registered =3D false;
> +       }
>         amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>  err_out0:
>         if (adev->pm.int_hwmon_dev)
> @@ -4821,6 +4884,11 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *ad=
ev)
>         if (adev->pm.int_hwmon_dev)
>                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
>
> +       if (adev->pm.gpu_metrics_bin_registered) {
> +               sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_gpu_met=
rics);
> +               adev->pm.gpu_metrics_bin_registered =3D false;
> +       }
> +
>         amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h
> index aa3f427819a0..67ff83b2134c 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -349,6 +349,7 @@ struct amdgpu_pm {
>         /* dpm */
>         bool                    dpm_enabled;
>         bool                    sysfs_initialized;
> +       bool                    gpu_metrics_bin_registered;
>         struct amdgpu_dpm       dpm;
>         const struct firmware   *fw;    /* SMC firmware */
>         uint32_t                fw_version;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd=
/pm/inc/amdgpu_pm.h
> index c12ced32f780..dc6875871f1d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> @@ -73,7 +73,6 @@ enum amdgpu_device_attr_id {
>         device_attr_id__unique_id,
>         device_attr_id__thermal_throttling_logging,
>         device_attr_id__apu_thermal_cap,
> -       device_attr_id__gpu_metrics,
>         device_attr_id__smartshift_apu_power,
>         device_attr_id__smartshift_dgpu_power,
>         device_attr_id__smartshift_bias,
> --
> 2.51.0
>
