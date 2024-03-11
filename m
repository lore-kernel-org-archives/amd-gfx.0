Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A42FC5475B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 14:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C2710E29A;
	Mon, 11 Mar 2024 14:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BX2m8aK3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FDD10E29A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 14:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXLck0c+e6qeZCxWNPgmSHTvvV8N8ClF423mX6KbdxfAKKKruiHhzsFW/Ny0OgC1a4V5H9V7ju13aT7GpVMEU+I6fOjQ3I23iwKwfujL3tGEpROWE9aTniSa8iP0EYgTq5ys1GFT4q0foHaDxuohd8kyhg1J7joCo4e+PyAT1Fo5Tf5r65lu08BVCjHTqeh5AWuhYCwrlHXpr6dy3PaS+qDSzmPi1vexiZW0IFDDIyvu7f7ewXPHIS09dYJcsXwrUhZaS0CS1BzxLjiPo/50X0HwH3xD6GXQP+2H5H7CUee7dYAUFLwAjwC0WsjvZ5Jtji3GaCTHTHvBeiVuUmk9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLucYArPmYv1RWt9hI5UlzjyJmHCWui/iYfhDNkvPpo=;
 b=UBeSXx0X2BK1nbDkp66Wpnw874I2FWpvxS8KsiLS6njM0koXN9OT4hbdtNK9Tks2sd4W11KaVLCVhy2WCjI2bn5Zpx2o5VZhXKPps5i+G5bNpw2UJ65MXkriSKBh9yCBtnLFkPaMnAXzdJbv/QB2KmpN5pcolrwskxIbl7eaI2u/cWOxfr4/zP7tTbZJqPCxhIuRjKepSaNam38dohoIEwKWGp7BNWvHx0hGViwdZNcEmvtHN+Ax/6sO8aSFqR5rQE3Nie0kZsZed4X/fuJvVjfg88ZJJHWTgG3HlX7u9FTCk6Zq8lb5sk4cxPX/yTBNsjIjUL/GgAZEeXB+m05iMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLucYArPmYv1RWt9hI5UlzjyJmHCWui/iYfhDNkvPpo=;
 b=BX2m8aK3TsOjbCGNWMvUKvQSKoJqgLYC6zY/vFLt/tivFrbeSXTlZ1V8B/zCX8f6SpPvbtbGK8Oemlp0OstPbeu64Sl0b8NQFd8ys7IcDjNPHdp8ubz+caWtQJF7CRbte1Mr8wMjji3Yqn+xbRVmiM98+jjyuOUBuH/njh6OqSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 14:37:31 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 14:37:30 +0000
Message-ID: <98f72106-e62e-ef02-ff9b-d92edeb6950d@amd.com>
Date: Mon, 11 Mar 2024 15:37:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240306144115.1007-1-shashank.sharma@amd.com>
 <939a8f23-952f-8993-9c1c-178bb0fd42b5@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <939a8f23-952f-8993-9c1c-178bb0fd42b5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0c7062-814b-4435-deb8-08dc41d8c80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28RpkQwp7wfytkvjZsU/5qXmkNu/Qbdo3pGz6fPcK4mT/3f4yLXLF9tWgb3sW630RERk0qc+LoIrAENIzBjoTbSqG6GbbHvD23gwvE5KtdtuvfneAk7aSFNeVtwO55YmMSk4J/pIC1dxI08UGoiPZYcXouvnVYPvCmj1IEnaPvRhloyqVL+mMpFUuHwHQDe5aheu6hJ8S+63jkhI9LlZemCPTWZ2nLgThyJKHZZqJlkHwv1uAIQelB5JTCCG4jfZyv+Kgiwe9NSlgjCdB4TYRp7bmTE66zhgZQFX4vx3+7cBBVHVx18BYG6WuECq9ggtW5JgjwOcbeZIHViSZrAMEwpGwc2GI+dUm9RQqrM/9bS26ZfBccxR2Vtoq+aNJKoEQNtIF1Jy26eboCRbgTj47XU/sE+MSDmBHSaqMRCjPYWmf7bmc6OJxpPfAe8cbeFyNw/oXX105zQWhvZZdjfI/Es9egPz2DypqMLa5dPtcxm6QkBF7Lzk1x/T1kyemm01hQtXVaeyyncBZJZKOk+gO2H3IUn+pOEZVrm04MaXc85iROk+O+yWeQ11rGOkQ8XNBpdx6E2kmQ3S8cioz2OoBQxic1vhBD0po4bFpzXVGUiUYVqFYhNRXRLRh9FwfLBu+fioewC1OyAZvfM5SmRmRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWxUVVR2OVoyWXYvMmt1eTBSSFd2ZUxzNG9vUWF0T0g5TncyZHZnWm1MMUhi?=
 =?utf-8?B?YU1JSzRWS3pzRVFxQks0RFdqL3BUcGswWXpqUjBKSDVpbzFXWFkxeEdmcUU2?=
 =?utf-8?B?TmJ6WEpFck1NOXVoNXNMc3NScWtHY1FJSHZpblV6QlNqc0ZuUE4xV1RyVkd6?=
 =?utf-8?B?amErci9Wb25qMUFMN1V3eDFpUVRHemRiYTRpUVNsMnVvV1kyQ3BwZnZrVWp3?=
 =?utf-8?B?UHN5STBkQ1ZZYjk4aUhrdjAxUCs5TVFuVlZBN0dMKzlCa3FkN0U0ZDNaVC9w?=
 =?utf-8?B?azFtK1RZUHowWTgwZS9lZmlQdkRZWHdEZisxTDI3Uko3WUM0QXhYWHFtTm95?=
 =?utf-8?B?TjVNd1liU1ZtMTkyRzhWS0ROdi8xekMyVVZsbzJtSEV4eWE4TEsvdzhZM1BB?=
 =?utf-8?B?MXp2OS9tNGwveW95L010cUxuODhvbTRPN2NXWXhrL2RqM0xnQm1pMXhKUUN5?=
 =?utf-8?B?OEo4MEFEWHhJc1VkNnJrUVNvL1ZzMHhxeUo2a1VDY2s5MXJVWUxKZUd2Z0Yr?=
 =?utf-8?B?TGJ5b2FoQVg4c3ljaUdYSFIzSWIrdlQ5U1dKeE1YTktFK1FUYnJCTXRUUDQr?=
 =?utf-8?B?UVJiaStaaE9pUWMzeW1pZkU4UmIwaUZoakx4eXh1SS9pdUxsWHo5SE5EWkR1?=
 =?utf-8?B?N2d0L2M0MnVkaGp4M0RCN0djcGlMWFl5RmJueGpzeUl2N1VuZnpmY2ZWYWl3?=
 =?utf-8?B?akVmV0wvU0RFeisva1VEZU9sZXhTb2pTR0NrRW9JM0owZ0hIRmVZc2tMcVZW?=
 =?utf-8?B?cW01eW9iUDg3YTU4TmlMWmlDeTYwUW9RemtsSUtnSnQxU1dyV0VvR1oycFNY?=
 =?utf-8?B?STh1clFUNUhUTVlaeCtqdGsvYlBTbmcyTDlXNTV4WFdEcWdZTllUMkh4MWtI?=
 =?utf-8?B?YmE4VjluMndEOFJNMTkvaGRlTGhOTUc4NUF3SEJjVTBueHYrcnZXNmZnOEc4?=
 =?utf-8?B?T2hoZzFVTERYZDNtKy9jeVI3R2l1QW51RmlwWFhBSWxaS3ZLMWJwaG5nK0JV?=
 =?utf-8?B?RkcybVRXZVBhOXE0dS9CbVF3OEJmN1FtRnhSRnNaWnRSWFprYm5qVHZ4SURM?=
 =?utf-8?B?djJDTkdCdUpvcitNdWVwWDlTdU1ra3RWL09pNTVyR1ZLMnlTRWhkSXBIU1JN?=
 =?utf-8?B?OHg0bUpJQ2VibHpHQ2tlRGh0SFhFb1lpTjdNeTVEQmdYQWc0clAwU0R0NjNa?=
 =?utf-8?B?WjBIUWQ5UDNlSUJGWS8wSmsxZkpHelZGQ1BMeFVjcXdib040bEpkRTR3N2kv?=
 =?utf-8?B?N3JZYzcyYm1CUUdqV0FiejBWbFJzQkEzR2Q2T0xQeERIYzgvc1ZhbEkvbjV3?=
 =?utf-8?B?SlNHV1NwNlFFZTB0djJLUTMxSEFSa3VqSktmV2tpekt6L3JuajNMdkRVRGJM?=
 =?utf-8?B?UVVmZ1RGMlFjSlAyZ2ZFdzNPcXkyRzVzMm5JaG5xd2RwelhjVjVJT3dEdCty?=
 =?utf-8?B?ZnBSNFF2ZVh4YjhtdVNGNkx4TkVjRjAzUzBLcWdFSStZUzRrMmlTejRaZHp3?=
 =?utf-8?B?Vnd5MitibytkbTFIekYvMFVnUURlOS81aWgrM3piSmNXc2FzNG0rN1M1UVR5?=
 =?utf-8?B?djFCbVZJLzFWZzY1cTVMQmtncCtXT3BraGpJanNaYlVHNEs3c1B2cEM0enBw?=
 =?utf-8?B?UHA2aGZEZy90d01nMCtzUTR2b3pJOGFBTVRselg1bUdnZE9xYWtOUXpCdlVM?=
 =?utf-8?B?NnVQYndma0VKcjhFOFY1SGltcy9hZTNjTksyeEVUbWVBSEdnSmt5Rjgralp4?=
 =?utf-8?B?M29xZXZaSDNnaXRqaGdta2g4Zk4rcXBoZTFTeUNjSGdXUFk5eHVDK1hXOGV4?=
 =?utf-8?B?ZFFxVUFlMmhoK0xUcEZIUEZuWlBLYVJIZk9HQXhKRGhkS3pTR1lzUlRyK0lp?=
 =?utf-8?B?VkN1WEZwUEdxOU9FeUpmOWt5Sk5NSjBaMWJPMTZwcTFMZFhNU1BkTXg2QlVo?=
 =?utf-8?B?K0hTMTBMZ2dZNWYvYkN4eDdFYU5lNmVpVk9nMGwveVFQOVFCUnBra2QrY1NE?=
 =?utf-8?B?NjZiME9WZWtEUlRHNzdNRzdjVnJMd1ZGWndxM3FEY3puOUErVzNDR2VPVEh5?=
 =?utf-8?B?NmY0N2ppdFhmREIwSzRHZUI5Tld2eWl3MFJSZGlUditGWXE0OGtKVUY1dERH?=
 =?utf-8?Q?FhKmdZLeFELSuC3I5nRPmv8y2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0c7062-814b-4435-deb8-08dc41d8c80f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:37:30.8487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 298whBlB86y8OwZdSoMFs4rQMAi7+MjIo7apvA8cTDFMy9h09Gd4vBJrM28hJXr1wYIZ8GV9KahykKghCARW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
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


On 07/03/2024 20:22, Philip Yang wrote:
>
>
> On 2024-03-06 09:41, Shashank Sharma wrote:
>> From: Christian König<christian.koenig@amd.com>
>>
>> The problem is that when (for example) 4k pages are replaced
>> with a single 2M page we need to wait for change to be flushed
>> out by invalidating the TLB before the PT can be freed.
>>
>> Solve this by moving the TLB flush into a DMA-fence object which
>> can be used to delay the freeing of the PT BOs until it is signaled.
>>
>> V2: (Shashank)
>>      - rebase
>>      - set dma_fence_error only in case of error
>>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>>      - use vm->pasid when f is NULL (Mukul)
>>
>> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>>      - move the misplaced fence_create call to the end (Philip)
>>
>> V5: - free the f->dependency properly (Christian)
>>
>> Cc: Christian Koenig<christian.koenig@amd.com>
>> Cc: Felix Kuehling<Felix.Kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj<rajneesh.bhardwaj@amd.com>
>> Cc: Alex Deucher<alexander.deucher@amd.com>
>> Reviewed-by: Shashank Sharma<shashank.sharma@amd.com>
>> Signed-off-by: Christian König<christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
>>   4 files changed, 128 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index fa26a4e3a99d..91ab4cf29b5b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>>   	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>>   	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>   	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>> -	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
>> +	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
>> +	amdgpu_ib.o amdgpu_pll.o \
>>   	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>   	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
>>   	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 0960e0a665d3..310aae6fb49b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -988,6 +988,15 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   
>>   	r = vm->update_funcs->commit(&params, fence);
>>   
>> +	/* Prepare a TLB flush fence to be attached to PTs */
>> +	if (!unlocked && params.needs_flush && vm->is_compute_context) {
>> +		amdgpu_vm_tlb_fence_create(adev, vm, fence);
>> +
>> +		/* Makes sure no PD/PT is freed before the flush */
>> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>> +				   DMA_RESV_USAGE_BOOKKEEP);
>> +	}
>> +
>>   error_unlock:
>>   	amdgpu_vm_eviction_unlock(vm);
>>   	drm_dev_exit(idx);
>> @@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   
>>   	mutex_init(&vm->eviction_lock);
>>   	vm->evicting = false;
>> +	vm->tlb_fence_context = dma_fence_context_alloc(1);
>>   
>>   	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>>   				false, &root, xcp_id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 64b3f69efa57..298f604b8e5f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -341,6 +341,7 @@ struct amdgpu_vm {
>>   	atomic64_t		tlb_seq;
>>   	uint64_t		tlb_seq_va;
>>   	uint64_t		*tlb_seq_cpu_addr;
>> +	uint64_t		tlb_fence_context;
>>   
>>   	atomic64_t		kfd_last_flushed_seq;
>>   
>> @@ -594,5 +595,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>>   				  uint64_t addr,
>>   				  uint32_t status,
>>   				  unsigned int vmhub);
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>> +				 struct amdgpu_vm *vm,
>> +				 struct dma_fence **fence);
>>   
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> new file mode 100644
>> index 000000000000..51cddfa3f1e8
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include <linux/dma-fence.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_gmc.h"
>> +
>> +struct amdgpu_tlb_fence {
>> +	struct dma_fence	base;
>> +	struct amdgpu_device	*adev;
>> +	struct dma_fence	*dependency;
>> +	struct work_struct	work;
>> +	spinlock_t		lock;
>> +	uint16_t		pasid;
>> +
>> +};
>> +
>> +static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
>> +{
>> +	return "amdgpu tlb fence";
>> +}
>> +
>> +static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
>> +{
>> +	return "amdgpu tlb timeline";
>> +}
>> +
>> +static void amdgpu_tlb_fence_work(struct work_struct *work)
>> +{
>> +	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
>> +	int r;
>> +
>> +	if (f->dependency) {
>> +		dma_fence_wait(f->dependency, false);
>> +		dma_fence_put(f->dependency);
>> +		f->dependency = NULL;
>> +	}
>> +
>> +	r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
>
> To flush all XCCs, as this is a corner case, we could start with this 
> to make it correct for SPX mode for now, with extra flush for other modes.
>
>     int num_xcc = f->adev->gfx.xcc_mask ? 
> NUM_XCC(f->adev->gfx.xcc_mask) : 1;
>     uint32_t xcc_mask = GENMASK(num_xcc - 1, 0);
>     int i;
>
>     for_each_inst(i, xcc_mask)
>          r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 
> TLB_FLUSH_LEGACY, true, i);

Thanks for this input, Philip.

@Christian, your feedback for this ?

- Shashank

>
> Regards,
> Philip
>> +	if (r) {
>> +		dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
>> +			f->pasid);
>> +		dma_fence_set_error(&f->base, r);
>> +	}
>> +
>> +	dma_fence_signal(&f->base);
>> +	dma_fence_put(&f->base);
>> +}
>> +
>> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>> +	.use_64bit_seqno = true,
>> +	.get_driver_name = amdgpu_tlb_fence_get_driver_name,
>> +	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>> +};
>> +
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +				struct dma_fence **fence)
>> +{
>> +	struct amdgpu_tlb_fence *f;
>> +
>> +	f = kmalloc(sizeof(*f), GFP_KERNEL);
>> +	if (!f) {
>> +		/*
>> +		 * We can't fail since the PDEs and PTEs are already updated, so
>> +		 * just block for the dependency and execute the TLB flush
>> +		 */
>> +		if (*fence)
>> +			dma_fence_wait(*fence, false);
>> +
>> +		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>> +		*fence = dma_fence_get_stub();
>> +		return;
>> +	}
>> +
>> +	f->adev = adev;
>> +	f->dependency = *fence;
>> +	f->pasid = vm->pasid;
>> +	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>> +	spin_lock_init(&f->lock);
>> +
>> +	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
>> +		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>> +
>> +	/* TODO: We probably need a separate wq here */
>> +	dma_fence_get(&f->base);
>> +	schedule_work(&f->work);
>> +
>> +	*fence = &f->base;
>> +}
