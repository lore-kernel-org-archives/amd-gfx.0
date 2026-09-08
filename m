Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE502C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4161410EB58;
	Tue,  8 Sep 2026 11:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RA+9/8+k";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4755510EB58
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isJhJg9otv+ohAv81UHKSkWtUtGnWIGEzvSCO3q4Rk+XbM99aLlza9U5/2uDqytkoMSx/e0o/sscCsmuTewQLKhq3mE5QBnY5IM9zCCDgwSIc2Ww5KRiR/SeznSXf5dquw/Ajn6JSstjlQckh+rm+yxwoL2BIscacM/AxflhAu+rGY6NhTdZBtzTl7KucDh48oUVG8fNCgzPAkPccJJLrH/vZgrP4A9qeKfPZn1suiBFwJ3wgGcvRKj9lPC6dSJ2Ar5Y/0/7yVgJsXx34pTHq/Zc4f3FV/JIN4g+227GmiafE0j6vQZJDDInbU4zv/6WjFNoF0oUIuakIoKIeX4DAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i67hC3o3sa7w7k/G0iWVourO0aifBdEqnwDCBr2JGwU=;
 b=Q+e9xJx0zIkzs+vE36DVjah9mxule70DAlifxg39LtUrwBhkqBT0HmdhF2158EBViu9xp7kxfcRFk5mCFdH+OSPKjKinZ9QCvqJ48rGpGJ697WOxIIhfOboQseRwXRbejNJtpZA/14JnQV/8icBHc3/15ZcR47oxRSDAFKesmQBamPJtmVZhokQ8oPgsY3BUJzD1TgA2o4vpyTg+LNL+uPuvu1NJV6J65PGzJ0ZNszHOd7mgNKLjdBcodIdkuupdb2/8/22+a6Lbn5ggZtWd8tNF2f7AVWyQ/fnlR9/awVpG5kWa3ODnNntEkz1tcwPiVcupkt+4lBYIZ6RG4O44Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i67hC3o3sa7w7k/G0iWVourO0aifBdEqnwDCBr2JGwU=;
 b=RA+9/8+ki7mNXfa7Qpw1RvBPfJoPYCRvuzpuNaB4CdjLaXjbWs+m7dxGnoaXvtxDNPPqSDS9haPkQ19xB2L3hVBfxJ+JPvRyDMmY4p/Zfmt6KjL/wpL5LAPtnImWVdZTnjMXgqaOuQzyc+DEbVtHvd3NpoPK0ncGb9EKVKgYnjI=
Received: from BL1PR13CA0422.namprd13.prod.outlook.com (2603:10b6:208:2c3::7)
 by CHBPR12MB497579.namprd12.prod.outlook.com (2603:10b6:610:33d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 11:39:16 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::64) by BL1PR13CA0422.outlook.office365.com
 (2603:10b6:208:2c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:39:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:39:16 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:39:07 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 37/66] drm/amd/display: Fix peak bandwidth measurement sequence
Date: Tue, 8 Sep 2026 19:31:30 +0800
Message-ID: <20260908113338.2433445-38-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|CHBPR12MB497579:EE_
X-MS-Office365-Filtering-Correlation-Id: c17c4c21-e327-4750-cd12-08df0d9dd051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|30052699003|376014|82310400026|1800799024|36860700016|10067099003|6133799003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: on+GxJBVxBg5VBjCPy0YlzNuL1qBMiQPCo7+HZDvugFihjfXWiOdO1A5ICX2JIqDH0XaMmhRdQKJ5NJTc5Q8yCBorhHk7dEQd+EtM3aiuAXQkBnGxQxauimecxzAHApK1g4YzWupUCFtrgzmsWtLV/Z3kJOaOTVT98Yb0CsOrK9cTi6NmjI91il5E/VojsaodKgvWG2DDOokCg1zzBbG46eXezvjJINxHQDN7t/FMe/nZOu51JulAjC+A8RsW6eCslTqXBDSNaWH+15j6MHbZ0yb4fDFXpuhzq0hns+Xf+OUcHQ3fRb+YV5NXlIxgvvmSDsVLKMLwx+WK3rbwBmhRvd0X+tYMn3k2g4GLKxVc4gbj42P0flOUepAVomQp+5RPv8SpiukCJv8iac2Sha7GKHAHbmd0qKc9i9+l1SbTqD/4c63/+xN5WhzxgvqWGF5B+iYIx8iXxHEDpB5X3lMiaVSeQ3vuwfmBIHUshOVF9bwEk2i0Wuk6KE8wxb35dO1K/E3YLAB2yYItVJ11GMqzCjFB4UUl+stAhPRQtHVcMb32K8mCjZldJKA6R/SLS0bPOldJ9SmKBLjeaSKcLW4XYQXbkpDVmHq2EWSeUTdQxFLuTfzj+dg+b2p64mVlZ6wv+AlnN1vzeu0NqwwweP43/I0plghFnqkL+efaR6gViSGD3EDpunCDtvtTNasNHXFMX1j7/6IwOLAMmQCwwvZwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(30052699003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vicXDAA2ESnR5UTeTpNa1tgsuDYrqCa8ccJu//zC6nNOMnlbvmZ1wnbp6RbbPhrUJJdC6snOyRmreiZYqaPxMfWvSmhxR6F1QvdPhBjZLPOgxr3lreqSp+QfkJcAqTx+E58yY+pahgPzYIPaNyFs5L7MLAVqOGYEpI++BXBMZjC+1VlVjZ6e+2P5k/8pGaCTcGmKLZufvg5Dl5qzTBPI+DL37XmtB1dv5Cfq9j5vOiHYQgeiAVMqErvwCzxNs2kpabbPE+YwKiMMGDlD2VOPTJpbL9aAuoyf/8xpifhTvsPpdQyuXcVkQCQLYXFQSaEiNg4VI6FWRqcJ4VQqYpeDqDAlim3mP7rths/Lo0aFGjRg1zOevE09Q+FTioLH47MWq7vtZubO1/oRT8kNASh/GbzHHpmS6n6GsST/NXoCxlM0p9Mcd5N9CzI/IDXQ6rel
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:39:16.5564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17c4c21-e327-4750-cd12-08df0d9dd051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB497579
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
Peak bandwidth samples could intermittently report invalid counter
values because completion and stale stop events were not isolated. The
default measurement window also made completion less likely within the
available sampling period.

[How]
Clear indirect counter state while masking stop output, use one counter
as the sole measurement completion source, and shorten the default
measurement window to 5000 events.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    | 44 ++++++++++++-------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
index 0169ffcd9343..c89c8ff42185 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
@@ -742,9 +742,19 @@ static void hubbub60_wm_read_state(struct hubbub *hubbub,
 static void hubbub60_perfmon_reset(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	unsigned int counter;
 
 	REG_WRITE(DC_PERFMON5_PERFMON_CNTL, 0);
 	REG_WRITE(DC_PERFMON5_PERFMON_CNTL2, 0);
+
+	for (counter = 0; counter < 8; counter++) {
+		REG_SET_2(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
+				PERFCOUNTER_CNTL_SEL, counter,
+				PERFCOUNTER_OFF_MASK, 0x1);
+		REG_SET(DC_PERFMON5_PERFCOUNTER_CNTL2, 0,
+				PERFCOUNTER_CNTL2_SEL, counter);
+	}
+
 	REG_WRITE(DC_PERFMON5_PERFCOUNTER_STATE, 0);
 	REG_WRITE(DC_PERFMON5_PERFMON_CVALUE_INT_MISC, 0xFF00);
 	REG_WRITE(DC_PERFMON5_PERFMON_CVALUE_LOW, 0);
@@ -1381,7 +1391,7 @@ static uint32_t hubbub60_perfmon_get_urgent_ramp_latency_ns(
  * Counter 1: data counter — tracks total data received during the measurement
  *            period.
  * Counter 2: target-reached generator — duplicates counter 1's event/target
- *            and generates the interrupt that stops counters 1 and 4.
+ *            and generates the counter-off event that stops counters 1 and 4.
  * Counter 4: duration timer — measures elapsed time in refclk cycles.
  *
  * UTM_FILTER_SEL is set to 0 so that isolation comes from OTG-vblank gating
@@ -1396,7 +1406,7 @@ static uint32_t hubbub60_perfmon_get_urgent_ramp_latency_ns(
  * windbg (ed dcn60_debug_peak_bw_ramp_size / ed dcn60_debug_peak_bw_window_size).
  */
 static unsigned int dcn60_debug_peak_bw_ramp_size = 0x100;
-static unsigned int dcn60_debug_peak_bw_window_size = 0x2500;
+static unsigned int dcn60_debug_peak_bw_window_size = 5000;
 
 /* Minimum count4 (refclk ticks) for a peak-BW sample to be trusted. */
 #define DCN60_OUT_OF_ORDER_BW_MIN_DURATION_TICKS 20
@@ -1419,7 +1429,7 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 			UTM_FILTER_SEL, 0x0);
 
 	/* Program counter 0 as the count off counter */
-	REG_SET_8(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
+	REG_SET_9(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
 			PERFCOUNTER_CNTL_SEL, 0x0, // select counter 0
 			PERFCOUNTER_EVENT_SEL, 259, // response vld
 			PERFCOUNTER_CVALUE_SEL, 0x1, // use cvalue bits 15-0
@@ -1427,7 +1437,8 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 			PERFCOUNTER_HW_CNTL_SEL, 0x0, // simutaneous mode
 			PERFCOUNTER_RUNEN_MODE, 0x0, // counter runs as long as run_enable is high
 			PERFCOUNTER_RESTART_EN, 0x0, // stop after counting is done
-			PERFCOUNTER_ACTIVE, 1);
+			PERFCOUNTER_OFF_MASK, 0x1, // do not generate pmon_counter_off_out
+			PERFCOUNTER_ACTIVE, 0x1);
 	REG_SET_4(DC_PERFMON5_PERFCOUNTER_CNTL2, 0,
 			PERFCOUNTER_CNTL2_SEL, 0x0, // select counter 0
 			PERFCOUNTER_COUNTED_VALUE_TYPE, 0x0, // count the accumulated value
@@ -1436,7 +1447,7 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 
 	/* Program counter 1 as a passive data accumulator, slaved to the same
 	 * external stop signal as counter 4 (generated by counter 2 below). */
-	REG_SET_9(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
+	REG_SET_10(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
 			PERFCOUNTER_CNTL_SEL, 0x1, // select counter 1
 			PERFCOUNTER_EVENT_SEL, 259, // response vld
 			PERFCOUNTER_CVALUE_SEL, 0x2, // use cvalue bits 31-16
@@ -1444,7 +1455,8 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 			PERFCOUNTER_HW_CNTL_SEL, 0x1, // independent mode
 			PERFCOUNTER_RUNEN_MODE, 0x0, // counter runs as long as run_enable is high
 			PERFCOUNTER_RESTART_EN, 0x0, // stop after counting is done
-			PERFCOUNTER_INT_EN, 0, // counter 2 now generates the interrupt
+			PERFCOUNTER_INT_EN, 0, // counter 2 is the completion source
+			PERFCOUNTER_OFF_MASK, 0x1, // do not generate pmon_counter_off_out
 			PERFCOUNTER_ACTIVE, 0x1);
 	REG_SET_5(DC_PERFMON5_PERFCOUNTER_CNTL2, 0,
 			PERFCOUNTER_CNTL2_SEL, 0x1,
@@ -1454,9 +1466,9 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 			PERFCOUNTER_HW_STOP2_SEL, 0x1); // stop via the same external signal as counter 4
 
 	/* Counter 2 is a dedicated "target reached" generator: it duplicates
-	 * counter 1's event/target and is the sole source of the completion
-	 * interrupt driving PERFMON_RUN_ENABLE_STOP_SEL. */
-	REG_SET_9(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
+	 * counter 1's event/target and is the sole source of the counter-off
+	 * event driving PERFMON_RUN_ENABLE_STOP_SEL. */
+	REG_SET_10(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
 			PERFCOUNTER_CNTL_SEL, 0x2, // select counter 2
 			PERFCOUNTER_EVENT_SEL, 259, // response vld
 			PERFCOUNTER_CVALUE_SEL, 0x2, // use cvalue bits 31-16 (same window target as counter 1)
@@ -1464,7 +1476,8 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 			PERFCOUNTER_HW_CNTL_SEL, 0x1, // independent mode
 			PERFCOUNTER_RUNEN_MODE, 0x0, // counter runs as long as run_enable is high
 			PERFCOUNTER_RESTART_EN, 0x0, // stop after counting is done
-			PERFCOUNTER_INT_EN, 1, // signal when the measurement is complete
+			PERFCOUNTER_INT_EN, 0, // counter-off is the completion source
+			PERFCOUNTER_OFF_MASK, 0x0, // generate pmon_counter_off_out at CVALUE
 			PERFCOUNTER_ACTIVE, 0x1);
 	REG_SET_5(DC_PERFMON5_PERFCOUNTER_CNTL2, 0,
 			PERFCOUNTER_CNTL2_SEL, 0x2,
@@ -1474,7 +1487,7 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 			PERFCOUNTER_HW_STOP2_SEL, 0x0); // the stop trigger is that perfcounter meet the target CVALUE
 
 	/* Program counter 4 to count the measuring time */
-	REG_SET_8(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
+	REG_SET_9(DC_PERFMON5_PERFCOUNTER_CNTL, 0,
 			PERFCOUNTER_CNTL_SEL, 0x4, // select counter 4
 			PERFCOUNTER_EVENT_SEL, 19, // always 1 event
 			PERFCOUNTER_CVALUE_SEL, 0x0, // ignored
@@ -1482,6 +1495,7 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 			PERFCOUNTER_HW_CNTL_SEL, 0x1, // independent mode
 			PERFCOUNTER_RUNEN_MODE, 0x0, // counter runs as long as run_enable is high
 			PERFCOUNTER_RESTART_EN, 0x0, // stop after counting is done
+			PERFCOUNTER_OFF_MASK, 0x1, // do not generate pmon_counter_off_out
 			PERFCOUNTER_ACTIVE, 1);
 	REG_SET_5(DC_PERFMON5_PERFCOUNTER_CNTL2, 0,
 			PERFCOUNTER_CNTL2_SEL, 0x4, // select counter 4
@@ -1509,7 +1523,7 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
 
 	REG_SET_2(DC_PERFMON5_PERFMON_CNTL2, 0,
 			PERFMON_RUN_ENABLE_START_SEL, 0x0,
-			PERFMON_RUN_ENABLE_STOP_SEL, 11); // perfmon counter off event
+			PERFMON_RUN_ENABLE_STOP_SEL, 10); // stop on counter-off event
 }
 
 /**
@@ -1517,9 +1531,9 @@ static void hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(
  * @hubbub: pointer to the hubbub hardware instance
  *
  * Enables the performance monitor counters previously configured by
- * hubbub60_perfmon_arm_measuring_out_of_order_bandwidth().  The counter
- * self-stops once the count-off counter reaches its target; there is no
- * explicit stop step for the peak-BW path.
+ * hubbub60_perfmon_arm_measuring_out_of_order_bandwidth(). Counter 2 stops
+ * the measurement once it reaches its target; there is no explicit stop
+ * step for the peak-BW path.
  */
 static void hubbub60_perfmon_start_measuring_out_of_order_bandwidth(
 		struct hubbub *hubbub)
-- 
2.43.0

