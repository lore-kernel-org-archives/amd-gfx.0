Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAC2E77198
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BE510EB0F;
	Tue,  7 Jan 2025 15:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4yjauEdk";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E0510EB0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4jI1vqqDyQjEVbvN71BkYpmaw33/DAzEzQL3GwhGLm2P7F23GAtbmH1CLt2UbjjbkQLEnGjFM7NZIfrNNtlQnaZfX/dxu8Y4/ioJK2CN8fl3GXcQoIzFjL50pekFgr+U4uvRLQYwZYeSygHDbjItXsx4TALF6/76Eq366LEXxRD1Vju1nCqlRLbVhoX4r9ubrLn9GEciMsU0c4pQs9ybBXI2gN1dynlq5HsA8Z80zGsGuQjITVJqHvAQJEscC//UaBbGoRE+bjTHv0YZ9SxJ51IAtO8iU9/FV73rE2cnnjcZVe/V4B1l9nve1e5Bt1E8s01iZWTIJDgzQsu6hJ+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSD+4M/EyC6VkETwUs0HbQ1yssFPfuUM44cffWDdOmM=;
 b=Fl61fYfNyFxH+7FE0iY7iHHq94FPNJMQj0yRGwuveAlqYFJE75NVZewk9190V5Oy3QsBFpEBwpKRD/HN3Ho1rU0KsTd0CB9+ZBw+ONWF02a0itSSqPFIFE7co13midGNl4s1v7l8rD1t5JjOHuDScuP4d4TY89T/YEchL8RDCqBMvjOJa8eWmviFXsPYKBKoWMmcKKOnsptDAj4FTB3a37BV0a+rV1g4MahtXSxNu9p6p+GIlvnlIvUI+DgeRef73FzlW+X9NjDhq2lHcwMyy94xcQaAeKDDjROexffSgo5gwL11xSqZ+KB5mZVztty7aL2RCpinaSDmix+MqhAtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSD+4M/EyC6VkETwUs0HbQ1yssFPfuUM44cffWDdOmM=;
 b=4yjauEdkeELSM7CtpyHaQcsoT5UjootVJprxUwZqtrx+RAeSxWgDq6wpgSeh8/l3DzWlz375dgt2UP7pcRiDBm9imM3csrdnmZ6oIyBb7GFVZkJ07+E2iuq/CotI8d0skgwm/q07Zki7UEHDfomNWddYjpra0sPHcdsyoBiHepM=
Received: from MN2PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:23a::28)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:30:45 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::1) by MN2PR03CA0023.outlook.office365.com
 (2603:10b6:208:23a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 15:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:43 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:40 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 21/24] drm/amd/display: Apply DML21 Patches
Date: Tue, 7 Jan 2025 23:28:52 +0800
Message-ID: <20250107152855.2953302-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: a61b0c48-b082-4f42-4bbc-08dd2f304097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|30052699003|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iGnmkUNK8dr7Z339hoghSFhE8ZgSgNkL54VfZDYBXXAHXckWxI3+QJKmNuxc?=
 =?us-ascii?Q?7aTHOfZdyRZetgjXfNyYpmw4BSeHiH9l7lZD6/0XNhw2hsszKanZ6KvKwaAZ?=
 =?us-ascii?Q?OhThheCwkvU8h6mkzsexivGc5M3WwB3oK4qrydSDfa2dNNE08aOGONqvXrQD?=
 =?us-ascii?Q?W6wT/ZyWO5YwFBBw7GWCkUIVB0nnGlPsxtnnQcU4LepjMi8cwa+YNAZDjqZZ?=
 =?us-ascii?Q?4ED5K51OggjiQmLoxLLMbWKoj1Nj1udmsuBn0U4n5FglFwhspgRjV5cqq+LQ?=
 =?us-ascii?Q?ADxKqK4xHUPaohqfvIlsiprer/kdRQRKtXPAHJcwP08apnay7ypvRblkAkgO?=
 =?us-ascii?Q?1Q0b7ct5dtbf8AI+wYF9FyAwV2ANgEzdAre/XOSvHRLOie/JTk7uY9ZsjtLD?=
 =?us-ascii?Q?xZkTSz1yTPPm6xrST4r7EZ4v8GdG7kOW7vqeXErT8Fu8lEtuy87N90yPPuKA?=
 =?us-ascii?Q?9AjqVzpybnSzZ8lNA3OoOogfO4HofgFXyHSfdz+VeE2hPVdrXIi7N7R03k9A?=
 =?us-ascii?Q?n9y4LgNBNckqD9sZvBH11z6rO9u+qa5CfLVd6jQFp8zIzU/IM6TMSUXsP+gh?=
 =?us-ascii?Q?EPyvB/WtnpYlTxuKl94/zX6ZqOj1eXflp3VvQQSnV9jAqPmTdPk7czKP3nK4?=
 =?us-ascii?Q?KIYnjwtmsoH9FN1tKlPPSn/2NBjy8iaOvYRSN65emoLiZeMKIx/Ugd2hATOU?=
 =?us-ascii?Q?8SM+vkVrIY9qDi4h2PzAqeFYBYklJexyCpfqmrrO6xc8irPeqTL5GB/WCztJ?=
 =?us-ascii?Q?XjuGhDG2mim2Fucr7kjdbnzKbjZ8CQ49W/KzMVWliZmqDOF8y4fFyEJNwN1+?=
 =?us-ascii?Q?OgmeN08enTlbNwyxOo5uayumJwqw2OAni/ObK7q63Da8h5Ab1N+XRI1I6zf/?=
 =?us-ascii?Q?g57v5NXzBcJ0mSUBfi06I3BgyRJRXoZVMH6NSbVRzalxqqwFqC5v2nt3VSTV?=
 =?us-ascii?Q?Y7EolaUmsagvdN1fqYOOtbRTrxu9zO4O3SyPXG6j4T1j0n2oWu6WD17AbS+5?=
 =?us-ascii?Q?Nl9H/rQLphK8RXy29KAom+R7fXao14X/FOS+XwkQnO0LsdD/9MT+LGKGKlUV?=
 =?us-ascii?Q?IxC6OMBDqU0hxyfyvoxFyVyJPm+Xoo3xB5GeREGmGEiVUjC9ScUnpuxBrABN?=
 =?us-ascii?Q?Q+O77kdSqhi6qi67xVwoymXmWsbl1/3wCFfomr80cy5chCTjTN25SfDeA9ny?=
 =?us-ascii?Q?amCsJHVGdxyu5Vu11TsECoVMohZpyXSJaCChNODjcYOFGTxlH6qVVhhjhLkR?=
 =?us-ascii?Q?T09YxGpZi7xAkxIFOUJ2uAS4JjsCo982Md3hY4EkqZs3yCiO2BIIKTQ1v2Hy?=
 =?us-ascii?Q?7/yGdlyfIDoUFN1chWBlDv5t6M4SpEaxERyaXoBTvuu6KIflqeFAisH5jFY8?=
 =?us-ascii?Q?Bogpn1im9IO+WVFQUAA3n//izQ/YbK5Rm/Yq7y9WyInpbTrIuLRsFerJJTMz?=
 =?us-ascii?Q?QbEl4szr50NPL/WZ/jOswu/t2G/stotiKpcLQTRLkOnk9Y2gnMIYdZT7O6nC?=
 =?us-ascii?Q?Jdsdkjf4zMRoVU0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(30052699003)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:44.4290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61b0c48-b082-4f42-4bbc-08dd2f304097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why & How]
Add several DML21 fixes

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 107 ++++++++++++++++--
 .../src/dml2_core/dml2_core_shared_types.h    |   6 +-
 .../dml21/src/dml2_core/dml2_core_utils.c     |   2 +-
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |   6 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  10 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   1 -
 .../dml2/dml21/src/dml2_top/dml2_top_legacy.c |   6 +
 .../dml2/dml21/src/dml2_top/dml2_top_soc15.c  |   1 +
 .../dml2/dml21/src/dml2_top/dml2_top_soc15.h  |   1 +
 .../src/inc/dml2_internal_shared_types.h      |   2 -
 10 files changed, 124 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index a3ffb8c95d25..c4dbf27abaf8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -3528,10 +3528,9 @@ static void CalculateUrgentBurstFactor(
 	dml2_printf("DML::%s: UrgentBurstFactorChroma = %f\n", __func__, *UrgentBurstFactorChroma);
 	dml2_printf("DML::%s: NotEnoughUrgentLatencyHiding = %d\n", __func__, *NotEnoughUrgentLatencyHiding);
 #endif
-
 }
 
-static void CalculateDCFCLKDeepSleep(
+static void CalculateDCFCLKDeepSleepTdlut(
 	const struct dml2_display_cfg *display_cfg,
 	unsigned int NumberOfActiveSurfaces,
 	unsigned int BytePerPixelY[],
@@ -3546,6 +3545,10 @@ static void CalculateDCFCLKDeepSleep(
 	double ReadBandwidthChroma[],
 	unsigned int ReturnBusWidth,
 
+	double dispclk,
+	unsigned int tdlut_bytes_to_deliver[],
+	double prefetch_swath_time_us[],
+
 	// Output
 	double *DCFClkDeepSleep)
 {
@@ -3580,6 +3583,22 @@ static void CalculateDCFCLKDeepSleep(
 		}
 		DCFClkDeepSleepPerSurface[k] = math_max2(DCFClkDeepSleepPerSurface[k], pixel_rate_mhz / 16);
 
+		// adjust for 3dlut delivery time
+		if (display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut && tdlut_bytes_to_deliver[k] > 0) {
+			double tdlut_required_deepsleep_dcfclk = (double) tdlut_bytes_to_deliver[k] / 64.0 / prefetch_swath_time_us[k];
+
+			dml2_printf("DML::%s: k=%d, DCFClkDeepSleepPerSurface = %f\n", __func__, k, DCFClkDeepSleepPerSurface[k]);
+			dml2_printf("DML::%s: k=%d, tdlut_bytes_to_deliver = %d\n", __func__, k, tdlut_bytes_to_deliver[k]);
+			dml2_printf("DML::%s: k=%d, prefetch_swath_time_us = %f\n", __func__, k, prefetch_swath_time_us[k]);
+			dml2_printf("DML::%s: k=%d, tdlut_required_deepsleep_dcfclk = %f\n", __func__, k, tdlut_required_deepsleep_dcfclk);
+
+			// increase the deepsleep dcfclk to match the original dispclk throughput rate
+			if (tdlut_required_deepsleep_dcfclk > DCFClkDeepSleepPerSurface[k]) {
+				DCFClkDeepSleepPerSurface[k] = math_max2(DCFClkDeepSleepPerSurface[k], tdlut_required_deepsleep_dcfclk);
+				DCFClkDeepSleepPerSurface[k] = math_max2(DCFClkDeepSleepPerSurface[k], dispclk / 4.0);
+			}
+		}
+
 #ifdef __DML_VBA_DEBUG__
 		dml2_printf("DML::%s: k=%u, PixelClock = %f\n", __func__, k, pixel_rate_mhz);
 		dml2_printf("DML::%s: k=%u, DCFClkDeepSleepPerSurface = %f\n", __func__, k, DCFClkDeepSleepPerSurface[k]);
@@ -3602,9 +3621,56 @@ static void CalculateDCFCLKDeepSleep(
 	for (unsigned int k = 0; k < NumberOfActiveSurfaces; ++k) {
 		*DCFClkDeepSleep = math_max2(*DCFClkDeepSleep, DCFClkDeepSleepPerSurface[k]);
 	}
+
 	dml2_printf("DML::%s: DCFClkDeepSleep = %f (final)\n", __func__, *DCFClkDeepSleep);
 }
 
+static void CalculateDCFCLKDeepSleep(
+	const struct dml2_display_cfg *display_cfg,
+	unsigned int NumberOfActiveSurfaces,
+	unsigned int BytePerPixelY[],
+	unsigned int BytePerPixelC[],
+	unsigned int SwathWidthY[],
+	unsigned int SwathWidthC[],
+	unsigned int DPPPerSurface[],
+	double PSCL_THROUGHPUT[],
+	double PSCL_THROUGHPUT_CHROMA[],
+	double Dppclk[],
+	double ReadBandwidthLuma[],
+	double ReadBandwidthChroma[],
+	unsigned int ReturnBusWidth,
+
+	// Output
+	double *DCFClkDeepSleep)
+{
+	double zero_double[DML2_MAX_PLANES];
+	unsigned int zero_integer[DML2_MAX_PLANES];
+
+	memset(zero_double, 0, DML2_MAX_PLANES * sizeof(double));
+	memset(zero_integer, 0, DML2_MAX_PLANES * sizeof(unsigned int));
+
+	CalculateDCFCLKDeepSleepTdlut(
+		display_cfg,
+		NumberOfActiveSurfaces,
+		BytePerPixelY,
+		BytePerPixelC,
+		SwathWidthY,
+		SwathWidthC,
+		DPPPerSurface,
+		PSCL_THROUGHPUT,
+		PSCL_THROUGHPUT_CHROMA,
+		Dppclk,
+		ReadBandwidthLuma,
+		ReadBandwidthChroma,
+		ReturnBusWidth,
+		0,
+		zero_integer, //tdlut_bytes_to_deliver,
+		zero_double, //prefetch_swath_time_us,
+
+		// Output
+		DCFClkDeepSleep);
+}
+
 static double CalculateWriteBackDelay(
 	enum dml2_source_format_class WritebackPixelFormat,
 	double WritebackHRatio,
@@ -4604,6 +4670,7 @@ static void calculate_tdlut_setting(
 		*p->tdlut_groups_per_2row_ub = 0;
 		*p->tdlut_opt_time = 0;
 		*p->tdlut_drain_time = 0;
+		*p->tdlut_bytes_to_deliver = 0;
 		*p->tdlut_bytes_per_group = 0;
 		*p->tdlut_pte_bytes_per_frame = 0;
 		*p->tdlut_bytes_per_frame = 0;
@@ -4672,6 +4739,7 @@ static void calculate_tdlut_setting(
 		*p->tdlut_groups_per_2row_ub = (unsigned int)math_ceil2((double) *p->tdlut_bytes_per_frame / *p->tdlut_bytes_per_group, 1);
 		*p->tdlut_opt_time = (*p->tdlut_bytes_per_frame - p->cursor_buffer_size * 1024) / tdlut_drain_rate;
 		*p->tdlut_drain_time = p->cursor_buffer_size * 1024 / tdlut_drain_rate;
+		*p->tdlut_bytes_to_deliver = (unsigned int) (p->cursor_buffer_size * 1024.0);
 	}
 
 #ifdef __DML_VBA_DEBUG__
@@ -4692,6 +4760,7 @@ static void calculate_tdlut_setting(
 	dml2_printf("DML::%s: tdlut_delivery_cycles = %u\n", __func__, tdlut_delivery_cycles);
 	dml2_printf("DML::%s: tdlut_opt_time = %f\n", __func__, *p->tdlut_opt_time);
 	dml2_printf("DML::%s: tdlut_drain_time = %f\n", __func__, *p->tdlut_drain_time);
+	dml2_printf("DML::%s: tdlut_bytes_to_deliver = %d\n", __func__, *p->tdlut_bytes_to_deliver);
 	dml2_printf("DML::%s: tdlut_groups_per_2row_ub = %d\n", __func__, *p->tdlut_groups_per_2row_ub);
 #endif
 }
@@ -5700,6 +5769,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 
 		s->cursor_prefetch_bytes = (unsigned int)math_max2(p->cursor_bytes_per_chunk, 4 * p->cursor_bytes_per_line);
 		*p->prefetch_cursor_bw = p->num_cursors * s->cursor_prefetch_bytes / (s->LinesToRequestPrefetchPixelData * s->LineTime);
+		*p->prefetch_swath_time_us = (s->LinesToRequestPrefetchPixelData * s->LineTime);
 
 #ifdef __DML_VBA_DEBUG__
 		dml2_printf("DML::%s: TimeForFetchingVM = %f\n", __func__, s->TimeForFetchingVM);
@@ -5710,6 +5780,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 		dml2_printf("DML::%s: dst_y_per_row_vblank = %f\n", __func__, *p->dst_y_per_row_vblank);
 		dml2_printf("DML::%s: LinesToRequestPrefetchPixelData = %f\n", __func__, s->LinesToRequestPrefetchPixelData);
 		dml2_printf("DML::%s: PrefetchSourceLinesY = %f\n", __func__, p->PrefetchSourceLinesY);
+		dml2_printf("DML::%s: prefetch_swath_time_us = %f\n", __func__, *p->prefetch_swath_time_us);
 
 		dml2_printf("DML::%s: cursor_bytes_per_chunk = %d\n", __func__, p->cursor_bytes_per_chunk);
 		dml2_printf("DML::%s: cursor_bytes_per_line = %d\n", __func__, p->cursor_bytes_per_line);
@@ -8817,6 +8888,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			calculate_tdlut_setting_params->tdlut_groups_per_2row_ub = &s->tdlut_groups_per_2row_ub[k];
 			calculate_tdlut_setting_params->tdlut_opt_time = &s->tdlut_opt_time[k];
 			calculate_tdlut_setting_params->tdlut_drain_time = &s->tdlut_drain_time[k];
+			calculate_tdlut_setting_params->tdlut_bytes_to_deliver = &s->tdlut_bytes_to_deliver[k];
 			calculate_tdlut_setting_params->tdlut_bytes_per_group = &s->tdlut_bytes_per_group[k];
 
 			calculate_tdlut_setting(&mode_lib->scratch, calculate_tdlut_setting_params);
@@ -9009,6 +9081,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 				CalculatePrefetchSchedule_params->prefetch_sw_bytes = &s->prefetch_sw_bytes[k];
 				CalculatePrefetchSchedule_params->Tpre_rounded = &s->Tpre_rounded[k];
 				CalculatePrefetchSchedule_params->Tpre_oto = &s->Tpre_oto[k];
+				CalculatePrefetchSchedule_params->prefetch_swath_time_us = &s->prefetch_swath_time_us[k];
 
 				mode_lib->ms.NoTimeForPrefetch[k] = CalculatePrefetchSchedule(&mode_lib->scratch, CalculatePrefetchSchedule_params);
 
@@ -9017,6 +9090,27 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 				dml2_printf("DML::%s: k=%d, dst_y_per_row_vblank = %f\n", __func__, k, *CalculatePrefetchSchedule_params->dst_y_per_row_vblank);
 			} // for k num_planes
 
+			CalculateDCFCLKDeepSleepTdlut(
+				display_cfg,
+				mode_lib->ms.num_active_planes,
+				mode_lib->ms.BytePerPixelY,
+				mode_lib->ms.BytePerPixelC,
+				mode_lib->ms.SwathWidthY,
+				mode_lib->ms.SwathWidthC,
+				mode_lib->ms.NoOfDPP,
+				mode_lib->ms.PSCL_FACTOR,
+				mode_lib->ms.PSCL_FACTOR_CHROMA,
+				mode_lib->ms.RequiredDPPCLK,
+				mode_lib->ms.vactive_sw_bw_l,
+				mode_lib->ms.vactive_sw_bw_c,
+				mode_lib->soc.return_bus_width_bytes,
+				mode_lib->ms.RequiredDISPCLK,
+				s->tdlut_bytes_to_deliver,
+				s->prefetch_swath_time_us,
+
+				/* Output */
+				&mode_lib->ms.dcfclk_deepsleep);
+
 			for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
 				if (mode_lib->ms.dst_y_prefetch[k] < 2.0
 					|| mode_lib->ms.LinesForVM[k] >= 32.0
@@ -10368,12 +10462,6 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 	dml2_assert(s->SOCCLK > 0);
 
 #ifdef __DML_VBA_DEBUG__
-	// dml2_printf_dml_display_cfg_timing(&display_cfg->timing, s->num_active_planes);
-	// dml2_printf_dml_display_cfg_plane(&display_cfg->plane, s->num_active_planes);
-	// dml2_printf_dml_display_cfg_surface(&display_cfg->surface, s->num_active_planes);
-	// dml2_printf_dml_display_cfg_output(&display_cfg->output, s->num_active_planes);
-	// dml2_printf_dml_display_cfg_hw_resource(&display_cfg->hw, s->num_active_planes);
-
 	dml2_printf("DML::%s: num_active_planes = %u\n", __func__, s->num_active_planes);
 	dml2_printf("DML::%s: num_active_pipes = %u\n", __func__, mode_lib->mp.num_active_pipes);
 	dml2_printf("DML::%s: Dcfclk = %f\n", __func__, mode_lib->mp.Dcfclk);
@@ -10832,8 +10920,8 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 		calculate_tdlut_setting_params->tdlut_groups_per_2row_ub = &s->tdlut_groups_per_2row_ub[k];
 		calculate_tdlut_setting_params->tdlut_opt_time = &s->tdlut_opt_time[k];
 		calculate_tdlut_setting_params->tdlut_drain_time = &s->tdlut_drain_time[k];
+		calculate_tdlut_setting_params->tdlut_bytes_to_deliver = &s->tdlut_bytes_to_deliver[k];
 		calculate_tdlut_setting_params->tdlut_bytes_per_group = &s->tdlut_bytes_per_group[k];
-
 		calculate_tdlut_setting(&mode_lib->scratch, calculate_tdlut_setting_params);
 	}
 
@@ -11219,6 +11307,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			CalculatePrefetchSchedule_params->prefetch_sw_bytes = &s->prefetch_sw_bytes[k];
 			CalculatePrefetchSchedule_params->Tpre_rounded = &s->Tpre_rounded[k];
 			CalculatePrefetchSchedule_params->Tpre_oto = &s->Tpre_oto[k];
+			CalculatePrefetchSchedule_params->prefetch_swath_time_us = &s->dummy_single[0];
 
 			mode_lib->mp.NoTimeToPrefetch[k] = CalculatePrefetchSchedule(&mode_lib->scratch, CalculatePrefetchSchedule_params);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index 4f54e54102ef..23c0fca5515f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -958,6 +958,7 @@ struct dml2_core_calcs_mode_support_locals {
 	unsigned int tdlut_groups_per_2row_ub[DML2_MAX_PLANES];
 	double tdlut_opt_time[DML2_MAX_PLANES];
 	double tdlut_drain_time[DML2_MAX_PLANES];
+	unsigned int tdlut_bytes_to_deliver[DML2_MAX_PLANES];
 	unsigned int tdlut_bytes_per_group[DML2_MAX_PLANES];
 
 	unsigned int cursor_bytes_per_chunk[DML2_MAX_PLANES];
@@ -979,6 +980,7 @@ struct dml2_core_calcs_mode_support_locals {
 	enum dml2_source_format_class pixel_format[DML2_MAX_PLANES];
 	unsigned int lb_source_lines_l[DML2_MAX_PLANES];
 	unsigned int lb_source_lines_c[DML2_MAX_PLANES];
+	double prefetch_swath_time_us[DML2_MAX_PLANES];
 };
 
 struct dml2_core_calcs_mode_programming_locals {
@@ -1042,6 +1044,7 @@ struct dml2_core_calcs_mode_programming_locals {
 	unsigned int tdlut_groups_per_2row_ub[DML2_MAX_PLANES];
 	double tdlut_opt_time[DML2_MAX_PLANES];
 	double tdlut_drain_time[DML2_MAX_PLANES];
+	unsigned int tdlut_bytes_to_deliver[DML2_MAX_PLANES];
 	unsigned int tdlut_bytes_per_group[DML2_MAX_PLANES];
 
 	unsigned int cursor_bytes_per_chunk[DML2_MAX_PLANES];
@@ -1809,6 +1812,7 @@ struct dml2_core_calcs_CalculatePrefetchSchedule_params {
 	unsigned int *VReadyOffsetPix;
 	double *prefetch_cursor_bw;
 	double *prefetch_sw_bytes;
+	double *prefetch_swath_time_us;
 };
 
 struct dml2_core_calcs_CheckGlobalPrefetchAdmissibility_params {
@@ -1993,6 +1997,7 @@ struct dml2_core_calcs_calculate_tdlut_setting_params {
 	unsigned int *tdlut_groups_per_2row_ub;
 	double *tdlut_opt_time;
 	double *tdlut_drain_time;
+	unsigned int *tdlut_bytes_to_deliver;
 	unsigned int *tdlut_bytes_per_group;
 };
 
@@ -2137,7 +2142,6 @@ struct dml2_core_calcs_mode_programming_ex {
 	const struct core_display_cfg_support_info *cfg_support_info;
 	int min_clk_index;
 	struct dml2_display_cfg_programming *programming;
-
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
index 1548dfc68b8e..456b3f8a6d38 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
@@ -556,7 +556,7 @@ bool dml2_core_utils_is_dual_plane(enum dml2_source_format_class source_format)
 {
 	bool ret_val = 0;
 
-	if ((source_format == dml2_420_12) || (source_format == dml2_420_8) || (source_format == dml2_420_10) || (source_format == dml2_rgbe_alpha))
+	if (dml2_core_utils_is_420(source_format) || dml2_core_utils_is_422_planar(source_format) || (source_format == dml2_rgbe_alpha))
 		ret_val = 1;
 
 	return ret_val;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index 655d1ef56814..e763c8e45da8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -347,8 +347,12 @@ static int find_highest_odm_load_stream_index(
 	int odm_load, highest_odm_load = -1, highest_odm_load_index = -1;
 
 	for (i = 0; i < display_config->num_streams; i++) {
-		odm_load = display_config->stream_descriptors[i].timing.pixel_clock_khz
+		if (mode_support_result->cfg_support_info.stream_support_info[i].odms_used > 0)
+			odm_load = display_config->stream_descriptors[i].timing.pixel_clock_khz
 				/ mode_support_result->cfg_support_info.stream_support_info[i].odms_used;
+		else
+			odm_load = 0;
+
 		if (odm_load > highest_odm_load) {
 			highest_odm_load_index = i;
 			highest_odm_load = odm_load;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 94609f9c18eb..a3324f7b9ba6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -813,8 +813,12 @@ static int find_highest_odm_load_stream_index(
 	int odm_load, highest_odm_load = -1, highest_odm_load_index = -1;
 
 	for (i = 0; i < display_config->num_streams; i++) {
-		odm_load = display_config->stream_descriptors[i].timing.pixel_clock_khz
+		if (mode_support_result->cfg_support_info.stream_support_info[i].odms_used > 0)
+			odm_load = display_config->stream_descriptors[i].timing.pixel_clock_khz
 				/ mode_support_result->cfg_support_info.stream_support_info[i].odms_used;
+		else
+			odm_load = 0;
+
 		if (odm_load > highest_odm_load) {
 			highest_odm_load_index = i;
 			highest_odm_load = odm_load;
@@ -1372,7 +1376,7 @@ static bool is_config_schedulable(
 			if (j_disallow_us < jp1_disallow_us) {
 				/* swap as A < B */
 				swap(s->pmo_dcn4.sorted_group_gtl_disallow_index[j],
-					 s->pmo_dcn4.sorted_group_gtl_disallow_index[j+1]);
+					 s->pmo_dcn4.sorted_group_gtl_disallow_index[j + 1]);
 				swapped = true;
 			}
 		}
@@ -1431,7 +1435,7 @@ static bool is_config_schedulable(
 			if (j_period_us < jp1_period_us) {
 				/* swap as A < B */
 				swap(s->pmo_dcn4.sorted_group_gtl_period_index[j],
-					 s->pmo_dcn4.sorted_group_gtl_period_index[j+1]);
+					 s->pmo_dcn4.sorted_group_gtl_period_index[j + 1]);
 				swapped = true;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_interfaces.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_interfaces.c
index 5f6dfc24df69..f88931ccbc5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_interfaces.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_interfaces.c
@@ -15,7 +15,6 @@ bool dml2_initialize_instance(struct dml2_initialize_instance_in_out *in_out)
 {
 	switch (in_out->options.project_id) {
 	case dml2_project_dcn4x_stage1:
-		return false;
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
 		return dml2_top_soc15_initialize_instance(in_out);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_legacy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_legacy.c
index db0a30fdb58d..5e14d85821e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_legacy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_legacy.c
@@ -2,3 +2,9 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
 
+#include "dml2_top_legacy.h"
+#include "dml2_top_soc15.h"
+#include "dml2_core_factory.h"
+#include "dml2_pmo_factory.h"
+#include "display_mode_core_structs.h"
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.c
index b39029c0e56f..a8f58f8448e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.c
@@ -545,6 +545,7 @@ bool dml2_top_mcache_validate_admissability(struct top_mcache_validate_admissabi
 		if (odm_combine_factor > 1) {
 			max_per_pipe_vp_p0 = plane->surface.plane0.width;
 			temp = (unsigned int)math_ceil(plane->composition.scaler_info.plane0.h_ratio * stream->timing.h_active / odm_combine_factor);
+
 			if (temp < max_per_pipe_vp_p0)
 				max_per_pipe_vp_p0 = temp;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.h
index 6fda201af898..53bd8602f9ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: MIT
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
+
 #ifndef __DML2_TOP_SOC15_H__
 #define __DML2_TOP_SOC15_H__
 #include "dml2_internal_shared_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
index d94b310d6eec..7fb6026bcb49 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
@@ -357,8 +357,6 @@ struct dml2_pmo_pstate_strategy {
 	enum dml2_pstate_method per_stream_pstate_method[DML2_MAX_PLANES];
 	bool allow_state_increase;
 };
-
-
 struct dml2_core_mode_support_in_out {
 	/*
 	* Inputs
-- 
2.34.1

