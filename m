From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu/SRIOV:implement guilty job TDR (V2)
Date: Wed, 10 May 2017 12:26:05 +0200
Message-ID: <b7e4ce5c-7992-a72a-c935-1db202f4615f@vodafone.de>
References: <DM5PR12MB1610CE50CEC9AB4A30B1164F84EE0@DM5PR12MB1610.namprd12.prod.outlook.com>
 <d6d293a4-4529-ffb1-394f-8fb0cc2a384d@vodafone.de>
 <DM5PR12MB1610CE19C4173C5764CACFA984EF0@DM5PR12MB1610.namprd12.prod.outlook.com>
 <034faac0-870e-b751-2a4e-3663dd80bbb6@amd.com>
 <DM5PR12MB161042624A3F706EFA8ADF2384EF0@DM5PR12MB1610.namprd12.prod.outlook.com>
 <7e6f651d-086e-35e2-5df5-89769cf2875e@amd.com>
 <DM5PR12MB16103C47D81A32009CD1011984EC0@DM5PR12MB1610.namprd12.prod.outlook.com>
 <00e571fe-d200-3d72-f3c0-91eefc3751d4@vodafone.de>
 <DM5PR12MB1610A13032697B40B7BB4A5984EC0@DM5PR12MB1610.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1534857339=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1610A13032697B40B7BB4A5984EC0-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1534857339==
Content-Type: multipart/alternative;
 boundary="------------FA66D46F1B9219BE83D92780"

This is a multi-part message in MIME format.
--------------FA66D46F1B9219BE83D92780
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.05.2017 um 12:05 schrieb Liu, Monk:
>
> [ML] yes, but we cannot guarantee the job is 100% really hang when 
> entering gpu_reset(), we can only trust our amdgpu_job_timeout as a 
> deadline for each job.
>
> You approach that check the fence first before charge it as 
> guilty/hang is incorrect looks to me because why you not check it 
> twice, triple, and even more loops ?
>
> Because the job can't signal any more after calling 
> amd_sched_hw_job_reset().
>
> [ML] No … that’s where I think your approach is vague:
>
> 1) see that you check after scheduler stopped, see if job signaled, my 
> question is if the job is not signaled (like most usual case)
>
> Why you not check it again and again ?  maybe the second time you will 
> find it signaled …
>

Checking a second time is pointless since it can't signal any more after 
calling amd_sched_hw_job_reset().

> My point is the checking here is meaningless, we already have timedout 
> for the guard.
>
No, the timeout is pretty meaningless. It's just the trigger that we 
need to do something.

But to determine what to do we first need to stop the scheduler, remove 
the hardware fence and THEN check the current status.

Otherwise we have a race condition here where we can't determine if the 
reset finished the job or if it did just on it's own while we stopped 
the scheduler.

> 2) And even it signaled after entering gpu_reset(), it will 
> automatically done like normal cases, that’s good. Why remove those 
> callback instead ?
>
No, that's absolutely not good. We don't know if it's the hardware which 
results in the job being signaled or our reset code.

>
>     So I refuse to check if @job is just signaled in gpu_reset,
>     because this action is vague (and no one can guarantee the job
>     won’t signal during gpu_reset, we should not argue on this event
>     …), I prefer clean and restrict rules.
>
> Yeah, completely agree that we need to have struct rules for that. 
> That's why I insists on doing this :)
>
> No, you are insist on a vague rules not strict, like I said, what is 
> the theoretic to backend your approach that only check once on the in 
> question job ? why not check again if not signaled ?
>
Because we have removed the connection between the job and the hardware 
fence and because of this the job can never signal.

Regards,
Christian.

> I don’t agree this approach is clean and strict. You are abuse 
> timedout parameter.
>
>
>
> See I just want to avoid problems for the case that the job signaled 
> while we stop the scheduler (because stopping the scheduler actually 
> can take a moment).
>
> Because when this happened the scheduler could already have pushed the 
> next job to the hardware and then we abort it with the GPU reset and 
> might create more problems than we solve.
>
>
>
>
>     [ML] I don’t see my approach will have chance to fence twice… on
>     the contrast I think my approach is more clear: no matter the in
>     question job finally signaled or not, I just kick it out from
>     mirror-list
>
>     Without remove the callback from hw fence, that way even it really
>     signaled during the gpu_reset() period the logic is still perfect
>     and its sched fence will act like usual …
>
> We want to set an error code on the job before signaling it don't we? 
> So we need to be sure how and when the job is signaled as finished.
>
> I mean letting it signal when we force the hardware fence to complete 
> will work as well, but I still think that this isn't as clean as 
> signaling it manually.
>
> Please also see the helper function the Intel guys introduced 
> drm_fence_set_error(), we will run into a BUG_ON if we can't guarantee 
> the order of execution here.
>
> Regards,
> Christian.
>
> Am 10.05.2017 um 06:00 schrieb Liu, Monk:
>
>     Christian,
>
>     Looks like we need more discuss with it…
>
>     Here is your approach:
>
>     1. Stop the scheduler from feeding more jobs to the hardware when
>     a jobs completes.  //this is where I agree with you
>
>     2. Then call hw_job_reset to remove the connection between job and
>     hardware fence.
>
>     3. Test if job is now completed. It is entirely possible that the
>     job completed while we started the work to reset the hardware.
>
>     Removing the connection between the hardware fence and the job is
>     the deadline, if the job completes after that it is lost.
>
>     4. Check the karma and kick out the job if we found it guilty.
>
>     5. Get the whole stuff working again, e.g. reset the hardware,
>     restart the scheduler etc...
>
>     */[ML]: One thing I agree to change with your way: in gpu_reset()
>     we should first stop the in question ring’s scheduler (not the
>     all) before kick out the guilty job./*
>
>     > Indeed, but I still think that this is a bad approach cause we
>     then reset the hardware without a good reason.
>
>     [ML] yes, but we cannot guarantee the job is 100% really hang when
>     entering gpu_reset(), we can only trust our amdgpu_job_timeout as
>     a deadline for each job.
>
>     You approach that check the fence first before charge it as
>     guilty/hang is incorrect looks to me because why you not check it
>     twice, triple, and even more loops ?
>
>     You check it one time and you found it just signaled that’s great
>     and lucky(really lucky…), But what if it didn’t signaled (like
>     most usual case) , why not check it again and again ? do you have
>     a theoretic to support on how much time you need to check before
>     finally consider it hang ? No I don’t think you have so please
>     just cut this unnecessary checking, we already use
>     amdgpu_job_timeout to give the deadline of each job.
>
>     So I refuse to check if @job is just signaled in gpu_reset,
>     because this action is vague (and no one can guarantee the job
>     won’t signal during gpu_reset, we should not argue on this event
>     …), I prefer clean and restrict rules.
>
>     >Force completion is not so much of the issue, but rather in which
>     order you do things.
>
>     >See the original code first stops the scheduler and removes the
>     connection between hardware fence and job in an atomic manner. And
>     THEN forces the hardware fence to complete.
>
>     >This way we could be sure that nothing happened in parallel, e.g.
>     that we don't try to signal the fence twice or something like that.
>
>     [ML] I don’t see my approach will have chance to fence twice… on
>     the contrast I think my approach is more clear: no matter the in
>     question job finally signaled or not, I just kick it out from
>     mirror-list
>
>     Without remove the callback from hw fence, that way even it really
>     signaled during the gpu_reset() period the logic is still perfect
>     and its sched fence will act like usual …
>
>     Please point out where or how my approach will go wrong like “e.g.
>     that we don't try to signal the fence twice or something like
>     that.”, otherwise I cannot be persuaded and fix my way …
>
>     At last. I run the TDR test and it ends up with Hypervisor side
>     error, the guest side is all perfect, here is what I ran:
>
>     The vk_example and vulkan CTS test under MCBP case, we have all
>     kinds of hang on compute ring, without TDR this test won’t suffer
>     for 5 seconds, and with TDR although MCBP is buggy now but we can
>
>     Finish this test (of cause test result is mismatch due to MCBP
>     issue), and there are tongs of job_timed_out in dmesg, but guest
>     driver didn’t have any error report.  I was also surprised this
>     behave really stable …
>
>     The second test the using “watch” to trigger a gpu hang (bad
>     command stream) every 2 seconds, with amdgpu_job_timeout also set
>     to 2seconds, I can run it till hypervisor side hit VF FLR error,
>     and guest side
>
>     Still runs perfectly and nothing wrong happened, with hw fence seq
>     number I can tell there are 3000 loops of TDR finished before
>     Hypervisor hit error.
>
>     BR Monk
>
>     *From:*Koenig, Christian
>     *Sent:* Tuesday, May 09, 2017 8:52 PM
>     *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org> <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>;
>     Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>     <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     *Subject:* Re: [PATCH 4/4] drm/amdgpu/SRIOV:implement guilty job
>     TDR (V2)
>
>         [ML] if the job complete, the job’s sched fence callback will
>         take this spin_lock and remove itself from mirror_list, so we
>         are still safe to call amd_sched_job_kickout(), and it will do
>         nothing if so
>
>     Indeed, but I still think that this is a bad approach cause we
>     then reset the hardware without a good reason.
>
>
>
>         Besides, original logic also force complete the hw fence, and
>         it works well …
>
>     Force completion is not so much of the issue, but rather in which
>     order you do things.
>
>     See the original code first stops the scheduler and removes the
>     connection between hardware fence and job in an atomic manner. And
>     THEN forces the hardware fence to complete.
>
>     This way we could be sure that nothing happened in parallel, e.g.
>     that we don't try to signal the fence twice or something like that.
>
>
>
>         State like “You are missing that it is entirely possible that
>         the job will complete while we are trying to kick it out.”
>
>     Sorry I should have been more clear.
>
>
>
>         Is not a good reason to reject my approach, because that is
>         okay if the job just completed …
>
>     We usually try to take a defensive approach, so stopping
>     everything, removing the hardware fence connection and then
>     explicitly kicking out the job in question sounds much better than
>     doing it implicitly with the hardware fence completion.
>
>     Even when this works (which I'm still not sure of) that is a
>     really awkward and hard to understand approach.
>
>     Regards,
>     Christian.
>
>     Am 09.05.2017 um 13:58 schrieb Liu, Monk:
>
>         You are missing that it is entirely possible that the job will
>         complete while we are trying to kick it out.
>
>         [ML] if the job complete, the job’s sched fence callback will
>         take this spin_lock and remove itself from mirror_list, so we
>         are still safe to call amd_sched_job_kickout(), and it will do
>         nothing if so
>
>         Please go through the whole steps again,
>
>         Besides, original logic also force complete the hw fence, and
>         it works well …
>
>         I don’t see the solid reason why you insist on your approach,
>         please go through the steps again  and give me the details
>         about where is incorrect than I can fix it
>
>         State like “You are missing that it is entirely possible that
>         the job will complete while we are trying to kick it out.” Is
>         not a good reason to reject my approach, because that is okay
>         if the job just completed …
>
>         BR Monk
>
>
>
>         *From:*Koenig, Christian
>         *Sent:* Tuesday, May 09, 2017 3:49 PM
>         *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org> <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>;
>         Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>         <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>;
>         amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         *Subject:* Re: [PATCH 4/4] drm/amdgpu/SRIOV:implement guilty
>         job TDR (V2)
>
>             [ML] Really not necessary, we have spin_lock to protect
>             the mirror-list, nothing will be messed up ...
>
>         You are missing that it is entirely possible that the job will
>         complete while we are trying to kick it out.
>
>
>
>
>             [ML] why don't touch hardware fence at all ?  the
>             original/bare-metal gpu reset also signal all ring's
>             hardware fence first, I just follow the original logic ...
>             Scheduler fence will be auto signaled after hw fence
>             signaled, any problem with that ? what's the concern ?
>
>         The hardware runs async to the CPU which tries to reset it, so
>         we need to be careful in which order things are done.
>
>
>
>
>             [ML] No I don't think so, the kickout must be prior to the
>             hw_job_reset, otherwise the scheduler fence callback will
>             be removed and you need manually install it later , which
>             is not correct:
>             For the guity job, we just kick it out before job reset,
>             in job_reset we only reset other innocent jobs( and unbind
>             the scheduler fence callback for them), after hw fence
>             Forcely set to drv_seq, all hw fence are signaled (this is
>             the way of original logic, I didn't change that).  When go
>             to sched_recovery(), it will recover all innocent job and hook
>             The scheduler fence with new hw fence.  That way only the
>             guilty job is dropped forever.
>
>         Again same problem here.
>
>         To be absolutely sure that everything works as expected we
>         need to do it in the following order:
>
>         1. Stop the scheduler from feeding more jobs to the hardware
>         when a jobs completes.
>
>         2. Then call hw_job_reset to remove the connection between job
>         and hardware fence.
>
>         3. Test if job is now completed. It is entirely possible that
>         the job completed while we started the work to reset the hardware.
>
>         Removing the connection between the hardware fence and the job
>         is the deadline, if the job completes after that it is lost.
>
>         4. Check the karma and kick out the job if we found it guilty.
>
>         5. Get the whole stuff working again, e.g. reset the hardware,
>         restart the scheduler etc...
>
>         Regards,
>         Christian.
>
>         Am 09.05.2017 um 04:45 schrieb Liu, Monk:
>
>             >
>             > -     /* block scheduler */
>             > -     for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>             > -             ring = adev->rings[i];
>             > +     /* we start from the ring trigger GPU hang */
>             > +     j = job ? job->ring->idx : 0;
>             > +
>             > +     if (job)
>             > +             if (amd_sched_invalidate_job(&job->base,
>             amdgpu_job_hang_limit))
>             > + amd_sched_job_kickout(&job->base);
>
>             Well that looks like the wrong order to me. We should
>             probably stop the scheduler before trying to mess anything
>             with the job.
>
>             [ML] Really not necessary, we have spin_lock to protect
>             the mirror-list, nothing will be messed up ...
>
>
>             >
>             > +void amdgpu_fence_driver_force_completion_ring(struct
>             amdgpu_ring
>             > +*ring) {
>             > +     if (ring)
>             > +             amdgpu_fence_write(ring,
>             ring->fence_drv.sync_seq); }
>             > +
>
>             The coding style is completely off.
>
>             [ML] I don't know why at email side it looks wrong coding
>             style, but I'm sure it is correct at my side, check here:
>             void amdgpu_fence_driver_force_completion_ring(struct
>             amdgpu_ring *ring)
>             {
>                     if (ring)
>                             amdgpu_fence_write(ring,
>             ring->fence_drv.sync_seq);
>             }
>
>             Additional to that I don't think that this is a good idea.
>             We should probably rather just signal all scheduler fences
>             instead and don't touch the hardware fence at all.
>
>             [ML] why don't touch hardware fence at all ?  the
>             original/bare-metal gpu reset also signal all ring's
>             hardware fence first, I just follow the original logic ...
>             Scheduler fence will be auto signaled after hw fence
>             signaled, any problem with that ? what's the concern ?
>
>
>             > -     for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>             > -             struct amdgpu_ring *ring = adev->rings[i];
>             > +     for (i = j; i < j + AMDGPU_MAX_RINGS; ++i) {
>             > +             ring = adev->rings[i % AMDGPU_MAX_RINGS];
>             >                if (!ring || !ring->sched.thread)
>             >                        continue;
>             >
>             > +             if (job && j != i) {
>             > + kthread_unpark(ring->sched.thread);
>             > +                     continue;
>             > +             }
>             > +
>
>             Please split up that patch a bit further. E.g. first the
>             handling to only hw_job_reset the ring in question, then
>             the kickout handling.
>
>             [ML] No I don't think so, the kickout must be prior to the
>             hw_job_reset, otherwise the scheduler fence callback will
>             be removed and you need manually install it later , which
>             is not correct:
>             For the guity job, we just kick it out before job reset,
>             in job_reset we only reset other innocent jobs( and unbind
>             the scheduler fence callback for them), after hw fence
>             Forcely set to drv_seq, all hw fence are signaled (this is
>             the way of original logic, I didn't change that).  When go
>             to sched_recovery(), it will recover all innocent job and hook
>             The scheduler fence with new hw fence.  That way only the
>             guilty job is dropped forever.
>
>             -----Original Message-----
>             From: Christian König [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
>             Sent: Monday, May 08, 2017 9:12 PM
>             To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>             <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>             Cc: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>             <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>             Subject: Re: [PATCH 4/4] drm/amdgpu/SRIOV:implement guilty
>             job TDR (V2)
>
>             Am 08.05.2017 um 09:01 schrieb Liu, Monk:
>             > @Christian
>             >
>             > This one is changed to guilty job scheme accordingly
>             with your
>             > response
>             >
>             > BR Monk
>             >
>             > -----Original Message-----
>             > From: Monk Liu [mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org]
>             > Sent: Monday, May 08, 2017 3:00 PM
>             > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>             > Cc: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org> <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>             > Subject: [PATCH] drm/amdgpu/SRIOV:implement guilty job
>             TDR (V2)
>             >
>             > 1,TDR will kickout guilty job if it hang exceed the
>             threshold of the given one from kernel paramter
>             "job_hang_limit", that way a bad command stream will not
>             infinitly cause GPU hang.
>             >
>             > by default this threshold is 1 so a job will be kicked
>             out after it hang.
>             >
>             > 2,if a job timeout TDR routine will not reset all
>             sched/ring, instead if will only reset on the givn one
>             which is indicated by @job of amdgpu_sriov_gpu_reset, that
>             way we don't need to reset and recover each sched/ring if
>             we already know which job cause GPU hang.
>             >
>             > 3,unblock sriov_gpu_reset for AI family.
>             > 4,don't init entity for KIQ
>             >
>             > TODO:
>             > when a job is considered as guilty, we should mark some
>             flag in its fence status flag, and let UMD side aware that
>             this fence signaling is not due to job complete but job hang.
>             >
>             > Change-Id: I7b89c19a3de93249db570d0a80522176b1525a09
>             > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>             <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>             > ---
>             >   drivers/gpu/drm/amd/amdgpu/amdgpu.h |  1 +
>             >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  4 +++
>             >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36
>             ++++++++++++++++++++-------
>             >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +++
>             >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  6 +++++
>             >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>             >   drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 11
>             +++++++- drivers/gpu/drm/amd/scheduler/gpu_scheduler.h | 
>             7 ++++++
>             >   8 files changed, 60 insertions(+), 10 deletions(-)
>             >
>             > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>             > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>             > index 90a69bf..93bcea2 100644
>             > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>             > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>             > @@ -111,6 +111,7 @@ extern int amdgpu_prim_buf_per_se; 
>             extern int
>             > amdgpu_pos_buf_per_se;  extern int
>             amdgpu_cntl_sb_buf_per_se;  extern
>             > int amdgpu_param_buf_per_se;
>             > +extern int amdgpu_job_hang_limit;
>             >
>             >   #define AMDGPU_DEFAULT_GTT_SIZE_MB 3072ULL /* 3GB by
>             default */
>             >   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS              3000
>             > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>             > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>             > index b4bbbb3..23afc58 100644
>             > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>             > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>             > @@ -52,6 +52,10 @@ static int amdgpu_ctx_init(struct
>             amdgpu_device *adev, struct amdgpu_ctx *ctx)
>             >                struct amd_sched_rq *rq;
>             >
>             >                rq =
>             &ring->sched.sched_rq[AMD_SCHED_PRIORITY_NORMAL];
>             > +
>             > +             if (ring == &adev->gfx.kiq.ring)
>             > +                     continue;
>             > +
>
>             That looks like a bug fix and should probably go into a
>             separate patch.
>
>             >                r = amd_sched_entity_init(&ring->sched,
>             &ctx->rings[i].entity,
>             >                                          rq,
>             amdgpu_sched_jobs);
>             >                if (r)
>             > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             > index 0e5f314..f3990fe 100644
>             > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>             > @@ -2537,7 +2537,7 @@ static int
>             amdgpu_recover_vram_from_shadow(struct amdgpu_device *adev,
>             >    */
>             >   int amdgpu_sriov_gpu_reset(struct amdgpu_device *adev,
>             struct amdgpu_job *job)  {
>             > -     int i, r = 0;
>             > +     int i, j, r = 0;
>             >        int resched;
>             >        struct amdgpu_bo *bo, *tmp;
>             >        struct amdgpu_ring *ring;
>             > @@ -2550,19 +2550,30 @@ int
>             amdgpu_sriov_gpu_reset(struct amdgpu_device *adev, struct
>             amdgpu_job *job)
>             >        /* block TTM */
>             >        resched =
>             ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
>             >
>             > -     /* block scheduler */
>             > -     for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>             > -             ring = adev->rings[i];
>             > +     /* we start from the ring trigger GPU hang */
>             > +     j = job ? job->ring->idx : 0;
>             > +
>             > +     if (job)
>             > +             if (amd_sched_invalidate_job(&job->base,
>             amdgpu_job_hang_limit))
>             > + amd_sched_job_kickout(&job->base);
>
>             Well that looks like the wrong order to me. We should
>             probably stop the scheduler before trying to mess anything
>             with the job.
>
>             >
>             > +     /* block scheduler */
>             > +     for (i = j; i < j + AMDGPU_MAX_RINGS; ++i) {
>             > +             ring = adev->rings[i % AMDGPU_MAX_RINGS];
>             >                if (!ring || !ring->sched.thread)
>             >                        continue;
>             >
>             > kthread_park(ring->sched.thread);
>             > +
>             > +             if (job && j != i)
>             > +                     continue;
>             > +
>             > +             /* only do job_reset on the hang ring if
>             @job not NULL */
>             > amd_sched_hw_job_reset(&ring->sched);
>             > -     }
>             >
>             > -     /* after all hw jobs are reset, hw fence is
>             meaningless, so force_completion */
>             > - amdgpu_fence_driver_force_completion(adev);
>             > +             /* after all hw jobs are reset, hw fence
>             is meaningless, so force_completion */
>             > + amdgpu_fence_driver_force_completion_ring(ring);
>             > +     }
>             >
>             >        /* request to take full control of GPU before
>             re-initialization  */
>             >        if (job)
>             > @@ -2615,11 +2626,16 @@ int
>             amdgpu_sriov_gpu_reset(struct amdgpu_device *adev, struct
>             amdgpu_job *job)
>             >        }
>             >        fence_put(fence);
>             >
>             > -     for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>             > -             struct amdgpu_ring *ring = adev->rings[i];
>             > +     for (i = j; i < j + AMDGPU_MAX_RINGS; ++i) {
>             > +             ring = adev->rings[i % AMDGPU_MAX_RINGS];
>             >                if (!ring || !ring->sched.thread)
>             >                        continue;
>             >
>             > +             if (job && j != i) {
>             > + kthread_unpark(ring->sched.thread);
>             > +                     continue;
>             > +             }
>             > +
>
>             Please split up that patch a bit further. E.g. first the
>             handling to only hw_job_reset the ring in question, then
>             the kickout handling.
>
>             > amd_sched_job_recovery(&ring->sched);
>             > kthread_unpark(ring->sched.thread);
>             >        }
>             > @@ -2629,6 +2645,8 @@ int amdgpu_sriov_gpu_reset(struct
>             amdgpu_device *adev, struct amdgpu_job *job)
>             >        if (r) {
>             >                /* bad news, how to tell it to userspace ? */
>             >                dev_info(adev->dev, "GPU reset failed\n");
>             > +     } else {
>             > +             dev_info(adev->dev, "GPU reset successed!\n");
>             >        }
>             >
>             >        adev->gfx.in_reset = false;
>             > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>             > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>             > index 416908a..fd3691a8 100644
>             > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>             > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>             > @@ -112,6 +112,7 @@ int amdgpu_prim_buf_per_se = 0;  int
>             > amdgpu_pos_buf_per_se = 0;  int
>             amdgpu_cntl_sb_buf_per_se = 0;  int
>             > amdgpu_param_buf_per_se = 0;
>             > +int amdgpu_job_hang_limit = 0;
>             >
>             >   MODULE_PARM_DESC(vramlimit, "Restrict VRAM for
>             testing, in
>             > megabytes");  module_param_named(vramlimit,
>             amdgpu_vram_limit, int,
>             > 0600); @@ -237,6 +238,9 @@
>             module_param_named(cntl_sb_buf_per_se,
>             > amdgpu_cntl_sb_buf_per_se, int, 0444);
>             > MODULE_PARM_DESC(param_buf_per_se, "the size of Off-Chip
>             Pramater
>             > Cache per Shader Engine (default depending on gfx)");
>             > module_param_named(param_buf_per_se,
>             amdgpu_param_buf_per_se, int,
>             > 0444);
>             >
>             > +MODULE_PARM_DESC(job_hang_limit, "how much time allow a
>             job hang and
>             > +not drop it (default 0)");
>             module_param_named(job_hang_limit,
>             > +amdgpu_job_hang_limit, int ,0444);
>             > +
>             >
>             >   static const struct pci_device_id pciidlist[] = {  #ifdef
>             > CONFIG_DRM_AMDGPU_SI diff --git
>             > a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>             > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>             > index d7523d1..8de3bd3 100644
>             > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>             > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>             > @@ -541,6 +541,12 @@ void
>             amdgpu_fence_driver_force_completion(struct amdgpu_device
>             *adev)
>             >        }
>             >   }
>             >
>             > +void amdgpu_fence_driver_force_completion_ring(struct
>             amdgpu_ring
>             > +*ring) {
>             > +     if (ring)
>             > +             amdgpu_fence_write(ring,
>             ring->fence_drv.sync_seq); }
>             > +
>
>             The coding style is completely off.
>
>             Additional to that I don't think that this is a good idea.
>             We should probably rather just signal all scheduler fences
>             instead and don't touch the hardware fence at all.
>
>             >   /*
>             >    * Common fence implementation
>             >    */
>             > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>             > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>             > index 981ef08..03e88c6 100644
>             > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>             > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>             > @@ -76,6 +76,7 @@ struct amdgpu_fence_driver { int
>             > amdgpu_fence_driver_init(struct amdgpu_device *adev);  void
>             > amdgpu_fence_driver_fini(struct amdgpu_device *adev);  void
>             > amdgpu_fence_driver_force_completion(struct
>             amdgpu_device *adev);
>             > +void amdgpu_fence_driver_force_completion_ring(struct
>             amdgpu_ring
>             > +*ring);
>             >
>             >   int amdgpu_fence_driver_init_ring(struct amdgpu_ring
>             *ring,
>             >                                  unsigned
>             num_hw_submission);
>             > diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
>             > b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
>             > index 6f4e31f..4e97e6d 100644
>             > --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
>             > +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
>             > @@ -390,9 +390,18 @@ void amd_sched_hw_job_reset(struct
>             amd_gpu_scheduler *sched)
>             > &s_job->s_fence->cb)) {
>             > fence_put(s_job->s_fence->parent);
>             > s_job->s_fence->parent = NULL;
>             > + atomic_dec(&sched->hw_rq_count);
>             >                }
>             >        }
>             > -     atomic_set(&sched->hw_rq_count, 0);
>             > + spin_unlock(&sched->job_list_lock);
>             > +}
>             > +
>             > +void amd_sched_job_kickout(struct amd_sched_job *s_job) {
>             > +     struct amd_gpu_scheduler *sched = s_job->sched;
>             > +
>             > +     spin_lock(&sched->job_list_lock);
>             > +     list_del_init(&s_job->node);
>             > spin_unlock(&sched->job_list_lock);
>             >   }
>             >
>             > diff --git a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
>             > b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
>             > index 8cb41d3..59694f3 100644
>             > --- a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
>             > +++ b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h
>             > @@ -81,6 +81,7 @@ struct amd_sched_job {
>             >        struct list_head                node;
>             >        struct delayed_work work_tdr;
>             >        uint64_t                        id;
>             > +     atomic_t karma;
>             >   };
>             >
>             >   extern const struct fence_ops
>             amd_sched_fence_ops_scheduled; @@ -96,6 +97,11 @@ static
>             inline struct amd_sched_fence *to_amd_sched_fence(struct
>             fence *f)
>             >        return NULL;
>             >   }
>             >
>             > +static inline bool amd_sched_invalidate_job(struct
>             amd_sched_job
>             > +*s_job, int threshold) {
>             > +     return (s_job && atomic_inc_return(&s_job->karma)
>             > threshold); }
>             > +
>
>             Again coding style is completely off.
>
>             Christian.
>
>             >   /**
>             >    * Define the backend operations called by the scheduler,
>             >    * these functions should be implemented in driver
>             side @@ -158,4 +164,5 @@ int amd_sched_job_init(struct
>             amd_sched_job *job,
>             >                       void *owner);
>             >   void amd_sched_hw_job_reset(struct amd_gpu_scheduler
>             *sched);  void
>             > amd_sched_job_recovery(struct amd_gpu_scheduler *sched);
>             > +void amd_sched_job_kickout(struct amd_sched_job *s_job);
>             >   #endif
>             > --
>             > 2.7.4
>             >
>             > _______________________________________________
>             > amd-gfx mailing list
>             > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>             > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
>
>
>
>     _______________________________________________
>
>     amd-gfx mailing list
>
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------FA66D46F1B9219BE83D92780
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 10.05.2017 um 12:05 schrieb Liu,
      Monk:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB1610A13032697B40B7BB4A5984EC0-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML 预设格式 Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:1.0pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.HTMLChar
	{mso-style-name:"HTML 预设格式 Char";
	mso-style-priority:99;
	mso-style-link:"HTML 预设格式";
	font-family:Consolas;
	color:black;}
span.EmailStyle24
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"
          style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span
            style="color:#1F497D">[</span>ML] yes, but we cannot
          guarantee the job is 100% really hang when entering
          gpu_reset(), we can only trust our amdgpu_job_timeout as a
          deadline for each job.<o:p></o:p></p>
        <p class="MsoNormal"
          style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto">You
          approach that check the fence first before charge it as
          guilty/hang is incorrect looks to me because why you not check
          it twice, triple, and even more loops ?
          <o:p></o:p></p>
        <p class="MsoNormal">Because the job can't signal any more after
          calling amd_sched_hw_job_reset().<span style="color:#1F497D"><o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">[ML]
            No … that’s where I think your approach is vague:<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">1)
            see that you check after scheduler stopped, see if job
            signaled, my question is if the job is not signaled (like
            most usual case)<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Why
            you not check it again and again ?  maybe the second time
            you will find it signaled …</span></p>
      </div>
    </blockquote>
    <br>
    Checking a second time is pointless since it can't signal any more
    after calling amd_sched_hw_job_reset().<br>
    <br>
    <blockquote
cite="mid:DM5PR12MB1610A13032697B40B7BB4A5984EC0-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"><o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">My
            point is the checking here is meaningless, we already have
            timedout for the guard.</span></p>
      </div>
    </blockquote>
    No, the timeout is pretty meaningless. It's just the trigger that we
    need to do something.<br>
    <br>
    But to determine what to do we first need to stop the scheduler,
    remove the hardware fence and THEN check the current status.<br>
    <br>
    Otherwise we have a race condition here where we can't determine if
    the reset finished the job or if it did just on it's own while we
    stopped the scheduler.<br>
    <br>
    <blockquote
cite="mid:DM5PR12MB1610A13032697B40B7BB4A5984EC0-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"><o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"><o:p></o:p></span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">2)
            And even it signaled after entering gpu_reset(), it will
            automatically done like normal cases, that’s good. Why
            remove those callback instead ?</span><br>
        </p>
      </div>
    </blockquote>
    No, that's absolutely not good. We don't know if it's the hardware
    which results in the job being signaled or our reset code.<br>
    <br>
    <blockquote
cite="mid:DM5PR12MB1610A13032697B40B7BB4A5984EC0-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <div class="WordSection1">
        <p class="MsoNormal">
          <br>
          <o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal"
            style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto">So
            I refuse to check if @job is just signaled in gpu_reset,
            because this action is vague (and no one can guarantee the
            job won’t signal during gpu_reset, we should not argue on
            this event …), I prefer clean and restrict rules.<o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal">Yeah, completely agree that we need to have
          struct rules for that. That's why I insists on doing this :)<span
            style="color:#1F497D"><o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">No,
            you are insist on a vague rules not strict, like I said,
            what is the theoretic to backend your approach that only
            check once on the in question job ? why not check again if
            not signaled ?</span></p>
      </div>
    </blockquote>
    Because we have removed the connection between the job and the
    hardware fence and because of this the job can never signal.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote
cite="mid:DM5PR12MB1610A13032697B40B7BB4A5984EC0-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">I
            don’t agree this approach is clean and strict. You are abuse
            timedout parameter.<o:p></o:p></span></p>
        <p class="MsoNormal"><br>
          <br>
          See I just want to avoid problems for the case that the job
          signaled while we stop the scheduler (because stopping the
          scheduler actually can take a moment).<br>
          <br>
          Because when this happened the scheduler could already have
          pushed the next job to the hardware and then we abort it with
          the GPU reset and might create more problems than we solve.<span
            style="color:#1F497D"><o:p></o:p></span></p>
        <p class="MsoNormal"><br>
          <br>
          <br>
          <o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal"
            style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto">[ML]
            I don’t see my approach will have chance to fence twice… on
            the contrast I think my approach is more clear: no matter
            the in question job finally signaled or not, I just kick it
            out from mirror-list<o:p></o:p></p>
          <p class="MsoNormal">Without remove the callback from hw
            fence, that way even it really signaled during the
            gpu_reset() period the logic is still perfect and its sched
            fence will act like usual …<o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal">We want to set an error code on the job
          before signaling it don't we? So we need to be sure how and
          when the job is signaled as finished.<br>
          <br>
          I mean letting it signal when we force the hardware fence to
          complete will work as well, but I still think that this isn't
          as clean as signaling it manually.<br>
          <br>
          Please also see the helper function the Intel guys introduced
          drm_fence_set_error(), we will run into a BUG_ON if we can't
          guarantee the order of execution here.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          Am 10.05.2017 um 06:00 schrieb Liu, Monk:<o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal">Christian, <o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">Looks like we need more discuss with it…<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">Here is your approach:<o:p></o:p></p>
          <p class="MsoNormal">1. Stop the scheduler from feeding more
            jobs to the hardware when a jobs completes.  //this is where
            I agree with you<br>
            <br>
            2. Then call hw_job_reset to remove the connection between
            job and hardware fence.<br>
            <br>
            3. Test if job is now completed. It is entirely possible
            that the job completed while we started the work to reset
            the hardware.<br>
            <br>
            Removing the connection between the hardware fence and the
            job is the deadline, if the job completes after that it is
            lost.<br>
            <br>
            4. Check the karma and kick out the job if we found it
            guilty.<br>
            <br>
            5. Get the whole stuff working again, e.g. reset the
            hardware, restart the scheduler etc...<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal"><b><i>[ML]: One thing I agree to change
                with your way: in gpu_reset() we should first stop the
                in question ring’s scheduler (not the all) before kick
                out the guilty job.</i></b><o:p></o:p></p>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"> </span><o:p></o:p></p>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"> </span><o:p></o:p></p>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">&gt;</span>
            Indeed, but I still think that this is a bad approach cause
            we then reset the hardware without a good reason.<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">[ML] yes, but we cannot guarantee the job
            is 100% really hang when entering gpu_reset(), we can only
            trust our amdgpu_job_timeout as a deadline for each job.<o:p></o:p></p>
          <p class="MsoNormal">You approach that check the fence first
            before charge it as guilty/hang is incorrect looks to me
            because why you not check it twice, triple, and even more
            loops ?
            <o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">You check it one time and you found it
            just signaled that’s great and lucky(really lucky…), But
            what if it didn’t signaled (like most usual case) , why not
            check it again and again ? do you have a theoretic to
            support on how much time you need to check before finally
            consider it hang ? No I don’t think you have so please just
            cut this unnecessary checking, we already use
            amdgpu_job_timeout to give the deadline of each job.<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">So I refuse to check if @job is just
            signaled in gpu_reset, because this action is vague (and no
            one can guarantee the job won’t signal during gpu_reset, we
            should not argue on this event …), I prefer clean and
            restrict rules.<o:p></o:p></p>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"> </span><o:p></o:p></p>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"> </span><o:p></o:p></p>
          <p class="MsoNormal">&gt;Force completion is not so much of
            the issue, but rather in which order you do things.<br>
            <br>
            &gt;See the original code first stops the scheduler and
            removes the connection between hardware fence and job in an
            atomic manner. And THEN forces the hardware fence to
            complete.<br>
            <br>
            &gt;This way we could be sure that nothing happened in
            parallel, e.g. that we don't try to signal the fence twice
            or something like that.<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">[ML] I don’t see my approach will have
            chance to fence twice… on the contrast I think my approach
            is more clear: no matter the in question job finally
            signaled or not, I just kick it out from mirror-list<o:p></o:p></p>
          <p class="MsoNormal">Without remove the callback from hw
            fence, that way even it really signaled during the
            gpu_reset() period the logic is still perfect and its sched
            fence will act like usual …<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">Please point out where or how my approach
            will go wrong like “e.g. that we don't try to signal the
            fence twice or something like that.”, otherwise I cannot be
            persuaded and fix my way …<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">At last. I run the TDR test and it ends
            up with Hypervisor side error, the guest side is all
            perfect, here is what I ran:<o:p></o:p></p>
          <p class="MsoNormal">The vk_example and vulkan CTS test under
            MCBP case, we have all kinds of hang on compute ring,
            without TDR this test won’t suffer for 5 seconds, and with
            TDR although MCBP is buggy now but we can
            <o:p></o:p></p>
          <p class="MsoNormal">Finish this test (of cause test result is
            mismatch due to MCBP issue), and there are tongs of
            job_timed_out in dmesg, but guest driver didn’t have any
            error report.  I was also surprised this behave really
            stable …<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">The second test the using “watch” to
            trigger a gpu hang (bad command stream) every 2 seconds,
            with amdgpu_job_timeout also set to 2seconds, I can run it
            till hypervisor side hit VF FLR error, and guest side<o:p></o:p></p>
          <p class="MsoNormal">Still runs perfectly and nothing wrong
            happened, with hw fence seq number I can tell there are 3000
            loops of TDR finished before Hypervisor hit error.<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">BR Monk<o:p></o:p></p>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"> </span><o:p></o:p></p>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"> </span><o:p></o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">
                  Koenig, Christian
                  <br>
                  <b>Sent:</b> Tuesday, May 09, 2017 8:52 PM<br>
                  <b>To:</b> Liu, Monk <a moz-do-not-send="true"
                    href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Christian König
                  <a moz-do-not-send="true"
                    href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a>;
                  <a moz-do-not-send="true"
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                    amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> Re: [PATCH 4/4]
                  drm/amdgpu/SRIOV:implement guilty job TDR (V2)</span><o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"> <o:p></o:p></p>
          <div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal"
                style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto">[ML]
                if the job complete, the job’s sched fence callback will
                take this spin_lock and remove itself from mirror_list,
                so we are still safe to call amd_sched_job_kickout(),
                and it will do nothing if so<o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal">Indeed, but I still think that this is
              a bad approach cause we then reset the hardware without a
              good reason.<br>
              <br>
              <br>
              <br>
              <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal">Besides, original logic also force
                complete the hw fence, and it works well …
                <o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal">Force completion is not so much of the
              issue, but rather in which order you do things.<br>
              <br>
              See the original code first stops the scheduler and
              removes the connection between hardware fence and job in
              an atomic manner. And THEN forces the hardware fence to
              complete.<br>
              <br>
              This way we could be sure that nothing happened in
              parallel, e.g. that we don't try to signal the fence twice
              or something like that.<br>
              <br>
              <br>
              <br>
              <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal">State like “You are missing that it
                is entirely possible that the job will complete while we
                are trying to kick it out.”<o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal">Sorry I should have been more clear.<br>
              <br>
              <br>
              <br>
              <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal">Is not a good reason to reject my
                approach, because that is okay if the job just completed
                …
                <o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal">We usually try to take a defensive
              approach, so stopping everything, removing the hardware
              fence connection and then explicitly kicking out the job
              in question sounds much better than doing it implicitly
              with the hardware fence completion.<br>
              <br>
              Even when this works (which I'm still not sure of) that is
              a really awkward and hard to understand approach.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 09.05.2017 um 13:58 schrieb Liu, Monk:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"> </span><o:p></o:p></p>
            <p class="MsoNormal">You are missing that it is entirely
              possible that the job will complete while we are trying to
              kick it out.<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">[ML] if the job complete, the job’s
              sched fence callback will take this spin_lock and remove
              itself from mirror_list, so we are still safe to call
              amd_sched_job_kickout(), and it will do nothing if so<o:p></o:p></p>
            <p class="MsoNormal">Please go through the whole steps
              again,<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">Besides, original logic also force
              complete the hw fence, and it works well …
              <o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">I don’t see the solid reason why you
              insist on your approach, please go through the steps
              again  and give me the details about where is incorrect
              than I can fix it
              <o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">State like “You are missing that it is
              entirely possible that the job will complete while we are
              trying to kick it out.” Is not a good reason to reject my
              approach, because that is okay if the job just completed …<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">BR Monk<br>
              <br>
              <br>
              <br>
              <o:p></o:p></p>
            <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"> </span><o:p></o:p></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">
                    Koenig, Christian
                    <br>
                    <b>Sent:</b> Tuesday, May 09, 2017 3:49 PM<br>
                    <b>To:</b> Liu, Monk <a moz-do-not-send="true"
                      href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                    Christian König
                    <a moz-do-not-send="true"
                      href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a>;
                    <a moz-do-not-send="true"
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                      amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    <b>Subject:</b> Re: [PATCH 4/4]
                    drm/amdgpu/SRIOV:implement guilty job TDR (V2)</span><o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"> <o:p></o:p></p>
            <div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoNormal"><span style="font-size:10.0pt">[ML]
                    Really not necessary, we have spin_lock to protect
                    the mirror-list, nothing will be messed up ...</span><o:p></o:p></p>
              </blockquote>
              <p class="MsoNormal">You are missing that it is entirely
                possible that the job will complete while we are trying
                to kick it out.<br>
                <br>
                <br>
                <br>
                <br>
                <o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoNormal"><span style="font-size:10.0pt">[ML]
                    why don't touch hardware fence at all ?  the
                    original/bare-metal gpu reset also signal all ring's
                    hardware fence first, I just follow the original
                    logic ...<br>
                    Scheduler fence will be auto signaled after hw fence
                    signaled, any problem with that ? what's the concern
                    ?</span><o:p></o:p></p>
              </blockquote>
              <p class="MsoNormal">The hardware runs async to the CPU
                which tries to reset it, so we need to be careful in
                which order things are done.<br>
                <br>
                <br>
                <br>
                <br>
                <o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoNormal"><span style="font-size:10.0pt">[ML]
                    No I don't think so, the kickout must be prior to
                    the hw_job_reset, otherwise the scheduler fence
                    callback will be removed and you need manually
                    install it later , which is not correct:<br>
                    For the guity job, we just kick it out before job
                    reset, in job_reset we only reset other innocent
                    jobs( and unbind the scheduler fence callback for
                    them), after hw fence<br>
                    Forcely set to drv_seq, all hw fence are signaled
                    (this is the way of original logic, I didn't change
                    that).  When go to sched_recovery(), it will recover
                    all innocent job and hook<br>
                    The scheduler fence with new hw fence.  That way
                    only the guilty job is dropped forever.</span><o:p></o:p></p>
              </blockquote>
              <p class="MsoNormal">Again same problem here.<br>
                <br>
                To be absolutely sure that everything works as expected
                we need to do it in the following order:<br>
                <br>
                1. Stop the scheduler from feeding more jobs to the
                hardware when a jobs completes.<br>
                <br>
                2. Then call hw_job_reset to remove the connection
                between job and hardware fence.<br>
                <br>
                3. Test if job is now completed. It is entirely possible
                that the job completed while we started the work to
                reset the hardware.<br>
                <br>
                Removing the connection between the hardware fence and
                the job is the deadline, if the job completes after that
                it is lost.<br>
                <br>
                4. Check the karma and kick out the job if we found it
                guilty.<br>
                <br>
                5. Get the whole stuff working again, e.g. reset the
                hardware, restart the scheduler etc...<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                Am 09.05.2017 um 04:45 schrieb Liu, Monk:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <div>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><span
                    style="font-size:10.0pt">&gt;  
                    <br>
                    &gt; -     /* block scheduler */<br>
                    &gt; -     for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i)
                    {<br>
                    &gt; -             ring = adev-&gt;rings[i];<br>
                    &gt; +     /* we start from the ring trigger GPU
                    hang */<br>
                    &gt; +     j = job ? job-&gt;ring-&gt;idx : 0;<br>
                    &gt; +<br>
                    &gt; +     if (job)<br>
                    &gt; +             if
                    (amd_sched_invalidate_job(&amp;job-&gt;base,
                    amdgpu_job_hang_limit))<br>
                    &gt; +                    
                    amd_sched_job_kickout(&amp;job-&gt;base);<br>
                    <br>
                    Well that looks like the wrong order to me. We
                    should probably stop the scheduler before trying to
                    mess anything with the job.<br>
                    <br>
                    [ML] Really not necessary, we have spin_lock to
                    protect the mirror-list, nothing will be messed up
                    ...<br>
                    <br>
                    <br>
                    &gt;   <br>
                    &gt; +void
                    amdgpu_fence_driver_force_completion_ring(struct
                    amdgpu_ring<br>
                    &gt; +*ring) {<br>
                    &gt; +     if (ring)<br>
                    &gt; +             amdgpu_fence_write(ring,
                    ring-&gt;fence_drv.sync_seq); }<br>
                    &gt; +<br>
                    <br>
                    The coding style is completely off.<br>
                    <br>
                    [ML] I don't know why at email side it looks wrong
                    coding style, but I'm sure it is correct at my side,
                    check here:<br>
                    void
                    amdgpu_fence_driver_force_completion_ring(struct
                    amdgpu_ring *ring)<br>
                    {<br>
                            if (ring)<br>
                                    amdgpu_fence_write(ring,
                    ring-&gt;fence_drv.sync_seq);<br>
                    }<br>
                    <br>
                    Additional to that I don't think that this is a good
                    idea. We should probably rather just signal all
                    scheduler fences instead and don't touch the
                    hardware fence at all.<br>
                    <br>
                    [ML] why don't touch hardware fence at all ?  the
                    original/bare-metal gpu reset also signal all ring's
                    hardware fence first, I just follow the original
                    logic ...<br>
                    Scheduler fence will be auto signaled after hw fence
                    signaled, any problem with that ? what's the concern
                    ?<br>
                    <br>
                    <br>
                    &gt; -     for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i)
                    {<br>
                    &gt; -             struct amdgpu_ring *ring =
                    adev-&gt;rings[i];<br>
                    &gt; +     for (i = j; i &lt; j + AMDGPU_MAX_RINGS;
                    ++i) {<br>
                    &gt; +             ring = adev-&gt;rings[i %
                    AMDGPU_MAX_RINGS];<br>
                    &gt;                if (!ring ||
                    !ring-&gt;sched.thread)<br>
                    &gt;                        continue;<br>
                    &gt;   <br>
                    &gt; +             if (job &amp;&amp; j != i) {<br>
                    &gt; +                    
                    kthread_unpark(ring-&gt;sched.thread);<br>
                    &gt; +                     continue;<br>
                    &gt; +             }<br>
                    &gt; +<br>
                    <br>
                    Please split up that patch a bit further. E.g. first
                    the handling to only hw_job_reset the ring in
                    question, then the kickout handling.<br>
                    <br>
                    [ML] No I don't think so, the kickout must be prior
                    to the hw_job_reset, otherwise the scheduler fence
                    callback will be removed and you need manually
                    install it later , which is not correct:<br>
                    For the guity job, we just kick it out before job
                    reset, in job_reset we only reset other innocent
                    jobs( and unbind the scheduler fence callback for
                    them), after hw fence<br>
                    Forcely set to drv_seq, all hw fence are signaled
                    (this is the way of original logic, I didn't change
                    that).  When go to sched_recovery(), it will recover
                    all innocent job and hook<br>
                    The scheduler fence with new hw fence.  That way
                    only the guilty job is dropped forever.<br>
                    <br>
                    -----Original Message-----<br>
                    From: Christian König [<a moz-do-not-send="true"
                      href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>]
                    <br>
                    Sent: Monday, May 08, 2017 9:12 PM<br>
                    To: Liu, Monk <a moz-do-not-send="true"
                      href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                    <a moz-do-not-send="true"
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                      amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    Cc: Koenig, Christian <a moz-do-not-send="true"
                      href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    Subject: Re: [PATCH 4/4] drm/amdgpu/SRIOV:implement
                    guilty job TDR (V2)<br>
                    <br>
                    Am 08.05.2017 um 09:01 schrieb Liu, Monk:<br>
                    &gt; @Christian<br>
                    &gt;<br>
                    &gt; This one is changed to guilty job scheme
                    accordingly with your <br>
                    &gt; response<br>
                    &gt;<br>
                    &gt; BR Monk<br>
                    &gt;<br>
                    &gt; -----Original Message-----<br>
                    &gt; From: Monk Liu [<a moz-do-not-send="true"
                      href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>]<br>
                    &gt; Sent: Monday, May 08, 2017 3:00 PM<br>
                    &gt; To: <a moz-do-not-send="true"
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    &gt; Cc: Liu, Monk <a moz-do-not-send="true"
                      href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    &gt; Subject: [PATCH] drm/amdgpu/SRIOV:implement
                    guilty job TDR (V2)<br>
                    &gt;<br>
                    &gt; 1,TDR will kickout guilty job if it hang exceed
                    the threshold of the given one from kernel paramter
                    "job_hang_limit", that way a bad command stream will
                    not infinitly cause GPU hang.<br>
                    &gt;<br>
                    &gt; by default this threshold is 1 so a job will be
                    kicked out after it hang.<br>
                    &gt;<br>
                    &gt; 2,if a job timeout TDR routine will not reset
                    all sched/ring, instead if will only reset on the
                    givn one which is indicated by @job of
                    amdgpu_sriov_gpu_reset, that way we don't need to
                    reset and recover each sched/ring if we already know
                    which job cause GPU hang.<br>
                    &gt;<br>
                    &gt; 3,unblock sriov_gpu_reset for AI family.<br>
                    &gt; 4,don't init entity for KIQ<br>
                    &gt;<br>
                    &gt; TODO:<br>
                    &gt; when a job is considered as guilty, we should
                    mark some flag in its fence status flag, and let UMD
                    side aware that this fence signaling is not due to
                    job complete but job hang.<br>
                    &gt;<br>
                    &gt; Change-Id:
                    I7b89c19a3de93249db570d0a80522176b1525a09<br>
                    &gt; Signed-off-by: Monk Liu <a
                      moz-do-not-send="true"
                      href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    &gt; ---<br>
                    &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h          
                    |  1 +<br>
                    &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c      
                    |  4 +++<br>
                    &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   
                    | 36 ++++++++++++++++++++-------<br>
                    &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      
                    |  4 +++<br>
                    &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c    
                    |  6 +++++<br>
                    &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     
                    |  1 +<br>
                    &gt;   drivers/gpu/drm/amd/scheduler/gpu_scheduler.c
                    | 11 +++++++- 
                    drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |  7
                    ++++++<br>
                    &gt;   8 files changed, 60 insertions(+), 10
                    deletions(-)<br>
                    &gt;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                    &gt; index 90a69bf..93bcea2 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                    &gt; @@ -111,6 +111,7 @@ extern int
                    amdgpu_prim_buf_per_se;  extern int <br>
                    &gt; amdgpu_pos_buf_per_se;  extern int
                    amdgpu_cntl_sb_buf_per_se;  extern <br>
                    &gt; int amdgpu_param_buf_per_se;<br>
                    &gt; +extern int amdgpu_job_hang_limit;<br>
                    &gt;   <br>
                    &gt;   #define AMDGPU_DEFAULT_GTT_SIZE_MB         
                    3072ULL /* 3GB by default */<br>
                    &gt;   #define
                    AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS              3000<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c <br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
                    &gt; index b4bbbb3..23afc58 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
                    &gt; @@ -52,6 +52,10 @@ static int
                    amdgpu_ctx_init(struct amdgpu_device *adev, struct
                    amdgpu_ctx *ctx)<br>
                    &gt;                struct amd_sched_rq *rq;<br>
                    &gt;   <br>
                    &gt;                rq =
                    &amp;ring-&gt;sched.sched_rq[AMD_SCHED_PRIORITY_NORMAL];<br>
                    &gt; +<br>
                    &gt; +             if (ring ==
                    &amp;adev-&gt;gfx.kiq.ring)<br>
                    &gt; +                     continue;<br>
                    &gt; +<br>
                    <br>
                    That looks like a bug fix and should probably go
                    into a separate patch.<br>
                    <br>
                    &gt;                r =
                    amd_sched_entity_init(&amp;ring-&gt;sched,
                    &amp;ctx-&gt;rings[i].entity,<br>
                    &gt;                                          rq,
                    amdgpu_sched_jobs);<br>
                    &gt;                if (r)<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                    &gt; index 0e5f314..f3990fe 100644<br>
                    &gt; ---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                    &gt; +++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                    &gt; @@ -2537,7 +2537,7 @@ static int
                    amdgpu_recover_vram_from_shadow(struct amdgpu_device
                    *adev,<br>
                    &gt;    */<br>
                    &gt;   int amdgpu_sriov_gpu_reset(struct
                    amdgpu_device *adev, struct amdgpu_job *job)  {<br>
                    &gt; -     int i, r = 0;<br>
                    &gt; +     int i, j, r = 0;<br>
                    &gt;        int resched;<br>
                    &gt;        struct amdgpu_bo *bo, *tmp;<br>
                    &gt;        struct amdgpu_ring *ring;<br>
                    &gt; @@ -2550,19 +2550,30 @@ int
                    amdgpu_sriov_gpu_reset(struct amdgpu_device *adev,
                    struct amdgpu_job *job)<br>
                    &gt;        /* block TTM */<br>
                    &gt;        resched =
                    ttm_bo_lock_delayed_workqueue(&amp;adev-&gt;mman.bdev);<br>
                    &gt;   <br>
                    &gt; -     /* block scheduler */<br>
                    &gt; -     for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i)
                    {<br>
                    &gt; -             ring = adev-&gt;rings[i];<br>
                    &gt; +     /* we start from the ring trigger GPU
                    hang */<br>
                    &gt; +     j = job ? job-&gt;ring-&gt;idx : 0;<br>
                    &gt; +<br>
                    &gt; +     if (job)<br>
                    &gt; +             if
                    (amd_sched_invalidate_job(&amp;job-&gt;base,
                    amdgpu_job_hang_limit))<br>
                    &gt; +                    
                    amd_sched_job_kickout(&amp;job-&gt;base);<br>
                    <br>
                    Well that looks like the wrong order to me. We
                    should probably stop the scheduler before trying to
                    mess anything with the job.<br>
                    <br>
                    &gt;   <br>
                    &gt; +     /* block scheduler */<br>
                    &gt; +     for (i = j; i &lt; j + AMDGPU_MAX_RINGS;
                    ++i) {<br>
                    &gt; +             ring = adev-&gt;rings[i %
                    AMDGPU_MAX_RINGS];<br>
                    &gt;                if (!ring ||
                    !ring-&gt;sched.thread)<br>
                    &gt;                        continue;<br>
                    &gt;   <br>
                    &gt;               
                    kthread_park(ring-&gt;sched.thread);<br>
                    &gt; +<br>
                    &gt; +             if (job &amp;&amp; j != i)<br>
                    &gt; +                     continue;<br>
                    &gt; +<br>
                    &gt; +             /* only do job_reset on the hang
                    ring if @job not NULL */<br>
                    &gt;               
                    amd_sched_hw_job_reset(&amp;ring-&gt;sched);<br>
                    &gt; -     }<br>
                    &gt;   <br>
                    &gt; -     /* after all hw jobs are reset, hw fence
                    is meaningless, so force_completion */<br>
                    &gt; -    
                    amdgpu_fence_driver_force_completion(adev);<br>
                    &gt; +             /* after all hw jobs are reset,
                    hw fence is meaningless, so force_completion */<br>
                    &gt; +            
                    amdgpu_fence_driver_force_completion_ring(ring);<br>
                    &gt; +     }<br>
                    &gt;   <br>
                    &gt;        /* request to take full control of GPU
                    before re-initialization  */<br>
                    &gt;        if (job)<br>
                    &gt; @@ -2615,11 +2626,16 @@ int
                    amdgpu_sriov_gpu_reset(struct amdgpu_device *adev,
                    struct amdgpu_job *job)<br>
                    &gt;        }<br>
                    &gt;        fence_put(fence);<br>
                    &gt;   <br>
                    &gt; -     for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i)
                    {<br>
                    &gt; -             struct amdgpu_ring *ring =
                    adev-&gt;rings[i];<br>
                    &gt; +     for (i = j; i &lt; j + AMDGPU_MAX_RINGS;
                    ++i) {<br>
                    &gt; +             ring = adev-&gt;rings[i %
                    AMDGPU_MAX_RINGS];<br>
                    &gt;                if (!ring ||
                    !ring-&gt;sched.thread)<br>
                    &gt;                        continue;<br>
                    &gt;   <br>
                    &gt; +             if (job &amp;&amp; j != i) {<br>
                    &gt; +                    
                    kthread_unpark(ring-&gt;sched.thread);<br>
                    &gt; +                     continue;<br>
                    &gt; +             }<br>
                    &gt; +<br>
                    <br>
                    Please split up that patch a bit further. E.g. first
                    the handling to only hw_job_reset the ring in
                    question, then the kickout handling.<br>
                    <br>
                    &gt;               
                    amd_sched_job_recovery(&amp;ring-&gt;sched);<br>
                    &gt;               
                    kthread_unpark(ring-&gt;sched.thread);<br>
                    &gt;        }<br>
                    &gt; @@ -2629,6 +2645,8 @@ int
                    amdgpu_sriov_gpu_reset(struct amdgpu_device *adev,
                    struct amdgpu_job *job)<br>
                    &gt;        if (r) {<br>
                    &gt;                /* bad news, how to tell it to
                    userspace ? */<br>
                    &gt;                dev_info(adev-&gt;dev, "GPU
                    reset failed\n");<br>
                    &gt; +     } else {<br>
                    &gt; +             dev_info(adev-&gt;dev, "GPU reset
                    successed!\n");<br>
                    &gt;        }<br>
                    &gt;   <br>
                    &gt;        adev-&gt;gfx.in_reset = false;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c <br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                    &gt; index 416908a..fd3691a8 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                    &gt; @@ -112,6 +112,7 @@ int amdgpu_prim_buf_per_se
                    = 0;  int <br>
                    &gt; amdgpu_pos_buf_per_se = 0;  int
                    amdgpu_cntl_sb_buf_per_se = 0;  int <br>
                    &gt; amdgpu_param_buf_per_se = 0;<br>
                    &gt; +int amdgpu_job_hang_limit = 0;<br>
                    &gt;   <br>
                    &gt;   MODULE_PARM_DESC(vramlimit, "Restrict VRAM
                    for testing, in <br>
                    &gt; megabytes");  module_param_named(vramlimit,
                    amdgpu_vram_limit, int, <br>
                    &gt; 0600); @@ -237,6 +238,9 @@
                    module_param_named(cntl_sb_buf_per_se, <br>
                    &gt; amdgpu_cntl_sb_buf_per_se, int, 0444);  <br>
                    &gt; MODULE_PARM_DESC(param_buf_per_se, "the size of
                    Off-Chip Pramater <br>
                    &gt; Cache per Shader Engine (default depending on
                    gfx)");  <br>
                    &gt; module_param_named(param_buf_per_se,
                    amdgpu_param_buf_per_se, int, <br>
                    &gt; 0444);<br>
                    &gt;   <br>
                    &gt; +MODULE_PARM_DESC(job_hang_limit, "how much
                    time allow a job hang and <br>
                    &gt; +not drop it (default 0)");
                    module_param_named(job_hang_limit,<br>
                    &gt; +amdgpu_job_hang_limit, int ,0444);<br>
                    &gt; +<br>
                    &gt;   <br>
                    &gt;   static const struct pci_device_id pciidlist[]
                    = {  #ifdef  <br>
                    &gt; CONFIG_DRM_AMDGPU_SI diff --git <br>
                    &gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c <br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
                    &gt; index d7523d1..8de3bd3 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
                    &gt; @@ -541,6 +541,12 @@ void
                    amdgpu_fence_driver_force_completion(struct
                    amdgpu_device *adev)<br>
                    &gt;        }<br>
                    &gt;   }<br>
                    &gt;   <br>
                    &gt; +void
                    amdgpu_fence_driver_force_completion_ring(struct
                    amdgpu_ring<br>
                    &gt; +*ring) {<br>
                    &gt; +     if (ring)<br>
                    &gt; +             amdgpu_fence_write(ring,
                    ring-&gt;fence_drv.sync_seq); }<br>
                    &gt; +<br>
                    <br>
                    The coding style is completely off.<br>
                    <br>
                    Additional to that I don't think that this is a good
                    idea. We should probably rather just signal all
                    scheduler fences instead and don't touch the
                    hardware fence at all.<br>
                    <br>
                    &gt;   /*<br>
                    &gt;    * Common fence implementation<br>
                    &gt;    */<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h <br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                    &gt; index 981ef08..03e88c6 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                    &gt; @@ -76,6 +76,7 @@ struct amdgpu_fence_driver { 
                    int <br>
                    &gt; amdgpu_fence_driver_init(struct amdgpu_device
                    *adev);  void <br>
                    &gt; amdgpu_fence_driver_fini(struct amdgpu_device
                    *adev);  void <br>
                    &gt; amdgpu_fence_driver_force_completion(struct
                    amdgpu_device *adev);<br>
                    &gt; +void
                    amdgpu_fence_driver_force_completion_ring(struct
                    amdgpu_ring <br>
                    &gt; +*ring);<br>
                    &gt;   <br>
                    &gt;   int amdgpu_fence_driver_init_ring(struct
                    amdgpu_ring *ring,<br>
                    &gt;                                  unsigned
                    num_hw_submission);<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c <br>
                    &gt; b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
                    &gt; index 6f4e31f..4e97e6d 100644<br>
                    &gt; ---
                    a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
                    &gt; +++
                    b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.c<br>
                    &gt; @@ -390,9 +390,18 @@ void
                    amd_sched_hw_job_reset(struct amd_gpu_scheduler
                    *sched)<br>
                    &gt;                                         
                    &amp;s_job-&gt;s_fence-&gt;cb)) {<br>
                    &gt;                       
                    fence_put(s_job-&gt;s_fence-&gt;parent);<br>
                    &gt;                       
                    s_job-&gt;s_fence-&gt;parent = NULL;<br>
                    &gt; +                    
                    atomic_dec(&amp;sched-&gt;hw_rq_count);<br>
                    &gt;                }<br>
                    &gt;        }<br>
                    &gt; -     atomic_set(&amp;sched-&gt;hw_rq_count,
                    0);<br>
                    &gt; +    
                    spin_unlock(&amp;sched-&gt;job_list_lock);<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +void amd_sched_job_kickout(struct
                    amd_sched_job *s_job) {<br>
                    &gt; +     struct amd_gpu_scheduler *sched =
                    s_job-&gt;sched;<br>
                    &gt; +<br>
                    &gt; +     spin_lock(&amp;sched-&gt;job_list_lock);<br>
                    &gt; +     list_del_init(&amp;s_job-&gt;node);<br>
                    &gt;       
                    spin_unlock(&amp;sched-&gt;job_list_lock);<br>
                    &gt;   }<br>
                    &gt;   <br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h <br>
                    &gt; b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
                    &gt; index 8cb41d3..59694f3 100644<br>
                    &gt; ---
                    a/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
                    &gt; +++
                    b/drivers/gpu/drm/amd/scheduler/gpu_scheduler.h<br>
                    &gt; @@ -81,6 +81,7 @@ struct amd_sched_job {<br>
                    &gt;        struct list_head                node;<br>
                    &gt;        struct delayed_work            
                    work_tdr;<br>
                    &gt;        uint64_t                        id;<br>
                    &gt; +     atomic_t karma;<br>
                    &gt;   };<br>
                    &gt;   <br>
                    &gt;   extern const struct fence_ops
                    amd_sched_fence_ops_scheduled; @@ -96,6 +97,11 @@
                    static inline struct amd_sched_fence
                    *to_amd_sched_fence(struct fence *f)<br>
                    &gt;        return NULL;<br>
                    &gt;   }<br>
                    &gt;   <br>
                    &gt; +static inline bool
                    amd_sched_invalidate_job(struct amd_sched_job <br>
                    &gt; +*s_job, int threshold) {<br>
                    &gt; +     return (s_job &amp;&amp;
                    atomic_inc_return(&amp;s_job-&gt;karma) &gt;
                    threshold); }<br>
                    &gt; +<br>
                    <br>
                    Again coding style is completely off.<br>
                    <br>
                    Christian.<br>
                    <br>
                    &gt;   /**<br>
                    &gt;    * Define the backend operations called by
                    the scheduler,<br>
                    &gt;    * these functions should be implemented in
                    driver side @@ -158,4 +164,5 @@ int
                    amd_sched_job_init(struct amd_sched_job *job,<br>
                    &gt;                       void *owner);<br>
                    &gt;   void amd_sched_hw_job_reset(struct
                    amd_gpu_scheduler *sched);  void <br>
                    &gt; amd_sched_job_recovery(struct amd_gpu_scheduler
                    *sched);<br>
                    &gt; +void amd_sched_job_kickout(struct
                    amd_sched_job *s_job);<br>
                    &gt;   #endif<br>
                    &gt; --<br>
                    &gt; 2.7.4<br>
                    &gt;<br>
                    &gt; _______________________________________________<br>
                    &gt; amd-gfx mailing list<br>
                    &gt; <a moz-do-not-send="true"
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    &gt; <a moz-do-not-send="true"
                      href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                    <br>
                    <br>
                    <br>
                  </span><o:p></o:p></p>
              </div>
            </blockquote>
            <p> <o:p></o:p></p>
          </blockquote>
          <p> <o:p></o:p></p>
          <p class="MsoNormal"><br>
            <br>
            <br>
            <o:p></o:p></p>
          <pre>_______________________________________________<o:p></o:p></pre>
          <pre>amd-gfx mailing list<o:p></o:p></pre>
          <pre><a moz-do-not-send="true" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><o:p></o:p></pre>
          <pre><a moz-do-not-send="true" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></pre>
        </blockquote>
        <p><o:p> </o:p></p>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------FA66D46F1B9219BE83D92780--

--===============1534857339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1534857339==--
