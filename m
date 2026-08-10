Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D054CC5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 09:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461D310E782;
	Mon, 10 Aug 2026 09:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="epV7r0yE";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BB010E782
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 09:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgJaL9sQxsYWoqA/OB+aOsgteVaREwDxjDsd//3cu5SPzqT7v5K2uIKEwn4FQN3OV1o7rPXJ6/Cod8kxCTlDMlBlzSrpTfARbpmxKIo9RQ7x7VhRg9kN2BPazZTZvB4bS60R1Hk/UjO21HzsZ6j4vnxmonTXJy021r2sYwp+2ffU8buHBKOy35rx7I/UR3KrVrc7mqX72hlrOhI9lbBd0yw2gphVJGx0ZnZFFLLQrr1HLos7+KS4lJULXpGqqi6omhpRwpU1n6VVb51R914GF2woNj5HnxP+mj04fex/ehEBjZxAtmxD7nfZ81+6PMA9c+WRwHmiI+xOJdneQ0Vtlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMpYVfOgpPvjRAABRcfEiLPioK5CNF2ix27nezceqvM=;
 b=aOR5+v7YFyD9awcMs50mcTBpT8y3goq+diU9eCGuNMJ2Zz6vNHD54aVaoD4X7rOFWTYdyi54I0bo0YbYXLRTjxBNrp5xNBusdYgckz3S6fePSn07+tVXt4h7UeWvMMfp/liZIcpMbRbIoUsr0pXm1VLsjQzwQBx48hIV88u5A98X/zmP/H8e2newcCFSzU6vS9gwii3bFk3IO+dqFzAwUcUMyKb9Sw1tR42gV5+sr1XlEEspbVSTR7yfz+8BMoiAulbHteVR/R3mDnPcrA3I0vNSzsTXK0s8xAxp8eour7LEBpUNpivTUV3HwdAI2o9ocd5BOdGI0A0fqycodji4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMpYVfOgpPvjRAABRcfEiLPioK5CNF2ix27nezceqvM=;
 b=epV7r0yEMq+Pm8iMZsm+yRo9jIfSEknVh6xPtVFoW9irauv8UYIKKYKDmsmNuQjfcxMI+JYK3REX4bf/DPep1X4HfbyHJRAuag4jNQxm0+rSVBYPIE8/yvrbSKa/0SjFXqkDjvcVlCxH9MPoewUkqZyNh4q1H5FewEdUnbAvDFM=
Received: from CH2PR11CA0020.namprd11.prod.outlook.com (2603:10b6:610:54::30)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:59:31 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::2e) by CH2PR11CA0020.outlook.office365.com
 (2603:10b6:610:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 09:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 09:59:31 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 04:59:28 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, Kenneth Feng <Kenneth.feng@amd.com>
Subject: [PATCH] drm/amdgpu: fix nbif 6.3.1 l1 low power not functional
Date: Mon, 10 Aug 2026 17:59:16 +0800
Message-ID: <20260810095916.1752707-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 926717f8-d5c7-45c7-25ab-08def6c612dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: i89jWJYpW5ZKOkAXL33q6iXP4rBzmcLcxTTlael/TGjp2sS2qGzMniKowKQ7L2AvmNwWv8UD5dEQbQs8OWEB+q3sq0Wv6LMLbdjs5qjaw8nDjmhKZkmYQtCCus3S0CtoUv+IY8RGShgRnFiJHRWYhxDE9jPeFPSn0gS8SIWKsg8iOS1JyOx9opSwTmqep2ofHGMegLjlwDksj2H/Si/xqBJ1woUj5u+IGqlB0hXZUFF2mTpjjMG7CXAfG798weOCn9co9hay3f31NDnTqMjuFR+iIWUrLKYdg5iq22l3RGloB6qFqjbqSZMx2/6l6C4RR6LTwivMgfVarGjmIfzTelMFDEaYRd+mkWE13DFtGqtuNoDX66NJYDZpPDPAbYst0Ax9geVOUsJwr2rBYRBDNM8k2FEjuzWIKyHPhDE4WWFtRsv7fgpp/KaB61tFiral+ezN6B7DS7y/4B11PdapLq9uixvwepi47Tgj2sFhQqqL3hSQ4aSFU/ZAM0vaz5tIWfzbktsS6eHuKrFE1I3y87wDH9MZRCopulNi0WMrFPV2mjoRJvtfMHE+hv+DIejQELbQPPR7ciolZbjAqA4Px6cWGJImGgq46y6JNUCXECT/50bspEeZ83fJS38dhQRw+iLk6v46TqT3J5eDvzS3Zs5CPY9Ftd4jhfP+G0jM0aas8+UDGpwDelwseXSi2OCT8hCn3srZeRSnZjdqiV93FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8ruJb29jFgVtdgYbZ/4n4Bxi4zGI810IZWYXmc2AKN+Jk/tAjCi7t7S7np5cYxwCPsi2IwwzSZ1DAVHhHr+SgTAuNJLOJvmlJgezEZMab/nPJ3Zlh5gH8dXGy8pdBJ6T3bOnEuDfonsqlY1Mgu3v3//7DawRftgwGK+DINEHOzI+zn1mHDOAQ7/OXlGQw+ldPEIyPrzHdvuZKnIF6sH6X6RkUnkLsdu4ncEepIiy7KkT5JE7zu4rHDHGWH+nfKhjPHdWEXYyvWmW5/yfyiQuVhEJkWcOsbRQ3v/0KWL5hTH9uUVfWhCTIx4u/Onhjy9ESiictibJqaFfM1DNRX8nh0+q0eVkTJuhC4Tu8WPw6WfCxEkcX6/FYzrKrFeuhj62WaYUAPqXdl8qZW3dlw/zQZVL0FAtD9yG04PnOD8mRuBgjzefgs8v5Pmd1D9UjAVS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:59:31.3033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 926717f8-d5c7-45c7-25ab-08def6c612dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
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

The PCIe L1 low‑power settings for NBIF 6.3.1 were never applied due to
unresolved register mapping, which caused the relevant code to be compiled out.
As a result, the PCIe link could not enter L1/L23 power‑down states or transition to L0s.

Properly configure the link control register to enable L1 and L23 power‑down,
and permit L0s link transitions. Keep LTR disabled and let the PCI core enable it
only after verifying end‑to‑end root complex support across switches.

Fixes: 894c6d3522d1 ("drm/amdgpu: Add nbif v6_3_1 ip block support")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Kenneth Feng <Kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 42 ++++++++++--------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 57b0cf817afb..cea08134d4c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -423,7 +423,6 @@ static u32 nbif_v6_3_1_get_rom_offset(struct amdgpu_device *adev)
 static void nbif_v6_3_1_program_ltr(struct amdgpu_device *adev)
 {
 	uint32_t def, data;
-	u16 devctl2;
 
 	def = RREG32_SOC15(NBIO, 0, regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL);
 	data = 0x35EB;
@@ -437,15 +436,8 @@ static void nbif_v6_3_1_program_ltr(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP2, data);
 
-	pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2, &devctl2);
-
-	if (adev->pdev->ltr_path == (devctl2 & PCI_EXP_DEVCTL2_LTR_EN))
-		return;
-
-	if (adev->pdev->ltr_path)
-		pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);
-	else
-		pcie_capability_clear_word(adev->pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);
+	pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2,
+				 PCI_EXP_DEVCTL2_LTR_EN);
 }
 #endif
 
@@ -453,7 +445,7 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
 {
 #ifdef CONFIG_PCIEASPM
 	uint32_t def, data;
-	u16 devctl2, ltr;
+	u16 ltr;
 
 	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL);
 	data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
@@ -483,11 +475,8 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data);
 
-	pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2, &devctl2);
-	data = def = devctl2;
-	data &= ~PCI_EXP_DEVCTL2_LTR_EN;
-	if (def != data)
-		pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, (u16)data);
+	pcie_capability_clear_word(adev->pdev, PCI_EXP_DEVCTL2,
+				   PCI_EXP_DEVCTL2_LTR_EN);
 
 	ltr = pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_LTR);
 
@@ -495,15 +484,13 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
 		pci_write_config_dword(adev->pdev, ltr + PCI_LTR_MAX_SNOOP_LAT, 0x10011001);
 	}
 
-#if 0
-	/* regPSWUSP0_PCIE_LC_CNTL2 should be replace by PCIE_LC_CNTL2 or someone else ? */
-	def = data = RREG32_SOC15(NBIO, 0, regPSWUSP0_PCIE_LC_CNTL2);
-	data |= PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
-		PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
-	data &= ~PSWUSP0_PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
+	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL2);
+	data |= PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
+		PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
+	data &= ~PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
 	if (def != data)
-		WREG32_SOC15(NBIO, 0, regPSWUSP0_PCIE_LC_CNTL2, data);
-#endif
+		WREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL2, data);
+
 	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL4);
 	data |= PCIE_LC_CNTL4__LC_L1_POWERDOWN_MASK;
 	if (def != data)
@@ -514,7 +501,12 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(PCIE, 0, regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL, data);
 
-	nbif_v6_3_1_program_ltr(adev);
+	/*
+	 * Do not enable endpoint LTR unless the Root Complex and every
+	 * upstream switch support it.
+	 */
+	if (adev->pdev->ltr_path)
+		nbif_v6_3_1_program_ltr(adev);
 
 	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3);
 	data |= 0x5DE0 << RCC_STRAP0_RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT;
-- 
2.54.0

