From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: both support PCO FP5/AM4 rlc fw
Date: Thu, 6 Dec 2018 02:45:45 +0000
Message-ID: <BN6PR12MB1809F17C96E262711D536C8BF7A90@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1544059612-3380-1-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1643584903=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1544059612-3380-1-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1643584903==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F17C96E262711D536C8BF7A90BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F17C96E262711D536C8BF7A90BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Aaron Li=
u <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, December 5, 2018 8:26:52 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Liu, Aaron
Subject: [PATCH] drm/amdgpu: both support PCO FP5/AM4 rlc fw

For Picasso && AM4 SOCKET board, we use picasso_rlc_am4.bin
For Picasso && FP5 SOCKET board, we use picasso_rlc.bin

Judgment method:
PCO AM4: revision >=3D 0xC8 && revision <=3D 0xCF
         or revision >=3D 0xD8 && revision <=3D 0xDF
otherwise is PCO FP5

Change-Id: I359f0a3d1bc7d4d49c871cb3fb82797c7b91b259
Signed-off-by: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 94740ea..7556716 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -86,6 +86,7 @@ MODULE_FIRMWARE("amdgpu/picasso_me.bin");
 MODULE_FIRMWARE("amdgpu/picasso_mec.bin");
 MODULE_FIRMWARE("amdgpu/picasso_mec2.bin");
 MODULE_FIRMWARE("amdgpu/picasso_rlc.bin");
+MODULE_FIRMWARE("amdgpu/picasso_rlc_am4.bin");

 MODULE_FIRMWARE("amdgpu/raven2_ce.bin");
 MODULE_FIRMWARE("amdgpu/raven2_pfp.bin");
@@ -645,7 +646,20 @@ static int gfx_v9_0_init_microcode(struct amdgpu_devic=
e *adev)
         adev->gfx.ce_fw_version =3D le32_to_cpu(cp_hdr->header.ucode_versi=
on);
         adev->gfx.ce_feature_version =3D le32_to_cpu(cp_hdr->ucode_feature=
_version);

-       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
+       /*
+        * For Picasso && AM4 SOCKET board, we use picasso_rlc_am4.bin
+        * instead of picasso_rlc.bin.
+        * Judgment method:
+        * PCO AM4: revision >=3D 0xC8 && revision <=3D 0xCF
+        *          or revision >=3D 0xD8 && revision <=3D 0xDF
+        * otherwise is PCO FP5
+        */
+       if (!strcmp(chip_name, "picasso") &&
+               (((adev->pdev->revision >=3D 0xC8) && (adev->pdev->revision=
 <=3D 0xCF)) ||
+               ((adev->pdev->revision >=3D 0xD8) && (adev->pdev->revision =
<=3D 0xDF))))
+               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc_am4.bin",=
 chip_name);
+       else
+               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chi=
p_name);
         err =3D request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
         if (err)
                 goto out;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809F17C96E262711D536C8BF7A90BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Aaron Liu &lt;aaron.liu@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, December 5, 2018 8:26:52 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Liu, Aaron<br>
<b>Subject:</b> [PATCH] drm/amdgpu: both support PCO FP5/AM4 rlc fw</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For Picasso &amp;&amp; AM4 SOCKET board, we use pi=
casso_rlc_am4.bin<br>
For Picasso &amp;&amp; FP5 SOCKET board, we use picasso_rlc.bin<br>
<br>
Judgment method:<br>
PCO AM4: revision &gt;=3D 0xC8 &amp;&amp; revision &lt;=3D 0xCF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; or revision &gt;=3D 0xD8 &=
amp;&amp; revision &lt;=3D 0xDF<br>
otherwise is PCO FP5<br>
<br>
Change-Id: I359f0a3d1bc7d4d49c871cb3fb82797c7b91b259<br>
Signed-off-by: Aaron Liu &lt;aaron.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 16 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;1 file changed, 15 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 94740ea..7556716 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -86,6 &#43;86,7 @@ MODULE_FIRMWARE(&quot;amdgpu/picasso_me.bin&quot;);<b=
r>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/picasso_mec.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/picasso_mec2.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/picasso_rlc.bin&quot;);<br>
&#43;MODULE_FIRMWARE(&quot;amdgpu/picasso_rlc_am4.bin&quot;);<br>
&nbsp;<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/raven2_ce.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/raven2_pfp.bin&quot;);<br>
@@ -645,7 &#43;646,20 @@ static int gfx_v9_0_init_microcode(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ce_fw_version=
 =3D le32_to_cpu(cp_hdr-&gt;header.ucode_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ce_feature_ve=
rsion =3D le32_to_cpu(cp_hdr-&gt;ucode_feature_version);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &q=
uot;amdgpu/%s_rlc.bin&quot;, chip_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For Picasso &amp;&amp; AM=
4 SOCKET board, we use picasso_rlc_am4.bin<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * instead of picasso_rlc.bi=
n.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Judgment method:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PCO AM4: revision &gt;=3D=
 0xC8 &amp;&amp; revision &lt;=3D 0xCF<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; or revision &gt;=3D 0xD8 &amp;&amp; revision &=
lt;=3D 0xDF<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * otherwise is PCO FP5<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!strcmp(chip_name, &quot;pica=
sso&quot;) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (((adev-&gt;pdev-&gt;revision &gt;=3D 0xC8) &amp;&amp; (adev=
-&gt;pdev-&gt;revision &lt;=3D 0xCF)) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((adev-&gt;pdev-&gt;revision &gt;=3D 0xD8) &amp;&amp; (adev-=
&gt;pdev-&gt;revision &lt;=3D 0xDF))))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &quot;amdgpu/%s_rlc_am4.b=
in&quot;, chip_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &quot;amdgpu/%s_rlc.bin&q=
uot;, chip_name);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D request_firmware(&=
amp;adev-&gt;gfx.rlc_fw, fw_name, adev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
-- <br>
2.7.4<br>
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

--_000_BN6PR12MB1809F17C96E262711D536C8BF7A90BN6PR12MB1809namp_--

--===============1643584903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1643584903==--
