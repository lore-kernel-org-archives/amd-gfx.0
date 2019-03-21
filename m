From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Off by one in
 vega20_get_smu_msg_index()
Date: Thu, 21 Mar 2019 09:37:05 +0000
Message-ID: <MN2PR12MB32969959655A6AE6EDF2F3F2A2420@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190321091957.GA2793@kadam>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0195396498=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190321091957.GA2793@kadam>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Gui,
 Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Gao,
 Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0195396498==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32969959655A6AE6EDF2F3F2A2420MN2PR12MB3296namp_"

--_000_MN2PR12MB32969959655A6AE6EDF2F3F2A2420MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sent: Thursday, March 21, 2019 5:19 PM
To: Deucher, Alexander; Wang, Kevin(Yang)
Cc: Koenig, Christian; Zhou, David(ChunMing); David Airlie; Daniel Vetter; =
Huang, Ray; Gao, Likun; Gui, Jack; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; kernel-ja=
nitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH] drm/amd/powerplay: Off by one in vega20_get_smu_msg_index(=
)

The > should be >=3D so that we don't read one element beyond the end of
the vega20_message_map[] array.

Fixes: 3ec3c931489f ("drm/amd/powerplay: implement smu vega20_message_map f=
or vega20")
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index 7e9e8ad9a300..31cd7b9d4dad 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -132,7 +132,8 @@ static int vega20_message_map[SMU_MSG_MAX_COUNT] =3D {
 static int vega20_get_smu_msg_index(struct smu_context *smc, uint32_t inde=
x)
 {
         int val;
-       if (index > SMU_MSG_MAX_COUNT)
+
+       if (index >=3D SMU_MSG_MAX_COUNT)
                 return -EINVAL;

         val =3D vega20_message_map[index];

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
--
2.17.1


--_000_MN2PR12MB32969959655A6AE6EDF2F3F2A2420MN2PR12MB3296namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dan Carpenter &lt;dan=
.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, March 21, 2019 5:19 PM<br>
<b>To:</b> Deucher, Alexander; Wang, Kevin(Yang)<br>
<b>Cc:</b> Koenig, Christian; Zhou, David(ChunMing); David Airlie; Daniel V=
etter; Huang, Ray; Gao, Likun; Gui, Jack; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; ke=
rnel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: Off by one in vega20_get_smu_msg=
_index()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The &gt; should be &gt;=3D so that we don't read o=
ne element beyond the end of<br>
the vega20_message_map[] array.<br>
<br>
Fixes: 3ec3c931489f (&quot;drm/amd/powerplay: implement smu vega20_message_=
map for vega20&quot;)<br>
Signed-off-by: Dan Carpenter &lt;dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index 7e9e8ad9a300..31cd7b9d4dad 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -132,7 &#43;132,8 @@ static int vega20_message_map[SMU_MSG_MAX_COUNT] =
=3D {<br>
&nbsp;static int vega20_get_smu_msg_index(struct smu_context *smc, uint32_t=
 index)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int val;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt; SMU_MSG_MAX_COUNT)<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt;=3D SMU_MSG_MAX_COU=
NT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D vega20_message_map=
[index];</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt=
;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB32969959655A6AE6EDF2F3F2A2420MN2PR12MB3296namp_--

--===============0195396498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0195396498==--
