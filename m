Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15415D58B00
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 06:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9908110E08C;
	Mon, 23 Mar 2026 06:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DS0sNXa1";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C85210E08C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 06:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ua3SDkLh392JLTNuk1flv+AAnPXdCrB+kt4g5/IAi/0mBFtsk20qzBb+VBpBQzfzRCJ09l2nHPvvCjbzWXkvVamERmv+nRA9X6dmgG0JaijVUk2fQr1RGXD5P4gO0mwyIkubfTj6Ga1UWqfnPUfypNs4QkijGS1KR0AOsgnwINce61GTcBwdWeiF6UTQcIK5NaQCguF4e53Y5qR4TUU5g4bSEPgmd9GUxJhs6DgpTUgD36lwKsscpa+XfdN+vk3K9RsLoRsvc+0LcPcLCVxEWk4jugKC5mGVRScLyclur23Gi+VakQbVVh1X0tcG4r0i4CqOxpztLajg81RRqd+9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU5uEnhiTbSZYm7OXeqHrVvYlWWSReIzY4PFaL/f86Q=;
 b=DIhF2zjaewNZdqgyySgfVeHIkkSXR24ZhZElJKcICNtvHNCrptRNN7W0XQyUd+tJd382Tku0fiI7Er737cE9QrsNzK/qiknCZ/gMRfnC3u5oyFCNXGJdFhjIBjHMt9EQN9Kpbz8an+H8M4g1agylGYXU18ABdMwTHiqIDFyVbe6QPa3jWlkNktWNERgk36B7VpuU+Nh4BPVgXclcVZwVIhV45H8d9JIau3oXeglUrZxJXe3BD2k4xZ5FjhUgCOuS6FPUxv00U3U3WHtfmjsd/MZHoQ6/XJcC3J6dmLv5Kftn4NcD9fMu4FzYzyRa1RkWUMJjJpYoWuX4SSo8X+8AlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU5uEnhiTbSZYm7OXeqHrVvYlWWSReIzY4PFaL/f86Q=;
 b=DS0sNXa1UoPsMPuelFt46CQi4fH4C80aJuj6P9Ra1AxJiGfGZme47s699mZ/HSzIdX5LHUy3Q+hGB2bd3gKnL1fJHXYECZDZk8g4at/WJsj2cbHT+lEIbTrXiUiWCkqEpRrbnnTpqHj+BeNclFgJVXamMACj9A8YoudUe3tIzZQ=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by LVUPR12MB999160.namprd12.prod.outlook.com (2603:10b6:408:3a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 06:06:33 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::19) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 06:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 06:06:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 01:06:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 01:06:32 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 01:06:25 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu: guard atom_context in devcoredump VBIOS dump
Date: Mon, 23 Mar 2026 14:06:04 +0800
Message-ID: <20260323060620.435763-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|LVUPR12MB999160:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ec0f95-db3f-4348-3896-08de88a2555a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Zpde+zWWenl8MGp6ARucSf1ygyNT8icADTWE96KMB+Llc/1FnXwqjOkhAkT6DP7037q7XwKyl9YhYPcjBDIz+sLATzzWQ5fcB46UxdT5LEoqZcCGJQ92H2Pos28zQOsXd43bNgFeWafpahW0G576AnnTNRa/hjyzLArOmILGLG0u33ITDe8aufKcp2CuR1dcxd7ooMJ6UfKsxKVZ4lOn40JFgW+bzAfoSKicsIB8z1bKY+uAlcYS0qVZMiww2S3ls/hj+bIL8OTjG4gGwu0wF37TdeNEhWhgn28dAreEf1n/UWPWLqKvAfUZrg8b904/gsLRYS/wqFs8w99PMl25z4hSX3i6FX3puWCKB1wKuWrdWrqFZt3g7bS1ILtnH/qNbFsxPHk4QLTEG1zM4sKcyvevvbLA+8GXDSVpz59qWZ35vOkXk9cbxFVFoyk506qi51rr/4sleVJWg0d1UKvK9BLUUyiGYJvJLKgKeeKjiek575U9/zKFVJk7DVTR0u5VKoHDfuCQ4Urk9qUWP/kUUchzc6NEBL6RAX0MSKMIsfS6Z7LXZULvxPH5bLLd05varIiRExpAO5AFnkcW4BWOqy0Vj0PoiEgF9RPjwllxC3pmnUi3IeB4151wPuLJPXtd/Rn9g/ProJgtWyH+vUAcTpPOHUnDc3Q/F9GFckZtmiSQgKdSLf7OvQG/ku9ZfXrIjrhO6Y7Z7zMN32VqxYsdCw74oZymuV4TnrUbJ+u8Dn8sa45+4YaOWBRGKxM+p7QY6P0RAAXu4zR8tLSmWeHVMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8KNfa6nB5n54I9SIAhpMt1JhtDyBJ9pnxGhFgMdpSH+hbRB6M+tCPYYcXhu7A1ta7XBlnW1QDsfcFSu/F6tJOSjQ2yqiLOxmAAPhUODa08JCpWx/nxLPqMbMqcAj4P9VS9ZHcvN9RIH7P7y/oQ7DbZ8QQuFuORtX3FZkVAdjYv/DBGIqQk4xgQX7NKvKjPmCTHxzJ5b+HuFuZOWr43FlSn7rMDTnU5t8lPmpLr3j+avU/VADmzrKkB0IdNKlm1/u1jcZlkVrKE5bEFUfhShVRggDzjL4nA7itQv7GUoQePwv0KBez7uYUXI7P3Y52bwQb/9+XEH4deLwHZpHX6WZT9xbZ2fL1fJT7AbSJoTys6JRKz0x2LcS0aPJy50sa74MtHovyvBBCTe/L+eENRjlREcfFey8cPDUGRDt+1SqD6N0ghfmWF37ZOYgu2+dOyJ/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:06:33.0596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ec0f95-db3f-4348-3896-08de88a2555a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999160
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

