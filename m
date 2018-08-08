From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: give 8s for recover vram under RUNTIME
Date: Wed, 8 Aug 2018 13:33:28 +0000
Message-ID: <BN6PR12MB180961094A6832B3B9826993F7260@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1533694400-21433-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1497643000=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1533694400-21433-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

--===============1497643000==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180961094A6832B3B9826993F7260BN6PR12MB1809namp_"

--_000_BN6PR12MB180961094A6832B3B9826993F7260BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Emily De=
ng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, August 7, 2018 10:13 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deng, Emily; Liu, Monk
Subject: [PATCH] drm/amdgpu/sriov: give 8s for recover vram under RUNTIME

Modify the commit message

Extend the timeout for recovering vram bos from shadows on sr-iov
to cover the worst case scenario for timeslices and VFs

Under runtime, the wait fence time could be quite long when
other VFs are in exclusive mode. For example, for 4 VF, every
VF's exclusive timeout time is set to 3s, then the worst case is
9s. If the VF number is more than 4,then the worst case time will
be longer.
The 8s is the test data, with setting to 8s, it will pass the TDR
test for 1000 times.

SWDEV-161490

Change-Id: Ifc32d56ca7fde01b1f4fe2b0db6959b51909008a
Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 1d933db..ef82ad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3124,7 +3124,7 @@ static int amdgpu_device_handle_vram_lost(struct amdg=
pu_device *adev)
         long tmo;

         if (amdgpu_sriov_runtime(adev))
-               tmo =3D msecs_to_jiffies(amdgpu_lockup_timeout);
+               tmo =3D msecs_to_jiffies(8000);
         else
                 tmo =3D msecs_to_jiffies(100);

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180961094A6832B3B9826993F7260BN6PR12MB1809namp_
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
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Emily Deng &lt;Emily.Deng@a=
md.com&gt;<br>
<b>Sent:</b> Tuesday, August 7, 2018 10:13 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deng, Emily; Liu, Monk<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sriov: give 8s for recover vram under RU=
NTIME</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Modify the commit message<br>
<br>
Extend the timeout for recovering vram bos from shadows on sr-iov<br>
to cover the worst case scenario for timeslices and VFs<br>
<br>
Under runtime, the wait fence time could be quite long when<br>
other VFs are in exclusive mode. For example, for 4 VF, every<br>
VF's exclusive timeout time is set to 3s, then the worst case is<br>
9s. If the VF number is more than 4,then the worst case time will<br>
be longer.<br>
The 8s is the test data, with setting to 8s, it will pass the TDR<br>
test for 1000 times.<br>
<br>
SWDEV-161490<br>
<br>
Change-Id: Ifc32d56ca7fde01b1f4fe2b0db6959b51909008a<br>
Signed-off-by: Monk Liu &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Emily Deng &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 1d933db..ef82ad1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3124,7 &#43;3124,7 @@ static int amdgpu_device_handle_vram_lost(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long tmo;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_runtime(a=
dev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmo =3D msecs_to_jiffies(amdgpu_lockup_timeout);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmo =3D msecs_to_jiffies(8000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmo =3D msecs_to_jiffies(100);<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk239167" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB180961094A6832B3B9826993F7260BN6PR12MB1809namp_--

--===============1497643000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1497643000==--
