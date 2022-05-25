Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62431C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA5510EF44;
	Wed, 25 May 2022 16:20:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 207DB10EEC7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox7/eyov4LYcV9KWv3EDcIdlO/nlmKnM+IHVT1Tq9J7LeZkJh+skjGqEahfhTrXIruabGFV9nYSVYuqlUPBXe2Kic8hm4Ng1BDLPHh34Zb+r0ddAf/t3ZZJQPis0lHg/EWsS5OVBmVVSdKi1WRh9W9iSuYVw3UPZRhtS62LKdNXucAVX5cYs4rBdVVK5MQ8K1YOEYOyXo4mBbA4LXVqVk0E1eTWGPtAtJBfvlgeVo5tgpRHDAcQZaYcUeQanMHqNazlpzuAIC/fY/ljNedVuUQWT1W1fTwKm1J83M7tYUCkC+Wv/a0gb4+SI6xGuyw7ZMXuid0BYRCgYVDrXt+x1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ranuC5YnNnIsysYbKVVQ6Gyy0FnyRQwLtnLFdD1Xy8M=;
 b=mqu0OiwxB0yogqyqw6iQmbKs1d/TjV4z8Ns7UjZZZNokDtOXh6YfOG18XzR8fRilj0NO+nkjYvLt3K+4kiMF0g0P8plxRrf0eswGQ7DKPt0eeTYuyO2LLMlXEuCb1IZfYRiBhC3+rPHujDVZHDrp4niR6eJezekoUsgGkgm3rVNpHQNlRxrl0Kr3S41vh6H7+Xtl4DjYKdGNMugKKD6joK/mBUhc/rD1P2PYqE0SGiIgO6WUhbdPcs9xFQJyoIrKEX8dUiJtd0m1qcaUtDHKWOa0Iqksy1AdXR/GXonaJTGCAFQIKadI42zQAvqXe9yOoM4woVhADwAEl74fKUzfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ranuC5YnNnIsysYbKVVQ6Gyy0FnyRQwLtnLFdD1Xy8M=;
 b=DGmBUtwcfx3pKt8QYT2IDwsj2IjHDSi260rr9RCw7wbez9t7ImIyHlr7MpCe7GulhFp6jN+e9v9oarjqYgdwt9giYOnQvvibyxuC6Fqcrj71mIwsn5ZnhtxY24DRBoc95eJZA7nQiXGFpEO2rG0icE6oQbH4IDCI4iUn8ai2tzY=
Received: from DM5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:3:d4::30) by
 CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.22; Wed, 25 May 2022 16:20:18 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::3b) by DM5PR05CA0020.outlook.office365.com
 (2603:10b6:3:d4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/43] drm/amd/display: set dram speed for all states
Date: Wed, 25 May 2022 12:19:26 -0400
Message-ID: <20220525161941.2544055-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19b82b95-9d8e-4921-414a-08da3e6a7514
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB61794823ED005DCD3855D4B2F7D69@CY5PR12MB6179.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2o8FNhTBV80vOvGHw78+Z/rmVuwhwOXvDVSg/7Nregj42BayXFJCb8RoIyOBoVbz7+zWupEtBTp3X+U/K86WZeTOqa8DK1MeBmwGnWHQYzlsUGAV3MqZXZ79f4uOZTw7VoN7fWgkLDKi5T2Se61qL+ZoPG0z1c03djjRGWzkhxYUILZifDxWw2wceT52AZQaF/hOlCuM+lKwSMDOIg5KNGDruqKDLKtDhvKacwaptPvzVDqCJmHRzbWuw7t+P2XelkmNzGcEBLgHoQKeK88SmY179eGCF0725Wyfuy7FvLgbPOYGiV6QVflUufQNM2tNHJcyNUjxMdRX9rEzODgk8F29kPVZGdk37LBgx5CBpWKee0urwUpeYiN2X7rCUT0goOvnRHjUhOhsQkEx5VozXdxICOIHS5piT/Ieu1ZmD1MLS5yY0jeIyYgVWRvtUaehfW9ZTgjZchJFA8xwYpP2VfOmQphOjj0caSplOtHuwlvbdqbiaaijXe4B3vn76W8jd/RNgotcJ26fKOnKRNpS9O/ajy86xlO1/NC+HxlsfbaZkBnKdbTHzjiX8NCEBaHklE+94EcqxN/8cQ3+SzdjRj6a2/2U6LPCz5EMjJMQBk/HwHYor0zrqfdSg+FISjAfq/J2WGXyNZevQ6xFZE4bR5+TWn0jYj6BEmtJIOtkMmplW9qb+0mPWFDlUVmDFsclKeuowPgno+D+lW+XVYzEgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(82310400005)(36756003)(4326008)(8936002)(2906002)(70586007)(70206006)(40460700003)(86362001)(8676002)(5660300002)(7696005)(336012)(81166007)(54906003)(36860700001)(47076005)(1076003)(26005)(186003)(83380400001)(6916009)(16526019)(356005)(6666004)(426003)(2616005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:17.6970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b82b95-9d8e-4921-414a-08da3e6a7514
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[WHY?]
If higher states have memory speed set to 0 MT/s currently they do not get set
to the highest value which can cause validation failures.

[HOW?]
Set unpopulated higher states to max value.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 6 +++++-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 7772beadd000..3f93b1f2d872 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -3549,7 +3549,6 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 			dcn3_2_soc.clock_limits[i].state = i;
 			dcn3_2_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
 			dcn3_2_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
-			dcn3_2_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
 
 			/* Fill all states with max values of all these clocks */
 			dcn3_2_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz;
@@ -3568,6 +3567,11 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 			else
 				dcn3_2_soc.clock_limits[i].socclk_mhz = bw_params->clk_table.entries[i].socclk_mhz;
 
+			if (!dram_speed_mts[i] && i > 0)
+				dcn3_2_soc.clock_limits[i].dram_speed_mts = dcn3_2_soc.clock_limits[i-1].dram_speed_mts;
+			else
+				dcn3_2_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
+
 			/* These clocks cannot come from bw_params, always fill from dcn3_2_soc[0] */
 			/* PHYCLK_D18, PHYCLK_D32 */
 			dcn3_2_soc.clock_limits[i].phyclk_d18_mhz = dcn3_2_soc.clock_limits[0].phyclk_d18_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 0b420466b6dd..27d3aa7d751f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1899,7 +1899,6 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 			dcn3_21_soc.clock_limits[i].state = i;
 			dcn3_21_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
 			dcn3_21_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
-			dcn3_21_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
 
 			/* Fill all states with max values of all these clocks */
 			dcn3_21_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz;
@@ -1918,6 +1917,11 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 			else
 				dcn3_21_soc.clock_limits[i].socclk_mhz = bw_params->clk_table.entries[i].socclk_mhz;
 
+			if (!dram_speed_mts[i] && i > 0)
+				dcn3_21_soc.clock_limits[i].dram_speed_mts = dcn3_21_soc.clock_limits[i-1].dram_speed_mts;
+			else
+				dcn3_21_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
+
 			/* These clocks cannot come from bw_params, always fill from dcn3_21_soc[0] */
 			/* PHYCLK_D18, PHYCLK_D32 */
 			dcn3_21_soc.clock_limits[i].phyclk_d18_mhz = dcn3_21_soc.clock_limits[0].phyclk_d18_mhz;
-- 
2.35.3

