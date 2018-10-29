From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: prevent an integer wraparound of
 cpu_map_count
Date: Mon, 29 Oct 2018 17:12:49 -0400
Message-ID: <CAAxE2A50faU_h4HAPkauLxt5mw9qfVnQRazwviSPhrTbmW4sCQ@mail.gmail.com>
References: <20181023190733.15251-1-maraeo@gmail.com>
 <63dd9ca5-dbfc-ad21-4a3b-6c1f48f03a03@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1258534421=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <63dd9ca5-dbfc-ad21-4a3b-6c1f48f03a03-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1258534421==
Content-Type: multipart/alternative; boundary="000000000000316f1f0579648a78"

--000000000000316f1f0579648a78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 10:38 PM Zhang, Jerry(Junwei) <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
wrote:

> On 10/24/18 3:07 AM, Marek Ol=C5=A1=C3=A1k wrote:
> > From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>
> We need commit log and sign-off here.
>
> BTW, have you encounter any issue about that?
>

I don't know what you mean. I'm pretty sure that a sign-off is not needed
for libdrm.


>
> >
> > ---
> >   amdgpu/amdgpu_bo.c | 19 +++++++++++++++++--
> >   1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c
> > index c0f42e81..81f8a5f7 100644
> > --- a/amdgpu/amdgpu_bo.c
> > +++ b/amdgpu/amdgpu_bo.c
> > @@ -22,20 +22,21 @@
> >    *
> >    */
> >
> >   #include <stdlib.h>
> >   #include <stdio.h>
> >   #include <stdint.h>
> >   #include <string.h>
> >   #include <errno.h>
> >   #include <fcntl.h>
> >   #include <unistd.h>
> > +#include <limits.h>
> >   #include <sys/ioctl.h>
> >   #include <sys/mman.h>
> >   #include <sys/time.h>
> >
> >   #include "libdrm_macros.h"
> >   #include "xf86drm.h"
> >   #include "amdgpu_drm.h"
> >   #include "amdgpu_internal.h"
> >   #include "util_math.h"
> >
> > @@ -442,21 +443,29 @@ drm_public int amdgpu_bo_cpu_map(amdgpu_bo_handle
> bo, void **cpu)
> >   {
> >       union drm_amdgpu_gem_mmap args;
> >       void *ptr;
> >       int r;
> >
> >       pthread_mutex_lock(&bo->cpu_access_mutex);
> >
> >       if (bo->cpu_ptr) {
> >               /* already mapped */
> >               assert(bo->cpu_map_count > 0);
> > -             bo->cpu_map_count++;
> > +
> > +             /* If the counter has already reached INT_MAX, don't
> increment
> > +              * it and assume that the buffer will be mapped
> indefinitely.
> > +              * The buffer is pretty unlikely to get unmapped by the
> user
> > +              * at this point.
> > +              */
> > +             if (bo->cpu_map_count !=3D INT_MAX)
> > +                     bo->cpu_map_count++;
>
> If so, shall we print some error here to notice that indefinite mappings
> come up.
>

No error. This is expected usage.

Marek

--000000000000316f1f0579648a78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, Oct 23=
, 2018 at 10:38 PM Zhang, Jerry(Junwei) &lt;<a href=3D"mailto:Jerry.Zhang@a=
md.com">Jerry.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">On 10/24/18 3:07 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
We need commit log and sign-off here.<br>
<br>
BTW, have you encounter any issue about that?<br></blockquote><div><br></di=
v><div>I don&#39;t know what you mean. I&#39;m pretty sure that a sign-off =
is not needed for libdrm.</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0amdgpu/amdgpu_bo.c | 19 +++++++++++++++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 17 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c<br>
&gt; index c0f42e81..81f8a5f7 100644<br>
&gt; --- a/amdgpu/amdgpu_bo.c<br>
&gt; +++ b/amdgpu/amdgpu_bo.c<br>
&gt; @@ -22,20 +22,21 @@<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &lt;stdlib.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;stdio.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;stdint.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;string.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;errno.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;fcntl.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;unistd.h&gt;<br>
&gt; +#include &lt;limits.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;sys/ioctl.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;sys/mman.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;sys/time.h&gt;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;libdrm_macros.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;xf86drm.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;amdgpu_drm.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;amdgpu_internal.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;util_math.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -442,21 +443,29 @@ drm_public int amdgpu_bo_cpu_map(amdgpu_bo_handl=
e bo, void **cpu)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0union drm_amdgpu_gem_mmap args;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void *ptr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_lock(&amp;bo-&gt;cpu_access_mu=
tex);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo-&gt;cpu_ptr) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* already mappe=
d */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(bo-&gt;cp=
u_map_count &gt; 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo-&gt;cpu_map_count+=
+;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If the counter has=
 already reached INT_MAX, don&#39;t increment<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * it and assume that=
 the buffer will be mapped indefinitely.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The buffer is pret=
ty unlikely to get unmapped by the user<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * at this point.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo-&gt;cpu_map_co=
unt !=3D INT_MAX)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bo-&gt;cpu_map_count++;<br>
<br>
If so, shall we print some error here to notice that indefinite mappings <b=
r>
come up.<br></blockquote><div><br></div><div>No error. This is expected usa=
ge.</div><div><br></div><div>Marek</div></div></div>

--000000000000316f1f0579648a78--

--===============1258534421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1258534421==--
