Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6513FCCA480
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EAEA10F4B5;
	Fri, 17 Jun 2022 19:36:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E35210F47D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkakwBMWNiE74doa4xxqwKVj2BvtQjlEuTqg7rGx9XlUL64xwc1r1wc5DC9iKsri664McYYa1uPPgaapltFCy/9en0PujfwmR1ux5DukBew1uCdLDz1InRG5MA/Gu7+NAflH4DeeWX3L7LNEJRrAJ+HMOLfnawVgX9e0XkOfy5ZRnBxEr/BnfkNTMBbMhnguHkcnOyeScPaMHkYEG2Lj9Zs5L/MFhuaU9XnAJ5XjE1C2HjNoBJ31+eiMVSlHTMVYYBBLcN38pPwnDToTakLoRSVDVScz2fTFTrwwt3JFl0zfhIdYcpamBm9N1b4UvWUFE7J3u2Fk2ZaB0KN9xKQjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gqAZaqfkXsAANg+plZSu0/UL6Z+9DYPuetTc4ukR9o=;
 b=bDaNw3EHp32xL6Dt2RsmgaHQj4i6Mi8gE+65spPz7lBkWXsNiBu5EduFOspAWNSlbKLgD16/ZGFYHNLfbQOr4gm0E8FwvvkV3+r5OvvY8RrtSrZtE/1MlFYzU797UPrkkf3fFNRi21EAn0xJE2X5aCUozwg0xytVhfrW3oBrP9TALvXfh5HqNpqyzAxWMyVAhZEbGMRP/OHL2rfwj2lWe6HSOVU1JOKrKBx5YaeaqAbL/5MvYAysar99b5y6C5z+57C1I4FyoDJiBkkWy5Y6CdsXoRvaTAxhx342gJhhYfGbNCYyqlCLm6ysuAjN/y83vbRbsT1dcuBZbz7sp/jiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gqAZaqfkXsAANg+plZSu0/UL6Z+9DYPuetTc4ukR9o=;
 b=NRp91lhw7IzUcwS3snQfB/aWIAwWCGZ0Zu2xlqODl+eccnHwT0VeTGpIxDtfI4RiwhDGvXbKaa6dhvp5y1D+pBNcXTV6EoOivkoNYRLkE1p+CyRqllYp07a9JbgXd+3E46Kn5Ep+cjWHmQ40BVmfwci/kfyRqY1XPp00tR7c9xo=
Received: from BN9PR03CA0764.namprd03.prod.outlook.com (2603:10b6:408:13a::19)
 by MWHPR1201MB0141.namprd12.prod.outlook.com (2603:10b6:301:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:36:07 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::7b) by BN9PR03CA0764.outlook.office365.com
 (2603:10b6:408:13a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:07 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:36:00 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/31] drm/amd/display: Update DPPCLK programming sequence
Date: Fri, 17 Jun 2022 15:35:05 -0400
Message-ID: <20220617193512.3471076-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd528b8f-2844-4a4e-21cd-08da50989fcc
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0141:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01414415F80B8018B48F33B498AF9@MWHPR1201MB0141.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n97uF/e9aVcZBt96GIh2ZMFWkdTQCOUh+72qWXkl9ubjXXJ0cjDYcvEq0q38EuRSXD8sD8KLVROuRbs8y7wA9KZuK83TJ2ks+lVC6b/DVYMG0ejoybrIG/XAFByNmrXlaMnbUjaI/0Hd+8/Naoa1cP8YF2nPfVI6sBKXt9wUiXy4F1Dy38TvrNRnH5vHaAErtuxAcg6Ce+RYSZ1+UjsVraaE8OOapxAzMNAknNLkk2iW7JNzDoO96/YcNtt9weDJGqCdhIXBoP9+epGmvRPED9+pg0zrobgzM3j8wejUFzSeBWwj8l+L3Fif5P6VX9UwKaCAMBMfO/jXFooDYE7Aeu4wWAcyGHUbm3VELMr2sEKVo3ULLYJKg1CcAgazfO2JkDdT9fBxNeFkFp5Ffe2wCxDlAve4H47nlUZpKytGUdoAie69AeV35H/nV+VaiuJb0Q7c79hnqIV862ayL6uIx4WGLsdeR/RFtXGdwWtH+nQXZUXALH9rOAO+dSWfuJ6HoBY3yeSpI6YzvyfEl8beKtSjURiEbob2hfBCcTDnde4CcTfbpS3K7VY8w8/Tt/6XvHJCemcDhHXgvQvZgKXnoDe7XEZ3LJITLaf0PmdMOCpxtJb1i8mBqP4Dm/CUAMnbyTwrFXM+Cl8Fs0utoFDfCDcshDlGinZrTAoBaxnZFiCXklr/w+64BSyO06+txiOSmFD6SqYZpMQ7NyvQnbCYSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(426003)(47076005)(6916009)(186003)(2906002)(81166007)(498600001)(83380400001)(26005)(54906003)(336012)(316002)(82310400005)(356005)(36756003)(70206006)(8676002)(7696005)(1076003)(70586007)(4326008)(5660300002)(16526019)(2616005)(15650500001)(8936002)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:07.1771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd528b8f-2844-4a4e-21cd-08da50989fcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0141
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- When lowering DPPCLK, we want to program the DPP DTO before updating
the DPP refclk.
- Also update DPPCLK to the exact frequency that will be set after clock
divider has been programmed. This will prevent rounding errors when
making the request to PMFW (we need DPP DTO to match exactly with the
exact DPP refclk).

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index b32880afb3fb..bab85f3c9c67 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -325,6 +325,26 @@ static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 	}
 }
 
+/* Since DPPCLK request to PMFW needs to be exact (due to DPP DTO programming),
+ * update DPPCLK to be the exact frequency that will be set after the DPPCLK
+ * divider is updated. This will prevent rounding issues that could cause DPP
+ * refclk and DPP DTO to not match up.
+ */
+static void dcn32_update_dppclk_dispclk_freq(struct clk_mgr_internal *clk_mgr, struct dc_clocks *new_clocks)
+{
+	int dpp_divider = 0;
+	int disp_divider = 0;
+
+	dpp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr->base.dentist_vco_freq_khz / new_clocks->dppclk_khz;
+	disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr->base.dentist_vco_freq_khz / new_clocks->dispclk_khz;
+
+	// Divide back the previous result to round up to the actual clock value that will be set from divider
+	new_clocks->dppclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / dpp_divider;
+	new_clocks->dispclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / disp_divider;
+}
+
 static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -448,13 +468,14 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 	}
 
+	dcn32_update_dppclk_dispclk_freq(clk_mgr, new_clocks);
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr_base->clks.dppclk_khz)) {
 		if (clk_mgr_base->clks.dppclk_khz > new_clocks->dppclk_khz)
 			dpp_clock_lowered = true;
 
 		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
 
-		if (clk_mgr->smu_present)
+		if (clk_mgr->smu_present && !dpp_clock_lowered)
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
 
 		update_dppclk = true;
@@ -488,6 +509,8 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			/* if clock is being lowered, increase DTO before lowering refclk */
 			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 			dcn20_update_clocks_update_dentist(clk_mgr, context);
+			if (clk_mgr->smu_present)
+				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
 		} else {
 			/* if clock is being raised, increase refclk before lowering DTO */
 			if (update_dppclk || update_dispclk)
-- 
2.25.1

