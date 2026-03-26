Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21C3109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5678310E91F;
	Thu, 26 Mar 2026 03:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uZxCrWe2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8265410E919
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HczBC9x/KcMH2Bgn14Yoh+Tm+o9/3FeGr0MfAqP3v82ND3LaKTf3n8IJgmyWek8C0gZh8BSpXe23ie/na13PVHkU4NfHRrJNrh0m22MbY3V6qXKNw1pIbyb74cuIGTVNaG9q7vkjFqGawljU+uvyG3kXgJClHshEAtPu0UIdTAxmwbhNyu8OzDcIdNyK158jzaf+E5FQXvkBm1HrT/rK6jTOr7RyMNrqMqGqhIoW9IBI4gBEPy6bKvneNMrPqB4b26oiMRrjHx+nO7wum2uoB/oW0wS+THWiYwvngc1W78jolOhHRjqDl2XJNYoosGnn2knfbENvAssmK80PR2zOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGayQRv9UslUftf2Z8WAtL8osJXvCFWMHu2bninMHtU=;
 b=G0kHv3e2cvRRUpn7Iiw2W4Sx7+YOyibaloZ7eWlEwiyeIe+lcmpYg6kU+FwrrTBryG3GawhPcGr1Yel2vT1T0d3crmZ37dM/8yWkBCVq0SBpjRMTCoMpKSYB1/nFr+GvWhanEahacrGyabb558eS4f4euTQES2oMK+sWl5+XYfpt9jvhhKEWszBzpDnm5TYlCHaDRhuOklyBEGklb2/1SPbiRZ/bRaAOvcKn6A8dyFoK3XqGaDXkOymgpjKEm6ab0Idbyeo02rL3D9lb4NEzliTCS97fNMUP6HZOJx1Ol69jgC22vft7urRYEJ9iD+A5gqAF6vbtpWIHTXDQDH3+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGayQRv9UslUftf2Z8WAtL8osJXvCFWMHu2bninMHtU=;
 b=uZxCrWe2+iy0LgRkhEUYUoIhPo0KMtmHUHZpdueDS5FW6C2Dj5EQ5i0SEyP3giqEAgAl26PcphNR/NrFB+WCp1SAibJA30D26kMXXnYHaAhiF+7Fs/flqUNMyFJiq6wrUjy9NxfHW/cTKs21j91XJU72gRaamqsWKnTUwvsTQNA=
Received: from BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:01:04 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::ab) by BL1PR13CA0151.outlook.office365.com
 (2603:10b6:208:2bd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 03:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:03 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:00:56 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 09/30] drm/amd/display: Fix Silence Conversion Warnings in
 Dmub
Date: Thu, 26 Mar 2026 10:57:00 +0800
Message-ID: <20260326030153.406612-10-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 74156e13-a83b-4c14-75e3-08de8ae3eb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TB2vLcy6i+WIk/7W8ydwuPDDlcsNFG/ATcH66PSrNnl3GqMrpcQEmfi/n58Z65aSgJvAGnwJkJrGNCZLjpknxuql8NYnnMRjaIGwCQGJ9EGFWPSBhFdgDRSCaO5aKmHv6DNE5JeBBUPVSpBFA7e0gKzyvdJhQrDjydizipgOjo2IKPc9EgGBNqav1P5dsTrv/aP/9Anr079e8Ymi4eMvvsToaF4oQqWM7NENEOvbF8LhzSYhuGto+otW477u78gLjOenFPMKmwXJu2q4Lkdm+dKyLiku508TnhSwHGeAo4Z7IRXmY2QBStHxbI2lk6Ish5G5NKRS1hhGjhjkvq2pyVZzgf2R1BuBGXytQ3j+gIpGhXKUyu/7gyWo7le/asu8fbyfUHU5ScwYRRuc9xFJ+xgsOTXFKMtoPISBL76KC8L/DF1Wl9i32bwTl8wuMxWO8CcMF0gQ+YpDSAWrDC33n+H3s1CUBgv7U6vW1HLl4xETPyuRezdcbteaS9L+4rxD6ITA+amuIjAi4ZM4CH63Xy1w/Ao8wkMU6XwWVofFDB6/yjdeV6V1CfWVZVvfZUSz1GXNnnADIPLrWSzn2nV8L9xrHkcTh5rq3y2+RkuvcG29D0VcXGGpr6yspENJGwtmdhen3dMfESOPstXPGxpjR1xqmg+vi0oYKnyYQnO/kDke8LV5sODaYLrsUxV4Dtx8UwGIIAR3vbt+RFpAeqB9+6DonGh5QLWe+cRy8u+zKK0OQawm08UFGWIEQj3HAvBBvnbVi6lfP6z3Kq503w0zfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LqzQZCx4GjtwHBb5EgWAkijWX1XgivQl+kokF2BGIYtgNUv+Pel6+blqbADblldKmEikHBzLtP+sYwu52GRGRk7AImvkNZH2vKqjlC2FWgiCY8Psfm10SiZQYIDQ/SoOW+sKuVgYr7Id7HM5puh67PVkmzmNGGSsL1WT1tJWVXdSzfHAt3MFlmeUA1I5XxD9yCN58N869UsLaaEPH+5xd67SCS/lbpZcmMwTrphmLEOdOjdyGkxpthTN50RNOHQr2n/T5gxqzfk/n+XzzPIbNvFcUV4TOgihW7KItHPJJ/RW5GkvNJxLRlnMH2HnLqdhHHpAUOVtlwj5QxPgZiLhawPKXVm0I+5um0KaqSeNYRbHhio1q5oVHYy61OyjeShx8coYe+Cs7EWFcQDheE18SJbpsDfzI9gjL+HEkU2wLNEOvqlNa8i9QciRShv0ofjj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:03.8937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74156e13-a83b-4c14-75e3-08de8ae3eb15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

Fix Conversion that might result in a loss of data  warnings in dmub/src/:

- dmub_dcn20/31/32/35/42/60/401.c: Add ASSERT(value <= 0xFF) and
  explicit (uint8_t) cast when storing REG_GET results into uint8_t
  debug struct fields. Add != 0 for bool assignments from uint32_t
  bitfield reads.
- dmub_reg.c: Cast va_arg shift value to uint8_t with ASSERT guard
  before passing to set_reg_field_value_masks().
- dmub_srv.c: Widen num_pending to uint64_t to match uint64_t
  arithmetic; use != 0 for bool assignments from unsigned expressions.

No functional change intended.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 18 ++++++++++-----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 21 +++++++++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 15 ++++++++----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 17 +++++++++-----
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 21 +++++++++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c | 23 ++++++++++++-------
 .../gpu/drm/amd/display/dmub/src/dmub_reg.c   |  3 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  8 +++----
 8 files changed, 82 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 54df2147e4dc..73221ca53b7d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -460,20 +460,26 @@ void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
+	ASSERT(is_sec_reset <= 0xFF);
+	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	dmub->debug.is_cw0_enabled = is_cw0_enabled;
+	ASSERT(is_cw0_enabled <= 0xFF);
+	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index a0cefc03b21d..244244f3df80 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -466,25 +466,32 @@ void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
-	dmub->debug.is_pwait = is_pwait;
+	ASSERT(is_pwait <= 0xFF);
+	dmub->debug.is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
+	ASSERT(is_sec_reset <= 0xFF);
+	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	dmub->debug.is_cw0_enabled = is_cw0_enabled;
+	ASSERT(is_cw0_enabled <= 0xFF);
+	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 }
 
 bool dmub_dcn31_should_detect(struct dmub_srv *dmub)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 2f99a2772599..5d86f649db4b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -486,19 +486,24 @@ void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
-	dmub->debug.is_pwait = is_pwait;
+	ASSERT(is_pwait <= 0xFF);
+	dmub->debug.is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 639f9835e5e9..f9b16eb8ef8e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -402,7 +402,7 @@ void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	union dmub_fw_boot_options boot_options = {0};
 
 	if (!dmub->dpia_supported) {
-		dmub->dpia_supported = dmub_dcn35_get_fw_boot_option(dmub).bits.enable_dpia;
+		dmub->dpia_supported = dmub_dcn35_get_fw_boot_option(dmub).bits.enable_dpia != 0;
 	}
 
 	boot_options.bits.z10_disable = params->disable_z10;
@@ -508,19 +508,24 @@ void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
-	dmub->debug.is_pwait = is_pwait;
+	ASSERT(is_pwait <= 0xFF);
+	dmub->debug.is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 16ed07f0e96d..3d2307d0ce49 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -473,25 +473,32 @@ void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
-	dmub->debug.is_pwait = is_pwait;
+	ASSERT(is_pwait <= 0xFF);
+	dmub->debug.is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
+	ASSERT(is_sec_reset <= 0xFF);
+	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	dmub->debug.is_cw0_enabled = is_cw0_enabled;
+	ASSERT(is_cw0_enabled <= 0xFF);
+	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
index f687359b7d83..7b870b831199 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -41,7 +41,7 @@ void dmub_dcn42_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	union dmub_fw_boot_options boot_options = {0};
 
 	if (!dmub->dpia_supported) {
-		dmub->dpia_supported = dmub_dcn42_get_fw_boot_option(dmub).bits.enable_dpia;
+		dmub->dpia_supported = dmub_dcn42_get_fw_boot_option(dmub).bits.enable_dpia != 0;
 	}
 
 	boot_options.bits.z10_disable = params->disable_z10;
@@ -676,25 +676,32 @@ void dmub_dcn42_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
-	dmub->debug.is_pwait = is_pwait;
+	ASSERT(is_pwait <= 0xFF);
+	dmub->debug.is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
+	ASSERT(is_sec_reset <= 0xFF);
+	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	dmub->debug.is_cw0_enabled = is_cw0_enabled;
+	ASSERT(is_cw0_enabled <= 0xFF);
+	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
index ca0c8a54b635..94f4931d3d44 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
@@ -57,8 +57,9 @@ static void set_reg_field_values(struct dmub_reg_value_masks *field_value_mask,
 		mask = va_arg(ap, uint32_t);
 		field_value = va_arg(ap, uint32_t);
 
+		ASSERT(shift <= 0xFF);
 		set_reg_field_value_masks(field_value_mask, field_value, mask,
-					  shift);
+					  (uint8_t)shift);
 		i++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 3bba256a288d..10d23f5f5d94 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -1034,8 +1034,8 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 static void dmub_srv_update_reg_inbox0_status(struct dmub_srv *dmub)
 {
 	if (dmub->reg_inbox0.is_pending) {
-		dmub->reg_inbox0.is_pending = dmub->hw_funcs.read_reg_inbox0_rsp_int_status &&
-				!dmub->hw_funcs.read_reg_inbox0_rsp_int_status(dmub);
+		dmub->reg_inbox0.is_pending = (dmub->hw_funcs.read_reg_inbox0_rsp_int_status &&
+				!dmub->hw_funcs.read_reg_inbox0_rsp_int_status(dmub)) != 0;
 
 		if (!dmub->reg_inbox0.is_pending) {
 			/* ack the rsp interrupt */
@@ -1320,7 +1320,7 @@ void dmub_srv_set_power_state(struct dmub_srv *dmub, enum dmub_srv_power_state_t
 
 enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, union dmub_rb_cmd *cmd)
 {
-	uint32_t num_pending = 0;
+	uint64_t num_pending = 0;
 
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
@@ -1348,7 +1348,7 @@ enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, union dmub_rb_c
 
 	dmub->reg_inbox0.num_submitted++;
 	dmub->reg_inbox0.is_pending = true;
-	dmub->reg_inbox0.is_multi_pending = cmd->cmd_common.header.multi_cmd_pending;
+	dmub->reg_inbox0.is_multi_pending = cmd->cmd_common.header.multi_cmd_pending != 0;
 
 	return DMUB_STATUS_OK;
 }
-- 
2.43.0

