From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/scheduler: add new function to get least loaded
 sched v2
Date: Wed, 1 Aug 2018 13:51:31 -0400
Message-ID: <6a065950-20c7-2c5a-9413-390d95126f07@amd.com>
References: <20180801082002.20696-1-nayan26deshmukh@gmail.com>
 <20180801082002.20696-3-nayan26deshmukh@gmail.com>
 <dde1b549-df1b-e156-1e96-ddfe4beca446@amd.com>
 <CAFd4ddx8D2iKquRu4YVh1gnRMpLFgWf3CBPdk5SD-nJ8dNXEPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1714581760=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFd4ddx8D2iKquRu4YVh1gnRMpLFgWf3CBPdk5SD-nJ8dNXEPQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

This is a multi-part message in MIME format.
--===============1714581760==
Content-Type: multipart/alternative;
 boundary="------------C58A028C0F3C3469D31F8BDE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C58A028C0F3C3469D31F8BDE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Series is Acked-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>

Andrey


On 08/01/2018 12:06 PM, Nayan Deshmukh wrote:
> Yes, that is correct.
>
> Nayan
>
> On Wed, Aug 1, 2018, 9:05 PM Andrey Grodzovsky 
> <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org <mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>     Clarification question -  if the run queues belong to different
>     schedulers they effectively point to different rings,
>
>     it means we allow to move (reschedule) a drm_sched_entity from one
>     ring
>     to another - i assume that the idea int the first place, that
>
>     you have a set of HW rings and you can utilize any of them for
>     your jobs
>     (like compute rings). Correct ?
>
>     Andrey
>
>
>     On 08/01/2018 04:20 AM, Nayan Deshmukh wrote:
>     > The function selects the run queue from the rq_list with the
>     > least load. The load is decided by the number of jobs in a
>     > scheduler.
>     >
>     > v2: avoid using atomic read twice consecutively, instead store
>     >      it locally
>     >
>     > Signed-off-by: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>     <mailto:nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>     > ---
>     >   drivers/gpu/drm/scheduler/gpu_scheduler.c | 25
>     +++++++++++++++++++++++++
>     >   1 file changed, 25 insertions(+)
>     >
>     > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>     b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>     > index 375f6f7f6a93..fb4e542660b0 100644
>     > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>     > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>     > @@ -255,6 +255,31 @@ static bool
>     drm_sched_entity_is_ready(struct drm_sched_entity *entity)
>     >       return true;
>     >   }
>     >
>     > +/**
>     > + * drm_sched_entity_get_free_sched - Get the rq from rq_list
>     with least load
>     > + *
>     > + * @entity: scheduler entity
>     > + *
>     > + * Return the pointer to the rq with least load.
>     > + */
>     > +static struct drm_sched_rq *
>     > +drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
>     > +{
>     > +     struct drm_sched_rq *rq = NULL;
>     > +     unsigned int min_jobs = UINT_MAX, num_jobs;
>     > +     int i;
>     > +
>     > +     for (i = 0; i < entity->num_rq_list; ++i) {
>     > +             num_jobs =
>     atomic_read(&entity->rq_list[i]->sched->num_jobs);
>     > +             if (num_jobs < min_jobs) {
>     > +                     min_jobs = num_jobs;
>     > +                     rq = entity->rq_list[i];
>     > +             }
>     > +     }
>     > +
>     > +     return rq;
>     > +}
>     > +
>     >   static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>     >                                   struct dma_fence_cb *cb)
>     >   {
>


--------------C58A028C0F3C3469D31F8BDE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Series is Acked-by: Andrey Grodzovsky
      <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a></p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 08/01/2018 12:06 PM, Nayan Deshmukh
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAFd4ddx8D2iKquRu4YVh1gnRMpLFgWf3CBPdk5SD-nJ8dNXEPQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="auto">Yes, that is correct. 
        <div dir="auto"><br>
        </div>
        <div dir="auto">Nayan</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr">On Wed, Aug 1, 2018, 9:05 PM Andrey Grodzovsky
          &lt;<a href="mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org"
            moz-do-not-send="true">Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">Clarification
          question -  if the run queues belong to different <br>
          schedulers they effectively point to different rings,<br>
          <br>
          it means we allow to move (reschedule) a drm_sched_entity from
          one ring <br>
          to another - i assume that the idea int the first place, that<br>
          <br>
          you have a set of HW rings and you can utilize any of them for
          your jobs <br>
          (like compute rings). Correct ?<br>
          <br>
          Andrey<br>
          <br>
          <br>
          On 08/01/2018 04:20 AM, Nayan Deshmukh wrote:<br>
          &gt; The function selects the run queue from the rq_list with
          the<br>
          &gt; least load. The load is decided by the number of jobs in
          a<br>
          &gt; scheduler.<br>
          &gt;<br>
          &gt; v2: avoid using atomic read twice consecutively, instead
          store<br>
          &gt;      it locally<br>
          &gt;<br>
          &gt; Signed-off-by: Nayan Deshmukh &lt;<a
            href="mailto:nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target="_blank"
            rel="noreferrer" moz-do-not-send="true">nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
          &gt; ---<br>
          &gt;   drivers/gpu/drm/scheduler/gpu_scheduler.c | 25
          +++++++++++++++++++++++++<br>
          &gt;   1 file changed, 25 insertions(+)<br>
          &gt;<br>
          &gt; diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c
          b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
          &gt; index 375f6f7f6a93..fb4e542660b0 100644<br>
          &gt; --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
          &gt; +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c<br>
          &gt; @@ -255,6 +255,31 @@ static bool
          drm_sched_entity_is_ready(struct drm_sched_entity *entity)<br>
          &gt;       return true;<br>
          &gt;   }<br>
          &gt;   <br>
          &gt; +/**<br>
          &gt; + * drm_sched_entity_get_free_sched - Get the rq from
          rq_list with least load<br>
          &gt; + *<br>
          &gt; + * @entity: scheduler entity<br>
          &gt; + *<br>
          &gt; + * Return the pointer to the rq with least load.<br>
          &gt; + */<br>
          &gt; +static struct drm_sched_rq *<br>
          &gt; +drm_sched_entity_get_free_sched(struct drm_sched_entity
          *entity)<br>
          &gt; +{<br>
          &gt; +     struct drm_sched_rq *rq = NULL;<br>
          &gt; +     unsigned int min_jobs = UINT_MAX, num_jobs;<br>
          &gt; +     int i;<br>
          &gt; +<br>
          &gt; +     for (i = 0; i &lt; entity-&gt;num_rq_list; ++i) {<br>
          &gt; +             num_jobs =
          atomic_read(&amp;entity-&gt;rq_list[i]-&gt;sched-&gt;num_jobs);<br>
          &gt; +             if (num_jobs &lt; min_jobs) {<br>
          &gt; +                     min_jobs = num_jobs;<br>
          &gt; +                     rq = entity-&gt;rq_list[i];<br>
          &gt; +             }<br>
          &gt; +     }<br>
          &gt; +<br>
          &gt; +     return rq;<br>
          &gt; +}<br>
          &gt; +<br>
          &gt;   static void drm_sched_entity_kill_jobs_cb(struct
          dma_fence *f,<br>
          &gt;                                   struct dma_fence_cb
          *cb)<br>
          &gt;   {<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------C58A028C0F3C3469D31F8BDE--

--===============1714581760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1714581760==--
