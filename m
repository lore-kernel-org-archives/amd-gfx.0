From: Richard Smith <richardsmith-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
Date: Wed, 12 Sep 2018 13:24:34 -0700
Message-ID: <CAGL0aWeYARfArmSJwXemE_QdGeRwnfE-CKh+DaRY8jwEF0SU5w@mail.gmail.com>
References: <20180912002559.1853-1-natechancellor@gmail.com>
 <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1424637900=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: David1.Zhou-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

--===============1424637900==
Content-Type: multipart/alternative; boundary="0000000000009b4d3c0575b261d6"

--0000000000009b4d3c0575b261d6
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 12, 2018 at 10:38 AM Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
wrote:

> On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor
> <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Clang warns if there are missing braces around a subobject
> > initializer.
> >
> > drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
> > around initialization of subobject [-Wmissing-braces]
> >                 struct amdgpu_task_info task_info = { 0 };
> >                                                       ^
> >                                                       {}
> > 1 warning generated.
> >
> > drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
> > around initialization of subobject [-Wmissing-braces]
> >                 struct amdgpu_task_info task_info = { 0 };
> >                                                       ^
> >                                                       {}
> > 1 warning generated.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > index 9333109b210d..968cc1b8cdff 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct
> amdgpu_device *adev,
> >                 gmc_v8_0_set_fault_enable_default(adev, false);
> >
> >         if (printk_ratelimit()) {
> > -               struct amdgpu_task_info task_info = { 0 };
> > +               struct amdgpu_task_info task_info = { { 0 } };
>
> Hi Nathan,
> Thanks for this patch.  I discussed this syntax with our language
> lawyers.  Turns out, this is not quite correct, as you're now saying
> "initialize the first subobject to zero, but not the rest of the
> object."  -Wmissing-field-initializers would highlight this, but it's
> not part of -Wall.  It would be more correct to zero initialize the
> full struct, including all of its subobjects with `= {};`.
>

Sorry, I think I've caused some confusion here.

Elements with an omitted initializer get implicitly zero-initialized. In
C++, it's idiomatic to write `= {}` to perform aggregate
zero-initialization, but in C, that's invalid because at least one
initializer is syntactically required within the braces. As a result, `=
{0}` is an idiomatic way to perform zero-initialization of an aggregate in
C. Clang intends to suppress the -Wmissing-braces in that case; if the
warning is still being produced in a recent version of Clang, that's a bug.
However, the warning suppression was added between Clang 5 and Clang 6, so
it's very plausible that the compiler being used here is simply older than
the warning fix.

(Long story short: the change here seems fine, but should be unnecessary as
of Clang 6.)


> >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > index 72f8018fa2a8..a781a5027212 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct
> amdgpu_device *adev,
> >         }
> >
> >         if (printk_ratelimit()) {
> > -               struct amdgpu_task_info task_info = { 0 };
> > +               struct amdgpu_task_info task_info = { { 0 } };
> >
> >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> >
> > --
> > 2.18.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
>

--0000000000009b4d3c0575b261d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Sep 12=
, 2018 at 10:38 AM Nick Desaulniers &lt;<a href=3D"mailto:ndesaulniers@goog=
le.com">ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor<br>
&lt;<a href=3D"mailto:natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">natechanc=
ellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Clang warns if there are missing braces around a subobject<br>
&gt; initializer.<br>
&gt;<br>
&gt; drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces=
<br>
&gt; around initialization of subobject [-Wmissing-braces]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct am=
dgpu_task_info task_info =3D { 0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
&gt; 1 warning generated.<br>
&gt;<br>
&gt; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces<=
br>
&gt; around initialization of subobject [-Wmissing-braces]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct am=
dgpu_task_info task_info =3D { 0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
&gt; 1 warning generated.<br>
&gt;<br>
&gt; Reported-by: Nick Desaulniers &lt;<a href=3D"mailto:ndesaulniers@googl=
e.com" target=3D"_blank">ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
&gt; Signed-off-by: Nathan Chancellor &lt;<a href=3D"mailto:natechancellor@=
gmail.com" target=3D"_blank">natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-<br>
&gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v8_0.c<br>
&gt; index 9333109b210d..968cc1b8cdff 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt; @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amd=
gpu_device *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gmc_v8_0_=
set_fault_enable_default(adev, false);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (printk_ratelimit()) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_=
task_info task_info =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_=
task_info task_info =3D { { 0 } };<br>
<br>
Hi Nathan,<br>
Thanks for this patch.=C2=A0 I discussed this syntax with our language<br>
lawyers.=C2=A0 Turns out, this is not quite correct, as you&#39;re now sayi=
ng<br>
&quot;initialize the first subobject to zero, but not the rest of the<br>
object.&quot;=C2=A0 -Wmissing-field-initializers would highlight this, but =
it&#39;s<br>
not part of -Wall.=C2=A0 It would be more correct to zero initialize the<br=
>
full struct, including all of its subobjects with `=3D {};`.<br></blockquot=
e><div><br></div><div>Sorry, I think I&#39;ve caused some confusion here.</=
div><div><br></div><div>Elements with an omitted initializer get implicitly=
 zero-initialized. In C++, it&#39;s idiomatic to write `=3D {}` to perform =
aggregate zero-initialization, but in C, that&#39;s invalid because at leas=
t one initializer is syntactically required within the braces. As a result,=
 `=3D {0}` is an idiomatic way to perform zero-initialization of an aggrega=
te in C. Clang intends to suppress the -Wmissing-braces in that case; if th=
e warning is still being produced in a recent version of Clang, that&#39;s =
a bug. However, the warning suppression was added between Clang 5 and Clang=
 6, so it&#39;s very plausible that the compiler being used here is simply =
older than the warning fix.<br></div><div><br></div><div>(Long story short:=
 the change here seems fine, but should be unnecessary as of Clang 6.)</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_vm=
_get_task_info(adev, entry-&gt;pasid, &amp;task_info);<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index 72f8018fa2a8..a781a5027212 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgp=
u_device *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (printk_ratelimit()) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_=
task_info task_info =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_=
task_info task_info =3D { { 0 } };<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_vm=
_get_task_info(adev, entry-&gt;pasid, &amp;task_info);<br>
&gt;<br>
&gt; --<br>
&gt; 2.18.0<br>
&gt;<br>
<br>
<br>
-- <br>
Thanks,<br>
~Nick Desaulniers<br>
</blockquote></div></div>

--0000000000009b4d3c0575b261d6--

--===============1424637900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1424637900==--
