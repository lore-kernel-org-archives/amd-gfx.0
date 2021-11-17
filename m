Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD410C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 19:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E71F61B04
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 19:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E71F61B04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC056E24E;
	Wed, 17 Nov 2021 19:14:51 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87DC6E24E
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 19:14:50 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 h12-20020a056830034c00b0055c8458126fso6591585ote.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/9ErCYFzETHecT+6ZQ24+ArnNnY3Fk8SDFuRdOMbJD8=;
 b=dWuSSdliz2cmZ85tpWnEp6uzVypRyRRHNgBdawpyT9yKGITRBVDcqFFBXa1yovy9M3
 yirIFEXRBvbXKcMasOS1N/U0QT3CcSS0ljqr+jjZ54/e82EpOwoZcdyl01GQRWVtpvta
 JOpIdmKC7x+5oS/FTUa1SHuV0GhllPRJZ1bKKdzP5SrQ0yYxvFm1Z3uZbzzJ4Gg3rLjM
 iZ1pzTU3HcjUlbY6ytTF0WcEaVy3yd2GmoZVVzIVn+F6Qc1EvAGewt39oN7o8ZXGns+l
 V5dZiHhQ4L3P/g4q+CZxKPWhup8jFBRSDWTZePG+peogshF93BrFh/CzrwQECp4oQtx3
 wxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/9ErCYFzETHecT+6ZQ24+ArnNnY3Fk8SDFuRdOMbJD8=;
 b=Bitnt/mMgaeo4SoTmZRzWZNLwba6LEX/0579OE81yrDAYaVIQWKtnKQkgqFiuz3qCp
 vBjqNG1aApqJpFSB0cD6LQJDEWqxP5pAzThYgMEgG+fliTA/aojO60JUUJm4UKicQ0u3
 jp+0mJcgtERcEYYwYjHyYFmnMOoLQwEmf0yxt9OxvzhTNzxDjCN5B9HkWY3sW6WsFD5t
 xRltp2f0h65rStivi+dxcRTv/RdnH4vHeKaBUVXebgQAthZrDeZtn44O6Gfhk3N96/u8
 /X/wgABnUydM0lPJopngFI/1LKR6fxQnbMjmT0O9SFTIn1t29/9vnNeZ6RU+WzmZqTtv
 kmgg==
X-Gm-Message-State: AOAM533iRK8CeLf5czgltD5dkZAq8hBiit7UKa+YpmA8Kh7YcF1aNloH
 9S7Af9tkAXOGL8NX9MhBlValRWu2k/8PBCLVTbk+QQQ3
X-Google-Smtp-Source: ABdhPJxhFN9wT4GMR5iLIOHO5jjEuFreU1x9w2MNb/EgHhd2vLyct5d1Te/AH1t+PC4+OzfKh9DEc8s+C1Ip4AkjIT4=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr16277537otn.299.1637176489939; 
 Wed, 17 Nov 2021 11:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20211117062044.4752-1-darren.powell@amd.com>
 <856e4446-1735-aed8-c85b-d34aef1076ab@amd.com>
In-Reply-To: <856e4446-1735-aed8-c85b-d34aef1076ab@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Nov 2021 14:14:38 -0500
Message-ID: <CADnq5_PtDLiWcbni_GqJ+FbSeFTH3=_eU_B3k4wOg3RwSrDuCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] amdgpu/pm: restructure reporting of clock values by
 smu
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Darren Powell <darren.powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 17, 2021 at 2:12 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 11/17/2021 11:50 AM, Darren Powell wrote:
> >   Use of sysfs_emit by each of the specific device implementations is problematic.
> >   To remove this back to a higher level, this patch adds a new function "get_clock_levels"
> >   to the power-management API (amd_pm_funcs) and smu powerplay API (pptable_funcs). The
> >   function returns an array of values to the power management module, which can then
> >   interpret the array and print the values at the top layer.
> >   This patch is only implemented for navi10 for some clocks to seek comment on the
> >   implementation before extending the implementation to other clock values and devices.
> >
> >   == Changes ==
> >    - new power management function get_clock_levels implemented by smu_get_ppclk_levels()
> >    - new power management function amdgpu_dpm_print_clock_array to print most common clock
> >         list, which can be later extended to use different units (currently only MHz), or
> >         other functions added to handle more complex structure (eg pcie clocks)
> >    - new powerplay function get_clk_levels implemented by navi10_get_clk_levels()
> >    - new helper function smu_convert_to_smuclk called by smu_print_ppclk_levels and
> >         smu_get_ppclk_levels
> >    - new error return value -EOPNOTSUPP for clock levels not recognized, allowing fallback
> >         to print_clock_levels. (NOTE: If pm or dpm not enabled current implementation will
> >         try and fail with both methods)
> >    - new error return value -EINVAL for unsupported clock level
> >    - new error messages output for error conditions encountered at the device specific layer
> >         which can be removed if suggested
> >
> >   == Test ==
> >   LOGFILE=sysfs_emit.test.log
> >   cd ~/workspace/linux
> >   cp ${LOGFILE}{,.old}
> >
> >   AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
> >   AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
> >   HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
> >
> >   lspci -nn | grep "VGA\|Display"  > $LOGFILE
> >   FILES="pp_dpm_sclk
> >   pp_dpm_pcie
> >   "
> >
>
> There hasn't been any problem with sysfs_emit for these nodes.
>
> The problem is with this kind of usage -
>
>                  size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
>                  size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK,
> buf+size);
>                  size += amdgpu_dpm_print_clock_levels(adev,
> OD_VDDC_CURVE, buf+size);
>                  size += amdgpu_dpm_print_clock_levels(adev,
> OD_VDDGFX_OFFSET, buf+size);
>                  size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE,
> buf+size);
>                  size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK,
> buf+size);
>
>
> It's mixing a set of data in a particular node. Then the node needs to
> pass buf and offset separately to use sysfs_emit_at
>
> Even then, if you notice, not every data is a clock level data. Some
> like VDDC_CURVE is ASIC specific and have a different format than clock
> DPM level data.
>
> The max number of DPM levels are ASIC specific. In the below
> implementation a max of 8 levels is assumed for all ASICs, but there are
> ASICs which support 16 levels for a particualr clock. In fact the
> implementation needs to pass max+1 as in arg for list_length.
>
> Sometimes, the current frequency may not match the exact DPM level, the
> approximation of what is the current level is ASIC specific. So instead
> of current freq, ASIC implementation needs to pass levels and the
> current level.
>
> In general, the problem with sysfs_emit_at is not related to a common
> print format. pp_od_clk_voltage node is a representation of the problem
> - a node which is an aggregator of different data formats. Also, it is
> difficult to narrow down to a single one across ASICs given that there
> could be changes from one to next.

Perhaps we should just switch the swsmu and powerplay code back to
sprintf for these functions. sysfs_emit doesn't really buy us anything
at this point.

Alex

>
> Thanks,
> Lijo
>
>
>
> >   for f in $FILES
> >   do
> >     echo === $f === >> $LOGFILE
> >     cat $HWMON_DIR/device/$f >> $LOGFILE
> >   done
> >   cat $LOGFILE
> >
> > Signed-off-by: Darren Powell <darren.powell@amd.com>
> > ---
> >   .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
> >   drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 41 +++++++-
> >   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  9 ++
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 53 +++++++++-
> >   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 96 +++++++++++++++++++
> >   5 files changed, 192 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > index bac15c466733..fbe045811e60 100644
> > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > @@ -310,6 +310,8 @@ struct amd_pm_funcs {
> >       int (*get_fan_speed_pwm)(void *handle, u32 *speed);
> >       int (*force_clock_level)(void *handle, enum pp_clock_type type, uint32_t mask);
> >       int (*print_clock_levels)(void *handle, enum pp_clock_type type, char *buf);
> > +     int (*get_clock_levels)(void *handle, enum pp_clock_type type,
> > +                             uint32_t *clock_list, uint max_list_length);
> >       int (*force_performance_level)(void *handle, enum amd_dpm_forced_level level);
> >       int (*get_sclk_od)(void *handle);
> >       int (*set_sclk_od)(void *handle, uint32_t value);
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > index 41472ed99253..ca7a6779e59b 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -1020,6 +1020,23 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
> >       return size;
> >   }
> >
> > +static int amdgpu_dpm_print_clock_array(enum pp_clock_type type,
> > +                                     char *buf,
> > +                                     uint32_t *clock_list, uint list_length) {
> > +
> > +     uint i;
> > +     int size = 0;
> > +
> > +     for (i = 1; i < list_length; i++) {
> > +             size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, clock_list[i],
> > +                             clock_list[i] == clock_list[0] ? "*" : "");
> > +     }
> > +
> > +
> > +     return size;
> > +}
> > +
> > +
> >   /**
> >    * DOC: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
> >    *
> > @@ -1058,6 +1075,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
> >       struct amdgpu_device *adev = drm_to_adev(ddev);
> >       ssize_t size;
> >       int ret;
> > +     uint32_t clock_list[8];
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > @@ -1070,10 +1088,24 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
> >               return ret;
> >       }
> >
> > -     if (adev->powerplay.pp_funcs->print_clock_levels)
> > -             size = amdgpu_dpm_print_clock_levels(adev, type, buf);
> > -     else
> > -             size = sysfs_emit(buf, "\n");
> > +     if (adev->powerplay.pp_funcs->get_clock_levels) {
> > +             ret = adev->powerplay.pp_funcs->get_clock_levels(
> > +                                     adev->powerplay.pp_handle, type, clock_list, 8);
> > +
> > +             if (ret > 0)
> > +                     size = amdgpu_dpm_print_clock_array(type, buf, clock_list, ret);
> > +     }
> > +     else {
> > +             ret = -EOPNOTSUPP;
> > +     }
> > +
> > +     if  (ret == -EOPNOTSUPP)  {
> > +             if (adev->powerplay.pp_funcs->print_clock_levels) {
> > +                     size = amdgpu_dpm_print_clock_levels(adev, type, buf);
> > +             }
> > +             else
> > +                     size = sysfs_emit(buf, "\n");
> > +     }
> >
> >       pm_runtime_mark_last_busy(ddev->dev);
> >       pm_runtime_put_autosuspend(ddev->dev);
> > @@ -1159,6 +1191,7 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
> >               struct device_attribute *attr,
> >               char *buf)
> >   {
> > +     dev_warn(dev, " %s ENTRY", __func__);
> >       return amdgpu_get_pp_dpm_clock(dev, PP_SCLK, buf);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > index 3557f4e7fc30..d8c20a134475 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > @@ -610,6 +610,15 @@ struct pptable_funcs {
> >        */
> >       int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
> >
> > +     /**
> > +      * @get_clk_levels: Get array DPM clock levels for a clock domain
> > +      *                    to array clock_list. current level is first element.
> > +      *
> > +      * Used for sysfs interfaces.
> > +      */
> > +     int (*get_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type,
> > +                           uint32_t *clock_list, uint max_list_length);
> > +
> >       /**
> >        * @force_clk_levels: Set a range of allowed DPM levels for a clock
> >        *                    domain.
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index 01168b8955bf..2de566118422 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -2395,11 +2395,8 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
> >       return ret;
> >   }
> >
> > -static int smu_print_ppclk_levels(void *handle,
> > -                               enum pp_clock_type type,
> > -                               char *buf)
> > +static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
> >   {
> > -     struct smu_context *smu = handle;
> >       enum smu_clk_type clk_type;
> >
> >       switch (type) {
> > @@ -2432,12 +2429,57 @@ static int smu_print_ppclk_levels(void *handle,
> >       case OD_CCLK:
> >               clk_type = SMU_OD_CCLK; break;
> >       default:
> > -             return -EINVAL;
> > +             clk_type = SMU_CLK_COUNT; break;
> >       }
> >
> > +     return clk_type;
> > +}
> > +
> > +static int smu_print_ppclk_levels(void *handle,
> > +                               enum pp_clock_type type,
> > +                               char *buf)
> > +{
> > +     struct smu_context *smu = handle;
> > +     enum smu_clk_type clk_type;
> > +
> > +     clk_type = smu_convert_to_smuclk(type);
> > +     if (clk_type == SMU_CLK_COUNT)
> > +             return -EINVAL;
> > +
> >       return smu_print_smuclk_levels(smu, clk_type, buf);
> >   }
> >
> > +static int smu_get_ppclk_levels(void *handle,
> > +                             enum pp_clock_type type,
> > +                             uint32_t *clock_list, uint max_list_length)
> > +{
> > +     struct smu_context *smu = handle;
> > +     enum smu_clk_type clk_type;
> > +     int ret = 0;
> > +
> > +     clk_type = smu_convert_to_smuclk(type);
> > +     if (clk_type == SMU_CLK_COUNT)
> > +             return -EINVAL;
> > +
> > +
> > +     if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> > +             return -EOPNOTSUPP;
> > +
> > +
> > +     if (smu->ppt_funcs->get_clk_levels) {
> > +
> > +             mutex_lock(&smu->mutex);
> > +             ret = smu->ppt_funcs->get_clk_levels(smu, clk_type, clock_list, max_list_length);
> > +             mutex_unlock(&smu->mutex);
> > +     }
> > +     else {
> > +             ret = -EOPNOTSUPP;
> > +     }
> > +
> > +
> > +     return ret;
> > +}
> > +
> >   static int smu_od_edit_dpm_table(void *handle,
> >                                enum PP_OD_DPM_TABLE_COMMAND type,
> >                                long *input, uint32_t size)
> > @@ -3100,6 +3142,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
> >       .set_fan_speed_pwm   = smu_set_fan_speed_pwm,
> >       .get_fan_speed_pwm   = smu_get_fan_speed_pwm,
> >       .force_clock_level       = smu_force_ppclk_levels,
> > +     .get_clock_levels        = smu_get_ppclk_levels,
> >       .print_clock_levels      = smu_print_ppclk_levels,
> >       .force_performance_level = smu_force_performance_level,
> >       .read_sensor             = smu_read_sensor,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 71161f6b78fe..55e6880c2964 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -1261,6 +1261,101 @@ static void navi10_od_setting_get_range(struct smu_11_0_overdrive_table *od_tabl
> >               *max = od_table->max[setting];
> >   }
> >
> > +static int navi10_get_clk_levels(struct smu_context *smu,
> > +                              enum smu_clk_type clk_type,
> > +                              uint32_t *clock_list, uint max_list_length)
> > +{
> > +     struct amdgpu_device *adev = smu->adev;
> > +     int size = 0, ret = 0;
> > +     uint32_t cur_value = 0, value = 0, count = 0, i;
> > +     uint32_t freq_values[3] = {0};
> > +     uint32_t mark_index = 0;
> > +
> > +     switch (clk_type) {
> > +     case SMU_GFXCLK:
> > +     case SMU_SCLK:
> > +     case SMU_SOCCLK:
> > +     case SMU_MCLK:
> > +     case SMU_UCLK:
> > +     case SMU_FCLK:
> > +     case SMU_VCLK:
> > +     case SMU_DCEFCLK:
> > +     case SMU_DCLK:
> > +             ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
> > +             if (ret) {
> > +                     dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
> > +                     return -EIO;
> > +             }
> > +
> > +             ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
> > +             if (ret) {
> > +                     dev_err(adev->dev, " %s Unable to retrieve clk count : %u", __func__, clk_type);
> > +                     return -EIO;
> > +             }
> > +
> > +             if (count > max_list_length-1) {
> > +                     dev_err(adev->dev, " %s Too many clock values", __func__);
> > +                     return -EPERM;
> > +             }
> > +
> > +
> > +             clock_list[0] = cur_value;
> > +             if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
> > +                     for (i = 0; i < count; i++) {
> > +                             ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
> > +                             if (ret) {
> > +                                     dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
> > +                                     return -EIO;
> > +                             }
> > +
> > +                             clock_list[i+1] = value;
> > +                     }
> > +                     size = count+1;
> > +             } else {
> > +                     // for fine-grained dpm, display cur_value as average of max and min
> > +                     ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
> > +                     if (ret) {
> > +                             dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
> > +                             return -EIO;
> > +                     }
> > +                     ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
> > +                     if (ret) {
> > +                             dev_err(adev->dev, " %s Unable to retrieve clk freq : %u", __func__, clk_type);
> > +                             return -EIO;
> > +                     }
> > +
> > +                     freq_values[1] = cur_value;
> > +                     mark_index = cur_value == freq_values[0] ? 0 :
> > +                                  cur_value == freq_values[2] ? 2 : 1;
> > +                     if (mark_index != 1)
> > +                             freq_values[1] = (freq_values[0] + freq_values[2]) / 2;
> > +
> > +                     clock_list[0] = freq_values[1];
> > +                     for (i = 0; i < 3; i++) {
> > +                             clock_list[i+1] = freq_values[i];
> > +                     }
> > +
> > +                     size = 3+1;
> > +             }
> > +             break;
> > +     case SMU_PCIE:
> > +     case SMU_OD_SCLK:
> > +     case SMU_OD_MCLK:
> > +     case SMU_OD_VDDC_CURVE:
> > +     case SMU_OD_RANGE:
> > +             dev_warn(adev->dev, " %s Unhandled clk_type : %u", __func__, clk_type);
> > +             size = -EOPNOTSUPP;
> > +             break;
> > +
> > +     default:
> > +             dev_err(adev->dev, " %s Unknown clk_type : %u", __func__, clk_type);
> > +             size = -EINVAL;
> > +             break;
> > +     }
> > +
> > +     return size;
> > +}
> > +
> >   static int navi10_print_clk_levels(struct smu_context *smu,
> >                       enum smu_clk_type clk_type, char *buf)
> >   {
> > @@ -3241,6 +3336,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
> >       .dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
> >       .i2c_init = navi10_i2c_control_init,
> >       .i2c_fini = navi10_i2c_control_fini,
> > +     .get_clk_levels = navi10_get_clk_levels,
> >       .print_clk_levels = navi10_print_clk_levels,
> >       .force_clk_levels = navi10_force_clk_levels,
> >       .populate_umd_state_clk = navi10_populate_umd_state_clk,
> >
> > base-commit: eabeb4f20a0786188fba07a2dd1b0a614c4e15f6
> >
