Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35768C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C4210E523;
	Tue, 15 Jul 2025 06:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wtq2dyW4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCD910E521
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faF4EMfGUIhQy6E6ykpqaH+R0sD4qAKNWWrvnYhqmOML1I7jClO2fsbU9BUr++W6Ke0CavrcJvJCbgY7lTpSHlXBVi7TFIyGTAJKR7lNPmerbZqF8A5TXCEorxnO4zk48d6VIoHiCGvWcu9qARdu6JYFn05dW0dkm1j8ivNTj2EQKOPScxjZPMDCb/fuh6f4lssdNcS+6H/XlLjb+c9YUEkE/mqjd11m1O+jwObiH1Pp2qq8YXBEx+1QiYJ8BIPThT3MMkDGwsJzXFCdSFJCWrxYdsHcIsXdBJe7R5pyp4Vtx86ODwpBb+FRWvYxKlSbL8uWCwb5lu1jbwPLIciWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvklfJzOsneVR7Cix22pMvkZA+2IyJnW1/n418QEFkY=;
 b=JjDdBK7hHUW/vf4UYYMgIeTaG7jfPFzcMt9tFiVQJqJFVtJOD7jiSKXEfhT3bunD08KnhcYRIlblKaZ30bWJvZ5sitfkozg9887ZDbwUQksJV7nM16mJvBWByMdANvwpcYIHHMJ6dYX6Z85+pQiF4vpDsP+uwXEujuFmbCaBbkq9wT3GFKNojK2H6/Xw37zOTN7J+ucnmvW9FKm66P+NJfkwifQi+J3xp4o2U2QOFJc5NlLLQdVKAwPsDNhaJkJufF7ULLnoelKz0hCcWOfRxPZZPK6oFpH8TtfPR5vmW2AIBuIjpIdwQpAGpkhfaKwX3PNfSLkXt4G24aSwlfhUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvklfJzOsneVR7Cix22pMvkZA+2IyJnW1/n418QEFkY=;
 b=wtq2dyW4NzfCZ+1lR6wXNrSp+jiVDkHLKcMzQhO8Aeg9LFdi0jFqZ53mOiLKFQbzJqdW2mabzFvyIVpFPPAlYuVlKbBfMhMZvItNZ2v/UOtc6RDV7vP4PGYKCcEXVs/Z2zf6PFgvQ2dW3W+MLz4aAvWKPPpPlv5M2R6pSHcyl1g=
Received: from CH0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::15)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 06:53:33 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::2d) by CH0P220CA0007.outlook.office365.com
 (2603:10b6:610:ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 06:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:53:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:32 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:53:27 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 08/10] drm/amd/display: Fix divide by zero when calculating
 min ODM factor
Date: Tue, 15 Jul 2025 14:49:32 +0800
Message-ID: <20250715065233.160043-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8df420-d630-45c6-7317-08ddc36c5060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?47vsFsxhFVFKCLI9SPNtmaL3J6NsZjJZ15bywEu1TvjFTI0aGvprZi9nrnth?=
 =?us-ascii?Q?4IA2hTAIVOz12sBz7iHjG11+Ffckkl+ALShTZYBDL5sqWmKp39ZNx+Ro18xw?=
 =?us-ascii?Q?W/a5ydEcuGg7QwHQEhL+e7PQIwpQAcVarieP/3RhGbKjulCghbgJq9N1ZiFa?=
 =?us-ascii?Q?/OqWDTUhmyJ2E785zBiW/UwRq97p7ySfwDzhubk5+98i6CFemZlrRwnRomLH?=
 =?us-ascii?Q?poHKINUBAFh2p+VXBXPo/awQKzkDCiQvR0zNmeniPzGHgXDewJQBWEQUOHCv?=
 =?us-ascii?Q?GBOHUXtLF86fJ76sJFrgSAcWEV+ZdTR4S0t22zpr5TAdEqXY+MA5D1X+xGX0?=
 =?us-ascii?Q?XF4/C6KFODGCpvmgvweO6omKMzTVgbiDFmbgNMxsh1YMD8o/kCet9vdSZon9?=
 =?us-ascii?Q?iy8ZgFkPI5miv/jejKvO3Nak+r2MU9G+orScKn8Pb/q14N0yofUhYRI6CRCw?=
 =?us-ascii?Q?DxDJcOYMt4UMoxFOhczSBIUIEN/rczXgEW1i+a+GA9k1ZeQz5FYey0tYaxyx?=
 =?us-ascii?Q?IL694tVKz1OvjszesQ5+hVNgAQE+NHuPB5emL0K/KqSTljxLzsUF6t8rqswW?=
 =?us-ascii?Q?ScJ9rgsvFJiPA9L1pZ88JBNXIm65pqnAY8ECOiR5Or9wXeBxM9cYrNT/Cc0g?=
 =?us-ascii?Q?AZPcLpuWklOLPEisox6ZSC68OnNiEn7Y4odDkakBvpN8zoYXM92uPOtSu3/q?=
 =?us-ascii?Q?ocYKgHJ4c+sAgq7B+D7TC+y9hqMFsyC6Kb1HVNluTOtjS+MikWFRaJuwQssy?=
 =?us-ascii?Q?jcXEIDawuhPQc714+EjJGI33a9qaAnfjuFcW8EmEM/0fqg/VmNp41hIeMA9b?=
 =?us-ascii?Q?Pzsjeu+y44CwVcHhFFaIEuqvne+tvBM2Q0fYrqPGK0+dc2tIR4VA3cUh1x1v?=
 =?us-ascii?Q?IThUJkpP4hqEiJQVqBlOH+eyctkcGBXSEPJghMeLwPq+j1pZ8GX8P+SxSqgQ?=
 =?us-ascii?Q?UzTnSB4DXI4jIuIs86R+vUXHKtz8CLiX+gxxc4DoLZ5smhrJiZdIM1QI89oT?=
 =?us-ascii?Q?8DnaBI1nt/vc0kGyYqorLkJYW4BWAdpjhdnIbVORWV0SpGEe/H5CgjiqEn/g?=
 =?us-ascii?Q?7PzUervlhxpCHeGxLvEJJwqXJZMBkUNyiNDCNx0SvwTOjtbsAE2z9n52RELH?=
 =?us-ascii?Q?gSIJWV6kHr43DHz8stA9SSFjd/cz6Yeume6ctm4XEGv23N6DsvEGX1cDGvnb?=
 =?us-ascii?Q?SYIaoNzYLxVOCtSYr5oIKMeGUuO3d/lkkNWbn4q02cjK4sfuJDxhbf5nCBlI?=
 =?us-ascii?Q?a/awB6s7PLQlCF23UStvb7qaT1ogZ464XS6GQhXzrILGbZffjC+rwEI9KUZs?=
 =?us-ascii?Q?GkveMREnM5wMWFkPlEcvg++QIHIvZcgO+ELO7pnv9Xtoz4dAV9lKoZBCaIVs?=
 =?us-ascii?Q?7gUtgHegPr0C7qmr81p3NsjgW+GxlQ8K2CLa2gulbtLy+OH/1Z+Y4fv3POGn?=
 =?us-ascii?Q?JC06PC66QJuX2uc/xcjdADxhxlKRRuy3Rv0Jgr8InnhPvyx3Is/afCudpzOG?=
 =?us-ascii?Q?Dfsmfy5n3vT33fC+Qlpj4nq9NDJWxqyOYiqVfVh7FXxTAa6BAaqN7PbYNw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:53:32.8213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8df420-d630-45c6-7317-08ddc36c5060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
If the debug option is set to disable_dsc the max slice width and/or
dispclk can be zero. This causes a divide by zero when calculating the
min ODM combine factor. Add a check to ensure they are valid first.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 29 +++++++++++----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index a454d16e6586..1f53a9f0c0ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -152,7 +152,7 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 }
 
 /* Forward Declerations */
-static unsigned int get_min_slice_count_for_odm(
+static unsigned int get_min_dsc_slice_count_for_odm(
 		const struct display_stream_compressor *dsc,
 		const struct dsc_enc_caps *dsc_enc_caps,
 		const struct dc_crtc_timing *timing);
@@ -466,7 +466,7 @@ bool dc_dsc_compute_bandwidth_range(
 		struct dc_dsc_bw_range *range)
 {
 	bool is_dsc_possible = false;
-	unsigned int min_slice_count;
+	unsigned int min_dsc_slice_count;
 	struct dsc_enc_caps dsc_enc_caps;
 	struct dsc_enc_caps dsc_common_caps;
 	struct dc_dsc_config config = {0};
@@ -478,14 +478,14 @@ bool dc_dsc_compute_bandwidth_range(
 
 	get_dsc_enc_caps(dsc, &dsc_enc_caps, timing->pix_clk_100hz);
 
-	min_slice_count = get_min_slice_count_for_odm(dsc, &dsc_enc_caps, timing);
+	min_dsc_slice_count = get_min_dsc_slice_count_for_odm(dsc, &dsc_enc_caps, timing);
 
 	is_dsc_possible = intersect_dsc_caps(dsc_sink_caps, &dsc_enc_caps,
 			timing->pixel_encoding, &dsc_common_caps);
 
 	if (is_dsc_possible)
 		is_dsc_possible = setup_dsc_config(dsc_sink_caps, &dsc_enc_caps, 0, timing,
-				&options, link_encoding, min_slice_count, &config);
+				&options, link_encoding, min_dsc_slice_count, &config);
 
 	if (is_dsc_possible)
 		is_dsc_possible = decide_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16,
@@ -593,14 +593,12 @@ static void build_dsc_enc_caps(
 
 	struct dc *dc;
 
-	memset(&single_dsc_enc_caps, 0, sizeof(struct dsc_enc_caps));
-
 	if (!dsc || !dsc->ctx || !dsc->ctx->dc || !dsc->funcs->dsc_get_single_enc_caps)
 		return;
 
 	dc = dsc->ctx->dc;
 
-	if (!dc->clk_mgr || !dc->clk_mgr->funcs->get_max_clock_khz || !dc->res_pool)
+	if (!dc->clk_mgr || !dc->clk_mgr->funcs->get_max_clock_khz || !dc->res_pool || dc->debug.disable_dsc)
 		return;
 
 	/* get max DSCCLK from clk_mgr */
@@ -634,7 +632,7 @@ static inline uint32_t dsc_div_by_10_round_up(uint32_t value)
 	return (value + 9) / 10;
 }
 
-static unsigned int get_min_slice_count_for_odm(
+static unsigned int get_min_dsc_slice_count_for_odm(
 		const struct display_stream_compressor *dsc,
 		const struct dsc_enc_caps *dsc_enc_caps,
 		const struct dc_crtc_timing *timing)
@@ -651,6 +649,10 @@ static unsigned int get_min_slice_count_for_odm(
 		}
 	}
 
+	/* validate parameters */
+	if (max_dispclk_khz == 0 || dsc_enc_caps->max_slice_width == 0)
+		return 1;
+
 	/* consider minimum odm slices required due to
 	 * 1) display pipe throughput (dispclk)
 	 * 2) max image width per slice
@@ -669,13 +671,12 @@ static void get_dsc_enc_caps(
 {
 	memset(dsc_enc_caps, 0, sizeof(struct dsc_enc_caps));
 
-	if (!dsc)
+	if (!dsc || !dsc->ctx || !dsc->ctx->dc || dsc->ctx->dc->debug.disable_dsc)
 		return;
 
 	/* check if reported cap global or only for a single DCN DSC enc */
 	if (dsc->funcs->dsc_get_enc_caps) {
-		if (!dsc->ctx->dc->debug.disable_dsc)
-			dsc->funcs->dsc_get_enc_caps(dsc_enc_caps, pixel_clock_100Hz);
+		dsc->funcs->dsc_get_enc_caps(dsc_enc_caps, pixel_clock_100Hz);
 	} else {
 		build_dsc_enc_caps(dsc, dsc_enc_caps);
 	}
@@ -1295,10 +1296,10 @@ bool dc_dsc_compute_config(
 {
 	bool is_dsc_possible = false;
 	struct dsc_enc_caps dsc_enc_caps;
-	unsigned int min_slice_count;
+	unsigned int min_dsc_slice_count;
 	get_dsc_enc_caps(dsc, &dsc_enc_caps, timing->pix_clk_100hz);
 
-	min_slice_count = get_min_slice_count_for_odm(dsc, &dsc_enc_caps, timing);
+	min_dsc_slice_count = get_min_dsc_slice_count_for_odm(dsc, &dsc_enc_caps, timing);
 
 	is_dsc_possible = setup_dsc_config(dsc_sink_caps,
 		&dsc_enc_caps,
@@ -1306,7 +1307,7 @@ bool dc_dsc_compute_config(
 		timing,
 		options,
 		link_encoding,
-		min_slice_count,
+		min_dsc_slice_count,
 		dsc_cfg);
 	return is_dsc_possible;
 }
-- 
2.43.0

