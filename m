Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C46C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2875C10E797;
	Fri, 18 Nov 2022 17:02:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A1910E797
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:02:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgPwt62JktpadSNENzrbV1Q1MeH9NSA20avmAEo39jq2AM8qbysBG09MY6ETVhSp2bvqZ82P9xmF+PKnompqE+pLqClhGqqiNOMSWiUNXENQp2PB4fxK9fH0vi3AYz6zTsIFrMkKI4CYNvkG2gYbjFhnZzMJ2GrU+FPygEaidSCMQ2VuwtlRGuHLYbNQlAb7fnCmW1O0RhyveQtstFKd/9Y6S+5bmLpiIkRG+oMmHVwy+wTvpPfHiXG+jYacksv5f7eZyl1FZB5ISUaRuzylQYW+CoimYOa6VFI12FLyD9fPr93H1IT05O67xwxJ8Ftzdb3wK1HHXCt8OSAaF8MeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNCErrYpHZKb/4YHnyQU7mYd1RwT+QPjU6RR1SWPlTU=;
 b=Tzqf1A0QMQKiQ6q3OnXzYH+X8g1+FI91gjvNOFMalsWa72BHwCCRKeYH0pkAJv2Rod4G74ccf/4MXpRNrZV8Omgu/Tt8sshRwdwvUA6j/SXnDBsAIzlLh2DU8Tb9mDzYMxIyET6DHOLh/qs4uicLCnTeB0pm69tBpXvH3sHB9ECG+SNSRYV8D7+edF9nbYK1WTasbX9lA2A+1NQlsmXpShqVYJYBQm9kxUw/WJSlYgHNDPXHbMysSySImsnwDokRYSOboliMFXraemVyfjrihH9GSg6PWYnz39yPuPuLfmAm6/gBYDW2F0pHbbO0/8/G16LeOv/G2J2yTcg/q2vwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNCErrYpHZKb/4YHnyQU7mYd1RwT+QPjU6RR1SWPlTU=;
 b=nkEDJ54S3abYL1syFh7tmDhvlWWRp/p98il9HXuP3I2D72cRjUjV6ToVHSbCyPxi9EetrMtkO5ouaKSSrEQy1IQSCY3oM0FghTRKT4FujaLFOOUindlroF46I1MqvvKw8yCJ6wKwBZkDrA0Cn01VvNdrjusl2rCR/MjUY5wX/Oc=
Received: from MW4PR03CA0318.namprd03.prod.outlook.com (2603:10b6:303:dd::23)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 17:02:03 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::47) by MW4PR03CA0318.outlook.office365.com
 (2603:10b6:303:dd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 17:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:02:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:02:01 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:01:57
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/22] drm/amd/display: Fix rotated cursor offset calculation
Date: Fri, 18 Nov 2022 20:59:34 +0800
Message-ID: <20221118125935.4013669-22-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff32e1d-e33d-4bfc-1a23-08dac9869d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhmzJHEV4bdd10JusOapAGjfkdYXkeUAjwvcEwh+ox0XNadvNQxLhrQENjuZ8a/aXeYMin4dZoqGFJ5CW0SqyDRwsbSxyZDG4Q0KwAm/o4KKxO7tRvbQwysR+1Bo4iyovkK7oyPB7O/FZ71spS3uIjrn+cFnK8M/Yd6Kej2OYPrlAhZM3sQ29p8AsgUwpiuqtwamGi3RrYv4GgBysR84cpqQTUyLx/hx08S5pF01P8prP4ev2wRhD5IYAE719bh2DlPm8f2enWDZ72QVxCz4dGn/3rY4ZC1Ixts94ooJd8oB6EQzcmLweEf5FjdgiyXBe7m2RwuM3cXPb4TnTpQzXqA+oCM/fxvTlJlsKwfj0seVwq+D5qDE+LBeyd09AHn1k+5DuIW6d+clhiPRA2i3jI+Pk5W05h8wyOblFq5GaUDyUUWL+N0zUHnmV5N9Qwvfo5vQe2+PS3OMS5lcyhX4SXDd1lvQUbCe8P0CV7E617YDFgTUi4yLPaX2VYsfVve2OywwKm/gihdto+g3msswpbasad748ZEwQqEykluMxLK1yXRsEI0+z0fslApEQ0NgBkd+TWmfeEMA86Ift/O1/EQbxQrO1WEafCAOnFxIwzK/tPiCsBKlXV4/hJgPx8FwjoEQq86vIpvgHTn/hGTnmTrI/kMeBUwtpu4wsYHFBfxQGRYCRIkO0YjxkKhLgFE5mhhk1MZWsZx5zmSncYjXKzR4KTcnh4GnXt8SL5mQjxKG9r9jk/FBmTqHrD/4EdyB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(2906002)(81166007)(82740400003)(40480700001)(8936002)(5660300002)(426003)(70206006)(336012)(1076003)(2616005)(86362001)(47076005)(186003)(6666004)(36756003)(54906003)(8676002)(70586007)(4326008)(41300700001)(36860700001)(83380400001)(478600001)(356005)(7696005)(6916009)(40460700003)(26005)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:02:02.9453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff32e1d-e33d-4bfc-1a23-08dac9869d7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 David Galiffi <David.Galiffi@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[Why]
Underflow is observed when cursor is still enabled when the cursor
rectangle is outside the bounds of it's surface viewport.

[How]
Update parameters used to determine when cursor should be disabled.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  | 34 +++++++++++++------
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 28 ++++++++++-----
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 32 +++++++++++------
 3 files changed, 64 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
index b9765b3899e1..ef52e6b6eccf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
@@ -436,34 +436,48 @@ void dpp1_set_cursor_position(
 		uint32_t height)
 {
 	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
-	int src_x_offset = pos->x - pos->x_hotspot - param->viewport.x;
-	int src_y_offset = pos->y - pos->y_hotspot - param->viewport.y;
+	int x_pos = pos->x - param->viewport.x;
+	int y_pos = pos->y - param->viewport.y;
+	int x_hotspot = pos->x_hotspot;
+	int y_hotspot = pos->y_hotspot;
+	int src_x_offset = x_pos - pos->x_hotspot;
+	int src_y_offset = y_pos - pos->y_hotspot;
+	int cursor_height = (int)height;
+	int cursor_width = (int)width;
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
-	// Cursor width/height and hotspots need to be rotated for offset calculation
+	// Transform cursor width / height and hotspots for offset calculations
 	if (param->rotation == ROTATION_ANGLE_90 || param->rotation == ROTATION_ANGLE_270) {
-		swap(width, height);
+		swap(cursor_height, cursor_width);
+		swap(x_hotspot, y_hotspot);
+
 		if (param->rotation == ROTATION_ANGLE_90) {
-			src_x_offset = pos->x - pos->y_hotspot - param->viewport.x;
-			src_y_offset = pos->y - pos->x_hotspot - param->viewport.y;
+			// hotspot = (-y, x)
+			src_x_offset = x_pos - (cursor_width - x_hotspot);
+			src_y_offset = y_pos - y_hotspot;
+		} else if (param->rotation == ROTATION_ANGLE_270) {
+			// hotspot = (y, -x)
+			src_x_offset = x_pos - x_hotspot;
+			src_y_offset = y_pos - (cursor_height - y_hotspot);
 		}
 	} else if (param->rotation == ROTATION_ANGLE_180) {
+		// hotspot = (-x, -y)
 		if (!param->mirror)
-			src_x_offset = pos->x - param->viewport.x;
+			src_x_offset = x_pos - (cursor_width - x_hotspot);
 
-		src_y_offset = pos->y - param->viewport.y;
+		src_y_offset = y_pos - (cursor_height - y_hotspot);
 	}
 
 	if (src_x_offset >= (int)param->viewport.width)
 		cur_en = 0;  /* not visible beyond right edge*/
 
-	if (src_x_offset + (int)width <= 0)
+	if (src_x_offset + cursor_width <= 0)
 		cur_en = 0;  /* not visible beyond left edge*/
 
 	if (src_y_offset >= (int)param->viewport.height)
 		cur_en = 0;  /* not visible beyond bottom edge*/
 
-	if (src_y_offset + (int)height <= 0)
+	if (src_y_offset + cursor_height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
 	REG_UPDATE(CURSOR0_CONTROL,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index 52e201e9b091..a142a00bc432 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -1179,10 +1179,12 @@ void hubp1_cursor_set_position(
 		const struct dc_cursor_mi_param *param)
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
-	int src_x_offset = pos->x - pos->x_hotspot - param->viewport.x;
-	int src_y_offset = pos->y - pos->y_hotspot - param->viewport.y;
+	int x_pos = pos->x - param->viewport.x;
+	int y_pos = pos->y - param->viewport.y;
 	int x_hotspot = pos->x_hotspot;
 	int y_hotspot = pos->y_hotspot;
+	int src_x_offset = x_pos - pos->x_hotspot;
+	int src_y_offset = y_pos - pos->y_hotspot;
 	int cursor_height = (int)hubp->curs_attr.height;
 	int cursor_width = (int)hubp->curs_attr.width;
 	uint32_t dst_x_offset;
@@ -1200,18 +1202,26 @@ void hubp1_cursor_set_position(
 	if (hubp->curs_attr.address.quad_part == 0)
 		return;
 
-	// Rotated cursor width/height and hotspots tweaks for offset calculation
+	// Transform cursor width / height and hotspots for offset calculations
 	if (param->rotation == ROTATION_ANGLE_90 || param->rotation == ROTATION_ANGLE_270) {
 		swap(cursor_height, cursor_width);
+		swap(x_hotspot, y_hotspot);
+
 		if (param->rotation == ROTATION_ANGLE_90) {
-			src_x_offset = pos->x - pos->y_hotspot - param->viewport.x;
-			src_y_offset = pos->y - pos->x_hotspot - param->viewport.y;
+			// hotspot = (-y, x)
+			src_x_offset = x_pos - (cursor_width - x_hotspot);
+			src_y_offset = y_pos - y_hotspot;
+		} else if (param->rotation == ROTATION_ANGLE_270) {
+			// hotspot = (y, -x)
+			src_x_offset = x_pos - x_hotspot;
+			src_y_offset = y_pos - (cursor_height - y_hotspot);
 		}
 	} else if (param->rotation == ROTATION_ANGLE_180) {
+		// hotspot = (-x, -y)
 		if (!param->mirror)
-			src_x_offset = pos->x - param->viewport.x;
+			src_x_offset = x_pos - (cursor_width - x_hotspot);
 
-		src_y_offset = pos->y - param->viewport.y;
+		src_y_offset = y_pos - (cursor_height - y_hotspot);
 	}
 
 	dst_x_offset = (src_x_offset >= 0) ? src_x_offset : 0;
@@ -1248,8 +1258,8 @@ void hubp1_cursor_set_position(
 			CURSOR_Y_POSITION, pos->y);
 
 	REG_SET_2(CURSOR_HOT_SPOT, 0,
-			CURSOR_HOT_SPOT_X, x_hotspot,
-			CURSOR_HOT_SPOT_Y, y_hotspot);
+			CURSOR_HOT_SPOT_X, pos->x_hotspot,
+			CURSOR_HOT_SPOT_Y, pos->y_hotspot);
 
 	REG_SET(CURSOR_DST_OFFSET, 0,
 			CURSOR_DST_X_OFFSET, dst_x_offset);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 938dba5249d4..4566bc7abf17 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -973,10 +973,12 @@ void hubp2_cursor_set_position(
 		const struct dc_cursor_mi_param *param)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-	int src_x_offset = pos->x - pos->x_hotspot - param->viewport.x;
-	int src_y_offset = pos->y - pos->y_hotspot - param->viewport.y;
+	int x_pos = pos->x - param->viewport.x;
+	int y_pos = pos->y - param->viewport.y;
 	int x_hotspot = pos->x_hotspot;
 	int y_hotspot = pos->y_hotspot;
+	int src_x_offset = x_pos - pos->x_hotspot;
+	int src_y_offset = y_pos - pos->y_hotspot;
 	int cursor_height = (int)hubp->curs_attr.height;
 	int cursor_width = (int)hubp->curs_attr.width;
 	uint32_t dst_x_offset;
@@ -994,18 +996,26 @@ void hubp2_cursor_set_position(
 	if (hubp->curs_attr.address.quad_part == 0)
 		return;
 
-	// Rotated cursor width/height and hotspots tweaks for offset calculation
+	// Transform cursor width / height and hotspots for offset calculations
 	if (param->rotation == ROTATION_ANGLE_90 || param->rotation == ROTATION_ANGLE_270) {
 		swap(cursor_height, cursor_width);
+		swap(x_hotspot, y_hotspot);
+
 		if (param->rotation == ROTATION_ANGLE_90) {
-			src_x_offset = pos->x - pos->y_hotspot - param->viewport.x;
-			src_y_offset = pos->y - pos->x_hotspot - param->viewport.y;
+			// hotspot = (-y, x)
+			src_x_offset = x_pos - (cursor_width - x_hotspot);
+			src_y_offset = y_pos - y_hotspot;
+		} else if (param->rotation == ROTATION_ANGLE_270) {
+			// hotspot = (y, -x)
+			src_x_offset = x_pos - x_hotspot;
+			src_y_offset = y_pos - (cursor_height - y_hotspot);
 		}
 	} else if (param->rotation == ROTATION_ANGLE_180) {
+		// hotspot = (-x, -y)
 		if (!param->mirror)
-			src_x_offset = pos->x - param->viewport.x;
+			src_x_offset = x_pos - (cursor_width - x_hotspot);
 
-		src_y_offset = pos->y - param->viewport.y;
+		src_y_offset = y_pos - (cursor_height - y_hotspot);
 	}
 
 	dst_x_offset = (src_x_offset >= 0) ? src_x_offset : 0;
@@ -1042,8 +1052,8 @@ void hubp2_cursor_set_position(
 			CURSOR_Y_POSITION, pos->y);
 
 	REG_SET_2(CURSOR_HOT_SPOT, 0,
-			CURSOR_HOT_SPOT_X, x_hotspot,
-			CURSOR_HOT_SPOT_Y, y_hotspot);
+			CURSOR_HOT_SPOT_X, pos->x_hotspot,
+			CURSOR_HOT_SPOT_Y, pos->y_hotspot);
 
 	REG_SET(CURSOR_DST_OFFSET, 0,
 			CURSOR_DST_X_OFFSET, dst_x_offset);
@@ -1052,8 +1062,8 @@ void hubp2_cursor_set_position(
 	hubp->pos.cur_ctl.bits.cur_enable = cur_en;
 	hubp->pos.position.bits.x_pos = pos->x;
 	hubp->pos.position.bits.y_pos = pos->y;
-	hubp->pos.hot_spot.bits.x_hot = x_hotspot;
-	hubp->pos.hot_spot.bits.y_hot = y_hotspot;
+	hubp->pos.hot_spot.bits.x_hot = pos->x_hotspot;
+	hubp->pos.hot_spot.bits.y_hot = pos->y_hotspot;
 	hubp->pos.dst_offset.bits.dst_x_offset = dst_x_offset;
 	/* Cursor Rectangle Cache
 	 * Cursor bitmaps have different hotspot values
-- 
2.25.1

