From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
Date: Wed, 25 Apr 2018 19:01:05 -0500
Message-ID: <874ljyu98e.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <87muxsbmkp.fsf@xmission.com>
        <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
        <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
        <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
        <20180425171757.GA10441@redhat.com>
        <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> (Andrey
        Grodzovsky's message of "Wed, 25 Apr 2018 14:40:54 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.Panariti@amd.com, akpm@linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>> On 04/25, Andrey Grodzovsky wrote:
>>> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
>>> able to exit immediately
>>> and not wait for GPU jobs completion when the reason for reaching this code
>>> is because of KILL
>>> signal to the user process who opened the device file.
>> Can you hook f_op->flush method?
>
> But this one is called for each task releasing a reference to the the file, so
> not sure I see how this solves the problem.

The big question is why do you need to wait during the final closing a
file?

The wait can be terminated so the wait does not appear to be simply a
matter of correctness.

Eric
