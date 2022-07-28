Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51541C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 10:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E88D098C33;
	Thu, 28 Jul 2022 10:31:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AB318B671
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 10:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Flb3cyQHd4a2bGR3mkt65oJyxQtXLrJYqDJsCFxt0EF02qipnlDRvmPE726UgbjXsfa6C4+TnYpT0cstdRvj1/uSndvDWvmFVkoUj1VQo3GW7zXj5Gh6noQmIzy7vJHME98EG3pFmwMVvUe0SkrM9BEPBupVb3LX1PpyvQS1EF2pnvvePN9dYn4q+gBLYBYjM0XXrEbwnDpknGHxFwuURF7FFyrrQgXD8OpKoquOpFw7hAVWJqCqGfzwLl9qRCgYGn6bnQBv5iD/aBMAi2K+O6L0tEcAfNM+CcqHhR7Z08Jfp+SAjsmEqtRzvdJND6rT+6dMRuV3pCRcIkE9Yoiwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0zDyVGqV3MroBNcYzPK6rzKFd00HixUdCgpbIqUfnI=;
 b=SXp7+qdx8iVb2D12FAzdAgN45bbKamfrOIRYN1qnm6OetqNtVXd9lNPKG4PY6P10IKwHqk7uhbObHZrzVLuS6Fuet7rFuFYllg8RZ24NzMvwgxsAx5GFCc72c2r3HQLDgK/p5Kohwo6e0YM6Zth1rfLRgxPaKQbqAzvWOmVAzx3yh9O/9RrblzY+ErPAUVi3kp4nqJkvPExHH+39H4M2DVzNKCta9Wh7/HzdymXVnYb0RKxDaNVixX6/bwb8/IAYzvHfIO8IioAvj4KPCGLUYjPpPK7/drx4VDZYv5sscEqyXSrXt79BAF8YnPF9Wt6zx98A2Eni5/Y1a9zNOR/jXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0zDyVGqV3MroBNcYzPK6rzKFd00HixUdCgpbIqUfnI=;
 b=4K1zIoAYwcPdda3YGGTedzXxPO8YDPogv6cDdfpvCFAFZ2yptqe4vzTO1Yx5kxwUWRrA1dN7uygh8BFH8uyjVTgmnS6p6hqB709TExxtcBL/TzR7JmEJ//OB777fLdCWpj4kjZqT4oQfNPKTMo3ISiKbEk7L41FKqJFGr/9cCeY=
Received: from DM5PR06CA0075.namprd06.prod.outlook.com (2603:10b6:3:4::13) by
 DM5PR1201MB2552.namprd12.prod.outlook.com (2603:10b6:3:e3::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Thu, 28 Jul 2022 10:30:44 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::51) by DM5PR06CA0075.outlook.office365.com
 (2603:10b6:3:4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20 via Frontend
 Transport; Thu, 28 Jul 2022 10:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 10:30:44 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 05:30:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 03:30:43 -0700
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 28 Jul 2022 05:30:42 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/6] drm/amdgpu: save and restore gc hub regs
Date: Thu, 28 Jul 2022 18:30:25 +0800
Message-ID: <20220728103027.27255-4-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728103027.27255-1-Victor.Zhao@amd.com>
References: <20220728103027.27255-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15b2f8b3-d5f8-4d0a-b7dd-08da70843a48
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2552:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2GfWnmuFVcPJDIkxZmwZG1WB7eke3guGOXD3nCbnSxvfVNm+CNdFH0htUBTHsrK+Kw8occIK33ZjWMaBUuzjgQM0BrQ++k/wMWzI+cNtPyOHjaT9i3l2oWIhyEjiQr3lkP5iKSGk92Mbot+FBae5m80Dv3ze1oAzRyI/LdNbVpwwDYY36EsV3wDgV2NJbZMsIv6m2jwzjeV4p1Gb9OIu1kHpFNIQWwN0KAZGMM3uxBGhCV9BSroAgW4gEGZMAxyHkxD47GbJUP7evcz3r2qs7hZ9ZoOu9nvdd18j0wsDqwiT9owtnnd6EdRir7usUwZAlMHYsrJ1yzaSQ7HqX4Fe/Def2qb6fnxJ1B7kX81K3wESHcH59qBDlctwEfpkBy354UJl34GcpYe+iYIOK6gT0Fmwi4gt/7YsKDSSXO9zgG5d/zLhr2EWo9r7X+JTGwjEDaLIJ0Patkat8y/AvdaRorEk1STy7yH4TElsPs7jQcgSAcPOxjkf+pNbdWA7nn/l5VXXaba2nQ4FsHBHFxtnaphDQ19RtkyCcA+N8yJe6fA6xXWA/6tG+KZVhlra8A0t/jGXpc6ubSCslLhPH9bXuquUVTiv1l9JKXFWyqiXOAYQcT2QPdfDbpAP1tBpY51atoOgHYR9JQjg6rFGguzZZxGT5lonfJfQ1OkGc9Z1lgn398iQyAzcuccq/7ZdbCnn/ycbLmKSuaNWaYKLocs4eJWLr+SY5V+LgIjfFiMg74blrkSlFEZ8XHHFc5Ta9QstW9Vz13HSv/kiqy8AjExXdF7nh2qtC81HSLHPEHvRnQWBj54K2wYFELMvr9eimzAHUuOYrhu/mD0LkUxAysXVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(40470700004)(36840700001)(46966006)(26005)(5660300002)(7696005)(2906002)(426003)(47076005)(30864003)(86362001)(41300700001)(40460700003)(2616005)(8936002)(83380400001)(70586007)(478600001)(1076003)(336012)(4326008)(186003)(82310400005)(82740400003)(81166007)(356005)(6666004)(54906003)(6916009)(40480700001)(8676002)(36756003)(70206006)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 10:30:44.1247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b2f8b3-d5f8-4d0a-b7dd-08da70843a48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2552
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>,
 Andrey.Grodzovsky@amd.com
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

