Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05639C636D4
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E24C10E2EB;
	Sun, 12 Feb 2023 17:00:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D07910E2E7
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVm42A7Xmk2RNbSukhJs+Jn3BOpZHVpNGOSvdZyEU2gAPFSn/8ZlfPEly7QKa+A/oeq5TyDvWYlg64SlAYkczMIDnJL/Unw/yKiMr1W2PWIP6NBc9clx5RC32J/3Pf1SH2bGdlocW0+NEtKg6MCFI4amVWDJVH9GIKdNlY6SszuqPF/N6+xyJX2KeqnFKfpPOC7xOqTJ5lNGfc/fiSJBxk6F9gV6zCiCs5rUvFXXZ8lbZGSpkrJIRvZzg2fn9uZBefjSoClQc28txFKRZx7jxz/RNYRsGy9kcJw8v2JHcisjjqRkY/7gBzYcTIpCKpjSQSYw5iMXsL/laY8JIMnWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrbFyu9yzfFyKcDQGYU/WDIEK9rEUNDR4la6hyYoxtE=;
 b=JpUohSAQWnCzRKv+JtrtZR7f0V2ReUnTKvycucSdDAv2Ftkr5suOs17VMW8oky0ogEHYh4cTx5VeBbnBj61foO2p4B7NMYrLKEdAszpJDIls8wTV18e1uGmdEaBDMirXmD0czj2MU2GBOBfZowxogHXAI0KtgPByrmvUC7ncpn2l98P+v/EoIRHU73Kg/wpZsS2+v3pwKT3NBT5ODfzJD54YYI3tI5zaA1vv5WUb3CGaI+JH8B0dmyh1z0jCrAgQX4nvyanxmzWGt3aYDGBh1wGwaNR20JtP/KHHbK/mz45/9lcupmrQE1tVQWgWjLzf4Sl7CxtNy/4Un0lznubr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrbFyu9yzfFyKcDQGYU/WDIEK9rEUNDR4la6hyYoxtE=;
 b=AcCbiADe1WZJTX80lizDpOlg1tvZjES61rm0xcunEO+lp1y3IcfPriHSF1485TgDdrf/DRKe+1O/JxrJjL6F2HJcirkEevL0IO0Abjnl5Lf++qa4dJ7XQf61BwMDEtnwWaemaF80I0Wt9UWedA4kz9LHqgGHVVcxIGvvv7CisHM=
Received: from DS7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::30) by
 PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sun, 12 Feb
 2023 17:00:38 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::ff) by DS7P222CA0002.outlook.office365.com
 (2603:10b6:8:2e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:37 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:36 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/22] drm/amd/display: do not set RX back to SST mode for non
 0 mst stream count
Date: Sun, 12 Feb 2023 11:59:39 -0500
Message-ID: <20230212165955.1993601-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: ef034c3e-669a-4df1-8240-08db0d1aaa38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vrwJT7IM2cJGKjYcDN156W7rK+/GrdpjPu5qxnigcIovxJdSeUJFFKyGnL4MGWknACoiwT40TBunfBg/RsR0DTwgt+S4iSqOsWG2JzxV4RmdoT3LMWCi1D3/rMYwEsuh1aQlp75ZlVzRnd3EsoXCqJwLFPtqzMoCnHADSAq+35CtMKvPFoes1cZEg/ex8mw+PQhVF3bVCKTF0z76TmXKjZCOPHIm1jaayYNNUzaVf0v8w8EUKJJdt8yisVF9HOmQR4SUkXc3eFSzKiYoCCMsHZthdPhjDuTTWWRaRhVLoR40o+HIYvAq61SxxSIEXUR2BjGB8Py0MPKN4IS+4DgeoQqNhjwv7N/4AoBPZglpzYgIQWS1dPg7FROfh+OnfEZ83SiiW8vgLM2XcbZ3ucmIwcjj/XMeeJ76Y4j//nlOkVXlCXmcP+p8Vesz7kj+2G8tTnUKp9R4ZOrd7M75+8LeQbik9cpZDPigpUW6MpII4rnqQvq0KXuN3NUYFLrTwjT5eap6xV3bq1XGEKG5ToNSoGjfm2wxVwnDNuWy0pxpYm/j6UpuYyzcyvH+BsXYLfbMFUc7IL8ikOjMY01T+8TTVA/9MvSCu+Jiw/0LYLANNNuFe7dXhJywfjmapZibymsP0NAP9E8oLKXGEsbQDf5RmG3no5tocHUPRDex2qaH7b57bNxogVPsFhPn1YXHn78SZ2XtP0LKakT+RP5o0veg9zBHbtjUmziecTd5T4xpYM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(82310400005)(86362001)(44832011)(186003)(26005)(5660300002)(16526019)(47076005)(426003)(40460700003)(83380400001)(82740400003)(81166007)(36860700001)(36756003)(2616005)(2906002)(356005)(336012)(40480700001)(8676002)(4326008)(6916009)(70586007)(70206006)(478600001)(54906003)(316002)(8936002)(1076003)(66899018)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:37.8416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef034c3e-669a-4df1-8240-08db0d1aaa38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606
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
 Samson Tam <Samson.Tam@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
a recent regression has caused us to mistakenly switch RX back to SST mode
when there are remaining mst stream enabled to the link. We are missing
a condition check for stream count before setting RX back to SST mode.

[how]
Add stream count check condition back and do some further refactor so the
logic is easier to understand to prevent future coding error in this sequence.

Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 51 +++++++++----------
 .../display/dc/link/protocols/link_dp_phy.c   | 11 ----
 .../display/dc/link/protocols/link_dp_phy.h   |  4 --
 3 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 9cdfa7f7dc77..22538b4f529b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1783,37 +1783,36 @@ enum dc_status link_increase_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw_
 	return DC_OK;
 }
 
-static void disable_link(struct dc_link *link, const struct link_resource *link_res,
+static void disable_link_dp(struct dc_link *link,
+		const struct link_resource *link_res,
 		enum signal_type signal)
 {
-	/*
-	 * TODO: implement call for dp_set_hw_test_pattern
-	 * it is needed for compliance testing
-	 */
+	struct dc_link_settings link_settings = link->cur_link_settings;
 
-	/* Here we need to specify that encoder output settings
-	 * need to be calculated as for the set mode,
-	 * it will lead to querying dynamic link capabilities
-	 * which should be done before enable output
-	 */
+	if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST &&
+			link->mst_stream_alloc_table.stream_count > 0)
+		/* disable MST link only when last vc payload is deallocated */
+		return;
 
+	dp_disable_link_phy(link, link_res, signal);
+
+	if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+		/* set the sink to SST mode after disabling the link */
+		enable_mst_on_sink(link, false);
+
+	if (link_dp_get_encoding_format(&link_settings) ==
+			DP_8b_10b_ENCODING) {
+		dp_set_fec_enable(link, false);
+		dp_set_fec_ready(link, link_res, false);
+	}
+}
+
+static void disable_link(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
 	if (dc_is_dp_signal(signal)) {
-		/* SST DP, eDP */
-		struct dc_link_settings link_settings = link->cur_link_settings;
-		if (dc_is_dp_sst_signal(signal)) {
-			dp_disable_link_phy(link, link_res, signal);
-		} else {
-			dp_disable_link_phy_mst(link, link_res, signal);
-			/* set the sink to SST mode after disabling the link */
-			enable_mst_on_sink(link, false);
-		}
-		if (dc_is_dp_sst_signal(signal) ||
-				link->mst_stream_alloc_table.stream_count == 0) {
-			if (link_dp_get_encoding_format(&link_settings) == DP_8b_10b_ENCODING) {
-				dp_set_fec_enable(link, false);
-				dp_set_fec_ready(link, link_res, false);
-			}
-		}
+		disable_link_dp(link, link_res, signal);
 	} else if (signal != SIGNAL_TYPE_VIRTUAL) {
 		link->dc->hwss.disable_link_output(link, link_res, signal);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index ea3873dae3ad..cd9fb8126bcf 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -85,17 +85,6 @@ void dp_disable_link_phy(struct dc_link *link,
 		dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
 }
 
-void dp_disable_link_phy_mst(struct dc_link *link,
-		const struct link_resource *link_res,
-		enum signal_type signal)
-{
-	/* MST disable link only when no stream use the link */
-	if (link->mst_stream_alloc_table.stream_count > 0)
-		return;
-
-	dp_disable_link_phy(link, link_res, signal);
-}
-
 static inline bool is_immediate_downstream(struct dc_link *link, uint32_t offset)
 {
 	return (dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) ==
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
index 6ce0b7958d51..dba1f29df319 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
@@ -38,10 +38,6 @@ void dp_disable_link_phy(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
 
-void dp_disable_link_phy_mst(struct dc_link *link,
-		const struct link_resource *link_res,
-		enum signal_type signal);
-
 void dp_set_hw_lane_settings(
 		struct dc_link *link,
 		const struct link_resource *link_res,
-- 
2.25.1

