Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACEEC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 14:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4842510E8EA;
	Thu, 21 Apr 2022 14:10:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57C410E8E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 14:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3yu7OTIbwh3glb/K6XGGOMEeYxQoDpujshKtCT3FuItp5XqDOQmeoFM2ELfca3N8X7ro5AhFjuyoaQLq9WTKlOalw7/78+BmFzYiI/2u6BqSERp+Cr2Bg6eBWmMZs0NnWd/GLKF7aFhhD/CiL1uU3LR3q1fzGfkBjyhsTCDOuHbeyLIte0vXE9Npw+0O3vizzAQ2kunvf0bjLnWgJb5mC2riIEa3fFRvtUrxi201+hCslTpEfbABAgVNfQiSKdw2YVhUYO5y6xXE46t7wqFTb7nFrYM9msByzjm1y1jfj2jOQmexT5ipW2Aaz6ooqEvtvuA8bxQjmRWpVidjc6DvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYrqe1WhtNJo12Qe9Mwz0O0amUE3+4OAKeYltRUhNiE=;
 b=B3TYQLT8CqQbUIUAppKFceSnB5o59lJcHPz25g/hqu3mQt5U207W/kBEbAU5v+MVRKMFnzSvA0V4TGsNDvOi7U6jpTia0CwVwQdo25pFgVOQMghGceC2VMzJRkjSaJUzDS0+6SLHF6xI4U1EJVA09KAWM+e0DDIS2xJRENcnzoEkmEwClmW/qQ4jB2E5nwYbv+CCjzTk0u3YkVq/z6/z1b1nHPq+ZwiNl6s2UF9d/Ajqq5BDo6NGH11CDE+KoaIhGhrYWohtMXTN5bMuLA4gnLSE0ZId4OUGS5tzrXCBZ062Jb9jhxxB9Nseb2CDz3ZZZUL1RQEj8GqtCNwUqaR+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYrqe1WhtNJo12Qe9Mwz0O0amUE3+4OAKeYltRUhNiE=;
 b=tvmRnPyK0AVUBtb88qP78Gw6I9nVXZpeTYZkS+rNofoC1AoFsZnPqb8RGpTWnSGsqOeofjqG7OzX3UCjMMZ1GPFQzJNuzMAp6Fb6wM64bIqyMYV0PhoR7e4JXPi0S/6BelFa/8KFC3F7GpkXZz3oWQQAgwaMURF1k5R4iy+FqRY=
Received: from BN9PR03CA0245.namprd03.prod.outlook.com (2603:10b6:408:ff::10)
 by DM5PR12MB1737.namprd12.prod.outlook.com (2603:10b6:3:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 14:10:51 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::a9) by BN9PR03CA0245.outlook.office365.com
 (2603:10b6:408:ff::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Thu, 21 Apr 2022 14:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 14:10:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 09:10:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: make hubp31_program_extended_blank static
Date: Thu, 21 Apr 2022 10:10:32 -0400
Message-ID: <20220421141032.3012374-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19aab683-61bb-468e-2cea-08da23a0bd79
X-MS-TrafficTypeDiagnostic: DM5PR12MB1737:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB17370B3DF21EE821A0134C7DF7F49@DM5PR12MB1737.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAwgrj99Q3ET2PJIkYx+h/I7WHtANR98FnRdSsF0AU8tLsEXmuPMQ/njyHIXgeglCSlUV3fybCi1bTqyqNFuEvqUU+LlumygamJ+h4/JTAxjCFN7IM2IDG3A4/fTqaa/EGLW+B+LASS2Y3jz+PPgvczu+J6UBmcKicNQ0QYaHDGhls/pDHS2ul1rMIh/s2AwB5H7nNz2JEBJuUjnfKR6CoNp+qBsvSvA5pAUxkxP3yDWnsn1D26d5/XL5xqKCoJcl3aY8Qsbj6t3gyJq8wTjBJQyllw9j18nW0QUfiJlw2XTcsPRHPDk7CH3NPdBCyIYCggYgmiOE9s53dbSzzUCksWSwIYO5P6OrIhGMIg2Ua45JXwT+bxK2tRfP94IlVe+tHnGJNwRZsCbgrgSMKdyNzLsnc4cZ0UIoyFY5NGu31R4YZHHrMx16ZsjTUlnwHQH95yfu0PIASj0N04aX3zIU6C0K/PCzGIlw6M3jvdt2AXeyY0l8Ybp0fWNjUU0sSp+9dTlYE3QAzYV+dF4k5MWihiiPeDWQA3/KWSPVa/byLcxFKilIIKK8WnQxjUFWrgAIeOeHSSRQBdCN9qoRH5j+irCd4/BnxeoRu9lzRoM+bKdiPryXfMhkUV71/leOVcvCeS8sl4OGxLo1jKUSuRCHlHtKf/fxDHwe17sUYhwI8+aKnEvUJy0kjI3Rzho5+4JEIUCUnimz5LZNcMLGBK2gxcrLufwaxtCkf70kXOj20X9eLyFSITPdouGO6Cpj3rXkqhgtQT1r8T4arsDJ8AwFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(36756003)(16526019)(36860700001)(5660300002)(2906002)(82310400005)(6916009)(316002)(336012)(426003)(40460700003)(86362001)(1076003)(4744005)(26005)(8936002)(356005)(83380400001)(7696005)(6666004)(4326008)(70586007)(70206006)(8676002)(81166007)(2616005)(47076005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:10:50.6296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19aab683-61bb-468e-2cea-08da23a0bd79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
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

It's not used outside of dcn31_hubp.c.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
index 8ae6117953ca..197a5cae068b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
@@ -54,7 +54,8 @@ void hubp31_soft_reset(struct hubp *hubp, bool reset)
 	REG_UPDATE(DCHUBP_CNTL, HUBP_SOFT_RESET, reset);
 }
 
-void hubp31_program_extended_blank(struct hubp *hubp, unsigned int min_dst_y_next_start_optimized)
+static void hubp31_program_extended_blank(struct hubp *hubp,
+					  unsigned int min_dst_y_next_start_optimized)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
-- 
2.35.1

