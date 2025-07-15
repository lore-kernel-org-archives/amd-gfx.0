Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF7DC83F1D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B79D10E524;
	Tue, 15 Jul 2025 06:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fx5cDtNt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9DE10E524
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVsM2gf75HQtUwY4gyNj3eankBcAt7SQ1kK5PeuVuRNdXmwgETRcd1znTOO2MLejX5DBL4BxV0BNjnfRaQtn3OK+G23HV4rJnHQLT5Uyhg5ohf+awRHJ4oJ3ve7FoGSJNwLqIdu85LBfmbJ8MlN3A2jDag97VwOvocF9/DVV1Dgds2zSs6WRb30m9Hk3OLRei3j8lYBAmCSfj5uD3qXgGZCsrEqz+4bJQiVrtDLyV3khSCnwbi6F99GgN2eD1hdOVgz6qj5JQgWGVGC1M4wVT33u2SPNLx/D3DzehM9CG+G3jcbpxHm74nZJPzD66nz+pfUmZkYSc+16d1Z/vLiw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2WfBLWK9iA2DfXsL4k63ez0Z/Iar6/tpLZq/9Tmg1k=;
 b=EaYfZSsUNW56FOYLWUwsGCwqVy1qE9GkUDsAX56OtjOREykrGAviR0QI2FiCATYhujZVQGDKU6jcxDhNkvnfUQ5BLc1QP6pyc61I+pSB81SWkGp3EXd0Y8ewlTHgjswezadSzskKyLMSJTMj/lfEploisBwaikZxZ+L82jBl6ZkqIYRE+k9IgeYtwLUkZgkI9T9Bt1DIa+dntRX54HbhJDEXUEvpjxJNufpzxsoxOwf6wdbKASb3jFlS6xYJhG3sSYLWQ4fY7ANva36NkVU16QPXUEO+L7iM8HbUrtNrQzCPXZkrfcdceReKrpJUeIjftelzEyJmsgtH6D7vKYdFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2WfBLWK9iA2DfXsL4k63ez0Z/Iar6/tpLZq/9Tmg1k=;
 b=Fx5cDtNt0TjqFirb69eucepN+eTVKynWBFOk9Ml/1ch6p/fuO4YKLCAGAmjGcLqluxzsrr0GXwaWcJyypAy17taAa02frM516b7qAnx7HBMW/1tVyf9OAM1Am2eUAHKUSTRJBoLn+hXBDMxsUxhxFPm2/3Uv7EGNFlwkNLnzTwY=
Received: from CH5P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::15)
 by SJ5PPFD5E8DE351.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 15 Jul
 2025 06:53:38 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::b2) by CH5P220CA0014.outlook.office365.com
 (2603:10b6:610:1ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 06:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:53:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:36 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:53:32 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 09/10] drm/amd/display: [FW Promotion] Release 0.1.19.0
Date: Tue, 15 Jul 2025 14:49:33 +0800
Message-ID: <20250715065233.160043-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SJ5PPFD5E8DE351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bff00c8-4368-424f-927a-08ddc36c536e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XhVNRbKL6tYN3/2jGs33ZemBM1N2nPTQC9z6X5FF95WoDEilCYqEks1EQAVi?=
 =?us-ascii?Q?BlnSA2xuv8TJlv/ateTEyAZbwo4sXvGqiRyBHuUtA/Qh7MnbnKYhgKm2u4R9?=
 =?us-ascii?Q?L35jiwk3oVOsSidS4/eyLqNNGAnT6pMkSIJQkcfivmd1kya1RT1Doeqnkbu4?=
 =?us-ascii?Q?hFgCsY9epztzJ150CdOAt0Ooobe4ZPDHF0xrpD+28il1/G02CbPVkqZW8Be/?=
 =?us-ascii?Q?+9AtrOKGVsnxCMJ9hHgW5T394ZDPPttQT2cz3Ax1TNdOKaLAZjZOIiAA+yjo?=
 =?us-ascii?Q?t6tTAJamYP5DRy44Kq9NtjE6AvJC4rEOiD5pdEXwEsDWN0oNKag6dgGlIbOg?=
 =?us-ascii?Q?oFpMiRgY6D33Fq+n7AVpFXK5t6RcZ7sTKKt6YXkPtV9dAenouBbtPoDEcbEa?=
 =?us-ascii?Q?sPoB3GWDQHsEsrZVnMT+Vd9uXntG56gfae5diIL/ElGVokaC+q3Elroa9hIv?=
 =?us-ascii?Q?DumH6v+Y83qwmiKnp1D2oiA/aoLzMYmzzlMGzIJumYL5OjBaXyGwSzNA5ItS?=
 =?us-ascii?Q?HuoyDQCuA4jVqUbw3NrF2Fn9AP6wEfhCagPngidP5zAO1GGxb7w/e9s2Xr4f?=
 =?us-ascii?Q?JpgU/xKycXcFFUkhNz9/UqEx/xDkCmON8cTyfbP6lNSvyq1tXnYOeqp7RhY7?=
 =?us-ascii?Q?HXk6YCMzjQS/9sW4cR+SN2ZDxGON0I8IbN/uEczv30hK+3UyYs2CVo/GMhQk?=
 =?us-ascii?Q?BfS6289LV9y5MMgav/CjQlngpLbIxNQtr2CajLE/Qc8iTDffkPzzz7sNRtti?=
 =?us-ascii?Q?FK49Xamtcv6vPgOA3uvzxwKOnJwcrGhjO4FEUQN6VVh+pGqmuFwnFpfsFxZU?=
 =?us-ascii?Q?02lT/e4UWFRAMwRj5zFVa1wzfAbxjxTace2r8l2UMoY++bWtxxQjWFC2T4Ca?=
 =?us-ascii?Q?6wXxqi9+cjnnjK3Z6IeWKNt48Ks+1xKYjKOZYaSkq82wOrwfmhx7A7B683L4?=
 =?us-ascii?Q?Lyk5bjxxLBeKj1K3ZMKgRncpPDrwvGQTJhKzELRqrdcxjA3zyICRcEH6zNLs?=
 =?us-ascii?Q?zsNdxatH1cZnp7RYlHkseUubxQDbZPVvpbszXAjbHqBcsRZF0P2hBO0CpLy8?=
 =?us-ascii?Q?M8b2bzOCXvz9zR/ZR2/c9inAUszuqPrjglYf+uNagzLgQJdjHHp5V8LRqBlL?=
 =?us-ascii?Q?xY6RrQGzPYJwZZ1jUe/iYiCaxSTmzyd3uc+SepHlgj6DU8B/vmBiuFWnYJNx?=
 =?us-ascii?Q?HhLE8JhSIA65FD9utSzSe8IUxK9sdT3sRvOZLUaJlsGb+lCOA0eRy5ocUamZ?=
 =?us-ascii?Q?5JNfqHqEUDlwxXzZ+sI1dKC7N+OZeaT1nLWT0NOqlq6X3Ja4IJVLEF0826B4?=
 =?us-ascii?Q?Kq0d3il7e7sC/5QIQN2/aj8fsVMP4JXNG99wGT9fVq1DXvriUb8pF06f3ftx?=
 =?us-ascii?Q?8qCg2DkB/ghODIIebZcESEEFNjrI6GOM9n/tUm5KKCNHiLxJBZVHZSjii0Zo?=
 =?us-ascii?Q?wdDiF2Pod/PspHgOoRLDwx9I0mnSFvSsGxPuXZ6hdeccp0HTFR0FmT+cSRqb?=
 =?us-ascii?Q?mWd8WXS7yKtTodf/s+cXQNOztKZNaGMbrO5rKBgp/NW427Oi6sfJRcHviQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:53:37.9485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bff00c8-4368-424f-927a-08ddc36c536e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD5E8DE351
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Update DMUB related command structure.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 89 +++++++++++++++----
 1 file changed, 73 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 1fb1472737ad..a89bf08ffd37 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1990,18 +1990,19 @@ struct dmub_cmd_lsdma_data {
 		struct lsdma_tiled_copy_data {
 			uint32_t src_addr_lo;
 			uint32_t src_addr_hi;
+
 			uint32_t dst_addr_lo;
 			uint32_t dst_addr_hi;
 
 			uint32_t src_x            : 16;
 			uint32_t src_y            : 16;
 
-			uint32_t src_width        : 16;
-			uint32_t src_height       : 16;
-
 			uint32_t dst_x            : 16;
 			uint32_t dst_y            : 16;
 
+			uint32_t src_width        : 16;
+			uint32_t src_height       : 16;
+
 			uint32_t dst_width        : 16;
 			uint32_t dst_height       : 16;
 
@@ -2034,23 +2035,58 @@ struct dmub_cmd_lsdma_data {
 			uint32_t padding          : 30;
 		} tiled_copy_data;
 		struct lsdma_linear_copy_data {
+			uint32_t src_lo;
+			uint32_t src_hi;
+
+			uint32_t dst_lo;
+			uint32_t dst_hi;
+
 			uint32_t count            : 30;
 			uint32_t cache_policy_dst : 2;
 
 			uint32_t tmz              : 1;
 			uint32_t cache_policy_src : 2;
 			uint32_t padding          : 29;
-
+		} linear_copy_data;
+		struct lsdma_linear_sub_window_copy_data {
 			uint32_t src_lo;
 			uint32_t src_hi;
+
 			uint32_t dst_lo;
 			uint32_t dst_hi;
-		} linear_copy_data;
+
+			uint32_t src_x        : 16;
+			uint32_t src_y        : 16;
+
+			uint32_t dst_x        : 16;
+			uint32_t dst_y        : 16;
+
+			uint32_t rect_x       : 16;
+			uint32_t rect_y       : 16;
+
+			uint32_t src_pitch    : 16;
+			uint32_t dst_pitch    : 16;
+
+			uint32_t src_slice_pitch;
+			uint32_t dst_slice_pitch;
+
+			uint32_t tmz              : 1;
+			uint32_t element_size     : 3;
+			uint32_t src_cache_policy : 3;
+			uint32_t dst_cache_policy : 3;
+			uint32_t reserved0        : 22;
+		} linear_sub_window_copy_data;
 		struct lsdma_reg_write_data {
 			uint32_t reg_addr;
 			uint32_t reg_data;
 		} reg_write_data;
 		struct lsdma_pio_copy_data {
+			uint32_t src_lo;
+			uint32_t src_hi;
+
+			uint32_t dst_lo;
+			uint32_t dst_hi;
+
 			union {
 				struct {
 					uint32_t byte_count      : 26;
@@ -2063,12 +2099,11 @@ struct dmub_cmd_lsdma_data {
 				} fields;
 				uint32_t raw;
 			} packet;
-			uint32_t src_lo;
-			uint32_t src_hi;
-			uint32_t dst_lo;
-			uint32_t dst_hi;
 		} pio_copy_data;
 		struct lsdma_pio_constfill_data {
+			uint32_t dst_lo;
+			uint32_t dst_hi;
+
 			union {
 				struct {
 					uint32_t byte_count      : 26;
@@ -2081,14 +2116,12 @@ struct dmub_cmd_lsdma_data {
 				} fields;
 				uint32_t raw;
 			} packet;
-			uint32_t dst_lo;
-			uint32_t dst_hi;
+
 			uint32_t data;
 		} pio_constfill_data;
 
 		uint32_t all[14];
 	} u;
-
 };
 
 struct dmub_rb_cmd_lsdma {
@@ -4047,6 +4080,14 @@ struct dmub_cmd_replay_copy_settings_data {
 	 * DIG BE HW instance.
 	 */
 	uint8_t digbe_inst;
+	/**
+	 * @hpo_stream_enc_inst: HPO stream encoder instance
+	 */
+	uint8_t hpo_stream_enc_inst;
+	/**
+	 * @hpo_link_enc_inst: HPO link encoder instance
+	 */
+	uint8_t hpo_link_enc_inst;
 	/**
 	 * AUX HW instance.
 	 */
@@ -4150,6 +4191,18 @@ struct dmub_rb_cmd_replay_enable_data {
 	 * This does not support HDMI/DP2 for now.
 	 */
 	uint8_t phy_rate;
+	/**
+	 * @hpo_stream_enc_inst: HPO stream encoder instance
+	 */
+	uint8_t hpo_stream_enc_inst;
+	/**
+	 * @hpo_link_enc_inst: HPO link encoder instance
+	 */
+	uint8_t hpo_link_enc_inst;
+	/**
+	 * @pad: Align structure to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
@@ -4663,22 +4716,26 @@ enum dmub_cmd_lsdma_type {
 	 * LSDMA copies data from source to destination linearly
 	 */
 	DMUB_CMD__LSDMA_LINEAR_COPY = 1,
+	/**
+	* LSDMA copies data from source to destination linearly in sub window
+	*/
+	DMUB_CMD__LSDMA_LINEAR_SUB_WINDOW_COPY = 2,
 	/**
 	 * Send the tiled-to-tiled copy command
 	 */
-	DMUB_CMD__LSDMA_TILED_TO_TILED_COPY = 2,
+	DMUB_CMD__LSDMA_TILED_TO_TILED_COPY = 3,
 	/**
 	 * Send the poll reg write command
 	 */
-	DMUB_CMD__LSDMA_POLL_REG_WRITE = 3,
+	DMUB_CMD__LSDMA_POLL_REG_WRITE = 4,
 	/**
 	 * Send the pio copy command
 	 */
-	DMUB_CMD__LSDMA_PIO_COPY = 4,
+	DMUB_CMD__LSDMA_PIO_COPY = 5,
 	/**
 	 * Send the pio constfill command
 	 */
-	DMUB_CMD__LSDMA_PIO_CONSTFILL = 5,
+	DMUB_CMD__LSDMA_PIO_CONSTFILL = 6,
 };
 
 struct abm_ace_curve {
-- 
2.43.0

