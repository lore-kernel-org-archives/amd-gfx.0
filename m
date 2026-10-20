Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6EA606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=kQxxdj/b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF1E10E18F;
	Tue, 20 Oct 2026 12:44:55 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C6110F569
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 12:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=rZopRmdABCjN8u+mz2E6s0XogTbfA1m8lacLfZ4a14w=; b=kQxxdj/bd/ibmyPF/0yV/Qhze5
 uvyoCCWKUYWzoiwYlMR4jN4oPNfFwQfSKz7u7DhbhkzIMj30jBRbVQO+3Xqu3va5a89R9KPfAF8pb
 cShNfW0kpSHntS0PVNx+0oYbhHPICoDafumo7FCYvPr4unlBs/2sg+rzcwggQkxtRoXjE8sf8ZhL8
 VwlXJqHSG/IzFG0GGzbe2kBBVyTmjnTOIC2vMiK7819V4gdAENiHvHa+uF9vjh5Aogba2FRuRQKZ/
 rlgUpk7hRWSUyyz2hcJ0GyrpZuyjo72TnKnC2sve113/bijK+Qx97p2W7DoCn1BkujZQKtvPKiECZ
 dqkw5SdA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJ9Cr-004a4D-D8; Tue, 20 Oct 2026 14:44:41 +0200
Message-ID: <c7e16efc-d5e0-4fef-9333-27be817270fb@igalia.com>
Date: Tue, 20 Oct 2026 13:44:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: guard VCE/UVD sched entity teardown on
 failed probe
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 phasta@kernel.org, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261015193037.86472-1-olivier.kaloudoff@gmail.com>
 <d6a743a1-7268-4167-9378-a364b6c04fbb@igalia.com>
 <e1202a38369202264a735836a2fd6a2de3609a13.camel@mailbox.org>
 <e2777c34-f12c-4861-b7b9-6ae12163864e@igalia.com>
 <256909c8-6099-4481-8579-f39112bd31ed@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <256909c8-6099-4481-8579-f39112bd31ed@amd.com>
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


On 20/10/2026 13:08, Christian König wrote:
> On 10/20/26 09:03, Tvrtko Ursulin wrote:
>>
>> On 20/10/2026 07:47, Philipp Stanner wrote:
>>> On Fri, 2026-10-16 at 09:23 +0100, Tvrtko Ursulin wrote:
>>>>
>>>> On 15/10/2026 20:30, Olivier Kaloudoff wrote:
>>>>> The hole was latent-but-safe until commit 2df5efb45425 ("drm/sched:
>>>>> Remove redundant entity->rq initialization and checks") removed the
>>>>> if (!entity->rq) early return that commit 1decbf6bb0b4 ("drm/sched:
>>>>> Fix entities with 0 rqs.") had put in drm_sched_entity_flush(), on the
>>>>> grounds that entity->rq can never be NULL. That holds only for
>>>>> entities that completed drm_sched_entity_init() — not for the
>>>>> never-initialized entity this teardown path reaches.
>>>
>>> […]
>>>
>>>>>     -    drm_sched_entity_destroy(&adev->uvd.entity);
>>>>> +    if (adev->uvd.entity.rq)
>>>>> +        drm_sched_entity_destroy(&adev->uvd.entity);
>>>>>            for (j = 0; j < adev->uvd.num_uvd_inst; ++j) {
>>>>>             if (adev->uvd.harvest_config & (1 << j))
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>> index 1f7a98cdc..3952af9ae 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>> @@ -253,7 +253,8 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>>>>>         if (adev->vce.vcpu_bo == NULL)
>>>>>             return 0;
>>>>>     -    drm_sched_entity_destroy(&adev->vce.entity);
>>>>> +    if (adev->vce.entity.rq)
>>>>> +        drm_sched_entity_destroy(&adev->vce.entity);
>>>>>            for (i = 0; i < adev->vce.num_rings; i++)
>>>>>             amdgpu_ring_fini(&adev->vce.ring[i]);
>>>>
>>>> Dang, it looks like currently the ownership of entity initialization is
>>>> broken between the IP agnostic phase which does the init, and per-IP
>>>> phase which tears it down.
>>>>
>>>> The fix will get in the way of me re-trying to embed the run-queue into
>>>> the scheduler but it does look correct.
>>>
>>> Couldn't the status be tracked through the vce struct?
>>>
>>> if (vce.entity_initialized)
>>>
>>> Otherwise you rely on API-internals (again) which is what enabled that
>>> bug AFAICS. If it's about amdgpu having called foo_init() or not, then
>>> the most robust solution is to track within amdgpu "did I call that
>>> function already?" Same applies to all constructors and destructors in
>>> the kernel AFAIK.
>>
>> Yep, it is such a horrible pattern to rely on being able to call destructors on non-initialized objects. I am looking at some flavour of "track in amdgpu" as priority options. Either by re-arranging the probe steps, or by tracking explicitly.
> 
> Yeah the problem goes deeper than the DRM scheduler here.
> 
> Normally the sw_fini callback should only be called when the sw_init callback succeeded. Same for the hw_init/hw_fini.
> 
> Somehow amdgpu tries to tear down an IP block which was never full initialized in the first place. The scheduler is just the first component where it becomes obvious that something is going wrong here.
> 
> So we need to take a step back and ask why sw_fini is called for something that was never initialized *OR* maybe why the DRM scheduler init is somewhere else than the fini.

Problem is entity is initialized outside of sw_init (after), while 
destroy is done on sw_fini.

Flow is roughly like this:

amdgpu_device_ip_init
  sw_init
  ... danger zone ...
  amdgpu_device_init_schedulers (this initializes the entity)

So any probe failure inside the danger zone calls (correctly) sw_fini 
and that calls drm_sched_entity_destroy (incorrectly).

I tried moving entity init into the ip block domain, to fix the confused 
"ownership", but it is all interleaved and not straightforward to 
untangle. For now I gave up and have a local patch which adds an 
explicit flag. I'll send it once this one propagates to some visible branch.

At least I have some new trivial cleanup patches as a bonus result, 
which I will also send soon.

Regards,

Tvrtko

>>>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>
>>>> I will see if I can re-work the init/cleanup phases so this can be
>>>> removed, or if not, try to add a proper DRM scheduler API to query the
>>>> status of an entity.
>>>
>>> An API with which you can query whether a data object that you
>>> allocated and that you own had the constructor run by yourself? Or am I
>>> misunderstanding something?
>>
>> Yeah it would be bad. I don't think it will come to it since there is at least one better option.
>>
>> Regards,
>>
>> Tvrtko
>>
> 

