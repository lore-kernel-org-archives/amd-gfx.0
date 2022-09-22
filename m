Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E076FECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC5610EA10;
	Thu, 22 Sep 2022 00:20:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBA710E9F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJMi6nA662sAIGuRWblW3mTp/GW/julwn43R4hkuRZnQLkrLtIlbV0F1ZNjY8e+wEhSb0F35Fuf6esn5d3/YJNf6fK1zvD/q9/4lSDQEq2ApyJDUiJDNtJHh+C3vvsA3ZCpTrOUiB2o8/lqp0cXnVWPW0zdMNv9hvOzEpHq04LgqBaqp0dzfvMIwdwRHFhbeW61Fpdywlh8smt9h8aLC7Vbx5XaV+cfb7SJQj0cAnJ6c1cbfZh/Gluukx4rhySDMA5Oc4F26qk0gZhlZxiBYshDUXUp8yx3WJJBb1yJJvTW+OPPQIOB2QtrjlIoe40RYJOPLrDae56wysT35/teo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4VvUDV4KyywcsBEuo4U5FJ0OfeEpJjCF/lrLPg32P0=;
 b=aW7jQQGf4iU4V5cy+2uhBDU/bJbJKoqjeqh3ieZyVrR4o33BfmcNPpOptCTf6zw1UjTEJPx7ZATtZN84Fwc58Gvdnxb9JrXCbTVrb5/zE2PaRSbeZDSiZGTvB9k1ra7vL//7WTLLSRA/iqW7MjEMFMaG5FjK26K/cDp4ElRm4CwX+msmuknIFUDghYobPGGFCQM15swWRaVdvYXCOP7x4D6Ff2xBNuBAy/d5hTN9j75SB0xrb42M80kUpJOH4P8jXwPjuXOVmg0gh93TyJ190j3OH7k37crXD2v6v0XaNXs7Cy7KV01Ms1wWNduZV4t8jsCVTqXCP7DVQKA3Pa4aQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4VvUDV4KyywcsBEuo4U5FJ0OfeEpJjCF/lrLPg32P0=;
 b=pn1pWeYBNtqYjJ2x/V8ijkIbXSM2vij4zlHAPN6m8HIYbP15Ji5VL98+5HmCnPIvtv8LQgZR4cB3FbB8Ovt8YKn39Uu65SQAB5bmFG4gK1dISW5t4tTVhZNK8TxLNghafszGB7N2e1JnFadEwxCw05xHGj/vMGqmWJhYv8RXktU=
Received: from BN9PR03CA0886.namprd03.prod.outlook.com (2603:10b6:408:13c::21)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Thu, 22 Sep
 2022 00:19:23 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::7c) by BN9PR03CA0886.outlook.office365.com
 (2603:10b6:408:13c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:22 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:19 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/31] Add debug option for exiting idle optimizations on
 cursor updates
Date: Wed, 21 Sep 2022 20:18:13 -0400
Message-ID: <20220922001821.320255-24-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc7d4fb-4938-4ead-9224-08da9c301970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpO48/XK8Y5+R3/kGDfM3H4SpMTM/BwTKIwDOBtXNSP/z2Pl8U9nDfYhFpSBNNxt4ZrbpJf7E2JIR3YV2XYi0blk41D7D4ulffIIJGSSt5PL6icbhj8DlfLVkHGk//+7MBEY/U0cChxdywJx2LtK6C8Ws30R8sCkMuYi26316t/cOlNkVx/FERfNoc3HUtTq3u8MP6dPlNWVJBMBg0WsRo39uiYaHf+ZImoDgZfjmOGVYnD4B1/JFZMbFaTAvziuQzlJKln1TAevduqmYNNwaaHMbMie62MlFTSCFDd1HkszlUgJvHh9PVtlKLRghCXNL1crblgopV/hUzPzEolqBYQ8bT4jIKXk4SDz6JO/UICLzTBjYib6iZvd8QARYsPH0Uoij/Q+K+VWJ8ZH+Vz4vRWtNffBn1hVY3WLQEBG5kOJ6dVWC/Eg6SB+oQxnck3CK+235FTdry/bk/e2+clpxBA8+rQudDf/4tnpomQcohsaYP5nSYq1BLByG2l+MGc4k54d0WOvyYIObtgi6wCBycAYUktRKRb3MuyoNn6Pd2DrHy3WXy/yfu2rFgk4JVPt/F9OcWcx5RalcJl1wcQO/a/lEwepwnD9Tsn9qb6D69mwspbcJK4XAWeEnXBv6wsL9mj/Z/1liqqwbsRKTkz/sKvtO7lxj8+srAzTB1GWzo5nzocA7ehIxJQJBa9PvooB2Byskai8f4fPKoKaISfZpM+c+fcCSoR/jSZA94zlmbdJch7X/PnUb23psn2JbTqMsMWGoXWx8P8t2UswvkyJlSS4CRpb74/sF9YQd6kGa6E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(478600001)(36756003)(40460700003)(82740400003)(356005)(81166007)(2906002)(5660300002)(15650500001)(336012)(36860700001)(186003)(70206006)(4326008)(8676002)(54906003)(6916009)(316002)(8936002)(70586007)(41300700001)(1076003)(426003)(83380400001)(16526019)(6666004)(40480700001)(47076005)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:22.4736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc7d4fb-4938-4ead-9224-08da9c301970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Brandon Syu <Brandon.Syu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Brandon Syu <Brandon.Syu@amd.com>

[Description]
- Have option to exit idle opt on cursor updates
for debug and optimizations purposes

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Brandon Syu<Brandon.Syu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index f6f3878c99b8..3a3b2ac791c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -724,7 +724,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
 	.disable_psr = false,
-	.use_max_lb = true
+	.use_max_lb = true,
+	.exit_idle_opt_for_cursor_updates = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 0c2b15a0f3a7..559e563d5bc1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -700,6 +700,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dwb_fi_phase = -1, // -1 = disable
 	.dmub_command_table = true,
 	.use_max_lb = false,
+	.exit_idle_opt_for_cursor_updates = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 4fab537e822f..b925b6ddde5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -93,7 +93,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.dwb_fi_phase = -1, // -1 = disable,
 		.dmub_command_table = true,
-		.use_max_lb = true
+		.use_max_lb = true,
+		.exit_idle_opt_for_cursor_updates = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index d97076648acb..527d5c902878 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -77,6 +77,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.dwb_fi_phase = -1, // -1 = disable,
 		.dmub_command_table = true,
+		.exit_idle_opt_for_cursor_updates = true,
 		.disable_idle_power_optimizations = false,
 };
 
-- 
2.25.1

