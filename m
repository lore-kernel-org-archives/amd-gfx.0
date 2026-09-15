Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCF2C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 12:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8678710E273;
	Tue, 15 Sep 2026 12:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EWwvHYUe";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E19F10E273
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 12:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=GgT6cUXhb+KxodtPpOsAlcQw5m8kwauQ0fGksMjELvU=; b=EWwvHYUeDLmxM3+HKgCoGWsIxD
 /rWUTJW+SNSCTEf0S/Pz+1IjfsbzBu//LLIJCmoweW/pbNxOInfuCPSpsQylyYdgpkbilm8yq703A
 JhEU7jlBt4qUmps6B0O3iijP6MnmMee/KqErfYip/oWVOUA5CPZwstwjUarfN4vKRNeWAfLH0BGx+
 N3cK4pz3D6L7iV4gbAXh/UovFW/xurLDs8KJLiM+vE/M10syzwyEr5inq9C0AfXEd5BzO0KRkTPox
 5+Fyn7RyvlxNm/EiitGKCvPlZiHuzv7DzI5O2OeyjUAJM+7FfRcMqdliF1rao9Ddkh9svdkJoMdEo
 zhxIxG/g==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x6SIP-002R3t-8i; Tue, 15 Sep 2026 14:29:57 +0200
Message-ID: <fbdd05fb-8d6f-42a2-b735-6c0ffe1ffeaa@igalia.com>
Date: Tue, 15 Sep 2026 13:29:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] A bit of SDMA (mostly) streamlining
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com
References: <20260914145426.51458-1-tvrtko.ursulin@igalia.com>
 <O1tQ1AQDQIeJjv8ajXx3UQ@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <O1tQ1AQDQIeJjv8ajXx3UQ@gmail.com>
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


On 15/09/2026 12:48, Timur Kristóf wrote:
> On 2026. szeptember 14., hétfő 16:54:20 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> Some old plus some new patches which mostly streamline the SDMA ring
>> emission, plus a little bit of GFX ring padding optimisation.
>>
>> More or less it is about replacing repeated runtime array walks (and
>> conditionals in general) with direct lookups for things which are invariant
>> at runtime.
>>
>> Smoke tested on Steam Deck only.
>>
>> Bloat-o-meter (from a debug build though):
>>
>> add/remove: 14/15 grow/shrink: 70/294 up/down: 53590/-196161 (-142571)
>> ...
>> Total: Before=10822624, After=10680053, chg -1.32%
>>
>> ---
>> v2/v3:
>>   - Tweaks per individual patch changelogs.
>>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
> 
> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> 
> The patches look good and make sense to me, but I can't test them right now.

Thank you! Looks like Alex will pull them in and then we will see if I 
broke anything.

Regards,

Tvrtko

> 
>>
>> Tvrtko Ursulin (6):
>>    drm/amdgpu: Add SDMA ring init helper
>>    drm/amdgpu: Add amdgpu_sdma_types.h header
>>    drm/amdgpu: Convert SDMA instance and index to direct lookup
>>    drm/amdgpu: Cache the SDMA CSA address
>>    drm/amdgpu: Extend logical to device instance lookup to all devices
>>    drm/amdgpu: Use memset32 for SDMA padding
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
>>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |   1 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        |  49 ++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h        |  21 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  17 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  26 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  67 +++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      | 162 ++++--------------
>>   .../gpu/drm/amd/amdgpu/amdgpu_sdma_types.h    | 161 +++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   1 +
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c      |   1 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   1 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   1 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   1 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   1 +
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   1 +
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   1 +
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   1 +
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      |   1 +
>>   drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   1 +
>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  25 ++-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  25 ++-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  31 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  39 ++---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  29 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  30 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  32 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  31 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |  34 ++--
>>   drivers/gpu/drm/amd/amdgpu/soc15_common.h     |   6 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   1 +
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |   1 +
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   1 +
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   1 +
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |   1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |   2 +
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |   1 +
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   1 +
>>   drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |   7 +-
>>   53 files changed, 435 insertions(+), 405 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
> 
> 
> 
> 

