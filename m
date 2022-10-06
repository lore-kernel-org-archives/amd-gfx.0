Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4512BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E83410E8B0;
	Thu,  6 Oct 2022 21:27:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 166BB10E8AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRcMGQ5IUFg/R26EkePc8Rvr2O9nBJF3VDshMQ+LOFC1oc9rerYfYuSYJcq/4FskRAW5C7abNoghsKXg9hVAWkmw+CoWRx3o0aSUdyU9Zga5KBADylwxs41fiGuNQIhchPSXakKRmVJ1EstSTSw9cgFNE1LTfsmH4snjN/dnjbJEkUnFqNQ+y5bFOQsAjfJShkYl9LYSFrRlB538VWaL4E6IMlxu4ounfyE3jEF6qgNayQV5EsHnQHDzm7Idxkm8x3YXQYfMmQNJwiToNMjz7Z9Nrj3q3CRYEjlp67ZfzctyK6LdOzjFjhzss0w/rNU/vQiuFwVaE6UjHYsma+BI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTEZSC2061egjfKtDMNTQTcThS5xEhqpPQ7KMqeaSdU=;
 b=W9p6jN+K59ZZMayLM/96S1WMuPWcP74+E+3aZCHAawNZTyOJaKuZDZIL8HBVSUL2W5ARLNxamfmusBI9GeNd3WMQoFWsLZHzRtmTEwNaBNrz5GyGhAGZ74c0ORSOqbxMoIrUMnFSy+jng6smA1Pu8XbYRtp+TY2aql8Vr2HWqfy1AasKn7QStN5qXBRH493kq+5YUhwl0SHCTpDOEgNakfc4BjX6+QDGs+XU77c2QmTY1elN8QsxoIZlEHG2av9y99hjqW4sX64ng2RVHe11Uro8Bt/wgW5NcW6lmcbDisjgqlZyKmzD1a13LoMWm/BBAqLX1fCnFwPNRCwWFRCx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTEZSC2061egjfKtDMNTQTcThS5xEhqpPQ7KMqeaSdU=;
 b=DG5OMwrLU1kCoZec9IG1oTE1IhY0bLBI+6EFRdfxqgyP9XFuWHt5ff8AuvjZ8xPVmcCLZNL9zUpOv+xxMz91WKOkcIzCaKsTjvAIaSnb85gsv+JufUOHmHMNrVUzKr2y/kYHpZifLuS4v5vHYiBGdWge7Dvwrx4MA1eszvdHgrw=
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:27:31 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::4b) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.22 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:31 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:29 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/23] Revert "drm/amd/display: skip commit minimal transition
 state"
Date: Thu, 6 Oct 2022 17:26:29 -0400
Message-ID: <20221006212650.561923-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2bb1ae-10f8-486d-0158-08daa7e193da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fh5700CQMCFLgbEuL5U5z2zsN3jd5Ca1AHFQD29bTjQAG6F2ufm0PzEDtWLBf1lxm+HBf0vi7PQy+Eo/3SxpUAOH8AARkIvOMILMUbv5PqAk9xI7XUbogtK9oljtCg/SrNBlLzh622ZURTqHxjTh0MrnGeCi9J29EsQkA8Qr4we7ocBe/xzM+dp2pWKcMPN5dSo04dCuPfgT9ppr2lI158boXvamXuaK36hTWS2xlf9scOGxR5KiTc/Lp8QdQImP3jw94ue3cOYkTSrBRr9b4+jkYOJsRPvWYGaveAH9NCOpSiloUr72OKw7DuBE1KdAqs3U4htWqImRgfLB/gfXL0C3QdKWyRJIvO8luOHUTLXKUEqLkettSQJL86xvhWjnlwndi1ZHuh9Wpad8aKTjRlTzTpoWu6aIPkqse7E0iv9b26ij8GuJlhj3pLSPtzG93N0rcLrdlD8/CYX9cj0OwyzQYBKEVyT+Zk7dvevlHLmmQ4J57V4/qaoK+BQQAVfImvo9AjWYFmCp4rzOwWOCjCSI0/AJbVI+2VX9/aNA1ujiU+ll+B1St3+iItsySpGkRiy3MWE1ZmktOJ9bA/MraL/ElrrsaNGe+Xn6VVfcLLWF2nAMDDdzveFLS+kB6sqCc/rSJQSsTvcQuEjNxY80BsSIp3gMdtZhNOX5qCKdlIHHDB+n+F7V2gcKE4yD1YkMo9qu9RI2XFUdNNCaAolFWZK58omOqBc7YbI3i+HEVOrlMrS934KWt8uCvnp/gBulT9VZ3TknjO0jK7a6Zr6PhdLdzZVuCFRJFqV5kA7OIrM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(2616005)(54906003)(1076003)(186003)(2906002)(86362001)(6916009)(316002)(82740400003)(70586007)(70206006)(40460700003)(5660300002)(8936002)(8676002)(36756003)(81166007)(44832011)(478600001)(4326008)(356005)(36860700001)(16526019)(336012)(41300700001)(26005)(83380400001)(426003)(40480700001)(47076005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:31.5583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2bb1ae-10f8-486d-0158-08daa7e193da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

This reverts commit 0a1b86a611f14df7a490b827556a4b8c2e31c050.

[Why & How]
The reverted commit creates memory leak and causes issue
upon driver install.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 40a34b600c8e..b5058a2ce7e8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3650,30 +3650,10 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	bool temp_subvp_policy;
 	enum dc_status ret = DC_ERROR_UNEXPECTED;
 	unsigned int i, j;
-	unsigned int pipe_in_use = 0;
 
 	if (!transition_context)
 		return false;
 
-	/* check current pipes in use*/
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &transition_base_context->res_ctx.pipe_ctx[i];
-
-		if (pipe->plane_state)
-			pipe_in_use++;
-	}
-
-	/* When the OS add a new surface if we have been used all of pipes with odm combine
-	 * and mpc split feature, it need use commit_minimal_transition_state to transition safely.
-	 * After OS exit MPO, it will back to use odm and mpc split with all of pipes, we need
-	 * call it again. Otherwise return true to skip.
-	 *
-	 * Reduce the scenarios to use dc_commit_state_no_check in the stage of flip. Especially
-	 * enter/exit MPO when DCN still have enough resources.
-	 */
-	if (pipe_in_use != dc->res_pool->pipe_count)
-		return true;
-
 	if (!dc->config.is_vmin_only_asic) {
 		tmp_mpc_policy = dc->debug.pipe_split_policy;
 		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
-- 
2.25.1

