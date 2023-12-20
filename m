Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2115C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 14:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051F110E570;
	Wed, 20 Dec 2023 14:11:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C2A10E570
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 14:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G54b7uu2r7UM+r54OOoGlFekx6368Z+gRqvCPTJRkB1hnAUKSNrJq92TkwHqhEprwxcX42dJt4HPcYtILXKGqKEQuglTZ7n4F/d5bFhCgVakVm2aaOzxNesaWUW7KL9cjiPgclUKEA8tZEWWVo7zGjUc1GUyYvVnc6ZIMpvJ/QiCCCq3R4B7TBPRZ/kMteQCFEViXyZDnTMt9e2AR95WK1stdVPKwJEgrRnpyh/fR/OXQJ6vljCTtoc+3kEW7GG+aj2o0Ia1KHTGDlMZxsFEMapTgoHJLk+ymOMq6VuwEAZ5DNxK8hTM/9kW3crytyEGLFaB0GzG46Ff5qY51NqbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaHMRkUd0RzX6IW55dATIe+Tj5dYjXO5t4OuuB+X+Ks=;
 b=lMsJ4vrLFhdG+SOgmxjewcD4yKxqid341ZjSZpVXWoFtjNHHhyX04I9ZBk2XDFhVqC2D6luBtQHZFlzKMU8lk19IZrfsHYYPwCNJT1UGjqxlq2fzTpBm9LxWl5lcB+NvC+bTnn0MVhJywN58nzxH/UknYZgIGaNu1VA5G4bA0wVF7Kkcw/AAJGpt8EUX+Z8GKiaZeZ3n1YYLg2TPiawD61ztQKbjS9jVNL2zHpoZ75iTXuYeW5vO/6LSJOA+HNp/6qaz1jluyUT0JADRKID+9kGcnLV7uAFxU7xraWgs/P722fYvCdddbbDAJeEDuigBzDBSmMe2bwaVl0aWasz2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaHMRkUd0RzX6IW55dATIe+Tj5dYjXO5t4OuuB+X+Ks=;
 b=cK5iB3gmZTApBTEDgsBkg9uPxjDzL9ImHen/bbAIW2hA2cyk1zvpJwoSKLmsSvfaLuUfLz/A31C7KAW3ZlaLOrdTV/TbDNlycVBO0RwkVgO3t7TwZkgIRcJGJOL2OOq5Z/jJo4zLkOkQovE0cnBICLf4+fy+yh2NsOVL7a62Rls=
Received: from CYZPR17CA0006.namprd17.prod.outlook.com (2603:10b6:930:8c::7)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 14:11:02 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::56) by CYZPR17CA0006.outlook.office365.com
 (2603:10b6:930:8c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 14:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.19 via Frontend Transport; Wed, 20 Dec 2023 14:11:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 20 Dec 2023 08:10:45 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Use kvcalloc instead of kvmalloc_array in
 amdgpu_cs_parser_bos()
Date: Wed, 20 Dec 2023 19:40:28 +0530
Message-ID: <20231220141028.953132-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d2a898-ce01-4aa1-d298-08dc01657f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMpuB2PBZ5fHFB4LGOixOlQ17poQ/YvNQoJqS2mjCTDA948u5C0qWT6TIx9Cq0tClUt8lKWazEzf881S/Vnsflq+BPW4NHEkla3R6yz+ZqqsqFiyrpHVQa/E9LjnOltSt9NPGbiBJmcAJ8SJZXUQTfR2DjMI1STlPS481C+14idLvboUvMImRMo9nzNtfbao3c6d30z0m14/4qMnPCnZByh6IB5zTYCzmoYFgI+brlGAJCfqhj3oNp3MxE/+MNlEyDhg5welop1tQRD9WduEiNUKYGTW8/JjVZv5jA6P/VvULAe4PCdPLkF5/EQRRhTzDabF3V8cgO0amcEJVIkvNZV4o7XXNTTpKEZCo7jBKQHtIisZpR/0ConEv5D00BCJdjTTOir2zzk3FGNsUo+3fpf29S//VcEPQfKK/jiE82T3U+y90LRb3lvJLIbVilbIqtzMI7tYusDMZyv83CaXExM/11Z1lRF4OIKu0aWzPtWSxYo+C1KPyKyWRX+3nDVizJe0fw4iYauom6Gg3iVJo4uaoH6tsvrifX+WjUs4jvtuB29S8ZrVpKJ+Wg804t3pTcNuFsudQ3fpgAN9RtV5T6hTYRMcOQNtCc050HIplXDbshyrTX+2v2Sag0WT9tv9XE988b4jvr85GxELOBuxD9gCaOzOG8Q+3ksVsqjSGitv0fReW4U+8j2KdwzXiyPtjTGziiIoW/6Hcw71A7zFJQ8EpWgPEqhbAGla2Mka7qx56LPCS02DL+647prnXGDwiCR0y+TUnlTVRvLqLbES7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(46966006)(36840700001)(40470700004)(356005)(81166007)(82740400003)(7696005)(41300700001)(86362001)(36860700001)(16526019)(26005)(36756003)(83380400001)(66574015)(336012)(426003)(47076005)(2616005)(1076003)(5660300002)(2906002)(6636002)(8936002)(8676002)(4326008)(70206006)(70586007)(316002)(54906003)(478600001)(110136005)(40480700001)(40460700003)(6666004)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:11:01.7764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d2a898-ce01-4aa1-d298-08dc01657f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kvmalloc_array + __GFP_ZERO is the same with kvcalloc.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:873 amdgpu_cs_parser_bos() warn: Please consider using kvcalloc instead of kvmalloc_array

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e50be6500030..83c7fc09218c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -870,9 +870,9 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		struct amdgpu_bo *bo = e->bo;
 		int i;
 
-		e->user_pages = kvmalloc_array(bo->tbo.ttm->num_pages,
-					sizeof(struct page *),
-					GFP_KERNEL | __GFP_ZERO);
+		e->user_pages = kvcalloc(bo->tbo.ttm->num_pages,
+					 sizeof(struct page *),
+					 GFP_KERNEL);
 		if (!e->user_pages) {
 			DRM_ERROR("kvmalloc_array failure\n");
 			r = -ENOMEM;
-- 
2.34.1

