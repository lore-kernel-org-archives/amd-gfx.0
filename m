Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C70C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 22:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950BD10E697;
	Thu, 17 Nov 2022 22:03:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2153210E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 22:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpYU144WOHTEY5iXKUUJN/CzbKthE9EkZVQXfvG90Ehu9VmAXEMVVrppOa94jQkLoVP6RuWhBZKrmUlQFNJlgAOZPheclIPxfq+Ir7O2OPjcctdGAnYgCPbVyrX+Sf0RjpWrztbfY5YaV6ewxOXrI8ZzYH8xOUcm7PKEX57vdeRh8XA9wgRe2zIcDcUkIThzRMlsSjJ1hWwy8TuEAiDeuLSaPpEjnf+ciKd3QyRvRisF8YOgqSMqPziWKw5TFHlhpYp7+pgR8WOGiPaqTNdGnOTUzEQRArzl7fqAH8+LB9MZ6opO11LOnw2beFzzNzqtBSoT48jxz/3PoI1yYWBtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wxll+3Mt2ndBaGDrRWHwOudxQ8Cz+t09Y2ajjIbcWT8=;
 b=EnCY5RLPLdF2uX20K5o6ewIFiMhBSFG4Hs1tLDhejxmS3s8PN42AvQtq31UtQpVkOmaWyZw1ONxLr49wMRPTnfG3ozbnDeu3WXwwGfm7KejyhLxL8SWl2gD50s+sxWsdEU6Vy8UaldL59xMjG+7atEnmLQ2vRW53T4vCb0dezcdSzoEPzWctzf5TRKYEmesuSLmmyn2eJoiXqptEiRECBp52bI9W/WuJuW0wh8y0WTvxQumcnO1ce7eEfYrEdRW9fGupbIGCIDujpA+TENdIJuNzWtO+x5Wf/1Qx54VOTZndbX53MGtcCcUX5qaGKToiZ+CCKqPcWYSOAJO1GdZLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxll+3Mt2ndBaGDrRWHwOudxQ8Cz+t09Y2ajjIbcWT8=;
 b=bLhkRxccIig3x01jfQwHKA2sFfI/+ueAH4Yo2N6CxHTKref63NNMVeL6dXpLXv16LeIyW66Yr3S/2kMWkL9hpFEv3Eaqh9Z2vwC8A2S8JR/G0xBX6UjaeSF3S1PkMgCDpJS3137IKSRzejLRKNMXJc0z/OTfgmYrEtf2bYreL9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 22:03:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 22:03:06 +0000
Message-ID: <59748ca8-9dac-e983-95a8-5b5b4c0a3946@amd.com>
Date: Thu, 17 Nov 2022 17:03:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: fix stall on CPU when allocate large system
 memory
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, philip.yang@amd.com
References: <20221117213829.24861-1-James.Zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221117213829.24861-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 19980d5e-1402-4650-431b-08dac8e78143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jfna5VF0QVKRBOgT6JqZrG9784sgfwM6RaPHTgio0WY5flvEbEvNBp/LtbI0DEWV0fBZaJSb3SM7GRQDn9sLHwcg65m5l170zngZrhsoL5CB+7MNMYpXe7QTwGwTKEIJpR+UTcYlkjZhXnQb3iImOxzyCA7IdLqCWp3aCiqVD0qaFOW3gtB8pu/N5HZUecM21/VuJXnIj8Ww1nHF/Iy0steBeTEOI25e2L3f3ZoY1Q34ldkZNa8+WBpcUpCiRwrI4mSlsG7QEPnu1m1VSXpnCapBmq9azRx2nD6h1+3F2yGDrGAy4nwzNa8mKVk/sF2kq/qH5qkj90d4VOKdkldwomIBqK4Rr4qCCKpthUevtoafXVK+bGiW9K12xBf3IYnwqS6Gl6jowWBSDCXB3dsYu6YJQJI4S2qjzm2vuiIwwmkJ7GsSlpDF91yMGgD2b+cSifmeKQEah+pKdpRQlJ8iinC7rLsvQKwQxR6aXowzL1zb+8+XDqyYme9mjbT3KJwcELdz4CPYccXqZYCp1M4hzgtpiz4GLtWvFD1S7TLT+hvBnmt1WeFougHFlCbk0u7j7l8cOnSFKv+UxSR4ymlg/4OuW6xEEeCKB85DqIBkIK0prKYGFtV5KSXUgNSZEEIryibMo9m5Z6HcqQzClIDbIqzx2QXxScCOOMOFNBiWWmQp/mXhJs/gj8RngHLPyt0S9VLubNYTghMiQUozqdHfAdXEbuBwMO0zcktHbIm3FYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(86362001)(31696002)(36756003)(41300700001)(66946007)(2616005)(66476007)(4326008)(8676002)(66556008)(6486002)(44832011)(8936002)(5660300002)(478600001)(316002)(186003)(6506007)(26005)(6636002)(38100700002)(6512007)(4001150100001)(2906002)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RqdThKK2E5UHJyVWk5Y2J3VURrYmgvdFI3VGFBVTVVRUV4NDRHOGQ0Yi83?=
 =?utf-8?B?Ky82Q3pCMnh3dFJuT1R4K0F1VmlTQ3Y3b2phRWhPRkVsSGpRajd4NkRTd3NO?=
 =?utf-8?B?aGwvKzNuNUdpZm5XV0ZJVU8xZVpIWjBmMFlDQnNQUGhiSGVoUWsxRGxvN2ky?=
 =?utf-8?B?Mm1xRzh3WEl5SnAybnRpSEI4ckdCczJBYS9iZTZaSlI2QklzQmZZS1NsUG1R?=
 =?utf-8?B?SHZZL1RKd1BEcnAzV3VaWWVCd0ZuNnZkNHlROUlvei9tRDBqb251REdTODNt?=
 =?utf-8?B?a3RPTG5ZZGxKQ25LU3F5QWVYNlMxaUFUOW5TNlhsdnZVUllYOXdieVdPdkFz?=
 =?utf-8?B?R3hrRTk4YWFEYTJjVEZrRGdDRHFEWEJDU2lzdS9QcGpjS1QyZG1wNWk1emFQ?=
 =?utf-8?B?NHZ0d0dpbWdSdWdGRVV0MlRPZDJ6azU2UUsyUnVjcFUrWSt2K244dUcwdkt1?=
 =?utf-8?B?VTI0c1Y0VGg3aW5yV0FKcUpDcWhaamdwU25ZbURkaXlMZ2QxMUJ2RlJCNWE1?=
 =?utf-8?B?R2w0SGJaZFQ1U0hOOGhEVkVQUExvZkd0c3BFeStqeFhjZHZWVjNJYUJZTkd2?=
 =?utf-8?B?ZFdxM2hCZUhYVDhCRHE0MWRwK2cwRGgvS1dyeWRENk5iQWpHcEZMT0xTRUlU?=
 =?utf-8?B?VFEvQ0hkcHRmMkRpYU1hZ0I5dHQyV2VieWtMWkxQOFBpcDIweFMzbFFEc0pM?=
 =?utf-8?B?U2VScjJhTHBscW05WWNtTEJjQitXRFN3YW1SQlptM0oxQ1FJYkVsNlczS2hJ?=
 =?utf-8?B?ampsRHNXRytFU0kxZ25HZjFaS2hlckY0Tlo5YS9mUFN0Y3BMcmk3dEJ1YTlE?=
 =?utf-8?B?MlVVUUg2a3VJUXhlOU5IV1BkS1VwZVA2SytvMDBqdStxN2pwZkNaYXR0SWtV?=
 =?utf-8?B?QXRrVUlCZ1FFM1k4aVNCSGlUTGxpaXU4VmNlR0tzWXBLT3hnMHdkdVBHV3Yv?=
 =?utf-8?B?eTR4amR4QlM4clhkdE1rNktpanRvN3ZVZlpnamduWkluSFY5QkNpZmJnY2o0?=
 =?utf-8?B?UXh0Q0pGSEdrZ3hCR1RxNStCcXhEVU44K1ozUlUrSW5nOFVvRXZtalo2Z2lW?=
 =?utf-8?B?NUNNakswRVNSU25DK3hPQVEzUzBrWDV2eUQxL05La1dWSnorRWJ6QUxKQmh1?=
 =?utf-8?B?Unh0UTlzcFVjazR0VlFTakRSNzVVTlpzRC9GRzlxNjdYWkVBcUFRU1RtUmtu?=
 =?utf-8?B?TDJOL2ZpUjJpcHNaejVFMkVoMG9lcXNiTTl2cUZhdVNHUkRMMStoTTFTalIz?=
 =?utf-8?B?K3VkZjB5UVh1cUh2UTZUTXl2RkhLWThWUGs1LzFvVmprNEwyTmNPUVBOYXRp?=
 =?utf-8?B?VjJHMzliQ2tLVzhTRXl1UHVvMTNRUmJaSWxERnJhRUllK3RGMTBEdE5XdmdL?=
 =?utf-8?B?YzNDTDBRVk0xMTltbjV1YmppR2ZhT0dwUFpTZXFLQVcyUEc4Wk5tWlNscWI0?=
 =?utf-8?B?dkJ6Ums2L3o1d0RyTmpZOWxVd1k1MTRweG5EaGxXVzJlbVZFRHlPamdvN01h?=
 =?utf-8?B?cVgybytRakVRSkltS2JORm42N1JBSVc3RUtVZXN6QXRzdjlQb0Nsak41MWVZ?=
 =?utf-8?B?aElQM25kZmRDNVEyRnF0SU9ndnFGSUpQRlU4emQrY3JGa01SL1ZiOGpwYUtR?=
 =?utf-8?B?RVRrbkZBWGhXRlJsV0JqalNmeWtxbXFIaUphNWYrSlN4QkhZTTdEK1VrMzJ3?=
 =?utf-8?B?NUxLQXl0SnBJbSsySmxFVTQ1Y2FjNmJlcTNEc3RXTGhvVGRQNmtIWEdGVEpn?=
 =?utf-8?B?ZVQ1Q3RTVDdEWU5rOGVqNHRtU3JPUmRjZUpaSVZ3cG1RZE5DWVVUZXdBTmNs?=
 =?utf-8?B?RGNKdkpXR1R5K3R3NlBSUTR2VjcxeGVXUzJmY0RvNHZ4My84REFPS1hWSHJP?=
 =?utf-8?B?TU5iV0pzS2k0U05ldk5vSncvYmFQNWxNTDFFLzNHcloyWjdTV3l3VUlTWEVG?=
 =?utf-8?B?UEUyVUR2elZ2SmlmdFFkK1FYYk10VkQ3K1RSbjFRelByQVR1Tk9kNGhhU0s3?=
 =?utf-8?B?V3JYSXJkV1dMczJxQkh6WUxQZ0ZRZUw4aTNibDYwUGdEQStNUkZvdmprL2Rw?=
 =?utf-8?B?a05uTFkyLys1eFJETEwweVpraDdpZ3QvcXVSSUtEekFHL3FhT0RaU0pSVjhZ?=
 =?utf-8?Q?roOszID1Xa2hELMUQ5gKe4D5B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19980d5e-1402-4650-431b-08dac8e78143
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:03:05.9109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWgF/BGMtiiMb6TvWpvsL3/xAfwozDqYxoeHJ/PpNZmiFHQ63JchaMQ6NGY38ANbOOim2b2trSymqgvDet/acQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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

Am 2022-11-17 um 16:38 schrieb James Zhu:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 47 +++++++++++++++++--------
>   1 file changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index a48ea62b12b0..0425fc6a49aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -163,6 +163,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       struct hmm_range **phmm_range)
>   {
>   	struct hmm_range *hmm_range;
> +	unsigned long hmm_range_end;
>   	unsigned long timeout;
>   	unsigned long i;
>   	unsigned long *pfns;
> @@ -184,25 +185,41 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   		hmm_range->default_flags |= HMM_PFN_REQ_WRITE;
>   	hmm_range->hmm_pfns = pfns;
>   	hmm_range->start = start;
> -	hmm_range->end = start + npages * PAGE_SIZE;
> +	hmm_range_end = start + npages * PAGE_SIZE;

This variable name is too easy to confuse with hmm_range->end. I would 
suggest calling it "end", analogous to "start".


>   	hmm_range->dev_private_owner = owner;
>   
> -	/* Assuming 512MB takes maxmium 1 second to fault page address */
> -	timeout = max(npages >> 17, 1ULL) * HMM_RANGE_DEFAULT_TIMEOUT;
> -	timeout = jiffies + msecs_to_jiffies(timeout);
> +#define MAX_WALK_BYTE	(64ULL<<30)
> +	do {
> +		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, hmm_range_end);
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
> +		hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
> +		hmm_range->start = hmm_range->end;
> +		schedule();

We don't need to schedule for ranges < MAX_WALK_BYTES. I guess these 
three lines could be conditional:

+		if (hmm_range->end == end)
+			break;

		hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
		hmm_range->start = hmm_range->end;
		schedule();

Regards,
   Felix


> +	} while (hmm_range->end < hmm_range_end);
> +
> +	hmm_range->start = start;
> +	hmm_range->hmm_pfns = pfns;
>   
>   	/*
>   	 * Due to default_flags, all pages are HMM_PFN_VALID or
