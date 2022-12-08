Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D93C3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 15:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AEE710E4B1;
	Thu,  8 Dec 2022 15:19:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7073F10E4B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 15:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fL53taSX0DimCOsB23i2yv4Ao1aD+q4lz8cYgOgJIDLWJ3NhNZs8wn41v7zQlI0vcJqk0aiItvysBmMscqOHhVTj7ssHj6U3QYxJGJu2Owez/Jb0m186gQgnV2umGjw2bccCEMAiBvOXa50aW7+Kbc0IjOgML2AAnNsebXvbwxhRtQ3xunJqUQU9bSLF0xj2t2PulUUr13ZjQIa+46X1JTK1QYOuYF4WkZTLaAgZ2YATiTbihxSXfYs0m0F+4T2KTJ+VV8mRJHq+y9n9xPIvVQ2bRQicZ8t9uLiZ4PWCBrR1c42bpDtXNc8PUeYMywAbBT9jCSHECG93lxEU6o8XjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aak52rZzBsVQXWpxa6nsOg7W5jCumylPujJHm41krg=;
 b=WzRaNKbQ01nIVg0zWVxXQ1uyHUPMhVxYAxf7tGIgZjAqdQIwtZc9qSXZ7zgPQgt8parJM91bbCw6biFK8u/21iPV8QjlGNxFmdTjCHMEZKd8zx32c4SfAqEgbRi7XZN86pBBf9BULdRuD0pLy/f/TeRbPhlM1BHZ4HoVJkCWv6mCmGQPXehBOG5ZQ7OarkiFhF4A8mMn7NHlZuRHaleGnaKLoZbBVWQNrMk8JVr0gLDL/oJBHFM65OHC3CJT5csC1bK5LD6aguV/Qs4qIHKwT9dECtQVaBwbhsLfIhPVJbm4zf4Vv4RhyOZSoWVwSpvjOAm0R5k5GfpiBI7d5wqryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aak52rZzBsVQXWpxa6nsOg7W5jCumylPujJHm41krg=;
 b=jEjRp5uIdqfmNNk8bm9MG354ZAO3D4xYzRBUhkbo+rx2H4UajXS6N27VKZ62l9OEfCEffcdUjon+ydcCog807UmRFjPqteRxSuBnXC9Wcpdgrscob6RlLY35Dbuj+NNQxbI/wG1CqNuKX3HNupyhvY7FWO3jSpzAvGVS8xtnoKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 15:19:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 15:19:36 +0000
Message-ID: <2df5f87e-fbf4-2364-fab6-7e3dbd4e5361@amd.com>
Date: Thu, 8 Dec 2022 10:19:34 -0500
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
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <917226e7-9e62-9cda-9f9b-eff4ce5a90c0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd2c44e-0af5-4f52-8088-08dad92f9dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9pu6JT9iLGyKakSzaH2nAn2uyWszzm5niEWt3qQdB7X387nx66AXzTgFcwixgs6AW2kcyZ/Vw1NQvRfXbtTEwSmG+T8yPH5m4uu/DJJHcWY99Plqughn2CUUFexpK36MR+rvJfpvr9dbn+kvp2aIVBN0piYNn8Xg+6yx38VnYOWW7+YDPzbjK6ktLBSjR/SG7FjQFECqf0svi3Y1+0rErxX0U5JkfXxn8XTqJCYRJ8wBIYPJp5R16d6BUs+CDImZwroB2kosKdEJa7x7zNT7rSRQ1SMjl3/EyG6K72L7Z4wUYJxabnNZa5FIff0donRCqwYpRVquOifw3SzgJZ+7d6NojBeT6HYydvI0i7KG44RHUr64ca2z/ZV2id4e/D3tmXC0glXIHShxbdDexsy3k1wbO9dcIew++JJhqrUs6+nJGnqUKnrC5KTIDldtjsmKKkwCmp3jASdgcfbPAeDfU169x+2kBl8miiH39Q2WPGfsGCnXoN61YIhU77iIpsQ2LfEbIJiMmuS6BMSg3G8fogqZt62MWfVA5bL7+JB7+DmdAG73y+ZIa9B/9O//sDmjbaF+Gj2B/B/i4Ma44kC5fkB0dPBWqufHjkcEEDOGzMfXMl5KSgUkfUOPz1ZXkVE/Nn2AJ5QAhXuawhV+wFJbgbvAnnW2jD9YwLtDhHa02ObcXJQoDM2yi3jcg8XAIcUAxPi1H3/B/pCTALULTkHhX9MPHUU4n/p1SHYZ6N8BLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(2906002)(31686004)(8936002)(66476007)(83380400001)(8676002)(66946007)(66574015)(31696002)(36756003)(66556008)(44832011)(30864003)(316002)(41300700001)(5660300002)(86362001)(110136005)(6486002)(6512007)(6506007)(478600001)(26005)(2616005)(186003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dFaGN3WmFWbUNNVncvZlJUcXdJNnlIa2FuZEVwN3JOZTY2dG5JRGlESW1Q?=
 =?utf-8?B?RmM2NU5yaktVMzlhUDV1UjJFMzFCVXp2T2ZKSTEwaktVS25aM0pDSE1WSE5G?=
 =?utf-8?B?emRrckV0OUJqWFFiZGJSZ3VhSXlHUlRqc2c3OVJaVUw5U2lzTlVGRXN2bW1y?=
 =?utf-8?B?TWk4U2JQSGoycm5TZTc2SCsxdHNadkg4bVplWkFTcGhaMmpNY0hFTHA3cVd1?=
 =?utf-8?B?c1VWRkhZMlFsUkZUeU1ZcjNjajZyL2JWblh1NmZ3Tlk3REN3QnFBUHNUR3li?=
 =?utf-8?B?SWtqa25SS2tZbG0xNlJ4RTZVNVZPSFhGbFJGdGQrbUFDWE5SOFNjOXVHVlFW?=
 =?utf-8?B?ZStqZGhLK2ttY1RZOXI0cmltWHhhcW94QzQxOGNBaExNazRmbTNGMUhRcjMr?=
 =?utf-8?B?Z0pXZlFSc3NaUGRFOVpLbW9JWUYrWnZlcUxPK1VQaDQ2d1pCeEFrNzFJVkhM?=
 =?utf-8?B?ZTdhZEVEVlNpYTJqRC92NEhQc28rZHRTMVdaaUFXS01PUnRXdjZ6SHZ4dHpT?=
 =?utf-8?B?cDhpZmE1Qlo1SzlCV1paUU1XRDh3N2gxV1pUdWs2cEQ5bzE1SkF1cUFLdXVu?=
 =?utf-8?B?dTNRT3BMR0htUy91Y2tTa21KcG4xSG1SYW00TXFEZE01M3ZNa2RnMXpTTnpv?=
 =?utf-8?B?R3QweFpNZVByZVgyRmNvSUp3MVpwRmJTUzY5aTRxVzFteWFaaDNmRUlGS3lN?=
 =?utf-8?B?TlFxampxWGNrL0JYSVZtdENTRHZSNGpMUW9NUkh1ZzJMMXJTTFMrUlo0OXc3?=
 =?utf-8?B?NEh0MlFjbDRDbW9JN210ZVZmTlowTGNTeFNxQzh2WlBIUGNYZTN5T0dDdk84?=
 =?utf-8?B?ZWNQbTNXK0ZCMnp0enVRTFZ3MkxZWUtrTVkvWWRzUkU5MS9mOUVaR3VCNE85?=
 =?utf-8?B?YUZvUkVucTlaTVpoOGpJRlR4aWhzNUVaaThQMWVJTkdUOS9MV2NQS2dtbU9w?=
 =?utf-8?B?S09rQUFOWWRldHJBc2hQcC9zWDFwS0RMKytnaGd6WHg2aTdCMFB2QWdYeFJI?=
 =?utf-8?B?eXNiK3I2NzAvYW9iNDFYMTB1UEVNN0dDRytWYzg5UVd1ekJyTjhHSTNFcDd3?=
 =?utf-8?B?dVZCR3RGU0NjcE5kRUdlS3g0alNLTUc5OHJZRmhmcmRIeXlRMi9NU09hdjRu?=
 =?utf-8?B?ZFc0bnJoMnlVd2orTG51SHZNWnoyNGM4SGJmUVl0elZTM3A2aDlFcnJvWTlx?=
 =?utf-8?B?WEpOTkdHakNoaDl3UDExZE1SYU9qNVVna2h0WHRXWGpSekI0amlrdE8xS1dp?=
 =?utf-8?B?NlpZaUtRdGtmUEFHQ1ZpdXN4STFMUWJuYVpVWGl3UkpvVWwxZUVIbjU1cDJO?=
 =?utf-8?B?TmppaldkN3FPSEtRNThURXRGUFg0OEw3UjA3OXpFNktSdWUxUzRQeGl3OHNV?=
 =?utf-8?B?NFlFVkFVSm1WVkVPa1YvMHRpcjYrV2VFdDlzL04vVlpPRWVuN1IwakxCRmtp?=
 =?utf-8?B?c3ZNSkk5dUFBQ3hzMm5iNzZCenA4SmdCWWJWbXZQdVUxYnRCVDBEOFp6dUFK?=
 =?utf-8?B?UHRJLzIvYlp2ejlkbXIxdG4xRnBzOUNnblR6anU1UmpUVzJiSXNFNzU0RkJJ?=
 =?utf-8?B?Q3p5VmNaMUU2SG1NbTNKSW1MZGo2MDEwc1BtTDIxbEZJV0Z0eGdGSDZBcm5R?=
 =?utf-8?B?dm5GQXNiSXR5eTFQRXVlMy9QZGpsTnkvUWJjbnF3MVRxVThqU2NwYTlFcHpz?=
 =?utf-8?B?ZHB4WStnckxmOVdWN1A1STMxUDNLU0dSbitaZDBaNkZ3dFZlS3QrbTZEOUJM?=
 =?utf-8?B?SGVOdVNHYVVZNkJKMGRjTmhTejkwc0JDWlRYYlJRMXNWSjEwMUVWZldpVk1Q?=
 =?utf-8?B?NmFwc0NNME5HT2FZb1lGZFBSdUhnTFlLa1ozeDFTNnAzcys5UytSTHRDbkc3?=
 =?utf-8?B?dkdSeHNUU04wckJ4TXNNUFBYRG5kZ3BTcFhtUHBQVlhQSlpBT3dicUYrZWFi?=
 =?utf-8?B?SFdnYTFsalpvR0JLMVEzNjdzTW40NnA2R0FTK09ucDNUV0xGMGNhWWdIT3Bo?=
 =?utf-8?B?ZVF4NHg0eERid0o5SytqNTZwMjRubmR6L1lwdFFWL1pjQW5HWHljTlVjOTNQ?=
 =?utf-8?B?VjVTMi9kWkx2a1IzSHRORnFUcGRpa2FWZkVVZk13R3h1NDN2RG50ZGhUSndQ?=
 =?utf-8?Q?XLOzR3neiM+0ItOtr2H11FUj8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd2c44e-0af5-4f52-8088-08dad92f9dcd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 15:19:36.2558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDeN1HDqSx1HokGKuenP1o4Eiu+RdvEBX1sGkv4pY7irPQaAtAG87aSY69oAw55ynKQco2+L0ZdTfd5gWix1wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
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

Am 2022-12-08 um 07:32 schrieb Christian König:
> Hi Felix,
>
> digging though the code I think I know now how we can solve this.
>
> The lock which needs to protect the validity of the pages is the 
> vm->eviction_lock, cause this one is what serializes the updates of 
> our page table.
>
> This means that the amdgpu_vm_update_range() function needs to be 
> extended further with enough information to check the HMM sequence 
> after grabbing the eviction lock.

I don't see how taking one more lock helps resolve a lock dependency 
issue. Right now the vm->eviction lock is not in the dependency cycle at 
all.

Do you mean we should use the vm->eviction lock instead of the 
prange->lock to serialize page table updates with MMU notifiers? I don't 
see how that solves the problem either. It just changes the lock that's 
involved in the cycle here. And it contradicts the previous change made 
by Philip, who removet vm->eviction lock from the cycle by dropping it 
just before potentially allocating page tables.

The fundamental problem, as I understand it, is that we need to hold the 
same lock in the MMU notifier and while updating page tables. That makes 
it difficult to allocate memory during page table updates because we 
cannot allow reclaim. Any lock taken during memory allocation gets drawn 
into the cycle, in this case the vram_mgr->lock. Unless we find a way to 
move page table allocation out of that critical section, we can never do 
reclaim while holding vram_mgr->lock.

Regards,
   Felix


>
> Or am I missing something here?
>
> Regards,
> Christian.
>
> Am 06.12.22 um 16:57 schrieb Christian König:
>> Am 06.12.22 um 16:14 schrieb Felix Kuehling:
>>> Am 2022-12-06 um 03:20 schrieb Christian König:
>>>> Hi Felix,
>>>>
>>>> to be honest I think the whole approach you take here and unmapping 
>>>> the range with the lock held is highly problematic.
>>>>
>>>> Essentially unmapping is something which can run concurrently with 
>>>> other operations and should never be blocked by such a lock. In 
>>>> other words it is perfectly valid for an unmap to run while another 
>>>> processor tries to map the same range.
>>>
>>> I strongly disagree. When an MMU notifier invalidates a virtual 
>>> address range, it must guarantee that the device will not access the 
>>> current physical location of the invalidated range any more. Without 
>>> the lock, another processor could easily overwrite the invalidated 
>>> PTEs with valid (but outdated) addresses that the MMU notifier just 
>>> removed.
>>>
>>> This is the relevant paragraph in the HMM doc:
>>>
>>>    [example of driver updating its page table ...]
>>>           take_lock(driver->update);
>>>           if (mmu_interval_read_retry(&ni, range.notifier_seq) {
>>>               release_lock(driver->update);
>>>               goto again;
>>>           }
>>>
>>>           /* Use pfns array content to update device page table,
>>>            * under the update lock */
>>>
>>>           release_lock(driver->update);
>>>           return 0;
>>>      }
>>>
>>>    The driver->update lock is the same lock that the driver takes
>>>    inside its
>>>    invalidate() callback. That lock must be held before calling
>>>    mmu_interval_read_retry() to avoid any race with a concurrent CPU
>>>    page table
>>>    update.
>>
>>
>> There is something massively missing here since that won't work at all.
>>
>> The problem is that we can't allocate memory nor fault pages while 
>> any lock is held which is also held inside the invalidation callback 
>> of the MMU notifier.
>>
>> Updating the PTEs will always need memory, e.g. we can't guarantee 
>> that we won't allocate page tables. Otherwise dynamic allocating 
>> tables won't work any more.
>>
>>>>
>>>> That's why the same page fault can occur multiple times until the 
>>>> page tables are up to date.
>>>>
>>>> When you get an MMU notification that range A->B is invalidated you 
>>>> trigger invalidation of range A->B inside the GPUVM address space 
>>>> as well and that's completely independent what's mapped there.
>>>
>>> Not exactly. Because we're in a shared virtual address space, we 
>>> know exactly what's mapped there.
>>
>> Yeah, but that's irrelevant. We are not allowed to use this 
>> information, cause otherwise we run exactly into the described issues 
>> again.
>>
>>> If the MMU notifier invalidates it, we have to coordinate with it to 
>>> make sure we don't write incorrect addresses into those PTEs. In the 
>>> example above, holding the lock guarantees that a concurrent MMU 
>>> notifier will not return until after it has overwritten the PTEs we 
>>> just updated. Alternatively mmu_interval_read_retry fails, which 
>>> means the MMU notifier got there first and we have to get updated 
>>> addresses with hmm_range_fault. Either way, the page table ends up 
>>> with PTEs with V=0 before the MMU notifier returns.
>>>
>>> Without holding the lock while writing the page table, we could end 
>>> up with a mix of valid (V=1, but outdated address) and invalid PTEs 
>>> when there is a concurrent validation and invalidation of the same 
>>> virtual address range.
>>
>> Yeah, I see the problem now as well. But I can't come up with any way 
>> to solve this.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Invalidating the mappings and eventually scheduling that they are 
>>>> re-created is a separate step which should come independent of this 
>>>> if I'm not completely mistaken.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 06.12.22 um 01:04 schrieb Felix Kuehling:
>>>>> We fixed a similar issue with Philip's patch "drm/amdgpu: Drop 
>>>>> eviction lock when allocating PT BO", but there was another one 
>>>>> hiding underneath that (see the log below). The problem is, that 
>>>>> we're still allocating page tables while holding the prange->lock 
>>>>> in the kfd_svm code, which is also held in MMU notifiers. This 
>>>>> creates a lock dependency between the vram_mgr->lock and fs-reclaim.
>>>>>
>>>>> There are three ways around this:
>>>>>
>>>>>  * Do the page table mapping outside prange->lock (creates a race,
>>>>>    contradicts advice in Documentation/vm/hmm.rst)
>>>>>  * Avoid all page table allocation in amdgpu_vm_update_range (i.e.
>>>>>    allocate page tables ahead of time somehow)
>>>>>  * Wrap vram_mgr->lock with memalloc_noreclaim_save/restore (may 
>>>>> cause
>>>>>    memory allocations to fail in drm_buddy under memory pressure)
>>>>>
>>>>> I only mention the first one for completeness. It's not a valid 
>>>>> solution. Neither of the remaining two options are particularly 
>>>>> appealing either.
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>> [   83.979486] ======================================================
>>>>> [   83.986583] WARNING: possible circular locking dependency detected
>>>>> [   83.993643] 5.19.0-kfd-fkuehlin #75 Not tainted
>>>>> [   83.999044] ------------------------------------------------------
>>>>> [   84.006088] kfdtest/3453 is trying to acquire lock:
>>>>> [   84.011820] ffff9a998561e210 (&prange->lock){+.+.}-{3:3}, at: 
>>>>> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>>> [   84.023911]
>>>>>                but task is already holding lock:
>>>>> [   84.031608] ffffffffbcd929c0 
>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>>>> unmap_vmas+0x5/0x170
>>>>> [   84.041992]
>>>>>                which lock already depends on the new lock.
>>>>>
>>>>> [   84.052785]
>>>>>                the existing dependency chain (in reverse order) is:
>>>>> [   84.061993]
>>>>>                -> #3 
>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
>>>>> [   84.071548]        fs_reclaim_acquire+0x6d/0xd0
>>>>> [   84.076941]        kmem_cache_alloc_trace+0x34/0x760
>>>>> [   84.082766]        alloc_workqueue_attrs+0x1b/0x50
>>>>> [   84.088411]        workqueue_init+0x88/0x318
>>>>> [   84.093533]        kernel_init_freeable+0x134/0x28f
>>>>> [   84.099258]        kernel_init+0x16/0x130
>>>>> [   84.104107]        ret_from_fork+0x1f/0x30
>>>>> [   84.109038]
>>>>>                -> #2 (fs_reclaim){+.+.}-{0:0}:
>>>>> [   84.116348]        fs_reclaim_acquire+0xa1/0xd0
>>>>> [   84.121697]        kmem_cache_alloc+0x2c/0x760
>>>>> [   84.126948]        drm_block_alloc.isra.0+0x27/0x50 [drm_buddy]
>>>>> [   84.133679]        split_block+0x4d/0x140 [drm_buddy]
>>>>> [   84.139539]        drm_buddy_alloc_blocks+0x385/0x580 [drm_buddy]
>>>>> [   84.146435]        amdgpu_vram_mgr_new+0x213/0x4f0 [amdgpu]
>>>>> [   84.153399]        ttm_resource_alloc+0x31/0x80 [ttm]
>>>>> [   84.159366]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>>>> [   84.165169]        ttm_bo_validate+0xc5/0x170 [ttm]
>>>>> [   84.170872]        ttm_bo_init_reserved+0x1a6/0x230 [ttm]
>>>>> [   84.177075]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>>>> [   84.183600] amdgpu_bo_create_reserved+0x188/0x1e0 [amdgpu]
>>>>> [   84.190803] amdgpu_bo_create_kernel_at+0x64/0x200 [amdgpu]
>>>>> [   84.197994]        amdgpu_ttm_init+0x420/0x4c0 [amdgpu]
>>>>> [   84.204301]        gmc_v10_0_sw_init+0x33a/0x530 [amdgpu]
>>>>> [   84.210813] amdgpu_device_init.cold+0x10d4/0x17a1 [amdgpu]
>>>>> [   84.218077]        amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>>>>> [   84.224919]        amdgpu_pci_probe+0x142/0x350 [amdgpu]
>>>>> [   84.231313]        local_pci_probe+0x40/0x80
>>>>> [   84.236437]        work_for_cpu_fn+0x10/0x20
>>>>> [   84.241500]        process_one_work+0x270/0x5a0
>>>>> [   84.246805]        worker_thread+0x203/0x3c0
>>>>> [   84.251828]        kthread+0xea/0x110
>>>>> [   84.256229]        ret_from_fork+0x1f/0x30
>>>>> [   84.261061]
>>>>>                -> #1 (&mgr->lock){+.+.}-{3:3}:
>>>>> [   84.268156]        __mutex_lock+0x9a/0xf30
>>>>> [   84.272967]        amdgpu_vram_mgr_new+0x14a/0x4f0 [amdgpu]
>>>>> [   84.279752]        ttm_resource_alloc+0x31/0x80 [ttm]
>>>>> [   84.285602]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>>>> [   84.291321]        ttm_bo_validate+0xc5/0x170 [ttm]
>>>>> [   84.296939]        ttm_bo_init_reserved+0xe2/0x230 [ttm]
>>>>> [   84.302969]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>>>> [   84.309297]        amdgpu_bo_create_vm+0x2e/0x80 [amdgpu]
>>>>> [   84.315656]        amdgpu_vm_pt_create+0xf5/0x270 [amdgpu]
>>>>> [   84.322090]        amdgpu_vm_ptes_update+0x6c4/0x8f0 [amdgpu]
>>>>> [   84.328793]        amdgpu_vm_update_range+0x29b/0x730 [amdgpu]
>>>>> [   84.335537] svm_range_validate_and_map+0xc78/0x1390 [amdgpu]
>>>>> [   84.342734]        svm_range_set_attr+0xc74/0x1170 [amdgpu]
>>>>> [   84.349222]        kfd_ioctl+0x189/0x5c0 [amdgpu]
>>>>> [   84.354808]        __x64_sys_ioctl+0x80/0xb0
>>>>> [   84.359738]        do_syscall_64+0x35/0x80
>>>>> [   84.364481] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>> [   84.370687]
>>>>>                -> #0 (&prange->lock){+.+.}-{3:3}:
>>>>> [   84.377864]        __lock_acquire+0x12ed/0x27e0
>>>>> [   84.383027]        lock_acquire+0xca/0x2e0
>>>>> [   84.387759]        __mutex_lock+0x9a/0xf30
>>>>> [   84.392491] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>> [amdgpu]
>>>>> [   84.400345] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>>> [   84.407410]        unmap_vmas+0x162/0x170
>>>>> [   84.412126]        unmap_region+0xa8/0x110
>>>>> [   84.416905]        __do_munmap+0x209/0x4f0
>>>>> [   84.421680]        __vm_munmap+0x78/0x120
>>>>> [   84.426365]        __x64_sys_munmap+0x17/0x20
>>>>> [   84.431392]        do_syscall_64+0x35/0x80
>>>>> [   84.436164] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>> [   84.442405]
>>>>>                other info that might help us debug this:
>>>>>
>>>>> [   84.452431] Chain exists of:
>>>>>                  &prange->lock --> fs_reclaim --> 
>>>>> mmu_notifier_invalidate_range_start
>>>>>
>>>>> [   84.466395]  Possible unsafe locking scenario:
>>>>>
>>>>> [   84.473720]        CPU0                    CPU1
>>>>> [   84.479020]        ----                    ----
>>>>> [   84.484296] lock(mmu_notifier_invalidate_range_start);
>>>>> [   84.490333] lock(fs_reclaim);
>>>>> [   84.496705] lock(mmu_notifier_invalidate_range_start);
>>>>> [   84.505246]   lock(&prange->lock);
>>>>> [   84.509361]
>>>>>                 *** DEADLOCK ***
>>>>>
>>>>> [   84.517360] 2 locks held by kfdtest/3453:
>>>>> [   84.522060]  #0: ffff9a99821ec4a8 
>>>>> (&mm->mmap_lock#2){++++}-{3:3}, at: __do_munmap+0x417/0x4f0
>>>>> [   84.531287]  #1: ffffffffbcd929c0 
>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>>>> unmap_vmas+0x5/0x170
>>>>> [   84.541896]
>>>>>                stack backtrace:
>>>>> [   84.547630] CPU: 3 PID: 3453 Comm: kfdtest Not tainted 
>>>>> 5.19.0-kfd-fkuehlin #75
>>>>> [   84.555537] Hardware name: To Be Filled By O.E.M. To Be Filled 
>>>>> By O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
>>>>> [   84.565788] Call Trace:
>>>>> [   84.568925]  <TASK>
>>>>> [   84.571702]  dump_stack_lvl+0x45/0x59
>>>>> [   84.576034]  check_noncircular+0xfe/0x110
>>>>> [   84.580715]  ? kernel_text_address+0x6d/0xe0
>>>>> [   84.585652]  __lock_acquire+0x12ed/0x27e0
>>>>> [   84.590340]  lock_acquire+0xca/0x2e0
>>>>> [   84.594595]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>> [amdgpu]
>>>>> [   84.602338]  __mutex_lock+0x9a/0xf30
>>>>> [   84.606714]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>> [amdgpu]
>>>>> [   84.614262]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>> [amdgpu]
>>>>> [   84.621806]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>> [amdgpu]
>>>>> [   84.629353] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>> [amdgpu]
>>>>> [   84.636742]  ? lock_release+0x139/0x2b0
>>>>> [   84.641374] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>>> [   84.647976]  unmap_vmas+0x162/0x170
>>>>> [   84.652203]  unmap_region+0xa8/0x110
>>>>> [   84.656503]  __do_munmap+0x209/0x4f0
>>>>> [   84.660792]  __vm_munmap+0x78/0x120
>>>>> [   84.664977]  __x64_sys_munmap+0x17/0x20
>>>>> [   84.669499]  do_syscall_64+0x35/0x80
>>>>> [   84.673755]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>> [   84.679485] RIP: 0033:0x7f32872eb97b
>>>>> [   84.683738] Code: 8b 15 19 35 0d 00 f7 d8 64 89 02 48 c7 c0 ff 
>>>>> ff ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 
>>>>> 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 34 0d 00 
>>>>> f7 d8 64 89 01 48
>>>>> [   84.703915] RSP: 002b:00007fffb06c4508 EFLAGS: 00000246 
>>>>> ORIG_RAX: 000000000000000b
>>>>> [   84.712205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
>>>>> 00007f32872eb97b
>>>>> [   84.720072] RDX: 0000000004000000 RSI: 0000000004000000 RDI: 
>>>>> 00007f32831ae000
>>>>> [   84.727944] RBP: 00007fffb06c4750 R08: 00007fffb06c4548 R09: 
>>>>> 000055e7570ad230
>>>>> [   84.735809] R10: 000055e757088010 R11: 0000000000000246 R12: 
>>>>> 000055e75453cefa
>>>>> [   84.743688] R13: 0000000000000000 R14: 0000000000000021 R15: 
>>>>> 0000000000000000
>>>>> [   84.751584]  </TASK>
>>>>>
>>>>>
>>>>
>>
>
