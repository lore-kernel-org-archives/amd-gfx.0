Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8CECDB46F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1CC210F5EF;
	Fri, 19 Jun 2026 13:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JWZBs6wd";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8689710F5E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1MBfCOEKvid9zIDajHFHrsniwEPfSEOqvzQiILyiNH0D7R4yJx2V63QAS+OJl3j9Jf9/IsBc41BGX/WQKah+Mn2kqPtLfLPl3oYtDNWFx2cjC3SkCWJ95F8NkTBqnXPIrqderyxTuNm1qaM2/zoTkTRMcB/lS9NmFdrlsTxoLZC5l2RJJKMsr9XKVCmtLkwSh5uva0TihFs3EuIepDnqmxopEXXkrl5GtfcNQxURijKLvjTRzkviu38ZKL/oq6Tl7yCLvpeeS0l0ujlYNn+nzmo/ETVWpEBAVht3tmZ3AFl4aXqs9pRNK+OoJhLmNfwxdOcat/4R+d3bh4dWqa7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT3dgWWHYl3XPQ+mkOwe4QVRaoVn8oV51HVu5plBsKY=;
 b=xSbWFxBEnvwaLGEURWf8FRghldX9ZG/9DxH5DdZ0hpVRQ1s1Iwjzk94eNB5F0A2myFaiYGp5DuhL3nbwoRgKw6udFyPdcY9gbS1Ev0jl4UCwk5PW+gWpd4qoLQuwT5BRQanW7r4JED8TAmZ66q53gPJ1DT+5aLn7L8ddahTkpRUoeXIaHNnktc074HMje0MuDYQyszZp1gpAH36LIwuQfSYsIj5BlXBDL/R0e9jD7X0qA2Mqpui4JpPgV+pOR5U1rDiW1wrJWH/7lZgPtBQl/eFun9U2Z5In/T7ei6Rky7pTGp5+NeWm3nzPLYy3TO3bZvoa7GLNUAIOX7lXVzn+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT3dgWWHYl3XPQ+mkOwe4QVRaoVn8oV51HVu5plBsKY=;
 b=JWZBs6wdUUW3esVkwiD5nexBj9097mFGz7evuo9HOlo6cL517UIAIfuugWyszCDHtX05l0tpJ2gRR1Bcvebp9vwiav5pfzraGgVBr2Cgmgm3n/QqQI0IY2rysC4vTDk2M6H0r/PpW/3a59NFAKx2fs53eutGwYj440JVIMkFPaU=
Received: from BN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:408:e6::19)
 by DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Fri, 19 Jun
 2026 13:32:28 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::2a) by BN0PR03CA0014.outlook.office365.com
 (2603:10b6:408:e6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 13:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:27 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:26 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 11/24] drm/amd/display: split TF/LUT colorop state lookups
 into separate upfront phases
Date: Fri, 19 Jun 2026 09:21:26 -0400
Message-ID: <20260619133154.116746-12-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DSWPR12MB999127:EE_
X-MS-Office365-Filtering-Correlation-Id: cc50a245-3789-44be-e905-08dece0734db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|3023799007|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: h14OHI3XcNqSTi1cPrCHvNhmEVW6dY4vO16ahXg3SggpaXDutFNl6IHuDCj+gyYQVbaTu3fFJH20230roCBRUc7Rw++wOdQtiRQcGqdFtVPGxnHq9Bu8knsyVGAkEOvIdhK0wJ3sjlhUi0aL54EtKc5OqIOkKhSzT/nYBglwsgb3VO+qNJgRZ5FT8mMTxh8XcoDu+uRVp4pLzqbkH8Lc/CC45JEAhT5gTdCZiRQX6NA06O+O6mujJKMUBQI0HUc+BzRpi1VGWg+45TUQmBkqck47CgOPDZ6BAvipGA6zvmH+TlTXuYsWypWXik7mGJhFGpe2mscxX12UQW16fLNZj1QQiZTT2MTFza6TY0/eRGO1y3S53f728V2Udh4Z8gcfzDwOMc+iV6MpewIx98o/l1aW4QZrFBcn5JDk3mKcQja+Zmm2iJeH2kTW9WsvdZ3RkhEuOfqjx7Qzeo/NU3g1wGrH2lwDGYzIT/oK0wngmiaT8gioCjGtpcbNUBfrLvMpEvI6oxkiCJ+YMzfev2m3lqO3y1jLc38ORCq0zaG7MP8h7wr+W7Xsx87BOaujaT0kp+gqn6b989U39jabGhTMCs6WwL9agFXKdkJH9dy+7bcBtc6jPNjUZCWhgxOrKHEedePo62zROsr0RtOOFD46kEn0/JtVOE5teLD6UbIe/MDT7iD4e05aW6/Qdk29BENc84KzTRF8DWMn7cn9H8Y7WQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(3023799007)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fwYTTDGkVLQBBjPO0MYvqBhBJgyDFuTRCe8YHT+IrlhNKelYCVUOMACvItZ0s8zwOJ45C9tJ54U11uPOQYfCOBrMdx3JreoIQy5hFIjyst+3nZxZE/zZJ5L+TK2wyFkPdd3X1CxEqSt5Ki6kB24Z6mrSfMRZ/O3lj5/GvqLVEHf2h+XdweckKYA2JcYZIN7dLY03vdMtR2s3CouiYUACODOrm/yGagtL8YnEUuSTrxsu/NwqaIRuXpifZMX/XCfzYeMZtdMXoH3Pr3k+B0THU8DQ+0Jukk5zlgX3cLyEumWh9VAefZf/kPmTlCtJlhjbcu4Wo53ANY6Cw5OcepYlOYB55PRJx7W5+8h4EzJLz6VmLivJXzlUB4ODfyX81BNUJFPMFD33ntuCk5iMuOlg3ZSj/SSda8Kg+6crrhvmC8YF8fHc3dqCeiOfXoPTSGAQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:27.9668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc50a245-3789-44be-e905-08dece0734db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999127
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

From: Harry Wentland <harry.wentland@amd.com>

In __set_dm_plane_colorop_shaper and __set_dm_plane_colorop_blend the
single colorop_state variable was reused sequentially: first to capture
the TF state, then (after mutating the colorop pointer) to capture the
LUT state.

Split into separate tf_state / lut_state pointers and introduce a
dedicated lut_colorop local. Resolve both pointers upfront before any
computation begins. This separates the concern of "find the states" from
"use the states" and makes the code easier to follow.

No functional change.

Assisted-by: Copilot:claude-opus-4.8

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 94 ++++++++++---------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 724b7729f342..affcd090c9b7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1640,8 +1640,10 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 			      struct drm_colorop *colorop)
 {
 	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
+	struct drm_colorop_state *new_colorop_state;
+	struct drm_colorop_state *tf_state = NULL, *lut_state = NULL;
 	struct drm_atomic_state *state = plane_state->state;
+	struct drm_colorop *lut_colorop;
 	enum dc_transfer_func_predefined default_tf = TRANSFER_FUNCTION_LINEAR;
 	struct dc_transfer_func *tf = &dc_plane_state->cm.shaper_func;
 	const struct drm_color_lut32 *shaper_lut;
@@ -1650,53 +1652,52 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 	u32 shaper_size;
 	int i = 0, ret = 0;

-	/* 1D Curve - SHAPER TF */
+	/* 1D Curve - SHAPER TF: find state */
 	old_colorop = colorop;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
 		if (new_colorop_state->colorop == old_colorop &&
 		    (BIT(new_colorop_state->curve_1d_type) & amdgpu_dm_supported_shaper_tfs)) {
-			colorop_state = new_colorop_state;
+			tf_state = new_colorop_state;
 			break;
 		}
 	}

-	if (colorop_state && !colorop_state->bypass) {
-		drm_dbg(dev, "Shaper TF colorop with ID: %d\n", colorop->base.id);
-		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
-		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
-		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
-		ret = __set_output_tf(tf, 0, 0, false);
-		if (ret)
-			return ret;
-		enabled = true;
-	}
-
-	/* 1D LUT - SHAPER LUT */
-	colorop = old_colorop->next;
-	if (!colorop) {
+	/* 1D LUT - SHAPER LUT: find state */
+	lut_colorop = old_colorop->next;
+	if (!lut_colorop) {
 		drm_dbg(dev, "no Shaper LUT colorop found\n");
 		return -EINVAL;
 	}

-	old_colorop = colorop;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == old_colorop &&
+		if (new_colorop_state->colorop == lut_colorop &&
 		    new_colorop_state->colorop->type == DRM_COLOROP_1D_LUT) {
-			colorop_state = new_colorop_state;
+			lut_state = new_colorop_state;
 			break;
 		}
 	}

-	if (colorop_state && !colorop_state->bypass) {
-		drm_dbg(dev, "Shaper LUT colorop with ID: %d\n", colorop->base.id);
+	if (tf_state && !tf_state->bypass) {
+		drm_dbg(dev, "Shaper TF colorop with ID: %d\n", old_colorop->base.id);
+		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(tf_state->curve_1d_type);
+		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
+		ret = __set_output_tf(tf, 0, 0, false);
+		if (ret)
+			return ret;
+		enabled = true;
+	}
+
+	if (lut_state && !lut_state->bypass) {
+		drm_dbg(dev, "Shaper LUT colorop with ID: %d\n", lut_colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf;
 		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
-		shaper_lut = __extract_blob_lut32(colorop_state->data, &shaper_size);
+		shaper_lut = __extract_blob_lut32(lut_state->data, &shaper_size);
 		shaper_size = shaper_lut != NULL ? shaper_size : 0;

 		/* Custom LUT size must be the same as supported size */
-		if (shaper_size == colorop->size) {
+		if (shaper_size == lut_colorop->size) {
 			ret = __set_output_tf_32(tf, shaper_lut, shaper_size, false);
 			if (ret)
 				return ret;
@@ -1812,8 +1813,10 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 			     struct drm_colorop *colorop)
 {
 	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
+	struct drm_colorop_state *new_colorop_state;
+	struct drm_colorop_state *tf_state = NULL, *lut_state = NULL;
 	struct drm_atomic_state *state = plane_state->state;
+	struct drm_colorop *lut_colorop;
 	enum dc_transfer_func_predefined default_tf = TRANSFER_FUNCTION_LINEAR;
 	struct dc_transfer_func *tf = &dc_plane_state->cm.blend_func;
 	const struct drm_color_lut32 *blend_lut = NULL;
@@ -1823,52 +1826,51 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,

 	dc_plane_state->cm.flags.bits.blend_enable = 0;

-	/* 1D Curve - BLND TF */
+	/* 1D Curve - BLND TF: find state */
 	old_colorop = colorop;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
 		if (new_colorop_state->colorop == old_colorop &&
 		    (BIT(new_colorop_state->curve_1d_type) & amdgpu_dm_supported_blnd_tfs)) {
-			colorop_state = new_colorop_state;
+			tf_state = new_colorop_state;
 			break;
 		}
 	}

-	if (colorop_state && !colorop_state->bypass) {
-		drm_dbg(dev, "Blend TF colorop with ID: %d\n", colorop->base.id);
-		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
-		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
-		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
-		dc_plane_state->cm.flags.bits.blend_enable = 1;
-		__set_input_tf_32(NULL, tf, blend_lut, blend_size);
-	}
-
-	/* 1D Curve - BLND LUT */
-	colorop = old_colorop->next;
-	if (!colorop) {
+	/* 1D LUT - BLND LUT: find state */
+	lut_colorop = old_colorop->next;
+	if (!lut_colorop) {
 		drm_dbg(dev, "no Blend LUT colorop found\n");
 		return -EINVAL;
 	}

-	old_colorop = colorop;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == old_colorop &&
+		if (new_colorop_state->colorop == lut_colorop &&
 		    new_colorop_state->colorop->type == DRM_COLOROP_1D_LUT) {
-			colorop_state = new_colorop_state;
+			lut_state = new_colorop_state;
 			break;
 		}
 	}

-	if (colorop_state && !colorop_state->bypass) {
-		drm_dbg(dev, "Blend LUT colorop with ID: %d\n", colorop->base.id);
+	if (tf_state && !tf_state->bypass) {
+		drm_dbg(dev, "Blend TF colorop with ID: %d\n", old_colorop->base.id);
+		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(tf_state->curve_1d_type);
+		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
+		dc_plane_state->cm.flags.bits.blend_enable = 1;
+		__set_input_tf_32(NULL, tf, blend_lut, blend_size);
+	}
+
+	if (lut_state && !lut_state->bypass) {
+		drm_dbg(dev, "Blend LUT colorop with ID: %d\n", lut_colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf;
 		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
 		dc_plane_state->cm.flags.bits.blend_enable = 1;
-		blend_lut = __extract_blob_lut32(colorop_state->data, &blend_size);
+		blend_lut = __extract_blob_lut32(lut_state->data, &blend_size);
 		blend_size = blend_lut != NULL ? blend_size : 0;

 		/* Custom LUT size must be the same as supported size */
-		if (blend_size == colorop->size)
+		if (blend_size == lut_colorop->size)
 			__set_input_tf_32(NULL, tf, blend_lut, blend_size);
 	}

--
2.54.0

