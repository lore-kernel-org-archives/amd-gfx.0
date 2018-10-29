From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: prevent an integer wraparound of
 cpu_map_count
Date: Mon, 29 Oct 2018 17:15:07 -0400
Message-ID: <CAAxE2A50X-XGvyx7GcZnnAC4p-bRnXrQpjQZ1D-8pD5ir3QdMQ@mail.gmail.com>
References: <20181023190733.15251-1-maraeo@gmail.com>
 <7690cf4c-5eff-85e4-885c-2ecc9dc01c25@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0153797082=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7690cf4c-5eff-85e4-885c-2ecc9dc01c25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0153797082==
Content-Type: multipart/alternative; boundary="0000000000006c0eb7057964928e"

--0000000000006c0eb7057964928e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You and I discussed this extensively internally a while ago. It's expected
and correct behavior. Mesa doesn't unmap some buffers and never will.

Marek

On Wed, Oct 24, 2018 at 3:45 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> That looks really ugly to me. Mapping the same BO so often is illegal
> and should be handled as error.
>
> Otherwise we will never be able to cleanly recover from a GPU lockup
> with lost state by reloading the client library.
>
> Christian.
>
> Am 23.10.18 um 21:07 schrieb Marek Ol=C5=A1=C3=A1k:
> > From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
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
> > +
> >               *cpu =3D bo->cpu_ptr;
> >               pthread_mutex_unlock(&bo->cpu_access_mutex);
> >               return 0;
> >       }
> >
> >       assert(bo->cpu_map_count =3D=3D 0);
> >
> >       memset(&args, 0, sizeof(args));
> >
> >       /* Query the buffer address (args.addr_ptr).
> > @@ -492,21 +501,27 @@ drm_public int
> amdgpu_bo_cpu_unmap(amdgpu_bo_handle bo)
> >
> >       pthread_mutex_lock(&bo->cpu_access_mutex);
> >       assert(bo->cpu_map_count >=3D 0);
> >
> >       if (bo->cpu_map_count =3D=3D 0) {
> >               /* not mapped */
> >               pthread_mutex_unlock(&bo->cpu_access_mutex);
> >               return -EINVAL;
> >       }
> >
> > -     bo->cpu_map_count--;
> > +     /* If the counter has already reached INT_MAX, don't decrement it=
.
> > +      * This is because amdgpu_bo_cpu_map doesn't increment it past
> > +      * INT_MAX.
> > +      */
> > +     if (bo->cpu_map_count !=3D INT_MAX)
> > +             bo->cpu_map_count--;
> > +
> >       if (bo->cpu_map_count > 0) {
> >               /* mapped multiple times */
> >               pthread_mutex_unlock(&bo->cpu_access_mutex);
> >               return 0;
> >       }
> >
> >       r =3D drm_munmap(bo->cpu_ptr, bo->alloc_size) =3D=3D 0 ? 0 : -err=
no;
> >       bo->cpu_ptr =3D NULL;
> >       pthread_mutex_unlock(&bo->cpu_access_mutex);
> >       return r;
>
>

--0000000000006c0eb7057964928e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>You and I discussed this e=
xtensively internally a while ago. It&#39;s expected and correct behavior. =
Mesa doesn&#39;t unmap some buffers and never will.</div><div><br></div><di=
v>Marek<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">On Wed, Oct 24=
, 2018 at 3:45 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leicht=
zumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">That looks really ugly t=
o me. Mapping the same BO so often is illegal <br>
and should be handled as error.<br>
<br>
Otherwise we will never be able to cleanly recover from a GPU lockup <br>
with lost state by reloading the client library.<br>
<br>
Christian.<br>
<br>
Am 23.10.18 um 21:07 schrieb Marek Ol=C5=A1=C3=A1k:<br>
&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
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
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*cpu =3D bo-&gt;=
cpu_ptr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_un=
lock(&amp;bo-&gt;cpu_access_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0assert(bo-&gt;cpu_map_count =3D=3D 0);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;args, 0, sizeof(args));<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Query the buffer address (args.addr_ptr).=
<br>
&gt; @@ -492,21 +501,27 @@ drm_public int amdgpu_bo_cpu_unmap(amdgpu_bo_han=
dle bo)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_lock(&amp;bo-&gt;cpu_access_mu=
tex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0assert(bo-&gt;cpu_map_count &gt;=3D 0);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo-&gt;cpu_map_count =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* not mapped */=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_un=
lock(&amp;bo-&gt;cpu_access_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0bo-&gt;cpu_map_count--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* If the counter has already reached INT_MAX, do=
n&#39;t decrement it.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * This is because amdgpu_bo_cpu_map doesn&#39;t =
increment it past<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * INT_MAX.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (bo-&gt;cpu_map_count !=3D INT_MAX)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo-&gt;cpu_map_count-=
-;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo-&gt;cpu_map_count &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* mapped multip=
le times */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_un=
lock(&amp;bo-&gt;cpu_access_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D drm_munmap(bo-&gt;cpu_ptr, bo-&gt;allo=
c_size) =3D=3D 0 ? 0 : -errno;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bo-&gt;cpu_ptr =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pthread_mutex_unlock(&amp;bo-&gt;cpu_access_=
mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
<br>
</blockquote></div></div>

--0000000000006c0eb7057964928e--

--===============0153797082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0153797082==--
