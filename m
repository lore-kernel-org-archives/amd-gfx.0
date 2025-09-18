Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD32CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E736210E625;
	Thu, 18 Sep 2025 01:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NlRP66Xf";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B6910E60D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDGriGrai9Qh7o5dB0CmVUOwDQd53f+rgGIdQlfZ7d+w8Q7/TOoBgXu5eEmws11c4dMyY53QwqJUu3ER3enKLnz84Vlyfmkxu8COWPOAy1ZWJ7aHw4lywgbfVLbnAAML+wgqKLjtFoLDIALRvLYKXfjNftBnHCWFYPtz0TJGZvMv4THbHcGmmmo7CAom71fE6PdTZ/h8XmdgMuXeLV5ypC5TeiYPNGz+H1oXluJcwwQNvdLmBHphLK6UegUgnIgq+fma07oAYs3Zonmmbakw8gdn3FxvuU9MsW9OvhKFYEZi9Kxq6e62mAlnbhb+qFNz99jqLZzLgDJkXz9+um/5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+x8FR76V9lTlZjRvyQB7KP+Zj7PUJGTLpbIwP+ohrQ=;
 b=Kf+KZ3i02p+L4PFCNPM1IJyCXYAeB3hPoUsWn2CUrZByWoqqAze1Vcg5D4oIbH3NlcQsTAr+6PJ8zPjUf0EiFDOpjMR+eNuV1R+QTtyVpl+niS3dNZRsKJV3Qd2sWpL1zG33XDZEoq+ifOPzDwVxBRbOWpYxgroffa3k7g+RYFnb09Ieq0Kml3Nk6SF4YwJsn3Jh0LYby12ifIhCX60jv3zjHnua1z5KKmGXlhKA7nWh0sEnUY3lAlP6hljlrCJhIpKRthlh95BL4TK7EQTPmip/AWXprJsn3FTm0vRJZn0LTRlS2Ixs2SnI7V3322d6rvwQG3fucEAkE4oTU1pBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+x8FR76V9lTlZjRvyQB7KP+Zj7PUJGTLpbIwP+ohrQ=;
 b=NlRP66XfcpLDPFigxHNa6bD8bNMS+05ftK9O3rG88IxEaZaLV0GHZ9j0mLGuYAtu3QLTSh5tWT51CZ13asj6ZZpisEIeIBxGug1FlcbSMbq/TLo+EAwe1UrDO1UHjnncNHwkPtOqrhWIW+AkdlDvp+q96FeA9lrYHZ8UU/H4BHg=
Received: from SA1PR03CA0006.namprd03.prod.outlook.com (2603:10b6:806:2d3::19)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 01:36:57 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::95) by SA1PR03CA0006.outlook.office365.com
 (2603:10b6:806:2d3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 01:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:36:56 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:36:54 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 07/10] drm/amd/ras: Amdgpu preprocesses ras interrupts
Date: Thu, 18 Sep 2025 09:35:04 +0800
Message-ID: <20250918013507.2629620-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 777caa3b-5874-4794-d177-08ddf653da93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WxtOAF/f/BU3CnYZm+vPUZpDVc4jYoByRz6jIzOaIzFbgEbm1VyyiSvNbm9Z?=
 =?us-ascii?Q?vFB+LfP9bCq7vDfODYghulyySFUlDfIZ3QlJpQQqqw8PLJV97WipDmwl14gG?=
 =?us-ascii?Q?vuCs0ovEYNvaPMcu7MKibZGnhrAMtgJbMpscS74g9qpPXXFMnMwWVjnf+vzi?=
 =?us-ascii?Q?JNeLube00b0/PbiS/UWHNCF6j352ei8xAztjJZMepxmLSJ5VPf32g5u02KnN?=
 =?us-ascii?Q?fBFOq+NtAfkJUOtOT47AA6zhrtHmOhszLgFJ6bzAoxqFZd06ObIDBZgB/Yr4?=
 =?us-ascii?Q?sAr58zyjtL7IH8W+0P48ts6VszWYeMaXhJw4UgCMNP90MGUP+dvNJogKji8e?=
 =?us-ascii?Q?TOdz5mxYwwxgTnh9/UKn49rG65qil4+pzdFKp4MpFeJ9cj7dZ/bKwuirUG/N?=
 =?us-ascii?Q?3g8qOmeka0rpGHTnojFTEgnAmA9mcvG9Oxz7IVHVJsrXhhMnHeix6Yx2UbF/?=
 =?us-ascii?Q?GLcUjPyLE8Nh0mzYgsOF+IdhFBju9JfJgBey7lL9FxWm5BCByv0FZY7smQew?=
 =?us-ascii?Q?9PL1qimpnrnSmVEDHZslge9PwD/GbISknHw/0Sxx9K7TsBrKgqEjz8ZUSpZm?=
 =?us-ascii?Q?kkJiK+kDg77tF2wr8Jnjj4U9fxv9IVOImdoGmT5s7MNRjaGdtfnuVm9edrxg?=
 =?us-ascii?Q?2ty6KHtebXQrrkxuPq67wMnOH+Z0atvawknQ+3FDPJDg1qG5xrU43L2ovZ2C?=
 =?us-ascii?Q?ahnckzoX2FDaKy24XVE/im5fKTd8E/oNAfZcpUWHLZIkujJMtyRj8/Rkfesz?=
 =?us-ascii?Q?v2vhhAvW5wDqtuEMBLDO9J8ioEX00QIfw+iqVGCiuL2a02YZEb7qIiIvA+9j?=
 =?us-ascii?Q?C8NbqEfCYnBEGNZ8+65yqb/e9wuhEH2csQdR8eV+Okp7+JN+KfLkIdnFuqOM?=
 =?us-ascii?Q?q+BAE4495xw5sIMdIun/SwYA0e/8lmrQAyOMhKB8Sg10hE5xwt3oizw8EtRP?=
 =?us-ascii?Q?tzZ4ZXELdp7Cgz973EFHpZZGyESGy6CEevWBH/r1+3ycAE0K5LP4Dt6Whhi1?=
 =?us-ascii?Q?ycCES98fZUTNdoKv/QlstoUAK2CznoANgIlZXzSSZXFWHJaW/c1RHM4ISOUL?=
 =?us-ascii?Q?JPlz5IYYLyuep+p9kcmMhtMDRq6+ZyPaEN2EN7WfY67rv0MgKP5Vb57GQOyM?=
 =?us-ascii?Q?4YnCFZaAEyRkGciyBFGQmqPinh6TtRujcm3Ssjkuwr5/TN7v2mTOrF83KRnp?=
 =?us-ascii?Q?GaQnNVeb3/xfaXIpQHZKoYheP8oCs5MxNvlVIKaH3mtWxOcj3AhX85SUK3Iz?=
 =?us-ascii?Q?jKfdfK+egZRz4bC2Vd4kDYuEX9fMrHx2qT/rc1oqGy4CNl2DC0XXHw6fu+tu?=
 =?us-ascii?Q?jZtvWhbv9MHqdasckCPMqMXTjAuAh1b1kRXHT5/pu32ep5hQHPgWVtc/GsOS?=
 =?us-ascii?Q?bLq4ClPJl91JwD6G38dTAoO16IXBVJv6POqwVCY1RHJwUiuAteDCU87rNrE/?=
 =?us-ascii?Q?ksiin3ScVJv9ZzuTGHFrYmGXKfLNcJTCXCMCiIUwTgnOTpdgsbBuXLXDv3c6?=
 =?us-ascii?Q?7H+h0sUVx5/B8RBM2LpPscublrSqshj3Sdmh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:36:56.5678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 777caa3b-5874-4794-d177-08ddf653da93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
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

Amdgpu preprocesses ras interrupts.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_ras_process.c  | 126 ++++++++++++++++++
 .../drm/amd/ras/ras_mgr/amdgpu_ras_process.h  |  37 +++++
 2 files changed, 163 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
new file mode 100644
index 000000000000..6727fc9a2b9b
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (c) 2025 Advanced Micro Devices, Inc. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_reset.h"
+#include "amdgpu_xgmi.h"
+#include "ras_sys.h"
+#include "amdgpu_ras_mgr.h"
+#include "amdgpu_ras_process.h"
+
+#define RAS_MGR_RETIRE_PAGE_INTERVAL  100
+
+static void ras_process_retire_page_dwork(struct work_struct *work)
+{
+	struct amdgpu_ras_mgr *ras_mgr =
+		container_of(work, struct amdgpu_ras_mgr, retire_page_dwork.work);
+	struct amdgpu_device *adev = ras_mgr->adev;
+	int ret;
+
+	if (amdgpu_ras_is_rma(adev))
+		return;
+
+	/* If gpu reset is ongoing, delay retiring the bad pages */
+	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) {
+		schedule_delayed_work(&ras_mgr->retire_page_dwork,
+			msecs_to_jiffies(RAS_MGR_RETIRE_PAGE_INTERVAL * 3));
+		return;
+	}
+
+	ret = ras_umc_handle_bad_pages(ras_mgr->ras_core, NULL);
+	if (!ret)
+		schedule_delayed_work(&ras_mgr->retire_page_dwork,
+			msecs_to_jiffies(RAS_MGR_RETIRE_PAGE_INTERVAL));
+}
+
+int amdgpu_ras_process_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	INIT_DELAYED_WORK(&ras_mgr->retire_page_dwork, ras_process_retire_page_dwork);
+
+	return 0;
+}
+
+int amdgpu_ras_process_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	/* Save all cached bad pages to eeprom */
+	flush_delayed_work(&ras_mgr->retire_page_dwork);
+	cancel_delayed_work_sync(&ras_mgr->retire_page_dwork);
+	return 0;
+}
+
+int amdgpu_ras_process_handle_umc_interrupt(struct amdgpu_device *adev, void *data)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!ras_mgr->ras_core)
+		return -EINVAL;
+
+	return ras_process_add_interrupt_req(ras_mgr->ras_core, NULL, true);
+}
+
+int amdgpu_ras_process_handle_unexpected_interrupt(struct amdgpu_device *adev, void *data)
+{
+	amdgpu_ras_set_fed(adev, true);
+	return amdgpu_ras_mgr_reset_gpu(adev, AMDGPU_RAS_GPU_RESET_MODE1_RESET);
+}
+
+int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *adev, void *data)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct ras_ih_info *ih_info = (struct ras_ih_info *)data;
+	struct ras_event_req req;
+	uint64_t seqno;
+
+	if (!ih_info)
+		return -EINVAL;
+
+	memset(&req, 0, sizeof(req));
+	req.block = ih_info->block;
+	req.data = ih_info->data;
+	req.pasid = ih_info->pasid;
+	req.pasid_fn = ih_info->pasid_fn;
+	req.reset = ih_info->reset;
+
+	seqno = ras_core_get_seqno(ras_mgr->ras_core,
+				RAS_SEQNO_TYPE_POISON_CONSUMPTION, false);
+
+	/* When the ACA register cannot be read from FW, the poison
+	 * consumption seqno in the fifo will not pop up, so it is
+	 * necessary to check whether the seqno is the previous seqno.
+	 */
+	if (seqno == ras_mgr->last_poison_consumption_seqno) {
+		/* Pop and discard the previous seqno */
+		ras_core_get_seqno(ras_mgr->ras_core,
+				RAS_SEQNO_TYPE_POISON_CONSUMPTION, true);
+		seqno = ras_core_get_seqno(ras_mgr->ras_core,
+					RAS_SEQNO_TYPE_POISON_CONSUMPTION, false);
+	}
+	ras_mgr->last_poison_consumption_seqno = seqno;
+	req.seqno = seqno;
+
+	return ras_process_add_interrupt_req(ras_mgr->ras_core, &req, false);
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
new file mode 100644
index 000000000000..b9502bd21beb
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#ifndef __AMDGPU_RAS_PROCESS_H__
+#define __AMDGPU_RAS_PROCESS_H__
+#include "ras_process.h"
+#include "amdgpu_ras_mgr.h"
+
+enum ras_ih_type;
+int amdgpu_ras_process_init(struct amdgpu_device *adev);
+int amdgpu_ras_process_fini(struct amdgpu_device *adev);
+int amdgpu_ras_process_handle_umc_interrupt(struct amdgpu_device *adev,
+		void *data);
+int amdgpu_ras_process_handle_unexpected_interrupt(struct amdgpu_device *adev,
+		void *data);
+int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *adev,
+		void *data);
+#endif
-- 
2.34.1

