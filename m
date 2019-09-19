From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx10: add support for wks firmware loading
Date: Thu, 19 Sep 2019 06:12:15 +0000
Message-ID: <DM5PR12MB253586B329B75BAC8D252CE595890@DM5PR12MB2535.namprd12.prod.outlook.com>
References: <20190919053247.14172-1-tianci.yin@amd.com>,
 <CH2PR12MB37670D6362ADEBD444190252FE890@CH2PR12MB3767.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0549686152=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CH2PR12MB37670D6362ADEBD444190252FE890-rV3HgkLYx2Vb0rI3ZRjBIAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0549686152==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB253586B329B75BAC8D252CE595890DM5PR12MB2535namp_"

--_000_DM5PR12MB253586B329B75BAC8D252CE595890DM5PR12MB2535namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Feifei!
________________________________
From: Xu, Feifei <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, September 19, 2019 14:05
To: Yin, Tianci (Rico) <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Yin, Tianci (Rico) <Tia=
nci.Yin-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu/gfx10: add support for wks firmware loading



Reviewed-by: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Tianci Y=
in
Sent: Thursday, September 19, 2019 1:33 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Yin, Tianci (Rico) <Tia=
nci.Yin-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/gfx10: add support for wks firmware loading

From: "Tianci.Yin" <tianci.yin-5C7GfCeVMHo@public.gmane.org>

load different cp firmware according to the DID and RID

Signed-off-by: Tianci.Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 082a0b3298a9..65caf404e7d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -66,6 +66,11 @@ MODULE_FIRMWARE("amdgpu/navi10_mec.bin");
 MODULE_FIRMWARE("amdgpu/navi10_mec2.bin");
 MODULE_FIRMWARE("amdgpu/navi10_rlc.bin");

+MODULE_FIRMWARE("amdgpu/navi14_ce_wks.bin");
+MODULE_FIRMWARE("amdgpu/navi14_pfp_wks.bin");
+MODULE_FIRMWARE("amdgpu/navi14_me_wks.bin");
+MODULE_FIRMWARE("amdgpu/navi14_mec_wks.bin");
+MODULE_FIRMWARE("amdgpu/navi14_mec2_wks.bin");
 MODULE_FIRMWARE("amdgpu/navi14_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi14_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi14_me.bin");
@@ -591,7 +596,8 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_d=
evice *adev)  static int gfx_v10_0_init_microcode(struct amdgpu_device *ade=
v)  {
         const char *chip_name;
-       char fw_name[30];
+       char fw_name[40];
+       char wks[10];
         int err;
         struct amdgpu_firmware_info *info =3D NULL;
         const struct common_firmware_header *header =3D NULL; @@ -604,12 +=
610,16 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)

         DRM_DEBUG("\n");

+       memset(wks, 0, sizeof(wks));
         switch (adev->asic_type) {
         case CHIP_NAVI10:
                 chip_name =3D "navi10";
                 break;
         case CHIP_NAVI14:
                 chip_name =3D "navi14";
+               if (!(adev->pdev->device =3D=3D 0x7340 &&
+                     adev->pdev->revision !=3D 0x00))
+                       snprintf(wks, sizeof(wks), "_wks");
                 break;
         case CHIP_NAVI12:
                 chip_name =3D "navi12";
@@ -618,7 +628,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_devic=
e *adev)
                 BUG();
         }

-       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
+       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp%s.bin", chip_name=
,
+wks);
         err =3D request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
         if (err)
                 goto out;
@@ -629,7 +639,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_devic=
e *adev)
         adev->gfx.pfp_fw_version =3D le32_to_cpu(cp_hdr->header.ucode_vers=
ion);
         adev->gfx.pfp_feature_version =3D le32_to_cpu(cp_hdr->ucode_featur=
e_version);

-       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
+       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me%s.bin", chip_name,
+wks);
         err =3D request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
         if (err)
                 goto out;
@@ -640,7 +650,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_devic=
e *adev)
         adev->gfx.me_fw_version =3D le32_to_cpu(cp_hdr->header.ucode_versi=
on);
         adev->gfx.me_feature_version =3D le32_to_cpu(cp_hdr->ucode_feature=
_version);

-       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
+       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce%s.bin", chip_name,
+wks);
         err =3D request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
         if (err)
                 goto out;
@@ -705,7 +715,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_devic=
e *adev)
         if (adev->gfx.rlc.is_rlc_v2_1)
                 gfx_v10_0_init_rlc_ext_microcode(adev);

-       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
+       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", chip_name=
,
+wks);
         err =3D request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
         if (err)
                 goto out;
@@ -716,7 +726,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_devic=
e *adev)
         adev->gfx.mec_fw_version =3D le32_to_cpu(cp_hdr->header.ucode_vers=
ion);
         adev->gfx.mec_feature_version =3D le32_to_cpu(cp_hdr->ucode_featur=
e_version);

-       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name)=
;
+       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2%s.bin", chip_nam=
e,
+wks);
         err =3D request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
         if (!err) {
                 err =3D amdgpu_ucode_validate(adev->gfx.mec2_fw);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB253586B329B75BAC8D252CE595890DM5PR12MB2535namp_
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
Thanks Feifei!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Xu, Feifei &lt;Feifei=
.Xu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, September 19, 2019 14:05<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Yin, Tianc=
i (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.c=
om&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/gfx10: add support for wks firmware =
loading</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
Reviewed-by: Feifei Xu &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf Of Ti=
anci Yin<br>
Sent: Thursday, September 19, 2019 1:33 PM<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Yin, Tianci (Rico=
) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<=
br>
Subject: [PATCH] drm/amdgpu/gfx10: add support for wks firmware loading<br>
<br>
From: &quot;Tianci.Yin&quot; &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
load different cp firmware according to the DID and RID<br>
<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 22 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;1 file changed, 16 insertions(&#43;), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 082a0b3298a9..65caf404e7d1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -66,6 &#43;66,11 @@ MODULE_FIRMWARE(&quot;amdgpu/navi10_mec.bin&quot;);<=
br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/navi10_mec2.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/navi10_rlc.bin&quot;);<br>
&nbsp;<br>
&#43;MODULE_FIRMWARE(&quot;amdgpu/navi14_ce_wks.bin&quot;);<br>
&#43;MODULE_FIRMWARE(&quot;amdgpu/navi14_pfp_wks.bin&quot;);<br>
&#43;MODULE_FIRMWARE(&quot;amdgpu/navi14_me_wks.bin&quot;);<br>
&#43;MODULE_FIRMWARE(&quot;amdgpu/navi14_mec_wks.bin&quot;);<br>
&#43;MODULE_FIRMWARE(&quot;amdgpu/navi14_mec2_wks.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/navi14_ce.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/navi14_pfp.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/navi14_me.bin&quot;);<br>
@@ -591,7 &#43;596,8 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdg=
pu_device *adev)&nbsp; static int gfx_v10_0_init_microcode(struct amdgpu_de=
vice *adev)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *chip_name;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char fw_name[30];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char fw_name[40];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char wks[10];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_inf=
o *info =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header =3D NULL; @@ -604,12 &#43;610,16 @@ static int gfx_v10_0_=
init_microcode(struct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);=
<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(wks, 0, sizeof(wks));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;navi10&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;navi14&quot;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!(adev-&gt;pdev-&gt;device =3D=3D 0x7340 &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pdev-&gt;revisi=
on !=3D 0x00))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(wks=
, sizeof(wks), &quot;_wks&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;navi12&quot;;<br>
@@ -618,7 &#43;628,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BUG();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &q=
uot;amdgpu/%s_pfp.bin&quot;, chip_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name)=
, &quot;amdgpu/%s_pfp%s.bin&quot;, chip_name, <br>
&#43;wks);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D request_firmware(&=
amp;adev-&gt;gfx.pfp_fw, fw_name, adev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
@@ -629,7 &#43;639,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.pfp_fw_versio=
n =3D le32_to_cpu(cp_hdr-&gt;header.ucode_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.pfp_feature_v=
ersion =3D le32_to_cpu(cp_hdr-&gt;ucode_feature_version);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &q=
uot;amdgpu/%s_me.bin&quot;, chip_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name)=
, &quot;amdgpu/%s_me%s.bin&quot;, chip_name, <br>
&#43;wks);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D request_firmware(&=
amp;adev-&gt;gfx.me_fw, fw_name, adev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
@@ -640,7 &#43;650,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me_fw_version=
 =3D le32_to_cpu(cp_hdr-&gt;header.ucode_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me_feature_ve=
rsion =3D le32_to_cpu(cp_hdr-&gt;ucode_feature_version);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &q=
uot;amdgpu/%s_ce.bin&quot;, chip_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name)=
, &quot;amdgpu/%s_ce%s.bin&quot;, chip_name, <br>
&#43;wks);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D request_firmware(&=
amp;adev-&gt;gfx.ce_fw, fw_name, adev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
@@ -705,7 &#43;715,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.is_rl=
c_v2_1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v10_0_init_rlc_ext_microcode(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &q=
uot;amdgpu/%s_mec.bin&quot;, chip_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name)=
, &quot;amdgpu/%s_mec%s.bin&quot;, chip_name, <br>
&#43;wks);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D request_firmware(&=
amp;adev-&gt;gfx.mec_fw, fw_name, adev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
@@ -716,7 &#43;726,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec_fw_versio=
n =3D le32_to_cpu(cp_hdr-&gt;header.ucode_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec_feature_v=
ersion =3D le32_to_cpu(cp_hdr-&gt;ucode_feature_version);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &q=
uot;amdgpu/%s_mec2.bin&quot;, chip_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name)=
, &quot;amdgpu/%s_mec2%s.bin&quot;, chip_name, <br>
&#43;wks);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D request_firmware(&=
amp;adev-&gt;gfx.mec2_fw, fw_name, adev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!err) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_ucode_validate(adev-&gt;gfx.mec2_fw);<=
br>
--<br>
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

--_000_DM5PR12MB253586B329B75BAC8D252CE595890DM5PR12MB2535namp_--

--===============0549686152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0549686152==--
