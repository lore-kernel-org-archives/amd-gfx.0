From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check support on
 Rv/Vega12
Date: Thu, 2 Aug 2018 09:38:15 -0400
Message-ID: <CADnq5_PsO7rzm-Jm8pKbbsrOfygky+SivuTnbCpCE=G7pcBKqA@mail.gmail.com>
References: <1532864547-1072-1-git-send-email-rex.zhu@amd.com>
 <1532864547-1072-3-git-send-email-rex.zhu@amd.com>
 <SN6PR12MB2656D918D6DBD7C1932747BFE42F0@SN6PR12MB2656.namprd12.prod.outlook.com>
 <CY4PR12MB1687B6284781F05DDD30ACA6FB2F0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <CY4PR12MB168799400EFB54D63F9EAE6CFB2D0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <CADnq5_N_BsHR9WCMcZ04wt+jL=6bCB_R=m2w=w+nb_O7Ugnj_w@mail.gmail.com>
 <CY4PR12MB1687D8D4388E80BE18A677F8FB2C0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1455895149=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687D8D4388E80BE18A677F8FB2C0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Quan,
 Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1455895149==
Content-Type: multipart/alternative; boundary="0000000000005866f9057273ec77"

--0000000000005866f9057273ec77
Content-Type: text/plain; charset="UTF-8"

If you use them enough for debugging that you think it's better to have
them in tree, feel free to commit them.  Maybe just add a note that they
are just for debugging and add a note about the race condition.

Alex


On Thu, Aug 2, 2018 at 6:22 AM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:

> Currently, there is no use case except for debug.
>
> So I will keep the patches in my local.
>
> Thanks.
>
>
>
> Best Regards
>
> Rex
>
>
>
>
> ------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Wednesday, August 1, 2018 11:13 PM
> *To:* Zhu, Rex
> *Cc:* Deucher, Alexander; Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>
> *Subject:* Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check support
> on Rv/Vega12
>
> Does anything use it?  Might be useful for debugging, but I guess you'd
> probably use something like umr in that case.
>
> Alex
>
> On Tue, Jul 31, 2018 at 9:15 PM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
>
> Hi Alex,
>
>
> Is it necessary to export an interface as "is_gfx_on" in powerplay to
> amdgpu?
>
> It can show the current power state of gfx ip.
>
>
>
> Best Regards
>
> Rex
>
>
> ------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhu,
> Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Monday, July 30, 2018 11:39 AM
> *To:* Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>
> *Subject:* Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check support
> on Rv/Vega12
>
>
> > It means user was told the gfx is on but actually it may switches to
> gfxoff already.
>
>
> Correct.
>
> So if the gfx is off, user should disable gfx off feature before they
> read/write the registers via mmio.
>
> if gfx is on, that is not mean the gfx off feature is disabled. it
> doesn't mean it is safe to visit the registers through mmio.
>
>
> Best Regards
>
> Rex
>
> ------------------------------
> *From:* Quan, Evan
> *Sent:* Monday, July 30, 2018 9:31 AM
> *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check support
> on Rv/Vega12
>
>
> Since the gfxoff is always in dynamic switch, i do not think the status
> reported to user is reliable. It means user was told the gfx is on but
> actually it may switches to gfxoff already.
>
>
> Regards,
>
> Evan
>
>
> ------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex
> Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Sunday, July 29, 2018 7:42:27 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Zhu, Rex
> *Subject:* [PATCH 3/3] drm/amd/pp: Add gfx power status check support on
> Rv/Vega12
>
> As gfx off is supported on Rv/Vega12, so this check is
> helpful and necessary when visit gfx regesiter via mmio.
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  | 10 +++++++
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 31
> +++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index 26d130a..da1be82 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -296,6 +296,15 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr)
>          return false;
>  }
>
> +static bool smu10_is_hw_ip_on(struct pp_hwmgr *hwmgr,
> +                               enum amd_ip_block_type client)
> +{
> +       if (client == AMD_IP_BLOCK_TYPE_GFX)
> +               return smu10_is_gfx_on(hwmgr);
> +       else /* for other ip, to do */
> +               return true;
> +}
> +
>  static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)
>  {
>          struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr
> *)(hwmgr->backend);
> @@ -1187,6 +1196,7 @@ static void smu10_powergate_vcn(struct pp_hwmgr
> *hwmgr, bool bgate)
>          .smus_notify_pwe = smu10_smus_notify_pwe,
>          .display_clock_voltage_request = smu10_display_clock_voltage_re
> quest,
>          .powergate_gfx = smu10_gfx_off_control,
> +       .is_hw_ip_on = smu10_is_hw_ip_on,
>  };
>
>  int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> index 0789d64..ee44300 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> @@ -45,7 +45,7 @@
>  #include "ppinterrupt.h"
>  #include "pp_overdriver.h"
>  #include "pp_thermal.h"
> -
> +#include "soc15_common.h"
>
>  static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
>                  enum pp_clock_type type, uint32_t mask);
> @@ -2320,6 +2320,34 @@ static int vega12_get_thermal_temperature_range(struct
> pp_hwmgr *hwmgr,
>          return 0;
>  }
>
> +/* GFX HW Power Status can be queried from bits [1:0] of
> MP1_SMN_EXT_SCRATCH0
> + * 2'b00   GFX is OFF
> + * 2'b01   Transitioning out of GFXOFF state
> + * 2'b10   GFX is ON
> + * 2'b11   Transitioning into GFXOFF state
> +*/
> +
> +static bool vega12_is_gfx_on(struct pp_hwmgr *hwmgr)
> +{
> +       uint32_t tmp;
> +       struct amdgpu_device *adev = hwmgr->adev;
> +
> +       tmp = RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
> +       if (tmp == 1 || tmp == 2)
> +               return true;
> +       else
> +               return false;
> +}
> +
> +static bool vega12_is_hw_ip_on(struct pp_hwmgr *hwmgr,
> +                               enum amd_ip_block_type client)
> +{
> +       if (client == AMD_IP_BLOCK_TYPE_GFX)
> +               return vega12_is_gfx_on(hwmgr);
> +       else /* for other ip, to do */
> +               return true;
> +}
> +
>  static int vega12_enable_gfx_off(struct pp_hwmgr *hwmgr)
>  {
>          struct vega12_hwmgr *data =
> @@ -2402,6 +2430,7 @@ static int vega12_gfx_off_control(struct pp_hwmgr
> *hwmgr, bool enable)
>          .register_irq_handlers = smu9_register_irq_handlers,
>          .start_thermal_controller = vega12_start_thermal_controller,
>          .powergate_gfx = vega12_gfx_off_control,
> +       .is_hw_ip_on = vega12_is_hw_ip_on,
>  };
>
>  int vega12_hwmgr_init(struct pp_hwmgr *hwmgr)
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following
> form. Use of all freedesktop.org lists is subject to our Code of Conduct.
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>

--0000000000005866f9057273ec77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>If you use them enough for debugging that you think i=
t&#39;s better to have them in tree, feel free to commit them.=C2=A0 Maybe =
just add a note that they are just for debugging and add a note about the r=
ace condition.</div><div><br></div><div>Alex<br></div><div><br></div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Aug 2, 2018 at =
6:22 AM, Zhu, Rex <span dir=3D"ltr">&lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" =
target=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">




<div dir=3D"ltr">
<div id=3D"m_4286124162469801541divtagdefaultwrapper" style=3D"font-size:12=
pt;color:#000000;font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Currently, there is no use case e=
xcept for debug.</p>
<p style=3D"margin-top:0;margin-bottom:0">So I will keep the patches in my =
local.</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_4286124162469801541divRplyFwdMsg" dir=3D"ltr"><font style=3D"f=
ont-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> =
Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank"=
>alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Wednesday, August 1, 2018 11:13 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> Deucher, Alexander; Quan, Evan; <a href=3D"mailto:amd-gfx@lists.=
freedesktop.org" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><div><d=
iv class=3D"h5"><br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check supp=
ort on Rv/Vega12</div></div></font>
<div>=C2=A0</div>
</div><div><div class=3D"h5">

<div>
<div dir=3D"ltr">
<div>Does anything use it?=C2=A0 Might be useful for debugging, but I guess=
 you&#39;d probably use something like umr in that case.</div>
<div><br>
</div>
<div>Alex<br>
</div>
<div>
<div class=3D"m_4286124162469801541x_gmail_extra"><br>
<div class=3D"m_4286124162469801541x_gmail_quote">On Tue, Jul 31, 2018 at 9=
:15 PM, Zhu, Rex <span dir=3D"ltr">
&lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" id=3D"m_4286124162469801541LPlnk9133=
12" class=3D"m_4286124162469801541OWAAutoLink" target=3D"_blank">Rex.Zhu@am=
d.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"m_4286124162469801541x_gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"m_4286124162469801541x_m_-777202135617971185divtagdefaultwrapper=
" dir=3D"ltr" style=3D"font-size:12pt;color:#000000;font-family:Calibri,Hel=
vetica,sans-serif">
<p style=3D"margin-top:0;margin-bottom:0">Hi Alex,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Is it necessary to export an inte=
rface as &quot;is_gfx_on&quot; in powerplay to amdgpu?</p>
<p style=3D"margin-top:0;margin-bottom:0">It can show the current power sta=
te of=C2=A0gfx ip.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex=C2=A0</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_4286124162469801541x_m_-777202135617971185divRplyFwdMsg" dir=
=3D"ltr"><font style=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=
=3D"#000000"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lis=
ts.freedesktop.org" id=3D"m_4286124162469801541LPlnk303975" class=3D"m_4286=
124162469801541OWAAutoLink" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
<wbr>ktop.org</a>&gt;
 on behalf of Zhu, Rex &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" id=3D"m_42861=
24162469801541LPlnk834453" class=3D"m_4286124162469801541OWAAutoLink" targe=
t=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Monday, July 30, 2018 11:39 AM<br>
<b>To:</b> Quan, Evan; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=
=3D"m_4286124162469801541LPlnk303555" class=3D"m_4286124162469801541OWAAuto=
Link" target=3D"_blank">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<div>
<div class=3D"m_4286124162469801541x_h5"><br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check supp=
ort on Rv/Vega12</div>
</div>
</font>
<div>=C2=A0</div>
</div>
<div>
<div class=3D"m_4286124162469801541x_h5">
<div dir=3D"ltr">
<div id=3D"m_4286124162469801541x_m_-777202135617971185x_divtagdefaultwrapp=
er" dir=3D"ltr" style=3D"font-size:12pt;color:#000000;font-family:Calibri,H=
elvetica,sans-serif">
<p style=3D"margin-top:0;margin-bottom:0"><span>&gt; It means user was told=
 the gfx is on but actually it may switches to gfxoff already.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span></span><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Correct. <br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">So if the gfx is off, user should=
 disable gfx off feature before they read/write the registers via mmio.</p>
<p style=3D"margin-top:0;margin-bottom:0">if gfx is on, that is not mean th=
e gfx off feature is disabled. it=C2=A0 doesn&#39;t mean it is safe to visi=
t the registers through mmio.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_4286124162469801541x_m_-777202135617971185x_divRplyFwdMsg" dir=
=3D"ltr"><font style=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=
=3D"#000000"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Monday, July 30, 2018 9:31 AM<br>
<b>To:</b> Zhu, Rex; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D=
"m_4286124162469801541LPlnk843060" class=3D"m_4286124162469801541OWAAutoLin=
k" target=3D"_blank">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check supp=
ort on Rv/Vega12</font>
<div>=C2=A0</div>
</div>
<div dir=3D"ltr">
<div id=3D"m_4286124162469801541x_m_-777202135617971185x_x_divtagdefaultwra=
pper" dir=3D"ltr" style=3D"font-size:12pt;color:#000000;font-family:Calibri=
,Helvetica,sans-serif">
<p style=3D"margin-top:0;margin-bottom:0">Since the gfxoff is always in dyn=
amic switch, i do not think the status reported to user is reliable. It mea=
ns user was told the gfx is on but actually it may switches to gfxoff alrea=
dy.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Evan</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_4286124162469801541x_m_-777202135617971185x_x_divRplyFwdMsg" d=
ir=3D"ltr"><font style=3D"font-size:11pt" face=3D"Calibri, sans-serif" colo=
r=3D"#000000"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@li=
sts.freedesktop.org" id=3D"m_4286124162469801541LPlnk224967" class=3D"m_428=
6124162469801541OWAAutoLink" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
s<wbr>ktop.org</a>&gt;
 on behalf of Rex Zhu &lt;<a href=3D"mailto:rex.zhu-5C7GfCeVMHo@public.gmane.org" id=3D"m_428612=
4162469801541LPlnk198810" class=3D"m_4286124162469801541OWAAutoLink" target=
=3D"_blank">rex.zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Sunday, July 29, 2018 7:42:27 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"m_4286124=
162469801541LPlnk622661" class=3D"m_4286124162469801541OWAAutoLink" target=
=3D"_blank">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/pp: Add gfx power status check support =
on Rv/Vega12</font>
<div>=C2=A0</div>
</div>
<div class=3D"m_4286124162469801541x_m_-777202135617971185x_x_BodyFragment"=
><font size=3D"2"><span style=3D"font-size:11pt">
<div class=3D"m_4286124162469801541x_m_-777202135617971185x_x_PlainText">As=
 gfx off is supported on Rv/Vega12, so this check is<br>
helpful and necessary when visit gfx regesiter via mmio.<br>
<br>
Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" id=3D"m_42861=
24162469801541LPlnk291397" class=3D"m_4286124162469801541OWAAutoLink" targe=
t=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/powerplay<wbr>/hwmgr/smu10_hwmgr.c=C2=A0 | 10 +++=
++++<br>
=C2=A0drivers/gpu/drm/amd/powerplay<wbr>/hwmgr/vega12_hwmgr.c | 31 ++++++++=
+++++++++++++-<br>
=C2=A02 files changed, 40 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerpla<wbr>y/hwmgr/smu10_hwmgr.c b/drive=
rs/gpu/drm/amd/powerpla<wbr>y/hwmgr/smu10_hwmgr.c<br>
index 26d130a..da1be82 100644<br>
--- a/drivers/gpu/drm/amd/powerpla<wbr>y/hwmgr/smu10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/powerpla<wbr>y/hwmgr/smu10_hwmgr.c<br>
@@ -296,6 +296,15 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr)<br=
>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>
=C2=A0}<br>
=C2=A0<br>
+static bool smu10_is_hw_ip_on(struct pp_hwmgr *hwmgr,<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 enum amd_ip_block_type client)<br>
+{<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client =3D=3D AMD_IP_BLOCK_TYPE_G=
FX)<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return smu10_is_gfx_on(hwmgr);<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else /* for other ip, to do */<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return true;<br>
+}<br>
+<br>
=C2=A0static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)<br>
=C2=A0{<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct smu10_hwmgr *smu10_=
data =3D (struct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
@@ -1187,6 +1196,7 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmg=
r, bool bgate)<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .smus_notify_pwe =3D smu10=
_smus_notify_pwe,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .display_clock_voltage_req=
uest =3D smu10_display_clock_voltage_re<wbr>quest,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .powergate_gfx =3D smu10_g=
fx_off_control,<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .is_hw_ip_on =3D smu10_is_hw_ip_on,<b=
r>
=C2=A0};<br>
=C2=A0<br>
=C2=A0int smu10_init_function_pointers(s<wbr>truct pp_hwmgr *hwmgr)<br>
diff --git a/drivers/gpu/drm/amd/powerpla<wbr>y/hwmgr/vega12_hwmgr.c b/driv=
ers/gpu/drm/amd/powerpla<wbr>y/hwmgr/vega12_hwmgr.c<br>
index 0789d64..ee44300 100644<br>
--- a/drivers/gpu/drm/amd/powerpla<wbr>y/hwmgr/vega12_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/powerpla<wbr>y/hwmgr/vega12_hwmgr.c<br>
@@ -45,7 +45,7 @@<br>
=C2=A0#include &quot;ppinterrupt.h&quot;<br>
=C2=A0#include &quot;pp_overdriver.h&quot;<br>
=C2=A0#include &quot;pp_thermal.h&quot;<br>
-<br>
+#include &quot;soc15_common.h&quot;<br>
=C2=A0<br>
=C2=A0static int vega12_force_clock_level(struc<wbr>t pp_hwmgr *hwmgr,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 enum pp_clock_type type, uint32_t mask);<br>
@@ -2320,6 +2320,34 @@ static int vega12_get_thermal_temperature<wbr>_range=
(struct pp_hwmgr *hwmgr,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>
=C2=A0}<br>
=C2=A0<br>
+/* GFX HW Power Status can be queried from bits [1:0] of MP1_SMN_EXT_SCRAT=
CH0<br>
+ * 2&#39;b00=C2=A0=C2=A0 GFX is OFF<br>
+ * 2&#39;b01=C2=A0=C2=A0 Transitioning out of GFXOFF state<br>
+ * 2&#39;b10=C2=A0=C2=A0 GFX is ON<br>
+ * 2&#39;b11=C2=A0=C2=A0 Transitioning into GFXOFF state<br>
+*/<br>
+<br>
+static bool vega12_is_gfx_on(struct pp_hwmgr *hwmgr)<br>
+{<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t tmp;<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *adev =3D hwmgr-=
&gt;adev;<br>
+<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_SOC15(MP1, 0, mmMP1_SM=
N_EXT_SCRATCH0);<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tmp =3D=3D 1 || tmp =3D=3D 2)<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return true;<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return false;<br>
+}<br>
+<br>
+static bool vega12_is_hw_ip_on(struct pp_hwmgr *hwmgr,<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0 enum amd_ip_block_type client)<br>
+{<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client =3D=3D AMD_IP_BLOCK_TYPE_G=
FX)<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return vega12_is_gfx_on(hwmgr);<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else /* for other ip, to do */<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return true;<br>
+}<br>
+<br>
=C2=A0static int vega12_enable_gfx_off(struct pp_hwmgr *hwmgr)<br>
=C2=A0{<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vega12_hwmgr *data =
=3D<br>
@@ -2402,6 +2430,7 @@ static int vega12_gfx_off_control(struct pp_hwmgr *hw=
mgr, bool enable)<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .register_irq_handlers =3D=
 smu9_register_irq_handlers,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .start_thermal_controller =
=3D vega12_start_thermal_controlle<wbr>r,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .powergate_gfx =3D vega12_=
gfx_off_control,<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .is_hw_ip_on =3D vega12_is_hw_ip_on,<=
br>
=C2=A0};<br>
=C2=A0<br>
=C2=A0int vega12_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
-- <br>
1.9.1<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"m_428612416246980154=
1LPlnk449340" class=3D"m_4286124162469801541OWAAutoLink" target=3D"_blank">=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"m_=
4286124162469801541LPlnk571453" class=3D"m_4286124162469801541x_m_-77720213=
5617971185x_OWAAutoLink m_4286124162469801541OWAAutoLink" target=3D"_blank"=
>https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
<div id=3D"m_4286124162469801541x_m_-777202135617971185LPBorder_GT_15329216=
129360.023283015732668888" style=3D"margin-bottom:20px;overflow:auto;width:=
100%;text-indent:0px">
<table id=3D"m_4286124162469801541x_m_-777202135617971185LPContainer_153292=
16129340.4712885778626795" style=3D"width:90%;background-color:rgb(255,255,=
255);overflow:auto;padding-top:20px;padding-bottom:20px;margin-top:20px;bor=
der-top:1px dotted rgb(200,200,200);border-bottom:1px dotted rgb(200,200,20=
0)" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td id=3D"m_4286124162469801541x_m_-777202135617971185x_TextCell_1532921612=
9340.47980485889895885" colspan=3D"2" style=3D"vertical-align:top;padding:0=
px;display:table-cell">
<div id=3D"m_4286124162469801541x_m_-777202135617971185LPRemovePreviewConta=
iner_15329216129340.8736912459594872">
</div>
<div id=3D"m_4286124162469801541x_m_-777202135617971185LPTitle_153292161293=
40.277757395718243" style=3D"color:rgb(0,120,215);font-weight:400;font-size=
:21px;font-family:&quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&quot;,=
&quot;Segoe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma=
,Arial,sans-serif;line-height:21px">
<a id=3D"m_4286124162469801541LPlnk160764" href=3D"https://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx" style=3D"text-decoration:none" class=3D"m_4=
286124162469801541OWAAutoLink" target=3D"_blank">amd-gfx Info Page - freede=
sktop.org</a></div>
<div id=3D"m_4286124162469801541x_m_-777202135617971185LPMetadata_153292161=
29340.9190483966147242" style=3D"margin:10px 0px 16px;color:rgb(102,102,102=
);font-weight:400;font-family:&quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI=
&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;font-size:14px;line-hei=
ght:14px">
<a href=3D"http://lists.freedesktop.org" id=3D"m_4286124162469801541LPlnk71=
1414" class=3D"m_4286124162469801541OWAAutoLink" target=3D"_blank">lists.fr=
eedesktop.org</a></div>
<div id=3D"m_4286124162469801541x_m_-777202135617971185LPDescription_153292=
16129340.6657080067609241" style=3D"display:block;color:rgb(102,102,102);fo=
nt-weight:400;font-family:&quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quo=
t;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;font-size:14px;line-height:=
20px;max-height:100px;overflow:hidden">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all
<a href=3D"http://freedesktop.org" id=3D"m_4286124162469801541LPlnk392662" =
class=3D"m_4286124162469801541OWAAutoLink" target=3D"_blank">
freedesktop.org</a> lists is subject to our Code of Conduct.</div>
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
</div>
</div>
</div>
</div>
</div>
</div>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"m_428612416246980154=
1LPlnk107607" class=3D"m_4286124162469801541OWAAutoLink" target=3D"_blank">=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" id=3D"m_4286124162469801541LPlnk993848" class=3D"m_4286124162469=
801541OWAAutoLink" target=3D"_blank">https://lists.freedesktop.org/<wbr>mai=
lman/listinfo/amd-gfx</a><br>
<br>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br></div></div>

--0000000000005866f9057273ec77--

--===============1455895149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1455895149==--
