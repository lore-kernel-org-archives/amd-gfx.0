Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB702C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 22:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0DFC8FB93;
	Thu, 11 Aug 2022 22:36:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D22310FE66
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 22:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcJIGX2V2hZ2O3JPxNJbqcFzUmMKM95XBDeTxcWctWFj8PNPR6fjW+0MVN/Te0Ab5+wiuoB+if5/mLBRtU0vdaiH7RllhwryOM4DnWQwIl7/dK/9ZCe4gwjkYQIolQbEl3jMnXV7VnQII0/BdtGF9xz6uQ1nQ+x02Gz13CoREReHrsRZ9ILWLlP1l4hZ14EOwZPO9C10ZXJ/nxfxLDnOL54MmNmT72f5zohh89qe6661PBnawP60OtpqgXjtxiOUNqysp+yY9tvnz0H9zXGKfx2vKQ3RCnq9WgoKro7oEsCvC35AUhuvWwqOuPNgRJGhoFlK5Gev8QkT+iB7gPo56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcXo3wD7TuogJy7+Ty7Tj44yID9d2fY4VGMDWS9NuKM=;
 b=CE8PYqiLwaCWTxk0+d7PzRhI6Qs6Bc9CwmoDb+ACH5TGOxKYVtw+kh4SsX5Q6My0okyTNTfseH3uUk+y0bqxDZQT6U/P4NSaQJeYmevhnghzJ5L4w5/QUEAtQ3rAgvqZUN55SWCbQZhL56Gf1PFdE/nFdMKZQwcFg1XQafONc1V8e4rYrDWc1bko8dBqmVRaG0E//bSfaOg55rQ0MjUlQ9IzMShjGaIPweKz5w485CUXuHyj2pebQqzlJ5n6v1kKblqjqhxdzW/UnXB4sWhyWyxXGeXqpWOC1idU3tf644paNras4hXdlDhNPf1ZPdkJtLmVQ1JKwiTT0rpzgnnetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcXo3wD7TuogJy7+Ty7Tj44yID9d2fY4VGMDWS9NuKM=;
 b=dkekcEpREb1FMPi6oZoAnH+49BCl7cHbZVgJEAwuN2VmwiCNLDwxT0LjF3ZkX1intE4oGsJnlE42/DywXhq8Ip18zclRwXtXIWrrTTyksGXHiIkd83eJlTOkttjh2eBqmlk9YVEy8slqBwcXLSKJBeVTrLL1/mdz475uJvEYVtI=
Received: from BN0PR04CA0117.namprd04.prod.outlook.com (2603:10b6:408:ec::32)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 22:36:02 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::33) by BN0PR04CA0117.outlook.office365.com
 (2603:10b6:408:ec::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 22:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 22:36:02 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 17:35:59 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Drop unused code
Date: Thu, 11 Aug 2022 18:35:30 -0400
Message-ID: <20220811223530.55892-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da051190-0e51-4efd-7b11-08da7be9debf
X-MS-TrafficTypeDiagnostic: DS7PR12MB5959:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZUeSMtiIqX9bqt+Qcoit5ODclfRl2R1aGS8QBatO3dV0YHVG8fhwgk1owg8CHWJQyTdWJsZ5BNpe4cq/Wxt3aJBL8JAXqWcLCMbpVj4SJGwqyGEKmm6YwEBkWFLzpMQsNNKppwOjLkLYqz2byDhRRNyNr9yfTtJgeG0W7atPas/WRw1atVydfuUYfEFBh56XMQl+pf7dCLTRuLhFwq7SUYPOKF8Wr7yyp9L/Yx5dFMvPvziYy5TusLS/RZANo4itVzExxs+9jjd7lQzbF2a8XWFsVdklpswBUwJQPt7wxRBC5ONmhqJIMYFAUJSRFIDbihhxWggmZLIz/p05popAz6c3hwMImdhNnRmTOgT+gsUoX6kar4AbMB5fDV0k8vy7X/DIP/Ve1MJBl5bZPbV/0AGS1bvQJnElcH5aBAsru1GDr0dCBN206pF7gHgJXu7cBCrZIb7QwMnJLVrbvAXu6j/aG24NKF9+YkIWahHn4QyI/uU/eGbqFQF7LY7wyys7/HBnUHOR0PEPQJHcmU3nIpidivo5sXmCr0DDfQzYLOJf2QMohs1FJaAsr9ErH+N/b/RkhAxE1iKOng7XyslqYJuwSJGaP02IdR19H81U84xWzQ58P5d2VG+PlSnA5ZB7ijOJtLUDgQtu/xZfsvEAIHmzeDy0EJ8+xGsib8zdkDMqXVU7s81K7OD9pw6kCUjd88mK/VTd5eFzrIXvr8D8A2vt7+y1PZrEqb/6dAuzdP3t6g46KUaf9kSHyRt6XUoiNzdf1GEmVBtjJ1gt2fO0sO5ESH55wjCB1wR7roC7cNT/PX6wNPQaFPHz9F6Kx2XzGXHysnVN8+cgs0lvVJzgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(40470700004)(8676002)(36860700001)(8936002)(2906002)(4326008)(83380400001)(37006003)(70586007)(6862004)(5660300002)(70206006)(36756003)(41300700001)(82310400005)(478600001)(16526019)(6636002)(426003)(186003)(336012)(316002)(2616005)(1076003)(47076005)(40480700001)(81166007)(40460700003)(82740400003)(26005)(6666004)(7696005)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 22:36:02.0252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da051190-0e51-4efd-7b11-08da7be9debf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After removing some code for fixing the PowerPC compilation, we had some
leftover functions that are not used anymore. This commit drops
optc3_fpu_set_vrr_m_const since we don't need it anymore.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 77 -------------------
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  3 -
 2 files changed, 80 deletions(-)

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
 
-- 
2.35.1

