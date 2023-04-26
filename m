Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80974C7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 16:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0718B10E889;
	Wed, 26 Apr 2023 16:28:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABED10E694
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 16:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpi0GPE2kb2hdo8X2x+RVVnKDhpnA/9GenC3CNUIJ4vVd41Yc5fte14CfMc4A6yPepkC4xbYexzAwZc6NsRrA6RuQwLNpSPVZDJU5g3g4mubbayWUxEvlpwWHia+IuJCqKRaCXulLQeJ5tnxqqnJ8EILqWyd1FV4Pa721WiUBM/oRe4GFuM12DNXf382U6AD1LF7FIeSYeydUA2sE5QcOvh3ZFU8RoVfFyEPQOEcvDxI+D4P1JiWJWaaqI1gfR+KsVVD3hcg7v+/VTiygc43hA/B7gOSlpy/wam531ZWbDwTGhU+HAXHSmIBr7Wy9hNhCyEkBBy3LOn+edht/f3AFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr3E2nMG01Ok/TbmYQnQrkfMSMbkDRodFlYUIjgpQLQ=;
 b=KwhWg1AWmITU06j1l1XOk33uFgZvYxBAsCVKeP5+QD4yjuHAl38JYMhHjR7dWRYBvP5zTcP1yO4Q8ssc8IvMSYukOp82H5JyymGmYEldmW2cLG2G1cnKzz4XihXXwuKbclsbK6bFrZqmMMF9GW6NFYGyWWRxJVznThkPV8glaAacyNvWIvPBeR5ac0qO6pTLEMJ9ljO+GU9TOXqvvWaBCIPjEJ6S7Xam6p0v9uTo2BozgOPlZQoTH+SHEgAA2vFV/TVRXoG36+RpYvF0kTybCcB98BdlJea4Hzr+zoItmkUPaCK3TbwJ23RS2oEBaXSeFinxAv8YEx6c7TfpVPQ5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr3E2nMG01Ok/TbmYQnQrkfMSMbkDRodFlYUIjgpQLQ=;
 b=EWFEfIgVKG58C89G0wXpRs7zqfcHLzkR2fmTUH2AsVp/ML91Bs+US9TOQcWyQfOooCsMlDUdSvzCZfMFQIKxQqdS7IY2o1J36XAD8kXQ7vtGKVNSHu9RpmWVYLFXF9L17dRohqE+qOeRJf+zfWzlaakQbPzvhzUa3mKmu7OFIMc=
Received: from DS7PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:3b8::23)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 16:28:11 +0000
Received: from DS1PEPF0000E637.namprd02.prod.outlook.com
 (2603:10b6:5:3b8:cafe::f6) by DS7PR03CA0018.outlook.office365.com
 (2603:10b6:5:3b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Wed, 26 Apr 2023 16:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E637.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Wed, 26 Apr 2023 16:28:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:28:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:28:10 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 26 Apr 2023 11:28:07 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amd/display: Add w/a to disable DP dual mode on
 certain ports
Date: Thu, 27 Apr 2023 00:27:10 +0800
Message-ID: <20230426162712.895717-7-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426162712.895717-1-HaoPing.Liu@amd.com>
References: <20230426162712.895717-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E637:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: de02c613-db90-4258-5115-08db46733a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQxZ7fb/iJOib8NPDeMJPJ61JiM+Xu6ZS/jz7zhDaSQDYTayUBvtbn2T2i7UpXW5LPn+Dop/03iqjAAWRjA4UWatbTIgrWnBsJS73ufUvmfPPMiA8EMBlasq8dIoYA6g0zPrjRWakLA6idk1DwZxEI6KC3A9Ef7vFzne7fJjSmvnyQMh8dUjSTsbJkQgHJadyR+H/QYreTcZZMVPvUY4ST0D4fkd22PVNMzEffIUhlGHHWvqboijTULB1L5OuRW7HaCPawZJv+IzxMNUSO2iuYNVhWxwLLluYRzUu9o+2RCJDg97f9Y+1nGLUN9mNxYs8fidDak8lQunRbIsxLwcF8oNuzPtkgdspbtQDuvx2cO1TvHV8tY0lIgqKF4bi+H5o62ml9c3LdwgAdfVndF6+pjynzvWsWD5RVATPzYSib+QGlED9OuTIfopVzy+QuJ7smZUfgdp2YLQyw4pPb5LQqhQDrxAM2QddwW3dlMfQCm5Xu0Jxu8PT6LJRgqwbhccIao8Xb7jXDn2063tFqClRpPx125wBcVp5bpX8PrhUY/kgp8bNwu2AZ+1ZuQAmJw1za537cQB6TjjNsUTQM+kzBQKRec8GiGisQhqBIDtaXq1ULG4IGhEHM1X+JxrfydbHRlDKoVOVng1hynyojW7YbfGesxlz8GMvEFevrhT2mUH3tv4jJnSVTWgLIM3dlVuph4CgBGrDz4vUl6/HkDZyeYRBQ3thRme3+fviJ0wklE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(54906003)(36756003)(82310400005)(86362001)(478600001)(81166007)(8936002)(8676002)(2906002)(4326008)(6916009)(40480700001)(82740400003)(356005)(70586007)(70206006)(316002)(5660300002)(1076003)(186003)(26005)(41300700001)(426003)(83380400001)(47076005)(336012)(2616005)(36860700001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:28:11.2983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de02c613-db90-4258-5115-08db46733a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E637.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <Michael.Strauss@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Certain ports on DCN3.2 configs do not properly populate the BIOS
info table flag to indicate DP dual mode is unsupported.

[How]
Add a workaround to disable DP dual mode on the ports with the missing
BIOS info table flag.

Reviewed-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/link/link_detection.c  | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fea68383bb61..fe60816653d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -887,6 +887,7 @@ struct dc_debug_options {
 	bool override_odm_optimization;
 	bool minimize_dispclk_using_odm;
 	bool disable_subvp_high_refresh;
+	bool disable_dp_plus_plus_wa;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index a49323885874..4de2f8813dce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -729,6 +729,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_fpo_vactive = false,
 	.disable_boot_optimizations = false,
 	.disable_subvp_high_refresh = true,
+	.disable_dp_plus_plus_wa = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index a131e30fd7d6..17904de4f155 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -593,6 +593,10 @@ static bool detect_dp(struct dc_link *link,
 			/* DP SST branch */
 			link->type = dc_connection_sst_branch;
 	} else {
+		if (link->dc->debug.disable_dp_plus_plus_wa &&
+				link->link_enc->features.flags.bits.IS_UHBR20_CAPABLE)
+			return false;
+
 		/* DP passive dongles */
 		sink_caps->signal = dp_passive_dongle_detection(link->ddc,
 								sink_caps,
-- 
2.34.1

