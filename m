Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31428E6B278
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD6310E9C6;
	Fri,  1 Nov 2024 13:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XYPZ6nEZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6362710E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeNoEzZgqq8g1wB7Kzaz3pliCEgZ4fyPyjSoH48WwEzScxTeWWUMx0l8idzk4JWhEjQLhMPPcFZDCT4pRjZy3o8+8InU3Y4KU9NeeiZwE4GYhx+xtFJ0XjZibdFXBbGyT6HDahrmjdNMNGtFBFbBW269puw00QXfKE2q/efW2xpOmTqT6F/qFy9L5LgYwP7ZmA6x9vor9YqsWfmBKGiWfclz9hN+9dSKRZaG47FbbCd2CsJ76iNG3WKhTt15UtezBUBqR1FMNL7Tpt2U0W1yw0hzFhKiU8vN682pLj/IjsdoWf6xUjISggS/Y8DIgNcxu6u7NnNq3ASi+Z09e1nwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+ZC6nq4JkyBUwtfNfpciv9InWnq//jHxdMzfnsgkmg=;
 b=WIX6LAhqlLF103l/P3RLYC55TboA6Ky35wUjbW7pX9O/UMagmPpb4BZKddD9zPl31fsj+u2cUVH8b3ROxRQplS1k/dE4Zhq+b8O2FAzHD1upBQWJOKFnWiBaEMw4Gxs/GRJQFtjoeDX8mqldQm4uI4HIOVMO89k6lVgCPtutTa1iL6VeT2CXu+XQo05dJwE5486Ba9Xr+X4wPCmej4bufrySgUPYJAur6A08Jcf/We57dMfyRgyMw2mtXy6Wsr2oYhP9od/1+zFWYlHSBHzrMvVGHkTbUrYx5Ff306BjAXmoS/S3560XT/zvi8cKlWk46GE4ZWoExSfx2B/54U9dfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+ZC6nq4JkyBUwtfNfpciv9InWnq//jHxdMzfnsgkmg=;
 b=XYPZ6nEZL6VMFkba9k28XuZw0eUICnLAlS+2HmZ2DsmPxMp98KDO0oIbgdPwijXSaBN3Y+kIcL8atujSnuoqlGG0Oxca4PKQagR4X9JnMYTrZ7LxtOlWEDixcqmeBYfl+B3WK8DqeI3Dp0i3rb3P3dCRw2uVqZFHVd9YnDeFXr8=
Received: from BN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:e4::9)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 13:50:12 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::65) by BN0PR02CA0004.outlook.office365.com
 (2603:10b6:408:e4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:11 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:09 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 06/17] drm/amd/display: fix asserts in SPL during bootup
Date: Fri, 1 Nov 2024 09:49:29 -0400
Message-ID: <20241101134940.1426653-7-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: db098693-1464-4e41-73e6-08dcfa7c1b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jXzzib7s0YETdrAXJoXDUfE0aO0BLvpOsajEAkJQpP+6r8I9ek2a1bAE61MR?=
 =?us-ascii?Q?ZFsnlqKRn5FuWDf3JPaeQzMfigh7fHq4du15uPLZOzSmac346abQ6mUKs+Yn?=
 =?us-ascii?Q?3FdA4nS1r0UlpkEqyEBflrDEfz3B8EN2mlodF01GdzufPJoyZvcOGZdvoHub?=
 =?us-ascii?Q?QT0m8VpRiyX2wApl9twxLBB3Wk9FrCMsByP/HWrozYwNqOBqY9DUAYy+0ekp?=
 =?us-ascii?Q?qKAyj/spES9hsVzJYrdtTs0DppKbY29PLT3aytp2B26Yy3ogfkG5Oa44yaSY?=
 =?us-ascii?Q?gqrevBWmkXQNgh+VaLA6yZoUrVFzfK+/cVVYYYr1NhgZFAgKc6FzXa1izk4A?=
 =?us-ascii?Q?KOx9DLJm9xEV3ShoCb89lYw5JsLf5uqyGs5FOohO8x3IFjmLRM3Lw3k8iT/A?=
 =?us-ascii?Q?ObzEB26wZZw4pBHyBB5PF+kIrLrQzZ82aqoNXjDwYm8/WuOrXqZKX/p3QYhN?=
 =?us-ascii?Q?P05O0Hsv7dgxy9jIVMUYciE/OvDNpOs+sgRbuJGf3xGiLwHW2p8qtVXYusv9?=
 =?us-ascii?Q?PIPr6/MuACHtNnvT2FoM/IT4ArbXhPFI/wQRMMYfm5AUQFYa/uBn7A2XxSb5?=
 =?us-ascii?Q?Ht+e5rgqgICKO2aARyzkTRhL0U//cV4MSPEj+gpEhmwxmvgrLmDNkoQ7Fdrp?=
 =?us-ascii?Q?BvTHAigUYJ0nru8YfvfAuprHLcJBTchzYTSwds7rz72q0nrYX+H3r5FmC+2H?=
 =?us-ascii?Q?iwkHgJ/x55v6UhV+rxeRy8teZkiovE7nxfQLtqe5jNuwQyzjfepxCLe7/aB7?=
 =?us-ascii?Q?XyZIFTlQNA/SevZwfO+PxShFChxG/NpFmVClOQt8yUuDVYucVc57xNe3mIwl?=
 =?us-ascii?Q?DFcCj8uVC5W/SJcEbaG2QUOdeLBi/MY6u8Elt7/SQ/qfhOJIpwOi3iqC6JGM?=
 =?us-ascii?Q?pNImQvsSKS8w24fsFyl0wNQYVH7FMum2XsowmWX7R1yzEXUZr6Qz5UEKe4UA?=
 =?us-ascii?Q?ah76njfIcI1NpwhDtkt8xmB2S8ezJ/Efk6o7MXQ8L7C95Jy03elj8zPXhe6C?=
 =?us-ascii?Q?PQxN/FbUxU2DA2z6VyuGpGfyfnHl9WqsgjOkCcL+qyN6lWeh98eKGObe2MnS?=
 =?us-ascii?Q?NKDuPIT7pziQeYNG1mNkjR8QNlWsl/q62tuwI/vc9IKvXJGtEZTt1ACEAMfD?=
 =?us-ascii?Q?ZIQWKJrX+wwTTdU+CggXp9E2xFvWxSjm9JsGPRdju5w09I4wUUAHFsQwlBMC?=
 =?us-ascii?Q?Lbg6TYb5wPV3Xftm1hJ4YhH6VjUs6ZDCc7OHWo/+AVd60HFuty3q+kZHRgKT?=
 =?us-ascii?Q?XWKjPZ2pHbHWEd30pHHBP29AY5rLMd5NgQm1egWltL9QPuLUUPTXslHgpRM8?=
 =?us-ascii?Q?9xWTGnnvpMIFc1pyhy6wojS+9C2ptVnSYQVWA/Y+IPYYgD6ZDNxRditg0MRv?=
 =?us-ascii?Q?XVULvnRbfn2/H09PlU+sXrm/Z/MGWDwiqiqUuHag4nJQFqOsGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:11.6331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db098693-1464-4e41-73e6-08dcfa7c1b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
During mode validation, there maybe modes that fail
 max_downscale_src_width check and scaling_quality
 taps are 0.  This will cause an assert to trigger
 in spl_set_filters_data() because taps are 0.

[How]
Move taps calculation for non-adaptive scaling mode
 to separate function and call it
 if max_downscale_src_width fails.  This will
 populate taps if scaling_quality taps are 0.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c | 86 ++++++++++++---------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 133906e73a65..9095da7b842b 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -868,6 +868,50 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 	return enable_isharp;
 }
 
+/* Calculate number of tap with adaptive scaling off */
+static void spl_get_taps_non_adaptive_scaler(
+	  struct spl_scratch *spl_scratch, const struct spl_taps *in_taps)
+{
+	if (in_taps->h_taps == 0) {
+		if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.horz) > 1)
+			spl_scratch->scl_data.taps.h_taps = spl_min(2 * spl_fixpt_ceil(
+				spl_scratch->scl_data.ratios.horz), 8);
+		else
+			spl_scratch->scl_data.taps.h_taps = 4;
+	} else
+		spl_scratch->scl_data.taps.h_taps = in_taps->h_taps;
+
+	if (in_taps->v_taps == 0) {
+		if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) > 1)
+			spl_scratch->scl_data.taps.v_taps = spl_min(spl_fixpt_ceil(spl_fixpt_mul_int(
+				spl_scratch->scl_data.ratios.vert, 2)), 8);
+		else
+			spl_scratch->scl_data.taps.v_taps = 4;
+	} else
+		spl_scratch->scl_data.taps.v_taps = in_taps->v_taps;
+
+	if (in_taps->v_taps_c == 0) {
+		if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) > 1)
+			spl_scratch->scl_data.taps.v_taps_c = spl_min(spl_fixpt_ceil(spl_fixpt_mul_int(
+				spl_scratch->scl_data.ratios.vert_c, 2)), 8);
+		else
+			spl_scratch->scl_data.taps.v_taps_c = 4;
+	} else
+		spl_scratch->scl_data.taps.v_taps_c = in_taps->v_taps_c;
+
+	if (in_taps->h_taps_c == 0) {
+		if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.horz_c) > 1)
+			spl_scratch->scl_data.taps.h_taps_c = spl_min(2 * spl_fixpt_ceil(
+				spl_scratch->scl_data.ratios.horz_c), 8);
+		else
+			spl_scratch->scl_data.taps.h_taps_c = 4;
+	} else if ((in_taps->h_taps_c % 2) != 0 && in_taps->h_taps_c != 1)
+		/* Only 1 and even h_taps_c are supported by hw */
+		spl_scratch->scl_data.taps.h_taps_c = in_taps->h_taps_c - 1;
+	else
+		spl_scratch->scl_data.taps.h_taps_c = in_taps->h_taps_c;
+}
+
 /* Calculate optimal number of taps */
 static bool spl_get_optimal_number_of_taps(
 	  int max_downscale_src_width, struct spl_in *spl_in, struct spl_scratch *spl_scratch,
@@ -883,7 +927,7 @@ static bool spl_get_optimal_number_of_taps(
 	if (spl_scratch->scl_data.viewport.width > spl_scratch->scl_data.h_active &&
 		max_downscale_src_width != 0 &&
 		spl_scratch->scl_data.viewport.width > max_downscale_src_width) {
-		memcpy(&spl_scratch->scl_data.taps, in_taps, sizeof(struct spl_taps));
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps);
 		*enable_easf_v = false;
 		*enable_easf_h = false;
 		*enable_isharp = false;
@@ -910,43 +954,9 @@ static bool spl_get_optimal_number_of_taps(
 	 * From programming guide: taps = min{ ceil(2*H_RATIO,1), 8} for downscaling
 	 * taps = 4 for upscaling
 	 */
-	if (skip_easf) {
-		if (in_taps->h_taps == 0) {
-			if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.horz) > 1)
-				spl_scratch->scl_data.taps.h_taps = spl_min(2 * spl_fixpt_ceil(
-					spl_scratch->scl_data.ratios.horz), 8);
-			else
-				spl_scratch->scl_data.taps.h_taps = 4;
-		} else
-			spl_scratch->scl_data.taps.h_taps = in_taps->h_taps;
-		if (in_taps->v_taps == 0) {
-			if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) > 1)
-				spl_scratch->scl_data.taps.v_taps = spl_min(spl_fixpt_ceil(spl_fixpt_mul_int(
-					spl_scratch->scl_data.ratios.vert, 2)), 8);
-			else
-				spl_scratch->scl_data.taps.v_taps = 4;
-		} else
-			spl_scratch->scl_data.taps.v_taps = in_taps->v_taps;
-		if (in_taps->v_taps_c == 0) {
-			if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) > 1)
-				spl_scratch->scl_data.taps.v_taps_c = spl_min(spl_fixpt_ceil(spl_fixpt_mul_int(
-					spl_scratch->scl_data.ratios.vert_c, 2)), 8);
-			else
-				spl_scratch->scl_data.taps.v_taps_c = 4;
-		} else
-			spl_scratch->scl_data.taps.v_taps_c = in_taps->v_taps_c;
-		if (in_taps->h_taps_c == 0) {
-			if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.horz_c) > 1)
-				spl_scratch->scl_data.taps.h_taps_c = spl_min(2 * spl_fixpt_ceil(
-					spl_scratch->scl_data.ratios.horz_c), 8);
-			else
-				spl_scratch->scl_data.taps.h_taps_c = 4;
-		} else if ((in_taps->h_taps_c % 2) != 0 && in_taps->h_taps_c != 1)
-			/* Only 1 and even h_taps_c are supported by hw */
-			spl_scratch->scl_data.taps.h_taps_c = in_taps->h_taps_c - 1;
-		else
-			spl_scratch->scl_data.taps.h_taps_c = in_taps->h_taps_c;
-	} else {
+	if (skip_easf)
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps);
+	else {
 		if (spl_is_yuv420(spl_in->basic_in.format)) {
 			spl_scratch->scl_data.taps.h_taps = 6;
 			spl_scratch->scl_data.taps.v_taps = 6;
-- 
2.34.1

