From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
Date: Tue, 24 Apr 2018 12:12:22 -0500
Message-ID: <877eowa5qh.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <87muxsbmkp.fsf@xmission.com>
        <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com> (Andrey
        Grodzovsky's message of "Tue, 24 Apr 2018 12:43:28 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.Panariti@amd.com, oleg@redhat.com, akpm@linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/24/2018 12:23 PM, Eric W. Biederman wrote:
>> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>>
>>> Avoid calling wait_event_killable when you are possibly being called
>>> from get_signal routine since in that case you end up in a deadlock
>>> where you are alreay blocked in singla processing any trying to wait
>>> on a new signal.
>> I am curious what the call path that is problematic here.
>
> Here is the problematic call stack
>
> [<0>] drm_sched_entity_fini+0x10a/0x3a0 [gpu_sched]
> [<0>] amdgpu_ctx_do_release+0x129/0x170 [amdgpu]
> [<0>] amdgpu_ctx_mgr_fini+0xd5/0xe0 [amdgpu]
> [<0>] amdgpu_driver_postclose_kms+0xcd/0x440 [amdgpu]
> [<0>] drm_release+0x414/0x5b0 [drm]
> [<0>] __fput+0x176/0x350
> [<0>] task_work_run+0xa1/0xc0
> [<0>] do_exit+0x48f/0x1280
> [<0>] do_group_exit+0x89/0x140
> [<0>] get_signal+0x375/0x8f0
> [<0>] do_signal+0x79/0xaa0
> [<0>] exit_to_usermode_loop+0x83/0xd0
> [<0>] do_syscall_64+0x244/0x270
> [<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [<0>] 0xffffffffffffffff
>
> On exit from system call you process all the signals you received and
> encounter a fatal signal which triggers process termination.
>
>>
>> In general waiting seems wrong when the process has already been
>> fatally killed as indicated by PF_SIGNALED.
>
> So indeed this patch avoids wait in this case.
>
>>
>> Returning -ERESTARTSYS seems wrong as nothing should make it back even
>> to the edge of userspace here.
>
> Can you clarify please - what should be returned here instead ?

__fput does not have a return code.  I don't see the return code of
release being used anywhere.  So any return code is going to be lost.
So maybe something that talks to the drm/kernel layer but don't expect
your system call to be restarted, which is what -ERESTARTSYS asks for.

Hmm.  When looking at the code that is merged versus whatever your
patch is against it gets even clearer.  The -ERESTARTSYS
return code doesn't even get out of drm_sched_entity_fini.

Caring at all about process state at that point is wrong, as except for
being in ``process'' context where you can sleep nothing is connected to
a process.

Let me respectfully suggest that the wait_event_killable on that code
path is wrong.  Possibly you want a wait_event_timeout if you are very
nice.  But the code already has the logic necessary to handle what
happens if it can't sleep.

So I think the justification needs to be why you are trying to sleep
there at all.

The progress guarantee needs to come from the gpu layer or the AMD
driver not from someone getting impatient and sending SIGKILL to
a dead process.


Eric


>>
>> Given that this is the only use of PF_SIGNALED outside of bsd process
>> accounting I find this code very suspicious.
>>
>> It looks the code path that gets called during exit is buggy and needs
>> to be sorted out.
>>
>> Eric
>>
>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>> index 088ff2b..09fd258 100644
>>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>>>   		return;
>>>   	/**
>>>   	 * The client will not queue more IBs during this fini, consume existing
>>> -	 * queued IBs or discard them on SIGKILL
>>> +	 * queued IBs or discard them when in death signal state since
>>> +	 * wait_event_killable can't receive signals in that state.
>>>   	*/
>>> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>>> +	if (current->flags & PF_SIGNALED)
>>>   		entity->fini_status = -ERESTARTSYS;
>>>   	else
>>>   		entity->fini_status = wait_event_killable(sched->job_scheduled,
