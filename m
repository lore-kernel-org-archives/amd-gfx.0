From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sriov: omit fbcon error under sriov or
 passthrough
Date: Wed, 18 Sep 2019 12:50:18 +0000
Message-ID: <BN6PR12MB1809EE8D0A4C188737F89FC2F78E0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190918072445.3559-1-Jack.Zhang1@amd.com>,
 <DM6PR12MB367564A4AAC093F841D88018BB8E0@DM6PR12MB3675.namprd12.prod.outlook.com>,
 <2a7e5c50-7af0-4af1-a46d-834943ab810c@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1476695665=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2a7e5c50-7af0-4af1-a46d-834943ab810c-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhang, Jack (Jian)" <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>
Cc: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, "Teng,
 Rui" <Rui.Teng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1476695665==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809EE8D0A4C188737F89FC2F78E0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809EE8D0A4C188737F89FC2F78E0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Driver unload works fine (barring any bugs) as long as you are not using th=
e device.  E.g., unbound the fbcon and no apps are using the GPU.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Koenig, =
Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, September 18, 2019 3:53 AM
To: Zhang, Jack (Jian) <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>
Cc: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; Cui, Flora <Flora.Cui-5C7GfCeVMHo@public.gmane.org>; Teng,=
 Rui <Rui.Teng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: omit fbcon error under sriov or pass=
through

Hi Jack,

Well that believe is unfortunately completely wrong.

The point is that ANY use of amdgpu by userspace will prevent correct drive=
r unload, that qxl is used for the fbcon doesn't change anything here.

So the patch is a clear NAK. Driver unload is not supposed to work even und=
er SRIOV.

Regards,
Christian.



Am 18.09.2019 09:32 schrieb "Zhang, Jack (Jian)" <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>:
Hi, Christian and folks,

In virtual machines(such virt-manager), there's always a virtual graphics d=
evice existed like "qxl" as the default gfx device.
So under such condition, we believe it's reasonable to unload amdgpu driver=
 as it is not treated as the default fbcon device.

Would you please help to review this patch?

Best wishes,
Jack

-----Original Message-----
From: Jack Zhang <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, September 18, 2019 3:25 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/sriov: omit fbcon error under sriov or passthro=
ugh

In virtual machine, there would be a qxl or cirrus graphics device as the d=
efault master fbcon device.

So for PF(passthrough mode) or SRIOV VF, it is reasonable to unload amdgpu =
driver. Amdgpu doesn't have to be the only fbcon device under this conditio=
n.

Signed-off-by: Jack Zhang <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 420888e..ada2b25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1103,8 +1103,9 @@ static void
 amdgpu_pci_remove(struct pci_dev *pdev)  {
         struct drm_device *dev =3D pci_get_drvdata(pdev);
-
-       DRM_ERROR("Device removal is currently not supported outside of fbc=
on\n");
+       struct amdgpu_device *adev =3D dev->dev_private;
+       if (!amdgpu_sriov_vf(adev) && !amdgpu_passthrough(adev))
+               DRM_ERROR("Device removal is currently not supported outsid=
e of
+fbcon\n");
         drm_dev_unplug(dev);
         drm_dev_put(dev);
         pci_disable_device(pdev);
--
2.7.4


--_000_BN6PR12MB1809EE8D0A4C188737F89FC2F78E0BN6PR12MB1809namp_
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
Driver unload works fine (barring any bugs) as long as you are not using th=
e device.&nbsp; E.g., unbound the fbcon and no apps are using the GPU.</div=
>
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Koenig, Christian &lt;Christi=
an.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, September 18, 2019 3:53 AM<br>
<b>To:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;; Cui, Flora &lt;Flora.Cui=
@amd.com&gt;; Teng, Rui &lt;Rui.Teng-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/sriov: omit fbcon error under sriov =
or passthrough</font>
<div>&nbsp;</div>
</div>
<style>
<!--
.x_EmailQuote
	{margin-left:1pt;
	padding-left:4pt;
	border-left:#800000 2px solid}
-->
</style>
<div>
<div>
<div dir=3D"auto">Hi Jack,
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Well that believe is unfortunately completely wrong.</div=
>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">The point is that ANY use of amdgpu by userspace will pre=
vent correct driver unload, that qxl is used for the fbcon doesn't change a=
nything here.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">So the patch is a clear NAK. Driver unload is not suppose=
d to work even under SRIOV.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards,</div>
<div dir=3D"auto">Christian.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto"><br>
</div>
</div>
<div class=3D"x_x_gmail_extra"><br>
<div class=3D"x_x_gmail_quote">Am 18.09.2019 09:32 schrieb &quot;Zhang, Jac=
k (Jian)&quot; &lt;Jack.Zhang1-5C7GfCeVMHo@public.gmane.org&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt">
<div class=3D"x_PlainText">Hi, Christian and folks,<br>
<br>
In virtual machines(such virt-manager), there's always a virtual graphics d=
evice existed like &quot;qxl&quot; as the default gfx device.<br>
So under such condition, we believe it's reasonable to unload amdgpu driver=
 as it is not treated as the default fbcon device.<br>
<br>
Would you please help to review this patch?<br>
<br>
Best wishes,<br>
Jack<br>
<br>
-----Original Message-----<br>
From: Jack Zhang &lt;Jack.Zhang1-5C7GfCeVMHo@public.gmane.org&gt; <br>
Sent: Wednesday, September 18, 2019 3:25 PM<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Zhang, Jack (Jian) &lt;Jack.Zhang1-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH] drm/amdgpu/sriov: omit fbcon error under sriov or passthro=
ugh<br>
<br>
In virtual machine, there would be a qxl or cirrus graphics device as the d=
efault master fbcon device.<br>
<br>
So for PF(passthrough mode) or SRIOV VF, it is reasonable to unload amdgpu =
driver. Amdgpu doesn't have to be the only fbcon device under this conditio=
n.<br>
<br>
Signed-off-by: Jack Zhang &lt;Jack.Zhang1-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 &#43;&#43;&#43;--<br>
&nbsp;1 file changed, 3 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 420888e..ada2b25 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1103,8 &#43;1103,9 @@ static void<br>
&nbsp;amdgpu_pci_remove(struct pci_dev *pdev)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D=
 pci_get_drvdata(pdev);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Device removal is cur=
rently not supported outside of fbcon\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D de=
v-&gt;dev_private;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) &amp;&=
amp; !amdgpu_passthrough(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_ERROR(&quot;Device removal is currently not supported ou=
tside of <br>
&#43;fbcon\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_unplug(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_put(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_disable_device(pdev);<=
br>
--<br>
2.7.4<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809EE8D0A4C188737F89FC2F78E0BN6PR12MB1809namp_--

--===============1476695665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1476695665==--
