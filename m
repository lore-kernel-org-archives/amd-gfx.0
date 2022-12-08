Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7FEC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 15:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B909110E4BD;
	Thu,  8 Dec 2022 15:45:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0F610E4BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 15:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqr/Yn51eJ8K8yvnHXaB75owH8/VO0sEizcR6qamQywALbGEYONMmqzjJljCnGZk5ztqNfH6kejhE1iM12EE0ZoHOwGgzGr0p0s9RHZuurA/s67N/T8t9B5h4Wd+sGVRzGjJehrV8j/Hkjqlsb61tMf+KnfwUIWvj45VBinHF7iRgzJaGMDE4pW2UMQ8EtOZ1wl7ErumfGvYPS2Ioon8IqrLjwjolZGmbF0lW9CsRfPq3hjtYY/v2YtTq8rCRftYNfBFSFx5zV280nsF+j3S/ggysvxNUK99uAymUmTecfzoB/Lym+kSvMQfGPebLPKF/H6lgDEahZ9+TEUdsedn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9oWaRKn8NYrtvfT77PgPN1WT7Ove+++U5e7Kq5oH5w=;
 b=EU7nEAbQJczm3/pPFNBQbYQiWEgSo08BA+uzW9cPyC6ejMgGo8KCLqc0TMpG0T0OFX2Gm6a5uDYul+WiexsPX4V/yaygcPbR6CXttc24amgiMSoLIci82+QtPadxssYQBC69UWeFqQS4vbPzGX+YIHpVKCKVipwZV2W4qUX5L+xP5fmpcBF1BLAP83p9uW0tuodt4roCm4/AiH48dvnLS6wTLIdWqMqk5sZWIcSntC2GX0d+cQY/PKOED4QORyn7R/Lgq2cxFgF9uf6lpD7k++AchxB+vrJp9Xv1hTal0Lzr+Zn2VvoXoHv3TnioG6GbR4iVZ7YyHnPTTmDPk4ybkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9oWaRKn8NYrtvfT77PgPN1WT7Ove+++U5e7Kq5oH5w=;
 b=btbGdtSrGUKIlwD2cDwMRUgbRtisEaHpaJltQ7QLsm1Wq4/aLKU2Nty1z1v3hZt9hQOuGx3isF0f8Y+EOBcplllPqnGBhNEyJiTECVsSGS2b7eNwcnq7n0B0zGiuflp8JMJ4u08E7nQtapqNuyOOnH5SSPqzeaZFXHHiSX/U4PA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 15:44:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 15:44:52 +0000
Message-ID: <7064f6ad-f180-0514-7ca4-0e240142bc28@amd.com>
Date: Thu, 8 Dec 2022 16:44:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Another circular lock dependency involving fs-reclaim and
 drm_buddy
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <5fb7e577-e17e-c791-c107-2424b80ea853@amd.com>
 <eb075cb2-1649-e149-6f53-c86a30f9fffd@amd.com>
 <ee07b373-9de2-faac-320c-ee7b15048cd9@amd.com>
 <dd4979da-6abd-ba02-8840-d59b78a3020d@amd.com>
 <917226e7-9e62-9cda-9f9b-eff4ce5a90c0@amd.com>
 <2df5f87e-fbf4-2364-fab6-7e3dbd4e5361@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <2df5f87e-fbf4-2364-fab6-7e3dbd4e5361@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: d85fc84c-cb92-4be2-6630-08dad93325a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbv429MmibHPOLMveFJMxHpgbuUwpszS6jP+Kuw9Tyn8a6mesBOyDR/A7PadurB/Jgow1y2022RWm1uQxlgJhGn8mjvzB+D/jvl6bCjlNPFHy6+76MIHApXcPpRR4Fy2+nN18odFF1XOskpyySI68IbQlixO/yyRMmB9mih5jstwuw/4d4ZCFwUR3PIY7EIBW9ABKx+tylZoh0Je9mG8QiHiRlQwrZ4UJgmw0fI1zjXqcbdWwYpEUdHosxC2TTkubD5sNkGvUSag2MwiP0C/s5wINDlFeRPeTlR6oAMkBQr9SE3jIS6CNB0HgQlRKGp6EKDPBegLU63IbmdoFfEa4XELbJNFukns0ylNG2A1kG9Hzava471buFmlrXEMEmuU2Xo54oPRGLmMVJBeSGnbEGMIShv5quzRObq/Q4nZrya60ynYfdfv7O+uBqRql0y97+HMd7n24VPTuD2XZqPAaSDqHx+lM6gq/l23+HqMmkiGEoKyC1RBPN585xwvPG//LkZE21f14A4eXqGhPk2mDbdtSWHMV2kOtT8TF5GxNpIUKGE+R/+cXZwCcz2uvRDzpvu6VkFivXjh5Yiq+JHrkYyaLA4sLbJKnyh1yTqT2/ikq/4Fx8cb3K20gKvMvxfiCrPjGIaxO6G35M93z7Pop5zVhltRdfCwsN4mqf3ubyw+Y1UlrKcQEqcN3VTvSMa8eGEBJBgoxQQxm/o1wbTG5RJtIuzpa/mqdL0CcwJFobw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(83380400001)(41300700001)(86362001)(66574015)(31696002)(38100700002)(30864003)(5660300002)(8936002)(2906002)(8676002)(6666004)(186003)(6506007)(66946007)(6512007)(66556008)(2616005)(66476007)(478600001)(110136005)(6486002)(316002)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkF0alNkUExGelkvdE1XVVlXV1VpcUlKOVROUjUzenUxOUtjbnJxTmxxbXUw?=
 =?utf-8?B?RHUydkJVN1JreGxyVC9BZ0hJRW5Ya2tpR0tUUjFXWU82czdzQmRveGVBWmk1?=
 =?utf-8?B?UGFkeXRYcGVaY09UQllRVm93M252MUZCZXBmOTdqR05lYUk5cWhDUlJWWFc5?=
 =?utf-8?B?U21TazBueHVXR0l0blNQeXRHOXBhemYxTnJ6Q0xGMDVYb0ZGZjg1OWNPVDMy?=
 =?utf-8?B?YlZZRFF6YUI0ZzZGUm93T3RrMUlEZXNjT3RSaGxCRzZ2d1ZaWHlyN0ZOc0Iy?=
 =?utf-8?B?Y0VqSkVkcHg2ZUExZ09qNHZ1ampyS2xZY05XcTBCakNaZnFIRHh3NStLMmVz?=
 =?utf-8?B?UjRIbTY4K0ZwNGZZdTc2M0orRmJYYzVDdXVObTlLNkZySW0xZEw1OE9RdWFH?=
 =?utf-8?B?YnN1eVVlYUpYN3lvMDVKVDhzcnZGZlZONWhQMjlzd3U0THlDL0dWd1JDL1Y4?=
 =?utf-8?B?WmlWQmZHVWs3Umd4bXFYVnZUbURyUnJXaVZ6bmdSTmlBUnpRYytUNURMekE4?=
 =?utf-8?B?T2hKSmsyZmt3MXY5c1NhOE5jbkdMWi9BK3UzTnJ0RWJUdEFUemRsbUpOMEg0?=
 =?utf-8?B?eUhFcG5pcFF6Z0ZPMXlpalNTNGZrUEJMQkJ3ZU4zYzJaMkdlWFY3eENLdzNu?=
 =?utf-8?B?Wi9sSlJWeXlJTzNJUDJvc2pRa0d5TVRENDl3amV6c2dDbWRLUlQ3UW9saThH?=
 =?utf-8?B?Um56cFlqOC8xUm05OXNmK09Qd3l4Y29FQWhCYlpqSTZvVkxPTkhaS3kyV2tq?=
 =?utf-8?B?VmRCVEljYmIycGg5MVQ1aURHcFU4T1RFWkhYQ3JzOEZ5MmxIOFlnVU1PMDhU?=
 =?utf-8?B?SC9JVnZjaUdPa2FEMDRkYkxOazB3UWZRZzdWNm1VTHJUcE1SVFc2dS80Q2Rz?=
 =?utf-8?B?dEQ0VXQrV0NBeVA3d1l5NGxzSDEwbUxDaXUyZmV5WjZUcGxNVlN4cE5TazJu?=
 =?utf-8?B?Z3NNVzVuMnRzdDhjRXIzSGd3V1kwSE1INWxrVE1sTTI2bG1ISEZkLzVFdUdE?=
 =?utf-8?B?QzhKWFMzSWp1eFdwdXFTUnF2WGlTdFNGZEMzZWFnMllWUGFHS2UzZlBEYXpI?=
 =?utf-8?B?WEkraHp6MDZYdGNMVzNnRkZFWmdvV3hYTkU5TEFXL2hmM3o2Wk5WTXlIRXBr?=
 =?utf-8?B?MWUzVkRYaTdvNGZPc05NMm1tQWx6RjhpVW1wYWs0Z0NWZ0thWC9GYS9PRENq?=
 =?utf-8?B?cWt5Z2dXVVJuRXNDb0hzZEFxS21WWmM0ZDdyenVnUm5XcHdnQzFjY2NwU1dC?=
 =?utf-8?B?OUhHMktFY1dXc2lvR0xqR0pkSUJTSzNQc2w0ci9yK1BsS3ExM2h3ektXUm1M?=
 =?utf-8?B?MWdrd3pvUHB0UGlpb3kwOTUrTzhMM3dRejJFd2hKamtNUVRhc2dhYldzUFgz?=
 =?utf-8?B?ZlY1d256YitkVUVtRFBmSDc3U2RxZ2t6cWhQUFJ4K2pUMU1jOW44N2l5Mk9X?=
 =?utf-8?B?TitUcUR4ZUZ0eU54a08vdURqaU9iZEpYZWNnMm96dHpIcnR2QkJTdmZzVWZq?=
 =?utf-8?B?anJNRkxLRW5lcHFWbVNEallVUExrZjEyVG9RcUJ5VkszZm03ZlIrMWFQTGEy?=
 =?utf-8?B?NVY5N1I5VitZdlR2bWdwOHF1RlRwZTR6WEhPQTh1b0ZqZEFQRGt3TUdIalJ3?=
 =?utf-8?B?NlNnYUlHM1RRUzZibU5ZT0dPY1owUnZWZWZ4VUZWQ1RVMHZoYklVaDBqU3lE?=
 =?utf-8?B?UnNiL3E5STRGMlRmd3pZWFZNMjRFbmRmOEdjM3kyRlZHcG5kcC9rNElOcVFu?=
 =?utf-8?B?SC9uUW1NYTlkbkZCa1dLSXJRMmVXamtlMGdaQ0NvcmxNZHpKWVBTRHJWOW0w?=
 =?utf-8?B?WGo3NDM4a0IyU3RJMWpYNG40OENSbWduM01GUmcvVXkvZzFjQW1rSlNGN3Nx?=
 =?utf-8?B?bVkvWjlEWndwYXBnc29PR0djTUc3OExZVE9iR3FHaVBMU1lVNHJNTlRVenRp?=
 =?utf-8?B?MjVGbzhJZGdpWkRkaGpiQWh6QStncUxMS3BGTTE3VERWUXV0c2lobXhWYmNU?=
 =?utf-8?B?Y3huWjBUdFVZUW5ZNFZJR0cwdDVWK1A3NEFQVUJXYjZScW43bmFJK2FBalo3?=
 =?utf-8?B?c2hoVjl5MzU0VWFMdWZHTk9pU1l5cENJOWo1cXBBamhYeFBZTEpRUTYwRG9Z?=
 =?utf-8?B?dWlVUFNoR1R4Q3VFT0ZBb2FFeUxvNlVTQVBJcHNPenRCTWtoQS8zak1yVStY?=
 =?utf-8?Q?23jWHfWDLckOsJ3ky4IhNKa/XUfct72yFNhKp1v+PceQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85fc84c-cb92-4be2-6630-08dad93325a1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 15:44:52.5646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VxByXO78wDoJkvwGo6uHfArEp4FvtcgyIwhO4bJfRkKNfIIuWrXYqdkyIZyod0G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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

Am 08.12.22 um 16:19 schrieb Felix Kuehling:
> Am 2022-12-08 um 07:32 schrieb Christian König:
>> Hi Felix,
>>
>> digging though the code I think I know now how we can solve this.
>>
>> The lock which needs to protect the validity of the pages is the 
>> vm->eviction_lock, cause this one is what serializes the updates of 
>> our page table.
>>
>> This means that the amdgpu_vm_update_range() function needs to be 
>> extended further with enough information to check the HMM sequence 
>> after grabbing the eviction lock.
>
> I don't see how taking one more lock helps resolve a lock dependency 
> issue. Right now the vm->eviction lock is not in the dependency cycle 
> at all.
>
> Do you mean we should use the vm->eviction lock instead of the 
> prange->lock to serialize page table updates with MMU notifiers?

Exactly that, yes.

> I don't see how that solves the problem either. It just changes the 
> lock that's involved in the cycle here. And it contradicts the 
> previous change made by Philip, who removet vm->eviction lock from the 
> cycle by dropping it just before potentially allocating page tables.

Yeah, and that change solves our issue.

>
> The fundamental problem, as I understand it, is that we need to hold 
> the same lock in the MMU notifier and while updating page tables.

No, that's what I meant initially. This is the wrong way to see it.

What we need is a lock which serializes page tables updates and at the 
same time is independent of allocating page tables.

After taking this lock we need to validate the addresses we want to 
write into the page tables before doing so.

So the resulting sequence for validation should be:

seq = mmu_interval_read_begin();
hmm_range_fault(pages);
amdgpu_vm_update_range(... pages, seq...)
{
     ....
     amdgpu_vm_eviction_lock();
     if (mmu_interval_read_retry(seq))
         return -EAGAIN;
     ...
     amdgpu_vm_pt_alloc()
     {
         amdgpu_vm_eviction_unlock();
         ....
         amdgpu_vm_eviction_lock();
         if (mmu_interval_read_retry(seq);
             return -EAGAIN;
     }
     amdgpu_vm_eviction_unlock();
}


That's the only way I can see how we can actually make this work.

Regards,
Christian.


> That makes it difficult to allocate memory during page table updates 
> because we cannot allow reclaim. Any lock taken during memory 
> allocation gets drawn into the cycle, in this case the vram_mgr->lock. 
> Unless we find a way to move page table allocation out of that 
> critical section, we can never do reclaim while holding vram_mgr->lock.
>
> Regards,
>   Felix
>
>
>>
>> Or am I missing something here?
>>
>> Regards,
>> Christian.
>>
>> Am 06.12.22 um 16:57 schrieb Christian König:
>>> Am 06.12.22 um 16:14 schrieb Felix Kuehling:
>>>> Am 2022-12-06 um 03:20 schrieb Christian König:
>>>>> Hi Felix,
>>>>>
>>>>> to be honest I think the whole approach you take here and 
>>>>> unmapping the range with the lock held is highly problematic.
>>>>>
>>>>> Essentially unmapping is something which can run concurrently with 
>>>>> other operations and should never be blocked by such a lock. In 
>>>>> other words it is perfectly valid for an unmap to run while 
>>>>> another processor tries to map the same range.
>>>>
>>>> I strongly disagree. When an MMU notifier invalidates a virtual 
>>>> address range, it must guarantee that the device will not access 
>>>> the current physical location of the invalidated range any more. 
>>>> Without the lock, another processor could easily overwrite the 
>>>> invalidated PTEs with valid (but outdated) addresses that the MMU 
>>>> notifier just removed.
>>>>
>>>> This is the relevant paragraph in the HMM doc:
>>>>
>>>>    [example of driver updating its page table ...]
>>>>           take_lock(driver->update);
>>>>           if (mmu_interval_read_retry(&ni, range.notifier_seq) {
>>>>               release_lock(driver->update);
>>>>               goto again;
>>>>           }
>>>>
>>>>           /* Use pfns array content to update device page table,
>>>>            * under the update lock */
>>>>
>>>>           release_lock(driver->update);
>>>>           return 0;
>>>>      }
>>>>
>>>>    The driver->update lock is the same lock that the driver takes
>>>>    inside its
>>>>    invalidate() callback. That lock must be held before calling
>>>>    mmu_interval_read_retry() to avoid any race with a concurrent CPU
>>>>    page table
>>>>    update.
>>>
>>>
>>> There is something massively missing here since that won't work at all.
>>>
>>> The problem is that we can't allocate memory nor fault pages while 
>>> any lock is held which is also held inside the invalidation callback 
>>> of the MMU notifier.
>>>
>>> Updating the PTEs will always need memory, e.g. we can't guarantee 
>>> that we won't allocate page tables. Otherwise dynamic allocating 
>>> tables won't work any more.
>>>
>>>>>
>>>>> That's why the same page fault can occur multiple times until the 
>>>>> page tables are up to date.
>>>>>
>>>>> When you get an MMU notification that range A->B is invalidated 
>>>>> you trigger invalidation of range A->B inside the GPUVM address 
>>>>> space as well and that's completely independent what's mapped there.
>>>>
>>>> Not exactly. Because we're in a shared virtual address space, we 
>>>> know exactly what's mapped there.
>>>
>>> Yeah, but that's irrelevant. We are not allowed to use this 
>>> information, cause otherwise we run exactly into the described 
>>> issues again.
>>>
>>>> If the MMU notifier invalidates it, we have to coordinate with it 
>>>> to make sure we don't write incorrect addresses into those PTEs. In 
>>>> the example above, holding the lock guarantees that a concurrent 
>>>> MMU notifier will not return until after it has overwritten the 
>>>> PTEs we just updated. Alternatively mmu_interval_read_retry fails, 
>>>> which means the MMU notifier got there first and we have to get 
>>>> updated addresses with hmm_range_fault. Either way, the page table 
>>>> ends up with PTEs with V=0 before the MMU notifier returns.
>>>>
>>>> Without holding the lock while writing the page table, we could end 
>>>> up with a mix of valid (V=1, but outdated address) and invalid PTEs 
>>>> when there is a concurrent validation and invalidation of the same 
>>>> virtual address range.
>>>
>>> Yeah, I see the problem now as well. But I can't come up with any 
>>> way to solve this.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> Invalidating the mappings and eventually scheduling that they are 
>>>>> re-created is a separate step which should come independent of 
>>>>> this if I'm not completely mistaken.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> Am 06.12.22 um 01:04 schrieb Felix Kuehling:
>>>>>> We fixed a similar issue with Philip's patch "drm/amdgpu: Drop 
>>>>>> eviction lock when allocating PT BO", but there was another one 
>>>>>> hiding underneath that (see the log below). The problem is, that 
>>>>>> we're still allocating page tables while holding the prange->lock 
>>>>>> in the kfd_svm code, which is also held in MMU notifiers. This 
>>>>>> creates a lock dependency between the vram_mgr->lock and fs-reclaim.
>>>>>>
>>>>>> There are three ways around this:
>>>>>>
>>>>>>  * Do the page table mapping outside prange->lock (creates a race,
>>>>>>    contradicts advice in Documentation/vm/hmm.rst)
>>>>>>  * Avoid all page table allocation in amdgpu_vm_update_range (i.e.
>>>>>>    allocate page tables ahead of time somehow)
>>>>>>  * Wrap vram_mgr->lock with memalloc_noreclaim_save/restore (may 
>>>>>> cause
>>>>>>    memory allocations to fail in drm_buddy under memory pressure)
>>>>>>
>>>>>> I only mention the first one for completeness. It's not a valid 
>>>>>> solution. Neither of the remaining two options are particularly 
>>>>>> appealing either.
>>>>>>
>>>>>> Regards,
>>>>>>   Felix
>>>>>>
>>>>>>
>>>>>> [   83.979486] 
>>>>>> ======================================================
>>>>>> [   83.986583] WARNING: possible circular locking dependency 
>>>>>> detected
>>>>>> [   83.993643] 5.19.0-kfd-fkuehlin #75 Not tainted
>>>>>> [   83.999044] 
>>>>>> ------------------------------------------------------
>>>>>> [   84.006088] kfdtest/3453 is trying to acquire lock:
>>>>>> [   84.011820] ffff9a998561e210 (&prange->lock){+.+.}-{3:3}, at: 
>>>>>> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>>>> [   84.023911]
>>>>>>                but task is already holding lock:
>>>>>> [   84.031608] ffffffffbcd929c0 
>>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>>>>> unmap_vmas+0x5/0x170
>>>>>> [   84.041992]
>>>>>>                which lock already depends on the new lock.
>>>>>>
>>>>>> [   84.052785]
>>>>>>                the existing dependency chain (in reverse order) is:
>>>>>> [   84.061993]
>>>>>>                -> #3 
>>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
>>>>>> [   84.071548]        fs_reclaim_acquire+0x6d/0xd0
>>>>>> [   84.076941]        kmem_cache_alloc_trace+0x34/0x760
>>>>>> [   84.082766]        alloc_workqueue_attrs+0x1b/0x50
>>>>>> [   84.088411]        workqueue_init+0x88/0x318
>>>>>> [   84.093533]        kernel_init_freeable+0x134/0x28f
>>>>>> [   84.099258]        kernel_init+0x16/0x130
>>>>>> [   84.104107]        ret_from_fork+0x1f/0x30
>>>>>> [   84.109038]
>>>>>>                -> #2 (fs_reclaim){+.+.}-{0:0}:
>>>>>> [   84.116348]        fs_reclaim_acquire+0xa1/0xd0
>>>>>> [   84.121697]        kmem_cache_alloc+0x2c/0x760
>>>>>> [   84.126948]        drm_block_alloc.isra.0+0x27/0x50 [drm_buddy]
>>>>>> [   84.133679]        split_block+0x4d/0x140 [drm_buddy]
>>>>>> [   84.139539]        drm_buddy_alloc_blocks+0x385/0x580 [drm_buddy]
>>>>>> [   84.146435]        amdgpu_vram_mgr_new+0x213/0x4f0 [amdgpu]
>>>>>> [   84.153399]        ttm_resource_alloc+0x31/0x80 [ttm]
>>>>>> [   84.159366]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>>>>> [   84.165169]        ttm_bo_validate+0xc5/0x170 [ttm]
>>>>>> [   84.170872]        ttm_bo_init_reserved+0x1a6/0x230 [ttm]
>>>>>> [   84.177075]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>>>>> [   84.183600] amdgpu_bo_create_reserved+0x188/0x1e0 [amdgpu]
>>>>>> [   84.190803] amdgpu_bo_create_kernel_at+0x64/0x200 [amdgpu]
>>>>>> [   84.197994]        amdgpu_ttm_init+0x420/0x4c0 [amdgpu]
>>>>>> [   84.204301]        gmc_v10_0_sw_init+0x33a/0x530 [amdgpu]
>>>>>> [   84.210813] amdgpu_device_init.cold+0x10d4/0x17a1 [amdgpu]
>>>>>> [   84.218077]        amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>>>>>> [   84.224919]        amdgpu_pci_probe+0x142/0x350 [amdgpu]
>>>>>> [   84.231313]        local_pci_probe+0x40/0x80
>>>>>> [   84.236437]        work_for_cpu_fn+0x10/0x20
>>>>>> [   84.241500]        process_one_work+0x270/0x5a0
>>>>>> [   84.246805]        worker_thread+0x203/0x3c0
>>>>>> [   84.251828]        kthread+0xea/0x110
>>>>>> [   84.256229]        ret_from_fork+0x1f/0x30
>>>>>> [   84.261061]
>>>>>>                -> #1 (&mgr->lock){+.+.}-{3:3}:
>>>>>> [   84.268156]        __mutex_lock+0x9a/0xf30
>>>>>> [   84.272967]        amdgpu_vram_mgr_new+0x14a/0x4f0 [amdgpu]
>>>>>> [   84.279752]        ttm_resource_alloc+0x31/0x80 [ttm]
>>>>>> [   84.285602]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>>>>> [   84.291321]        ttm_bo_validate+0xc5/0x170 [ttm]
>>>>>> [   84.296939]        ttm_bo_init_reserved+0xe2/0x230 [ttm]
>>>>>> [   84.302969]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>>>>> [   84.309297]        amdgpu_bo_create_vm+0x2e/0x80 [amdgpu]
>>>>>> [   84.315656]        amdgpu_vm_pt_create+0xf5/0x270 [amdgpu]
>>>>>> [   84.322090]        amdgpu_vm_ptes_update+0x6c4/0x8f0 [amdgpu]
>>>>>> [   84.328793]        amdgpu_vm_update_range+0x29b/0x730 [amdgpu]
>>>>>> [   84.335537] svm_range_validate_and_map+0xc78/0x1390 [amdgpu]
>>>>>> [   84.342734]        svm_range_set_attr+0xc74/0x1170 [amdgpu]
>>>>>> [   84.349222]        kfd_ioctl+0x189/0x5c0 [amdgpu]
>>>>>> [   84.354808]        __x64_sys_ioctl+0x80/0xb0
>>>>>> [   84.359738]        do_syscall_64+0x35/0x80
>>>>>> [   84.364481] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>> [   84.370687]
>>>>>>                -> #0 (&prange->lock){+.+.}-{3:3}:
>>>>>> [   84.377864]        __lock_acquire+0x12ed/0x27e0
>>>>>> [   84.383027]        lock_acquire+0xca/0x2e0
>>>>>> [   84.387759]        __mutex_lock+0x9a/0xf30
>>>>>> [   84.392491] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>> [amdgpu]
>>>>>> [   84.400345] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>>>> [   84.407410]        unmap_vmas+0x162/0x170
>>>>>> [   84.412126]        unmap_region+0xa8/0x110
>>>>>> [   84.416905]        __do_munmap+0x209/0x4f0
>>>>>> [   84.421680]        __vm_munmap+0x78/0x120
>>>>>> [   84.426365]        __x64_sys_munmap+0x17/0x20
>>>>>> [   84.431392]        do_syscall_64+0x35/0x80
>>>>>> [   84.436164] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>> [   84.442405]
>>>>>>                other info that might help us debug this:
>>>>>>
>>>>>> [   84.452431] Chain exists of:
>>>>>>                  &prange->lock --> fs_reclaim --> 
>>>>>> mmu_notifier_invalidate_range_start
>>>>>>
>>>>>> [   84.466395]  Possible unsafe locking scenario:
>>>>>>
>>>>>> [   84.473720]        CPU0                    CPU1
>>>>>> [   84.479020]        ----                    ----
>>>>>> [   84.484296] lock(mmu_notifier_invalidate_range_start);
>>>>>> [   84.490333] lock(fs_reclaim);
>>>>>> [   84.496705] lock(mmu_notifier_invalidate_range_start);
>>>>>> [   84.505246]   lock(&prange->lock);
>>>>>> [   84.509361]
>>>>>>                 *** DEADLOCK ***
>>>>>>
>>>>>> [   84.517360] 2 locks held by kfdtest/3453:
>>>>>> [   84.522060]  #0: ffff9a99821ec4a8 
>>>>>> (&mm->mmap_lock#2){++++}-{3:3}, at: __do_munmap+0x417/0x4f0
>>>>>> [   84.531287]  #1: ffffffffbcd929c0 
>>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>>>>> unmap_vmas+0x5/0x170
>>>>>> [   84.541896]
>>>>>>                stack backtrace:
>>>>>> [   84.547630] CPU: 3 PID: 3453 Comm: kfdtest Not tainted 
>>>>>> 5.19.0-kfd-fkuehlin #75
>>>>>> [   84.555537] Hardware name: To Be Filled By O.E.M. To Be Filled 
>>>>>> By O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
>>>>>> [   84.565788] Call Trace:
>>>>>> [   84.568925]  <TASK>
>>>>>> [   84.571702]  dump_stack_lvl+0x45/0x59
>>>>>> [   84.576034]  check_noncircular+0xfe/0x110
>>>>>> [   84.580715]  ? kernel_text_address+0x6d/0xe0
>>>>>> [   84.585652]  __lock_acquire+0x12ed/0x27e0
>>>>>> [   84.590340]  lock_acquire+0xca/0x2e0
>>>>>> [   84.594595]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>> [amdgpu]
>>>>>> [   84.602338]  __mutex_lock+0x9a/0xf30
>>>>>> [   84.606714]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>> [amdgpu]
>>>>>> [   84.614262]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>> [amdgpu]
>>>>>> [   84.621806]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>> [amdgpu]
>>>>>> [   84.629353] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>> [amdgpu]
>>>>>> [   84.636742]  ? lock_release+0x139/0x2b0
>>>>>> [   84.641374] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>>>> [   84.647976]  unmap_vmas+0x162/0x170
>>>>>> [   84.652203]  unmap_region+0xa8/0x110
>>>>>> [   84.656503]  __do_munmap+0x209/0x4f0
>>>>>> [   84.660792]  __vm_munmap+0x78/0x120
>>>>>> [   84.664977]  __x64_sys_munmap+0x17/0x20
>>>>>> [   84.669499]  do_syscall_64+0x35/0x80
>>>>>> [   84.673755]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>> [   84.679485] RIP: 0033:0x7f32872eb97b
>>>>>> [   84.683738] Code: 8b 15 19 35 0d 00 f7 d8 64 89 02 48 c7 c0 ff 
>>>>>> ff ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 
>>>>>> 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 34 0d 00 
>>>>>> f7 d8 64 89 01 48
>>>>>> [   84.703915] RSP: 002b:00007fffb06c4508 EFLAGS: 00000246 
>>>>>> ORIG_RAX: 000000000000000b
>>>>>> [   84.712205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
>>>>>> 00007f32872eb97b
>>>>>> [   84.720072] RDX: 0000000004000000 RSI: 0000000004000000 RDI: 
>>>>>> 00007f32831ae000
>>>>>> [   84.727944] RBP: 00007fffb06c4750 R08: 00007fffb06c4548 R09: 
>>>>>> 000055e7570ad230
>>>>>> [   84.735809] R10: 000055e757088010 R11: 0000000000000246 R12: 
>>>>>> 000055e75453cefa
>>>>>> [   84.743688] R13: 0000000000000000 R14: 0000000000000021 R15: 
>>>>>> 0000000000000000
>>>>>> [   84.751584]  </TASK>
>>>>>>
>>>>>>
>>>>>
>>>
>>

