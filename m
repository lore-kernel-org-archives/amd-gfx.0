Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E5BC07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 20:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DDFA10E71B;
	Wed, 25 Oct 2023 20:53:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6129510E71B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 20:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtLGVKgfgEJ4C/JxmVuxKlxIfFZl36f4JA8V9fELYOFriQbxxWcyKWlrnE97wFm6I0YTM1H4lcMrazoIjS/h3Vc0xl4BssapYNAvn+bdPj4Vb2Ed707OrlyUVjJtsTWfLv3fGbFdo36R4SPoF3yv3Jj67uWChNi8192BYSW7lcGcoOFK90opYsu8JbBdLfXdHOXHrQCOXniMvWIgpn5Wy2cj+q+jbvsiQ/960yCYlmGjkf8dpCgy28W0OCtXQJoyfGw8eVNdp0ISQfbEek5vow9BYG0YvULlZa9tDopbzMbiha+eSPMygrgtfjSRAotHUHnOAgnixhgL2gwOoQrDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acOYU5INw43v0o41+BqROtNkVnMKLw8IZ4FFlDwHdmk=;
 b=g/gu3aw7VplhJyl0/LMenuXZQT/J3Ph0pySU2zXYVuTeYCfu3UKgFuKmn5CYzWM0jVSd4TR70Xf2jXhwacZcFahmZSHNrGtC+ewE1z+0fPIKZilPCaUuClVkCHsFy+MyGE8Ev4WCSCRb2fhruwZmEc+ry/inGKTlg0WLFSnMtHoQbFVqbO2oytrmF+DnqIx0/iz7GoZ+vNDffMoiWrSw6l5gVeNluoqln6M35J44sYp/X97NizaYThxc1rDTOUUcrsSEmu3g7V8a5617rlEt9yJOs+Pj5DV1reWCNeBzSoGQV7MbFNTkja/DufAkV2Vx+p+etV6czR/bNbZm16Vbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acOYU5INw43v0o41+BqROtNkVnMKLw8IZ4FFlDwHdmk=;
 b=o8Ib72kzc88GJ/qNEn4laUEyvDTPiwwWwRSrAT+kITG8tRsLsHEj5D9ueSckYKD9kSDCS4Wu50KJbP61A9mAy0lBZy1e+m6jyTCUdCempYyxqVDuBDX8Pc6oHoD4faJ+r2d0w8727NJLqTh9ETzhAyNk74SOHAZ1WS+pqfK3xDE=
Received: from SJ0PR05CA0125.namprd05.prod.outlook.com (2603:10b6:a03:33d::10)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 20:53:49 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::2) by SJ0PR05CA0125.outlook.office365.com
 (2603:10b6:a03:33d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16 via Frontend
 Transport; Wed, 25 Oct 2023 20:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Wed, 25 Oct 2023 20:53:49 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 15:53:48 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.3 (v3)
Date: Wed, 25 Oct 2023 16:52:40 -0400
Message-ID: <20231025205242.40490-3-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025205242.40490-1-victorchengchi.lu@amd.com>
References: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
 <20231025205242.40490-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: e5084270-79dc-4557-87cf-08dbd59c7d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQVZY+NbNJRDhcLc4RpT5vHciOh7GL6uECqiH/6cC2TR133aNwx6xNcct0MgI4ikjkXdISRL/99Mg2Yr4DoGHbNGg4CqIsqUOXM+kGHExoWmdEzZiXCuQckC2bkifuLEXwx7UwCKwp0RZKWS31Kse4fwhZwAPy9QrC6BsCeGFnTQHDVm6kHwZVsHQZNKdi25sQXV46VKo/+jjtTPaL5pYhqfhBVUeVZ5VzczMApjzQ1HnBUZcCZ1M4joIf/wXdsZBjxvEFjM480i7sq9zhT2hBKp09auftRNY+TUEQSnvLfXHQMUC+RHTK4qtMucKwGKewXI+CObv0GPH9vufS5S9JYUPPk8bhIELGiybMeeNLNnboxsSmxWFdKJleLrr5gf/inDfs29P1QRPsB6HqkrP6Ms6Bc+/FoHlH7Qwvual/a8T0LKVdzTsxCydHQUcV0p2bD4vGebdnfUqjs6GQQbBfqWYBXrEZuiNmq1cLLbF8oc5L1dt6IoWnX8ia7lszLQYqHbkiJvzowPL7IIkg9ZkqdmZ2BbkRPZ6oXzP5cqnBTXwHb7o/MdWDKFZuuQkOe3j7fH38aWPa/Lbl+cHqGs9rRbdL6P+wQsFW91XTHFfIYJYtof4PoOxU8G+pdM5Gj/sId0X6Rp7iZ6SVGOroUxkmZddJIL+PxFEP9vlwIt3KyBOSRH76IQ3DBoSds6jp68GAx1IfJdZrsB82BNUfuXfpF/7SPX9wWbEPBZJe5JTiXPiVZQJKzXyU+HvIaWVNeHu6fWtFufs4nba1uYQ5cJbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(26005)(16526019)(41300700001)(2906002)(30864003)(40460700003)(86362001)(5660300002)(8936002)(36756003)(8676002)(4326008)(36860700001)(54906003)(70206006)(478600001)(6916009)(7696005)(1076003)(81166007)(356005)(316002)(70586007)(82740400003)(2616005)(83380400001)(336012)(40480700001)(426003)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 20:53:49.3174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5084270-79dc-4557-87cf-08dbd59c7d20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_kiq_wreg/rreg is hardcoded to use MEC engine 0.

Add an xcc_id parameter to amdgpu_kiq_wreg/rreg, define W/RREG32_XCC
and amdgpu_device_xcc_wreg/rreg to to use the new xcc_id parameter.

v3: use W/RREG32_XCC to handle non-kiq case

v2: define amdgpu_device_xcc_wreg/rreg instead of changing parameters
    of amdgpu_device_wreg/rreg

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 13 ++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 84 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  8 +-
 8 files changed, 107 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a2e8c2b60857..09989ebb5da3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1168,11 +1168,18 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
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
@@ -1213,8 +1220,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
-#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
-#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
+#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg), 0)
+#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v), 0)
 
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
@@ -1224,6 +1231,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
 #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
+#define RREG32_XCC(reg, flag, inst) amdgpu_device_xcc_rreg(adev, (reg), flag, inst)
+#define WREG32_XCC(reg, v, flag, inst) amdgpu_device_xcc_wreg(adev, (reg), (v), flag, inst)
 #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
 #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
 #define RREG32_PCIE_PORT(reg) adev->pciep_rreg(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 490c8f5ddb60..c94df54e2657 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -300,7 +300,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
 
 	for (reg = hqd_base; reg <= hqd_end; reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], AMDGPU_REGS_RLC, inst);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51011e8ee90d..47c8c334c779 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -239,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	for (reg = hqd_base;
 	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], AMDGPU_REGS_RLC, inst);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ec32b44df05..9a35088b990a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -471,7 +471,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
-			ret = amdgpu_kiq_rreg(adev, reg);
+			ret = amdgpu_kiq_rreg(adev, reg, 0);
 			up_read(&adev->reset_domain->sem);
 		} else {
 			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
@@ -508,6 +508,48 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
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
+		if ((acc_flags & AMDGPU_REGS_RLC) &&
+		    (!amdgpu_sriov_runtime(adev)) &&
+		    adev->gfx.rlc.rlcg_reg_access_supported) {
+			amdgpu_sriov_rreg(adev, reg, acc_flags, GC_HWIP, xcc_id);
+		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
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
@@ -555,7 +597,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
-			amdgpu_kiq_wreg(adev, reg, v);
+			amdgpu_kiq_wreg(adev, reg, v, 0);
 			up_read(&adev->reset_domain->sem);
 		} else {
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
@@ -596,6 +638,44 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
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
+		if ((acc_flags & AMDGPU_REGS_RLC) &&
+		    (!amdgpu_sriov_runtime(adev)) &&
+		    adev->gfx.rlc.rlcg_reg_access_supported) {
+			amdgpu_sriov_wreg(adev, reg, v, acc_flags, GC_HWIP, xcc_id);
+		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
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
index c92e0aba69e1..60ae4bfdc7f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -929,12 +929,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
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
@@ -997,12 +997,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
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
index 7088c5015675..f23bafec71c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -521,8 +521,8 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
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
index a0aa624f5a92..c6c8f4fed0c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1076,7 +1076,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		WREG32_NO_KIQ(offset, value);
 	else
-		WREG32(offset, value);
+		WREG32_XCC(offset, value, acc_flags, xcc_id);
 }
 
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
@@ -1091,5 +1091,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		return RREG32_NO_KIQ(offset);
 	else
-		return RREG32(offset);
+		return RREG32_XCC(offset, acc_flags, xcc_id);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 386804f2e95c..b24db7974311 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2739,16 +2739,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, AMDGPU_REGS_RLC, xcc_id);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, AMDGPU_REGS_RLC, xcc_id);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, AMDGPU_REGS_RLC, xcc_id);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, AMDGPU_REGS_RLC, xcc_id);
 		break;
 	default:
 		break;
-- 
2.34.1

