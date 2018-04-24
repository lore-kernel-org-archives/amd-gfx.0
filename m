From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/3] signals: Allow generation of SIGKILL to exiting task.
Date: Tue, 24 Apr 2018 12:29:32 -0500
Message-ID: <871sf48qdf.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
        <87y3hca73s.fsf@xmission.com>
        <e371e586-0859-adb0-6666-d40a909d0b22@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e371e586-0859-adb0-6666-d40a909d0b22@amd.com> (Andrey
        Grodzovsky's message of "Tue, 24 Apr 2018 12:51:13 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.Panariti@amd.com, oleg@redhat.com, akpm@linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/24/2018 12:42 PM, Eric W. Biederman wrote:
>> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>>
>>> Currently calling wait_event_killable as part of exiting process
>>> will stall forever since SIGKILL generation is suppresed by PF_EXITING.
>>>
>>> In our partilaur case AMDGPU driver wants to flush all GPU jobs in
>>> flight before shutting down. But if some job hangs the pipe we still want to
>>> be able to kill it and avoid a process in D state.
>> I should clarify.  This absolutely can not be done.
>> PF_EXITING is set just before a task starts tearing down it's signal
>> handling.
>>
>> So delivering any signal, or otherwise depending on signal handling
>> after PF_EXITING is set can not be done.  That abstraction is gone.
>
> I see, so you suggest it's the driver responsibility to avoid creating
> such code path that ends up
> calling wait_event_killable from exit call stack (PF_EXITING == 1) ?

I don't just suggest.

I am saying clearly that any dependency on receiving SIGKILL after
PF_EXITING is set is a bug.

It looks safe (the bitmap is not freed) to use wait_event_killable on a
dual use code path, but you can't expect SIGKILL ever to be delivered
during fop->release, as f_op->release is called from exit after signal
handling has been shutdown.

The best generic code could do would be to always have
fatal_signal_pending return true after PF_EXITING is set.

Increasingly I am thinking that drm_sched_entity_fini should have a
wait_event_timeout or no wait at all.  The cleanup code should have
a progress guarantee of it's own.

Eric
