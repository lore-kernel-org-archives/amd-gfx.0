Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45680C77B62
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41E110EC42;
	Wed, 29 Mar 2023 20:14:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CB810EC3E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDlIVwzcn4fzLFG3pZiHH6/1WdT7yb23p9LsmtUE7bojxMk+yUiXNItESri1OssfBvmvHKtPSzAG++4gNNuht2ssMXaq5KAXzPU7GMJxO1s8ID5mIW1YAJIqElo34b0+EKse7zoEmwJb2VPVlkPvIyKa3bmq6xXm9Gc1YSG2MN20Lqjn/C8cNMtparWVUqzv8WYIC6+hFeHWKnHTvTT890tmRJniH6RnMYzp6Y/b8fNnTOEhDu0kuLOKkyMe+w8z7XJGHaDLh7AVDH0xS5mkvbW8m9QKj45LgNGSUlc05Gi4r5bpNqI6mzVuSwGgr5HP9Rfb6ft85TY8+CFDXpxaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywfAoxAyago9VxEMRHS3HxF4zhJxnOwr1Ps1YHehKgo=;
 b=aSJKCljGVnFx/Wc9c7EQ5KVHOGJYFWIh/AQAU0iAJAzYvvuZqf7nxCcQjR9yFl84LX6DF9uQvgMQo/dVbhae7/+BJBIuAk7o65nm1BH0deAYN2qKfTKlBY6w/LP7CYqu1XMnNNoGSVrF1FBbJ/VLjsaawSltztW6HC5NDTaw5cuWVNiXiONF70/TS81DbXtrExRIjTrpVZI0DPzxgHNo2Tm2l/5VuQocfgtqRQ4q9GOgqfnagUIlUy+A0eoTNP1vb3tgrtesfS554YdoG7Zv1UzAg+hossduJ9ecwmgWkiT/91SPOeVszKllPLEJTHKc/+7mDGDp/tDzapQHLya7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywfAoxAyago9VxEMRHS3HxF4zhJxnOwr1Ps1YHehKgo=;
 b=QTQluMPZuznBTiO6DNF6HCPsClGhkcx1DJz90p8dYa1m13brrISSPZyEb0jADLLYVcFQLxYefsXu3Sg5A92E8RAH3GqP5fPPqXPxi1USgT/br/9NrWiOQVIBZaf29KZUgI2kyhm04U9JgYtdwh43SZtDHVqluinRBK9xpP0Lkus=
Received: from MW2PR2101CA0034.namprd21.prod.outlook.com (2603:10b6:302:1::47)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:14:50 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::80) by MW2PR2101CA0034.outlook.office365.com
 (2603:10b6:302:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amdgpu: Fix SWS on multi-XCD GPU
Date: Wed, 29 Mar 2023 16:14:21 -0400
Message-ID: <20230329201426.1982669-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 1195025f-62da-4793-da6b-08db30924003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaDJ+XHTO/rDV0iILgGoaNNSGqyV3VwJxPkoytlrS9N1dl5AL1GxL8jvCywy58CzwtZ4Nfy+q5kj6KsAzWT1Rx6O0V7nc+g2fkFXrBOrDdGf59vZKx0BblkmyNhWkBhkvtgdqGLkYxoL8rIT7raA+bPOU3abCYIBACPoSv+i9kPoa1G/dBa0t4hmhWKL5ny62kWIQx6WZx+Qd//mjizRfPszxMDBLFiJoxBw+FVHB3yCeRovqbrn3nlSStRG3aIt2x87y4lpz9POB9bdNK0tk0NIQ/cQ1mHERibHL3yZrTG8in860a9sW6AfkuvVd3ZgAxwhg87HUssn8UADuuKft9kfX+6dPpwlMvpQiO+UYOWvvcd81WNpP8zGNzyIec382EdkeLRpra2SUwTP7z1yD1BUlPxh/uZw7Ntek7+b8jvpj7zdVc/K1c1VGGHSStpa6sFChT3Ak8EuwaGohb39HqaX/Ya9jZCkXyJDTWxTni/ggBUBqezjnozitKtv3uxRz96HIkusUIXjv5XsJ6Bsq1O00XbENRUBsjraL3CEGolDn+lxP2RvBdDeW7vde8YDLiJF57plwfUUbPPyS3sin9Tw3xisxp0qGBSFCjIT4OI3BG/2M0gPC5EYlWt2bODNzn7E/5GJIx5QvLsvdvf1P+uw6y/JlNqC0cXfy2QK0IFoiVtvLSQSK8jbE2dqV1kfSiizhPTajMBB8rpPMDulFi/v6gAAoj87zfdG7nUBajs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(336012)(83380400001)(2616005)(6916009)(426003)(47076005)(26005)(40480700001)(1076003)(82310400005)(16526019)(186003)(86362001)(356005)(81166007)(82740400003)(36860700001)(41300700001)(8936002)(70206006)(36756003)(5660300002)(478600001)(6666004)(7696005)(70586007)(4326008)(8676002)(54906003)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:49.9003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1195025f-62da-4793-da6b-08db30924003
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amber Lin <Amber.Lin@amd.com>

GFX_9_4_3 supports multi-XCDs and multi-AIDs in one GPU device. SWS needs
to program IH_VMID_x_LUT with specified XCC instance and corresponded
AID instance.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 772774615cb8..58adbf2262cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -21,14 +21,13 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
-#include "amdgpu_amdkfd_arcturus.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
 #include "gc/gc_9_4_3_offset.h"
 #include "gc/gc_9_4_3_sh_mask.h"
 #include "athub/athub_1_8_0_offset.h"
 #include "athub/athub_1_8_0_sh_mask.h"
-#include "oss/osssys_4_0_offset.h"
-#include "oss/osssys_4_0_sh_mask.h"
+#include "oss/osssys_4_4_2_offset.h"
+#include "oss/osssys_4_4_2_sh_mask.h"
 #include "v9_structs.h"
 #include "soc15.h"
 #include "sdma/sdma_4_4_2_offset.h"
@@ -220,9 +219,12 @@ int kgd_gfx_v9_4_3_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
 }
 
 static int kgd_gfx_v9_4_3_set_pasid_vmid_mapping(struct amdgpu_device *adev,
-				u32 pasid, unsigned int vmid, uint32_t inst)
+			u32 pasid, unsigned int vmid, uint32_t xcc_inst)
 {
 	unsigned long timeout;
+	unsigned int reg;
+	/* Every two XCCs share one AID */
+	unsigned int aid = xcc_inst / 2;
 
 	/*
 	 * We have to assume that there is no outstanding mapping.
@@ -234,11 +236,11 @@ static int kgd_gfx_v9_4_3_set_pasid_vmid_mapping(struct amdgpu_device *adev,
 	uint32_t pasid_mapping = (pasid == 0) ? 0 : (uint32_t)pasid |
 			ATC_VMID0_PASID_MAPPING__VALID_MASK;
 
-	WREG32(SOC15_REG_OFFSET(ATHUB, inst,
+	WREG32(SOC15_REG_OFFSET(ATHUB, 0,
 		regATC_VMID0_PASID_MAPPING) + vmid, pasid_mapping);
 
 	timeout = jiffies + msecs_to_jiffies(10);
-	while (!(RREG32(SOC15_REG_OFFSET(ATHUB, inst,
+	while (!(RREG32(SOC15_REG_OFFSET(ATHUB, 0,
 			regATC_VMID_PASID_MAPPING_UPDATE_STATUS)) &
 			(1U << vmid))) {
 		if (time_after(jiffies, timeout)) {
@@ -248,14 +250,25 @@ static int kgd_gfx_v9_4_3_set_pasid_vmid_mapping(struct amdgpu_device *adev,
 		cpu_relax();
 	}
 
-	WREG32(SOC15_REG_OFFSET(ATHUB, inst,
+	WREG32(SOC15_REG_OFFSET(ATHUB, 0,
 		regATC_VMID_PASID_MAPPING_UPDATE_STATUS),
 		1U << vmid);
 
-	WREG32(SOC15_REG_OFFSET(OSSSYS, inst, mmIH_VMID_0_LUT) + vmid,
+	reg = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_LUT_INDEX));
+	/* Every 4 numbers is a cycle. 1st is AID, 2nd and 3rd are XCDs,
+	 * and the 4th is reserved. Therefore "aid * 4 + (xcc_inst % 2) + 1"
+	 * programs _LUT for XCC and "aid * 4" for AID where the XCC connects
+	 * to.
+	 */
+	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_LUT_INDEX),
+		aid * 4 + (xcc_inst % 2) + 1);
+	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid,
 		pasid_mapping);
-	WREG32(SOC15_REG_OFFSET(OSSSYS, inst, mmIH_VMID_0_LUT_MM) + vmid,
+	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_LUT_INDEX),
+		aid * 4);
+	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT_MM) + vmid,
 		pasid_mapping);
+	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_LUT_INDEX), reg);
 
 	return 0;
 }
-- 
2.39.2

