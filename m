Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF5FC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D0961CDD
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D0961CDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914516E99E;
	Mon, 17 May 2021 14:39:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042A96E99B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUav8hutHDy0LeKbD3CEIDj7tK91O7CCBTcujpiMXsZ8l83fDIOcHo+dS/HqOzTuQ3XrRoczH/DX70bkB7QGz7l+Pv4eRrrpjfiSf89v7qWZTKOyUmxGEgE2X3nptX3ZqpIaj8wQowBzSvkyFm81k0YOKbRR6MLNHoQ9M3GkvHfrPGqCR4VjZKom+C5SY+rnY7hvZdMzfMDih1jxwOAJ/0bj6AjfpHutzzO2ujmWonOrn4L1w2K4vEUYUS6dnEr7PSonvai6e/0z+uunYKSl0JCf85kM4lNVzVgFut2ygxlgOkzwVzhHJq7uNWuVEatYO1MBPcX5+EI1yOXSi90RhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1vXKWQXEm9pamcbI/CvxRgRHAUxzx5zM++hX0UTgks=;
 b=Ym6Y5G7jN6AybhwXudPytOIqA6tMMXkM9/GkRglfhvY8QrxhUTHT7nwg+9Hg9Z0TWq9owuNeyEi+KNCNavt/R9bkRgZR5nf/Q0k1G0hf6mFb/KhqfO3WjJL5u37sNmeQGLITirCckQAYikiwtdDDzcxEFep0cZhC8yzoCmhY9sw/1dEFsfEdbSAcLCJK0VQLxPQQhEtg5xD2XtaQ75M8GGQg5TLUoC/YhOdngWjPuhgGpaOdDITttY2TH9t6GGqg1NrBD7Bv1OOO95l7zJ6PoF4vrQF8Dkn4JfRtDmukO31bC+qJPCqLmRq5MsCYzMrVo0Yt41doVC+0vjYk/FaXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1vXKWQXEm9pamcbI/CvxRgRHAUxzx5zM++hX0UTgks=;
 b=VwYfAzpYuslehJ9zD57WtPspVqUB2IbDzraAHKynrbaXDG8XKH0+xlALITesYTSV3LiRuUx4a4ugvXnwVwz094fpZM8zykdoOR4u/0Kb+Biw1m1Z+1nkphUJ+3GxFsPWFoKPv2cJyVcQDWJ40X5egVTfqogr79K/fOKHtqiDKao=
Received: from DM5PR13CA0017.namprd13.prod.outlook.com (2603:10b6:3:23::27) by
 BYAPR12MB3190.namprd12.prod.outlook.com (2603:10b6:a03:132::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 14:39:19 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::17) by DM5PR13CA0017.outlook.office365.com
 (2603:10b6:3:23::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Mon, 17 May 2021 14:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 14:39:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:18 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 09:39:17 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12 sriov
Date: Mon, 17 May 2021 22:39:01 +0800
Message-ID: <20210517143910.2125-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 494d5eb3-e644-4fa2-eda6-08d919418dca
X-MS-TrafficTypeDiagnostic: BYAPR12MB3190:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3190572DC83985E64775917CF82D9@BYAPR12MB3190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzCpbQJz/2Yn4RquEPJDl4FZSMESbGa6GxBf4+iVSkNQBEsGd9fKQeaMWSxYDo65+ARU1C0GMtRcSAz5s90pdrwXKHdK6MVBz8shyCrn+y1TJ88+viijSXKp4xeg003C0nuRzeFk39mJxyCwk8huHjfzgGov7kaoyD1u76eG/odYnPgWo7KN1qSPfO6A1p2mEEQYEpSCN9G2dULAjljPJGNPEYwtA/l0RH4FjHBD0fX8YF6nMieefIC/b+vSSLDcbOnxKXIyc8OTiGUjQhMs5SOu2JOZc9bSydTPNNLE0YrQ2lnG/odw4DGijAuXCwN+FBmm/V52fOiTYPDqObuyf+cLRELltgxnQd9/Tw9gjD0X1us8ro0g7pi4mouQcIvT0aw1+A75STTWewIi0B7HifAjrqxpwWsRhvrws0ZWw6q0jqmfl1fEELsoZcUtDGh3XKQKU/yBUgxIl87kmMERwkDC+oSe8NpmCd1+vcs3FLNDg+hTpUwrlHro5BCgvqJLd7Yo0qmE6IFr41F3Pr4y5nRLr26xHV+qRpLKVa5N++HbgL3osDwpR4vzYrmqrETFWP4CvJHs5TbOh5ZYVT/tT1KMRufXJ7/w6vE4Nw1r1psNrQU5TjGAWBEfT5Bfo7ZUygIfgY0t0eRyyPr1umNewFzZylYRiplDWTtPDFseQ2Qe/9EzjGhbTT5G53yQUXSm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(396003)(376002)(136003)(36840700001)(46966006)(6916009)(26005)(6666004)(478600001)(8936002)(8676002)(316002)(186003)(2616005)(336012)(426003)(2906002)(5660300002)(4326008)(36756003)(7696005)(1076003)(82740400003)(83380400001)(81166007)(356005)(86362001)(36860700001)(47076005)(82310400003)(70586007)(30864003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:39:19.1181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 494d5eb3-e644-4fa2-eda6-08d919418dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3190
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

This patch series are used for GC/MMHUB(part)/IH_RB_CNTL
indirect access in the SRIOV environment.

There are 4 bits, controlled by host, to control
if GC/MMHUB(part)/IH_RB_CNTL indirect access enabled.
(one bit is master bit controls other 3 bits)

For GC registers, changing all the register access from MMIO to
RLC and use RLC as the default access method in the full access time.

For partial MMHUB registers, changing their access from MMIO to
RLC in the full access time, the remaining registers
keep the original access method.

For IH_RB_CNTL register, changing it's access from MMIO to PSP.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 78 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  9 ++-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 87 +++++++++++++---------
 6 files changed, 97 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3147c1c935c8..4e0c90e52ab6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1147,6 +1147,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
  * Registers read & write functions.
  */
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
+#define AMDGPU_REGS_RLC	(1<<2)
 
 #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7c6c435e5d02..a2392bbe1e21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -490,7 +490,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0);
+			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0, 0);
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 4fc2ce8ce8ab..7a4775ab6804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,8 +127,8 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
-	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag);
-	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 flag);
+	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
+	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2a3427e5020f..7c5c1ff7d97e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1427,38 +1427,36 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
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
+static bool gfx_v10_get_rlcg_flag(struct amdgpu_device *adev, u32 acc_flags, u32 hwip,
+				 int write, u32 *rlcg_flag)
+{
+	switch (hwip) {
+	case GC_HWIP:
+		if (amdgpu_sriov_reg_indirect_gc(adev)) {
+			*rlcg_flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
 
-		return true;
-	}
+			return true;
+		/* only in new version, AMDGPU_REGS_NO_KIQ and AMDGPU_REGS_RLC enabled simultaneously */
+		} else if ((acc_flags & AMDGPU_REGS_RLC) && !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
+			*rlcg_flag = GFX_RLCG_GC_WRITE_OLD;
 
-	/* currently support gc read/write, mmhub write */
-	if (offset >= SOC15_REG_OFFSET(GC, 0, mmSDMA0_DEC_START) &&
-	    offset <= SOC15_REG_OFFSET(GC, 0, mmRLC_GTS_OFFSET_MSB)) {
-		if (amdgpu_sriov_reg_indirect_gc(adev))
-			*flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
-		else
-			return false;
-	} else {
-		if (amdgpu_sriov_reg_indirect_mmhub(adev))
-			*flag = GFX_RLCG_MMHUB_WRITE;
-		else
-			return false;
+			return true;
+		}
+
+		break;
+	case MMHUB_HWIP:
+		if (amdgpu_sriov_reg_indirect_mmhub(adev) &&
+		    (acc_flags & AMDGPU_REGS_RLC) && write) {
+			*rlcg_flag = GFX_RLCG_MMHUB_WRITE;
+			return true;
+		}
+
+		break;
+	default:
+		DRM_DEBUG("Not program register by RLCG\n");
 	}
 
-	return true;
+	return false;
 }
 
 static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32_t flag)
@@ -1518,36 +1516,34 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32
 	return ret;
 }
 
-static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 flag)
+static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 acc_flags, u32 hwip)
 {
-	uint32_t rlcg_flag;
+	u32 rlcg_flag;
 
-	if (amdgpu_sriov_fullaccess(adev) &&
-	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 1)) {
+	if (!amdgpu_sriov_runtime(adev) &&
+	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 1, &rlcg_flag)) {
 		gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
-
 		return;
 	}
-	if (flag & AMDGPU_REGS_NO_KIQ)
+
+	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		WREG32_NO_KIQ(offset, value);
 	else
 		WREG32(offset, value);
 }
 
-static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32 flag)
+static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip)
 {
-	uint32_t rlcg_flag;
+	u32 rlcg_flag;
 
-	if (amdgpu_sriov_fullaccess(adev) &&
-	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 0))
+	if (!amdgpu_sriov_runtime(adev) &&
+	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 0, &rlcg_flag))
 		return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
 
-	if (flag & AMDGPU_REGS_NO_KIQ)
+	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		return RREG32_NO_KIQ(offset);
 	else
 		return RREG32(offset);
-
-	return 0;
 }
 
 static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] =
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index feaa5e4a5538..fe5908f708cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -734,7 +734,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
 	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };
 
-static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
 {
 	static void *scratch_reg0;
 	static void *scratch_reg1;
@@ -787,15 +787,16 @@ static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32
 
 }
 
-static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
+			       u32 v, u32 acc_flags, u32 hwip)
 {
 	if (amdgpu_sriov_fullaccess(adev)) {
-		gfx_v9_0_rlcg_rw(adev, offset, v, flag);
+		gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
 
 		return;
 	}
 
-	if (flag & AMDGPU_REGS_NO_KIQ)
+	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		WREG32_NO_KIQ(offset, v);
 	else
 		WREG32(offset, v);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 14bd794bbea6..c781808e4dc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -27,28 +27,51 @@
 /* Register Access Macros */
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
+#define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
+	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
+	 WREG32(reg, value))
+
+#define __RREG32_SOC15_RLC__(reg, flag, hwip) \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
+	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
+	 RREG32(reg))
+
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
-	WREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
-	(RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg)	\
-	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
+	 __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
+				(__RREG32_SOC15_RLC__( \
+					adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
+					0, ip##_HWIP) & \
+				~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
+			      0, ip##_HWIP)
 
 #define RREG32_SOC15(ip, inst, reg) \
-	RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
+			 0, ip##_HWIP)
+
+#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP)
 
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
-	RREG32_NO_KIQ(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
+			 AMDGPU_REGS_NO_KIQ, ip##_HWIP)
 
 #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
-	RREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset)
+	 __RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, 0, ip##_HWIP)
 
 #define WREG32_SOC15(ip, inst, reg, value) \
-	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
+	 __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
+			  value, 0, ip##_HWIP)
+
+#define WREG32_SOC15_IP(ip, reg, value) \
+	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)
 
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
-	WREG32_NO_KIQ((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
+	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
+			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
 
 #define WREG32_SOC15_OFFSET(ip, inst, reg, offset, value) \
-	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value)
+	 __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, \
+			  value, 0, ip##_HWIP)
 
 #define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask) \
 ({	int ret = 0;						\
@@ -77,12 +100,7 @@
 })
 
 #define WREG32_RLC(reg, value) \
-	do { \
-		if (adev->gfx.rlc.funcs->rlcg_wreg) \
-			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, 0); \
-		else \
-			WREG32(reg, value);	\
-	} while (0)
+	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP)
 
 #define WREG32_RLC_EX(prefix, reg, value) \
 	do {							\
@@ -108,24 +126,19 @@
 		}	\
 	} while (0)
 
+/* shadow the registers in the callback function */
 #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
-	WREG32_RLC((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value, AMDGPU_REGS_RLC, GC_HWIP)
 
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
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
+
+#define WREG32_RLC_NO_KIQ(reg, value, hwip) \
+	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip)
 
-#define RREG32_RLC_NO_KIQ(reg) \
-	(adev->gfx.rlc.funcs->rlcg_rreg ? \
-		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, AMDGPU_REGS_NO_KIQ) : RREG32_NO_KIQ(reg))
+#define RREG32_RLC_NO_KIQ(reg, hwip) \
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip)
 
 #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
 	do {							\
@@ -146,12 +159,12 @@
 	} while (0)
 
 #define RREG32_SOC15_RLC(ip, inst, reg) \
-	RREG32_RLC(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, AMDGPU_REGS_RLC, ip##_HWIP)
 
 #define WREG32_SOC15_RLC(ip, inst, reg, value) \
 	do {							\
 		uint32_t target_reg = adev->reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg;\
-		WREG32_RLC(target_reg, value); \
+		__WREG32_SOC15_RLC__(target_reg, value, AMDGPU_REGS_RLC, ip##_HWIP); \
 	} while (0)
 
 #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \
@@ -161,14 +174,16 @@
 	} while (0)
 
 #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
-	WREG32_RLC((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
-	(RREG32_RLC(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
-	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
+			     (__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
+						   AMDGPU_REGS_RLC, ip##_HWIP) & \
+			      ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
+			     AMDGPU_REGS_RLC, ip##_HWIP)
 
 #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
-	WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset), value)
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP)
 
 #define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
-	RREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset))
+	__RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP)
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
