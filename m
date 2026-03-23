Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA3DD58CBB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 03:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3A510E320;
	Mon, 23 Mar 2026 03:06:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BnHYY1pf";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892C910E320
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 03:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8HfEd3xFw56BEJ3w5uBzXD0eoeM90ptLjvbotQBRibXIRv9ksr7ZGhqZ9XMfbmxH3AcKWTDpPj7c999ZAtRTLxxAYSyKs47TTEf5jTzN6OxpjwYyvoIKBTl1Q5aFKprZZfsGqdriyRC/zxbuUsl/3XH4yrCViWA0/aeXesuHj8LECLFnxaiPCGhx2hZjmNsHXngXVL+9VcswHyqN77NaNyD7edM1mYRbVr2nRNUJrIhuynMiuckZ3In4lFwAckkDK6DvtQzvkGBJAcCa/fZmdzssZvT4Yq8nve0YJpmR5O0hyOjIe6IGG6JVLG1KtJsYx9pofRVU95UnwVObVW5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksp0pwTqSJkyhTuqWJyfb0uVv2gQ6PYZ+Z08OSH+Dx8=;
 b=c1oyXOk7jHms3R4L7/Ysg+FN3QUKXK/Di8fStKKk8puwjGa7m/sM7b+C7hKCa6zuRzRQ13kH6LM/TjC/vie5cnuQ/c8vY8iB6aTEgXcjQX+gKgP4jvZ8z8X7IDJ1W5Nec2FSLuvHIY0LaB7Jfb85u2H/Hx01TYh6kPK8H5lVnwGAwE7vGjHDXDSiECzTRwttCYI4pbkBoeqVAHkEz9eDAtw6vV3TgNYNngt0bBNKiCWnK/hzvKNZitwh/ZsFvvGtprNAVeraphhjbMhxBvEfTWto/ndCmqZZrV+oa0oqS7/MSgE43ngRfWteIbARnI+9NnMnCg1bt3/vT4V4SK1Gag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksp0pwTqSJkyhTuqWJyfb0uVv2gQ6PYZ+Z08OSH+Dx8=;
 b=BnHYY1pfpiW9p6ZftvXAtTRefOUaQVQPjHSGT3cNEcuGa9EKPRXtYrBdaUBxJEpIZxT6f3RRGBmG9bAosqOmsg1/7y+fgp6Mic3erUXaevBt9nwt2y/Sn3Fi6HR/xFICqhVKX2m6CKUFv/FRq9jWcuZ7kPoyM92kqMsxp80+xBU=
Received: from PH7P221CA0082.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::21)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 03:06:15 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::4) by PH7P221CA0082.outlook.office365.com
 (2603:10b6:510:328::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 03:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 03:06:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 22 Mar
 2026 22:06:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 22 Mar
 2026 20:06:13 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 22 Mar 2026 22:06:07 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: guard atom_context in devcoredump VBIOS dump
Date: Mon, 23 Mar 2026 11:06:04 +0800
Message-ID: <20260323030606.381915-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: fab83577-aa29-4144-bbed-08de888924d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8B7rQ7nCGtQawxZJPUmDacPASj9SEQT7qMGLFk7Gt3Bp3qSYA17btdCm6ggoRImN91klD6GtiriK7+ICnCjzHDFLFNuezl8GpXqgV2L5Gq/JJnKnORthjZytGCCIIJmHiE5Zdy2kx3+xypjaplK3gbo/MNVEGQFKj94YjtATgPvkDSu6f819LeHvLTcHMayOkWJYvLvd/sBgf5kfIRr8yoDgv6S3wHOSKtGXiF0q7ojIMB1OLXToMZKs/rSSTd3bVZTUmPo/X8+bU2mBWJL081OIq0p4IjWcWLSaPTL5qPQLMzd6twrGH8lNhbBQwb2kNqeZ8o2gOrw3RAIEtXOApkvLr/k2zUQ9KUEKRjRV69VmMp5ODVfMfCUXOSigpk7LSQhSZvOKI90BovJ3a5i9SM/9V6KiGxgYbw109WGA5JxHCsEjcyNvFfoFAICiICDwsW9qgIYzMoRkFlyEfUcYW2Ez+EuGVVoImyUWP4hHKMKJZrgcjBo2rNmzCFL5QgPxI5ijywc1bU5jBm9Di5qq+S2OfKQGBiSUoeXWkHJ0CHJouzlWJwp2oXixcKGEbIWwj4RwSQQgZpUL/Hito98pGKO8RprRwp5L4FiRC0lMa48GFeqhyHHGXzo+C+TDyixR/vmtBiHnhY/6PnVHVUb00e1Q1dxNc5k+QWqwccZAFTa2SL0yHvTd7g9Z/2bKonLA1U9sMzLLk5J0yVfSCwELHVjFCdU4mCIPq+XlFBeywGmMC+L0QRAla/y1khgonWMEBsWqO42Aqtv8sNQZmzA1HQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xIyVmGinAseqetRmAeZHmCQwXXvARbIWTxBRclnv5GQ7ewKfiobUuG9ilQQbV2AhLqS5QG0u0F6PIS38xKmtMGau3cteihiWsuOk5+Fy8licQN6uBmUmBMLw+hNdophoDHSBGYlup3dWxQxMkvpPFDr8KrXaeEnRZb9Z6E83tR1V3bQox8WQ88HGVaax+5DkTzS6W2N+cIeZsNstb1TUGQi4tsvz4zXa64CrGmiSmDrb8cXgKcuBR/c+Dx8ka9OaXPIKZH/x+FxqAGqs3G8QWJYVcVN+UQDl+EXQpXleaBa9Hy+18NSf53kyiMhjfyAaVUq1XdeQHFEyoZzlomEbTMbiXw0dzMea7Hpm2sxmGZEZKmO62Oo+bqnVR2QiniTYQaHXcJ8VRK4is8NblhI+Rm5NnsOhwRKYUYAvIgiX9DeF55mhTY+lEtp659Yix31O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:06:14.2656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab83577-aa29-4144-bbed-08de888924d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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
otherwise print a fallback line:
vbios info       : unavailable (atom_context is NULL).
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

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index bbb5afd67b49..7896ddf46ae0 100644
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
+	if (ctx) {
+		drm_printf(p, "\nVBIOS Information\n");
+		drm_printf(p, "vbios name       : %s\n", ctx->name);
+		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
+		drm_printf(p, "vbios version    : %d\n", ctx->version);
+		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
+		drm_printf(p, "vbios date       : %s\n", ctx->date);
+	} else {
+		drm_printf(p, "vbios info       : unavailable (atom_context is NULL)\n");
+	}
 }
 
 static ssize_t
-- 
2.49.0

