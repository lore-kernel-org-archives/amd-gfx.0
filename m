Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497A8C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 17:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7739112723;
	Mon, 15 Apr 2024 17:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TgUpwohS";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E12112722
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 17:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+SdTtDZblPbkmnL1OW0GNYk6a4Xm1kTXLXFhZtLr81dy4JIksSKfxgOAEOYt2EACOo/5ApClmlrS4Dggg6jetUVk13XnCU5JjM3tN/dsEL2o9aOSJU+QOYQ/wR5rNJ4IURYs5jbcqGCjcBtIqHOuiVleBeybZHpJkeh+tNS1c3tGMbMEq/8FizY1VUH0tf20sP9Vo3uooPuSbXYrakCM/3fxMeBazy3BH4cwuRe+3TK5gfwtNEgxx01PuFnS4krZul4aoQmjj+zhAqPnt+3VJyjMub8w+/bbqWQn2ZibkUdXyWOeh1zbvYhIFjpN8B9JoyL/oeQ03539sjnoR3OPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDGpn4myRupxFk5i8aWXWdYPL9QuvnNe5QjGGHRBz1k=;
 b=FzOpS3scCa55popW76hJTic+4MPH4pAWfT1tJpv3kNv6wHyPhP8+F17ydq/srspYNTpxH4vSNslUGvFv8WP9AV8mHXtIoUxpYBvV+2Inj1wcJbusVusLZDelx5zDbiQTye22/bnQWWjFBTP5ATDFwCVxwYrERR/6YogYoKNLBVdE2SpKQpRk6AB7lUyC6Y/oK6xrF7a5ddH6LAuBujjobu9xWtvEo1KzwVdmoDHbZAAy99Zd+nG0O95CyP+rwaNyD2hR1uQG3vCZg0Am88lydxio7oRO975pA02MijeFkD6NS52bg8OAWpPAz+n96ia6clxfjh1K0Dzpw0zJDoKcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDGpn4myRupxFk5i8aWXWdYPL9QuvnNe5QjGGHRBz1k=;
 b=TgUpwohSVM7xKUFOqs7xyPvD5rqoM25G9/OpfbMGw/kWYqpKOgOPPZwwELIgyeowp2WtMotuMSnlPjTAQAIUwGgtXlJdey54K4/TBVb8ybHAZ7eVihmKRrUMDWrWF+LHzKKBcQN5A23fTaUFnF/xPEVtdKSb7gCDQptWOsPW2gA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 17:16:44 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 17:16:44 +0000
Message-ID: <77019521-27e4-4ebe-bafe-784bc251ee56@amd.com>
Date: Mon, 15 Apr 2024 22:46:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Modify the contiguous flags behaviour
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 felix.kuehling@amd.com, philip.yang@amd.com
References: <20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com>
 <4f929e29-599a-431e-ab21-768aee8d765a@gmail.com>
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <4f929e29-599a-431e-ab21-768aee8d765a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::7) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c3facc-a04e-48e1-2f8e-08dc5d6fd2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiQNWKNN96UVWzhhl1Wat74Y+tzMJNaFLv6BZuDaBEm1qZfCsZLpQDHJl7ID9YoVfTHwoeT/L4jGgOINXaToIovaQNnsoa4xI1qimshUMWRwM/rubDxn0IZRwtAfc9eKZ/3aaSpQayf6hyrkOvd5IO9OHoplb46zWz3UEHUGANoGaIPHGLxCd6WNVJ21olFTQfCWqy3H1ek+JsbH7EyaUk1akkghjJlrhVEG3RLLYrXiHyrW4e5UQJx+yy/ZS1ss6J84aamav4PUBypIWQJVx7MzEy2i06q962kANYC/KpA1IM4nQz7rDPHT1EFqwNHId5tTqKyYr9exl/NzTF6xEMc/IJ+QY6urngAb5pAOw+iLk2AjL0lfiUpZO15nLg8W/LTyg+6c+nWWBxqKgv8UejKGaFWKTqWWcSHINrVPczXquOnrY/QUUrbmbGy8pPAQ0dv1L2Z5JoG2Cua95FpC1iQQGh/xEC2z8aRQJFMpd8d3f3oPoeA82xo2n7obL8McwnUZ0m7yZ08hu/eY3GduwvlVljZfw+uH207P7BRLA+KPzyCCwOd0sqSiITqjxiqfOPRGCL1AvYqUcChL0fYPyXXlSQ/TBvFdMoY4IZaeTAjlq7fZMDqL+xtllgrVPVj19dtaBE4djPaU60oB3kVdtERJ287DgSeDELVxfViAd9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZUSjgzMENoVm0zTjB3NzB5RGZTb0FDMmRwODFNeFFTb05JN2VrVDlyRkdm?=
 =?utf-8?B?ZDUyRzZEenNLRWVxR1NQSzFVKzVqZEllTWpBSENoVk1kRHl4ZWZWRE5NODRK?=
 =?utf-8?B?VnZsakJBcWtGL21DRVczQ3BqZEdnQnRxUlJLY0dBSXArNHBUUFp3NTN1VmMy?=
 =?utf-8?B?KzVKY0RoR2dsOHJpbHh5TFV3MldVdkNPQU84VUJrQldTeVVhdzNyREppZFdz?=
 =?utf-8?B?WmF6RmJiS3B5UG9vK3cwclgrcUZOQzZFaVQ0ZUNYV096WFRzUGRvdzA3Y05l?=
 =?utf-8?B?RzV2ZUc4cTNYOThLWDRQa1A0clBTbGdzSGRpVHJrSjVoL2NDaHIxRzZhQjZE?=
 =?utf-8?B?aWFIVXpndXEwUW1LL0thckdsaGVMcUNLd0ZXUnNySG1PS3J6RTFVYWdMZWJx?=
 =?utf-8?B?ZGQrQkJHL2lXY0FFNVJpSmdBNkJNc0tqclFJcm85bTB6L3lZa0tjY1pzM09a?=
 =?utf-8?B?bHIrYXM0S2FjYlN4TEY0ZmswSDFNU3VZQmJzZWNnZkpSZ1hZNHM1WDhWY1FZ?=
 =?utf-8?B?VERSanF3bW15eG9xSWtMdWJWdHJ1OGdoUTUyM0NkV2VyeStWZ1Z1c1ZjRHRp?=
 =?utf-8?B?MytVV3hydU9veTZWSEZyV1Y2YlNTNlZVODl0d0VHWHpZVmc0WUgrRGNNTWZh?=
 =?utf-8?B?VXhKMEkvZjkyMDdmaWxLamh4emF2L2phUzg3VzdNb3VLbjZBM3JGUWhla055?=
 =?utf-8?B?M0RVeU41ZUNiYjg4TWpVMitFVDNsU3pxTGVwY2lPTGNtZVVUckJaRDBkWTNL?=
 =?utf-8?B?b1l4bi8xSERYT2t4c3JBTHhJcmNaK283V1V6aEFBa1RLVW9OWTlaWDhQek0z?=
 =?utf-8?B?ek1JTXNLVzdTZkhBMlRoZGFnYnByUzR3VVpVeHMxUVN5U2tjU0d2SmtaaDRl?=
 =?utf-8?B?ZGtMYnZkMmJ0RXJxUTBHTXpQK1VkZUdMNGs2cXJORzdEb1k1SVU2Z0YrbEYw?=
 =?utf-8?B?WHZ2TU9Mblh0bytMQUg3c3BjZ2FDTnlPOUc2MTF4WFNET01rdlIzcWl2N0Zj?=
 =?utf-8?B?QVdhdk53Qjd1VkMxWTFPYUxvRWV0Rmh6NDRCOXcrRmhuUHp1R0o2OFM4Rm9M?=
 =?utf-8?B?eWFXSW1XbFVVMkxTL0R6RVdpREZvQml0MlVsbGRTQ3pQTTFyWklxMG1NUDlq?=
 =?utf-8?B?TEExOTR1czFHUWw5QXIrNXZydkt4WDFvYXdTZUxmS0NKQ2xkeWlNY0hWYlZJ?=
 =?utf-8?B?WFZQUCttamdxZmpiNkNXZUgybnkwT29YUi9sNUxiREtJMVBGUlROZjQvUmg3?=
 =?utf-8?B?ekZGUVVnZWQ0NVd5T0lLcUFqaGszQi9MTXhVNWVjdU5yVm50MWVIWHc3Nm84?=
 =?utf-8?B?LytONFQ2NU54dFpQYmhHTDI3QW44WTNObGFIUHZDNDJyWEVBenl1dHlPYzdw?=
 =?utf-8?B?SEpVYUxKMURVcE9LUVNtQ3dZWXVzVnBSTUtFTHhldUJNVXNMdTVBWGtINERV?=
 =?utf-8?B?dTF4c1lsSlUwQmd2NldnUS9GZmJ1a3V3S25qMDNVeWhTaXpjcnUwakNjcUp5?=
 =?utf-8?B?NHFhczE1dzRLeERhSWpoQjluWUpUUkpLRFQ4V0dXM1pVYkJrY2k1NFVlVnR1?=
 =?utf-8?B?ck5yaEVidnlZSm9ueTdNaHhTa0hWYUhWelNGelBOL0lEYnY5YmJSYnFwRGdE?=
 =?utf-8?B?d0w4anhzdUxxd0taM2JjbGc1UXkvUzhlV0JoZ3o0dGhSbUVOQnFablNWN2Ex?=
 =?utf-8?B?QlRRMjZSNG9tejQrR2IzTVFQY1pQV05FVUhrU3o4UVlZS0ZpY1F3UEFlVXV2?=
 =?utf-8?B?MU9wSkc3a25pQUM4L05MSGp5ZFpCNkpZcWJ6Skh3YzZsSlYyc0trTnh1Z0ls?=
 =?utf-8?B?WlBTYzdYcWFIYXZHYk1TZFFGQ1NNZGhYMEpqb2doRXlHWDh3WHJ1cEgva1pG?=
 =?utf-8?B?cCt6YVVxNitqcEVoQ3lmbzkyUnRMb1JjK3V2ZncvUWVYZ1piTG0vRlFXV2ZZ?=
 =?utf-8?B?N2kzUitpMldxeENiczBPeGdiL2twcWM4bTkyenQrYi9yUGVkaGxieStRb0xm?=
 =?utf-8?B?NTF2L3hjY3JlaU1XQmxJOFoxajFLMytpVklqWjcyZFoyclROb3FLS0RsL29v?=
 =?utf-8?B?VytHaVQ1Mlp0NDRHM3VKQkZHTld1L0cyaEtQZ0czcXYzaTB6WEE2Rm5GeVJy?=
 =?utf-8?Q?8mFT6ay1Uq7XCb1tLaV8w9rqs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c3facc-a04e-48e1-2f8e-08dc5d6fd2ac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 17:16:44.0430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kx0AdwZ+nY/1ehw0BKXTc+gTq6C0wrgFRy9QiRLIoD9OVTO8QJmRuK5ii43ATMz3voCBfzR7XULiTq04/Wja0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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

On 4/15/2024 7:33 PM, Christian König wrote:
> Am 14.04.24 um 16:57 schrieb Arunpravin Paneer Selvam:
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
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   | 14 +++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 +++++++++++++++-----
>>   2 files changed, 49 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 8bc79924d171..41926d631563 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -153,8 +153,6 @@ void amdgpu_bo_placement_from_domain(struct 
>> amdgpu_bo *abo, u32 domain)
>>           else
>>               places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>>   -        if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>> -            places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>           c++;
>>       }
>>   @@ -899,6 +897,8 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>> *bo, u32 domain,
>>   {
>>       struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>       struct ttm_operation_ctx ctx = { false, false };
>> +    struct ttm_place *places = bo->placements;
>> +    u32 c = 0;
>>       int r, i;
>>         if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
>> @@ -921,16 +921,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>> *bo, u32 domain,
>>         if (bo->tbo.pin_count) {
>>           uint32_t mem_type = bo->tbo.resource->mem_type;
>> -        uint32_t mem_flags = bo->tbo.resource->placement;
>>             if (!(domain & amdgpu_mem_type_to_domain(mem_type)))
>>               return -EINVAL;
>>   -        if ((mem_type == TTM_PL_VRAM) &&
>> -            (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) &&
>> -            !(mem_flags & TTM_PL_FLAG_CONTIGUOUS))
>> -            return -EINVAL;
>> -
>
> I think that check here needs to stay.
>
>>           ttm_bo_pin(&bo->tbo);
>>             if (max_offset != 0) {
>> @@ -968,6 +962,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>> *bo, u32 domain,
>>               bo->placements[i].lpfn = lpfn;
>>       }
>>   +    if (domain & AMDGPU_GEM_DOMAIN_VRAM &&
>> +        !WARN_ON(places[c].mem_type != TTM_PL_VRAM))
>> +        places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>> +
>
> This needs to go into the loop directly above as something like this 
> here:
>
> If (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>     bo->placements[i].mem_type == TTM_PL_VRAM)
>         o->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>
> This essentially replaces the removed code in 
> amdgpu_bo_placement_from_domain() and only applies it during pinning.
>
>>       r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>       if (unlikely(r)) {
>>           dev_err(adev->dev, "%p pin failed\n", bo);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 8db880244324..ddbf302878f6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -88,6 +88,30 @@ static inline u64 
>> amdgpu_vram_mgr_blocks_size(struct list_head *head)
>>       return size;
>>   }
>>   +static inline unsigned long
>> +amdgpu_vram_find_pages_per_block(struct ttm_buffer_object *tbo,
>> +                 const struct ttm_place *place,
>> +                 unsigned long bo_flags)
>
> Well I think we need a better name here. "find" usually means we look 
> up something in a data structure. Maybe 
> amdgpu_vram_mgr_calculate_pages_per_block.
>
>> +{
>> +    unsigned long pages_per_block;
>> +
>> +    if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
>> +        place->flags & TTM_PL_FLAG_CONTIGUOUS) {
>> +        pages_per_block = ~0ul;
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
>> @@ -451,8 +475,10 @@ static int amdgpu_vram_mgr_new(struct 
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
>> @@ -468,18 +494,8 @@ static int amdgpu_vram_mgr_new(struct 
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
>> +        amdgpu_vram_find_pages_per_block(tbo, place, bo_flags);
>>         vres = kzalloc(sizeof(*vres), GFP_KERNEL);
>>       if (!vres)
>> @@ -498,7 +514,8 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>       if (place->flags & TTM_PL_FLAG_TOPDOWN)
>>           vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
>> +    if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
>> +        place->flags & TTM_PL_FLAG_CONTIGUOUS)
>>           vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>>         if (fpfn || lpfn != mgr->mm.size)
>> @@ -529,8 +546,20 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>                          min_block_size,
>>                          &vres->blocks,
>>                          vres->flags);
>> -        if (unlikely(r))
>> +        if (unlikely(r)) {
>> +            if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>> +                /* Fallback to non contiguous allocation */
>> +                vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>> +                bo_flags &= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>> +
>> +                pages_per_block =
>> +                    amdgpu_vram_find_pages_per_block(tbo,
>> +                                     place,
>> +                                     bo_flags);
>> +                continue;
>> +            }
>
> Let's talk about that on our weekly call. Might be a bit overkill, but 
> I'm not so deep inside the code any more.
Sure, Thanks.

Regards,
Arun.
>
> But looks quite good actually.
>
> Regards,
> Christian.
>
>>               goto error_free_blocks;
>> +        }
>>             if (size > remaining_size)
>>               remaining_size = 0;
>

