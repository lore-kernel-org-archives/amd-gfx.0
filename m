From: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Subject: Re: [PATCH 2/3] drm/scheduler: add counter for total jobs in scheduler
Date: Thu, 2 Aug 2018 11:20:31 +0530
Message-ID: <CAFd4ddzHsjg=D0=Zo-iKLv-uQ_MFWq2bzZGLwXQtoRnZAixzGA@mail.gmail.com>
References: <20180712063643.8030-1-nayan26deshmukh@gmail.com>
 <20180712063643.8030-3-nayan26deshmukh@gmail.com> <5B62901B.3050005@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0449122595=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <5B62901B.3050005@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jerry.Zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0449122595==
Content-Type: multipart/alternative; boundary="000000000000614c6405726d66eb"

--000000000000614c6405726d66eb
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 2, 2018 at 10:31 AM Zhang, Jerry (Junwei) <Jerry.Zhang@amd.com>
wrote:

> On 07/12/2018 02:36 PM, Nayan Deshmukh wrote:
> > Signed-off-by: Nayan Deshmukh <nayan26deshmukh@gmail.com>
> > ---
> >   drivers/gpu/drm/scheduler/gpu_scheduler.c | 3 +++
> >   include/drm/gpu_scheduler.h               | 2 ++
> >   2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > index 429b1328653a..3dc1a4f07e3f 100644
> > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > @@ -538,6 +538,7 @@ void drm_sched_entity_push_job(struct drm_sched_job
> *sched_job,
> >       trace_drm_sched_job(sched_job, entity);
> >
> >       first = spsc_queue_push(&entity->job_queue,
> &sched_job->queue_node);
> > +     atomic_inc(&entity->sched->num_jobs);
>
> Shall we use hw_rq_count directly or merge them together?
>
hw_rq_count is the number of jobs that are currently in the hardware queue
as compared to num_jobs which is the number of jobs in the software queue.
num_jobs provides a give a better idea of the load on a scheduler that's
why I added that field and used it to decide the scheduler with the least
load.

Regards,
Nayan

>
> Regards,
> Jerry
> >
> >       /* first job wakes up scheduler */
> >       if (first) {
> > @@ -818,6 +819,7 @@ static void drm_sched_process_job(struct dma_fence
> *f, struct dma_fence_cb *cb)
> >
> >       dma_fence_get(&s_fence->finished);
> >       atomic_dec(&sched->hw_rq_count);
> > +     atomic_dec(&sched->num_jobs);
> >       drm_sched_fence_finished(s_fence);
> >
> >       trace_drm_sched_process_job(s_fence);
> > @@ -935,6 +937,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
> >       INIT_LIST_HEAD(&sched->ring_mirror_list);
> >       spin_lock_init(&sched->job_list_lock);
> >       atomic_set(&sched->hw_rq_count, 0);
> > +     atomic_set(&sched->num_jobs, 0);
> >       atomic64_set(&sched->job_id_count, 0);
> >
> >       /* Each scheduler will run on a seperate kernel thread */
> > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > index 43e93d6077cf..605bd4ad2397 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -257,6 +257,7 @@ struct drm_sched_backend_ops {
> >    * @job_list_lock: lock to protect the ring_mirror_list.
> >    * @hang_limit: once the hangs by a job crosses this limit then it is
> marked
> >    *              guilty and it will be considered for scheduling
> further.
> > + * @num_jobs: the number of jobs in queue in the scheduler
> >    *
> >    * One scheduler is implemented for each hardware ring.
> >    */
> > @@ -274,6 +275,7 @@ struct drm_gpu_scheduler {
> >       struct list_head                ring_mirror_list;
> >       spinlock_t                      job_list_lock;
> >       int                             hang_limit;
> > +     atomic_t                        num_jobs;
> >   };
> >
> >   int drm_sched_init(struct drm_gpu_scheduler *sched,
> >
>

--000000000000614c6405726d66eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu=
, Aug 2, 2018 at 10:31 AM Zhang, Jerry (Junwei) &lt;<a href=3D"mailto:Jerry=
.Zhang@amd.com">Jerry.Zhang@amd.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">On 07/12/2018 02:36 PM, Nayan Deshmukh wrote:<br>
&gt; Signed-off-by: Nayan Deshmukh &lt;<a href=3D"mailto:nayan26deshmukh@gm=
ail.com" target=3D"_blank">nayan26deshmukh@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/scheduler/gpu_scheduler.c | 3 +++<br>
&gt;=C2=A0 =C2=A0include/drm/gpu_scheduler.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
&gt;=C2=A0 =C2=A02 files changed, 5 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/d=
rm/scheduler/gpu_scheduler.c<br>
&gt; index 429b1328653a..3dc1a4f07e3f 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; @@ -538,6 +538,7 @@ void drm_sched_entity_push_job(struct drm_sched_jo=
b *sched_job,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_drm_sched_job(sched_job, entity);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0first =3D spsc_queue_push(&amp;entity-&gt;jo=
b_queue, &amp;sched_job-&gt;queue_node);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0atomic_inc(&amp;entity-&gt;sched-&gt;num_jobs);<b=
r>
<br>
Shall we use hw_rq_count directly or merge them together?<br></blockquote><=
div>hw_rq_count is the number of jobs that are currently in the hardware qu=
eue as compared to num_jobs which is the number of jobs in the software que=
ue. num_jobs provides a give a better idea of the load on a scheduler that&=
#39;s why I added that field and used it to decide the scheduler with the l=
east load. <br><br></div><div>Regards,<br></div><div>Nayan <br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
Regards,<br>
Jerry<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* first job wakes up scheduler */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (first) {<br>
&gt; @@ -818,6 +819,7 @@ static void drm_sched_process_job(struct dma_fence=
 *f, struct dma_fence_cb *cb)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_get(&amp;s_fence-&gt;finished);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_dec(&amp;sched-&gt;hw_rq_count);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0atomic_dec(&amp;sched-&gt;num_jobs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_fence_finished(s_fence);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_drm_sched_process_job(s_fence);<br>
&gt; @@ -935,6 +937,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_LIST_HEAD(&amp;sched-&gt;ring_mirror_li=
st);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;sched-&gt;job_list_lock)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_set(&amp;sched-&gt;hw_rq_count, 0);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0atomic_set(&amp;sched-&gt;num_jobs, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_set(&amp;sched-&gt;job_id_count, 0)=
;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Each scheduler will run on a seperate ker=
nel thread */<br>
&gt; diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h=
<br>
&gt; index 43e93d6077cf..605bd4ad2397 100644<br>
&gt; --- a/include/drm/gpu_scheduler.h<br>
&gt; +++ b/include/drm/gpu_scheduler.h<br>
&gt; @@ -257,6 +257,7 @@ struct drm_sched_backend_ops {<br>
&gt;=C2=A0 =C2=A0 * @job_list_lock: lock to protect the ring_mirror_list.<b=
r>
&gt;=C2=A0 =C2=A0 * @hang_limit: once the hangs by a job crosses this limit=
 then it is marked<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 guilty =
and it will be considered for scheduling further.<br>
&gt; + * @num_jobs: the number of jobs in queue in the scheduler<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 * One scheduler is implemented for each hardware ring.<br=
>
&gt;=C2=A0 =C2=A0 */<br>
&gt; @@ -274,6 +275,7 @@ struct drm_gpu_scheduler {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_mirror_list;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 job_list_lock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hang_limit;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0atomic_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_jobs;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;<br>
&gt;=C2=A0 =C2=A0int drm_sched_init(struct drm_gpu_scheduler *sched,<br>
&gt;<br>
</blockquote></div></div>

--000000000000614c6405726d66eb--

--===============0449122595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0449122595==--
