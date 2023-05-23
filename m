Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43D8C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 13:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C2EC10E43A;
	Tue, 23 May 2023 13:29:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D64F510E440
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 13:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL+y1KtYnx8bWUH+AvP2QoMTOoIQicWGAkHSKTl5uy6k5aOubCBB60TmmHdWroz3+xfcVNmfAOcRO+YvPbz8JiiliIkoTWPAODpjbBNxSVCAciXEME8Up7C77Lv6XMkiN9ZAj4EXk+dyKd1GCqfRVYZN7e4ekh7eyBojx7Zt/PwAPsrwz1IIT6tgFxOSo7FW/DKeiTHk8oUo1Fp3yYr5z/xJsi/pgbPNQ8Wcnzfg3pfws8/qKxYQ7ze6wH/0zW7bXIr8STC2w6dV1qejJgdqAPOq6+pfuWNNDHjD9mUtl1olH0L94V6Mt4j/y82WfVXepYVShLVBqm8duM0foZzeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKLuZbr8vbZPzc5/N3b+dNjiMFWxqzG7EU2xsvkyBoY=;
 b=ZvAfvPgqp1yyK0tOjecKcl8n+bRCj2dlQUCR6OGk0L5fz/ecj/x8d7Trl0cBXUH3oOuI+fbWYuWLotSt/N9lQGNoMJoLUTwcDyCqq5dVg5bIPdEeI1PVB1iJLDXSbVD4NRbpvMUXC/5X/Qyx5d1moLlYUp4IrEHApNKBP5l84f5JOYfKwmnET2rihV3onCAxdG8ACBQ1gMUBM2ZA52eupNKgkfQnhZyqcI6yESuFHbeXaJXTdlubOZ6JsxkHTjxL1dsWIh7P5JZm/ebDP2F9oCu2vXx7rWwg49pPzaVIj9AIBxW9e2vHUJJR5n0b1z9n/mzCJkWKZiVHwtcFlmJr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKLuZbr8vbZPzc5/N3b+dNjiMFWxqzG7EU2xsvkyBoY=;
 b=Gfa6Je5jTDMMVwaBflP67IDjX7GtqMTMr7282f9ZvsNQhIOCLgyx+7n1KBK7v6dAVKG35QHxUNcHvI7kB3EXe46OWDgUTKDksR/CPqhIrHM4hw0M38u3K6xJi+PYhFfE4ubY8LybQu/Zy4SOWy0vYPWqC4QBRLne/rlhui+wSzU=
Received: from BN0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:e7::25)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 13:29:27 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::e6) by BN0PR03CA0050.outlook.office365.com
 (2603:10b6:408:e7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 13:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 13:29:27 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 08:29:26 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: use amdxcp platform device as spatial
 partition
Date: Tue, 23 May 2023 09:29:14 -0400
Message-ID: <20230523132914.3144843-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523132914.3144843-1-James.Zhu@amd.com>
References: <20230523132914.3144843-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fbcfb2-647a-43e7-d65b-08db5b91bb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N73ujgDM/puLK6KGMFCYEzmkiz2mjwkvBlG7ypb4guWSgPVmvbArF8gdY3mwcXgg0sUEGYCuu3fCg4hA2PCiQpw0Ki+RY5y0LjHqZeG/F9kbfMQDxFd2LSjzn7Tfz+AWrWLyrmvy35DBpwl1ThefLas14Nz9REOgfpwFWBGeJRENlC91csI3iXBa83dtPoyjqFJtEdTYcILXD6QYMs4iHrGYvHa9jQfIo84iIrc+Nal6gWbA8WQ3h18S/NX/EsV+j0LfJsbZUhpHkgOpkq0DWguJwuOijlFksejKuVUzmA97Je0B8sRN+4tCkhWcom9m25EQFCeu2zV+/6KS78ny3ZP6AuzWACdmBx1XRvE1V0E/bsdNXstqursorFPvtUPLC2iXpeaopmqaTd7tUVnuIM0oMckSiFXFuQsktoVURzV3HVPuw9ALFJO3QWbXPx1/PW/bV8QkMWP2teGwkOGB64wyFel0uldC+ZVTGPlwWDvP/H31F75bQZa7tHmQCgwCKSifr/d6H9t7731ObhZKLOtSRstMuLtdxYa5EZpXsZCQT39yRKYY8caQII0FaM8zCE6JUeTYD6CL6VrXhPdz7hvuq5SZ0v83tN2fa65iazH2cqgqA8JF1+hwt2dBvJFxa17qkKouWShpQTq7LuU5SbkfpZK7SfdOuZrfhwn0XgBIwX0NRO/pawm9PK1DL388d0VTo8gIS0MIimSFan5Sm23FVh/iHqnjVhqG4mSCanjSH6BAL+NewSMyXAJC/B7sTWpHzn1yyaajAZ/mTO1UmOyJv01ZS9JH+0ZLP4w7GZE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(316002)(110136005)(70206006)(70586007)(4326008)(6636002)(356005)(82740400003)(81166007)(41300700001)(82310400005)(6666004)(478600001)(7696005)(86362001)(5660300002)(8676002)(8936002)(40460700003)(40480700001)(186003)(36860700001)(1076003)(26005)(2906002)(336012)(426003)(16526019)(47076005)(36756003)(83380400001)(2616005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:29:27.0415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fbcfb2-647a-43e7-d65b-08db5b91bb24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use amdxcp platform device as spatial partition device.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3d91e123f9bd..852c98dd40ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -51,6 +51,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_reset.h"
+#include "../amdxcp/amdgpu_xcp_drv.h"
 
 /*
  * KMS wrapper.
@@ -2944,6 +2945,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_sync_fini();
 	amdgpu_fence_slab_fini();
 	mmu_notifier_synchronize();
+	amdgpu_xcp_drv_release();
 }
 
 module_init(amdgpu_init);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 6ab5713ff741..9e3a7efaf584 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -25,6 +25,7 @@
 #include "amdgpu_drv.h"
 
 #include <drm/drm_drv.h>
+#include "../amdxcp/amdgpu_xcp_drv.h"
 
 static int __amdgpu_xcp_run(struct amdgpu_xcp_mgr *xcp_mgr,
 			    struct amdgpu_xcp_ip *xcp_ip, int xcp_state)
@@ -228,21 +229,20 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
 	struct drm_device *p_ddev;
 	struct pci_dev *pdev;
 	struct drm_device *ddev;
-	int i;
+	int i, ret;
 
 	pdev = adev->pdev;
 	ddev = adev_to_drm(adev);
 
 	for (i = 0; i < MAX_XCP; i++) {
-		p_ddev = drm_dev_alloc(&amdgpu_partition_driver,
-			&pci_upstream_bridge(pdev)->dev);
-		if (IS_ERR(p_ddev))
-			return PTR_ERR(p_ddev);
+		ret = amdgpu_xcp_drm_dev_alloc(&p_ddev);
+		if (ret)
+			return ret;
 
 		/* Redirect all IOCTLs to the primary device */
 		adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
 		adev->xcp_mgr->xcp[i].pdev = p_ddev->primary->dev;
-		adev->xcp_mgr->xcp[i].driver = p_ddev->driver;
+		adev->xcp_mgr->xcp[i].driver = (struct drm_driver *)p_ddev->driver;
 		adev->xcp_mgr->xcp[i].vma_offset_manager = p_ddev->vma_offset_manager;
 		p_ddev->render->dev = ddev;
 		p_ddev->primary->dev = ddev;
-- 
2.34.1

