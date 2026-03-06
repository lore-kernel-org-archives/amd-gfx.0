Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04074F513E9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D31210E2FA;
	Fri,  6 Mar 2026 03:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mog7Asqm";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DCA10E2FA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAxjyF2RiAJHBwJJUjznHyMPrRlSigoVfilAD+okJo+HBe3aujIRlT3ehDZ5ZMv1oHcN4C2OJ09IxhNawwA281DzkpgIcto6uTOup1bmNkGLndvGTGcU6nUjHPTie4ez/PfcIBY1tOT2VPWcOvADSEfrWpfJF3OppVDtd0i3HPznvc8IZCNr6IuN4U3CVBzV3rmvHA6HkRcYMSazsPGjS/hrO3aeevfUjgE0EHI8P1EQ5NUF0u/90UbDkl+p03v0e330ppHCWnS/yeraqGdeqGii9og19nYo1xe3YpqoY3Thia4oh4htHTzxhBs6MkEwEWGcVjp54ZDsMJXq3lzcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atO8Ek3URKisWa68J5EVveKlGxxtSLh3wP++RCd/sDc=;
 b=qo4JxEG65tcD9l/VfTxTBjpoKUyX+FXJONSYVuyO4vk1n4JiDGurcqYcffTowwGVZ1nwABorTtD7xyRJQ+0F9yS67kpCgYIOblRbBoNh6GpyVEpaxMm1pPE2Wb2b83wtNugin1h5idfW0ZhCP6v+ZDvkgR9h8rqd1mvfnkjVsHzCjFPAYMGCot4tEpPC9MEk5b2NTpX+GbKqh2Yar+wHRrwZefnbhzWqj7+bKGTL0C5nXJn8ZsI3NNJzVMFbxx1GJE62m1PzkmDOxpNYN0cwmpJBtRb2Q2FSD2SToHGTk/A7HMA7vEwASPQnWGRO0mI7PEWSzZ1/d9ilRb074Zj6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atO8Ek3URKisWa68J5EVveKlGxxtSLh3wP++RCd/sDc=;
 b=mog7AsqmDSksOJOLVg1bqGfdjPpfwkYV9De5PE2AJaJkUhEIzD0LmlQemBBkZQaDCdHWdWQZueK7cEDcqSDgQot65r3WOPDTwJxHQA2+J2yGA8WgT0JGCYstwOwxZR6WcjF3YFMq15+LnB3PDKN2fYpMtsY8sQAlTmLIZo7umGg=
Received: from PH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::27)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 03:25:20 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::f2) by PH0P220CA0029.outlook.office365.com
 (2603:10b6:510:d3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Fri,
 6 Mar 2026 03:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:25:19 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:25:16 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>
Subject: [PATCH 07/21] drm/amd/display: Update underflow detection
Date: Thu, 5 Mar 2026 20:13:33 -0700
Message-ID: <20260306031932.136179-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 8374ddbd-d99a-41f2-5f4e-08de7b2ffe2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: uhls+PARReBr2cOa3m0WCXrxwgiNIt1AsONIGIDYIve8P4tdRqdBoREcR4F06k+4b2ZbfXcR98UXDexNzuWOBBl6TEW2ggcLsZXtG0lZannhsEGoOLq8eQN5mLEmJgN9alsr4gGKz7yhG59LQmjszSdKI523/tkelk/3Hj4m35By8KOycuobczy9H8VayTLl3FAwwC8Ly0N3ISO4GjUjmr5mrWLgrCnxGGpnOxtq+90uGQDbJgQSK8Ah5wCs1q1ZLfWtj8m+/otFhpRrO50N37i6EXiAfPKsjlw6379OqipK18jZ3x0A/Wjl98pY8mIueyl+SeHDaG7abpEc5Bg1IWRy4cm2x7SXmaIeWQ2PD3U78n25nh0/oYm/EcL1Ieubu/PvKE/P9kAhF+v/4u3rT2QxmSmKaiQnUtgv4Efi1Wb4RrmHqlnJI5FO2UsCYfazVuE7K3yu5sUJvE0QSLF5u1Q8/r1PnGKgP5j6zuNowy+DFRO4vUG9wA4tlRjoXtiBgUUjIR1B2AhovpMmeyD5Dj1tBqgILgpKbX2XyKaeFJq8vPcAGhLA+cFGx2XyjLEpuY8AoTvNBlgMRMlt+6fy2qD5az2EYLrVHg+AEixVf/d/xWRKl5vz6uMkOnj/q4CIAyD9pbh0TnKslTPf+gIcgn+CvYqVL/wRiCYWR96tPaHEZij9YkLQO++mrcPop8gRiCMP3Q9azxGuFekbI2txFl9vRaiOS4TpItVBIkKAZvNAGMRrNbklqRd0clwLBr6Fm5Vtx5YXMAxMvMHVOKabqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mndtW7dsSeLQ5H6ZjmgzKIl1h3vypHu3+IKkFFU3AUXg+DLHpSuBJ7PYVVy61jZ1XEUcIORXvDUmv6jD5GJdjcrKmwzbnHGvw9HxNWP4MFdAMNDYa10UBwCrBGtSbj2u3rl1ruQV5i/MwmKOn5+Eu+RHWDPugqNRK/ulod2olABfemnFWvec2ljLeA1kujbgLLzpnShOFMkF7auC0764C0kK318RSnTB91Vmo9hVmzAbmPk9gtOReIaKFLuu0UNh2osw5rj33RfbWhb949dpLg594aIF29H2YjpIo4qE9Y7IU8GiETR1IBLrSwvuWEHV7g6MROFsdP9rSXYpwLeunwvIpFJDDwy45zOVJfYzEghqE0IitRmeq0O6yCJPmnVxkWmu074qsd9/Wh99XttcA+ZloOE7aSACDwnVTDvY3d6kCPI/5xi0I2BOM4Oi6Qi5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:25:19.0469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8374ddbd-d99a-41f2-5f4e-08de7b2ffe2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
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

From: Charlene Liu <Charlene.Liu@amd.com>

[WHY]
Add underflow detection for later ASICs.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h | 6 +++++-
 drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index cf05620fd8f5..d2ba63046a50 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -218,7 +218,7 @@
 	uint32_t OTG_CRC_SIG_BLUE_CONTROL_MASK; \
 	uint32_t OTG_CRC_SIG_RED_GREEN_MASK; \
 	uint32_t OTG_DLPC_CONTROL; \
-	uint32_t OTG_DRR_CONTROL2; \
+	uint32_t OTG_DRR_CONTOL2; \
 	uint32_t OTG_DRR_TIMING_INT_STATUS; \
 	uint32_t OTG_GLOBAL_CONTROL3; \
 	uint32_t OTG_GLOBAL_SYNC_STATUS; \
@@ -676,6 +676,10 @@ struct dcn_optc_registers {
 	type OTG_V_COUNT_STOP_TIMER;
 
 #define TG_REG_FIELD_LIST_DCN3_6(type) \
+	type OPTC_RSMU_UNDERFLOW_CLEAR;\
+	type OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS;\
+	type OPTC_RSMU_UNDERFLOW_INT_EN;\
+	type OPTC_RSMU_UNDERFLOW_INT_STATUS;\
 	type OTG_CRC_POLY_SEL; \
 	type CRC0_R_CR32; \
 	type CRC0_G_Y32; \
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index c6417538090f..893d2aff1f82 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -363,7 +363,7 @@ void optc31_read_reg_state(struct timing_generator *optc, struct dcn_optc_reg_st
 	optc_reg_state->otg_crc3_data_rg = REG_READ(OTG_CRC3_DATA_RG);
 	optc_reg_state->otg_dlpc_control = REG_READ(OTG_DLPC_CONTROL);
 	optc_reg_state->otg_double_buffer_control = REG_READ(OTG_DOUBLE_BUFFER_CONTROL);
-	optc_reg_state->otg_drr_control2 = REG_READ(OTG_DRR_CONTROL2);
+	optc_reg_state->otg_drr_control2 = REG_READ(OTG_DRR_CONTOL2);
 	optc_reg_state->otg_drr_control = REG_READ(OTG_DRR_CONTROL);
 	optc_reg_state->otg_drr_timing_int_status = REG_READ(OTG_DRR_TIMING_INT_STATUS);
 	optc_reg_state->otg_drr_trigger_window = REG_READ(OTG_DRR_TRIGGER_WINDOW);
-- 
2.43.0

