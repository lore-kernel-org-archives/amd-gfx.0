Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38593C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 20:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEB110FA16;
	Wed, 15 Dec 2021 20:45:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B7BD10FA1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 20:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADHd+uOBUp9nQo3dyF0/aDjwGdIEYpLDDK+k/LFBA6lZDIkE+RnI0iJW11H6OCWpBDUebIaKrgE1LfkKJsTC8wAp17ZYslQ8xAeeQ5hGM3JY3dnJ4lfDuSGXzxEgMZkW/qR3YvfhDyw1oebpj1oOToVNwnVUW70piAFdqkxn9PKpYsMc8b7jLN/pOCFrHgLuXYL+DmQEwyo7Ry6oYReYJkkdfbVRyjwrVJxsrGPTtwPP7TmE5Cur87efxaZs9TFKcZLHNHDdIlCD8SH+Trs/5FtsIneaz810xkXq69Ef12vHedzPlVILAbdAdcOt0UBAFwETXs+Hkru+tgXCgdhodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lF/JDzoT/dDaqAa1qhFiLjG8yPklhFUb3VKjogUc6A=;
 b=T4Yg3coTT+g3Q7InVb6103/fY0gf55m6UKuWvKssSxmwG08B3/xqXzwxrmn/PBecq9cm0xlp3ey1BZkeFHk2jf0atOX6XicTgF/jxCKAsNnKvBlyIGVfk6haFaz8cm+peCmBpydoIAdgV+Jnl0ul+2sKV0xmk8TytjrZ1oCrr31jatSdvlsZRBg/dDxst8UWSVVkgzE8pZRO/QiVPs2m1TsUpVyw811mgwK6Y50qwEvGMUJ7WEEI9d7Fe1zymKiDeF9ME0e/8kSIqygJYFxVV/beRFnzZyqd9Qy5zEGJ0VAVXYHp2UqVyc2fDAWnMGCc+QM5aWo9I/JNNhgXo7yCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lF/JDzoT/dDaqAa1qhFiLjG8yPklhFUb3VKjogUc6A=;
 b=YJztwIPluvlmIco2IAIDAW20yqFjStsl0qAMBKSN2tXlTfOoDExVl9TogPoPJDHJNh98FaOWA4OQaYRuAIsSD3BFXbNlJbAGRJ98hwm58d21mtb6L+bpyYpPuCGEMnZ0fC32KZeff9YJdxfOypj+HaD1MHRUqMHBgGDnJDo6DHk=
Received: from DM5PR13CA0007.namprd13.prod.outlook.com (2603:10b6:3:23::17) by
 BN8PR12MB3378.namprd12.prod.outlook.com (2603:10b6:408:61::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.11; Wed, 15 Dec 2021 20:45:07 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::de) by DM5PR13CA0007.outlook.office365.com
 (2603:10b6:3:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.10 via Frontend
 Transport; Wed, 15 Dec 2021 20:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 20:45:07 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 14:45:01 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu: Modify indirect register access for gfx9
 sriov
Date: Wed, 15 Dec 2021 20:44:39 +0000
Message-ID: <20211215204439.7216-6-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215204439.7216-1-victor.skvortsov@amd.com>
References: <20211215204439.7216-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa826b3c-78a5-44b2-b4f8-08d9c00bc7ad
X-MS-TrafficTypeDiagnostic: BN8PR12MB3378:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3378D351A5DC8A0A61BDAF7B8B769@BN8PR12MB3378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7iw2AdCRx/JBo2jS0k8A74MuybBodyyhtnSOTAGeHXy7ybqBsKaYuYyNW7hyEag9aUz5CGuauxpl+CBWbFzrzjkAL824mXhQXSb2cMx9Me3kTNgMFRvfSh3y8OkZiQUjb7uugTqWQgassCcAs2sK7Ysuk5krx6FHmLVpHtaaHrG1YdoGbiWdKwseMl3Z935jsTJc8B8xmcDUUEAMXzemENLioo6DIT1jkT0vGtgIzzyx8WoJXX14infsGGj8nAJBD26RMtGGg7ppUAOHwpGUaAuFCQC9/8EJ4VL+Gtza8PQlCGtd0nDgUGvhpwbiszsjZuqYmmF6gxW8IyFHEAY+d17RujoW0E9FbcmGlgV0fbQ0J/bsbnA8SbEPR2lUFw8kGbhOlhYNVrEQRU6zo1oFFEnOgVXuQFf/lNvBnAvm74FUKSPB6W78081OGwc/4Y09yuBzZX3qWCwb6jQ9yQTrdDZnUAch7P2iSrxhLfFQiZO0zq7ddMxAmiAM2cr9kmewCiyoKJ6tOJvi5bhu5OCbvNbimna2ILTZY2JHqG1C4Xngpn4ih2XvnbQ1v4qzwJFHEinl92O3nBYHHUSVFsvYFkzswJ5BCgeKYNzsXz2cXMpxjgymTJ7wGzJwcz/b/CwdhbFqwIsv+6+tWlfKcsMH4ZweytSgUIyVIOmFXHGC5hUIe9HpM4Bj+uKA5hFqa7Mdx6GI/COo7IA0/ocPZzorDcC5kMtmY325bNt/IVTruVnyl3O6NunG7JQW/yVpfEDhzi6egrwDLa2iy9GowdNa5dOcRn4hHaQdNj4iPaURIM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(356005)(110136005)(316002)(1076003)(2616005)(426003)(81166007)(2906002)(4326008)(6666004)(36860700001)(82310400004)(83380400001)(26005)(36756003)(8676002)(6636002)(7696005)(86362001)(44832011)(508600001)(70206006)(336012)(47076005)(40460700001)(16526019)(186003)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 20:45:07.6015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa826b3c-78a5-44b2-b4f8-08d9c00bc7ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3378
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
index d252b06efa43..7a754cb8236e 100644
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
@@ -5134,7 +5194,7 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
 	else
-		data = RREG32(reg);
+		data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
@@ -5190,6 +5250,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.start = gfx_v9_0_rlc_start,
 	.update_spm_vmid = gfx_v9_0_update_spm_vmid,
 	.sriov_wreg = gfx_v9_0_sriov_wreg,
+	.sriov_rreg = gfx_v9_0_sriov_rreg,
 	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
 };
 
@@ -5795,16 +5856,16 @@ static void gfx_v9_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
 
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

