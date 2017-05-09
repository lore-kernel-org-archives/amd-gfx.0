From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu/SRIOV:implement guilty job TDR (V2)
Date: Tue, 9 May 2017 09:48:34 +0200
Message-ID: <034faac0-870e-b751-2a4e-3663dd80bbb6@amd.com>
References: <DM5PR12MB1610CE50CEC9AB4A30B1164F84EE0@DM5PR12MB1610.namprd12.prod.outlook.com>
 <d6d293a4-4529-ffb1-394f-8fb0cc2a384d@vodafone.de>
 <DM5PR12MB1610CE19C4173C5764CACFA984EF0@DM5PR12MB1610.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0839500436=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1610CE19C4173C5764CACFA984EF0-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0839500436==
Content-Type: multipart/alternative;
	boundary="------------360C05E31E12B96B2E70979A"

--------------360C05E31E12B96B2E70979A
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

> [ML] Really not necessary, we have spin_lock to protect the 
> mirror-list, nothing will be messed up ...
You are missing that it is entirely possible that the job will complete 
while we are trying to kick it out.

> [ML] why don't touch hardware fence at all ?  the original/bare-metal 
> gpu reset also signal all ring's hardware fence first, I just follow 
> the original logic ...
> Scheduler fence will be auto signaled after hw fence signaled, any 
> problem with that ? what's the concern ?
The hardware runs async to the CPU which tries to reset it, so we need 
to be careful in which order things are done.

> [ML] No I don't think so, the kickout must be prior to the 
> hw_job_reset, otherwise the scheduler fence callback will be removed 
> and you need manually install it later , which is not correct:
> For the guity job, we just kick it out before job reset, in job_reset 
> we only reset other innocent jobs( and unbind the scheduler fence 
> callback for them), after hw fence
> Forcely set to drv_seq, all hw fence are signaled (this is the way of 
> original logic, I didn't change that).  When go to sched_recovery(), 
> it will recover all innocent job and hook
> The scheduler fence with new hw fence.  That way only the guilty job 
> is dropped forever.
Again same problem here.

To be absolutely sure that everything works as expected we need to do it 
in the following order:

1. Stop the scheduler from feeding more jobs to the hardware when a jobs 
completes.

2. Then call hw_job_reset to remove the connection between job and 
hardware fence.

3. Test if job is now completed. It is entirely possible that the job 
completed while we started the work to reset the hardware.

Removing the connection between the hardware fence and the job is the 
deadline, if the job completes after that it is lost.

4. Check the karma and kick out the job if we found it guilty.

5. Get the whole stuff working again, e.g. reset the hardware, restart 
the scheduler etc...

Regards,
Christian.

Am 09.05.2017 um 04:45 schrieb Liu, Monk:
> >
> > -     /* block scheduler */
> > -     for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> > -             ring = adev->rings[i];
> > +     /* we start from the ring trigger GPU hang */
> > +     j = job ? job->ring->idx : 0;
> > +
> > +     if (job)
> > +             if (amd_sched_invalidate_job(&job->base, 
> amdgpu_job_hang_limit))
> > + amd_sched_job_kickout(&job->base);
>
> Well that looks like the wrong order to me. We should probably stop 
> the scheduler before trying to mess anything with the job.
>
> [ML] Really not necessary, we have spin_lock to protect the 
> mirror-list, nothing will be messed up ...
>
>
> >
> > +void amdgpu_fence_driver_force_completion_ring(struct amdgpu_ring
> > +*ring) {
> > +     if (ring)
> > +             amdgpu_fence_write(ring, ring->fence_drv.sync_seq); }
> > +
>
> The coding style is completely off.
>
> [ML] I don't know why at email side it looks wrong coding style, but 
> I'm sure it is correct at my side, check here:
> void amdgpu_fence_driver_force_completion_ring(struct amdgpu_ring *ring)
> {
>         if (ring)
>                 amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
> }
>
> Additional to that I don't think that this is a good idea. We should 
> probably rather just signal all scheduler fences instead and don't 
> touch the hardware fence at all.
>
> [ML] why don't touch hardware fence at all ?  the original/bare-metal 
> gpu reset also signal all ring's hardware fence first, I just follow 
> the original logic ...
> Scheduler fence will be auto signaled after hw fence signaled, any 
> problem with that ? what's the concern ?
>
>
> > -     for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> > -             struct amdgpu_ring *ring = adev->rings[i];
> > +     for (i = j; i < j + AMDGPU_MAX_RINGS; ++i) {
> > +             ring = adev->rings[i % AMDGPU_MAX_RINGS];
> >                if (!ring || !ring->sched.thread)
> >                        continue;
> >
> > +             if (job && j != i) {
> > + kthread_unpark(ring->sched.thread);
> > +                     continue;
> > +             }
> > +
>
> Please split up that patch a bit further. E.g. first the handling to 
> only hw_job_reset the ring in question, then the kickout handling.
>
> [ML] No I don't think so, the kickout must be prior to the 
> hw_job_reset, otherwise the scheduler fence callback will be removed 
> and you need manually install it later , which is not correct:
> For the guity job, we just kick it out before job reset, in job_reset 
> we only reset other innocent jobs( and unbind the scheduler fence 
> callback for them), after hw fence
> Forcely set to drv_seq, all hw fence are signaled (this is the way of 
> original logic, I didn't change that).  When go to sched_recovery(), 
> it will recover all innocent job and hook
> The scheduler fence with new hw fence.  That way only the guilty job 
> is dropped forever.
>
> -----Original Message-----
> From: Christian König [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
> Sent: Monday, May 08, 2017 9:12 PM
> To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
> Subject: Re: [PATCH 4/4] drm/amdgpu/SRIOV:implement guilty job TDR (V2)
>
> Am 08.05.2017 um 09:01 schrieb Liu, Monk:
> > @Christian
> >
> > This one is changed to guilty job scheme accordingly with your
> > response
> >
> > BR Monk
> >
> > -----Original Message-----
> > From: Monk Liu [mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org]
> > Sent: Monday, May 08, 2017 3:00 PM
> > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Cc: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> > Subject: [PATCH] drm/amdgpu/SRIOV:implement guilty job TDR (V2)
> >
> > 1,TDR will kickout guilty job if it hang exceed the threshold of the 
> given one from kernel paramter "job_hang_limit", that way a bad 
> command stream will not infinitly cause GPU hang.
> >
> > by default this threshold is 1 so a job will be kicked out after it 
> hang.
> >
> > 2,if a job timeout TDR routine will not reset all sched/ring, 
> instead if will only reset on the givn one which is indicated by @job 
> of amdgpu_sriov_gpu_reset, that way we don't need to reset and recover 
> each sched/ring if we already know which job cause GPU hang.
> >
> > 3,unblock sriov_gpu_reset for AI family.
> > 4,don't init entity for KIQ
> >
> > TODO:
> > when a job is considered as guilty, we should mark some flag in its 
> fence status flag, and let UMD side aware that this fence signaling is 
> not due to job complete but job hang.
> >
> > Change-Id: I7b89c19a3de93249db570d0a80522176b1525a09
> > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  4 +++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 36 
> ++++++++++++++++++++-------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  4 +++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  6 +++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  1 +
> >   drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 11 +++++++-  
> drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |  7 ++++++
> >   8 files changed, 60 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 90a69bf..93bcea2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -111,6 +111,7 @@ extern int amdgpu_prim_buf_per_se; extern int
> > amdgpu_pos_buf_per_se;  extern int amdgpu_cntl_sb_buf_per_se;  extern
> > int amdgpu_param_buf_per_se;
> > +extern int amdgpu_job_hang_limit;
> >
> >   #define AMDGPU_DEFAULT_GTT_SIZE_MB          3072ULL /* 3GB by 
> default */
> >   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS 3000
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > index b4bbbb3..23afc58 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -52,6 +52,10 @@ static int amdgpu_ctx_init(struct amdgpu_device 
> *adev, struct amdgpu_ctx *ctx)
> >                struct amd_sched_rq *rq;
> >
> >                rq = &ring->sched.sched_rq[AMD_SCHED_PRIORITY_NORMAL];
> > +
> > +             if (ring == &adev->gfx.kiq.ring)
> > +                     continue;
> > +
>
> That looks like a bug fix and should probably go into a separate patch.
>
> >                r = amd_sched_entity_init(&ring->sched, 
> &ctx->rings[i].entity,
> >                                          rq, amdgpu_sched_jobs);
> >                if (r)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 0e5f314..f3990fe 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2537,7 +2537,7 @@ static int 
> amdgpu_recover_vram_from_shadow(struct amdgpu_device *adev,
> >    */
> >   int amdgpu_sriov_gpu_reset(struct amdgpu_device *adev, struct 
> amdgpu_job *job)  {
> > -     int i, r = 0;
> > +     int i, j, r = 0;
> >        int resched;
> >        struct amdgpu_bo *bo, *tmp;
> >        struct amdgpu_ring *ring;
> > @@ -2550,19 +2550,30 @@ int amdgpu_sriov_gpu_reset(struct 
> amdgpu_device *adev, struct amdgpu_job *job)
> >        /* block TTM */
> >        resched = ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> >
> > -     /* block scheduler */
> > -     for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> > -             ring = adev->rings[i];
> > +     /* we start from the ring trigger GPU hang */
> > +     j = job ? job->ring->idx : 0;
> > +
> > +     if (job)
> > +             if (amd_sched_invalidate_job(&job->base, 
> amdgpu_job_hang_limit))
> > + amd_sched_job_kickout(&job->base);
>
> Well that looks like the wrong order to me. We should probably stop 
> the scheduler before trying to mess anything with the job.
>
> >
> > +     /* block scheduler */
> > +     for (i = j; i < j + AMDGPU_MAX_RINGS; ++i) {
> > +             ring = adev->rings[i % AMDGPU_MAX_RINGS];
> >                if (!ring || !ring->sched.thread)
> >                        continue;
> >
> >                kthread_park(ring->sched.thread);
> > +
> > +             if (job && j != i)
> > +                     continue;
> > +
> > +             /* only do job_reset on the hang ring if @job not NULL */
> > amd_sched_hw_job_reset(&ring->sched);
> > -     }
> >
> > -     /* after all hw jobs are reset, hw fence is meaningless, so 
> force_completion */
> > -     amdgpu_fence_driver_force_completion(adev);
> > +             /* after all hw jobs are reset, hw fence is 
> meaningless, so force_completion */
> > + amdgpu_fence_driver_force_completion_ring(ring);
> > +     }
> >
> >        /* request to take full control of GPU before 
> re-initialization  */
> >        if (job)
> > @@ -2615,11 +2626,16 @@ int amdgpu_sriov_gpu_reset(struct 
> amdgpu_device *adev, struct amdgpu_job *job)
> >        }
> >        fence_put(fence);
> >
> > -     for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> > -             struct amdgpu_ring *ring = adev->rings[i];
> > +     for (i = j; i < j + AMDGPU_MAX_RINGS; ++i) {
> > +             ring = adev->rings[i % AMDGPU_MAX_RINGS];
> >                if (!ring || !ring->sched.thread)
> >                        continue;
> >
> > +             if (job && j != i) {
> > + kthread_unpark(ring->sched.thread);
> > +                     continue;
> > +             }
> > +
>
> Please split up that patch a bit further. E.g. first the handling to 
> only hw_job_reset the ring in question, then the kickout handling.
>
> > amd_sched_job_recovery(&ring->sched);
> >                kthread_unpark(ring->sched.thread);
> >        }
> > @@ -2629,6 +2645,8 @@ int amdgpu_sriov_gpu_reset(struct 
> amdgpu_device *adev, struct amdgpu_job *job)
> >        if (r) {
> >                /* bad news, how to tell it to userspace ? */
> >                dev_info(adev->dev, "GPU reset failed\n");
> > +     } else {
> > +             dev_info(adev->dev, "GPU reset successed!\n");
> >        }
> >
> >        adev->gfx.in_reset = false;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 416908a..fd3691a8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -112,6 +112,7 @@ int amdgpu_prim_buf_per_se = 0; int
> > amdgpu_pos_buf_per_se = 0;  int amdgpu_cntl_sb_buf_per_se = 0;  int
> > amdgpu_param_buf_per_se = 0;
> > +int amdgpu_job_hang_limit = 0;
> >
> >   MODULE_PARM_DESC(vramlimit, "Restrict VRAM for testing, in
> > megabytes");  module_param_named(vramlimit, amdgpu_vram_limit, int,
> > 0600); @@ -237,6 +238,9 @@ module_param_named(cntl_sb_buf_per_se,
> > amdgpu_cntl_sb_buf_per_se, int, 0444);
> > MODULE_PARM_DESC(param_buf_per_se, "the size of Off-Chip Pramater
> > Cache per Shader Engine (default depending on gfx)");
> > module_param_named(param_buf_per_se, amdgpu_param_buf_per_se, int,
> > 0444);
> >
> > +MODULE_PARM_DESC(job_hang_limit, "how much time allow a job hang and
> > +not drop it (default 0)"); module_param_named(job_hang_limit,
> > +amdgpu_job_hang_limit, int ,0444);
> > +
> >
> >   static const struct pci_device_id pciidlist[] = { #ifdef
> > CONFIG_DRM_AMDGPU_SI diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > index d7523d1..8de3bd3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -541,6 +541,12 @@ void 
> amdgpu_fence_driver_force_completion(struct amdgpu_device *adev)
> >        }
> >   }
> >
> > +void amdgpu_fence_driver_force_completion_ring(struct amdgpu_ring
> > +*ring) {
> > +     if (ring)
> > +             amdgpu_fence_write(ring, ring->fence_drv.sync_seq); }
> > +
>
> The coding style is completely off.
>
> Additional to that I don't think that this is a good idea. We should 
> probably rather just signal all scheduler fences instead and don't 
> touch the hardware fence at all.
>
> >   /*
> >    * Common fence implementation
> >    */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 981ef08..03e88c6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -76,6 +76,7 @@ struct amdgpu_fence_driver {  int
> > amdgpu_fence_driver_init(struct amdgpu_device *adev); void
> > amdgpu_fence_driver_fini(struct amdgpu_device *adev); void
> > amdgpu_fence_driver_force_completion(struct amdgpu_device *adev);
> > +void amdgpu_fence_driver_force_completion_ring(struct amdgpu_ring
> > +*ring);
> >
> >   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
> >                                  unsigned num_hw_submission);
> > diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> > b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> > index 6f4e31f..4e97e6d 100644
> > --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> > +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
> > @@ -390,9 +390,18 @@ void amd_sched_hw_job_reset(struct 
> amd_gpu_scheduler *sched)
> > &s_job->s_fence->cb)) {
> > fence_put(s_job->s_fence->parent);
> >                        s_job->s_fence->parent = NULL;
> > + atomic_dec(&sched->hw_rq_count);
> >                }
> >        }
> > -     atomic_set(&sched->hw_rq_count, 0);
> > +     spin_unlock(&sched->job_list_lock);
> > +}
> > +
> > +void amd_sched_job_kickout(struct amd_sched_job *s_job) {
> > +     struct amd_gpu_scheduler *sched = s_job->sched;
> > +
> > +     spin_lock(&sched->job_list_lock);
> > +     list_del_init(&s_job->node);
> >        spin_unlock(&sched->job_list_lock);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> > b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> > index 8cb41d3..59694f3 100644
> > --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> > +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
> > @@ -81,6 +81,7 @@ struct amd_sched_job {
> >        struct list_head                node;
> >        struct delayed_work             work_tdr;
> >        uint64_t                        id;
> > +     atomic_t karma;
> >   };
> >
> >   extern const struct fence_ops amd_sched_fence_ops_scheduled; @@ 
> -96,6 +97,11 @@ static inline struct amd_sched_fence 
> *to_amd_sched_fence(struct fence *f)
> >        return NULL;
> >   }
> >
> > +static inline bool amd_sched_invalidate_job(struct amd_sched_job
> > +*s_job, int threshold) {
> > +     return (s_job && atomic_inc_return(&s_job->karma) > threshold); }
> > +
>
> Again coding style is completely off.
>
> Christian.
>
> >   /**
> >    * Define the backend operations called by the scheduler,
> >    * these functions should be implemented in driver side @@ -158,4 
> +164,5 @@ int amd_sched_job_init(struct amd_sched_job *job,
> >                       void *owner);
> >   void amd_sched_hw_job_reset(struct amd_gpu_scheduler *sched);  void
> > amd_sched_job_recovery(struct amd_gpu_scheduler *sched);
> > +void amd_sched_job_kickout(struct amd_sched_job *s_job);
> >   #endif
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>


--------------360C05E31E12B96B2E70979A
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite"><font size="2"><span
            style="font-size:10pt;">[ML] Really not necessary, we have
            spin_lock to protect the mirror-list, nothing will be messed
            up ...<br>
          </span></font></blockquote>
      You are missing that it is entirely possible that the job will
      complete while we are trying to kick it out.<br>
      <br>
      <blockquote type="cite"><font size="2"><span
            style="font-size:10pt;">[ML] why don't touch hardware fence
            at all ?  the original/bare-metal gpu reset also signal all
            ring's hardware fence first, I just follow the original
            logic ...<br>
            Scheduler fence will be auto signaled after hw fence
            signaled, any problem with that ? what's the concern ?</span></font></blockquote>
      The hardware runs async to the CPU which tries to reset it, so we
      need to be careful in which order things are done.<br>
      <br>
      <blockquote type="cite"><font size="2"><span
            style="font-size:10pt;">
            [ML] No I don't think so, the kickout must be prior to the
            hw_job_reset, otherwise the scheduler fence callback will be
            removed and you need manually install it later , which is
            not correct:<br>
            For the guity job, we just kick it out before job reset, in
            job_reset we only reset other innocent jobs( and unbind the
            scheduler fence callback for them), after hw fence<br>
            Forcely set to drv_seq, all hw fence are signaled (this is
            the way of original logic, I didn't change that).  When go
            to sched_recovery(), it will recover all innocent job and
            hook<br>
            The scheduler fence with new hw fence.  That way only the
            guilty job is dropped forever.<br>
          </span></font></blockquote>
      Again same problem here.<br>
      <br>
      To be absolutely sure that everything works as expected we need to
      do it in the following order:<br>
      <br>
      1. Stop the scheduler from feeding more jobs to the hardware when
      a jobs completes.<br>
      <br>
      2. Then call hw_job_reset to remove the connection between job and
      hardware fence.<br>
      <br>
      3. Test if job is now completed. It is entirely possible that the
      job completed while we started the work to reset the hardware.<br>
      <br>
      Removing the connection between the hardware fence and the job is
      the deadline, if the job completes after that it is lost.<br>
      <br>
      4. Check the karma and kick out the job if we found it guilty.<br>
      <br>
      5. Get the whole stuff working again, e.g. reset the hardware,
      restart the scheduler etc...<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 09.05.2017 um 04:45 schrieb Liu, Monk:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB1610CE19C4173C5764CACFA984EF0-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">&gt;   <br>
            &gt; -     /* block scheduler */<br>
            &gt; -     for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
            &gt; -             ring = adev-&gt;rings[i];<br>
            &gt; +     /* we start from the ring trigger GPU hang */<br>
            &gt; +     j = job ? job-&gt;ring-&gt;idx : 0;<br>
            &gt; +<br>
            &gt; +     if (job)<br>
            &gt; +             if
            (amd_sched_invalidate_job(&amp;job-&gt;base,
            amdgpu_job_hang_limit))<br>
            &gt; +                    
            amd_sched_job_kickout(&amp;job-&gt;base);<br>
            <br>
            Well that looks like the wrong order to me. We should
            probably stop the scheduler before trying to mess anything
            with the job.<br>
            <br>
            [ML] Really not necessary, we have spin_lock to protect the
            mirror-list, nothing will be messed up ...<br>
            <br>
            <br>
            &gt;   <br>
            &gt; +void amdgpu_fence_driver_force_completion_ring(struct
            amdgpu_ring<br>
            &gt; +*ring) {<br>
            &gt; +     if (ring)<br>
            &gt; +             amdgpu_fence_write(ring,
            ring-&gt;fence_drv.sync_seq); }<br>
            &gt; +<br>
            <br>
            The coding style is completely off.<br>
            <br>
            [ML] I don't know why at email side it looks wrong coding
            style, but I'm sure it is correct at my side, check here:<br>
            void amdgpu_fence_driver_force_completion_ring(struct
            amdgpu_ring *ring)<br>
            {<br>
                    if (ring)<br>
                            amdgpu_fence_write(ring,
            ring-&gt;fence_drv.sync_seq);<br>
            }<br>
            <br>
            Additional to that I don't think that this is a good idea.
            We should probably rather just signal all scheduler fences
            instead and don't touch the hardware fence at all.<br>
            <br>
            [ML] why don't touch hardware fence at all ?  the
            original/bare-metal gpu reset also signal all ring's
            hardware fence first, I just follow the original logic ...<br>
            Scheduler fence will be auto signaled after hw fence
            signaled, any problem with that ? what's the concern ?<br>
            <br>
            <br>
            &gt; -     for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
            &gt; -             struct amdgpu_ring *ring =
            adev-&gt;rings[i];<br>
            &gt; +     for (i = j; i &lt; j + AMDGPU_MAX_RINGS; ++i) {<br>
            &gt; +             ring = adev-&gt;rings[i %
            AMDGPU_MAX_RINGS];<br>
            &gt;                if (!ring || !ring-&gt;sched.thread)<br>
            &gt;                        continue;<br>
            &gt;   <br>
            &gt; +             if (job &amp;&amp; j != i) {<br>
            &gt; +                    
            kthread_unpark(ring-&gt;sched.thread);<br>
            &gt; +                     continue;<br>
            &gt; +             }<br>
            &gt; +<br>
            <br>
            Please split up that patch a bit further. E.g. first the
            handling to only hw_job_reset the ring in question, then the
            kickout handling.<br>
            <br>
            [ML] No I don't think so, the kickout must be prior to the
            hw_job_reset, otherwise the scheduler fence callback will be
            removed and you need manually install it later , which is
            not correct:<br>
            For the guity job, we just kick it out before job reset, in
            job_reset we only reset other innocent jobs( and unbind the
            scheduler fence callback for them), after hw fence<br>
            Forcely set to drv_seq, all hw fence are signaled (this is
            the way of original logic, I didn't change that).  When go
            to sched_recovery(), it will recover all innocent job and
            hook<br>
            The scheduler fence with new hw fence.  That way only the
            guilty job is dropped forever.<br>
            <br>
            -----Original Message-----<br>
            From: Christian König [<a moz-do-not-send="true"
              href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>]
            <br>
            Sent: Monday, May 08, 2017 9:12 PM<br>
            To: Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            Cc: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            Subject: Re: [PATCH 4/4] drm/amdgpu/SRIOV:implement guilty
            job TDR (V2)<br>
            <br>
            Am 08.05.2017 um 09:01 schrieb Liu, Monk:<br>
            &gt; @Christian<br>
            &gt;<br>
            &gt; This one is changed to guilty job scheme accordingly
            with your <br>
            &gt; response<br>
            &gt;<br>
            &gt; BR Monk<br>
            &gt;<br>
            &gt; -----Original Message-----<br>
            &gt; From: Monk Liu [<a moz-do-not-send="true"
              href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>]<br>
            &gt; Sent: Monday, May 08, 2017 3:00 PM<br>
            &gt; To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; Cc: Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; Subject: [PATCH] drm/amdgpu/SRIOV:implement guilty job
            TDR (V2)<br>
            &gt;<br>
            &gt; 1,TDR will kickout guilty job if it hang exceed the
            threshold of the given one from kernel paramter
            "job_hang_limit", that way a bad command stream will not
            infinitly cause GPU hang.<br>
            &gt;<br>
            &gt; by default this threshold is 1 so a job will be kicked
            out after it hang.<br>
            &gt;<br>
            &gt; 2,if a job timeout TDR routine will not reset all
            sched/ring, instead if will only reset on the givn one which
            is indicated by @job of amdgpu_sriov_gpu_reset, that way we
            don't need to reset and recover each sched/ring if we
            already know which job cause GPU hang.<br>
            &gt;<br>
            &gt; 3,unblock sriov_gpu_reset for AI family.<br>
            &gt; 4,don't init entity for KIQ<br>
            &gt;<br>
            &gt; TODO:<br>
            &gt; when a job is considered as guilty, we should mark some
            flag in its fence status flag, and let UMD side aware that
            this fence signaling is not due to job complete but job
            hang.<br>
            &gt;<br>
            &gt; Change-Id: I7b89c19a3de93249db570d0a80522176b1525a09<br>
            &gt; Signed-off-by: Monk Liu <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; ---<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  4
            +++<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 36
            ++++++++++++++++++++-------<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  4
            +++<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  6
            +++++<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  1 +<br>
            &gt;   drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 11
            +++++++-  drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |  7
            ++++++<br>
            &gt;   8 files changed, 60 insertions(+), 10 deletions(-)<br>
            &gt;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            &gt; index 90a69bf..93bcea2 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            &gt; @@ -111,6 +111,7 @@ extern int amdgpu_prim_buf_per_se; 
            extern int <br>
            &gt; amdgpu_pos_buf_per_se;  extern int
            amdgpu_cntl_sb_buf_per_se;  extern <br>
            &gt; int amdgpu_param_buf_per_se;<br>
            &gt; +extern int amdgpu_job_hang_limit;<br>
            &gt;   <br>
            &gt;   #define AMDGPU_DEFAULT_GTT_SIZE_MB          3072ULL
            /* 3GB by default */<br>
            &gt;   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS             
            3000<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
            &gt; index b4bbbb3..23afc58 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
            &gt; @@ -52,6 +52,10 @@ static int amdgpu_ctx_init(struct
            amdgpu_device *adev, struct amdgpu_ctx *ctx)<br>
            &gt;                struct amd_sched_rq *rq;<br>
            &gt;   <br>
            &gt;                rq =
            &amp;ring-&gt;sched.sched_rq[AMD_SCHED_PRIORITY_NORMAL];<br>
            &gt; +<br>
            &gt; +             if (ring == &amp;adev-&gt;gfx.kiq.ring)<br>
            &gt; +                     continue;<br>
            &gt; +<br>
            <br>
            That looks like a bug fix and should probably go into a
            separate patch.<br>
            <br>
            &gt;                r =
            amd_sched_entity_init(&amp;ring-&gt;sched,
            &amp;ctx-&gt;rings[i].entity,<br>
            &gt;                                          rq,
            amdgpu_sched_jobs);<br>
            &gt;                if (r)<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; index 0e5f314..f3990fe 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; @@ -2537,7 +2537,7 @@ static int
            amdgpu_recover_vram_from_shadow(struct amdgpu_device *adev,<br>
            &gt;    */<br>
            &gt;   int amdgpu_sriov_gpu_reset(struct amdgpu_device
            *adev, struct amdgpu_job *job)  {<br>
            &gt; -     int i, r = 0;<br>
            &gt; +     int i, j, r = 0;<br>
            &gt;        int resched;<br>
            &gt;        struct amdgpu_bo *bo, *tmp;<br>
            &gt;        struct amdgpu_ring *ring;<br>
            &gt; @@ -2550,19 +2550,30 @@ int
            amdgpu_sriov_gpu_reset(struct amdgpu_device *adev, struct
            amdgpu_job *job)<br>
            &gt;        /* block TTM */<br>
            &gt;        resched =
            ttm_bo_lock_delayed_workqueue(&amp;adev-&gt;mman.bdev);<br>
            &gt;   <br>
            &gt; -     /* block scheduler */<br>
            &gt; -     for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
            &gt; -             ring = adev-&gt;rings[i];<br>
            &gt; +     /* we start from the ring trigger GPU hang */<br>
            &gt; +     j = job ? job-&gt;ring-&gt;idx : 0;<br>
            &gt; +<br>
            &gt; +     if (job)<br>
            &gt; +             if
            (amd_sched_invalidate_job(&amp;job-&gt;base,
            amdgpu_job_hang_limit))<br>
            &gt; +                    
            amd_sched_job_kickout(&amp;job-&gt;base);<br>
            <br>
            Well that looks like the wrong order to me. We should
            probably stop the scheduler before trying to mess anything
            with the job.<br>
            <br>
            &gt;   <br>
            &gt; +     /* block scheduler */<br>
            &gt; +     for (i = j; i &lt; j + AMDGPU_MAX_RINGS; ++i) {<br>
            &gt; +             ring = adev-&gt;rings[i %
            AMDGPU_MAX_RINGS];<br>
            &gt;                if (!ring || !ring-&gt;sched.thread)<br>
            &gt;                        continue;<br>
            &gt;   <br>
            &gt;                kthread_park(ring-&gt;sched.thread);<br>
            &gt; +<br>
            &gt; +             if (job &amp;&amp; j != i)<br>
            &gt; +                     continue;<br>
            &gt; +<br>
            &gt; +             /* only do job_reset on the hang ring if
            @job not NULL */<br>
            &gt;               
            amd_sched_hw_job_reset(&amp;ring-&gt;sched);<br>
            &gt; -     }<br>
            &gt;   <br>
            &gt; -     /* after all hw jobs are reset, hw fence is
            meaningless, so force_completion */<br>
            &gt; -     amdgpu_fence_driver_force_completion(adev);<br>
            &gt; +             /* after all hw jobs are reset, hw fence
            is meaningless, so force_completion */<br>
            &gt; +            
            amdgpu_fence_driver_force_completion_ring(ring);<br>
            &gt; +     }<br>
            &gt;   <br>
            &gt;        /* request to take full control of GPU before
            re-initialization  */<br>
            &gt;        if (job)<br>
            &gt; @@ -2615,11 +2626,16 @@ int
            amdgpu_sriov_gpu_reset(struct amdgpu_device *adev, struct
            amdgpu_job *job)<br>
            &gt;        }<br>
            &gt;        fence_put(fence);<br>
            &gt;   <br>
            &gt; -     for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
            &gt; -             struct amdgpu_ring *ring =
            adev-&gt;rings[i];<br>
            &gt; +     for (i = j; i &lt; j + AMDGPU_MAX_RINGS; ++i) {<br>
            &gt; +             ring = adev-&gt;rings[i %
            AMDGPU_MAX_RINGS];<br>
            &gt;                if (!ring || !ring-&gt;sched.thread)<br>
            &gt;                        continue;<br>
            &gt;   <br>
            &gt; +             if (job &amp;&amp; j != i) {<br>
            &gt; +                    
            kthread_unpark(ring-&gt;sched.thread);<br>
            &gt; +                     continue;<br>
            &gt; +             }<br>
            &gt; +<br>
            <br>
            Please split up that patch a bit further. E.g. first the
            handling to only hw_job_reset the ring in question, then the
            kickout handling.<br>
            <br>
            &gt;               
            amd_sched_job_recovery(&amp;ring-&gt;sched);<br>
            &gt;                kthread_unpark(ring-&gt;sched.thread);<br>
            &gt;        }<br>
            &gt; @@ -2629,6 +2645,8 @@ int amdgpu_sriov_gpu_reset(struct
            amdgpu_device *adev, struct amdgpu_job *job)<br>
            &gt;        if (r) {<br>
            &gt;                /* bad news, how to tell it to userspace
            ? */<br>
            &gt;                dev_info(adev-&gt;dev, "GPU reset
            failed\n");<br>
            &gt; +     } else {<br>
            &gt; +             dev_info(adev-&gt;dev, "GPU reset
            successed!\n");<br>
            &gt;        }<br>
            &gt;   <br>
            &gt;        adev-&gt;gfx.in_reset = false;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
            &gt; index 416908a..fd3691a8 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
            &gt; @@ -112,6 +112,7 @@ int amdgpu_prim_buf_per_se = 0; 
            int <br>
            &gt; amdgpu_pos_buf_per_se = 0;  int
            amdgpu_cntl_sb_buf_per_se = 0;  int <br>
            &gt; amdgpu_param_buf_per_se = 0;<br>
            &gt; +int amdgpu_job_hang_limit = 0;<br>
            &gt;   <br>
            &gt;   MODULE_PARM_DESC(vramlimit, "Restrict VRAM for
            testing, in <br>
            &gt; megabytes");  module_param_named(vramlimit,
            amdgpu_vram_limit, int, <br>
            &gt; 0600); @@ -237,6 +238,9 @@
            module_param_named(cntl_sb_buf_per_se, <br>
            &gt; amdgpu_cntl_sb_buf_per_se, int, 0444);  <br>
            &gt; MODULE_PARM_DESC(param_buf_per_se, "the size of
            Off-Chip Pramater <br>
            &gt; Cache per Shader Engine (default depending on gfx)"); 
            <br>
            &gt; module_param_named(param_buf_per_se,
            amdgpu_param_buf_per_se, int, <br>
            &gt; 0444);<br>
            &gt;   <br>
            &gt; +MODULE_PARM_DESC(job_hang_limit, "how much time allow
            a job hang and <br>
            &gt; +not drop it (default 0)");
            module_param_named(job_hang_limit,<br>
            &gt; +amdgpu_job_hang_limit, int ,0444);<br>
            &gt; +<br>
            &gt;   <br>
            &gt;   static const struct pci_device_id pciidlist[] = { 
            #ifdef  <br>
            &gt; CONFIG_DRM_AMDGPU_SI diff --git <br>
            &gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
            &gt; index d7523d1..8de3bd3 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
            &gt; @@ -541,6 +541,12 @@ void
            amdgpu_fence_driver_force_completion(struct amdgpu_device
            *adev)<br>
            &gt;        }<br>
            &gt;   }<br>
            &gt;   <br>
            &gt; +void amdgpu_fence_driver_force_completion_ring(struct
            amdgpu_ring<br>
            &gt; +*ring) {<br>
            &gt; +     if (ring)<br>
            &gt; +             amdgpu_fence_write(ring,
            ring-&gt;fence_drv.sync_seq); }<br>
            &gt; +<br>
            <br>
            The coding style is completely off.<br>
            <br>
            Additional to that I don't think that this is a good idea.
            We should probably rather just signal all scheduler fences
            instead and don't touch the hardware fence at all.<br>
            <br>
            &gt;   /*<br>
            &gt;    * Common fence implementation<br>
            &gt;    */<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
            &gt; index 981ef08..03e88c6 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
            &gt; @@ -76,6 +76,7 @@ struct amdgpu_fence_driver {  int <br>
            &gt; amdgpu_fence_driver_init(struct amdgpu_device *adev); 
            void <br>
            &gt; amdgpu_fence_driver_fini(struct amdgpu_device *adev); 
            void <br>
            &gt; amdgpu_fence_driver_force_completion(struct
            amdgpu_device *adev);<br>
            &gt; +void amdgpu_fence_driver_force_completion_ring(struct
            amdgpu_ring <br>
            &gt; +*ring);<br>
            &gt;   <br>
            &gt;   int amdgpu_fence_driver_init_ring(struct amdgpu_ring
            *ring,<br>
            &gt;                                  unsigned
            num_hw_submission);<br>
            &gt; diff --git
            a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c <br>
            &gt; b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
            &gt; index 6f4e31f..4e97e6d 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
            &gt; @@ -390,9 +390,18 @@ void amd_sched_hw_job_reset(struct
            amd_gpu_scheduler *sched)<br>
            &gt;                                         
            &amp;s_job-&gt;s_fence-&gt;cb)) {<br>
            &gt;                       
            fence_put(s_job-&gt;s_fence-&gt;parent);<br>
            &gt;                        s_job-&gt;s_fence-&gt;parent =
            NULL;<br>
            &gt; +                    
            atomic_dec(&amp;sched-&gt;hw_rq_count);<br>
            &gt;                }<br>
            &gt;        }<br>
            &gt; -     atomic_set(&amp;sched-&gt;hw_rq_count, 0);<br>
            &gt; +     spin_unlock(&amp;sched-&gt;job_list_lock);<br>
            &gt; +}<br>
            &gt; +<br>
            &gt; +void amd_sched_job_kickout(struct amd_sched_job
            *s_job) {<br>
            &gt; +     struct amd_gpu_scheduler *sched =
            s_job-&gt;sched;<br>
            &gt; +<br>
            &gt; +     spin_lock(&amp;sched-&gt;job_list_lock);<br>
            &gt; +     list_del_init(&amp;s_job-&gt;node);<br>
            &gt;        spin_unlock(&amp;sched-&gt;job_list_lock);<br>
            &gt;   }<br>
            &gt;   <br>
            &gt; diff --git
            a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h <br>
            &gt; b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
            &gt; index 8cb41d3..59694f3 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
            &gt; @@ -81,6 +81,7 @@ struct amd_sched_job {<br>
            &gt;        struct list_head                node;<br>
            &gt;        struct delayed_work             work_tdr;<br>
            &gt;        uint64_t                        id;<br>
            &gt; +     atomic_t karma;<br>
            &gt;   };<br>
            &gt;   <br>
            &gt;   extern const struct fence_ops
            amd_sched_fence_ops_scheduled; @@ -96,6 +97,11 @@ static
            inline struct amd_sched_fence *to_amd_sched_fence(struct
            fence *f)<br>
            &gt;        return NULL;<br>
            &gt;   }<br>
            &gt;   <br>
            &gt; +static inline bool amd_sched_invalidate_job(struct
            amd_sched_job <br>
            &gt; +*s_job, int threshold) {<br>
            &gt; +     return (s_job &amp;&amp;
            atomic_inc_return(&amp;s_job-&gt;karma) &gt; threshold); }<br>
            &gt; +<br>
            <br>
            Again coding style is completely off.<br>
            <br>
            Christian.<br>
            <br>
            &gt;   /**<br>
            &gt;    * Define the backend operations called by the
            scheduler,<br>
            &gt;    * these functions should be implemented in driver
            side @@ -158,4 +164,5 @@ int amd_sched_job_init(struct
            amd_sched_job *job,<br>
            &gt;                       void *owner);<br>
            &gt;   void amd_sched_hw_job_reset(struct amd_gpu_scheduler
            *sched);  void <br>
            &gt; amd_sched_job_recovery(struct amd_gpu_scheduler
            *sched);<br>
            &gt; +void amd_sched_job_kickout(struct amd_sched_job
            *s_job);<br>
            &gt;   #endif<br>
            &gt; --<br>
            &gt; 2.7.4<br>
            &gt;<br>
            &gt; _______________________________________________<br>
            &gt; amd-gfx mailing list<br>
            &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; <a moz-do-not-send="true"
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            <br>
            <br>
          </div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------360C05E31E12B96B2E70979A--

--===============0839500436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0839500436==--
