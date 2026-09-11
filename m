Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67D8C79FA1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 06:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5322F10F4F2;
	Fri, 11 Sep 2026 06:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1N+S7W/W";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141F310F4F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 06:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHix92wadjljTcoim4ri32KBhgUZdEWzG9r+KK6y7t6TADSvCtKhM13ipA+TO2hZU46ofjGTXmcTPL1MjwXkscsRvdT06JiVuXqdOgNIFf5tmtpEQgqYv1ovIVO+FKTdL+/1ac81TwpxT51OZ5fbiZkew4XLLFgXSm0e+Uq0+lfzOtYxJZTMSAG2imG4bSPpDP2E3rvCTDF8C+6Xi0QtTXSyRkIUbdsdY2LfwyX4uOl6ymK3/us6O2QlPFP8JOJuzvKgDoL1ntdZJMCXJBIynvLfSr8zr/t8BDjvQDo3N6KgHkvzTlJ1x0cLrzaQr5L85F6TSARVgFc6Pk1+XkIqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnw7B6kojkKBXlX7m7+7dJdWd/A7mhhmfwwT3LiqXaM=;
 b=IQ+aqTfvOA9mDp9nH5SXVcJkqMt9yWcv8pBdARSlJ8iz5YiSzgXDlzaEIQsSuAUwdgNp00O3hH6JPrkesl1UA9rIalFqFMUowGPqQwXCjy5B2BPFkC79ifVIKe6POlWf+aVPFI2vWNgc14bS4piychZgm31yiWswd4tFCx9+shom//4mTq93mc/kXatTiNRXn4Tual0KS1gXWfsiRpc5YxAeOjjVh+GJ6mQ4pS03OdKDWp6PAIkKJcSeHGMuA3iBGzN30icxdGCerL7Q76Fh+GDVBKH7A4cnaK4WwgrLZUujM9pmntTjhHkYLs4gehJBbYn0Ou7Ch5K9GEoXgJpRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnw7B6kojkKBXlX7m7+7dJdWd/A7mhhmfwwT3LiqXaM=;
 b=1N+S7W/WhKdJIAIzbRJgedG9ZHpe0ARYKLFGVbX5Shv9JTeNvsqTNiVOF1H+R+iM7eMyqc/0CrQ+NiWRyqJPR3AFFbI7gDH3+NK2UufTvS0ybATZiQThjoBBxJaDiUDrNVvqPTt09PsaHJyuvO1qPTnCCFJ2TVBaXf+UUGR38KY=
Received: from CH2PR04CA0003.namprd04.prod.outlook.com (2603:10b6:610:52::13)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 06:46:13 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::32) by CH2PR04CA0003.outlook.office365.com
 (2603:10b6:610:52::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 06:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 06:46:12 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:46:10 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 6/6] drm/amd/ras: remove obsolete ras mp1 v13 manager code
Date: Fri, 11 Sep 2026 14:44:10 +0800
Message-ID: <20260911064410.1693567-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
References: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: ee37ccfc-36f1-4e0e-d148-08df0fd05ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YahY/QX4kxVSJpiwbWNbfDFGOFouuEMpp/b4vzShGZgIXKyGkau0BeKr2+LsBeiQLBqBZmFbqkMItSnTDJRN62ntnTHU26s6zEO1rb/2dqOved05ieA85JB0CDI8VLGqF7d81XE2atYEC9d6X8TLq5DDlEP0Ru11rexFh+seEZv2I5TmaUGz1p1dgkF/tSnKb61kxWa26VsWqoNk5oxWRlWurfAlpvE7WmnyK9ZkiqBNW0wjZEG2Mn8ynZyjG1RMddhQZ+eU+aVqPa5gCwXrX/1AfWQT2/a4P1zbEEflJYCjbc3eM7CyTZZtA25q5scNb+vkAx1QY/fUMtZZiswbkcNaaHGi7z0vQtFXgS4/2sMoDumgg0woeAt/oYJX2P1VOuaE5FHrkK+gHl+8GyY0dReKDpqFPyNvqer07azWu9H88vRLz6f/T7mV613+m/UJ/XqQ97mDBGdEwTMfGWYxTFOYpi+T5ZEyoIX+qAxrfcMmKqLsfS/IOaNImgASXu9UFK5MS7qLCORAoG3bIi7GaUQgSpeA08o7yPlNvgQdrQIC9VDjD3rZg7TQDaO8EsekSnmC9zocTDTztDo9htyz0/JCLzHE+07AtCfmeTGTUKipYt6cXJuFRwpWI+axL0Qx3KljurkfkpwkqIhjuZI3sBXR8YuTvZfe7XDjAgypIMwxGh42xQyAV5clQ7fvlUeNdFZFS0yu1vH6h8Qyj2sBuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g+tnA6N76ReqcVQaaJ0iZJ4AmNJFHt/hiPo8nwQIc3CMZ/Ciw1I4CRDrubW3wtfOYHhBnLYGpNkkq2IjABadKtK7W8cgpHCL1acAdKLyLCQSOQPkVDptiil766rjCFxuWuFSkULma9WqndnDnrtS/fe0ea3ocBSi4XNdUCZbM5M3ql0JyEPk/lsj0gvHUuCnPUUWgE1ODXHnJx/lLR0WTNwxTuai7WUUB9ne6KgZBsllWtnTDkQ1MaHIhG4zU2tCEmAgHX56jqfyubozq+V/lOLrqEhbVNqeRA3HF4uwvFpfQIO8qTe8MCfNVT0hFhZaQxI381/PNVri1eX0Y0jt2gUF0wLBI8pt47blGcYDJC2vxR8lukAtuOqkIhwQ2VOxEoQ+OkwiqQ73bT+t3ZD0z654DFhyH/beBFu5GpyoIq/M9cbMO8cf34AQt7vXjzno
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:46:12.6810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee37ccfc-36f1-4e0e-d148-08df0fd05ebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
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

Remove obsolete ras mp1 v13 manager code.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |   9 -
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile      |   1 -
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |   1 -
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 161 ------------------
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h    |  30 ----
 5 files changed, 202 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
 delete mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 47fa30f94a2a..73e3960c7c8e 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -205,15 +205,6 @@ struct ras_psp;
 struct ras_eeprom_mgr;
 
 struct ras_mp1_sys_func {
-	int (*mp1_get_valid_bank_count)(struct ras_core_context *ras_core,
-			u32 msg, u32 *count);
-	int (*mp1_dump_valid_bank)(struct ras_core_context *ras_core,
-			u32 msg, u32 idx, u32 reg_idx, u64 *val);
-	int (*mp1_send_eeprom_msg)(struct ras_core_context *ras_core,
-			u32 msg_id, uint32_t param, uint32_t *read_arg);
-	int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
-			uint64_t *enabled_mask);
-	int (*mp1_set_debug_mode)(struct ras_core_context *ras_core, bool enable);
 	int (*mp1_send_ras_msg)(struct ras_core_context *ras_core, u32 msg_id,
 		u32 *params, u32 num_params, u32 *read_args, u32 num_read_args);
 	int (*check_ras_feature_status)(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
index 4f94c97c15ca..c70760f10ffd 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
@@ -21,7 +21,6 @@
 RAS_MGR_FILES = amdgpu_ras_sys.o  \
 		amdgpu_ras_mgr.o \
 		amdgpu_ras_eeprom_i2c.o \
-		amdgpu_ras_mp1_v13_0.o \
 		amdgpu_ras_mp1.o \
 		amdgpu_ras_cmd.o \
 		amdgpu_virt_ras_cmd.o \
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 7dd8a331bd1d..07dd62ae460b 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -30,7 +30,6 @@
 #include "amdgpu_virt_ras_cmd.h"
 #include "amdgpu_ras_process.h"
 #include "amdgpu_ras_eeprom_i2c.h"
-#include "amdgpu_ras_mp1_v13_0.h"
 #include "amdgpu_ras_mp1.h"
 #include "amdgpu_ras_nbio_v7_9.h"
 #include "amdgpu_ras_bert.h"
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
deleted file mode 100644
index 548594373d0b..000000000000
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ /dev/null
@@ -1,161 +0,0 @@
-// SPDX-License-Identifier: MIT
-/*
- * Copyright 2025 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#include "amdgpu_smu.h"
-#include "amdgpu_reset.h"
-#include "amdgpu_ras_mp1_v13_0.h"
-#include "smu13_driver_if_v13_0_6.h"
-
-#define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
-#define RAS_MP1_MSG_McaBankCeDumpDW       0x3B
-
-static const enum smu_message_type pmfw_eeprom_msgs[] = {
-	[RAS_SMU_GetRASTableVersion] = SMU_MSG_GetRASTableVersion,
-	[RAS_SMU_GetBadPageCount] = SMU_MSG_GetBadPageCount,
-	[RAS_SMU_SetTimestamp] = SMU_MSG_SetTimestamp,
-	[RAS_SMU_GetTimestamp] = SMU_MSG_GetTimestamp,
-	[RAS_SMU_GetBadPageIpid] = SMU_MSG_GetBadPageIpid,
-	[RAS_SMU_EraseRasTable] = SMU_MSG_EraseRasTable,
-	[RAS_SMU_GetBadPageMcaAddr] = SMU_MSG_GetBadPageMcaAddr,
-};
-
-static int mp1_v13_send_smu_msg(struct amdgpu_device *adev, enum smu_message_type msg,
-			uint32_t param, uint32_t *read_arg)
-{
-	return amdgpu_smu_ras_send_msg(adev, msg, &param, 1, read_arg, read_arg ? 1 : 0);
-}
-
-static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_core,
-					  u32 msg, u32 *count)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	u32 smu_msg;
-	int ret = 0;
-
-	if (!count)
-		return -EINVAL;
-
-	smu_msg = (msg == RAS_MP1_MSG_QueryValidMcaCeCount) ?
-			SMU_MSG_QueryValidMcaCeCount : SMU_MSG_QueryValidMcaCount;
-
-	if (down_read_trylock(&adev->reset_domain->sem)) {
-		ret = mp1_v13_send_smu_msg(adev, smu_msg, 0, count);
-		up_read(&adev->reset_domain->sem);
-	} else {
-		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
-	}
-
-	if (ret)
-		*count = 0;
-
-	return ret;
-}
-
-static int mp1_v13_0_dump_valid_bank(struct ras_core_context *ras_core,
-				     u32 msg, u32 idx, u32 reg_idx, u64 *val)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	uint32_t data[2] = {0, 0};
-	uint32_t param;
-	int ret = 0;
-	int i, offset;
-	u32 smu_msg = (msg == RAS_MP1_MSG_McaBankCeDumpDW) ?
-			     SMU_MSG_McaBankCeDumpDW : SMU_MSG_McaBankDumpDW;
-
-	if (down_read_trylock(&adev->reset_domain->sem)) {
-		offset = reg_idx * 8;
-		for (i = 0; i < ARRAY_SIZE(data); i++) {
-			param = ((idx & 0xffff) << 16) | ((offset + (i << 2)) & 0xfffc);
-			ret = mp1_v13_send_smu_msg(adev, smu_msg, param, &data[i]);
-			if (ret) {
-				RAS_DEV_ERR(adev, "ACA failed to read register[%d], offset:0x%x\n",
-					reg_idx, offset);
-				break;
-			}
-		}
-		up_read(&adev->reset_domain->sem);
-
-		if (!ret)
-			*val = (uint64_t)data[1] << 32 | data[0];
-	} else {
-		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
-	}
-
-	return ret;
-}
-
-static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
-				u32 msg_id, uint32_t param, uint32_t *read_arg)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	int ret = 0;
-
-	if (down_read_trylock(&adev->reset_domain->sem)) {
-		ret = mp1_v13_send_smu_msg(adev,
-			pmfw_eeprom_msgs[msg_id], param, read_arg);
-		up_read(&adev->reset_domain->sem);
-	} else {
-		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
-	}
-
-	return ret;
-}
-
-static int mp1_v13_0_get_ras_enabled_mask(struct ras_core_context *ras_core,
-					     uint64_t *enabled_mask)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	int ret = 0;
-
-	if (down_read_trylock(&adev->reset_domain->sem)) {
-		if (amdgpu_smu_ras_feature_is_enabled(adev, SMU_FEATURE_HROM_EN_BIT))
-			*enabled_mask |= RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM;
-		up_read(&adev->reset_domain->sem);
-	} else {
-		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
-	}
-
-	return ret;
-}
-
-static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core, bool enable)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	u32 param = enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK |
-		ClearMcaOnRead_CE_POLL_MASK;
-	int ret;
-	u32 smu_msg = SMU_MSG_ClearMcaOnRead;
-
-	ret = amdgpu_smu_ras_send_msg(adev, smu_msg,
-			&param, 1, NULL, 0);
-	return ret;
-}
-
-const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 = {
-	.mp1_get_valid_bank_count = mp1_v13_0_get_valid_bank_count,
-	.mp1_dump_valid_bank = mp1_v13_0_dump_valid_bank,
-	.mp1_send_eeprom_msg = mp1_v13_0_eeprom_send_msg,
-	.mp1_get_ras_enabled_mask = mp1_v13_0_get_ras_enabled_mask,
-	.mp1_set_debug_mode = mp1_v13_0_set_debug_mode,
-};
-
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h
deleted file mode 100644
index 71c614ae1ae4..000000000000
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Copyright 2025 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#ifndef __AMDGPU_RAS_MP1_V13_0_H__
-#define __AMDGPU_RAS_MP1_V13_0_H__
-#include "ras.h"
-
-extern const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0;
-
-#endif
-- 
2.43.0

