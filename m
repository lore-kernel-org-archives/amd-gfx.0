From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check support on
 Rv/Vega12
Date: Thu, 2 Aug 2018 10:22:39 +0000
Message-ID: <CY4PR12MB1687D8D4388E80BE18A677F8FB2C0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1532864547-1072-1-git-send-email-rex.zhu@amd.com>
 <1532864547-1072-3-git-send-email-rex.zhu@amd.com>
 <SN6PR12MB2656D918D6DBD7C1932747BFE42F0@SN6PR12MB2656.namprd12.prod.outlook.com>
 <CY4PR12MB1687B6284781F05DDD30ACA6FB2F0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <CY4PR12MB168799400EFB54D63F9EAE6CFB2D0@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <CADnq5_N_BsHR9WCMcZ04wt+jL=6bCB_R=m2w=w+nb_O7Ugnj_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1963709479=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_N_BsHR9WCMcZ04wt+jL=6bCB_R=m2w=w+nb_O7Ugnj_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Quan,
 Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1963709479==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687D8D4388E80BE18A677F8FB2C0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687D8D4388E80BE18A677F8FB2C0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Currently, there is no use case except for debug.

So I will keep the patches in my local.

Thanks.



Best Regards

Rex



________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, August 1, 2018 11:13 PM
To: Zhu, Rex
Cc: Deucher, Alexander; Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check support on =
Rv/Vega12

Does anything use it?  Might be useful for debugging, but I guess you'd pro=
bably use something like umr in that case.

Alex

On Tue, Jul 31, 2018 at 9:15 PM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu@a=
md.com>> wrote:

Hi Alex,


Is it necessary to export an interface as "is_gfx_on" in powerplay to amdgp=
u?

It can show the current power state of gfx ip.



Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.=
Zhu-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, July 30, 2018 11:39 AM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org>

Subject: Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check support on =
Rv/Vega12


> It means user was told the gfx is on but actually it may switches to gfxo=
ff already.


Correct.

So if the gfx is off, user should disable gfx off feature before they read/=
write the registers via mmio.

if gfx is on, that is not mean the gfx off feature is disabled. it  doesn't=
 mean it is safe to visit the registers through mmio.


Best Regards

Rex

________________________________
From: Quan, Evan
Sent: Monday, July 30, 2018 9:31 AM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org>
Subject: Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check support on =
Rv/Vega12


Since the gfxoff is always in dynamic switch, i do not think the status rep=
orted to user is reliable. It means user was told the gfx is on but actuall=
y it may switches to gfxoff already.


Regards,

Evan


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org<mailto:rex.z=
hu-5C7GfCeVMHo@public.gmane.org>>
Sent: Sunday, July 29, 2018 7:42:27 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Zhu, Rex
Subject: [PATCH 3/3] drm/amd/pp: Add gfx power status check support on Rv/V=
ega12

As gfx off is supported on Rv/Vega12, so this check is
helpful and necessary when visit gfx regesiter via mmio.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  | 10 +++++++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 31 ++++++++++++++++++=
+++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 26d130a..da1be82 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -296,6 +296,15 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr)
         return false;
 }

+static bool smu10_is_hw_ip_on(struct pp_hwmgr *hwmgr,
+                               enum amd_ip_block_type client)
+{
+       if (client =3D=3D AMD_IP_BLOCK_TYPE_GFX)
+               return smu10_is_gfx_on(hwmgr);
+       else /* for other ip, to do */
+               return true;
+}
+
 static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)
 {
         struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->b=
ackend);
@@ -1187,6 +1196,7 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmg=
r, bool bgate)
         .smus_notify_pwe =3D smu10_smus_notify_pwe,
         .display_clock_voltage_request =3D smu10_display_clock_voltage_req=
uest,
         .powergate_gfx =3D smu10_gfx_off_control,
+       .is_hw_ip_on =3D smu10_is_hw_ip_on,
 };

 int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index 0789d64..ee44300 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -45,7 +45,7 @@
 #include "ppinterrupt.h"
 #include "pp_overdriver.h"
 #include "pp_thermal.h"
-
+#include "soc15_common.h"

 static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
                 enum pp_clock_type type, uint32_t mask);
@@ -2320,6 +2320,34 @@ static int vega12_get_thermal_temperature_range(stru=
ct pp_hwmgr *hwmgr,
         return 0;
 }

+/* GFX HW Power Status can be queried from bits [1:0] of MP1_SMN_EXT_SCRAT=
CH0
+ * 2'b00   GFX is OFF
+ * 2'b01   Transitioning out of GFXOFF state
+ * 2'b10   GFX is ON
+ * 2'b11   Transitioning into GFXOFF state
+*/
+
+static bool vega12_is_gfx_on(struct pp_hwmgr *hwmgr)
+{
+       uint32_t tmp;
+       struct amdgpu_device *adev =3D hwmgr->adev;
+
+       tmp =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
+       if (tmp =3D=3D 1 || tmp =3D=3D 2)
+               return true;
+       else
+               return false;
+}
+
+static bool vega12_is_hw_ip_on(struct pp_hwmgr *hwmgr,
+                               enum amd_ip_block_type client)
+{
+       if (client =3D=3D AMD_IP_BLOCK_TYPE_GFX)
+               return vega12_is_gfx_on(hwmgr);
+       else /* for other ip, to do */
+               return true;
+}
+
 static int vega12_enable_gfx_off(struct pp_hwmgr *hwmgr)
 {
         struct vega12_hwmgr *data =3D
@@ -2402,6 +2430,7 @@ static int vega12_gfx_off_control(struct pp_hwmgr *hw=
mgr, bool enable)
         .register_irq_handlers =3D smu9_register_irq_handlers,
         .start_thermal_controller =3D vega12_start_thermal_controller,
         .powergate_gfx =3D vega12_gfx_off_control,
+       .is_hw_ip_on =3D vega12_is_hw_ip_on,
 };

 int vega12_hwmgr_init(struct pp_hwmgr *hwmgr)
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org<http://lists.freedesktop.org>
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org<http://freedesktop.org> lists is subject to=
 our Code of Conduct.



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_CY4PR12MB1687D8D4388E80BE18A677F8FB2C0CY4PR12MB1687namp_
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
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Alex Deucher &lt;ale=
xdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, August 1, 2018 11:13 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> Deucher, Alexander; Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br=
>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check supp=
ort on Rv/Vega12</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Dutf-8">
<div>
<div dir=3D"ltr">
<div>Does anything use it?&nbsp; Might be useful for debugging, but I guess=
 you'd probably use something like umr in that case.</div>
<div><br>
</div>
<div>Alex<br>
</div>
<div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">On Tue, Jul 31, 2018 at 9:15 PM, Zhu, Rex <spa=
n dir=3D"ltr">
&lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" id=3D"LPlnk913312"=
 class=3D"OWAAutoLink" previewremoved=3D"true">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"x_m_-777202135617971185divtagdefaultwrapper" dir=3D"ltr" style=
=3D"font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif=
">
<p style=3D"margin-top:0; margin-bottom:0">Hi Alex,</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Is it necessary to export an int=
erface as &quot;is_gfx_on&quot; in powerplay to amdgpu?</p>
<p style=3D"margin-top:0; margin-bottom:0">It can show the current power st=
ate of&nbsp;gfx ip.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0; margin-bottom:0">Rex&nbsp;</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"x_m_-777202135617971185divRplyFwdMsg" dir=3D"ltr"><font style=3D=
"font-size:11pt" color=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b=
> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" targ=
et=3D"_blank" id=3D"LPlnk303975" class=3D"OWAAutoLink" previewremoved=3D"tr=
ue">amd-gfx-bounces@lists.<wbr>freedesktop.org</a>&gt;
 on behalf of Zhu, Rex &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_bl=
ank" id=3D"LPlnk834453" class=3D"OWAAutoLink" previewremoved=3D"true">Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Monday, July 30, 2018 11:39 AM<br>
<b>To:</b> Quan, Evan; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" tar=
get=3D"_blank" id=3D"LPlnk303555" class=3D"OWAAutoLink" previewremoved=3D"t=
rue">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<div>
<div class=3D"x_h5"><br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check supp=
ort on Rv/Vega12</div>
</div>
</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"x_h5">
<div dir=3D"ltr">
<div id=3D"x_m_-777202135617971185x_divtagdefaultwrapper" dir=3D"ltr" style=
=3D"font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif=
">
<p style=3D"margin-top:0; margin-bottom:0"><span>&gt; It means user was tol=
d the gfx is on but actually it may switches to gfxoff already.</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span></span><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Correct. <br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">So if the gfx is off, user shoul=
d disable gfx off feature before they read/write the registers via mmio.</p=
>
<p style=3D"margin-top:0; margin-bottom:0">if gfx is on, that is not mean t=
he gfx off feature is disabled. it&nbsp; doesn't mean it is safe to visit t=
he registers through mmio.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0; margin-bottom:0">Rex<br>
</p>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"x_m_-777202135617971185x_divRplyFwdMsg" dir=3D"ltr"><font style=
=3D"font-size:11pt" color=3D"#000000" face=3D"Calibri, sans-serif"><b>From:=
</b> Quan, Evan<br>
<b>Sent:</b> Monday, July 30, 2018 9:31 AM<br>
<b>To:</b> Zhu, Rex; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" targe=
t=3D"_blank" id=3D"LPlnk843060" class=3D"OWAAutoLink" previewremoved=3D"tru=
e">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check supp=
ort on Rv/Vega12</font>
<div>&nbsp;</div>
</div>
<div dir=3D"ltr">
<div id=3D"x_m_-777202135617971185x_x_divtagdefaultwrapper" dir=3D"ltr" sty=
le=3D"font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-ser=
if">
<p style=3D"margin-top:0; margin-bottom:0">Since the gfxoff is always in dy=
namic switch, i do not think the status reported to user is reliable. It me=
ans user was told the gfx is on but actually it may switches to gfxoff alre=
ady.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Regards,</p>
<p style=3D"margin-top:0; margin-bottom:0">Evan</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
</div>
<hr style=3D"display:inline-block; width:98%">
<div id=3D"x_m_-777202135617971185x_x_divRplyFwdMsg" dir=3D"ltr"><font styl=
e=3D"font-size:11pt" color=3D"#000000" face=3D"Calibri, sans-serif"><b>From=
:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" =
target=3D"_blank" id=3D"LPlnk224967" class=3D"OWAAutoLink" previewremoved=
=3D"true">amd-gfx-bounces@lists.<wbr>freedesktop.org</a>&gt;
 on behalf of Rex Zhu &lt;<a href=3D"mailto:rex.zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_bla=
nk" id=3D"LPlnk198810" class=3D"OWAAutoLink" previewremoved=3D"true">rex.zh=
u@amd.com</a>&gt;<br>
<b>Sent:</b> Sunday, July 29, 2018 7:42:27 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k" id=3D"LPlnk622661" class=3D"OWAAutoLink" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/pp: Add gfx power status check support =
on Rv/Vega12</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_m_-777202135617971185x_x_BodyFragment"><font size=3D"2"><sp=
an style=3D"font-size:11pt">
<div class=3D"x_m_-777202135617971185x_x_PlainText">As gfx off is supported=
 on Rv/Vega12, so this check is<br>
helpful and necessary when visit gfx regesiter via mmio.<br>
<br>
Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_bl=
ank" id=3D"LPlnk291397" class=3D"OWAAutoLink" previewremoved=3D"true">Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu10_hwmgr.c&nbsp; | 10 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/vega12_hwmgr.c | 31 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;-<br>
&nbsp;2 files changed, 40 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu10_hwmgr.c b/drive=
rs/gpu/drm/amd/<wbr>powerplay/hwmgr/smu10_hwmgr.c<br>
index 26d130a..da1be82 100644<br>
--- a/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/smu10_hwmgr.c<br=
>
@@ -296,6 &#43;296,15 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static bool smu10_is_hw_ip_on(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<wbr>&nbsp; enum amd_ip_block_type client)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (client =3D=3D AMD_IP_BLOCK_TY=
PE_GFX)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return smu10_is_gfx_on(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else /* for other ip, to do */<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_=
data =3D (struct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
@@ -1187,6 &#43;1196,7 @@ static void smu10_powergate_vcn(struct pp_hwmgr *=
hwmgr, bool bgate)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smus_notify_pwe =3D smu10=
_smus_notify_pwe,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_voltage_req=
uest =3D smu10_display_clock_voltage_<wbr>request,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_gfx =3D smu10_g=
fx_off_control,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_hw_ip_on =3D smu10_is_hw_ip_o=
n,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int smu10_init_function_pointers(<wbr>struct pp_hwmgr *hwmgr)<br>
diff --git a/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/vega12_hwmgr.c b/driv=
ers/gpu/drm/amd/<wbr>powerplay/hwmgr/vega12_hwmgr.c<br>
index 0789d64..ee44300 100644<br>
--- a/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/vega12_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/<wbr>powerplay/hwmgr/vega12_hwmgr.c<b=
r>
@@ -45,7 &#43;45,7 @@<br>
&nbsp;#include &quot;ppinterrupt.h&quot;<br>
&nbsp;#include &quot;pp_overdriver.h&quot;<br>
&nbsp;#include &quot;pp_thermal.h&quot;<br>
-<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;<br>
&nbsp;static int vega12_force_clock_level(<wbr>struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type, uint32_t mask);<br>
@@ -2320,6 &#43;2320,34 @@ static int vega12_get_thermal_<wbr>temperature_r=
ange(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/* GFX HW Power Status can be queried from bits [1:0] of MP1_SMN_EXT_S=
CRATCH0<br>
&#43; * 2'b00&nbsp;&nbsp; GFX is OFF<br>
&#43; * 2'b01&nbsp;&nbsp; Transitioning out of GFXOFF state<br>
&#43; * 2'b10&nbsp;&nbsp; GFX is ON<br>
&#43; * 2'b11&nbsp;&nbsp; Transitioning into GFXOFF state<br>
&#43;*/<br>
&#43;<br>
&#43;static bool vega12_is_gfx_on(struct pp_hwmgr *hwmgr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(MP1, 0, mmMP=
1_SMN_EXT_SCRATCH0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp =3D=3D 1 || tmp =3D=3D 2)=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;}<br>
&#43;<br>
&#43;static bool vega12_is_hw_ip_on(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<wbr>&nbsp; enum amd_ip_block_type client)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (client =3D=3D AMD_IP_BLOCK_TY=
PE_GFX)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return vega12_is_gfx_on(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else /* for other ip, to do */<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int vega12_enable_gfx_off(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =
=3D<br>
@@ -2402,6 &#43;2430,7 @@ static int vega12_gfx_off_control(struct pp_hwmgr=
 *hwmgr, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handlers =3D=
 smu9_register_irq_handlers,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_thermal_controller =
=3D vega12_start_thermal_<wbr>controller,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_gfx =3D vega12_=
gfx_off_control,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_hw_ip_on =3D vega12_is_hw_ip_=
on,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int vega12_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
-- <br>
1.9.1<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" id=3D"LP=
lnk449340" class=3D"OWAAutoLink" previewremoved=3D"true">amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk571453" class=3D"x_m_-777202135617971185x_OWAAutoLink OWAAutoLink" targe=
t=3D"_blank" previewremoved=3D"true">https://lists.freedesktop.org/<wbr>mai=
lman/listinfo/amd-gfx</a>
<div id=3D"x_m_-777202135617971185LPBorder_GT_15329216129360.02328301573266=
8888" style=3D"margin-bottom:20px; overflow:auto; width:100%; text-indent:0=
px">
<table id=3D"x_m_-777202135617971185LPContainer_15329216129340.471288577862=
6795" style=3D"width:90%; background-color:rgb(255,255,255); overflow:auto;=
 padding-top:20px; padding-bottom:20px; margin-top:20px; border-top:1px dot=
ted rgb(200,200,200); border-bottom:1px dotted rgb(200,200,200)" cellspacin=
g=3D"0">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td id=3D"x_m_-777202135617971185x_TextCell_15329216129340.4798048588989588=
5" colspan=3D"2" style=3D"vertical-align:top; padding:0px; display:table-ce=
ll">
<div id=3D"x_m_-777202135617971185LPRemovePreviewContainer_15329216129340.8=
736912459594872">
</div>
<div id=3D"x_m_-777202135617971185LPTitle_15329216129340.277757395718243" s=
tyle=3D"color:rgb(0,120,215); font-weight:400; font-size:21px; font-family:=
&quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Lig=
ht&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;=
 line-height:21px">
<a id=3D"LPlnk160764" href=3D"https://lists.freedesktop.org/mailman/listinf=
o/amd-gfx" target=3D"_blank" style=3D"text-decoration:none" class=3D"OWAAut=
oLink" previewremoved=3D"true">amd-gfx Info Page - freedesktop.org</a></div=
>
<div id=3D"x_m_-777202135617971185LPMetadata_15329216129340.919048396614724=
2" style=3D"margin:10px 0px 16px; color:rgb(102,102,102); font-weight:400; =
font-family:&quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe=
 WP&quot;,Tahoma,Arial,sans-serif; font-size:14px; line-height:14px">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank" id=3D"LPlnk71141=
4" class=3D"OWAAutoLink" previewremoved=3D"true">lists.freedesktop.org</a><=
/div>
<div id=3D"x_m_-777202135617971185LPDescription_15329216129340.665708006760=
9241" style=3D"display:block; color:rgb(102,102,102); font-weight:400; font=
-family:&quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&=
quot;,Tahoma,Arial,sans-serif; font-size:14px; line-height:20px; max-height=
:100px; overflow:hidden">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all
<a href=3D"http://freedesktop.org" target=3D"_blank" id=3D"LPlnk392662" cla=
ss=3D"OWAAutoLink" previewremoved=3D"true">
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
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk107607" class=
=3D"OWAAutoLink" previewremoved=3D"true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><=
br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank" id=3D"LPlnk993848" class=3D"OWAAutoLink" previ=
ewremoved=3D"true">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-=
gfx</a><br>
<br>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687D8D4388E80BE18A677F8FB2C0CY4PR12MB1687namp_--

--===============1963709479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1963709479==--
