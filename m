Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59072606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=RZXBmOcX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA8EC10F283;
	Tue, 20 Oct 2026 07:04:00 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F19610F25E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 07:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=lErXpm3EWPpLA7UrZg77d+A0pPBL077yZqRtv0piVbw=; b=RZXBmOcXYX+cveXUZgjKNG/fBb
 5aLZZTkQTGl+Kc5eUy1FIFvCtp5X5Wthbb/85eahy8JRCbwS6q4G4NAp/958vAqPTwC0Ne7e55TXF
 trOKrTAz4mfJaLdZ1W1FRh4hhQYuRjl0+FH6VwyKmzO770l8OwJZztCi3p8eJtOdqjwNNdwo1sE6N
 YEFNttkbBxmdQivpZJTEjFKCqcOfzpwc3Bp8g2iAPLIXeQNBifxTwOQz28+TR2SF8aWDz2Fs8FUMF
 LartjD2uTOZ3zTS8VFyugHdrlEU+5y9v0N8yWdcJ2O/6v2snLHYciCt1wdwt0jjPW4I/FSFOTE5qM
 YTGord3Q==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJ3t0-004HXE-UR; Tue, 20 Oct 2026 09:03:50 +0200
Message-ID: <e2777c34-f12c-4861-b7b9-6ae12163864e@igalia.com>
Date: Tue, 20 Oct 2026 08:03:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: guard VCE/UVD sched entity teardown on
 failed probe
To: phasta@kernel.org, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
References: <20261015193037.86472-1-olivier.kaloudoff@gmail.com>
 <d6a743a1-7268-4167-9378-a364b6c04fbb@igalia.com>
 <e1202a38369202264a735836a2fd6a2de3609a13.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <e1202a38369202264a735836a2fd6a2de3609a13.camel@mailbox.org>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 20/10/2026 07:47, Philipp Stanner wrote:
> On Fri, 2026-10-16 at 09:23 +0100, Tvrtko Ursulin wrote:
>>
>> On 15/10/2026 20:30, Olivier Kaloudoff wrote:
>>> The hole was latent-but-safe until commit 2df5efb45425 ("drm/sched:
>>> Remove redundant entity->rq initialization and checks") removed the
>>> if (!entity->rq) early return that commit 1decbf6bb0b4 ("drm/sched:
>>> Fix entities with 0 rqs.") had put in drm_sched_entity_flush(), on the
>>> grounds that entity->rq can never be NULL. That holds only for
>>> entities that completed drm_sched_entity_init() — not for the
>>> never-initialized entity this teardown path reaches.
> 
> […]
> 
>>>    
>>> -	drm_sched_entity_destroy(&adev->uvd.entity);
>>> +	if (adev->uvd.entity.rq)
>>> +		drm_sched_entity_destroy(&adev->uvd.entity);
>>>    
>>>    	for (j = 0; j < adev->uvd.num_uvd_inst; ++j) {
>>>    		if (adev->uvd.harvest_config & (1 << j))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> index 1f7a98cdc..3952af9ae 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> @@ -253,7 +253,8 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>>>    	if (adev->vce.vcpu_bo == NULL)
>>>    		return 0;
>>>    
>>> -	drm_sched_entity_destroy(&adev->vce.entity);
>>> +	if (adev->vce.entity.rq)
>>> +		drm_sched_entity_destroy(&adev->vce.entity);
>>>    
>>>    	for (i = 0; i < adev->vce.num_rings; i++)
>>>    		amdgpu_ring_fini(&adev->vce.ring[i]);
>>
>> Dang, it looks like currently the ownership of entity initialization is
>> broken between the IP agnostic phase which does the init, and per-IP
>> phase which tears it down.
>>
>> The fix will get in the way of me re-trying to embed the run-queue into
>> the scheduler but it does look correct.
> 
> Couldn't the status be tracked through the vce struct?
> 
> if (vce.entity_initialized)
> 
> Otherwise you rely on API-internals (again) which is what enabled that
> bug AFAICS. If it's about amdgpu having called foo_init() or not, then
> the most robust solution is to track within amdgpu "did I call that
> function already?" Same applies to all constructors and destructors in
> the kernel AFAIK.

Yep, it is such a horrible pattern to rely on being able to call 
destructors on non-initialized objects. I am looking at some flavour of 
"track in amdgpu" as priority options. Either by re-arranging the probe 
steps, or by tracking explicitly.

>>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> I will see if I can re-work the init/cleanup phases so this can be
>> removed, or if not, try to add a proper DRM scheduler API to query the
>> status of an entity.
> 
> An API with which you can query whether a data object that you
> allocated and that you own had the constructor run by yourself? Or am I
> misunderstanding something?

Yeah it would be bad. I don't think it will come to it since there is at 
least one better option.

Regards,

Tvrtko

