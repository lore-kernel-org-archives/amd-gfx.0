Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7AC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B1A61263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B1A61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5886ED8F;
	Thu, 10 Jun 2021 16:29:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF58A6ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz+7Hiq5R60bMa2N7U8dJF+7einXGRVya9HSntZNRDVkUCbrwajItO3GMF15KxHr3ru/1xpzQIQD3r5LjEbLx7zHhIrUQJ/bKtqrNPhSAXHfqZnZOoqQhg2lTZGWL9oVOz9+cQE+qvtQwMhouVcbWZ5/Z/ITW2ZAZcA2wkTR3A/1Y7hpNegO6LdfGlclbFy9HhvkxRkHuzHuwhWOsAbvi7yd67isDW9lWb0AvwxC5G8uTP0eovi2yiEDqn1pf7dXGRc/H8EK5fpe40rXYvIPULPR8/bGW+oJTwL9rYmP8MZGuH4MSdGEIktxN+YgyrmylzXPAcuOBz93UOwfuwWxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KplsIbT0cwH8PHaJ4MutI/SmTbPAxuXSEdyFisjMqiU=;
 b=hk9tn66wyGRytTUY1MVl42060WqShonB4qhcI2sd0/F5pz2JQ/ARyRrt+dVWHn2z+ogrOXXIpl80kW1pO5ow8cz8Q5a9n8H9UP8F23m2HwEi5w57R4qJhYnl8LVskp7uclmmdb/MSU7lyi/mGtLE39g1krtYCYkrzuovWg2AmkioD1JHOyIYuvnCifOi70Do3zClbH5mbTSW7zhAE4JzMz+uIYzL5flkSD/hP7zRQyGenTxid4YXgLnCuJsj9LrljokCUqAiphq1SQEYeGL1cnqUzhMgUCvOb2Sz/nShdrfRtOqa+wXIBT0JlPfAATejbUvojwEn3YuMZY++s+6znQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KplsIbT0cwH8PHaJ4MutI/SmTbPAxuXSEdyFisjMqiU=;
 b=sK5AQ37Z9BP31AF28DVyTBeOKBNVxbIIMQVYdHLppQjbua3k1Qcdz5wPdYEleG8lYj9wNc+PcYIBzMpbVmTACcCke2xTeUD0fjO2dz1v+44HJI4dmPjAonv6/LPqvU+Pso5B1Gw2dh0ECGLpjQvWFVkZD2DcYRybbyPCfIxqBYA=
Received: from CO1PR15CA0071.namprd15.prod.outlook.com (2603:10b6:101:20::15)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 16:29:16 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::b6) by CO1PR15CA0071.outlook.office365.com
 (2603:10b6:101:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:12 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:11 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/24] drm/amd/display: dp mst detection code refactor
Date: Thu, 10 Jun 2021 12:28:19 -0400
Message-ID: <20210610162838.287723-6-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c245dac5-121e-4e73-569a-08d92c2ce374
X-MS-TrafficTypeDiagnostic: DM6PR12MB4434:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44349026439C376D93940768EB359@DM6PR12MB4434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cbADWSsBmDke5uXgHdRVXliJAtoCigDB0WnZZVSv5QszLTA4amLamhFXdtTll9muQuVlWEW4I8P+Nad73q1LC+qFYayUWWwJTsYPNzB0luL2rsPx0Fm8EdvHnpXCBE/xQTH4dxfAZWHRHlsRKzbOeBOcAnppNXdTIjBGjLYLibq4yFEsGTZ41wnRu16EMQ4U5PUNeRFbbG9Wr9Fs0vb4Z3Nl5dgr26mxsEkgKVsbOXFX9NXFcMi7woCzSnuGQP+U2XVoI697MAqAq3/Zdypf7MGnj6row9piSjl84c25B/CuGyc9dyPBhMnGRPjcAdDn/uSpbZmlttdlR9nmW1HUVEVkqHO9on40XOvJtmLKWko0PotzR0pquj/Q5QEgNhCDznJr5vwvaY4lVN78dJ92PyEEeJIjE6Z6IG3gvUVNY1V7JJPjIdydUT0YnISnWKdF5RHw+Q7PMMyk30OS4SxNl7qZdaNK/uTOPz273FmvdgEC1YwIy8mf/C92THEm1L3HcK1ZMFVIxN5qSZ8jjzjwrIRj0W1GGRIFPTB8RlR7pLigllLmvoHKmDC1G7rI+MXoy7oYRrL8AuDWqLw6JWgY+Ml09dJYf8IBhFfPY9kM68T8Tzhk2DGQaxyOqzjKj+YJlh7hc2VXKAPoXp87SpJI5SDaAZUWwIbYsy3gZSpR3C78+Fu5H8TX07QI8jPwmAd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(36840700001)(426003)(2616005)(82740400003)(336012)(8676002)(82310400003)(83380400001)(478600001)(4326008)(54906003)(356005)(2906002)(316002)(81166007)(86362001)(36756003)(7696005)(70586007)(8936002)(70206006)(36860700001)(26005)(6916009)(1076003)(186003)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:15.4262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c245dac5-121e-4e73-569a-08d92c2ce374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <George.Shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Move mst start top mgr in dc_link_detect layer.
Remove unused same_dpcd variable.
Move PEAK_FACTOR_X1000 and LINK_TRAINING_MAX_VERIFY_RETRY
to the proper header for defining dc link internal constant.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 156 +++++++-----------
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  10 +-
 2 files changed, 70 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 33e83c033284..05c963a5b789 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -59,20 +59,6 @@
 #define RETIMER_REDRIVER_INFO(...) \
 	DC_LOG_RETIMER_REDRIVER(  \
 		__VA_ARGS__)
-/*******************************************************************************
- * Private structures
- ******************************************************************************/
-
-enum {
-	PEAK_FACTOR_X1000 = 1006,
-	/*
-	 * Some receivers fail to train on first try and are good
-	 * on subsequent tries. 2 retries should be plenty. If we
-	 * don't have a successful training then we don't expect to
-	 * ever get one.
-	 */
-	LINK_TRAINING_MAX_VERIFY_RETRY = 2
-};
 
 /*******************************************************************************
  * Private functions
@@ -718,11 +704,9 @@ static void read_current_link_settings_on_detect(struct dc_link *link)
 
 static bool detect_dp(struct dc_link *link,
 		      struct display_sink_capability *sink_caps,
-		      bool *converter_disable_audio,
-		      struct audio_support *audio_support,
 		      enum dc_detect_reason reason)
 {
-	bool boot = false;
+	struct audio_support *audio_support = &link->dc->res_pool->audio_support;
 
 	sink_caps->signal = link_detect_sink(link, reason);
 	sink_caps->transaction_type =
@@ -745,60 +729,12 @@ static bool detect_dp(struct dc_link *link,
 			 * of this function). */
 			query_hdcp_capability(SIGNAL_TYPE_DISPLAY_PORT_MST, link);
 #endif
-			/*
-			 * This call will initiate MST topology discovery. Which
-			 * will detect MST ports and add new DRM connector DRM
-			 * framework. Then read EDID via remote i2c over aux. In
-			 * the end, will notify DRM detect result and save EDID
-			 * into DRM framework.
-			 *
-			 * .detect is called by .fill_modes.
-			 * .fill_modes is called by user mode ioctl
-			 * DRM_IOCTL_MODE_GETCONNECTOR.
-			 *
-			 * .get_modes is called by .fill_modes.
-			 *
-			 * call .get_modes, AMDGPU DM implementation will create
-			 * new dc_sink and add to dc_link. For long HPD plug
-			 * in/out, MST has its own handle.
-			 *
-			 * Therefore, just after dc_create, link->sink is not
-			 * created for MST until user mode app calls
-			 * DRM_IOCTL_MODE_GETCONNECTOR.
-			 *
-			 * Need check ->sink usages in case ->sink = NULL
-			 * TODO: s3 resume check
-			 */
-			if (reason == DETECT_REASON_BOOT)
-				boot = true;
-
-			dm_helpers_dp_update_branch_info(link->ctx, link);
-
-			if (!dm_helpers_dp_mst_start_top_mgr(link->ctx,
-							     link, boot)) {
-				/* MST not supported */
-				link->type = dc_connection_single;
-				sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT;
-			}
 		}
 
 		if (link->type != dc_connection_mst_branch &&
-		    is_dp_branch_device(link)) {
+				is_dp_branch_device(link))
 			/* DP SST branch */
 			link->type = dc_connection_sst_branch;
-			if (!link->dpcd_caps.sink_count.bits.SINK_COUNT) {
-				/*
-				 * SST branch unplug processing for short irq
-				 */
-				link_disconnect_sink(link);
-				return true;
-			}
-
-			if (is_dp_active_dongle(link) &&
-				(link->dpcd_caps.dongle_type !=
-					DISPLAY_DONGLE_DP_HDMI_CONVERTER))
-				*converter_disable_audio = true;
-		}
 	} else {
 		/* DP passive dongles */
 		sink_caps->signal = dp_passive_dongle_detection(link->ddc,
@@ -893,7 +829,6 @@ static bool dc_link_detect_helper(struct dc_link *link,
 	struct dc_sink *sink = NULL;
 	struct dc_sink *prev_sink = NULL;
 	struct dpcd_caps prev_dpcd_caps;
-	bool same_dpcd = true;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	enum dc_connection_type pre_connection_type = dc_connection_none;
 	bool perform_dp_seamless_boot = false;
@@ -984,20 +919,59 @@ static bool dc_link_detect_helper(struct dc_link *link,
 					return false;
 			}
 
-			if (!detect_dp(link, &sink_caps,
-				       &converter_disable_audio,
-				       aud_support, reason)) {
+			if (!detect_dp(link, &sink_caps, reason)) {
 				if (prev_sink)
 					dc_sink_release(prev_sink);
 				return false;
 			}
 
-			// Check if dpcp block is the same
-			if (prev_sink) {
-				if (memcmp(&link->dpcd_caps, &prev_dpcd_caps,
-					   sizeof(struct dpcd_caps)))
-					same_dpcd = false;
+			if (link->type == dc_connection_mst_branch) {
+				LINK_INFO("link=%d, mst branch is now Connected\n",
+					  link->link_index);
+				/* Need to setup mst link_cap struct here
+				 * otherwise dc_link_detect() will leave mst link_cap
+				 * empty which leads to allocate_mst_payload() has "0"
+				 * pbn_per_slot value leading to exception on dc_fixpt_div()
+				 */
+				dp_verify_mst_link_cap(link);
+
+				/*
+				 * This call will initiate MST topology discovery. Which
+				 * will detect MST ports and add new DRM connector DRM
+				 * framework. Then read EDID via remote i2c over aux. In
+				 * the end, will notify DRM detect result and save EDID
+				 * into DRM framework.
+				 *
+				 * .detect is called by .fill_modes.
+				 * .fill_modes is called by user mode ioctl
+				 * DRM_IOCTL_MODE_GETCONNECTOR.
+				 *
+				 * .get_modes is called by .fill_modes.
+				 *
+				 * call .get_modes, AMDGPU DM implementation will create
+				 * new dc_sink and add to dc_link. For long HPD plug
+				 * in/out, MST has its own handle.
+				 *
+				 * Therefore, just after dc_create, link->sink is not
+				 * created for MST until user mode app calls
+				 * DRM_IOCTL_MODE_GETCONNECTOR.
+				 *
+				 * Need check ->sink usages in case ->sink = NULL
+				 * TODO: s3 resume check
+				 */
+
+				dm_helpers_dp_update_branch_info(link->ctx, link);
+				if (dm_helpers_dp_mst_start_top_mgr(link->ctx,
+						link, reason == DETECT_REASON_BOOT)) {
+					if (prev_sink)
+						dc_sink_release(prev_sink);
+					return false;
+				} else {
+					link->type = dc_connection_sst_branch;
+					sink_caps.signal = SIGNAL_TYPE_DISPLAY_PORT;
+				}
 			}
+
 			/* Active SST downstream branch device unplug*/
 			if (link->type == dc_connection_sst_branch &&
 			    link->dpcd_caps.sink_count.bits.SINK_COUNT == 0) {
@@ -1007,31 +981,23 @@ static bool dc_link_detect_helper(struct dc_link *link,
 				return true;
 			}
 
+			/* disable audio for non DP to HDMI active sst converter */
+			if (link->type == dc_connection_sst_branch &&
+					is_dp_active_dongle(link) &&
+					(link->dpcd_caps.dongle_type !=
+							DISPLAY_DONGLE_DP_HDMI_CONVERTER))
+				converter_disable_audio = true;
+
 			// link switch from MST to non-MST stop topology manager
 			if (pre_connection_type == dc_connection_mst_branch &&
-				link->type != dc_connection_mst_branch) {
+					link->type != dc_connection_mst_branch)
 				dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
-			}
 
-			if (link->type == dc_connection_mst_branch) {
-				LINK_INFO("link=%d, mst branch is now Connected\n",
-					  link->link_index);
-				/* Need to setup mst link_cap struct here
-				 * otherwise dc_link_detect() will leave mst link_cap
-				 * empty which leads to allocate_mst_payload() has "0"
-				 * pbn_per_slot value leading to exception on dc_fixpt_div()
-				 */
-				dp_verify_mst_link_cap(link);
-
-				if (prev_sink)
-					dc_sink_release(prev_sink);
-				return false;
-			}
 
 			// For seamless boot, to skip verify link cap, we read UEFI settings and set them as verified.
 			if (reason == DETECT_REASON_BOOT &&
-			    !dc_ctx->dc->config.power_down_display_on_boot &&
-			    link->link_status.link_active)
+					!dc_ctx->dc->config.power_down_display_on_boot &&
+					link->link_status.link_active)
 				perform_dp_seamless_boot = true;
 
 			if (perform_dp_seamless_boot) {
@@ -1214,11 +1180,11 @@ static bool dc_link_detect_helper(struct dc_link *link,
 		link->dongle_max_pix_clk = 0;
 	}
 
-	LINK_INFO("link=%d, dc_sink_in=%p is now %s prev_sink=%p dpcd same=%d edid same=%d\n",
+	LINK_INFO("link=%d, dc_sink_in=%p is now %s prev_sink=%p edid same=%d\n",
 		  link->link_index, sink,
 		  (sink_caps.signal ==
 		   SIGNAL_TYPE_NONE ? "Disconnected" : "Connected"),
-		  prev_sink, same_dpcd, same_edid);
+		  prev_sink, same_edid);
 
 	if (prev_sink)
 		dc_sink_release(prev_sink);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 883c3af51022..dd38dd63697f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -42,7 +42,15 @@ enum {
 	/* to avoid infinite loop where-in the receiver
 	 * switches between different VS
 	 */
-	LINK_TRAINING_MAX_CR_RETRY = 100
+	LINK_TRAINING_MAX_CR_RETRY = 100,
+	/*
+	 * Some receivers fail to train on first try and are good
+	 * on subsequent tries. 2 retries should be plenty. If we
+	 * don't have a successful training then we don't expect to
+	 * ever get one.
+	 */
+	LINK_TRAINING_MAX_VERIFY_RETRY = 2,
+	PEAK_FACTOR_X1000 = 1006,
 };
 
 bool dp_verify_link_cap(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
