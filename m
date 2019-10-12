From: Joe Barnett <thejoe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] drm/amdgpu: user pages array memory leak fix
Date: Sat, 12 Oct 2019 09:12:26 -0700
Message-ID: <CAHpbJO_rJ+WLoGLscJ7YkbEFFJ2VUj_aSTd4UUswi2Y1dKVS4w@mail.gmail.com>
References: <20191011143620.8785-1-Philip.Yang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1161036630=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191011143620.8785-1-Philip.Yang-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1161036630==
Content-Type: multipart/alternative; boundary="00000000000039a1ee0594b8e7cf"

--00000000000039a1ee0594b8e7cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Confirming that v3 patch still fixes the bug.

Thanks,
-Joe

On Fri, Oct 11, 2019 at 7:36 AM Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org> wrote:

> user_pages array should always be freed after validation regardless if
> user pages are changed after bo is created because with HMM change parse
> bo always allocate user pages array to get user pages for userptr bo.
>
> v2: remove unused local variable and amend commit
>
> v3: add back get user pages in gem_userptr_ioctl, to detect application
> bug where an userptr VMA is not ananymous memory and reject it.
>
> Bugzilla: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1844962
>
> Signed-off-by: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
> Tested-by: Joe Barnett <thejoe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index c18a153b3d2a..e7b39daa22f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -476,7 +476,6 @@ static int amdgpu_cs_list_validate(struct
> amdgpu_cs_parser *p,
>
>         list_for_each_entry(lobj, validated, tv.head) {
>                 struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(lobj->tv.bo);
> -               bool binding_userptr =3D false;
>                 struct mm_struct *usermm;
>
>                 usermm =3D amdgpu_ttm_tt_get_usermm(bo->tbo.ttm);
> @@ -493,14 +492,13 @@ static int amdgpu_cs_list_validate(struct
> amdgpu_cs_parser *p,
>
>                         amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm,
>                                                      lobj->user_pages);
> -                       binding_userptr =3D true;
>                 }
>
>                 r =3D amdgpu_cs_validate(p, bo);
>                 if (r)
>                         return r;
>
> -               if (binding_userptr) {
> +               if (lobj->user_pages) {
>                         kvfree(lobj->user_pages);
>                         lobj->user_pages =3D NULL;
>                 }
> --
> 2.17.1
>
>

--00000000000039a1ee0594b8e7cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Confirming that v3 patch still fixes the bug.</div><d=
iv><br></div><div>Thanks,</div><div>-Joe<br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 11, 2019 at 7=
:36 AM Yang, Philip &lt;<a href=3D"mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">Philip.Yang@=
amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">user_pages array should always be freed after validation regardless =
if<br>
user pages are changed after bo is created because with HMM change parse<br=
>
bo always allocate user pages array to get user pages for userptr bo.<br>
<br>
v2: remove unused local variable and amend commit<br>
<br>
v3: add back get user pages in gem_userptr_ioctl, to detect application<br>
bug where an userptr VMA is not ananymous memory and reject it.<br>
<br>
Bugzilla: <a href=3D"https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1=
844962" rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/ubu=
ntu/+source/linux/+bug/1844962</a><br>
<br>
Signed-off-by: Philip Yang &lt;<a href=3D"mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org" targe=
t=3D"_blank">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Tested-by: Joe Barnett &lt;<a href=3D"mailto:thejoe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_b=
lank">thejoe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 +---<br>
=C2=A01 file changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c<br>
index c18a153b3d2a..e7b39daa22f6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
@@ -476,7 +476,6 @@ static int amdgpu_cs_list_validate(struct amdgpu_cs_par=
ser *p,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(lobj, validated, tv.head) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_bo *b=
o =3D ttm_to_amdgpu_bo(lobj-&gt;<a href=3D"http://tv.bo" rel=3D"noreferrer"=
 target=3D"_blank">tv.bo</a>);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool binding_userpt=
r =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mm_struct *u=
sermm;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usermm =3D amdgpu_t=
tm_tt_get_usermm(bo-&gt;tbo.ttm);<br>
@@ -493,14 +492,13 @@ static int amdgpu_cs_list_validate(struct amdgpu_cs_p=
arser *p,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 amdgpu_ttm_tt_set_user_pages(bo-&gt;tbo.ttm,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lobj-&gt;user_pages);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0binding_userptr =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_cs_val=
idate(p, bo);<br>
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
-- <br>
2.17.1<br>
<br>
</blockquote></div>

--00000000000039a1ee0594b8e7cf--

--===============1161036630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1161036630==--
