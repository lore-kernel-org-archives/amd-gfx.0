Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC462CD8CA8
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 19:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6A510F950;
	Mon,  8 Jun 2026 19:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YbXtoggh";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A8110F950
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 19:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fz8h717ZxEkW9izjs7PQP7yO57/O5MtzbQH2XD+Ac9rmci4j4KeZ3M+CpP+KVSeMv7vPZiH5kySFXLCTXt0EanYDcHZK5PU6k+1ZClh7C7G+X9NkTOlT065eoo8mhACxvEyTTuZie0CZRuR9lmoAOpLnqbqNGH2d1Y8ZQv7NZdmzlO78DernZNhSgKQf4o4voC83uSCniziyqFW1Tz+g6K8c2TayMkXOak4oThrQdu2ytXt0gJlaz+nNOYYaqGmVoT8nViqweOTYSLYbov97JdapQLQXIKqZuPlI2OUvaLveEWdzgMHgncHYqHpVgXzyqWMBoE2GnzulxxeoQDSVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNIKi32IzhrmSDLa5O5YYj8uDbgoYvTDhrjoUFuQZNw=;
 b=pJaNtOeOEW6qnzmymm9qRR/b1Mt7qnOS5fxW/i9EvrgMEBsHiclXcyA9zKrl3+Fgmi/rnit4IeckpVxQ+jSm0FVBktOGeJrjxvrle3eDG+vU1k4sOEGe5bHKUJdl/lmmaBNVEgd1QCIUs0K0Di3sacy5KHKKQyN3bEmwFY17igWIbJDToL9pIJdHPhvPfCdNE7KT9Lpx7c9d+nfwG0eGAkdNq1Kh2y4PvQmjtvkFWe7iiJF6U5pmoP+e+n48Ka51QvOlrlA4kATmXZyZMKI8vwhZmfvmudrufIUUZusNYqTw3FMNbp8irzgpV78mvc+KjL+4laPtrCQ9uRRntc9cQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNIKi32IzhrmSDLa5O5YYj8uDbgoYvTDhrjoUFuQZNw=;
 b=YbXtogghw+wVBy3PS4Cm0nRkQAtv4ail4EErnOlsVEjg1vS8NxP7lsxABYr1y2MSrS1YGFmMDOgqk2uDQIJpxpsDOlMwTa/AXd81wEDjCwSAwjchnTFhAcPAaO558jOCiHdM8tOTbaEA6Os14Xzp31cL6/9Tig1O4COrCqwQHjI=
Received: from CY5PR22CA0076.namprd22.prod.outlook.com (2603:10b6:930:80::23)
 by PHXPR12MB999256.namprd12.prod.outlook.com (2603:10b6:510:3ca::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Mon, 8 Jun 2026
 19:48:10 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::72) by CY5PR22CA0076.outlook.office365.com
 (2603:10b6:930:80::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 19:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 19:48:09 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 14:48:02 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH v2 06/11] drm/amdgpu: move struct amdgpu_init_level and
 helpers into header file
Date: Mon, 8 Jun 2026 15:47:36 -0400
Message-ID: <20260608194741.1590055-7-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608194741.1590055-1-shahyan.soltani@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PHXPR12MB999256:EE_
X-MS-Office365-Filtering-Correlation-Id: ac207a27-0fb8-4ba1-5bab-08dec596dded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|6133799003|3023799007|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: Eat1/7yy9aVuNVCGfyev7yiX3FzZpLACpTZsz6vqNmmxJQ3Q806fck78W+qkgYjOB2oZXNCDz074LEEUigzBfCfz/75shBwot3dH+2coho/zvSAyS5Bn6J3ksFtuQHVP2eRbxlEZlvhjeu5iO0CBxptzaOVRCFBgfGHSpzpQLaOtFmgRN+2Gz8S39FZ37QNAMq+bdivHXJ8rWplIwjQrS3Yrre0NBHNfUw6y1q0DEW8iZ+jvLOiVB2l8UuifT0KQO7b7nhNAbVGkl0f8fksl2d35Dxv6NAU/YWl5UCkdl9R1KRqrGPio5qrUBfHVhM/7KFPM/HZYWGfy1JhmMDKol4FYCdZDSwjceY8UZEsZCducIB4L0Yx2Ft5aKEgj2t/3ibuqHo01cQReMvDk3ewybM9HGtd0F4TbLgtaNJIgcSdzQFcFwirN/CEwQQsa6BOSe7kF3jurSWk3aTdRYPpsSmbWCvBQmN6kN4m3iD+B+fawFvJ95GS0idt/EjIo6z4bYLUGyQJKAvRhX8j+c7Uq8tULYntoZjRVKTuu7r9y0GadWCyS0XXfb8fAcpoXyHNwCjkR0KEycPknlZrYWBcoz7h9Lw6YXmiL70hajDTTaRKSccCnPvcjhdEBmtwaQek0a5h39j8EOU6fCvdt5LSLftYYd+cb+zT8RRtBGSJSoc5ovMgtsC2usAI6r8BDQy770XmpyQfLiIzSt7u8+M3Pvl98H8BN+8DHYs+CUgwH05A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(6133799003)(3023799007)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G7Zpg5Ry9njvxL31jKMyoUEsTBKfDt7odtbYINXvEhnzDf+YZBdPj/lnB/CS6q4E7DCPx/DiH1R/6Q0zI4EeXe5LIHuMMwIbPw5Bp/Ddg9u663j4TivbDQmQIUjK5CKpQWOPzHiksgDVa2hLTXcQbBsz2BEyw0kf+uSK5yZHt7uv8pXpr71td4vekj1EJ6rRGmQnvlUy2B8TRX+xYJ3eWD3MSYxc3R3KgKNpTALN6qOMckyIZCI8cHXxOXmDjndhFeLllxkBRtnFevw4ZOWitoBhPDqUVZaN/wzakszCeeLRoMPWYRUJhjCs0h2c7vdcII/MDEFY1v0heuBtC3vo7c88WII+E2tiqtywHpXNwZ1pyBgUOnWIv+HkYNkcY2U9VYek8rLjv34p85y8qqBzWE9q2BKp2ZgsjfZ54kTBulYmI0HK2dsybD/krD7Axn5a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:48:09.1401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac207a27-0fb8-4ba1-5bab-08dec596dded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999256
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

