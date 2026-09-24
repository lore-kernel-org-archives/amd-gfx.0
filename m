Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39028C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C437E10F73F;
	Thu, 24 Sep 2026 18:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q1FS3Fx4";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC3310F72B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHH0N+yj/hQZWaNCoOB/vNEjVYN6FNHuUn61KYlxAGhtkXcIo3NB2RKS9LypfSyt+3bcXgXJjOoyjky75oeTWm31LuT/Yl9CDJP+Wu46HMLrApQPiHzamEbtlLf5I0Ds6vp8HV7/sOH5uAkDqJCPcFFmfq0mn1o8E/cqRIBwj/5wMkCvnIgMtXGB71uE2yxOFjgYRo9Px2PMSOCqRV2MeKiGilaD8celUgb4pgnodiHvrdpcWmIPZfkAOhgMTNM6o8+KzvDkibIc4f5UVkd5hvO9MxaXGQY/pK2HIt0Oo710DBiBPkBblFVy5Kd478zYwDVNyU212hkgkgU5dvKu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFkF8KWAmLjVzPfCCEShus9sUZjNiuE2izrdE6JzG7Y=;
 b=v1IjejbFOSbmwBx12YVH1luv1875tvAWhJkbC62yLIX5DTscf7qYeB2bBT4bza39jJujTdi5IWUhmIoIi78ZE2zIdFIOl0xdS/DYNP/9M2szWrpZwwHlgDai0Z96kNHSyJ7qNZgcyH/TibBkFShfpxDPKBDj1WPkT9l5z1mw1wkBZg7SU6bwRZOttC0NT90SBaTifT81p2Djkz3/qeJx2vNKoZ3TkB8FCYNW/qphIc39Uaqei3cDR9+gOHL1dEgbCPxlCXFsbbIrXK1P8QZUkwUAy3DGGR3nReGS2N3f5ngwABI9NuO2X1g03o6mw+Cxy255B1QN1P1rIDpsMVv82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFkF8KWAmLjVzPfCCEShus9sUZjNiuE2izrdE6JzG7Y=;
 b=q1FS3Fx4lsPbqoOWTwBCPF6R7IeXws+BjDox9EEspXZ8ovind3fDmLOtwjcqcc/CR/cK4zx9wAqvS22yCD1F89DajHXY+JaMKL3mAB0OYwwGWo24qo1bhn5LF+JL7bh/BBAUt0EeTglD9w6U4rp7BBJgvqTvOOtZykVqLjpj7kA=
Received: from PH8P221CA0053.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::18)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:39 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::38) by PH8P221CA0053.outlook.office365.com
 (2603:10b6:510:346::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:38 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:19 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 25/34] drm/amd/display: Fix VTG programming for dcn60
Date: Thu, 24 Sep 2026 14:45:38 -0400
Message-ID: <20260924184824.596894-26-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b82a27-80cd-4552-cb64-08df1a6c2a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|6133799003|56012099006|3023799007|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: H36kbbP1pwfXbqtr8tv/6y9cZFlRVH2I2crkIJ0tobkVwPnyh/s7tmbMRvgsGda1vT65KanIBYkfxPZ8Bvpwhh+Z4lj8j1oHXAvGVuVhWH9wWT0VFbqELV3HnQDCIPKTZ4hCSc0WrsqtPYv4Y2UqbZi7LMYDMy1UDsIpb2nmtP+v2Z3/9SmyuJyrrBlA+Mmo3glYIj7UFZ59d/BHzUoRoE6t8dqFYpAxSaKedMBkJZm6jjDz5eEcA8XQzdlv2pcnKXDoLn+5rrwh8IdOwLPaS8KtfiK50T7cUMkC01JQuihEeqmm4G1r2ZGEzHnhNxhivLMm9LpsgTR8nwQoGOkNX6SXmNJe/PwuQounskgObiSqwIZl1iA5x7KlK27N8hs41nFCh26cdoIBDGsC9hR5glua6AhZplyJfQTrVQeC5MvxCMuK+tdDgE6e+IfS5OVmO2/XsfocweiUBeXp9GRc++PGd7BQ+blRPYwjvlgsjgpqvsN7F32O+6OXgnbGGnnT0iXR/TaCBd4WwlZP7rn9YaiwqqG64UnaQLH+tD8Q6JUrBagacOEB1L1lo5LNjfszWqtAm4Z/07GwMtUMiUlZ3ak+QIKQ0q4LDERnbPuyFaIW4khuvQF8Ya1NaYv68juZzkto9bMREwEK210LjnnHAW+65kRReLbBD7Rb+k2iKoY+lLVmehFiDukvQQXU/RLwi8Dvc1NRzk+sd6YTO/tGsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(6133799003)(56012099006)(3023799007)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m2UBh8gWR+yrUnn4rFA8oimRSntqZPyxWbLwcuFtDm5u+HtYU4sF1iG9ZcfynLduo5i+GzqtsXb4zYugO8RdjwTN6BrM5AYDgYqVEBL0xtUG7FlC3RrMgrBBBLOJrNxgcJ7efZxujpQq9jYP2iEE3o7oxMO0+xIQRUp76tfpyvPiQL01sbe9TVN7cNYpzgkZ+R2DGnpYu++QWgHsDKOWr91We5tX9SHnTP4go0L9UcRfaoiNSbEa5h0ZTxVqW1v9DXIkHweyrlHnJiAJN3PLlncj/4XL4kadqQxchvrNX9ZUG2Mgasu+s5/6O4VCu9NICY2h5bZRoISoPQKT6fBLbYKtU5qvQlsmiR1hFuNFMfVN0TDz4LlkY7Qax6oWuSk8sOGDk5VEvnMIkTvsAsCegPV1GYgx4MY4oVECzHQyPe9cF+79riqQ3r47CUjuCKpz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:38.2026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b82a27-80cd-4552-cb64-08df1a6c2a97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
VTG params should be corrected based on HW expectation:
- FP2 = v_bp - vstartup_start (if vstartup is after vsync), else 0
- vcount_init = OTG SOF position from vsync (0) or vtotal
  depending on vstartup position

Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../amd/display/dc/optc/dcn60/dcn60_optc.c    | 83 ++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c
index bfeb3c8fc8f5..1257a540bc59 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c
@@ -23,6 +23,87 @@
 #define FN(reg_name, field_name) \
 	optc1->tg_shift->field_name, optc1->tg_mask->field_name
 
+/*
+ * apply_front_porch_workaround
+ *
+ * fixed keep Front porch at minimum 2 for Interlaced mode or 1 for progressive.
+ */
+static void apply_front_porch_workaround(
+	struct dc_crtc_timing *timing)
+{
+	if (timing->flags.INTERLACE == 1) {
+		if (timing->v_front_porch < 2)
+			timing->v_front_porch = 2;
+	} else {
+		if (timing->v_front_porch < 1)
+			timing->v_front_porch = 1;
+	}
+}
+
+/**
+ * optc60_set_vtg_params - Set Vertical Timing Generator (VTG) parameters
+ *
+ * @optc: timing_generator struct used to extract the optc parameters
+ * @dc_crtc_timing: Timing parameters configured
+ * @program_fp2: Boolean value indicating if FP2 will be programmed or not
+ *
+ * OTG is responsible for generating the global sync signals, including
+ * vertical timing information for each HUBP in the dcfclk domain. Each VTG is
+ * associated with one OTG that provides HUBP with vertical timing information
+ * (i.e., there is 1:1 correspondence between OTG and VTG). This function is
+ * responsible for setting the OTG parameters to the VTG during the pipe
+ * programming.
+ */
+static void optc60_set_vtg_params(struct timing_generator *optc,
+		const struct dc_crtc_timing *dc_crtc_timing, bool program_fp2)
+{
+	struct dc_crtc_timing patched_crtc_timing;
+	uint32_t v_bp;
+	uint32_t v_init;
+	uint32_t v_fp2;
+	bool vstartup_after_vsync;
+
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	patched_crtc_timing = *dc_crtc_timing;
+	apply_front_porch_workaround(&patched_crtc_timing);
+
+	/* v_bp (end of blank): lines from vsync (0) to end of blank */
+	v_bp = patched_crtc_timing.v_total - patched_crtc_timing.v_front_porch -
+			patched_crtc_timing.v_border_bottom -
+			patched_crtc_timing.v_addressable -
+			patched_crtc_timing.v_border_top;
+
+	vstartup_after_vsync = (uint32_t)optc1->vstartup_start < v_bp;
+
+	/* if vstartup is before vsync, fp2 is the offset, otherwise 0 */
+	v_fp2 = !vstartup_after_vsync ?
+			optc1->vstartup_start - v_bp :
+			0;
+
+	/* vcount_init should be OTG SOF (vstartup) position from vsync (0) or
+	 * vtotal depending on the position of vstartup.
+	 */
+	v_init = !vstartup_after_vsync ?
+			patched_crtc_timing.v_total - v_fp2 - 1 : // OTG SOF before VSYNC
+			patched_crtc_timing.v_total - 1; // OTG SOF is VSYNC
+
+	/* Interlace */
+	if (REG(OTG_INTERLACE_CONTROL)) {
+		if (patched_crtc_timing.flags.INTERLACE == 1) {
+			v_init = v_init / 2;
+			if ((uint32_t)((optc1->vstartup_start/2)*2) > v_bp)
+				v_fp2 = v_fp2 / 2;
+		}
+	}
+
+	if (program_fp2)
+		REG_UPDATE_2(CONTROL,
+				VTG0_FP2, v_fp2,
+				VTG0_VCOUNT_INIT, v_init);
+	else
+		REG_UPDATE(CONTROL, VTG0_VCOUNT_INIT, v_init);
+}
 static const struct timing_generator_funcs dcn60_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -78,7 +159,7 @@ static const struct timing_generator_funcs dcn60_tg_funcs = {
 		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = NULL,
-		.set_vtg_params = optc1_set_vtg_params,
+		.set_vtg_params = optc60_set_vtg_params,
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
-- 
2.53.0

