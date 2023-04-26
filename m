Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305FDC77B78
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 16:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C611010E46E;
	Wed, 26 Apr 2023 16:28:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252C710E46E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 16:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iobVmihoNYaEpsu6YH+gziPsKD1NP/rulkozy9O6vf1tWfM2uMvkH/WqJE6IM7ik9mozKOHNY6GUronFG+gSKrmqhAwX0XBylvIQWmqHGh95OaQOgJoNJQMMcIStlqzreBDMZEYkNk3hh1+4qIyQ5qt+o8JKqiq43Ud6oxmoR0QdxcbxlFUIOa5qfBQOFTJ9y0yBLmATFAjFjRqpThEqGJaLBWO9GnIZWc5QULLudpVAc1WSSAPD2FMVXpPBTWB3bYuskr/YLLlZ8zEZKDbd8bIGfTdnr4pC/EwixjyRelt8ZcA6FKxH7tIcTi+RECsdsyu8VILwxMdkidNNHtrmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re3vSK1AbqhaYk75qrUSGv/G39J4FnyVvmLq2VPaSWk=;
 b=WVe7Liw6tsq3bltxpdAsOcqsQE1Tbl6SiA8qeS22yPZcIsSvao28cqBbdQ+LCcb0APi7Qwcu+YZGlXSN5E9DV16BHGCDgBUK0XCTC9bnQl4wItiL36DflYjiq9sRRIX5wngcQQ8Ykpz468NlNoQs+jt/3Lz9P/vBCGFCHvy7qrHWk2USnJaSMI9vj0RzV0LcgCga7xYQNptc/P69ks0fvSeCY/0XnhykuLbH/D/hv+VX2Db0tqHpWin/gimZ02lmu3NzkiL3udIk15Si9M8AO4Vq1bJ6XoyNoKBMxivrO065KNegWKWsGlzmDRFCeIKmAnOLeFdAiD5bUTBhXhfOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re3vSK1AbqhaYk75qrUSGv/G39J4FnyVvmLq2VPaSWk=;
 b=lyavPuZtXE8+KoAywImROAbeC7G0Pz0QiBijPZYjJ+nbW+1mEN5r4jEp/orrB6t/Dmw3IC8v9ncDlnAPqC7nh85hhyBn5r9KPM8IjOPPCshx02fWZ2y2f146e8Oknd2/O5A4PO6EFkcfK8P/TIhGyB0eUMoUgf/EG49Sk25OZS0=
Received: from DM6PR02CA0148.namprd02.prod.outlook.com (2603:10b6:5:332::15)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 16:28:04 +0000
Received: from DS1PEPF0000E63D.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::da) by DM6PR02CA0148.outlook.office365.com
 (2603:10b6:5:332::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 16:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E63D.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Wed, 26 Apr 2023 16:28:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:28:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 09:28:02 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 26 Apr 2023 11:27:59 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amd/display: filter out invalid bits in pipe_fuses
Date: Thu, 27 Apr 2023 00:27:08 +0800
Message-ID: <20230426162712.895717-5-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426162712.895717-1-HaoPing.Liu@amd.com>
References: <20230426162712.895717-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63D:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: ed39bdf7-6fca-4143-d7e3-08db467335af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfvAhMTpIbwZy++YJUy+EKhEbOTL2FY/TGXD8Du8rqpuYOinz+1/k875GVhlx4PWwqtxhduCxQVaq/yvshiwxaMBoDz7++NOli6mb4eTIEDyNnnyn2LFh+WBC2FXZWMYDe5ZH8a1WdQUZk29N70sF9uR3zdLerYbUc47s/pV3BgwYVK7Psv1CT6QHsyIo+pW5xZsmeqZP1Oe/9rHZD1TzPMZN1PGJ61wGJzgaIGh4a/5Ei8bORc98HDjv7YC45mOB5Du9Sk0G5zPxy0PxOkhH6UGLirM8Y8s9mdG6TvBOl3HYzM9LO5ej8/QqM02+AbBPdwRUHbuioHi48XpKSVnevtkbBcRFR6jCuWjd9iRn39HoeUwic9h291vS3nh/rXAmY6ufBrSJUPqwTpwF4GUA4n558rCGwfNRnQr/4ZeogJw36oKKc7idZsy01QPboFgLd9Gd6DQwyDfDcHWIhEz5efxYz9qhRiW2CC18LGR6dd84trh/gjy5vuZwM99L8yxXDEai8MX4hQZsFky7Z1T0T1o9m/0hPg/feWoOWuJ56y4ur19nM7NBnKhppgttoS7cHtc75+y39iGuIQknbQBI7DWDxbYGQYHrCjvrx3ngbaV7Fj83Kre3W6hu6oUKhdOiE6MoVU9OeQ34RQ37+/pGu9YH8Xa1KW5dY7I7rjnUk+h+C6n8FQdazrZCaDi91iXzWuiH2JLs5rTxE9RvcO5RQ6jmfAImHo9raxu8GtGGvc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(81166007)(356005)(36756003)(40480700001)(8676002)(316002)(8936002)(82310400005)(5660300002)(70586007)(82740400003)(86362001)(41300700001)(2906002)(6916009)(70206006)(83380400001)(4326008)(426003)(336012)(47076005)(6666004)(1076003)(26005)(54906003)(186003)(7696005)(2616005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:28:03.7707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed39bdf7-6fca-4143-d7e3-08db467335af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Reading pipe_fuses from register may have invalid bits set, which may
 affect the num_pipes erroneously.

[How]
Add read_pipes_fuses() call and filter bits based on expected number
 of pipes.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  | 10 +++++++++-
 .../gpu/drm/amd/display/dc/dcn321/dcn321_resource.c    | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 7feeba78c0c9..a49323885874 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2082,6 +2082,14 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.restore_mall_state = dcn32_restore_mall_state,
 };
 
+static uint32_t read_pipe_fuses(struct dc_context *ctx)
+{
+	uint32_t value = REG_READ(CC_DC_PIPE_DIS);
+	/* DCN32 support max 4 pipes */
+	value = value & 0xf;
+	return value;
+}
+
 
 static bool dcn32_resource_construct(
 	uint8_t num_virtual_links,
@@ -2125,7 +2133,7 @@ static bool dcn32_resource_construct(
 	pool->base.res_cap = &res_cap_dcn32;
 	/* max number of pipes for ASIC before checking for pipe fuses */
 	num_pipes  = pool->base.res_cap->num_timing_generator;
-	pipe_fuses = REG_READ(CC_DC_PIPE_DIS);
+	pipe_fuses = read_pipe_fuses(ctx);
 
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++)
 		if (pipe_fuses & 1 << i)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 63bd6928c82f..4c1e0f5a5f09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1633,6 +1633,14 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.restore_mall_state = dcn32_restore_mall_state,
 };
 
+static uint32_t read_pipe_fuses(struct dc_context *ctx)
+{
+	uint32_t value = REG_READ(CC_DC_PIPE_DIS);
+	/* DCN321 support max 4 pipes */
+	value = value & 0xf;
+	return value;
+}
+
 
 static bool dcn321_resource_construct(
 	uint8_t num_virtual_links,
@@ -1675,7 +1683,7 @@ static bool dcn321_resource_construct(
 	pool->base.res_cap = &res_cap_dcn321;
 	/* max number of pipes for ASIC before checking for pipe fuses */
 	num_pipes  = pool->base.res_cap->num_timing_generator;
-	pipe_fuses = REG_READ(CC_DC_PIPE_DIS);
+	pipe_fuses = read_pipe_fuses(ctx);
 
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++)
 		if (pipe_fuses & 1 << i)
-- 
2.34.1

