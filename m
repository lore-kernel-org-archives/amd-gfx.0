Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A15C25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 20:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD76F10EA3F;
	Fri, 27 Oct 2023 20:09:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281EC10EA3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 20:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUfMxartNCgyyXbTqIX+G3Szb4cgvFCs9K2oK953VlPSjvEGcVUdmBN9S8ddbTfIbj/nT4RAcG7C56ACVlXrOHhxz2P32HA5h9WPPSN/EJWbX5tBXhrABszfCRZx6YH0ecLDHXOg3TAKuWE6LTCQusxgZNiOL+3OwcA4nEJqfxg+4wOhdzbvPkhndd+PdIzGAVA7apjJy9uJs0rIfnePM/gjqV7hUibZJJCP13QM0jY+lFKCM5GQx8YaUlARfv0m8kNLDgzGJJf0D2wl1EcmlYFHjWAWmzar4fS5Tusn93bTz5hZQ/dmloXd6n7KNgOSZRGwUupgFSiOzr0JZKyFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5nB3nQwx6KcoIK64Bvfq7FFEu4s163J+IwDw19dupE=;
 b=F0G7H3IdUyMmERlDGwGlUw2+9dY/7rjEYbsjse/Yoi2AB98BNVkn5xyBv5Td1aaZugCxciIy+rO7+iaOxVxmAwjueGVbC5OTyKVVUz5B0OQf1Og+eA034cmEe9ptYdn27KwKFZDjlE3n5x5qCxS+j55lrErE7IR85EgoW+T/hsWQh1Cls2AsWpnINOdr1e91a21QjNP7nkUhCjCbPgwbyEjB1hJUVsOtglXHpgvXOKYHh8qvVR8DzsOT+qEP0NQrRoRBuv1YQ+EGRtck2RSx/iy359qFCoxOePppblyZ6hGuAfNvFUc9nmucxNcIDurTjteZhGUx8DvxqXLUvPJTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5nB3nQwx6KcoIK64Bvfq7FFEu4s163J+IwDw19dupE=;
 b=3yR5p3yrc2YGEdRP8CcsutT0+4la7JLGpUF0K4G094IAugnwZTnY0TS2cKovQPMe9fzDEBVOPxGgf+5866PDGWk/NvtqD6OhAX9hNTBrKxJXMtGZdvq89n0QKrzwJNUL1vlGR+OLYeVVie6Z+uf3eWrFd/YJH3vIElvQDZiuNqI=
Received: from BYAPR02CA0006.namprd02.prod.outlook.com (2603:10b6:a02:ee::19)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 20:09:45 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::f8) by BYAPR02CA0006.outlook.office365.com
 (2603:10b6:a02:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Fri, 27 Oct 2023 20:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 20:09:44 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 15:09:42 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.3 (v4)
Date: Fri, 27 Oct 2023 16:09:28 -0400
Message-ID: <20231027200928.2319-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8d1c0dc9-7bb0-2549-6692-830845879de5@amd.com>
References: <8d1c0dc9-7bb0-2549-6692-830845879de5@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 2527984a-e059-4751-7d5b-08dbd728a975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OP6Zbw9AGXze4TuHis8YKERZONpbD1VgjwlycP+UH7g+lFoV2pkeIUfGXr5OOodVx/PyjBQ7ooKzNJUXHvQJMuUsVeZxyCZN5h/k2x+n+cp4gVoxHrczNdJzoqtoCp3ZF95MTbVUhxBbCFwNs28DKskq0fy45vr1hyavl1b2Z3hL3KapuNp/WP006dtReFCRVG/WkdDgQeCLmd3YSwA7PZ+Fj6iqKggZjhR+tnNiau/WnarYgI1iFnryN8QuJ32TijJKzm1d2MNZLYlmxScwjoSa4UhVZiM1rLN+LyTARd4m1wNGGffnV8zSk7/iKv3PFzusZdo0rwZCejMbh98SOq9GdvsKYOl6S9vTz9MOejmYANOHIDgkI5ozmY2QjxPG0mlYkqWweabv9C3rYPvH9fP/5/kn+amJK/c5esi+D+ymAQ1dljDH94T/PXG3Kg7+FMYaq51dYALI4+/BD8E9IyV/yXwmN371cXnkohWyHmlbL7WArSuORTuZDWIUAOsfEzyzcvnAQeQaYY2NWJlGZyV9oRVbx2Fx+Kc7nvUwlNAyKV825JCSAojPwHdrdoIpQPVJGu8h+mrrB30jqN2aKo+ijlitqienb/L2rJdaQ9+TRwzCpqNhgT3oVmuuZSeRlBpEiCyj5YaWORTBESIjTR5dzQWhsLFOD7PN/GaQVUbQjyJf4C5TsjUghFcNrwVskUnv3rxtYBSYy1TIVTb1PY6TQGrSjibHVwzTUn6GWFCT5zg98aGX/2QBL1NMBwVyO5CEvzFhxR+WCCcQkZEqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(46966006)(36840700001)(40460700003)(2616005)(26005)(1076003)(16526019)(5660300002)(7696005)(478600001)(47076005)(6666004)(8676002)(2906002)(336012)(36860700001)(83380400001)(30864003)(426003)(41300700001)(70586007)(70206006)(4326008)(8936002)(316002)(54906003)(6916009)(82740400003)(356005)(81166007)(86362001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:09:44.1176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2527984a-e059-4751-7d5b-08dbd728a975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
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

Using amdgpu_sriov_runtime to determine whether to access via kiq or
RLC is sufficient for now.

v4: avoid using amdgpu_sriov_w/rreg

v3: use W/RREG32_XCC to handle non-kiq case

v2: define amdgpu_device_xcc_wreg/rreg instead of changing parameters
    of amdgpu_device_wreg/rreg

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 13 ++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 91 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  8 +-
 9 files changed, 118 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 43c579f5a95e..e8dc75a3ff44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1162,11 +1162,18 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
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
@@ -1207,8 +1214,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)

-#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
-#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
+#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg), 0)
+#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v), 0)

 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
@@ -1218,6 +1225,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
 #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
+#define RREG32_XCC(reg, inst) amdgpu_device_xcc_rreg(adev, (reg), 0, inst)
+#define WREG32_XCC(reg, v, inst) amdgpu_device_xcc_wreg(adev, (reg), (v), 0, inst)
 #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
 #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
 #define RREG32_PCIE_PORT(reg) adev->pciep_rreg(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 490c8f5ddb60..80309d39737a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -300,7 +300,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);

 	for (reg = hqd_base; reg <= hqd_end; reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], inst);


 	/* Activate doorbell logic before triggering WPTR poll. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51011e8ee90d..9285789b3a42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -239,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,

 	for (reg = hqd_base;
 	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], inst);


 	/* Activate doorbell logic before triggering WPTR poll. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9a11dd1b686e..c1a439bfde14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -74,6 +74,7 @@
 #include "amdgpu_pmu.h"
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_virt.h"

 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -473,7 +474,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
-			ret = amdgpu_kiq_rreg(adev, reg);
+			ret = amdgpu_kiq_rreg(adev, reg, 0);
 			up_read(&adev->reset_domain->sem);
 		} else {
 			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
@@ -510,6 +511,50 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
 	BUG();
 }

+
+/**
+ * amdgpu_device_xcc_rreg - read a memory mapped IO or indirect register with specific XCC
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
+	uint32_t ret, rlcg_flag;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if ((reg * 4) < adev->rmmio_size) {
+		if (!amdgpu_sriov_runtime(adev) &&
+		    adev->gfx.rlc.rlcg_reg_access_supported &&
+		    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
+							 GC_HWIP, false,
+							 &rlcg_flag)) {
+			amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag, xcc_id);
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
@@ -557,7 +602,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
-			amdgpu_kiq_wreg(adev, reg, v);
+			amdgpu_kiq_wreg(adev, reg, v, 0);
 			up_read(&adev->reset_domain->sem);
 		} else {
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
@@ -598,6 +643,48 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	}
 }

+/**
+ * amdgpu_device_xcc_wreg - write to a memory mapped IO or indirect register with specific XCC
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
+	uint32_t rlcg_flag;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if ((reg * 4) < adev->rmmio_size) {
+		if (!amdgpu_sriov_runtime(adev) &&
+		    adev->gfx.rlc.rlcg_reg_access_supported &&
+		    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
+							 GC_HWIP, true,
+							 &rlcg_flag)) {
+			amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, xcc_id);
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
index a0aa624f5a92..7a084fbfd33c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -942,7 +942,7 @@ void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 	}
 }

-static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
+bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 						 u32 acc_flags, u32 hwip,
 						 bool write, u32 *rlcg_flag)
 {
@@ -975,7 +975,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 	return ret;
 }

-static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id)
+u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 	uint32_t timeout = 50000;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 858ef21ae515..03c0e38b8aea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -365,4 +365,8 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
 			uint32_t ucode_id);
 void amdgpu_virt_post_reset(struct amdgpu_device *adev);
+bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
+					  u32 acc_flags, u32 hwip,
+					  bool write, u32 *rlcg_flag);
+u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ce2a9876369e..9afd43276ab2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2738,16 +2738,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(

 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, xcc_id);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, xcc_id);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
 		break;
 	default:
 		break;
--
2.34.1

