Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB88C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 10:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E0810E330;
	Wed,  1 Jul 2026 10:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GGs+hT8O";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0022010E330
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 10:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtPc/cepfZo2pEW9RGS4TVWLDyoisT695J1S1mDCo4yRmHzNKokjtPy8FowLZ6/+G64ifKnmdPArrILICZwi+AHPzMpG2Zi+jj26kVCPt26ffFu2CFf0ViCAINX4p5DDNtXSOhDSTLmrJ9WqgogAWUiUai2fJl50y3XmwLUmkPdTggmBNrCjtm1dAxzAdiuceG4SZzQXSZ78dOgfd/aeASZJisDETbJ1DM8bkYeqYAreLd4kKs+/HFYwY5nyQkXbk5xc8dNBQpFQxtJMIs7jMY0woJ3jyTdGeD/kcOqw4q9x/UBZ2lggpz5G46IgBytJP7fEHkKmk4Oq7YhNjDZzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG2ps2JCTo371RY50Nk3mrWBCDuuE7G6wVKLu8mMzj0=;
 b=rcEC1FhDkG+G0yZyBG/erRsmLmCFbFCfxmTXD85qhPoXj3wUq/akQRMTFl3aDuptbm5mdyopELX45FPdqiJRFZBrenv0rUSqDKl+f6sHK51e1r7Wr3Axgq+GbO2DtxnU6G6P7TqS8Fl4pFW7AVmdSOrwkn5OREHls4NkoGfclMtbF5iKIp2sRIG5atRiZ9GihIXgBmu6yYyOhUqFTa+B9uv5UgSwZhFVsbqoX1MqPcb3oNCYpr34nYyDdDG+q2QtOfZsYtjcblQZKbuKe8vBMT/HhdRad3JBqjrdvF8fWYPaImP7SID6S+zU7QZxNNuyCCeBvkM6ghamNKEHCHYTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG2ps2JCTo371RY50Nk3mrWBCDuuE7G6wVKLu8mMzj0=;
 b=GGs+hT8OOQv+4tWIZUpH3ILCxiCav/UOELuYu3O4SEFKNmzT/44TXQ5IyVtIkePPoKTfd9F+YVBXAPvADgJDhbMiuYWLsVFAtIpIlENkLBa5u4nhf3UCNrLcIO1yJP3gZbtgT2MYOAcfMlyPsM2TvKHPA7svlYczKaiV8elMRl0=
Received: from BN0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:e4::18)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 1 Jul
 2026 10:07:23 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::17) by BN0PR02CA0013.outlook.office365.com
 (2603:10b6:408:e4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 10:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Wed, 1 Jul 2026 10:07:21 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 1 Jul 2026 05:07:20 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: flush pending RCU callbacks on module unload
Date: Wed, 1 Jul 2026 18:07:09 +0800
Message-ID: <20260701100709.1584191-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8fe486-256e-41aa-78f3-08ded7588ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|11063799006|5023799004|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: gMiXYlh1CK1gYsC0zFg/SwNmxabdKCg/niNuskdMQ3h93smeE+57lkE10J03ZSP4tUPruoo0V3ZLpSPPBzt3PNb14NgoB5z5r/gUaFL4y0sZvc/U7Cdc6lUeFZgfx8GstUNs8E6jd4axuRYat+tj4tZHCb48+uVrUWECKqtdOAfKRwybpxRQYVDJHfy3EecUeoBlZbFruD1PNUxcJsTS6zNTrWZB8KDBGxvHaGoeZHHLHRHOSRlpy/2lQNN399iR9FpGHpm3TdwoOnVsDboD92hkof8GTLVGm4EN3ii5QZDIf2/q4GUIC2aMiPuUrAE72nX2J+aD/vddi8O4ab6rrK/nXXDNiCVhMPbem0Eho945A71Oozp2eCezKvGu5ZoaOkGnNuyf/i+mz46nnqdF11VFV4F98VWJtIpeneK90JZaeaS8bSXNS7dT9ecQJFvLByL6/JJ3QrdrsuTAnGbrl47oaYhS9BiIJizLz1haFYoZZbCUSG0ys8ulBKTDjgNDGlEadmpGaWvqzUy91gJvy6QPq9WeUWa1GqErhM09mcNxfyFBzv4pfAghVzbF93hTUf2Jv4ovJPsamE5wHuigh6B2UbbepUSOUw9mO61NhunFqxEb7iXYK8BSZ4rc9kxEXvFic5eugdnM6WOxz6sYCqIIf2pl2/253ghTbHKjuthL0xzFu9G2CgQwGc/6fQeE4ja3VVV9Xe+yECj4epl1Iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(11063799006)(5023799004)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DYYpgJpPL6VaGf3o+0dS9THXiLKxCrDuIqv755I7jlZY9NSoY0O1lBuk+wBI8lIGqPKG1dxhM8YeHXujHaW37NF+T1c22cD0SmBCFH+4rTq5mgucPPH+wMb11wSuCF605r7w4CWjBbPP+uGffQB2gyp6NzuDSg0U34h1Baf4CSWbS116Bmhgn1hfmglLMziJ/x77hN/ENtFFmldq6ilTLpPSYIeNTN+HRPttRmT3bJ/nV0yExs71tYhx9TML+fFlH/0R1wxxX1+RT+qwyCbn7htrsutvoAhMyvmGIYUQf/0tKPdiIayKaMvVXnUI6PYfUMUL+qlQZ1nnmoYDUhmtXEYNBwN3pF2Ia819kBydiW+bxWaCfhYXjWWrqimqECNXwd2YiEqCNckU/jdnf+HC5+OZpm6FirE/DJv9EuwVYM+jfEwv0qe3kb4ynCODP9YD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:07:21.8193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8fe486-256e-41aa-78f3-08ded7588ac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
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

Call rcu_barrier() in module exit to wait for outstanding call_rcu() callbacks
before freeing module text, preventing late callback execution in freed memory.

BUG: unable to handle page fault for address: ffffffffc1d59c40
PGD 6a12067 P4D 6a12067 PUD 6a14067 PMD 13698b067 PTE 0
Oops: 0010 [#1] SMP NOPTI
RIP: 0010:0xffffffffc1d59c40
Code: Unable to access opcode bytes at RIP 0xffffffffc1d59c16.
RSP: 0018:ffffc900198c0f28 EFLAGS: 00010286
RAX: ffffffffc1d59c40 RBX: ffff897c7d6b61c0 RCX: ffff88826aff4590
RDX: ffff8884d8b35490 RSI: ffffc900198c0f30 RDI: ffff88812af67290
RBP: 000000000000000a (DONE segment entries) R08: 0000000000000000 R09: 0000000000000100
R10: 0000000000000000 R11: ffffffff82a06100 R12: ffff88811a4e3700
R13: 0000000000000000 R14: ffff897c7d6b6270 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff897c7d680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc1d59c16 CR3: 00000104a980a001 CR4: 0000000002770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 ? rcu_do_batch+0x163/0x450
 ? rcu_core+0x177/0x1c0
 ? __do_softirq+0xc1/0x280
 ? asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 ? do_softirq_own_stack+0x37/0x50
 ? irq_exit_rcu+0xc4/0x100
 ? sysvec_apic_timer_interrupt+0x36/0x80
 ? asm_sysvec_apic_timer_interrupt+0x12/0x20
 ? cpuidle_enter_state+0xd4/0x360
 ? cpuidle_enter+0x29/0x40
 ? cpuidle_idle_call+0x108/0x1a0
 ? do_idle+0x77/0xf0
 ? cpu_startup_entry+0x19/0x20
 ? secondary_startup_64_no_verify+0xbf/0xcb

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 87885326f68b..ad631ad31899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3215,6 +3215,14 @@ static void __exit amdgpu_exit(void)
 	amdgpu_sync_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
+
+	/*
+	 * Flush outstanding call_rcu() callbacks before the
+	 * module text is freed.  Otherwise a grace period elapsing after
+	 * unload invokes a callback in already-freed module memory and
+	 * faults in rcu_do_batch().
+	 */
+	rcu_barrier();
 }
 
 module_init(amdgpu_init);
-- 
2.34.1

