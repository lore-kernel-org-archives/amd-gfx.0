From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add HDP flush dummy for UVD 6/7
Date: Tue, 8 May 2018 15:46:41 +0000
Message-ID: <BN6PR12MB1809A00B996C25DC52B7CDC0F79A0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180508103006.3626-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0899296611=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180508103006.3626-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

--===============0899296611==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809A00B996C25DC52B7CDC0F79A0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809A00B996C25DC52B7CDC0F79A0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, May 8, 2018 6:30:06 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH] drm/amdgpu: add HDP flush dummy for UVD 6/7

The UVD firmware doesn't seem to like the HDP flush here.

This worked for years without HDP flush, so just skip it.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 13 ++++++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c
index 6d3359889c0b..8041b26a7a21 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -963,6 +963,16 @@ static void uvd_v6_0_enc_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr,
         amdgpu_ring_write(ring, HEVC_ENC_CMD_TRAP);
 }

+/**
+ * uvd_v6_0_ring_emit_hdp_flush - skip HDP flushing
+ *
+ * @ring: amdgpu_ring pointer
+ */
+static void uvd_v6_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+       /* The firmware doesn't seem to like touching registers at this poi=
nt. */
+}
+
 /**
  * uvd_v6_0_ring_test_ring - register write test
  *
@@ -1528,12 +1538,13 @@ static const struct amdgpu_ring_funcs uvd_v6_0_ring=
_phys_funcs =3D {
         .set_wptr =3D uvd_v6_0_ring_set_wptr,
         .parse_cs =3D amdgpu_uvd_ring_parse_cs,
         .emit_frame_size =3D
-               6 + 6 + /* hdp flush / invalidate */
+               6 + /* hdp invalidate */
                 10 + /* uvd_v6_0_ring_emit_pipeline_sync */
                 14, /* uvd_v6_0_ring_emit_fence x1 no user fence */
         .emit_ib_size =3D 8, /* uvd_v6_0_ring_emit_ib */
         .emit_ib =3D uvd_v6_0_ring_emit_ib,
         .emit_fence =3D uvd_v6_0_ring_emit_fence,
+       .emit_hdp_flush =3D uvd_v6_0_ring_emit_hdp_flush,
         .test_ring =3D uvd_v6_0_ring_test_ring,
         .test_ib =3D amdgpu_uvd_ring_test_ib,
         .insert_nop =3D amdgpu_ring_insert_nop,
@@ -1552,7 +1563,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_ring_v=
m_funcs =3D {
         .get_wptr =3D uvd_v6_0_ring_get_wptr,
         .set_wptr =3D uvd_v6_0_ring_set_wptr,
         .emit_frame_size =3D
-               6 + 6 + /* hdp flush / invalidate */
+               6 + /* hdp invalidate */
                 10 + /* uvd_v6_0_ring_emit_pipeline_sync */
                 VI_FLUSH_GPU_TLB_NUM_WREG * 6 + 8 + /* uvd_v6_0_ring_emit_=
vm_flush */
                 14 + 14, /* uvd_v6_0_ring_emit_fence x2 vm fence */
@@ -1561,6 +1572,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_ring_v=
m_funcs =3D {
         .emit_fence =3D uvd_v6_0_ring_emit_fence,
         .emit_vm_flush =3D uvd_v6_0_ring_emit_vm_flush,
         .emit_pipeline_sync =3D uvd_v6_0_ring_emit_pipeline_sync,
+       .emit_hdp_flush =3D uvd_v6_0_ring_emit_hdp_flush,
         .test_ring =3D uvd_v6_0_ring_test_ring,
         .test_ib =3D amdgpu_uvd_ring_test_ib,
         .insert_nop =3D amdgpu_ring_insert_nop,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v7_0.c
index 2251db4048f5..b0de1e04093b 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1135,6 +1135,16 @@ static void uvd_v7_0_enc_ring_emit_fence(struct amdg=
pu_ring *ring, u64 addr,
         amdgpu_ring_write(ring, HEVC_ENC_CMD_TRAP);
 }

+/**
+ * uvd_v7_0_ring_emit_hdp_flush - skip HDP flushing
+ *
+ * @ring: amdgpu_ring pointer
+ */
+static void uvd_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+       /* The firmware doesn't seem to like touching registers at this poi=
nt. */
+}
+
 /**
  * uvd_v7_0_ring_test_ring - register write test
  *
@@ -1654,7 +1664,7 @@ static const struct amdgpu_ring_funcs uvd_v7_0_ring_v=
m_funcs =3D {
         .get_wptr =3D uvd_v7_0_ring_get_wptr,
         .set_wptr =3D uvd_v7_0_ring_set_wptr,
         .emit_frame_size =3D
-               6 + 6 + /* hdp flush / invalidate */
+               6 + /* hdp invalidate */
                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
                 8 + /* uvd_v7_0_ring_emit_vm_flush */
@@ -1663,6 +1673,7 @@ static const struct amdgpu_ring_funcs uvd_v7_0_ring_v=
m_funcs =3D {
         .emit_ib =3D uvd_v7_0_ring_emit_ib,
         .emit_fence =3D uvd_v7_0_ring_emit_fence,
         .emit_vm_flush =3D uvd_v7_0_ring_emit_vm_flush,
+       .emit_hdp_flush =3D uvd_v7_0_ring_emit_hdp_flush,
         .test_ring =3D uvd_v7_0_ring_test_ring,
         .test_ib =3D amdgpu_uvd_ring_test_ib,
         .insert_nop =3D uvd_v7_0_ring_insert_nop,
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809A00B996C25DC52B7CDC0F79A0BN6PR12MB1809namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, May 8, 2018 6:30:06 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add HDP flush dummy for UVD 6/7</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The UVD firmware doesn't seem to like the HDP flus=
h here.<br>
<br>
This worked for years without HDP flush, so just skip it.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 16 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 13 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;2 files changed, 26 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c<br>
index 6d3359889c0b..8041b26a7a21 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
@@ -963,6 &#43;963,16 @@ static void uvd_v6_0_enc_ring_emit_fence(struct am=
dgpu_ring *ring, u64 addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, HE=
VC_ENC_CMD_TRAP);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/**<br>
&#43; * uvd_v6_0_ring_emit_hdp_flush - skip HDP flushing<br>
&#43; *<br>
&#43; * @ring: amdgpu_ring pointer<br>
&#43; */<br>
&#43;static void uvd_v6_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The firmware doesn't seem to l=
ike touching registers at this point. */<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp; * uvd_v6_0_ring_test_ring - register write test<br>
&nbsp; *<br>
@@ -1528,12 &#43;1538,13 @@ static const struct amdgpu_ring_funcs uvd_v6_0_=
ring_phys_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wptr =3D uvd_v6_0_rin=
g_set_wptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .parse_cs =3D amdgpu_uvd_r=
ing_parse_cs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_frame_size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 6 &#43; 6 &#43; /* hdp flush / invalidate */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 6 &#43; /* hdp invalidate */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 10 &#43; /* uvd_v6_0_ring_emit_pipeline_sync */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 14, /* uvd_v6_0_ring_emit_fence x1 no user fence */<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib_size =3D 8, /* uv=
d_v6_0_ring_emit_ib */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib =3D uvd_v6_0_ring=
_emit_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_fence =3D uvd_v6_0_r=
ing_emit_fence,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_hdp_flush =3D uvd_v6_0_ring=
_emit_hdp_flush,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ring =3D uvd_v6_0_ri=
ng_test_ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ib =3D amdgpu_uvd_ri=
ng_test_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D amdgpu_rin=
g_insert_nop,<br>
@@ -1552,7 &#43;1563,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_ri=
ng_vm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wptr =3D uvd_v6_0_rin=
g_get_wptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wptr =3D uvd_v6_0_rin=
g_set_wptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_frame_size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 6 &#43; 6 &#43; /* hdp flush / invalidate */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 6 &#43; /* hdp invalidate */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 10 &#43; /* uvd_v6_0_ring_emit_pipeline_sync */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; VI_FLUSH_GPU_TLB_NUM_WREG * 6 &#43; 8 &#43; /* uvd_v6=
_0_ring_emit_vm_flush */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 14 &#43; 14, /* uvd_v6_0_ring_emit_fence x2 vm fence =
*/<br>
@@ -1561,6 &#43;1572,7 @@ static const struct amdgpu_ring_funcs uvd_v6_0_ri=
ng_vm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_fence =3D uvd_v6_0_r=
ing_emit_fence,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_vm_flush =3D uvd_v6_=
0_ring_emit_vm_flush,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_pipeline_sync =3D uv=
d_v6_0_ring_emit_pipeline_sync,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_hdp_flush =3D uvd_v6_0_ring=
_emit_hdp_flush,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ring =3D uvd_v6_0_ri=
ng_test_ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ib =3D amdgpu_uvd_ri=
ng_test_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D amdgpu_rin=
g_insert_nop,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v7_0.c<br>
index 2251db4048f5..b0de1e04093b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
@@ -1135,6 &#43;1135,16 @@ static void uvd_v7_0_enc_ring_emit_fence(struct =
amdgpu_ring *ring, u64 addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, HE=
VC_ENC_CMD_TRAP);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/**<br>
&#43; * uvd_v7_0_ring_emit_hdp_flush - skip HDP flushing<br>
&#43; *<br>
&#43; * @ring: amdgpu_ring pointer<br>
&#43; */<br>
&#43;static void uvd_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The firmware doesn't seem to l=
ike touching registers at this point. */<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp; * uvd_v7_0_ring_test_ring - register write test<br>
&nbsp; *<br>
@@ -1654,7 &#43;1664,7 @@ static const struct amdgpu_ring_funcs uvd_v7_0_ri=
ng_vm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wptr =3D uvd_v7_0_rin=
g_get_wptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wptr =3D uvd_v7_0_rin=
g_set_wptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_frame_size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 6 &#43; 6 &#43; /* hdp flush / invalidate */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 6 &#43; /* hdp invalidate */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 &#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 &#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 8 &#43; /* uvd_v7_0_ring_emit_vm_flush */<br>
@@ -1663,6 &#43;1673,7 @@ static const struct amdgpu_ring_funcs uvd_v7_0_ri=
ng_vm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_ib =3D uvd_v7_0_ring=
_emit_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_fence =3D uvd_v7_0_r=
ing_emit_fence,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_vm_flush =3D uvd_v7_=
0_ring_emit_vm_flush,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_hdp_flush =3D uvd_v7_0_ring=
_emit_hdp_flush,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ring =3D uvd_v7_0_ri=
ng_test_ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .test_ib =3D amdgpu_uvd_ri=
ng_test_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D uvd_v7_0_r=
ing_insert_nop,<br>
-- <br>
2.14.1<br>
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

--_000_BN6PR12MB1809A00B996C25DC52B7CDC0F79A0BN6PR12MB1809namp_--

--===============0899296611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0899296611==--
