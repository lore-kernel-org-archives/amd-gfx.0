From: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/scheduler: add counter for total jobs in scheduler
Date: Thu, 2 Aug 2018 11:41:22 +0530
Message-ID: <CAFd4ddxd5p6S0aM5pBs5P+6MArBL9bFh=vvFr1zyvqjR-DH_kQ@mail.gmail.com>
References: <20180801082002.20696-1-nayan26deshmukh@gmail.com>
 <20180801082002.20696-2-nayan26deshmukh@gmail.com>
 <20180801131546.GA1401@hr-amur2>
 <79aee9af-534b-693e-6700-1c07a2ef31aa@gmail.com>
 <20180802025709.GA5753@hr-amur2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1842975508=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180802025709.GA5753@hr-amur2>
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
To: ray.huang-5C7GfCeVMHo@public.gmane.org
Cc: Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1842975508==
Content-Type: multipart/alternative; boundary="000000000000ee9a0c05726db0da"

--000000000000ee9a0c05726db0da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the reminders. I felt that the commit header was sufficient
enough but I guess that didn't cover the motivation for the change.

Thanks Christian for adding the commit message.

Regards,
Nayan

On Thu, Aug 2, 2018 at 8:16 AM Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org> wrote:

> On Wed, Aug 01, 2018 at 09:06:29PM +0800, Christian K=C3=B6nig wrote:
> > Yeah, I've actually added one before pushing it to amd-staging-drm-next=
.
> >
> > But thanks for the reminder, wanted to note that to Nayan as well :)
> >
>
> Yes, a soft reminder to Nayan. Thanks Nayan for the contribution. :-)
>
> Thanks,
> Ray
>
> > Christian.
> >
> > Am 01.08.2018 um 15:15 schrieb Huang Rui:
> > > On Wed, Aug 01, 2018 at 01:50:00PM +0530, Nayan Deshmukh wrote:
> > >
> > > This should need a commmit message.
> > >
> > > Thanks,
> > > Ray
> > >
> > >> Signed-off-by: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > >> ---
> > >>   drivers/gpu/drm/scheduler/gpu_scheduler.c | 3 +++
> > >>   include/drm/gpu_scheduler.h               | 2 ++
> > >>   2 files changed, 5 insertions(+)
> > >>
> > >> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > >> index a3eacc35cf98..375f6f7f6a93 100644
> > >> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > >> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > >> @@ -549,6 +549,7 @@ void drm_sched_entity_push_job(struct
> drm_sched_job *sched_job,
> > >>
> > >>    trace_drm_sched_job(sched_job, entity);
> > >>
> > >> +  atomic_inc(&entity->rq->sched->num_jobs);
> > >>    first =3D spsc_queue_push(&entity->job_queue,
> &sched_job->queue_node);
> > >>
> > >>    /* first job wakes up scheduler */
> > >> @@ -836,6 +837,7 @@ static void drm_sched_process_job(struct
> dma_fence *f, struct dma_fence_cb *cb)
> > >>
> > >>    dma_fence_get(&s_fence->finished);
> > >>    atomic_dec(&sched->hw_rq_count);
> > >> +  atomic_dec(&sched->num_jobs);
> > >>    drm_sched_fence_finished(s_fence);
> > >>
> > >>    trace_drm_sched_process_job(s_fence);
> > >> @@ -953,6 +955,7 @@ int drm_sched_init(struct drm_gpu_scheduler
> *sched,
> > >>    INIT_LIST_HEAD(&sched->ring_mirror_list);
> > >>    spin_lock_init(&sched->job_list_lock);
> > >>    atomic_set(&sched->hw_rq_count, 0);
> > >> +  atomic_set(&sched->num_jobs, 0);
> > >>    atomic64_set(&sched->job_id_count, 0);
> > >>
> > >>    /* Each scheduler will run on a seperate kernel thread */
> > >> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler=
.h
> > >> index a60896222a3e..89881ce974a5 100644
> > >> --- a/include/drm/gpu_scheduler.h
> > >> +++ b/include/drm/gpu_scheduler.h
> > >> @@ -260,6 +260,7 @@ struct drm_sched_backend_ops {
> > >>    * @job_list_lock: lock to protect the ring_mirror_list.
> > >>    * @hang_limit: once the hangs by a job crosses this limit then it
> is marked
> > >>    *              guilty and it will be considered for scheduling
> further.
> > >> + * @num_jobs: the number of jobs in queue in the scheduler
> > >>    *
> > >>    * One scheduler is implemented for each hardware ring.
> > >>    */
> > >> @@ -277,6 +278,7 @@ struct drm_gpu_scheduler {
> > >>    struct list_head                ring_mirror_list;
> > >>    spinlock_t                      job_list_lock;
> > >>    int                             hang_limit;
> > >> +  atomic_t                        num_jobs;
> > >>   };
> > >>
> > >>   int drm_sched_init(struct drm_gpu_scheduler *sched,
> > >> --
> > >> 2.14.3
> > >>
> > >> _______________________________________________
> > >> amd-gfx mailing list
> > >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
>

--000000000000ee9a0c05726db0da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Thanks for the reminders. I felt that the c=
ommit header was sufficient enough but I guess that didn&#39;t cover the mo=
tivation for the change.<br><br></div>Thanks Christian for adding the commi=
t message.<br><br></div>Regards,<br></div>Nayan<br></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr">On Thu, Aug 2, 2018 at 8:16 AM Huang Rui &lt;=
<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">ray.huang-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Wed, Aug 01, 2018 at 09:06:29PM +0800=
, Christian K=C3=B6nig wrote:<br>
&gt; Yeah, I&#39;ve actually added one before pushing it to amd-staging-drm=
-next.<br>
&gt; <br>
&gt; But thanks for the reminder, wanted to note that to Nayan as well :)<b=
r>
&gt; <br>
<br>
Yes, a soft reminder to Nayan. Thanks Nayan for the contribution. :-)<br>
<br>
Thanks,<br>
Ray<br>
<br>
&gt; Christian.<br>
&gt; <br>
&gt; Am 01.08.2018 um 15:15 schrieb Huang Rui:<br>
&gt; &gt; On Wed, Aug 01, 2018 at 01:50:00PM +0530, Nayan Deshmukh wrote:<b=
r>
&gt; &gt;<br>
&gt; &gt; This should need a commmit message.<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Ray<br>
&gt; &gt;<br>
&gt; &gt;&gt; Signed-off-by: Nayan Deshmukh &lt;<a href=3D"mailto:nayan26de=
shmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 =C2=A0drivers/gpu/drm/scheduler/gpu_scheduler.c | 3 +++=
<br>
&gt; &gt;&gt;=C2=A0 =C2=A0include/drm/gpu_scheduler.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
&gt; &gt;&gt;=C2=A0 =C2=A02 files changed, 5 insertions(+)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/driv=
ers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; &gt;&gt; index a3eacc35cf98..375f6f7f6a93 100644<br>
&gt; &gt;&gt; --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; &gt;&gt; +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt; &gt;&gt; @@ -549,6 +549,7 @@ void drm_sched_entity_push_job(struct drm=
_sched_job *sched_job,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 trace_drm_sched_job(sched_job, entity);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0<br>
&gt; &gt;&gt; +=C2=A0 atomic_inc(&amp;entity-&gt;rq-&gt;sched-&gt;num_jobs)=
;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 first =3D spsc_queue_push(&amp;entity-&gt;job_qu=
eue, &amp;sched_job-&gt;queue_node);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 /* first job wakes up scheduler */<br>
&gt; &gt;&gt; @@ -836,6 +837,7 @@ static void drm_sched_process_job(struct =
dma_fence *f, struct dma_fence_cb *cb)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 dma_fence_get(&amp;s_fence-&gt;finished);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 atomic_dec(&amp;sched-&gt;hw_rq_count);<br>
&gt; &gt;&gt; +=C2=A0 atomic_dec(&amp;sched-&gt;num_jobs);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 drm_sched_fence_finished(s_fence);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 trace_drm_sched_process_job(s_fence);<br>
&gt; &gt;&gt; @@ -953,6 +955,7 @@ int drm_sched_init(struct drm_gpu_schedul=
er *sched,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 INIT_LIST_HEAD(&amp;sched-&gt;ring_mirror_list);=
<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 spin_lock_init(&amp;sched-&gt;job_list_lock);<br=
>
&gt; &gt;&gt;=C2=A0 =C2=A0 atomic_set(&amp;sched-&gt;hw_rq_count, 0);<br>
&gt; &gt;&gt; +=C2=A0 atomic_set(&amp;sched-&gt;num_jobs, 0);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 atomic64_set(&amp;sched-&gt;job_id_count, 0);<br=
>
&gt; &gt;&gt;=C2=A0 =C2=A0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 /* Each scheduler will run on a seperate kernel =
thread */<br>
&gt; &gt;&gt; diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_sc=
heduler.h<br>
&gt; &gt;&gt; index a60896222a3e..89881ce974a5 100644<br>
&gt; &gt;&gt; --- a/include/drm/gpu_scheduler.h<br>
&gt; &gt;&gt; +++ b/include/drm/gpu_scheduler.h<br>
&gt; &gt;&gt; @@ -260,6 +260,7 @@ struct drm_sched_backend_ops {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 * @job_list_lock: lock to protect the ring_mirro=
r_list.<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 * @hang_limit: once the hangs by a job crosses t=
his limit then it is marked<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 guilty and it will be considered for scheduling further.<br>
&gt; &gt;&gt; + * @num_jobs: the number of jobs in queue in the scheduler<b=
r>
&gt; &gt;&gt;=C2=A0 =C2=A0 *<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 * One scheduler is implemented for each hardware=
 ring.<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 */<br>
&gt; &gt;&gt; @@ -277,6 +278,7 @@ struct drm_gpu_scheduler {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 struct list_head=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ring_mirror_list;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 spinlock_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 job_list_lock;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hang_limit;<br>
&gt; &gt;&gt; +=C2=A0 atomic_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_jobs;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0};<br>
&gt; &gt;&gt;=C2=A0 =C2=A0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0int drm_sched_init(struct drm_gpu_scheduler *sche=
d,<br>
&gt; &gt;&gt; -- <br>
&gt; &gt;&gt; 2.14.3<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; _______________________________________________<br>
&gt; &gt;&gt; amd-gfx mailing list<br>
&gt; &gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_b=
lank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; &gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd=
-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx</a><br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; dri-devel mailing list<br>
&gt; &gt; <a href=3D"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_bla=
nk">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-dev=
el" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mail=
man/listinfo/dri-devel</a><br>
&gt; <br>
</blockquote></div>

--000000000000ee9a0c05726db0da--

--===============1842975508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1842975508==--
