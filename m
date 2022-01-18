Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E79C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 04:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB3F1129C5;
	Tue, 18 Jan 2022 04:04:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BAB1129C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 04:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlNtKFf15oNxiB0eBy19T27CB1fKyrJ88j67bsmAdvbLy0pOTRot5QgJGr+foY08IthfUehVS1GOgStXYKEbbD4hkgr1xZjJ4MdrGf/TJfbigowt+/IyRE5NlRbsAmsgDTfQUV4eSjgKiejIxdOyNSjaDimBDBrMtJrjeGeSPXwzSgmyVCHFoFxzK/+8lV9rg7N65/752zTzG4PFc7/jVhm+7L2ex3SyVLJUWH2fzkVDnvJvHdAR7dKE3dQCM2Ezn4u9DANeADP7hAsCILyTqE9kcVa0Xvvz8Ci9e8KuXPczuTs5SwIRs/7CDQpC/9zstPgx8ZMvvuDlFp0jS0G6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLG+GNmoKNoAD8Uq7omOw83fNFfWu2MQYQzEiTn9Zg0=;
 b=gb7vyrviV0F+pPlKC8JWuFRgM7oNIcheI4QxgElBzTIxbkuqd0amqzXbPd+BfpesmaK0cI2S1uA4xtXdIgBb+nYbZPcnmED8fwoosYdasFTFF0BxsGBKy4LPXBu1Pr12NwGqVcGKQ0NMFBLKugxaUz/S7zZTUlcEspYa0X31W+aVUJGYwUrXfzR0iIkQDpYpS/hOwzqf9q64TK8ud2KgnP1x1pbPvPz6LWjM7wyqDT/kV/tk0RxOS5jjt4Nc22VFLs97/kvcPobzpv5stJW6WzYfyDz/poU+wLInrRl/1tduNcTu7csmLyJ011DUHqYxLbZiZbBpNCQheRJg0p6yrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLG+GNmoKNoAD8Uq7omOw83fNFfWu2MQYQzEiTn9Zg0=;
 b=2Nkmr9Y4G+1ZV5JH0cvRdtX0rE1KHA2KCnyaHhE711W1/IU8FKdQkAsft9s0E25JQ9qccNWMnRN/0Yrmkys0UcXZE1hlMMY2FlGzS3M82wU1HR5J9MdDqAdb2SBk3YIrFmQKQ1f265UFMaetpDOxQzhkjcon34hfHWS+DDwUqEI=
Received: from BN9PR03CA0947.namprd03.prod.outlook.com (2603:10b6:408:108::22)
 by DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 18 Jan
 2022 04:04:09 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::a9) by BN9PR03CA0947.outlook.office365.com
 (2603:10b6:408:108::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Tue, 18 Jan 2022 04:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 04:04:08 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 22:04:07 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/1] Add test for new hsaKmtAvailableMemory library call
Date: Mon, 17 Jan 2022 23:03:43 -0500
Message-ID: <20220118040343.666586-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111021442.3221240-1-daniel.phillips@amd.com>
References: <20220111021442.3221240-1-daniel.phillips@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9be80cd2-7938-4a93-f682-08d9da3793ab
X-MS-TrafficTypeDiagnostic: DM6PR12MB3771:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3771A28550CDED8649FC416792589@DM6PR12MB3771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8o9xaqMFf2sMlGJhgRoi3gMTgNILlFjNoIvtET/2Lqa/U1IwHWKjXOSelncdmMSAoXL0/J83P9lZ5NXxJiTTaVknZBIOdVISKJOxl4LorDd0d6ZPvzlm4fa97bWBUByKxWTS25vpRPI+t3qJsIgMHGaDfmZIfTtdslEBVWQvp4i1bQazirRirTTVWouDSY+Dn9McIVT9yzKgCq5SYETRFXJ0+Zg0EY7uCQm5XecILi1X9VO3+uzaE8WG1ahaHnbccAjOrHneCIqDh1NmQgMOgKYfwqrkCsQusVfcg5LIziltVuTZtGvnB9OlGL8WsjGcvCwnBzLVjIyP5f14UNgfqdL9cyamU/amAUZ8QCtSw8gCZVR/gWH5cUq6b4pUt4WeTmx8P5ecAgWEOcX5feeN84i9P85EzS9X7bOMR1fGc1AujInHbqFQU1Y8SG+yGclgN8VkYLa/zmGXMarZP6ZqWdmK3g26GQHmK/3m7rUuuBvM9uxFIBLVLRyj9+r4IRlsYHDKVk76wEhoJBh6yurFKBMeycU78BxG47FHhcrcH7epKS90fSaKNeGc/dXdWVxNk7y79o0Ql/RDtNvrmML9dotyoaFdVH1Fye0aAv1yIXIBXVdNY2LMILdPvMgCkm3JzoGOZNPz6Ses4cq1z9vJWQ4oUl4Dv2Iec1R8YtYdEoAjoSLtuFImZmwglenpu3A1N7VPYQBCZbOhkK/F+H52ocoQAaSWkYuEoRHQ8DjJZXOp1iR31RCuue7Hsao39tPDI0M0AYx6irvwtLOfzpn/Px70gwHjf82ihccBQ9bKnCk/t8H/2Zhgh8WI9gXGnHlnRXzmR1Nnb8icgfErfasEWWM8hUc6EenmewPqB/p6vLU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(316002)(6916009)(2906002)(70206006)(508600001)(336012)(36860700001)(186003)(81166007)(36756003)(83380400001)(8936002)(356005)(19627235002)(5660300002)(40460700001)(426003)(26005)(6666004)(7696005)(70586007)(47076005)(4326008)(82310400004)(86362001)(1076003)(2616005)(8676002)(16526019)(131093003)(145543001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 04:04:08.4744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be80cd2-7938-4a93-f682-08d9da3793ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
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
Cc: daniel.phillips@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Phillips <daniel.phillips@amd.com>

Using DefaultGPUNode now instead of system memory, usage similar to
other tests. Also cleaned up pSmall, which I originally intended to
just let float away on the mistaken assumption that it would be
cleaned up automatically at the end of the test.

Basic test for the new hsaKmtAvailableMemory library call. This is
a standalone test, does not modify any of the other tests just to
be on the safe side. More elaborate tests coming soon.

v2:
* Change ioctl to IOWR
* Allocate non-paged memory to actually get VRAM
* Align available memory to page size as required by hsaKmtAllocMemory
Still doesn't pass on Fiji. Available is actually larger than the physically
free memory on this GPU with only 4GB of memory. Needs more refinement in KFD.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
Change-Id: I645006a89bd8d55ef7b1605611e8ef0c010dad1a
---
 include/linux/kfd_ioctl.h           |  2 +-
 tests/kfdtest/src/KFDMemoryTest.cpp | 24 ++++++++++++++++++++++++
 tests/kfdtest/src/KFDTestUtil.hpp   |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/kfd_ioctl.h b/include/linux/kfd_ioctl.h
index a81ae37..f9af830 100644
--- a/include/linux/kfd_ioctl.h
+++ b/include/linux/kfd_ioctl.h
@@ -1252,7 +1252,7 @@ struct kfd_ioctl_set_xnack_mode_args {
 		AMDKFD_IOWR(0x21, struct kfd_ioctl_set_xnack_mode_args)
 
 #define AMDKFD_IOC_AVAILABLE_MEMORY		\
-		AMDKFD_IOR(0x22, struct kfd_ioctl_get_available_memory_args)
+		AMDKFD_IOWR(0x22, struct kfd_ioctl_get_available_memory_args)
 
 #define AMDKFD_COMMAND_START		0x01
 #define AMDKFD_COMMAND_END		0x23
diff --git a/tests/kfdtest/src/KFDMemoryTest.cpp b/tests/kfdtest/src/KFDMemoryTest.cpp
index f7ac73f..b722ff8 100644
--- a/tests/kfdtest/src/KFDMemoryTest.cpp
+++ b/tests/kfdtest/src/KFDMemoryTest.cpp
@@ -595,6 +595,30 @@ TEST_F(KFDMemoryTest, MemoryAlloc) {
     TEST_END
 }
 
+// Basic test for hsaKmtAllocMemory
+TEST_F(KFDMemoryTest, MemoryAllocAll) {
+    TEST_START(TESTPROFILE_RUNALL)
+
+    int defaultGPUNode = m_NodeInfo.HsaDefaultGPUNode();
+    unsigned int* pBig = NULL;
+    unsigned int* pSmall = NULL;
+    HsaMemFlags memFlags = {0};
+    HSAuint64 available;
+
+    memFlags.ui32.NonPaged = 1;
+
+    EXPECT_SUCCESS(hsaKmtAvailableMemory(defaultGPUNode, &available));
+    available = ALIGN_DOWN(available, PAGE_SIZE);
+
+    EXPECT_SUCCESS(hsaKmtAllocMemory(defaultGPUNode, available, memFlags, reinterpret_cast<void**>(&pBig)));
+    EXPECT_NE(HSAKMT_STATUS_SUCCESS, hsaKmtAllocMemory(defaultGPUNode, PAGE_SIZE, memFlags, reinterpret_cast<void**>(&pSmall)));
+    EXPECT_SUCCESS(hsaKmtFreeMemory(pBig, available));
+    EXPECT_SUCCESS(hsaKmtAllocMemory(defaultGPUNode, PAGE_SIZE, memFlags, reinterpret_cast<void**>(&pSmall)));
+    EXPECT_SUCCESS(hsaKmtFreeMemory(pSmall, PAGE_SIZE));
+
+    TEST_END
+}
+
 TEST_F(KFDMemoryTest, AccessPPRMem) {
     TEST_START(TESTPROFILE_RUNALL)
 
diff --git a/tests/kfdtest/src/KFDTestUtil.hpp b/tests/kfdtest/src/KFDTestUtil.hpp
index ee88ed3..420b7af 100644
--- a/tests/kfdtest/src/KFDTestUtil.hpp
+++ b/tests/kfdtest/src/KFDTestUtil.hpp
@@ -33,6 +33,7 @@
 class BaseQueue;
 #define ARRAY_SIZE(_x) (sizeof(_x)/sizeof(_x[0]))
 #define ALIGN_UP(x, align) (((uint64_t)(x) + (align) - 1) & ~(uint64_t)((align)-1))
+#define ALIGN_DOWN(x, align) ((uint64_t)(x) & ~(uint64_t)((align)-1))
 #define CounterToNanoSec(x) ((x) * 1000 / (is_dgpu() ? 27 : 100))
 
 void WaitUntilInput();
-- 
2.32.0

