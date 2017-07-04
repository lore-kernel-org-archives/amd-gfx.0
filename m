From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/12] drm: export drm_gem_prime_dmabuf_ops
Date: Tue, 4 Jul 2017 14:55:00 +1000
Message-ID: <CAPM=9tx4vhT564_LMK0r7u5W6apzYrg2Cvx+nSZLV5uZe-AYdw@mail.gmail.com>
References: <1499116294-12817-1-git-send-email-Felix.Kuehling@amd.com>
 <1499116294-12817-8-git-send-email-Felix.Kuehling@amd.com>
 <ec9f1be8-4d73-2ae2-094e-e8b50811dd22@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0698167839=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ec9f1be8-4d73-2ae2-094e-e8b50811dd22-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0698167839==
Content-Type: multipart/alternative; boundary="f403043eb9b89e6b22055376af52"

--f403043eb9b89e6b22055376af52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 4 Jul. 2017 11:23, "Michel D=C3=A4nzer" <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:


Adding the dri-devel list, since this is a core DRM patch.


On 04/07/17 06:11 AM, Felix Kuehling wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> This allows drivers to check if a DMA-buf contains a GEM object or not.


Please use an accessor function. I doubt it'll be a fast path.

Dave.

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/drm_prime.c | 3 ++-
>  include/drm/drmP.h          | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 25aa455..5cb4fd9 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -396,7 +396,7 @@ static int drm_gem_dmabuf_mmap(struct dma_buf
*dma_buf,
>       return dev->driver->gem_prime_mmap(obj, vma);
>  }
>
> -static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =3D  {
> +const struct dma_buf_ops drm_gem_prime_dmabuf_ops =3D  {
>       .attach =3D drm_gem_map_attach,
>       .detach =3D drm_gem_map_detach,
>       .map_dma_buf =3D drm_gem_map_dma_buf,
> @@ -410,6 +410,7 @@ static int drm_gem_dmabuf_mmap(struct dma_buf
*dma_buf,
>       .vmap =3D drm_gem_dmabuf_vmap,
>       .vunmap =3D drm_gem_dmabuf_vunmap,
>  };
> +EXPORT_SYMBOL(drm_gem_prime_dmabuf_ops);
>
>  /**
>   * DOC: PRIME Helpers
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index 6105c05..e0ea8f8 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -761,6 +761,8 @@ static inline int drm_debugfs_remove_files(const
struct drm_info_list *files,
>
>  struct dma_buf_export_info;
>
> +extern const struct dma_buf_ops drm_gem_prime_dmabuf_ops;
> +
>  extern struct dma_buf *drm_gem_prime_export(struct drm_device *dev,
>                                           struct drm_gem_object *obj,
>                                           int flags);
>


--
Earthling Michel D=C3=A4nzer               |               http://www.amd.c=
om
Libre software enthusiast             |             Mesa and X developer
_______________________________________________
dri-devel mailing list
dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/dri-devel

--f403043eb9b89e6b22055376af52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On 4 Jul. 2017 11:23, &quot;Michel D=C3=A4nzer&quot; &lt;<a href=
=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br type=3D=
"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><br>
Adding the dri-devel list, since this is a core DRM patch.<br>
<div class=3D"elided-text"><br>
<br>
On 04/07/17 06:11 AM, Felix Kuehling wrote:<br>
&gt; From: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.=
com">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; This allows drivers to check if a DMA-buf contains a GEM object or not=
.<br></div></blockquote></div></div></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Please use an accessor function. I doubt it&#39;ll be a fast p=
ath.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Dave.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div class=3D"elided-text">
&gt;<br>
&gt; Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.ko=
enig-5C7GfCeVMHo@public.gmane.org">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Reviewed-by: Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehling@amd.c=
om">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/drm_prime.c | 3 ++-<br>
&gt;=C2=A0 include/drm/drmP.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
&gt;=C2=A0 2 files changed, 4 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c=
<br>
&gt; index 25aa455..5cb4fd9 100644<br>
&gt; --- a/drivers/gpu/drm/drm_prime.c<br>
&gt; +++ b/drivers/gpu/drm/drm_prime.c<br>
&gt; @@ -396,7 +396,7 @@ static int drm_gem_dmabuf_mmap(struct dma_buf *dma=
_buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return dev-&gt;driver-&gt;gem_prime_mmap(<wb=
r>obj, vma);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =3D=C2=A0 {<=
br>
&gt; +const struct dma_buf_ops drm_gem_prime_dmabuf_ops =3D=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.attach =3D drm_gem_map_attach,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.detach =3D drm_gem_map_detach,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.map_dma_buf =3D drm_gem_map_dma_buf,<br>
&gt; @@ -410,6 +410,7 @@ static int drm_gem_dmabuf_mmap(struct dma_buf *dma=
_buf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.vmap =3D drm_gem_dmabuf_vmap,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.vunmap =3D drm_gem_dmabuf_vunmap,<br>
&gt;=C2=A0 };<br>
&gt; +EXPORT_SYMBOL(drm_gem_prime_<wbr>dmabuf_ops);<br>
&gt;<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* DOC: PRIME Helpers<br>
&gt; diff --git a/include/drm/drmP.h b/include/drm/drmP.h<br>
&gt; index 6105c05..e0ea8f8 100644<br>
&gt; --- a/include/drm/drmP.h<br>
&gt; +++ b/include/drm/drmP.h<br>
&gt; @@ -761,6 +761,8 @@ static inline int drm_debugfs_remove_files(const s=
truct drm_info_list *files,<br>
&gt;<br>
&gt;=C2=A0 struct dma_buf_export_info;<br>
&gt;<br>
&gt; +extern const struct dma_buf_ops drm_gem_prime_dmabuf_ops;<br>
&gt; +<br>
&gt;=C2=A0 extern struct dma_buf *drm_gem_prime_export(struct drm_device *d=
ev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct drm_gem_object *obj,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int flags);<br>
&gt;<br>
<br>
<br>
--<br>
</div>Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a hr=
ef=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.a=
md.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
______________________________<wbr>_________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.<wbr>org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/l=
istinfo/dri-devel</a><br>
</blockquote></div><br></div></div></div>

--f403043eb9b89e6b22055376af52--

--===============0698167839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0698167839==--
