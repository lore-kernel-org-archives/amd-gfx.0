Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3016ACA0FE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C7110E7ED;
	Wed, 20 Aug 2025 20:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iFmaGmT0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 954AC10E7E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvvVhNZ2hh8sAp+o4m2L5EjRhRI1yYd3p0ZJ8nQGko3w4tDhXOyWrdn3daHe9YHRBodp0HGk/sAr6WZr/Y3a1jVpNBVLd9GVyQfFe/iXN3xnIFUJ188cSS12VqbTs/vtUg7PBYP1KHyDCGFth4wPxJZL+TyqmA0JyQHpBWLOZAxzvM9ql0ph7ZyweB0EWZYvrvgQgQACry+Aiyz4/U68Q8i+y+RpFP9Rz3qG5ZW+OhUZ1Pdq8LsSaMp+iP1JayVe7Aybim/qIsx7KoFn8RIxGcoTpUptqaDaFXRynLAS4VP7v1vLkCfTK1LGzHWi3L6otaVy001cMi/wtsQ68ja6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YSCM+2YS3heT9Qpf0zCxcDurzVTVSrouQXdk6qsY+8=;
 b=rz+/xgJjomZkvlvAFVYO7U1qGTbAPSfKuMPI6HkOmV8FKyffgC6DZEgMJ8NwUc6C+BENtoMJ2FnUixB6GZFFMz0VMmZpRNzaF+DVbRtQtLSN84GpQ6ZUnQaQTPtXLHGbHHV9ByLvljNhe0QzPp79n8b90PSl2stEPJ8+diByNXv85ODlrX7w0k4tGTyD9NC7dhMErUdTcggvNzMY8aeFMxCRW5OCaredd9AIYbVh6FTuLC88SqAr/PFmeO1r6O2/hiemPV3RDaMHWdNN8sOo6256kpe3qdF4vJ7jaOTyk2zyv9f6BcMuMAl9gwdE+dYTLMgyOTSICfljK6erSKLCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YSCM+2YS3heT9Qpf0zCxcDurzVTVSrouQXdk6qsY+8=;
 b=iFmaGmT0tkO6IUgnPFD+ESfHGjKSaUHb3jZ5iVuwXTUprTs03itAJi56SuD7cUs1gnODuCzUsANU32fngPRw96BsH65D2ll5wceCp2AaI99yS5DH0wnjgV99lAVxHvLjLOrEuCIR7oaCNakqBOWO7ZdI0gCzMD6JNSm3cWjuEDQ=
Received: from CH0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:610:b3::6)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 20:21:12 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::c4) by CH0PR03CA0031.outlook.office365.com
 (2603:10b6:610:b3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 20:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 13:21:10 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:09 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>
Subject: [PATCH 09/12] drm/amd/display: Array offset used before range check
Date: Wed, 20 Aug 2025 16:19:59 -0400
Message-ID: <20250820202103.1122706-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 598efdd8-bae7-4436-3f02-08dde0271b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2BEHb1hcS9/F+5nqwdl2RSmPIjEKqKF6hh0UypsX0rZn+1RPHJh5j9ZKwObW?=
 =?us-ascii?Q?riZo580SDV3oomQDneVPwwH0E7Wuv8ShDF0UzM89z1RHqhiXE8jbXXuKc1DW?=
 =?us-ascii?Q?ksRMHJnvrJJPuUS3BBm3P60wxpfLQCHT4WXiZtYzn5kOKvYnS+TvZNJuZ9Ut?=
 =?us-ascii?Q?eY0ea04XtstXGBBABeE8spa9lmyQu+h8BkHyVJ0GHDgX6Fp483Yh0RybnN1o?=
 =?us-ascii?Q?8sCuK68DZ42vSvHszMKxrheAANTnZGCkRuGzhS1IQTHEymMzfcMnihZEexmh?=
 =?us-ascii?Q?kNQl1+yW52Lg9HCGN1RUui+hKOKfI9VNoOgHb13ivXXUxGlIb3VDWz1FUxub?=
 =?us-ascii?Q?UZDrJa5NTsZRROdml+EHAInAuHCPs5FtPPNPWFEkbX3EzkmDNfZ3TKKOEaqx?=
 =?us-ascii?Q?XW4Cgl20i4PRBkbeCpdJOWfotxpRarnir6tMqtG5e4Hkp1sIuRZuHq3VhEp2?=
 =?us-ascii?Q?PrVTHuBMqGFIqBJYaXA0dXBHYvAmoWyIt2lsZ399LTQNjC/nBbs16Kw5fjWy?=
 =?us-ascii?Q?gdYVHZkhjKutGIEKnwhNxOZh2gzpdLvWMkp5IDkyjtDU6C9gvkWhO6QcX6kM?=
 =?us-ascii?Q?PUCW/O3izptZFKxCOsGD4weY0X0RL9w4Kc3hVb7/jYlWhuy3LrQQ3rBMMpuH?=
 =?us-ascii?Q?qK3zrxVfV9G+pRsZbiM9zI0G7E+6BPF9o/RTwQZNO/Ohle/ZCuP19FhQl5il?=
 =?us-ascii?Q?CH9+7SMJnBR6t7Ix94+AIId5NXBIrqS3Pc4UROyzgf8vmpEd/5Py79eU1Qep?=
 =?us-ascii?Q?QOXpdw1/gvMnOvkU6cevpkqe7hEPMXY0o+NiwBdUYnHmx9LajYg7OIgeWpTP?=
 =?us-ascii?Q?H/ex0s9z+iVbdTiIaZ1TnnPrbh+4yj8butHMNjyiaVRdYP00BrfcZQ8Lv0NW?=
 =?us-ascii?Q?jxIhx8UxPlJXypkb42k8D2oA0lKs6WmY/+BrKSfJHr9TsUWGeJRmup10mYrv?=
 =?us-ascii?Q?NIgbB82o3yDahGGtkpHfMVJ2W4JMT7aWOWk9vmVqfcj8vL2cHKMlr8zOX1By?=
 =?us-ascii?Q?dyALHfUsjphJYMxDJvbrf8ERNS4J/t0Ucjj158eaz25UbwFpBWgkO8XORQif?=
 =?us-ascii?Q?R0t0RRTBxrfNJMG7zUoHV3mRcMIEH3qSEh1XS6DVh5hrPKorBO/4j/aiAPBV?=
 =?us-ascii?Q?wAJzd8Cglr3UnOYFi4oPIOTXpZVIVjaQ0WjE6Ag6502vr8YHAxaTqXrykyqv?=
 =?us-ascii?Q?uPcMgpN8RAVmaoAAQ9xDW9IpzQ5adh1CnFOh18P857Iy/kB9peYcaVDZm+F2?=
 =?us-ascii?Q?oCzbK83Lj5722jpqqu1lAXq1b88WOB1ck6bocsJBHYbuLb0CBsu6AYs4Yy0W?=
 =?us-ascii?Q?kvHVG1ByLLBMV9T25h2MVN7+Bmbwx6YntiNW5CVuDv+L/XXRw89XRdkeofG2?=
 =?us-ascii?Q?jg+9kyDmD6a5e0RjmBg8bGU7X6pKKhGbJHcSbS25MsrXOnE5zTyzwps+ZBH4?=
 =?us-ascii?Q?enh0qj4nW7NavqqWPwZBYCW/fuIpDYtvZpNZZi+CdZZG0NP2xE76XSqCY+PE?=
 =?us-ascii?Q?etdmFw1KKE1YBkxRj/kF5kOqFLTGwT/ljpUF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:12.2323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 598efdd8-bae7-4436-3f02-08dde0271b51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
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

From: Clay King <clayking@amd.com>

Consolidating multiple CodeQL Fixes for alerts with rule id: cpp/offset-use-before-range-check

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
index 8da97a96b1ce..8d7c59ec701d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
@@ -280,7 +280,7 @@ void dcn302_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 		j = 0;
 		/* create the final dcfclk and uclk table */
 		while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
-			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
+			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
 				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
 				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
 			} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
index e968870a4b81..b5d3fd4c3694 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
@@ -285,7 +285,7 @@ void dcn303_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 		j = 0;
 		/* create the final dcfclk and uclk table */
 		while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
-			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
+			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
 				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
 				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
 			} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 7cd7bddea423..18388fb00be8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -3229,7 +3229,7 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 			j = 0;
 			// create the final dcfclk and uclk table
 			while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
-				if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
+				if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
 					dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
 					dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
 				} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 8839faf42207..e0a1dc89ce43 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -779,7 +779,7 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 		j = 0;
 		// create the final dcfclk and uclk table
 		while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
-			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
+			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
 				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
 				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
 			} else {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 895349d9ca07..201ed863b69e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2192,7 +2192,7 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		j = 0;
 		// create the final dcfclk and uclk table
 		while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
-			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
+			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
 				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
 				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
 			} else {
-- 
2.50.1

