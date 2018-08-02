From: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/scheduler: add counter for total jobs in scheduler
Date: Thu, 2 Aug 2018 11:38:23 +0530
Message-ID: <CAFd4ddyYDy=u68cd4RbJ54yyGBFcUX8NaM8DaC-huuzmnDOfSQ@mail.gmail.com>
References: <20180712063643.8030-1-nayan26deshmukh@gmail.com>
 <20180712063643.8030-3-nayan26deshmukh@gmail.com> <5B62901B.3050005@amd.com>
 <CAFd4ddzHsjg=D0=Zo-iKLv-uQ_MFWq2bzZGLwXQtoRnZAixzGA@mail.gmail.com>
 <5B629DC1.2040100@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1027226986=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5B629DC1.2040100-5C7GfCeVMHo@public.gmane.org>
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
To: Jerry.Zhang-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

--===============1027226986==
Content-Type: multipart/alternative; boundary="000000000000503fbd05726da61a"

--000000000000503fbd05726da61a
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 2, 2018 at 11:29 AM Zhang, Jerry (Junwei) <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
wrote:

> On 08/02/2018 01:50 PM, Nayan Deshmukh wrote:
> >
> >
> > On Thu, Aug 2, 2018 at 10:31 AM Zhang, Jerry (Junwei) <
> Jerry.Zhang-5C7GfCeVMHo@public.gmane.org <mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>> wrote:
> >
> >     On 07/12/2018 02:36 PM, Nayan Deshmukh wrote:
> >      > Signed-off-by: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:
> nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
> >      > ---
> >      >   drivers/gpu/drm/scheduler/gpu_scheduler.c | 3 +++
> >      >   include/drm/gpu_scheduler.h               | 2 ++
> >      >   2 files changed, 5 insertions(+)
> >      >
> >      > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> >      > index 429b1328653a..3dc1a4f07e3f 100644
> >      > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> >      > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> >      > @@ -538,6 +538,7 @@ void drm_sched_entity_push_job(struct
> drm_sched_job *sched_job,
> >      >       trace_drm_sched_job(sched_job, entity);
> >      >
> >      >       first = spsc_queue_push(&entity->job_queue,
> &sched_job->queue_node);
> >      > +     atomic_inc(&entity->sched->num_jobs);
> >
> >     Shall we use hw_rq_count directly or merge them together?
> >
> > hw_rq_count is the number of jobs that are currently in the hardware
> queue as compared to num_jobs which is the number of jobs in the software
> queue. num_jobs provides a give a better idea of the load
> > on a scheduler that's why I added that field and used it to decide the
> scheduler with the least load.
>
> Thanks for your explanation.
>
> Then may be more reasonable to move atomic_dec(&sched->num_jobs) after
> drm_sched_fence_scheduled() or just before atomic_inc(&sched->hw_rq_count).
> How do you think that?
>
> For now num_jobs also includes jobs that have been pushed to the hardware
queue. If I shift it before atomic_inc(&sched->hw_rq_count) then I also
need to handle cases when the job was reset and update the counter
properly. I went for the easier implementation as I felt that num_jobs will
correctly represent the load on the scheduler.

But the idea that you suggested can be a potential improvement over what I
have done.

Regards,
Nayan

> Regards,
> Jerry
>
> >
> > Regards,
> > Nayan
> >
> >
> >     Regards,
> >     Jerry
> >      >
> >      >       /* first job wakes up scheduler */
> >      >       if (first) {
> >      > @@ -818,6 +819,7 @@ static void drm_sched_process_job(struct
> dma_fence *f, struct dma_fence_cb *cb)
> >      >
> >      >       dma_fence_get(&s_fence->finished);
> >      >       atomic_dec(&sched->hw_rq_count);
> >      > +     atomic_dec(&sched->num_jobs);
> >      >       drm_sched_fence_finished(s_fence);
> >      >
> >      >       trace_drm_sched_process_job(s_fence);
> >      > @@ -935,6 +937,7 @@ int drm_sched_init(struct drm_gpu_scheduler
> *sched,
> >      >       INIT_LIST_HEAD(&sched->ring_mirror_list);
> >      >       spin_lock_init(&sched->job_list_lock);
> >      >       atomic_set(&sched->hw_rq_count, 0);
> >      > +     atomic_set(&sched->num_jobs, 0);
> >      >       atomic64_set(&sched->job_id_count, 0);
> >      >
> >      >       /* Each scheduler will run on a seperate kernel thread */
> >      > diff --git a/include/drm/gpu_scheduler.h
> b/include/drm/gpu_scheduler.h
> >      > index 43e93d6077cf..605bd4ad2397 100644
> >      > --- a/include/drm/gpu_scheduler.h
> >      > +++ b/include/drm/gpu_scheduler.h
> >      > @@ -257,6 +257,7 @@ struct drm_sched_backend_ops {
> >      >    * @job_list_lock: lock to protect the ring_mirror_list.
> >      >    * @hang_limit: once the hangs by a job crosses this limit then
> it is marked
> >      >    *              guilty and it will be considered for scheduling
> further.
> >      > + * @num_jobs: the number of jobs in queue in the scheduler
> >      >    *
> >      >    * One scheduler is implemented for each hardware ring.
> >      >    */
> >      > @@ -274,6 +275,7 @@ struct drm_gpu_scheduler {
> >      >       struct list_head                ring_mirror_list;
> >      >       spinlock_t                      job_list_lock;
> >      >       int                             hang_limit;
> >      > +     atomic_t                        num_jobs;
> >      >   };
> >      >
> >      >   int drm_sched_init(struct drm_gpu_scheduler *sched,
> >      >
> >
>

--000000000000503fbd05726da61a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu=
, Aug 2, 2018 at 11:29 AM Zhang, Jerry (Junwei) &lt;<a href=3D"mailto:Jerry=
.Zhang-5C7GfCeVMHo@public.gmane.org">Jerry.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">On 08/02/2018 01:50 PM, Nayan Deshmukh wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Aug 2, 2018 at 10:31 AM Zhang, Jerry (Junwei) &lt;<a href=3D"m=
ailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Jerry.Zhang-5C7GfCeVMHo@public.gmane.org</a> &lt;ma=
ilto:<a href=3D"mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Jerry.Zhang@a=
md.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 07/12/2018 02:36 PM, Nayan Deshmukh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Nayan Deshmukh &lt;<a href=3D"=
mailto:nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">nayan26deshmukh@gmail.c=
om</a> &lt;mailto:<a href=3D"mailto:nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_b=
lank">nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0drivers/gpu/drm/scheduler/gpu_sch=
eduler.c | 3 +++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0include/drm/gpu_scheduler.h=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A02 files changed, 5 insertions(+)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/drivers/gpu/drm/scheduler/gpu_sc=
heduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 429b1328653a..3dc1a4f07e3f 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/drivers/gpu/drm/scheduler/gpu_scheduler=
.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/drivers/gpu/drm/scheduler/gpu_scheduler=
.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -538,6 +538,7 @@ void drm_sched_entity_pus=
h_job(struct drm_sched_job *sched_job,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_drm_sched_job=
(sched_job, entity);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0first =3D spsc_queu=
e_push(&amp;entity-&gt;job_queue, &amp;sched_job-&gt;queue_node);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0atomic_inc(&amp;entity-&=
gt;sched-&gt;num_jobs);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Shall we use hw_rq_count directly or merge them tog=
ether?<br>
&gt;<br>
&gt; hw_rq_count is the number of jobs that are currently in the hardware q=
ueue as compared to num_jobs which is the number of jobs in the software qu=
eue. num_jobs provides a give a better idea of the load<br>
&gt; on a scheduler that&#39;s why I added that field and used it to decide=
 the scheduler with the least load.<br>
<br>
Thanks for your explanation.<br>
<br>
Then may be more reasonable to move atomic_dec(&amp;sched-&gt;num_jobs) aft=
er drm_sched_fence_scheduled() or just before atomic_inc(&amp;sched-&gt;hw_=
rq_count).<br>
How do you think that?<br>
<br></blockquote><div>For now num_jobs also includes jobs that have been pu=
shed to the hardware queue. If I shift it before atomic_inc(&amp;sched-&gt;=
hw_rq_count) then I also need to handle cases when the job was reset and up=
date the counter properly. I went for the easier implementation as I felt t=
hat num_jobs will correctly represent the load on the scheduler. <br><br></=
div><div>But the idea that you suggested can be a potential improvement ove=
r what I have done.<br><br></div><div>Regards,<br></div><div>Nayan <br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
Regards,<br>
Jerry<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Nayan<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Jerry<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* first job wakes =
up scheduler */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (first) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -818,6 +819,7 @@ static void drm_sched_pro=
cess_job(struct dma_fence *f, struct dma_fence_cb *cb)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_get(&amp;=
s_fence-&gt;finished);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_dec(&amp;sch=
ed-&gt;hw_rq_count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0atomic_dec(&amp;sched-&g=
t;num_jobs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_sched_fence_fin=
ished(s_fence);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_drm_sched_pro=
cess_job(s_fence);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -935,6 +937,7 @@ int drm_sched_init(struct=
 drm_gpu_scheduler *sched,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_LIST_HEAD(&amp=
;sched-&gt;ring_mirror_list);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp=
;sched-&gt;job_list_lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_set(&amp;sch=
ed-&gt;hw_rq_count, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0atomic_set(&amp;sched-&g=
t;num_jobs, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_set(&amp;s=
ched-&gt;job_id_count, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Each scheduler w=
ill run on a seperate kernel thread */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/include/drm/gpu_scheduler.h b/in=
clude/drm/gpu_scheduler.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 43e93d6077cf..605bd4ad2397 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/include/drm/gpu_scheduler.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/include/drm/gpu_scheduler.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -257,6 +257,7 @@ struct drm_sched_backend_=
ops {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 * @job_list_lock: lock to protec=
t the ring_mirror_list.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 * @hang_limit: once the hangs by=
 a job crosses this limit then it is marked<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 guilty and it will be considered for scheduling further.<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * @num_jobs: the number of jobs in queue in=
 the scheduler<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 * One scheduler is implemented f=
or each hardware ring.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -274,6 +275,7 @@ struct drm_gpu_scheduler =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_mirror_list;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 job_l=
ist_lock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0hang_limit;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0atomic_t=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_j=
obs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0int drm_sched_init(struct drm_gpu=
_scheduler *sched,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;<br>
</blockquote></div></div>

--000000000000503fbd05726da61a--

--===============1027226986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1027226986==--
