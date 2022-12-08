Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD08C3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 16:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C06E10E4C9;
	Thu,  8 Dec 2022 16:28:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A2410E4C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 16:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMTBC/L9LrDmtE3wk3U8rOvPwJywkeEVIangnOs86KZUVrvjpxL0nKRlyGDOPFBUjidK7ZFvhji7Ti+XJO26ojGatjKH1A34AlfMoj+mXgx9fv8JqdiL9bmMFJsqj+6Y3WsPftzLutKcT99TVZlvCP+EbK+e7qjvIs6YVxjJkx7bao93AXuoJvjnTKbs3k9lYD5Xb5ciwMnwC7e+0IjZ+rMsq/8FQJ2P2+pWTVeuhru6LVb/GOgdcBiJNuztnxu/C0dpnezV4Y0A8c9wCXBBqKbRaUuuD2XF52/a/fj6+9XZ/Dk4lwjB+PbQeri8fTRZ+ygx2bDzBzEJ6+TIHlJLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehyU6/1ZCdm59hDsfR99Ist2LIvqAhQ9WpPfiBLTjHk=;
 b=CdSJ0+SyCbmNbNFrK1JEypSB1ZAqboNTohMHaIcDp1hO2HZmDem2nobohSoiWAX0zt8Q5Fgc9iSLBjwRem8UNKL0IvxhJlVkv8psi6kn101l+CITnc0z9Zk05Bu4oNpiXORELwwyOm0YNowq09WqXahDiceforYJO16aIiwTvPLVHL849DYtgeH0zE9pV06U8FPRrQz5iUAGL+DYepRACwu4eDQZU2UfXqzsX+ch4gbtcs97OJoD9ATep+24a4nQc8WgwhubEo0HPV4YUe3sgycFZg0UCcByKtiW+zpxhLvfEmf4O6+WTWuhuzUslO+mYcI/B4W+/CGhT78T2JwDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehyU6/1ZCdm59hDsfR99Ist2LIvqAhQ9WpPfiBLTjHk=;
 b=P1opUAAYgMht/I0aBBc2GpLrIoLvQv/FQIOqwcMidG5p84DShYMngsJKo30iQiBWJ3LO1Wfj0zEO0Yvmg7VFLDXul2yG3rbFNKr8mKSBpQvJN/b97f0kilL+UNvT/JAoSaOcE8vduQQd7YXmB+HLA/YONu1SbhAb1rSah2g934Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 16:28:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 16:28:16 +0000
Message-ID: <cff19c5c-3c2a-33ab-043e-5d4836613669@amd.com>
Date: Thu, 8 Dec 2022 11:28:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Another circular lock dependency involving fs-reclaim and
 drm_buddy
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <5fb7e577-e17e-c791-c107-2424b80ea853@amd.com>
 <eb075cb2-1649-e149-6f53-c86a30f9fffd@amd.com>
 <ee07b373-9de2-faac-320c-ee7b15048cd9@amd.com>
 <dd4979da-6abd-ba02-8840-d59b78a3020d@amd.com>
 <917226e7-9e62-9cda-9f9b-eff4ce5a90c0@amd.com>
 <2df5f87e-fbf4-2364-fab6-7e3dbd4e5361@amd.com>
 <7064f6ad-f180-0514-7ca4-0e240142bc28@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <7064f6ad-f180-0514-7ca4-0e240142bc28@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0004.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::17)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a488c8-0fab-436d-dddc-08dad9393584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7dI4vEUEiAqLy9bvYDKeKoFpOvYGAJEOB7llXu6gv/S7/bCvjGiREZZkyYd6KnPFjokqi9VTx+nFEAKuXt+N1hUGpX4Xxp1nj5whifxmn1+kCIH7RpS48U9YUEYLNRwCg/JZehTBX1dv3R0dTYcPVMYIvY95fCZmk6sJP81JH5YJRqxIxc7+AVPIZqFIKO8omHpD6mxtb9kTm3HhKcUjEMP8gWLEqnlqji0KaZGYAzWlBhHBd9Ii0S5NJde+VOwuBiLdFZpfmW9e07UPbgFsQc/P0WkcfB420QUccnHqzMySmb2Iz6Sp0KJrv2AO9qUkN9DBL1Kw31d6ZzRqMQ7IC42fE+vssKqrbUx7hDGvRCrtgfSv+4+Tn0OGcAt/4zi5iY6Mp2FyM2c2S1HxK7e4tZKZH6w/MIDMHCU4eyrVF/GfVrMDfOv/NnSXAIi4f65s+KnaomEDSyBCptgTqTuql+LU6WQkf03jCE/9ik0fY4BEZRSVHyxKWrDrHpGfPwuNtqZlRM3YQ69llHCnQq6IOsjNacu0Dc8woPALFjHD7XBfgq3o4i/VZ0YeFGnGjAZEP8n0TTfL46JIFXfNnGuteqkpeHTMCNbLxzdtaCFPseRoaFYD7qqcO91ePcoY8tk52z04OPKwaC6nI7LD1CjCg07yyKK6f/St5rTVOSfM8QrjZXuoqfcwgb6auCTeWX/euTui317OGyFSfdL/RZerH1eDartwXOPILxZXkJCw28=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(31686004)(31696002)(36756003)(5660300002)(30864003)(66574015)(2906002)(44832011)(186003)(83380400001)(2616005)(8936002)(41300700001)(86362001)(66556008)(66476007)(6512007)(26005)(6506007)(316002)(478600001)(110136005)(8676002)(38100700002)(66946007)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1llazF2TTJ6KzVtY0JMbS9HdmVIUHpRN1VRSTY5THV0Y3BEUGd2cVh6U0pq?=
 =?utf-8?B?WmxsZkhUeEtwRGNEOXZuM3B1WGIxV2hTMU4zMjdpeks4cUhGT0U0MnpvOVdV?=
 =?utf-8?B?bmltcnlHZjdWM1MxVWZOZGVpOE1QWlZKdVZWUkdJZlZJRGFGK3NUZFZGZzU4?=
 =?utf-8?B?bDR2dUZvSElCZkkrUzhZSnlhU0hJV0lYckovK1k3Q3ErU1lJR3VDaW9rR1NI?=
 =?utf-8?B?cy9uT3dxeDdSczdSRjhPQ3pvRURsRjFCRld5c09ZWGhoZUo1WUZBWHhwVzJG?=
 =?utf-8?B?VnBRVkpwVHgwRzZXWHZsMDhqZDdDc1JJY1NTZ3FxbmZZZ2xOanhRSGtLRGVR?=
 =?utf-8?B?Ynh6cUJqL3RSTXhzY3hPSkp2M0tzdHVkSWxYU0J6elAwU2RmN3ZqZzBkY3Yr?=
 =?utf-8?B?ZkkzRFg0SEVjalNHd0pUVW1ucGJwM2dscmlqMkpqajcwQlR3OGV0MWh2eHRK?=
 =?utf-8?B?cWpnd1kybkpyVit1dXlYNGxFd0RzZ1ViZUxBRzhMalFXc00yMWV5MXErVWRF?=
 =?utf-8?B?blZCTFpMYTdNK0dsNDNCWUt4SkZmK1RmclIrSGpXWnF5c1R0T1Z0SlgwWUE2?=
 =?utf-8?B?bVJ1MWo3Qk5rSkZ6SHBVajlVYmowUzAvUkdMWVNCZDBmVjFoampVUkNUeGsz?=
 =?utf-8?B?dWVsR1Uzdy9PMGtPOFJRM2NxNVlLekxsdEFWNU5mOHJwbjBTcDZLL0ZJSWlM?=
 =?utf-8?B?NFVVOVVBMlNCaVVVVjJYRGpBMXdUbmMvcVJ1dWEvaTZQVWNkZlNsYjgvNzc1?=
 =?utf-8?B?eDU0NHFUWktWVFJiZ0hzcEJGZVNINXZaYlljVkxkbFRabXFtcE50K2hFZWVQ?=
 =?utf-8?B?TEtaVzVYSklDclYzemx5KzJITUJDOE1UMG9jdDNMTTQ5VkZlVlcvZVRpSmVU?=
 =?utf-8?B?T1JQWERTQXVmcFM1cDVYTzRXcWdQd0tnUU5MSHdEMUJYNVFEWWEybW1VR09K?=
 =?utf-8?B?akkzWmlQZWplOHRaQWUza0VNUmR3UW53cWRCb0swbi9vNDNXMERManppVDVl?=
 =?utf-8?B?QSsrVDE1c0JkOVFvWWI4K1NrOC9wZ0lxMlkvK1lwWU13RVREU1FBZnR4cHNI?=
 =?utf-8?B?ekh2VkNtWVVXZmw4SDRhNUlXZDJTYjN5VHBldFNjQmIvUVJYWm1NcGVEczN1?=
 =?utf-8?B?ZDVZNmd6aWZpZExZY1NzMVo0clBzV1p2RHFEZTNrTDlHenRsdk1XQkxya1VB?=
 =?utf-8?B?WjFQRVdSNm9rRTB2ZGdiU2Z4SFVZRTZ2cUZsdUl3SWx3ZmVoaGNybjM5dTc1?=
 =?utf-8?B?dVhPb1NsNUtIRnpLMFV0S080Q2Q2alZ5L0ZvOUFXbVlVWFQyNEd1V1FzbkFL?=
 =?utf-8?B?Mmd0UXNNcmdFNTFqY28vOE5qeGlOK3lLMm1QUlhSZmtXM2x3RjVBbHZUQzZO?=
 =?utf-8?B?ZG1LMkdZQ1BpTWVQRXBsZmltRkxyZnByRUJQNlRxeXZhbVM4bjZsaDdEV29k?=
 =?utf-8?B?UVBmWGVUbzJ3N3BCMm90NXkwYm9wTjh0VmU0Z3Q5RWgzc2l0OFltZiszUTdn?=
 =?utf-8?B?WjB1SXVGNTJ3MTkrVS9tQXN4dFc4TFFyRWtKSWtjeG1mcDB2VG5hbHE3R0NM?=
 =?utf-8?B?c21qWWljMmRZUStZcDc5UFNweDZEVGFoRW5KNzRxYkN3MGkxZ1ZPSnlPeCtn?=
 =?utf-8?B?S2loWUR4QVJqV05qUTcxZVViclNoOVRGTHVoYVorei9PUGdUcHp6ZzBLNDZ0?=
 =?utf-8?B?U0ZTcW5oaG5hREFjeVROU2ZLTzYxQ3dBTDVOemRpbHZtUkpMWHE3NFIwWnBr?=
 =?utf-8?B?azVqN3BWdUJDajJXWWFIamYzL05KU0tQaW5aNW9xRmhTdVFIOEZSMGpuMVR0?=
 =?utf-8?B?N2RZU1ZwbXU4M1pwcVBoMTNFWWM5cStlcGNoS043TCtIeHV6Nlpwc1hZY2hy?=
 =?utf-8?B?blZ3TmtNOVF0TVJPVDZKM3ZDbDhJTmJ2YUQ2ZmNlSldIeXpJMHR5bjl1QXd4?=
 =?utf-8?B?QmFwTjRsajYwM2VYRmdOVzFsR3NaNWpNOU1QQndzTklneEhHYWpwWExWYzkx?=
 =?utf-8?B?WEdmNVpiZUQ2UlJZY0M1U2dmdDFoV3FVSmJ3Q3BZMUsyd0JiZVI4RGUzMEZN?=
 =?utf-8?B?NUcrT2hhMmhYVnR5di9HTVRMUk5malJxOXZSbUJRTkVOSEVWYW9rMkJmZW9p?=
 =?utf-8?Q?5Tdtq5o+zk1t66fN29YoJScPF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a488c8-0fab-436d-dddc-08dad9393584
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 16:28:16.1859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L02of59xJtX3F9p4+64AC/hFa9e44dIv5UTDc9Hpsn3zOwGCJ+mjVnJJj7PyHFQ82neT1uddbk14L3yzTMjnXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076
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

Am 2022-12-08 um 10:44 schrieb Christian König:
> Am 08.12.22 um 16:19 schrieb Felix Kuehling:
>> Am 2022-12-08 um 07:32 schrieb Christian König:
>>> Hi Felix,
>>>
>>> digging though the code I think I know now how we can solve this.
>>>
>>> The lock which needs to protect the validity of the pages is the 
>>> vm->eviction_lock, cause this one is what serializes the updates of 
>>> our page table.
>>>
>>> This means that the amdgpu_vm_update_range() function needs to be 
>>> extended further with enough information to check the HMM sequence 
>>> after grabbing the eviction lock.
>>
>> I don't see how taking one more lock helps resolve a lock dependency 
>> issue. Right now the vm->eviction lock is not in the dependency cycle 
>> at all.
>>
>> Do you mean we should use the vm->eviction lock instead of the 
>> prange->lock to serialize page table updates with MMU notifiers?
>
> Exactly that, yes.
>
>> I don't see how that solves the problem either. It just changes the 
>> lock that's involved in the cycle here. And it contradicts the 
>> previous change made by Philip, who removet vm->eviction lock from 
>> the cycle by dropping it just before potentially allocating page tables.
>
> Yeah, and that change solves our issue.
>
>>
>> The fundamental problem, as I understand it, is that we need to hold 
>> the same lock in the MMU notifier and while updating page tables.
>
> No, that's what I meant initially. This is the wrong way to see it.
>
> What we need is a lock which serializes page tables updates and at the 
> same time is independent of allocating page tables.
>
> After taking this lock we need to validate the addresses we want to 
> write into the page tables before doing so.
>
> So the resulting sequence for validation should be:
>
> seq = mmu_interval_read_begin();
> hmm_range_fault(pages);
> amdgpu_vm_update_range(... pages, seq...)
> {
>     ....
>     amdgpu_vm_eviction_lock();
>     if (mmu_interval_read_retry(seq))
>         return -EAGAIN;
>     ...
>     amdgpu_vm_pt_alloc()
>     {
>         amdgpu_vm_eviction_unlock();
>         ....
>         amdgpu_vm_eviction_lock();
>         if (mmu_interval_read_retry(seq);
>             return -EAGAIN;
>     }
>     amdgpu_vm_eviction_unlock();
> }
>
>
> That's the only way I can see how we can actually make this work.

OK. I think that's a good way to move the memory allocation out of the 
critical section. And it also makes the critical section smaller. One 
potential problematic issue is, that we can make multiple calls to 
amdgpu_vm_update_range for one hmm_range when some pages are in 
different locations (system memory or VRAM). We'd have to separate the 
mmu_interval_read_retry from freeing the hmm_range, which is currently 
done together in amdgpu_hmm_range_get_pages_done.

I'd have to think through any other locking implications to our MMU 
notifier and other places that need to serialize with MMU notifiers. We 
may not be able to use the vm->eviction lock everywhere. We'll probably 
still want to take prange->lock in our MMU notifier.

Another alternative would be to pass the lock into 
amdgpu_vm_update_range as a parameter. This would allow for more 
fine-grained locking per range, rather than per-VM.

Regards,
   Felix


>
> Regards,
> Christian.
>
>
>> That makes it difficult to allocate memory during page table updates 
>> because we cannot allow reclaim. Any lock taken during memory 
>> allocation gets drawn into the cycle, in this case the 
>> vram_mgr->lock. Unless we find a way to move page table allocation 
>> out of that critical section, we can never do reclaim while holding 
>> vram_mgr->lock.
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Or am I missing something here?
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 06.12.22 um 16:57 schrieb Christian König:
>>>> Am 06.12.22 um 16:14 schrieb Felix Kuehling:
>>>>> Am 2022-12-06 um 03:20 schrieb Christian König:
>>>>>> Hi Felix,
>>>>>>
>>>>>> to be honest I think the whole approach you take here and 
>>>>>> unmapping the range with the lock held is highly problematic.
>>>>>>
>>>>>> Essentially unmapping is something which can run concurrently 
>>>>>> with other operations and should never be blocked by such a lock. 
>>>>>> In other words it is perfectly valid for an unmap to run while 
>>>>>> another processor tries to map the same range.
>>>>>
>>>>> I strongly disagree. When an MMU notifier invalidates a virtual 
>>>>> address range, it must guarantee that the device will not access 
>>>>> the current physical location of the invalidated range any more. 
>>>>> Without the lock, another processor could easily overwrite the 
>>>>> invalidated PTEs with valid (but outdated) addresses that the MMU 
>>>>> notifier just removed.
>>>>>
>>>>> This is the relevant paragraph in the HMM doc:
>>>>>
>>>>>    [example of driver updating its page table ...]
>>>>>           take_lock(driver->update);
>>>>>           if (mmu_interval_read_retry(&ni, range.notifier_seq) {
>>>>>               release_lock(driver->update);
>>>>>               goto again;
>>>>>           }
>>>>>
>>>>>           /* Use pfns array content to update device page table,
>>>>>            * under the update lock */
>>>>>
>>>>>           release_lock(driver->update);
>>>>>           return 0;
>>>>>      }
>>>>>
>>>>>    The driver->update lock is the same lock that the driver takes
>>>>>    inside its
>>>>>    invalidate() callback. That lock must be held before calling
>>>>>    mmu_interval_read_retry() to avoid any race with a concurrent CPU
>>>>>    page table
>>>>>    update.
>>>>
>>>>
>>>> There is something massively missing here since that won't work at 
>>>> all.
>>>>
>>>> The problem is that we can't allocate memory nor fault pages while 
>>>> any lock is held which is also held inside the invalidation 
>>>> callback of the MMU notifier.
>>>>
>>>> Updating the PTEs will always need memory, e.g. we can't guarantee 
>>>> that we won't allocate page tables. Otherwise dynamic allocating 
>>>> tables won't work any more.
>>>>
>>>>>>
>>>>>> That's why the same page fault can occur multiple times until the 
>>>>>> page tables are up to date.
>>>>>>
>>>>>> When you get an MMU notification that range A->B is invalidated 
>>>>>> you trigger invalidation of range A->B inside the GPUVM address 
>>>>>> space as well and that's completely independent what's mapped there.
>>>>>
>>>>> Not exactly. Because we're in a shared virtual address space, we 
>>>>> know exactly what's mapped there.
>>>>
>>>> Yeah, but that's irrelevant. We are not allowed to use this 
>>>> information, cause otherwise we run exactly into the described 
>>>> issues again.
>>>>
>>>>> If the MMU notifier invalidates it, we have to coordinate with it 
>>>>> to make sure we don't write incorrect addresses into those PTEs. 
>>>>> In the example above, holding the lock guarantees that a 
>>>>> concurrent MMU notifier will not return until after it has 
>>>>> overwritten the PTEs we just updated. Alternatively 
>>>>> mmu_interval_read_retry fails, which means the MMU notifier got 
>>>>> there first and we have to get updated addresses with 
>>>>> hmm_range_fault. Either way, the page table ends up with PTEs with 
>>>>> V=0 before the MMU notifier returns.
>>>>>
>>>>> Without holding the lock while writing the page table, we could 
>>>>> end up with a mix of valid (V=1, but outdated address) and invalid 
>>>>> PTEs when there is a concurrent validation and invalidation of the 
>>>>> same virtual address range.
>>>>
>>>> Yeah, I see the problem now as well. But I can't come up with any 
>>>> way to solve this.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>>
>>>>>> Invalidating the mappings and eventually scheduling that they are 
>>>>>> re-created is a separate step which should come independent of 
>>>>>> this if I'm not completely mistaken.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>> Am 06.12.22 um 01:04 schrieb Felix Kuehling:
>>>>>>> We fixed a similar issue with Philip's patch "drm/amdgpu: Drop 
>>>>>>> eviction lock when allocating PT BO", but there was another one 
>>>>>>> hiding underneath that (see the log below). The problem is, that 
>>>>>>> we're still allocating page tables while holding the 
>>>>>>> prange->lock in the kfd_svm code, which is also held in MMU 
>>>>>>> notifiers. This creates a lock dependency between the 
>>>>>>> vram_mgr->lock and fs-reclaim.
>>>>>>>
>>>>>>> There are three ways around this:
>>>>>>>
>>>>>>>  * Do the page table mapping outside prange->lock (creates a race,
>>>>>>>    contradicts advice in Documentation/vm/hmm.rst)
>>>>>>>  * Avoid all page table allocation in amdgpu_vm_update_range (i.e.
>>>>>>>    allocate page tables ahead of time somehow)
>>>>>>>  * Wrap vram_mgr->lock with memalloc_noreclaim_save/restore (may 
>>>>>>> cause
>>>>>>>    memory allocations to fail in drm_buddy under memory pressure)
>>>>>>>
>>>>>>> I only mention the first one for completeness. It's not a valid 
>>>>>>> solution. Neither of the remaining two options are particularly 
>>>>>>> appealing either.
>>>>>>>
>>>>>>> Regards,
>>>>>>>   Felix
>>>>>>>
>>>>>>>
>>>>>>> [   83.979486] 
>>>>>>> ======================================================
>>>>>>> [   83.986583] WARNING: possible circular locking dependency 
>>>>>>> detected
>>>>>>> [   83.993643] 5.19.0-kfd-fkuehlin #75 Not tainted
>>>>>>> [   83.999044] 
>>>>>>> ------------------------------------------------------
>>>>>>> [   84.006088] kfdtest/3453 is trying to acquire lock:
>>>>>>> [   84.011820] ffff9a998561e210 (&prange->lock){+.+.}-{3:3}, at: 
>>>>>>> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>>>>> [   84.023911]
>>>>>>>                but task is already holding lock:
>>>>>>> [   84.031608] ffffffffbcd929c0 
>>>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>>>>>> unmap_vmas+0x5/0x170
>>>>>>> [   84.041992]
>>>>>>>                which lock already depends on the new lock.
>>>>>>>
>>>>>>> [   84.052785]
>>>>>>>                the existing dependency chain (in reverse order) is:
>>>>>>> [   84.061993]
>>>>>>>                -> #3 
>>>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
>>>>>>> [   84.071548]        fs_reclaim_acquire+0x6d/0xd0
>>>>>>> [   84.076941] kmem_cache_alloc_trace+0x34/0x760
>>>>>>> [   84.082766]        alloc_workqueue_attrs+0x1b/0x50
>>>>>>> [   84.088411]        workqueue_init+0x88/0x318
>>>>>>> [   84.093533]        kernel_init_freeable+0x134/0x28f
>>>>>>> [   84.099258]        kernel_init+0x16/0x130
>>>>>>> [   84.104107]        ret_from_fork+0x1f/0x30
>>>>>>> [   84.109038]
>>>>>>>                -> #2 (fs_reclaim){+.+.}-{0:0}:
>>>>>>> [   84.116348]        fs_reclaim_acquire+0xa1/0xd0
>>>>>>> [   84.121697]        kmem_cache_alloc+0x2c/0x760
>>>>>>> [   84.126948]        drm_block_alloc.isra.0+0x27/0x50 [drm_buddy]
>>>>>>> [   84.133679]        split_block+0x4d/0x140 [drm_buddy]
>>>>>>> [   84.139539] drm_buddy_alloc_blocks+0x385/0x580 [drm_buddy]
>>>>>>> [   84.146435]        amdgpu_vram_mgr_new+0x213/0x4f0 [amdgpu]
>>>>>>> [   84.153399]        ttm_resource_alloc+0x31/0x80 [ttm]
>>>>>>> [   84.159366]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>>>>>> [   84.165169]        ttm_bo_validate+0xc5/0x170 [ttm]
>>>>>>> [   84.170872]        ttm_bo_init_reserved+0x1a6/0x230 [ttm]
>>>>>>> [   84.177075]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>>>>>> [   84.183600] amdgpu_bo_create_reserved+0x188/0x1e0 [amdgpu]
>>>>>>> [   84.190803] amdgpu_bo_create_kernel_at+0x64/0x200 [amdgpu]
>>>>>>> [   84.197994]        amdgpu_ttm_init+0x420/0x4c0 [amdgpu]
>>>>>>> [   84.204301]        gmc_v10_0_sw_init+0x33a/0x530 [amdgpu]
>>>>>>> [   84.210813] amdgpu_device_init.cold+0x10d4/0x17a1 [amdgpu]
>>>>>>> [   84.218077] amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>>>>>>> [   84.224919]        amdgpu_pci_probe+0x142/0x350 [amdgpu]
>>>>>>> [   84.231313]        local_pci_probe+0x40/0x80
>>>>>>> [   84.236437]        work_for_cpu_fn+0x10/0x20
>>>>>>> [   84.241500]        process_one_work+0x270/0x5a0
>>>>>>> [   84.246805]        worker_thread+0x203/0x3c0
>>>>>>> [   84.251828]        kthread+0xea/0x110
>>>>>>> [   84.256229]        ret_from_fork+0x1f/0x30
>>>>>>> [   84.261061]
>>>>>>>                -> #1 (&mgr->lock){+.+.}-{3:3}:
>>>>>>> [   84.268156]        __mutex_lock+0x9a/0xf30
>>>>>>> [   84.272967]        amdgpu_vram_mgr_new+0x14a/0x4f0 [amdgpu]
>>>>>>> [   84.279752]        ttm_resource_alloc+0x31/0x80 [ttm]
>>>>>>> [   84.285602]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>>>>>> [   84.291321]        ttm_bo_validate+0xc5/0x170 [ttm]
>>>>>>> [   84.296939]        ttm_bo_init_reserved+0xe2/0x230 [ttm]
>>>>>>> [   84.302969]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>>>>>> [   84.309297]        amdgpu_bo_create_vm+0x2e/0x80 [amdgpu]
>>>>>>> [   84.315656]        amdgpu_vm_pt_create+0xf5/0x270 [amdgpu]
>>>>>>> [   84.322090] amdgpu_vm_ptes_update+0x6c4/0x8f0 [amdgpu]
>>>>>>> [   84.328793] amdgpu_vm_update_range+0x29b/0x730 [amdgpu]
>>>>>>> [   84.335537] svm_range_validate_and_map+0xc78/0x1390 [amdgpu]
>>>>>>> [   84.342734]        svm_range_set_attr+0xc74/0x1170 [amdgpu]
>>>>>>> [   84.349222]        kfd_ioctl+0x189/0x5c0 [amdgpu]
>>>>>>> [   84.354808]        __x64_sys_ioctl+0x80/0xb0
>>>>>>> [   84.359738]        do_syscall_64+0x35/0x80
>>>>>>> [   84.364481] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>>> [   84.370687]
>>>>>>>                -> #0 (&prange->lock){+.+.}-{3:3}:
>>>>>>> [   84.377864]        __lock_acquire+0x12ed/0x27e0
>>>>>>> [   84.383027]        lock_acquire+0xca/0x2e0
>>>>>>> [   84.387759]        __mutex_lock+0x9a/0xf30
>>>>>>> [   84.392491] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>>> [amdgpu]
>>>>>>> [   84.400345] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>>>>> [   84.407410]        unmap_vmas+0x162/0x170
>>>>>>> [   84.412126]        unmap_region+0xa8/0x110
>>>>>>> [   84.416905]        __do_munmap+0x209/0x4f0
>>>>>>> [   84.421680]        __vm_munmap+0x78/0x120
>>>>>>> [   84.426365]        __x64_sys_munmap+0x17/0x20
>>>>>>> [   84.431392]        do_syscall_64+0x35/0x80
>>>>>>> [   84.436164] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>>> [   84.442405]
>>>>>>>                other info that might help us debug this:
>>>>>>>
>>>>>>> [   84.452431] Chain exists of:
>>>>>>>                  &prange->lock --> fs_reclaim --> 
>>>>>>> mmu_notifier_invalidate_range_start
>>>>>>>
>>>>>>> [   84.466395]  Possible unsafe locking scenario:
>>>>>>>
>>>>>>> [   84.473720]        CPU0                    CPU1
>>>>>>> [   84.479020]        ----                    ----
>>>>>>> [   84.484296] lock(mmu_notifier_invalidate_range_start);
>>>>>>> [   84.490333] lock(fs_reclaim);
>>>>>>> [   84.496705] lock(mmu_notifier_invalidate_range_start);
>>>>>>> [   84.505246]   lock(&prange->lock);
>>>>>>> [   84.509361]
>>>>>>>                 *** DEADLOCK ***
>>>>>>>
>>>>>>> [   84.517360] 2 locks held by kfdtest/3453:
>>>>>>> [   84.522060]  #0: ffff9a99821ec4a8 
>>>>>>> (&mm->mmap_lock#2){++++}-{3:3}, at: __do_munmap+0x417/0x4f0
>>>>>>> [   84.531287]  #1: ffffffffbcd929c0 
>>>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>>>>>> unmap_vmas+0x5/0x170
>>>>>>> [   84.541896]
>>>>>>>                stack backtrace:
>>>>>>> [   84.547630] CPU: 3 PID: 3453 Comm: kfdtest Not tainted 
>>>>>>> 5.19.0-kfd-fkuehlin #75
>>>>>>> [   84.555537] Hardware name: To Be Filled By O.E.M. To Be 
>>>>>>> Filled By O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
>>>>>>> [   84.565788] Call Trace:
>>>>>>> [   84.568925]  <TASK>
>>>>>>> [   84.571702]  dump_stack_lvl+0x45/0x59
>>>>>>> [   84.576034]  check_noncircular+0xfe/0x110
>>>>>>> [   84.580715]  ? kernel_text_address+0x6d/0xe0
>>>>>>> [   84.585652]  __lock_acquire+0x12ed/0x27e0
>>>>>>> [   84.590340]  lock_acquire+0xca/0x2e0
>>>>>>> [   84.594595]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>>> [amdgpu]
>>>>>>> [   84.602338]  __mutex_lock+0x9a/0xf30
>>>>>>> [   84.606714]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>>> [amdgpu]
>>>>>>> [   84.614262]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>>> [amdgpu]
>>>>>>> [   84.621806]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>>> [amdgpu]
>>>>>>> [   84.629353] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>>> [amdgpu]
>>>>>>> [   84.636742]  ? lock_release+0x139/0x2b0
>>>>>>> [   84.641374] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>>>>> [   84.647976]  unmap_vmas+0x162/0x170
>>>>>>> [   84.652203]  unmap_region+0xa8/0x110
>>>>>>> [   84.656503]  __do_munmap+0x209/0x4f0
>>>>>>> [   84.660792]  __vm_munmap+0x78/0x120
>>>>>>> [   84.664977]  __x64_sys_munmap+0x17/0x20
>>>>>>> [   84.669499]  do_syscall_64+0x35/0x80
>>>>>>> [   84.673755] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>>> [   84.679485] RIP: 0033:0x7f32872eb97b
>>>>>>> [   84.683738] Code: 8b 15 19 35 0d 00 f7 d8 64 89 02 48 c7 c0 
>>>>>>> ff ff ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
>>>>>>> b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 34 
>>>>>>> 0d 00 f7 d8 64 89 01 48
>>>>>>> [   84.703915] RSP: 002b:00007fffb06c4508 EFLAGS: 00000246 
>>>>>>> ORIG_RAX: 000000000000000b
>>>>>>> [   84.712205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
>>>>>>> 00007f32872eb97b
>>>>>>> [   84.720072] RDX: 0000000004000000 RSI: 0000000004000000 RDI: 
>>>>>>> 00007f32831ae000
>>>>>>> [   84.727944] RBP: 00007fffb06c4750 R08: 00007fffb06c4548 R09: 
>>>>>>> 000055e7570ad230
>>>>>>> [   84.735809] R10: 000055e757088010 R11: 0000000000000246 R12: 
>>>>>>> 000055e75453cefa
>>>>>>> [   84.743688] R13: 0000000000000000 R14: 0000000000000021 R15: 
>>>>>>> 0000000000000000
>>>>>>> [   84.751584]  </TASK>
>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>>
>
