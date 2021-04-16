Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E78C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EE3610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EE3610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50036EB91;
	Fri, 16 Apr 2021 14:34:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 168A66EB87
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/aQMZv2/yH/Bh/oHQYzxq78XrLGLe7K7XT42jkibA8RHb9P8wWiLa3xEkWyIiOcbL+1gomzesrFwjXuxENi/E4fCpx5bBJES8x/TbGu+kqfaNkSNeF/1JI90Wn18i83TzW4A5Rkvi4T9wTPmk+t90KRyN9B8VwaJVr2YAU9dr6dmbn25vqoscRtVP/YtaRf3X708wQpkprulcD9ktRQQlwYNMWJPNVv1hg9bM8fcNSeChXErTvJgdbMgGLNKZChCBSy06zv2FEUr9acMRT0hZXq3V86kKh8b0dB3bsp48WtNOversJo2Q8XCx1GvdzXazFlJ7wbeGTfSXXe9rE0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TyyH0iQ2qJwxYFdaHHw3Yr3NJm90djBymd1ZPhtbFs=;
 b=fvZSqcrJzO+h1S9sfZoCjF8J9Nodi+SvSjkzLYPNk7B1wX5zRq3lw2AsRlM3SHrrb9ApBg7wHinjt1zFpjgKJBJa8fLSor5rr6ykBVVX5KHOOOwyOTXj7RDNUGMLhJ8+yb97CgrpEVq7ZwtXLm/2OsqNsJOc1K7KEhZ8ehBwTcIhAm9qw2WLwybgVLa8ybfgklsoSG9eZUGcaXAEhcU0aRTwIr1e99WyE8ClGuw8bUGU+TcHqeCmZIo2N3u6cDtM6PloiuwlrZy5u4yWut3QdJpiqH961sodZ2XzqosWmEtEwHtc/M8svrNkbHAUWtqxPXnczfNh8jKxFawMinsGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TyyH0iQ2qJwxYFdaHHw3Yr3NJm90djBymd1ZPhtbFs=;
 b=JsWaZoZ1pxGwJOovDE2J2YABWUmsDmavL7fx8yg7/eqMrsj9rd1ooOdgqcqYJQhuXpUVHqWFLyHMMn4pncmx+Dra6lg+GtxQEpPUUn+gVgR/FR1Bb/Kuj/XSd2cBN7VYlOJpVD27bT8VBNAPPHx4v9/KD/TBidM8Bn3XfngNpWY=
Received: from BN6PR2001CA0014.namprd20.prod.outlook.com
 (2603:10b6:404:b4::24) by BL0PR12MB4737.namprd12.prod.outlook.com
 (2603:10b6:208:8d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 14:34:32 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::99) by BN6PR2001CA0014.outlook.office365.com
 (2603:10b6:404:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:31 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:31 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/19] drm/amd/display: Add link rate optimization logs for ILR
Date: Fri, 16 Apr 2021 10:34:08 -0400
Message-ID: <20210416143417.611019-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5d43d3e-8c3f-4ea0-646d-08d900e4bff5
X-MS-TrafficTypeDiagnostic: BL0PR12MB4737:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47371ACE3DA81C623D57506F8B4C9@BL0PR12MB4737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyvQNTSRPIfJOcC/E9MWvXlPXos4Ybdcy+QiMRM/Yb0+1ig83OsYUK43XrmaH+/DD4OWTaqt/jC4ZaKuo3/3DH4JkYx8qcz62Xx1nVAazNN5vw0/IcIahCatb4JbKgoIBblHXW5zSpMKNBI8+scykvfIVCz8W+7iZXLN3nY2YdCRpri2nuO3qyAo23LVRZQ+e9Iq8K7PrAMMHnHUcXXPBC7EY5tZQ9RmwK9nmTkSDt7ReZ6baI2R+3e8YDcctSJ2mo4MUjy/e3mmwuTqKOPK+AdZx/6RtMoVg5qt60dqhNejARNXVPxszdVYY71L8hS4ukmZCrpsLAGbqxmRvHhlwksi3cHLZECd7qyLcnoASOdVEFA151JsbxW1u22FLzFQRS5HUNn3E/emumpXJe80iCnAldLTNXJjo25BTSZLNGMkyahEg+2DL6SmwORaJAERCfxNMybCGmusxONIXO2m5e+zbEMshKO69/Py+5IJCYXjfxfALBvGusRv0QAspj/oxWaoc7oVohngX3P1IS3CNdCTqTRatm+4djlgafj++OqWt5wAPLz7wUV9nFOIg90yCQMxb17VJZcvKp+ZvlqCcWnUfeZH9yyZqyFF2uKrJih8rsaGLSTJiv1xC8wrEphpIWGjhGcRCPptsmiX4iI6nx1krHTYNMdpdJtTEnjcQ/CBFY+d4k8vQ8Lf/j++fTUH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966006)(36840700001)(426003)(8936002)(478600001)(8676002)(7696005)(356005)(26005)(186003)(336012)(4326008)(36756003)(70206006)(2616005)(44832011)(81166007)(82740400003)(54906003)(47076005)(6916009)(2906002)(6666004)(83380400001)(316002)(5660300002)(70586007)(86362001)(82310400003)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:32.2259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d43d3e-8c3f-4ea0-646d-08d900e4bff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4737
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
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[Why&How]
Add logs to verify ILR optimization behaviour on boot

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                 | 1 +
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c         | 9 +++++++--
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 79c652eaddb6..4713f09bcbf1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1434,6 +1434,7 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
 	}
 
 	if (is_edp_ilr_optimization_required(link, crtc_timing)) {
+		DC_LOG_EVENT_LINK_TRAINING("Seamless boot disabled to optimize eDP link rate\n");
 		return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index bbf2865b25c5..3ff3d9e90983 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4739,8 +4739,10 @@ bool is_edp_ilr_optimization_required(struct dc_link *link, struct dc_crtc_timin
 	core_link_read_dpcd(link, DP_LINK_BW_SET,
 				&link_bw_set, sizeof(link_bw_set));
 
-	if (link_bw_set)
+	if (link_bw_set) {
+		DC_LOG_EVENT_LINK_TRAINING("eDP ILR: Optimization required, VBIOS used link_bw_set\n");
 		return true;
+	}
 
 	// Read DPCD 00115h to find the edp link rate set used
 	core_link_read_dpcd(link, DP_LINK_RATE_SET,
@@ -4755,9 +4757,12 @@ bool is_edp_ilr_optimization_required(struct dc_link *link, struct dc_crtc_timin
 	decide_edp_link_settings(link, &link_setting, req_bw);
 
 	if (link->dpcd_caps.edp_supported_link_rates[link_rate_set] != link_setting.link_rate ||
-			lane_count_set.bits.LANE_COUNT_SET != link_setting.lane_count)
+			lane_count_set.bits.LANE_COUNT_SET != link_setting.lane_count) {
+		DC_LOG_EVENT_LINK_TRAINING("eDP ILR: Optimization required, VBIOS link_rate_set not optimal\n");
 		return true;
+	}
 
+	DC_LOG_EVENT_LINK_TRAINING("eDP ILR: No optimization required, VBIOS set optimal link_rate_set\n");
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index dd903b267ca5..5ddeee96bf23 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1695,6 +1695,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	bool can_apply_edp_fast_boot = false;
 	bool can_apply_seamless_boot = false;
 	bool keep_edp_vdd_on = false;
+	DC_LOGGER_INIT();
+
 
 	get_edp_links_with_sink(dc, edp_links_with_sink, &edp_with_sink_num);
 	get_edp_links(dc, edp_links, &edp_num);
@@ -1717,6 +1719,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 					edp_stream = edp_streams[0];
 					can_apply_edp_fast_boot = !is_edp_ilr_optimization_required(edp_stream->link, &edp_stream->timing);
 					edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
+					if (can_apply_edp_fast_boot)
+						DC_LOG_EVENT_LINK_TRAINING("eDP fast boot disabled to optimize link rate\n");
 
 					break;
 				}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
