Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF48EC01A4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 09:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF35910E05C;
	Mon, 23 Mar 2026 09:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e3+dn/Ah";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012019.outbound.protection.outlook.com
 [40.93.195.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0EB410E05C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 09:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGwkPvGyYxlb4jsfzcDJyLYlseCDMKXrYFTBYmRyjzIQwZRwVfiSnvB/EFgXWmqg7Z8s7VyPsd9sXNScHFx2Mr87cQu+pjSHarpbqTp2pC5HtBVilXjAPTyELHdE9Ije+ZSMAtcYOcfmkVcc6R6d1iEzji0iR0UuST4u8i0vTSZCotSS742PColg1NegjT/1hCzzKoct0XQDD0Yxaz+oXTjoJU7C3lPSMfWZf+gkxul6aab4+Hv1TJnGtesqs1gVmXELFqxXzUGxImCeiMP3duPWMwdHXmAmuaNjsRwcAlgIl8YRDOuRPoJ8ar4RblJh6xyd509TlU2XItErndygjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfPf4d5B+wQXcA2O9+WKO0pjybKR3jzy6m3D2Qxiv/w=;
 b=fLHL0yIbLJkwdt67Ryx8hoA3Rc4c7TH7jRHCCm7FoJ21DvZyMM7Z3Cv5Md7tpQjBPcLY8blfB79a94iVFTBwVLWp2sdjCwx0mSQbnZivXvKsj6/k29oPgPVxEyqauUe7evLhCjEaeXd/S10HTqnOzCU+jqReGlMnm+Caf1oyZbUFi+jmGt8XM4dvMNcByifGelnKmXb10R6IsQDxYhR+LelCUKqPD/WwHDd7amoNma4fYdRw4Jqfd8gY+8LlO+GQFS84tFmj8yGEXLn0VGzwXp+toA6DI1MirBeP/Gepol7LCaF8XuQ8JUqV54tWEM4m4a5hBTLMqKzPYqxxzgiYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfPf4d5B+wQXcA2O9+WKO0pjybKR3jzy6m3D2Qxiv/w=;
 b=e3+dn/Ahy/tncq4+yToU7PdsY3Ju7zbH50h9aTJB2tZ3SiilF0qwa2T1s3wQCs0uQ0ZuewwRpDkXRYoL8j4tX3UOcOOwQa7YP1WfVLIEIjn5lo9QZC7nDDvHv9bVtv0MBcoVVMAakM+j6Ob0opNdJcgYO/IQ/XTaITpiOPi2av4=
Received: from SJ0PR13CA0061.namprd13.prod.outlook.com (2603:10b6:a03:2c4::6)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Mon, 23 Mar
 2026 09:12:26 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::17) by SJ0PR13CA0061.outlook.office365.com
 (2603:10b6:a03:2c4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 09:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 09:12:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:12:17 -0500
Received: from jessevm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 04:12:10 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH V4] drm/amdgpu: guard atom_context in devcoredump VBIOS dump
Date: Mon, 23 Mar 2026 17:12:10 +0800
Message-ID: <20260323091210.252353-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5a45eb-5783-4fbf-f30d-08de88bc4c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ERiWhCB5lG8Q1l8oQAWwu+uPrtzvkjAMGWmxIHX2MYMWANcE5hD8s8Dv/C3yN+kO4QRiJgDOHNft2+Q8B3fwQYWas1IC3Lt3HZqIaAlK3hgy1KfvcWrczM1W7OVJRUfM+OhqwyVKQWhSWfKzGUG3KWtKnJsq9ElwkChsgrfecygi9xulg4nA82iD/pdjZ+49QXiaST0BRNi3NvbdJRDkQSQuh3IDmWWSfLmNIOY80OQbhhP6Bm8Vr5gYoNHkrlm3uzMUWGyEYHwLc/08fDWgsIXlWw2TKL1LuOAcX1uRqn6I+mWUrVAxYmpeivcDJIAOCTq2ExoEJZX4Vlx3pamuktGFVt1thpVd5DIsL7HHfBx82FdyZVTBNnYr+8jhfPFicrhL7lbu0JabEXZsKLnocbUMx5hySZWvp07vovquvvlGdXZW/o9CDQ3fCybQ4VHH7Tvh1IR77Dh3GtrB38+gUhiWcFoTlqzSi/Kl7Uv5fcyOaNuhNJWuroVPFbwyWl64sRxHWZTXpnPNeGCJ97rwe7wjmkTFTwXBinlmJ+JKtcEUyBYfzOwOM9dERMi7QvQQA/+uKrkxzXKfFHasw4o3d3XC2yxb+IJomoPdI+DpaIg4GJVY4ezEpEtlJJv3VV8MxzAOgAoIMDHOp1VaH2UlRwOD+GOq2sf7jEimoe4OOBkISFhmYtDLLSmj2AWZzd6OqsS4+PDBFiId7lmSqYj1lNmywMPOd108Rj+Ke/Z73MAp4Se/lUdGXreA+EqffCpgWleZidVhSrHFFAucP/N6LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0t0RgkkKrlCuKXr4EXUvESc8Doi/6lUugGI/jacFp7hOL1qaZMywBv4P0/GTOHjrQDxPYI5R9cDSMjhjKaF0O9qyV9/Jbz0kzpTO0qM6B6aqBvg/YNKSCCbXFXn4pzft6kFroKsw3BJTO/ItavPb4+fcWSGGpc47Ptn1OfnUxaenudQoo7EquzZ8B5CEVcmd/3PMqG+UxO3VOgei70X00YGMODe4Y3zmiyBQm7egWsJzgFIb0B1/B7GyDxXadjR1BqvefxUiDwn6WXXzo2ZA7abSipKzSW7faWAEGpmK352unOkC+eu1WtTcon1E1bYaBFqgbm+5luR+wjbF8qKf00N1zLxdMeXiKZLCpgvk9a/yc2h1E34MtoFNrZk8SSfewKt+2IgUm1B1Dof8O71JYqWNCx7xS66kGqcSVpwvdy6cpbvengD2tngv/qx+vtdA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:12:24.2459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5a45eb-5783-4fbf-f30d-08de88bc4c6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742
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

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

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

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

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
-- 
2.49.0

