Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469EACA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 18:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FE810E661;
	Wed,  7 Oct 2026 18:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PQHJWhZW";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0747D10E661
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 18:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyOXNP1knUrTszYq+8luL92q/9Rg0D0IXpjQIHnyGewyyAdNihCP8S4nGZbOUCXuAgk/uOKmLd6a7oU2sCQ7tDAvM6q/CWyPVwhIfal1vMeBiPh8R/KwlZadNPUQPcr1/FBGRPlrRrO6S15xx0jbj/ilvN7nBSYeszaHPV0LyOFit2w2yPtdcL0+J7h2lcUcJb3tqnpO7v/ehfBZ0Ydn0fJCMQFz+CS2wy5IYyWC9REYoTZKPFDuuRR33JeNwMKi9p+qFZ2HTvez2b3Uhy9P34UcSYy7ymsX6ZpSazvHkJ//icCBujTO0YGtjHrd4UL1b1e4w4Ssj4AO0H+3q+KqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzv+ruFNRI8cH0h5x7ZGIniQ9wo5ynw6dGhy8bYBacY=;
 b=LYWRfehwud/435SkKvGxShCCL+o79QCCjbzkdxP2m01qChDiAX/4xGFnN2hiCbCRbY+0l0AcgKkNx6+kTM6lizSVw2eqXvlnYlfb09OBiSYoJ+r1LfyB/yaZC9Oc42PxGiLMmjIodWg6dSHC31pWL0EjKGdx+enGA43CGUzVeV9BendTVPwYLcdzGbwc53s2I/DV69mp5+k7LKKkmANJoBm75c1ojwnnvvKtxDAi8eIjL4X54Ufku1iFY5tspWI26FPOaF9A55SO1jJF6jaepr6XQcs+c6Yhu5LqdkI/c8njJ0lFKFAiNOR6gmHNaFBpNiAu4UH048RnmHLGtH/JyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzv+ruFNRI8cH0h5x7ZGIniQ9wo5ynw6dGhy8bYBacY=;
 b=PQHJWhZW/zDPH2qC626wO5sAvjjy4hifboovl6HaQWr6tYkXD52JnXn8cdSVCBK7b7QF/6EEzlCcN5RXkLFXzxb+UEd4CCT+XZM0udbtf+tZltI9gYq0MY1Tx904IYSP109KzXGkN108yMj8gIrxcDbmdf6F0V/i/HO+J3Fi4U8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 18:57:43 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 18:57:42 +0000
Message-ID: <9bbff69b-63c8-40a0-9081-babd69243b76@amd.com>
Date: Wed, 7 Oct 2026 13:57:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/amdkfd: Apply HMM THP zone device-private
 memory migration in kfd driver
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260904195421.42919-1-xiaogang.chen@amd.com>
 <20260904195421.42919-4-xiaogang.chen@amd.com>
 <554ee275-f01f-48ee-ad8c-9253d4739308@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <554ee275-f01f-48ee-ad8c-9253d4739308@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:610:e7::8) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: d60e200e-bddd-4ba2-eefe-08df24a4dd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: sv9he1K9eRfTH1NGLYCfQ7KDUtqZMsrTTTwtDSoOIJIzMD0ZtyDwIQqTckREXIWOcM/CLTqMtIh3e8fZFoG81LuTQ72BKYvnieCsbAscCDN9LddIVJc9qQFRFPTvqK78AyoaJM7pcmrvbk4ehbY93oyPPDEpFqMllgxSWq9yc776MPv/GaJGPA2M1fgmOF9zQuMfy37U4sT9OUjtmeg/iNDT2/FzK8vA3DrED7pQQY1+Tq8ijH08BgIxBms8vHJawyhm58wgrfzH2ePCTbhbGkXpp5EJyQ6FSyZ65HlroQOQYy8rBYmk0jP1ZmAX/FnG7tuoyO21/K7IkjnZpIL25ahwDsdE3PfTccRmsQV2Pb7OM7vXcPHnlW5FvpThLdfeDS0iAMI+etF0f5y2UV1yGNd+p9uAgDV9xLsX+USui+yRRwOdOuo/mMNkeT2tFb4miKbemcZpdDNSKwt/tZNWf9ydyoNY8KASpBfIk59XzXJ3fSPFrIKYUAn189REocYOwKgoo+VerIpWjgLhFHk7S/P2y2l+40N6fXNdrAOerSwV44vIeLXtT+MffoNoP1OaO612ai79EOMWte4dokMoaeGWOgLuW+s3gaaIYjN6BA3/vQXHWxzTBRsQBxDS0f2Sm3OoBvCRFlmX+Vivsx9DHoRc7hcRCWelxdrSwzkC8UQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1JpOHl2TzZwb2FFWGJROHovQmtGY3JUcENsSlI5c3YvUUJCazJGazBsV2M0?=
 =?utf-8?B?Nkowam13NlRKVTFmaEdCVVFTRlkvV29TaGNpS3RvblN1OGRmRmFaaHZTZ2pO?=
 =?utf-8?B?Zml3dEc1aHR1QlNDUXROc245SDF3M2lWV1l6Mk4xYzlabTR3Q0N5eEFZOVJk?=
 =?utf-8?B?eU92QUNDT29RSm56UEJkTGEvM2ZQOWJpbnRkd2ZTV0l4bkJaWGRMVFFQT0ky?=
 =?utf-8?B?emZqV2RoNm85b1NHOUlSKzF6cVZjM3RHMFdPaVBHanU5eVJvYnk0Q1dYcUNw?=
 =?utf-8?B?Mk8xTVBNR1lNYVFxc25kbGZFNlljQ0RhTGdVS1JTYWJxaG5QTFlQVm5GUVhi?=
 =?utf-8?B?b2kzbXNCN09ONUU3ODFrd2xqM0N6NXhLa1NXZlp2NE4yb2c0ZWRhV1FzUGhL?=
 =?utf-8?B?NVVIazZDQ2JzRmlxWit6RzBhZlN5dDRweHlRQ2N5em9iaWFWR0czc0VXZ1Mr?=
 =?utf-8?B?VnJVdW1EOW5OeU1YWlUzQ1dqbEw1OGlxeUR1WXVDRGx2dVg4U2lHS3JqUEho?=
 =?utf-8?B?b09LWUhZN1c5VUNwam1mNCsxZm9SOU9iK3ZNVkVlcGhvVjd3RFBwVXN2OUdB?=
 =?utf-8?B?SWNuaXhZVFJCZnpodzFta0IwT3hIV2FVTGl6YUE5aTMvTFNDUjZ3SUJkTm1r?=
 =?utf-8?B?dCt5ZURlUkFKamhRTlVobEpqaDRnMjZ3ay9ZcnRETXZYR2xNOXhXWThRTGF4?=
 =?utf-8?B?OFVoSm9MU0JEejQvU29xckJqQjZudGZPQWw5eHFFOGJycW1Lak93aWRxNEtL?=
 =?utf-8?B?eEowODZQdmNpc2xUT2JIQzFYeEQzQ0Uza2J4UG1KVVZxejR6dUh0U3Ayai91?=
 =?utf-8?B?ci9CTU9kNjV0VUp3RG1OWUk0MDBieEtMSVQzVVlrK293THJSVFB2T05NbHFw?=
 =?utf-8?B?d0xCQUFpa1hzRitnY2RwQ29RUWNwL1VhTjJ2eXZxZ2Q0ZSsxVE5PVC9JTGZE?=
 =?utf-8?B?VVBMaVFHVmV4amp3cEJlRUg5UjREOXBmbm1oQ09QNzZhRHpGdWtvVUQxWFRZ?=
 =?utf-8?B?c0tQeURGR09XN3hpZEJSVjlCNEZPdFZQWkhqK2VyenNZSXdoOVdOa1N1akRt?=
 =?utf-8?B?Mm9GOE1OdlA1SkxoS2d2Y2NzSDltNGVNaFZzSXZlenBXdWJkeWFxcm1lRzl4?=
 =?utf-8?B?czlEeWpaSHg0cU9rWU9lQlR4c1hvenpMS2RySGhhSmVybUxOQlhLYm1PemtP?=
 =?utf-8?B?anVuQ0g5QVFPZWtpSW5xUzk2ODZTdG5lcC8wdzZKSXo2QnlxRVViVFhTM1lK?=
 =?utf-8?B?bUtwaHIwTkRoTWFTTloxZzF6bUczRWoybnhTeU9vOVhwSVhTaWd0blRxMnZV?=
 =?utf-8?B?L3BJTzlUQmN6K1hrMHBQeGVoc3hPOG1JdURNZ3ZDbTJNdW5zWWlRWnVCNEp4?=
 =?utf-8?B?eVUrOFQ5SXdQaW9OWXpycnpUSHU5L3F3OFBVMHVqMkd3MVpjTXZqZEJaRWJ5?=
 =?utf-8?B?bU95YU84aldYWFBRb2xpQnFadDUySFZGNkFFNmdYelJ0WVRuQkx2SjdzVXEx?=
 =?utf-8?B?NjRoaHEzYzhGVlFxcy9GSXVXOXVhclM3V1hOeG9iUGQvcHpWbjdwV2xoeUxN?=
 =?utf-8?B?bVpYSTFmLzM2ckY3ZUVtZGhKYW5nRzJKU0ZuN0grdjR3TUN4Snlmd0RaSndy?=
 =?utf-8?B?U1NraVkzODd1Wm1IMWJzZWF5WVIzV1NaM2hJZTdDQ2VPaFhuRkcxdTlFQ1hj?=
 =?utf-8?B?YUtsb3V4cFVBM1hrRmh6Q0pTcSt5ZzBRYy9ZUlhDYVdXUVBpbjdudjBVUDdm?=
 =?utf-8?B?VncwbGpkZmVINE53VmZIb0p0YWpLRUdqSXIxd1pMNmRPMHhTRTlnZzNiNm5C?=
 =?utf-8?B?S2pVS1ZYSEdGNDRqMEtoR2RxM0VySk9zYjRRY1ZJY0lDdHBBNkhNbGF0TG9J?=
 =?utf-8?B?bkJQd3lJZXFTeE1mUjNnbWpMU3BJbnp4UEJNUy9FZkhIc0FFUzlnZkJrbmVO?=
 =?utf-8?B?U2NDUzlXdUpyVTB5Q3ZrRWtXK0JlT0hFZjdhbW14aVFUMGYvQ293Nk9JSnRU?=
 =?utf-8?B?R293QmwyWnpYcmV5UFQrYm9kYmVNRzNCZEJqWFRxRTFqNm0zbmRPRGdQSFg1?=
 =?utf-8?B?UWRMS2hHTjZPL0JHanFzMFRJUlV1UVFYdi9TRUhGV0ZuYzF5bUFpNFdyVE1E?=
 =?utf-8?B?a0M0QVBNUFZVYjVnV3N0VFRkQkJ5NCtmd25tbGtXeTN3ZGNTbjBQVUhpb21F?=
 =?utf-8?B?WVpySDdqZGRKUURDK20wQ2NzZzBPMUxYWjdZTFNXaVFDa3ZPOWNsZ3FKa1hn?=
 =?utf-8?B?N1BIZGdxZ3QrM3htR1pYRmpHMCtQaUJDSTVrMDZSQUVwOFE1TUJzUTBTU1hD?=
 =?utf-8?Q?gRwo50RjFu0prOILNi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60e200e-bddd-4ba2-eefe-08df24a4dd9a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:57:42.4992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpQ6yiiKuzRHlSvOZBY8LDQvgrSdd4dglR2kU1o2PqH6o9BX0vpmGqpJsTtqHyZv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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


On 10/6/2026 5:44 PM, Felix Kuehling wrote:
> On 2026-09-04 15:54, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> Update kfd svm driver to migrate device-private THP introduced from 
>> HMM core
>> migration function. Select this function by flag 
>> MIGRATE_VMA_SELECT_COMPOUND
>> when call migrate_vma_setup. kfd migration procedure is updated 
>> according to
>> collected page type that can be either compound folio(physical 
>> continuous) or
>> normal size page.
>>
>> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 271 ++++++++++++++++++-----
>>   1 file changed, 219 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index bbf0fefd5722..af39e547c1fa 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -298,7 +298,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>       u64 mpages = 0;
>>       dma_addr_t *src;
>>       u64 *dst;
>> -    u64 i, j;
>> +    u64 i, j, k, l, m;
>>       int r = 0;
>>         pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, 
>> prange->start,
>> @@ -309,59 +309,158 @@ svm_migrate_copy_to_vram(struct kfd_node 
>> *node, struct svm_range *prange,
>>         amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>>                npages << PAGE_SHIFT, &cursor);
>> -    for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
>> +    for (i = j = m = 0; (i < npages) && (mpages < migrate->cpages);) {
>>           struct page *spage;
>> +        unsigned long cur_dst_pfn;
>> +        bool is_large = false;
>>   -        if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>> -            dst[i] = cursor.start + (j << PAGE_SHIFT);
>> -            migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>> -            svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
>> -            migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>> +        cur_dst_pfn = svm_migrate_addr_to_pfn(adev,
>> +                              cursor.start + (m << PAGE_SHIFT));
>> +
>> +        /* when migrate->src[i] has MIGRATE_PFN_COMPOUND set the src 
>> page
>> +         * is compound THP; its vm address is HPAGE_PMD_SIZE aligned 
>> and
>> +         * its MIGRATE_PFN_MIGRATE is set
>> +         */
>> +        if ((m + HPAGE_PMD_NR) <= (cursor.size >> PAGE_SHIFT) &&
>> +            (i + HPAGE_PMD_NR) <= npages &&
>> +            (migrate->src[i] & MIGRATE_PFN_COMPOUND) &&
>> +            IS_ALIGNED(cur_dst_pfn, HPAGE_PMD_NR)) {
>> +
>
> Unnecessary empty line.
>
ok
>
>> +            is_large = true;
>> +            k = HPAGE_PMD_NR;
>
> is_large is redundant. Just use (k > 1).
>
>
>> +        } else
>> +             k = 1;
>
> Bad indentation.
ok
>
>
>> +
>> +        /* for THP src[0] alwas MIGRATE_PFN_MIGRATE
>> +         * just the first migrate->dst need be setup, others are zero
>> +         */
>> +        if (is_large) {
>> +
>> +            dst[i] = cursor.start + (m << PAGE_SHIFT);
>> +            svm_migrate_get_vram_page(prange, cur_dst_pfn,
>> +                          HPAGE_PMD_ORDER);
>> +
>> +            migrate->dst[i] = migrate_pfn(cur_dst_pfn);
>> +            migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
>> +
>> +            for (l=1; l < k; l++)
>> +                migrate->dst[i+l] = 0;
>> +
>> +            mpages++;
>> +
>> +        } else if ((migrate->src[i] & MIGRATE_PFN_MIGRATE)) {
>> +            dst[i] = cursor.start + (m << PAGE_SHIFT);
>> +            svm_migrate_get_vram_page(prange, cur_dst_pfn, 0);
>> +            migrate->dst[i] = migrate_pfn(cur_dst_pfn);
>>               mpages++;
>>           }
>> -        spage = migrate_pfn_to_page(migrate->src[i]);
>> -        if (spage && !is_zone_device_page(spage)) {
>> -            src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
>> -                          DMA_BIDIRECTIONAL);
>> -            r = dma_mapping_error(dev, src[i]);
>> -            if (r) {
>> -                src[i] = 0;
>> -                dev_err(dev, "%s: fail %d dma_map_page\n",
>> -                    __func__, r);
>> -                goto out_free_vram_pages;
>> +
>> +        if (is_large) {
>> +            if (j) {
>> +                /* migrate previous accumulated pages */
>> +                r = svm_migrate_copy_memory_gart(
>> +                        adev, src + i - j,
>> +                        dst + i - j, j,
>> +                        FROM_RAM_TO_VRAM,
>> +                        mfence);
>> +
>> +                if (r)
>> +                    goto out_free_vram_pages;
>> +
>> +                j = 0;
>> +            }
>> +
>> +            /* for THP check if the first src page is valid
>> +             * if not valid skip following HPAGE_PMD_NR - 1 pages
>> +             */
>> +            spage = migrate_pfn_to_page(migrate->src[i]);
>> +            if (spage && !is_zone_device_page(spage)) {
>> +                /* dma_map continuous HPAGE_PMD_NR sys ram pages */
>> +                src[i] = dma_map_page(dev, spage, 0, 
>> PAGE_SIZE*HPAGE_PMD_NR,
>> +                              DMA_BIDIRECTIONAL);
>> +
>> +                r = dma_mapping_error(dev, src[i]);
>> +                if (r) {
>> +                    dev_err(dev, "%s: fail %d dma_map_page\n",
>> +                            __func__, r);
>> +                    goto out_free_vram_pages;
>> +                }
>> +
>> +                /* get dma address for following HPAGE_PMD_NR-1 pages
>> +                 * since src pages are continuous their dma addresses
>> +                 * are continuous too.
>> +                 */
>> +                for (l=1; l < k; l++)
>> +                    src[i + l] = src[i] + l*PAGE_SIZE;
>> +
>> +                /* migrate the HPAGE_PMD_NR pages above */
>> +                r = svm_migrate_copy_memory_gart(
>> +                        adev, src + i,
>> +                        dst + i, HPAGE_PMD_NR,
>> +                        FROM_RAM_TO_VRAM,
>> +                        mfence);
>> +
>> +                /* mark head page dma mapping as THP, tail pages dma 
>> addr
>> +                 * are set to 0 for following dma_unmap
>> +                 */
>> +                src[i] |= SVM_RANGE_DMA_THP;
>> +                for (l = 1; l < k; l++)
>> +                    src[i + l] = 0;
>
> I hope this doesn't break partial mapping or unmapping. We'd need to 
> be sure that code always aligns addresses to huge-page boundaries and 
> gets the whole huge page. A safer alternative would be to use a 
> different flag for the second and subsequent compound pages. So you'd 
> still have the DMA addresses, but you could ignore them for DMA 
> unmapping.

For THP system memory core HMM provides 
spage=migrate_pfn_to_page(migrate->src[i]) is 2MB aligned.  dma adress 
src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE*HPAGE_PMD_NR,..), is also 
2MB aligned since  spage is 2MB aliged and size is 2MB.

I put SVM_RANGE_DMA_THP bit just at dma addr of head page. The following 
511 dma address is put 0. At svm_range_dma_unmap_dev I should have 
jumped i by 512 when hit SVM_RANGE_DMA_THP:


         if (dma_addr[i] & SVM_RANGE_DMA_THP) {

             dma_addr[i] &= ~SVM_RANGE_DMA_THP;
             dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*HPAGE_PMD_NR,
                                    DMA_BIDIRECTIONAL);
         } else
             dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);

>
>> +
>> +                if (r)
>> +                    goto out_free_vram_pages;
>> +
>> +                j = 0;
>>               }
>>           } else {
>> -            if (j) {
>> +            /* single normal page case */
>> +            spage = migrate_pfn_to_page(migrate->src[i]);
>> +            if (spage && !is_zone_device_page(spage)) {
>> +                src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
>> +                              DMA_BIDIRECTIONAL);
>> +
>> +                r = dma_mapping_error(dev, src[i]);
>> +
>> +                if (r) {
>> +                    dev_err(dev, "%s: fail %d dma_map_page\n",
>> +                            __func__, r);
>> +                    goto out_free_vram_pages;
>> +                }
>> +                j += 1;
>> +
>> +            } else if (j) {
>>                   r = svm_migrate_copy_memory_gart(
>>                           adev, src + i - j,
>>                           dst + i - j, j,
>>                           FROM_RAM_TO_VRAM,
>>                           mfence);
>> +
>>                   if (r)
>>                       goto out_free_vram_pages;
>> -                amdgpu_res_next(&cursor, (j + 1) << PAGE_SHIFT);
>> +
>>                   j = 0;
>> -            } else {
>> -                amdgpu_res_next(&cursor, PAGE_SIZE);
>>               }
>> -            continue;
>>           }
>>   -        pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 
>> 0x%lx\n",
>> -                     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
>> +        pr_debug_ratelimited("dma mapping %lld pages, src to 0x%llx, 
>> pfn 0x%lx\n",
>> +                     k, src[i] >> PAGE_SHIFT, migrate->src[i] >> 
>> MIGRATE_PFN_SHIFT);
>> +        i += k;
>> +        m += k;
>> +
>> +        if (m >= (cursor.size >> PAGE_SHIFT)) {
>> +            if (j > 0) {
>> +                r = svm_migrate_copy_memory_gart(adev, src + i - j,
>> +                                 dst + i - j, j,
>> +                                 FROM_RAM_TO_VRAM,
>> +                                 mfence);
>
> Are you sure this is correct? The old code incremented i after this 
> copy was done. Your new code does it before. I think that will mess up 
> your address calculations.
The old code changes i at for-loop: for (i = j = 0; i < npages; i++) . 
Here I update i  after handle page(either one 4k page or one THP), then 
increase i(either 1 or 512). When reach current vram segment boundary,  
migrate previous accumulated 4k pages. THP has been migrated before. 
Here the code handles the 4k pages that was accumulated when reach to 
current vram segment boundary.
>
>
>> +                if (r)
>> +                    goto out_free_vram_pages;
>> +            }
>> +
>> +            amdgpu_res_next(&cursor, m*PAGE_SIZE);
>>   -        /* accumulated j + 1 pages reach end of current 
>> drm_buddy_block */
>> -        if (j + 1 >= (cursor.size >> PAGE_SHIFT)) {
>> -            r = svm_migrate_copy_memory_gart(adev, src + i - j,
>> -                             dst + i - j, j + 1,
>> -                             FROM_RAM_TO_VRAM,
>> -                             mfence);
>> -            if (r)
>> -                goto out_free_vram_pages;
>> -            amdgpu_res_next(&cursor, (j + 1) * PAGE_SIZE);
>>               j = 0;
>> -        } else {
>> -            j++;
>> +            m = 0;
>>           }
>>       }
>>   @@ -410,17 +509,24 @@ svm_migrate_vma_to_vram(struct kfd_node 
>> *node, struct svm_range *prange,
>>       struct kfd_process_device *pdd;
>>       struct dma_fence *mfence = NULL;
>>       struct migrate_vma migrate = { 0 };
>> +    bool is_private_device = false;
>>       unsigned long cpages = 0;
>>       unsigned long mpages = 0;
>>       dma_addr_t *scratch;
>>       void *buf;
>>       int r = -ENOMEM;
>>   +    is_private_device = svm_is_private_zone(adev);
>> +
>>       memset(&migrate, 0, sizeof(migrate));
>>       migrate.vma = vma;
>>       migrate.start = start;
>>       migrate.end = end;
>>       migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
>> +
>> +    if (is_private_device && ((end - start) >> PAGE_SHIFT) >= 
>> HPAGE_PMD_NR)
>> +        migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
>> +
>
> Why do you apply this only to device_private memory. This should work 
> just as well for device_coherent on MI200 A+A.

Current work is for private device memory only. Need update core HMM 
code for coherent device memory to support THP.

Driver's work to enable device THP actually has no real difference 
between private and coherence device memory.

>
>
>>       migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>>         buf = kvcalloc(npages,
>> @@ -609,6 +715,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>       u64 addr;
>>       int r = 0;
>>   +    u64 l, k;
>> +    bool is_large = false;
>> +
>>       pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
>>            prange->last);
>>   @@ -616,8 +725,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>         src = (u64 *)(scratch + npages);
>>       dst = scratch;
>> -
>> -    for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
>> +    for (i = 0, j = 0; i < npages;) {
>
> If you reset k = 1, you could keep the increment in the loop header. 
> Just update it to
>
>     for (i = 0, j = 0, k = 1; i < npages; i += k, addr += k*PAGE_SIZE, 
> k = 1)
ok, that makes code more concise.
>
>
>>           struct page *spage;
>>             spage = migrate_pfn_to_page(migrate->src[i]);
>> @@ -633,6 +741,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>                       goto out_oom;
>>                   j = 0;
>>               }
>> +
>> +            addr += PAGE_SIZE;
>> +            i++;
>>               continue;
>>           }
>>           src[i] = svm_migrate_addr(adev, spage);
>> @@ -646,7 +757,22 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>               j = 0;
>>           }
>>   -        dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
>> +        if(IS_ALIGNED(page_to_pfn(spage), HPAGE_PMD_NR) &&
>
> There should be a space after "if". I see a few more coding style 
> issues below. Please run check_patch.pl to check for common coding 
> style issues.
ok, will check code style next submit.
>
>
>> +           (addr + HPAGE_PMD_SIZE) <= migrate->end &&
>> +           IS_ALIGNED (addr, HPAGE_PMD_SIZE) &&
>> +           migrate->src[i] & MIGRATE_PFN_COMPOUND) {
>> +
>> +            is_large = true;
>> +            k = HPAGE_PMD_NR;
>
> is_large is redundant. You could just use (k > 1).
ok
>
>
>> +
>> +            dpage = svm_migrate_get_sys_page(migrate->vma, addr,
>> +                             HPAGE_PMD_ORDER);
>
> Do we need a fallback to small pages if if huge-page allocation fails?

I thought about that for system page allocation: if kernel cannot 
provide THP system memory allocate in regular page base, if still 
cannot, fail svm_migrate_get_sys_page.

Same for device memory allocation when allocate THP from ttm. If fail, 
fallback to 4k page based allocation.

Before migration check driver allocated page is THP or not, then use 
different procedure.

>
>
>> +        } else {
>> +            k = 1;
>> +            is_large = false;
>> +            dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
>> +        }
>> +
>>           if (!dpage) {
>>               pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>>                    prange->svms, prange->start, prange->last);
>> @@ -654,21 +780,59 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>               goto out_oom;
>>           }
>>   -        dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, 
>> DMA_BIDIRECTIONAL);
>> +        dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, 
>> DMA_BIDIRECTIONAL);
>>           r = dma_mapping_error(dev, dst[i]);
>>           if (r) {
>>               dev_err(adev->dev, "%s: fail %d dma_map_page\n", 
>> __func__, r);
>> -            dst[i] = 0;
>
> Why did you remove this?
ok,  dst[i] is still used at svm_range_dma_unmap_dev for error handling 
case.
>
>
>>               goto out_oom;
>>           }
>>   -        pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 
>> 0x%lx\n",
>> -                     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>> -
>>           migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
>> +        if (is_large)
>> +            migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
>
> Looks like you can merge that into the next if-block just below.
Yes, I do not know what I thought when did it. Maybe forgot cleaning 
code after removed some debug code here.
>
>
>>   -        dpage = NULL;
>> -        j++;
>> +        if (is_large) {
>> +            /* migrate previous accumulated pages */
>> +            if(j) {
>> +                r = svm_migrate_copy_memory_gart(adev, dst + i - j,
>> +                                 src + i - j, j, FROM_VRAM_TO_RAM, 
>> mfence);
>> +                if (r)
>> +                    goto out_oom;
>> +                j = 0;
>> +            }
>> +
>> +            for (l = 1; l < k; l++) {
>> +
>> +                src[i + l] = src[i] + l*PAGE_SIZE;
>> +                dst[i + l] = dst[i] + l*PAGE_SIZE;
>> +                migrate->dst[i + l] = 0;
>> +            }
>> +
>> +            /* migrate the HPAGE_PMD_NR pages above */
>> +            /* svm_migrate_copy_memory_gart will add a paramter to 
>> indicate
>> +             * the migration is for 2MB THP
>> +             */
>> +            r = svm_migrate_copy_memory_gart(
>> +                        adev, dst + i,
>> +                        src + i, HPAGE_PMD_NR,
>> +                        FROM_VRAM_TO_RAM,
>> +                        mfence);
>> +
>> +            /* mark head page dma mapping as THP, tail pages dma addr
>> +             * are set to 0 for following dma_unmap
>> +             */
>> +            dst[i] |= SVM_RANGE_DMA_THP;
>> +            for (l = 1; l < k; l++)
>> +                dst[i + l] = 0;
>
> I hope this doesn't break partial mapping or unmapping. We'd need to 
> be sure that code always aligns addresses to huge-page boundaries and 
> gets the whole huge page.
Same as migration from sys to device. dst[i] is dma address for THP 
system page. It is 2MB aligned and the mapping size is 
PAGE_SIZE*k(k=512) for THP.
>
>
>> +
>> +            if (r)
>> +                goto out_oom;
>> +
>> +        } else
>> +            j++;
>> +
>> +        addr += PAGE_SIZE*k;
>> +        i += k;
>>       }
>>         if (j > 0)
>> @@ -687,12 +851,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>           /* release previous allocated sys pages and unmap dma 
>> address */
>>           while (i--) {
>>   -            if (dst[i]) {
>> -                dma_unmap_page(dev, dst[i], PAGE_SIZE,
>> -                           DMA_BIDIRECTIONAL);
>> -                dst[i] = 0;
>> -            }
>> -
>> +            /* follwing svm_range_dma_unmap_dev will do dma unmap 
>> anyway
>> +             * not need do dma unmap here
>> +             */
>>               dpage = migrate_pfn_to_page(migrate->dst[i]);
>>               if (!dpage)
>>                   continue;
>> @@ -733,6 +894,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>       unsigned long cpages = 0;
>>       unsigned long mpages = 0;
>>       struct amdgpu_device *adev = node->adev;
>> +    bool is_private_device = false;
>>       struct kfd_process_device *pdd;
>>       struct dma_fence *mfence = NULL;
>>       struct migrate_vma migrate = { 0 };
>> @@ -740,6 +902,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>       void *buf;
>>       int r = -ENOMEM;
>>   +    is_private_device = svm_is_private_zone(adev);
>> +
>>       memset(&migrate, 0, sizeof(migrate));
>>       migrate.vma = vma;
>>       migrate.start = start;
>> @@ -750,6 +914,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>       else
>>           migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>>   +    if (is_private_device && ((end - start) >> PAGE_SHIFT) >= 
>> HPAGE_PMD_NR)
>> +        migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
>
> Why do you apply this only to device_private memory. This should work 
> just as well for device_coherent on MI200 A+A.

Current work is for private device only. Need update core HMM code for 
coherent device memory to support THP.

Driver's work to enable device THP actually has no real difference 
between private and coherence device memory since driver uses same 
migration path.

>
>
>> +
>>       buf = kvcalloc(npages,
>>                  2 * sizeof(*migrate.src) + sizeof(u64) + 
>> sizeof(dma_addr_t),
>>                  GFP_KERNEL);
>> @@ -1132,7 +1299,7 @@ int kgd2kfd_init_zone_device(struct 
>> amdgpu_device *adev)
>> amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
>>   -    pr_info("HMM registered %ldMB device memory\n", size >> 20);
>> +    pr_info("---XCHEN 3.2 HMM registered %ldMB device memory\n", 
>> size >> 20);
>
> This looks like it's not meant to be submitted.

Sorry about that. I should have removed debug stuff put during triage 
before submit.


Thanks

Xiaogang

>
> Regards,
>   Felix
>
>
>>         return 0;
>>   }
