Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B6FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 11:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DE610E63B;
	Thu, 20 Jan 2022 11:19:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD7910E5F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOsASqE7i4JrcVhKdF1RJb62ctULXLlfZAQhWr0t1PS6W+dGXDsGi4//Q3QJ78JbvSsMOAdqKJr0Ggcv6WRDkx1+HJ+VZ8Gm1D1u5DW/Iq96/17KcJ31TmvRpOiWKAY0Tc8pkYxOc+AxR/zK6s5rSM3ia1nN2orPWNwtBuWasrosk3Z1BqQYwACFEU9l/VdBq4U/RYSYqcEUCkBuiY1ddmPatiig+Kwnumqqe9hg5oQMhYe2NoGoZN73SEHulwiYgjrUd3JEM7wqHSLpYB+HiPRgenjoMTwC9RhXuPi+s7N1knmXVvrVeI3z9Codqxkf1cMJRp8FTqVrqHqugX8YHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k1jrfaYIdPx7nnL1vvgyXH7eVJ8GcwVRT/47Z/FkEA=;
 b=Jvoh6zIy6jiHBb30vy8AWgK5pS/N/Era0ZfRIxoK+nmWBuJm7bhyUoTjci8Cvi3diIRE0bGvsh561MaKTY+wxAXdNWqJtkC/0fr7NQiGcTTr8c7wGU3AzUFds4GXDAEPY1j5WKCOUvqo6/FpJpPC7Tq4H2VkF+aMjV5JEXlZ9tWVfxGgEaY2heVycbilTksjpF8X2UJhg9q4qhZjo/0WDtVTnfG2dBBPy4Qf0bS935t63hSudTD9R0h7jyY41iqg0nV8/5La1DsefcVlVVs2U69nkoGlro2KE2XTMBfstkbAkMRV4OXViB47NbZ1YTeKj9Ur776YToCOYgEVX/vtpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k1jrfaYIdPx7nnL1vvgyXH7eVJ8GcwVRT/47Z/FkEA=;
 b=S/kJutnQTEFMgYqeTt+YUlVsGlcPZ9jY8sUZVZnEW7g0jkLmZxpqGloqR+kKUFR+5VkkCsPAkiyt0wf28tFaZue97GjZdJWOrpMdTMjCQbHtF1zPfCc9l6snIA34AFHLOF48Akd1UzNBzOACAheXHhYsk2GWjdG7bsy/8O+VZXY=
Received: from MWHPR18CA0061.namprd18.prod.outlook.com (2603:10b6:300:39::23)
 by DM5PR12MB1196.namprd12.prod.outlook.com (2603:10b6:3:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 11:19:13 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::c1) by MWHPR18CA0061.outlook.office365.com
 (2603:10b6:300:39::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Thu, 20 Jan 2022 11:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 11:19:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:12 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.18 via Frontend Transport; Thu, 20 Jan 2022 05:19:11
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/9] drm/amdgpu: add helper for rlcg indirect reg access
Date: Thu, 20 Jan 2022 19:18:51 +0800
Message-ID: <20220120111853.11674-7-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120111853.11674-1-Hawking.Zhang@amd.com>
References: <20220120111853.11674-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dbf8e6b-90fa-4605-b308-08d9dc06b045
X-MS-TrafficTypeDiagnostic: DM5PR12MB1196:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1196E91B210A7687DD7E477FFC5A9@DM5PR12MB1196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DlES7HgPfIL6L/aBIdHC/2AjQCTtv93D+4KGwQ4DvhGTTggrzISzcTvaDMLGrA0tMBr1M6/xOh0SM5+g2DDvaW5zIlVHLqDmzaHDS8lE3V2ctrAvCyFIjBVkWN9WTViHxfIzHlHBRLBK1gmdr8YWnsFjHqoAmMzTLp62sG4PeGwdkGU1gNXjhzsvCeq5g1/1mqIS7W+Aa1KxMhOvH2xlkJ1kOc7n0VBRJ8hOqYcgRkuwRO0DLf6rmyVRn5jDLlx92QdQ8dm2j99WWR1uiVGTJprUXgl59b6jySIMacxie5HmSqZQZjUldV19A/6g99LQhA7uLMgREeilVxtJ775bf8SflmPKHoy/WHFKazV/+FyfpYStTdBg11kbeSfp32yFtM3joXL2SBBNKYCOsoSpfy60f3+E8T66rHKYz53JtQJfBxDx9OPb0E09sHAZP3YGYPhFOqz+wj2XmGIfZhygc5wGWZAlzIMSJH7x3lFT+Zj9szMw8VsykfPkQ9dm5BWLNRvzt6lAjmffvSSdDpkKPLyuhzXbEvUG2qHPogT20NWZuAIgjkOrlymZkjfTmtgTBUqrGPzPZKuRfw1WXQaop7BpjbslQePFeLkxIi0TudOFZXi5uFIXNDu1vzIm/DsT33LoDRDRNJ1hSKRrJuh9IFRubOHlN52A5tzxCCatCu43v3cOBxDy63RHdVDlJ9/0Fc0BwEaqjhw8ow/YSND84mUd5qPeAk6lZNp3jjaTjPYeLFGk6+Wl2/XiHl1fTBlujFYd9OQbdyl326dwdu96Bhiqa0bRPZOZYIwk4L/89s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(508600001)(186003)(82310400004)(81166007)(36860700001)(356005)(1076003)(40460700001)(86362001)(47076005)(110136005)(6666004)(36756003)(2906002)(316002)(5660300002)(70586007)(26005)(426003)(6636002)(70206006)(7696005)(66574015)(336012)(83380400001)(4326008)(8676002)(2616005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 11:19:13.3345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbf8e6b-90fa-4605-b308-08d9dc06b045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1196
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

The helper will be used to access registers from sriov
guest in full access time

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 111 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  14 ++-
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a40e4fcdfa46..8c27d31f3e53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -855,3 +855,114 @@ bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev, u32 acc_fl
 	}
 	return ret;
 }
+
+static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+{
+	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
+	uint32_t timeout = 50000;
+	uint32_t i, tmp;
+	uint32_t ret = 0;
+	static void *scratch_reg0;
+	static void *scratch_reg1;
+	static void *scratch_reg2;
+	static void *scratch_reg3;
+	static void *spare_int;
+
+	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
+		dev_err(adev->dev,
+			"indirect registers access through rlcg is not available\n");
+		return 0;
+	}
+
+	scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
+	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
+	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
+	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
+	if (reg_access_ctrl->spare_int)
+		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
+
+	if (offset == reg_access_ctrl->grbm_cntl) {
+		/* if the target reg offset is grbm_cntl, write to scratch_reg2 */
+		writel(v, scratch_reg2);
+		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
+	} else if (offset == reg_access_ctrl->grbm_idx) {
+		/* if the target reg offset is grbm_idx, write to scratch_reg3 */
+		writel(v, scratch_reg3);
+		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
+	} else {
+		/*
+		 * SCRATCH_REG0 	= read/write value
+		 * SCRATCH_REG1[30:28]	= command
+		 * SCRATCH_REG1[19:0]	= address in dword
+		 * SCRATCH_REG1[26:24]	= Error reporting
+		 */
+		writel(v, scratch_reg0);
+		writel((offset | flag), scratch_reg1);
+		if (reg_access_ctrl->spare_int)
+			writel(1, spare_int);
+
+		for (i = 0; i < timeout; i++) {
+			tmp = readl(scratch_reg1);
+			if (!(tmp & flag))
+				break;
+			udelay(10);
+		}
+
+		if (i >= timeout) {
+			if (amdgpu_sriov_rlcg_error_report_enabled(adev)) {
+				if (tmp & AMDGPU_RLCG_VFGATE_DISABLED) {
+					dev_err(adev->dev,
+						"vfgate is disabled, rlcg failed to program reg: 0x%05x\n", offset);
+				} else if (tmp & AMDGPU_RLCG_WRONG_OPERATION_TYPE) {
+					dev_err(adev->dev,
+						"wrong operation type, rlcg failed to program reg: 0x%05x\n", offset);
+				} else if (tmp & AMDGPU_RLCG_REG_NOT_IN_RANGE) {
+					dev_err(adev->dev,
+						"regiser is not in range, rlcg failed to program reg: 0x%05x\n", offset);
+				} else {
+					dev_err(adev->dev,
+						"unknown error type, rlcg failed to program reg: 0x%05x\n", offset);
+				}
+			} else {
+				dev_err(adev->dev,
+					"timeout: rlcg faled to program reg: 0x%05x\n", offset);
+			}
+		}
+	}
+
+	ret = readl(scratch_reg0);
+	return ret;
+}
+
+void amdgpu_sriov_wreg(struct amdgpu_device *adev,
+		       u32 offset, u32 value,
+		       u32 acc_flags, u32 hwip)
+{
+	u32 rlcg_flag;
+
+	if (!amdgpu_sriov_runtime(adev) &&
+	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
+		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag);
+		return;
+	}
+
+	if (acc_flags & AMDGPU_REGS_NO_KIQ)
+		WREG32_NO_KIQ(offset, value);
+	else
+		WREG32(offset, value);
+}
+
+u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
+		      u32 offset, u32 acc_flags, u32 hwip)
+{
+	u32 rlcg_flag;
+
+	if (!amdgpu_sriov_runtime(adev) &&
+	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
+		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);
+
+	if (acc_flags & AMDGPU_REGS_NO_KIQ)
+		return RREG32_NO_KIQ(offset);
+	else
+		return RREG32(offset);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 404a06e57f30..dbfa3ba445c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -38,6 +38,11 @@
 #define AMDGPU_RLCG_GC_READ            (0x1 << 28)
 #define AMDGPU_RLCG_MMHUB_WRITE        (0x2 << 28)
 
+/* error code for indirect register access path supported by rlcg for sriov */
+#define AMDGPU_RLCG_VFGATE_DISABLED		0x4000000
+#define AMDGPU_RLCG_WRONG_OPERATION_TYPE	0x2000000
+#define AMDGPU_RLCG_REG_NOT_IN_RANGE		0x1000000
+
 /* all asic after AI use this offset */
 #define mmRCC_IOV_FUNC_IDENTIFIER 0xDE5
 /* tonga/fiji use this offset */
@@ -281,6 +286,9 @@ struct amdgpu_video_codec_info;
 (amdgpu_sriov_vf((adev)) && \
 	((adev)->virt.reg_access & (AMDGIM_FEATURE_GC_REG_RLC_EN)))
 
+#define amdgpu_sriov_rlcg_error_report_enabled(adev) \
+        (amdgpu_sriov_reg_indirect_mmhub(adev) || amdgpu_sriov_reg_indirect_gc(adev))
+
 #define amdgpu_passthrough(adev) \
 ((adev)->virt.caps & AMDGPU_PASSTHROUGH_MODE)
 
@@ -299,7 +307,6 @@ static inline bool is_virtual_machine(void)
 	((!amdgpu_in_reset(adev)) && adev->virt.tdr_debug)
 #define amdgpu_sriov_is_normal(adev) \
 	((!amdgpu_in_reset(adev)) && (!adev->virt.tdr_debug))
-
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
@@ -329,4 +336,9 @@ void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size);
 bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev, u32 acc_flags,
 					  u32 hwip, bool write, u32 *rlcg_flag);
+void amdgpu_sriov_wreg(struct amdgpu_device *adev,
+		       u32 offset, u32 value,
+		       u32 acc_flags, u32 hwip);
+u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
+		      u32 offset, u32 acc_flags, u32 hwip);
 #endif
-- 
2.17.1

