Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD73C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCAF810E4ED;
	Wed,  2 Nov 2022 16:04:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8740710E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2aAgug2TZdCi1k3mBBpn1Z3p2iTbZ/fjp5FhSEmk7W1Bt1p+L7Gl3nwMJaRG3m2CbTQWNqAA8XYERPt99N4WH7pI+vg1B5kAKZY8VLeUGPTbGC2nIrLT5lv6AdXnU7SykHlCJApF11f7n0UanC212c0ZgEwu2v/sGWZ+q7K2d2yZNYA5+0lnS2U77R5OkI9jbPTBMoWBioQI5Woc+EmGJFxU1UxygTxerOmhTWZW+n2pACsSaHxfyKWhqJ9BpSrHYC0Ipd5VX47aMgjUXmgxOLmEuYn/caCdZn91B3PDDQCaKR3vyhyZ9mVwo5KES8pq1e0j1lmayCfxH8RpKmSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC05C+uwYce7J/bQD7MXrZwLmUVWkA6giHyW4kCCGmQ=;
 b=CRK4uC278CxiIRJK/jMR/gdSjMIbNgpdFKnCp8G/CU6XEG3F10VdoZ6E9iQiwMJax0UJYYPPeYasyiqPUUlks9LsjCOTAPFjNEtkkgz5k1aD8T9jAg0ufhdVXsn3mw9WMRl7t1s2OFP77rKqE85+P8MSt5OdP1EvBh+ei7AYnCARKW3jtrT2RgqhsOvpTk1B5ZRqCAHPpJAk/zNS/8iKhDWW1mFc9mCyjb3sahBQCYNf533zZ9U0BHp34pJO7Ju+ykTvD5ev4KEp+OjeHu7X4TnEjI171S+kFQ8UvLRa6wEDw59hIm7I40M55GGo09y/x6oaN+5koz64S+B2CrP0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC05C+uwYce7J/bQD7MXrZwLmUVWkA6giHyW4kCCGmQ=;
 b=QrP4JwbARn+HM7GImVl/b6yQusv5CXUcW10bzH6+MoIYjS5iMMVG6HuUP5+MxiotQCQJMloGplcTuRYzN471Km20L/k7oaknm0/f6ZKx5nLO0qj2TV58OvzcFT9OegpPRVN8hJ7CgHNaB7fUD3cVOvC43vp5NZ8fg71XbkiQ4ok=
Received: from DM6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:40::23) by
 IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:441::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Wed, 2 Nov
 2022 16:04:27 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::34) by DM6PR03CA0010.outlook.office365.com
 (2603:10b6:5:40::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 16:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:04:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:04:26 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:04:22 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/22] drm/amd/display: Add margin for max vblank time for
 SubVP + DRR
Date: Thu, 3 Nov 2022 00:01:15 +0800
Message-ID: <20221102160117.506511-21-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 843808ee-9296-4a41-d0fd-08dabcebeac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNzsXV/05qUJw0yt+0fEv67PewP48yryUL/JWx7znPHbxW0sLlJqqOCxkliKfrxH0wIfajRBBSTECfN/eafEpMazei6sb8NCea8gSs7VHI74tZuy2WxHwc2dszxjiHrAFPLO3IFJJoJGXz3OLccXmHdhxlJHH0rksSe7lnSGmvLRpE+RSdvzKPtdqikm8yh7xNbI0YnUHkCi1spRKYCmhP3Mry23WTtqD+2Jn90epJDYW3MhU42YBCbvtbj0tnmXYLj3DfHJvHc4Az3IffsKi1Oypbi1Jk8cf1m8yqMYgJj+Br7mMA8q1sBFaAfnSe8UUrLlzhS9X0VJJoI/YtyFX0/ZuxeBcWh3jmxwgiuEHfNIy2kNFKDBMnNBFX+XWzWUS+dJ8ot9YY9wzGzbq84e6+O0ciT+WobMesxsvFcbT01aTfWuQa0m3yL5PT+MBoXmLyuQa4UgAn4nn3qSq42n2U9lxazcUfU6twnSdtJAK4yhtPwPUN7qxI/BtLMKQxtMegn6wk5Oufg9ycQ9EUdJxQnrHV1a30Vb56rzOOrTEgE6lF6OzyLSA4RTZhBujEaJjZS/Nj5m8B5TyMOP3isNyTC2LsGIKpFQQBegVC6jHXNQMPNBHJXUS2Qnq0wneaHPzit4jtJOTte5W79bSbPyKgyVcfdSzpw4sHGrmVQyogYF4Ou7abJtCDV5+6zqlF9uP8wr4jDhlRIRvVMCo0JDoKscnApUW+/JRxn/DnBheEURwGoX88HqNS0vnX01S58PtPUFy2xbba02Gsdcj+d1CRn1boNWcoZ/VmgbMxc0vEL/9x0eVOrJBaQ8RxG4B7ki
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(426003)(478600001)(82310400005)(40480700001)(36756003)(54906003)(36860700001)(81166007)(8676002)(186003)(26005)(8936002)(6916009)(356005)(86362001)(6666004)(40460700003)(7696005)(1076003)(2616005)(41300700001)(2906002)(83380400001)(70586007)(5660300002)(82740400003)(70206006)(47076005)(4326008)(336012)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:04:26.7996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 843808ee-9296-4a41-d0fd-08dabcebeac9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Incorporate FW delays as port of max VTOTAL calculated for
  SubVP + DRR cases (since it is part of the microschedule).
- Also add margin for the max VTOTAL possible for SubVP + DRR cases.
- Due to rounding errors in FW (integer arithmetic), the microschedule
  calculation can get pushed to the next frame (incorrectly) in cases
  where we use the max VTOTAL possible to complete the MCLK switch.
- When the rounding error occurs, we are only off by 1-2 lines,
  use 40us margin which is working consistently.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                  |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c         | 12 ++++++++++--
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c    |  1 +
 .../gpu/drm/amd/display/dc/dcn321/dcn321_resource.c  |  1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d69121809524..1ec1b441d5cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -261,6 +261,7 @@ struct dc_caps {
 	uint32_t cache_line_size;
 	uint32_t cache_num_ways;
 	uint16_t subvp_fw_processing_delay_us;
+	uint8_t subvp_drr_max_vblank_margin_us;
 	uint16_t subvp_prefetch_end_to_mall_start_us;
 	uint8_t subvp_swath_height_margin_lines; // subvp start line must be aligned to 2 x swath height
 	uint16_t subvp_pstate_allow_width_us;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4cb912bf400b..097556f7b32c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -477,12 +477,20 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 			(((uint64_t)main_timing->pix_clk_100hz * 100)));
 	drr_active_us = div64_u64(((uint64_t)drr_timing->v_addressable * drr_timing->h_total * 1000000),
 			(((uint64_t)drr_timing->pix_clk_100hz * 100)));
-	max_drr_vblank_us = div64_u64((subvp_active_us - prefetch_us - drr_active_us), 2) + drr_active_us;
-	max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us;
+	max_drr_vblank_us = div64_u64((subvp_active_us - prefetch_us -
+			dc->caps.subvp_fw_processing_delay_us - drr_active_us), 2) + drr_active_us;
+	max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us - dc->caps.subvp_fw_processing_delay_us;
 	max_drr_supported_us = max_drr_vblank_us > max_drr_mallregion_us ? max_drr_vblank_us : max_drr_mallregion_us;
 	max_vtotal_supported = div64_u64(((uint64_t)drr_timing->pix_clk_100hz * 100 * max_drr_supported_us),
 			(((uint64_t)drr_timing->h_total * 1000000)));
 
+	/* When calculating the max vtotal supported for SubVP + DRR cases, add
+	 * margin due to possible rounding errors (being off by 1 line in the
+	 * FW calculation can incorrectly push the P-State switch to wait 1 frame
+	 * longer).
+	 */
+	max_vtotal_supported = max_vtotal_supported - dc->caps.subvp_drr_max_vblank_margin_us;
+
 	pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported = min_vtotal_supported;
 	pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported = max_vtotal_supported;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 4bd861427b3c..77e40ee488bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2117,6 +2117,7 @@ static bool dcn32_resource_construct(
 	dc->caps.cache_num_ways = 16;
 	dc->caps.max_cab_allocation_bytes = 67108864; // 64MB = 1024 * 1024 * 64
 	dc->caps.subvp_fw_processing_delay_us = 15;
+	dc->caps.subvp_drr_max_vblank_margin_us = 40;
 	dc->caps.subvp_prefetch_end_to_mall_start_us = 15;
 	dc->caps.subvp_swath_height_margin_lines = 16;
 	dc->caps.subvp_pstate_allow_width_us = 20;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 6292ac515d1a..e5861225f1df 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1704,6 +1704,7 @@ static bool dcn321_resource_construct(
 	dc->caps.cache_num_ways = 16;
 	dc->caps.max_cab_allocation_bytes = 33554432; // 32MB = 1024 * 1024 * 32
 	dc->caps.subvp_fw_processing_delay_us = 15;
+	dc->caps.subvp_drr_max_vblank_margin_us = 40;
 	dc->caps.subvp_prefetch_end_to_mall_start_us = 15;
 	dc->caps.subvp_swath_height_margin_lines = 16;
 	dc->caps.subvp_pstate_allow_width_us = 20;
-- 
2.25.1

