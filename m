Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E85CD98F6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7A810F5F6;
	Fri, 19 Jun 2026 13:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="naQkOmLM";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19AA310F5EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WF9rLyXLHY5GUxvdp5DV7AWHvrZDZhn1wgquZIoXOiTBtykrNAnzD1qNmeHdkKTCA+XMasMVozphGuHs25dd9jjJd3mU6XozqYqBqljTEp6hEfgnY8Bj39rsW6AD4wF9MR5EKZ+I32aezGLEoUvUUSbJqIHet7aWGHPzO+aSkU0oq6asLIidHdH76PRwbHbxUp7mzXs2c3w/F3TxLOErL47wZ74a97p0KQ+orY7tibVuKm4xgAXE7JHFTmyp0bwAO9qVqtIaiGieePcAAaGlzyfAOtDjSieUx+eu3z3IV/3YP/mivvvE4hNMpRFeIv78TV9jplTkO+DGTBKSrf4TdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lPZrQll03/R89o7sCOOaEehCMoHWCyHz3qxpbipC3s=;
 b=UX5uZifWeCuiqTPakLYLTjcJpW57n5RaynvnonqAodrzv5M9wpwkEKfFY+Sz9nO4q5wAX+CrBbuF0f1L/ZxZ0zvydQ0kD6SI7zOxITzgxrI8aGktJN+vyN+2hfkIMRaCAldp5YUw7FlAoP4yC5S3A98kVDjJVPNSxp2uwmq4ZuRFrxqXKeVlaZeHogIDQwbOYYUvX6438yjcjyCXah68KMPH+3eULOxrKvbkXdEWB3oUQSFhxQvbtO+tFIths4L215QT8bf3Wds2czA8kMTYJSe4rB1gQ9W58bHc6S89Rs0xe7KrIjSMmukoYCmt2IyuGPZayk62vwCAJelowZES3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lPZrQll03/R89o7sCOOaEehCMoHWCyHz3qxpbipC3s=;
 b=naQkOmLMw3QAkyNYt82DJt2TLgT34cVQxmn6jjKURkVFJZ2LHSzwwK/1SXqPClWwdSHT9gDDGwFlpTq9TN19K8NdX/tYd88hpABSll63EW9wEIrejEat+/fc27TSxWVg36t2IV5qPTE8AUers6qjiBbl17IiyRwuJx+Fwoyc7qs=
Received: from BN9PR03CA0863.namprd03.prod.outlook.com (2603:10b6:408:13d::28)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:34 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::77) by BN9PR03CA0863.outlook.office365.com
 (2603:10b6:408:13d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 13:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:34 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:31 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leo Chen <leo.chen@amd.com>, "Ovidiu (Ovi) Bunea"
 <ovidiu.bunea@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 18/24] drm/amd/display: Remove unnecessary DSCCLK enable
 during DSC PG
Date: Fri, 19 Jun 2026 09:21:33 -0400
Message-ID: <20260619133154.116746-19-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad37a45-e0d9-4193-602b-08dece0738de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: aGRxvxrLe1xepZ0jnotwL6YGh3G3WPcyR7rly8+hLBfSI2Y1Md7fK5ATTyT+DVVH+tK8hrZI9FV0O8+WCkYrUbVaRQI4eaF1nPvkne8AtseUdlNuWZK+9peTkg6ts9LZw5avvoJR5J59j4G0iatnfBWRn1zUvwrv10vE7/v7LiXfuMO0mxXHcwVO1s/lG4/sHHdHzs328bLBZiEwi5gL6HnOW65Ccez8DBPpEcZaw/9Mq2qL2Rfsn4+y2kD85DfWp4/we9G+UGV/resTi55eIatBqbF/oHu5z31I2iVnpo+hPRzxskMgsbRFCznb/UEPE3fu9hiMkELU23cKGW8hEBsod49I1tNuYXZWMURWckALWO7bQyFEbOLxumIsnffyUuXMk3zKkqeGwnpfUBMalxk+Y9QYe0tPzWlVAXXVTRUJDoRbF82ziMZvyXZry7kHKlmvlANn5S9bwIa+bpR9AYbPEEZtWNiXN/cB+C2mhFVMqPY3tYBvWlzCxA5s5QryP9XJsGsL+frF+MrYJTENkRSdsL2E3vYxLJZBW9M0GSW74C98EaIqPwfhOl0pmCbW9CMbx8jcgmraW/7fIG43+g/1tYsIybsKXLf4JhSbbUyt7K5zAHaRi/hGsSVh6xbJSDv8awd9yi9mjlUDGPreyY5fPw085MRgAbeaGFojFVMfRLgLmL0tDgtCb32kbHBpW49qHFEj4Z160hRmCbt/Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x2OwCD5Y0m8mwjEEbOYG/fAOzR9FbZJQRQUnpSENdtDRqJuk7S/S4l51L1Dg1+jRHhnGcG1zqa1fWJDXi2URXgecMIEx9tvYzhmYhUJ1kui+RSs1r0W/PWOCbLrRc8tKCexITrIiOCbMZlULX7NjASUc3CaZazEwDkMOxQ+JfmJIVRMW7ZBZgN9h1KNmHd79oj10ZDMGhQ9w+NqieStaIq6U1H44lL6BBMuZAvd9PwkMq8seAzPqFPL9r/GzqFlIBKxYK7vKksaDJL/+r6QuIqdur/cYYGtaTTRLYkoZpcvDFA69c/ovog95eH9z2YAlt2XAvK3gpNsACf/dv7f+jGrQGQlzBfbS9V4yaXo53RTuuhydFo+6nN9ykxakhj0Mioguh3d5b6jb/0XfYhLvT2jQcbKebnkeme77lJRnfwghvcB+N23jI46ZzTvW+ewP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:34.6985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad37a45-e0d9-4193-602b-08dece0738de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <leo.chen@amd.com>

[Why & How]
DSCCLK is not required when power gating or ungating the DSC block.
Remove the unnecessary DSCCLK enable sequence.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
index 94361e326c56..2fc17dc510df 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
@@ -96,11 +96,6 @@ void pg_cntl42_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bo
 	struct dcn42_global_fgcg_rep_state fgcg_rep_state = {0};
 	bool block_enabled;

-	/*need to enable dscclk regardless DSC_PG*/
-	if (pg_cntl->ctx->dc->res_pool->dccg->funcs->enable_dsc && power_on)
-		pg_cntl->ctx->dc->res_pool->dccg->funcs->enable_dsc(
-				pg_cntl->ctx->dc->res_pool->dccg, dsc_inst);
-
     bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
 			pg_cntl->ctx->dc->debug.disable_dsc_power_gate ||
 			pg_cntl->ctx->dc->idle_optimizations_allowed;
@@ -167,12 +162,6 @@ void pg_cntl42_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bo

 	if (dsc_inst < MAX_PIPES)
 		pg_cntl->pg_pipe_res_enable[PG_DSC][dsc_inst] = power_on;
-
-	if (pg_cntl->ctx->dc->res_pool->dccg->funcs->disable_dsc && !power_on) {
-		/*this is to disable dscclk*/
-		pg_cntl->ctx->dc->res_pool->dccg->funcs->disable_dsc(
-			pg_cntl->ctx->dc->res_pool->dccg, dsc_inst);
-	}
 }

 static bool pg_cntl42_hubp_dpp_pg_status(struct pg_cntl *pg_cntl, unsigned int hubp_dpp_inst)
--
2.54.0

