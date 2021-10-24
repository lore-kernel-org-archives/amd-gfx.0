Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC6FC4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8227260724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8227260724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440E06E14D;
	Sun, 24 Oct 2021 13:32:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B4AC6E12C
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM2dXjAL8f9/HkGSgH0qgN6dxl4RZc97TYbF7H0eUpFsnujaROyom+QCodYXTepM+ePjk+n8Ez4J/DKtNFQGZUXpn+L7otd8Ppv/rZImgW8Nt2BSZuDOBaH3acUN1jf/qpglv40QgfmE57afwuDUDmMi4AIo1Q1vvDUtzfjtoxH+APnu3mhjOCrxBzvmSQWmF7V8CnIV9HRDfCMMoM6uLRmfgbX18bqhuIzVFt8l8Or1tVlFzczn7ruTfYsmL3upeNS4bzKE8ZhR/gHwp+tv5vEUVxPY3t2N+aJRr2sXoLkUznhKhoPnjoIYFiAmuhktvMWc6D877O+7n1Z6a6ovqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL/tp7bNGTwljsZbz5+EDn6G75QR6Z2AZZjvHKGaI9Q=;
 b=Ex0aj270GaonWOgLhdyu2PZMH8ln6+519YQYiG4JJkFx7gj4V7+dJ45LJyfzl05zyVAy9FF9gNgJmtaZsEdKbZzhe/rHOGVQzF+POMk0EdY2ELQxXlnqYsmvThZgWHnC+72RjMGvyL6mi9c7g6XSpMmpa2CyNpxmm96rjzg1WlLRe02zTuvNkEUYv2xY3L6aickb9fRJNI40W+yd14wwzewKZC8OMFPnz0oX1oIsLSXBJO4YeIlkzkKW2UHFIVSz8l6V3AkJCfCAD+sWcqGb+2YO+aEoV4zoU5PWrlVKP8+kyp+s0InN/44IkwRQI3LQJKMk1u502UHXw9NVVVDwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL/tp7bNGTwljsZbz5+EDn6G75QR6Z2AZZjvHKGaI9Q=;
 b=oSKF/APVfKNyxUM17g9w+OR6rUkwVp3qPIfre7qYqc7ZFnw6xjaadM1ec8CVf5f/fr+L/15+pgrY+UsPOyo/lBc0it9AoD6lTf7Ets7WiJ3eIaZ74GUvp6KKz13Ns10eA8/Yhi5duI7uaNC8w7QR+JDnautaKgwBhF4d66EZsew=
Received: from MW3PR06CA0016.namprd06.prod.outlook.com (2603:10b6:303:2a::21)
 by DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:46 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::61) by MW3PR06CA0016.outlook.office365.com
 (2603:10b6:303:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:45 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:42 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 31/33] drm/amd/display: add two lane settings training options
Date: Sun, 24 Oct 2021 09:31:39 -0400
Message-ID: <20211024133141.239861-32-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34074a53-8cc1-41d1-5125-08d996f2c39b
X-MS-TrafficTypeDiagnostic: DM6PR12MB5007:
X-Microsoft-Antispam-PRVS: <DM6PR12MB5007DB18D449C94FB98CA0FF98829@DM6PR12MB5007.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5JQnQ+RX/JTp3W26/m9rlpJhHVmEvLDLz61UaPOnU+SkR440M/P881k5AhYsJrbuNNwH6PrOD+Qa3oLJ4dweZiZxrVU5KQDAT/ZPEfAavSDS6xtWNuYV9UEAQJ2XZ+Qa8CAGfwFb4xTl90LMZcPEg+0wAJIBZ59+KfTenAfVrzF31s2ApDy+pwI9RusyBFXxpkdBYUJCZXiYFAnELjedWNyGrnvCCePhQf3HfkUHX5jRgWtUMHSdsFRoNNXIc1SUQgfyW85aaDLme6G44fbvfPBx/wRgfafUauEWUVHsbfYurZ+hJM7fCeC1K2wsiuPpOFwz0maYSUZJtC/tF7xSYFre3CJ4HUWWCnqN5rnzjxjxfpE7LZYK1qTX2EhzTxmOw6fVS+tWduHX8c6m541jUACZIu7bQWnfMoATOZXB9N3e0k+3g+zFs4Cd0SErLLjjdrK8xJmdTjXEodA0Ll/FGqOsZCOLKFfFXZwGuLx+M7P9FJsIjUJTc1GDJZg56xDMIrOYRbv1ZgVP/6KIA7VVNzkE1wfGTDvK/FUMy4ZckWtwXEKdnv1C76SqfwVKU/mk5ODSAvCYGHUZ4OCNTTf2hjly8kDsItMYXbBDahgaobVDS1zntNB3z+coVZd9uSdlSKTT+SbmRTdbNovxJ3mU9vHFj91OxPLGgInRgRb9C4pg13Ufcjrexw3TwiNB9Spl+St7BuPlz0FWx8JJj6tuN2R6nUVJhP7S3ei8dj/xUk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(36756003)(54906003)(508600001)(5660300002)(86362001)(2906002)(8936002)(26005)(1076003)(16526019)(82310400003)(70206006)(426003)(336012)(36860700001)(8676002)(356005)(6666004)(6916009)(2616005)(316002)(83380400001)(186003)(81166007)(47076005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:45.6124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34074a53-8cc1-41d1-5125-08d996f2c39b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5007
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
option 1: disallow different lanes to have different lane settings
option 2: dpcd lane settings will always use the same hw lane settings
even if it doesn't match requested lane adjust

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 14 +++++++++++++-
 .../drm/amd/display/include/link_service_types.h   |  1 -
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8f27097d56cc..653279ab96f4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -737,8 +737,17 @@ void dp_decide_lane_settings(
 
 	/* we find the maximum of the requested settings across all lanes*/
 	/* and set this maximum for all lanes*/
-	maximize_lane_settings(lt_settings, hw_lane_settings);
 	dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
+
+	if (lt_settings->disallow_per_lane_settings) {
+		/* we find the maximum of the requested settings across all lanes*/
+		/* and set this maximum for all lanes*/
+		maximize_lane_settings(lt_settings, hw_lane_settings);
+
+		if (lt_settings->always_match_dpcd_with_hw_lane_settings)
+			dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
+	}
+
 }
 
 static uint8_t get_nibble_at_index(const uint8_t *buf,
@@ -1453,6 +1462,8 @@ static inline void decide_8b_10b_training_settings(
 	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_setting);
 	lt_settings->enhanced_framing = 1;
 	lt_settings->should_set_fec_ready = true;
+	lt_settings->disallow_per_lane_settings = true;
+	lt_settings->always_match_dpcd_with_hw_lane_settings = true;
 	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
 
@@ -1479,6 +1490,7 @@ static inline void decide_128b_132b_training_settings(struct dc_link *link,
 			link->dpcd_caps.lttpr_caps.phy_repeater_cnt) + 1) * 20000;
 	lt_settings->lttpr_mode = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) ?
 			LTTPR_MODE_NON_TRANSPARENT : LTTPR_MODE_TRANSPARENT;
+	lt_settings->disallow_per_lane_settings = true;
 	dp_hw_to_dpcd_lane_settings(lt_settings,
 			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 622c03f15df2..424bccd36434 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -118,7 +118,6 @@ struct link_training_settings {
 #endif
 
 	bool enhanced_framing;
-	bool allow_invalid_msa_timing_param;
 	enum lttpr_mode lttpr_mode;
 
 	/* disallow different lanes to have different lane settings */
-- 
2.25.1

