Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD7CC001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 22:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F6E10E122;
	Fri, 11 Aug 2023 22:00:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36FF10E122
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 22:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiGEZDNRaXg8Ptbuzk5irnjsbJzv9vNG5a6AKF6XaoJTEtvIucNOSQq43JWbK4EpNi3oioirtKR0Pt3lFhMx20RBpOK+ex9X7d4TmfMmpA31wbW4u4QNc6xVQwBAAHGgUwxAqGjiTH1iYN6yRFQzhLhBtQ1D+tzCDWjqh37yRzN5vdFyLh9w8KEV0pYyrCTfrMOuZIc5dRvK0GxwX8x57YfMV9/1dysWoPCL/4p8cDn2A/in2jOYYx+ywtMdNWtvIoKRq/mw1jielYVFgan+Q1Zems7vljtQ7QZvk4oOJpRyzuiETT1Zd3WA++PJzL4GYzPtFtX42jDmvK5D+c1ZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Axu7x77YLYoD7nSdiu8efRTgNHxMFgt3unqQOWvaahs=;
 b=J+ux/eR2oYCKUwo4InjwXsY96Qch2ByyuYwr5EhTJLfhmLjdLYojUttwPxGf0St26W/EYqpHYGd9xLgPNyykbXKOTQewkn4NJ+uFm5i/nZqUxEkpaaJc1+3elmVXVUsc0yX3PXkl0SufTUVSS4/qk6SBs0Jd3s39dzI47+SiAot3sHXK0ZCKxlmNt3XCpG2+O61N+HT8s/tSJf+ZyRp0vf/sWc8dVRPP6Lym7bjWvsRLR77t162mvSnH3+vPhqo/+GTEgtvQ2zHSgcMUZA7OHKiW2oFrmFVTdOeuz+EIG4xkUZJ2MFoSui8miLcIl7pmKccglY19cSa1QMIGJ0Qeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axu7x77YLYoD7nSdiu8efRTgNHxMFgt3unqQOWvaahs=;
 b=e0YGOPMuyCKl8UHS7RXYdmmtt+YC0AqkBBvzpFxBibhMrnEoB/4Oo/m6zk/oP4cW4W5Oemnu0ZIfS3uDjhjm7uikvan7jablOEyjiu7VNZJYahV492zZkpqOfEHZA8MLvptfsK/WfgPmZ5aA5c3Sca9pnoexAIbI458KvZKAacI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 22:00:37 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8172:fab3:9de4:a004]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8172:fab3:9de4:a004%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 22:00:37 +0000
Message-ID: <470a396b-e62c-7e11-5986-684a625c240b@amd.com>
Date: Fri, 11 Aug 2023 17:00:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230811191108.1808648-1-James.Zhu@amd.com>
 <3268e31b-bfd8-7e40-d7df-068f51dc8ff6@amd.com>
 <9c146294-f979-a2f9-13c9-fac588a63406@amd.com>
 <5ae99973-1b5d-4672-de31-4f2f23330bb4@amd.com>
 <1680c4b5-808f-b02b-cd2d-083f78fce3d6@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <1680c4b5-808f-b02b-cd2d-083f78fce3d6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0147.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::11) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: d43a8301-4975-4318-3f4d-08db9ab664c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0g6YpOY/3GH2wvn0y0/SMInNcWg4CMnXFkOnEc2BDSV/clnEGqme8BbuwbB2BxKUCqEejilDrycto3JICWk0gnYh6RspQ/ibMQOzQRt3CvmvfCbWybn/gUk+0h1UisI1ZAwB0udedQXLb1pv4pV0fsLp5Ev1BWjuS8yd6O7Z4tYuiHP3kwZeCC10v/nwaQ1xlgZeKiEAK9SyOJxVJy+B1YG6+lAJOQ2nPi4uWOfCm+Xo5n4AVJ36K0pamHAJJ/PR//o4Nw4FPzL7ElyJJMd7Us1/2afAG/NIcfVTp/QFAr8xnGpda2Zn443sDlj348Lrxy16LkMY5O1sSE6K+j41XzYomgvDCOsJzYh3qjZRMFQoMLG3pDmwpUjdKkTRPPCaTAkLm9rQv+fD1muzoNm38Va6i8+tvjK4e32wqA2TAMkigiudDX+IW5uDGZd5MGQahv9Hq6HWn0U/Oxrgy0Re9K7F5DYbP7olFWiyQ7qpFxjQ5lp+fbYmeK0nawkUs1kwyT3tbZfBXnw7VUdNaToch45vZoRWoj1HHGYcEGeNiv+qBs9ZWY1ullkFb7lXWvi9EAgyFhTxO7NC7aggVCWp7uhnVlqFmbe9ffnnHKBXZsGu+j6UAPNBpP71TYyDM+Fz1cX7c8jaB1w6HGe6DMI5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(376002)(396003)(136003)(346002)(186006)(1800799006)(451199021)(6512007)(6666004)(31686004)(4326008)(66946007)(66556008)(66476007)(316002)(110136005)(478600001)(6486002)(5660300002)(8936002)(8676002)(53546011)(26005)(6506007)(41300700001)(31696002)(36756003)(86362001)(83380400001)(2906002)(38100700002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU5NQjFUOGhUMkpDdWExRjhQZEZCTkw4R256RmFEN0J0ZXVzbzFnMFJpVzdl?=
 =?utf-8?B?M3pKSjJRTzgvOHQxMUdSLytEZ1FZaXRvbTBTVU1HLzdNNDhTeHFOYkJxRTRT?=
 =?utf-8?B?b04xaVNlbkF1elZpbVdHTVBrQnEwOHJpNXNQSzYreDdxdWVUZ1AwazVaeVJN?=
 =?utf-8?B?N3YwZjBGbnF5cHRBUG9QRkhmZjVzMUxnZVZzRTMwRGc1S2ZJWVBIRjVPNTVL?=
 =?utf-8?B?UWgydk11dmRBcjBsdVZYd0dEbmg4UE1uWTZjK2tzd21zVGJBbVFTdWpGaDEx?=
 =?utf-8?B?QldZTTNkanZKbjUxTDRYTE9GK3daRnJZWjBNK3JBQkZEQ2N0SmNzWTE3QWtq?=
 =?utf-8?B?TGRZK3NOQytrZm1sdDRsYzNmNWkvQm82RzJOckxUYUpFQUxqVjBLd2tnNUg4?=
 =?utf-8?B?VzZaOVNtSnh5Z0Y4QWM3elFHdGNmeVVDNVF5NXh5YnNqZ2V5MVliVlJwWkpw?=
 =?utf-8?B?cHRaZUo2TUZkMmhhYWhJb0YyeHl6SjI1bTFHNXJxOTMrVFJiS3Q0dm1vbkQx?=
 =?utf-8?B?b09VaHVZYmZQSjZ4UXdqWStJL253LzJneGp1OGtnaVE0c0JvS0J0czhoRGFW?=
 =?utf-8?B?YmcwQ0JpTTFsZVVxSVZ2MXpXc3VlWTFVNGF2bFU3V0xPTHhaNHlsclhvY2Y4?=
 =?utf-8?B?TEJncERPclc0c094diswcWtDcVhWR2xEczdodWxxVVVGWkpSQXRTcnhaWERW?=
 =?utf-8?B?cGdWaFBhazR5OEM2cWVhSEtnbWY2VDZuWnF1NmQwNTZtMUFneUs4ZGltU0F5?=
 =?utf-8?B?YWIyd2lKS3Q0SGtjMVdFUWVLMlozalQ4Z3g2UEM4NFYrWUtYZWk2MTZiNzFQ?=
 =?utf-8?B?UUZJMThHNVJDeHRldzcxYWM0ejFKWnpiM0MzakZNbWN4TzdQd0xVSkFyelNt?=
 =?utf-8?B?Q2JONEdNcHJSVVYySlR1RDErRllWZWdrLzVOOTkxVWVsaWpwWkdYbVJaRm56?=
 =?utf-8?B?aFNJTi9vaS9SNkhKdmdkejNSVnBhaEdTSWhmRGYzU3F4V2FqT0ZQU25UQnkr?=
 =?utf-8?B?Qlg1RG9oRWJCY0ZHaldWb2UvTU9vMGMrbjJhNVp5LzJ0NktiYnVSTDZhYUlj?=
 =?utf-8?B?bFhwOWhybU1WRndqNXFyaUtYVlptNjFINmxENml2cmxnL1hFbDZCQmlPaUU2?=
 =?utf-8?B?TUl6c2Y4Z0k2RzdXbmZmUmtZV0RmMzhQcEdvQ2xJWTdLWkc4WjFHbGIrbnA5?=
 =?utf-8?B?SFlKa09XKzNtT2U4TmJ5M1NNUk0zNm43cnNpZFVCa3lteHpwZ1c3YkZlVVE1?=
 =?utf-8?B?K21FdFI3TzE0TFJ1UUxoWUR4RlNNeTR5dzd6eFNkWmxkTWppMFZ6OUlMWGRr?=
 =?utf-8?B?RC9sSVNpTmgwUXBvd2xSRVhUVEFpM2prYlVWaEZHWEI1Y0puZ3FUUlN4OFdx?=
 =?utf-8?B?SW1xZ09NUTRVLzY3U3djMCtyZVdEVjNIeFplNUpXSDhaSFFQUUlDUFNQbHNh?=
 =?utf-8?B?NXhZVlZsVkJYTnRsVzJNMXp6aGdqMWtWYVNXSEhKUFNCbm80SUQ1bFRNVmRB?=
 =?utf-8?B?Q3pxMEY5V3MwL0IyRy9lam9ZVUJPMWYwTWE0MlhjSFFHMWQ4VVpJelczUGVa?=
 =?utf-8?B?WDhRdHB3VlNyNnVGWFBSblBaQnpoR0FiN1NiYXhwZkl6WVlYMytLVlZLeXlw?=
 =?utf-8?B?aDFGYUJPNno0RUZQUUFZMm95SEU5S2JYMXpmb0N0bWZzWWptRDg3c1ZwWDFK?=
 =?utf-8?B?WVY4bGhSQm5NNTEzcDdQSWpKOWMrZms1SjNFUzVwU0x2VWR1b1gwVndnTm11?=
 =?utf-8?B?OTluNU9nMmk1THZ2Y0tGKzF4V1BtQmN3VGYyQVE4SEgwUGtZb3JaZXdWL1dD?=
 =?utf-8?B?N2pzcHMvbG9wTzhYc29rMEd6TEJzTkM4M0hPRUMzL0xQcU1yMUFmc0I5YTVU?=
 =?utf-8?B?TUcvZXZVR2x4eCtpM3RIcElNRDhWTnlPNzN6THpnQllvbGRXL01Ja2NiNlRM?=
 =?utf-8?B?RWlhcVVGbHdaNXlvMnY3VEN0TUFOUTVtZ2FuM2R1VWxxL0M3d2pKYlJSa3Ev?=
 =?utf-8?B?Sk9OanNRWVZBT2JZNklYYzVJZE11ZXgyK3ZQNjh5T25jKzZkYnpUMFJvemwr?=
 =?utf-8?B?OW5yRk5CaEEvL2JRUUIwNmhpUGFBYk1ZV1Q3Ri9rL0U1Q0pwbytRV2MyYmlj?=
 =?utf-8?Q?rOCg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43a8301-4975-4318-3f4d-08db9ab664c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:00:37.0006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tM4tfhI0ksqZLfWNUiT6rGII2FwfQh7SajQCdxBHH3Mmg8S+Dv4LXopkMJW1YBD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965
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


one checkpoint: I saw they use serial port for console at kernel 
parameter: console=ttyS0,115200n8

  *

    Booting Linux using a console connection that is too slow to keep up
    with the boot-time console-message rate. For example, a 115Kbaud
    serial console can be/way/too slow to keep up with boot-time message
    rates, and will frequently result in RCU CPU stall warning messages.
    Especially if you have added debug|printk()|
    <https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.printk>s.


On 8/11/2023 4:31 PM, Felix Kuehling wrote:
> If you have a complete kernel log, it may be worth looking at 
> backtraces from other threads, to better understand the interactions. 
> I'd expect that there is a thread there that's in an RCU read critical 
> section. It may not be in our driver, though. If it's a customer 
> system, it may also help to see the kernel config. Maybe the kernel 
> was configured without preemption:
>
> -       For !CONFIG_PREEMPTION kernels, a CPU looping anywhere in the 
> kernel
>         without invoking schedule().  If the looping in the kernel is
>         really expected and desirable behavior, you might need to add
>         some calls to cond_resched().
>
> But then I would expect cond_resched() to fix the problem, according 
> to this document.
>
> Regards,
>   Felix
>
>
> On 2023-08-11 17:27, Chen, Xiaogang wrote:
>>
>> On 8/11/2023 4:22 PM, Felix Kuehling wrote:
>>> On 2023-08-11 17:12, Chen, Xiaogang wrote:
>>>>
>>>> I know the original jira ticket. The system got RCU cpu stall, then 
>>>> kernel enter panic, then no response or ssh. This patch let prange 
>>>> list update task yield cpu after each range update. It can prevent 
>>>> task holding mm lock too long.
>>>
>>> Calling schedule does not drop the lock. If anything, it causes the 
>>> lock to be held longer, because the function takes longer to complete.
>>>
>>> Regards,
>>>   Felix
>>>
>> Right. I do not see either how this patch target the root cause. It 
>> is on customer system that can have many RCU operations(not necessary 
>> from our code). Any read critical section can cause write stall.
>>
>> I think we can use some RCU parameters first to see if thing can 
>> change: like config_rcu_cpu_stall_timeout to increase grace period, 
>> or rcuupdate.rcu_cpu_stall_suppress to surppress RCU stall.
>>
>> Regards
>>
>> Xiaogang
>>
>>>> mm lock is rw_semophore, not RCU mechanism. Can you explain how 
>>>> that can prevent RCU cpu stall in this case?
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>> On 8/11/2023 2:11 PM, James Zhu wrote:
>>>>> Caution: This message originated from an External Source. Use 
>>>>> proper caution when opening attachments, clicking links, or 
>>>>> responding.
>>>>>
>>>>>
>>>>> update_list could be big in list_for_each_entry(prange, 
>>>>> &update_list, update_list),
>>>>> mmap_read_lock(mm) is kept hold all the time, adding schedule() 
>>>>> can remove
>>>>> RCU stall on CPU for this case.
>>>>>
>>>>> RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
>>>>> Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 
>>>>> 65 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 
>>>>> <89> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
>>>>> RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
>>>>> RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
>>>>> RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
>>>>> RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
>>>>> R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
>>>>> R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
>>>>> __mmu_notifier_invalidate_range_start+0x132/0x1d0
>>>>> ? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
>>>>> migrate_vma_setup+0x6c7/0x8f0
>>>>> ? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
>>>>> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
>>>>> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
>>>>> kfd_ioctl+0x271/0x4e0 [amdgpu]
>>>>> ? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
>>>>> __x64_sys_ioctl+0x92/0xd0
>>>>>
>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> index 113fd11aa96e..9f2d48ade7fa 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> @@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>>>> struct mm_struct *mm,
>>>>>                  r = svm_range_trigger_migration(mm, prange, 
>>>>> &migrated);
>>>>>                  if (r)
>>>>>                          goto out_unlock_range;
>>>>> +               schedule();
>>>>>
>>>>>                  if (migrated && (!p->xnack_enabled ||
>>>>>                      (prange->flags & 
>>>>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>>>>> -- 
>>>>> 2.34.1
>>>>>
