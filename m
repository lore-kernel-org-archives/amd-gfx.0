Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78583C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 17:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4132361002
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 17:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4132361002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5DE96E3B2;
	Wed, 10 Nov 2021 17:51:35 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF376E3B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 17:51:34 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 l7-20020a0568302b0700b0055ae988dcc8so5031430otv.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 09:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fjokStNa+ZhpAK/ASHq5/uDmRveZFtDGIdozeRKnXfo=;
 b=aU2N4Wim2wwh23XdqdUe9cgWIGO/MfeNal31JXa6q0tOIYlHwclfHsUV42ft6ttVl6
 X+4qVFz89MoRe9E9dwuIJWhh9VXvVFRVbFgZC96j24Dv2Vxo1YYm8BRPAyR3s4JQe81f
 ogzzIHY2vAjn0zpzCRuCm0yVhStl1AOAA0HBDmQv+27sE06Osv8WgHtJKktDk0PCoLCn
 17HEYOicu7ZKoLvvLPnhiMdV+S83L7JwwZssQTmuqt7Bxsl2o9o7LI10is9m/nQELCGn
 jmgmLx3Ub2vZNBu/32YfXgLP+q9JfOHnNN2GnvLVy1PEUA4MBHfyzYKgf7jTm13tZEU/
 8L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fjokStNa+ZhpAK/ASHq5/uDmRveZFtDGIdozeRKnXfo=;
 b=KFfzxRDIVx8kYcBBsa77ouuckUiBFlfWJWpBfHQQEtZm0vBCrXmwYZji8XPJjiwUHN
 6AaAglJG2jZHgjfa7Yja5Q27mGoj80Tmf+/eKIODW2rD+3j1LBJ2RACKpy8ilORkKRvQ
 OfYeX4LBoug1slDCCp5oDkVPsHCvVxrI2XZlR80aTK6yrvJGkdqdcIEXcpgCZ626ue28
 46XPyQgwcDaHbeRQXlglXMRuSEZwCzBoKAOQXfyh8bcpbkjW9ghAwx7TcIkHGwNmqFpO
 p+57LTELtSJJhSuAp/EdNd6NrL9P8UcYMqpzZNyHtW70oxm2OYk8CwOKWh92sxe0zCR2
 msQA==
X-Gm-Message-State: AOAM530u721wmacPkjewA1L/iLr7nPDSYE04mGf3pmpV8wJh/fTBaCDz
 6Pp9P9Z0hMnrNa6jGbFrD68494PVG2gtyNeTbmuzNRV2
X-Google-Smtp-Source: ABdhPJzjG8ZJBfDkxlwmSaL/IvOEzkHfVjMG6jCrMsh8KZiAGVM7sfTVOZwugI43netnNQfI4u6z/Opxkf3sg1rqvBo=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr821652otn.299.1636566693316;
 Wed, 10 Nov 2021 09:51:33 -0800 (PST)
MIME-Version: 1.0
References: <20211110062343.10041-1-mario.limonciello@amd.com>
 <20211110062343.10041-3-mario.limonciello@amd.com>
 <CADnq5_MGbOh_Xbg6y4hH6qrSok_YKMj0c4Ma6ZKAE835cm2-hw@mail.gmail.com>
 <DM6PR12MB39300185FB03556E914290C297939@DM6PR12MB3930.namprd12.prod.outlook.com>
 <SA0PR12MB4510F4D9040A7EDA54FC73A8E2939@SA0PR12MB4510.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB4510F4D9040A7EDA54FC73A8E2939@SA0PR12MB4510.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Nov 2021 12:51:22 -0500
Message-ID: <CADnq5_ORL6n=h+8iHKhZcMV4c231HxGy7qvh=9xF3aM-HmNnhw@mail.gmail.com>
Subject: Re: [RFC 2/2] drm/amd/pm: Add support for reacting to platform
 profile notification
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 10, 2021 at 12:31 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > I don't think we want to force the performance level.  This interface
> forces various fixed clock configurations for debugging and profiling.
>
> Ah got it.
>
>
>
> >I think what we'd want to select here is the power profile (see
> amdgpu_set_pp_power_profile_mode()).  For this interface you can
> select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,
> VIDEO, VR, COMPUTE, etc.).  These still use dynamic power management,
> but they adjust the heuristics used by the GPU to select power states
> so the GPU performance ramps up/down more or less aggressively.
>
>
>
> Which profile mapping you think make sense?
>
> My guess would be:
>
> =E2=80=9CBOOTUP_DEFAULT=E2=80=9D for balanced
>
> =E2=80=9CPOWER_SAVING=E2=80=9D for low-power
>
> =E2=80=9C3D_FULL_SCREEN=E2=80=9D for performance

Yeah, that is what I was thinking.

>
>
>
> Since recently we removed that interface for YC, and some earlier APUs do=
n=E2=80=99t do as much with it.
>
> So I wonder if this is only really valuable to do this callback for !APU.
>

Yes, I think so.  I think for APUs this will be handled under the
covers in the platform firmware going forward.

>
>
> > I feel it's better to leave to platform vendors. For ex: for APU cases =
they may have implementations in which their BIOSes talk to PMFW and this m=
ight be driving something else here.
>
>
>
> Even if changing the heuristic for workload as Alex suggested?
>
>
>
> > Also, not sure how to handle a case like, say a laptop with Intel CPU a=
nd AMD dgpu.
>
>
>
> I was actually thinking this approach where there are platform profile ca=
llbacks is best because of that specifically.
>
> It would allow an Intel CPU system to have a platform profile driver impl=
emented by the OEM, but then still notify amdgpu dGPU to tune for power sav=
ing or performance workload.
>

Right, a user could still adjust these via the existing sysfs
interface today, this just makes it a little more automatic.  I guess
it depends whether we want to couple them or not.

Alex


>
>
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, November 10, 2021 10:05
> To: Alex Deucher <alexdeucher@gmail.com>; Limonciello, Mario <Mario.Limon=
ciello@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [RFC 2/2] drm/amd/pm: Add support for reacting to platform p=
rofile notification
>
>
>
> [Public]
>
>
>
> I feel it's better to leave to platform vendors. For ex: for APU cases th=
ey may have implementations in which their BIOSes talk to PMFW and this mig=
ht be driving something else here.
>
>
>
> Also, not sure how to handle a case like, say a laptop with Intel CPU and=
 AMD dgpu.
>
>
>
> Thanks,
> Lijo
>
>
>
> ________________________________
>
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex D=
eucher <alexdeucher@gmail.com>
> Sent: Wednesday, 10 November 2021, 8:44 pm
> To: Limonciello, Mario
> Cc: amd-gfx list
> Subject: Re: [RFC 2/2] drm/amd/pm: Add support for reacting to platform p=
rofile notification
>
>
>
> On Wed, Nov 10, 2021 at 1:24 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > Various drivers provide platform profile support to let users set a hin=
t
> > in their GUI whether they want to run in a high performance, low batter=
y
> > life or balanced configuration.
> >
> > Drivers that provide this typically work with the firmware on their sys=
tem
> > to configure hardware.  In the case of AMDGPU however, the notification
> > path doesn't come through firmware and can instead be provided directly
> > to the driver from a notification chain.
> >
> > Use the information of the newly selected profile to tweak
> > `dpm_force_performance_level` to that profile IFF the user hasn't manua=
lly
> > selected `manual` or any other `profile_*` options.
>
> I don't think we want to force the performance level.  This interface
> forces various fixed clock configurations for debugging and profiling.
> I think what we'd want to select here is the power profile (see
> amdgpu_set_pp_power_profile_mode()).  For this interface you can
> select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,
> VIDEO, VR, COMPUTE, etc.).  These still use dynamic power management,
> but they adjust the heuristics used by the GPU to select power states
> so the GPU performance ramps up/down more or less aggressively.
>
> Alex
>
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h |   3 +
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 105 +++++++++++++++++++++++-----
> >  2 files changed, 90 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index b85b67a88a3d..27b0be23b6ac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1097,6 +1097,9 @@ struct amdgpu_device {
> >
> >         struct amdgpu_reset_control     *reset_cntl;
> >         uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX=
_INSTANCE];
> > +
> > +       /* platform profile notifications */
> > +       struct notifier_block           platform_profile_notifier;
> >  };
> >
> >  static inline struct amdgpu_device *drm_to_adev(struct drm_device *dde=
v)
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/p=
m/amdgpu_pm.c
> > index 41472ed99253..33fc52b90d4c 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/hwmon.h>
> >  #include <linux/hwmon-sysfs.h>
> >  #include <linux/nospec.h>
> > +#include <linux/platform_profile.h>
> >  #include <linux/pm_runtime.h>
> >  #include <asm/processor.h>
> >  #include "hwmgr.h"
> > @@ -200,6 +201,33 @@ static ssize_t amdgpu_set_power_dpm_state(struct d=
evice *dev,
> >         return count;
> >  }
> >
> > +static int amdgpu_get_forced_level(struct device *dev, enum amd_dpm_fo=
rced_level *level)
> > +{
> > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> > +       int ret;
> > +
> > +       if (amdgpu_in_reset(adev))
> > +               return -EPERM;
> > +       if (adev->in_suspend && !adev->in_runpm)
> > +               return -EPERM;
> > +
> > +       ret =3D pm_runtime_get_sync(ddev->dev);
> > +       if (ret < 0) {
> > +               pm_runtime_put_autosuspend(ddev->dev);
> > +               return ret;
> > +       }
> > +
> > +       if (adev->powerplay.pp_funcs->get_performance_level)
> > +               *level =3D amdgpu_dpm_get_performance_level(adev);
> > +       else
> > +               *level =3D adev->pm.dpm.forced_level;
> > +
> > +       pm_runtime_mark_last_busy(ddev->dev);
> > +       pm_runtime_put_autosuspend(ddev->dev);
> > +
> > +       return 0;
> > +}
> >
> >  /**
> >   * DOC: power_dpm_force_performance_level
> > @@ -264,29 +292,13 @@ static ssize_t amdgpu_get_power_dpm_force_perform=
ance_level(struct device *dev,
> >                                                             struct devi=
ce_attribute *attr,
> >                                                             char *buf)
> >  {
> > -       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > -       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> >         enum amd_dpm_forced_level level =3D 0xff;
> >         int ret;
> >
> > -       if (amdgpu_in_reset(adev))
> > -               return -EPERM;
> > -       if (adev->in_suspend && !adev->in_runpm)
> > -               return -EPERM;
> > +       ret =3D amdgpu_get_forced_level(dev, &level);
> >
> > -       ret =3D pm_runtime_get_sync(ddev->dev);
> > -       if (ret < 0) {
> > -               pm_runtime_put_autosuspend(ddev->dev);
> > +       if (ret < 0)
> >                 return ret;
> > -       }
> > -
> > -       if (adev->powerplay.pp_funcs->get_performance_level)
> > -               level =3D amdgpu_dpm_get_performance_level(adev);
> > -       else
> > -               level =3D adev->pm.dpm.forced_level;
> > -
> > -       pm_runtime_mark_last_busy(ddev->dev);
> > -       pm_runtime_put_autosuspend(ddev->dev);
> >
> >         return sysfs_emit(buf, "%s\n",
> >                           (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? "a=
uto" :
> > @@ -405,6 +417,59 @@ static ssize_t amdgpu_set_power_dpm_force_performa=
nce_level(struct device *dev,
> >         return count;
> >  }
> >
> > +static void amdgpu_update_profile(struct device *dev, enum platform_pr=
ofile_option *profile)
> > +{
> > +       enum amd_dpm_forced_level level;
> > +       const char *str;
> > +       int ret;
> > +
> > +       ret =3D amdgpu_get_forced_level(dev, &level);
> > +       if (ret < 0)
> > +               return;
> > +
> > +       /* only update profile if we're in fixed modes right now that n=
eed updating */
> > +       switch (level) {
> > +       case AMD_DPM_FORCED_LEVEL_LOW:
> > +               if (*profile < PLATFORM_PROFILE_BALANCED)
> > +                       return;
> > +               break;
> > +       case AMD_DPM_FORCED_LEVEL_HIGH:
> > +               if (*profile > PLATFORM_PROFILE_BALANCED)
> > +                       return;
> > +               break;
> > +       case AMD_DPM_FORCED_LEVEL_AUTO:
> > +               if (*profile =3D=3D PLATFORM_PROFILE_BALANCED)
> > +                       return;
> > +               break;
> > +       default:
> > +               dev_dbg(dev, "refusing to update amdgpu profile from %d=
\n", level);
> > +               return;
> > +       }
> > +       if (*profile > PLATFORM_PROFILE_BALANCED)
> > +               str =3D "high";
> > +       else if (*profile < PLATFORM_PROFILE_BALANCED)
> > +               str =3D "low";
> > +       else
> > +               str =3D "auto";
> > +
> > +       dev_dbg(dev, "updating platform profile to %s\n", str);
> > +       amdgpu_set_power_dpm_force_performance_level(dev, NULL, str, 0)=
;
> > +}
> > +
> > +static int amdgpu_platform_profile_notifier_call(struct notifier_block=
 *nb,
> > +                                                 unsigned long action,=
 void *data)
> > +{
> > +       if (action =3D=3D PLATFORM_PROFILE_CHANGED) {
> > +               enum platform_profile_option *profile =3D data;
> > +               struct amdgpu_device *adev;
> > +
> > +               adev =3D container_of(nb, struct amdgpu_device, platfor=
m_profile_notifier);
> > +               amdgpu_update_profile(adev->dev, profile);
> > +       }
> > +
> > +       return NOTIFY_OK;
> > +}
> > +
> >  static ssize_t amdgpu_get_pp_num_states(struct device *dev,
> >                 struct device_attribute *attr,
> >                 char *buf)
> > @@ -3506,6 +3571,9 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *ad=
ev)
> >         if (ret)
> >                 return ret;
> >
> > +       adev->platform_profile_notifier.notifier_call =3D amdgpu_platfo=
rm_profile_notifier_call;
> > +       platform_profile_register_notifier(&adev->platform_profile_noti=
fier);
> > +
> >         adev->pm.sysfs_initialized =3D true;
> >
> >         return 0;
> > @@ -3519,6 +3587,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *a=
dev)
> >         if (adev->pm.int_hwmon_dev)
> >                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
> >
> > +       platform_profile_unregister_notifier(&adev->platform_profile_no=
tifier);
> >         amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
> >  }
> >
> > --
> > 2.25.1
> >
>
>
