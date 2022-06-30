Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6529DC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C47AB12A8F2;
	Thu, 30 Jun 2022 19:14:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5894112A8F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUpnB5zwElG0MJ2LBKfIsL/xq7zuaOCo+n59BwIOfFuzksekD7ViVexdVvl6qjGMDtR6iE05FUdswRvkv/i+HRHXWFEKp28d+9a43MS3g5FmabsOilx1LXPRCu7bQ4Kyxcl137Z0WjBnzQ0z6Ci3e6TVtAB5gfN5+Q+ePzOBv5Zu3aUSWXISCMkbWIramCk+bULj7F1djWUIlA+49YTI3zd7iiH1vnpfPLQ8Za9wWjaSZISjnuEmvwGx+D/ndrs0LAqnwakgQR9poUhGTmlfPQFxsWpcIHxIJZSObnQuKAop983pabKAzdb+P55Q0j7JTx0ul2pUPM4XpMpQ8e+5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMjgia6N3zLMi4AYiM9MJ17v7dX52i1TzgvJ2k7smOI=;
 b=TX6k2VF1QY+NBawkS7JxoKhXNigELk1eoBDCkGWPE/ct9PV3GrcD3LqYj41EZiGRiNsjMAmldrU90pZXknNy7SOrxpX1VrMqS/dbodc9Pd0run0pmFHPVHvpP4KICpvY1bqQCYLjx6vmUx6fDXUifSkXYS5p3YQcfyjogLsVEmeci+ANeXW0EyAyY58bRlK4XnxzqWuCwXa5ITd90mqSjv9uRQsVFJrfpH1Irqivt5BQrj9eg5Kr2Xm0eFKL4mqu0+dEGvfs9UO/O+ibEWhmq+OJHThXMQUxU9l5cDT9pWFLXLr2Yiqt34chbNPA81CZjtytyXkNWkJrK2f3tJDStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMjgia6N3zLMi4AYiM9MJ17v7dX52i1TzgvJ2k7smOI=;
 b=4mpDf0upyS9LhycblqjGAZ6EOmRmR5IU9lcCzlF7QTOulcWQ00HjUmvajtOPbGl2E2pBnOFt1DgvhDtPIqP9rWmZLR3ZMoLgasHroOySuzf2mfCW0nPeMHRJQSbFUX57ACbVqhyreLSf/YTsA3yhG9rIya+iciGWIhG09HONLaU=
Received: from BN6PR17CA0030.namprd17.prod.outlook.com (2603:10b6:405:75::19)
 by DM5PR12MB2423.namprd12.prod.outlook.com (2603:10b6:4:b3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:14:28 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::f3) by BN6PR17CA0030.outlook.office365.com
 (2603:10b6:405:75::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:27 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:26 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 38/40] drm/amd/display: rename hdmi_frl_pcon_support
Date: Thu, 30 Jun 2022 15:13:20 -0400
Message-ID: <20220630191322.909650-39-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79f07959-7226-414c-dd6a-08da5accc0c5
X-MS-TrafficTypeDiagnostic: DM5PR12MB2423:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJFMOQJK59oe1lVZrwp0qTxdLuOeFZYqsawh0/dfdLmGhl0rx+z5zMLDmCSxkrA0Eowrf20Sv5sav6S665JB4P3yR9x7TlpvVG5n33LYWdHKsp7U2AkKdYpvFvEm9Ijmd3nTG8/I+tbEDIQPi0zviNPTrqNopSqnqf7BbXUG6pO1rLLguILtWC5U/jG/kls1RntXhCQntziXGnokfp3Q6Che4yHrw6IDaPsAtw6O5d53HVw8xTJ8a/z+5mQypmMuWpE4p8SyNujsRXSBT1aLqSWP19+18cdPA7FWkDYlsnHCTohRmmNpo6tNQr/89MXmIEjZ1SalM2gMhxR3RZMaloSeuByXX5Be7l3xUrwWLuQbZc/tryxmjiZGrZKy2uKcGkqPnWqtO8hSq/ZmMvKAQ49kRyAz5qTvMdQTis6vI9N1D8JMw9G8wPJKJTiIPhKpqftWp28VV4LOVF5Ikl2Y+DaoIRZAdY2st51AiTDlyF2ytjdiMYX8EV5QFZBO2vggkw1JoTghSNoiMxZADIlDStY2gzdGnt6aiFRCXPH9BQ+4bdmSlCh7LrpZdERjDgfLUcNnAU/WnFhhsbd1i+g3CNPGZKfqOXrPaH564OKGr3qatprPSwffsTZ6IT4fl1o82Isch89LfCxbeluOG/DTFIwy0D1FdTk/eMyNbd79Ki3M0BzU9p4UhzWHzzw2/pjsNB9yneuWWUkhbYK0JXoIsqbcLPBNSA1GIk/EBvMOQDBe8M4pbolH+IHjnsX7KmHpLUFDlrvOw07BOoPPDhdz3JDrELO42kvPFYkdMTmvASCyfAR2GUcoYl+5TuuX99EFDkvNOXDINT6zV/b32pwnqi/MTgvF2Zu6XKBkItyfWpo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(40470700004)(36840700001)(40480700001)(54906003)(6916009)(426003)(86362001)(336012)(36756003)(83380400001)(2616005)(4326008)(70586007)(8676002)(1076003)(82740400003)(2906002)(356005)(47076005)(70206006)(16526019)(81166007)(186003)(316002)(36860700001)(7696005)(5660300002)(6666004)(8936002)(40460700003)(41300700001)(82310400005)(26005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:27.9586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f07959-7226-414c-dd6a-08da5accc0c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2423
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

hdmi_frl_pcon_support has been the source of confusion. So, rename it to
dp_hdmi21_pcon_support.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c        | 2 +-
 drivers/gpu/drm/amd/display/dc/dc.h                     | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 07e5b316fbde..a126921c664a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4890,7 +4890,7 @@ static void get_active_converter_info(
 							hdmi_color_caps.bits.MAX_BITS_PER_COLOR_COMPONENT);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-					if (link->dc->caps.hdmi_frl_pcon_support) {
+					if (link->dc->caps.dp_hdmi21_pcon_support) {
 						union hdmi_encoded_link_bw hdmi_encoded_link_bw;
 
 						link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps =
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b9a23e6b3696..a9c59669dd1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -203,7 +203,7 @@ struct dc_caps {
 	struct dc_color_caps color;
 	struct dc_dmub_caps dmub_caps;
 	bool dp_hpo;
-	bool hdmi_frl_pcon_support;
+	bool dp_hdmi21_pcon_support;
 	bool edp_dsc_support;
 	bool vbios_lttpr_aware;
 	bool vbios_lttpr_enable;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index a0a94ea58a57..1483de85a524 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2463,7 +2463,7 @@ static bool dcn20_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
-	dc->caps.hdmi_frl_pcon_support = true;
+	dc->caps.dp_hdmi21_pcon_support = true;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV) {
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index faab59508d82..d95875952fba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1490,7 +1490,7 @@ static bool dcn21_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
-	dc->caps.hdmi_frl_pcon_support = true;
+	dc->caps.dp_hdmi21_pcon_support = true;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index b74d5f3f0472..4f684235a413 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2379,7 +2379,7 @@ static bool dcn30_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
-	dc->caps.hdmi_frl_pcon_support = true;
+	dc->caps.dp_hdmi21_pcon_support = true;
 
 	/* read VBIOS LTTPR caps */
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 1a67d04cc017..16bbccc69fdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1898,7 +1898,7 @@ static bool dcn31_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
-	dc->caps.hdmi_frl_pcon_support = true;
+	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index e346a00f395f..df2abd8fe2eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1768,7 +1768,7 @@ static bool dcn315_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
-	dc->caps.hdmi_frl_pcon_support = true;
+	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 1b170e2d546b..070fe10a004e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1770,7 +1770,7 @@ static bool dcn316_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
-	dc->caps.hdmi_frl_pcon_support = true;
+	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 65de38b96312..5e9ffd43bc09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -4010,7 +4010,7 @@ static bool dcn32_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
-	dc->caps.hdmi_frl_pcon_support = true;
+	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index f38b16335086..da44044c8cc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -2305,7 +2305,7 @@ static bool dcn321_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
-	dc->caps.hdmi_frl_pcon_support = true;
+	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
-- 
2.25.1

