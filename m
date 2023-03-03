Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9ADC7EE2F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E4F10E6D6;
	Fri,  3 Mar 2023 15:48:23 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F51710E6D6
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFp1FCDzzrBk+r2rVvfyE0GrOES3ZzV2t4PVBFF4SiDtvBu50zS7fmGc7SFP+4bdDcVLPDM92a+Ojvs4LpOQGJ78FxUqmf59okJZSj3G/MvZGYZHKL+2bW2QhBcLvLtiDvRzWTr1KBOacRSeK87Osm3kGWym+jPn2ypoLMP6ertsoi1muwKCKRzKUG7IcaaiXBaOmj9t/g/dE5Rf8mdsLYFuVWb/wyIxS5HWcsq4vXHjBTgMIrygsYHPR0+IoY/kPc3lcXnEhacTOiVi6I0Lgd/E62eroDQ8v7l3UGtPePYVgocS4wQpS0hlkv3YobneFPYBxd3tDHAI32q66ix9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piwplXZRxaRa/APEsZluMVYT4IfnaeqgsjuHpnitNtc=;
 b=Jtl8ws+JWwwDFvqT9KGOc/Pl13K3xzAks54eqMTzkurvdIn5BA1Ega9Y+55KUXJcoEeKyVno5oh2KN/gvBpTz9kROiPCq6sXI8Ln7Ysy3rFZSgcT3gczy/LxSgPq51zuGos55zmDI36lDz2y55x6TeMtqVRYqNQBepqYK1l0GGO9jwHScYT/pbgcC7f9PmxHTUNjKKaXbKsj972zUq2v8Zht3pozK3fIGnl6s1vHFIdO4u/beVjMTGfhR4sfdfwy5pQiYk/+3MwmYAGI0G3gvkm4QhYRM2A0fQ9XLAFEVYJZEy0GSxDA2sgFF+0GrE5OwQAr1SLXhQgR30ZozFmfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piwplXZRxaRa/APEsZluMVYT4IfnaeqgsjuHpnitNtc=;
 b=FLGcCYl9WqFby0kfxsZciPWScSxf5mCfa90g8h6URcJfxohRBoU0EQxe0oz9o2VU7yDiUu51fH4v/4vQIJv1sPZ0oLc3UfhmOgbjeBtXKJ1p00HoAhezgVOsY8cfm+tPMC7maTTqCMyNhwHhzoVSn5Axm3dp6mg3f2+D4QovhUQ=
Received: from MW4PR04CA0154.namprd04.prod.outlook.com (2603:10b6:303:85::9)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 15:48:17 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::9c) by MW4PR04CA0154.outlook.office365.com
 (2603:10b6:303:85::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 15:48:17 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:47:54 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/33] drm/amd/display: move dc_link functions in link root
 folder to dc_link_exports
Date: Fri, 3 Mar 2023 10:40:03 -0500
Message-ID: <20230303154022.2667-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: fc214fd7-09b5-4bb5-cb62-08db1bfeb511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zeuVCkAkQGphnPTArTCqw8Srqs+RyAjU5Vzc6xyy/c1a4TdGI+d/a3Y8Aoxfyy9NuXTI4sHnSgv3P94j2xFcKkHvx24HTHRhhyoAKyv7VJvZp+aSLBd7vCBqODREx2N8WDrDi2gz/AM4ektwP9+We1XZPGX1UxcwBil9cT2d0P/GoULHyqAhROTwCIYJ0qrdj1C75QK2F4+Chyn+cYw/UTnhbBaWldxwzfDTbgfXlR2QZKQeDLABsDIeQwNhtg4DLGhB0NWmIjmF+etUdBZQg617QonTSA5ENat42ZCt1+q0WfWLibaWd//fj7JmZJT4zKSSQnbD/6bIN43mkyk+DZneJ3S3pF+Ffq1acw4EdqG7MjGClWPvW/gYywh6uSa6i49DP5hMDpawqLjIlD2YpK+Hs+YRsdZJ2FzILemYLmJFqlDmqkd02mhqIcyDtmY0fdkWubNhJyPAEfUCsK9OeFgTB4IxPQJK7A33L+s2bN9Nw54uWNo5wBD2sOUI0KaWEUG5Mj/tFGhq3surxwPgJDapTCbz7qKiW3N8EAmCNRkl+6de2YE9LGu7cvtLtfPU9QWCpgXjBaNn5GVyDf9z1uIdmNXerbuMSiqiT4dF/2x21uwSHxdxLo6l+Fr5S00GQ6G47Wld9FrtWSQA9T8PzcnSQl4ACB/1KGE1ogErGuvUzLte0pqYLibcd0yUqX6+Kg3lnoVEWTOh3Y5g6vnpK4XVFi+/TxKEQGKCobYvqgw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(47076005)(4326008)(6916009)(16526019)(426003)(336012)(86362001)(26005)(186003)(8676002)(5660300002)(70206006)(70586007)(36756003)(54906003)(356005)(83380400001)(41300700001)(40460700003)(316002)(40480700001)(2616005)(478600001)(8936002)(2906002)(36860700001)(1076003)(6666004)(82310400005)(82740400003)(81166007)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:48:17.5136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc214fd7-09b5-4bb5-cb62-08db1bfeb511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
link component should only have one interface serving dc.

[how]
We are moving dc_link functions exposed to DM to dc_link_exports
and unify link component interface in link.h with function pointer
to match the style of other dc component. This is the second step to move
dc_link functions under link root folder to dc_link_exports.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/link.h         |  6 ++++++
 .../gpu/drm/amd/display/dc/link/link_detection.c  |  4 ++--
 .../gpu/drm/amd/display/dc/link/link_detection.h  |  6 ++++++
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c   |  8 ++++----
 .../gpu/drm/amd/display/dc/link/link_factory.c    | 11 +++++++----
 6 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 79e763b8209d..b1fedef193a0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -264,3 +264,18 @@ unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link)
 {
 	return link->dc->link_srv->dp_trace_get_link_loss_count(link);
 }
+
+struct dc_sink *dc_link_add_remote_sink(
+		struct dc_link *link,
+		const uint8_t *edid,
+		int len,
+		struct dc_sink_init_data *init_data)
+{
+	return link->dc->link_srv->add_remote_sink(link, edid, len, init_data);
+}
+
+void dc_link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
+{
+	link->dc->link_srv->remove_remote_sink(link, sink);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index cfe6fc48b6e9..9c05333f62aa 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -49,6 +49,12 @@ struct link_init_data {
 };
 
 struct link_service {
+	struct dc_sink *(*add_remote_sink)(
+			struct dc_link *link,
+			const uint8_t *edid,
+			int len,
+			struct dc_sink_init_data *init_data);
+	void (*remove_remote_sink)(struct dc_link *link, struct dc_sink *sink);
 	void (*dp_handle_automated_test)(struct dc_link *link);
 	bool (*dp_set_test_pattern)(
 			struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 99279e1e7330..2a248ee0d70e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1327,7 +1327,7 @@ static bool link_add_remote_sink_helper(struct dc_link *dc_link, struct dc_sink
 	return true;
 }
 
-struct dc_sink *dc_link_add_remote_sink(
+struct dc_sink *link_add_remote_sink(
 		struct dc_link *link,
 		const uint8_t *edid,
 		int len,
@@ -1385,7 +1385,7 @@ struct dc_sink *dc_link_add_remote_sink(
 	return NULL;
 }
 
-void dc_link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
+void link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
 {
 	int i;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.h b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
index 1831636516fb..4b1731c4fd3d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
@@ -26,5 +26,11 @@
 #ifndef __DC_LINK_DETECTION_H__
 #define __DC_LINK_DETECTION_H__
 #include "link.h"
+struct dc_sink *link_add_remote_sink(
+		struct dc_link *link,
+		const uint8_t *edid,
+		int len,
+		struct dc_sink_init_data *init_data);
+void link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink);
 
 #endif /* __DC_LINK_DETECTION_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 0039928186ff..650ac2a608ef 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1000,7 +1000,7 @@ static void enable_stream_features(struct pipe_ctx *pipe_ctx)
 	}
 }
 
-static void dc_log_vcp_x_y(const struct dc_link *link, struct fixed31_32 avg_time_slots_per_mtp)
+static void log_vcp_x_y(const struct dc_link *link, struct fixed31_32 avg_time_slots_per_mtp)
 {
 	const uint32_t VCP_Y_PRECISION = 1000;
 	uint64_t vcp_x, vcp_y;
@@ -1516,7 +1516,7 @@ static enum dc_status allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	pbn = get_pbn_from_timing(pipe_ctx);
 	avg_time_slots_per_mtp = dc_fixpt_div(pbn, pbn_per_slot);
 
-	dc_log_vcp_x_y(link, avg_time_slots_per_mtp);
+	log_vcp_x_y(link, avg_time_slots_per_mtp);
 
 	if (link_hwss->ext.set_throttled_vcp_size)
 		link_hwss->ext.set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
@@ -1669,7 +1669,7 @@ static enum dc_status update_sst_payload(struct pipe_ctx *pipe_ctx,
 	if (!allocate) {
 		avg_time_slots_per_mtp = dc_fixpt_from_int(0);
 
-		dc_log_vcp_x_y(link, avg_time_slots_per_mtp);
+		log_vcp_x_y(link, avg_time_slots_per_mtp);
 
 		if (link_hwss->ext.set_throttled_vcp_size)
 			link_hwss->ext.set_throttled_vcp_size(pipe_ctx,
@@ -1720,7 +1720,7 @@ static enum dc_status update_sst_payload(struct pipe_ctx *pipe_ctx,
 			DP_128b_132b_ENCODING) {
 		avg_time_slots_per_mtp = link_calculate_sst_avg_time_slots_per_mtp(stream, link);
 
-		dc_log_vcp_x_y(link, avg_time_slots_per_mtp);
+		log_vcp_x_y(link, avg_time_slots_per_mtp);
 
 		if (link_hwss->ext.set_throttled_vcp_size)
 			link_hwss->ext.set_throttled_vcp_size(pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 88fbd04e92f2..e37f271a6c72 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -27,6 +27,7 @@
  * This file owns the creation/destruction of link structure.
  */
 #include "link_factory.h"
+#include "link_detection.h"
 #include "accessories/link_dp_cts.h"
 #include "accessories/link_dp_trace.h"
 #include "accessories/link_fpga.h"
@@ -43,6 +44,8 @@
 		__VA_ARGS__)
 
 static struct link_service link_srv = {
+	.add_remote_sink = link_add_remote_sink,
+	.remove_remote_sink = link_remove_remote_sink,
 	.dp_handle_automated_test = dp_handle_automated_test,
 	.dp_set_test_pattern = dp_set_test_pattern,
 	.dp_set_preferred_link_settings = dp_set_preferred_link_settings,
@@ -197,7 +200,7 @@ static enum channel_id get_ddc_line(struct dc_link *link)
 	return channel;
 }
 
-static bool dc_link_construct_phy(struct dc_link *link,
+static bool construct_phy(struct dc_link *link,
 			      const struct link_init_data *init_params)
 {
 	uint8_t i;
@@ -489,7 +492,7 @@ static bool dc_link_construct_phy(struct dc_link *link,
 	return false;
 }
 
-static bool dc_link_construct_dpia(struct dc_link *link,
+static bool construct_dpia(struct dc_link *link,
 			      const struct link_init_data *init_params)
 {
 	struct ddc_service_init_data ddc_service_init_data = { 0 };
@@ -559,9 +562,9 @@ static bool link_construct(struct dc_link *link,
 {
 	/* Handle dpia case */
 	if (init_params->is_dpia_link == true)
-		return dc_link_construct_dpia(link, init_params);
+		return construct_dpia(link, init_params);
 	else
-		return dc_link_construct_phy(link, init_params);
+		return construct_phy(link, init_params);
 }
 
 struct dc_link *link_create(const struct link_init_data *init_params)
-- 
2.34.1

