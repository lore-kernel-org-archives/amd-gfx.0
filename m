Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919B7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3046410F76C;
	Tue, 24 May 2022 17:58:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E7410F76C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtVymWcY0blrgqSnpzJHu1YkMVkT9Kf+uU9OZYWKzl5j/h3hIx4qxn6XgXXKKyyhzhotEsQZowfyUzgqSadJ8pqsLbM77gGto6ewzV6w5CK5PUGjOjGNwvybiVa4H8394LmRUtZ5DuTr3uuuHeNWQefLXC7vP+8LzjW+ILZrzoP7oO/tjfh/bKtcZuiO4Lq82o89o1ZqtS074dBdh3Y7SHnXOeLwTTX5S4a1bZ2f7AaidrYxiu0jh0opBmIlD8L1CQyw7o/vAlPqN7kBB7mFw5+xAG0DvIko8A7RjT8tZSv4RP9DMfe6U2rfeWINn7YrMEFbjPpTF76ZjX06DXELmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VcWsrf9GaEHkOmCd+WwD7gPu7JJf4UnqsWIYcR2/TM=;
 b=awZJPUWQ+t79UgzMY263COUbgcZ/Tti6S013ix3ZyTEosEIFq0ra8vYXvRue6QEI7AI+wG8mbwPQbNmJdo9So/rmZiYR8q5Ja26TsRZmYC83EVmLJxbXoPRcH/FhgroQTVN8ZecdEIRFuppxgq+80bSzk+G4LhcHAm+ChpvICNVcB0lTWmwN0tqBRjK8QaG6kxJVvykmDLUNAN5GBx00/xcjV8Jr+Hhr/Q2xjZHlOtWHjj9Z3eQD6qf3iNGqLpJolIZIf5xKn2pWate/z6+bGVk0VRyZooer2IPwrg0M6AkEGcofeMUlW1eBW0n9KYgA/UNA5WXl6bYglmV1JqSR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VcWsrf9GaEHkOmCd+WwD7gPu7JJf4UnqsWIYcR2/TM=;
 b=tQQbyPrIjMEF7nAigWo5qEzhlOc1qf/3b9uMui3r4jCHnWkQ85l5sS2cqJp8g2nktRLt2a+lJYtdIX+vAitWq9lPIk1b1NtWroUztDz31v2l+iu52rn1Ae2tOZJsgF0Iv2ASy3DDqwr11H6V12G8q/ciMKxbOPeVwiXz4CB4XnE=
Received: from BN0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:408:ec::29)
 by SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 17:57:57 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::da) by BN0PR04CA0114.outlook.office365.com
 (2603:10b6:408:ec::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Tue, 24 May 2022 17:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:57:57 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 12:57:55 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amd/display: Fix DMUB outbox trace in S4 (#4465)
Date: Tue, 24 May 2022 13:57:20 -0400
Message-ID: <20220524175724.126380-5-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524175724.126380-1-jdhillon@amd.com>
References: <20220524175724.126380-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc6d04f-2fc2-4977-43db-08da3daeef69
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5501:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB55018EADB8D552686AB58EE7FBD79@SJ0PR12MB5501.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zV4O56CW0cyq0WF0Yx/4LvLH4PVpEOWKV0QMjRMNPsw3F3p67SyLlLW4Upd3veyBDWnrtLxdG7S/8ipeZRDlqvS832rJetIEz5VJ5R1eFs/1bbSVH8yuz8BfkqTUUGusT+nHAiHe1T7YZd0zp8++keK1Ceg1gqHL+F68d3qEIb7PjGwVCCxbtZHW5ap+gUjiHqV/DyjP42Lz7z7pzoHfciG17fopPWznlzQIQj0Lvtsuhgxi4vGXdeI7sl8DIL5EfBUI9VBs0/aRq+MIJzuQy3rh1OohKT0zg0mFetxIheZJth7q/kldluH+u1813ZZI1n1CYBZNrRIL2wjELvjfeBjOZ/ETyfBrB1aOVk1h4BrQ+g36/Vr9fmeZg5iIajVU4h7G8ImLN9D5/X9He3Hl4pgzKbVGOkOO6g5V29Wmevs5piPF92eCwLWpTCMdtSrvZswVlOSFU0yVvAU9JGcPKanr4oVO+nxtNwX5RAkocHsOqVr4ZPTdfhhRl0GSsgS7W3Xuy2c1EYR8zXpWZYgd8f+4gJhQrwJsO92bkZfAm5h6muxQ1NJgeiNW/KxeB/a1Sf2vyuW7Xy+BrFPzYVf+LKPr/vM/JWOdD8Af8HNrBLlWAimySV3PrrqUp+GzVXMkkv12KjeCPlh+szUxjtR7MAywzhPS7xRpJY9r2MYEWIFdbDhAL0hN2RG+XPAvA+8CzCqByYpJ5johTWU2APlRpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(2906002)(6666004)(16526019)(36860700001)(508600001)(36756003)(4326008)(70206006)(83380400001)(8676002)(2616005)(186003)(82310400005)(40460700003)(5660300002)(70586007)(26005)(81166007)(356005)(316002)(6916009)(47076005)(426003)(336012)(54906003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:57:57.5822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc6d04f-2fc2-4977-43db-08da3daeef69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Cruise Hung <Cruise.Hung@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Cruise Hung <Cruise.Hung@amd.com>

[Why]
DMUB Outbox0 read/write pointer not sync after resumed from S4.
And that caused old traces were sent to outbox.

[How]
Disable DMUB Outbox0 interrupt
and clear DMUB Outbox0 read/write pointer when resumes from S4.
And then enable Outbox0 interrupt before starts DMCUB.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 61 +++++++++----------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  2 +
 2 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 616013c618a5..0eb89e117a6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -513,12 +513,10 @@ void dccg31_set_physymclk(
 /* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
 static void dccg31_set_dtbclk_dto(
 		struct dccg *dccg,
-		int dtbclk_inst,
-		int req_dtbclk_khz,
-		int num_odm_segments,
-		const struct dc_crtc_timing *timing)
+		struct dtbclk_dto_params *params)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	int req_dtbclk_khz = params->pixclk_khz;
 	uint32_t dtbdto_div;
 
 	/* Mode	                DTBDTO Rate       DTBCLK_DTO<x>_DIV Register
@@ -529,57 +527,56 @@ static void dccg31_set_dtbclk_dto(
 	 * DSC native 4:2:2     pixel rate/2      4
 	 * Other modes          pixel rate        8
 	 */
-	if (num_odm_segments == 4) {
+	if (params->num_odm_segments == 4) {
 		dtbdto_div = 2;
-		req_dtbclk_khz = req_dtbclk_khz / 4;
-	} else if ((num_odm_segments == 2) ||
-			(timing->pixel_encoding == PIXEL_ENCODING_YCBCR420) ||
-			(timing->flags.DSC && timing->pixel_encoding == PIXEL_ENCODING_YCBCR422
-					&& !timing->dsc_cfg.ycbcr422_simple)) {
+		req_dtbclk_khz = params->pixclk_khz / 4;
+	} else if ((params->num_odm_segments == 2) ||
+			(params->timing->pixel_encoding == PIXEL_ENCODING_YCBCR420) ||
+			(params->timing->flags.DSC && params->timing->pixel_encoding == PIXEL_ENCODING_YCBCR422
+					&& !params->timing->dsc_cfg.ycbcr422_simple)) {
 		dtbdto_div = 4;
-		req_dtbclk_khz = req_dtbclk_khz / 2;
+		req_dtbclk_khz = params->pixclk_khz / 2;
 	} else
 		dtbdto_div = 8;
 
-	if (dccg->ref_dtbclk_khz && req_dtbclk_khz) {
+	if (params->ref_dtbclk_khz && req_dtbclk_khz) {
 		uint32_t modulo, phase;
 
 		// phase / modulo = dtbclk / dtbclk ref
-		modulo = dccg->ref_dtbclk_khz * 1000;
-		phase = div_u64((((unsigned long long)modulo * req_dtbclk_khz) + dccg->ref_dtbclk_khz - 1),
-			dccg->ref_dtbclk_khz);
+		modulo = params->ref_dtbclk_khz * 1000;
+		phase = div_u64((((unsigned long long)modulo * req_dtbclk_khz) + params->ref_dtbclk_khz - 1),
+				params->ref_dtbclk_khz);
 
-		REG_UPDATE(OTG_PIXEL_RATE_CNTL[dtbclk_inst],
-				DTBCLK_DTO_DIV[dtbclk_inst], dtbdto_div);
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_DIV[params->otg_inst], dtbdto_div);
 
-		REG_WRITE(DTBCLK_DTO_MODULO[dtbclk_inst], modulo);
-		REG_WRITE(DTBCLK_DTO_PHASE[dtbclk_inst], phase);
+		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], modulo);
+		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], phase);
 
-		REG_UPDATE(OTG_PIXEL_RATE_CNTL[dtbclk_inst],
-				DTBCLK_DTO_ENABLE[dtbclk_inst], 1);
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_ENABLE[params->otg_inst], 1);
 
-		REG_WAIT(OTG_PIXEL_RATE_CNTL[dtbclk_inst],
-				DTBCLKDTO_ENABLE_STATUS[dtbclk_inst], 1,
+		REG_WAIT(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLKDTO_ENABLE_STATUS[params->otg_inst], 1,
 				1, 100);
 
 		/* The recommended programming sequence to enable DTBCLK DTO to generate
 		 * valid pixel HPO DPSTREAM ENCODER, specifies that DTO source select should
 		 * be set only after DTO is enabled
 		 */
-		REG_UPDATE(OTG_PIXEL_RATE_CNTL[dtbclk_inst],
-				PIPE_DTO_SRC_SEL[dtbclk_inst], 1);
-
-		dccg->dtbclk_khz[dtbclk_inst] = req_dtbclk_khz;
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				PIPE_DTO_SRC_SEL[params->otg_inst], 1);
 	} else {
-		REG_UPDATE_3(OTG_PIXEL_RATE_CNTL[dtbclk_inst],
-				DTBCLK_DTO_ENABLE[dtbclk_inst], 0,
-				PIPE_DTO_SRC_SEL[dtbclk_inst], 0,
-				DTBCLK_DTO_DIV[dtbclk_inst], dtbdto_div);
+		REG_UPDATE_3(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_ENABLE[params->otg_inst], 0,
+				PIPE_DTO_SRC_SEL[params->otg_inst], 0,
+				DTBCLK_DTO_DIV[params->otg_inst], dtbdto_div);
 
 		REG_WRITE(DTBCLK_DTO_MODULO[dtbclk_inst], 0);
 		REG_WRITE(DTBCLK_DTO_PHASE[dtbclk_inst], 0);
 
-		dccg->dtbclk_khz[dtbclk_inst] = 0;
+		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
+		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 8d4574895757..c7bd7e216710 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -132,6 +132,8 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_WPTR, 0);
 	REG_WRITE(DMCUB_SCRATCH0, 0);
 
 	/* Clear the GPINT command manually so we don't send anything during boot. */
-- 
2.25.1

