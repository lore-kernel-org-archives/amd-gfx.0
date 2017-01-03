From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add flag for high priority contexts
Date: Tue, 3 Jan 2017 18:09:55 -0500
Message-ID: <CAFQ_0eEJ8QQ4VKPOH-7smPZ0CBsuC=XTx_gnr_V_QoQR=7Kmjg@mail.gmail.com>
References: <1483484076-10424-1-git-send-email-andresx7@gmail.com>
 <1483484076-10424-2-git-send-email-andresx7@gmail.com>
 <CADnq5_Mt_-61h6DG77kqepp5psS2JGHJOA-mek513s5HgvtTDA@mail.gmail.com>
 <CAFQ_0eG9k3b=FLxa0kwF1-56dbMBub-cDst1p4_F9KBbayuS=g@mail.gmail.com>
 <CADnq5_Mu4t4i9prGhZakMdd3cFB5NRWE6zh0zFp05T1Z_WONmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0518386223=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Mu4t4i9prGhZakMdd3cFB5NRWE6zh0zFp05T1Z_WONmQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0518386223==
Content-Type: multipart/alternative; boundary=94eb2c058c723bbb61054538c468

--94eb2c058c723bbb61054538c468
Content-Type: text/plain; charset=UTF-8

Cool. Follow up question then:

We can either:
1. Expose a priority number
2. Expose a priority enum, e.g. PRIORITY_HIGH, PRIORITY_NORMAL (to start)

The HW can do numerical priorities, but the SW scheduler would require a
bit of rework to consume arbitrary priorities.

At least for our use case, I don't really see a need for super fine-grained
priorities. Something like HIGH/NORMAL is sufficient, with possibility of
expanding to add REALTIME/LOW. So I think going for an enum is
simpler/better.

yay or nay on enum?


On Tue, Jan 3, 2017 at 6:02 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Tue, Jan 3, 2017 at 6:00 PM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > I was thinking of that originally, but the allocation context already
> has a
> > flags variable which allows us to preserve the IOCTL ABI.
> >
> > We could reserve a few bits of the flags for a priority level instead if
> > that sounds good?
>
> We can also use _pad for something else.
>
> Alex
>
> >
> > Regards,
> > Andres
> >
> > On Tue, Jan 3, 2017 at 5:59 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >>
> >> On Tue, Jan 3, 2017 at 5:54 PM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> wrote:
> >> > Add a new context creation flag, AMDGPU_CTX_FLAG_HIGHPRIORITY. This
> flag
> >> > results in the allocated context receiving a higher scheduler priority
> >> > that other contexts system-wide.
> >> >
> >> > Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> > ---
> >> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       | 24
> >> > ++++++++++++++++++------
> >> >  drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |  1 +
> >> >  include/uapi/drm/amdgpu_drm.h                 |  3 ++-
> >> >  3 files changed, 21 insertions(+), 7 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >> > index 400c66b..ce470e2 100644
> >> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >> > @@ -25,11 +25,17 @@
> >> >  #include <drm/drmP.h>
> >> >  #include "amdgpu.h"
> >> >
> >> > -static int amdgpu_ctx_init(struct amdgpu_device *adev, struct
> >> > amdgpu_ctx *ctx)
> >> > +static int amdgpu_ctx_init(struct amdgpu_device *adev, int priority,
> >> > struct amdgpu_ctx *ctx)
> >> >  {
> >> >         unsigned i, j;
> >> >         int r;
> >> >
> >> > +       if (priority < 0 || priority >= AMD_SCHED_MAX_PRIORITY)
> >> > +               return -EINVAL;
> >> > +
> >> > +       if (priority == AMD_SCHED_PRIORITY_HIGH &&
> >> > !capable(CAP_SYS_ADMIN))
> >> > +               return -EACCES;
> >> > +
> >> >         memset(ctx, 0, sizeof(*ctx));
> >> >         ctx->adev = adev;
> >> >         kref_init(&ctx->refcount);
> >> > @@ -51,7 +57,7 @@ static int amdgpu_ctx_init(struct amdgpu_device
> *adev,
> >> > struct amdgpu_ctx *ctx)
> >> >                 struct amdgpu_ring *ring = adev->rings[i];
> >> >                 struct amd_sched_rq *rq;
> >> >
> >> > -               rq = &ring->sched.sched_rq[AMD_
> SCHED_PRIORITY_NORMAL];
> >> > +               rq = &ring->sched.sched_rq[priority];
> >> >                 r = amd_sched_entity_init(&ring->sched,
> >> > &ctx->rings[i].entity,
> >> >                                           rq, amdgpu_sched_jobs);
> >> >                 if (r)
> >> > @@ -90,11 +96,15 @@ static void amdgpu_ctx_fini(struct amdgpu_ctx
> *ctx)
> >> >
> >> >  static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
> >> >                             struct amdgpu_fpriv *fpriv,
> >> > +                           int flags,
> >> >                             uint32_t *id)
> >> >  {
> >> >         struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
> >> >         struct amdgpu_ctx *ctx;
> >> > -       int r;
> >> > +       int r, priority;
> >> > +
> >> > +       priority = flags & AMDGPU_CTX_FLAG_HIGHPRIORITY ?
> >> > +               AMD_SCHED_PRIORITY_HIGH : AMD_SCHED_PRIORITY_NORMAL;
> >> >
> >> >         ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> >> >         if (!ctx)
> >> > @@ -107,8 +117,9 @@ static int amdgpu_ctx_alloc(struct amdgpu_device
> >> > *adev,
> >> >                 kfree(ctx);
> >> >                 return r;
> >> >         }
> >> > +
> >> >         *id = (uint32_t)r;
> >> > -       r = amdgpu_ctx_init(adev, ctx);
> >> > +       r = amdgpu_ctx_init(adev, priority, ctx);
> >> >         if (r) {
> >> >                 idr_remove(&mgr->ctx_handles, *id);
> >> >                 *id = 0;
> >> > @@ -186,7 +197,7 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void
> >> > *data,
> >> >                      struct drm_file *filp)
> >> >  {
> >> >         int r;
> >> > -       uint32_t id;
> >> > +       uint32_t id, flags;
> >> >
> >> >         union drm_amdgpu_ctx *args = data;
> >> >         struct amdgpu_device *adev = dev->dev_private;
> >> > @@ -194,10 +205,11 @@ int amdgpu_ctx_ioctl(struct drm_device *dev,
> void
> >> > *data,
> >> >
> >> >         r = 0;
> >> >         id = args->in.ctx_id;
> >> > +       flags = args->in.flags;
> >> >
> >> >         switch (args->in.op) {
> >> >         case AMDGPU_CTX_OP_ALLOC_CTX:
> >> > -               r = amdgpu_ctx_alloc(adev, fpriv, &id);
> >> > +               r = amdgpu_ctx_alloc(adev, fpriv, flags, &id);
> >> >                 args->out.alloc.ctx_id = id;
> >> >                 break;
> >> >         case AMDGPU_CTX_OP_FREE_CTX:
> >> > diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> >> > b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> >> > index d8dc681..2e458de 100644
> >> > --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> >> > +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> >> > @@ -108,6 +108,7 @@ struct amd_sched_backend_ops {
> >> >
> >> >  enum amd_sched_priority {
> >> >         AMD_SCHED_PRIORITY_KERNEL = 0,
> >> > +       AMD_SCHED_PRIORITY_HIGH,
> >> >         AMD_SCHED_PRIORITY_NORMAL,
> >> >         AMD_SCHED_MAX_PRIORITY
> >> >  };
> >> > diff --git a/include/uapi/drm/amdgpu_drm.h
> >> > b/include/uapi/drm/amdgpu_drm.h
> >> > index 3961836..702332e 100644
> >> > --- a/include/uapi/drm/amdgpu_drm.h
> >> > +++ b/include/uapi/drm/amdgpu_drm.h
> >> > @@ -160,10 +160,11 @@ union drm_amdgpu_bo_list {
> >> >  /* unknown cause */
> >> >  #define AMDGPU_CTX_UNKNOWN_RESET       3
> >> >
> >> > +#define AMDGPU_CTX_FLAG_HIGHPRIORITY   (1 << 0)
> >>
> >> Would it be better to expose a priority level rather than a single
> >> flag?  If we want to expose more than just normal/high in the future
> >> for example.
> >>
> >> Alex
> >>
> >> >  struct drm_amdgpu_ctx_in {
> >> >         /** AMDGPU_CTX_OP_* */
> >> >         __u32   op;
> >> > -       /** For future use, no flags defined so far */
> >> > +       /** AMDGPU_CTX_FLAG_* */
> >> >         __u32   flags;
> >> >         __u32   ctx_id;
> >> >         __u32   _pad;
> >> > --
> >> > 2.7.4
> >> >
> >> > _______________________________________________
> >> > amd-gfx mailing list
> >> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
> >
>

--94eb2c058c723bbb61054538c468
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Cool. Follow up question then:<br><br></div><div>We c=
an either:<br></div><div>1. Expose a priority number<br></div><div>2. Expos=
e a priority enum, e.g. PRIORITY_HIGH, PRIORITY_NORMAL (to start)<br><br></=
div><div>The HW can do numerical priorities, but the SW scheduler would req=
uire a bit of rework to consume arbitrary priorities.<br><br></div><div>At =
least for our use case, I don&#39;t really see a need for super fine-graine=
d priorities. Something like HIGH/NORMAL is sufficient, with possibility of=
 expanding to add REALTIME/LOW. So I think going for an enum is simpler/bet=
ter.<br><br></div><div>yay or nay on enum?<br></div><div><br></div></div><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Jan 3, 2017=
 at 6:02 PM, Alex Deucher <span dir=3D"ltr">&lt;<a href=3D"mailto:alexdeuch=
er-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><span class=3D"">On Tue, Jan 3, 2017 at =
6:00 PM, Andres Rodriguez &lt;<a href=3D"mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">andresx=
7@gmail.com</a>&gt; wrote:<br>
&gt; I was thinking of that originally, but the allocation context already =
has a<br>
&gt; flags variable which allows us to preserve the IOCTL ABI.<br>
&gt;<br>
&gt; We could reserve a few bits of the flags for a priority level instead =
if<br>
&gt; that sounds good?<br>
<br>
</span>We can also use _pad for something else.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Alex<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; Regards,<br>
&gt; Andres<br>
&gt;<br>
&gt; On Tue, Jan 3, 2017 at 5:59 PM, Alex Deucher &lt;<a href=3D"mailto:ale=
xdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Jan 3, 2017 at 5:54 PM, Andres Rodriguez &lt;<a href=3D"ma=
ilto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt; Add a new context creation flag, AMDGPU_CTX_FLAG_HIGHPRIORITY=
. This flag<br>
&gt;&gt; &gt; results in the allocated context receiving a higher scheduler=
 priority<br>
&gt;&gt; &gt; that other contexts system-wide.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Andres Rodriguez &lt;<a href=3D"mailto:andresx=
7@gmail.com">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ctx.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 24<br>
&gt;&gt; &gt; ++++++++++++++++++------<br>
&gt;&gt; &gt;=C2=A0 drivers/gpu/drm/amd/scheduler/<wbr>gpu_scheduler.h |=C2=
=A0 1 +<br>
&gt;&gt; &gt;=C2=A0 include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;&gt; &gt;=C2=A0 3 files changed, 21 insertions(+), 7 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ctx.c<br>
&gt;&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ctx.c<br>
&gt;&gt; &gt; index 400c66b..ce470e2 100644<br>
&gt;&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ctx.c<br>
&gt;&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_ctx.c<br>
&gt;&gt; &gt; @@ -25,11 +25,17 @@<br>
&gt;&gt; &gt;=C2=A0 #include &lt;drm/drmP.h&gt;<br>
&gt;&gt; &gt;=C2=A0 #include &quot;amdgpu.h&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -static int amdgpu_ctx_init(struct amdgpu_device *adev, struc=
t<br>
&gt;&gt; &gt; amdgpu_ctx *ctx)<br>
&gt;&gt; &gt; +static int amdgpu_ctx_init(struct amdgpu_device *adev, int p=
riority,<br>
&gt;&gt; &gt; struct amdgpu_ctx *ctx)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned i, j;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (priority &lt; 0 || priority &=
gt;=3D AMD_SCHED_MAX_PRIORITY)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -EINVAL;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (priority =3D=3D AMD_SCHED_PRI=
ORITY_HIGH &amp;&amp;<br>
&gt;&gt; &gt; !capable(CAP_SYS_ADMIN))<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -EACCES;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(ctx, 0, sizeof(*ctx))=
;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;adev =3D adev;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kref_init(&amp;ctx-&gt;refco=
unt);<br>
&gt;&gt; &gt; @@ -51,7 +57,7 @@ static int amdgpu_ctx_init(struct amdgpu_de=
vice *adev,<br>
&gt;&gt; &gt; struct amdgpu_ctx *ctx)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
struct amd_sched_rq *rq;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rq =
=3D &amp;ring-&gt;sched.sched_rq[AMD_<wbr>SCHED_PRIORITY_NORMAL];<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rq =
=3D &amp;ring-&gt;sched.sched_rq[<wbr>priority];<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
r =3D amd_sched_entity_init(&amp;ring-&gt;<wbr>sched,<br>
&gt;&gt; &gt; &amp;ctx-&gt;rings[i].entity,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0rq, amdgpu_sched_jobs);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (r)<br>
&gt;&gt; &gt; @@ -90,11 +96,15 @@ static void amdgpu_ctx_fini(struct amdgpu=
_ctx *ctx)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 static int amdgpu_ctx_alloc(struct amdgpu_device *adev,=
<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_fpriv *fpriv,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *id)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_ctx_mgr *mgr =
=3D &amp;fpriv-&gt;ctx_mgr;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_ctx *ctx;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int r, priority;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0priority =3D flags &amp; AMDGPU_C=
TX_FLAG_HIGHPRIORITY ?<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_S=
CHED_PRIORITY_HIGH : AMD_SCHED_PRIORITY_NORMAL;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx =3D kmalloc(sizeof(*ctx)=
, GFP_KERNEL);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ctx)<br>
&gt;&gt; &gt; @@ -107,8 +117,9 @@ static int amdgpu_ctx_alloc(struct amdgpu=
_device<br>
&gt;&gt; &gt; *adev,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
kfree(ctx);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return r;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*id =3D (uint32_t)r;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ctx_init(adev, ctx);=
<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ctx_init(adev, prior=
ity, ctx);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
idr_remove(&amp;mgr-&gt;ctx_handles, *id);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
*id =3D 0;<br>
&gt;&gt; &gt; @@ -186,7 +197,7 @@ int amdgpu_ctx_ioctl(struct drm_device *d=
ev, void<br>
&gt;&gt; &gt; *data,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct drm_file *filp)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t id;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t id, flags;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0union drm_amdgpu_ctx *args =
=3D data;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =
=3D dev-&gt;dev_private;<br>
&gt;&gt; &gt; @@ -194,10 +205,11 @@ int amdgpu_ctx_ioctl(struct drm_device =
*dev, void<br>
&gt;&gt; &gt; *data,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D 0;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id =3D args-&gt;in.ctx_id;<b=
r>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0flags =3D args-&gt;in.flags;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (args-&gt;in.op) {<br=
>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_CTX_OP_ALLOC_CTX=
:<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D=
 amdgpu_ctx_alloc(adev, fpriv, &amp;id);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D=
 amdgpu_ctx_alloc(adev, fpriv, flags, &amp;id);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
args-&gt;out.alloc.ctx_id =3D id;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
break;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_CTX_OP_FREE_CTX:=
<br>
&gt;&gt; &gt; diff --git a/drivers/gpu/drm/amd/<wbr>scheduler/gpu_scheduler=
.h<br>
&gt;&gt; &gt; b/drivers/gpu/drm/amd/<wbr>scheduler/gpu_scheduler.h<br>
&gt;&gt; &gt; index d8dc681..2e458de 100644<br>
&gt;&gt; &gt; --- a/drivers/gpu/drm/amd/<wbr>scheduler/gpu_scheduler.h<br>
&gt;&gt; &gt; +++ b/drivers/gpu/drm/amd/<wbr>scheduler/gpu_scheduler.h<br>
&gt;&gt; &gt; @@ -108,6 +108,7 @@ struct amd_sched_backend_ops {<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 enum amd_sched_priority {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_SCHED_PRIORITY_KERNEL =
=3D 0,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_SCHED_PRIORITY_HIGH,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_SCHED_PRIORITY_NORMAL,<b=
r>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_SCHED_MAX_PRIORITY<br>
&gt;&gt; &gt;=C2=A0 };<br>
&gt;&gt; &gt; diff --git a/include/uapi/drm/amdgpu_drm.<wbr>h<br>
&gt;&gt; &gt; b/include/uapi/drm/amdgpu_drm.<wbr>h<br>
&gt;&gt; &gt; index 3961836..702332e 100644<br>
&gt;&gt; &gt; --- a/include/uapi/drm/amdgpu_drm.<wbr>h<br>
&gt;&gt; &gt; +++ b/include/uapi/drm/amdgpu_drm.<wbr>h<br>
&gt;&gt; &gt; @@ -160,10 +160,11 @@ union drm_amdgpu_bo_list {<br>
&gt;&gt; &gt;=C2=A0 /* unknown cause */<br>
&gt;&gt; &gt;=C2=A0 #define AMDGPU_CTX_UNKNOWN_RESET=C2=A0 =C2=A0 =C2=A0 =
=C2=A03<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +#define AMDGPU_CTX_FLAG_HIGHPRIORITY=C2=A0 =C2=A0(1 &lt;&lt;=
 0)<br>
&gt;&gt;<br>
&gt;&gt; Would it be better to expose a priority level rather than a single=
<br>
&gt;&gt; flag?=C2=A0 If we want to expose more than just normal/high in the=
 future<br>
&gt;&gt; for example.<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 struct drm_amdgpu_ctx_in {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** AMDGPU_CTX_OP_* */<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0op;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/** For future use, no flags defi=
ned so far */<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/** AMDGPU_CTX_FLAG_* */<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0flags;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0ctx_id;<br=
>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0_pad;<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; 2.7.4<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ______________________________<wbr>_________________<br>
&gt;&gt; &gt; amd-gfx mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@list=
s.freedesktop.org</a><br>
&gt;&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd=
-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<w=
br>mailman/listinfo/amd-gfx</a><br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div>

--94eb2c058c723bbb61054538c468--

--===============0518386223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0518386223==--
