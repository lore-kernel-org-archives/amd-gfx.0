Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6475010A88E0
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 16:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D961710E04A;
	Thu, 26 Mar 2026 16:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nZ3HrlD/";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FF410E04A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 16:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4tMsxytZvZ7BdtVaJoTwCFP4227KahuPwai89E4EGbTWh7QZ9W7yYuK/WMeLaM7N1LpIoArcEkjjDpe+IXDCxcVkx5Cu9lZBrnwb/n74hPyamYDT7nIeAZDDlgCFlTXRU2sFWhicCqCCEd3KExeo/6COT4vgGI+9HscQoi5slfYK2mOy0jsn5SlsnM+TbBFo2948luJyFLFm5rUr0ipDGI6/WO8G2wM0pgieM4HRe0uGvkxThyW7aeY0lSls3MeZelgmkTbJ1pP9E/C/TgptR4Djmq2wWvZSVHzH07Q6IsGz4wf+lboZ1BiDk+YxLNpwtrPm4X9UCtMeNz6PR/Fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9VlDTrJzx7wklzobv6jj8fQ21DsOtVKFfwnU0dHBjA=;
 b=EaWz6VKT+Y6ZQNbZaz6FrQUANcwBc6NS8X0V+CQu7e0tIFHnZe/wuYeAgcABJ1gHOH9nahrrXHVll9PKJlhTMP6iPhf2iLXRf/J6OuFafQfCFvhby6kM/56n8rOId9T1YVBNhtY6FS0aGEuUkhSRf4EkFHz8xAs22W4hZl4AUECiUyNHSA+KmRR/zBcwAqt+raBfzTEm2SnOKjegCBD7RatKXEG8gSfuZli/UkasKv4Ryp50tWueHAxKczQ8fSUK2Kcx58InGEGEQJu+mB/WrVNnWxdmiYAnvZ/KtF74Ol5NLoReBEYSHZqlgYlA5M9+OEKSbpSQgtF8R99Vz+4NzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9VlDTrJzx7wklzobv6jj8fQ21DsOtVKFfwnU0dHBjA=;
 b=nZ3HrlD/FannDGnSc3g1x7mHPy/HiE2/0RUFQlfzQ1EX5Ou0PpUDHzk+qIDh76DT1cnItoguorLoLKnPLN5P7qDaZhoJh0jv5CxmRCX8sp9q1ylVAM9NQuSZD7S9wPMc0vAYw+bNbEvKIfEJBEo/59ZqVw0y5GyFED/BhY7UcbI=
Received: from BN9PR03CA0346.namprd03.prod.outlook.com (2603:10b6:408:f6::21)
 by SA5PPF590085732.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 16:39:25 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::c6) by BN9PR03CA0346.outlook.office365.com
 (2603:10b6:408:f6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 16:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 16:39:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 26 Mar
 2026 11:39:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Mar
 2026 11:39:24 -0500
Received: from [10.254.92.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 11:39:24 -0500
Message-ID: <d8ddc1be-71de-4c75-ba0d-c3a7e6b9b8dd@amd.com>
Date: Thu, 26 Mar 2026 12:39:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: prevent immediate PASID reuse case
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>
References: <20260318150814.48340-1-jinhuieric.huang@amd.com>
 <84526990-a5f3-4456-b964-f81e42416ef4@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <84526990-a5f3-4456-b964-f81e42416ef4@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 30939b74-6b48-4b38-a7fa-08de8b563db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|42112799006|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z6zpoY/AYTJPKK7UmWn/HzC85SwUT5WU7/4JpKFfnVIuXZLbW9BTGDtj/8Qf7aP3J6qy7AObfdRLYhzo+JPDeVW0csDTYsyD02TQI8tXiAJcNHbYzamIemMPuFDMhKZ9xXiO8MxA6Xb7rhicx5W9zVD9inC7f1rLbCwbGcSlznzBMXUEhcoCRbq9H9Lo08ZABWIy7VyUo+paNBytTCQwStVgE8HMDmife8Fl426vYlhSRmzicKLiCuEDADhH/ccilfl3rb1bZm9l2Y86VEDKI6EKAm385jiXf0/vDB3gUoo0T+8rhnVGabbIDlEYwmQdgpvKCQ0NIC3wnUG2em9H3F1XU518nJCE3TLb5U/DgjKx33chm3yQbV+sTJGF0DNSlsF99Vy1YnRJMk2B+pWgNZwSLAPw+LT0CyeNZdPngHMBV/65RQa1FKw1s8X1gHgATBuJJxHRt0KybAS60db961z0sG4Hput4k8K12MYDTcFLnuIVephkAne923b1Z91a1fZzXIQJdsZTF4r+sorJfn1TQFgHTS4QOFm0EJpSrKExqzTFM1jrYMZsQJ1Rp87zndhRQV8u5U5ZIO/CcILkMeqS1Fn8mfkb+jUUM2852W26/yul17p7PLAwpGNNdsI0GDFnycpFZlEKtOKSYJrzeP7MXDE1a9W/2gka2jp26w/7ZcO4Yr+6HP6rxpmnSH95aRTl8LZ+wg4E3CI6gv5+VLfasJR/wEwcGGTBrxHit3hqq+XMNXA2xtRayLqYnBI60xnmXd7QWeqg8Q8o5RUoog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(42112799006)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p0xXif19pybgsp22DxiC4Y8oUyzkz0ebXsdfyEG9xC1mjrwlXTKvxa9pQ2pZMF2TuwyQRul217v7VpXSzR7wPAaNuA4ffsDDnurvzlTS9PWVdPYLUVR66ts4Lv+XYoAnOX/cf3V46q5Dw7E6QTwpI9eX810KcREZaYHltzD6OOAIIPdimlyo/FVPWJp2qkM3EIOKijMbAmF8R48KTwQyyXDe+jjAWd7IaHy/gWLQ4DoNllJdKXwnkNJYNhN9duOrYGSaMinqbA++PriUmIjOXPRVZ1mml0URhq4y/X+rxGNiM0xV6wu+8WBAKvXC9VZUpKH3uEAHHxRtiinUY40Oli4mCPjMygIRV9XILMK6IV3jODPFhIEo7/rcig+W4eMhTk+11e7ii4Qmy05M+/iBAtZJlA8V3jOKnr3tKpleglZigO6SnkebmhqPW+LRNSrp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 16:39:25.1608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30939b74-6b48-4b38-a7fa-08de8b563db7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
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



On 2026-03-19 03:23, Christian König wrote:
> On 3/18/26 16:08, Eric Huang wrote:
>> PASID resue could cause interrupt issue when process
>> immediately runs into hw state left by previous
>> process exited with the same PASID, it's possible that
>> page faults are still pending in the IH ring buffer when
>> the process exits and frees up its PASID. To prevent the
>> case, it uses idr cyclic allocator same as kernel pid's.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

Hi Eric,
I'm getting a lock prover warning with this change, should it use spin_lock_irqsave() instead?
- Leo

[    9.139038] ================================
[    9.139041] WARNING: inconsistent lock state
[    9.139044] 6.19.0-MANJARO-ASDN-minimal+ #200 Not tainted
[    9.139047] --------------------------------
[    9.139049] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[    9.139050] swapper/11/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[    9.139054] ffffffffc1e6f2f8 (amdgpu_pasid_idr_lock){?.+.}-{3:3}, at: amdgpu_pasid_free+0x2b/0xa0 [amdgpu]
[    9.139444] {HARDIRQ-ON-W} state was registered at:
[    9.139446]   lock_acquire+0xdb/0x2e0
[    9.139456]   _raw_spin_lock+0x34/0x80
[    9.139463]   amdgpu_pasid_alloc+0x20/0xd0 [amdgpu]
[    9.139717]   amdgpu_driver_open_kms+0x9a/0x310 [amdgpu]
[    9.139953]   drm_file_alloc+0x20d/0x310
[    9.139961]   drm_client_init+0x7b/0x160
[    9.139966]   amdgpu_amdkfd_drm_client_create+0x51/0x80 [amdgpu]
[    9.140285]   amdgpu_pci_probe+0x2ac/0x480 [amdgpu]
[    9.140516]   local_pci_probe+0x42/0x90
[    9.140522]   pci_device_probe+0xd7/0x260
[    9.140525]   really_probe+0xde/0x380
[    9.140531]   __driver_probe_device+0x78/0x150
[    9.140534]   driver_probe_device+0x1f/0xa0
[    9.140536]   __driver_attach+0xcf/0x210
[    9.140538]   bus_for_each_dev+0x7b/0xd0
[    9.140541]   bus_add_driver+0x11b/0x200
[    9.140543]   driver_register+0x75/0xe0
[    9.140546]   do_one_initcall+0x5b/0x360
[    9.140551]   do_init_module+0x62/0x240
[    9.140556]   init_module_from_file+0xd3/0xf0
[    9.140558]   idempotent_init_module+0x109/0x310
[    9.140560]   __x64_sys_finit_module+0x71/0xe0
[    9.140561]   do_syscall_64+0x99/0x490
[    9.140566]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    9.140569] irq event stamp: 84734
[    9.140571] hardirqs last  enabled at (84733): [<ffffffffb0ac1ae7>] cpuidle_enter_state+0x107/0x4e0
[    9.140576] hardirqs last disabled at (84734): [<ffffffffb0abc353>] common_interrupt+0x13/0xd0
[    9.140580] softirqs last  enabled at (84712): [<ffffffffafb37aa8>] __irq_exit_rcu+0xe8/0x160
[    9.140585] softirqs last disabled at (84703): [<ffffffffafb37aa8>] __irq_exit_rcu+0xe8/0x160
[    9.140588] 
               other info that might help us debug this:
[    9.140589]  Possible unsafe locking scenario:

[    9.140590]        CPU0
[    9.140591]        ----
[    9.140592]   lock(amdgpu_pasid_idr_lock);
[    9.140594]   <Interrupt>
[    9.140595]     lock(amdgpu_pasid_idr_lock);
[    9.140597] 
                *** DEADLOCK ***

[    9.140598] 2 locks held by swapper/11/0:
[    9.140600]  #0: ffff88c753a32900 (&ring->fence_drv.lock){-...}-{3:3}, at: dma_fence_signal+0x24/0x70
[    9.140610]  #1: ffff88c741b58ab0 (&fence->lock){-...}-{3:3}, at: dma_fence_signal+0x24/0x70
[    9.140615] 
               stack backtrace:
[    9.140619] CPU: 11 UID: 0 PID: 0 Comm: swapper/11 Not tainted 6.19.0-MANJARO-ASDN-minimal+ #200 PREEMPT(full)  456c95f30fba7b087f768dc486320b859d317b7b
[    9.140624] Hardware name: HP HP Spectre Laptop 14-fd0xxx - 5CD411LN4C/8CDD, BIOS W81 Ver. 00.46.00 05/10/2024
[    9.140627] Call Trace:
[    9.140629]  <IRQ>
[    9.140636]  dump_stack_lvl+0x6c/0xa0
[    9.140639]  print_usage_bug.part.0+0x22b/0x2c0
[    9.140642]  mark_lock+0x821/0xa00
[    9.140644]  ? find_held_lock+0x2b/0x80
[    9.140646]  ? local_clock+0x15/0x30
[    9.140651]  ? lock_release+0x1c4/0x4a0
[    9.140654]  __lock_acquire+0x10ff/0x2250
[    9.140662]  lock_acquire+0xdb/0x2e0
[    9.140664]  ? amdgpu_pasid_free+0x2b/0xa0 [amdgpu a0c72c9b7ef197ec09c5986009831d93cb38f16a]
[    9.140925]  _raw_spin_lock+0x34/0x80
[    9.140927]  ? amdgpu_pasid_free+0x2b/0xa0 [amdgpu a0c72c9b7ef197ec09c5986009831d93cb38f16a]
[    9.141178]  amdgpu_pasid_free+0x2b/0xa0 [amdgpu a0c72c9b7ef197ec09c5986009831d93cb38f16a]
[    9.141430]  amdgpu_pasid_free_cb+0x19/0x60 [amdgpu a0c72c9b7ef197ec09c5986009831d93cb38f16a]
[    9.141681]  dma_fence_signal_timestamp_locked+0x9d/0x160
[    9.141685]  dma_fence_signal+0x37/0x70
[    9.141689]  drm_sched_job_done.isra.0+0x6d/0x1b0 [gpu_sched 4c9c47cecdaeac2a93e031dbb2cb233cb20e7757]
[    9.141696]  dma_fence_signal_timestamp_locked+0x9d/0x160
[    9.141699]  dma_fence_signal+0x37/0x70
[    9.141702]  amdgpu_fence_process+0xdd/0x150 [amdgpu a0c72c9b7ef197ec09c5986009831d93cb38f16a]
[    9.141941]  sdma_v6_0_process_trap_irq+0x5a/0x70 [amdgpu a0c72c9b7ef197ec09c5986009831d93cb38f16a]
[    9.142225]  amdgpu_irq_dispatch+0x189/0x2a0 [amdgpu a0c72c9b7ef197ec09c5986009831d93cb38f16a]
[    9.142489]  amdgpu_ih_process+0x66/0x190 [amdgpu a0c72c9b7ef197ec09c5986009831d93cb38f16a]
[    9.142745]  amdgpu_irq_handler+0x23/0x60 [amdgpu a0c72c9b7ef197ec09c5986009831d93cb38f16a]
[    9.143000]  __handle_irq_event_percpu+0x95/0x2f0
[    9.143007]  handle_irq_event+0x3b/0x80
[    9.143009]  handle_edge_irq+0xf5/0x1e0
[    9.143012]  __common_interrupt+0x79/0x1a0
[    9.143016]  ? tick_irq_enter+0x77/0xb0
[    9.143020]  common_interrupt+0x9c/0xd0
[    9.143023]  </IRQ>
[    9.143023]  <TASK>
[    9.143025]  asm_common_interrupt+0x26/0x40
[    9.143027] RIP: 0010:cpuidle_enter_state+0x10d/0x4e0
[    9.143032] Code: 01 48 0f a3 05 14 e8 dc 00 0f 82 a7 02 00 00 31 ff e8 67 f1 0e ff 45 84 ff 0f 85 8b 02 00 00 e8 59 cd 22 ff fb 0f 1f 44 00 00 <45> 85 f6 0f 88 cf 01 00 00 49 63 ce 48 2b 2c 24 48 6b d1 68 48 89
[    9.143033] RSP: 0018:ffffd1304023fe80 EFLAGS: 00000286
[    9.143036] RAX: 0000000000014afd RBX: 0000000000000003 RCX: ffffffffb0ac1ae7
[    9.143037] RDX: ffff88c740b30000 RSI: ffffffffb13de1de RDI: ffffffffb13a30c3
[    9.143038] RBP: 0000000220ab5620 R08: 0000000000000000 R09: 0000000000000001
[    9.143039] R10: 000000000000000b R11: 0000000000000000 R12: ffff88c747caf000
[    9.143040] R13: ffffffffb17b2100 R14: 0000000000000003 R15: 0000000000000000
[    9.143042]  ? cpuidle_enter_state+0x107/0x4e0
[    9.143046]  cpuidle_enter+0x31/0x50
[    9.143052]  do_idle+0x1d6/0x240
[    9.143057]  cpu_startup_entry+0x29/0x30
[    9.143059]  start_secondary+0x11c/0x150
[    9.143065]  common_startup_64+0x13e/0x141
[    9.143072]  </TASK>


