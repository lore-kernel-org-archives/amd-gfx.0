Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF59CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0C510E286;
	Tue,  4 Nov 2025 15:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="hYxeISys";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="wxlwU8rN";
	dkim-atps=neutral
X-Greylist: delayed 423 seconds by postgrey-1.36 at gabe;
 Tue, 04 Nov 2025 15:15:54 UTC
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6678910E286
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1762268918;
 bh=kupIRhPEunbv4SgJWeXvCIb
 8qjHbkxDWIWP3IxF/bUw=; b=hYxeISys792TgnrivbN5sjC3TuhtyY4WYaaDAVd+yepXw0ZsZv
 C4dUxboilO5OW6SAoyPDvXhxaAsTSJ43lkYBD/kiMVqSnmncruVoxgjdBAcAMk07V2LDXf74OuT
 cMCLPx9urIf9dZG9fwH2lwel1+jbSTLnnhi/zOrRDb323MHnlCMsT+sZuDOBF/WVfLoT7gDh+wH
 107XRCp00GuigpWaaocCpLziACP53cNH9O5ho7OyFdBpM7arMdAtcFQ17AXXsE64W+dJIM8PqJ1
 dck4scH3pnIvs8DPwIAWNqRJGPQ42oArhfwAKkApTh4YaMC9j0LsO/WV7PRY18nmhzA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1762268918; bh=kupIRhPEunbv4SgJWeXvCIb
 8qjHbkxDWIWP3IxF/bUw=; b=wxlwU8rNlkY3AUGPAlj1P+ibnw0EzS1CKMJhIEHFsFPv44Zizs
 gjRdqm+jyXeFk6NuFB0CyCX73D+ZxpMHQ3Ag==;
Message-ID: <237b5110-bf9b-452a-ab51-51ca67f7589d@damsy.net>
Date: Tue, 4 Nov 2025 16:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] drm/amdgpu/gmc: Don't hardcode GART page count
 before GTT
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-2-timur.kristof@gmail.com>
 <9b4daf2b-d97d-4b3d-bd7b-3b136a4e304c@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <9b4daf2b-d97d-4b3d-bd7b-3b136a4e304c@amd.com>
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



Le 04/11/2025 à 14:23, Christian König a écrit :
> 
> 
> On 11/3/25 23:23, Timur Kristóf wrote:
>> GART contains some pages in its address space that come before
>> the GTT and are used for BO copies.
>>
>> Instead of hardcoding the size of the GART space before GTT,
>> make it a field in the amdgpu_gmc struct. This allows us to map
>> more things in GART before GTT.
>>
>> Split this into a separate patch to make it easier to bisect,
>> in case there are any errors in the future.
>>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
>>   3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 97b562a79ea8..bf31bd022d6d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -325,6 +325,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>>   		break;
>>   	}
>>   
>> +	mc->num_gart_pages_before_gtt =
>> +		AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
>>   	mc->gart_start &= ~(four_gb - 1);
>>   	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>>   	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index 55097ca10738..568eed3eb557 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -266,6 +266,7 @@ struct amdgpu_gmc {
>>   	u64			fb_end;
>>   	unsigned		vram_width;
>>   	u64			real_vram_size;
>> +	u32			num_gart_pages_before_gtt;
>>   	int			vram_mtrr;
>>   	u64                     mc_mask;
>>   	const struct firmware   *fw;	/* MC firmware */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> index 0760e70402ec..4c2563a70c2b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> @@ -283,7 +283,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
>>   
>>   	ttm_resource_manager_init(man, &adev->mman.bdev, gtt_size);
>>   
>> -	start = AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
>> +	start = adev->gmc.num_gart_pages_before_gtt;
> 
> I would prefer that we have a single function which returns the number of GART pages we need before the dynamic GTT mapping.
> 
> But let me see how Pierre-Eric solved this first.
> 

The only conflicting change with my series is that I changed this:

-	start = AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
+	start = AMDGPU_GTT_MAX_TRANSFER_SIZE * reserved_windows;

So to account for Timur's change, I would only need to adapt this part:

+	mc->num_gart_pages_before_gtt =
+		AMDGPU_GTT_MAX_TRANSFER_SIZE * reserved_windows;

Regards,
Pierre-Eric


> Regards,
> Christian.
> 
>>   	size = (adev->gmc.gart_size >> PAGE_SHIFT) - start;
>>   	drm_mm_init(&mgr->mm, start, size);
>>   	spin_lock_init(&mgr->lock);
