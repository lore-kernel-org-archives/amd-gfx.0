Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4495C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B0C60F4A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97B0C60F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C53A6EE59;
	Thu, 29 Jul 2021 20:34:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B28B6EE46
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA3VRJ0e1lmej7FcxkvlHhCDMgw1j61dQLzYS/C8OrZQkp0bShI3KmroUeO6a7NakRNn9FhmLy8n38K6KXOP5Z6gP9FvKGs61SWlzQZpvBRjKVKILur2/6UJ2HHnDWsHwA7JvUxCuFKWrjISjGc0QDWLpN+Obzx+W4NXqyjQck6vpPG2qKwg57z5H9cOqTaOonpfXgfYIU4rG6VXO5jfzPcWMpoVWElLck6W9Y1fwQKiGqZg04Ox+T0KxK9cqnqH+JngX1gBy0HoEmIvvmn4C4Nu0BSCncFjcya0xyoG42Eu59ClNjr0Uzr229mmTAyZN9i+1IrRTf8beDJeQruUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtdxcX8zfjg/aEXXsBTe4YfOq7DUp3EhzTQ8/fOfbYU=;
 b=h0uTIKN1aq0odr4LpnWWaZB26R1n5hJ7emA8EEuQlfBwamNUp6O9TmdGr7VUk6MlRw3O0B/7FD//PO2Esob588nPtjtCgMxcncH46PzgBpv2rA8Ymlpj1zxbCuwj/ThajY1v8rqBhFmKcv4vZWDVpbvPjmcximacMCJC21V0bXbCj22uwUz0tIx+3z+cZURBpm6FYsk2z6QEDsIDghfTQoZfRcP5YsbIt/OSTMU2cHZLxGZC4C5F/1GvXmDssuW0vn5jcQPP71mhbzAAGJMsnfroqmR3Rhsly9prGxO3KK5GV8r7KQMo80LtBTVTVZJVM6Emb5U1FoEmjaLBd9utEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtdxcX8zfjg/aEXXsBTe4YfOq7DUp3EhzTQ8/fOfbYU=;
 b=StifzLkQ0e0wZ9PERJAPJfyZovO65D2OTuFGpgkS8TFQtueRavr/lMo1K/6BB8DEtfVWqDIWDIoq/qqKQuTgPpFmW1tR+laYhdTgPi2XYH2qyrp9Cj59OhMUL8gIbFRyspeFB5hCa1bb58vqInFjM+lYnruQDv/hSmXZbAYcOG4=
Received: from DM6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:5:14c::29)
 by MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 20:34:00 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::3f) by DM6PR11CA0052.outlook.office365.com
 (2603:10b6:5:14c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Thu, 29 Jul 2021 20:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:33:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:33:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:33:58 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:33:58 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/9] drm/amd/display: Assume LTTPR interop for DCN31+
Date: Thu, 29 Jul 2021 16:33:49 -0400
Message-ID: <20210729203357.1562846-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729203357.1562846-1-aurabindo.pillai@amd.com>
References: <20210729203357.1562846-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4647e2bd-8fef-4f06-9f60-08d952d03240
X-MS-TrafficTypeDiagnostic: MN2PR12MB3437:
X-Microsoft-Antispam-PRVS: <MN2PR12MB343793A9A6C9ED9240E3D81B8BEB9@MN2PR12MB3437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WN6UuEwaN7ufs+/m+0gDD5LrG73yEsjnf9zN7peMO0EwGlkhfPzA4A5bJoTsv8ZmMEvvW4KLxxNSFr3A0Jk6x5ZzHIHtIqHJyZ1yFYNk7lt0eq4v3F7R8fBVRXXwQZ8v0VVS+Q/01RsRLIETKDGGroAodlDfPeOLY/tjgKNYGMGgu471FINc1ifZQXNXsqwycloAJ7NCsdPVh/IqBCgTJUIK0C4VqcXf4zwM51c0ftsyWcJ+1xq1nUTZr2z3adGptnb/cC6wM5dtYB9VZeDVGoJUhbjLgHfA9EhcDe04zEBzDd3zJL/MsrLKMSqL34JLB4kdd8Hn0UJ+NLbkozIvJySu+fxtN+5aaxF4W9AAiU3DJZQYKSLnRVh0aRTJEErMbZcFmiqCw17ZX8EFoJzIHLvVP7PWXNnFNcv7TXcVyf4/EAGHW2Q/uqBEujIJF3wyNfGAsda1k5rbELNi8N4uqRXAuiSQDyml1kcBUcP50bw0bLIzalNoVBuUyCNVO2Y9Qmae7768hc7YwIS9H4OAT4EpBgKBo0AZh2IqDe55C6lrz+EwtaJnbEAJskBpdMXt0YNfBoyWyON6PaS0p8YchVEjjClqNpXaQexXJmQgBbMX/nkUMssrwmu9OFHQ3vjUMEWHohcGIyFS1+tyZaPvAxZC88qKa4SinHuWhp5FPssfPj37lrcEVmj+GzPeqwBgbz6l2JTaoZEK2utr0H0tCMCUeDDVLai60lNGwvDqRjoY5UmlCtH3NFW4kEkOFHGM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39840400004)(46966006)(36840700001)(2906002)(86362001)(54906003)(81166007)(26005)(44832011)(426003)(2616005)(1076003)(4326008)(316002)(8936002)(5660300002)(478600001)(6666004)(7696005)(8676002)(82310400003)(6916009)(36860700001)(70586007)(83380400001)(336012)(70206006)(47076005)(36756003)(356005)(186003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:33:59.8437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4647e2bd-8fef-4f06-9f60-08d952d03240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3437
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
