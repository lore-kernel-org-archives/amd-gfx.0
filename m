From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: trace fence details in
 amdgpu_sched_run_job
Date: Sun, 26 Feb 2017 11:54:51 +0100
Message-ID: <2044a656-bdd4-25b7-0710-48d4a8ed11f9@vodafone.de>
References: <20170224182058.5810-1-andresx7@gmail.com>
 <20170224182058.5810-3-andresx7@gmail.com>
 <dbc8d447-2423-9524-4e38-e4b87022e4db@vodafone.de>
 <CAFQ_0eET-ydfJyFthnGOR-3-q9ZD8dev=C0eM1dfZHC8vpyXWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1445795069=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFQ_0eET-ydfJyFthnGOR-3-q9ZD8dev=C0eM1dfZHC8vpyXWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1445795069==
Content-Type: multipart/alternative;
 boundary="------------5AF12E15E1015B6E51B3CC87"

This is a multi-part message in MIME format.
--------------5AF12E15E1015B6E51B3CC87
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.02.2017 um 18:28 schrieb Andres Rodriguez:
>
>
> On Feb 25, 2017 4:40 AM, "Christian König" <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org 
> <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
>
>     Am 24.02.2017 um 19:20 schrieb Andres Rodriguez:
>
>         This information is intended to provide the required data to
>         associate
>         amdgpu tracepoints with their corresponding dma_fence_* events.
>
>         Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>         <mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>         ---
>           drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 11 +++++++++--
>           1 file changed, 9 insertions(+), 2 deletions(-)
>
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>         index 01623d1..cc9a31d 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>         @@ -130,6 +130,9 @@ TRACE_EVENT(amdgpu_sched_run_job,
>                                      __field(struct amd_sched_job *,
>         sched_job)
>                                      __field(struct amdgpu_ib *, ib)
>                                      __field(struct dma_fence *, fence)
>         +                            __string(timeline,
>         job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished))
>         +                            __field(unsigned int, context)
>         +                            __field(unsigned int, seqno)
>                                      __field(char *, ring_name)
>                                      __field(u32, num_ibs)
>                                      ),
>         @@ -139,12 +142,16 @@ TRACE_EVENT(amdgpu_sched_run_job,
>                                    __entry->sched_job = &job->base;
>                                    __entry->ib = job->ibs;
>                                    __entry->fence =
>         &job->base.s_fence->finished;
>         +                          __assign_str(timeline,
>         job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished))
>
>
>     Not 100% sure, but we might be able to use a char * field here
>     instead of the extra overhead of embedding a string, the timeline
>     names are never freed IIRC.
>
>
> I'll give this a try.
>
>
>
>         +                          __entry->context =
>         job->base.s_fence->finished.co <http://finished.co>ntext;
>         +                          __entry->seqno =
>         job->base.s_fence->finished.se <http://finished.se>qno;
>                                    __entry->ring_name = job->ring->name;
>                                    __entry->num_ibs = job->num_ibs;
>                                    ),
>         -           TP_printk("adev=%p, sched_job=%p, first ib=%p,
>         sched fence=%p, ring name=%s, num_ibs=%u",
>         +           TP_printk("adev=%p, sched_job=%p, first ib=%p,
>         sched fence=%p, timeline=%s, context=%u, seqno=%u, ring
>         name=%s, num_ibs=%u",
>
>
>     If you have time for another patch please drop the pinters here as
>     well. Scheduler job, IBs and fence are all heavily reallocated
>     (sometimes even with a slab allocator). So the pointers are
>     completely meaningless. The adev pointer is superseded by the
>     timeline name and context numbers.
>
>
> The pointers do provide some useful data. But you need to make sure 
> you read it in between an allocation event and a fence signal event. 
> It is extremely terrible for reading from a trace text file.

Yeah, that's why I try to avoid them in the trace files.

Additional to that the adev pointer is 8 bytes and pretty much 
meaningless in the trace file, but the PCI bus number is only 4 bytes 
IIRC and really easy to related to other log messages.

>
> How do you feel about if we replaced the job pointer with a job id, 
> and replaced the fence pointers with the fence data?

Mostly sounds like a plan to me. I would just try to get away from 
trying to use the job to identify a command submission.

Instead use the scheduler fence for this. The difference is that we 
create the job structure early during command submission, but the 
scheduler fence only when the command submission is actually 
successfully and not interrupted by a signal.

So a job id would contain a bunch of numbers which are never submitted. 
Especially for the X server that is usually rather annoying in the logs.

Regards,
Christian.

>
>     Anyway that should be done in an extra patch, so this one is
>     Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org
>     <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>>.
>
>     Regards,
>     Christian.
>
>
>                               __entry->adev, __entry->sched_job,
>         __entry->ib,
>         -                     __entry->fence, __entry->ring_name,
>         __entry->num_ibs)
>         +                     __entry->fence, __get_str(timeline),
>         __entry->context, __entry->seqno,
>         +                     __entry->ring_name, __entry->num_ibs)
>           );
>
>
>
>


--------------5AF12E15E1015B6E51B3CC87
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 25.02.2017 um 18:28 schrieb Andres
      Rodriguez:<br>
    </div>
    <blockquote
cite="mid:CAFQ_0eET-ydfJyFthnGOR-3-q9ZD8dev=C0eM1dfZHC8vpyXWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <div dir="auto">
        <div><br>
          <div class="gmail_extra"><br>
            <div class="gmail_quote">On Feb 25, 2017 4:40 AM, "Christian
              König" &lt;<a moz-do-not-send="true"
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;
              wrote:<br type="attribution">
              <blockquote class="quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                <div class="elided-text">Am 24.02.2017 um 19:20 schrieb
                  Andres Rodriguez:<br>
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    This information is intended to provide the required
                    data to associate<br>
                    amdgpu tracepoints with their corresponding
                    dma_fence_* events.<br>
                    <br>
                    Signed-off-by: Andres Rodriguez &lt;<a
                      moz-do-not-send="true"
                      href="mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target="_blank">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                    ---<br>
                      drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_trace.h |
                    11 +++++++++--<br>
                      1 file changed, 9 insertions(+), 2 deletions(-)<br>
                    <br>
                    diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_trace.h
                    b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_trace.h<br>
                    index 01623d1..cc9a31d 100644<br>
                    --- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_trace.h<br>
                    +++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_trace.h<br>
                    @@ -130,6 +130,9 @@ TRACE_EVENT(amdgpu_sched_run_j<wbr>ob,<br>
                                                 __field(struct
                    amd_sched_job *, sched_job)<br>
                                                 __field(struct
                    amdgpu_ib *, ib)<br>
                                                 __field(struct
                    dma_fence *, fence)<br>
                    +                            __string(timeline,
                    job-&gt;base.s_fence-&gt;finished.op<wbr>s-&gt;get_timeline_name(&amp;job-&gt;bas<wbr>e.s_fence-&gt;finished))<br>
                    +                            __field(unsigned int,
                    context)<br>
                    +                            __field(unsigned int,
                    seqno)<br>
                                                 __field(char *,
                    ring_name)<br>
                                                 __field(u32, num_ibs)<br>
                                                 ),<br>
                    @@ -139,12 +142,16 @@ TRACE_EVENT(amdgpu_sched_run_j<wbr>ob,<br>
                                               __entry-&gt;sched_job =
                    &amp;job-&gt;base;<br>
                                               __entry-&gt;ib =
                    job-&gt;ibs;<br>
                                               __entry-&gt;fence =
                    &amp;job-&gt;base.s_fence-&gt;finished;<br>
                    +                          __assign_str(timeline,
                    job-&gt;base.s_fence-&gt;finished.op<wbr>s-&gt;get_timeline_name(&amp;job-&gt;bas<wbr>e.s_fence-&gt;finished))<br>
                  </blockquote>
                  <br>
                </div>
                Not 100% sure, but we might be able to use a char *
                field here instead of the extra overhead of embedding a
                string, the timeline names are never freed IIRC.</blockquote>
            </div>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">I'll give this a try. </div>
        <div dir="auto">
          <div class="gmail_extra">
            <div class="gmail_quote">
              <blockquote class="quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                <div class="quoted-text"><br>
                  <br>
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    +                          __entry-&gt;context =
                    job-&gt;base.s_fence-&gt;<a moz-do-not-send="true"
                      href="http://finished.co">finished.co</a><wbr>ntext;<br>
                    +                          __entry-&gt;seqno =
                    job-&gt;base.s_fence-&gt;<a moz-do-not-send="true"
                      href="http://finished.se">finished.se</a><wbr>qno;<br>
                                               __entry-&gt;ring_name =
                    job-&gt;ring-&gt;name;<br>
                                               __entry-&gt;num_ibs =
                    job-&gt;num_ibs;<br>
                                               ),<br>
                    -           TP_printk("adev=%p, sched_job=%p, first
                    ib=%p, sched fence=%p, ring name=%s, num_ibs=%u",<br>
                    +           TP_printk("adev=%p, sched_job=%p, first
                    ib=%p, sched fence=%p, timeline=%s, context=%u,
                    seqno=%u, ring name=%s, num_ibs=%u",<br>
                  </blockquote>
                  <br>
                </div>
                If you have time for another patch please drop the
                pinters here as well. Scheduler job, IBs and fence are
                all heavily reallocated (sometimes even with a slab
                allocator). So the pointers are completely meaningless.
                The adev pointer is superseded by the timeline name and
                context numbers.<br>
              </blockquote>
            </div>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">The pointers do provide some useful data. But
          you need to make sure you read it in between an allocation
          event and a fence signal event. It is extremely terrible for
          reading from a trace text file. <br>
        </div>
      </div>
    </blockquote>
    <br>
    Yeah, that's why I try to avoid them in the trace files.<br>
    <br>
    Additional to that the adev pointer is 8 bytes and pretty much
    meaningless in the trace file, but the PCI bus number is only 4
    bytes IIRC and really easy to related to other log messages.<br>
    <br>
    <blockquote
cite="mid:CAFQ_0eET-ydfJyFthnGOR-3-q9ZD8dev=C0eM1dfZHC8vpyXWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <div dir="auto">
        <div dir="auto"><br>
        </div>
        <div dir="auto">How do you feel about if we replaced the job
          pointer with a job id, and replaced the fence pointers with
          the fence data? <br>
        </div>
      </div>
    </blockquote>
    <br>
    Mostly sounds like a plan to me. I would just try to get away from
    trying to use the job to identify a command submission.<br>
    <br>
    Instead use the scheduler fence for this. The difference is that we
    create the job structure early during command submission, but the
    scheduler fence only when the command submission is actually
    successfully and not interrupted by a signal.<br>
    <br>
    So a job id would contain a bunch of numbers which are never
    submitted. Especially for the X server that is usually rather
    annoying in the logs.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote
cite="mid:CAFQ_0eET-ydfJyFthnGOR-3-q9ZD8dev=C0eM1dfZHC8vpyXWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <div dir="auto">
        <div dir="auto"> </div>
        <div dir="auto">
          <div class="gmail_extra">
            <div class="gmail_quote">
              <blockquote class="quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                <br>
                Anyway that should be done in an extra patch, so this
                one is Reviewed-by: Christian König &lt;<a
                  moz-do-not-send="true"
                  href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target="_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;.<br>
                <br>
                Regards,<br>
                Christian.
                <div class="elided-text"><br>
                  <br>
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                                          __entry-&gt;adev,
                    __entry-&gt;sched_job, __entry-&gt;ib,<br>
                    -                     __entry-&gt;fence,
                    __entry-&gt;ring_name, __entry-&gt;num_ibs)<br>
                    +                     __entry-&gt;fence,
                    __get_str(timeline), __entry-&gt;context,
                    __entry-&gt;seqno,<br>
                    +                     __entry-&gt;ring_name,
                    __entry-&gt;num_ibs)<br>
                      );<br>
                        <br>
                  </blockquote>
                  <br>
                  <br>
                </div>
              </blockquote>
            </div>
            <br>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------5AF12E15E1015B6E51B3CC87--

--===============1445795069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1445795069==--
