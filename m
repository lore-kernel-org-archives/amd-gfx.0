Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC45C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1C710EAE2;
	Thu, 20 Jun 2024 16:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dI6poh0p";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0960810EAE2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVrYsDY+0RuRktw0Ng8Cu51R2ektrEOCWNHbJxULheRqlWtJwiBlUBTLJDI8IhAkjlirSBe0EqRCtt2vSkuzFtQo9SVMhuESiXOpRzHr9qPZo/SwDlybbSRh8Mm8gcYTNeRF9YyhtvWpoV+NcZa7VAZb+GjYegccxABOISRhyxaMi2RcLdjml8JIa7JGbZsCFNGovS+vIJEbl5DzgQfOveJ2pcGTCpXhJa30eiqU0XXntOk1RgkojpgJLDGB7Pn7zDav79LNKTLKc206QoVI0lq/dkJMiLfCQDgPsFNd2XJVqJayKaMzzh0GzqyB+1Yk+5nfIh+eCxYteJzPF0YhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teRGtTtoZaiTY0t1OW67aOIhXHUOkVDDeYH5vyJPYeU=;
 b=B5N/7Nze7mvvQ8qlq7t4FRH9V68wZEbW53pAeMfh89qS+36l6cGLO7qn0/g/Ni1Zo75sonaoe5tMkFgxQm73TnJywezRgPDVdyFQ3W5nk66MoyzwtjUjg9frc+sz+0YcwhRm3MUkD+AmlKKxFWFgun7lMqLBnHdjOPziGb6xx6XOMuX4lLGzndXIK8A1XaaAeGGDs/cNvWa9SPCa8ymR8NzXA5guPgdcW4wFH6YTI/PdSOrXmzF/b5Ks/iISCk5XuaSdEP7fDH/vDdSVziA1DxpTYmyaOhtQu+cDyfPYtHtUWTUD1JQuggjIYrOXVyLiwaOtP1JM4SdY+Ws9cJkOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teRGtTtoZaiTY0t1OW67aOIhXHUOkVDDeYH5vyJPYeU=;
 b=dI6poh0pkOWb4evt8TMYvVPtfPiS8kOKzI6hQZLu6Cd9jIYjTBJg2nDXZ8qrAChtvywta5tWbJgdCRHFsezHkJ/V8oEhouJX9jTzJovhcPY/LWfjw1G+/YFBn3TeBtG0vLzhZRP+LEyl0x2wOlJLxrKbrXdt+jaS28f5ZWjL9KY=
Received: from PH7PR10CA0014.namprd10.prod.outlook.com (2603:10b6:510:23d::16)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 16:12:56 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::ac) by PH7PR10CA0014.outlook.office365.com
 (2603:10b6:510:23d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:12:56 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:12:43 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ivan Lipski <ivlipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 03/39] drm/amd/display: Remove redundant var from
 display_rq_dig_calc in dml
Date: Thu, 20 Jun 2024 10:11:09 -0600
Message-ID: <20240620161145.2489774-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a5f955-0374-45ca-86c6-08dc9143d898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CAgfzIBNFNMld56IT5Pcw4JrCXiDm3tXGp8fZ8CUUjp/gjloa7ZadDZCqV21?=
 =?us-ascii?Q?OpPhlB5j+SpKXWvbf4BSfvrqpE2Ujmra+h+t2W2kSuBrbw83KSGErOTPmel1?=
 =?us-ascii?Q?H7wB7dIabc8qlylC3rsICNqT/KqWME7+2ESYMUoxjPcPWXFjfu+xUJpje5nZ?=
 =?us-ascii?Q?g321jXnI3Cy/2PwXXOQbHLFtC96PxSGwNWvaT1FVkcpgfDDH9ADqvCTreQfK?=
 =?us-ascii?Q?AkEPSxe5VGZggw0zzqKakRRiYG+s10gjBUurMvrZTp3CfUncjxAXB8fl1BQw?=
 =?us-ascii?Q?37/tl+Ja65I9cH9Ms2zRvp0NcMfqKAGZSjIsyeIr65BIoqD612L2kXCpjdl8?=
 =?us-ascii?Q?AUyK5RRhM1c6SfSIerUurmEBzV0rPiL3KgnJeuHlCJhG5pQOzwL04Nw4URnv?=
 =?us-ascii?Q?OklqI4H0y9fO8kjG5iM2YE1Bw/tO7iENfaxwmn01wpE9lFp3HC0XaSNSKnLt?=
 =?us-ascii?Q?Sqoxns0CIjhZflMtG5F+xdFGtRHi6MOiJTHfdJc1jYFGDd+5dEsoU0fla+xn?=
 =?us-ascii?Q?G0cVV+VSA7HwR0H88mp6yCWm/LoUyZP9sO4baZtcOdc32L//JLw4VPY+d0H+?=
 =?us-ascii?Q?BYV4Vc2HrsiFTtmKhKP4IP14qQFxmGBDmgp3OlTkF12fO28lDqJES26hwLjq?=
 =?us-ascii?Q?jyQ8EBxzp+cYFIc2nyG5m6hvZYT/ius68N7wgj5Nw3lSYjMyEgUVbsJOGg7u?=
 =?us-ascii?Q?6ZISq6VaA5oB7vwbzskoDh535vMLWq/krMp94SkIdAWSpHWmGENrnq6INut0?=
 =?us-ascii?Q?kO93b5N9SWvObJOWDLzyFwZmocCypAkEP+r3E6UiCnTPtgS60VPjls1bWxTc?=
 =?us-ascii?Q?FUvHG9kzdJDugQOUYvr6MKXTxxGWU4ZYZpf6DYhQFr2ABoBIYd2F7twHYbJi?=
 =?us-ascii?Q?Gts+olj6fAYoNViPkRKzVGJFGfeiTXwCqnEpK9DbyvVNGpr19qR1Mj85lOc7?=
 =?us-ascii?Q?HneCLkWbyt3G5m0XOgy7oPLci3iXCDrS+r3D5WnYT7ncbJlVkemJyj2QEboP?=
 =?us-ascii?Q?YMomMvr8M1XylYoJFACnUp0wWIccoKBpnBv1240+iKcclGpR3f+H0l6Nw8gX?=
 =?us-ascii?Q?sAhMdghYINkGvQ5GfssiujbUq9dWghKGUzSg2kR9f2QkjSeY8DnLuCRIEMPf?=
 =?us-ascii?Q?myVSpr6VYMY03bcIDKlEe7nt6pjClGjCnH6D08NvPGitmpaPETYgTrKzAOaB?=
 =?us-ascii?Q?VAXDm/rSvZl+be3cdt+9tRFbCa9xJD9/XXjosB/o2wbdAgtMnB+CCeLxJeTP?=
 =?us-ascii?Q?2A1LKt5vaHv6AiMlrpd9y0xzGkjdOM9o1dBsU1ZwzyFF6pgH0FpjZQ3x7/cF?=
 =?us-ascii?Q?CokbGiQi0PsMV7Hn4IJ+6W7L3RkZo0SqDEJ0g7/AgmyvrxFHt9BoxSz404TP?=
 =?us-ascii?Q?i2/tSlIAyH4tnejPilYn8BX5pBWp7gF7a9RIcY6mmu/ZEWmYYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:12:56.1384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a5f955-0374-45ca-86c6-08dc9143d898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis flagged these files as containing DEADCODE, i. e.
redundant or unreachabale. In these files, variable 'mode_422' is
always the same file (0 or false), so any code logic with it is
redundant.

[HOW]
Removed 'mode_422' variable and all code with it from
'display_rq_dlg_calc_' functions in dml.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  | 14 +++-----------
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        | 14 +++-----------
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  | 14 +++-----------
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  | 14 +++-----------
 .../display/dc/dml/dcn31/display_rq_dlg_calc_31.c  | 14 +++-----------
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c        | 14 +++-----------
 6 files changed, 18 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 07146569e335..7c56ad0f8812 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -688,12 +688,11 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 		const display_pipe_source_params_st *pipe_src_param,
 		bool is_chroma)
 {
-	bool mode_422 = false;
 	unsigned int vp_width = 0;
 	unsigned int vp_height = 0;
 	unsigned int data_pitch = 0;
 	unsigned int meta_pitch = 0;
-	unsigned int ppe = mode_422 ? 2 : 1;
+	unsigned int ppe = 1;
 
 	// TODO check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma) {
@@ -825,7 +824,6 @@ static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	double min_dst_y_ttu_vblank;
 	unsigned int dlg_vblank_start;
 	bool dual_plane;
-	bool mode_422;
 	unsigned int access_dir;
 	unsigned int vp_height_l;
 	unsigned int vp_width_l;
@@ -971,7 +969,6 @@ static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	// Source
 //             dcc_en              = src.dcc;
 	dual_plane = is_dual_plane((enum source_format_class)(src->source_format));
-	mode_422 = false; // TODO
 	access_dir = (src->source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
 //      bytes_per_element_l = get_bytes_per_element(source_format_class(src.source_format), 0);
 //      bytes_per_element_c = get_bytes_per_element(source_format_class(src.source_format), 1);
@@ -1148,13 +1145,8 @@ static void dml20_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	dpte_row_height_l = rq_dlg_param->rq_l.dpte_row_height;
 	dpte_row_height_c = rq_dlg_param->rq_c.dpte_row_height;
 
-	if (mode_422) {
-		swath_width_pixels_ub_l = swath_width_ub_l * 2;  // *2 for 2 pixel per element
-		swath_width_pixels_ub_c = swath_width_ub_c * 2;
-	} else {
-		swath_width_pixels_ub_l = swath_width_ub_l * 1;
-		swath_width_pixels_ub_c = swath_width_ub_c * 1;
-	}
+	swath_width_pixels_ub_l = swath_width_ub_l;
+	swath_width_pixels_ub_c = swath_width_ub_c;
 
 	if (htaps_l <= 1)
 		min_hratio_fact_l = 2.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index f4bba1f2aeb6..3d95bfa5aca2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -688,12 +688,11 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 		const display_pipe_source_params_st *pipe_src_param,
 		bool is_chroma)
 {
-	bool mode_422 = false;
 	unsigned int vp_width = 0;
 	unsigned int vp_height = 0;
 	unsigned int data_pitch = 0;
 	unsigned int meta_pitch = 0;
-	unsigned int ppe = mode_422 ? 2 : 1;
+	unsigned int ppe = 1;
 
 	// TODO check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma) {
@@ -825,7 +824,6 @@ static void dml20v2_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	double min_dst_y_ttu_vblank;
 	unsigned int dlg_vblank_start;
 	bool dual_plane;
-	bool mode_422;
 	unsigned int access_dir;
 	unsigned int vp_height_l;
 	unsigned int vp_width_l;
@@ -972,7 +970,6 @@ static void dml20v2_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	// Source
 //             dcc_en              = src.dcc;
 	dual_plane = is_dual_plane((enum source_format_class)(src->source_format));
-	mode_422 = false; // TODO
 	access_dir = (src->source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
 //      bytes_per_element_l = get_bytes_per_element(source_format_class(src.source_format), 0);
 //      bytes_per_element_c = get_bytes_per_element(source_format_class(src.source_format), 1);
@@ -1149,13 +1146,8 @@ static void dml20v2_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	dpte_row_height_l = rq_dlg_param->rq_l.dpte_row_height;
 	dpte_row_height_c = rq_dlg_param->rq_c.dpte_row_height;
 
-	if (mode_422) {
-		swath_width_pixels_ub_l = swath_width_ub_l * 2;  // *2 for 2 pixel per element
-		swath_width_pixels_ub_c = swath_width_ub_c * 2;
-	} else {
-		swath_width_pixels_ub_l = swath_width_ub_l * 1;
-		swath_width_pixels_ub_c = swath_width_ub_c * 1;
-	}
+	swath_width_pixels_ub_l = swath_width_ub_l;
+	swath_width_pixels_ub_c = swath_width_ub_c;
 
 	if (htaps_l <= 1)
 		min_hratio_fact_l = 2.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index c229a9edf82a..98502a4f0567 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -694,12 +694,11 @@ static void get_surf_rq_param(
 		const display_pipe_params_st *pipe_param,
 		bool is_chroma)
 {
-	bool mode_422 = false;
 	unsigned int vp_width = 0;
 	unsigned int vp_height = 0;
 	unsigned int data_pitch = 0;
 	unsigned int meta_pitch = 0;
-	unsigned int ppe = mode_422 ? 2 : 1;
+	unsigned int ppe = 1;
 
 	// FIXME check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma) {
@@ -868,7 +867,6 @@ static void dml_rq_dlg_get_dlg_params(
 	double min_dst_y_ttu_vblank;
 	unsigned int dlg_vblank_start;
 	bool dual_plane;
-	bool mode_422;
 	unsigned int access_dir;
 	unsigned int vp_height_l;
 	unsigned int vp_width_l;
@@ -1020,7 +1018,6 @@ static void dml_rq_dlg_get_dlg_params(
 	// Source
 	//             dcc_en              = src.dcc;
 	dual_plane = is_dual_plane((enum source_format_class) (src->source_format));
-	mode_422 = false; // FIXME
 	access_dir = (src->source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
 						    //      bytes_per_element_l = get_bytes_per_element(source_format_class(src.source_format), 0);
 						    //      bytes_per_element_c = get_bytes_per_element(source_format_class(src.source_format), 1);
@@ -1197,13 +1194,8 @@ static void dml_rq_dlg_get_dlg_params(
 	dpte_row_height_l = rq_dlg_param->rq_l.dpte_row_height;
 	dpte_row_height_c = rq_dlg_param->rq_c.dpte_row_height;
 
-	if (mode_422) {
-		swath_width_pixels_ub_l = swath_width_ub_l * 2;  // *2 for 2 pixel per element
-		swath_width_pixels_ub_c = swath_width_ub_c * 2;
-	} else {
-		swath_width_pixels_ub_l = swath_width_ub_l * 1;
-		swath_width_pixels_ub_c = swath_width_ub_c * 1;
-	}
+	swath_width_pixels_ub_l = swath_width_ub_l;
+	swath_width_pixels_ub_c = swath_width_ub_c;
 
 	if (hratio_l <= 1)
 		min_hratio_fact_l = 2.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index f3ee7baac786..b28fcc8608ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -660,13 +660,12 @@ static void get_surf_rq_param(struct display_mode_lib *mode_lib,
 	bool is_chroma,
 	bool is_alpha)
 {
-	bool mode_422 = 0;
 	unsigned int vp_width = 0;
 	unsigned int vp_height = 0;
 	unsigned int data_pitch = 0;
 	unsigned int meta_pitch = 0;
 	unsigned int surface_height = 0;
-	unsigned int ppe = mode_422 ? 2 : 1;
+	unsigned int ppe = 1;
 
 	// FIXME check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma | is_alpha) {
@@ -934,7 +933,6 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	double min_dst_y_ttu_vblank = 0;
 	unsigned int dlg_vblank_start = 0;
 	bool dual_plane = false;
-	bool mode_422 = false;
 	unsigned int access_dir = 0;
 	unsigned int vp_height_l = 0;
 	unsigned int vp_width_l = 0;
@@ -1083,7 +1081,6 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	// Source
 	//			 dcc_en			  = src.dcc;
 	dual_plane = is_dual_plane((enum source_format_class)(src->source_format));
-	mode_422 = false; // TODO
 	access_dir = (src->source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
 	vp_height_l = src->viewport_height;
 	vp_width_l = src->viewport_width;
@@ -1301,13 +1298,8 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	dpte_row_height_l = rq_dlg_param.rq_l.dpte_row_height;
 	dpte_row_height_c = rq_dlg_param.rq_c.dpte_row_height;
 
-	if (mode_422) {
-		swath_width_pixels_ub_l = swath_width_ub_l * 2;  // *2 for 2 pixel per element
-		swath_width_pixels_ub_c = swath_width_ub_c * 2;
-	} else {
-		swath_width_pixels_ub_l = swath_width_ub_l * 1;
-		swath_width_pixels_ub_c = swath_width_ub_c * 1;
-	}
+	swath_width_pixels_ub_l = swath_width_ub_l;
+	swath_width_pixels_ub_c = swath_width_ub_c;
 
 	if (hratio_l <= 1)
 		min_hratio_fact_l = 2.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index b6d954d9aa00..b57b095cd4a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -655,13 +655,12 @@ static void get_surf_rq_param(
 		bool is_chroma,
 		bool is_alpha)
 {
-	bool mode_422 = 0;
 	unsigned int vp_width = 0;
 	unsigned int vp_height = 0;
 	unsigned int data_pitch = 0;
 	unsigned int meta_pitch = 0;
 	unsigned int surface_height = 0;
-	unsigned int ppe = mode_422 ? 2 : 1;
+	unsigned int ppe = 1;
 
 	// FIXME check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma | is_alpha) {
@@ -888,7 +887,6 @@ static void dml_rq_dlg_get_dlg_params(
 	double min_ttu_vblank;
 	unsigned int dlg_vblank_start;
 	bool dual_plane;
-	bool mode_422;
 	unsigned int access_dir;
 	unsigned int vp_height_l;
 	unsigned int vp_width_l;
@@ -1004,7 +1002,6 @@ static void dml_rq_dlg_get_dlg_params(
 	// Prefetch Calc
 	// Source
 	dual_plane = is_dual_plane((enum source_format_class) (src->source_format));
-	mode_422 = 0;
 	access_dir = (src->source_scan == dm_vert);	// vp access direction: horizontal or vertical accessed
 	vp_height_l = src->viewport_height;
 	vp_width_l = src->viewport_width;
@@ -1142,13 +1139,8 @@ static void dml_rq_dlg_get_dlg_params(
 	dpte_row_height_l = rq_dlg_param->rq_l.dpte_row_height;
 	dpte_row_height_c = rq_dlg_param->rq_c.dpte_row_height;
 
-	if (mode_422) {
-		swath_width_pixels_ub_l = swath_width_ub_l * 2;  // *2 for 2 pixel per element
-		swath_width_pixels_ub_c = swath_width_ub_c * 2;
-	} else {
-		swath_width_pixels_ub_l = swath_width_ub_l * 1;
-		swath_width_pixels_ub_c = swath_width_ub_c * 1;
-	}
+	swath_width_pixels_ub_l = swath_width_ub_l;
+	swath_width_pixels_ub_c = swath_width_ub_c;
 
 	if (hratio_l <= 1)
 		min_hratio_fact_l = 2.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index 94975b0fa398..61b3bebf24c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -743,13 +743,12 @@ static void get_surf_rq_param(
 		bool is_chroma,
 		bool is_alpha)
 {
-	bool mode_422 = 0;
 	unsigned int vp_width = 0;
 	unsigned int vp_height = 0;
 	unsigned int data_pitch = 0;
 	unsigned int meta_pitch = 0;
 	unsigned int surface_height = 0;
-	unsigned int ppe = mode_422 ? 2 : 1;
+	unsigned int ppe = 1;
 
 	// FIXME check if ppe apply for both luma and chroma in 422 case
 	if (is_chroma | is_alpha) {
@@ -973,7 +972,6 @@ static void dml_rq_dlg_get_dlg_params(
 	double min_ttu_vblank;
 	unsigned int dlg_vblank_start;
 	bool dual_plane;
-	bool mode_422;
 	unsigned int access_dir;
 	unsigned int vp_height_l;
 	unsigned int vp_width_l;
@@ -1091,7 +1089,6 @@ static void dml_rq_dlg_get_dlg_params(
 	// Prefetch Calc
 	// Source
 	dual_plane = is_dual_plane((enum source_format_class) (src->source_format));
-	mode_422 = 0;
 	access_dir = (src->source_scan == dm_vert);	// vp access direction: horizontal or vertical accessed
 	vp_height_l = src->viewport_height;
 	vp_width_l = src->viewport_width;
@@ -1230,13 +1227,8 @@ static void dml_rq_dlg_get_dlg_params(
 	dpte_row_height_l = rq_dlg_param->rq_l.dpte_row_height;
 	dpte_row_height_c = rq_dlg_param->rq_c.dpte_row_height;
 
-	if (mode_422) {
-		swath_width_pixels_ub_l = swath_width_ub_l * 2;  // *2 for 2 pixel per element
-		swath_width_pixels_ub_c = swath_width_ub_c * 2;
-	} else {
-		swath_width_pixels_ub_l = swath_width_ub_l * 1;
-		swath_width_pixels_ub_c = swath_width_ub_c * 1;
-	}
+	swath_width_pixels_ub_l = swath_width_ub_l;
+	swath_width_pixels_ub_c = swath_width_ub_c;
 
 	if (hratio_l <= 1)
 		min_hratio_fact_l = 2.0;
-- 
2.34.1

