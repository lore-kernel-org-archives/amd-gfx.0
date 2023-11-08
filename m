Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CA2C4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F48310E82C;
	Wed,  8 Nov 2023 19:09:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC7210E829
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBCBYf6lTKOn66okwAyygu+BFuGTCTFWaBnVOIu0ECiE3VBp9Gb5lQ3so4w1RdcWWjwydbXABQv5nmh6Og9Y1+IvmIedDf53eYpNUdYgMdrgXOv5b9rofZkWVC4uVR2MHAnn+c9vwI1UgVz2rdTK+PJi0+C6tcvKz4gnJWnYH5J+pDfxOkLqR/mf2N4rd99SRFhOyW9nyA7gvnDkrpxRyXVAEjVwnJQf8XieWjzh0Pai56uD8AjTZgFhc3ws11dDD5CF7FPVAshVhOqqpmgAzz/QBeZwJjQpIq3KA8tuaV5PhvLmZj+OZox02O0hjRsNt6h05DoKjgycpUAfL2zAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9iJaknyqPS+6HHQZARmkmTwskhlNZzadSSt2s3Ys8M=;
 b=YbtmmHQl420kO2tbf0Oc4JxgbvQyS6gb0uymrTJiPy6LbCpfsI1YO7vQHhjZKJUDytr4XqFP75tZTmj+J0133akOyjbbuJI6qKWPU1OOjN+Vi0j4XOAsjTNluSzMLQ43r5UVUQx0jgMue3mxgtDCGMlp0iflzJ7tURe2mzpBjtjLaKsxwBk32y84CUrEGMxQqxZKz+ua16uNE4PW7lJWIa/3Fpk8Z42HWH7zuP6BsFfHPpPd9YIfU2rYuBX2XRIBciTEGyCq0DjwNbXylCmEw+SBEw8Foy7q/zoTTmoNT7N627M5gChdtMu8TD0IxzjCbP4s7/JeOLxDwX5p04mVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9iJaknyqPS+6HHQZARmkmTwskhlNZzadSSt2s3Ys8M=;
 b=MlfJRJ550j/RYHkLvXOHsDPgYzxNKME5Rn9KUcCjhOdf8OybOPDTQ8JWXkZOc2KkmxV0/xUqh6ro7giXCQFCqIVG/3BnXpkdmWsRQyohIzo1daP7IhVcdoLwF79NcCUbz9QulPrDNs9rOer9SCWmf1cGl1DVQLxFfxGDTG+Gdto=
Received: from CH2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:59::40)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:09:41 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::7d) by CH2PR03CA0030.outlook.office365.com
 (2603:10b6:610:59::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Wed, 8 Nov 2023 19:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:09:41 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:09:38 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/20] drm/amd/display: Enable DSC Flag in MST Mode Validation
Date: Wed, 8 Nov 2023 11:44:30 -0700
Message-ID: <20231108185501.45359-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 8820c1f1-0599-4c95-09fd-08dbe08e42bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJ5cg8W3buYnq0yJo8tGr1X9Oc1mZyDPR8HH4vcMkmYnMwz9V9eblJg8oKkhagze4wOS1K4/mJMBVBjgB5wgBDl9BmagSSy2HxB0j7q11ZhcXRcrfdYVJlby76iETY60JiP5lwIPlHbaogMPkvcIRFNOxaXsGnhAKW26BAnMRZQ/DICWCn4YgVyH6F6rNXFEA6dwl4WW201UAJIQlwPbcyXnSpWvDensbNMWEiu9/hG97QQRk0Ogn171OZlOe4ZBkHt2IHxMS91rzr1zOJKjmQq1qLhyTvAjBHxW4RsKnPsoZFcTTdbtTQynMqIi6GVvUD1bQuoGdIeHmaUF/vCz58GGXSF3x5jf6Ep8szwEz2jtIXvUSeSJ1YO4aeE5m96Qybn939YfmpBjVgR39y0vL3eRubvcjrSryiIjDoziJoCoW2BXvTero2EiexqzfPZmaJFFQAbHHTTfRmq/aO26JghPXyhgakZyz9LusFP3lbqyAz83by4tA2XJVTTNf9SeAR8ZUhPlt8bAPIDWVR82PBIb3z6yHCKOhDcZBPCwPb/lP+N8SoNOkEi5LJX0fVm9XPDcYe5zRFK8zSKHgjsa2ygk0a7DiuWnT1Uu65Wnr4qksIZ6EmFCQycb1YbMUicE2UYWJFcg5kPVxaIXEcst1U1dPvUCIrt3QYSvhwyK4pE6hxl1K86UzfLVcHpd9sR+8kCHkcKpuCXd9O0PMawzs2qXAh+7P9RwZFsisNQ1CtvPHZToF0ym6kzulbGtRlwJ4ZvvnN24IH/GZEtO1IL2JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(426003)(7696005)(6666004)(478600001)(2616005)(36756003)(81166007)(36860700001)(86362001)(356005)(82740400003)(70586007)(26005)(8676002)(44832011)(70206006)(41300700001)(2906002)(16526019)(47076005)(1076003)(336012)(83380400001)(6916009)(5660300002)(4326008)(316002)(8936002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:09:41.2069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8820c1f1-0599-4c95-09fd-08dbe08e42bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex
 Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <jerry.zuo@amd.com>

[WHY & HOW]
When dsc is possible, MST mode validation includes:
1. if maximum dsc compression cannot fit into end to end bw, mode pruned
2. if native bw cannot fit into end to end bw, try to enabled dsc to see
   whether a feasible dsc config can be found
3. if native bw can fit into end to end bw, mode supported

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 44 +++++++++++--------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index ec87e31c6fe8..8d7d4024f285 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1602,9 +1602,8 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	struct dc_link_settings cur_link_settings;
 	unsigned int end_to_end_bw_in_kbps = 0;
 	unsigned int upper_link_bw_in_kbps = 0, down_link_bw_in_kbps = 0;
-	unsigned int max_compressed_bw_in_kbps = 0;
 	struct dc_dsc_bw_range bw_range = {0};
-	uint16_t full_pbn = aconnector->mst_output_port->full_pbn;
+	struct dc_dsc_config_options dsc_options = {0};
 
 	/*
 	 * Consider the case with the depth of the mst topology tree is equal or less than 2
@@ -1620,30 +1619,39 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	   (aconnector->mst_output_port->passthrough_aux ||
 	    aconnector->dsc_aux == &aconnector->mst_output_port->aux)) {
 		cur_link_settings = stream->link->verified_link_cap;
+		upper_link_bw_in_kbps = dc_link_bandwidth_kbps(aconnector->dc_link, &cur_link_settings);
+		down_link_bw_in_kbps = kbps_from_pbn(aconnector->mst_output_port->full_pbn);
 
-		upper_link_bw_in_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
-							       &cur_link_settings);
-		down_link_bw_in_kbps = kbps_from_pbn(full_pbn);
-
-		/* pick the bottleneck */
-		end_to_end_bw_in_kbps = min(upper_link_bw_in_kbps,
-					    down_link_bw_in_kbps);
-
-		/*
-		 * use the maximum dsc compression bandwidth as the required
-		 * bandwidth for the mode
-		 */
-		max_compressed_bw_in_kbps = bw_range.min_kbps;
+		/* pick the end to end bw bottleneck */
+		end_to_end_bw_in_kbps = min(upper_link_bw_in_kbps, down_link_bw_in_kbps);
 
-		if (end_to_end_bw_in_kbps < max_compressed_bw_in_kbps) {
-			DRM_DEBUG_DRIVER("Mode does not fit into DSC pass-through bandwidth validation\n");
+		if (end_to_end_bw_in_kbps < bw_range.min_kbps) {
+			DRM_DEBUG_DRIVER("maximum dsc compression cannot fit into end-to-end bandwidth\n");
 			return DC_FAIL_BANDWIDTH_VALIDATE;
 		}
+
+		if (end_to_end_bw_in_kbps < bw_range.stream_kbps) {
+			dc_dsc_get_default_config_option(stream->link->dc, &dsc_options);
+			dsc_options.max_target_bpp_limit_override_x16 = aconnector->base.display_info.max_dsc_bpp * 16;
+			if (dc_dsc_compute_config(stream->sink->ctx->dc->res_pool->dscs[0],
+					&stream->sink->dsc_caps.dsc_dec_caps,
+					&dsc_options,
+					end_to_end_bw_in_kbps,
+					&stream->timing,
+					dc_link_get_highest_encoding_format(stream->link),
+					&stream->timing.dsc_cfg)) {
+				stream->timing.flags.DSC = 1;
+				DRM_DEBUG_DRIVER("end-to-end bandwidth require dsc and dsc config found\n");
+			} else {
+				DRM_DEBUG_DRIVER("end-to-end bandwidth require dsc but dsc config not found\n");
+				return DC_FAIL_BANDWIDTH_VALIDATE;
+			}
+		}
 	} else {
 		/* check if mode could be supported within full_pbn */
 		bpp = convert_dc_color_depth_into_bpc(stream->timing.display_color_depth) * 3;
 		pbn = drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp, false);
-		if (pbn > full_pbn)
+		if (pbn > aconnector->mst_output_port->full_pbn)
 			return DC_FAIL_BANDWIDTH_VALIDATE;
 	}
 
-- 
2.42.0

