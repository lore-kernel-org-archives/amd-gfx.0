Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17636C433ED
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC77261029
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC77261029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82EAC6E4D0;
	Sat, 10 Apr 2021 02:04:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A836D6E0E9
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvkqvObjSCj7LSuSh11YOmNp3zZjB4/Qj3c8sj8s7y3GnjMrxT/tKtH9NXvL7ZErbKbReU8gG1kBhuxeepbtr1EUc77RFCk1yom0ytijC31UImgNgS+ZSu989DMbl1CgzJEs6fqwoPhoPDTRYufqmhk5+jfhq8bekHj6ZcTlBPHm3DLv/ISIP5Wa5KC5ouBYd/TOYQBgz9KPCQlsSsFPYiYEaXWnE+PW+KKJrOvO7PZZVl0V15D/eCCxZknbIOfpC2/wAo8PZaphHaGRShGWkjIjpPqUITdCRxt6SAovsdmKrSI+IZDMEVmbxxjyRMVOuTCeZxde2ULUh5MtDttoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuDr6M7xOVaTTnQCLzLsbZPw3EWryvWlRyDAsZQM8aY=;
 b=YF2pNC60Npqu5qGtWrACz0XmfPyVSGVuIV5Y6xNhJv16wFev1p0Pk3AEa7i6eJhkstJt4VShMNGyluld3zgSjcdiXj/xc/giWkSKOc82GoO4BV2HWJKQtF+yPBtvZESIj40niq3iL+Ds/4JXjRmfn4hFmmqq5Z65vOygjDutbZ5FHy1fph86s+Q93tI8ZAfJ/Xz352evPx9j9pSEduVRv+8XHIi3goIjUQx9FTlDHevKjci6bvvudCWsZ/wT1bD0M2bKJYVnyI6++CDPu0QcO+LhVi3cDHVMggFOYI01gzcTYGTZtE7whJ1w3YK4Z2NWbwHIXHHz3qTl9Mx/BUY0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuDr6M7xOVaTTnQCLzLsbZPw3EWryvWlRyDAsZQM8aY=;
 b=caS8di/xZpKaLWhUi5PC0Gt5/zZ/Ma1ft3th3B4nq8CsM2X9lv4m9OEhTZvptTNyA5jQJNas0p5TVyBxeXWD+gpZtB/XHNt4d6Exk8+ZidksJhxkr84PZ8Kb/rQpdS97U+7duFEIGdqTAKherJ1KrI6lnIglRQuXSONQrG+Gg3Y=
Received: from DM3PR03CA0003.namprd03.prod.outlook.com (2603:10b6:0:50::13) by
 MN2PR12MB3262.namprd12.prod.outlook.com (2603:10b6:208:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Sat, 10 Apr
 2021 02:04:44 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::f2) by DM3PR03CA0003.outlook.office365.com
 (2603:10b6:0:50::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:43 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:43 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: Disable boot optimizations if ILR
 optimzation is required
Date: Fri, 9 Apr 2021 22:03:47 -0400
Message-ID: <20210410020401.1100228-3-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4434ced-0215-444a-1547-08d8fbc502c2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3262:
X-Microsoft-Antispam-PRVS: <MN2PR12MB326215B6AA9745A33910252AF5729@MN2PR12MB3262.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkSuBkPh0W3j2WVDOxeacNyaQbhsJgoViiQMINfg79MO9J+ThAO06oFAYEUbjRGIwYOuLysctqymPuk4aAOeh9oYkH7H/Ir+p4Hu33U1XyTdGN2vWNMmriYThmrs4Aleud74UT67xhZGCHERsclHHb3JLyYTzk3h0e2Sh7a+0zLDiD+hiIU1QHr2gXPejhelfNxLS0b6oOywPdAnZ83PwbV1KPuK0tTIIACLFf+tq/1K7OaWK3X4zqtZhjACIKLzvGAQluAA36mVzxVzkqs4yOMd6AvleTEHGOEZ8A3rihRHqgsZVTkBveCEm7Ypd+8krJCi29Y370CofG3Wp+5zhf0CEOUOGVV2KjLiIoZ+YHuTVjsbliUB3c/y0k98wD+H58XLlR7eZV3Pe9wdCFXg70g8FUY4CnPw+7p/ROVD/zOB1kwNA6BNIOrrwc26KZjeyugBuB4pdu2U8Y9up3O+OittmXS6A/tcL3ACpSPEVKp3FeYM6B+Gy5czBt52EyVTFfhRTIDsIDXj4kVAy3jq7FlB8ZYHLUQTEpnXX2djS/7YhpiDYFjoYc4qs4wsH7FIlWr2ge8u6tZod/0kNyz2B131/MqW1YGg2RpoJhWtBBX70rT1kGUPQYBy+FnuI5IQzIIHyr86E+SXM7GZKv4GM96bwI0f1yVYYPRGQEKFRA/rRjh6kWNtJ1d2rPvGvr5l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(36840700001)(46966006)(26005)(356005)(2906002)(186003)(316002)(54906003)(83380400001)(36756003)(6916009)(4326008)(81166007)(36860700001)(82310400003)(86362001)(7696005)(2616005)(336012)(8676002)(426003)(82740400003)(8936002)(5660300002)(478600001)(1076003)(70206006)(47076005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:44.5318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4434ced-0215-444a-1547-08d8fbc502c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3262
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
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 Bindu Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[Why]
VBIOS currently sets the max link rate found in eDP 1.4 SUPPORTED_LINK_RATES table
If eDP fastboot optimizations are enabled, the link rate remains at max after init

[How]
Determine optimal link rate during boot, disable seamless boot
and eDP fastboot optimizations if link rate optimization is required

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 43 +++++++++++++++++++
 .../display/dc/dce110/dce110_hw_sequencer.c   |  6 ++-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  2 +
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8f0a13807d05..e74027a9354e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -55,6 +55,7 @@
 #include "link_encoder.h"
 #include "link_enc_cfg.h"
 
+#include "dc_link.h"
 #include "dc_link_ddc.h"
 #include "dm_helpers.h"
 #include "mem_input.h"
@@ -1429,6 +1430,10 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
 		return false;
 	}
 
+	if (is_edp_ilr_optimization_required(link, crtc_timing)) {
+		return false;
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5aa16114a676..2e4740648e3c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4718,3 +4718,46 @@ bool dc_link_set_default_brightness_aux(struct dc_link *link)
 	}
 	return false;
 }
+
+bool is_edp_ilr_optimization_required(struct dc_link *link, struct dc_crtc_timing *crtc_timing)
+{
+	struct dc_link_settings link_setting;
+	uint8_t link_bw_set;
+	uint8_t link_rate_set;
+	uint32_t req_bw;
+	union lane_count_set lane_count_set = { {0} };
+
+	ASSERT(link || crtc_timing); // invalid input
+
+	if (link->dpcd_caps.edp_supported_link_rates_count == 0 ||
+			!link->dc->debug.optimize_edp_link_rate)
+		return false;
+
+
+	// Read DPCD 00100h to find if standard link rates are set
+	core_link_read_dpcd(link, DP_LINK_BW_SET,
+				&link_bw_set, sizeof(link_bw_set));
+
+	if (link_bw_set)
+		return true;
+
+	// Read DPCD 00115h to find the edp link rate set used
+	core_link_read_dpcd(link, DP_LINK_RATE_SET,
+			    &link_rate_set, sizeof(link_rate_set));
+
+	// Read DPCD 00101h to find out the number of lanes currently set
+	core_link_read_dpcd(link, DP_LANE_COUNT_SET,
+				&lane_count_set.raw, sizeof(lane_count_set));
+
+	req_bw = dc_bandwidth_in_kbps_from_timing(crtc_timing);
+
+	decide_edp_link_settings(link, &link_setting, req_bw);
+
+	if (link->dpcd_caps.edp_supported_link_rates[link_rate_set] != link_setting.link_rate ||
+			lane_count_set.bits.LANE_COUNT_SET != link_setting.lane_count)
+		return true;
+
+	return false;
+}
+
+
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 873c6f2d2cd9..dd903b267ca5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -48,6 +48,7 @@
 #include "stream_encoder.h"
 #include "link_encoder.h"
 #include "link_hwss.h"
+#include "dc_link_dp.h"
 #include "clock_source.h"
 #include "clk_mgr.h"
 #include "abm.h"
@@ -1714,8 +1715,9 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 				/* Set optimization flag on eDP stream*/
 				if (edp_stream_num && edp_link->link_status.link_active) {
 					edp_stream = edp_streams[0];
-					edp_stream->apply_edp_fast_boot_optimization = true;
-					can_apply_edp_fast_boot = true;
+					can_apply_edp_fast_boot = !is_edp_ilr_optimization_required(edp_stream->link, &edp_stream->timing);
+					edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
+
 					break;
 				}
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index b970a32177af..d3901403c30b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -71,6 +71,8 @@ void detect_edp_sink_caps(struct dc_link *link);
 
 bool is_dp_active_dongle(const struct dc_link *link);
 
+bool is_edp_ilr_optimization_required(struct dc_link *link, struct dc_crtc_timing *crtc_timing);
+
 void dp_enable_mst_on_sink(struct dc_link *link, bool enable);
 
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
