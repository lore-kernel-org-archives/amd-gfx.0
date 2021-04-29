Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FBFC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7725961419
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7725961419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0656ED9E;
	Thu, 29 Apr 2021 08:14:02 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760077.outbound.protection.outlook.com [40.107.76.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACFF26ED9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtfalDgjA6J1NiBfioMKdsl0TxU/kaZ4ypL9dHqTanpeRFRkyDZ8pflY56YT5jLIDA76BLKzK/U55VR5kSgGb0p3LdTt1RwU5Wwi004Cb00Ptgx7dpYxymiymoMoVtXP9xgqNva1jwzbt+I816NohWskKV9Hm7s4V5gLnLiplK2dqXhb9F+BiddyRKJiRKNgqqhdZYmFnglD6t3zmMpCv6+JUV9Rd34P/32jz3HuemYYLvj56GD8oxhdHS90m5iKSQgOrEjm+vjNWazXjhJ6itqP870qflVLLXooQTo61areejpynCXKL36y4Oz3gOkaBgsRT7d2dPI/xzqcAhLQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sep1AtKxoGlVncnvA1gerWrsEwAtKtRjT/fOwdKZO44=;
 b=a2cArjcYue08ggPS9Ne5lTHhUEdv30FJnsXO+1C2SPNI6QZ/2J49hn/wd9smuQhPZb1CkVxNFPtCzxSJrUPIHrzpm4FF8qkrhaxnQmQhv3FythSa1YzjbHiO8EDJyww/sAptHTUmtOPHBKptKOvKZ/FpaPK7lfaQfzDsF8pA0toxQtXW9VCMue5cblVNUnobdxZKvq6lvvihJDmt+UdJaqzKb5nKF4WlLCwe100uyXqMgcp9oeGyYFhWIZDXNV9Sc/9j+V8+Mb0pb0GS9yjNOSweRWsl7EL2fbo/7E2MjBkDD1yH/TJ542ccza+2Vfijn1bwfiudnYfFmYz3+SSLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sep1AtKxoGlVncnvA1gerWrsEwAtKtRjT/fOwdKZO44=;
 b=bMNGUMvMrrVz0rcnaWdzBA+sHGi2X23BoRGWf0PwT7VPIJkMmSNmobmMJWux1l78BPKLYXq2nDZ2n/TO7f6ohSj0Q/xLKzF6+mwlZWBFzq3b/JMkKu9gW3RZRMOjdkZ1X4tsfggkA8WrdT1nCym5tajCy6Kjj3Zy0r2abETlt2Y=
Received: from DM5PR20CA0004.namprd20.prod.outlook.com (2603:10b6:3:93::14) by
 BYAPR12MB3207.namprd12.prod.outlook.com (2603:10b6:a03:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 08:13:57 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::7e) by DM5PR20CA0004.outlook.office365.com
 (2603:10b6:3:93::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 08:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 08:13:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:13:56 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:13:55 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amdgpu: Indirect register access for Navi12 sriov
Date: Thu, 29 Apr 2021 16:13:34 +0800
Message-ID: <20210429081345.24217-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bad8675-ee09-4007-5524-08d90ae6bca3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3207:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3207A5AF69D2CB0BF55FB4D1F85F9@BYAPR12MB3207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FHBjMGTKEWcFp5TmD8vXjHdUr2TjVs2ACEo4Iqo+AiVYaXdpa9Fp9oJ/MjNGfCraIobGt//btulG99UiYTudj45cjXcpOSpwrcSNJNMWemsHEbZL/xHtDLA8qcte0zpzKeiv02XABzhMOO7gvPGMWBJ1IeVlHXL+xrkLMZ95HAflzvE7YBICe+QFkAKqujvSQKttb21jIZ/6nyyO/ZLFM3oG08KyD7w9PniMZDG7evXphUbhjbqnzN2OE0O+zDgsoIzhC4z5+4d0ZcZjjHGo/cmgUCa+oLuzgLjmodgWU72057jSJZAT51jX9aAKSIutmTG3hsf+1qqXde4k5P7/EsHTRVMjyaIjeoUrWX4zdcBrn3tpV0nz5SfBXZ1ueFZTEIqSo95+WatqtLsBGXEdTZw+v6Hc61mC3wUqr73RI0R8HDh9j0RY8gqvIR5Q1Zx1iJuvSYWqAqUAGUDbvyZOlcYRd4b+ycDnPX5hE5nWZZ6EFdO5RTlgHe91qPzVM5NV9SFTrJd3mDbAG+M/TTEnUjR7chDIorxjcHueTczirD7cUncl2/BZVgaIBng51POHgqos6WEJ8UbuzRJJl3ucL+LT+XQ0NpeEAqneZa6ASagLhp8/nGK+HJGllCUNrUFK3L/gHZzfQ2/vS2qBdUJRwX9fOqhfa9TUnKu9kk0W1v1TrFg8C6oFfByMgIkE9KV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(6916009)(5660300002)(186003)(26005)(30864003)(82740400003)(356005)(6666004)(83380400001)(86362001)(1076003)(316002)(81166007)(426003)(36756003)(7696005)(478600001)(70206006)(82310400003)(2616005)(336012)(4326008)(8936002)(8676002)(2906002)(47076005)(36860700001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:13:57.2243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bad8675-ee09-4007-5524-08d90ae6bca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3207
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

Change RLCG/SOC15 register access interface to triage
GC/MMHUB access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h   |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |  68 ++++----------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 109 +++++++++++++++-------
 3 files changed, 95 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 4fc2ce8ce8ab..8193bd04b4b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,8 +127,8 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
-	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag);
-	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 flag);
+	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 hwip);
+	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 hwip);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 85a6a10e048f..c7e04ed168bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1427,38 +1427,25 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00800000)
 };
 
-static bool gfx_v10_is_rlcg_rw(struct amdgpu_device *adev, u32 offset, uint32_t *flag, bool write)
-{
-	/* always programed by rlcg, only for gc */
-	if (offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI) ||
-	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO) ||
-	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH) ||
-	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL) ||
-	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX) ||
-	    offset == SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL)) {
-		if (!amdgpu_sriov_reg_indirect_gc(adev))
-			*flag = GFX_RLCG_GC_WRITE_OLD;
-		else
-			*flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
-
-		return true;
-	}
+static u32 gfx_v10_get_rlcg_flag(struct amdgpu_device *adev, u32 hwip, int write)
+{
+	u32 flag = -1;
 
-	/* currently support gc read/write, mmhub write */
-	if (offset >= SOC15_REG_OFFSET(GC, 0, mmSDMA0_DEC_START) &&
-	    offset <= SOC15_REG_OFFSET(GC, 0, mmRLC_GTS_OFFSET_MSB)) {
+	if (hwip == GC_HWIP) {
 		if (amdgpu_sriov_reg_indirect_gc(adev))
-			*flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
+			flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
 		else
-			return false;
+			flag = GFX_RLCG_GC_WRITE_OLD;
 	} else {
+		ASSERT(write);
 		if (amdgpu_sriov_reg_indirect_mmhub(adev))
-			*flag = GFX_RLCG_MMHUB_WRITE;
-		else
-			return false;
+			flag = GFX_RLCG_MMHUB_WRITE;
 	}
 
-	return true;
+	if (flag == -1)
+		DRM_ERROR("amdgpu: failed to get RLCG flag, IP 0x%x\n", hwip);
+
+	return flag;
 }
 
 static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32_t flag)
@@ -1518,36 +1505,21 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32
 	return ret;
 }
 
-static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 flag)
+static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 hwip)
 {
-	uint32_t rlcg_flag;
-
-	if (amdgpu_sriov_fullaccess(adev) &&
-	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 1)) {
-		gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
+	u32 rlcg_flag;
 
-		return;
-	}
-	if (flag & AMDGPU_REGS_NO_KIQ)
-		WREG32_NO_KIQ(offset, value);
-	else
-		WREG32(offset, value);
+	rlcg_flag = gfx_v10_get_rlcg_flag(adev, hwip, 1);
+	gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
 }
 
-static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32 flag)
+static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32 hwip)
 {
-	uint32_t rlcg_flag;
-
-	if (amdgpu_sriov_fullaccess(adev) &&
-	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 0))
-		return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
+	u32 rlcg_flag;
 
-	if (flag & AMDGPU_REGS_NO_KIQ)
-		return RREG32_NO_KIQ(offset);
-	else
-		return RREG32(offset);
+	rlcg_flag = gfx_v10_get_rlcg_flag(adev, hwip, 0);
 
-	return 0;
+	return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
 }
 
 static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] =
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 14bd794bbea6..90c4c56b5665 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -27,28 +27,73 @@
 /* Register Access Macros */
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
+#define RLC_GC_EN(hwip) \
+	(amdgpu_sriov_fullaccess(adev) && \
+	 (amdgpu_sriov_reg_indirect_gc(adev) && (hwip == GC_HWIP)))
+
+#define RLC_MMHUB_EN(hwip, write) \
+	(amdgpu_sriov_fullaccess(adev) && \
+	 (amdgpu_sriov_reg_indirect_mmhub(adev) && \
+	  (hwip == MMHUB_HWIP) && \
+	  (write)))
+
+#define __WREG32_SOC15_RLC__(reg, value, hwip) \
+	((((hwip == GC_HWIP) || ((hwip == MMHUB_HWIP) && RLC_MMHUB_EN(hwip, 1))) && \
+	  adev->gfx.rlc.funcs->rlcg_wreg) ? \
+	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, hwip) : \
+	 WREG32(reg, value))
+
+#define __RREG32_SOC15_RLC__(reg, hwip) \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
+	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, hwip) : \
+	 RREG32(reg))
+
+#define __WREG32_SOC15__(reg, value, hwip) \
+	(RLC_GC_EN(hwip) ? \
+	 __WREG32_SOC15_RLC__(reg, value, hwip) : \
+	 WREG32(reg, value))
+
+#define __RREG32_SOC15__(reg, hwip) \
+	(RLC_GC_EN(hwip) ? \
+	 __RREG32_SOC15_RLC__(reg, hwip) : \
+	 RREG32(reg))
+
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
-	WREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
-	(RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg)	\
-	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
+	 __WREG32_SOC15__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
+				(__RREG32_SOC15__( \
+					adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
+					ip##_HWIP) & \
+				~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
+			  ip##_HWIP)
 
 #define RREG32_SOC15(ip, inst, reg) \
-	RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+	__RREG32_SOC15__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, ip##_HWIP)
+
+#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15__(reg, ip##_HWIP)
 
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
-	RREG32_NO_KIQ(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+	((RLC_GC_EN(ip##_HWIP) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
+	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, ip##_HWIP) : \
+	 RREG32_NO_KIQ(reg, value))
 
 #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
-	RREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset)
+	 __RREG32_SOC15__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, ip##_HWIP)
 
 #define WREG32_SOC15(ip, inst, reg, value) \
-	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
+	 __WREG32_SOC15__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
+			  value, ip##_HWIP)
+
+#define WREG32_SOC15_IP(ip, reg, value) \
+	 __WREG32_SOC15__(reg, value, ip##_HWIP)
 
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
-	WREG32_NO_KIQ((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
+	((RLC_GC_EN(ip##_HWIP) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
+	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, ip##_HWIP) : \
+	 WREG32_NO_KIQ(reg, value))
 
 #define WREG32_SOC15_OFFSET(ip, inst, reg, offset, value) \
-	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value)
+	 __WREG32_SOC15__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, \
+			  value, ip##_HWIP)
 
 #define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask) \
 ({	int ret = 0;						\
@@ -77,12 +122,7 @@
 })
 
 #define WREG32_RLC(reg, value) \
-	do { \
-		if (adev->gfx.rlc.funcs->rlcg_wreg) \
-			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, 0); \
-		else \
-			WREG32(reg, value);	\
-	} while (0)
+	__WREG32_SOC15_RLC__(reg, value, GC_HWIP)
 
 #define WREG32_RLC_EX(prefix, reg, value) \
 	do {							\
@@ -108,24 +148,21 @@
 		}	\
 	} while (0)
 
+/* shadow the registers in the callback function */
 #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
-	WREG32_RLC((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value, GC_HWIP)
 
+/* for GC only */
 #define RREG32_RLC(reg) \
-	(adev->gfx.rlc.funcs->rlcg_rreg ? \
-		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, 0) : RREG32(reg))
-
-#define WREG32_RLC_NO_KIQ(reg, value) \
-	do { \
-		if (adev->gfx.rlc.funcs->rlcg_wreg) \
-			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, AMDGPU_REGS_NO_KIQ); \
-		else \
-			WREG32_NO_KIQ(reg, value);	\
-	} while (0)
+	__RREG32_SOC15_RLC__(reg, GC_HWIP)
+
+#define WREG32_RLC_NO_KIQ(reg, value, hwip) \
+	(((RLC_GC_EN(hwip) || RLC_MMHUB_EN(hwip, 1)) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
+		adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, hwip) : WREG32_NO_KIQ(reg, value))
 
-#define RREG32_RLC_NO_KIQ(reg) \
-	(adev->gfx.rlc.funcs->rlcg_rreg ? \
-		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, AMDGPU_REGS_NO_KIQ) : RREG32_NO_KIQ(reg))
+#define RREG32_RLC_NO_KIQ(reg, hwip) \
+	(((RLC_GC_EN(hwip) || RLC_MMHUB_EN(hwip, 0)) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
+		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, hwip) : RREG32_NO_KIQ(reg))
 
 #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
 	do {							\
@@ -146,12 +183,12 @@
 	} while (0)
 
 #define RREG32_SOC15_RLC(ip, inst, reg) \
-	RREG32_RLC(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, ip##_HWIP)
 
 #define WREG32_SOC15_RLC(ip, inst, reg, value) \
 	do {							\
 		uint32_t target_reg = adev->reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg;\
-		WREG32_RLC(target_reg, value); \
+		__WREG32_SOC15_RLC__(target_reg, value, ip##_HWIP); \
 	} while (0)
 
 #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \
@@ -161,14 +198,14 @@
 	} while (0)
 
 #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
-	WREG32_RLC((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
-	(RREG32_RLC(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
-	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
+		     (__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, ip##_HWIP) \
+				 & ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), ip##_HWIP)
 
 #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
-	WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset), value)
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value, ip##_HWIP)
 
 #define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
-	RREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset))
+	__RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, ip##_HWIP)
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
