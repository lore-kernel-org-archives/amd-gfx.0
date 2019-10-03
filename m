From: Joe Barnett <thejoe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: user pages array memory leak fix
Date: Thu, 3 Oct 2019 15:45:42 -0700
Message-ID: <CAHpbJO9_7iJ2Deay1CVq8qLdS6OmR8DOfbT+hVLDLLYnS49T0Q@mail.gmail.com>
References: <20191003190653.15455-1-Philip.Yang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0865380307=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191003190653.15455-1-Philip.Yang-5C7GfCeVMHo@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0865380307==
Content-Type: multipart/alternative; boundary="0000000000000e5e630594095965"

--0000000000000e5e630594095965
Content-Type: text/plain; charset="UTF-8"

I've tested applying v2 of this patch against a v5.3 tagged kernel and it
appears to fix the issue I reported.

Thanks,
-Joe

On Thu, Oct 3, 2019 at 12:07 PM Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org> wrote:

> user_pages array should be freed regardless if user pages are
> invalidated after bo is created because HMM change to always allocate
> user pages array to get user pages while parsing user page bo.
>
> Don't need to to get user pages while creating bo because user pages
> will only be used after parsing user page bo.
>
> Bugzilla: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1844962
>
> Signed-off-by: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 23 +----------------------
>  2 files changed, 2 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 49b767b7238f..e861de259def 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -498,7 +498,7 @@ static int amdgpu_cs_list_validate(struct
> amdgpu_cs_parser *p,
>                 if (r)
>                         return r;
>
> -               if (binding_userptr) {
> +               if (lobj->user_pages) {
>                         kvfree(lobj->user_pages);
>                         lobj->user_pages = NULL;
>                 }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index a828e3d0bfbd..3ccd61d69964 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -283,7 +283,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev,
> void *data,
>  int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>                              struct drm_file *filp)
>  {
> -       struct ttm_operation_ctx ctx = { true, false };
>         struct amdgpu_device *adev = dev->dev_private;
>         struct drm_amdgpu_gem_userptr *args = data;
>         struct drm_gem_object *gobj;
> @@ -326,32 +325,12 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev,
> void *data,
>                         goto release_object;
>         }
>
> -       if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> -               r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
> -               if (r)
> -                       goto release_object;
> -
> -               r = amdgpu_bo_reserve(bo, true);
> -               if (r)
> -                       goto user_pages_done;
> -
> -               amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
> -               r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -               amdgpu_bo_unreserve(bo);
> -               if (r)
> -                       goto user_pages_done;
> -       }
> -
>         r = drm_gem_handle_create(filp, gobj, &handle);
>         if (r)
> -               goto user_pages_done;
> +               goto release_object;
>
>         args->handle = handle;
>
> -user_pages_done:
> -       if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE)
> -               amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> -
>  release_object:
>         drm_gem_object_put_unlocked(gobj);
>
> --
> 2.17.1
>
>

--0000000000000e5e630594095965
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;ve tested applying v2 of this patch against a v=
5.3 tagged kernel and it appears to fix the issue I reported.</div><div><br=
></div><div>Thanks,</div><div>-Joe<br></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 3, 2019 at 12:07 PM=
 Yang, Philip &lt;<a href=3D"mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">Philip.Yang-urvtwAKJhsc@public.gmane.org=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>user_pages array should be freed regardless if user pages are<br>
invalidated after bo is created because HMM change to always allocate<br>
user pages array to get user pages while parsing user page bo.<br>
<br>
Don&#39;t need to to get user pages while creating bo because user pages<br=
>
will only be used after parsing user page bo.<br>
<br>
Bugzilla: <a href=3D"https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1=
844962" rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/ubu=
ntu/+source/linux/+bug/1844962</a><br>
<br>
Signed-off-by: Philip Yang &lt;<a href=3D"mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org" targe=
t=3D"_blank">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 |=C2=A0 2 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 23 +----------------------<=
br>
=C2=A02 files changed, 2 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c<br>
index 49b767b7238f..e861de259def 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
@@ -498,7 +498,7 @@ static int amdgpu_cs_list_validate(struct amdgpu_cs_par=
ser *p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return r;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (binding_userptr=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (lobj-&gt;user_p=
ages) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvfree(lobj-&gt;user_pages);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 lobj-&gt;user_pages =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c<br>
index a828e3d0bfbd..3ccd61d69964 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
@@ -283,7 +283,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, voi=
d *data,<br>
=C2=A0int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file *filp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ttm_operation_ctx ctx =3D { true, false =
};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D dev-&gt;dev_priv=
ate;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_gem_userptr *args =3D data;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_gem_object *gobj;<br>
@@ -326,32 +325,12 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, =
void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto release_object;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags &amp; AMDGPU_GEM_USERPTR_VAL=
IDATE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ttm_tt=
_get_user_pages(bo, bo-&gt;tbo.ttm-&gt;pages);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto release_object;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_res=
erve(bo, true);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto user_pages_done;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_placement=
_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D ttm_bo_valida=
te(&amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_unreserve=
(bo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto user_pages_done;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D drm_gem_handle_create(filp, gobj, &amp;ha=
ndle);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto user_pages_don=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto release_object=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 args-&gt;handle =3D handle;<br>
<br>
-user_pages_done:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args-&gt;flags &amp; AMDGPU_GEM_USERPTR_VAL=
IDATE)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ttm_tt_get_u=
ser_pages_done(bo-&gt;tbo.ttm);<br>
-<br>
=C2=A0release_object:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_gem_object_put_unlocked(gobj);<br>
<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div>

--0000000000000e5e630594095965--

--===============0865380307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0865380307==--
