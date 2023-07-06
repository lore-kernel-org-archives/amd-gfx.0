Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C65C001DD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 15:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB86D10E444;
	Thu,  6 Jul 2023 15:54:09 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C93DE10E444
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 15:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie+vCy+Wg7RkHPTg1XMC6j+VirPLghIMxrJBhp39MI65fXAq/mh6zygylAs+PGu9mZXvWsCfqmyk50pqVdflUNtAbz3noorkPWCxuLJJvKM7khCnQHm9HEHbak2iT5Gd3CBwn2hVYmXmBp+hVJnfenjpJ5+npnL9hXXIRyMUgk/Lacg+lxb4BUAF50014TAG++jF/e2bNhsFDDqKRxUYDpMtz5zOW8PaJaPm6VBRKMmEafdoN9bOPOPMvyiNJPU8lBaXPQaoKeXytHMG28Lm4jKg05/92nlqS3hC9BJxAxO9iGKPnaY2H8d97Py0Z0hsTdDG4DFxBdKYAES+TCpQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF1fKrhX6YdhwFwnoIelvCYcAYhlcK5V0XVBULiHMPk=;
 b=XCevagSvG766Zo2YjCNVuZtfR/S4+WMY7er98FRTorRP/8TNG3hs5j5U5MrMOEOGi22if4MZLp0WCOwMYItiA4TDv1REi7RkEhMQW0Dv0nWoh6pzJ5fijo8JgTmlJjFf4fw9n258o1OqgIv5sAQQ/6NMGZP+698ydePivgT8TNc46c2Tjll6lOiHZAYhqulOjIvu0A/LbH8H1Z0WcNORQsgaDvNG8WX3lHi+tC91dgEISUcd203WOxi6Rs1G5x8++Y+SH8dfAenNqLUxH+9/CizyvSkcLhJ9G3PTCWhTtE7cA5AXrMgWlugaOG8m1tXM4zPD7EF1foAG1nDkEh+VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF1fKrhX6YdhwFwnoIelvCYcAYhlcK5V0XVBULiHMPk=;
 b=cuTeApmTdzZClluxhfX4/+TXJFGxQlNo9KVmnbp81tJ1KH+/47r8AnWQ+GC5aSO4noyT0n3eCLfAiOsjXw3ianyez124azYQTfU3W8lLFMWVxm11EOYg1iR0DtyMqgSJLb8Li/hTotrDsHHIJQZlRNJ0h4pjlE9NSRMMwBYO/Uk=
Received: from BN0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:408:e6::11)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 15:54:03 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::23) by BN0PR03CA0006.outlook.office365.com
 (2603:10b6:408:e6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 15:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Thu, 6 Jul 2023 15:54:03 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 10:54:02 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Add RLCG interface driver implementation for
 gfx v9.4.3 (v2)
Date: Thu, 6 Jul 2023 11:53:51 -0400
Message-ID: <20230706155351.522544-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|BL1PR12MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: a8776dc5-137b-4f4f-a3e0-08db7e3938c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffib4KCK6X+LPESxYaMQxuk53yEbiiiAj2Mf/lME0NYJkN1JmhFMlzPhIZkaV0hWXUiK2jLJmBi2RCwxpl5IXdxMLPz3+9DwFJPaSrfed0JrybH3FudeIlGS3/h+/kNvpMD+EyIlClC+ylcdFm7HiH0S+8p3KWSiy02IE67pryri/UfuezJQchn+uluF23H4H2ONo10VP4UpQwGv4nUMsNK1cDTRH1zSA3tAq6XVTL69867gXjDbVmkZDhEIbxPTGQvlbkZF/IQ3e+IoAzoAYJXVz3QnHf6gZ+SWOdw7kfnsjVo9OrSw4HdaJgZ/kEn4Y98lcUrW7GNaXnNEwxCDXvBc9tY/lbdDuIzy8KdQFSIVxtAcl1hOVKQ/mO4QdwFe/fm+/ZO0xuWfYksxyoOj/0NsOlvSbbDhnN+qSJvlK5Kr8kk3rOZfIns9xDhHS10Fr0ggEGXWis4rSfY8zLLueyQyNzU/7Bzvsk7Fdt7S3hOlU+ZZ62V9JRUhrRUDFUyD7ID7PwNxJNmQweHrizi4AsPrSY8hgLM/svrZ0vnzyA7Teo+e9ARbNywlW+3PWPA5NglCbvIDW6InCbnv/F0s6sTjnOsJ/+uIQVteOi10Ljgh2Ja0pdoi7mNNak0Gi+yVXqwNVsLComAxMP9RELLsPjjNQvtQ9JWlP/sq1XhGrlMi6hx8hlerfpR1/KbcUEVyGgavWdh9otzo1pBg5g4agC1E1L6O1HQvgJhR/gkfZhAQMnX9FisyWi8R+qwrVMD9aX0bq2R9JsRds4KVrm0w2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(8936002)(8676002)(54906003)(2906002)(70206006)(70586007)(478600001)(6916009)(4326008)(316002)(7696005)(5660300002)(41300700001)(186003)(26005)(1076003)(16526019)(336012)(2616005)(36860700001)(83380400001)(426003)(47076005)(30864003)(6666004)(356005)(81166007)(82740400003)(82310400005)(86362001)(40480700001)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 15:54:03.3522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8776dc5-137b-4f4f-a3e0-08db7e3938c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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
Cc: victor.skvortsov@amd.com, zhigang.luo@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add RLCG interface support for gfx v9.4.3 and multiple XCCs.
Do not enable it yet.

v2: Fix amdgpu_rlcg_reg_access_ctrl init, add support for multiple XCCs
    in amdgpu_mm_wreg_mmio_rlc

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h     |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 17 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     | 22 +++++++
 drivers/gpu/drm/amd/amdgpu/soc15_common.h   | 66 ++++++++++-----------
 11 files changed, 81 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c578e07fd90a..a6647a1d13e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1182,7 +1182,7 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
 				 u32 pcie_index, u32 pcie_index_hi,
 				 u32 pcie_data, u64 reg_addr, u32 reg_data);
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
-			     uint32_t reg, uint32_t v);
+			     uint32_t reg, uint32_t v, uint32_t xcc_id);
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
 uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 241d8c5da273..fc77bea72db7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -173,7 +173,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 		} else {
 			r = get_user(value, (uint32_t *)buf);
 			if (!r)
-				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value);
+				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value, 0);
 		}
 		if (r) {
 			result = r;
@@ -301,7 +301,7 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 		} else {
 			r = get_user(value, (uint32_t *)buf);
 			if (!r)
-				amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value);
+				amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value, rd->id.xcc_id);
 		}
 		if (r) {
 			result = r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 45b335c766fd..abc56085b136 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -586,7 +586,8 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
  * this function is invoked only for the debugfs register access
  */
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
-			     uint32_t reg, uint32_t v)
+			     uint32_t reg, uint32_t v,
+			     uint32_t xcc_id)
 {
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
@@ -595,7 +596,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return amdgpu_sriov_wreg(adev, reg, v, 0, 0);
+			return amdgpu_sriov_wreg(adev, reg, v, 0, 0, xcc_id);
 	} else if ((reg * 4) >= adev->rmmio_size) {
 		adev->pcie_wreg(adev, reg * 4, v);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 80b263646966..b591d33af264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -26,6 +26,8 @@
 
 #include "clearstate_defs.h"
 
+#define AMDGPU_MAX_RLC_INSTANCES	8
+
 /* firmware ID used in rlc toc */
 typedef enum _FIRMWARE_ID_ {
 	FIRMWARE_ID_INVALID					= 0,
@@ -201,7 +203,7 @@ struct amdgpu_rlc {
 	u32                     cp_table_size;
 
 	/* safe mode for updating CG/PG state */
-	bool in_safe_mode[8];
+	bool in_safe_mode[AMDGPU_MAX_RLC_INSTANCES];
 	const struct amdgpu_rlc_funcs *funcs;
 
 	/* for firmware data */
@@ -257,7 +259,7 @@ struct amdgpu_rlc {
 
 	bool rlcg_reg_access_supported;
 	/* registers for rlcg indirect reg access */
-	struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl;
+	struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl[AMDGPU_MAX_RLC_INSTANCES];
 };
 
 void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 5731829964c2..b5c6c7435551 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -960,7 +960,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 	return ret;
 }
 
-static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 	uint32_t timeout = 50000;
@@ -978,7 +978,12 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 		return 0;
 	}
 
-	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
+	if (adev->gfx.xcc_mask && (((1 << xcc_id) & adev->gfx.xcc_mask) == 0)) {
+		dev_err(adev->dev, "invalid xcc\n");
+		return 0;
+	}
+
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[xcc_id];
 	scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
 	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
@@ -1043,13 +1048,13 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 
 void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 		       u32 offset, u32 value,
-		       u32 acc_flags, u32 hwip)
+		       u32 acc_flags, u32 hwip, u32 xcc_id)
 {
 	u32 rlcg_flag;
 
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
-		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag);
+		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc_id);
 		return;
 	}
 
@@ -1060,13 +1065,13 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 }
 
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
-		      u32 offset, u32 acc_flags, u32 hwip)
+		      u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id)
 {
 	u32 rlcg_flag;
 
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
-		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);
+		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, xcc_id);
 
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		return RREG32_NO_KIQ(offset);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 4f7bab52282a..d1f7509a44cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -355,9 +355,9 @@ void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size);
 void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 		       u32 offset, u32 value,
-		       u32 acc_flags, u32 hwip);
+		       u32 acc_flags, u32 hwip, u32 xcc_id);
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
-		      u32 offset, u32 acc_flags, u32 hwip);
+		      u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id);
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
 			uint32_t ucode_id);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c8291711dba3..7a1e7e3db2cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4151,7 +4151,7 @@ static void gfx_v10_0_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 
-	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[0];
 	reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
 	reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG1);
 	reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a9f008d0d5ab..f5b52d239eb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -645,7 +645,7 @@ static void gfx_v11_0_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 
-	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[0];
 	reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
 	reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG1);
 	reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index de9a5c67e241..ebdc0f9200f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1636,7 +1636,7 @@ static void gfx_v9_0_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 
-	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[0];
 	reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
 	reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG1);
 	reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b41d6ae35c8a..2503ddee85b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1126,6 +1126,25 @@ static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SAFE_MODE, data);
 }
 
+static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
+{
+	int xcc_id;
+	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
+
+	for (xcc_id = 0; xcc_id < AMDGPU_MAX_RLC_INSTANCES; xcc_id++) {
+		if (((1 << xcc_id) & adev->gfx.xcc_mask) == 0)
+			continue;
+		reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[xcc_id];
+		reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG0);
+		reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG1);
+		reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG2);
+		reg_access_ctrl->scratch_reg3 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG3);
+		reg_access_ctrl->grbm_cntl = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_CNTL);
+		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX);
+		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPARE_INT);
+	}
+}
+
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
 	/* init spm vmid with 0xf */
@@ -2319,6 +2338,9 @@ static int gfx_v9_4_3_early_init(void *handle)
 			gfx_v9_4_3_xcc_rlc_smu_handshake_cntl(adev, false, i);
 	}
 
+	/* init rlcg reg access ctrl */
+	gfx_v9_4_3_init_rlcg_reg_access_ctrl(adev);
+
 	return gfx_v9_4_3_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 96948a59f8dd..da683afa0222 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -37,65 +37,65 @@
 #define SOC15_REG_OFFSET1(ip, inst, reg, offset) \
 	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)+(offset))
 
-#define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
+#define __WREG32_SOC15_RLC__(reg, value, flag, hwip, inst) \
 	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
-	 amdgpu_sriov_wreg(adev, reg, value, flag, hwip) : \
+	 amdgpu_sriov_wreg(adev, reg, value, flag, hwip, inst) : \
 	 WREG32(reg, value))
 
-#define __RREG32_SOC15_RLC__(reg, flag, hwip) \
+#define __RREG32_SOC15_RLC__(reg, flag, hwip, inst) \
 	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
-	 amdgpu_sriov_rreg(adev, reg, flag, hwip) : \
+	 amdgpu_sriov_rreg(adev, reg, flag, hwip, inst) : \
 	 RREG32(reg))
 
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
 	 __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
 				(__RREG32_SOC15_RLC__( \
 					adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
-					0, ip##_HWIP) & \
+					0, ip##_HWIP, idx) & \
 				~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
-			      0, ip##_HWIP)
+			      0, ip##_HWIP, idx)
 
 #define WREG32_FIELD15_PREREG(ip, idx, reg_name, field, val)        \
 	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][reg##reg_name##_BASE_IDX] + reg##reg_name,   \
 			(__RREG32_SOC15_RLC__( \
 					adev->reg_offset[ip##_HWIP][idx][reg##reg_name##_BASE_IDX] + reg##reg_name, \
-					0, ip##_HWIP) & \
+					0, ip##_HWIP, idx) & \
 					~REG_FIELD_MASK(reg_name, field)) | (val) << REG_FIELD_SHIFT(reg_name, field), \
-			0, ip##_HWIP)
+			0, ip##_HWIP, idx)
 
 #define RREG32_SOC15(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
-			 0, ip##_HWIP)
+			 0, ip##_HWIP, inst)
 
-#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP)
+#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP, 0)
 
-#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
 
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
-			 AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+			 AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
 
 #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
 	 __RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)) + \
-			 (offset), 0, ip##_HWIP)
+			 (offset), 0, ip##_HWIP, inst)
 
 #define WREG32_SOC15(ip, inst, reg, value) \
 	 __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
-			  value, 0, ip##_HWIP)
+			  value, 0, ip##_HWIP, inst)
 
 #define WREG32_SOC15_IP(ip, reg, value) \
-	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)
+	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP, 0)
 
 #define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
-	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
 
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
 	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
-			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
 
 #define WREG32_SOC15_OFFSET(ip, inst, reg, offset, value) \
 	 __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, \
-			  value, 0, ip##_HWIP)
+			  value, 0, ip##_HWIP, inst)
 
 #define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask)      \
 	amdgpu_device_wait_on_rreg(adev, inst,                       \
@@ -108,16 +108,16 @@
 	#reg, expected_value, mask)
 
 #define WREG32_RLC(reg, value) \
-	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP)
+	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP, 0)
 
-#define WREG32_RLC_EX(prefix, reg, value) \
+#define WREG32_RLC_EX(prefix, reg, value, inst) \
 	do {							\
 		if (amdgpu_sriov_fullaccess(adev)) {    \
 			uint32_t i = 0;	\
 			uint32_t retries = 50000;	\
-			uint32_t r0 = adev->reg_offset[GC_HWIP][0][prefix##SCRATCH_REG0_BASE_IDX] + prefix##SCRATCH_REG0;	\
-			uint32_t r1 = adev->reg_offset[GC_HWIP][0][prefix##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG1;	\
-			uint32_t spare_int = adev->reg_offset[GC_HWIP][0][prefix##RLC_SPARE_INT_BASE_IDX] + prefix##RLC_SPARE_INT;	\
+			uint32_t r0 = adev->reg_offset[GC_HWIP][inst][prefix##SCRATCH_REG0_BASE_IDX] + prefix##SCRATCH_REG0;	\
+			uint32_t r1 = adev->reg_offset[GC_HWIP][inst][prefix##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG1;	\
+			uint32_t spare_int = adev->reg_offset[GC_HWIP][inst][prefix##RLC_SPARE_INT_BASE_IDX] + prefix##RLC_SPARE_INT;	\
 			WREG32(r0, value);	\
 			WREG32(r1, (reg | 0x80000000));	\
 			WREG32(spare_int, 0x1);	\
@@ -136,17 +136,17 @@
 
 /* shadow the registers in the callback function */
 #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
-	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value, AMDGPU_REGS_RLC, GC_HWIP)
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value, AMDGPU_REGS_RLC, GC_HWIP, inst)
 
 /* for GC only */
 #define RREG32_RLC(reg) \
 	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
 
 #define WREG32_RLC_NO_KIQ(reg, value, hwip) \
-	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip)
+	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip, 0)
 
 #define RREG32_RLC_NO_KIQ(reg, hwip) \
-	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip)
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip, 0)
 
 #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
 	do {							\
@@ -167,32 +167,32 @@
 	} while (0)
 
 #define RREG32_SOC15_RLC(ip, inst, reg) \
-	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, AMDGPU_REGS_RLC, ip##_HWIP)
+	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, AMDGPU_REGS_RLC, ip##_HWIP, inst)
 
 #define WREG32_SOC15_RLC(ip, inst, reg, value) \
 	do {							\
 		uint32_t target_reg = adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\
-		__WREG32_SOC15_RLC__(target_reg, value, AMDGPU_REGS_RLC, ip##_HWIP); \
+		__WREG32_SOC15_RLC__(target_reg, value, AMDGPU_REGS_RLC, ip##_HWIP, inst); \
 	} while (0)
 
 #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \
 	do {							\
 			uint32_t target_reg = adev->reg_offset[GC_HWIP][inst][reg##_BASE_IDX] + reg;\
-			WREG32_RLC_EX(prefix, target_reg, value); \
+			WREG32_RLC_EX(prefix, target_reg, value, inst); \
 	} while (0)
 
 #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
 	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
 			     (__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
-						   AMDGPU_REGS_RLC, ip##_HWIP) & \
+						   AMDGPU_REGS_RLC, ip##_HWIP, idx) & \
 			      ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
-			     AMDGPU_REGS_RLC, ip##_HWIP)
+			     AMDGPU_REGS_RLC, ip##_HWIP, idx)
 
 #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
-	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP)
+	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP, inst)
 
 #define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
-	__RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP)
+	__RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP, inst)
 
 /* inst equals to ext for some IPs */
 #define RREG32_SOC15_EXT(ip, inst, reg, ext) \
-- 
2.34.1

