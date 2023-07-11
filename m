Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05BAEB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 14:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D45910E05A;
	Tue, 11 Jul 2023 14:19:35 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0408310E05A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 14:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWI2wS7yNMvnmnd2JBeVg7OZjpcssHS/edyCDmPI/LubSEOhjjEXVFlYLld43zWn+gpPM8B2ki13kWSZ2e178G4GZbe2pyrOzqu7ZXVuWgm8JM2XitjeBwTluYEJizKhJqJS4Ii0c0oClRoY2fgWugRr+0+6w8VgZzqu4YDS91g1SyGVtu01Yisag76062yYMrDEICbJ9WWbQbEz7Dfr+lRShZusEyPMs+VI/O09/S5aQmHBz8s+F2hMPKxcgzTUDdpXJ2AX4btocegftwDR/QaVCmizj+Ql8S3D3rARpmeow9cxCE46y7b7s39XkJZlzHRyT5g+I/2AUHAERcuUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8A1GR+zt68KU4cdh4xVdHDQzzzRAbdRv/datdK8oDSk=;
 b=Fwr0rMj0Rf+3OB6PK89pvqKg8Xf7c2t5G5UQgnAHhDcheBt3CVvlWyUBMsoDsE35xuRSQb2fwmXCn2//w4dcTUk17gSNXnNdmkewp5r5WD46PCMurQuHW9cRKqf+3AZ1roMN0ReRqEG8BOpqFtG5a0MNHfUc8qcXLmkWrq+jd+995SM9/8FCbVcZLO53+Bw/3bQcvxDcOS7PgdPQoPF34mLE2WpmY9cvZZDlfU88/1ppwilQJI+N/AUPd5IKD9kXSU7C1FEVL3BX0IxuYwJe27gHEninoTSYOuNZLEXGKHLYFbULcu6X6J+mgcje+eH0LpYq6Ui8MrsijKLj5e9MHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8A1GR+zt68KU4cdh4xVdHDQzzzRAbdRv/datdK8oDSk=;
 b=cPcPQXKrksP01bMgr7pYEvSYNlhoxL6hxE+JVZ/nkKGVm7V2SvAqZL54w3bVFoR2Cfk8w0CqTLfJBjhVXZ++VMRxf9oHLoBIq2thtIwOKvdirdpVU2RkONeHyFxAkP6tXmAkhFJKn8yRmFBkGqVctSGqzB56QD+e/7qD5BfmnVw=
Received: from DM6PR17CA0018.namprd17.prod.outlook.com (2603:10b6:5:1b3::31)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 14:19:27 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::b9) by DM6PR17CA0018.outlook.office365.com
 (2603:10b6:5:1b3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 14:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Tue, 11 Jul 2023 14:19:26 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 09:19:25 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Add RLCG interface driver implementation for
 gfx v9.4.3 (v3)
Date: Tue, 11 Jul 2023 10:17:34 -0400
Message-ID: <20230711141734.2033-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 154df6e8-19af-4083-1c9c-08db8219d538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joJtursl5Y07JjtURRVf0ayEbyKyes5KUgs/QQNRhSt07AcJcO5SNL0NO/nIzOJNk3XEuJDVwwvqB6srKpX0tPprJV8UYH+UtdDeIIu0MYzfIxpLdrsf0NicG6nGi4UgXJVoM7SYYE4z/6SA7rwLo3wBC39eNv+EKnMGeYaEu561Hdt8xYprLDazYbDrUrmwOXvC9kiSfo6XsI+W8Yh3TV8qPJhuqiJVIg1Y67KphXE5+c+xB20wB0hG6LU/4koOWI8gWldWLCQREpU1WNJfYV+ykP3TROS6OS5m7Dxa+fWNaTsiei/dWyMZ31dfSpBB0cZNdVnWkl4iPdFTxoPL5HGMTVibycgb47KuvkWrqFKzS2Tc7doC/Ou8rij1sB7Ve/y9hvRs7HRZlnwBsXMrt113D57OrUpRUHKnL+OpwzMImLpzx1IRnq9R+DU2Ip8q98ibonTsdfgPKoFxyWMcn9Pqzf8ti0b1oLhuwETqHajcXAFrCAaDnFcDHMH4Vyc4pWPojp6XAV5Vn05AH4eWJg+tpkfaKDjk7ayFKKu1BiNXNAkx+kVO7YT1PvlghlDLMY9TP2HCJEKnN/Wj3HhWZhLH3+cmfJ8aAvJvKNqtZWT3XvwoDikKB9AVQk7BCCL1Wb1WdqKOKL2G2dtRWr5nwFXoNbUk3DpBp9sd1lNJhCeNSqQZH+xeid9bjK3xH4lDgpAJUFiTGYvL9oUu/T63I14PCqIlpHYbqwYgX6FuiMh9l1G2DdKwfEvuBt+PdLGLf1XZPOMPuMA9YOmD7evOtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(478600001)(54906003)(186003)(1076003)(26005)(16526019)(70586007)(336012)(70206006)(30864003)(2906002)(82310400005)(41300700001)(6916009)(4326008)(316002)(5660300002)(8676002)(8936002)(356005)(82740400003)(81166007)(40460700003)(86362001)(36756003)(36860700001)(2616005)(47076005)(83380400001)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 14:19:26.5293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154df6e8-19af-4083-1c9c-08db8219d538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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
Cc: victor.skvortsov@amd.com, zhigang.luo@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add RLCG interface support for gfx v9.4.3 and multiple XCCs.
Do not enable it yet.

v2: Fix amdgpu_rlcg_reg_access_ctrl init, add support for multiple XCCs
    in amdgpu_mm_wreg_mmio_rlc

v3: Use GET_INST() when indexing amdgpu_rlcg_reg_access_ctrl

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
index b41d6ae35c8a..1cd417034860 100644
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
+		reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[GET_INST(GC, xcc_id)];
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

