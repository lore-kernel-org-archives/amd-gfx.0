Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB71C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 05:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66FB6191B
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 05:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66FB6191B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B6206E48E;
	Wed, 31 Mar 2021 05:21:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4EB6E48E
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 05:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JB9rOXRfRWwBF0uHdswFR+1k8M+QFNQABO/3yxtr4mbnNNr289kT/EM0Mq4jO2KjPHQibdN3OyRHEKZlcVuyquEqyFQIlifhscIIr7+CD5Cb6juVn2JOtYl6QJCWtlzCZbjRLm2xr7pfsAmS9kb7ez2mm/mY3dKIIykRo2XIl2LbJ2tgFlSO17JbblQ/16r2d8EtPqM4A808aUBYJ1bGXQKyZ5djnZ58OU0N93Q4sxqYNe9in2/o9PG2UBV7JSZx8RdISAl7kyuXUlBlrWyfXnGwhA11OkTNcmyY8D8Ue1UhrZse13K8aHN9eXLW8DfpweXbMj1UkFeE2lQHBm+0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWXeWN3Ec9o+zNVL79OTrvCjmVPqraKjj4jzytE6Z2c=;
 b=luOKz58d7VPDvU4b1fSFFTiQPAYKHq0jPhyiGNokOxB952RcTsWmJsksCVLk/73/da4Zl077HpfYO6cYKReQsdu1xy/cOkorSMHpIRaLlpWrT+P+RZm6Y99HaEfUgNKk6wWdv+wVHdhWMZVOFcDJ9JlkP5ZnAM3V4wYks+ToHni1/lreisO7uWgWOpDHx+jRL+SjAyk/CE6MaPOqZrTp032B/Ue7jndYEvUrAQRzVxfAtHD7xKv/Miaic8OTcJc3DJUwtcUrje0nDMHhRDGKcfEAs44QbXyoEsMoFkJnZzGhtN6Ek852/mzkx1V0CDf9eKRLSWZ3loDcAq4sYgX3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWXeWN3Ec9o+zNVL79OTrvCjmVPqraKjj4jzytE6Z2c=;
 b=Uy1IEBA6jzE816domgRUCvkvG02l2nK8ThnePJx6OQhplmabMsE2qTRj4eRtyuuF7vY4b08Bi3u+EOp3sy/Qp1IzxPQPSLGN6z5lcgM33i0PVSxkvGsyMwjrji+oV8j+WgD6hlvQuSNZ8vB6r80OPs2uvu7Jt2bjFGQ/efLfqc8=
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 31 Mar
 2021 05:20:59 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::92) by MW4PR03CA0100.outlook.office365.com
 (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Wed, 31 Mar 2021 05:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Wed, 31 Mar 2021 05:20:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 31 Mar
 2021 00:20:57 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Wed, 31 Mar 2021 00:20:56 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: indirect register access for nv12 sriov
Date: Wed, 31 Mar 2021 13:20:25 +0800
Message-ID: <20210331052025.24200-4-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331052025.24200-1-PengJu.Zhou@amd.com>
References: <20210331052025.24200-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1692225-3b0a-4066-7371-08d8f404c46c
X-MS-TrafficTypeDiagnostic: MW3PR12MB4556:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4556116D919F8564B7E76B42F87C9@MW3PR12MB4556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jE2pMKLEDnONfW1ylvipYrLUrxxs4Dg84Mk+CdWsdq2mm1jpHbyveVWisvmj/cjngUeDrKTq29EPDS72Oz+js0qBNpx6JF6y5apv2vKDjIgJ+VhRn2LYCFSVZrl9VxnKcK7JINrGK7pmtmjX3RlqyojB8B6cziutWArFwUWIhFsNbcLKu5z0P6r42El3f1wG0FwzfC+bCJdZKDRxjf1Ne/XiEC+AwdJpBtNDVVaohrYr8wJycDOXhMCsmEZ9dPBpUAsm4vVKGaw5hucDUuzng+j3z9bHKj2hpxJTMvcCnMTHRLXNLTuzUDCV0r1Wkzv4iHnMtY0zI7QPdWQSWYW7V0owefKaWPSoJFz1COHdIIw1593XL8eXfQyPOQonfcMBMFgEFeyzgK5n0uML8i0G07BqFUyq0ESP1UuWZcyO2Cej20GFtat4LSBafhPYwO0WdBIrj1TglzQDLZ0YySgiznXCBFd2pATZPJyMbPC84zWjGhJNBc/jZ4hG2dgcM3VWQ3O2u7uLt4hV8Y+3tqOoHFdKcq6cC+E1KWaium8G2a8tZG1OWk0iB1u2/MM3ymwnJMwxA4Lww7jsRV2omRAjRzn12FqfYWpGuV+b0ptjBq+odjQim25yU1Yh1W3gDBx5IYAbeQsXbGbg7u26C1z64c11TcSeajcqonx9rAEVGdV/TDu2L3IjFzxZfLwgKkV1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(316002)(6916009)(54906003)(30864003)(1076003)(5660300002)(83380400001)(86362001)(2906002)(478600001)(6666004)(26005)(2616005)(82740400003)(81166007)(36756003)(47076005)(426003)(70206006)(70586007)(82310400003)(7696005)(336012)(356005)(36860700001)(8676002)(4326008)(186003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 05:20:58.3304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1692225-3b0a-4066-7371-08d8f404c46c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
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

1. expand rlcg interface for gc & mmhub indirect access
2. add rlcg interface for no kiq

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 131 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  75 ++++++------
 5 files changed, 150 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 060d0ae99453..438e2f732377 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -490,7 +490,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v);
+			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0);
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index aeaaae713c59..4fc2ce8ce8ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,7 +127,8 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
-	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v);
+	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag);
+	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 flag);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b4fd0394cd08..85a6a10e048f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -177,6 +177,11 @@
 #define mmGC_THROTTLE_CTRL_Sienna_Cichlid              0x2030
 #define mmGC_THROTTLE_CTRL_Sienna_Cichlid_BASE_IDX     0
 
+#define GFX_RLCG_GC_WRITE_OLD	(0x8 << 28)
+#define GFX_RLCG_GC_WRITE	(0x0 << 28)
+#define GFX_RLCG_GC_READ	(0x1 << 28)
+#define GFX_RLCG_MMHUB_WRITE	(0x2 << 28)
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -1422,38 +1427,127 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00800000)
 };
 
-static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
+static bool gfx_v10_is_rlcg_rw(struct amdgpu_device *adev, u32 offset, uint32_t *flag, bool write)
+{
+	/* always programed by rlcg, only for gc */
+	if (offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI) ||
+	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO) ||
+	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH) ||
+	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL) ||
+	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX) ||
+	    offset == SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL)) {
+		if (!amdgpu_sriov_reg_indirect_gc(adev))
+			*flag = GFX_RLCG_GC_WRITE_OLD;
+		else
+			*flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
+
+		return true;
+	}
+
+	/* currently support gc read/write, mmhub write */
+	if (offset >= SOC15_REG_OFFSET(GC, 0, mmSDMA0_DEC_START) &&
+	    offset <= SOC15_REG_OFFSET(GC, 0, mmRLC_GTS_OFFSET_MSB)) {
+		if (amdgpu_sriov_reg_indirect_gc(adev))
+			*flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
+		else
+			return false;
+	} else {
+		if (amdgpu_sriov_reg_indirect_mmhub(adev))
+			*flag = GFX_RLCG_MMHUB_WRITE;
+		else
+			return false;
+	}
+
+	return true;
+}
+
+static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32_t flag)
 {
 	static void *scratch_reg0;
 	static void *scratch_reg1;
+	static void *scratch_reg2;
+	static void *scratch_reg3;
 	static void *spare_int;
+	static uint32_t grbm_cntl;
+	static uint32_t grbm_idx;
 	uint32_t i = 0;
 	uint32_t retries = 50000;
+	u32 ret = 0;
+
+	scratch_reg0 = adev->rmmio +
+		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0) * 4;
+	scratch_reg1 = adev->rmmio +
+		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1) * 4;
+	scratch_reg2 = adev->rmmio +
+		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG2) * 4;
+	scratch_reg3 = adev->rmmio +
+		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3) * 4;
+	spare_int = adev->rmmio +
+		    (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT) * 4;
+
+	grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;
+	grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
+
+	if (offset == grbm_cntl || offset == grbm_idx) {
+		if (offset  == grbm_cntl)
+			writel(v, scratch_reg2);
+		else if (offset == grbm_idx)
+			writel(v, scratch_reg3);
+
+		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
+	} else {
+		writel(v, scratch_reg0);
+		writel(offset | flag, scratch_reg1);
+		writel(1, spare_int);
+		for (i = 0; i < retries; i++) {
+			u32 tmp;
+
+			tmp = readl(scratch_reg1);
+			if (!(tmp & flag))
+				break;
 
-	scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
-	scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
-	spare_int = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;
+			udelay(10);
+		}
 
-	if (amdgpu_sriov_runtime(adev)) {
-		pr_err("shouldn't call rlcg write register during runtime\n");
-		return;
+		if (i >= retries)
+			pr_err("timeout: rlcg program reg:0x%05x failed !\n", offset);
 	}
 
-	writel(v, scratch_reg0);
-	writel(offset | 0x80000000, scratch_reg1);
-	writel(1, spare_int);
-	for (i = 0; i < retries; i++) {
-		u32 tmp;
+	ret = readl(scratch_reg0);
 
-		tmp = readl(scratch_reg1);
-		if (!(tmp & 0x80000000))
-			break;
+	return ret;
+}
 
-		udelay(10);
+static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 flag)
+{
+	uint32_t rlcg_flag;
+
+	if (amdgpu_sriov_fullaccess(adev) &&
+	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 1)) {
+		gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
+
+		return;
 	}
+	if (flag & AMDGPU_REGS_NO_KIQ)
+		WREG32_NO_KIQ(offset, value);
+	else
+		WREG32(offset, value);
+}
+
+static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32 flag)
+{
+	uint32_t rlcg_flag;
 
-	if (i >= retries)
-		pr_err("timeout: rlcg program reg:0x%05x failed !\n", offset);
+	if (amdgpu_sriov_fullaccess(adev) &&
+	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 0))
+		return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
+
+	if (flag & AMDGPU_REGS_NO_KIQ)
+		return RREG32_NO_KIQ(offset);
+	else
+		return RREG32(offset);
+
+	return 0;
 }
 
 static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] =
@@ -7888,6 +7982,7 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
 	.start = gfx_v10_0_rlc_start,
 	.update_spm_vmid = gfx_v10_0_update_spm_vmid,
 	.rlcg_wreg = gfx_v10_rlcg_wreg,
+	.rlcg_rreg = gfx_v10_rlcg_rreg,
 	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 99f58439f3d5..6e49b239087a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -734,7 +734,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
 	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };
 
-static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
+void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
 {
 	static void *scratch_reg0;
 	static void *scratch_reg1;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 8cdf5d1685cb..14bd794bbea6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -77,27 +77,11 @@
 })
 
 #define WREG32_RLC(reg, value) \
-	do {							\
-		if (amdgpu_sriov_fullaccess(adev)) {    \
-			uint32_t i = 0;	\
-			uint32_t retries = 50000;	\
-			uint32_t r0 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0;	\
-			uint32_t r1 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1;	\
-			uint32_t spare_int = adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT;	\
-			WREG32(r0, value);	\
-			WREG32(r1, (reg | 0x80000000));	\
-			WREG32(spare_int, 0x1);	\
-			for (i = 0; i < retries; i++) {	\
-				u32 tmp = RREG32(r1);	\
-				if (!(tmp & 0x80000000))	\
-					break;	\
-				udelay(10);	\
-			}	\
-			if (i >= retries)	\
-				pr_err("timeout: rlcg program reg:0x%05x failed !\n", reg);	\
-		} else {	\
-			WREG32(reg, value); \
-		}	\
+	do { \
+		if (adev->gfx.rlc.funcs->rlcg_wreg) \
+			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, 0); \
+		else \
+			WREG32(reg, value);	\
 	} while (0)
 
 #define WREG32_RLC_EX(prefix, reg, value) \
@@ -125,23 +109,24 @@
 	} while (0)
 
 #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
-	do {							\
-		uint32_t target_reg = adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\
-		if (amdgpu_sriov_fullaccess(adev)) {    \
-			uint32_t r2 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG2;	\
-			uint32_t r3 = adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3;	\
-			uint32_t grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;   \
-			uint32_t grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;   \
-			if (target_reg == grbm_cntl) \
-				WREG32(r2, value);	\
-			else if (target_reg == grbm_idx) \
-				WREG32(r3, value);	\
-			WREG32(target_reg, value);	\
-		} else {	\
-			WREG32(target_reg, value); \
-		}	\
+	WREG32_RLC((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
+
+#define RREG32_RLC(reg) \
+	(adev->gfx.rlc.funcs->rlcg_rreg ? \
+		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, 0) : RREG32(reg))
+
+#define WREG32_RLC_NO_KIQ(reg, value) \
+	do { \
+		if (adev->gfx.rlc.funcs->rlcg_wreg) \
+			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, AMDGPU_REGS_NO_KIQ); \
+		else \
+			WREG32_NO_KIQ(reg, value);	\
 	} while (0)
 
+#define RREG32_RLC_NO_KIQ(reg) \
+	(adev->gfx.rlc.funcs->rlcg_rreg ? \
+		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, AMDGPU_REGS_NO_KIQ) : RREG32_NO_KIQ(reg))
+
 #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
 	do {							\
 		uint32_t target_reg = adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\
@@ -160,10 +145,13 @@
 		}	\
 	} while (0)
 
+#define RREG32_SOC15_RLC(ip, inst, reg) \
+	RREG32_RLC(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+
 #define WREG32_SOC15_RLC(ip, inst, reg, value) \
 	do {							\
-			uint32_t target_reg = adev->reg_offset[GC_HWIP][0][reg##_BASE_IDX] + reg;\
-			WREG32_RLC(target_reg, value); \
+		uint32_t target_reg = adev->reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg;\
+		WREG32_RLC(target_reg, value); \
 	} while (0)
 
 #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \
@@ -173,11 +161,14 @@
 	} while (0)
 
 #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
-    WREG32_RLC((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
-    (RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
-    & ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
+	WREG32_RLC((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
+	(RREG32_RLC(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
+	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
 
 #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
-    WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset), value)
+	WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset), value)
+
+#define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
+	RREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset))
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
