Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBC3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF5B10F371;
	Fri, 17 Jun 2022 19:35:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DFD610F2B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv6liVF5XR6pov3vlClKX17lUoZ8VZu19OCqOrTaz3gS2UBV7Dml1LibyVYr/ae8bOYFIo2xBdQm46ka3PoxG5iplI37KqHEINErm1Smr7+HOiyLb4CLdTD7wmwQtpVExaV5m+HF05B9pa8wxG30cRXchvgcZI0Yt9NiedDSVeJK5FqFo4BG88nMCggVE8d0gaubR9RqzXuAw2g76AXMLdtCXuk4m3otrcrJ8r3bYkZu4uiGblOL03vEoSuySFBRbcCy62Q6bPVdn7Y72JKRNLbttNOg+xwPw2FsSY4sFd+bPwN1DxNyIbvS40s/14PB+cun3q+yZePL+rlrCWTQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVgmTo4p8+vTGXcecDMVYqU+DR1eNHOtuq8MKcLbup0=;
 b=Pvqpjg6P/2KPXU8Aq1/CXMGtagGNrJlK2oI8y0nd2nUs1jZyMJqes7GKgvKmkFp/Uvp7RwY71nsCHSo4FBoS9lqVWjzHKXlVK8d5fT8Q1OU8Tjh3T6fJrQGqCK39t0GJ6DZ+kfOtbN2y6eStPIj/Qf///Esd99AM8MiRBGUovBBncpe6Dmhf+G17lLiT03oLLkZoEPOfdkDk3GzT8DqXC7qh8RLfT54S6oKtkE4o1NxsZ9+RFLIW6FK5MB3BLUNmb8wkO4Yvvsd0yfJo8TqtLSZK9sFuruWZGpYWUDK4saKqkH6TAEDi0vnrVD1/8o4EjFDffDY9cXpSX7WHsW1lhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVgmTo4p8+vTGXcecDMVYqU+DR1eNHOtuq8MKcLbup0=;
 b=bg/BLZjGBV3qiOUPWogPjGOJU+6Y5Gi1ngrUHrt7J8TO4ZbBhbbQ2MW5J1rhI0VyqRZTk61801gsFvFE8Y9VHAiqAKPZhunOHPuaymiu2Cqh5ns31vIdCcjmdMhN28OhjfHy74XpqQ0uJAy3s/7laOtr9VlMTB9KD3bc6F9u0R4=
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Fri, 17 Jun
 2022 19:35:45 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::e2) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:45 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:42 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/31] drm/amd/display: add mst port output bw check
Date: Fri, 17 Jun 2022 15:34:48 -0400
Message-ID: <20220617193512.3471076-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f612bf0-82f0-4c8a-594b-08da509892c0
X-MS-TrafficTypeDiagnostic: BL3PR12MB6617:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB6617D599B688E9F6E2C87EA098AF9@BL3PR12MB6617.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPNi7TAaingB8+pn/tybRH0YZS65pBU2OPKUHh5Vp+M3TtOeaJfyzb046vv+AAuLnC/hrf/odFB0Z6e3WdMOEncH0JuVPn1BeUn0nlRkIXjtDLeQq1HYT6J/J4IfIFaepTzlHDa0sULN6kPGL/LUIzX2iw1THMudhU0N8wtXgd4KX8H5nNbPlEfnJ0UFcJgysLpdBTjdl2HTkgRiTXN0pHZAD5tddNlox0oPB7LK2VCGeHmd8bmqRLsJux6G798QsSGuNMCenff2rCBaqCT1hS3Y8aEVCsg0NKqOquhfLDGWSyY/gNmuG3j+KFd21ZYtmQWLXeiYv/gXkBG8RfX77w3s29FZszG8qDS+Os+pcWAKSHoUguIKnKOw6x9Zq+Gj3LxS7wvQEC7EKNC8Yw/30Ita8TuFzijZ9CQyAHPaN+dL7aw/3+4S9Y4fP0lBf2NC3u/M9c3wxc9/4B3mbUGaR9rTHJBFGapPMy5cVAnBdZIWmiZK/Z6P5dpTugaXj225LbxJAjLNvtwvb4Sa8AM1HhTdfCd+mrceO4NUkTh1QEq7PpkVUpQMKROtxKbBqBA55K7C64dbTWltEHGLv3bzdJHCAMCQ6Rq/gPTuiG9yXyCB/FhS9vnZrSS9Cl2dE5tQjIcHHilydw+bihKyIWazNw9RaatyqsHfFmlv1vF4zjKL2DmBXL9l34wzSfj8FpGn6a5BnAoLRk26vtPherqIRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(6916009)(8936002)(70206006)(356005)(426003)(86362001)(1076003)(8676002)(7696005)(316002)(336012)(498600001)(5660300002)(4326008)(70586007)(26005)(81166007)(82310400005)(36860700001)(186003)(2616005)(36756003)(16526019)(2906002)(54906003)(83380400001)(40460700003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:45.2895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f612bf0-82f0-4c8a-594b-08da509892c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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
 solomon.chiu@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 hersen wu <hersenxs.wu@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why]
when connect one 4k@144hz dp to dsc mst hub, 4k@144hz mode is in valid
mode list. but some mst hub port output bandwidth does not support
4k@144hz.

[How]
add mst port output bandwidth checks, include full_pbn, branch max
throughput mps.

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 36 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  4 +++
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c2fc32dac712..ea91149ec3e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7259,7 +7259,11 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			break;
 		}
 
-		dc_result = dc_validate_stream(adev->dm.dc, stream);
+		if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+			dc_result = dm_dp_mst_is_port_support_mode(aconnector, stream);
+
+		if (dc_result == DC_OK)
+			dc_result = dc_validate_stream(adev->dm.dc, stream);
 
 		if (dc_result != DC_OK) {
 			DRM_DEBUG_KMS("Mode %dx%d (clk %d) failed DC validation with error %d (%s)\n",
@@ -7559,7 +7563,7 @@ static void dm_encoder_helper_disable(struct drm_encoder *encoder)
 
 }
 
-static int convert_dc_color_depth_into_bpc (enum dc_color_depth display_color_depth)
+int convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth)
 {
 	switch (display_color_depth) {
 		case COLOR_DEPTH_666:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index cbd2e8f2ae50..8241a3795762 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -583,7 +583,6 @@ struct amdgpu_dm_connector {
 	struct drm_dp_mst_port *port;
 	struct amdgpu_dm_connector *mst_port;
 	struct drm_dp_aux *dsc_aux;
-
 	/* TODO see if we can merge with ddc_bus or make a dm_connector */
 	struct amdgpu_i2c_adapter *i2c;
 
@@ -747,4 +746,6 @@ int dm_atomic_get_state(struct drm_atomic_state *state,
 struct amdgpu_dm_connector *
 amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 					     struct drm_crtc *crtc);
+
+int convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth);
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index d005bb6a2956..ee5d6fa34a6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1353,4 +1353,40 @@ bool pre_validate_dsc(struct drm_atomic_state *state,
 
 	return (ret == 0);
 }
+
 #endif
+
+enum dc_status dm_dp_mst_is_port_support_mode(
+	struct amdgpu_dm_connector *aconnector,
+	struct dc_stream_state *stream)
+{
+	int bpp, pbn, branch_max_throughput_mps = 0;
+
+	/* check if mode could be supported within fUll_pbn */
+	bpp = convert_dc_color_depth_into_bpc(stream->timing.display_color_depth) * 3;
+	pbn = drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp, false);
+	if (pbn > aconnector->port->full_pbn)
+		return DC_FAIL_BANDWIDTH_VALIDATE;
+
+	/* check is mst dsc output bandwidth branch_overall_throughput_0_mps */
+	switch (stream->timing.pixel_encoding) {
+	case PIXEL_ENCODING_RGB:
+	case PIXEL_ENCODING_YCBCR444:
+		branch_max_throughput_mps =
+			aconnector->dc_sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_0_mps;
+		break;
+	case PIXEL_ENCODING_YCBCR422:
+	case PIXEL_ENCODING_YCBCR420:
+		branch_max_throughput_mps =
+			aconnector->dc_sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_1_mps;
+		break;
+	default:
+		break;
+	}
+
+	if (branch_max_throughput_mps != 0 &&
+		((stream->timing.pix_clk_100hz / 10) >  branch_max_throughput_mps * 1000))
+		return DC_FAIL_BANDWIDTH_VALIDATE;
+
+	return DC_OK;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 2e13027d9b88..b92a7c5671aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -63,4 +63,8 @@ bool pre_validate_dsc(struct drm_atomic_state *state,
 		      struct dm_atomic_state **dm_state_ptr,
 		      struct dsc_mst_fairness_vars *vars);
 
+enum dc_status dm_dp_mst_is_port_support_mode(
+	struct amdgpu_dm_connector *aconnector,
+	struct dc_stream_state *stream);
+
 #endif
-- 
2.25.1

