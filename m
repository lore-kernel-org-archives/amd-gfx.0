Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1637AC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C3E6EA2B;
	Fri, 26 Nov 2021 19:49:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CF4B6E857
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ1iFNPROL/jOmcH2SLYhzcj1cWobi52oMYxfiO347+OQnyz0jlBDb6IEzWrf5CFkhtfMoozG0OTpIpX5c7joUDObsGhBpmAxZ1OTAQNschgJ2PE7vWlwN+c75vE9GGBPIkJL0kO2CSeddrG+GP3MZ6uUcV278ANB5LHaesmk5jedGzrIU4l+lfIbUxBz5tUf6p3AQDnwe32hMQmfqRjfVxi6kXg8L7CQB//xKT2kMReXbsAeNPrx8hGZpnr2Gvve7QirySulIv0JI3FDxe6nz1fj9IyuT44yVC6hsLVeOjKh953yaIgH5U1FZQ9cEdKoMMeWa8J62dvRz710Lh17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMQc349mi6Fo/zqCOdL+u0Bs0pkwt71vS6d0Nsgh1Fk=;
 b=GJF9P3Z4zONFAEYcgCEsUWztveSNrRcewIHRk7jwaI1oi74nhJh3Km2g/5nsIwmS/HHovN9L7AVpxe9Ypcq1yMaVicv1IhhZzrQZKS7soikE46E93b7vgPFKCcw0xUOAaLExnciMDLH7skrSFFh0MenknsqZxPl57on8+MLaRAaRhQvuReR4e2sz8/She+m+5L9jPxhnns8yw6fVpMtLZoZwmN/hS6Uu0pKZkngJNkO/7wbEB793cF+sD+X6JzkPDKeEekg1n7JLFuO2E40rCrL50wz9bPE9/ri29y3kyvl+cQaj0g6IeC0pDozXVGldr9MgY1itmdOsbP4x6GYOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMQc349mi6Fo/zqCOdL+u0Bs0pkwt71vS6d0Nsgh1Fk=;
 b=5VBsUS2sPmLzRYZcMZRoHsjBZxGBt9gHFQwmh5yUZnD6p7d2WMPMlx977iTJthc3f79135zT9fQXpIFHYJ+Sr2SO9AsbZRckBR/Vs4y+/5wf6ViqZ6UQkjb5v02q+Vj4rPMZbgSY4sx8a9Zwal7bWRxKMvZLD3kPQKMrGmjCmd8=
Received: from MWHPR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:301:14::17) by BL0PR12MB2819.namprd12.prod.outlook.com
 (2603:10b6:208:8a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 26 Nov
 2021 19:49:44 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::f6) by MWHPR1701CA0007.outlook.office365.com
 (2603:10b6:301:14::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:41 -0600
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:40 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: Add 16ms AUX RD interval W/A for
 specific LTTPR
Date: Fri, 26 Nov 2021 14:49:20 -0500
Message-ID: <20211126194922.816835-15-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86a8af0e-37e4-492c-c149-08d9b115e4b3
X-MS-TrafficTypeDiagnostic: BL0PR12MB2819:
X-Microsoft-Antispam-PRVS: <BL0PR12MB28192F8B885FCC1077A8369DF9639@BL0PR12MB2819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXhdZwUO4KX4t3M0zIxxVc7yUJQbuMq9arhl5zCPhxSrAK5AU9pwVjXmxPP09d3qqxDNaW/JaZyRTEGH4uk/KepLy3curRf+Ks4/qic7eQHkFHoCWqspCNFm5PhLUmgDJJTfPBMG0u1G45n1og/FJouKy5DMac6/Q9tEAF1C0dpPiXWLKn/FL05o0LmwrhihSaGj5NKOMUUSuD9aimZwsuFcvszh/YlAJckkVWitw3dh8mqJrbb1/+M8qmYoz6s3vib/sSMv4jxZ6mRy1ZB0c684fk+2Z8hF6707rTihMOrDqjMgfVR7TWXUmy8/dcLsBRjBm5Lr0aqshWVG0dpBkJsVEi5S/QNvjs2A4Jchw79UhjJagJjy1svOnATSGOQzClQJP4AYeTNKCSGkY600QYJTkIBZroVA/VaUuiiwYgn5+jhsy5C0QeYdXG8nDkbMpZvMfYlIA3M4bt1KY0owzXUbSgruYGui4FmabkHq6KYbUsfkMOBr77mpf5HOwyz6QAfJu1zPO+pDs+UQeNRoqGxMIHddYI7GBwEqmdYx7B/d8ug7Di2vhTepRE9eXJQbI2k1mDosWNpenEOkakhJ/mg0AC5UInxQ073V9+g2Jij6hEj6FGHWzmihLvmNWzOdQV+llB2ZfiRKaf3nPadNMVxMQxN5JslMZd1sfVgOUmKed/4GK3dSInv17BP9MX5puNSGNspYftzpgdM84lUQcpJcDEgMhLAbk8PT36lNbb4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(5660300002)(4326008)(54906003)(6916009)(508600001)(83380400001)(316002)(356005)(70586007)(8676002)(2906002)(8936002)(336012)(86362001)(70206006)(36860700001)(1076003)(6666004)(2616005)(36756003)(186003)(82310400004)(81166007)(26005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:43.7441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a8af0e-37e4-492c-c149-08d9b115e4b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2819
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
Certain display configurations require an extra delay before
reading lane status with certain LTTPR.

[How]
Add temporary workaround to force AUX RD interval to
16ms for CR and EQ. Needs to be refactored later.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 026ce0839719..28baa84102da 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1384,6 +1384,12 @@ static enum link_training_result perform_channel_equalization_sequence(
 					dp_translate_training_aux_read_interval(
 						link->dpcd_caps.lttpr_caps.aux_rd_interval[offset - 1]);
 
+		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
+				(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+				link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+			wait_time_microsec = 16000;
+		}
+
 		dp_wait_for_training_aux_rd_interval(
 				link,
 				wait_time_microsec);
@@ -1487,6 +1493,12 @@ static enum link_training_result perform_clock_recovery_sequence(
 		if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
 			wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
 
+		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
+				(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+				link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+			wait_time_microsec = 16000;
+		}
+
 		dp_wait_for_training_aux_rd_interval(
 				link,
 				wait_time_microsec);
-- 
2.25.1

