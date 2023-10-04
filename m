Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5509FE8FDBF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 00:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6235310E328;
	Wed,  4 Oct 2023 00:56:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1464710E328
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 00:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr7yrXOPI8PAB0GIApcINkcsca7I3STBpWBij6sYzO2nDzx2waFY0lbLeoKeCPKW+KuMklfmnCIgGvAR8RY6yzMPU1JTldgPJPGz1zW8AUFPR2p7rv7eeqRvfrsGf3hKzEIT2ru39MeQ4atbpSPoiNz1mKhUIiILkqp/cXDIRDLQq3lm3UZ3oXHcMlrGnMDmDnxs4ryOwMlNPPyjW6Gb/25xOk00kRq8ad9ItmvN/jAFuhbqsB+dXbgxzoSu6u2FDzPCCg+krCNM2jndnWeF2uX/hxH5Oi3vTSBFpjp00P3U+SSKCPRDr/5MgsNUNb4GhtQl2OsYCyC0Kh+C7F7jBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYYQKVppNBVeN3R3p9t2CpRXSjskUD2QaSs9g+p0uYE=;
 b=AQ7HhEJRhBSFlPA8bI9MLxur4qBEtAhsuyzdrsx0CCt1EP8PBbgLDmXc2UNgAmv0prchqeEVYbRAh+6bznJE2n0Mh1f9SxBpCPFXOVcOiImYflqB8EaAerPUsr2VtpV2FczI6awtZ4IEKyn4vf/f8afxPVAeggu8pYDLdhgrbQkmRMxo6WtiRfQlcQ/Ryq5BPfdMRrYMusWMhMtgoYZ6wA+oXB1/qONO76ZhUqszHkMsLWRTnb/qi9yktHsiQBKzAXqXLwNfp0J13WFbsCUtm642Sy1Z0d92iHXDlX5ChxhLkP4MuZITaQ7q+rarhjaHk1eV9Rb0IJavNI4dbY36GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYYQKVppNBVeN3R3p9t2CpRXSjskUD2QaSs9g+p0uYE=;
 b=LjAlEiUBqQBLUbEaEH5M2IEsQLtrNxBjXtWXW/Cr1VHrspUVnLb2zH0w0onZ/Vnun6EMD8tMBA/+AfovhkOOYjLPKExBhJ2jW5u7j3lktfn9BOxunft5Kuut/eXQNAW0u7Q1+z3DSG1Cxn0v+PbBDbk9teEqfvZBquOuJK/3uAs=
Received: from MN2PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:c0::18)
 by PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 00:56:42 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::24) by MN2PR05CA0005.outlook.office365.com
 (2603:10b6:208:c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.24 via Frontend
 Transport; Wed, 4 Oct 2023 00:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 00:56:42 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 19:56:41 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.3 (v2)
Date: Tue, 3 Oct 2023 20:56:13 -0400
Message-ID: <20231004005616.108476-3-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004005616.108476-1-victorchengchi.lu@amd.com>
References: <20231004005616.108476-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d88b3d-e6f0-4218-b01b-08dbc474c630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9MBEMUGSm+ciTz0uDk7tjuXIkEltbZNyso3HK5JoeegdN5o1SwWssfzIqMHDLkpI3k31TrqWyMTp4AhRNprDpYNUFVVaazw0pVXv3OLvY21DtegIwpMe2AEx7vKcsk+LgXhlMi31MC9ycAUxeeTOnN1WUUMuo6OQskIcQ7PjqkS0fTegrZREZcpUFTEUGXSTdxjh2i7hdv8Z9okqi1gqWYMtKcud1dd+YjLDSXgOEDi/S6nIrHpipx2ACv52RwvGOSWJ3QgndC7ZdgHhvtHFTudxcsFnk+LtJpPPS3Ri+vV4yZ2U2/oEZ0oVSqqifviWhQ9pNF/k3eLDhplEdpzqGWjdFpThlLvjb30bnPaMma+x/ZIXZ4tQ7HaxM6F+t5orWrWkZHZS5fMczBnW/41B2/EEhbPx3b3VWnlp/S8CSlsbZS5FiHv3ia/fT2przwG5iEES9TRYvqjjsZK8c0t2gE5h2F0kK7wB5uSJTh0F9/mlSej8cgjZ+5c5edP7zrjQuUlwtCtEMzQ24HsA1WnHhomTTSWIDqjFyY8T4Sua3cDAlXRn3bh2/A8p03V80vhsE2OZ+pBGFQ9iIThPmIwevfgk5W5Z+fRXgVc1PVPZr9LVTilmji2Pwi9qqci7lU/YAVBPvF/+ivuAgTq5Zjw7G6fVtHq6R/uuN6liDKjCgW/kjfZTd01VfCvuLiZ41zQ5U+cHq3HZxUjemBbK6y965zNudKf2aRS5SN+QN6UKHpOke264ITLLFAXvF99YG2DGxZjYnq7PUIRXC5YCYRoIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(40470700004)(36840700001)(46966006)(336012)(40460700003)(426003)(26005)(1076003)(16526019)(83380400001)(86362001)(36860700001)(82740400003)(356005)(81166007)(36756003)(47076005)(40480700001)(478600001)(6916009)(2616005)(316002)(54906003)(5660300002)(70586007)(70206006)(41300700001)(8936002)(4326008)(7696005)(6666004)(8676002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 00:56:42.2918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d88b3d-e6f0-4218-b01b-08dbc474c630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_kiq_wreg/rreg is hardcoded to use MEC engine 0.

Add an xcc_id parameter to amdgpu_kiq_wreg/rreg, define W/RREG32_XCC
and amdgpu_device_xcc_wreg/rreg to to use the new xcc_id parameter.

v2: define amdgpu_device_xcc_wreg/rreg instead of changing parameters
    of amdgpu_device_wreg/rreg

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 13 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 76 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  4 +-
 5 files changed, 93 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 73e825d20259..387ef7e2419f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1161,11 +1161,18 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 			    uint32_t reg, uint32_t acc_flags);
 u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
 				    u64 reg_addr);
+uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
+				uint32_t reg, uint32_t acc_flags,
+				uint32_t xcc_id);
 void amdgpu_device_wreg(struct amdgpu_device *adev,
 			uint32_t reg, uint32_t v,
 			uint32_t acc_flags);
 void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
 				     u64 reg_addr, u32 reg_data);
+void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
+			    uint32_t reg, uint32_t v,
+			    uint32_t acc_flags,
+			    uint32_t xcc_id);
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 			     uint32_t reg, uint32_t v, uint32_t xcc_id);
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
@@ -1206,8 +1213,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
-#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
-#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
+#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg), 0)
+#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v), 0)
 
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
@@ -1217,6 +1224,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
 #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
+#define RREG32_XCC(reg, inst) amdgpu_device_xcc_rreg(adev, (reg), 0, inst)
+#define WREG32_XCC(reg, v, inst) amdgpu_device_xcc_wreg(adev, (reg), (v), 0, inst)
 #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
 #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
 #define RREG32_PCIE_PORT(reg) adev->pciep_rreg(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bad2b5577e96..96d1937a1d53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -405,7 +405,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
-			ret = amdgpu_kiq_rreg(adev, reg);
+			ret = amdgpu_kiq_rreg(adev, reg, 0);
 			up_read(&adev->reset_domain->sem);
 		} else {
 			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
@@ -442,6 +442,44 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
 	BUG();
 }
 
+
+/**
+ * amdgpu_device_xcc_rreg - read a memory mapped IO or indirect register
+ *
+ * @adev: amdgpu_device pointer
+ * @reg: dword aligned register offset
+ * @acc_flags: access flags which require special behavior
+ * @xcc_id: xcc accelerated compute core id
+ *
+ * Returns the 32 bit value from the offset specified.
+ */
+uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
+				uint32_t reg, uint32_t acc_flags,
+				uint32_t xcc_id)
+{
+	uint32_t ret;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if ((reg * 4) < adev->rmmio_size) {
+		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+		    amdgpu_sriov_runtime(adev) &&
+		    down_read_trylock(&adev->reset_domain->sem)) {
+			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
+			up_read(&adev->reset_domain->sem);
+		} else {
+			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
+		}
+	} else {
+		ret = adev->pcie_rreg(adev, reg * 4);
+	}
+
+	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
+
+	return ret;
+}
+
 /*
  * MMIO register write with bytes helper functions
  * @offset:bytes offset from MMIO start
@@ -489,7 +527,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
-			amdgpu_kiq_wreg(adev, reg, v);
+			amdgpu_kiq_wreg(adev, reg, v, 0);
 			up_read(&adev->reset_domain->sem);
 		} else {
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
@@ -530,6 +568,40 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	}
 }
 
+/**
+ * amdgpu_device_wreg - write to a memory mapped IO or indirect register with specific XCC
+ *
+ * @adev: amdgpu_device pointer
+ * @reg: dword aligned register offset
+ * @v: 32 bit value to write to the register
+ * @acc_flags: access flags which require special behavior
+ * @xcc_id: xcc accelerated compute core id
+ *
+ * Writes the value specified to the offset specified.
+ */
+void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
+			uint32_t reg, uint32_t v,
+			uint32_t acc_flags, uint32_t xcc_id)
+{
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if ((reg * 4) < adev->rmmio_size) {
+		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+		    amdgpu_sriov_runtime(adev) &&
+		    down_read_trylock(&adev->reset_domain->sem)) {
+			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
+			up_read(&adev->reset_domain->sem);
+		} else {
+			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
+		}
+	} else {
+		adev->pcie_wreg(adev, reg * 4, v);
+	}
+
+	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
+}
+
 /**
  * amdgpu_device_indirect_rreg - read an indirect register
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9a158018ae16..847dd1ce1b08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -908,12 +908,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
 		func(adev, ras_error_status, i);
 }
 
-uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
+uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id)
 {
 	signed long r, cnt = 0;
 	unsigned long flags;
 	uint32_t seq, reg_val_offs = 0, value = 0;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	if (amdgpu_device_skip_hw_access(adev))
@@ -976,12 +976,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	return ~0;
 }
 
-void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
+void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id)
 {
 	signed long r, cnt = 0;
 	unsigned long flags;
 	uint32_t seq;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_wreg);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 42ac6d1bf9ca..b06500aed33f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -526,8 +526,8 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry);
-uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
-void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
+void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a0aa624f5a92..786ce1eb75b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1076,7 +1076,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		WREG32_NO_KIQ(offset, value);
 	else
-		WREG32(offset, value);
+		WREG32_XCC(offset, value, xcc_id);
 }
 
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
@@ -1091,5 +1091,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		return RREG32_NO_KIQ(offset);
 	else
-		return RREG32(offset);
+		return RREG32_XCC(offset, xcc_id);
 }
-- 
2.34.1

