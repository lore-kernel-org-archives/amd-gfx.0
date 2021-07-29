Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF4EC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C8E60F46
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 47C8E60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035786EE4C;
	Thu, 29 Jul 2021 20:37:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F2B6EE5C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyaL44REiWpakm/cmSdgpeYCrcpyd5t5UMK7Vw0mPcLXzdZyRPRZ8q+4K2QDkl6+X/aCKXkjhwPOIW43oAtHg8hN1YUEYyNKkQjW46MxK+4ZgikbiCHUSqzq0ps9Z1cQ2pXjzAy+dE0TDQ2QPFLn+ra31rfLy6gkdUuACzcNNXNWUGfW8A3Bc9skI6+T9JHHHCzs9NRLx8pH3aUy4qm9J1cKKmfFbu8UHFHd+5RO5V1S0zn1x3acqYT4dcHxlXial1ERRmN3etMEnaXicV3zpJYNC2SGn937OQuSlJrriBe7Imjt1vdcFv9PRxbNReG52mpKf6hdCaiqFGP9zJ/bOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtdxcX8zfjg/aEXXsBTe4YfOq7DUp3EhzTQ8/fOfbYU=;
 b=dgumDgI+QfUEBSRvmQwpHVp7DgO4GESeCJwD2KdBkJ5zYS0Yo0eB1/39EkmpQ+cdvOHJPb0dRXJmvlmxK8boC6ADg3xna+j3CbvnfN7faJdbo7YLnPkhQMRNrT87QIY4zYggEo6oHPGiLkBx8OCFLiEXY2LVAhYsDETxWN7BnLX+63lqlHWxOU9jSXHaltDj+0Uifxw0hGHFg1//rUwAfClxzw1Tn20+f/9GfIo5Amv+LOVbLTvgy4HnIXjMtmeuQC++WnbO9QMR+Q1vD2emz8uwEJ40DKXlenectyNNfemxHcd6hnEF1VdzeTcRFx+XE0fvZEcHW84bLLPgakj2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtdxcX8zfjg/aEXXsBTe4YfOq7DUp3EhzTQ8/fOfbYU=;
 b=3HqqdMivYH2goJ5xc6YEblQZ2UNiy33otUlFGLLxaEIQhnB8g5cqSBM1oLsNpGwkR536KonoG0nHERi3EJP65vXCgytxBu1zTdJzGQt1pdl+BAy/lKA6KTiRqAzS8nwBPtIyK/b/vbG4NeGPEU79gmwfyGFfVWWD3CymmFrB6b4=
Received: from DM5PR13CA0071.namprd13.prod.outlook.com (2603:10b6:3:117::33)
 by MWHPR12MB1646.namprd12.prod.outlook.com (2603:10b6:301:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Thu, 29 Jul
 2021 20:37:15 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::fc) by DM5PR13CA0071.outlook.office365.com
 (2603:10b6:3:117::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend
 Transport; Thu, 29 Jul 2021 20:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:37:14 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 13:37:13 -0700
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:37:13 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/9] drm/amd/display: Assume LTTPR interop for DCN31+
Date: Thu, 29 Jul 2021 16:37:04 -0400
Message-ID: <20210729203712.1566129-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
References: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5ef4f81-6b4e-44af-7439-08d952d0a67f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1646:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16462CF0DBE15F095ACC96BE8BEB9@MWHPR12MB1646.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lM0IJmcCvpWUSPjwN4Kd/jEsTBoNUUYpKxkTWgAFXL98zTzcifkwUrlf4a2+/6Buvn80cB12BIReb3OE2aFcIaaTA4orx84Fp6DBA8A9rg+zF0v1iz0QsdxtEX0heBy18ZdyK6UKUCMQmzoXdq4pfyXgVpcUa8AYv7e0m1X0jXk4v16Yly7M2zIZBqYjYm/LHwhF7qbv6LPtSdOSTYBE7M5O0mdARx3PKR1VHejT6AOFSXFq9eWflzUnE8DaRqIQH58T3EynXVeqfUy6bYzm2L0hFcKks5Ck9m25Q+ukev/TwjdhW/U2NlZJpvdzlkNxT5WSSUD/hb+AfTHsS4oPY7Oh0sPLELwK2m2l038UKJCYHLBzXeL9xcBXXVn9QoIdZ0vhRE77pvq7PFIjcxgX0Ek/X/5B1FD46rIc/xLOCYzo7TwaC3wgfT3GG7gqzlCJMN7PX2nOeeRkmtQFlCnLoQwMMb/Sc3dHlJErlBYZl3EuJHpBCtRFFvrmeVVk3BCDwOct/G8/ADxqtbG/4jtfHKGU2bj/BTwDMCMvxdZUSMz0DkoNcS45fSksuLcW0JMrkmKaBr/JgCURwTvD1u/nkcFxRb2uyXCArVfQZ0HV0xJhJuVAi9lY+ARVNTZ0sjSsHeR8orVlkbl5o5CU9GUnnn8ZqvKE/IzKkOugfm9+GmwqkYAoMP0rYTyFKdfE1Ejn7e75MtZZuesRBbeQCezjM+VOVQTxGfGgIz6xWtxCuHuvR7IRTgAeviaS9MpZKqfx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(7696005)(83380400001)(81166007)(5660300002)(26005)(8676002)(82310400003)(8936002)(44832011)(356005)(47076005)(54906003)(82740400003)(4326008)(36860700001)(6916009)(2616005)(336012)(1076003)(70206006)(70586007)(36756003)(186003)(6666004)(86362001)(426003)(478600001)(316002)(2906002)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:37:14.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ef4f81-6b4e-44af-7439-08d952d0a67f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1646
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
For DCN31 onward, LTTPR is to be enabled and set to Transparent by
VBIOS.  Driver is to assume that VBIOS has done this without needing to
check the VBIOS interop bit.

[HOW]
Add LTTPR enable and interop VBIOS bits into dc->caps, and force-set the
interop bit to true for DCN31+.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 21 ++-----------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 20 ++++++++++++++++++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 16 ++++++++++++++
 4 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f56e061d35bc..cd025c12f17b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3595,29 +3595,12 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 bool dp_retrieve_lttpr_cap(struct dc_link *link)
 {
 	uint8_t lttpr_dpcd_data[6];
-	bool vbios_lttpr_enable = false;
-	bool vbios_lttpr_interop = false;
-	struct dc_bios *bios = link->dc->ctx->dc_bios;
+	bool vbios_lttpr_enable = link->dc->caps.vbios_lttpr_enable;
+	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	bool is_lttpr_present = false;
 
 	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
-	/* Query BIOS to determine if LTTPR functionality is forced on by system */
-	if (bios->funcs->get_lttpr_caps) {
-		enum bp_result bp_query_result;
-		uint8_t is_vbios_lttpr_enable = 0;
-
-		bp_query_result = bios->funcs->get_lttpr_caps(bios, &is_vbios_lttpr_enable);
-		vbios_lttpr_enable = (bp_query_result == BP_RESULT_OK) && !!is_vbios_lttpr_enable;
-	}
-
-	if (bios->funcs->get_lttpr_interop) {
-		enum bp_result bp_query_result;
-		uint8_t is_vbios_interop_enabled = 0;
-
-		bp_query_result = bios->funcs->get_lttpr_interop(bios, &is_vbios_interop_enabled);
-		vbios_lttpr_interop = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
-	}
 
 	/*
 	 * Logic to determine LTTPR mode
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a948f4f48935..22e917714fe2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -183,6 +183,8 @@ struct dc_caps {
 	unsigned int cursor_cache_size;
 	struct dc_plane_cap planes[MAX_PLANES];
 	struct dc_color_caps color;
+	bool vbios_lttpr_aware;
+	bool vbios_lttpr_enable;
 };
 
 struct dc_bug_wa {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 596c97dce67e..253654d605c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2617,6 +2617,26 @@ static bool dcn30_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	/* read VBIOS LTTPR caps */
+	{
+		if (ctx->dc_bios->funcs->get_lttpr_caps) {
+			enum bp_result bp_query_result;
+			uint8_t is_vbios_lttpr_enable = 0;
+
+			bp_query_result = ctx->dc_bios->funcs->get_lttpr_caps(ctx->dc_bios, &is_vbios_lttpr_enable);
+			dc->caps.vbios_lttpr_enable = (bp_query_result == BP_RESULT_OK) && !!is_vbios_lttpr_enable;
+		}
+
+		if (ctx->dc_bios->funcs->get_lttpr_interop) {
+			enum bp_result bp_query_result;
+			uint8_t is_vbios_interop_enabled = 0;
+
+			bp_query_result = ctx->dc_bios->funcs->get_lttpr_interop(ctx->dc_bios,
+					&is_vbios_interop_enabled);
+			dc->caps.vbios_lttpr_aware = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
+		}
+	}
+
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
 	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index f9446ce4fdc5..a7702d3c75cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1967,6 +1967,22 @@ static bool dcn31_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	/* read VBIOS LTTPR caps */
+	{
+		if (ctx->dc_bios->funcs->get_lttpr_caps) {
+			enum bp_result bp_query_result;
+			uint8_t is_vbios_lttpr_enable = 0;
+
+			bp_query_result = ctx->dc_bios->funcs->get_lttpr_caps(ctx->dc_bios, &is_vbios_lttpr_enable);
+			dc->caps.vbios_lttpr_enable = (bp_query_result == BP_RESULT_OK) && !!is_vbios_lttpr_enable;
+		}
+
+		/* interop bit is implicit */
+		{
+			dc->caps.vbios_lttpr_aware = true;
+		}
+	}
+
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
 	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
