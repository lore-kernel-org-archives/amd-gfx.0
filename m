From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: don't invalidate caches in RELEASE_MEM, only
 do the writeback
Date: Mon, 8 Jul 2019 17:51:53 +0000
Message-ID: <BN6PR12MB180974B4A10C0862544AEF25F7F60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190702182901.22491-1-maraeo@gmail.com>,
 <CAAxE2A5FUU-TukfWC0-Od9u_deQKV3JZjPXCbwin=ccx-dOx-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1077736329=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A5FUU-TukfWC0-Od9u_deQKV3JZjPXCbwin=ccx-dOx-g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?Windows-1252?Q?Marek_Ol=9A=E1k?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1077736329==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180974B4A10C0862544AEF25F7F60BN6PR12MB1809namp_"

--_000_BN6PR12MB180974B4A10C0862544AEF25F7F60BN6PR12MB1809namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Marek Ol=
=9A=E1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, July 8, 2019 1:31 PM
To: amd-gfx mailing list
Subject: Re: [PATCH] drm/amdgpu: don't invalidate caches in RELEASE_MEM, on=
ly do the writeback

ping

On Tue, Jul 2, 2019 at 2:29 PM Marek Ol=9A=E1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:mar=
aeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
From: Marek Ol=9A=E1k <marek.olsak-5C7GfCeVMHo@public.gmane.org<mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org>>

This RELEASE_MEM use has the Release semantic, which means we should write
back but not invalidate. Invalidations only make sense with the Acquire
semantic (ACQUIRE_MEM), or when RELEASE_MEM is used to do the combined
Acquire-Release semantic, which is a barrier, not a fence.

The undesirable side effect of doing invalidations for the Release semantic
is that it invalidates caches while shaders are running, because the Releas=
e
can execute in the middle of the next IB.

UMDs should use ACQUIRE_MEM at the beginning of IBs. Doing cache
invalidations for a fence (like in this case) doesn't do anything
for correctness.

Signed-off-by: Marek Ol=9A=E1k <marek.olsak-5C7GfCeVMHo@public.gmane.org<mailto:marek.olsak@amd.=
com>>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 210d24511dc6..a30f5d4913b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4296,25 +4296,21 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr,
        bool int_sel =3D flags & AMDGPU_FENCE_FLAG_INT;

        /* Interrupt not work fine on GFX10.1 model yet. Use fallback inste=
ad */
        if (adev->pdev->device =3D=3D 0x50)
                int_sel =3D false;

        /* RELEASE_MEM - flush caches, send int */
        amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
        amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ |
                                 PACKET3_RELEASE_MEM_GCR_GL2_WB |
-                                PACKET3_RELEASE_MEM_GCR_GL2_INV |
-                                PACKET3_RELEASE_MEM_GCR_GL2_US |
-                                PACKET3_RELEASE_MEM_GCR_GL1_INV |
-                                PACKET3_RELEASE_MEM_GCR_GLV_INV |
-                                PACKET3_RELEASE_MEM_GCR_GLM_INV |
+                                PACKET3_RELEASE_MEM_GCR_GLM_INV | /* must =
be set with GLM_WB */
                                 PACKET3_RELEASE_MEM_GCR_GLM_WB |
                                 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
                                 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH=
_AND_INV_TS_EVENT) |
                                 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
        amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? =
2 : 1) |
                                 PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : =
0)));

        /*
         * the address should be Qword aligned if 64bit write, Dword
         * aligned if only send 32bit data low (discard data high)
--
2.17.1


--_000_BN6PR12MB180974B4A10C0862544AEF25F7F60BN6PR12MB1809namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Marek Ol=9A=E1k &lt;maraeo@gm=
ail.com&gt;<br>
<b>Sent:</b> Monday, July 8, 2019 1:31 PM<br>
<b>To:</b> amd-gfx mailing list<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: don't invalidate caches in RELEASE_=
MEM, only do the writeback</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">ping<br>
</div>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Tue, Jul 2, 2019 at 2:29 PM Mare=
k Ol=9A=E1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt=
; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
From: Marek Ol=9A=E1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org" target=3D"=
_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
This RELEASE_MEM use has the Release semantic, which means we should write<=
br>
back but not invalidate. Invalidations only make sense with the Acquire<br>
semantic (ACQUIRE_MEM), or when RELEASE_MEM is used to do the combined<br>
Acquire-Release semantic, which is a barrier, not a fence.<br>
<br>
The undesirable side effect of doing invalidations for the Release semantic=
<br>
is that it invalidates caches while shaders are running, because the Releas=
e<br>
can execute in the middle of the next IB.<br>
<br>
UMDs should use ACQUIRE_MEM at the beginning of IBs. Doing cache<br>
invalidations for a fence (like in this case) doesn't do anything<br>
for correctness.<br>
<br>
Signed-off-by: Marek Ol=9A=E1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org" t=
arget=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 &#43;-----<br>
&nbsp;1 file changed, 1 insertion(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 210d24511dc6..a30f5d4913b9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4296,25 &#43;4296,21 @@ static void gfx_v10_0_ring_emit_fence(struct am=
dgpu_ring *ring, u64 addr,<br>
&nbsp; &nbsp; &nbsp; &nbsp; bool int_sel =3D flags &amp; AMDGPU_FENCE_FLAG_=
INT;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; /* Interrupt not work fine on GFX10.1 model yet=
. Use fallback instead */<br>
&nbsp; &nbsp; &nbsp; &nbsp; if (adev-&gt;pdev-&gt;device =3D=3D 0x50)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int_sel =3D false;<=
br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; /* RELEASE_MEM - flush caches, send int */<br>
&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE=
_MEM, 6));<br>
&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GC=
R_SEQ |<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;PACKET3_RELEASE_MEM_GCR_GL2_WB |=
<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PACKET3_RELEASE_MEM_GCR_GL2_INV |<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PACKET3_RELEASE_MEM_GCR_GL2_US |<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PACKET3_RELEASE_MEM_GCR_GL1_INV |<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PACKET3_RELEASE_MEM_GCR_GLV_INV |<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PACKET3_RELEASE_MEM_GCR_GLM_INV |<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PACKET3_RELEASE_MEM_GCR_GLM_INV |=
 /* must be set with GLM_WB */<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;PACKET3_RELEASE_MEM_GCR_GLM_WB |=
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;PACKET3_RELEASE_MEM_CACHE_POLICY=
(3) |<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;PACKET3_RELEASE_MEM_EVENT_TYPE(C=
ACHE_FLUSH_AND_INV_TS_EVENT) |<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;PACKET3_RELEASE_MEM_EVENT_INDEX(=
5)));<br>
&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DA=
TA_SEL(write64bit ? 2 : 1) |<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;PACKET3_RELEASE_MEM_INT_SEL(int_=
sel ? 2 : 0)));<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; /*<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* the address should be Qword aligned if =
64bit write, Dword<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* aligned if only send 32bit data low (di=
scard data high)<br>
-- <br>
2.17.1<br>
<br>
</blockquote>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB180974B4A10C0862544AEF25F7F60BN6PR12MB1809namp_--

--===============1077736329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1077736329==--
