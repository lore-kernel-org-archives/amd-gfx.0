From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: reroute VMC and UMD to IH ring 1
Date: Mon, 4 Mar 2019 15:26:27 +0000
Message-ID: <BN6PR12MB1809BD223DD40B32FB996F86F7710@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190304131522.12223-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1855675033=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190304131522.12223-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

--===============1855675033==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809BD223DD40B32FB996F86F7710BN6PR12MB1809namp_"

--_000_BN6PR12MB1809BD223DD40B32FB996F86F7710BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Would be good to verify this across all vega parts (10/12/20).  Other than =
that:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, March 4, 2019 8:15 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH] drm/amdgpu: reroute VMC and UMD to IH ring 1

Page faults can easily overwhelm the interrupt handler.

So to make sure that we never lose valuable interrupts on the primary ring
we re-route page faults to IH ring 1.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 36 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/=
amdgpu/psp_gfx_if.h
index f3a7d207af07..2f79765b4bdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -43,6 +43,7 @@ enum psp_gfx_crtl_cmd_id
     GFX_CTRL_CMD_ID_ENABLE_INT      =3D 0x00050000,   /* enable PSP-to-Gfx=
 interrupt */
     GFX_CTRL_CMD_ID_DISABLE_INT     =3D 0x00060000,   /* disable PSP-to-Gf=
x interrupt */
     GFX_CTRL_CMD_ID_MODE1_RST       =3D 0x00070000,   /* trigger the Mode =
1 reset */
+    GFX_CTRL_CMD_ID_GBR_IH_SET      =3D 0x00080000,   /* set Gbr IH_RB_CNT=
L registers */
     GFX_CTRL_CMD_ID_CONSUME_CMD     =3D 0x000A0000,   /* send interrupt to=
 psp for updating write pointer of vf */
     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING =3D 0x000C0000, /* destroy GPCOM ri=
ng */

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.c
index 0487e3a4e9e7..143f0fae69d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -37,6 +37,9 @@
 #include "sdma0/sdma0_4_0_offset.h"
 #include "nbio/nbio_6_1_offset.h"

+#include "oss/osssys_4_0_offset.h"
+#include "oss/osssys_4_0_sh_mask.h"
+
 MODULE_FIRMWARE("amdgpu/vega10_sos.bin");
 MODULE_FIRMWARE("amdgpu/vega10_asd.bin");
 MODULE_FIRMWARE("amdgpu/vega12_sos.bin");
@@ -252,6 +255,37 @@ static int psp_v3_1_ring_init(struct psp_context *psp,
         return 0;
 }

+static void psp_v3_1_reroute_ih(struct psp_context *psp)
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
 static int psp_v3_1_ring_create(struct psp_context *psp,
                                 enum psp_ring_type ring_type)
 {
@@ -260,6 +294,8 @@ static int psp_v3_1_ring_create(struct psp_context *psp=
,
         struct psp_ring *ring =3D &psp->km_ring;
         struct amdgpu_device *adev =3D psp->adev;

+       psp_v3_1_reroute_ih(psp);
+
         /* Write low address of the ring to C2PMSG_69 */
         psp_ring_reg =3D lower_32_bits(ring->ring_mem_mc_addr);
         WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, psp_ring_reg);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809BD223DD40B32FB996F86F7710BN6PR12MB1809namp_
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
Would be good to verify this across all vega parts (10/12/20).&nbsp; Other =
than that:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoen=
ig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, March 4, 2019 8:15 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: reroute VMC and UMD to IH ring 1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Page faults can easily overwhelm the interrupt han=
dler.<br>
<br>
So to make sure that we never lose valuable interrupts on the primary ring<=
br>
we re-route page faults to IH ring 1.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v3_1.c&nbsp;&nbsp; | 36 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 37 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/=
amdgpu/psp_gfx_if.h<br>
index f3a7d207af07..2f79765b4bdb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h<br>
@@ -43,6 &#43;43,7 @@ enum psp_gfx_crtl_cmd_id<br>
&nbsp;&nbsp;&nbsp;&nbsp; GFX_CTRL_CMD_ID_ENABLE_INT&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; =3D 0x00050000,&nbsp;&nbsp; /* enable PSP-to-Gfx interrupt */<br>
&nbsp;&nbsp;&nbsp;&nbsp; GFX_CTRL_CMD_ID_DISABLE_INT&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x00060000,&nbsp;&nbsp; /* disable PSP-to-Gfx interrupt */<br>
&nbsp;&nbsp;&nbsp;&nbsp; GFX_CTRL_CMD_ID_MODE1_RST&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D 0x00070000,&nbsp;&nbsp; /* trigger the Mode 1 reset */<br>
&#43;&nbsp;&nbsp;&nbsp; GFX_CTRL_CMD_ID_GBR_IH_SET&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =3D 0x00080000,&nbsp;&nbsp; /* set Gbr IH_RB_CNTL registers */<br>
&nbsp;&nbsp;&nbsp;&nbsp; GFX_CTRL_CMD_ID_CONSUME_CMD&nbsp;&nbsp;&nbsp;&nbsp=
; =3D 0x000A0000,&nbsp;&nbsp; /* send interrupt to psp for updating write p=
ointer of vf */<br>
&nbsp;&nbsp;&nbsp;&nbsp; GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING =3D 0x000C0000,=
 /* destroy GPCOM ring */<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.c<br>
index 0487e3a4e9e7..143f0fae69d5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c<br>
@@ -37,6 &#43;37,9 @@<br>
&nbsp;#include &quot;sdma0/sdma0_4_0_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_6_1_offset.h&quot;<br>
&nbsp;<br>
&#43;#include &quot;oss/osssys_4_0_offset.h&quot;<br>
&#43;#include &quot;oss/osssys_4_0_sh_mask.h&quot;<br>
&#43;<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega10_sos.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega10_asd.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega12_sos.bin&quot;);<br>
@@ -252,6 &#43;255,37 @@ static int psp_v3_1_ring_init(struct psp_context *=
psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void psp_v3_1_reroute_ih(struct psp_context *psp)<br>
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
&nbsp;static int psp_v3_1_ring_create(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum psp_ring_type ring_type)<br=
>
&nbsp;{<br>
@@ -260,6 &#43;294,8 @@ static int psp_v3_1_ring_create(struct psp_context =
*psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_ring *ring =3D =
&amp;psp-&gt;km_ring;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_v3_1_reroute_ih(psp);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Write low address of th=
e ring to C2PMSG_69 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_ring_reg =3D lower_32_=
bits(ring-&gt;ring_mem_mc_addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP0, 0, mmMP0=
_SMN_C2PMSG_69, psp_ring_reg);<br>
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

--_000_BN6PR12MB1809BD223DD40B32FB996F86F7710BN6PR12MB1809namp_--

--===============1855675033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1855675033==--
