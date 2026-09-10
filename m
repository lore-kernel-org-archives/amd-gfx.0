Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970D9C79F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 14:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2649610E1F6;
	Thu, 10 Sep 2026 14:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g7iIWjOB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BB010E1F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=13QZMNCHSafqCevDyVAtb0yEW4trUWtt5q4k4N3NxH8=; b=g7iIWjOBj/zsyKNMB7+i495MXb
 b6L3iTENUGDV0hE7e+5wLKuoDjWlc6mxD0tiw4af2BAQgMcpfgp1qn5o1OnLxyEXktyxKxMfQf/pL
 OvXaQy5YppfRou+qArLxr4Zqtk5IUH52lxXc/hWgRTt1DgM027fhHp4ByjeCG0lcgWVGsyjyz/deh
 ThQIDYD+YetM5I3G4uK6fqzNFS41N7dCxr1U1YlLQ4eWdC/QOxfXq3JRC+xbVXXVPWpEulk5HBpyW
 VohAwCrGq7PMC4cWpJ8ju8cJjMZnUfvdhMbxpTDyrQMMBjtICFz3wzLRWmj5chpEAuMhGn7Z5IW1N
 09w+xCPQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x4fvW-000D0u-6z; Thu, 10 Sep 2026 16:38:58 +0200
Message-ID: <34e86c9a-9d38-4365-a65d-0323018904d6@igalia.com>
Date: Thu, 10 Sep 2026 15:38:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: Add SDMA ring init helper
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
 <20260909105215.88242-2-tvrtko.ursulin@igalia.com>
 <s5-Dk6INQlqq93576HqTlw@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <s5-Dk6INQlqq93576HqTlw@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 09/09/2026 19:27, Timur Kristóf wrote:
> On 2026. szeptember 9., szerda 12:52:10 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> Consolidate one part of the SDMA ring initialization with a new
>> amdgpu_sdma_ring_init() helper.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 19 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +++
>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  7 +------
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  7 +------
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 13 ++-----------
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 19 ++++++-------------
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  7 +------
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 +-----
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  8 ++------
>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  7 +------
>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 13 +++++--------
>>   11 files changed, 42 insertions(+), 67 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c index fbac732f3e01..cca8b3a98f6a
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -37,6 +37,25 @@
>>    * GPU SDMA IP block helpers function.
>>    */
>>
>> +int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring
>> *ring, +			  const char *prefix, unsigned int index)
> 
> Instead of "index", I suggest "instance_id" to make it clear what it is.
> Additionally please add an xcc_id argument because some SDMA versions seem to
> need that too.

I can use instance_id although then it will be incosistent with the two 
helpers just below it which call it index.

Regarding xcc_id I didn't to pull in thing which are IP version 
specific. With the expection of the name, will comment on that a bit lower.

> 
>> +{
>> +	int r;
>> +
>> +	ring->ring_obj = NULL;
> 
> Maybe also consider moving here the following lines:
> ring->me = instance_id;

I considered this but noticed ring->me assignment is a bit messy.

Basically it is done it early init via *_set_ring_funcs(). And I think 
this is required for ordering.

Some IP versions then set in again *_sw_init() but I don't see how that 
is required. Shall I add a patch to remove those instead of initializing 
ring->me in this new helper?

> ring->use_doorbell = ... // based on SDMA IP version

I didn't want to pull in anything which would require branching on IP 
version.

> ring->no_user_submission = adev->sdma.no_user_submission;

ring->no_user_submission I haven't looked at. If the default would be 
the same on IPs which currently leave it at default of false.. Let me 
see.. It looks it would be safe becuase both adev and sdma instance 
struct allocations are zeroed. Don't know somehow I would be nervous of 
baking this assumption in.

> 
>> +
>> +	if (prefix)
>> +		sprintf(ring->name, "sdma%u", index);
> 
> Seems like this wouldn't name the page queues correctly.
> Suggestion:
> 
> sprintf(ring->name, "%s%u.%u", prefix ?: "sdma", xcc_id, instance_id);

This is the exception to my rule in that I left those callers override 
it. For 7.1:

		r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
		if (r)
			return r;

		sprintf(ring->name, "sdma%d.%d", xcc_id,
			GET_INST(SDMA0, i) % adev->sdma.num_inst_per_xcc);
	}

And 4.4.2:

		ring = &adev->sdma.instance[i].ring;
...
		r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
...
		sprintf(ring->name, "sdma%d.%d", aid_id,
				i % adev->sdma.num_inst_per_aid);


			ring = &adev->sdma.instance[i].page;
...
			r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
...
			sprintf(ring->name, "page%d.%d", aid_id,
					i % adev->sdma.num_inst_per_aid);

Maybe I try to make amdgpu_sdma_ring_init variadic and so the format and 
args can be passed in?

Regards,

Tvrtko

> 
> 
>> +
>> +	r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
>> +			     AMDGPU_SDMA_IRQ_INSTANCE0 + index,
>> +			     AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +	if (r)
>> +		return r;
>> +
>> +	return 0;
>> +}
>> +
>>   struct amdgpu_sdma_instance *amdgpu_sdma_get_instance_from_ring(struct
>> amdgpu_ring *ring) {
>>   	struct amdgpu_device *adev = ring->adev;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h index 671cfbb67b7a..2f1edef97c2f
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> @@ -158,6 +158,9 @@ struct amdgpu_buffer_funcs {
>>   				 uint32_t byte_count);
>>   };
>>
>> +int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring
>> *ring, +			  const char *prefix, unsigned int index);
>> +
>>   int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>> instance_id, bool caller_handles_kernel_queues);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c index 657ef6c93c61..fb2047d8e25a
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> @@ -865,13 +865,8 @@ static int sdma_v2_4_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>
>>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>>   		ring = &adev->sdma.instance[i].ring;
>> -		ring->ring_obj = NULL;
>>   		ring->use_doorbell = false;
>> -		sprintf(ring->name, "sdma%d", i);
>> -		r = amdgpu_ring_init(adev, ring, 1024, &adev-
>> sdma.trap_irq,
>> -				     (i == 0) ?
> AMDGPU_SDMA_IRQ_INSTANCE0 :
>> -				     AMDGPU_SDMA_IRQ_INSTANCE1,
>> -				     AMDGPU_RING_PRIO_DEFAULT,
> NULL);
>> +		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>>   		if (r)
>>   			return r;
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c index 9478dd034aff..656f66527999
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> @@ -1146,7 +1146,6 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>
>>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>>   		ring = &adev->sdma.instance[i].ring;
>> -		ring->ring_obj = NULL;
>>   		if (!amdgpu_sriov_vf(adev)) {
>>   			ring->use_doorbell = true;
>>   			ring->doorbell_index = adev-
>> doorbell_index.sdma_engine[i];
>> @@ -1154,11 +1153,7 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block
>> *ip_block) ring->use_pollmem = true;
>>   		}
>>
>> -		sprintf(ring->name, "sdma%d", i);
>> -		r = amdgpu_ring_init(adev, ring, 1024, &adev-
>> sdma.trap_irq,
>> -				     (i == 0) ?
> AMDGPU_SDMA_IRQ_INSTANCE0 :
>> -				     AMDGPU_SDMA_IRQ_INSTANCE1,
>> -				     AMDGPU_RING_PRIO_DEFAULT,
> NULL);
>> +		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>>   		if (r)
>>   			return r;
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c index 9d7d919a5aa1..e135dfb1c3e2
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -1858,7 +1858,6 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>
>>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>>   		ring = &adev->sdma.instance[i].ring;
>> -		ring->ring_obj = NULL;
>>   		ring->use_doorbell = true;
>>
>>   		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n",
> i,
>> @@ -1878,16 +1877,12 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block
>> *ip_block) else
>>   			ring->vm_hub = AMDGPU_MMHUB0(0);
>>
>> -		sprintf(ring->name, "sdma%d", i);
>> -		r = amdgpu_ring_init(adev, ring, 1024, &adev-
>> sdma.trap_irq,
>> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +
> i,
>> -				     AMDGPU_RING_PRIO_DEFAULT,
> NULL);
>> +		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>>   		if (r)
>>   			return r;
>>
>>   		if (adev->sdma.has_page_queue) {
>>   			ring = &adev->sdma.instance[i].page;
>> -			ring->ring_obj = NULL;
>>   			ring->use_doorbell = true;
>>
>>   			/* paging queue use same doorbell index/
> routing as gfx queue
>> @@ -1915,11 +1910,7 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block
>> *ip_block) else
>>   				ring->vm_hub = AMDGPU_MMHUB0(0);
>>
>> -			sprintf(ring->name, "page%d", i);
>> -			r = amdgpu_ring_init(adev, ring, 1024,
>> -					     &adev-
>> sdma.trap_irq,
>> -					
> AMDGPU_SDMA_IRQ_INSTANCE0 + i,
>> -					
> AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +			r = amdgpu_sdma_ring_init(adev, ring, "page",
> i);
>>   			if (r)
>>   				return r;
>>   		}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c index 461f8b220a3e..2e46e63a6dbf
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -1484,7 +1484,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block
>> *ip_block) adev->sdma.instance[i].funcs = &sdma_v4_4_2_sdma_funcs;
>>
>>   		ring = &adev->sdma.instance[i].ring;
>> -		ring->ring_obj = NULL;
>>   		ring->use_doorbell = true;
>>   		aid_id = adev->sdma.instance[i].aid_id;
>>
>> @@ -1495,18 +1494,15 @@ static int sdma_v4_4_2_sw_init(struct
>> amdgpu_ip_block *ip_block) ring->doorbell_index =
>> adev->doorbell_index.sdma_engine[i] << 1; ring->vm_hub =
>> AMDGPU_MMHUB0(aid_id);
>>   		ring->no_user_submission = adev-
>> sdma.no_user_submission;
>> +		r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
>> +		if (r)
>> +			return r;
>>
>>   		sprintf(ring->name, "sdma%d.%d", aid_id,
>>   				i % adev->sdma.num_inst_per_aid);
>> -		r = amdgpu_ring_init(adev, ring, 1024, &adev-
>> sdma.trap_irq,
>> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +
> i,
>> -				     AMDGPU_RING_PRIO_DEFAULT,
> NULL);
>> -		if (r)
>> -			return r;
>>
>>   		if (adev->sdma.has_page_queue) {
>>   			ring = &adev->sdma.instance[i].page;
>> -			ring->ring_obj = NULL;
>>   			ring->use_doorbell = true;
>>
>>   			/* doorbell index of page queue is assigned
> right after
>> @@ -1515,15 +1511,12 @@ static int sdma_v4_4_2_sw_init(struct
>> amdgpu_ip_block *ip_block) ring->doorbell_index =
>>   				(adev-
>> doorbell_index.sdma_engine[i] + 1) << 1;
>>   			ring->vm_hub = AMDGPU_MMHUB0(aid_id);
>> +			r = amdgpu_sdma_ring_init(adev, ring, NULL,
> i);
>> +			if (r)
>> +				return r;
>>
>>   			sprintf(ring->name, "page%d.%d", aid_id,
>>   					i % adev-
>> sdma.num_inst_per_aid);
>> -			r = amdgpu_ring_init(adev, ring, 1024,
>> -					     &adev-
>> sdma.trap_irq,
>> -					
> AMDGPU_SDMA_IRQ_INSTANCE0 + i,
>> -					
> AMDGPU_RING_PRIO_DEFAULT, NULL);
>> -			if (r)
>> -				return r;
>>   		}
>>   	}
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c index 97fee70dc2f6..a0614fa9ffa6
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> @@ -1411,7 +1411,6 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block
>> *ip_block) mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
>>   		adev->sdma.instance[i].funcs = &sdma_v5_0_sdma_funcs;
>>   		ring = &adev->sdma.instance[i].ring;
>> -		ring->ring_obj = NULL;
>>   		ring->use_doorbell = true;
>>
>>   		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n",
> i,
>> @@ -1422,11 +1421,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>   			: (adev->doorbell_index.sdma_engine[1] <<
> 1); // get DWORD offset
>>
>>   		ring->vm_hub = AMDGPU_GFXHUB(0);
>> -		sprintf(ring->name, "sdma%d", i);
>> -		r = amdgpu_ring_init(adev, ring, 1024, &adev-
>> sdma.trap_irq,
>> -				     (i == 0) ?
> AMDGPU_SDMA_IRQ_INSTANCE0 :
>> -				     AMDGPU_SDMA_IRQ_INSTANCE1,
>> -				     AMDGPU_RING_PRIO_DEFAULT,
> NULL);
>> +		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>>   		if (r)
>>   			return r;
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c index 35cdf6c149f8..5b3dafc194d7
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -1331,7 +1331,6 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block
>> *ip_block) mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
>>   		adev->sdma.instance[i].funcs = &sdma_v5_2_sdma_funcs;
>>   		ring = &adev->sdma.instance[i].ring;
>> -		ring->ring_obj = NULL;
>>   		ring->use_doorbell = true;
>>   		ring->me = i;
>>
>> @@ -1342,10 +1341,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block
>> *ip_block) (adev->doorbell_index.sdma_engine[i] << 1); //get DWORD offset
>>
>>   		ring->vm_hub = AMDGPU_GFXHUB(0);
>> -		sprintf(ring->name, "sdma%d", i);
>> -		r = amdgpu_ring_init(adev, ring, 1024, &adev-
>> sdma.trap_irq,
>> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +
> i,
>> -				     AMDGPU_RING_PRIO_DEFAULT,
> NULL);
>> +		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>>   		if (r)
>>   			return r;
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c index 303fd7d1b7c8..845e622d3c1a
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -1335,7 +1335,6 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>
>>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>>   		ring = &adev->sdma.instance[i].ring;
>> -		ring->ring_obj = NULL;
>>   		ring->use_doorbell = true;
>>   		ring->me = i;
>>   		ring->no_user_submission = adev-
>> sdma.no_user_submission;
>> @@ -1347,11 +1346,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block
>> *ip_block) (adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
>>
>>   		ring->vm_hub = AMDGPU_GFXHUB(0);
>> -		sprintf(ring->name, "sdma%d", i);
>> -		r = amdgpu_ring_init(adev, ring, 1024,
>> -				     &adev->sdma.trap_irq,
>> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +
> i,
>> -				     AMDGPU_RING_PRIO_DEFAULT,
> NULL);
>> +
>> +		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>>   		if (r)
>>   			return r;
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c index d5552f206e4d..ea460a19b89d
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> @@ -1319,7 +1319,6 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>
>>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>>   		ring = &adev->sdma.instance[i].ring;
>> -		ring->ring_obj = NULL;
>>   		ring->use_doorbell = true;
>>   		ring->me = i;
>>   		ring->no_user_submission = adev-
>> sdma.no_user_submission;
>> @@ -1331,11 +1330,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block
>> *ip_block) (adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
>>
>>   		ring->vm_hub = AMDGPU_GFXHUB(0);
>> -		sprintf(ring->name, "sdma%d", i);
>> -		r = amdgpu_ring_init(adev, ring, 1024,
>> -				     &adev->sdma.trap_irq,
>> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +
> i,
>> -				     AMDGPU_RING_PRIO_DEFAULT,
> NULL);
>> +		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>>   		if (r)
>>   			return r;
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c index 0f30eb503c2a..1704d406c34a
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>> @@ -1305,7 +1305,6 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>
>>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>>   		ring = &adev->sdma.instance[i].ring;
>> -		ring->ring_obj = NULL;
>>   		ring->use_doorbell = true;
>>   		ring->me = i;
>>   		ring->no_user_submission = adev-
>> sdma.no_user_submission;
>> @@ -1323,14 +1322,12 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block
>> *ip_block) (adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
>>
>>   		ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
>> +		r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
>> +		if (r)
>> +			return r;
>> +
>>   		sprintf(ring->name, "sdma%d.%d", xcc_id,
>> -				GET_INST(SDMA0, i) % adev-
>> sdma.num_inst_per_xcc);
>> -		r = amdgpu_ring_init(adev, ring, 1024,
>> -				     &adev->sdma.trap_irq,
>> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +
> i,
>> -				     AMDGPU_RING_PRIO_DEFAULT,
> NULL);
>> -		if (r)
>> -			return r;
>> +			GET_INST(SDMA0, i) % adev-
>> sdma.num_inst_per_xcc);
>>   	}
>>
>>   	adev->sdma.supported_reset =
> 
> 
> 

