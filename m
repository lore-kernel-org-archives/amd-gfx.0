Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE81CD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F9910F60E;
	Thu, 28 Mar 2024 19:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fJ4qMIbn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFDB10E652
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKFBW86hU4vnLAO95w3r5XW2xtSgxpxmZQqcKZEsMCTCRQ+i/SEiQHBdO2WunuZ9yWPWZghkLw4XfLJQvhXOXfhEsaBDLkNTL2BXpC5FwZsDAuIU2hweQcsQI9qhbyI6Pe2RY7fUiYGXZNE00z7MadJf8o3/9ziCVgsza8op2blUNRsL5Flf7gBBmdRurRGQ2MOFG8lRj/sk5q7BfGKmLj7wBl9AX7Ao82PobYHCMZ23tuO7Gk+6v4PN7cFK2WiVGR0SRZkZEa86V+0h7ohefa7FEMJp4h+FJItvlcoSormMtCZLt+QH4q/UsqXMrXyabmgiypxTAGg7ndWVQXB3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P49iRjeysFNvHAj+I3PubM/uiGLX496n71a32k9jKu0=;
 b=TX1A0sGNyiRIzFFMlN2wrLXaoHwHaovu36Pl3+HNICA+TqoQcU+w/vfbuqQ1WKN8NJzHl31k6oGQj4ON1c2qFPIg8eUZNntzJYqHtAWtZy/6sC7Sbbgm7PMBN6KtIN2UDHQkW4dQPakLS5h0vblgf4ttJ+MLSXLI6btafMZLIlZras1ojseVxfKrDu1tEosHdHEk2IbEEPxF03kZK1b1iPIY0DsfaB23dy9P0YOGR1s5DoICT+yl5Gh+5bmL4NyF2TjFl9caWggffV1LW2oa8I8PIar2WceG0I8FXcuiGXHDMfnsPxCyWAIneQPagwDf2raKSwBbokUfRevR1qktsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P49iRjeysFNvHAj+I3PubM/uiGLX496n71a32k9jKu0=;
 b=fJ4qMIbnacdHIiecJ3VERVWYPOdLEeRvr3hr7IDceNL9VW+tCZ9gVl/JxdaToceY1ZgWnJrOpiI/JcON+CUM6E7chBojaYxX8feMtACswIHyxcV96FYaX+tzl09iw6uiD+PxrMweApjMJU6LxNSvoDajEuf6hp+qd4oVWqiqPHE=
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:51:39 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::d2) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:36 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:36 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 10/43] drm/amd/display: Add dmub additional interface support
 for FAMS
Date: Thu, 28 Mar 2024 15:50:14 -0400
Message-ID: <20240328195047.2843715-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ede0cb-f23f-4750-a34f-08dc4f607b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: de8sQsYHOhCyr0WR3MAWbkJ3wIKS4uls76QbVjnh0+zccqByRDWaFkszkrgdir37e4QsaTMaEz1w1kbMYmag9IJrfuiFdRhZjP0YRYtZSgSGAAoKMikMHJ5dkxeGsHaUhcle/Ko9EY2RoEj647aiPolfE+5Gr2gIVmQpgqBN26wrrXFpVMPNw05lDA7zacBX6Rc0i0dPRUZ4XvLHGp/xnDjiLLk0BBRAZClzzvhliXbZwQkp6maNzdM9gUNRe5JgcNotMEh+vgD9Q5P1L16Hv7lc7+dD6GUjXSr80owZ7CoOERkrF63cV+U5xvR1OdjSGH8K8oYt+BCJtghWyo6+gSzKm6qV8gDPJXQj8u5N2v89yZ+QRWUS2MJc5cClW37Jvo1ynZfYVtRpU3LrwiMcqFj6z0JhL5I2FvBX0tpU9DLpxKkatxc2aqB+jhxi0OqoUdHcqJXX0LrEEVRkPSM/Y52enbbDmFQF/JG5QvGigbYzpKg2LmksAPz2O55YydU0IZZiBVy7i37qHTCymIrx61M4ZAZ8lsTsjoCUL4yXMaQ6yl+wjW8c6s4bfxGsuX6vcqBY5palGEDNiF4AXMuHvlsD6AKmaXtX1Xjlgb3oDa6lEsgRSA2KOGZRocQoUQSW5xbs8tLTfQkw/skk9IvFzzcybqCxiEFdOuH+DrR9oZx9qw8EUYxJjh1bI7V/67pk6ef1E3fzlTQIoCDkb0R+Ci0Nn+9lA4u4Vqt4AgqRIYuG6SpPQkA5hYbm5MY5zYjo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:38.3898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ede0cb-f23f-4750-a34f-08dc4f607b73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Update dmub and driver interface for future FAMS revisions.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h         | 6 +++++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index af3a26c2656b..1f3ddee1ec1b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -799,7 +799,7 @@ void dcn30_init_hw(struct dc *dc)
 	// Get DMCUB capabilities
 	dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv);
 	dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
-	dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
+	dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
 }
 
 void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index a760f0c6fe98..9ab475a87545 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -273,7 +273,7 @@ void dcn31_init_hw(struct dc *dc)
 	// Get DMCUB capabilities
 	dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv);
 	dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
-	dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
+	dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
 }
 
 void dcn31_dsc_pg_control(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 0f522f8a7228..9aea4a088652 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -953,7 +953,7 @@ void dcn32_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 		dc->caps.dmub_caps.subvp_psr = dc->ctx->dmub_srv->dmub->feature_caps.subvp_psr_support;
 		dc->caps.dmub_caps.gecc_enable = dc->ctx->dmub_srv->dmub->feature_caps.gecc_enable;
-		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
+		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
 
 		if (dc->ctx->dmub_srv->dmub->fw_version <
 		    DMUB_FW_VERSION(7, 0, 35)) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 9499295f4582..c2275a8b4ecc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -349,7 +349,7 @@ void dcn35_init_hw(struct dc *dc)
 	if (dc->ctx->dmub_srv) {
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
-		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
+		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
 	}
 
 	if (dc->res_pool->pg_cntl) {
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3bd9911b6f3a..66eff38b9e80 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -97,6 +97,9 @@
 /* Maximum number of planes on any ASIC. */
 #define DMUB_MAX_PLANES 6
 
+/* Maximum number of phantom planes on any ASIC */
+#define DMUB_MAX_PHANTOM_PLANES (DMUB_MAX_PLANES) / 2
+
 /* Trace buffer offset for entry */
 #define TRACE_BUFFER_ENTRY_OFFSET  16
 
@@ -466,7 +469,7 @@ struct dmub_feature_caps {
 	 * Max PSR version supported by FW.
 	 */
 	uint8_t psr;
-	uint8_t fw_assisted_mclk_switch;
+	uint8_t fw_assisted_mclk_switch_ver;
 	uint8_t reserved[4];
 	uint8_t subvp_psr_support;
 	uint8_t gecc_enable;
@@ -4667,6 +4670,7 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__PSP_ASSR_ENABLE command.
 	 */
 	struct dmub_rb_cmd_assr_enable assr_enable;
+
 };
 
 /**
-- 
2.34.1

