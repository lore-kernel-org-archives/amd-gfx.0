Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F222CA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 23:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A98F89B78;
	Tue,  6 Oct 2026 23:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fMuanwZV";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DD1892D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 23:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5tO2+xFetVnb5liTAID8iR6ncPQ0XDRuUYlIxIpXVupJgXCURxr5bs+qcB1O3Atp4or9pcDDrNIn/lBbAkIa9+YiiYl3Mm21dzgeBWHzJu098EBJDdp94Tmc/Fjk9Hji4Q7o8vlsG1qaflt+6+ZiPJ+AovYLPAClk1WrjT3z9u6XHZVPnwGzFsj1tvF23zBn6UY2LHCmHa31fxnRfaSecXMmAlu9Lc4dR2sNt19cXMy334fDVzL9q2vZMlPIyNN5pFKPeG8vePK4e6j0K45Ug06HawgdlA5KTGHFObcE5jRBBnBGa/EKKQWMTnoPGFlehEg+eKHYGdDMqLZTkixiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1PZOKx24OofSbP5QZOLRJEuoDCbBGKCloFWoYVsCbo=;
 b=b6XfGuOl50iArF6jxx8LlArawOj/u13joJa7jJsv4yMqNEYfJenR7bKSPovK9Nn6U8K5vpBt3k7SxTzqUS0VBJ4ZLcrFTrImGTb4bx4Kl4u7g92QlKsk+tIAE/CHvBhR+UmL6rSmRieLtB5cLuvxgaXZHGvR4MgJmcMc9K0Gnic0DKe9a4uCOn0pSnt/NKnaVKwIq0sGWdQTstic9RTEtUrYZ/vIfyIOV4tuJ1Yq6GkhsGrxKSYwGc5rKLJE93DQ9BhQ2q0cvhd2y19z9ziBKFzAEtCvor/9he5hBJBNr8Hjc68Vz8Nf89FFxwrmuc14N9nKtIJgEj4LqqjQ84FkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1PZOKx24OofSbP5QZOLRJEuoDCbBGKCloFWoYVsCbo=;
 b=fMuanwZVKVxEQbXf18lJTKoHha/l7FZm6pH5qhy1nWIrg94cR7uT1HqewopleQtqeBCAF3v92V6ZbL7j3jdtRb5GqRTooRkSBuBR9pSHtBOpsyYrQuoIft27GgWh3446n8tajGcEuaKvhtcZG51NeD02xz7xMSBw+sAnwNjzV9k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ0PR12MB7034.namprd12.prod.outlook.com
 (2603:10b6:a03:449::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 23:01:54 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 23:01:53 +0000
Content-Type: multipart/alternative;
 boundary="------------2Ee0wpcuSnQPn1Cc4W7ZWneD"
Message-ID: <f060c415-4538-43bc-ade1-22db64e05736@amd.com>
Date: Tue, 6 Oct 2026 19:01:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/amdkfd: Add awareness of THP of device and
 system RAM in kfd svm driver
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260904195421.42919-1-xiaogang.chen@amd.com>
 <20260904195421.42919-2-xiaogang.chen@amd.com>
 <225421e2-3ab1-4c6c-b229-6c59dcb4bcbc@amd.com>
 <73bea04f-27ee-48dc-842b-3c0ba08eb062@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <73bea04f-27ee-48dc-842b-3c0ba08eb062@amd.com>
X-ClientProxiedBy: YQZPR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::13) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 98275315-2dbc-45da-1433-08df23fdd01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: HSz7IgDItbtajEBcZtbyivvtKrwbPjca9z5fYjKPka7bQYJTooc5KYh1suxdY7sqq5a74PJNtf19lRddFpQdVhbXtsMxEOErfVyaOwcoLKn7nO76tF64HStYxq0S+upG9QY1xhxE0fBpHLLJGeyZEKszF8/yyY9Z52RG4utdWfp6kFFwwM3/jdQpzzdiwrgHKrrudFygXNpN/bU2bHUNupscZG8vOtwcKCp3//haNHWgLh4JevM85gQlXiGFcWwhgWBupYgaz5vQ8tFNxyfiZoMlBGrGaKpClra6RrTvdRVp6JNDz2vxDAMqx2jn6E5GORqkCGDqo4IrUdOg1laFKBCiaPFQWYxBDT7Vg+ji2lFAaB1dIpkAb72+5fe3HM+igT1DL6fSHuaXNR0FIL9qYYAiSg28PSPrStYEBsb/CH1IVjCBTmjTBoczI3TDqur9zPUlW3TL9V+IjtxTuCmnJxAWdNBMpelZe7BGoGARSeiEisCfMfbvnIV3mpPTUz4HSDW4VgNUkTlrzFVWEXAo3xfseXUo/6WnOtv9nY7luUwTjjnRHGshRShf4f78Iqm21K8ZKP16yKG5ZY5M+u+KfgTs1dce8XzaIG4iNF/ZyPyIdLfhHcAuFY9xccmi2J0351hkMM2ZZ7lWvk3Kpgd9D8tx9zGFe0EIHCRVO9PUtR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjE4RHV0N2E3VTdXVTRQaks5TTVicDd0U2tKNU5XM0tDMlRxVEpnOU5yMXIw?=
 =?utf-8?B?R2kvdmJkTEdhUkpDQVRqNDFBWGlLYyt4RTdKSHd3eFRGa3hjeTFuUnc5aXFs?=
 =?utf-8?B?YnFtM1lWTlJEVGVkOHJlbWJXSzNaeVFjNStLQ0Q3QmtIMlJKNHN6a0d0cDRL?=
 =?utf-8?B?TmxJNnM5MkNyNmV6MjNkMVRTSnZkRnQzbXh1S1QwTFdBV1dnZW9TTmI1ajVB?=
 =?utf-8?B?MDZwWEhOb0VGOFcyVjUrUDFFdStLS3Irb0dvMzkyc2xCTlNyNmY4SXJ0R3lk?=
 =?utf-8?B?M2xUdlpBT1g0emduN0dleVVNMGFpREtNTjhpdWdhSE9FaGd3dUpnVG1BRWMy?=
 =?utf-8?B?ZEhMdkxHcEEva2pLOHpOZmM0cTVIa2N4K3hnM2N0NkhUYU5yWjd0bC91VVk5?=
 =?utf-8?B?NEFqckRrcVJNdjBLcWkwL25rSHk3TkRPQ3AvcVI0UGxCbnVYNGhBdjRsVWF6?=
 =?utf-8?B?SEJZbzFIRnNieU0rWW5sWXIrWU45bGJzVi9WQWNMNkN4dE9qaWQwYXRiNUFB?=
 =?utf-8?B?YmhPRi93RzR2MUtBT3NGOEgvTlc1VDVMSmUvU2ltRmZJVEwxRDFxSnRKbnho?=
 =?utf-8?B?OXBrOXlOc0pra0lHcDJoSjJHNHBoNWJlamZMNFF0VTAvZnQ4Y216eUhwV1F4?=
 =?utf-8?B?TTBrT1BMSVpxaUVIQjRacG01UGFTNGxRdTc4NzNTcmQwd1Q5MU1LREltMEdC?=
 =?utf-8?B?OEdoR0tpdWpEM25BNU5JbXhhZmxKL1NjbC91bnlGK3o5c3c3WFVYTFJkOURL?=
 =?utf-8?B?bVA4MU5pc01iaGdhWW9ZY01SSWtnR3pxQlZ1a2xiejZHWU15RmRYVzhqanBG?=
 =?utf-8?B?S3lZYncvM1RUUmtqRTNvSTVLZExNa2dKSmZXaHQxVjNxdnc0K1NaUHVTV052?=
 =?utf-8?B?blcxS2NzblIxZHlnZ3IxTDFUTkZVdlFKOVdUQkY4NmczK1VIVjRzTnV2VExN?=
 =?utf-8?B?amwzUERFaUdvZFdCQ3BGek9xQ2pROFJGYmN5dll3Qmt6ZTIrTVdOY1cxZlJq?=
 =?utf-8?B?b3R0a3FmWmpnQnM3TkFrOWx5N1Q2WUlZMUpRVFpDSDdxL2R6WExCVWNqQ3NZ?=
 =?utf-8?B?SGVwT3pLeXE3M1JyYVBoY0lFeFpSakJTaCtYV2JIbmlzSGxVc1hXRGFPMnVx?=
 =?utf-8?B?THlwQ3M1NWtuZ250MERsc0hnQWN3Lyt1b0NLYVBLL0w1eHBtaDE5VkNnSzR4?=
 =?utf-8?B?Ry9nQ0gvWHRwYjhIZ0tibXRkU3dLQWQydXNOT1BLRWxvaFFnbXVCblBkY0Vz?=
 =?utf-8?B?NnZkN3VWUmlDa0ZZTE9PWW5sbkt0SktnMzNQSHR0Vi9FTEppcG5QREhnNDFW?=
 =?utf-8?B?a0wzczhWRjl1WGJ4RlV3eGwxRHJQaFp5dGlUTFVyNnBnejBTWWl3R0N5ak41?=
 =?utf-8?B?aUorR3ZNSUk5bmdNaVpkeENqMlFtNHlVNlV1eEhQT2ZXelM3V002SUpsRHUv?=
 =?utf-8?B?VFQwWi80Y2t0V09Cb3BUQlpHa2JLR2ZYWEpWZHhlT0k0TENnbWtLRXNIZ3Vs?=
 =?utf-8?B?eEhiNUU2ekt5SlpaOE9mSWlYaDY5M0p5czBjU0dwUjZpTVJONUZqekhSdUJt?=
 =?utf-8?B?SDJJV3BnWi8wK01ndjgxMk5TNUt3a1VLVEp0SE5nbHJxaUM5RFVJaVpPV29n?=
 =?utf-8?B?K3o3L2ErQmJvZmdQU21CSElXUUlDdUhrR2hKd0RwSXlYUHpoYkl1WFo4eGFQ?=
 =?utf-8?B?QVRJR21wTkVHbHozY2ZWbVlMQlhZRUZ4TmJHRW9HZlR6R2hFV0p5cU41a3hs?=
 =?utf-8?B?ZThtdmYxeVlzak5uNkRMSTlJNE5vc0lhSTdrNVlockd4V0Q0cXNQSXY0eTIw?=
 =?utf-8?B?NXExSjRJNDUwM2hZSFJWZjJMeFJBZUZ2QmZlM2h3K1c5Zm9ZU0pMSXhxdGNW?=
 =?utf-8?B?MXVRSFhmTHU1RlQzQTgwbzBwYXByNVR3SDB5T2IyZGIvSFNRbmdsY2NsS0xM?=
 =?utf-8?B?NGFXd0YvaVAzTlFXb1ZCWFRkTW9LUlV4TlN6Qkd4Y0VORXhQMWxmd1ZtSWhV?=
 =?utf-8?B?SHN3L25LeWZvZXVqRnZvUzRWUnVGN21xMTduUmVBSFFhbzdnZ0lmUVBmU3dQ?=
 =?utf-8?B?cjU5UDZGUjFtaE5FbGJSb2c5ZU1CMTVwbUpQbmpMSFRaMld1dXpFcE03azU3?=
 =?utf-8?B?R0Nkam9wV0wzWlVtQzhGL2s3bVlBT05MWVhiTGRjOWFXa1RqQ2dNUDZxNEdG?=
 =?utf-8?B?VFU2bmpFcVMxU1R1bko2aS9NNFNPNzNuTDNmQmVsMU9OdHRuc0huZ1RMRWZB?=
 =?utf-8?B?QTNnUzVvelBha3MrSXhsdTd0WmszaUJWTW9jY0lrTll4cHJDeW92b0taeUNW?=
 =?utf-8?B?dmxSMlJCNU16dllmalNOb1RqS0VZZUF0TEt5Ym9IMzY5ZWNxenVsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98275315-2dbc-45da-1433-08df23fdd01c
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 23:01:53.6980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1fHa8Gl5wiLh4Ky6yOkQwz2WH2AQq9DQeQXWoPyFLbetCyI3x12RbaZg6vhUsrZKn/Q2yDB6N1n+dJl2UfOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
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

--------------2Ee0wpcuSnQPn1Cc4W7ZWneD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-10-06 18:49, Chen, Xiaogang wrote:
>
> On 10/6/2026 4:40 PM, Felix Kuehling wrote:
>> On 2026-09-04 15:54, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> Extend kfd/svm function to allocate HPAGE_PMD_SIZE based device 
>>> memory by buddy
>>> allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned and to 
>>> allocate THP
>>> system ram by vma_alloc_folio.
>>>
>>> Introduce SVM_RANGE_DMA_THP flag that indicates dma map of THP. THP dma
>>> addresss will use this flag.
>>>
>>> Add dev_pagemap_ops->folio_split callback that is called by 
>>> folio_split when
>>> core MM splits device memory folio.
>>>
>>> These are preparations for following support for (THP) migration of 
>>> zone
>>> device-private memory, no function change.
>>>
>>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 50 
>>> +++++++++++++++++++-----
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 15 +++++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
>>>   3 files changed, 54 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index 253365a8257e..813f3c1d29dc 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -217,14 +217,19 @@ svm_migrate_addr_to_pfn(struct amdgpu_device 
>>> *adev, unsigned long addr)
>>>   }
>>>     static void
>>> -svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
>>> +svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
>>> +               int order)
>>>   {
>>>       struct page *page;
>>> +    struct folio *folio;
>>>         page = pfn_to_page(pfn);
>>> +    folio = page_folio(page);
>>> +
>>> +    zone_device_folio_init(folio, folio->pgmap, order);
>>> +
>>> +    folio_set_zone_device_data(folio, prange->svm_bo);
>>
>> I see that folio_set_zone_device_data checks that folio is 
>> device_private. This will fail for device_coherent pages. We can't 
>> use this function without breaking MI200 A+A.
>
> Yes, I was looking if this work has changes that can affect 
> device_coherent. It is one of them. This work is for GPU with device 
> private memory by now. I will change this part to:
>
> if (folio_is_device_private(folio))
>     folio_set_zone_device_data(folio, prange->svm_bo);
> else
>     folio->page.zone_device_data = prange->svm_bo;

Then you're effectively just duplicating the check for device_private, 
and then bypassing it if it fails. I think we should just use

	folio->page.zone_device_data = prange->svm_bo;

If we want a check, we can do

	if (folio_is_device_private(folio) || folio_is_device_coherent(folio))
		folio->page.zone_device_data = prange->svm_bo;

Ideally we'd fix folio_set_zone_device_data to do just that, but we'd 
need to keep this hack in our DKMS code to work with older kernels.

Regards,
   Felix


>
>>
>>
>>> svm_range_bo_ref(prange->svm_bo);
>>> -    page->zone_device_data = prange->svm_bo;
>>> -    zone_device_page_init(page, page_pgmap(page), 0);
>>>   }
>>>     static void
>>> @@ -247,11 +252,17 @@ svm_migrate_addr(struct amdgpu_device *adev, 
>>> struct page *page)
>>>   }
>>>     static struct page *
>>> -svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long 
>>> addr)
>>> +svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long 
>>> addr,
>>> +              unsigned long order)
>>>   {
>>>       struct page *page;
>>>   -    page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
>>> +    if (order)
>>> +        page = folio_page(vma_alloc_folio(GFP_HIGHUSER,
>>> +                          order, vma, addr), 0);
>>> +    else
>>> +        page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
>>> +
>>>       if (page)
>>>           lock_page(page);
>>>   @@ -265,8 +276,12 @@ static unsigned long 
>>> svm_migrate_successful_pages(struct migrate_vma *migrate)
>>>         for (i = 0; i < migrate->npages; i++) {
>>>           if (migrate->dst[i] & MIGRATE_PFN_VALID &&
>>> -            migrate->src[i] & MIGRATE_PFN_MIGRATE)
>>> -            mpages++;
>>> +            migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>>> +                if (migrate->dst[i] & MIGRATE_PFN_COMPOUND)
>>> +                    mpages += HPAGE_PMD_NR;
>>> +                else
>>> +                    mpages++;
>>> +            }
>>
>> Please fix the indentation.  This is one tab too deep. The alignment 
>> of the condition should remain unchanged.
> ok
>>
>>
>>>       }
>>>       return mpages;
>>>   }
>>> @@ -300,7 +315,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>           if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>>>               dst[i] = cursor.start + (j << PAGE_SHIFT);
>>>               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>> -            svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>> +            svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
>>>               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>               mpages++;
>>>           }
>>> @@ -568,6 +583,7 @@ svm_migrate_ram_to_vram(struct svm_range 
>>> *prange, uint32_t best_loc,
>>>       return r < 0 ? r : 0;
>>>   }
>>>   +/* folio can be compound folio or single page */
>>>   static void svm_migrate_folio_free(struct folio *folio)
>>>   {
>>>       struct page *page = &folio->page;
>>> @@ -630,7 +646,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>               j = 0;
>>>           }
>>>   -        dpage = svm_migrate_get_sys_page(migrate->vma, addr);
>>> +        dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
>>>           if (!dpage) {
>>>               pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>>>                    prange->svms, prange->start, prange->last);
>>> @@ -1033,9 +1049,25 @@ static vm_fault_t svm_migrate_to_ram(struct 
>>> vm_fault *vmf)
>>>       return r ? VM_FAULT_SIGBUS : 0;
>>>   }
>>>   +static void svm_migrate_folio_split(struct folio *head, struct 
>>> folio *tail)
>>> +{
>>> +    struct svm_range_bo *svm_bo;
>>> +
>>> +    if (tail == NULL)
>>> +        return;
>>> +
>>> +    tail->pgmap = head->pgmap;
>>> +    tail->mapping = head->mapping;
>>> +
>>> +    svm_bo = folio_zone_device_data(head);
>>> +    folio_set_zone_device_data(tail, svm_bo);
>>> +    svm_range_bo_ref(svm_bo);
>>> +}
>>> +
>>>   static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
>>>       .folio_free        = svm_migrate_folio_free,
>>>       .migrate_to_ram        = svm_migrate_to_ram,
>>> +    .folio_split        = svm_migrate_folio_split,
>>>   };
>>>     /* Each VRAM page uses sizeof(struct page) on system memory */
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index fa4054d51f60..6b783d12bce4 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -245,7 +245,16 @@ void svm_range_dma_unmap_dev(struct device 
>>> *dev, dma_addr_t *dma_addr,
>>>           if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>>>               continue;
>>>           pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> 
>>> PAGE_SHIFT);
>>> -        dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
>>> +
>>> +        /* dma unmap of THP */
>>> +        if (dma_addr[i] & SVM_RANGE_DMA_THP) {
>>> +
>>
>> Unnecessary empty line.
>>
>>
> ok
>>> +            dma_addr[i] &= ~SVM_RANGE_DMA_THP;
>>> +            dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*HPAGE_PMD_NR,
>>> +                                   DMA_BIDIRECTIONAL);
>>> +        } else
>>> +            dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
>>
>> The else-branch should also use {} braces if the if-branch does.
> ok
>>
>>
>>> +
>>>           dma_addr[i] = 0;
>>>       }
>>>   }
>>> @@ -578,10 +587,10 @@ svm_range_vram_node_new(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>       }
>>>         memset(&bp, 0, sizeof(bp));
>>> -    bp.size = prange->npages * PAGE_SIZE;
>>> +    bp.size = ALIGN(prange->npages * PAGE_SIZE, HPAGE_PMD_SIZE);
>>
>> This wastes memory for small ranges. Maybe guard this so it only 
>> applies to ranges that are larger than HPAGE_PMD_NR pages.
>
> I am think this too. The waste is 2MB at most instead of current 4KB. 
> I will change allocation size/aliment according to request size.
>
> Regards
>
> Xiaogang
>
>>
>>
>>>       bp.bo_ptr_size = sizeof(struct svm_range_bo);
>>>       bp.destroy = svm_range_bo_destroy;
>>> -    bp.byte_align = PAGE_SIZE;
>>> +    bp.byte_align = HPAGE_PMD_SIZE;
>>
>> Same as above. There is no need to align smaller allocations.
>>
>> Regards,
>>   Felix
>>
>>
>>>       bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>       bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>>>       bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> index c7d7adae4476..f2b3a05cd8cf 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> @@ -35,6 +35,7 @@
>>>   #include "kfd_priv.h"
>>>     #define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
>>> +#define SVM_RANGE_DMA_THP (1UL << 1)
>>>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>>>               ((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
--------------2Ee0wpcuSnQPn1Cc4W7ZWneD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-10-06 18:49, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:73bea04f-27ee-48dc-842b-3c0ba08eb062@amd.com">
      <br>
      On 10/6/2026 4:40 PM, Felix Kuehling wrote:
      <br>
      <blockquote type="cite">On 2026-09-04 15:54, Xiaogang.Chen wrote:
        <br>
        <blockquote type="cite">From: Xiaogang Chen
          <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
          <br>
          <br>
          Extend kfd/svm function to allocate HPAGE_PMD_SIZE based
          device memory by buddy
          <br>
          allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned and
          to allocate THP
          <br>
          system ram by vma_alloc_folio.
          <br>
          <br>
          Introduce SVM_RANGE_DMA_THP flag that indicates dma map of
          THP. THP dma
          <br>
          addresss will use this flag.
          <br>
          <br>
          Add dev_pagemap_ops-&gt;folio_split callback that is called by
          folio_split when
          <br>
          core MM splits device memory folio.
          <br>
          <br>
          These are preparations for following support for (THP)
          migration of zone
          <br>
          device-private memory, no function change.
          <br>
          <br>
          Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 50
          +++++++++++++++++++-----
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 15 +++++--
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
          <br>
          &nbsp; 3 files changed, 54 insertions(+), 12 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          index 253365a8257e..813f3c1d29dc 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          <br>
          @@ -217,14 +217,19 @@ svm_migrate_addr_to_pfn(struct
          amdgpu_device *adev, unsigned long addr)
          <br>
          &nbsp; }
          <br>
          &nbsp; &nbsp; static void
          <br>
          -svm_migrate_get_vram_page(struct svm_range *prange, unsigned
          long pfn)
          <br>
          +svm_migrate_get_vram_page(struct svm_range *prange, unsigned
          long pfn,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int order)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *page;
          <br>
          +&nbsp;&nbsp;&nbsp; struct folio *folio;
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page = pfn_to_page(pfn);
          <br>
          +&nbsp;&nbsp;&nbsp; folio = page_folio(page);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; zone_device_folio_init(folio, folio-&gt;pgmap, order);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; folio_set_zone_device_data(folio, prange-&gt;svm_bo);
          <br>
        </blockquote>
        <br>
        I see that folio_set_zone_device_data checks that folio is
        device_private. This will fail for device_coherent pages. We
        can't use this function without breaking MI200 A+A.
        <br>
      </blockquote>
      <br>
      Yes, I was looking if this work has changes that can affect
      device_coherent. It is one of them. This work is for GPU with
      device private memory by now. I will change this part to:
      <br>
      <br>
      if (folio_is_device_private(folio))
      <br>
      &nbsp; &nbsp; folio_set_zone_device_data(folio, prange-&gt;svm_bo);
      <br>
      else
      <br>
      &nbsp; &nbsp; folio-&gt;page.zone_device_data = prange-&gt;svm_bo;</blockquote>
    <p>Then you're effectively just duplicating the check for
      device_private, and then bypassing it if it fails. I think we
      should just use&nbsp;</p>
    <pre>	folio-&gt;page.zone_device_data = prange-&gt;svm_bo;</pre>
    <p>If we want a check, we can do</p>
    <pre>	if (folio_is_device_private(folio) || folio_is_device_coherent(folio))
		folio-&gt;page.zone_device_data = prange-&gt;svm_bo;

</pre>
    <p>Ideally we'd fix folio_set_zone_device_data to do just that, but
      we'd need to keep this hack in our DKMS code to work with older
      kernels.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:73bea04f-27ee-48dc-842b-3c0ba08eb062@amd.com"><br>
      <blockquote type="cite">
        <br>
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          svm_range_bo_ref(prange-&gt;svm_bo);
          <br>
          -&nbsp;&nbsp;&nbsp; page-&gt;zone_device_data = prange-&gt;svm_bo;
          <br>
          -&nbsp;&nbsp;&nbsp; zone_device_page_init(page, page_pgmap(page), 0);
          <br>
          &nbsp; }
          <br>
          &nbsp; &nbsp; static void
          <br>
          @@ -247,11 +252,17 @@ svm_migrate_addr(struct amdgpu_device
          *adev, struct page *page)
          <br>
          &nbsp; }
          <br>
          &nbsp; &nbsp; static struct page *
          <br>
          -svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned
          long addr)
          <br>
          +svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned
          long addr,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long order)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *page;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
          <br>
          +&nbsp;&nbsp;&nbsp; if (order)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page = folio_page(vma_alloc_folio(GFP_HIGHUSER,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; order, vma, addr), 0);
          <br>
          +&nbsp;&nbsp;&nbsp; else
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
          <br>
          +
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (page)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock_page(page);
          <br>
          &nbsp; @@ -265,8 +276,12 @@ static unsigned long
          svm_migrate_successful_pages(struct migrate_vma *migrate)
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; migrate-&gt;npages; i++) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (migrate-&gt;dst[i] &amp; MIGRATE_PFN_VALID
          &amp;&amp;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE)
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages++;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (migrate-&gt;dst[i] &amp;
          MIGRATE_PFN_COMPOUND)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += HPAGE_PMD_NR;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages++;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
        </blockquote>
        <br>
        Please fix the indentation.&nbsp; This is one tab too deep. The
        alignment of the condition should remain unchanged.
        <br>
      </blockquote>
      ok
      <br>
      <blockquote type="cite">
        <br>
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mpages;
          <br>
          &nbsp; }
          <br>
          @@ -300,7 +315,7 @@ svm_migrate_copy_to_vram(struct kfd_node
          *node, struct svm_range *prange,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
          svm_migrate_addr_to_pfn(adev, dst[i]);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
          migrate-&gt;dst[i]);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
          migrate-&gt;dst[i], 0);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
          migrate_pfn(migrate-&gt;dst[i]);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages++;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          @@ -568,6 +583,7 @@ svm_migrate_ram_to_vram(struct svm_range
          *prange, uint32_t best_loc,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r &lt; 0 ? r : 0;
          <br>
          &nbsp; }
          <br>
          &nbsp; +/* folio can be compound folio or single page */
          <br>
          &nbsp; static void svm_migrate_folio_free(struct folio *folio)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *page = &amp;folio-&gt;page;
          <br>
          @@ -630,7 +646,7 @@ svm_migrate_copy_to_ram(struct
          amdgpu_device *adev, struct svm_range *prange,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpage = svm_migrate_get_sys_page(migrate-&gt;vma,
          addr);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpage = svm_migrate_get_sys_page(migrate-&gt;vma,
          addr, 0);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dpage) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed get page svms 0x%p [0x%lx
          0x%lx]\n&quot;,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;svms, prange-&gt;start,
          prange-&gt;last);
          <br>
          @@ -1033,9 +1049,25 @@ static vm_fault_t
          svm_migrate_to_ram(struct vm_fault *vmf)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r ? VM_FAULT_SIGBUS : 0;
          <br>
          &nbsp; }
          <br>
          &nbsp; +static void svm_migrate_folio_split(struct folio *head,
          struct folio *tail)
          <br>
          +{
          <br>
          +&nbsp;&nbsp;&nbsp; struct svm_range_bo *svm_bo;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; if (tail == NULL)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; tail-&gt;pgmap = head-&gt;pgmap;
          <br>
          +&nbsp;&nbsp;&nbsp; tail-&gt;mapping = head-&gt;mapping;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; svm_bo = folio_zone_device_data(head);
          <br>
          +&nbsp;&nbsp;&nbsp; folio_set_zone_device_data(tail, svm_bo);
          <br>
          +&nbsp;&nbsp;&nbsp; svm_range_bo_ref(svm_bo);
          <br>
          +}
          <br>
          +
          <br>
          &nbsp; static const struct dev_pagemap_ops svm_migrate_pgmap_ops =
          {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .folio_free&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = svm_migrate_folio_free,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .migrate_to_ram&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = svm_migrate_to_ram,
          <br>
          +&nbsp;&nbsp;&nbsp; .folio_split&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = svm_migrate_folio_split,
          <br>
          &nbsp; };
          <br>
          &nbsp; &nbsp; /* Each VRAM page uses sizeof(struct page) on system
          memory */
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          index fa4054d51f60..6b783d12bce4 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          @@ -245,7 +245,16 @@ void svm_range_dma_unmap_dev(struct
          device *dev, dma_addr_t *dma_addr,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!svm_is_valid_dma_mapping_addr(dev,
          dma_addr[i]))
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;unmap 0x%llx\n&quot;, dma_addr[i]
          &gt;&gt; PAGE_SHIFT);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* dma unmap of THP */
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_addr[i] &amp; SVM_RANGE_DMA_THP) {
          <br>
          +
          <br>
        </blockquote>
        <br>
        Unnecessary empty line.
        <br>
        <br>
        <br>
      </blockquote>
      ok
      <br>
      <blockquote type="cite">
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr[i] &amp;=
          ~SVM_RANGE_DMA_THP;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_page(dev, dma_addr[i],
          PAGE_SIZE*HPAGE_PMD_NR,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_BIDIRECTIONAL);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
          <br>
        </blockquote>
        <br>
        The else-branch should also use {} braces if the if-branch does.
        <br>
      </blockquote>
      ok
      <br>
      <blockquote type="cite">
        <br>
        <br>
        <blockquote type="cite">+
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr[i] = 0;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; }
          <br>
          @@ -578,10 +587,10 @@ svm_range_vram_node_new(struct kfd_node
          *node, struct svm_range *prange,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;bp, 0, sizeof(bp));
          <br>
          -&nbsp;&nbsp;&nbsp; bp.size = prange-&gt;npages * PAGE_SIZE;
          <br>
          +&nbsp;&nbsp;&nbsp; bp.size = ALIGN(prange-&gt;npages * PAGE_SIZE,
          HPAGE_PMD_SIZE);
          <br>
        </blockquote>
        <br>
        This wastes memory for small ranges. Maybe guard this so it only
        applies to ranges that are larger than HPAGE_PMD_NR pages.
        <br>
      </blockquote>
      <br>
      I am think this too. The waste is 2MB at most instead of current
      4KB. I will change allocation size/aliment according to request
      size.
      <br>
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">
        <br>
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.bo_ptr_size = sizeof(struct
          svm_range_bo);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.destroy = svm_range_bo_destroy;
          <br>
          -&nbsp;&nbsp;&nbsp; bp.byte_align = PAGE_SIZE;
          <br>
          +&nbsp;&nbsp;&nbsp; bp.byte_align = HPAGE_PMD_SIZE;
          <br>
        </blockquote>
        <br>
        Same as above. There is no need to align smaller allocations.
        <br>
        <br>
        Regards,
        <br>
        &nbsp; Felix
        <br>
        <br>
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =
          AMDGPU_GEM_DOMAIN_VRAM;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
          b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
          <br>
          index c7d7adae4476..f2b3a05cd8cf 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
          <br>
          @@ -35,6 +35,7 @@
          <br>
          &nbsp; #include &quot;kfd_priv.h&quot;
          <br>
          &nbsp; &nbsp; #define SVM_RANGE_VRAM_DOMAIN (1UL &lt;&lt; 0)
          <br>
          +#define SVM_RANGE_DMA_THP (1UL &lt;&lt; 1)
          <br>
          &nbsp; #define SVM_ADEV_PGMAP_OWNER(adev)\
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;hive ? (void *)(adev)-&gt;hive :
          (void *)(adev))
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------2Ee0wpcuSnQPn1Cc4W7ZWneD--
