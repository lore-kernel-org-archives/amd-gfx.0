Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5710CD8C84
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1F410E54B;
	Fri,  5 Jun 2026 13:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k1OlwUYd";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C76F10E4D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMePwIgQHUifdj48BQRPxOF7BKigYQLWZIiEvc+RZ/sun1TAOg5fbi9JUMdB6TpyPyJ5cXOJLhm4AvAMVo9Px0GO4TgNo/GmD2pnXfa69kWrYXZg7DKWfjAil2H3ckhQuDv9mubHfP9f2CgSe5iJLT3lcGlSEoAoCDv4lHx+KaV44HqdUhsa0j175Q/iefZchi+HP89WXFa1QzKC5e7KAiO42jJVqUwPqiwyrC8rouG8KGUctOYJU9a17ve+zLdmbTFm/05Vx5c7vTYOlfbwU5bwh7Tu8PT8rw7yvmVXHAQP2hz+UUHaWMAECz666UzaUUg0JsHqOw05b6JxlnD75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkBwROJ9qfMyHjsXlMvZpdZaG0aTEX4w88ReZW/vqVY=;
 b=br5UC+ikonO+1y6o80iDwC0/FRgvIIVy6vZKWrNzUcipaXLTVXHWJsSMoQVTBqWq9jhLVOwl7ggZJ5JinFdRGn+gWkaC5f4oBrZWAAfpxl9n3ogR62Lj1Trk9z7M2NhrAWweQSmX8K6YA2GalfVOfeprwdHBTNSBFnmda+iV74YHiB1d19NhZHtFNIw7cdO+AXCpmY8PYnlw3jIa9Pyo8SXddQd9YNUD7Rs44DZenhI+Bscj52b63DTN6Hl2BU1mTp9GcaAgM3ZcfXyRs9eatkpSsTmVjrM4k+jyqrGtAMqADx8BwZ2xdb+9xgrBi63h4GvWTaR1Qt2SQubKRi93CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkBwROJ9qfMyHjsXlMvZpdZaG0aTEX4w88ReZW/vqVY=;
 b=k1OlwUYdcwOVsa0x1mHIfVGlhbPmrlbNm89R2048Kzzh5SRSNPwdjpx43QCQWCU9dvjfIN6cLJtiapL8tohrEuxj7IICd/Rx1zSwN476ln3xmYtdiz0q4+INnvxIdWBJCBAdDiwV4eCrAM9XJ3pWD5p+Wq1r6eTd8eywwQF0kT8=
Received: from CH0P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::23)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:44:19 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::6e) by CH0P221CA0043.outlook.office365.com
 (2603:10b6:610:11d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 13:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:44:19 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:44:14 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH 04/11] drm/amdgpu: move struct amdgpu_video_codecs and helpers
 into header file
Date: Fri, 5 Jun 2026 09:43:16 -0400
Message-ID: <20260605134400.956791-5-shahyan.soltani@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: d347521a-5c84-4109-ec0f-08dec3088b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|3023799007|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lVYm7KfteNwt4vtNMeC/EUOW45G1gR6ZlcwNuUzO8Hy80IVDS/nFpv23B7DLoxjZhGENP3rGyB+h8s+aynHYaZmaiuoRQHQW6HQN1A82YXrzMF/BQv/p38IpGeI+34oyY/7PwP+xGsbke2w27vuPEyLQFbM6srVNWAWhlJd0yNNGzu3p8HmhIUF9VgnT02AQtAU2FWtTsE2IvP1/fogX+2N5gbrkyWHAgApmgVZyGy1a8xKb6JmzJsAgfoGUVyfWoYNsXcNpP9qLWctkn6dIC4l69ogecN+ZHLhEUU+ALB2wpX/TyLi3aszpHzvpHni5Pq6XNk08BtAQTMcbDRwJTusmmWeACnfebxtEIuXoDKs7kzwgEz3vvN8B0xwMzDNjon7xY2MlFndnepaxPEQE6REqMnsFbY2orGQiUH9oD7NiG8sSWiLcFxF4JPMEB9IXfJeNW0oU1PMjzZ9IhmNiBWEc5NWqidxyTcFDhIOca6V8lAEn9RzKVfwsckrJ3bS3bSRsaY+YeWm1L4SL/9pCMDHMfnO2J4J9S+GpxzSMmxOJ+JzNVdrJRMUhpUe575Tt2cmRhbxB8re72weZls0hE6QD1MZmtztSN8c0kUlwuwxYHLu2wc3nEPx5Bd8aa0+mB0BC+SAmyzY0SeDUz3T1G4kQOmfeutVRERWF7nsWZYKBmIDGFqcypxQn0Y/Kaw7GoMltHzSZlpDUFcC21p+AlRIjm6OQFN+6PODQskBKG+U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D+ZAcFXJNYhc4dmrNTVdhyqK4TWw/GetvllcrksWhLQj+UvNHaMz2n1yNBbAPuBl1CQiDCHtcawt3aSYxvqmqrG6AsXSk+a32PKy6eNxaKmw1ti7Un2ZBfSdWyrLrF0dzqpDkL+9ifyNJjfaPS6tUzehdipXDWOfek99Qiy35IkfZicVsqqngUh8CVY19eoAZ0c3qrVrKcBh/6fYlHAlswB6AzQfR5EXI8mk/sUuRa9pt/yQeee1GB1QL85LsN+kmhnQJBFX4Hxdb+DvWRgFKzLKTbuu324fOSLKkt1G62fLt0Pj1YSvNELQ8+0HM1jQy1+/u3fsTKZZYnayTadVonDuhfC1qRmMO9NCJ6bb1+lcO87tLGI4E+QVCzHvzdHzfEcphOm5JELqArRUAPFrR6shrPh9mi8GNYzj3u8n1rHezRjZ+hxbRPN/7DBVOGVs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:19.5440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d347521a-5c84-4109-ec0f-08dec3088b39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 21 +--------
 .../gpu/drm/amd/amdgpu/amdgpu_video_codecs.h  | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+), 20 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0f8743254fe6..8fb70731ea58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -115,6 +115,7 @@
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
 #include "amdgpu_uid.h"
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

