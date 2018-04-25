From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
Date: Wed, 25 Apr 2018 11:31:45 -0500
Message-ID: <87y3hbtfgu.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
        <20180424194418.GE25142@phenom.ffwll.local>
        <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
        <87tvs05mik.fsf@xmission.com>
        <27d7d15b-f7c3-2a0a-af85-eb243526ac88@amd.com>
        <20180425071444.GM25142@phenom.ffwll.local>
        <94828a42-02dd-29ad-a3d0-dc4c0cc82ddb@amd.com>
        <87a7trwbh0.fsf@xmission.com>
        <311660b9-9e46-b960-3088-06e16ac3838d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <311660b9-9e46-b960-3088-06e16ac3838d@amd.com> (Andrey
        Grodzovsky's message of "Wed, 25 Apr 2018 12:13:58 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: David.Panariti@amd.com, Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, oleg@redhat.com, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, akpm@linux-foundation.org, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/25/2018 11:29 AM, Eric W. Biederman wrote:
>
>>  Another issue is changing wait_event_killable to wait_event_timeout where I need
>> to understand
>> what TO value is acceptable for all the drivers using the scheduler, or maybe it
>> should come as a property
>> of drm_sched_entity.
>>
>> It would not surprise me if you could pick a large value like 1 second
>> and issue a warning if that time outever triggers.  It sounds like the
>> condition where we wait indefinitely today is because something went
>> wrong in the driver.
>
> We wait here for all GPU jobs in flight which belong to the dying entity to complete. The driver submits
> the GPU jobs but the content of the job might be is not under driver's control and could take 
> long time to finish or even hang (e.g. graphic or compute shader) , I
> guess that why originally the wait is indefinite.


I am ignorant of what user space expect or what the semantics of the
susbsystem are here, so I might be completely off base.  But this wait
for a long time behavior I would expect much more from f_op->flush or a
f_op->fsync method.

fsync so it could be obtained without closing the file descriptor.
flush so that you could get a return value out to close.

But I honestly don't know semantically what your userspace applications
expect and/or require so I can really only say.  Those of weird semantics.

Eric
