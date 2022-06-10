Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F77FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2CB10FF82;
	Fri, 10 Jun 2022 20:53:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64EAF112A00
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQu5srl9T4WZHm30erj+FUC7domGlsFPXOuXyqFywJ8BzztgKzuKOkA9NOkAWvQ1X7gkiye4Ux0bk+a+IjHRCVut++b/jlGCSJ/XCthyF1EIr9cOW2vV35cxuImV+MHeEAkF3nfxUy3rsQnj6/z6kM6bwpw7dkDG/SXeo4Ogvc4NAXiSPY2jNtGnePn2x0Z58FiiGTxlzhqygv3h9DVgz/mZCFq04x/++sd0Y4KhG0zjN2nqCR3nJmWYAIGHy8FrjKxqmADNr+692VuuZVKmJgkMoAHYSKfw3hnpAecMPVBTuoGT4lI2Xm6vOHM9TpWXRdwUSiyCSgcyfqmd20lJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0MXUsdUFxXKodZzwbQgwygPfO+yv443eVjOJJRnoiY=;
 b=SV/NNkoGby96c1zQATs8pJk4B2qoUv9iRXi1RGQyrKFrU4vCTzXrYd66sSdgJhfvGtlvluz6xlM2n+j5S1JhoRbV/81Baebl4dG5oHWTsbXsShTyGDLXvwQrYeMPGAvc8Q6R6V4irp7MpMSjPNxQxZhgmwO1ytZ1bZs2Y4i15du0A/FDb6iEacPYQ9WHoCnV5smfiRbvfwSfL0CEC3/n78W6JYkEkiRNQJdCbDaFbhEBmHTXWNTnk6lKNWy+SB7G5X7C/CjYKSqtMBtin34QCMoWZbEVazU/FT0b0SxENs68E3NbZZX1BhM1HAKFHSzs9lZJU2jI8guk/HmVbhe9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0MXUsdUFxXKodZzwbQgwygPfO+yv443eVjOJJRnoiY=;
 b=DKTxwX8IpX5Vo19hXKVABrAnyiKcFGHFR9lG9p4MQshZfCn/rCHVRp1etKF9h1jNbjJ5NOLBHvNv4Wl6Pn5dJUNN48ZI5XciUxvFP7hw0gxYWM0Ao6s37jLsTk5SQVdZaXayQ8BJye1hQ8BVCNRAQdJHBTEuz/ki8k1h54NOFCc=
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Fri, 10 Jun
 2022 20:53:35 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::7a) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:34 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:29 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/23] drm/amd/display: Add support for HF-VSIF
Date: Fri, 10 Jun 2022 16:52:38 -0400
Message-ID: <20220610205245.174802-17-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc80f80-cb94-4c15-e3eb-08da4b234933
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6314:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB63143CB87228E578FFE08262F4A69@SJ1PR12MB6314.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k137Q+7Z+00ubEs7TL3/XFjr/0/EDmhyx/r+rPackhVnxHOrzhXUzQp772PEUobS2f6pCr3Zb8CvcwWU0ki0GCSCT1JlEHwAyu6IxNcgO7Syd2KAVwjkh122ziWLy07StMKyA4H0X5vRq/k+6K1Hz+hBgOJnnkyzHFBgvUN9hH9/NcOyOdUu17aXzbo/jqEFeD4XmDGpHA3kbXvi0hBrkrg+8kS8enjH1rEr5rU6UGbuXZNwsuzz1mDeuLHGjQYmVj7NqdgtS/84rca1YmZoRq4axLP5XQUfZEjWxaGUlLsRz5H9yEyM5a8SIvtOxKbWQiC16WJcYNLQ7knXqNVyZAnLhxX2RZenKmDAo2qIqQPMZhtuBVVaLKhhFu91tNC2jMzbZMlvhLJFv1Ux1HZsBRzoPpkJAkpGfi55ziunM5tlncg9+8PzlIF1Ihl+ry0BjJYmvzQOPlK6WAV01av1qmRNaDGso1k6bk8DhILSsdkUV04vCigDt000TR8cP6AI+sb0WSPZ89T5pOX78YJvqBwvGJ/A8viLrAjndKoYqJU8zgaWSJDmU/yPtHRvqvZRGepXId0ISeeGbvbJC8sWBeBOcFC3trMRX2dWm60mrQ2wSI2/2CiQJvat3OC8VrEGSgRU9yFuHTa41VRCAWiubvCZLLk66NAP5kNVS7VVe5I8IqeKpykMAG2WT3EQ3lmyizTfJXhFynRtJzLa02IKVd3vpfBVtQkrBK2P0bS43GS7vOzowPIWji0HHyYB6Rxh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(70586007)(70206006)(2616005)(36860700001)(356005)(82310400005)(8676002)(4326008)(508600001)(86362001)(83380400001)(1076003)(316002)(6916009)(54906003)(16526019)(44832011)(7696005)(186003)(36756003)(5660300002)(40460700003)(26005)(8936002)(47076005)(426003)(336012)(81166007)(6666004)(2906002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:34.8547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc80f80-cb94-4c15-e3eb-08da4b234933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Ahmad Othman <ahmad.othman@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ahmad Othman <ahmad.othman@amd.com>

[Why]
- Currently there is no support for HF-VSIF
- The current support of VSIF is limited to H14b infoframe

[How]
- refactor VSIF
- Added new builder for HF-VSIF
- Added the HF-VSIF packet to DisplayTarget
- Updates DC to apply HF-VSIF updates when updating streams

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Ahmad Othman <ahmad.othman@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c              |  3 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c     | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h            |  2 ++
 .../drm/amd/display/dc/dcn10/dcn10_stream_encoder.c   |  8 +++++---
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cfa6c2d1fc69..7d71fd61c0a5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2732,7 +2732,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
 			if ((stream_update->hdr_static_metadata && !stream->use_dynamic_meta) ||
 					stream_update->vrr_infopacket ||
 					stream_update->vsc_infopacket ||
-					stream_update->vsp_infopacket) {
+					stream_update->vsp_infopacket ||
+					stream_update->hfvsif_infopacket) {
 				resource_build_info_frame(pipe_ctx);
 				dc->hwss.update_info_frame(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 21d217e84192..5749db88b7c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2806,6 +2806,15 @@ static void set_vsc_info_packet(
 
 	*info_packet = stream->vsc_infopacket;
 }
+static void set_hfvs_info_packet(
+		struct dc_info_packet *info_packet,
+		struct dc_stream_state *stream)
+{
+	if (!stream->hfvsif_infopacket.valid)
+		return;
+
+	*info_packet = stream->hfvsif_infopacket;
+}
 
 void dc_resource_state_destruct(struct dc_state *context)
 {
@@ -2886,6 +2895,7 @@ void resource_build_info_frame(struct pipe_ctx *pipe_ctx)
 	info->spd.valid = false;
 	info->hdrsmd.valid = false;
 	info->vsc.valid = false;
+	info->hfvsif.valid = false;
 
 	signal = pipe_ctx->stream->signal;
 
@@ -2894,6 +2904,7 @@ void resource_build_info_frame(struct pipe_ctx *pipe_ctx)
 		set_avi_info_frame(&info->avi, pipe_ctx);
 
 		set_vendor_info_packet(&info->vendor, pipe_ctx->stream);
+		set_hfvs_info_packet(&info->hfvsif, pipe_ctx->stream);
 
 		set_spd_info_packet(&info->spd, pipe_ctx->stream);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 68cf06a5a3e3..376dddf54ec1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -180,6 +180,7 @@ struct dc_stream_state {
 	struct dc_info_packet vrr_infopacket;
 	struct dc_info_packet vsc_infopacket;
 	struct dc_info_packet vsp_infopacket;
+	struct dc_info_packet hfvsif_infopacket;
 	uint8_t dsc_packed_pps[128];
 	struct rect src; /* composition area */
 	struct rect dst; /* stream addressable area */
@@ -296,6 +297,7 @@ struct dc_stream_update {
 	struct dc_info_packet *vrr_infopacket;
 	struct dc_info_packet *vsc_infopacket;
 	struct dc_info_packet *vsp_infopacket;
+	struct dc_info_packet *hfvsif_infopacket;
 	bool *dpms_off;
 	bool integer_scaling_update;
 	bool *allow_freesync;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 7608187751c8..92f474e6a96b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -675,11 +675,13 @@ static void enc1_stream_encoder_update_hdmi_info_packets(
 	/* for bring up, disable dp double  TODO */
 	REG_UPDATE(HDMI_DB_CONTROL, HDMI_DB_DISABLE, 1);
 
+	/*Always add mandatory packets first followed by optional ones*/
 	enc1_update_hdmi_info_packet(enc1, 0, &info_frame->avi);
-	enc1_update_hdmi_info_packet(enc1, 1, &info_frame->vendor);
+	enc1_update_hdmi_info_packet(enc1, 1, &info_frame->hfvsif);
 	enc1_update_hdmi_info_packet(enc1, 2, &info_frame->gamut);
-	enc1_update_hdmi_info_packet(enc1, 3, &info_frame->spd);
-	enc1_update_hdmi_info_packet(enc1, 4, &info_frame->hdrsmd);
+	enc1_update_hdmi_info_packet(enc1, 3, &info_frame->vendor);
+	enc1_update_hdmi_info_packet(enc1, 4, &info_frame->spd);
+	enc1_update_hdmi_info_packet(enc1, 5, &info_frame->hdrsmd);
 }
 
 static void enc1_stream_encoder_stop_hdmi_info_packets(
-- 
2.36.1

