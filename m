From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/amdgpu: passing i2s instance value as platform
 data
Date: Wed, 18 Apr 2018 13:57:14 +0000
Message-ID: <BN6PR12MB18096701074EF5A4A6654B47F7B60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1524041792-8096-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0703231927=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1524041792-8096-1-git-send-email-Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>
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
To: "Mukunda, Vijendar" <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Agrawal, Akshu" <Akshu.Agrawal-5C7GfCeVMHo@public.gmane.org>

--===============0703231927==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18096701074EF5A4A6654B47F7B60BN6PR12MB1809namp_"

--_000_BN6PR12MB18096701074EF5A4A6654B47F7B60BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, April 18, 2018 4:56:32 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Agrawal, Akshu; Mukunda, Vijendar
Subject: [PATCH v2] drm/amd/amdgpu: passing i2s instance value as platform =
data

i2s instance value is passed as platform data to dwc driver.
this parameter will be useful to distinguish current i2s
instance value when multiple i2s controller instances are created.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>
---
v1->v2: moved I2S instance macros from dwc driver header file
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_acp.c
index 6cca4d1..c8c7583 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -83,6 +83,8 @@
 #define ACP_TIMEOUT_LOOP                        0x000000FF
 #define ACP_DEVS                                4
 #define ACP_SRC_ID                              162
+#define I2S_SP_INSTANCE                         0x01
+#define I2S_BT_INSTANCE                         0x02

 enum {
         ACP_TILE_P1 =3D 0,
@@ -347,6 +349,7 @@ static int acp_hw_init(void *handle)
         i2s_pdata[0].snd_rates =3D SNDRV_PCM_RATE_8000_96000;
         i2s_pdata[0].i2s_reg_comp1 =3D ACP_I2S_COMP1_PLAY_REG_OFFSET;
         i2s_pdata[0].i2s_reg_comp2 =3D ACP_I2S_COMP2_PLAY_REG_OFFSET;
+       i2s_pdata[0].i2s_instance =3D I2S_SP_INSTANCE;
         switch (adev->asic_type) {
         case CHIP_STONEY:
                 i2s_pdata[1].quirks =3D DW_I2S_QUIRK_COMP_REG_OFFSET |
@@ -362,6 +365,7 @@ static int acp_hw_init(void *handle)
         i2s_pdata[1].snd_rates =3D SNDRV_PCM_RATE_8000_96000;
         i2s_pdata[1].i2s_reg_comp1 =3D ACP_I2S_COMP1_CAP_REG_OFFSET;
         i2s_pdata[1].i2s_reg_comp2 =3D ACP_I2S_COMP2_CAP_REG_OFFSET;
+       i2s_pdata[1].i2s_instance =3D I2S_SP_INSTANCE;

         i2s_pdata[2].quirks =3D DW_I2S_QUIRK_COMP_REG_OFFSET;
         switch (adev->asic_type) {
@@ -376,6 +380,7 @@ static int acp_hw_init(void *handle)
         i2s_pdata[2].snd_rates =3D SNDRV_PCM_RATE_8000_96000;
         i2s_pdata[2].i2s_reg_comp1 =3D ACP_BT_COMP1_REG_OFFSET;
         i2s_pdata[2].i2s_reg_comp2 =3D ACP_BT_COMP2_REG_OFFSET;
+       i2s_pdata[2].i2s_instance =3D I2S_BT_INSTANCE;

         adev->acp.acp_res[0].name =3D "acp2x_dma";
         adev->acp.acp_res[0].flags =3D IORESOURCE_MEM;
--
2.7.4


--_000_BN6PR12MB18096701074EF5A4A6654B47F7B60BN6PR12MB1809namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vijendar Mukunda &lt;=
Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, April 18, 2018 4:56:32 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Agrawal, Akshu; Mukunda, Vijendar<br>
<b>Subject:</b> [PATCH v2] drm/amd/amdgpu: passing i2s instance value as pl=
atform data</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">i2s instance value is passed as platform data to d=
wc driver.<br>
this parameter will be useful to distinguish current i2s<br>
instance value when multiple i2s controller instances are created.<br>
<br>
Signed-off-by: Vijendar Mukunda &lt;Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
v1-&gt;v2: moved I2S instance macros from dwc driver header file<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 5 &#43;&#43;&#43;&#43;&#43;=
<br>
&nbsp;1 file changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_acp.c<br>
index 6cca4d1..c8c7583 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c<br>
@@ -83,6 &#43;83,8 @@<br>
&nbsp;#define ACP_TIMEOUT_LOOP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x000000FF<br>
&nbsp;#define ACP_DEVS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;#define ACP_SRC_ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 162<br>
&#43;#define I2S_SP_INSTANCE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x01<br>
&#43;#define I2S_BT_INSTANCE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x02<br>
&nbsp;<br>
&nbsp;enum {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP_TILE_P1 =3D 0,<br>
@@ -347,6 &#43;349,7 @@ static int acp_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[0].snd_rates =3D=
 SNDRV_PCM_RATE_8000_96000;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[0].i2s_reg_comp1=
 =3D ACP_I2S_COMP1_PLAY_REG_OFFSET;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[0].i2s_reg_comp2=
 =3D ACP_I2S_COMP2_PLAY_REG_OFFSET;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[0].i2s_instance =3D I2S=
_SP_INSTANCE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_STONEY:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; i2s_pdata[1].quirks =3D DW_I2S_QUIRK_COMP_REG_OFFSET =
|<br>
@@ -362,6 &#43;365,7 @@ static int acp_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[1].snd_rates =3D=
 SNDRV_PCM_RATE_8000_96000;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[1].i2s_reg_comp1=
 =3D ACP_I2S_COMP1_CAP_REG_OFFSET;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[1].i2s_reg_comp2=
 =3D ACP_I2S_COMP2_CAP_REG_OFFSET;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[1].i2s_instance =3D I2S=
_SP_INSTANCE;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[2].quirks =3D DW=
_I2S_QUIRK_COMP_REG_OFFSET;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
@@ -376,6 &#43;380,7 @@ static int acp_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[2].snd_rates =3D=
 SNDRV_PCM_RATE_8000_96000;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[2].i2s_reg_comp1=
 =3D ACP_BT_COMP1_REG_OFFSET;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[2].i2s_reg_comp2=
 =3D ACP_BT_COMP2_REG_OFFSET;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2s_pdata[2].i2s_instance =3D I2S=
_BT_INSTANCE;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;acp.acp_res[0].na=
me =3D &quot;acp2x_dma&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;acp.acp_res[0].fl=
ags =3D IORESOURCE_MEM;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18096701074EF5A4A6654B47F7B60BN6PR12MB1809namp_--

--===============0703231927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0703231927==--
