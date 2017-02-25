From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: trace fence details in
 amdgpu_sched_run_job
Date: Sat, 25 Feb 2017 12:28:14 -0500
Message-ID: <CAFQ_0eET-ydfJyFthnGOR-3-q9ZD8dev=C0eM1dfZHC8vpyXWQ@mail.gmail.com>
References: <20170224182058.5810-1-andresx7@gmail.com>
 <20170224182058.5810-3-andresx7@gmail.com>
 <dbc8d447-2423-9524-4e38-e4b87022e4db@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0320773946=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <dbc8d447-2423-9524-4e38-e4b87022e4db-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0320773946==
Content-Type: multipart/alternative; boundary=f403043532e8dca5e105495e2b56

--f403043532e8dca5e105495e2b56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Feb 25, 2017 4:40 AM, "Christian K=C3=B6nig" <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> w=
rote:

Am 24.02.2017 um 19:20 schrieb Andres Rodriguez:

> This information is intended to provide the required data to associate
> amdgpu tracepoints with their corresponding dma_fence_* events.
>
> Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 01623d1..cc9a31d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -130,6 +130,9 @@ TRACE_EVENT(amdgpu_sched_run_job,
>                              __field(struct amd_sched_job *, sched_job)
>                              __field(struct amdgpu_ib *, ib)
>                              __field(struct dma_fence *, fence)
> +                            __string(timeline,
> job->base.s_fence->finished.ops->get_timeline_name(&job->bas
> e.s_fence->finished))
> +                            __field(unsigned int, context)
> +                            __field(unsigned int, seqno)
>                              __field(char *, ring_name)
>                              __field(u32, num_ibs)
>                              ),
> @@ -139,12 +142,16 @@ TRACE_EVENT(amdgpu_sched_run_job,
>                            __entry->sched_job =3D &job->base;
>                            __entry->ib =3D job->ibs;
>                            __entry->fence =3D &job->base.s_fence->finishe=
d;
> +                          __assign_str(timeline,
> job->base.s_fence->finished.ops->get_timeline_name(&job->bas
> e.s_fence->finished))
>

Not 100% sure, but we might be able to use a char * field here instead of
the extra overhead of embedding a string, the timeline names are never
freed IIRC.


I'll give this a try.



+                          __entry->context =3D job->base.s_fence->finished=
.co
> ntext;
> +                          __entry->seqno =3D job->base.s_fence->finished=
.se
> qno;
>                            __entry->ring_name =3D job->ring->name;
>                            __entry->num_ibs =3D job->num_ibs;
>                            ),
> -           TP_printk("adev=3D%p, sched_job=3D%p, first ib=3D%p, sched fe=
nce=3D%p,
> ring name=3D%s, num_ibs=3D%u",
> +           TP_printk("adev=3D%p, sched_job=3D%p, first ib=3D%p, sched fe=
nce=3D%p,
> timeline=3D%s, context=3D%u, seqno=3D%u, ring name=3D%s, num_ibs=3D%u",
>

If you have time for another patch please drop the pinters here as well.
Scheduler job, IBs and fence are all heavily reallocated (sometimes even
with a slab allocator). So the pointers are completely meaningless. The
adev pointer is superseded by the timeline name and context numbers.


The pointers do provide some useful data. But you need to make sure you
read it in between an allocation event and a fence signal event. It is
extremely terrible for reading from a trace text file.

How do you feel about if we replaced the job pointer with a job id, and
replaced the fence pointers with the fence data?



Anyway that should be done in an extra patch, so this one is Reviewed-by:
Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Regards,
Christian.


                      __entry->adev, __entry->sched_job, __entry->ib,
> -                     __entry->fence, __entry->ring_name, __entry->num_ib=
s)
> +                     __entry->fence, __get_str(timeline),
> __entry->context, __entry->seqno,
> +                     __entry->ring_name, __entry->num_ibs)
>   );
>
>

--f403043532e8dca5e105495e2b56
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Feb 25, 2017 4:40 AM, &quot;Christian K=C3=B6nig&quot; &lt;<a =
href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; wro=
te:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"elided-t=
ext">Am 24.02.2017 um 19:20 schrieb Andres Rodriguez:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
This information is intended to provide the required data to associate<br>
amdgpu tracepoints with their corresponding dma_fence_* events.<br>
<br>
Signed-off-by: Andres Rodriguez &lt;<a href=3D"mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" t=
arget=3D"_blank">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_trace.h | 11 +++++++++--<br>
=C2=A0 1 file changed, 9 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_trace.h b/drivers/gpu/d=
rm/amd/amdgpu/a<wbr>mdgpu_trace.h<br>
index 01623d1..cc9a31d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_trace.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_trace.h<br>
@@ -130,6 +130,9 @@ TRACE_EVENT(amdgpu_sched_run_j<wbr>ob,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__field(struct amd_sched_job *, sched_job)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__field(struct amdgpu_ib *, ib)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__field(struct dma_fence *, fence)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __string(timeline, job-&gt;base.s_fence-&gt;finish=
ed.op<wbr>s-&gt;get_timeline_name(&amp;job-&gt;bas<wbr>e.s_fence-&gt;finish=
ed))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __field(unsigned int, context)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 __field(unsigned int, seqno)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__field(char *, ring_name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__field(u32, num_ibs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0),<br>
@@ -139,12 +142,16 @@ TRACE_EVENT(amdgpu_sched_run_j<wbr>ob,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__entry-&gt;sched_job =3D &amp;job-&gt;base;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__entry-&gt;ib =3D job-&gt;ibs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__entry-&gt;fence =3D &amp;job-&gt;base.s_fence-&gt=
;finished;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __assign_str(timeline, job-&gt;base.s_fence-&gt;finished.=
op<wbr>s-&gt;get_timeline_name(&amp;job-&gt;bas<wbr>e.s_fence-&gt;finished)=
)<br>
</blockquote>
<br></div>
Not 100% sure, but we might be able to use a char * field here instead of t=
he extra overhead of embedding a string, the timeline names are never freed=
 IIRC.</blockquote></div></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"></div><div dir=3D"auto">I&#39;ll give this a try.=C2=A0</div><div=
 dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockq=
uote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div class=3D"quoted-text"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __entry-&gt;context =3D job-&gt;base.s_fence-&gt;<a href=
=3D"http://finished.co">finished.co</a><wbr>ntext;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __entry-&gt;seqno =3D job-&gt;base.s_fence-&gt;<a href=3D=
"http://finished.se">finished.se</a><wbr>qno;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__entry-&gt;ring_name =3D job-&gt;ring-&gt;name;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__entry-&gt;num_ibs =3D job-&gt;num_ibs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_printk(&quot;adev=3D%p, sched_=
job=3D%p, first ib=3D%p, sched fence=3D%p, ring name=3D%s, num_ibs=3D%u&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_printk(&quot;adev=3D%p, sched_=
job=3D%p, first ib=3D%p, sched fence=3D%p, timeline=3D%s, context=3D%u, seq=
no=3D%u, ring name=3D%s, num_ibs=3D%u&quot;,<br>
</blockquote>
<br></div>
If you have time for another patch please drop the pinters here as well. Sc=
heduler job, IBs and fence are all heavily reallocated (sometimes even with=
 a slab allocator). So the pointers are completely meaningless. The adev po=
inter is superseded by the timeline name and context numbers.<br></blockquo=
te></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">The poin=
ters do provide some useful data. But you need to make sure you read it in =
between an allocation event and a fence signal event. It is extremely terri=
ble for reading from a trace text file.=C2=A0</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">How do you feel about if we replaced the job pointer =
with a job id, and replaced the fence pointers with the fence data?=C2=A0</=
div><div dir=3D"auto">=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_ext=
ra"><div class=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Anyway that should be done in an extra patch, so this one is Reviewed-by: C=
hristian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;.<br>
<br>
Regards,<br>
Christian.<div class=3D"elided-text"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __entry-&gt;adev, __entry-&gt;sched_job, __entry-&gt;ib,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__entry-&gt;fence, __entry-&gt;ring_name, __entry-&gt;num_ibs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__entry-&gt;fence, __get_str(timeline), __entry-&gt;context, __entry-&gt=
;seqno,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__entry-&gt;ring_name, __entry-&gt;num_ibs)<br>
=C2=A0 );<br>
=C2=A0 =C2=A0 <br>
</blockquote>
<br>
<br>
</div></blockquote></div><br></div></div></div>

--f403043532e8dca5e105495e2b56--

--===============0320773946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0320773946==--
