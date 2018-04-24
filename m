From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
Date: Tue, 24 Apr 2018 11:23:18 -0500
Message-ID: <87muxsbmkp.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        (Andrey Grodzovsky's message of "Tue, 24 Apr 2018 11:30:35 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.Panariti@amd.com, oleg@redhat.com, akpm@linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:

> Avoid calling wait_event_killable when you are possibly being called
> from get_signal routine since in that case you end up in a deadlock
> where you are alreay blocked in singla processing any trying to wait
> on a new signal.

I am curious what the call path that is problematic here.

In general waiting seems wrong when the process has already been
fatally killed as indicated by PF_SIGNALED.

Returning -ERESTARTSYS seems wrong as nothing should make it back even
to the edge of userspace here.

Given that this is the only use of PF_SIGNALED outside of bsd process
accounting I find this code very suspicious.

It looks the code path that gets called during exit is buggy and needs
to be sorted out.

Eric


> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> index 088ff2b..09fd258 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>  		return;
>  	/**
>  	 * The client will not queue more IBs during this fini, consume existing
> -	 * queued IBs or discard them on SIGKILL
> +	 * queued IBs or discard them when in death signal state since
> +	 * wait_event_killable can't receive signals in that state.
>  	*/
> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
> +	if (current->flags & PF_SIGNALED)
>  		entity->fini_status = -ERESTARTSYS;
>  	else
>  		entity->fini_status = wait_event_killable(sched->job_scheduled,
