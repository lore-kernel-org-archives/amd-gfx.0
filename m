From: Richard Smith <richardsmith-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
Date: Thu, 13 Sep 2018 15:08:35 -0700
Message-ID: <CAGL0aWdF+8XTw=KV+QkNHSJhDrjxzcBUHPv8Ak5gkyMw2f0mQg@mail.gmail.com>
References: <20180912002559.1853-1-natechancellor@gmail.com>
 <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com>
 <CAGL0aWeYARfArmSJwXemE_QdGeRwnfE-CKh+DaRY8jwEF0SU5w@mail.gmail.com>
 <CAKwvOdkSy74TKqASdMtWwHKOeAVQn+mEfv0Fi8q+-35dGjXtHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0156240171=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKwvOdkSy74TKqASdMtWwHKOeAVQn+mEfv0Fi8q+-35dGjXtHA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: David1.Zhou-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org

--===============0156240171==
Content-Type: multipart/alternative; boundary="0000000000007849850575c7f315"

--0000000000007849850575c7f315
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 12, 2018 at 4:13 PM Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
wrote:

> On Wed, Sep 12, 2018 at 1:24 PM Richard Smith <richardsmith-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> wrote:
> >
> > On Wed, Sep 12, 2018 at 10:38 AM Nick Desaulniers <
> ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> >>
> >> On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor
> >> <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> >
> >> > Clang warns if there are missing braces around a subobject
> >> > initializer.
> >> >
> >> > drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
> >> > around initialization of subobject [-Wmissing-braces]
> >> >                 struct amdgpu_task_info task_info = { 0 };
> >> >                                                       ^
> >> >                                                       {}
> >> > 1 warning generated.
> >> >
> >> > drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
> >> > around initialization of subobject [-Wmissing-braces]
> >> >                 struct amdgpu_task_info task_info = { 0 };
> >> >                                                       ^
> >> >                                                       {}
> >> > 1 warning generated.
> >> >
> >> > Reported-by: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> >> > Signed-off-by: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> > ---
> >> >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
> >> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
> >> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >> > index 9333109b210d..968cc1b8cdff 100644
> >> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >> > @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct
> amdgpu_device *adev,
> >> >                 gmc_v8_0_set_fault_enable_default(adev, false);
> >> >
> >> >         if (printk_ratelimit()) {
> >> > -               struct amdgpu_task_info task_info = { 0 };
> >> > +               struct amdgpu_task_info task_info = { { 0 } };
> >>
> >> Hi Nathan,
> >> Thanks for this patch.  I discussed this syntax with our language
> >> lawyers.  Turns out, this is not quite correct, as you're now saying
> >> "initialize the first subobject to zero, but not the rest of the
> >> object."  -Wmissing-field-initializers would highlight this, but it's
> >> not part of -Wall.  It would be more correct to zero initialize the
> >> full struct, including all of its subobjects with `= {};`.
> >
> >
> > Sorry, I think I've caused some confusion here.
> >
> > Elements with an omitted initializer get implicitly zero-initialized. In
> C++, it's idiomatic to write `= {}` to perform aggregate
> zero-initialization, but in C, that's invalid because at least one
> initializer is syntactically required within the braces. As a result, `=
> {0}` is an idiomatic way to perform zero-initialization of an aggregate in
> C.
>
> That doesn't seem to be the case:
> https://godbolt.org/z/TZzfo6 shouldn't Clang warn in the case of bar()?
>

This is a GNU extension. Use -pedantic-errors to turn off extensions, then
Clang and GCC reject bar(): https://godbolt.org/z/pIzI6M


> > Clang intends to suppress the -Wmissing-braces in that case; if the
> warning is still being produced in a recent version of Clang, that's a bug.
> However, the warning suppression was added between Clang 5 and Clang 6, so
> it's very plausible that the compiler being used here is simply older than
> the warning fix.
> >
> > (Long story short: the change here seems fine, but should be unnecessary
> as of Clang 6.)
>
> The warning was identified from clang-8 ToT synced yesterday.
>

Thanks for the testcase. This is a Clang bug. Apparently the warning
suppression only works when the first member is of type 'int'!
https://godbolt.org/z/sxnZvv

--0000000000007849850575c7f315
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quot=
e"><div dir=3D"ltr">On Wed, Sep 12, 2018 at 4:13 PM Nick Desaulniers &lt;<a=
 href=3D"mailto:ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org">ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Sep=
 12, 2018 at 1:24 PM Richard Smith &lt;<a href=3D"mailto:richardsmith@googl=
e.com" target=3D"_blank">richardsmith-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, Sep 12, 2018 at 10:38 AM Nick Desaulniers &lt;<a href=3D"mailt=
o:ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" target=3D"_blank">ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt=
; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor<br>
&gt;&gt; &lt;<a href=3D"mailto:natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">=
natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Clang warns if there are missing braces around a subobject<br=
>
&gt;&gt; &gt; initializer.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: sugge=
st braces<br>
&gt;&gt; &gt; around initialization of subobject [-Wmissing-braces]<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
struct amdgpu_task_info task_info =3D { 0 };<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
&gt;&gt; &gt; 1 warning generated.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: sugges=
t braces<br>
&gt;&gt; &gt; around initialization of subobject [-Wmissing-braces]<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
struct amdgpu_task_info task_info =3D { 0 };<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
&gt;&gt; &gt; 1 warning generated.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Reported-by: Nick Desaulniers &lt;<a href=3D"mailto:ndesaulni=
ers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" target=3D"_blank">ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
&gt;&gt; &gt; Signed-off-by: Nathan Chancellor &lt;<a href=3D"mailto:natech=
ancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-<br>
&gt;&gt; &gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-<br>
&gt;&gt; &gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/=
gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt;&gt; &gt; index 9333109b210d..968cc1b8cdff 100644<br>
&gt;&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt;&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt;&gt; &gt; @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(s=
truct amdgpu_device *adev,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
gmc_v8_0_set_fault_enable_default(adev, false);<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (printk_ratelimit()) {<br=
>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t amdgpu_task_info task_info =3D { 0 };<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t amdgpu_task_info task_info =3D { { 0 } };<br>
&gt;&gt;<br>
&gt;&gt; Hi Nathan,<br>
&gt;&gt; Thanks for this patch.=C2=A0 I discussed this syntax with our lang=
uage<br>
&gt;&gt; lawyers.=C2=A0 Turns out, this is not quite correct, as you&#39;re=
 now saying<br>
&gt;&gt; &quot;initialize the first subobject to zero, but not the rest of =
the<br>
&gt;&gt; object.&quot;=C2=A0 -Wmissing-field-initializers would highlight t=
his, but it&#39;s<br>
&gt;&gt; not part of -Wall.=C2=A0 It would be more correct to zero initiali=
ze the<br>
&gt;&gt; full struct, including all of its subobjects with `=3D {};`.<br>
&gt;<br>
&gt;<br>
&gt; Sorry, I think I&#39;ve caused some confusion here.<br>
&gt;<br>
&gt; Elements with an omitted initializer get implicitly zero-initialized. =
In C++, it&#39;s idiomatic to write `=3D {}` to perform aggregate zero-init=
ialization, but in C, that&#39;s invalid because at least one initializer i=
s syntactically required within the braces. As a result, `=3D {0}` is an id=
iomatic way to perform zero-initialization of an aggregate in C.<br>
<br>
That doesn&#39;t seem to be the case:<br>
<a href=3D"https://godbolt.org/z/TZzfo6" rel=3D"noreferrer" target=3D"_blan=
k">https://godbolt.org/z/TZzfo6</a> shouldn&#39;t Clang warn in the case of=
 bar()?<br></blockquote><div><br></div><div>This is a GNU extension. Use -p=
edantic-errors to turn off extensions, then Clang and GCC reject bar(): <a =
href=3D"https://godbolt.org/z/pIzI6M">https://godbolt.org/z/pIzI6M</a></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Clang intends to suppress the -Wmissing-braces in that case; if the wa=
rning is still being produced in a recent version of Clang, that&#39;s a bu=
g. However, the warning suppression was added between Clang 5 and Clang 6, =
so it&#39;s very plausible that the compiler being used here is simply olde=
r than the warning fix.<br>
&gt;<br>
&gt; (Long story short: the change here seems fine, but should be unnecessa=
ry as of Clang 6.)<br>
<br>
The warning was identified from clang-8 ToT synced yesterday.<br></blockquo=
te><div><br></div><div>Thanks for the testcase. This is a Clang bug. Appare=
ntly the warning suppression only works when the first member is of type &#=
39;int&#39;! <a href=3D"https://godbolt.org/z/sxnZvv">https://godbolt.org/z=
/sxnZvv</a></div></div></div></div></div>

--0000000000007849850575c7f315--

--===============0156240171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0156240171==--
