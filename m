Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7ADC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5CD10E52B;
	Mon, 28 Apr 2025 13:56:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eMZNJ20K";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559C610E52B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pY6KLbJ78pkdKL/U/M6Oqjq1R+m8bhYKIJrWtDaCJzlqYKpb+qKvaJU+6MQ8FfunIeGF1xpf5hpqDCtmOSPji0ZMW060iMDFs3sT5JrPRQZU3aiFurqnKHmRVgP0xm92uzZ4grxdtJtjvlV5rikPE1hu0dTY95cNrnTgKwEZubayvtKZfGi1y/aOEeaaVQDQlofImOFw32fmPP8M6exeECZ8fvw37iiqHkN5opJr/pmA1CjjzEBsy6dcDlFf53zMKZkC6dSeBQ6GajyaqhtNx4FS6Kv64WazoL7J4/9gxUsUbrYRuBrNmUZ1qPh8D2COP42ZDpWHXJUAl5MXh5HhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsakkzfMUU7yhH/4Bye9KCx2sw8Nj9JFGrLZSOgUh4c=;
 b=bm9a06bDyczD1dnw1yGMShgN7/qHg1eeRov7dffqKqu+/2kcl5fr+YLArZzhSAEn/Vg7PL95va17LveCtk6jwa0UVnd7n7+rF9NawSDUETZ2axXj1R30xp90YshF4DqmlqWBqdjoRbN1XMTD3znCQNBEGi2l52eix0R/QkeOV1Ovd/qxhOsM96fjP82Bt7/BLOO5lA72Rcpk5Xk3ukWrrLU3Dtnnbb9T5JT8H6lq2bf2Ly3udWShJgGfYlpFpotMFi8sFsUtmfbYRfy/Tw7h7ocDlclNeJ1vURL/OoDFnhuJlNAIromAqYcNeh0uTjB0/VlWOCnxOaa1U+4+aalEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsakkzfMUU7yhH/4Bye9KCx2sw8Nj9JFGrLZSOgUh4c=;
 b=eMZNJ20KIVIZBviJfm5LoFFQqVL6VWNxuAPrV7Ys9TfocTaVHvzCURnfdT1TNBz4Oaomf940xoSAgpQwQaEBuXbcv7/AIYYOHzO29oFpP6z9VQlSfRtZ8of1b9w6+PxseMOVOkPWNnyo3moexcWsRgx+t6rLRWat0P5jRidXaZI=
Received: from CH0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:610:11a::25)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 13:56:02 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::19) by CH0PR03CA0334.outlook.office365.com
 (2603:10b6:610:11a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 13:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:01 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:55:58 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Jesse Agate
 <jesse.agate@amd.com>, Samson Tam <samson.tam@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 04/28] drm/amd/display: Always Scale Flag
Date: Mon, 28 Apr 2025 21:50:34 +0800
Message-ID: <20250428135514.20775-5-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1c6fed-354d-4918-60c3-08dd865c6993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NSWPB53pNi5BYq6ew51hxvFNmF7Aj4Co2iiSayuB53H3jXOEShmNLDJHSpa3?=
 =?us-ascii?Q?8vdttsWMErv1C8NSkqpPsQH399fgMD+IsC6g4zjOFWASG9tDTPlILDmU47et?=
 =?us-ascii?Q?xzKXn8ADEEQXf78Iiv4M5/KHeptzkotMCxd7Ycuu8CkgUYHZuUZtKev1HME+?=
 =?us-ascii?Q?tX7q0DcObeGL2zruR76QvSsZ8S+6QOrMFCVVtXNxGuw1TFTy0PPFRoVndeX1?=
 =?us-ascii?Q?+Xsb6H7jdKJ6K1BUnByiuS9agyz+coOAnel9BqxASPhfGmG7HYgIsh28RaKa?=
 =?us-ascii?Q?R6ipiY//DOpTtgudUdt/liyxjT7oayvp8Bm5qopiyj8dEoqtV3HgbSWrK9p6?=
 =?us-ascii?Q?TzMKgI91ZIlc+6i5I5NbMfIYq+my8LhScR8klrvcQMk0H/KxKEi3pe+tb79s?=
 =?us-ascii?Q?pA79T9YnrrzkG3PoD+h/MHuaVfA4fMXeFzd51X6kmUabT7VyK6TTvQ/t5yhb?=
 =?us-ascii?Q?KC3mDF9/dxzx+zoyzn7sFhT8IKhoURCViIKXGZ4tS9r6HOFc3hn66GsWEMLh?=
 =?us-ascii?Q?2qm0B5wI2XFyDBcSexAktj50uFNpKBcXYXfsE+wF2mAyZTO8hdfn9Ynu0IJg?=
 =?us-ascii?Q?CFa4gk1QclpsqmegPjzBWSrJQxmW1RmTIRrrWFQJzTQcMGEQdTemuqJm3twG?=
 =?us-ascii?Q?ezdL2mC1UPA+TCDpz57cihu9I4zaQi3wcz/sheJpwMK/J4PM0T35IX5BckaK?=
 =?us-ascii?Q?jEmw3lwpmPcChHeFEiiHFf4HjAsVMo5PZfdiL7BJd4M+0l5TM8nzFu44eyO/?=
 =?us-ascii?Q?u1l93sE9YNhxDK2QuJYEfJDNXtgw3LBIVybq3t12gT8oU5yFIoUnobyCv8Zz?=
 =?us-ascii?Q?dDyxCltomR0qfEQwbXvQJxcpphRAdNPnruAnGqcL6MvjnXxDUFQ1Azc0u3GI?=
 =?us-ascii?Q?dt2Xqls5BzKXJKC6SKn78IfaJuVyzjKt07HHEwx+ZlQ4KlqGMK54v2Igy5tu?=
 =?us-ascii?Q?wXcGIp0XrK5Auo0fIdPOYA2BJWVCgQT9eyZOS+KCz4f3b6IYfpsVpt72PEAE?=
 =?us-ascii?Q?Dm18SYgWgH9jUmdS2xKIuFTWwJHWjQ/ip7vmiYibk2DOM4+1m0duSc/aJ929?=
 =?us-ascii?Q?4yHToGKJEFSRqN3bU0JcrO+tweXlzM4tC1BHVhfK8OzsGhGq7XZORjpPkyR/?=
 =?us-ascii?Q?uNdQdqYWXMv+y/q19All2Rq6tGhTmySvBLkXqwgKngNBlCqLhEVf8BnO5Ywv?=
 =?us-ascii?Q?6S1Aa4Gf5UQ/H9z0NQv8VPVHqjNaVJ8OP0NDVQZeeJjwKZ4W/PJDD1uk9WLm?=
 =?us-ascii?Q?G+IW3P5UK2vXVyJ4bx70T1t3sefqwwQqbUM9/KYyzP/3OwXXbgNCqinK1xmp?=
 =?us-ascii?Q?eRRoqO4WXgm1ebC2v/P/KJqd4b6vbPFjxBdzp8nCR28xApXMNFczYfDqJQbM?=
 =?us-ascii?Q?+JD5QofIlCoJasKzm0b2cKyh9eQZxkltnSq7I6uEtxY4Ridwpx51nm4gl7lD?=
 =?us-ascii?Q?scPESnnc4eCFAhzvwzyLOdYdZPP+23A6y/Ygki7uWxZNZKKgAbhkVWhCtsQG?=
 =?us-ascii?Q?Ab06TurwWPF1oMckWayrbWUUc5vOPM9UlNCb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:02.2197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1c6fed-354d-4918-60c3-08dd865c6993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
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

From: Jesse Agate <jesse.agate@amd.com>

[Why & How]
When always scale flag is set at the API level, the number of taps
should not be overridden to zero in the identity scaling ratio case,
and luma scale should not be set to bypass regardless of luma scale
ratio

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Jesse Agate <jesse.agate@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 25 +++++++++++---------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 28348734d900..002eb926cca4 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -776,7 +776,7 @@ static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
 	 * Do not bypass UV at 1:1 for cositing to be applied
 	 */
 	if (!enable_isharp) {
-		if (data->ratios.horz.value == one && data->ratios.vert.value == one)
+		if (data->ratios.horz.value == one && data->ratios.vert.value == one && !spl_in->basic_out.always_scale)
 			return SCL_MODE_SCALING_420_LUMA_BYPASS;
 	}
 
@@ -884,7 +884,7 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 
 /* Calculate number of tap with adaptive scaling off */
 static void spl_get_taps_non_adaptive_scaler(
-	  struct spl_scratch *spl_scratch, const struct spl_taps *in_taps)
+	  struct spl_scratch *spl_scratch, const struct spl_taps *in_taps, bool always_scale)
 {
 	bool check_max_downscale = false;
 
@@ -944,15 +944,15 @@ static void spl_get_taps_non_adaptive_scaler(
 		spl_fixpt_from_fraction(6, 1));
 	SPL_ASSERT(check_max_downscale);
 
-	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz))
+
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz) && !always_scale)
 		spl_scratch->scl_data.taps.h_taps = 1;
-	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert))
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert) && !always_scale)
 		spl_scratch->scl_data.taps.v_taps = 1;
-	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c))
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !always_scale)
 		spl_scratch->scl_data.taps.h_taps_c = 1;
-	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c))
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c) && !always_scale)
 		spl_scratch->scl_data.taps.v_taps_c = 1;
-
 }
 
 /* Calculate optimal number of taps */
@@ -965,13 +965,15 @@ static bool spl_get_optimal_number_of_taps(
 	unsigned int max_taps_y, max_taps_c;
 	unsigned int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
-	bool skip_easf = false;
+	bool skip_easf     = false;
+	bool always_scale  = spl_in->basic_out.always_scale;
 	bool is_subsampled = spl_is_subsampled_format(spl_in->basic_in.format);
 
+
 	if (spl_scratch->scl_data.viewport.width > spl_scratch->scl_data.h_active &&
 		max_downscale_src_width != 0 &&
 		spl_scratch->scl_data.viewport.width > max_downscale_src_width) {
-		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps);
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, always_scale);
 		*enable_easf_v = false;
 		*enable_easf_h = false;
 		*enable_isharp = false;
@@ -980,7 +982,7 @@ static bool spl_get_optimal_number_of_taps(
 
 	/* Disable adaptive scaler and sharpener when integer scaling is enabled */
 	if (spl_in->scaling_quality.integer_scaling) {
-		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps);
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, always_scale);
 		*enable_easf_v = false;
 		*enable_easf_h = false;
 		*enable_isharp = false;
@@ -996,7 +998,7 @@ static bool spl_get_optimal_number_of_taps(
 	 * taps = 4 for upscaling
 	 */
 	if (skip_easf)
-		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps);
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, always_scale);
 	else {
 		if (spl_is_video_format(spl_in->basic_in.format)) {
 			spl_scratch->scl_data.taps.h_taps = 6;
@@ -1898,3 +1900,4 @@ bool SPL_NAMESPACE(spl_get_number_of_taps(struct spl_in *spl_in, struct spl_out
 	spl_set_taps_data(dscl_prog_data, data);
 	return res;
 }
+
-- 
2.43.0

