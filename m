Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EABAC021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A9710EAD3;
	Fri, 21 Feb 2025 16:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LawXs6B6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6579010EAD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzTwb6dB20/zhuMA3TuZKeZ4d8qrlEuvxZQ8B3gdjerIgU8yX9/Rf8DkSJeZksohCQ6nMz3Q1Thugqv2emQB/r5FCiwtSV6Pi29dafi/R6CqmNrZMjnF+RZjyXfniZHA3EAETqCxxc8UxxBPrvsfXMG10Ohw5Jgdjiy8yQtr/gB4+Ij46bHSqzTUn4EGnEgxBIeih93nyvMGD6eWhYrz4aMPX/Q8brXuH0eDCmNKr26Q6R4D04qbJx8IA736CpvaElROZWADDe083TAWvzbEWaccPS13YRx9a37OFw3ah5dDkXQV73qRYaOMEWtAIalF0MjcUNJGM8HT2QsbxEIjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6fYoYWjHT8qHOpxP24OGqdDXxwZV6FMJOuT1zJipXE=;
 b=fjK5GqSn9YNEE2n0rLSDjVAbW5dUdTFjuaarw9ZRHLvk2qU+n0V+k1ykYRlakDOR1qqhSSM6UfgRXfkQ85d1/r1aO7d8902rDvA14Pdxm+PADc0n0/30IOCWFjb8fPl37IaNYDs2WzoeINgZctfUzsP5VrpUC9TuO4+R4GVXBBQskjbVa6yhpSrX5qwkzAJ5w0M6tbfkMC1HZiTFHRkBoVbOG60rhSbCi9VgtpdMEl33wSMWwjPxqMHmNT2q346dDnTUtxBQ/iEoalwSg12wLjGtAD1/3FY8kr5deFsJLLRNT06s/8xbKvbrTe+x8m2jTzy8c+EOLtpjE1Ub1cp0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6fYoYWjHT8qHOpxP24OGqdDXxwZV6FMJOuT1zJipXE=;
 b=LawXs6B6JVjQmTidy5Cb2EEyw9+wnufDYRZ4Kqpb6yu3rOryjFL8qoWR8XTb7Bf0c01B2Q91HLJD9S19eIhRhJwnHCT3H4lSNWgA/o9Yms6RkmpOdQxc/k/tfYwKw5n39ZgpTp/X4ZIGQOgrYosov3NzOC8uwXDJYBEuK84wb9Y=
Received: from PH7P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::24)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 16:02:17 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::3e) by PH7P220CA0040.outlook.office365.com
 (2603:10b6:510:32b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 16:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:16 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:07 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Navid Assadian <Navid.Assadian@amd.com>, Samson Tam
 <Samson.Tam@amd.com>
Subject: [PATCH 06/24] drm/amd/display: Add opp recout adjustment
Date: Fri, 21 Feb 2025 11:01:27 -0500
Message-ID: <20250221160145.1730752-7-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 1917fc08-b8a1-4e9a-6b50-08dd52911d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TQo/eeM71rl8XR+1yQO4uZGadjfqLsfAtdNPDa7QBIEwP6Kri4+miK3orneE?=
 =?us-ascii?Q?oIxdPpVU0qwihXpFTQQ7BKlNB68Qs+ij07YvAfKcyIZhZchhyvjLJ5/BhTgZ?=
 =?us-ascii?Q?F/mF3cQzTlHzPRcJInHPEOM82FuTySBXIuOFuMNdq0C+lkTyLluWxzvgD6lW?=
 =?us-ascii?Q?rxg+UIEUr7f7C/MTw1Z79vSCLB3tJWNkr7Ug2oPBC3zTq/+kB6hD4ERCHBaw?=
 =?us-ascii?Q?vv8L9s5VD3tZgVNhaidFTTzLOfVuUpjg9u2LQ6JGt1KC17ug1qHw0Lv7VqxE?=
 =?us-ascii?Q?L4Tstyyb47bJPozBkJRwB9UCNVxcGwAn19ivficMN9fGgD2sZHEbS9mIInrf?=
 =?us-ascii?Q?5rDoYtX9Zlpr0DcKzSHjlux4C7XvUCh0GSNTwm6r7ODkEtPIvqCHfHkxala6?=
 =?us-ascii?Q?9JH72PuiY5giAHjtpEIZJexFBIsrbVeKbDhGfEKqnYuuOxUfbY/itr0hUiMe?=
 =?us-ascii?Q?xWxJTu40MASuoaykFU4jWRkadJ9a6OHTl3efIdT8YpK2Ed7oUVh5a7/C9XiM?=
 =?us-ascii?Q?cJk3JLBuzJmp4rnqGHIdvS8KGhM/7YDmBsyXF+YBglNkXr5T05Lo7VgYSaup?=
 =?us-ascii?Q?SpB6pihsKuwDowPjC8fiSvyXy3VywjvKhlvLqillsFfdkasiFgTLSzE2SELX?=
 =?us-ascii?Q?4uLhxHTwIrLxvpXIJZ1210T8RnNCQrND+Xi1vltd07C3vIgG1UsT6CYSPHUl?=
 =?us-ascii?Q?CMbbdEO3sz/2i0/N7XsZWcb7cuHvt4CdNxcJSAE+xbKGvP9ihcSEv1Rp+hqb?=
 =?us-ascii?Q?ZK8/bPXxfh7Rwtp2akDE508dJNcu1CxIgeNEujQnkq8oFY64ePuUQZcqZPK1?=
 =?us-ascii?Q?k35zShzQOSgXytH66RdsHpZJFsEEwg1izJKMTrNBpC0Sc1r41Zo4oqmYM8ii?=
 =?us-ascii?Q?/mnIBbhb2JlqHuDDVEfQnCu+IIdPenhIaMj3E2XmifX7HTHlYmOQTZ5i5s3m?=
 =?us-ascii?Q?YXPw0S/rfrtGf5KbKYhSxD6oA+A2GJO6Xu1y0Vl0ASYbGWJNy8pOYzDuv8q3?=
 =?us-ascii?Q?CKttRKM0/N/OxT6WnfXo3i2Hhij2yCFcqOUFJ0+QMEJY0W6lahhfyetHNMea?=
 =?us-ascii?Q?rQWVxgFfIx79p5m/R/Yt9EVP5yvAeswEj9+x8LPDbVeE8GZMtl6CpsE3mRCR?=
 =?us-ascii?Q?6AJLX8ik2AI80ZXFwCZTrH8m08gWyOn2V/hPvLPAu/bKHvEDeq4wJripgWYT?=
 =?us-ascii?Q?r4ygEkwj8WWcajJemq180qQBKqYSlvjRBdXGCuYPowhzx5uxmT1ocR344Fq7?=
 =?us-ascii?Q?sAmIdhZ1VnoEflHA6ZB56wteNpAdKgJaws+c0bwy8Aap639sHW9q8KaeaWhY?=
 =?us-ascii?Q?UXmoGd4s7uCm6MNkIEVQiX+2sR3UyS1QYR8f/hkMoeG/tEWUxkljrZlkYuHo?=
 =?us-ascii?Q?cqLLon/XUAZFBhj2ko768t2TYPoGQbmBVrl/+xDqPGK21AgmbN+gojPRjIEr?=
 =?us-ascii?Q?cUFoIF4UF0ICezC19netybzxBETBwMUsoUn+oNnvUIxroNpQctbGP9f/Bcf4?=
 =?us-ascii?Q?DcEsPBwlj1ACKN8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:16.5520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1917fc08-b8a1-4e9a-6b50-08dd52911d07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
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

From: Navid Assadian <Navid.Assadian@amd.com>

[Why]
For subsampled YUV output formats, more pixels can get fetched and be
used for scaling.

[How]
Add the adjustment to the calculated recout, so the viewport covers the
corresponding pixels on the source plane.

Signed-off-by: Navid Assadian <Navid.Assadian@amd.com>
Reviewed-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  | 31 +++++++++++++++----
 .../drm/amd/display/dc/sspl/dc_spl_types.h    | 10 ++++++
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 31495c9978b0..72a79288ab79 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -76,6 +76,21 @@ static struct spl_rect shift_rec(const struct spl_rect *rec_in, int x, int y)
 	return rec_out;
 }
 
+static void spl_opp_adjust_rect(struct spl_rect *rec, const struct spl_opp_adjust *adjust)
+{
+	if ((rec->x + adjust->x) >= 0)
+		rec->x += adjust->x;
+
+	if ((rec->y + adjust->y) >= 0)
+		rec->y += adjust->y;
+
+	if ((rec->width + adjust->width) >= 1)
+		rec->width += adjust->width;
+
+	if ((rec->height + adjust->height) >= 1)
+		rec->height += adjust->height;
+}
+
 static struct spl_rect calculate_plane_rec_in_timing_active(
 		struct spl_in *spl_in,
 		const struct spl_rect *rec_in)
@@ -723,13 +738,15 @@ static void spl_handle_3d_recout(struct spl_in *spl_in, struct spl_rect *recout)
 	}
 }
 
-static void spl_clamp_viewport(struct spl_rect *viewport)
+static void spl_clamp_viewport(struct spl_rect *viewport, int min_viewport_size)
 {
+	if (min_viewport_size == 0)
+		min_viewport_size = MIN_VIEWPORT_SIZE;
 	/* Clamp minimum viewport size */
-	if (viewport->height < MIN_VIEWPORT_SIZE)
-		viewport->height = MIN_VIEWPORT_SIZE;
-	if (viewport->width < MIN_VIEWPORT_SIZE)
-		viewport->width = MIN_VIEWPORT_SIZE;
+	if (viewport->height < min_viewport_size)
+		viewport->height = min_viewport_size;
+	if (viewport->width < min_viewport_size)
+		viewport->width = min_viewport_size;
 }
 
 static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
@@ -1764,6 +1781,8 @@ static bool spl_calculate_number_of_taps(struct spl_in *spl_in, struct spl_scrat
 	spl_calculate_recout(spl_in, spl_scratch, spl_out);
 	/* depends on pixel format */
 	spl_calculate_scaling_ratios(spl_in, spl_scratch, spl_out);
+	/* Adjust recout for opp if needed */
+	spl_opp_adjust_rect(&spl_scratch->scl_data.recout, &spl_in->basic_in.opp_recout_adjust);
 	/* depends on scaling ratios and recout, does not calculate offset yet */
 	spl_calculate_viewport_size(spl_in, spl_scratch);
 
@@ -1800,7 +1819,7 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 	// Handle 3d recout
 	spl_handle_3d_recout(spl_in, &spl_scratch.scl_data.recout);
 	// Clamp
-	spl_clamp_viewport(&spl_scratch.scl_data.viewport);
+	spl_clamp_viewport(&spl_scratch.scl_data.viewport, spl_in->min_viewport_size);
 
 	// Save all calculated parameters in dscl_prog_data structure to program hw registers
 	spl_set_dscl_prog_data(spl_in, &spl_scratch, spl_out, enable_easf_v, enable_easf_h, enable_isharp);
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index 467af9dd90de..0130673ceee6 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -427,6 +427,14 @@ struct spl_out	{
 
 // SPL inputs
 
+// opp extra adjustment for rect
+struct spl_opp_adjust {
+	int x;
+	int y;
+	int width;
+	int height;
+};
+
 // Basic input information
 struct basic_in	{
 	enum spl_pixel_format format; // Pixel Format
@@ -444,6 +452,7 @@ struct basic_in	{
 		} num_slices_recout_width;
 	} num_h_slices_recout_width_align;
 	int mpc_h_slice_index; // previous mpc_combine_v - split_idx
+	struct spl_opp_adjust opp_recout_adjust;
 	// Inputs for adaptive scaler - TODO
 	enum spl_transfer_func_type tf_type; /* Transfer function type */
 	enum spl_transfer_func_predefined tf_predefined_type; /* Transfer function predefined type */
@@ -535,6 +544,7 @@ struct spl_in	{
 	bool is_hdr_on;
 	int h_active;
 	int v_active;
+	int min_viewport_size;
 	int sdr_white_level_nits;
 	enum sharpen_policy sharpen_policy;
 };
-- 
2.34.1

