From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: allocate GTT space for shadow VM page tables
Date: Fri, 16 Sep 2016 09:55:43 +0000
Message-ID: <CAHbf0-EBxKZqwWstQxTYt_=2yy_0e0CGMtnnoZiQ_wFs-0itMw@mail.gmail.com>
References: <1474019288-5770-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1814425322=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474019288-5770-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1814425322==
Content-Type: multipart/alternative; boundary=001a114b07d4f14f3c053c9cf77b

--001a114b07d4f14f3c053c9cf77b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Does this fix the issue I was seeing since the new memory manager went into
thr 4.9-wip branch?

On Fri, 16 Sep 2016, 10:48 am Christian K=C3=B6nig, <deathsimple@vodafone.d=
e>
wrote:

> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> We need to access those with the system domain.
>
> Fixes fallout from only allocating GTT space on demand.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a6a48ed..8928a2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -552,6 +552,10 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device
> *adev,
>         if (r)
>                 goto error;
>
> +       r =3D amdgpu_ttm_bind(&bo->tbo, &bo->tbo.mem);
> +       if (r)
> +               goto error;
> +
>         addr =3D amdgpu_bo_gpu_offset(bo);
>         entries =3D amdgpu_bo_size(bo) / 8;
>
> @@ -625,6 +629,11 @@ static int amdgpu_vm_update_pd_or_shadow(struct
> amdgpu_device *adev,
>
>         if (!pd)
>                 return 0;
> +
> +       r =3D amdgpu_ttm_bind(&pd->tbo, &pd->tbo.mem);
> +       if (r)
> +               return r;
> +
>         pd_addr =3D amdgpu_bo_gpu_offset(pd);
>         ring =3D container_of(vm->entity.sched, struct amdgpu_ring, sched=
);
>
> @@ -650,6 +659,14 @@ static int amdgpu_vm_update_pd_or_shadow(struct
> amdgpu_device *adev,
>                 if (bo =3D=3D NULL)
>                         continue;
>
> +               if (bo->shadow) {
> +                       struct amdgpu_bo *shadow =3D bo->shadow;
> +
> +                       r =3D amdgpu_ttm_bind(&shadow->tbo,
> &shadow->tbo.mem);
> +                       if (r)
> +                               return r;
> +               }
> +
>                 pt =3D amdgpu_bo_gpu_offset(bo);
>                 if (!shadow) {
>                         if (vm->page_tables[pt_idx].addr =3D=3D pt)
> --
> 2.5.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a114b07d4f14f3c053c9cf77b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Does this fix the issue I was seeing since the new memory ma=
nager went into thr 4.9-wip branch?</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, 16 Sep 2016, 10:48 =
am Christian K=C3=B6nig, &lt;<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">dea=
thsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>From: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
We need to access those with the system domain.<br>
<br>
Fixes fallout from only allocating GTT space on demand.<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++<br>
=C2=A01 file changed, 17 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index a6a48ed..8928a2a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -552,6 +552,10 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *ad=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ttm_bind(&amp;bo-&gt;tbo, &amp;bo-=
&gt;tbo.mem);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D amdgpu_bo_gpu_offset(bo);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 entries =3D amdgpu_bo_size(bo) / 8;<br>
<br>
@@ -625,6 +629,11 @@ static int amdgpu_vm_update_pd_or_shadow(struct amdgpu=
_device *adev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ttm_bind(&amp;pd-&gt;tbo, &amp;pd-=
&gt;tbo.mem);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pd_addr =3D amdgpu_bo_gpu_offset(pd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring =3D container_of(vm-&gt;entity.sched, stru=
ct amdgpu_ring, sched);<br>
<br>
@@ -650,6 +659,14 @@ static int amdgpu_vm_update_pd_or_shadow(struct amdgpu=
_device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bo =3D=3D NULL)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo-&gt;shadow) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct amdgpu_bo *shadow =3D bo-&gt;shadow;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0r =3D amdgpu_ttm_bind(&amp;shadow-&gt;tbo, &amp;shadow-&gt;tbo.me=
m);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (r)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pt =3D amdgpu_bo_gp=
u_offset(bo);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!shadow) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (vm-&gt;page_tables[pt_idx].addr =3D=3D pt)<br>
--<br>
2.5.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--001a114b07d4f14f3c053c9cf77b--

--===============1814425322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1814425322==--
