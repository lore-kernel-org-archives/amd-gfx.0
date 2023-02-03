Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F432C636D4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6416F10E7FB;
	Fri,  3 Feb 2023 15:25:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F9C10E7FA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eos6Rq1ygG2Vp2ERxWgfOuGsBCYhvxjy0rsPjTVQEdgaIFFyVTyEhAPbo8SLdBJReJTSkOm4QwFgY78gwT0RNdzjO1NIipKFI91vs1BZEO06oRlhsmG+iOfFaHWhmWc2IIrY1ci4g4fTox+yQdwr64tvYlranxFKtrZlcOTXzig4Ea3QwREKoB4m44wXi/cc1BdpozvghwOpjfxIHYPrdwLSm2wUYGzgXJui9znOqW6jaUeB/k3GR+YZkS7MPk7k20ZY66y54VphDMKjBv+5ILsl4Rzyh5v1f4nPhAeLbDn4RMLppQyDlyvfLbkt9gbuDqOk/0phlkgQRKrYab4IbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvWzu8sMaWy8oASTLlktbrrZe5NwFAA4Nn48k9NLVmQ=;
 b=alKjDOdoWIEsmYuQupbAB/jEVM00GA6x7CDiy51DA9qWG1jAMjTgYkAWcNgzmQ+1PyOE/9FQ+/xO4yT7cm5dznMmohLpl8YYl9HyiqgLohjWZiDEjFlcPfKFnJh5yAOkMybnW1lTYHp0QHlTFKSQWIUTYKSKK+z23+lbD6GProtn2x5SNOWARbyLowpPpo2H7EmplJm0hIVmVkl2pVnMeHcmLRDU2WGn+VQXolHpzsz4JVy3DLbX6P6J/QGvr6lz8HJYsweVwlCmsISqB4RKlOQ9IEz/S20/smVopnNFpFphXz1EYlYEivT234J1hc4x5NrksQIlBZE5x9jhFp9vRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvWzu8sMaWy8oASTLlktbrrZe5NwFAA4Nn48k9NLVmQ=;
 b=r8Fb/mS1Cde4yVjrgnUrZeNsAVOKkivtwoW1nXBj0CRmFEGwM+Mo5PsifJ4zZ2oK5rqlphe+8v22SX6MWg5wcqs8KTXt9Ic9DGl55wuHsFtjQsyf5wjHWorQeJfreagSrMB5/W9DxbfT6f6jeIFUOrPYFNoAZsNLfFx9h3TArb0=
Received: from MN2PR15CA0046.namprd15.prod.outlook.com (2603:10b6:208:237::15)
 by DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 15:25:39 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::96) by MN2PR15CA0046.outlook.office365.com
 (2603:10b6:208:237::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:36 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:32 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: Move DCN314 DOMAIN power control to
 DMCUB
Date: Fri, 3 Feb 2023 10:24:48 -0500
Message-ID: <20230203152452.1441747-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|DM4PR12MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ce8f2d-d741-4b6f-81c7-08db05fae691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++mUQBHuHxY2x4m6TObcmRws8nEaGcQ1vgVWTfwlVl/clVlO5SujHgTiWdbkoyq+Dk1EPoxjcbzDmz1sWleJ9hBThe6jPqL5TWWI6g6OI7HGSnS/VkwwqueGzUjWYJHjiJ9DgJgn6bclsZti6qbbBReZ+5zVluyYfOTHgPaJClLrsQXTX/e/1g4OuzcOTJB0ijq5NFMZ0/8SKNMXsVXElNUnf60xHxrfcr1Fq4IYFBqGishm04rpDIoqOGx+0nyUkefjNMTSeuAK8sn5iz1dYLHOjYyrjdThP/pY/M9rLwMu1rFja5rAyx3DEjDkJ2V4rgSzfiTVG8d/C8Aqk7FIPE+WHyLKP/eQdRj1IDz43AGs2E0lpD8vAxEWyZ4C0d+FfptSmQ/XljlwXygX+OirVf31iw+CkxKbm9fCE2v+efqyxFIIIP38WjqdEH2AP9aFhtH0d0+Jv95n2ptCXVI7RG+LlhwD608O+JP69uXO8G2cDbqs8Jp4HcnEwBX2wq0uJQQdIx1qZ4nzX2/iXZOdSvy5aBYPUQivO1Ou1OkPAMc9GlKfo7bzLFomGcxjEnMRIVKvlQquCX2q2RvionJfI+UrlurqcHuuTxCpyjeRcbp/TRTDcYM9eJUOmcJAP41H0g2WpihIF60z9oH2zZN6NCgdYQZJRUm5yiMqQxK7EVVZUa8PHDtrriz5y6DO5ZUNBuCYjAqKXN/6HRhZh+cP3S6P63sopoG/6Yv2U96Z9gY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(5660300002)(8676002)(40480700001)(86362001)(6666004)(316002)(54906003)(2616005)(1076003)(2906002)(36756003)(16526019)(186003)(41300700001)(8936002)(336012)(83380400001)(44832011)(40460700003)(6916009)(47076005)(70206006)(81166007)(4326008)(70586007)(426003)(63370400001)(63350400001)(26005)(36860700001)(82310400005)(478600001)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:36.8503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ce8f2d-d741-4b6f-81c7-08db05fae691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
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
Cc: stylon.wang@amd.com, Hansen Dsouza <hansen.dsouza@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DOMAIN power gating control is now required to be done via firmware
due to interlock with other power features. This is to avoid
intermittent issues in the LB memories.

[How]
If the firmware supports the command then use the new firmware as
the sequence can avoid potential display corruption issues.

The command will be ignored on firmware that does not support DOMAIN
power control and the pipes will remain always on - frequent PG cycling
can cause the issue to occur on the old sequence, so we should avoid it.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  | 24 ++++++++++++++++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |  2 ++
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 25 +++++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index d725260336fe..575d3501c848 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -389,3 +389,27 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 		pipe_ctx->stream_res.stream_enc->funcs->set_input_mode(pipe_ctx->stream_res.stream_enc,
 				pix_per_cycle);
 }
+
+void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
+{
+	struct dc_context *ctx = hws->ctx;
+	union dmub_rb_cmd cmd;
+
+	if (hws->ctx->dc->debug.disable_hubp_power_gate)
+		return;
+
+	PERF_TRACE();
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.domain_control.header.type = DMUB_CMD__VBIOS;
+	cmd.domain_control.header.sub_type = DMUB_CMD__VBIOS_DOMAIN_CONTROL;
+	cmd.domain_control.header.payload_bytes = sizeof(cmd.domain_control.data);
+	cmd.domain_control.data.inst = hubp_inst;
+	cmd.domain_control.data.power_gate = !power_on;
+
+	dc_dmub_srv_cmd_queue(ctx->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(ctx->dmub_srv);
+	dc_dmub_srv_wait_idle(ctx->dmub_srv);
+
+	PERF_TRACE();
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index 244280298212..c419d3dbdfee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -41,4 +41,6 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
+void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
+
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 5b6c2d94ec71..343f4d9dd5e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -137,7 +137,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.plane_atomic_disable = dcn20_plane_atomic_disable,
 	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
-	.hubp_pg_control = dcn31_hubp_pg_control,
+	.hubp_pg_control = dcn314_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn314_update_odm,
 	.dsc_pg_control = dcn314_dsc_pg_control,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 04df407092b1..f28f7675d736 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -457,6 +457,10 @@ enum dmub_cmd_vbios_type {
 	 * Query DP alt status on a transmitter.
 	 */
 	DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT  = 26,
+	/**
+	 * Controls domain power gating
+	 */
+	DMUB_CMD__VBIOS_DOMAIN_CONTROL = 28,
 };
 
 //==============================================================================
@@ -1213,6 +1217,23 @@ struct dmub_rb_cmd_dig1_transmitter_control {
 	union dmub_cmd_dig1_transmitter_control_data transmitter_control; /**< payload */
 };
 
+/**
+ * struct dmub_rb_cmd_domain_control_data - Data for DOMAIN power control
+ */
+struct dmub_rb_cmd_domain_control_data {
+	uint8_t inst : 6; /**< DOMAIN instance to control */
+	uint8_t power_gate : 1; /**< 1=power gate, 0=power up */
+	uint8_t reserved[3]; /**< Reserved for future use */
+};
+
+/**
+ * struct dmub_rb_cmd_domain_control - Controls DOMAIN power gating
+ */
+struct dmub_rb_cmd_domain_control {
+	struct dmub_cmd_header header; /**< header */
+	struct dmub_rb_cmd_domain_control_data data; /**< payload */
+};
+
 /**
  * DPIA tunnel command parameters.
  */
@@ -3322,6 +3343,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__VBIOS_DIG1_TRANSMITTER_CONTROL command.
 	 */
 	struct dmub_rb_cmd_dig1_transmitter_control dig1_transmitter_control;
+	/**
+	 * Definition of a DMUB_CMD__VBIOS_DOMAIN_CONTROL command.
+	 */
+	struct dmub_rb_cmd_domain_control domain_control;
 	/**
 	 * Definition of a DMUB_CMD__PSR_SET_VERSION command.
 	 */
-- 
2.25.1

