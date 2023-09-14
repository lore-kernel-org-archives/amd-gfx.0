Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993CDEE0203
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB4510E244;
	Thu, 14 Sep 2023 02:02:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5144E10E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j47txmAlGoH8iEPsLEWPd8KhAc+0+pw8VBgcsTUstRaaxJsTlc9PE9KvceaX5v+xo0J+4zhQffADa5EbKCL9A+n1QjpdcYEqDJHjyNILcodYqd814ajD/n7g+7S5+p4q+b8DU139e4v6+CLFfLsusJ3t1O6n0R1VpEUpuVq87MNmUWukFvqe1XlsulYf6Zo7Mz3AOQ1gZzkwad71GLGb8JsgtAk2SPBE2ISp+RXkWljWyvIXmo3zLeuEHXn16wl3nRa0+ifB5PH5/CrtgCTT61sT205Vcbn//1J0aU/El4UFdfZYQgOEGeKp3YKng7KcGbR/QnLn8gYjVDI7eH88fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJy6Vgzffr3rBbvbK9kOVAnwCfgZM0GPpa2ZAl/SqSE=;
 b=bCBQ2lem57Su/tn2mZ8VP9RFa95mxvJ1qnqVCEbaP/DVKjAd6QG8+j3yrrmaUCuwxHRs6ksHN92o/7rlcvBX4da94TNbAFknfPPKB1Dc6vdsYVoHE8rmoSo0sCvkLus13pSi6qgYJp6rWTsUUiVn5pLOSolUJa5QqdRlXs//iXMiKi+6qjDaVtyH4jPyOdSB8NMPnS4T59vV141uZA7rYxSgmx84U9RhLM20gyLOTFLRwkPaK3SNsNX4JCdqyiHwSS2qQ3j6xAfDlzT1GwZmDnj+fmFEjIDuzRzGb2FF4gaWSKqE2pFYQZuiPdwoScpF4owFaJyf48HtZ6QYdpLllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJy6Vgzffr3rBbvbK9kOVAnwCfgZM0GPpa2ZAl/SqSE=;
 b=Lz/qJ9lSjBhQemrHnGzbvzH4tx7Qt/aLoeP4SHhIN/3D4S1yhqQze5uand9Bl8R5OG3vBggowgvh9+R18fxfwdmbD1Ht4A1DUmarfZzeUX2qpZwDEmJpq0L20MSEjwasUIrAqPFQaKmHO3FQtZ3upoLxbA0F9ZwxpTjGsUfFARM=
Received: from PA7P264CA0161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::18)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.40; Thu, 14 Sep
 2023 02:02:00 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10a6:102:36c:cafe::3f) by PA7P264CA0161.outlook.office365.com
 (2603:10a6:102:36c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:59 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:55 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/28] drm/amd/display: Fix MST recognizes connected displays
 as one
Date: Wed, 13 Sep 2023 20:00:13 -0600
Message-ID: <20230914020021.2890026-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM6PR12MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2946c2-e075-4893-a852-08dbb4c69485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5FLf0hSaQYl0hgmQnfyvNF8gOr4s0SxekkYBITEkI8ZR+TZdqe0G0/4PxMh+xgB3lNIOCiJpPPxQR9/pXB0yI9T5v8mKG6qCOB86UHEyxNrNlv69kWIOiKciS3Sx7Mz0NdMDQGrGt38MsnQt9cQZYirqFNkOlsWIbCkgGn1rHkC5EAMlhj6qv5lBp58vLEEQd166yYxRJeZxnSP1pHlrVsTtqdWbtDc/TLSxNBaIRYhd+W2eYzRZSErdrOWhdjKzDUQ0u7CVxEayOXrW0DAFdWC6C4NZDN4mg8WjSoOHi2wf1GUrmGCfsqsdQAXVPzO8k6hqNrvcnwEjvzItYMgROn0ryxe8aR4uUce/391U9G3I4Tmh1vDHAbiYpnhQrBPGEsVOHayWuCgRDVO5pjKT1Y9bRKjPn31q3HXnfgPPW/uoCv1Me2kDONmZMh05Q8jihPtuzTrvTYomTLr1S9IlvBNsj9yEHWZj2OT5NQ16rWeGq/Su96nhddCPfk8Z8MtjN7++jSyTMxVeXo+hd2x7rT6SpxFg3U2uuI/5vPvCV8kYU8FdlbJicphr9GSTF2NofRpLnjjj+ACA00GHICtvjAbCXKIgocPLWjEROpdNa1KuUzrviSGqyc3XljgpggQI81U2jCcbeiNox7KNvtkUEMfkmlyKVQ3pHS4nWQO094LLr6/zDIQ5i8N37AtIHqCU5g0MLG3qQBOGDkquOXLdIoW5sD76DAHjQ6XykaIZnrv56loyJcn0A56790k5eixYT/O8beep5stGV2NZroYNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(47076005)(2906002)(36756003)(86362001)(82740400003)(81166007)(40480700001)(2616005)(16526019)(26005)(8936002)(8676002)(4326008)(1076003)(6666004)(41300700001)(54906003)(6916009)(356005)(70206006)(70586007)(316002)(83380400001)(336012)(426003)(478600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:59.0743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2946c2-e075-4893-a852-08dbb4c69485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[What]
MST now recognizes both connected displays

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 95 +++++++++++++++----
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  4 -
 2 files changed, 74 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 70a66df8315a..22137fde62bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -635,8 +635,55 @@ static void dccg35_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst,
 	}
 }
 
+/*get other front end connected to this backend*/
+static uint8_t dccg35_get_other_enabled_symclk_fe(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+{
+	uint8_t num_enabled_symclk_fe = 0;
+	uint32_t be_clk_en = 0, fe_clk_en[5] = {0}, be_clk_sel[5] = {0};
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (link_enc_inst) {
+	case 0:
+		REG_GET_3(SYMCLKA_CLOCK_ENABLE, SYMCLKA_CLOCK_ENABLE, &be_clk_en,
+				SYMCLKA_FE_EN, &fe_clk_en[0],
+				SYMCLKA_FE_SRC_SEL, &be_clk_sel[0]);
+				break;
+	case 1:
+		REG_GET_3(SYMCLKB_CLOCK_ENABLE, SYMCLKB_CLOCK_ENABLE, &be_clk_en,
+				SYMCLKB_FE_EN, &fe_clk_en[1],
+				SYMCLKB_FE_SRC_SEL, &be_clk_sel[1]);
+				break;
+	case 2:
+			REG_GET_3(SYMCLKC_CLOCK_ENABLE, SYMCLKC_CLOCK_ENABLE, &be_clk_en,
+				SYMCLKC_FE_EN, &fe_clk_en[2],
+				SYMCLKC_FE_SRC_SEL, &be_clk_sel[2]);
+				break;
+	case 3:
+			REG_GET_3(SYMCLKD_CLOCK_ENABLE, SYMCLKD_CLOCK_ENABLE, &be_clk_en,
+				SYMCLKD_FE_EN, &fe_clk_en[3],
+				SYMCLKD_FE_SRC_SEL, &be_clk_sel[3]);
+				break;
+	case 4:
+			REG_GET_3(SYMCLKE_CLOCK_ENABLE, SYMCLKE_CLOCK_ENABLE, &be_clk_en,
+				SYMCLKE_FE_EN, &fe_clk_en[4],
+				SYMCLKE_FE_SRC_SEL, &be_clk_sel[4]);
+				break;
+	}
+	if (be_clk_en) {
+	/* for DPMST, this backend could be used by multiple front end.
+	only disable the backend if this stream_enc_ins is the last active stream enc connected to this back_end*/
+		uint8_t i;
+		for (i = 0; i != link_enc_inst && i < sizeof(fe_clk_en); i++) {
+			if (fe_clk_en[i] && be_clk_sel[i] == link_enc_inst)
+				num_enabled_symclk_fe++;
+		}
+	}
+	return num_enabled_symclk_fe;
+}
+
 static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
 {
+	uint8_t num_enabled_symclk_fe = 0;
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	switch (stream_enc_inst) {
@@ -667,27 +714,33 @@ static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 		break;
 	}
 
-	switch (link_enc_inst) {
-	case 0:
-		REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
-				SYMCLKA_CLOCK_ENABLE, 0);
-		break;
-	case 1:
-		REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
-				SYMCLKB_CLOCK_ENABLE, 0);
-		break;
-	case 2:
-		REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
-				SYMCLKC_CLOCK_ENABLE, 0);
-		break;
-	case 3:
-		REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
-				SYMCLKD_CLOCK_ENABLE, 0);
-		break;
-	case 4:
-		REG_UPDATE(SYMCLKE_CLOCK_ENABLE,
-				SYMCLKE_CLOCK_ENABLE, 0);
-		break;
+	/*check other enabled symclk fe */
+	num_enabled_symclk_fe = dccg35_get_other_enabled_symclk_fe(dccg, stream_enc_inst, link_enc_inst);
+	/*only turn off backend clk if other front end attachecd to this backend are all off,
+	 for mst, only turn off the backend if this is the last front end*/
+	if (num_enabled_symclk_fe == 0) {
+		switch (link_enc_inst) {
+		case 0:
+			REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
+					SYMCLKA_CLOCK_ENABLE, 0);
+			break;
+		case 1:
+			REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
+					SYMCLKB_CLOCK_ENABLE, 0);
+			break;
+		case 2:
+			REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
+					SYMCLKC_CLOCK_ENABLE, 0);
+			break;
+		case 3:
+			REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
+					SYMCLKD_CLOCK_ENABLE, 0);
+			break;
+		case 4:
+			REG_UPDATE(SYMCLKE_CLOCK_ENABLE,
+					SYMCLKE_CLOCK_ENABLE, 0);
+			break;
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 7fa1172b98d0..4a0bca134581 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -751,14 +751,10 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_unbounded_requesting = false,
 	.disable_mem_low_power = true,
 	.enable_hpo_pg_support = false,
-
 	//must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions
 	.enable_double_buffered_dsc_pg_support = false,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
-	.disable_stutter = true,
-	.disable_idle_power_optimizations = true,
 	.disable_z10 = false,
-	.disable_mem_low_power = true,
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
 	.disable_ips = true,
-- 
2.40.1

