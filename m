Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE5ACD6E7D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642C410E62F;
	Fri,  5 Jun 2026 13:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q0vFDTlV";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013009.outbound.protection.outlook.com
 [40.107.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9387E10E62F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3/j5ei93BGYrbPDbFVqtMjvRA3S13R20cFT1X6LAYiG5Zqc7XipYBssYGeIimgVh7n/mAYDdLijrm/YtKjs+gDAkq7eSQ0VTkrScAQboXBhoebw4qQAUOOSsMMNOWMGnZNdAlDaH79TBK2321Xn3J7X+ftZX7QWHKPdWZCrWBJKXCDsFw9Z2NkIpPw7iGKE4xVYW5gqZ/0ZQlcQLn0DspjoVjZDWBPWfOGAYaYfJTI81icKnuxAQ4/TjCvk5PnHkL8nGXskLuDLBf9l3yi5mKy1Ca6TJ7qqYMjwWZlmc6zbRF/v1g1woqXpAiN2ohP+P9/QM500xyjhh63/T63QCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNIKi32IzhrmSDLa5O5YYj8uDbgoYvTDhrjoUFuQZNw=;
 b=nvS8N6ygFFKXmQmw2P6oIPPDMdrBAwBUxmVAq7yBUs1bUDtFxI5rz5mJaOb8/6COD71Y12+TRS4nR0kfka6NP3rSpOuGJu2bCZxFe/gOvkJBomQf+X4NuuFAtrVh7++WxYIw+rzeakZbylDI3zlKng9s/NkKif2KVjvjZVC2q1PkfAqACgYRi9V5BCdvxybgByiAm2FyQn8hoQaNfM8vvEPxIA24sH1MT6k2vvAK1BLx5R6Q/EDoiU3ifiZ15X93BnwjNJhNlwFMtVAFgCf45kwl/LCvhesLYuD6d0V4udX6bg01UgKdrJ2/bTfSOqRy79A6xglyoWHMcHHIoX4xJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNIKi32IzhrmSDLa5O5YYj8uDbgoYvTDhrjoUFuQZNw=;
 b=Q0vFDTlVra6XtN3YJDFP2JVhrN1r25ib5pnvpmmCVAgoTLWs0Xytq/MX9Zc6kWbWRBM2m0/PUdnw1sNxGXxpU/aUPDfyTFVyn6Mpkf7KduzSip4eLW2XmJtRC+EJOOaON+CXZwVocOBZnyUXm0Cuq8e7lcfX3/F3+9apgXsT7JE=
Received: from CH0P221CA0046.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::19)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:44:22 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::98) by CH0P221CA0046.outlook.office365.com
 (2603:10b6:610:11d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 13:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:44:21 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:44:15 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH 06/11] drm/amdgpu: move struct amdgpu_init_level and helpers
 into header file
Date: Fri, 5 Jun 2026 09:43:18 -0400
Message-ID: <20260605134400.956791-7-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605134400.956791-1-shahyan.soltani@amd.com>
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c1196f-604d-4ad9-27b1-08dec3088c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|6133799003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: RH+/gUPp6W2ITJu7LZxHBNb9R8V6/tcat0qKnRUCYZv73XqL5cTqmrp3CFCjxdaE3rgp6KbL7qmta41aYGxW+tn9eiCJK5ybHYryFYw5RpJsufaQ5+cF6UZI0eVpn5lg5UvK96zsrBamPpmecnO1RrfYNgrfE2iCNv6U8t9O5lAEdKhr0k0PBtexDcMEDDZktJuP5xnzBIPyO0kmWNxaaEOpmaYTg+bWVyLZMbT79TdGSOPuRilPw+srM3yn9qA6HjmFrQJOr9o56VxPKYFU6S8PaqKp9d8Cz63XswDloSR+rNIn7bb0oxHyOI82maSA1gpPwYNDfupLZranqA7cG+ZXD//o+pbUa0Sm+0lAAiXqwUpZSXVhi+74kB+C/fOenwbs9uJKAZyJt+elKZ1sJZQerLFY19SlYRLrU+FKIyVdXC96TI2TUw2ZA8d8YEvZGoVhnGBc/fFlCy6+Zlooj1khqdA6HvtRsCsk0Wx8r8AjvnE5dlMoNgXrVfRRpu+/3ydlPUz65EbvPTBwDytCboMWi9hInpXKhY9VSUbXhwlTCF9HEMToKVZIKV6AqDr8zBZY7gIdeFcXtpou48PfpfQPM45o4ozRbPBmQpKByGvwoIk0zyzPuNxfoyo18FZVh1JyO/iGPI9n0mnzutdeXq2lw19qHOZoU/X2fo7+G5CnTuPQJ8fVfTevCe+IP9WO2V3cU6oI+n282ev5it51mlJ7GNe1lVrP5AMqQsMqCH4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9rqnCh9dQsjvxCsWjf3Yrrr9U9TNIAkN8pFlR0lQmysTT+XlFWyGDt2P/NEp2HVXqxnETy8TweN9EfR3KwjyCPIr68oZ/b5ipMaYDEzmKetco4p/Vf4Kub8rglw3ZuIlqZO2d9Psm+lnEg9izwXvvdO27ujwoG2UmbwvwEH80VDAKGJGcY9rChbAJ72xiG8viMT1SAQEmyvM6DhL1nSOrKTnIo+gtSxU5ukUnMbnxMWlDGCkFN1OWExOK7qRQsOwWGQU8svwyBlJylU6n2WhHuzeIJpvS7BLyXjC3WUdVoD4O3MXPpgYggkSZCygD3lLo0vcbmaaqVktiJkIuskICwWRjbx9FjI1W+AtBp2cfKQ+d7qe4X7FiEcKJabnePrTGRoSYIpjX77kWFPXpghTeb0EWXacpczgbLvcJ34qNaVxGXjDkOsc4eMtYxt7xBqU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:21.8465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c1196f-604d-4ad9-27b1-08dec3088c99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
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

Move struct amdgpu_init_level and helpers from the monolithic amdgpu.h file into a new
amdgpu_init_level.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 23 +--------
 .../gpu/drm/amd/amdgpu/amdgpu_init_level.h    | 51 +++++++++++++++++++
 2 files changed, 52 insertions(+), 22 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9473626ea96f..07962b06168d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -115,6 +115,7 @@
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
 #include "amdgpu_mqd.h"
+#include "amdgpu_init_level.h"
 #include "amdgpu_uid.h"
 #include "amdgpu_video_codecs.h"
 #if defined(CONFIG_DRM_AMD_ISP)
@@ -621,25 +622,6 @@ struct amdgpu_pcie_reset_ctx {
 	struct pci_saved_state *swds_pcistate;
 };
 
-/*
- * Custom Init levels could be defined for different situations where a full
- * initialization of all hardware blocks are not expected. Sample cases are
- * custom init sequences after resume after S0i3/S3, reset on initialization,
- * partial reset of blocks etc. Presently, this defines only two levels. Levels
- * are described in corresponding struct definitions - amdgpu_init_default,
- * amdgpu_init_minimal_xgmi.
- */
-enum amdgpu_init_lvl_id {
-	AMDGPU_INIT_LEVEL_DEFAULT,
-	AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
-	AMDGPU_INIT_LEVEL_RESET_RECOVERY,
-};
-
-struct amdgpu_init_level {
-	enum amdgpu_init_lvl_id level;
-	uint32_t hwini_ip_block_mask;
-};
-
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_reset_domain;
@@ -1436,9 +1418,6 @@ extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
 extern const struct attribute_group amdgpu_flash_attr_group;
 
-void amdgpu_set_init_level(struct amdgpu_device *adev,
-			   enum amdgpu_init_lvl_id lvl);
-
 static inline int amdgpu_device_bus_status_check(struct amdgpu_device *adev)
 {
        u32 status;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h
new file mode 100644
index 000000000000..60e75cc88bfd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_init_level.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT
+ *
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
+ */
+#ifndef __AMDGPU_INIT_LEVEL_H__
+#define __AMDGPU_INIT_LEVEL_H__
+
+#include <linux/types.h>
+
+struct amdgpu_device;
+
+/*
+ * Custom Init levels could be defined for different situations where a full
+ * initialization of all hardware blocks are not expected. Sample cases are
+ * custom init sequences after resume after S0i3/S3, reset on initialization,
+ * partial reset of blocks etc. Presently, this defines only two levels. Levels
+ * are described in corresponding struct definitions - amdgpu_init_default,
+ * amdgpu_init_minimal_xgmi.
+ */
+enum amdgpu_init_lvl_id {
+	AMDGPU_INIT_LEVEL_DEFAULT,
+	AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
+	AMDGPU_INIT_LEVEL_RESET_RECOVERY,
+};
+
+struct amdgpu_init_level {
+	enum amdgpu_init_lvl_id level;
+	uint32_t hwini_ip_block_mask;
+};
+
+void amdgpu_set_init_level(struct amdgpu_device *adev,
+			   enum amdgpu_init_lvl_id lvl);
+#endif
-- 
2.54.0

