From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Fw: [PATCH 2/5] drm/amdgpu: refine pwm1_enable call back functions.
Date: Fri, 5 May 2017 12:42:57 +0000
Message-ID: <CY4PR12MB1687EE2BE8CF419165628D47FBEB0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1493978213-19943-1-git-send-email-Rex.Zhu@amd.com>,
 <1493978213-19943-2-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1713283277=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493978213-19943-2-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============1713283277==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687EE2BE8CF419165628D47FBEB0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687EE2BE8CF419165628D47FBEB0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Change-Id: Ie5fe90762f75497fab68b913874956bbeab11e72
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index e00ed19..1d9d571 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -867,8 +867,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct devi=
ce *dev,

         pwm_mode =3D amdgpu_dpm_get_fan_control_mode(adev);

-       /* never 0 (full-speed), fuse or smc-controlled always */
-       return sprintf(buf, "%i\n", pwm_mode =3D=3D FDO_PWM_MODE_STATIC ? 1=
 : 2);
+       return sprintf(buf, "%i\n", pwm_mode);
 }

 static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
@@ -887,14 +886,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct dev=
ice *dev,
         if (err)
                 return err;

-       switch (value) {
-       case 1: /* manual, percent-based */
-               amdgpu_dpm_set_fan_control_mode(adev, FDO_PWM_MODE_STATIC);
-               break;
-       default: /* disable */
-               amdgpu_dpm_set_fan_control_mode(adev, 0);
-               break;
-       }
+       amdgpu_dpm_set_fan_control_mode(adev, value);

         return count;
 }
--
1.9.1


--_000_CY4PR12MB1687EE2BE8CF419165628D47FBEB0CY4PR12MB1687namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr">
<div></div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Change-Id: Ie5fe90762f75497fab68b913874956bbeab11e=
72<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 12 &#43;&#43;----------<br>
&nbsp;1 file changed, 2 insertions(&#43;), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index e00ed19..1d9d571 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -867,8 &#43;867,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct =
device *dev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pwm_mode =3D amdgpu_dpm_ge=
t_fan_control_mode(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* never 0 (full-speed), fuse or smc-=
controlled always */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%i\n&quot;,=
 pwm_mode =3D=3D FDO_PWM_MODE_STATIC ? 1 : 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%i\n&qu=
ot;, pwm_mode);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,<br>
@@ -887,14 &#43;886,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct=
 device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (value) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1: /* manual, percent-based */<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_set_fan_control_mode(adev, FDO_PWM_MODE_STATIC);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default: /* disable */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_set_fan_control_mode(adev, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_fan_control_mode(a=
dev, value);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&nbsp;}<br>
-- <br>
1.9.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1687EE2BE8CF419165628D47FBEB0CY4PR12MB1687namp_--

--===============1713283277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1713283277==--
