From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover from ring hang.
Date: Tue, 24 Apr 2018 11:30:03 -0500
Message-ID: <87bme8bm9g.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
        <DM5PR12MB244017F98FC732EB5DD86E0395880@DM5PR12MB2440.namprd12.prod.outlook.com>
        <b4309ea4-c1a0-5811-040b-4390ce6f297f@amd.com>
        <DM5PR12MB24408FF7C780D95307FB2BAD95880@DM5PR12MB2440.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DM5PR12MB24408FF7C780D95307FB2BAD95880@DM5PR12MB2440.namprd12.prod.outlook.com>
        (David Panariti's message of "Tue, 24 Apr 2018 16:20:16 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: "Panariti, David" <David.Panariti@amd.com>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "oleg@redhat.com" <oleg@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: amd-gfx.lists.freedesktop.org

"Panariti, David" <David.Panariti@amd.com> writes:

> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>> Kind of dma_fence_wait_killable, except that we don't have such API
>> (maybe worth adding ?)
> Depends on how many places it would be called, or think it might be called.  Can always factor on the 2nd time it's needed.
> Factoring, IMO, rarely hurts.  The factored function can easily be visited using `M-.' ;->
>
> Also, if the wait could be very long, would a log message, something like "xxx has run for Y seconds."  help?
> I personally hate hanging w/no info.

Ugh.  This loop appears susceptible to loosing wake ups.  There are
races between when a wake-up happens, when we clear the sleeping state,
and when we test the stat to see if we should stat awake.  So yes
implementing a dma_fence_wait_killable that handles of all that
correctly sounds like an very good idea.

Eric


>> If the ring is hanging for some reason allow to recover the waiting by sending fatal signal.
>>
>> Originally-by: David Panariti <David.Panariti@amd.com>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index eb80edf..37a36af 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
>>
>>       if (other) {
>>               signed long r;
>> -             r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
>> -             if (r < 0) {
>> -                     DRM_ERROR("Error (%ld) waiting for fence!\n", r);
>> -                     return r;
>> +
>> +             while (true) {
>> +                     if ((r = dma_fence_wait_timeout(other, true,
>> +                                     MAX_SCHEDULE_TIMEOUT)) >= 0)
>> +                             return 0;
>> +
>> +                     if (fatal_signal_pending(current)) {
>> +                             DRM_ERROR("Error (%ld) waiting for fence!\n", r);
>> +                             return r;
>> +                     }
>>               }
>>       }
>>
>> --
>> 2.7.4
>>
Eric
