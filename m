Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB4FC38142
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jan 2023 17:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2710510E193;
	Fri, 27 Jan 2023 17:52:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 039C310E193
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jan 2023 17:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0fkB+E3l2QnVFm/oeBqvBlttziuLb4aiyOncbLJOJZcV1CDDMf0VnNmRgygwaw5fvz5oc6qd86meI6CO70ALx68J7Ix3UufLeAhC2cJVKlrd5zv0oHUU3z0oZQQSvJdp3qk1bjVblGpzXO9QFXhHD2BzP5mT5KXKRpf5tVpTs9F698nt0tnWhqrkicsNVK5WxKb77/FRxRujd2EN2pvG/LbHRYpr8J0I95YSmLtf5hdcA6zN1uPIu3ew5GW6q38H0r5ZHgycIOsZUM/KjmZ1d3n4smgWfGzN0WFG4tZAYTZZyI0Hf3sY0lxVL5ZWvrBU9esf2XUie7NsXWx/hxpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INBDpo1y5Y2iRl2Fn1T93NqZ1doc/bRehfJC0lJVzI8=;
 b=mnfI78P0Z80woA1UTw2HeKBA6VMFba1ia/lOEGB+T9VOCqr+05vDYwYMbyNZDfY5XOfG6NjGcIy3NCT9WCR4ThQkgkzSPIINL4f+HzZkFfaHhq1ZPRiu86s18nShFO1+qaWaqmmJeLknU7VuGRaQYuT8NAsltsj+WPBMULp5dPsogXW4NxX3nqXOBZgK1+9ZxHHaw7jbjMkj92+8ClaFYAHjPzEFbqJ1Los07sFovFR9L/ToBXsbrbrGnA+2bGKgja2qEmbzmQTpRzbWwhVvYmZRPLIg/kQumZHkT430L8PAcnBWqEt3QykmNxSxkkcFFnMDLQJFyKpv8O2tf1xQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INBDpo1y5Y2iRl2Fn1T93NqZ1doc/bRehfJC0lJVzI8=;
 b=44030wHUc9nwtxKuEpFwjSLgmH3+yrV3Uh2gI+9CRECovFNSleof2O83mt4Fy40SVLXWU2NpvnUas0tnMe1q9TdCQVeZQqd8/A7NFXV4ur3bC9b7k3dozqCy5oxVSgF3hjRpD8Vc5DPmTMKf6DcH9HCJ8KiaER39HrBE8Ci1X3c=
Received: from MW4PR04CA0190.namprd04.prod.outlook.com (2603:10b6:303:86::15)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 17:52:05 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::aa) by MW4PR04CA0190.outlook.office365.com
 (2603:10b6:303:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Fri, 27 Jan 2023 17:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Fri, 27 Jan 2023 17:52:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:52:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: add missing cyanskillfish check
Date: Fri, 27 Jan 2023 12:51:28 -0500
Message-ID: <20230127175128.2570382-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127175128.2570382-1-alexander.deucher@amd.com>
References: <20230127175128.2570382-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|BL1PR12MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bb4523-98bb-4439-ce2f-08db008f33ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMGIc3/DZYI0/Hx9cm4H9VMgY5XlH7q8EgM0GFrJT98/+8CWHotWtMP68DNXUf7360tkZ2AnGp/PM4am8tmVNuwNvpgjL7X3uvIQMJxCFEdgh0Un2OzbdapG4ndQYSVk0uXQxv0th5ivF/oRLighclMuGNtCXuFdzv+3+Aac42ODtpuUeNi0iSVzIKuhMctmyTv5Tqmyy4YRMxu6Hc3LQh4wvcyrJtg3VGqzZt9EkNKkelCZZkyVyL0CNwfk2VGckAn6WPX+sUfUmkxIXSK9dCmQLQGMNTU9J6Qu7ZfLrNQ5LFgwk3Evtrcz97pxNXT9bbWU7AGNOi/Td3k0UOL0UVRVGfK07Wxg5eNGFTuYsQRVDVLpC7GUNpZ37PRggHK1eXDCthdvNPfsN1w4imfPLEWKQwlFZcmgdQ5HBq6/NFcgRz5Sw9kn6SmoK5pn4FlAbvfp0rmWnEXk2/7gg4LBJqsOozkNbJT4SS4ibF7+tCCG4uXW6cP4eQvsiYzfWjaW7PJ6vVXMAiAiS02ePBNyIaUrc64qEadBd3wP+cZHikdwbUxSrnY5GUNPGddr1w0RUfne27+smoUnZgkqRudCcHA6zeebcYUAKUbHOFjxwTkdi8cxw+HMz/NaaBDHX4jNvM9l8aFyUJVj5OPIo0ES1j33XKcJYQwKnQabCyVi7ANUBCI1TzCb4mqO77txPP5I+HH1L4ZUwu2gJ8a5m4QwCRlSuvWjCR7OG8/adVSLrgM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(8936002)(41300700001)(5660300002)(4744005)(426003)(36860700001)(336012)(40460700003)(81166007)(40480700001)(356005)(47076005)(82740400003)(316002)(36756003)(86362001)(82310400005)(70206006)(70586007)(6916009)(16526019)(26005)(8676002)(186003)(478600001)(83380400001)(2616005)(6666004)(7696005)(4326008)(1076003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:52:04.9541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bb4523-98bb-4439-ce2f-08db008f33ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For clkmgr setup.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 69691daf4dbb..91f7e7386da4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -269,7 +269,8 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
-		if (asic_id.chip_id == DEVICE_ID_NV_13FE) {
+		if ((asic_id.chip_id == DEVICE_ID_NV_13FE) ||
+		    (asic_id.chip_id == DEVICE_ID_NV_143F)) {
 			dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
-- 
2.39.1

