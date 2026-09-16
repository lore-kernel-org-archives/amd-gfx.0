Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946D5C982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4B010ECC3;
	Wed, 16 Sep 2026 17:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P/wSxsH2";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AF710ECC4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8LLe9PEACS3PM2mlNQJxBMEGExpVs26qVmlctGxBMXZkdw45Tn09BxZCcj3vKAKxTP9nXpSYdWYsYYdBEB+k7B4HOvfNEBK/vMpH5gmBJO6AThitK0Dquzj6lgwQSHc/2Dgo3ync2rZIg/x9jerCjXqpBKCiRNF+abar9Z9eRx9Hg5IPlU6WegsWDKVwY9wcsMTMcoIDrMEFCcCPfFd295A08Dp03Qj4jqP5VrGgh2mRBJo6pF2JU50kyN9tNoe9NBbmLewwdNl2siKDiiwORaABKJNkrrpBfLbfJ4JzGTH7ultLosH8aPbJ4g5d7hjwXAD53EKDMk/CacczuiuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eryg7GxLr0ez/q5XLMh3gYO+IbCTkzVPF2cpnzmZCvI=;
 b=OyrRaY+nPQvCzfP6l4YhLehWWW88NFJm64Wqy5VZasYO13Xfj76cF4oMtAVYCo7rGSgb2CWiTybT4bG9clKM+lpQjO2KdftVmDrnnHTKJJrTBiFa2mJAtjykl0wwW9QzgECl5uz9OlNbF0Umzv9JG1n5nEBA61xQbZdWoZ1zRKCBh3YC6P0AQFXm1dHO+cb1u2Qeh/fnh9IEvRT1Ko74aeiBbmBTBn8Kh2U2SZXDxne6jkeH00m7gAIfPjfuwhDXWHCt7yNd+6pPUa8eL0qwOTO6E4hf5w6Ib5nc5LLBkI+cWRekJ4ssaFNehGGUoYf5Ia9LA1K1JiwCfZLJlz6wdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eryg7GxLr0ez/q5XLMh3gYO+IbCTkzVPF2cpnzmZCvI=;
 b=P/wSxsH2pp04OKBLiVhMWPumtEmGFS4rjClJ+V31/Ah6+rJAgM4S6stNSMl7ubG4j+I/+xMUjo+4tH3+F/hhW8+pL7pt15yPIAWXvyufTAcfrUia6W9ypmzbGj4ost8UUJH8j+AQheMvJJjV1ddj9pvIWFOuQ54y5TkTp0TePuw=
Received: from CH0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:610:e4::33)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:56 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::4) by CH0PR03CA0208.outlook.office365.com
 (2603:10b6:610:e4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:56 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:43 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 39/64] drm/amd/display: Add inst field to clock_source and dio
Date: Wed, 16 Sep 2026 13:51:54 -0400
Message-ID: <20260916175301.368306-40-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b280a64-ffc6-431b-8504-08df141b56e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: J4vcwd5Iut/+1DEtXpE9A14p5ln6NCbZPw6Biv6GWwGvek8cUwc3shbGqWlanraw7b0WQgJAMFFz+z02HvkNn/aURtens8JT6bt02tttB45DNxqRxEh91Vi7bBsI+UZnli9sVVNsxI8XgReLwAUlygiEa/OwTsHGdlrSx2eUxUmO9MNHHU2U23lqM1zXIE2AZsOHd/c6Tgy3qT4FuGxfuq6uXNdw4TELljx0B+g8ktDO6UOmy/xICZHgp1l+uh9GJsiGD7i9dcoNFkiBCjYDsPpf14PBhNLHqiuyUWEmW9WzDhlZDyqLaYfwuDDLYV8UNCr2I7OZFG6Me4dWptyyG4kN2Ojw+w5gZ+eKs048WxVv1YRyK3u68o4j/vN2zdL52+yXQeib3EQDdFpPABZOMbLcH4BSfk8BfN/EaRgZkSh2u2Yg0c2GM47vKf1e+6QSGLECvgqNqeL8gX2SlkH+6sxoflooBzF1hw8+PciYbxBrChNBX2fMe0ouZfZaP4U4POGAwVQvVhtfh9oZvpOMy7I8uc4C0mpkPQaHlZBlYIBlB6zX0uRmw4Rd2N7zv1+Q/iwOaX2pkw3IOLiMypOuwpad9du2VpMZ/83E96HRUf2ShpYs25xhkem16zRCjKG2m1wrxul0yQnpG6otdOFZofjn9dTj+45RcDXWrzSs1q9z3hdo0jb9u3Lda+QM3MmlrTAw50Wi9cJroEVMnlu86Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LzFuhX3z3Cgx3vlGzlRJeqs5p9ukObl2/CW0Ix2caCi/TYDOczPocdIz6zhVYq80zDxInPbWKEHICiqCetgBOb4f+kUkz54Qmz+aN/fvdr1y2+drvSLmJ0fM2xiqxj9Zgvc3WEBUl4N7o994rtrigFr/JAGDMd/390Z1UVZJpB1Qsv1abbPoZhA//oQ8TDBxD8/mm3N67KSt/E2YtA+sC19gst44O7pXz6WftU+xxeXRuoKQOPQo5l++VdsinfzhWvjKCAkWK+0BdBmGekwlfKVYOcEfpj5vhe79Vv3o3jmYepPa7Ae0Jgpry88qMUa21bcCXqFEhkTH93kzMP/JHLRqPn0XBX+S1rTWSW+UP3aR8vaG/9KJmBZc2RMuVJD2fNrxhi5ICCEWr9bi53g/6gJeNNTmQm5VyfxpPivUFp+i6fidWOMtqe2oV9emGdQt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:56.3904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b280a64-ffc6-431b-8504-08df141b56e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
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

From: Tony Cheng <Tony.Cheng@amd.com>

Add an inst member to struct clock_source and struct dio. The DCE110
and DCE112 clock sources derive it from their clock_source_id; the
DCN10 DIO is a singleton and uses 0.

Also move the (void)encoding cast in dcn401_program_pix_clk() below the
local declarations, where it belongs.

No functional change; the inst field has no readers yet.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c  | 1 +
 drivers/gpu/drm/amd/display/dc/inc/clock_source.h     | 1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dio.h           | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 54ef1808ca35..145c993342bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1074,7 +1074,6 @@ static bool dcn401_program_pix_clk(
 		enum dp_link_encoding encoding,
 		struct pll_settings *pll_settings)
 {
-	(void)encoding;
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
 	const struct pixel_rate_range_table_entry *e =
@@ -1082,6 +1081,7 @@ static bool dcn401_program_pix_clk(
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 	enum transmitter_color_depth bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
 	struct dp_dto_params dto_params = { 0 };
+	(void)encoding;
 
 	dto_params.otg_inst = inst;
 	dto_params.signal = pix_clk_params->signal_type;
@@ -1757,6 +1757,7 @@ bool dce110_clk_src_construct(
 	clk_src->base.ctx = ctx;
 	clk_src->bios = bios;
 	clk_src->base.id = id;
+	clk_src->base.inst = (unsigned int)id;
 	clk_src->base.funcs = &dce110_clk_src_funcs;
 
 	clk_src->regs = regs;
@@ -1855,6 +1856,7 @@ bool dce112_clk_src_construct(
 	clk_src->base.ctx = ctx;
 	clk_src->bios = bios;
 	clk_src->base.id = id;
+	clk_src->base.inst = (unsigned int)id;
 	clk_src->base.funcs = &dce112_clk_src_funcs;
 
 	clk_src->regs = regs;
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c
index edcf4e67483b..458ce1053c96 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c
@@ -40,6 +40,7 @@ void dcn10_dio_construct(
 {
 	dio10->base.ctx = ctx;
 	dio10->base.funcs = &dcn10_dio_funcs;
+	dio10->base.inst = 0;
 
 	dio10->regs = regs;
 	dio10->shifts = shifts;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
index dad429298d77..caa8dd8737bb 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
@@ -186,6 +186,7 @@ struct clock_source {
 	const struct clock_source_funcs *funcs;
 	struct dc_context *ctx;
 	enum clock_source_id id;
+	unsigned int inst;
 	bool dp_clk_src;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dio.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dio.h
index 532bf54cf2c4..916ac15b6b58 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dio.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dio.h
@@ -17,6 +17,7 @@ struct dio_funcs {
 struct dio {
 	const struct dio_funcs *funcs;
 	struct dc_context *ctx;
+	unsigned int inst;
 };
 
 #endif /* __DC_DIO_H__ */
-- 
2.55.0

