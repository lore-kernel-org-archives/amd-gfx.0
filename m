Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB3606A32F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ztlk35VA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4D210F800;
	Tue, 17 Nov 2026 17:12:48 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8526210F813
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ky5WRm7xH1Z7NfSwuZdBTL+OFmdnnwcfLZ6/Tib89nw8CUFcQ7Vfu+D6By2wVD1Ew2BgHmyIfKUoWQ7jMFB2qova6aqbgsrZPEvJJinSmSD93JLcmd9AkVIqjKz26jDVf7wJ77tIOoRlkQMGZfB2R7QddYrbnwfn25ryQ3Y8YCL7u8HTspDdVdskacItBN/ZAgk561XGTBrk5de3698EXVNTspsZQoDL2IexU1+w5SMDCPBdKOEPO6uVFE6uQysk9tRUPjTgxgna0TS89LcyYIt1HwqK9oTwc6Q8KVomFeA+GOqjOHJY1BGtV8lKohtt0SC1Ic+agLP/lOLSybtG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wNB5/vLvbrdhws/oE5131toCtzoXPgriqKb855u2kg=;
 b=tjra0RX2Y3fpfL2G2jBy7S5gsIrmnu4vm/4Gtgj/MJTXzDHW26bDqFTgdKLYMxXHxH9ygpkrAyZJqu275ovaTSWqTsAv2Srn/ZuOB25ljfAlUzS+mWYpyPfhcSbTuVFWYdrR/OIAzI2q5FYD3erICjhbBovlcBEpUeEr9OO1L6yJrgqMWHCRL9BwEMpeU3GYCewyRKLtRaKus+XMEXzALUcaHCdi3zFwckAn+3VMVI1647catMO2HCXEiSrE988jq1sWA/h6EFHb4ww8thyMOe9hM9wrwhFisS6StJzirdvm0XKolFifGQD4Nihl3xbUngMl41eHbE8shryBllKitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wNB5/vLvbrdhws/oE5131toCtzoXPgriqKb855u2kg=;
 b=Ztlk35VAjiy3/QmD+kZFxuuRrAgWGc9N0WRxecW0Cwx+y+/bnVO/+GoeA+Jmwq6/9IoufAzETu8NxtMve+iuw7PWODa3FTJzvPNX2Cs/Gr0XZB3W2hN79B50BYk0pCkcMbbJsvleKbUTV3LdIJXhXczfBcAcxFL3+/7TMbpEkvI=
Received: from DS2PEPF00004556.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::510) by PH7PR12MB9151.namprd12.prod.outlook.com
 (2603:10b6:510:2e9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:12:25 +0000
Received: from PH3PEPF0005961C.namprd05.prod.outlook.com
 (2603:10b6:518:1::24a) by DS2PEPF00004556.outlook.office365.com
 (2603:10b6:f:fc00::510) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.1 via Frontend Transport; Tue, 17
 Nov 2026 17:12:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961C.mail.protection.outlook.com (10.167.243.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 17:12:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:24 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:24 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:12:15 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kowalski <dominik.kowalski@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 02/33] drm/amd/display: Rename DPMS to DPMS_v1
Date: Tue, 17 Nov 2026 05:50:39 +0800
Message-ID: <20261116215641.2800595-3-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961C:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f53724-c5f4-4a1a-06f8-08df44cdf35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|22082099003|18002099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|10067099003|261022075727099003|261022113327099003|261022105027099003|261026140227099003|261021123027099003|261021121427099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 1guIfq6jJ+QLsp3fJhJIuhsDwP25JDdQL2zCYxKccnZg5i759mhXjViltnyMLx3wwwZDmI/TiH+7WHoF3G7qM1adKiZBobqKlx+J7CAi0z8osDLsovOVZjgEVErp38szQLDebnWokFv2NxWiXKR9MlDG4yoXDT1dw21x06590DecNsTCSKrR4cKHjZFmyl+Lt3g/FC5oaBXQSK1q3OM4XMsVb3CqUpsSF2VTMqDJi4Gw40/zfYX8ockiUl/WPi/t9lEFDi5sp5PBy7bb+fsbw67ODXgr3NdbXaCz7kLPyVXPcURIalA7cUL0fI3T+3lUj3IAEE2Z3OzgT8bnDZpYXbd7mX1PkbDKvu9bvhtt5JXWS5jUiEsRuncUEztWOWFd1X0SasHJrDuVwaIEshhqD5Qg4RXOWIMolxO0ATCG+XMuFejsapFtiCMy8wEkRMU7Hm6TmEFN3JWZeO/FkD+fYbzcS3BINQqPGXlI3ks6nrLMq4y3CkvYFAHrd1HVX0HTI841DDZCtD8j37+8c6SAdOVqVIdZW1sRVjXA6ITK8d3QcYMH0ly+byq9ImJv/24nr72Ar2CoauFI1NUgD4eR1Sd+Smqj7pdLBqoo2b7/m4uWbwHRHu4kFL42DbulO5hUYWsBtDjiUNxOKyt2sdgvwoRqBdRLg8bL74ceU7dWG0ArKdBDI2YZjz7t7JpFKCi0Y8prDSIKdP2FOKszylKHsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(10067099003)(261022075727099003)(261022113327099003)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261026121527099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UtwQDh3OqkvZ58RpLtoWVpNjIZFup+YHZDy/N1ynNxD8M8XOJh2SqIC/ebVmyFi7JlZvdLcq0QnZp/fhr/5t7udiuCpGACMU/2TGECuRWJAsydxdSuI15pmw+yDRyG+/HOF96Vr21UIgzgtyQp5w/WzQCU47wAK+jTI30PuaaT1FJvvGg/ejQK7UMqMrB40V1/2X6pWJixXeR5xVTF1Xaqhrq4g1lzHHfNv87TLoes+LfxKjzM+wELA65yUVXzDSMa9BtvmM20oJRPkGR68OBAC7GsbJaSg5DSKVZe2yBuGa+N2j9lgk8JnlIr20idqL+wSHhOOrYAEE8iBKBKrWsOypmtoiYEZ2D4NOSg0QcMXpuatEfLQiZx66YbH2GTX62/On8Jg6PVLeOUAWKjFX/nn+8j8I4bMTq7VtiyWnEkJr4rU9TqvpU7S+vDDbmhqF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:12:25.0561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f53724-c5f4-4a1a-06f8-08df44cdf35e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dominik Kowalski <dominik.kowalski@amd.com>

[Why]
Working on v2 of DPMS link protocol implementation, renaming
existing version to v1 for consistency.

[How]
* Rename files link_dpms.{c,h} to link_dpms_v1.{c,h}
* Rename functions link_dpms_set_{on,off} accordingly
* Replace direct calls to those functions with link_srv vtable

Cc: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dominik Kowalski <dominik.kowalski@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/Makefile           |  2 +-
 .../drm/amd/display/dc/link/accessories/link_dp_cts.c  |  4 ++--
 drivers/gpu/drm/amd/display/dc/link/link_detection.c   |  2 +-
 .../display/dc/link/{link_dpms.c => link_dpms_v1.c}    |  6 +++---
 .../display/dc/link/{link_dpms.h => link_dpms_v1.h}    | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/link/link_factory.c     |  6 +++---
 .../display/dc/link/protocols/link_dp_irq_handler.c    |  6 +++---
 .../drm/amd/display/dc/link/protocols/link_hdmi_frl.c  |  4 ++--
 8 files changed, 20 insertions(+), 20 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/link/{link_dpms.c => link_dpms_v1.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/link/{link_dpms.h => link_dpms_v1.h} (92%)

diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index f558a20eceaa..0eb433b5d822 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -23,7 +23,7 @@
 # It abstracts the control and status of back end pipe such as DIO, HPO, DPIA,
 # PHY, HPD, DDC and etc).
 
-LINK = link_detection.o link_dpms.o link_factory.o link_resource.o \
+LINK = link_detection.o link_dpms_v1.o link_factory.o link_resource.o \
 link_validation.o
 
 AMD_DAL_LINK = $(addprefix $(AMDDALPATH)/dc/link/, \
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 83f676a49fd1..f316337cee1b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -29,7 +29,7 @@
 #include "link/protocols/link_dp_phy.h"
 #include "link/protocols/link_dp_training_fixed_vs_pe_retimer.h"
 #include "link/protocols/link_dp_capability.h"
-#include "link/link_dpms.h"
+#include "link/link_dpms_v1.h"
 #include "resource.h"
 #include "dm_helpers.h"
 #include "dc_dmub_srv.h"
@@ -91,7 +91,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	link_get_master_pipes_with_dpms_on(link, state, &count, pipes);
 
 	for (i = 0; i < count; i++) {
-		link_set_dpms_off(pipes[i]);
+		link->dc->link_srv->set_dpms_off(pipes[i]);
 		pipes[i]->link_config.dp_link_settings = *link_setting;
 		update_dp_encoder_resources_for_test_harness(
 				link->dc,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 5b257f003f13..9bd24b3e4291 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -30,7 +30,7 @@
  * directly from connected receivers.
  */
 
-#include "link_dpms.h"
+#include "link_dpms_v1.h"
 #include "link_detection.h"
 #include "link_hwss.h"
 #include "protocols/link_edp_panel_control.h"
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/link/link_dpms.c
rename to drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
index 75e232ebffe8..ae94a0a2b9da 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
@@ -35,7 +35,7 @@
  * boundary between link and stream is not clearly defined.
  */
 
-#include "link_dpms.h"
+#include "link_dpms_v1.h"
 #include "link_hwss.h"
 #include "link_validation.h"
 #include "accessories/link_dp_trace.h"
@@ -2403,7 +2403,7 @@ static struct vpg *get_vpg(struct pipe_ctx *pipe_ctx)
 		return pipe_ctx->stream_res.stream_enc->vpg;
 }
 
-enum dc_status link_set_dpms_off(struct pipe_ctx *pipe_ctx)
+enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 {
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 	struct dc_stream_state *stream = pipe_ctx->stream;
@@ -2794,7 +2794,7 @@ static enum dc_status link_set_dpms_on_post_enable_link(
 	return DC_DPMS_SUCCESS;
 }
 
-enum dc_status link_set_dpms_on(
+enum dc_status link_set_dpms_on_v1(
 		struct dc_state *state,
 		struct pipe_ctx *pipe_ctx
 )
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.h b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.h
similarity index 92%
rename from drivers/gpu/drm/amd/display/dc/link/link_dpms.h
rename to drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.h
index 6559bc04d90e..b170c9a8622d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.h
@@ -23,14 +23,14 @@
  *
  */
 
-#ifndef __DC_LINK_DPMS_H__
-#define __DC_LINK_DPMS_H__
+#ifndef DC_LINK_DPMS_V1_H
+#define DC_LINK_DPMS_V1_H
 
 #include "link_service.h"
-enum dc_status link_set_dpms_on(
+enum dc_status link_set_dpms_on_v1(
 		struct dc_state *state,
 		struct pipe_ctx *pipe_ctx);
-enum dc_status link_set_dpms_off(struct pipe_ctx *pipe_ctx);
+enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx);
 void link_resume(struct dc_link *link);
 void link_blank_all_dp_displays(struct dc *dc);
 void link_blank_all_edp_displays(struct dc *dc);
@@ -51,4 +51,4 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool link_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
 bool link_update_dsc_config(struct pipe_ctx *pipe_ctx);
 void link_wait_for_unlocked(struct dc_link *link);
-#endif /* __DC_LINK_DPMS_H__ */
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 3b192c539f8b..7bf1364659ea 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -30,7 +30,7 @@
 #include "link_detection.h"
 #include "link_resource.h"
 #include "link_validation.h"
-#include "link_dpms.h"
+#include "link_dpms_v1.h"
 #include "accessories/link_dp_cts.h"
 #include "accessories/link_dp_trace.h"
 #include "protocols/link_ddc.h"
@@ -113,8 +113,8 @@ static void construct_link_service_validation(struct link_service *link_srv)
  */
 static void construct_link_service_dpms(struct link_service *link_srv)
 {
-	link_srv->set_dpms_on = link_set_dpms_on;
-	link_srv->set_dpms_off = link_set_dpms_off;
+	link_srv->set_dpms_on = link_set_dpms_on_v1;
+	link_srv->set_dpms_off = link_set_dpms_off_v1;
 	link_srv->resume = link_resume;
 	link_srv->blank_all_dp_displays = link_blank_all_dp_displays;
 	link_srv->blank_all_edp_displays = link_blank_all_edp_displays;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 59f9150edf30..154595dcb618 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -36,7 +36,7 @@
 #include "link_edp_panel_control.h"
 #include "link_dp_panel_replay.h"
 #include "link/accessories/link_dp_trace.h"
-#include "link/link_dpms.h"
+#include "link/link_dpms_v1.h"
 #include "dm_helpers.h"
 #include "link_dp_dpia_bw.h"
 
@@ -332,7 +332,7 @@ void dp_handle_link_loss(struct dc_link *link)
 	link_get_master_pipes_with_dpms_on(link, state, &count, pipes);
 
 	for (i = 0; i < count; i++)
-		link_set_dpms_off(pipes[i]);
+		link->dc->link_srv->set_dpms_off(pipes[i]);
 
 	for (i = count - 1; i >= 0; i--) {
 		// Always use max settings here for DP 1.4a LL Compliance CTS
@@ -344,7 +344,7 @@ void dp_handle_link_loss(struct dc_link *link)
 			pipes[i]->link_config.dp_link_settings.link_spread =
 					link->verified_link_cap.link_spread;
 		}
-		link_set_dpms_on(link->dc->current_state, pipes[i]);
+		link->dc->link_srv->set_dpms_on(link->dc->current_state, pipes[i]);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 3f687603a70c..2eaa830662b0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -36,7 +36,7 @@
  */
 #include "link_hdmi_frl.h"
 #include "link_ddc.h"
-#include "link/link_dpms.h"
+#include "link/link_dpms_v1.h"
 #include "link/link_validation.h"
 #include "resource.h"
 #include "dccg.h"
@@ -1040,7 +1040,7 @@ void hdmi_frl_set_preferred_link_settings(struct dc *dc,
 	link_stream->link->frl_verified_link_cap = *link_setting;
 
 	while (link_stat != LINK_RESULT_SUCCESS && link_stat != LINK_RESULT_NO_TIMEOUT) {
-		link_set_dpms_off(pipe);
+		link->dc->link_srv->set_dpms_off(pipe);
 		/* For DCN3.0, can also have 4:1 combine mode.
 		 * TODO: Add function get_odm_combine_mode that has different
 		 *       implementation for DCN2/DCN3AG and DCN3.0
-- 
2.43.0

