Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C66C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 15:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0951810E408;
	Tue, 22 Nov 2022 15:12:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF15610E404
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 15:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrA3vImN2FRo5jZvysaETR1f1GdaisoTfMfdlJD9LEYD8EyfBdXcJq7zzB+QEezOLm0n3pU0uIjC8sGM0fxGmmv8z1iaRTFzIKSvoTjAxHJB2bTnlomQDzUp5dC93qxYALHPzzYAiMndwMBOwj28QvCSjkuBm/qnEoYrlPA23rGJWJMMcJcShrQrXN+0mMQPdUsYuamZK7QfErMkCLlOVwanbOVyosbO3tq64vR/iPdybLLuLKOkTcDrbWkOhnX9o4ftGmBiOp1prEA2S3xreWEC1ayACx9rOuIRlDMaj5TF3I8EPyAss5NQKSv+UK+2ajgJcyQVtqmNNqvgjUldcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrKpEA0COhG1s6BxGnXl83AND2+lpKdG1I+5MN3qs/Q=;
 b=JP2myNt1VNgbFpqAqLVnGxtzILpmio7yZAhLa1u+nvUR2x1GgM+Il14ppN/y0qaram+atYJI5b5xsMWc3oiv8LHvXPWpcfL1pI/ICRrISq8JUDCkmL7EWcSHfxHjN7C6NQMpl+lNywadn0PPabFvalAzrNRYfaiLexC6vZMX0rHFZ6VIpAL7aKhGkDA13f9qqx41z2Qm/wTddR/KiZD/yXbKic4XaH/HGO2PjJpftq3BvOOpxnIbnQu3Xkl0PwJFsizALmMpGAPwrXhAVWwy3pXppguBQklvHkgOp6py3GiCS4Aw1eGnJavZlAz5mx4/TWXDVUYYCsrjZNFW4PaWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrKpEA0COhG1s6BxGnXl83AND2+lpKdG1I+5MN3qs/Q=;
 b=Y9b5kZ/yQi8R6XroHeEi7Iy9GXx9iX0PMqd4ri0on55Bu7gGyjzDR0fgUdL9ISH9WOnJ5x6O6WFx3DJPO697owdtkycVJXa9lMIzaQ5U67Ry8mO8sL009U/FUwvQVHt0ZMFVT0WwaP0OXk2m7IQgT8/Er4dBiS1G80uPKFihhVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 15:12:32 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::a425:7531:6b64:db42]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::a425:7531:6b64:db42%12]) with mapi id 15.20.5834.015; Tue, 22 Nov
 2022 15:12:32 +0000
Content-Type: multipart/alternative;
 boundary="------------o63WDQYu1XQRuyiEN621HlX4"
Message-ID: <8bd5e203-5092-e062-fddb-55178e64ed6c@amd.com>
Date: Tue, 22 Nov 2022 10:12:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] drm/amdgpu: fix stall on CPU when allocate large
 system memory
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Felix.kuehling@amd.com, philip.yang@amd.com
References: <20221117213829.24861-1-James.Zhu@amd.com>
 <20221121145312.125272-1-James.Zhu@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20221121145312.125272-1-James.Zhu@amd.com>
X-ClientProxiedBy: BL1PR13CA0400.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::15) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_|PH0PR12MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: 86722b47-fbe3-4394-7ae3-08dacc9bf9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuPw/gTK/oHoRdaNOqFwuOR2RmYBOmlf4eDNi1SH3YoiF2IYpqU9KrSPbB60xIq+AYwsOfy3SWgC5S4tz8AegI4R7J/edxS+6Sa1d9TnWV567QLrrwhPX4ym1u029OE39VKkUvrpYOCL+4TYfxYKosevOvGKNpT9z5r+uvvGkHHiTtfPDY+bG3R3ZI5wJJIJk41CPFd4sdN6WoXvLLmDl3IKp6Qrt4kgPQc+5XUyhCdSXV4h8eV/vD7ZGJuvjJkd7drogd1YpisHNJ/QLyjkSGygrIUawRUl/vUaM2HRXwQmqkjMbzu5X4k9+VSkUOWewKOOm1CLHV/vnr8hexrlC+VR0BahXSC8Su6ssw3vO/qVDe/EMh/axir/D6DYmjRrknGtIPp4xSmIC0MPMcnpF263VcJIGvnNK27/NyIh/48hQG5cOFvYqDYcBSRHrjmZAKKp2F+z2YebkI6crlDPCviTQZ+l1I5WLVclDAz8xpYOWArGOyrP+KcRPb+8QvGjaZP5VJCoTpYPFHup1LKnzd1wnd0SgQ+T+O6txmi4zT8Yb7UCuNHtb9hY4EFEIq5CZhPoL6E65vcVnN+99jaqwPEYrSzGuFpFgVDGolhWTl90o1v474HVuZ1IUL+fcb6rtX7+RqVHFBszpdR+DeCaM5PsnChyRgMIkD2JGV3tvryBC5r2CqiF27KRr7Gqh02v18JC8yA3FhDe9CPpcFnlPivO+h5xCkEIT0nCRe9ULHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(31696002)(36756003)(316002)(6636002)(41300700001)(5660300002)(66946007)(66476007)(83380400001)(8676002)(66556008)(26005)(6506007)(6512007)(6666004)(53546011)(33964004)(2616005)(186003)(478600001)(36916002)(6486002)(38100700002)(30864003)(8936002)(4001150100001)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhhcVlCYTNkdFcvUGFaeDQvdFZoVGxPODRUSnluYkxVSGhYcTR0OWF5OThO?=
 =?utf-8?B?VHUyYnU1WW5lK3lGSmNVeDJxdCtoNXV6OU91K0RMcEdjWFJ3c2MxUU5aOVEw?=
 =?utf-8?B?QUZjd0twTlVEeWdrV3VXbW8xSVgrdFhjQTdtT2pMWDBGUnA5TFRUUURjaktT?=
 =?utf-8?B?Y1dKZ2NXVDQrR0xhaXdxRERPZXlYcVkxR3htckx6SFhyak4xU3Q5VTdYWitX?=
 =?utf-8?B?UVVPWENWeEszb0RTTGdhN2tWRWtCSkJEYWFIVVNjdlBvRXp1eTQrY3djN1Yz?=
 =?utf-8?B?MERTTVhLT0V2ejB2QXN5aVUyMHFLY0NQVTR0U0cxSjkwWEpsZXgvNlJQL1U4?=
 =?utf-8?B?ZWtHT2NLL3Rqd0JRNXhidXJ2T0xrWG0vVWdVL1Z3cWs0VVJoYms5YzJQRzRa?=
 =?utf-8?B?Z0swRGRKZjNNdWNhdlVvdE83K0wyQ1hRMUlxVWxHRnlOekdjU0F2ajUxaHhi?=
 =?utf-8?B?eW9OcHlCNDZWd2tHd3VReW1rY1VWVVhYdVZKZU40UnBBU0pmUlpEaTE3Y2Nz?=
 =?utf-8?B?YldCU1JHaUx3QU9uQUdJS2N2UjdKVGg0ejUreFJtTEFKcmowSHoxT05xMVhJ?=
 =?utf-8?B?N1lFMHRTdUtYL3hlNUFIc0h0L2F5cVRsTTRLSGlUNDNraGhJZVFuWTlkR3hC?=
 =?utf-8?B?NUJ2dHV3ai9xVEFoZXlzRnhheDF3Q0V2SDZoRXdINnNDUU1WTDJFLzNyMElN?=
 =?utf-8?B?cU9MWnlRbFdQVEkrSXJycDV2ZWFpN2czSWJ6WUVzcUc4dGxmWHc4aUM5TldH?=
 =?utf-8?B?aHB4bGdmdGI0elM3VGE2R0xCRWtqemFqNVZtWWtVVkhLZGNJQkl2eG5LUFlm?=
 =?utf-8?B?KzJ1SEYvVllmOFN5TkJtd2xrVmd2QXhkTnY0UlhOTS8wckd5OWU4YTVuQkgw?=
 =?utf-8?B?U05KSXBFS014NWNZdDA3VmlmR1d6VVJjVkEyRkJWaFlrTFVyR1JyQ3lBREpl?=
 =?utf-8?B?aUI4MnF3aWh4bEx3R2U4WG9xQ2dqUUF3cDZBNjY3ci9RanRhMXhpcElaaEV0?=
 =?utf-8?B?c1NUa3doZlJhbFlJM3pUbmJsSTRGT1NXVFFxb1ZYQWY1MjNRZ3FJUERPMUhk?=
 =?utf-8?B?Ukc4NTc3a08wcVg2NHM1cUFmTG1MQ2Q3N3V5RUdaWFpXVTUrNCtKbEdEUFJK?=
 =?utf-8?B?L05TZnlWbTQxUUFQSndDUEtDSHNESHdHRzJKRUt6WThFek1TTnVjV3NpdVdT?=
 =?utf-8?B?SWxoRHJTMFZ1R1V0ZmRtTkhnWG41SVhCSW5Va0ZJam9obEs3UzlKbjVYRGNy?=
 =?utf-8?B?TnFPY0ZmaGFBU2RFMTJTQ2N3QlZsSUxTNnlLc2dJcHoyV2xBVXlVUnJDVU1Y?=
 =?utf-8?B?SmR3a1RjakozNG9HS2FoNEx0eTdqcEM1Y0FQMEpZYWtQMlZNVWRTM0tnOEdS?=
 =?utf-8?B?eHlaWnA1bTZmZkVBSWgzTlZLM3picyt5dVVJVXVZTmFWVFBFTVFmYzRQcG5z?=
 =?utf-8?B?UEFST0N5b3ZUNTlBN0Q0WFdBV0d4ZklyM3ltNzlVOXNOUUY4Rys2RjM3S0U2?=
 =?utf-8?B?S1JpWlBCOTZGMXdRSDFUaU5tWFpPVE9TVml2MnBUaWlaakYvMTFDaHYvcjJV?=
 =?utf-8?B?RGZUdlF0YmZEQXI3V0N4RUlrcnIvTU90alJxbWlmWjEvMjVrcEFiZENkdm9l?=
 =?utf-8?B?Tkh6NzdzdTZUWWg3ZFdpV2l6UXRRL2pxNHBjODBLVURCWVZNRy8yQ0R6d2to?=
 =?utf-8?B?OHR5Wk5yNmYzcWk5OGtYczFSdk9VWUhEOHhNV09TK3FJRjZvRGRZS2V2V2s1?=
 =?utf-8?B?SFVPZlBnSXh1Y202V1VtdFhpUGNKZUoxSERmajNLSms4d2U3aVJjbmhXWklQ?=
 =?utf-8?B?YURnUWpPNkdRVTk3ZzkvS2tCM1k0VzF3VFlKT29vUVhHbzltRE1YcUZraWJV?=
 =?utf-8?B?ZmpOZXFGc3g2SWFMSXlSM2poYU10TmlPQU8yRElPM2w0VG4vdlJ3UmR4d0VS?=
 =?utf-8?B?aGNXV1I4c1J4czBwdzBqTFllQ3gwTWhsWHo3ZE9XRU5NNjBGWDNOSG1xQnMv?=
 =?utf-8?B?ZDVYK3ZkMVNyV1BncWVMOGdsTm1zZGQzTTJMM3gwbkwzaWQ3MnhUd1ZHdjFX?=
 =?utf-8?B?dFBXME90eldhcVl0TmFBSmQ3QTdRejRSbnd6WlVILzhOOFJSZHpOR2R6alph?=
 =?utf-8?Q?sQMx30u4MoL5OJfEw5i+hYrb3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86722b47-fbe3-4394-7ae3-08dacc9bf9a0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 15:12:31.9667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+kUnUneRg72G11Fn61v+I6hI7Hd72/uotfZVxFEB08cH6r0hl1dac4RUOSSBVii
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468
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

--------------o63WDQYu1XQRuyiEN621HlX4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping...

On 2022-11-21 09:53, James Zhu wrote:
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
> Signed-off-by: James Zhu<James.Zhu@amd.com>
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
--------------o63WDQYu1XQRuyiEN621HlX4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><span data-markjs="true" class="mark4xj82b56k" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" style="border: 0px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-variant-numeric: inherit;
        font-variant-east-asian: inherit; font-weight: 400;
        font-stretch: inherit; font-size: 14.6667px; line-height:
        inherit; font-family: &quot;Times New Roman&quot;; margin: 0px;
        padding: 0px; vertical-align: baseline; color: rgb(36, 36, 36);
        letter-spacing: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial;">Ping</span><span style="color: rgb(36, 36, 36);
        font-family: &quot;Times New Roman&quot;; font-size: 14.6667px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">...</span></p>
    <div class="moz-cite-prefix">On 2022-11-21 09:53, James Zhu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20221121145312.125272-1-James.Zhu@amd.com">
      <pre class="moz-quote-pre" wrap="">-v2: 1. rename variable to redue confuse
     2. optimize the code
-v3: move new define out of the middle of the code

When applications try to allocate large system (more than &gt; 128GB),
&quot;stall cpu&quot; is reported.

for such large system memory, walk_page_range takes more than 20s usually.
The warning message can be removed when splitting hmm range into smaller
ones which is not more 64GB for each walk_page_range.

[  164.437617] amdgpu:amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu:1753: amdgpu: 	create BO VA 0x7f63c7a00000 size 0x2f16000000 domain CPU
[  164.488847] amdgpu:amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu:1785: amdgpu: creating userptr BO for user_addr = 7f63c7a00000
[  185.439116] rcu: INFO: rcu_sched self-detected stall on CPU
[  185.439125] rcu: 	8-....: (20999 ticks this GP) idle=e22/1/0x4000000000000000 softirq=2242/2242 fqs=5249
[  185.439137] 	(t=21000 jiffies g=6325 q=1215)
[  185.439141] NMI backtrace for cpu 8
[  185.439143] CPU: 8 PID: 3470 Comm: kfdtest Kdump: loaded Tainted: G           O      5.12.0-0_fbk5_zion_rc1_5697_g2c723fb88626 #1
[  185.439147] Hardware name: HPE ProLiant XL675d Gen10 Plus/ProLiant XL675d Gen10 Plus, BIOS A47 11/06/2020
[  185.439150] Call Trace:
[  185.439153]  &lt;IRQ&gt;
[  185.439157]  dump_stack+0x64/0x7c
[  185.439163]  nmi_cpu_backtrace.cold.7+0x30/0x65
[  185.439165]  ? lapic_can_unplug_cpu+0x70/0x70
[  185.439170]  nmi_trigger_cpumask_backtrace+0xf9/0x100
[  185.439174]  rcu_dump_cpu_stacks+0xc5/0xf5
[  185.439178]  rcu_sched_clock_irq.cold.97+0x112/0x38c
[  185.439182]  ? tick_sched_handle.isra.21+0x50/0x50
[  185.439185]  update_process_times+0x8c/0xc0
[  185.439189]  tick_sched_timer+0x63/0x70
[  185.439192]  __hrtimer_run_queues+0xff/0x250
[  185.439195]  hrtimer_interrupt+0xf4/0x200
[  185.439199]  __sysvec_apic_timer_interrupt+0x51/0xd0
[  185.439201]  sysvec_apic_timer_interrupt+0x69/0x90
[  185.439206]  &lt;/IRQ&gt;
[  185.439207]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  185.439211] RIP: 0010:clear_page_rep+0x7/0x10
[  185.439214] Code: e8 fe 7c 51 00 44 89 e2 48 89 ee 48 89 df e8 60 ff ff ff c6 03 00 5b 5d 41 5c c3 cc cc cc cc cc cc cc cc b9 00 02 00 00 31 c0 &lt;f3&gt; 48 ab c3 0f 1f 44 00 00 31 c0 b9 40 00 00 00 66 0f 1f 84 00 00
[  185.439218] RSP: 0018:ffffc9000f58f818 EFLAGS: 00000246
[  185.439220] RAX: 0000000000000000 RBX: 0000000000000881 RCX: 000000000000005c
[  185.439223] RDX: 0000000000100dca RSI: 0000000000000000 RDI: ffff88a59e0e5d20
[  185.439225] RBP: ffffea0096783940 R08: ffff888118c35280 R09: ffffea0096783940
[  185.439227] R10: ffff888000000000 R11: 0000160000000000 R12: ffffea0096783980
[  185.439228] R13: ffffea0096783940 R14: ffff88b07fdfdd00 R15: 0000000000000000
[  185.439232]  prep_new_page+0x81/0xc0
[  185.439236]  get_page_from_freelist+0x13be/0x16f0
[  185.439240]  ? release_pages+0x16a/0x4a0
[  185.439244]  __alloc_pages_nodemask+0x1ae/0x340
[  185.439247]  alloc_pages_vma+0x74/0x1e0
[  185.439251]  __handle_mm_fault+0xafe/0x1360
[  185.439255]  handle_mm_fault+0xc3/0x280
[  185.439257]  hmm_vma_fault.isra.22+0x49/0x90
[  185.439261]  __walk_page_range+0x692/0x9b0
[  185.439265]  walk_page_range+0x9b/0x120
[  185.439269]  hmm_range_fault+0x4f/0x90
[  185.439274]  amdgpu_hmm_range_get_pages+0x24f/0x260 [amdgpu]
[  185.439463]  amdgpu_ttm_tt_get_user_pages+0xc2/0x190 [amdgpu]
[  185.439603]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x49f/0x7a0 [amdgpu]
[  185.439774]  kfd_ioctl_alloc_memory_of_gpu+0xfb/0x410 [amdgpu]

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 50 +++++++++++++++++--------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index a48ea62b12b0..8a2e5716d8db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -51,6 +51,8 @@
 #include &quot;amdgpu_amdkfd.h&quot;
 #include &quot;amdgpu_hmm.h&quot;
 
+#define MAX_WALK_BYTE	(64ULL&lt;&lt;30)
+
 /**
  * amdgpu_hmm_invalidate_gfx - callback to notify about mm change
  *
@@ -163,6 +165,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       struct hmm_range **phmm_range)
 {
 	struct hmm_range *hmm_range;
+	unsigned long end;
 	unsigned long timeout;
 	unsigned long i;
 	unsigned long *pfns;
@@ -184,25 +187,42 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		hmm_range-&gt;default_flags |= HMM_PFN_REQ_WRITE;
 	hmm_range-&gt;hmm_pfns = pfns;
 	hmm_range-&gt;start = start;
-	hmm_range-&gt;end = start + npages * PAGE_SIZE;
+	end = start + npages * PAGE_SIZE;
 	hmm_range-&gt;dev_private_owner = owner;
 
-	/* Assuming 512MB takes maxmium 1 second to fault page address */
-	timeout = max(npages &gt;&gt; 17, 1ULL) * HMM_RANGE_DEFAULT_TIMEOUT;
-	timeout = jiffies + msecs_to_jiffies(timeout);
+	do {
+		hmm_range-&gt;end = min(hmm_range-&gt;start + MAX_WALK_BYTE, end);
+
+		pr_debug(&quot;hmm range: start = 0x%lx, end = 0x%lx&quot;,
+			hmm_range-&gt;start, hmm_range-&gt;end);
+
+		/* Assuming 512MB takes maxmium 1 second to fault page address */
+		timeout = max((hmm_range-&gt;end - hmm_range-&gt;start) &gt;&gt; 29, 1ULL) *
+			HMM_RANGE_DEFAULT_TIMEOUT;
+		timeout = jiffies + msecs_to_jiffies(timeout);
 
 retry:
-	hmm_range-&gt;notifier_seq = mmu_interval_read_begin(notifier);
-	r = hmm_range_fault(hmm_range);
-	if (unlikely(r)) {
-		/*
-		 * FIXME: This timeout should encompass the retry from
-		 * mmu_interval_read_retry() as well.
-		 */
-		if (r == -EBUSY &amp;&amp; !time_after(jiffies, timeout))
-			goto retry;
-		goto out_free_pfns;
-	}
+		hmm_range-&gt;notifier_seq = mmu_interval_read_begin(notifier);
+		r = hmm_range_fault(hmm_range);
+		if (unlikely(r)) {
+			/*
+			 * FIXME: This timeout should encompass the retry from
+			 * mmu_interval_read_retry() as well.
+			 */
+			if (r == -EBUSY &amp;&amp; !time_after(jiffies, timeout))
+				goto retry;
+			goto out_free_pfns;
+		}
+
+		if (hmm_range-&gt;end == end)
+			break;
+		hmm_range-&gt;hmm_pfns += MAX_WALK_BYTE &gt;&gt; PAGE_SHIFT;
+		hmm_range-&gt;start = hmm_range-&gt;end;
+		schedule();
+	} while (hmm_range-&gt;end &lt; end);
+
+	hmm_range-&gt;start = start;
+	hmm_range-&gt;hmm_pfns = pfns;
 
 	/*
 	 * Due to default_flags, all pages are HMM_PFN_VALID or
</pre>
    </blockquote>
  </body>
</html>

--------------o63WDQYu1XQRuyiEN621HlX4--
