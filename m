Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2B5C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A1310E4EF;
	Thu, 20 Oct 2022 15:50:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD1C10E6B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6Md6g3ZcLvpvUotpNo9V0NvkvFEwWljQ0WCgNldtyLzRghO8T50x6G+WDNbEjrX7h7hPVL4LXkZQWCTU4z8E1ef/pKarJIcGa+M2gXMPTQ1het4jbWHkcmbsE6j3gbQ8x+5xi96s5QAibDv4rLcaiMkipJWRTpA00uB6AMC6bGA6diAvaXupWVI3jyrJCRHyXRGKdE6oQgh0k4+22La6XvrgXmQv+szW93oEnXJpVRISQqutpx8+G84V6YbDqMKMPrR0QRnW9LpiVGnPIOlEPMjsF86jpwT8ONFPrZRqmqz4zj7njPv0g7iNCSYPhhQRHh14DKvaL2ud2BWnwl5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hC/FibOcQNQ663ZAtxaHuyX0tQCRObYDNnJWwvo1QbM=;
 b=RbKAXW1oyWYLibRHfD183i0KrlbvoCOrbMSmDSRbj4FjH1ALGJoKLNQ+SW0Iyf6sYh1/G+o4ZL7/6EPg0+SBv2km7RycfEEF3Aoh0xivop8ZzPOYZnJhgGLb+xFEYm22iNTV9Z3QjNQyLCtlIyzQEmDoojYro0FLFoOFrLto7vhdWvi7ZWrHquxWl0A8F55Z2hG9HLVlMYJK1I4xLkVmk8px9z2MmBxS0gIPg58ePJYUBNOr4Eqm69dE7dT2+c+jv7K3FNDwJD7XpiB7s4TrcM0OlKW6tGU+EfWBCoWiZ6LRgeq1HM6hppCJ9Ogs7Obg54x5Me+IkaAZEUGT55okNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC/FibOcQNQ663ZAtxaHuyX0tQCRObYDNnJWwvo1QbM=;
 b=KM3Hvfz1MzUs7ojLtHI+927lXHa9hp1RdGATNfBnx3iVC9/ac9tkpR2QFf5xs8e1CPWnt46nFv63XqR9sa/uxdeW8vLD0xh5x62ybcMB2+mW4R3g03WqEROFMtIc+9e1n5QMUGXKRe0AsFZB1xRtrAT1U3iTrJ7VNJBQu6oxVt0=
Received: from DM6PR01CA0026.prod.exchangelabs.com (2603:10b6:5:296::31) by
 SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 15:48:15 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::c6) by DM6PR01CA0026.outlook.office365.com
 (2603:10b6:5:296::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:14 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:13 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/33] drm/amd/display: Wrong colorimetry workaround
Date: Thu, 20 Oct 2022 11:46:56 -0400
Message-ID: <20221020154702.503934-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f148841-8b2c-4892-4b0a-08dab2b28003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FO7cw8MXhsdQ4VvG2B4xzBKOsXVVuwtQyUdhzdMW35rUb4q6vWgWOAEHnDT6YuStCjV50oSqJZzFt/MCjvPeWtffkQYo4M96pOHQqDWAv0cZvDe1/EBscVdVGJhTRfiPi3tRHRAWGELzjjrLXYzyxcyzXQfjqPtWMIjUS6UYRMSWqTIu9Ea5yI5OmysN1egN0O/mTMBw2/GYTNXhkgaJBcCGVvrbI6QwtU6Lzh2iKI4yYvV1Wpg6zTgOecLy5eIJUdD+eKVYnDYvxfcXOo3PM5iTwiiC8QyM/gt19RSCAogkYZAPsZGamQk/Sno50/yqz5Qmb5RwnDl2AMujgEUps/G1GLMTkV1uxhP/9db/KggeSoX8HQzDDi5A/abKBrEFJJOLEuJjIgaO/JfWZhgmRejGYn5JSkMMea0+eJjgMYfz4L+fTYX4hxGoc4jGdRoKR3P83Gc6fNtT6cQLlybdkBN8V5di7UCVG+mgZFhvCj2KHuY5Wb5BC0FaN35MaXvNQAzgwIsys+cEySL9Z6w7bLBbFKnY3V8EKUV6UhQXTpsxJO9SXSfWqFeLw/lB4qkjkvyNXw3dgwr6O6ziwu/jH7nR4DkAvMbS83gQeeptsQ+kSy/qqjc89BkRLbNewbOiIkrwR8TkSkUUC4FhBmBBilxdvXnrlcFduZiAoBMLhtINHHet+ChPifMNhUr3NleUQprsWKfpxcxJucSRCRr74rPT0994cKai6WO8ltawZTDF9pd7Vg+KZRSSMcyHS1npjoffDFoV1SgcaOm3+MbXIz2Amsy30CrWVXP3ONDm1sVLm+7Nb2OjI7YAiRPy/Muf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(478600001)(26005)(2906002)(82740400003)(6666004)(5660300002)(16526019)(36860700001)(8676002)(54906003)(70586007)(70206006)(1076003)(2616005)(47076005)(6916009)(316002)(7696005)(186003)(41300700001)(8936002)(83380400001)(4326008)(336012)(40480700001)(426003)(40460700003)(36756003)(82310400005)(356005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:14.7187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f148841-8b2c-4892-4b0a-08dab2b28003
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
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
Cc: stylon.wang@amd.com, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Ma Hanghong <hanghong.ma@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ma Hanghong <hanghong.ma@amd.com>

[Why]
For FreeSync HDR, native color space flag in AMD VSIF(BT.709) should be
used when intepreting content and color space flag in VSC or AVI
infoFrame should be ignored. However, it turned out some userspace
application still use color flag in VSC or AVI infoFrame which is
incorrect.

[How]
Transfer function is used when building the VSC and AVI infoFrame. Set
colorimetry to BT.709 when all the following match:

1. Pixel format is YCbCr;
2. In FreeSync 2 HDR, color is COLOR_SPACE_2020_YCBCR;
3. Transfer function is TRANSFER_FUNC_GAMMA_22;

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Ma Hanghong <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 5 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 6 ++++++
 drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h   | 3 ++-
 .../gpu/drm/amd/display/modules/info_packet/info_packet.c   | 6 +++++-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1e67366b3536..d69c71f21720 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5711,6 +5711,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
 	int mode_refresh;
 	int preferred_refresh = 0;
+	enum color_transfer_func tf = TRANSFER_FUNC_UNKNOWN;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dsc_dec_dpcd_caps dsc_caps;
 #endif
@@ -5834,7 +5835,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
 				stream->use_vsc_sdp_for_colorimetry = true;
 		}
-		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space);
+		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
+			tf = TRANSFER_FUNC_GAMMA_22;
+		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
 		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ba2d4347f722..d99f1c4b9584 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3015,6 +3015,12 @@ static void set_avi_info_frame(
 		hdmi_info.bits.C0_C1   = COLORIMETRY_EXTENDED;
 	}
 
+	if (pixel_encoding && color_space == COLOR_SPACE_2020_YCBCR &&
+			stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
+		hdmi_info.bits.EC0_EC2 = 0;
+		hdmi_info.bits.C0_C1 = COLORIMETRY_ITU709;
+	}
+
 	/* TODO: un-hardcode aspect ratio */
 	aspect = stream->timing.aspect_ratio;
 
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 1d8b746b02f2..edf5845f6a1f 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -35,7 +35,8 @@ struct mod_vrr_params;
 
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
-		enum dc_color_space cs);
+		enum dc_color_space cs,
+		enum color_transfer_func tf);
 
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet);
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 27ceba9d6d65..69691058ab89 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -132,7 +132,8 @@ enum ColorimetryYCCDP {
 
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
-		enum dc_color_space cs)
+		enum dc_color_space cs,
+		enum color_transfer_func tf)
 {
 	unsigned int vsc_packet_revision = vsc_packet_undefined;
 	unsigned int i;
@@ -382,6 +383,9 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 				colorimetryFormat = ColorimetryYCC_DP_AdobeYCC;
 			else if (cs == COLOR_SPACE_2020_YCBCR)
 				colorimetryFormat = ColorimetryYCC_DP_ITU2020YCbCr;
+
+			if (cs == COLOR_SPACE_2020_YCBCR && tf == TRANSFER_FUNC_GAMMA_22)
+				colorimetryFormat = ColorimetryYCC_DP_ITU709;
 			break;
 
 		default:
-- 
2.35.1

