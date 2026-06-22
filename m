Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD28BCDB475
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 19:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CAC410E833;
	Mon, 22 Jun 2026 19:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="No+fWxql";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF87410E81F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 19:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPfGdImLrCYSbbs5/jQ6pVP8prBNyPsivBK8S2FV7Vp0KHikAhePPtq/1u2OkBtoodZSTTnHZBJmN+M5xaTIFmsJBtGTUNUKQi5EaEiAhE5t1Y/5wsv4oYi06Yy7/uf+xQ2nnRBp5nlFA8gcdDWyPQ6LpPIh8DqQJG1G4PjjHnPjKItx3utp/hiXQ2Ga+2XJAbkUTFOi68fFKu0qiCeZ5HZhfNCGvhqhBCPRed5t56VdKB7+0sJZ2i4bvfvRJfAAer+qx3SCcI/H1blYkPRpsuTGdrU5yivN2vSrJy0B+5INWHsplEQ63byWR5hfKiXjZfKfTarsYOfVRtgHigW9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNrV4iGlkVGHis+K4aNqn5RqcEwFfUM7drQxFOBtLhU=;
 b=ZpeAgFIy0q+Bm1GFw6RunikMIT3A8FVTpWVdTzeCMswBDFoyECo7L8pLatkFQTj0UHSa6yMSGNnXKpiD8tcEo53JuuIPGBLwCqEwrGvmqtUMGsnvCpYJ/snWJMsmVhtwfwV8Lt7Ncs44EFVh8nQr0KPeuxU0RA+v6YgatQjRZ0PCtoo92VzAK2uSnOKFRcJsrXwqS9pTXwvJn0eyMakYUyfUJeULHXzC5Pgmm3Pldu00cTJncN6ACd2t+zBF3aJ8gtF7zx1NT5vLi2vj+QenqMkxdOuvIfDL4IBCZ4ac5lP2w3Ku1fq+izUTvfXFUBQMUcWDgo8n+U5SLV9WSD/k3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNrV4iGlkVGHis+K4aNqn5RqcEwFfUM7drQxFOBtLhU=;
 b=No+fWxqlFPXR1CINxQh3bDwavfyLtZ6gP2wU68ZasXryzgDTCG2B8iHb7/cFavJQaaogyzi+zazI/VZHedwhDRx7qXvxwyhBFTvtp0aObNokHJ4tVrPtl1GFnp0Dz2rbWchHmag3KAZbWALgd6djxnNiMsONuJSHMwpKqLo4F5Q=
Received: from PH1PEPF000132EE.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::36)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 19:57:45 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF000132EE.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Mon,
 22 Jun 2026 19:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 19:57:44 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 14:57:43 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 3/8] drm/amdgpu: move struct amdgpu_video_codecs and
 helpers into header file
Date: Mon, 22 Jun 2026 15:57:24 -0400
Message-ID: <20260622195729.181216-4-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622195729.181216-1-shahyan.soltani@amd.com>
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c591b8-bbeb-4d6b-861f-08ded09886e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TXuMMavpw1KLofpDVHX35iB2MqO6F7Ad0anFvpMzZHfY2rkuvYfKPqK4QAF7ZEQwBsXY2XqgYNMSQn2cwq5GRx3XVLV44y6ua6xIaYWlxuT6luxuNNrmNJbQQSbLevnE5UkuMxSYewXdgM5IHLjJWHC5RGHMbKnL0Qg2IJ8UPsbqSSWn+Riq8MmIGZWtHB/MdakyPmlRZTLOiMhhWISEouZrXCU4rEARNyxMp9Emos2l4uBkXGAmMYLIo65qY7HaTX1TZOfrvFJ5XXWF1tVY7GfgC/vmrpKAK9xY+NU6Bb4fC0UZS4OYnnHM4esWh1w58Am4GU0IbRDbFp5T3QSSLW+2sazAHSPltn2iPjqoacKkYLKFVZadhxNxQTBOchFwPg35kHRYcSZxomKEpPOjynP23G7PVFkWqBhL55KtAAXxKs0cWjUSPjlrlQFG6X9BcYLDYudhJboX28H4P3m1azG9NKz3H7jGpBvFZsc8eMn+c6RBjEG12N8zZa/iATMyVqBP8GxXB3PVujaXWx9ODqwrgKTpWreo/2I8VkpZwaDbK6HMGisfCk+89Y+BX2WT8j01V1WOu+elkokqWYxhtSL84mzFaS1+CtvN/G1fbzQNVoy7Fgu4rWBO+51PJ0QKG9W4wL1DcdSYLP/F8SF/6tYpmNS3bN8TT/5ABUqZy2ljqlyasYxwHeXTcZ++D4BZRTpvzWS8XcpnXfNAQiTKyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I0UH46wHoPExR9B3pmaz+tRV1gF6hDwCEeVIWaTq0FAsb+KSz1ByLI9hbCNX3EeGpZxar2FyIp8HmXe36YCi3yrm5Y03lOjZ5aNA8bkKHjMsoISa+3PrE3bWXG1HRt+PeDD7GP8S4X/1DpWFf1s1thLaybwe3Bfky5MTYBPgCAEQ3lFsgzkUARB8V8KikJfzMzG6tGUav2p5bZAXCK3aBYpcYcQY028kG2AZf0RNAS/TyYdx9V7Ef6yfoU8GLrmD2fOahV9TersakeYio9B0ytNk6OwHdvfQGFTAWjiyslIsO1S8565TpJ05x3exC/21PpKvWX9TnMGMa6XyyEdFrr08yvyFAZfoGBXJS4MHuFNytdytTh/FMjnWU7T/qPH7+IWoJjfHc9z61vibS45jGIww99AA1Gj27RNkbdshy0LX+PMzXXvZiUmNVBH99vJ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:57:44.9103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c591b8-bbeb-4d6b-861f-08ded09886e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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
index fe951a901d20..61608acc0393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -117,6 +117,7 @@
 #include "amdgpu_ip.h"
 #include "amdgpu_sa.h"
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

