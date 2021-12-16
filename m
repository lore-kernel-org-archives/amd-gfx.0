Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD57C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 19:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7C810EDBC;
	Thu, 16 Dec 2021 19:43:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BB710EDB3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 19:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE851cO1hIXJXYXw1MpqMEEojVgo3MBhmOYCAPeKVDyL47Y3gJ5raTZ4A/NKt/ePsKCuFWkX49cKswdBBbdh1BoHa1VMLMTy7nKXv7HjAktWl+JaMQDEs/wlX805K3sTFuPNfyPapHHX1muE5tUmw5xf074RlOqoUWMp44jEBXOwgXjZC0G9eomOnKnrTzJJwmlar5zspz9muRragdboAJrSaMBo6LWU+0Xx0huXOyFfAanLMU7d8IkW88JxJ9frntwc4K8FrqJydWW+ZjvhMbsN5SLO72J7k6Ow9bk5l/xuJdhRHvtn2XgoRL9VXxnC8HjGkjLKaJqGBVpbbmdTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRYf436f9pynk3gCISroVgTcIAgQP5ag9Q6un//KsCU=;
 b=JHm+Ta2CuZ8X2y9X2zbHTDBQ6vHnLLtYOU2s2qR8bcHlnaAAfbX0K/UcdJDwk7CWXxy9eNyRyis2fabJKkih5DKOdkYGR3PGOv30+J+HcvNAn1aATLiT6ODfjEaXnpCm/imoTfpdXR8VR1sB6NKNz/9MkzRtrBZ9MU3MjKRmmtIzoEOPvNQicHU4+dgMdWHAeWZ2a9yW7/ljDLOVZ7AV1NBxJivpnBcuEfBnOHiWOOHcwl2pAbzSItLjSfMvuOzct9IynA4rte1G+8CogwxzpzSKtievKFhjT57egadtKb5DyQLNeWCkcqo8Fyn1S/Z5AK2TQGBuzwjKlIvPpITWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRYf436f9pynk3gCISroVgTcIAgQP5ag9Q6un//KsCU=;
 b=Jn97p6F53ztnaTOMVBqcJGF6ergp1LKXAJWQGhJCqbPzFsxxMoJ9RJzDapYXzyJKREe8eRneKZo38Q0rieQ0WyZyad3ve8UILsF/BtYsOuHZRLNS0TuzUdwpw5djnWJenEz6AIYalW9Egekt5PPTaaz48jFpSrOqSGSPp0fq4yo=
Received: from DM5PR21CA0051.namprd21.prod.outlook.com (2603:10b6:3:129::13)
 by BN6PR12MB1473.namprd12.prod.outlook.com (2603:10b6:405:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 19:42:58 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::1) by DM5PR21CA0051.outlook.office365.com
 (2603:10b6:3:129::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8 via Frontend
 Transport; Thu, 16 Dec 2021 19:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 19:42:58 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 13:42:57 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v3 5/5] drm/amdgpu: Modify indirect register access for gfx9
 sriov
Date: Thu, 16 Dec 2021 19:42:33 +0000
Message-ID: <20211216194233.3839-6-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216194233.3839-1-victor.skvortsov@amd.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5da0cb4-c598-4dd7-6888-08d9c0cc4381
X-MS-TrafficTypeDiagnostic: BN6PR12MB1473:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1473040F4DCEFC70A9DEB2B58B779@BN6PR12MB1473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Wu/wivGFUn/VS5pMObP7jj3PYLmYsny21JhCU7UDe67czofLjNVzKcvqiPyzT3bPkeNm6Fg/4AhsudENc/6XAsw/1Y8AFvlMWUIAvG1OE0I/A5ViEqJC0U8AkLViUhdAknXciyCon/2GGPYNmmgECJ1cIRiwPbCBtY58ypPSBqKBtp/jL212lRQh24XtORG0nDW5Ty013OfMZJQYcXaEPNO+l2FXzsdPs01pAZaAMvSVCfKERSgHX7kEwFiC8rs34c8INKS3w7Bbdr5EavM06Fk3d9+BeaDX3k9IHLJF8zrJrEpXvpeWc06znbSRWGP2uXpqj5rL/13teIuurgGIrJafutubG+5vVsmtLus1Tm4f//aL8YmFekin1kwHIrQliMH9afgKcVdYq68gj+eUKJN2iYHTcGeTGRIwtCSaHp8RG/E7N+973FKAjuFZkfRwt12qjUSdmnQ+4WMQw9YrM3yP6rFK0xYZl+RkhFiU0GOXDj3n5iAX4mGSwf/0BBO84mAPlOz0yUBmBAPKo+fYr7D8hlKNVdomYwD22oN7ay4Fov8G4UMO3aZWXzGTxyxybX9oyTP4PDwr+m/NhKT2uhFyrkGw0lW9vmCzjzJlgQmlQFmL898ldvD3j1g4msx/3rC0iimxYZ0WfBxSc2StdKlQM84MkI881FXW2JXaTbx2Y6LPsPk4NuqJUGaW9t925zVpDjeNs39nMKVm6Ch1hn2POQ6hfvxPpiCAgPqHIGxbxH+/L8jvNahAeGevdDTPXGhlOLrqk2BK9h3t9xU6/EP4+DdnUHSD4Ql/jhqftM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(47076005)(1076003)(110136005)(5660300002)(8676002)(8936002)(86362001)(83380400001)(6666004)(40460700001)(186003)(356005)(36756003)(2906002)(336012)(426003)(16526019)(316002)(6636002)(4326008)(26005)(508600001)(70206006)(81166007)(36860700001)(2616005)(82310400004)(70586007)(44832011)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 19:42:58.7114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5da0cb4-c598-4dd7-6888-08d9c0cc4381
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1473
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expand RLCG interface for new GC read & write commands.
New interface will only be used if the PF enables the flag in pf2vf msg.

v2: Added a description for the scratch registers

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 117 ++++++++++++++++++++------
 1 file changed, 89 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index edb3e3b08eed..9189fb85a4dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -63,6 +63,13 @@
 #define mmGCEA_PROBE_MAP                        0x070c
 #define mmGCEA_PROBE_MAP_BASE_IDX               0
 
+#define GFX9_RLCG_GC_WRITE_OLD			(0x8 << 28)
+#define GFX9_RLCG_GC_WRITE			(0x0 << 28)
+#define GFX9_RLCG_GC_READ			(0x1 << 28)
+#define GFX9_RLCG_VFGATE_DISABLED		0x4000000
+#define GFX9_RLCG_WRONG_OPERATION_TYPE		0x2000000
+#define GFX9_RLCG_NOT_IN_RANGE			0x1000000
+
 MODULE_FIRMWARE("amdgpu/vega10_ce.bin");
 MODULE_FIRMWARE("amdgpu/vega10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/vega10_me.bin");
@@ -739,7 +746,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
 	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };
 
-static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+static u32 gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32_t flag)
 {
 	static void *scratch_reg0;
 	static void *scratch_reg1;
@@ -748,21 +755,20 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	static void *spare_int;
 	static uint32_t grbm_cntl;
 	static uint32_t grbm_idx;
+	uint32_t i = 0;
+	uint32_t retries = 50000;
+	u32 ret = 0;
+	u32 tmp;
 
 	scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
 	scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
-	scratch_reg2 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;
-	scratch_reg3 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;
+	scratch_reg2 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG2_BASE_IDX] + mmSCRATCH_REG2)*4;
+	scratch_reg3 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG3_BASE_IDX] + mmSCRATCH_REG3)*4;
 	spare_int = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;
 
 	grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;
 	grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
 
-	if (amdgpu_sriov_runtime(adev)) {
-		pr_err("shouldn't call rlcg write register during runtime\n");
-		return;
-	}
-
 	if (offset == grbm_cntl || offset == grbm_idx) {
 		if (offset  == grbm_cntl)
 			writel(v, scratch_reg2);
@@ -771,41 +777,95 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 
 		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
 	} else {
-		uint32_t i = 0;
-		uint32_t retries = 50000;
-
+		/*
+		 * SCRATCH_REG0 	= read/write value
+		 * SCRATCH_REG1[30:28]	= command
+		 * SCRATCH_REG1[19:0]	= address in dword
+		 * SCRATCH_REG1[26:24]	= Error reporting
+		 */
 		writel(v, scratch_reg0);
-		writel(offset | 0x80000000, scratch_reg1);
+		writel(offset | flag, scratch_reg1);
 		writel(1, spare_int);
-		for (i = 0; i < retries; i++) {
-			u32 tmp;
 
+		for (i = 0; i < retries; i++) {
 			tmp = readl(scratch_reg1);
-			if (!(tmp & 0x80000000))
+			if (!(tmp & flag))
 				break;
 
 			udelay(10);
 		}
-		if (i >= retries)
-			pr_err("timeout: rlcg program reg:0x%05x failed !\n", offset);
+
+		if (i >= retries) {
+			if (amdgpu_sriov_reg_indirect_gc(adev)) {
+				if (tmp & GFX9_RLCG_VFGATE_DISABLED)
+					pr_err("The vfgate is disabled, program reg:0x%05x failed!\n", offset);
+				else if (tmp & GFX9_RLCG_WRONG_OPERATION_TYPE)
+					pr_err("Wrong operation type, program reg:0x%05x failed!\n", offset);
+				else if (tmp & GFX9_RLCG_NOT_IN_RANGE)
+					pr_err("The register is not in range, program reg:0x%05x failed!\n", offset);
+				else
+					pr_err("Unknown error type, program reg:0x%05x failed!\n", offset);
+			} else
+				pr_err("timeout: rlcg program reg:0x%05x failed!\n", offset);
+		}
 	}
 
+	ret = readl(scratch_reg0);
+
+	return ret;
+}
+
+static bool gfx_v9_0_get_rlcg_flag(struct amdgpu_device *adev, u32 acc_flags, u32 hwip,
+				int write, u32 *rlcg_flag)
+{
+
+	switch (hwip) {
+	case GC_HWIP:
+		if (amdgpu_sriov_reg_indirect_gc(adev)) {
+			*rlcg_flag = write ? GFX9_RLCG_GC_WRITE : GFX9_RLCG_GC_READ;
+
+			return true;
+		/* only in new version, AMDGPU_REGS_NO_KIQ and AMDGPU_REGS_RLC enabled simultaneously */
+		} else if ((acc_flags & AMDGPU_REGS_RLC) && !(acc_flags & AMDGPU_REGS_NO_KIQ) && write) {
+			*rlcg_flag = GFX9_RLCG_GC_WRITE_OLD;
+			return true;
+		}
+
+		break;
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static u32 gfx_v9_0_sriov_rreg(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip)
+{
+	u32 rlcg_flag;
+
+	if (!amdgpu_sriov_runtime(adev) && gfx_v9_0_get_rlcg_flag(adev, acc_flags, hwip, 0, &rlcg_flag))
+		return gfx_v9_0_rlcg_rw(adev, offset, 0, rlcg_flag);
+
+	if (acc_flags & AMDGPU_REGS_NO_KIQ)
+		return RREG32_NO_KIQ(offset);
+	else
+		return RREG32(offset);
 }
 
 static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offset,
-			       u32 v, u32 acc_flags, u32 hwip)
+			       u32 value, u32 acc_flags, u32 hwip)
 {
-	if ((acc_flags & AMDGPU_REGS_RLC) &&
-	    amdgpu_sriov_fullaccess(adev)) {
-		gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
+	u32 rlcg_flag;
 
+	if (!amdgpu_sriov_runtime(adev) && gfx_v9_0_get_rlcg_flag(adev, acc_flags, hwip, 1, &rlcg_flag)) {
+		gfx_v9_0_rlcg_rw(adev, offset, value, rlcg_flag);
 		return;
 	}
 
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
-		WREG32_NO_KIQ(offset, v);
+		WREG32_NO_KIQ(offset, value);
 	else
-		WREG32(offset, v);
+		WREG32(offset, value);
 }
 
 #define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042
@@ -5135,7 +5195,7 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
 	else
-		data = RREG32(reg);
+		data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
@@ -5191,6 +5251,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.start = gfx_v9_0_rlc_start,
 	.update_spm_vmid = gfx_v9_0_update_spm_vmid,
 	.sriov_wreg = gfx_v9_0_sriov_wreg,
+	.sriov_rreg = gfx_v9_0_sriov_rreg,
 	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
 };
 
@@ -5796,16 +5857,16 @@ static void gfx_v9_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_SOC15_IP(GC,mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
 		break;
 	default:
 		break;
-- 
2.25.1

