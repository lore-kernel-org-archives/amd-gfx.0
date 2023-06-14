Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75F5EB64D9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B5A10E160;
	Wed, 14 Jun 2023 17:58:54 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442DD10E15F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze1nfbjMF/95d/xWlBT27PmJ9YL/18p0kVoLBvu+7O8VSiYASQ9Mp6rgCobXtK9mOFG/8CxEa9FSlbRiLrJT5oxRgZ5bwyH5vFH3PYns+4MCMvKXWoR+O23TkRnH9rES/o7ugIEh6BAXntqUJtUKWI+ZjG6wvoghLNCYCxibaiAl4q8uLLFx78Ir9Jg3BqaV5s+D+mZqHbYrwTyGFgocIbTuCP4kMLUvzXiu7nHJSzZoZ0uPTYd9/8bsNywhacCw4o6edZoRir64557yHoZhNgt5mBMSayB/2BG28+02piZzSFS951jKn+o3UX2CTYaEfeNdvWjtvcQlYxOITVbHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbNh59qCjLPxo0bdFU97EH87TfEdVqV4dMAfSL5QCwY=;
 b=hXiGmvv0VJinFx5sL6UY7oEfI4rKaiRJ6O/VRiWO6giz75tkmS7kSiRhzngzqadLYQU9i24m4WnMiKNUNVAAytjuV6qOXx/jVXY8iI023cr/uUelmpUdAKV+IqAfmohf7k6DE+3BiQV51VRU6OuRSYQbeCKG3ROSfPy5LGcN6waFLCO97exXNlLXdIcBzLUPhiaSsv8hvEt8xYeBG4K1iyOtYANcsHs0OcbL5qpEXDHdrh7t3drGnWWRp3JDJX1jU5cu0QnQoP/4VwHZoGOxmtIQRj/KuDzxZdZHJcAMJirhJHouv1w5ZvKDAVctj5lUvbEufp6s9JdzLfqwFA/VMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbNh59qCjLPxo0bdFU97EH87TfEdVqV4dMAfSL5QCwY=;
 b=F415y1mjJnvcvcTX0GhqRHKXVL5aef6VIGUAzo9ITfW1TCY0znVfnO5vcagFJXWpZ/uYeU/CHAmq/j7yoF2wBPgc0aaveLLXf44kbxFUBI4QJu6pgKTrf3XJiKvKESHs0ENk2VbiOw9c+7RpYl/Q6Ik8QeoT4je5/SiRZuMXTqc=
Received: from MW2PR2101CA0026.namprd21.prod.outlook.com (2603:10b6:302:1::39)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 17:58:28 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::b6) by MW2PR2101CA0026.outlook.office365.com
 (2603:10b6:302:1::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Wed, 14 Jun 2023 17:58:27 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:26 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/17] drm/amd/display: Disable DC Mode Capping On DCN321
Date: Wed, 14 Jun 2023 13:57:44 -0400
Message-ID: <20230614175750.43359-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e7da49-c9c8-4ca7-08cd-08db6d00f504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7jXkZd9PbPRRpjU+tlgpFjhmUg1TdrSK0QG5nuisloApF7LTld0bwDm5OZLsDFhaQSMdpfmvtuBjFQxgYKr7dOVTrFMiLIL1To7yZM2SFLQlNxRyGoo1dc+wSkIvpSoR2AGXFLpa58QYWlrdqS7Q9+idHjiwmqgUEDL6MDh4N1HixoIWyc7T7NOYwP6CLlHJPoVTjl3lhoDDq0dRefFrlvf8N2oEJ10UoYePqeb8TL5VLZIa34TJ97aFrBMT0JbmWIT4/l+t/E1y5I0R5WWz1wtgSGigE2QQR+W4oT5c69YFUJtPz7VjJ00GI5hfFmP1ChVD2nQfoDj9Y9TtthJyEnOZyZAn6u/r1UT+dECEP633LeTc+T67nrimUEvmuvlYR+dz1ZOSANx02Gbu3gAjMHhAtdnHuvjkX+qMub9EoAsQawWiDAtkYNU7UXMMEwtry7DPRb8web4LaT04jQJChfSM+HKeaEfYYr8wQEPJak9i7tNs1V8HHe+3Zn+gvbnvz9iiacqpfknDzb3+PXfjwa6uraX4S5iOGAs/IkNWB9rMRBYLhCbsVaEDUdBSoQmey9/44mqUbRD9MfAK+hN7B0y1w3HsKls4aYIPoHdK8PjrSsNehnKTgWc1k9xQkzLww6Y/adebGOsv9tq86gfV+PE6hmRtOAyidkRd1ycp8y5TRsHL5pSTfhlwIHFGXxN16gHxc52RGV+CllVMApKzsJCMeawwWNnkx2oOXziyNgu14/lMhNFwGpW/fp+8qbHVI2VvpA5Se3szHZNfApiIXTgLRGv2tIalawoie3gUXLNHLdw6dyP3v+8H1NKeSCn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(54906003)(82740400003)(81166007)(356005)(478600001)(8676002)(41300700001)(8936002)(5660300002)(4326008)(70586007)(70206006)(6916009)(316002)(2616005)(426003)(16526019)(36860700001)(186003)(47076005)(336012)(83380400001)(6666004)(26005)(1076003)(86362001)(82310400005)(44832011)(2906002)(36756003)(66899021)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:27.9760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e7da49-c9c8-4ca7-08cd-08db6d00f504
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
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
Cc: stylon.wang@amd.com, Austin Zheng <austin.zheng@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <austin.zheng@amd.com>

Why:
Limiting clocks to DC mode max results in some
display modes to no longer be supported

How:
Disable the path that limits the clock values

Fixes: d65f0d2a2a2f ("drm/amd/display: Filter out AC mode frequencies on DC mode systems")
Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn321/dcn321_resource.c    |  1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 28320c608aeb..ca409a441953 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -731,6 +731,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
 	.enable_legacy_fast_update = false,
+	.disable_dc_mode_overwrite = true,
 };
 
 static struct dce_aux *dcn321_aux_engine_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 190776063f46..b26fcf86014c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -415,11 +415,11 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 
 	if (max_clk_data.fclk_mhz == 0)
 		max_clk_data.fclk_mhz = max_clk_data.dcfclk_mhz *
-				dcn3_2_soc.pct_ideal_sdp_bw_after_urgent /
-				dcn3_2_soc.pct_ideal_fabric_bw_after_urgent;
+				dcn3_21_soc.pct_ideal_sdp_bw_after_urgent /
+				dcn3_21_soc.pct_ideal_fabric_bw_after_urgent;
 
 	if (max_clk_data.phyclk_mhz == 0)
-		max_clk_data.phyclk_mhz = dcn3_2_soc.clock_limits[0].phyclk_mhz;
+		max_clk_data.phyclk_mhz = dcn3_21_soc.clock_limits[0].phyclk_mhz;
 
 	*num_entries = 0;
 	entry.dispclk_mhz = max_clk_data.dispclk_mhz;
@@ -427,8 +427,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	entry.dppclk_mhz = max_clk_data.dppclk_mhz;
 	entry.dtbclk_mhz = max_clk_data.dtbclk_mhz;
 	entry.phyclk_mhz = max_clk_data.phyclk_mhz;
-	entry.phyclk_d18_mhz = dcn3_2_soc.clock_limits[0].phyclk_d18_mhz;
-	entry.phyclk_d32_mhz = dcn3_2_soc.clock_limits[0].phyclk_d32_mhz;
+	entry.phyclk_d18_mhz = dcn3_21_soc.clock_limits[0].phyclk_d18_mhz;
+	entry.phyclk_d32_mhz = dcn3_21_soc.clock_limits[0].phyclk_d32_mhz;
 
 	// Insert all the DCFCLK STAs
 	for (i = 0; i < num_dcfclk_stas; i++) {
-- 
2.40.1

