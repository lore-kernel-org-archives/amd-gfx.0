From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: mitigate workaround for i915
Date: Tue, 20 Mar 2018 20:38:44 +0000
Message-ID: <CAHbf0-HzQcL-35OH3C7Yri8hHK9AkDQEPOZ6YUqXnMWB3MqwOA@mail.gmail.com>
References: <20180219135755.1714-1-christian.koenig@amd.com>
 <20180219135755.1714-2-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1667887529=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180219135755.1714-2-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1667887529==
Content-Type: multipart/alternative; boundary="001a114fd7c4c558140567de1048"

--001a114fd7c4c558140567de1048
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2018 at 13:58 Christian K=C3=B6nig <ckoenig.leichtzumerken@g=
mail.
com> wrote:

> To be able to use DRI_PRIME with amdgpu and i915 we add all our fences
> only as exclusive ones.
>
> Disable that behavior when sharing between amdgpu itself cause it
> hinders concurrent execution.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 31
> ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> index f6d7f6404a07..8ce74a1d9966 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> @@ -30,6 +30,8 @@
>  #include <drm/amdgpu_drm.h>
>  #include <linux/dma-buf.h>
>
> +static const struct dma_buf_ops amdgpu_dmabuf_ops;
> +
>  struct sg_table *amdgpu_gem_prime_get_sg_table(struct drm_gem_object
> *obj)
>  {
>         struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> @@ -129,20 +131,27 @@ static int amdgpu_gem_map_attach(struct dma_buf
> *dma_buf,
>         if (unlikely(r !=3D 0))
>                 goto error_detach;
>
> -       /*
> -        * Wait for all shared fences to complete before we switch to
> future
> -        * use of exclusive fence on this prime shared bo.
> -        */
> -       r =3D reservation_object_wait_timeout_rcu(bo->tbo.resv, true, fal=
se,
> -                                               MAX_SCHEDULE_TIMEOUT);
> -       if (unlikely(r < 0)) {
> -               DRM_DEBUG_PRIME("Fence wait failed: %li\n", r);
> -               goto error_unreserve;
> +
> +       if (dma_buf->ops !=3D &amdgpu_dmabuf_ops) {
> +               /*
> +                * Wait for all shared fences to complete before we switc=
h
> to future
> +                * use of exclusive fence on this prime shared bo.
> +                */
> +               r =3D reservation_object_wait_timeout_rcu(bo->tbo.resv,
> +                                                       true, false,
> +
>  MAX_SCHEDULE_TIMEOUT);
> +               if (unlikely(r < 0)) {
> +                       DRM_DEBUG_PRIME("Fence wait failed: %li\n", r);
> +                       goto error_unreserve;
> +               }
>         }
>
>         /* pin buffer into GTT */
>         r =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT, NULL);
> -       if (likely(r =3D=3D 0))
> +       if (r)
> +               goto error_unreserve;
> +
> +       if (dma_buf->ops !=3D &amdgpu_dmabuf_ops)
>                 bo->prime_shared_count++;
>
>  error_unreserve:
> @@ -166,7 +175,7 @@ static void amdgpu_gem_map_detach(struct dma_buf
> *dma_buf,
>                 goto error;
>
>         amdgpu_bo_unpin(bo);
> -       if (bo->prime_shared_count)
> +       if (dma_buf->ops !=3D &amdgpu_dmabuf_ops && bo->prime_shared_coun=
t)
>                 bo->prime_shared_count--;
>         amdgpu_bo_unreserve(bo);
>
> --
> 2.14.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


Hi

This patch causes tearing / stuttering on my i915/amdgpu prime setup

Reverting this patch and some of  "[PATCH 3/3] drm/amdgpu: further mitigate
workaround for i915" to get it to compile, gets things working again

Sorry for not noticing this sooner

Let me know if you'd like me to test any follow up patches

Cheers

Mike

--001a114fd7c4c558140567de1048
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon=
, 19 Feb 2018 at 13:58 Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.l=
eichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig.leichtzumerken@gmail.<wb=
r>com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">To be able to use DRI_PRIME with amdgpu and i915 we add all our fences=
<br>
only as exclusive ones.<br>
<br>
Disable that behavior when sharing between amdgpu itself cause it<br>
hinders concurrent execution.<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_prime.c | 31 +++++++++++++++++=
+++----------<wbr>-<br>
=C2=A01 file changed, 20 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_prime.c b/drivers/gpu/d=
rm/amd/amdgpu/<wbr>amdgpu_prime.c<br>
index f6d7f6404a07..8ce74a1d9966 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_prime.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_prime.c<br>
@@ -30,6 +30,8 @@<br>
=C2=A0#include &lt;drm/amdgpu_drm.h&gt;<br>
=C2=A0#include &lt;linux/dma-buf.h&gt;<br>
<br>
+static const struct dma_buf_ops amdgpu_dmabuf_ops;<br>
+<br>
=C2=A0struct sg_table *amdgpu_gem_prime_get_sg_<wbr>table(struct drm_gem_ob=
ject *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);=
<br>
@@ -129,20 +131,27 @@ static int amdgpu_gem_map_attach(struct dma_buf *dma_=
buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(r !=3D 0))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_detach;<=
br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Wait for all shared fences to complete befor=
e we switch to future<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * use of exclusive fence on this prime shared =
bo.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D reservation_object_wait_<wbr>timeout_rcu(=
bo-&gt;tbo.resv, true, false,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0MAX_SCHEDULE_TIMEOUT);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(r &lt; 0)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG_PRIME(&qu=
ot;Fence wait failed: %li\n&quot;, r);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreserv=
e;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dma_buf-&gt;ops !=3D &amp;amdgpu_dmabuf_ops=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Wait for all sha=
red fences to complete before we switch to future<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * use of exclusive=
 fence on this prime shared bo.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D reservation_o=
bject_wait_<wbr>timeout_rcu(bo-&gt;tbo.resv,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true, false,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAX_SCHEDULE_TIMEOUT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(r &lt;=
 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0DRM_DEBUG_PRIME(&quot;Fence wait failed: %li\n&quot;, r);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto error_unreserve;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* pin buffer into GTT */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT, =
NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (likely(r =3D=3D 0))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_unreserv=
e;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dma_buf-&gt;ops !=3D &amp;amdgpu_dmabuf_ops=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;prime_shared=
_count++;<br>
<br>
=C2=A0error_unreserve:<br>
@@ -166,7 +175,7 @@ static void amdgpu_gem_map_detach(struct dma_buf *dma_b=
uf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_unpin(bo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo-&gt;prime_shared_count)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dma_buf-&gt;ops !=3D &amp;amdgpu_dmabuf_ops=
 &amp;&amp; bo-&gt;prime_shared_count)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;prime_shared=
_count--;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_unreserve(bo);<br>
<br>
--<br>
2.14.1<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a></blockquote><div><br></div><div>Hi</div><div><br></div><d=
iv>This patch causes tearing / stuttering on my i915/amdgpu prime setup</di=
v><div><br></div><div>Reverting this patch and some of=C2=A0 &quot;[PATCH 3=
/3] drm/amdgpu: further mitigate workaround for i915&quot; to get it to com=
pile, gets things working again</div><div><br></div><div>Sorry for not noti=
cing this sooner</div><div><br></div><div>Let me know if you&#39;d like me =
to test any follow up patches</div><div><br></div><div>Cheers</div><div><br=
></div><div>Mike</div></div></div>

--001a114fd7c4c558140567de1048--

--===============1667887529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1667887529==--
