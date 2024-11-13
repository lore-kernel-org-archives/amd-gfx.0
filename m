Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7611BD65C57
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 08:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F1E10E7AF;
	Thu, 14 Nov 2024 08:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fYYz3xjX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A15710E111
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IcT83MgkxzRrPL6gDhw5qJ31Igd7b2+O7TaC60v+Pq8=; b=fYYz3xjX3+gempGvZPWM6kBjIi
 oVMNx93RS+i85AkJ6IHQ2VoXO7OOSVKAQtbbY7BWb7/fYTOJQG7Hw64ScJ3bTNMUE+hsvFOpZsSkS
 rDP4uDEso/UUXOxijBwwTssqRH8F3DZwbqIVLtfMZsxkEqtqmZ9gtVktqNBtZLAxpSSpAH7QLx/qq
 RJoIUyqxwvDCZm2fpJZNnYHq2zfkSQvFKBQWOiujMbzoIpsXYv2BFwb4TY3L/CEW1MfrxImQTs/lV
 fxddcFfIYHDxdqKkMv2sxDSE5bogmZs8ZlzjkLfAgtTj9mn+aWelqqCanEFvHghTdUXLveo1Wj6GH
 hTA0KJHA==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tBHCL-006Q75-UU; Wed, 13 Nov 2024 18:30:33 +0100
Message-ID: <dd23e624-c8c5-41f4-b4b0-316351d8c8e4@igalia.com>
Date: Wed, 13 Nov 2024 17:30:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Matthew Auld <matthew.auld@intel.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
 <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
 <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
 <cc63f0ef-e152-49fc-90d9-ca695a8918f3@igalia.com>
 <eed6b35e-912a-4d7a-ac18-643d571f6e03@amd.com>
 <SA1PR12MB85999903EC92F7A1329D741CED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
 <76af3cc6-5535-47ca-9473-792f3e9c2d13@amd.com>
 <SA1PR12MB859954E2004C03CAAF764812ED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <SA1PR12MB859954E2004C03CAAF764812ED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Nov 2024 08:50:25 +0000
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


On 13/11/2024 17:01, Li, Yunxiang (Teddy) wrote:
> [Public]
> 
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, November 13, 2024 9:22
>> Am 13.11.24 um 14:53 schrieb Li, Yunxiang (Teddy):
>>> [Public]
>>>
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Wednesday, November 13, 2024 6:39 Am 13.11.24 um 11:25 schrieb
>>>> Tvrtko Ursulin:
>>>>> On 13/11/2024 08:49, Christian König wrote:
>>>>>> Am 12.11.24 um 19:16 schrieb Li, Yunxiang (Teddy):
>>>>>>> [SNIP]
>>>>>>>>> +   size = sign * amdgpu_bo_size(bo);
>>>>>>>>> +   res = bo->tbo.resource;
>>>>>>>>> +   type = res ? res->mem_type :
>>>>>>>>> amdgpu_bo_get_preferred_placement(bo);
>>>>>>>> Again, it's a clear NAK from my side to do stuff like that.
>>>>>>>>
>>>>>>>> When there isn't any backing store the BO should *not* be
>>>>>>>> accounted to anything.
>>>>>>> I don't have a preference either way, but I think it should be a
>>>>>>> separate discussion to properly define what drm-total- means.
>>>>> Total must show the total size of all BOs which exist even if they
>>>>> don't currently have a backing store. That's how drm-usage-stats.rst
>>>>> defines the field and that is how all the other drivers work.
>>>> In that case we should only look at the preferred placement and not
>>>> the backing store at all.
>>>>
>>>> But that makes the total identical to the requested value, doesn't it?
>>> Yes, the issue is not which BO needs to be counted but where they should be
>> counted. This gets more complicated if we consider BOs to prefer multiple
>> placements.
>>>
>>> IMO it makes sense to have drm-total- to work like the legacy amd-requested-
>> where we look at BO's preferred placement. For multiple preferred placements we
>> say that the implementation needs to pick one of them to avoid double counting, but
>> which one is up to the implementation as long as it's done in a consistent manner.
>> Does that sound reasonable?
>>
>> Yeah that works for me. Just don't look at both bo->preferred_placement and bo-
>>> tbo.resource because that will certainly be inconsistent in some use cases.
> 
> oof, from the commit message i915/xe is doing the exact opposite, BO gets counted in the totals for all the possible(preferred?) regions.

Which commit message? I was doing that early during i915 patch 
development but stopped in v2:

commit 968853033d8aa4dbb80fbafa6f5d9b6a0ea21272
Author: Tvrtko Ursulin <tursulin@ursulin.net>
Date:   Tue Nov 7 10:18:06 2023 +0000

     drm/i915: Implement fdinfo memory stats printing

     Use the newly added drm_print_memory_stats helper to show memory
     utilisation of our objects in drm/driver specific fdinfo output.

     To collect the stats we walk the per memory regions object lists
     and accumulate object size into the respective drm_memory_stats
     categories.

     v2:
      * Only account against the active region.

^^^ THIS ^^^

      * Use DMA_RESV_USAGE_BOOKKEEP when testing for active. (Tejas)

     v3:
      * Update commit text. (Aravind)
      * Update to use memory regions uabi names.

In code that would be here:

static void
obj_meminfo(struct drm_i915_gem_object *obj,
	    struct drm_memory_stats stats[INTEL_REGION_UNKNOWN])
{
	const enum intel_region_id id = obj->mm.region ?
					obj->mm.region->id : INTEL_REGION_SMEM;

So either active region or SMEM if no backing store. Maybe that should 
be improved too. Grr (to myself).

I don't see xe is counting total against all regions either, apart that 
maybe it has potential null ptr deref?

static void bo_meminfo(struct xe_bo *bo,
		       struct drm_memory_stats stats[TTM_NUM_MEM_TYPES])
{
	u64 sz = bo->size;
	u32 mem_type = bo->ttm.resource->mem_type;

Or is bo->ttm.resource always present in xe? Adding Matt according to 
git blame.

Regards,

Tvrtko

> 
> Teddy
