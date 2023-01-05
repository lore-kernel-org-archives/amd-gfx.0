Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF9AC3DA7A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 19:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE79410E244;
	Thu,  5 Jan 2023 19:28:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B2110E244
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 19:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrPltsNdV8C8CcrfXbs8YfYWF5FyhgcBCJf/7+fDSiJ0bnoCGZh3LQr4nE5+mXRVGQa1QsEjIdO1sG8Gpg5rAwdfubdORTNXEz+5sWBz6ziQwJY44RI8koMrq7FGHC525DICk10dYj3Hq4+pWJe6yupgbCjT+Neqbb+exS1PlsmDhIJfylmmhamW7S5ciSP2ApX36YWJK1dkgZpi/Qgw8zbOoq8LT6tBAe+0xlfAIOwJwfp7qlQVv8MWbxIHhqiHr5VF7Z1hInXktQ5PyazOAFvPv+DpT1ITOZ4A7YyZWc3QWgIoVA2A11eMxGpsG+8uWlLjV5XDcm4tege4ebKB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkY1RexmV9P1/6XcrYU60lMmdg1yyFdFXmBtfeTJKko=;
 b=UVo97/6DuNm6gg5aUfoGt2oDH9WkEifJDKwAXzj4sk3+GLNWYSb4BnH1f5Ome+5c5yTtGEWJBtqSNyd5jCf4ShRByg6E0sN1VqYvPaZqHsJs8urt2Va/vZccPShDe4KUeJYfnYVWG4mlnPqQ1pflQ93JsAvEJJEK8Z/MtKVhnORBcOW+hRYtYBBB3qZctYMd5L6yhbKx1inn7ybKnVSM4UJQsC9x8UT1EFZMuGTjZc/O+ns3jt6CUW/8+w0UzkspUfjWTKvs7SW6/p4xffAGzcPCfQNh/xPCJNj2N0N+pFdO1FizBNOoq3tzmEoISoJQkTwRs+QsyBdFQSgBTZjGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkY1RexmV9P1/6XcrYU60lMmdg1yyFdFXmBtfeTJKko=;
 b=OCDbFF7N1uGsDwy4sytPmSZjEdIe1dyQ+RpZEYTsqQ5Za8pYUn4K9xlKq9Ekvjit9INjAuFacCtb/hVizqDcKMPdNU0dhzGDPqo00B7mzo/g6uqjFKOqGoIOrEmIVHLfi88iObYqfhDzmxYHDR3Ofy2697xztf2dMJsljXde80s=
Received: from DS7PR05CA0005.namprd05.prod.outlook.com (2603:10b6:5:3b9::10)
 by CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:28:41 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::25) by DS7PR05CA0005.outlook.office365.com
 (2603:10b6:5:3b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 19:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 19:28:41 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 13:28:40 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix NULL pointer error for GC 11.0.1 on mGPU
Date: Thu, 5 Jan 2023 14:28:25 -0500
Message-ID: <20230105192825.138353-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|CH0PR12MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: e5902151-792e-49c9-2373-08daef530da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBMjWYN2haE5vknjzw3upT1TajrROqoR1UuJUS0G0JI3Y6VY1UyapjKR32H4wqQsICQdAdzyCyJOGTe0QCvcPpzR9Xd6hiotsYGl0L/dMF/QgNT1PvOu9h3Bxnuxyhh1l6fXuBYgqFSm4U0nNHActBh8yvHF9UuRy0XacXSTub2KRjs16AnQ98F82UD9a9vRmqH5uMecUOHDZiSOgfF6OIMfb2eXuyrdO7KMOa2vNE8Oee9hWQtXH9uqB8tqN3+ohT7MdCepTUAEnh9LErZZvDTQFQ7qIf3McPpn1X9g87MIfAl6n+zw04LL313sUMosVD9mltcHXrkPr49WoVEFjMfcDAPkr2Rkms6LsxBn1G1lhILvEdYFYa/K/KuPOa2dCMWX0wKRfiAtnquHx1a5IQvoUvv0mLh1SthuWxWBJq98sVGjeoq0bNmfoJMarA24dQxgn+yA7SJLqM1k/sQICqwVT3Gc2nimdNr1sWeRxNgi3h4jXEBF/vqyDUsyamIu3TKb9bOPRRtro6Oy9vQ4fav0xXAtnik1nSpkjIyUoYijx5+/2xLx2a6JUrls7lzkJvgfMorcxGa6KKdz4/GsLGZIFdOX3bmWTd0cT1RglBxge1bEgWgwwYkXrzy3mGmp/YwtPyqOQ2YeFP35pQMvEFvmH5q2PMm4hgEf6WgEcsEF7jdwgZuGvHBuGrPSk8VkSRsFnYxByhV9sjJo56v81/fDHDts860NgzvqmrdHxhc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(47076005)(426003)(2616005)(26005)(16526019)(186003)(83380400001)(82310400005)(40480700001)(6666004)(336012)(7696005)(40460700003)(86362001)(36756003)(36860700001)(356005)(81166007)(82740400003)(1076003)(4326008)(8676002)(5660300002)(2906002)(8936002)(316002)(41300700001)(478600001)(70206006)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 19:28:41.5775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5902151-792e-49c9-2373-08daef530da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5026
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The point bo->kfd_bo is NULL for queue's write pointer BO
when creating queue on mGPU. To avoid using the pointer
fixes the error.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c      | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9885735f1a30..d4c29e9edf34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2179,7 +2179,7 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_b
 	}
 
 	amdgpu_amdkfd_remove_eviction_fence(
-		bo, bo->kfd_bo->process_info->eviction_fence);
+		bo, bo->vm_bo->vm->process_info->eviction_fence);
 
 	amdgpu_bo_unreserve(bo);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6013f498ea1e..55c2dc48e567 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -231,7 +231,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
 
 	if (q->wptr_bo) {
-		wptr_addr_off = (uint64_t)q->properties.write_ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
+		wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
 		queue_input.wptr_mc_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
 	}
 
-- 
2.34.1

