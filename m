From: Joe Barnett <thejoe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: user pages array memory leak fix
Date: Thu, 10 Oct 2019 08:37:05 -0700
Message-ID: <CAHpbJO_M4n1A++YsVGZnug3q9=9T=-53eUo4J23ky25vVh5A_w@mail.gmail.com>
References: <20191003194423.14468-1-Philip.Yang@amd.com>
 <e86d92cd-7bae-6704-00db-1a79ccbb1011@amd.com>
 <6640c636-79d1-6159-a1db-5f39f70096a1@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0104754874=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6640c636-79d1-6159-a1db-5f39f70096a1-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0104754874==
Content-Type: multipart/alternative; boundary="00000000000026f0490594902d67"

--00000000000026f0490594902d67
Content-Type: text/plain; charset="UTF-8"

Thanks for looking at this Christian.  Let me know if there's anything I
can do to help.

In the meantime, is there a workaround to avoid the memory leak other than
using a kernel from before the HMM change?

Thanks,
-Joe

On Fri, Oct 4, 2019 at 8:02 AM Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
wrote:

> Hi Philip,
>
> Am 04.10.19 um 15:40 schrieb Yang, Philip:
> > Thanks Joe for the test, I will add your Tested-by.
> >
> > Hi Christian,
> >
> > May you help review? The change removes the get user pages from
> > gem_userptr_ioctl, this was done if flags AMDGPU_GEM_USERPTR_VALIDATE is
> > set, and delay the get user pages to amdgpu_cs_parser_bos, and check if
> > user pages are invalidated when amdgpu_cs_submit. I don't find issue for
> > overnight test, but not sure if there is potential side effect.
>
> Yeah, seen that.
>
> The AMDGPU_GEM_USERPTR_VALIDATE was explicitly added to cause a
> validation during BO creation because of some very stupid applications.
>
> I didn't wanted to reject that without offering an alternative, but we
> seriously can't do this or it would break Vulkan/OpenGL.
>
> I need more time to take a closer look,
> Christian.
>
> >
> > Thanks,
> > Philip
> >
> > On 2019-10-03 3:44 p.m., Yang, Philip wrote:
> >> user_pages array should always be freed after validation regardless if
> >> user pages are changed after bo is created because with HMM change parse
> >> bo always allocate user pages array to get user pages for userptr bo.
> >>
> >> Don't need to get user pages while creating uerptr bo because user pages
> >> will only be used while validating after parsing userptr bo.
> >>
> >> Bugzilla: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1844962
> >>
> >> v2: remove unused local variable and amend commit
> >>
> >> Signed-off-by: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
> >> ---
> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  4 +---
> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 23 +----------------------
> >>    2 files changed, 2 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >> index 49b767b7238f..961186e7113e 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >> @@ -474,7 +474,6 @@ static int amdgpu_cs_list_validate(struct
> amdgpu_cs_parser *p,
> >>
> >>      list_for_each_entry(lobj, validated, tv.head) {
> >>              struct amdgpu_bo *bo = ttm_to_amdgpu_bo(lobj->tv.bo);
> >> -            bool binding_userptr = false;
> >>              struct mm_struct *usermm;
> >>
> >>              usermm = amdgpu_ttm_tt_get_usermm(bo->tbo.ttm);
> >> @@ -491,14 +490,13 @@ static int amdgpu_cs_list_validate(struct
> amdgpu_cs_parser *p,
> >>
> >>                      amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm,
> >>                                                   lobj->user_pages);
> >> -                    binding_userptr = true;
> >>              }
> >>
> >>              r = amdgpu_cs_validate(p, bo);
> >>              if (r)
> >>                      return r;
> >>
> >> -            if (binding_userptr) {
> >> +            if (lobj->user_pages) {
> >>                      kvfree(lobj->user_pages);
> >>                      lobj->user_pages = NULL;
> >>              }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> index a828e3d0bfbd..3ccd61d69964 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> @@ -283,7 +283,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev,
> void *data,
> >>    int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
> >>                           struct drm_file *filp)
> >>    {
> >> -    struct ttm_operation_ctx ctx = { true, false };
> >>      struct amdgpu_device *adev = dev->dev_private;
> >>      struct drm_amdgpu_gem_userptr *args = data;
> >>      struct drm_gem_object *gobj;
> >> @@ -326,32 +325,12 @@ int amdgpu_gem_userptr_ioctl(struct drm_device
> *dev, void *data,
> >>                      goto release_object;
> >>      }
> >>
> >> -    if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> >> -            r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
> >> -            if (r)
> >> -                    goto release_object;
> >> -
> >> -            r = amdgpu_bo_reserve(bo, true);
> >> -            if (r)
> >> -                    goto user_pages_done;
> >> -
> >> -            amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
> >> -            r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> >> -            amdgpu_bo_unreserve(bo);
> >> -            if (r)
> >> -                    goto user_pages_done;
> >> -    }
> >> -
> >>      r = drm_gem_handle_create(filp, gobj, &handle);
> >>      if (r)
> >> -            goto user_pages_done;
> >> +            goto release_object;
> >>
> >>      args->handle = handle;
> >>
> >> -user_pages_done:
> >> -    if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE)
> >> -            amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> >> -
> >>    release_object:
> >>      drm_gem_object_put_unlocked(gobj);
> >>
> >>
>
>

--00000000000026f0490594902d67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for looking at this Christian.=C2=A0 Let me kn=
ow if there&#39;s anything I can do to help.<br></div><div><br></div><div>I=
n the meantime, is there a workaround to avoid the memory leak other than u=
sing a kernel from before the HMM change?</div><div><br></div><div>Thanks,<=
/div><div>-Joe<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Oct 4, 2019 at 8:02 AM Koenig, Christian &l=
t;<a href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Ph=
ilip,<br>
<br>
Am 04.10.19 um 15:40 schrieb Yang, Philip:<br>
&gt; Thanks Joe for the test, I will add your Tested-by.<br>
&gt;<br>
&gt; Hi Christian,<br>
&gt;<br>
&gt; May you help review? The change removes the get user pages from<br>
&gt; gem_userptr_ioctl, this was done if flags AMDGPU_GEM_USERPTR_VALIDATE =
is<br>
&gt; set, and delay the get user pages to amdgpu_cs_parser_bos, and check i=
f<br>
&gt; user pages are invalidated when amdgpu_cs_submit. I don&#39;t find iss=
ue for<br>
&gt; overnight test, but not sure if there is potential side effect.<br>
<br>
Yeah, seen that.<br>
<br>
The AMDGPU_GEM_USERPTR_VALIDATE was explicitly added to cause a <br>
validation during BO creation because of some very stupid applications.<br>
<br>
I didn&#39;t wanted to reject that without offering an alternative, but we =
<br>
seriously can&#39;t do this or it would break Vulkan/OpenGL.<br>
<br>
I need more time to take a closer look,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Philip<br>
&gt;<br>
&gt; On 2019-10-03 3:44 p.m., Yang, Philip wrote:<br>
&gt;&gt; user_pages array should always be freed after validation regardles=
s if<br>
&gt;&gt; user pages are changed after bo is created because with HMM change=
 parse<br>
&gt;&gt; bo always allocate user pages array to get user pages for userptr =
bo.<br>
&gt;&gt;<br>
&gt;&gt; Don&#39;t need to get user pages while creating uerptr bo because =
user pages<br>
&gt;&gt; will only be used while validating after parsing userptr bo.<br>
&gt;&gt;<br>
&gt;&gt; Bugzilla: <a href=3D"https://bugs.launchpad.net/ubuntu/+source/lin=
ux/+bug/1844962" rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpa=
d.net/ubuntu/+source/linux/+bug/1844962</a><br>
&gt;&gt;<br>
&gt;&gt; v2: remove unused local variable and amend commit<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Philip Yang &lt;<a href=3D"mailto:Philip.Yang@amd.c=
om" target=3D"_blank">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 |=C2=A0 =
4 +---<br>
&gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 23 +-------=
---------------<br>
&gt;&gt;=C2=A0 =C2=A0 2 files changed, 2 insertions(+), 25 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_cs.c<br>
&gt;&gt; index 49b767b7238f..961186e7113e 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt;&gt; @@ -474,7 +474,6 @@ static int amdgpu_cs_list_validate(struct amdg=
pu_cs_parser *p,<br>
&gt;&gt;=C2=A0 =C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 list_for_each_entry(lobj, validated, tv.head) =
{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_bo *=
bo =3D ttm_to_amdgpu_bo(lobj-&gt;<a href=3D"http://tv.bo" rel=3D"noreferrer=
" target=3D"_blank">tv.bo</a>);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool binding_userptr =
=3D false;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mm_struct *=
usermm;<br>
&gt;&gt;=C2=A0 =C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usermm =3D amdgpu_=
ttm_tt_get_usermm(bo-&gt;tbo.ttm);<br>
&gt;&gt; @@ -491,14 +490,13 @@ static int amdgpu_cs_list_validate(struct am=
dgpu_cs_parser *p,<br>
&gt;&gt;=C2=A0 =C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 amdgpu_ttm_tt_set_user_pages(bo-&gt;tbo.ttm,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lobj-&gt;user_pages);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 binding_userptr =3D true;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 =C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_cs_va=
lidate(p, bo);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return r;<br>
&gt;&gt;=C2=A0 =C2=A0 <br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (binding_userptr) {<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lobj-&gt;user_pages=
) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvfree(lobj-&gt;user_pages);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 lobj-&gt;user_pages =3D NULL;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt; index a828e3d0bfbd..3ccd61d69964 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt; @@ -283,7 +283,6 @@ int amdgpu_gem_create_ioctl(struct drm_device =
*dev, void *data,<br>
&gt;&gt;=C2=A0 =C2=A0 int amdgpu_gem_userptr_ioctl(struct drm_device *dev, =
void *data,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file *filp)<br>
&gt;&gt;=C2=A0 =C2=A0 {<br>
&gt;&gt; -=C2=A0 =C2=A0 struct ttm_operation_ctx ctx =3D { true, false };<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D dev-&gt;dev_pri=
vate;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_gem_userptr *args =3D data;<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 struct drm_gem_object *gobj;<br>
&gt;&gt; @@ -326,32 +325,12 @@ int amdgpu_gem_userptr_ioctl(struct drm_devi=
ce *dev, void *data,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto release_object;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 =C2=A0 <br>
&gt;&gt; -=C2=A0 =C2=A0 if (args-&gt;flags &amp; AMDGPU_GEM_USERPTR_VALIDAT=
E) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_ttm_tt_get=
_user_pages(bo, bo-&gt;tbo.ttm-&gt;pages);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto release_object;<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_bo_reserve=
(bo, true);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto user_pages_done;<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_placement_fro=
m_domain(bo, AMDGPU_GEM_DOMAIN_GTT);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D ttm_bo_validate(&=
amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_unreserve(bo)=
;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto user_pages_done;<br>
&gt;&gt; -=C2=A0 =C2=A0 }<br>
&gt;&gt; -<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 r =3D drm_gem_handle_create(filp, gobj, &amp;h=
andle);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (r)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto user_pages_done;<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto release_object;<br=
>
&gt;&gt;=C2=A0 =C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 args-&gt;handle =3D handle;<br>
&gt;&gt;=C2=A0 =C2=A0 <br>
&gt;&gt; -user_pages_done:<br>
&gt;&gt; -=C2=A0 =C2=A0 if (args-&gt;flags &amp; AMDGPU_GEM_USERPTR_VALIDAT=
E)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ttm_tt_get_user_=
pages_done(bo-&gt;tbo.ttm);<br>
&gt;&gt; -<br>
&gt;&gt;=C2=A0 =C2=A0 release_object:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 drm_gem_object_put_unlocked(gobj);<br>
&gt;&gt;=C2=A0 =C2=A0 <br>
&gt;&gt;<br>
<br>
</blockquote></div>

--00000000000026f0490594902d67--

--===============0104754874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0104754874==--
