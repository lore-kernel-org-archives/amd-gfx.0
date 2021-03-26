Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE680C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FB661A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FB661A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8806F4C2;
	Fri, 26 Mar 2021 22:06:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 594A66F4C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEM7ttWvHYI6C5TUtYea6OMDqutnhvsnp7bUzjbZBeNkvnCoQlmUYBqwjYifG6oaM1Jl+FQnCU1NFIyAstf6aji8HcQgH/vDE5h7379LpdGR+aUZKpmrnUyO2peOhdEvZ4WW4HHE6Tt1Oyoh6py1EzndLQIEFQTJq4GtRMJpbs/z9c3MH5oRLzh6o9MfXplLUTZjwqa/KRHrAnZeCLROOlORydBG5pzv6mSGZVhAhjBLT6JOY0+Trr7Gdzqb/jCHWgCmVG5Tdz+gCSE0DySskjD7GdwB8lMQegQGA8willvPjInDsHS1L6Gcy3ZdE0poW187UzVyCDqQRZxc5JsBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLS2WxUbPmcQxDAEE7XHZ1yJtJiJVYXjKSAZpTZjmL0=;
 b=bhYgfXtP8zysBY9usOmHtNGEP6muK9dxbzAx1ferqUh+O2rVyZOfIXITi2uEgfiJ0EOc7xP1d6O6oFp2YgQO8bc6HmkY+lw7C/vQI8sqKdWCvWXoQb2j6Sa0XvD3SGirNN21k0OgbZndXBuLNqKh6uhvuFzc0fzylZFOB77KXfgz8VTKpl8kg4CywAIlyf0bMJBVr/qP1PrLUj09RiTtWWLQkl9Y2EBDhduumScQY7CQI3HlfY/LXKvZO+5BM8+Ci0XnN4mplMcNv5pyZfsw01l14tnAQ8rnwJRkAux2JvIonuvbWHlS13wmroa/1kb3d7lqQRYHRMNoaDzUhcB8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLS2WxUbPmcQxDAEE7XHZ1yJtJiJVYXjKSAZpTZjmL0=;
 b=jzfAAiaK04URGPvU5ElJ5T/VJ6MnWpiaC8t2SWlBavETT21tznjD834LiETzH6TjdhUj1aJ9sAMTJxmkV/wG9laPPbacjW6TTJ1RoHT+hF7hNiqejhpJwv+MlQ8b9gGeIeRqKWEa6HWm8c7ULg+kgmtr5/eA8x6x4iD/LgWmV1c=
Received: from DM5PR16CA0008.namprd16.prod.outlook.com (2603:10b6:3:c0::18) by
 CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29; Fri, 26 Mar 2021 22:06:16 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::9e) by DM5PR16CA0008.outlook.office365.com
 (2603:10b6:3:c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:14 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:13 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/21] drm/amd/display: Update display endpoint control path.
Date: Fri, 26 Mar 2021 18:05:28 -0400
Message-ID: <20210326220534.918023-16-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3497c754-eda1-4109-e436-08d8f0a36040
X-MS-TrafficTypeDiagnostic: CH2PR12MB4088:
X-Microsoft-Antispam-PRVS: <CH2PR12MB408858960E3A77736229CA7DEB619@CH2PR12MB4088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPA2ksqsT3i4bRQYzmy5NOjAH9uLmbF5rNAzWfrlAQWZzJH2Ec6YEyRAiFWO/DIPN4Ed4/8So1yosoXG+xYI9L0Ky6SIwBzm/MYSWV9zE2tZ27V6r0uBF7FOrOQE4yPQFNqV5us7yKv6pRS9WjomDelJs1Nal0fA51MkPowW63pWd+TsJrbukUeJohFkvdwOtrJHTpD4qJpVAoIf0KczOG3T9eINBfJwqUrJFIDn9/nvOejxEMO6mu1Sh7qEp8H9P4KiMcZ17ywc/1sbkJMtU8L1NLOvcs4u8iqxknWtICK/x2A/vr0wwHAEug3JhtQ4/AzDalk9CnoeFLRlQFJR6esZWAuyJrpbmKiGJIHPcCdgZKz9hayyJTVSynbRj9QwpOAPPwBjHP13b/d0gkUyS2PRRZ1sNC7WdQfx0UnVqW8cxwoBQCUdQAT9yU/m/xd3CT7EqBeIzQzG/1T0ZbIf28s0fX6JEpWMkPRg40v9v8NjN+Dxv6QyrrgzK7AfV/JN6IUSfIPqyjb7l1Z7JfHMuhWzLJ9/c6F6ImXCX9O0aaVtG2YT8aCUZ53R9MvSvcroHC6+6DoKVv8SmvBmCP5KS19+e/9dNK7RVsl72wlY3HRlJ85CnIVOHqr+c1OQEyQRu0oYMNXSe2aUoxyEDALMDtjIhoD1Bc9o6y9KSxssdRDWL0MvGM+5xzs5dxMx4sl/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(47076005)(82740400003)(15650500001)(4326008)(26005)(356005)(83380400001)(81166007)(6916009)(478600001)(36860700001)(70586007)(70206006)(7696005)(36756003)(186003)(316002)(82310400003)(54906003)(8936002)(6666004)(426003)(2906002)(336012)(2616005)(86362001)(8676002)(5660300002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:15.6776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3497c754-eda1-4109-e436-08d8f0a36040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Some display endpoints may be dynamically mapped to the link encoders
which drive them.

[How]
Update the code paths for display enabling/disabling to accommodate
the dynamic association between links and link encoders.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 15 ++-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 99 +++++++++++++++++++
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 22 ++++-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h | 18 ++++
 4 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cebf68200f43..0b8082a15e24 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1728,11 +1728,16 @@ bool perform_link_training_with_retries(
 		if (link->aux_access_disabled) {
 			dc_link_dp_perform_link_training_skip_aux(link, link_setting);
 			return true;
-		} else if (dc_link_dp_perform_link_training(
-				link,
-				link_setting,
-				skip_video_pattern) == LINK_TRAINING_SUCCESS)
-			return true;
+		} else {
+			enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
+
+				status = dc_link_dp_perform_link_training(
+										link,
+										link_setting,
+										skip_video_pattern);
+			if (status == LINK_TRAINING_SUCCESS)
+				return true;
+		}
 
 		/* latest link training still fail, skip delay and keep PHY on
 		 */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index c2bf9e5d9675..1361b87d86d7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -127,6 +127,32 @@ static enum engine_id find_first_avail_link_enc(
 	return eng_id;
 }
 
+/* Return stream using DIG link encoder resource. NULL if unused. */
+static struct dc_stream_state *get_stream_using_link_enc(
+		struct dc_state *state,
+		enum engine_id eng_id)
+{
+	struct dc_stream_state *stream = NULL;
+	int stream_idx = -1;
+	int i;
+
+	for (i = 0; i < state->stream_count; i++) {
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+
+		if (assignment.valid && (assignment.eng_id == eng_id)) {
+			stream_idx = i;
+			break;
+		}
+	}
+
+	if (stream_idx != -1)
+		stream = state->streams[stream_idx];
+	else
+		dm_output_to_console("%s: No stream using DIG(%d).\n", __func__, eng_id);
+
+	return stream;
+}
+
 void link_enc_cfg_init(
 		struct dc *dc,
 		struct dc_state *state)
@@ -202,3 +228,76 @@ void link_enc_cfg_link_enc_unassign(
 
 	update_link_enc_assignment(state, stream, eng_id, false);
 }
+
+bool link_enc_cfg_is_transmitter_mappable(
+		struct dc_state *state,
+		struct link_encoder *link_enc)
+{
+	bool is_mappable = false;
+	enum engine_id eng_id = link_enc->preferred_engine;
+	struct dc_stream_state *stream = get_stream_using_link_enc(state, eng_id);
+
+	if (stream)
+		is_mappable = stream->link->is_dig_mapping_flexible;
+
+	return is_mappable;
+}
+
+struct dc_link *link_enc_cfg_get_link_using_link_enc(
+		struct dc_state *state,
+		enum engine_id eng_id)
+{
+	struct dc_link *link = NULL;
+	int stream_idx = -1;
+	int i;
+
+	for (i = 0; i < state->stream_count; i++) {
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+
+		if (assignment.valid && (assignment.eng_id == eng_id)) {
+			stream_idx = i;
+			break;
+		}
+	}
+
+	if (stream_idx != -1)
+		link = state->streams[stream_idx]->link;
+	else
+		dm_output_to_console("%s: No link using DIG(%d).\n", __func__, eng_id);
+
+	return link;
+}
+
+struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
+		struct dc_state *state,
+		struct dc_link *link)
+{
+	struct link_encoder *link_enc = NULL;
+	struct display_endpoint_id ep_id;
+	int stream_idx = -1;
+	int i;
+
+	ep_id = (struct display_endpoint_id) {
+		.link_id = link->link_id,
+		.ep_type = link->ep_type};
+
+	for (i = 0; i < state->stream_count; i++) {
+		struct link_enc_assignment assignment = state->res_ctx.link_enc_assignments[i];
+
+		if (assignment.valid &&
+				assignment.ep_id.link_id.id == ep_id.link_id.id &&
+				assignment.ep_id.link_id.enum_id == ep_id.link_id.enum_id &&
+				assignment.ep_id.link_id.type == ep_id.link_id.type &&
+				assignment.ep_id.ep_type == ep_id.ep_type) {
+			stream_idx = i;
+			break;
+		}
+	}
+
+	if (stream_idx != -1)
+		link_enc = state->streams[stream_idx]->link_enc;
+	else
+		dm_output_to_console("%s: No link encoder used by link(%d).\n", __func__, link->link_index);
+
+	return link_enc;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 22fe19ee842d..48ad1a8d4a74 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -14,6 +14,7 @@
 #include "dpcd_defs.h"
 #include "dsc.h"
 #include "resource.h"
+#include "link_enc_cfg.h"
 #include "clk_mgr.h"
 
 static uint8_t convert_to_count(uint8_t lttpr_repeater_count)
@@ -95,7 +96,7 @@ void dp_enable_link_phy(
 	enum clock_source_id clock_source,
 	const struct dc_link_settings *link_settings)
 {
-	struct link_encoder *link_enc = link->link_enc;
+	struct link_encoder *link_enc;
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 
@@ -105,6 +106,13 @@ void dp_enable_link_phy(
 			link->dc->res_pool->dp_clock_source;
 	unsigned int i;
 
+	/* Link should always be assigned encoder when en-/disabling. */
+	if (link->is_dig_mapping_flexible && dc->res_pool->funcs->link_encs_assign)
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+	else
+		link_enc = link->link_enc;
+	ASSERT(link_enc);
+
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		link->dc->hwss.edp_power_control(link, true);
 		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
@@ -227,6 +235,14 @@ void dp_disable_link_phy(struct dc_link *link, enum signal_type signal)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
+	struct link_encoder *link_enc;
+
+	/* Link should always be assigned encoder when en-/disabling. */
+	if (link->is_dig_mapping_flexible && dc->res_pool->funcs->link_encs_assign)
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+	else
+		link_enc = link->link_enc;
+	ASSERT(link_enc);
 
 	if (!link->wa_flags.dp_keep_receiver_powered)
 		dp_receiver_power_ctrl(link, false);
@@ -234,13 +250,13 @@ void dp_disable_link_phy(struct dc_link *link, enum signal_type signal)
 	if (signal == SIGNAL_TYPE_EDP) {
 		if (link->dc->hwss.edp_backlight_control)
 			link->dc->hwss.edp_backlight_control(link, false);
-		link->link_enc->funcs->disable_output(link->link_enc, signal);
+		link_enc->funcs->disable_output(link_enc, signal);
 		link->dc->hwss.edp_power_control(link, false);
 	} else {
 		if (dmcu != NULL && dmcu->funcs->lock_phy)
 			dmcu->funcs->lock_phy(dmcu);
 
-		link->link_enc->funcs->disable_output(link->link_enc, signal);
+		link_enc->funcs->disable_output(link_enc, signal);
 
 		if (dmcu != NULL && dmcu->funcs->unlock_phy)
 			dmcu->funcs->unlock_phy(dmcu);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index ad641632eadd..7d36e55f3097 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -65,4 +65,22 @@ void link_enc_cfg_link_enc_unassign(
 		struct dc_state *state,
 		struct dc_stream_state *stream);
 
+/*
+ * Check whether the transmitter driven by a link encoder is a mappable
+ * endpoint.
+ */
+bool link_enc_cfg_is_transmitter_mappable(
+		struct dc_state *state,
+		struct link_encoder *link_enc);
+
+/* Return link using DIG link encoder resource. NULL if unused. */
+struct dc_link *link_enc_cfg_get_link_using_link_enc(
+		struct dc_state *state,
+		enum engine_id eng_id);
+
+/* Return DIG link encoder used by link. NULL if unused. */
+struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
+		struct dc_state *state,
+		struct dc_link *link);
+
 #endif /* DC_INC_LINK_ENC_CFG_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
