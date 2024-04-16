Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682B0C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 06:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA939112A88;
	Tue, 16 Apr 2024 06:50:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2GdHegDB";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CB0112A88
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 06:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHx8jmms8vffd12ytEzT6nghTUFuJiPGdyn4g/0lH70wfcM6hWnL0pt9FX8M1Fjldr3JiKVudJRCcxAT5ayPmWbmbGkQU2NkYnroUSq1n0vqizF1QHlZin55vrp83+5V52hnnA8gWfevQp9SbcdYadBbgDcSA6Ljor0t2bz1LIYN6J0+tuB4Dyv/YNNiMCTh7rruk/pd1Sfh3s3ff2rPIFja1uv+/CF7RIfT2mUG4aiayshjVnD4+WECziT02/UCKDpgXn4vYZOmR++FltywN+VnSOdJcurqBgFJR+g5+1hE6WtvCLt1UmlCY4LRHBp0aTyMBqIg+hAZqxk9660nGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/W/EqHIwFV0T62HSE8xi3CFnqDP2mdrlZBk25/LAq8=;
 b=nLgxMzaHLfBe2Uc13SflXBVZNBU3v39++Ge0aIRSSxow56VsRmM5DODq/UyzkpSbkscEUrbkhE8cPg1rtAlrijLy9S6CSITJbKWS2yHCUYOsuJzhwAKo5e4cFVtV9b6YcMOcyysyyQZKKQCACLDlVqhJOwaoJYoShxoVaaTLjZlcwM2qJIiy82wjdnysauqfdqt9eacmliUqatH0KZozmlO434iVUvf/f6nDuEgmm4j0fSgp1OydgbIabN/Cb+P7jJOyDf7tVfyWdALZN3DMAprlUbRHip084Dp0uxJgpW+uYKYlLaEhrt1JaWcGvFEjYm0MkSgS6KP7aZjo9qdZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/W/EqHIwFV0T62HSE8xi3CFnqDP2mdrlZBk25/LAq8=;
 b=2GdHegDB7DeRgOaSFcQR8DPIjgEUH30zLgh6dollmG29XU1orMDgK8UnYEw2wXPMyZ8gVttPSMh7L/rR+c8Afg3MJ12196HlnS9tqIatSV+61kJpgIMhEA7szT9j7p+42hMOncDz0rnhkVCya2/ZZ8V7vjkfE5HB2MqXarb1hos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:50:19 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 06:50:19 +0000
Message-ID: <a8fd7808-a4ae-4e1e-8aae-be22bd4fd3b1@amd.com>
Date: Tue, 16 Apr 2024 12:20:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Modify the contiguous flags behaviour
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 felix.kuehling@amd.com, philip.yang@amd.com
References: <20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com>
 <01b794f2-1f9f-e8ac-1c0f-1acd199e09ea@amd.com>
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <01b794f2-1f9f-e8ac-1c0f-1acd199e09ea@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: d13acee1-f834-4e03-aaea-08dc5de17aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpJr5Zj4gvz/PdNBYHgld6obQBRylsjHJFto/70Xl2t72nfYVOydyB0ew9WrbtmuNYpV1d810q8fkqHSf7GyVNtwgKALXtst8vbBNvffELVeDv2AhpUQ/tHG54QPtvCBcgLNNV5Z54W3yUXm+lR6cpXy8ju61U2+xy/0XtkpX6cBm9/OOizRpO4GhvVN6Xg0957yTzrqRRO3lkJPl6JfN+kYhKFQhAd+LNvXsuWJCD2e8m8rBo4tR+6UULatnzrFNtHnC0JrjJ5rAbwucRJwDvRBfwq2SJkmY9cPXJQbZa33wie4gLdamGd+U1dtYKw/od/YiAN0pUXgUUJv+sx/DLP47zMZ58YXv1333vIx4A3nw1FsSJFWqP/Tkbd8SrVMR3tw4LS1jywSRrbja94pDa1qChz3hPThuytjj6Dl+3/OQ6SgoFKM+FYJfjDe1xyx+ZeB/oqBlXD3dN98QiQIGxN6Q0XVyRwf2x+AFYFXXvj5TW78ZCuC9VitbdZsJ1yptwbESP4/KxnqBdAc1N273XQNtr+VCXfnLzfamNwemyXvMaF8HSvUD1UxIcwbuda83JvMEcWG1Wc6arGGxRKpERr3sNiv+PDhEg/zPvsizvTJzB8/uiRjvN/+oIrvq0vnK3OTrZ/U5BKjwLROGImBgi74w+xeWk+hN3SgR8GspeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2dXODFVSGRrMk01VGd3NHFMYTVZSGJtMWxnbE9tZlBsMkJwM0ZCbVYzSGhW?=
 =?utf-8?B?S1BlTXc3RDJYUmhHeW90MXNNbGhpVkVqTkxraU9FcXgwa0ZDeEhkaFF6U2VW?=
 =?utf-8?B?eHJjRGN3ZFkxenh3U1Y4ZjdYeVZFNFZqVTA2T3lXVGlnYW5tTGdIMkNNb0hN?=
 =?utf-8?B?UW55aGNyRm1mUlFuRmxlY1UrRTloY0NMMDYzdDdkeUhHTm1VWFpnY0hPYmwx?=
 =?utf-8?B?SXAyeHNCMkpKeTREOXIwbHljamFzZzl5L05ubW5vZlVCSzk2alpYK0IwSmpG?=
 =?utf-8?B?OW1LVjJyenNTMWdyV2dEbEFqQXVuTDNoMzZ6YUpWMU85anRPMjhRNmJJSmhP?=
 =?utf-8?B?ZmNMYklVT29uK3F5MkRwM2lYTmc5YktXcTFKb1BacUVsTzB6OFdyREhzSThw?=
 =?utf-8?B?OWVudW9vaUdoYnVXQWkvZXE1aTdya3hEMGpPcG5rQ0VWQnovY0JsRW51dDk2?=
 =?utf-8?B?azFhSERyZnVmbjZGUzRLa04vNVhpOUpwWWVXdmtseEpYbW9ZdVhSNVlTNHF3?=
 =?utf-8?B?TDdpMjB2R2JrZ21Fb2phNDQzRTlCS1E2Q3JLVERIWU85QzhzaHlwZUo4ekhx?=
 =?utf-8?B?dXFGc3kvdmJPMnpmeURnQ2NLallmVnA5aGpaaVlSRHFWRUw1NFNoNDNRcXhi?=
 =?utf-8?B?bmEvWDhYVHdFYllKV1lUclZTb3ZEWHE2L2F4R0Z1WVlJZk5vQU0yaDlmdytq?=
 =?utf-8?B?NC96cE1QTnVuNEVhc1hHZUc3ZGVaQitLdmM5VGY1RlY1TUNIZXU4UGIzbDI4?=
 =?utf-8?B?bWkzcnJUdWFkSCt5MW9ZYmFvQVk3U2tReWRtVXplV0ozYzNRcXFWZnBMa0lQ?=
 =?utf-8?B?TzFRNGFILzlnS2ZIbGtmSVkrWnNITXNOMjVDaktsbFV2WjR6cSs5cHIyS3hZ?=
 =?utf-8?B?WGtmTTQ2ZVVObWRUNXR6VkRWWHp4NUdnZGVlSVIzbVFUREJRem4rUGtoSGFn?=
 =?utf-8?B?V2xkam5GZXFEUHhMR2dPSUh2VkY0V21nZWQ1K2szNmZLL3ByVytJUVAydnJL?=
 =?utf-8?B?QVV4cDN1UWlOaUZtdDRZWnFMUkc4dmhhRUtxV3BBNThUUStiN0RqTXF5NVc1?=
 =?utf-8?B?RHA0am5vYlNFVzUxTWd6cFlXNjJ0U1ZBQTd2UDlkUXIzTTB3SnhITExrdTBQ?=
 =?utf-8?B?TDJKalBBZHd5cEdOQXA5TTlXWElFS1FmdVlxM1JLb2c3RnEzWUI3R2Y2T3BO?=
 =?utf-8?B?UGtWQUNsc0JuV1ZpWFg1MDZQUERpUTdjZHVEM3F5eEdKbkpCLyt3NUsyZUFm?=
 =?utf-8?B?bllRcUFKSnB0REU3TE9XYVkvSWJaUXJsUDV6YU9zalNYY2NNMjlOSjQ2WTdn?=
 =?utf-8?B?K3BCd3dyWERkRVNkbHZoUXEvTXIzSmFvZnhBbTZQR2d5NnZzbGxEL2NKRFZY?=
 =?utf-8?B?TTBrNHFQMng1QVhwRGs2bXVNd2toYkFDbktsUjIrdms5dmNYNThHdlp5bzVT?=
 =?utf-8?B?cStGbzc2andyUS95OHhaU2x6YkZCYUJYUWhvMG9pT0ZZZ0xFQ3RCOHdoL2Q1?=
 =?utf-8?B?Z1VOQ0NGVXROdmtqQUpKRUZxOVN0aUhCWmZmMHdaeUs1MWJDNjZwQnowdzh0?=
 =?utf-8?B?Q1Nyc3oydmpDaFJCY1BTakxFQTVGVCt2cTk1bTNud0YzT3VxS21OSlBsSnNl?=
 =?utf-8?B?amM4WlFWeTQ0dS9oR0dzMWlWY0w2NjR6bnZxcENJQVpRYjZHekovRnFmZitz?=
 =?utf-8?B?YWsvYWRZYzkxcnl0enc5emlZODkvbDBFMERLeHRLOGU3Y3JqbGpndzBQeDVZ?=
 =?utf-8?B?S2FFenlMVU56RmJETU5RTUhvVWdsdlpRelRUYkYwaDU1aEdZQ3lGbGh6Znl4?=
 =?utf-8?B?cmVYZnRaQ0pwbkpRaGFBODIrM2FPek5mcjZkSU5WdlBVVUw4bit2Uzgyb0Ex?=
 =?utf-8?B?SDJIbTJ4VTB1Y0RWUCtUWGlwVDZLVlBaS2dZNFdGRS9Qc2dLMHJBUEFvTEo5?=
 =?utf-8?B?Z1l0V2VUbFR5bGxhaWFpSWtZbFRrL0NLTmE0TG1TRWk0SlZBaGwycEh3QlVL?=
 =?utf-8?B?N3JVYnV5WWp4QStubFkycDQ5ei9KS21adms5anN0THJTY3FxNDBSakNPQTJk?=
 =?utf-8?B?ZURoRk9SMHd4MzJWV09Ya1BxNmxZVkwyUitES0VJQXBkd2w2eTlUcG1rNlh1?=
 =?utf-8?Q?b1Pq3DRFqjrhEfc3D/cgfc/ML?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13acee1-f834-4e03-aaea-08dc5de17aa7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:50:18.9714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DS81DScLHhFL6J3Gx51tK5Pw5SJxaYaTXRkdJDpwALN2PEob138gOmJCV0IA3MHexizBn2B+USb8SZt2vDnOdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
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



On 4/16/2024 3:32 AM, Philip Yang wrote:
>
>
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
here we can return -ENOSPC when the BO is pinned (i.e 
TTM_PL_FLAG_CONTIGUOUS is set). Please find the below modified condition,
if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
     !(place->flags & TTM_PL_FLAG_CONTIGUOUS)
Hence if the TTM_PL_FLAG_CONTIGUOUS flag is set, we don't proceed for 
allocating individual pages.
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

