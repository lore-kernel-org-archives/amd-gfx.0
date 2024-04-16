Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25869C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 07:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FB710EF05;
	Tue, 16 Apr 2024 07:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z7gjJEQN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A840C10EF0C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 07:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3XBj/sKjuG8MZ8mXShL7Ih871Ug5D5Y1sXo0W5MD8upUaZku3RTYd1t18ecCU6ua+IIUK6o8li1dEcB/GExoWTHCj18kA2YLg4kHv5AqlocuzYZhNCtqlCiP1uaa2+XfJuDi6o8KFuYcKIfPYXHdE0xARCeU6EVG+D3zzw8gxD80rLE0xxh44cQ0HcMsBvi11lAQiiB0gxKbN3nHDFoscKOhpI/UGgmrf6IBsu8ySLXHGciN3CT7RaKPOLNt2Xdro+wYWJOM2N0lSBaxneOlwn0FaTPfzE9XZkl7lPRU5yG3NEJrsC5zHpjWJBQl9/QFre1AFN0bahov2C5EgDlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x6WQse3n4RGljAIsUrr4VBf5eGHaynwz48LMqbo8Hs=;
 b=K+6+ym49qZKl5Iit0dp2Y93UdWem7hnSyj7hxFu6Ok9gmZBBTMEp0dQ7HK3t9JwnR5ouYjZFgVdD4PTIkB6BmkbILD6POkMI4lMBnTnbeyg9d4kHrk+bzWHRIwxE7viVUQ/s2y83klGv0WSbPXA1n+S4+OyBIz6QfFACgUErtx6rAot+Rn3XyFLDZbTnGqx10YOKKJ57Z6yPwktj76zN6xgJcqG3s0bhTaQyK+3CKLZo7BHleGNSTGwuqWiver4K+PRxVV2eiZ2PjQgayT6D9OfmgUR75UaO1+63ksbuvqioP/o02KpE1HUwxppo/Z+YTCh1X1reRPa+ZqQ0mzJ7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x6WQse3n4RGljAIsUrr4VBf5eGHaynwz48LMqbo8Hs=;
 b=Z7gjJEQNIfVEvRIbVEUIpPBf0csafTlZTshP4I53Fjt04GXhYXi1T8q1sYrHOA80T0VztYMdgpSw4prVtid8RTuPL7eR8SRaP9mYXxoYwZeFK3NlfyF7wO2/A4kivu4VrUXCiMvRMKvZu6gBBaf2pzI/QXYomWdeVneAb3lzW5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 07:46:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 07:46:45 +0000
Message-ID: <4e0dd9e0-1b07-47df-804a-a869d08ca171@amd.com>
Date: Tue, 16 Apr 2024 09:46:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Modify the contiguous flags behaviour
To: Philip Yang <yangp@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, philip.yang@amd.com
References: <20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com>
 <01b794f2-1f9f-e8ac-1c0f-1acd199e09ea@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <01b794f2-1f9f-e8ac-1c0f-1acd199e09ea@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 708281e8-3874-4d9b-5487-08dc5de95d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNn68J4ApTu8OVU1qGXuVMBb1K4JIKGu+GopRxmjdhlCjI2WOcfWx5fjw6npW2XDPdhp2zUvmXZgvcbiGjD7dDPFE5tbq/La8lQWDRTuGhcgUumngvUj9ZACISKVnvi91Pw1olZU4vzvhVQeulOCnMZrVmsNXL3DRWLHAeBGNmiL4NWvNPi/b5KHxwHVATzOt493P/Lx7uI2Zu2giPhObHOdzIvJviOL7ahV9bWDTW5Ejj0YgooZEKO20I/JQHtMDO35Cbs5wX7hO1kTamLW39O3fLSpIkOzEmI2F60H3OkfGnXsEovpFu9A5/s4S9t9cRLdJymN9xBlTDpkRK/ToJ5LTWW+rKNW+md2JBFJXPkCUz5BCr91Ilou3EaCrb0azQcY4+0hA/gn6bBmfg38i8r992cK22bfHrRa7ZxFgSz+z+oSAg6iSY08ua00roM1xOTRtxGPTBPwC1svycHXKmPbd3/yJiwpSQodi2FuPvQGzmyywQC+3D3ziZoxtnjKGd8H8bo0NKS4o8GaPwV1TXpOkSqMuG6HQAUNYL7yAVZcxAcr0v4QAvaNeZHI6f5TMTwO+A4ohHC736QYEzaVs3ugcn/pEoga48/p0KC3obYMwG85Y4+UKqyYG99cb62kkqLu9nzuoRCTSwB5NYhe+Ex4LE9EbkCpAnm/NMLFYF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDl3YmFCVms5dGFQSkQveHpXZEptY1dzZjN2dStPSmRCMGlHMEVReDRhK0Nl?=
 =?utf-8?B?R2llL0pMK2ltSUt6cnl0ZmZkcllvYUt3WHoxd3VNMnJjZ1AyckhQM2hzNWJj?=
 =?utf-8?B?eEJtVTU2OThLdlp1YUhIU1UzaUZBRzdpMnNMVGVaLzN6b2d2RUtwQm1VUW0r?=
 =?utf-8?B?TXl1OFFJNU80S25udG1CQ0dVZldTbjc0SVFiQWpNbEtlcFBVeDVBMW9PR1d0?=
 =?utf-8?B?UHFCQld5NmRpaVdpZUhDa1FzWUdiaDJ6dTZjblE1akxOT0wwZ2FudTlQQXRs?=
 =?utf-8?B?YURVbTlEVFRsTFhLZ1NZZTVvbUtVbjNSVDdJenE2T2YxV1RBK2NESmFvQUFM?=
 =?utf-8?B?ckFWYnlnaU5hL2VqN3RORGN5TnVSbFhUOTZvWnlXOFNtaFU1RXJYbk1BR09K?=
 =?utf-8?B?RDBLcW1kbWF3cmgyMkRFcVppRU5vRUFWNXlwUHdhSFhKRHFNWkVQM3EzRVpH?=
 =?utf-8?B?UThNSGpXczk1QmpRZlpZUGxsWkRNWnIvTEE5dW01c0ZhaitvTk9UcjA5V2Qz?=
 =?utf-8?B?YzRlbXU3VW5Jc3VtQlNCaGpVem9rS0hEUVozNk02REtuOWovbDFzdGRremli?=
 =?utf-8?B?UEIwWWxYT2xmdnRHYS9ZMFduZzI2Ny9nd1d5M3dKdU5rRGw5cjN4TkErNGY3?=
 =?utf-8?B?RXZpcnI5LzlnZlNWZ3oyU3N1dWQ2bktaWUt3QVR3bUF0YVFTaGRYclVUT0ZB?=
 =?utf-8?B?MlprazRPeGdJeWI0ZFdpcTZBQjdGSndlSUJCUWltUnBER3FNOG56TUJoRlpz?=
 =?utf-8?B?TEoyMEM3dlNyL3hsQ0lPbFcrNHJhOWRoQ1o0UWRwV1NQVXJFRW43R3ZjVFNx?=
 =?utf-8?B?dDY3RUt4MlI2dW44SmRXdzFacis5MngvRDJUS0srMnAzMXI2UjBYK0lzOVFu?=
 =?utf-8?B?S3BqRWlZV3JTYmpwNW5ZK21SRWM0MnQ2aEhNYmYyRk9DbTUrL2ZiS3oyZ3Va?=
 =?utf-8?B?M2E5ZWhXWmxZVjRzTmtmSEhSdXpkbmE5VVpTUzAwbVpocmNTMEI0MERmMlFh?=
 =?utf-8?B?MjZmUHlIUVBCYjFPbGcwREk2N2hoNVV0Q09wQ2dERXZvbStxVkdBdmhnWmFS?=
 =?utf-8?B?L0oxZnc3TmdGTGw2aTdJTHN2MjRsZUZRaDdZYlJFZE40V3RJR01HVWY2eUhx?=
 =?utf-8?B?S0RUQTM1akJCZkhzUThCM3BsK1FIeDF4TGEwR09MVzdlYlZQNFo3WFJQSVBZ?=
 =?utf-8?B?ODNTRlZpUEJxQTdDS1E4aW9yeWVoc2phNmRGK2cyVkorV3poN2pWekk2TnFu?=
 =?utf-8?B?bndJUis0TkJ5VzMxRjY4amFoTTJ0dFdPMWZleE1aYzczb2gvS2w0b1ErVXo1?=
 =?utf-8?B?MWxEZFc5SldkSnRUODNqTjBUNTBIVEZrZG9yem81MitKM3R4RTRTYlZRWnll?=
 =?utf-8?B?Q3g1YUdwRUdMNjgyS3NhR0Q4YzhFMksrOE1FQktUdjF1NTFncFRzbGdxQVlv?=
 =?utf-8?B?aFFKS24vdU5VdkwyeWtZL214Z0JSV0x4Mzh4NjNKTnNScHBiWEtrOHpRTWt1?=
 =?utf-8?B?aXQ3YWtSNjVyWUxDNllaM2RiK1RKdTVzejMzU09IaEJ2SzdXT2hxVnlDR2Fv?=
 =?utf-8?B?amExbFhHQ3MrZG5lcEFRUTJZNWQvUVRoaU1RU3E2ZGJ5WjBsNnJOSVkzUFlW?=
 =?utf-8?B?YnZsNDhwWHNDNTZiTHBkZkVpbGhZQmhJWXZ2QkMyQ0puSTFVb1p1cWRyRytD?=
 =?utf-8?B?K2c3MnF0UU1ya1NWSDNqWnIvSi9tTUtrS0ZWNTNCdEg0SHlKRWZxWGx1M2NO?=
 =?utf-8?B?UHZzNDFEWFl3am1UK3BVeGNQQUZOOG5EYlZlclhqZTBtVUhxdWlGaCtDUWNI?=
 =?utf-8?B?UVVYY0wzbGdlNzlUcDBBbEIwakpxUmRoRzFFdk1jOXgvSVU0THROY3Vyd3Vi?=
 =?utf-8?B?QUlBZmUvVkN0TXpheHFUTllmUmpqOUUyb2htdml4cEhIVHExaW41YUdsck5o?=
 =?utf-8?B?eDBFYmJlckdkM2diYkpadGx0eWhaMGFMK3JhMzUyZEV3MldSSm45ZVJEZHdl?=
 =?utf-8?B?Q2pOYXJEcE9WQjd0OERyTkNLSThpR3ZrTGgwZjBZU2xDc1dCb2ZrZDczQ1ZI?=
 =?utf-8?B?bXpwckY4VUU4RU4rVlYxY1M3dUhZSndsZDNLSnQ3M0lQTVNOc0FxZWVzTktO?=
 =?utf-8?Q?qj3X/RGOiryLEqyS01R/CxWh0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708281e8-3874-4d9b-5487-08dc5de95d40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 07:46:45.3943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+e3whkyMrOH5NapdHsQwBrgclqgNUwH0UMQBLwkmV5wjrB3XEWVuM8utZhy4twJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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

Am 16.04.24 um 00:02 schrieb Philip Yang:
> On 2024-04-14 10:57, Arunpravin Paneer Selvam wrote:
>> Now we have two flags for contiguous VRAM buffer allocation.
>> If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
>> it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
>> buffer's placement function.
>>
>> This patch will change the default behaviour of the two flags.
> This change will simplify the KFD best effort contiguous VRAM 
> allocation, because KFD doesn't need set new GEM_ flag.
>> When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
>> - This means contiguous is not mandatory.
>
> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS used in couple of places. For page 
> table BO, it is fine as BO size is page size 4K. For 64KB reserved BOs 
> and F/W size related BOs, do all allocation happen at driver 
> initialization before the VRAM is fragmented?
>

Oh, that's a really good point, we need to keep the behavior as is for 
kernel allocations. Arun can you take care of that?

Thanks,
Christian.

>> - we will try to allocate the contiguous buffer. Say if the
>>    allocation fails, we fallback to allocate the individual pages.
>>
>> When we setTTM_PL_FLAG_CONTIGUOUS
>> - This means contiguous allocation is mandatory.
>> - we are setting this in amdgpu_bo_pin_restricted() before bo validation
>>    and check this flag in the vram manager file.
>> - if this is set, we should allocate the buffer pages contiguously.
>>    the allocation fails, we return -ENOSPC.
>>
>> Signed-off-by: Arunpravin Paneer Selvam<Arunpravin.PaneerSelvam@amd.com>
>> Suggested-by: Christian König<christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   | 14 +++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 +++++++++++++++-----
>>   2 files changed, 49 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 8bc79924d171..41926d631563 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -153,8 +153,6 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>>   		else
>>   			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>>   
>> -		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>> -			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>   		c++;
>>   	}
>>   
>> @@ -899,6 +897,8 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>>   {
>>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>   	struct ttm_operation_ctx ctx = { false, false };
>> +	struct ttm_place *places = bo->placements;
>> +	u32 c = 0;
>>   	int r, i;
>>   
>>   	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
>> @@ -921,16 +921,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>>   
>>   	if (bo->tbo.pin_count) {
>>   		uint32_t mem_type = bo->tbo.resource->mem_type;
>> -		uint32_t mem_flags = bo->tbo.resource->placement;
>>   
>>   		if (!(domain & amdgpu_mem_type_to_domain(mem_type)))
>>   			return -EINVAL;
>>   
>> -		if ((mem_type == TTM_PL_VRAM) &&
>> -		    (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) &&
>> -		    !(mem_flags & TTM_PL_FLAG_CONTIGUOUS))
>> -			return -EINVAL;
>> -
> This looks like a bug before, but with this patch, the check makes 
> sense and is needed.
>>   		ttm_bo_pin(&bo->tbo);
>>   
>>   		if (max_offset != 0) {
>> @@ -968,6 +962,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>>   			bo->placements[i].lpfn = lpfn;
>>   	}
>>   
>> +	if (domain & AMDGPU_GEM_DOMAIN_VRAM &&
>> +	    !WARN_ON(places[c].mem_type != TTM_PL_VRAM))
>> +		places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>> +
>
> If BO pinned is not allocated with AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS, 
> should pin and return scattered pages because the RDMA support 
> scattered dmabuf. Christian also pointed this out.
>
> If (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>
>     bo->placements[i].mem_type == TTM_PL_VRAM)
>         o->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>   	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>   	if (unlikely(r)) {
>>   		dev_err(adev->dev, "%p pin failed\n", bo);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 8db880244324..ddbf302878f6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -88,6 +88,30 @@ static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
>>   	return size;
>>   }
>>   
>> +static inline unsigned long
>> +amdgpu_vram_find_pages_per_block(struct ttm_buffer_object *tbo,
>> +				 const struct ttm_place *place,
>> +				 unsigned long bo_flags)
>> +{
>> +	unsigned long pages_per_block;
>> +
>> +	if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
>> +	    place->flags & TTM_PL_FLAG_CONTIGUOUS) {
>> +		pages_per_block = ~0ul;
>> +	} else {
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +		pages_per_block = HPAGE_PMD_NR;
>> +#else
>> +		/* default to 2MB */
>> +		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>> +#endif
>> +		pages_per_block = max_t(uint32_t, pages_per_block,
>> +					tbo->page_alignment);
>> +	}
>> +
>> +	return pages_per_block;
>> +}
>> +
>>   /**
>>    * DOC: mem_info_vram_total
>>    *
>> @@ -451,8 +475,10 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>>   	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>>   	struct amdgpu_device *adev = to_amdgpu_device(mgr);
>>   	u64 vis_usage = 0, max_bytes, min_block_size;
>> +	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>   	struct amdgpu_vram_mgr_resource *vres;
>>   	u64 size, remaining_size, lpfn, fpfn;
>> +	unsigned long bo_flags = bo->flags;
>>   	struct drm_buddy *mm = &mgr->mm;
>>   	struct drm_buddy_block *block;
>>   	unsigned long pages_per_block;
>> @@ -468,18 +494,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>>   	if (tbo->type != ttm_bo_type_kernel)
>>   		max_bytes -= AMDGPU_VM_RESERVED_VRAM;
>>   
>> -	if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
>> -		pages_per_block = ~0ul;
>> -	} else {
>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -		pages_per_block = HPAGE_PMD_NR;
>> -#else
>> -		/* default to 2MB */
>> -		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>> -#endif
>> -		pages_per_block = max_t(uint32_t, pages_per_block,
>> -					tbo->page_alignment);
>> -	}
>> +	pages_per_block =
>> +		amdgpu_vram_find_pages_per_block(tbo, place, bo_flags);
>>   
>>   	vres = kzalloc(sizeof(*vres), GFP_KERNEL);
>>   	if (!vres)
>> @@ -498,7 +514,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>>   	if (place->flags & TTM_PL_FLAG_TOPDOWN)
>>   		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>>   
>> -	if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
>> +	if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
>> +	    place->flags & TTM_PL_FLAG_CONTIGUOUS)
>>   		vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>>   
>>   	if (fpfn || lpfn != mgr->mm.size)
>> @@ -529,8 +546,20 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>>   					   min_block_size,
>>   					   &vres->blocks,
>>   					   vres->flags);
>> -		if (unlikely(r))
>> +		if (unlikely(r)) {
>
> If pin BO failed to allocate contiguous VRAM, this should return 
> failure to application, as RDMA cannot work with scattered VRAM pages.
>
> Regards,
>
> Philip
>
>> +			if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>> +				/* Fallback to non contiguous allocation */
>> +				vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>> +				bo_flags &= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>> +
>> +				pages_per_block =
>> +					amdgpu_vram_find_pages_per_block(tbo,
>> +									 place,
>> +									 bo_flags);
>> +				continue;
>> +			}
>>   			goto error_free_blocks;
>> +		}
>>   
>>   		if (size > remaining_size)
>>   			remaining_size = 0;

