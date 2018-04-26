From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
Date: Thu, 26 Apr 2018 10:57:46 -0500
Message-ID: <87zi1qq7t1.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <87muxsbmkp.fsf@xmission.com>
        <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
        <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
        <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
        <20180425171757.GA10441@redhat.com>
        <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com>
        <874ljyu98e.fsf@xmission.com>
        <611911a3-2858-200c-d5f8-679c5f41ee3a@amd.com>
        <d6754c66-afe8-db2a-5633-d33701e22f3c@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d6754c66-afe8-db2a-5633-d33701e22f3c@amd.com> (Andrey
        Grodzovsky's message of "Thu, 26 Apr 2018 08:52:34 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.Panariti@amd.com, akpm@linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/26/2018 08:34 AM, Andrey Grodzovsky wrote:
>>
>>
>> On 04/25/2018 08:01 PM, Eric W. Biederman wrote:
>>> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>>>
>>>> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>>>>> On 04/25, Andrey Grodzovsky wrote:
>>>>>> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
>>>>>> able to exit immediately
>>>>>> and not wait for GPU jobs completion when the reason for reaching this
>>>>>> code
>>>>>> is because of KILL
>>>>>> signal to the user process who opened the device file.
>>>>> Can you hook f_op->flush method?
>>>> But this one is called for each task releasing a reference to the the file,
>>>> so
>>>> not sure I see how this solves the problem.
>>> The big question is why do you need to wait during the final closing a
>>> file?
>>>
>>> The wait can be terminated so the wait does not appear to be simply a
>>> matter of correctness.
>>
>> Well, as I understand it, it just means that you don't want to abruptly
>> terminate GPU work in progress without a good
>> reason (such as KILL signal). When we exit we are going to release various
>> resources GPU is still using so we either
>> wait for it to complete or terminate the remaining jobs.

At the point of do_exit you might as well be a KILL signal however you
got there.

> Looked more into code, some correction, drm_sched_entity_fini means the SW job
> queue itself is about to die, so we must
> either wait for completion or terminate any outstanding jobs that are still in
> the SW queue. Anything which already in flight in HW
> will still complete.

It sounds like we don't care if we block the process that had the file
descriptor open, this is just book keeping.  Which allows having a piece
of code that cleans up resources when the GPU is done with the queue but
does not make userspace wait.  (option 1)

For it to make sense that we let the process run there has to be
something that cares about the results being completed.  If all of the
file descriptors are closed and the process is killed I can't see who
will care that the software queue will continue to be processed.  So it
may be reasonable to simply kill the queue (option 2).

If userspace really needs the wait it is probably better done in
f_op->flush so that every close of the file descriptor blocks
until the queue is flushed (option 3).

Do you know if userspace cares about the gpu operations completing?

My skim of the code suggests that nothing actually cares about those
operations, but I really don't know the gpu well.

Eric
