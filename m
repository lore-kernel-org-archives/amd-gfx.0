Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E502AC6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 15:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D3710E44A;
	Wed, 14 Sep 2022 15:13:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA6910E44A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 15:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWbAyxQ8b0xBx2mN4zHPovky7FQ6CYgdwkASd8G3B3lXHwi/u4hR44KVbEaSR1EwevutsZCa6QGalF3aV8Qdxlkb9ZkSZyWGXxbaPnz8+pJzYUcUce06iBU/5HTQrPx4SSaFHTU1QATsIVqP/hmMfk31vLEOMsLzr2zlyXAtVT95Y1z4TuUtpY63kccORizwnRmFppYaw7GNh+iUxPovxp+9mxgMXB74eudk+9j4AIxVdk8z4DYVtBxAZdIP/iXBmZ/CAcpNaho5R+/jD4FcAD/Aa4580/IO2WFVvlxdnsc3Gk7gpIQ09rBbG+6RFxEVo2tfJXzbJrufXnr53L5r8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEPaSmtXDiD1QSsY4gJWYWi2D8OxHfFTcGvO15RIpx8=;
 b=f8/n3crNAx+Gcmd88KJ1NOwTsBK72Q4NE5Pzy5Cm0yiLEjb1An3kTFCbEP5tqkJLli6iTT9/19HtWaQiDtUkDzwvq2+O49Oc2wdzFhwbgHAEaze0Bh5jfdAgJWvDgIjZgPBExsAcl6WpkGGGO0ezm7mGyp0/YTKi0BMgI2I8ijMHL7ZT94q3VdjI55v94UXfBVTiHddClWtXwgYARkaEX7UoBUpllsbrEsPvCPmChbwHeexHLuhGJilRxUYc8xTvqcOc1SdPoSEdao43WnaK4tgcGTvtc3uuBJqB3IGSZg5K3PmD8U1/4RAN629uaYD7E9Jrn/ItN59//PNHggqSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEPaSmtXDiD1QSsY4gJWYWi2D8OxHfFTcGvO15RIpx8=;
 b=HDE3pWiQpPwSs2pOXlk7gKKXEwEuexqAj8gwMvoKgaDhck/zXHYVdMG7ngdMGs62snTaWAlu1L1ukLaXbvWt7C3SvPXLRjhlTw9GZuBdQevcVC62nXK+fmGp7uHfnLzsmTP95rODWJ0pjY8Fjupo2oAfDGWPa0IAKCIkUKvGUUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 15:13:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb%2]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 15:13:06 +0000
Message-ID: <1f01f80c-d9b5-a77a-3ac8-32a8729a9198@amd.com>
Date: Wed, 14 Sep 2022 11:13:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220912175817.17985-1-Philip.Yang@amd.com>
 <20220913131926.24766-1-Philip.Yang@amd.com>
 <05e8e202-4a15-2cbb-3c27-4f5c18270c9e@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <05e8e202-4a15-2cbb-3c27-4f5c18270c9e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0045.namprd20.prod.outlook.com
 (2603:10b6:208:235::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c393cb-b163-49ff-3ab0-08da9663a06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lc/qV1K6pmykgRn4pwb/ZrooeafPuhEgMcWYgMdXwgMIr7iLJHCTlAtVlFzGKmCcIBaFNtoR9TJvfbeBaF8p2bdvRqtMbTen9Jvb4H093f6Xqb7u0A4FsUNt8QnB43MVLhqGzBridm1XhXv1DbAv/b6FzuJQFoU6KdkHg5/uBmWOcP9d5J/QBu5rOFLIY2oFMqsjVfwphNrDYcYIFiNRVyZSHsOGQgjsuUaPMXaWwN4gZVeZCZTsF8SzcU+6p56ylZLQ9Jm5AR4rD77g638yAb07vC78EJQ3TeJn14wj5g12Vx8QRQZPzD+EpkR+2kd++vHfUoS+nUVWq+wZEiZZhCs17RiTr4WTRsXa2eW5wRgdB4g/V/QaCdNlt66YGBF/VusA7IsM5BRlS2LuNgbhMVnJD+ugw2rzM3EmMwU9WVftQc98T4R0o9eeuo4ddRstTuREHWVHSNnJRf0sZ3gUmtmlyFbfQXTfgJu9khA6x1fdYCVL8K4l+mIj/0gt50AbcNX+pwudgpqmZaXMg3KTqFdEeZi+LdNU9DwuvmTZ/7wEJzmT+qwh43Q5lWqEFCywpayKEIdUlHX5noH1mXnBEfDHl1cysVLgYpdXsgnUBLlxWxkx7T/XZHkPwuF4AJyVhggXW4AHSjCZIStL1mFJg8bRUZ5aaX+5C5dipY33sGOfRPiZpMB3a8UazksXxoZdjfUvROs5EtPrcp6INnEYdoqqThQIFCI6O1n5gUBOYRueehrPRCeujOH0/WzPdA5YG6wKS5ZTz7Rhh5ZVqQ4lWu+KNKNAStLbvnxXRK8sX+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199015)(316002)(5660300002)(38100700002)(31696002)(66556008)(6512007)(186003)(478600001)(31686004)(53546011)(36756003)(4326008)(66946007)(110136005)(6506007)(83380400001)(6486002)(8676002)(26005)(66476007)(41300700001)(2906002)(2616005)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2pTR3NRU2d0eU8rUEQ1M1d1MUtDRlhyM1JDRDdUNVVEME12QjdpMjFlYk5o?=
 =?utf-8?B?QitrRnNudDVBUkgwRDdwd2RwRkFqMzZsQ3RaVHhnZDNIKzJJbGY3eFRZbmp6?=
 =?utf-8?B?NjJralRhMG55NnNvbTRId3NsR0hoREtlelllMU1NS0p0Rk9BdXRXV0hWTCtz?=
 =?utf-8?B?NTNjSHYxNzV2Y0w2M1prNWx6aCt5Q3B2a2Q2OHNndWlhdC9ESmVKVFlkNENG?=
 =?utf-8?B?eXZKc0s4QTJra2MrdnVGc0kyaWpKeUw5MENQd0YxbE9JeU5hcnFSb2RRM2NO?=
 =?utf-8?B?a2J0Wkk4QWFIN3pzMU45WkZhckg3LzlpQjdIMDJaMk9vcTlCaDV1T3RjVjdX?=
 =?utf-8?B?WU5tNS9SSmFtTnc3MXdnQ0NIa0IwTDV6S1JuV3NVY1VWQkpOcS9INXpFTllR?=
 =?utf-8?B?ODVTb09lODlES0xVYkNycWlqZVhEa2ZQRXVGdUt6QkMvekxZTGxrVHRMOExv?=
 =?utf-8?B?Q3VhLzdMRjIwOEJybnpGT2YvV3dWbThQZURTelo3UWlPRVVaWlBFYnp2NFhn?=
 =?utf-8?B?c3Q4Qi9CRmhjYXplanZkejBUUURzdXc5SnNFOUFQYWZFQjFKWUN1TE40cUVB?=
 =?utf-8?B?ZzNHUmYyd0NrK0NDVHkxcHBOeXVNckt3OEdFTTFZTHluMlpIVmNOdnFrdUFK?=
 =?utf-8?B?cndyTDhpSjVtU0JMc0ZESExCbTFOQWxUc3lKbmtWY3RFWDlKVmxxOXg1Mld1?=
 =?utf-8?B?WDhaaEhpd25oT2RTQ0oyWGdTWEcvbFlsVTZ0QTRBTytoR0g1MnlyQ2RnSkpC?=
 =?utf-8?B?UUlJd3Q0bFBVTWlZcTFWeWx0eGk1Y2NWb1lhRzQ2cFlwblZSOUYrR1ZvMENU?=
 =?utf-8?B?bXFETHVWMWJWd2w1elp2UFF3M1NCU3VncUN3NEtmejRLZHpkckpMR2tyZWlr?=
 =?utf-8?B?NmJJRkhBVkNEQ2JRVHV0QlM0VU5remliTW5lSzFpSWVTL1Bscm5uSk15RlU2?=
 =?utf-8?B?cTJoQ3ZCUlZocnNzNkN1MkVjSm5Vc2FrSUtPVEFCUC9MVk1td3JYalRubnY1?=
 =?utf-8?B?L1V6WU1WTFh3NnpYeWNnNklpZmlnUDV6NHpWKzVvNDZQL1gxOFphaUVpTUNW?=
 =?utf-8?B?UUN0bTIzRm9nMGVhWTg0V0VheGNRTEVCdVJRQjZGdHdnRldxTytKUEpVcjlL?=
 =?utf-8?B?ZVpmSlZIaTN2VUFBUUdiaG1HUmtNVFkvMHprSG45dTNoUGdMWUtlT0xhMmxM?=
 =?utf-8?B?NTllWFNyc3BLZm5XVGRJOE50Y2t4L0dmWHJJRkI2OVAvSEIxOGZvcVVUZTNX?=
 =?utf-8?B?dXJhL28vZk1VdktxdGJIYnpSbW1meHdqcjF4dXlxSVliQkgxMGRLUC8wdjIr?=
 =?utf-8?B?NVI2S2EzcEZ6MWVEVyt2bEhNQ0xDaFFjbVdhVWl5MjIvRkxMOW9PUmxkYnJX?=
 =?utf-8?B?UWM2aWo5SkY2Y01UbFBtTjFVUDhvY0ZkMVN0cU1FV05GVExCM2ZGQ00ybndX?=
 =?utf-8?B?cUlwZVk4OGtCcmtRL0RWVENMVUNLMnJyVFV1bDJ1TjFGZ3lIZXBNVDlLRWhH?=
 =?utf-8?B?cWdBa3g3dXVNTVFxN3FVVmtKVDFlMDJKWjVCeC9oZXVTM2s4bTY5L3pTYlR6?=
 =?utf-8?B?ZEdNUVY2b2JFeWFWd1E4RExqQkl5ZU5UNWhaMFhoWlNJRlZkdi9qaVJBQ0cy?=
 =?utf-8?B?S3oyTjNxUlFScmhlWjBWOUJSM1hHZ084QitXeklwaXl4bUlIaW9GMVdLL0Ra?=
 =?utf-8?B?Snh6NnlTSFU0TVg2dHdxanRaQUhwTXljdStaMDZCS2IzM3VyaTVzTjA0aW1n?=
 =?utf-8?B?ZFN0Ni9waWRGZWQzSW1RdnNIcEZGVHI3RUpoWmFsd0w5NXdzNm45M3F1dlJq?=
 =?utf-8?B?RSs4VnRvdVB1bFo5aHhuNnlxYThCTmxNcUtwalpVTFBEMjlPemJrQ3pXZjg3?=
 =?utf-8?B?TFVBRE44ajFCNnpPcnlabGNKTUNEYkg1UFkzbGtUem1JOGhSRkE4V1F2OE9M?=
 =?utf-8?B?YTMrZnZTa0x5SUZXNWI5S3F6enJYOGlKYnFKOWZaU0xKcXNKTUkwbDFDZnpn?=
 =?utf-8?B?YjYyOXhxakhEemNFaHE5Z1BUcXRPczJIb3lpSUhnY0dvMlR6QThjSnJWdjN6?=
 =?utf-8?B?NjhwNTRJcjJPbm9jaHdZbWdrZUNXclFwaXdZVW95S1FYYkYwUXhTZmtOTENo?=
 =?utf-8?Q?JQuA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c393cb-b163-49ff-3ab0-08da9663a06d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 15:13:06.6287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tB9KnpLww72ZE5OZU5UnSUVcNwGhISXP6GWryOiOgAU729shItNg67KBS8yz5U/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-13 16:10, Felix Kuehling wrote:
> Am 2022-09-13 um 09:19 schrieb Philip Yang:
>> Free page table BO from vm resv unlocked context generate below
>> warnings.
>>
>> Add a pt_free_work in vm to free page table BO from vm->pt_freed list.
>> pass vm resv unlock status from page table update caller, and add vm_bo
>> entry to vm->pt_freed list and schedule the pt_free_work if calling with
>> vm resv unlocked.
>>
>> WARNING: CPU: 12 PID: 3238 at
>> drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
>> Call Trace:
>>   amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>>   amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>>   amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>>   amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>>   svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>>   svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>>   unmap_vmas+0x9d/0x140
>>   unmap_region+0xa8/0x110
>>
>> WARNING: CPU: 0 PID: 1475 at
>> drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
>> Call Trace:
>>   dma_resv_iter_first+0x43/0xa0
>>   amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
>>   amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
>>   amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
>>   svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
>>   svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
>>   __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>   unmap_vmas+0x140/0x150
>>   unmap_region+0xa8/0x110
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 47 ++++++++++++++++++++---
>>   3 files changed, 51 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 59cac347baa3..27e6155053b6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>       spin_lock_init(&vm->invalidated_lock);
>>       INIT_LIST_HEAD(&vm->freed);
>>       INIT_LIST_HEAD(&vm->done);
>> +    INIT_LIST_HEAD(&vm->pt_freed);
>> +    INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>> +    spin_lock_init(&vm->pt_free_lock);
>>         /* create scheduler entities for page table updates */
>>       r = drm_sched_entity_init(&vm->immediate, 
>> DRM_SCHED_PRIORITY_NORMAL,
>> @@ -2244,6 +2247,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>           amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>>       }
>>   +    cancel_work_sync(&vm->pt_free_work);
>>       amdgpu_vm_pt_free_root(adev, vm);
>>       amdgpu_bo_unreserve(root);
>>       amdgpu_bo_unref(&root);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 9ecb7f663e19..b77fe838c327 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -276,6 +276,11 @@ struct amdgpu_vm {
>>       /* BOs which are invalidated, has been updated in the PTs */
>>       struct list_head        done;
>>   +    /* PT BOs scheduled to free and fill with zero if vm_resv is 
>> not hold */
>> +    struct list_head    pt_freed;
>> +    struct work_struct    pt_free_work;
>> +    spinlock_t        pt_free_lock;
>> +
>>       /* contains the page directory */
>>       struct amdgpu_vm_bo_base     root;
>>       struct dma_fence    *last_update;
>> @@ -471,6 +476,7 @@ int amdgpu_vm_pde_update(struct 
>> amdgpu_vm_update_params *params,
>>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>                 uint64_t start, uint64_t end,
>>                 uint64_t dst, uint64_t flags);
>> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>>     #if defined(CONFIG_DEBUG_FS)
>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>> seq_file *m);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 88de9f0d4728..c6f91731ecfb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -624,12 +624,22 @@ static int amdgpu_vm_pt_alloc(struct 
>> amdgpu_device *adev,
>>    *
>>    * @entry: PDE to free
>>    */
>> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>> +static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool 
>> unlocked)
>>   {
>>       struct amdgpu_bo *shadow;
>>         if (!entry->bo)
>>           return;
>> +
>> +    if (unlocked) {
>> +        spin_lock(&entry->vm->pt_free_lock);
>> +        list_move(&entry->vm_status, &entry->vm->pt_freed);
>> +        spin_unlock(&entry->vm->pt_free_lock);
>> +
>> +        schedule_work(&entry->vm->pt_free_work);
>> +        return;
>> +    }
>> +
>>       shadow = amdgpu_bo_shadowed(entry->bo);
>>       if (shadow) {
>>           ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>> @@ -641,6 +651,29 @@ static void amdgpu_vm_pt_free(struct 
>> amdgpu_vm_bo_base *entry)
>>       amdgpu_bo_unref(&entry->bo);
>>   }
>>   +void amdgpu_vm_pt_free_work(struct work_struct *work)
>> +{
>> +    struct amdgpu_vm_bo_base *entry, *next;
>> +    struct amdgpu_vm *vm;
>> +    struct amdgpu_bo *root;
>> +    LIST_HEAD(pt_freed);
>> +
>> +    vm = container_of(work, struct amdgpu_vm, pt_free_work);
>> +
>> +    spin_lock(&vm->pt_free_lock);
>> +    list_splice_init(&vm->pt_freed, &pt_freed);
>> +    spin_unlock(&vm->pt_free_lock);
>> +
>> +    root = amdgpu_bo_ref(vm->root.bo);
>
> I'm not sure why you need this extra reference. If your concern is, 
> that the root bo could disappear while the worker is running, it could 
> disappear even before the worker started running. In that case, you 
> should take the reference before scheduling the work. But I think 
> cancel_work_sync in amdgpu_vm_fini protects you from that. Therefore I 
> believe there is no need to take an extra reference here.
>
Yes, with cancel_work_sync in amdgpu_vm_fini, we don't need take vm 
reference here. I will remove it and modify others commented by 
Christian, send out v5 patch.

Thanks,

Philip

> Other than that, the patch looks good to me.
>
> Regards,
>   Felix
>
>
>> +    amdgpu_bo_reserve(root, true);
>> +
>> +    list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>> +        amdgpu_vm_pt_free(entry, false);
>> +
>> +    amdgpu_bo_unreserve(root);
>> +    amdgpu_bo_unref(&root);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>    *
>> @@ -652,16 +685,17 @@ static void amdgpu_vm_pt_free(struct 
>> amdgpu_vm_bo_base *entry)
>>    */
>>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>                     struct amdgpu_vm *vm,
>> -                  struct amdgpu_vm_pt_cursor *start)
>> +                  struct amdgpu_vm_pt_cursor *start,
>> +                  bool unlocked)
>>   {
>>       struct amdgpu_vm_pt_cursor cursor;
>>       struct amdgpu_vm_bo_base *entry;
>>         for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>> -        amdgpu_vm_pt_free(entry);
>> +        amdgpu_vm_pt_free(entry, unlocked);
>>         if (start)
>> -        amdgpu_vm_pt_free(start->entry);
>> +        amdgpu_vm_pt_free(start->entry, unlocked);
>>   }
>>     /**
>> @@ -673,7 +707,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>> amdgpu_device *adev,
>>    */
>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm)
>>   {
>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL);
>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>   }
>>     /**
>> @@ -966,7 +1000,8 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>                   if (cursor.entry->bo) {
>>                       params->table_freed = true;
>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>> -                                  &cursor);
>> +                                  &cursor,
>> +                                  params->unlocked);
>>                   }
>>                   amdgpu_vm_pt_next(adev, &cursor);
>>               }
