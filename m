Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E53C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB10661418
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB10661418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC6F6EDA2;
	Thu, 29 Apr 2021 08:14:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A5B6EDA4
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxGYJTzJoanEbd0xchZEq7CrrZE4ne9jYT697rmvQoJ6Bt/ei2WeGy0HMzzS2EKuOdwpjDSOSKa/WiDyz+nLwqEQTIE3zTKa+4U7urpT4i0MovwFuHTWpvJqGDigqxT+BUOgCN2xOSB5XBnLwAuxKVj+sW/sllSBvdnd+hUu5soXToFl1Rx/pKZbI6Tm88irtItgu76ZbjO/h+CHIbyVdARYRVdPVEI5FWhQ5myo1yHIkyTFWt00zYcZvIXT0E9LhTwfov4EBP4/2JkiKl6eBBNRwjuGi5v44oo44LvkQmhPUO17CfmeREWBDEWFpCvpeaR86z3zEfrCUanu99WhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btL/3RSqoDVyw4HzY6kfvXa7/uijuSu/GgMhO/RlFoI=;
 b=YBSJgeMObaVJwLMnLEiyYx+Ar410nxFyibaljx3rJ2uAKKqC9qbQ8agzr3Gp+KuYm2DRRpNO1eKuBUv61zvAwYiTdyJVMWCxBto2is8MnMScfMBBgDQG45etlDonlT8yGgY9Vp82i25zWA7c5cUKZulqKABdqQ2pMfVcW5wYWMA6KxKMFSvtvCFZ4LYn8ea6k1Fc5WtwVS+FZn0iw9RXdgxL6lXeFQcAFkXIq0KdrPPreIwxi4vFC9x7x+dkfw6frLwgRbnKkfWSwuHHvLOY6+IfH133e2UK+PWQ/bLfwLiCG1oe7JU4Bxkc+/qyzNuCf5480+04Af0xiNXaUSbxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btL/3RSqoDVyw4HzY6kfvXa7/uijuSu/GgMhO/RlFoI=;
 b=MHa/AP2IpHhK7qdwNU0Y4w6mnCneuMXJ1psi79Hs4G+7+K0uDtiQpyfGQhg0v+covZ2iOp09qO0GkgfY6Ofo+BvIqzdnShdkhS/q8I+/oPPxLbPTZI4fDvHgqRPW4pVoFuXprWpHWRRsR1ZwA73R2VXZM4wYd5sDwTLBPcFFDnE=
Received: from DM6PR06CA0065.namprd06.prod.outlook.com (2603:10b6:5:54::42) by
 CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Thu, 29 Apr 2021 08:14:14 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::ef) by DM6PR06CA0065.outlook.office365.com
 (2603:10b6:5:54::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 08:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 08:14:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:13 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:14:12 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amdgpu: Modify MMHUB register access from MMIO to
 RLCG in file mmhub_v2*
Date: Thu, 29 Apr 2021 16:13:41 +0800
Message-ID: <20210429081345.24217-8-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081345.24217-1-PengJu.Zhou@amd.com>
References: <20210429081345.24217-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f76cb6-f785-4657-76b1-08d90ae6c6b5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4039:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40395041B39000E1D1361CBEF85F9@CH2PR12MB4039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HDcRYLHAT1AesCeBKNc3aOl1tdoULUPtNPKa0xr+jGLYJk6RsGS3WfBXU0rcqEY/HFsvuabJnY42mwvQ+tghgFiEbROw0rYPRF7lbhuqOkk5SZ1c2vjJi4dIpgXf6QqJXfqUIPwKXQXNsDsOyOVio2ahWZ3koC6HN+etwGUZ25EPznT555v7niNd2yfOCQf+rbSWH8kCOpXeBk0ErpQSQ2voqjesDp/15tLhqMi6+OH9nj0HvceHNMprXnO8oT2L04C97nYWk4XPsno8EG2SihhAcIEdhe/kn8+TEdI5bfZkqjfZ78mqM6uPco5dUwjOqEIJe/HdP1GUhTqNp4e94SfypDjD5oAqe9z4R6WB3Y4exdAkvBPB1NMxuAceANAH+pvOYmyGa6lExBDhj1pupeXESNOls3fTGxvZyZYSvBLZH1xst0CNDg5m0Up4RiMTJrwtt/3eKUrGvL/sgnYSyW/CY1Lft75OjEWzXH/OtD99XnkPlnlz+VV16xP7yy7lNVI2KH3fcNZYFsadvuqGUsy9QpCd//i3WIMbXEvBHV3gdQRfHeO7aoKuzQ/Mf6ApEmYcxzLTbmBvuIPhhd8FZM2xLHJk5/Qah/J7g/7DiAMKwY+VEwvJRNBPLl/2N7G3fAh50K2FFhG51V/An2pKqA1TXaIRX5tRFCfL+EJN9xJbT2gt4I2dNmwCxRIC9Nlg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(19627235002)(6666004)(186003)(316002)(1076003)(83380400001)(2616005)(478600001)(26005)(5660300002)(70586007)(6916009)(36756003)(8676002)(70206006)(82310400003)(86362001)(426003)(356005)(8936002)(81166007)(47076005)(82740400003)(336012)(4326008)(2906002)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:14:14.1133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f76cb6-f785-4657-76b1-08d90ae6c6b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: pengzhou <PengJu.Zhou@amd.com>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 37 +++++++++++++------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index da7edd1ed6b2..630334bc3a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -29,6 +29,7 @@
 #include "mmhub/mmhub_2_0_0_default.h"
 #include "navi10_enum.h"
 
+#include "gc/gc_10_1_0_offset.h"
 #include "soc15_common.h"
 
 #define mmMM_ATC_L2_MISC_CG_Sienna_Cichlid                      0x064d
@@ -165,11 +166,11 @@ static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 
-	WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+	WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
 			    lower_32_bits(page_table_base));
 
-	WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+	WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
 			    hub->ctx_addr_distance * vmid,
 			    upper_32_bits(page_table_base));
 }
@@ -180,14 +181,14 @@ static void mmhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 
 	mmhub_v2_0_setup_vm_pt_regs(adev, 0, pt_base);
 
-	WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 		     (u32)(adev->gmc.gart_start >> 12));
-	WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
 		     (u32)(adev->gmc.gart_start >> 44));
 
-	WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
 		     (u32)(adev->gmc.gart_end >> 12));
-	WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
 		     (u32)(adev->gmc.gart_end >> 44));
 }
 
@@ -197,9 +198,9 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	/* Program the AGP BAR */
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/* Program the system aperture low logical page number. */
@@ -309,7 +310,7 @@ static void mmhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
 	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
 			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
-	WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_CNTL, tmp);
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_CNTL, tmp);
 }
 
 static void mmhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
@@ -371,16 +372,16 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !adev->gmc.noretry);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
 				    i * hub->ctx_addr_distance, 0);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
 				    i * hub->ctx_addr_distance, 0);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
 				    i * hub->ctx_addr_distance,
 				    lower_32_bits(adev->vm_manager.max_pfn - 1));
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
@@ -392,9 +393,9 @@ static void mmhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
 				    i * hub->eng_addr_distance, 0xffffffff);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
 				    i * hub->eng_addr_distance, 0x1f);
 	}
 }
@@ -423,7 +424,7 @@ static void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
 
 	/* Disable all tables */
 	for (i = 0; i < AMDGPU_NUM_VMID; i++)
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_CNTL,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT0_CNTL,
 				    i * hub->ctx_distance, 0);
 
 	/* Setup TLB control */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
