Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3BCC04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 07:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1412318A6A4;
	Thu, 28 Jul 2022 07:05:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27C018A6A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 07:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSY4R2TNez5T+B6QmRK3xlYkNf1aXGZV3svv0lzaRivA/USn4+oRbbdhEieAFSd4uoso+jP81Rgfdy4jPTp3HU7999NUaAlgnOAGLxIps4jEuxG3F9c96UBKErdJDOQmEjLJBDF1eunzI25LkWot27/azRWgypNNf6x/0yK2ewGQRt+huAhJRrkKyoXdRSEvK9k2+TcbTgqBEE3hZc2ZbPdOYzOK4BMPhcu6YboSyMKvEMaxGdNvWVa1KBb96qeN5Ap9SJuigHJ38waCw4fIwg4FeOU7fwd/Pm+XXCKruxmspEcH2eZtMZDkXBbRWP287N5Mf3EM1S1HvfMvjN7P6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpLN5AXHP90Vhcb7JqGNp14+N63XZYe6+P/BfVTv2NU=;
 b=CO1yKTDHRo5yfmJPMDSDJ96KYJUKWTICuzwedAFJOee3j5hxBFJpjBr4Ip6j1Wwmm/bmuOs6N43geBoGKVyUs2iJoUndl1m7CyiOdjz8pn+qa0GDy5ZreslnfQySe7inkOCRvyjmRrfoZJ8UOM4kJGpkB/hJfg9cubXL0zr0M4+GdMk4bybAuIMA2N6iBiFyWLp0Qc63uywlGZjXzVs0DhZWI0jxMhmjrjhUQCfLUNUR9nSFpuKcji6BH8EyrkJOwZuFcG0v9DbAM/94sNEqKZv/9U/9sZIQfK1fS0/dgoUbfR+q7FhvsFy1hsHv0PrtPF0vSblTfR7dRjHLccysnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpLN5AXHP90Vhcb7JqGNp14+N63XZYe6+P/BfVTv2NU=;
 b=dGBJAsUzLg77fG4Od6+smR2x6l0DD+uEOtHORke2/uoNWOKjD2kV+7LPbpJtDRIurz5DTO6sbAR9zn130f5zIx41MdnWiBoqplRp/QJtT3/qFnxi0QcnGFVlLU0D7Ua3rcrPNZQfAhkFGtcHbZjENQ0nQgBC5iIDJjprPHltWaQ=
Received: from MW3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:303:2b::16)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Thu, 28 Jul
 2022 07:05:20 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::54) by MW3PR05CA0011.outlook.office365.com
 (2603:10b6:303:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Thu, 28 Jul 2022 07:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 07:05:19 +0000
Received: from jenkins-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 02:05:17 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: add files for PSP 13.0.4
Date: Thu, 28 Jul 2022 15:04:18 +0800
Message-ID: <20220728070419.2485384-4-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
References: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 607d1272-64c0-4123-03c1-08da70678880
X-MS-TrafficTypeDiagnostic: CY5PR12MB6321:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pODionGNWBDFKtdH4gQPbbL8E0vptoRvAygoldvU/aSinkiSDxHScgIIcxgkIQ5RkDc/LDlrj0tFvBgif5LQwLu79g/DTkxUkExcX+Zhc9XrkLQE7Agld8b2xD3O28sJ8r6NmD6jOl5ejWitLGug+GQuF47fGwwXMJBTdcHNundh5pzUQ8Zi71COfg5FGDe+DlC9SDzOw/JsRPILY+Pj/Y4eQoAtmZZiiaLND+ypW8LMNvvtc6rBwsxIbhJXYU7PX8meOX2AkMZPrGiLNjKae3DtRlL5jdGoLsiaC3BwLVOVhXURWANQLId90sjfaM10osRoygCI8UXrOMos7bNqkksEiEu8YAzolF627wDGMFD2rwIhYr5XxmPGp6xDC/uMp1yeeM6M6MeX4wZYrhS1NBpQo6Umdyyl37VSzDP5AmtaU1QPZsoe8GK5R9thH0NSJHJlBYXa617HvBlwIRiwewhA/l4P3XjJ3jKZ2yRTTA3CFCaReOy4KWiMJjSTqjNjarpnK94i/SrsO4EEGf+kp2xwRqPrLaabDEMbXQLyEhXlO8DnBvBaxRLvFNa4mhjeWwOU6suwrcHtzZ5PtWumPgKFskQJuOG/ctBYBG4wbbzrwVX/zylGMfunOintGdkgob8aX1oyI+yYGp74ZyyJT5MFiCV9VX4NmaVpetdnDUyjphyTJ2j3koCLUZok3RZ083gdwoTeI4xRzd079tUqgeapQO+A97PdlXSRS0wkfxOwka9oCFA7p58qN/pvJsWStKikmMT3aHLgOSlyA9uKJ605d8UT4hnMlPspqaxa+jQbdhDkw1wxLTE/L8lIqQAJoGckjoRTdvGDTJRLY/PuKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(40470700004)(46966006)(8676002)(6916009)(41300700001)(316002)(2906002)(478600001)(40480700001)(40460700003)(186003)(5660300002)(30864003)(8936002)(70206006)(70586007)(4326008)(82310400005)(82740400003)(356005)(54906003)(86362001)(83380400001)(47076005)(426003)(81166007)(36756003)(16526019)(1076003)(7696005)(336012)(26005)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 07:05:19.8504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 607d1272-64c0-4123-03c1-08da70678880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
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
Cc: Alexander.Deucher@amd.com, tim.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, Yifan1.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch will add files for PSP 13.0.4.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 387 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.h |  30 ++
 2 files changed, 417 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.h

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
new file mode 100644
index 000000000000..321089dfa7db
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -0,0 +1,387 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_ucode.h"
+#include "soc15_common.h"
+#include "psp_v13_0_4.h"
+
+#include "mp/mp_13_0_4_offset.h"
+#include "mp/mp_13_0_4_sh_mask.h"
+
+MODULE_FIRMWARE("amdgpu/psp_13_0_4_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_4_ta.bin");
+
+static int psp_v13_0_4_init_microcode(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	const char *chip_name;
+	char ucode_prefix[30];
+	int err = 0;
+
+	switch (adev->ip_versions[MP0_HWIP][0]) {
+	case IP_VERSION(13, 0, 4):
+		amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));
+		chip_name = ucode_prefix;
+		break;
+	default:
+		BUG();
+	}
+
+	switch (adev->ip_versions[MP0_HWIP][0]) {
+	case IP_VERSION(13, 0, 4):
+		err = psp_init_toc_microcode(psp, chip_name);
+		if (err)
+			return err;
+		err = psp_init_ta_microcode(psp, chip_name);
+		if (err)
+			return err;
+		break;
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
+static bool psp_v13_0_4_is_sos_alive(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t sol_reg;
+
+	sol_reg = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+
+	return sol_reg != 0x0;
+}
+
+static int psp_v13_0_4_wait_for_bootloader(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	int ret;
+	int retry_loop;
+
+	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
+		/* Wait for bootloader to signify that is
+		    ready having bit 31 of C2PMSG_35 set to 1 */
+		ret = psp_wait_for(psp,
+				   SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
+				   0x80000000,
+				   0x80000000,
+				   false);
+
+		if (ret == 0)
+			return 0;
+	}
+
+	return ret;
+}
+
+static int psp_v13_0_4_bootloader_load_component(struct psp_context  	*psp,
+					       struct psp_bin_desc 	*bin_desc,
+					       enum psp_bootloader_cmd  bl_cmd)
+{
+	int ret;
+	uint32_t psp_gfxdrv_command_reg = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	/* Check tOS sign of life register to confirm sys driver and sOS
+	 * are already been loaded.
+	 */
+	if (psp_v13_0_4_is_sos_alive(psp))
+		return 0;
+
+	ret = psp_v13_0_4_wait_for_bootloader(psp);
+	if (ret)
+		return ret;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+
+	/* Copy PSP KDB binary to memory */
+	memcpy(psp->fw_pri_buf, bin_desc->start_addr, bin_desc->size_bytes);
+
+	/* Provide the PSP KDB to bootloader */
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,
+	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
+	psp_gfxdrv_command_reg = bl_cmd;
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35,
+	       psp_gfxdrv_command_reg);
+
+	ret = psp_v13_0_4_wait_for_bootloader(psp);
+
+	return ret;
+}
+
+static int psp_v13_0_4_bootloader_load_kdb(struct psp_context *psp)
+{
+	return psp_v13_0_4_bootloader_load_component(psp, &psp->kdb, PSP_BL__LOAD_KEY_DATABASE);
+}
+
+static int psp_v13_0_4_bootloader_load_spl(struct psp_context *psp)
+{
+	return psp_v13_0_4_bootloader_load_component(psp, &psp->kdb, PSP_BL__LOAD_TOS_SPL_TABLE);
+}
+
+static int psp_v13_0_4_bootloader_load_sysdrv(struct psp_context *psp)
+{
+	return psp_v13_0_4_bootloader_load_component(psp, &psp->sys, PSP_BL__LOAD_SYSDRV);
+}
+
+static int psp_v13_0_4_bootloader_load_soc_drv(struct psp_context *psp)
+{
+	return psp_v13_0_4_bootloader_load_component(psp, &psp->soc_drv, PSP_BL__LOAD_SOCDRV);
+}
+
+static int psp_v13_0_4_bootloader_load_intf_drv(struct psp_context *psp)
+{
+	return psp_v13_0_4_bootloader_load_component(psp, &psp->intf_drv, PSP_BL__LOAD_INTFDRV);
+}
+
+static int psp_v13_0_4_bootloader_load_dbg_drv(struct psp_context *psp)
+{
+	return psp_v13_0_4_bootloader_load_component(psp, &psp->dbg_drv, PSP_BL__LOAD_DBGDRV);
+}
+
+static int psp_v13_0_4_bootloader_load_sos(struct psp_context *psp)
+{
+	int ret;
+	unsigned int psp_gfxdrv_command_reg = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	/* Check sOS sign of life register to confirm sys driver and sOS
+	 * are already been loaded.
+	 */
+	if (psp_v13_0_4_is_sos_alive(psp))
+		return 0;
+
+	ret = psp_v13_0_4_wait_for_bootloader(psp);
+	if (ret)
+		return ret;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+
+	/* Copy Secure OS binary to PSP memory */
+	memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_bytes);
+
+	/* Provide the PSP secure OS to bootloader */
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,
+	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
+	psp_gfxdrv_command_reg = PSP_BL__LOAD_SOSDRV;
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35,
+	       psp_gfxdrv_command_reg);
+
+	/* there might be handshake issue with hardware which needs delay */
+	mdelay(20);
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_81),
+			   RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81),
+			   0, true);
+
+	return ret;
+}
+
+static int psp_v13_0_4_ring_init(struct psp_context *psp,
+			      enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ring = &psp->km_ring;
+
+	ring->ring_type = ring_type;
+
+	/* allocate 4k Page of Local Frame Buffer memory for ring */
+	ring->ring_size = 0x1000;
+	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->firmware.rbuf,
+				      &ring->ring_mem_mc_addr,
+				      (void **)&ring->ring_mem);
+	if (ret) {
+		ring->ring_size = 0;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int psp_v13_0_4_ring_stop(struct psp_context *psp,
+			       enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
+	} else {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64,
+			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+	}
+
+	return ret;
+}
+
+static int psp_v13_0_4_ring_create(struct psp_context *psp,
+				 enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	unsigned int psp_ring_reg = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = psp_v13_0_4_ring_stop(psp, ring_type);
+		if (ret) {
+			DRM_ERROR("psp_v13_0_ring_stop_sriov failed!\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_102 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_102, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_103 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_103, psp_ring_reg);
+
+		/* Write the ring initialization command to C2PMSG_101 */
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_101 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
+
+	} else {
+		/* Wait for sOS ready for ring creation */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+		if (ret) {
+			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_69 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_69, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_70 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_70, psp_ring_reg);
+		/* Write size of ring to C2PMSG_71 */
+		psp_ring_reg = ring->ring_size;
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_71, psp_ring_reg);
+		/* Write the ring initialization command to C2PMSG_64 */
+		psp_ring_reg = ring_type;
+		psp_ring_reg = psp_ring_reg << 16;
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64, psp_ring_reg);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_64 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
+	}
+
+	return ret;
+}
+
+static int psp_v13_0_4_ring_destroy(struct psp_context *psp,
+				  enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ret = psp_v13_0_4_ring_stop(psp, ring_type);
+	if (ret)
+		DRM_ERROR("Fail to stop psp ring\n");
+
+	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
+			      &ring->ring_mem_mc_addr,
+			      (void **)&ring->ring_mem);
+
+	return ret;
+}
+
+static uint32_t psp_v13_0_4_ring_get_wptr(struct psp_context *psp)
+{
+	uint32_t data;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev))
+		data = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_102);
+	else
+		data = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67);
+
+	return data;
+}
+
+static void psp_v13_0_4_ring_set_wptr(struct psp_context *psp, uint32_t value)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_102, value);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_CONSUME_CMD);
+	} else
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67, value);
+}
+
+static const struct psp_funcs psp_v13_0_4_funcs = {
+	.init_microcode = psp_v13_0_4_init_microcode,
+	.bootloader_load_kdb = psp_v13_0_4_bootloader_load_kdb,
+	.bootloader_load_spl = psp_v13_0_4_bootloader_load_spl,
+	.bootloader_load_sysdrv = psp_v13_0_4_bootloader_load_sysdrv,
+	.bootloader_load_soc_drv = psp_v13_0_4_bootloader_load_soc_drv,
+	.bootloader_load_intf_drv = psp_v13_0_4_bootloader_load_intf_drv,
+	.bootloader_load_dbg_drv = psp_v13_0_4_bootloader_load_dbg_drv,
+	.bootloader_load_sos = psp_v13_0_4_bootloader_load_sos,
+	.ring_init = psp_v13_0_4_ring_init,
+	.ring_create = psp_v13_0_4_ring_create,
+	.ring_stop = psp_v13_0_4_ring_stop,
+	.ring_destroy = psp_v13_0_4_ring_destroy,
+	.ring_get_wptr = psp_v13_0_4_ring_get_wptr,
+	.ring_set_wptr = psp_v13_0_4_ring_set_wptr,
+};
+
+void psp_v13_0_4_set_psp_funcs(struct psp_context *psp)
+{
+	psp->funcs = &psp_v13_0_4_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.h b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.h
new file mode 100644
index 000000000000..8547b8d514d5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __PSP_V13_0_4_H__
+#define __PSP_V13_0_4_H__
+
+#include "amdgpu_psp.h"
+
+void psp_v13_0_4_set_psp_funcs(struct psp_context *psp);
+
+#endif
-- 
2.25.1

