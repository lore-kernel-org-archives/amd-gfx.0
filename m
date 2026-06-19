Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D314CD98F6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C70210F5D0;
	Fri, 19 Jun 2026 13:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5BizMzg+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67F810F5D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCzHmL0+1Sj8Q8Uv3tMblUpgrbthKCxceR0jl3g1xoOgc5Y8NLULipo0aGQysJZrz8LzQJ5fpCxlKyvSaXVM6LxaPbWOzbVgjM5ebJsYnRk+Rm/Wp4GZ0I4NnFO/da8rfV3eNw4Mt9hN1buXkzPTszSRnJb5v+tonZS9McI06LAMvIsXWPzWObhEkDS/FN8gX/AUoa7pBMjbLccC2gFHJW9s4g0zvXkpQcBDRIeZnnYym+6CLOWUKmskow+QMWlVOjsDBRCLu9J224iZNzo2FH0QGiIAWq0CfQoN7+PVaYCH8Eko39Phhr+iIHonwgDG2Lr6oZoAzqMBZuuq7euybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/k/xF31NIozN2vwxpPDmuoMmy7N+nVljxJvCn9P+ao=;
 b=mMBYEQxvThfRGYFD7j+7BR/vrGyUhPIYSlxSPnjO5g66Xy0RligS5VeFSyJ+BjJn5kQe3+wLoft09saMpBLXGW85rxJsqydSUISupDj0qtf124+Wh+uEYmyxdCTx9JEjmrVkwC/3GwfLznAyiGfoTbLCz9QSoht5KhLmj04qU+LU6JxoQ0r45oWZlBqseFe0QyugUotFp6kZalrXK0bnnvw9uMTjKynn6in6atXKUYVFQu6Kegvx/dn2VIlpVkusJdA4DrFIlfbUOjepmolkLGOqSuy6QUJGCwizd3WQ46fO0HTX6hBx7udqfHsBA1GtTlEW7kQ0tuocxFeSFMwnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/k/xF31NIozN2vwxpPDmuoMmy7N+nVljxJvCn9P+ao=;
 b=5BizMzg+Y4D/GysxOJbMQJcPLk+J9Wsp0ZQyN1vGin1jGvgY9cSk21kZ9ct0LTIaCAQrkq8xTDQ2qcSL/cVq2WIe7j8VhQUJs8iQkyZ6/mvq9cOUGAIHL/g3W4COj3/uCUm6aplx9vh1PkhRS1mrgFypToW1uohq/ZspdMK8H38=
Received: from BLAPR03CA0112.namprd03.prod.outlook.com (2603:10b6:208:32a::27)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 13:32:21 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::94) by BLAPR03CA0112.outlook.office365.com
 (2603:10b6:208:32a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 13:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:20 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:19 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 01/24] drm/amd/display: Add dcn42b_soc_and_ip_translator
Date: Fri, 19 Jun 2026 09:21:16 -0400
Message-ID: <20260619133154.116746-2-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f85b166-d4a2-4561-94f5-08dece07302d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|18002099003|3023799007|56012099006|5023799004|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Hb9EQ0f9hbGzvDR84HbFgPzCt66/bRG5VQ9Jazz15Qrzcpnv9Ym4n+JJKR0iKsOKHeH2IJGIcTU51oMNCeZOxU3eJQo3bpsDyvJ8FFObLkR0yfCbZqtSHs7WXs/qYgCB2fAvpX7NCu3t/Uuj+uf6LBPTnI91qToJqrxYWZpVboL2g44t0ucZWQNnxRaTdi/Qy3P2KBNAu7NNuMA2waTPvI5RLbJeagbMV+9qCZpGl98QgjGk1MiUXC9mu28qEWNNP9fo4VTnoSXivHXu/v7LTz+vX3rQosRvxEIsLzqwk1hzHkUHISgzUwaSQoZFb9IBTkdepRfBA7bf4HX2pM5Z31csGp/XVAECCmvhX8FqPHlxN5cabS3F94gj8Ll7cVRTC63r6ZU2I3BkRgaMFUTUpe+4gRtMEVcpxcCoIkdEq9jnS/sLBmP1vcpdySX5r5qRv6G81BGm6cBuHDLhMf+IhJo+Xy3WFlxVs2eL9+NCuffmt1TiObY9Y1celaQeCSeI0BS+LN6ysuuvuG0AwYZz7j0KdDZDF4WEegXP0gk7hNNiYn7j9O288xuRYvJHFAJFZzzZJOhRsmOaFW8KDX9sbEkz4C4RTwX2t7DXF7Lu0cK8qV5uuVBOJDFMHatJbJlUSyByVirIRC1PaacpBGeQuQQhQcfl6cAMZUXARxhDsEefKycIClzAqs6kqmD6//vtNqEQPbMnoXXW3l9Ow0VabA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(18002099003)(3023799007)(56012099006)(5023799004)(11063799006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bb/SZrNas5LO1kK4IBdPjQmwDBhPN+dQdzyc1Rcw7eBhMkSaiGHE9x5UdFOJLptOA4WMdgyusekPg/4pF/2xrTunjbHjvc7VOcsPzPJmShJcC51IhIyssU61CNmO43j8aRBDL/dnw8u8dE1EbRlPqpKNyeXCCL3M6lkWn6Jzj+xVcY9QTDGMLLAkawevplDcu6QxvVo1uKBP6ASt0Sw9GT8bf0y/VqSXIitpbI4Bp3xfPnW0JKmvzJSujIenGBG0QnHN3cdEh5596FFQjYVMYdefrndzWkKt/o4Guddb99+8pK7iiW4x+NNbQJe7QF4UazLPPPeIoq0TNtbjRA8ntI9unArKVqTMSWPgEmV4trzCL1xZRXkwTghf+V1++o2dLvhi0l4WYivBGTTqzNoGOqafFCrG+A8PGRak+NdjnHMbuNmSTWhVyZxu8R6rbv/e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:20.1145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f85b166-d4a2-4561-94f5-08dece07302d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[why]

DCN42B was not using its own max_ip_caps table. Need to create a
separate soc_and_ip_translator in order to not reuse the DCN42 one.

[how]

Separate DCN42B into its own soc_and_ip_translator.c file to handle this.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  | 38 +++++++++++++++++
 .../display/dc/soc_and_ip_translator/Makefile |  3 ++
 .../dcn42/dcn42_soc_and_ip_translator.c       | 18 +++-----
 .../dcn42/dcn42_soc_and_ip_translator.h       |  1 +
 .../dcn42b/dcn42b_soc_and_ip_translator.c     | 42 +++++++++++++++++++
 .../dcn42b/dcn42b_soc_and_ip_translator.h     | 17 ++++++++
 .../soc_and_ip_translator.c                   |  5 ++-
 7 files changed, 111 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.h

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
index eae4a37b0984..60ef56419846 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
@@ -224,4 +224,42 @@ static const struct dml2_soc_bb dml2_socbb_dcn42b = {
 	.max_fclk_for_uclk_dpm_khz = 2200 * 1000,
 };

+static const struct dml2_ip_capabilities dml2_dcn42b_max_ip_caps = {
+	.pipe_count = 4,
+	.otg_count = 3,
+	.num_dsc = 3,
+	.max_num_dp2p0_streams = 3,
+	.max_num_hdmi_frl_outputs = 0,
+	.max_num_dp2p0_outputs = 2,
+	.rob_buffer_size_kbytes = 64,
+	.config_return_buffer_size_in_kbytes = 1792,
+	.config_return_buffer_segment_size_in_kbytes = 64,
+	.meta_fifo_size_in_kentries = 32,
+	.compressed_buffer_segment_size_in_kbytes = 64,
+	.cursor_buffer_size = 24,
+	.max_flip_time_us = 110,
+	.max_flip_time_lines = 50,
+	.hostvm_mode = 0,
+	.subvp_drr_scheduling_margin_us = 100,
+	.subvp_prefetch_end_to_mall_start_us = 15,
+	.subvp_fw_processing_delay = 15,
+	.max_vactive_det_fill_delay_us = 400,
+
+	.fams2 = {
+		.max_allow_delay_us = 100 * 1000,
+		.scheduling_delay_us = 550,
+		.vertical_interrupt_ack_delay_us = 40,
+		.allow_programming_delay_us = 18,
+		.min_allow_width_us = 20,
+		.subvp_df_throttle_delay_us = 100,
+		.subvp_programming_delay_us = 200,
+		.subvp_prefetch_to_mall_delay_us = 18,
+		.drr_programming_delay_us = 35,
+
+		.lock_timeout_us = 5000,
+		.recovery_timeout_us = 5000,
+		.flip_programming_delay_us = 300,
+	},
+};
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
index d168fb1eacf7..8a9bb0aef9b7 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
@@ -9,13 +9,16 @@ soc_and_ip_translator_rcflags := $(CC_FLAGS_NO_FPU)

 CFLAGS_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.o := $(soc_and_ip_translator_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.o := $(soc_and_ip_translator_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.o := $(soc_and_ip_translator_ccflags)

 CFLAGS_REMOVE_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.o := $(soc_and_ip_translator_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.o := $(soc_and_ip_translator_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.o := $(soc_and_ip_translator_rcflags)

 soc_and_ip_translator := soc_and_ip_translator.o
 soc_and_ip_translator += dcn401/dcn401_soc_and_ip_translator.o
 soc_and_ip_translator += dcn42/dcn42_soc_and_ip_translator.o
+soc_and_ip_translator += dcn42b/dcn42b_soc_and_ip_translator.o

 AMD_DAL_soc_and_ip_translator := $(addprefix $(AMDDALPATH)/dc/soc_and_ip_translator/, $(soc_and_ip_translator))

diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
index ae2c6a2f3f75..c6c1b19b7370 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -5,22 +5,16 @@
 #include "dcn42_soc_and_ip_translator.h"
 #include "../dcn401/dcn401_soc_and_ip_translator.h"
 #include "bounding_boxes/dcn42_soc_bb.h"
-#include "bounding_boxes/dcn42b_soc_bb.h"

 /* soc_and_ip_translator component used to get up-to-date values for bounding box.
  * Bounding box values are stored in several locations and locations can vary with DCN revision.
  * This component provides an interface to get DCN-specific bounding box values.
  */

-static void get_default_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc)
+static void get_default_soc_bb(struct dml2_soc_bb *soc_bb)
 {
-	if (dc->ctx->dce_version == DCN_VERSION_4_2B) {
-		memcpy(soc_bb, &dml2_socbb_dcn42b, sizeof(struct dml2_soc_bb));
-		memcpy(&soc_bb->qos_parameters, &dml_dcn42b_variant_a_soc_qos_params, sizeof(struct dml2_soc_qos_parameters));
-	} else {
-		memcpy(soc_bb, &dml2_socbb_dcn42, sizeof(struct dml2_soc_bb));
-		memcpy(&soc_bb->qos_parameters, &dml_dcn42_variant_a_soc_qos_params, sizeof(struct dml2_soc_qos_parameters));
-	}
+	memcpy(soc_bb, &dml2_socbb_dcn42, sizeof(struct dml2_soc_bb));
+	memcpy(&soc_bb->qos_parameters, &dml_dcn42_variant_a_soc_qos_params, sizeof(struct dml2_soc_qos_parameters));
 }

 /*
@@ -165,7 +159,7 @@ static void dcn42_update_soc_bb_with_values_from_clk_mgr(struct dml2_soc_bb *soc
 	}
 }

-static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
+void dcn42_apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
 {
 	(void)config;
 	/* Individual modification can be overwritten even if it was obtained by a previous function.
@@ -181,9 +175,9 @@ static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc
 void dcn42_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
 {
 	//get default soc_bb with static values
-	get_default_soc_bb(soc_bb, dc);
+	get_default_soc_bb(soc_bb);
 	//update soc_bb values with more accurate values
-	apply_soc_bb_updates(soc_bb, dc, config);
+	dcn42_apply_soc_bb_updates(soc_bb, dc, config);
 }

 static void dcn42_get_ip_caps(struct dml2_ip_capabilities *ip_caps)
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h
index 1dded5426152..8ac90655f276 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h
@@ -13,5 +13,6 @@

 void dcn42_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator);
 void dcn42_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config);
+void dcn42_apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config);

 #endif /* _DCN42_SOC_AND_IP_TRANSLATOR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.c
new file mode 100644
index 000000000000..50669f458e23
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#include "../dcn42/dcn42_soc_and_ip_translator.h"
+#include "dcn42b_soc_and_ip_translator.h"
+#include "../dcn401/dcn401_soc_and_ip_translator.h"
+#include "bounding_boxes/dcn42b_soc_bb.h"
+
+/* soc_and_ip_translator component used to get up-to-date values for bounding box.
+ * Bounding box values are stored in several locations and locations can vary with DCN revision.
+ * This component provides an interface to get DCN-specific bounding box values.
+ */
+
+static void get_default_soc_bb(struct dml2_soc_bb *soc_bb)
+{
+	memcpy(soc_bb, &dml2_socbb_dcn42b, sizeof(struct dml2_soc_bb));
+	memcpy(&soc_bb->qos_parameters, &dml_dcn42b_variant_a_soc_qos_params, sizeof(struct dml2_soc_qos_parameters));
+}
+
+void dcn42b_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
+{
+	//get default soc_bb with static values
+	get_default_soc_bb(soc_bb);
+	//update soc_bb values with more accurate values
+	dcn42_apply_soc_bb_updates(soc_bb, dc, config);
+}
+
+static void dcn42b_get_ip_caps(struct dml2_ip_capabilities *ip_caps)
+{
+	*ip_caps = dml2_dcn42b_max_ip_caps;
+}
+
+static struct soc_and_ip_translator_funcs dcn42b_translator_funcs = {
+	.get_soc_bb = dcn42b_get_soc_bb,
+	.get_ip_caps = dcn42b_get_ip_caps,
+};
+
+void dcn42b_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator)
+{
+	soc_and_ip_translator->translator_funcs = &dcn42b_translator_funcs;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.h b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.h
new file mode 100644
index 000000000000..0d4ea613431a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#ifndef _DCN42B_SOC_AND_IP_TRANSLATOR_H_
+#define _DCN42B_SOC_AND_IP_TRANSLATOR_H_
+
+#include "core_types.h"
+#include "dc.h"
+#include "clk_mgr.h"
+#include "dml_top_soc_parameter_types.h"
+#include "soc_and_ip_translator.h"
+
+void dcn42b_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator);
+void dcn42b_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config);
+
+#endif /* _DCN42B_SOC_AND_IP_TRANSLATOR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
index e6887cac5884..ffc9c38eeeed 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
@@ -5,6 +5,7 @@
 #include "soc_and_ip_translator.h"
 #include "soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h"
 #include "soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h"
+#include "soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.h"

 static void dc_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator,
 		enum dce_version dc_version)
@@ -14,9 +15,11 @@ static void dc_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc
 		dcn401_construct_soc_and_ip_translator(soc_and_ip_translator);
 		break;
 	case DCN_VERSION_4_2:
-	case DCN_VERSION_4_2B:
 		dcn42_construct_soc_and_ip_translator(soc_and_ip_translator);
 		break;
+	case DCN_VERSION_4_2B:
+		dcn42b_construct_soc_and_ip_translator(soc_and_ip_translator);
+		break;
 	default:
 		break;
 	}
--
2.54.0

