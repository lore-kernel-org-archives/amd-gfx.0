Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D404C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05F610EA68;
	Mon,  7 Mar 2022 05:50:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C287F10EA68
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOiwNdGC15zHfsQoA5UUm4JcFt/FyRiSJuXnf8W8tnPx1KiHjg8iTam3HpfNobspRmIGOFINJH4odsZYtgVaUVWfpDaxMgERzSlRq8fTvVHHTz2jhve80B9vzZJnKU7ND5hDO4Qt08bwx/nyM/98/+A07AESlqrviSxmjeouUoUssRNFi/fYAH/CFsXJ4q87afSc3oaqDQUDdPoOLF1dCWeBgo/E+BD1a/H28Ppk/7IhoREnhizd7PRsAZTsYaVR9IKfmjvKdDtyF9RXnuBUeZ0WhE8HfPP4UQ3J4Q2P2MlZvKbQZz3TE7bHRPPz281fdpj5ij+NwwogzSueeBUt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6gtuY9i5dePc2L1t7jwarGhLQSgqOuEQKUA9tXoE2k=;
 b=Gr9GbEaUEPab3F0P4Ih9QmWmaiG2mM9edQ1xDUwk2+LrwhNqujOIC+qWU/8wtZpTYErsm+7pBHtEGRLniw2xRl1qOzKEdrjlXhoigvTgLpk+XcQNUbUFVwtAyhVpHM3B2zAuc9bDk138GrvcMVAAJ35NaYa6GHowiNI8Bu3mJDoq8fngEQheljvRYVX+tENdEmUx537ctvAGX4lQu4+ye7Vj0tpeYcgO6ffOT6qgTTtwIRT6TOyHI6gnUdqvhSa3TIX66f5+jWGNRiA7x6EEW4kOtGQIHMQzgvhdI1/2DAS3gs5HsS0HjBj2Bx7a9gXSbrW60Yp8DDibU6H7IjV7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6gtuY9i5dePc2L1t7jwarGhLQSgqOuEQKUA9tXoE2k=;
 b=2+9k/3+wetSrzT1odzmMvQYAsiHcA36dE6vSsPS4pkXfXBoCCZrJ+y1rXbhfj2zCrIUOdBii1msq5C43woaWsfSVIjifIffXfGH6oLW+tOd5taYmXVDkcWMQ3Bgu0kV+1t+E+bEYQaEP1Ax2eOJ30V1oT2ZgW7ljycDmzwEkFLo=
Received: from DS7PR03CA0283.namprd03.prod.outlook.com (2603:10b6:5:3ad::18)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 05:50:31 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::48) by DS7PR03CA0283.outlook.office365.com
 (2603:10b6:5:3ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:50:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:50:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:50:29 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:50:26 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/21] drm/amd/display: Add link dp trace support
Date: Tue, 8 Mar 2022 05:09:31 +0800
Message-ID: <20220307210942.444808-9-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81981b63-8242-4203-9ead-08d9fffe63de
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43424B7021AB777EC2BDCEC1F5089@MN2PR12MB4342.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzRJywWEsdzMdd30rGlZ/nEvJBxZvnmBAKG/DH3nKh/pYuLrWXdxzJz75u45n1mbVILPY743gWQ5oxRwaxQ1o+oUqOK7vNaYROUHFEukawb7r8e59qTYLCg/7qX0OW8xGb+yXtX6dYcL4UNLPJWaQ1feqI+UD5Ey43uz8E5J4N9PVwQ96HYAzyVhkNfrIjEM95oMESZyV7Kb5qSB2NQI37IyraI0c0UFGKOtiueQUuN4vJWF3lVKcvF4LZKAT2dXK3MS5u7JvJu763aBvVYeNACRH5pUH8gkP+obTBhOxvy409gHSJTml66nnEDlZsR9+9IugGXfnsdsfddjWwp5ukW2q8fpRWRqR6KXIKdtQBEJD9aMugjsxi6bVyRwcMDiUh0fyuI0mKbeL02e8u8PYwqJLvdzgNK/Jqgq695viX/p7OObs/Bk5/V01j5szZnZs2CHiak6dOEzZ58AiqKbGSRUh3uNLoiAw/lHA6OVGUQ4cA1d+n3hxRcDJ4VQvy3hZUC/Zxx/lRCaTD3ARgiQK8k7jBtk1EQMRn6s+mxCghZklCVqDfRup3r/sodivUXX2o8bRhZopHtSHp+B5JpqnNF8yCVvTFnlvIu/Vggq10r/DcYjpFfLlt0QWP3Jieg0RP8Eun1nfjyhOeJLjQveNKjR95/2yzOiuaKlqLfPUTPdt6IGB0njVnPqTmQY5d0DxufNj8MSgPBMfnrLPVIcQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(7696005)(1076003)(4326008)(30864003)(82310400004)(8936002)(508600001)(36756003)(5660300002)(336012)(8676002)(83380400001)(26005)(186003)(2616005)(426003)(70586007)(70206006)(36860700001)(356005)(316002)(6916009)(54906003)(81166007)(86362001)(6666004)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:50:31.1008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81981b63-8242-4203-9ead-08d9fffe63de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
It is nice to have link training and link loss status logging in
our trace, and this patch add the all necessary accessors in dc
side.

[How]
1. Define dp_trace struct and create new file link_dp_trace.c and
link_dp_trace.h;
2. Add dp link training status update in dc_link_dp.c;

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   5 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  24 ++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  36 +++++
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   2 +-
 .../drm/amd/display/dc/link/link_dp_trace.c   | 146 ++++++++++++++++++
 .../drm/amd/display/dc/link/link_dp_trace.h   |  57 +++++++
 6 files changed, 268 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_trace.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_trace.h

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b2ed2b683ba5..1951a92e3417 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -50,6 +50,7 @@
 #include "inc/hw/panel_cntl.h"
 #include "inc/link_enc_cfg.h"
 #include "inc/link_dpcd.h"
+#include "link/link_dp_trace.h"
 
 #include "dc/dcn30/dcn30_vpg.h"
 
@@ -1255,6 +1256,9 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		    !sink->edid_caps.edid_hdmi)
 			sink->sink_signal = SIGNAL_TYPE_DVI_SINGLE_LINK;
 
+		if (link->local_sink && dc_is_dp_signal(sink_caps.signal))
+			dp_trace_init(link);
+
 		/* Connectivity log: detection */
 		for (i = 0; i < sink->dc_edid.length / DC_EDID_BLOCK_SIZE; i++) {
 			CONN_DATA_DETECT(link,
@@ -1307,6 +1311,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		link->dongle_max_pix_clk = 0;
 
 		dc_link_clear_dprx_states(link);
+		dp_trace_reset(link);
 	}
 
 	LINK_INFO("link=%d, dc_sink_in=%p is now %s prev_sink=%p edid same=%d\n",
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6a213467c97c..0e84c54dc67e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -39,6 +39,7 @@
 #include "dce/dmub_hw_lock_mgr.h"
 #include "inc/dc_link_dpia.h"
 #include "inc/link_enc_cfg.h"
+#include "link/link_dp_trace.h"
 
 /*Travis*/
 static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
@@ -2776,6 +2777,10 @@ bool perform_link_training_with_retries(
 	enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
 	struct dc_link_settings current_setting = *link_setting;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+	int fail_count = 0;
+
+	dp_trace_commit_lt_init(link);
+
 
 	if (dp_get_link_encoding_format(&current_setting) == DP_8b_10b_ENCODING)
 		/* We need to do this before the link training to ensure the idle
@@ -2783,6 +2788,7 @@ bool perform_link_training_with_retries(
 		 */
 		link_hwss->setup_stream_encoder(pipe_ctx);
 
+	dp_trace_set_lt_start_timestamp(link, false);
 	for (j = 0; j < attempts; ++j) {
 
 		DC_LOG_HW_LINK_TRAINING("%s: Beginning link training attempt %u of %d\n",
@@ -2838,10 +2844,15 @@ bool perform_link_training_with_retries(
 						skip_video_pattern);
 			}
 
+			dp_trace_lt_total_count_increment(link, false);
+			dp_trace_lt_result_update(link, status, false);
+			dp_trace_set_lt_end_timestamp(link, false);
 			if (status == LINK_TRAINING_SUCCESS)
 				return true;
 		}
 
+		fail_count++;
+		dp_trace_lt_fail_count_update(link, fail_count, false);
 		/* latest link training still fail, skip delay and keep PHY on
 		 */
 		if (j == (attempts - 1) && link->ep_type == DISPLAY_ENDPOINT_PHY)
@@ -3309,6 +3320,8 @@ static bool dp_verify_link_cap(
 		} else {
 			(*fail_count)++;
 		}
+		dp_trace_lt_total_count_increment(link, true);
+		dp_trace_lt_result_update(link, status, true);
 		dp_disable_link_phy(link, &link_res, link->connector_signal);
 	} while (!success && decide_fallback_link_setting(link,
 			initial_link_settings, &cur_link_settings, status));
@@ -3340,13 +3353,16 @@ bool dp_verify_link_cap_with_retries(
 {
 	int i = 0;
 	bool success = false;
+	int fail_count = 0;
+
+	dp_trace_detect_lt_init(link);
 
 	if (link->link_enc && link->link_enc->features.flags.bits.DP_IS_USB_C &&
 			link->dc->debug.usbc_combo_phy_reset_wa)
 		apply_usbc_combo_phy_reset_wa(link, known_limit_link_setting);
 
+	dp_trace_set_lt_start_timestamp(link, false);
 	for (i = 0; i < attempts; i++) {
-		int fail_count = 0;
 		enum dc_connection_type type = dc_connection_none;
 
 		memset(&link->verified_link_cap, 0,
@@ -3361,6 +3377,10 @@ bool dp_verify_link_cap_with_retries(
 		}
 		msleep(10);
 	}
+
+	dp_trace_lt_fail_count_update(link, fail_count, true);
+	dp_trace_set_lt_end_timestamp(link, true);
+
 	return success;
 }
 
@@ -4627,6 +4647,8 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 		status = false;
 		if (out_link_loss)
 			*out_link_loss = true;
+
+		dp_trace_link_loss_increment(link);
 	}
 
 	if (link->type == dc_connection_sst_branch &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index ce6e8d013459..78e66e4bab5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -76,6 +76,28 @@ struct link_trace {
 	struct time_stamp time_stamp;
 };
 
+struct dp_trace_lt_counts {
+	unsigned int total;
+	unsigned int fail;
+};
+
+struct dp_trace_lt {
+	struct dp_trace_lt_counts counts;
+	struct dp_trace_timestamps {
+		unsigned long long start;
+		unsigned long long end;
+	} timestamps;
+	enum link_training_result result;
+	bool is_logged;
+};
+
+struct dp_trace {
+	struct dp_trace_lt detect_lt_trace;
+	struct dp_trace_lt commit_lt_trace;
+	unsigned int link_loss_count;
+	bool is_initialized;
+};
+
 /* PSR feature flags */
 struct psr_settings {
 	bool psr_feature_enabled;		// PSR is supported by sink
@@ -121,6 +143,8 @@ struct dc_link {
 
 	bool edp_sink_present;
 
+	struct dp_trace dp_trace;
+
 	/* caps is the same as reported_link_cap. link_traing use
 	 * reported_link_cap. Will clean up.  TODO
 	 */
@@ -470,4 +494,16 @@ void dc_link_clear_dprx_states(struct dc_link *link);
 struct gpio *get_hpd_gpio(struct dc_bios *dcb,
 		struct graphics_object_id link_id,
 		struct gpio_service *gpio_service);
+void dp_trace_reset(struct dc_link *link);
+bool dc_dp_trace_is_initialized(struct dc_link *link);
+unsigned long long dc_dp_trace_get_lt_end_timestamp(struct dc_link *link,
+		bool in_detection);
+void dc_dp_trace_set_is_logged_flag(struct dc_link *link,
+		bool in_detection,
+		bool is_logged);
+bool dc_dp_trace_is_logged(struct dc_link *link,
+		bool in_detection);
+struct dp_trace_lt_counts *dc_dp_trace_get_lt_counts(struct dc_link *link,
+		bool in_detection);
+unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link);
 #endif /* DC_LINK_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index c4a69ba7cb62..054c2a727eb2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -23,7 +23,7 @@
 # It abstracts the control and status of back end pipe such as DIO, HPO, DPIA,
 # PHY, HPD, DDC and etc).
 
-LINK = link_hwss_dio.o link_hwss_dpia.o link_hwss_hpo_dp.o
+LINK = link_hwss_dio.o link_hwss_dpia.o link_hwss_hpo_dp.o link_dp_trace.o
 
 AMD_DAL_LINK = $(addprefix $(AMDDALPATH)/dc/link/,$(LINK))
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_trace.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_trace.c
new file mode 100644
index 000000000000..e7047391934b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_trace.c
@@ -0,0 +1,146 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#include "dc_link.h"
+#include "link_dp_trace.h"
+
+void dp_trace_init(struct dc_link *link)
+{
+	memset(&link->dp_trace, 0, sizeof(link->dp_trace));
+	link->dp_trace.is_initialized = true;
+}
+
+void dp_trace_reset(struct dc_link *link)
+{
+	memset(&link->dp_trace, 0, sizeof(link->dp_trace));
+}
+
+bool dc_dp_trace_is_initialized(struct dc_link *link)
+{
+	return link->dp_trace.is_initialized;
+}
+
+void dp_trace_detect_lt_init(struct dc_link *link)
+{
+	memset(&link->dp_trace.detect_lt_trace, 0, sizeof(link->dp_trace.detect_lt_trace));
+}
+
+void dp_trace_commit_lt_init(struct dc_link *link)
+{
+	memset(&link->dp_trace.commit_lt_trace, 0, sizeof(link->dp_trace.commit_lt_trace));
+}
+
+void dp_trace_link_loss_increment(struct dc_link *link)
+{
+	link->dp_trace.link_loss_count++;
+}
+
+void dp_trace_lt_fail_count_update(struct dc_link *link,
+		unsigned int fail_count,
+		bool in_detection)
+{
+	if (in_detection)
+		link->dp_trace.detect_lt_trace.counts.fail = fail_count;
+	else
+		link->dp_trace.commit_lt_trace.counts.fail = fail_count;
+}
+
+void dp_trace_lt_total_count_increment(struct dc_link *link,
+		bool in_detection)
+{
+	if (in_detection)
+		link->dp_trace.detect_lt_trace.counts.total++;
+	else
+		link->dp_trace.commit_lt_trace.counts.total++;
+}
+
+void dc_dp_trace_set_is_logged_flag(struct dc_link *link,
+		bool in_detection,
+		bool is_logged)
+{
+	if (in_detection)
+		link->dp_trace.detect_lt_trace.is_logged = is_logged;
+	else
+		link->dp_trace.commit_lt_trace.is_logged = is_logged;
+}
+
+bool dc_dp_trace_is_logged(struct dc_link *link,
+		bool in_detection)
+{
+	if (in_detection)
+		return link->dp_trace.detect_lt_trace.is_logged;
+	else
+		return link->dp_trace.commit_lt_trace.is_logged;
+}
+
+void dp_trace_lt_result_update(struct dc_link *link,
+		enum link_training_result result,
+		bool in_detection)
+{
+	if (in_detection)
+		link->dp_trace.detect_lt_trace.result = result;
+	else
+		link->dp_trace.commit_lt_trace.result = result;
+}
+
+void dp_trace_set_lt_start_timestamp(struct dc_link *link,
+		bool in_detection)
+{
+	if (in_detection)
+		link->dp_trace.detect_lt_trace.timestamps.start = dm_get_timestamp(link->dc->ctx);
+	else
+		link->dp_trace.commit_lt_trace.timestamps.start = dm_get_timestamp(link->dc->ctx);
+}
+
+void dp_trace_set_lt_end_timestamp(struct dc_link *link,
+		bool in_detection)
+{
+	if (in_detection)
+		link->dp_trace.detect_lt_trace.timestamps.end = dm_get_timestamp(link->dc->ctx);
+	else
+		link->dp_trace.commit_lt_trace.timestamps.end = dm_get_timestamp(link->dc->ctx);
+}
+
+unsigned long long dc_dp_trace_get_lt_end_timestamp(struct dc_link *link,
+		bool in_detection)
+{
+	if (in_detection)
+		return link->dp_trace.detect_lt_trace.timestamps.end;
+	else
+		return link->dp_trace.commit_lt_trace.timestamps.end;
+}
+
+struct dp_trace_lt_counts *dc_dp_trace_get_lt_counts(struct dc_link *link,
+		bool in_detection)
+{
+	if (in_detection)
+		return &link->dp_trace.detect_lt_trace.counts;
+	else
+		return &link->dp_trace.commit_lt_trace.counts;
+}
+
+unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link)
+{
+	return link->dp_trace.link_loss_count;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_trace.h b/drivers/gpu/drm/amd/display/dc/link/link_dp_trace.h
new file mode 100644
index 000000000000..702f97c6ead0
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_trace.h
@@ -0,0 +1,57 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#ifndef __LINK_DP_TRACE_H__
+#define __LINK_DP_TRACE_H__
+
+void dp_trace_init(struct dc_link *link);
+void dp_trace_reset(struct dc_link *link);
+bool dc_dp_trace_is_initialized(struct dc_link *link);
+void dp_trace_detect_lt_init(struct dc_link *link);
+void dp_trace_commit_lt_init(struct dc_link *link);
+void dp_trace_link_loss_increment(struct dc_link *link);
+void dp_trace_lt_fail_count_update(struct dc_link *link,
+		unsigned int fail_count,
+		bool in_detection);
+void dp_trace_lt_total_count_increment(struct dc_link *link,
+		bool in_detection);
+void dc_dp_trace_set_is_logged_flag(struct dc_link *link,
+		bool in_detection,
+		bool is_logged);
+bool dc_dp_trace_is_logged(struct dc_link *link,
+		bool in_detection);
+void dp_trace_lt_result_update(struct dc_link *link,
+		enum link_training_result result,
+		bool in_detection);
+void dp_trace_set_lt_start_timestamp(struct dc_link *link,
+		bool in_detection);
+void dp_trace_set_lt_end_timestamp(struct dc_link *link,
+		bool in_detection);
+unsigned long long dc_dp_trace_get_lt_end_timestamp(struct dc_link *link,
+		bool in_detection);
+struct dp_trace_lt_counts *dc_dp_trace_get_lt_counts(struct dc_link *link,
+		bool in_detection);
+unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link);
+
+#endif /* __LINK_DP_TRACE_H__ */
-- 
2.25.1

