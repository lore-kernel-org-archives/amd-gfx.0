Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C43C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377CE916E0;
	Fri, 22 Jul 2022 20:43:48 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B84912CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miu6xtZVZ2JH95EbT5T1+/FiXEg/rdWQYhT5jpI0cPJY75M+EdW+4s6fGwnOvkZlkGLKeDLks8aIv7F1NZ4EMEXzqiAPsmIZtZD2Xq+uiyMs/dNyYYEb6TXvofScmvLOJMk98VYeCrXLgxEqWUU4+m1oRvA5ybbVAaSQeZfdZa7YSTMp9awaYUATRhXMVMBTvth44MphiczHz0TpzPVYbYQGhnim5vH2dMYtjjjU7gMLzgvJfaV3bIOrP85KsLswKxUkm9fZv8XSZOMrimy/5MUWAE7lnIq5IanG4gYLupwXiUY/J5ZAldA9pGDC9Wh/zg6QInXsFiIdxPAcgwc2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7+FGDXh2OYiuEKGkyN3546+25/iizcvN5PnxKG9/ro=;
 b=RNvwbsiAwOOupmyEJmFHfXcKrfzCo3/msNulk4M+fPpluKuz7LFroMd/99Fa6md+HV2mw9GCljso7F/ogN+Pw6TOlkDqxTUThtkLHXTauLOBX3N8pv6FTH5KO0mDTqanZEKYzYI7OX3s74TxuR9rfuBeZMlbHBPzdxIWOlMWc7IEwAYBEkArGr8y8yPP6PDhVZHLnCUHWM81vuhcgEbWf+aJDR4bd485w6piqYrc914V6B5RcLrtRQ1L2InmmktKJBqFrNsQbDbTdyTci6d6WinqzKvG2RNLnTMrTykQxIGlRCfuebicVpYCxBe77VAPZbeAxlrgKN8WNgZCrBho5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7+FGDXh2OYiuEKGkyN3546+25/iizcvN5PnxKG9/ro=;
 b=rH76Ha+vwo46OnqdG6HhtQqd6B4hsR0bxzXflBdRxiYQcS9PQkcTXn5ip+Ts3I+fFqSqaMOA7BXsZBbqjxMplT1YRMZ91Vjk6WEbH2PspXH90AbvBMyCNoUtNJJXpFeOMWPv8JeZyrn/dOH73nV2CgAqIpOXaLlq8oSeGIO70Hw=
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:43:44 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::b5) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Fri, 22 Jul 2022 20:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:43:43 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:43:41 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/31] drm/amd/display: Disable MPC split for DCN32/321
Date: Fri, 22 Jul 2022 14:31:34 -0600
Message-ID: <20220722203137.4043516-29-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 031e32d3-194e-474b-ada0-08da6c22de2d
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6052:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11cQn181mYTVBL7YJY2fqujru0aXs74uCemFAucyBog2HaioxGqhC6EZAy8kxDyXDT380N6e4O9+LIkRPsrIsNuX3c9hSx6CS6C4T3sfU1+5pBrCtTCOIz2V/OKm4LiLbnMYYYg6ydXcsgOzAFxt3krDOawOCQFnndlFh9w7m4EiQuMHNHFb9q2WhWdOwB9WbDcWvzGsBOKw7rO55rKHvQRY3vrVM9Kjl9Uvd/zJ9801mj73bUz1vbX3dUzFWkZVf4LutZQWT0OlBckEB7E0WvOeFViGff+IUgJODAgKEPjWieBJpbTSmLeTOl0P+B4O1WhiDNMpslqvcmxx+ZXLbVAXxPt2cPlDrR7lk4nuiD3If23lQ8gtENswAtjIxxa2oQHv1ZpuigRS/76eHwIO+9yDcBcIR+9uyLDzIhAmb7S0s+FBTBVKSmzMvgtdIIoRBpFvhtlR2ZZakPvJHvu55DkTgisqjqMaV1+gX9EGpQIhSslFJFRwaU1lV1Le5zin/2PQBFPLVWduGkVeiX60jjLmxoNYif5SBIJB5NVNoOAsZLZ0bgQ6TN0v98V3/Dmh1g4uijSjjcWOgEAK6r12X+gGIBdaPBsvP9GgBQAIfvRhGQdcc7BQeRPS5hB7GsHji1sGyBQJKCvNr3IxNaGuZezCcLQPO3bqpGBSvch3kWkTyvddutZwLNl1Pin97zVy66jPLu+cTB1bZyY1/ipcoriYr9NfstzTT8wVV8j6QLnJK4SGlNZ8PJvCxV1lxszhfolnBzvFt7FRPyvsAJWBEfUZOiZnWNvWaKpH27Q1TMmJZvPLnesYKCTylLmX5iF14oJmSyRewkKt94HJrDXyMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(40470700004)(36840700001)(2906002)(47076005)(5660300002)(44832011)(356005)(82740400003)(36860700001)(8936002)(81166007)(83380400001)(1076003)(426003)(8676002)(186003)(54906003)(6916009)(16526019)(82310400005)(36756003)(316002)(4326008)(336012)(70206006)(41300700001)(7696005)(6666004)(40480700001)(86362001)(70586007)(478600001)(26005)(2616005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:43:43.7476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031e32d3-194e-474b-ada0-08da6c22de2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

Due to CRB, no need to rely on MPC splitting to maximize use of DET
anymore.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index bb1d880eee1e..2278181ad3d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -843,7 +843,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.timing_trace = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
-	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+	.pipe_split_policy = MPC_SPLIT_AVOID, // Due to CRB, no need to MPC split anymore
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 73d2a653a279..ea5160d0c92e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -844,7 +844,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.timing_trace = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
-	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+	.pipe_split_policy = MPC_SPLIT_AVOID,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
-- 
2.37.1

