From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: cast mem->num_pages to 64-bits when
 shifting
Date: Mon, 17 Jun 2019 14:21:32 -0400
Message-ID: <CAAzXoRK9vy-qC36mSzJ3aJr6YB8kuWMujxfuNFAqAzbWEk+gTA@mail.gmail.com>
References: <20190614165108.23011-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1277517907=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190614165108.23011-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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

--===============1277517907==
Content-Type: multipart/alternative; boundary="00000000000078d28d058b891157"

--00000000000078d28d058b891157
Content-Type: text/plain; charset="UTF-8"

ping?

On Fri, Jun 14, 2019 at 12:51 PM StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org> wrote:

> On 32-bit hosts mem->num_pages is 32-bits and can overflow
> when shifted.  Add a cast to avoid this.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index c963ad86072e..31895d3c33de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -279,14 +279,16 @@ static int amdgpu_vram_mgr_new(struct
> ttm_mem_type_manager *man,
>         uint64_t vis_usage = 0;
>         unsigned i;
>         int r;
> +       uint64_t mem_bytes;
>
>         lpfn = place->lpfn;
>         if (!lpfn)
>                 lpfn = man->size;
>
>         /* bail out quickly if there's likely not enough VRAM for this BO
> */
> -       if (atomic64_add_return(mem->num_pages << PAGE_SHIFT, &mgr->usage)
> > adev->gmc.mc_vram_size) {
> -               atomic64_sub(mem->num_pages << PAGE_SHIFT, &mgr->usage);
> +       mem_bytes = (u64)mem->num_pages << PAGE_SHIFT;
> +       if (atomic64_add_return(mem_bytes, &mgr->usage) >
> adev->gmc.mc_vram_size) {
> +               atomic64_sub(mem_bytes, &mgr->usage);
>                 mem->mm_node = NULL;
>                 return 0;
>         }
> @@ -308,7 +310,7 @@ static int amdgpu_vram_mgr_new(struct
> ttm_mem_type_manager *man,
>         nodes = kvmalloc_array((uint32_t)num_nodes, sizeof(*nodes),
>                                GFP_KERNEL | __GFP_ZERO);
>         if (!nodes) {
> -               atomic64_sub(mem->num_pages << PAGE_SHIFT, &mgr->usage);
> +               atomic64_sub(mem_bytes, &mgr->usage);
>                 return -ENOMEM;
>         }
>
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--00000000000078d28d058b891157
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ping?</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Fri, Jun 14, 2019 at 12:51 PM StDenis, Tom &lt;<a =
href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On 32-bit hosts mem-=
&gt;num_pages is 32-bits and can overflow<br>
when shifted.=C2=A0 Add a cast to avoid this.<br>
<br>
Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org" targ=
et=3D"_blank">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 8 +++++---<br>
=C2=A01 file changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vram_mgr.c<br>
index c963ad86072e..31895d3c33de 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c<br>
@@ -279,14 +279,16 @@ static int amdgpu_vram_mgr_new(struct ttm_mem_type_ma=
nager *man,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t vis_usage =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int r;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t mem_bytes;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lpfn =3D place-&gt;lpfn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lpfn)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lpfn =3D man-&gt;si=
ze;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* bail out quickly if there&#39;s likely not e=
nough VRAM for this BO */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (atomic64_add_return(mem-&gt;num_pages &lt;&=
lt; PAGE_SHIFT, &amp;mgr-&gt;usage) &gt; adev-&gt;gmc.mc_vram_size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_sub(mem-&g=
t;num_pages &lt;&lt; PAGE_SHIFT, &amp;mgr-&gt;usage);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mem_bytes =3D (u64)mem-&gt;num_pages &lt;&lt; P=
AGE_SHIFT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (atomic64_add_return(mem_bytes, &amp;mgr-&gt=
;usage) &gt; adev-&gt;gmc.mc_vram_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_sub(mem_by=
tes, &amp;mgr-&gt;usage);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem-&gt;mm_node =3D=
 NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -308,7 +310,7 @@ static int amdgpu_vram_mgr_new(struct ttm_mem_type_mana=
ger *man,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nodes =3D kvmalloc_array((uint32_t)num_nodes, s=
izeof(*nodes),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GFP_KERNEL | __GFP_ZERO);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!nodes) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_sub(mem-&g=
t;num_pages &lt;&lt; PAGE_SHIFT, &amp;mgr-&gt;usage);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_sub(mem_by=
tes, &amp;mgr-&gt;usage);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-- <br>
2.21.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a></blockquote></div>

--00000000000078d28d058b891157--

--===============1277517907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1277517907==--
