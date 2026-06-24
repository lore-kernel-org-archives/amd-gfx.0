Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BE5CDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 17:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DEF10EFF5;
	Wed, 24 Jun 2026 17:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aODodzh9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C9010EFE8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 17:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3GGP9Wh5FazCol5FY3TpDjfiwwn6/VmLWwdytSIbWNtF8avbZW6zjBrTOfxUtZaW5Js/p5Lcpw/hfJwADgGLLZMEjaNu4NxnYo0/vBX9P1sKaOWfEkHK0VsOwuuxETYTFIw0bEdUkvFU2LjWYfOKT1TbZnBbExgpPeBRfvHNLu+8T6QWPaKmqNthTqBxjtgv1vmx75PoNCWtZViM2kufoVK+B0RmIEO6EQhGVlNXVAdx9MhSNAXeHWpUtdb6qQYDAL8ozdlYNew3wCb345x217csZDMGsEIREh99k4p1egdXa2ZHqOdIynm/0NQOHTd+fD20agEoSkDz8PRnq8fyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msy+WXJZqptPz5cmZWO+wY6rq4hKjgrYObwM0NBfDNo=;
 b=kjUYJ22ZNRlY/sdDyYonWbVW/6wdsuviYODrhfkUfFc6gw/vQyew3LxSy32G3Ems2sJRcbh38SgAx28ek4l9vUmaR7hEoQL4rq3WuK39eLN+f2QX/5xVtB3DHnhi9a6QqWtMgq/e003tWd/tp/iiL/MxiNFzSoiAd4hfon8o4qIueM7cknzKkcKudgWzwLlD097PNd89ScGVyplvYPt4QV4yB6x8wSiRLdniSLfdBKuEdNM9k1lTND0hiJ50FoLLMZgbLyqI70Dkg3aRggVI4xO3RSGqKOOhOEDVw1g5MRu5hjnHoe9AsCfd1yqm9C/pUyFCD3AoKIAD6u4SwuHrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msy+WXJZqptPz5cmZWO+wY6rq4hKjgrYObwM0NBfDNo=;
 b=aODodzh9iHQoxcBsJrTTww3/MJRnPG/cjCZRgkDGQ/xMrQE91SaqlDJn4DqyIDchyDQSgJMYpDSnscHsPFIZn7W7CLCQB1Y9Yj3eZLpsibcsWHuGBJ0Ml1MYX5DVOQKEicnE+LhqUO3EvF1mwb6H6O5IjJxpSaSAhGrr93LnIkw=
Received: from BN9PR03CA0154.namprd03.prod.outlook.com (2603:10b6:408:f4::9)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 17:56:07 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::11) by BN9PR03CA0154.outlook.office365.com
 (2603:10b6:408:f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 17:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 17:56:07 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 12:56:03 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v4 2/6] drm/amdgpu: move struct amdgpu_video_codecs and
 helpers into header file
Date: Wed, 24 Jun 2026 13:55:03 -0400
Message-ID: <20260624175554.489406-3-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624175554.489406-1-shahyan.soltani@amd.com>
References: <20260624175554.489406-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff91f8b-5127-4d9c-2124-08ded219de14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|18002099003|22082099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: pXqE8Ak0zeSDyykdWXSThUq7bDc1qLTT+9DXNrAXzPjlA0C9Oewaxi4N1/CtCkp/nXe/vIwkyxeFx0JJx378yhi6gdfNukDzLn217MqU+qiV0dzYzQdCp4VHmlGuW9RJGwSejAmKXrhAyBx2aQDNUlhxpOf0NZiWLWtSjVaK3YX2DLop4IE+llsTDBbg5Vw8plLta+E1oSNGZ7sNQqTQWVCChk1+IkC9qoxA7z3pmBgvQ060Q+pf8P35Zcgbe+m5U6Q5kz9RXZ0EN8VivvYk+fc3pnc0IaJMNH7tPyWXkCLWWRpJviuoFE6awylIgH+AAdpqbcIvhVMfBmWh7nkKT9WDcwrMWMAyVJhJ7fDsLZ9T3EefmX1+MRXBuIzd/eT31d0ASJ7q29LQdNmLUgf12MMNaFcC5euPYEXDn7wv+Wf0naYIaAElhFYIao76Elc0rh4CcSh6nEe2SqXLRn8VB4sAqeHN1Ks7iouKy9pbRFrp40BBKZCAetNEzRgdsoN3CoJUWE1ZSSa9LY0waucRIVGBp2/6dBe7205gH2FNK04kADpfO0oR7YohOc8dBgPv+eqt3MGmyCEo331OfoWUZj1efrTMvZm62vVS+NKWBi9J41/bri25b3mOuDSYz1ApmJVyXkD1JhvTc5n+jd+lV8ulQ6yAif1z36qe0U1mdWpnFCravFICs7e1bvo9ogi7nGUSSIRMI3VI5YDLi+KjNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b9mzwIikrL1UMxh/XUdN0uxfZYi03Yc/IJKd1wVk1+u1PTgpptKTYHysi1M1/FOdr5EArdQ7ScdtI9TG7oOgd7HKaTD4clpfGhUwYFSKaiAO3fasumkXZ0woPy9d5RYs3RtEpPF8fKAYNyf9OrKtZ65fFP9mQ+o3J8+aplUIvTJ0D2LpcsdAx6jn35wuCek8xveOMmD2PW1RSU0skoQ9y24LIJhGuVLNkBMFB8ihmdOLue8u1Fgdn9E5VDDAMZnfmfm6uLYYRRNhza0tZDd6X68gBtiLCaJhFQaq2AJTGycWq+2Ee493exTRW+JhO9i9tvx4toMXTXZ4ZP6LeMOq4OKImlVU3T+SvdoWAU1bMZDwGwlO8c4GtRmfV0JXYz4jzHyjaVJBps5xoMdGSNT0tCc6j/7LOeiA8C3ZsurYe0F2UkwlZwQa6xbTGr4BMdFa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:56:07.4674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff91f8b-5127-4d9c-2124-08ded219de14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
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

Move struct amdgpu_video_codec_info, struct amdgpu_video_codecs, and helpers into a new
amdgpu_video_codecs.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 21 +--------
 .../gpu/drm/amd/amdgpu/amdgpu_video_codecs.h  | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+), 20 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f9b579675886..0a1c6c9c3e18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -116,6 +116,7 @@
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
 #include "amdgpu_sa.h"
+#include "amdgpu_video_codecs.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -444,26 +445,6 @@ struct amdgpu_allowed_register_entry {
 	bool grbm_indexed;
 };
 
-struct amdgpu_video_codec_info {
-	u32 codec_type;
-	u32 max_width;
-	u32 max_height;
-	u32 max_pixels_per_frame;
-	u32 max_level;
-};
-
-#define codec_info_build(type, width, height, level) \
-			 .codec_type = type,\
-			 .max_width = width,\
-			 .max_height = height,\
-			 .max_pixels_per_frame = height * width,\
-			 .max_level = level,
-
-struct amdgpu_video_codecs {
-	const u32 codec_count;
-	const struct amdgpu_video_codec_info *codec_array;
-};
-
 /*
  * ASIC specific functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
new file mode 100644
index 000000000000..3b2a6cb8632d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
@@ -0,0 +1,47 @@
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
+#ifndef __AMDGPU_VIDEO_CODECS_H__
+#define __AMDGPU_VIDEO_CODECS_H__
+
+#include <linux/types.h>
+
+#define codec_info_build(type, width, height, level) \
+			 .codec_type = type,\
+			 .max_width = width,\
+			 .max_height = height,\
+			 .max_pixels_per_frame = height * width,\
+			 .max_level = level,
+
+struct amdgpu_video_codec_info {
+	u32 codec_type;
+	u32 max_width;
+	u32 max_height;
+	u32 max_pixels_per_frame;
+	u32 max_level;
+};
+
+struct amdgpu_video_codecs {
+	const u32 codec_count;
+	const struct amdgpu_video_codec_info *codec_array;
+};
+#endif
-- 
2.54.0

