Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05838C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 14:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71AAC10E2DA;
	Mon, 21 Nov 2022 14:46:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3827110E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 14:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXHGbFp1HHUUD0CNhoxTTnD1+1X/cFGoeciFnQIIxIbQl/3NmIfvhFjrTix3H6O9wbztM5frx1zeRQ6406dRWvooXoHrjSmysdccA6x/p9rz7LTsRl6xgMYO3ufyLr8t4v8zdWPBAlceuF8WeNq5wP8VyF3w3oEFTct2H03XGlgOTd+Mvf1hszT08raxk5mt/NhBlNwlAKC28UmsYugUAoAMEuoQsOUnQCReF6IZAizzjT+H0uCDWGvMLXVZa+R/CXZTd8VGpvSQgKOKKAJFJrMWXoykDxa0IrxOv5yNV8u7as30Rhc8IOs9BdY9ppUfLmLupibX8dusea/yARbizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isOV7xFleTIm0/1maylZp7C7iE11ZC3NkumwmGZnX4w=;
 b=n5ps0wj4/cuvVvb0srzTx4LYSePgRX6oGMHSPE28sPM8mEou/zecRUul1C2/rxqhUqqCY+H72/NtzwYO7nqzkPHCpofc8qySMZ1j0HnIoTocxERKhzA1KNwr6o/rJ287gggOy2TZx7P32iLcqCJa4I0ccVZTuL6CxuxXQ2/sgnD+pYd16qrMnmFJmHphN1wiQMeM5DgO3FK8l54StPPUUgG/0u8KPDjGRtg5V/UrAvKhTnS8AbsgEscAEQwFTty0tdbjkSxqTAmdXOVN2cGFGVf6d81FaRR07+at2bw8BW70O5c6GtibRlslaOt5mN9LrvVeqC4R4eYVfH8KFvntxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isOV7xFleTIm0/1maylZp7C7iE11ZC3NkumwmGZnX4w=;
 b=Om/Uh65ysimR0ZnsLullre5D4Uo3Gyl8fhLo5WPKTYUoC2mouJOoPxCCiuZFrnt4TWJxGwiuH/Gw3PilddAvAs4DPVqgV7gXJcmhxHriH5LHrTsOZo8ItZPfBBMHp7eKH+JmEzsM9tbX5pMP/lI0mx4qcHQpkKQmjZEvZPDTpo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 14:46:32 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::a425:7531:6b64:db42]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::a425:7531:6b64:db42%12]) with mapi id 15.20.5834.015; Mon, 21 Nov
 2022 14:46:31 +0000
Message-ID: <79e06919-409d-5b40-008a-6c9410240b72@amd.com>
Date: Mon, 21 Nov 2022 09:46:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] drm/amdgpu: fix stall on CPU when allocate large
 system memory
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.kuehling@amd.com, philip.yang@amd.com
References: <20221117213829.24861-1-James.Zhu@amd.com>
 <20221121131356.119508-1-James.Zhu@amd.com>
 <950574a1-ca9b-c99c-fd9b-8fed2105a043@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <950574a1-ca9b-c99c-fd9b-8fed2105a043@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 4014de84-a73b-41d4-a0c0-08dacbcf2d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSgNpaznJ81onoN+c3AIDxGT1SJN++wg/n55azbUBeH6VlvqP0edUCeGiBhDPoMzwziOW+kOCkW+TuWm6khIi58GDaq7pLV/BTzg+Fq9n4iSDYTz7ygePSxqRMuI72+RnMFfXfbXpT/2Wq7XpXEEZdVWu2i9nO/i77pNmgssq6cT2raGovpLsrVnCGnfVqH3qHjv47nKxQOGJdUcJ1fy2VchhxYM6IY3r2B9ZcU+2QSaS//MF0szWveWbLVNH6ze2od8DvoDguAtA6OeCbJeXreI7M6hTazC3q+vCZ6nFhDE5w4ejyfHmY4MBZuGt33cuBZbWQgk9gp7W3lDAjzeoVnIDL6asw7UbJLqJHTtXy434qIWSgX/x6sAUzVucoQpq3tZExnXxrn63+kRpklUscKnT/Y2+SaKW6i/UPEGkoeVwa8rd7jG4zd0B6eLdZm/i2BrkqfySOjGF/Yf6uXj9tzDKAqi3M+dXfx7S9hxffskxAgzNpiaEZUH7+lVE6DuRzINam/Oi7HI3GdVy3iUBP82O0JTaCcg/RpKWbSMm4zVSyo/rYFEiWxXmrKk7z6UNjrGBqgsgA3A6Wb2GSjW2EG8zFTFff0zaQlF20vjeqXS8eVIGWjpBKKVKB+HHi1zi32RCJ5SQzcssJ9UDEXGEd64VmpxpwMDbGTQDueJmYqUJdTOA3RuRUHS7JV70tuUa69+slO3rw6P29eyvlMHw7y1F1IhpS6N19ll3KgT6SQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(478600001)(66556008)(6486002)(36756003)(36916002)(66946007)(8676002)(66476007)(5660300002)(316002)(41300700001)(110136005)(6636002)(38100700002)(66574015)(6666004)(26005)(6506007)(6512007)(53546011)(31696002)(186003)(83380400001)(2616005)(2906002)(31686004)(8936002)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWR2RUtRem9pdmRCOXBNRy9VbGk2ZGxXSi9NZ1RoQTlJbktML1pSUXZwOGNH?=
 =?utf-8?B?R0JJTzRhU3AvRURpR2cvOG85SEcwTkxYY2J4VWw5bUgraEhxQklsbWxYS1Vm?=
 =?utf-8?B?U2QzNlNudzJUUzFSZmQ0TW5VSkoxUzRwblpmalJEbzZRN0JHbUxocG8yQVhS?=
 =?utf-8?B?SFkzazc3T1hzY0FwN0dQMS9zdVdNQnpoWXlpYlAvNnFmclNPaThKVWdJSytC?=
 =?utf-8?B?aElRMW9FWW5FbUNvWkg5UyswOW5sTjlscUVtcXA0dnJMaE9Eb2dUSy9NK1Yy?=
 =?utf-8?B?U05hNG1GaEF4R0h0OXNlTktuNHlMN3J4MjBKMWNrbXNzSE5sUjVyYWtjOFk3?=
 =?utf-8?B?VjYxWWxiL0lVOW5YTHBXSzlsTlQyM21DRGFtcUhPQWhCWFYxcVRUbHliVEh0?=
 =?utf-8?B?RGJVK3oxeXVzbm81RkZiL0tLNHZUekp4cHVVbUNWV2tEV1BCeWs5c3Vtb0kz?=
 =?utf-8?B?aVl1Zk1NSm1JUXhMMWdwc0IrTk1XL0VMQytvZWtXYk1YcXhNT1V6aGR3ZXI4?=
 =?utf-8?B?M1U3UWVjMktnNUpGdDRXMTE0RWY1b0JsbEEvb0JDUTBjY3IrUkExdHdvVXp4?=
 =?utf-8?B?eitjRVdYdnJHVWJ5ZzNIZnFKNkwxR3dGNXhZWlhXV3Zpc1IzNGZIY09hYVBP?=
 =?utf-8?B?VWVUM0dEV0RGS2pJdkxWRmpFYzg0TFZ1aWdUVVVlNUZqYjA2VTRVZUxGdGp0?=
 =?utf-8?B?VklOdi9QVUVBRWRFN0VueFFiVm5jUnhDQVZoODhZK3d5amRwcUtsOTVqNzU1?=
 =?utf-8?B?cEI3SVNKUDlMSFY5SmJZNmNtMjlwL05GZFdUZldmNjZUdWYxZTN2emk2akND?=
 =?utf-8?B?dkdlUGdzRCtWV3REU1gxQWl0NmQxZWhsb1JSUXNMM1JJMGozNGowZ3VDM3RK?=
 =?utf-8?B?bWNmMFdOaEt6RG9XellHVGNyUmgrcndiRHgvSHpMSks1V2hFSFF1T1k5N0pj?=
 =?utf-8?B?azRWSytDM09IOXpkcmIvcGlxQ2xadFU1M204VnRaYk9BUVNqRGJIdlQwYWVY?=
 =?utf-8?B?SDAwVU93N0FYTnJXSzhDeWhtWld4M2w4czU0a0RnaTRYVXZuVlIvc3laVnhT?=
 =?utf-8?B?dk5FN0lucUVDaEowQWFDdFFDK0l4TGRwMkphcDhDYkZ4SlFoUmZMejEwRGlt?=
 =?utf-8?B?YW5pYWJwZUNJS01uVWdMa0FGRTVGbDJ0WGNXWVEraXA1bUdrMlUrbWhBVmdE?=
 =?utf-8?B?U2RPTXpVNjVnWUpaT0dCejZHK1FrdTdURmhpREIxOG9iY1ZIWlV6cGtlcGtN?=
 =?utf-8?B?dTNTVXdESGJ5WEtjaUN6WXg5SGNmK2VDVTEzc2dkNlBrb0h1eVZLY3dLbUtO?=
 =?utf-8?B?eGk4SldreG9Cd1lhR3BMQlVBSTdESTVMLzZ2bTEzTktRcE04bGMra1VwNDFT?=
 =?utf-8?B?bzd6VDVnUnpiOW9sdlA4bXV4R2kxTWdaQnBkLzhjZmF6NEkzcDZZMzljaWpH?=
 =?utf-8?B?czBCR1ZFWkxsUEplYzdTTXlqOTJGdVRHWG9pMDNnckVHVnFZSS9nV1JyaXNl?=
 =?utf-8?B?QnVDWWVpZVcvTm1VcEpIaDRSMTd6UHd0bVFqMkpSVnVZTEVOTXhxcTRrZ2Nj?=
 =?utf-8?B?ZDMwdDBYZ05kS0NjbVNtRXdpTGlXMGxNakxsdnRyN3pPSkdGQ3NzVURkOUdq?=
 =?utf-8?B?WTk5NUQyN1BVNEJFOWpFM2c4L3FZV2JRNmhCaDVoTFBuaDJPNnI2MHppTlNj?=
 =?utf-8?B?bVdwTFdBeWd2ZXJzdUtrRTU5Uk1zUndJQk5meWxnN2R0MWdqNm5Mbk01ZVpM?=
 =?utf-8?B?eENTME9pbGZnZXVHWmtLdFVBU09heis5UlhHRlgxL0prRWNxcDdaVVJhZUxY?=
 =?utf-8?B?M0d5eEc3RCsrTTQ4Uk96bU83RHZnNmR4K0QwS2VzdXFKbVpYaWpLalFIZHRT?=
 =?utf-8?B?QWxVRmNyOTJtLzNQME83NlpqdXBhUndzK1FQMUo3YVpNUnhMTHYzSFZHNit2?=
 =?utf-8?B?RE84T3NJZ2VrbzEvWjVKenpOeWVZNWkvWmExYVZsTlEvS0s0dDQwYzlWVytP?=
 =?utf-8?B?RzlxbkVNRm5QMnZWTFNQMXhsZG5OTUFLWWJjZW9NMXZnR0JuQ0ZQMDRsWTUv?=
 =?utf-8?B?ckMwUXZUVHlGampPWkxScE1QdzlKeWxJY0lLemFIYVpuWXlyWkdkMlE2ek5Z?=
 =?utf-8?Q?gggAppxjAcPRPZ97Q9xvfZ3c0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4014de84-a73b-41d4-a0c0-08dacbcf2d0e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 14:46:31.5009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT72/LWVtXqEhYWsXnIw/aUX5olOO4XeJuGs1Tz90VY9Pg8O+yk1Mt1qwypNrQu1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
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


On 2022-11-21 08:18, Christian König wrote:
>
>
> Am 21.11.22 um 14:13 schrieb James Zhu:
>> When applications try to allocate large system (more than > 128GB),
>> "stall cpu" is reported.
>>
>> for such large system memory, walk_page_range takes more than 20s 
>> usually.
>> The warning message can be removed when splitting hmm range into smaller
>> ones which is not more 64GB for each walk_page_range.
>>
>> [  164.437617] amdgpu:amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu:1753: 
>> amdgpu: create BO VA 0x7f63c7a00000 size 0x2f16000000 domain CPU
>> [  164.488847] amdgpu:amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu:1785: 
>> amdgpu: creating userptr BO for user_addr = 7f63c7a00000
>> [  185.439116] rcu: INFO: rcu_sched self-detected stall on CPU
>> [  185.439125] rcu:     8-....: (20999 ticks this GP) 
>> idle=e22/1/0x4000000000000000 softirq=2242/2242 fqs=5249
>> [  185.439137]     (t=21000 jiffies g=6325 q=1215)
>> [  185.439141] NMI backtrace for cpu 8
>> [  185.439143] CPU: 8 PID: 3470 Comm: kfdtest Kdump: loaded Tainted: 
>> G           O 5.12.0-0_fbk5_zion_rc1_5697_g2c723fb88626 #1
>> [  185.439147] Hardware name: HPE ProLiant XL675d Gen10 Plus/ProLiant 
>> XL675d Gen10 Plus, BIOS A47 11/06/2020
>> [  185.439150] Call Trace:
>> [  185.439153]  <IRQ>
>> [  185.439157]  dump_stack+0x64/0x7c
>> [  185.439163]  nmi_cpu_backtrace.cold.7+0x30/0x65
>> [  185.439165]  ? lapic_can_unplug_cpu+0x70/0x70
>> [  185.439170]  nmi_trigger_cpumask_backtrace+0xf9/0x100
>> [  185.439174]  rcu_dump_cpu_stacks+0xc5/0xf5
>> [  185.439178]  rcu_sched_clock_irq.cold.97+0x112/0x38c
>> [  185.439182]  ? tick_sched_handle.isra.21+0x50/0x50
>> [  185.439185]  update_process_times+0x8c/0xc0
>> [  185.439189]  tick_sched_timer+0x63/0x70
>> [  185.439192]  __hrtimer_run_queues+0xff/0x250
>> [  185.439195]  hrtimer_interrupt+0xf4/0x200
>> [  185.439199]  __sysvec_apic_timer_interrupt+0x51/0xd0
>> [  185.439201]  sysvec_apic_timer_interrupt+0x69/0x90
>> [  185.439206]  </IRQ>
>> [  185.439207]  asm_sysvec_apic_timer_interrupt+0x12/0x20
>> [  185.439211] RIP: 0010:clear_page_rep+0x7/0x10
>> [  185.439214] Code: e8 fe 7c 51 00 44 89 e2 48 89 ee 48 89 df e8 60 
>> ff ff ff c6 03 00 5b 5d 41 5c c3 cc cc cc cc cc cc cc cc b9 00 02 00 
>> 00 31 c0 <f3> 48 ab c3 0f 1f 44 00 00 31 c0 b9 40 00 00 00 66 0f 1f 
>> 84 00 00
>> [  185.439218] RSP: 0018:ffffc9000f58f818 EFLAGS: 00000246
>> [  185.439220] RAX: 0000000000000000 RBX: 0000000000000881 RCX: 
>> 000000000000005c
>> [  185.439223] RDX: 0000000000100dca RSI: 0000000000000000 RDI: 
>> ffff88a59e0e5d20
>> [  185.439225] RBP: ffffea0096783940 R08: ffff888118c35280 R09: 
>> ffffea0096783940
>> [  185.439227] R10: ffff888000000000 R11: 0000160000000000 R12: 
>> ffffea0096783980
>> [  185.439228] R13: ffffea0096783940 R14: ffff88b07fdfdd00 R15: 
>> 0000000000000000
>> [  185.439232]  prep_new_page+0x81/0xc0
>> [  185.439236]  get_page_from_freelist+0x13be/0x16f0
>> [  185.439240]  ? release_pages+0x16a/0x4a0
>> [  185.439244]  __alloc_pages_nodemask+0x1ae/0x340
>> [  185.439247]  alloc_pages_vma+0x74/0x1e0
>> [  185.439251]  __handle_mm_fault+0xafe/0x1360
>> [  185.439255]  handle_mm_fault+0xc3/0x280
>> [  185.439257]  hmm_vma_fault.isra.22+0x49/0x90
>> [  185.439261]  __walk_page_range+0x692/0x9b0
>> [  185.439265]  walk_page_range+0x9b/0x120
>> [  185.439269]  hmm_range_fault+0x4f/0x90
>> [  185.439274]  amdgpu_hmm_range_get_pages+0x24f/0x260 [amdgpu]
>> [  185.439463]  amdgpu_ttm_tt_get_user_pages+0xc2/0x190 [amdgpu]
>> [  185.439603] amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x49f/0x7a0 
>> [amdgpu]
>> [  185.439774]  kfd_ioctl_alloc_memory_of_gpu+0xfb/0x410 [amdgpu]
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 49 +++++++++++++++++--------
>>   1 file changed, 34 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index a48ea62b12b0..fb51144ab77e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -163,6 +163,7 @@ int amdgpu_hmm_range_get_pages(struct 
>> mmu_interval_notifier *notifier,
>>                      struct hmm_range **phmm_range)
>>   {
>>       struct hmm_range *hmm_range;
>> +    unsigned long end;
>>       unsigned long timeout;
>>       unsigned long i;
>>       unsigned long *pfns;
>> @@ -184,25 +185,43 @@ int amdgpu_hmm_range_get_pages(struct 
>> mmu_interval_notifier *notifier,
>>           hmm_range->default_flags |= HMM_PFN_REQ_WRITE;
>>       hmm_range->hmm_pfns = pfns;
>>       hmm_range->start = start;
>> -    hmm_range->end = start + npages * PAGE_SIZE;
>> +    end = start + npages * PAGE_SIZE;
>>       hmm_range->dev_private_owner = owner;
>>   -    /* Assuming 512MB takes maxmium 1 second to fault page address */
>> -    timeout = max(npages >> 17, 1ULL) * HMM_RANGE_DEFAULT_TIMEOUT;
>> -    timeout = jiffies + msecs_to_jiffies(timeout);
>> +#define MAX_WALK_BYTE    (64ULL<<30)
>
> Please don't add any defines in the middle of the code.
[JZ] sure. can I have RB on this patch? Thanks!
>
>> +    do {
>> +        hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>> +
>> +        pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>> +            hmm_range->start, hmm_range->end);
>> +
>> +        /* Assuming 512MB takes maxmium 1 second to fault page 
>> address */
>> +        timeout = max((hmm_range->end - hmm_range->start) >> 29, 
>> 1ULL) *
>> +            HMM_RANGE_DEFAULT_TIMEOUT;
>> +        timeout = jiffies + msecs_to_jiffies(timeout);
>>     retry:
>> -    hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>> -    r = hmm_range_fault(hmm_range);
>> -    if (unlikely(r)) {
>> -        /*
>> -         * FIXME: This timeout should encompass the retry from
>> -         * mmu_interval_read_retry() as well.
>> -         */
>> -        if (r == -EBUSY && !time_after(jiffies, timeout))
>> -            goto retry;
>> -        goto out_free_pfns;
>> -    }
>> +        hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>> +        r = hmm_range_fault(hmm_range);
>> +        if (unlikely(r)) {
>> +            /*
>> +             * FIXME: This timeout should encompass the retry from
>> +             * mmu_interval_read_retry() as well.
>> +             */
>> +            if (r == -EBUSY && !time_after(jiffies, timeout))
>> +                goto retry;
>> +            goto out_free_pfns;
>> +        }
>> +
>> +        if (hmm_range->end == end)
>> +            break;
>> +        hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
>> +        hmm_range->start = hmm_range->end;
>> +        schedule();
>> +    } while (hmm_range->end < end);
>> +
>> +    hmm_range->start = start;
>> +    hmm_range->hmm_pfns = pfns;
>>         /*
>>        * Due to default_flags, all pages are HMM_PFN_VALID or
>
