Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABE6C433E9
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E71A64E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E71A64E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA4F6EC28;
	Fri, 29 Jan 2021 21:28:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33B76EC22
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRqiR8D8pMo2Oca7o/sQcE7NmQlgq1Q8N9G05FQdj4uiNCKjBXsj38RHxUpbnrONXM7eR3vv3TNqdR6EvlQiRMUy95iiMVywrRZw94Wu5ckXtLVhYUFlUqAgF0rvKE7s3+P/FTmAy89HWYia7r4Fu6P/6L+H6/n3s8Wve8i3vt37dFK48A5DplVkGrDyGIWPqo1bfEuJ06IYBGoNwmDNkfaJpC7Y4yLn7g5dl9o/CwMm1DiUVX41n+HcyZgkWABjwo1OSFOsg3zyVlEcFZcBVTwQlMc6G6IbXYHL9zuWcRvm4P+O2aeqWtlJEgewRiT9uffK5Su5G6uK+xsEM7mazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNkpCgVB8zwQC0c4kkni2C8DIF0petzP/XG1/2FzNMk=;
 b=jcYCVFTxu38F2RuLKAhprbR9ROusCjq1kJZKy8vyHXelLM9fAntMn0OYdEnNMT2aqTvORXAcTN0xuEb2vv03zHdHsZwau942LAGHvreXPYEIGYMfN3moBu4m7b1683e4GSrfm25KU59/rjPRnWPsTfirN/rx3fInyPvhTK5oMiRbjfU3tp4wVNsEWpkxtIrgLjDRscILQ9yrxoAdledDiO1L/5kB1HXXVhkFEBa2eS9DHDm1L1TAZyyxmW8gWwHJZ9ZOP34ieP6idfy6l6umA9b/fqBtlgjj/rVxAU/D+0IEQN3TqCK9LJThMvI2aoHchdr7ljSYxqIXqjNE7H0mZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNkpCgVB8zwQC0c4kkni2C8DIF0petzP/XG1/2FzNMk=;
 b=g0J3NEvLsM5JIj6E32gdPoERUpr4XYODkNupCmNO0V6v7/PUBds6gGoPSlTCpN8RDd6CMRqCn8YhQL+2DTp//XQJPQOQGo0qG7rU/cSBozItaeCL7khcVpaJO9tr5VjRNw49eYtRltMn238mMg7lDfLeSVP/hvhMBYIH5i8/Rw8=
Received: from MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40) by
 MN2PR12MB3168.namprd12.prod.outlook.com (2603:10b6:208:af::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Fri, 29 Jan 2021 21:28:09 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::d6) by MW2PR16CA0027.outlook.office365.com
 (2603:10b6:907::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:06 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:05 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:05 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/27] drm/amd/display: correct some hdcp variable naming
Date: Fri, 29 Jan 2021 16:27:32 -0500
Message-ID: <20210129212752.38865-8-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f30b5bc-1f2d-4b2b-3e8a-08d8c49cc53a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3168:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3168D6836AEA61CB4AF88746EBB99@MN2PR12MB3168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: osRcI25nRWxXvzrsEUbZYMZwFV0OlJ4w3gHZ2Wnyp1yqa40R+rv1/drCy81swHB39/Q0PuL88lolxQwI+0mc43fGtTYQur56uDeU+ViRzT1iRZLFhKlSCURyr+fk+Hke1GhV6CBWogLqNRe4OJMvN7felo9/Aueq2hlNzoxFq+QbgVb7aCPVzWOlSqOuq1Y46b93CJL7jD4gURhH95wPcNkEV/6ZNqJ9skodb4YhPpTADqIfoSS6t6wnZepYi0uMVS9LiQUvN+Y8rD8gULhDFK2ySWcTIO2nvayeAXQ0q54kauJMcREJrt/hOpGFmLrsG0fwsJRoSMF7JS8xuqBuHSFaUaSIrOngm5MYkRhEMAz+hVByIAga+3McREYYRsH61lcbq5Y/xkxWp1wWIZNizVw5euVa5UVJHcBU9LfosLw9oHk4EU016FNer28UZTtaIeS2Rtq5rsRL9WR3bAHSMNMOwEUmaBQe7jMX8OQffsJPxs0udQ8d5xOJxG6wqcjrGzNoP+SHcxM0izoZNHhpyf6E416Yk+f0uYqZ3l1LTfUpQ///4DzrZlNR8kWAXfNDL7rfix5azoUnxJgCzbGFzuqDfwxc36DugMAqtBEqkFHn5s0V8f8pKb7+vMRyXQVC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(6666004)(36756003)(47076005)(82740400003)(186003)(426003)(6916009)(82310400003)(2616005)(4326008)(70206006)(86362001)(336012)(8676002)(316002)(7696005)(54906003)(356005)(83380400001)(5660300002)(2906002)(70586007)(478600001)(81166007)(8936002)(1076003)(26005)(21314003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:07.4107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f30b5bc-1f2d-4b2b-3e8a-08d8c49cc53a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3168
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <George.Shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
In HDCP update stream config interface, some variables are named as
xxx_supported, but in fact the variable indicates whether or not xxx_enabled.
Correct the naming so it is less confusing to read the code.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  7 ++++---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 14 +++++++-------
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h         |  7 ++++---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |  2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |  2 +-
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |  4 ++--
 6 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index c2cd184f0bbd..b297ddc24d3a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -449,11 +449,12 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 		link->mode = mod_hdcp_signal_type_to_operation_mode(aconnector->dc_sink->sink_signal);
 
 	display->controller = CONTROLLER_ID_D0 + config->otg_inst;
-	display->dig_fe = config->stream_enc_inst;
-	link->dig_be = config->link_enc_inst;
+	display->dig_fe = config->dig_fe;
+	link->dig_be = config->dig_be;
 	link->ddc_line = aconnector->dc_link->ddc_hw_inst + 1;
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
-	link->dp.mst_supported = config->mst_supported;
+	link->dp.assr_enabled = config->assr_enabled;
+	link->dp.mst_enabled = config->mst_enabled;
 	display->adjust.disable = 1;
 	link->adjust.auth_delay = 3;
 	link->adjust.hdcp1.disable = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 55f20d731b25..8506739a22f7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3169,17 +3169,17 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 {
 	struct cp_psp *cp_psp = &pipe_ctx->stream->ctx->cp_psp;
 	if (cp_psp && cp_psp->funcs.update_stream_config) {
-		struct cp_psp_stream_config config;
-
-		memset(&config, 0, sizeof(config));
+		struct cp_psp_stream_config config = {0};
+		enum dp_panel_mode panel_mode =
+				dp_get_panel_mode(pipe_ctx->stream->link);
 
 		config.otg_inst = (uint8_t) pipe_ctx->stream_res.tg->inst;
-		/*stream_enc_inst*/
-		config.stream_enc_inst = (uint8_t) pipe_ctx->stream_res.stream_enc->stream_enc_inst;
-		config.link_enc_inst = pipe_ctx->stream->link->link_enc_hw_inst;
+		config.dig_fe = (uint8_t) pipe_ctx->stream_res.stream_enc->stream_enc_inst;
+		config.dig_be = pipe_ctx->stream->link->link_enc_hw_inst;
 		config.dpms_off = dpms_off;
 		config.dm_stream_ctx = pipe_ctx->stream->dm_stream_context;
-		config.mst_supported = (pipe_ctx->stream->signal ==
+		config.assr_enabled = (panel_mode == DP_PANEL_MODE_EDP);
+		config.mst_enabled = (pipe_ctx->stream->signal ==
 				SIGNAL_TYPE_DISPLAY_PORT_MST);
 		cp_psp->funcs.update_stream_config(cp_psp->handle, &config);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
index 5da7677627a1..cac0b2c0d31b 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
@@ -30,9 +30,10 @@ struct dc_link;
 
 struct cp_psp_stream_config {
 	uint8_t otg_inst;
-	uint8_t link_enc_inst;
-	uint8_t stream_enc_inst;
-	uint8_t mst_supported;
+	uint8_t dig_be;
+	uint8_t dig_fe;
+	uint8_t assr_enabled;
+	uint8_t mst_enabled;
 	void *dm_stream_ctx;
 	bool dpms_off;
 };
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 6c678cfb82e3..5c22cf7e6118 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -397,7 +397,7 @@ static inline uint8_t is_dp_hdcp(struct mod_hdcp *hdcp)
 static inline uint8_t is_dp_mst_hdcp(struct mod_hdcp *hdcp)
 {
 	return (hdcp->connection.link.mode == MOD_HDCP_MODE_DP &&
-			hdcp->connection.link.dp.mst_supported);
+			hdcp->connection.link.dp.mst_enabled);
 }
 
 static inline uint8_t is_hdmi_dvi_sl_hdcp(struct mod_hdcp *hdcp)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 3a367a5968ae..b26ed64eaf98 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -106,7 +106,7 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
 	dtm_cmd->dtm_in_message.topology_update_v2.dig_be = link->dig_be;
 	dtm_cmd->dtm_in_message.topology_update_v2.dig_fe = display->dig_fe;
 	if (is_dp_hdcp(hdcp))
-		dtm_cmd->dtm_in_message.topology_update_v2.is_assr = link->dp.assr_supported;
+		dtm_cmd->dtm_in_message.topology_update_v2.is_assr = link->dp.assr_enabled;
 
 	dtm_cmd->dtm_in_message.topology_update_v2.dp_mst_vcid = display->vc_id;
 	dtm_cmd->dtm_in_message.topology_update_v2.max_hdcp_supported_version =
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index eed560eecbab..d223ed3be5d3 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -101,8 +101,8 @@ enum mod_hdcp_status {
 
 struct mod_hdcp_displayport {
 	uint8_t rev;
-	uint8_t assr_supported;
-	uint8_t mst_supported;
+	uint8_t assr_enabled;
+	uint8_t mst_enabled;
 };
 
 struct mod_hdcp_hdmi {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
