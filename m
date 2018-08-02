From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/scheduler: add new function to get least loaded
 sched v2
Date: Thu, 2 Aug 2018 14:42:58 +0800
Message-ID: <823db5d9-ec03-7469-0746-a5d9b521d933@amd.com>
References: <20180801082002.20696-1-nayan26deshmukh@gmail.com>
 <20180801082002.20696-3-nayan26deshmukh@gmail.com>
 <dde1b549-df1b-e156-1e96-ddfe4beca446@amd.com>
 <CAFd4ddx8D2iKquRu4YVh1gnRMpLFgWf3CBPdk5SD-nJ8dNXEPQ@mail.gmail.com>
 <BY1PR12MB050215C66BE529F1FB94F373B42C0@BY1PR12MB0502.namprd12.prod.outlook.com>
 <CAFd4ddyf=EhJ7pmzq3sEGa6U1sQ7Ga7fUH+sW+VKeBxJABjnKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0886574305=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFd4ddyf=EhJ7pmzq3sEGa6U1sQ7Ga7fUH+sW+VKeBxJABjnKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David1.Zhou-5C7GfCeVMHo@public.gmane.org
Cc: Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0886574305==
Content-Type: multipart/alternative;
	boundary="------------3338382B526B0F53E4633636"
Content-Language: en-US

--------------3338382B526B0F53E4633636
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年08月02日 14:01, Nayan Deshmukh wrote:
> Hi David,
>
> On Thu, Aug 2, 2018 at 8:22 AM Zhou, David(ChunMing) 
> <David1.Zhou-5C7GfCeVMHo@public.gmane.org <mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>     Another big question:
>
>     I agree the general idea is good to balance scheduler load for
>     same ring family.
>
>     But, when same entity job run on different scheduler, that means
>     the later job could be completed ahead of front, Right?
>
> Really good question. To avoid this senario we do not move an entity 
> which already has a job in the hardware queue. We only move entities 
> whose last_scheduled fence has been signalled which means that the 
> last submitted job of this entity has finished executing.
Good handling I missed when reviewing them.

Cheers,
David Zhou
>
> Moving an entity which already has a job in the hardware queue will 
> hinder the dependency optimization that we are using and hence will 
> not anyway lead to a better performance. I have talked about the issue 
> in more detail here [1]. Please let me know if you have any more 
> doubts regarding this.
>
> Cheers,
> Nayan
>
> [1] 
> http://ndesh26.github.io/gsoc/2018/06/14/GSoC-Update-A-Curious-Case-of-Dependency-Handling/
>
>     That will break fence design, later fence must be signaled after
>     front fence in same fence context.
>
>     Anything I missed?
>
>     Regards,
>
>     David Zhou
>
>     *From:* dri-devel <dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> *On Behalf Of
>     *Nayan Deshmukh
>     *Sent:* Thursday, August 02, 2018 12:07 AM
>     *To:* Grodzovsky, Andrey <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org
>     <mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>>
>     *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Maling list - DRI
>     developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>; Koenig, Christian
>     <Christian.Koenig-5C7GfCeVMHo@public.gmane.org <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>>
>     *Subject:* Re: [PATCH 3/4] drm/scheduler: add new function to get
>     least loaded sched v2
>
>     Yes, that is correct.
>
>     Nayan
>
>     On Wed, Aug 1, 2018, 9:05 PM Andrey Grodzovsky
>     <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org <mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>         Clarification question -  if the run queues belong to different
>         schedulers they effectively point to different rings,
>
>         it means we allow to move (reschedule) a drm_sched_entity from
>         one ring
>         to another - i assume that the idea int the first place, that
>
>         you have a set of HW rings and you can utilize any of them for
>         your jobs
>         (like compute rings). Correct ?
>
>         Andrey
>
>
>         On 08/01/2018 04:20 AM, Nayan Deshmukh wrote:
>         > The function selects the run queue from the rq_list with the
>         > least load. The load is decided by the number of jobs in a
>         > scheduler.
>         >
>         > v2: avoid using atomic read twice consecutively, instead store
>         >      it locally
>         >
>         > Signed-off-by: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>         <mailto:nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>         > ---
>         >   drivers/gpu/drm/scheduler/gpu_scheduler.c | 25
>         +++++++++++++++++++++++++
>         >   1 file changed, 25 insertions(+)
>         >
>         > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>         b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>         > index 375f6f7f6a93..fb4e542660b0 100644
>         > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>         > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>         > @@ -255,6 +255,31 @@ static bool
>         drm_sched_entity_is_ready(struct drm_sched_entity *entity)
>         >       return true;
>         >   }
>         >
>         > +/**
>         > + * drm_sched_entity_get_free_sched - Get the rq from
>         rq_list with least load
>         > + *
>         > + * @entity: scheduler entity
>         > + *
>         > + * Return the pointer to the rq with least load.
>         > + */
>         > +static struct drm_sched_rq *
>         > +drm_sched_entity_get_free_sched(struct drm_sched_entity
>         *entity)
>         > +{
>         > +     struct drm_sched_rq *rq = NULL;
>         > +     unsigned int min_jobs = UINT_MAX, num_jobs;
>         > +     int i;
>         > +
>         > +     for (i = 0; i < entity->num_rq_list; ++i) {
>         > +             num_jobs =
>         atomic_read(&entity->rq_list[i]->sched->num_jobs);
>         > +             if (num_jobs < min_jobs) {
>         > +                     min_jobs = num_jobs;
>         > +                     rq = entity->rq_list[i];
>         > +             }
>         > +     }
>         > +
>         > +     return rq;
>         > +}
>         > +
>         >   static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>         >                                   struct dma_fence_cb *cb)
>         >   {
>


--------------3338382B526B0F53E4633636
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018年08月02日 14:01, Nayan Deshmukh
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAFd4ddyf=EhJ7pmzq3sEGa6U1sQ7Ga7fUH+sW+VKeBxJABjnKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">Hi David,<br>
        <div><br>
          <div class="gmail_quote">
            <div dir="ltr">On Thu, Aug 2, 2018 at 8:22 AM Zhou,
              David(ChunMing) &lt;<a href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org"
                moz-do-not-send="true">David1.Zhou-5C7GfCeVMHo@public.gmane.org</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div lang="EN-US">
                <div class="gmail-m_963201938271036718WordSection1">
                  <p class="MsoNormal">Another big question:</p>
                  <p class="MsoNormal">I agree the general idea is good
                    to balance scheduler load for same ring family.</p>
                  <p class="MsoNormal">But, when same entity job run on
                    different scheduler, that means the later job could
                    be completed ahead of front, Right?</p>
                </div>
              </div>
            </blockquote>
            <div>Really good question. To avoid this senario we do not
              move an entity which already has a job in the hardware
              queue. We only move entities whose last_scheduled fence
              has been signalled which means that the last submitted job
              of this entity has finished executing. <br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    Good handling I missed when reviewing them.<br>
    <br>
    Cheers,<br>
    David Zhou<br>
    <blockquote type="cite"
cite="mid:CAFd4ddyf=EhJ7pmzq3sEGa6U1sQ7Ga7fUH+sW+VKeBxJABjnKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div>
          <div class="gmail_quote">
            <div><br>
            </div>
            <div>Moving an entity which already has a job in the
              hardware queue will hinder the dependency optimization
              that we are using and hence will not anyway lead to a
              better performance. I have talked about the issue in more
              detail here [1]. Please let me know if you have any more
              doubts regarding this.<br>
              <br>
            </div>
            <div>Cheers,<br>
            </div>
            <div>Nayan <br>
              <br>
              [1] <a
href="http://ndesh26.github.io/gsoc/2018/06/14/GSoC-Update-A-Curious-Case-of-Dependency-Handling/"
                moz-do-not-send="true">http://ndesh26.github.io/gsoc/2018/06/14/GSoC-Update-A-Curious-Case-of-Dependency-Handling/</a><br>
              <br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div lang="EN-US">
                <div class="gmail-m_963201938271036718WordSection1">
                  <p class="MsoNormal">That will break fence design,
                    later fence must be signaled after front fence in
                    same fence context.</p>
                  <p class="MsoNormal"> </p>
                  <p class="MsoNormal">Anything I missed?</p>
                  <p class="MsoNormal"> </p>
                  <p class="MsoNormal">Regards,</p>
                  <p class="MsoNormal">David Zhou</p>
                  <p class="MsoNormal"> </p>
                  <p class="MsoNormal"><b>From:</b> dri-devel &lt;<a
                      href="mailto:dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      target="_blank" moz-do-not-send="true">dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
                    <b>On Behalf Of </b>Nayan Deshmukh<br>
                    <b>Sent:</b> Thursday, August 02, 2018 12:07 AM<br>
                    <b>To:</b> Grodzovsky, Andrey &lt;<a
                      href="mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org"
                      target="_blank" moz-do-not-send="true">Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                    <b>Cc:</b> <a
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      target="_blank" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                    Maling list - DRI developers &lt;<a
                      href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      target="_blank" moz-do-not-send="true">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;;
                    Koenig, Christian &lt;<a
                      href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                      target="_blank" moz-do-not-send="true">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                    <b>Subject:</b> Re: [PATCH 3/4] drm/scheduler: add
                    new function to get least loaded sched v2</p>
                  <p class="MsoNormal"> </p>
                  <div>
                    <p class="MsoNormal">Yes, that is correct. </p>
                    <div>
                      <p class="MsoNormal"> </p>
                    </div>
                    <div>
                      <p class="MsoNormal">Nayan</p>
                    </div>
                  </div>
                  <p class="MsoNormal"> </p>
                  <div>
                    <div>
                      <p class="MsoNormal">On Wed, Aug 1, 2018, 9:05 PM
                        Andrey Grodzovsky &lt;<a
                          href="mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org"
                          target="_blank" moz-do-not-send="true">Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org</a>&gt;
                        wrote:</p>
                    </div>
                    <blockquote style="border-color:currentcolor
                      currentcolor currentcolor
                      rgb(204,204,204);border-style:none none none
                      solid;border-width:medium medium medium
                      1pt;padding:0in 0in 0in
                      6pt;margin-left:4.8pt;margin-right:0in">
                      <p class="MsoNormal" style="margin-bottom:12pt">Clarification
                        question -  if the run queues belong to
                        different
                        <br>
                        schedulers they effectively point to different
                        rings,<br>
                        <br>
                        it means we allow to move (reschedule) a
                        drm_sched_entity from one ring <br>
                        to another - i assume that the idea int the
                        first place, that<br>
                        <br>
                        you have a set of HW rings and you can utilize
                        any of them for your jobs <br>
                        (like compute rings). Correct ?<br>
                        <br>
                        Andrey<br>
                        <br>
                        <br>
                        On 08/01/2018 04:20 AM, Nayan Deshmukh wrote:<br>
                        &gt; The function selects the run queue from the
                        rq_list with the<br>
                        &gt; least load. The load is decided by the
                        number of jobs in a<br>
                        &gt; scheduler.<br>
                        &gt;<br>
                        &gt; v2: avoid using atomic read twice
                        consecutively, instead store<br>
                        &gt;      it locally<br>
                        &gt;<br>
                        &gt; Signed-off-by: Nayan Deshmukh &lt;<a
                          href="mailto:nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                          target="_blank" moz-do-not-send="true">nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                        &gt; ---<br>
                        &gt;   drivers/gpu/drm/scheduler/gpu_scheduler.c
                        | 25 +++++++++++++++++++++++++<br>
                        &gt;   1 file changed, 25 insertions(+)<br>
                        &gt;<br>
                        &gt; diff --git
                        a/drivers/gpu/drm/scheduler/gpu_scheduler.c
                        b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
                        &gt; index 375f6f7f6a93..fb4e542660b0 100644<br>
                        &gt; ---
                        a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
                        &gt; +++
                        b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
                        &gt; @@ -255,6 +255,31 @@ static bool
                        drm_sched_entity_is_ready(struct
                        drm_sched_entity *entity)<br>
                        &gt;       return true;<br>
                        &gt;   }<br>
                        &gt;   <br>
                        &gt; +/**<br>
                        &gt; + * drm_sched_entity_get_free_sched - Get
                        the rq from rq_list with least load<br>
                        &gt; + *<br>
                        &gt; + * @entity: scheduler entity<br>
                        &gt; + *<br>
                        &gt; + * Return the pointer to the rq with least
                        load.<br>
                        &gt; + */<br>
                        &gt; +static struct drm_sched_rq *<br>
                        &gt; +drm_sched_entity_get_free_sched(struct
                        drm_sched_entity *entity)<br>
                        &gt; +{<br>
                        &gt; +     struct drm_sched_rq *rq = NULL;<br>
                        &gt; +     unsigned int min_jobs = UINT_MAX,
                        num_jobs;<br>
                        &gt; +     int i;<br>
                        &gt; +<br>
                        &gt; +     for (i = 0; i &lt;
                        entity-&gt;num_rq_list; ++i) {<br>
                        &gt; +             num_jobs =
                        atomic_read(&amp;entity-&gt;rq_list[i]-&gt;sched-&gt;num_jobs);<br>
                        &gt; +             if (num_jobs &lt; min_jobs) {<br>
                        &gt; +                     min_jobs = num_jobs;<br>
                        &gt; +                     rq =
                        entity-&gt;rq_list[i];<br>
                        &gt; +             }<br>
                        &gt; +     }<br>
                        &gt; +<br>
                        &gt; +     return rq;<br>
                        &gt; +}<br>
                        &gt; +<br>
                        &gt;   static void
                        drm_sched_entity_kill_jobs_cb(struct dma_fence
                        *f,<br>
                        &gt;                                   struct
                        dma_fence_cb *cb)<br>
                        &gt;   {</p>
                    </blockquote>
                  </div>
                </div>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------3338382B526B0F53E4633636--

--===============0886574305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0886574305==--
