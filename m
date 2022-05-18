Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EBAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 21:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1563F10EBB1;
	Wed, 18 May 2022 21:31:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E752010EBB1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 21:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS+E4EcAEpRPGw/rvJ6wP/WnZm+O2v6qSlB6pKd/QFQ3q3vTn73QkVrIcenu0VInVF2KDzLv4NPGuOLsD6IW0ncCNqypktBRD2MvYow/w/tp6sBz0XwXX7fQzi8xWT2Xg5Qfg15uggGivlQYNzeKtDYw0jxAIr/0SCQuWxiUQ0swb64p3GOI+NFrxOA+T2hGCM7LJ24SIijLxJnEREWoAOzQWY8VMQACMDh9KGyQSx848lV1dnlqTjmKmUG0+lp8UH56ns+WbOEID15TxDS4YnRdThD4UenyMNzI8mrwrRMIrCb1ej1qi35UhDpPUC/9p+w38hwIzvm4rZnxdz7+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7f01TYX9Uh9jwNHpHJzPKpb3L/sPdF61nb0yl90dGM=;
 b=VxUyrODFF3s375AXQ+7n5cIUIKQiW2TapqBcC2ee4g6coj4IhvvY5lIeAfeWtsPnAdQcJu2od2XfvwTdeUiGFo7nlv1LEoUrKydrvp69hdmPpP+sVSydGj7BVo2d+yu5WGbumITUU+IpLC83EqHvRC9AAIbFAnoXTGFRVFuE/cWdSxMkH9sQU8wBYBVSNOgrF3Onmu4MNjGaeQOQNq+U8yj55QMEU3tOvkF9QLJkEe0oC+RObxb8kaZdTVMP2QAVNMdX0vcuAhYQkyG+ushmnu6+xuT9BYUHKsx+66hd/vGiJVUJJgaZHauKyUXkOSauS9I2vCsO9rWPeN3/oRD/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7f01TYX9Uh9jwNHpHJzPKpb3L/sPdF61nb0yl90dGM=;
 b=V6zHaj5niAoilAr6u48UQL8JDv0sCN68SPj1Hw6qt9CZWDEL/eUxp/0cN6P3a31ZK7sos7y+9r6NV0lvLbU3Y3zFThAvicBBu7dYA9S4UuYwiRinFnApyK4IJ3hpO4DrGFFh4wrxop9lissfJhDeiepoWAHNndFTQkFQ/7WEETE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR1201MB0236.namprd12.prod.outlook.com (2603:10b6:4:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 21:31:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5273.013; Wed, 18 May 2022
 21:31:05 +0000
Message-ID: <63fe88f7-fa3c-67be-73ab-8fed555e4c52@amd.com>
Date: Wed, 18 May 2022 17:31:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] drm/amdgpu: remove acc_size from reserve/unreserve mem
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
References: <20220517231108.14048-1-alex.sierra@amd.com>
 <1e136059-5e56-8709-c252-bee43dec2c1d@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <1e136059-5e56-8709-c252-bee43dec2c1d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:208:23b::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca895f0-4c87-492d-9815-08da3915b6c7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0236:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB023669EF50FA4C67B2A9D51492D19@DM5PR1201MB0236.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPLfiEFK033SlAPqlQimSsTouCiyO2IMazTDdPnj2B0FtLmU/RMUXxVBcZwYdALAOXkUwxRsJ0P8dH58THBr9PvU50lwxOdK3CPwxBfizR7+uukHk67zVw8obsSj74ebGS2n0pl5EFBmAFHVW3lWVoFg1UObZXIR4nH3WZc+IxuJTRjSoBc/E5vHgfXTpIm9DAhm3rhNr01xpV5IO+vENhiG5qbb0CW5YAwUMyEczHmjixtryoR7s16E50j6hJ1N9xTc+ETZDJ6/K/emn13eAypa87FhiyCXJBsCy7F9dAH+dEVogFapw5oy2uxLnI8gecerFWcRycDgmrroi/6srGisgtiKa+1pHxFpdGw3Htg494sfs+iPXnfgjqIUGHrQjzr/E5AP8H38uX1NjNlMxJXpAuXBx+spSzdN5EwO/ifaB5MBsDUkMz0b+uf0j4HqC91GTRd6RwZf0/FdjtVHJ66i2zEHEgF2Dqv5LPTvtATlDbyNmF945XFVbwMRDKPFNhhjzW5ajyt3A7bZfHcZBBS4C2Jcqe7R/0M6m2ly/PPqdZY3M9N5tWaf4c8jMYepPI3+//95tqGhgIU11BMyOP+FGWjsT4HFvcAt7Kil2l+AMVXrwcnekUtjks9S3x91fx6g7Q7A5EUqKJAkfIZ+1xJwVlJbfYx/c4EEWSs9gDyNX6CsWZSaEgFl7//FjSzV73H6Nqkiq8MAa8DWJgUP4e9U8bbMBvn/VQ7lOdDYZreyEl9qN+CXJ3/Hc96y0ol5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(8676002)(6636002)(66556008)(66946007)(6506007)(53546011)(110136005)(316002)(66476007)(186003)(36916002)(508600001)(6512007)(26005)(6486002)(2616005)(36756003)(2906002)(86362001)(31686004)(31696002)(8936002)(44832011)(5660300002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWxkajFSRVFnNC9mcjVhUms0N0pHZGF2QzlFNlNnYTk0dllOUE55VTd6MVdm?=
 =?utf-8?B?NFNPc01lbGFPcE4rMngyMzZPSVZ5dDdOOGo3cm9aWDNzNWkxeERKVWNVcWpu?=
 =?utf-8?B?NzQ5RFkrUkVya2pXMHNMcE1qNmVoTjNWM0d6WjhsN216c0xWMHltekI3Njk0?=
 =?utf-8?B?UWcvRGdmdVExU1QvMmNNK0VUais3UW1VRGtjdThaSm1EV3hndDd1V2NQWGF6?=
 =?utf-8?B?WTF3S29iazR0aU9iK0padVd3WTNjNmpDcnBuRHg5bnR2UTdxZ3ovbzI2dVRR?=
 =?utf-8?B?QmpHbHJZUVVFVGhNV0NubjFQMmpjeE5UUmFublp6bmFWdU1nWk50YmszTjFt?=
 =?utf-8?B?eGtzdlF5YXdqT2N1OG1SU0xhaGZOOGZTa2J2a2dFYm5sUjR3K20yWCtoeTFI?=
 =?utf-8?B?aXoxRTNoZE5tRm5iUXBKVGVpY3dTTkVQMjdxL01zaDFWU3Vkek0xUDZYV01K?=
 =?utf-8?B?aEtHRDRuOGhNUi8reDgvMm5zWkFwd2RsQUpBYU1wU3NQZGR0bG5tYktqOC9N?=
 =?utf-8?B?azVndXJKRHBDZmxlZmRjdllQc0tNT2orZU5zMTZVaUFWZTFyeGd5MFBsaXdS?=
 =?utf-8?B?V1E2ZE4ycWtwL0pCR0NLelNUVHVXMDBiRUFtOVVlbHFNUzQyamlvS0ozZzlE?=
 =?utf-8?B?eWJJeFdnbXFIYlBVOFZkVGQ3cnZuYkRDbWx1eGxYQ20ySUN1ejNzZ2k4eXpO?=
 =?utf-8?B?L2JPcWV3Rk9xclBBWjZaajZHKzBrOE53WS9YUGNKTnVyQUtlV282TklIdGxU?=
 =?utf-8?B?Z3o5b3E4R3FiSEtIb0JzVkRjV0Y0WWlDSGsxdjJyVjJGSE1Wb3BPT3AyWmh1?=
 =?utf-8?B?bXRDc0ZaNFV0WFdFbTZodSsvYlVtQ0VvNUdjTEJRU1NzZHdTVHJvMmV0bWtm?=
 =?utf-8?B?b2tpa0lBT0NsNDR3cnl3WnF2amNLcllTdXFHcnFBc3ZlUUpTQnNMY1V2SDBu?=
 =?utf-8?B?N1dINDRUY2M5MWpjQ1NLMWs4OW5pem13dEJKRzYrd1V2MmptSWlXTTlVcHNJ?=
 =?utf-8?B?QmpMci9uOXlGR0hFblNRVVp4OGtNNmJoMzArY2RpbWQ1MHNiVlQ1K0doczNU?=
 =?utf-8?B?QXJKWkQ5cmpXd3cwN0dxTzdEQXZ0Vkk0NGdIdG9kQkprQWZtUUFNMUxNM1dr?=
 =?utf-8?B?c2hVeVZDY050Sm1lZ3JGTFI1T0svZW9zWHVuN2NGc2NlRVpWa2ZKbWlnMXVz?=
 =?utf-8?B?NzY1ajl5YXUxaEM2dVU2dG80RUROWkVsaWV4QmNWRGN3THlCQ2txMU5VRVhE?=
 =?utf-8?B?UElZckpBbW4wTEFZd3NGNzltVzlTck5qS3I0TlhhUE5wSXduVCsyMW9pV2hZ?=
 =?utf-8?B?R1hwOVNCMGRibmpPSTcydXN4V0R6MjNQdVRmNTVXdVBReWE4aWlXZ0lqTE9V?=
 =?utf-8?B?c3ozSkZkSUsrakx5dnZZd2pONG5PaWRrN0RkS1oyaUdISUJqeGVFZDVCUWVP?=
 =?utf-8?B?MEpybnFUZ3plS0RJa1pBc2U3TGZ6bERCaUFBV2tvbVlEWmh0SU5JSWRoSUFS?=
 =?utf-8?B?MG9zdXI0ajRFVTZGZk1TbnRWV3Z6cFRMWGZ1VG80V2toVU9PUVhJVFF6aHNC?=
 =?utf-8?B?UUJOb1NwYmN5RW9pdForRWt0MGltekFTZzkxSm1YZWZ0TUJpY3VpOTB5Q3JR?=
 =?utf-8?B?MG9aaTlpcHdtczZxOU1VTVJacUtEeG8rYVBBZTdWWmdLVGJRS1NXalNnNFA5?=
 =?utf-8?B?LzhzS3l3NUI1c2ticENLSmI4WHdhaldPSFQrVEFEMGpmYndvc2ZtWHJjLzhX?=
 =?utf-8?B?dlEva0dVNE5yRVVhSlZSM0llTG9ucHJhZVRiWi9hSUR6a1hSaXVZbHZqdU14?=
 =?utf-8?B?UGR0TnNXQ3RwdG9xTHQzckovWFFXYUhSZGozdHlIeHFSc1VUVmVzaFNYVExn?=
 =?utf-8?B?a2V6NkthNm54Y3VEYmlsR1NYSUQ3cDZwNHV5aFM0Q1RxeFJob0NLd21qQ2tB?=
 =?utf-8?B?eDZ2cUVrN211ZFMwYnUzdnZra0ZHZ3RJVzExelYwdE1VbkJ3b3lubW9ZZ3lM?=
 =?utf-8?B?NmxLV29OVG1CNjlQSkI2L3lLTk1NVmlObEx1dTJBdkl1elNMVUhlT0dxaGtr?=
 =?utf-8?B?SXpqTGhhT1dnYlJrQ3Rzemk3a0d3aDdpWmJib2E3ZE9sNlBUYU9zTFhya04y?=
 =?utf-8?B?cFZPRnBFUVBCcUN5TVlUdGh6MTJIdDl2b09MYVI0OUo4NFFZRU40ZXJoSS8x?=
 =?utf-8?B?NG5mbjVNWi93WnA1b3Y1cWxiSnlnaWVNVlZWV21LZHRWYld0aFVIZ2FDaXgz?=
 =?utf-8?B?TUZRb0NDMDAzckc2LzR6UVI0SDJrVm1VVU5pcFVXWXpYU2dUbVdJdkVkZjFM?=
 =?utf-8?B?WDJNT3F5aEJFMlE1TzR0ZzdKNXZkMUR4cEZWMGs3cTFuVWpVRktpQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca895f0-4c87-492d-9815-08da3915b6c7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:31:05.5587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRwfA7r/woqrN8wjJ9UQDK2077f4HmHjQtok7P7k3J289jAJcITCyBynluI/IfFNgLAeQo35J9K5skrU5zwFpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0236
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

On 2022-05-18 13:55, philip yang wrote:
>
>
> On 2022-05-17 19:11, Alex Sierra wrote:
>> TTM used to track the "acc_size" of all BOs internally. We needed to
>> keep track of it in our memory reservation to avoid TTM running out
>> of memory in its own accounting. However, that "acc_size" accounting
>> has since been removed from TTM. Therefore we don't really need to
>> track it any more.
>
> acc_size is size of amdgpu_bo data structure plus size of pages array 
> and dma_address array, it is needed for each BO, so should track as 
> system_mem_needed. It can be removed from ttm_mem_needed as this is 
> not allocated by TTM as GTT memory.
>
You have a point, I didn't think of that. The fact that TTM isn't 
tracking the data structure sizes any more doesn't mean, we shouldn't 
account for it in our own system memory usage.

That said, do we actually have DMA address arrays for VRAM allocations?

Also, acc_size doesn't track the extra dmabuf BOs we create for DMA 
mappings on multiple GPUs. So I'm not sure how useful the acc_size 
tracking is at this point. The system memory limit is currently 15/16 of 
total memory. Maybe that leaves enough reserve for data structure sizes?

Regards,
   Felix


> Regards,
>
> Philip
>
>> Signed-off-by: Alex Sierra<alex.sierra@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 57 ++++++-------------
>>   1 file changed, 16 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index fada3b149361..e985cf9c7ec0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -108,17 +108,8 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>>    * compromise that should work in most cases without reserving too
>>    * much memory for page tables unnecessarily (factor 16K, >> 14).
>>    */
>> -#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)
>> -
>> -static size_t amdgpu_amdkfd_acc_size(uint64_t size)
>> -{
>> -	size >>= PAGE_SHIFT;
>> -	size *= sizeof(dma_addr_t) + sizeof(void *);
>>   
>> -	return __roundup_pow_of_two(sizeof(struct amdgpu_bo)) +
>> -		__roundup_pow_of_two(sizeof(struct ttm_tt)) +
>> -		PAGE_ALIGN(size);
>> -}
>> +#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)
>>   
>>   /**
>>    * amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
>> @@ -136,28 +127,22 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   {
>>   	uint64_t reserved_for_pt =
>>   		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
>> -	size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
>> +	size_t system_mem_needed, ttm_mem_needed, vram_needed;
>>   	int ret = 0;
>>   
>> -	acc_size = amdgpu_amdkfd_acc_size(size);
>> -
>> +	system_mem_needed = 0;
>> +	ttm_mem_needed = 0;
>>   	vram_needed = 0;
>>   	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>> -		system_mem_needed = acc_size + size;
>> -		ttm_mem_needed = acc_size + size;
>> +		system_mem_needed = size;
>> +		ttm_mem_needed = size;
>>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>> -		system_mem_needed = acc_size;
>> -		ttm_mem_needed = acc_size;
>>   		vram_needed = size;
>>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>> -		system_mem_needed = acc_size + size;
>> -		ttm_mem_needed = acc_size;
>> -	} else if (alloc_flag &
>> -		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>> -		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>> -		system_mem_needed = acc_size;
>> -		ttm_mem_needed = acc_size;
>> -	} else {
>> +		system_mem_needed = size;
>> +	} else if (!(alloc_flag &
>> +				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>> +				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
>>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>>   		return -ENOMEM;
>>   	}
>> @@ -193,28 +178,18 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   static void unreserve_mem_limit(struct amdgpu_device *adev,
>>   		uint64_t size, u32 alloc_flag)
>>   {
>> -	size_t acc_size;
>> -
>> -	acc_size = amdgpu_amdkfd_acc_size(size);
>> -
>>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
>>   
>>   	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>> -		kfd_mem_limit.system_mem_used -= (acc_size + size);
>> -		kfd_mem_limit.ttm_mem_used -= (acc_size + size);
>> +		kfd_mem_limit.system_mem_used -= size;
>> +		kfd_mem_limit.ttm_mem_used -= size;
>>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>> -		kfd_mem_limit.system_mem_used -= acc_size;
>> -		kfd_mem_limit.ttm_mem_used -= acc_size;
>>   		adev->kfd.vram_used -= size;
>>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>> -		kfd_mem_limit.system_mem_used -= (acc_size + size);
>> -		kfd_mem_limit.ttm_mem_used -= acc_size;
>> -	} else if (alloc_flag &
>> -		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>> -		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>> -		kfd_mem_limit.system_mem_used -= acc_size;
>> -		kfd_mem_limit.ttm_mem_used -= acc_size;
>> -	} else {
>> +		kfd_mem_limit.system_mem_used -= size;
>> +	} else if (!(alloc_flag &
>> +				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>> +				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
>>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>>   		goto release;
>>   	}
