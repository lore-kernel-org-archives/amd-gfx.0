From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features
Date: Mon, 27 Aug 2018 04:04:34 +0000
Message-ID: <SN6PR12MB265639A61D343C54EF74CDF9E40B0@SN6PR12MB2656.namprd12.prod.outlook.com>
References: <20180824074349.12448-1-evan.quan@amd.com>
 <CADnq5_PPLej3PUu6ZkHv6muRv_1v8qL7Sfe0zyoKrRAXLan-4w@mail.gmail.com>,
 <BYAPR12MB27751AEFBBFD1386D9ECAFF5FB360@BYAPR12MB2775.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0763732608=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB27751AEFBBFD1386D9ECAFF5FB360-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0763732608==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB265639A61D343C54EF74CDF9E40B0SN6PR12MB2656namp_"

--_000_SN6PR12MB265639A61D343C54EF74CDF9E40B0SN6PR12MB2656namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi @Deucher, Alexander<mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> & @Zhu, Rex<mailto=
:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>,


I can remove the od setings for power limit and fan speed related since the=
y seem redundant with other sysfs apis.

But for the clock/voltage related, i can not see how to reuse old pp_od_clk=
_voltage APIs.


For the old pp_od_clk_voltage APIs,

 1. they output/input the voltages in their exact values. E.g. "s 1 500 820=
" will update sclk level 1 to be 500 MHz at 820 mV

     But for vega20, we did not know its original voltage value. The output=
/input for voltage are just offest from its original value.

     So, if  to reuse these APIs, we will make them have two different expl=
anations(

     on vega20 or later, the voltage is offset. On previous ASICs, the volt=
age is exact value). I think that will confuse the users.


 2. they support voltage set for each level. But for vega20, it supports on=
ly three pairs of clock/voltage set. And per suggestion,

     these three pairs should be: voltage offset of minimum clock level, vo=
ltage offset for middle clock level  and voltage offset

     for maximum clock level.


Also, i believe the future ASICs will also take the vega20 OD ways(that is =
we need the offset, not the exact value for voltage).


So, based on previous considerations, i decide to have new APIs instead of =
reusing existing ones.


Regards,

Evan

________________________________
From: Zhu, Rex
Sent: Saturday, August 25, 2018 12:32 AM
To: Alex Deucher; Quan, Evan
Cc: amd-gfx list; Xu, Feifei; Kuehling, Felix; Deucher, Alexander; Zhang, H=
awking
Subject: RE: [PATCH] drm/amd/powerplay: expose vega20 OD features



> -----Original Message-----
> From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Friday, August 24, 2018 11:48 PM
> To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Xu, Feifei
> <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>; Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; Deucher,
> Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>;
> Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
> Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features
>
> On Fri, Aug 24, 2018 at 3:45 AM Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org> wrote:
> >
> > Vega20 simplifies the OD logics and it can not fit old OD interfaces.
> > Thus we design new OD interfaces for vega20.
>
> Please split this into two patches, one to add the internal od8_settings =
API,
> and one to wire it up to sysfs.  A few more comments below.
>
> >
> > Change-Id: I888faec46a81287ae24f452ce16b42c1f6d06d7d
> > Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h       |   8 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        | 125 ++++++++++++
> >  .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +
> >  drivers/gpu/drm/amd/powerplay/amd_powerplay.c |  37 ++++
> >  .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 191
> +++++++++++++++++-
> >  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     |   2 +
> >  6 files changed, 362 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > index ff24e1cc5b65..84b3e6f87abf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > @@ -357,6 +357,14 @@ enum amdgpu_pcie_gen {
> >                 ((adev)->powerplay.pp_funcs->odn_edit_dpm_table(\
> >                         (adev)->powerplay.pp_handle, type, parameter,
> > size))
> >
> > +#define amdgpu_dpm_get_od8_settings(adev, buf) \
> > +               ((adev)->powerplay.pp_funcs->get_od8_settings(\
> > +                       (adev)->powerplay.pp_handle, buf))
> > +
> > +#define amdgpu_dpm_set_od8_settings(adev, parameter, size) \
> > +               ((adev)->powerplay.pp_funcs->set_od8_settings(\
> > +                       (adev)->powerplay.pp_handle, parameter, size))
> > +
> >  struct amdgpu_dpm {
> >         struct amdgpu_ps        *ps;
> >         /* number of valid power states */ diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > index daa55fb06171..94cd7c503372 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > @@ -934,6 +934,121 @@ static ssize_t amdgpu_get_busy_percent(struct
> device *dev,
> >         return snprintf(buf, PAGE_SIZE, "%d\n", value);  }
> >
> > +/**
> > + * DOC: pp_od8_settings
> > + *
> > + * The amdgpu driver provides a sysfs API for adjusting the clocks,
> > +voltages,
> > + * power limit, fan speed and temperature. The pp_od8_settings is
> > +used for
> > + * this.
> > + *
> > + * Reading the file will display:
> > + *
> > + * - a name list of the features that are able to be adjusted
> > + *
> > + * - the mininum and maximum allowed value for each supported
> > + *   feature labeled in format of "[mininum - maximum]"
> > + *
> > + * - the current value for each supported feature labeled after
> > + *   ":"
> > + *
> > + * To manually adjust these settings:
> > + *
> > + * - write a string that contains the new value for each supported
> > + *   feature. For those which do not need to be changed, just enter
> > + *   their old value
> > + *
> > + * - make sure the new value is within the allowed ranges between
> > + *   the minimum and maximum
>
> We should probably also make it a set and commit model like we do for
> previous asics for consistency.  That way you can see the changes, and th=
en
> apply them.
>
> > + *
> > + * All the possible supported features:
> > + *
> > + * - Gfx clock
> > + *   The min and max frequency can be specified by GfxclkFmin
> > + *   and GfxclkFmax(both in Mhz). Intermediate levels are
> > + *   stretched/shrunk according to ratio in original table.
> > + *
> > + * - Gfx voltage
> > + *   With three pairs of gfx clk(in Mhz) and offset voltage(in mV)
> > + *   combinations specified, smu fw can calibrate the voltage
> > + *   curve automatically.
> > + *     - GfxclkFreq1 <-> GfxclkOffsetVolt1
> > + *     - GfxclkFreq2 <-> GfxclkOffsetVolt2
> > + *     - GfxclkFreq3 <-> GfxclkOffsetVolt3
> > + *
> > + * - Uclk
> > + *   The max memory clock can be specified by UclkFmax(in Mhz).
> > + *
> > + * - Power limit
> > + *   The power limit can be increased or descreased by
> > + *   OverDrivePct(in percent).
>
> We already expose the power limit via hwmon.  Do we still need it here?
>
> > + *
> > + * - Fan spped
>
> spped -> speed
>
> > + *   The max fan speed can be set by FanMaxinumRpm and the
>
> FanMaxinumRpm -> FanMaximumRpm
>
> > + *   min fan speed by FanMinimumPwm. Also zero rpm enablement
> > + *   is specified by FanZeroRpmEnable.
> > + *
> > + * - Temperature
> > + *   The fan target temperature can be set by FanTargetTemperature
> > + *   and max Tj temperature by MaxOpTemp.
>
> The fan and temp stuff might be a better fit for the hwmon interfaces:
> https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface
>
> > + *
> > + */
> > +
> > +static ssize_t amdgpu_get_pp_od8_settings(struct device *dev,
> > +               struct device_attribute *attr,
> > +               char *buf)
> > +{
> > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > +       struct amdgpu_device *adev =3D ddev->dev_private;
> > +
> > +       if (adev->powerplay.pp_funcs->get_od8_settings)
> > +               return amdgpu_dpm_get_od8_settings(adev, buf);
> > +
> > +       return snprintf(buf, PAGE_SIZE, "\n"); }
> > +
> > +static ssize_t amdgpu_set_pp_od8_settings(struct device *dev,
> > +               struct device_attribute *attr,
> > +               const char *buf,
> > +               size_t count)
> > +{
> > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > +       struct amdgpu_device *adev =3D ddev->dev_private;
> > +       char *sub_str, *tmp_str, buf_cpy[128];
> > +       const char delimiter[3] =3D {' ', '\n', '\0'};
> > +       uint32_t parameter_size =3D 0;
> > +       long parameter[64];
> > +       int ret =3D 0xff;
> > +
> > +       if (count >=3D sizeof(buf_cpy) / sizeof(buf_cpy[0]))
> > +               return -EINVAL;
> > +
> > +       memcpy(buf_cpy, buf, count);
> > +       buf_cpy[count] =3D '\0';
> > +
> > +       tmp_str =3D buf_cpy;
> > +
> > +       while (isspace(*tmp_str)) tmp_str++;
> > +
> > +       while (tmp_str[0]) {
> > +               sub_str =3D strsep(&tmp_str, delimiter);
> > +               ret =3D kstrtol(sub_str, 0, &parameter[parameter_size])=
;
> > +               if (ret)
> > +                       return -EINVAL;
> > +               parameter_size++;
> > +
> > +               while (isspace(*tmp_str))
> > +                       tmp_str++;
> > +       }
> > +
> > +       if (adev->powerplay.pp_funcs->set_od8_settings)
> > +               ret =3D amdgpu_dpm_set_od8_settings(adev, parameter,
> > + parameter_size);
> > +
> > +       if (ret)
> > +               return -EINVAL;
> > +
> > +       return count;
> > +}
> > +
> >  static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR,
> > amdgpu_get_dpm_state, amdgpu_set_dpm_state);  static
> DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_IWUSR,
> >                    amdgpu_get_dpm_forced_performance_level,
> > @@ -969,6 +1084,9 @@ static DEVICE_ATTR(pp_od_clk_voltage, S_IRUGO
> | S_IWUSR,
> >                 amdgpu_set_pp_od_clk_voltage);  static
> > DEVICE_ATTR(gpu_busy_percent, S_IRUGO,
> >                 amdgpu_get_busy_percent, NULL);
> > +static DEVICE_ATTR(pp_od8_settings, S_IRUGO | S_IWUSR,
> > +               amdgpu_get_pp_od8_settings,
> > +               amdgpu_set_pp_od8_settings);
>
> Rather than adding a new file, would it make more sense to expose this ne=
w
> API on the same file we use for older asics?  Otherwise, every time the
> interface changes, we'll need to add a new file.  We already handle asic
> specific differences in the power profile sysfs files.
>
> >
> >  static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
> >                                       struct device_attribute *attr,
> > @@ -1879,6 +1997,13 @@ int amdgpu_pm_sysfs_init(struct
> amdgpu_device *adev)
> >                                 "gpu_busy_level\n");
> >                 return ret;
> >         }
> > +       ret =3D device_create_file(adev->dev,
> > +                       &dev_attr_pp_od8_settings);
> > +       if (ret) {
> > +               DRM_ERROR("failed to create device file "
> > +                               "pp_od8_settings\n");
> > +               return ret;
> > +       }
> >         ret =3D amdgpu_debugfs_pm_init(adev);
> >         if (ret) {
> >                 DRM_ERROR("Failed to register debugfs file for
> > dpm!\n"); diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > index 6a41b81c7325..e23746ba53bf 100644
> > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > @@ -269,6 +269,8 @@ struct amd_pm_funcs {
> >         int (*get_display_mode_validation_clocks)(void *handle,
> >                 struct amd_pp_simple_clock_info *clocks);
> >         int (*notify_smu_enable_pwe)(void *handle);
> > +       int (*get_od8_settings)(void *handle, char *buf);
> > +       int (*set_od8_settings)(void *handle, long *input, uint32_t
> > + size);
> >  };
> >
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > index da4ebff5b74d..4bcd06306698 100644
> > --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > @@ -883,6 +883,41 @@ static int pp_odn_edit_dpm_table(void *handle,
> uint32_t type, long *input, uint3
> >         return hwmgr->hwmgr_func->odn_edit_dpm_table(hwmgr, type,
> > input, size);  }
> >
> > +static int pp_get_od8_settings(void *handle, char *buf) {
> > +       struct pp_hwmgr *hwmgr =3D handle;
> > +
> > +       if (!hwmgr || !hwmgr->pm_en || !buf)
> > +               return -EINVAL;
> > +
> > +       if (hwmgr->hwmgr_func->get_od8_settings =3D=3D NULL) {
> > +               pr_info("%s was not implemented.\n", __func__);
> > +               return snprintf(buf, PAGE_SIZE, "\n");
> > +       }
> > +
> > +       return hwmgr->hwmgr_func->get_od8_settings(hwmgr, buf); }
> > +
> > +static int pp_set_od8_settings(void *handle, long *input, uint32_t
> > +size) {
> > +       struct pp_hwmgr *hwmgr =3D handle;
> > +       int ret =3D -EINVAL;
> > +
> > +       if (!hwmgr || !hwmgr->pm_en)
> > +               return ret;
> > +
> > +       if (hwmgr->hwmgr_func->set_od8_settings =3D=3D NULL) {
> > +               pr_info("%s was not implemented.\n", __func__);
> > +               return ret;
> > +       }
> > +
> > +       mutex_lock(&hwmgr->smu_lock);
> > +       ret =3D hwmgr->hwmgr_func->set_od8_settings(hwmgr, input, size)=
;
> > +       mutex_unlock(&hwmgr->smu_lock);
> > +
> > +       return ret;
> > +}
> > +
> >  static int pp_dpm_switch_power_profile(void *handle,
> >                 enum PP_SMC_POWER_PROFILE type, bool en)  { @@ -1272,6
> > +1307,8 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D {
> >         .get_power_profile_mode =3D pp_get_power_profile_mode,
> >         .set_power_profile_mode =3D pp_set_power_profile_mode,
> >         .odn_edit_dpm_table =3D pp_odn_edit_dpm_table,
> > +       .get_od8_settings =3D pp_get_od8_settings,
> > +       .set_od8_settings =3D pp_set_od8_settings,
> >         .set_power_limit =3D pp_set_power_limit,
> >         .get_power_limit =3D pp_get_power_limit,
> >  /* export to DC */
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > index fb32b28afa66..ececa2f7fe5f 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > @@ -1099,7 +1099,188 @@ static int
> vega20_od8_initialize_default_settings(
> >         return 0;
> >  }
> >
> > -static int vega20_od8_set_settings(
> > +static int vega20_get_od8_settings(
> > +               struct pp_hwmgr *hwmgr,
> > +               char *buf)
> > +{
> > +       struct vega20_hwmgr *data =3D
> > +                       (struct vega20_hwmgr *)(hwmgr->backend);
> > +       struct vega20_od8_single_setting *od8_settings =3D
> > +                       data->od8_settings.od8_settings_array;
> > +       OverDriveTable_t od_table;
> > +       uint32_t size =3D 0;
> > +       int ret =3D 0;
> > +
> > +       if (!buf)
> > +               return -EINVAL;
> > +
> > +       ret =3D vega20_copy_table_from_smc(hwmgr,
> > +                       (uint8_t *)(&od_table),
> > +                       TABLE_OVERDRIVE);
> > +       PP_ASSERT_WITH_CODE(!ret,
> > +                       "Failed to export over drive table!",
> > +                       return ret);
> > +
> > +       if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n", "G=
fxclkFmin",
> > +                               od8_settings[OD8_SETTING_GFXCLK_FMIN].m=
in_value,
> > +                               od8_settings[OD8_SETTING_GFXCLK_FMIN].m=
ax_value,
> > +                               od_table.GfxclkFmin);
> > +
> > +       if (od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n", "G=
fxclkFmax",
> > +                               od8_settings[OD8_SETTING_GFXCLK_FMAX].m=
in_value,
> > +                               od8_settings[OD8_SETTING_GFXCLK_FMAX].m=
ax_value,
> > +                               od_table.GfxclkFmax);
> > +
> > +       if (od8_settings[OD8_SETTING_GFXCLK_FREQ1].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n", "G=
fxclkFreq1",
> > +                               od8_settings[OD8_SETTING_GFXCLK_FREQ1].=
min_value,
> > +                               od8_settings[OD8_SETTING_GFXCLK_FREQ1].=
max_value,
> > +                               od_table.GfxclkFreq1);
> > +
> > +       if (od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n",
> "GfxclkOffsetVolt1",
> > +
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].min_value,
> > +
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].max_value,
> > +                               od_table.GfxclkOffsetVolt1);
> > +
> > +       if (od8_settings[OD8_SETTING_GFXCLK_FREQ2].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n", "G=
fxclkFreq2",
> > +                               od8_settings[OD8_SETTING_GFXCLK_FREQ2].=
min_value,
> > +                               od8_settings[OD8_SETTING_GFXCLK_FREQ2].=
max_value,
> > +                               od_table.GfxclkFreq2);
> > +
> > +       if (od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n",
> "GfxclkOffsetVolt2",
> > +
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].min_value,
> > +
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].max_value,
> > +                               od_table.GfxclkOffsetVolt2);
> > +
> > +       if (od8_settings[OD8_SETTING_GFXCLK_FREQ3].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n", "G=
fxclkFreq3",
> > +                               od8_settings[OD8_SETTING_GFXCLK_FREQ3].=
min_value,
> > +                               od8_settings[OD8_SETTING_GFXCLK_FREQ3].=
max_value,
> > +                               od_table.GfxclkFreq3);
> > +
> > +       if (od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n",
> "GfxclkOffsetVolt3",
> > +
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].min_value,
> > +
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].max_value,
> > +                               od_table.GfxclkOffsetVolt3);
> > +
> > +       if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n", "U=
clkFmax",
> > +                               od8_settings[OD8_SETTING_UCLK_FMAX].min=
_value,
> > +                               od8_settings[OD8_SETTING_UCLK_FMAX].max=
_value,
> > +                               od_table.UclkFmax);
> > +
> > +       if (od8_settings[OD8_SETTING_POWER_PERCENTAGE].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n", "O=
verDrivePct",
> > +
> od8_settings[OD8_SETTING_POWER_PERCENTAGE].min_value,
> > +
> od8_settings[OD8_SETTING_POWER_PERCENTAGE].max_value,
> > +                               od_table.OverDrivePct);
> > +
> > +       if (od8_settings[OD8_SETTING_FAN_ACOUSTIC_LIMIT].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n",
> "FanMaximumRpm",
> > +
> od8_settings[OD8_SETTING_FAN_ACOUSTIC_LIMIT].min_value,
> > +
> od8_settings[OD8_SETTING_FAN_ACOUSTIC_LIMIT].max_value,
> > +                               od_table.FanMaximumRpm);
> > +
> > +       if (od8_settings[OD8_SETTING_FAN_MIN_SPEED].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n",
> "FanMinimumPwm",
> > +
> od8_settings[OD8_SETTING_FAN_MIN_SPEED].min_value,
> > +
> od8_settings[OD8_SETTING_FAN_MIN_SPEED].max_value,
> > +                               od_table.FanMinimumPwm);
> > +
> > +       if (od8_settings[OD8_SETTING_FAN_TARGET_TEMP].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n",
> "FanTargetTemperautre",
> > +
> od8_settings[OD8_SETTING_FAN_TARGET_TEMP].min_value,
> > +
> od8_settings[OD8_SETTING_FAN_TARGET_TEMP].max_value,
> > +                               od_table.FanTargetTemperature);
> > +
> > +       if (od8_settings[OD8_SETTING_OPERATING_TEMP_MAX].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n", "M=
axOpTemp",
> > +
> od8_settings[OD8_SETTING_OPERATING_TEMP_MAX].min_value,
> > +
> od8_settings[OD8_SETTING_OPERATING_TEMP_MAX].max_value,
> > +                               od_table.MaxOpTemp);
> > +
> > +       if (od8_settings[OD8_SETTING_FAN_ZERO_RPM_CONTROL].feature_id)
> > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n",
> "FanZeroRpmEnable",
> > +
> od8_settings[OD8_SETTING_FAN_ZERO_RPM_CONTROL].min_value,
> > +
> od8_settings[OD8_SETTING_FAN_ZERO_RPM_CONTROL].max_value,
> > +                               od_table.FanZeroRpmEnable);
> > +
> > +       return size;
> > +}
> > +
> > +static int vega20_set_od8_settings(
> > +               struct pp_hwmgr *hwmgr,
> > +               long *input,
> > +               uint32_t size)
> > +{
> > +       struct vega20_hwmgr *data =3D
> > +                       (struct vega20_hwmgr *)(hwmgr->backend);
> > +       struct vega20_od8_single_setting *od8_settings =3D
> > +                       data->od8_settings.od8_settings_array;
> > +       OverDriveTable_t od_table;
> > +       uint16_t *buf =3D (uint16_t *)(&od_table);
> > +       uint32_t i, j =3D 0, k;
> > +       int ret =3D 0;
> > +
> > +       /* retrieve current overdrive settings */
> > +       ret =3D vega20_copy_table_from_smc(hwmgr,
> > +                       (uint8_t *)(&od_table),
> > +                       TABLE_OVERDRIVE);
> > +       PP_ASSERT_WITH_CODE(!ret,
> > +                       "Failed to export over drive table!",
> > +                       return ret);
> > +
> > +       for (i =3D 0;
> > +            i < (sizeof(OverDriveTable_t) / sizeof(uint16_t)) - 1;
> > +            i++) {
> > +               /* overdrive table supports no dram timing setting */
> > +               k =3D (i =3D=3D OD8_SETTING_AC_TIMING) ?
> > +                       OD8_SETTING_FAN_ZERO_RPM_CONTROL : i;
> > +               /*
> > +                * Not all OD settings are supported and exported
> > +                * to user.
> > +                * So, updated only those which are supported and
> > +                * exported to user.
> > +                */
> > +               if (od8_settings[k].feature_id) {
> > +                       if (input[j] < od8_settings[k].min_value ||
> > +                           input[j] > od8_settings[k].max_value)
> > +                               return -EINVAL;
> > +
> > +                       buf[i] =3D input[j];
> > +                       if (j++ >=3D size - 1)
> > +                               break;
> > +               }
> > +       }
> > +
> > +       /* enable the new overdrive settings */
> > +       ret =3D vega20_copy_table_to_smc(hwmgr,
> > +                       (uint8_t *)(&od_table),
> > +                       TABLE_OVERDRIVE);
> > +       PP_ASSERT_WITH_CODE(!ret,
> > +                       "Failed to import over drive table!",
> > +                       return ret);
> > +
> > +       /* update the current_value of overdrive settings */
> > +       for (i =3D 0;
> > +            i < (sizeof(OverDriveTable_t) / sizeof(uint16_t)) - 1;
> > +            i++) {
> > +               k =3D (i =3D=3D OD8_SETTING_AC_TIMING) ?
> > +                       OD8_SETTING_FAN_ZERO_RPM_CONTROL : i;
> > +               if (od8_settings[k].feature_id)
> > +                       od8_settings[k].current_value =3D buf[i];
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int vega20_od8_set_single_setting(
> >                 struct pp_hwmgr *hwmgr,
> >                 uint32_t index,
> >                 uint32_t value)
> > @@ -1198,7 +1379,7 @@ static int vega20_set_sclk_od(
> >         do_div(od_sclk, 100);
> >         od_sclk +=3D
> > golden_sclk_table->dpm_levels[golden_sclk_table->count - 1].value;
> >
> > -       ret =3D vega20_od8_set_settings(hwmgr, OD8_SETTING_GFXCLK_FMAX,
> od_sclk);
> > +       ret =3D vega20_od8_set_single_setting(hwmgr,
> > + OD8_SETTING_GFXCLK_FMAX, od_sclk);
> >         PP_ASSERT_WITH_CODE(!ret,
> >                         "[SetSclkOD] failed to set od gfxclk!",
> >                         return ret);
> > @@ -1245,7 +1426,7 @@ static int vega20_set_mclk_od(
> >         do_div(od_mclk, 100);
> >         od_mclk +=3D
> > golden_mclk_table->dpm_levels[golden_mclk_table->count - 1].value;
> >
> > -       ret =3D vega20_od8_set_settings(hwmgr, OD8_SETTING_UCLK_FMAX,
> od_mclk);
> > +       ret =3D vega20_od8_set_single_setting(hwmgr,
> > + OD8_SETTING_UCLK_FMAX, od_mclk);
> >         PP_ASSERT_WITH_CODE(!ret,
> >                         "[SetMclkOD] failed to set od memclk!",
> >                         return ret);
> > @@ -2966,6 +3147,10 @@ static const struct pp_hwmgr_func
> vega20_hwmgr_funcs =3D {
> >                 vega20_get_power_profile_mode,
> >         .set_power_profile_mode =3D
> >                 vega20_set_power_profile_mode,
> > +       .get_od8_settings =3D
> > +               vega20_get_od8_settings,
> > +       .set_od8_settings =3D
> > +               vega20_set_od8_settings,
> >         /* od related */
> >         .set_power_limit =3D
> >                 vega20_set_power_limit, diff --git
> > a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > index a6d92128b19c..285af1728e2e 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > @@ -328,6 +328,8 @@ struct pp_hwmgr_func {
> >         int (*set_power_limit)(struct pp_hwmgr *hwmgr, uint32_t n);
> >         int (*powergate_mmhub)(struct pp_hwmgr *hwmgr);
> >         int (*smus_notify_pwe)(struct pp_hwmgr *hwmgr);
> > +       int (*get_od8_settings)(struct pp_hwmgr *hwmgr, char *buf);
> > +       int (*set_od8_settings)(struct pp_hwmgr *hwmgr, long *input,
> > + uint32_t size);

Those new added interfaces for OD parameters get/set seems have no differen=
ce with the old interface.

        int (*print_clock_levels)(struct pp_hwmgr *hwmgr, enum pp_clock_typ=
e type, char *buf);
        int (*odn_edit_dpm_table)(struct pp_hwmgr *hwmgr, enum PP_OD_DPM_TA=
BLE_COMMAND type, long *input, uint32_t size);

Regards
Rex
> >  };
> >
> >  struct pp_table_func {
> > --
> > 2.18.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_SN6PR12MB265639A61D343C54EF74CDF9E40B0SN6PR12MB2656namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hi <a class=3D"mention ms-bgc-nlr=
 ms-fcl-b" id=3D"OWAAM369891" href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">
@Deucher, Alexander</a>&nbsp;&amp; <a class=3D"mention ms-bgc-nlr ms-fcl-b"=
 id=3D"OWAAM450498" href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">
@Zhu, Rex</a>,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I can remove the od setings for p=
ower limit and fan speed related since they seem
<span>redundant&nbsp;</span>with other sysfs apis.</p>
<p style=3D"margin-top:0;margin-bottom:0">But for the clock/voltage related=
, i can not&nbsp;see how to reuse old&nbsp;<span>pp_od_clk_voltage APIs.</s=
pan></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><i>For the old pp_od_clk_vo=
ltage APIs,</i></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><i><span>&nbsp;1.&nbsp;they outpu=
t/input the voltages in their&nbsp;exact&nbsp;values. E.g.&nbsp;</span><spa=
n style=3D"font-size: 12pt;">&quot;s 1 500 820&quot; will update sclk level=
 1 to be 500 MHz</span><span style=3D"font-size: 12pt;">&nbsp;at 820 mV</sp=
an></i></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 12pt;">=
<i>&nbsp; &nbsp; &nbsp;But for vega20, we did not know its original voltage=
 value. The output/input for voltage are just&nbsp;offest from its original=
 value.</i></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><i>&nbsp; &nbsp; &nbsp;So, if &nb=
sp;to reuse these APIs, we will make them have two different explanations(<=
/i></p>
<p style=3D"margin-top:0;margin-bottom:0"><i>&nbsp; &nbsp; &nbsp;on vega20 =
or later, the voltage is offset. On previous ASICs, the voltage is exact va=
lue). I think that will confuse the users.</i></p>
<p style=3D"margin-top:0;margin-bottom:0"><i><br>
</i></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><i>&nbsp;2. they support vo=
ltage set for each level. But for vega20, it supports only three pairs of c=
lock/voltage set. And per suggestion,</i></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><i>&nbsp; &nbsp; &nbsp;thes=
e three pairs should be: voltage offset of minimum clock level, voltage off=
set for middle clock&nbsp;level&nbsp; and voltage offset</i></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><i>&nbsp; &nbsp; &nbsp;for =
maximum clock level.</i></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><i>Also, i believe the futu=
re ASICs will also take the vega20 OD&nbsp;ways(that is we need the offset,=
 not the exact value for voltage).</i></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>So, based on previous consi=
derations, i decide to have&nbsp;new APIs instead of reusing existing ones.=
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Regards,</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Evan</span></p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhu, Rex<br>
<b>Sent:</b> Saturday, August 25, 2018 12:32 AM<br>
<b>To:</b> Alex Deucher; Quan, Evan<br>
<b>Cc:</b> amd-gfx list; Xu, Feifei; Kuehling, Felix; Deucher, Alexander; Z=
hang, Hawking<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: expose vega20 OD features</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; Sent: Friday, August 24, 2018 11:48 PM<br>
&gt; To: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Cc: amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Xu, Feifei<br>
&gt; &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;; Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&=
gt;; Deucher,<br>
&gt; Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Zhu, Rex &lt;Rex.Zhu@amd.=
com&gt;;<br>
&gt; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features<br>
&gt; <br>
&gt; On Fri, Aug 24, 2018 at 3:45 AM Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt; wr=
ote:<br>
&gt; &gt;<br>
&gt; &gt; Vega20 simplifies the OD logics and it can not fit old OD interfa=
ces.<br>
&gt; &gt; Thus we design new OD interfaces for vega20.<br>
&gt; <br>
&gt; Please split this into two patches, one to add the internal od8_settin=
gs API,<br>
&gt; and one to wire it up to sysfs.&nbsp; A few more comments below.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Change-Id: I888faec46a81287ae24f452ce16b42c1f6d06d7d<br>
&gt; &gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 &#43;<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 125 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;<br>
&gt; &gt;&nbsp; .../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 &#43;<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c |&nbsp; 37 &#=
43;&#43;&#43;&#43;<br>
&gt; &gt;&nbsp; .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp=
; | 191<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;-<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp;&nbsp; 2 &#43;<br>
&gt; &gt;&nbsp; 6 files changed, 362 insertions(&#43;), 3 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&gt; &gt; index ff24e1cc5b65..84b3e6f87abf 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&gt; &gt; @@ -357,6 &#43;357,14 @@ enum amdgpu_pcie_gen {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;odn_edit_=
dpm_table(\<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (adev)-&gt;powerplay.pp_handle, type, parameter,<br>
&gt; &gt; size))<br>
&gt; &gt;<br>
&gt; &gt; &#43;#define amdgpu_dpm_get_od8_settings(adev, buf) \<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;get_od8_setting=
s(\<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev)-&gt;powerplay.pp_handle, buf))<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;#define amdgpu_dpm_set_od8_settings(adev, parameter, size) \=
<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_od8_setting=
s(\<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev)-&gt;powerplay.pp_handle, parameter, size))<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; struct amdgpu_dpm {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ps&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ps;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* number of vali=
d power states */ diff --git<br>
&gt; &gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; index daa55fb06171..94cd7c503372 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; @@ -934,6 &#43;934,121 @@ static ssize_t amdgpu_get_busy_percent(=
struct<br>
&gt; device *dev,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(b=
uf, PAGE_SIZE, &quot;%d\n&quot;, value);&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;/**<br>
&gt; &gt; &#43; * DOC: pp_od8_settings<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * The amdgpu driver provides a sysfs API for adjusting the =
clocks,<br>
&gt; &gt; &#43;voltages,<br>
&gt; &gt; &#43; * power limit, fan speed and temperature. The pp_od8_settin=
gs is<br>
&gt; &gt; &#43;used for<br>
&gt; &gt; &#43; * this.<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * Reading the file will display:<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - a name list of the features that are able to be adjuste=
d<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - the mininum and maximum allowed value for each supporte=
d<br>
&gt; &gt; &#43; *&nbsp;&nbsp; feature labeled in format of &quot;[mininum -=
 maximum]&quot;<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - the current value for each supported feature labeled af=
ter<br>
&gt; &gt; &#43; *&nbsp;&nbsp; &quot;:&quot;<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * To manually adjust these settings:<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - write a string that contains the new value for each sup=
ported<br>
&gt; &gt; &#43; *&nbsp;&nbsp; feature. For those which do not need to be ch=
anged, just enter<br>
&gt; &gt; &#43; *&nbsp;&nbsp; their old value<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - make sure the new value is within the allowed ranges be=
tween<br>
&gt; &gt; &#43; *&nbsp;&nbsp; the minimum and maximum<br>
&gt; <br>
&gt; We should probably also make it a set and commit model like we do for<=
br>
&gt; previous asics for consistency.&nbsp; That way you can see the changes=
, and then<br>
&gt; apply them.<br>
&gt; <br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * All the possible supported features:<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - Gfx clock<br>
&gt; &gt; &#43; *&nbsp;&nbsp; The min and max frequency can be specified by=
 GfxclkFmin<br>
&gt; &gt; &#43; *&nbsp;&nbsp; and GfxclkFmax(both in Mhz). Intermediate lev=
els are<br>
&gt; &gt; &#43; *&nbsp;&nbsp; stretched/shrunk according to ratio in origin=
al table.<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - Gfx voltage<br>
&gt; &gt; &#43; *&nbsp;&nbsp; With three pairs of gfx clk(in Mhz) and offse=
t voltage(in mV)<br>
&gt; &gt; &#43; *&nbsp;&nbsp; combinations specified, smu fw can calibrate =
the voltage<br>
&gt; &gt; &#43; *&nbsp;&nbsp; curve automatically.<br>
&gt; &gt; &#43; *&nbsp;&nbsp;&nbsp;&nbsp; - GfxclkFreq1 &lt;-&gt; GfxclkOff=
setVolt1<br>
&gt; &gt; &#43; *&nbsp;&nbsp;&nbsp;&nbsp; - GfxclkFreq2 &lt;-&gt; GfxclkOff=
setVolt2<br>
&gt; &gt; &#43; *&nbsp;&nbsp;&nbsp;&nbsp; - GfxclkFreq3 &lt;-&gt; GfxclkOff=
setVolt3<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - Uclk<br>
&gt; &gt; &#43; *&nbsp;&nbsp; The max memory clock can be specified by Uclk=
Fmax(in Mhz).<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - Power limit<br>
&gt; &gt; &#43; *&nbsp;&nbsp; The power limit can be increased or descrease=
d by<br>
&gt; &gt; &#43; *&nbsp;&nbsp; OverDrivePct(in percent).<br>
&gt; <br>
&gt; We already expose the power limit via hwmon.&nbsp; Do we still need it=
 here?<br>
&gt; <br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - Fan spped<br>
&gt; <br>
&gt; spped -&gt; speed<br>
&gt; <br>
&gt; &gt; &#43; *&nbsp;&nbsp; The max fan speed can be set by FanMaxinumRpm=
 and the<br>
&gt; <br>
&gt; FanMaxinumRpm -&gt; FanMaximumRpm<br>
&gt; <br>
&gt; &gt; &#43; *&nbsp;&nbsp; min fan speed by FanMinimumPwm. Also zero rpm=
 enablement<br>
&gt; &gt; &#43; *&nbsp;&nbsp; is specified by FanZeroRpmEnable.<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * - Temperature<br>
&gt; &gt; &#43; *&nbsp;&nbsp; The fan target temperature can be set by FanT=
argetTemperature<br>
&gt; &gt; &#43; *&nbsp;&nbsp; and max Tj temperature by MaxOpTemp.<br>
&gt; <br>
&gt; The fan and temp stuff might be a better fit for the hwmon interfaces:=
<br>
&gt; <a href=3D"https://www.kernel.org/doc/Documentation/hwmon/sysfs-interf=
ace" id=3D"LPlnk523014" class=3D"OWAAutoLink" previewremoved=3D"true">
https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface</a><br>
&gt; <br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; */<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;static ssize_t amdgpu_get_pp_od8_settings(struct device *dev=
,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &gt; &#43;{<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev=
 =3D dev_get_drvdata(dev);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *a=
dev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.=
pp_funcs-&gt;get_od8_settings)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_dpm_get_od8_settings(adev, buf);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PA=
GE_SIZE, &quot;\n&quot;); }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;static ssize_t amdgpu_set_pp_od8_settings(struct device *dev=
,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size_t count)<br>
&gt; &gt; &#43;{<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev=
 =3D dev_get_drvdata(dev);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *a=
dev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *sub_str, *tmp_str=
, buf_cpy[128];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char delimiter[3]=
 =3D {' ', '\n', '\0'};<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t parameter_size=
 =3D 0;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long parameter[64];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0xff;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (count &gt;=3D sizeo=
f(buf_cpy) / sizeof(buf_cpy[0]))<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf_cpy, buf, co=
unt);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_cpy[count] =3D '\0'=
;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_str =3D buf_cpy;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (isspace(*tmp_str=
)) tmp_str&#43;&#43;;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (tmp_str[0]) {<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sub_str =3D strsep(&amp;tmp_str, delimiter);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kstrtol(sub_str, 0, &amp;parameter[paramet=
er_size]);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EINVAL;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; parameter_size&#43;&#43;;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; while (isspace(*tmp_str))<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tm=
p_str&#43;&#43;;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.=
pp_funcs-&gt;set_od8_settings)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_od8_settings(adev, paramete=
r,<br>
&gt; &gt; &#43; parameter_size);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR,<br>
&gt; &gt; amdgpu_get_dpm_state, amdgpu_set_dpm_state);&nbsp; static<br>
&gt; DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_IWUSR,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_dpm_forced_perf=
ormance_level,<br>
&gt; &gt; @@ -969,6 &#43;1084,9 @@ static DEVICE_ATTR(pp_od_clk_voltage, S_=
IRUGO<br>
&gt; | S_IWUSR,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_od_clk_voltage);&nbsp; static<=
br>
&gt; &gt; DEVICE_ATTR(gpu_busy_percent, S_IRUGO,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_busy_percent, NULL);<br>
&gt; &gt; &#43;static DEVICE_ATTR(pp_od8_settings, S_IRUGO | S_IWUSR,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_od8_settings,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_od8_settings);<br>
&gt; <br>
&gt; Rather than adding a new file, would it make more sense to expose this=
 new<br>
&gt; API on the same file we use for older asics?&nbsp; Otherwise, every ti=
me the<br>
&gt; interface changes, we'll need to add a new file.&nbsp; We already hand=
le asic<br>
&gt; specific differences in the power profile sysfs files.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;&nbsp; static ssize_t amdgpu_hwmon_show_temp(struct device *dev,<b=
r>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &gt; @@ -1879,6 &#43;1997,13 @@ int amdgpu_pm_sysfs_init(struct<br>
&gt; amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;gpu_busy_level\n&=
quot;);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_f=
ile(adev-&gt;dev,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;dev_attr_pp_od8_settings);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device file &quot=
;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_od8_settings\n&quot;=
);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_de=
bugfs_pm_init(adev);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to register debugfs f=
ile for<br>
&gt; &gt; dpm!\n&quot;); diff --git a/drivers/gpu/drm/amd/include/kgd_pp_in=
terface.h<br>
&gt; &gt; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &gt; index 6a41b81c7325..e23746ba53bf 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<=
br>
&gt; &gt; @@ -269,6 &#43;269,8 @@ struct amd_pm_funcs {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_display=
_mode_validation_clocks)(void *handle,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock_info *clocks);<br=
>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_smu_=
enable_pwe)(void *handle);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_od8_settings)=
(void *handle, char *buf);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_od8_settings)=
(void *handle, long *input, uint32_t<br>
&gt; &gt; &#43; size);<br>
&gt; &gt;&nbsp; };<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; #endif<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &gt; index da4ebff5b74d..4bcd06306698 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<b=
r>
&gt; &gt; @@ -883,6 &#43;883,41 @@ static int pp_odn_edit_dpm_table(void *h=
andle,<br>
&gt; uint32_t type, long *input, uint3<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;=
hwmgr_func-&gt;odn_edit_dpm_table(hwmgr, type,<br>
&gt; &gt; input, size);&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;static int pp_get_od8_settings(void *handle, char *buf) {<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =
=3D handle;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&g=
t;pm_en || !buf)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_fun=
c-&gt;get_od8_settings =3D=3D NULL) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __f=
unc__);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<b=
r>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_=
func-&gt;get_od8_settings(hwmgr, buf); }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;static int pp_set_od8_settings(void *handle, long *input, ui=
nt32_t<br>
&gt; &gt; &#43;size) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =
=3D handle;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&g=
t;pm_en)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_fun=
c-&gt;set_od8_settings =3D=3D NULL) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __f=
unc__);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&=
gt;smu_lock);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;hwmgr=
_func-&gt;set_od8_settings(hwmgr, input, size);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr=
-&gt;smu_lock);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; static int pp_dpm_switch_power_profile(void *handle,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_SMC_POWER_PROFILE type, bool en)&nbs=
p; { @@ -1272,6<br>
&gt; &gt; &#43;1307,8 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D =
{<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profil=
e_mode =3D pp_get_power_profile_mode,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profil=
e_mode =3D pp_set_power_profile_mode,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .odn_edit_dpm_tab=
le =3D pp_odn_edit_dpm_table,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_od8_settings =3D p=
p_get_od8_settings,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_od8_settings =3D p=
p_set_od8_settings,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_limit =
=3D pp_set_power_limit,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_limit =
=3D pp_get_power_limit,<br>
&gt; &gt;&nbsp; /* export to DC */<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<b=
r>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; &gt; index fb32b28afa66..ececa2f7fe5f 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmg=
r.c<br>
&gt; &gt; @@ -1099,7 &#43;1099,188 @@ static int<br>
&gt; vega20_od8_initialize_default_settings(<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -static int vega20_od8_set_settings(<br>
&gt; &gt; &#43;static int vega20_get_od8_settings(<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &gt; &#43;{<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *da=
ta =3D<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s=
truct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_od8_singl=
e_setting *od8_settings =3D<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; da=
ta-&gt;od8_settings.od8_settings_array;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t od_tab=
le;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D 0;<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!buf)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_copy_tab=
le_from_smc(hwmgr,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u=
int8_t *)(&amp;od_table),<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA=
BLE_OVERDRIVE);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!re=
t,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &q=
uot;Failed to export over drive table!&quot;,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn ret);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_GFXCLK_FMIN].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;, &quot;GfxclkFmin&quot;,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXC=
LK_FMIN].min_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXC=
LK_FMIN].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkFmin);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_GFXCLK_FMAX].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;, &quot;GfxclkFmax&quot;,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXC=
LK_FMAX].min_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXC=
LK_FMAX].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkFmax);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_GFXCLK_FREQ1].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;, &quot;GfxclkFreq1&quot;,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXC=
LK_FREQ1].min_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXC=
LK_FREQ1].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkFreq1);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_GFXCLK_VOLTAGE1].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;,<br>
&gt; &quot;GfxclkOffsetVolt1&quot;,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].min_value,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkOffsetVolt1);<=
br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_GFXCLK_FREQ2].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;, &quot;GfxclkFreq2&quot;,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXC=
LK_FREQ2].min_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXC=
LK_FREQ2].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkFreq2);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_GFXCLK_VOLTAGE2].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;,<br>
&gt; &quot;GfxclkOffsetVolt2&quot;,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].min_value,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkOffsetVolt2);<=
br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_GFXCLK_FREQ3].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;, &quot;GfxclkFreq3&quot;,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXC=
LK_FREQ3].min_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXC=
LK_FREQ3].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkFreq3);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_GFXCLK_VOLTAGE3].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;,<br>
&gt; &quot;GfxclkOffsetVolt3&quot;,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].min_value,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkOffsetVolt3);<=
br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_UCLK_FMAX].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;, &quot;UclkFmax&quot;,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_UCLK=
_FMAX].min_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_UCLK=
_FMAX].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.UclkFmax);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_POWER_PERCENTAGE].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;, &quot;OverDrivePct&quot;,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_POWER_PERCENTAGE].min_value,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_POWER_PERCENTAGE].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.OverDrivePct);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_FAN_ACOUSTIC_LIMIT].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;,<br>
&gt; &quot;FanMaximumRpm&quot;,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_FAN_ACOUSTIC_LIMIT].min_value,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_FAN_ACOUSTIC_LIMIT].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.FanMaximumRpm);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_FAN_MIN_SPEED].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;,<br>
&gt; &quot;FanMinimumPwm&quot;,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_FAN_MIN_SPEED].min_value,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_FAN_MIN_SPEED].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.FanMinimumPwm);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_FAN_TARGET_TEMP].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;,<br>
&gt; &quot;FanTargetTemperautre&quot;,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_FAN_TARGET_TEMP].min_value,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_FAN_TARGET_TEMP].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.FanTargetTemperature=
);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_OPERATING_TEMP_MAX].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;, &quot;MaxOpTemp&quot;,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_OPERATING_TEMP_MAX].min_value,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_OPERATING_TEMP_MAX].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.MaxOpTemp);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SE=
TTING_FAN_ZERO_RPM_CONTROL].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%22s[%=
d - %d]: %u\n&quot;,<br>
&gt; &quot;FanZeroRpmEnable&quot;,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_FAN_ZERO_RPM_CONTROL].min_value,<br>
&gt; &gt; &#43;<br>
&gt; od8_settings[OD8_SETTING_FAN_ZERO_RPM_CONTROL].max_value,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.FanZeroRpmEnable);<b=
r>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;static int vega20_set_od8_settings(<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; long *input,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size)<br>
&gt; &gt; &#43;{<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *da=
ta =3D<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s=
truct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_od8_singl=
e_setting *od8_settings =3D<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; da=
ta-&gt;od8_settings.od8_settings_array;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t od_tab=
le;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t *buf =3D (uint=
16_t *)(&amp;od_table);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, j =3D 0, k;=
<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* retrieve current ove=
rdrive settings */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_copy_tab=
le_from_smc(hwmgr,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u=
int8_t *)(&amp;od_table),<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA=
BLE_OVERDRIVE);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!re=
t,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &q=
uot;Failed to export over drive table!&quot;,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn ret);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; i &lt; (sizeof(OverDriveTable_t) / sizeof(uint16_t)) - 1;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; i&#43;&#43;) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* overdrive table supports no dram timing setting=
 */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; k =3D (i =3D=3D OD8_SETTING_AC_TIMING) ?<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OD=
8_SETTING_FAN_ZERO_RPM_CONTROL : i;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Not all OD settings are supported and expo=
rted<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to user.<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * So, updated only those which are supported=
 and<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * exported to user.<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[k].feature_id) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (input[j] &lt; od8_settings[k].min_value ||<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; input[j] &gt; od8_settings[k].max_value)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bu=
f[i] =3D input[j];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (j&#43;&#43; &gt;=3D size - 1)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable the new overd=
rive settings */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_copy_tab=
le_to_smc(hwmgr,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u=
int8_t *)(&amp;od_table),<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA=
BLE_OVERDRIVE);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!re=
t,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &q=
uot;Failed to import over drive table!&quot;,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn ret);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update the current_v=
alue of overdrive settings */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; i &lt; (sizeof(OverDriveTable_t) / sizeof(uint16_t)) - 1;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; i&#43;&#43;) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; k =3D (i =3D=3D OD8_SETTING_AC_TIMING) ?<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OD=
8_SETTING_FAN_ZERO_RPM_CONTROL : i;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[k].feature_id)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od=
8_settings[k].current_value =3D buf[i];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;static int vega20_od8_set_single_setting(<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value)<br>
&gt; &gt; @@ -1198,7 &#43;1379,7 @@ static int vega20_set_sclk_od(<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_div(od_sclk, 1=
00);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_sclk &#43;=3D<=
br>
&gt; &gt; golden_sclk_table-&gt;dpm_levels[golden_sclk_table-&gt;count - 1]=
.value;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_od8_set_sett=
ings(hwmgr, OD8_SETTING_GFXCLK_FMAX,<br>
&gt; od_sclk);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_od8_set_=
single_setting(hwmgr,<br>
&gt; &gt; &#43; OD8_SETTING_GFXCLK_FMAX, od_sclk);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CO=
DE(!ret,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &quot;[SetSclkOD] failed to set od gfxclk!&quot;,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret);<br>
&gt; &gt; @@ -1245,7 &#43;1426,7 @@ static int vega20_set_mclk_od(<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_div(od_mclk, 1=
00);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_mclk &#43;=3D<=
br>
&gt; &gt; golden_mclk_table-&gt;dpm_levels[golden_mclk_table-&gt;count - 1]=
.value;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_od8_set_sett=
ings(hwmgr, OD8_SETTING_UCLK_FMAX,<br>
&gt; od_mclk);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_od8_set_=
single_setting(hwmgr,<br>
&gt; &gt; &#43; OD8_SETTING_UCLK_FMAX, od_mclk);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CO=
DE(!ret,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &quot;[SetMclkOD] failed to set od memclk!&quot;,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret);<br>
&gt; &gt; @@ -2966,6 &#43;3147,10 @@ static const struct pp_hwmgr_func<br>
&gt; vega20_hwmgr_funcs =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_get_power_profile_mode,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profil=
e_mode =3D<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_set_power_profile_mode,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_od8_settings =3D<b=
r>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; vega20_get_od8_settings,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_od8_settings =3D<b=
r>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; vega20_set_od8_settings,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* od related */<=
br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_limit =
=3D<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_set_power_limit, diff --git<br>
&gt; &gt; a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; index a6d92128b19c..285af1728e2e 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; @@ -328,6 &#43;328,8 @@ struct pp_hwmgr_func {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_l=
imit)(struct pp_hwmgr *hwmgr, uint32_t n);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*powergate_m=
mhub)(struct pp_hwmgr *hwmgr);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smus_notify=
_pwe)(struct pp_hwmgr *hwmgr);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_od8_settings)=
(struct pp_hwmgr *hwmgr, char *buf);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_od8_settings)=
(struct pp_hwmgr *hwmgr, long *input,<br>
&gt; &gt; &#43; uint32_t size);<br>
<br>
Those new added interfaces for OD parameters get/set seems have no differen=
ce with the old interface.<br>
&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*print_clock_levels)(struct=
 pp_hwmgr *hwmgr, enum pp_clock_type type, char *buf);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*odn_edit_dpm_table)(struct=
 pp_hwmgr *hwmgr, enum PP_OD_DPM_TABLE_COMMAND type, long *input, uint32_t =
size);<br>
<br>
Regards<br>
Rex<br>
&gt; &gt;&nbsp; };<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; struct pp_table_func {<br>
&gt; &gt; --<br>
&gt; &gt; 2.18.0<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
" id=3D"LPlnk84178" class=3D"OWAAutoLink" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_SN6PR12MB265639A61D343C54EF74CDF9E40B0SN6PR12MB2656namp_--

--===============0763732608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0763732608==--
