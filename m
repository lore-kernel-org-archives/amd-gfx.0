Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5237CC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BC810E33D;
	Mon,  7 Jul 2025 19:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Z/Frc9V";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0D210E33D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCfONYCkwWrTQuIkcNIlGoDH/zKuLtZfIjqg4QrG3mVvDYTZEySY3FkFHpdh2NSOdRtNdrPvf8GYLj9L8DohMO2X2tg7DLm9sxnVjaODUHN1iDg4gWGPcBhDkKoaY/fDy7QArxRu9rL8ZKXckhQprz81suv6eiUkH9RDFHAD2SboEOzeiW7wPEFlxMA2uhReYmnv1pg5LVM9QrnBqa3qdws5ihjRvhWITW7cBvG4b+Ene2/vNfbl9FFS7ZDYsNsp64Xdcer2P4fSwhozb+guqbPhZWLC6sqiAzwmrt60elunXMOPIv1y0zkknFOExJkzEeAoYTQKNuEsbDV4Cbw6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoUVZhaHBHKeQKLKq0k4WG6+Q6yptZRjhBC0brjfpQg=;
 b=IB4C7C9QHBnGqRp7gbV3YaMnDiSCXF93a5DxjL8FYRJ2iGLDpx+1fjsXmwvV3qxD9T2IWGBj07WKBVTsRRUUZ9mOg3wCjIGLmjHUsTorMl3sR1xHQxJZbiGLNnl4NvYWRIAh6AffCoSvxn8E3gIxnXdUEep7SDUeiza2wSJ6VElGSHp5v2h5AoDHFN6cN2PRSnWPgFyBPNiT2jzE/Bv+L0W2JgPIDG1SH2QCOsN3c7ZUPhkyw4NeBR/lt7fTP33KV+TQ2plG7jkYAaNtj9E0r9ZcKnzI1fUCiQEC+i4pZ16i8LGqhMYbOqNgtDygKFS9hysDE9KJ2z89T+6m7fx3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoUVZhaHBHKeQKLKq0k4WG6+Q6yptZRjhBC0brjfpQg=;
 b=3Z/Frc9VRO31GNhg+FAvBUbcdSOvel1VQ/8YncikPZN3eVRro7inOTzZnr6O7+6MNpLPpgplruG7Qo+SelU5dRJjoDW+Ucta+SVGJ+/hdgPjIwssHL4EsqOg4jpmVi5sXRf8Yp5oUBkcDbNKt+aiKLi3lBZCxUV0MSVbClx9H5U=
Received: from DS7PR03CA0129.namprd03.prod.outlook.com (2603:10b6:5:3b4::14)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:44:43 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::dc) by DS7PR03CA0129.outlook.office365.com
 (2603:10b6:5:3b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:44:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:44:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:44:41 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Jul 2025 14:44:41 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Yihan Zhu
 <Yihan.Zhu@amd.com>, Krunoslav Kovac <krunoslav.kovac@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 01/17] drm/amd/display: MPC basic allocation logic and TMZ
Date: Mon, 7 Jul 2025 15:41:21 -0400
Message-ID: <20250707194358.1185190-2-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
References: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3906aa-d4db-4ab2-7ed6-08ddbd8eb82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pcgsy2Zry/TibK6Cq7O1xgxGndjutJBhOUpsUp3QCDCAJLtOpLkgfZmfuOZE?=
 =?us-ascii?Q?7wgRcRm8T77/A0EOElXI9tD0nhs7KJHqtYdiUmCFNnnC+GDayQujAO5paB0p?=
 =?us-ascii?Q?lIFsjXIxXz3MAtZVzwKMFkuR4hlIs14YUeWGgCwTo2a/ST024fwnisnlAsPx?=
 =?us-ascii?Q?xv1zUtswRCaeT88WiYHkd6MUDN8KNv5EzrLZYnsJ1PLIPoqZHm/Ew12eesPc?=
 =?us-ascii?Q?RLI/zH0lStmLHvtVs7pXG3FVR8x2KMMsxPobK4YpO4njphGHm1yjPQR+1pwP?=
 =?us-ascii?Q?Qpb2FTYfxIi1A1shItLtaG+6nfY4Yo3NVFAmvmR55+sY/oK58J+kTCWu1xiT?=
 =?us-ascii?Q?MSj8WsD8VNWlxo9oo88+fDQ98oGqlgwC0czipV0ZkproMr4PlqxUjil17FWu?=
 =?us-ascii?Q?xWa/ZOLVB7sHBc/2lIfObpDOizAdtX2Er2KTvajTTFFZU1yJCE1QOCw6z8Y4?=
 =?us-ascii?Q?64XKlJlqYKfNJ+mNpWo6HC3OmjiY/GPOQJ0HQHx4IK4Ag6X362GqgIXETeM7?=
 =?us-ascii?Q?XuR1qQHJ9JT8fHK+u4leODetSJ20Bl2nuql/1N4sAd0LedSdJfeeXS1NTRuu?=
 =?us-ascii?Q?8+y4lCzkA1E7ED0uF0J1AlM2Wgxb8lHmGnOOZ5yJ1v7P/1UE5mxAAPUK34hs?=
 =?us-ascii?Q?QXF5B1tBWLOwOeGtzOI7rh4skEDLeMopEWLJWOdg70Ks0k/kd2WmzIjjaI1L?=
 =?us-ascii?Q?BsyXUAJ5aBSXdwO1Krcvxy3RTdRoRckCiYiL10kh7XoDB+twn/SdpcTeZHl6?=
 =?us-ascii?Q?xEZCxt6bnLF4KPsEb2xM8z7PnoCQwL3xxafwS67fDStEoZnY8F2AjQRdP1Nj?=
 =?us-ascii?Q?oN4xMDAYBC6iWpwn5RxKSh+A+dsQl7ymg+bWqXQQQXGDxbTA4DX3Gf921fSr?=
 =?us-ascii?Q?NSFuyMdHObE8OyDTyAXcoiNg1dWj3HMpmVFvuMLWbvyXpOUsNcnkPr17Uqqs?=
 =?us-ascii?Q?GLUaan2rfFJZNPeWoMWxMHCnDgKR+PcmJnyiIdLyftvIqZhdsAIZFKqaF37Z?=
 =?us-ascii?Q?i8U2hmXqZynr9ZV6olhVk8QDzu/XNYpzkP1wsqIaleEqtJ9b3U+AcEaogn5q?=
 =?us-ascii?Q?eEJH6V+HZghjSaWhlyZgURywWlSeDxi9mAyv/H2e/EYEUBf2Ra9gb4ebofQ9?=
 =?us-ascii?Q?uLjQCIdBQj1YnIAsj2p+xUr89QsJ6jWDZH+Tw1+m1Dk4DosoyiMO1Ain2xpV?=
 =?us-ascii?Q?KLaqkf+litn90GoDKHy2tWUzZCD/fIyRQDatmihOvKrmV0W2vfmsClKzFh0g?=
 =?us-ascii?Q?FldVC/X/tMxICz2uqhL4vHDPoFOQSLJ6ejclZyUstYwl12V3KfzGcp60Qvu1?=
 =?us-ascii?Q?b8q+qXExFKeHM1N9gszyO6q8KrOdV5/i8GV7avIwg6P7xGfKr1YkmeNeHTby?=
 =?us-ascii?Q?YtIzVapmA02Z+mE9jmpHsaEzKCrbSrnDXgwcuRYHdqMtecJ36U1n3AQ2L0ug?=
 =?us-ascii?Q?b1Jhf4BEFSoOGX967hyDxFMCEqcrMCt7bsRJLE/O7ivEYssWTx+197wDkc4Z?=
 =?us-ascii?Q?pdB0SYs6NQquh14BC4r2DZy8T5TK63XZzXMB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:44:42.8462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3906aa-d4db-4ab2-7ed6-08ddbd8eb82b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
Adding basic logic to allocate unused RMCM block and TMZ support.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  2 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 67 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  7 ++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    | 11 +++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  2 +-
 11 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c744aa9d830f..f37ed24b2430 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -976,6 +976,8 @@ static bool dc_construct_ctx(struct dc *dc,
 	if (!dc_ctx)
 		return false;
 
+	dc_stream_init_rmcm_3dlut(dc);
+
 	dc_ctx->cgs_device = init_params->cgs_device;
 	dc_ctx->driver_context = init_params->driver;
 	dc_ctx->dc = dc;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 47712a4aec55..883054bb18e7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -427,6 +427,8 @@ enum dc_status dc_state_remove_stream(
 		return DC_ERROR_UNEXPECTED;
 	}
 
+	dc_stream_release_3dlut_for_stream(dc, stream);
+
 	dc_stream_release(state->streams[i]);
 	state->stream_count--;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index b883fb24fa12..4d6bc9fd4faa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -856,6 +856,73 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 	}
 }
 
+/*
+*	dc_stream_get_3dlut()
+*	Requirements:
+*	1. Is stream already owns an RMCM instance, return it.
+*	2. If it doesn't and we don't need to allocate, return NULL.
+*	3. If there's a free RMCM instance, assign to stream and return it.
+*	4. If no free RMCM instances, return NULL.
+*/
+
+struct dc_rmcm_3dlut *dc_stream_get_3dlut_for_stream(
+	const struct dc *dc,
+	const struct dc_stream_state *stream,
+	bool allocate_one)
+{
+	unsigned int num_rmcm = dc->caps.color.mpc.num_rmcm_3dluts;
+
+	// see if one is allocated for this stream
+	for (int i = 0; i < num_rmcm; i++) {
+		if (dc->res_pool->rmcm_3dlut[i].isInUse &&
+			dc->res_pool->rmcm_3dlut[i].stream == stream)
+			return &dc->res_pool->rmcm_3dlut[i];
+	}
+
+	//case: not found one, and dont need to allocate
+	if (!allocate_one)
+		return NULL;
+
+	//see if there is an unused 3dlut, allocate
+	for (int i = 0; i < num_rmcm; i++) {
+		if (!dc->res_pool->rmcm_3dlut[i].isInUse) {
+			dc->res_pool->rmcm_3dlut[i].isInUse = true;
+			dc->res_pool->rmcm_3dlut[i].stream = stream;
+			return &dc->res_pool->rmcm_3dlut[i];
+		}
+	}
+
+	//dont have a 3dlut
+	return NULL;
+}
+
+
+void dc_stream_release_3dlut_for_stream(
+	const struct dc *dc,
+	const struct dc_stream_state *stream)
+{
+	struct dc_rmcm_3dlut *rmcm_3dlut =
+		dc_stream_get_3dlut_for_stream(dc, stream, false);
+
+	if (rmcm_3dlut) {
+		rmcm_3dlut->isInUse = false;
+		rmcm_3dlut->stream  = NULL;
+		rmcm_3dlut->protection_bits = 0;
+	}
+}
+
+
+void dc_stream_init_rmcm_3dlut(struct dc *dc)
+{
+	unsigned int num_rmcm = dc->caps.color.mpc.num_rmcm_3dluts;
+
+	for (int i = 0; i < num_rmcm; i++) {
+		dc->res_pool->rmcm_3dlut[i].isInUse = false;
+		dc->res_pool->rmcm_3dlut[i].stream = NULL;
+		dc->res_pool->rmcm_3dlut[i].protection_bits = 0;
+	}
+}
+
 /*
  * Finds the greatest index in refresh_rate_hz that contains a value <= refresh
  */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ce1957c7862f..6825b8a9af59 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -246,6 +246,7 @@ struct mpc_color_caps {
 	uint16_t ogam_ram : 1;
 	uint16_t ocsc : 1;
 	uint16_t num_3dluts : 3;
+	uint16_t num_rmcm_3dluts : 3;
 	uint16_t shared_3d_lut:1;
 	struct rom_curve_caps ogam_rom_caps;
 	struct lut3d_caps mcm_3d_lut_caps;
@@ -1294,6 +1295,12 @@ union dc_3dlut_state {
 };
 
 
+struct dc_rmcm_3dlut {
+	bool isInUse;
+	const struct dc_stream_state *stream;
+	uint8_t protection_bits;
+};
+
 struct dc_3dlut {
 	struct kref refcount;
 	struct tetrahedral_params lut_3d;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 341d2ffb64b1..5fc6fea211de 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -579,6 +579,17 @@ bool dc_stream_set_gamut_remap(struct dc *dc,
 bool dc_stream_program_csc_matrix(struct dc *dc,
 				  struct dc_stream_state *stream);
 
+struct dc_rmcm_3dlut *dc_stream_get_3dlut_for_stream(
+	const struct dc *dc,
+	const struct dc_stream_state *stream,
+	bool allocate_one);
+
+void dc_stream_release_3dlut_for_stream(
+	const struct dc *dc,
+	const struct dc_stream_state *stream);
+
+void dc_stream_init_rmcm_3dlut(struct dc *dc);
+
 struct pipe_ctx *dc_stream_get_pipe_ctx(struct dc_stream_state *stream);
 
 void dc_dmub_update_dirty_rect(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index b203ed020cd5..a0829bc0708a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1313,6 +1313,7 @@ struct dc_cm2_func_luts {
 		bool mpc_3dlut_enable;
 		bool rmcm_3dlut_enable;
 		bool mpc_mcm_post_blend;
+		uint8_t rmcm_tmz;
 	} lut3d_data;
 	const struct dc_transfer_func *lut1d_func;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index baed31611477..705b98b1b6cc 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -86,11 +86,11 @@ void hubp401_program_3dlut_fl_width(struct hubp *hubp, enum hubp_3dlut_fl_width
 	REG_UPDATE(HUBP_3DLUT_CONTROL, HUBP_3DLUT_WIDTH, width);
 }
 
-void hubp401_program_3dlut_fl_tmz_protected(struct hubp *hubp, bool protection_enabled)
+void hubp401_program_3dlut_fl_tmz_protected(struct hubp *hubp, uint8_t protection_bits)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
-	REG_UPDATE(HUBP_3DLUT_CONTROL, HUBP_3DLUT_TMZ, protection_enabled ? 1 : 0);
+	REG_UPDATE(HUBP_3DLUT_CONTROL, HUBP_3DLUT_TMZ, protection_bits);
 }
 
 void hubp401_program_3dlut_fl_crossbar(struct hubp *hubp,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index 6e1d4c90ddd4..608e6153fa68 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -333,7 +333,7 @@ void hubp401_program_3dlut_fl_crossbar(struct hubp *hubp,
 	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
 	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r);
 
-void hubp401_program_3dlut_fl_tmz_protected(struct hubp *hubp, bool protection_enabled);
+void hubp401_program_3dlut_fl_tmz_protected(struct hubp *hubp, uint8_t protection_bits);
 
 void hubp401_program_3dlut_fl_width(struct hubp *hubp, enum hubp_3dlut_fl_width width);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 9ad29be925e2..39910f73ecd0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -335,7 +335,7 @@ static void dcn10_log_hubp_states(struct dc *dc, void *log_ctx)
 		struct dcn_fl_regs_st *fl_regs = &s->fl_regs;
 
 		if (!s->blank_en) {
-			DTN_INFO("[%2d]:  %5xh  %6xh  %5d  %6d  %2xh  %2xh  %6xh  %6d  %8d  %8d  %7d  %8xh %5x %5x %5x",
+			DTN_INFO("[%2d]:  %5xh  %6xh  %5d  %6d  %8xh  %2xh  %6xh  %6d  %8d  %8d  %7d  %8xh %5x %5x %5x",
 					pool->hubps[i]->inst,
 					fl_regs->lut_enable,
 					fl_regs->lut_done,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index c9454fe1cd05..f0d7185153b2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -67,6 +67,8 @@ struct resource_context;
 struct clk_bw_params;
 struct dc_mcache_params;
 
+#define MAX_RMCM_INST  2
+
 struct resource_funcs {
 	enum engine_id (*get_preferred_eng_id_dpia)(unsigned int dpia_index);
 	void (*destroy)(struct resource_pool **pool);
@@ -286,6 +288,7 @@ struct resource_pool {
 	struct hpo_dp_link_encoder *hpo_dp_link_enc[MAX_HPO_DP2_LINK_ENCODERS];
 	struct dc_3dlut *mpc_lut[MAX_PIPES];
 	struct dc_transfer_func *mpc_shaper[MAX_PIPES];
+	struct dc_rmcm_3dlut rmcm_3dlut[MAX_RMCM_INST];
 
 	struct {
 		unsigned int xtalin_clock_inKhz;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index b610beb075d5..cee29e89ec5c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -282,7 +282,7 @@ struct hubp_funcs {
 	void (*hubp_enable_3dlut_fl)(struct hubp *hubp, bool enable);
 	void (*hubp_program_3dlut_fl_addressing_mode)(struct hubp *hubp, enum hubp_3dlut_fl_addressing_mode addr_mode);
 	void (*hubp_program_3dlut_fl_width)(struct hubp *hubp, enum hubp_3dlut_fl_width width);
-	void (*hubp_program_3dlut_fl_tmz_protected)(struct hubp *hubp, bool protection_enabled);
+	void (*hubp_program_3dlut_fl_tmz_protected)(struct hubp *hubp, uint8_t protection_bits);
 	void (*hubp_program_3dlut_fl_crossbar)(struct hubp *hubp,
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_y_g,
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
-- 
2.43.0

