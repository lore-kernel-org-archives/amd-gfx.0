Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2EAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB0B10E481;
	Thu,  5 May 2022 20:06:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 287A110E481
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti10OAT3Jnjl+ZDm6TyuRgj9XJMJQ6654JLlwwZWnx9hjAHEEBZtGS53YX0U3CGtCbr+TXDLin+c/DxiEOZ9IIMVVU0PAEQMhKqP+id0s+L8GmWWPRg52IxYVHnZJCYvWkONYT4qx1oq7bzQcdJt3tuY0xITsXS1eB0k214zH9S/UzI99nZbLtxqqlKnN8Mmbax6VZPyWZE+EqoKTm3pxUNvVkO/Bc3c/8F0htdJSDUJLT3MIz7qe+4k1N8wdVshZpFUGrMP4Xv2bWPJjgUimjB2Vc5glrVjh8i4Hy5ZS8rIck8DSteiol7Rg7/ZxWOaocpw1P2m6eA+0rz4fZEMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTCYA6TZVbq4PPzPJPT6S4Mhc4lE/o9pM5D4XGoFxls=;
 b=SxcrHm7ly7L/2GH52OyuNBGheQcKDjzoCxltaEJbRB5MMNDr/wAcBgzx0jHNNvWf/jtgAmdeRr/HyFjpyo/GW2kuXRsQGf4IZa6rsmudkxikfl7XNErEmzDFRZp3hKs46PhG7oStrWgwu3Jhx5asdor3r5gBACdTgv5Rj8b+TkPAjOpeLFqZEzuMaJ++JpwZzXVy62nDjxVabFm9FddTVVTwAFkHnH1s+iLsuLVtYs6ngTJkXm7JaL92S14kXjtCBPZaL6Az6ds6SqRrmZlf5staPWrpqEkklcdNHj8T6tgPTu+Jeo40wdPH8axSOy4TBkcrMP/ddyYgp6niSiytwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTCYA6TZVbq4PPzPJPT6S4Mhc4lE/o9pM5D4XGoFxls=;
 b=KvpjSmrsuQY+t5Tz0wXivQnptqOxz3F2cgP8G8unFW88N9K6I2WwTzds7ggIzia7PGlYj5Lzmpll/BgSxxEZ2zUb2okXQIoFex4Fp+agMPG6VUhUwtO7g52EDjzV/w6IYSbkUBZnwXsb/UEDe6JDCnz6eXgrq1ZW6JrxIeACv6Y=
Received: from DS7PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:3bb::32)
 by SN1PR12MB2543.namprd12.prod.outlook.com (2603:10b6:802:2a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 20:06:04 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::1e) by DS7PR03CA0087.outlook.office365.com
 (2603:10b6:5:3bb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Thu, 5 May 2022 20:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:06:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:06:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu/psp: Add VBIOS flash handler
Date: Thu, 5 May 2022 16:05:36 -0400
Message-ID: <20220505200538.1293584-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200538.1293584-1-alexander.deucher@amd.com>
References: <20220505200538.1293584-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d9eb062-0bac-4978-c70b-08da2ed2af16
X-MS-TrafficTypeDiagnostic: SN1PR12MB2543:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2543C53ACF262ED78E720A7BF7C29@SN1PR12MB2543.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDu8NZKcoJOUQHOeBDIXYwG2JcVdfBZPxQbAQQR4h7kq1AVGfJGS7IhDlR3H7HPZQWL7P0TJzTqasFrQGbrDCdwnV6iMwX6vqS633ff5ZniU6iiLI8QWsGHuebvGq7W5uniCzQO0X2zCsOG1eGnxYOI+VPMqxxUUs4/TTX0xNRUyRf93EimdGuIXNqHncbDL9jZ5J9tifoemKAYZGHUn/sBCX0bBW2qIywsHrHbFnGyKrD7vXkeKFhwj/av8oAG8o7bl+nSM233PXZZl0D2gwsrWAxdPSQpkYl0q8fEZNFbgvnc3RRTmcvHebSNAMY1a2beE+o+Lw1L7U72s+NWDbuJzGO3aD0tnbX3EuhBQr0nWFVi7BgbrskomzqHFIGLAPccN0GoZzsf2MEUPNmXEYkDhZ/O/uQubOQmcNlE7l70gK2YYsdNn4LA3AcIWn8UB9dPZytIDoE1Ma9kDp1ElxuogW431wHPegc7MCf9yDaj/1L+7Ea0M1b9BOKnHARmao9VZ+RXMJnrAyqzhMfES6LexT0cIKXZOPSXKgjEege0RXp7IiS7DqqOrOHCdzObCsXldrxPhGbjDOvTTahQvPKQCHmMZaZVfu6Vtnd9Nk1i9zTG8Ggoe0lQKrwFGHSxHWam1fN7DCdMqBohr+wIuV7IsolyDMo9YZyhOxELTomavHN+8nLTpJQbMdHPFFPqqqV822sJm29N4MWHXfjvPZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(16526019)(186003)(336012)(7696005)(6916009)(83380400001)(2906002)(47076005)(426003)(54906003)(2616005)(1076003)(36756003)(8936002)(36860700001)(70206006)(40460700003)(70586007)(86362001)(316002)(82310400005)(26005)(8676002)(4326008)(6666004)(508600001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:06:04.0924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9eb062-0bac-4978-c70b-08da2ed2af16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2543
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Add psp vbflash function for psp v13.

v2: fix warnings

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  5 ++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 74 ++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index a9fe05c38715..81ecbdeb1ddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -129,6 +129,7 @@ struct psp_funcs
 	void (*ring_set_wptr)(struct psp_context *psp, uint32_t value);
 	int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
+	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 };
 
 #define AMDGPU_XGMI_MAX_CONNECTED_NODES		64
@@ -417,6 +418,10 @@ struct amdgpu_psp_funcs {
 	((psp)->funcs->read_usbc_pd_fw ? \
 	(psp)->funcs->read_usbc_pd_fw((psp), fw_ver) : -EINVAL)
 
+#define psp_update_spirom(psp, fw_pri_mc_addr) \
+	((psp)->funcs->update_spirom ? \
+	(psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
+
 extern const struct amd_ip_funcs psp_ip_funcs;
 
 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 9beb94681dd2..894ac0c64bf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -50,6 +50,15 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
 /* Read USB-PD from LFB */
 #define GFX_CMD_USB_PD_USE_LFB 0x480
 
+/* VBIOS gfl defines */
+#define MBOX_READY_MASK 0x80000000
+#define MBOX_STATUS_MASK 0x0000FFFF
+#define MBOX_COMMAND_MASK 0x00FF0000
+#define MBOX_READY_FLAG 0x80000000
+#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
+#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
+#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
+
 static int psp_v13_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -465,6 +474,68 @@ static int psp_v13_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
 	return ret;
 }
 
+static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
+{
+	uint32_t reg_status = 0, reg_val = 0;
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	/* clear MBX ready (MBOX_READY_MASK bit is 0) and set update command */
+	reg_val |= (cmd << 16);
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_115,  reg_val);
+
+	/* Ring the doorbell */
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
+
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
+				MBOX_READY_FLAG, MBOX_READY_MASK, false);
+	if (ret) {
+		dev_err(adev->dev, "SPI cmd %x timed out, ret = %d", cmd, ret);
+		return ret;
+	}
+
+	reg_status = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_115);
+	if ((reg_status & 0xFFFF) != 0) {
+		dev_err(adev->dev, "SPI cmd %x failed, fail status = %04x\n",
+				cmd, reg_status & 0xFFFF);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int psp_v13_0_update_spirom(struct psp_context *psp, uint64_t fw_pri_mc_addr)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	/* Confirm PSP is ready to start */
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
+			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
+	if (ret) {
+		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
+		return ret;
+	}
+
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, lower_32_bits(fw_pri_mc_addr));
+
+	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO);
+	if (ret)
+		return ret;
+
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, upper_32_bits(fw_pri_mc_addr));
+
+	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI);
+	if (ret)
+		return ret;
+
+	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
@@ -481,7 +552,8 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.ring_get_wptr = psp_v13_0_ring_get_wptr,
 	.ring_set_wptr = psp_v13_0_ring_set_wptr,
 	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
-	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw
+	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
+	.update_spirom = psp_v13_0_update_spirom
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.35.1

