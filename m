Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BEAC6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 15:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF1210E751;
	Tue, 13 Sep 2022 15:05:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E3210E751
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 15:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUGc83y78pEzMVFeJiHEiw/ezNLIh6u3babbWGGITH9a2K1N1ZX8wHlwxTrDFlOvFevmDqFVYUySIaI7CegHdGnN6cefkrbIK+WV08CnxvBXKNdjYuEb/1++8szB5hZks3Zrd2Txp1K/S9p9Guunynsi1n0Gkl0GQDEGT2DFbp7mN+EL73a5fj7ewNGPrdRr8kfZZwebUiPxlvbZ5DZDb5AEkSFwNYVYvD1fQ0/Yfcg3dBv6kPGfzw6dVe9jRoT26U1Hi18HRwic6nedyzkCSApCBkKY/nbIodRWZX+Cn7xVCC9bnPGGqVyvF2hgnmJ2B/UNGmuf1sqTINebcogZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJTbE4lKsAhPj4RB35MvSu4jUt2dxDdr7mEx1qAYjNk=;
 b=W82gkfNlsCs1FJkPMPav1747nt6wME3tdM36LjV0Ncz+38bcDlqvIZYl2VavrO0g2sET9oNjabmBzyGJB5HhCowrfdLssjypnM7IH4VIaADRRrXjntCSuimicokX+1n0tw7DAs+LL53ZSWsp2qRfrOJAylSCbXo5zhJUphCAzEsx4QQ6TqDXfiSUFyCNeFb+d+dsIVu8eH28F9GpoPp8quak8j0zYP/J1tRlrMFsC+VL51l4gMn7dctUF6yk0XdM89OwAAsuYQjDGsUNfo1KcSqgGuni3qbH31hcfV8vXCfvyE4AWyRwfJrpDcUF+6TdjamcQnZnjoiOKeytVmq3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJTbE4lKsAhPj4RB35MvSu4jUt2dxDdr7mEx1qAYjNk=;
 b=GoS424gNcE/xInXaZ0SCXZ7P3uZ66QtKyeAUNX2dceP/St0pPiCm9XvGZsNdPJwhPoV7tRmVQ+fEkt0aQz65FFE+EMWhe8pS+Vgge+BTudmy4S7yEEbQ/ulqm/jPSpvBFHD0igzVavC63UeZ8ZhwCy9YCGMc9qZJqZz/7hqx5ME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA0PR12MB4589.namprd12.prod.outlook.com (2603:10b6:806:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Tue, 13 Sep
 2022 15:05:26 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b5bf:2f0b:c13e:36bb%2]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 15:05:26 +0000
Message-ID: <45117a88-be5c-0024-3273-be5544fe3e08@amd.com>
Date: Tue, 13 Sep 2022 11:05:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Track unified memory when changing xnack
 mode
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220912180447.19622-1-Philip.Yang@amd.com>
 <022a8a66-4dfe-4001-96cc-2cd752a81586@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <022a8a66-4dfe-4001-96cc-2cd752a81586@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:208:238::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA0PR12MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b5a7c6-3fe3-4538-38b2-08da95996394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kECQbdXwko7Ykk16khWg5aGucQomUww43+hVieJKTjL2uiYD8KBj1w+3237yhIzhyXAVEb2wTS4rllVzJ623abMs52UFZJrVVCQQiBy1rQJ9JkU7Ot/k9VLFoJ0uXwH6DDW7hSLPjCs/4DQNw3lFX+9Ik+g04q5kG3Rhlextl1XZU+NhsgU4pY4dzeCLkPYlm8X31ZRb7gbBGrHP+AIWnnuS6W5aPePfJc0wvj24fDr5eBqE6CFGuMkXubD7vLQuR2ESZsioDQiqq1Mj6XaGx2O4s6ZUO7Od06/kQO7EMB3wVnk3vVknd/9vS4ArUIzkeAQIqWzqMqdjtjigdykEdjhesaM6N+x+leFnEidMXiTHQebWFqPrYQkfM7iLjbDc1DpPmilRvUcdArJFIECLc5M2gn+cSDmlh/tOYZTdXsiqyl84dl28yVwMGTtw+Tjkj/wxyZVLKJ6rd8LrMUolJUjTBJymRT6gN+yxGXtluBmu2Qm4nxV3B3CZlVTpUUsTxfkVjV2/kjTGGD6yyPXwft0TJ9igc7kmh+FO7Qvr3i/R+4w9ZhdxtmHrU6xJwltw/0jhLmTs4SRoijQQT2zppQq778cGH4EXyWaYZhGSWouZkh/jDb+7haQKYvDB73iVLnAO8VtDfdtSPtvqwJfcDt0LrurX+VVCAEZQEG3zgTilV5MKQBRpZRMCveDR2EPkiTm+aHmUWefcFILejfQ1O97/GQb4AIqEclvfMO9aRRezaN45vIxIffPOOgb8lj4+Ym5YHSvZrStirpPP6yFBle0qDa3SfwxPtlsPu72yAG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(31696002)(186003)(6486002)(53546011)(316002)(41300700001)(36756003)(110136005)(478600001)(8936002)(83380400001)(38100700002)(31686004)(66556008)(6506007)(6512007)(2616005)(5660300002)(66946007)(26005)(8676002)(66476007)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFNQzd6SkFXNUFvSXhvOVM5cFVaQ3h4YW5nM3RJMWhrTkRTRzNCTTFxN3ov?=
 =?utf-8?B?M2tQTGNYakRIc3FiUG1IY3JFTS9hdktLUHZuUHgrY2kxUnRVNWdITkJWeEtp?=
 =?utf-8?B?bEFIeU5yM295cldvcmdNcVVOOWxwMXV0ZDVGdVZoM0JwZ0FpOVFhSEY2UVZS?=
 =?utf-8?B?RExUaWJEdHVUc3puQWtFcEZzSGdJbldZbFprMWdSVDYyNjNDSUlOWk12bW5J?=
 =?utf-8?B?blhmVE90VWNyZ0NWemdESVllZ3U5TU9XMmxtT25KMU9iem5XRXAxQThxLzI2?=
 =?utf-8?B?ZnpNQWNxVE4zVDFOVHpIcEpVajd4bU0xZDFzRjNXVFVMMTF1QlViRW5YRFhF?=
 =?utf-8?B?MHRxcTcra2UwSVpKdEdVdzRaLzg5NDJNOXhnbTNPUDhsWUNQekQzbC82ZUt2?=
 =?utf-8?B?SVd1cndVNlp5dDY1ekFpVVBlUkZtL1N1SHdhTEEwYTV4M3RaaDZKejg3dmFE?=
 =?utf-8?B?dkRUMDNPMXd1N2QwV3lCenFwS0ZFK3dDZXRJdlNnalptY0lRcGlZQXJaN3dv?=
 =?utf-8?B?YXQwZEM3OWJwVXZrZlVFOG4rbW00YnRkaVpLc0FIRnRWcE1VOWFQUFB5ZStB?=
 =?utf-8?B?TzErbGNtbXdWRENoQTN1ejJoemJZYVZacjk1S1JWTUx5VFdpK1hrZDU5YWFU?=
 =?utf-8?B?N1JSZVFQRmFVaGJRS1lVUGw5Ni9EdnJ4WXp4NTF6czlWaUVHWHdzaG5KbEJD?=
 =?utf-8?B?UVpKRG5hY25iajQ0SWNJVzlLOFdyQklZU0lEQzlRUzAzbFViSDN5b1NVK3RW?=
 =?utf-8?B?dzRTbHh5UDY0QkpQOTlTbmpSZlBMekZMa0NZUDQrTHAzcUNud3prYWNtbVk4?=
 =?utf-8?B?UFBTTndmL2s5WktNdm80WDN6M21BcXhBZVpoRTdwOEpLTk1HMnlySnBvM2JF?=
 =?utf-8?B?eWw3cmc3TzVicjR1V1F3OVh1bnFMcGVubXYveG5zektvRStEbzRnbTlLa1RG?=
 =?utf-8?B?aWNjaW52WmVyR0VLTWVqMUc2U3Z6RnlSaHBKVTVqbEJRR25aVWtQbmJBOTVY?=
 =?utf-8?B?bFhISWlHTyt5d0NMTGgzKzJ4L3pPTURlV3hlRndnUG9nWUhPWlpYTmQ4OW1D?=
 =?utf-8?B?WVg2cnZwNnVOdVA4Si8xZVpMVEZ6ZEd4ZVd1VStkNHpvUC9Wc3lEd2x4blNy?=
 =?utf-8?B?RnZTVHduWnJGT2ExSm9YYVYxbUNRREV1dTk0UitUVnEyVm1IREo5UWdKbU5C?=
 =?utf-8?B?ZmJBSjR4bnY0Z0xoaUFnb3hsWDlEWVNVa1VweHAxczA3V1RsdTdUUmVMN3BH?=
 =?utf-8?B?Uk1Tdnk5dnFGZVpUekZkWkdLZzFvUWVGNjNzb2RvSnNacVQ5N29ORmZJZUh5?=
 =?utf-8?B?WitqalUyUW94VHRZM3RSZkpTTDFhR2F1a3QxN1NOOFhPQmQrWFZ1WGlCQlNP?=
 =?utf-8?B?S3Bsc0MreFZGZWpnaThtQlYrMHBXL1VvZ3dhM0ZBMGtCSUprY1JHWTl6V0Rz?=
 =?utf-8?B?bXBXc0R4MEVFZVZPMUhHa0NpWFhYMy83NGgwSEYxWEJxS0hDU0dFdDdiRGlR?=
 =?utf-8?B?S010dlMwQVRCbFVUY1ZDOUJ2Zk9hV3VwTFNhbjIzOWt1N28vQ2ZZczBzNGZ4?=
 =?utf-8?B?QzJSWVFhcXVkTG11b3VrMWFXeGZ4dnNvUTdxa0kzMGllNWNESVFlWHRnbWtl?=
 =?utf-8?B?WC9QaGpCTEhUaGEyV09PKzZzTDFTVHJTcDI5MkY5UHJlSDQzSXdxdUg4bTBl?=
 =?utf-8?B?aTV0WVRzbDdLRElIVk4vMndNK2k1cTlmWExyZ2IrWCtJL09ka2VRSmdCdEd4?=
 =?utf-8?B?VDJqeUFEOFFHRVNtWlZ6elRQWVlLSjJ0OTZRQ1lwSmxGU01nb3MvcCthQjJk?=
 =?utf-8?B?SHVQWjdKRVpzUk9PRXFqUjlqSW9VV3FlRE9SVWpsWUlWeEFqY0lva0VXUWpT?=
 =?utf-8?B?a3ZuOUtzM0MwOXIrdHlPZXh3eUp3Wm5kWmlLQitoY2htcG91bU9RVFJwV0pF?=
 =?utf-8?B?aWVRd0ZpL3dobFc1ODA4M3VOY1YydnJhelg4bDMzRlFpQm1yQmJiT2xrK2JQ?=
 =?utf-8?B?UExveGg4V0E4UjZuUWtxc3FSRy9kR2RUdlBNTnd2R09TL1FTSzdMOWpjT3pX?=
 =?utf-8?B?bmpXUUZ4ZFRhK0ppNDAyRnprQnY3SlF5V2xhVUVndkFzMXNPSjRmcEh5Rm9Y?=
 =?utf-8?Q?LrLg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b5a7c6-3fe3-4538-38b2-08da95996394
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 15:05:26.1414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWGOvQBn0jt8+xEEpfopTVP44rpSrvXedVeo02NtpOu1UuhslixuCsIANzU4ve+B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589
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


On 2022-09-12 14:53, Felix Kuehling wrote:
>
> Am 2022-09-12 um 14:04 schrieb Philip Yang:
>> Unified memory usage with xnack off is tracked to avoid oversubscribe
>> system memory. When changing xnack mode from off to on, subsequent
>> free ranges allocated with xnack off will not unreserve memory because
>> xnack is changed to on, cause memory accounting unbalanced.
> To you need something equivalent to reserve already allocated memory 
> when switching XNACK off?
>
> One more comment inline.

Yes, I get error message "KFD system memory accounting unbalanced" when 
switching XNACK off too, I will send v2 patch to handle this case.

Thanks,

Philip

>
>
>>
>> Unreserve memory of the ranges allocated with xnack off when switching
>> to xnack on.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 16 ++++++++++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 14 ++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +++
>>   3 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 56f7307c21d2..1855efeeaaa0 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1594,16 +1594,28 @@ static int kfd_ioctl_set_xnack_mode(struct 
>> file *filep,
>>       if (args->xnack_enabled >= 0) {
>>           if (!list_empty(&p->pqm.queues)) {
>>               pr_debug("Process has user queues running\n");
>> -            mutex_unlock(&p->mutex);
>> -            return -EBUSY;
>> +            r = -EBUSY;
>> +            goto out_unlock;
>>           }
>> +
>> +        if (p->xnack_enabled == args->xnack_enabled)
>> +            goto out_unlock;
>> +
>>           if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
>>               r = -EPERM;
>
> You should goto out_unlock here. It may not be strictly necessary, but 
> it's confusing to think of the cases where you may fall through here 
> unexpectedly.
>
> Regards,
>   Felix
>
>
>>           else
>>               p->xnack_enabled = args->xnack_enabled;
>> +
>> +        /* Switching to XNACK on, unreserve memory of all ranges
>> +         * allocated with XNACK off.
>> +         */
>> +        if (p->xnack_enabled)
>> +            svm_range_list_unreserve_mem(p);
>>       } else {
>>           args->xnack_enabled = p->xnack_enabled;
>>       }
>> +
>> +out_unlock:
>>       mutex_unlock(&p->mutex);
>>         return r;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index cf5b4005534c..5c333bacf546 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2956,6 +2956,20 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>       return r;
>>   }
>>   +void svm_range_list_unreserve_mem(struct kfd_process *p)
>> +{
>> +    struct svm_range *prange;
>> +    uint64_t size;
>> +
>> +    mutex_lock(&p->svms.lock);
>> +    list_for_each_entry(prange, &p->svms.list, list) {
>> +        size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>> +        pr_debug("svms 0x%p size 0x%llx\n", &p->svms, size);
>> +        amdgpu_amdkfd_unreserve_mem_limit(NULL, size, 
>> KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +    }
>> +    mutex_unlock(&p->svms.lock);
>> +}
>> +
>>   void svm_range_list_fini(struct kfd_process *p)
>>   {
>>       struct svm_range *prange;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index 012c53729516..339f706673c8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -203,11 +203,14 @@ void svm_range_list_lock_and_flush_work(struct 
>> svm_range_list *svms, struct mm_s
>>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>>     void svm_range_set_max_pages(struct amdgpu_device *adev);
>> +void svm_range_list_unreserve_mem(struct kfd_process *p);
>>     #else
>>     struct kfd_process;
>>   +void svm_range_list_unreserve_mem(struct kfd_process *p) { }
>> +
>>   static inline int svm_range_list_init(struct kfd_process *p)
>>   {
>>       return 0;
