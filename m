From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add flag for high priority contexts
Date: Tue, 3 Jan 2017 18:00:51 -0500
Message-ID: <CAFQ_0eG9k3b=FLxa0kwF1-56dbMBub-cDst1p4_F9KBbayuS=g@mail.gmail.com>
References: <1483484076-10424-1-git-send-email-andresx7@gmail.com>
 <1483484076-10424-2-git-send-email-andresx7@gmail.com>
 <CADnq5_Mt_-61h6DG77kqepp5psS2JGHJOA-mek513s5HgvtTDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0352489691=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Mt_-61h6DG77kqepp5psS2JGHJOA-mek513s5HgvtTDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0352489691==
Content-Type: multipart/alternative; boundary=94eb2c058c72c36bdd054538a333

--94eb2c058c72c36bdd054538a333
Content-Type: text/plain; charset=UTF-8

I was thinking of that originally, but the allocation context already has a
flags variable which allows us to preserve the IOCTL ABI.

We could reserve a few bits of the flags for a priority level instead if
that sounds good?

Regards,
Andres

On Tue, Jan 3, 2017 at 5:59 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Tue, Jan 3, 2017 at 5:54 PM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Add a new context creation flag, AMDGPU_CTX_FLAG_HIGHPRIORITY. This flag
> > results in the allocated context receiving a higher scheduler priority
> > that other contexts system-wide.
> >
> > Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       | 24
> ++++++++++++++++++------
> >  drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |  1 +
> >  include/uapi/drm/amdgpu_drm.h                 |  3 ++-
> >  3 files changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > index 400c66b..ce470e2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -25,11 +25,17 @@
> >  #include <drm/drmP.h>
> >  #include "amdgpu.h"
> >
> > -static int amdgpu_ctx_init(struct amdgpu_device *adev, struct
> amdgpu_ctx *ctx)
> > +static int amdgpu_ctx_init(struct amdgpu_device *adev, int priority,
> struct amdgpu_ctx *ctx)
> >  {
> >         unsigned i, j;
> >         int r;
> >
> > +       if (priority < 0 || priority >= AMD_SCHED_MAX_PRIORITY)
> > +               return -EINVAL;
> > +
> > +       if (priority == AMD_SCHED_PRIORITY_HIGH &&
> !capable(CAP_SYS_ADMIN))
> > +               return -EACCES;
> > +
> >         memset(ctx, 0, sizeof(*ctx));
> >         ctx->adev = adev;
> >         kref_init(&ctx->refcount);
> > @@ -51,7 +57,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
> struct amdgpu_ctx *ctx)
> >                 struct amdgpu_ring *ring = adev->rings[i];
> >                 struct amd_sched_rq *rq;
> >
> > -               rq = &ring->sched.sched_rq[AMD_SCHED_PRIORITY_NORMAL];
> > +               rq = &ring->sched.sched_rq[priority];
> >                 r = amd_sched_entity_init(&ring->sched,
> &ctx->rings[i].entity,
> >                                           rq, amdgpu_sched_jobs);
> >                 if (r)
> > @@ -90,11 +96,15 @@ static void amdgpu_ctx_fini(struct amdgpu_ctx *ctx)
> >
> >  static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
> >                             struct amdgpu_fpriv *fpriv,
> > +                           int flags,
> >                             uint32_t *id)
> >  {
> >         struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
> >         struct amdgpu_ctx *ctx;
> > -       int r;
> > +       int r, priority;
> > +
> > +       priority = flags & AMDGPU_CTX_FLAG_HIGHPRIORITY ?
> > +               AMD_SCHED_PRIORITY_HIGH : AMD_SCHED_PRIORITY_NORMAL;
> >
> >         ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> >         if (!ctx)
> > @@ -107,8 +117,9 @@ static int amdgpu_ctx_alloc(struct amdgpu_device
> *adev,
> >                 kfree(ctx);
> >                 return r;
> >         }
> > +
> >         *id = (uint32_t)r;
> > -       r = amdgpu_ctx_init(adev, ctx);
> > +       r = amdgpu_ctx_init(adev, priority, ctx);
> >         if (r) {
> >                 idr_remove(&mgr->ctx_handles, *id);
> >                 *id = 0;
> > @@ -186,7 +197,7 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void
> *data,
> >                      struct drm_file *filp)
> >  {
> >         int r;
> > -       uint32_t id;
> > +       uint32_t id, flags;
> >
> >         union drm_amdgpu_ctx *args = data;
> >         struct amdgpu_device *adev = dev->dev_private;
> > @@ -194,10 +205,11 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void
> *data,
> >
> >         r = 0;
> >         id = args->in.ctx_id;
> > +       flags = args->in.flags;
> >
> >         switch (args->in.op) {
> >         case AMDGPU_CTX_OP_ALLOC_CTX:
> > -               r = amdgpu_ctx_alloc(adev, fpriv, &id);
> > +               r = amdgpu_ctx_alloc(adev, fpriv, flags, &id);
> >                 args->out.alloc.ctx_id = id;
> >                 break;
> >         case AMDGPU_CTX_OP_FREE_CTX:
> > diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> > index d8dc681..2e458de 100644
> > --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> > +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> > @@ -108,6 +108,7 @@ struct amd_sched_backend_ops {
> >
> >  enum amd_sched_priority {
> >         AMD_SCHED_PRIORITY_KERNEL = 0,
> > +       AMD_SCHED_PRIORITY_HIGH,
> >         AMD_SCHED_PRIORITY_NORMAL,
> >         AMD_SCHED_MAX_PRIORITY
> >  };
> > diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> > index 3961836..702332e 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -160,10 +160,11 @@ union drm_amdgpu_bo_list {
> >  /* unknown cause */
> >  #define AMDGPU_CTX_UNKNOWN_RESET       3
> >
> > +#define AMDGPU_CTX_FLAG_HIGHPRIORITY   (1 << 0)
>
> Would it be better to expose a priority level rather than a single
> flag?  If we want to expose more than just normal/high in the future
> for example.
>
> Alex
>
> >  struct drm_amdgpu_ctx_in {
> >         /** AMDGPU_CTX_OP_* */
> >         __u32   op;
> > -       /** For future use, no flags defined so far */
> > +       /** AMDGPU_CTX_FLAG_* */
> >         __u32   flags;
> >         __u32   ctx_id;
> >         __u32   _pad;
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--94eb2c058c72c36bdd054538a333
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>I was thinking of that originally, but the =
allocation context already has a flags variable which allows us to preserve=
 the IOCTL ABI.<br><br></div>We could reserve a few bits of the flags for a=
 priority level instead if that sounds good?<br><br></div>Regards,<br></div=
>Andres<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jan 3, 2017 at 5:59 PM, Alex Deucher <span dir=3D"ltr">&lt;<a href=
=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb=
"><div class=3D"h5">On Tue, Jan 3, 2017 at 5:54 PM, Andres Rodriguez &lt;<a=
 href=3D"mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; Add a new context creation flag, AMDGPU_CTX_FLAG_HIGHPRIORITY. This fl=
ag<br>
&gt; results in the allocated context receiving a higher scheduler priority=
<br>
&gt; that other contexts system-wide.<br>
&gt;<br>
&gt; Signed-off-by: Andres Rodriguez &lt;<a href=3D"mailto:andresx7@gmail.c=
om">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ctx.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 24 ++++++++++++++++++------<br>
&gt;=C2=A0 drivers/gpu/drm/amd/scheduler/<wbr>gpu_scheduler.h |=C2=A0 1 +<b=
r>
&gt;=C2=A0 include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 3 files changed, 21 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ctx.c b/drivers/gp=
u/drm/amd/amdgpu/<wbr>amdgpu_ctx.c<br>
&gt; index 400c66b..ce470e2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ctx.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ctx.c<br>
&gt; @@ -25,11 +25,17 @@<br>
&gt;=C2=A0 #include &lt;drm/drmP.h&gt;<br>
&gt;=C2=A0 #include &quot;amdgpu.h&quot;<br>
&gt;<br>
&gt; -static int amdgpu_ctx_init(struct amdgpu_device *adev, struct amdgpu_=
ctx *ctx)<br>
&gt; +static int amdgpu_ctx_init(struct amdgpu_device *adev, int priority, =
struct amdgpu_ctx *ctx)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned i, j;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (priority &lt; 0 || priority &gt;=3D AM=
D_SCHED_MAX_PRIORITY)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (priority =3D=3D AMD_SCHED_PRIORITY_HIG=
H &amp;&amp; !capable(CAP_SYS_ADMIN))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EACCES=
;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(ctx, 0, sizeof(*ctx));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;adev =3D adev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kref_init(&amp;ctx-&gt;refcount);<br>
&gt; @@ -51,7 +57,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *ade=
v, struct amdgpu_ctx *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct am=
dgpu_ring *ring =3D adev-&gt;rings[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct am=
d_sched_rq *rq;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rq =3D &amp;ri=
ng-&gt;sched.sched_rq[AMD_<wbr>SCHED_PRIORITY_NORMAL];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rq =3D &amp;ri=
ng-&gt;sched.sched_rq[<wbr>priority];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amd=
_sched_entity_init(&amp;ring-&gt;<wbr>sched, &amp;ctx-&gt;rings[i].entity,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rq, amdgpu_sched_jobs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br=
>
&gt; @@ -90,11 +96,15 @@ static void amdgpu_ctx_fini(struct amdgpu_ctx *ctx=
)<br>
&gt;<br>
&gt;=C2=A0 static int amdgpu_ctx_alloc(struct amdgpu_device *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_fpriv *fpriv,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *id)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_ctx_mgr *mgr =3D &amp;f=
priv-&gt;ctx_mgr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_ctx *ctx;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int r, priority;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0priority =3D flags &amp; AMDGPU_CTX_FLAG_H=
IGHPRIORITY ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_SCHED_PRIO=
RITY_HIGH : AMD_SCHED_PRIORITY_NORMAL;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx =3D kmalloc(sizeof(*ctx), GFP_KER=
NEL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ctx)<br>
&gt; @@ -107,8 +117,9 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *=
adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(ctx=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*id =3D (uint32_t)r;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ctx_init(adev, ctx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ctx_init(adev, priority, ctx)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0idr_remov=
e(&amp;mgr-&gt;ctx_handles, *id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*id =3D 0=
;<br>
&gt; @@ -186,7 +197,7 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void =
*data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct drm_file *filp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t id, flags;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0union drm_amdgpu_ctx *args =3D data;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D dev-&g=
t;dev_private;<br>
&gt; @@ -194,10 +205,11 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, voi=
d *data,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id =3D args-&gt;in.ctx_id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0flags =3D args-&gt;in.flags;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (args-&gt;in.op) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_CTX_OP_ALLOC_CTX:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_c=
tx_alloc(adev, fpriv, &amp;id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_c=
tx_alloc(adev, fpriv, flags, &amp;id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args-&gt;=
out.alloc.ctx_id =3D id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_CTX_OP_FREE_CTX:<br>
&gt; diff --git a/drivers/gpu/drm/amd/<wbr>scheduler/gpu_scheduler.h b/driv=
ers/gpu/drm/amd/<wbr>scheduler/gpu_scheduler.h<br>
&gt; index d8dc681..2e458de 100644<br>
&gt; --- a/drivers/gpu/drm/amd/<wbr>scheduler/gpu_scheduler.h<br>
&gt; +++ b/drivers/gpu/drm/amd/<wbr>scheduler/gpu_scheduler.h<br>
&gt; @@ -108,6 +108,7 @@ struct amd_sched_backend_ops {<br>
&gt;<br>
&gt;=C2=A0 enum amd_sched_priority {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_SCHED_PRIORITY_KERNEL =3D 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_SCHED_PRIORITY_HIGH,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_SCHED_PRIORITY_NORMAL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_SCHED_MAX_PRIORITY<br>
&gt;=C2=A0 };<br>
&gt; diff --git a/include/uapi/drm/amdgpu_drm.<wbr>h b/include/uapi/drm/amd=
gpu_drm.<wbr>h<br>
&gt; index 3961836..702332e 100644<br>
&gt; --- a/include/uapi/drm/amdgpu_drm.<wbr>h<br>
&gt; +++ b/include/uapi/drm/amdgpu_drm.<wbr>h<br>
&gt; @@ -160,10 +160,11 @@ union drm_amdgpu_bo_list {<br>
&gt;=C2=A0 /* unknown cause */<br>
&gt;=C2=A0 #define AMDGPU_CTX_UNKNOWN_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
&gt;<br>
&gt; +#define AMDGPU_CTX_FLAG_HIGHPRIORITY=C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
<br>
</div></div>Would it be better to expose a priority level rather than a sin=
gle<br>
flag?=C2=A0 If we want to expose more than just normal/high in the future<b=
r>
for example.<br>
<br>
Alex<br>
<span class=3D""><br>
&gt;=C2=A0 struct drm_amdgpu_ctx_in {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** AMDGPU_CTX_OP_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0op;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/** For future use, no flags defined so fa=
r */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/** AMDGPU_CTX_FLAG_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0ctx_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0_pad;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
</span>&gt; ______________________________<wbr>_________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailma=
n/listinfo/amd-gfx</a><br>
</blockquote></div><br></div>

--94eb2c058c72c36bdd054538a333--

--===============0352489691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0352489691==--
