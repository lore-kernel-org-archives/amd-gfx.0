Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA97C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 17:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EC910E243;
	Thu,  1 Jun 2023 17:09:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF62E10E243
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 17:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRAfKO/P5IHRlpBVT47/MYEmzYMBGBUGYCkIWg4jl628jRU+hVaC7OR2TMhQLY/mPKObcf9R6XEIEc1o+RJhzXzjlgrJPib49Akc3fuy6qKN87q6B1G6/tuYUQtN2HIH3FVfPhbGunWmExSTu2ESKy9hqKesYii7RGmwMM/s1a3ss3J951J58OEn5KIs8aQZ5M5sbRMVTuqEDwAwvk8gxtor27OfJX5pc6WVj2D7SNBlwcd5qi6iIavdtVgHnJakJTht2b968DkRFb/OVBYKCfkyyosIlCBAE4HX6LmG5Q8j6OGSuhthV3ePkxR4AOHmWx/DHiSyFJwbEeWgA93VNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txeWdqEa5fuNslMcX2cO4KyebltOUOILRInxik9foNM=;
 b=TDv44+mdOP3kGHvXUJ20cbFyQ6lR0KNaa8NrniyjkNbV+xHTNaGsXA4/cgTVFGAT1r6wrgbA3fTCDZrMtcbTSdS1swcmzK7VKxY8lNMfjumGbmbRPLKVsGnE0EbsThHdMYUtdjYpHJIcQ5XrU9WHw1SFVZ/FvtR+wfUFL8wEuiucm2dBdudUD8W4k0qHmuasUPq/CAqoYqvIzX5YpHACzLiMQs9PlptvYABpgb6zUdtkzKXXMQ8P0DibRWuYngahq1j989BzECfXQi+k5edKhaARddG9cMjfFPKu3ZoT2mfB0mxx9iMhmBRa97OpOy+Lliy2hzXLxrR4rdAI9s0SNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txeWdqEa5fuNslMcX2cO4KyebltOUOILRInxik9foNM=;
 b=Ld3Ho+aMPhqK9CI/QgcPA8CHQS54ODDidXNU+2DsPYgpn/Yf9Rmfj7MeDLriKt+J3qOG+iEPmDG40As7XmSUwSC6I9a0zV8G2144x2YL3Qi1/sIos9oHY92ae0b21LH59h9IPk5oyvptPmryv3RS3DhVGhnHcP6W0IZ4Z8lBSD8=
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 17:09:47 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::c1) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 17:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 17:09:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 12:09:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 10:09:44 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 1 Jun 2023 12:09:44 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Program OTG vtotal min/max selectors
 unconditionally for DCN1+
Date: Thu, 1 Jun 2023 13:09:44 -0400
Message-ID: <20230601170944.1770501-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 1776a82b-0560-4e4c-b002-08db62c2ffc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cneu3TsRfnABGKNtNjz/5hGEou2aMhJjb8ccodPOLNsP1CPnha6l5VEOa8JS9XQrmV/4dQm8JMagkcXtpflk0ptWkTfK0k/DwgtIodUIvASNPQjVV4c95tOchpf98kMJQ5ye64EXJDmb35SlEflxQ5sb835fsC5c5sQxylOnlDehcLrMfZ90DLTIeJ+c+o/Axj3GHuvn0zOBhxGVtbNXjue/69h1jLTjGMwNDqgPFmnnca7pnDgYXOYV8LSMphKqGcQO3GDav30V+AO8VYl0kSZHXNJp8O3UGbtopIUFlkVt/T8cQlnS6NDneX/tV0rWyctsi+NCX/xzYfyhp4tl6zkA+I6LIXw+QoXGfDVf3CUSJVQ/rRDfmrl5u/roZexGU7sDGq/Iqp0mn+eDWYr57jBh0BJHWYJuxazq+eHXIbcqo08d9x7lhZk+wl+WjdeTgxP41Den6CDoRrl4KUnXm5SxKf62OjsrwuBGYecL5AEZ12wLx+kSsP/lAwLKM2rG6J0lFcWWIDk9UbELYeoExfKDvF+sC9i2dh7dJ2C2ycq87WygucuZrtqwTB5ET5hLyzIyBftBALsNaJS+isv/jEarNxBlUsRWMo7Mh6ZZHtXTU3ptBFfdDNvUGCSrJPLgmJepPqDjFK485Wfv49aTjSIRlMmVPfMG0vOkOPes2FntboIV2rGMTuIvVG5CP+e38E8/Gk2Ov667v/jv5xpevjDXcjReJfafLRrgoBcjbhpKqDDjN/bDGk6p2ASSBKXUCvKm7ZnCCJQW8cxfP7oaDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(7696005)(36860700001)(47076005)(36756003)(83380400001)(426003)(336012)(2616005)(86362001)(82310400005)(82740400003)(81166007)(356005)(1076003)(26005)(186003)(40480700001)(2906002)(70206006)(70586007)(6916009)(4326008)(54906003)(8936002)(8676002)(316002)(5660300002)(41300700001)(44832011)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:09:45.6311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1776a82b-0560-4e4c-b002-08db62c2ffc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
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
Cc: harry.wentland@amd.com, aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to FPO, firmware will try to change OTG timings, which would only
latch if min/max selectors for vtotal are written by the driver.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 15 +++------------
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  6 ++++++
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index e1975991e075..633989fd2514 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -930,19 +930,10 @@ void optc1_set_drr(
 				OTG_FORCE_LOCK_ON_EVENT, 0,
 				OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
 				OTG_SET_V_TOTAL_MIN_MASK, 0);
-
-		// Setup manual flow control for EOF via TRIG_A
-		optc->funcs->setup_manual_trigger(optc);
-
-	} else {
-		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
-				OTG_SET_V_TOTAL_MIN_MASK, 0,
-				OTG_V_TOTAL_MIN_SEL, 0,
-				OTG_V_TOTAL_MAX_SEL, 0,
-				OTG_FORCE_LOCK_ON_EVENT, 0);
-
-		optc->funcs->set_vtotal_min_max(optc, 0, 0);
 	}
+
+	// Setup manual flow control for EOF via TRIG_A
+	optc->funcs->setup_manual_trigger(optc);
 }
 
 void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index e0edc163d767..042ce082965f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -455,6 +455,12 @@ void optc2_setup_manual_trigger(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
+	REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+                                OTG_V_TOTAL_MIN_SEL, 1,
+                                OTG_V_TOTAL_MAX_SEL, 1,
+                                OTG_FORCE_LOCK_ON_EVENT, 0,
+                                OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
+
 	REG_SET_8(OTG_TRIGA_CNTL, 0,
 			OTG_TRIGA_SOURCE_SELECT, 21,
 			OTG_TRIGA_SOURCE_PIPE_SELECT, optc->inst,
-- 
2.40.1

