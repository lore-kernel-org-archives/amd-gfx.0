From: "Kim, Jonathan" <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole
 hive initialized
Date: Wed, 6 Nov 2019 02:17:37 +0000
Message-ID: <CH2PR12MB383150DB7FA13B7E5472A37085790@CH2PR12MB3831.namprd12.prod.outlook.com>
References: <20191105102310.16657-1-evan.quan@amd.com>
 <20191105102310.16657-2-evan.quan@amd.com>,
 <CH2PR12MB3831CEABDD4CBA2FEB8DEFEB857E0@CH2PR12MB3831.namprd12.prod.outlook.com>
 <DM5PR12MB248696FDB2D0E563221E7CDFE87E0@DM5PR12MB2486.namprd12.prod.outlook.com>
 <CH2PR12MB3831D16D352FA009002800CC857E0@CH2PR12MB3831.namprd12.prod.outlook.com>
 <CH2PR12MB3831868F2A7B4A8BCCBA24F7857E0@CH2PR12MB3831.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1843229056=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CH2PR12MB3831868F2A7B4A8BCCBA24F7857E0-rV3HgkLYx2Wb1l0FfFgDpQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Strawbridge, Michael" <Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1843229056==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB383150DB7FA13B7E5472A37085790CH2PR12MB3831namp_"

--_000_CH2PR12MB383150DB7FA13B7E5472A37085790CH2PR12MB3831namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Taking a look at this again, it's not an indexing issue, it's a placement p=
roblem.  I don't think this solution will work if we expect to pstate switc=
h all gpus.

>From amdgpu_kms.c,  amdgpu_register_gpu_instance comes after amdgpu_device_=
init.  This means we'll never reach mgpu_info.num_gpu =3D=3D adev->gmc.xgmi=
.num_physical_nodes until in this code path.

From: Kim, Jonathan
Sent: Tuesday, November 5, 2019 12:07 PM
To: Strawbridge, Michael <Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Qu=
an-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole=
 hive initialized

+                       for (i =3D 0; i < mgpu_info.num_gpu; i++) {
Also while num_physical_nodes should be used here instead.  It doesn't make=
 sense to have a pre-condition check i.e. (if (mgpu_info.num_dgpu =3D=3D ad=
ev->gmc.xgmi.num_physical_nodes - 1) ) against the total number of nodes wh=
ile the loop checks for the current num gpus from mgpu_info.  This will fai=
l to set the last node to low pstate for the same 0-indexing issue once the=
 pre-condition passes.

+                               gpu_instance =3D &(mgpu_info.gpu_ins[i]);
+                               if (gpu_instance->adev->flags & AMD_IS_APU)
+                                       continue;
+

From: Kim, Jonathan
Sent: Tuesday, November 5, 2019 11:42 AM
To: Strawbridge, Michael <Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org<mailto:Michael.Strawb=
ridge-5C7GfCeVMHo@public.gmane.org>>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; =
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole=
 hive initialized

Yes that's correct.  This should fix the issue.

Jon

From: Strawbridge, Michael <Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org<mailto:Michael.Stra=
wbridge-5C7GfCeVMHo@public.gmane.org>>
Sent: Tuesday, November 5, 2019 11:40 AM
To: Kim, Jonathan <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org<mailto:Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>>; Quan=
, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole=
 hive initialized

Hi Jon,

Does that mean we can simply use this instead?

+               if (mgpu_info.num_dgpu =3D=3D adev->gmc.xgmi.num_physical_n=
odes - 1) {

Thanks,
Michael
________________________________
From: Kim, Jonathan <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org<mailto:Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>>
Sent: 05 November 2019 11:32 AM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Strawbridge, Michael <Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org<mailto:Michael.Strawb=
ridge-5C7GfCeVMHo@public.gmane.org>>
Subject: RE: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole=
 hive initialized

Please see inline.

Jon

-----Original Message-----
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Tuesday, November 5, 2019 5:24 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Kim, Jonathan <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org<mailto:Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>>; Stra=
wbridge, Michael <Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org<mailto:Michael.Strawbridge@am=
d.com>>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole hiv=
e initialized

P-state switch should be performed after all devices from the hive get init=
ialized.

Change-Id: Ifc7cac9ef0cf250447d2a412da35d601e2ac79ec
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:evan.quan-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index e6ce949670e5..2d72d206cead 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2090,6 +2090,7 @@ static int amdgpu_device_enable_mgpu_fan_boost(void)
  */
 static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)  {
+       struct amdgpu_gpu_instance *gpu_instance;
         int i =3D 0, r;

         for (i =3D 0; i < adev->num_ip_blocks; i++) { @@ -2115,6 +2116,40 =
@@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
         if (r)
                 DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);

+
+       if (adev->gmc.xgmi.num_physical_nodes > 1) {
+               mutex_lock(&mgpu_info.mutex);
+
+               /*
+                * Reset device p-state to low as this was booted with high=
.
+                *
+                * This should be performed only after all devices from the=
 same
+                * hive get initialized.
+                *
+                * However, it's unknown how many device in the hive in adv=
ance.
+                * As this is counted one by one during devices initializat=
ions.
+                *
+                * So, we wait for all XGMI interlinked devices initialized=
.
+                * This may bring some delays as those devices may come fro=
m
+                * different hives. But that should be OK.
+                */
+               if (mgpu_info.num_dgpu =3D=3D adev->gmc.xgmi.num_physical_n=
odes) {
[JK] This condition will never succeed.  mgpu_info.num_dgpu is 0-indexed wh=
ile num_physical_nodes give total nodes.

+                       for (i =3D 0; i < mgpu_info.num_gpu; i++) {
+                               gpu_instance =3D &(mgpu_info.gpu_ins[i]);
+                               if (gpu_instance->adev->flags & AMD_IS_APU)
+                                       continue;
+
+                               r =3D amdgpu_xgmi_set_pstate(gpu_instance->=
adev, 0);
+                               if (r) {
+                                       DRM_ERROR("pstate setting failed (%=
d).\n", r);
+                                       break;
+                               }
+                       }
+               }
+
+               mutex_unlock(&mgpu_info.mutex);
+       }
+
         return 0;
 }

@@ -2227,18 +2262,6 @@ static void amdgpu_device_delayed_init_work_handler(=
struct work_struct *work)
         r =3D amdgpu_ib_ring_tests(adev);
         if (r)
                 DRM_ERROR("ib ring test failed (%d).\n", r);
-
-       /*
-        * set to low pstate by default
-        * This should be performed after all devices from
-        * XGMI finish their initializations. Thus it's moved
-        * to here.
-        * The time delay is 2S. TODO: confirm whether that
-        * is enough for all possible XGMI setups.
-        */
-       r =3D amdgpu_xgmi_set_pstate(adev, 0);
-       if (r)
-               DRM_ERROR("pstate setting failed (%d).\n", r);
 }

 static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
--
2.23.0

--_000_CH2PR12MB383150DB7FA13B7E5472A37085790CH2PR12MB3831namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
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
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
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
<p class=3D"MsoNormal">Taking a look at this again, it&#8217;s not an index=
ing issue, it&#8217;s a placement problem. &nbsp;I don&#8217;t think this s=
olution will work if we expect to pstate switch all gpus.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">From amdgpu_kms.c,&nbsp; amdgpu_register_gpu_instanc=
e comes after amdgpu_device_init.&nbsp; This means we&#8217;ll never reach =
mgpu_info.num_gpu =3D=3D adev-&gt;gmc.xgmi.num_physical_nodes until in this=
 code path.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Kim, Jonathan <br>
<b>Sent:</b> Tuesday, November 5, 2019 12:07 PM<br>
<b>To:</b> Strawbridge, Michael &lt;Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org&gt;; Quan, =
Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: perform p-state switch after th=
e whole hive initialized<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; mgpu_info.num_gpu; i&#43;&#43;) {<o:p></o:p=
></p>
<p class=3D"MsoNormal">Also while num_physical_nodes should be used here in=
stead.&nbsp; It doesn&#8217;t make sense to have a pre-condition check i.e.=
 (<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;color:black;ba=
ckground:white">if (mgpu_info.num_dgpu =3D=3D adev-&gt;gmc.xgmi.num_physica=
l_nodes<b>
 - 1</b>) ) </span>against the total number of nodes while the loop checks =
for the current num gpus from mgpu_info.&nbsp; This will fail to set the la=
st node to low pstate for the same 0-indexing issue once the pre-condition =
passes.
<o:p></o:p></p>
<p class=3D"MsoNormal"><br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_instance =3D &amp;(mgpu_info.gpu_in=
s[i]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_instance-&gt;adev-&gt;flags &am=
p; AMD_IS_APU)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; continue;<br>
&#43;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Kim, Jonathan <br>
<b>Sent:</b> Tuesday, November 5, 2019 11:42 AM<br>
<b>To:</b> Strawbridge, Michael &lt;<a href=3D"mailto:Michael.Strawbridge@a=
md.com">Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org</a>&gt;; Quan, Evan &lt;<a href=3D"mail=
to:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: perform p-state switch after th=
e whole hive initialized<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yes that&#8217;s correct.&nbsp; This should fix the =
issue.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Jon<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Strawbridge, Michael &lt;<a href=3D"mai=
lto:Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org">Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org</a>&gt;
<br>
<b>Sent:</b> Tuesday, November 5, 2019 11:40 AM<br>
<b>To:</b> Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim-5C7GfCeVMHo@public.gmane.org">Jonath=
an.Kim-5C7GfCeVMHo@public.gmane.org</a>&gt;; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org"=
>Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: perform p-state switch after th=
e whole hive initialized<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Jon,=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Does th=
at mean we can simply use this instead?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black;background:white">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mgpu_info.num_dgpu =
=3D=3D adev-&gt;gmc.xgmi.num_physical_nodes<b> - 1</b>) {</span><span style=
=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Thanks,<o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Michael=
<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Kim, Jonathan &lt;</span><a href=3D"mailto:Jonathan=
.Kim-5C7GfCeVMHo@public.gmane.org">Jonathan.Kim-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> 05 November 2019 11:32 AM<br>
<b>To:</b> Quan, Evan &lt;</span><a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.=
Quan-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><span style=3D=
"color:black">&gt;<br>
<b>Cc:</b> Strawbridge, Michael &lt;</span><a href=3D"mailto:Michael.Strawb=
ridge-5C7GfCeVMHo@public.gmane.org">Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&=
gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: perform p-state switch after th=
e whole hive initialized</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Please see inline.<br=
>
<br>
Jon<br>
<br>
-----Original Message-----<br>
From: Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan-5C7GfCeVMHo@public.gmane.org=
</a>&gt; <br>
Sent: Tuesday, November 5, 2019 5:24 AM<br>
To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org</a><br>
Cc: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim-5C7GfCeVMHo@public.gmane.org">Jonathan.Kim@=
amd.com</a>&gt;; Strawbridge, Michael &lt;<a href=3D"mailto:Michael.Strawbr=
idge-5C7GfCeVMHo@public.gmane.org">Michael.Strawbridge-5C7GfCeVMHo@public.gmane.org</a>&gt;; Quan, Evan &lt;<a href=
=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole hiv=
e initialized<br>
<br>
P-state switch should be performed after all devices from the hive get init=
ialized.<br>
<br>
Change-Id: Ifc7cac9ef0cf250447d2a412da35d601e2ac79ec<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;1 file changed, 35 insertions(&#43;), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index e6ce949670e5..2d72d206cead 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2090,6 &#43;2090,7 @@ static int amdgpu_device_enable_mgpu_fan_boost(vo=
id)<br>
&nbsp; */<br>
&nbsp;static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)&nbs=
p; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gpu_instance *gpu_i=
nstance;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0, r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;num_ip_blocks; i&#43;&#43;) { @@ -2115,6 &#43;2116,40 @@ static int amd=
gpu_device_ip_late_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;enable mgpu fan boost failed (%d).\n&=
quot;, r);<br>
&nbsp;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physica=
l_nodes &gt; 1) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_lock(&amp;mgpu_info.mutex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * Reset device p-state to low as this was booted with =
high.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * This should be performed only after all devices from=
 the same<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * hive get initialized.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * However, it's unknown how many device in the hive in=
 advance.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * As this is counted one by one during devices initial=
izations.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * So, we wait for all XGMI interlinked devices initial=
ized.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * This may bring some delays as those devices may come=
 from<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * different hives. But that should be OK.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (mgpu_info.num_dgpu =3D=3D adev-&gt;gmc.xgmi.num_physical=
_nodes) {<br>
[JK] This condition will never succeed.&nbsp; mgpu_info.num_dgpu is 0-index=
ed while num_physical_nodes give total nodes.<br>
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0=
; i &lt; mgpu_info.num_gpu; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_instance =3D &amp;(mgpu_info.gpu_in=
s[i]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_instance-&gt;adev-&gt;flags &am=
p; AMD_IS_APU)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; continue;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_xgmi_set_pstate(gpu_instan=
ce-&gt;adev, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; DRM_ERROR(&quot;pstate setting failed (%d).\n&quot;, r);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_unlock(&amp;mgpu_info.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2227,18 &#43;2262,6 @@ static void amdgpu_device_delayed_init_work_hand=
ler(struct work_struct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ib_ring_tests=
(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;ib ring test failed (%d).\n&quot;, r)=
;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * set to low pstate by default<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This should be performed afte=
r all devices from<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * XGMI finish their initializat=
ions. Thus it's moved<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to here.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The time delay is 2S. TODO: c=
onfirm whether that<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is enough for all possible XG=
MI setups.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_xgmi_set_pstate(adev, 0)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;pstate setting failed (%d).\n&quot;, r);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void amdgpu_device_delay_enable_gfx_off(struct work_struct *wo=
rk)<br>
--<br>
2.23.0<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB383150DB7FA13B7E5472A37085790CH2PR12MB3831namp_--

--===============1843229056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1843229056==--
