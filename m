From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu trace event print string format
 error
Date: Wed, 16 Oct 2019 12:01:13 +0000
Message-ID: <MN2PR12MB329607EB61BBC2CB91F8972FA2920@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191016030606.6750-1-kevin1.wang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0724933026=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191016030606.6750-1-kevin1.wang-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0724933026==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329607EB61BBC2CB91F8972FA2920MN2PR12MB3296namp_"

--_000_MN2PR12MB329607EB61BBC2CB91F8972FA2920MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

add @Koenig, Christian<mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>,
could you help me review it?

Best Regards,
Kevin

________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 16, 2019 11:06 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix amdgpu trace event print string format err=
or

the trace event print string format error.
(use integer type to handle string)

before:
amdgpu_test_kev-1556  [002]   138.508781: amdgpu_cs_ioctl:
sched_job=3D8, timeline=3Dgfx_0.0.0, context=3D177, seqno=3D1,
ring_name=3Dffff94d01c207bf0, num_ibs=3D2

after:
amdgpu_test_kev-1506  [004]   370.703783: amdgpu_cs_ioctl:
sched_job=3D12, timeline=3Dgfx_0.0.0, context=3D234, seqno=3D2,
ring_name=3Dgfx_0.0.0, num_ibs=3D1

change trace event list:
1.amdgpu_cs_ioctl
2.amdgpu_sched_run_job
3.amdgpu_ib_pipe_sync

Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_trace.h
index 8227ebd0f511..f940526c5889 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -170,7 +170,7 @@ TRACE_EVENT(amdgpu_cs_ioctl,
                              __field(unsigned int, context)
                              __field(unsigned int, seqno)
                              __field(struct dma_fence *, fence)
-                            __field(char *, ring_name)
+                            __string(ring, to_amdgpu_ring(job->base.sched)=
->name)
                              __field(u32, num_ibs)
                              ),

@@ -179,12 +179,12 @@ TRACE_EVENT(amdgpu_cs_ioctl,
                            __assign_str(timeline, AMDGPU_JOB_GET_TIMELINE_=
NAME(job))
                            __entry->context =3D job->base.s_fence->finishe=
d.context;
                            __entry->seqno =3D job->base.s_fence->finished.=
seqno;
-                          __entry->ring_name =3D to_amdgpu_ring(job->base.=
sched)->name;
+                          __assign_str(ring, to_amdgpu_ring(job->base.sche=
d)->name)
                            __entry->num_ibs =3D job->num_ibs;
                            ),
             TP_printk("sched_job=3D%llu, timeline=3D%s, context=3D%u, seqn=
o=3D%u, ring_name=3D%s, num_ibs=3D%u",
                       __entry->sched_job_id, __get_str(timeline), __entry-=
>context,
-                     __entry->seqno, __entry->ring_name, __entry->num_ibs)
+                     __entry->seqno, __get_str(ring), __entry->num_ibs)
 );

 TRACE_EVENT(amdgpu_sched_run_job,
@@ -195,7 +195,7 @@ TRACE_EVENT(amdgpu_sched_run_job,
                              __string(timeline, AMDGPU_JOB_GET_TIMELINE_NA=
ME(job))
                              __field(unsigned int, context)
                              __field(unsigned int, seqno)
-                            __field(char *, ring_name)
+                            __string(ring, to_amdgpu_ring(job->base.sched)=
->name)
                              __field(u32, num_ibs)
                              ),

@@ -204,12 +204,12 @@ TRACE_EVENT(amdgpu_sched_run_job,
                            __assign_str(timeline, AMDGPU_JOB_GET_TIMELINE_=
NAME(job))
                            __entry->context =3D job->base.s_fence->finishe=
d.context;
                            __entry->seqno =3D job->base.s_fence->finished.=
seqno;
-                          __entry->ring_name =3D to_amdgpu_ring(job->base.=
sched)->name;
+                          __assign_str(ring, to_amdgpu_ring(job->base.sche=
d)->name)
                            __entry->num_ibs =3D job->num_ibs;
                            ),
             TP_printk("sched_job=3D%llu, timeline=3D%s, context=3D%u, seqn=
o=3D%u, ring_name=3D%s, num_ibs=3D%u",
                       __entry->sched_job_id, __get_str(timeline), __entry-=
>context,
-                     __entry->seqno, __entry->ring_name, __entry->num_ibs)
+                     __entry->seqno, __get_str(ring), __entry->num_ibs)
 );


@@ -473,7 +473,7 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
             TP_PROTO(struct amdgpu_job *sched_job, struct dma_fence *fence=
),
             TP_ARGS(sched_job, fence),
             TP_STRUCT__entry(
-                            __field(const char *,name)
+                            __string(ring, sched_job->base.sched->name);
                              __field(uint64_t, id)
                              __field(struct dma_fence *, fence)
                              __field(uint64_t, ctx)
@@ -481,14 +481,14 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
                              ),

             TP_fast_assign(
-                          __entry->name =3D sched_job->base.sched->name;
+                          __assign_str(ring, sched_job->base.sched->name)
                            __entry->id =3D sched_job->base.id;
                            __entry->fence =3D fence;
                            __entry->ctx =3D fence->context;
                            __entry->seqno =3D fence->seqno;
                            ),
             TP_printk("job ring=3D%s, id=3D%llu, need pipe sync to fence=
=3D%p, context=3D%llu, seq=3D%u",
-                     __entry->name, __entry->id,
+                     __get_str(ring), __entry->id,
                       __entry->fence, __entry->ctx,
                       __entry->seqno)
 );
--
2.17.1


--_000_MN2PR12MB329607EB61BBC2CB91F8972FA2920MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
add <a id=3D"OWAAM231809" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-n=
lr ms-fcl-b" href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">
@Koenig, Christian</a>,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
could you help me review it?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, October 16, 2019 11:06 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix amdgpu trace event print string for=
mat error</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">the trace event print string format error.<br>
(use integer type to handle string)<br>
<br>
before:<br>
amdgpu_test_kev-1556&nbsp; [002]&nbsp;&nbsp; 138.508781: amdgpu_cs_ioctl:<b=
r>
sched_job=3D8, timeline=3Dgfx_0.0.0, context=3D177, seqno=3D1,<br>
ring_name=3Dffff94d01c207bf0, num_ibs=3D2<br>
<br>
after:<br>
amdgpu_test_kev-1506&nbsp; [004]&nbsp;&nbsp; 370.703783: amdgpu_cs_ioctl:<b=
r>
sched_job=3D12, timeline=3Dgfx_0.0.0, context=3D234, seqno=3D2,<br>
ring_name=3Dgfx_0.0.0, num_ibs=3D1<br>
<br>
change trace event list:<br>
1.amdgpu_cs_ioctl<br>
2.amdgpu_sched_run_job<br>
3.amdgpu_ib_pipe_sync<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 18 &#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;1 file changed, 9 insertions(&#43;), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_trace.h<br>
index 8227ebd0f511..f940526c5889 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<br>
@@ -170,7 &#43;170,7 @@ TRACE_EVENT(amdgpu_cs_ioctl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __field(unsigned int, context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __field(unsigned int, seqno)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __field(struct dma_fence *, fence)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; __field(char *, ring_name)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; __string(ring, to_amdgpu_ring(job-&gt;base.sched)-&gt;nam=
e)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __field(u32, num_ibs)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ),<br>
&nbsp;<br>
@@ -179,12 &#43;179,12 @@ TRACE_EVENT(amdgpu_cs_ioctl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __assign_str(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(job))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __entry-&gt;context =3D job-&gt;base.s_fence-&gt;finished.cont=
ext;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __entry-&gt;seqno =3D job-&gt;base.s_fence-&gt;finished.seqno;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; __entry-&gt;ring_name =3D to_amdgpu_ring(job-&gt;base.sched)-&gt;name;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; __assign_str(ring, to_amdgpu_ring(job-&gt;base.sched)-&gt;name)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __entry-&gt;num_ibs =3D job-&gt;num_ibs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP=
_printk(&quot;sched_job=3D%llu, timeline=3D%s, context=3D%u, seqno=3D%u, ri=
ng_name=3D%s, num_ibs=3D%u&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;sched=
_job_id, __get_str(timeline), __entry-&gt;context,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;seqno, __entry-&=
gt;ring_name, __entry-&gt;num_ibs)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;seqno, __get=
_str(ring), __entry-&gt;num_ibs)<br>
&nbsp;);<br>
&nbsp;<br>
&nbsp;TRACE_EVENT(amdgpu_sched_run_job,<br>
@@ -195,7 &#43;195,7 @@ TRACE_EVENT(amdgpu_sched_run_job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __string(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(jo=
b))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __field(unsigned int, context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __field(unsigned int, seqno)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; __field(char *, ring_name)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; __string(ring, to_amdgpu_ring(job-&gt;base.sched)-&gt;nam=
e)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __field(u32, num_ibs)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ),<br>
&nbsp;<br>
@@ -204,12 &#43;204,12 @@ TRACE_EVENT(amdgpu_sched_run_job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __assign_str(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(job))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __entry-&gt;context =3D job-&gt;base.s_fence-&gt;finished.cont=
ext;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __entry-&gt;seqno =3D job-&gt;base.s_fence-&gt;finished.seqno;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; __entry-&gt;ring_name =3D to_amdgpu_ring(job-&gt;base.sched)-&gt;name;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; __assign_str(ring, to_amdgpu_ring(job-&gt;base.sched)-&gt;name)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __entry-&gt;num_ibs =3D job-&gt;num_ibs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP=
_printk(&quot;sched_job=3D%llu, timeline=3D%s, context=3D%u, seqno=3D%u, ri=
ng_name=3D%s, num_ibs=3D%u&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;sched=
_job_id, __get_str(timeline), __entry-&gt;context,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;seqno, __entry-&=
gt;ring_name, __entry-&gt;num_ibs)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;seqno, __get=
_str(ring), __entry-&gt;num_ibs)<br>
&nbsp;);<br>
&nbsp;<br>
&nbsp;<br>
@@ -473,7 &#43;473,7 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP=
_PROTO(struct amdgpu_job *sched_job, struct dma_fence *fence),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP=
_ARGS(sched_job, fence),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP=
_STRUCT__entry(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; __field(const char *,name)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; __string(ring, sched_job-&gt;base.sched-&gt;name);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __field(uint64_t, id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __field(struct dma_fence *, fence)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; __field(uint64_t, ctx)<br>
@@ -481,14 &#43;481,14 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ),<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP=
_fast_assign(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; __entry-&gt;name =3D sched_job-&gt;base.sched-&gt;name;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; __assign_str(ring, sched_job-&gt;base.sched-&gt;name)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __entry-&gt;id =3D sched_job-&gt;base.id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __entry-&gt;fence =3D fence;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __entry-&gt;ctx =3D fence-&gt;context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; __entry-&gt;seqno =3D fence-&gt;seqno;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP=
_printk(&quot;job ring=3D%s, id=3D%llu, need pipe sync to fence=3D%p, conte=
xt=3D%llu, seq=3D%u&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;name, __entry-&g=
t;id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __get_str(ring), __entry=
-&gt;id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;fence=
, __entry-&gt;ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __entry-&gt;seqno=
)<br>
&nbsp;);<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB329607EB61BBC2CB91F8972FA2920MN2PR12MB3296namp_--

--===============0724933026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0724933026==--
