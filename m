From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features
Date: Wed, 29 Aug 2018 09:16:43 +0000
Message-ID: <SN6PR12MB2656AF86A061B6F37E25267AE4090@SN6PR12MB2656.namprd12.prod.outlook.com>
References: <20180824074349.12448-1-evan.quan@amd.com>
 <CADnq5_PPLej3PUu6ZkHv6muRv_1v8qL7Sfe0zyoKrRAXLan-4w@mail.gmail.com>
 <BYAPR12MB27751AEFBBFD1386D9ECAFF5FB360@BYAPR12MB2775.namprd12.prod.outlook.com>
 <SN6PR12MB265639A61D343C54EF74CDF9E40B0@SN6PR12MB2656.namprd12.prod.outlook.com>
 <CADnq5_Pb=HR3h8Bq8UfPifvGea-S_x9drEOrCdf3rtN-=pbaJg@mail.gmail.com>
 <SN6PR12MB2656D9CFE46599866E01CB46E40A0@SN6PR12MB2656.namprd12.prod.outlook.com>
 <BN6PR12MB180998E806A582A0C10F2C1BF70A0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BYAPR12MB27757726027B9534A5EDFAF2FB0A0@BYAPR12MB2775.namprd12.prod.outlook.com>,
 <CADnq5_ODKCsF_PxL+UhxHNVUZP+U8+ko0+O6uxQuSYtOfuDydA@mail.gmail.com>,
 <SN6PR12MB265690C8EFFD1ACFBF696C86E4090@SN6PR12MB2656.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1976688323=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB265690C8EFFD1ACFBF696C86E4090-kxOKjb6HO/FeL/N0e1LXkAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Xu,
 Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1976688323==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2656AF86A061B6F37E25267AE4090SN6PR12MB2656namp_"

--_000_SN6PR12MB2656AF86A061B6F37E25267AE4090SN6PR12MB2656namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

I just sent out a new patch which reuses existing APIs. Let's move future d=
iscussion there.

Regards,
Evan
________________________________
From: Quan, Evan
Sent: Wednesday, August 29, 2018 9:12 AM
To: Alex Deucher; Zhu, Rex
Cc: Deucher, Alexander; amd-gfx list; Xu, Feifei; Kuehling, Felix; Zhang, H=
awking
Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features


Approach 3 seems not workable since we do not know the default value.

I would prefer approach 1 if we have to fit into original APIs. There needs=
 three pairs of <frequency, offset> to recalculate the voltage curve. Inste=
ad of silently calucating dpm_mid_leve=92s offset in our driver, i would pr=
efer to have it specified by user.


Also, we may need to update the description for the OD apis to tell user th=
e different behaviors on vega20 and previous ASICs.


/**
 * DOC: pp_od_clk_voltage
 *
 * The amdgpu driver provides a sysfs API for adjusting the clocks and volt=
ages
 * in each power level within a power state.  The pp_od_clk_voltage is used=
 for
 * this.
 *
 * Reading the file will display:
 *
 * - a list of engine clock levels and voltages labeled OD_SCLK
 *
 * - a list of memory clock levels and voltages labeled OD_MCLK
 *
 * - a list of valid ranges for sclk, mclk, and voltage labeled OD_RANGE
 *
 * To manually adjust these settings, first select manual using
 * power_dpm_force_performance_level. Enter a new value for each
 * level by writing a string that contains "s/m level clock voltage" to
 * the file.  E.g., "s 1 500 820" will update sclk level 1 to be 500 MHz
 * at 820 mV; "m 0 350 810" will update mclk level 0 to be 350 MHz at
 * 810 mV.  When you have edited all of the states as needed, write
 * "c" (commit) to the file to commit your changes.  If you want to reset t=
o the
 * default power levels, write "r" (reset) to the file to reset them.
 *
 */

Regards,

Evan

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, August 29, 2018 1:26:42 AM
To: Zhu, Rex
Cc: Deucher, Alexander; Quan, Evan; amd-gfx list; Xu, Feifei; Kuehling, Fel=
ix; Zhang, Hawking
Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features

On Tue, Aug 28, 2018 at 12:35 PM Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
>
> Got it. Thanks Alex.
>
>
>
> I think we can simplify the od_clk_voltage on vega20.
>
>
>
> When user cat pp_od_clk_voltage
>
> The output can be simplified as:
>
>
>
> Sclk:
>
> 0  clock_value   voltage_offset
>
> 7 clock_value    voltage_offset
>
> Mclk
>
> 3  mclk_value
>
> Range:
>
> sclk {min, max}
>
> mclk {min, max}
>
> voltage{min, max}
>
>
>
> for sclk,
>
> user can only set the sclk in dpm level0 and level7, the clock in other l=
evels will be recalculated by smu automatically based on user=92s setting.
>
>
>
> For voltage, the avfs is enabled, so the voltage in each level is not a u=
nique value.
>
> It is reasonable that export voltage offset to user.
>
> The voltage offset is 0 by default.
>
>
>
> The voltage offset in dpm_0, dpm_mid_level, dpm7_level can be configured.
>
> But in order to keep in consistent with sclk=92s od,
>
> We only let user change the offset in dpm0 and dpm7, for dpm_mid_leve=92s=
 offset, we can calculate in driver by (offset0 + offset7)/2.
>

Seems pretty good.  How about something like the following:

OD_SCLK:
min: clock_value
max: clock_value
OD_MCLK:
max: clock_value
OD_VDDC:
0: clock_value voltage_offset
1: clock_value voltage_offset
2: clock_value voltage_offset
OD_RANGE:
SCLK:     clock_value       clock_value
MCLK:     clock_value       clock_value
VDDC:     voltage_value        voltage_value

OD_SCLK:
min: 300Mhz
max: 1200Mhz
OD_MCLK:
max: 1500Mhz
OD_VDDC:
0: 300Mhz 0mV
1: 600Mhz 0mV
2: 1200Mhz 0mV
OD_RANGE:
SCLK:     300MHz       1200MHz
MCLK:     300MHz       1500MHz
VDDC:     700mV        1200mV

That would give you the fullest control.  Alternatively, we could
simplify this a bit by deriving the mid point in the voltage curve.
E.g.,

OD_SCLK:
min: clock_value
max: clock_value
OD_MCLK:
max: clock_value
OD_VDDC:
min: clock_value voltage_offset
max: clock_value voltage_offset
OD_RANGE:
SCLK:     clock_value       clock_value
MCLK:     clock_value       clock_value
VDDC:     voltage_value        voltage_value

OD_SCLK:
min: 300Mhz
max: 1200Mhz
OD_MCLK:
max 1500Mhz
OD_VDDC:
min: 300Mhz 0mV
max: 1200Mhz 0mV
OD_RANGE:
SCLK:     300MHz       1200MHz
MCLK:     300MHz       1500MHz
VDDC:     700mV        1200mV

I think we could also make the interface backwards compatible.  E.g.,

OD_SCLK:
0 300Mhz 900mV
7 1200Mhz 1000mV
OD_MCLK:
3 1500Mhz 900mV
OD_RANGE:
SCLK:     300MHz       1200MHz
MCLK:     300MHz       1500MHz
VDDC:     700mV        1200mV

We can ignore the voltage for OD_MCLK and then calculate the offsets
based on the absolute value specified in OD_SCLK (e.g., default value
- specified value =3D offset), then calculate the midpoint based on the
end points.  It would be backwards compatible, but somewhat more
confusing for users.  Probably one of the first two would be better.
Thoughts?

Alex

>
>
> For mclk,
>
> Smu just let us change the max clock in dpm3(high level). And the mclk in=
 other dpm levels can not be changed.
>
>
>
> Any concerns?
>
>
>
>
>
> Best Regards
>
> Rex
>
>
>
> From: Deucher, Alexander
> Sent: Wednesday, August 29, 2018 12:03 AM
> To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>; amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp93rCq3LdnpKM@public.gmane.org=
rg>; Xu, Feifei <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>; Kuehling, Felix <Felix.Kuehling-urvtwAKJhsc@public.gmane.org=
m>; Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
> Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features
>
>
>
> Right.  I'm saying use the same sysfs file (pp_od_clk_voltage) for all de=
vices rather than adding a new one.  The output of reading that file will b=
e different on each asic that supports a different way of adjusting the clo=
ck and voltage parameters and the supported inputs will be different.  We d=
o the same thing today for pp_power_profile_mode.  Vega10 and smu7 parts ha=
ve different parameters, but we use the same files.  See the attached patch=
 to an example.
>
>
>
> Alex
>
> ________________________________
>
> From: Quan, Evan
> Sent: Tuesday, August 28, 2018 11:51:16 AM
> To: Alex Deucher
> Cc: Zhu, Rex; Deucher, Alexander; amd-gfx list; Xu, Feifei; Kuehling, Fel=
ix; Zhang, Hawking
> Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features
>
>
>
> Hi Alex,
>
>
>
> Sorry, i cannot get your point.
>
>
>
> The OD feature sysfs file used by previous ASICs is "pp_od_clk_voltage". =
And it binds to two APIs "amdgpu_get_pp_od_clk_voltage" and "amdgpu_set_pp_=
od_clk_voltage".
>
>
>
> static DEVICE_ATTR(pp_od_clk_voltage, S_IRUGO | S_IWUSR,
>
>                 amdgpu_get_pp_od_clk_voltage,
>
>                 amdgpu_set_pp_od_clk_voltage);
>
>
>
> I was saying we cannot reuse these two APIs for vega20 since we have no w=
ay to know the exact voltage value for each dpm level(that is what these tw=
o APIs required). Thus we cannot share the same sysfs file.
>
>
>
> Do you mean we can bind the sysfs file to other APIs? How?
>
>
>
> Regards,
>
> Evan
>
> ________________________________
>
> From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Monday, August 27, 2018 10:01:49 PM
> To: Quan, Evan
> Cc: Zhu, Rex; Deucher, Alexander; amd-gfx list; Xu, Feifei; Kuehling, Fel=
ix; Zhang, Hawking
> Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features
>
>
>
> On Mon, Aug 27, 2018 at 12:04 AM Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org> wrote:
> >
> > Hi @Deucher, Alexander & @Zhu, Rex,
> >
> >
> > I can remove the od setings for power limit and fan speed related since=
 they seem redundant with other sysfs apis.
> >
> > But for the clock/voltage related, i can not see how to reuse old pp_od=
_clk_voltage APIs.
> >
> >
> > For the old pp_od_clk_voltage APIs,
> >
> >  1. they output/input the voltages in their exact values. E.g. "s 1 500=
 820" will update sclk level 1 to be 500 MHz at 820 mV
> >
> >      But for vega20, we did not know its original voltage value. The ou=
tput/input for voltage are just offest from its original value.
> >
> >      So, if  to reuse these APIs, we will make them have two different =
explanations(
> >
> >      on vega20 or later, the voltage is offset. On previous ASICs, the =
voltage is exact value). I think that will confuse the users.
> >
> >
> >  2. they support voltage set for each level. But for vega20, it support=
s only three pairs of clock/voltage set. And per suggestion,
> >
> >      these three pairs should be: voltage offset of minimum clock level=
, voltage offset for middle clock level  and voltage offset
> >
> >      for maximum clock level.
> >
> >
> > Also, i believe the future ASICs will also take the vega20 OD ways(that=
 is we need the offset, not the exact value for voltage).
> >
> >
> > So, based on previous considerations, i decide to have new APIs instead=
 of reusing existing ones.
>
> I'm not saying to use the same API.  Use the new API, but expose the
> API using the same sysfs file rather than adding a new one.  Same way
> we handle the power profiles; E.g., the API is different between smu7
> and vega10, but they both use the same sysfs file.
>
> Alex
>
>
> >
> >
> > Regards,
> >
> > Evan
> >
> > ________________________________
> > From: Zhu, Rex
> > Sent: Saturday, August 25, 2018 12:32 AM
> > To: Alex Deucher; Quan, Evan
> > Cc: amd-gfx list; Xu, Feifei; Kuehling, Felix; Deucher, Alexander; Zhan=
g, Hawking
> > Subject: RE: [PATCH] drm/amd/powerplay: expose vega20 OD features
> >
> >
> >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Sent: Friday, August 24, 2018 11:48 PM
> > > To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> > > Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Xu, Feifei
> > > <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>; Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; Deuche=
r,
> > > Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>;
> > > Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
> > > Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features
> > >
> > > On Fri, Aug 24, 2018 at 3:45 AM Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org> wrote:
> > > >
> > > > Vega20 simplifies the OD logics and it can not fit old OD interface=
s.
> > > > Thus we design new OD interfaces for vega20.
> > >
> > > Please split this into two patches, one to add the internal od8_setti=
ngs API,
> > > and one to wire it up to sysfs.  A few more comments below.
> > >
> > > >
> > > > Change-Id: I888faec46a81287ae24f452ce16b42c1f6d06d7d
> > > > Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h       |   8 +
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        | 125 ++++++++++++
> > > >  .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +
> > > >  drivers/gpu/drm/amd/powerplay/amd_powerplay.c |  37 ++++
> > > >  .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 191
> > > +++++++++++++++++-
> > > >  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     |   2 +
> > > >  6 files changed, 362 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > > > index ff24e1cc5b65..84b3e6f87abf 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > > > @@ -357,6 +357,14 @@ enum amdgpu_pcie_gen {
> > > >                 ((adev)->powerplay.pp_funcs->odn_edit_dpm_table(\
> > > >                         (adev)->powerplay.pp_handle, type, paramete=
r,
> > > > size))
> > > >
> > > > +#define amdgpu_dpm_get_od8_settings(adev, buf) \
> > > > +               ((adev)->powerplay.pp_funcs->get_od8_settings(\
> > > > +                       (adev)->powerplay.pp_handle, buf))
> > > > +
> > > > +#define amdgpu_dpm_set_od8_settings(adev, parameter, size) \
> > > > +               ((adev)->powerplay.pp_funcs->set_od8_settings(\
> > > > +                       (adev)->powerplay.pp_handle, parameter, siz=
e))
> > > > +
> > > >  struct amdgpu_dpm {
> > > >         struct amdgpu_ps        *ps;
> > > >         /* number of valid power states */ diff --git
> > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > > index daa55fb06171..94cd7c503372 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > > @@ -934,6 +934,121 @@ static ssize_t amdgpu_get_busy_percent(struct
> > > device *dev,
> > > >         return snprintf(buf, PAGE_SIZE, "%d\n", value);  }
> > > >
> > > > +/**
> > > > + * DOC: pp_od8_settings
> > > > + *
> > > > + * The amdgpu driver provides a sysfs API for adjusting the clocks=
,
> > > > +voltages,
> > > > + * power limit, fan speed and temperature. The pp_od8_settings is
> > > > +used for
> > > > + * this.
> > > > + *
> > > > + * Reading the file will display:
> > > > + *
> > > > + * - a name list of the features that are able to be adjusted
> > > > + *
> > > > + * - the mininum and maximum allowed value for each supported
> > > > + *   feature labeled in format of "[mininum - maximum]"
> > > > + *
> > > > + * - the current value for each supported feature labeled after
> > > > + *   ":"
> > > > + *
> > > > + * To manually adjust these settings:
> > > > + *
> > > > + * - write a string that contains the new value for each supported
> > > > + *   feature. For those which do not need to be changed, just ente=
r
> > > > + *   their old value
> > > > + *
> > > > + * - make sure the new value is within the allowed ranges between
> > > > + *   the minimum and maximum
> > >
> > > We should probably also make it a set and commit model like we do for
> > > previous asics for consistency.  That way you can see the changes, an=
d then
> > > apply them.
> > >
> > > > + *
> > > > + * All the possible supported features:
> > > > + *
> > > > + * - Gfx clock
> > > > + *   The min and max frequency can be specified by GfxclkFmin
> > > > + *   and GfxclkFmax(both in Mhz). Intermediate levels are
> > > > + *   stretched/shrunk according to ratio in original table.
> > > > + *
> > > > + * - Gfx voltage
> > > > + *   With three pairs of gfx clk(in Mhz) and offset voltage(in mV)
> > > > + *   combinations specified, smu fw can calibrate the voltage
> > > > + *   curve automatically.
> > > > + *     - GfxclkFreq1 <-> GfxclkOffsetVolt1
> > > > + *     - GfxclkFreq2 <-> GfxclkOffsetVolt2
> > > > + *     - GfxclkFreq3 <-> GfxclkOffsetVolt3
> > > > + *
> > > > + * - Uclk
> > > > + *   The max memory clock can be specified by UclkFmax(in Mhz).
> > > > + *
> > > > + * - Power limit
> > > > + *   The power limit can be increased or descreased by
> > > > + *   OverDrivePct(in percent).
> > >
> > > We already expose the power limit via hwmon.  Do we still need it her=
e?
> > >
> > > > + *
> > > > + * - Fan spped
> > >
> > > spped -> speed
> > >
> > > > + *   The max fan speed can be set by FanMaxinumRpm and the
> > >
> > > FanMaxinumRpm -> FanMaximumRpm
> > >
> > > > + *   min fan speed by FanMinimumPwm. Also zero rpm enablement
> > > > + *   is specified by FanZeroRpmEnable.
> > > > + *
> > > > + * - Temperature
> > > > + *   The fan target temperature can be set by FanTargetTemperature
> > > > + *   and max Tj temperature by MaxOpTemp.
> > >
> > > The fan and temp stuff might be a better fit for the hwmon interfaces=
:
> > > https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface
> > >
> > > > + *
> > > > + */
> > > > +
> > > > +static ssize_t amdgpu_get_pp_od8_settings(struct device *dev,
> > > > +               struct device_attribute *attr,
> > > > +               char *buf)
> > > > +{
> > > > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > > > +       struct amdgpu_device *adev =3D ddev->dev_private;
> > > > +
> > > > +       if (adev->powerplay.pp_funcs->get_od8_settings)
> > > > +               return amdgpu_dpm_get_od8_settings(adev, buf);
> > > > +
> > > > +       return snprintf(buf, PAGE_SIZE, "\n"); }
> > > > +
> > > > +static ssize_t amdgpu_set_pp_od8_settings(struct device *dev,
> > > > +               struct device_attribute *attr,
> > > > +               const char *buf,
> > > > +               size_t count)
> > > > +{
> > > > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > > > +       struct amdgpu_device *adev =3D ddev->dev_private;
> > > > +       char *sub_str, *tmp_str, buf_cpy[128];
> > > > +       const char delimiter[3] =3D {' ', '\n', '\0'};
> > > > +       uint32_t parameter_size =3D 0;
> > > > +       long parameter[64];
> > > > +       int ret =3D 0xff;
> > > > +
> > > > +       if (count >=3D sizeof(buf_cpy) / sizeof(buf_cpy[0]))
> > > > +               return -EINVAL;
> > > > +
> > > > +       memcpy(buf_cpy, buf, count);
> > > > +       buf_cpy[count] =3D '\0';
> > > > +
> > > > +       tmp_str =3D buf_cpy;
> > > > +
> > > > +       while (isspace(*tmp_str)) tmp_str++;
> > > > +
> > > > +       while (tmp_str[0]) {
> > > > +               sub_str =3D strsep(&tmp_str, delimiter);
> > > > +               ret =3D kstrtol(sub_str, 0, &parameter[parameter_si=
ze]);
> > > > +               if (ret)
> > > > +                       return -EINVAL;
> > > > +               parameter_size++;
> > > > +
> > > > +               while (isspace(*tmp_str))
> > > > +                       tmp_str++;
> > > > +       }
> > > > +
> > > > +       if (adev->powerplay.pp_funcs->set_od8_settings)
> > > > +               ret =3D amdgpu_dpm_set_od8_settings(adev, parameter=
,
> > > > + parameter_size);
> > > > +
> > > > +       if (ret)
> > > > +               return -EINVAL;
> > > > +
> > > > +       return count;
> > > > +}
> > > > +
> > > >  static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR,
> > > > amdgpu_get_dpm_state, amdgpu_set_dpm_state);  static
> > > DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_IWUSR,
> > > >                    amdgpu_get_dpm_forced_performance_level,
> > > > @@ -969,6 +1084,9 @@ static DEVICE_ATTR(pp_od_clk_voltage, S_IRUGO
> > > | S_IWUSR,
> > > >                 amdgpu_set_pp_od_clk_voltage);  static
> > > > DEVICE_ATTR(gpu_busy_percent, S_IRUGO,
> > > >                 amdgpu_get_busy_percent, NULL);
> > > > +static DEVICE_ATTR(pp_od8_settings, S_IRUGO | S_IWUSR,
> > > > +               amdgpu_get_pp_od8_settings,
> > > > +               amdgpu_set_pp_od8_settings);
> > >
> > > Rather than adding a new file, would it make more sense to expose thi=
s new
> > > API on the same file we use for older asics?  Otherwise, every time t=
he
> > > interface changes, we'll need to add a new file.  We already handle a=
sic
> > > specific differences in the power profile sysfs files.
> > >
> > > >
> > > >  static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
> > > >                                       struct device_attribute *attr=
,
> > > > @@ -1879,6 +1997,13 @@ int amdgpu_pm_sysfs_init(struct
> > > amdgpu_device *adev)
> > > >                                 "gpu_busy_level\n");
> > > >                 return ret;
> > > >         }
> > > > +       ret =3D device_create_file(adev->dev,
> > > > +                       &dev_attr_pp_od8_settings);
> > > > +       if (ret) {
> > > > +               DRM_ERROR("failed to create device file "
> > > > +                               "pp_od8_settings\n");
> > > > +               return ret;
> > > > +       }
> > > >         ret =3D amdgpu_debugfs_pm_init(adev);
> > > >         if (ret) {
> > > >                 DRM_ERROR("Failed to register debugfs file for
> > > > dpm!\n"); diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface=
.h
> > > > b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > > index 6a41b81c7325..e23746ba53bf 100644
> > > > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > > @@ -269,6 +269,8 @@ struct amd_pm_funcs {
> > > >         int (*get_display_mode_validation_clocks)(void *handle,
> > > >                 struct amd_pp_simple_clock_info *clocks);
> > > >         int (*notify_smu_enable_pwe)(void *handle);
> > > > +       int (*get_od8_settings)(void *handle, char *buf);
> > > > +       int (*set_od8_settings)(void *handle, long *input, uint32_t
> > > > + size);
> > > >  };
> > > >
> > > >  #endif
> > > > diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > > > b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > > > index da4ebff5b74d..4bcd06306698 100644
> > > > --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > > > +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > > > @@ -883,6 +883,41 @@ static int pp_odn_edit_dpm_table(void *handle,
> > > uint32_t type, long *input, uint3
> > > >         return hwmgr->hwmgr_func->odn_edit_dpm_table(hwmgr, type,
> > > > input, size);  }
> > > >
> > > > +static int pp_get_od8_settings(void *handle, char *buf) {
> > > > +       struct pp_hwmgr *hwmgr =3D handle;
> > > > +
> > > > +       if (!hwmgr || !hwmgr->pm_en || !buf)
> > > > +               return -EINVAL;
> > > > +
> > > > +       if (hwmgr->hwmgr_func->get_od8_settings =3D=3D NULL) {
> > > > +               pr_info("%s was not implemented.\n", __func__);
> > > > +               return snprintf(buf, PAGE_SIZE, "\n");
> > > > +       }
> > > > +
> > > > +       return hwmgr->hwmgr_func->get_od8_settings(hwmgr, buf); }
> > > > +
> > > > +static int pp_set_od8_settings(void *handle, long *input, uint32_t
> > > > +size) {
> > > > +       struct pp_hwmgr *hwmgr =3D handle;
> > > > +       int ret =3D -EINVAL;
> > > > +
> > > > +       if (!hwmgr || !hwmgr->pm_en)
> > > > +               return ret;
> > > > +
> > > > +       if (hwmgr->hwmgr_func->set_od8_settings =3D=3D NULL) {
> > > > +               pr_info("%s was not implemented.\n", __func__);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       mutex_lock(&hwmgr->smu_lock);
> > > > +       ret =3D hwmgr->hwmgr_func->set_od8_settings(hwmgr, input, s=
ize);
> > > > +       mutex_unlock(&hwmgr->smu_lock);
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > >  static int pp_dpm_switch_power_profile(void *handle,
> > > >                 enum PP_SMC_POWER_PROFILE type, bool en)  { @@ -127=
2,6
> > > > +1307,8 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D {
> > > >         .get_power_profile_mode =3D pp_get_power_profile_mode,
> > > >         .set_power_profile_mode =3D pp_set_power_profile_mode,
> > > >         .odn_edit_dpm_table =3D pp_odn_edit_dpm_table,
> > > > +       .get_od8_settings =3D pp_get_od8_settings,
> > > > +       .set_od8_settings =3D pp_set_od8_settings,
> > > >         .set_power_limit =3D pp_set_power_limit,
> > > >         .get_power_limit =3D pp_get_power_limit,
> > > >  /* export to DC */
> > > > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > > > b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > > > index fb32b28afa66..ececa2f7fe5f 100644
> > > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > > > @@ -1099,7 +1099,188 @@ static int
> > > vega20_od8_initialize_default_settings(
> > > >         return 0;
> > > >  }
> > > >
> > > > -static int vega20_od8_set_settings(
> > > > +static int vega20_get_od8_settings(
> > > > +               struct pp_hwmgr *hwmgr,
> > > > +               char *buf)
> > > > +{
> > > > +       struct vega20_hwmgr *data =3D
> > > > +                       (struct vega20_hwmgr *)(hwmgr->backend);
> > > > +       struct vega20_od8_single_setting *od8_settings =3D
> > > > +                       data->od8_settings.od8_settings_array;
> > > > +       OverDriveTable_t od_table;
> > > > +       uint32_t size =3D 0;
> > > > +       int ret =3D 0;
> > > > +
> > > > +       if (!buf)
> > > > +               return -EINVAL;
> > > > +
> > > > +       ret =3D vega20_copy_table_from_smc(hwmgr,
> > > > +                       (uint8_t *)(&od_table),
> > > > +                       TABLE_OVERDRIVE);
> > > > +       PP_ASSERT_WITH_CODE(!ret,
> > > > +                       "Failed to export over drive table!",
> > > > +                       return ret);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
, "GfxclkFmin",
> > > > +                               od8_settings[OD8_SETTING_GFXCLK_FMI=
N].min_value,
> > > > +                               od8_settings[OD8_SETTING_GFXCLK_FMI=
N].max_value,
> > > > +                               od_table.GfxclkFmin);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
, "GfxclkFmax",
> > > > +                               od8_settings[OD8_SETTING_GFXCLK_FMA=
X].min_value,
> > > > +                               od8_settings[OD8_SETTING_GFXCLK_FMA=
X].max_value,
> > > > +                               od_table.GfxclkFmax);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_GFXCLK_FREQ1].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
, "GfxclkFreq1",
> > > > +                               od8_settings[OD8_SETTING_GFXCLK_FRE=
Q1].min_value,
> > > > +                               od8_settings[OD8_SETTING_GFXCLK_FRE=
Q1].max_value,
> > > > +                               od_table.GfxclkFreq1);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
,
> > > "GfxclkOffsetVolt1",
> > > > +
> > > od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].min_value,
> > > > +
> > > od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].max_value,
> > > > +                               od_table.GfxclkOffsetVolt1);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_GFXCLK_FREQ2].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
, "GfxclkFreq2",
> > > > +                               od8_settings[OD8_SETTING_GFXCLK_FRE=
Q2].min_value,
> > > > +                               od8_settings[OD8_SETTING_GFXCLK_FRE=
Q2].max_value,
> > > > +                               od_table.GfxclkFreq2);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
,
> > > "GfxclkOffsetVolt2",
> > > > +
> > > od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].min_value,
> > > > +
> > > od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].max_value,
> > > > +                               od_table.GfxclkOffsetVolt2);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_GFXCLK_FREQ3].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
, "GfxclkFreq3",
> > > > +                               od8_settings[OD8_SETTING_GFXCLK_FRE=
Q3].min_value,
> > > > +                               od8_settings[OD8_SETTING_GFXCLK_FRE=
Q3].max_value,
> > > > +                               od_table.GfxclkFreq3);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
,
> > > "GfxclkOffsetVolt3",
> > > > +
> > > od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].min_value,
> > > > +
> > > od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].max_value,
> > > > +                               od_table.GfxclkOffsetVolt3);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
, "UclkFmax",
> > > > +                               od8_settings[OD8_SETTING_UCLK_FMAX]=
.min_value,
> > > > +                               od8_settings[OD8_SETTING_UCLK_FMAX]=
.max_value,
> > > > +                               od_table.UclkFmax);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_POWER_PERCENTAGE].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
, "OverDrivePct",
> > > > +
> > > od8_settings[OD8_SETTING_POWER_PERCENTAGE].min_value,
> > > > +
> > > od8_settings[OD8_SETTING_POWER_PERCENTAGE].max_value,
> > > > +                               od_table.OverDrivePct);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_FAN_ACOUSTIC_LIMIT].feature_id=
)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
,
> > > "FanMaximumRpm",
> > > > +
> > > od8_settings[OD8_SETTING_FAN_ACOUSTIC_LIMIT].min_value,
> > > > +
> > > od8_settings[OD8_SETTING_FAN_ACOUSTIC_LIMIT].max_value,
> > > > +                               od_table.FanMaximumRpm);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_FAN_MIN_SPEED].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
,
> > > "FanMinimumPwm",
> > > > +
> > > od8_settings[OD8_SETTING_FAN_MIN_SPEED].min_value,
> > > > +
> > > od8_settings[OD8_SETTING_FAN_MIN_SPEED].max_value,
> > > > +                               od_table.FanMinimumPwm);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_FAN_TARGET_TEMP].feature_id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
,
> > > "FanTargetTemperautre",
> > > > +
> > > od8_settings[OD8_SETTING_FAN_TARGET_TEMP].min_value,
> > > > +
> > > od8_settings[OD8_SETTING_FAN_TARGET_TEMP].max_value,
> > > > +                               od_table.FanTargetTemperature);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_OPERATING_TEMP_MAX].feature_id=
)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
, "MaxOpTemp",
> > > > +
> > > od8_settings[OD8_SETTING_OPERATING_TEMP_MAX].min_value,
> > > > +
> > > od8_settings[OD8_SETTING_OPERATING_TEMP_MAX].max_value,
> > > > +                               od_table.MaxOpTemp);
> > > > +
> > > > +       if (od8_settings[OD8_SETTING_FAN_ZERO_RPM_CONTROL].feature_=
id)
> > > > +               size +=3D sprintf(buf + size, "%22s[%d - %d]: %u\n"=
,
> > > "FanZeroRpmEnable",
> > > > +
> > > od8_settings[OD8_SETTING_FAN_ZERO_RPM_CONTROL].min_value,
> > > > +
> > > od8_settings[OD8_SETTING_FAN_ZERO_RPM_CONTROL].max_value,
> > > > +                               od_table.FanZeroRpmEnable);
> > > > +
> > > > +       return size;
> > > > +}
> > > > +
> > > > +static int vega20_set_od8_settings(
> > > > +               struct pp_hwmgr *hwmgr,
> > > > +               long *input,
> > > > +               uint32_t size)
> > > > +{
> > > > +       struct vega20_hwmgr *data =3D
> > > > +                       (struct vega20_hwmgr *)(hwmgr->backend);
> > > > +       struct vega20_od8_single_setting *od8_settings =3D
> > > > +                       data->od8_settings.od8_settings_array;
> > > > +       OverDriveTable_t od_table;
> > > > +       uint16_t *buf =3D (uint16_t *)(&od_table);
> > > > +       uint32_t i, j =3D 0, k;
> > > > +       int ret =3D 0;
> > > > +
> > > > +       /* retrieve current overdrive settings */
> > > > +       ret =3D vega20_copy_table_from_smc(hwmgr,
> > > > +                       (uint8_t *)(&od_table),
> > > > +                       TABLE_OVERDRIVE);
> > > > +       PP_ASSERT_WITH_CODE(!ret,
> > > > +                       "Failed to export over drive table!",
> > > > +                       return ret);
> > > > +
> > > > +       for (i =3D 0;
> > > > +            i < (sizeof(OverDriveTable_t) / sizeof(uint16_t)) - 1;
> > > > +            i++) {
> > > > +               /* overdrive table supports no dram timing setting =
*/
> > > > +               k =3D (i =3D=3D OD8_SETTING_AC_TIMING) ?
> > > > +                       OD8_SETTING_FAN_ZERO_RPM_CONTROL : i;
> > > > +               /*
> > > > +                * Not all OD settings are supported and exported
> > > > +                * to user.
> > > > +                * So, updated only those which are supported and
> > > > +                * exported to user.
> > > > +                */
> > > > +               if (od8_settings[k].feature_id) {
> > > > +                       if (input[j] < od8_settings[k].min_value ||
> > > > +                           input[j] > od8_settings[k].max_value)
> > > > +                               return -EINVAL;
> > > > +
> > > > +                       buf[i] =3D input[j];
> > > > +                       if (j++ >=3D size - 1)
> > > > +                               break;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       /* enable the new overdrive settings */
> > > > +       ret =3D vega20_copy_table_to_smc(hwmgr,
> > > > +                       (uint8_t *)(&od_table),
> > > > +                       TABLE_OVERDRIVE);
> > > > +       PP_ASSERT_WITH_CODE(!ret,
> > > > +                       "Failed to import over drive table!",
> > > > +                       return ret);
> > > > +
> > > > +       /* update the current_value of overdrive settings */
> > > > +       for (i =3D 0;
> > > > +            i < (sizeof(OverDriveTable_t) / sizeof(uint16_t)) - 1;
> > > > +            i++) {
> > > > +               k =3D (i =3D=3D OD8_SETTING_AC_TIMING) ?
> > > > +                       OD8_SETTING_FAN_ZERO_RPM_CONTROL : i;
> > > > +               if (od8_settings[k].feature_id)
> > > > +                       od8_settings[k].current_value =3D buf[i];
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int vega20_od8_set_single_setting(
> > > >                 struct pp_hwmgr *hwmgr,
> > > >                 uint32_t index,
> > > >                 uint32_t value)
> > > > @@ -1198,7 +1379,7 @@ static int vega20_set_sclk_od(
> > > >         do_div(od_sclk, 100);
> > > >         od_sclk +=3D
> > > > golden_sclk_table->dpm_levels[golden_sclk_table->count - 1].value;
> > > >
> > > > -       ret =3D vega20_od8_set_settings(hwmgr, OD8_SETTING_GFXCLK_F=
MAX,
> > > od_sclk);
> > > > +       ret =3D vega20_od8_set_single_setting(hwmgr,
> > > > + OD8_SETTING_GFXCLK_FMAX, od_sclk);
> > > >         PP_ASSERT_WITH_CODE(!ret,
> > > >                         "[SetSclkOD] failed to set od gfxclk!",
> > > >                         return ret);
> > > > @@ -1245,7 +1426,7 @@ static int vega20_set_mclk_od(
> > > >         do_div(od_mclk, 100);
> > > >         od_mclk +=3D
> > > > golden_mclk_table->dpm_levels[golden_mclk_table->count - 1].value;
> > > >
> > > > -       ret =3D vega20_od8_set_settings(hwmgr, OD8_SETTING_UCLK_FMA=
X,
> > > od_mclk);
> > > > +       ret =3D vega20_od8_set_single_setting(hwmgr,
> > > > + OD8_SETTING_UCLK_FMAX, od_mclk);
> > > >         PP_ASSERT_WITH_CODE(!ret,
> > > >                         "[SetMclkOD] failed to set od memclk!",
> > > >                         return ret);
> > > > @@ -2966,6 +3147,10 @@ static const struct pp_hwmgr_func
> > > vega20_hwmgr_funcs =3D {
> > > >                 vega20_get_power_profile_mode,
> > > >         .set_power_profile_mode =3D
> > > >                 vega20_set_power_profile_mode,
> > > > +       .get_od8_settings =3D
> > > > +               vega20_get_od8_settings,
> > > > +       .set_od8_settings =3D
> > > > +               vega20_set_od8_settings,
> > > >         /* od related */
> > > >         .set_power_limit =3D
> > > >                 vega20_set_power_limit, diff --git
> > > > a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > > > b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > > > index a6d92128b19c..285af1728e2e 100644
> > > > --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > > > +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > > > @@ -328,6 +328,8 @@ struct pp_hwmgr_func {
> > > >         int (*set_power_limit)(struct pp_hwmgr *hwmgr, uint32_t n);
> > > >         int (*powergate_mmhub)(struct pp_hwmgr *hwmgr);
> > > >         int (*smus_notify_pwe)(struct pp_hwmgr *hwmgr);
> > > > +       int (*get_od8_settings)(struct pp_hwmgr *hwmgr, char *buf);
> > > > +       int (*set_od8_settings)(struct pp_hwmgr *hwmgr, long *input=
,
> > > > + uint32_t size);
> >
> > Those new added interfaces for OD parameters get/set seems have no diff=
erence with the old interface.
> >
> >         int (*print_clock_levels)(struct pp_hwmgr *hwmgr, enum pp_clock=
_type type, char *buf);
> >         int (*odn_edit_dpm_table)(struct pp_hwmgr *hwmgr, enum PP_OD_DP=
M_TABLE_COMMAND type, long *input, uint32_t size);
> >
> > Regards
> > Rex
> > > >  };
> > > >
> > > >  struct pp_table_func {
> > > > --
> > > > 2.18.0
> > > >
> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_SN6PR12MB2656AF86A061B6F37E25267AE4090SN6PR12MB2656namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">I just sent out a new patch which=
 reuses existing APIs. Let's move future discussion there.</p>
<br>
Regards,
<div>Evan<br>
<div>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Wednesday, August 29, 2018 9:12 AM<br>
<b>To:</b> Alex Deucher; Zhu, Rex<br>
<b>Cc:</b> Deucher, Alexander; amd-gfx list; Xu, Feifei; Kuehling, Felix; Z=
hang, Hawking<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: expose vega20 OD features</f=
ont>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3DWindows-1252">
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0"><span>Approach 3 seems not worka=
ble since we do not know the default value.</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span>I would&nbsp;prefer approa=
ch 1 if we have to fit into original APIs. There needs three pairs of &lt;f=
requency, offset&gt; to recalculate the voltage curve.&nbsp;</span><span st=
yle=3D"font-size:12pt">Instead of silently calucating&nbsp;</span><span sty=
le=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&qu=
ot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size=
:14.6667px">dpm_mid_leve=92s
 offset in our driver, i would prefer to have it&nbsp;specified by user.</s=
pan></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">Also, we ma=
y need to update the description for the OD apis to tell
 user the different behaviors on vega20 and previous ASICs.</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"></span></p>
<div>/**</div>
<div>&nbsp;* DOC: pp_od_clk_voltage</div>
<div>&nbsp;*</div>
<div>&nbsp;* The amdgpu driver provides a sysfs API for adjusting the clock=
s and voltages</div>
<div>&nbsp;* in each power level within a power state.&nbsp; The pp_od_clk_=
voltage is used for</div>
<div>&nbsp;* this.</div>
<div>&nbsp;*</div>
<div>&nbsp;* Reading the file will display:</div>
<div>&nbsp;*</div>
<div>&nbsp;* - a list of engine clock levels and voltages labeled OD_SCLK</=
div>
<div>&nbsp;*</div>
<div>&nbsp;* - a list of memory clock levels and voltages labeled OD_MCLK</=
div>
<div>&nbsp;*</div>
<div>&nbsp;* - a list of valid ranges for sclk, mclk, and voltage labeled O=
D_RANGE</div>
<div>&nbsp;*</div>
<div>&nbsp;* To manually adjust these settings, first select manual using</=
div>
<div>&nbsp;* power_dpm_force_performance_level. <i><span style=3D"color:rgb=
(255,0,0)">Enter a new value for each</span></i></div>
<div><i><span style=3D"color:rgb(255,0,0)">&nbsp;* level by writing a strin=
g that contains &quot;s/m level clock voltage&quot; to</span></i></div>
<div><i><span style=3D"color:rgb(255,0,0)">&nbsp;* the file.&nbsp; E.g., &q=
uot;s 1 500 820&quot; will update sclk level 1 to be 500 MHz</span></i></di=
v>
<div><i><span style=3D"color:rgb(255,0,0)">&nbsp;* at 820 mV; &quot;m 0 350=
 810&quot; will update mclk level 0 to be 350 MHz at</span></i></div>
<div><i><span style=3D"color:rgb(255,0,0)">&nbsp;* 810 mV.</span></i>&nbsp;=
 When you have edited all of the states as needed, write</div>
<div>&nbsp;* &quot;c&quot; (commit) to the file to commit your changes.&nbs=
p; If you want to reset to the</div>
<div>&nbsp;* default power levels, write &quot;r&quot; (reset) to the file =
to reset them.</div>
<div>&nbsp;*</div>
<div>&nbsp;*/</div>
<div><br>
</div>
Regards,
<p></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"color:rgb(33,33,3=
3); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">Evan</span>=
</p>
<p style=3D"margin-top:0; margin-bottom:0"><span><span style=3D"color:rgb(3=
3,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe W=
P&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"></spa=
n></span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;al=
exdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, August 29, 2018 1:26:42 AM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> Deucher, Alexander; Quan, Evan; amd-gfx list; Xu, Feifei; Kuehli=
ng, Felix; Zhang, Hawking<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: expose vega20 OD features</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On Tue, Aug 28, 2018 at 12:35 PM Zhu, Rex &lt;Re=
x.Zhu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; Got it. Thanks Alex.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I think we can simplify the od_clk_voltage on vega20.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; When user cat pp_od_clk_voltage<br>
&gt;<br>
&gt; The output can be simplified as:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Sclk:<br>
&gt;<br>
&gt; 0&nbsp; clock_value&nbsp;&nbsp; voltage_offset<br>
&gt;<br>
&gt; 7 clock_value&nbsp;&nbsp;&nbsp; voltage_offset<br>
&gt;<br>
&gt; Mclk<br>
&gt;<br>
&gt; 3&nbsp; mclk_value<br>
&gt;<br>
&gt; Range:<br>
&gt;<br>
&gt; sclk {min, max}<br>
&gt;<br>
&gt; mclk {min, max}<br>
&gt;<br>
&gt; voltage{min, max}<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; for sclk,<br>
&gt;<br>
&gt; user can only set the sclk in dpm level0 and level7, the clock in othe=
r levels will be recalculated by smu automatically based on user=92s settin=
g.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; For voltage, the avfs is enabled, so the voltage in each level is not =
a unique value.<br>
&gt;<br>
&gt; It is reasonable that export voltage offset to user.<br>
&gt;<br>
&gt; The voltage offset is 0 by default.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; The voltage offset in dpm_0, dpm_mid_level, dpm7_level can be configur=
ed.<br>
&gt;<br>
&gt; But in order to keep in consistent with sclk=92s od,<br>
&gt;<br>
&gt; We only let user change the offset in dpm0 and dpm7, for dpm_mid_leve=
=92s offset, we can calculate in driver by (offset0 &#43; offset7)/2.<br>
&gt;<br>
<br>
Seems pretty good.&nbsp; How about something like the following:<br>
<br>
OD_SCLK:<br>
min: clock_value<br>
max: clock_value<br>
OD_MCLK:<br>
max: clock_value<br>
OD_VDDC:<br>
0: clock_value voltage_offset<br>
1: clock_value voltage_offset<br>
2: clock_value voltage_offset<br>
OD_RANGE:<br>
SCLK:&nbsp;&nbsp;&nbsp;&nbsp; clock_value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; clock_value<br>
MCLK:&nbsp;&nbsp;&nbsp;&nbsp; clock_value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; clock_value<br>
VDDC:&nbsp;&nbsp;&nbsp;&nbsp; voltage_value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; voltage_value<br>
<br>
OD_SCLK:<br>
min: 300Mhz<br>
max: 1200Mhz<br>
OD_MCLK:<br>
max: 1500Mhz<br>
OD_VDDC:<br>
0: 300Mhz 0mV<br>
1: 600Mhz 0mV<br>
2: 1200Mhz 0mV<br>
OD_RANGE:<br>
SCLK:&nbsp;&nbsp;&nbsp;&nbsp; 300MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12=
00MHz<br>
MCLK:&nbsp;&nbsp;&nbsp;&nbsp; 300MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15=
00MHz<br>
VDDC:&nbsp;&nbsp;&nbsp;&nbsp; 700mV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1200mV<br>
<br>
That would give you the fullest control.&nbsp; Alternatively, we could<br>
simplify this a bit by deriving the mid point in the voltage curve.<br>
E.g.,<br>
<br>
OD_SCLK:<br>
min: clock_value<br>
max: clock_value<br>
OD_MCLK:<br>
max: clock_value<br>
OD_VDDC:<br>
min: clock_value voltage_offset<br>
max: clock_value voltage_offset<br>
OD_RANGE:<br>
SCLK:&nbsp;&nbsp;&nbsp;&nbsp; clock_value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; clock_value<br>
MCLK:&nbsp;&nbsp;&nbsp;&nbsp; clock_value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; clock_value<br>
VDDC:&nbsp;&nbsp;&nbsp;&nbsp; voltage_value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; voltage_value<br>
<br>
OD_SCLK:<br>
min: 300Mhz<br>
max: 1200Mhz<br>
OD_MCLK:<br>
max 1500Mhz<br>
OD_VDDC:<br>
min: 300Mhz 0mV<br>
max: 1200Mhz 0mV<br>
OD_RANGE:<br>
SCLK:&nbsp;&nbsp;&nbsp;&nbsp; 300MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12=
00MHz<br>
MCLK:&nbsp;&nbsp;&nbsp;&nbsp; 300MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15=
00MHz<br>
VDDC:&nbsp;&nbsp;&nbsp;&nbsp; 700mV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1200mV<br>
<br>
I think we could also make the interface backwards compatible.&nbsp; E.g.,<=
br>
<br>
OD_SCLK:<br>
0 300Mhz 900mV<br>
7 1200Mhz 1000mV<br>
OD_MCLK:<br>
3 1500Mhz 900mV<br>
OD_RANGE:<br>
SCLK:&nbsp;&nbsp;&nbsp;&nbsp; 300MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12=
00MHz<br>
MCLK:&nbsp;&nbsp;&nbsp;&nbsp; 300MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15=
00MHz<br>
VDDC:&nbsp;&nbsp;&nbsp;&nbsp; 700mV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1200mV<br>
<br>
We can ignore the voltage for OD_MCLK and then calculate the offsets<br>
based on the absolute value specified in OD_SCLK (e.g., default value<br>
- specified value =3D offset), then calculate the midpoint based on the<br>
end points.&nbsp; It would be backwards compatible, but somewhat more<br>
confusing for users.&nbsp; Probably one of the first two would be better.<b=
r>
Thoughts?<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt;<br>
&gt; For mclk,<br>
&gt;<br>
&gt; Smu just let us change the max clock in dpm3(high level). And the mclk=
 in other dpm levels can not be changed.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Any concerns?<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Best Regards<br>
&gt;<br>
&gt; Rex<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: Deucher, Alexander<br>
&gt; Sent: Wednesday, August 29, 2018 12:03 AM<br>
&gt; To: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Alex Deucher &lt;alexdeucher=
@gmail.com&gt;<br>
&gt; Cc: Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx list &lt;amd-gfx@lists.f=
reedesktop.org&gt;; Xu, Feifei &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;; Kuehling, Felix &=
lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
&gt; Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Right.&nbsp; I'm saying use the same sysfs file (pp_od_clk_voltage) fo=
r all devices rather than adding a new one.&nbsp; The output of reading tha=
t file will be different on each asic that supports a different way of adju=
sting the clock and voltage parameters and the
 supported inputs will be different.&nbsp; We do the same thing today for p=
p_power_profile_mode.&nbsp; Vega10 and smu7 parts have different parameters=
, but we use the same files.&nbsp; See the attached patch to an example.<br=
>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: Quan, Evan<br>
&gt; Sent: Tuesday, August 28, 2018 11:51:16 AM<br>
&gt; To: Alex Deucher<br>
&gt; Cc: Zhu, Rex; Deucher, Alexander; amd-gfx list; Xu, Feifei; Kuehling, =
Felix; Zhang, Hawking<br>
&gt; Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Alex,<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Sorry, i cannot get your point.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; The OD feature sysfs file used by previous ASICs is &quot;pp_od_clk_vo=
ltage&quot;. And it binds to two APIs &quot;amdgpu_get_pp_od_clk_voltage&qu=
ot; and &quot;amdgpu_set_pp_od_clk_voltage&quot;.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; static DEVICE_ATTR(pp_od_clk_voltage, S_IRUGO | S_IWUSR,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_od_clk_voltage,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_od_clk_voltage);<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I was saying we cannot reuse these two APIs for vega20 since we have n=
o way to know the exact voltage value for each dpm level(that is what these=
 two APIs required). Thus we cannot share the same sysfs file.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Do you mean we can bind the sysfs file to other APIs? How?<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Evan<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; Sent: Monday, August 27, 2018 10:01:49 PM<br>
&gt; To: Quan, Evan<br>
&gt; Cc: Zhu, Rex; Deucher, Alexander; amd-gfx list; Xu, Feifei; Kuehling, =
Felix; Zhang, Hawking<br>
&gt; Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD features<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Aug 27, 2018 at 12:04 AM Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt; =
wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi @Deucher, Alexander &amp; @Zhu, Rex,<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I can remove the od setings for power limit and fan speed related=
 since they seem redundant with other sysfs apis.<br>
&gt; &gt;<br>
&gt; &gt; But for the clock/voltage related, i can not see how to reuse old=
 pp_od_clk_voltage APIs.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; For the old pp_od_clk_voltage APIs,<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; 1. they output/input the voltages in their exact values. E.=
g. &quot;s 1 500 820&quot; will update sclk level 1 to be 500 MHz at 820 mV=
<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; But for vega20, we did not know its=
 original voltage value. The output/input for voltage are just offest from =
its original value.<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; So, if&nbsp; to reuse these APIs, w=
e will make them have two different explanations(<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; on vega20 or later, the voltage is =
offset. On previous ASICs, the voltage is exact value). I think that will c=
onfuse the users.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; 2. they support voltage set for each level. But for vega20,=
 it supports only three pairs of clock/voltage set. And per suggestion,<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; these three pairs should be: voltag=
e offset of minimum clock level, voltage offset for middle clock level&nbsp=
; and voltage offset<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for maximum clock level.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Also, i believe the future ASICs will also take the vega20 OD way=
s(that is we need the offset, not the exact value for voltage).<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; So, based on previous considerations, i decide to have new APIs i=
nstead of reusing existing ones.<br>
&gt;<br>
&gt; I'm not saying to use the same API.&nbsp; Use the new API, but expose =
the<br>
&gt; API using the same sysfs file rather than adding a new one.&nbsp; Same=
 way<br>
&gt; we handle the power profiles; E.g., the API is different between smu7<=
br>
&gt; and vega10, but they both use the same sysfs file.<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt;<br>
&gt; &gt; Evan<br>
&gt; &gt;<br>
&gt; &gt; ________________________________<br>
&gt; &gt; From: Zhu, Rex<br>
&gt; &gt; Sent: Saturday, August 25, 2018 12:32 AM<br>
&gt; &gt; To: Alex Deucher; Quan, Evan<br>
&gt; &gt; Cc: amd-gfx list; Xu, Feifei; Kuehling, Felix; Deucher, Alexander=
; Zhang, Hawking<br>
&gt; &gt; Subject: RE: [PATCH] drm/amd/powerplay: expose vega20 OD features=
<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; &gt; &gt; Sent: Friday, August 24, 2018 11:48 PM<br>
&gt; &gt; &gt; To: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; &gt; Cc: amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Xu, =
Feifei<br>
&gt; &gt; &gt; &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;; Kuehling, Felix &lt;Felix.Kuehlin=
g@amd.com&gt;; Deucher,<br>
&gt; &gt; &gt; Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Zhu, Rex &lt;Re=
x.Zhu-5C7GfCeVMHo@public.gmane.org&gt;;<br>
&gt; &gt; &gt; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; &gt; Subject: Re: [PATCH] drm/amd/powerplay: expose vega20 OD fea=
tures<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Fri, Aug 24, 2018 at 3:45 AM Evan Quan &lt;evan.quan@amd.=
com&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Vega20 simplifies the OD logics and it can not fit old =
OD interfaces.<br>
&gt; &gt; &gt; &gt; Thus we design new OD interfaces for vega20.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please split this into two patches, one to add the internal =
od8_settings API,<br>
&gt; &gt; &gt; and one to wire it up to sysfs.&nbsp; A few more comments be=
low.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Change-Id: I888faec46a81287ae24f452ce16b42c1f6d06d7d<br=
>
&gt; &gt; &gt; &gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 &#43;<br>
&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 125 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;<br>
&gt; &gt; &gt; &gt;&nbsp; .../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 &#43;<br>
&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c |&n=
bsp; 37 &#43;&#43;&#43;&#43;<br>
&gt; &gt; &gt; &gt;&nbsp; .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&=
nbsp;&nbsp; | 191<br>
&gt; &gt; &gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;-<br>
&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 &#43;<br>
&gt; &gt; &gt; &gt;&nbsp; 6 files changed, 362 insertions(&#43;), 3 deletio=
ns(-)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br=
>
&gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&gt; &gt; &gt; &gt; index ff24e1cc5b65..84b3e6f87abf 100644<br>
&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm=
.h<br>
&gt; &gt; &gt; &gt; @@ -357,6 &#43;357,14 @@ enum amdgpu_pcie_gen {<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt=
;odn_edit_dpm_table(\<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (adev)-&gt;powerplay.pp_handle, type, parameter,<br>
&gt; &gt; &gt; &gt; size))<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &#43;#define amdgpu_dpm_get_od8_settings(adev, buf) \<b=
r>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;get_o=
d8_settings(\<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev)-&gt;powerplay.pp_handle, buf))<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;#define amdgpu_dpm_set_od8_settings(adev, paramete=
r, size) \<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_o=
d8_settings(\<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev)-&gt;powerplay.pp_handle, parameter, size))<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt;&nbsp; struct amdgpu_dpm {<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_ps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ps;<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* numb=
er of valid power states */ diff --git<br>
&gt; &gt; &gt; &gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; &gt; index daa55fb06171..94cd7c503372 100644<br>
&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.=
c<br>
&gt; &gt; &gt; &gt; @@ -934,6 &#43;934,121 @@ static ssize_t amdgpu_get_bus=
y_percent(struct<br>
&gt; &gt; &gt; device *dev,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
snprintf(buf, PAGE_SIZE, &quot;%d\n&quot;, value);&nbsp; }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &#43;/**<br>
&gt; &gt; &gt; &gt; &#43; * DOC: pp_od8_settings<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * The amdgpu driver provides a sysfs API for adju=
sting the clocks,<br>
&gt; &gt; &gt; &gt; &#43;voltages,<br>
&gt; &gt; &gt; &gt; &#43; * power limit, fan speed and temperature. The pp_=
od8_settings is<br>
&gt; &gt; &gt; &gt; &#43;used for<br>
&gt; &gt; &gt; &gt; &#43; * this.<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * Reading the file will display:<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - a name list of the features that are able to =
be adjusted<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - the mininum and maximum allowed value for eac=
h supported<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; feature labeled in format of &quot;=
[mininum - maximum]&quot;<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - the current value for each supported feature =
labeled after<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; &quot;:&quot;<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * To manually adjust these settings:<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - write a string that contains the new value fo=
r each supported<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; feature. For those which do not nee=
d to be changed, just enter<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; their old value<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - make sure the new value is within the allowed=
 ranges between<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; the minimum and maximum<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; We should probably also make it a set and commit model like =
we do for<br>
&gt; &gt; &gt; previous asics for consistency.&nbsp; That way you can see t=
he changes, and then<br>
&gt; &gt; &gt; apply them.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * All the possible supported features:<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - Gfx clock<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; The min and max frequency can be sp=
ecified by GfxclkFmin<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; and GfxclkFmax(both in Mhz). Interm=
ediate levels are<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; stretched/shrunk according to ratio=
 in original table.<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - Gfx voltage<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; With three pairs of gfx clk(in Mhz)=
 and offset voltage(in mV)<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; combinations specified, smu fw can =
calibrate the voltage<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; curve automatically.<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp;&nbsp;&nbsp; - GfxclkFreq1 &lt;-&gt;=
 GfxclkOffsetVolt1<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp;&nbsp;&nbsp; - GfxclkFreq2 &lt;-&gt;=
 GfxclkOffsetVolt2<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp;&nbsp;&nbsp; - GfxclkFreq3 &lt;-&gt;=
 GfxclkOffsetVolt3<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - Uclk<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; The max memory clock can be specifi=
ed by UclkFmax(in Mhz).<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - Power limit<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; The power limit can be increased or=
 descreased by<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; OverDrivePct(in percent).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; We already expose the power limit via hwmon.&nbsp; Do we sti=
ll need it here?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - Fan spped<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; spped -&gt; speed<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; The max fan speed can be set by Fan=
MaxinumRpm and the<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; FanMaxinumRpm -&gt; FanMaximumRpm<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; min fan speed by FanMinimumPwm. Als=
o zero rpm enablement<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; is specified by FanZeroRpmEnable.<b=
r>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; * - Temperature<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; The fan target temperature can be s=
et by FanTargetTemperature<br>
&gt; &gt; &gt; &gt; &#43; *&nbsp;&nbsp; and max Tj temperature by MaxOpTemp=
.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The fan and temp stuff might be a better fit for the hwmon i=
nterfaces:<br>
&gt; &gt; &gt; <a href=3D"https://www.kernel.org/doc/Documentation/hwmon/sy=
sfs-interface" id=3D"LPlnk955600" class=3D"OWAAutoLink" previewremoved=3D"t=
rue">
https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &gt; &#43; */<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;static ssize_t amdgpu_get_pp_od8_settings(struct d=
evice *dev,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &gt; &gt; &gt; &#43;{<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_de=
vice *ddev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu=
_device *adev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;=
powerplay.pp_funcs-&gt;get_od8_settings)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_dpm_get_od8_settings(adev,=
 buf);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprin=
tf(buf, PAGE_SIZE, &quot;\n&quot;); }<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;static ssize_t amdgpu_set_pp_od8_settings(struct d=
evice *dev,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count)<br>
&gt; &gt; &gt; &gt; &#43;{<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_de=
vice *ddev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu=
_device *adev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *sub_str=
, *tmp_str, buf_cpy[128];<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char de=
limiter[3] =3D {' ', '\n', '\0'};<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t para=
meter_size =3D 0;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long paramete=
r[64];<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0=
xff;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (count &gt=
;=3D sizeof(buf_cpy) / sizeof(buf_cpy[0]))<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf_cp=
y, buf, count);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_cpy[count=
] =3D '\0';<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_str =3D b=
uf_cpy;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (isspac=
e(*tmp_str)) tmp_str&#43;&#43;;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (tmp_st=
r[0]) {<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_str =3D strsep(&amp;tmp_str, delimit=
er);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kstrtol(sub_str, 0, &amp;paramet=
er[parameter_size]);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parameter_size&#43;&#43;;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (isspace(*tmp_str))<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; tmp_str&#43;&#43;;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;=
powerplay.pp_funcs-&gt;set_od8_settings)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_od8_settings(adev=
, parameter,<br>
&gt; &gt; &gt; &gt; &#43; parameter_size);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;=
<br>
&gt; &gt; &gt; &gt; &#43;}<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt;&nbsp; static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_I=
WUSR,<br>
&gt; &gt; &gt; &gt; amdgpu_get_dpm_state, amdgpu_set_dpm_state);&nbsp; stat=
ic<br>
&gt; &gt; &gt; DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_I=
WUSR,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_dpm_f=
orced_performance_level,<br>
&gt; &gt; &gt; &gt; @@ -969,6 &#43;1084,9 @@ static DEVICE_ATTR(pp_od_clk_v=
oltage, S_IRUGO<br>
&gt; &gt; &gt; | S_IWUSR,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_od_clk_voltage);&nbs=
p; static<br>
&gt; &gt; &gt; &gt; DEVICE_ATTR(gpu_busy_percent, S_IRUGO,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_busy_percent, NULL);<br=
>
&gt; &gt; &gt; &gt; &#43;static DEVICE_ATTR(pp_od8_settings, S_IRUGO | S_IW=
USR,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_od8_settings,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_od8_settings);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Rather than adding a new file, would it make more sense to e=
xpose this new<br>
&gt; &gt; &gt; API on the same file we use for older asics?&nbsp; Otherwise=
, every time the<br>
&gt; &gt; &gt; interface changes, we'll need to add a new file.&nbsp; We al=
ready handle asic<br>
&gt; &gt; &gt; specific differences in the power profile sysfs files.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&nbsp; static ssize_t amdgpu_hwmon_show_temp(struct devi=
ce *dev,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &gt; &gt; &gt; @@ -1879,6 &#43;1997,13 @@ int amdgpu_pm_sysfs_init(str=
uct<br>
&gt; &gt; &gt; amdgpu_device *adev)<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;gpu_bus=
y_level\n&quot;);<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D devic=
e_create_file(adev-&gt;dev,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &amp;dev_attr_pp_od8_settings);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br=
>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device =
file &quot;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_od8_settin=
gs\n&quot;);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 amdgpu_debugfs_pm_init(adev);<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret=
) {<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to register=
 debugfs file for<br>
&gt; &gt; &gt; &gt; dpm!\n&quot;); diff --git a/drivers/gpu/drm/amd/include=
/kgd_pp_interface.h<br>
&gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &gt; &gt; &gt; index 6a41b81c7325..e23746ba53bf 100644<br>
&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br=
>
&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_in=
terface.h<br>
&gt; &gt; &gt; &gt; @@ -269,6 &#43;269,8 @@ struct amd_pm_funcs {<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*g=
et_display_mode_validation_clocks)(void *handle,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock_info *c=
locks);<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*n=
otify_smu_enable_pwe)(void *handle);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_od8=
_settings)(void *handle, char *buf);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_od8=
_settings)(void *handle, long *input, uint32_t<br>
&gt; &gt; &gt; &gt; &#43; size);<br>
&gt; &gt; &gt; &gt;&nbsp; };<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&nbsp; #endif<br>
&gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerpla=
y.c<br>
&gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &gt; &gt; &gt; index da4ebff5b74d..4bcd06306698 100644<br>
&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_pow=
erplay.c<br>
&gt; &gt; &gt; &gt; @@ -883,6 &#43;883,41 @@ static int pp_odn_edit_dpm_tab=
le(void *handle,<br>
&gt; &gt; &gt; uint32_t type, long *input, uint3<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
hwmgr-&gt;hwmgr_func-&gt;odn_edit_dpm_table(hwmgr, type,<br>
&gt; &gt; &gt; &gt; input, size);&nbsp; }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &#43;static int pp_get_od8_settings(void *handle, char =
*buf) {<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwm=
gr *hwmgr =3D handle;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr ||=
 !hwmgr-&gt;pm_en || !buf)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt=
;hwmgr_func-&gt;get_od8_settings =3D=3D NULL) {<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&=
quot;, __func__);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n=
&quot;);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-=
&gt;hwmgr_func-&gt;get_od8_settings(hwmgr, buf); }<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;static int pp_set_od8_settings(void *handle, long =
*input, uint32_t<br>
&gt; &gt; &gt; &gt; &#43;size) {<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwm=
gr *hwmgr =3D handle;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -=
EINVAL;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr ||=
 !hwmgr-&gt;pm_en)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt=
;hwmgr_func-&gt;set_od8_settings =3D=3D NULL) {<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&=
quot;, __func__);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&a=
mp;hwmgr-&gt;smu_lock);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr=
-&gt;hwmgr_func-&gt;set_od8_settings(hwmgr, input, size);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(=
&amp;hwmgr-&gt;smu_lock);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<b=
r>
&gt; &gt; &gt; &gt; &#43;}<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt;&nbsp; static int pp_dpm_switch_power_profile(void *hand=
le,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_SMC_POWER_PROFILE type, bo=
ol en)&nbsp; { @@ -1272,6<br>
&gt; &gt; &gt; &gt; &#43;1307,8 @@ static const struct amd_pm_funcs pp_dpm_=
funcs =3D {<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_po=
wer_profile_mode =3D pp_get_power_profile_mode,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_po=
wer_profile_mode =3D pp_set_power_profile_mode,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .odn_ed=
it_dpm_table =3D pp_odn_edit_dpm_table,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_od8_sett=
ings =3D pp_get_od8_settings,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_od8_sett=
ings =3D pp_set_od8_settings,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_po=
wer_limit =3D pp_set_power_limit,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_po=
wer_limit =3D pp_get_power_limit,<br>
&gt; &gt; &gt; &gt;&nbsp; /* export to DC */<br>
&gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20=
_hwmgr.c<br>
&gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br=
>
&gt; &gt; &gt; &gt; index fb32b28afa66..ececa2f7fe5f 100644<br>
&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.=
c<br>
&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/v=
ega20_hwmgr.c<br>
&gt; &gt; &gt; &gt; @@ -1099,7 &#43;1099,188 @@ static int<br>
&gt; &gt; &gt; vega20_od8_initialize_default_settings(<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;<br>
&gt; &gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -static int vega20_od8_set_settings(<br>
&gt; &gt; &gt; &gt; &#43;static int vega20_get_od8_settings(<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &gt; &gt; &gt; &#43;{<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20=
_hwmgr *data =3D<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (struct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20=
_od8_single_setting *od8_settings =3D<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;od8_settings.od8_settings_array;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTabl=
e_t od_table;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size=
 =3D 0;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0=
;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!buf)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega2=
0_copy_table_from_smc(hwmgr,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (uint8_t *)(&amp;od_table),<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; TABLE_OVERDRIVE);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WIT=
H_CODE(!ret,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &quot;Failed to export over drive table!&quot;,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_GFXCLK_FMIN].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;, &quot;GfxclkFmin&quot;,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_GFXCLK_FMIN].min_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_GFXCLK_FMIN].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkFmin=
);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_GFXCLK_FMAX].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;, &quot;GfxclkFmax&quot;,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_GFXCLK_FMAX].min_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_GFXCLK_FMAX].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkFmax=
);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_GFXCLK_FREQ1].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;, &quot;GfxclkFreq1&quot;,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_GFXCLK_FREQ1].min_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_GFXCLK_FREQ1].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkFreq=
1);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;,<br>
&gt; &gt; &gt; &quot;GfxclkOffsetVolt1&quot;,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].min_value,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkOffs=
etVolt1);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_GFXCLK_FREQ2].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;, &quot;GfxclkFreq2&quot;,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_GFXCLK_FREQ2].min_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_GFXCLK_FREQ2].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkFreq=
2);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;,<br>
&gt; &gt; &gt; &quot;GfxclkOffsetVolt2&quot;,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].min_value,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkOffs=
etVolt2);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_GFXCLK_FREQ3].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;, &quot;GfxclkFreq3&quot;,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_GFXCLK_FREQ3].min_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_GFXCLK_FREQ3].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkFreq=
3);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;,<br>
&gt; &gt; &gt; &quot;GfxclkOffsetVolt3&quot;,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].min_value,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.GfxclkOffs=
etVolt3);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_UCLK_FMAX].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;, &quot;UclkFmax&quot;,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_UCLK_FMAX].min_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SE=
TTING_UCLK_FMAX].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.UclkFmax);=
<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_POWER_PERCENTAGE].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;, &quot;OverDrivePct&quot;,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_POWER_PERCENTAGE].min_value,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_POWER_PERCENTAGE].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.OverDriveP=
ct);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_FAN_ACOUSTIC_LIMIT].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;,<br>
&gt; &gt; &gt; &quot;FanMaximumRpm&quot;,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_FAN_ACOUSTIC_LIMIT].min_value,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_FAN_ACOUSTIC_LIMIT].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.FanMaximum=
Rpm);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_FAN_MIN_SPEED].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;,<br>
&gt; &gt; &gt; &quot;FanMinimumPwm&quot;,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_FAN_MIN_SPEED].min_value,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_FAN_MIN_SPEED].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.FanMinimum=
Pwm);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_FAN_TARGET_TEMP].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;,<br>
&gt; &gt; &gt; &quot;FanTargetTemperautre&quot;,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_FAN_TARGET_TEMP].min_value,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_FAN_TARGET_TEMP].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.FanTargetT=
emperature);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_OPERATING_TEMP_MAX].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;, &quot;MaxOpTemp&quot;,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_OPERATING_TEMP_MAX].min_value,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_OPERATING_TEMP_MAX].max_value,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.MaxOpTemp)=
;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_setti=
ngs[OD8_SETTING_FAN_ZERO_RPM_CONTROL].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &q=
uot;%22s[%d - %d]: %u\n&quot;,<br>
&gt; &gt; &gt; &quot;FanZeroRpmEnable&quot;,<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_FAN_ZERO_RPM_CONTROL].min_value,<br=
>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; od8_settings[OD8_SETTING_FAN_ZERO_RPM_CONTROL].max_value,<br=
>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table.FanZeroRpm=
Enable);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<=
br>
&gt; &gt; &gt; &gt; &#43;}<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;static int vega20_set_od8_settings(<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long *input,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size)<br>
&gt; &gt; &gt; &gt; &#43;{<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20=
_hwmgr *data =3D<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (struct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20=
_od8_single_setting *od8_settings =3D<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;od8_settings.od8_settings_array;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTabl=
e_t od_table;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t *buf=
 =3D (uint16_t *)(&amp;od_table);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, j=
 =3D 0, k;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0=
;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* retrieve c=
urrent overdrive settings */<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega2=
0_copy_table_from_smc(hwmgr,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (uint8_t *)(&amp;od_table),<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; TABLE_OVERDRIVE);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WIT=
H_CODE(!ret,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &quot;Failed to export over drive table!&quot;,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0;=
<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; i &lt; (sizeof(OverDriveTable_t) / sizeof(uint16_t)) - 1;<=
br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; i&#43;&#43;) {<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* overdrive table supports no dram timi=
ng setting */<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k =3D (i =3D=3D OD8_SETTING_AC_TIMING) ?=
<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; OD8_SETTING_FAN_ZERO_RPM_CONTROL : i;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Not all OD settings are supporte=
d and exported<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to user.<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * So, updated only those which are=
 supported and<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * exported to user.<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[k].feature_id) {<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (input[j] &lt; od8_settings[k].min_value ||<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; input[j] &gt; od8_settings[k].max_value)<br=
>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; buf[i] =3D input[j];<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (j&#43;&#43; &gt;=3D size - 1)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable the=
 new overdrive settings */<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega2=
0_copy_table_to_smc(hwmgr,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (uint8_t *)(&amp;od_table),<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; TABLE_OVERDRIVE);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WIT=
H_CODE(!ret,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &quot;Failed to import over drive table!&quot;,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret);<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update the=
 current_value of overdrive settings */<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0;=
<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; i &lt; (sizeof(OverDriveTable_t) / sizeof(uint16_t)) - 1;<=
br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; i&#43;&#43;) {<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k =3D (i =3D=3D OD8_SETTING_AC_TIMING) ?=
<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; OD8_SETTING_FAN_ZERO_RPM_CONTROL : i;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (od8_settings[k].feature_id)<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; od8_settings[k].current_value =3D buf[i];<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt; &gt; &#43;}<br>
&gt; &gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &gt; &#43;static int vega20_od8_set_single_setting(<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value)<br>
&gt; &gt; &gt; &gt; @@ -1198,7 &#43;1379,7 @@ static int vega20_set_sclk_od=
(<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_div(=
od_sclk, 100);<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_sclk=
 &#43;=3D<br>
&gt; &gt; &gt; &gt; golden_sclk_table-&gt;dpm_levels[golden_sclk_table-&gt;=
count - 1].value;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_od=
8_set_settings(hwmgr, OD8_SETTING_GFXCLK_FMAX,<br>
&gt; &gt; &gt; od_sclk);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega2=
0_od8_set_single_setting(hwmgr,<br>
&gt; &gt; &gt; &gt; &#43; OD8_SETTING_GFXCLK_FMAX, od_sclk);<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSE=
RT_WITH_CODE(!ret,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &quot;[SetSclkOD] failed to set od gfxclk!&quot;,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return ret);<br>
&gt; &gt; &gt; &gt; @@ -1245,7 &#43;1426,7 @@ static int vega20_set_mclk_od=
(<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_div(=
od_mclk, 100);<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_mclk=
 &#43;=3D<br>
&gt; &gt; &gt; &gt; golden_mclk_table-&gt;dpm_levels[golden_mclk_table-&gt;=
count - 1].value;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_od=
8_set_settings(hwmgr, OD8_SETTING_UCLK_FMAX,<br>
&gt; &gt; &gt; od_mclk);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega2=
0_od8_set_single_setting(hwmgr,<br>
&gt; &gt; &gt; &gt; &#43; OD8_SETTING_UCLK_FMAX, od_mclk);<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSE=
RT_WITH_CODE(!ret,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &quot;[SetMclkOD] failed to set od memclk!&quot;,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return ret);<br>
&gt; &gt; &gt; &gt; @@ -2966,6 &#43;3147,10 @@ static const struct pp_hwmgr=
_func<br>
&gt; &gt; &gt; vega20_hwmgr_funcs =3D {<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_get_power_profile_mode,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_po=
wer_profile_mode =3D<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_set_power_profile_mode,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_od8_sett=
ings =3D<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_get_od8_settings,<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_od8_sett=
ings =3D<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_set_od8_settings,<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* od r=
elated */<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_po=
wer_limit =3D<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_set_power_limit, diff --git=
<br>
&gt; &gt; &gt; &gt; a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; &gt; &gt; index a6d92128b19c..285af1728e2e 100644<br>
&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwm=
gr.h<br>
&gt; &gt; &gt; &gt; @@ -328,6 &#43;328,8 @@ struct pp_hwmgr_func {<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*s=
et_power_limit)(struct pp_hwmgr *hwmgr, uint32_t n);<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*p=
owergate_mmhub)(struct pp_hwmgr *hwmgr);<br>
&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*s=
mus_notify_pwe)(struct pp_hwmgr *hwmgr);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_od8=
_settings)(struct pp_hwmgr *hwmgr, char *buf);<br>
&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_od8=
_settings)(struct pp_hwmgr *hwmgr, long *input,<br>
&gt; &gt; &gt; &gt; &#43; uint32_t size);<br>
&gt; &gt;<br>
&gt; &gt; Those new added interfaces for OD parameters get/set seems have n=
o difference with the old interface.<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*print_clock=
_levels)(struct pp_hwmgr *hwmgr, enum pp_clock_type type, char *buf);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*odn_edit_dp=
m_table)(struct pp_hwmgr *hwmgr, enum PP_OD_DPM_TABLE_COMMAND type, long *i=
nput, uint32_t size);<br>
&gt; &gt;<br>
&gt; &gt; Regards<br>
&gt; &gt; Rex<br>
&gt; &gt; &gt; &gt;&nbsp; };<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&nbsp; struct pp_table_func {<br>
&gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; 2.18.0<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; &gt; amd-gfx mailing list<br>
&gt; &gt; &gt; &gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; &gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listin=
fo/amd-gfx" id=3D"LPlnk661557" class=3D"OWAAutoLink" previewremoved=3D"true=
">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SN6PR12MB2656AF86A061B6F37E25267AE4090SN6PR12MB2656namp_--

--===============1976688323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1976688323==--
