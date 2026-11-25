Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70175606A692
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KUmzKQx7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CEE10F609;
	Wed, 25 Nov 2026 06:56:37 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F5510F553
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYLSBjhJHFJuImOZZStPOp4hwluznOY4JmnMvAQXoD+zB4tdGnvXfNmRl0VuzCJ9Ncjigx5sZzoQ2EGq2WSAXUNkn8H9E5n0IDKDZ0sNJvNZgKL9KocboKfx7KBRNDxxkaRvhQfCzRNhp2C4LNbwVblUZiozrF64xPAhbitkzA7PfDNzMMND6+k0WLgDroyxWr7jFmI5a+nh30yfcuapBsHjZwp9Y/AOHX0raO+TFoE0xLBgCLArGg+pCMVBP6Vy7zvuAsQKvHNjSpNLp296TDSimhqUsg78YpqHmdaiYmfRjSeYCAjfG2KCRrPBYC/eHxATXJECryxZSEtNhCtMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryRkVDAII6CnTBkKEh+2GKm9PPdCghS9XYe/gAaWQos=;
 b=EcRQxbCb1NYyFAPib5UhiYQXDgZMGSvsV1Ol44m+zJXpdH+hXq+ITH1mnTvCDEb5L0oDiB3UKOiQuGI7FqHwBbTccT5EQ3dafSEx7wDl9yhk6GsbrJnZZxQCez9NOQdnqxXKojxbgVKsewgR8T6dRPRGtVNLVTvTwEhTIw6+q5U7QjRTObSPD3rYMJfLmuIW0oA6gRkfrNfrg0pkDTQ12kNLnYMuUXH2nwXJiTA680EcmyCQq7n0CuHpEMq91KhHkXVEVoSizN8EwJk0EbTPvwDckV0WXCj8Duvb87gXoc2P34GgqI2lcrTe5N4WV0quqKThLoMJL4ek0jSbeOvnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryRkVDAII6CnTBkKEh+2GKm9PPdCghS9XYe/gAaWQos=;
 b=KUmzKQx7tXXuGH8Yt+yVahRa0FSsTjXiNjiCsMLpJdtobosLDngzcBHgYko/Q3QWJPeoG0daL6gapUJQMGaivTjz02/leP7JswGhepfxN0iRfmBIOJZSLTdknWYW5Y5Dvj8PPUo56PcsJob8deyNQ04SzIFlHEF6nzcJiyWhj2w=
Received: from MW4PR03CA0222.namprd03.prod.outlook.com (2603:10b6:303:b9::17)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 06:56:25 +0000
Received: from EA8PEPF00000006.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::52) by MW4PR03CA0222.outlook.office365.com
 (2603:10b6:303:b9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 06:56:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000006.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:56:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:23 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:23 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:56:14 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kowalski <dominik.kowalski@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 08/27] drm/amd/display: Add DPMS-v2 tx init
Date: Wed, 25 Nov 2026 14:54:57 +0800
Message-ID: <20261125065631.3889665-9-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000006:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd55f50-83cf-4781-0ee9-08df4ac1383b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|6133799003|261009223027099003|3023799007|261102123227099003|56012099006|261026121527099003|10067099003|261022113327099003|11063799006|261022115727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: ykKt4LXMf2UQqOmaz/USvuGKEIUiSyoZz+/6XaJ6TcOfvXaPNdmeCYOaHhWFGSH8IBqfASjVXf1n9tDDOsET3nSHQyqi0Neb4QmVjizMJ0zp3k0GqCcK7em0KTAruEU/rKCbG2Rt9stWbMBjfN9LE/DSKrxribigNGeigAr9+CnpKWoHnLLLVdBI+dsTUuPu8Rd0cbN4j9ydV7iwUcEt7PcBAsjR7rNi72dexiIEQIHNeZIsN35D4PHeCr8hTdp8K8KxOwHNicmUxkM1s62BHRxGzp3NnXlZqxsghS2sPWMdMWyaHMnx55li3PVdIlDzeWnLbHuSHdKRdTRbLHL1IzDPXu9H0mypVZQupoqvLUzvuRiJ+J+avgGbvNRuxNDmfBarmYCU3W9DhQuBWMesHP/wiTdUUw047j2GcTbDXIHSA/BG7jEPt87qfo+l7FP0mD7ORjucgEQgXu4q3XZFZtb5hubbJLI3CHGqQHRgvdlO/teIRZSWipGXCSr7MSrpCDHa+Lq/QS6LC1xU5W0OO3zBaZDvLnkVrsMU9TarLWdGaesUGR5KPq6FErxRn/sxVP14lyXpqtIJzISsZ+3e08grtDSaGacPKiVWDk3phrDNZbCfCwxEbZyhh6JT2nnUvJzRJiXV03+muhfzqw9YJbeId8J2aBwTpho7xb9cW6gWeis9IDx9ciif13uunHwq5CzTg3+TuVAANgPdKEMAhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(261102123227099003)(56012099006)(261026121527099003)(10067099003)(261022113327099003)(11063799006)(261022115727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ryqaZlemNP69v3o31eshOuQJehEnv1LD7cThnwPciew1tCxbrxvUb6e/rq9p5goQynWRyUBy6p468ozs8UnHwjjrd8JIX02GfqdCmR5UI6Bxex/4QUXkTLaY6kmOD/8GN1EsPgoIDKa4hUr2NYQQ5nMO8+oea5NcS3rN5nV36zXUcDKN2CYgOVlAIOVcv9Cj7FP3FUfsDMEZQsayHiDxF9l7W6mhe/dmIma+wgtLz+jYFdiByE6RRvJTIf38T+fhnZIMPpzeNlcIY/CgLVu3KbLBdoW8CQcLsTcmnyiIy3InzSl9Ha0deZTYXwVcmR94IyepENGznF8NQumzyW8YTZ/NAWJ1CV+vaRrCRzkEj2wi6eGhLWuU1k8IN1M1rERruGiXEK/R75ENVJtIXlDJxN+NcXDzz5dvMXtszR3Td3nlzAj0YHak9fA9DTRvDvDk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:56:24.1086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd55f50-83cf-4781-0ee9-08df4ac1383b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000006.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dominik Kowalski <dominik.kowalski@amd.com>

[Why & How]
Add allocation, deallocation and initialization of DPMS-v2 tx structs.
When enable_dpms_v2 is set, link_factory creates a v2 tx; otherwise it
creates a v1 tx, so every link gets a tx. The tx is stored in a new
tx_inst field of dc_link and passed to the dpms_ctx. Link construction
fails if the tx cannot be created.

Cc: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dominik Kowalski <dominik.kowalski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  | 11 +++
 .../drm/amd/display/dc/link/link_factory.c    | 39 ++++++++-
 .../drm/amd/display/dc/link/tx/link_tx_v1.c   | 55 ++++++++++++
 .../drm/amd/display/dc/link/tx/link_tx_v1.h   | 34 ++++++++
 .../drm/amd/display/dc/link/tx/link_tx_v2.c   | 83 +++++++++++++++++++
 .../drm/amd/display/dc/link/tx/link_tx_v2.h   | 38 +++++++++
 7 files changed, 259 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 75d1ede366c7..69d6eed1df41 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1935,6 +1935,7 @@ struct dc_scratch_space {
 
 	struct ddc_service *ddc;
 	struct link_dpms_ctx *dpms_ctx;
+	struct link_tx *tx_inst;
 
 	enum dp_panel_mode panel_mode;
 	bool panel_mode_initialized;
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index ea08f1b1e60e..2d9bbf33ed97 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -70,3 +70,14 @@ AMD_DAL_LINK_PROTOCOLS = $(addprefix $(AMDDALPATH)/dc/link/protocols/, \
 $(LINK_PROTOCOLS))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_LINK_PROTOCOLS)
+
+###############################################################################
+# tx
+###############################################################################
+LINK_TX = link_tx_v1.o
+LINK_TX += link_tx_v2.o
+
+AMD_DAL_LINK_TX = $(addprefix $(AMDDALPATH)/dc/link/tx/, \
+$(LINK_TX))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_LINK_TX)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 1e32f96348b7..e5a5bc70e7d3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -47,6 +47,9 @@
 #include "protocols/link_hpd.h"
 #include "gpio_service_interface.h"
 #include "atomfirmware.h"
+#include "dc/inc/link_tx.h"
+#include "dc/link/tx/link_tx_v1.h"
+#include "dc/link/tx/link_tx_v2.h"
 
 #define DC_LOGGER \
 	dc_ctx->logger
@@ -434,11 +437,18 @@ static struct link_dpms_ctx *link_create_dpms_ctx(struct dc_link *link)
 
 	*ctx = (struct link_dpms_ctx){
 		.link = link,
+		.tx = link->tx_inst,
 	};
 
 	return ctx;
 }
 
+static void link_destroy_tx(struct link_tx *tx)
+{
+	if (tx && tx->funcs && tx->funcs->destroy)
+		tx->funcs->destroy(tx);
+}
+
 static void link_destruct(struct dc_link *link)
 {
 	unsigned int i;
@@ -471,6 +481,9 @@ static void link_destruct(struct dc_link *link)
 
 	if (link->dpms_ctx)
 		link_destroy_dpms_ctx(link->dpms_ctx);
+
+	if (link->tx_inst)
+		link_destroy_tx(link->tx_inst);
 }
 
 static enum channel_id get_ddc_line(struct dc_link *link)
@@ -922,7 +935,11 @@ static bool construct_phy(struct dc_link *link,
 		}
 	}
 
-	if (init_params->dc->config.enable_dpms_v2) {
+	if (!init_params->dc->config.enable_dpms_v2) {
+		link->tx_inst = link_tx_create_v1(link);
+	} else {
+		link->tx_inst = link_tx_create_v2(link);
+
 		link->dpms_ctx = link_create_dpms_ctx(link);
 		if (!link->dpms_ctx) {
 			DC_ERROR("Failed to create dpms_ctx!\n");
@@ -930,6 +947,11 @@ static bool construct_phy(struct dc_link *link,
 		}
 	}
 
+	if (!link->tx_inst) {
+		DC_ERROR("Failed to create tx!\n");
+		goto fail;
+	}
+
 	link->psr_settings.psr_vtotal_control_support = false;
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 	link->replay_settings.config.replay_version = DC_REPLAY_VERSION_UNSUPPORTED;
@@ -952,6 +974,8 @@ static bool construct_phy(struct dc_link *link,
 		link->link_enc->funcs->destroy(&link->link_enc);
 	if (link->dpms_ctx)
 		link_destroy_dpms_ctx(link->dpms_ctx);
+	if (link->tx_inst)
+		link_destroy_tx(link->tx_inst);
 
 	DC_LOG_DC("BIOS object table - %s failed.\n", __func__);
 	return false;
@@ -1006,7 +1030,11 @@ static bool construct_dpia(struct dc_link *link,
 		goto fail;
 	}
 
-	if (init_params->dc->config.enable_dpms_v2) {
+	if (!init_params->dc->config.enable_dpms_v2) {
+		link->tx_inst = link_tx_create_v1(link);
+	} else {
+		link->tx_inst = link_tx_create_v2(link);
+
 		link->dpms_ctx = link_create_dpms_ctx(link);
 		if (!link->dpms_ctx) {
 			DC_ERROR("Failed to create dpms_ctx!\n");
@@ -1014,6 +1042,11 @@ static bool construct_dpia(struct dc_link *link,
 		}
 	}
 
+	if (!link->tx_inst) {
+		DC_ERROR("Failed to create tx!\n");
+		goto fail;
+	}
+
 	/* Set dpia port index : 0 to number of dpia ports */
 	link->ddc_hw_inst = (uint8_t)init_params->connector_index;
 
@@ -1033,6 +1066,8 @@ static bool construct_dpia(struct dc_link *link,
 		link_destroy_ddc_service(&link->ddc);
 	if (link->dpms_ctx)
 		link_destroy_dpms_ctx(link->dpms_ctx);
+	if (link->tx_inst)
+		link_destroy_tx(link->tx_inst);
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.c b/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.c
new file mode 100644
index 000000000000..68312ab50711
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.c
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: MIT */
+/*
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
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dc/link/tx/link_tx_v1.h"
+
+static void link_tx_destroy_v1(struct link_tx *tx)
+{
+	if (!tx)
+		return;
+
+	kfree(tx);
+}
+
+static const struct link_tx_funcs link_tx_funcs_v1 = {
+	.destroy = link_tx_destroy_v1,
+};
+
+struct link_tx *link_tx_create_v1(struct dc_link *link)
+{
+	struct link_tx *tx = kzalloc_obj(*tx);
+
+	if (!tx)
+		return NULL;
+
+	*tx = (struct link_tx){
+		.funcs = &link_tx_funcs_v1,
+		.link = link,
+		.ctx = NULL,
+	};
+
+	return tx;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.h b/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.h
new file mode 100644
index 000000000000..11211f3955cf
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: MIT */
+/*
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
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef LINK_TX_V1_H
+#define LINK_TX_V1_H
+
+#include "dc/inc/link_tx.h"
+
+struct link_tx *link_tx_create_v1(struct dc_link *link);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.c b/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.c
new file mode 100644
index 000000000000..b42704453f89
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.c
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: MIT */
+/*
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
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dc/link/tx/link_tx_v2.h"
+
+static void link_tx_v2_ctx_destroy(struct link_tx_v2_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	kfree(ctx);
+}
+
+static struct link_tx_v2_ctx *link_tx_v2_ctx_create(void)
+{
+	struct link_tx_v2_ctx *ctx = kzalloc_obj(*ctx);
+
+	if (!ctx)
+		return NULL;
+
+	*ctx = (struct link_tx_v2_ctx){
+		.dummy = 0,
+	};
+
+	return ctx;
+}
+
+static void link_tx_destroy_v2(struct link_tx *tx)
+{
+	if (!tx)
+		return;
+
+	link_tx_v2_ctx_destroy(tx->ctx);
+	kfree(tx);
+}
+
+static const struct link_tx_funcs link_tx_funcs_v2 = {
+	.destroy = link_tx_destroy_v2,
+};
+
+struct link_tx *link_tx_create_v2(struct dc_link *link)
+{
+	struct link_tx *tx = kzalloc_obj(*tx);
+
+	if (!tx)
+		return NULL;
+
+	*tx = (struct link_tx){
+		.funcs = &link_tx_funcs_v2,
+		.link = link,
+		.ctx = link_tx_v2_ctx_create(),
+	};
+
+	if (!tx->ctx) {
+		link_tx_destroy_v2(tx);
+		return NULL;
+	}
+
+	return tx;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.h b/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.h
new file mode 100644
index 000000000000..151a6173b2a7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: MIT */
+/*
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
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef LINK_TX_V2_H
+#define LINK_TX_V2_H
+
+#include "dc/inc/link_tx.h"
+
+struct link_tx_v2_ctx {
+	int dummy;
+};
+
+struct link_tx *link_tx_create_v2(struct dc_link *link);
+
+#endif
-- 
2.43.0

