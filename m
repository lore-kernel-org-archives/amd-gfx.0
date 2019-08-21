From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/radeon: use WAIT_REG_MEM special op for CP HDP
 flush
Date: Wed, 21 Aug 2019 22:23:33 +0000
Message-ID: <BN6PR12MB1809DC90F9DBB4F86DCA278CF7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190821222034.13387-1-alexander.deucher@amd.com>,
 <20190821222034.13387-5-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1524886053=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190821222034.13387-5-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1524886053==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809DC90F9DBB4F86DCA278CF7AA0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809DC90F9DBB4F86DCA278CF7AA0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ignore those.  wrong directory.

Alex
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, August 21, 2019 6:20 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/radeon: use WAIT_REG_MEM special op for CP HDP flu=
sh

Flush via the ring works differently on CIK and requires a
special sequence.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/radeon/cik.c | 73 +++++++++++++++++++++++++++-------------=
----
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 0847367..03dd075 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3485,6 +3485,48 @@ int cik_ring_test(struct radeon_device *rdev, struct=
 radeon_ring *ring)
         return r;
 }

+static void cik_gfx_hdp_flush(struct radeon_device *rdev,
+                             int ridx)
+{
+       struct radeon_ring *ring =3D &rdev->ring[ridx];
+       u32 ref_and_mask;
+
+       switch (ring->idx) {
+       case CAYMAN_RING_TYPE_CP1_INDEX:
+       case CAYMAN_RING_TYPE_CP2_INDEX:
+               switch (ring->me) {
+               case 0:
+                       ref_and_mask =3D CP2 << ring->pipe;
+                       break;
+               case 1:
+                       ref_and_mask =3D CP6 << ring->pipe;
+                       break;
+               default:
+                       return;
+               }
+               break;
+       case RADEON_RING_TYPE_GFX_INDEX:
+               ref_and_mask =3D CP0;
+               break;
+       default:
+               return;
+       }
+
+       radeon_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
+       radeon_ring_write(ring, ((CP_WAIT_REG_MEM_TIMEOUT -
+                                 PACKET3_SET_UCONFIG_REG_START) >> 2));
+       radeon_ring_write(ring, 0xfff);
+
+       radeon_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
+       radeon_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* special op =
*/
+                                WAIT_REG_MEM_FUNCTION(3))); /* =3D=3D */
+       radeon_ring_write(ring, GPU_HDP_FLUSH_REQ >> 2);
+       radeon_ring_write(ring, GPU_HDP_FLUSH_DONE >> 2);
+       radeon_ring_write(ring, ref_and_mask);
+       radeon_ring_write(ring, ref_and_mask);
+       radeon_ring_write(ring, 0xa); /* poll interval */
+}
+
 /**
  * cik_fence_gfx_ring_emit - emit a fence on the gfx ring
  *
@@ -3511,15 +3553,7 @@ void cik_fence_gfx_ring_emit(struct radeon_device *r=
dev,
         radeon_ring_write(ring, fence->seq);
         radeon_ring_write(ring, 0);
         /* HDP flush */
-       /* We should be using the new WAIT_REG_MEM special op packet here
-        * but it causes the CP to hang
-        */
-       radeon_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-       radeon_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-                                WRITE_DATA_DST_SEL(0)));
-       radeon_ring_write(ring, HDP_MEM_COHERENCY_FLUSH_CNTL >> 2);
-       radeon_ring_write(ring, 0);
-       radeon_ring_write(ring, 0);
+       cik_gfx_hdp_flush(rdev, fence->ring);
 }

 /**
@@ -3549,15 +3583,7 @@ void cik_fence_compute_ring_emit(struct radeon_devic=
e *rdev,
         radeon_ring_write(ring, fence->seq);
         radeon_ring_write(ring, 0);
         /* HDP flush */
-       /* We should be using the new WAIT_REG_MEM special op packet here
-        * but it causes the CP to hang
-        */
-       radeon_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-       radeon_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-                                WRITE_DATA_DST_SEL(0)));
-       radeon_ring_write(ring, HDP_MEM_COHERENCY_FLUSH_CNTL >> 2);
-       radeon_ring_write(ring, 0);
-       radeon_ring_write(ring, 0);
+       cik_gfx_hdp_flush(rdev, fence->ring);
 }

 bool cik_semaphore_ring_emit(struct radeon_device *rdev,
@@ -5369,16 +5395,7 @@ void cik_vm_flush(struct radeon_device *rdev, int ri=
dx, struct radeon_vm *vm)
         radeon_ring_write(ring, VMID(0));

         /* HDP flush */
-       /* We should be using the WAIT_REG_MEM packet here like in
-        * cik_fence_ring_emit(), but it causes the CP to hang in this
-        * context...
-        */
-       radeon_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-       radeon_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-                                WRITE_DATA_DST_SEL(0)));
-       radeon_ring_write(ring, HDP_MEM_COHERENCY_FLUSH_CNTL >> 2);
-       radeon_ring_write(ring, 0);
-       radeon_ring_write(ring, 0);
+       cik_gfx_hdp_flush(rdev, ridx);

         /* bits 0-15 are the VM contexts0-15 */
         radeon_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
--
1.8.3.1


--_000_BN6PR12MB1809DC90F9DBB4F86DCA278CF7AA0BN6PR12MB1809namp_
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
Ignore those.&nbsp; wrong directory.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, August 21, 2019 6:20 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/radeon: use WAIT_REG_MEM special op for CP =
HDP flush</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Flush via the ring works differently on CIK and re=
quires a<br>
special sequence.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/radeon/cik.c | 73 &#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;-----------------<br>
&nbsp;1 file changed, 45 insertions(&#43;), 28 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c<br=
>
index 0847367..03dd075 100644<br>
--- a/drivers/gpu/drm/radeon/cik.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/radeon/cik.c<br>
@@ -3485,6 &#43;3485,48 @@ int cik_ring_test(struct radeon_device *rdev, st=
ruct radeon_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void cik_gfx_hdp_flush(struct radeon_device *rdev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; int ridx)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct radeon_ring *ring =3D &amp=
;rdev-&gt;ring[ridx];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ref_and_mask;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ring-&gt;idx) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CAYMAN_RING_TYPE_CP1_INDEX:<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CAYMAN_RING_TYPE_CP2_INDEX:<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; switch (ring-&gt;me) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; case 0:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ref_and_mask=
 =3D CP2 &lt;&lt; ring-&gt;pipe;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; case 1:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ref_and_mask=
 =3D CP6 &lt;&lt; ring-&gt;pipe;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RADEON_RING_TYPE_GFX_INDEX:<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ref_and_mask =3D CP0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACKET3(P=
ACKET3_SET_UCONFIG_REG, 1));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, ((CP_WAIT=
_REG_MEM_TIMEOUT -<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PACKET3_SET_UCONFIG_REG_STA=
RT) &gt;&gt; 2));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0xfff);<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACKET3(P=
ACKET3_WAIT_REG_MEM, 5));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, (WAIT_REG=
_MEM_OPERATION(1) | /* special op */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WAIT_REG_MEM_FUNCTION(3))); /* =
=3D=3D */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, GPU_HDP_F=
LUSH_REQ &gt;&gt; 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, GPU_HDP_F=
LUSH_DONE &gt;&gt; 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, ref_and_m=
ask);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, ref_and_m=
ask);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0xa); /* =
poll interval */<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp; * cik_fence_gfx_ring_emit - emit a fence on the gfx ring<br>
&nbsp; *<br>
@@ -3511,15 &#43;3553,7 @@ void cik_fence_gfx_ring_emit(struct radeon_devic=
e *rdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, fe=
nce-&gt;seq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HDP flush */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We should be using the new WAIT_RE=
G_MEM special op packet here<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * but it causes the CP to hang<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACKET3(PACKE=
T3_WRITE_DATA, 3));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, (WRITE_DATA_E=
NGINE_SEL(0) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0)));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, HDP_MEM_COHER=
ENCY_FLUSH_CNTL &gt;&gt; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cik_gfx_hdp_flush(rdev, fence-&gt=
;ring);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -3549,15 &#43;3583,7 @@ void cik_fence_compute_ring_emit(struct radeon_d=
evice *rdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, fe=
nce-&gt;seq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HDP flush */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We should be using the new WAIT_RE=
G_MEM special op packet here<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * but it causes the CP to hang<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACKET3(PACKE=
T3_WRITE_DATA, 3));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, (WRITE_DATA_E=
NGINE_SEL(0) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0)));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, HDP_MEM_COHER=
ENCY_FLUSH_CNTL &gt;&gt; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cik_gfx_hdp_flush(rdev, fence-&gt=
;ring);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;bool cik_semaphore_ring_emit(struct radeon_device *rdev,<br>
@@ -5369,16 &#43;5395,7 @@ void cik_vm_flush(struct radeon_device *rdev, in=
t ridx, struct radeon_vm *vm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, VM=
ID(0));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HDP flush */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We should be using the WAIT_REG_ME=
M packet here like in<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * cik_fence_ring_emit(), but it=
 causes the CP to hang in this<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * context...<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PACKET3(PACKE=
T3_WRITE_DATA, 3));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, (WRITE_DATA_E=
NGINE_SEL(0) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0)));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, HDP_MEM_COHER=
ENCY_FLUSH_CNTL &gt;&gt; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cik_gfx_hdp_flush(rdev, ridx);<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bits 0-15 are the VM co=
ntexts0-15 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_ring_write(ring, PA=
CKET3(PACKET3_WRITE_DATA, 3));<br>
-- <br>
1.8.3.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809DC90F9DBB4F86DCA278CF7AA0BN6PR12MB1809namp_--

--===============1524886053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1524886053==--
