Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF789C4829E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C6E10E460;
	Wed,  7 Feb 2024 20:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XWYLGnzK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB3A10E460
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1cfEY4BmA0RD1HmVi5d4JJyCp51StWz1T2uoaaNN8Royr63pv6LG/Co4eUDlQYuToEujj1dqXkgORx/21w+By7AumHcRUCuYRCgIH6CvMf5R1AWWDuJaUPJD3g0kWpWWxXRvW2Go+8zJSza+ctcrJBOcxCtNejkGhVMEsfS92zhjFp/XYfvwr7RBuGjnJfsdj6xpUKl60hhoxxshvyPftA7BDj1KdOtaR4R4cky5Qxf2Kth61HoMdgbAMniC3fPxwjXMKToGLv5+xJ6IHH0PFIo+P6Zx0TGce6KO2HyDhIDDjCSMyqCjIz/5ai3+yH5La1psKWch1T/e9weFdVVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I81jyAVDBuha2iNnhRj9R0p3nyPmeWh14ISeNrOk9uQ=;
 b=oC2A3vVb2V8Qc0ntpQ17yWwy4l1M1BNAC2nmcSf8sepg0+YtKvh0MjNUy3qu7ErU4VyElWJYA6DmD5+7/wOFhC6ZmpOxv+NXRTubiMuxwWY1GAS/ClM89ZfethSunCI2KONkP4kMTmdB4+cLBiBsPM+h67h6HUUEdGlf9ZAW0n9wqioNoFCh0uAJjOZ2i4Cq58TTJVFBieIhpvwyC59/aNGeMBJXRf0FI4ORYg5aaR2wIXFlDPC8FSVYEPYZAlrDiDVLE1s1k0MJtMH6nIXAGzF2Q+qqT4ZK1p92NStdJRLCQx9sZM7gpM2vnb5Pz+HJxjfTjSi4TVydCYgFflxTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I81jyAVDBuha2iNnhRj9R0p3nyPmeWh14ISeNrOk9uQ=;
 b=XWYLGnzKLzW97GcR/ZV2tXcrxQwUi1WLZ+iBTovhoyYzclXMdZW4rVJ8wBiGVlTunYEhYKi2De3DO2licfEW98PQrCLhy0ZI2nxuSQUpvEwAamj/q/rF3mpLXZ7UXQTxT6TSBFbHw52W6+M8zl2INiCD61uc9eu9+e8lodtAA1E=
Received: from SJ0PR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:334::22)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Wed, 7 Feb
 2024 20:52:21 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::3a) by SJ0PR05CA0107.outlook.office365.com
 (2603:10b6:a03:334::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:14 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:14 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sohaib Nadeem
 <sohaib.nadeem@amd.com>, Josip Pavic <josip.pavic@amd.com>
Subject: [PATCH 09/15] drm/amd/display: fixed integer types and null check
 locations
Date: Wed, 7 Feb 2024 15:50:44 -0500
Message-ID: <20240207205200.1608684-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 859ac372-fad6-453b-b88e-08dc281eae43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYfYsHxim3oN0zROGlU65Yi0DuHIH08+TMaSocIiWwxlAf328fGljyZJuD7zArwDWhrbvGYwN8B/wi5oIO8QzDly4qNr/BiHFZSS/lGtDc91HC/FVUFd9q9EevHfcy3zwAS5KuFUMP+3zFNwUL8eH36/GxAUMBsFS7ByrcORupTkATu68VurWhY14XtOYBU7RVqM8r0Ws2n9GnwWuVPQ+YHdsNU5DwpN4yrjA1B3u4W90MOyQjPofqHguYtUmVDFDxWU2qzMitH+h+Hj87jC5nPZJ5wXkRrrTxCZ3p1e+yogatfA/sfQflFRANjpIN8OYnkjEoch8LzA77C/YSVzaVwujbNM7AQ4QoIc54JlcMrEYFSm1qq15VAzwj7GFHdWyzxXuWR2u570bXMYCOIPBtHTr7V+YfQwX/laQ7Bz/J6fVWT3/L20VuDG7krnma05cbxCoXhaGo8uFdNIeGjZswVO4mQeKFYbgt/OXDKVeX08Y2VWwvfsuzPhUP70PX/Lw9DKq8hKfJH9vPFc/K4I1ZXmlI21yuHqydhzhq1YoM2UyyaOZyrDSzoYO6zL5M+g/I5sCpUETikeSsh4wWkojvYGjrwK99GNwI9MsjLbuy4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(356005)(8676002)(83380400001)(41300700001)(426003)(26005)(81166007)(336012)(44832011)(70206006)(54906003)(2906002)(4326008)(6666004)(8936002)(316002)(5660300002)(7696005)(478600001)(70586007)(82740400003)(6916009)(36756003)(1076003)(2616005)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:21.6321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859ac372-fad6-453b-b88e-08dc281eae43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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

From: Sohaib Nadeem <sohaib.nadeem@amd.com>

[why]:
issues fixed:
- comparison with wider integer type in loop condition which can cause
infinite loops
- pointer dereference before null check

Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser2.c   | 16 ++++++++++------
 .../drm/amd/display/dc/link/link_validation.c    |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 960c4b4f6ddf..05f392501c0a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1850,19 +1850,21 @@ static enum bp_result get_firmware_info_v3_2(
 		/* Vega12 */
 		smu_info_v3_2 = GET_IMAGE(struct atom_smu_info_v3_2,
 							DATA_TABLES(smu_info));
-		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
 		if (!smu_info_v3_2)
 			return BP_RESULT_BADBIOSTABLE;
 
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
+
 		info->default_engine_clk = smu_info_v3_2->bootup_dcefclk_10khz * 10;
 	} else if (revision.minor == 3) {
 		/* Vega20 */
 		smu_info_v3_3 = GET_IMAGE(struct atom_smu_info_v3_3,
 							DATA_TABLES(smu_info));
-		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
 		if (!smu_info_v3_3)
 			return BP_RESULT_BADBIOSTABLE;
 
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
+
 		info->default_engine_clk = smu_info_v3_3->bootup_dcefclk_10khz * 10;
 	}
 
@@ -2422,10 +2424,11 @@ static enum bp_result get_integrated_info_v11(
 	info_v11 = GET_IMAGE(struct atom_integrated_system_info_v1_11,
 					DATA_TABLES(integratedsysteminfo));
 
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
 	if (info_v11 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v11->gpucapinfo);
 	/*
@@ -2637,11 +2640,12 @@ static enum bp_result get_integrated_info_v2_1(
 
 	info_v2_1 = GET_IMAGE(struct atom_integrated_system_info_v2_1,
 					DATA_TABLES(integratedsysteminfo));
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
 
 	if (info_v2_1 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v2_1->gpucapinfo);
 	/*
@@ -2799,11 +2803,11 @@ static enum bp_result get_integrated_info_v2_2(
 	info_v2_2 = GET_IMAGE(struct atom_integrated_system_info_v2_2,
 					DATA_TABLES(integratedsysteminfo));
 
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
-
 	if (info_v2_2 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v2_2->gpucapinfo);
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index 1c038e2a527b..1aed55b0ab6a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -359,7 +359,7 @@ bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const un
 	struct dc_link *dpia_link[MAX_DPIA_NUM] = {0};
 	int num_dpias = 0;
 
-	for (uint8_t i = 0; i < num_streams; ++i) {
+	for (unsigned int i = 0; i < num_streams; ++i) {
 		if (stream[i].signal == SIGNAL_TYPE_DISPLAY_PORT) {
 			/* new dpia sst stream, check whether it exceeds max dpia */
 			if (num_dpias >= MAX_DPIA_NUM)
-- 
2.43.0

