Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01B8C43217
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 13:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0EC10E0AC;
	Mon, 21 Nov 2022 13:18:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D1E89FA5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 13:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6hAHUgr6gmP5d2mHoKkdnGEXLF8Ujigi7ZdSenNl17nZErHzbUziuY59xtFd+CoGFS4bv2BAT1OBXkazWXroHcIIoF1Audx9Ie2qKy2FovB69Yc/BfdQzkUaxB2TU8+UWxihnQds1lrHtAcEuIbx/K+3Dpz3Uy9SboOUsy9FTfeMnQZZHkzyObLciZdgW7Q8VneGmRgxEWdsEwDMl1sXo48Sbq49lotFq2Z1zuvSKMXgrHrX9cZvG+YG9V/4ceksfFDF4lrmsKZ0GT5btMQLdqbWhG7vlJaEooKGAt1+c0w3clHTknCRFGF+oLDNHG7ROQtOxLagsChx+QV37E77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J30pe44hTilO8yscgxmC6HLCziGT+PeSz7ZVlL3v3D8=;
 b=Z3tNrfv2YYKfF2mQfnBvu6cOek255uQgByZNmoWNdZB2ZY6k8S7m7jn/A0YJXihv2px0+Q24taMHGfhJmt4LVC80I7+cRD8ks40OJrqD4mJ2TSN22cdPPmoz364gAPstx7nD1g77qGHvTBpUkDk/jvyEski+8+7y5QJTmCopPpTVFhU3lPvs6vZoL6hoZbQvW7ybBZp6nr0v4IIszS/HfcFHSsEujW1GaaljXD35ZhQbJI3lOFTG2hoM7UI9BO3y4Q+QBxd5TlOQA4aErWBEU+Yoe1BO0BjYJkI2I1OZ0tdnhyH603/B5EVt569WBvUdxT3bTdwTq2v348eLJ/s0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J30pe44hTilO8yscgxmC6HLCziGT+PeSz7ZVlL3v3D8=;
 b=b4PhMcjAoQHHH2gsZpfTF14v9ItvsN0wlm6IPxiUWgXNz7GMzZojWTAxNu1X2Q96z6I49yJJYNXul4d4tDO/O08pv/yCbDOSpiatGID+yFuxVyivRPy5soSFzyqyoo7g8Bc/kXIXfq+44gr1skKqIHOcPRHSdW4WM9W+Hc6PfWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 13:18:44 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 13:18:44 +0000
Message-ID: <950574a1-ca9b-c99c-fd9b-8fed2105a043@amd.com>
Date: Mon, 21 Nov 2022 14:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] drm/amdgpu: fix stall on CPU when allocate large
 system memory
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.kuehling@amd.com, philip.yang@amd.com
References: <20221117213829.24861-1-James.Zhu@amd.com>
 <20221121131356.119508-1-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221121131356.119508-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: d74f12d7-633c-4bfe-a2f6-08dacbc2ea6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8frRbw1AZ15jjCkQY2OyBt5uyXmP9mdTYqYUF2ykhCjhF79BO4OmqGoRILncLhPQ3NwBX6CcU0rKolMEqahlNov5s96pNPRHk6yf3V7wHAZMzGH9XpC5j8NotMROp48lKNl62dV6CkpgmJ327tDMT7EKm3lLSl7+JcgUcGJgPHJzff5Ayqbw9pCGeR74UOTnBag6IkSShdbnK31Wo12Uiiy6qKMVmS8oneT1VwQNdUehBeVvarowUqmnpVo30MV4vQ35Zws/tV74NWKbp1G3sM56jAAm2sUbkWYRQYFYhAilS/WrTMYuodXnGJU/T7ca5gSSQTz88eCd9gDCNU6kf/Zo4bLhbBsRjzQpIjQTP4pkby4ihKtH3FdssVCfKlJ4goVFiVZP/ThiLNgS5iZ1uW3ASzqSZgrW1Xbdpf6o4Pjcl4KL2fPXh4S2GEGS5qBC06bAf/FXVay336lLcvMgbSbgkIO47/pWwyIiKi6vXJlfEYphPtqck0C+ZQQnkF2GaxmInrBGFeMks8vSIt0q0cD4gQzbDyaqkAQATAATC+fncb1Y+OAv2FmS/4nYAb3Deu11bq7saHjr4bcb1pMNYuvj3nsKTCZ3mdZjD1Z/Fr6LWVciO57qmgNABrrvxAtSmHFtLW+MIW4E3EUWVHt9wl27IBxwuqK9igbGcfLnbTj95iE4R4p0cp0io9P7TrqMrLGzHKY5nM/+2Mwyx1JBm9LPfIAhayAYetTKTXfQDx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(2906002)(2616005)(478600001)(186003)(41300700001)(8936002)(8676002)(66476007)(66556008)(66946007)(83380400001)(5660300002)(6636002)(31686004)(4326008)(316002)(31696002)(86362001)(6486002)(38100700002)(6666004)(36756003)(6506007)(26005)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzdXdFY2V1U3aUJKbUJ0NUJCQjc2MXE5bE1EL09ZSDloYVRXbVFFKzl4aU81?=
 =?utf-8?B?RkdOdGtvdGFoTGV3YkJ0N0Zma0JFQVV5M1pRM3VHYmRselh2VHo2ZlF2MVJG?=
 =?utf-8?B?QnRaT0ZsY2hwMENHVG9vZkxtZ1c1YUl2OW5TK1Zwenp3aU9XY0ZHeFFUQlha?=
 =?utf-8?B?NTZCcnkxTnBqc0ZwcHZpZHhNVkxVeSt6RE9BS0t4c0xUU041cFRWZWlOTGF5?=
 =?utf-8?B?QkYrRE9vQ012UXgyZEwyZ3BrdXA0TEtidmx5eHpFSUlvb0UzaUdybGpGK2px?=
 =?utf-8?B?SWRaZFlOZ0o3MHowc3NrZ1YwNjRGaXJwV09aTzhHMm9FSTE0OFViTGVCc0RR?=
 =?utf-8?B?VlNwek0zR3U4UC9RbG1YR1h5b2xHRUlwV0taRWFMLzJXYnRpcHlNbk5OMmRD?=
 =?utf-8?B?Qjk1REoreFVRRW9mS2NvRnZUWjhWWThLU0Q1YkJiZjh5Rzh6Zlo0YURtQnZU?=
 =?utf-8?B?UFJvREU3STQ2UEE0Vk5Ca216WlMyUEM4ZWExeWhHYzIycFVKQ2IyeGF4ak50?=
 =?utf-8?B?NjQvSW43U0tiak9mMnRWU2xxejJaWjFtYmxNQmZvdTlYSUZSWEE4OWhqSVhO?=
 =?utf-8?B?c3VKN2xOZHRHVjFlaHgyV3VsT2RNSHoxUzA3NFRlMTFrZ0pDQ2EzaHhpUXJO?=
 =?utf-8?B?eHFLVkJNeG03TkdKWnNkWVFrdGNMcG9IWXZOMFZOcml1UWd2UlZrOHRrYldz?=
 =?utf-8?B?N3ZOYStoWXo4d3ovZVg2emllTHZpU0M1MEtPTkV0Sk1Ub3oxUnozSHFJVlBy?=
 =?utf-8?B?dUdQVmJkZzJhSFBlN1RzdjU3dFFQNmJCaXpZc2RuV0FIY1ZNVURMV0NJVlpH?=
 =?utf-8?B?UkdETW15VjZsNzJNVWx2RGxwVDk1MzhYVHZjblZGS1dpc3JLeFdoVUphZ0pm?=
 =?utf-8?B?VEFJaTVBYUNsUUhSR0Fxb2VKRENLckpVTitVM0RnRjB3SkpHcEJCOFhzcVlU?=
 =?utf-8?B?bS9QcXhUMUhOZzQyV1E5ME1vZG13VDd0Y0VMczRsc2RnM3BkRGRpQWsyRVRr?=
 =?utf-8?B?c2ZqcUcyUG5ER21oL3dKWFRmY2QvbFJBdjNnNExqRXU2Ujg3clRmL1JBeTRn?=
 =?utf-8?B?dHMrVGxMcFVSYjZiT1BmeEp5TWxEcUU2SnlqRGxaUW5mU2VZdnNyTGJFTk5R?=
 =?utf-8?B?TnF2Sk5NR3pRbU1WdzQ3d1gvNHJ4d09jNVRqMEhxMXVhVEd1K1ZXUVZwOTI5?=
 =?utf-8?B?MVpMQmhEYjRaTDh2KzlBRTE5cS80cnVybGVNRzViS2lReGRCenVKNU5ZYTFL?=
 =?utf-8?B?bHhUaFJhRnhmOFdZNzVueDdrbnB2VzJJZnFyTGE4RFhDZDNzR2pNa0VBTm9o?=
 =?utf-8?B?aUpPa1o2T2p6cU1Sa3hMZnQ4cFgydUVxNUZGRHpwRFpIb1E4MkhBK3FFbWhI?=
 =?utf-8?B?RXU0d0U4S1RqMnFBTG56b2xXZ0YveFdvWmZ2TVRML3Q4RUFuYjJuMWhzZXhH?=
 =?utf-8?B?Y21uQ2FuK1RaMEExVXBWL2VGajdkWXJHQnY2c1FjQzE0Y2xUN2hrOGpIK21l?=
 =?utf-8?B?N3U5bU9Ob1VuM3hheWJPN1ZRRDdvblJpV3RMcys2OXdQNkJibnFULzliODcv?=
 =?utf-8?B?dXZNUGM1SWtQaUpZb1dXT2NoSDdDU0dCQVgycE1PU0g3QlJ3TGg2cEkwU1d5?=
 =?utf-8?B?eGI5VjJYbis0MFRWSXlTMXFiKzVDTTd1S25kWTU2VnRXdjhMU2tuUVFOdGE0?=
 =?utf-8?B?Z2R5eHNJbjZFcTZ4TzZXRmkyL2tvcWVpaXNoN2hpb0ptL004dHVNTjV2bGhk?=
 =?utf-8?B?OU8yVDFTMzVDYjU4MkJNakJVRXUwc2tYSFc2UmovY0lQZU5kUTV3MXhwNFpr?=
 =?utf-8?B?VVc0WnlPS0FaZFRWWnFxZ1YxQVRQWWtjVEt1U2J2Yk5USHA5SGRIY3Q3UFV6?=
 =?utf-8?B?T2cyc0RaTmFOTHlTMlBrVU9WSDU4Y0RjSU1PZkxHOU9Bam81eHE3cTdxMWJh?=
 =?utf-8?B?b29HcDYvcEtrbk9mNThqSFgwK01ZZFYzZHFxM2FtekNhVmttWUtUR0xxL1VK?=
 =?utf-8?B?MXZTL2MvY01HTWNQL1h1alBFRHM3cWJnRWFVOTJPazNSbHlLLzFwbFErdGh5?=
 =?utf-8?B?aFBUSnZGR1Y0akpjb0dlRGxwaVA3RzJmOEhtQ25ENVVEeGp5QU12b0pCektR?=
 =?utf-8?Q?JXkk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74f12d7-633c-4bfe-a2f6-08dacbc2ea6f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 13:18:44.5968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gi0DFRpnuJRWF0/9ud/dY3E6PGxw98763Uar3H7j3tVAe21Niv1i7gRDJh/uM1Yz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
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



Am 21.11.22 um 14:13 schrieb James Zhu:
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
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 49 +++++++++++++++++--------
>   1 file changed, 34 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index a48ea62b12b0..fb51144ab77e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -163,6 +163,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       struct hmm_range **phmm_range)
>   {
>   	struct hmm_range *hmm_range;
> +	unsigned long end;
>   	unsigned long timeout;
>   	unsigned long i;
>   	unsigned long *pfns;
> @@ -184,25 +185,43 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
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
> +#define MAX_WALK_BYTE	(64ULL<<30)

Please don't add any defines in the middle of the code.

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

