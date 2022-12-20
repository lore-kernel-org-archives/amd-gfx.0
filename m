Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B56C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 23:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F7C10E3FD;
	Tue, 20 Dec 2022 23:27:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E1210E3F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 23:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+PlaVDKllRC0FQLGeDCJMbWG7wLmEuaclz0kDfSwQ83ogQ9rOUxzMIGSDzI/bNuSgjOrg/xsBS5/EagIhMbKTKJGnqGAvyi1uyrzfov9F4Cee+pyjXDfL/wPLtjsJBLdJDCdrD3GXBHE7mEwHkrj8ZMhcOqev5cdB+g8oitRFFMYRY49wqW5jq1Vr0xIF4Uy0LBT3BlMnsH4VlgGkQtpu6jjLjFD5vbvT8PY9K2BnU3vutcNDLBJji1REHSZuHmo9NO7MzaWYgvaW7IeEwc+X0rOzkvie/oPBo+/qFixz4zdN+OBeKPqzf/zzdgp4FZbzmewz0NPRBUSUc3ByP2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCZiMzHI3Fmo7VMR7aCYL4ysJhowCJnWfEfapYPOBN0=;
 b=RP3LXQqDem0GGTdwqooxF6DRSQlgYxxFvI0o4NV1BViBlgHwF2hUtOk8p2L/svv/FCjv2/cK9Nb3nRhdsclYaEmeKxiv5TnVqc6CdC3rewTuDL+yJDepK2hTaFFI54zmhJggbWHoKbJ8W8vYootE5LZh/LnSjDk98/v+P6E7RVrNjXkqWjcwkspOpgEDSqXJTWtrZf9O1hR0z9EXTYqYEjdBFGOraT9YS1Ax1s8oHVveeybN3fdUmRSUXUWQ1vGqbApo8tTzsqiANOPkLxICxPPHTtrr+MP77yNKOMcsYj7xBrVVng/M3YoFMh63vQXhMKt35qBXMTjK/C4Zz7fqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCZiMzHI3Fmo7VMR7aCYL4ysJhowCJnWfEfapYPOBN0=;
 b=SorEW1EQJPNXR1Bmo2bRjsUJetZ10s1xbQOw9r7+QUfiV0PEDqNXjubNlGOdnKPJAuWlgfT7+0AogWWniCtrewiHAsa7ynfxk7AG4y9BFK6xcaeS6iT69dHGgdtdAvIM/53T32ATp9oIuJqaCUOpx21yKYK4IN2dNtBpTMsdh6c=
Received: from SJ0PR03CA0167.namprd03.prod.outlook.com (2603:10b6:a03:338::22)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 23:27:22 +0000
Received: from CO1PEPF00001A61.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::11) by SJ0PR03CA0167.outlook.office365.com
 (2603:10b6:a03:338::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 23:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A61.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 20 Dec 2022 23:27:21 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 17:27:20 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 3/3] drm/amdkfd: Use per-process notifier_lock for SVM
Date: Tue, 20 Dec 2022 18:27:04 -0500
Message-ID: <20221220232704.3394112-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221220232704.3394112-1-Felix.Kuehling@amd.com>
References: <20221220232704.3394112-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A61:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: ae27b385-3426-4b65-3148-08dae2e1beaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJcvkZjRQIl60c0SPXmj2VV9nv/NWl8w8PJfBMaRnNADFd6vIXpY0PNEAJSfAsUcOWNimNpUkx1CJugR+fM7d9k9m+fno+SBcAWuVd5/c96B8k6VOoMMvlmKb6yXsej4AETaUc6GVsdHSdEv3nCLnJOTZ7DCmIJQz+aInJY1w9xkbpeoGMx7c3xmx5TtBYNCpcYJ2uacRiRGcV5MsHVqQuYhj5klF+5RSjBXyyGl5iAIVXC03i1CUd/QOXPXX3OLoU+IlkguAamwT+S5xmEc9uNd8XMs9FusU+BVWq+38oY0cTvcveZ2v3SCmGCrg5F9FCdol9qnIQCkTokUS5gK61F6fPw/hSmwIGpqHMR9Lsw2oZ6pPhOXAm9ZKFvWXZn43+AhDWmYVxYEEAkgh6LL2H9p21xbhSkl63VYOiITXbFWPZQfEVwr2dIXkYnLcyHjRtHKqjGQ778biSCYnTySgbjy23s+sbpVmVfgATfkQOqXaUR2f5KuLk1QmCrvuEWvDlV3FD/cKcvNtKSK7x7iKNpj+yqPH+vDqYT63zxetaQtKW9evmRvC1ebmVybrspBUcVTv0k3zfmvoLCc45/QKY84+6REvTSB0HYiAnaeqK33oSPLMveFGXdMp4pLoay+0wrc0GNKrRlII2C3cGWxzzBvHAbpjpUnB+DQWwM9ttXIes4Kwc1NpQbnrRRincec/XvGmrss0YIWA+sEObRahswGT7145PCI0H8r94VzGk4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(426003)(1076003)(4326008)(8676002)(336012)(47076005)(40460700003)(36860700001)(356005)(82740400003)(83380400001)(30864003)(81166007)(82310400005)(2906002)(5660300002)(8936002)(7696005)(41300700001)(478600001)(6666004)(36756003)(316002)(86362001)(6916009)(2616005)(54906003)(70586007)(40480700001)(70206006)(26005)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 23:27:21.9284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae27b385-3426-4b65-3148-08dae2e1beaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
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
Cc: philip.yang@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the process_info->notifier lock for validating and mapping SVM ranges.
Take advantage of the locking done inside amdgpu_vm_ptes_update to fix
a lock dependency issue with page table allocations.

TODO: double check that prange->lock it not still needed somewhere inside
the notifier lock because it protects a few other things.

[   83.979486] ======================================================
[   83.986583] WARNING: possible circular locking dependency detected
[   83.993643] 5.19.0-kfd-fkuehlin #75 Not tainted
[   83.999044] ------------------------------------------------------
[   84.006088] kfdtest/3453 is trying to acquire lock:
[   84.011820] ffff9a998561e210 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.023911]
               but task is already holding lock:
[   84.031608] ffffffffbcd929c0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: unmap_vmas+0x5/0x170
[   84.041992]
               which lock already depends on the new lock.

[   84.052785]
               the existing dependency chain (in reverse order) is:
[   84.061993]
               -> #3 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
[   84.071548]        fs_reclaim_acquire+0x6d/0xd0
[   84.076941]        kmem_cache_alloc_trace+0x34/0x760
[   84.082766]        alloc_workqueue_attrs+0x1b/0x50
[   84.088411]        workqueue_init+0x88/0x318
[   84.093533]        kernel_init_freeable+0x134/0x28f
[   84.099258]        kernel_init+0x16/0x130
[   84.104107]        ret_from_fork+0x1f/0x30
[   84.109038]
               -> #2 (fs_reclaim){+.+.}-{0:0}:
[   84.116348]        fs_reclaim_acquire+0xa1/0xd0
[   84.121697]        kmem_cache_alloc+0x2c/0x760
[   84.126948]        drm_block_alloc.isra.0+0x27/0x50 [drm_buddy]
[   84.133679]        split_block+0x4d/0x140 [drm_buddy]
[   84.139539]        drm_buddy_alloc_blocks+0x385/0x580 [drm_buddy]
[   84.146435]        amdgpu_vram_mgr_new+0x213/0x4f0 [amdgpu]
[   84.153399]        ttm_resource_alloc+0x31/0x80 [ttm]
[   84.159366]        ttm_bo_mem_space+0x8f/0x230 [ttm]
[   84.165169]        ttm_bo_validate+0xc5/0x170 [ttm]
[   84.170872]        ttm_bo_init_reserved+0x1a6/0x230 [ttm]
[   84.177075]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
[   84.183600]        amdgpu_bo_create_reserved+0x188/0x1e0 [amdgpu]
[   84.190803]        amdgpu_bo_create_kernel_at+0x64/0x200 [amdgpu]
[   84.197994]        amdgpu_ttm_init+0x420/0x4c0 [amdgpu]
[   84.204301]        gmc_v10_0_sw_init+0x33a/0x530 [amdgpu]
[   84.210813]        amdgpu_device_init.cold+0x10d4/0x17a1 [amdgpu]
[   84.218077]        amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
[   84.224919]        amdgpu_pci_probe+0x142/0x350 [amdgpu]
[   84.231313]        local_pci_probe+0x40/0x80
[   84.236437]        work_for_cpu_fn+0x10/0x20
[   84.241500]        process_one_work+0x270/0x5a0
[   84.246805]        worker_thread+0x203/0x3c0
[   84.251828]        kthread+0xea/0x110
[   84.256229]        ret_from_fork+0x1f/0x30
[   84.261061]
               -> #1 (&mgr->lock){+.+.}-{3:3}:
[   84.268156]        __mutex_lock+0x9a/0xf30
[   84.272967]        amdgpu_vram_mgr_new+0x14a/0x4f0 [amdgpu]
[   84.279752]        ttm_resource_alloc+0x31/0x80 [ttm]
[   84.285602]        ttm_bo_mem_space+0x8f/0x230 [ttm]
[   84.291321]        ttm_bo_validate+0xc5/0x170 [ttm]
[   84.296939]        ttm_bo_init_reserved+0xe2/0x230 [ttm]
[   84.302969]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
[   84.309297]        amdgpu_bo_create_vm+0x2e/0x80 [amdgpu]
[   84.315656]        amdgpu_vm_pt_create+0xf5/0x270 [amdgpu]
[   84.322090]        amdgpu_vm_ptes_update+0x6c4/0x8f0 [amdgpu]
[   84.328793]        amdgpu_vm_update_range+0x29b/0x730 [amdgpu]
[   84.335537]        svm_range_validate_and_map+0xc78/0x1390 [amdgpu]
[   84.342734]        svm_range_set_attr+0xc74/0x1170 [amdgpu]
[   84.349222]        kfd_ioctl+0x189/0x5c0 [amdgpu]
[   84.354808]        __x64_sys_ioctl+0x80/0xb0
[   84.359738]        do_syscall_64+0x35/0x80
[   84.364481]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   84.370687]
               -> #0 (&prange->lock){+.+.}-{3:3}:
[   84.377864]        __lock_acquire+0x12ed/0x27e0
[   84.383027]        lock_acquire+0xca/0x2e0
[   84.387759]        __mutex_lock+0x9a/0xf30
[   84.392491]        svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.400345]        __mmu_notifier_invalidate_range_start+0x1d3/0x230
[   84.407410]        unmap_vmas+0x162/0x170
[   84.412126]        unmap_region+0xa8/0x110
[   84.416905]        __do_munmap+0x209/0x4f0
[   84.421680]        __vm_munmap+0x78/0x120
[   84.426365]        __x64_sys_munmap+0x17/0x20
[   84.431392]        do_syscall_64+0x35/0x80
[   84.436164]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   84.442405]
               other info that might help us debug this:

[   84.452431] Chain exists of:
                 &prange->lock --> fs_reclaim --> mmu_notifier_invalidate_range_start

[   84.466395]  Possible unsafe locking scenario:

[   84.473720]        CPU0                    CPU1
[   84.479020]        ----                    ----
[   84.484296]   lock(mmu_notifier_invalidate_range_start);
[   84.490333]                                lock(fs_reclaim);
[   84.496705]                                lock(mmu_notifier_invalidate_range_start);
[   84.505246]   lock(&prange->lock);
[   84.509361]
                *** DEADLOCK ***

[   84.517360] 2 locks held by kfdtest/3453:
[   84.522060]  #0: ffff9a99821ec4a8 (&mm->mmap_lock#2){++++}-{3:3}, at: __do_munmap+0x417/0x4f0
[   84.531287]  #1: ffffffffbcd929c0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: unmap_vmas+0x5/0x170
[   84.541896]
               stack backtrace:
[   84.547630] CPU: 3 PID: 3453 Comm: kfdtest Not tainted 5.19.0-kfd-fkuehlin #75
[   84.555537] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
[   84.565788] Call Trace:
[   84.568925]  <TASK>
[   84.571702]  dump_stack_lvl+0x45/0x59
[   84.576034]  check_noncircular+0xfe/0x110
[   84.580715]  ? kernel_text_address+0x6d/0xe0
[   84.585652]  __lock_acquire+0x12ed/0x27e0
[   84.590340]  lock_acquire+0xca/0x2e0
[   84.594595]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.602338]  __mutex_lock+0x9a/0xf30
[   84.606714]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.614262]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.621806]  ? svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.629353]  svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
[   84.636742]  ? lock_release+0x139/0x2b0
[   84.641374]  __mmu_notifier_invalidate_range_start+0x1d3/0x230
[   84.647976]  unmap_vmas+0x162/0x170
[   84.652203]  unmap_region+0xa8/0x110
[   84.656503]  __do_munmap+0x209/0x4f0
[   84.660792]  __vm_munmap+0x78/0x120
[   84.664977]  __x64_sys_munmap+0x17/0x20
[   84.669499]  do_syscall_64+0x35/0x80
[   84.673755]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   84.679485] RIP: 0033:0x7f32872eb97b
[   84.683738] Code: 8b 15 19 35 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 34 0d 00 f7 d8 64 89 01 48
[   84.703915] RSP: 002b:00007fffb06c4508 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
[   84.712205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f32872eb97b
[   84.720072] RDX: 0000000004000000 RSI: 0000000004000000 RDI: 00007f32831ae000
[   84.727944] RBP: 00007fffb06c4750 R08: 00007fffb06c4548 R09: 000055e7570ad230
[   84.735809] R10: 000055e757088010 R11: 0000000000000246 R12: 000055e75453cefa
[   84.743688] R13: 0000000000000000 R14: 0000000000000021 R15: 0000000000000000
[   84.751584]  </TASK>

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 13 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 60 ++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 16 +------
 3 files changed, 37 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 884f7d4ee695..b8430c27d775 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -882,6 +882,7 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
  */
 static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 {
+	struct amdkfd_process_info *process_info;
 	unsigned long addr = vmf->address;
 	struct svm_range_bo *svm_bo;
 	enum svm_work_list_ops op;
@@ -889,6 +890,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	struct svm_range *prange;
 	struct kfd_process *p;
 	struct mm_struct *mm;
+	unsigned int flags;
 	int r = 0;
 
 	svm_bo = vmf->page->zone_device_data;
@@ -916,6 +918,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 		r = 0;
 		goto out_unref_process;
 	}
+	process_info = p->kgd_process_info;
 
 	pr_debug("CPU page fault svms 0x%p address 0x%lx\n", &p->svms, addr);
 	addr >>= PAGE_SHIFT;
@@ -936,13 +939,11 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	if (!prange->actual_loc)
 		goto out_unlock_prange;
 
-	svm_range_lock(parent);
-	if (prange != parent)
-		mutex_lock_nested(&prange->lock, 1);
+	mutex_lock(&process_info->notifier_lock);
+	flags = memalloc_noreclaim_save();
 	r = svm_range_split_by_granularity(p, mm, addr, parent, prange);
-	if (prange != parent)
-		mutex_unlock(&prange->lock);
-	svm_range_unlock(parent);
+	memalloc_noreclaim_restore(flags);
+	mutex_unlock(&process_info->notifier_lock);
 	if (r) {
 		pr_debug("failed %d to split range by granularity\n", r);
 		goto out_unlock_prange;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cc46878901c1..7020861438fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1278,6 +1278,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 
 static int
 svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
+		     struct hmm_range *hmm_range,
 		     unsigned long offset, unsigned long npages, bool readonly,
 		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
 		     struct dma_fence **fence, bool flush_tlb)
@@ -1323,7 +1324,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 					   pte_flags,
 					   (last_start - prange->start) << PAGE_SHIFT,
 					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					   NULL, dma_addr, NULL, &vm->last_update);
+					   NULL, dma_addr, hmm_range,
+					   &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
@@ -1350,9 +1352,10 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 }
 
 static int
-svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
-		      unsigned long npages, bool readonly,
-		      unsigned long *bitmap, bool wait, bool flush_tlb)
+svm_range_map_to_gpus(struct svm_range *prange, struct hmm_range *hmm_range,
+		      unsigned long offset, unsigned long npages,
+		      bool readonly, unsigned long *bitmap, bool wait,
+		      bool flush_tlb)
 {
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *bo_adev;
@@ -1385,7 +1388,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			continue;
 		}
 
-		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
+		r = svm_range_map_to_gpu(pdd, prange, hmm_range, offset,
+					 npages, readonly,
 					 prange->dma_addr[gpuidx],
 					 bo_adev, wait ? &fence : NULL,
 					 flush_tlb);
@@ -1613,23 +1617,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			goto unreserve_out;
 		}
 
-		svm_range_lock(prange);
-		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
-			pr_debug("hmm update the range, need validate again\n");
-			r = -EAGAIN;
-			goto unlock_out;
-		}
-		if (!list_empty(&prange->child_list)) {
-			pr_debug("range split by unmap in parallel, validate again\n");
-			r = -EAGAIN;
-			goto unlock_out;
-		}
+		r = svm_range_map_to_gpus(prange, hmm_range, offset, npages,
+					  readonly, ctx.bitmap, wait,
+					  flush_tlb);
 
-		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-					  ctx.bitmap, wait, flush_tlb);
-
-unlock_out:
-		svm_range_unlock(prange);
+		/* Ignoring return value because this just frees the hmm_range.
+		 * Actual checking is done in amdgpu_vm_ptes_update under the
+		 * notifier lock.
+		 */
+		amdgpu_hmm_range_get_pages_done(hmm_range);
 
 		addr = next;
 	}
@@ -1806,13 +1802,11 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			if (!pchild->mapped_to_gpu)
 				continue;
 			mapped = true;
-			mutex_lock_nested(&pchild->lock, 1);
 			if (pchild->start <= last && pchild->last >= start) {
 				pr_debug("increment pchild invalid [0x%lx 0x%lx]\n",
 					 pchild->start, pchild->last);
 				atomic_inc(&pchild->invalid);
 			}
-			mutex_unlock(&pchild->lock);
 		}
 
 		if (!mapped)
@@ -1848,12 +1842,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 		pr_debug("invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n",
 			 prange->svms, start, last);
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
-			mutex_lock_nested(&pchild->lock, 1);
 			s = max(start, pchild->start);
 			l = min(last, pchild->last);
 			if (l >= s)
 				svm_range_unmap_from_gpus(pchild, s, l, trigger);
-			mutex_unlock(&pchild->lock);
 		}
 		s = max(start, prange->start);
 		l = min(last, prange->last);
@@ -2335,13 +2327,11 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	unmap_parent = start <= prange->start && last >= prange->last;
 
 	list_for_each_entry(pchild, &prange->child_list, child_list) {
-		mutex_lock_nested(&pchild->lock, 1);
 		s = max(start, pchild->start);
 		l = min(last, pchild->last);
 		if (l >= s)
 			svm_range_unmap_from_gpus(pchild, s, l, trigger);
 		svm_range_unmap_split(mm, prange, pchild, start, last);
-		mutex_unlock(&pchild->lock);
 	}
 	s = max(start, prange->start);
 	l = min(last, prange->last);
@@ -2384,9 +2374,12 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 				    const struct mmu_notifier_range *range,
 				    unsigned long cur_seq)
 {
+	struct amdkfd_process_info *process_info;
 	struct svm_range *prange;
+	struct kfd_process *p;
 	unsigned long start;
 	unsigned long last;
+	unsigned int flags;
 
 	if (range->event == MMU_NOTIFY_RELEASE)
 		return true;
@@ -2404,8 +2397,11 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 		 mni->interval_tree.last >> PAGE_SHIFT, range->event);
 
 	prange = container_of(mni, struct svm_range, notifier);
+	p = container_of(prange->svms, struct kfd_process, svms);
+	process_info = p->kgd_process_info;
 
-	svm_range_lock(prange);
+	mutex_lock(&process_info->notifier_lock);
+	flags = memalloc_noreclaim_save();
 	mmu_interval_set_seq(mni, cur_seq);
 
 	switch (range->event) {
@@ -2417,7 +2413,8 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 		break;
 	}
 
-	svm_range_unlock(prange);
+	memalloc_noreclaim_restore(flags);
+	mutex_unlock(&process_info->notifier_lock);
 	mmput(mni->mm);
 
 	return true;
@@ -2959,6 +2956,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 int
 svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
 {
+	struct amdkfd_process_info *process_info = p->kgd_process_info;
 	struct svm_range *prange, *pchild;
 	uint64_t reserved_size = 0;
 	uint64_t size;
@@ -2967,9 +2965,9 @@ svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
 	pr_debug("switching xnack from %d to %d\n", p->xnack_enabled, xnack_enabled);
 
 	mutex_lock(&p->svms.lock);
+	mutex_lock(&process_info->notifier_lock);
 
 	list_for_each_entry(prange, &p->svms.list, list) {
-		svm_range_lock(prange);
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
 			size = (pchild->last - pchild->start + 1) << PAGE_SHIFT;
 			if (xnack_enabled) {
@@ -2996,10 +2994,10 @@ svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
 			reserved_size += size;
 		}
 out_unlock:
-		svm_range_unlock(prange);
 		if (r)
 			break;
 	}
+	mutex_unlock(&process_info->notifier_lock);
 
 	if (r)
 		amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 7a33b93f9df6..bb455dc7f549 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -82,8 +82,7 @@ struct svm_work_list_item {
  * @offset:     range start offset within mm_nodes
  * @svm_bo:     struct to manage splited amdgpu_bo
  * @svm_bo_list:link list node, to scan all ranges which share same svm_bo
- * @lock:       protect prange start, last, child_list, svm_bo_list
- * @saved_flags:save/restore current PF_MEMALLOC flags
+ * @lock:       protect prange start, last, svm_bo_list
  * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
  * @perferred_loc: perferred location, 0 for CPU, or GPU id
  * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
@@ -117,7 +116,6 @@ struct svm_range {
 	struct svm_range_bo		*svm_bo;
 	struct list_head		svm_bo_list;
 	struct mutex                    lock;
-	unsigned int                    saved_flags;
 	uint32_t			flags;
 	uint32_t			preferred_loc;
 	uint32_t			prefetch_loc;
@@ -135,18 +133,6 @@ struct svm_range {
 	bool				mapped_to_gpu;
 };
 
-static inline void svm_range_lock(struct svm_range *prange)
-{
-	mutex_lock(&prange->lock);
-	prange->saved_flags = memalloc_noreclaim_save();
-
-}
-static inline void svm_range_unlock(struct svm_range *prange)
-{
-	memalloc_noreclaim_restore(prange->saved_flags);
-	mutex_unlock(&prange->lock);
-}
-
 static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
 {
 	if (svm_bo)
-- 
2.32.0

