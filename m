Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BFAC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 14:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9F810E653;
	Wed, 17 Apr 2024 14:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kLhl7i42";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA4310EDA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 14:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkWEbYR94toMIKIB4ceaWmOA1QjguGowawwzoX7nEus/r8eDxlH0PPGZNxLndjgCm3xqxmR9mkfbahvNuJJk9aZj8sQXD3v+lMApC2AuCxoW+nIszuHxII4SQauaOStAfC9ciC6SdRxEm8y571Unh6FgZeAuxGgIlCP/rPKUngLUjOx+6Hgbn4QWIXQODKq0Z4nHHlS/5Z21cZf8qjGkk9mTn5Lxkprrpu10GP33BX/ih+NeLBw4KiiRewCadPxmxU7pito6+/3O3sC4VcyCVpIqobaIvzuH9R1jJxxHTnFk8UmSUUspnEraHNNPyIqgfsWvIHQo2fZAwAXZjxBmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCLFbFcf6EAXCGRjO0C1i2AwdOKigcNGIluUEiPO3cU=;
 b=QA9FE7IPW6cl3nKRf3LmZKujMHjzUmkSemF8yFRWNqA8HrAZfsvHwP/I7jYhNvAAXt4bx6QT95so9D1xjtjATBjtPGKHEIe0w0mFozLilEJeoNbSnsTxK3tih2/vvw3YkXWoJVyS9WAvao7T9/Js3r+q3tnq5/BSZr/SD8pc7zX4YcB4ye5P8GRp7BT3cZfD3kgG9ZYDw9nt9TkH9HT5X4G0bFsE/PKdBEnJjC7DnmUqEq2RGz4Kib0QIRk1AqQo5EdatguCPE7Sljm8WidYI5IswbEm7gS7gm8xL14nR+6vAPfd/TOEA8VcuYuHl434k8ZHXFDUlmBowHR1VzNpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCLFbFcf6EAXCGRjO0C1i2AwdOKigcNGIluUEiPO3cU=;
 b=kLhl7i42SxZC8Teeic+zXevNtopirXWyFIBQJGl2NIXi6mw7cOVob7RIBnlyRW71vHy3FvL6t8IrLokNh3xgSICSO8ZdZi6hg56WWbiFaaZ6bMexws2S/ob74oLtlkrf+yrEmPXoxcvHuUESvTjmHR97ZFJRKTZrgGMiqbn6oGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 14:33:08 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:33:08 +0000
Message-ID: <ea5d73f1-0bf9-41a1-95b7-6479ea4c6ad8@amd.com>
Date: Wed, 17 Apr 2024 20:02:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Modify the contiguous flags behaviour
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, philip.yang@amd.com
References: <20240417062121.3779-1-Arunpravin.PaneerSelvam@amd.com>
 <0ebbd37d-1872-4d54-9aa1-842a6090c678@amd.com>
 <b5460307-ce38-4a34-af22-e0936507a3cc@amd.com>
In-Reply-To: <b5460307-ce38-4a34-af22-e0936507a3cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::7) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 5890d1fe-0230-4cd1-4b9d-08dc5eeb4cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NoQTekHbIexI33u5JLzyHP397NXQZxWaW62tLx7CCbF4Fj3/w2E12cGvXRc8USKTxCWcww0taNuI7/W8BvgheOuePOV54ZvjNmfH2pwh74DFPlXlVuwpmdKJGTrUIW0FjZipS2MC83Qa0GRVnLtof9a1CdIvnu8H2YYWjl9r37dP1ywdq3RXUXv8upqUTKMc+EbdMIujKdqfqBERsAmNE9EpdvPrg61HgezVKVuYPRth3j2ZuigJ65sT8qKtT5wRxLcuiun+OXGiHqkPDzo9diNshPr4rfhE3+updwP4gR30k+TjdhG+xXTWtTcjHGSOs8OPEDty5Lugg1dzcelpJVVlh+L74kG4nj+C4CF4rcB3jAQ25pYqCY0kDPd6xHpfp0pjvj+C4+C2IJQdvNyXxFhfYr/bGY0+dqKI7cq0jCtlCNKwPpv7aMgHqCAz22eYDr5EQ+qj2FBEmPcCCsAI75X9Q7Asg6rIoMSCj72BjD2HNUgOaL+bTDJq5loJ40X+r2gWHiylMrcl8vRVV5J1N1RbGwg9SJg8OZVJlVMpjF/Lc+GpH23Uo1ef9QX/P7xQofwrAaQfOMxBS9XkY05vemq601DkjHKR07xz/5Eu0yU0fI8fvqLppLu32fppljQvhKB5GH3ArjP79oLO32eMjqC8a/ifGSMddf14IxTl2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L29WaFgyVk9Ha2F3U0JxSGRhN2xTRHY0amVaQkIrbVFMQ013QzZoa0s2d2dn?=
 =?utf-8?B?ckdwdklrQ0hpaC9JTjNmckdta0lRcGcwbGwzbjg3OE9LVUtYTm9LMUJ3a09r?=
 =?utf-8?B?ZHRXSWNtM3ZlNjZjTnVzazZPbjkzamt0VDhxT1RZQkZSMjFZeENWTmJhR3Rp?=
 =?utf-8?B?dW51UjhpQlhVV3ZEc3Q0RDhpOXBlemUvTVhCQ1JjYWwyNnpnUkN4YXNYRTU4?=
 =?utf-8?B?MDRYSTc2OHQvQlVuSmg0WDZBbHVKUmhlcmFKdENNdlFEVkxpV29ESkgzdHF4?=
 =?utf-8?B?ZlpzOXFGRzEvdkZtWWlhNWNXdC9IRnhCUlRhMkNxZTVEejR0WnBoaGNId2dU?=
 =?utf-8?B?aXJaaklVUkxuWFlPRXRmL3dUYVAzVGRmY1o3Q096OG5NdVRrTnUyRW5EQ2Np?=
 =?utf-8?B?V0QyZFg0TWNBNmp0VnY4Z3dUYnZjczBQYmtCYlBGRmVhdFMwVW5WRXJUR1pw?=
 =?utf-8?B?NGl2czZvNzZCLy9BOW84MTcyZkFla1JXUm9KTFJhY1JRR09Bd0J3dDZuRzlS?=
 =?utf-8?B?N0M5Y20zL0VYYUdpamkwNk9wQnlxMnRTOThFMDlLeTBMOHNGWnp1U0FXZ3Nl?=
 =?utf-8?B?aElTSDlNQ0ppSllvZG5OcHhaTFhXTEtUSlJ3anV2UUtPZWdkMGZlcUtqOVNr?=
 =?utf-8?B?OEtnR25pYm4xZHU1WnM2OTBQam9saFNSMG5qalhVRHlZT0NLY2tQMk93Z2Ix?=
 =?utf-8?B?NDF0SGlLVU1qVkxiRFovcytMRWxzc3BTODh6ZUhkZDB1Rk4vejhqaTNKU3B5?=
 =?utf-8?B?VnFFRmhQRlYrSnlkOC8vcjJSaGxjWGFVZ2NrOUJCenVRemJxNWZPb2xXWDhS?=
 =?utf-8?B?UGxOYU1iUWNwTCs4Risxa2pidmFXWCtwaFh4ZDFqdHFLZ3B3M05yOThXYXpx?=
 =?utf-8?B?ejJYZ0dGSm1DS2RGS1MvYy90VDRrUmkvakVyR2pRaXlQRmpkQ2xkU3VuNjJx?=
 =?utf-8?B?MnNFdE5DNFYyQmtURW1iSFdjUzV3TE1Odk5VRmZlYUVGVHFldkd2M2poUXRo?=
 =?utf-8?B?K3FKNzZjeGl0V3dyd3NleGs2M2FrY2taYkNsSTlEV0I1NUlTUlJiUHdkdUpo?=
 =?utf-8?B?cWdvRGUzNHdrTHpkeGNTaWUyUzdvVTY1Z29jeEFncXF3RUh5UHdWM201UUFq?=
 =?utf-8?B?WUtQSTd5dkNiL2kxUFkzVEFBemxwb1NqRVNTN0t3Z0JDdWlqWkxrMU1vYjdz?=
 =?utf-8?B?MWt3L2M3dU9FQlVyWENnVEZBdjVDS2RydkJmNlIzL0dMMmtQcGNCRnZ2MFZl?=
 =?utf-8?B?UUhlelFpcGt6c1Q1OFFYVGVSbm11RjBqUzdwdENGNTJzdXZBZWVtOEo4dmVB?=
 =?utf-8?B?bE4ydzM1TFBTMEhvYTJ4UC95TXpMU2FZSmIyYlBwUjFrZEN6TTNQTkpGMW1T?=
 =?utf-8?B?MVN1cktLUlNpeUIzNGhZaHJmNittMjl0SjJjbjdwaG5ZNGlLQTBKc0JnMFpJ?=
 =?utf-8?B?ZjQrM2lXZ2xqSXhsMGczUzRWMllzUmdWSC9pNjFRa3BWeXdEeXMwbjBNMmR4?=
 =?utf-8?B?WWZzZkRVTkIrRzFXZmRZcFRRWTBwdXZyVDVObjlYYUtCRm8xRm5jY1RycGpJ?=
 =?utf-8?B?NVNwbUwzZHdLaGRUcWRqV3k3SEVOdFREVmFod3RGcWlDS3ZoeStTamY2enNl?=
 =?utf-8?B?elhRZlEvZWN6Z1FrTjVzeFFlU1M3SnRSSS84TmJFenZsZ2g1U3E5YllLQW56?=
 =?utf-8?B?MU9KY2lDV1VyaXk4cTlzdklqWGlRdGlZZVdZMytiZHBUaFgrUnU5UkZ4T21T?=
 =?utf-8?B?VFJ0aUEvNG9aWTV1WWVvRzN2MVlpcWNqb2NwRUJGRlBySERNdVpselZZQWxD?=
 =?utf-8?B?Yzg2ZDRKeDFVL09qbmVDRWhTS25meTQzTXdnNFlzaldSQTBDdXErSWgxUkJX?=
 =?utf-8?B?WTBBSmY2dlBNYUpRWUROTkErdHRBcW5yb2lRTjBPRUZLOVo3dThPU0hVSkJ4?=
 =?utf-8?B?ZndZQS9RQVpqdU54YzJaYlI4WWV6ZlU2RmtEU0tvaU5XNDNrN1p0ai9WK1Y0?=
 =?utf-8?B?blpxb3NjZm05MG1MMXNCdnZOcG9zU0xIOWsvZ1NOQWtydVB4bGVmM1M4YWk0?=
 =?utf-8?B?eTV2OVIyOGFyYjV6Y1lZK2hwcENtb0xLaXhYQUF3VERJZm8yd0tETkNEWW15?=
 =?utf-8?Q?ak8DKkNVhJwqdqlDZhw6q2MRK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5890d1fe-0230-4cd1-4b9d-08dc5eeb4cc4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:33:08.1200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N25m+TtbkCegD2SfjCuHlvoj8WZa3ySbHUhUmcODCNexCkoF00oiaosb3+Mdrz+w7XM4trqKpWb1vU7Uh+WDJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798
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

On 4/17/2024 6:57 PM, Paneer Selvam, Arunpravin wrote:
> Hi Christian,
>
> On 4/17/2024 12:19 PM, Christian König wrote:
>> Am 17.04.24 um 08:21 schrieb Arunpravin Paneer Selvam:
>>> Now we have two flags for contiguous VRAM buffer allocation.
>>> If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
>>> it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
>>> buffer's placement function.
>>>
>>> This patch will change the default behaviour of the two flags.
>>>
>>> When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
>>> - This means contiguous is not mandatory.
>>> - we will try to allocate the contiguous buffer. Say if the
>>>    allocation fails, we fallback to allocate the individual pages.
>>>
>>> When we setTTM_PL_FLAG_CONTIGUOUS
>>> - This means contiguous allocation is mandatory.
>>> - we are setting this in amdgpu_bo_pin_restricted() before bo 
>>> validation
>>>    and check this flag in the vram manager file.
>>> - if this is set, we should allocate the buffer pages contiguously.
>>>    the allocation fails, we return -ENOSPC.
>>>
>>> v2:
>>>    - keep the mem_flags and bo->flags check as is(Christian)
>>>    - place the TTM_PL_FLAG_CONTIGUOUS flag setting into the
>>>      amdgpu_bo_pin_restricted function placement range iteration
>>>      loop(Christian)
>>>    - rename find_pages with amdgpu_vram_mgr_calculate_pages_per_block
>>>      (Christian)
>>>    - Keep the kernel BO allocation as is(Christain)
>>>    - If BO pin vram allocation failed, we need to return -ENOSPC as
>>>      RDMA cannot work with scattered VRAM pages(Philip)
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  8 ++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 
>>> +++++++++++++++-----
>>>   2 files changed, 50 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 8bc79924d171..caaef7b1df49 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -153,8 +153,10 @@ void amdgpu_bo_placement_from_domain(struct 
>>> amdgpu_bo *abo, u32 domain)
>>>           else
>>>               places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>>>   -        if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>> +        if (abo->tbo.type == ttm_bo_type_kernel &&
>>> +            flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>>               places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>> +
>>>           c++;
>>>       }
>>>   @@ -966,6 +968,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>>> *bo, u32 domain,
>>>           if (!bo->placements[i].lpfn ||
>>>               (lpfn && lpfn < bo->placements[i].lpfn))
>>>               bo->placements[i].lpfn = lpfn;
>>> +
>>> +        if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>>> +            bo->placements[i].mem_type == TTM_PL_VRAM)
>>> +            bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>>       }
>>>         r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>
>> Nice work, up till here that looks exactly right as far as I can see.
>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> index 8db880244324..4be8b091099a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> @@ -88,6 +88,29 @@ static inline u64 
>>> amdgpu_vram_mgr_blocks_size(struct list_head *head)
>>>       return size;
>>>   }
>>>   +static inline unsigned long
>>> +amdgpu_vram_mgr_calculate_pages_per_block(struct ttm_buffer_object 
>>> *tbo,
>>> +                      const struct ttm_place *place,
>>> +                      unsigned long bo_flags)
>>> +{
>>> +    unsigned long pages_per_block;
>>> +
>>> +    if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>>> +        pages_per_block = ~0ul;
>>
>> If I understand it correctly this here enforces the allocation of a 
>> contiguous buffer in the way that it says we should have only one 
>> giant page for the whole BO.
> yes, for contiguous we don't have the 2MB limit, hence we are setting 
> to maximum to avoid restricting the min_block_size to 2MB limitation.
>>
>>> +    } else {
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +        pages_per_block = HPAGE_PMD_NR;
>>> +#else
>>> +        /* default to 2MB */
>>> +        pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>>> +#endif
>>> +        pages_per_block = max_t(uint32_t, pages_per_block,
>>> +                    tbo->page_alignment);
>>> +    }
>>> +
>>> +    return pages_per_block;
>>> +}
>>> +
>>>   /**
>>>    * DOC: mem_info_vram_total
>>>    *
>>> @@ -451,8 +474,10 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>       struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>>>       struct amdgpu_device *adev = to_amdgpu_device(mgr);
>>>       u64 vis_usage = 0, max_bytes, min_block_size;
>>> +    struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>>       struct amdgpu_vram_mgr_resource *vres;
>>>       u64 size, remaining_size, lpfn, fpfn;
>>> +    unsigned long bo_flags = bo->flags;
>>>       struct drm_buddy *mm = &mgr->mm;
>>>       struct drm_buddy_block *block;
>>>       unsigned long pages_per_block;
>>> @@ -468,18 +493,9 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>       if (tbo->type != ttm_bo_type_kernel)
>>>           max_bytes -= AMDGPU_VM_RESERVED_VRAM;
>>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
>>> -        pages_per_block = ~0ul;
>>> -    } else {
>>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> -        pages_per_block = HPAGE_PMD_NR;
>>> -#else
>>> -        /* default to 2MB */
>>> -        pages_per_block = 2UL << (20UL - PAGE_SHIFT);
>>> -#endif
>>> -        pages_per_block = max_t(uint32_t, pages_per_block,
>>> -                    tbo->page_alignment);
>>> -    }
>>> +    pages_per_block =
>>> +        amdgpu_vram_mgr_calculate_pages_per_block(tbo, place,
>>> +                              bo_flags);
>>>         vres = kzalloc(sizeof(*vres), GFP_KERNEL);
>>>       if (!vres)
>>> @@ -498,7 +514,7 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>       if (place->flags & TTM_PL_FLAG_TOPDOWN)
>>>           vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>>>   -    if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
>>> +    if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>>>           vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>>
>> And this here just optimizes it in the way that it says try harder to 
>> make it look contiguous.
> Here I removed the TTM_PL_FLAG_CONTIGUOUS. AFAIU, in both cases (BO 
> pinning and normal contiguous request)
> this flag AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS is always set.
>>
>> Question is if that also works with pages_per_block of 2MiB or does 
>> that only kick in when pages_per_block is maximal?
> AFAIU, if this flag AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS is set, we are 
> setting the pages_per_block as maximal, thus
> we dont limit the BO. when we set the pages_per_block as maximal, the 
> min_block_size would be the tbo->page_alignment,
> and this tbo->page_alignment would be the same value as the required 
> size. Required size can be less than 2MB or more than 2MB.
> Below we have check size >= pages_per_block, when the pages_per_block 
> is maximal we don't limit the min_block_size.
a small correction, when we set the pages_per_block as maximal, we don't 
set the min_block_size, the buddy allocator will set the min_block_size
as roundup_pow_of_two(size).

Thanks,
Arun.
>>
>>>         if (fpfn || lpfn != mgr->mm.size)
>>> @@ -529,8 +545,21 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>                          min_block_size,
>>>                          &vres->blocks,
>>>                          vres->flags);
>>> -        if (unlikely(r))
>>> +        if (unlikely(r)) {
>>> +            if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>>> +                !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {
>>> +                /* Fallback to non contiguous allocation */
>>> +                vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>>> +                bo_flags &= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>
>> Well I would say that this is a rather hacky implementation and 
>> should be avoided if possible.
> sure, I will try to rewrite the code.
>>
>>> +
>>> +                pages_per_block =
>>> + amdgpu_vram_mgr_calculate_pages_per_block(tbo,
>>> +                                          place,
>>> +                                          bo_flags);
>>
>> Rather move the AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS handling out of 
>> amdgpu_vram_mgr_calculate_pages_per_block().
> sure.
>
> Thanks,
> Arun.
>>
>> Regards,
>> Christian.
>>
>>> +                continue;
>>> +            }
>>>               goto error_free_blocks;
>>> +        }
>>>             if (size > remaining_size)
>>>               remaining_size = 0;
>>
>

