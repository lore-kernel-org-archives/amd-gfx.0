Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A101C001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 21:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C06910E700;
	Fri, 11 Aug 2023 21:31:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B36210E700
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 21:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMuhnlD311QmZPQCf/k/1wXfkwNTakdzjiSaaFi/s2+nzoSPCKe4SSXK9klM4rPxtnOFtrIInWW5afcqSuPQxfHzz1L1V8YlCcBnA4l/nNJVRiR7cTCXOBofzA9rEKn1eoPpQhaeWU3bjeuv3y2jQhGdEeLXwyilnAh8GaBV2J3FmzzCDuIg1HdBqcVDSkgovzdclTpx9je/v2WRoEnlUZTQkPq6rkEQ9ReCcSw8X6cM8b5fw5eWoQlv1ridz4G4vub0W0PnSX4TeNzw6pRAxtu3KZywdOOp1PkDyEME3B/F17H80h48XeeQPyimUgQSVT2MUcRm8m83a4VNbMfCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unABAwSxdJWOSaokCFIUW+q7/KJb5h8LLRUjI8VL8OI=;
 b=QcXuOHA/sbey82ZKO63VVmgA6nt5UikL9zDaVBPK8YhPB15qOAlXtaC0yShXIzXeIlVEEit24ynwImAjjoZgnnslM7phB5R8Ffe1ggf+0dGWugo4Gyz7sbE5BfZTmZC6PywrXRCERi2JZDULoNcOMl0ZG8TwDHlLslPh/+QEy0I7dW6P6AcGdspwomD5K47EpplqZ9S7k8qV/9MNxH6YRrV3dwzI6HDOr2tvOwJF/iGuJmcwS0j6diYbmtO2zkmiFxz5rCpQOkX5b97QII/Zc9qSv8lNcs0QU+lX0F2uGzgjD4xyhFqYIbCR7SftXPxrcv9WzKH01ft6pPZWODtWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unABAwSxdJWOSaokCFIUW+q7/KJb5h8LLRUjI8VL8OI=;
 b=lIp7VaycTccHOZ59B/zHIk/gYeG+L8je6YMukL5tEhHCDoNaxKMNMDmaNggXYwXUf4VxQ2+UpBo4TkOhcZDB9NOVKllhrYSSKzh+kPZyT2szKaSeMFAxaR1lOTpy8rsfA0u5aNtStDRVnQLsjjJnpzv28kIk9FhjcaPCh54a8CA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5134.namprd12.prod.outlook.com (2603:10b6:5:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:31:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 21:31:46 +0000
Message-ID: <1680c4b5-808f-b02b-cd2d-083f78fce3d6@amd.com>
Date: Fri, 11 Aug 2023 17:31:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230811191108.1808648-1-James.Zhu@amd.com>
 <3268e31b-bfd8-7e40-d7df-068f51dc8ff6@amd.com>
 <9c146294-f979-a2f9-13c9-fac588a63406@amd.com>
 <5ae99973-1b5d-4672-de31-4f2f23330bb4@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <5ae99973-1b5d-4672-de31-4f2f23330bb4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e47b12-d4f6-4ac2-385d-08db9ab25cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIRvKRQcyi59UEnux+bd7e3zv9q9QczuxOIsW58K5l7kqcQBmfPIIRjuEPa4YtqRqUYXM5KKJhUOxUYp336jSu5cZGr2s/aOO7QEB7Bbh0FiyXG7y+I7JOE5T2ktaFTeTarlyjEBIv2IL7Q8zbJUdp1ql7iwZEVVjKdEj20EglRHhlEa60mMTbRgMzbvqqwct4YCUd7RazJJcSzMqxNXRwhF57vIwb3alyDluY0NajV6+VSrroXV6NpCblFNa2snXMWwqIDdy1qbJPoCTu7GMwn7HwxyOuWzh4vHx22UVb9RBcemLa39ljctNZ3Jga2mFDUcH8MnCLNAxqufo6csXNNvikb7EX1imXzjLyKCZVwcjrEZu4mkMJP6hhh79VNrd22WPG+D8vhwHtB+WQIWxZaTetxmwmTI0RuUohcceaZezuXrET3Ojzjs4SW98kXj/NE1eqSJizBEnQwfLyeAdCIpNTwelxXt8rdSeOX/JuMDRmwTjY9ThxjxtOqHqD3Vs5wKy2F0VSnbvXLSvaROTzEH7T0r6yq4Dy8ww6/L4vzb696UHb9UIr9cwS3tS7QnQZ//g1oe8HTtKCpWMBoK77dgeelEBPD3ML331Nmb1wfuKSKu8kg49TRPYgRuWm6ZnriQuY/XyrftEqbhNoYGxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(1800799006)(451199021)(186006)(316002)(4326008)(31686004)(66556008)(66946007)(66476007)(38100700002)(41300700001)(110136005)(8676002)(8936002)(5660300002)(83380400001)(6512007)(2616005)(31696002)(44832011)(86362001)(26005)(6506007)(6666004)(2906002)(478600001)(36756003)(36916002)(53546011)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkwvbTQxT3JHQkpwZ2ZyZ0tQZVNvS2d2S2tnU29ieFFOWlJmV2VTblhzTzFF?=
 =?utf-8?B?Yy95NzZNRGk2NTdZc3N1OUxGN3NlcmxQYkNzeFF0Wk1RRHlxYUVPUk1EMncr?=
 =?utf-8?B?L1VZa09tdmJlbGhqTXJsZlZpUXdVNVJ2eTdsaEFUeW5uN2Q4UHl0K2NkK0JQ?=
 =?utf-8?B?cEtnS1ptcGN2eVJtK1lUTTZQYjJxUkFSc1M1cVMxRFp6TGhQUmwwalpTN1lH?=
 =?utf-8?B?Z29MS2FhaE42MG1FN1pHVmZlNWlIMkdObDV6MWhVMU5UL3BXdllEQ0ZBa05D?=
 =?utf-8?B?R21SZzVlWHpHa25EY1EzMEthOE82dnpCbThRVXM0REVRQWRrZXc0TGxNVXhW?=
 =?utf-8?B?YWQ3QisxM3doMXZxbUczYlFEYkM2emR1NTVhb0d3YitucE5paWlXaUpUTHVl?=
 =?utf-8?B?UUJZRmE5azJxNDgzSUxKbHgyLzlWMGVIdHRhSnE5cXM5YVhmc3BBaXNXZ3Za?=
 =?utf-8?B?OXRHdlJkcWFmQjJsbktwcUVZTVV1N0tPNWhyeFU3NFdUOE83Qkx1em01bHFW?=
 =?utf-8?B?aEkzVkU2eGdLNlNXdUJxTDBuREhFK2ZBMk0zeXpSWGhVdVpraTR1M2Y5ZXZi?=
 =?utf-8?B?NmxVR21INTNycktyTEVOOU43VmVzN21UYi9CdFpBcUJSekF0dE9sN0hFMkg1?=
 =?utf-8?B?bzMrWDBvTkErWHdwTmFiMFR3TjRDaFlNSUp1Y1JYTE5OU3R4T0lmeHp5N1pz?=
 =?utf-8?B?RUFxNkJ6NDNvMG5MWjhEYW0vYkRjZHVsNG4xcU1JbjliTXNyNEk0cG16Z2J5?=
 =?utf-8?B?SjBXVjIxLzVFMlNoMkNmbkU4UDR0NXFZakpXMjJ4YTRHWW5oUmpyZ0dBaFpk?=
 =?utf-8?B?ck8vUUdXd1J2V2h4bnp4ckxKNk13N05Jb0w1Z1lYT1NacWZ1NnZGd25XOS9s?=
 =?utf-8?B?bFZYUjY5VXBNNkFqUlZ6TmFLWUEzVTZxblVNUi9FZXlPUFVhREhqMjNQYU4y?=
 =?utf-8?B?MzNWUkNEdmhEUjRJVzd0dmdKU0o2QS9LUUo3OUNpRlRsamdpRGYyRWRZRml6?=
 =?utf-8?B?NXBkcFExaUhzZXdHWDBRNWZOVVczc243QkhVN2pRbzJ4dkZNL1BaL29GYXd3?=
 =?utf-8?B?OVlGMnVyZmRkSk9Dejh3Njh0a2l4SkhlSDB6SSsyY3lJaFFPclUwZFR1NWE4?=
 =?utf-8?B?Z3pzQmdad0xsdjVERUdYQmhiaFA2eTNFWElLV3QzUzk4NW8zL1hyT3laRjZr?=
 =?utf-8?B?OFoxYktVRHVkUW9sQ3BycUY0RXFteGdQRlZDSlRGN0ZwaEFpOHM2L2phejlr?=
 =?utf-8?B?Y1RraGpzdlNQaHRGbzczNEJFWHZTdXZ5Y0duUjNhakxGL1h2Vm1ZbEhZc0hr?=
 =?utf-8?B?dXM1U0hjc1NQR0JCWGI2a095SGxWOUtLWDNPRXQ3V2IvQnBWQTZNcDNhOXJp?=
 =?utf-8?B?MUZWdDhNYnUwRGJ2bnl1K2VOeTFUeVZpWWg4OUNuUEt1N2lScWNjMll6SnU2?=
 =?utf-8?B?NkZhUjVld05QVlhzMm01NE0rckQwM2NHSzZyb2tLUXZMdkY5cTVaNmkvMXha?=
 =?utf-8?B?YVI0NVNNUXVwZWd6eDRUSmFodU80YUIzTWxjQVlnNHY4UTVOMG5Sa0VmdGxD?=
 =?utf-8?B?ZGVGZEk3OUsxTmQ4NmlhdG9HMGJUV3BnTXRZbU1OSysrSDlKbEFhWndoWGdE?=
 =?utf-8?B?WGNyQ2src3o2L2tzOFF3eWZaQ2FLZGtCTUJuQ2NCV2dibHg0V0lzazFpb3lh?=
 =?utf-8?B?TlltajdzeWVnNUZBbncwT2N5aXpNNm50WUhNeGZ4akx3dVphVHlJTG5ERmZ2?=
 =?utf-8?B?UkhHZDhmMit5c0tCTUZPUEVHNlh3dXZ2STlSb3U5SE5CYXpCTXIvb0tMN2ZB?=
 =?utf-8?B?QUQvaDB4L0NyalRObldreTdxVWFTZjhPRkZiMnlHOStWam5oS2dtTmxWRURT?=
 =?utf-8?B?c2F6djU1bVJoMXBPemhHNFRrOEcweVBkOXpBL2RDWUNMY0RQd201Vkw4Q1c4?=
 =?utf-8?B?ckRLYkIwYXFLWFVtV09ockhYRncrajdsTlh1UHZMY0RBblRtOTNYaXVITE90?=
 =?utf-8?B?ZkxBSlowekZtd3FLNDBoNUNFVW41aXYwZ0FHTHRIMU55TDFFK0N3NWhnK2FV?=
 =?utf-8?B?bnFNbjRRbDVWQVNZemZtcVYwd3RMNWdJNXpqZE1DSUFmQlBra2VxNnpraGFk?=
 =?utf-8?Q?XmKwxuLAnh05QKpeZ1oYELDhY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e47b12-d4f6-4ac2-385d-08db9ab25cf7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:31:45.9005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZUZGgFwHQm9cMyG7eJdw+bo1+/OYz3l5hRC4PJ8YOrKRpWcYNL/TeWD90DIj4Uvpe6YOvTIk44IZt+b4QaDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5134
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
Cc: jamesz@amd.com, Roger.Madrid@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If you have a complete kernel log, it may be worth looking at backtraces 
from other threads, to better understand the interactions. I'd expect 
that there is a thread there that's in an RCU read critical section. It 
may not be in our driver, though. If it's a customer system, it may also 
help to see the kernel config. Maybe the kernel was configured without 
preemption:

-       For !CONFIG_PREEMPTION kernels, a CPU looping anywhere in the kernel
         without invoking schedule().  If the looping in the kernel is
         really expected and desirable behavior, you might need to add
         some calls to cond_resched().

But then I would expect cond_resched() to fix the problem, according to 
this document.

Regards,
   Felix


On 2023-08-11 17:27, Chen, Xiaogang wrote:
>
> On 8/11/2023 4:22 PM, Felix Kuehling wrote:
>> On 2023-08-11 17:12, Chen, Xiaogang wrote:
>>>
>>> I know the original jira ticket. The system got RCU cpu stall, then 
>>> kernel enter panic, then no response or ssh. This patch let prange 
>>> list update task yield cpu after each range update. It can prevent 
>>> task holding mm lock too long.
>>
>> Calling schedule does not drop the lock. If anything, it causes the 
>> lock to be held longer, because the function takes longer to complete.
>>
>> Regards,
>>   Felix
>>
> Right. I do not see either how this patch target the root cause. It is 
> on customer system that can have many RCU operations(not necessary 
> from our code). Any read critical section can cause write stall.
>
> I think we can use some RCU parameters first to see if thing can 
> change: like config_rcu_cpu_stall_timeout to increase grace period, or 
> rcuupdate.rcu_cpu_stall_suppress to surppress RCU stall.
>
> Regards
>
> Xiaogang
>
>>> mm lock is rw_semophore, not RCU mechanism. Can you explain how that 
>>> can prevent RCU cpu stall in this case?
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>> On 8/11/2023 2:11 PM, James Zhu wrote:
>>>> Caution: This message originated from an External Source. Use 
>>>> proper caution when opening attachments, clicking links, or 
>>>> responding.
>>>>
>>>>
>>>> update_list could be big in list_for_each_entry(prange, 
>>>> &update_list, update_list),
>>>> mmap_read_lock(mm) is kept hold all the time, adding schedule() can 
>>>> remove
>>>> RCU stall on CPU for this case.
>>>>
>>>> RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
>>>> Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 
>>>> 65 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 
>>>> <89> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
>>>> RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
>>>> RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
>>>> RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
>>>> RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
>>>> R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
>>>> R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
>>>> __mmu_notifier_invalidate_range_start+0x132/0x1d0
>>>> ? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
>>>> migrate_vma_setup+0x6c7/0x8f0
>>>> ? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
>>>> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
>>>> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
>>>> kfd_ioctl+0x271/0x4e0 [amdgpu]
>>>> ? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
>>>> __x64_sys_ioctl+0x92/0xd0
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 113fd11aa96e..9f2d48ade7fa 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>>> struct mm_struct *mm,
>>>>                  r = svm_range_trigger_migration(mm, prange, 
>>>> &migrated);
>>>>                  if (r)
>>>>                          goto out_unlock_range;
>>>> +               schedule();
>>>>
>>>>                  if (migrated && (!p->xnack_enabled ||
>>>>                      (prange->flags & 
>>>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>>>> -- 
>>>> 2.34.1
>>>>
