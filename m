Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3749C5DF6A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF1510F70E;
	Fri, 14 Aug 2026 21:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HkXy71+Y";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF5410F70C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szd9oA983l+GqvS8vi8mIlJh3uy+4fgLN3CqH8JW1gJWdwUZCPCaUcgmYDuuVMGMSzZvLlcU7m5NEGn3LPW/5QVkJKolIXTUxNY5fMXeGXwSuWs2njK7TP0jfAk8qb2PyS3sy8r3Ye8iS+OLeUfGz03rINTO8xDkBmD3/9bqL4DU0vHLKoDJa9s5/mwj8Z7AV7U/mKTJy/J+1cYa8H2/aZmtlGJC2bEqnJbeSVle4EB0AlfBC1WV+64TTF9kCmxVe4Yh1/QAPc/S0vsSlLjCnEnkMe1wyyDkFzE4WXaRQIRKH0Y3B6litzHyI2yRY5huUTzPZmwy2NcDwdQsOdakaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFw4HJs/A2VWFcpZnDxQgzU8O1l0bb9q8AFMnmMsSgU=;
 b=LnaRxVo5MtOzLIfdMQb1pim3Wfyn2I1OBON/GYYVVNSqbiwx/7yx9v0m3l14sD6Asm4L0CjUqx9Ix6Y325QSrqlcsQGTTdFcNiIdvz6O9tHrPEKzC584nKDTXxZVZZicEbtqBZ7biQubYRm1/ohiqKzRXvh3La885B/Ot76ipEBPa8FyKsj4zEBtalYRkljIyaZmb1XT6bH1t4flUxg14K+wYlfbdQuvf/9RnOu65fYhiPf+XiRK/doup0UjKKLfH6p946OtQqQ5kl3RnxlAykSxHcjxOzR3o3ENW/wf9if/egmHf99DDHqdfdsjgmBVdwfJeoxLxxy4Mc3QHVQTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFw4HJs/A2VWFcpZnDxQgzU8O1l0bb9q8AFMnmMsSgU=;
 b=HkXy71+Yp3CaWJBOQXZwwNbZNp51LVYj0eWpgLPsZBHOoJhZYuzQL/091Z2QhMBKvcJNXlQxfGBLGu1fHVFRDTe2fR6uW3AyvG0srFJI3LWg12Cf965NogI9TP8DTcmOtiKrsgttidffyvpL/ye2AyHF5tB62VtMGf6wVjkNcZc=
Received: from DS7PR03CA0308.namprd03.prod.outlook.com (2603:10b6:8:2b::31) by
 CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.16; Fri, 14 Aug 2026 21:03:30 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::21) by DS7PR03CA0308.outlook.office365.com
 (2603:10b6:8:2b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 041/109] drm/amd/ras: add interfaces to manage multiple EEPROMs
Date: Fri, 14 Aug 2026 17:01:38 -0400
Message-ID: <20260814210246.3067612-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 01be25be-61d4-4c86-b738-08defa477e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|3023799007|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 2II8ipV+wRMiRm7y8sDmsjFwkWbh9UsmQIlH4+gXzazhgAWS7Jec9EtGnh+EK7Q3O1MxEUl9Ug8wi7n1sE6Pn8piOmHsKhGAtbWP8dMDTX2WwTVGVJxHLfO+eW4yiGDa6OxkQ9yEb1Qe4UWdgHkw7qT33IjgdYBS6k1oSr9rzMNjdHnSskoNl/5nKdRS9w8tge8bgyzN8YMndegDbJBsCdui3ioYvpao5TQFdDcB8ctKjQwYsGT1FafwTuacpQABh+finiBZGsEW4FvM85oeA9F+oJksiSvRwutn2WmG9sSEKGwkM+OK67uliZxKkpLKQAYp4pQNRWV3/UZmPJzDa1uFSCCltVNwHn4ah21NVkpB2rz3CwUMypYhCB+/oCDO3oLQ4Zi/JC82ZaorIQxPxiEKl2fOJs1YPXpr263JBnm/xITikIKaDlvbX6JaBVVZNl/9ud/wPl9EzeGS2mx91E09fmztqVl8JN868inVbLWxxiKTG9pgA4LzdzoR0QXrxIqzD8g7xJXbTXxs50XB+mTGZwa11JI3bPc4lxyQ6KIOb0htnfKZe5fSkp4ctONcLqCCZlJjLC3tXXJ+Nw8DXW0fWTNPDvJsf0yjdNZf1OfSk3I1izdUm/yK1aZzpYgKlLGoApe33r5Jbsk+H0s8HbqCbd0X0XqagNY5DfM0y8M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 43UQEpB3Cb5ycCB96RzRWbZVGB5e5XhoH3E6oXdlZQIvVjaAsm+YmZ3EFkq+HEGi7IFoLvNXIVzSL8MiBSLmTuPMlIo91RdvcTKdDEkR515avx8pUP9c1l68llnym67D53OkoxbEI0+Hzq2dkvx+F4c65lO1sCbEVsmDJGwxsBMso8XMZlfCp4GHEIujsy4kza4i2dqD4XW3Fnt0jDCHSm6oG7z22VfnZoXByg2i529SGCEmW7PW1nEzRVGGSCJnM02CXl8TvjTftEOEEfLvy+yo4am+4HGhFUyJdAN+V5CUJYlHzxcM/T6AEKfAzTEM1yR9yTykRo1JDTMOtIRhtdecnrLWJMYrPdktyLonXY7uulB6Hyx54Vbk3HvsNECKzUTju9zo1WHKsac9A3vSoaSIzaHJgMBUV46tgWp23hbCt4g/gaLJ3DjZOgKmQomt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:29.8075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01be25be-61d4-4c86-b738-08defa477e1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add interfaces to manage multiple EEPROMs.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 413 ++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h | 123 ++++++
 2 files changed, 536 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h

diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
new file mode 100644
index 0000000000000..d56e065ccfc74
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "ras_eeprom_mgr.h"
+#include "ras.h"
+#include "eeprom.h"
+
+static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)
+{
+	return !ras_core->ras_eeprom_supported;
+}
+
+static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip_func(
+				struct ras_core_context *ras_core, uint32_t ip_version)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+
+	switch (ip_version) {
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 12):
+		mgr->eeprom_early_init_service_supported = false;
+		return &ras_drv_eeprom_ops;
+	default:
+		RAS_DEV_ERR(ras_core->dev,
+			"EEPROM(MP1) ip version(0x%x) is not supported!\n", ip_version);
+		break;
+	}
+
+	return NULL;
+}
+
+int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	struct ras_eeprom_config *cfg;
+	struct ras_eeprom_param_config  param_cfg = {0};
+	struct ras_eeprom_param eeprom_param = {0};
+	int ret = 0;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return 0;
+
+	cfg = &ras_core->config->eeprom_cfg;
+	if (!cfg || !cfg->eeprom_sys_fn || !cfg->eeprom_sys_fn->get_eeprom_config) {
+		RAS_DEV_ERR(ras_core->dev, "Ras eeprom not configured!\n");
+		return -EINVAL;
+	}
+
+	memset(mgr, 0, sizeof(*mgr));
+
+	mgr->sys_func = cfg->eeprom_sys_fn;
+	ret = mgr->sys_func->get_eeprom_config(ras_core, &param_cfg);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to get ras eeprom param config!\n");
+		return -EPERM;
+	}
+
+	mgr->ras_err_threshold = param_cfg.eeprom_record_threshold_count;
+	mgr->work_mode_over_thresh = param_cfg.work_mode_over_thresh;
+	mgr->eeprom_ip_version = param_cfg.eeprom_ip_version;
+	mgr->eeprom_ops = ras_eeprom_mgr_get_ip_func(ras_core, mgr->eeprom_ip_version);
+	if (!mgr->eeprom_ops)
+		return -ENODEV;
+
+	eeprom_param.sys_fn = mgr->sys_func;
+	eeprom_param.eeprom_ip_version = param_cfg.eeprom_ip_version;
+	eeprom_param.record_threshold = param_cfg.eeprom_record_threshold_count;
+	eeprom_param.max_i2c_read_len = param_cfg.max_i2c_read_len;
+	eeprom_param.max_i2c_write_len = param_cfg.max_i2c_write_len;
+	eeprom_param.eeprom_i2c_adapter = param_cfg.eeprom_i2c_adapter;
+	eeprom_param.eeprom_i2c_port = param_cfg.eeprom_i2c_port;
+	eeprom_param.eeprom_i2c_addr = param_cfg.eeprom_i2c_addr;
+
+	if (mgr->eeprom_ops->sw_init)
+		ret = mgr->eeprom_ops->sw_init(ras_core, &eeprom_param);
+
+	return ret;
+}
+
+int ras_eeprom_mgr_sw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	int ret = 0;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return 0;
+
+	if (!mgr->eeprom_ops)
+		return -EINVAL;
+
+	if (mgr->eeprom_ops->sw_fini)
+		ret = mgr->eeprom_ops->sw_fini(ras_core);
+
+	return ret;
+}
+
+int ras_eeprom_mgr_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	struct ras_eeprom_param_config  param_cfg = {0};
+	struct ras_eeprom_param eeprom_param = {0};
+	int ret = 0;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return 0;
+
+	if (!mgr->eeprom_ops)
+		return -EINVAL;
+
+	ret = mgr->sys_func->get_eeprom_config(ras_core, &param_cfg);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to get ras eeprom param config!\n");
+		return -EPERM;
+	}
+
+	eeprom_param.max_i2c_read_len = param_cfg.max_i2c_read_len;
+	eeprom_param.max_i2c_write_len = param_cfg.max_i2c_write_len;
+	eeprom_param.eeprom_i2c_adapter = param_cfg.eeprom_i2c_adapter;
+	eeprom_param.eeprom_i2c_port = param_cfg.eeprom_i2c_port;
+	eeprom_param.eeprom_i2c_addr = param_cfg.eeprom_i2c_addr;
+
+	if (mgr->eeprom_ops->hw_init)
+		ret = mgr->eeprom_ops->hw_init(ras_core, &eeprom_param);
+
+	return ret;
+}
+
+int ras_eeprom_mgr_hw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	int ret = 0;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return 0;
+
+	if (!mgr->eeprom_ops)
+		return -EINVAL;
+
+	if (mgr->eeprom_ops->hw_fini)
+		ret = mgr->eeprom_ops->hw_fini(ras_core);
+
+	return ret;
+}
+
+int ras_eeprom_mgr_reset_table(struct ras_core_context *ras_core)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	int ret = -EOPNOTSUPP;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return 0;
+
+	if (!mgr->eeprom_ops)
+		return -EINVAL;
+
+	if (mgr->eeprom_ops->reset_table)
+		ret = mgr->eeprom_ops->reset_table(ras_core);
+
+	return ret;
+}
+
+int ras_eeprom_mgr_get_record_count(struct ras_core_context *ras_core)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	int ret = 0;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return 0;
+
+	if (!mgr->eeprom_ops)
+		return -EINVAL;
+
+	if (mgr->eeprom_ops && mgr->eeprom_ops->get_record_count)
+		ret = mgr->eeprom_ops->get_record_count(ras_core);
+
+	return ret;
+}
+
+int ras_eeprom_mgr_get_records(struct ras_core_context *ras_core, u32 start,
+		struct eeprom_umc_record *record, u32 num)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	int ret = -EOPNOTSUPP;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return -RAS_CORE_NOT_SUPPORTED;
+
+	if (!mgr->eeprom_ops)
+		return -EINVAL;
+
+	if (mgr->eeprom_ops->get_records)
+		ret = mgr->eeprom_ops->get_records(ras_core,
+					start, record, num);
+
+	return ret;
+}
+
+int ras_eeprom_mgr_append_records(struct ras_core_context *ras_core,
+			struct eeprom_umc_record *record, const u32 num)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	int ret = -EOPNOTSUPP;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return -RAS_CORE_NOT_SUPPORTED;
+
+	if (!mgr->eeprom_ops)
+		return -EINVAL;
+
+	if (mgr->eeprom_ops->append_records)
+		ret = mgr->eeprom_ops->append_records(ras_core,
+					record, num);
+
+	return ret;
+}
+
+int ras_eeprom_mgr_get_eeprom_info(struct ras_core_context *ras_core,
+			struct ras_eeprom_info *eeprom_info)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return -EOPNOTSUPP;
+
+	if (!mgr->eeprom_ops || !mgr->eeprom_ops->get_eeprom_info)
+		return -EOPNOTSUPP;
+
+	return mgr->eeprom_ops->get_eeprom_info(ras_core,
+				eeprom_info, ras_core_gpu_in_reset(ras_core));
+}
+
+int ras_eeprom_mgr_check_and_report_status(struct ras_core_context *ras_core, bool chk_hw)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	struct ras_eeprom_info info = {0};
+	int valid_err_count;
+	int ret = 0;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return 0;
+
+	if (!mgr->eeprom_ops || !mgr->eeprom_ops->get_eeprom_info)
+		return -EOPNOTSUPP;
+
+	ret = mgr->eeprom_ops->get_eeprom_info(ras_core, &info, !chk_hw);
+	if (ret)
+		return ret;
+
+	valid_err_count = ras_umc_get_saved_eeprom_count(ras_core);
+	if (info.eeprom_status == RAS_EEPROM_OK) {
+		RAS_DEV_DBG(ras_core->dev,
+			"Found existing EEPROM table with %d records\n",
+			valid_err_count);
+
+		/* Warn if error count reaches or exceeds 90% of the threshold */
+		if (10 * valid_err_count >= 9 * mgr->ras_err_threshold)
+			RAS_DEV_WARN(ras_core->dev,
+				"RAS records:%u exceeds 90%% of threshold:%d\n",
+				valid_err_count, mgr->ras_err_threshold);
+
+	} else if (info.eeprom_status == RAS_EEPROM_LOCKED) {
+		if (info.rma_status || (valid_err_count >= mgr->ras_err_threshold)) {
+			if (info.rma_status)
+				RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed error threshold",
+					valid_err_count);
+			else
+				RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed threshold:%d",
+					valid_err_count, mgr->ras_err_threshold);
+
+			if (mgr->work_mode_over_thresh == RAS_WORK_MODE_OVER_THRESH_STRICT) {
+				RAS_DEV_WARN(ras_core->dev,
+				"Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
+			} else if (mgr->work_mode_over_thresh == RAS_WORK_MODE_OVER_THRESH_RMA) {
+				ras_core->is_rma = true;
+				RAS_DEV_ERR(ras_core->dev,
+				"User defined threshold is set, runtime service will be halt when threshold is reached\n");
+			}
+		} else if ((valid_err_count < mgr->ras_err_threshold) &&
+				mgr->eeprom_ops->unlock_eeprom) {
+			/* This means that, the threshold was increased since
+			 * the last time the system was booted, and now,
+			 * the saved error count is less than threshold,
+			 * so that at least one more record can be saved,
+			 * before the page count threshold is reached.
+			 */
+			ret = mgr->eeprom_ops->unlock_eeprom(ras_core);
+			if (ret) {
+				RAS_DEV_ERR(ras_core->dev, "Failed to resize RAS table\n");
+			} else {
+				ras_core->is_rma = false;
+				RAS_DEV_INFO(ras_core->dev,
+					"records:%d threshold:%d, resetting RAS table header signature",
+					valid_err_count, mgr->ras_err_threshold);
+			}
+		} else {
+			RAS_DEV_ERR(ras_core->dev,
+				"records:%d threshold:%d, not support to resize RAS table\n",
+				valid_err_count, mgr->ras_err_threshold);
+		}
+	} else {
+		RAS_DEV_ERR(ras_core->dev, "Error ras eeprom status:0x%x\n", info.eeprom_status);
+	}
+
+	return ret;
+}
+
+enum ras_gpu_op_status
+	ras_eeprom_mgr_get_gpu_op_status(struct ras_core_context *ras_core)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	struct ras_eeprom_info info = {0};
+	int ret;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return RAS_GPU_OP_STATUS_OK;
+
+	if (!mgr->eeprom_ops || !mgr->eeprom_ops->get_eeprom_info)
+		return RAS_GPU_OP_STATUS_UNKNOWN;
+
+	ret = mgr->eeprom_ops->get_eeprom_info(ras_core,
+				&info, ras_core_gpu_in_reset(ras_core));
+	if (ret)
+		return RAS_GPU_OP_STATUS_UNKNOWN;
+
+	if (info.rma_status || ras_core->is_rma)
+		return RAS_GPU_OP_STATUS_RMA;
+
+	if (info.eeprom_status == RAS_EEPROM_FAULT)
+		return RAS_GPU_OP_STATUS_FAULT;
+	else if (info.eeprom_status == RAS_EEPROM_LOCKED)
+		return RAS_GPU_OP_STATUS_LOCKED;
+	else if (info.eeprom_status == RAS_EEPROM_UNKNOWN)
+		return RAS_GPU_OP_STATUS_UNKNOWN;
+
+	return RAS_GPU_OP_STATUS_OK;
+}
+
+bool ras_eeprom_mgr_check_safety_watermark(struct ras_core_context *ras_core)
+{
+	enum ras_gpu_op_status status;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return true;
+
+	ras_eeprom_mgr_check_and_report_status(ras_core, false);
+
+	status = ras_eeprom_mgr_get_gpu_op_status(ras_core);
+
+	return (status == RAS_GPU_OP_STATUS_OK);
+}
+
+int ras_eeprom_mgr_get_version(struct ras_core_context *ras_core, u32 *version)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+	struct ras_eeprom_info info = {0};
+	int ret = 0;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return 0;
+
+	if (!mgr->eeprom_ops || !mgr->eeprom_ops->get_eeprom_info)
+		return -EOPNOTSUPP;
+
+	ret = mgr->eeprom_ops->get_eeprom_info(ras_core, &info, true);
+	if (ret)
+		return ret;
+
+	*version = info.record_format_version;
+
+	return 0;
+}
+
+bool ras_eeprom_mgr_early_init_service_supported(struct ras_core_context *ras_core)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return false;
+
+	return mgr->eeprom_early_init_service_supported;
+}
+
+bool ras_eeprom_mgr_fw_record_enabled(struct ras_core_context *ras_core)
+{
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
+
+	if (__ras_eeprom_disabled(ras_core))
+		return false;
+
+	return mgr->fw_record_enabled;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
new file mode 100644
index 0000000000000..5f249ede0d40b
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __RAS_EEPROM_MGR_H__
+#define __RAS_EEPROM_MGR_H__
+
+enum ras_gpu_op_status {
+	RAS_GPU_OP_STATUS_UNKNOWN = 0,
+	RAS_GPU_OP_STATUS_OK      = 1,
+	RAS_GPU_OP_STATUS_LOCKED  = 2,
+	RAS_GPU_OP_STATUS_FAULT   = 3,
+	RAS_GPU_OP_STATUS_RMA     = 4,
+};
+
+enum ras_eeprom_status {
+	RAS_EEPROM_UNKNOWN,
+	/*Read and write */
+	RAS_EEPROM_OK,
+	/* Only read */
+	RAS_EEPROM_LOCKED,
+	/* Invalid data */
+	RAS_EEPROM_FAULT,
+};
+
+struct ras_eeprom_param {
+	u32 eeprom_ip_version;
+	uint32_t record_threshold;
+	void *eeprom_i2c_adapter;
+	u32 eeprom_i2c_addr;
+	u32 eeprom_i2c_port;
+	u16 max_i2c_read_len;
+	u16 max_i2c_write_len;
+	const struct ras_eeprom_sys_func *sys_fn;
+};
+
+struct ras_eeprom_info {
+	u32 record_format_version;
+	u32 eeprom_status;
+	u32 rma_status;
+	/* Raw record count in eeprom, but data may be duplicated,
+	 * therefore not a valid record count
+	 */
+	u32 record_count;
+	u32 max_record_count;
+	u64 bad_channel_bitmap;
+};
+
+struct ras_core_context;
+struct eeprom_umc_record;
+
+struct ras_eeprom_ops {
+	int (*sw_init)(struct ras_core_context *ras_core, struct ras_eeprom_param *param);
+	int (*sw_fini)(struct ras_core_context *ras_core);
+	int (*hw_init)(struct ras_core_context *ras_core, struct ras_eeprom_param *param);
+	int (*hw_fini)(struct ras_core_context *ras_core);
+	int (*reset_table)(struct ras_core_context *ras_core);
+	int (*get_records)(struct ras_core_context *ras_core, u32 start,
+		struct eeprom_umc_record *records, u32 num);
+	int (*append_records)(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *records, u32 num);
+	u32 (*get_record_count)(struct ras_core_context *ras_core);
+	int (*get_eeprom_info)(struct ras_core_context *ras_core,
+		struct ras_eeprom_info *eeprom_info, bool fast_mode);
+	int (*unlock_eeprom)(struct ras_core_context *ras_core);
+};
+
+struct ras_eeprom_mgr {
+	u32 eeprom_ip_version;
+	const struct ras_eeprom_sys_func *sys_func;
+	void *ras_eeprom;
+	const struct ras_eeprom_ops *eeprom_ops;
+	u32 ras_err_threshold;
+	u32 work_mode_over_thresh;
+	bool eeprom_early_init_service_supported;
+	bool fw_record_enabled;
+};
+
+struct ras_core_context;
+int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core);
+int ras_eeprom_mgr_sw_fini(struct ras_core_context *ras_core);
+int ras_eeprom_mgr_hw_init(struct ras_core_context *ras_core);
+int ras_eeprom_mgr_hw_fini(struct ras_core_context *ras_core);
+int ras_eeprom_mgr_reset_table(struct ras_core_context *ras_core);
+int ras_eeprom_mgr_get_record_count(struct ras_core_context *ras_core);
+int ras_eeprom_mgr_get_records(struct ras_core_context *ras_core, u32 start,
+		struct eeprom_umc_record *record, const u32 num);
+int ras_eeprom_mgr_append_records(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *record, const u32 num);
+int ras_eeprom_mgr_check_and_report_status(struct ras_core_context *ras_core,
+		bool check_hw);
+enum ras_gpu_op_status
+	ras_eeprom_mgr_get_gpu_op_status(struct ras_core_context *ras_core);
+int ras_eeprom_mgr_get_version(struct ras_core_context *ras_core, u32 *version);
+bool ras_eeprom_mgr_check_safety_watermark(struct ras_core_context *ras_core);
+int ras_eeprom_mgr_get_eeprom_info(struct ras_core_context *ras_core,
+			struct ras_eeprom_info *eeprom_info);
+int ras_core_enable_early_init_service(struct ras_core_context *ras_core,
+		bool enabled);
+bool ras_eeprom_mgr_early_init_service_supported(struct ras_core_context *ras_core);
+bool ras_eeprom_mgr_fw_record_enabled(struct ras_core_context *ras_core);
+int  ras_eeprom_mgr_dump_fw_records(struct ras_core_context *ras_core);
+#endif
-- 
2.55.0

