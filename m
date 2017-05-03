From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu:keep ctx alive till all job finished
Date: Wed, 3 May 2017 11:11:45 +0200
Message-ID: <ba31391d-1f42-705b-5c94-bfd7bd1a194f@vodafone.de>
References: <1493623371-32614-1-git-send-email-Monk.Liu@amd.com>
 <1493623371-32614-2-git-send-email-Monk.Liu@amd.com>
 <a4605d10-b1f7-7fee-63c9-829d612c63aa@vodafone.de>
 <DM5PR12MB16102746DB02DBE8ED69DA9C84160@DM5PR12MB1610.namprd12.prod.outlook.com>
 <DM5PR12MB16107F8A55F3EF0B1C834FC384160@DM5PR12MB1610.namprd12.prod.outlook.com>
 <MWHPR1201MB020601F998809FC8F0527723B4160@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <DM5PR12MB161082763FA0163FF22E1C1F84160@DM5PR12MB1610.namprd12.prod.outlook.com>
 <59098580.6090204@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1963350195=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <59098580.6090204-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1963350195==
Content-Type: multipart/alternative;
 boundary="------------E19C064EAC862D2A4F73EF0F"

This is a multi-part message in MIME format.
--------------E19C064EAC862D2A4F73EF0F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> > 1) fence_context have chance to incorrectly represent the context 
> behind it, because the number can be used up and will wrapped around 
> from beginning
> No, fence_context is unique in global in kernel.
Yeah, I would go with that as well.

You note the fence_context of the job which caused the trouble.

Then take a look at all jobs on the recovery list and remove the ones 
with the same fence_context number.

Then take a look at all entities on the runlist and remove the one with 
the same fence_context number. If it is already freed you won't find 
any, but that shouldn't be a problem.

This way you effectively can prevent other jobs from the same context 
from running and the context query can simply check if the entity is 
still on the runlist to figure out if it was guilty or not.

Regards,
Christian.

Am 03.05.2017 um 09:23 schrieb zhoucm1:
>
>
> On 2017年05月03日 14:02, Liu, Monk wrote:
>> You can add ctx as filed of job, but not get reference of it, when 
>> you try to use ctx, just check if ctx == NULL.
>> > that doesn't work at all... job->ctx will always be non-NULL after 
>> it is initialized, you just refer to a wild pointer after CTX released
> job->ctx is a **ctx, which could resolve your this concern.
>
>>
>> Another stupid method:
>> Use idr_for_each_entry(..job->vm->ctx_mgr...) and compare the 
>> job->fence->fence_context with ctx->ring[].entity->fence_context. if 
>> not found, then ctx is freed, otherwise you can do your things for 
>> this ctx.
>> > 1) fence_context have chance to incorrectly represent the context 
>> behind it, because the number can be used up and will wrapped around 
>> from beginning
> No, fence_context is unique in global in kernel.
>
> Regards,
> David Zhou
>>    2) why not just keep CTX alive, which is much simple than this method
>>
>> BR
>>
>> -----Original Message-----
>> From: Zhou, David(ChunMing)
>> Sent: Wednesday, May 03, 2017 12:54 PM
>> To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; 
>> Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: RE: [PATCH 1/5] drm/amdgpu:keep ctx alive till all job finished
>>
>> You can add ctx as filed of job, but not get reference of it, when 
>> you try to use ctx, just check if ctx == NULL.
>>
>> Another stupid method:
>> Use idr_for_each_entry(..job->vm->ctx_mgr...) and compare the 
>> job->fence->fence_context with ctx->ring[].entity->fence_context. if 
>> not found, then ctx is freed, otherwise you can do your things for 
>> this ctx.
>>
>> Regards,
>> David Zhou
>>
>> -----Original Message-----
>> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On 
>> Behalf Of Liu, Monk
>> Sent: Wednesday, May 03, 2017 11:57 AM
>> To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Christian König 
>> <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: RE: [PATCH 1/5] drm/amdgpu:keep ctx alive till all job finished
>>
>> @Christian,
>>
>> The thing is I need mark all entities behind this timeout job as 
>> guilty, so I use a member in entity named "ptr_guilty", to point to 
>> The member in amdgpu_ctx named "guilty", that way read 
>> *entity->ptr_guilty can get you if this entity is "invalid", and set 
>> *entity->ptr_guilty Can let you set all entities belongs to the 
>> context as "invalid".
>>
>> Above logic is to guarantee we can kick out all guilty entities in 
>> entity kfifo, and also block all IOCTL with a ctx handle point to 
>> this guilty context, And we only recovery other jobs/entities/context 
>> after scheduler unparked
>>
>> If you reject the patch to keep ctx alive till all jobs signaled, 
>> please give me a solution to satisfy above logic
>>
>> BR Monk
>>
>> -----Original Message-----
>> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On 
>> Behalf Of Liu, Monk
>> Sent: Wednesday, May 03, 2017 11:31 AM
>> To: Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>; 
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: RE: [PATCH 1/5] drm/amdgpu:keep ctx alive till all job finished
>>
>> 1, This is necessary otherwise how can I access entity pointer after 
>> a job timedout , and why it is dangerous ?
>> 2, what's the status field in the fences you were referring to ? I 
>> need to judge if it could satisfy my requirement
>>
>>
>>
>> -----Original Message-----
>> From: Christian König [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
>> Sent: Monday, May 01, 2017 10:48 PM
>> To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: Re: [PATCH 1/5] drm/amdgpu:keep ctx alive till all job finished
>>
>> Am 01.05.2017 um 09:22 schrieb Monk Liu:
>> > for TDR guilty context feature, we need access ctx/s_entity field
>> > member through sched job pointer,so ctx must keep alive till all job
>> > from it signaled.
>>
>> NAK, that is unnecessary and quite dangerous.
>>
>> Instead we have the designed status field in the fences which should 
>> be checked for that.
>>
>> Regards,
>> Christian.
>>
>> >
>> > Change-Id: Ib87e9502f7a5c8c054c7e56956d7f7ad75998e43
>> > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 6 +++++-
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 2 +-
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       | 9 +++++++++
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       | 9 +++++++--
>> >   drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 6 ------
>> >   drivers/gpu/drm/amd/scheduler/gpu_scheduler.h | 1 +
>> >   6 files changed, 23 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> > index e330009..8e031d6 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> > @@ -760,10 +760,12 @@ struct amdgpu_ib {
>> >        uint32_t                        flags;
>> >   };
>> >
>> > +struct amdgpu_ctx;
>> > +
>> >   extern const struct amd_sched_backend_ops amdgpu_sched_ops;
>> >
>> >   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
>> > -                  struct amdgpu_job **job, struct amdgpu_vm *vm);
>> > +                  struct amdgpu_job **job, struct amdgpu_vm *vm, 
>> struct
>> > +amdgpu_ctx *ctx);
>> >   int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned 
>> size,
>> >                             struct amdgpu_job **job);
>> >
>> > @@ -802,6 +804,7 @@ struct amdgpu_ctx_mgr {
>> >
>> >   struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, 
>> uint32_t id);
>> >   int amdgpu_ctx_put(struct amdgpu_ctx *ctx);
>> > +struct amdgpu_ctx *amdgpu_ctx_kref_get(struct amdgpu_ctx *ctx);
>> >
>> >   uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx, struct 
>> amdgpu_ring *ring,
>> >                              struct fence *fence);
>> > @@ -1129,6 +1132,7 @@ struct amdgpu_job {
>> >        struct amdgpu_sync      sync;
>> >        struct amdgpu_ib        *ibs;
>> >        struct fence            *fence; /* the hw fence */
>> > +     struct amdgpu_ctx *ctx;
>> >        uint32_t                preamble_status;
>> >        uint32_t                num_ibs;
>> >        void                    *owner;
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > index 699f5fe..267fb65 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > @@ -234,7 +234,7 @@ int amdgpu_cs_parser_init(struct 
>> amdgpu_cs_parser *p, void *data)
>> >                }
>> >        }
>> >
>> > -     ret = amdgpu_job_alloc(p->adev, num_ibs, &p->job, vm);
>> > +     ret = amdgpu_job_alloc(p->adev, num_ibs, &p->job, vm, p->ctx);
>> >        if (ret)
>> >                goto free_all_kdata;
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> > index b4bbbb3..81438af 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> > @@ -25,6 +25,13 @@
>> >   #include <drm/drmP.h>
>> >   #include "amdgpu.h"
>> >
>> > +struct amdgpu_ctx *amdgpu_ctx_kref_get(struct amdgpu_ctx *ctx) {
>> > +     if (ctx)
>> > +             kref_get(&ctx->refcount);
>> > +     return ctx;
>> > +}
>> > +
>> >   static int amdgpu_ctx_init(struct amdgpu_device *adev, struct 
>> amdgpu_ctx *ctx)
>> >   {
>> >        unsigned i, j;
>> > @@ -56,6 +63,8 @@ static int amdgpu_ctx_init(struct amdgpu_device 
>> *adev, struct amdgpu_ctx *ctx)
>> >                                          rq, amdgpu_sched_jobs);
>> >                if (r)
>> >                        goto failed;
>> > +
>> > +             ctx->rings[i].entity.ptr_guilty = &ctx->guilty; /* 
>> kernel entity
>> > +doesn't have ptr_guilty */
>> >        }
>> >
>> >        return 0;
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> > index 690ef3d..208da11 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> > @@ -40,7 +40,7 @@ static void amdgpu_job_timedout(struct 
>> amd_sched_job *s_job)
>> >   }
>> >
>> >   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
>> > -                  struct amdgpu_job **job, struct amdgpu_vm *vm)
>> > +                  struct amdgpu_job **job, struct amdgpu_vm *vm, 
>> struct
>> > +amdgpu_ctx *ctx)
>> >   {
>> >        size_t size = sizeof(struct amdgpu_job);
>> >
>> > @@ -57,6 +57,7 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, 
>> unsigned num_ibs,
>> >        (*job)->vm = vm;
>> >        (*job)->ibs = (void *)&(*job)[1];
>> >        (*job)->num_ibs = num_ibs;
>> > +     (*job)->ctx = amdgpu_ctx_kref_get(ctx);
>> >
>> >        amdgpu_sync_create(&(*job)->sync);
>> >
>> > @@ -68,7 +69,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device 
>> *adev, unsigned size,
>> >   {
>> >        int r;
>> >
>> > -     r = amdgpu_job_alloc(adev, 1, job, NULL);
>> > +     r = amdgpu_job_alloc(adev, 1, job, NULL, NULL);
>> >        if (r)
>> >                return r;
>> >
>> > @@ -94,6 +95,10 @@ void amdgpu_job_free_resources(struct amdgpu_job 
>> *job)
>> >   static void amdgpu_job_free_cb(struct amd_sched_job *s_job)
>> >   {
>> >        struct amdgpu_job *job = container_of(s_job, struct amdgpu_job,
>> > base);
>> > +     struct amdgpu_ctx *ctx = job->ctx;
>> > +
>> > +     if (ctx)
>> > +             amdgpu_ctx_put(ctx);
>> >
>> >        fence_put(job->fence);
>> >        amdgpu_sync_free(&job->sync);
>> > diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
>> > b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
>> > index 6f4e31f..9100ca8 100644
>> > --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
>> > +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
>> > @@ -208,12 +208,6 @@ void amd_sched_entity_fini(struct 
>> amd_gpu_scheduler *sched,
>> >        if (!amd_sched_entity_is_initialized(sched, entity))
>> >                return;
>> >
>> > -     /**
>> > -      * The client will not queue more IBs during this fini, 
>> consume existing
>> > -      * queued IBs
>> > -     */
>> > -     wait_event(sched->job_scheduled, 
>> amd_sched_entity_is_idle(entity));
>> > -
>> >        amd_sched_rq_remove_entity(rq, entity);
>> >        kfifo_free(&entity->job_queue);
>> >   }
>> > diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
>> > b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
>> > index 8cb41d3..ccbbcb0 100644
>> > --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
>> > +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
>> > @@ -49,6 +49,7 @@ struct amd_sched_entity {
>> >
>> >        struct fence                    *dependency;
>> >        struct fence_cb                 cb;
>> > +     bool *ptr_guilty;
>> >   };
>> >
>> >   /**
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------E19C064EAC862D2A4F73EF0F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite"><font size="2"><span
            style="font-size:10pt;">
            <div class="PlainText"> &gt; 1) fence_context have chance to
              incorrectly represent the context behind it, because the
              number can be used up and will wrapped around from
              beginning <br>
            </div>
          </span></font> <font size="2">No, fence_context is unique in
          global in kernel.<br>
        </font></blockquote>
      Yeah, I would go with that as well.<br>
      <br>
      You note the fence_context of the job which caused the trouble.<br>
      <br>
      Then take a look at all jobs on the recovery list and remove the
      ones with the same fence_context number.<br>
      <br>
      Then take a look at all entities on the runlist and remove the one
      with the same fence_context number. If it is already freed you
      won't find any, but that shouldn't be a problem.<br>
      <br>
      This way you effectively can prevent other jobs from the same
      context from running and the context query can simply check if the
      entity is still on the runlist to figure out if it was guilty or
      not.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 03.05.2017 um 09:23 schrieb zhoucm1:<br>
    </div>
    <blockquote cite="mid:59098580.6090204-5C7GfCeVMHo@public.gmane.org" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      <br>
      <br>
      <div class="moz-cite-prefix">On 2017年05月03日 14:02, Liu, Monk
        wrote:<br>
      </div>
      <blockquote
cite="mid:DM5PR12MB161082763FA0163FF22E1C1F84160-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
        type="cite">
        <meta http-equiv="Content-Type" content="text/html;
          charset=utf-8">
        <meta name="Generator" content="Microsoft Exchange Server">
        <!-- converted from text -->
        <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
        <font size="2"><span style="font-size:10pt;">
            <div class="PlainText">You can add ctx as filed of job, but
              not get reference of it, when you try to use ctx, just
              check if ctx == NULL.<br>
              &gt; that doesn't work at all... job-&gt;ctx will always
              be non-NULL after it is initialized, you just refer to a
              wild pointer after CTX released <br>
            </div>
          </span></font></blockquote>
      <font size="2">job-&gt;ctx is a **ctx, which could resolve your
        this concern.<br>
        <br>
      </font>
      <blockquote
cite="mid:DM5PR12MB161082763FA0163FF22E1C1F84160-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
        type="cite"><font size="2"><span style="font-size:10pt;">
            <div class="PlainText"> <br>
              Another stupid method:<br>
              Use idr_for_each_entry(..job-&gt;vm-&gt;ctx_mgr...) and
              compare the job-&gt;fence-&gt;fence_context with
              ctx-&gt;ring[].entity-&gt;fence_context. if not found,
              then ctx is freed, otherwise you can do your things for
              this ctx.<br>
              &gt; 1) fence_context have chance to incorrectly represent
              the context behind it, because the number can be used up
              and will wrapped around from beginning <br>
            </div>
          </span></font></blockquote>
      <font size="2">No, fence_context is unique in global in kernel.<br>
        <br>
        Regards,<br>
        David Zhou<br>
      </font>
      <blockquote
cite="mid:DM5PR12MB161082763FA0163FF22E1C1F84160-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
        type="cite"><font size="2"><span style="font-size:10pt;">
            <div class="PlainText">    2) why not just keep CTX alive,
              which is much simple than this method <br>
              <br>
              BR<br>
              <br>
              -----Original Message-----<br>
              From: Zhou, David(ChunMing) <br>
              Sent: Wednesday, May 03, 2017 12:54 PM<br>
              To: Liu, Monk <a moz-do-not-send="true"
                class="moz-txt-link-rfc2396E"
                href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
              Liu, Monk <a moz-do-not-send="true"
                class="moz-txt-link-rfc2396E"
                href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
              Christian König <a moz-do-not-send="true"
                class="moz-txt-link-rfc2396E"
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a>;
              <a moz-do-not-send="true" class="moz-txt-link-abbreviated"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              Subject: RE: [PATCH 1/5] drm/amdgpu:keep ctx alive till
              all job finished<br>
              <br>
              You can add ctx as filed of job, but not get reference of
              it, when you try to use ctx, just check if ctx == NULL. <br>
              <br>
              Another stupid method:<br>
              Use idr_for_each_entry(..job-&gt;vm-&gt;ctx_mgr...) and
              compare the job-&gt;fence-&gt;fence_context with
              ctx-&gt;ring[].entity-&gt;fence_context. if not found,
              then ctx is freed, otherwise you can do your things for
              this ctx.<br>
              <br>
              Regards,<br>
              David Zhou<br>
              <br>
              -----Original Message-----<br>
              From: amd-gfx [<a moz-do-not-send="true"
                href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
              On Behalf Of Liu, Monk<br>
              Sent: Wednesday, May 03, 2017 11:57 AM<br>
              To: Liu, Monk <a moz-do-not-send="true"
                class="moz-txt-link-rfc2396E"
                href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
              Christian König <a moz-do-not-send="true"
                class="moz-txt-link-rfc2396E"
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a>;
              <a moz-do-not-send="true" class="moz-txt-link-abbreviated"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              Subject: RE: [PATCH 1/5] drm/amdgpu:keep ctx alive till
              all job finished<br>
              <br>
              @Christian,<br>
              <br>
              The thing is I need mark all entities behind this timeout
              job as guilty, so I use a member in entity named
              "ptr_guilty", to point to The member in amdgpu_ctx named
              "guilty", that way read *entity-&gt;ptr_guilty can get you
              if this entity is "invalid", and set
              *entity-&gt;ptr_guilty Can let you set all entities
              belongs to the context as "invalid".<br>
              <br>
              Above logic is to guarantee we can kick out all guilty
              entities in entity kfifo, and also block all IOCTL with a
              ctx handle point to this guilty context, And we only
              recovery other jobs/entities/context after scheduler
              unparked <br>
              <br>
              If you reject the patch to keep ctx alive till all jobs
              signaled, please give me a solution to satisfy above logic
              <br>
              <br>
              BR Monk<br>
              <br>
              -----Original Message-----<br>
              From: amd-gfx [<a moz-do-not-send="true"
                href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
              On Behalf Of Liu, Monk<br>
              Sent: Wednesday, May 03, 2017 11:31 AM<br>
              To: Christian König <a moz-do-not-send="true"
                class="moz-txt-link-rfc2396E"
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a>;
              <a moz-do-not-send="true" class="moz-txt-link-abbreviated"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              Subject: RE: [PATCH 1/5] drm/amdgpu:keep ctx alive till
              all job finished<br>
              <br>
              1, This is necessary otherwise how can I access entity
              pointer after a job timedout , and why it is dangerous ?<br>
              2, what's the status field in the fences you were
              referring to ? I need to judge if it could satisfy my
              requirement <br>
              <br>
              <br>
              <br>
              -----Original Message-----<br>
              From: Christian König [<a moz-do-not-send="true"
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>]<br>
              Sent: Monday, May 01, 2017 10:48 PM<br>
              To: Liu, Monk <a moz-do-not-send="true"
                class="moz-txt-link-rfc2396E"
                href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
              <a moz-do-not-send="true" class="moz-txt-link-abbreviated"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              Subject: Re: [PATCH 1/5] drm/amdgpu:keep ctx alive till
              all job finished<br>
              <br>
              Am 01.05.2017 um 09:22 schrieb Monk Liu:<br>
              &gt; for TDR guilty context feature, we need access
              ctx/s_entity field <br>
              &gt; member through sched job pointer,so ctx must keep
              alive till all job <br>
              &gt; from it signaled.<br>
              <br>
              NAK, that is unnecessary and quite dangerous.<br>
              <br>
              Instead we have the designed status field in the fences
              which should be checked for that.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              &gt;<br>
              &gt; Change-Id: Ib87e9502f7a5c8c054c7e56956d7f7ad75998e43<br>
              &gt; Signed-off-by: Monk Liu <a moz-do-not-send="true"
                class="moz-txt-link-rfc2396E"
                href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; ---<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 6
              +++++-<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 2
              +-<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       | 9
              +++++++++<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       | 9
              +++++++--<br>
              &gt;   drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 6
              ------<br>
              &gt;   drivers/gpu/drm/amd/scheduler/gpu_scheduler.h | 1 +<br>
              &gt;   6 files changed, 23 insertions(+), 10 deletions(-)<br>
              &gt;<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt; index e330009..8e031d6 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt; @@ -760,10 +760,12 @@ struct amdgpu_ib {<br>
              &gt;        uint32_t                        flags;<br>
              &gt;   };<br>
              &gt;   <br>
              &gt; +struct amdgpu_ctx;<br>
              &gt; +<br>
              &gt;   extern const struct amd_sched_backend_ops
              amdgpu_sched_ops;<br>
              &gt;   <br>
              &gt;   int amdgpu_job_alloc(struct amdgpu_device *adev,
              unsigned num_ibs,<br>
              &gt; -                  struct amdgpu_job **job, struct
              amdgpu_vm *vm);<br>
              &gt; +                  struct amdgpu_job **job, struct
              amdgpu_vm *vm, struct <br>
              &gt; +amdgpu_ctx *ctx);<br>
              &gt;   int amdgpu_job_alloc_with_ib(struct amdgpu_device
              *adev, unsigned size,<br>
              &gt;                             struct amdgpu_job **job);<br>
              &gt;   <br>
              &gt; @@ -802,6 +804,7 @@ struct amdgpu_ctx_mgr {<br>
              &gt;   <br>
              &gt;   struct amdgpu_ctx *amdgpu_ctx_get(struct
              amdgpu_fpriv *fpriv, uint32_t id);<br>
              &gt;   int amdgpu_ctx_put(struct amdgpu_ctx *ctx);<br>
              &gt; +struct amdgpu_ctx *amdgpu_ctx_kref_get(struct
              amdgpu_ctx *ctx);<br>
              &gt;   <br>
              &gt;   uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx
              *ctx, struct amdgpu_ring *ring,<br>
              &gt;                              struct fence *fence);<br>
              &gt; @@ -1129,6 +1132,7 @@ struct amdgpu_job {<br>
              &gt;        struct amdgpu_sync      sync;<br>
              &gt;        struct amdgpu_ib        *ibs;<br>
              &gt;        struct fence            *fence; /* the hw
              fence */<br>
              &gt; +     struct amdgpu_ctx *ctx;<br>
              &gt;        uint32_t                preamble_status;<br>
              &gt;        uint32_t                num_ibs;<br>
              &gt;        void                    *owner;<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
              &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
              &gt; index 699f5fe..267fb65 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
              &gt; @@ -234,7 +234,7 @@ int amdgpu_cs_parser_init(struct
              amdgpu_cs_parser *p, void *data)<br>
              &gt;                }<br>
              &gt;        }<br>
              &gt;   <br>
              &gt; -     ret = amdgpu_job_alloc(p-&gt;adev, num_ibs,
              &amp;p-&gt;job, vm);<br>
              &gt; +     ret = amdgpu_job_alloc(p-&gt;adev, num_ibs,
              &amp;p-&gt;job, vm, p-&gt;ctx);<br>
              &gt;        if (ret)<br>
              &gt;                goto free_all_kdata;<br>
              &gt;   <br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
              &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
              &gt; index b4bbbb3..81438af 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
              &gt; @@ -25,6 +25,13 @@<br>
              &gt;   #include &lt;drm/drmP.h&gt;<br>
              &gt;   #include "amdgpu.h"<br>
              &gt;   <br>
              &gt; +struct amdgpu_ctx *amdgpu_ctx_kref_get(struct
              amdgpu_ctx *ctx) {<br>
              &gt; +     if (ctx)<br>
              &gt; +             kref_get(&amp;ctx-&gt;refcount);<br>
              &gt; +     return ctx;<br>
              &gt; +}<br>
              &gt; +<br>
              &gt;   static int amdgpu_ctx_init(struct amdgpu_device
              *adev, struct amdgpu_ctx *ctx)<br>
              &gt;   {<br>
              &gt;        unsigned i, j;<br>
              &gt; @@ -56,6 +63,8 @@ static int amdgpu_ctx_init(struct
              amdgpu_device *adev, struct amdgpu_ctx *ctx)<br>
              &gt;                                          rq,
              amdgpu_sched_jobs);<br>
              &gt;                if (r)<br>
              &gt;                        goto failed;<br>
              &gt; +<br>
              &gt; +             ctx-&gt;rings[i].entity.ptr_guilty =
              &amp;ctx-&gt;guilty; /* kernel entity <br>
              &gt; +doesn't have ptr_guilty */<br>
              &gt;        }<br>
              &gt;   <br>
              &gt;        return 0;<br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
              &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
              &gt; index 690ef3d..208da11 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
              &gt; @@ -40,7 +40,7 @@ static void
              amdgpu_job_timedout(struct amd_sched_job *s_job)<br>
              &gt;   }<br>
              &gt;   <br>
              &gt;   int amdgpu_job_alloc(struct amdgpu_device *adev,
              unsigned num_ibs,<br>
              &gt; -                  struct amdgpu_job **job, struct
              amdgpu_vm *vm)<br>
              &gt; +                  struct amdgpu_job **job, struct
              amdgpu_vm *vm, struct <br>
              &gt; +amdgpu_ctx *ctx)<br>
              &gt;   {<br>
              &gt;        size_t size = sizeof(struct amdgpu_job);<br>
              &gt;   <br>
              &gt; @@ -57,6 +57,7 @@ int amdgpu_job_alloc(struct
              amdgpu_device *adev, unsigned num_ibs,<br>
              &gt;        (*job)-&gt;vm = vm;<br>
              &gt;        (*job)-&gt;ibs = (void *)&amp;(*job)[1];<br>
              &gt;        (*job)-&gt;num_ibs = num_ibs;<br>
              &gt; +     (*job)-&gt;ctx = amdgpu_ctx_kref_get(ctx);<br>
              &gt;   <br>
              &gt;        amdgpu_sync_create(&amp;(*job)-&gt;sync);<br>
              &gt;   <br>
              &gt; @@ -68,7 +69,7 @@ int amdgpu_job_alloc_with_ib(struct
              amdgpu_device *adev, unsigned size,<br>
              &gt;   {<br>
              &gt;        int r;<br>
              &gt;   <br>
              &gt; -     r = amdgpu_job_alloc(adev, 1, job, NULL);<br>
              &gt; +     r = amdgpu_job_alloc(adev, 1, job, NULL, NULL);<br>
              &gt;        if (r)<br>
              &gt;                return r;<br>
              &gt;   <br>
              &gt; @@ -94,6 +95,10 @@ void
              amdgpu_job_free_resources(struct amdgpu_job *job)<br>
              &gt;   static void amdgpu_job_free_cb(struct amd_sched_job
              *s_job)<br>
              &gt;   {<br>
              &gt;        struct amdgpu_job *job = container_of(s_job,
              struct amdgpu_job, <br>
              &gt; base);<br>
              &gt; +     struct amdgpu_ctx *ctx = job-&gt;ctx;<br>
              &gt; +<br>
              &gt; +     if (ctx)<br>
              &gt; +             amdgpu_ctx_put(ctx);<br>
              &gt;   <br>
              &gt;        fence_put(job-&gt;fence);<br>
              &gt;        amdgpu_sync_free(&amp;job-&gt;sync);<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
              &gt; b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
              &gt; index 6f4e31f..9100ca8 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
              &gt; @@ -208,12 +208,6 @@ void
              amd_sched_entity_fini(struct amd_gpu_scheduler *sched,<br>
              &gt;        if (!amd_sched_entity_is_initialized(sched,
              entity))<br>
              &gt;                return;<br>
              &gt;   <br>
              &gt; -     /**<br>
              &gt; -      * The client will not queue more IBs during
              this fini, consume existing<br>
              &gt; -      * queued IBs<br>
              &gt; -     */<br>
              &gt; -     wait_event(sched-&gt;job_scheduled,
              amd_sched_entity_is_idle(entity));<br>
              &gt; -<br>
              &gt;        amd_sched_rq_remove_entity(rq, entity);<br>
              &gt;        kfifo_free(&amp;entity-&gt;job_queue);<br>
              &gt;   }<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
              &gt; b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
              &gt; index 8cb41d3..ccbbcb0 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
              &gt; @@ -49,6 +49,7 @@ struct amd_sched_entity {<br>
              &gt;   <br>
              &gt;        struct fence                    *dependency;<br>
              &gt;        struct fence_cb                 cb;<br>
              &gt; +     bool *ptr_guilty;<br>
              &gt;   };<br>
              &gt;   <br>
              &gt;   /**<br>
              <br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a moz-do-not-send="true" class="moz-txt-link-abbreviated"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a moz-do-not-send="true"
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a moz-do-not-send="true" class="moz-txt-link-abbreviated"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a moz-do-not-send="true"
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </div>
          </span></font> </blockquote>
      <br>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------E19C064EAC862D2A4F73EF0F--

--===============1963350195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1963350195==--
