Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6883ECA5FED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 22:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F7C10E453;
	Tue,  6 Oct 2026 22:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XppEJAip";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012024.outbound.protection.outlook.com
 [40.107.200.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3EF10E453
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 22:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APmAwwVu7YTZDXcNNtp4nUHce3xPXL3QjRDSXVB9jbxKbCwYAz44iljHUhkfovQYIPUMY/sgIwdrIZ3CnhQaVn1Iy4I8EMPUmwcqxclbp19IGJ0+Rrk1VEnn1tRZyDBO2gsfq3d76xJPLe9GA6sVrskv14Uu2srrRSsSarkkJJ4UwpaPbxnyphynf0OdGnoIlwhzpX+CR9Eh8PJTH3TRXNbqC8i18CPGnLZPuoOONm4VHkOue8Q6CzqfCnHC6N9tg7MZX8APJ5O9wJvujTisU/8IeCOyp77thKfPvAJg2c3N9y8eKenRNYVhAFJXQLyizHHcqR16JGeEcVT8MBTcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8+0Xpb2SAeGV/A/gixwAl35Uas0d7KtFoILV1f96bE=;
 b=L085m7RfOnRVKP6F05f8lTUpBuA1h7g1+M0weq9Wu4e49VHGOhd3q5ZiVkBWpQKVJxgifUT70rmuVxPyyN39g9Uzg5RqCatO87GB7UJGpGruP6XB4zkmanGSmoat8v7crtNopzv+huY/9E/tyw7aGe2Aia/5WXgeZMzqN4fPTN4gdET/4skJQdHvxvdP5WpARObS7Zzkl4lFebl/3w5hYBMkau32VWMKjv2+BoC0pT02MgqzymyGmQifBrRAbhUDdNLBWmouc4tNG92PYKOwK2Vd9UhZGUMrwwjYPWUPqf71efxEfE3xBeagLmxbVaiiXW5GJHKwHABtkkeBFJ9gBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8+0Xpb2SAeGV/A/gixwAl35Uas0d7KtFoILV1f96bE=;
 b=XppEJAipLwX3oiP4BdNAymUwXEjTRlnWXVoZp+L2FFCiZ2WPglA6TsqnsObh9InT4+vfY1CNQl4U/1O2Nq+B4gUR4yv0AkV+FkidZGSVd9V8YFg3h6gmlF1L7kTDKXjhSfayKIDPu6TZEZcVd0ayhEnm6udDZVZ5vLVl6ujwTvo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by CHBPR12MB971693.namprd12.prod.outlook.com (2603:10b6:610:340::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 22:49:59 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 22:49:58 +0000
Message-ID: <73bea04f-27ee-48dc-842b-3c0ba08eb062@amd.com>
Date: Tue, 6 Oct 2026 17:49:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/amdkfd: Add awareness of THP of device and
 system RAM in kfd svm driver
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260904195421.42919-1-xiaogang.chen@amd.com>
 <20260904195421.42919-2-xiaogang.chen@amd.com>
 <225421e2-3ab1-4c6c-b229-6c59dcb4bcbc@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <225421e2-3ab1-4c6c-b229-6c59dcb4bcbc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:610:4c::20) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|CHBPR12MB971693:EE_
X-MS-Office365-Filtering-Correlation-Id: 7284a0e4-932f-4670-405b-08df23fc25f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tE9FK/SJUbQ6ngXzjPz9CT9/re5KfHRkyYZZ/pfbtQWv2DeggGebgE74TMsAT0sfAMwyYC14SKLNRdsZ6pKf7RTSL72Ot88sZsdckKQq9hxWGWejoRN7kOG4IxxGLREU2ecvO57r2n/E1qdvKvtuvmIaXbPR2H9CnMULEOR+TJUpgQ9mImbzp8nC9h4kwMbwZx2HKrdxNOKI3VA5qqT3JX4wSqWr9ekSMluDIpLYGxARWNx8SBifEWCCyYT0Amj1iC6KsfZnltXf4ZBDNkM2FEkJTI+yzrwpBU9oaBzsp6CkCtrTb6LxAisHYsbJvJQkCz8zg0yPxlVupyLUq9lUSxGGF+w4V8AwfIKcAmwRSEnsqOtH8eOiK9A0/LBnE0FFfNNrhPZh5EBG2m6LcYIZ3MTqfOrR7SqwANVcLcjjHuTI6T57ber51adELJ6xxvWBjOQzK2bTBcZ/vJgjlG25PfuY8jPmMqDnPgRPgVLID3D0Iv+OLBlP7RxKT35YiJJunWQDBYu6Rg6PxbH3IZ9yZ7P4XVxHzTzoDdohMy2UrWF8snfHvqY5HPaxfW0ANQgB990rh2y0titJhd6CCB51gPsGaZRVcNQ3Q1K8UuaaWLlE7+unzptUl/OcxKgcX/gm2XU81fVZtiFOhHOxoyKUUv7eo0J8t15pEbmCNIhcDlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnE5dXAzczVGM2JWK3ladTVESTE4cENHb1M0V1BXTndnd09yZnBRZ091VCtS?=
 =?utf-8?B?SnNwOGtNTEdWQTVRSENBM2MzbDVHdW1rQ3JrbWRXVHVQbk1OSkl6Y05odkhS?=
 =?utf-8?B?WlFJakpyNGNUMGlNeGJZNUZVcWo3azBWZVNFcHVpNDBkKzd2NzNKeEtjYXZ4?=
 =?utf-8?B?cGZuSndoUFNKMEtpUW4rSWkyMHdxK3RMTCt6eVFCNFJCdkcxMHNxRHlXY3ZO?=
 =?utf-8?B?RExENkFETWxQMGpYL2VaZk10Tk9MdE9DSDRZSUx1UmhYZld1RlQ4S1RMY3N6?=
 =?utf-8?B?aHVVTkJaWHdjWEdQclNZd2dhdXZmdW5ld1AvYlU1ejJ4elJLbWRseUFsYkVp?=
 =?utf-8?B?cVo3U3JiSEVlWm5GazZtVkZjSFJqRWsxWW1HZmJCU1hvK1hEMCtJdUlJUWh6?=
 =?utf-8?B?a3pTNjJsb3gzZUlveXR6YTMrUFpxK0FMV21RU0Y3VVJERThIMjJOMEJzR1ZW?=
 =?utf-8?B?UG9ROU1hV2hLSlN2N3ZVK2d1ZVFpS1RRMmY2bjduM0JRZ1laSUdTTTE2elda?=
 =?utf-8?B?WGdKK1hxcVBGckZ0ZGsyK0NYQldWNkZJTWV4Snh3bzVXSGUzbDQ4MVlhZ2M2?=
 =?utf-8?B?dTkvRzN0WUdGUENobTdUT2VaT1NDN0hGOGhwUUZZcTRUeXBlRjNDKzdFWVJR?=
 =?utf-8?B?N3hkNzFhUHFzTW5YYXkrVGIxVGxsdUZqcUVnUlcza3lycTFjN2hlLy85UHFR?=
 =?utf-8?B?R2VQRlcrRWREUy9GMUNBeTNwT3k5eWdwNENHRUVkV3RodGdyQ2Z0M1Faa2lz?=
 =?utf-8?B?N2RsdjBLNkVCb3VzdUdVMjEyWXlFdFRsM1FVcTdibFh3WlkwS1ROa20xQVB5?=
 =?utf-8?B?V0U2a2dubkFkejU2cTFWVTRIMjlSam1odUt2UmgwNTVQQUUvdnd3VHI5UFpJ?=
 =?utf-8?B?NnRMNm5uMEFWVTFhQlorSlpvNHZrR3FlTktsWnpiZ25jMDhvd211TnNYUFFN?=
 =?utf-8?B?NGdsQ2JCUHF5V1IzYXFMOFRxbHpjNE1yZDVRWkxDY3EzVGd6SFpQYUdFLzB0?=
 =?utf-8?B?aHdBdlRpSUd4ak9Dd2FiVWxsWjhXVjZVbHpQRkU3TUtPL0JhVTVhL3ZWMXM5?=
 =?utf-8?B?alZlYmVKTGNYRE96MTdSR2oxVzVOQ0dPa1o4clVOYnRWWjVTQjVlMkJxd29C?=
 =?utf-8?B?YlV4OHlYS25VWHRLMW9HWUU4YlhzQmNBZklrbkZSWGNteEVWYjVIQ2hVYWVi?=
 =?utf-8?B?b0M2ZjFsUTVFeUR6Q1VLTkVPSnU3RHdoODRLZFMvc285SlA4bDZEVExDNUxt?=
 =?utf-8?B?OHhaTUozY0ppY0ttSGVGaWpteG9wKzFIN2h6dUQ4Q2JQZTVuR3Z6cE9YSksx?=
 =?utf-8?B?K2V1MGthYlN6UzNockc2d3FjLytDWHhocWdiUzZiKyt2SE8xU3plY2FBbmdp?=
 =?utf-8?B?VXlxcUdqSVphUVNyUWU0bG5LMTVsVWpGWDdKRmFlbzVkdjNqWWRmTEowTkla?=
 =?utf-8?B?Mk9GMm9QaE1ZUGc4YjJPNUVVV0FIeERrTUJxdXRScTRGV2R0ZXBscjFXTi92?=
 =?utf-8?B?d1QyY241RktEME9LVk5reGNrWmt1SGdNN0VSdEhLRkN6REJJTEo3UjZ5QXFN?=
 =?utf-8?B?NTdEK3VUaGcyUy9McmlqV0w3Mmx6aUtnV0V5S3pEOXlzRnU2UDRDeU9nbVFo?=
 =?utf-8?B?cmkxNENhQmdrRlhTS0pwUk82U09kRzlCbi8wWWN6UmxKUHJOcU1mSWh1UEFR?=
 =?utf-8?B?Z1JlZTRXczFGcjJ2NENLZkpsNUxoOXAxQ0lhM093UEd3WnVyYy9rMUpQVWND?=
 =?utf-8?B?Znd4T3M0OEptR3MyQmEyRGhWMXBPTk1wcUgrRURZY2Fnc3NHd3dkaGd6Q0JT?=
 =?utf-8?B?MUphNnNQQkFMakNGR2pKOEZrY2FwUW1YL291NGNjNC9nN0dxVDJJcHJleHZ1?=
 =?utf-8?B?ZWFVU1JQWVExZFZXVmx2RVNKd3FmaHhNNjVWSDVLYVd6RU9tRVc4TlMxQ1pO?=
 =?utf-8?B?M1d2cWt5VmFmRWpBUDN3U3FlMU9FWG10N1pnQUpFV05BQUZuc253ZUZoZ203?=
 =?utf-8?B?ZkhsMEJkWVgrRWlXVFlxcXBVSThyenptVWRZUG9nQndwa0tZajZhamU2Vnoy?=
 =?utf-8?B?aXQzN0FqaEdPcUFNTWFPb2lYblkyS1c5c1BpZnZ0aDZjZERKSTVKNm4yak0y?=
 =?utf-8?B?bVVVbEpXeURDSjQ5SHBRMzNBWEZmekx0UVc4NERQUVVLeXVUa2ZXWVZnQ0tD?=
 =?utf-8?B?VTArSnRqWmpZVGpoemh0WFBPbk9kSTdmQXVEOVZBa2xOM2xXVTVPTUM2WXpk?=
 =?utf-8?B?SGl5eEkycTdzcXBncmpBS0ZLRzlEajd1UzJHeW9iNFlKZmJ4NDdyUEpNQXI4?=
 =?utf-8?Q?9rWbj7D8ZfaU29C4xM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7284a0e4-932f-4670-405b-08df23fc25f0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 22:49:58.8057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBeeEkulJ/4joGtFrJ0HLENB+HJ5J4yti4ZNtUmz1GRFiIlNMZzMfE6Qo47G1L7o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB971693
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


On 10/6/2026 4:40 PM, Felix Kuehling wrote:
> On 2026-09-04 15:54, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> Extend kfd/svm function to allocate HPAGE_PMD_SIZE based device 
>> memory by buddy
>> allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned and to 
>> allocate THP
>> system ram by vma_alloc_folio.
>>
>> Introduce SVM_RANGE_DMA_THP flag that indicates dma map of THP. THP dma
>> addresss will use this flag.
>>
>> Add dev_pagemap_ops->folio_split callback that is called by 
>> folio_split when
>> core MM splits device memory folio.
>>
>> These are preparations for following support for (THP) migration of zone
>> device-private memory, no function change.
>>
>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 50 +++++++++++++++++++-----
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 15 +++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
>>   3 files changed, 54 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 253365a8257e..813f3c1d29dc 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -217,14 +217,19 @@ svm_migrate_addr_to_pfn(struct amdgpu_device 
>> *adev, unsigned long addr)
>>   }
>>     static void
>> -svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
>> +svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
>> +               int order)
>>   {
>>       struct page *page;
>> +    struct folio *folio;
>>         page = pfn_to_page(pfn);
>> +    folio = page_folio(page);
>> +
>> +    zone_device_folio_init(folio, folio->pgmap, order);
>> +
>> +    folio_set_zone_device_data(folio, prange->svm_bo);
>
> I see that folio_set_zone_device_data checks that folio is 
> device_private. This will fail for device_coherent pages. We can't use 
> this function without breaking MI200 A+A.

Yes, I was looking if this work has changes that can affect 
device_coherent. It is one of them. This work is for GPU with device 
private memory by now. I will change this part to:

if (folio_is_device_private(folio))
     folio_set_zone_device_data(folio, prange->svm_bo);
else
     folio->page.zone_device_data = prange->svm_bo;

>
>
>>       svm_range_bo_ref(prange->svm_bo);
>> -    page->zone_device_data = prange->svm_bo;
>> -    zone_device_page_init(page, page_pgmap(page), 0);
>>   }
>>     static void
>> @@ -247,11 +252,17 @@ svm_migrate_addr(struct amdgpu_device *adev, 
>> struct page *page)
>>   }
>>     static struct page *
>> -svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long 
>> addr)
>> +svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long 
>> addr,
>> +              unsigned long order)
>>   {
>>       struct page *page;
>>   -    page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
>> +    if (order)
>> +        page = folio_page(vma_alloc_folio(GFP_HIGHUSER,
>> +                          order, vma, addr), 0);
>> +    else
>> +        page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
>> +
>>       if (page)
>>           lock_page(page);
>>   @@ -265,8 +276,12 @@ static unsigned long 
>> svm_migrate_successful_pages(struct migrate_vma *migrate)
>>         for (i = 0; i < migrate->npages; i++) {
>>           if (migrate->dst[i] & MIGRATE_PFN_VALID &&
>> -            migrate->src[i] & MIGRATE_PFN_MIGRATE)
>> -            mpages++;
>> +            migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>> +                if (migrate->dst[i] & MIGRATE_PFN_COMPOUND)
>> +                    mpages += HPAGE_PMD_NR;
>> +                else
>> +                    mpages++;
>> +            }
>
> Please fix the indentation.  This is one tab too deep. The alignment 
> of the condition should remain unchanged.
ok
>
>
>>       }
>>       return mpages;
>>   }
>> @@ -300,7 +315,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>           if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>>               dst[i] = cursor.start + (j << PAGE_SHIFT);
>>               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>> -            svm_migrate_get_vram_page(prange, migrate->dst[i]);
>> +            svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
>>               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>               mpages++;
>>           }
>> @@ -568,6 +583,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, 
>> uint32_t best_loc,
>>       return r < 0 ? r : 0;
>>   }
>>   +/* folio can be compound folio or single page */
>>   static void svm_migrate_folio_free(struct folio *folio)
>>   {
>>       struct page *page = &folio->page;
>> @@ -630,7 +646,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>               j = 0;
>>           }
>>   -        dpage = svm_migrate_get_sys_page(migrate->vma, addr);
>> +        dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
>>           if (!dpage) {
>>               pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>>                    prange->svms, prange->start, prange->last);
>> @@ -1033,9 +1049,25 @@ static vm_fault_t svm_migrate_to_ram(struct 
>> vm_fault *vmf)
>>       return r ? VM_FAULT_SIGBUS : 0;
>>   }
>>   +static void svm_migrate_folio_split(struct folio *head, struct 
>> folio *tail)
>> +{
>> +    struct svm_range_bo *svm_bo;
>> +
>> +    if (tail == NULL)
>> +        return;
>> +
>> +    tail->pgmap = head->pgmap;
>> +    tail->mapping = head->mapping;
>> +
>> +    svm_bo = folio_zone_device_data(head);
>> +    folio_set_zone_device_data(tail, svm_bo);
>> +    svm_range_bo_ref(svm_bo);
>> +}
>> +
>>   static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
>>       .folio_free        = svm_migrate_folio_free,
>>       .migrate_to_ram        = svm_migrate_to_ram,
>> +    .folio_split        = svm_migrate_folio_split,
>>   };
>>     /* Each VRAM page uses sizeof(struct page) on system memory */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index fa4054d51f60..6b783d12bce4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -245,7 +245,16 @@ void svm_range_dma_unmap_dev(struct device *dev, 
>> dma_addr_t *dma_addr,
>>           if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>>               continue;
>>           pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> 
>> PAGE_SHIFT);
>> -        dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
>> +
>> +        /* dma unmap of THP */
>> +        if (dma_addr[i] & SVM_RANGE_DMA_THP) {
>> +
>
> Unnecessary empty line.
>
>
ok
>> +            dma_addr[i] &= ~SVM_RANGE_DMA_THP;
>> +            dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*HPAGE_PMD_NR,
>> +                                   DMA_BIDIRECTIONAL);
>> +        } else
>> +            dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
>
> The else-branch should also use {} braces if the if-branch does.
ok
>
>
>> +
>>           dma_addr[i] = 0;
>>       }
>>   }
>> @@ -578,10 +587,10 @@ svm_range_vram_node_new(struct kfd_node *node, 
>> struct svm_range *prange,
>>       }
>>         memset(&bp, 0, sizeof(bp));
>> -    bp.size = prange->npages * PAGE_SIZE;
>> +    bp.size = ALIGN(prange->npages * PAGE_SIZE, HPAGE_PMD_SIZE);
>
> This wastes memory for small ranges. Maybe guard this so it only 
> applies to ranges that are larger than HPAGE_PMD_NR pages.

I am think this too. The waste is 2MB at most instead of current 4KB. I 
will change allocation size/aliment according to request size.

Regards

Xiaogang

>
>
>>       bp.bo_ptr_size = sizeof(struct svm_range_bo);
>>       bp.destroy = svm_range_bo_destroy;
>> -    bp.byte_align = PAGE_SIZE;
>> +    bp.byte_align = HPAGE_PMD_SIZE;
>
> Same as above. There is no need to align smaller allocations.
>
> Regards,
>   Felix
>
>
>>       bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>       bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>>       bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index c7d7adae4476..f2b3a05cd8cf 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -35,6 +35,7 @@
>>   #include "kfd_priv.h"
>>     #define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
>> +#define SVM_RANGE_DMA_THP (1UL << 1)
>>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>>               ((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
