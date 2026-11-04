Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA7606A326
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=YrvLs8tl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB03310E75B;
	Wed,  4 Nov 2026 12:57:27 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BB010E75B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 12:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=wzNTUmTcHP+LAH8ZpfX7K6jy0cFW+GQNyrjwGZvnOCg=; t=1793797041; x=2109157041; 
 b=YrvLs8tlATbRwnat1bImZQEXN/1eHtdqUwllUelf0iHJ7lps6p2UO1yhTlx+QHFt9Rmhn3rjIyA
 Qvl1IfR0mx5sWdvl0ENAa+CDLLljjG+PRV5rgQ4Pq/CDqhdrjMydgR5lMStIFUXh0UoRBSTwyDIej
 BgFALkWITy9r+wRY9ut39clX/NtI8MJutEVZxeQRjA4/NVxLRsZjQPb2FGBX8HrJul6y6pdsVDvF4
 L0K1yNK1W7CVHYnDT3IccTan08kzrteYr+n+PWvj9ugOitl+7/B9wvAOk3pi8MDLibqO8Wp7rq7vJ
 N/TxOARDfhjykn68JDPrYkfPb2GC8crXaZww==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xOaYJ-002GpX-Qq; Wed, 04 Nov 2026 13:57:19 +0100
Message-ID: <42ee9a20-06e5-44c2-b27e-cfe5bfc6c09e@igalia.com>
Date: Wed, 4 Nov 2026 12:57:19 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Track entity initialization status in the
 driver
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20261104121647.34640-1-tvrtko.ursulin@igalia.com>
 <4e1ffc9f2d29bbe9482614b65dabfd96e058ecca.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <4e1ffc9f2d29bbe9482614b65dabfd96e058ecca.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 04/11/2026 12:39, Philipp Stanner wrote:
> On Wed, 2026-11-04 at 12:16 +0000, Tvrtko Ursulin wrote:
>> Instead of accessing the internals of the DRM scheduler data structures
>> directly and relying on the own entity backing store to be zeroed on
>> allocation, lets explicitly track whether we have called
>> drm_sched_entity_init() and base on that the decision on whether or not
>> to call drm_sched_entity_destroy().
>>
>> Alternative could (in theory) be to re-order the driver init/fini flows,
>> but that is really complicated due inter-dependencies between different
>> stages.
> 
> +1, nice.
> 
>> Apart from being conceptually cleaner this also re-allows future DRM
>> scheduler work which will embed the run-queue in the scheduler.
> 
> Is that related to the spsc_queue work you're doing, or only to
> Olivier's recent patches?
> 
> https://lore.kernel.org/dri-devel/20261022105454.60267-1-olivier.kaloudoff@gmail.com/

Not that one but it is a follow up on 3ad55d18f468 ("drm/amdgpu: guard 
VCE/UVD sched entity teardown on failed probe").

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Acked-by: Philipp Stanner <phasta@kernel.org>
> 
>> ---
>> Considering how many hundreds of kilobytes I have saved so far I hope I
>> can get away with adding a couple of booleans. ;)
> 
> You *could* look into reordering the structs to reduce padding? IMO the
> byte count is irrelevant; so just an idea.

I had that idea as well some time ago, from my branch called 
250221-amdholes-2, so you figure the naming scheme:

31052b84323b (250221-amdholes-2) drm/amdgpu: Reduce holes in struct 
amdgpu_job
fcee566a59ed drm/amdgpu: Remove hole from struct amdgpu_ib
af32c97bc278 struct amdgpu_bo_param
337fa2519367 struct amdgpu_bo_list_entry
bc0187dd2856 struct amdgpu_reset_context
429001ac71ef struct amdgpu_reset_domain
856887ace7a0 struct amdgpu_wb
c1fc08af9241 struct amdgpu_pm
95efb111d2f4 struct amdgpu_vmid_mgr
4e6b00a4da43 struct amdgpu_vm_manager
79cffa09930d struct amdgpu_vm_update_params
4f2d88484f3b struct amdgpu_vm
fb8f72204695 struct amdgpu_rlc
b91d7eca6360 struct amdgpu_irq
a0bfd7075a88 struct amdgpu_iv_entry
838956ae96f6 struct amdgpu_ih_ring
12fb7dde6fca stable_pstate
ac62fdab31b7 struct amdgpu_ctx
e89d67894fe4 struct amdgpu_ring {
3f98c5c7e73b struct amdgpu_fence_driver

:)

But it's not that interesting for most of those have no many instances 
at runtime. And is easy to get re-broken. So I wasn't pursuing it much, 
only ctx one I got merged. If you are curious there was bigger fish to fry:

6eadd448d7e7 drm/amdgpu: Choose SOC15 RLC register read write functions 
at init time

or:

789551e08ebe drm/amdgpu: Extend logical to device instance lookup to all 
devices

Not listing the smaller ones, those two on their own saved half a 
megabyte. So I can be excused to add a couple of booleans I think. :)

> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 4 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h | 1 +
>>   4 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> index cd35ff7ca864..8f69aa4597e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> @@ -377,7 +377,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>>   	void *addr = amdgpu_bo_kptr(adev->uvd.ib_bo);
>>   	int i, j;
>>   
>> -	if (adev->uvd.entity.rq)
>> +	if (adev->uvd.entity_initialized)
> 
> Just asking, what's the ordering semantics of this like in amdgpu? All
> guarded by the same outer lock that serializes drm_sched_job_arm() and
> drm_sched_entity_submit()?

This is the driver probe and unbind paths so shouldn't have any 
connection to job arming etc.

Regards,

Tvrtko

