Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC4EC072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 06:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1562410E2ED;
	Wed, 22 Nov 2023 06:59:53 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8997B10E127
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 06:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/NbkTiDJO6QzrKA2s6f+b0wJJLjOTuqEkDsE1B+F18t5B2B94/olc1D70EjD6TBmIAE/sRaKULPFD4pHPiGmnEdguzn6vZamZk8Cqnf2MqyC5AsmR9cDMCCOJa/IStvnp6NlyASAIB7qPS7GYaBbwW2Px8mCrjX5uibN6VhPztpYYsAmlZr+JP05x2TiWZGX8rTJanRLs+x+T6GWApOCqHcZuxVXLteiCqlX54H54Li9CN4JNDiVjVITW5sPxlPlSGoZ9Vx+xmSOQlapfXV2xOWSKYazXZPdaUkCr9/nX1kYaELxRwO2ul017QREQNMcGZKZUq4pusxfeIwDz2ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSy1gQTIpMKrybE/JyHHs7n9lbje9fziUlmnmIWQO/Y=;
 b=DZVOu+Axai4ivHrWEVxzvd6lkNHkSE0kTZdkD5dP+i10m1lbNXWoT4M11Bqo6cDkILjIhruI/TbxhN48B/gUkdXyiQ8f7LUbpVE60LXuHf+qjYmsUT1FDLS+bp54/UXgsSgtHtT1Fnf/TJeCOfDATxm9yLHwLHHsJRb+mS7D37gbDz5YO2cLyO5r71UPv01rdNdg8oNgHMkbBDl1J3W8IveZQNAhKvIJVu8yl9hg4MIkahjHyH3yLpPxIpx09txslquqXak9GIieCd6uFKkKzdimoPO+a6a/pABbw8K6W4TVsqam0cxKYsPVDN40Yo3r4+HCv5iQlzbG7bN6oFSLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSy1gQTIpMKrybE/JyHHs7n9lbje9fziUlmnmIWQO/Y=;
 b=1fkQhHVhj3lKdPXyzRMCw5kpYBaC2IH6MhpIoChZeXp+Z+ikgSdeT5PFBb9tj7jMc6V7DaWtqViF7ljzEt/2JXsahIj7zxIcv01+tRLIR5mDa0Ba2JIf8mbIQg/7ebReBG6WubDMAeuSqPklcWjAvRnPTnUS7nMW+BCH2IEjb4Q=
Received: from CY5PR18CA0059.namprd18.prod.outlook.com (2603:10b6:930:13::22)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 06:59:46 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::af) by CY5PR18CA0059.outlook.office365.com
 (2603:10b6:930:13::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 06:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 06:59:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:45 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 00:59:38 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amd/display: Allow DTBCLK disable for DCN35
Date: Wed, 22 Nov 2023 14:58:39 +0800
Message-ID: <20231122065841.2267110-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
References: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddb43e5-02bf-4d24-b179-08dbeb289ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zy+YfCPkTdn1KJjmerHk0WvSg5DAtiL3TV+b8eVQYQTlLusf6WA8woZrrYOMsec0iSyG23BWqyAe6uoeWlIdTjIOXSFm+gbo7BPE0jZfveZdFyQVpUOh3WyldKfPQfiQFnQAA8IlEAoiimS3xIx62BWmfRTZtbGsvEO67vnl7gcUbObk66aG3xpzYTD8cLcBPqctprt0BZLRoeOl7ooYa7+x6cxlIIlXTghOl0Ya3UpX17XJyIdcpUxqDKmAhHiKgZ5nXSRISTg/uZGJbdC1ijvQvp5pPfShFFYAZzPkgkUZiODa49c/2juDYu4e7Fjqow3D4zddGA40KzVWfJnvIkiFDsm5cbzddnv0Rgokmi32lilQB7YOo7yFWJTuFGaEaByCOkwKfjAVymaZZrpNtoz7gt850VD7Hf+TylfYROdog/4eqHyHhKadsYv3h2eV3oluw1kGiqWFLoBOBP2HYMnwHXEZ6ZgRA+42Lgu92I90S/s3kF6nwFfh3hsaP8l3TKWYzIVQGknEM/1x5Ybz4IJWYqSbeYkOugeuTRE4+3UAK6369b3PiHYiXkDpvZZn6Pxg034aHAsLyPU7jboPJG6ZY8Ozz6EKW3ZeRGSl5zKww39iEP5Du6Se1bM0x1qEtx0rXgzBvGURE7tUIsD/iLngy/eqZYpgBgLKZZk81+v44fBi8+OnAdydU+RCmxuiZsx5GciJF/wpLfTNa3b8CDgJz+wQrPrGydO0uspuV2M2APbfy5sRyni/GfHyfhMte8+zk14IVhP4rjuI9laTjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(426003)(336012)(83380400001)(36756003)(81166007)(356005)(86362001)(82740400003)(47076005)(36860700001)(41300700001)(8676002)(54906003)(70206006)(70586007)(4326008)(8936002)(316002)(5660300002)(2906002)(26005)(6916009)(2616005)(1076003)(40480700001)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 06:59:46.1640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddb43e5-02bf-4d24-b179-08dbeb289ca8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DTBCLK is enabled on idle and it will burn power.

[How]
There's a few issues here:
- Always enabling DTBCLK on clock manager init
- Setting refclk when DTBCLK is supposed to be disabled
- Not applying the correct calculated version refclk, but instead the
  base value which might be zero

On dtbclk_en change we'll message PMFW to enable or disable the clock
accordingly.

The DTBDTO will be then based on refclk, but it will be set to the
default fixed value if there was nothing calculated in DML despite the
clock being considered enabled.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 27 +++++++++----------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 63a0b885b6f0..d5fde7d23fbf 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -232,6 +232,10 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (dc->work_arounds.skip_clock_update)
 		return;
 
+	/* DTBCLK is fixed, so set a default if unspecified. */
+	if (new_clocks->dtbclk_en && !new_clocks->ref_dtbclk_khz)
+		new_clocks->ref_dtbclk_khz = 600000;
+
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
 	 * also if safe to lower is false, we just go in the higher state
@@ -265,8 +269,10 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 
 		if (!clk_mgr_base->clks.dtbclk_en && new_clocks->dtbclk_en) {
 			dcn35_smu_set_dtbclk(clk_mgr, true);
-			dcn35_update_clocks_update_dtb_dto(clk_mgr, context, clk_mgr_base->clks.ref_dtbclk_khz);
 			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+
+			dcn35_update_clocks_update_dtb_dto(clk_mgr, context, new_clocks->ref_dtbclk_khz);
+			clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
 		}
 
 		/* check that we're not already in D0 */
@@ -314,17 +320,12 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dispclk = true;
 	}
 
-	if (!new_clocks->dtbclk_en) {
-		new_clocks->ref_dtbclk_khz = 600000;
-	}
-
 	/* clock limits are received with MHz precision, divide by 1000 to prevent setting clocks at every call */
 	if (!dc->debug.disable_dtb_ref_clk_switch &&
-			should_set_clock(safe_to_lower, new_clocks->ref_dtbclk_khz / 1000, clk_mgr_base->clks.ref_dtbclk_khz / 1000)) {
-		/* DCCG requires KHz precision for DTBCLK */
-		dcn35_smu_set_dtbclk(clk_mgr, true);
-
-		dcn35_update_clocks_update_dtb_dto(clk_mgr, context, clk_mgr_base->clks.ref_dtbclk_khz);
+	    should_set_clock(safe_to_lower, new_clocks->ref_dtbclk_khz / 1000,
+			     clk_mgr_base->clks.ref_dtbclk_khz / 1000)) {
+		dcn35_update_clocks_update_dtb_dto(clk_mgr, context, new_clocks->ref_dtbclk_khz);
+		clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
 	}
 
 	if (dpp_clock_lowered) {
@@ -1048,12 +1049,8 @@ void dcn35_clk_mgr_construct(
 	dcn35_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
 
 	clk_mgr->base.base.dprefclk_khz = dcn35_smu_get_dprefclk(&clk_mgr->base);
-	clk_mgr->base.base.clks.ref_dtbclk_khz = dcn35_smu_get_dtbclk(&clk_mgr->base);
-
-	if (!clk_mgr->base.base.clks.ref_dtbclk_khz)
-		dcn35_smu_set_dtbclk(&clk_mgr->base, true);
+	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
 
-	clk_mgr->base.base.clks.dtbclk_en = true;
 	dce_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
-- 
2.25.1

