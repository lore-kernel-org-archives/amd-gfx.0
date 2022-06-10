Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5880C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45CC410F7AE;
	Fri, 10 Jun 2022 20:53:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899A5112104
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz+dt9aMEbYXM5f2lclWnSn/JzzDwwx6sTPKaGzbGKyrl2Ah8tEAD29SaZsbrwIz4A45ZmMNAnGUWceJPZ1Dj7KT2N5mXxc5mrDgzda9lXzn8AlehoOKoyg8R+0kPakXEgXE33dStKKdoQsFCvisy/5ElmrYB3k7xq01vIxKchhBOwGNNYuoawvF7KS+vda5rA8xw0k/0iGCbkmVe/Gc7CXME8fjcNNNOtAa/QJwgQBvSPmd4imLwZwXU4C2mY+YQre4HQsLTt4I6YmeU9yrJnnbdgfdxmudSAzNmhU3yvBIkSsW7Y116UXTSB1jDuDJ/4nD2hXMz8JC/Pz8lZfOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paFWgQInezvl6zjq1oP1s73t1jEqcoCeV7jYsPv8RcM=;
 b=gIurmu96esJKqibku3BRU9V22c/TQJoZAQ5NgapzhP21ygFXVUs+CF0N9OgFn5BX/HdSZZ5NM8uiocRHWkIM0CzHYoBZ5hj1vZmbgoU9S5KZLgTuinqWS1vk4YAQ8lr5tJutWAOvWieowR7j1fGly4fUHHntR0DMZSXZONPvtftGh2KmeTQ3nQsqRvlDcGhCzJJr+0p4J0Isw8toLCx3aN0HgYHbxGMXOIxZk7NNmBJJT7Yma6a183DhGW6TOpINJe3Fcfnh/hwIXV2CulhRFt8ZkM7NZQu73Fvu/6AqdiBshHW5y5yWR1ZKVXVcxzqFUwBEz78H0w/40iR1JCHO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paFWgQInezvl6zjq1oP1s73t1jEqcoCeV7jYsPv8RcM=;
 b=Ti+PDrMAekIwsK86sDfr4yGvT8ESE/HOcpFxKAXeaDey/vnEZVmes3tI3F8fssxMlzCrMdNzmcGNiNZvD2IXaSbmc3M8MBrG6EnWp3EgB2fDgR10cxGSN33cxH+8z4uX6EilLySu9K/yDcvdbbuXaMKjSWOIpxChwY4MyliKVFg=
Received: from MW4PR02CA0012.namprd02.prod.outlook.com (2603:10b6:303:16d::35)
 by BN6PR12MB1553.namprd12.prod.outlook.com (2603:10b6:405:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Fri, 10 Jun
 2022 20:53:39 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::91) by MW4PR02CA0012.outlook.office365.com
 (2603:10b6:303:16d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:38 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:33 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/23] drm/amd/display: Adding VTEM to dc
Date: Fri, 10 Jun 2022 16:52:40 -0400
Message-ID: <20220610205245.174802-19-hamza.mahfooz@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f3660b2-89c8-4cf7-9cf7-08da4b234b84
X-MS-TrafficTypeDiagnostic: BN6PR12MB1553:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1553C8A4CB9125ADDD220916F4A69@BN6PR12MB1553.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/egBWx2DRUp+f0kKKCDtNDa+AJi5czQuBvJ5IYX7PITaWpF/uqDGDe2n9vz3qACMnPKXEbAAXy6rsGOLt/Zke29K1AIt4VCsqFX6ENKQugmKMiaZwW6V7VBp/C43ndBt5PGPUabthLevVajfAh0D05zVsPoukMTFSFXUufm/IiRQ70ieWQyo0TjBypWK1MIU678G4VT+vYrnuSX+bbGaK5sfJ0aCWCztUOJX0+RxMpHt4ymMpyhJxfr1FNXYQqAw4xtidCVkUqEQMu0rAr5lmkQsJOswtimMulPYnKiU3XuZxVXyc4GbV5EyvYdqrjfQmXpmcENbS+eqtrMJcxtJ2PmcdWUoD2yLPXstsMF0L4EF5MLlpEBiBPJvVP5R2SqjNWKlpwG2Zn7UkaDA48S3zGbNt7EWWjveTuBw0dPnrNZLnes77Empt6LuF/tl3LBsu9CQyl8jrg5rtEVE48exx/MNUACvuLuJbgWpv8ebdN9j+Y4baiBVrSYD+bar7NU66yDrlKV0k8WQBwNiAXIVXX+nN647EN1AkpBQrK02NzUHjfARbqQ3I/JmNFzn4XdPpNPZ21udq1+VVuq2H0XQAdgMynf9PdHdBMEjZ2d2QhV9ZmrIKxo8H67kdFJrdDndUofafsXmnMPbNrVZ0EQvktK60Gdq7kiukP3uFntMvXsMCJ8a5U7bDIDizJ7VWUEVdd80BkbMZp/lut0oghxRiEE/IMkRxN8EnmOVmLNg1Qs68jifIeBhY4F0b9AnKgx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(86362001)(4326008)(7696005)(81166007)(44832011)(70586007)(70206006)(6666004)(336012)(16526019)(8676002)(508600001)(1076003)(2616005)(186003)(2906002)(54906003)(6916009)(316002)(26005)(426003)(47076005)(82310400005)(83380400001)(356005)(36756003)(36860700001)(8936002)(40460700003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:38.7392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3660b2-89c8-4cf7-9cf7-08da4b234b84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1553
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
Video Timing Extended Metadata packet (VTEM) is required for features
like VRR and FVA

[How]
Adding support for VTEM transmission to stream encoders in DCN20 and DCN30
as part of FVA support

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Ahmad Othman <ahmad.othman@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  6 +++++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  | 14 +++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |  2 ++
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c    |  1 +
 .../display/dc/dcn30/dcn30_dio_stream_encoder.c    |  1 +
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |  1 +
 6 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 400b37e393b7..7c2b65226131 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2661,6 +2661,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->hfvsif_infopacket)
 		stream->hfvsif_infopacket = *update->hfvsif_infopacket;
 
+	if (update->vtem_infopacket)
+		stream->vtem_infopacket = *update->vtem_infopacket;
+
 	if (update->vsc_infopacket)
 		stream->vsc_infopacket = *update->vsc_infopacket;
 
@@ -2736,7 +2739,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					stream_update->vrr_infopacket ||
 					stream_update->vsc_infopacket ||
 					stream_update->vsp_infopacket ||
-					stream_update->hfvsif_infopacket) {
+					stream_update->hfvsif_infopacket ||
+					stream_update->vtem_infopacket) {
 				resource_build_info_frame(pipe_ctx);
 				dc->hwss.update_info_frame(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 5749db88b7c3..60b780385bbd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2816,6 +2816,17 @@ static void set_hfvs_info_packet(
 	*info_packet = stream->hfvsif_infopacket;
 }
 
+
+static void set_vtem_info_packet(
+		struct dc_info_packet *info_packet,
+		struct dc_stream_state *stream)
+{
+	if (!stream->vtem_infopacket.valid)
+		return;
+
+	*info_packet = stream->vtem_infopacket;
+}
+
 void dc_resource_state_destruct(struct dc_state *context)
 {
 	int i, j;
@@ -2896,7 +2907,7 @@ void resource_build_info_frame(struct pipe_ctx *pipe_ctx)
 	info->hdrsmd.valid = false;
 	info->vsc.valid = false;
 	info->hfvsif.valid = false;
-
+	info->vtem.valid = false;
 	signal = pipe_ctx->stream->signal;
 
 	/* HDMi and DP have different info packets*/
@@ -2905,6 +2916,7 @@ void resource_build_info_frame(struct pipe_ctx *pipe_ctx)
 
 		set_vendor_info_packet(&info->vendor, pipe_ctx->stream);
 		set_hfvs_info_packet(&info->hfvsif, pipe_ctx->stream);
+		set_vtem_info_packet(&info->vtem, pipe_ctx->stream);
 
 		set_spd_info_packet(&info->spd, pipe_ctx->stream);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 376dddf54ec1..c76fac3c153d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -181,6 +181,7 @@ struct dc_stream_state {
 	struct dc_info_packet vsc_infopacket;
 	struct dc_info_packet vsp_infopacket;
 	struct dc_info_packet hfvsif_infopacket;
+	struct dc_info_packet vtem_infopacket;
 	uint8_t dsc_packed_pps[128];
 	struct rect src; /* composition area */
 	struct rect dst; /* stream addressable area */
@@ -298,6 +299,7 @@ struct dc_stream_update {
 	struct dc_info_packet *vsc_infopacket;
 	struct dc_info_packet *vsp_infopacket;
 	struct dc_info_packet *hfvsif_infopacket;
+	struct dc_info_packet *vtem_infopacket;
 	bool *dpms_off;
 	bool integer_scaling_update;
 	bool *allow_freesync;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index aab25ca8343a..e8f5c01688ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -159,6 +159,7 @@ static void enc2_stream_encoder_update_hdmi_info_packets(
 	enc2_update_hdmi_info_packet(enc1, 3, &info_frame->vendor);
 	enc2_update_hdmi_info_packet(enc1, 4, &info_frame->spd);
 	enc2_update_hdmi_info_packet(enc1, 5, &info_frame->hdrsmd);
+	enc2_update_hdmi_info_packet(enc1, 6, &info_frame->vtem);
 }
 
 static void enc2_stream_encoder_stop_hdmi_info_packets(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 1a26ce87c16e..25e5c3bc1be9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -212,6 +212,7 @@ void enc3_stream_encoder_update_hdmi_info_packets(
 	enc3_update_hdmi_info_packet(enc1, 1, &info_frame->vendor);
 	enc3_update_hdmi_info_packet(enc1, 3, &info_frame->spd);
 	enc3_update_hdmi_info_packet(enc1, 4, &info_frame->hdrsmd);
+	enc3_update_hdmi_info_packet(enc1, 6, &info_frame->vtem);
 }
 
 void enc3_stream_encoder_stop_hdmi_info_packets(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index e5fe0f6adc86..e04a51a57c93 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -77,6 +77,7 @@ struct encoder_info_frame {
 	struct dc_info_packet gamut;
 	struct dc_info_packet vendor;
 	struct dc_info_packet hfvsif;
+	struct dc_info_packet vtem;
 	/* source product description */
 	struct dc_info_packet spd;
 	/* video stream configuration */
-- 
2.36.1

