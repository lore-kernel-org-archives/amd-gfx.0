Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5022C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 16:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3046103C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 16:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A3046103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD82D6ED8E;
	Thu, 23 Sep 2021 16:21:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7056ED8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 16:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPN1JhBJf7enIa9hy//RwV8N1qwjWIGZ4FaZIU1zWOcXbies/VOe4C5+9fHtpJSY2WVxj7W3Ei5bBGSAwygGKgvgwrJJfhBms4Ofbp+uETRnCht64fwndR6rSJrVpbkYtTQ8AbP8BNi0FiMxVoL9ZPHk7aaorcz556uFvYS4NIUU9qdLyVNB4sYpXdOqMMIq1Ct5zJL5f7lh4jUAKbbXre6f21vM8x0sytk31yMZw6cLM6whd27BE8CGNfphRlc2smOMgHK3KnNniB6Jf41y8trF/69B6Z5crzar2rlFs5zNcRpPYRM9XoGCRyEZUqy0gIqOYpm0rma0KcTK0rJgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SjxozwlxnbNO94JffXHxdhilhotDWPXJAEN4IZEOn2g=;
 b=GygkySJ0RRdE5vlgMFKv6mdLgMmmDrOZFbdQiKx+kwfCuERYbNIguJSNv/w8BwFB+AiHO7aUzKRRmb1zUznEg5qjqAWEAeX/UknWLsl/qjjyU/y2T0AW1QW2Bwsq2iGvLN523usqu+dsRWxUkj638g8joU1hPdYapjWoQczuIVzMaeQ5LJFpNLfVblD3HbCnMf7l0dZIU4woyii2h9l6S4ZuvboJ9WYfwJN0BIFTThW8zTF5UO/esKFhmZNHlOLUkkvPpmNgRRwzsULo0XD/iBhY5y2mJLbo6eFKi/M/CAbIGXKVz14/rDxMfxV4AjmTLHwqKXIewiIS7Vk42pRURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjxozwlxnbNO94JffXHxdhilhotDWPXJAEN4IZEOn2g=;
 b=FXPTG8Zr+1ya5RNNSCJ+NAABVlMFO8wOzPtYOAGIptEj47b4f8Lrp7tJwq7lc8UQgGvu59llFyvsxqIqWXBmqA3nN5Vc2XASb3pu9jDRMhRGKU7wxepotPrMilucYfBz08JLXKWHbJLs7zqu4QxAeu60iZ2CdZOkRuZxiJaM13U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 16:21:26 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 16:21:26 +0000
Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
To: "Yu, Lang" <Lang.Yu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Huang, Ray" <Ray.Huang@amd.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <aae7844f-8d15-b8be-86c0-463572a9d931@amd.com>
Date: Thu, 23 Sep 2021 12:21:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::8) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT3PR01CA0084.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 16:21:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd62375d-fa45-4bde-226b-08d97eae3108
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51633DF4128323C63FAFBDFE92A39@BN9PR12MB5163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFbcl9xmnQWI8c1yXreBqW2DJV4NYghzOdMOgQ8JDyHKsU+3jSgATxTJy8jFDm0cPjFnGdBSWul1J7PhqWl3mWF+yrburIk81LPoG5vWS1yEqWAVGguuAqWu9xW8p12n8DiMxMEb+8B9cxAkvUiBCto6Ql8iUnji7t3FBH1qZGG9tve0W07xdP6kYPRp4InAlOEB7/iJYFdwsYHU3O6m37BycrTGS6QKesjD/jqSxTTkZfdIfcgRlkl0Kx+XRaJEmo0gX3EJL8gmCXQY9DpHfEabaOnM8uHjNH/7pAxrUAsbcBNx9X+rGtmLEJsJya6GixRWgozSQKEsIS8ocvuBiqUIt/eRPBU0AetN0khzoZXEyDBfwohe2oyUDDQMv2kJpsl4bMesTzExvEBT9FrrJOnydSoakiMLCYNRFEWssT7B3gfK8AB0oI8K2FK6tmc/XHTg+aibiqpiFhFd7kz7Ao2k0/CWEy3iz30JLJAVciLG3CCdRiduzmW1STSlCnbpykhPZU4OfKiSISnnQQzcRI5SODdW25RclPfft0HcArbGEdC20hpOD7cGRFT6bMlFrLuSfDDEMESZH5VjKubqvL784N9gMJ5rXe5IGGS54zI/rO6TiaMXspAR+yHudu+WVnGxdr/O3BGesAhpsvGRClOzVT9muEkOf2wPwuEQmvFI9c6tRAyBkIv45b6uj3GHChKi+1hOv0svZGPzFDr9G8iztxcHtrEnFhG79AtHrzrMxljHo/loX6RmcCui0FVa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(8676002)(316002)(8936002)(5660300002)(44832011)(16576012)(86362001)(110136005)(2616005)(956004)(4326008)(83380400001)(2906002)(31696002)(66556008)(38100700002)(31686004)(186003)(53546011)(66946007)(26005)(36756003)(6486002)(36916002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkxIUmJTWEhXSCtDSTZIUnV0SU10S21xWjNndmE0KzA2NVEwVGVRK283MU1W?=
 =?utf-8?B?bktwM1d5UG12SXlZWlRwVlE1MStETDl2U1ZqYTUxbEQyUzR1ayszMHpieXpv?=
 =?utf-8?B?QkdQdml1ZDZwVXZ3VDl0RnVqRmJuTUpsaFY5NU9xTFRTcC9rTTdmaVRpYnRr?=
 =?utf-8?B?RDBKcTl3WmVVNFpJcGllVFhHUlNlbFN1cmZCa21KUU1ORUc5dDVjaWE3bkJK?=
 =?utf-8?B?Y241NGNVK3dtckg5bXFTckVYbXhCWHJUaEVIVVdEejBkcnpJTkZKRmNlYmNU?=
 =?utf-8?B?enFNdS93ejZ0eEl0aWxHd2RTMHRSRjIxT09WTTFya1NaUUd2T3YvWmN4UDJM?=
 =?utf-8?B?WUEzeFR4eVo2MkJ2MGlVeG81RmxxMFZEbE5MNXBZMEtWMWRIdjBOU0tMRTlo?=
 =?utf-8?B?L0dVRWw3WXp0K0dlZ2xBSTd6MnJOaHg2cE9EcHI0L0VUb1hJWVlTOHdHMnBl?=
 =?utf-8?B?ZTI5aG4wOU94TEd1aGNCZHlLbGhsMWdpQ2lDWSs4VGhhT09IVGxRajVDdEhq?=
 =?utf-8?B?ZWhPaXFnZ1NBOTZWdUkvZ1kvZUNQOGVUNTlFUGMzY0dyb2hYQzAzNm9kU3ZB?=
 =?utf-8?B?L250MHpSclhIa0IrenZTM3E2N0FEUnpMY3ZnNjRZNGEvMWdVaFR6Mmo5MWEr?=
 =?utf-8?B?S2x1VEtxT2xiSnBQWnV3M2U3VWV0RmZuMk9yM2NWQWFaVjFPZ2tkWjJVNFJE?=
 =?utf-8?B?SnFwN2s0UkxTYUpIQjJRanhOLzJxNlRsUTBKSXR6R2M1KzNLMjdUMHBPRTdt?=
 =?utf-8?B?ZFkzUG0yQ3VkL0F3WXY0YW9MRGdZQnVEUXNZLzVwSFFVTXZuYWpwZmNkTHZL?=
 =?utf-8?B?U3hkZkU4eENIOCtVQXYxVklWT1NNKzRKZ1RnQ2ZFT2ZkYm9tdlpQeUlRMWpZ?=
 =?utf-8?B?ZVgzQUpZMkNtVnRGdTZmR053cWlPZVFwSUZPY05tdzBtTmY4WEZ1SCtva1I2?=
 =?utf-8?B?UkdYVjVRNXBxblBaWFRQV0d5SjJLa256dWIxdzFLcEZBbzk4T2N3M3A3WDFC?=
 =?utf-8?B?Y2NnS1AvQ3Q3YUpRMlZWSzlLajJnVlRzNWI3aVB1SWRUV1RncVJISWhqa0d1?=
 =?utf-8?B?REkzWXFLeU1lZUUyUStaTElCdHJudjhIQmFoRE5PSnQ5Y05xcjdCdXFqQ2hO?=
 =?utf-8?B?RG56MVY5Z3I4ZnRJU3R6eXdUOFhmT0V4TkhqeHV1cjdINmRtaVdSK0NBQW5U?=
 =?utf-8?B?Vyt0ZFFPMk5kZ2tRSlNSZ3NTUkdwcEhRcFdDbjhFRDc5ZGxYUmZzOWh6REUz?=
 =?utf-8?B?UUZ5ZURwcGdNd3Rvd3pmb3lFeVpXU0tiVlhvYXJWRzFOeUhsaVRKNlptdHRP?=
 =?utf-8?B?THA5Um0rNmdITHgxcFJNaFJXdnJVS1dDaGxiaXQwOXA3TkZhc2VkNFRzSU9i?=
 =?utf-8?B?Z21NQ0pkSS8rS29vQmVtYmZ2VTFRT3liMnl3NHl5SVUrUjU2OE5jRHRTQmN1?=
 =?utf-8?B?UEFIaEhXcDF6enJIZFNOczIvRjE0OEhtbnQ4UklDNGdXWHprR1lFWVZzaVF4?=
 =?utf-8?B?VTN1RjNSYVdLSmRXcDYxMDd0OHpNZFkycHJEZzlxVDhSenE3S1ZYTll3aWgy?=
 =?utf-8?B?dDlYdFc1YlV4aG4rLzRJUlRwME9lNFhHYzFQMlpHNXh6RFp1MGxYZ0FucjNO?=
 =?utf-8?B?R1d5ZTRtUGUyVEVRa09OZThhdmFwcWMrVmNTeVFrR3FrYjFEWk96OVY3YzEz?=
 =?utf-8?B?Rlp2MnpZSEZnekN0cUY5N0loZS9ZeW95MjIwb2VKTzlVbzVHNTNSaGpnNUE4?=
 =?utf-8?Q?64G4LXQ61hc6wjKiJYZIH4mS2pqu0uCKGP4DVqd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd62375d-fa45-4bde-226b-08d97eae3108
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 16:21:26.2657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oy/k0fMC/3+JuQCUD0b133SOBR4Pd1DqxsdpmuRtvFkbc0VPTbQ42qEqGUJuL0h0QoFFjIwh8jAccEJc6UWw8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
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


On 2021-09-23 8:09 a.m., Yu, Lang wrote:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, September 23, 2021 7:40 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Christian K nig
>> <C3B6christian.koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
>>
>>
>>
>> Am 23.09.21 um 11:44 schrieb Lang Yu:
>>> If a BO is pinned, unpin it before freeing it.
>>>
>>> Call Trace:
>>> 	ttm_bo_put+0x30/0x50 [ttm]
>>> 	amdgpu_bo_unref+0x1e/0x30 [amdgpu]
>>> 	amdgpu_gem_object_free+0x34/0x50 [amdgpu]
>>> 	drm_gem_object_free+0x1d/0x30 [drm]
>>> 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x31f/0x3a0 [amdgpu]
>>> 	kfd_process_device_free_bos+0xa3/0xf0 [amdgpu]
>>> 	kfd_process_wq_release+0x224/0x2e0 [amdgpu]
>>> 	process_one_work+0x220/0x3c0
>>> 	worker_thread+0x4d/0x3f0
>>> 	kthread+0x114/0x150
>>> 	process_one_work+0x3c0/0x3c0
>>> 	kthread_park+0x90/0x90
>>> 	ret_from_fork+0x22/0x30
>>>
>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 2d6b2d77b738..7e693b064072 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1567,6 +1567,9 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>    	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,
>>>    		mem->va + bo_size * (1 + mem->aql_queue));
>>>
>>> +	if (mem->bo->tbo.pin_count)
>>> +		amdgpu_bo_unpin(mem->bo);
>>> +
>> NAK, using mem->bo->tbo.pin_count like this is illegal.
> I didn't  get your point. I referred to function-"void amdgpu_bo_unpin(struct amdgpu_bo *bo)",
> which uses it like this.
>
>> Where was the BO pinned in the first place?
> I found two places:
>
> 	ret = kfd_process_alloc_gpuvm(pdd, qpd->ib_base, PAGE_SIZE, flags,
> 				      &kaddr);
>
> 	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
> 				      KFD_CWSR_TBA_TMA_SIZE, flags, &kaddr);

These two allocations are created by the kernel mode driver. There is 
another case where a user-allocated BO can get pinned because we need to 
kmap it (in kfd_ioctl_create_event).

Regards,
   Felix


> Regards,
> Lang
>
>> Christian.
>>
>>>    	ret = unreserve_bo_and_vms(&ctx, false, false);
>>>
>>>    	/* Remove from VM internal data structures */
