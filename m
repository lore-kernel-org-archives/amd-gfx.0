Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C423AC7EE26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 15:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB1210E21D;
	Tue, 23 May 2023 15:31:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5C210E21D
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 15:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mtjq1jlGdILd6C/oYlY2wLLTsiQY7DNlYGD2A+8xDzNNrlYXRN8L/7pPNuvRBxpwI4WpO/OR70f6sEP38rsQBc3bg9sXCBTw3H3UZJ3qD+GeLghEwDfBT5/pqAhxFK/lS28x8Frr7eIDxOXtgJUzpnXEMh9seVXRsmBRsctkRPH36Gtc4qBFFePvmhNSbE4SXBBeCIMFcmKgWRBRU3RvJ+ncxZhx9sIMwTu4YjOXM+6PrQkNlKQDoDnfWVzmunAauJqGmKe32Wl17cSkqzgEAXGycNLStoBMNqJ/+1vGKtJss/rorRRWID84H7BAwKRS9ceEOG9oiq5JriECZdW31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FFBVJYQTd8KAVtxR8iZvIGXV6+fzFUiQdjer2ilSWg=;
 b=VqeKgor66Zt/v5pkeNjK+4gtVm/6mpDnAaL17QnG4Ln3DrGx7e3tHCdxD97IKi/LSxvD4FwnqD4QQQBD4bkCfAY9ZWpYYCcywldM8lUUvopObNlAR9+I4621xkiyl0ghJ24cF61qaIXbzsfPDEI/g/xlHmbmXdEbWw8R33bGQXNEtamfkFcWaURwC4t9SkI25VPkGHHHp8RciOCCkGLM5Gl/8P9Hw9ymcHpjI8rgQx06zfwWf778NV6Y0gvg7XjQB+mSmwLtKI0MUXOopnJDHbNGn7fK/iWa5zLX3yQiWupk4xqSXV5j6GT0Fb0rEmwABke0ZxG6oWD6bh+ADbxP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FFBVJYQTd8KAVtxR8iZvIGXV6+fzFUiQdjer2ilSWg=;
 b=ayrue35VSR1TDX6Ohk8/MOe4yAFMoAB3EzR5qDLrUSWsASY5rwNrUIGi6xZwVLCZwoRynWid4Y0ArgCQEfLmSFcQT2LQn26a2aWW71J6k+NMj6pyy2blFFxb3IZaa+x2exTl9wmxs5YD+3+EzxDUWouAtV4MY9tLGehYFEgv6ZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 15:31:39 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11%3]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 15:31:39 +0000
Message-ID: <cff1d185-4cd6-f7df-e79c-03515d6cbd60@amd.com>
Date: Tue, 23 May 2023 11:31:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] Revert "drm/amd/display: Do not set drr on pipe
 commit"
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230522130823.769236-1-michel@daenzer.net>
 <20230522130823.769236-2-michel@daenzer.net>
Content-Language: en-US, en-CA
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230522130823.769236-2-michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0229.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::35) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|CO6PR12MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc2410b-7666-499d-bf9f-08db5ba2cd42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2E6FPt6mKAvO07wLPcEQOOIhVd9d4JouXxxevIXSznTBdmF7D5TUqDWBTW7pbdSjkvEVZTqi96EoC+f6omgSq6yqcEh/ekBsDKibmay4EYInMGQhV/JFt4q3R1RlTk/rX+Qaap3XhFNsjU54X/W7vhUBtBq8i5Mm5ZKV8gSDUHEBY/Ea8p1m3AG5phjy7V1D5BRRnXjROt1l4HoCwC50ztxZtEbtruLVdHuK71B3okPuFgZvlbNdmZNKD8Qd/TV30A8yEz7zUERZk4D/h4uRhM9A+Lqr5/OzHIhg47nbsOc/Xhdw4F6Rs66WoMeeGtRkkEqJC4lpFLaJN7knovbvJ6CDd7gQqhue3tRcjRF/cGPUTOg9s36MFM6zjZ09jo7e1gBcnnqbsRxFEKqwwX/vPmrBuldYjo4uBQSF44J/Mv4aQKhjDubTq+QBTQD3MDPrn4SoJylZT1t/q0IWTwNnhYLmo+o6b+LX+GS6ZQkb8az92mXxwtImyQ8cJ+ZgkYK3ZhxplP4nauuvMWvJcF65Trh3fdCIolEfSb1KXkJRPiYMKQJraonrWelErG10hHkmUQLSzVRQyCLP0RZO2SK8QidKHsfrgs/0T7m7czRNOsukY1aF6g9fv7/YWvS5bxXbE16d5Ay/y+tOUKzmq9KCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(478600001)(66476007)(66946007)(66556008)(6636002)(4326008)(31686004)(31696002)(6486002)(41300700001)(110136005)(6666004)(316002)(54906003)(5660300002)(8936002)(8676002)(86362001)(38100700002)(44832011)(6506007)(6512007)(26005)(186003)(53546011)(83380400001)(2906002)(2616005)(36756003)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW9nZnFQb1AzZVNWQkdISm9lc3VtL0x4VEFuWDhzVUFBMTI1WVZ5ZkdGTm55?=
 =?utf-8?B?anpFMDJMZlAzSk1uV1dSUEE1ZkRJUWh6Y3Q0TkJQU3d2cS96cDA2cElLUXVM?=
 =?utf-8?B?R2ZzOXZrdU9wc3h3Vyt0NmNOYzRpcU1ZTW9ENk1MNWhpRW9Kb3RlSkNDT3E4?=
 =?utf-8?B?Q3ZCSThUZEI4b1d6TXFRY1Z4S3c3Z2psb0dBZmJzY0Z1SDlnWGZPZm53K2th?=
 =?utf-8?B?ZnFSOCsrNHN0M2NueVNpZ0JFNEc2K05yK3VkRGNMalk2NkI4bktRQnlnVGxB?=
 =?utf-8?B?QUZPQUdaQUtuMFJDcEh4Z0RaQjdzWExlODcrSzBZMkt5MSt5SXRlcks0Qkpr?=
 =?utf-8?B?UmV5a1lpNHA2UEExQncyYU5TS2ZOWDBzWmJSYmlzQ3NRcHc1ZkNYWkZjUGlp?=
 =?utf-8?B?blJVSmU1RXY4dlk5NzVxMnJmS1psQkpnb0V5YmhIdU9MNmE1Skt4eEhkZHVx?=
 =?utf-8?B?UjFHR3BZbFc5UWVQakFwQlZBU1RnNWp5aTRwQ2dOY2lBTHF3aFpmZ1kyUnRE?=
 =?utf-8?B?QjNQSVU2QWtxNEFpTlRNczF2VFpiNDI1VHVNNXpSM1FpNGJLR0x1Z1dQbWFt?=
 =?utf-8?B?bjRLL2d2b2Vic1BQK0pDSWZ1MDU2SU9IUlJlcVR6SUhlaDVtZnpvcWN0RW96?=
 =?utf-8?B?d3JpcFJiRlFFZDNiWWsrSHlMSXRvc3VySWpEcHpKM2lqS3huTFBUWWtHWkFJ?=
 =?utf-8?B?SW4wdDZZczRham5XSVdyYkpPajNBWTVLUjRQN0hza3NqdmpLMDJqYTAwcUdD?=
 =?utf-8?B?V3c5SlFoanZCUWFjK0Z1NUw3dE5xSmVNZ0pYcHg3U1l2dk1STmxrY2pXZzJj?=
 =?utf-8?B?Qk5uby95b1VCYWRmdFZ2d0RUK0EzUDhtR0Z5RkpZK1lwNlh4S2pDY0MxaHBB?=
 =?utf-8?B?dTUrekxVWnZ1TlRXVzdDUVVDZGsvaEx1Tm94dXRiOUo5TzlGU3kydHFqMkdp?=
 =?utf-8?B?YnF1ZG9hemdiZXUvN0s4YUlGam5WVUVNQ2hxM2dzdU9IK3V0cTNwS2oxQW9I?=
 =?utf-8?B?TjQ2WkxTR0RUVjAzREFUaE9xNnIwQnVqZ3FjcWpMRlpWUjhneGdVY1BLOXB4?=
 =?utf-8?B?SGo2bVlTRE5NTTNLOS8wMk9rN3djT1A5ZlptN0ZRY2lNa1IwckErQ0o3UUh6?=
 =?utf-8?B?dUNudWNmM3IxVng5a1M0UGp0Wm4rcWcwcG5Ta0RUQXdpQnY5RHJzWHlkRWlL?=
 =?utf-8?B?ZHAyc3p4bHFTMTg3VnpjVlhhR1c0MHVQT1g3YmR4L3NIM205d3pxeHBaRjFX?=
 =?utf-8?B?MzAvRzNuRXZWZkdXTVpST0o3dmdlc1E2SVJLUmMvMjVVKzZtNVR5RVhZKy9G?=
 =?utf-8?B?Nmh3K0xxaW8wMnZXejRUQm0xZWxIRHdsRlNsMUVFOFlKRmg1SUJ1bHRDcG9u?=
 =?utf-8?B?U0JnSTZpQzlWQjJvK3FseUlpMnBOWDZqZzRldDJGZlJiZFc2eWpOejJnWUxP?=
 =?utf-8?B?TXRaaUQ3blI5K2RkMVpHVWxKa080U3FpOVpBRlpzM0NteUh3ZDkxcnZXbHdM?=
 =?utf-8?B?WmtxUWRiYWJiT1VyaXozZzB0NjFtV2dRMy9jY21zQzlzOEhVR3U3bys1azlH?=
 =?utf-8?B?Skk1dHpuemIvOUZNN0p5WWJUTDFCVU1odys5aU5ZOUxlRFl2QkdWQy91Nm9h?=
 =?utf-8?B?dkxlRWtnMHRKblN0YnkybTJmTmlUVmJhRFlBbWIwMnpVSHEycWRaaGpHZDI3?=
 =?utf-8?B?bVdRM095WUdPUzlLT0wyNWUzd1FMUzl5bXkzMW14amIxNGtqLzFUajFmdlUr?=
 =?utf-8?B?OHhYNlZzVjdTaTFFNkMydktYbTByNTd2dHVJZGJZc3ZPYzh4SUpaOU5DdGNL?=
 =?utf-8?B?bmt0SUM1VjVOTEFZRWFjcldPMC80K1U4OXpXRTNjWTNqZG9ncnRmN3Jtbzc0?=
 =?utf-8?B?TmdlVHpBQ3B3OUhiNXRReXRNMTVTTlFwdU1ycUhmOXRVeUdva0dudG04L3Ri?=
 =?utf-8?B?R0lFZUNORUUreVVVR2lBTHFsNnVwaFRCWkZjdzZjalJrMW9KQmFqbHFITEZ4?=
 =?utf-8?B?NGwrUDMvQkllZ1dsa2QzTmZ4eFh4VStnYlRHUDR2YytudWl2QXdaaFFkMmU2?=
 =?utf-8?B?OWRkdUNrY25JU3BZM0cxNm9yemp2dk1jdWJpajZBWTVYTEtreTdyNUJLMElR?=
 =?utf-8?Q?75vY6P7I4ZVu4dIX6rmaRbc/5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc2410b-7666-499d-bf9f-08db5ba2cd42
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:31:39.2074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBb9s4a3zrJBLAf3JvFrqD+rZTmRfJVvH0V6Fs+bT4Ozn+GdhcHJyuoVEHz5ATModcGyhqFeeB9cLlYPDhYE1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 5/22/23 09:08, Michel Dänzer wrote:
> From: Michel Dänzer <mdaenzer@redhat.com>
> 
> This reverts commit 474f01015ffdb74e01c2eb3584a2822c64e7b2be.
> 
> Caused a regression:
> 
> Samsung Odyssey Neo G9, running at 5120x1440@240/VRR, connected to Navi
> 21 via DisplayPort, blanks and the GPU hangs while starting the Steam
> game Assetto Corsa Competizione (via Proton 7.0).
> 
> Example dmesg excerpt:
> 
>  amdgpu 0000:0c:00.0: [drm] ERROR [CRTC:82:crtc-0] flip_done timed out
>  NMI watchdog: Watchdog detected hard LOCKUP on cpu 6
>  [...]
>  RIP: 0010:amdgpu_device_rreg.part.0+0x2f/0xf0 [amdgpu]
>  Code: 41 54 44 8d 24 b5 00 00 00 00 55 89 f5 53 48 89 fb 4c 3b a7 60 0b 00 00 73 6a 83 e2 02 74 29 4c 03 a3 68 0b 00 00 45 8b 24 24 <48> 8b 43 08 0f b7 70 3e 66 90 44 89 e0 5b 5d 41 5c 31 d2 31 c9 31
>  RSP: 0000:ffffb39a119dfb88 EFLAGS: 00000086
>  RAX: ffffffffc0eb96a0 RBX: ffff9e7963dc0000 RCX: 0000000000007fff
>  RDX: 0000000000000000 RSI: 0000000000004ff6 RDI: ffff9e7963dc0000
>  RBP: 0000000000004ff6 R08: ffffb39a119dfc40 R09: 0000000000000010
>  R10: ffffb39a119dfc40 R11: ffffb39a119dfc44 R12: 00000000000e05ae
>  R13: 0000000000000000 R14: ffff9e7963dc0010 R15: 0000000000000000
>  FS:  000000001012f6c0(0000) GS:ffff9e805eb80000(0000) knlGS:000000007fd40000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00000000461ca000 CR3: 00000002a8a20000 CR4: 0000000000350ee0
>  Call Trace:
>   <TASK>
>   dm_read_reg_func+0x37/0xc0 [amdgpu]
>   generic_reg_get2+0x22/0x60 [amdgpu]
>   optc1_get_crtc_scanoutpos+0x6a/0xc0 [amdgpu]
>   dc_stream_get_scanoutpos+0x74/0x90 [amdgpu]
>   dm_crtc_get_scanoutpos+0x82/0xf0 [amdgpu]
>   amdgpu_display_get_crtc_scanoutpos+0x91/0x190 [amdgpu]
>   ? dm_read_reg_func+0x37/0xc0 [amdgpu]
>   amdgpu_get_vblank_counter_kms+0xb4/0x1a0 [amdgpu]
>   dm_pflip_high_irq+0x213/0x2f0 [amdgpu]
>   amdgpu_dm_irq_handler+0x8a/0x200 [amdgpu]
>   amdgpu_irq_dispatch+0xd4/0x220 [amdgpu]
>   amdgpu_ih_process+0x7f/0x110 [amdgpu]
>   amdgpu_irq_handler+0x1f/0x70 [amdgpu]
>   __handle_irq_event_percpu+0x46/0x1b0
>   handle_irq_event+0x34/0x80
>   handle_edge_irq+0x9f/0x240
>   __common_interrupt+0x66/0x110
>   common_interrupt+0x5c/0xd0
>   asm_common_interrupt+0x22/0x40
> 
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 6 ------
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 7 -------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index 6ce10fd4bb1a..5403e9399a46 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -2113,12 +2113,6 @@ void dcn20_optimize_bandwidth(
>  	if (hubbub->funcs->program_compbuf_size)
>  		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, true);
>  
> -	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
> -		dc_dmub_srv_p_state_delegate(dc,
> -			true, context);
> -		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
> -	}
> -
>  	dc->clk_mgr->funcs->update_clocks(
>  			dc->clk_mgr,
>  			context,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index 0411867654dd..0e071fbc9154 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -985,18 +985,11 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
>  void dcn30_prepare_bandwidth(struct dc *dc,
>   	struct dc_state *context)
>  {
> -	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
> -		dc->optimized_required = true;
> -		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
> -	}
> -
>  	if (dc->clk_mgr->dc_mode_softmax_enabled)
>  		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
>  				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
>  			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
>  
>  	dcn20_prepare_bandwidth(dc, context);
> -
> -	dc_dmub_srv_p_state_delegate(dc, false, context);
>  }
>  
