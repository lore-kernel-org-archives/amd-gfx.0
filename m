Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FC9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 14:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FBD1123B3;
	Tue, 14 Jun 2022 14:05:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA941123BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 14:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3rthspTgRGfYrgGBw0qkwk5rSC4Bk18Y+a6lRC2aZyB6VdNr3/ekKgdVsXma1g3rd777nMt5YFXIcJA2n9c8tWhEQptw88tnA6X4RvXMMvhIQclyR/y0XGyqCa8uIcWQafvu0Gd95xk8XgBqzv1u6RRqgWexHJlBRdyWG8xvEbIWYjyU6vW1oUNq/wQH2Xoyk1zAI3xvkJZXdLHimY7kk/0lMQ6n6nctKRq2v5YATPzT3aekkWSfiPwFKBd8sWuRobVtmDB3HL0coE4GM0GxDumzgLSjqZmF7CB/Kgp8o9r/1BfZcpiOWzfti6WCSrHaMRdJk9ydTksSkg68Yb0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLXqz8PRUTyAW2yUnS/qxcC2JRcueribLZz+CRB9f8Q=;
 b=PHXMcMh9aqQH7pI26vB5LKhCSrOAPuT4ijxY6WKSGa+rT/FFq4r6tObPlIekmet3ccTVz2WbyRwwrQ8pFrN/3kg+Mp6FtUBFtvhqTkjuB2dK5KcW3o/BsiYdFSM+q5B48UUVjFZ+ErU2qgx6OxxUGLNR6w9NRkROPF5vJd+9AGVxyQZnO5nkS3V5iaUG8ph11ak1w/23qCz6uGSIY4/pV4Q6sFlJd1AsK80yZ38uLD95Tr7Gs07X0NyJ49fQ9R1/2LDH45o3HrqviDOXMT0EUFLlXQw7J/2FIiRQ4bLIAnZjpigPOAWHY/p6N5uoP50PI9tL0y9p7eGm6RvFAPPS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLXqz8PRUTyAW2yUnS/qxcC2JRcueribLZz+CRB9f8Q=;
 b=kb/tbzLZ69VshvJvnztLT6mUbR3OxOroB3h28VEt3bT8/1yy5BYttTYr1LQFK+DDfm6dYDqYbnQ1nlxm1RtIeEB+VMfCVdGtBV2bJa7XxdTgfItO4ZtmrpNHRYzptAFU/+qzKOUbgXOu4TP/ecniv9lfkoyDVxTQgPoJ4tqeMc4=
Received: from DM6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:5:174::32)
 by MN2PR12MB3358.namprd12.prod.outlook.com (2603:10b6:208:d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Tue, 14 Jun
 2022 14:05:38 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::7a) by DM6PR21CA0022.outlook.office365.com
 (2603:10b6:5:174::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.5 via Frontend
 Transport; Tue, 14 Jun 2022 14:05:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Tue, 14 Jun 2022 14:05:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 14 Jun
 2022 09:05:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] Revert "drm/amdgpu/display: Protect some functions with
 CONFIG_DRM_AMD_DC_DCN"
Date: Tue, 14 Jun 2022 10:05:22 -0400
Message-ID: <20220614140524.2677317-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dbc4ed2-c7cd-47b9-424c-08da4e0ef566
X-MS-TrafficTypeDiagnostic: MN2PR12MB3358:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3358997E1B2C6A163A8DC6C1F7AA9@MN2PR12MB3358.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aiozvqu4zAvCPuVh3z4T1wIwpqNvVdNG95UEJo7tfCrC22t/j0TryIJYmIgl2RPlCnHpAgErT3RYnCQAso3F97zLRmxqcYT43WnXkj1VIkTFDw1fuTMgHK92rH5LLM4/bhJxLkF/3aMXjeWPxEdoDxfNhk4BIzU3H11mgPEC/IuAPXB3KeN5QqIONRY7gnpseQqxt6stFh7LjXNus/FK2UXyHNb0z09Vsed1LBmIA95/hdYxGwwB27DmmnbQJJV81PA/KygOXyMSFEe68wqSNdUgWBZt3Gx1FGrgf5/uJAGFx29jFMKb6GpK6oV0WxwRt49M3D3wAW1sC462bNjw3DEBbQm5GO7UXGZs0W7NZF5KW5i14P2GOWJ2xeH7Wg73dVkUhnmL1uVEzjQX8538uw5LT+2BBGsPqXFBagY10+l+iMqRCl7dlywhf7mP3ZgC9Enb4vrIa84J961N/YtRwonC7c56TTHXOPyMTr9vieQ6KoVZDNFZDsrWSMNAvUsWE37EW9dcUMdgLkdOud8umJLhLK+CKH5uFB0emvYIK/vhC5wg0q1AntuP5EU9BUxxY8YwhDXgyaOJA5yP9v7X3Q5jPA9aN9EulcRifuAii+rFEWAIIr6G4du7TyqTwcvTzixSUNQXwrX65imeY/j2e634Q2K8IrxW85fA85cbPErb3bn6kOwoifb6rAH958ZAuAGRnR9da4jfs6cz6e6ZgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(508600001)(2616005)(36756003)(70586007)(316002)(70206006)(8936002)(2906002)(4326008)(40460700003)(1076003)(8676002)(86362001)(7696005)(16526019)(186003)(336012)(26005)(81166007)(426003)(36860700001)(47076005)(82310400005)(83380400001)(6666004)(356005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 14:05:37.9037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbc4ed2-c7cd-47b9-424c-08da4e0ef566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3358
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

This reverts commit b109b14682230f06f70a35a0f1ee36a7d43840e2.

This is no longer necessary as newer patches require these functions
without CONFIG_DRM_AMD_DC_DCN.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b7dc65800b1e..28803ca9e3f2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1801,7 +1801,6 @@ static inline void retain_hpo_dp_link_enc(
 	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]++;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static inline void release_hpo_dp_link_enc(
 		struct resource_context *res_ctx,
 		int enc_index)
@@ -1809,7 +1808,6 @@ static inline void release_hpo_dp_link_enc(
 	ASSERT(res_ctx->hpo_dp_link_enc_ref_cnts[enc_index] > 0);
 	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]--;
 }
-#endif
 
 static bool add_hpo_dp_link_enc_to_ctx(struct resource_context *res_ctx,
 		const struct resource_pool *pool,
@@ -1834,7 +1832,6 @@ static bool add_hpo_dp_link_enc_to_ctx(struct resource_context *res_ctx,
 	return pipe_ctx->link_res.hpo_dp_link_enc != NULL;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_stream_state *stream)
@@ -1848,7 +1845,6 @@ static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
 		pipe_ctx->link_res.hpo_dp_link_enc = NULL;
 	}
 }
-#endif
 
 /* TODO: release audio object */
 void update_audio_usage(
-- 
2.35.3

