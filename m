Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEDECC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5318610E7AE;
	Tue, 13 Oct 2026 11:17:09 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E14A310E7B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdCynG2GkF4QW7YKrTQoeHONUsN+SDaqW1VM2cHFDQCTU9Mkb03NVFhOVNisz0rrbDSsbruMzIp5nJO7cjpqsRBGLgoPkTxJDR0uPPH4tQ5J6dUA1SDY8FR+0LBSB+JlmjGsag0fwHjXkhox17iqPOAPSTuxl7NH624R5kts1HsrVkU+vTM40dVAECqLYrhetWT8p+HDp5vyeF5bJTRMCgMLs6lcJo9hpXF+M2EZ9wh404iCqxDWHpE63o+e5GaRwL0i4tfqFEzuSBUooUS3Kb/O8frOyH3q4hrPUFJNI+d4O8QnrKFUlL084pKpjyRO1JwhQRfH09uN6JgjEWNQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxLCHKBRhCe9vCruE6n30JUkwxeqFysHtV8NNRYomQM=;
 b=RM89F6m7ymZJc5o8R3KhJPUlmuuoXwk0Pyn0u/PXWO5pZ+AAd7VouLxO4uacxcbSJ9FBeVClVXg/lWrXZS35X8kUrA+9fYw4HjG5PhyXTVsoKRBqiOEqHV2SrLopDwIC18SpOLgkrOzUMzsEWzBHSrtaC5AxXzH7vRyK025dUS1I6E0NE2jHxIgKUl5C/PXFTdNO/86ncqkskS+qz01hzJgaoU47XeuA0radSk8PryJyYYK4RAHIkdP4SQAM4le6bqX9naON88Ul6HL/7gGdYPYzRH9qSXgyFwerjHspn192QVhewaxPWAJfujV1f6NhqBFL1OzSxeCkHV2gHOy/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxLCHKBRhCe9vCruE6n30JUkwxeqFysHtV8NNRYomQM=;
 b=dMOtgHTbXl9sWKBTxHTonRu+qWyk0/a2IhnwaGKMkUQJuKw+sOuX05iq+Xis+SX+sYSCPkhf4YYT5bWaJOpCBl8+uMBGc98CIwWhlKVIdSNMt80Ro+9ejFT91nC0nhRCYPMh+ZcC7vCuwNaETnPwkWblx5CAUPA2dm4QSJa5RvU=
Received: from SJ0PR13CA0184.namprd13.prod.outlook.com (2603:10b6:a03:2c3::9)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:16:56 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::24) by SJ0PR13CA0184.outlook.office365.com
 (2603:10b6:a03:2c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 11:16:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:16:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:16:36 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:16:27 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Chris Park
 <chris.park@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 05/30] drm/amd/display: use dmub to notify pme
Date: Tue, 13 Oct 2026 19:07:52 +0800
Message-ID: <20261013111616.2267344-6-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfedced-7a83-4aaf-0a3d-08df291b7de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|3023799007|261009223027099003|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: U3A7R6g/qZdcdP+fgxr9oGgJK0Alys5fpcWu6S0fUZdIC7dsdQZRkiR4AApa8i9oHa/59j+W5z4H229axyYT4FzcYAJ/zA7RSpqRZd5L46VzeWdi9/KOcwfNUrIeqvx8DQvLxn9ZuRaeDZS06wNj1+k8Y91YuOTdwXxVxq4hCzW0zPIJvnhtL8W7yPdgXPvQDb82L9I2enmG0vCcpvqCpLoQxoIjr3ux2qAS+RYbcnWGZR+fiwCC0x8XiDwdlBtmuRsFAjVkCw5ycb3vaCi9z5IIz5CtVAEu1Vf+FroAamMQQ6g6CS1XD/wQUfM3YWwaQdqqlXQd8W4/EsensOfxQPYKB5aV6/8EXK69+O7DAqzIcKC+ryCQv38Opg4onO47/b6YoC0J2Ob9lcI26KdRh6pPi4YM0YJq5og6mWiSjXbXi2pLN/eEBcteRXNmzUdcGckUhpxy3q9hVrUhLP0mY9pyyO1zM3esI74tHvSRcpqCLlV8iw8QqSCTkApjl4NsVjuJgHsz2Jp7KLDyYNWbgM2isVFkpTh8XXx06S/gH+gABVO+nWSV7sypmbNkTHmhU3otqXmNaWZOdNL1Y7mVKyV3Zhx+gMPPYl+4QaYF2P5UITWeOtECURlYYii74ctDukV2rqFdswAlgUkVYZxVo4T6kI1oX91t0bYJHskIGAZmtzoMj4a2PeCqD769kq/k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(3023799007)(261009223027099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sdmlkEbkP58z5n71iPwxKZwrrlu1Ud/psY0VCWONmAO2oO6UHIlqIbxW10FfuXxtkEuTWPfMCS4O7IVh+df3hB10TM+Ey9ijTkta3AHPD+7zM9I/F4xcigP582s73wPbRYDUYcNHqXxn8mo5oGt+cP/5kIcfMHxnX9yFRy4vwn0KBn44+PyTLbnd/LhsRn6SH6jbKY3/j7d6daNainJdCAjRglKMVFECpLES3Mt2PqXydKQ4dZ5LLSrffDT7jAlhNDCvv4lok2+KSWTY115OeXfLgYH3kOGrP16bS9Kq1V+b0pjK7btc1Kdc0scf1Oau/+eHYWiYE7fZDW6XDE9XxVx/K6jgZqbYIu0Dt50x/kk1VTxhSv0lf4jfSy55kgGlmJdijpPmEU3nMBEgZL6yA345myllujJcHBuTbAo9SxqujN9/vOARCJhThp0+EdWp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:16:56.1311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfedced-7a83-4aaf-0a3d-08df291b7de0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
Use dmub to notify pme instead of pmfw.
This is for asic which has no pmfw-driver-if interface support.

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h             |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 17 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h    | 11 +++++++++++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c   | 15 +++++++++++----
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9cc90c406d86..91d4a8ec7a94 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1331,6 +1331,7 @@ struct dc_debug_options {
 	uint8_t iommu_mismatch_temp_wka;
 	bool disable_dynamic_expansion_for_test_pattern;
 	bool psr_phy_force_phy_power_down_up_level_2;
+	bool dmub_send_az_pme_restore;
 	uint32_t dml21_custom_derate_num_dpms;
 	uint32_t dml21_custom_derate_at_dpm[DML2_MAX_NUM_DPM_LVL];
 	bool override_utm_client_qc_profile;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0485ff5217f1..f1a0225bbf84 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2606,3 +2606,20 @@ void dc_dmub_srv_hubbub_set_riommu_pctrl(const struct dc_context *ctx, uint32_t
 
 	dc_wake_and_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
+
+void dc_dmub_srv_nbif_az_pme_restore(const struct dc_context *ctx, uint32_t az_inst)
+{
+	union dmub_rb_cmd cmd;
+
+	az_inst =  (az_inst < 0x7) ? az_inst : 0; //dcnhw max aud_end point is 7
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.nbif_az_pme_restore.header.type = DMUB_CMD__NBIF_AZ_PME_RESTORE;
+	cmd.nbif_az_pme_restore.header.payload_bytes = sizeof(cmd.nbif_az_pme_restore.data);
+
+	cmd.nbif_az_pme_restore.data.az_inst = az_inst & 0xF;
+
+	/* AZ must be out of D3 before the endpoint is accessed, so wait for completion */
+	dc_wake_and_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 8056824d90e0..684b66dc9771 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -476,4 +476,15 @@ bool dc_dmub_srv_panel_polarity_get_polarity(struct dc_dmub_srv *dc_dmub_srv, ui
  */
 void dc_dmub_srv_hubbub_set_riommu_pctrl(const struct dc_context *ctx, uint32_t value);
 
+/**
+ * dc_dmub_srv_nbif_az_pme_restore() - Wake the AZ endpoint from D3 via DMCUB.
+ *
+ * Replaces the clk_mgr PME workaround on DCN4_2, where the NBIF AZ PME restore
+ * is performed by DMCUB on the driver's behalf. No-op on other ASICs.
+ *
+ * @ctx: dc context
+ * @az_inst: Azalia codec endpoint instance
+ */
+void dc_dmub_srv_nbif_az_pme_restore(const struct dc_context *ctx, uint32_t az_inst);
+
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 1abb28504aec..ed6c2096272c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -60,6 +60,7 @@
 #include "dpcd_defs.h"
 #include "dsc.h"
 #include "dc_dp_types.h"
+#include "dc_dmub_srv.h"
 /* include DCE11 register header files */
 #include "dce/dce_11_0_d.h"
 #include "dce/dce_11_0_sh_mask.h"
@@ -1146,7 +1147,10 @@ void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
 			if (dc->current_state->res_ctx.pipe_ctx[i].stream_res.audio != NULL)
 				num_audio++;
 		}
-		if (num_audio >= 1 && clk_mgr->funcs->enable_pme_wa) {
+		if (dc->debug.dmub_send_az_pme_restore) {
+			/*wake AZ from D3 first before access az endpoint*/
+			dc_dmub_srv_nbif_az_pme_restore(dc->ctx, pipe_ctx->stream_res.audio->inst);
+		} else if (num_audio >= 1 && clk_mgr->funcs->enable_pme_wa) {
 			/*wake AZ from D3 first before access az endpoint*/
 			clk_mgr->funcs->enable_pme_wa(clk_mgr);
 		}
@@ -1184,10 +1188,13 @@ void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx)
 	if (pipe_ctx->stream_res.audio) {
 		pipe_ctx->stream_res.audio->enabled = false;
 
-		if (clk_mgr->funcs->enable_pme_wa)
-			/*this is the first audio. apply the PME w/a in order to wake AZ from D3*/
+		if (dc->debug.dmub_send_az_pme_restore) {
+			/*wake AZ from D3 first before access az endpoint*/
+			dc_dmub_srv_nbif_az_pme_restore(dc->ctx, pipe_ctx->stream_res.audio->inst);
+		} else if (clk_mgr->funcs->enable_pme_wa) {
+			/*wake AZ from D3 first before access az endpoint*/
 			clk_mgr->funcs->enable_pme_wa(clk_mgr);
-
+		}
 		/* TODO: notify audio driver for if audio modes list changed
 		 * add audio mode list change flag */
 		/* dal_audio_disable_azalia_audio_jack_presence(stream->audio,
-- 
2.43.0

