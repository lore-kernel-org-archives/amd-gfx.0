Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B61BC54E49
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 14:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98E5112B4D;
	Tue,  5 Mar 2024 14:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zfj1ORJb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80BE112B4C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 14:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpqDrgNfZsBIERHUkFlp+aKFry3yh3XkMeheLs4rawh3E+Ukxd//CoH/ZYg7FN2pimIhRwguUsm5zr+syqqFbblZ5QQ0uMFH5LnRleaUyij70U9NUVAqazJMcwRM76So0YDVrHcoQ1/yTkmbLSlLFmDcUQu4Uo7OeA2lfRlGQDagZAaYvIQsN7fDk2oVb7v50jo0DxIcWg7kBm+/U7i9wrJuTzKJwZ4tUeb6awmlbpQV1A6DT06J9By4d7hwo33CgnnVkMMf3o28g+i5Q1ZaIWuhL5NuYSfQWYasp4JKfT4Nk0MsutZ0mLQHQZDBlsS0XzUVghwpwHYpCoa8Q8WEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z8A7fn8JtxyUPgmKzR4pV3Od/c4XO60blE09EhigAs=;
 b=HJEQ/osKtbn/vFycsOvrj3XRZY4FNabw7PBe0Q/iXscySi5KZx9pZyh8nZzsMFXqOrVaDJOwhbMxtbwInrlhAs5W20ksSn/hT3XbQin0wKRE1ujg0rFdut0WU7c515D9m4mud6GcDo7k8eIxem/1KyImPOwZLzJNKavnY97W0vrV5WabbJhj6uaEpcD5jh04Gf+pBf16tN6BMwA7BCdA/VZ2BCjDrCjmdk/HLoP68XJIbhqL5bvBbcbz13dR3BxUB9lW+DgW9LOBIDmWA2Rv39trtw3ESKGpujM/jJW4UICPs+yrWQQok2QN3qcM6viUVg8Cfib4gms826Wa7iEKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z8A7fn8JtxyUPgmKzR4pV3Od/c4XO60blE09EhigAs=;
 b=Zfj1ORJbBhXwLcZDo0/tCZvswPhD9rDQrLlzsDlsA2iJWVPhM70Tb6wvVsoQZYOBbVMbGC6Hp7edOuFamxl7xRHYHBPdJhHMzGwoqykloXg9NlrgA56nhaslkgERTmM5w5rDsmbaRzufpNxdmHgdpXoH0sUDZFp4kUeGDnvOTxo=
Received: from BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 14:31:21 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::ab) by BYAPR05CA0062.outlook.office365.com
 (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 14:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 14:31:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 08:31:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lang Yu <Lang.Yu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/vpe: add VPE 6.1.1 support
Date: Tue, 5 Mar 2024 09:30:52 -0500
Message-ID: <20240305143053.1262593-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305143053.1262593-1-alexander.deucher@amd.com>
References: <20240305143053.1262593-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 536842bc-ceb4-40f3-a056-08dc3d20ed5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NklG+mPQHOl4JjQhU66vG79wjhMtShKfxWg94O3BE9R9n5uACwyXUHW2Ak7Pj8rDuYAezGaU6nRw3Knmu90G+FQFaO71LLLD+2S4CkGT6sqoAVJQTlaJObiHx+/apGHzTuF5yc+It7TSp8IW+3QouUdnYnPi4knXSi66Nxls1Idpl++4rX/6fhyPe+hHwu8xmfRMIl224zqZ3qZEXzYlwiDpl63rf1dg456me6IykVIUh4SkKtOpw3teoARzRywnmhiE0DTZROfbHOeJdSpuGNArTP8Z3EYYdeDZ31OZa7Fw27UCC1QOF/VxN4bIQWfQUQCBWVhUUwnsoHYijD9AD1Ungirpp8tbNKSsq+dXeLvCWJ9skEJgb8Msvee6vReHMzffrUFaL9AA4bht6yGgLQ65WgsUY545ciWprn0dRMcap4nZQTw5lwwEHmtpCs6yu1WtVfiWn4xhqainmcebckin+jJHN4PoePbHeNbdswK23hX00UpHQZ4fwq6hLmP/xnoB32Cfd6c1wbpeoOB0doTWdyCc+eczHkX51hD4xbLA5DJZAgDtP6z/Q3pqdp4IXNC0k9NW6+QjgJykIOGNz2DYCWnMygippBgNMTLVbQSzBzGneRjWuFD6yHFCkpo53rMiD7A2p9/YS3+b3NYgH8xNJUkSH06pPDUMffdZtvEs5QxpzmCCnXEaMfufoXq7+sMxGZ6ZOewPrHgq+ToA5mWb+YL71FIxp5ybi50o37dbBb6IEGS79SCemhPUkfq3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:31:20.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 536842bc-ceb4-40f3-a056-08dc3d20ed5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add initial support for VPE 6.1.1.

v2: squash in updates (Alex)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c |  32 ++-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c   | 281 ++++++++++++++++--------
 2 files changed, 207 insertions(+), 106 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index eea2487d2ea24..70c5cc80ecdc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -297,6 +297,10 @@ static int vpe_early_init(void *handle)
 	case IP_VERSION(6, 1, 0):
 		vpe_v6_1_set_funcs(vpe);
 		break;
+	case IP_VERSION(6, 1, 1):
+		vpe_v6_1_set_funcs(vpe);
+		vpe->collaborate_mode = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -304,6 +308,8 @@ static int vpe_early_init(void *handle)
 	vpe_set_ring_funcs(adev);
 	vpe_set_regs(vpe);
 
+	dev_info(adev->dev, "VPE: collaborate mode %s", vpe->collaborate_mode ? "true" : "false");
+
 	return 0;
 }
 
@@ -493,8 +499,6 @@ static void vpe_ring_emit_fence(struct amdgpu_ring *ring, uint64_t addr,
 {
 	int i = 0;
 
-	vpe_ring_emit_pred_exec(ring, 0, 10);
-
 	do {
 		/* write the fence */
 		amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0));
@@ -705,16 +709,22 @@ static void vpe_ring_set_wptr(struct amdgpu_ring *ring)
 			upper_32_bits(ring->wptr << 2));
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		if (vpe->collaborate_mode)
+			WDOORBELL64(ring->doorbell_index + 4, ring->wptr << 2);
 	} else {
-		dev_dbg(adev->dev, "Not using doorbell, \
-			regVPEC_QUEUE0_RB_WPTR == 0x%08x, \
-			regVPEC_QUEUE0_RB_WPTR_HI == 0x%08x\n",
-			lower_32_bits(ring->wptr << 2),
-			upper_32_bits(ring->wptr << 2));
-		WREG32(vpe_get_reg_offset(vpe, ring->me, vpe->regs.queue0_rb_wptr_lo),
-		       lower_32_bits(ring->wptr << 2));
-		WREG32(vpe_get_reg_offset(vpe, ring->me, vpe->regs.queue0_rb_wptr_hi),
-		       upper_32_bits(ring->wptr << 2));
+		int i;
+
+		for (i = 0; i < vpe->num_instances; i++) {
+			dev_dbg(adev->dev, "Not using doorbell, \
+				regVPEC_QUEUE0_RB_WPTR == 0x%08x, \
+				regVPEC_QUEUE0_RB_WPTR_HI == 0x%08x\n",
+				lower_32_bits(ring->wptr << 2),
+				upper_32_bits(ring->wptr << 2));
+			WREG32(vpe_get_reg_offset(vpe, i, vpe->regs.queue0_rb_wptr_lo),
+			       lower_32_bits(ring->wptr << 2));
+			WREG32(vpe_get_reg_offset(vpe, i, vpe->regs.queue0_rb_wptr_hi),
+			       upper_32_bits(ring->wptr << 2));
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
index d20060a51e052..769eb8f7bb3c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -33,14 +33,38 @@
 #include "vpe/vpe_6_1_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/vpe_6_1_0.bin");
+MODULE_FIRMWARE("amdgpu/vpe_6_1_1.bin");
 
 #define VPE_THREAD1_UCODE_OFFSET	0x8000
 
+#define regVPEC_COLLABORATE_CNTL                                                0x0013
+#define regVPEC_COLLABORATE_CNTL_BASE_IDX                                       0
+#define VPEC_COLLABORATE_CNTL__COLLABORATE_MODE_EN__SHIFT                       0x0
+#define VPEC_COLLABORATE_CNTL__COLLABORATE_MODE_EN_MASK                         0x00000001L
+
+#define regVPEC_COLLABORATE_CFG                                                 0x0014
+#define regVPEC_COLLABORATE_CFG_BASE_IDX                                        0
+#define VPEC_COLLABORATE_CFG__MASTER_ID__SHIFT                                  0x0
+#define VPEC_COLLABORATE_CFG__MASTER_EN__SHIFT                                  0x3
+#define VPEC_COLLABORATE_CFG__SLAVE0_ID__SHIFT                                  0x4
+#define VPEC_COLLABORATE_CFG__SLAVE0_EN__SHIFT                                  0x7
+#define VPEC_COLLABORATE_CFG__MASTER_ID_MASK                                    0x00000007L
+#define VPEC_COLLABORATE_CFG__MASTER_EN_MASK                                    0x00000008L
+#define VPEC_COLLABORATE_CFG__SLAVE0_ID_MASK                                    0x00000070L
+#define VPEC_COLLABORATE_CFG__SLAVE0_EN_MASK                                    0x00000080L
+
+#define regVPEC_CNTL_6_1_1                                                      0x0016
+#define regVPEC_CNTL_6_1_1_BASE_IDX                                             0
+#define regVPEC_QUEUE_RESET_REQ_6_1_1                                           0x002c
+#define regVPEC_QUEUE_RESET_REQ_6_1_1_BASE_IDX                                  0
+#define regVPEC_PUB_DUMMY2_6_1_1                                                0x004c
+#define regVPEC_PUB_DUMMY2_6_1_1_BASE_IDX                                       0
+
 static uint32_t vpe_v6_1_get_reg_offset(struct amdgpu_vpe *vpe, uint32_t inst, uint32_t offset)
 {
 	uint32_t base;
 
-	base = vpe->ring.adev->reg_offset[VPE_HWIP][0][0];
+	base = vpe->ring.adev->reg_offset[VPE_HWIP][inst][0];
 
 	return base + offset;
 }
@@ -48,12 +72,14 @@ static uint32_t vpe_v6_1_get_reg_offset(struct amdgpu_vpe *vpe, uint32_t inst, u
 static void vpe_v6_1_halt(struct amdgpu_vpe *vpe, bool halt)
 {
 	struct amdgpu_device *adev = vpe->ring.adev;
-	uint32_t f32_cntl;
+	uint32_t i, f32_cntl;
 
-	f32_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL));
-	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT, halt ? 1 : 0);
-	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_RESET, halt ? 1 : 0);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL), f32_cntl);
+	for (i = 0; i < vpe->num_instances; i++) {
+		f32_cntl = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_F32_CNTL));
+		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT, halt ? 1 : 0);
+		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_RESET, halt ? 1 : 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_F32_CNTL), f32_cntl);
+	}
 }
 
 static int vpe_v6_1_irq_init(struct amdgpu_vpe *vpe)
@@ -70,20 +96,58 @@ static int vpe_v6_1_irq_init(struct amdgpu_vpe *vpe)
 	return 0;
 }
 
+static void vpe_v6_1_set_collaborate_mode(struct amdgpu_vpe *vpe, bool enable)
+{
+	struct amdgpu_device *adev = vpe->ring.adev;
+	uint32_t vpe_colla_cntl, vpe_colla_cfg, i;
+
+	if (!vpe->collaborate_mode)
+		return;
+
+	for (i = 0; i < vpe->num_instances; i++) {
+		vpe_colla_cntl = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_COLLABORATE_CNTL));
+		vpe_colla_cntl = REG_SET_FIELD(vpe_colla_cntl, VPEC_COLLABORATE_CNTL,
+					       COLLABORATE_MODE_EN, enable ? 1 : 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_COLLABORATE_CNTL), vpe_colla_cntl);
+
+		vpe_colla_cfg = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_COLLABORATE_CFG));
+		vpe_colla_cfg = REG_SET_FIELD(vpe_colla_cfg, VPEC_COLLABORATE_CFG, MASTER_ID, 0);
+		vpe_colla_cfg = REG_SET_FIELD(vpe_colla_cfg, VPEC_COLLABORATE_CFG, MASTER_EN, enable ? 1 : 0);
+		vpe_colla_cfg = REG_SET_FIELD(vpe_colla_cfg, VPEC_COLLABORATE_CFG, SLAVE0_ID, 1);
+		vpe_colla_cfg = REG_SET_FIELD(vpe_colla_cfg, VPEC_COLLABORATE_CFG, SLAVE0_EN, enable ? 1 : 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_COLLABORATE_CFG), vpe_colla_cfg);
+	}
+}
+
 static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 {
 	struct amdgpu_device *adev = vpe->ring.adev;
 	const struct vpe_firmware_header_v1_0 *vpe_hdr;
 	const __le32 *data;
 	uint32_t ucode_offset[2], ucode_size[2];
-	uint32_t i, size_dw;
+	uint32_t i, j, size_dw;
 	uint32_t ret;
 
-	// disable UMSCH_INT_ENABLE
-	ret = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL));
-	ret = REG_SET_FIELD(ret, VPEC_CNTL, UMSCH_INT_ENABLE, 0);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL), ret);
+	/* disable UMSCH_INT_ENABLE */
+	for (j = 0; j < vpe->num_instances; j++) {
+
+		if (amdgpu_ip_version(adev, VPE_HWIP, 0) == IP_VERSION(6, 1, 1))
+			ret = RREG32(vpe_get_reg_offset(vpe, j, regVPEC_CNTL_6_1_1));
+		else
+			ret = RREG32(vpe_get_reg_offset(vpe, j, regVPEC_CNTL));
+
+		ret = REG_SET_FIELD(ret, VPEC_CNTL, UMSCH_INT_ENABLE, 0);
 
+		if (amdgpu_ip_version(adev, VPE_HWIP, 0) == IP_VERSION(6, 1, 1))
+			WREG32(vpe_get_reg_offset(vpe, j, regVPEC_CNTL_6_1_1), ret);
+		else
+			WREG32(vpe_get_reg_offset(vpe, j, regVPEC_CNTL), ret);
+	}
+
+	/*
+	 * For VPE 6.1.1, still only need to add master's offset, and psp will apply it to slave as well.
+	 * Here use instance 0 as master.
+	 */
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		uint32_t f32_offset, f32_cntl;
 
@@ -96,8 +160,7 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 		adev->vpe.cmdbuf_cpu_addr[1] = f32_cntl;
 
 		amdgpu_vpe_psp_update_sram(adev);
-
-		/* Config DPM */
+		vpe_v6_1_set_collaborate_mode(vpe, true);
 		amdgpu_vpe_configure_dpm(vpe);
 
 		return 0;
@@ -114,25 +177,26 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 
 	vpe_v6_1_halt(vpe, true);
 
-	for (i = 0; i < 2; i++) {
-		if (i > 0)
-			WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_UCODE_ADDR), VPE_THREAD1_UCODE_OFFSET);
-		else
-			WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_UCODE_ADDR), 0);
-
-		data = (const __le32 *)(adev->vpe.fw->data + ucode_offset[i]);
-		size_dw = ucode_size[i] / sizeof(__le32);
-
-		while (size_dw--) {
-			if (amdgpu_emu_mode && size_dw % 500 == 0)
-				msleep(1);
-			WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_UCODE_DATA), le32_to_cpup(data++));
+	for (j = 0; j < vpe->num_instances; j++) {
+		for (i = 0; i < 2; i++) {
+			if (i > 0)
+				WREG32(vpe_get_reg_offset(vpe, j, regVPEC_UCODE_ADDR), VPE_THREAD1_UCODE_OFFSET);
+			else
+				WREG32(vpe_get_reg_offset(vpe, j, regVPEC_UCODE_ADDR), 0);
+
+			data = (const __le32 *)(adev->vpe.fw->data + ucode_offset[i]);
+			size_dw = ucode_size[i] / sizeof(__le32);
+
+			while (size_dw--) {
+				if (amdgpu_emu_mode && size_dw % 500 == 0)
+					msleep(1);
+				WREG32(vpe_get_reg_offset(vpe, j, regVPEC_UCODE_DATA), le32_to_cpup(data++));
+			}
 		}
-
 	}
 
 	vpe_v6_1_halt(vpe, false);
-	/* Config DPM */
+	vpe_v6_1_set_collaborate_mode(vpe, true);
 	amdgpu_vpe_configure_dpm(vpe);
 
 	return 0;
@@ -142,68 +206,68 @@ static int vpe_v6_1_ring_start(struct amdgpu_vpe *vpe)
 {
 	struct amdgpu_ring *ring = &vpe->ring;
 	struct amdgpu_device *adev = ring->adev;
-	uint32_t rb_bufsz, rb_cntl;
-	uint32_t ib_cntl;
 	uint32_t doorbell, doorbell_offset;
+	uint32_t rb_bufsz, rb_cntl;
+	uint32_t ib_cntl, i;
 	int ret;
 
-	rb_bufsz = order_base_2(ring->ring_size / 4);
-	rb_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL));
-	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
-	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_PRIV, 1);
-	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_VMID, 0);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL), rb_cntl);
-
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_RPTR), 0);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_RPTR_HI), 0);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_WPTR), 0);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_WPTR_HI), 0);
-
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_RPTR_ADDR_LO),
-	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_RPTR_ADDR_HI),
-	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
-
-	ring->wptr = 0;
-
-	/* before programing wptr to a less value, need set minor_ptr_update first */
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_MINOR_PTR_UPDATE), 1);
-
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
-
-	/* set minor_ptr_update to 0 after wptr programed */
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_MINOR_PTR_UPDATE), 0);
-
-	doorbell = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_DOORBELL));
-	doorbell_offset = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_DOORBELL_OFFSET));
-
-	doorbell = REG_SET_FIELD(doorbell, VPEC_QUEUE0_DOORBELL, ENABLE, ring->use_doorbell ? 1 : 0);
-	doorbell_offset = REG_SET_FIELD(doorbell_offset, VPEC_QUEUE0_DOORBELL_OFFSET, OFFSET, ring->doorbell_index);
-
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_DOORBELL), doorbell);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
-
-	adev->nbio.funcs->vpe_doorbell_range(adev, 0, ring->use_doorbell, ring->doorbell_index, 2);
-
-	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_ENABLE, 1);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL), rb_cntl);
-
-	ib_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_IB_CNTL));
-	ib_cntl = REG_SET_FIELD(ib_cntl, VPEC_QUEUE0_IB_CNTL, IB_ENABLE, 1);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_IB_CNTL), ib_cntl);
-
-	ring->sched.ready = true;
+	for (i = 0; i < vpe->num_instances; i++) {
+		/* Set ring buffer size in dwords */
+		rb_bufsz = order_base_2(ring->ring_size / 4);
+		rb_cntl = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_CNTL));
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_PRIV, 1);
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_VMID, 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_CNTL), rb_cntl);
+
+		/* Initialize the ring buffer's read and write pointers */
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_RPTR), 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_RPTR_HI), 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_WPTR), 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_WPTR_HI), 0);
+
+		/* set the wb address whether it's enabled or not */
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_RPTR_ADDR_LO),
+			lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_RPTR_ADDR_HI),
+			upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
+
+		ring->wptr = 0;
+
+		/* before programing wptr to a less value, need set minor_ptr_update first */
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_MINOR_PTR_UPDATE), 1);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+		/* set minor_ptr_update to 0 after wptr programed */
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_MINOR_PTR_UPDATE), 0);
+
+		doorbell_offset = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_DOORBELL_OFFSET));
+		doorbell_offset = REG_SET_FIELD(doorbell_offset, VPEC_QUEUE0_DOORBELL_OFFSET, OFFSET, ring->doorbell_index + i*4);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
+
+		doorbell = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_DOORBELL));
+		doorbell = REG_SET_FIELD(doorbell, VPEC_QUEUE0_DOORBELL, ENABLE, ring->use_doorbell ? 1 : 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_DOORBELL), doorbell);
+
+		adev->nbio.funcs->vpe_doorbell_range(adev, i, ring->use_doorbell, ring->doorbell_index + i*4, 4);
+
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_ENABLE, 1);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_CNTL), rb_cntl);
+
+		ib_cntl = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_IB_CNTL));
+		ib_cntl = REG_SET_FIELD(ib_cntl, VPEC_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_IB_CNTL), ib_cntl);
+	}
 
 	ret = amdgpu_ring_test_helper(ring);
-	if (ret) {
-		ring->sched.ready = false;
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
@@ -211,17 +275,30 @@ static int vpe_v6_1_ring_start(struct amdgpu_vpe *vpe)
 static int vpe_v_6_1_ring_stop(struct amdgpu_vpe *vpe)
 {
 	struct amdgpu_device *adev = vpe->ring.adev;
-	uint32_t queue_reset;
+	uint32_t queue_reset, i;
 	int ret;
 
-	queue_reset = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE_RESET_REQ));
-	queue_reset = REG_SET_FIELD(queue_reset, VPEC_QUEUE_RESET_REQ, QUEUE0_RESET, 1);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE_RESET_REQ), queue_reset);
+	for (i = 0; i < vpe->num_instances; i++) {
+		if (amdgpu_ip_version(adev, VPE_HWIP, 0) == IP_VERSION(6, 1, 1))
+			queue_reset = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE_RESET_REQ_6_1_1));
+		else
+			queue_reset = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE_RESET_REQ));
+
+		queue_reset = REG_SET_FIELD(queue_reset, VPEC_QUEUE_RESET_REQ, QUEUE0_RESET, 1);
+
+		if (amdgpu_ip_version(adev, VPE_HWIP, 0) == IP_VERSION(6, 1, 1)) {
+			WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE_RESET_REQ_6_1_1), queue_reset);
+			ret = SOC15_WAIT_ON_RREG(VPE, i, regVPEC_QUEUE_RESET_REQ_6_1_1, 0,
+						 VPEC_QUEUE_RESET_REQ__QUEUE0_RESET_MASK);
+		} else {
+			WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE_RESET_REQ), queue_reset);
+			ret = SOC15_WAIT_ON_RREG(VPE, i, regVPEC_QUEUE_RESET_REQ, 0,
+						 VPEC_QUEUE_RESET_REQ__QUEUE0_RESET_MASK);
+		}
 
-	ret = SOC15_WAIT_ON_RREG(VPE, 0, regVPEC_QUEUE_RESET_REQ, 0,
-				 VPEC_QUEUE_RESET_REQ__QUEUE0_RESET_MASK);
-	if (ret)
-		dev_err(adev->dev, "VPE queue reset failed\n");
+		if (ret)
+			dev_err(adev->dev, "VPE queue reset failed\n");
+	}
 
 	vpe->ring.sched.ready = false;
 
@@ -236,10 +313,18 @@ static int vpe_v6_1_set_trap_irq_state(struct amdgpu_device *adev,
 	struct amdgpu_vpe *vpe = &adev->vpe;
 	uint32_t vpe_cntl;
 
-	vpe_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL));
+	if (amdgpu_ip_version(adev, VPE_HWIP, 0) == IP_VERSION(6, 1, 1))
+		vpe_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL_6_1_1));
+	else
+		vpe_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL));
+
 	vpe_cntl = REG_SET_FIELD(vpe_cntl, VPEC_CNTL, TRAP_ENABLE,
 				 state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL), vpe_cntl);
+
+	if (amdgpu_ip_version(adev, VPE_HWIP, 0) == IP_VERSION(6, 1, 1))
+		WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL_6_1_1), vpe_cntl);
+	else
+		WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL), vpe_cntl);
 
 	return 0;
 }
@@ -264,13 +349,19 @@ static int vpe_v6_1_process_trap_irq(struct amdgpu_device *adev,
 
 static int vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)
 {
+	struct amdgpu_device *adev = container_of(vpe, struct amdgpu_device, vpe);
+
 	vpe->regs.queue0_rb_rptr_lo = regVPEC_QUEUE0_RB_RPTR;
 	vpe->regs.queue0_rb_rptr_hi = regVPEC_QUEUE0_RB_RPTR_HI;
 	vpe->regs.queue0_rb_wptr_lo = regVPEC_QUEUE0_RB_WPTR;
 	vpe->regs.queue0_rb_wptr_hi = regVPEC_QUEUE0_RB_WPTR_HI;
 	vpe->regs.queue0_preempt = regVPEC_QUEUE0_PREEMPT;
 
-	vpe->regs.dpm_enable = regVPEC_PUB_DUMMY2;
+	if (amdgpu_ip_version(adev, VPE_HWIP, 0) == IP_VERSION(6, 1, 1))
+		vpe->regs.dpm_enable = regVPEC_PUB_DUMMY2_6_1_1;
+	else
+		vpe->regs.dpm_enable = regVPEC_PUB_DUMMY2;
+
 	vpe->regs.dpm_pratio = regVPEC_QUEUE6_DUMMY4;
 	vpe->regs.dpm_request_interval = regVPEC_QUEUE5_DUMMY3;
 	vpe->regs.dpm_decision_threshold = regVPEC_QUEUE5_DUMMY4;
-- 
2.44.0

