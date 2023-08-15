Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B08C001B0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 04:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3CC10E14A;
	Tue, 15 Aug 2023 04:21:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBAC10E14A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 04:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZbNpunEfUVMxb2YCVjHWLV25Wv/Qldz2FjCi+VMEfbH/wiT7s5LliJcywg97HuWAatKwK4EF/W0HjSyOKnraLplP1u7gg0y6UhCso6WNpDui5eXkY09hFhfgRdl1Ksqph08NFSCbhMvBauZJ4ntvbzY3gC2k2dOKZrv5MVV3Fen8N3bR9SmvMJRnOUs7VEoA59VS/IJwDGsVCf/6UmWnuv2svu7xORxcKM2mpSOlAiOK2vHXLOnVcyaLVeFzx2wWQ/uszXagZ3TwcT3r2s1kkFxCPmYBqAHH2EmYg0IMZEb0Ci0cQjJl1MLC26U+0cbvvki3E9mYDmb2K1tke07eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6yAN3PEe1waPZK2PO0U8I7LZZNGNybWdcsbnqtWxWo=;
 b=R9rnY3cG1ua5DZ79fK4MTwPGsU44mFwXLW7MkdDk9U5uGhdqKM0jVHZPlHJsWvHYQR6E4JoixsL0shHP3tUSzjpVQvZptWrR9BZNW5lDfr0+KZnm/nYZ2ZmgiV0i5wzps/UvpmEswfT6Rwd4lvm+1xzPTTUmGPxciU9lXmMQbUNiDE1Hh72bJDk1mZqbM/DvBzKlwhUB4NaeokG4ILdkHEIOCWkpcH3ux8TFdh2dC//l9zUZseVwdoNARw+MZDuHL01gFZ8DlqfO1/e0RlLR8o2CBZtw2TYNBv10KnnA8dyHVlGyn5e7UsD/H0VAM03XlzGS1cAemyr9BefpbhyuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6yAN3PEe1waPZK2PO0U8I7LZZNGNybWdcsbnqtWxWo=;
 b=fc2vPJcUgAxXLcbE2mkKxkdqzqixEupcJeUZUiX9+Jou3DUQ9gjkI57zh2fD8iR9L9qBglRHiohGmPxoRAdJ+89IStrMGuMSD2SvPXs+eVYvgx81dH372XuI/Z8JbccQv738KwX4cbLqsw0UVNC7THRgTgCD5weGgTYYA0nezFo=
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 04:21:17 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::48) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 04:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Tue, 15 Aug 2023 04:21:16 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 23:21:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Drop USB-C PD F/W flashing support
Date: Mon, 14 Aug 2023 22:35:47 -0500
Message-ID: <20230815033547.65220-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: acf6586a-f668-40d2-a021-08db9d47116d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tygpJq39TPqjSg/f+tyeSUmZ0d9l/Ye/qE7jhZmlB++6d0jp2UdA1KzwSQWVgGMZ/HeYcNig2jGaPlWGJW51b7rBWTE5KXCzJnRcqxfjPC3Ws59BsGTTNLdjesEDmP7Xq1HdxRB7GfldeaDk3vPqJn0Ok/uQqEOEpzHze1Dd31MzRGQZ7Fot8XFajFpLGfJVHjBosDLcI1z9xL7gtJ6ph+X9/ucoqKfkOUWRc/1Ipsi6a+FQClQr/pmM2Yz9Szz+0egAEaSZ1AGLHEUI9Psgw3qZNRU5FKXM7zht32zdUKBk51ZSc2igcMb3vY71A1OdVSZiwwOPJaeqohodHLcxscrwH7IlusJQ+tP61nleZfDCkWF98kbrcfkktMn6eZzIz7+yzn888kj4JmyyHC38eECSigsYbAPqgmy6Cs1F4npQphtbK1i/X5VvFdIOCxkhoAKNX0M9mhLqui8z6ooJwZ+gbqEBzCj5C5Sp0Fqe60wubtQbHPGUzklGHGpI6CTo8HjsS0oBd9splv5wT/5EN4Q0ry85qjFBUKIJYYwIlA6H+mmZpvYquRPNwrX2mrpTdafp1hxI91Tl3PIf8YY3M/Nb4Sgj3KzSNPHzeXUgUfGLeU6zcGke4+CbHZV/9uHZ1zQSTL9zLtfVmUYobqxqx/isUxRwSlbB4WnyMMEbSVgXcRq+w91f3vDcqxymx1aq8w1mwDl5VLTk++KMfHVSNQD7xo5V4DDyTrGFrGxmg5SOcp8bP8SuRtERTHBHzdCPifPHpQZIJ7Se75BqWozxeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(82310400008)(451199021)(1800799006)(186006)(36840700001)(40470700004)(46966006)(6666004)(40480700001)(7696005)(40460700003)(478600001)(81166007)(356005)(82740400003)(2906002)(5660300002)(36756003)(30864003)(86362001)(44832011)(4326008)(6916009)(336012)(70586007)(70206006)(41300700001)(8936002)(8676002)(316002)(16526019)(1076003)(26005)(36860700001)(47076005)(2616005)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 04:21:16.2130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf6586a-f668-40d2-a021-08db9d47116d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This support was introduced for pre-navi3x dGPUS.  The interface that
this was wired up to isn't usable by fwupd, and no devices had a need
to release firmware into the wild.

Navi3x dGPUs introduce an interface that can flash the entire IFWI
image that is acceptable by userspace software like fwupd.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/flashing.rst   | 12 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 91 -------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 10 ---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 60 ----------------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 60 ----------------
 5 files changed, 233 deletions(-)

diff --git a/Documentation/gpu/amdgpu/flashing.rst b/Documentation/gpu/amdgpu/flashing.rst
index bd745c42a538f..4556d58866e8e 100644
--- a/Documentation/gpu/amdgpu/flashing.rst
+++ b/Documentation/gpu/amdgpu/flashing.rst
@@ -16,18 +16,6 @@ The IFWI flash process is:
 3. "Read" from the `psp_vbflash` sysfs file to initiate the flash process.
 4. Poll the `psp_vbflash_status` sysfs file to determine when the flash process completes.
 
-USB-C PD F/W
-------------
-On GPUs that support flashing an updated USB-C PD firmware image, the process
-is done using the `usbc_pd_fw` sysfs file.
-
-* Reading the file will provide the current firmware version.
-* Writing the name of a firmware payload stored in `/lib/firmware/amdgpu` to the sysfs file will initiate the flash process.
-
-The firmware payload stored in `/lib/firmware/amdgpu` can be named any name
-as long as it doesn't conflict with other existing binaries that are used by
-`amdgpu`.
-
 sysfs files
 -----------
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8fdca54bb8a11..15450b9aabdae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3471,88 +3471,6 @@ static int psp_set_powergating_state(void *handle,
 	return 0;
 }
 
-static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t fw_ver;
-	int ret;
-
-	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
-		DRM_INFO("PSP block is not ready yet.");
-		return -EBUSY;
-	}
-
-	mutex_lock(&adev->psp.mutex);
-	ret = psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
-	mutex_unlock(&adev->psp.mutex);
-
-	if (ret) {
-		DRM_ERROR("Failed to read USBC PD FW, err = %d", ret);
-		return ret;
-	}
-
-	return sysfs_emit(buf, "%x\n", fw_ver);
-}
-
-static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
-						       struct device_attribute *attr,
-						       const char *buf,
-						       size_t count)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret, idx;
-	char fw_name[100];
-	const struct firmware *usbc_pd_fw;
-	struct amdgpu_bo *fw_buf_bo = NULL;
-	uint64_t fw_pri_mc_addr;
-	void *fw_pri_cpu_addr;
-
-	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
-		DRM_INFO("PSP block is not ready yet.");
-		return -EBUSY;
-	}
-
-	if (!drm_dev_enter(ddev, &idx))
-		return -ENODEV;
-
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
-	ret = request_firmware(&usbc_pd_fw, fw_name, adev->dev);
-	if (ret)
-		goto fail;
-
-	/* LFB address which is aligned to 1MB boundary per PSP request */
-	ret = amdgpu_bo_create_kernel(adev, usbc_pd_fw->size, 0x100000,
-				      AMDGPU_GEM_DOMAIN_VRAM |
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &fw_buf_bo, &fw_pri_mc_addr,
-				      &fw_pri_cpu_addr);
-	if (ret)
-		goto rel_buf;
-
-	memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
-
-	mutex_lock(&adev->psp.mutex);
-	ret = psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
-	mutex_unlock(&adev->psp.mutex);
-
-	amdgpu_bo_free_kernel(&fw_buf_bo, &fw_pri_mc_addr, &fw_pri_cpu_addr);
-
-rel_buf:
-	release_firmware(usbc_pd_fw);
-fail:
-	if (ret) {
-		DRM_ERROR("Failed to load USBC PD FW, err = %d", ret);
-		count = ret;
-	}
-
-	drm_dev_exit(idx);
-	return count;
-}
-
 void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size)
 {
 	int idx;
@@ -3566,15 +3484,6 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
 	drm_dev_exit(idx);
 }
 
-/**
- * DOC: usbc_pd_fw
- * Reading from this file will retrieve the USB-C PD firmware version. Writing to
- * this file will trigger the update process.
- */
-static DEVICE_ATTR(usbc_pd_fw, 0644,
-		   psp_usbc_pd_fw_sysfs_read,
-		   psp_usbc_pd_fw_sysfs_write);
-
 int is_psp_fw_valid(struct psp_bin_desc bin)
 {
 	return bin.size_bytes;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 3c7d9051b8c6b..4f62013ffed3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -128,8 +128,6 @@ struct psp_funcs {
 	int (*mem_training)(struct psp_context *psp, uint32_t ops);
 	uint32_t (*ring_get_wptr)(struct psp_context *psp);
 	void (*ring_set_wptr)(struct psp_context *psp, uint32_t value);
-	int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
-	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
 	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*vbflash_stat)(struct psp_context *psp);
 };
@@ -429,14 +427,6 @@ struct amdgpu_psp_funcs {
 #define psp_ring_get_wptr(psp) (psp)->funcs->ring_get_wptr((psp))
 #define psp_ring_set_wptr(psp, value) (psp)->funcs->ring_set_wptr((psp), (value))
 
-#define psp_load_usbc_pd_fw(psp, fw_pri_mc_addr) \
-	((psp)->funcs->load_usbc_pd_fw ? \
-	(psp)->funcs->load_usbc_pd_fw((psp), (fw_pri_mc_addr)) : -EINVAL)
-
-#define psp_read_usbc_pd_fw(psp, fw_ver) \
-	((psp)->funcs->read_usbc_pd_fw ? \
-	(psp)->funcs->read_usbc_pd_fw((psp), fw_ver) : -EINVAL)
-
 #define psp_update_spirom(psp, fw_pri_mc_addr) \
 	((psp)->funcs->update_spirom ? \
 	(psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 8f84fe40abbbb..8aaecc725ec19 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -586,64 +586,6 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
 }
 
-static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc_addr)
-{
-	struct amdgpu_device *adev = psp->adev;
-	uint32_t reg_status;
-	int ret, i = 0;
-
-	/*
-	 * LFB address which is aligned to 1MB address and has to be
-	 * right-shifted by 20 so that LFB address can be passed on a 32-bit C2P
-	 * register
-	 */
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));
-
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			     0x80000000, 0x80000000, false);
-	if (ret)
-		return ret;
-
-	/* Fireup interrupt so PSP can pick up the address */
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, (GFX_CMD_USB_PD_USE_LFB << 16));
-
-	/* FW load takes very long time */
-	do {
-		msleep(1000);
-		reg_status = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
-
-		if (reg_status & 0x80000000)
-			goto done;
-
-	} while (++i < USBC_PD_POLLING_LIMIT_S);
-
-	return -ETIME;
-done:
-
-	if ((reg_status & 0xFFFF) != 0) {
-		DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = 0x%04x\n",
-				reg_status & 0xFFFF);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
-{
-	struct amdgpu_device *adev = psp->adev;
-	int ret;
-
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
-
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-				     0x80000000, 0x80000000, false);
-	if (!ret)
-		*fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
-
-	return ret;
-}
-
 static const struct psp_funcs psp_v11_0_funcs = {
 	.init_microcode = psp_v11_0_init_microcode,
 	.bootloader_load_kdb = psp_v11_0_bootloader_load_kdb,
@@ -657,8 +599,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.mem_training = psp_v11_0_memory_training,
 	.ring_get_wptr = psp_v11_0_ring_get_wptr,
 	.ring_set_wptr = psp_v11_0_ring_set_wptr,
-	.load_usbc_pd_fw = psp_v11_0_load_usbc_pd_fw,
-	.read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw
 };
 
 void psp_v11_0_set_psp_funcs(struct psp_context *psp)
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 58db1ee631b39..46af460e60ed8 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -557,64 +557,6 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 	return 0;
 }
 
-static int psp_v13_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc_addr)
-{
-	struct amdgpu_device *adev = psp->adev;
-	uint32_t reg_status;
-	int ret, i = 0;
-
-	/*
-	 * LFB address which is aligned to 1MB address and has to be
-	 * right-shifted by 20 so that LFB address can be passed on a 32-bit C2P
-	 * register
-	 */
-	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));
-
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
-			     0x80000000, 0x80000000, false);
-	if (ret)
-		return ret;
-
-	/* Fireup interrupt so PSP can pick up the address */
-	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35, (GFX_CMD_USB_PD_USE_LFB << 16));
-
-	/* FW load takes very long time */
-	do {
-		msleep(1000);
-		reg_status = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35);
-
-		if (reg_status & 0x80000000)
-			goto done;
-
-	} while (++i < USBC_PD_POLLING_LIMIT_S);
-
-	return -ETIME;
-done:
-
-	if ((reg_status & 0xFFFF) != 0) {
-		DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %04x\n",
-				reg_status & 0xFFFF);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static int psp_v13_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
-{
-	struct amdgpu_device *adev = psp->adev;
-	int ret;
-
-	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
-
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
-				     0x80000000, 0x80000000, false);
-	if (!ret)
-		*fw_ver = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36);
-
-	return ret;
-}
-
 static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
 {
 	uint32_t reg_status = 0, reg_val = 0;
@@ -707,8 +649,6 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.ring_get_wptr = psp_v13_0_ring_get_wptr,
 	.ring_set_wptr = psp_v13_0_ring_set_wptr,
 	.mem_training = psp_v13_0_memory_training,
-	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
-	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
 	.update_spirom = psp_v13_0_update_spirom,
 	.vbflash_stat = psp_v13_0_vbflash_status
 };
-- 
2.34.1

