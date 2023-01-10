Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843B2C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 20:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2078910E668;
	Tue, 10 Jan 2023 20:49:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B4310E668
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 20:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv51oOWGajI/aNE74JyWmnvGuMPGNsouPxn8QBhNBfCPyRYZBKyrxES5sCbk9AEp7ydOYEtEx8ROK2vCUZoa+rhBusBAa3WPRVeemP5ps63xYa5506HshZjANdob25JYhSwoudLv/Q/LlWYsz1LBQuT+Y62XU5W9waWTmBhwSARVa/THXlC6h16JBp+OaesA0TDOgKeDq4Pt/3W9Zy1VQ0B1dQ8yn4P2KhB6c2/9psSiviT3byUl0u4jZuZFWq1m9NtNwzOx6VzlSqP4zb3JwPw353bmdSi8mU27HUhcYHTsNxo0cjzG64/Yg6S0oHP8DuPkv5cZpyBfXqbU74FkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcZu5JaTwODnbHRUR1ZoufPcHhd1gxSGlxVHthhOo6c=;
 b=EvggJcMjCF6JvjrJHWjgo3i4qan0fmYmTOWGuwdfdsSxEKMSiPmRsVNZV1HXepxEE6DDVNZgNJw0mSqjSOJBiM3VJlukwxKMRziOCKVdGMRf+brQ6hXukXDNGkq5FLlD0P92tO6JEnd8c9T+5bPGYw8Pn676GNI8P03jgvsYyyZbKp/TuMuKLis+7lug9GJcx8Oej0QDgr+JCTiYVjHEgqyBA1C5TKWZFCLSL8u48EmAeSaOHp0WGANK/7WVjJi/uNOHJR1NffChMe8Kakoxcs+IKVVl2wN1oURinpx/DI3Q4gqZ+jWEWQutD3/tRV9FjpZTzR1FPrJ+DoE+SJwnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcZu5JaTwODnbHRUR1ZoufPcHhd1gxSGlxVHthhOo6c=;
 b=uFx0wVbb2K8aL2zS61qn1NvO3iUa+jF8kdZrfMHscq161nlAc7INFn21nKpUea8w14XVlY7/DTRLkPYKWoTaEkEr+eckY6kdBug41LDzUKDTUL4tLvaWLZfI0vFmaNqAK44yCpQ7HNuxFwc0KbRtuqb5t6hgRD/smkUM5s9OfbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 20:49:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 20:49:31 +0000
Message-ID: <f29c55f7-f472-7c1c-abec-b82407d3b304@amd.com>
Date: Tue, 10 Jan 2023 15:49:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Page aligned memory reserve size
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230110000112.29730-1-Philip.Yang@amd.com>
 <20230110171122.10380-1-Philip.Yang@amd.com>
 <d5d4c442-e7d2-5319-56b5-6d41edb9f375@amd.com>
 <a554f4d2-3d0b-3c5d-c010-047f5048753c@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <a554f4d2-3d0b-3c5d-c010-047f5048753c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::49) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a2b040-3800-41ef-a10a-08daf34c2c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElfUv+ZpaKqgx8ySdEo8+GPt/kI3Df0z63UKeDzbWFVFpUBD0Y0BgIYA0UunpeKvAeDCgS3eAEYdc6g4aeOTez/Mnwv7ILtjLesIuJQNm9yr6Kme9r8G84pj02vZ5cNVpfJlmJ0xexJArLH2YZggk3Dx8WVnNoaDNjt7tWDmUwf2WoAUEfsh5myWjFbrP3dCO1M0R2lJAY2pccgx4pIgyYYJS8n5DbbFqr8ZkzZx+0FSmeMdyJrK37MfiPQGxVpBdrp8gUA7RmQh2XxZryieYcE/7T4EKaKTpr60DKW9J6mAcoTb1SM4XsPLxYulMiA6qHYlArHmJJISoAX/xvHlh1aa/xoeqlFCukc8Z1i87wSAS467GYMCIIZUPQb/OFih7w4BokVt3flsnbD7X4XHtvu1m4SLLZzU46Hwh6cBaM0YD073Mz8w0UuK91d6sQAtzwE6QAMhbMyZbMZHgVJaDnN98B6scEoCdYPm9E+Amhmo/se37UWbpvN5kybyeyvohWF/qX6Pkt+MolsHF+XrzSBM1Qy0QFWVKoWCjsJXltmUxjVybuAlvKdkR+Jrb4uK1cmkBcdKJZBF7fvjITtl3QKl73V4rRweA+L6WV0Ra2bm6LFbzr3Od6mvFebyc5ldlFNxXGfEorYCy7xS1fJ3aV0rY/pevdodUk9gnuUCrUmCMzLZiZ6yGwaXz9dpykMlTq0lA1O6Ko33MBLksmdiyvpaOph6LbQ5Bu0v0UKDld4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(44832011)(2906002)(83380400001)(2616005)(66556008)(66476007)(5660300002)(66946007)(6666004)(53546011)(8936002)(26005)(36756003)(186003)(6506007)(6512007)(31686004)(478600001)(38100700002)(6486002)(8676002)(110136005)(41300700001)(86362001)(316002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJNTk1vRG93cGI3cGhVVzhobk16MmZCTEw2K3hYUEd0eUc0Ym9wUkZvN0hi?=
 =?utf-8?B?clVFTHV5NWJwV0pwZ3JGMS9zemQvYUZyTEd5c3dxa2hwdmhBcEZwZzc2R2pn?=
 =?utf-8?B?UCtwMGFHU2lMY0YyQi93TU1JWXZReDFvaHJydlVTMFRNamRZZElnMUdvL01k?=
 =?utf-8?B?TzBZSStTWUhHb1ZYWUtEa3daRnBwMDRaY3JsQVpDNlNDNG5ibUk2NzB3ckc1?=
 =?utf-8?B?Wk5RUEdRQUd6Z01USi81UVRJZnpxQ2RCaFQ3Um5NZ1B4NzJPdkZjUGJJY3BM?=
 =?utf-8?B?M1NOTm9zZlh5TWh4aXZkWUQwRmF3a3YraUM4OVJuYi9RNXRTVm9MZVFUOWUx?=
 =?utf-8?B?RzJjbHJORHlmVk1ZcDR0RmpDTlBmaks3bmtGbTNFeTFZQnllQXdIOVpUTWhD?=
 =?utf-8?B?cENBeUwzK2xWL3laYmVBdnV3amJsQ0FremR2c0FRT1lYaTFDQjhVWi93M3gy?=
 =?utf-8?B?VG5VN1hGODN6VEVwTmN0NzZqUk1KbGRJT1ZFVWV2LzZoMmh2VkdRK0dCaGZH?=
 =?utf-8?B?YXQ5VlB4cFg4V3pBL2UySFFDZVpDcDQxa2o4enZSMTVQZVhHRG40TStYZ1o5?=
 =?utf-8?B?aGQwK2JPcW9Ob1RoYVNDamtTbWwvZUNJSEdKQWFhMnp1bWpuNVVYZzFZZURD?=
 =?utf-8?B?UThXU0t3eTJ5Rm5rRWxBNi9ZQ0djNmRCY0dJUTRXRzI4M3JTR242ZG5yOHZo?=
 =?utf-8?B?ZXFPNFhqV1JENnRyTytkWnBwM1RyWGpxUUZyVjRJUE1PU3VoSDk0Z1NKcmdF?=
 =?utf-8?B?S0tMejVIMnp0c21uZHZHNUtHMDI1WXpQd2t6OTJXV3RscU1BcVFONUlML1Aw?=
 =?utf-8?B?SmdPMnlaT2REMmpsN1RUV25QZnFCVzIzSWx4Z3VQaUpzTlErL0tpdlgyS1ZF?=
 =?utf-8?B?eEV6YjA1ZEJYVmtodDBDUXNkVXUzVVZQY0R2UmF6YWFFSkRHb2xXbFdRdHVu?=
 =?utf-8?B?QitaS09yUDBVd1FrQWs1aHBXaWpzM2JSQjBQR1RvRmpWbDNGZnZOamVuZE9L?=
 =?utf-8?B?MzF6bFIzaDNxQzBIbmVjRE1RZzhCNFVxUW0rR2dMVzZRNzRERDgrbis3R2VZ?=
 =?utf-8?B?M3ZvNVVhaXE2WVZGaVBGTGd4QXhhSG1Ba2FsaVJJVW12K284MlBMUjdCdXds?=
 =?utf-8?B?cVZ5eDNKY29ocEJPWXZRNmhzSERMWVNMdlZ0WFlMdDlTeFF4bjVGQWU0S3BI?=
 =?utf-8?B?T1dFNi9najk0ZkFwMzlQWHJqSjdzaWw1WlFWeDlraW9kc1UvaDV6dnJHbmg0?=
 =?utf-8?B?ejlwNnZjNVZEOHJuTnBGVmc3RTRMQ0lLQlc0cTVXb2d6Q3czVDVqQ0pKTDFj?=
 =?utf-8?B?VkdtYWx1WDBaTWg4cnE0b0l2aCtrWGJMWnFnc1AvS2Frd215ZFFGVUpoNHpa?=
 =?utf-8?B?b1VOQjRrVHRvMWlyclFxMWZsMEkzaUhqbnF3MHJhSXRGRGRwM05IbHU5d2VU?=
 =?utf-8?B?bWQ5ZEw0cTFiTUpnQW1ucldHeUpnK2N5RWtrQlJNeXN6V1JpaFM5N2R3dnN3?=
 =?utf-8?B?MVNZZ1IzVkMxVWM5bDVlSXZScEN2dldPcHZNM09RNlBTQTl4MThnWldlZXV0?=
 =?utf-8?B?TVI2Vm9yZkh4VHQ4bkhxK1RDK2tJWUJvaWdkQ052cUpKY29WMUlZOUJ1Z08w?=
 =?utf-8?B?azBUd01SV2R5OXJQaFVYUytFZ2xqQU5UbnFCNUFpenR0ZkVJY010ekFsUExT?=
 =?utf-8?B?WjV3Q0syaG9FOEp5MUFsOVY3ZkFHM1BjMWN4TUlkV2gwNGYvMlV1K0FYUlpW?=
 =?utf-8?B?T1Y2Y1FoN1NpYlhtTDRIaU9LcEw5aUtQVHlGbWtzRU1qdXFRbTlVWGhBa3BV?=
 =?utf-8?B?azNwVHpTSElrdERNSG0zMkxSM1ZaVUhMTTE0WTkxUm1RRmxXMy9DRDdNRWRT?=
 =?utf-8?B?djZIdHhxS2pGMUZsWUl6eHFnVjUxZHJ1TlBocUU1YThCZ3lQdjFDN0UxUUhE?=
 =?utf-8?B?MkFVK2ZyOCtWSTBaN1dNaXVnS1dGdkl6cHB6N2MxN3h3bVJ4SDZqUTd6SjFE?=
 =?utf-8?B?czUxTUduVXRPS3Noa2RRU3MzTkw0eGR1emVKbzN1UzYxVjVvenh1dzRkTFo4?=
 =?utf-8?B?aTR1WFVpa3JjSzZSWW9oL0xwOEE4aWJZb29CUDMxekFPYnZXNFdLUWdGMDFw?=
 =?utf-8?Q?XJrl7GOSZgyj/MeNrCoO7wwXt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a2b040-3800-41ef-a10a-08daf34c2c0f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 20:49:31.0350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCmflmfiqhpLQWvDxkYeKNwHDGS3QRr/M3LwUw3rt7/3fQZm22cp0hGUKHEM9afNDuIRpZnLT6rHCETSJP9aDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
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

Am 2023-01-10 um 15:44 schrieb Philip Yang:
>
> On 2023-01-10 13:33, Felix Kuehling wrote:
>> Am 2023-01-10 um 12:11 schrieb Philip Yang:
>>> Use page aligned size to reserve memory usage because page aligned TTM
>>> BO size is used to unreserve memory usage, otherwise no page aligned
>>> size causes memory usage accounting unbalanced.
>>>
>>> Change vram_used definition type to int64_t to be able to trigger
>>> WARN_ONCE(adev && adev->kfd.vram_used < 0, "..."), to help debug the
>>> accouting issue with warning and backtrace.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 7 +++++--
>>>   3 files changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index fb41869e357a..333780491867 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -97,7 +97,7 @@ struct amdgpu_amdkfd_fence {
>>>     struct amdgpu_kfd_dev {
>>>       struct kfd_dev *dev;
>>> -    uint64_t vram_used;
>>> +    int64_t vram_used;
>>>       uint64_t vram_used_aligned;
>>>       bool init_complete;
>>>       struct work_struct reset_work;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 2a118669d0e3..7efee672bc41 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1598,6 +1598,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>       struct amdgpu_bo *bo;
>>>       struct drm_gem_object *gobj = NULL;
>>>       u32 domain, alloc_domain;
>>> +    uint64_t aligned_size;
>>>       u64 alloc_flags;
>>>       int ret;
>>>   @@ -1653,13 +1654,15 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>        * the memory.
>>>        */
>>>       if ((*mem)->aql_queue)
>>> -        size = size >> 1;
>>> +        size >>= 1;
>>> +
>>> +    aligned_size = PAGE_ALIGN(size);
>>
>> Why do you need a new variable for this? Can't you just update size 
>> to be page-aligned here? Is the unaligned size still needed anywhere?
> amdgpu_gem_object_create ->...-> amdgpu_bo_create needs the original 
> size for domain GWS etc, as the size is used as number of pages, not 
> bytes.

I don't think GWS is ever allocated through this code path. This type of 
memory is not exposed in the KFD ioctl API. KFD allocates a GWS BO using 
amdgpu_amdkfd_alloc_gws.

Regards,
   Felix


>>
>>
>>>         (*mem)->alloc_flags = flags;
>>>         amdgpu_sync_create(&(*mem)->sync);
>>>   -    ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, flags);
>>> +    ret = amdgpu_amdkfd_reserve_mem_limit(adev, aligned_size, flags);
>>>       if (ret) {
>>>           pr_debug("Insufficient memory\n");
>>>           goto err_reserve_limit;
>>> @@ -1725,7 +1728,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>       /* Don't unreserve system mem limit twice */
>>>       goto err_reserve_limit;
>>>   err_bo_create:
>>> -    amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>>> +    amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags);
>>>   err_reserve_limit:
>>>       mutex_destroy(&(*mem)->lock);
>>>       if (gobj)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 6d291aa6386b..e11451100a20 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1127,8 +1127,11 @@ static int 
>>> kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>       }
>>>         /* Update the VRAM usage count */
>>> -    if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
>>> -        WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + args->size);
>>> +    if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>> +        if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
>>> +            args->size >>= 1;
>>
>> This will return the updated size to user mode. That's probably not 
>> what you want. It may be harmless, but technically it breaks the ABI. 
>> It would be better to use a local variable for the updated size.
>
> Submit v3 patch to fix this.
>
> Thanks,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>> +        WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + 
>>> PAGE_ALIGN(args->size));
>>> +    }
>>>         mutex_unlock(&p->mutex);
