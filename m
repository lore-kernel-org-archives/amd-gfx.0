Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955F2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 08:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33EDA112BC5;
	Tue,  7 Jun 2022 08:39:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A3D112A81
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 08:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYSYDGGEeLedi4POXsgMwOuWruBBkTPSqtVIAfmSnik8uJ9wuGBX9XD4hsUVomzaLHCCaubMIUhPY9XL04nnYvoRiCzy+iMrdh2iahGSgmZmR8VfMzh91gXeGi81XRzjhcysCHlfEoGK1Ek3UglDhK6L3zbjSpdEmWeD7VXLx/fkzLF21bh3XivhQLILAS0rrny2SlE/zTzUpP+PQwJJiKXst9J7wZVP2LNuv8Ixt6L5Ph6nUwlb4irIQxuieZdjwWlY4nM6VQCHohmntmNCrH/2JCbJL35bwIu6ln5SV3ZpjKV+2YoYYWaUeEqNMtycV2zqyEF5x0/HXKOk3gb2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvcqHlTvOtrshgQ/3nZu8sb79aOAS5m3OLy/Sd+CrZQ=;
 b=J+C1EHWWc0cQhDwuuVG+Q6FFRi5VuePn3xXIDaJT0EVk8SmlUyauMUr6fax1or5GPlmV4qYIqxnVWnS1srZIyKvoT6I4Ep60LOWRyIwgdGLJUNtPR2lGIe6vRt/H19iaB/NwiT6yhAHKDFHyzTwfFSveT9KlHD0Dq/MpUdq7hvr0blFS5jHiIeyCDKi1XZE+ZGhRDygq+YjRpAZHqXOgaWNNjjZWhvADXJZRWCorT3WaoDw4YXTHvIZcF41ufM1eUKXhj+F7A57nIvPHIVbFWApna3w8KE5tHyX4KKm36w/jtx/BptkzHmuMUjcMyAySktES/4GwgMS8Rp6AezPJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvcqHlTvOtrshgQ/3nZu8sb79aOAS5m3OLy/Sd+CrZQ=;
 b=BxZZWg2BX7ZkqaMnLYvSi6B3xlCHwzY/GIz4oUR9xAwFjdcYN7/Pi9bbLCqicFTk9CHqnJLCSthPaPhCe4zoDCad8VZV9pvK/agDfo2dolWDKnHXxwGSAxV3bmgPm2MR/Nwxlawsthhr6wRJXXxZXXb3yuoCXsvgWmNqC5jZtoc=
Received: from MWHPR02CA0015.namprd02.prod.outlook.com (2603:10b6:300:4b::25)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 08:38:58 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::b) by MWHPR02CA0015.outlook.office365.com
 (2603:10b6:300:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 08:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 08:38:58 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 03:38:55 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3] drm/amdgpu: enable ASPM support for PCIE 7.4.0/7.6.0
Date: Tue, 7 Jun 2022 16:38:31 +0800
Message-ID: <20220607083831.1864654-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cd920c5-967b-4a5b-7de6-08da48612a59
X-MS-TrafficTypeDiagnostic: DM6PR12MB3017:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3017D92AE0579A3FBBFF66C8E4A59@DM6PR12MB3017.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtIgBb+qSVy/NQiD/IvZhygUQClvugJT6doSDi9eAnZY3WQTVe+v/as/VrNhxRWt7XXIu4PJi4nCsNWznmRIqbYWpeMjS9TQp8G1pkEEOlj2IxvRvqqilnnVeN+UyFxVxCEP0crU9eGCcKlLiyJeIZuYUYDwN3teYGP/r78A8VnT1GIKJIFeaG6IqL/hULU/Vcal0MI3xP8MtY8RmlXv84NZcWc9sp2qhncExQtOKDQtcxgU1MyNhVsZha7ZOD8g93HBjGYVQ8quJqFwl3/jPdwwQK59EsL/jUmiMb0gAcG8yQkRtKfSiuwaRbEn0YPBpnaI8qWRA5fcR3NoQu95cvAi7uHDqLYC8MI8ChlkUeMZS1wCasOFesUC3BAyaZDIgNHaABg1hd39vgc4tpJG2/do64N5e3r6CMZd0ZKaujqcDiCXsNoFLXbcn5Sj3KARcBZZVClkDVBEekKV5ospfLpUhUg3lRkF7H66ERhSOPGkyM5DvEwLzZLWZuQ67NrtNildehCZbuKC4VcnChebQexnqV8ggVmDxhJsXixqJYUBzJlm2fW8ytzqIRhLB34ClU5Dy9Z53R7Kud8hTz5Lq3XGu18tl8JKdpc4UeZA5rgAT+EYNjt8lMzrMfcEKBeQcChEyQDzTCXJyxHxlb0vxJPq4Rya+nUgZSqO1nJH9A0njAN/UC/uQSalj/epgySoF5WxMstXZrgGvtRkLCTvpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(316002)(8676002)(356005)(44832011)(2906002)(5660300002)(40460700003)(70206006)(8936002)(70586007)(81166007)(86362001)(26005)(426003)(47076005)(1076003)(336012)(186003)(16526019)(508600001)(6666004)(2616005)(7696005)(54906003)(6916009)(82310400005)(83380400001)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 08:38:58.4163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd920c5-967b-4a5b-7de6-08da48612a59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
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
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable ASPM support for PCIE 7.4.0 and 7.6.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ib3b0e106ff43ad49f0f815e6eeb5c756b6bf4550
--
v1->v2:
  - support LTR disabled scenario(Lijo)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c        | 116 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   7 +-
 .../include/asic_reg/nbio/nbio_4_3_0_offset.h |   2 +
 .../asic_reg/nbio/nbio_4_3_0_sh_mask.h        |   1 +
 6 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc938d4d8616..3eabca826c75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -689,6 +689,7 @@ enum amd_hw_ip_block_type {
 	RSMU_HWIP,
 	XGMI_HWIP,
 	DCI_HWIP,
+	PCIE_HWIP,
 	MAX_HWIP
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3996da88e1fa..44cea9649810 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -193,6 +193,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[UMC_HWIP]	= UMC_HWID,
 	[XGMI_HWIP]	= XGMI_HWID,
 	[DCI_HWIP]	= DCI_HWID,
+	[PCIE_HWIP]	= PCIE_HWID,
 };
 
 static int amdgpu_discovery_read_binary_from_vram(struct amdgpu_device *adev, uint8_t *binary)
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index ed31d133f07a..233be735165a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -344,6 +344,121 @@ static u32 nbio_v4_3_get_rom_offset(struct amdgpu_device *adev)
 	return rom_offset;
 }
 
+#ifdef CONFIG_PCIEASPM
+static void nbio_v4_3_program_ltr(struct amdgpu_device *adev)
+{
+	uint32_t def, data;
+
+	def = RREG32_SOC15(NBIO, 0, regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL);
+	data = 0x35EB;
+	data &= ~EP_PCIE_TX_LTR_CNTL__LTR_PRIV_MSG_DIS_IN_PM_NON_D0_MASK;
+	data &= ~EP_PCIE_TX_LTR_CNTL__LTR_PRIV_RST_LTR_IN_DL_DOWN_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP2);
+	data &= ~RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP2, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
+	if (adev->pdev->ltr_path)
+		data |= BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+	else
+		data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
+}
+#endif
+
+static void nbio_v4_3_program_aspm(struct amdgpu_device *adev)
+{
+#ifdef CONFIG_PCIEASPM
+	uint32_t def, data;
+
+	if (!(adev->ip_versions[PCIE_HWIP][0] == IP_VERSION(7, 4, 0)) &&
+	      !(adev->ip_versions[PCIE_HWIP][0] == IP_VERSION(7, 6, 0)))
+		return;
+
+	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL);
+	data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
+	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
+	data |= PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL7);
+	data |= PCIE_LC_CNTL7__LC_NBIF_ASPM_INPUT_EN_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL7, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL3);
+	data |= PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL3, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3);
+	data &= ~RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK;
+	data &= ~RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5);
+	data &= ~RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
+	data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
+
+	WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP, 0x10011001);
+
+	def = data = RREG32_SOC15(NBIO, 0, regPSWUSP0_PCIE_LC_CNTL2);
+	data |= PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
+		PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
+	data &= ~PSWUSP0_PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regPSWUSP0_PCIE_LC_CNTL2, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL4);
+	data |= PCIE_LC_CNTL4__LC_L1_POWERDOWN_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL4, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL);
+	data |= PCIE_LC_RXRECOVER_RXSTANDBY_CNTL__LC_RX_L0S_STANDBY_EN_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL, data);
+
+	nbio_v4_3_program_ltr(adev);
+
+	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3);
+	data |= 0x5DE0 << RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT;
+	data |= 0x0010 << RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5);
+	data |= 0x0010 << RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL);
+	data |= 0x0 << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
+	data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	data &= ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL3);
+	data &= ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL3, data);
+#endif
+}
+
 const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
 	.get_hdp_flush_req_offset = nbio_v4_3_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v4_3_get_hdp_flush_done_offset,
@@ -365,4 +480,5 @@ const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
 	.init_registers = nbio_v4_3_init_registers,
 	.remap_hdp_registers = nbio_v4_3_remap_hdp_registers,
 	.get_rom_offset = nbio_v4_3_get_rom_offset,
+	.program_aspm = nbio_v4_3_program_aspm,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 31caae7c2495..d8a954bd4c50 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -380,11 +380,12 @@ static void soc21_pcie_gen3_enable(struct amdgpu_device *adev)
 
 static void soc21_program_aspm(struct amdgpu_device *adev)
 {
-
-	if (amdgpu_aspm == 0)
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
-	/* todo */
+	if (!(adev->flags & AMD_IS_APU) &&
+	    (adev->nbio.funcs->program_aspm))
+		adev->nbio.funcs->program_aspm(adev);
 }
 
 static void soc21_enable_doorbell_aperture(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_offset.h
index 53802d674e13..4b489d64deaa 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_offset.h
@@ -6918,6 +6918,8 @@
 #define regPSWUSCFG0_SSID_CAP                                                                           0x2880031
 #define regPSWUSCFG0_SSID_CAP_BASE_IDX                                                                  5
 
+#define regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL                                                             0x2890102
+#define regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL_BASE_IDX                                                    5
 
 // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
 // base address: 0x10100000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_sh_mask.h
index f3cda48bfaeb..d038fd915351 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_sh_mask.h
@@ -82045,5 +82045,6 @@
 #define BIF_CFG_DEV0_EPF3_1_RTR_DATA2__FLR_TIME_MASK                                                          0x00000FFFL
 #define BIF_CFG_DEV0_EPF3_1_RTR_DATA2__D3HOTD0_TIME_MASK                                                      0x00FFF000L
 
+#define PCIE_LC_RXRECOVER_RXSTANDBY_CNTL__LC_RX_L0S_STANDBY_EN_MASK                                           0x00010000L
 
 #endif
-- 
2.29.0

