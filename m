Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DCEC5475B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 17:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40693112BBB;
	Mon, 11 Mar 2024 17:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uxth+jcF";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE642112BBA
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 17:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUbFUICp4KkydaWB0JMzQ0XClK4B+yV7yzeACDu8XAFa5fB0Y2+ZL4vsbOy+T+6kNw091d4yID11Yb0YMhEo2ZcAx+fosCbIq6IdG1pTGcLGMz3gwt8wxIInGXvWb7nI4GuTneu9QRMNbC/n8zHRrGrESFa27aGCOhgbDOqgAe09PsCCTXsWxaqRQnb6Au+Eez9x/z6jtHQTeXssbHNfzeq4mSu6O8LhAaI02+HBQpMpFvgrcalLx7g5mqAJMDi7LlqYHWQifyhzjXNH7lN9zv7vQPusD/PzXK7Ob3XzjrPKbetiNiJjpPOcF0CYNpq8MY+Ae6huIzbbtSYph/ujvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM4jC90WVXPguv380K6BiqP//1a+RNMnEdCxRjJnYW4=;
 b=dkNBVfdQDceS4tH2uW2f5W7C8TKBesQqLstvEK9BtyJak0CPbHIJUr5kZvaMUg/hzAvi0/aUWMJC4DOwA3FSxzE6QbtwjLkT92cdUlkx6Qo9KhxmoCjXcZEH3KQuz0ysJXVwF56JeB0NZ78sYTqCiWlsTTsPG3ukVeDevkfmlcxAWh9cc12i75PleDZfy7cfSA9aqyUg4Q6Grwr3tC/gODHiwHOVIs5UKKKQ/qYp2mXkjEQNyNBGFz813PEw70zTwDyt6GHXPXBCJBGhkQW+n76S1EWmZRF5bBboEMbE5SiPxFlQY0wJQLP0G08R606DhXcdUXGmjdQ99g4U1V8XZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM4jC90WVXPguv380K6BiqP//1a+RNMnEdCxRjJnYW4=;
 b=uxth+jcF3z5zamvoE+prISNY4/qzqoxz+ktznVQRnzzsuviGCDGorVyQvJXR0tESw9dIBl2N2oJEYkd8k+U+D/6WYIilyOE0M5J8HkCyteh5cvjSp0tzdV4t+7PzQpGqa1maoa5WTe82MC+5xfnCk7h0WY1SGteLXNLUNjpz0VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:27:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 17:27:40 +0000
Message-ID: <efa67457-ada8-4a3f-9d34-823fb1d35f02@amd.com>
Date: Mon, 11 Mar 2024 13:27:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240308162253.264154-1-mukul.joshi@amd.com>
 <4098f759-dc58-422d-b000-af8126775966@gmail.com>
 <BL3PR12MB6425EFDC27818399BA85C1E2EE242@BL3PR12MB6425.namprd12.prod.outlook.com>
 <08c51a55-a1e9-43e6-82e9-537424c0bfb5@amd.com>
 <4cc9a397-fb93-4490-9ae7-3330ac0b4c5e@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <4cc9a397-fb93-4490-9ae7-3330ac0b4c5e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6ff637-624a-47e9-0bfb-08dc41f08dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7w5VIA2Kr7ThF0MxV4Z59pwvHs/YZTC+cRB7sFRbnWTK3ewJrSMhf01Hm8xopscuFxvXGCGh+bKXCrI2EothKd1HZGe9fyfzG5HoPbYbzfe8Fi+9EcwXYVVoK5PlNhXVg19YP8GIwS2Ku1K4rtdsSz/3grfKCOtj6e1gPDMBSKgq0W0GclS9+VQUOZm8qMAIeRWJ4hUMug5WWqSeVDkq8G9KkGbwFD384p2fBVrRb2mOZ5Dtvq5w3Om3ZEDSmeK3tVaLK3xBVGJ1MzH/2lJHJKsvKTsYUstAgacpiE7qbA6pNB2ARTEKAm5k1BzBcETijnQ8wbvK8uw0LBBXo0k4ydtmlnmMPtrTCoVN8g5Un96jQdSc4otXKeNryk3bMonpMTwjdUmLFmTmC7bl/QD8b1MYA38APcIMNtGcfjXza5mrPLDZaHN8bXcuLulyKkfo1d17nETC92Qb5Ym1Cp+8CQN3TQqa9+dj3p6Z/HRUDTlSZ4lCgDMl5eWU5EZzn72/7Fd4LPqDOlB26FvsU/i0qozEqzD+n2j6erL/i7D4+4Eg1CN0wcP6WKxhP4w6t7/PaiqfnCwaY4ZUmLPCJ697K4vfBkGV6bU8PGZYKUHLX5ES5VnZFSc1F9AgiAr2CVJo7x+x6NqqPFFHj8TXZKyYrA02wIN3IxIVgkbcfeqH6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVk5N1pWdk4wRFA5b0FzeHg2TVEvWWRuMWVncXdvbXg1VzdvbCthdEY2Ym03?=
 =?utf-8?B?SlFQRmo0cjBzcmVmanVFNWt5VUtaMTdhSnh2d3VwNDY4bVNlRWEzeGg3bFU5?=
 =?utf-8?B?aFNORXdzN2xFcnBaWmhNQjk4U1h0amttbVVmV2FoWGRYV2lFWHRwRVVBSTg1?=
 =?utf-8?B?dEpOTmdGSEpDSUNZUU5KRnZLemhOMTRkaXRLbmUzTFBkeVJpeXBvR2I0TTdD?=
 =?utf-8?B?VEFGVTgyZHhrdEVDenowcDJQRENiNUY0b0RmR0MvRE91ak5Wd01mZHZDZjVB?=
 =?utf-8?B?THNYdTZqY0RBeUZqYy9ucFJidTZ1ZjJTUVhZbHdiU29zdW5KVHMvUHNmeUR3?=
 =?utf-8?B?MndKck0xeVJaL3hzT1lOa3lNMkd0YisybitOVmNDME4yQnpwb0hPNVI0MjVS?=
 =?utf-8?B?azNYcHZvY2JKend2OVlQRWN5Uk9VT21zcFlTYmxMOHBFOTRmNXVNTHlLQy9F?=
 =?utf-8?B?eEgvTWI5N3RaaXVWdGdkekJ5WGh0cmw2cExLRjZsYm5PUGw1eCsxYUEzUFR4?=
 =?utf-8?B?cS9zbTd5SUsydWM2TXoydm4waUZ4Z2lacXhPcHRQNmN0U25OWW00RmhKeUhw?=
 =?utf-8?B?Y3ZnQmZWMGNscVQ3M2YxOVhqeHA0dmJOb3Ruand6MFF5eEJKRjNyeDhDc0Fw?=
 =?utf-8?B?dWRBL3hxcm9acE51NTE2bXBhc1FEU21lWnhjUVBVaDdaMVFPTGxSVlpwS3U1?=
 =?utf-8?B?TCtBUHE5d3dQMTZVTzVqaEtNdUpHNGZuZVJZZjNSZXZvemQyYnBmSndYVFBu?=
 =?utf-8?B?WWZFT2NTKzhGTlY1WHJVa2VWZnJSMGZ4cmMxNWlVNlkydFV1dVlZY2wza3dx?=
 =?utf-8?B?RzJqcW9obU9pSnBnSE1mRVVoUWp6emlISElZdkV2anA1bFhUVThua3hRZ3ds?=
 =?utf-8?B?bGdSMUwyL1hZeHhTZ2V2YkkrNGx6QndIbHYxVkZOemgvY3Y0WFF3SThvSlMz?=
 =?utf-8?B?QndFNGlvTmoxU2RQdEhsSkduNlpFdGNNcnhDK1BTSXZxWDdFMU9xNEwxTVFv?=
 =?utf-8?B?V2RyUFZLZGRsNkJYYXNTV2lwU1JXbnpOelNwYk5FN0RMMjIzR1dVMW1aVW10?=
 =?utf-8?B?eFlPb3l6SE5Ja2pXMG9zYzRUOCtOaDU5dVlxbmQ2YUpLVVY2SHBJbEUxOUFv?=
 =?utf-8?B?a3M2djhwNEJiZHZHdWE3NTdTeXJ2Q1BFWTY4REt4bjVoZVFTeHFxSHpEMG1Z?=
 =?utf-8?B?Nm1uVGZQYXkzcTB5eVRyVTJac0pMSGZ2bUtsdlEyd2FNMmNDYjZiTWZDVktp?=
 =?utf-8?B?Y09vR1ZjN0FjaGlHeU5EdXV5Z3MwdHV4aTUrWkxnaEI5QklFMm5tWTI4N3hX?=
 =?utf-8?B?RXd2YzAycnZkYmcrUjhnWnJ0OC84Rm9ORjZ2L3FQdFNXUXJicTBEeDhjUTRs?=
 =?utf-8?B?Y2tYc3NUamZwNThsdzlOOHZEWXVob0FQSW9WY09DanB4amJKL3M2L2ltWmxC?=
 =?utf-8?B?Tm5ZdHV2RmlEUUZGbElNNXJFYkEyMHlOVHhyS3pVNkpVa2FUKzkxcEg1aTRp?=
 =?utf-8?B?eXpkaTNULzB4NWRYVUhkQmdDZktSQjZtMmtMOVBta0JTQWNEbjhOMlF3YVpl?=
 =?utf-8?B?d0tkNlFJc0ZYNyt0VFBHRnRUNFErTGJxdUJlTjZNbDRJYS9WcmpTYVAzNGh0?=
 =?utf-8?B?RlkyZURtVTcxSVh4RFMrWGJHU1JCbElhM2l3Y1pJalNpUkluOXhyall5R2Ry?=
 =?utf-8?B?WjlsRTlqZ0prZFlHcXpyUEx6aUF5YmpzcDN5YVh4S1lXTzNqdWpyWklmaWl4?=
 =?utf-8?B?V0lCNnpicVZaT05sRndLaU9ESXlVTDdSY0owdTg5UVp0bzQzYlk5S0xrMlRq?=
 =?utf-8?B?TVZmYk84SUlpa3Z5RERGMGRtd3Y1WGh4bWdvTlY1dnU3M3A0c0w4ZXlCUzU3?=
 =?utf-8?B?NHpzdWx6S1hzTGpVVWlCbnltOG13N2s0TU0yVEhFK3ZueDNxVlJ2eTBzSWtX?=
 =?utf-8?B?LzJNb0J3Q3d2TWFTbU5mUVFqV29UV1ZEbmU3aUovK2prRm4wZ0lLQTd6b0RY?=
 =?utf-8?B?NFRPa1ZBa0MyY0NuYVlVM3AzeGR3SDJXdE9ndmVJdGpkN0Rob1BkMG5SWVdN?=
 =?utf-8?B?a3VNWFVDV1hpa0pwMW51RHE5MmZqZVFKbW1kR2NsY2tLVkNYbzJUTWhRNDNR?=
 =?utf-8?Q?J+DrfFbex8a38Zv9eGT1v61og?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6ff637-624a-47e9-0bfb-08dc41f08dbf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:27:40.7078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tFQUbcGPKXF3rgY55mNd1REN3NZJoR6ltJ8SRA3DYTbGJ/kLP6PkN6njTdfmjLOGxnB5EkLspN9tqL7GTdxOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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

On 2024-03-11 12:33, Christian König wrote:
> Am 11.03.24 um 16:33 schrieb Felix Kuehling:
>> On 2024-03-11 11:25, Joshi, Mukul wrote:
>>> [AMD Official Use Only - General]
>>>
>>>> -----Original Message-----
>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>> Sent: Monday, March 11, 2024 2:50 AM
>>>> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: Handle duplicate BOs during process
>>>> restore
>>>>
>>>> Caution: This message originated from an External Source. Use 
>>>> proper caution
>>>> when opening attachments, clicking links, or responding.
>>>>
>>>>
>>>> Am 08.03.24 um 17:22 schrieb Mukul Joshi:
>>>>> In certain situations, some apps can import a BO multiple times
>>>>> (through IPC for example). To restore such processes successfully, we
>>>>> need to tell drm to ignore duplicate BOs.
>>>>> While at it, also add additional logging to prevent silent failures
>>>>> when process restore fails.
>>>>>
>>>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14
>>>> ++++++++++----
>>>>>    1 file changed, 10 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index bf8e6653341f..65d808d8b5da 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -2869,14 +2869,16 @@ int
>>>>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>>>>> __rcu *
>>>>>
>>>>>        mutex_lock(&process_info->lock);
>>>>>
>>>>> -     drm_exec_init(&exec, 0);
>>>>> +     drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES);
>>>>>        drm_exec_until_all_locked(&exec) {
>>>>>                list_for_each_entry(peer_vm, 
>>>>> &process_info->vm_list_head,
>>>>>                                    vm_list_node) {
>>>>>                        ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
>>>>> drm_exec_retry_on_contention(&exec);
>>>>> -                     if (unlikely(ret))
>>>>> +                     if (unlikely(ret)) {
>>>>> +                             pr_err("Locking VM PD failed, ret:
>>>>> + %d\n", ret);
>>>>>                                goto ttm_reserve_fail;
>>>>> +                     }
>>>> That's a bad idea. Locking can always be interrupted and that would 
>>>> print an
>>>> error here.
>>>>
>>> Thanks Christian. Will send out a patch to change it to pr_debug.
>>
>> We cannot get interrupted here because we're in a worker thread. We 
>> should be running in non-interruptible mode.
>
> Ah! Ok in that case this isn't necessary.
>
> But in general I think we should avoid error printing like that. If we 
> want to know where something failed there is a function tracker for that.

In this case, it was hard to know that something failed at all. The 
problem manifested as a soft-hang in an application, and it took several 
teams several days to track it down to an eviction/restore problem in 
kernel mode. A failure to reserve BOs seems like the type of problem 
that is not expected here, and would justify an error or warning message 
in the kernel log. That would have helped track down this issue much faster.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Mukul
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>                }
>>>>>
>>>>>                /* Reserve all BOs and page tables/directory. Add all
>>>>> BOs from @@ -2889,8 +2891,10 @@ int
>>>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>>>> __rcu *
>>>>>                        gobj = &mem->bo->tbo.base;
>>>>>                        ret = drm_exec_prepare_obj(&exec, gobj, 1);
>>>>> drm_exec_retry_on_contention(&exec);
>>>>> -                     if (unlikely(ret))
>>>>> +                     if (unlikely(ret)) {
>>>>> +                             pr_err("drm_exec_prepare_obj failed,
>>>>> + ret: %d\n", ret);
>>>>>                                goto ttm_reserve_fail;
>>>>> +                     }
>>>>>                }
>>>>>        }
>>>>>
>>>>> @@ -2950,8 +2954,10 @@ int
>>>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>>>> __rcu *
>>>>>         * validations above would invalidate DMABuf imports again.
>>>>>         */
>>>>>        ret = process_validate_vms(process_info, &exec.ticket);
>>>>> -     if (ret)
>>>>> +     if (ret) {
>>>>> +             pr_err("Validating VMs failed, ret: %d\n", ret);
>>>>>                goto validate_map_fail;
>>>>> +     }
>>>>>
>>>>>        /* Update mappings not managed by KFD */
>>>>>        list_for_each_entry(peer_vm, &process_info->vm_list_head,
>
