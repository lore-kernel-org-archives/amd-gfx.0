Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8522EC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D01B6109D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D01B6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035006E4CB;
	Fri, 13 Aug 2021 06:16:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D45D6E4CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaaeT9a/SVanIeg3x/4YpinXnGFPzIoZImDHQ/+PZVOPou2Ny2ufcLxr786NRBiKR9JA+DnaQhUk4qhrL1HU1qU9vi0mcXWOqk34I9L9qfUgQjgGTfnwKuUH91UlAgOMgpXd2vVzvRpe6IYtLoet6F9lu73lQ0dDZZVf/VNX13QInetGQbQsKoTuKaFYKW4FG47Lxa/3Lfos3U+LDjnHxOYDjikFqNKqT2qCNI1aqwYjqzvyBfKgLjSRRl+DSyktqmB6qgEa6Sr+h10+u/ovqa3V0mAC80SMP2KLQcS/ZH1noB3h9QE+iDcPCDjpQKKEo3ffw8TBs94DX2lK8zsp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnrQlETfYdyh9hHpis97hGEr4uOBnNX1G63PSpd7wMI=;
 b=E64F5uMguHJB2fJslFgfHNy1qFS4T0M2w5Yt0i7jDj0sKZzvHTuguqy32pzw3a1+JSogjLhElMVjh/n75rkw7mvf2OIFoOy2HgpkCfe3uUU/6ka2JEo0EP2cUz2IJSm4L9vatnxPwHmJQfbPouk5UhbJRlfCYYx/8+QA/o4TvcXixMOFjwAhoORQLIteqMQhxwTOhzc6P9SDSl7A6gGGYj6zG7qhqNPPdz/hFyivNUWf7ZzdCm5H7iMvjk1XTp5r4cNFXquiDvmS6sueXG3FCjXpEi2HH22T3ObHIa7Wt6yTMOt+hU98spUv89EvkFFRYOOABL+U9VN0gRPFt3iudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnrQlETfYdyh9hHpis97hGEr4uOBnNX1G63PSpd7wMI=;
 b=ejBzD5Sd6HJmqbbMoYAT67VUWHpHtE4PKQKmiBNRLYCk3a5qJytyuuGB8UElU8tpGq7T45dito+JI2twT5lSgMmLklFUoTwEvrDXlqDzpl+ImoeH8dt4WcaBaeuibtxe9miFJoYWQBw7rPvIY1/f066/Y12PORR3ntU6Vf+BiTo=
Received: from BN8PR15CA0014.namprd15.prod.outlook.com (2603:10b6:408:c0::27)
 by BYAPR12MB3319.namprd12.prod.outlook.com (2603:10b6:a03:dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Fri, 13 Aug
 2021 06:16:30 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::53) by BN8PR15CA0014.outlook.office365.com
 (2603:10b6:408:c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Fri, 13 Aug 2021 06:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 06:16:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:16:21 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:16:19 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Jake Wang <haonan.wang2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Wayne Lin <wayne.lin@amd.com>
Subject: [PATCH 4/7] drm/amd/display: Ensure DCN save after VM setup
Date: Fri, 13 Aug 2021 14:15:47 +0800
Message-ID: <20210813061550.3104690-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813061550.3104690-1-Wayne.Lin@amd.com>
References: <20210813061550.3104690-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c3dc26-ffe8-4234-b487-08d95e21e352
X-MS-TrafficTypeDiagnostic: BYAPR12MB3319:
X-Microsoft-Antispam-PRVS: <BYAPR12MB331963C339C38A51CA3D10E4FCFA9@BYAPR12MB3319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIehxdgJgrFSCLXmrHxPmr/LFK2efMkqh/t9G4lvhLVzV8aoV3PaD3fBg7ZEd/9T7F1dx3Wpb9wC0plVltyfjTv2h6BOLDBLkb1Du/0NB/M77xW+zNguuG9mwXYYqKMrhQdzdQtHFVknxti/6HswNtEvRqB8T2moNf3LuDZu6WonrPs2SnCh/RG35QsqG1g8/WfchIK/grK1BKXfrSm1iyZ/F7JYLxkcF216fl5Q7CpSRbwpORjTzex7qqiyYgFv2DfWeGBrElB06AAAeuS88eBrj79RYuoKfvMUtYTTvp/QkSQIdOy5OdnkMq9D4Ys1sJqB0B05FxFRaEgPOXEa+/mAOK8ihR/sVpPqzo8iRuI+JMxMsIcSpzJnQ9pxw9JnX1pttp7prMywDP6A1m5eNQTQXIc+Pjk6i3ykIDdUYMWHctsEMWYkOEpTbAPWLNnOwEDKSKxLTJgJ/MArnwzf/UnQhvJFJY/hD7yvRU/I3hUdTIHRYFihaHwGJiRTb4ng4ObFKUHd+bl9D10pnIyGs9QIUSyxE/yMWMZFlQexBc172Tt359H2Qbl7LwGQBrG4T4ZQ1WstnI76JoB2wnsAusuvsYdZFPE66NYpfBj8FXtD0wm6LQMwSr7YN10eREYaA3VZFZQJMUVjx8SacwO9kPKXGWtlbEvuqedTjaPtntsPpCMohQ+CPRIZDRx3S620ufYenV0Jj9rCnzB6nFxO6uPmFiajlG9w1sSk9kPjs+bblyJkBmaVasXma9n0eZCD4dvhK3pI+9Y1c91JzbizjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(70206006)(83380400001)(81166007)(316002)(82740400003)(86362001)(6916009)(4326008)(70586007)(36756003)(54906003)(36860700001)(8936002)(2906002)(8676002)(356005)(478600001)(5660300002)(6666004)(7696005)(47076005)(26005)(426003)(2616005)(1076003)(336012)(186003)(82310400003)(34020700004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:16:28.9996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c3dc26-ffe8-4234-b487-08d95e21e352
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3319
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

