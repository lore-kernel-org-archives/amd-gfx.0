Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4844ECD6E79
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 19:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D000110F94D;
	Mon,  8 Jun 2026 19:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jb0j3NFn";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A78910F966
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 19:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxTwNrTVyvCTJEe8z3JtGZFYFP2iXA6ajadutRkz/144GVw9CF8bK6Gt34Ih0Y72xMEgMexFqTrCNP/8aV9bbgRpi3OMNFI9G+QNI+3ARyw3+J2OdCWnMqxF2HAUfCecmjDtmSdLrVTsd46K+yt7/ONWwZjQSe3cyEX1HGzpNuSfdWTNzKdR6iiUG31kSqdV2wGKx56hgS5DD+D0/lBx2CIgLaowKiKP7MFGIIseclycUaPOc2QZD5c7GZeCwZZWhCky1lWwASY60Mhj/ZZSKDavLjnNJHBNTVYE3LomUgVxTL3e91TlLxuLYNoBo2kT29+GbKyS5NXzz2caACgJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jue8PTfiX2L4QvXl/02pthukXeqZsoa6/C9/GLA+1MM=;
 b=fFbsSvB9bvKL6Svdo2npkSWlPbbAQ8oXMM4nLJrFML9wioHt95feSzFnTLfKeciVASqUj8B5e+wtiHs0F6tv/99SKYMIU0Nsb5yN4EIE1qFsNbd6QCSVBd5jXoiKkb2TwNrNmv1L1x1hIFT+W2iufna2XyJBbKN+sMS5yGD6XvrH3gc00IWMH4mEmsIWiK3oZBij6zFaMrvST5XJZ7sMF6WNvCa8eFsEG/zaIJrW6oHB8k/93VqUGFY+c5k8CuSgaz1gcVAF98TfeRnbPyP1cWeIcPcgskun1rukp4WeYfuNe1QciM9plnabeuSx/NY4FxXiCpK+Krv0+MFN7EdM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jue8PTfiX2L4QvXl/02pthukXeqZsoa6/C9/GLA+1MM=;
 b=jb0j3NFnkvL+7OskEvaIusWmM3rJ1YnPCBav5ucr160CKIPBNM2SYvfDArkR39WfsekraddNPg+oc3GGH4DLJk6RCpkIDyEZSMS/IrYbyaYRRnuu1mcRs0IhnOPCISJ2GmXj+SNDCdlHHCAso0rFuZvXKu6UHXO/w9AJTe62k4Y=
Received: from PH8PR05CA0014.namprd05.prod.outlook.com (2603:10b6:510:2cc::7)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:48:06 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2cc:cafe::32) by PH8PR05CA0014.outlook.office365.com
 (2603:10b6:510:2cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Mon, 8
 Jun 2026 19:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 19:48:06 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 14:48:01 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH v2 05/11] drm/amdgpu: move struct amdgpu_mqd and helpers into
 header file
Date: Mon, 8 Jun 2026 15:47:35 -0400
Message-ID: <20260608194741.1590055-6-shahyan.soltani@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da7f4a3-8b38-4366-0f14-08dec596dc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: pIaBHt7NYGWYFVm1Fr6c600hgjqdg7m1UsPOeB1c4L+6q92OhNVJeLCFBUAoC9oNtrlOqqbOL/QNjeMdYc02er3+rIunDqUssoWCN9cVgm/Xq5HY4JDoQvvwxkJmvzh0amV2OgHI+cmGgFp2FtM6HGZD6Y0FswlkuuT96cUxpb2dVOumtSkyD4fmcVb4vLCihzQhv5ixcGpNkYhvgLAGaNxoLvofAGON3rux+SuNmogzzrzTk9aDXqrDcsWAS8e0wj50I0daBPWO20p+jaIjROOQuHarmqi4Vbw8kCDGZlswQTvChNIpUYM93AQKBMNYGqUGgmfBqTCScbmu/qcywdi4709pmAWlK6QAik3jg3ENHAFX8X5QPC8EsFWhkqk8175/MTufHXv3ySHWyts+GXNZg//NJZ7nkXI75Ccvkl6nlqWNjjNwaghMpibE1GGED9g6gLhOcdOOYu6Nz6wttJFreiV6H4ifVNUiymokKyVUAxzapGEqxjpBKgN8g31YdB9yzsCbGZ6y0VJ/mM64TeDRrqjJCN54VAITN2RyMX4y0oYyZQUEBtvG32i57BGi/R5KWsxDPG77VL5p159agpbWCZCHOljjjC6wx+pXiGMhELBTJ4Q8JwnQwHrOPs9eJ99ZRtCS+1O1fMZQ0vvoogZ3fj8XlpZ6hYD9eJbeiED3wOoVXZT2PcgQ6fgFzR4Er7k2rkqLVnazu+VzUUZgAbYevpjZew1VX1C4mmg14ls=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rsv61jPh2f8AANq66BVvaoXXBkvaQzpEIcwgEatjshZdN8e4Pt6in0Glek/631Jqgy922fVlAUQ1UrY0tfz5HbshdTK71zJ+9ztrd8b7Z67vL9BQJ+/LWlQiOLAEgWn3PZaibesJjkw7IE4dyWwGjpV2D11A84VT62mAi9SWIkom3T/B1hBXhXjtcadBWqMzD0HcY0OsipGak1ReFTewCMmCHv9qQUy24qDSfq1O3ic9LbAr6MsNnNTUj0NWmm30BJR6R01AHd+kBV+LWfsRVAKMaLSLLirmisWRr3Lb+yPImF7z1fuqHz1fIOQ876EsvDvNNvm5mUx8nckVtF/H3UNqNegQaKMVcfhdsKWUoAiCignp7hQB1grL3Crth+TljrfwSQE4fCtkoyCLk20PoZi1WeqBOEvRQNWxJBeVRT4oLbaNZSPFLS+SZ2yncNEe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:48:06.4509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da7f4a3-8b38-4366-0f14-08dec596dc50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467
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

Move struct amdgpu_mqd_prop, struct amdgpu_mqd, and helpers from the monolithic amdgpu.h into
a new amdgpu_mqd.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 47 +---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h | 75 +++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 46 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8fb70731ea58..9473626ea96f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -114,6 +114,7 @@
 #include "amdgpu_sa.h"
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
+#include "amdgpu_mqd.h"
 #include "amdgpu_uid.h"
 #include "amdgpu_video_codecs.h"
 #if defined(CONFIG_DRM_AMD_ISP)
@@ -611,44 +612,6 @@ struct amd_powerplay {
 					  (rid == 0x01) || \
 					  (rid == 0x10))))
 
-enum amdgpu_mqd_update_flag {
-       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
-       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
-       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
-};
-
-struct amdgpu_mqd_prop {
-	uint64_t mqd_gpu_addr;
-	uint64_t hqd_base_gpu_addr;
-	uint64_t rptr_gpu_addr;
-	uint64_t wptr_gpu_addr;
-	uint32_t queue_size;
-	bool use_doorbell;
-	uint32_t doorbell_index;
-	uint64_t eop_gpu_addr;
-	uint32_t hqd_pipe_priority;
-	uint32_t hqd_queue_priority;
-	uint32_t mqd_stride_size;
-	bool allow_tunneling;
-	bool hqd_active;
-	uint64_t shadow_addr;
-	uint64_t gds_bkup_addr;
-	uint64_t csa_addr;
-	uint64_t fence_address;
-	bool tmz_queue;
-	bool kernel_queue;
-	uint32_t *cu_mask;
-	uint32_t cu_mask_count;
-	uint32_t cu_flags;
-	bool is_user_cu_masked;
-};
-
-struct amdgpu_mqd {
-	unsigned mqd_size;
-	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
-			struct amdgpu_mqd_prop *p);
-};
-
 struct amdgpu_pcie_reset_ctx {
 	bool in_link_reset;
 	bool occurs_dpc;
@@ -1035,14 +998,6 @@ struct amdgpu_device {
 	struct amdgpu_kfd_dev		kfd;
 };
 
-/*
- * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
- * as fence address and writes a 32 bit fence value to this address.
- * Driver needs to allocate at least 4 DWs extra memory in addition to
- * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
- */
-#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
-
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
 					 uint8_t ip, uint8_t inst)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h
new file mode 100644
index 000000000000..3806ade5fa71
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h
@@ -0,0 +1,75 @@
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
+#ifndef __AMDGPU_MQD_H__
+#define __AMDGPU_MQD_H__
+
+#include <linux/types.h>
+
+struct amdgpu_device;
+
+enum amdgpu_mqd_update_flag {
+	AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
+	AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
+	AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
+};
+
+struct amdgpu_mqd_prop {
+	uint64_t mqd_gpu_addr;
+	uint64_t hqd_base_gpu_addr;
+	uint64_t rptr_gpu_addr;
+	uint64_t wptr_gpu_addr;
+	uint32_t queue_size;
+	bool use_doorbell;
+	uint32_t doorbell_index;
+	uint64_t eop_gpu_addr;
+	uint32_t hqd_pipe_priority;
+	uint32_t hqd_queue_priority;
+	uint32_t mqd_stride_size;
+	bool allow_tunneling;
+	bool hqd_active;
+	uint64_t shadow_addr;
+	uint64_t gds_bkup_addr;
+	uint64_t csa_addr;
+	uint64_t fence_address;
+	bool tmz_queue;
+	bool kernel_queue;
+	uint32_t *cu_mask;
+	uint32_t cu_mask_count;
+	uint32_t cu_flags;
+	bool is_user_cu_masked;
+};
+
+struct amdgpu_mqd {
+	unsigned mqd_size;
+	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
+			struct amdgpu_mqd_prop *p);
+};
+
+/*
+ * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
+ * as fence address and writes a 32 bit fence value to this address.
+ * Driver needs to allocate at least 4 DWs extra memory in addition to
+ * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
+ */
+#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
+#endif
-- 
2.54.0

