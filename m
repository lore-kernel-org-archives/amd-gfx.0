Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84248606A32F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=lsr2bxVJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0F510E11C;
	Wed, 18 Nov 2026 15:41:56 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED0B10E11C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=OZBhk4utbSlaG4QH3uLQB80jNFsvj2n69s7q+XqG85k=; t=1795016511; x=2110376511; 
 b=lsr2bxVJ8DISBhu18Lsnk5ANPSFilHWbMECCXGM4ieX0dUuq1xDDomhoTNx3K2wmf2cjdWXrbZA
 7+xNu1ioWaFk2HIVbVRk2NEU9p092g5xVnb+i5R7mC7vf6zkSx6gwLbOMV7Z8ng0aWw04b1rVlQZK
 YPnnftsHgRvix7r2lRA+Yh0ElVZG4CFomcORiOuAzhyn3JOAPohNI6z+e5zp8gKSkPzg2mPy3yXNM
 grXq9RBtNdVTrz5HgwdEDeFUnT2cXyrqzGgitbkT98xB21nLgYFd3oBgAvGw6oYMKbnCnN56MXoL7
 bCFgyYnzifV8Iiu5LOsu/5xwAa+owSAw/NZw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xThnB-000000014fu-2b1x; Wed, 18 Nov 2026 16:41:49 +0100
Message-ID: <ba676297-c8cd-48e4-9853-17f92eafc57b@igalia.com>
Date: Wed, 18 Nov 2026 15:41:48 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Track entity initialization status in the
 driver
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: kernel-dev@igalia.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
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


[Gently promoting Alex and Christian from Cc to To]

Would you be okay merging this to decouple amdgpu from scheduler 
internals a bit more?

Thanks,

Tvrtko

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
> 
> 
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
> 
> 
> P.

