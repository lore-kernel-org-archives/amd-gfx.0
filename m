From: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/scheduler: add new function to get least loaded
 sched
Date: Tue, 31 Jul 2018 17:05:54 +0530
Message-ID: <CAFd4ddxxh_RtnafPTYKDZbWAih41f6umyo8iWWo1bf-Oww87QA@mail.gmail.com>
References: <20180731103736.7813-1-nayan26deshmukh@gmail.com>
 <20180731103736.7813-4-nayan26deshmukh@gmail.com>
 <1e24b45b-027c-2742-97eb-21054798218d@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0489643921=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1e24b45b-027c-2742-97eb-21054798218d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

--===============0489643921==
Content-Type: multipart/alternative; boundary="000000000000e6f837057249fde9"

--000000000000e6f837057249fde9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will take care of that in v2.

On Tue, Jul 31, 2018 at 4:57 PM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 31.07.2018 um 12:37 schrieb Nayan Deshmukh:
> > The function selects the run queue from the rq_list with the
> > least load. The load is decided by the number of jobs in a
> > scheduler.
> >
> > Signed-off-by: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >   drivers/gpu/drm/scheduler/gpu_scheduler.c | 26
> ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > index 375f6f7f6a93..c67f65ad8f15 100644
> > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > @@ -255,6 +255,32 @@ static bool drm_sched_entity_is_ready(struct
> drm_sched_entity *entity)
> >       return true;
> >   }
> >
> > +/**
> > + * drm_sched_entity_get_free_sched - Get the rq from rq_list with leas=
t
> load
> > + *
> > + * @entity: scheduler entity
> > + *
> > + * Return the pointer to the rq with least load.
> > + */
> > +static struct drm_sched_rq *
> > +drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
> > +{
> > +     struct drm_sched_rq *rq =3D NULL;
> > +     unsigned int min_jobs =3D UINT_MAX;
> > +     int i;
> > +
> > +     for (i =3D 0; i < entity->num_rq_list; ++i) {
> > +             if (atomic_read(&entity->rq_list[i]->sched->num_jobs) <
> > +                             min_jobs) {
> > +                     min_jobs =3D atomic_read(
> > +
>  &entity->rq_list[i]->sched->num_jobs);
>
> When you use atomic_read twice you might get different results because
> the atomic has changed in the meantime.
>
> In other words you need to store the result locally:
>
> unsigned int num_jobs =3D atomic_read(....);
>
> if (num_jobs < min_jobs) {
>      min_jobs =3D num_jobs;
>      .....
>
> Christian.
>
> > +                     rq =3D entity->rq_list[i];
> > +             }
> > +     }
> > +
> > +     return rq;
> > +}
> > +
> >   static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
> >                                   struct dma_fence_cb *cb)
> >   {
>
>

--000000000000e6f837057249fde9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I will take care of that in v2.<br></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr">On Tue, Jul 31, 2018 at 4:57 PM Christian K=
=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.l=
eichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">Am 31.07.2018 um 12:37 schrieb Nayan Deshmukh:<br>
&gt; The function selects the run queue from the rq_list with the<br>
&gt; least load. The load is decided by the number of jobs in a<br>
&gt; scheduler.<br>
&gt;<br>
&gt; Signed-off-by: Nayan Deshmukh &lt;<a href=3D"mailto:nayan26deshmukh@gm=
ail.com" target=3D"_blank">nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/scheduler/gpu_scheduler.c | 26 +++++++++++=
+++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 26 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/d=
rm/scheduler/gpu_scheduler.c<br>
&gt; index 375f6f7f6a93..c67f65ad8f15 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; @@ -255,6 +255,32 @@ static bool drm_sched_entity_is_ready(struct drm_=
sched_entity *entity)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/**<br>
&gt; + * drm_sched_entity_get_free_sched - Get the rq from rq_list with lea=
st load<br>
&gt; + *<br>
&gt; + * @entity: scheduler entity<br>
&gt; + *<br>
&gt; + * Return the pointer to the rq with least load.<br>
&gt; + */<br>
&gt; +static struct drm_sched_rq *<br>
&gt; +drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct drm_sched_rq *rq =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int min_jobs =3D UINT_MAX;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; entity-&gt;num_rq_list; ++i)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (atomic_read(&amp;=
entity-&gt;rq_list[i]-&gt;sched-&gt;num_jobs) &lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0min_jobs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0min_jobs =3D atomic_read(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;entity-=
&gt;rq_list[i]-&gt;sched-&gt;num_jobs);<br>
<br>
When you use atomic_read twice you might get different results because <br>
the atomic has changed in the meantime.<br>
<br>
In other words you need to store the result locally:<br>
<br>
unsigned int num_jobs =3D atomic_read(....);<br>
<br>
if (num_jobs &lt; min_jobs) {<br>
=C2=A0=C2=A0=C2=A0=C2=A0 min_jobs =3D num_jobs;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 .....<br>
<br>
Christian.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rq =3D entity-&gt;rq_list[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return rq;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void drm_sched_entity_kill_jobs_cb(struct dma_fence=
 *f,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence_cb =
*cb)<br>
&gt;=C2=A0 =C2=A0{<br>
<br>
</blockquote></div>

--000000000000e6f837057249fde9--

--===============0489643921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0489643921==--
