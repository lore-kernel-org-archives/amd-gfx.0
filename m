Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228AEF364C2
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 21:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8171810E870;
	Thu,  9 Apr 2026 21:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3vP7z6wx";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BF710E08B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 21:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVX3FH1aMEG55bA34O9pYXzxqthZGYauGlfyfjHvhAHeMwyBkc8vNiwCSVrc1e9flei6sJNv/kZvqJXF2PU2iLWC9Auv1ycMN1XPVT5MpedfvsCGq3Hx5BZVHin92dlaXp5/QYViAyXKoUTdLfeFgnDc9876knwlEJi3Re9inIsosZIJT/J4pzdhL9e7oRCk8m+RPMfZntdlci6g3Pq5cBWTvMCQ0a9PbAmeZC/jz7QeEoU8ORrCb5HQubZkpAtYfCkXVilQ3M8DSEqPAMVYELNvcsw22hT0IRiE1ewTHjejzIBEAmQf9+zuR4qKDhiaANf4Vv1mszGh9AWiQGLL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+LSFhrqF+iw+e/KD2uoRuChTsxloUpxyeKEB2ijqB8=;
 b=KeRkp5GoQDM2ZEU22m399ylUqCGdWokT8tBA0jd8MWwN/GNVhLw+5h7qoPk7MPzoHufZefNzRM4hOlDJhaAW740aYXE384geR945ihrLAeWnoJQm0ztLx+0JeLavAjobDCdcAsRRmxDBwnJgoixtYwWsYqnsM1OlCvZBwhytAVjHE+iTtAvqnKS0Pp7jnWq41Cj0DIC3IWKFOiZaLVmImF58ylBamHOnUWQu236rtkLvFTvc1tC8PgEH0np/dutterFFX2UZ/wxd2PNBuw+SFSb6wTadup6tHnTT9KA9yo+EoKZlag9ytIwOWN5g/yhgaXvtVlEG7O9/X3YnUwdz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+LSFhrqF+iw+e/KD2uoRuChTsxloUpxyeKEB2ijqB8=;
 b=3vP7z6wxkKuPqVLLKh2XhS8q/fVGZ9HyS7l7wNuYe+gDJjA29ks9XTnxAcowZNNqi11HN1qvtLuCaaJc7+GEmi8zszAGCWLxPyHzz56UTajCC71FiG8YhTsURUXVXPZFk8aX6VYgvAzmPUMRCKXYAlh4kGUNppzqh+IogXSIxY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BN7PPF7F4CD71A4.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 21:56:51 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 21:56:51 +0000
Content-Type: multipart/alternative;
 boundary="------------OTeENLc0Cr40Ov4JCd7SbBna"
Message-ID: <8ab95e17-11bf-4ea1-b408-c740c6cefc88@amd.com>
Date: Thu, 9 Apr 2026 17:56:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: extend mtype override to non-contiguous pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Chen, Xiaogang" <xiaogang.chen@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260407133833.463741-1-Philip.Yang@amd.com>
 <55d2743f-9585-4e79-a153-b403a9781aa4@amd.com>
 <4966b8f2-4d51-405c-beae-889771c298b5@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <4966b8f2-4d51-405c-beae-889771c298b5@amd.com>
X-ClientProxiedBy: YQZPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BN7PPF7F4CD71A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 00dd88b7-5c46-499c-82d5-08de9682e7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: wU7jkK6LGepVWgNx3BXiZdMImzjGK8xsm/QYFMqG2dok77fDbcfK+ZIJy+VbNbVeQasUym7w1VOahYSfdukLQWMYc3MEOUe3UpsMZH6GM4+XMZ1Zszki934PCwPM3oAv6eCYjPpJP15j6/zAWSCU/D2uOYoFWmhoVDsobySNDMUoSXNEb186n5DW475bP1Y4XEYqrLKLVy3/97sxTOdpcezKHrfJxvC3G14Kw+FJt5s6bY5W3itJI/RnunGRgOIsVJWM7Pk2AAv9VyBrcBWDJBdLiqS+p17rdM3qwVqWQUxS45LBaLxxdeP0HslHReQNO/B6JPYhF9wJ6lmDLzk9i00OwQar8T+Ic0PQtylKAIQ+OhuRMHKVW7dIaTAKwAtRy9uxq5eV/ribLImWUg61Cus/geRU2hhEqC/S9NSSqup8rqu2g96pF767civJk+otK29UW6jh+ObceURSF1JML5tQTz51FhqN+n0FynJpHcGgkFW25Ym8/QINd2yOWce/tuz4btIdGV0VrQN8WM1cUK875gjfgXXiaan9fAH2sFkbcfuEKbHWDTPRJBeBjl43SuUTzyZdkocr3y1Vejp6lXV2osQh3M/2l0ZV2xjq0tg5JT/81d5zds4yBxEU76wlISxUAfYxmhfkNjA1uDxbeT79UNzlJusHjG/lu6FdJU92aspqovduYE0RHmw19iVMgaTolIFN0pdUwC1wiPAmXihXWYWws5yQxTJU7CDqOjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blJINWVoSVBDUWRhL2l6NXl4TXVWSms2cVdCaSswUnpUQU0xVlpIS3pTZlYy?=
 =?utf-8?B?ajErRUxYcnZJdUd5UTlNV2ptcS9EaWRTdEtyNGFTbmRoQ0c2T212a0JzUGlP?=
 =?utf-8?B?MXNMSXRCTzJ5dzQwU2dtSG9rTWhDV0M2NlpiVUFQcklibFl2dmZxV21VdEI5?=
 =?utf-8?B?cnVGaFR4YW1RVUZweFN2TjE0Nno4cm1KSmo5Q2RseVVzRTIyRmdPSEtNZmwr?=
 =?utf-8?B?UFk4UWNCVWpld1hNbTdqaEJRZ0xNcmFsR3pCbGlvRVM3NjF5ZGxUZlVkZ29t?=
 =?utf-8?B?ZitKWjFLYTVwMCtYTXNsWkVWUi9mVXlwREpnSk93cDFhTEsyS1h0MXVOUEw2?=
 =?utf-8?B?UlRPd3FBcCtBMmxjNUwwSkFGWlIwVi9jWUZlSlNQU29WWTRNVC81Q3V1ZFlq?=
 =?utf-8?B?WDlERGJOOFg5d2RoR1JEeVptWnpxNndCR0JzVDh0Z2NzNlAxL2t3Qm9XYVd6?=
 =?utf-8?B?cU03QWxXV1pqeFhmdG14cG42WmhrOUNhY011dlN2YjJoaEorOGloeVduRUpM?=
 =?utf-8?B?YVExME14SXZoYWtkME5iTXRDUjY5Z3QyY1JOYUYwMXdIQS9SdDVMekVWVjhP?=
 =?utf-8?B?L1B0UjkvcXJSUElYcGUyTVBPTHZIZTBiUXExZzRwZnZOVE9kOUF4blh1WnBz?=
 =?utf-8?B?dXBhUGs1dlZWQ0g4VUphUFdjeStSb3JFZThPNDN4R2dnV3psOXcrelJONFJv?=
 =?utf-8?B?R1Z4L05MNFM2eXk0K09HVVY4Vy9VWGVtbFBpUVd4amlLOXBTcXo4KzRBRW5p?=
 =?utf-8?B?THBhWFA0b1p5eStPYnFYWGFYekVaNXZNVTZxSTB5SE91S2VsWXdjWUVPLzdi?=
 =?utf-8?B?UmhmamZnaCtoZng5TDZ6WXVEeDFVSkhMVnUwVGtQdkw3N1BqUllDaWVoWW91?=
 =?utf-8?B?OUxMb1Q5V05qaVRRdmZuZ2xVcDJ5dXQ2QTNLNVhIUGtQL0I0YVIzWWx2dWlw?=
 =?utf-8?B?SExnQkdVa1o1T3pzQmJJZEJuUFVtZkVKcVlpNURJejZscE1vSFFjYVlKUmRQ?=
 =?utf-8?B?ZlczNFhQRmJpR0JRV0piZm9KUUdFdDRHWFdOeXBJWWZmeTBRQTFoUWdiWnUx?=
 =?utf-8?B?bHhsR2EvdHRFWGFtQXd5NzVCaUJpMGJyU3pDRGRMZXQxOVdYV0ZxTmYyU0tM?=
 =?utf-8?B?dWpjeDdFeVZVNUZMemFzNVlNb2RDSzYvVXk3VkdCL0RmaGhsOXJBYjFCUEpV?=
 =?utf-8?B?TUxNTjYxaUc0a1RSMWNuOHhuY3FOcC9RVFRvRnRWUGtKWUgyV1FuQnFIRHhP?=
 =?utf-8?B?Nmw0KzFxTE1vSzlYRGtQNFR6bElhc253R3hBQVpaSHdZTThmbGlVd3dwRGlC?=
 =?utf-8?B?WXhnWktXbVVwZ2I0U1hOWmFWU0d4NjBxS2V0SVZrdGd2Y2MwZ1NoZFVvZWJ2?=
 =?utf-8?B?RjBueTNoTnlpbnRvRUpwTmxMY3UxYkVLUHI0K05zeVdFTTFzWEgxUjRVTDYx?=
 =?utf-8?B?VjZIaGdRenFYbzMrTWcvZmJsZEllU2Foc2tMMFNORmd5bk91aVQ2R1BTMU55?=
 =?utf-8?B?RnovYkExUTE1MXU3VUdmcDV1eDQzcHVDVTNEbktZSWZXdlZVYnJVMDBHczRE?=
 =?utf-8?B?RzRJdkJ5YWhTTUdSdUoyYkFscFozOUpIeHJCNmh2WElTOHhESUFDLzdyei9V?=
 =?utf-8?B?a2pyLytlaktJdEdYVE9SeStSRHpkVkVXV2taUzhodG5PZWxPVTEvbFZFNWRD?=
 =?utf-8?B?U1cwM2hweDdWK2FZdXhBbUk2blZRWnYyb2k2VXQwRU5Qbzhpa0F0WlF4aUlB?=
 =?utf-8?B?Z1pkZUR4bzF0Y1dUN2RUcWsweEh3azliRm4vS3UvT3lYN0lraTdPQ1BmK0h0?=
 =?utf-8?B?Y213RGd6ZDlBSVU0bGhjV041ZitCelU0RjJpdkZ3V1VHejFIUVlTU2c1Yktk?=
 =?utf-8?B?L3dMd3JpNlJ3ZE9kVnc2dkZuUUNlaTRaazl6elJKRzMvckIzdmJsSEt0cUJE?=
 =?utf-8?B?ZzQvRjkxRW5pNjBwL1RyY2dFMjM1QWNlRG0wYlIrcHN5eHBGY2p6STF1VExi?=
 =?utf-8?B?S2FSZW9IUFowUytYRUtJRDJOZW5XVXBuZ0s5cWlKNkM1UVNrV0ZPczVBYXVs?=
 =?utf-8?B?TEEyMlFGSjhxRjExNkhkcDRTaG1wcE1sdFBPT0pvbG5ocTg0WlppNXExN3dq?=
 =?utf-8?B?OGQ4N0RqRTBIY1ZKbElUYndsanl6L1pHdHJaTW5md1FMZlhTYTBOTlhpK3Ax?=
 =?utf-8?B?dlEvRURsM0xiRDlKUlRpRlJJeHhlcGtqQjdsVEs2ZlVCS3hGdWNtVlZ3dnFQ?=
 =?utf-8?B?QWJ5M0tieTB0L3crSnVHMldRbHFDTXBFd2xZamtRdUlmblNzbHFOL0VyUkhx?=
 =?utf-8?Q?2pBt5GirOsfQXOXA9r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dd88b7-5c46-499c-82d5-08de9682e7e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 21:56:51.7096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TKqYKEb4JOXtOfwYwMEYesq9H86s/Xyp7YYVvzpwZIHlYSn1dInPuFM0I+ZJKfu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4
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

--------------OTeENLc0Cr40Ov4JCd7SbBna
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-04-08 04:04, Christian König wrote:
> On 4/7/26 21:40, Chen, Xiaogang wrote:
>> On 4/7/2026 8:38 AM, Philip Yang wrote:
>>> On multi-socket MI300A APU systems, system memory pages mapped to the
>>> closest GPU must use MTYPE_RW instead of MTYPE_NC to maintain correct
>>> cache coherence. The existing mtype override in amdgpu_vm_pte_update_flags()
>>> excluded non-contiguous page mappings from the override. This caused
>>> incorrect MTYPE_NC for scattered local pages, leading to cache coherence
>>> issues.
>>>
>>> The override applies to both contiguous and non-contiguous mappings.
>>> When pages_addr is set, resolve the physical address via
>>> pages_addr[addr >> PAGE_SHIFT] before passing it to the override
>>> callback for NUMA node lookup.
>>>
>>> Introduce amdgpu_vm_addr_contiguous() helper that, on MI300A, treats
>>> pages on different NUMA nodes as non-contiguous even if their DMA
>>> addresses are adjacent. This ensures amdgpu_vm_update_range() splits
>>> page table updates at NUMA node boundaries so each batch gets the
>>> correct mtype override.
>>>
>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
>>>   2 files changed, 50 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 63156289ae7f..f8fcbf079bf4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>>   	}
>>>   }
>>>   
>>> +/**
>>> + * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @addr: current DMA address
>>> + * @addr_next: next DMA address to check against
>>> + * @contiguous: current contiguity state of the range being built
>>> + *
>>> + * Check whether @addr and @addr_next are physically contiguous. On APU
>>> + * platforms with multiple NUMA nodes (e.g. MI300A), a NUMA node boundary
>>> + * also breaks contiguity so that each contiguous batch stays within a
>>> + * single NUMA node for correct MTYPE override selection.
>>> + *
>>> + * Returns:
>>> + * true if @addr_next continues the current contiguous range, false otherwise.
>>> + */
>> We can use pfn_to_nid or page_to_nid to get which noma(id) the backing memory is at. pfn_to_nid uses pfn from physical address. You use dma_addr_t that is device dependent. It is not always same as physical address of RAM.
> Yeah that here won't work at all.
>
>> ttm_tt also has
>>
>> /** @pages: Array of pages backing the data. */ struct page **pages;
>>
>> I think using the pages to get numa id by page_to_nid is more appropriate.
> That array isn't filled in for imported pages.
>
> As far as I can see the whole approach won't work reliable. For imports we only know the dma_addr and not the struct page nor the pfn.
if adev->ram_is_direct_mapped, then dma_addr equals to pfn, we can use 
dma_addr to call pfn_to_nid.
I will add ram_is_direct_mapped condition, this is currently inside 
override function, and add fast path change suggested by Felix in next 
version.

Regards,
Philip
>
> I think we need to re-iterate the whole idea of MTYPE override.
>
> Regards,
> Christian.
>
>> Regards
>>
>> Xiaogang
>>
>>> +static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
>>> +					     dma_addr_t addr_next, bool contiguous)
>>> +{
>>> +	if (!adev->gmc.is_app_apu || !page_is_ram(addr >> PAGE_SHIFT))
>>> +		return (addr + PAGE_SIZE) == addr_next;
>>> +
>>> +	if (pfn_to_nid(addr >> PAGE_SHIFT) != pfn_to_nid(addr_next >> PAGE_SHIFT))
>>> +		return !contiguous;
>>> +
>>> +	return (addr + PAGE_SIZE) == addr_next;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_vm_update_range - update a range in the vm page table
>>>    *
>>> @@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>   				uint64_t pfn = cursor.start >> PAGE_SHIFT;
>>>   				uint64_t count;
>>>   
>>> -				contiguous = pages_addr[pfn + 1] ==
>>> -					pages_addr[pfn] + PAGE_SIZE;
>>> +				contiguous = amdgpu_vm_addr_contiguous(adev,
>>> +								       pages_addr[pfn],
>>> +								       pages_addr[pfn + 1],
>>> +								       contiguous);
>>>   
>>> -				tmp = num_entries /
>>> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>> +				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>>   				for (count = 2; count < tmp; ++count) {
>>>   					uint64_t idx = pfn + count;
>>>   
>>> -					if (contiguous != (pages_addr[idx] ==
>>> -					    pages_addr[idx - 1] + PAGE_SIZE))
>>> +					if (contiguous != amdgpu_vm_addr_contiguous(adev,
>>> +									pages_addr[idx - 1],
>>> +									pages_addr[idx],
>>> +									contiguous))
>>>   						break;
>>>   				}
>>> +
>>>   				if (!contiguous)
>>>   					count--;
>>> -				num_entries = count *
>>> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>> +
>>> +				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>>   			}
>>>   
>>>   			if (!contiguous) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index 31a437ce9570..9e1607fb3b2e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>>>   		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>>>   
>>>   	/* APUs mapping system memory may need different MTYPEs on different
>>> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
>>> -	 * to be on the same NUMA node.
>>> +	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
>>> +	 * since amdgpu_vm_update_range ensures updates don't span NUMA
>>> +	 * node boundaries.
>>>   	 */
>>>   	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
>>>   	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
>>> -	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
>>> -		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>>> +	    num_possible_nodes() > 1 && params->allow_override) {
>>> +		if (params->pages_addr)
>>> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
>>> +					params->pages_addr[addr >> PAGE_SHIFT], &flags);
>>> +		else
>>> +			amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>>> +	}
>>>   
>>>   	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>>>   					 flags);

--------------OTeENLc0Cr40Ov4JCd7SbBna
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-08 04:04, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4966b8f2-4d51-405c-beae-889771c298b5@amd.com">
      <pre wrap="" class="moz-quote-pre">On 4/7/26 21:40, Chen, Xiaogang wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 4/7/2026 8:38 AM, Philip Yang wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On multi-socket MI300A APU systems, system memory pages mapped to the
closest GPU must use MTYPE_RW instead of MTYPE_NC to maintain correct
cache coherence. The existing mtype override in amdgpu_vm_pte_update_flags()
excluded non-contiguous page mappings from the override. This caused
incorrect MTYPE_NC for scattered local pages, leading to cache coherence
issues.

The override applies to both contiguous and non-contiguous mappings.
When pages_addr is set, resolve the physical address via
pages_addr[addr &gt;&gt; PAGE_SHIFT] before passing it to the override
callback for NUMA node lookup.

Introduce amdgpu_vm_addr_contiguous() helper that, on MI300A, treats
pages on different NUMA nodes as non-contiguous even if their DMA
addresses are adjacent. This ensures amdgpu_vm_update_range() splits
page table updates at NUMA node boundaries so each batch gets the
correct mtype override.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 48 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 14 +++++--
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63156289ae7f..f8fcbf079bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1099,6 +1099,34 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 }
 
+/**
+ * amdgpu_vm_addr_contiguous - check if two DMA addresses are contiguous
+ *
+ * @adev: amdgpu_device pointer
+ * @addr: current DMA address
+ * @addr_next: next DMA address to check against
+ * @contiguous: current contiguity state of the range being built
+ *
+ * Check whether @addr and @addr_next are physically contiguous. On APU
+ * platforms with multiple NUMA nodes (e.g. MI300A), a NUMA node boundary
+ * also breaks contiguity so that each contiguous batch stays within a
+ * single NUMA node for correct MTYPE override selection.
+ *
+ * Returns:
+ * true if @addr_next continues the current contiguous range, false otherwise.
+ */
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
We can use pfn_to_nid or page_to_nid to get which noma(id) the backing memory is at.&nbsp;pfn_to_nid uses pfn from physical address. You use dma_addr_t that is device dependent. It is not always same as physical address of RAM.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Yeah that here won't work at all.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
ttm_tt also has

/** @pages: Array of pages backing the data. */ struct page **pages;

I think using the pages to get numa id by page_to_nid&nbsp;is more appropriate.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That array isn't filled in for imported pages.

As far as I can see the whole approach won't work reliable. For imports we only know the dma_addr and not the struct page nor the pfn.</pre>
    </blockquote>
    if adev-&gt;ram_is_direct_mapped, then dma_addr equals to pfn, we
    can use dma_addr to call pfn_to_nid.<br>
    I will add ram_is_direct_mapped condition, this is currently inside
    override function, and add fast path change suggested by Felix in
    next version.<br>
    <br>
    Regards,<br>
    Philip&nbsp;&nbsp;
    <blockquote type="cite" cite="mid:4966b8f2-4d51-405c-beae-889771c298b5@amd.com">
      <pre wrap="" class="moz-quote-pre">

I think we need to re-iterate the whole idea of MTYPE override.

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Regards

Xiaogang

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">+static inline bool amdgpu_vm_addr_contiguous(struct amdgpu_device *adev, dma_addr_t addr,
+					     dma_addr_t addr_next, bool contiguous)
+{
+	if (!adev-&gt;gmc.is_app_apu || !page_is_ram(addr &gt;&gt; PAGE_SHIFT))
+		return (addr + PAGE_SIZE) == addr_next;
+
+	if (pfn_to_nid(addr &gt;&gt; PAGE_SHIFT) != pfn_to_nid(addr_next &gt;&gt; PAGE_SHIFT))
+		return !contiguous;
+
+	return (addr + PAGE_SIZE) == addr_next;
+}
+
 /**
  * amdgpu_vm_update_range - update a range in the vm page table
  *
@@ -1198,22 +1226,26 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				uint64_t pfn = cursor.start &gt;&gt; PAGE_SHIFT;
 				uint64_t count;
 
-				contiguous = pages_addr[pfn + 1] ==
-					pages_addr[pfn] + PAGE_SIZE;
+				contiguous = amdgpu_vm_addr_contiguous(adev,
+								       pages_addr[pfn],
+								       pages_addr[pfn + 1],
+								       contiguous);
 
-				tmp = num_entries /
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+				tmp = num_entries / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 				for (count = 2; count &lt; tmp; ++count) {
 					uint64_t idx = pfn + count;
 
-					if (contiguous != (pages_addr[idx] ==
-					    pages_addr[idx - 1] + PAGE_SIZE))
+					if (contiguous != amdgpu_vm_addr_contiguous(adev,
+									pages_addr[idx - 1],
+									pages_addr[idx],
+									contiguous))
 						break;
 				}
+
 				if (!contiguous)
 					count--;
-				num_entries = count *
-					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+
+				num_entries = count * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 			}
 
 			if (!contiguous) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 31a437ce9570..9e1607fb3b2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -708,13 +708,19 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		amdgpu_vm_pte_update_noretry_flags(adev, &amp;flags);
 
 	/* APUs mapping system memory may need different MTYPEs on different
-	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
-	 * to be on the same NUMA node.
+	 * NUMA nodes. Both contiguous and non-contiguous ranges are handled
+	 * since amdgpu_vm_update_range ensures updates don't span NUMA
+	 * node boundaries.
 	 */
 	if ((flags &amp; AMDGPU_PTE_SYSTEM) &amp;&amp; (adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp;
 	    adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags &amp;&amp;
-	    num_possible_nodes() &gt; 1 &amp;&amp; !params-&gt;pages_addr &amp;&amp; params-&gt;allow_override)
-		amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm, addr, &amp;flags);
+	    num_possible_nodes() &gt; 1 &amp;&amp; params-&gt;allow_override) {
+		if (params-&gt;pages_addr)
+			amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm,
+					params-&gt;pages_addr[addr &gt;&gt; PAGE_SHIFT], &amp;flags);
+		else
+			amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm, addr, &amp;flags);
+	}
 
 	params-&gt;vm-&gt;update_funcs-&gt;update(params, pt, pe, addr, count, incr,
 					 flags);
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------OTeENLc0Cr40Ov4JCd7SbBna--
