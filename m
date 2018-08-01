From: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Subject: Re: [PATCH 3/4] drm/scheduler: add new function to get least loaded
 sched v2
Date: Wed, 1 Aug 2018 21:36:42 +0530
Message-ID: <CAFd4ddx8D2iKquRu4YVh1gnRMpLFgWf3CBPdk5SD-nJ8dNXEPQ@mail.gmail.com>
References: <20180801082002.20696-1-nayan26deshmukh@gmail.com>
 <20180801082002.20696-3-nayan26deshmukh@gmail.com>
 <dde1b549-df1b-e156-1e96-ddfe4beca446@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1189009893=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <dde1b549-df1b-e156-1e96-ddfe4beca446@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

--===============1189009893==
Content-Type: multipart/alternative; boundary="000000000000707621057261e2eb"

--000000000000707621057261e2eb
Content-Type: text/plain; charset="UTF-8"

Yes, that is correct.

Nayan

On Wed, Aug 1, 2018, 9:05 PM Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
wrote:

> Clarification question -  if the run queues belong to different
> schedulers they effectively point to different rings,
>
> it means we allow to move (reschedule) a drm_sched_entity from one ring
> to another - i assume that the idea int the first place, that
>
> you have a set of HW rings and you can utilize any of them for your jobs
> (like compute rings). Correct ?
>
> Andrey
>
>
> On 08/01/2018 04:20 AM, Nayan Deshmukh wrote:
> > The function selects the run queue from the rq_list with the
> > least load. The load is decided by the number of jobs in a
> > scheduler.
> >
> > v2: avoid using atomic read twice consecutively, instead store
> >      it locally
> >
> > Signed-off-by: Nayan Deshmukh <nayan26deshmukh@gmail.com>
> > ---
> >   drivers/gpu/drm/scheduler/gpu_scheduler.c | 25
> +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > index 375f6f7f6a93..fb4e542660b0 100644
> > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > @@ -255,6 +255,31 @@ static bool drm_sched_entity_is_ready(struct
> drm_sched_entity *entity)
> >       return true;
> >   }
> >
> > +/**
> > + * drm_sched_entity_get_free_sched - Get the rq from rq_list with least
> load
> > + *
> > + * @entity: scheduler entity
> > + *
> > + * Return the pointer to the rq with least load.
> > + */
> > +static struct drm_sched_rq *
> > +drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
> > +{
> > +     struct drm_sched_rq *rq = NULL;
> > +     unsigned int min_jobs = UINT_MAX, num_jobs;
> > +     int i;
> > +
> > +     for (i = 0; i < entity->num_rq_list; ++i) {
> > +             num_jobs =
> atomic_read(&entity->rq_list[i]->sched->num_jobs);
> > +             if (num_jobs < min_jobs) {
> > +                     min_jobs = num_jobs;
> > +                     rq = entity->rq_list[i];
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

--000000000000707621057261e2eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, that is correct.=C2=A0<div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Nayan</div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr">On Wed, Aug 1, 2018, 9:05 PM Andrey Grodzovsky &lt;<a href=3D"mailto:=
Andrey.Grodzovsky@amd.com">Andrey.Grodzovsky@amd.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">Clarification question -=C2=A0 if the run =
queues belong to different <br>
schedulers they effectively point to different rings,<br>
<br>
it means we allow to move (reschedule) a drm_sched_entity from one ring <br=
>
to another - i assume that the idea int the first place, that<br>
<br>
you have a set of HW rings and you can utilize any of them for your jobs <b=
r>
(like compute rings). Correct ?<br>
<br>
Andrey<br>
<br>
<br>
On 08/01/2018 04:20 AM, Nayan Deshmukh wrote:<br>
&gt; The function selects the run queue from the rq_list with the<br>
&gt; least load. The load is decided by the number of jobs in a<br>
&gt; scheduler.<br>
&gt;<br>
&gt; v2: avoid using atomic read twice consecutively, instead store<br>
&gt;=C2=A0 =C2=A0 =C2=A0 it locally<br>
&gt;<br>
&gt; Signed-off-by: Nayan Deshmukh &lt;<a href=3D"mailto:nayan26deshmukh@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">nayan26deshmukh@gmail.com</a>=
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/scheduler/gpu_scheduler.c | 25 +++++++++++=
++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 25 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/d=
rm/scheduler/gpu_scheduler.c<br>
&gt; index 375f6f7f6a93..fb4e542660b0 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; @@ -255,6 +255,31 @@ static bool drm_sched_entity_is_ready(struct drm_=
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
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int min_jobs =3D UINT_MAX, num_jobs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; entity-&gt;num_rq_list; ++i)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_jobs =3D atomic_r=
ead(&amp;entity-&gt;rq_list[i]-&gt;sched-&gt;num_jobs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_jobs &lt; min=
_jobs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0min_jobs =3D num_jobs;<br>
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

--000000000000707621057261e2eb--

--===============1189009893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1189009893==--
