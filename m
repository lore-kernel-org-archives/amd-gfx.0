Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495DEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 11:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC3510E609;
	Thu, 20 Jan 2022 11:19:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B667910E62A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu8OFIqofMlzL0193yQqNstGEMxQELetg3t0qaN08+v5ngB8Eq1TynAenCP4NlgdHSruAPlcQH/OstVx4bLWFZLaAHA+Wmp8ndb1OpmmgUNY43Gj6V0hnBdcJ+ZzbqGXabkLgS/CHjyOUAKeTgtv9xhJJps0L0UyoJ1d/AcdHeJxJOrEtu63mPya5DmuWN1910RZ0r6WZVNT+mId5HBipN5Iy1XwQ5W8vfIEXjkiyhL3ThvkEmN9z3JAZE64WQ4wJ8t7cmIq2RLesOwUMtWlEBktXiiNyUBRoZhMUowgVbWSnOtd0vJqSlkSWAAI5YOstt7U9ZSAo3t+b8kZeATX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9ZntfFTZ96VnbwnaIn85YT3MFlhCBER5l36naAWcqc=;
 b=WIf2XyjPSY+Y7uzgUS2SsDI+SWu7tj+bGwEnemp0PQ3X9wkR8DBdwZNBtTvIbhBiYW0SRXvO4Opv8YA6+sOC+nbsMjGqgktLPPbW41UP9+unGhEPHCmuLRV99Onr1BAYCXd6erJab5KRJi3M7Jfhtlb0dFGk74VjpxQgtMYWz1NO3NXEhQo2zF36yIANBXIMFOXP1w3HwY0VlDesQmfM//4Svo9YbFZ1TPLCtsVpDYivHNc1wAJLNRVVkOmMMwHxyISAXi93zCy18ed1ODm4dfFKCNUMkgQtOjFXnZdy5bEKxNri6zuPK3VhNRwS6q+nRZdu31LHIgNnnNZtOe/jIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9ZntfFTZ96VnbwnaIn85YT3MFlhCBER5l36naAWcqc=;
 b=xJp2+vW2ZYx/K9UcNjgZVgljsrMxExswAd+wzT0IVPVQVqt2X+XLfNstI6kVqPB8wWaWFf86X+TmEoQgXs7Kvi/J+r2MKImiN7tQn+5prw23EvTA+I4+vQTqesFgZz8A1ENQinonHIJq7fnWXGd/03fk6mLpG589Rmlq/AbatXI=
Received: from MWHPR17CA0061.namprd17.prod.outlook.com (2603:10b6:300:93::23)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 11:19:18 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::21) by MWHPR17CA0061.outlook.office365.com
 (2603:10b6:300:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Thu, 20 Jan 2022 11:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 11:19:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:16 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.18 via Frontend Transport; Thu, 20 Jan 2022 05:19:15
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: retire rlc callbacks sriov_rreg/wreg
Date: Thu, 20 Jan 2022 19:18:53 +0800
Message-ID: <20220120111853.11674-9-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120111853.11674-1-Hawking.Zhang@amd.com>
References: <20220120111853.11674-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dfe4567-4331-458b-e1d7-08d9dc06b2c8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4406:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB440610F126E5A7EED3145F66FC5A9@MN2PR12MB4406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jw+2USxSTOO6O5FxawDfh6gxxEbKEXn3vY6rKyXE/Yi2CFSq8anFZMs3zawqYupCN7qcz/HTHfV/UmoQlPQvDfnjpVD+JmymP3aGHCqvbNUKwQpLgNrkUcgJvGiSD3EB+6jPuwyY6pHd6V0iiwPQzta1PvffmujLZrdg3+xnC49n98GzutxHSHnpJLsS6bVmMLCLS+KGvWDpK95Z7LY9zgXrU2WnsA5jqXlUjLycIGU1RZZ9KARhUz+S5QFOD0TLOEP+nPZtDzdj0gS5tfZcx4/j9CoEZyBU+tZVAdtJX8q8HPU+xjN75T7W/8hkOYNX5cfBUXz6iCd83NhL+yYnGhZGdxs4h0bEgAyy/z/undWxOR3qBzWi477Sffp1U2E6z2b7De2sk0Pb6oDu5Huaia9KmJRkvnYYVjdTtA23Oq3yaNJilmNzMvXAlVijvxY/0Ep+gRgeYUsJYb/FjH2nN6aTmDZTtNmrFTDvYb2ljRzRLZ0Io1x669pRTw9AwMcoqVYlVeienYqkntX/Mshrvd3hIrPovoNVhBJoN5iJCnZ3oQ3GsuffQCEtsfnuTgwg1LNgZ5SQx5Ofcd+nbbrVF3PyySGHCBtjgEakcJqCEj7aQ7plM+MEdocxaunCpncwpdAERm7duZogjXip7W801oEU9x3JVSYF+SkA18re2dU7H5/bRhWxPvhHReRfwTmRCxLo0XI9t1HPI6naDEbKD860Ueq82q/Vu1REQAF13JrBDwLOd6HL9JkB5vVCI6RHcFpfhWrrr2EnOkuuJqcZiUhYLM22kTULa+UNWlvbhqs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(186003)(2616005)(19627235002)(356005)(1076003)(6636002)(47076005)(36756003)(81166007)(336012)(70206006)(36860700001)(86362001)(70586007)(5660300002)(82310400004)(7696005)(426003)(8936002)(66574015)(8676002)(26005)(30864003)(4326008)(40460700001)(316002)(508600001)(6666004)(2906002)(83380400001)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 11:19:17.5341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfe4567-4331-458b-e1d7-08d9dc06b2c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not needed anymore.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h  |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |   2 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 114 -----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 106 ---------------------
 5 files changed, 3 insertions(+), 226 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 286b2347d063..3f671a62b009 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,8 +127,6 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
-	void (*sriov_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
-	u32 (*sriov_rreg)(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 8c27d31f3e53..80c25176c993 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -821,8 +821,9 @@ void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 	}
 }
 
-bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev, u32 acc_flags,
-					  u32 hwip, bool write, u32 *rlcg_flag)
+static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
+						 u32 acc_flags, u32 hwip,
+						 bool write, u32 *rlcg_flag)
 {
 	bool ret = false;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index dbfa3ba445c3..c5edd84c1c12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -334,8 +334,6 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 			struct amdgpu_video_codec_info *encode, uint32_t encode_array_size,
 			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size);
-bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev, u32 acc_flags,
-					  u32 hwip, bool write, u32 *rlcg_flag);
 void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 		       u32 offset, u32 value,
 		       u32 acc_flags, u32 hwip);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3fb484214d3a..f54e106e2b86 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -56,10 +56,6 @@
 #define GFX10_NUM_GFX_RINGS_Sienna_Cichlid	1
 #define GFX10_MEC_HPD_SIZE	2048
 
-#define RLCG_VFGATE_DISABLED	0x4000000
-#define RLCG_WRONG_OPERATION_TYPE	0x2000000
-#define RLCG_NOT_IN_RANGE	0x1000000
-
 #define F32_CE_PROGRAM_RAM_SIZE		65536
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 
@@ -180,9 +176,6 @@
 #define mmRLC_SPARE_INT_0_Sienna_Cichlid               0x4ca5
 #define mmRLC_SPARE_INT_0_Sienna_Cichlid_BASE_IDX      1
 
-#define RLCG_ERROR_REPORT_ENABLED(adev) \
-	(amdgpu_sriov_reg_indirect_mmhub(adev) || amdgpu_sriov_reg_indirect_gc(adev))
-
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -1458,111 +1451,6 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00c00000)
 };
 
-static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32_t flag)
-{
-	static void *scratch_reg0;
-	static void *scratch_reg1;
-	static void *scratch_reg2;
-	static void *scratch_reg3;
-	static void *spare_int;
-	static uint32_t grbm_cntl;
-	static uint32_t grbm_idx;
-	uint32_t i = 0;
-	uint32_t retries = 50000;
-	u32 ret = 0;
-	u32 tmp;
-
-	scratch_reg0 = adev->rmmio +
-		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0) * 4;
-	scratch_reg1 = adev->rmmio +
-		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1) * 4;
-	scratch_reg2 = adev->rmmio +
-		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG2) * 4;
-	scratch_reg3 = adev->rmmio +
-		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3) * 4;
-
-	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0)) {
-		spare_int = adev->rmmio +
-			    (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_0_Sienna_Cichlid_BASE_IDX]
-			     + mmRLC_SPARE_INT_0_Sienna_Cichlid) * 4;
-	} else {
-		spare_int = adev->rmmio +
-			    (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT) * 4;
-	}
-
-	grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;
-	grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
-
-	if (offset == grbm_cntl || offset == grbm_idx) {
-		if (offset  == grbm_cntl)
-			writel(v, scratch_reg2);
-		else if (offset == grbm_idx)
-			writel(v, scratch_reg3);
-
-		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
-	} else {
-		writel(v, scratch_reg0);
-		writel(offset | flag, scratch_reg1);
-		writel(1, spare_int);
-
-		for (i = 0; i < retries; i++) {
-			tmp = readl(scratch_reg1);
-			if (!(tmp & flag))
-				break;
-
-			udelay(10);
-		}
-
-		if (i >= retries) {
-			if (RLCG_ERROR_REPORT_ENABLED(adev)) {
-				if (tmp & RLCG_VFGATE_DISABLED)
-					pr_err("The vfgate is disabled, program reg:0x%05x failed!\n", offset);
-				else if (tmp & RLCG_WRONG_OPERATION_TYPE)
-					pr_err("Wrong operation type, program reg:0x%05x failed!\n", offset);
-				else if (tmp & RLCG_NOT_IN_RANGE)
-					pr_err("The register is not in range, program reg:0x%05x failed!\n", offset);
-				else
-					pr_err("Unknown error type, program reg:0x%05x failed!\n", offset);
-			} else
-				pr_err("timeout: rlcg program reg:0x%05x failed!\n", offset);
-		}
-	}
-
-	ret = readl(scratch_reg0);
-
-	return ret;
-}
-
-static void gfx_v10_sriov_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 acc_flags, u32 hwip)
-{
-	u32 rlcg_flag;
-
-	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
-		gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
-		return;
-	}
-
-	if (acc_flags & AMDGPU_REGS_NO_KIQ)
-		WREG32_NO_KIQ(offset, value);
-	else
-		WREG32(offset, value);
-}
-
-static u32 gfx_v10_sriov_rreg(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip)
-{
-	u32 rlcg_flag;
-
-	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
-		return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
-
-	if (acc_flags & AMDGPU_REGS_NO_KIQ)
-		return RREG32_NO_KIQ(offset);
-	else
-		return RREG32(offset);
-}
-
 static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] =
 {
 	/* Pending on emulation bring up */
@@ -8370,8 +8258,6 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
 	.reset = gfx_v10_0_rlc_reset,
 	.start = gfx_v10_0_rlc_start,
 	.update_spm_vmid = gfx_v10_0_update_spm_vmid,
-	.sriov_wreg = gfx_v10_sriov_wreg,
-	.sriov_rreg = gfx_v10_sriov_rreg,
 	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c7bccf1a28b4..ca7b886c6ce6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -63,10 +63,6 @@
 #define mmGCEA_PROBE_MAP                        0x070c
 #define mmGCEA_PROBE_MAP_BASE_IDX               0
 
-#define GFX9_RLCG_VFGATE_DISABLED		0x4000000
-#define GFX9_RLCG_WRONG_OPERATION_TYPE		0x2000000
-#define GFX9_RLCG_NOT_IN_RANGE			0x1000000
-
 MODULE_FIRMWARE("amdgpu/vega10_ce.bin");
 MODULE_FIRMWARE("amdgpu/vega10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/vega10_me.bin");
@@ -743,106 +739,6 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
 	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };
 
-static u32 gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32_t flag)
-{
-	static void *scratch_reg0;
-	static void *scratch_reg1;
-	static void *scratch_reg2;
-	static void *scratch_reg3;
-	static void *spare_int;
-	static uint32_t grbm_cntl;
-	static uint32_t grbm_idx;
-	uint32_t i = 0;
-	uint32_t retries = 50000;
-	u32 ret = 0;
-	u32 tmp;
-
-	scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
-	scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
-	scratch_reg2 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG2_BASE_IDX] + mmSCRATCH_REG2)*4;
-	scratch_reg3 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG3_BASE_IDX] + mmSCRATCH_REG3)*4;
-	spare_int = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;
-
-	grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;
-	grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
-
-	if (offset == grbm_cntl || offset == grbm_idx) {
-		if (offset  == grbm_cntl)
-			writel(v, scratch_reg2);
-		else if (offset == grbm_idx)
-			writel(v, scratch_reg3);
-
-		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
-	} else {
-		/*
-		 * SCRATCH_REG0 	= read/write value
-		 * SCRATCH_REG1[30:28]	= command
-		 * SCRATCH_REG1[19:0]	= address in dword
-		 * SCRATCH_REG1[26:24]	= Error reporting
-		 */
-		writel(v, scratch_reg0);
-		writel(offset | flag, scratch_reg1);
-		writel(1, spare_int);
-
-		for (i = 0; i < retries; i++) {
-			tmp = readl(scratch_reg1);
-			if (!(tmp & flag))
-				break;
-
-			udelay(10);
-		}
-
-		if (i >= retries) {
-			if (amdgpu_sriov_reg_indirect_gc(adev)) {
-				if (tmp & GFX9_RLCG_VFGATE_DISABLED)
-					pr_err("The vfgate is disabled, program reg:0x%05x failed!\n", offset);
-				else if (tmp & GFX9_RLCG_WRONG_OPERATION_TYPE)
-					pr_err("Wrong operation type, program reg:0x%05x failed!\n", offset);
-				else if (tmp & GFX9_RLCG_NOT_IN_RANGE)
-					pr_err("The register is not in range, program reg:0x%05x failed!\n", offset);
-				else
-					pr_err("Unknown error type, program reg:0x%05x failed!\n", offset);
-			} else
-				pr_err("timeout: rlcg program reg:0x%05x failed!\n", offset);
-		}
-	}
-
-	ret = readl(scratch_reg0);
-
-	return ret;
-}
-
-static u32 gfx_v9_0_sriov_rreg(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip)
-{
-	u32 rlcg_flag;
-
-	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
-		return gfx_v9_0_rlcg_rw(adev, offset, 0, rlcg_flag);
-
-	if (acc_flags & AMDGPU_REGS_NO_KIQ)
-		return RREG32_NO_KIQ(offset);
-	else
-		return RREG32(offset);
-}
-
-static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offset,
-			       u32 value, u32 acc_flags, u32 hwip)
-{
-	u32 rlcg_flag;
-
-	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
-		gfx_v9_0_rlcg_rw(adev, offset, value, rlcg_flag);
-		return;
-	}
-
-	if (acc_flags & AMDGPU_REGS_NO_KIQ)
-		WREG32_NO_KIQ(offset, value);
-	else
-		WREG32(offset, value);
-}
-
 #define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042
 #define VEGA12_GB_ADDR_CONFIG_GOLDEN 0x24104041
 #define RAVEN_GB_ADDR_CONFIG_GOLDEN 0x24000042
@@ -5268,8 +5164,6 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.reset = gfx_v9_0_rlc_reset,
 	.start = gfx_v9_0_rlc_start,
 	.update_spm_vmid = gfx_v9_0_update_spm_vmid,
-	.sriov_wreg = gfx_v9_0_sriov_wreg,
-	.sriov_rreg = gfx_v9_0_sriov_rreg,
 	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
 };
 
-- 
2.17.1

