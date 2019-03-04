From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: also reroute VMC and UMD to IH ring 1 on Vega
 20
Date: Mon, 4 Mar 2019 18:37:21 +0000
Message-ID: <BN6PR12MB180947D8A82008521C338DBFF7710@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190304183612.1497-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0081825439=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190304183612.1497-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0081825439==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180947D8A82008521C338DBFF7710BN6PR12MB1809namp_"

--_000_BN6PR12MB180947D8A82008521C338DBFF7710BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, March 4, 2019 1:36 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH] drm/amdgpu: also reroute VMC and UMD to IH ring 1 on Vega =
20

Same patch we alredy did for Vega10. Just re-route page faults to a separat=
e
ring to avoid drowning in interrupts.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 3f59a4477a7b..2b3429d90690 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -33,6 +33,9 @@
 #include "sdma0/sdma0_4_0_offset.h"
 #include "nbio/nbio_7_4_offset.h"

+#include "oss/osssys_4_0_offset.h"
+#include "oss/osssys_4_0_sh_mask.h"
+
 MODULE_FIRMWARE("amdgpu/vega20_sos.bin");
 MODULE_FIRMWARE("amdgpu/vega20_asd.bin");
 MODULE_FIRMWARE("amdgpu/vega20_ta.bin");
@@ -224,6 +227,37 @@ static int psp_v11_0_bootloader_load_sos(struct psp_co=
ntext *psp)
         return ret;
 }

+static void psp_v11_0_reroute_ih(struct psp_context *psp)
+{
+       struct amdgpu_device *adev =3D psp->adev;
+       uint32_t tmp;
+
+       /* Change IH ring for VMC */
+       tmp =3D REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x=
1244b);
+       tmp =3D REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
+       tmp =3D REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
+
+       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 3);
+       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
+       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SE=
T);
+
+       mdelay(20);
+       psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                    0x80000000, 0x8000FFFF, false);
+
+       /* Change IH ring for UMC */
+       tmp =3D REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x=
1216b);
+       tmp =3D REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
+
+       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 4);
+       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
+       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SE=
T);
+
+       mdelay(20);
+       psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+                    0x80000000, 0x8000FFFF, false);
+}
+
 static int psp_v11_0_ring_init(struct psp_context *psp,
                               enum psp_ring_type ring_type)
 {
@@ -231,6 +265,8 @@ static int psp_v11_0_ring_init(struct psp_context *psp,
         struct psp_ring *ring;
         struct amdgpu_device *adev =3D psp->adev;

+       psp_v11_0_reroute_ih(psp);
+
         ring =3D &psp->km_ring;

         ring->ring_type =3D ring_type;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180947D8A82008521C338DBFF7710BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, March 4, 2019 1:36 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: also reroute VMC and UMD to IH ring 1 o=
n Vega 20</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Same patch we alredy did for Vega10. Just re-route=
 page faults to a separate<br>
ring to avoid drowning in interrupts.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 36 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 36 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c<br>
index 3f59a4477a7b..2b3429d90690 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
@@ -33,6 &#43;33,9 @@<br>
&nbsp;#include &quot;sdma0/sdma0_4_0_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_7_4_offset.h&quot;<br>
&nbsp;<br>
&#43;#include &quot;oss/osssys_4_0_offset.h&quot;<br>
&#43;#include &quot;oss/osssys_4_0_sh_mask.h&quot;<br>
&#43;<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega20_sos.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega20_asd.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega20_ta.bin&quot;);<br>
@@ -224,6 &#43;227,37 @@ static int psp_v11_0_bootloader_load_sos(struct ps=
p_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void psp_v11_0_reroute_ih(struct psp_context *psp)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ps=
p-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Change IH ring for VMC */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(0, IH_CLIEN=
T_CFG_DATA, CREDIT_RETURN_ADDR, 0x1244b);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_CLI=
ENT_CFG_DATA, CLIENT_TYPE, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_CLI=
ENT_CFG_DATA, RING_ID, 1);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP0, 0, mmMP0_SMN_C2=
PMSG_69, 3);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP0, 0, mmMP0_SMN_C2=
PMSG_70, tmp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP0, 0, mmMP0_SMN_C2=
PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(20);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_wait_for(psp, SOC15_REG_OFFSE=
T(MP0, 0, mmMP0_SMN_C2PMSG_64),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000, 0x8000FFFF, false)=
;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Change IH ring for UMC */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(0, IH_CLIEN=
T_CFG_DATA, CREDIT_RETURN_ADDR, 0x1216b);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_CLI=
ENT_CFG_DATA, RING_ID, 1);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP0, 0, mmMP0_SMN_C2=
PMSG_69, 4);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP0, 0, mmMP0_SMN_C2=
PMSG_70, tmp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP0, 0, mmMP0_SMN_C2=
PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(20);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_wait_for(psp, SOC15_REG_OFFSE=
T(MP0, 0, mmMP0_SMN_C2PMSG_64),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000, 0x8000FFFF, false)=
;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int psp_v11_0_ring_init(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum psp_ring_type ring_type)<br>
&nbsp;{<br>
@@ -231,6 &#43;265,8 @@ static int psp_v11_0_ring_init(struct psp_context *=
psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_ring *ring;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_v11_0_reroute_ih(psp);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;psp-&gt;km_r=
ing;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;ring_type =3D rin=
g_type;<br>
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

--_000_BN6PR12MB180947D8A82008521C338DBFF7710BN6PR12MB1809namp_--

--===============0081825439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0081825439==--
