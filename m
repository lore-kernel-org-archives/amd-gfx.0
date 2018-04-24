From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/3] signals: Allow generation of SIGKILL to exiting task.
Date: Tue, 24 Apr 2018 11:42:47 -0500
Message-ID: <87y3hca73s.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
        (Andrey Grodzovsky's message of "Tue, 24 Apr 2018 11:30:34 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.Panariti@amd.com, oleg@redhat.com, akpm@linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:

> Currently calling wait_event_killable as part of exiting process
> will stall forever since SIGKILL generation is suppresed by PF_EXITING.
>
> In our partilaur case AMDGPU driver wants to flush all GPU jobs in
> flight before shutting down. But if some job hangs the pipe we still want to
> be able to kill it and avoid a process in D state.

I should clarify.  This absolutely can not be done.
PF_EXITING is set just before a task starts tearing down it's signal
handling.

So delivering any signal, or otherwise depending on signal handling
after PF_EXITING is set can not be done.  That abstraction is gone.

Eric

> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  kernel/signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c6e4c83..c49c706 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -886,10 +886,10 @@ static inline int wants_signal(int sig, struct task_struct *p)
>  {
>  	if (sigismember(&p->blocked, sig))
>  		return 0;
> -	if (p->flags & PF_EXITING)
> -		return 0;
>  	if (sig == SIGKILL)
>  		return 1;
> +	if (p->flags & PF_EXITING)
> +		return 0;
>  	if (task_is_stopped_or_traced(p))
>  		return 0;
>  	return task_curr(p) || !signal_pending(p);
