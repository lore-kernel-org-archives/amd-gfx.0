Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C17C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA1860FBF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EA1860FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6586E517;
	Fri, 13 Aug 2021 06:35:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063F56E517
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeI7lFvWZkHGiSS9KWwuGWKi4jAAbInSlvfwoG/JbtifYVzCufC7g49D/PcF+3DBes/ofIKfOhl788UAc8n27FBEvUC1GC4Z5GE5dpHPHtmFMyObjfKkORibz6rcMzpz+fiVGPAfxjUV9lIr+ZMRaZzj4A/sazWQfcBg4DAW+c4hfWB02mwceryVtkMZoyt3LEP70qmHuwkVKvXJ8ajE+fLIdZp9VEduZt9ZttaZwsLtmcwGK5WdEg8/qbW6ULPjkfWEf75cJZyN0/rbAIDqDlooj/Y2q+j+S+kI9cP6AGDq5JKX0nLqWndQtBlaf43svXFZunsuDMtQrrnTIZkoyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnrQlETfYdyh9hHpis97hGEr4uOBnNX1G63PSpd7wMI=;
 b=LrrluETrBSV7w9zySrMfkEIdTujqDiugfI4rUXmscyDHSWMm3iX0bdZjpAauf6ufq96m8rD+GvNy12/FS/J2VO01ry2lYTJNgS0ljapcvzZufsKmvU+OGAbThDnu4vzMpGlb6V8qNV0ilPxvBX4cgaZjj7LMGtqpZXrmcBDet2cikEM5DD060WcLx4+kN/hCtJqrLmKKxzW3DZ2pFUZ4RYJijXjdvk+BgElO8aIAPWsROxrOKB5Bl1Eyhsrp7sLpGLDH2sQHuq95an3IFhdzzO0t2nHWV/p5fqy5tKGoC62+v4dGlPvTRzlXvFIauqxc1ZWcMlAzGT7lhV5eFVJG9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnrQlETfYdyh9hHpis97hGEr4uOBnNX1G63PSpd7wMI=;
 b=X8f1ZL8wT+hTCCZn6yISTZcMEVh1rIUcT0t3+Ghz5ZHHzTOZ3lvbBN4jHUppHT0/4BJkuWvcCFlWziFPcYZNOeS4KItrEP1MHjL2WST8+7sZ4IBKwK3vD+vTiB2G4Vwsh5zicfl5C0GdE0cZCSZnii/41vQNKCpZvgSfylL3TNs=
Received: from DM3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:0:50::26) by
 CH2PR12MB4821.namprd12.prod.outlook.com (2603:10b6:610:c::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14; Fri, 13 Aug 2021 06:35:42 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::6a) by DM3PR03CA0016.outlook.office365.com
 (2603:10b6:0:50::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Fri, 13 Aug 2021 06:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 06:35:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:35:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 23:35:40 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:35:38 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Jake Wang <haonan.wang2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Wayne Lin <wayne.lin@amd.com>
Subject: [PATCH 4/7] drm/amd/display: Ensure DCN save after VM setup
Date: Fri, 13 Aug 2021 14:34:59 +0800
Message-ID: <20210813063502.3106309-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813063502.3106309-1-Wayne.Lin@amd.com>
References: <20210813063502.3106309-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c28c9ca-ce82-409a-a00c-08d95e24927c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4821:
X-Microsoft-Antispam-PRVS: <CH2PR12MB482124E7ADFBEE8A7680E926FCFA9@CH2PR12MB4821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sLqj4nSfA9W9PYOVmjObJagN7wh0ZtHLR4juB+TEN8druMvbmxrFW8IGpgwpABpaQkmCeJYxftGxnJcp7mcyYfAEA0oXR2Bjcip/a/NeeW02IAANwqgQMOUDwBYMnn8Hb2wE+rSfFbM3tCTkHef3U0gv3O7Y/02WzUQVl+id4AJBM+8h4BXU3eFZhxSivS83uwHINnnEROa3g3ek5rozj0F7ywf0vPU/49sPskNGh5F9bS31j/n133E9KGKEtc9MjpSsMK7HCQ5Pu0YQvw0Ed7qMIcpCUPldse1Wh/Y2iXwbT1iNYv2nJojt9MhAShVR2DGDCvI0cJHMKm/dfII1sMydC4+ILDCZxqvh+6GDNWvniVzT/utF8CSks4VSeXk8ERBcT4lWooTmYs+OT8a6edvJHvxPNDtVkayOK+aH/XbpwwVS6FTBRhtK2sLDIUpxKKjg6ax9Z/VC85KZsOfvg2ramioz5hWkFchAGikh5QKKrP+aeHIUfcdtINdsCfAqdVQQ8yGnFYaicLeO1oHlgkykw5aCPMTsuXHJKbUg9uKJVvmNHjqC74EOOKbcIuXQgeWTDaUVyb8c1DbQuVQr7CwOP4tjyVamaVl3WOwHVdobyCpfUeS6GWCnkoPSPC/gclk7RhlgfOJ7UaVLIeTNu7Z3ayt0+FIWE1tUdBC+m6lzzGJ8SyEbdAkBnOngOg5MqFKvus90wVBBoxqXgwlt6efiIZBs+K9P2oOe5owRH8iUPLKZ22/rA1O94Hv4vsfiJGYL8SmhiyIwfRbk0FYnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966006)(36840700001)(26005)(186003)(82740400003)(5660300002)(86362001)(478600001)(356005)(36860700001)(7696005)(34020700004)(1076003)(8676002)(8936002)(81166007)(2616005)(36756003)(82310400003)(70586007)(426003)(2906002)(316002)(47076005)(4326008)(54906003)(70206006)(6666004)(336012)(6916009)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:35:41.8121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c28c9ca-ce82-409a-a00c-08d95e24927c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4821
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

From: Jake Wang <haonan.wang2@amd.com>

[Why]
DM initializes VM context after DMCUB initialization.
This results in loss of DCN_VM_CONTEXT registers after z10.

[How]
Notify DMCUB when VM setup is complete, and have DMCUB
save init registers.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  6 ++++++
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c |  3 +++
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h |  1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c  |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |  1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  5 +++++
 8 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7a442fcfa6ac..c798c65d4276 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1549,6 +1549,12 @@ void dc_z10_restore(struct dc *dc)
 	if (dc->hwss.z10_restore)
 		dc->hwss.z10_restore(dc);
 }
+
+void dc_z10_save_init(struct dc *dc)
+{
+	if (dc->hwss.z10_save_init)
+		dc->hwss.z10_save_init(dc);
+}
 #endif
 /*
  * Applies given context to HW and copy it into current context.
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index f2b39ec35c89..80c752ca4a5a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -47,6 +47,9 @@ int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_c
 		 */
 		memcpy(&dc->vm_pa_config, pa_config, sizeof(struct dc_phy_addr_space_config));
 		dc->vm_pa_config.valid = true;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+		dc_z10_save_init(dc);
+#endif
 	}
 
 	return num_vmids;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 03b81e5c5d67..0494e6dcf4dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1338,6 +1338,7 @@ void dc_hardware_release(struct dc *dc);
 bool dc_set_psr_allow_active(struct dc *dc, bool enable);
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 void dc_z10_restore(struct dc *dc);
+void dc_z10_save_init(struct dc *dc);
 #endif
 
 bool dc_enable_dmub_notifications(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 6399e8acd093..3f2333ec67e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -407,6 +407,18 @@ void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx)
 			&pipe_ctx->stream_res.encoder_info_frame);
 	}
 }
+void dcn31_z10_save_init(struct dc *dc)
+{
+	union dmub_rb_cmd cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.dcn_restore.header.type = DMUB_CMD__IDLE_OPT;
+	cmd.dcn_restore.header.sub_type = DMUB_CMD__IDLE_OPT_DCN_SAVE_INIT;
+
+	dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
+}
 
 void dcn31_z10_restore(struct dc *dc)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
index 40dfebe78fdd..140435e4f7ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
@@ -44,6 +44,7 @@ void dcn31_enable_power_gating_plane(
 void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx);
 
 void dcn31_z10_restore(struct dc *dc);
+void dcn31_z10_save_init(struct dc *dc);
 
 void dcn31_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
 int dcn31_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_space_config *pa_config);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index 05954045c332..40011cd3c8ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -97,6 +97,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.z10_restore = dcn31_z10_restore,
+	.z10_save_init = dcn31_z10_save_init,
 	.is_abm_supported = dcn31_is_abm_supported,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 5ab008e62b82..ad5f2adcc40d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -237,6 +237,7 @@ struct hw_sequencer_funcs {
 			int width, int height, int offset);
 
 	void (*z10_restore)(struct dc *dc);
+	void (*z10_save_init)(struct dc *dc);
 
 	void (*update_visual_confirm_color)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5950da7bf252..a6f3d58f82c6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -860,6 +860,11 @@ enum dmub_cmd_idle_opt_type {
 	 * DCN hardware restore.
 	 */
 	DMUB_CMD__IDLE_OPT_DCN_RESTORE = 0,
+
+	/**
+	 * DCN hardware save.
+	 */
+	DMUB_CMD__IDLE_OPT_DCN_SAVE_INIT = 1
 };
 
 /**
-- 
2.25.1

