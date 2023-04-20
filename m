Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A0BC77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 05:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8398A10E21D;
	Thu, 20 Apr 2023 05:29:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B824C10E21D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 05:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/GMs9l+FR48UdWFc3GYcXJtuPze3qBddjcRnDld2jsPvUywhrq/z+BdRc99gZmwwLoilACmUd+e9lb9m0tgU5UF8agZvLbLeDSTAElXps/d9HG816jeKhmN/8jZhIdRK9ZnAOh/WNoHpEOoiAHgavkh0s6ecftNNo5SqTruBI9q4TJrJjnfzDn8lkxYfq6lXg7kWqaatdSDrkWctkovWwTxc6kysdMxHtdEhjvM5NyDJqY7l2h21V3zOk8hbQbSuLSVSsTlCC+8DBzDhFdKNCYJOEGJ+Vb0+8YSwjfg3N1wuDzcfWGTOpODdBVXHIs6zXKiDoitpK5u46Z6gco+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uKobevo0Tmc/WY7fqTWEeYfr/DVK6LwqwPQY7Cmfss=;
 b=cLRZ5K6rBPSBt/WicsSvMyEUDaRGIXdQxXHvU78THvzJa55EbXTQmHUQoNL2bwCPe/hREYfE9N3u8lY3ztSU/RizoQZ0NGb5ElsM6Qx+WxWMPoDPTJ2jrOS3R1MyZimhxfEizV8qxRPGpCcGIHaZ0u74r/Y7NPkp/zC4Uw+XYVoCZMolExk+GV17Np4B4suX20rNJog6fStzKze1gqo0ixtJDmW48l8QfOeGqfR2891FpEX4tejNxs/51ef5un8BBNwQiV1WUvSXtpCviNyFLdvDawsY9DaIGBlcYwPWuQXmXFByJFq2zNNAeFLjcVOLqXEuXpQdvNjJ2ULeaSehTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uKobevo0Tmc/WY7fqTWEeYfr/DVK6LwqwPQY7Cmfss=;
 b=mlhl3a9l0c0yRnfhyMcLrEUA1DRcAUdZYBRhHCDjFXWD3fsGlWlDxQKDvwt51Ry8djQb03JGw6VvgrP0RmDs1LRxCLPQbvEOSHdcHnU/QMRjVsyeKJubJu2Hg057USUlHpNwtT0Z+NdEWb1SFGrjKOC0Ovu9oHGBKdt5HWDNkbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20; Thu, 20 Apr 2023 05:29:52 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c3:83f1:333c:fc17]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c3:83f1:333c:fc17%5]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 05:29:52 +0000
Message-ID: <54fc29c8-f722-dc4e-2484-477fec4d2204@amd.com>
Date: Thu, 20 Apr 2023 00:28:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Fix some issues at userptr buffer validation
 process.
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412061432.207610-1-xiaogang.chen@amd.com>
 <aa76e51f-8343-a1d0-a4a9-8f1329288535@amd.com>
 <da29b4b9-0c7a-21ca-a050-007f4c7ce203@amd.com>
 <76d79bab-6015-989b-55e0-4e9bb6c7d160@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <76d79bab-6015-989b-55e0-4e9bb6c7d160@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::9) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 80126104-2151-44d7-b912-08db4160445f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6tadqoWJhOBOsnVZGPhKoFpSCfyBEPEn0kgoFBjXPzq/BFWFpJ8SxIRPuQowGBBjzzqPo4AMwkoIX0QHdlotzESS2JJRjfJp0cYa9G0ke04OF8BUV0Am6a1qSSnOb8p3Y/J15ONStq/UJ5UFxYehD17enWVoti83UV5x2cka0NZ31IDFNI+UbwXdP9loixnuu597XCjf70fn9c9P/GNvurk/VDeH24EobZ9LM+mfgrl3NEV2tD0iJXGOrH9gQLpBh7ImQB4W1LKjXmyWO/UZfnwb6RhCp3jz5mHsuRMLanTlCjqKKAn/cS9dcjwoDu5tNS3Ix11Xcv6sgSPtjrnaCNVRePjAGp3V4zDctpIfRL2GyG6Ts0DI8ExGyblqdpvp9fI8h3KEQvutNeBpcnNkBo8ZuyWUh/rMldZ870qjMwsYc/ZSMZ8BRqZcd7wvELFe9bb7nbnxjbZkkpkRwGAxJPSAzXQaTSCt5ysVJiDaOj8bONbnPNnZ1Nulv/0osuMpsW8KmqRyS0U1FwLpAJt1qWnBT1bTgTH8FgPLyYb2EOOBgvkWTWLBC0shMsx0TLkbJZsuVtK+wWe4T0oOChbFFzWoVJE+hUiGLEa5nuhEqVCvexW+3WNGoHiV04KbQM/lnZhbiNjYmtVfNIYihALXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(31686004)(316002)(66556008)(66476007)(66946007)(36756003)(186003)(53546011)(6506007)(6512007)(38100700002)(2616005)(83380400001)(31696002)(5660300002)(41300700001)(8676002)(6666004)(8936002)(478600001)(6486002)(86362001)(2906002)(30864003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEp5MCszejZIcVFDTFg3U1FsVU1iOVFwbisrdGpQQ3AxNVQxU1U3ckV5Qkxi?=
 =?utf-8?B?cFhPSnRteFRHWkdHaG1YYUthazluaHFTczhLMVVxS0ZuYjNPS2ZCQkdiWnkr?=
 =?utf-8?B?V0hnZkJ1Qk5kNnhqazNBTHgrbFpaY0dyZGE4djN6WWtnSjROR3UzeG9HY1RV?=
 =?utf-8?B?TDZVMVlYaXZRbmtvWHZ3d0tDYVFXQXZ6OUxBcUlobEhZc2RWNDREeVBQYkxR?=
 =?utf-8?B?YkFkVDRUcllUc3JxMVZUUE5ucU12ZTVpNnhXcEVyYlVpUkEzRGJNZ1pSSWVw?=
 =?utf-8?B?aXNCWnBsQWtpQWNlMUw5cDJnQVBzb1JTQVVOcWpPSGJqaWRTOXJUZmV5MUU0?=
 =?utf-8?B?OCtuenRFcjdCY2JaQkYrYjdUcEtHSEM2VW43c2tJYno2SG5qMTEvYUVQeHFV?=
 =?utf-8?B?MFpKZ2RpazRYUWREQ1VSZDJacllRZ2dhZUlaeUV2aXVSSVBYcUZwLzRFUWdP?=
 =?utf-8?B?M0hiR20ybWFzRHBZYTNZeGY3dlFmZ1pJUVk3enA4SlNhNWsvYlprRW9zU1Qw?=
 =?utf-8?B?T000MFBSZ2pTbTF6Wm1qcGprM2dKS3VyOFdmLzREbFVPSHpxbmg0SXFDL3dT?=
 =?utf-8?B?RDRXQXhDR1BVRk14NFdMWjE5dDZocHVVY2VNd3FSc0Q3L3lLYkQ4bFZnYktv?=
 =?utf-8?B?T3AzOVVGTGZqOGVMMFRKT2JqVkdmZFlPRkZQdjZoN0tCUy9RaDJueWtodTJI?=
 =?utf-8?B?NWtzeGk4bnhSR3NhSEVzK2taK0RZMlhxUGUvUzlGMHpRY0ZOVzFtdkU5dWtB?=
 =?utf-8?B?bEh6dWlCQWhxN2JYMmdwbTMwZnY5K3JOclNyRU8zQXY3RnBreG9KSDNXbnlt?=
 =?utf-8?B?Z3hmaVFrbUdxMm5OdHc3M255NlM4NkRGL2NhTE9CQU10d1FkTEdPd0hIeEhR?=
 =?utf-8?B?c2swck93SENuMWJFNFkwL0V6Z0g4ZmpRK2JYOUdkUjhQZWp5QWtHbjI4L3ph?=
 =?utf-8?B?UmFkOXFSMGxuaXdaM2xBem9GWHhwL0xqVjZXajVweXZoVnVDSWM0YVA0SXND?=
 =?utf-8?B?ZldJMURwN0JiQzNsejFPZUZsejY1ZDlDL01Zanc3S1VDVFZ2bWhpb0lYaERz?=
 =?utf-8?B?ZlY2M2xGajNvcU1ZY0kzNHdYSmZxc1NvRitCS1M5bXd2ZmU1RFRnYWttY2lv?=
 =?utf-8?B?eEc3Z04ydTZxUXJoVmVhRkNCazhWL2lvNmx2VzR6c2V4WCtOZENDVWNJUy9Y?=
 =?utf-8?B?RWtIY0drNWw0cHMyaThxQmRaNkhtTXE1R01vbmFsMDVydjYwTEFjbWsvbEM5?=
 =?utf-8?B?U2h6R2oxNWhScTFoUTBIOEVISjdJbFp5N2EwNzZjZC92QS8rOFFldGFkbVBt?=
 =?utf-8?B?L1dubGpTUnN4ZWxsd3VhNUZrWGV2N05HYzNESE9mSjNIRHdMYmpGbFZFUE9q?=
 =?utf-8?B?ZUt0QlJjMUliOW04eDk1NjZSOG85b3BtbHU1WkthRVVndlI4Q3JUREtpM3lY?=
 =?utf-8?B?T2tUVjR6T0Ntd3RmQS83YTAyc1htdzRQVHo0bVpoTW1DZ0tqc05ZUGN3cCs4?=
 =?utf-8?B?OHdzdmNaTXMzUGJCbWpXb1NuU0k4OEJOU0Q4Ykw1QjRwTWMwQ29RWVpMM215?=
 =?utf-8?B?NlhLU0ZYdjJTU1AxQXdibmFtcEp0YlFrc21tOFlrSTNpalYxbExvNmRva1RS?=
 =?utf-8?B?ejFlb0lqSDdlaE1OZEVSam84MkNuSE40UVJHZi9Fa0FSTVZ3SDVlNHV6SC9T?=
 =?utf-8?B?UjlWYWVaWVpzSG5NK3FSVk5yVTBuWnhEU0VNY1FORzZPQUNZWC9lWVlFMnBa?=
 =?utf-8?B?MXBFK3M4eXFwY1VjTFpQQkUwYlNkT3pEQzQ5QlNNUjNGUmFoWlhjYnBOWXRB?=
 =?utf-8?B?Z2FpaFo1cTZLa3pnUU9iVDY0cExaZjZNMXhMN1VsbFh6aVVNelV3OFpCNlJI?=
 =?utf-8?B?eE93Y2dRMFB6c2I1d1lpclJ4TXlHaHFMS1R5U1BCZDZ6RUhlZDI3WHlvMDhx?=
 =?utf-8?B?OGJEWkVnL3JtdUljQXlhSUZuSTJac3VTc3NOUkhyUyt4UUkyWXNPTGtzVHU0?=
 =?utf-8?B?aitZblZoUERuQUxYNjNDa3M4djJkVnlqUmlxTnZ0WXpJM0NxRElkY29ZdnMx?=
 =?utf-8?B?d0ZETFRFUFlMS1lHSXBUOGJlUUZLUG9tMUFHOVFtbmlSRWcxbHIrZ1FkZFBh?=
 =?utf-8?B?REJ4Y3NobEN6K3A5TFNNU2xjQ20va3R5d2kxdENSR1g0SUh6YU9rYXpvbmt0?=
 =?utf-8?Q?PG6jTl+wFKbWvFJMVNVAMyw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80126104-2151-44d7-b912-08db4160445f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 05:29:52.6169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQy/8i2J69guXdHbBT0xMTEFh+9vMiYmNBswoEqibnVc5GF6PhZZbN3tRcn/Y5Hh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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


On 4/18/2023 6:17 PM, Felix Kuehling wrote:
>
> On 2023-04-13 23:27, Chen, Xiaogang wrote:
>>
>> On 4/13/2023 3:08 PM, Felix Kuehling wrote:
>>> Am 2023-04-12 um 02:14 schrieb Xiaogang.Chen:
>>>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>>>
>>>> Notice userptr buffer restore process has following issues:
>>>>
>>>> 1: amdgpu_ttm_tt_get_user_pages can fail(-EFAULT). If it failed we 
>>>> should not set
>>>> it valid(mem->invalid = 0). In this case mem has no associated hmm 
>>>> range or user_pages
>>>> associated.
>>>
>>> We don't want to suspend the process indefinitely when this happens. 
>>> This can happen if usermode calls munmap before unregistering the 
>>> userptr. What we want to happen in this case is, the process should 
>>> resume. If it accesses the virtual address, it will result in a page 
>>> fault, which alerts the application to its mistake. If it doesn't 
>>> access the virtual address, then there is no harm.
>>>
>>> It's a good catch that there is no useful hmm_range in this case to 
>>> check validity, so we should not warn about it in 
>>> confirm_valid_user_pages_locked.
>>>
>> Not sure why you said "suspend the process indefinitely". When 
>> mem(kgd_mem) has no hmm_range due to amdgpu_ttm_tt_get_user_pages 
>> fail the patch does not mark it valid( set mem->invalid != 0) and 
>> keep it at userptr_inval_list. The process has not been suspended.
>
> User mode queues are stopped. Until the queues are restarted, the 
> process is effectively suspended (for GPU execution). If invalid 
> userptr mappings cause restore to fail, that means, the GPU queues 
> will remain stopped. That's what I mean with "suspend the process 
> indefinitely".
>
>
My understanding your concern is that I have restore process reschedule 
itself indefinitely. At confirm_valid_user_pages_locked the real thing 
is if mem has hmm range associated. If it has and mem->invalid if true I 
will reschedule next attempt. If mem has no hmm range it will be kept at 
invalid list and not trigger reschedule.
>>
>> Yes, in this customer application case amdgpu_ttm_tt_get_user_pages 
>> failed at vma_lookup. I think it unmap its buffer before unregister 
>> from KFD. This patch handles amdgpu_ttm_tt_get_user_pages in general: 
>> not mark it valid(mem->invalid != 0), keep it at userptr_inval_list, 
>> then at confirm_valid_user_pages_locked, check if mem has hmm range 
>> associated before WARN.
>
> I think it would be easier to just mark it as valid. mem->invalid == 0 
> means, it's safe to resume the user mode queues. For userptrs without 
> a valid VMA this is the case as the corresponding page table entries 
> have been invalidated (V=0).
>
I have mem->invalid != 0 because it has no hmm range associated and stay 
at invalid list. I think that keep consistency with its status.
>
>>
>>>> 2: mmu notifier can happen concurrently and update 
>>>> mem->range->notifier->invalidate_seq,
>>>> but not mem->range->notifier_seq. That causes 
>>>> mem->range->notifier_seq stale
>>>> when mem is in process_info->userptr_inval_list and 
>>>> amdgpu_amdkfd_restore_userptr_worker
>>>> got interrupted. At next rescheduled next attempt we use stale 
>>>> mem->range->notifier_seq
>>>> to compare with mem->range->notifier->invalidate_seq.
>>>
>>> amdgpu_hmm_range_get_pages updates mem->range->notifier_seq with the 
>>> current mem->range->notifier->invalidate_seq. If an eviction happens 
>>> after this, there is a collision and the range needs to be 
>>> revalidated. I think when you say "mem->range->notifier_seq is 
>>> stale", it means there was a collision. When this happens, 
>>> mem->invalid should be set to true at the same time. So 
>>> confirm_valid_user_pages_locked should not complain because 
>>> mem->invalid and amdgpu_ttm_tt_get_user_pages_done should agree that 
>>> the range is invalid.
>>>
>> Yes, "mem->range->notifier_seq is stale" means it is different from 
>> mem->range->notifier_seq. It is caused by mmu notifier happened 
>> concurrently on same buffer that is still in restore process. For 
>> this case the patch update mem->range->notifier_seq:
>>
>> +            if (mem->range)
>> +                mem->range->notifier_seq = 
>> mem->range->notifier->invalidate_seq;
>
> You should not update mem->range->notifier_seq without also getting an 
> up-to-date page address list. Matching sequence numbers indicate that 
> your page list is up to date. If you just update the sequence number, 
> you're basically lying to yourself.
>
> You need to call amdgpu_hmm_range_get_pages to get an updated page 
> list and update the mem->range->notifier_seq at the same time. There 
> is no need to do this in more than one place. That's in 
> update_invalid_user_pages.
>
>
ok, it maybe redundant. At next round I will remove it, depend on next 
scheduled attempt to update mem->range->notifier_seq by 
amdgpu_ttm_tt_get_user_pages.
>>
>> Then restore process will skip confirm_valid_user_pages_locked, jump 
>> to next scheduled attempt: "goto unlock_notifier_out".
>>
>>> "At next rescheduled next attempt we use stale 
>>> mem->range->notifier_seq": This is not really stale. The 
>>> notifier_seq indicates whether the pages returned by the last call 
>>> to amdgpu_hmm_range_get_pages are still valid. If it's "stale", it 
>>> means an invalidation (evict_userptr) happened and we need to 
>>> amdgpu_hmm_range_get_pages again. In theory, if an invalidation 
>>> happened since the last call, then mem->invalid should also be true. 
>>> So again, the sequence numbers and mem->invalid should agree and 
>>> there should be no warning.
>>>
>> When invalidation (evict_userptr) happen concurrently restore process 
>> will schedule next attempt. The mem->invalid is set to true by 
>> evict_userptr, also the sequence numbers. Both agree and with this 
>> patch we do not see WARN.
>
> Why do they disagree without this patch? I think what you did there 
> (updating the sequence number without getting updated pages) is 
> incorrect. If the sequence number and mem->invalid are updated 
> together under the same lock, they should always agree. There should 
> be no need to mess with the sequence numbers after the fact.
>
I did not mean mem->invalid and sequence number disagree. I mean 
mem->range->notifier_seq and mem->range->notifier->invalidate_seq 
disagree. We can update mem->range->notifier_seq at next attempt.
> Regards,
>   Felix
>
>
>>> The warning messages printed in confirm_valid_user_pages_locked 
>>> indicate that there is a mismatch between the sequence numbers and 
>>> mem->invalid. As I understand it, such a mismatch should be 
>>> impossible. Unless there are some bad assumptions in the code. I 
>>> haven't figured out what those bad assumptions are yet. Other than 
>>> the case for -EFAULT you pointed out above.
>>>
>> From my debugging this customer app the warnings is due to we did not 
>> handle well if amdgpu_hmm_range_get_pages return -EFAULT and mmu 
>> notifier happen on same buffer concurrently. That lead we use mem 
>> without hmm range associated and stale mem->range->notifier_seq for 
>> following operations. With this patch there is no warning messages 
>> and not see other errors.
>>
>> Xiaogang
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>>> ---
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 45 
>>>> +++++++++++++++----
>>>>   1 file changed, 37 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index 7b1f5933ebaa..6881f1b0844c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -2444,7 +2444,9 @@ static int update_invalid_user_pages(struct 
>>>> amdkfd_process_info *process_info,
>>>>               ret = -EAGAIN;
>>>>               goto unlock_out;
>>>>           }
>>>> -        mem->invalid = 0;
>>>> +         /* set mem valid if mem has hmm range associated */
>>>> +        if (mem->range)
>>>> +            mem->invalid = 0;
>>>>       }
>>>>     unlock_out:
>>>> @@ -2576,16 +2578,28 @@ static int 
>>>> confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
>>>>       list_for_each_entry_safe(mem, tmp_mem,
>>>>                    &process_info->userptr_inval_list,
>>>>                    validate_list.head) {
>>>> -        bool valid = amdgpu_ttm_tt_get_user_pages_done(
>>>> -                mem->bo->tbo.ttm, mem->range);
>>>> +        /* Only check mem with hmm range associated */
>>>> +        bool valid;
>>>>   -        mem->range = NULL;
>>>> -        if (!valid) {
>>>> -            WARN(!mem->invalid, "Invalid BO not marked invalid");
>>>> +        if (mem->range) {
>>>> +            valid = amdgpu_ttm_tt_get_user_pages_done(
>>>> +                    mem->bo->tbo.ttm, mem->range);
>>>> +
>>>> +            mem->range = NULL;
>>>> +            if (!valid) {
>>>> +                WARN(!mem->invalid, "Invalid BO not marked invalid");
>>>> +                ret = -EAGAIN;
>>>> +                continue;
>>>> +            }
>>>> +        } else
>>>> +            /* keep mem without hmm range at userptr_inval_list */
>>>> +            continue;
>>>> +
>>>> +        if (mem->invalid) {
>>>> +            WARN(1, "Valid BO is marked invalid");
>>>>               ret = -EAGAIN;
>>>>               continue;
>>>>           }
>>>> -        WARN(mem->invalid, "Valid BO is marked invalid");
>>>>             list_move_tail(&mem->validate_list.head,
>>>> &process_info->userptr_valid_list);
>>>> @@ -2644,8 +2658,23 @@ static void 
>>>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>>>        * reference counting inside KFD will handle this case.
>>>>        */
>>>>       mutex_lock(&process_info->notifier_lock);
>>>> -    if (process_info->evicted_bos != evicted_bos)
>>>> +    if (process_info->evicted_bos != evicted_bos) {
>>>> +        /* mmu notifier interrupted 
>>>> amdgpu_amdkfd_restore_userptr_worker
>>>> +         * before reschedule next attempt update stale 
>>>> mem->range->notifier_seq
>>>> +         * inside userptr_inval_list
>>>> +         */
>>>> +        struct kgd_mem *mem, *tmp_mem;
>>>> +
>>>> +        list_for_each_entry_safe(mem, tmp_mem,
>>>> +                &process_info->userptr_inval_list,
>>>> +                validate_list.head) {
>>>> +
>>>> +            if (mem->range)
>>>> +                mem->range->notifier_seq = 
>>>> mem->range->notifier->invalidate_seq;
>>>> +        }
>>>> +
>>>>           goto unlock_notifier_out;
>>>> +    }
>>>>         if (confirm_valid_user_pages_locked(process_info)) {
>>>>           WARN(1, "User pages unexpectedly invalid");
