Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70052FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 17:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D89D10E883;
	Mon, 27 Apr 2026 17:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZjGRZh5n";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FE810E87E
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 17:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDO+gYmQAEXeDq4LhwXGxf3RjQA1jQDHrCpbvhruPTWcHewKbvHWV9jLxTNINCFVQhJo3FHiK7Q4E+T2PnCZITuMB+dNjyccQHgmHNy00DQofUZwFY1GQODOZc0rpeG8D4bEjDJFwiW6BfzwMdEJsev4XqWJz85xWDvjbAVPP32Z2jlw55rnU8r4TVhww1cICZVxmmJJZnBrYNhTC41Lja8Ku2OZMcyQIcu7vg2SwaCk08LwE1q+p7BriE+zHL51G18cfGlQ16hO7ef94JuHDWrl5BJpOT5qTaK9MMK+QuQoVJLh/l4VGpPi7XCgVEeyXd3tZXUle7WXKwmauG/foA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doBuYpy8bfsO6mQ9sx4VORYE4CIko4LecnjmqiN+Dog=;
 b=zFHW6yg1sRnLjXed/XTMakTN6pHOylQSOGuuc8GPRUgcEtMG5ReSZnjedO1q+f6+8EKzJ1J348gsKH0Sp5JZymmzIsL4rJZRwHc9ZXryCFg6CY/+PmF0Id7YwQnUr6piNy0RLxV6mRHJtfrssdvsZdAfZmFOqKIw6CffBsX4AdVO+GgWDp8kiYDOEm+jb2DD8ExfpebmmY73tf0HPg4T12PVN50iRf7+EKpPeFu0VpbvpGSLGsgNcI9pb+74EiOP4YVL/038SDZdOlc36NENqWDa5I8ZoaGZQhJvACwkQm8B4R69qoHKisx51gpaGGFghl7mjPsaQsKXLeW6pT3Zvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doBuYpy8bfsO6mQ9sx4VORYE4CIko4LecnjmqiN+Dog=;
 b=ZjGRZh5nxieENdkvoXJmUVw+PMsXHQnrjypMhGWMK9II/F6pbeGQ+9GOrEN6nFkGQ+MK4iM2Vghpkp/5StnUAcqMsGuLAL53IpxcYxEUiHkxE0RAcWEDzVf1v/c1VP8qC5hnP9bLf1tYlEUXkE6+Ad2fbR9KGjwz0u5+eETr07A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 17:48:49 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 17:48:49 +0000
Message-ID: <a663fedf-0c41-4d4d-ab6a-f85c3d46a129@amd.com>
Date: Mon, 27 Apr 2026 13:48:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Make all TLB-flushes heavy-weight
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, christian.koenig@amd.com
References: <20260420155822.718805-1-felix.kuehling@amd.com>
 <f2f17b8e-ce73-4d96-b5df-29d235f9ffca@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <f2f17b8e-ce73-4d96-b5df-29d235f9ffca@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::41) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 062a71b6-d56f-437b-21e6-08dea4853caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 7rE9v4KLRxiSDE/w09WpEXCd4zKBpl2+js32iGrVeC1h/bMwdNodifYi+gmrQJ7bVIvaLB90LNsJzWhtBItAHrvscBtefMZw2gRC2AosQN0OXqDHqHrzg/3NuU4wqrBO2rh33WAykdiSUmDCEkaSVCchvOFtSFhTBiTAJ3YiUOXnLirigVbsiKdQCwAULrlnbmTTQz1vn0vMcQudFH0PExCqEZ2g8YbDzJU5KqWyZ92v86x1C9UIgsgHyMm/81y5UOGfdPpUT8o77pJ2VlYfA2yBS8T9oCOwQ5nEv8ctf5uBZOhWAp+nuAzpUMNwCc8A0UfAz6mJLWmyfBPUcan2fqnmys7K/evGrAHcPeTfOhu+qmJijqLkmxrqmwHHJYV6ODFr2kWg5F15ngSh8o0WU1GNoe7+PClW2pvcTF7F+LCPbe/aIyllpDWifm4KWvpRA3Tv+TtpjynwVRLbIS65jrr6iFHOVtGqWFRJXwVQfYA/0FHM3K9br7c2ZpZiowGIKGmiAcMdLkbA35TjoaEqdxYnppjV8poQMy+DqcBBnPgltDt/68Z5bsbQGPbkrPLpOF9TbJRh20JM4ktQjwWmicLJRAbQGovqVUeUfQWrFVqvLqJUG5FW0+GCAVswz8OOBob458BIiCwnm7KESNAOdC1EfLkffp7ejypdCZ76383iSN+bTs7BNkw8OCthvSeAINRrGJyxo824FlXhDzuXa66z/WtMndUNZdWjYF8wpqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2xONkpydEFFVTg2a0N1bGNRUWJreEU4Q2V3N3RRaWQrMGo1ZXl2bk9tQTNF?=
 =?utf-8?B?aFN2eiszNmFzVE91N09HYUkzM3FPRDYvY2drSWxMK1BRTTNpRGxUMFpNdXhj?=
 =?utf-8?B?UVB5SERRcmtKZFJTOWhJYWxOT2I0SGxDclNkZVNxT0JWWVBJWTFhODRSV0NF?=
 =?utf-8?B?anJhWC9hNTM3TTJmVXhxbzN2VmxqZzVNU0hUeTNpN3E2emJHWElHc3BwNTdp?=
 =?utf-8?B?ME5UTWFKdHE4WE1uU1FwVllyck9EM0oyNG1kN2twYjR6dnYxZ0NOSGNERmxU?=
 =?utf-8?B?TU02a3JsVG9lVExOUlJoeXdRM0Ztam0yUXBLcVNPRUF5NjA3bUNVR0orUVVH?=
 =?utf-8?B?azBLWmlteE80MHBjVVZ2ZWhLdmhFR29GSEtGSk45L1VYNUEwVnorSDU0cmNO?=
 =?utf-8?B?UXp3Vlc0OXNuejR5b0czSTFDZ3kvbldkV1c0UXVhc1h4YWRFa1RuNkhuNzJ6?=
 =?utf-8?B?MzBCdGJMZlFMWHNEcVREODdLOFZhUzRNUTRKSW9kRjFHbVRGcEswQ2FhNzFl?=
 =?utf-8?B?VzJCa29kc3pIQjcwMTkyYjd1UzZISWhwZk9IUFNDR2l4V3Vib0F6c1pGVVJR?=
 =?utf-8?B?bmpDaTZvWDNEb1NWYjJSOHk3ZFgvNmVySlViMjRuZ29mNnlja0QzamVsNHpU?=
 =?utf-8?B?YmxnY0FJcEFTczhiL01pUExHUHZHalZCZmxzYjRGSEw1aS83R2Q1ajZ0TlZ2?=
 =?utf-8?B?MXNYUHhIL0V6b2ViSzRhc21FNHZKdGxpaE8yTTRZQjd6Rld5c2pDQWhxb2Nk?=
 =?utf-8?B?WmhSVHZ2UEVwMlFZYzVPMnY1NFRqOEFVOXBNckcrVzBlYVRpdXhUMDJXQXFj?=
 =?utf-8?B?cFBNQm5FU3QwVXFPQ0IwdUVWYldFM3I5OHZxU2FvK255U2FrckFod0YyeERa?=
 =?utf-8?B?Y0pVQVBzV3VkR1FXR0YydVVjL2ZqUWhLZ3pxa1FtbmRBeE9kU3dwTDUyZFhv?=
 =?utf-8?B?d1JlRlhNZ3dvenp6T01kOHM5QkllRHJTRUwrREtVcHhFK0VxNGFtUHdJWllT?=
 =?utf-8?B?SldEYWF6NFR2RG9vdFhway9HODhqanRYTDN3YzNRTlVhN2FrcnV3KzhFNTFh?=
 =?utf-8?B?R2ZVZVc1bWFBUzVPOWJxbWZIQU1xcTd1eDE4UnlDbFhFQ0pvcktDc1pydS8v?=
 =?utf-8?B?ZkNJSXZ1ZWJYTXpyZHp6ME1XWmw5L1JlV29aVkY5bmtKaGhxSTZDNXdDeVpu?=
 =?utf-8?B?cExSdk9UK0xXKzNQRWwxcTlIanV0N2V5dWNlMTlraXR4TWsreUpiTXNkTTl4?=
 =?utf-8?B?aldUMldwY1NIWUtlL3ZULzh5aVZtZ3ovczhDdmpoNW1mYWV5ajVsR3FoZkJr?=
 =?utf-8?B?M3lNZlVSU1NzanZ0eG1sTG5WTEM0MFZIeDhMRzZMSkhzcUpLaThicHU3NXh5?=
 =?utf-8?B?b2FpekZlL1lQdmRyV2JWQjlqdWFhbjRrTmhrQVF2MFE5bWtQUXA5dnppUTYv?=
 =?utf-8?B?ZjI5YXVYWHFrQUFWdzRQejFWbURvRXRwdXlqSkM5YmpScU1jalM3WVliem8z?=
 =?utf-8?B?a3RjWXNKU01vcjdPMDRudlZuSlNCeTJUaTl3aHUzdSt2NG5rbS82L1B5SHdj?=
 =?utf-8?B?R29kdmdkK1hFbVlSZEkxOUMwQXkvTHNSc3pRbUJVRzA5a3dDMkJJTDBrbzBB?=
 =?utf-8?B?eEp4U0xYZm5EWmdSUy9na2NoLzFrVmhqN0tEMU41SHZXNWtVVmtDd3pLK0N6?=
 =?utf-8?B?bHA3WVFQTU1xL0RXbHhQbVhxaVBHSm9VZmxGcUZaK0padnM3SEhUeUx1eGVq?=
 =?utf-8?B?MHd1dlJKYXVnT1hCcFJqVW5pdWkvSERaOWtqbVVKL3gvZzBUSlZmQkJzdXY3?=
 =?utf-8?B?VE52YkJrRzJSSXc1WGpOK2swN2Nrcmk5Yms0d04zaStqTjBmVVpDenNxdkVk?=
 =?utf-8?B?bXBzUm5YWi9rd1hUTjd6Zkl5RGF5ME0wK0x6RUNhWmlFZ1lZazhITlFrR2M3?=
 =?utf-8?B?V3d2OGJGait6ZG5aY1BiLzRPVzhwRnBGQUNGOHVraFBhTGNKdG9vcHp4aWFH?=
 =?utf-8?B?bTBVSlZkaFFKZUdtQkZybDhKelppUzgwRnBRU0NWYkYwNE5hK0dVZnlyaTI4?=
 =?utf-8?B?Tisxd2F3QzNtZTRZeUNEczNHOVRLNFdBYktEQktSdlhhSHBZcVBWSU1mVEtr?=
 =?utf-8?B?OWdhak5DajEwTXBhbW50SGtUQWdTZkZ2cmtidEhHcXBnaU53eWZLbnZubFYv?=
 =?utf-8?B?YVVhMDNObENwOEhkTU9Yc0ExVnVSZlpRM2lYcGJ5dSt0T1NHWTlLMDErbXR3?=
 =?utf-8?B?ZDZ5K0FwL2lXdTBVVXlNRUt0Zkhvb1l4ZHFmU2NEOGZmUWNrd0cvVHF6SDYx?=
 =?utf-8?B?QXlqU1VYQXhyaTl5VjhMZ21UQ2M3ZDJwalZGL2xGUFVGUkM2MnNFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062a71b6-d56f-437b-21e6-08dea4853caa
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:48:49.6645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pf2zajQtBB58c+jV7+uOsLLJP0EQqOreIwO+pQ5cAubGIRHLCiTqXnO26SdGp2eIMRv9zgAZ6EypnobzffzIAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
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

On 2026-04-20 17:32, Philip Yang wrote:
>
>
> On 2026-04-20 11:58, Felix Kuehling wrote:
>> With only one sequence number we cannot track the need for legacy vs
>> heavy-weight flushes reliably. Always use heavy-weight.
>>
>> Signed-off-by: Felix Kuehling<felix.kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 4 ++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 6 +++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c                  | 4 ++--
>>   4 files changed, 10 insertions(+), 10 deletions(-)
> Probably change to heavy-weight flush in this path, other changes look 
> good to me.
>
> amdgpu_gem_va_update_vm()
>  {
>   ....
>           if (vm->is_compute_context) {
>             .....
>                                r = amdgpu_vm_flush_compute_tlb(adev, vm,
>                             TLB_FLUSH_LEGACY,
>                             xcc_mask);

This code doesn't exist on the amd-staging-drm-next branch that this 
patch is intended for. I'll need to make a separate patch for the DKMS 
branch that includes this one.

Can I get your R-b for this patch?

Thanks,
   Felix


> }
>
> Regards,
> Philip
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 16fb39259911..0625104a7693 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1358,7 +1358,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>>   		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
>>   		if (WARN_ON_ONCE(!peer_pdd))
>>   			continue;
>> -		kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
>> +		kfd_flush_tlb(peer_pdd);
>>   	}
>>   	kfree(devices_arr);
>>   
>> @@ -1453,7 +1453,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>   		if (WARN_ON_ONCE(!peer_pdd))
>>   			continue;
>>   		if (flush_tlb)
>> -			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>> +			kfd_flush_tlb(peer_pdd);
>>   
>>   		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
>>   		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index c1f668f12732..8d9bf4334090 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -595,7 +595,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>>   			qpd->vmid,
>>   			qpd->page_table_base);
>>   	/* invalidate the VM context after pasid and vmid mapping is set up */
>> -	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>> +	kfd_flush_tlb(qpd_to_pdd(qpd));
>>   
>>   	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
>>   		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->adev,
>> @@ -633,7 +633,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
>>   		if (flush_texture_cache_nocpsch(q->device, qpd))
>>   			dev_err(dev, "Failed to flush TC\n");
>>   
>> -	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>> +	kfd_flush_tlb(qpd_to_pdd(qpd));
>>   
>>   	/* Release the vmid mapping */
>>   	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
>> @@ -1307,7 +1307,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>>   				dqm->dev->adev,
>>   				qpd->vmid,
>>   				qpd->page_table_base);
>> -		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
>> +		kfd_flush_tlb(pdd);
>>   	}
>>   
>>   	/* Take a safe reference to the mm_struct, which may otherwise
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 53c26b1a25ca..dc8787dc399b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1559,13 +1559,13 @@ void kfd_signal_reset_event(struct kfd_node *dev);
>>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
>>   void kfd_signal_process_terminate_event(struct kfd_process *p);
>>   
>> -static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
>> -				 enum TLB_FLUSH_TYPE type)
>> +static inline void kfd_flush_tlb(struct kfd_process_device *pdd)
>>   {
>>   	struct amdgpu_device *adev = pdd->dev->adev;
>>   	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
>>   
>> -	amdgpu_vm_flush_compute_tlb(adev, vm, type, pdd->dev->xcc_mask);
>> +	amdgpu_vm_flush_compute_tlb(adev, vm, TLB_FLUSH_HEAVYWEIGHT,
>> +				    pdd->dev->xcc_mask);
>>   }
>>   
>>   static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 015eb61f3440..5090f8c15428 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1418,7 +1418,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>>   			if (r)
>>   				break;
>>   		}
>> -		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
>> +		kfd_flush_tlb(pdd);
>>   	}
>>   
>>   	return r;
>> @@ -1560,7 +1560,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>>   			}
>>   		}
>>   
>> -		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
>> +		kfd_flush_tlb(pdd);
>>   	}
>>   
>>   	return r;
>
