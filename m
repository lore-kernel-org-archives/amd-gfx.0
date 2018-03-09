From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/8] drm/amd/pp: Refine code for smu7 in powerplay
Date: Fri, 9 Mar 2018 12:06:51 -0500
Message-ID: <CADnq5_N1P6aAV_P8HWvvWCDcrCjaVkGk-Fpa3L864DJqJKNbjA@mail.gmail.com>
References: <1520419570-28831-1-git-send-email-Rex.Zhu@amd.com>
 <CADnq5_OeOQwxo6pMsrDEdCgwYK06cEq3bU7ztF+nvAFHmVQ-yw@mail.gmail.com>
 <CY4PR12MB168736E41ADC884B48DF5171FBDE0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0484989343=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB168736E41ADC884B48DF5171FBDE0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0484989343==
Content-Type: multipart/alternative; boundary="001a1143bb868dd7bb0566fdd17d"

--001a1143bb868dd7bb0566fdd17d
Content-Type: text/plain; charset="UTF-8"

Nice cleanup.  Patch is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

On Fri, Mar 9, 2018 at 5:55 AM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:

> Hi Alex,
>
>
> The avfs btc state is only used in driver and not interact with HW.
>
> and we only need to know whether this feature is supported or not by HW.
>
> so delete the complex define of avfs btc state and simplify related code.
>
> Please review the attached patch.
>
>
> Best Regards
>
> Rex
>
> ------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Thursday, March 8, 2018 1:12 AM
> *To:* Zhu, Rex
> *Cc:* amd-gfx list
> *Subject:* Re: [PATCH 1/8] drm/amd/pp: Refine code for smu7 in powerplay
>
> On Wed, Mar 7, 2018 at 5:46 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> > 1. Add avfs_support in hwmgr to avoid to visit smu backend struct in
> >    hwmgr.so do not need to include smu7_smumgr.h under hwmgr folder.
> > 2. simplify the list of enum AVFS_BTC_STATUS
> >
> > Change-Id: I04c769972deff797229339f3ccb1c442b35768a2
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c        | 14
> ++------------
> >  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h               |  2 +-
> >  drivers/gpu/drm/amd/powerplay/inc/smumgr.h              | 10 +---------
> >  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c      |  4 +++-
> >  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c |  4 +++-
> >  5 files changed, 10 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > index d4d1d2e..da25e7f 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > @@ -40,7 +40,6 @@
> >
> >  #include "hwmgr.h"
> >  #include "smu7_hwmgr.h"
> > -#include "smu7_smumgr.h"
> >  #include "smu_ucode_xfer_vi.h"
> >  #include "smu7_powertune.h"
> >  #include "smu7_dyn_defaults.h"
> > @@ -1353,12 +1352,7 @@ static int smu7_enable_dpm_tasks(struct pp_hwmgr
> *hwmgr)
> >
> >  static int smu7_avfs_control(struct pp_hwmgr *hwmgr, bool enable)
> >  {
> > -       struct smu7_smumgr *smu_data = (struct smu7_smumgr
> *)(hwmgr->smu_backend);
> > -
> > -       if (smu_data == NULL)
> > -               return -EINVAL;
> > -
> > -       if (smu_data->avfs.avfs_btc_status == AVFS_BTC_NOTSUPPORTED)
> > +       if (!hwmgr->avfs_supported)
> >                 return 0;
> >
> >         if (enable) {
> > @@ -1382,13 +1376,9 @@ static int smu7_avfs_control(struct pp_hwmgr
> *hwmgr, bool enable)
> >
> >  static int smu7_update_avfs(struct pp_hwmgr *hwmgr)
> >  {
> > -       struct smu7_smumgr *smu_data = (struct smu7_smumgr
> *)(hwmgr->smu_backend);
> >         struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
> >
> > -       if (smu_data == NULL)
> > -               return -EINVAL;
> > -
> > -       if (smu_data->avfs.avfs_btc_status == AVFS_BTC_NOTSUPPORTED)
> > +       if (!hwmgr->avfs_supported)
> >                 return 0;
> >
> >         if (data->need_update_smu7_dpm_table & DPMTABLE_OD_UPDATE_VDDC)
> {
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > index b151ad85..312fbc3 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > @@ -748,7 +748,7 @@ struct pp_hwmgr {
> >         struct pp_power_state    *uvd_ps;
> >         struct amd_pp_display_configuration display_config;
> >         uint32_t feature_mask;
> > -
> > +       bool avfs_supported;
> >         /* UMD Pstate */
> >         bool en_umd_pstate;
> >         uint32_t power_profile_mode;
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> > index 9bba0a0..f0ef02a 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> > @@ -28,23 +28,15 @@
> >
> >  enum AVFS_BTC_STATUS {
> >         AVFS_BTC_BOOT = 0,
> > -       AVFS_BTC_BOOT_STARTEDSMU,
> >         AVFS_LOAD_VIRUS,
> >         AVFS_BTC_VIRUS_LOADED,
> >         AVFS_BTC_VIRUS_FAIL,
> >         AVFS_BTC_COMPLETED_PREVIOUSLY,
> >         AVFS_BTC_ENABLEAVFS,
> > -       AVFS_BTC_STARTED,
> >         AVFS_BTC_FAILED,
> > -       AVFS_BTC_RESTOREVFT_FAILED,
> > -       AVFS_BTC_SAVEVFT_FAILED,
> >         AVFS_BTC_DPMTABLESETUP_FAILED,
> > -       AVFS_BTC_COMPLETED_UNSAVED,
> > -       AVFS_BTC_COMPLETED_SAVED,
> > -       AVFS_BTC_COMPLETED_RESTORED,
> >         AVFS_BTC_DISABLED,
> > -       AVFS_BTC_NOTSUPPORTED,
> > -       AVFS_BTC_SMUMSG_ERROR
> > +       AVFS_BTC_NOTSUPPORTED
> >  };
>
> This isn't used to interact with the hw anywhere is it?  If so, this
> will break that.  It should probably be split out as a separate patch
> since it's not really directly related to the rest of this patch.
> With those addresses this patch is:
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> >
> >  enum SMU_TABLE {
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> > index 0b2b5d1..573c9be 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> > @@ -360,8 +360,10 @@ static bool fiji_is_hw_avfs_present(struct pp_hwmgr
> *hwmgr)
> >
> >         if (!atomctrl_read_efuse(hwmgr->device, AVFS_EN_LSB,
> AVFS_EN_MSB,
> >                         mask, &efuse)) {
> > -               if (efuse)
> > +               if (efuse) {
> > +                       hwmgr->avfs_supported = true;
> >                         return true;
> > +               }
> >         }
> >         return false;
> >  }
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> > index 632d1ca..1075ec1 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> > @@ -357,8 +357,10 @@ static bool polaris10_is_hw_avfs_present(struct
> pp_hwmgr *hwmgr)
> >
> >         efuse = cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> ixSMU_EFUSE_0 + (49*4));
> >         efuse &= 0x00000001;
> > -       if (efuse)
> > +       if (efuse) {
> > +               hwmgr->avfs_supported = true;
> >                 return true;
> > +       }
> >
> >         return false;
> >  }
> > --
> > 1.9.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following
> form. Use of all freedesktop.org lists is subject to our Code of ...
>
>

--001a1143bb868dd7bb0566fdd17d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Nice cleanup.=C2=A0 Patch is:<br></div>Reviewed-by: A=
lex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">alexander.deuc=
her-5C7GfCeVMHo@public.gmane.org</a>&gt;<br><div><div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Fri, Mar 9, 2018 at 5:55 AM, Zhu, Rex <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">




<div dir=3D"ltr">
<div id=3D"m_7239844958464048745divtagdefaultwrapper" style=3D"font-size:12=
pt;color:#000000;font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hi Alex,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">The avfs btc state is only used i=
n driver
<font size=3D"2"><span style=3D"font-size:11pt">and not interact with HW.</=
span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt"></span></font>and we only need to know whether this feature =
is supported or not by HW.</p>
<p style=3D"margin-top:0;margin-bottom:0">so delete the complex define of a=
vfs btc state and simplify related code.</p>
<p style=3D"margin-top:0;margin-bottom:0">Please review the attached patch.=
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_7239844958464048745divRplyFwdMsg" dir=3D"ltr"><font style=3D"f=
ont-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> =
Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank"=
>alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, March 8, 2018 1:12 AM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 1/8] drm/amd/pp: Refine code for smu7 in powerpl=
ay</font>
<div>=C2=A0</div>
</div>
<div class=3D"m_7239844958464048745BodyFragment"><font size=3D"2"><span sty=
le=3D"font-size:11pt">
<div class=3D"m_7239844958464048745PlainText"><div><div class=3D"h5">On Wed=
, Mar 7, 2018 at 5:46 AM, Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" ta=
rget=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt; 1. Add avfs_support in hwmgr to avoid to visit smu backend struct in<b=
r>
&gt;=C2=A0=C2=A0=C2=A0 hwmgr.so do not need to include smu7_smumgr.h under =
hwmgr folder.<br>
&gt; 2. simplify the list of enum AVFS_BTC_STATUS<br>
&gt;<br>
&gt; Change-Id: I04c769972deff797229339f3ccb1c<wbr>442b35768a2<br>
&gt; Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/powerplay/<wbr>hwmgr/smu7_hwmgr.c=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++------------<br>
&gt;=C2=A0 drivers/gpu/drm/amd/powerplay/<wbr>inc/hwmgr.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
2 +-<br>
&gt;=C2=A0 drivers/gpu/drm/amd/powerplay/<wbr>inc/smumgr.h=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +-----=
----<br>
&gt;=C2=A0 drivers/gpu/drm/amd/powerplay/<wbr>smumgr/fiji_smumgr.c=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-<br>
&gt;=C2=A0 drivers/gpu/drm/amd/powerplay/<wbr>smumgr/polaris10_smumgr.c |=
=C2=A0 4 +++-<br>
&gt;=C2=A0 5 files changed, 10 insertions(+), 24 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu7_hwmgr.c b/d=
rivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; index d4d1d2e..da25e7f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; +++ b/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; @@ -40,7 +40,6 @@<br>
&gt;<br>
&gt;=C2=A0 #include &quot;hwmgr.h&quot;<br>
&gt;=C2=A0 #include &quot;smu7_hwmgr.h&quot;<br>
&gt; -#include &quot;smu7_smumgr.h&quot;<br>
&gt;=C2=A0 #include &quot;smu_ucode_xfer_vi.h&quot;<br>
&gt;=C2=A0 #include &quot;smu7_powertune.h&quot;<br>
&gt;=C2=A0 #include &quot;smu7_dyn_defaults.h&quot;<br>
&gt; @@ -1353,12 +1352,7 @@ static int smu7_enable_dpm_tasks(struct pp_hwmg=
r *hwmgr)<br>
&gt;<br>
&gt;=C2=A0 static int smu7_avfs_control(struct pp_hwmgr *hwmgr, bool enable=
)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct smu7_smumgr *smu_data =3D=
 (struct smu7_smumgr *)(hwmgr-&gt;smu_backend);<br>
&gt; -<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (smu_data =3D=3D NULL)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;<br>
&gt; -<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (smu_data-&gt;avfs.avfs_btc_<=
wbr>status =3D=3D AVFS_BTC_NOTSUPPORTED)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!hwmgr-&gt;avfs_supported)<b=
r>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (enable) {<br>
&gt; @@ -1382,13 +1376,9 @@ static int smu7_avfs_control(struct pp_hwmgr *h=
wmgr, bool enable)<br>
&gt;<br>
&gt;=C2=A0 static int smu7_update_avfs(struct pp_hwmgr *hwmgr)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct smu7_smumgr *smu_data =3D=
 (struct smu7_smumgr *)(hwmgr-&gt;smu_backend);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct smu7_hwmgr *dat=
a =3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&gt;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (smu_data =3D=3D NULL)<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;<br>
&gt; -<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (smu_data-&gt;avfs.avfs_btc_<=
wbr>status =3D=3D AVFS_BTC_NOTSUPPORTED)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!hwmgr-&gt;avfs_supported)<b=
r>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data-&gt;need_upda=
te_smu7_dpm_<wbr>table &amp; DPMTABLE_OD_UPDATE_VDDC) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/<wbr>powerplay/inc/hwmgr.h b/drivers/=
gpu/drm/amd/<wbr>powerplay/inc/hwmgr.h<br>
&gt; index b151ad85..312fbc3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/<wbr>powerplay/inc/hwmgr.h<br>
&gt; +++ b/drivers/gpu/drm/amd/<wbr>powerplay/inc/hwmgr.h<br>
&gt; @@ -748,7 +748,7 @@ struct pp_hwmgr {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pp_power_state=
=C2=A0=C2=A0=C2=A0 *uvd_ps;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amd_pp_display_=
configuration display_config;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t feature_mask;=
<br>
&gt; -<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool avfs_supported;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* UMD Pstate */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool en_umd_pstate;<br=
>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t power_profile=
_mode;<br>
&gt; diff --git a/drivers/gpu/drm/amd/<wbr>powerplay/inc/smumgr.h b/drivers=
/gpu/drm/amd/<wbr>powerplay/inc/smumgr.h<br>
&gt; index 9bba0a0..f0ef02a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/<wbr>powerplay/inc/smumgr.h<br>
&gt; +++ b/drivers/gpu/drm/amd/<wbr>powerplay/inc/smumgr.h<br>
&gt; @@ -28,23 +28,15 @@<br>
&gt;<br>
&gt;=C2=A0 enum AVFS_BTC_STATUS {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_BOOT =3D 0,<b=
r>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_BOOT_STARTEDSMU,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_LOAD_VIRUS,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_VIRUS_LOADED,=
<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_VIRUS_FAIL,<b=
r>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_COMPLETED_PRE=
VIOUSLY,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_ENABLEAVFS,<b=
r>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_STARTED,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_FAILED,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_RESTOREVFT_FAILED,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_SAVEVFT_FAILED,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_DPMTABLESETUP=
_FAILED,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_COMPLETED_UNSAVED,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_COMPLETED_SAVED,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_COMPLETED_RESTORED,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_DISABLED,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_NOTSUPPORTED,<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_SMUMSG_ERROR<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVFS_BTC_NOTSUPPORTED<br>
&gt;=C2=A0 };<br>
<br>
This isn&#39;t used to interact with the hw anywhere is it?=C2=A0 If so, th=
is<br>
will break that.=C2=A0 It should probably be split out as a separate patch<=
br>
since it&#39;s not really directly related to the rest of this patch.<br>
With those addresses this patch is:<br>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" =
target=3D"_blank">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
&gt;<br>
&gt;=C2=A0 enum SMU_TABLE {<br>
&gt; diff --git a/drivers/gpu/drm/amd/<wbr>powerplay/smumgr/fiji_smumgr.c b=
/drivers/gpu/drm/amd/<wbr>powerplay/smumgr/fiji_smumgr.c<br>
&gt; index 0b2b5d1..573c9be 100644<br>
&gt; --- a/drivers/gpu/drm/amd/<wbr>powerplay/smumgr/fiji_smumgr.c<br>
&gt; +++ b/drivers/gpu/drm/amd/<wbr>powerplay/smumgr/fiji_smumgr.c<br>
&gt; @@ -360,8 +360,10 @@ static bool fiji_is_hw_avfs_present(struct pp_hwm=
gr *hwmgr)<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!atomctrl_read_efu=
se(hwmgr-&gt;<wbr>device, AVFS_EN_LSB, AVFS_EN_MSB,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 mask, &amp;efuse)) {<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (efuse)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (efuse) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmgr-&gt;a=
vfs_supported =3D true;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return true;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/drivers/gpu/drm/amd/<wbr>powerplay/smumgr/polaris10_<wbr>=
smumgr.c b/drivers/gpu/drm/amd/<wbr>powerplay/smumgr/polaris10_<wbr>smumgr.=
c<br>
&gt; index 632d1ca..1075ec1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/<wbr>powerplay/smumgr/polaris10_<wbr>smumgr.=
c<br>
&gt; +++ b/drivers/gpu/drm/amd/<wbr>powerplay/smumgr/polaris10_<wbr>smumgr.=
c<br>
&gt; @@ -357,8 +357,10 @@ static bool polaris10_is_hw_avfs_present(<wbr>str=
uct pp_hwmgr *hwmgr)<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efuse =3D cgs_read_ind=
_register(hwmgr-&gt;<wbr>device, CGS_IND_REG__SMC, ixSMU_EFUSE_0 + (49*4));=
<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efuse &amp;=3D 0x00000=
001;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (efuse)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (efuse) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 hwmgr-&gt;avfs_supported =3D true;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>
&gt;=C2=A0 }<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a id=3D"m_7239844958464048745LPlnk605140" href=3D"https://lists.freed=
esktop.org/mailman/listinfo/amd-gfx" target=3D"_blank">
https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</div></div><div style=3D"margin-bottom:20px;overflow:auto;width:100%;text-=
indent:0px" id=3D"m_7239844958464048745LPBorder_GT_15205915258620.268686134=
5053829">
<table style=3D"width:90%;background-color:rgb(255,255,255);overflow:auto;p=
adding-top:20px;padding-bottom:20px;margin-top:20px;border-top:1px dotted r=
gb(200,200,200);border-bottom:1px dotted rgb(200,200,200)" id=3D"m_72398449=
58464048745LPContainer_15205915258590.9282736731640967" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td colspan=3D"2" style=3D"vertical-align:top;padding:0px;display:table-cel=
l" id=3D"m_7239844958464048745TextCell_15205915258600.9720307957613028">
<div id=3D"m_7239844958464048745LPRemovePreviewContainer_15205915258600.574=
7894184804376"></div>
<div style=3D"color:rgb(0,120,215);font-weight:400;font-size:21px;font-fami=
ly:&quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP =
Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-ser=
if;line-height:21px" id=3D"m_7239844958464048745LPTitle_15205915258600.6420=
531425137407">
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" style=3D=
"text-decoration:none" id=3D"m_7239844958464048745LPUrlAnchor_1520591525861=
0.5529589204654419" target=3D"_blank">amd-gfx Info Page - freedesktop.org</=
a></div>
<div style=3D"margin:10px 0px 16px;color:rgb(102,102,102);font-weight:400;f=
ont-family:&quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe =
WP&quot;,Tahoma,Arial,sans-serif;font-size:14px;line-height:14px" id=3D"m_7=
239844958464048745LPMetadata_15205915258610.39476917506447184">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank">lists.freedeskto=
p.org</a></div>
<div style=3D"display:block;color:rgb(102,102,102);font-weight:400;font-fam=
ily:&quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot=
;,Tahoma,Arial,sans-serif;font-size:14px;line-height:20px;max-height:100px;=
overflow:hidden" id=3D"m_7239844958464048745LPDescription_15205915258620.74=
43088027813343">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all <a href=3D"http://freedesktop.org" target=3D"_blank">freede=
sktop.org</a> lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</div>

</blockquote></div><br></div></div></div></div>

--001a1143bb868dd7bb0566fdd17d--

--===============0484989343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0484989343==--
