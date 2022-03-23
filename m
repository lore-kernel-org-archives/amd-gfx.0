Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B17C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 06:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30F610E38A;
	Wed, 23 Mar 2022 06:22:47 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF0A610E38A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 06:22:46 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae903.dynamic.kabel-deutschland.de
 [95.90.233.3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id C263561EA1928;
 Wed, 23 Mar 2022 07:22:44 +0100 (CET)
Message-ID: <c1898ff9-c274-2f74-5998-d5e0afc0d14c@molgen.mpg.de>
Date: Wed, 23 Mar 2022 07:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Correct the parameter name of amdgpu_ring_init
Content-Language: en-US
To: Jun Ma <majun@amd.com>
References: <20220322125308.3771732-1-Jun.Ma2@amd.com>
 <bcf4bb86-4b76-0b02-d0f6-2af822e5276f@amd.com>
 <e424caae-277d-4aec-7057-8b38c27cd9ad@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <e424caae-277d-4aec-7057-8b38c27cd9ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: alexander.deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Jun,


Thank you for your patch.

Am 23.03.22 um 04:02 schrieb Ma, Jun:

> On 3/22/2022 9:33 PM, Christian König wrote:
>> Am 22.03.22 um 13:53 schrieb Ma Jun:
>>> Correct the parameter name of amdgpu_ring_init() in header file.
>>
>> Maybe write "Sync up header and implementation to use the same parameter
>> names", otherwise somebody could think that this is a real functional
>> bug fix and backport it.
>> ok, will fix this in v2

(Your mailer incorrectly quoted your reply sentence, making it look like 
it was written by Christian.)

If you re-roll the patch, please also mention both parameter names in 
the commit message, so people do not have to search in the diff for 
them, and can verify the changes match your intention. (The summary uses 
singular *name* adding a little confusion.)


Kind regards,

Paul


>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>
>> With the commit message and subject adjusted the patch is Reviewed-by:
>> Christian König <christian.koenig@amd.com>
>>
>>> Change-Id: I202d76ba04b137926b456b1c8a4c05a5b1a01bff
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 5320bb0883d8..317d80209e95 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -300,8 +300,8 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>>>    void amdgpu_ring_commit(struct amdgpu_ring *ring);
>>>    void amdgpu_ring_undo(struct amdgpu_ring *ring);
>>>    int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>> -		     unsigned int ring_size, struct amdgpu_irq_src *irq_src,
>>> -		     unsigned int irq_type, unsigned int prio,
>>> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
>>> +		     unsigned int irq_type, unsigned int hw_prio,
>>>    		     atomic_t *sched_score);
>>>    void amdgpu_ring_fini(struct amdgpu_ring *ring);
>>>    void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
>>
