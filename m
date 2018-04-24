From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
Date: Tue, 24 Apr 2018 16:21:07 -0500
Message-ID: <87tvs05mik.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
        <20180424194418.GE25142@phenom.ffwll.local>
        <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com> (Andrey
        Grodzovsky's message of "Tue, 24 Apr 2018 17:02:40 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, David.Panariti@amd.com, oleg@redhat.com, Alexander.Deucher@amd.com, akpm@linux-foundation.org, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/24/2018 03:44 PM, Daniel Vetter wrote:
>> On Tue, Apr 24, 2018 at 05:46:52PM +0200, Michel Dänzer wrote:
>>> Adding the dri-devel list, since this is driver independent code.
>>>
>>>
>>> On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
>>>> Avoid calling wait_event_killable when you are possibly being called
>>>> from get_signal routine since in that case you end up in a deadlock
>>>> where you are alreay blocked in singla processing any trying to wait
>>> Multiple typos here, "[...] already blocked in signal processing and [...]"?
>>>
>>>
>>>> on a new signal.
>>>>
>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>> index 088ff2b..09fd258 100644
>>>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>>> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>>>>   		return;
>>>>   	/**
>>>>   	 * The client will not queue more IBs during this fini, consume existing
>>>> -	 * queued IBs or discard them on SIGKILL
>>>> +	 * queued IBs or discard them when in death signal state since
>>>> +	 * wait_event_killable can't receive signals in that state.
>>>>   	*/
>>>> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>>>> +	if (current->flags & PF_SIGNALED)
>> You want fatal_signal_pending() here, instead of inventing your own broken
>> version.
>
> I rely on current->flags & PF_SIGNALED because this being set from
> within get_signal,

It doesn't mean that.  Unless you are called by do_coredump (you
aren't).  The closing of files does not happen in do_coredump.
Which means you are being called from do_exit.
In fact you are being called after exit_files which closes
the files.  The actual __fput processing happens in task_work_run.

> meaning I am within signal processing  in which case I want to avoid
> any signal based wait for that task,
> From what i see in the code, task_struct.pending.signal is being set
> for other threads in same
> group (zap_other_threads) or for other scenarios, those task are still
> able to receive signals
> so calling wait_event_killable there will not have problem.

Excpet that you are geing called after from do_exit and after exit_files
which is after exit_signal.  Which means that PF_EXITING has been set.
Which implies that the kernel signal handling machinery has already
started being torn down.

Not as much as I would like to happen at that point as we are still
left with some old CLONE_PTHREAD messes in the code that need to be
cleaned up.

Still given the fact you are task_work_run it is quite possible even
release_task has been run on that task before the f_op->release method
is called.  So you simply can not count on signals working.

Which in practice leaves a timeout for ending your wait.  That code can
legitimately be in a context that is neither interruptible nor killable.

>>>>   		entity->fini_status = -ERESTARTSYS;
>>>>   	else
>>>>   		entity->fini_status = wait_event_killable(sched->job_scheduled,
>> But really this smells like a bug in wait_event_killable, since
>> wait_event_interruptible does not suffer from the same bug. It will return
>> immediately when there's a signal pending.
>
> Even when wait_event_interruptible is called as following - 
> ...->do_signal->get_signal->....->wait_event_interruptible ?
> I haven't tried it but wait_event_interruptible is very much alike to
> wait_event_killable so I would assume it will also
> not be interrupted if called like that. (Will give it a try just out
> of curiosity anyway)

As PF_EXITING is set want_signal should fail and the signal state of the
task should not be updatable by signals.

Eric
