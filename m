Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE12D35663
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D7010E5FD;
	Wed, 28 Jan 2026 02:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hDBKnVPS";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010028.outbound.protection.outlook.com
 [40.93.198.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE7D510E5FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNdbqgsSj1wgc5bRSn6QgGeiETkjV+RoArpbCJ+wz5T71SNGoE4P/HhRTEDzZWpr8prYQpqj3tWsVE+maffG72ULSfA1h0IPmanJr8C6In+MG0rv3GNcWhBDN3C/lxanhl3vNv0SlJlkfkKV6XyLyo3L1f7HNifaEjeRmT3UTZqCA2JffkuB+RaCuLfHzuYQ/oUc/f6pGuzrB8NQyCDD7Gbv+q9VHllWezYvs12+n6kncL0g0/OnkMsrPlPLbPNocMpAS1pB9rgeb0Bub25PlDi3HEhljIDr9cTxq1/Psjv4dByqi4EffNM8B0s+fUcfZdwAw0rz2s+gV4MvbrDA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzuWy7MDyQDpDIdFpVXB4C9MFfULJCcJ6BJxRR//GDc=;
 b=d7eRjNDT/ifwx02x/AtTbgn+On28EUh3zC5MvviE/P+BW07n3mYlVolHMhgw6N8sjVAEyvevBEeSwmsJ1nSWjAci/P12K14IwXje6UUsU5uTtDE49yBCvJGeIoiIpDVSbQU+YrthiRPZHYcuFJp/UXHLCAv4JwpvG2bclu6COG18y4GNUQ29R1rTiyzfLAGri06FHiz6zacFHcFjAl0ViXAY1k3Nrbp8C+JNiDhVoHZxKEqRkG+yLOruu8Q6ueSNj1HzRLeJyr4fFgi72aliMG/9g5QJIBtzMasy+wNVj6fHoDVg4irSvNFg4k25C/EwkUX43j3Irfa1wdvPbTm7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzuWy7MDyQDpDIdFpVXB4C9MFfULJCcJ6BJxRR//GDc=;
 b=hDBKnVPSJUDggOpqtiMIwWsSGK5jmh27uRF8lyDcd2sMa8UjyJAEEEsj8pa629XbxaIH1NIbJ4wIwVFxY5eYoqDtZrkgt1NHZXhcTn0BaoAYc/rBtkq0Ru6BNNMwD7xGtsG9mKIjbjgLa8DwPYYh6jpklyahr4P+A3lk4MVCOMQ=
Received: from MN0P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::14)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 02:00:16 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::14) by MN0P221CA0026.outlook.office365.com
 (2603:10b6:208:52a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 01:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:00:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:09 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 20:00:06 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Bhuvanachandra Pinninti <bpinnint@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 14/21] drm/amd/display: Migrate DIO registers access from
 hwseq to dio component.
Date: Wed, 28 Jan 2026 09:51:39 +0800
Message-ID: <20260128015538.568712-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d164d60-654d-4ab6-9396-08de5e10fb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zdoU1iY6FZZdwvUAkwWqXPO/xerUQkj21aMKsd0bMpY3ZDWBEuNDQyGvL6tT?=
 =?us-ascii?Q?kJfciOLt4L2rS3ZltLOXTiasVmmEMDiUzxf9ejR0QXjdH+Rg3SVzM78ANlDw?=
 =?us-ascii?Q?IK94gV05ceF/czyJtkdu9z3NN0NyY1UMWKbNoBAmEWFCiuei4bN2AHlCAIXq?=
 =?us-ascii?Q?hZK03JiVdEfAjPJD9UiSBPZz/D8utZY0JmF2JVv89w717drvpBXmbXHP4QQY?=
 =?us-ascii?Q?0n0CRqajc7Gl75q2huuGIFRivR5+qy8ucrjoRMeaO2lcDq2wMZyAq4fv09GN?=
 =?us-ascii?Q?nse80YLrGQ9Qj4x8+cgOWo/FoWu7/BKzFegn/h0YsX/QjySZZQ67IzuoCLSl?=
 =?us-ascii?Q?xG37KbKWyN1HQTJHuLM5Jrqd952rrpcrYgHzFkpSEoCKeKmXUPw+bG/Y8u1E?=
 =?us-ascii?Q?Bid/AI/42aa3WnSOB05TaTpdyqmCH8yt0GmieCuIWcCcbkwf3Kz+ZZoAFc+H?=
 =?us-ascii?Q?vNWby1YoxsQh20ifDMC5oatiTiZQ0z2tlnKkzHwwZDSQf/e8JQzsXJqpDg6r?=
 =?us-ascii?Q?opu5G5dUE4jf2q9wMR7Ibep29L/7IriAKWWy1irSGKGLAQ+vzG7G1NqvOpeu?=
 =?us-ascii?Q?Gjb9kohTHxVXY29rXkWY+2ccqITsgU7IqIvj1iOslTp22OJkB2/WTBrChLno?=
 =?us-ascii?Q?Ep2Gr4i+4E6EribeDMGRpVF4ED5K7sXINmJaSuORLS7LLJeiND2YXl6R2fnE?=
 =?us-ascii?Q?dht7pydmKIKSOrMfLUcpBhxnu8tM3KRbrSJdmG4k1CzbZzVZCSBJRZFz0xh1?=
 =?us-ascii?Q?NWFIR0EqlU14vRW/Rsy/uSyhsXVIXhc0pZeD2T9ZWbN5DN9hlttkaIhpfBiA?=
 =?us-ascii?Q?cSUMXW6Shn0R/9ZcUT7VJDkYHDcSLtX+qGTg0KfAHj6czgqcmVe86IlTRwVJ?=
 =?us-ascii?Q?Mjcw6tZdbEs/JQ6OYkVwe74E/YN/upJYOdugLD86XuhiQRPLg37ujrEwtwf/?=
 =?us-ascii?Q?ua2NMZZdKvfJkl2G/vEPH96PsdogeOZNKCazNdssTL9fMagsVH8H8ISfKDWN?=
 =?us-ascii?Q?RkGvYeAIbOAYPcgPxM8lPASAcT34Uf4oK54C9QYPnojA8EjXupgjwpNE4PI8?=
 =?us-ascii?Q?jbn8L48FbpkFzDR1501vT3TPZ7sZRtCPjNzT5mYp8n/A7/7aIBbPW6CuOW99?=
 =?us-ascii?Q?pSExxtEd7zh8NzfTz1dgxZVZTS50ZW09czz+YeUptNY13KuRIO448kE627IH?=
 =?us-ascii?Q?hwmEt4X+SspsdYEPe4jCQKkbskR7Ytmi+ZnOUrGC1GeqwW26VxjMBvVWd9Ly?=
 =?us-ascii?Q?Ubdqz6q43GQdrlbJVr84uImRz7WOSerVmrsbRee5swoAI0u1NWvSav3vy9DV?=
 =?us-ascii?Q?FDwJbSPgCyy/unJSglOu9DOg7fqDsSEwgNGUjfULDUyYXeyCCHRLK/rEYCgL?=
 =?us-ascii?Q?rME6rJa4DtnpOKe+ht/6TerlC4soSqRP43haVH1ihFdhk74zJVTVdvja0kZh?=
 =?us-ascii?Q?dwiFl+63nC/9pnljQnOqOBWfJOGgDeInaPrOzbeLl4WVgwqF/BX0JSi6wJkx?=
 =?us-ascii?Q?LCvDvWPPWOeGMFggQAx3FuWKPmG6WkmYXW83egqKCv88D3k6MgUFKfwAyqOG?=
 =?us-ascii?Q?lkTyP0G/Py+yJwiX+eWWRrXfq5NwQFbIOrLfoN32Ch3X30P9DcYaI3IUDkYC?=
 =?us-ascii?Q?pqC4rhSi8IBuh+wT/aYjlu0YBFigLeFvh6a7ySanLKBlKoRNeTbEp3iYh5Pn?=
 =?us-ascii?Q?BJU1tQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:00:16.4425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d164d60-654d-4ab6-9396-08de5e10fb7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
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

From: Bhuvanachandra Pinninti <bpinnint@amd.com>

[why]
Direct DIO registers access in hwseq layer was creating register conflicts.

[how]
Migrated DIO registers from hwseq to dio component.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <bpinnint@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |  2 +-
 .../drm/amd/display/dc/dio/dcn10/dcn10_dio.c  | 47 +++++++++++++++++++
 .../drm/amd/display/dc/dio/dcn10/dcn10_dio.h  | 42 +++++++++++++++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  4 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  5 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  4 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 10 ++--
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 10 ++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  4 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dio.h   | 22 +++++++++
 .../dc/resource/dcn401/dcn401_resource.c      | 41 ++++++++++++++++
 13 files changed, 179 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/dio.h

diff --git a/drivers/gpu/drm/amd/display/dc/dio/Makefile b/drivers/gpu/drm/amd/display/dc/dio/Makefile
index 0dfd480976f7..02eec03dc204 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dio/Makefile
@@ -27,7 +27,7 @@ ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
 # DCN10
 ###############################################################################
-DIO_DCN10 = dcn10_link_encoder.o dcn10_stream_encoder.o
+DIO_DCN10 = dcn10_link_encoder.o dcn10_stream_encoder.o dcn10_dio.o
 
 AMD_DAL_DIO_DCN10 = $(addprefix $(AMDDALPATH)/dc/dio/dcn10/,$(DIO_DCN10))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c
new file mode 100644
index 000000000000..edcf4e67483b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#include "dc_hw_types.h"
+#include "dm_services.h"
+#include "reg_helper.h"
+#include "dcn10_dio.h"
+
+#define CTX \
+	dio10->base.ctx
+#define REG(reg)\
+	dio10->regs->reg
+
+#undef FN
+#define FN(reg_name, field_name) \
+	dio10->shifts->field_name, dio10->masks->field_name
+
+static void dcn10_dio_mem_pwr_ctrl(struct dio *dio, bool enable_i2c_light_sleep)
+{
+	struct dcn10_dio *dio10 = TO_DCN10_DIO(dio);
+
+	/* power AFMT HDMI memory */
+	REG_WRITE(DIO_MEM_PWR_CTRL, 0);
+
+	if (enable_i2c_light_sleep)
+		REG_UPDATE(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, 1);
+}
+
+static const struct dio_funcs dcn10_dio_funcs = {
+	.mem_pwr_ctrl = dcn10_dio_mem_pwr_ctrl,
+};
+
+void dcn10_dio_construct(
+	struct dcn10_dio *dio10,
+	struct dc_context *ctx,
+	const struct dcn_dio_registers *regs,
+	const struct dcn_dio_shift *shifts,
+	const struct dcn_dio_mask *masks)
+{
+	dio10->base.ctx = ctx;
+	dio10->base.funcs = &dcn10_dio_funcs;
+
+	dio10->regs = regs;
+	dio10->shifts = shifts;
+	dio10->masks = masks;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.h b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.h
new file mode 100644
index 000000000000..369c5996326e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.h
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#ifndef __DCN10_DIO_H__
+#define __DCN10_DIO_H__
+
+#include "dio.h"
+
+#define TO_DCN10_DIO(dio_base) \
+	container_of(dio_base, struct dcn10_dio, base)
+
+#define DIO_REG_LIST_DCN10()\
+	SR(DIO_MEM_PWR_CTRL)
+
+struct dcn_dio_registers {
+	uint32_t DIO_MEM_PWR_CTRL;
+};
+
+struct dcn_dio_shift {
+	uint8_t I2C_LIGHT_SLEEP_FORCE;
+};
+
+struct dcn_dio_mask {
+	uint32_t I2C_LIGHT_SLEEP_FORCE;
+};
+
+struct dcn10_dio {
+	struct dio base;
+	const struct dcn_dio_registers *regs;
+	const struct dcn_dio_shift *shifts;
+	const struct dcn_dio_mask *masks;
+};
+
+void dcn10_dio_construct(
+	struct dcn10_dio *dio10,
+	struct dc_context *ctx,
+	const struct dcn_dio_registers *regs,
+	const struct dcn_dio_shift *shifts,
+	const struct dcn_dio_mask *masks);
+
+#endif /* __DCN10_DIO_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index f89b2f5a9bbd..5243177c1faa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -50,6 +50,7 @@
 #include "link_hwss.h"
 #include "dpcd_defs.h"
 #include "dsc.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dce/dmub_psr.h"
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
@@ -1881,7 +1882,8 @@ void dcn10_init_hw(struct dc *dc)
 
 	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
 	if (!is_optimized_init_done)
-		REG_WRITE(DIO_MEM_PWR_CTRL, 0);
+		if (dc->res_pool->dio && dc->res_pool->dio->funcs->mem_pwr_ctrl)
+			dc->res_pool->dio->funcs->mem_pwr_ctrl(dc->res_pool->dio, false);
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index 7cd225a6cf6c..ce18d75fd991 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -40,6 +40,8 @@
 #include "clk_mgr.h"
 #include "reg_helper.h"
 #include "dcn10/dcn10_hubbub.h"
+#include "dio/dcn10/dcn10_dio.h"
+
 
 #define CTX \
 	hws->ctx
@@ -360,7 +362,8 @@ void dcn201_init_hw(struct dc *dc)
 	}
 
 	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
-	REG_WRITE(DIO_MEM_PWR_CTRL, 0);
+	if (dc->res_pool->dio && dc->res_pool->dio->funcs->mem_pwr_ctrl)
+		dc->res_pool->dio->funcs->mem_pwr_ctrl(dc->res_pool->dio, false);
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 3ff15ec9dc17..d58f2cf2615c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -53,6 +53,7 @@
 #include "dcn30/dcn30_resource.h"
 #include "link_service.h"
 #include "dc_state_priv.h"
+#include "dio/dcn10/dcn10_dio.h"
 
 #define TO_DCN_DCCG(dccg)\
 	container_of(dccg, struct dcn_dccg, base)
@@ -794,7 +795,8 @@ void dcn30_init_hw(struct dc *dc)
 	}
 
 	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
-	REG_WRITE(DIO_MEM_PWR_CTRL, 0);
+	if (dc->res_pool->dio && dc->res_pool->dio->funcs->mem_pwr_ctrl)
+		dc->res_pool->dio->funcs->mem_pwr_ctrl(dc->res_pool->dio, false);
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 91a672a46289..db2f7cbb12ff 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -53,6 +53,7 @@
 #include "dcn30/dcn30_vpg.h"
 #include "dce/dce_i2c_hw.h"
 #include "dce/dmub_abm_lcd.h"
+#include "dio/dcn10/dcn10_dio.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -237,12 +238,9 @@ void dcn31_init_hw(struct dc *dc)
 			abms[i]->funcs->abm_init(abms[i], backlight, user_level);
 	}
 
-	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
-	REG_WRITE(DIO_MEM_PWR_CTRL, 0);
-
-	// Set i2c to light sleep until engine is setup
-	if (dc->debug.enable_mem_low_power.bits.i2c)
-		REG_UPDATE(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, 1);
+	/* Power on DIO memory (AFMT HDMI) and set I2C to light sleep */
+	if (dc->res_pool->dio && dc->res_pool->dio->funcs->mem_pwr_ctrl)
+		dc->res_pool->dio->funcs->mem_pwr_ctrl(dc->res_pool->dio, dc->debug.enable_mem_low_power.bits.i2c);
 
 	if (hws->funcs.setup_hpo_hw_control)
 		hws->funcs.setup_hpo_hw_control(hws, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 3f76fba7dccc..37300e12e645 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -52,6 +52,7 @@
 #include "link_service.h"
 #include "../dcn20/dcn20_hwseq.h"
 #include "dc_state_priv.h"
+#include "dio/dcn10/dcn10_dio.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -955,7 +956,8 @@ void dcn32_init_hw(struct dc *dc)
 	}
 
 	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
-	REG_WRITE(DIO_MEM_PWR_CTRL, 0);
+	if (dc->res_pool->dio && dc->res_pool->dio->funcs->mem_pwr_ctrl)
+		dc->res_pool->dio->funcs->mem_pwr_ctrl(dc->res_pool->dio, false);
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 1c7263f9ef51..b5a4cefbd35f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -53,6 +53,7 @@
 #include "dcn30/dcn30_vpg.h"
 #include "dce/dce_i2c_hw.h"
 #include "dsc.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dcn20/dcn20_optc.h"
 #include "dcn30/dcn30_cm_common.h"
 #include "dcn31/dcn31_hwseq.h"
@@ -272,12 +273,9 @@ void dcn35_init_hw(struct dc *dc)
 		}
 	}
 
-	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
-	REG_WRITE(DIO_MEM_PWR_CTRL, 0);
-
-	// Set i2c to light sleep until engine is setup
-	if (dc->debug.enable_mem_low_power.bits.i2c)
-		REG_UPDATE(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, 0);
+	/* Power on DIO memory (AFMT HDMI) and optionally disable I2C light sleep */
+	if (dc->res_pool->dio && dc->res_pool->dio->funcs->mem_pwr_ctrl)
+		dc->res_pool->dio->funcs->mem_pwr_ctrl(dc->res_pool->dio, !dc->debug.enable_mem_low_power.bits.i2c);
 
 	if (hws->funcs.setup_hpo_hw_control)
 		hws->funcs.setup_hpo_hw_control(hws, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 567ed207d7cd..9cda39d0ed95 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -39,6 +39,7 @@
 #include "dc_state_priv.h"
 #include "link_enc_cfg.h"
 #include "../hw_sequencer.h"
+#include "dio/dcn10/dcn10_dio.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -320,7 +321,8 @@ void dcn401_init_hw(struct dc *dc)
 	}
 
 	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
-	REG_WRITE(DIO_MEM_PWR_CTRL, 0);
+	if (dc->res_pool->dio && dc->res_pool->dio->funcs->mem_pwr_ctrl)
+		dc->res_pool->dio->funcs->mem_pwr_ctrl(dc->res_pool->dio, false);
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 61d8ef759aca..43579b0e1482 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -35,6 +35,7 @@
 #include "hubp.h"
 #include "mpc.h"
 #include "dwb.h"
+#include "hw/dio.h"
 #include "mcif_wb.h"
 #include "panel_cntl.h"
 #include "dmub/inc/dmub_cmd.h"
@@ -250,6 +251,7 @@ struct resource_pool {
 	struct timing_generator *timing_generators[MAX_PIPES];
 	struct stream_encoder *stream_enc[MAX_PIPES * 2];
 	struct hubbub *hubbub;
+	struct dio *dio;
 	struct mpc *mpc;
 	struct pp_smu_funcs *pp_smu;
 	struct dce_aux *engines[MAX_PIPES];
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dio.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dio.h
new file mode 100644
index 000000000000..532bf54cf2c4
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dio.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#ifndef __DC_DIO_H__
+#define __DC_DIO_H__
+
+#include "dc_types.h"
+
+struct dc_context;
+struct dio;
+
+struct dio_funcs {
+	void (*mem_pwr_ctrl)(struct dio *dio, bool enable_i2c_light_sleep);
+};
+
+struct dio {
+	const struct dio_funcs *funcs;
+	struct dc_context *ctx;
+};
+
+#endif /* __DC_DIO_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 1cdbb65da4a3..df3acf589582 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -21,6 +21,7 @@
 #include "dcn401/dcn401_hubbub.h"
 #include "dcn401/dcn401_mpc.h"
 #include "dcn401/dcn401_hubp.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "irq/dcn401/irq_service_dcn401.h"
 #include "dcn401/dcn401_dpp.h"
 #include "dcn401/dcn401_optc.h"
@@ -634,6 +635,22 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+#define dio_regs_init() \
+		DIO_REG_LIST_DCN10()
+
+static struct dcn_dio_registers dio_regs;
+
+#define DIO_MASK_SH_LIST_DCN401(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST_DCN401(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST_DCN401(_MASK)
+};
+
 static const struct resource_caps res_cap_dcn4_01 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
@@ -881,6 +898,22 @@ static struct hubbub *dcn401_hubbub_create(struct dc_context *ctx)
 	return &hubbub2->base;
 }
 
+static struct dio *dcn401_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc(sizeof(struct dcn10_dio), GFP_KERNEL);
+
+	if (!dio10)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT dio_regs
+	dio_regs_init();
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubp *dcn401_hubp_create(
 	struct dc_context *ctx,
 	uint32_t inst)
@@ -2071,6 +2104,14 @@ static bool dcn401_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn401_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs, TGs, ABMs */
 	for (i = 0, j = 0; i < pool->base.res_cap->num_timing_generator; i++) {
 
-- 
2.43.0

