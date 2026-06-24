Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A084ACDE009
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8F810F08E;
	Wed, 24 Jun 2026 18:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="osT0JNtv";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013026.outbound.protection.outlook.com
 [40.93.196.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B4E10F086
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjb51eC1Iy07dFczMbRV1o5Ga0bFjojA8g6ToPR/P74GJRtEyswCljLubqAMB9FpYVKAkHGKhavA1YqX53cL9Kxi/Kf0O+eBUJW7wFOORkRdGDR0llt7lDNAfgnBvHzViEezC9nuTSf2sTH6k9bxVjbGPLk2HcGi07+OKCNrZQdIQ8n3/VACOJY6rXaKZooh7/qdmQVZ7MgjGXT1hCkBupG4PHqDwFolC12cyWtBYjNgt7/Oq3p3saC9Qv7AFt7CS4MaAM25gxiRaO7T8n7EpkXiV1AWVJmlKZHp6L+QRN3GAW8tbZEVrbd46SBXyPE5cDJMrxh04kEGnbxWUjjE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXMG4p0Qa8p60V6seOUhNNWMu6UL+y8SFNpNHQKwahY=;
 b=DhHjLalocdWobzbNgZapvQFVs13vYOrFgTxQeeYL/6lfQywTusKicat0Hc3F3jee1fjkVmN7EdO67hXGV3LEUlgVp1793PNUgYJddZ6P+nwucBHocA3qcwB7evlfI7rbCQAWo/vpY9mhfej0MX44NEzVi41HEbJDFZx3poJRGm2vcFs95aQ1/W9Q4DwVi9dskrvA+NlakRphUzVuA60W7tuJeHDcqPjg9BwENSvJdzlgeo06zmq1WkLfUhIFRf43CdQZR55HNU3MmxhJk+sy6ABTKSI0oNiTkqkhWOjIDSllfF7zZycblRC0Zr5YvfcgF2nsNwq1RX6ujhfpHL3GLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXMG4p0Qa8p60V6seOUhNNWMu6UL+y8SFNpNHQKwahY=;
 b=osT0JNtvUT3Cz5mWxyjuYz5zeVFiRLaWRTpzN7TIdUfYr+PBZ9ol7uukR2TKhJIEDMhN5O6oVucwiV8fkDGaPrtKbAVLrxb21IyLxL1KHjKbimY208A359qmLCrrpc9QuZgkf9sqAegbfC1lp2+3ST+xXWv/aLcv/9BdkDpKC7U=
Received: from SJ0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:33a::11)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:09:20 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::8a) by SJ0PR03CA0006.outlook.office365.com
 (2603:10b6:a03:33a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Wed,
 24 Jun 2026 18:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:20 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:17 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Cruise Hung
 <cruise.hung@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 10/28] drm/amd/display: correct encoder minimal creation
Date: Wed, 24 Jun 2026 14:03:08 -0400
Message-ID: <20260624180829.4775-11-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b93903-a93c-46f9-d7df-08ded21bb6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|3023799007|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: op2DpdfStCO68OzoEiTclDBH2wbkh0O80lx6C6ed5yT4o4TSo2/zbFF3kFuvoHVBsA7X8pLrJO7Jx4P8TNIeBetFnz/tyQdv8ZQRS9C/Vudpqro39F8GBFqjESu7eGwxlc6G7nhS9pYiZN7UMDrWnK/VjbvHwnzDHqpZqU7auDOb0hryXjh5wbP5tjvhlgRqESf7DCqPrdfJ8TTiJYBwfGS3qPDLk0bmTVFOUVUAj5ZovA1x6ZECAG0rDmWA8hUqanFHBQkBT/nKd+t/vt27lcZrckdA0d3S1EhoKk+QcB9CeruJbokmDsRJPbjSoyrYtqgQNAkTXV/nlRpVbugxlRHFlaA2tLan0HQMpx7jxNEid8nAuMT2mzlFfcurlpr55PZxlT5S4HT4lfm5CiMZa9fEMWE4CPEYcgXs6Eb+0HTUDPlbCwPmOFmwCRNzgzlkxPcLdWpxAkarGPcCgequP8suNNZkK9Ds2g+SKFcvjKHXB46jREfJ5ia7daUuwAuU23Rp5vrctgQv+UBmd5yvS+/JJLu7p5xsmzkRqJ86b7Uou1z8M+47OLIn2I6GzILi98RqZ+En/woMya3Ob1q2PRG1jCFtu3idqQQjx1qhBNbtz/0Ag4LJLQuEiuR7dyChdB/xf45jorTEh/tPHoqQefjhwkEDAH/zd8mtk1cAIqKF/QFDxY+Wy1HRFGCjO5tUVSDFZSFQCiBSdmF3uRHbyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(3023799007)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xxQrdw2TNW0etpJA07h6Xk89ii9/gkJmj8VpI5sE3fNtAeNT6I8y09yjlPwAyoK+sgCDbDkYBJknH26pSjiy02k6b1mxpH7FxcPcTYzKdH1wCs8kDzjU9VWvCAhYosiJpN0YL6m2XQeQdf5lznYjRrRbmhwO3JQ4OyD3mb9nS/5a5FNagXSlLc/yoA1EAbruKwFGLRhh+2plyZrZEhaRm6Nzwmu0+9JbkFcGdHdOoP+tBSWZx5MQivbi291ADH1IQslRGPccKzHGw7HOxnrBCa/Pm+LQ41o4p/8o3D2cQPxYbw0bd7MyDF8fqpqLlARDWssmyh6glz717aEVY1Wny0pgMH/4tq6+UqrszM++2+OPGz1QXhad5f667H7U/zX+CpYn9ItjH1spxESfxGM+xGv7I1guhxx82q6w4dbsg920GkAgSTiITqDeN3lbrCwG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:20.2668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b93903-a93c-46f9-d7df-08ded21bb6ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
shift and mask are not correctly initilized in create_minimal functions.

[HOW]
Correct initialize necessary variables.

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c | 4 ++++
 .../gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h | 2 ++
 .../gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c    | 4 +++-
 .../gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c  | 4 +++-
 .../gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c  | 4 +++-
 .../gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c  | 4 +++-
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 4 +++-
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 4 +++-
 .../gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c    | 4 +++-
 .../gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c    | 4 +++-
 .../gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c  | 4 +++-
 11 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
index bcb791d74189..f57f3ba68a02 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
@@ -516,6 +516,8 @@ void dcn31_link_encoder_construct_minimal(
 	struct dc_context *ctx,
 	const struct encoder_feature_support *enc_features,
 	const struct dcn10_link_enc_registers *link_regs,
+	const struct dcn10_link_enc_shift *link_shift,
+	const struct dcn10_link_enc_mask *link_mask,
 	enum engine_id eng_id)
 {
 	struct dcn10_link_encoder *enc10 = &enc20->enc10;
@@ -529,6 +531,8 @@ void dcn31_link_encoder_construct_minimal(
 	enc10->base.features = *enc_features;
 	enc10->base.transmitter = TRANSMITTER_UNKNOWN;
 	enc10->link_regs = link_regs;
+	enc10->link_shift = link_shift;
+	enc10->link_mask = link_mask;
 
 	enc10->base.output_signals =
 		SIGNAL_TYPE_DISPLAY_PORT |
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h
index 3cf587527991..88ab9684e207 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.h
@@ -246,6 +246,8 @@ void dcn31_link_encoder_construct_minimal(
 	struct dc_context *ctx,
 	const struct encoder_feature_support *enc_features,
 	const struct dcn10_link_enc_registers *link_regs,
+	const struct dcn10_link_enc_shift *link_shift,
+	const struct dcn10_link_enc_mask *link_mask,
 	enum engine_id eng_id);
 
 void dcn31_link_encoder_set_dio_phy_mux(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 97c2cd7045b5..e6d7da830440 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1191,7 +1191,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) >= ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1203,6 +1203,8 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 			ctx,
 			&link_enc_feature,
 			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+			&le_shift,
+			&le_mask,
 			eng_id);
 
 	return &enc20->enc10.base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index fbfedfca211f..ef2038efbfc2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1248,7 +1248,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) >= ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1260,6 +1260,8 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 			ctx,
 			&link_enc_feature,
 			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+			&le_shift,
+			&le_mask,
 			eng_id);
 
 	return &enc20->enc10.base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 4e283e4c238c..dbf9cb934c76 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1190,7 +1190,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) >= ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1202,6 +1202,8 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 			ctx,
 			&link_enc_feature,
 			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+			&le_shift,
+			&le_mask,
 			eng_id);
 
 	return &enc20->enc10.base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 0c8b37520ec3..3a776959767c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1183,7 +1183,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) >= ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1195,6 +1195,8 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 			ctx,
 			&link_enc_feature,
 			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+			&le_shift,
+			&le_mask,
 			eng_id);
 
 	return &enc20->enc10.base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index c94136bf2dcf..800a030990bd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1189,7 +1189,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) >= ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1201,6 +1201,8 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 			ctx,
 			&link_enc_feature,
 			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+			&le_shift,
+			&le_mask,
 			eng_id);
 
 	return &enc20->enc10.base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 42c8c01efb0b..8e276c333dbe 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1169,7 +1169,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) >= ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1181,6 +1181,8 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 			ctx,
 			&link_enc_feature,
 			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+			&le_shift,
+			&le_mask,
 			eng_id);
 
 	return &enc20->enc10.base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index b7afba548fd4..e2368a5c1eed 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1176,7 +1176,7 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if (((unsigned int)eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if (((unsigned int)eng_id - ENGINE_ID_DIGA) >= ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1188,6 +1188,8 @@ static struct link_encoder *dcn31_link_enc_create_minimal(
 			ctx,
 			&link_enc_feature,
 			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+			&le_shift,
+			&le_mask,
 			eng_id);
 
 	return &enc20->enc10.base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 44728894dceb..c999db12d0a5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1882,7 +1882,7 @@ static struct link_encoder *dcn42_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if ((unsigned int)(eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if ((unsigned int)(eng_id - ENGINE_ID_DIGA) >= ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1894,6 +1894,8 @@ static struct link_encoder *dcn42_link_enc_create_minimal(
 			ctx,
 			&link_enc_feature,
 			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+			&le_shift,
+			&le_mask,
 			eng_id);
 
 	return &enc20->enc10.base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 669bd5eb4c8f..60cbaf4f6fdf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -1824,7 +1824,7 @@ static struct link_encoder *dcn42b_link_enc_create_minimal(
 {
 	struct dcn20_link_encoder *enc20;
 
-	if ((unsigned int)(eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+	if ((unsigned int)(eng_id - ENGINE_ID_DIGA) >= ctx->dc->res_pool->res_cap->num_dig_link_enc)
 		return NULL;
 
 	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
@@ -1836,6 +1836,8 @@ static struct link_encoder *dcn42b_link_enc_create_minimal(
 			ctx,
 			&link_enc_feature,
 			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+			&le_shift,
+			&le_mask,
 			eng_id);
 
 	return &enc20->enc10.base;
-- 
2.53.0

