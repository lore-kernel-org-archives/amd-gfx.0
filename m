From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/sched: add schuduling policy
Date: Fri, 17 Mar 2017 08:54:06 +0100
Message-ID: <deb8f7fe-1111-e994-732a-c3a506398204@amd.com>
References: <1489654849-6031-1-git-send-email-David1.Zhou@amd.com>
 <1489654849-6031-3-git-send-email-David1.Zhou@amd.com>
 <ad692555-8641-2ec7-f90e-eee0e8b97c2c@amd.com> <58CA57B9.4000306@amd.com>
 <4c0f45fa-3f76-d33d-6cd0-83ba1d39a3f3@gmail.com>
 <f99a087f-d479-dcd1-8d00-bdd46df10eae@gmail.com>
 <0da11bd5-d21e-d059-2987-28d650d10463@vodafone.de>
 <55502bc2-c5d5-1636-5bd5-6c385746343a@gmail.com>
 <MWHPR1201MB0206DC9ED4550D01BE31DBAAB4390@MWHPR1201MB0206.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2003994997=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB0206DC9ED4550D01BE31DBAAB4390-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2003994997==
Content-Type: multipart/alternative;
	boundary="------------6DA1838099AA281C36546B8A"

--------------6DA1838099AA281C36546B8A
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.03.2017 um 03:35 schrieb Zhou, David(ChunMing):
> Hi Christian, Andres,
>
> I understand your mean, especially high priority queue from Andres is 
> for VR, which is liking an engine to himself, but our scheduler is a 
> generic thing, which is used by multiple case.
> From scheduler perspective, scheduling policy is popular, e.g. CPU 
> scheduler, it provides different time piece for different priority 
> queue, high priority has long time to execute, low has short time, but 
> everyone has the chance to run, just sooner or later.
>

As Michel pointed out even the CPU scheduler allows for a process to 
dominate everyone else when you have the right privileges and is useful 
for the use case.

> The proposal I send is same goal for gpu scheduler, we don't desire to 
> one engine is occupied by one person, high priority can have more 
> chance to run, low priority has less, but low priority must to have. 
> The ratio is power of 2 in current implementation, we can adjust it 
> for more different situations if necessary. Even we can put a 
> parameter to be adusted convenience.
> For Andres case, he can pass a big time piece to it so that the 
> efficiency is same with occupied previous.

We perfectly understand what your patch is doing, it's just not that we 
want this behavior.

When there is high priority work available it should completely dominate 
everything else.

Regards,
Christian.

>
> Regards,
> David Zhou
>
>
> -----Original Message-----
> From: Andres Rodriguez [mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Friday, March 17, 2017 12:32 AM
> To: Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>; Zhou, David(ChunMing) 
> <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: Re: [PATCH 2/2] drm/amd/sched: add schuduling policy
>
>
>
> On 2017-03-16 12:01 PM, Christian König wrote:
> > Am 16.03.2017 um 16:31 schrieb Andres Rodriguez:
> >>
> >>
> >> On 2017-03-16 11:13 AM, Andres Rodriguez wrote:
> >>>
> >>>
> >>> On 2017-03-16 05:15 AM, zhoucm1 wrote:
> >>>>
> >>>>
> >>>> On 2017年03月16日 17:10, Christian König wrote:
> >>>>> Am 16.03.2017 um 10:00 schrieb Chunming Zhou:
> >>>>>> if high priority rq is full, then process with low priority could
> >>>>>> be starve.
> >>>>>> Add policy for this problem, the high proiority can ahead of next
> >>>>>> priority queue, the ratio is 2 : 1.
> >>>>>>
> >>>>>> Change-Id: I58f4a6b9cdce8689b18dd8e83dd6e2cf5f99d5fb
> >>>>>> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> >>>>>
> >>>>> Well, the idea behind the high priority queues is to actually
> >>>>> starve the low priority queues to a certain amount.
> >>>>>
> >>>>> At least for the kernel queue that is really desired.
> >>>> Yes, agree, but we certainly don't want low priority queue is
> >>>> totally dead, which doesn't have chance to run if high priority
> >>>> queue is always full and busy.
> >>>> If without Andres changes, it doesn't matter. But after Andres
> >>>> changes upstream, we need scheduling policy.
> >>>>
> >>>> Regards,
> >>>> David Zhou
> >>>
> >>> Hey David,
> >>>
> >>> The desired behavior is actually starvation. This is why allocating
> >>> a high priority context is locked behind root privileges at the 
> moment.
> >
> > Thanks for the quick response, and yes that's what I was expecting as
> > requirement for that feature as well.
> >
> >>>
> >>> High priority work includes many different features intended for the
> >>> safety of the user wearing the headset. These include:
> >>>     - stopping the user from tripping over furniture
> >>>     - preventing motion sickness
> >>>
> >>> We cannot compromise these safety features in order to run
> >>> non-critical tasks.
> >>>
> >>> The current approach also has the disadvantage of heavily
> >>> interleaving work. This is going to have two undesired side effects.
> >>> First, there will be a performance overhead from having the queue
> >>> context switch so often.
> >>>
> >>> Second, this approach improves concurrency of work in a ring with
> >>> mixed priority work, but actually decreases overall system
> >>> concurrency. When a ring's HW queue has any high priority work
> >>> committed, the whole ring will be executing at high priority. So
> >>> interleaving the work will result in extending the time a ring
> >>> spends in high priority mode. This effectively extends time that a
> >>> ring might spend with CU's reserved which will have a performance 
> impact on other rings.
> >>>
> >>> The best approach here is to make sure we don't map high priority
> >>> work and regular priority work to the same ring. This is why the LRU
> >>> policy for userspace ring ids to kernel ring ids was introduced.
> >>> This policy provides the guarantee as a side effect.
> >>
> >> Wanted to correct myself here. The LRU policy doesn't actually
> >> provide a guarantee. It approximates it.
> >
> > What David is perfectly right with is that this has the potential for
> > undesired side effects.
> >
> > But I completely agree that deadline or fair queue scheduling is
> > tricky to implement even when it is desired.
> >
> > So letting a submission dominate all other is perfectly ok for me as
> > long as it is limited to a certain set of processes somehow.
> >
> > Christian.
>
> I also wanted to comment that I think policies for the gpu_scheduler 
> are something interesting to explore. Not just at single ring level, 
> but also policies that tie all the gpu_schedulers for a single ASIC 
> together. Currently they all operate independently, but technically 
> they share the underlying HW so there is some resource aliasing.
>
> There has been a lot of experimentation on this area in the VR world 
> by other OS vendors. Enhancing the policies provided by the SPI 
> through SW can have some pretty great benefits. Although because of 
> restrictions these kind of changes are only activated for certain HMDs.
>
> I think we have a good opportunity here to make the linux version of 
> VR better for all HMDs, and not just the ones associated with the OS 
> vendor.
>
> Regards,
> Andres
>
> >
> >>
> >> Regards,
> >> Andres
> >>
> >>> But further work there could be
> >>> useful to actually check context priorities when doing the ring 
> mapping.
> >>>
> >>> By placing work on different rings, we let the hardware actually
> >>> dispatch work according to wave parameters like VGPR usage, etc.
> >>> Trying to deduce all this information in the GPU scheduler will get
> >>> very complicated.
> >>>
> >>> This is NAK'd by me.
> >>>
> >>> Regards,
> >>> Andres
> >>>
> >>>
> >>>>>
> >>>>> Christian.
> >>>>>
> >>>>>> ---
> >>>>>> drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 26
> >>>>>> +++++++++++++++++++++++---
> >>>>>> drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |  2 ++
> >>>>>>   2 files changed, 25 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> >>>>>> b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> >>>>>> index 0f439dd..4637b6f 100644
> >>>>>> --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> >>>>>> +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> >>>>>> @@ -35,11 +35,16 @@
> >>>>>>   static void amd_sched_process_job(struct fence *f, struct
> >>>>>> fence_cb *cb);
> >>>>>>     /* Initialize a given run queue struct */ -static void
> >>>>>> amd_sched_rq_init(struct amd_sched_rq *rq)
> >>>>>> +static void amd_sched_rq_init(struct amd_gpu_scheduler *sched, 
> enum
> >>>>>> + amd_sched_priority pri)
> >>>>>>   {
> >>>>>> +    struct amd_sched_rq *rq = &sched->sched_rq[pri];
> >>>>>> +
> >>>>>> spin_lock_init(&rq->lock);
> >>>>>> INIT_LIST_HEAD(&rq->entities);
> >>>>>>       rq->current_entity = NULL;
> >>>>>> +    rq->wait_base = pri * 2;
> >>>>>> +    rq->wait = rq->wait_base;
> >>>>>>   }
> >>>>>>     static void amd_sched_rq_add_entity(struct amd_sched_rq *rq,
> >>>>>> @@ -494,17 +499,32 @@ static void amd_sched_wakeup(struct
> >>>>>> amd_gpu_scheduler *sched)
> >>>>>>   {
> >>>>>>       struct amd_sched_entity *entity;
> >>>>>>       int i;
> >>>>>> +    bool skip;
> >>>>>>         if (!amd_sched_ready(sched))
> >>>>>>           return NULL;
> >>>>>>   +retry:
> >>>>>> +    skip = false;
> >>>>>>       /* Kernel run queue has higher priority than normal run 
> queue*/
> >>>>>>       for (i = AMD_SCHED_PRIORITY_MAX - 1; i >=
> >>>>>> AMD_SCHED_PRIORITY_MIN; i--) {
> >>>>>> +        if ((i > AMD_SCHED_PRIORITY_MIN) &&
> >>>>>> +            (sched->sched_rq[i - 1].wait >=
> >>>>>> sched->sched_rq[i].wait_base)) {
> >>>>>> +            sched->sched_rq[i - 1].wait = sched->sched_rq[i -
> >>>>>> 1].wait_base;
> >>>>>> +            skip = true;
> >>>>>> +            continue;
> >>>>>> +        }
> >>>>>>           entity = amd_sched_rq_select_entity(&sched->sched_rq[i]);
> >>>>>> -        if (entity)
> >>>>>> +        if (entity) {
> >>>>>> +            if (i > AMD_SCHED_PRIORITY_MIN)
> >>>>>> + sched->sched_rq[i - 1].wait++;
> >>>>>>               break;
> >>>>>> +        }
> >>>>>>       }
> >>>>>>   +    if (!entity && skip)
> >>>>>> +        goto retry;
> >>>>>> +
> >>>>>>       return entity;
> >>>>>>   }
> >>>>>>   @@ -608,7 +628,7 @@ int amd_sched_init(struct amd_gpu_scheduler
> >>>>>> *sched,
> >>>>>>       sched->name = name;
> >>>>>>       sched->timeout = timeout;
> >>>>>>       for (i = AMD_SCHED_PRIORITY_MIN; i <
> >>>>>> AMD_SCHED_PRIORITY_MAX;
> >>>>>> i++)
> >>>>>> - amd_sched_rq_init(&sched->sched_rq[i]);
> >>>>>> +        amd_sched_rq_init(sched, i);
> >>>>>> init_waitqueue_head(&sched->wake_up_worker);
> >>>>>> init_waitqueue_head(&sched->job_scheduled);
> >>>>>> diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> >>>>>> b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> >>>>>> index 99f0240..4caed30 100644
> >>>>>> --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> >>>>>> +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> >>>>>> @@ -64,6 +64,8 @@ struct amd_sched_rq {
> >>>>>>       spinlock_t        lock;
> >>>>>>       struct list_head    entities;
> >>>>>>       struct amd_sched_entity *current_entity;
> >>>>>> +    int wait_base;
> >>>>>> +    int wait;
> >>>>>>   };
> >>>>>>     struct amd_sched_fence {
> >>>>>
> >>>>>
> >>>>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
> >



--------------6DA1838099AA281C36546B8A
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 17.03.2017 um 03:35 schrieb Zhou,
      David(ChunMing):<br>
    </div>
    <blockquote
cite="mid:MWHPR1201MB0206DC9ED4550D01BE31DBAAB4390-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">Hi Christian, Andres,<br>
            <br>
            I understand your mean, especially high priority queue from
            Andres is for VR, which is liking an engine to himself, but
            our scheduler is a generic thing, which is used by multiple
            case.<br>
            From scheduler perspective, scheduling policy is popular,
            e.g. CPU scheduler, it provides different time piece for
            different priority queue, high priority has long time to
            execute, low has short time, but everyone has the chance to
            run, just sooner or later.<br>
            <br>
          </div>
        </span></font></blockquote>
    <br>
    As Michel pointed out even the CPU scheduler allows for a process to
    dominate everyone else when you have the right privileges and is
    useful for the use case.<br>
    <br>
    <blockquote
cite="mid:MWHPR1201MB0206DC9ED4550D01BE31DBAAB4390-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite"><font size="2"><span style="font-size:10pt;">
          <div class="PlainText">
            The proposal I send is same goal for gpu scheduler, we don't
            desire to one engine is occupied by one person, high
            priority can have more chance to run, low priority has less,
            but low priority must to have. The ratio is power of 2 in
            current implementation, we can adjust it for more different
            situations if necessary. Even we can put a parameter to be
            adusted convenience. <br>
            For Andres case, he can pass a big time piece to it so that
            the efficiency is same with occupied previous.<br>
          </div>
        </span></font></blockquote>
    <br>
    We perfectly understand what your patch is doing, it's just not that
    we want this behavior.<br>
    <br>
    When there is high priority work available it should completely
    dominate everything else.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote
cite="mid:MWHPR1201MB0206DC9ED4550D01BE31DBAAB4390-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite"><font size="2"><span style="font-size:10pt;">
          <div class="PlainText">
            <br>
            Regards,<br>
            David Zhou<br>
            <br>
            <br>
            -----Original Message-----<br>
            From: Andres Rodriguez [<a moz-do-not-send="true"
              href="mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
            <br>
            Sent: Friday, March 17, 2017 12:32 AM<br>
            To: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a>; Zhou,
            David(ChunMing) <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>; Koenig,
            Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            Subject: Re: [PATCH 2/2] drm/amd/sched: add schuduling
            policy<br>
            <br>
            <br>
            <br>
            On 2017-03-16 12:01 PM, Christian König wrote:<br>
            &gt; Am 16.03.2017 um 16:31 schrieb Andres Rodriguez:<br>
            &gt;&gt;<br>
            &gt;&gt;<br>
            &gt;&gt; On 2017-03-16 11:13 AM, Andres Rodriguez wrote:<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; On 2017-03-16 05:15 AM, zhoucm1 wrote:<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; On 2017年03月16日 17:10, Christian König
            wrote:<br>
            &gt;&gt;&gt;&gt;&gt; Am 16.03.2017 um 10:00 schrieb Chunming
            Zhou:<br>
            &gt;&gt;&gt;&gt;&gt;&gt; if high priority rq is full, then
            process with low priority could <br>
            &gt;&gt;&gt;&gt;&gt;&gt; be starve.<br>
            &gt;&gt;&gt;&gt;&gt;&gt; Add policy for this problem, the
            high proiority can ahead of next <br>
            &gt;&gt;&gt;&gt;&gt;&gt; priority queue, the ratio is 2 : 1.<br>
            &gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; Change-Id:
            I58f4a6b9cdce8689b18dd8e83dd6e2cf5f99d5fb<br>
            &gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Chunming Zhou
            <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; Well, the idea behind the high priority
            queues is to actually <br>
            &gt;&gt;&gt;&gt;&gt; starve the low priority queues to a
            certain amount.<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; At least for the kernel queue that is
            really desired.<br>
            &gt;&gt;&gt;&gt; Yes, agree, but we certainly don't want 
            low priority queue is <br>
            &gt;&gt;&gt;&gt; totally dead, which doesn't have chance to
            run if high priority <br>
            &gt;&gt;&gt;&gt; queue is always full and busy.<br>
            &gt;&gt;&gt;&gt; If without Andres changes, it doesn't
            matter. But after Andres <br>
            &gt;&gt;&gt;&gt; changes upstream, we need scheduling
            policy.<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; Regards,<br>
            &gt;&gt;&gt;&gt; David Zhou<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; Hey David,<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; The desired behavior is actually starvation.
            This is why allocating <br>
            &gt;&gt;&gt; a high priority context is locked behind root
            privileges at the moment.<br>
            &gt;<br>
            &gt; Thanks for the quick response, and yes that's what I
            was expecting as <br>
            &gt; requirement for that feature as well.<br>
            &gt;<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; High priority work includes many different
            features intended for the <br>
            &gt;&gt;&gt; safety of the user wearing the headset. These
            include:<br>
            &gt;&gt;&gt;     - stopping the user from tripping over
            furniture<br>
            &gt;&gt;&gt;     - preventing motion sickness<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; We cannot compromise these safety features in
            order to run <br>
            &gt;&gt;&gt; non-critical tasks.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; The current approach also has the disadvantage
            of heavily <br>
            &gt;&gt;&gt; interleaving work. This is going to have two
            undesired side effects. <br>
            &gt;&gt;&gt; First, there will be a performance overhead
            from having the queue <br>
            &gt;&gt;&gt; context switch so often.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; Second, this approach improves concurrency of
            work in a ring with <br>
            &gt;&gt;&gt; mixed priority work, but actually decreases
            overall system <br>
            &gt;&gt;&gt; concurrency. When a ring's HW queue has any
            high priority work <br>
            &gt;&gt;&gt; committed, the whole ring will be executing at
            high priority. So <br>
            &gt;&gt;&gt; interleaving the work will result in extending
            the time a ring <br>
            &gt;&gt;&gt; spends in high priority mode. This effectively
            extends time that a <br>
            &gt;&gt;&gt; ring might spend with CU's reserved which will
            have a performance impact on other rings.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; The best approach here is to make sure we don't
            map high priority <br>
            &gt;&gt;&gt; work and regular priority work to the same
            ring. This is why the LRU <br>
            &gt;&gt;&gt; policy for userspace ring ids to kernel ring
            ids was introduced. <br>
            &gt;&gt;&gt; This policy provides the guarantee as a side
            effect.<br>
            &gt;&gt;<br>
            &gt;&gt; Wanted to correct myself here. The LRU policy
            doesn't actually <br>
            &gt;&gt; provide a guarantee. It approximates it.<br>
            &gt;<br>
            &gt; What David is perfectly right with is that this has the
            potential for <br>
            &gt; undesired side effects.<br>
            &gt;<br>
            &gt; But I completely agree that deadline or fair queue
            scheduling is <br>
            &gt; tricky to implement even when it is desired.<br>
            &gt;<br>
            &gt; So letting a submission dominate all other is perfectly
            ok for me as <br>
            &gt; long as it is limited to a certain set of processes
            somehow.<br>
            &gt;<br>
            &gt; Christian.<br>
            <br>
            I also wanted to comment that I think policies for the
            gpu_scheduler are something interesting to explore. Not just
            at single ring level, but also policies that tie all the
            gpu_schedulers for a single ASIC together. Currently they
            all operate independently, but technically they share the
            underlying HW so there is some resource aliasing.<br>
            <br>
            There has been a lot of experimentation on this area in the
            VR world by other OS vendors. Enhancing the policies
            provided by the SPI through SW can have some pretty great
            benefits. Although because of restrictions these kind of
            changes are only activated for certain HMDs.<br>
            <br>
            I think we have a good opportunity here to make the linux
            version of VR better for all HMDs, and not just the ones
            associated with the OS vendor.<br>
            <br>
            Regards,<br>
            Andres<br>
            <br>
            &gt;<br>
            &gt;&gt;<br>
            &gt;&gt; Regards,<br>
            &gt;&gt; Andres<br>
            &gt;&gt;<br>
            &gt;&gt;&gt; But further work there could be<br>
            &gt;&gt;&gt; useful to actually check context priorities
            when doing the ring mapping.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; By placing work on different rings, we let the
            hardware actually <br>
            &gt;&gt;&gt; dispatch work according to wave parameters like
            VGPR usage, etc. <br>
            &gt;&gt;&gt; Trying to deduce all this information in the
            GPU scheduler will get <br>
            &gt;&gt;&gt; very complicated.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; This is NAK'd by me.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; Regards,<br>
            &gt;&gt;&gt; Andres<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; Christian.<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; ---<br>
            &gt;&gt;&gt;&gt;&gt;&gt;  
            drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 26<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +++++++++++++++++++++++---<br>
            &gt;&gt;&gt;&gt;&gt;&gt;  
            drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |  2 ++<br>
            &gt;&gt;&gt;&gt;&gt;&gt;   2 files changed, 25
            insertions(+), 3 deletions(-)<br>
            &gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; diff --git
            a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
            &gt;&gt;&gt;&gt;&gt;&gt;
            b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
            &gt;&gt;&gt;&gt;&gt;&gt; index 0f439dd..4637b6f 100644<br>
            &gt;&gt;&gt;&gt;&gt;&gt; ---
            a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +++
            b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
            &gt;&gt;&gt;&gt;&gt;&gt; @@ -35,11 +35,16 @@<br>
            &gt;&gt;&gt;&gt;&gt;&gt;   static void
            amd_sched_process_job(struct fence *f, struct <br>
            &gt;&gt;&gt;&gt;&gt;&gt; fence_cb *cb);<br>
            &gt;&gt;&gt;&gt;&gt;&gt;     /* Initialize a given run queue
            struct */ -static void <br>
            &gt;&gt;&gt;&gt;&gt;&gt; amd_sched_rq_init(struct
            amd_sched_rq *rq)<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +static void
            amd_sched_rq_init(struct amd_gpu_scheduler *sched, enum<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +                 
            amd_sched_priority pri)<br>
            &gt;&gt;&gt;&gt;&gt;&gt;   {<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +    struct amd_sched_rq *rq =
            &amp;sched-&gt;sched_rq[pri];<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt;&gt;&gt;&gt;&gt;&gt;      
            spin_lock_init(&amp;rq-&gt;lock);<br>
            &gt;&gt;&gt;&gt;&gt;&gt;      
            INIT_LIST_HEAD(&amp;rq-&gt;entities);<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       rq-&gt;current_entity = NULL;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +    rq-&gt;wait_base = pri * 2;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +    rq-&gt;wait =
            rq-&gt;wait_base;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;   }<br>
            &gt;&gt;&gt;&gt;&gt;&gt;     static void
            amd_sched_rq_add_entity(struct amd_sched_rq *rq, <br>
            &gt;&gt;&gt;&gt;&gt;&gt; @@ -494,17 +499,32 @@ static void
            amd_sched_wakeup(struct <br>
            &gt;&gt;&gt;&gt;&gt;&gt; amd_gpu_scheduler *sched)<br>
            &gt;&gt;&gt;&gt;&gt;&gt;   {<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       struct amd_sched_entity
            *entity;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       int i;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +    bool skip;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;         if
            (!amd_sched_ready(sched))<br>
            &gt;&gt;&gt;&gt;&gt;&gt;           return NULL;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;   +retry:<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +    skip = false;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       /* Kernel run queue has
            higher priority than normal run queue*/<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       for (i =
            AMD_SCHED_PRIORITY_MAX - 1; i &gt;= <br>
            &gt;&gt;&gt;&gt;&gt;&gt; AMD_SCHED_PRIORITY_MIN; i--) {<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +        if ((i &gt;
            AMD_SCHED_PRIORITY_MIN) &amp;&amp;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +            (sched-&gt;sched_rq[i
            - 1].wait &gt;=<br>
            &gt;&gt;&gt;&gt;&gt;&gt; sched-&gt;sched_rq[i].wait_base)) {<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +            sched-&gt;sched_rq[i -
            1].wait = sched-&gt;sched_rq[i -<br>
            &gt;&gt;&gt;&gt;&gt;&gt; 1].wait_base;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +            skip = true;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +            continue;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +        }<br>
            &gt;&gt;&gt;&gt;&gt;&gt;           entity =
            amd_sched_rq_select_entity(&amp;sched-&gt;sched_rq[i]);<br>
            &gt;&gt;&gt;&gt;&gt;&gt; -        if (entity)<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +        if (entity) {<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +            if (i &gt;
            AMD_SCHED_PRIORITY_MIN)<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +               
            sched-&gt;sched_rq[i - 1].wait++;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;               break;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +        }<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       }<br>
            &gt;&gt;&gt;&gt;&gt;&gt;   +    if (!entity &amp;&amp; skip)<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +        goto retry;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       return entity;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;   }<br>
            &gt;&gt;&gt;&gt;&gt;&gt;   @@ -608,7 +628,7 @@ int
            amd_sched_init(struct amd_gpu_scheduler <br>
            &gt;&gt;&gt;&gt;&gt;&gt; *sched,<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       sched-&gt;name = name;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       sched-&gt;timeout = timeout;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       for (i =
            AMD_SCHED_PRIORITY_MIN; i &lt; <br>
            &gt;&gt;&gt;&gt;&gt;&gt; AMD_SCHED_PRIORITY_MAX;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; i++)<br>
            &gt;&gt;&gt;&gt;&gt;&gt; -       
            amd_sched_rq_init(&amp;sched-&gt;sched_rq[i]);<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +        amd_sched_rq_init(sched,
            i);<br>
            &gt;&gt;&gt;&gt;&gt;&gt;
            init_waitqueue_head(&amp;sched-&gt;wake_up_worker);<br>
            &gt;&gt;&gt;&gt;&gt;&gt;      
            init_waitqueue_head(&amp;sched-&gt;job_scheduled);<br>
            &gt;&gt;&gt;&gt;&gt;&gt; diff --git
            a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
            &gt;&gt;&gt;&gt;&gt;&gt;
            b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
            &gt;&gt;&gt;&gt;&gt;&gt; index 99f0240..4caed30 100644<br>
            &gt;&gt;&gt;&gt;&gt;&gt; ---
            a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +++
            b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
            &gt;&gt;&gt;&gt;&gt;&gt; @@ -64,6 +64,8 @@ struct
            amd_sched_rq {<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       spinlock_t        lock;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       struct list_head    entities;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;       struct amd_sched_entity   
            *current_entity;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +    int wait_base;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; +    int wait;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;   };<br>
            &gt;&gt;&gt;&gt;&gt;&gt;     struct amd_sched_fence {<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt; _______________________________________________<br>
            &gt;&gt; amd-gfx mailing list<br>
            &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt;&gt; <a moz-do-not-send="true"
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            &gt;<br>
            &gt;<br>
          </div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------6DA1838099AA281C36546B8A--

--===============2003994997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2003994997==--
