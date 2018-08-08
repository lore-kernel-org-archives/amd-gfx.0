From: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the null pointer to get timeline by
 scheduler fence
Date: Wed, 8 Aug 2018 17:30:17 +0530
Message-ID: <CAFd4ddzbq5xLZUK6WfAS=hvjo8KaPbhwDxPV5jEkxUXMP3QN9Q@mail.gmail.com>
References: <1533711936-22450-1-git-send-email-ray.huang@amd.com>
 <91ac6260-1f17-12a9-80e9-50d78756bb87@amd.com>
 <20180808095226.GA11875@hr-amur2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1844959588=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180808095226.GA11875@hr-amur2>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1844959588==
Content-Type: multipart/alternative; boundary="0000000000001635d00572eb44a2"

--0000000000001635d00572eb44a2
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 8, 2018 at 4:58 PM Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org> wrote:

> On Wed, Aug 08, 2018 at 03:10:07PM +0800, Koenig, Christian wrote:
> > Yeah that is a known issue, but this solution is not correct either.
> >
> > See the scheduler where the job is execute on is simply not determined
> > yet when we want to trace it.
> >
> > So using the scheduler name from the entity is wrong as well.
> >
> > We should probably move the reschedule from drm_sched_entity_push_job()
> > to drm_sched_job_init() to fix that.
>
> Could you please explain why move reschedule along can fix the issue.
> Seemingly, only s_fence's sched is written to entity rq's sched, it can
> avoid the issue.
>
> sched_job->s_fence->sched = entity->rq->sched
>
> Because entity->rq->sched may not necessarily be the scheduler on which
this job will get scheduled. And assigning a wrong scheduler could lead to
wrong dependency optimizations. Hence it was assigned NULL initially we
don't know scheduler it will be scheduled on to avoid any wrong
optimizations.

Cheers,
Nayan

> Thanks,
> Ray
>
> >
> > I will prepare a patch for that today,
> > Christian.
> >
> > Am 08.08.2018 um 09:05 schrieb Huang Rui:
> > > We won't initialize fence scheduler in drm_sched_fence_create()
> anymore, so it
> > > will refer null fence scheduler if open trace event to get the
> timeline name.
> > > Actually, it is the scheduler name from the entity, so add a macro to
> replace
> > > legacy getting timeline name by job.
> > >
> > > [  212.844281] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000018
> > > [  212.852401] PGD 8000000427c13067 P4D 8000000427c13067 PUD 4235fc067
> PMD 0
> > > [  212.859419] Oops: 0000 [#1] SMP PTI
> > > [  212.862981] CPU: 4 PID: 1520 Comm: amdgpu_test Tainted: G
>  OE     4.18.0-rc1-custom #1
> > > [  212.872194] Hardware name: Gigabyte Technology Co., Ltd.
> Z170XP-SLI/Z170XP-SLI-CF, BIOS F20 11/04/2016
> > > [  212.881704] RIP: 0010:drm_sched_fence_get_timeline_name+0x2b/0x30
> [gpu_sched]
> > > [  212.888948] Code: 1f 44 00 00 48 8b 47 08 48 3d c0 b1 4f c0 74 13
> 48 83 ef 60 48 3d 60 b1 4f c0 b8 00 00 00 00 48 0f 45 f8 48 8b 87 e0 00 00
> 00 <48> 8b 40 18 c3 0f 1f 44 00 00 b8 01 00 00 00 c3 0f 1f 44 00 00 0f
> > > [  212.908162] RSP: 0018:ffffa3ed81f27af0 EFLAGS: 00010246
> > > [  212.913483] RAX: 0000000000000000 RBX: 0000000000070034 RCX:
> ffffa3ed81f27da8
> > > [  212.920735] RDX: ffff8f24ebfb5460 RSI: ffff8f24e40d3c00 RDI:
> ffff8f24ebfb5400
> > > [  212.928008] RBP: ffff8f24e40d3c00 R08: 0000000000000000 R09:
> ffffffffae4deafc
> > > [  212.935263] R10: ffffffffada000ed R11: 0000000000000001 R12:
> ffff8f24e891f898
> > > [  212.942558] R13: 0000000000000000 R14: ffff8f24ebc46000 R15:
> ffff8f24e3de97a8
> > > [  212.949796] FS:  00007ffff7fd2700(0000) GS:ffff8f24fed00000(0000)
> knlGS:0000000000000000
> > > [  212.958047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  212.963921] CR2: 0000000000000018 CR3: 0000000423422003 CR4:
> 00000000003606e0
> > > [  212.971201] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> > > [  212.978482] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> > > [  212.985720] Call Trace:
> > > [  212.988236]  trace_event_raw_event_amdgpu_cs_ioctl+0x4c/0x170
> [amdgpu]
> > > [  212.994904]  ? amdgpu_ctx_add_fence+0xa9/0x110 [amdgpu]
> > > [  213.000246]  ? amdgpu_job_free_resources+0x4b/0x70 [amdgpu]
> > > [  213.005944]  amdgpu_cs_ioctl+0x16d1/0x1b50 [amdgpu]
> > > [  213.010920]  ? amdgpu_cs_find_mapping+0xf0/0xf0 [amdgpu]
> > > [  213.016354]  drm_ioctl_kernel+0x8a/0xd0 [drm]
> > > [  213.020794]  ? recalc_sigpending+0x17/0x50
> > > [  213.024965]  drm_ioctl+0x2d7/0x390 [drm]
> > > [  213.028979]  ? amdgpu_cs_find_mapping+0xf0/0xf0 [amdgpu]
> > > [  213.034366]  ? do_signal+0x36/0x700
> > > [  213.037928]  ? signal_wake_up_state+0x15/0x30
> > > [  213.042375]  amdgpu_drm_ioctl+0x46/0x80 [amdgpu]
> > >
> > > Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c    |  2 +-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 10 ++++++----
> > >   2 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > index e12871d..be01e1b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > @@ -1247,7 +1247,7 @@ static int amdgpu_cs_submit(struct
> amdgpu_cs_parser *p,
> > >
> > >     amdgpu_job_free_resources(job);
> > >
> > > -   trace_amdgpu_cs_ioctl(job);
> > > +   trace_amdgpu_cs_ioctl(job, entity);
> > >     amdgpu_vm_bo_trace_cs(&fpriv->vm, &p->ticket);
> > >     priority = job->base.s_priority;
> > >     drm_sched_entity_push_job(&job->base, entity);
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > > index 8c2dab2..25cdcb7 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> > > @@ -36,6 +36,8 @@
> > >
> > >   #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
> > >
> job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished)
> > > +#define AMDGPU_GET_SCHED_NAME(entity) \
> > > +    (entity->rq->sched->name)
> > >
> > >   TRACE_EVENT(amdgpu_mm_rreg,
> > >         TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
> > > @@ -161,11 +163,11 @@ TRACE_EVENT(amdgpu_cs,
> > >   );
> > >
> > >   TRACE_EVENT(amdgpu_cs_ioctl,
> > > -       TP_PROTO(struct amdgpu_job *job),
> > > -       TP_ARGS(job),
> > > +       TP_PROTO(struct amdgpu_job *job, struct drm_sched_entity
> *entity),
> > > +       TP_ARGS(job, entity),
> > >         TP_STRUCT__entry(
> > >                          __field(uint64_t, sched_job_id)
> > > -                        __string(timeline,
> AMDGPU_JOB_GET_TIMELINE_NAME(job))
> > > +                        __string(timeline,
> AMDGPU_GET_SCHED_NAME(entity))
> > >                          __field(unsigned int, context)
> > >                          __field(unsigned int, seqno)
> > >                          __field(struct dma_fence *, fence)
> > > @@ -175,7 +177,7 @@ TRACE_EVENT(amdgpu_cs_ioctl,
> > >
> > >         TP_fast_assign(
> > >                        __entry->sched_job_id = job->base.id;
> > > -                      __assign_str(timeline,
> AMDGPU_JOB_GET_TIMELINE_NAME(job))
> > > +                      __assign_str(timeline,
> AMDGPU_GET_SCHED_NAME(entity))
> > >                        __entry->context =
> job->base.s_fence->finished.context;
> > >                        __entry->seqno =
> job->base.s_fence->finished.seqno;
> > >                        __entry->ring_name =
> to_amdgpu_ring(job->base.sched)->name;
> >
>

--0000000000001635d00572eb44a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed=
, Aug 8, 2018 at 4:58 PM Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org"=
>ray.huang-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">O=
n Wed, Aug 08, 2018 at 03:10:07PM +0800, Koenig, Christian wrote:<br>
&gt; Yeah that is a known issue, but this solution is not correct either.<b=
r>
&gt; <br>
&gt; See the scheduler where the job is execute on is simply not determined=
 <br>
&gt; yet when we want to trace it.<br>
&gt; <br>
&gt; So using the scheduler name from the entity is wrong as well.<br>
&gt; <br>
&gt; We should probably move the reschedule from drm_sched_entity_push_job(=
) <br>
&gt; to drm_sched_job_init() to fix that.<br>
<br>
Could you please explain why move reschedule along can fix the issue.<br>
Seemingly, only s_fence&#39;s sched is written to entity rq&#39;s sched, it=
 can<br>
avoid the issue.<br>
<br>
sched_job-&gt;s_fence-&gt;sched =3D entity-&gt;rq-&gt;sched<br>
<br></blockquote><div>Because entity-&gt;rq-&gt;sched may not necessarily b=
e the scheduler on which this job will get scheduled. And assigning a wrong=
 scheduler could lead to wrong dependency optimizations. Hence it was assig=
ned NULL initially we don&#39;t know scheduler it will be scheduled on to a=
void any wrong optimizations.<br><br></div><div>Cheers,<br></div><div>Nayan=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
Thanks,<br>
Ray<br>
<br>
&gt; <br>
&gt; I will prepare a patch for that today,<br>
&gt; Christian.<br>
&gt; <br>
&gt; Am 08.08.2018 um 09:05 schrieb Huang Rui:<br>
&gt; &gt; We won&#39;t initialize fence scheduler in drm_sched_fence_create=
() anymore, so it<br>
&gt; &gt; will refer null fence scheduler if open trace event to get the ti=
meline name.<br>
&gt; &gt; Actually, it is the scheduler name from the entity, so add a macr=
o to replace<br>
&gt; &gt; legacy getting timeline name by job.<br>
&gt; &gt;<br>
&gt; &gt; [=C2=A0 212.844281] BUG: unable to handle kernel NULL pointer der=
eference at 0000000000000018<br>
&gt; &gt; [=C2=A0 212.852401] PGD 8000000427c13067 P4D 8000000427c13067 PUD=
 4235fc067 PMD 0<br>
&gt; &gt; [=C2=A0 212.859419] Oops: 0000 [#1] SMP PTI<br>
&gt; &gt; [=C2=A0 212.862981] CPU: 4 PID: 1520 Comm: amdgpu_test Tainted: G=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OE=C2=A0 =C2=A0 =C2=A04.18.0-rc1-c=
ustom #1<br>
&gt; &gt; [=C2=A0 212.872194] Hardware name: Gigabyte Technology Co., Ltd. =
Z170XP-SLI/Z170XP-SLI-CF, BIOS F20 11/04/2016<br>
&gt; &gt; [=C2=A0 212.881704] RIP: 0010:drm_sched_fence_get_timeline_name+0=
x2b/0x30 [gpu_sched]<br>
&gt; &gt; [=C2=A0 212.888948] Code: 1f 44 00 00 48 8b 47 08 48 3d c0 b1 4f =
c0 74 13 48 83 ef 60 48 3d 60 b1 4f c0 b8 00 00 00 00 48 0f 45 f8 48 8b 87 =
e0 00 00 00 &lt;48&gt; 8b 40 18 c3 0f 1f 44 00 00 b8 01 00 00 00 c3 0f 1f 4=
4 00 00 0f<br>
&gt; &gt; [=C2=A0 212.908162] RSP: 0018:ffffa3ed81f27af0 EFLAGS: 00010246<b=
r>
&gt; &gt; [=C2=A0 212.913483] RAX: 0000000000000000 RBX: 0000000000070034 R=
CX: ffffa3ed81f27da8<br>
&gt; &gt; [=C2=A0 212.920735] RDX: ffff8f24ebfb5460 RSI: ffff8f24e40d3c00 R=
DI: ffff8f24ebfb5400<br>
&gt; &gt; [=C2=A0 212.928008] RBP: ffff8f24e40d3c00 R08: 0000000000000000 R=
09: ffffffffae4deafc<br>
&gt; &gt; [=C2=A0 212.935263] R10: ffffffffada000ed R11: 0000000000000001 R=
12: ffff8f24e891f898<br>
&gt; &gt; [=C2=A0 212.942558] R13: 0000000000000000 R14: ffff8f24ebc46000 R=
15: ffff8f24e3de97a8<br>
&gt; &gt; [=C2=A0 212.949796] FS:=C2=A0 00007ffff7fd2700(0000) GS:ffff8f24f=
ed00000(0000) knlGS:0000000000000000<br>
&gt; &gt; [=C2=A0 212.958047] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033<br>
&gt; &gt; [=C2=A0 212.963921] CR2: 0000000000000018 CR3: 0000000423422003 C=
R4: 00000000003606e0<br>
&gt; &gt; [=C2=A0 212.971201] DR0: 0000000000000000 DR1: 0000000000000000 D=
R2: 0000000000000000<br>
&gt; &gt; [=C2=A0 212.978482] DR3: 0000000000000000 DR6: 00000000fffe0ff0 D=
R7: 0000000000000400<br>
&gt; &gt; [=C2=A0 212.985720] Call Trace:<br>
&gt; &gt; [=C2=A0 212.988236]=C2=A0 trace_event_raw_event_amdgpu_cs_ioctl+0=
x4c/0x170 [amdgpu]<br>
&gt; &gt; [=C2=A0 212.994904]=C2=A0 ? amdgpu_ctx_add_fence+0xa9/0x110 [amdg=
pu]<br>
&gt; &gt; [=C2=A0 213.000246]=C2=A0 ? amdgpu_job_free_resources+0x4b/0x70 [=
amdgpu]<br>
&gt; &gt; [=C2=A0 213.005944]=C2=A0 amdgpu_cs_ioctl+0x16d1/0x1b50 [amdgpu]<=
br>
&gt; &gt; [=C2=A0 213.010920]=C2=A0 ? amdgpu_cs_find_mapping+0xf0/0xf0 [amd=
gpu]<br>
&gt; &gt; [=C2=A0 213.016354]=C2=A0 drm_ioctl_kernel+0x8a/0xd0 [drm]<br>
&gt; &gt; [=C2=A0 213.020794]=C2=A0 ? recalc_sigpending+0x17/0x50<br>
&gt; &gt; [=C2=A0 213.024965]=C2=A0 drm_ioctl+0x2d7/0x390 [drm]<br>
&gt; &gt; [=C2=A0 213.028979]=C2=A0 ? amdgpu_cs_find_mapping+0xf0/0xf0 [amd=
gpu]<br>
&gt; &gt; [=C2=A0 213.034366]=C2=A0 ? do_signal+0x36/0x700<br>
&gt; &gt; [=C2=A0 213.037928]=C2=A0 ? signal_wake_up_state+0x15/0x30<br>
&gt; &gt; [=C2=A0 213.042375]=C2=A0 amdgpu_drm_ioctl+0x46/0x80 [amdgpu]<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org"=
>ray.huang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
&gt; &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 10 ++++++=
----<br>
&gt; &gt;=C2=A0 =C2=A02 files changed, 7 insertions(+), 5 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &gt; index e12871d..be01e1b 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &gt; @@ -1247,7 +1247,7 @@ static int amdgpu_cs_submit(struct amdgpu_c=
s_parser *p,<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0amdgpu_job_free_resources(job);<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt; -=C2=A0 =C2=A0trace_amdgpu_cs_ioctl(job);<br>
&gt; &gt; +=C2=A0 =C2=A0trace_amdgpu_cs_ioctl(job, entity);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0amdgpu_vm_bo_trace_cs(&amp;fpriv-&gt;vm, &amp;=
p-&gt;ticket);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0priority =3D job-&gt;base.s_priority;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0drm_sched_entity_push_job(&amp;job-&gt;base, e=
ntity);<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&gt; &gt; index 8c2dab2..25cdcb7 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&gt; &gt; @@ -36,6 +36,8 @@<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt;=C2=A0 =C2=A0#define AMDGPU_JOB_GET_TIMELINE_NAME(job) \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 job-&gt;base.s_fence-&gt;finished.ops-&gt;get=
_timeline_name(&amp;job-&gt;base.s_fence-&gt;finished)<br>
&gt; &gt; +#define AMDGPU_GET_SCHED_NAME(entity) \<br>
&gt; &gt; +=C2=A0 =C2=A0 (entity-&gt;rq-&gt;sched-&gt;name)<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt;=C2=A0 =C2=A0TRACE_EVENT(amdgpu_mm_rreg,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_PROTO(unsigned did, uint32_t =
reg, uint32_t value),<br>
&gt; &gt; @@ -161,11 +163,11 @@ TRACE_EVENT(amdgpu_cs,<br>
&gt; &gt;=C2=A0 =C2=A0);<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt;=C2=A0 =C2=A0TRACE_EVENT(amdgpu_cs_ioctl,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0TP_PROTO(struct amdgpu_job *job),<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0TP_ARGS(job),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0TP_PROTO(struct amdgpu_job *job, stru=
ct drm_sched_entity *entity),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0TP_ARGS(job, entity),<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_STRUCT__entry(<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __field(uint64_t, sched_job_id)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 __string(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(job))<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 __string(timeline, AMDGPU_GET_SCHED_NAME(entity))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __field(unsigned int, context)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __field(unsigned int, seqno)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __field(struct dma_fence *, fence)<br>
&gt; &gt; @@ -175,7 +177,7 @@ TRACE_EVENT(amdgpu_cs_ioctl,<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_fast_assign(<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __entry-&gt;sched_job_id =3D job-&gt;<a href=3D"http://ba=
se.id" rel=3D"noreferrer">base.id</a>;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 __assign_str(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(job))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 __assign_str(timeline, AMDGPU_GET_SCHED_NAME(entity))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __entry-&gt;context =3D job-&gt;base.s_fence-&gt;finished=
.context;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __entry-&gt;seqno =3D job-&gt;base.s_fence-&gt;finished.s=
eqno;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __entry-&gt;ring_name =3D to_amdgpu_ring(job-&gt;base.sch=
ed)-&gt;name;<br>
&gt; <br>
</blockquote></div></div>

--0000000000001635d00572eb44a2--

--===============1844959588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1844959588==--
