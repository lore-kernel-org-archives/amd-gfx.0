Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09063CA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 02:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF0810E573;
	Tue, 12 Aug 2025 02:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GvkSp4J7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AD310E578
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 02:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gk86vio7TuCtb34XQ3qSj8/CxxgC9W5rbfAaDQTguJiVVMpceQrdsVD4dRl92e9xBTw0R3WiBKsfEvV94B28DE+gNlA8wLSzGKxy9PE1ivXa5lGkJ8sWPxKhIHJ8D+nXIh4EGqh425cuGhyKUp66hpzktQ57mqt7swHywv++LjZLtUNtRP0gPOCiQbYMEwcpqYuPrcAc7CyOU7evY37NUntgGQFQYCaNIMOlFJirYWWmOpShyz29h+lubGB84fBMcGaH3DZLLKXAEX9Q+awjgmq1DCsgKf8SGIakCFsWewoYxwtgYH0qhba/0z8bF51L+BsIaLUSOJrJLbsVAv9GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeocItWhdpdBA9WUCR2zFXVDMj2PeqoQqqIXqxrszVY=;
 b=dzKizU9kzdjLIgOUOZ1rEmUG5bZ0ePZn990OIs2IksRlfdOSpakIQXTDzhdSuqBcTh4g9TyVOKE4taSDcZsfjdwRRlurqC3ShPCOVTIdXtsEMt5zLK9mQvl9/vGnj1dJnX79cDELMgwIGNkklQMyVBllykB8Al6MNlE+NtC6LLsDDMaE8qfiNQORmq2DWliYLz8lu1UKOQMsaexPEMm6VcRan1LnaME9JmX3wQaG8PZrvgJgiMEs5rmBgJiW7owot4hu39A3ytG1pS7tjPLhaR8lfX+tbyGnlmF8WZ5W+pcEAkaXlRSKzuj/aB13fruiacVddSbE9NB5aawGViiGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeocItWhdpdBA9WUCR2zFXVDMj2PeqoQqqIXqxrszVY=;
 b=GvkSp4J741ryUqHr2cvLRqZz6zY6Y92J6h3WiKW7wNmoa5921GYkWWyS+GTXYyL8CGmoDyQiL6+ERR82/wNNpKlaGbRfJwDsgm0Jb2fDV8a4Rx9cptmFzkjKZihjw1iGfgFzw+lF3kNquJSdEFHsVAIpHibmZB0Cff3SSMhzNg4=
Received: from BYAPR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:74::14)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Tue, 12 Aug
 2025 02:00:16 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::ee) by BYAPR05CA0037.outlook.office365.com
 (2603:10b6:a03:74::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 02:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 02:00:15 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 21:00:01 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: fix vram reservation issue
Date: Tue, 12 Aug 2025 09:59:33 +0800
Message-ID: <20250812015933.2360801-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: b89a04b3-e883-49de-e3c6-08ddd943fb39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rRjuxG6+n52KYDl3EZz5JDE89WHNkG2kFBcoi58wzwO9EQ69+Du85NoI+NQ0?=
 =?us-ascii?Q?d9OpwhmOn2Jok28E6mQe6kRPFhM+o04NygR1P0Tp7HNxoMLQjOCUtaaQGYxZ?=
 =?us-ascii?Q?btBtcHByladq1/X5hSvgTU+BeKKUGfXfFZSoP//ThXKMHy4y4CYHNiQgTpdi?=
 =?us-ascii?Q?ihBAfj9hhC22sV3ai0t9H67UwLftvXs2PAObzjWy/fQ8Uw02gBd+7yISVpQB?=
 =?us-ascii?Q?CWmTmX/C8fZ6efQMrDTOS43CrIqRbK7ONQ/KwjkKhSxNOCAvw4klwmffgbse?=
 =?us-ascii?Q?aH0qbebRmDt2/xeuSK/+8PU1Aqgh6Mhx61UVtSF7c8TgwCCJAKOUWnK1F0QA?=
 =?us-ascii?Q?tVnZhaLN2f7JpxB33UGcTGvgEtEJkpncy0fF7vNuH41Wwoo6ls7A13R6eHh2?=
 =?us-ascii?Q?kqudLP6d4aAmAjDwbtx4euLuR4sp6C4u4r9jD22hmWwRCDMLsSDLK2mdwc1n?=
 =?us-ascii?Q?q8gvHKbQj5FWm3l8hb4IIKEF7Ac/n8EdCfscRsAIcTHHjFNPkIufiHCfEFCi?=
 =?us-ascii?Q?4Ob992OuMv+bl6+OPR32y2ezOdXBxEg8EZdC5zPe5tpJ0xlZkMufiGWUsxVy?=
 =?us-ascii?Q?WFK3Y1ZXgfujTZohL1VrZjFizKnB4+FGmO2Gm722dQj6k2tWUmQ+ZRVa/nk+?=
 =?us-ascii?Q?oGtrHMzaIuEQb66jzKBRYmeNx5sOsG0EPRK+it0DCeNHpmfXfmeb/uopTIFx?=
 =?us-ascii?Q?05V1f7a8QB1NO0QB5tMuKoiFjgAmbKbiaFeEp4L/GLMV28l+D6bq3PXHMEJX?=
 =?us-ascii?Q?AVtOFyUqkVjHgCRaY4Cw0fG931jF+jCP9+QIEep9aKkgLHZqBA5++UIZBYOM?=
 =?us-ascii?Q?yVeYFtfIm94NjgKL/0fKIaVGmJJlNl4kgFjXxqhHAb0Gazm+HFFuiXqVeeG2?=
 =?us-ascii?Q?xKD+6V80cCjA255aLpJTOAA5D9nP0uvXX0D1NinJPAEanbEx8S/ydToMHM2o?=
 =?us-ascii?Q?bX1ox/LFiTFSKv8Wb+jyjoZLlQPbbPVSmWcl6oH/2d5oTX1ijigwxyVunA2M?=
 =?us-ascii?Q?p0LppqWBNgs4+ulMTfPtG/JNOjQTqNDUC9t5SXj98GB0AnnfC3Z5i2LH/LkQ?=
 =?us-ascii?Q?z7ypS1xPfqWw7yIfRkP9qNL+1ydtRnW6/uWtMYucQ2Fry+SJnGxD99ZdRnYl?=
 =?us-ascii?Q?O24Ohq3I3uSXqpyZwX11gLiMgVjSGfQCWkHV8vJv7gI9NO0kbVlyQm8i1T5U?=
 =?us-ascii?Q?mZaQELFfuFbzYioAJYJeYEdoY/qdj8p5Kf+32Qgb045xq4haZskP8R6aJ+yF?=
 =?us-ascii?Q?wp7X8HxLDHY5GS3h6236CMXLVfmP1GxdBSnxKq8WLrXBHyw4rzVewTT3BqeU?=
 =?us-ascii?Q?jhI2oxTnsf5vZf/iDf7x+HP+ehzURjMAHVoqrHiHLM6WEsGXMwegttkKg/V3?=
 =?us-ascii?Q?Me6mFPTrHcx7OhMyjwlyqKR0O9MuysfyYxRLFJLJkj8kzW0sjiQ0hQ6DneXZ?=
 =?us-ascii?Q?xDZmlLMUFDFPl1ORXDl+5zdknXKLq7DuzAvBU1wkTyWRbXBrvJeOMVe7I1dF?=
 =?us-ascii?Q?iAF/sKRqeGijvEdLfhkjrdK1lbCbP4iMlEqm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 02:00:15.6045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89a04b3-e883-49de-e3c6-08ddd943fb39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
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

The vram block allocation flag must be cleared
before making vram reservation, otherwise reserving
addresses within the currently freed memory range
will always fail.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 77ce9cf28051..e69db0a93378 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -685,9 +685,8 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
 	list_for_each_entry(block, &vres->blocks, link)
 		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
 
-	amdgpu_vram_mgr_do_reserve(man);
-
 	drm_buddy_free_list(mm, &vres->blocks, vres->flags);
+	amdgpu_vram_mgr_do_reserve(man);
 	mutex_unlock(&mgr->lock);
 
 	atomic64_sub(vis_usage, &mgr->vis_usage);
-- 
2.34.1

