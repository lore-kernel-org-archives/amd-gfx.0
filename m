Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD824C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEC510EB6D;
	Tue,  8 Sep 2026 11:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZNnM4gD6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F8D10EB6D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reia6iEqlODtiNbIplYm6KlMzjE478opCS71NdseF/9+S8VGelhGLwu/GE3TnsLiKiRLB6Ur+aw5OV43RVkG2GQUu1r7QuhqV74fBacQBKGou7xVpGrpddH2XRvbl2OByQuive8QpB9aV2LGgPcSV1LmukSACf9k5MOC7WhQ65pmtrRpGrUv3RL6TXQPshLkMEGCKj+YNbZvLD7q321u2m4RlV6ItKRnp8FhKfU0Ia65XOsEG8X8IvqXJN2Fb29PxQlKahezT8/EtJKUqORFrpkrTtwdgB2sM2Cleousxwe+x2ZGz0OewksHjl+dw2E5hOfk2oCHVUwQlQwLwQUwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFjHqgGe999rPseiBLHfpY3kq8m0ijdiQbyzHYNE+ys=;
 b=NILgtISfbX1s8a9bX4t1lrkjCJPw/uqWS8tYXKYA3P7H4bbPVYiC7/ZmBwYo+DtOs8kWO5gTjB+NlVV4fO2+CvkYRs7FVWB5wRYO/i5yse65gOjQ1IXQ+OFRbS/wjWjnXt0bs0Jfzv7B1Pj6Yzv86I9fIx5I2O8gyey7LIstjQ0MpfkFV130i97nIhiIlbA3JZgENtrkwPWKl3SDCsru85ZUdWrUJXmHcEEavyVobQw39e9WnNOCHgPWku5w2UwsbQ/5Pd0YzjG6JLVeE+JRpvCQs5HG3UhzLJk5p4kGgFsdp+s2/R44UOwLOokapWhl5ZZqCkDZuZa/ieYJapVY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFjHqgGe999rPseiBLHfpY3kq8m0ijdiQbyzHYNE+ys=;
 b=ZNnM4gD6MjY/563F9bEaRBG+pXuqoKrWv4TPb5r/VKF2CXyL7MOyQFJzdRM5SrsCiIhQqhYgQ2E9mHKqRL0mCjw3jUN9QV9zmSFpLHb4b5N4NYTQj+FdbVqMuZvb96ln1NvpusgeRgXguT3ifoE2+6oF5HHavbzbduV69Jfb0A8=
Received: from IA1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::16)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:42:22 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::2e) by IA1P220CA0017.outlook.office365.com
 (2603:10b6:208:464::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:42:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:10 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:42:01 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 53/66] drm/amd/display: Program DCC as part of address update
Date: Tue, 8 Sep 2026 19:31:46 +0800
Message-ID: <20260908113338.2433445-54-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: a589148e-3c8a-4c53-42f4-08df0d9e3f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gfWlvjW9XxwD1NEcJap/58SEOzOg7FzlTTAZ4N6hIXmE+qbNZgIOHYEL4Wa1+OOUQltnd4mCA9a4rkWVk1+LCo0B99c/ZNHozbNNijZKSxIY+45aho10fbib9LOHnYZzy7MTrOd7K19gH54JMsIq3PuIDg7nOFmP/eEfZE1EtddgK+d9fCPCugOtcWqmEO74AwnSZ4m+FmHhEcw0hhegWZzvO9w2Ecyj8cip8e6fe0okE9cfqwv+JzScOo9AL7IBczUj2GOH/z88AyNCuOE/zm7J8vKp/rfkVuGXSuoOevEOqewxNjCTIBiswBy/YqkUlG9ay6H8QDqktBbIgEaoSibBPYRqVewoAD8RBEzUWKlwtBPmw9URBjrf3Jr7UzkAWKa6F5fYr4LBlZmUc94mMCEIhPRJG1ufpVLZlPlq6BLdHESIKTlJQWayM+IMh7YUf8ThYhr7fHHeOPB+dK2nZiJZCKNGE5E577P2IYVaRmpGS4yI4DLgr0GQE9ItdOgo0BBEkEaLwx7RGABD5YhAHRCW2lBBWoqFZ8cBZeusiGXCzK1pvIjpHvajxpvDGtg+O41yCiiGIMS9Zbi5nNMTAyGMbSlcx3EDtejnZP9N6kYsDbrFeKjprw0i1JbRfWP46n0Cw8VIv/owfuktgeuz6zf404RlJ970MatWvchZN6ZBUBuOqli353n0+awPgaZWP/sm84CxBHgy7pQJ8WiuRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ey2jd4EpgMTWhDCTgIvr2W7ZLkMCm0Wd0LXjFc8yyn6WN2jqkuINHORgji6h9S/EhFsAIqaQXAH7K5GP/tdYOB0N5D7Fm44yTcmSMWuSLJ6invzeqqUnzEOp84J7qFE0L3BfUftIqeS0inlblvgVILJ2jmImWu8QZdAK9Mg4Y7NZlYxzsyzaZePDIePASMQS4eNeJ6tB4Brvfo2g33r+FTIaZaLUtl/D9jc4Ry1OqwKBPmK+Q+Dfy6VVzhxXJNXBCv8vgaMPhxvf3igRnVasW+NOnDIWxgdWcKW+gFOZPLIWhHnCuLy4le5MaxLisnOaiPxG2d/IDJ/rByGgbJQWbOofHMnOAqr+IDfxqXrPge02/wHhpHuX1zemUEKCEVHn0mac2XKaAG+7cjPP6hR5B+XdpGpwL8MJIOZYvIGaVxMNHrmWNgEJdClRR8gvVHc8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:42:22.4287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a589148e-3c8a-4c53-42f4-08df0d9e3f1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- DCC register is latched on the surface address register being updated
- In this case couple the DCC programming and the address update
  together to ensure the DCC programming is always taken as expected
- Update address programming function to take in DCC bool, use for
  DCN6+ and leave older DCN unchanged.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  4 ++-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  4 ++-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  3 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  5 +++-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  3 +-
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |  5 +++-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  5 +++-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |  3 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  5 +++-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  3 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |  5 +++-
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    | 28 ++++++++++++-------
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.h    |  3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  6 ++--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  3 +-
 18 files changed, 65 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index ccc58d42e0ab..6ed22b2e9c74 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1713,7 +1713,8 @@ void hwss_execute_sequence(struct dc *dc,
 			params->update_plane_addr_params.hubp->funcs->hubp_program_surface_flip_and_addr(
 					params->update_plane_addr_params.hubp,
 					&params->update_plane_addr_params.address,
-					params->update_plane_addr_params.flip_immediate);
+					params->update_plane_addr_params.flip_immediate,
+					params->update_plane_addr_params.dcc);
 			break;
 		case DPP_SET_INPUT_TRANSFER_FUNC:
 			hws->funcs.set_input_transfer_func(&params->set_input_transfer_func_params);
@@ -2356,6 +2357,7 @@ void hwss_add_hubp_update_plane_addr(struct block_sequence_state *seq_state,
 		dc->hwss.prepare_plane_addr_update(dc, pipe_ctx,
 				&params->address, &params->flip_immediate);
 		params->hubp = hubp;
+		params->dcc = pipe_ctx->plane_state ? pipe_ctx->plane_state->dcc.enable : false;
 		seq_state->steps[*seq_state->num_steps].func = HUBP_UPDATE_PLANE_ADDR;
 		(*seq_state->num_steps)++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index d8eb5996b577..2a4be0c7a724 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -350,10 +350,12 @@ void hubp1_program_pixel_format(
 bool hubp1_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate)
+	bool flip_immediate,
+	bool dcc)
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
 
+	(void)dcc;
 
 	//program flip type
 	REG_UPDATE(DCSURF_FLIP_CONTROL,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
index f2571076fc50..0c1d5e518f97 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -905,7 +905,8 @@ void hubp_reset(struct hubp *hubp);
 bool hubp1_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate);
+	bool flip_immediate,
+	bool dcc);
 
 bool hubp1_is_flip_pending(struct hubp *hubp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index cf2c9f80056e..79a429814061 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -730,10 +730,13 @@ bool hubp2_dmdata_status_done(struct hubp *hubp)
 bool hubp2_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate)
+	bool flip_immediate,
+	bool dcc)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
+	(void)dcc;
+
 	//program flip type
 	REG_UPDATE(DCSURF_FLIP_CONTROL,
 			SURFACE_FLIP_TYPE, flip_immediate);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
index ea90dee05d5f..3ae06bf89f79 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
@@ -399,7 +399,8 @@ void hubp2_program_deadline(
 bool hubp2_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate);
+	bool flip_immediate,
+	bool dcc);
 
 void hubp2_dcc_control(struct hubp *hubp, bool enable,
 		enum hubp_ind_block_size independent_64b_blks);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
index 0dba8ff8a19d..c667db319baf 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
@@ -696,10 +696,13 @@ static void dmcub_PLAT_54186_wa(struct hubp *hubp,
 static bool hubp21_program_surface_flip_and_addr(
 		struct hubp *hubp,
 		const struct dc_plane_address *address,
-		bool flip_immediate)
+		bool flip_immediate,
+		bool dcc)
 {
 	struct surface_flip_registers flip_regs = { 0 };
 
+	(void)dcc;
+
 	flip_regs.vmid = address->vmid;
 
 	switch (address->type) {
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 4f5f10f6d1cc..72698b5cf5f7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -68,10 +68,13 @@ void hubp3_set_vm_system_aperture_settings(struct hubp *hubp,
 bool hubp3_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate)
+	bool flip_immediate,
+	bool dcc)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
+	(void)dcc;
+
 	//program flip type
 	REG_UPDATE(DCSURF_FLIP_CONTROL,
 			SURFACE_FLIP_TYPE, flip_immediate);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
index c767e9f4f9b3..faa7e0379f4e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
@@ -260,7 +260,8 @@ void hubp3_set_vm_system_aperture_settings(struct hubp *hubp,
 bool hubp3_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate);
+	bool flip_immediate,
+	bool dcc);
 
 void hubp3_program_surface_config(
 	struct hubp *hubp,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 2acdac35a382..5ca40941c355 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -486,10 +486,13 @@ void hubp401_setup_interdependent(
 bool hubp401_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate)
+	bool flip_immediate,
+	bool dcc)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
+	(void)dcc;
+
 	//program flip type
 	REG_UPDATE(DCSURF_FLIP_CONTROL,
 			SURFACE_FLIP_TYPE, flip_immediate);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index adf343837652..818cea479272 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -271,7 +271,8 @@ void hubp401_setup_interdependent(
 bool hubp401_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate);
+	bool flip_immediate,
+	bool dcc);
 
 void hubp401_dcc_control(struct hubp *hubp,
 		struct dc_plane_dcc_param *dcc);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
index 96d3310e2c3f..0c8a23cef1e0 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
@@ -398,10 +398,13 @@ void hubp42_program_3dlut_fl_config(struct hubp *hubp,
 static bool hubp42_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate)
+	bool flip_immediate,
+	bool dcc)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
+	(void)dcc;
+
 	//program flip type
 	REG_UPDATE(DCSURF_FLIP_CONTROL,
 			SURFACE_FLIP_TYPE, flip_immediate);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
index 0230f03590cf..ba86e30b1180 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
@@ -22,7 +22,8 @@
 bool hubp50_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate)
+	bool flip_immediate,
+	bool dcc)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
@@ -55,8 +56,10 @@ bool hubp50_program_surface_flip_and_addr(
 		if (address->grph.addr.quad_part == 0)
 			break;
 
-		REG_UPDATE(DCSURF_SURFACE_CONTROL,
-				PRIMARY_SURFACE_TMZ, address->tmz_surface);
+		REG_UPDATE_3(DCSURF_SURFACE_CONTROL,
+				PRIMARY_SURFACE_TMZ, address->tmz_surface,
+				PRIMARY_SURFACE_DCC_EN, dcc,
+				SECONDARY_SURFACE_DCC_EN, dcc);
 
 		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, 0,
 				PRIMARY_SURFACE_ADDRESS_HIGH,
@@ -71,9 +74,11 @@ bool hubp50_program_surface_flip_and_addr(
 				|| address->video_progressive.chroma_addr.quad_part == 0)
 			break;
 
-		REG_UPDATE_2(DCSURF_SURFACE_CONTROL,
+		REG_UPDATE_4(DCSURF_SURFACE_CONTROL,
 				PRIMARY_SURFACE_TMZ, address->tmz_surface,
-				PRIMARY_SURFACE_TMZ_C, address->tmz_surface);
+				PRIMARY_SURFACE_TMZ_C, address->tmz_surface,
+				PRIMARY_SURFACE_DCC_EN, dcc,
+				SECONDARY_SURFACE_DCC_EN, dcc);
 
 		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C, 0,
 				PRIMARY_SURFACE_ADDRESS_HIGH_C,
@@ -96,11 +101,13 @@ bool hubp50_program_surface_flip_and_addr(
 			|| address->grph_stereo.right_addr.quad_part == 0)
 			break;
 
-		REG_UPDATE_4(DCSURF_SURFACE_CONTROL,
+		REG_UPDATE_6(DCSURF_SURFACE_CONTROL,
 				PRIMARY_SURFACE_TMZ, address->tmz_surface,
 				PRIMARY_SURFACE_TMZ_C, address->tmz_surface,
 				SECONDARY_SURFACE_TMZ, address->tmz_surface,
-				SECONDARY_SURFACE_TMZ_C, address->tmz_surface);
+				SECONDARY_SURFACE_TMZ_C, address->tmz_surface,
+				PRIMARY_SURFACE_DCC_EN, dcc,
+				SECONDARY_SURFACE_DCC_EN, dcc);
 
 		REG_SET(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH_C, 0,
 				SECONDARY_SURFACE_ADDRESS_HIGH_C,
@@ -139,9 +146,11 @@ bool hubp50_program_surface_flip_and_addr(
 				|| address->rgbea.alpha_addr.quad_part == 0)
 			break;
 
-		REG_UPDATE_2(DCSURF_SURFACE_CONTROL,
+		REG_UPDATE_4(DCSURF_SURFACE_CONTROL,
 				PRIMARY_SURFACE_TMZ, address->tmz_surface,
-				PRIMARY_SURFACE_TMZ_C, address->tmz_surface);
+				PRIMARY_SURFACE_TMZ_C, address->tmz_surface,
+				PRIMARY_SURFACE_DCC_EN, dcc,
+				SECONDARY_SURFACE_DCC_EN, dcc);
 
 		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C, 0,
 				PRIMARY_SURFACE_ADDRESS_HIGH_C,
@@ -457,7 +466,6 @@ void hubp50_program_surface_config(
 	(void)compat_level;
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
-	hubp401_dcc_control(hubp, dcc);
 	hubp50_program_tiling(hubp2, tiling_info, format);
 	hubp401_program_size(hubp, format, plane_size, dcc);
 	hubp2_program_rotation(hubp, rotation, horizontal_mirror);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h
index e7d9bb3623b9..a497a90947b6 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h
@@ -21,7 +21,8 @@
 bool hubp50_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
-	bool flip_immediate);
+	bool flip_immediate,
+	bool dcc);
 
 void hubp50_program_surface_config(
 	struct hubp *hubp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 7fa329229ae0..84e146f2509c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2100,7 +2100,8 @@ void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_addr(
 			pipe_ctx->plane_res.hubp,
 			&address,
-			flip_immediate);
+			flip_immediate,
+			pipe_ctx->plane_state->dcc.enable);
 }
 
 bool dcn10_set_input_transfer_func(struct set_input_transfer_func_params *params)
@@ -4184,5 +4185,6 @@ void dcn10_reset_surface_dcc_and_tiling(struct pipe_ctx *pipe_ctx,
 	/* force page flip to see the new content of the framebuffer */
 	hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
 							&plane_state->address,
-							true);
+							true,
+							plane_state->dcc.enable);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a3d2385bc731..e5f266b0013d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2818,7 +2818,8 @@ void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_addr(
 			pipe_ctx->plane_res.hubp,
 			&address,
-			flip_immediate);
+			flip_immediate,
+			pipe_ctx->plane_state->dcc.enable);
 }
 
 void dcn20_unblank_stream(struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index 916b6804e8e6..c22587188c98 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -176,7 +176,8 @@ void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_addr(
 			pipe_ctx->plane_res.hubp,
 			&address,
-			flip_immediate);
+			flip_immediate,
+			pipe_ctx->plane_state->dcc.enable);
 }
 
 /* Blank pixel data during initialization */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 4b2c801421d6..f023bef4fd7e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -95,6 +95,7 @@ struct update_plane_addr_params {
 	struct hubp *hubp;
 	struct dc_plane_address address;
 	bool flip_immediate;
+	bool dcc;
 };
 
 struct set_input_transfer_func_params {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index b97f08b20984..a648ed3b012a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -176,7 +176,8 @@ struct hubp_funcs {
 	bool (*hubp_program_surface_flip_and_addr)(
 		struct hubp *hubp,
 		const struct dc_plane_address *address,
-		bool flip_immediate);
+		bool flip_immediate,
+		bool dcc);
 
 	void (*hubp_program_pte_vm)(
 		struct hubp *hubp,
-- 
2.43.0

