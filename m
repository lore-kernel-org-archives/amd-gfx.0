Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BDDC48BC1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 17:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2037910EE6D;
	Mon, 12 Feb 2024 17:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R3R4CeqG";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1AE10EE53
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 17:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM4bK3fTxeVQAtfOcVAhO25MKurq4Hv714ysTw1kn6n2GcZg1jQ508PvPCYLXIYSjSlKW5iHsJ97YspYoeelsVqE5X+KzzoPayY9We53L/oEv58Mb0PCneZ8X/BNE5asBVooyxbcyyFlkZMoZ8i8HSaUvzkfBoEq1p+hy5O5aGTTtpZEBjxm0M0+iqx6gj6n3QzHK2GMvSq8cfh/6ZBX/GqoKYYqaflcIBiuTgHjIXsZpvwr/iGjjWz7yngP9tzZx0rxfcdAlXec/ty4wKqNK7K8N5CGkvRrJV50MO6FqzzdeIDTdlMmXUtAbF221iHETxi/iXrA9xMSjNL+KT6RMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cFcHEl9fnM/yjChH9hDmHs+B5zBfCOB6qKKXWAI+Tk=;
 b=H2Jyj3g/Rm/MfuaOM3QAefyF+7gyFwnTU4sSC5mi7yNvnc3bf3qxznjz5kCRnYk44YDAioDl49Nk7WEku/IIdubvO/k7Oc4grrw4B/za1vz+doYxUtNJiAinnp4i4ZNHmQQfucR73p6VSpDKzcudfPvDOCpLDEC0O62NoxElCY8YzLmPMKvR7E8qmVsYswqvIlTwnUmG1wDc0Y2hsx8PK8XvHJILnWA4lLU8MvOn+QV1GjIkh142ACKDBWJHFtqNUrvuc5G81lU908zNvLwSyfYuBd/GgJwhTyjVOzHPWnlMgZZ0gjA1BPQFFFmVryLQQe2CtQUkPkfscQT2EpinZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cFcHEl9fnM/yjChH9hDmHs+B5zBfCOB6qKKXWAI+Tk=;
 b=R3R4CeqG5rr7OKJND/ohycpm1pJ3WwD1aiByTC5lVF3qY7DMf1VHPQ9CrQrPwhmUKNbHmtrrtHugYuaOu09vC+QbN3s2czqI+/SQU4Dye2qh2aZGhJx08eErlUH9xn/CDrxx525ikNzyIEoqHfVohJ6cqaAzEhvRSxf+RyiOIj4=
Received: from DM6PR06CA0068.namprd06.prod.outlook.com (2603:10b6:5:54::45) by
 IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Mon, 12 Feb
 2024 17:59:05 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::66) by DM6PR06CA0068.outlook.office365.com
 (2603:10b6:5:54::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 17:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 17:59:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:59:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/9] drm/amdgpu: Add psp v14_0 ip block support
Date: Mon, 12 Feb 2024 12:58:42 -0500
Message-ID: <20240212175849.433812-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240212175849.433812-1-alexander.deucher@amd.com>
References: <20240212175849.433812-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c019c1-3815-4474-ec5a-08dc2bf44d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3H4xmT+wNlzNEeQSkitQ/v9GEG+GDTGM+bG5X2EoV3GgSQJG2NBH/TFPQqDuNVfQLyOWwGLIk6Hpk9z9BLbrWgSKKtbRupzDcjvBWDLdplcF/xx20FZ0d0x9xAbs2PpX9UTwNzFHs25Crq22KZxVZCan7bV0thF/WTfDBFPvhy+LtIL0LGDA741Bcnqx29onXU+kNe0t3JnW61e/PSOfzRg/dJzxwVW68MOMslgH1dWOLDJKA0gICIULLMbHplaJcYnEk7QIH8xhPyrDoyz3W3N8WD4aAa8iLFYcuSW9/7t7mRjbU4VIDO4EWP5bbnStHC5ZVDhZh4SeTUDuzjbgHxiFP4NFtpZGA7Jo9+cjtmLvNOWmiyIGb7zGl8S0IObtxmHKwu/W5zW0E76zNDJDj+wuthaJdm6BotGgoYJ964/+uF85mjj+5odO56xOe4+lIJltsNabga06mToFcZuAg1jaM8pU5PeDoGPlWi0anOnoIdeeFPU7F1hPVaz5PpYGMnDCgoI/kiheYYmrZO2/3ExHuotCCoghJGJlueZRyHHSnfZGGxwX5WMWLfZmYmFV4Ssm9sZq2mPalNq2mRlIwWK560RUaiccWyfbzg3e3pI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(5660300002)(45080400002)(478600001)(41300700001)(66899024)(8936002)(4326008)(8676002)(2906002)(30864003)(70586007)(7696005)(6916009)(70206006)(54906003)(6666004)(316002)(16526019)(2616005)(83380400001)(336012)(426003)(81166007)(1076003)(356005)(86362001)(26005)(36756003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:59:05.2596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c019c1-3815-4474-ec5a-08dc2bf44d9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add psp v14_0 ip block support.

v2: rebase (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   3 +-
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c | 666 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.h |  30 ++
 3 files changed, 698 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v14_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index daccbc11176e..fa26a4e3a99d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -144,7 +144,8 @@ amdgpu-y += \
 	psp_v11_0_8.o \
 	psp_v12_0.o \
 	psp_v13_0.o \
-	psp_v13_0_4.o
+	psp_v13_0_4.o \
+	psp_v14_0.o
 
 # add DCE block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
new file mode 100644
index 000000000000..fc4caf752687
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -0,0 +1,666 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#include <drm/drm_drv.h>
+#include <linux/vmalloc.h>
+#include "amdgpu.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_ucode.h"
+#include "soc15_common.h"
+#include "psp_v14_0.h"
+
+#include "mp/mp_14_0_2_offset.h"
+#include "mp/mp_14_0_2_sh_mask.h"
+
+MODULE_FIRMWARE("amdgpu/psp_14_0_2_sos.bin");
+
+/* For large FW files the time to complete can be very long */
+#define USBC_PD_POLLING_LIMIT_S 240
+
+/* Read USB-PD from LFB */
+#define GFX_CMD_USB_PD_USE_LFB 0x480
+
+/* VBIOS gfl defines */
+#define MBOX_READY_MASK 0x80000000
+#define MBOX_STATUS_MASK 0x0000FFFF
+#define MBOX_COMMAND_MASK 0x00FF0000
+#define MBOX_READY_FLAG 0x80000000
+#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
+#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
+#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
+
+/* memory training timeout define */
+#define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
+
+static int psp_v14_0_init_microcode(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	char ucode_prefix[30];
+	int err = 0;
+
+	amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));
+
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(14, 0, 2):
+		err = psp_init_sos_microcode(psp, ucode_prefix);
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
+static bool psp_v14_0_is_sos_alive(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t sol_reg;
+
+	sol_reg = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);
+
+	return sol_reg != 0x0;
+}
+
+static int psp_v14_0_wait_for_bootloader(struct psp_context *psp)
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
+				   SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
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
+static int psp_v14_0_bootloader_load_component(struct psp_context  	*psp,
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
+	if (psp_v14_0_is_sos_alive(psp))
+		return 0;
+
+	ret = psp_v14_0_wait_for_bootloader(psp);
+	if (ret)
+		return ret;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+
+	/* Copy PSP KDB binary to memory */
+	memcpy(psp->fw_pri_buf, bin_desc->start_addr, bin_desc->size_bytes);
+
+	/* Provide the PSP KDB to bootloader */
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36,
+	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
+	psp_gfxdrv_command_reg = bl_cmd;
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_35,
+	       psp_gfxdrv_command_reg);
+
+	ret = psp_v14_0_wait_for_bootloader(psp);
+
+	return ret;
+}
+
+static int psp_v14_0_bootloader_load_kdb(struct psp_context *psp)
+{
+	return psp_v14_0_bootloader_load_component(psp, &psp->kdb, PSP_BL__LOAD_KEY_DATABASE);
+}
+
+static int psp_v14_0_bootloader_load_spl(struct psp_context *psp)
+{
+	return psp_v14_0_bootloader_load_component(psp, &psp->kdb, PSP_BL__LOAD_TOS_SPL_TABLE);
+}
+
+static int psp_v14_0_bootloader_load_sysdrv(struct psp_context *psp)
+{
+	return psp_v14_0_bootloader_load_component(psp, &psp->sys, PSP_BL__LOAD_SYSDRV);
+}
+
+static int psp_v14_0_bootloader_load_soc_drv(struct psp_context *psp)
+{
+	return psp_v14_0_bootloader_load_component(psp, &psp->soc_drv, PSP_BL__LOAD_SOCDRV);
+}
+
+static int psp_v14_0_bootloader_load_intf_drv(struct psp_context *psp)
+{
+	return psp_v14_0_bootloader_load_component(psp, &psp->intf_drv, PSP_BL__LOAD_INTFDRV);
+}
+
+static int psp_v14_0_bootloader_load_dbg_drv(struct psp_context *psp)
+{
+	return psp_v14_0_bootloader_load_component(psp, &psp->dbg_drv, PSP_BL__LOAD_DBGDRV);
+}
+
+static int psp_v14_0_bootloader_load_ras_drv(struct psp_context *psp)
+{
+	return psp_v14_0_bootloader_load_component(psp, &psp->ras_drv, PSP_BL__LOAD_RASDRV);
+}
+
+
+static int psp_v14_0_bootloader_load_sos(struct psp_context *psp)
+{
+	int ret;
+	unsigned int psp_gfxdrv_command_reg = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	/* Check sOS sign of life register to confirm sys driver and sOS
+	 * are already been loaded.
+	 */
+	if (psp_v14_0_is_sos_alive(psp))
+		return 0;
+
+	ret = psp_v14_0_wait_for_bootloader(psp);
+	if (ret)
+		return ret;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+
+	/* Copy Secure OS binary to PSP memory */
+	memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_bytes);
+
+	/* Provide the PSP secure OS to bootloader */
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36,
+	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
+	psp_gfxdrv_command_reg = PSP_BL__LOAD_SOSDRV;
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_35,
+	       psp_gfxdrv_command_reg);
+
+	/* there might be handshake issue with hardware which needs delay */
+	mdelay(20);
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_81),
+			   RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81),
+			   0, true);
+
+	return ret;
+}
+
+static int psp_v14_0_ring_stop(struct psp_context *psp,
+			       enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
+	} else {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64,
+			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+	}
+
+	return ret;
+}
+
+static int psp_v14_0_ring_create(struct psp_context *psp,
+				 enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	unsigned int psp_ring_reg = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = psp_v14_0_ring_stop(psp, ring_type);
+		if (ret) {
+			DRM_ERROR("psp_v14_0_ring_stop_sriov failed!\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_102 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_103 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_103, psp_ring_reg);
+
+		/* Write the ring initialization command to C2PMSG_101 */
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_101 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
+
+	} else {
+		/* Wait for sOS ready for ring creation */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+		if (ret) {
+			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_69 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_69, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_70 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_70, psp_ring_reg);
+		/* Write size of ring to C2PMSG_71 */
+		psp_ring_reg = ring->ring_size;
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_71, psp_ring_reg);
+		/* Write the ring initialization command to C2PMSG_64 */
+		psp_ring_reg = ring_type;
+		psp_ring_reg = psp_ring_reg << 16;
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64, psp_ring_reg);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_64 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
+	}
+
+	return ret;
+}
+
+static int psp_v14_0_ring_destroy(struct psp_context *psp,
+				  enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ret = psp_v14_0_ring_stop(psp, ring_type);
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
+static uint32_t psp_v14_0_ring_get_wptr(struct psp_context *psp)
+{
+	uint32_t data;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev))
+		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
+	else
+		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67);
+
+	return data;
+}
+
+static void psp_v14_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, value);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_CONSUME_CMD);
+	} else
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67, value);
+}
+
+static int psp_v14_0_memory_training_send_msg(struct psp_context *psp, int msg)
+{
+	int ret;
+	int i;
+	uint32_t data_32;
+	int max_wait;
+	struct amdgpu_device *adev = psp->adev;
+
+	data_32 = (psp->mem_train_ctx.c2p_train_data_offset >> 20);
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36, data_32);
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_35, msg);
+
+	max_wait = MEM_TRAIN_SEND_MSG_TIMEOUT_US / adev->usec_timeout;
+	for (i = 0; i < max_wait; i++) {
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
+				   0x80000000, 0x80000000, false);
+		if (ret == 0)
+			break;
+	}
+	if (i < max_wait)
+		ret = 0;
+	else
+		ret = -ETIME;
+
+	dev_dbg(adev->dev, "training %s %s, cost %d @ %d ms\n",
+		  (msg == PSP_BL__DRAM_SHORT_TRAIN) ? "short" : "long",
+		  (ret == 0) ? "succeed" : "failed",
+		  i, adev->usec_timeout/1000);
+	return ret;
+}
+
+
+static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
+{
+	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
+	uint32_t *pcache = (uint32_t *)ctx->sys_cache;
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t p2c_header[4];
+	uint32_t sz;
+	void *buf;
+	int ret, idx;
+
+	if (ctx->init == PSP_MEM_TRAIN_NOT_SUPPORT) {
+		dev_dbg(adev->dev, "Memory training is not supported.\n");
+		return 0;
+	} else if (ctx->init != PSP_MEM_TRAIN_INIT_SUCCESS) {
+		dev_err(adev->dev, "Memory training initialization failure.\n");
+		return -EINVAL;
+	}
+
+	if (psp_v14_0_is_sos_alive(psp)) {
+		dev_dbg(adev->dev, "SOS is alive, skip memory training.\n");
+		return 0;
+	}
+
+	amdgpu_device_vram_access(adev, ctx->p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);
+	dev_dbg(adev->dev, "sys_cache[%08x,%08x,%08x,%08x] p2c_header[%08x,%08x,%08x,%08x]\n",
+		  pcache[0], pcache[1], pcache[2], pcache[3],
+		  p2c_header[0], p2c_header[1], p2c_header[2], p2c_header[3]);
+
+	if (ops & PSP_MEM_TRAIN_SEND_SHORT_MSG) {
+		dev_dbg(adev->dev, "Short training depends on restore.\n");
+		ops |= PSP_MEM_TRAIN_RESTORE;
+	}
+
+	if ((ops & PSP_MEM_TRAIN_RESTORE) &&
+	    pcache[0] != MEM_TRAIN_SYSTEM_SIGNATURE) {
+		dev_dbg(adev->dev, "sys_cache[0] is invalid, restore depends on save.\n");
+		ops |= PSP_MEM_TRAIN_SAVE;
+	}
+
+	if (p2c_header[0] == MEM_TRAIN_SYSTEM_SIGNATURE &&
+	    !(pcache[0] == MEM_TRAIN_SYSTEM_SIGNATURE &&
+	      pcache[3] == p2c_header[3])) {
+		dev_dbg(adev->dev, "sys_cache is invalid or out-of-date, need save training data to sys_cache.\n");
+		ops |= PSP_MEM_TRAIN_SAVE;
+	}
+
+	if ((ops & PSP_MEM_TRAIN_SAVE) &&
+	    p2c_header[0] != MEM_TRAIN_SYSTEM_SIGNATURE) {
+		dev_dbg(adev->dev, "p2c_header[0] is invalid, save depends on long training.\n");
+		ops |= PSP_MEM_TRAIN_SEND_LONG_MSG;
+	}
+
+	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
+		ops &= ~PSP_MEM_TRAIN_SEND_SHORT_MSG;
+		ops |= PSP_MEM_TRAIN_SAVE;
+	}
+
+	dev_dbg(adev->dev, "Memory training ops:%x.\n", ops);
+
+	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
+		/*
+		 * Long training will encroach a certain amount on the bottom of VRAM;
+		 * save the content from the bottom of VRAM to system memory
+		 * before training, and restore it after training to avoid
+		 * VRAM corruption.
+		 */
+		sz = BIST_MEM_TRAINING_ENCROACHED_SIZE;
+
+		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
+			dev_err(adev->dev, "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
+				  adev->gmc.visible_vram_size,
+				  adev->mman.aper_base_kaddr);
+			return -EINVAL;
+		}
+
+		buf = vmalloc(sz);
+		if (!buf) {
+			dev_err(adev->dev, "failed to allocate system memory.\n");
+			return -ENOMEM;
+		}
+
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
+			ret = psp_v14_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
+			if (ret) {
+				DRM_ERROR("Send long training msg failed.\n");
+				vfree(buf);
+				drm_dev_exit(idx);
+				return ret;
+			}
+
+			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
+			adev->hdp.funcs->flush_hdp(adev, NULL);
+			vfree(buf);
+			drm_dev_exit(idx);
+		} else {
+			vfree(buf);
+			return -ENODEV;
+		}
+	}
+
+	if (ops & PSP_MEM_TRAIN_SAVE) {
+		amdgpu_device_vram_access(psp->adev, ctx->p2c_train_data_offset, ctx->sys_cache, ctx->train_data_size, false);
+	}
+
+	if (ops & PSP_MEM_TRAIN_RESTORE) {
+		amdgpu_device_vram_access(psp->adev, ctx->c2p_train_data_offset, ctx->sys_cache, ctx->train_data_size, true);
+	}
+
+	if (ops & PSP_MEM_TRAIN_SEND_SHORT_MSG) {
+		ret = psp_v14_0_memory_training_send_msg(psp, (amdgpu_force_long_training > 0) ?
+							 PSP_BL__DRAM_LONG_TRAIN : PSP_BL__DRAM_SHORT_TRAIN);
+		if (ret) {
+			dev_err(adev->dev, "send training msg failed.\n");
+			return ret;
+		}
+	}
+	ctx->training_cnt++;
+	return 0;
+}
+
+static int psp_v14_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc_addr)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t reg_status;
+	int ret, i = 0;
+
+	/*
+	 * LFB address which is aligned to 1MB address and has to be
+	 * right-shifted by 20 so that LFB address can be passed on a 32-bit C2P
+	 * register
+	 */
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));
+
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
+			     0x80000000, 0x80000000, false);
+	if (ret)
+		return ret;
+
+	/* Fireup interrupt so PSP can pick up the address */
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_35, (GFX_CMD_USB_PD_USE_LFB << 16));
+
+	/* FW load takes very long time */
+	do {
+		msleep(1000);
+		reg_status = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_35);
+
+		if (reg_status & 0x80000000)
+			goto done;
+
+	} while (++i < USBC_PD_POLLING_LIMIT_S);
+
+	return -ETIME;
+done:
+
+	if ((reg_status & 0xFFFF) != 0) {
+		DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %04x\n",
+				reg_status & 0xFFFF);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int psp_v14_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
+
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
+				     0x80000000, 0x80000000, false);
+	if (!ret)
+		*fw_ver = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36);
+
+	return ret;
+}
+
+static int psp_v14_0_exec_spi_cmd(struct psp_context *psp, int cmd)
+{
+	uint32_t reg_status = 0, reg_val = 0;
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	/* clear MBX ready (MBOX_READY_MASK bit is 0) and set update command */
+	reg_val |= (cmd << 16);
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_115,  reg_val);
+
+	/* Ring the doorbell */
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_73, 1);
+
+	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
+		return 0;
+
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
+				MBOX_READY_FLAG, MBOX_READY_MASK, false);
+	if (ret) {
+		dev_err(adev->dev, "SPI cmd %x timed out, ret = %d", cmd, ret);
+		return ret;
+	}
+
+	reg_status = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_115);
+	if ((reg_status & 0xFFFF) != 0) {
+		dev_err(adev->dev, "SPI cmd %x failed, fail status = %04x\n",
+				cmd, reg_status & 0xFFFF);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int psp_v14_0_update_spirom(struct psp_context *psp,
+				   uint64_t fw_pri_mc_addr)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	/* Confirm PSP is ready to start */
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
+			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
+	if (ret) {
+		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
+		return ret;
+	}
+
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_116, lower_32_bits(fw_pri_mc_addr));
+
+	ret = psp_v14_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO);
+	if (ret)
+		return ret;
+
+	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_116, upper_32_bits(fw_pri_mc_addr));
+
+	ret = psp_v14_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI);
+	if (ret)
+		return ret;
+
+	psp->vbflash_done = true;
+
+	ret = psp_v14_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int psp_v14_0_vbflash_status(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	return RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_115);
+}
+
+static const struct psp_funcs psp_v14_0_funcs = {
+	.init_microcode = psp_v14_0_init_microcode,
+	.bootloader_load_kdb = psp_v14_0_bootloader_load_kdb,
+	.bootloader_load_spl = psp_v14_0_bootloader_load_spl,
+	.bootloader_load_sysdrv = psp_v14_0_bootloader_load_sysdrv,
+	.bootloader_load_soc_drv = psp_v14_0_bootloader_load_soc_drv,
+	.bootloader_load_intf_drv = psp_v14_0_bootloader_load_intf_drv,
+	.bootloader_load_dbg_drv = psp_v14_0_bootloader_load_dbg_drv,
+	.bootloader_load_ras_drv = psp_v14_0_bootloader_load_ras_drv,
+	.bootloader_load_sos = psp_v14_0_bootloader_load_sos,
+	.ring_create = psp_v14_0_ring_create,
+	.ring_stop = psp_v14_0_ring_stop,
+	.ring_destroy = psp_v14_0_ring_destroy,
+	.ring_get_wptr = psp_v14_0_ring_get_wptr,
+	.ring_set_wptr = psp_v14_0_ring_set_wptr,
+	.mem_training = psp_v14_0_memory_training,
+	.load_usbc_pd_fw = psp_v14_0_load_usbc_pd_fw,
+	.read_usbc_pd_fw = psp_v14_0_read_usbc_pd_fw,
+	.update_spirom = psp_v14_0_update_spirom,
+	.vbflash_stat = psp_v14_0_vbflash_status
+};
+
+void psp_v14_0_set_psp_funcs(struct psp_context *psp)
+{
+	psp->funcs = &psp_v14_0_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.h b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.h
new file mode 100644
index 000000000000..cb7ee54529b4
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#ifndef __PSP_V14_0_H__
+#define __PSP_V14_0_H__
+
+#include "amdgpu_psp.h"
+
+void psp_v14_0_set_psp_funcs(struct psp_context *psp);
+
+#endif
-- 
2.42.0

