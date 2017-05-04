From: Nikola Pajkovsky <npajkovsky@suse.cz>
Subject: Re: [RFC] drm/amd/amdgpu: get rid of else branch
Date: Thu, 04 May 2017 14:57:26 +0200
Message-ID: <87efw47pah.fsf@suse.cz>
References: <c9e022e344770c861714615c6386d1821e2fa0a5.1493307341.git.npajkovsky@suse.cz>
        <6ce3044b-9473-94eb-e54c-e8e856f1c88f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ce3044b-9473-94eb-e54c-e8e856f1c88f@amd.com> ("Christian
        =?utf-8?Q?K=C3=B6nig=22's?= message of "Fri, 28 Apr 2017 10:30:49 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Christian König <christian.koenig@amd.com> writes:

> Am 27.04.2017 um 18:17 schrieb Nikola Pajkovsky:
>> This is super simple elimination of else branch and I should
>> probably even use unlikely in
>>
>>   	if (ring->count_dw < count_dw) {
>>
>> However, amdgpu_ring_write() has similar if condition, but does not
>> return after DRM_ERROR and it looks suspicious. On error, we still
>> adding v to ring and keeping count_dw-- below zero.
>>
>> 	if (ring->count_dw <= 0)
>> 		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
>> 	ring->ring[ring->wptr++] = v;
>> 	ring->wptr &= ring->ptr_mask;
>> 	ring->count_dw--;
>>
>> I can obviously be totaly wrong. Hmm?
>
> That's just choosing the lesser evil.
>
> When we write more DW to the ring than expected it is possible (but
> not likely) that we override stuff on the ring buffer which is still
> executed by the command processor leading to a possible CP crash.
>
> But when we completely drop the write the commands in the ring buffer
> will certainly be invalid and so the CP will certainly crash sooner or
> later.

Instead of choosing the lesser evil, is there good way to design ring
buffer right way?

> Please add the unlikely() as well and then send out the patch with a
> signed-of-by line and I will be happy to push it into our upstream
> branch.

Proper patch has been sent.

-- 
Nikola
