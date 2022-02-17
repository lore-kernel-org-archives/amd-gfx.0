Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D79C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 21:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE50F10E25D;
	Thu, 17 Feb 2022 21:05:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5EC10E25D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 21:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoxd3TZVfgXhk+X666CduBco4dYbQPBQvLOVxGvHMNiQeiGgb61hEJ6FLAgRcoL5TChdaZD9/vggCc67Vz1Q7j73Vk63CWklzEn8TXJ/eEkI2uH7cF4WNO6peAskOSegAV4w0E142rOGAsvljpyFsC8UFn3p16REBP5UfMimZwvklSNwyCP5hNTblxle2ILX5LgKPyUYVaRO9Ww1CBbW/L8TLEp1Ivnbu+rknX5SccdYJeLhJCWJgsxqqq2xGMEDSP9ziMi9/O+lHvYl8UMPmLY/pqJEUVwZQLaK+lXtkWRjdO5RmonNyl2E0PuMvZsveJP0QDHgG81lh0UX+Xm0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iAN8xiF/TBsjAbaE2PZ0s1315qP4C078GdrmYwGWSk=;
 b=UfUPpjk4YqfILxQ4DLmoiyUMIFszugc4m+VAknq/xNNO4BUocz9ZCrijMb6OOLj4Ltj8NFYv5MSQPhuSIv1mX/7kLOBWltufV+6f0sQZr921IzkblqVxGxjc+GkzqV6tinTXVPQqO5RtbZHnRbR2ROk7xoluPL1+gDNSXLkr64ju8aMw8fHndo9ipQEmo4/TwqfxgmVp9Qb3dOTJFr8O4LFSUT0WmE7vdV+gk+Ta+ShNbGfncBnvOl5mSXh6wXN2QUxyL+W7AkI+XZitIyxpu9PTMRQ0fDtGLhUQWWMPJcdX+vKncGEXqsrHYDeo9a1+7HGkcd8L1X7I8xWF2PSxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iAN8xiF/TBsjAbaE2PZ0s1315qP4C078GdrmYwGWSk=;
 b=tfJ+wts/uUjo4sFKl1an9z0SJm7h8T68a+nU8gH5i994Hk9bRWwfn5FEOX5gWB5aQUwMmZXs7VCYal3qSTHwVF2/EE4owkDiHv934g19a2Fga5luGETYu7DKEgh5MHsbcxbfaJeVdX06ybVO5/I8kPvDuLN/iDO/7rt+TXbVxFQ=
Received: from MW4PR03CA0333.namprd03.prod.outlook.com (2603:10b6:303:dc::8)
 by CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 21:05:32 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::1) by MW4PR03CA0333.outlook.office365.com
 (2603:10b6:303:dc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Thu, 17 Feb 2022 21:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 21:05:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 15:05:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 13:05:30 -0800
Received: from leo-desktop-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via
 Frontend Transport; Thu, 17 Feb 2022 15:05:29 -0600
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix DC_FP_START/END use on non-DCN builds
Date: Thu, 17 Feb 2022 16:05:28 -0500
Message-ID: <20220217210528.8644-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 505d4bf0-8004-45e9-9bc2-08d9f2593bc8
X-MS-TrafficTypeDiagnostic: CH0PR12MB5220:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5220CE778849B66C0F2BC0EF82369@CH0PR12MB5220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zt2LWeYNxQtOzR92o8Eyl1QjvaX06PBrakiGV+0naE2Qi0HUaByRzM24oxzqi9+/NWy9dP/JwNHsV11+wTkLMt9GIK1mZ8V1bdQyAua/FytWnkEPTcTjF35Ht1XS+y/QlpBJNWu+qzmtQKtKfZNrc6KGpOEX1tD2ghZfZvj0O4iHJwjN6AS/gLNCarB/tv2rNlLxuzmmQ+OXEvB9jjClEExXZ5nsao0IeyoJxrD/k1WM2w9BUmIruTa4KF7kviKJUQnG61Z7ffMOwKox/Gag4qdFTFNxNnBstIGdJaiRtoDaCkHgcelwZX4pNAqgGeUBcLGf0Vt/gp/4vhF+UfIWuwv3e7oUTlmSRdWMVLQ/h6n/c1tIpSrYD/XSftFujpp6IrdBRyWijIHBjqlhFZ7Uo+ffoa57Yv0aGcbGTp6tcVlwSkQyUcMqbaA35q5Qk+vo7AY8toHqKOGJXOLLl9xB3NHMEzmz1pjZFdkfOX37P5Nw50FBeqzwRPs86g2Td1kBVgqCm29/R1fUjUtnN6TTtel5hgp6uOEtfyU/HrTjSg/Gd8jR8OGLTgkFQv69ioO2Id7krEO0VUz2pLGw5lFGqtwz5cKhZs5+oJfTDUStRpd7jO/2Q/jmhhpWg4mfENxHZInE3oKAkTyfGlLg9sMC/3AKTy3R/gGjd1ryG4CBmw+02R0ilT5ymJySRhP1iErYLhpSHGHBNOrOf66t8lIrDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(7696005)(36860700001)(1076003)(316002)(8936002)(336012)(426003)(81166007)(356005)(2616005)(47076005)(2876002)(26005)(2906002)(36756003)(5660300002)(83380400001)(186003)(70586007)(82310400004)(508600001)(6916009)(54906003)(8676002)(4326008)(40460700003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 21:05:31.6774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505d4bf0-8004-45e9-9bc2-08d9f2593bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo.Siqueira@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, harry.wentland@amd.com,
 Nicholas.Choi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

DC_FP_START/END is only defined for CONFIG_DRM_AMD_DC_DCN enabled
builds, and update_bw_bounding_box() is only valid for DCN ASICs.

Therefore, wrap the entire thing in the ifdef guard.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4ea114725d61..b1ce3c0cf477 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -987,13 +987,13 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 #ifdef CONFIG_DRM_AMD_DC_DCN
 	dc->clk_mgr->force_smu_not_present = init_params->force_smu_not_present;
-#endif
 
 	if (dc->res_pool->funcs->update_bw_bounding_box) {
 		DC_FP_START();
 		dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
 		DC_FP_END();
 	}
+#endif
 
 	/* Creation of current_state must occur after dc->dml
 	 * is initialized in dc_create_resource_pool because
-- 
2.34.1

