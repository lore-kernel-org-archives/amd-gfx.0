Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDFEC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 07:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EBAE10E323;
	Fri, 22 Jul 2022 07:35:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E52310E323
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 07:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8G/CzvaqPLyRaltZs1uzXx9bi3ALfJTGsYUAt2hfMVsOVTsjCk9Sk/cNwK7y4Wg8IQuIqqFWaa1gljQW6Rbft5p55bzgoz5Cg98dPiUMfL3zN9s58+PYpGotnotof4H6/DRd11xRHdW2R77RxwzBZ0XwD5VGIEQcIhr+84QrEpJjNlcD1U71O8z5Yu5uRLrDfNLdJrAVInXyUHDsU7idrTSmzVpLPkP5tj0oaAiylXQRxOIcoRgGh/Gi1H2725qFnDcfCC76/DjoUbakEzD2YJx1Brm+ZBs30PjlofLmSlACmWuFmUTNThRxgB8nxCa3cOTttC5LwB2YgoCB7vpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0zDyVGqV3MroBNcYzPK6rzKFd00HixUdCgpbIqUfnI=;
 b=ICN2Xg8Ak9/iT5WSqZo1vT/7R7b8D+IZOSCyeDPn/A9oR8iH+3jekuK0f1swce0dxMbi/iQMgTME9THnGLKI2qER8ZNgD7+gN7bvNrZmOhHvaBLnJ2tXE8WNbWiKEZnaZbH4QGM4RV3Vwk1vZxcYtlgD05PIowWcKC+ZfeeuQXMOxL3KojiiHBuKLY7bsyBohPW7tBHio0yGSWE397vbMApf6K1J3nyNUu/qFIs5US+yqQdMFgUv2AD1sq5EKBdb7Jw/3sgHOodUrPc0KPdkgIy/IbjWGfdx+ke4jAAcyI/AV7jdaLB0mz9FbkE/jlHS1wFNDoAPFTFkvqLpNKck4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0zDyVGqV3MroBNcYzPK6rzKFd00HixUdCgpbIqUfnI=;
 b=UC3AZUdHcWqcllAafQ7GgRWx8P+wgQQ2cjBBaqMcXNCfU0LlGgIkW7P8j7vSoQDaqhfkgr8olvFgIn/M8lYE6L3SaZ3yabz3o1NxKMdhFTFREcBxRr2BcDVP8+cPfRl/nh4/C2Vpoy78X1cteQTRXDulu+TO3U/aO5H8qAeoj8w=
Received: from BN0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:e8::35)
 by DM6PR12MB4730.namprd12.prod.outlook.com (2603:10b6:5:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 07:35:05 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::12) by BN0PR04CA0060.outlook.office365.com
 (2603:10b6:408:e8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Fri, 22 Jul 2022 07:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 07:35:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 02:35:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 00:34:54 -0700
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 22 Jul 2022 02:34:52 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: save and restore gc hub regs
Date: Fri, 22 Jul 2022 15:34:01 +0800
Message-ID: <20220722073403.5171-3-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722073403.5171-1-Victor.Zhao@amd.com>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a2c3b4f-cf49-40fb-997c-08da6bb4b1f3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4730:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGzaEJMw7aKGPinL7WvJI7t8J6hKFHoJgskeA+Z1a1yQ3OG+pPSK9qWwL9BD6FqJdCO7ljoVLsXcKle4VPB9uVL0BAtE8XZYHy8HwASuaPwwKWPFLkTaAI6B7ee+RQiK3jVzsGuo/vBQQgiG0TKH0UKKpoSW5N7HYU1AuQAFXx/DY1sij0M3+KJkL3uheu6LbLS31ecpc7kGg19mhLBtGc8n8wNSZpjVqIkYDbL7K+OMYw3DUUc39wq2tUYKN+9/8jPmpjDixd/I7Cg5mX1gao5/fyGEbTXD+xgzmjAO4++KmRp030XYjd8qdN+hdDCW8dbUjxTFD96Boze1nUMlnywp+s8EIZdL/E5O9enXdu0sSttdI2F/4VIvVu1WRNpjMPgJPkB2Ljr0oUD/6hF8LsNCDyYrK0ukEBHNXSGTOxXhEyqznpXib699mbzZqyaCIctzz18E7lQ4BksW58ODsPa5q5OmKrrAr9Pmx4OWo76Syx3Asw26UZpX+L7RimRIYgLQkX6DqFHONFAGzjDjTdsHRQEAKabTUE6SBv+xUd+gxrfGE1Wsr2crdYndtuH6hhbSSDzr9KZqFGbFFjP8CdMYnx39DoQ8NNR1sKUO4Z4a7snRCsJZtCqtytUmtw5Y2nMDDtstA2eMcgXySYZXsXSZfcNVCtxXiTRgj5QP4jhMg2qCxZXRV5WDlbgK45N06TDX8JS4q6TlCCuwc5JGIyKoc3pO2HuYbkOG4fKSNFyiOKRVfvl3WugyXnvDRANDEzAmTwkz8PXtxPp48iCHhVCyWmAnHiwOEw1nXExX0VwUF00ToLkxLVgPxvCGfmV+oCjT+noPWbViOjHyrWrjGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(186003)(336012)(82740400003)(40460700003)(54906003)(316002)(47076005)(82310400005)(426003)(81166007)(6916009)(86362001)(70586007)(2616005)(4326008)(356005)(1076003)(478600001)(70206006)(8676002)(83380400001)(36860700001)(2906002)(26005)(6666004)(41300700001)(7696005)(30864003)(5660300002)(36756003)(40480700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 07:35:04.9538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2c3b4f-cf49-40fb-997c-08da6bb4b1f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4730
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
Cc: Alexander.Deucher@amd.com, emily.deng@amd.com,
 Victor Zhao <Victor.Zhao@amd.com>, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Save and restore gfxhub regs as they will be reset during mode 2

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       | 26 +++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      | 72 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  7 +-
 .../include/asic_reg/gc/gc_10_3_0_offset.h    |  4 ++
 5 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
index beabab515836..f8036f2b100e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
@@ -35,6 +35,8 @@ struct amdgpu_gfxhub_funcs {
 	void (*init)(struct amdgpu_device *adev);
 	int (*get_xgmi_info)(struct amdgpu_device *adev);
 	void (*utcl2_harvest)(struct amdgpu_device *adev);
+	void (*mode2_save_regs)(struct amdgpu_device *adev);
+	void (*mode2_restore_regs)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_gfxhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 008eaca27151..0305b660cd17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -264,6 +264,32 @@ struct amdgpu_gmc {
 	u64 mall_size;
 	/* number of UMC instances */
 	int num_umc;
+	/* mode2 save restore */
+	u64 VM_L2_CNTL;
+	u64 VM_L2_CNTL2;
+	u64 VM_DUMMY_PAGE_FAULT_CNTL;
+	u64 VM_DUMMY_PAGE_FAULT_ADDR_LO32;
+	u64 VM_DUMMY_PAGE_FAULT_ADDR_HI32;
+	u64 VM_L2_PROTECTION_FAULT_CNTL;
+	u64 VM_L2_PROTECTION_FAULT_CNTL2;
+	u64 VM_L2_PROTECTION_FAULT_MM_CNTL3;
+	u64 VM_L2_PROTECTION_FAULT_MM_CNTL4;
+	u64 VM_L2_PROTECTION_FAULT_ADDR_LO32;
+	u64 VM_L2_PROTECTION_FAULT_ADDR_HI32;
+	u64 VM_DEBUG;
+	u64 VM_L2_MM_GROUP_RT_CLASSES;
+	u64 VM_L2_BANK_SELECT_RESERVED_CID;
+	u64 VM_L2_BANK_SELECT_RESERVED_CID2;
+	u64 VM_L2_CACHE_PARITY_CNTL;
+	u64 VM_L2_IH_LOG_CNTL;
+	u64 VM_CONTEXT_CNTL[16];
+	u64 VM_CONTEXT_PAGE_TABLE_BASE_ADDR_LO32[16];
+	u64 VM_CONTEXT_PAGE_TABLE_BASE_ADDR_HI32[16];
+	u64 VM_CONTEXT_PAGE_TABLE_START_ADDR_LO32[16];
+	u64 VM_CONTEXT_PAGE_TABLE_START_ADDR_HI32[16];
+	u64 VM_CONTEXT_PAGE_TABLE_END_ADDR_LO32[16];
+	u64 VM_CONTEXT_PAGE_TABLE_END_ADDR_HI32[16];
+	u64 MC_VM_MX_L1_TLB_CNTL;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index d8c531581116..51cf8acd2d79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -576,6 +576,76 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
 	}
 }
 
+static void gfxhub_v2_1_save_regs(struct amdgpu_device *adev)
+{
+	int i;
+	adev->gmc.VM_L2_CNTL = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);
+	adev->gmc.VM_L2_CNTL2 = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2);
+	adev->gmc.VM_DUMMY_PAGE_FAULT_CNTL = RREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_CNTL);
+	adev->gmc.VM_DUMMY_PAGE_FAULT_ADDR_LO32 = RREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_ADDR_LO32);
+	adev->gmc.VM_DUMMY_PAGE_FAULT_ADDR_HI32 = RREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_ADDR_HI32);
+	adev->gmc.VM_L2_PROTECTION_FAULT_CNTL = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
+	adev->gmc.VM_L2_PROTECTION_FAULT_CNTL2 = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
+	adev->gmc.VM_L2_PROTECTION_FAULT_MM_CNTL3 = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_MM_CNTL3);
+	adev->gmc.VM_L2_PROTECTION_FAULT_MM_CNTL4 = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_MM_CNTL4);
+	adev->gmc.VM_L2_PROTECTION_FAULT_ADDR_LO32 = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_ADDR_LO32);
+	adev->gmc.VM_L2_PROTECTION_FAULT_ADDR_HI32 = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_ADDR_HI32);
+	adev->gmc.VM_DEBUG = RREG32_SOC15(GC, 0, mmGCVM_DEBUG);
+	adev->gmc.VM_L2_MM_GROUP_RT_CLASSES = RREG32_SOC15(GC, 0, mmGCVM_L2_MM_GROUP_RT_CLASSES);
+	adev->gmc.VM_L2_BANK_SELECT_RESERVED_CID = RREG32_SOC15(GC, 0, mmGCVM_L2_BANK_SELECT_RESERVED_CID);
+	adev->gmc.VM_L2_BANK_SELECT_RESERVED_CID2 = RREG32_SOC15(GC, 0, mmGCVM_L2_BANK_SELECT_RESERVED_CID2);
+	adev->gmc.VM_L2_CACHE_PARITY_CNTL = RREG32_SOC15(GC, 0, mmGCVM_L2_CACHE_PARITY_CNTL);
+	adev->gmc.VM_L2_IH_LOG_CNTL = RREG32_SOC15(GC, 0, mmGCVM_L2_IH_LOG_CNTL);
+
+	for (i = 0; i <= 15; i++) {
+		adev->gmc.VM_CONTEXT_CNTL[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_CNTL, i);
+		adev->gmc.VM_CONTEXT_PAGE_TABLE_BASE_ADDR_LO32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32, i * 2);
+		adev->gmc.VM_CONTEXT_PAGE_TABLE_BASE_ADDR_HI32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32, i * 2);
+		adev->gmc.VM_CONTEXT_PAGE_TABLE_START_ADDR_LO32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32, i * 2);
+		adev->gmc.VM_CONTEXT_PAGE_TABLE_START_ADDR_HI32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32, i * 2);
+		adev->gmc.VM_CONTEXT_PAGE_TABLE_END_ADDR_LO32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32, i * 2);
+		adev->gmc.VM_CONTEXT_PAGE_TABLE_END_ADDR_HI32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32, i * 2);
+	}
+
+	adev->gmc.MC_VM_MX_L1_TLB_CNTL = RREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
+}
+
+static void gfxhub_v2_1_restore_regs(struct amdgpu_device *adev)
+{
+	int i;
+	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL, adev->gmc.VM_L2_CNTL);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2, adev->gmc.VM_L2_CNTL2);
+	WREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_CNTL, adev->gmc.VM_DUMMY_PAGE_FAULT_CNTL);
+	WREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_ADDR_LO32, adev->gmc.VM_DUMMY_PAGE_FAULT_ADDR_LO32);
+	WREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_ADDR_HI32, adev->gmc.VM_DUMMY_PAGE_FAULT_ADDR_HI32);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, adev->gmc.VM_L2_PROTECTION_FAULT_CNTL);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, adev->gmc.VM_L2_PROTECTION_FAULT_CNTL2);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_MM_CNTL3, adev->gmc.VM_L2_PROTECTION_FAULT_MM_CNTL3);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_MM_CNTL4, adev->gmc.VM_L2_PROTECTION_FAULT_MM_CNTL4);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_ADDR_LO32, adev->gmc.VM_L2_PROTECTION_FAULT_ADDR_LO32);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_ADDR_HI32, adev->gmc.VM_L2_PROTECTION_FAULT_ADDR_HI32);
+	WREG32_SOC15(GC, 0, mmGCVM_DEBUG, adev->gmc.VM_DEBUG);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_MM_GROUP_RT_CLASSES, adev->gmc.VM_L2_MM_GROUP_RT_CLASSES);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_BANK_SELECT_RESERVED_CID, adev->gmc.VM_L2_BANK_SELECT_RESERVED_CID);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_BANK_SELECT_RESERVED_CID2, adev->gmc.VM_L2_BANK_SELECT_RESERVED_CID2);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_CACHE_PARITY_CNTL, adev->gmc.VM_L2_CACHE_PARITY_CNTL);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_IH_LOG_CNTL, adev->gmc.VM_L2_IH_LOG_CNTL);
+
+	for (i = 0; i <= 15; i++) {
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_CNTL, i, adev->gmc.VM_CONTEXT_CNTL[i]);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_BASE_ADDR_LO32[i]);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_BASE_ADDR_HI32[i]);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_START_ADDR_LO32[i]);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_START_ADDR_HI32[i]);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_END_ADDR_LO32[i]);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_END_ADDR_HI32[i]);
+	}
+
+	WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE, adev->gmc.vram_start >> 24);
+	WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_TOP, adev->gmc.vram_end >> 24);
+	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, adev->gmc.MC_VM_MX_L1_TLB_CNTL);
+}
+
 const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
 	.get_fb_location = gfxhub_v2_1_get_fb_location,
 	.get_mc_fb_offset = gfxhub_v2_1_get_mc_fb_offset,
@@ -586,4 +656,6 @@ const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
 	.init = gfxhub_v2_1_init,
 	.get_xgmi_info = gfxhub_v2_1_get_xgmi_info,
 	.utcl2_harvest = gfxhub_v2_1_utcl2_harvest,
+	.mode2_save_regs = gfxhub_v2_1_save_regs,
+	.mode2_restore_regs = gfxhub_v2_1_restore_regs,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 0512960bed23..51a5b68f77d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -94,8 +94,11 @@ sienna_cichlid_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
 	int r = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
 
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev)) {
+		if (adev->gfxhub.funcs->mode2_save_regs)
+			adev->gfxhub.funcs->mode2_save_regs(adev);
 		r = sienna_cichlid_mode2_suspend_ip(adev);
+	}
 
 	return r;
 }
@@ -152,6 +155,8 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 	}
 
 	/* Reinit GFXHUB */
+	if (adev->gfxhub.funcs->mode2_restore_regs)
+		adev->gfxhub.funcs->mode2_restore_regs(adev);
 	adev->gfxhub.funcs->init(adev);
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index f21554a1c86c..594bffce93a9 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -3129,6 +3129,8 @@
 #define mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32_BASE_IDX                                          0
 #define mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32                                                   0x15cc
 #define mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32_BASE_IDX                                          0
+#define mmGCVM_DEBUG                                                                                   0x15cd
+#define mmGCVM_DEBUG_BASE_IDX                                                                          0
 #define mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32                                             0x15ce
 #define mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32_BASE_IDX                                    0
 #define mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32                                             0x15cf
@@ -3151,6 +3153,8 @@
 #define mmGCVM_L2_BANK_SELECT_RESERVED_CID2_BASE_IDX                                                   0
 #define mmGCVM_L2_CACHE_PARITY_CNTL                                                                    0x15d8
 #define mmGCVM_L2_CACHE_PARITY_CNTL_BASE_IDX                                                           0
+#define mmGCVM_L2_IH_LOG_CNTL                                                                          0x15d9
+#define mmGCVM_L2_IH_LOG_CNTL_BASE_IDX                                                                 0
 #define mmGCVM_L2_CNTL5                                                                                0x15dc
 #define mmGCVM_L2_CNTL5_BASE_IDX                                                                       0
 #define mmGCVM_L2_GCR_CNTL                                                                             0x15dd
-- 
2.25.1

