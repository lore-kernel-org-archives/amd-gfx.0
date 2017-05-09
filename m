From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [PATCH 1/5] drm: introduce sync objects
Date: Tue, 9 May 2017 15:06:42 -0700
Message-ID: <CAOFGe957vC3xD+7r0SSuif6_G5HCbmjieCFRfwnAeropDxNRiw@mail.gmail.com>
References: <20170426032833.1455-1-airlied@gmail.com>
 <20170426032833.1455-2-airlied@gmail.com>
 <20170504081633.GC17961@nuc-i3427.alporthouse.com>
 <CAPM=9tzzn69_89nRpp3L3Y_qzd6AWg_aZ4PFF3twJg0gV0K8Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0563406154=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tzzn69_89nRpp3L3Y_qzd6AWg_aZ4PFF3twJg0gV0K8Fg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>

--===============0563406154==
Content-Type: multipart/alternative; boundary=001a11497cfe1eebe4054f1e9276

--001a11497cfe1eebe4054f1e9276
Content-Type: text/plain; charset=UTF-8

On Mon, May 8, 2017 at 7:26 PM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On 4 May 2017 at 18:16, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org> wrote:
> > On Wed, Apr 26, 2017 at 01:28:29PM +1000, Dave Airlie wrote:
> >> +#include <drm/drmP.h>
> >
> > I wonder if Daniel has already split everything used here into its own
> > headers?
>
> not sure, if drm_file is out there yet. I'll find out when I rebase
> this onto something newer I expect.
> >> +
> >> +static struct drm_syncobj *drm_syncobj_get(struct drm_file
> *file_private,
> >> +                                        u32 handle)
> >
> > I would like this exposed to the driver as well, so I can do handle to
> > syncobj conversion once. (drm_syncobj_find() if we go with kref_get style
> > naming.)
>
> Where do you expect to need two lookups? At least for the semaphore APIs,
> you have a list of wait and list of signals, the lists should be
> different, I've
> no objections to exporting this later, but it would be easier to just do
> that
> with the first user.
>
> >
> >> +static struct drm_syncobj *drm_syncobj_fdget(int fd)
> >
> > It will aslo be useful to export the fd -> syncobj function for drivers.
> In
> > the interface Jason has for execbuf, we can substitute the handle for an
> > fd + flag, which may be more convenient for the user.
>
> Happy once we have a use case for it, I'd rather we didn't expose the
> syncobj
> fd to userspace for anything but sending a syncobj between processes,
> avoiding
> using fd's is one of the main points of this, I'd hate for an API to
> demand we use
> fd's.
>

I'm not sure how useful Chris' use-case is here.  From a userspace
perspective, I don't want to burn any more FDs than I absolutely have to,
so I'll do the FD -> syncobj conversion on import and use the handle from
there on.  For sync_file, using the FD isn't a big deal as it's a one-shot
and we close it as soon as execbuf() is completed.  Permanently
exported/imported VkSemaphores, on the other hand, are re-usable long-lived
objects and the ioctl on import is a smal

--001a11497cfe1eebe4054f1e9276
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, May 8, 2017 at 7:26 PM, Dave Airlie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 4 May =
2017 at 18:16, Chris Wilson &lt;<a href=3D"mailto:chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org"=
>chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org</a>&gt; wrote:<br>
&gt; On Wed, Apr 26, 2017 at 01:28:29PM +1000, Dave Airlie wrote:<br>
&gt;&gt; +#include &lt;drm/drmP.h&gt;<br>
&gt;<br>
&gt; I wonder if Daniel has already split everything used here into its own=
<br>
&gt; headers?<br>
<br>
</span>not sure, if drm_file is out there yet. I&#39;ll find out when I reb=
ase<br>
this onto something newer I expect.<br>
<span class=3D"">&gt;&gt; +<br>
&gt;&gt; +static struct drm_syncobj *drm_syncobj_get(struct drm_file *file_=
private,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 u32 handle)<br>
&gt;<br>
&gt; I would like this exposed to the driver as well, so I can do handle to=
<br>
&gt; syncobj conversion once. (drm_syncobj_find() if we go with kref_get st=
yle<br>
&gt; naming.)<br>
<br>
</span>Where do you expect to need two lookups? At least for the semaphore =
APIs,<br>
you have a list of wait and list of signals, the lists should be different,=
 I&#39;ve<br>
no objections to exporting this later, but it would be easier to just do th=
at<br>
with the first user.<br>
<span class=3D""><br>
&gt;<br>
&gt;&gt; +static struct drm_syncobj *drm_syncobj_fdget(int fd)<br>
&gt;<br>
&gt; It will aslo be useful to export the fd -&gt; syncobj function for dri=
vers. In<br>
&gt; the interface Jason has for execbuf, we can substitute the handle for =
an<br>
&gt; fd + flag, which may be more convenient for the user.<br>
<br>
</span>Happy once we have a use case for it, I&#39;d rather we didn&#39;t e=
xpose the syncobj<br>
fd to userspace for anything but sending a syncobj between processes, avoid=
ing<br>
using fd&#39;s is one of the main points of this, I&#39;d hate for an API t=
o<br>
demand we use<br>
fd&#39;s.<span class=3D""><br></span></blockquote><div><br></div><div>I&#39=
;m not sure how useful Chris&#39; use-case is here.=C2=A0 From a userspace =
perspective, I don&#39;t want to burn any more FDs than I absolutely have t=
o, so I&#39;ll do the FD -&gt; syncobj conversion on import and use the han=
dle from there on.=C2=A0 For sync_file, using the FD isn&#39;t a big deal a=
s it&#39;s a one-shot and we close it as soon as execbuf() is completed.=C2=
=A0 Permanently exported/imported VkSemaphores, on the other hand, are re-u=
sable long-lived objects and the ioctl on import is a smal</div></div><br><=
/div></div>

--001a11497cfe1eebe4054f1e9276--

--===============0563406154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0563406154==--
