Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE504C54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7907410E551;
	Wed, 28 May 2025 02:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sg9msQDO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E3E10E1AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/kmjKwFFqO6375qMyvD9vmpHhfyqta2HJ/qeqtmwY+oFPcu/Qf5fM5BqVVD1+FCaBuxDZLR/8gP1pwYqW1Wovi5UgtPjs3DNxO8IrXzT+W2xYYHpWD/e7e+bHZDSz7rzb1OJObvX2nF/iopQ7F3ANenzpl8ZITcJvK0I+GiWI2fdlhnREPvPsoEDOHkjqSywdQ/Fy85v0FKRYXoUpvFUUWg7MAj7Tqc9mwOZ4/jiV+p88rvd+xwwN5ynbCKMbzMdFjM0iNWbgsBhcCjjO98IWxnY1Wld1mgPJyKGB2VkPqX3qn3ovnuNfO0bYQNePCO0vNDyqunGGkK9M0uUo5jcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4acm07018HeivvGbHmZDBP4vNT2o9L8pjl7zs83VB4k=;
 b=oV/amkOF5DUsDLH4fQwA2UB5GWL3is7Kg+pGOOffnX48T9/eqzt2Jmb2q/vNCdE1ksZIDQ94iOkmLiWFv0THeDt3up4wtV2A6X/0qtuyItjJKD3GYh0T5GrB+mkNzZrgvUBSWVRtdwlhXFYhnGxwzaD99vaCvichLJr6nNJNRK/n4Xn6eZryuHEuzFd2t2zl7ewf7KATgwmGk5vH3h3LCmDhSDzgVbHsa7CwTZ0DyT9ghBbE+3gb4Ihyc/X0F+PESYKkWwRL/Tted6fQUf/E7k7d7eZlAYnz1FAShCZ47ks2KJSd7CDGFhTapsJjxp3AKIsqftoZ30n6I10RLGJpOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4acm07018HeivvGbHmZDBP4vNT2o9L8pjl7zs83VB4k=;
 b=sg9msQDObOMGOilai6BOLXJw87O4swGJ7m8QFPjq9yb0Ev41UY/C9+NfqwySSO4pIi/MXICRaB18Y/fbLbEIc+JaqvobSU813SJ1WdX4ttx5NloKpIS+U18tYwWr5wvjWvV+JznIK/em+VFvDL5Jnoz1zeBnNu8eJ5cHIt42Wbk=
Received: from BN9PR03CA0885.namprd03.prod.outlook.com (2603:10b6:408:13c::20)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:53:26 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::dc) by BN9PR03CA0885.outlook.office365.com
 (2603:10b6:408:13c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:53:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:25 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:53:21 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Navid Assadian
 <Navid.Assadian@amd.com>, Samson Tam <samson.tam@amd.com>
Subject: [PATCH 13/24] drm/amd/display: Do not bypass chroma scaling in 1:1
 case
Date: Wed, 28 May 2025 10:49:08 +0800
Message-ID: <20250528025204.79578-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 2756bb90-4bd7-4a6e-4907-08dd9d92d1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MSh9CmnZlySwJ/pyh0Dwm3DuFGKdRO/if2yUvBKK7/it3a7hW2ZWK8eBCTuZ?=
 =?us-ascii?Q?o7tXscrFTcUyd70TBLzCMNYQgwdUDYgwOMf5iSiiTSR/oM2C05GoHkTBur6u?=
 =?us-ascii?Q?wtGVZH4rWM7CHT0G1/k4Nlp+N92mAL42mA6QDid4u2jiNxflUAJLeId2g6Zo?=
 =?us-ascii?Q?+JvFb3UErTdnVkf88wd9+iDDgyfhl5QVkJRN88kQ1Em/6Xa2r6850HYE3fGR?=
 =?us-ascii?Q?Y2Ya0xUIP5Qg3iIx5mV378+nHWqMTq3FckIixgEXfPok7Cd3eDXsFuK+FR3F?=
 =?us-ascii?Q?cuwR6sF/qR4dRplxizjyTuyOoah7JUT9MZZ64KIybZY3dlhRvm07bJDB6hFS?=
 =?us-ascii?Q?NZMGIiv1dYOyo7AVHl305ERnOcVCihq2IG2FILTZy7S9hfJUUBY2K3ccY5gg?=
 =?us-ascii?Q?sn6TeBwi3Q/eoS5b2+ghwRmTDkaWIITh/S4smiXfbChHuUHJhxQZjEZhzQvG?=
 =?us-ascii?Q?qcbn5guO3NzAagWt5hMQ59hNfS6KSEJ6aunk/ZdQvvP+pW0YokIPIq0q21S9?=
 =?us-ascii?Q?lFS1Q8TbN7bs87J2SV2l0od1W/AXa/YgmsDBWmKCqWNd69fDzjGHtCTFsKvY?=
 =?us-ascii?Q?yarj/6jx03K3go5oz0TAFOABh38yoJY5M/1UzfZIr0vChud+YMr5jKYMPOkX?=
 =?us-ascii?Q?JtTLrlY8X/KFb+gqr+ELVKOSXX9pcBye6tFkTqDh3jhOFUrBtaKWYGcIMRaG?=
 =?us-ascii?Q?+1dyJnhLOtiWpBiCNd0i7EC84AYh8KtYzA7DHw+WEslxVWa4cLiFnjHbUXdy?=
 =?us-ascii?Q?pJylTcjXO3EA+kDMRZRfvAnpORb4cMK9lNmy0SR5KohuY1qYpFs9W3VywoMr?=
 =?us-ascii?Q?whVDU6QGEEjz+yb4JraQLeWpmzJ7/4KUJxKsu4lb0AsbALb4HpPcG+vuRwqb?=
 =?us-ascii?Q?WTXuN6ybYYbYgunWjIcQXXcGdUreSR5HOZnD7LJily2Cu+nLrT8CQ55qXajm?=
 =?us-ascii?Q?JEj7VEOYEHG3fjeP32hFi9pveUXE4un5OXkJySkld0ujfWWNjAubUIAMaK8x?=
 =?us-ascii?Q?yHYke+WqQd2qR19DrwH1YpRudPkbXQCxx/7hEWw+ISgfKlgewvxdTMXc9Avy?=
 =?us-ascii?Q?legQkINbRJ+qBt4R5QA6c9UytBJl5gpXu0m+9FR59Bx41apjfPh2apN3rBCH?=
 =?us-ascii?Q?lH8qk0PdwbiDU7vlQD7KNgBIFbiLbWDYSh17orFqvxoiNYK+axDnot5vgvmH?=
 =?us-ascii?Q?5Ogw0fgrkmzPZh0aK2ZUG9t2HGUqVyfR0FHCT+md48AfEzNS504SXn8s+VbQ?=
 =?us-ascii?Q?nvnEloEcPQnixJEk0wHicaMW0PddasbVRt6OXJQKPYhOlugzpdB7YS/OUkZy?=
 =?us-ascii?Q?QJby1OwPBZhGkoN1W0hPBSRCM47ajwuzbnE1nV3Pg9T8DalbRUZ1qAT7VCia?=
 =?us-ascii?Q?U8lThT30S85YsBYjrY6G56Xm0fL2H0iG8e9IqNlhjwLJvpgs3POr3qfzGbzt?=
 =?us-ascii?Q?BMXb5AdkuZQumcvGZGD1nt8tOyxe5OBiPIgcBlYCxjrTrgOmDr5Q3nhHlSi1?=
 =?us-ascii?Q?36AP0tvg6CI+WCx3G+EoF7nTjKqkgxJFjzoz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:53:26.6526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2756bb90-4bd7-4a6e-4907-08dd9d92d1ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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
When doing 2:1 downscaling on a YUV sub-sampled format, the chroma
scaling ratio is 1:1. Since chroma has cositing, it is needed to do
scaling on the chroma plane(s) and not to bypass chroma scaling.

[How]
Do not set the chroma taps to one when the chroma ratio is identity
and the input format is a sub-sampled YUV format.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Navid Assadian <Navid.Assadian@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 28 +++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index e0008c5f08ad..d5f3bcb68d53 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -884,7 +884,9 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 
 /* Calculate number of tap with adaptive scaling off */
 static void spl_get_taps_non_adaptive_scaler(
-	  struct spl_scratch *spl_scratch, const struct spl_taps *in_taps, bool always_scale)
+		struct spl_scratch *spl_scratch,
+		const struct spl_taps *in_taps,
+		bool is_subsampled)
 {
 	bool check_max_downscale = false;
 
@@ -945,14 +947,15 @@ static void spl_get_taps_non_adaptive_scaler(
 	SPL_ASSERT(check_max_downscale);
 
 
-	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz) && !always_scale)
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz))
 		spl_scratch->scl_data.taps.h_taps = 1;
-	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert) && !always_scale)
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert))
 		spl_scratch->scl_data.taps.v_taps = 1;
-	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !always_scale)
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !is_subsampled)
 		spl_scratch->scl_data.taps.h_taps_c = 1;
-	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c) && !always_scale)
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c) && !is_subsampled)
 		spl_scratch->scl_data.taps.v_taps_c = 1;
+
 }
 
 /* Calculate optimal number of taps */
@@ -965,15 +968,13 @@ static bool spl_get_optimal_number_of_taps(
 	unsigned int max_taps_y, max_taps_c;
 	unsigned int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
-	bool skip_easf     = false;
-	bool always_scale  = spl_in->basic_out.always_scale;
+	bool skip_easf          = false;
 	bool is_subsampled = spl_is_subsampled_format(spl_in->basic_in.format);
 
-
 	if (spl_scratch->scl_data.viewport.width > spl_scratch->scl_data.h_active &&
 		max_downscale_src_width != 0 &&
 		spl_scratch->scl_data.viewport.width > max_downscale_src_width) {
-		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, always_scale);
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, is_subsampled);
 		*enable_easf_v = false;
 		*enable_easf_h = false;
 		*enable_isharp = false;
@@ -982,7 +983,7 @@ static bool spl_get_optimal_number_of_taps(
 
 	/* Disable adaptive scaler and sharpener when integer scaling is enabled */
 	if (spl_in->scaling_quality.integer_scaling) {
-		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, always_scale);
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, is_subsampled);
 		*enable_easf_v = false;
 		*enable_easf_h = false;
 		*enable_isharp = false;
@@ -997,8 +998,9 @@ static bool spl_get_optimal_number_of_taps(
 	 * From programming guide: taps = min{ ceil(2*H_RATIO,1), 8} for downscaling
 	 * taps = 4 for upscaling
 	 */
-	if (skip_easf)
-		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, always_scale);
+	if (skip_easf) {
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, is_subsampled);
+	}
 	else {
 		if (spl_is_video_format(spl_in->basic_in.format)) {
 			spl_scratch->scl_data.taps.h_taps = 6;
@@ -1124,7 +1126,6 @@ static bool spl_get_optimal_number_of_taps(
 			(IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert))) {
 			spl_scratch->scl_data.taps.h_taps = 1;
 			spl_scratch->scl_data.taps.v_taps = 1;
-
 			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !is_subsampled)
 				spl_scratch->scl_data.taps.h_taps_c = 1;
 
@@ -1149,6 +1150,7 @@ static bool spl_get_optimal_number_of_taps(
 			if ((!*enable_easf_v) && !is_subsampled &&
 				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c)))
 				spl_scratch->scl_data.taps.v_taps_c = 1;
+
 		}
 	}
 	return true;
-- 
2.43.0

