Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873DDC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 17:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C2610E1FD;
	Wed, 17 May 2023 17:17:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFAC10E1FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 17:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK/hljJ4+mmkHDRfc0klIRRuV/cgHyCQAqi2KWGl5o71mrFm+KpbkKZJ/ipGbzMRti45acRSjmpb3JVuLT4khH03E+Vl6oaqDE+hmOo4hP61SBUBqcH8y4sN1fNeq1v9vBxdNlRX+UOj22xFIEmmPhDnFoFYtd4oCaapMqJ1Q4OFIUfr8Jc+zHkQfAoNIt6Pl8fcDaZgCH+z4qsy4/MVIPC/eqtm9HJdMjKt4LAIB+EIFMGRQc6dfL2IVOw4hRVxCwpN6RFsM26xsnsYGI8x9WuVuKWrbHlKDAVOgV9h1su5NmshE01JBDr7kTCc3yq81ZrerbmXB0T/47iFBYNaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiVewIPalxV7WZkT/31atsqoyOa0lXJZmHqqoUAwcyo=;
 b=ULGKTr1BjfnycX8bG1Y3rTEBaT34HPBI1J5rUDCS5sYNE5OvmqBM38QvSfuudUp7qUbJ5LeMY1lAD7J8sTXYm2s/HMQgsvSdD9yV57C48eItpzEhPYaR/Iz3krMD4FPQaasxcSeJ6oVkXbV8eaOs0cHC84M3VzyBgIMMNLVyYOvMlnRQokdnb1LtzpI7Sw3XGtYHmwbj3hSL1vJpuTIuRz4mmW/8B5elKEU0hdN8Gwi154YKJrvCkX4KJlSmChsyVdF/VI5B3y3gdTrszNQe+zZARCJ0hN3hAzPNaHKHuDhJGBJIS0gPezEBOKFF/Aso/VcR8sSnvhJmwJhYBn4RtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiVewIPalxV7WZkT/31atsqoyOa0lXJZmHqqoUAwcyo=;
 b=ebhwxbgimZ/35VJ1DxikL2vwEy4zc7ex3m8NPK9Bsvg5GhYdOgQsqjNBF+4G1MpM3anu9tghPXpaTt0QMZaWjWAMY0jrg+mZvbOMhX9M/Ko2DKEUZ46XNK1ouN2MESCTM0KvRD2reGR2Rkh5Vq3Yva+9mzLVQyJYoqQhTltTjjI=
Received: from DM6PR13CA0052.namprd13.prod.outlook.com (2603:10b6:5:134::29)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 17:17:42 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::de) by DM6PR13CA0052.outlook.office365.com
 (2603:10b6:5:134::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.14 via Frontend
 Transport; Wed, 17 May 2023 17:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 17:17:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 12:17:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
Date: Wed, 17 May 2023 13:17:26 -0400
Message-ID: <20230517171726.4188188-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd550a6-e8a6-4fb5-52a6-08db56fa9f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3E6XdUMRQ6AIhScq261h3AghuJ5aD0YVwVMOcLZbaDIu4rTWcW6Dc5uLWR7x7IqLLevoWn0/tD3kYniibUtoDr1NyI/MNHXdvFcSkprZFfkYvy6AoM615JofFs6m5AKZIESpxSP00EhwjBcU1gERJhsAsR7PThjZJBe5t/YNUeNmwi/CvOMFiINANUym05nHu1Ghy/E7FSG075HH430VHaWtFFp6hHOnTNoU3PSGnUDROM7n88+Oym97+7KhKuvk0YbVFsuzvIXDwWqy9JeqHna2RZUPZDrkMRdP8SXSJunCEJf0e8YVA5jSowj9XCuw6jRA9CAhBvIG6IqFOIixHALRpNp2/EF3UPAzRFEcGp5wIwEQj9FLKZKN8q1QaZfVJaYkW/irvxA6CdM9HRGbs6NDZGpPGR/N1eXqALZE8sF8e3Zo3k6e2yN4/eav5jMu71TJGHITPlKOZz9XIzY5H34Yd8JC8s3Lh0b2stVjTq5lBYA/2pYiPh94VFmbYWG9tXzc9/hkN61rgJSFgHSl4aRSnubFXpoaQ+TXQuJ7ZV5aCYoyrZ6b3ndboEn9n3ALq7NcxOm/0ygvEygaaFHkfpvahCXbWjFx09GoiUGWaJ7oNuV9K0awOalhJ1uUaGyCQFdHXPvA4sG5YRFrgYt3ndmBZZ5oxz1WsxvfpXwXnyQNEL9JaXnjCNhp+RtkhrLGJGufDYAI3YYhpeP9MX5s+PMjFFL+dP9fVNWnkWPg8RCvQZwY0my0en3Nma5fF88+x1Dw+gW42VNT8sU2pC6VdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(4326008)(478600001)(316002)(2906002)(8936002)(41300700001)(6916009)(70206006)(54906003)(8676002)(70586007)(5660300002)(6666004)(7696005)(26005)(40460700003)(1076003)(16526019)(82740400003)(186003)(81166007)(47076005)(83380400001)(40480700001)(36860700001)(36756003)(82310400005)(356005)(426003)(336012)(2616005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:17:41.7782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd550a6-e8a6-4fb5-52a6-08db56fa9f5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rework logic or use do_div() to avoid problems on 32 bit.

v2: add a missing case for XCP macro
v3: fix out of bounds array access

Acked-by: Guchun Chen <guchun.chen@amd.com> (v1)
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com> (v2)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  9 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 11 ++++++-----
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 739eb7c0d133..5de92c9ab18f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -794,3 +794,18 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev)
 {
 	kgd2kfd_unlock_kfd();
 }
+
+
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
+{
+	u64 tmp;
+	s8 mem_id = KFD_XCP_MEM_ID(adev, xcp_id);
+
+	if (adev->gmc.num_mem_partitions && xcp_id >= 0 && mem_id >= 0) {
+		tmp = adev->gmc.mem_partitions[mem_id].size;
+		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
+		return tmp;
+	} else {
+		return adev->gmc.real_vram_size;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index be43d71ba7ef..94cc456761e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -333,15 +333,14 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
+
 #define KFD_XCP_MEM_ID(adev, xcp_id) \
 		((adev)->xcp_mgr && (xcp_id) >= 0 ?\
 		(adev)->xcp_mgr->xcp[(xcp_id)].mem_id : -1)
 
-#define KFD_XCP_MEMORY_SIZE(adev, xcp_id)\
-		((adev)->gmc.num_mem_partitions && (xcp_id) >= 0 ?\
-		(adev)->gmc.mem_partitions[KFD_XCP_MEM_ID((adev), (xcp_id))].size /\
-		(adev)->xcp_mgr->num_xcp_per_mem_partition :\
-		(adev)->gmc.real_vram_size)
+#define KFD_XCP_MEMORY_SIZE(adev, xcp_id) amdgpu_amdkfd_xcp_memory_size((adev), (xcp_id))
+
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ad664ef640ff..34724b771ace 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -818,11 +818,14 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
 	uint64_t total_pages = ttm->num_pages;
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
-	uint64_t page_idx, pages_per_xcc = total_pages / num_xcc;
+	uint64_t page_idx, pages_per_xcc;
 	int i;
 	uint64_t ctrl_flags = (flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 			AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
 
+	pages_per_xcc = total_pages;
+	do_div(pages_per_xcc, num_xcc);
+
 	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
 		/* MQD page: use default flags */
 		amdgpu_gart_bind(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 938c8dba9057..d559e7bc0f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1919,9 +1919,10 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 	adev->gmc.num_mem_partitions = num_ranges;
 
 	/* If there is only partition, don't use entire size */
-	if (adev->gmc.num_mem_partitions == 1)
-		mem_ranges[0].size =
-			(mem_ranges[0].size * (mem_groups - 1) / mem_groups);
+	if (adev->gmc.num_mem_partitions == 1) {
+		mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
+		do_div(mem_ranges[0].size, mem_groups);
+	}
 }
 
 static void
@@ -1953,8 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 		break;
 	}
 
-	size = (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) /
-	       adev->gmc.num_mem_partitions;
+	size = adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT;
+	size /= adev->gmc.num_mem_partitions;
 
 	for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
 		mem_ranges[i].range.fpfn = start_addr;
-- 
2.40.1

