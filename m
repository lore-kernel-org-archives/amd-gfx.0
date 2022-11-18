Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C46C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 12:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B34610E1EB;
	Fri, 18 Nov 2022 12:23:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2858010E1EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 12:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICIAEp3cyvBlyZL8CPVBgM6Axbszt8M7sHzJQA75OjouMKZJTJtYEtBaAsFe15VKVCmx4uBAG1lJT20gPc1XQQqxpGz5x+9g2XJ0pyCYOfw4YKXUHUPmEx/NB4X27W295GNVpDoer/3qmqp6t3YdA1Lv9EApbhD3tlSDA/u7QFp4uyXNGj9ipbTyazmE4vG5K2mxvTFnCNK0n2hBRNsTWD2Xvgqbnqi+JOX+t6Qb0Y1PhukkcxCDtv7JzzuLw50+IGTqiflShn7/pX+YzEo8hd+zveFbTnSKCpKY+rzoro2mM69jzNaOuSu7fV0THqgoLuFr9aR2mzmJ1mCUtLgeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/BhVCO9xeMDzBZDqy3enNRz9NmYJXsJy9Gd6BqvcOg=;
 b=f/uG67Mb0k46PT7+Tz82ZXMY1ln4FIl1+BxuOCHd7BZubgoQtrpL7G7/tfpXVhnGdybToW2wLhj04UKy8OpL5B4CWCbmd61Q9zbw+ZgTDnir9XD05NKZZyz1uSk2X2OsGANdvh2bQPQCFAuke6SsruU99JxijZwvritB5d3Ft4sSRXlBu2pHm+5hyq7YzadEcSlcNGixFmCAs9Jek2jVmjUvRx3MD8eWRHbwGYsv0QeaRx0o3wx+ztQsIzx6MBxHWVeh8YY1AArB2uMMElmVVDaclFPloE4Hc5q5UE0C0WlzuyE5ZWUXpqQ9jCc7ay2aNdcU9qyBtQ3zy/e8plxeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/BhVCO9xeMDzBZDqy3enNRz9NmYJXsJy9Gd6BqvcOg=;
 b=lcU09hGt00Tfj5p0e/KNW2QAxVlLi1YoeFCqXGjp7+H/UyqTO1PJBA2yB/G6LM0xTK7SFgjP6SNZlPtFyAvfWeR8OEOI5STs5+nHzVcNX4n31vUW9g4fKVobtXhLseBYB4rjC+9vELZmdlFfkshN7mOFwVZZV4nuzwgF7Vddzx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 12:22:54 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::a425:7531:6b64:db42]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::a425:7531:6b64:db42%12]) with mapi id 15.20.5813.020; Fri, 18 Nov
 2022 12:22:54 +0000
Message-ID: <a8e115cd-acba-29a1-1020-4bb653d03bbc@amd.com>
Date: Fri, 18 Nov 2022 07:22:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: fix stall on CPU when allocate large system
 memory
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, philip.yang@amd.com
References: <20221117213829.24861-1-James.Zhu@amd.com>
 <59748ca8-9dac-e983-95a8-5b5b4c0a3946@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <59748ca8-9dac-e983-95a8-5b5b4c0a3946@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:610:118::24) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_|CO6PR12MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: 561adfd8-1b4d-4d51-eb7f-08dac95f9d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuXZNe9CAgTmymXRS7IkboZMIQ1eJJvjAUOBcOzQrUgm3ixRHOsDnHMj6ZTLwOWL+gOWkWIRxfyAgJZAgjAFORGZ81/c84GmijUXUnao9kOZLmQwOmKPLKtLQGb6vZc4NPqY/Fg8quMKtphJRJez2J+d/fDNUjxSSXxTA9nxlFuXczcXac07c9DYPw+ag3YVr9qPkNWkFF+05HblFh6D35ZXJBumebiE24RNJwmTM4O4T6ys+AdJfGI8vQ1iC1ssqeSn8p8MChtTSQECNbXROt1QbBU5PjN1kA7PoSdXgfq5hGfNVwWaujvsaiKxQw2+m5W2zZkrx9fvCgdJAFFef41IEfpFwnoDX+acW+Fa196gXvCWW81gZCYg1ZdWGucrGmCNVflPYXq/hVgYSS8qU5snjBbUvz0etj3wu7prd5Zm2bXOk/ncxuqyrOqtZX1uc/LZSMu5n+loK3k60COpdBIwthx/bY8Xyo9F6dd/pNtHPX5tIpZdQJJMA1/rFeolWf9DFth3TBKGQZaIa0D8MRrnWl+Qc/eAu45ip9Ocsj0q8ISC5bEbFeOQ5Sap0AAlOMR8rM1JGQKLth5ZQsthYs1N7p5vE1vo1hFCrQDUxA1tdM52iEga7UQAU8dpw7cWpnyDJ6S9yHQIhusEcXWB8kc0MFONM86IkU0UFlYNQNxB5tKAF9fV72QKWZyahHcpikQL903j5hA/h7uNvM5/DwICzd9+WvPuqv1d+x0ntmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(478600001)(36916002)(31686004)(6666004)(6486002)(41300700001)(8936002)(2616005)(66946007)(66476007)(36756003)(66556008)(8676002)(26005)(6512007)(6636002)(5660300002)(186003)(316002)(110136005)(6506007)(53546011)(83380400001)(2906002)(4001150100001)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ZvcFU1R2ZFS2xKdjFDdUdOSDRaQmN2S1ZUODhEUGE3ZG1senVMQjQrcnNX?=
 =?utf-8?B?emJTZWtycUVlT211TkhsMjNiSncxUWt5T2hrNVFacmtSaEJhNkwxRWYzSWhB?=
 =?utf-8?B?ZVlWRkpOY0gxaksxanlyMm1rajBON0NqRkQ0aUJ4bHRIY05zeHBRdHVjTjBt?=
 =?utf-8?B?TVVRMGR0dnZuR0ZOcytxNjVFK1BmbFNKOFZDa2lybFgxOVQvSzA0T3JWK0JT?=
 =?utf-8?B?dHUyU1RmMXY1TCtreE9sUU1VaThNdEJXUUpQMzNZajgwVXJqTytlL3ZxNkRu?=
 =?utf-8?B?aDRkNGc0eDIyU1RpYjdvWXB1R3JsSUVIZGNhZm1QOGVMbDNPM2VZZ0NHWEMx?=
 =?utf-8?B?c1lBcjZ3OVkxNWJ3YU5FWXViN2hkWGFuRDNuQ0VTcSt4cmhWNkJhcnByUDdl?=
 =?utf-8?B?bGtlOWxWMlhwT0hNTnR4WmwrSzdrcEl5V1Y3RCtMdVdZOS9wUDAyNlFtTTdK?=
 =?utf-8?B?QjJIV3pSYzN6WXJPOG04SmpXTnpzRlgwVXZhZVVJbjQ1aUhZUFhvWlJ5NHNH?=
 =?utf-8?B?NGhpS0FQcGFiOERwbzVGOFk2dU5lQ29qVkJyZnhNYnNvZThiazA2MmlQV0Vs?=
 =?utf-8?B?VE1nTGRyY2NoUGJXSTZBYm5FV1c4MW9KbnI0ZlRGaXFuNFVFYmxUVU5IUHRu?=
 =?utf-8?B?NmdXeTZBZC8wZ0pNemNlL2Y3aSt4a0lIMHV0cmtXUkczTlFySFFKaHZDUGh5?=
 =?utf-8?B?UFVVaE8ybUdSaTVpNnBFMTFBSStMVXVYbmFEZWtoaU42UHpHeXZVQXdUbk1T?=
 =?utf-8?B?Y1M5N0F1aGJBUE1saDFUNUJiTWNMYldrS2g5RkVkZjlMbXNqaGxjSkZNczgw?=
 =?utf-8?B?cGhGYWM2R0xmRXYzcDJSeWQ4YUEzUDdDeW1ySlRJdjQxQlY2cnVTaHFkZ3BO?=
 =?utf-8?B?SnUwV1p2bTkyL3M0SDhoZkdmY0FTbWtKWktrazBDRFpmUlFOVUN4WjBFMnVz?=
 =?utf-8?B?UUlVb3kyNzlSTWVTWUQ4aTg2QVVlLy9CcThHZWR6L29rYlZKcTNkSEZHTGtj?=
 =?utf-8?B?N1BDdFpZdnVSdjE3Z2JvblRtdzhCcG16ZW00T0d2MjlLVkxNK0V1OEFnT1lm?=
 =?utf-8?B?OHZFcVVhbFdzK2ZhbXJCSWV4U2ZETSticGY5bjhlWWdoQ09Vb2lNMy9PSUdq?=
 =?utf-8?B?WEpLUnVSQStvMEJTZzA0VUZLRnFJQkYxcnVqTytiZEh0T0k0R2gvc21Zdko4?=
 =?utf-8?B?SUZuRFIvTmtQYnlLeVBkMDByTDdvNEg0bUlHdE9qZklUMGNHaWd3VTR0WUhE?=
 =?utf-8?B?MWhVbUM0MjBpVXNoRmxYeW9JTS9UTzBkdy9HN01yZVhCWDlTelFpblYzOW1R?=
 =?utf-8?B?YXNxMm43TzdoTnBPdUszSXpKbzFmb21pVGFvQk9Vdm9kK2h2VlYveEZVdVdY?=
 =?utf-8?B?aVd4UUNCUDFzVllRaXp4S2lxQ1Y0a2xzTm15NWp2WkdqQ01WK3FJdFRZVFA5?=
 =?utf-8?B?d3Z3QmZLMk81UWVsVXJ3QkVGTHdwb3JDZDJER3VkVnM1cUZKam5DYzRVS1hU?=
 =?utf-8?B?dy9QdDFxN2hRMFlnZWhMdTJmZlM4MlMwSjFZS1Z2M2gyc2JQRUFLazFIU2Rp?=
 =?utf-8?B?MWtxSVl5V2xrNm9VZEVvM3g4MnFPNi9FS3h4SEdWbkNta3BSSGJ0UEVVc0g3?=
 =?utf-8?B?cXJFRkFHbW8xMWw2SnlNdURsVVo2MXIxVXROVHJqRjFLWjJxb1Y2bjJpT0sv?=
 =?utf-8?B?bVpHa0xIM1RqOTZDY1JTa3RxbnNibnVTZE1JSzJLS3E0TE43YTBRKytNdWEy?=
 =?utf-8?B?MUdkTGpqZUFLQzNZOGxMWXorUGdrMURGMmhRdXZOOEt2N0VKL0hMS2JEZndH?=
 =?utf-8?B?dlZrL3ZmSytqMDBVZWtodUgrRG9udlRPVFlOcThtZkRMOEs1R25HS2pkaFpY?=
 =?utf-8?B?b1RvQlhBKy9jSGhLTC9oVWxNVHZzY0ptRkVJcjlDNGsrYytJQWxIcnpBZncy?=
 =?utf-8?B?cFpXSnhsOVRDd0ZWNys1YlVYSWc0UWROVUlSYjNpNWhIUittODZYaEpTbmRr?=
 =?utf-8?B?YmluMXJnYW1KaHBpUHR5d0ExVFdPN01reVlWek1rUitXR2w2eFV0QjgrY0U5?=
 =?utf-8?B?TGNiQWhtVkNMMkZuMlJXRkgySDB4cHBrYjdmTU9MWDlCL29KcXZVY1BncGdj?=
 =?utf-8?Q?ZaM1WB+P37WKrg3/y8E87cDl1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561adfd8-1b4d-4d51-eb7f-08dac95f9d86
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 12:22:54.5473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNxajbG6EfiTK4sRO1MU2u9EobQJRVI46nONV7BT5QZWvfI632L5aE8Z8Ylo0IGp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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


On 2022-11-17 17:03, Felix Kuehling wrote:
> Am 2022-11-17 um 16:38 schrieb James Zhu:
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
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 47 +++++++++++++++++--------
>>   1 file changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index a48ea62b12b0..0425fc6a49aa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -163,6 +163,7 @@ int amdgpu_hmm_range_get_pages(struct 
>> mmu_interval_notifier *notifier,
>>                      struct hmm_range **phmm_range)
>>   {
>>       struct hmm_range *hmm_range;
>> +    unsigned long hmm_range_end;
>>       unsigned long timeout;
>>       unsigned long i;
>>       unsigned long *pfns;
>> @@ -184,25 +185,41 @@ int amdgpu_hmm_range_get_pages(struct 
>> mmu_interval_notifier *notifier,
>>           hmm_range->default_flags |= HMM_PFN_REQ_WRITE;
>>       hmm_range->hmm_pfns = pfns;
>>       hmm_range->start = start;
>> -    hmm_range->end = start + npages * PAGE_SIZE;
>> +    hmm_range_end = start + npages * PAGE_SIZE;
>
> This variable name is too easy to confuse with hmm_range->end. I would 
> suggest calling it "end", analogous to "start".
[JZ] Sure
>
>
>>       hmm_range->dev_private_owner = owner;
>>   -    /* Assuming 512MB takes maxmium 1 second to fault page address */
>> -    timeout = max(npages >> 17, 1ULL) * HMM_RANGE_DEFAULT_TIMEOUT;
>> -    timeout = jiffies + msecs_to_jiffies(timeout);
>> +#define MAX_WALK_BYTE    (64ULL<<30)
>> +    do {
>> +        hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, 
>> hmm_range_end);
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
>> +        hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
>> +        hmm_range->start = hmm_range->end;
>> +        schedule();
>
> We don't need to schedule for ranges < MAX_WALK_BYTES. I guess these 
> three lines could be conditional:
>
> +        if (hmm_range->end == end)
> +            break;
>
>         hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
>         hmm_range->start = hmm_range->end;
>         schedule();
[JZ] Yes, it will be more accurate. I will update it. Thanks!
>
> Regards,
>   Felix
>
>
>> +    } while (hmm_range->end < hmm_range_end);
>> +
>> +    hmm_range->start = start;
>> +    hmm_range->hmm_pfns = pfns;
>>         /*
>>        * Due to default_flags, all pages are HMM_PFN_VALID or
