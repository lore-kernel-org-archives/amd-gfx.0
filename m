From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd: Don't fail on backlight = 0
Date: Tue, 6 Nov 2018 16:21:56 +0000
Message-ID: <BN6PR12MB1809D72ABCF2D6FF64AA3719F7CB0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181106161446.17462-1-David.Francis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0333396666=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181106161446.17462-1-David.Francis-5C7GfCeVMHo@public.gmane.org>
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
To: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Samantham-VwIFZPTo/vqsTnJN9+BGXg@public.gmane.org" <Samantham-VwIFZPTo/vqsTnJN9+BGXg@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Guttula, Suresh" <Suresh.Guttula-5C7GfCeVMHo@public.gmane.org>

--===============0333396666==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809D72ABCF2D6FF64AA3719F7CB0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809D72ABCF2D6FF64AA3719F7CB0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of David Fr=
ancis <David.Francis-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, November 6, 2018 11:14:46 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Francis, David; Samantham-VwIFZPTo/vqsTnJN9+BGXg@public.gmane.org; Wentland, Harry; Guttula, Suresh
Subject: [PATCH] drm/amd: Don't fail on backlight =3D 0

Amgpu's backlight update status function was
returning 1 (an error value) when the backlight
property was 0.  This breaks users that assume
0 is a valid backlight value (which is a
correct assumption)

If the user passes in a backlight value of 0,
tell them everything is fine, then write a value of
1 to hardware.

Signed-off-by: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>
Bugzilla: https://bugs.freedesktop.org/108668
Fixes: 416615ea9578 ("drm/amd/display: set backlight level limit to 1")
Cc: Suresh.Guttula-5C7GfCeVMHo@public.gmane.org
Cc: Harry.Wentland-5C7GfCeVMHo@public.gmane.org
Cc: Samantham-VwIFZPTo/vqsTnJN9+BGXg@public.gmane.org
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f8ec8a146663..131e6483d442 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1567,21 +1567,23 @@ static int amdgpu_dm_backlight_update_status(struct=
 backlight_device *bd)
 {
         struct amdgpu_display_manager *dm =3D bl_get_data(bd);

+       /* backlight_pwm_u16_16 parameter is in unsigned 32 bit, 16 bit int=
eger
+        * and 16 bit fractional, where 1.0 is max backlight value.
+        * bd->props.brightness is 8 bit format and needs to be converted b=
y
+        * scaling via copy lower byte to upper byte of 16 bit value.
+        */
+       uint32_t brightness =3D bd->props.brightness * 0x101;
+
         /*
          * PWM interperts 0 as 100% rather than 0% because of HW
-        * limitation for level 0.So limiting minimum brightness level
+        * limitation for level 0.  So limiting minimum brightness level
          * to 1.
          */
         if (bd->props.brightness < 1)
-               return 1;
+               brightness =3D 0x101;

-       /* backlight_pwm_u16_16 parameter is in unsigned 32 bit, 16 bit int=
eger
-        * and 16 bit fractional, where 1.0 is max backlight value.
-        * bd->props.brightness is 8 bit format and needs to be converted b=
y
-        * scaling via copy lower byte to upper byte of 16 bit value.
-        */
         if (dc_link_set_backlight_level(dm->backlight_link,
-                       (bd->props.brightness * 0x101), 0, 0))
+                       brightness, 0, 0))
                 return 0;
         else
                 return 1;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809D72ABCF2D6FF64AA3719F7CB0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of David Francis &lt;David.Franc=
is-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, November 6, 2018 11:14:46 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Francis, David; Samantham-VwIFZPTo/vqsTnJN9+BGXg@public.gmane.org; Wentland, Harry; Guttula, =
Suresh<br>
<b>Subject:</b> [PATCH] drm/amd: Don't fail on backlight =3D 0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Amgpu's backlight update status function was<br>
returning 1 (an error value) when the backlight<br>
property was 0.&nbsp; This breaks users that assume<br>
0 is a valid backlight value (which is a<br>
correct assumption)<br>
<br>
If the user passes in a backlight value of 0,<br>
tell them everything is fine, then write a value of<br>
1 to hardware.<br>
<br>
Signed-off-by: David Francis &lt;David.Francis-5C7GfCeVMHo@public.gmane.org&gt;<br>
Bugzilla: <a href=3D"https://bugs.freedesktop.org/108668">https://bugs.free=
desktop.org/108668</a><br>
Fixes: 416615ea9578 (&quot;drm/amd/display: set backlight level limit to 1&=
quot;)<br>
Cc: Suresh.Guttula-5C7GfCeVMHo@public.gmane.org<br>
Cc: Harry.Wentland-5C7GfCeVMHo@public.gmane.org<br>
Cc: Samantham-VwIFZPTo/vqsTnJN9+BGXg@public.gmane.org<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c&nbsp; | 18 &#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--------<br>
&nbsp;1 file changed, 10 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index f8ec8a146663..131e6483d442 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1567,21 &#43;1567,23 @@ static int amdgpu_dm_backlight_update_status(st=
ruct backlight_device *bd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_display_mana=
ger *dm =3D bl_get_data(bd);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* backlight_pwm_u16_16 parameter=
 is in unsigned 32 bit, 16 bit integer<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and 16 bit fractional, wh=
ere 1.0 is max backlight value.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * bd-&gt;props.brightness i=
s 8 bit format and needs to be converted by<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * scaling via copy lower by=
te to upper byte of 16 bit value.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t brightness =3D bd-&gt;pr=
ops.brightness * 0x101;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PWM interperts 0 a=
s 100% rather than 0% because of HW<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * limitation for level 0.So lim=
iting minimum brightness level<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * limitation for level 0.&n=
bsp; So limiting minimum brightness level<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to 1.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bd-&gt;props.brightnes=
s &lt; 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; brightness =3D 0x101;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* backlight_pwm_u16_16 parameter is =
in unsigned 32 bit, 16 bit integer<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and 16 bit fractional, where =
1.0 is max backlight value.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * bd-&gt;props.brightness is 8 =
bit format and needs to be converted by<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * scaling via copy lower byte t=
o upper byte of 16 bit value.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc_link_set_backlight_=
level(dm-&gt;backlight_link,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bd-&gt;props.br=
ightness * 0x101), 0, 0))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brightness, =
0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 1;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809D72ABCF2D6FF64AA3719F7CB0BN6PR12MB1809namp_--

--===============0333396666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0333396666==--
