From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Fw: [PATCH 1/5] drm/amdgpu: add amd fan ctrl mode define.
Date: Fri, 5 May 2017 12:44:25 +0000
Message-ID: <CY4PR12MB16877AC642C356214CE59F18FBEB0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1493978213-19943-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0501912140=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493978213-19943-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============0501912140==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16877AC642C356214CE59F18FBEB0CY4PR12MB1687namp_"

--_000_CY4PR12MB16877AC642C356214CE59F18FBEB0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Change-Id: Ida8f8168d9600503146b5140ea47c913733888cf
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index 2ccf44e..1d1ac1e 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -138,6 +138,12 @@ struct amd_pp_profile {
         uint8_t down_hyst;
 };

+enum amd_fan_ctrl_mode {
+       AMD_FAN_CTRL_NONE =3D 0,
+       AMD_FAN_CTRL_MANUAL =3D 1,
+       AMD_FAN_CTRL_AUTO =3D 2,
+};
+
 /* CG flags */
 #define AMD_CG_SUPPORT_GFX_MGCG                 (1 << 0)
 #define AMD_CG_SUPPORT_GFX_MGLS                 (1 << 1)
--
1.9.1


--_000_CY4PR12MB16877AC642C356214CE59F18FBEB0CY4PR12MB1687namp_
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
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sans-serif, EmojiF=
ont, 'Apple Color Emoji', 'Segoe UI Emoji', NotoColorEmoji, 'Segoe UI Symbo=
l', 'Android Emoji', EmojiSymbols;">
<p><span style=3D"font-size:12pt">&nbsp;</span><br>
</p>
<div style=3D"color:rgb(0,0,0)"><font size=3D"2"><span style=3D"font-size:1=
0pt">
<div class=3D"PlainText">Change-Id: Ida8f8168d9600503146b5140ea47c913733888=
cf<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/amd_shared.h | 6 &#43;&#43;&#43;&#43;&#43=
;&#43;<br>
&nbsp;1 file changed, 6 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h<br>
index 2ccf44e..1d1ac1e 100644<br>
--- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/amd_shared.h<br>
@@ -138,6 &#43;138,12 @@ struct amd_pp_profile {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t down_hyst;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;enum amd_fan_ctrl_mode {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_FAN_CTRL_NONE =3D 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_FAN_CTRL_MANUAL =3D 1,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_FAN_CTRL_AUTO =3D 2,<br>
&#43;};<br>
&#43;<br>
&nbsp;/* CG flags */<br>
&nbsp;#define AMD_CG_SUPPORT_GFX_MGCG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 0)<b=
r>
&nbsp;#define AMD_CG_SUPPORT_GFX_MGLS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 1)<b=
r>
-- <br>
1.9.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB16877AC642C356214CE59F18FBEB0CY4PR12MB1687namp_--

--===============0501912140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0501912140==--
