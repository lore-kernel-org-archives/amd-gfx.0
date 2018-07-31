From: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Subject: Re: [PATCH 4/4] drm/scheduler: move idle entities to scheduler with
 less load
Date: Tue, 31 Jul 2018 17:08:35 +0530
Message-ID: <CAFd4ddzHOjooOG+u40JWjtiibKhXdUsX8=M43ypGRYK6uVAKFA@mail.gmail.com>
References: <20180731103736.7813-1-nayan26deshmukh@gmail.com>
 <20180731103736.7813-5-nayan26deshmukh@gmail.com>
 <1e00384e-9741-3745-556a-bd13319d0706@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1095181865=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1e00384e-9741-3745-556a-bd13319d0706@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1095181865==
Content-Type: multipart/alternative; boundary="0000000000008c76ac05724a0707"

--0000000000008c76ac05724a0707
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 5:02 PM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 31.07.2018 um 12:37 schrieb Nayan Deshmukh:
> > This is the first attempt to move entities between schedulers to
> > have dynamic load balancing. We just move entities with no jobs for
> > now as moving the ones with jobs will lead to other compilcations
> > like ensuring that the other scheduler does not remove a job from
> > the current entity while we are moving.
> >
> > Signed-off-by: Nayan Deshmukh <nayan26deshmukh@gmail.com>
> > ---
> >   drivers/gpu/drm/scheduler/gpu_scheduler.c | 25
> ++++++++++++++++++++-----
> >   1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > index c67f65ad8f15..f665a84d48ef 100644
> > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > @@ -540,6 +540,8 @@ drm_sched_entity_pop_job(struct drm_sched_entity
> *entity)
> >       if (!sched_job)
> >               return NULL;
> >
> > +     sched_job->sched =3D sched;
> > +     sched_job->s_fence->sched =3D sched;
> >       while ((entity->dependency =3D sched->ops->dependency(sched_job,
> entity)))
> >               if (drm_sched_entity_add_dependency_cb(entity))
> >                       return NULL;
> > @@ -570,16 +572,29 @@ drm_sched_entity_pop_job(struct drm_sched_entity
> *entity)
> >   void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
> >                              struct drm_sched_entity *entity)
> >   {
> > -     struct drm_gpu_scheduler *sched =3D sched_job->sched;
> > -     bool first =3D false;
> > +     struct drm_gpu_scheduler *sched =3D entity->rq->sched;
>
> Is the local "sched" variable actually still used?
>
> Might be a good idea to drop that since we potentially changing the
> scheduler/rq.
>
Yes dropping it is a good idea to avoid confusion. I had kept it for
debugging purpose but forgot to remove it in the end.


>
> > +     struct drm_sched_rq *rq =3D entity->rq;
> > +     bool first =3D false, reschedule, idle;
> >
> > -     trace_drm_sched_job(sched_job, entity);
> > +     idle =3D entity->last_scheduled =3D=3D NULL ||
> > +             dma_fence_is_signaled(entity->last_scheduled);
> > +     first =3D spsc_queue_count(&entity->job_queue) =3D=3D 0;
> > +     reschedule =3D idle && first && (entity->num_rq_list > 1);
> > +
> > +     if (reschedule) {
> > +             rq =3D drm_sched_entity_get_free_sched(entity);
> > +             spin_lock(&entity->rq_lock);
> > +             drm_sched_rq_remove_entity(entity->rq, entity);
> > +             entity->rq =3D rq;
> > +             spin_unlock(&entity->rq_lock);
> > +     }
> >
> > +     trace_drm_sched_job(sched_job, entity);
> >       atomic_inc(&entity->rq->sched->num_jobs);
> >       first =3D spsc_queue_push(&entity->job_queue,
> &sched_job->queue_node);
> >
> >       /* first job wakes up scheduler */
> > -     if (first) {
> > +     if (first || reschedule) {
>
> You can drop that extra check since we can only rescheduler when there
> wasn't any jobs in the entity.

Will fix it in v2.

>
> Christian.
>
> >               /* Add the entity to the run queue */
> >               spin_lock(&entity->rq_lock);
> >               if (!entity->rq) {
> > @@ -589,7 +604,7 @@ void drm_sched_entity_push_job(struct drm_sched_job
> *sched_job,
> >               }
> >               drm_sched_rq_add_entity(entity->rq, entity);
> >               spin_unlock(&entity->rq_lock);
> > -             drm_sched_wakeup(sched);
> > +             drm_sched_wakeup(entity->rq->sched);
> >       }
> >   }
> >   EXPORT_SYMBOL(drm_sched_entity_push_job);
>
>

--0000000000008c76ac05724a0707
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue=
, Jul 31, 2018 at 5:02 PM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoeni=
g.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Am 31.07.2018 um 12:37 schrieb Nay=
an Deshmukh:<br>
&gt; This is the first attempt to move entities between schedulers to<br>
&gt; have dynamic load balancing. We just move entities with no jobs for<br=
>
&gt; now as moving the ones with jobs will lead to other compilcations<br>
&gt; like ensuring that the other scheduler does not remove a job from<br>
&gt; the current entity while we are moving.<br>
&gt;<br>
&gt; Signed-off-by: Nayan Deshmukh &lt;<a href=3D"mailto:nayan26deshmukh@gm=
ail.com" target=3D"_blank">nayan26deshmukh@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/scheduler/gpu_scheduler.c | 25 +++++++++++=
+++++++++-----<br>
&gt;=C2=A0 =C2=A01 file changed, 20 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/d=
rm/scheduler/gpu_scheduler.c<br>
&gt; index c67f65ad8f15..f665a84d48ef 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; @@ -540,6 +540,8 @@ drm_sched_entity_pop_job(struct drm_sched_entity *=
entity)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sched_job)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sched_job-&gt;sched =3D sched;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sched_job-&gt;s_fence-&gt;sched =3D sched;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0while ((entity-&gt;dependency =3D sched-&gt;=
ops-&gt;dependency(sched_job, entity)))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (drm_sched_en=
tity_add_dependency_cb(entity))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return NULL;<br>
&gt; @@ -570,16 +572,29 @@ drm_sched_entity_pop_job(struct drm_sched_entity=
 *entity)<br>
&gt;=C2=A0 =C2=A0void drm_sched_entity_push_job(struct drm_sched_job *sched=
_job,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_sched_entity *entity)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct drm_gpu_scheduler *sched =3D sched_job-&gt=
;sched;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0bool first =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct drm_gpu_scheduler *sched =3D entity-&gt;rq=
-&gt;sched;<br>
<br>
Is the local &quot;sched&quot; variable actually still used?<br>
<br>
Might be a good idea to drop that since we potentially changing the <br>
scheduler/rq.<br></blockquote><div>Yes dropping it is a good idea to avoid =
confusion. I had kept it for debugging purpose but forgot to remove it in t=
he end. <br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct drm_sched_rq *rq =3D entity-&gt;rq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool first =3D false, reschedule, idle;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0trace_drm_sched_job(sched_job, entity);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0idle =3D entity-&gt;last_scheduled =3D=3D NULL ||=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_is_signaled=
(entity-&gt;last_scheduled);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0first =3D spsc_queue_count(&amp;entity-&gt;job_qu=
eue) =3D=3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reschedule =3D idle &amp;&amp; first &amp;&amp; (=
entity-&gt;num_rq_list &gt; 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (reschedule) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rq =3D drm_sched_enti=
ty_get_free_sched(entity);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;entity=
-&gt;rq_lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_rq_remove_e=
ntity(entity-&gt;rq, entity);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entity-&gt;rq =3D rq;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;enti=
ty-&gt;rq_lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0trace_drm_sched_job(sched_job, entity);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_inc(&amp;entity-&gt;rq-&gt;sched-&gt;=
num_jobs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0first =3D spsc_queue_push(&amp;entity-&gt;jo=
b_queue, &amp;sched_job-&gt;queue_node);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* first job wakes up scheduler */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (first) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (first || reschedule) {<br>
<br>
You can drop that extra check since we can only rescheduler when there <br>
wasn&#39;t any jobs in the entity.=C2=A0</blockquote><div>Will fix it in v2=
. <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
Christian.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add the entit=
y to the run queue */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;e=
ntity-&gt;rq_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!entity-&gt;=
rq) {<br>
&gt; @@ -589,7 +604,7 @@ void drm_sched_entity_push_job(struct drm_sched_jo=
b *sched_job,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_rq_add=
_entity(entity-&gt;rq, entity);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp=
;entity-&gt;rq_lock);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_wakeup(sche=
d);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_wakeup(enti=
ty-&gt;rq-&gt;sched);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0EXPORT_SYMBOL(drm_sched_entity_push_job);<br>
<br>
</blockquote></div></div>

--0000000000008c76ac05724a0707--

--===============1095181865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1095181865==--
