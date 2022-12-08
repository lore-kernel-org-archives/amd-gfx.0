Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5769EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 12:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34AB910E1FB;
	Thu,  8 Dec 2022 12:32:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7239110E1FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 12:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJpqA+BiAGn4wgAS9pUfkGZO3hbrK6UeDFx4icBUyVBjMufEVtk8CmSbEHUkzAbTMHTxhoUOdrP798rJKdf7JMZCVrlQLipR1+2ZwM1//48T/lci/yu7t1J14+Rwe3mGIG40XXOtLZXSYcEYBMCjfftGaxnWaHqTdZsqggFINUXbPSNGDDE58GRMBjRZ6C9M+thHTs/kn/g1v1a+3YguVQhoQk56qXx4fgMwZ+JTA98l8tL6VS+8H2OS2CsMX2MUdnwsn/w+5Czcwp6lKOVXgg853d0nWMgpMXTIzTbdeAOxrXYf6wxFU14zwV3X2FWijDBrvaOiVyKoFr3Nfl3WJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3EyAAVemEjf3tNrdEZQ54lBTcDqOor5SwAwDJ+8/t0=;
 b=a8OZcv88zOQFc0Q4yGH9XhPAXQXKgzsxzrnSYLO8BnJQsNBNsFrgiFMkj2BXX3m9ATY3KduaGMuio5bqNBqkp65XPrC9RH3ejZe4ZTqwNgzBpD/EJlvDBM9lXMVca3BQZJdJGuZDiTXCYW/eDfDUXiz+n3hCszkbdU6vn+kIQ/wU8Ef5WKF3iznY/K+OZ7Gs8794JJTyHwdQulvZRpB5MBHpApjqWsqwakM0AX6ASUlyNFKznQyWhSE103HKG0HJ6mF6ek5f3m1iJK0fzmw3mQLUZhbO4dlJM1kVQvmyvB2Oi0lVYxOeeUBJ0b9GADcBEiwHsFtp0PkdNYfd2j2bcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3EyAAVemEjf3tNrdEZQ54lBTcDqOor5SwAwDJ+8/t0=;
 b=XGAbzIhJ5zIZBNtg3FJGmfM6dtqNw4g9pAM55LHEa+M0bKP8nbhZtQZwRN8IzcLfMQP6qPq+jyKopNavY+pRJ0ZDs96e2rhaR1zChSPwHbRHotTaX08oXFw8Dx7UOrNMtD/Pe3YsQmx3U4Pi1jD92g22+EZPUref3fvrpH27Y1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Thu, 8 Dec
 2022 12:32:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 12:32:27 +0000
Message-ID: <917226e7-9e62-9cda-9f9b-eff4ce5a90c0@amd.com>
Date: Thu, 8 Dec 2022 13:32:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Another circular lock dependency involving fs-reclaim and
 drm_buddy
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <5fb7e577-e17e-c791-c107-2424b80ea853@amd.com>
 <eb075cb2-1649-e149-6f53-c86a30f9fffd@amd.com>
 <ee07b373-9de2-faac-320c-ee7b15048cd9@amd.com>
 <dd4979da-6abd-ba02-8840-d59b78a3020d@amd.com>
In-Reply-To: <dd4979da-6abd-ba02-8840-d59b78a3020d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: c7af0806-a4f3-4bc2-34dd-08dad9184425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZ2f6Gh591a3VTBqSTEOmYrTmTuAyo0Di9kOJ4MD4w7fYTY1VFtv4Hm8dNq6m/F0clLtCP+fOD9vJGcfWcQG6zF5XMLkeM6yOIe2ttP3cXtadFqA+9E1Iug4m3BzLLZj30HBiYS9Do7yS/qXp/9Z+YaewldiTm8fwJWrWDFY0SZbh1shmlZ8BzuCzkV1eU6Wj93QS+7/N7ADsiBzktbzztwiCnG7p/iJ+Bedj+OwIaeTbNE0ZL7JrV0xPrbgOknL5fgIyC8zLxIlQVvMUYaKb5zdIojvl0Me4HNw2VNdofN1TrtU+4dZWcac2ChAU66AVosDzNZ8FgJ0DGwZkVQoVmnL5XxtBO89M++EyC4NB3nA4wWtYwhUV3ocb3u+CyMH/ymYtoIEns3Mawml5fQ8cIzvv1p7IVvnRUORMcVU8tr/Bwj3q8s55gy2ZNzuXZO/Xzq7obJXF2T4sRmRek5qJUDGn7aSAnjxyE6Ft2hPK9SqGZot60mHy/TTLfHZJgdb4+3ZeLnAZRqRuRtV9YaWg7R3Bnf87YP3ItYgGybDowQnYDTDNxyk8CoQvyGSBDf7Bh8zzt70DSYkANc8+LM81YJ9U3Cbvb+QSYUwrJb5bYUsYjTTNQjHSdexXfNXxrht1Zk/beS3iqaMcpOISzTQMZT39le4zDIcOb+42FILK6rJApJAVM40PqBRTzlhwSZq918i0j6DZQsD7R3VycvLuJdI/4XedrV4VBjYQni5Dvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(6506007)(2616005)(83380400001)(66574015)(6486002)(36756003)(6666004)(478600001)(186003)(6512007)(31696002)(86362001)(38100700002)(8936002)(5660300002)(110136005)(31686004)(30864003)(316002)(41300700001)(2906002)(66946007)(66556008)(8676002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3hVdUVXamRIdU9hZjR4d2N2Yms3ZmpyQTduK2ZuUldVUEQwVWlDZDZvWk5F?=
 =?utf-8?B?OGY1RGNFZGtma0IvUTFGN1dFdTJENlhUM3ZjNk02ZW42QWlWUzkrbHdxeDJB?=
 =?utf-8?B?MWZCMGF4VUxwVkQwZ250SHVweUNGRmZBcTJzZkE0K2hGOHpiSVZoeUN0YTgv?=
 =?utf-8?B?eEowL2svSGZEaU1hS0tkQUZ6NFZQNUYveEc0MTBJSEptVFBGaGpGM1YzSXJY?=
 =?utf-8?B?dzV5L0RJTHMxV0xjMzQyb0tWQVZOTVAxK1pUbTFmWi9Gdit1cllSU1hDdTkr?=
 =?utf-8?B?SStOZXI5NTBIcmk2Z3Y4Y0V1QWlMZWwzVTNMc3hTVGJ3Q3BaNUFKa3huT09L?=
 =?utf-8?B?NTc2V0czbXZ5bUU4d2tmSzg4a3N3bVhZQ0VrUXVZZGdLS0sxTFV1dDZRcy9y?=
 =?utf-8?B?bFEzZmNraHZ6UXBwazQwNkNQRDNKenZDQVZleVd2T1lYdlBPandoMjQwVWdZ?=
 =?utf-8?B?UE5sWDJ1RCtGdzRQUWpCazFVVDZLYXJTQ3orRmhDanVsV3lHcEFySFFPelJ3?=
 =?utf-8?B?dEwzcE9wR3BIcURmb2lyMmFBQkV1Z0ZYc3dhdGVqbDgvWmEzK3duOU1YSzEz?=
 =?utf-8?B?dW9IUVp2NGVHVjg4WUxyL2JxK05pYnhPTTJYSXl6Q21xdDQyUEhRNS9kZXFp?=
 =?utf-8?B?RDhNYTRVNUNIYWhuRkl0YW9qaStJWiswTlFESHcwVTVNTkN1Y1NGd20rdzlL?=
 =?utf-8?B?a0J1L1piNW0yTi9IcGFuandWVlcrYjZLc3RoY0FITXRYQnQxQmFabWM1U1BY?=
 =?utf-8?B?cW9UWEtuc0pDTHplUnE5VXpUeGg4TnBOdjIrUzVEU0dRa3MwQUZSRmFNTzg2?=
 =?utf-8?B?OUtJRThHdWQzUHd4K0VNSG83QnZ4Sk9nTjRnUlhOd1BOR2NaUXM3UitwNThW?=
 =?utf-8?B?SGJHSE9mNVlMaGk4bHlKVnNCeitHMXpPcGNkQnBNMEk4bWpVV3h3elJaVTdu?=
 =?utf-8?B?My9zZnROOGpBRlFaY1IrQWg4VUFoSVM3WmE0bEg4T1czcUNGRnE3MVo5SUM3?=
 =?utf-8?B?VlAyK2dQZFk4WWRnMWVqd0hXSDJnaWk4d1FQMXJuekdKVW1tckhoZWpJQ3Vx?=
 =?utf-8?B?QjBkbDlnY1p1elBucU1aeGRMV3IxYTJaWE1tMWZISFlFclVyUzJuV2FORDBD?=
 =?utf-8?B?TVRzckR2RmdCZ0hYZEJ5WGMyZXRFa1NHMWsvMHg0TC9TR1FkaVZCSis0cUZ1?=
 =?utf-8?B?enhHdk9oaS91QkxMU1VXeENmK1dERmZIa1VjK1VLUm5leEJTVlNGcU14U3NL?=
 =?utf-8?B?a3VZeGNRbktGYmhqdW9jZlk4U3pkWnNraXRGeUZReFhzaDN3NS9pWEpybmx0?=
 =?utf-8?B?Q3RTRXRsQThleGJlZHR6cjFEcEJ1Nk1yN2g5VDJTanFuS2NFdGs4a2I5QUcx?=
 =?utf-8?B?clZxK20rY0d2ejBDS2tVQU04dHpydjlRMmFqM2ZRZEc0RlczTWQ3L1BPTVhy?=
 =?utf-8?B?Q2VsNzZnenJicmMxT1Z3L0dJNy9FdVZ2TzVWbW83THF5T1NtNEtudUVWRHVK?=
 =?utf-8?B?Mk9RSTIvdHY3NG9hT1FLZFdwVmxTOGZkVzl6NmxJVEdxd3NoaEVqdjQvb2RZ?=
 =?utf-8?B?ejg2UC9sUGx4MXpGNHlZeEt3cFp3dFptTlBGTGhYREM0dTVlZjZQSWZ2ZVY3?=
 =?utf-8?B?WlZKVk5WVFI0a2JvSkxEWWlFUUpUS3dDWmpvUXdORGl3RkxSWkdabG1sZ1lD?=
 =?utf-8?B?SnpxVUpGVkE1V0ozaUl1MnozbUtYNjRlbDJkKytVVDVyOWpIMWxqUkR4SVph?=
 =?utf-8?B?MU5LZk0rajlFSldMTDcvaE5aMXVmdDFESkdWTzFQSndKTndVRlFub2YxUXBV?=
 =?utf-8?B?YUhjSG9DRFFoT3U2WHRlTS9CenAvNzNDMkRqYVRPUldVSVJUQUQ4dzVpMUVO?=
 =?utf-8?B?L2JIZEtoNXNwM1hmRVlQSW9OYVd6TTVxY2lMUmJvL0J2dHhVQjRoYUtwMStG?=
 =?utf-8?B?VUJTNEhJc20rVjRITWxmY3NvL0xrS01BeEVCSVFkWmI0a21jQUhURjFhbE92?=
 =?utf-8?B?OE1LTVhGUUMzc216My9vejdXSHBsMHd0RTVvbm1nMlp2MTFSRy91UzBoMGhH?=
 =?utf-8?B?NnZxVUZKVkhrREJzd0UwUUozSGxBL3M3cFlXLzV4cnhlMi96VHM2eVRUZ3hH?=
 =?utf-8?B?L1hGc2E4TGwzWWw4K3AzQXAzZHZsZmpOLzRHdU5HdVB6Q1dkdFpaK2RKWWRB?=
 =?utf-8?Q?vJRULJ5jjDXRVXxkgDCElHk4OtBWzdEhEI8s9XJnnKpQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7af0806-a4f3-4bc2-34dd-08dad9184425
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 12:32:27.3952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Q2eBvhbYjsG+9fzNazTJyK9XBbPy3xEROyE/mIUBTglSiFbvgApjsLiVyRLo260
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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

Hi Felix,

digging though the code I think I know now how we can solve this.

The lock which needs to protect the validity of the pages is the 
vm->eviction_lock, cause this one is what serializes the updates of our 
page table.

This means that the amdgpu_vm_update_range() function needs to be 
extended further with enough information to check the HMM sequence after 
grabbing the eviction lock.

Or am I missing something here?

Regards,
Christian.

Am 06.12.22 um 16:57 schrieb Christian König:
> Am 06.12.22 um 16:14 schrieb Felix Kuehling:
>> Am 2022-12-06 um 03:20 schrieb Christian König:
>>> Hi Felix,
>>>
>>> to be honest I think the whole approach you take here and unmapping 
>>> the range with the lock held is highly problematic.
>>>
>>> Essentially unmapping is something which can run concurrently with 
>>> other operations and should never be blocked by such a lock. In 
>>> other words it is perfectly valid for an unmap to run while another 
>>> processor tries to map the same range.
>>
>> I strongly disagree. When an MMU notifier invalidates a virtual 
>> address range, it must guarantee that the device will not access the 
>> current physical location of the invalidated range any more. Without 
>> the lock, another processor could easily overwrite the invalidated 
>> PTEs with valid (but outdated) addresses that the MMU notifier just 
>> removed.
>>
>> This is the relevant paragraph in the HMM doc:
>>
>>    [example of driver updating its page table ...]
>>           take_lock(driver->update);
>>           if (mmu_interval_read_retry(&ni, range.notifier_seq) {
>>               release_lock(driver->update);
>>               goto again;
>>           }
>>
>>           /* Use pfns array content to update device page table,
>>            * under the update lock */
>>
>>           release_lock(driver->update);
>>           return 0;
>>      }
>>
>>    The driver->update lock is the same lock that the driver takes
>>    inside its
>>    invalidate() callback. That lock must be held before calling
>>    mmu_interval_read_retry() to avoid any race with a concurrent CPU
>>    page table
>>    update.
>
>
> There is something massively missing here since that won't work at all.
>
> The problem is that we can't allocate memory nor fault pages while any 
> lock is held which is also held inside the invalidation callback of 
> the MMU notifier.
>
> Updating the PTEs will always need memory, e.g. we can't guarantee 
> that we won't allocate page tables. Otherwise dynamic allocating 
> tables won't work any more.
>
>>>
>>> That's why the same page fault can occur multiple times until the 
>>> page tables are up to date.
>>>
>>> When you get an MMU notification that range A->B is invalidated you 
>>> trigger invalidation of range A->B inside the GPUVM address space as 
>>> well and that's completely independent what's mapped there.
>>
>> Not exactly. Because we're in a shared virtual address space, we know 
>> exactly what's mapped there.
>
> Yeah, but that's irrelevant. We are not allowed to use this 
> information, cause otherwise we run exactly into the described issues 
> again.
>
>> If the MMU notifier invalidates it, we have to coordinate with it to 
>> make sure we don't write incorrect addresses into those PTEs. In the 
>> example above, holding the lock guarantees that a concurrent MMU 
>> notifier will not return until after it has overwritten the PTEs we 
>> just updated. Alternatively mmu_interval_read_retry fails, which 
>> means the MMU notifier got there first and we have to get updated 
>> addresses with hmm_range_fault. Either way, the page table ends up 
>> with PTEs with V=0 before the MMU notifier returns.
>>
>> Without holding the lock while writing the page table, we could end 
>> up with a mix of valid (V=1, but outdated address) and invalid PTEs 
>> when there is a concurrent validation and invalidation of the same 
>> virtual address range.
>
> Yeah, I see the problem now as well. But I can't come up with any way 
> to solve this.
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
>>> Invalidating the mappings and eventually scheduling that they are 
>>> re-created is a separate step which should come independent of this 
>>> if I'm not completely mistaken.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 06.12.22 um 01:04 schrieb Felix Kuehling:
>>>> We fixed a similar issue with Philip's patch "drm/amdgpu: Drop 
>>>> eviction lock when allocating PT BO", but there was another one 
>>>> hiding underneath that (see the log below). The problem is, that 
>>>> we're still allocating page tables while holding the prange->lock 
>>>> in the kfd_svm code, which is also held in MMU notifiers. This 
>>>> creates a lock dependency between the vram_mgr->lock and fs-reclaim.
>>>>
>>>> There are three ways around this:
>>>>
>>>>  * Do the page table mapping outside prange->lock (creates a race,
>>>>    contradicts advice in Documentation/vm/hmm.rst)
>>>>  * Avoid all page table allocation in amdgpu_vm_update_range (i.e.
>>>>    allocate page tables ahead of time somehow)
>>>>  * Wrap vram_mgr->lock with memalloc_noreclaim_save/restore (may cause
>>>>    memory allocations to fail in drm_buddy under memory pressure)
>>>>
>>>> I only mention the first one for completeness. It's not a valid 
>>>> solution. Neither of the remaining two options are particularly 
>>>> appealing either.
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>> [   83.979486] ======================================================
>>>> [   83.986583] WARNING: possible circular locking dependency detected
>>>> [   83.993643] 5.19.0-kfd-fkuehlin #75 Not tainted
>>>> [   83.999044] ------------------------------------------------------
>>>> [   84.006088] kfdtest/3453 is trying to acquire lock:
>>>> [   84.011820] ffff9a998561e210 (&prange->lock){+.+.}-{3:3}, at: 
>>>> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>> [   84.023911]
>>>>                but task is already holding lock:
>>>> [   84.031608] ffffffffbcd929c0 
>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>>> unmap_vmas+0x5/0x170
>>>> [   84.041992]
>>>>                which lock already depends on the new lock.
>>>>
>>>> [   84.052785]
>>>>                the existing dependency chain (in reverse order) is:
>>>> [   84.061993]
>>>>                -> #3 
>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
>>>> [   84.071548]        fs_reclaim_acquire+0x6d/0xd0
>>>> [   84.076941]        kmem_cache_alloc_trace+0x34/0x760
>>>> [   84.082766]        alloc_workqueue_attrs+0x1b/0x50
>>>> [   84.088411]        workqueue_init+0x88/0x318
>>>> [   84.093533]        kernel_init_freeable+0x134/0x28f
>>>> [   84.099258]        kernel_init+0x16/0x130
>>>> [   84.104107]        ret_from_fork+0x1f/0x30
>>>> [   84.109038]
>>>>                -> #2 (fs_reclaim){+.+.}-{0:0}:
>>>> [   84.116348]        fs_reclaim_acquire+0xa1/0xd0
>>>> [   84.121697]        kmem_cache_alloc+0x2c/0x760
>>>> [   84.126948]        drm_block_alloc.isra.0+0x27/0x50 [drm_buddy]
>>>> [   84.133679]        split_block+0x4d/0x140 [drm_buddy]
>>>> [   84.139539]        drm_buddy_alloc_blocks+0x385/0x580 [drm_buddy]
>>>> [   84.146435]        amdgpu_vram_mgr_new+0x213/0x4f0 [amdgpu]
>>>> [   84.153399]        ttm_resource_alloc+0x31/0x80 [ttm]
>>>> [   84.159366]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>>> [   84.165169]        ttm_bo_validate+0xc5/0x170 [ttm]
>>>> [   84.170872]        ttm_bo_init_reserved+0x1a6/0x230 [ttm]
>>>> [   84.177075]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>>> [   84.183600]        amdgpu_bo_create_reserved+0x188/0x1e0 [amdgpu]
>>>> [   84.190803]        amdgpu_bo_create_kernel_at+0x64/0x200 [amdgpu]
>>>> [   84.197994]        amdgpu_ttm_init+0x420/0x4c0 [amdgpu]
>>>> [   84.204301]        gmc_v10_0_sw_init+0x33a/0x530 [amdgpu]
>>>> [   84.210813]        amdgpu_device_init.cold+0x10d4/0x17a1 [amdgpu]
>>>> [   84.218077]        amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>>>> [   84.224919]        amdgpu_pci_probe+0x142/0x350 [amdgpu]
>>>> [   84.231313]        local_pci_probe+0x40/0x80
>>>> [   84.236437]        work_for_cpu_fn+0x10/0x20
>>>> [   84.241500]        process_one_work+0x270/0x5a0
>>>> [   84.246805]        worker_thread+0x203/0x3c0
>>>> [   84.251828]        kthread+0xea/0x110
>>>> [   84.256229]        ret_from_fork+0x1f/0x30
>>>> [   84.261061]
>>>>                -> #1 (&mgr->lock){+.+.}-{3:3}:
>>>> [   84.268156]        __mutex_lock+0x9a/0xf30
>>>> [   84.272967]        amdgpu_vram_mgr_new+0x14a/0x4f0 [amdgpu]
>>>> [   84.279752]        ttm_resource_alloc+0x31/0x80 [ttm]
>>>> [   84.285602]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>>> [   84.291321]        ttm_bo_validate+0xc5/0x170 [ttm]
>>>> [   84.296939]        ttm_bo_init_reserved+0xe2/0x230 [ttm]
>>>> [   84.302969]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>>> [   84.309297]        amdgpu_bo_create_vm+0x2e/0x80 [amdgpu]
>>>> [   84.315656]        amdgpu_vm_pt_create+0xf5/0x270 [amdgpu]
>>>> [   84.322090]        amdgpu_vm_ptes_update+0x6c4/0x8f0 [amdgpu]
>>>> [   84.328793]        amdgpu_vm_update_range+0x29b/0x730 [amdgpu]
>>>> [   84.335537] svm_range_validate_and_map+0xc78/0x1390 [amdgpu]
>>>> [   84.342734]        svm_range_set_attr+0xc74/0x1170 [amdgpu]
>>>> [   84.349222]        kfd_ioctl+0x189/0x5c0 [amdgpu]
>>>> [   84.354808]        __x64_sys_ioctl+0x80/0xb0
>>>> [   84.359738]        do_syscall_64+0x35/0x80
>>>> [   84.364481] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>> [   84.370687]
>>>>                -> #0 (&prange->lock){+.+.}-{3:3}:
>>>> [   84.377864]        __lock_acquire+0x12ed/0x27e0
>>>> [   84.383027]        lock_acquire+0xca/0x2e0
>>>> [   84.387759]        __mutex_lock+0x9a/0xf30
>>>> [   84.392491] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>> [   84.400345] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>> [   84.407410]        unmap_vmas+0x162/0x170
>>>> [   84.412126]        unmap_region+0xa8/0x110
>>>> [   84.416905]        __do_munmap+0x209/0x4f0
>>>> [   84.421680]        __vm_munmap+0x78/0x120
>>>> [   84.426365]        __x64_sys_munmap+0x17/0x20
>>>> [   84.431392]        do_syscall_64+0x35/0x80
>>>> [   84.436164] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>> [   84.442405]
>>>>                other info that might help us debug this:
>>>>
>>>> [   84.452431] Chain exists of:
>>>>                  &prange->lock --> fs_reclaim --> 
>>>> mmu_notifier_invalidate_range_start
>>>>
>>>> [   84.466395]  Possible unsafe locking scenario:
>>>>
>>>> [   84.473720]        CPU0                    CPU1
>>>> [   84.479020]        ----                    ----
>>>> [   84.484296]   lock(mmu_notifier_invalidate_range_start);
>>>> [   84.490333] lock(fs_reclaim);
>>>> [   84.496705] lock(mmu_notifier_invalidate_range_start);
>>>> [   84.505246]   lock(&prange->lock);
>>>> [   84.509361]
>>>>                 *** DEADLOCK ***
>>>>
>>>> [   84.517360] 2 locks held by kfdtest/3453:
>>>> [   84.522060]  #0: ffff9a99821ec4a8 
>>>> (&mm->mmap_lock#2){++++}-{3:3}, at: __do_munmap+0x417/0x4f0
>>>> [   84.531287]  #1: ffffffffbcd929c0 
>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>>> unmap_vmas+0x5/0x170
>>>> [   84.541896]
>>>>                stack backtrace:
>>>> [   84.547630] CPU: 3 PID: 3453 Comm: kfdtest Not tainted 
>>>> 5.19.0-kfd-fkuehlin #75
>>>> [   84.555537] Hardware name: To Be Filled By O.E.M. To Be Filled 
>>>> By O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
>>>> [   84.565788] Call Trace:
>>>> [   84.568925]  <TASK>
>>>> [   84.571702]  dump_stack_lvl+0x45/0x59
>>>> [   84.576034]  check_noncircular+0xfe/0x110
>>>> [   84.580715]  ? kernel_text_address+0x6d/0xe0
>>>> [   84.585652]  __lock_acquire+0x12ed/0x27e0
>>>> [   84.590340]  lock_acquire+0xca/0x2e0
>>>> [   84.594595]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>> [amdgpu]
>>>> [   84.602338]  __mutex_lock+0x9a/0xf30
>>>> [   84.606714]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>> [amdgpu]
>>>> [   84.614262]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>> [amdgpu]
>>>> [   84.621806]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>> [amdgpu]
>>>> [   84.629353] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>> [   84.636742]  ? lock_release+0x139/0x2b0
>>>> [   84.641374] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>> [   84.647976]  unmap_vmas+0x162/0x170
>>>> [   84.652203]  unmap_region+0xa8/0x110
>>>> [   84.656503]  __do_munmap+0x209/0x4f0
>>>> [   84.660792]  __vm_munmap+0x78/0x120
>>>> [   84.664977]  __x64_sys_munmap+0x17/0x20
>>>> [   84.669499]  do_syscall_64+0x35/0x80
>>>> [   84.673755]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>> [   84.679485] RIP: 0033:0x7f32872eb97b
>>>> [   84.683738] Code: 8b 15 19 35 0d 00 f7 d8 64 89 02 48 c7 c0 ff 
>>>> ff ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 
>>>> 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 34 0d 00 f7 
>>>> d8 64 89 01 48
>>>> [   84.703915] RSP: 002b:00007fffb06c4508 EFLAGS: 00000246 
>>>> ORIG_RAX: 000000000000000b
>>>> [   84.712205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
>>>> 00007f32872eb97b
>>>> [   84.720072] RDX: 0000000004000000 RSI: 0000000004000000 RDI: 
>>>> 00007f32831ae000
>>>> [   84.727944] RBP: 00007fffb06c4750 R08: 00007fffb06c4548 R09: 
>>>> 000055e7570ad230
>>>> [   84.735809] R10: 000055e757088010 R11: 0000000000000246 R12: 
>>>> 000055e75453cefa
>>>> [   84.743688] R13: 0000000000000000 R14: 0000000000000021 R15: 
>>>> 0000000000000000
>>>> [   84.751584]  </TASK>
>>>>
>>>>
>>>
>

