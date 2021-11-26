Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250C8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EBDA6EA0D;
	Fri, 26 Nov 2021 19:49:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011C16E950
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFika5SLEifBoM4PfOle6mdXqUMlfpz0rsi0GRgmQbwe3rsYKvlFn3xvAJ5Sl/mc+vWRkLXn8kBiaqCKPgMFw1J3rcwWHG2+6XDPAhO0f57BxAboaGa/qSKTWmWuJlwtwDl9bPwIz0UtYilrlcF1vvMOSY8wLdc4zwyEir6fyU6DYz3Jg244VoTKjBQ3IBbwlQYUe/q2RO2Df5kPqnQqL2yB8/ZVtl5/5bUtCJB0wIHm9piNhmIUDqK6bnrWvNP7FfSgZt6LCuEQV5Y5sR40Gzu7JCZKvFZEUrwoh6pi1/52co0vrx5j+F1YZL1VAfHEKeCyTjCIeuOlUnnp0oZqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nr5d5Dw78Yt3uH8mav+f5pgFOZAwStetmKPtkG3YUdc=;
 b=bUdvYCLwHwDw4S1YFaCXoSZPS6Vug1joI9ztDTum0cC53ssBQix8kFfLlOl9gFU6IYiW8XPg8px5Frb9vZ+glfxyOd+gFzOQBz0aDxk+hMfviYycaiERoAgsO+f4yXAmWLQc3ZNMmEJ4pv4fFiTfdm9Ey77ygBFiC12LJ8jKBH65fVaxMD9c5qWj9XjTw5X1e1gnh0Gs2+SKrlUt/ZN8tzu7wHynRCWEJdkBAmy9/T57fndrrppsHvN99E5Pp9tY7XbHb5IGYYY91NXCYRUgWpmZXWI4hKXERxy6Ub0k83QUR5bHf+55xcrPs44TZHQmmOItAW5u/FQKSJ++EitXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr5d5Dw78Yt3uH8mav+f5pgFOZAwStetmKPtkG3YUdc=;
 b=snCzo8SSao50ilzQGdIxfaSSXBHgOdkBhukU3WeWWI3UbjmPnKOsSY5FWrJgCG4/aUF+D5Z81c0vfrhb71TgOrRuBz5vFE9wUCiU2LpZuaJE9mVkn8az76JOOefjKfXkGmwEt8UQdYfUhS5dXYun1+R78pkhx+F+q6GbKhzblVY=
Received: from BN6PR19CA0114.namprd19.prod.outlook.com (2603:10b6:404:a0::28)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 26 Nov
 2021 19:49:43 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::c6) by BN6PR19CA0114.outlook.office365.com
 (2603:10b6:404:a0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 11:49:39 -0800
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:38 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Skip vendor specific LTTPR w/a outside
 link training
Date: Fri, 26 Nov 2021 14:49:18 -0500
Message-ID: <20211126194922.816835-13-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa843043-cef9-4ebd-43ed-08d9b115e450
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4573082314C04FDF2BA6E935F9639@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0F6boi8p9xOwjvxv5uPEH2J/HZPb3Q9DWeXD9B2PHHCZpcYyjaql1xFCu9kwmQ2tArvROfuqqfZCWWKbo7RaINBXoIQVs6Z+xRFr/M0hLpljNfjrP48xEuym7XzoPa+gdAerxRNyku9oZTpxqATRb8LC5owlrkg+BYhirOqBcX/5uOejhvL8oFCCT1/ujn91epn2axOQpZwA1duc0kETpZv/bhXyyYhWFpVALRa8NJTrHBRhTU4ClE9HwwtdzG2DhXTkFpDgv6CWJYScvYsW9nFYRbPZeOxy97oyoC5WGk5kxfF+WsSPyvtHtdkOk+NsoexsjnUWkjBEFGC3rRf/v0HeaiF5ReYiAA3yYkyoXUG7vMxbdx+qtojuSLpeCJYY/Th91JJH90POcaTyceyUPVffR1XzCtC3yQ+0KpZGYr0V0it/t7YJ3OBmWG2oa/Sa7mZUdtpq4QPE5JCoaXYSLoVX7DOVljLjzZLYhC0zfTYxz9pzGnX251+2o6MTsp2cQOkIvmJDRaTIE0220vhARJJ5FVIjGNDp1SFigJiYxAb7KtS0HY6uvEWCUFiqUhW+q1YF1kAL7bUbTzTDpFWEN/c46YIBa5J8RFStK20jPleF44BIpheZWwJkVMAbW1Ffz3BOcfjHE00okAWC0/bAPOaZLyX0cjEcYQiZ0ZtKyiReLVXAu/kQUWvApQONGmLJDEHu+kPAslOFaP1cfEvncsMcxYS3gIkawQUIAU/XLEw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(336012)(70586007)(36756003)(6916009)(2616005)(426003)(1076003)(82310400004)(508600001)(70206006)(8936002)(8676002)(86362001)(2906002)(54906003)(81166007)(47076005)(5660300002)(6666004)(36860700001)(356005)(186003)(83380400001)(26005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:43.1951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa843043-cef9-4ebd-43ed-08d9b115e450
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <George.Shen@amd.com>

[Why]
Vendor specific link rate toggle workaround should not be
applied outside of link training scenario, such as when
outputting PHY test pattern.

[How]
Add flag to indicate when link training is occuring.
Make workaround a no-op when flag is not set.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 44 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5eea4ec82f99..026ce0839719 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -444,24 +444,26 @@ static void vendor_specific_lttpr_wa_one_two(
 	struct dc_link *link,
 	const uint8_t rate)
 {
-	uint8_t toggle_rate = 0x0;
+	if (link->apply_vendor_specific_lttpr_link_rate_wa) {
+		uint8_t toggle_rate = 0x0;
 
-	if (rate == 0x6)
-		toggle_rate = 0xA;
-	else
-		toggle_rate = 0x6;
+		if (rate == 0x6)
+			toggle_rate = 0xA;
+		else
+			toggle_rate = 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
-		/* W/A for certain LTTPR to reset internal state for link training */
-		core_link_write_dpcd(
-				link,
-				DP_LINK_BW_SET,
-				&toggle_rate,
-				1);
-	}
+		if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+			/* W/A for certain LTTPR to reset internal state for link training */
+			core_link_write_dpcd(
+					link,
+					DP_LINK_BW_SET,
+					&toggle_rate,
+					1);
+		}
 
-	/* Store the last attempted link rate for this link */
-	link->vendor_specific_lttpr_link_rate_wa = rate;
+		/* Store the last attempted link rate for this link */
+		link->vendor_specific_lttpr_link_rate_wa = rate;
+	}
 }
 
 static void vendor_specific_lttpr_wa_three(
@@ -2383,10 +2385,12 @@ enum link_training_result dc_link_dp_perform_link_training(
 	/* reset previous training states */
 	if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
 			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-			link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+			link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+		link->apply_vendor_specific_lttpr_link_rate_wa = true;
 		vendor_specific_lttpr_wa_four(link, true);
-	else
+	} else {
 		dpcd_exit_training_mode(link);
+	}
 
 	/* configure link prior to entering training mode */
 	dpcd_configure_lttpr_mode(link, &lt_settings);
@@ -2409,10 +2413,12 @@ enum link_training_result dc_link_dp_perform_link_training(
 	/* exit training mode */
 	if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
 			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-			link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+			link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+		link->apply_vendor_specific_lttpr_link_rate_wa = false;
 		vendor_specific_lttpr_wa_four(link, (status != LINK_TRAINING_SUCCESS));
-	else
+	} else {
 		dpcd_exit_training_mode(link);
+	}
 
 	/* switch to video idle */
 	if ((status == LINK_TRAINING_SUCCESS) || !skip_video_pattern)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index a99950883e85..c0ee625aa357 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -188,6 +188,7 @@ struct dc_link {
 
 	/* Vendor specific LTTPR workaround variables */
 	uint8_t vendor_specific_lttpr_link_rate_wa;
+	bool apply_vendor_specific_lttpr_link_rate_wa;
 
 	/* MST record stream using this link */
 	struct link_flags {
-- 
2.25.1

