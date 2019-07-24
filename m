From: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu/vcn_v2_0: Set CMD_SOURCE for RB commands
Date: Wed, 24 Jul 2019 22:23:43 +0000
Message-ID: <DM5PR12MB2456E8FF88AA6C6F48A0A12FE5C60@DM5PR12MB2456.namprd12.prod.outlook.com>
References: <BN6PR1201MB0178175C942E341FCEB0D07B9DC60@BN6PR1201MB0178.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1077557585=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR1201MB0178175C942E341FCEB0D07B9DC60-6iU6OBHu2P+P5uQgMQGiHWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Content-Language: en-CA
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
To: "Thai, Thong" <Thong.Thai-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1077557585==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB2456E8FF88AA6C6F48A0A12FE5C60DM5PR12MB2456namp_"

--_000_DM5PR12MB2456E8FF88AA6C6F48A0A12FE5C60DM5PR12MB2456namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please separate the patches to 2 patches. i. e. New ring test as one patch.

Regards,
Leo
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Thai, Th=
ong <Thong.Thai-5C7GfCeVMHo@public.gmane.org>
Sent: July 24, 2019 3:50:47 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: [PATCH] drm/amd/amdgpu/vcn_v2_0: Set CMD_SOURCE for RB commands

Sets the CMD_SOURCE bit for VCN 2.0 decoder ring-buffer commands. This bit =
was previously set by the RBC HW on older versions of the firmware, and now=
 needs to be set by the driver in order to work with the SW RBC found in ne=
wer versions of the firmware.

Signed-off-by: Thong Thai <thong.thai-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 44 ++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c
index bc9726787c97..8daee23425f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1488,7 +1488,7 @@ static void vcn_v2_0_dec_ring_insert_start(struct amd=
gpu_ring *ring)
         amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OF=
FSET, 0));
         amdgpu_ring_write(ring, 0);
         amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));
-       amdgpu_ring_write(ring, VCN_DEC_CMD_PACKET_START << 1);
+       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_PACKET_START << 1=
));
 }

 /**
@@ -1501,7 +1501,7 @@ static void vcn_v2_0_dec_ring_insert_start(struct amd=
gpu_ring *ring)
 static void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
 {
         amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));
-       amdgpu_ring_write(ring, VCN_DEC_CMD_PACKET_END << 1);
+       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_PACKET_END << 1))=
;
 }

 /**
@@ -1546,7 +1546,7 @@ static void vcn_v2_0_dec_ring_emit_fence(struct amdgp=
u_ring *ring, u64 addr, u64
         amdgpu_ring_write(ring, upper_32_bits(addr) & 0xff);

         amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));
-       amdgpu_ring_write(ring, VCN_DEC_CMD_FENCE << 1);
+       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_FENCE << 1));

         amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OF=
FSET, 0));
         amdgpu_ring_write(ring, 0);
@@ -1556,7 +1556,7 @@ static void vcn_v2_0_dec_ring_emit_fence(struct amdgp=
u_ring *ring, u64 addr, u64

         amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));

-       amdgpu_ring_write(ring, VCN_DEC_CMD_TRAP << 1);
+       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_TRAP << 1));
 }

 /**
@@ -1600,7 +1600,7 @@ static void vcn_v2_0_dec_ring_emit_reg_wait(struct am=
dgpu_ring *ring,

         amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));

-       amdgpu_ring_write(ring, VCN_DEC_CMD_REG_READ_COND_WAIT << 1);
+       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_REG_READ_COND_WAI=
T << 1));
 }

 static void vcn_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
@@ -1629,7 +1629,7 @@ static void vcn_v2_0_dec_ring_emit_wreg(struct amdgpu=
_ring *ring,

         amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFS=
ET, 0));

-       amdgpu_ring_write(ring, VCN_DEC_CMD_WRITE_REG << 1);
+       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_WRITE_REG << 1));
 }

 /**
@@ -2082,6 +2082,36 @@ static int vcn_v2_0_process_interrupt(struct amdgpu_=
device *adev,
         return 0;
 }

+int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
+{
+       struct amdgpu_device *adev =3D ring->adev;
+       uint32_t tmp =3D 0;
+       unsigned i;
+       int r;
+
+       WREG32(adev->vcn.external.scratch9, 0xCAFEDEAD);
+       r =3D amdgpu_ring_alloc(ring, 3);
+       if (r)
+               return r;
+       amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
+       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_PACKET_START << 1=
));
+       amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.scratch9, 0));
+       amdgpu_ring_write(ring, 0xDEADBEEF);
+       amdgpu_ring_commit(ring);
+       for (i =3D 0; i < adev->usec_timeout; i++) {
+               tmp =3D RREG32(adev->vcn.external.scratch9);
+               if (tmp =3D=3D 0xDEADBEEF)
+                       break;
+               DRM_UDELAY(1);
+       }
+
+       if (i >=3D adev->usec_timeout)
+               r =3D -ETIMEDOUT;
+
+       return r;
+}
+
+
 static int vcn_v2_0_set_powergating_state(void *handle,
                                           enum amd_powergating_state state=
)
 {
@@ -2145,7 +2175,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ri=
ng_vm_funcs =3D {
         .emit_ib =3D vcn_v2_0_dec_ring_emit_ib,
         .emit_fence =3D vcn_v2_0_dec_ring_emit_fence,
         .emit_vm_flush =3D vcn_v2_0_dec_ring_emit_vm_flush,
-       .test_ring =3D amdgpu_vcn_dec_ring_test_ring,
+       .test_ring =3D vcn_v2_0_dec_ring_test_ring,
         .test_ib =3D amdgpu_vcn_dec_ring_test_ib,
         .insert_nop =3D vcn_v2_0_dec_ring_insert_nop,
         .insert_start =3D vcn_v2_0_dec_ring_insert_start,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB2456E8FF88AA6C6F48A0A12FE5C60DM5PR12MB2456namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
Please separate the patches to 2 patches. i. e. New ring test as one patch.=
<br>
<br>
Regards, <br>
Leo<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Thai, Thong &lt;Thong.Thai@am=
d.com&gt;<br>
<b>Sent:</b> July 24, 2019 3:50:47 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu/vcn_v2_0: Set CMD_SOURCE for RB comm=
ands</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Sets the CMD_SOURCE bit for VCN 2.0 decoder ring-b=
uffer commands. This bit was previously set by the RBC HW on older versions=
 of the firmware, and now needs to be set by the driver in order to work wi=
th the SW RBC found in newer versions
 of the firmware.<br>
<br>
Signed-off-by: Thong Thai &lt;thong.thai-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 44 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;-----<br>
&nbsp;1 file changed, 37 insertions(&#43;), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c<br>
index bc9726787c97..8daee23425f8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
@@ -1488,7 &#43;1488,7 @@ static void vcn_v2_0_dec_ring_insert_start(struct=
 amdgpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_P=
ACKET_START &lt;&lt; 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x8000000=
0 | (VCN_DEC_CMD_PACKET_START &lt;&lt; 1));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -1501,7 &#43;1501,7 @@ static void vcn_v2_0_dec_ring_insert_start(struct=
 amdgpu_ring *ring)<br>
&nbsp;static void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_P=
ACKET_END &lt;&lt; 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x8000000=
0 | (VCN_DEC_CMD_PACKET_END &lt;&lt; 1));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -1546,7 &#43;1546,7 @@ static void vcn_v2_0_dec_ring_emit_fence(struct a=
mdgpu_ring *ring, u64 addr, u64<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, up=
per_32_bits(addr) &amp; 0xff);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_F=
ENCE &lt;&lt; 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x8000000=
0 | (VCN_DEC_CMD_FENCE &lt;&lt; 1));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0)=
;<br>
@@ -1556,7 &#43;1556,7 @@ static void vcn_v2_0_dec_ring_emit_fence(struct a=
mdgpu_ring *ring, u64 addr, u64<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_T=
RAP &lt;&lt; 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x8000000=
0 | (VCN_DEC_CMD_TRAP &lt;&lt; 1));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -1600,7 &#43;1600,7 @@ static void vcn_v2_0_dec_ring_emit_reg_wait(struc=
t amdgpu_ring *ring,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_R=
EG_READ_COND_WAIT &lt;&lt; 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x8000000=
0 | (VCN_DEC_CMD_REG_READ_COND_WAIT &lt;&lt; 1));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void vcn_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,=
<br>
@@ -1629,7 &#43;1629,7 @@ static void vcn_v2_0_dec_ring_emit_wreg(struct am=
dgpu_ring *ring,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_CMD_W=
RITE_REG &lt;&lt; 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x8000000=
0 | (VCN_DEC_CMD_WRITE_REG &lt;&lt; 1));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -2082,6 &#43;2082,36 @@ static int vcn_v2_0_process_interrupt(struct amd=
gpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ri=
ng-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(adev-&gt;vcn.external.scra=
tch9, 0xCAFEDEAD);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_alloc(ring, 3);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET0(a=
dev-&gt;vcn.internal.cmd, 0));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x8000000=
0 | (VCN_DEC_CMD_PACKET_START &lt;&lt; 1));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET0(a=
dev-&gt;vcn.internal.scratch9, 0));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0xDEADBEE=
F);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;use=
c_timeout; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D RREG32(adev-&gt;vcn.external.scratch9);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (tmp =3D=3D 0xDEADBEEF)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_UDELAY(1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i &gt;=3D adev-&gt;usec_timeo=
ut)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -ETIMEDOUT;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;}<br>
&#43;<br>
&#43;<br>
&nbsp;static int vcn_v2_0_set_powergating_state(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_powergating_state state)<br>
&nbsp;{<br>
@@ -2145,7 &#43;2175,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_de=
c_ring_vm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib =3D vcn_v2_0_dec_=
ring_emit_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_fence =3D vcn_v2_0_d=
ec_ring_emit_fence,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_vm_flush =3D vcn_v2_=
0_dec_ring_emit_vm_flush,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ring =3D amdgpu_vcn_dec_ring_te=
st_ring,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ring =3D vcn_v2_0_dec_ring_=
test_ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ib =3D amdgpu_vcn_de=
c_ring_test_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D vcn_v2_0_d=
ec_ring_insert_nop,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_start =3D vcn_v2_0=
_dec_ring_insert_start,<br>
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

--_000_DM5PR12MB2456E8FF88AA6C6F48A0A12FE5C60DM5PR12MB2456namp_--

--===============1077557585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1077557585==--
