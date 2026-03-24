Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E32F532C0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 01:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5F110E03C;
	Tue, 24 Mar 2026 01:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1s+faTIz";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 110C510E03C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 01:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=py468Weu4fTyGqStQ+IP+e0MsWgFebi/5+U8lFXOfFuVMGXBr8VdRKGpVZnM28gFNn46ZVREFUSAGDN9D1ta+BXquwhGttXGkKNx4c2r1ueVBKjz5OnwIpeBojn2WHxJQ7HppXuzQR4pvdcXxDu1bpFCZGnS1VTQDXo2ZFiEuBy4fFuyoGEQ0V1as5dH2uCW02EYY1BNMdAPhyJP0rPppl6xx0itg2nFEkQIhpHfuHceX1/3aj8FOIe3Db9q3TwAmXhL2P36oLJM0mftbEpohwPvueAMlXb5yVqQ5P7NIE/xa+tfKgZUhOs/4eKhFApRq31PwpMXsWKxv6LGNtZLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93qw4AwhewohlGpK8cAdwHIrns+0EKgIAmSpSsrlg9c=;
 b=Aw+8p8or6HAQX+dtJ6T0P1E4spiNOMyFJzlZEphxJZwHKXrpljBRCvHqtDScgyopCJUmz2TeMOMe9RymwDfyBIopMhROFEABmFBLiXmlpQN+0l9IJcUXLdJZ4iEe98WJja1qU5FEnJ7WYxYkRgabqxi9O5S2FtozfRCZwWVwIJ+uqaenncMJAwXLrpDwqKKEWq+tooKKcgSYt5kSIRUlggG8vL8njVIMhBvg1qUxZWUPF7Gv2IJyt+dYaoN976oE0tLJrH6X7TKa4wvWk1YZs/mWY8CUYV91Mv+UqiGAHGYPN+ERUU0CUqCw1hOrZUuJAy3j62ygMabAICXx8q7hgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93qw4AwhewohlGpK8cAdwHIrns+0EKgIAmSpSsrlg9c=;
 b=1s+faTIzFXSSEy+T4hRr4p431/aMDQbWB8x+6ROQsAIJCEaSNy7SO13R1nvz+X8LiF5S7LN5N1mIbv5oJYID194KEkIF6KqQz+jncuScF/T9rZ3WXMODZoREtAJFRT4sHxFkwuXPo8XbHtcbwO9M3mKdWYehTGF62XOfX9pzYPA=
Received: from SJ0PR13CA0162.namprd13.prod.outlook.com (2603:10b6:a03:2c7::17)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 01:26:27 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::89) by SJ0PR13CA0162.outlook.office365.com
 (2603:10b6:a03:2c7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 01:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 01:26:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 20:26:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 18:26:25 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 20:26:19 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH v4] drm/amdgpu: guard atom_context in devcoredump VBIOS dump
Date: Tue, 24 Mar 2026 09:26:08 +0800
Message-ID: <20260324012618.626710-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a03395e-f510-4cc0-62d0-08de89445e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: u/YzR9CTcFazddquWO13dAVFRyMWvgP0YA4G1+6q3d10fzpMkk7dhBSBIiOEolEzZRcdHAEuQF1dAzWJnieMjVP91EMWj/6eRNkQC4JErguyq/2NTTxU8xiIlnhoaveYeoecEKgXJmduu2WPQ/bHBOCHLbwP+Mqh7xK4rgNc7gZeOzFH+J9VXFH5ku/pb0ieD93IVlx+3NSRkEd0c00jNf/2iQ84OgbTgm5klG/0KeWXiOBHKtGTR0vpqR3R0PHomx2f/FjOaAG8LaPa/28CCm9dT8TZMamfEnpXIkiYYW0YfiTg423u1a2yG7kHAomVjELBCoXVlbwbzYqLrs9sZjyv79+obe/QeaZXmnnOg7MRfpHNiWRVH1fyaRZGgk68j8LjqjhnNMBaO5dE0NlAvw6dq+uDKl0xMTH3e35EgwClaEn4h7JapFDEWJP8QS+ayb9hIN+GMPe7ATCJCqKXnLQwOu+ZrDYvelAieuwgMOpk/j920Tq72VS6w8kFIZuDYQIZywGmR40OtBqqbhtS0OUaekWpTpd369ja0h4f+OBNgKIAfN9k393Wup8y5g6cHhu8z6l00PX+CexqmejmSaywQepwxO28FqfsNBkEOeA49dpmRukt6I/HD521LDe3Om+pXcpndEfpbcCgMNPGpm3ow5ukm/GmDbv7EvmwoIbqh6HL7nGUCe7lC2zln/XjvHaToq4YT2qPjLmsuN44hdXuvvpKEn7EkDvEJBqUCSnrxe6wA6WyBvzf9vRoe7TJD6vZUGhH4dNBNlCkddT6bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: abTaB8QLUlOGqvzGqCUintYAr4lnkEHzapNZ5En2mC0k9KN3b3RGGOVlemIMDDJ+U452+Wd8Tgc9DoPV/Up9Oh2K2ovfFQuYBqYIIyGYKiUGCl/vTCF/I+y2YY6074mTxabgxLNqcfs7Jqpx62kjPSkaoQbNCRXLnjUoHk3Cr2yYwZ7x8wWnwHPZ+7kdMiWhKpNC6mgNFg6DDz5LKJfijqTy8d+wMDmFxcNd9cOFEKZoCg3TvjdOjPRHLNgusxJMxCg6PN314lJ9E5QeKiO/xENBd4Umihhhk/fIDJeP0MBZZFHELMfpea7FtVROr0RTjOthYcAazfpTgVNHB21T/j8RuQp8H8Qf3ayvjR2A8a6hEQQYjin3UHPzzuH0V5k3wVmdgS186rstdk14rTr/M8cLC7SAvHnsyQYkuYK+NMuG+aKS95ufVKxiEi0dB/Xp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:26:26.6263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a03395e-f510-4cc0-62d0-08de89445e64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
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

During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
paths this pointer can be NULL, causing a kernel page fault from the deferred
coredump workqueue.

Fix by checking ctx before printing VBIOS fields:

if ctx is valid, print full VBIOS information as before;
This prevents NULL-dereference crashes while preserving coredump output.

Observed page fault log:
[  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00 [amdgpu]
[  667.941517] amdgpu 0002:01:00.0: Dumping IP State
[  667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 96 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 96 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 69 96 7a
[  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246
[  667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX: 0000000000000000
[  667.949676] RDX: 000000000000a9b5 RSI: 0000000000000405 RDI: 000000000000a999
[  667.949680] RBP: ffffc9002302be00 R08: ffffffffc09c3084 R09: ffffffffc09c3085
[  667.949684] R10: 0000000000000000 R11: 0000000000000004 R12: 00000000000048e0
[  667.993908] amdgpu 0002:01:00.0: Dumping IP State Completed
[  667.994229] R13: 0000000000000025 R14: 000000000000000c R15: 0000000000000000
[  667.994233] FS:  0000000000000000(0000) GS:ffff88c44c2c9000(0000) knlGS:0000000000000000
[  668.000076] amdgpu 0002:01:00.0: [drm] AMDGPU device coredump file has been created
[  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4: 0000000000770ef0
[  668.008035] PKRU: 55555554
[  668.008040] Call Trace:
[  668.008045]  <TASK>
[  668.016010] amdgpu 0002:01:00.0: [drm] Check your /sys/class/drm/card16/device/devcoredump/data
[  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
[  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
[  668.031950] amdgpu 0003:01:00.0: Dumping IP State
[  668.038159]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
[  668.083017] amdgpu 0003:01:00.0: Dumping IP State Completed
[  668.083824]  amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu]
[  668.086163] amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file has been created
[  668.095863]  process_scheduled_works+0xa6/0x420
[  668.095880]  worker_thread+0x12a/0x270
[  668.101223] amdgpu 0003:01:00.0: [drm] Check your /sys/class/drm/card24/device/devcoredump/data
[  668.107441]  kthread+0x10d/0x230
[  668.107451]  ? __pfx_worker_thread+0x10/0x10
[  668.107458]  ? __pfx_kthread+0x10/0x10
[  668.112709] amdgpu 0000:01:00.0: ring vcn_unified_1 timeout, signaled seq=9, emitted seq=10
[  668.118630]  ret_from_fork+0x17c/0x1f0
[  668.118640]  ? __pfx_kthread+0x10/0x10
[  668.118647]  ret_from_fork_asm+0x1a/0x30

v4: fix the race concern without introducing VBIOS snapshot state.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  4 ++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index bbb5afd67b49..5aa46480f05f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
 	drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
 		   adev->vpe.feature_version, adev->vpe.fw_version);
 
-	drm_printf(p, "\nVBIOS Information\n");
-	drm_printf(p, "vbios name       : %s\n", ctx->name);
-	drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
-	drm_printf(p, "vbios version    : %d\n", ctx->version);
-	drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
-	drm_printf(p, "vbios date       : %s\n", ctx->date);
+	if (adev->bios) {
+		drm_printf(p, "\nVBIOS Information\n");
+		drm_printf(p, "vbios name       : %s\n", ctx->name);
+		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
+		drm_printf(p, "vbios version    : %d\n", ctx->version);
+		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
+		drm_printf(p, "vbios date       : %s\n", ctx->date);
+	}else {
+		drm_printf(p, "\nVBIOS Information: NA\n");
+	}
 }
 
 static ssize_t
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fbe553c38583..69f4549e6271 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4260,6 +4260,10 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	/* free i2c buses */
 	amdgpu_i2c_fini(adev);
 
+#ifdef CONFIG_DEV_COREDUMP
+	/* Make sure deferred coredump formatting is done before tearing down VBIOS/ATOM. */
+	flush_work(&adev->coredump_work);
+#endif
 	if (adev->bios) {
 		if (amdgpu_emu_mode != 1)
 			amdgpu_atombios_fini(adev);
-- 
2.49.0

