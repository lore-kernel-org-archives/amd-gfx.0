Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D4BC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8FF10F29D;
	Thu, 23 May 2024 19:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="grKyiQYO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BD010F29D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLeSnad8KZXE40Rml/PsxsCcle5ze5wmwBkJJw3EBLq+w8OX6ae5QBMRrMksZ3uagxewk5RzknCFVHwwZBzo+3kNlk61XJSOFlBL76aGKJEtJTdiKcPvdKVPQw53XNppvrn8y4FEx2DO36I67PQlO66LDRazLpPoMR12/3hbpIpmM6E86/cBLL1WvO0b65W/7bmZHcyevkevvuJ46jNrHOmqQXteqQvUe4EgSeLSwWDMebxTHgTYjX2j+L8cnMR36GalXtldZmQlyugX14psD7+kxGjjzTKHaW2jMZSdr37iBTOpv1CzG1TrYMTle+JFN3OBVcnpup0X3tAIzJTKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4VyFEFH/Hf6AovN9YTcPfg5IZsdHKiogLdFhEtg5SE=;
 b=oSbmBnEa/yEisk8nXJUpFl2ccMPUDEQ7SIgrku9W1I9IFA2F8td4mIRim7V9plBo1mpPkRAehsIuguxWDQHJHvgva6e9jyKTwOXBw297qjO7ivudFmKy4UlSSBZUIXgrRjE7BS0y7rfyfqJYHvO4fZGK26OncTiOdpYV6fCWRAdKMFJpbehd0E1b5D3DE09soU5Rgh06JHfekWTrAJ1oX+/JpcXgolN6Ji2wsEBtKriOCNUjgM39aK9LJ3gmaRSmKtQrnI5fNSimecxvmnfsbABbUsw0vawZnatmeSXv722pJTbWYfHI2/fLPiNOjNsCqiioitW0sxvG+8TdJi306Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4VyFEFH/Hf6AovN9YTcPfg5IZsdHKiogLdFhEtg5SE=;
 b=grKyiQYOol3qLyUpOtpiuCdJ+QQnbwXaY+cZK6loljre8QhxFqh0HTbgxa91fWBFlUyskhPFrc3V4/eMXwz690DKZfqw8e/jwEXDFgIyKZdTHx2Q1DTWHlm3p6Idt/nYoS2H6hiqmwNtVF8zF/xSr39iD4vRAJ38OQz23eYodz8=
Received: from PH7PR17CA0063.namprd17.prod.outlook.com (2603:10b6:510:325::27)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 19:20:35 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::76) by PH7PR17CA0063.outlook.office365.com
 (2603:10b6:510:325::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 19:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:20:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:20:34 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:20:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>, "Arvindekar, Sridevi"
 <Sridevi.Arvindekar@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Sridevi <sarvinde@amd.com>
Subject: [PATCH 01/13] drm/amd/display: Fix incorrect cursor position for
 dcn401
Date: Thu, 23 May 2024 19:20:15 +0000
Message-ID: <20240523192027.50630-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfa9977-c764-4e31-6a05-08dc7b5d6bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f6Ksote/tJBfozs0mNhF4CyySQFIUV7S7PS0dF15HqWpcXycwf9briu5poM7?=
 =?us-ascii?Q?tAThBJxFiuLX4snUMxUoR3COkdwQC9eNsXPwvOJiTnvYhnnzCZPyx3q4J+i0?=
 =?us-ascii?Q?GTyzQHDb5I5C/38DSo5weM/2YHkf7AmfidjyRkr63Z4HYPnNjFUwo2onyWtf?=
 =?us-ascii?Q?ImPLYRgzEhuw3v/vEx1mQOD2Ja3ud6jvhynisbVle7pYiPOt8cxvc+7v3vcQ?=
 =?us-ascii?Q?SWr5mkFyZTBHlX165CyFAPQNnef1/FH9tScGjswx/eTnb2CD77FBlxagsRxW?=
 =?us-ascii?Q?tApMbE1DhQkl8CXXxIu1bY9V8s2Pxgxn+znI8+Q6X8wk8rpLiCFt4sKj0bjx?=
 =?us-ascii?Q?pYz5D9cN0dte+h4cP1I4pzHptWOrIobCZEkpsvlgZ4RhusuRMTffq6ed4ED3?=
 =?us-ascii?Q?LBVIAQmSFED0b9isEovu1xOrLXv1sNHaLslfrm4J6Dad4ooTDglo0ZfpTWZ3?=
 =?us-ascii?Q?FXwFn6LWYF4Hcd4qNJRt12Pz9GUv95EOEQE/oBphMTBDQMsnukRL1hHSw+GM?=
 =?us-ascii?Q?kZWmYdRPqY1og0UdjVWuFYCHdBdADtscsTStvKYXl3yCjwqjMDiRWmKNG0gL?=
 =?us-ascii?Q?nq2fIXeYXstdLsWEOnJs6+9tsNbONzISgub1OePixu/YeMnvrnSAxG8L9dgW?=
 =?us-ascii?Q?CZGuz1o0vcSLzfFoMyuW4n27EznJzRHJHdgQfEGQhm6JxeAykJEuCcXoYrC+?=
 =?us-ascii?Q?rCLQY6N7ah0Xo03d7nCjygcnm1hbMcUvk99M7BeYsk6z14MdVPT/iUePXOK+?=
 =?us-ascii?Q?WpBY85CMKYOjFmn0ntIW4to6fz7mRO67XbhrRuTErmf/440+nSrRSq5Oq/7e?=
 =?us-ascii?Q?xFL+zlsVGhFLH+hiPIo4fjqVyFg7nw3wUQkruYYeY+ixvWnG7b7QYtgezMUp?=
 =?us-ascii?Q?I6K+I31GtCG6aOM5b7uWmT/+atwJJqpo8NsNl8Yah0acicQRM1e+jqFpicsW?=
 =?us-ascii?Q?mI2zmf8xrJV9DHSYY7WWL/cU/wli2dj4KOuqofVet2522QIrvD71FWOLbtuO?=
 =?us-ascii?Q?Q41DsSiWsVXrKz82WeH01eeMgTEgtX/y9BemC6a+7NPU1SeD9pL/oT+gHksR?=
 =?us-ascii?Q?p24spYMHwavULaGxmKeYEURZIrqhlNUArhJzATQ+U3C4Iu/oIoxudsjvhnaW?=
 =?us-ascii?Q?hUVeu5uAoW494/X5oSxV2o4CLN2HbUBtXypmESeST+c2L+4OzHvvB4Wqq4mR?=
 =?us-ascii?Q?L8nIKzvmeoWOQegieI1S3cpytNsxVcIib83DPWZjFBcqoPCNxfrhfUSlJ9lg?=
 =?us-ascii?Q?2fE+C40rzQjnZFPtd0dsJcy8GZ5ECYZzj9keNE5l2ErHAMAM+2ncJEnEJWP/?=
 =?us-ascii?Q?OKZW7lTXzpAkk1T3DLiV7yx8QEMFpPrbf6wEwhcDJd1uWRMBAm5/8hLJLo5F?=
 =?us-ascii?Q?4Q/9zJU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:20:34.7703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfa9977-c764-4e31-6a05-08dc7b5d6bb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
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

From: "Arvindekar, Sridevi" <Sridevi.Arvindekar@amd.com>

[Why]
Incorrect cursor position calculation in some scenarios.  Also for
mirror and rotation cases.

[How]
Fix for incorrect cursor position.  Added new test scenarios for diags
cursor test.  Updated CRC for few of the diags cursor test scenarios.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Sridevi <sarvinde@amd.com>
---
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c | 18 +++++++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 30 +++++++++++++------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index a54b9089f15d..aef73bd1221a 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -185,15 +185,23 @@ void dpp401_set_cursor_position(
 		rec_y_offset = y_pos - (cursor_height - y_hotspot);
 	}
 
-	if (rec_x_offset >= (int)param->recout.width)
-		cur_en = 0;  /* not visible beyond right edge*/
+	if (param->rotation == ROTATION_ANGLE_0 && !param->mirror) {
+		if (rec_x_offset >= (int)param->recout.width)
+			cur_en = 0;  /* not visible beyond right edge*/
+
+		if (rec_y_offset >= (int)param->recout.height)
+			cur_en = 0;  /* not visible beyond bottom edge*/
+	} else {
+		if (rec_x_offset > (int)param->recout.width)
+			cur_en = 0;  /* not visible beyond right edge*/
+
+		if (rec_y_offset > (int)param->recout.height)
+			cur_en = 0;  /* not visible beyond bottom edge*/
+	}
 
 	if (rec_x_offset + cursor_width <= 0)
 		cur_en = 0;  /* not visible beyond left edge*/
 
-	if (rec_y_offset >= (int)param->recout.height)
-		cur_en = 0;  /* not visible beyond bottom edge*/
-
 	if (rec_y_offset + cursor_height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f5333a095adb..407a45a3ae2c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1126,14 +1126,14 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	 */
 
 	if (param.rotation == ROTATION_ANGLE_90 || param.rotation == ROTATION_ANGLE_270) {
-		x_pos = x_pos * pipe_ctx->stream->dst.width /
+		x_pos = pipe_ctx->stream->dst.x + x_pos * pipe_ctx->stream->dst.width /
 			pipe_ctx->stream->src.height;
-		y_pos = y_pos * pipe_ctx->stream->dst.height /
+		y_pos = pipe_ctx->stream->dst.y + y_pos * pipe_ctx->stream->dst.height /
 			pipe_ctx->stream->src.width;
 	} else {
-		x_pos = x_pos * pipe_ctx->stream->dst.width /
+		x_pos = pipe_ctx->stream->dst.x + x_pos * pipe_ctx->stream->dst.width /
 			pipe_ctx->stream->src.width;
-		y_pos = y_pos * pipe_ctx->stream->dst.height /
+		y_pos = pipe_ctx->stream->dst.y + y_pos * pipe_ctx->stream->dst.height /
 			pipe_ctx->stream->src.height;
 	}
 
@@ -1225,10 +1225,15 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 			}
 		}
 	} else if (param.rotation == ROTATION_ANGLE_90) {
-		uint32_t temp_y = pos_cpy.y;
+		if (!param.mirror) {
+			uint32_t temp_y = pos_cpy.y;
+
+			pos_cpy.y = pipe_ctx->plane_res.scl_data.recout.height - pos_cpy.x;
+			pos_cpy.x = temp_y - prev_odm_width;
+		} else {
+			swap(pos_cpy.x, pos_cpy.y);
+		}
 
-		pos_cpy.y = pipe_ctx->plane_res.scl_data.recout.height - pos_cpy.x;
-		pos_cpy.x = temp_y - prev_odm_width;
 	} else if (param.rotation == ROTATION_ANGLE_270) {
 		// Swap axis and mirror vertically
 		uint32_t temp_x = pos_cpy.x;
@@ -1279,8 +1284,15 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 				pos_cpy.y = temp_x;
 			}
 		} else {
-			pos_cpy.x = pipe_ctx->plane_res.scl_data.recout.width - pos_cpy.y;
-			pos_cpy.y = temp_x;
+			if (param.mirror) {
+				swap(pos_cpy.x, pos_cpy.y);
+
+				pos_cpy.x = pipe_ctx->plane_res.scl_data.recout.width - pos_cpy.x + 2 * pipe_ctx->plane_res.scl_data.recout.x;
+				pos_cpy.y = (2 * pipe_ctx->plane_res.scl_data.recout.y) + pipe_ctx->plane_res.scl_data.recout.height - pos_cpy.y;
+			} else {
+				pos_cpy.x = pipe_ctx->plane_res.scl_data.recout.width - pos_cpy.y;
+				pos_cpy.y = temp_x;
+			}
 		}
 	} else if (param.rotation == ROTATION_ANGLE_180) {
 		// Mirror horizontally and vertically
-- 
2.39.2

