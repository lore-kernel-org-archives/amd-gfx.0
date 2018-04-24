From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
Date: Tue, 24 Apr 2018 16:00:32 -0500
Message-ID: <87tvs0721b.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
        <20180424194418.GE25142@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424194418.GE25142@phenom.ffwll.local> (Daniel Vetter's
        message of "Tue, 24 Apr 2018 21:44:18 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, David.Panariti@amd.com, oleg@redhat.com, Alexander.Deucher@amd.com, akpm@linux-foundation.org, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

Daniel Vetter <daniel@ffwll.ch> writes:

> On Tue, Apr 24, 2018 at 05:46:52PM +0200, Michel Dänzer wrote:
>> 
>> Adding the dri-devel list, since this is driver independent code.
>> 
>> 
>> On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
>> > Avoid calling wait_event_killable when you are possibly being called
>> > from get_signal routine since in that case you end up in a deadlock
>> > where you are alreay blocked in singla processing any trying to wait
>> 
>> Multiple typos here, "[...] already blocked in signal processing and [...]"?
>> 
>> 
>> > on a new signal.
>> > 
>> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> > ---
>> >  drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>> >  1 file changed, 3 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> > index 088ff2b..09fd258 100644
>> > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> > @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>> >  		return;
>> >  	/**
>> >  	 * The client will not queue more IBs during this fini, consume existing
>> > -	 * queued IBs or discard them on SIGKILL
>> > +	 * queued IBs or discard them when in death signal state since
>> > +	 * wait_event_killable can't receive signals in that state.
>> >  	*/
>> > -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>> > +	if (current->flags & PF_SIGNALED)
>
> You want fatal_signal_pending() here, instead of inventing your own broken
> version.
>> >  		entity->fini_status = -ERESTARTSYS;
>> >  	else
>> >  		entity->fini_status = wait_event_killable(sched->job_scheduled,
>
> But really this smells like a bug in wait_event_killable, since
> wait_event_interruptible does not suffer from the same bug. It will return
> immediately when there's a signal pending.
>
> I think this should be fixed in core code, not papered over in some
> subsystem.

PF_SIGNALED does not mean a signal has been sent.  PF_SIGNALED means
the process was killed by a signal.

Neither of interruptible or killable makes sense after the process has
been killed.

Eric
