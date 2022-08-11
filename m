Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD72C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 19:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2E258B355;
	Thu, 11 Aug 2022 19:56:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4418B320
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 19:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zan+HGUxqEoT1SggSxHoU0cmjEhKfcVQGbQ5TAZxvF8Lz5f/7L9pMexSYnQUjGoJDn4cPcnStRIfDT1a3avSAwRKrEhfxRvh+YV1BED9eORyxMTxITOAN9nwy4kDD57GTforPrAx91Ew78p7yrnjovhXO8Es4lI4d2ffqgVafVIWkgEyqUyGvgGSrA3xh+du1zRuan5TPqtrqpiN7/bEvw6iZNijEdVIvV7H9r1q1YwwXRd+ih3XmFUfpRMQbYDOojjU3/+k+SDMMhJkd6CD5GWepxiaVhSGFiQPGKnkVClWRJpE6ESnBwycUxo6YCjNgs3SeL1xfxNF4zyMfWg0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNZJrE4uP2nrqwkzyI5SOosUABvQv7y4LJ7u8chNzLk=;
 b=WnFN8C9/QMv5HE3e/wxY7AfYANl+jiAkS7WMYd00HcOCFSgGWP2cJ2m90HZwVVtvSq61gZR9PabA678Yabfxt86Y6GAPaLa64BR5WaML8tY+VuhgMl1bGh3qNwjBRK+V8+HGBEoPSWV5b1frvyFp2qukpnrEvl7+VbqkSWQTiMBKH+7ulLVJ3vwODnu6rRljX/tarJziQxmPdWbs/6RkhRoQoeWIgMjbag8knu9Et9CC5M8ZfJNf5ZxPPNe0jlqDIeQuTOgYz1V9e0sFzesr1lncnIf+DsJPuCqSqtWrgcQQiwr8Plz5VT1vx3n6jxqufQCDydLPIxh+J59CYmOB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNZJrE4uP2nrqwkzyI5SOosUABvQv7y4LJ7u8chNzLk=;
 b=dWa7ZV1f4YDkmdb96tlqLDUFfDdl0X1ViTNoRkXHLrqo9XXR7XCrDwk60j6a7dA8wGCTCOlcppz8wswhEHzOxOr+hKk/KjKr+9PGvf1IEOQm1fmrojr4XSZPxJy/qedg+uArVYNXivgGcEFEB0F0MHpDuuK/ZaPR3LFJ5H4wIr4=
Received: from DM6PR08CA0040.namprd08.prod.outlook.com (2603:10b6:5:1e0::14)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 19:56:34 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::5a) by DM6PR08CA0040.outlook.office365.com
 (2603:10b6:5:1e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.13 via Frontend
 Transport; Thu, 11 Aug 2022 19:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 19:56:33 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 14:56:29 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix a compilation failure on PowerPC
 caused by FPU code
Date: Thu, 11 Aug 2022 15:56:19 -0400
Message-ID: <20220811195619.4155393-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 845d81db-72c9-4453-327d-08da7bd397a9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GOF57vw3Kg6+zVfb7RE0PfjT8KqMBCHIfiosUlvRYDGaiazCJVI/bsgz+Te7UDcC5K8hRqRJMvmMuzRLkB5kobbvjHUocEuxYzT5tTJNUQdHpDCv+ZptNWq/aYTGKo4RmsPEEpUgOpeQ5Afn3WMEVnJ4Erns4W/Webv81KvmjiZvWVFJVYp4qIcC8xW1Fjeo9PKC6bUbaRKpmiLawU9boibqgYZ7nxqL+XS9LEnAE73SDrlHIQI74p14n8zHWlGn//4wWRADfP/L3XbdNvmM4705gSZpbfTH0IjGTyU6WKgvJrVcfpBOeadY7Bh/wB8eLMQ6/cv8TDGz0aYg9eITYTwY6v6ABt6fvZcZhKSpIeChjUhNFTNZb3Urj7/50mwGEOxn6J/gCvQ5VBv6yTj+xaUpQheGTHSgSBD14QkbGMqgLXE6S3lNIQjm5DiJlJWJcBiZzO83zj6dRbV5SVK1PpzOooDav+I3voLh6wcJQZ9343qxpEqH4qfUuihH9DmaTLP9qelaWfxh5FL1MBGwQIEyOF/g2qNfzY53MaXJ2wJ/oxk/VVUh+XM0J+lpmvnuqwzVRPZzgNiwe96e+QdF/sZ1LeLr4aHRbxshD5twhyS7HWPSmD0hP529F05fu5GsuOzwUFz/pMvSYnxh4mhSl9rCOZoA0vzxOxYxvf2U08mMw2fQ6QNXO3CMXa3neYOIuEWdYoOv6hsoY+YwcYneyAoFEDxaLoevArTO0UM45wn5xN3gWOrb1IpmUwJxGkmKDzlIpk32EyiApTP1FoyiQO4uIBrQJob9K4nMgTlkmmHM8ZFhlR2AFTm0+l32fGYmXLgzhSsIoYX5AGHZSKMRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(40470700004)(46966006)(6636002)(8676002)(83380400001)(41300700001)(6666004)(4326008)(40480700001)(2906002)(70586007)(70206006)(36860700001)(316002)(1076003)(54906003)(2616005)(36756003)(110136005)(16526019)(66574015)(47076005)(426003)(186003)(336012)(82310400005)(26005)(81166007)(356005)(86362001)(8936002)(5660300002)(40460700003)(7696005)(478600001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 19:56:33.8173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 845d81db-72c9-4453-327d-08da7bd397a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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
Cc: Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>, Michael
 Ellerman <mpe@ellerman.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We got a report from Stephen/Michael that the PowerPC build was failing
with the following error:

ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o

This error happened because of the function optc3_set_vrr_m_const. This
function expects a double as a parameter in a code that is not allowed
to have FPU operations. After further investigation, it became clear
that optc3_set_vrr_m_const was never invoked, so we can safely drop this
function and fix the ld issue.

Changes since V1:
 - Drop optc3_fpu_set_vrr_m_const since it is unused.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Maíra Canal <mairacanal@riseup.net>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  8 --
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |  3 -
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |  1 -
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 77 -------------------
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  3 -
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 -
 6 files changed, 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index d072997477dd..1782b9c26cf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -184,14 +184,6 @@ void optc3_set_dsc_config(struct timing_generator *optc,
 	REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
 }
 
-void optc3_set_vrr_m_const(struct timing_generator *optc,
-		double vtotal_avg)
-{
-	DC_FP_START();
-	optc3_fpu_set_vrr_m_const(optc, vtotal_avg);
-	DC_FP_END();
-}
-
 void optc3_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
index 33bd12f5dc17..dd45a5499b07 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
@@ -329,9 +329,6 @@ void optc3_lock_doublebuffer_enable(struct timing_generator *optc);
 
 void optc3_lock_doublebuffer_disable(struct timing_generator *optc);
 
-void optc3_set_vrr_m_const(struct timing_generator *optc,
-		double vtotal_avg);
-
 void optc3_set_drr_trigger_window(struct timing_generator *optc,
 		uint32_t window_start, uint32_t window_end);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 9861be1dc063..1fad7b48bd5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -281,7 +281,6 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
 		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
 		.enable_optc_clock = optc1_enable_optc_clock,
-		.set_vrr_m_const = optc3_set_vrr_m_const,
 		.set_drr = optc32_set_drr,
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
 		.set_vtotal_min_max = optc3_set_vtotal_min_max,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index e1e92daba668..814374b1016c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -177,83 +177,6 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
 };
 
-
-void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
-		double vtotal_avg)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	double vtotal_min, vtotal_max;
-	double ratio, modulo, phase;
-	uint32_t vblank_start;
-	uint32_t v_total_mask_value = 0;
-
-	dc_assert_fp_enabled();
-
-	/* Compute VTOTAL_MIN and VTOTAL_MAX, so that
-	 * VOTAL_MAX - VTOTAL_MIN = 1
-	 */
-	v_total_mask_value = 16;
-	vtotal_min = dcn_bw_floor(vtotal_avg);
-	vtotal_max = dcn_bw_ceil(vtotal_avg);
-
-	/* Check that bottom VBLANK is at least 2 lines tall when running with
-	 * VTOTAL_MIN. Note that VTOTAL registers are defined as 'total number
-	 * of lines in a frame - 1'.
-	 */
-	REG_GET(OTG_V_BLANK_START_END, OTG_V_BLANK_START,
-		&vblank_start);
-	ASSERT(vtotal_min >= vblank_start + 1);
-
-	/* Special case where the average frame rate can be achieved
-	 * without using the DTO
-	 */
-	if (vtotal_min == vtotal_max) {
-		REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_min);
-
-		optc->funcs->set_vtotal_min_max(optc, 0, 0);
-		REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, 0);
-		REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, 0);
-		REG_UPDATE_3(OTG_V_TOTAL_CONTROL,
-			OTG_V_TOTAL_MIN_SEL, 0,
-			OTG_V_TOTAL_MAX_SEL, 0,
-			OTG_SET_V_TOTAL_MIN_MASK_EN, 0);
-		return;
-	}
-
-	ratio = vtotal_max - vtotal_avg;
-	modulo = 65536.0 * 65536.0 - 1.0; /* 2^32 - 1 */
-	phase = ratio * modulo;
-
-	/* Special cases where the DTO phase gets rounded to 0 or
-	 * to DTO modulo
-	 */
-	if (phase <= 0 || phase >= modulo) {
-		REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL,
-			phase <= 0 ?
-				(uint32_t)vtotal_max : (uint32_t)vtotal_min);
-		REG_SET(OTG_V_TOTAL_MIN, 0, OTG_V_TOTAL_MIN, 0);
-		REG_SET(OTG_V_TOTAL_MAX, 0, OTG_V_TOTAL_MAX, 0);
-		REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, 0);
-		REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, 0);
-		REG_UPDATE_3(OTG_V_TOTAL_CONTROL,
-			OTG_V_TOTAL_MIN_SEL, 0,
-			OTG_V_TOTAL_MAX_SEL, 0,
-			OTG_SET_V_TOTAL_MIN_MASK_EN, 0);
-		return;
-	}
-	REG_UPDATE_6(OTG_V_TOTAL_CONTROL,
-		OTG_V_TOTAL_MIN_SEL, 1,
-		OTG_V_TOTAL_MAX_SEL, 1,
-		OTG_SET_V_TOTAL_MIN_MASK_EN, 1,
-		OTG_SET_V_TOTAL_MIN_MASK, v_total_mask_value,
-		OTG_VTOTAL_MID_REPLACING_MIN_EN, 0,
-		OTG_VTOTAL_MID_REPLACING_MAX_EN, 0);
-	REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_min);
-	optc->funcs->set_vtotal_min_max(optc, vtotal_min, vtotal_max);
-	REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, (uint32_t)phase);
-	REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, (uint32_t)modulo);
-}
-
 void dcn30_fpu_populate_dml_writeback_from_context(
 		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
index cab864095ce7..e3b6ad6a8784 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
@@ -29,9 +29,6 @@
 #include "core_types.h"
 #include "dcn20/dcn20_optc.h"
 
-void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
-		double vtotal_avg);
-
 void dcn30_fpu_populate_dml_writeback_from_context(
 		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 828e5c6ad1cf..72eef7a5ed83 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -310,8 +310,6 @@ struct timing_generator_funcs {
 			int group_idx,
 			uint32_t gsl_ready_signal);
 	void (*set_out_mux)(struct timing_generator *tg, enum otg_out_mux_dest dest);
-	void (*set_vrr_m_const)(struct timing_generator *optc,
-			double vtotal_avg);
 	void (*set_drr_trigger_window)(struct timing_generator *optc,
 			uint32_t window_start, uint32_t window_end);
 	void (*set_vtotal_change_limit)(struct timing_generator *optc,
-- 
2.35.1

