Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E355C61D92
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 06:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C1E10E115;
	Wed, 22 Nov 2023 06:59:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ACCC10E115
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 06:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNUifFOxckI1MInnbyPWz7DNk79GIg9wGMhryHqY0HuJiukhUtWoTXP5cLjmMIex6xEIV9nz05ycIVWRxG/t2vzCH5k5atyW0Pe8hxqOGefgSw1QJ2G1M//+v2LCeloGzOm8UDXcaDdAjVrYrIhvhIEiUgRgAv3ZUGi8UwZcXP+YVV+/kevgj+zTy/1ObRGN+HtawU2Si3EC9WsUgXOojywjCma0qzrxTxElY7ZJF83a3csRUWVO0JIMogDxrkwLYI9kHgmglfWmD69W9+Ok6Pn5vIlVbyKz+qyMfwOXf0sLo7iy1bsy24m/v9iTBUeAbhjNtuLdj7o9Q/cnDN1aQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn1sO6MA+pckW8KNQuQuXAPpyoTEmvTB5S5ax8jVFoU=;
 b=Hjgj2i8f4pXuY0OKZZI0wLxN5Tc13hpA8aUTu74jmrNP0Ndx+L0AwtfDFQRzp+HA4xJIx8Hm12D+b2GQpxrPCJMCyPAZN9sO2cVTmpax7763M/7gu60OPd8wSerWW3m17GnaSoOF4SftawURMCuTZ/p1iTyunRXuIB8f72GMPp3nok8qVGWJY2u4yYwiIKBIL4MR5seyJ5JQ6alLWal9ZP7n5DY0h8LLcdeVE70YBqCsCNw1cb8CATTRKt1RhHH08iCK4+Vg0HjOrL/kht39GB4e9O4yEnmKFR/1Yz2afxo4Z0EzRsikMAws8iNSReZyYZarP2oWBcS3DFnqkxTyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn1sO6MA+pckW8KNQuQuXAPpyoTEmvTB5S5ax8jVFoU=;
 b=EADlr1IY/0wKmNxu2kF/i9XAL93jc7AyZNtElywJvopQA1gibCCvcbkkbmeS+Y95UdoTZjTQQu3pbdOlNcpa6YWkNOrDzJnTYW1ZAkHC2ct92veVkEXhbO9hCTXMnCHxwlxNoDynUXJemdQTxH0H1t7nNHpxlRTQsU6Oc6eJi3M=
Received: from DS7PR03CA0267.namprd03.prod.outlook.com (2603:10b6:5:3b3::32)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 06:59:17 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::44) by DS7PR03CA0267.outlook.office365.com
 (2603:10b6:5:3b3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Wed, 22 Nov 2023 06:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 06:59:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 21 Nov
 2023 22:59:16 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 00:59:10 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amd/display: update dcn315 lpddr pstate latency
Date: Wed, 22 Nov 2023 14:58:35 +0800
Message-ID: <20231122065841.2267110-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
References: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DM4PR12MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9d2d47-969c-4345-42cc-08dbeb288b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWk+AwG61+9C0ro4KjdRwjQAZOM/f6SHHu4Nw9vc79E3LX7L+J9u6iWCDDW1SQY10suUnYy4Z0505hauBa6h9JuKt+Inbv6FOM+l3cTt7RxygSQQLHs90B4cNRl33/1AOxat1PLbodBUabHAduOGKg4SBrldBM6yVHqvUVvGVjQDpfj3KKFScue9sc9QYeMVg7qd6cEPKOdshtIlN5yBiL8KDSFB5UxVMO7gSvcv6I6ys8+V7kEX6OgM46I/qP4WaKhQdhLLY8Oj9K9wzSB+PkIqLoN7KdWQXL+AA8QGCYBa+/6bm3jFidzsCQmFgh1FnjcyVHc2mXOQ/ZGINl4T9vv+9Hq5NgRJFKoDmFrt++e5rpDAJjXoNnoNugJ/xoES7z4jC/r6NFkgT8UJWLcAMPfFfdOBJL6ZhHIr3cfciK58cNxFo0JrMyJEEYF4zThptQ4ouom2t251u6TvCtqUaR/m3OHHWf3qbfHbzdzXFmVmeqAa3+dEHqGRYY/YcsX56i7vWOGXMYGBeZE6sHbeohe0bn9vFahMhHZ67XSjwELWO5FaGbZYTxqTF7FehM2CiaAujTHjPuau/0dddVsHpYkYzPS/t7+7JYybaACi8rvNDT0UnHobMpLVulbyM+lSyEs/xJaASDzybpvw3afedp+koB/wPpaKIvvaBKbGuZTEaldHmmC55RoYEi8EfSLJKxyzYIbiFiMgbI7JqbREqCf1lnFlkr6VqJdNo1tgDbk9V1ZBVkiOQRSQJRA/d/vv/N9MXnYpasBUVcRV1HyS3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(316002)(336012)(426003)(82740400003)(356005)(41300700001)(81166007)(2906002)(2616005)(86362001)(36756003)(478600001)(6916009)(4326008)(83380400001)(70586007)(26005)(54906003)(70206006)(5660300002)(8936002)(8676002)(36860700001)(47076005)(1076003)(6666004)(40480700001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 06:59:17.5521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9d2d47-969c-4345-42cc-08dbeb288b9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
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
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[WHY/HOW]
Increase the pstate latency to improve ac/dc transition

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index b2c4f97afc8b..8776055bbeaa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -334,7 +334,7 @@ static struct wm_table lpddr5_wm_table = {
 		{
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
@@ -342,7 +342,7 @@ static struct wm_table lpddr5_wm_table = {
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
@@ -350,7 +350,7 @@ static struct wm_table lpddr5_wm_table = {
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
@@ -358,7 +358,7 @@ static struct wm_table lpddr5_wm_table = {
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
+			.pstate_latency_us = 129.0,
 			.sr_exit_time_us = 11.5,
 			.sr_enter_plus_exit_time_us = 14.5,
 			.valid = true,
-- 
2.25.1

