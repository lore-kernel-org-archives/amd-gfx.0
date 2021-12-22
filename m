Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC52C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 22:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DD710E32C;
	Wed, 22 Dec 2021 22:05:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C3810E32C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 22:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTTiTEuE91X2SV8tPcpYXw1bnb9Gw6Er4BGUzW+REEWhjcpgkVey9Oa6heg9emNfnJRB88KjK1Yj1RWlnEmsEwnBbdGSoTOrQZ5LnnZmCQZZf6yZgsejAUKXbGh1m1SpY+qkwZX0psxBuWu784P3APmZaNbkW7fLUyibX83lEie/mbBaD+PbGzP6V8kmSvUO6yOm7zR46O80wDCRPGPEJKri+et1adoW7RALAmiD3+P8BjmJ/GGB8kbtMPk7CLjpN/zmUeS7WxBgWC5O7Qs79RUhCJPJXrgwoTA1q/NOhOCWYJux0jUDzjvGQEIaMjEp/gB9U+OpOW+mZfMbLxDgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8U54DPFHTZMd+3hV+ucN2mP2U1YtKmAc49UwwsYJ6w=;
 b=ZkccFw5bBi0QMB14FP4nPyaTcFHyaS0aIQnudxBsIpUK+M1NgYywTqyObvP2olhLn+Y/c3mLCh+UtWOFZjWrx6SSsGSZFuxu1zhSRsgvfT2LpHRCLdo0qgU6XYWgYr4dhD9euV50yEoEYTa8x91MaoOpmvH8R4gaspouaEugiecGx8M9p7RumjdQevUoNEQfVpL+TgKGq13xOQXg+TCwdULpURUKfNI434JzI2DJ/goSH8LeI2/1zEJJPSoIZUG2ITKJZXsouAHA9QNKG4y5W4ZZPk86swuAf4JXfEVtkDxhJ7njEv866Wz5LGlP97Jpwkw/84dhi5P5O3XnRX+5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8U54DPFHTZMd+3hV+ucN2mP2U1YtKmAc49UwwsYJ6w=;
 b=uFlT0xWhyJXqjSowTAv3yQjC00v5L0cZBhFz/07RWgbs7eHzoz7D2U0eIlkd6SQ+KwSjaMiwls1SIcN0OcKY9RJwhpzZrxnP+t64Ysc5/kydIFlBtrzN5wCGNs7rvZyd5Bj1Uzi0beRpr+VEAlYcI2zooUSMUG8iEsilsABlfJA=
Received: from MWHPR13CA0002.namprd13.prod.outlook.com (2603:10b6:300:16::12)
 by DM6PR12MB3387.namprd12.prod.outlook.com (2603:10b6:5:3a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 22 Dec
 2021 22:05:47 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::e8) by MWHPR13CA0002.outlook.office365.com
 (2603:10b6:300:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8 via Frontend
 Transport; Wed, 22 Dec 2021 22:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 22:05:46 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 22 Dec
 2021 16:05:44 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amd/display: unhard code link to phy idx mapping in
 dc link and clean up
Date: Wed, 22 Dec 2021 17:05:15 -0500
Message-ID: <20211222220519.1682537-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
References: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f477b27-e069-426b-2d65-08d9c59734c5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3387:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB33879F77C1FDFB54CD9EAA95987D9@DM6PR12MB3387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rj56yh8BuRlAu24aBOTC+NCtIO1YqYV/nj5oZKVaRt236UqPnW02sL4NXKvpi52lVJBA9Y3yQokFlaeO2N+2uNRytorzruoQcRZ13GBm4HcJDL9QBDV25QbwjqH+U6GLv5QdaokMdnmjdelaOCmH90t+/35n2Quq4BvIZlh/9gz5ffEpqnfHPfSWoLhBns2Dz/2VBxpXxE2f7kVaW1X1//uzf5WzXOJp61a51rff89gJBC7laQ193QCRGM1RGED+9wbegJmqxCNGBvtlOlMft9mBFUmBvXkf5LCRmvSLxbsTTIrzs1KMSvvZvP0oPTgd1b9p1wnn9vFQa4Wgrjw7gwPxi8YfQqC/EY5HdgInXwsD4+kjMb22RoIWTD45flfjpa5SyDSkwjsO2XVrA+qvQYd/sKswih6eEWiWqz4ab5QSBp7W75iCHNqewrUwI2rtTObiCU7Wnq+8ny4ZL2uk9h6W5rkl1U73Kiubm/7397gfdKh9ynjw603JIVOncjGrHzKS97sqh7qhCspo438us60O5WgeM+mPZM3MF9wPcK8KOs/Ntq7/NMXBBD2oC2Paj1A9Hd38u0hMK4E9IROT+Ieu16ehMrAe35y2in2XGbibbgNCIWp4aGwalnTOvUuT9hc+jH+zhF0KcC62BQQSDo7tr0dOaB1bW7ffTnJsta84n+TSzR27fGuf+9pJ0fXEDLc2uEDlyqYo6nCC/3tnB6zGXajELbH6uEI2JlfrEzmWZN78WIECrJ+CNE9gd4KH27JVqrXkgr5wdRcLBRqiR5TTxb97MDhR+npZO32EyBg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(6666004)(356005)(70586007)(70206006)(426003)(86362001)(4326008)(2616005)(54906003)(2906002)(40460700001)(6916009)(316002)(36756003)(186003)(83380400001)(47076005)(8936002)(82310400004)(26005)(1076003)(16526019)(336012)(5660300002)(36860700001)(8676002)(30864003)(81166007)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 22:05:46.4144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f477b27-e069-426b-2d65-08d9c59734c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3387
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
1. Current code hard codes link to PHY mapping in dc link level per asic
per revision.
This is not scalable. In long term the mapping will be obatined from
DMUB and store in dc resource.

2. Depending on DCN revision and endpoint type, the definition of
dio_output_idx dio_output_type and phy_idx are not  consistent. We need
to unify the meaning of these hardware indices across different system
configuration.

[how]
1. Temporarly move the hardcoded mapping to dc_resource level, which
should have full awareness of asic specific configuration and add a TODO
comment to move the mapping to DMUB.

2. populate dio_output_idx/phy_idx for all configuration, define
usb4_enabled bit instead of dio_output_type as an external enum.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 145 +++++++-----------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  33 ++++
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   2 +-
 5 files changed, 95 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index dc1380b6c5e0..b5e570d33ca9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3971,102 +3971,73 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 {
 	struct cp_psp *cp_psp = &pipe_ctx->stream->ctx->cp_psp;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct link_encoder *link_enc = NULL;
-#endif
+	struct cp_psp_stream_config config = {0};
+	enum dp_panel_mode panel_mode =
+			dp_get_panel_mode(pipe_ctx->stream->link);
 
-	if (cp_psp && cp_psp->funcs.update_stream_config) {
-		struct cp_psp_stream_config config = {0};
-		enum dp_panel_mode panel_mode =
-				dp_get_panel_mode(pipe_ctx->stream->link);
+	if (cp_psp == NULL || cp_psp->funcs.update_stream_config == NULL)
+		return;
 
-		config.otg_inst = (uint8_t) pipe_ctx->stream_res.tg->inst;
-		/*stream_enc_inst*/
-		config.dig_fe = (uint8_t) pipe_ctx->stream_res.stream_enc->stream_enc_inst;
-		config.dig_be = pipe_ctx->stream->link->link_enc_hw_inst;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-		config.stream_enc_idx = pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA;
-
-		if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY ||
-				pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
-			if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY)
-				link_enc = pipe_ctx->stream->link->link_enc;
-			else if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
-				if (pipe_ctx->stream->link->dc->res_pool->funcs->link_encs_assign) {
-					link_enc = link_enc_cfg_get_link_enc_used_by_stream(
-							pipe_ctx->stream->ctx->dc,
-							pipe_ctx->stream);
-			}
-			ASSERT(link_enc);
+	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY)
+		link_enc = pipe_ctx->stream->link->link_enc;
+	else if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+			pipe_ctx->stream->link->dc->res_pool->funcs->link_encs_assign)
+		link_enc = link_enc_cfg_get_link_enc_used_by_stream(
+				pipe_ctx->stream->ctx->dc,
+				pipe_ctx->stream);
+	ASSERT(link_enc);
+	if (link_enc == NULL)
+		return;
 
-			// Initialize PHY ID with ABCDE - 01234 mapping except when it is B0
-			config.phy_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+	/* otg instance */
+	config.otg_inst = (uint8_t) pipe_ctx->stream_res.tg->inst;
 
-			// Add flag to guard new A0 DIG mapping
-			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0 == true &&
-					pipe_ctx->stream->link->dc->ctx->dce_version == DCN_VERSION_3_1) {
-				config.dig_be = link_enc->preferred_engine;
-				config.dio_output_type = pipe_ctx->stream->link->ep_type;
-				config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
-			} else {
-				config.dio_output_type = 0;
-				config.dio_output_idx = 0;
-			}
+	/* dig front end */
+	config.dig_fe = (uint8_t) pipe_ctx->stream_res.stream_enc->stream_enc_inst;
 
-			// Add flag to guard B0 implementation
-			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0 == true &&
-					link_enc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
-				if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
-					// enum ID 1-4 maps to DPIA PHY ID 0-3
-					config.phy_idx = pipe_ctx->stream->link->link_id.enum_id - ENUM_ID_1;
-				} else {  // for non DPIA mode over B0, ABCDE maps to 01564
-
-					switch (link_enc->transmitter) {
-					case TRANSMITTER_UNIPHY_A:
-						config.phy_idx = 0;
-						break;
-					case TRANSMITTER_UNIPHY_B:
-						config.phy_idx = 1;
-						break;
-					case TRANSMITTER_UNIPHY_C:
-						config.phy_idx = 5;
-						break;
-					case TRANSMITTER_UNIPHY_D:
-						config.phy_idx = 6;
-						break;
-					case TRANSMITTER_UNIPHY_E:
-						config.phy_idx = 4;
-						break;
-					default:
-						config.phy_idx = 0;
-						break;
-					}
+	/* stream encoder index */
+	config.stream_enc_idx = pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (is_dp_128b_132b_signal(pipe_ctx))
+		config.stream_enc_idx =
+				pipe_ctx->stream_res.hpo_dp_stream_enc->id - ENGINE_ID_HPO_DP_0;
+#endif
 
-				}
-			}
-		} else if (pipe_ctx->stream->link->dc->res_pool->funcs->link_encs_assign) {
-			link_enc = link_enc_cfg_get_link_enc_used_by_stream(
-					pipe_ctx->stream->ctx->dc,
-					pipe_ctx->stream);
-			config.phy_idx = 0; /* Clear phy_idx for non-physical display endpoints. */
-		}
-		ASSERT(link_enc);
-		if (link_enc)
-			config.link_enc_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
-		if (is_dp_128b_132b_signal(pipe_ctx)) {
-			config.stream_enc_idx = pipe_ctx->stream_res.hpo_dp_stream_enc->id - ENGINE_ID_HPO_DP_0;
+	/* dig back end */
+	config.dig_be = pipe_ctx->stream->link->link_enc_hw_inst;
 
-			config.link_enc_idx = pipe_ctx->link_res.hpo_dp_link_enc->inst;
-			config.dp2_enabled = 1;
-		}
+	/* link encoder index */
+	config.link_enc_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (is_dp_128b_132b_signal(pipe_ctx))
+		config.link_enc_idx = pipe_ctx->link_res.hpo_dp_link_enc->inst;
 #endif
-		config.dpms_off = dpms_off;
-		config.dm_stream_ctx = pipe_ctx->stream->dm_stream_context;
-		config.assr_enabled = (panel_mode == DP_PANEL_MODE_EDP);
-		config.mst_enabled = (pipe_ctx->stream->signal ==
-				SIGNAL_TYPE_DISPLAY_PORT_MST);
-		cp_psp->funcs.update_stream_config(cp_psp->handle, &config);
-	}
+	/* dio output index */
+	config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+
+	/* phy index */
+	config.phy_idx = resource_transmitter_to_phy_idx(
+			pipe_ctx->stream->link->dc, link_enc->transmitter);
+	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+		/* USB4 DPIA doesn't use PHY in our soc, initialize it to 0 */
+		config.phy_idx = 0;
+
+	/* stream properties */
+	config.assr_enabled = (panel_mode == DP_PANEL_MODE_EDP) ? 1 : 0;
+	config.mst_enabled = (pipe_ctx->stream->signal ==
+			SIGNAL_TYPE_DISPLAY_PORT_MST) ? 1 : 0;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	config.dp2_enabled = is_dp_128b_132b_signal(pipe_ctx) ? 1 : 0;
+#endif
+	config.usb4_enabled = (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) ?
+			1 : 0;
+	config.dpms_off = dpms_off;
+
+	/* dm stream context */
+	config.dm_stream_ctx = pipe_ctx->stream->dm_stream_context;
+
+	cp_psp->funcs.update_stream_config(cp_psp->handle, &config);
 }
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index eaeef72773f6..b3912ff9dc91 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3270,3 +3270,36 @@ void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 				i, disabled_master_pipe_idx);
 	}
 }
+
+uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter)
+{
+	/* TODO - get transmitter to phy idx mapping from DMUB */
+	uint8_t phy_idx = transmitter - TRANSMITTER_UNIPHY_A;
+
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (dc->ctx->dce_version == DCN_VERSION_3_1 &&
+			dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
+		switch (transmitter) {
+		case TRANSMITTER_UNIPHY_A:
+			phy_idx = 0;
+			break;
+		case TRANSMITTER_UNIPHY_B:
+			phy_idx = 1;
+			break;
+		case TRANSMITTER_UNIPHY_C:
+			phy_idx = 5;
+			break;
+		case TRANSMITTER_UNIPHY_D:
+			phy_idx = 6;
+			break;
+		case TRANSMITTER_UNIPHY_E:
+			phy_idx = 4;
+			break;
+		default:
+			phy_idx = 0;
+			break;
+		}
+	}
+#endif
+	return phy_idx;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
index 511f9e1159c7..4229369c57f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
@@ -34,12 +34,12 @@ struct cp_psp_stream_config {
 	uint8_t dig_fe;
 	uint8_t link_enc_idx;
 	uint8_t stream_enc_idx;
-	uint8_t phy_idx;
 	uint8_t dio_output_idx;
-	uint8_t dio_output_type;
+	uint8_t phy_idx;
 	uint8_t assr_enabled;
 	uint8_t mst_enabled;
 	uint8_t dp2_enabled;
+	uint8_t usb4_enabled;
 	void *dm_stream_ctx;
 	bool dpms_off;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index ee4a5df428e3..028180f58f71 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -218,5 +218,6 @@ void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
 void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 	struct dc_state *context,
 	uint8_t disabled_master_pipe_idx);
+uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter);
 
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index 6d648c889866..f7420c3f5672 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -104,6 +104,7 @@ struct mod_hdcp_displayport {
 	uint8_t rev;
 	uint8_t assr_enabled;
 	uint8_t mst_enabled;
+	uint8_t usb4_enabled;
 };
 
 struct mod_hdcp_hdmi {
@@ -249,7 +250,6 @@ struct mod_hdcp_link {
 	uint8_t ddc_line;
 	uint8_t link_enc_idx;
 	uint8_t phy_idx;
-	uint8_t dio_output_type;
 	uint8_t dio_output_id;
 	uint8_t hdcp_supported_informational;
 	union {
-- 
2.25.1

