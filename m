Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C06CAC592
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6B910E3D5;
	Tue, 16 Sep 2025 19:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qxFQ4zzn";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D988B10E3D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYPIOg3anRcfEL+aGJ9E9Q09XFGn3G17vV7Jw7KsGJbecPGvabeARH8PWxD9aPguAsc2+xKoXKSjDmO1VBDBtKpEibV6UnQQbY5yqMG6p/cq1hAyHuUjQSjwnH2O2goH2BaatzUtSbPw6otVdoa8OtvZ5LNm4h8dsSlds905a0hJ024CIa4XTuaRAXyJZtXqjDJt60tOWqwoTgb9hS850qt/yuAW5U5aJ1yfl4VvSjmIPt9A9M7ZnOjaDf9Q10K9rixL7kIntcJZtZgd6f+dYZWPZdNumufNigCa9FMDJByfxNVlYk1REw75svoH5enZrazR7qlFVDEhR1UhaOIezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ahsi/6G82ux1dkDM272m+junMKNetN/GDP+JOf1GQY=;
 b=KB+riQK0m5vte1NBJFyYRhes8Y84UD5ScneFZ8gX5mj7sbQssTWolUYP0tQ8C/3eouu062WQhLpvsUgms0uN6nUBNIHBbo52PZ0r3NmXACbktGl0y00PoJwpJOEfIAfI5iovF7Aqa/MgAfYfZzrWFjJEpzcEn3mezixJnS+e/Yg4dIEJ8K4+KiRuUc/mlqNF18jdGijsi+PgVO7qLm4oCT5QbbW6b/RlkOEOn9cOIowr/xA5j6copBPgG2zdOFjJgdbr2RHPbSOncjdPdXHyLfCUAa6/+NG1XuKojn6YhPp5IFWsAEQuuP5A95tkpn6jRbQkQqfk8zwVvFrGg2mU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ahsi/6G82ux1dkDM272m+junMKNetN/GDP+JOf1GQY=;
 b=qxFQ4zznG95KChEvcXtV9XlI0TaqfPAP883hClN1qB2Ff03zr1G7UdGF6oWQ8zXrUXBDfAmNlM3KzXzzBM0FBopHZVO+nmqA6oo2XvTuL56lbvzdziESSiTEG19kUe85MpoXGaCoA6R8SS1SpVrW/gYqHyr0Nxsep5oG/29hv/A=
Received: from DS7PR03CA0338.namprd03.prod.outlook.com (2603:10b6:8:55::31) by
 SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:08 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::1e) by DS7PR03CA0338.outlook.office365.com
 (2603:10b6:8:55::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 19:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:08 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:08 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:07 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Karthi Kandasamy <karthi.kandasamy@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 03/20] drm/amd/display: Add AVI infoframe copy in
 copy_stream_update_to_stream
Date: Tue, 16 Sep 2025 15:09:23 -0400
Message-ID: <20250916191142.3504643-4-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 89287b62-364e-42b6-e303-08ddf554eecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A7WY5Zpyo/XaCaIcvI8Q3KuxxLtck1nWnOcW0liNDl2Yvx43gB+fs0Hxt8W6?=
 =?us-ascii?Q?PI/hIUax1WNES4vp2nUYgtvKzlD6pifVBk/7P0TbNZP2I9+M+wpKRRXFMLfN?=
 =?us-ascii?Q?CAK6qoIRObKeGQBtzHE06XG10TBE0O+sV3qWjV80oEOJ9L185WJSyu0H8rkW?=
 =?us-ascii?Q?gxcOPZ7Oab3MPafv6x969GROF/4lHSAsrHHb0SpVlyFDfpakMhtp0QyHTupg?=
 =?us-ascii?Q?owkhbnl70+isDi9A1Yz+AMTlvqCg/StdRZzAjh4blnND25/qdZwcBX706RYr?=
 =?us-ascii?Q?j108+hlYYRyfAQmQGP15M5oywd08V0YXVpnFMD6MdzvR8h9wAve06m8tJOcX?=
 =?us-ascii?Q?cNejqXkAuauMFv7CNnprwwOFekt4S9WnhtHcVkJP7YXXc3XNDFojnZ26j4/X?=
 =?us-ascii?Q?jxCW/P8Icbp3bbfRwTgm14BHhpilVsoa1vjGsuZ/ZS4vfGD47LctO0gaOOq4?=
 =?us-ascii?Q?y9XxmA5cKlmZbiKmnNRCRhJ32ypivG6zF1E/KM+n/HOKyNj3iM4VhHW3a/co?=
 =?us-ascii?Q?1Cr2aJDMFjX7kRv9u3NUmp2QS1kIo3IfZZ+5azeIjKpwfvuD6h4KXCVzHJ5A?=
 =?us-ascii?Q?IeeK2lKri+Oq4XVdBQzdWeMNqK3nktIlJey9Cyylv0zItTQJbOxzcJkAHetC?=
 =?us-ascii?Q?YAs4ZzdRTgMuflrnetGIEmi/NT8brMVBgrF8DN/3e65ivcTKFcuqyHmrthPG?=
 =?us-ascii?Q?zJHZUUNaDSXC0Be+Xl2qH2UBo9yEh6jSt6WVnh6FGWHaN23C/MUsM4K1yQff?=
 =?us-ascii?Q?rcpdxlpbKL6hv6GICqRR5jEaZuQdK/NsrT28Mqa801KQdK+FurOgP0Bb6BSy?=
 =?us-ascii?Q?L31PvOA58C0zf7ZJAmLb/GC82utO3SlJlPzVR+BWsvylNeOmawQSEFHAgy6O?=
 =?us-ascii?Q?u813UAZbWmQz6mkuMB9tXIBTOpb2fbDdZuy6zEyMh8rVeCMOw1sm6Tk+TIEt?=
 =?us-ascii?Q?iIBlRZNDAZQf5TdgnrmrHCy5r7YQ6mewnXbyJ7FahWexDIviua6HoPxd7Xan?=
 =?us-ascii?Q?IjMFfS8CnUzVn8QycQCkKXum+vfzSOiE365reKmCmqej7pfPT1w9wMKmpEGr?=
 =?us-ascii?Q?sEOV3KDZT0HM2oAYg9s+OYPX3QJIW4MOXPOqVpJaZqNvH7UMFTpdlnRYH3A4?=
 =?us-ascii?Q?OaGKpvMh5Qwr3QMpJopenyIyLBYmfjqhwRh1Q872W1iFmUqQwx92ibW1gAQ0?=
 =?us-ascii?Q?bA+tY+ngcSiLAYuYxmPHhJuz7qPi5RnuClQwRmIhzrT0eegm0C903xn16U29?=
 =?us-ascii?Q?CPsAxwJzXXCcS8rsoAdPf+vSINh2Rab9itVHhktiv/iZUadZf2x9mDDejUeh?=
 =?us-ascii?Q?MxD8niKffal7lqa65SFhpEtHs29HwqQ/mXyNeqjJLcL7FtDGxX3oYG8yLIMF?=
 =?us-ascii?Q?+tLR7OhAnMVrAy6LgyQw0pSm92qzCh03DqVjKVPU6ygzUzcXtzCrSYsu0d99?=
 =?us-ascii?Q?eZng4IW7G8x+Szq/ydryq7jo+3VBN51iRe2CyxBdRrVQteYUR+oS6kY7JJGV?=
 =?us-ascii?Q?iuReXTtnd+cxL4rlUm6v3oCryFosmgBLHfZk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:08.8068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89287b62-364e-42b6-e303-08ddf554eecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

[WHY]
Ensure AVI infoframe updates from stream updates are applied to the active
stream so OS overrides are not lost.

[HOW]
Copy avi_infopacket to stream when valid flag is set.
Follow existing infopacket copy pattern and perform a basic validity check before assignment.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h        | 3 +++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c4dd52ed377d..974d63af1c70 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3313,6 +3313,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->adaptive_sync_infopacket)
 		stream->adaptive_sync_infopacket = *update->adaptive_sync_infopacket;
 
+	if (update->avi_infopacket)
+		stream->avi_infopacket = *update->avi_infopacket;
+
 	if (update->dither_option)
 		stream->dither_option = *update->dither_option;
 
@@ -3607,7 +3610,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					stream_update->vsp_infopacket ||
 					stream_update->hfvsif_infopacket ||
 					stream_update->adaptive_sync_infopacket ||
-					stream_update->vtem_infopacket) {
+					stream_update->vtem_infopacket ||
+					stream_update->avi_infopacket) {
 				resource_build_info_frame(pipe_ctx);
 				dc->hwss.update_info_frame(pipe_ctx);
 
@@ -5079,6 +5083,7 @@ static bool full_update_required(struct dc *dc,
 			stream_update->hfvsif_infopacket ||
 			stream_update->vtem_infopacket ||
 			stream_update->adaptive_sync_infopacket ||
+			stream_update->avi_infopacket ||
 			stream_update->dpms_off ||
 			stream_update->allow_freesync ||
 			stream_update->vrr_active_variable ||
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index cbca3c67f439..bc5dedf5f60c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4410,8 +4410,14 @@ static void set_avi_info_frame(
 	unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
 	enum dc_timing_3d_format format;
 
+	if (stream->avi_infopacket.valid) {
+		*info_packet = stream->avi_infopacket;
+		return;
+	}
+
 	memset(&hdmi_info, 0, sizeof(union hdmi_info_packet));
 
+
 	color_space = pipe_ctx->stream->output_color_space;
 	if (color_space == COLOR_SPACE_UNKNOWN)
 		color_space = (stream->timing.pixel_encoding == PIXEL_ENCODING_RGB) ?
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 5fc6fea211de..76cf9fdedab0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -203,6 +203,7 @@ struct dc_stream_state {
 	struct dc_info_packet hfvsif_infopacket;
 	struct dc_info_packet vtem_infopacket;
 	struct dc_info_packet adaptive_sync_infopacket;
+	struct dc_info_packet avi_infopacket;
 	uint8_t dsc_packed_pps[128];
 	struct rect src; /* composition area */
 	struct rect dst; /* stream addressable area */
@@ -335,6 +336,8 @@ struct dc_stream_update {
 	struct dc_info_packet *hfvsif_infopacket;
 	struct dc_info_packet *vtem_infopacket;
 	struct dc_info_packet *adaptive_sync_infopacket;
+	struct dc_info_packet *avi_infopacket;
+
 	bool *dpms_off;
 	bool integer_scaling_update;
 	bool *allow_freesync;
-- 
2.43.0

