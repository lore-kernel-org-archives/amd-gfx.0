Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE55CD8CA4
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 19:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51DC310F965;
	Mon,  8 Jun 2026 19:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pV5V31fr";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD4310F965
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 19:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2ScJ9yq29xbCZDqf/zsk2No8iJ7BFQ6crmqwPpupj3xZAO+IACCgljeJBW8ibxhkEGfIED69Wj56eG/GCRFD/VI1PE3pMX9k/E8ZNakXwLRHuMT5hChoMrb/h07i66zhY/HnFO0JFoOmOy8QMKLBLmJVJ0YRDoXhtHvjolmBRpKZ56lD4ljABf5UqhFhOnO2Ol4vdfbLuAsBh5zft/QXaYzzJLX7Lh6i8fcPTMpxHGYuFuDaWIHhXAhycq9I5FFN5ZFqfHEFGG0DE1UdGK4nzNAu9D5MXYhRidp6LQqPvQgx2yfosiEHM3JLHbul3F0/PmUhllAEoLuHqhoqAn70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkBwROJ9qfMyHjsXlMvZpdZaG0aTEX4w88ReZW/vqVY=;
 b=jtq61MyaIodxZNKWvyJC14jWGH22UZyxS2hJ968yd8gdfgxA13VJwOo4GKraY/RW7HEK4WwfclgsxAY/Yve2vo+FjksiE8UaueK190UTKsCZYzQfbsifEc+bhxD6yREIxKipVxyv7q05duM4QNnD+sDsqIp1/XssRMLYJFY7l70HcqbA7GcOsPbWNdeENU3Wu8rVzitzC44V31Y+hmPKqJnzvzBTLAC7zsyB93RPuieEuf1o4BiSOoQnROhye7w7AoP41oCqgK6w+TlAi4umpSxYOPtfb5ETvi+WRmhynbk5PZZjundK3sOugYRtdy8V33j8M3tpg+l0VTmCQbuENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkBwROJ9qfMyHjsXlMvZpdZaG0aTEX4w88ReZW/vqVY=;
 b=pV5V31fryQUqNY0JPNYvIaIhJ1LhrX9g6LuDRgw9vvifOhMQfoN+gLgG34y0shLAW42I5cBORkKpS347TqwSsoTLzeJOzm2dCfZk8D6vW7hsLh9PKyjx3iECKwW+6u8R/A/Ni9VpzSsehQ3udrC1/n29uIrUnIJEW4dlmbT/DtU=
Received: from PH8PR05CA0013.namprd05.prod.outlook.com (2603:10b6:510:2cc::13)
 by LV8PR12MB9689.namprd12.prod.outlook.com (2603:10b6:408:296::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:48:05 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2cc:cafe::97) by PH8PR05CA0013.outlook.office365.com
 (2603:10b6:510:2cc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.8 via Frontend Transport; Mon, 8
 Jun 2026 19:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 19:48:04 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 14:48:01 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH v2 04/11] drm/amdgpu: move struct amdgpu_video_codecs and
 helpers into header file
Date: Mon, 8 Jun 2026 15:47:34 -0400
Message-ID: <20260608194741.1590055-5-shahyan.soltani@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|LV8PR12MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: af389723-60dd-4340-913b-08dec596db20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: O4CGBVJyQqMSefZRWcNgaeEckf15zS3IPl+WLTyWAgn77G5BnJugiaBaE0XidhbGQw2X14r085wCOpEzFQ6mgRr6ZnBFGARmlt6bxEcEaGjrcZszq/AJmXzUXZ8WSjbIBm/Gh56/KRy1EUPQGGGaXjLIXcFo15bTbSFwHeCVuCGJzGeZroUB2MymTAW+kHOLsqiA8s+pSyVYFYrC1CZzqCVZUDNT6Hn612J0Id95e7lFznZkYuYOPdXa/SVyZNeeo9+wldGI8RzSOwEEGiNq9ZVCbEspIip7O95Ub3AJB6dTXhMrvmXUjf+x+QbnXuZz9lWLJYilLifhZBejOLSGasgaZFkSk8WWk5SHOVEgSVyXqvbyG++iiWLBT7mzRxmTgC4LsZT9RxgX9CgbJL4uyQyU8pQ6Fydt+m7MGzVaO1GpLJCn0zfdbXkmEhhu3/2lXVeGN0O7QWQB4eUFsGI2iv3oHRMEEEZ6PUzNqH48K6HN6kxBm9nLNrW+8rVe+WIm6JOnsNttxQiCrqxUQSEyu1QrGkzk8+G7JN8VJ196lLPQZXoeLYuqfEZOb2RKNdS7TrCoqmqU2pddhO2ENNCnO8G5OEaVDjs4HpRvbPyKy4zhzxjJFOrff1f4p9WEXoPSTZ2tzpbbQNS9nbracQ/MZ5FBS/mcnYqB8YcFYllLz+1+VjzUQbxVuzkxcjPiFXlZMhnj6rvO10W8bUMlMjuhpPiGywbAqLSB4nOywA+9ED0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5JPmMC5pkn3g5NraMgsoz7wmxgFoGN5Gzra/88QUbm/A93FDAY+l3Y+mr7UrebDTnYQlbFda6xtdemDrvYfeV71Gum1GYeOKfzYjGD+l6LwPNeI88B6bYRvHp/tZGGaxBxUWxm6bB+bfmG33Pd2P3iEC0DqqpMX/3wZ19fJ7y6QtX0N6y3Zv893Cb8Emnp60CPTfzxuuQIsrSC/8UeXEOP8FB26JCrZgK6V7i7o8XamT2TbJ0fubAzrQg0VP6HaoY0pdlMyxfzREdtmW/DTTzWbSSu7LqLl2fRQe/SfhevVaGm0pgVn+Q5eXAhxJI6IW4him7gMHAXzZGsTsn6XT57pPiodWlgSpY+VB0RICGCEABv5WXlm9v8Hqh72StVPn4XTgjlzMzKOw25sUbvGQDzmn47yqQce6vchQ6rT2W+kUkfUtcwdqZvLAJ0Nr9KDc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:48:04.4642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af389723-60dd-4340-913b-08dec596db20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9689
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

