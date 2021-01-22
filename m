Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E8C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87ECC23AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ECC23AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A716EA4F;
	Fri, 22 Jan 2021 20:07:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C01E6EA40
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1HGTFqfbv7yHl6zV3OS+AkwyXl89F8JTmtDufAx0Wrb1X3Pc/V9J9cF1dgcLM/4WcCFHKz7SFdqfplVVbNslMLsfgakrYCOIYqGpqX7+AzPwKASg8/jPzYOM8sFDBwor2S1r1g/bN0sjFs7fbR5BUx0x0EXnXkR3WAJUhO7QA7X2IMSNHWp5FByMj1WUGTDmgPNcpJqiliN9tgLP4VPe5GiWS50hIQCF9CZF826Su4+/Ez7s8asBmglaZw/4ccWr+NZgYp/E2GxaHnqXoUqE1aQXTUNifniP1j+8oakvTyC+GNffKO5JRtq+Z3CwhxWGPcplX2iPiHfMp6l3gbsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y9YeXaGQijFlahiHftwgixdOsCPqaC0hRBr3W/PTxU=;
 b=HFCZ0b2Fsu50r4a7ijRLPREL4AZFKBxpREqA35QROw5dfzK3DNyHZYCENSsTADQhJLgSsIDmnI6nrNBQj9x7BKycXG3qI1zNOg+7my2OBZqMoavZp3UbylobUBOBATUR0v6bS1ZWTywRAS/IYQIv3Y054DmXW/wMir503O5gCgkktjbYwZr9SkDD1hyPwbz/bno6CLcYAJtJF3eIHKSeu593ZVudpLTpE+oB6y13lcSBcuKcPMYn+Xn3oWbbbpz2mPYcm1ZReUhgHmcsXgEPaA7OgIwBf45cq1DkMUIHem3Pbl40P+4LiSXPFDuOOBMts5KZvkEQF969iGErJXOo2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y9YeXaGQijFlahiHftwgixdOsCPqaC0hRBr3W/PTxU=;
 b=AI9QBmrlUZhaniviF/sY6XD/baP0HSm/2+s2h45HPgptHHcGJ8shU3Kj+P9c7LxSPR+NFCW+QyIivvRKVHoceHo9auz9PkeLn6h1wZd5VyXV4JYL6HJjiAfN/xkeMtYICsPjfOi7k8ptFiWI6CSsRUq7tK+6Vy4QFKVKNUqL+ho=
Received: from MWHPR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:301:4a::31) by MN2PR12MB4456.namprd12.prod.outlook.com
 (2603:10b6:208:266::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 20:07:09 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::62) by MWHPR1201CA0021.outlook.office365.com
 (2603:10b6:301:4a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:05 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:05 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:07:04 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/display: correct some hdcp variable naming
Date: Fri, 22 Jan 2021 15:06:47 -0500
Message-ID: <20210122200652.197934-8-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a846f7-846d-4410-24e0-08d8bf114b6e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4456:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4456924D8111328993C2F3ADEBA09@MN2PR12MB4456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qw0hk7YJStcGWcXGYzGKkg2xIrRjiG3MCnLTxeFc09bDNdEvuZxzTT3FX2XRa+Taj9j4cdmS5ZYjE9zZUuQpB+xnKGec83ZT4/sLwYvQySwaxjyi+nJH202OFDX0NPXwjM97YCANPi3/v81fm2fM3OtsiLok+Kio/lAd/wXaT2j0IaJNNWjNG4r+7/ncMVENTK0cwp0w0WPg29dhdXq/oJcg6sLTbCafiX3+AsR8fiocmKBaoIbK3N7iKBvG67pfO/QTS+3RMmDv8BT/DmS+E1Z5jsakXRHahATwzSdyfXAqWfPh8RM81vbQiVZBQnK3x5ID8ATBEwcuBz4nvc4XsH3E6TZZhY33QxKWVzNLLbrktILihwwUZMUz+tC3hKuFasKecCaLS36opgpv2YEMzhl0EKanGMJBLpDopU7KfR6+ms4hae/qVIS8Kdg+TtVvuyitHHRunTuMn1GaRL78pF3JdIW2rhcQHj4+6VJJrtmiRvjvomhRbLTGGOy9pQU3HwQxctbkvl88tdPPQJPmaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(336012)(70206006)(86362001)(426003)(2906002)(8936002)(36756003)(26005)(81166007)(478600001)(186003)(82740400003)(7696005)(82310400003)(2616005)(8676002)(356005)(6666004)(5660300002)(6916009)(4326008)(70586007)(54906003)(1076003)(316002)(47076005)(83380400001)(21314003)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:07.2075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a846f7-846d-4410-24e0-08d8bf114b6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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
index c16af3983fdb..60bf091dc123 100644
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
