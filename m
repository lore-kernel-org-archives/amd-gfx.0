Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B784C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 13:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0267310F60C;
	Wed, 17 Apr 2024 13:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJlYdM9L";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADAAF10F60C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 13:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYJyWmGm+CQJy1cOLu5iuyzXW03xjNUoM5sJA5mogbe4VmmEzmUGRUbj6uLgUswrSFMJBZFo58MYEETxoOBZ6yq/E2oNxp49UBalRDQ7xbpDkrKUpH2SHDmcJ+2GtOMfkdTNqqnyF0OLId39F+3GXXCKXX3CBzGE7+vh0h63mqvoDRyQkacmU3VwrWZuiGjF7oG44B9BbNXiQpEk/A5kNAy9XAobFqt696g/OjpwcriCQBFykeMT0+JeD/MR8qmSJBg0fNHgLcYc2ztJHUkHxm66WO1woN4/x+8uAOh1BzHcd6dWRGMP7WSo4tb0osxV2+DhWJBA5+gftn6Blgf3hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNxUf0viy+Itkkbs3McIO1Z2Jmj62X0lisq6ZcoIuG8=;
 b=SdK2rFVVGreP6YUTX/VBBU+2yhJcipGbpeHW6tM/iBky59lOsPTke3TkM1X0EXcLYyxYVDtpEtM/J7gTGjTpg1NWoRfJH0j6zuqb7UO3qBGewk0j/K6x0qp7VkTUe2Vcdd+QNdG1Tk1o3gQNRfi8d9PfrKaH7cAF6nExyc+7Cru7uAYymwdvyEgi9ieMyLUrb08DjhlQZue2YqUHL+w3d4dJnoYI2exuxEw4ny5GcL/OWiY8hV5L7G34LSWD+AX2bpBvT+5yQAMjnxxAv24VSVJuRgJZj5nEB2Xg9VFHoUAD/DsTic+3j3CwRrMosEU/X21SPNGlOrW4lGdptlcV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNxUf0viy+Itkkbs3McIO1Z2Jmj62X0lisq6ZcoIuG8=;
 b=MJlYdM9L/dfo29mi8xqTT+IknnOgRDLy+ATwTRizkZxygwl3u+VvHr2wkbe94Z0pZuT64aTXbgA1J7cGRF92LddIRkH/syuV2btiNgkwq/3WzykQNZ2j2Gxebt4pRPLeB34icfwg7nvMRQAU2Kl/t4HGAVd9d+0PWr5FvjUmRuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by PH7PR12MB5759.namprd12.prod.outlook.com (2603:10b6:510:1d2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 13:27:55 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 13:27:55 +0000
Message-ID: <b5460307-ce38-4a34-af22-e0936507a3cc@amd.com>
Date: Wed, 17 Apr 2024 18:57:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Modify the contiguous flags behaviour
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, philip.yang@amd.com
References: <20240417062121.3779-1-Arunpravin.PaneerSelvam@amd.com>
 <0ebbd37d-1872-4d54-9aa1-842a6090c678@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <0ebbd37d-1872-4d54-9aa1-842a6090c678@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::23) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|PH7PR12MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: ec980223-51fa-40e9-ae0e-08dc5ee230ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YV03uGW67zoaayh0n8MZxZWsOYbIW5J0kIg8QCEffS+argMl8YMZ1x9Swd9SxSqn1Ygq7P1cJQkYupR1S0BoBcjAdhHxUhl8bYQRppq0h3xHrZ/HBGCMdfG9Md1+ufj/f83BBhwOV7ZLy3FFI8vj2r6BVo6lxt40DiNcfDc9R6fyYhCiAW8LJziRq6C7BkkcwsSVl3PqI/Ju0kM8MCLK16IWWVOQ0slvmg6WRcHUPxGHrx9eoi2vUjYFoF+OMr4YYVB3kAK14FDPRHiGPlJw9QwsoUiWtO0BghdvSdDt2Mx+xhJOKVn+4WvhRykaFVenhl+9PprPfCZ/ZfJv8naqZLC2hkyABDVumwW3esxeav2ibjQhQilHj4UnHQiCK8L9e9BZlqjcr/2zsm3EWcuHenWkwmSjRADFJtuRFjg73gG/LLlABtW8MXA4JKzdhyqwMR6Ny6n9hdAzzuF1UYLYJQTWt56SL0nNXdB4rCQ+9f3SWmb/h1xArMwN0lE3G886UVfuFauHQBuZYW3gMp45jy6tEOkhtun9kcyyUddI8yLhKCCO5i8PDENMiVAgT6YNj4om5rJdOIPwDgslVq9q9vPavd3ZLAho167aiOKjQWE5R4LNrNzbODB+z7tWNZFAGaGIvrqdJP/U1p4HqU5ZGk3gOicAmsiSg780A4j9a1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUpOL1FzZFltR0FTODRZWnB0Wi9lMnc3bUh4cU05dFo5U1hCQ0dhQWhYMXAz?=
 =?utf-8?B?UlB3dlhtdnpqTjRzYm0yR2JzZUxpbUIxWktidjRDeTluQ3ZlQUh0eGxJaEZv?=
 =?utf-8?B?Y0tza1NkZUh0UERLTUNKN1RPMTZpREZDY1RGb00rQ25MSHk3YTBYTGp4dVFT?=
 =?utf-8?B?ay9zcDA5aVpwekxRUzlMaFM1cUdSb1N5V213VTN6QnJUZklWb1pIUkg0aldj?=
 =?utf-8?B?TUJmYWg5NDZKLzRMM3lham9IWnpnN2pVS1JnODdWWS9YdHpsY2d0UzdLSFBN?=
 =?utf-8?B?ODVDR3htWGpFTkg0OUUzUFpIcHpwK2IxKzVFU0FwWU81a0NlVmtISEtNMTlj?=
 =?utf-8?B?bk1jbXNhaXQ2U2dJb0h3OGVUazVPcHJrSjJGcTFVa1RacXVLRDQ3ZDg1Nzlw?=
 =?utf-8?B?Z1R4bm9PUDJQRU53U21teTYwSVVnUWE1SmIzUDlJdTJleVN1WE1GM0UvZVJS?=
 =?utf-8?B?Z04vQjluWUJVVnM2eUlyRUU3OTRtRk55ajJGUmZVRmUwVjA1anRtOURxTWsz?=
 =?utf-8?B?MmdBK0VLMFkvUXEvOVJhakh1eWFndjUxUEN3Y3BPMFV2TlNya2dCaFc5a2Zz?=
 =?utf-8?B?aFQwb1VKbVNsZXgyckJXbmo2WHNoS1hSWXVwSmk2Q1NmZWZYVlR1OXBmbTIv?=
 =?utf-8?B?UEdqR0R1RkhuSnhyelB1emQzVmticThJZFBweWtTcVNxdXZVaTBIeU8rM1Zj?=
 =?utf-8?B?akJNeVNYZFgyVTh0L1o4NmlWdjR1V0VJWk9NMWVUczVHSVFacnRmcWR5Smxl?=
 =?utf-8?B?c0Z5dThJUVJrdTNqZ2tFalp4b2dqYm9DZDNER3RiQk1GdHAvam5CSElkNzBO?=
 =?utf-8?B?UjFyNmFKMmgyMjRYNE1kdGw5L3ovTEVpM09pWGhLdFo1a3NSUFRCQ2xRU0VX?=
 =?utf-8?B?Q0xiaEp6R2plVTBYQUZmUm9IaVhWSkFhRlBHcWV4NzQwNEVrUktCUC9OQUpQ?=
 =?utf-8?B?T0RXcFM3MCtCSFdwQzBZVi94dEdkV1pZRjV0WU1TWlhGWXR6RVgxbzl4Y0Rw?=
 =?utf-8?B?bWxjSlFmbDJZTkdONS8vUGVVcEEwSjAvbWN0enRjVnJna0NyQmlreGF0cjBG?=
 =?utf-8?B?bnBzUHhNejRRa01zWWFKa09KMlRYamhWd01sbkw4R3ZnbFBGSndyWGtHekNV?=
 =?utf-8?B?SlpwdkxFek9OOFE3OWY4VjdZZkVuTUtvdjY3bTFuU2pyTTlDRGdlcTRoSmJx?=
 =?utf-8?B?cWlxeXpvcUJ5SStwUGRXSHYvM0xvQ2hoRnIyUEU3ZlY2NWhsd1hLbTMySHIx?=
 =?utf-8?B?ZXUzV25JVUdzZ0F2UXJZZmkzV0xUUU9NZTRla0VORDZGNnFyRGN6RzAyaStV?=
 =?utf-8?B?bFJvN0t1Z2hrVGx2UzRGS1VCZ2dJK2dQOUJseTZwK1ZhRFdlZnAyZmV4cW5o?=
 =?utf-8?B?RWFPSGZYYXdoOTBHU1BVQVNWeXk2MUl1QVFIOVVGenBvSjFZWnp2MmYxTVdG?=
 =?utf-8?B?ckpvbGtJT3FjN3VManZmWHJVQXd4bVpRTTQ2WkMrMW15RUQ5YldObURQZkxG?=
 =?utf-8?B?QmwzY09jaVVVbGpkTGVnSlZWVndWbW93Q1dYRFViUUR0THAzcFc2NTVKTko0?=
 =?utf-8?B?bFlyUzlBdmVtbTFoWXhEMWtNUEVYelZ4RXh4U1RGMm1mM2hTZjlNbGtNTWxW?=
 =?utf-8?B?Y1J1MVBKKytBR2RqNFZBdXQ5alI2TVgrbUtUTWxMcE50dUtEek9lSHh5RFRk?=
 =?utf-8?B?UmhrS3hhcE9OdkRVblRocnNkdE5Fenl4VFFlZGQ5b3FNOWhuU3B5TThKYUg5?=
 =?utf-8?B?TTdvd1lKT1ZEbm1raldaZlpCdEFHcFlxeDhMKzBDNzlrZXJRc2ZkZHFEV1Zm?=
 =?utf-8?B?UW5qdEhNRk5TSURLRVN4ek5pQTZlMjdwRGo4VjY4OWZTWGpXdzZUbVV1VzB6?=
 =?utf-8?B?LzV0SjROckpZZnlsRGF6dHloSmdobTArM1hycU1kUFdqYXdIV21XU1ZCaDU0?=
 =?utf-8?B?TGt4OGRpR1RDaVU5R3VlcFhNSUxRYTRaRnBQMEkyUy9PSVlpQlVnVndFd2Mv?=
 =?utf-8?B?Tm05ditWMk01aDA4YW9pWEgwZitVdHBqY1lOK1ByamVDTE5XRm9YcVBiODVn?=
 =?utf-8?B?dHZnU2t4cngyTm85RjE0VzhmN0thbnZtVFJyQTJlYnAxdVRCaVhTWHZjY2sy?=
 =?utf-8?Q?LMZUyXKdOiXfAXwdLVQlGj1rV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec980223-51fa-40e9-ae0e-08dc5ee230ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 13:27:55.6299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/vhAx/ejZtXxKOaybBE6xxidc1dqZuZXdeoWDy1duxECsQEV/v+eJOV8VRd3PrCIzsV0+ESQQZIVUrH8WS00A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5759
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

Hi Christian,

On 4/17/2024 12:19 PM, Christian König wrote:
> Am 17.04.24 um 08:21 schrieb Arunpravin Paneer Selvam:
>> Now we have two flags for contiguous VRAM buffer allocation.
>> If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
>> it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
>> buffer's placement function.
>>
>> This patch will change the default behaviour of the two flags.
>>
>> When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
>> - This means contiguous is not mandatory.
>> - we will try to allocate the contiguous buffer. Say if the
>>    allocation fails, we fallback to allocate the individual pages.
>>
>> When we setTTM_PL_FLAG_CONTIGUOUS
>> - This means contiguous allocation is mandatory.
>> - we are setting this in amdgpu_bo_pin_restricted() before bo validation
>>    and check this flag in the vram manager file.
>> - if this is set, we should allocate the buffer pages contiguously.
>>    the allocation fails, we return -ENOSPC.
>>
>> v2:
>>    - keep the mem_flags and bo->flags check as is(Christian)
>>    - place the TTM_PL_FLAG_CONTIGUOUS flag setting into the
>>      amdgpu_bo_pin_restricted function placement range iteration
>>      loop(Christian)
>>    - rename find_pages with amdgpu_vram_mgr_calculate_pages_per_block
>>      (Christian)
>>    - Keep the kernel BO allocation as is(Christain)
>>    - If BO pin vram allocation failed, we need to return -ENOSPC as
>>      RDMA cannot work with scattered VRAM pages(Philip)
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  8 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 +++++++++++++++-----
>>   2 files changed, 50 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 8bc79924d171..caaef7b1df49 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -153,8 +153,10 @@ void amdgpu_bo_placement_from_domain(struct 
>> amdgpu_bo *abo, u32 domain)
>>           else
>>               places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>>   -        if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>> +        if (abo->tbo.type == ttm_bo_type_kernel &&
>> +            flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>               places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>> +
>>           c++;
>>       }
>>   @@ -966,6 +968,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>> *bo, u32 domain,
>>           if (!bo->placements[i].lpfn ||
>>               (lpfn && lpfn < bo->placements[i].lpfn))
>>               bo->placements[i].lpfn = lpfn;
>> +
>> +        if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>> +            bo->placements[i].mem_type == TTM_PL_VRAM)
>> +            bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>       }
>>         r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>
> Nice work, up till here that looks exactly right as far as I can see.
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 8db880244324..4be8b091099a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -88,6 +88,29 @@ static inline u64 
>> amdgpu_vram_mgr_blocks_size(struct list_head *head)
>>       return size;
>>   }
>>   +static inline unsigned long
>> +amdgpu_vram_mgr_calculate_pages_per_block(struct ttm_buffer_object 
>> *tbo,
>> +                      const struct ttm_place *place,
>> +                      unsigned long bo_flags)
>> +{
>> +    unsigned long pages_per_block;
>> +
>> +    if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>> +        pages_per_block = ~0ul;
>
> If I understand it correctly this here enforces the allocation of a 
> contiguous buffer in the way that it says we should have only one 
> giant page for the whole BO.
yes, for contiguous we don't have the 2MB limit, hence we are setting to 
maximum to avoid restricting the min_block_size to 2MB limitation.
>
>> +    } else {
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +        pages_per_block = HPAGE_PMD_NR;
>> +#else
>> +        /* default to 2MB */
>> +        pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>> +#endif
>> +        pages_per_block = max_t(uint32_t, pages_per_block,
>> +                    tbo->page_alignment);
>> +    }
>> +
>> +    return pages_per_block;
>> +}
>> +
>>   /**
>>    * DOC: mem_info_vram_total
>>    *
>> @@ -451,8 +474,10 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>       struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>>       struct amdgpu_device *adev = to_amdgpu_device(mgr);
>>       u64 vis_usage = 0, max_bytes, min_block_size;
>> +    struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>       struct amdgpu_vram_mgr_resource *vres;
>>       u64 size, remaining_size, lpfn, fpfn;
>> +    unsigned long bo_flags = bo->flags;
>>       struct drm_buddy *mm = &mgr->mm;
>>       struct drm_buddy_block *block;
>>       unsigned long pages_per_block;
>> @@ -468,18 +493,9 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>       if (tbo->type != ttm_bo_type_kernel)
>>           max_bytes -= AMDGPU_VM_RESERVED_VRAM;
>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
>> -        pages_per_block = ~0ul;
>> -    } else {
>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -        pages_per_block = HPAGE_PMD_NR;
>> -#else
>> -        /* default to 2MB */
>> -        pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>> -#endif
>> -        pages_per_block = max_t(uint32_t, pages_per_block,
>> -                    tbo->page_alignment);
>> -    }
>> +    pages_per_block =
>> +        amdgpu_vram_mgr_calculate_pages_per_block(tbo, place,
>> +                              bo_flags);
>>         vres = kzalloc(sizeof(*vres), GFP_KERNEL);
>>       if (!vres)
>> @@ -498,7 +514,7 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>       if (place->flags & TTM_PL_FLAG_TOPDOWN)
>>           vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
>> +    if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>           vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>
> And this here just optimizes it in the way that it says try harder to 
> make it look contiguous.
Here I removed the TTM_PL_FLAG_CONTIGUOUS. AFAIU, in both cases (BO 
pinning and normal contiguous request)
this flag AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS is always set.
>
> Question is if that also works with pages_per_block of 2MiB or does 
> that only kick in when pages_per_block is maximal?
AFAIU, if this flag AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS is set, we are 
setting the pages_per_block as maximal, thus
we dont limit the BO. when we set the pages_per_block as maximal, the 
min_block_size would be the tbo->page_alignment,
and this tbo->page_alignment would be the same value as the required 
size. Required size can be less than 2MB or more than 2MB.
Below we have check size >= pages_per_block, when the pages_per_block is 
maximal we don't limit the min_block_size.
>
>>         if (fpfn || lpfn != mgr->mm.size)
>> @@ -529,8 +545,21 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>                          min_block_size,
>>                          &vres->blocks,
>>                          vres->flags);
>> -        if (unlikely(r))
>> +        if (unlikely(r)) {
>> +            if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>> +                !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {
>> +                /* Fallback to non contiguous allocation */
>> +                vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>> +                bo_flags &= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>
> Well I would say that this is a rather hacky implementation and should 
> be avoided if possible.
sure, I will try to rewrite the code.
>
>> +
>> +                pages_per_block =
>> + amdgpu_vram_mgr_calculate_pages_per_block(tbo,
>> +                                          place,
>> +                                          bo_flags);
>
> Rather move the AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS handling out of 
> amdgpu_vram_mgr_calculate_pages_per_block().
sure.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>> +                continue;
>> +            }
>>               goto error_free_blocks;
>> +        }
>>             if (size > remaining_size)
>>               remaining_size = 0;
>

