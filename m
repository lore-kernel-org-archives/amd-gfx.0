From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: don't invalidate caches in RELEASE_MEM, only
 do the writeback
Date: Mon, 8 Jul 2019 13:31:58 -0400
Message-ID: <CAAxE2A5FUU-TukfWC0-Od9u_deQKV3JZjPXCbwin=ccx-dOx-g@mail.gmail.com>
References: <20190702182901.22491-1-maraeo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0794997946=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190702182901.22491-1-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0794997946==
Content-Type: multipart/alternative; boundary="000000000000862a5f058d2ed4ed"

--000000000000862a5f058d2ed4ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Tue, Jul 2, 2019 at 2:29 PM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:

> From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>
> This RELEASE_MEM use has the Release semantic, which means we should writ=
e
> back but not invalidate. Invalidations only make sense with the Acquire
> semantic (ACQUIRE_MEM), or when RELEASE_MEM is used to do the combined
> Acquire-Release semantic, which is a barrier, not a fence.
>
> The undesirable side effect of doing invalidations for the Release semant=
ic
> is that it invalidates caches while shaders are running, because the
> Release
> can execute in the middle of the next IB.
>
> UMDs should use ACQUIRE_MEM at the beginning of IBs. Doing cache
> invalidations for a fence (like in this case) doesn't do anything
> for correctness.
>
> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 210d24511dc6..a30f5d4913b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4296,25 +4296,21 @@ static void gfx_v10_0_ring_emit_fence(struct
> amdgpu_ring *ring, u64 addr,
>         bool int_sel =3D flags & AMDGPU_FENCE_FLAG_INT;
>
>         /* Interrupt not work fine on GFX10.1 model yet. Use fallback
> instead */
>         if (adev->pdev->device =3D=3D 0x50)
>                 int_sel =3D false;
>
>         /* RELEASE_MEM - flush caches, send int */
>         amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
>         amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ |
>                                  PACKET3_RELEASE_MEM_GCR_GL2_WB |
> -                                PACKET3_RELEASE_MEM_GCR_GL2_INV |
> -                                PACKET3_RELEASE_MEM_GCR_GL2_US |
> -                                PACKET3_RELEASE_MEM_GCR_GL1_INV |
> -                                PACKET3_RELEASE_MEM_GCR_GLV_INV |
> -                                PACKET3_RELEASE_MEM_GCR_GLM_INV |
> +                                PACKET3_RELEASE_MEM_GCR_GLM_INV | /* mus=
t
> be set with GLM_WB */
>                                  PACKET3_RELEASE_MEM_GCR_GLM_WB |
>                                  PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
>
>  PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
>                                  PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
>         amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit =
?
> 2 : 1) |
>                                  PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 =
:
> 0)));
>
>         /*
>          * the address should be Qword aligned if 64bit write, Dword
>          * aligned if only send 32bit data low (discard data high)
> --
> 2.17.1
>
>

--000000000000862a5f058d2ed4ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ping<br></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Jul 2, 2019 at 2:29 PM Marek Ol=C5=A1=C3=
=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Marek Ol=
=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">=
marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
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
invalidations for a fence (like in this case) doesn&#39;t do anything<br>
for correctness.<br>
<br>
Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak@amd.=
com" target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +-----<br>
=C2=A01 file changed, 1 insertion(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 210d24511dc6..a30f5d4913b9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4296,25 +4296,21 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool int_sel =3D flags &amp; AMDGPU_FENCE_FLAG_=
INT;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Interrupt not work fine on GFX10.1 model yet=
. Use fallback instead */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;pdev-&gt;device =3D=3D 0x50)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int_sel =3D false;<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* RELEASE_MEM - flush caches, send int */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE=
_MEM, 6));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GC=
R_SEQ |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PACKET3_RELEASE_MEM_GCR_GL2_WB=
 |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PACKET3_RELEASE_MEM_GCR_GL2_INV |<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PACKET3_RELEASE_MEM_GCR_GL2_US |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PACKET3_RELEASE_MEM_GCR_GL1_INV |<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PACKET3_RELEASE_MEM_GCR_GLV_INV |<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PACKET3_RELEASE_MEM_GCR_GLM_INV |<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PACKET3_RELEASE_MEM_GCR_GLM_INV | /*=
 must be set with GLM_WB */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PACKET3_RELEASE_MEM_GCR_GLM_WB=
 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PACKET3_RELEASE_MEM_CACHE_POLI=
CY(3) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PACKET3_RELEASE_MEM_EVENT_TYPE=
(CACHE_FLUSH_AND_INV_TS_EVENT) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PACKET3_RELEASE_MEM_EVENT_INDE=
X(5)));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DA=
TA_SEL(write64bit ? 2 : 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PACKET3_RELEASE_MEM_INT_SEL(in=
t_sel ? 2 : 0)));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the address should be Qword aligned if =
64bit write, Dword<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* aligned if only send 32bit data low (di=
scard data high)<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div>

--000000000000862a5f058d2ed4ed--

--===============0794997946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0794997946==--
