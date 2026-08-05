Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8996AC561E6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258A810ED16;
	Wed,  5 Aug 2026 06:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GlQQnX5p";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F49E10ED16
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/peUuFFhFLg0Mwmyh/1INxNqvIezaUk7qKUbw3GRdP/Z5ajMkeMwTjUUUY482CLlrbhB9+dv8l91CbLZSsbk77piL8Cwo064Hb2xNGWmcqTJYl3yIOO0TCUe/J+XTpcHHPvBxI2YKfYAyMMKdwJKf4TsOm0MCwgpYbY4WXZOafTyuawTCa2p6RLjq7Ka5YUS0NjPzeEOX2Zq+BKj3U3a/+tbWhEDOFGXOmB4FEfIcnAfO1FKg5dwspDBnWrPYVCFOkju1atp2D4A5FQMLZCU76vzYkl19RSi9vHHuTeM/WdCjuB6ElRpe7IWrQD7pGBnbIFbyEglXfuDWRNhnWyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB0Z29PnhYP6rVpruusqFGMq/VmUQ/TAynIPnWumZ5s=;
 b=RsKIgeixvWZHkwi467+zFa26bJMF8WZG7bn7Idf583XNfHPues/b3tnBm1N+KwOywVo0VJHZ1YuuerbJy+aflKU7lV6sZp7EMZQf/b+WuznYETv2cV63JERfUfU9wq9NTNYF7Lo5c+IOSiuiB9HroZMDj46QNxfnpfqIG4/+Jd/UTPvngfQzNImO4TOkoTN8DAOcjU1EJJZEOmIEl7PrYYc2xElh6syS/d4VPdDgRAQxJzBL83RDZ6n4LMc6Oy5xkNnTofIChYYddpa1Ad0ktBxP8p87qsZ5xQJn8jWEkjM5NJgTUdBeHSCbE0U3C6vqTD7b4IysKHQkQwCIgQ4LkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB0Z29PnhYP6rVpruusqFGMq/VmUQ/TAynIPnWumZ5s=;
 b=GlQQnX5pRST4vsY/Sl65niXr+1d/KCc7BNrv99jLh9M0h8r037ceh7Dz+83zB2dKLCIlLDtjNcqMdYIrkexrHo7XmUWSZ+HNMnV1gcIu38d27ebaZCeWTN3PRb1tuVbJizRT0Rp0X7UTkcrMec4k1FvqXR3qnLpMQY0gNjeWBoo=
Received: from MW4PR03CA0227.namprd03.prod.outlook.com (2603:10b6:303:b9::22)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:41:58 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::52) by MW4PR03CA0227.outlook.office365.com
 (2603:10b6:303:b9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Wed, 5
 Aug 2026 06:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:56 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:52 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 30/34] drm/amd/display: Fix DCN6 peak bandwidth measurement
 overshoot
Date: Wed, 5 Aug 2026 14:36:42 +0800
Message-ID: <20260805063937.2145774-31-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 638cf0c0-17d9-4f07-ae42-08def2bca543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|82310400026|1800799024|376014|36860700016|23010399003|22082099003|6133799003|18002099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: vFQaAOn8WtsvA+WRN/WI7AKU+qlvNnfmHZDB6e+Qz907AwCEQd64TFY5pmYtTDMUcF5IfdwMcm2Vk0UsGbN0VrWbnSnqVx2dScZPxndky5vZZFsI71zBwXIdYZNsWtr5BdlaikT042kxp1QiqGlCENY2pbYo2FWT4+sb0AwaDkQ6HqLUmmsColPDJNrOe6Vzksx3Rykdy1Cir4lthDCp5gpXdmZ4yyKX7dGaNx6tn76t3Qcf0QBTLZk3IETLu/MYk2qsn15drw3PFhm8W5jSN/qzYYvd1S44p6RWDs3TFEaz5deRujmwKU5V9R/vcbBzNoREizLswTQfi6wyV25QbTRebx9ZzctGsTEkJZhBjVpPnQ7fkS6aeTCH7VoJmydRoX9O+4PoIPtlDVesMDxm+b2B6cLtiEFz94sUZtMSp9MR9U3bKQHCYNko901xICtUQKDB+/7FrdNcdWlu3IgAJC+fHBwt5rNexzjXBbqZkqDEuF0Aabk7roA+L03zKUPQlrc5+sge1UAdwfju1RqQ68E+O9CqOZEEn9JWybbKU3t+Yy0VVBqykYtZL/VHX3gG/dqqa+RBktXmu9r1D1YewKYOduJ9MfXbt14YPmnfCBmsIuefQsI/zSvWzRC49esaaVvfqlyCldC+iftA8D0VAcA1TscamMOTGE2uoQ5RWHwvipCdEmAuM3XQdzIbSaHlsoVNLsHf4fGSfg8lyDikuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +xiSkLnTSeB6xct64sIQI2irXgxMuXshXvz9LkW7VL0ApS0RYcZiFPFq4sftjOAeb6NePNRWnsp27eeLt55X9TdKZmgc8WzI6jzAtMdrfAngzepySGK2+sWE+9XV6WjkhjA8ET0V5FL8ivMBQ0Es3AdUX9DE6FEb39JDbLlLsExhp7TCXytpClyF0obchkWjVSywi5b35DukInm87zB9KFRX9OJEx7yhfDp25+FPka4SIvw3+QtCUkoQRKBG5CjHTvVh/z8NY2jiUrCBOUwJH53hZgfTEBS2UhnFGTOd4Vq918QN9MUSbwx9fSzAc0Q9iafMx5BOfulAkX5BV+LqllcK5y9e1acTOh7zaOT2AayF7o7jY8A5johx3vqDcz5ls0LQ5c8w7GzMQxDl5HR6gscaps2cO2Js65NYnfSu3B3O7OLNuEWdedzchQvBI7u9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:57.2297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 638cf0c0-17d9-4f07-ae42-08def2bca543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The out-of-order (peak prefetch) bandwidth probe could report
bandwidth far above the physical clock ceiling. The data and
duration counters could latch on different edges of the shared
stop event, and very short measurement windows amplified refclk
tick quantization into large relative errors.

[How]
Add a dedicated counter (2) that generates the single stop event
both the data counter (1) and duration counter (4) key off of, so
they always latch on the same edge. Reject samples where the data
counter overshoots the generator's target, or where the duration
is too short to trust. Also drop the single-timing-group
restriction on the peak-BW probe.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    | 96 +++++++++++++++----
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   | 10 --
 2 files changed, 75 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
index 820b156474e1..f1e6b2a1000d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
@@ -1374,21 +1374,33 @@ static uint32_t hubbub60_perfmon_get_urgent_ramp_latency_ns(
  * @hubbub: pointer to the hubbub hardware instance
  *
  * Configures the performance monitoring counters to measure out-of-order
- * (peak prefetch) bandwidth using hardware counters 0, 1, and 4:
+ * (peak prefetch) bandwidth using hardware counters 0, 1, 2, and 4:
  *
  * Counter 0: count-off counter — counts response-valid events and gates the
  *            measurement window once it reaches its target value.
  * Counter 1: data counter — tracks total data received during the measurement
- *            period; generates an interrupt when measurement completes.
+ *            period.
+ * Counter 2: target-reached generator — duplicates counter 1's event/target
+ *            and generates the interrupt that stops counters 1 and 4.
  * Counter 4: duration timer — measures elapsed time in refclk cycles.
  *
  * UTM_FILTER_SEL is set to 0 so that isolation comes from OTG-vblank gating
- * rather than the silicon-broken HW filter.  The first 200 prefetch requests
- * are skipped (ramp-up), and the subsequent 200 are the measurement window.
+ * rather than the silicon-broken HW filter.
  *
  * This function configures counters only; call
  * hubbub60_perfmon_start_measuring_out_of_order_bandwidth() to enable them.
  */
+
+/* Counter0's ramp-up target and counter1's measurement-window target,
+ * packed into PERFMON_CVALUE_LOW's low/high words respectively. Tunable via
+ * windbg (ed dcn60_debug_peak_bw_ramp_size / ed dcn60_debug_peak_bw_window_size).
+ */
+static unsigned int dcn60_debug_peak_bw_ramp_size = 0x100;
+static unsigned int dcn60_debug_peak_bw_window_size = 0x2500;
+
+/* Minimum count4 (refclk ticks) for a peak-BW sample to be trusted. */
+#define DCN60_OUT_OF_ORDER_BW_MIN_DURATION_TICKS 20
+
 static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 		struct hubbub *hubbub)
 {
@@ -1422,7 +1434,8 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 			PERFCOUNTER_HW_STOP1_SEL, 0x1, // the stop trigger is that perfcounter meet the target CVALUE
 			PERFCOUNTER_HW_STOP2_SEL, 0x0); // ignored
 
-	/* Program counter 1 to count total data received */
+	/* Program counter 1 as a passive data accumulator, slaved to the same
+	 * external stop signal as counter 4 (generated by counter 2 below). */
 	REG_SET_9(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
 			PERFCOUNTER_CNTL_SEL, 0x1, // select counter 1
 			PERFCOUNTER_EVENT_SEL, 259, // response vld
@@ -1431,13 +1444,33 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 			PERFCOUNTER_HW_CNTL_SEL, 0x1, // independent mode
 			PERFCOUNTER_RUNEN_MODE, 0x0, // counter runs as long as run_enable is high
 			PERFCOUNTER_RESTART_EN, 0x0, // stop after counting is done
-			PERFCOUNTER_INT_EN, 1, // signal when the measurement is complete
+			PERFCOUNTER_INT_EN, 0, // counter 2 now generates the interrupt
 			PERFCOUNTER_ACTIVE, 0x1);
 	REG_SET_5(DC_PERFMON5_PERFCOUNTER_CNTL2, 0,
 			PERFCOUNTER_CNTL2_SEL, 0x1,
 			PERFCOUNTER_CNTOFF_SEL, 0, // start when count0 stops
 			PERFCOUNTER_COUNTED_VALUE_TYPE, 0x0, // count the accumulated value
 			PERFCOUNTER_HW_STOP1_SEL, 0x0, // ignored
+			PERFCOUNTER_HW_STOP2_SEL, 0x1); // stop via the same external signal as counter 4
+
+	/* Counter 2 is a dedicated "target reached" generator: it duplicates
+	 * counter 1's event/target and is the sole source of the completion
+	 * interrupt driving PERFMON_RUN_ENABLE_STOP_SEL. */
+	REG_SET_9(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
+			PERFCOUNTER_CNTL_SEL, 0x2, // select counter 2
+			PERFCOUNTER_EVENT_SEL, 259, // response vld
+			PERFCOUNTER_CVALUE_SEL, 0x2, // use cvalue bits 31-16 (same window target as counter 1)
+			PERFCOUNTER_INC_MODE, 0x2, // count LSB level
+			PERFCOUNTER_HW_CNTL_SEL, 0x1, // independent mode
+			PERFCOUNTER_RUNEN_MODE, 0x0, // counter runs as long as run_enable is high
+			PERFCOUNTER_RESTART_EN, 0x0, // stop after counting is done
+			PERFCOUNTER_INT_EN, 1, // signal when the measurement is complete
+			PERFCOUNTER_ACTIVE, 0x1);
+	REG_SET_5(DC_PERFMON5_PERFCOUNTER_CNTL2, 0,
+			PERFCOUNTER_CNTL2_SEL, 0x2,
+			PERFCOUNTER_CNTOFF_SEL, 0, // start when count0 stops
+			PERFCOUNTER_COUNTED_VALUE_TYPE, 0x0, // count the accumulated value
+			PERFCOUNTER_HW_STOP1_SEL, 0x0, // ignored
 			PERFCOUNTER_HW_STOP2_SEL, 0x0); // the stop trigger is that perfcounter meet the target CVALUE
 
 	/* Program counter 4 to count the measuring time */
@@ -1458,21 +1491,21 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 			PERFCOUNTER_HW_STOP2_SEL, 0x1); // the stop trigger is from the external 64 pairs of start/stop events
 
 	/* Program perfcounter states */
-	REG_SET_6(DC_PERFMON5_PERFCOUNTER_STATE, 0,
+	REG_SET_8(DC_PERFMON5_PERFCOUNTER_STATE, 0,
 			PERFCOUNTER_STATE_SEL0, 0x1, // independent state mode
 			PERFCOUNTER_CNT0_STATE, 0x3, // hw mode
 			PERFCOUNTER_STATE_SEL1, 0x1, // independent state mode
 			PERFCOUNTER_CNT1_STATE, 0x3, // hw mode
+			PERFCOUNTER_STATE_SEL2, 0x1, // independent state mode
+			PERFCOUNTER_CNT2_STATE, 0x3, // hw mode
 			PERFCOUNTER_STATE_SEL4, 0x1, // independent state mode
 			PERFCOUNTER_CNT4_STATE, 0x3); // hw mode
 
-	/*
-	 * The cvalue is derived based on experimental results at the lowest
-	 * clock state. Out-of-order bandwidth requires ~200 prefetch requests
-	 * to ramp up to full speed; the subsequent 200 requests form the
-	 * measurement window.
-	 */
-	REG_SET(DC_PERFMON5_PERFMON_CVALUE_LOW, 0, PERFMON_CVALUE_LOW, 200 | 200 << 16);
+	/* Ramp/window sizes are derived from experimental results at the
+	 * lowest clock state. */
+	REG_SET(DC_PERFMON5_PERFMON_CVALUE_LOW, 0, PERFMON_CVALUE_LOW,
+			(dcn60_debug_peak_bw_ramp_size & 0xFFFF)
+					| (dcn60_debug_peak_bw_window_size & 0xFFFF) << 16);
 
 	REG_SET_2(DC_PERFMON5_PERFMON_CNTL2, 0,
 			PERFMON_RUN_ENABLE_START_SEL, 0x0,
@@ -1504,28 +1537,49 @@ static void hubbub60_perfmon_start_measuring_out_of_order_bandwidth(
  * @refclk_mhz: reference clock frequency in MHz, used for duration conversion
  * @duration_ns: output parameter; receives the measured duration in nanoseconds
  *
- * Reads hardware counters 1 (data) and 4 (duration) and converts the raw
- * refclk-cycle count into bandwidth in Mbps.
+ * Reads hardware counters 1 (data), 2 (target-reached generator), and 4
+ * (duration), validates the sample, and converts the raw refclk-cycle count
+ * into bandwidth in Mbps.
  *
- * Return: out-of-order bandwidth in Mbps
+ * Return: out-of-order bandwidth in Mbps, or 0 if the sample is invalid
  */
 static uint32_t hubbub60_perfmon_get_out_of_order_bandwidth_mbps(
 		struct hubbub *hubbub, uint32_t refclk_mhz, uint32_t *duration_ns)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
-	uint32_t count0 = 0, count1 = 0, count4 = 0,
+	uint32_t count1 = 0, count2 = 0, count4 = 0,
 			out_of_order_bandwidth_mbps = 0, measuring_duration_ns = 0;
 	struct fixed31_32 temp;
 
-	REG_SET(DC_PERFMON5_PERFMON_HI, 0, PERFMON_READ_SEL, 0x0);
-	REG_GET(DC_PERFMON5_PERFMON_LOW, PERFMON_LOW, &count0);
-
 	REG_SET(DC_PERFMON5_PERFMON_HI, 0, PERFMON_READ_SEL, 0x1);
 	REG_GET(DC_PERFMON5_PERFMON_LOW, PERFMON_LOW, &count1);
 
+	REG_SET(DC_PERFMON5_PERFMON_HI, 0, PERFMON_READ_SEL, 0x2);
+	REG_GET(DC_PERFMON5_PERFMON_LOW, PERFMON_LOW, &count2);
+
 	REG_SET(DC_PERFMON5_PERFMON_HI, 0, PERFMON_READ_SEL, 0x4);
 	REG_GET(DC_PERFMON5_PERFMON_LOW, PERFMON_LOW, &count4);
 
+	/* count1 should never exceed count2's target, doing so means it
+	 * missed the shared stop edge and the sample is corrupted. */
+	if (count1 > count2 + (count2 / 20)) {
+		DC_LOG_WARNING("hubbub60_perfmon_get_out_of_order_bandwidth_mbps: "
+				"count1=%u exceeds count2=%u target, discarding corrupted sample\n",
+				count1, count2);
+		if (duration_ns)
+			*duration_ns = 0;
+		return 0;
+	}
+
+	if (count4 < DCN60_OUT_OF_ORDER_BW_MIN_DURATION_TICKS) {
+		DC_LOG_WARNING("hubbub60_perfmon_get_out_of_order_bandwidth_mbps: "
+				"count4=%u below minimum %u ticks, discarding sample\n",
+				count4, DCN60_OUT_OF_ORDER_BW_MIN_DURATION_TICKS);
+		if (duration_ns)
+			*duration_ns = 0;
+		return 0;
+	}
+
 	if (refclk_mhz == 0)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index 14adf1a3a1e0..b9a046584740 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -904,16 +904,6 @@ static void dcn60_build_hubbub_perfmon_sequence(
 	if (probe->target_state != DC_PROBE_MEASURED || !ref_tg)
 		return;
 
-	/* Peak BW needs a single timing group. The out-of-order counter spans one
-	 * prefetch window, which is meaningless when streams in separate timing
-	 * groups have non-overlapping prefetch windows. */
-	if (probe->type == DC_PROBE_PEAK_MEM_BW) {
-		int group_size = context->stream_status[0].timing_sync_info.group_size;
-
-		if (group_size != context->stream_count)
-			return;
-	}
-
 	switch (probe->type) {
 	case DC_PROBE_PEAK_MEM_BW:
 		/* Start at the vblank edge and stop at the next vactive so the counter
-- 
2.43.0

