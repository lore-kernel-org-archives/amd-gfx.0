From: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: omit fbcon error under sriov or
 passthrough
Date: Wed, 18 Sep 2019 08:08:13 +0000
Message-ID: <MN2PR12MB2975F41EE42811399F0016C28F8E0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <20190918072445.3559-1-Jack.Zhang1@amd.com>,
 <DM6PR12MB367564A4AAC093F841D88018BB8E0@DM6PR12MB3675.namprd12.prod.outlook.com>
 <2a7e5c50-7af0-4af1-a46d-834943ab810c@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1057948386=="
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
Cc: "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, "Teng, Rui" <Rui.Teng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1057948386==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2975F41EE42811399F0016C28F8E0MN2PR12MB2975namp_"

--_000_MN2PR12MB2975F41EE42811399F0016C28F8E0MN2PR12MB2975namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Christian,
     Before unloading driver, user must sure there is not any userspace to =
use of amdgpu, if not, it will report driver is in use. And the unloading d=
river is a feature about amdgpu driver which will be easier to replace driv=
er without rebooting VM. Do you think it has any issue about driver unloadi=
ng path?

Best wishes
Emily Deng
From: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, September 18, 2019 3:54 PM
To: Zhang, Jack (Jian) <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Teng, Rui <Rui.Teng-5C7GfCeVMHo@public.gmane.org>; Deng, Emil=
y <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; Cui, Flora <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
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



Am 18.09.2019 09:32 schrieb "Zhang, Jack (Jian)" <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org<mailt=
o:Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>>:
Hi, Christian and folks,

In virtual machines(such virt-manager), there's always a virtual graphics d=
evice existed like "qxl" as the default gfx device.
So under such condition, we believe it's reasonable to unload amdgpu driver=
 as it is not treated as the default fbcon device.

Would you please help to review this patch?

Best wishes,
Jack

-----Original Message-----
From: Jack Zhang <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org<mailto:Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>>
Sent: Wednesday, September 18, 2019 3:25 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Zhang, Jack (Jian) <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org<mailto:Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH] drm/amdgpu/sriov: omit fbcon error under sriov or passthro=
ugh

In virtual machine, there would be a qxl or cirrus graphics device as the d=
efault master fbcon device.

So for PF(passthrough mode) or SRIOV VF, it is reasonable to unload amdgpu =
driver. Amdgpu doesn't have to be the only fbcon device under this conditio=
n.

Signed-off-by: Jack Zhang <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org<mailto:Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>>
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

--_000_MN2PR12MB2975F41EE42811399F0016C28F8E0MN2PR12MB2975namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:1.0pt;
	border:none;
	padding:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Christian,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Before unloading driver, us=
er must sure there is not any userspace to use of amdgpu, if not, it will r=
eport driver is in use. And the unloading driver is a feature about amdgpu =
driver which will be easier to replace driver without
 rebooting VM. Do you think it has any issue about driver unloading path?<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best wishes<o:p></o:p></p>
<p class=3D"MsoNormal">Emily Deng<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian &lt;Christian.Koenig@=
amd.com&gt; <br>
<b>Sent:</b> Wednesday, September 18, 2019 3:54 PM<br>
<b>To:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Teng, Rui &lt;Rui.Teng-5C7GfCeVMHo@public.gmane.org&gt=
;; Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;; Cui, Flora &lt;Flora.Cui-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/sriov: omit fbcon error under sriov =
or passthrough<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">Hi Jack,<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Well that believe is unfortunately completely wrong.=
<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">The point is that ANY use of amdgpu by userspace wil=
l prevent correct driver unload, that qxl is used for the fbcon doesn't cha=
nge anything here.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">So the patch is a clear NAK. Driver unload is not su=
pposed to work even under SRIOV.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Christian.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Am 18.09.2019 09:32 schrieb &quot;Zhang, Jack (Jian)=
&quot; &lt;<a href=3D"mailto:Jack.Zhang1-5C7GfCeVMHo@public.gmane.org">Jack.Zhang1-5C7GfCeVMHo@public.gmane.org</a>&g=
t;:<o:p></o:p></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Hi, Christian and fol=
ks,<br>
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
From: Jack Zhang &lt;<a href=3D"mailto:Jack.Zhang1-5C7GfCeVMHo@public.gmane.org">Jack.Zhang1@amd=
.com</a>&gt; <br>
Sent: Wednesday, September 18, 2019 3:25 PM<br>
To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org</a><br>
Cc: Zhang, Jack (Jian) &lt;<a href=3D"mailto:Jack.Zhang1-5C7GfCeVMHo@public.gmane.org">Jack.Zhan=
g1-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
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
Signed-off-by: Jack Zhang &lt;<a href=3D"mailto:Jack.Zhang1-5C7GfCeVMHo@public.gmane.org">Jack.Z=
hang1-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
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
2.7.4<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB2975F41EE42811399F0016C28F8E0MN2PR12MB2975namp_--

--===============1057948386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1057948386==--
