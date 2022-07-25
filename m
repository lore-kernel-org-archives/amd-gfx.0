Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB50DC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 17:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512B0C1197;
	Mon, 25 Jul 2022 17:15:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0C8C1197
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 17:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3bYSxFnnrABLMuHJ8s4evMtbSehy3yl2FVbyjvOyUQXANggCJ6MMFlEksjas88zJwmAJjHYIObu0nuy4VREMpT9dCw3tc2CIxb+jmsDNUCHqBSXq+DVHL5TH4FoetntyXY46hO+UZMMCaPOBgemc8y29ncsLw5QpyIwSZhcXgkCuW97pUIu7KSEFoz5CQHtXcghPZcTp+maZlnLOteSL/RRUAOkp6J1CcNyxejKmFpFjFKEQB/IqARK7bqo2TbrrfwgROFURhuWyUrReQFe1Jj/D5pFMZL4TLMjH4pmclWl65JhgShEzRMd/AIHqmqaK3ZR73yOrgFx/AS0KGYYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z/7eWwDeoY99sTXIjritZiiyYvkBVwTvm++CdjLA0c=;
 b=KZx4nG9Yt/z9I5inoty/1j+kFvBEXWjR7sNd6KpV9nnfcdELOg8L4Lg+TtTJInXy1qHWTBbRNQhHx8OHVBbOxV0e6mleOJzjk78XuQ6vLadrk580FBaOPf/ihvsR3ypKlEISUG9xTsq/fLQg8OwCzBdHJf6H6rO7tA4ZplvmW29A6Pfh2IoGTAfvFIGKUz96fXD9DEs2NZh+XAz+AA0hyNwwm3OMhJsvAT58pGTBHJvfHQnvaeiXiRn93e5xgc8CxpbwoHdAk2LFzWjGr07FDCBYwoRqu/Y5JnLTh58Ea+nKs1n8e6ANcChzUqGxnYDwx5l33Uc+aTmxAt3CszHLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z/7eWwDeoY99sTXIjritZiiyYvkBVwTvm++CdjLA0c=;
 b=UcSUzXE+V6hAtA2fq4k+Jsuz5M3FjD2w6IARpAk5oe7PcADyvCPzwoCi8h3S+NrhMRKr7ab/CPgKUUoLnUKBPv8QTzwk8HGL5hYEqyXIgWiCfwcBde1jgNbPuwJwt4RCLmUwCBXq1LzUSuguwxm3wBMbtyMbWwwcb0lheKAUYG0=
Received: from BN6PR2001CA0024.namprd20.prod.outlook.com
 (2603:10b6:404:b4::34) by CH2PR12MB4875.namprd12.prod.outlook.com
 (2603:10b6:610:35::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 17:15:26 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::c1) by BN6PR2001CA0024.outlook.office365.com
 (2603:10b6:404:b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Mon, 25 Jul 2022 17:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 17:15:26 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 12:15:24 -0500
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Remove rounding from vram allocation path
Date: Mon, 25 Jul 2022 10:14:41 -0700
Message-ID: <20220725171441.11695-1-daniel.phillips@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5dd0992-2700-48fa-7a94-08da6e61444d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4875:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWE2wOWJsd6x/3owNScYK1wO4McTkAzW3hz+MIts5Q1fGuILrxan30oHx5kcV3ZevLJuCsYc7T5gwbjXGrKRHOdEO10XFzJ8dLBHdyDp+sR4P+2OMS1QkIk3euJFSntezsH1j/KKXEb/OQv3pFEZ14u1fK+IxQ84klp3/YTH4y4pA9biphbXRV5jUzDBtTiFm23neOD3B6uiv8cBbxgz8Zrw38nJnDpgdcHi+wuQofugyLPzxQb4AwVTi+mgOK/RmBeRrDXcppl/vzB2R9E9eF0Nz+T8itOYzvjWI20MqhoF6/g5WQhEnbh1XJpiphFCPakXyCUarraoti5i1FSvGEso2oLqP6aTwLnNpYVozOrcHPLG0Q9y3NwEN/S2GzvOvBTDQPBUq9WlUR3yDyc7uw3LewHWpu6gLUsHXId5fgN9p+jKLLwDw2+Gv4XXd5tHP65bkMImeKuMlzSwCNOJ980r4ejG54x0nJjW2eS682c49uLpS4hsKk9jCOVOn71gH6LLnrJVcSZ1pyS3h3RfY7y6AnYYqon6m6Ytc2YDOAGhf3QmQTWprpQ+0AxGcJXTUXO+ofbr9AyOV68OzKqg7X6vCX/ucqTIZ8+oYF+Fg96RoGtjXuirecREcHDzwNITnHuEvIDigcmk4vMhtO37+AFn3vl8dt3qv9/s1GaHqd64piFWD40EpZL+fR0QbKXqVOCco/SqxPAWBSb214mam8xJ1PCJK3uGfdFBT4J+XbnnVtP8pcBGy6QlZfdgk0Rd9T3XusiwNS2AFlXgqnkBeoWXKWJ8cBzoLGPBsejNS+WKaoZToaMzFv7t08xmmLHvNDIlgDLy+pD7c1wiiqunOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(40470700004)(36840700001)(426003)(2906002)(7696005)(6666004)(41300700001)(86362001)(1076003)(5660300002)(83380400001)(47076005)(336012)(40460700003)(16526019)(186003)(2616005)(8936002)(40480700001)(44832011)(36756003)(356005)(4326008)(6916009)(8676002)(82740400003)(70206006)(36860700001)(70586007)(54906003)(81166007)(26005)(316002)(478600001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 17:15:26.2064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dd0992-2700-48fa-7a94-08da6e61444d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
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
Cc: Daniel Phillips <daniel.phillips@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rounding up allocations in the allocation path caused test regressions,
so now just round in the availability path.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 043a808c88a3..014a594899fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -40,10 +40,10 @@
 #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
 
 /*
- * Align VRAM allocations to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
+ * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
  * BO chunk
  */
-#define VRAM_ALLOCATION_ALIGN (1 << 21)
+#define VRAM_AVAILABLITY_ALIGN (1 << 21)
 
 /* Impose limit on how much memory KFD can use */
 static struct {
@@ -149,7 +149,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		 * to avoid fragmentation caused by 4K allocations in the tail
 		 * 2M BO chunk.
 		 */
-		vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
+		vram_needed = size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		system_mem_needed = size;
 	} else if (!(alloc_flag &
@@ -198,7 +198,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		kfd_mem_limit.system_mem_used -= size;
 		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
+		adev->kfd.vram_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= size;
 	} else if (!(alloc_flag &
@@ -1642,7 +1642,6 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
 	size_t available;
-
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 	available = adev->gmc.real_vram_size
 		- adev->kfd.vram_used
@@ -1650,7 +1649,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 		- reserved_for_pt;
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 
-	return ALIGN_DOWN(available, VRAM_ALLOCATION_ALIGN);
+	return ALIGN_DOWN(available, VRAM_AVAILABLITY_ALIGN);
 }
 
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
-- 
2.34.1

