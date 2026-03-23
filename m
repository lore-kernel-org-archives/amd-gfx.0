Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B97D58CDC
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 06:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D87E10E049;
	Mon, 23 Mar 2026 06:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cGWW7Ruj";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE26810E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 06:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDzPfQ77zEC5OKWhMZqvqGfCgGW9FVt9XsPbBfDcay//xSguqpTsI/B8/FxGKMBhSpeOdGB/ORxFCTPL9sQUSfnQVjQ0O9LBIEeW979NVJrYM4dkxfYCmDHjeujkSvVjAhROIygJ9SWPF6F1MwL5Kj1CzlX+2q3lS66gIxQInLwjfRvsuHXGyIM7Vrl5QeaH+g8hqUQCfIrrW7NpjGrzo5QKF4XO2XnrNGGf0bpACJ1dwSFWgqAk9zn/Fua4MN2RC7dztqt3DnNE3mI5K6vfaA/vWdMGilo+YGOIxENIqqzot6opHZRwYRd1coI53PHLrwMjdODuUVG8tI0w3fPuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU5uEnhiTbSZYm7OXeqHrVvYlWWSReIzY4PFaL/f86Q=;
 b=QJLvugFxNmtATy7k+ThD9gulIStobUFvePRVPjL1tIyXRROUajHYrGrwObhry+MtUbQhNKU+mqAYYeIBiIZcCo0c7FS1now8svh6iRz0vPREA6x2Y6K5tmBU/ZU8rpmgx0/RVGUWyvJWo9aYM5F1iZXdzpW0ScGsIfsjc13EHJsrwMXycMUv3MbraYsjJE+ylWaG1v2BUXOWiAAAf4gZorDDvQhNAzBk2GYV7fFHVizBluaDEXByAjLIofLkq5T3KHY+mE0Nj7CA2R0mSj5HzSzCJSyOCDKWqGFKcayETtZdzUOZQ8uyzO+JOLjgMpo5Gc4LlQiNohSV4zMsX6W55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU5uEnhiTbSZYm7OXeqHrVvYlWWSReIzY4PFaL/f86Q=;
 b=cGWW7RujUBdt7X+vWBT2EbH1ow2CD0SYTGZrT1XEVfsWi9qe1W8jWximBTj32403Q7uVFzqWTS/qnnH/4NSJQbA2UvQpBap9iGhfvXTDjJnxa59hD4M+fovSlkU7sWcNvgJXH+FyQ3fXbVatRzjRoG42ALAg9Ari/ZkYseGg0mY=
Received: from BN9PR03CA0665.namprd03.prod.outlook.com (2603:10b6:408:10e::10)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 06:19:25 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::e2) by BN9PR03CA0665.outlook.office365.com
 (2603:10b6:408:10e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 06:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 23 Mar 2026 06:19:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 01:19:24 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 01:19:17 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu: guard atom_context in devcoredump VBIOS dump
Date: Mon, 23 Mar 2026 14:18:32 +0800
Message-ID: <20260323061912.505329-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: aad309fd-83a3-4771-4c1c-08de88a42143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: eE6+UV9u8ZsYzYTvHvifUhKEsbvgMpkNL4GYaVJEIa0ecM03zXGpVZN+Z5vkt+5sDXQ8P5ijCcvVUDCRM8sQUfnyX80c3yYreuB6b0rmxpLTwHZ21Ny06l4CIiS3j1e51SZfKIXV85IpXoepeb5Sz9oPstumtDZ6WILNECnvNzu9T565baTghXSLCx76q0yWgjriiAWxqoDR6bzBklNpwxBpGTLWF5NGqyrmn1P6eUC3ySfnowBkwmpq0MBL+pbe61Vty14cA00//8hsxxaa3ecYg4HwtovNMuBqq4/N7fI6XXO9/7b0UN2a2sdGHUPnlBn5VIMmDUd6MWaBARde+Ku3HrqxegQqLRxOlv6HROlzreHoUurNfJ/BMF49RHXQoS8KWcxlg7qOgciYPkylSSQs2UoH2hxWilLoJYiJOtttZAqWKBCtP340fawul3D88/TuKiMwriI2UKv73w48NFJJ4nMYp4t2nZzqltmhbJPYnck2zE5a0CyYYCrJwJIZPOFasionGqgRYSeB7fGN2MD2fnuuW7DGp8uL3JwJpuoGxjkjBcMyc+GL78q0UyxJURHhhss6DK3UgBLRCihlL1jB3bdOMOcrZdq5TSvBQuySsaoMbnPN+gL+Z6HGMyEOks6oebTE0Kc0xSR+uUD5KlC3boFi+AKJ+bbkcNPqIJcR0j81smROfs2MS2+TjIJiEs0E/ePA5AA4oEj+oC94aSqAmnrUy/kg/Syw3Q4NeOy+9MbsW/LLBLae1icO3Ww/880kKgEoKXnOEkxyBIrbag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: arzYl5J8WWVTGDjtv5uoHpGjpke4e8tPUQVCKbgpUnQeOz5N9IARoKTAWjYHsbMKlEsrcJ6Si5Ht7hV+zyNFEjXxO1T6veQJX96CGcw2FX7Rku1VCs8GmYNmiBEjGiDnshcvtyZ+81tvJvfwLeracto9qytcURDoTtTg+jwP0VxlOgidyh68V/N/Jxy/y6v+59EL34ASW8Gw6HZUDPq2qpOcm9hsBxKPGEp8u+8ejob3FtaU9qxvjRGAkGfCK1AuimoZHOe5n8XaDeww4jJ4kMzIhhAURTkq8tIIR9bEz+LUY4qUyPPrJ90uXFelnDeASM2fUz9G1nAQVGSShLypqtV4+S1gbkr/pXV59G83Ow3ddLjM2bu5m5LxWxpJyJfv5wxY3+i0QztarWpES8Rx4YmRet+01WuINI6m7NyIKt2Hwj+klXMoCGed/GY6M56S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:19:24.6837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad309fd-83a3-4771-4c1c-08de88a42143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
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

v2: add check !adev->bios (Lijo)

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

