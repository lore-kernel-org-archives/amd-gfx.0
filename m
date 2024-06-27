Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138F9C3064D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB4110EB64;
	Thu, 27 Jun 2024 21:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B7r3rNMr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5B010EB5F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bswDciF80Y5zTuCuI3EutLfN6kQ+TGjSGFPaPSG+CTobjsIkl5D6Ux2Wlv/OCS7I9/aVcBR5htgIYTfNGTABehoh02x6ma/9XyGIth4NsdngrvAEQMi76zRpdB7rjpa0Dpxf8NsPTaq+gAAlWlOqQyyFq6iF3glo3QZI8xepZ0R/kpAOnkLq+CY32+Gz3KztwJ3JzX8bhQn6jKEuPsv7y6Q9OwMAAZnf4TSoyGaRFSg+PD3DowZamQr27xZHnEDVvbVdvHJG9maeZjoB8KPU0ZBuLxnPNoP+alefYGyvavJpc0+QqDQ/trzf6NjdvmAl1uz5StaDJZDLIHW2b/Ek6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzM6dWBe7pe8xefWQJ9e0SYhnODvmySI07u2pVSJr34=;
 b=J9QfJUOEHLISXMcwyVwZxZfXPB3rTFPxjz4SR3pirgQueRRVy3D2S+cyhF23RnximCXZYdRvOX63CGK3uqASyMKrRMSMbrbqjHcVT5P+zSR3DMhWL05yiJFkUaTSl/pdgl+7nzOOLJzl3yTmE06OA2QXEFfveqKWxK0GpEs+LFtzY5OOWp29P4yJaEjE860ZNMd1GyNp1l+BCnlXwayvoz//UUaC1xbvVkRqqvMmiXOxDOEfDdLL9wionspCUfGjbIbyOeNo20xneCcdBlLL39vKFEIR4roP8ZqJ157P6IImy81p9xnoAc9GWRnc+TRZCBiKLGxJ2Q5rdNph535apA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzM6dWBe7pe8xefWQJ9e0SYhnODvmySI07u2pVSJr34=;
 b=B7r3rNMrVizIFjWf/tVx+xC5Bh0A6eIXa41V2CyDvhq561YL9rlhSpdot1LHc028QGch4vD59lhzNqiEoqNzcYZTAnIZcjpCwaOLHJxjeiQKNILoH/JZO+9tiQHIUVfu5bSQilYWcSTCovkiI6+qSbiPOXTW7gn2FJ9rSWeEmnA=
Received: from BN0PR04CA0199.namprd04.prod.outlook.com (2603:10b6:408:e9::24)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25; Thu, 27 Jun
 2024 21:14:46 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::12) by BN0PR04CA0199.outlook.office365.com
 (2603:10b6:408:e9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:45 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:45 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, "Xi (Alex) Liu" <xi.liu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 22/26] drm/amd/display: replace CRTC disable function call
Date: Thu, 27 Jun 2024 17:13:25 -0400
Message-ID: <20240627211329.26386-23-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: e77c139f-70a2-4a82-1a46-08dc96ee2bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GHnSF4Th7z0xp+FTdsYmY7GmMy3XYXDtlsnhpMPmsC0mY+xNAAglnybwnoY1?=
 =?us-ascii?Q?vYvGhqis+ppCF49NE/BoFv+WwCOT/sXzRrcWLaN9cyfu/Nl6XtAT7Vgc8nUh?=
 =?us-ascii?Q?SV4M7+QrwHjSHs8vVqRBda7QUOyv2kFqy8QsOCJD4oyFvk7+PQqIuMpE8sCb?=
 =?us-ascii?Q?Q4pKjp2YK36MJ1BvS4paUzBuek0LsZffscHaHgtstDY+h/NpSCcKBXO8f2tK?=
 =?us-ascii?Q?nHRuryHPtCz67Cn8FCWbZhAhJX7XKgmOcuBVbyGrBx/N8g7/oLgo2Tb0x5ex?=
 =?us-ascii?Q?Atz+wqNThcqN6dxtr4cWU3ieNC1cIdnIz+pCGhU1pkljN4xhBMidu/6aa3XN?=
 =?us-ascii?Q?zlTsnbnpti+Ujh7yx7Ymqe9J8fkeqU6PfsrTcT8WIch4LdhK4Yf4wV8+7//X?=
 =?us-ascii?Q?QMnHEpox0HSrR9+p5x2XsPy8bzNr16ISii7XHMzZNcIC8onlLnwDqkymi16d?=
 =?us-ascii?Q?XnQMrIAHIYSPkohVc6B51W58O9Dn7loKpApDiqp0fwu2TtHxvM5g85WD6zBx?=
 =?us-ascii?Q?SM/hPdf5BO8VwFBrcEuXnNxQvUIdBWd6WMVBM4sRPm4BU8tdVNIvMHqiFpQn?=
 =?us-ascii?Q?I38zbT4PCEBxHNRchMEVvqIfERJXyEpvpIwXfUm1GWaA3uhs/9CTuQE7y/jG?=
 =?us-ascii?Q?0g4jh81gFVTdXCtAQfKv0Miry2ZiThrVcIRG0NomxB7KwQfThvIWHLmgAUTn?=
 =?us-ascii?Q?HCk2mweiST2nIIl5eFTyLwGmOv+X7ADL0VMZlOLxk0unzVTdky1DOI+BkjzX?=
 =?us-ascii?Q?Z/xvn4GkY3Bv+04J2A/MOkK8g/D3tdCyaso56U/Vap91padueCLkd6JWnXSx?=
 =?us-ascii?Q?1kM63g1yWU3qq/gOi2QP4EocOpAS9PTKSqQRm3WZMQlt6mtxSamOxCLm5DNO?=
 =?us-ascii?Q?iRlRmlXtxk63RMMqlNV7GNEHY7ySWxzJGq9H4c3AJpSgTRW6G6Ce6d4lCylc?=
 =?us-ascii?Q?+NH894yKaIwijqTvX11QxAfUeZMHiBvGfoZRM462pxSWDQUl2CZjfj4I5N1H?=
 =?us-ascii?Q?D7Lr2xVMUZbp2gNY0BBNTjZ6Yqo2JA9y8TVsLutmzifM0VcLujVaIXkkh8j2?=
 =?us-ascii?Q?mfARQ0KuW2cdaT7qtAKsIPVfFIt5Zeqy1E3X2i32uojTrrDxVXSTEQD1+Acv?=
 =?us-ascii?Q?GnAX/jOp5F+xLQfjrS5tiaZonGyrpkWz2XZ6aggGUCtN+AB6MLS26P61h1Ss?=
 =?us-ascii?Q?X8wKq9Yhde38VYIa3khGlvWlvfqeG1kiUQj5yPIEtGVV98Tg1mttgaCtLUNr?=
 =?us-ascii?Q?tHSmmnOr+VjTvhiR1ICW/eTm6uGumbknnrD4VNyedWlGooP5+qnrv33j6xa6?=
 =?us-ascii?Q?nTbN1kLv1z4tsyBirBpIkTT8TTk8It0PniBNb3DiZed2I9R867twjgpTAsuJ?=
 =?us-ascii?Q?qsGo1SlULwBny1E9oA0yP5Lu3i9sWwhU3XvY29eVyxZ8Hv/9KLqdBxnDeI27?=
 =?us-ascii?Q?lvlE2/UZFhpkU/++jPnjrSysmGJbvKpI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:46.0765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77c139f-70a2-4a82-1a46-08dc96ee2bed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
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

From: "Xi (Alex) Liu" <xi.liu@amd.com>

[Why]

In OTG disable workarund, CRTC is disabled immediately
to improve performance, but this may cause timing issue
in DP HPO encoder FIFO and result in blank CRCs.

[How]

Replace the immediate CRTC disable call with normal disable call

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Xi (Alex) Liu <xi.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 5691714f738d..70ee0089a20d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -137,8 +137,8 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
 				     !pipe->stream->link_enc)) {
 			if (disable) {
-				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
-					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->disable_crtc)
+					pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
 
 				reset_sync_context_for_pipe(dc, context, i);
 			} else {
-- 
2.34.1

