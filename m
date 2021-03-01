Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7000BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 17:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281016516A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 17:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281016516A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D186E04E;
	Mon,  1 Mar 2021 17:07:00 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750071.outbound.protection.outlook.com [40.107.75.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006F36E843
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 17:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYr9lOsVdWi7tIGT7fnN1rf0jtiuQaHuxGxMm+DLI4nMpcmm7SeWmdO5ywMYffMz3wwoPfxJBBTR5pABM2hqCZKENx7gEtqH0O4sPEWcEylQpuyPTVONB0Tdf/d2dlpwysvWj7XirFmL2MtvE+Sa/B9EOUkDwhtC+zNUg1mZOmlBgTqbRzEqstWfRd1Ge+zleKVaOAhomFKFm17oYwWwlJz4Nct4Vwf8DOCML3IbbOmel2YPIMsCLpUHIbc63ETwANzEbXCvNG5fUAHdXZOk70zF1F1FbRUZE6rz/qGe4jq9nVq5ZIMO1m/6Kiv5HgYVzd+BoGbOMouFA3IKxDF4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1HSGhACX3qepJ72vq7Q3GFMZGsRrvm4OOts9qItkvI=;
 b=hVFNkdecG4GBRvq79jt4ULIXOQ05MkblqK+Zx58KOeilEx4/jTa3Kieiotqvww4GTCsN4J5ATh1uVnGYJtLrlunN4URLmNnfPOGUiemrQLp8m0f9be+VYPvFlHWS/CNsE46HdpDf18TRKWDQ6EWAfbHK/AZfo9MyQNrC2uID33BMVdH0pyLACISBgYLfMDXqw7KdGY2kg79MtWREClg9jY6yQ2NlrReKt/t+wqDm0/CtT44vxw8T5srA/Xaz4BYkHZokclb/vH5vkdcvgkV4eC1/gPH577BYd5391I5/VIuCodySCUguLrAdXe25TWfE1J1/F/4t2ZUd0VPDpEufUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1HSGhACX3qepJ72vq7Q3GFMZGsRrvm4OOts9qItkvI=;
 b=plHeFWWKLFdqwXMUME2K1BC4faOlr5UqPU9niJwanCVgo6y0++dNqskXalbopi7/IwvfDiiynTMaLRx3WnwbR4Rfhk8yeGFMsUekYB1P8EPUXdtYHkAVFmD8bFocQRMYfP2QjGbqSTVK87bkhfPTYN/MTnE1G9UU164VkzF8WUM=
Received: from BN9PR03CA0560.namprd03.prod.outlook.com (2603:10b6:408:138::25)
 by CY4PR1201MB0039.namprd12.prod.outlook.com (2603:10b6:910:1e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Mon, 1 Mar
 2021 17:06:57 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::c2) by BN9PR03CA0560.outlook.office365.com
 (2603:10b6:408:138::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Mon, 1 Mar 2021 17:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 17:06:55 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Mar 2021
 11:06:53 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 1 Mar 2021 11:06:53 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] SWDEV-266369 - dc: Fix 64 bit divisions on 32 bit
 platforms by using div64 API
Date: Mon, 1 Mar 2021 12:06:30 -0500
Message-ID: <20210301170631.94988-2-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210301170631.94988-1-bindu.r@amd.com>
References: <20210301170631.94988-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af52c442-f3f6-4894-503b-08d8dcd46a9f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0039:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0039BCA00CCFF8933D553EB1F59A9@CY4PR1201MB0039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Kh+zs+2YuxHGdDP9YHws5blxavyo5jdpDbX6gCpLAYyVvdEociVC7TZtCMKELZIusEsj9O0A8xKD7Eb09NQA25CKgeuT6Fnsburh8R9TIIjoS12ZUBM9YbfvlbTOtuJH81585EY90BrD/mALfJlG5jS0rfycxw+1ngruN2itxNEUrCKJKWTIg4x7DO+ID2Kp0riavJca6Z1BKQnJA4AOW3XmqeqrJy68gpipFQRtLW8GD8ZNy73yfPfluAVLx6lxva7Hg10k7EtqPdNEE2Y7BqK5LeMQ0D4bhQB6v6w8OhVCa+Om/WFQZDfg0AhoxvVNHbFDKL6LS2GgsD7uDVwyOpYWfg9XmnDh5TItTUIDvFscFRsxYjQxclMrBTIVtDVFE8dCjDF0cuZ+/2fQNKYg3/IG68lkDYDHppG+CSWBK59hzFNievA0eqUmwmDIEG++Jbw0YPuwNU9bzUfFFDEr2/J8dpCR9sCJ+Pg+xT4GAxJez74k3ALRxDBJvmmz4i1XVF4wXkkDNgt52eQaFzI9nl/kUxrx6jA6vqXlhO6K2mKXTYvVOEx/Ivvi6uGt3cO9LhysHaYu8WfQIDrJYFqlTV6Spm1Sh4mQDzzPd0MjJuHlbVXENrq4wlOvzcyrTWkr7kqSwtZ6Pfw+N0JLAdnCixEhBWwtRPKnKK1QQvoyl8rA7o7nfKU18baVUOHPCCp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(54906003)(426003)(8936002)(2616005)(86362001)(36756003)(6916009)(478600001)(70586007)(316002)(82310400003)(6666004)(4326008)(70206006)(83380400001)(1076003)(81166007)(47076005)(5660300002)(82740400003)(8676002)(186003)(356005)(7696005)(36860700001)(336012)(2906002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 17:06:55.2478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af52c442-f3f6-4894-503b-08d8dcd46a9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0039
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
Cc: alexander.deucher@amd.com, Vladimir Stempen <vladimir.stempen@amd.com>,
 Rodrigo.Siqueira@amd.com, Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[why]
Synchronization displays with different timings feature uses division
operator for 64 bit division, which is not supported by 32 bit platforms

[how]
Use div64 API for 64 bit division

Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
Tested-by: Bindu Ramamurthy<bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  | 14 +++++++-------
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  6 +++---
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  | 13 +++++++------
 4 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 0241c9d96d7a..3c91d16c2710 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -424,7 +424,7 @@ bool resource_are_vblanks_synchronizable(
 	uint32_t base60_refresh_rates[] = {10, 20, 5};
 	uint8_t i;
 	uint8_t rr_count = sizeof(base60_refresh_rates)/sizeof(base60_refresh_rates[0]);
-	int64_t frame_time_diff;
+	uint64_t frame_time_diff;
 
 	if (stream1->ctx->dc->config.vblank_alignment_dto_params &&
 		stream1->ctx->dc->config.vblank_alignment_max_frame_time_diff > 0 &&
@@ -441,15 +441,15 @@ bool resource_are_vblanks_synchronizable(
 		if (stream2->timing.pix_clk_100hz*100/stream2->timing.h_total/
 				stream2->timing.v_total > 60)
 			return false;
-		frame_time_diff = (int64_t)10000 *
+		frame_time_diff = (uint64_t)10000 *
 			stream1->timing.h_total *
 			stream1->timing.v_total *
-			stream2->timing.pix_clk_100hz /
-			stream1->timing.pix_clk_100hz /
-			stream2->timing.h_total /
-			stream2->timing.v_total;
+			stream2->timing.pix_clk_100hz;
+		frame_time_diff = div_u64(frame_time_diff, stream1->timing.pix_clk_100hz);
+		frame_time_diff = div_u64(frame_time_diff, stream2->timing.h_total);
+		frame_time_diff = div_u64(frame_time_diff, stream2->timing.v_total);
 		for (i = 0; i < rr_count; i++) {
-			int64_t diff = (frame_time_diff * base60_refresh_rates[i]) / 10 - 10000;
+			int64_t diff = (int64_t)div_u64(frame_time_diff * base60_refresh_rates[i], 10) - 10000;
 
 			if (diff < 0)
 				diff = -diff;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 6f47f9bab5ee..2c7eb982eabc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1013,9 +1013,9 @@ static bool get_pixel_clk_frequency_100hz(
 			 * not be programmed equal to DPREFCLK
 			 */
 			modulo_hz = REG_READ(MODULO[inst]);
-			*pixel_clk_khz = ((uint64_t)clock_hz*
-				clock_source->ctx->dc->clk_mgr->dprefclk_khz*10)/
-				modulo_hz;
+			*pixel_clk_khz = div_u64((uint64_t)clock_hz*
+				clock_source->ctx->dc->clk_mgr->dprefclk_khz*10,
+				modulo_hz);
 		} else {
 			/* NOTE: There is agreement with VBIOS here that MODULO is
 			 * programmed equal to DPREFCLK, in which case PHASE will be
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index bdf40ef01607..45f4dbd886b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1900,8 +1900,8 @@ uint64_t reduceSizeAndFraction(
 		}
 		while (num % prime_numbers[i] == 0 &&
 			   denom % prime_numbers[i] == 0) {
-			num /= prime_numbers[i];
-			denom /= prime_numbers[i];
+			num = div_u64(num, prime_numbers[i]);
+			denom = div_u64(denom, prime_numbers[i]);
 		}
 	}
 	*numerator = num;
@@ -1987,8 +1987,8 @@ int dcn10_align_pixel_clocks(
 
 				phase[i] = (uint64_t)embedded_pix_clk_100hz*
 					hw_crtc_timing[i].h_total*
-					hw_crtc_timing[i].v_total/
-					get_clock_divider(grouped_pipes[i], true);
+					hw_crtc_timing[i].v_total;
+				phase[i] = div_u64(phase[i], get_clock_divider(grouped_pipes[i], true));
 				modulo[i] = (uint64_t)dp_ref_clk_100hz*
 					embedded_h_total*
 					embedded_v_total;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index ef6ee03175e0..ea7eaf7d755f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -323,8 +323,8 @@ void optc2_align_vblanks(
 	uint32_t master_v_active = 0;
 	uint32_t master_h_total = 0;
 	uint32_t slave_h_total = 0;
-	uint64_t L, XY, p = 10000;
-	uint32_t X, Y;
+	uint64_t L, XY;
+	uint32_t X, Y, p = 10000;
 	uint32_t master_update_lock;
 
 	/* disable slave OTG */
@@ -355,11 +355,12 @@ void optc2_align_vblanks(
 	REG_GET(OTG_H_TOTAL, OTG_H_TOTAL, &master_h_total);
 
 	/* calculate when to enable slave OTG */
-	L = p * slave_h_total * master_pixel_clock_100Hz /
-		master_h_total / slave_pixel_clock_100Hz;
-	XY = L / p;
+	L = (uint64_t)p * slave_h_total * master_pixel_clock_100Hz;
+	L = div_u64(L, master_h_total);
+	L = div_u64(L, slave_pixel_clock_100Hz);
+	XY = div_u64(L, p);
 	Y = master_v_active - XY - 1;
-	X = ((XY + 1) * p - L) * master_h_total / master_clock_divider / p;
+	X = div_u64(((XY + 1) * p - L) * master_h_total, p * master_clock_divider);
 
 	/*
 	 * set master OTG to unlock when V/H
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
