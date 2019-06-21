From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu:  add sw_init to df_v1_7
Date: Fri, 21 Jun 2019 13:58:21 +0000
Message-ID: <BN6PR12MB180927B186CB19A7D5F17008F7E70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190621094526.96749-1-jonathan.kim@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1393051745=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190621094526.96749-1-jonathan.kim-5C7GfCeVMHo@public.gmane.org>
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
To: "Kim, Jonathan" <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1393051745==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180927B186CB19A7D5F17008F7E70BN6PR12MB1809namp_"

--_000_BN6PR12MB180927B186CB19A7D5F17008F7E70BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

If both init and sw_init are empty, we don't need both.  Just rename the in=
it callback to sw_init.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Kim, Jon=
athan <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, June 21, 2019 5:45 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Kim, Jonathan
Subject: [PATCH] drm/amdgpu: add sw_init to df_v1_7

add df sw init to df 1.7 function to prevent regression issues on pre-vega2=
0
products.

Change-Id: I4941003ea4a99ba0ea736c7ecc8800148423c379
Signed-off-by: Jonathan Kim <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amd=
gpu/df_v1_7.c
index 9935371db7ce..335f2c02878f 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -33,6 +33,10 @@ static void df_v1_7_init (struct amdgpu_device *adev)
 {
 }

+static void df_v1_7_sw_init(struct amdgpu_device *adev)
+{
+}
+
 static void df_v1_7_enable_broadcast_mode(struct amdgpu_device *adev,
                                           bool enable)
 {
@@ -111,6 +115,7 @@ static void df_v1_7_enable_ecc_force_par_wr_rmw(struct =
amdgpu_device *adev,

 const struct amdgpu_df_funcs df_v1_7_funcs =3D {
         .init =3D df_v1_7_init,
+       .sw_init =3D df_v1_7_sw_init,
         .enable_broadcast_mode =3D df_v1_7_enable_broadcast_mode,
         .get_fb_channel_number =3D df_v1_7_get_fb_channel_number,
         .get_hbm_channel_number =3D df_v1_7_get_hbm_channel_number,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180927B186CB19A7D5F17008F7E70BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
If both init and sw_init are empty, we don't need both.&nbsp; Just rename t=
he init callback to sw_init.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Kim, Jonathan &lt;Jonathan.Ki=
m@amd.com&gt;<br>
<b>Sent:</b> Friday, June 21, 2019 5:45 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Kim, Jonathan<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add sw_init to df_v1_7</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">add df sw init to df 1.7 function to prevent regre=
ssion issues on pre-vega20<br>
products.<br>
<br>
Change-Id: I4941003ea4a99ba0ea736c7ecc8800148423c379<br>
Signed-off-by: Jonathan Kim &lt;Jonathan.Kim-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/df_v1_7.c | 5 &#43;&#43;&#43;&#43;&#43;<br=
>
&nbsp;1 file changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amd=
gpu/df_v1_7.c<br>
index 9935371db7ce..335f2c02878f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c<br>
@@ -33,6 &#43;33,10 @@ static void df_v1_7_init (struct amdgpu_device *adev=
)<br>
&nbsp;{<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void df_v1_7_sw_init(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;}<br>
&#43;<br>
&nbsp;static void df_v1_7_enable_broadcast_mode(struct amdgpu_device *adev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&nbsp;{<br>
@@ -111,6 &#43;115,7 @@ static void df_v1_7_enable_ecc_force_par_wr_rmw(str=
uct amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;const struct amdgpu_df_funcs df_v1_7_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init =3D df_v1_7_init,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sw_init =3D df_v1_7_sw_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_broadcast_mode =3D=
 df_v1_7_enable_broadcast_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fb_channel_number =3D=
 df_v1_7_get_fb_channel_number,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hbm_channel_number =
=3D df_v1_7_get_hbm_channel_number,<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180927B186CB19A7D5F17008F7E70BN6PR12MB1809namp_--

--===============1393051745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1393051745==--
