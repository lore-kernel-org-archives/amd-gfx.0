Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1732BC6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 14:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4174710E4D1;
	Mon, 12 Sep 2022 14:01:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF6D10E4D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 14:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGux+Y/lD58QQkIXoEjIA3ITxlQ/nEB5p+QMC6m3pivZktA9VP0ZAJQwzmAEhdKMiLNugHjA0m5NuC9A8g+KCtk43GHTn+Mf5h/bM63aj48skl3yEwQIEOWvM5xZ+RYOeApi1OKeV3d6ph+ZyKrNwjNhpADyI2ROmEPRTpx8DkBBhunHNjamZUz2AISib7kYJVYWPZSckNmW7t0OZ1qvit8ySTsBXAbDGbULqVL1qryRr/q+aXhSdvjTDiUpl6JC+G01a4orXHgkTWcf36rldHf1T56zK0g9W5kwqCTCS4Zf53QZg+kLMVybk1hg6Jz6yZa6tMabt6WPxWbt6i6VVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igZqoWSzdyRs2B4rzcntOjAD/aznXBePNYJN1/H4Ldg=;
 b=CacEQFe0wzbDwNUvqR3oEd0BSy+m/yjKW0oDfcryf2f5ZCp+8TK8rtinuqON8qGU9V/hdP/LIogUS30Np65oQwE/cVtBSoTwohPlMzTfkkXa9g5vEyzy7CViLKYHIOezbjMRZKBaQL2T5d6mbdt6D1gAmWHOE9EoLcePff2T6HARxkOYHpL1Tk5worC+gOrXXysfjxrWarUnQWF+BTcYfXS1VdETgFyT5XlFoGsDYFlOzjHsaND0UyNx5WviBasNWlOYylOcBw8/B6ZrTTjtiGQZdwfy6pYN8SJ1+VmRZ44QEKh3yBPMm/HRQLkQbmmUGhN2zpuCV2ITW6jnD5JWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igZqoWSzdyRs2B4rzcntOjAD/aznXBePNYJN1/H4Ldg=;
 b=DGpbOoZhr8seP3xgSzKZBtn19Zu36Gv4z9FA/8z3rqvS5TzzNwfrjdTit/11KRdxyj/rSTvXOmFhntvqUvv5wbujPZy+W9Jr0sZQoM4ChxljKfUSlDsVY9EhvzftHdysfUK1PX/m2YJ5Mh+tu3IlBCK6Fr339jeTrGCIprp2CAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Mon, 12 Sep
 2022 14:01:30 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb%2]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:01:30 +0000
Message-ID: <17d11b8b-ba96-2b8c-3655-f784fb4ee55d@amd.com>
Date: Mon, 12 Sep 2022 10:01:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220909182502.13995-1-Philip.Yang@amd.com>
 <d00251a6-dae3-2b42-7c26-71fee4a06fe5@gmail.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <d00251a6-dae3-2b42-7c26-71fee4a06fe5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0018.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: e809acdb-2169-4c57-ea23-08da94c74af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgTfs/AdPti/OpeJLxSAcDb7zCV/Sw8ddxXvl4pgV05OFCbGi/dk7jJpYM9Zgq04Ugt65RKTJ8z566WmaUTDfueVtnDCrFgspbMt2VgC5x9AgUfQFpJAVpZRArb/1tJPaBz/mnrqH/2l3lkDTUPgFFHsCnsQRdwgoUfyM5M0fH4A+ctcZXalUOp6l3WpYhgxweKccDwT4CzUr3+fa2MMnSLM3ZbDVupWW2nbEE5NTmZUO4PsGYY89Oeqws8cnvdIph89d6OL8+jnT7pG0Erxh28+iBWX+M9hxhqKancCTjXAABVh0PWkN/7aWNRM8XuaXTF04tE6nt4+EyPOg5tN9Am7UkExcUUH8f2hKMiT4svWrr0fdaSSu96csBLG1pSdTu4F7KqvhmRDGmkGDTbryOvdW8waG087N8Os8C0BK0gSQwL1Bk4ma4f5bAvpynKe1SWZVG+XQBN4/v/JDdqS8X+aVTZ302lXzKMkroCKfH3HtcgW8G8M4rkqxJptj9cvXV/yoLYOkQ/CriAN0H/2dsDwPtbjnNlWx7sAlFQwrc2mI+nCBRQD1cGK6Qk+v+3I3q7lIt9nkRXd8T/BoWlzs61z4bDgCzRE+a4B9KMty2MjyVcTLWx/SXfeb7TlPmr0ccqvDI4QzaGIIlcDbTDeBfcvRpNdvUrItnims8K9y18ZlESqr17zEfWpugx1jp8Mx2gAfQHdPsom7nUP3TL+rFi1N9VjALtoiXuj3voDuYR6Lp1CM0Prys15w4Ck1M9ymGL1zuu2fJrPVisshl3BrOGxiho3EskNCXqrBRngd2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(31696002)(38100700002)(8676002)(66556008)(66946007)(66476007)(4326008)(6512007)(26005)(53546011)(6506007)(478600001)(6486002)(110136005)(41300700001)(316002)(31686004)(83380400001)(66574015)(36756003)(2906002)(8936002)(5660300002)(2616005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21hdWQ5RGg0SVNiaWJmK1hFZkI2WXQ1cjY5UklkSVdMUTdBLzEvOXE5a0Vu?=
 =?utf-8?B?Z0VTQ1RONE1qejQzQmU0ZjJqSThiNzdHalFWRkRrcHB3MWt0ZWlHaDFXRlBO?=
 =?utf-8?B?VU9JMEQwU3BGZkd0WVBtNkVkR0hZd3ozWnJ4dDBFVzJsbkxwcXFmN2hnS0Vh?=
 =?utf-8?B?UDhHTkJDWEZKcndaZWExdStsUkZuRzIvWEErUlRxcUtBQmthMlBKbzVjbGhk?=
 =?utf-8?B?Q2NIaFZSREpTb3g0K3V6MGh2d0Z3TXF0ZXZibEIzV1JyWGxZc3B3eEtXb2Zi?=
 =?utf-8?B?MGNIQ0g2RDdUWWwwMjZLSGZKa3l6NWMxUjFpUmxxTFJLRHVqMXFHOTQ1d2cr?=
 =?utf-8?B?bnU4Ui9HNXRVbC9BVU5KL0d5aWxmK1lneXBGSWlwRHVWVXpFNGlaVFlrajkr?=
 =?utf-8?B?OFJXVjJVN3ZLQ09iNk1GbXQwVytvYnRwZE9mekFtSmVnVkdSZzM0S3dhUnYz?=
 =?utf-8?B?bGdwNHFWR1o3TWp4dFBSaE9HU3NUTDFNVXpiaGJ5VWw3WjdhKytnOWZuL1l0?=
 =?utf-8?B?S0M3UjljSlRvYmZSYU9ELzZ0NTJpZWRYZXh0QjU3WGdhbDJCNE5TcjhnWElK?=
 =?utf-8?B?Uyt1QnVINWJPL21ENmZwTFVMN2RlR3REMTU2dGRYYm9abDNXRWI2b2svOVl1?=
 =?utf-8?B?cXhjdDNRSGEvOHAzRklwSVBLSUlnUUlUd3NJQlVMZThJenBxOGdlOU0wZFdK?=
 =?utf-8?B?MFhIRXkyR3B2S0cvMnJsSUZKaStHd2orMlM2QW1laUxXMEtuV0dQQnRVcDF1?=
 =?utf-8?B?ZzQzK2taR2N2aXJnQ3pxQ0NwYkRWdUZRV3lzQUxPOFhjNHQwYmxDZWRoL1Zw?=
 =?utf-8?B?SWZHUkpoYkphMGtoalZjODZMY3BGbnV0cE5pOFNNV0U0T3lhTlNqSy80NFhw?=
 =?utf-8?B?ei9MTzByTDdLdm1iL2tROWF3b3BXaG0yZTBHVm5ndjVTU1A2bXRwQW13aStX?=
 =?utf-8?B?NXI2b1FxclhDZkNOQWx0SkhYQ1BPd01MVGdwZWc0THgwQmdVdHhIMU5rWUpp?=
 =?utf-8?B?STBBb2tzZDZDd1pwS1JuSXpNYTYzVVhRZTl5ZkdLKzl2eEd5Uzl3VXg1Y3pE?=
 =?utf-8?B?ajd6TlVBZ0NWNFVHY3lwb24yQkdZN2lDNkt3UEk5NTdMT1NBTktLQ2dzY2ZP?=
 =?utf-8?B?K3FSTEdKSTlHcDZMemJzanhJOFVtSFRxK21xZHRON0JRZ0FLandaZmJIV3hz?=
 =?utf-8?B?THNQNVlML3BLeW9TdmdlSlBSVW11WDBodGJqY3BPSVRoVkdwaFI1RlFlU0Yw?=
 =?utf-8?B?aEZ5cVMxZFBtcE41ZTZBbldUaU9Kc0VJYjZqclNnZUZZallPMDAwTy9WTVNB?=
 =?utf-8?B?Mk0zUmRWUGhEZmZRVlhmclMzRUtJYjBsaVFnUTlmN1RxY0hDSFJMQkJWb3Bj?=
 =?utf-8?B?NVZMOWYwclZsOVdMWjBudXY2U0ZTMXF5N2NERGFob0tPWDNQRVA2M1hNak1t?=
 =?utf-8?B?Q3VMSWZXRUh6S1FIdUFwdkUwNmQ3WEtvNXg3bHRxY0c2d2FhSmtKeXp1bEhQ?=
 =?utf-8?B?YmsxNjZzMDBsVWVoZVhsY0N1d1pySHVyZ3AzRHNXNmpnTTkvcnBlZ0NXOWwy?=
 =?utf-8?B?aUtlOEN0bW1JNlp6RFBaZ3AwS3IxZzFIVU9zUEM2NnlFaU9DdkwzZis0ZGVH?=
 =?utf-8?B?c1diVjQrRGROWW5ZOXZ4YmNyNHl6OG1nbVJ5MUpHeVlydmZHd1c3clY4YUYz?=
 =?utf-8?B?bmQ1bjJGaDJOY2x1ZkxkY2tEQjRkSUVTU2NSMEZmbk54QmV1MmJvL21uSVd1?=
 =?utf-8?B?dUdNQXZUUzZEY3BLeFY1WWpyei9pZmw2NnRMZzhwQStzR29MTmR6KzEzUjFT?=
 =?utf-8?B?UVhMU3NYd3k4enowZkJHV3B0WFVBc01oZzNEdGpBdWFDZC83NFdjMFp0T3E1?=
 =?utf-8?B?eEVrSEtObE8ydW1aOTdhTzhoSDhEczdBMWpqaGM1SS9hU2VwUys5dk9FdWx0?=
 =?utf-8?B?NjJhL05lNW9ZTURUTEpGYjFDeEZ3L2dHZzlxcUxzM05vY2xsakMrV2tNcG1N?=
 =?utf-8?B?S21jVkhSMTNSSEVPbXhJYm9Rd1FkZFBCbC9ZKzlzdURvaWI0WmJGakNxdHdh?=
 =?utf-8?B?Vi9zbHlQSGI2Qy82dnJIc0g4MEdMVjFTSUltQUpSeTNseFNHWWE0MCtLSnM2?=
 =?utf-8?Q?inrI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e809acdb-2169-4c57-ea23-08da94c74af9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:01:30.4578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMNrB7RmlNDsB3CqslBoO1fiR+8KQHSryjNEjlScbCXZWqrvzO+AebGIYPA7rmRi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
Cc: felix.kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-12 06:22, Christian König wrote:
> Am 09.09.22 um 20:25 schrieb Philip Yang:
>> Free page table BO from vm resv unlocked context generate below
>> warnings.
>>
>> Add a free_work in vm_bo base of each page table BO, pass vm resv
>> unlock status from page table update caller, and schedule the
>> work if calling with vm resv unlocked.
>>
>>   WARNING: CPU: 12 PID: 3238 at
>>   drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
>>   Call Trace:
>>    amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>>    amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>>    amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>>    amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>>    svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>>    svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>>    unmap_vmas+0x9d/0x140
>>    unmap_region+0xa8/0x110
>>
>>   WARNING: CPU: 0 PID: 1475 at
>>   drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
>>   Call Trace:
>>    dma_resv_iter_first+0x43/0xa0
>>    amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
>>    amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
>>    amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
>>    svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
>>    svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
>>    __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>    unmap_vmas+0x140/0x150
>>    unmap_region+0xa8/0x110
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 40 +++++++++++++++++++----
>>   2 files changed, 37 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 9ecb7f663e19..ac7cd2c738e5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -150,6 +150,9 @@ struct amdgpu_vm_bo_base {
>>         /* protected by the BO being reserved */
>>       bool                moved;
>> +
>> +    /* work to free pt bo if vm resv is not hold */
>> +    struct work_struct              free_work;
>
> Oh, this is a pretty clear NAK. We can't increase the size of this 
> struct.
>
> Instead just come up with a single worker in the VM and a new state 
> for the page tables.

Good idea, I agree it is too much overhead to add a worker in each pt 
bo. I will send v2 patch.

Regards,

Philip

>
> Regards,
> Christian.
>
>>   };
>>     /* provided by hw blocks that can write ptes, e.g., sdma */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 88de9f0d4728..e6f6d7e6368f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -37,6 +37,8 @@ struct amdgpu_vm_pt_cursor {
>>       unsigned int level;
>>   };
>>   +static void amdgpu_vm_pt_free_work(struct work_struct *work);
>> +
>>   /**
>>    * amdgpu_vm_pt_level_shift - return the addr shift for each level
>>    *
>> @@ -607,6 +609,7 @@ static int amdgpu_vm_pt_alloc(struct 
>> amdgpu_device *adev,
>>       pt_bo = &pt->bo;
>>       pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
>>       amdgpu_vm_bo_base_init(entry, vm, pt_bo);
>> +    INIT_WORK(&entry->free_work, amdgpu_vm_pt_free_work);
>>       r = amdgpu_vm_pt_clear(adev, vm, pt, immediate);
>>       if (r)
>>           goto error_free_pt;
>> @@ -624,23 +627,46 @@ static int amdgpu_vm_pt_alloc(struct 
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
>> +        schedule_work(&entry->free_work);
>> +        return;
>> +    }
>> +
>>       shadow = amdgpu_bo_shadowed(entry->bo);
>>       if (shadow) {
>>           ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>>           amdgpu_bo_unref(&shadow);
>>       }
>>       ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>> +
>>       entry->bo->vm_bo = NULL;
>>       list_del(&entry->vm_status);
>>       amdgpu_bo_unref(&entry->bo);
>>   }
>>   +static void amdgpu_vm_pt_free_work(struct work_struct *work)
>> +{
>> +    struct amdgpu_vm_bo_base *entry;
>> +    struct amdgpu_bo *root;
>> +
>> +    entry = container_of(work, struct amdgpu_vm_bo_base, delayed_work);
>> +
>> +    root = amdgpu_bo_ref(entry->vm->root.bo);
>> +    amdgpu_bo_reserve(root, true);
>> +
>> +    amdgpu_vm_pt_free(entry, true);
>> +
>> +    amdgpu_bo_unreserve(root);
>> +    amdgpu_bo_unref(&root);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>    *
>> @@ -652,16 +678,17 @@ static void amdgpu_vm_pt_free(struct 
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
>> @@ -673,7 +700,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>> amdgpu_device *adev,
>>    */
>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm)
>>   {
>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL);
>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>   }
>>     /**
>> @@ -966,7 +993,8 @@ int amdgpu_vm_ptes_update(struct 
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
>
