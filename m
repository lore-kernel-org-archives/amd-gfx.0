Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7F7C433B4
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5088B61354
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5088B61354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5913A6E87B;
	Sat,  8 May 2021 11:52:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2166E877
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 11:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT1SQLHDrYq3vLibjadPx/qAHaAorjwVu6BPG6AbXWVJR0K/+pX+rGhZ5gx8bqICO769GaT3dOgwzZnEc0ZqwxRAPyyiRPOja8F+InvuRQBl1ZHW6napBuqN1aZjVkouupIg561zaVPWcJrFr8vTBCrhbofok/KRGtZ9ankYgx1VXboQIaTc7HpuWL+l0dcb3bYY18vLK7btr/54zkvQFMi5tiTO+WRZsGqgocWWfjNZy+yn7dljliO1Qi25svYD6BvYrTb3dNd7uD2V7w10AOOmnlXvEVU3NZtb7CsNem0bLCuVc5LeQZ+GIkYBP4x0rDTVBxEKwbhOx7hPyR932g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJaWxka/8tjQPo0YOPi9cYcg11p3WoC+zUU72nJjaj0=;
 b=MdtdvcAcg+AQ6Qkw86e+omk5To/GEZ7UFRTndq37apzHYj/GnzYIQ8Z69juxWO3nDwMd/XBVA72k37SRXgAWhFOcM2M6dYfXJvPeSy8hJ0WYSkb/jYnCDbx33/inqaIf6cEFBVUEt7+C1TTqijON0yrOfuX4FqOPo1Rkr6mgpf+u/zllpcDfyxHkD1IZKyMR+78cyHFI0KPaxrqyhrTNKKPwmmG3OsdKLRdRQ8bbTuip9MhGT5BTCU19rgkrKa0LFIGLSAYTMJI6csEgfVtUSBkSwoc+81mpTos4LlsWsmwwNwtE0JJYDitiyLi5TD6LQwjoCvJUMiZryFjZaFy5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJaWxka/8tjQPo0YOPi9cYcg11p3WoC+zUU72nJjaj0=;
 b=0owYdF7Wl9wxZoSzl4gdCf/wWSXG60ht5pLz1UIhI9SoUe7AJ/bWoicj7Hcq0uajD1K2RcXqmpxeHk0AMisMPyXvWuyAGVLMiitZ/q22sVs/3Y8oeRKe8fIYqsSZ9ZrFlzOBf3G13Va2xlnGdhw84SLh+tHlMhgHooRh0SbgbsE=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 11:51:55 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::3e) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 11:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 11:51:54 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:51:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 04:51:53 -0700
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 06:51:52 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 01/13] drm/amdgpu: Indirect register access for Navi12 sriov
Date: Sat, 8 May 2021 19:51:33 +0800
Message-ID: <20210508115145.758-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c295e5dc-3c3f-495d-f348-08d91217ad49
X-MS-TrafficTypeDiagnostic: MW3PR12MB4425:
X-Microsoft-Antispam-PRVS: <MW3PR12MB442588357699A5C171494D56F8569@MW3PR12MB4425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LogmoRiSAd0FiepLzIg/y/eHVU+1oyiS1+m1+o/ImHF0z5Q5MThPacB47FSqDpu+kaVaMBf/BdJsEoY9B2UQksxgD+AuI9RYqHZKMvAOFdfGLCv6bpAP4B0NzuNz13vozeBePDmdipdRr2wiAqvCXBbHE2w0G0DMrcy4wnAczkTNOnr9fRvlZ/Z/gsHwKv4Cyo8RSbl5wvs377r2Rr45XZzMKRbufqOt+KmYSH7NYgZAUI5v6e33QIbe8yYOFgH5UhH7uuqavWMSHXuDmQYHZiLGJ2ShxUhrby076mg+lbS77FQqlpF7XgTL9nYzP3W5fPu93P2IlWNcl0fWsN8W1k8QwNzD0/hSp5V3Y/kvFNJLanaAc7Vqbqe/wRZJiJBowXmyf5nCpJNBTlsczKeW3RY92O6HaG66JrvETM6LceCqzP63mQlVDxNGesr6FYEz4TbthvumjQ/Wr5CF7XmMa8AxHJW/EopsEhGED/0PR+p2LljKP3mszc9mpCsW1c3SfVdwl0EWfzBLRFWFAWyOp9KFRkYJyZfstVTDM7Wmu1T5DjW+JCLvznu+xOfRm9GB4iGl/+haAFekoWksva4+G6rfVDuD+/LKSPKPJAD9teNNg8Br70SKBDSA9grcCG/mmrmLh3mxL4ptASk9ZyDHRUthny/qJQRMGr11lmjQH2EiUYLU2Bjl1N3OtVbEgEBR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(346002)(136003)(376002)(36840700001)(46966006)(7696005)(36860700001)(26005)(8936002)(82310400003)(36756003)(6666004)(2906002)(336012)(316002)(1076003)(30864003)(81166007)(8676002)(70586007)(478600001)(5660300002)(6916009)(47076005)(83380400001)(426003)(2616005)(356005)(70206006)(186003)(86362001)(4326008)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 11:51:54.8839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c295e5dc-3c3f-495d-f348-08d91217ad49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h   |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 78 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 87 +++++++++++++----------
 4 files changed, 91 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 125b25a5ce5b..c3c75c1f628f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1144,6 +1144,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
  * Registers read & write functions.
  */
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
+#define AMDGPU_REGS_RLC	(1<<2)
 
 #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
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
index 49fd10a15707..6603cc3466b8 100644
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
+		DRM_INFO("Not program register by RLCG\n");
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
