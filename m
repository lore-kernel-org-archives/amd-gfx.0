From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: support retrieving and adjusting
 dcefclock power levels
Date: Tue, 15 Jan 2019 15:19:08 +0000
Message-ID: <BN6PR12MB180954E02C7F4F12A5654723F7810@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190114100142.16922-1-evan.quan@amd.com>
 <20190114100142.16922-4-evan.quan@amd.com>
 <CADnq5_MQg0z6FCH-3UQCXtLEOdtsS2vQ-YXvgWDNBGoyOSaFbw@mail.gmail.com>
 <SN6PR12MB265648F3ACAE6F52278858D3E4810@SN6PR12MB2656.namprd12.prod.outlook.com>,
 <SN6PR12MB26560F7F273E30EBFECE50EFE4810@SN6PR12MB2656.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1268493895=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB26560F7F273E30EBFECE50EFE4810-kxOKjb6HO/FeL/N0e1LXkAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1268493895==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180954E02C7F4F12A5654723F7810BN6PR12MB1809namp_"

--_000_BN6PR12MB180954E02C7F4F12A5654723F7810BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Seems reasonable to me.  With those changes,

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Quan, Evan
Sent: Tuesday, January 15, 2019 1:59:42 AM
To: Alex Deucher
Cc: amd-gfx list; Deucher, Alexander
Subject: RE: [PATCH 4/4] drm/amd/powerplay: support retrieving and adjustin=
g dcefclock power levels

For ppfeatures, it will be seen only if (adev->asic_type >=3D CHIP_VEGA10 &=
& !APU).

Regards,
Evan
> -----Original Message-----
> From: Quan, Evan
> Sent: Tuesday, January 15, 2019 2:44 PM
> To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Deucher, Alexander
> <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> Subject: RE: [PATCH 4/4] drm/amd/powerplay: support retrieving and
> adjusting dcefclock power levels
>
> I think we can use asic_type to determine whether to expose these new
> interfaces.
> If (adev->asic_type >=3D CHIP_VEGA10), socclk and dcefclk are OK to expos=
e If
> (adev->asic_type >=3D CHIP_VEGA20), fclk is OK to expose
>
> Regards,
> Evan
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Sent: Tuesday, January 15, 2019 1:00 AM
> > To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> > Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Deucher, Alexander
> > <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> > Subject: Re: [PATCH 4/4] drm/amd/powerplay: support retrieving and
> > adjusting dcefclock power levels
> >
> > On Mon, Jan 14, 2019 at 5:02 AM Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org> wrote:
> > >
> > > User can use "pp_dpm_dcefclk" to retrieve and adjust dcefclock power
> > > levels.
> > >
> > > Change-Id: Ia3f61558ca96104c88d129ba5194103b2fe702ec
> > > Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> >
> > We should probably find a way to hide these new files on asics which
> > don't support them.  Other than that, the series looks good to me.
> >
> > Alex
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        | 53
> > ++++++++++++++++++-
> > >  .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
> > >  .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 52
> > +++++++++++++++++-
> > >  3 files changed, 103 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > index f6646a522c06..b7b70f590236 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > @@ -731,11 +731,13 @@ static ssize_t
> > > amdgpu_get_ppfeature_status(struct device *dev,  }
> > >
> > >  /**
> > > - * DOC: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk
> > pp_dpm_pcie
> > > + * DOC: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk
> > > + pp_dpm_dcefclk
> > > + * pp_dpm_pcie
> > >   *
> > >   * The amdgpu driver provides a sysfs API for adjusting what power
> levels
> > >   * are enabled for a given power state.  The files pp_dpm_sclk,
> > > pp_dpm_mclk,
> > > - * pp_dpm_socclk, pp_dpm_fclk and pp_dpm_pcie are used for this.
> > > + * pp_dpm_socclk, pp_dpm_fclk, pp_dpm_dcefclk and pp_dpm_pcie
> are
> > > + used for
> > > + * this.
> > >   *
> > >   * Reading back the files will show you the available power levels w=
ithin
> > >   * the power state and the clock information for those levels.
> > > @@ -745,6 +747,8 @@ static ssize_t
> > > amdgpu_get_ppfeature_status(struct
> > device *dev,
> > >   * Secondly,Enter a new value for each level by inputing a string th=
at
> > >   * contains " echo xx xx xx > pp_dpm_sclk/mclk/pcie"
> > >   * E.g., echo 4 5 6 to > pp_dpm_sclk will enable sclk levels 4, 5, a=
nd 6.
> > > + *
> > > + * NOTE: change to the dcefclk max dpm level is not supported now
> > >   */
> > >
> > >  static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev, @@ -927,6
> > > +931,42 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
> > >         return count;
> > >  }
> > >
> > > +static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
> > > +               struct device_attribute *attr,
> > > +               char *buf)
> > > +{
> > > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > > +       struct amdgpu_device *adev =3D ddev->dev_private;
> > > +
> > > +       if (adev->powerplay.pp_funcs->print_clock_levels)
> > > +               return amdgpu_dpm_print_clock_levels(adev, PP_DCEFCLK=
,
> buf);
> > > +       else
> > > +               return snprintf(buf, PAGE_SIZE, "\n"); }
> > > +
> > > +static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
> > > +               struct device_attribute *attr,
> > > +               const char *buf,
> > > +               size_t count)
> > > +{
> > > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > > +       struct amdgpu_device *adev =3D ddev->dev_private;
> > > +       int ret;
> > > +       uint32_t mask =3D 0;
> > > +
> > > +       ret =3D amdgpu_read_mask(buf, count, &mask);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       if (adev->powerplay.pp_funcs->force_clock_level)
> > > +               ret =3D amdgpu_dpm_force_clock_level(adev, PP_DCEFCLK=
,
> > > + mask);
> > > +
> > > +       if (ret)
> > > +               return -EINVAL;
> > > +
> > > +       return count;
> > > +}
> > > +
> > >  static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
> > >                 struct device_attribute *attr,
> > >                 char *buf)
> > > @@ -1216,6 +1256,9 @@ static DEVICE_ATTR(pp_dpm_socclk, S_IRUGO |
> > > S_IWUSR,  static DEVICE_ATTR(pp_dpm_fclk, S_IRUGO | S_IWUSR,
> > >                 amdgpu_get_pp_dpm_fclk,
> > >                 amdgpu_set_pp_dpm_fclk);
> > > +static DEVICE_ATTR(pp_dpm_dcefclk, S_IRUGO | S_IWUSR,
> > > +               amdgpu_get_pp_dpm_dcefclk,
> > > +               amdgpu_set_pp_dpm_dcefclk);
> > >  static DEVICE_ATTR(pp_dpm_pcie, S_IRUGO | S_IWUSR,
> > >                 amdgpu_get_pp_dpm_pcie,
> > >                 amdgpu_set_pp_dpm_pcie); @@ -2387,6 +2430,11 @@ int
> > > amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
> > >                 DRM_ERROR("failed to create device file pp_dpm_fclk\n=
");
> > >                 return ret;
> > >         }
> > > +       ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_dcefcl=
k);
> > > +       if (ret) {
> > > +               DRM_ERROR("failed to create device file pp_dpm_dcefcl=
k\n");
> > > +               return ret;
> > > +       }
> > >         ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_pcie);
> > >         if (ret) {
> > >                 DRM_ERROR("failed to create device file
> > > pp_dpm_pcie\n"); @@ -2474,6 +2522,7 @@ void
> > amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
> > >         device_remove_file(adev->dev, &dev_attr_pp_dpm_socclk);
> > >         device_remove_file(adev->dev, &dev_attr_pp_dpm_pcie);
> > >         device_remove_file(adev->dev, &dev_attr_pp_dpm_fclk);
> > > +       device_remove_file(adev->dev, &dev_attr_pp_dpm_dcefclk);
> > >         device_remove_file(adev->dev, &dev_attr_pp_sclk_od);
> > >         device_remove_file(adev->dev, &dev_attr_pp_mclk_od);
> > >         device_remove_file(adev->dev, diff --git
> > > a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > index f82de14f6560..2b579ba9b685 100644
> > > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > @@ -94,6 +94,7 @@ enum pp_clock_type {
> > >         PP_PCIE,
> > >         PP_SOCCLK,
> > >         PP_FCLK,
> > > +       PP_DCEFCLK,
> > >         OD_SCLK,
> > >         OD_MCLK,
> > >         OD_VDDC_CURVE,
> > > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > > b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > > index 1832dcb965b1..585046c24925 100644
> > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> > > @@ -1746,6 +1746,17 @@ static int
> vega20_upload_dpm_min_level(struct
> > pp_hwmgr *hwmgr, uint32_t feature_
> > >                                         return ret);
> > >         }
> > >
> > > +       if (data->smu_features[GNLD_DPM_DCEFCLK].enabled &&
> > > +          (feature_mask & FEATURE_DPM_DCEFCLK_MASK)) {
> > > +               min_freq =3D
> > > + data->dpm_table.dcef_table.dpm_state.hard_min_level;
> > > +
> > > +               PP_ASSERT_WITH_CODE(!(ret =3D
> > smum_send_msg_to_smc_with_parameter(
> > > +                                       hwmgr, PPSMC_MSG_SetHardMinBy=
Freq,
> > > +                                       (PPCLK_DCEFCLK << 16) | (min_=
freq & 0xffff))),
> > > +                                       "Failed to set hard min dcefc=
lk!",
> > > +                                       return ret);
> > > +       }
> > > +
> > >         return ret;
> > >  }
> > >
> > > @@ -2258,7 +2269,7 @@ static int vega20_force_clock_level(struct
> > pp_hwmgr *hwmgr,
> > >                 enum pp_clock_type type, uint32_t mask)  {
> > >         struct vega20_hwmgr *data =3D (struct vega20_hwmgr *)(hwmgr-
> > >backend);
> > > -       uint32_t soft_min_level, soft_max_level;
> > > +       uint32_t soft_min_level, soft_max_level, hard_min_level;
> > >         int ret =3D 0;
> > >
> > >         switch (type) {
> > > @@ -2373,6 +2384,28 @@ static int vega20_force_clock_level(struct
> > > pp_hwmgr *hwmgr,
> > >
> > >                 break;
> > >
> > > +       case PP_DCEFCLK:
> > > +               hard_min_level =3D mask ? (ffs(mask) - 1) : 0;
> > > +
> > > +               if (hard_min_level >=3D data->dpm_table.dcef_table.co=
unt) {
> > > +                       pr_err("Clock level specified %d is over max =
allowed %d\n",
> > > +                                       hard_min_level,
> > > +                                       data->dpm_table.dcef_table.co=
unt - 1);
> > > +                       return -EINVAL;
> > > +               }
> > > +
> > > +               data->dpm_table.dcef_table.dpm_state.hard_min_level
> > > + =3D
> > > +
> > > + data->dpm_table.dcef_table.dpm_levels[hard_min_level].value;
> > > +
> > > +               ret =3D vega20_upload_dpm_min_level(hwmgr,
> > FEATURE_DPM_DCEFCLK_MASK);
> > > +               PP_ASSERT_WITH_CODE(!ret,
> > > +                       "Failed to upload boot level to lowest!",
> > > +                       return ret);
> > > +
> > > +               //TODO: Setting DCEFCLK max dpm level is not
> > > + supported
> > > +
> > > +               break;
> > > +
> > >         case PP_PCIE:
> > >                 soft_min_level =3D mask ? (ffs(mask) - 1) : 0;
> > >                 soft_max_level =3D mask ? (fls(mask) - 1) : 0; @@
> > > -3039,6 +3072,23 @@ static int vega20_print_clock_levels(struct
> > > pp_hwmgr
> > *hwmgr,
> > >                                 fclk_dpm_table->dpm_levels[i].value =
=3D=3D (now / 100) ?
> "*" :
> > "");
> > >                 break;
> > >
> > > +       case PP_DCEFCLK:
> > > +               ret =3D vega20_get_current_clk_freq(hwmgr,
> > > + PPCLK_DCEFCLK,
> > &now);
> > > +               PP_ASSERT_WITH_CODE(!ret,
> > > +                               "Attempt to get current dcefclk freq =
Failed!",
> > > +                               return ret);
> > > +
> > > +               ret =3D vega20_get_dcefclocks(hwmgr, &clocks);
> > > +               PP_ASSERT_WITH_CODE(!ret,
> > > +                               "Attempt to get dcefclk levels Failed=
!",
> > > +                               return ret);
> > > +
> > > +               for (i =3D 0; i < clocks.num_levels; i++)
> > > +                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n=
",
> > > +                               i, clocks.data[i].clocks_in_khz / 100=
0,
> > > +                               (clocks.data[i].clocks_in_khz =3D=3D =
now * 10) ? "*" : "");
> > > +               break;
> > > +
> > >         case PP_PCIE:
> > >                 gen_speed =3D (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
> > >
> > > PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
> > > --
> > > 2.20.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180954E02C7F4F12A5654723F7810BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Seems reasonable to me.&nbsp; Wit=
h those changes,</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Tuesday, January 15, 2019 1:59:42 AM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx list; Deucher, Alexander<br>
<b>Subject:</b> RE: [PATCH 4/4] drm/amd/powerplay: support retrieving and a=
djusting dcefclock power levels</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For ppfeatures, it will be seen only if (adev-&gt;=
asic_type &gt;=3D CHIP_VEGA10 &amp;&amp; !APU).<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: Quan, Evan<br>
&gt; Sent: Tuesday, January 15, 2019 2:44 PM<br>
&gt; To: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; Cc: amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Deucher, Alexa=
nder<br>
&gt; &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: RE: [PATCH 4/4] drm/amd/powerplay: support retrieving and<br>
&gt; adjusting dcefclock power levels<br>
&gt; <br>
&gt; I think we can use asic_type to determine whether to expose these new<=
br>
&gt; interfaces.<br>
&gt; If (adev-&gt;asic_type &gt;=3D CHIP_VEGA10), socclk and dcefclk are OK=
 to expose If<br>
&gt; (adev-&gt;asic_type &gt;=3D CHIP_VEGA20), fclk is OK to expose<br>
&gt; <br>
&gt; Regards,<br>
&gt; Evan<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; &gt; Sent: Tuesday, January 15, 2019 1:00 AM<br>
&gt; &gt; To: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; Cc: amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Deucher, =
Alexander<br>
&gt; &gt; &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; Subject: Re: [PATCH 4/4] drm/amd/powerplay: support retrieving an=
d<br>
&gt; &gt; adjusting dcefclock power levels<br>
&gt; &gt;<br>
&gt; &gt; On Mon, Jan 14, 2019 at 5:02 AM Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&g=
t; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; User can use &quot;pp_dpm_dcefclk&quot; to retrieve and adju=
st dcefclock power<br>
&gt; &gt; &gt; levels.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Change-Id: Ia3f61558ca96104c88d129ba5194103b2fe702ec<br>
&gt; &gt; &gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;<br>
&gt; &gt; We should probably find a way to hide these new files on asics wh=
ich<br>
&gt; &gt; don't support them.&nbsp; Other than that, the series looks good =
to me.<br>
&gt; &gt;<br>
&gt; &gt; Alex<br>
&gt; &gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 53<br>
&gt; &gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;-<br>
&gt; &gt; &gt;&nbsp; .../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;=
&nbsp; |&nbsp; 1 &#43;<br>
&gt; &gt; &gt;&nbsp; .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;=
&nbsp; | 52<br>
&gt; &gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;-<br>
&gt; &gt; &gt;&nbsp; 3 files changed, 103 insertions(&#43;), 3 deletions(-)=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; index f6646a522c06..b7b70f590236 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; @@ -731,11 &#43;731,13 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_get_ppfeature_status(struct device *dev,&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; /**<br>
&gt; &gt; &gt; - * DOC: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk<b=
r>
&gt; &gt; pp_dpm_pcie<br>
&gt; &gt; &gt; &#43; * DOC: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fc=
lk<br>
&gt; &gt; &gt; &#43; pp_dpm_dcefclk<br>
&gt; &gt; &gt; &#43; * pp_dpm_pcie<br>
&gt; &gt; &gt;&nbsp;&nbsp; *<br>
&gt; &gt; &gt;&nbsp;&nbsp; * The amdgpu driver provides a sysfs API for adj=
usting what power<br>
&gt; levels<br>
&gt; &gt; &gt;&nbsp;&nbsp; * are enabled for a given power state.&nbsp; The=
 files pp_dpm_sclk,<br>
&gt; &gt; &gt; pp_dpm_mclk,<br>
&gt; &gt; &gt; - * pp_dpm_socclk, pp_dpm_fclk and pp_dpm_pcie are used for =
this.<br>
&gt; &gt; &gt; &#43; * pp_dpm_socclk, pp_dpm_fclk, pp_dpm_dcefclk and pp_dp=
m_pcie<br>
&gt; are<br>
&gt; &gt; &gt; &#43; used for<br>
&gt; &gt; &gt; &#43; * this.<br>
&gt; &gt; &gt;&nbsp;&nbsp; *<br>
&gt; &gt; &gt;&nbsp;&nbsp; * Reading back the files will show you the avail=
able power levels within<br>
&gt; &gt; &gt;&nbsp;&nbsp; * the power state and the clock information for =
those levels.<br>
&gt; &gt; &gt; @@ -745,6 &#43;747,8 @@ static ssize_t<br>
&gt; &gt; &gt; amdgpu_get_ppfeature_status(struct<br>
&gt; &gt; device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp; * Secondly,Enter a new value for each level by i=
nputing a string that<br>
&gt; &gt; &gt;&nbsp;&nbsp; * contains &quot; echo xx xx xx &gt; pp_dpm_sclk=
/mclk/pcie&quot;<br>
&gt; &gt; &gt;&nbsp;&nbsp; * E.g., echo 4 5 6 to &gt; pp_dpm_sclk will enab=
le sclk levels 4, 5, and 6.<br>
&gt; &gt; &gt; &#43; *<br>
&gt; &gt; &gt; &#43; * NOTE: change to the dcefclk max dpm level is not sup=
ported now<br>
&gt; &gt; &gt;&nbsp;&nbsp; */<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp; static ssize_t amdgpu_get_pp_dpm_sclk(struct device *d=
ev, @@ -927,6<br>
&gt; &gt; &gt; &#43;931,42 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct =
device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count=
;<br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device =
*dev,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &gt; &gt; &#43;{<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device =
*ddev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_devi=
ce *adev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;power=
play.pp_funcs-&gt;print_clock_levels)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_dpm_print_clock_levels(adev, PP=
_DCEFCLK,<br>
&gt; buf);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot=
;); }<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device =
*dev,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count)<br>
&gt; &gt; &gt; &#43;{<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device =
*ddev =3D dev_get_drvdata(dev);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_devi=
ce *adev =3D ddev-&gt;dev_private;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D =
0;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_rea=
d_mask(buf, count, &amp;mask);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;power=
play.pp_funcs-&gt;force_clock_level)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_force_clock_level(adev, PP=
_DCEFCLK,<br>
&gt; &gt; &gt; &#43; mask);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &gt; &gt; &#43;}<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp; static ssize_t amdgpu_get_pp_dpm_pcie(struct device *d=
ev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &gt; &gt; @@ -1216,6 &#43;1256,9 @@ static DEVICE_ATTR(pp_dpm_socclk, =
S_IRUGO |<br>
&gt; &gt; &gt; S_IWUSR,&nbsp; static DEVICE_ATTR(pp_dpm_fclk, S_IRUGO | S_I=
WUSR,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_dpm_fclk,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_dpm_fclk);<br>
&gt; &gt; &gt; &#43;static DEVICE_ATTR(pp_dpm_dcefclk, S_IRUGO | S_IWUSR,<b=
r>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_dpm_dcefclk,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_dpm_dcefclk);<br>
&gt; &gt; &gt;&nbsp; static DEVICE_ATTR(pp_dpm_pcie, S_IRUGO | S_IWUSR,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_dpm_pcie,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_dpm_pcie); @@ -2387,6 &#4=
3;2430,11 @@ int<br>
&gt; &gt; &gt; amdgpu_pm_sysfs_init(struct amdgpu_device *adev)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device=
 file pp_dpm_fclk\n&quot;);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_cre=
ate_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_dcefclk);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device file =
pp_dpm_dcefclk\n&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D devi=
ce_create_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_pcie);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device=
 file<br>
&gt; &gt; &gt; pp_dpm_pcie\n&quot;); @@ -2474,6 &#43;2522,7 @@ void<br>
&gt; &gt; amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remov=
e_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_socclk);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remov=
e_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_pcie);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remov=
e_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_fclk);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file=
(adev-&gt;dev, &amp;dev_attr_pp_dpm_dcefclk);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remov=
e_file(adev-&gt;dev, &amp;dev_attr_pp_sclk_od);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remov=
e_file(adev-&gt;dev, &amp;dev_attr_pp_mclk_od);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remov=
e_file(adev-&gt;dev, diff --git<br>
&gt; &gt; &gt; a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &gt; &gt; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &gt; &gt; index f82de14f6560..2b579ba9b685 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interfa=
ce.h<br>
&gt; &gt; &gt; @@ -94,6 &#43;94,7 @@ enum pp_clock_type {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PCIE,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SOCCLK,<b=
r>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_FCLK,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_DCEFCLK,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OD_SCLK,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OD_MCLK,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OD_VDDC_CURV=
E,<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmg=
r.c<br>
&gt; &gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; &gt; &gt; index 1832dcb965b1..585046c24925 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20=
_hwmgr.c<br>
&gt; &gt; &gt; @@ -1746,6 &#43;1746,17 @@ static int<br>
&gt; vega20_upload_dpm_min_level(struct<br>
&gt; &gt; pp_hwmgr *hwmgr, uint32_t feature_<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_f=
eatures[GNLD_DPM_DCEFCLK].enabled &amp;&amp;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(feature_mask &amp; FEATURE_DPM_DCEFCLK_MASK)) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_freq =3D<br>
&gt; &gt; &gt; &#43; data-&gt;dpm_table.dcef_table.dpm_state.hard_min_level=
;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!(ret =3D<br>
&gt; &gt; smum_send_msg_to_smc_with_parameter(<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; hwmgr, PPSMC_MSG_SetHardMinByFreq,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; (PPCLK_DCEFCLK &lt;&lt; 16) | (min_freq &amp; 0xfff=
f))),<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to set hard min dcefclk!&quot;,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&gt; &gt; &gt;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -2258,7 &#43;2269,7 @@ static int vega20_force_clock_leve=
l(struct<br>
&gt; &gt; pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type, uint32_t mask)=
&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega2=
0_hwmgr *data =3D (struct vega20_hwmgr *)(hwmgr-<br>
&gt; &gt; &gt;backend);<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t soft_min_leve=
l, soft_max_level;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t soft_min_=
level, soft_max_level, hard_min_level;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D =
0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type=
) {<br>
&gt; &gt; &gt; @@ -2373,6 &#43;2384,28 @@ static int vega20_force_clock_lev=
el(struct<br>
&gt; &gt; &gt; pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_DCEFCLK:<b=
r>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hard_min_level =3D mask ? (ffs(mask) - 1) : 0=
;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hard_min_level &gt;=3D data-&gt;dpm_table=
.dcef_table.count) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; pr_err(&quot;Clock level specified %d is over max allowed %d\n&quot;,<br=
>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; hard_min_level,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.dcef_table.count - 1);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.dcef_table.dpm_state.hard_=
min_level<br>
&gt; &gt; &gt; &#43; =3D<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43; data-&gt;dpm_table.dcef_table.dpm_levels[hard_min_leve=
l].value;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_min_level(hwmgr,<br=
>
&gt; &gt; FEATURE_DPM_DCEFCLK_MASK);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &quot;Failed to upload boot level to lowest!&quot;,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return ret);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //TODO: Setting DCEFCLK max dpm level is not<=
br>
&gt; &gt; &gt; &#43; supported<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PCIE=
:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soft_min_level =3D mask ? (ffs(mask) - =
1) : 0;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soft_max_level =3D mask ? (fls(mask) - =
1) : 0; @@<br>
&gt; &gt; &gt; -3039,6 &#43;3072,23 @@ static int vega20_print_clock_levels=
(struct<br>
&gt; &gt; &gt; pp_hwmgr<br>
&gt; &gt; *hwmgr,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fclk_dpm_table-&gt=
;dpm_levels[i].value =3D=3D (now / 100) ?<br>
&gt; &quot;*&quot; :<br>
&gt; &gt; &quot;&quot;);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_DCEFCLK:<b=
r>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_get_current_clk_freq(hwmgr,<br=
>
&gt; &gt; &gt; &#43; PPCLK_DCEFCLK,<br>
&gt; &gt; &amp;now);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Attempt to get cur=
rent dcefclk freq Failed!&quot;,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_get_dcefclocks(hwmgr, &amp;clo=
cks);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Attempt to get dce=
fclk levels Failed!&quot;,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; clocks.num_levels; i&#43=
;&#43;)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; size &#43;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, clocks.data[i].clocks=
_in_khz / 1000,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clocks.data[i].clocks_i=
n_khz =3D=3D now * 10) ? &quot;*&quot; : &quot;&quot;);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PCIE=
:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gen_speed =3D (RREG32_PCIE(smnPCIE_LC_S=
PEED_CNTL) &amp;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.20.1<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; amd-gfx mailing list<br>
&gt; &gt; &gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/am=
d-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180954E02C7F4F12A5654723F7810BN6PR12MB1809namp_--

--===============1268493895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1268493895==--
