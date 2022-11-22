Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF435C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 16:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F8D310E141;
	Tue, 22 Nov 2022 16:21:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E32110E141
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 16:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjf0XHZLPWpI8P92TOp2pI0simttbiFwtQd0O7osaDwcC4cJ0c3rXyweqrS3aOsH+th8OcoORrwkwBRl1zt5dncnNiIaBW/VH3Oa1gAgwyvi/ZQqePbECGuEOG1f8oYQMhfiICTwXxO9Jygj7qojpJxnOB0A8beTL1Qj3ymFkoYsw82z++iGtxoWcitgHQdWA/q4ylE+sOiU+9S4Wg5FsiblFec3e2Mej4iu6oAYxH/fgKOPa71gtWmqUSuB8/OUQcH3iOvG+tzQHlSxGI1u4FGvdHx7QB7j/PxU2JMYuWbNWRUOp9SV8N0/4mPKhGlTyc6PGluoU5cbMrmvgjObQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PccDPnX6vqfEGgEF8GX8e+WfKIsSrwE1wOm6Og2Pja4=;
 b=Jsz9khlfLDoKDtyMhklzCKdQKeiG/xHSaw4Nnu2B1r5H1mjvTua9mhOvCJTQF/7WhiMgZtDp9iX2Fx0CSWhCNFwedu0gY+hX7R/33X5asm8mBZ4gscsSTHVetSmpih226dsvbkghPR9prDACIUpUHR8IH569Qp+PVGouZoRHtDif+Iqv9UrmQmAwT1QxFrgLpgzZ7RJtsDU6r8a5e/CCJr0nKl6oi1WgB2/cQFsQXpAnrpxfCIKpOAqJXE7iVOj8OmOo5mBZbkl2HNvLkVUjF+3Obst0FbxPpcw4nqLBiJ1Q1oLoidvLjCgY+PsjXR2h79uNvEgP4X+aMCOBgDNYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PccDPnX6vqfEGgEF8GX8e+WfKIsSrwE1wOm6Og2Pja4=;
 b=niRjRAvoe6RAE/R2pwmrTvbLNNLC4kC5Z0jzS/i4iQ15LFM2FW8RGGkYFyTtQSHVDR2jhhbZ6DcPVtalJ55V+nMRqoITqWnsPNkDEYcl5lPIlcbUFe5+yVwyqvMFLW6FXss8F0y79HATthjiIpB915IjMh/02SAw+9K8IDFiKec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 16:21:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 16:21:18 +0000
Message-ID: <a09596f0-e44a-29f9-db02-e9d649140270@amd.com>
Date: Tue, 22 Nov 2022 11:21:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] drm/amdgpu: fix stall on CPU when allocate large
 system memory
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, philip.yang@amd.com
References: <20221117213829.24861-1-James.Zhu@amd.com>
 <20221121145312.125272-1-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221121145312.125272-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0062.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: 2297a8f3-e2b8-4cd5-1ade-08dacca595ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVMZ6tKA+c9XVFbLOoztuZ2KV4boYWhMsZdQdSliTthhTlHGiO0eDbpu2ruOP8NbmJ4Cmty8vZTZy9ogDZFAHr319EYmJ7IP5f680nwJRMrmqo7JpBEd4sm963qODsjHEF8aXfT4a7y+tr6u8lppD/PBwB3d+/7BoZP19nQNBojJpi7UKe7M7ehS8BFJnymxYQzdpnivwXeeDccDQphQBXtMJ8kX0HHG1VQ0o/gxF91DZ6B9OBVPKcHaXaSZxllrlvWkdTS+AuXkAgod7ymQky5xOW9ObqTq7gOcqXhO7pqY1Viq5w4PCTDbUIZtBUiBj0fuFi9DX6wnvN8x3zZY/kf3jUzyrkj2GsDv8tkvvlYRdkV4tCET9iVkPe0gz5MyYCTV+/rGT4hDma4QY/ZJ73uQmrS8oVx/vZdlyGKH1O8iYFtSb6ozTkSfVgnNUrJAWMuaRJsuYUJ57Xs5/bs8y0mZUMcuQSrl3le5f7z119dlRKrHXq5vxGC3pwWs+lNCPy+yfy+RjNWbH0U688H7rJXNTas5ehellFXbZKzXVmViahs79Us3Q1+/eeGv20lpsZgfkYsHxwd62w+vNeAS54yZp3UdA62yPlirk0Z5PfT8tO7aIn4VyNPP+WvSf8RNIgXSEFBuGIei2CjMJjoaqgM7h27XXe7O5XLHcjpGAqseyNyR/xcWIBLW/hPSSh4qG9F29aeMZK7ohT1fA838n4KfSDXGMHCbAZyoO0gIonY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(31686004)(36756003)(8676002)(6506007)(86362001)(31696002)(38100700002)(8936002)(66556008)(44832011)(2906002)(2616005)(83380400001)(41300700001)(4001150100001)(6512007)(316002)(186003)(26005)(5660300002)(66946007)(6486002)(4326008)(478600001)(66476007)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFVLbVBtWHhMMFB2bkE1c21yaTlhZWpwZ3FjdnBpQnJOVGJ6amJuMHJpcXJw?=
 =?utf-8?B?RmJoWFNiRnNBY3ZHSHAzSUtGcW1CWTNVQWFBdlA0UXdDYWpVQWx6REx4TzZz?=
 =?utf-8?B?aUxYOEl5WEI0Q3o2Uy9WcEphTzB1Q1ZLQ0Y0VE1NU2FQOUphUHFUV0tHdk5W?=
 =?utf-8?B?WDJaenVEZjUzRFFhcFEzQTVJcEJlOFBJMGplUnp2aC9Hc1c2bk5USFNzcHln?=
 =?utf-8?B?eHpGQUJaeFN1NTBGUzRrd3B3SVRHbzYvcUlFUmdwcGNnOERWOUd3bEI2dXMy?=
 =?utf-8?B?aDdBOTRQRzdHcUsvYTgrcjljUjYyTjNrMWMvQi80ekoxTGVxZFMvTm9lNGtH?=
 =?utf-8?B?M3pBK01qYkhjSlhaQzBUYlh1SUZqUGlPN095WGNpbFJkalhCWm1ENjlya0FU?=
 =?utf-8?B?QjlKMm9ubmM0Nlcrb0ZLc3B2RjlkUy9XYmN0OSs4SmJkOGFhd1duWWVVTW5E?=
 =?utf-8?B?eFJUM1ZucE1HZHIwM2pkU3IwS3VwMWJzV1R0RkRma0tCNG5TVVhJZ2ZoUXJk?=
 =?utf-8?B?Z1d4QXpxOFhkcnY0ZmlxN3VKWVdOSkt6c2tVVmR1b3JYWWFWa3VxVWVtU1RP?=
 =?utf-8?B?QzF5Yy9ObjZSKytsSUlCNW43SkdoUGVDdmI2dVNMVlNWVDJmQk5DNXJPZ3kx?=
 =?utf-8?B?bTE2eTR1anV0TFRnQ2NBdkl2Y3pFY2tmR212SFVLOHlsbjZtY1A4Rlh1emxw?=
 =?utf-8?B?OTFxTlVLU3BZMWxGTHpXdys1ZlNlUHpPQWl6M3VYckFPbDd3Q3BlaDNVZTgw?=
 =?utf-8?B?eVA2V0N0RlRxSVdOdlJtSGtUWExjM0Y4ejgrS3RzUkgranQvcDBRcTNsOWdX?=
 =?utf-8?B?d0RhWHB2S05GdnMyYi9uZHR3YWx5b2dSUnMrbjBZREtUU1VOZm1LVmFaN29J?=
 =?utf-8?B?c3ViUFBKWUI1aXZ3MkxqUVdkTVN3U3FRam95aktLcnZvK013OWFsSzdIb1pX?=
 =?utf-8?B?dktVRjBxaGRuckx4T3JwT3NKdFZEd0pqQjVkRlZSK0hkaGkyUnkzcGJoajM0?=
 =?utf-8?B?ZCtaQStwN1lPUE9zS2lLL1hCWkpxZmgwVkd4M21pVENEZUt3SU5nUlphYU5q?=
 =?utf-8?B?QjlwcDh3N0x1SW9TY0pEYnNzVnNnUzBGeFlEMXN0QnZRcGNXR0RYMjg0eE5C?=
 =?utf-8?B?QVYreUFwYWp2OE94Zk1CMTVXNTZHMW56MzhjdHdNaGdNVEFjZndxaVdRYVVZ?=
 =?utf-8?B?eW9sL0lldjNWeUVCT0NuQyswNGljY3BaWlNNV1kwenNuY3E2NDhta0lCcDRh?=
 =?utf-8?B?Y1hXSDJLakZTQ2NDQnFNT2p2MGhjdTVCdFJEOFJjNjNsMzAyR0hqVEVOWi91?=
 =?utf-8?B?MTgzbCtRaTIzVWxqclZuTUswQWwzNi9Ra0VmcVJJZCtTazV2SnlJcFhIM3VM?=
 =?utf-8?B?dmRYYzVGaVd0elFveGkxZUp3MWNocTdyOHllVEs4aGIrRWwwNGhGUkUrVXJW?=
 =?utf-8?B?VXJpL1RERlQ3QlFFeUNvemlGaGpPVkZwdEtKK0pDbmEyaFJKbTZ2REtWRy9H?=
 =?utf-8?B?MGhPZnJvbk9KdGZtUkNKdmhGQUFCSGNwZVd3TnliczZCRVExNDFjTVl1ZlV5?=
 =?utf-8?B?Qk8vMVhuVjl0RkpjMTEwVnZiUFFTa1hnRjhMeGV6VkZqR3lmeWc3RTdsc21M?=
 =?utf-8?B?WE9YT2EvK3h6bDhabnRiUVVkd3dEUkdXZ0pMcTRyRUQ2QU5VTWorZGxvaGZC?=
 =?utf-8?B?TUppd21HZFVSTmNzVnk2ay9KaEhSbDhuZHFKcis0WnVZc3laZ0YzNWJwbHdP?=
 =?utf-8?B?N2VLS0R5Y1NMYWMwR3VVVmgzMms4akFET2M0Q3JPYW1ZK2oxaXV4MjR6YmlU?=
 =?utf-8?B?djdiU1NGZjhVSUZnSGVzSEhqbyt2d0ZFWjN0WkFtcXVtRDNDMW95aWxrbGpn?=
 =?utf-8?B?NEkrOUkrb0NHWjBTUVplR0RpSlNXRWVRTzN3MHNZZlo4djhVa0dnVDdRMmxm?=
 =?utf-8?B?V1lJTzRCekJpbC9XbzNraEJ0ck9NWjVJRlFUZDlkUE9ybUpNQjUxRDNqVWZY?=
 =?utf-8?B?U1labWFWVGFRWU1GZkdhL1NycytyTmpvZkZyN2RiOStaRlpWVTZPaFJFRmNF?=
 =?utf-8?B?eHBIdmthdUlJc1RCSlpCekIrSHpZMTFOdEIydmZBa0Jja2lWSEljNjNTa2gw?=
 =?utf-8?Q?wHYsRzq8d0hfK1ZWkbep3lxyW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2297a8f3-e2b8-4cd5-1ade-08dacca595ef
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 16:21:18.8022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxfEgRcnDkbNeInd1qmTxRVhONK+COAY6gtU+L+3Hu/zGa13lnto24J0HP8GAHsdGvVx101JalTJ2FO6IQEaiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-11-21 um 09:53 schrieb James Zhu:
> -v2: 1. rename variable to redue confuse
>       2. optimize the code
> -v3: move new define out of the middle of the code
>
> When applications try to allocate large system (more than > 128GB),
> "stall cpu" is reported.
>
> for such large system memory, walk_page_range takes more than 20s usually.
> The warning message can be removed when splitting hmm range into smaller
> ones which is not more 64GB for each walk_page_range.
>
> [  164.437617] amdgpu:amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu:1753: amdgpu: 	create BO VA 0x7f63c7a00000 size 0x2f16000000 domain CPU
> [  164.488847] amdgpu:amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu:1785: amdgpu: creating userptr BO for user_addr = 7f63c7a00000
> [  185.439116] rcu: INFO: rcu_sched self-detected stall on CPU
> [  185.439125] rcu: 	8-....: (20999 ticks this GP) idle=e22/1/0x4000000000000000 softirq=2242/2242 fqs=5249
> [  185.439137] 	(t=21000 jiffies g=6325 q=1215)
> [  185.439141] NMI backtrace for cpu 8
> [  185.439143] CPU: 8 PID: 3470 Comm: kfdtest Kdump: loaded Tainted: G           O      5.12.0-0_fbk5_zion_rc1_5697_g2c723fb88626 #1
> [  185.439147] Hardware name: HPE ProLiant XL675d Gen10 Plus/ProLiant XL675d Gen10 Plus, BIOS A47 11/06/2020
> [  185.439150] Call Trace:
> [  185.439153]  <IRQ>
> [  185.439157]  dump_stack+0x64/0x7c
> [  185.439163]  nmi_cpu_backtrace.cold.7+0x30/0x65
> [  185.439165]  ? lapic_can_unplug_cpu+0x70/0x70
> [  185.439170]  nmi_trigger_cpumask_backtrace+0xf9/0x100
> [  185.439174]  rcu_dump_cpu_stacks+0xc5/0xf5
> [  185.439178]  rcu_sched_clock_irq.cold.97+0x112/0x38c
> [  185.439182]  ? tick_sched_handle.isra.21+0x50/0x50
> [  185.439185]  update_process_times+0x8c/0xc0
> [  185.439189]  tick_sched_timer+0x63/0x70
> [  185.439192]  __hrtimer_run_queues+0xff/0x250
> [  185.439195]  hrtimer_interrupt+0xf4/0x200
> [  185.439199]  __sysvec_apic_timer_interrupt+0x51/0xd0
> [  185.439201]  sysvec_apic_timer_interrupt+0x69/0x90
> [  185.439206]  </IRQ>
> [  185.439207]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> [  185.439211] RIP: 0010:clear_page_rep+0x7/0x10
> [  185.439214] Code: e8 fe 7c 51 00 44 89 e2 48 89 ee 48 89 df e8 60 ff ff ff c6 03 00 5b 5d 41 5c c3 cc cc cc cc cc cc cc cc b9 00 02 00 00 31 c0 <f3> 48 ab c3 0f 1f 44 00 00 31 c0 b9 40 00 00 00 66 0f 1f 84 00 00
> [  185.439218] RSP: 0018:ffffc9000f58f818 EFLAGS: 00000246
> [  185.439220] RAX: 0000000000000000 RBX: 0000000000000881 RCX: 000000000000005c
> [  185.439223] RDX: 0000000000100dca RSI: 0000000000000000 RDI: ffff88a59e0e5d20
> [  185.439225] RBP: ffffea0096783940 R08: ffff888118c35280 R09: ffffea0096783940
> [  185.439227] R10: ffff888000000000 R11: 0000160000000000 R12: ffffea0096783980
> [  185.439228] R13: ffffea0096783940 R14: ffff88b07fdfdd00 R15: 0000000000000000
> [  185.439232]  prep_new_page+0x81/0xc0
> [  185.439236]  get_page_from_freelist+0x13be/0x16f0
> [  185.439240]  ? release_pages+0x16a/0x4a0
> [  185.439244]  __alloc_pages_nodemask+0x1ae/0x340
> [  185.439247]  alloc_pages_vma+0x74/0x1e0
> [  185.439251]  __handle_mm_fault+0xafe/0x1360
> [  185.439255]  handle_mm_fault+0xc3/0x280
> [  185.439257]  hmm_vma_fault.isra.22+0x49/0x90
> [  185.439261]  __walk_page_range+0x692/0x9b0
> [  185.439265]  walk_page_range+0x9b/0x120
> [  185.439269]  hmm_range_fault+0x4f/0x90
> [  185.439274]  amdgpu_hmm_range_get_pages+0x24f/0x260 [amdgpu]
> [  185.439463]  amdgpu_ttm_tt_get_user_pages+0xc2/0x190 [amdgpu]
> [  185.439603]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x49f/0x7a0 [amdgpu]
> [  185.439774]  kfd_ioctl_alloc_memory_of_gpu+0xfb/0x410 [amdgpu]
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 50 +++++++++++++++++--------
>   1 file changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index a48ea62b12b0..8a2e5716d8db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -51,6 +51,8 @@
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_hmm.h"
>   
> +#define MAX_WALK_BYTE	(64ULL<<30)
> +
>   /**
>    * amdgpu_hmm_invalidate_gfx - callback to notify about mm change
>    *
> @@ -163,6 +165,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       struct hmm_range **phmm_range)
>   {
>   	struct hmm_range *hmm_range;
> +	unsigned long end;
>   	unsigned long timeout;
>   	unsigned long i;
>   	unsigned long *pfns;
> @@ -184,25 +187,42 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   		hmm_range->default_flags |= HMM_PFN_REQ_WRITE;
>   	hmm_range->hmm_pfns = pfns;
>   	hmm_range->start = start;
> -	hmm_range->end = start + npages * PAGE_SIZE;
> +	end = start + npages * PAGE_SIZE;
>   	hmm_range->dev_private_owner = owner;
>   
> -	/* Assuming 512MB takes maxmium 1 second to fault page address */
> -	timeout = max(npages >> 17, 1ULL) * HMM_RANGE_DEFAULT_TIMEOUT;
> -	timeout = jiffies + msecs_to_jiffies(timeout);
> +	do {
> +		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
> +
> +		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
> +			hmm_range->start, hmm_range->end);
> +
> +		/* Assuming 512MB takes maxmium 1 second to fault page address */
> +		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL) *
> +			HMM_RANGE_DEFAULT_TIMEOUT;
> +		timeout = jiffies + msecs_to_jiffies(timeout);
>   
>   retry:
> -	hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
> -	r = hmm_range_fault(hmm_range);
> -	if (unlikely(r)) {
> -		/*
> -		 * FIXME: This timeout should encompass the retry from
> -		 * mmu_interval_read_retry() as well.
> -		 */
> -		if (r == -EBUSY && !time_after(jiffies, timeout))
> -			goto retry;
> -		goto out_free_pfns;
> -	}
> +		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
> +		r = hmm_range_fault(hmm_range);
> +		if (unlikely(r)) {
> +			/*
> +			 * FIXME: This timeout should encompass the retry from
> +			 * mmu_interval_read_retry() as well.
> +			 */
> +			if (r == -EBUSY && !time_after(jiffies, timeout))
> +				goto retry;
> +			goto out_free_pfns;
> +		}
> +
> +		if (hmm_range->end == end)
> +			break;
> +		hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
> +		hmm_range->start = hmm_range->end;
> +		schedule();
> +	} while (hmm_range->end < end);
> +
> +	hmm_range->start = start;
> +	hmm_range->hmm_pfns = pfns;
>   
>   	/*
>   	 * Due to default_flags, all pages are HMM_PFN_VALID or
