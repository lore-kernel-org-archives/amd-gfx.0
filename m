Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2177CD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 08:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5182810E71F;
	Mon, 18 May 2026 08:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NSL8UDiz";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763BD10E71F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 08:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/bIaC9cfMzrSSPypGjHkLuzojdSmmSm2Gj3esdQJcIGBmLdZuwq+ZzYIoKY0Q6weZlyND/V1dKhlHqDQkJCrA6DcDMiDHS5y+DqRdWtjgLQYPtl88LaFFEcly0SH9spWvqum/hQpF0wOwm3DNHPsxLDmLwgHZ6ZgnE0PWsgCr3b27kuh332RKy4H2Ar+X4rmpDn/Gv1U+hdSjnRUed5q6FoYNiIxOZQNA5+5JWDDd8YOjDj+LCnFIRoDAbX7hz5206Pbhx3pTduebJLcNVWYIhh6skFlZxWsqK/qWuHqyEp+c5E7TCpt+jY89zBw0H4VN+6yo0IBHVdalTXSVj0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIurJXaDFPm3WKHgdkchW6uo6cAvV1ctuDtQbiRfE1I=;
 b=oTxkw6ZK9kEks75p5B2vgfIGuVKeEm5faJZ1TMDP5OLYsV1dvb41sL+EfvLlj2EGaKNQrK/DBGCBtl7WbvFXHWz0n1ScnVyMZKbHfWcaBXJbb9jHe6u3CdatHJzm55hAH+67QNV9bKU4iYQzrVNSRnoGSkW/U91esrwTQFHslqRWvCUETYjS1N4UH8a8+gvZtZ/njF9g4G4gIXbGp74n85TH5FXYc+pM3D8ByYxC6OSjDLP03r5mgLNvNiLY94xPjqavmUoalvYu2M3Ny/BA+4QK35nB7Mtly+OUN/FG3q0mXD0tFHXI3SFar2MGSKSVON+fXQnkC/iW5eQpBbh78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIurJXaDFPm3WKHgdkchW6uo6cAvV1ctuDtQbiRfE1I=;
 b=NSL8UDizGtXbwm+F16e6xyTe7+NM5IV1sUl6yvsfbXCK81kQQjN5MI/+Tk9PGyfxMeYwJ8o32Q+tm5+lj7vrWxlQ/E7sOqPvpOgANC8yANcgFGVQJazD8p03sGEuPTm9nsfQrJAguy4jj+H5mS3BEdX5JYOEb4ygu28unRm2/U8=
Received: from CYXPR02CA0029.namprd02.prod.outlook.com (2603:10b6:930:cc::27)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Mon, 18 May
 2026 08:33:54 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::d5) by CYXPR02CA0029.outlook.office365.com
 (2603:10b6:930:cc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 08:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 08:33:54 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 03:33:51 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: validate and share PSP fw_pri_buf copies via
 psp_copy_fw
Date: Mon, 18 May 2026 16:33:37 +0800
Message-ID: <20260518083337.790208-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb9079c-0832-412a-f751-08deb4b8323a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: nKW1Q+ISdQwnluKeDnbTCKQPIvz0QFhlyDO1gsTq/BmA/Uapa45AIDmPlvzUyWYl78MHQ4+5L9W+NzowEe7sstQcmJyN2A8Nd8m66vVHZrkT0pin3zfLM56kkIAGaPBGmfAdjT0KQXZ+fIKwKy1M6mQqgtASuPU03ZTqQ1QhpfVuu4Vl5TLsiLDin6cFc5SNGUlasL6lVnRUNzbimSP6clddO0LopeOudF0E5WFSni6HX1Qc5mkxv8LuC/tfP9W3Er61Z4Cq72H+i36NacStm/k4fzLjkfabhLLI061eANeaDeWmGoArHUyhrerU2BruZMkTBkt6dyegI7/dtxQGFcXZFW0fNpE3JJX/IEbns10yhRt91sLAYIuwLnb2ioXmK6usXzD+xsjiuUZFikif1NOd5DoLTgZMW8MZn+UAUqDOGk34jxkCdjq9VGK+ivT89kmF9Lo2s4URfhh04+zpLtNnUXPIn66Ro+xlxXz0UpR9wJB/4zGy1fjvQYDaduATd9xwm7H6iduEanzxkqefdGxH/5T+JCyp0saeGQleJhBHxdrkeiC4pgvtOCn/nhaM8wlphnnYGiCcmYwDD+paAXY2N41J3CU6Fqib5jaO+ZPD2yuV56ZVVfo3sZo5uXxBHEYs7fGmN2/Dmy1TZcEEqCdXEUxPxaiFlvfJVk4TYKBGRdFNw9IhOnnB/ot+zxWcPs5MigAV5BHha8dRv5Y0RGwKbua1tXNyTM58GUWMX3U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mupvpMyCbsXeVPJYGfGKn7fANY46CAtoIJhxEkSsB6VO0ucGE2vG1dPIQWo0DN7wzDwlEsAeAS0B88j6oIsT7y3kqejBGoXHi3H6HwqlzdhhbLprFyGSmCiJvX2L6nYJnHHTHliRn4EGtmos/g2jMShXAeBGsy4idi5rjKgfTcDKJ0lFZIEdSfZQ8gCB1YS6aPKYZJMj8brGfxtI/Fq7syCAVipCr1aBc1HwtUgoTf5Lv+96wbrx7hTTXuUnqvZxRLkfShJ9xGpNukNWjRYWF/CGn0FUScwXhac5FPsz28eWVE/pMRX8T2Z4Pld4B8M85tj0FF8ROfBsAJmMRQRGpYDaHyZgddHgPQ8N+zpU/yVMptRYt99guCurTwc9NgSmKcSa0CXt6rosCETL2MBnPM88iSbEVafXgc+f1wE/QTK5+/9MWbTIk+/ztm/vKlem
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:33:54.2020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb9079c-0832-412a-f751-08deb4b8323a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842
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

Change psp_copy_fw from void to int: return -ENODEV when drm_dev_enter
fails, and -EINVAL when the image size is zero or larger than the
1 MiB PSP private buffer.

Replace open-coded memset/memcpy into fw_pri_buf with psp_copy_fw.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 32 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c   |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c   | 14 +++++------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 14 +++++------
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c   | 14 +++++------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c    |  8 ++++--
 8 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9f79109acbeee5..e66943f85997cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -857,7 +857,11 @@ static int psp_load_toc(struct psp_context *psp,
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
 
 	/* Copy toc to psp firmware private buffer */
-	psp_copy_fw(psp, psp->toc.start_addr, psp->toc.size_bytes);
+	ret = psp_copy_fw(psp, psp->toc.start_addr, psp->toc.size_bytes);
+	if (ret) {
+		release_psp_cmd_buf(psp);
+		return ret;
+	}
 
 	psp_prep_load_toc_cmd_buf(cmd, psp->fw_pri_mc_addr, psp->toc.size_bytes);
 
@@ -1173,8 +1177,11 @@ static int psp_rl_load(struct amdgpu_device *adev)
 
 	cmd = acquire_psp_cmd_buf(psp);
 
-	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
-	memcpy(psp->fw_pri_buf, psp->rl.start_addr, psp->rl.size_bytes);
+	ret = psp_copy_fw(psp, psp->rl.start_addr, psp->rl.size_bytes);
+	if (ret) {
+		release_psp_cmd_buf(psp);
+		return ret;
+	}
 
 	cmd->cmd_id = GFX_CMD_ID_LOAD_IP_FW;
 	cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo = lower_32_bits(psp->fw_pri_mc_addr);
@@ -1760,8 +1767,12 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
 
 	cmd = acquire_psp_cmd_buf(psp);
 
-	psp_copy_fw(psp, context->bin_desc.start_addr,
-		    context->bin_desc.size_bytes);
+	ret = psp_copy_fw(psp, context->bin_desc.start_addr,
+			  context->bin_desc.size_bytes);
+	if (ret) {
+		release_psp_cmd_buf(psp);
+		return ret;
+	}
 
 	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) &&
 		context->mem_context.shared_bo)
@@ -4562,17 +4573,24 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	return count;
 }
 
-void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size)
+int psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size)
 {
 	int idx;
 
 	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
-		return;
+		return -ENODEV;
+
+	if (!bin_size || bin_size > PSP_1_MEG) {
+		dev_err(psp->adev->dev, "PSP firmware is invalid\n");
+		drm_dev_exit(idx);
+		return -EINVAL;
+	}
 
 	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
 	memcpy(psp->fw_pri_buf, start_addr, bin_size);
 
 	drm_dev_exit(idx);
+	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 4197179a770182..2d838b1b2b116c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -638,7 +638,7 @@ int psp_get_fw_attestation_records_addr(struct psp_context *psp,
 int psp_update_fw_reservation(struct psp_context *psp);
 int psp_load_fw_list(struct psp_context *psp,
 		     struct amdgpu_firmware_info **ucode_list, int ucode_count);
-void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size);
+int psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size);
 
 int psp_spatial_partition(struct psp_context *psp, int mode);
 int psp_memory_partition(struct psp_context *psp, int mode);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index fb7aaf5ae05cfb..479690c44f0d54 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -217,7 +217,9 @@ static int psp_v11_0_bootloader_load_component(struct psp_context  	*psp,
 		return ret;
 
 	/* Copy PSP System Driver binary to memory */
-	psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
+	ret = psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the sys driver to bootloader */
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
@@ -263,7 +265,9 @@ static int psp_v11_0_bootloader_load_sos(struct psp_context *psp)
 		return ret;
 
 	/* Copy Secure OS binary to PSP memory */
-	psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
+	ret = psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the PSP secure OS to bootloader */
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index c3cae29eeca1e5..f823f042788d15 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -87,7 +87,9 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_context *psp)
 		return ret;
 
 	/* Copy PSP System Driver binary to memory */
-	psp_copy_fw(psp, psp->sys.start_addr, psp->sys.size_bytes);
+	ret = psp_copy_fw(psp, psp->sys.start_addr, psp->sys.size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the sys driver to bootloader */
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
@@ -123,7 +125,9 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context *psp)
 		return ret;
 
 	/* Copy Secure OS binary to PSP memory */
-	psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
+	ret = psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the PSP secure OS to bootloader */
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index a0c84f81c0c9d5..00b4a34e6601f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -271,10 +271,9 @@ static int psp_v13_0_bootloader_load_component(struct psp_context  	*psp,
 	if (ret)
 		return ret;
 
-	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
-
-	/* Copy PSP KDB binary to memory */
-	memcpy(psp->fw_pri_buf, bin_desc->start_addr, bin_desc->size_bytes);
+	ret = psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the PSP KDB to bootloader */
 	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,
@@ -353,10 +352,9 @@ static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
 	if (ret)
 		return ret;
 
-	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
-
-	/* Copy Secure OS binary to PSP memory */
-	memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_bytes);
+	ret = psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the PSP secure OS to bootloader */
 	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
index 5f39a2edcc9562..3d5e26b3fa00ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -105,10 +105,9 @@ static int psp_v13_0_4_bootloader_load_component(struct psp_context  	*psp,
 	if (ret)
 		return ret;
 
-	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
-
-	/* Copy PSP KDB binary to memory */
-	memcpy(psp->fw_pri_buf, bin_desc->start_addr, bin_desc->size_bytes);
+	ret = psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the PSP KDB to bootloader */
 	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,
@@ -168,10 +167,9 @@ static int psp_v13_0_4_bootloader_load_sos(struct psp_context *psp)
 	if (ret)
 		return ret;
 
-	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
-
-	/* Copy Secure OS binary to PSP memory */
-	memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_bytes);
+	ret = psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the PSP secure OS to bootloader */
 	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 38dfc5c19f2a7e..040a61aefa8669 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -140,10 +140,9 @@ static int psp_v14_0_bootloader_load_component(struct psp_context  	*psp,
 	if (ret)
 		return ret;
 
-	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
-
-	/* Copy PSP KDB binary to memory */
-	memcpy(psp->fw_pri_buf, bin_desc->start_addr, bin_desc->size_bytes);
+	ret = psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the PSP KDB to bootloader */
 	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36,
@@ -214,10 +213,9 @@ static int psp_v14_0_bootloader_load_sos(struct psp_context *psp)
 	if (ret)
 		return ret;
 
-	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
-
-	/* Copy Secure OS binary to PSP memory */
-	memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_bytes);
+	ret = psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the PSP secure OS to bootloader */
 	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index f5030efc6c804a..24856c91c1351b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -96,7 +96,9 @@ static int psp_v3_1_bootloader_load_sysdrv(struct psp_context *psp)
 		return ret;
 
 	/* Copy PSP System Driver binary to memory */
-	psp_copy_fw(psp, psp->sys.start_addr, psp->sys.size_bytes);
+	ret = psp_copy_fw(psp, psp->sys.start_addr, psp->sys.size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the sys driver to bootloader */
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
@@ -135,7 +137,9 @@ static int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
 		return ret;
 
 	/* Copy Secure OS binary to PSP memory */
-	psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
+	ret = psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
+	if (ret)
+		return ret;
 
 	/* Provide the PSP secure OS to bootloader */
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
-- 
2.25.1

