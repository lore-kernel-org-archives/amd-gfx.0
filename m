Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A409AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0C7610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E0C7610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B426E21D;
	Fri, 24 Sep 2021 19:10:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 234F66E21D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVSWOQo/6hEtmXpKiTKFWTRgDLWOhSm0WY0cp0jCqclnBEEq8EArraCFDykQy79xPBQbX/0lvHoriy0Gs/fGyA0xD+gHx1HHfEMuE1Vpc5AhCVmZMK5UcX3+gyADHGZ4UtemXaRjC051p22gp/pU1KbEjPVrRXtvz1ZjxRWVz2PEImRFtWODzGDorTa/D8Mwx/+GBzS1KfRRnj1VUFaWODK/ZQobU5GauN1CBrNbEYbVKX/9f25bbZ8Bx1zzMhhjZhJG/HSBJg/sOitLtePeElQGwUrblxGZ0DeaFEMhDdQI6HKktI+HfXzbbHGRqC1rK9Hkq+/0XvvT6ZABmOcwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=BB1Mp+2lBhq9G+F8N4UiDc+eV3ff72WBSeFWat8d7fA=;
 b=CssJYBrfTxJ+QOnttTMTCfJOsnYe5bOoqNE4TDNz+a7WzlY9bw2kIemO1z+u8x0QyX8eRve5WxcoVKNXd6wO3BI7UWGwh+CFdPaKpKmjGXx+OK/BMV7zEVIt/N9Cujm9Tp5qp+ps97mnwtFKquUKUaluOM+AfkRphR4yKjG3JLV4hkngUuhhPq3UEjO3UenEXJi3W2Du8p0AE5T96uLyEtxlQrcMttGjqFU6ncREnqBsQPBfUzIjyK5k2KCYreJj8idLUN+aaF8WPYnswV5/MUML7fGBYFAeBnK93cTRgN7Bs/sq/6H5KnabWrXzR7jY5WkXbXX4DSTGbZRolMIMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB1Mp+2lBhq9G+F8N4UiDc+eV3ff72WBSeFWat8d7fA=;
 b=5CjYjkdMDZTk3pCeucSHz7jIov/Y2pOMjwJ6sRQ1/1A3b/eMnKaujN+q45Cq5C/9jy5rfUiF8VxRxgK7ThckgtG41BrizWd/a7Z95EFQ5MucapUofIEhKCruqU995UKnOU9/2rUI6i9xsDADd95q5iCz0RfI1OmkkEZfqydobDA=
Received: from DM5PR04CA0059.namprd04.prod.outlook.com (2603:10b6:3:ef::21) by
 BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 19:10:31 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::77) by DM5PR04CA0059.outlook.office365.com
 (2603:10b6:3:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:31 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 12:10:29 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:28 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Eric Yang <Eric.Yang2@amd.com>
Subject: [PATCH 19/24] drm/amd/display: Defer LUT memory powerdown until LUT
 bypass latches
Date: Fri, 24 Sep 2021 15:09:29 -0400
Message-ID: <20210924190934.1193379-20-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64dc045b-7a99-4f52-9c95-08d97f8efa7b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4100:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4100222634151F60B9ACCF1BEBA49@BY5PR12MB4100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPOViLkqGCXmLTtb0w7Z99X9kPhM3Nua5rIhNTFD9NzexLPd2sBDkY1uM5qSUIdOAFngi8OuGFT5hXGRXZXTb1f/DGv+YD7YD1ftP2CNxM2iB6LAsDSKbc4M/gEtlSlqrC4P+N5wYWm++bMGT91iijLwpx+J1nkukcO1OzHnlSnIHpK+sbFvuIL2v323oaVri8J2jav/bcb48mUmIg+eJlhwmnwWnYKBTDfd9slLbU+U3CYaJC9uSaasMG/QClcgW16igM1i8hVo++XYMPITtVaQi4/6ywnelccCsUOW+OQGNiLbwuXtz10w596LZ6jWWpDhTt2mPsjMmSXtTGz4ptkKsjjH5htYEQ95YJk5U6IIIoy3WxaxkJ1hEAvRWTwCAm+xg6a4Co/sI4g3NPEoHDoR1YfN7iJvVzwGGEbfLYkVnnnep0xa2g5kXIopRtLATI9U8DNel/4Y2T9AKin0fRdIE+xkLi4B9wqXTXOIpLVc1N2ZbN8IOKK2RbPADBCw9COhQaEZ0DbQWsTbtijkfEzJmz2qrM0Arz6FiGo5hvpIgqf9C7H2vTsxgSZfqv5RByfqzehPJkCtB3fTj8wv8u76CtJ0wXlUJo+PwUt+ZbmRIEqQwP5RbiXJezfgL4Hv1axIbIoppcu4vTnz2njL7X79pkUdN70ssWqwBmAJBcyRDQFJQFNicG52eyHzb28jUOUY8AEqsiEh1bDlyMXGmhV2fX4AgFzAFbKNZoM38Fk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(356005)(2906002)(70586007)(186003)(426003)(2616005)(81166007)(70206006)(26005)(36860700001)(47076005)(82310400003)(83380400001)(4326008)(6916009)(7696005)(54906003)(5660300002)(8936002)(316002)(508600001)(336012)(1076003)(86362001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:31.3404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dc045b-7a99-4f52-9c95-08d97f8efa7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Blnd, 3dlut, and shaper LUT select registers are double buffered, however
their accompanying LUT memory shutdown registers are not. As a result,
shutting down LUT memory immediately after setting a block to bypass causes
corruption as bypass only happens at next Vupdate.

[HOW]
Re-enable mem low power for CM block
Force optimization on next flip and disable LUT memory during optimization
sequence if LUT select field is then set to bypass

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 19 ++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 59 +++++++++++++++++--
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   | 12 ++++
 4 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 644005846433..0f0440408a16 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1793,6 +1793,23 @@ static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
 	return false;
 }
 
+/* Perform updates here which need to be deferred until next vupdate
+ *
+ * i.e. blnd lut, 3dlut, and shaper lut bypass regs are double buffered
+ * but forcing lut memory to shutdown state is immediate. This causes
+ * single frame corruption as lut gets disabled mid-frame unless shutdown
+ * is deferred until after entering bypass.
+ */
+static void process_deferred_updates(struct dc *dc)
+{
+	int i;
+
+	if (dc->debug.enable_mem_low_power.bits.cm)
+		for (i = 0; i < dc->dcn_ip->max_num_dpp; i++)
+			if (dc->res_pool->dpps[i]->funcs->dpp_deferred_update)
+				dc->res_pool->dpps[i]->funcs->dpp_deferred_update(dc->res_pool->dpps[i]);
+}
+
 void dc_post_update_surfaces_to_stream(struct dc *dc)
 {
 	int i;
@@ -1818,6 +1835,8 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 			dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
 		}
 
+	process_deferred_updates(dc);
+
 	dc->hwss.optimize_bandwidth(dc, context);
 
 	dc->optimized_required = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 23a52d47e61c..ef5f6da5248a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -488,6 +488,40 @@ void dpp3_cnv_set_bias_scale(
 	REG_UPDATE(FCNV_FP_SCALE_B, FCNV_FP_SCALE_B, bias_and_scale->scale_blue);
 }
 
+void dpp3_deferred_update(
+	struct dpp *dpp_base)
+{
+	int bypass_state;
+	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
+
+	if (dpp_base->deferred_reg_writes.bits.disable_blnd_lut) {
+		REG_GET(CM_BLNDGAM_CONTROL, CM_BLNDGAM_MODE_CURRENT, &bypass_state);
+		if (bypass_state == 0) {	// only program if bypass was latched
+			REG_UPDATE(CM_MEM_PWR_CTRL, BLNDGAM_MEM_PWR_FORCE, 3);
+		} else
+			ASSERT(0); // LUT select was updated again before vupdate
+		dpp_base->deferred_reg_writes.bits.disable_blnd_lut = false;
+	}
+
+	if (dpp_base->deferred_reg_writes.bits.disable_3dlut) {
+		REG_GET(CM_3DLUT_MODE, CM_3DLUT_MODE_CURRENT, &bypass_state);
+		if (bypass_state == 0) {	// only program if bypass was latched
+			REG_UPDATE(CM_MEM_PWR_CTRL2, HDR3DLUT_MEM_PWR_FORCE, 3);
+		} else
+			ASSERT(0); // LUT select was updated again before vupdate
+		dpp_base->deferred_reg_writes.bits.disable_3dlut = false;
+	}
+
+	if (dpp_base->deferred_reg_writes.bits.disable_shaper) {
+		REG_GET(CM_SHAPER_CONTROL, CM_SHAPER_MODE_CURRENT, &bypass_state);
+		if (bypass_state == 0) {	// only program if bypass was latched
+			REG_UPDATE(CM_MEM_PWR_CTRL2, SHAPER_MEM_PWR_FORCE, 3);
+		} else
+			ASSERT(0); // LUT select was updated again before vupdate
+		dpp_base->deferred_reg_writes.bits.disable_shaper = false;
+	}
+}
+
 static void dpp3_power_on_blnd_lut(
 	struct dpp *dpp_base,
 	bool power_on)
@@ -495,9 +529,13 @@ static void dpp3_power_on_blnd_lut(
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
 	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
-		REG_UPDATE(CM_MEM_PWR_CTRL, BLNDGAM_MEM_PWR_FORCE, power_on ? 0 : 3);
-		if (power_on)
+		if (power_on) {
+			REG_UPDATE(CM_MEM_PWR_CTRL, BLNDGAM_MEM_PWR_FORCE, 0);
 			REG_WAIT(CM_MEM_PWR_STATUS, BLNDGAM_MEM_PWR_STATE, 0, 1, 5);
+		} else {
+			dpp_base->ctx->dc->optimized_required = true;
+			dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
+		}
 	} else {
 		REG_SET(CM_MEM_PWR_CTRL, 0,
 				BLNDGAM_MEM_PWR_FORCE, power_on == true ? 0 : 1);
@@ -511,9 +549,13 @@ static void dpp3_power_on_hdr3dlut(
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
 	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
-		REG_UPDATE(CM_MEM_PWR_CTRL2, HDR3DLUT_MEM_PWR_FORCE, power_on ? 0 : 3);
-		if (power_on)
+		if (power_on) {
+			REG_UPDATE(CM_MEM_PWR_CTRL2, HDR3DLUT_MEM_PWR_FORCE, 0);
 			REG_WAIT(CM_MEM_PWR_STATUS2, HDR3DLUT_MEM_PWR_STATE, 0, 1, 5);
+		} else {
+			dpp_base->ctx->dc->optimized_required = true;
+			dpp_base->deferred_reg_writes.bits.disable_3dlut = true;
+		}
 	}
 }
 
@@ -524,9 +566,13 @@ static void dpp3_power_on_shaper(
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
 	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
-		REG_UPDATE(CM_MEM_PWR_CTRL2, SHAPER_MEM_PWR_FORCE, power_on ? 0 : 3);
-		if (power_on)
+		if (power_on) {
+			REG_UPDATE(CM_MEM_PWR_CTRL2, SHAPER_MEM_PWR_FORCE, 0);
 			REG_WAIT(CM_MEM_PWR_STATUS2, SHAPER_MEM_PWR_STATE, 0, 1, 5);
+		} else {
+			dpp_base->ctx->dc->optimized_required = true;
+			dpp_base->deferred_reg_writes.bits.disable_shaper = true;
+		}
 	}
 }
 
@@ -1400,6 +1446,7 @@ static struct dpp_funcs dcn30_dpp_funcs = {
 	.dpp_program_blnd_lut = dpp3_program_blnd_lut,
 	.dpp_program_shaper_lut = dpp3_program_shaper,
 	.dpp_program_3dlut = dpp3_program_3dlut,
+	.dpp_deferred_update = dpp3_deferred_update,
 	.dpp_program_bias_and_scale	= NULL,
 	.dpp_cnv_set_alpha_keyer	= dpp2_cnv_set_alpha_keyer,
 	.set_cursor_attributes		= dpp3_set_cursor_attributes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 6f0c788d1904..613d34bde7dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1013,7 +1013,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.i2c = true,
 			.dmcu = false, // This is previously known to cause hang on S3 cycles if enabled
 			.dscl = true,
-			.cm = false, // visible flicker on OLED eDPs
+			.cm = true,
 			.mpc = true,
 			.optc = true,
 			.vpg = true,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 00fc81431b43..9f12792b7e59 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -29,6 +29,15 @@
 
 #include "transform.h"
 
+union defer_reg_writes {
+	struct {
+		bool disable_blnd_lut:1;
+		bool disable_3dlut:1;
+		bool disable_shaper:1;
+	} bits;
+	uint32_t raw;
+};
+
 struct dpp {
 	const struct dpp_funcs *funcs;
 	struct dc_context *ctx;
@@ -43,6 +52,7 @@ struct dpp {
 	struct pwl_params regamma_params;
 	struct pwl_params degamma_params;
 	struct dpp_cursor_attributes cur_attr;
+	union defer_reg_writes deferred_reg_writes;
 
 	struct pwl_params shaper_params;
 	bool cm_bypass_mode;
@@ -245,6 +255,8 @@ struct dpp_funcs {
 			bool dppclk_div,
 			bool enable);
 
+	void (*dpp_deferred_update)(
+			struct dpp *dpp);
 	bool (*dpp_program_blnd_lut)(
 			struct dpp *dpp,
 			const struct pwl_params *params);
-- 
2.25.1

