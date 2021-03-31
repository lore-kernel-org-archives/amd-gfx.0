Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2040CC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 07:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41F8619AB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 07:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41F8619AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0256E9FC;
	Wed, 31 Mar 2021 07:17:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB84A6E9FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 07:17:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYnDpA+yy9cBotGLTGbHtsecLyiuXxJIywrvfJAElLej1jtMUkudWmk3LrN1FrSRCDapyqSm3Io4VZYULjDudcIerSd+zarRNEkK4RtHrn5vPrD2jBfaswkb7pbya7YFQNkKWDYbAmIVtyo4moimRr2+LU6G474B8qlMZV3BMSxr8h2pVC7mCnuvbkjgLGAxBDkIKCKZoxFhTVFV0ct9U9WQACL9YrttlJXlIRC2VMRAcf2M0eLbHBaV5k6VBjan/8VjiJArk5TD+MM9Bz2BzrivFB8wp7ETQgaEjt7vM0GXmopGKmwGsYJcSdLKOKzgR7VmPQKcfg6uL2o++J5sow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsxuOZeqgT8fSxHzaAFIfgLFxLorS0wzQzCY7s1PAWs=;
 b=iIAGLvrebAHWy8iCAgNxHaeNpF92+pHe8NA9e20qlxSZNk3mpb5eCUY+rySMcCNM/Pu7f7dT5Ny54on9VzzCHUwMNIvMNhVQYjCoGlUbovoK3zli30wgjRCWEOiIynyHroE6h3dhLaFa0LIrO6iYvT5h7zGejadN+lGNpjRO6oR+Iz18PLLek6WDJpz6wdcBfSn++eV4mZd5BW0pbTK9B7qx1e+wZQVgE8QRcWn3vmCXcAnGNXVkVVvrJRebQPHYFIWRUOC+ROlik592VvxVDfhOBdpdbw4ecWalOAoaFDuwp/TSaud8ejYQ1aNpvgfXzHK45RldiXgeSi0MdOroFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsxuOZeqgT8fSxHzaAFIfgLFxLorS0wzQzCY7s1PAWs=;
 b=292vH7YOQDkFxRJjR6Uai4xnxzykuvnWiNloyxcZ3KPM7DEDYOS9zhgyyT/zCnGnc/ALvIseXz8fhX6QpQZLwkU7rLVAVPRKG6DC5LItHvy9PxzviGp7X215XqcNSVj9MIQzRvxxaoe+aarzfmcKZ2v2jnlPA7g8DRGe9ygMQ68=
Received: from BN6PR22CA0040.namprd22.prod.outlook.com (2603:10b6:404:37::26)
 by CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 31 Mar
 2021 07:17:27 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::33) by BN6PR22CA0040.outlook.office365.com
 (2603:10b6:404:37::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Wed, 31 Mar 2021 07:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Wed, 31 Mar 2021 07:17:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 31 Mar
 2021 02:17:26 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Wed, 31 Mar 2021 02:17:25 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change mmhub register access from mmio to rlcg
Date: Wed, 31 Mar 2021 15:17:16 +0800
Message-ID: <20210331071716.11916-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e268e30-bbe4-453f-7073-08d8f4150a1f
X-MS-TrafficTypeDiagnostic: CO6PR12MB5492:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54923296EE5E15E03E3CF140F87C9@CO6PR12MB5492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKhI2O+QNJxKTxafdTTH6rLn0jdV2edsiww0mV3DMW8CJreZhuNsQMi76tQAPznF5Z/z6AIWbDkujMbQWp3qxnylP5xBwtALTF6yuzZp6TSu8uHEzH68i5q3kgBrtm1PThlSRHtyrhucySdwvnV/2e3Sp9S/O+hAXqZZiB8KqUHM5e1BSKOgeyUPjsE6fQIZldbhvlXh4enK8JGLm/YDkvg4+xmDuDlo/qwhb0BiuO2H57nvWpVEHcOL0SFJmXq/jmxGZYF9UI1ibtO4UIE67sfSm5AiPOBsrviJXelHJ5tQihQ9AR9afmqOGBzeioncH6rLbEwBn5ORR6cq9TDE3doA5L8FdjjoY0aapeb+GeHt9TtnOQq47avAvv318GuW1C5Cwr5Dikx0uVmUPSzLhPHWZNu06hSpgPOv6itT8vkC1ES9DCrqzcoIVQyRsfHAr+jXCGZzpaOCz5fYpYToowcmumBRdUEmzxLPsRmQ4QDRTFDlZS3ClFh/GMWBTdBIRoJVHkteNqgTwLRjpgfr7Uyzdso/VWQC2WXvBE3E3o+RH8wq32MVUkuVGOGMd6fWburbGEiHZiSm52FiwjEO8AtK4/VVf5u5tiEcZy/yJV9iAGl1hwz9x2vd+d/QJKk0ROtR2JIuUt9jGHGyCvZGxP4TX7kW2n7BZ3Os2geFIRsA2G4hrLMfEIacJA2tM/HL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(86362001)(82740400003)(83380400001)(5660300002)(54906003)(2616005)(356005)(81166007)(36756003)(36860700001)(7696005)(6916009)(70206006)(47076005)(6666004)(26005)(186003)(8936002)(8676002)(4326008)(336012)(478600001)(2906002)(19627235002)(316002)(426003)(82310400003)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 07:17:27.3798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e268e30-bbe4-453f-7073-08d8f4150a1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492
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
Cc: jianzh@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: pengzhou <PengJu.Zhou@amd.com>

change mmhub register access from mmio to rlcg if mmhub
indirect access enabled, otherwise access these registers in
the old path.

Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 12 ++++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 39 +++++++++++++------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 33e54eed2eec..7d0ce34dcc45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -38,6 +38,7 @@
 #include "soc15.h"
 #include "soc15d.h"
 #include "soc15_common.h"
+#include "gc/gc_10_1_0_offset.h"
 
 #include "nbio_v2_3.h"
 
@@ -253,7 +254,10 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+	if (vmhub == AMDGPU_MMHUB_0)
+		WREG32_RLC_NO_KIQ((hub->vm_inv_eng0_req + eng), inv_req);
+	else
+		WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to be cleared
@@ -280,8 +284,10 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
 		 */
-		WREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-			      hub->eng_distance * eng, 0);
+		if (vmhub == AMDGPU_MMHUB_0)
+			WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + eng, 0);
+		else
+			WREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng, 0);
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index f107385faba2..9dae6eb47053 100644
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
@@ -304,12 +305,12 @@ static void mmhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
 
-	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_CNTL);
+	tmp = RREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_CNTL);
 	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
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
