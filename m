Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5495C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4820F10E1F7;
	Mon,  3 Jun 2024 01:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LOHgtfBf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948EA10E1B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb2TwhxiStZibdQw3DraDj+nvpnB8nMJtlFqebQQmkNA2dxZWjRudAA+mxRnE5E1+8mK9AS0z2q63l6Bp2MggjIAoNrkuLGmOSSLMr8UFcnkNNu5QEsdnKXqKirCCiuiJRWc3xCawupjY8JLxOisszKbwzgAYGvtWgGVvuukq/3FLSx28R17NZOuazOdHqs+do4VUta/z3Kl7mFeqP9CeEgjvF9L/g+LngLcOh9h39aLZYIgqjeEnCfHXS7+Tk09gPEgwfWYOUkPIrbBCEfE1rZs/gSeJXGlx7qU442DfkWZxaE0x8vuxkhwIqHttRAUzLTV2N9kr62yVLoWeGeaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgBr59qYfn1YicyFWuTRR2tnYCLp2sDHeU24ILTR2jY=;
 b=NF0WIQIHBehDqjBbzILVOHiJP6W3oGYzh0BFcv7uCJ4ydP6b2fpMkt+JpaAm/OMh4zQLt2ZUBWmg7v77KqwkjzkMF/zucLKsX2X8h2nJOrtqyOeogl86pGemoArgpK/DjOVgyxnb8kbW+RqrqunJNJoyqRW8Q6Xd2D7V3vg1uJ4iAjI7sGPi0Mqicvh/0j9XbQhyBHwjWuHMBe/Io0E4i56nZLcj8jA8WsmsvKvsiWb7FMAIe5FuZnLK9GuTkNPN0vu0CcsxYxTmOZTnK6Gz4/zibJQvzwAuZsRIP2vbOvLs/HrY5VIhnBHwcJvn+QzHf9tjbLZAVfJd/vSSi3MgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgBr59qYfn1YicyFWuTRR2tnYCLp2sDHeU24ILTR2jY=;
 b=LOHgtfBfBtJFGtM9H0YqACB8LvR+fBROCzkgp4CXaSth30Q+XOXQMl3dzP41DOfMnBYeUmgs6hh9JdytMsac6cxS/PVeI5o8RTWm3vQHYPEGTW4e/bzfIPcy036Z61R+m7thmeViFf8FQE+ELfqtrVjJrE7s+JcaAkqitmJhl0s=
Received: from BYAPR02CA0037.namprd02.prod.outlook.com (2603:10b6:a03:54::14)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Mon, 3 Jun
 2024 01:42:48 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::96) by BYAPR02CA0037.outlook.office365.com
 (2603:10b6:a03:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:47 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:46 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 05/18] drm/amdgpu: refine psp firmware loading
Date: Mon, 3 Jun 2024 09:41:59 +0800
Message-ID: <20240603014212.1969546-6-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e4f203-b81e-43d6-5f78-08dc836e78fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VGuhmK+SHQWGmLijEk3MJVMjuCbdca7YXrrlNaZNgMEqJQyft9wjCyOr+CuM?=
 =?us-ascii?Q?n4MhWXCW1O1ogY8glDaqXzNuEHNtRcmgCdzwui/K9Tmz1fFSF+r/4v68FhZR?=
 =?us-ascii?Q?2iz/BfuvEuEJgNU5VZCfU7Z45V2cM2BKjBZ1jai5Kuu1Mq4+MzfAy0ZRCUQQ?=
 =?us-ascii?Q?K2MF10eSiFLOe9Is2GVOcPocCrhhHz6qmbVOeaGDjACFjML4BLczhnKM9pL7?=
 =?us-ascii?Q?+HVVkRmzFL6WH2p1gKhLSa4WLAS84t/5tz2JSul/xtEkNCkxNkVVdZxoBO3g?=
 =?us-ascii?Q?tPKDfv3h9zbs1j9T4cZG15dn/7mlOfhhRrxiqoc+zOhkALCIpSbCfEPe/ECW?=
 =?us-ascii?Q?5EMHReY1fg9AtYx4MQE9FoVoB5nZRO/dSridFRZscyy/cj2bZJOWBA6YZPJu?=
 =?us-ascii?Q?l085TPsT095h9QUzxlShHcWbVV8wnNsWDr5aHpY5lKDEHizeSjw4dh5NeTPH?=
 =?us-ascii?Q?feNC06keOU+iO+YLU1+mLEzVkdBDIQ8WDF4CNI0hdXRxLXdamKa/Mkt/LQht?=
 =?us-ascii?Q?AzYNGOolcgxm7mKEH9VkGwwbCesJ9OZIGXhM2ACYY97YmpsfrwJKqK2SE2Qh?=
 =?us-ascii?Q?OloSirxhS6EvwqbEutJSiBGZon0qYEfQpdXNWIFWE7/yBAvkdNbR1di8t1cn?=
 =?us-ascii?Q?26q6d493iWafqGfZcPnk3AauzKyZOAjHB6wgHuAzby70/n1hyccIaGyHQQUg?=
 =?us-ascii?Q?k/Qy3OZCtE7ivUQTbELWvNPaHoF4/T6lSO1YF42cAc2sml9zYXdlrr16aLQ5?=
 =?us-ascii?Q?oU+/KjRctIaAfm01JbtOi77BrGEr8+NoI6F/z5hyCxzA1bJXAitaHb7OF7ZL?=
 =?us-ascii?Q?ynBkcCPbZKRRSL5YI3QXIAa0deit+ZIWoK4/gqdTBsdODdU9If/AaILD9O/a?=
 =?us-ascii?Q?NdyhxTpYTB6aE5CZ1GRhgDmdMeeq+U+aFw2OH9BUp13lO+1GzgH1zq3qhNdT?=
 =?us-ascii?Q?jxbIri45Pf4Oe1aOMkPbhEEJ8SYRfMeWHiHgi/Cs/N73anKnHw/SkfMPY+So?=
 =?us-ascii?Q?7xdOWb99nRLOZmySJGqRflzhRHac+yGq5oDNufnt/O/VxqxOkH6vfSegfxzb?=
 =?us-ascii?Q?m3J1i1o4MscSQdUnZ3C9MH/mkt7WWNaNNXX/pNWEKB7nrSDPBtBKY/W65b5u?=
 =?us-ascii?Q?69aWeujddl+kosKEaE2WbiZwBNAaU9hfQUSn8eED2KQ7u3EYubGJCY1iqCNf?=
 =?us-ascii?Q?SN/5OcetdWvnELgcvnnGOt3PGXuIvXSY0y2rIBPFULWkzWdsgaiXjlD46J40?=
 =?us-ascii?Q?i1/3ES9FtIJUTRzVS2KUlbtj9zNjo+OFA6sDvBhhgmTbDiqdSHRLTnecnMzi?=
 =?us-ascii?Q?988JcwYa3mAV+W6A7vbZV60crC9LEpAtF//NU1yfqvaEqUCMupB0XPpfllKB?=
 =?us-ascii?Q?at5LuyY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:47.8095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e4f203-b81e-43d6-5f78-08dc836e78fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

refine psp firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 26 +++++++------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6d1911773043..14fb4a5b4bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3184,12 +3184,10 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 int psp_init_asd_microcode(struct psp_context *psp, const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *asd_hdr;
 	int err = 0;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, "amdgpu/%s_asd.bin", chip_name);
 	if (err)
 		goto out;
 
@@ -3208,12 +3206,10 @@ int psp_init_asd_microcode(struct psp_context *psp, const char *chip_name)
 int psp_init_toc_microcode(struct psp_context *psp, const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *toc_hdr;
 	int err = 0;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_toc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, "amdgpu/%s_toc.bin", chip_name);
 	if (err)
 		goto out;
 
@@ -3365,7 +3361,6 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *sos_hdr;
 	const struct psp_firmware_header_v1_1 *sos_hdr_v1_1;
 	const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
@@ -3375,8 +3370,7 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 	uint8_t *ucode_array_start_addr;
 	int fw_index = 0;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_sos.bin", chip_name);
 	if (err)
 		goto out;
 
@@ -3601,11 +3595,9 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
 {
 	const struct common_firmware_header *hdr;
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[PSP_FW_NAME_LEN];
 	int err;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, "amdgpu/%s_ta.bin", chip_name);
 	if (err)
 		return err;
 
@@ -3631,7 +3623,6 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
 int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *cap_hdr_v1_0;
 	struct amdgpu_firmware_info *info = NULL;
 	int err = 0;
@@ -3641,8 +3632,7 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 		return -EINVAL;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_cap.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, "amdgpu/%s_cap.bin", chip_name);
 	if (err) {
 		if (err == -ENODEV) {
 			dev_warn(adev->dev, "cap microcode does not exist, skip\n");
@@ -3716,7 +3706,6 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int ret, idx;
-	char fw_name[100];
 	const struct firmware *usbc_pd_fw;
 	struct amdgpu_bo *fw_buf_bo = NULL;
 	uint64_t fw_pri_mc_addr;
@@ -3730,8 +3719,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	if (!drm_dev_enter(ddev, &idx))
 		return -ENODEV;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
-	ret = request_firmware(&usbc_pd_fw, fw_name, adev->dev);
+	ret = amdgpu_ucode_request(adev, &usbc_pd_fw, "amdgpu/%s", buf);
 	if (ret)
 		goto fail;
 
@@ -3753,7 +3741,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	amdgpu_bo_free_kernel(&fw_buf_bo, &fw_pri_mc_addr, &fw_pri_cpu_addr);
 
 rel_buf:
-	release_firmware(usbc_pd_fw);
+	amdgpu_ucode_release(&usbc_pd_fw);
 fail:
 	if (ret) {
 		dev_err(adev->dev, "Failed to load USBC PD FW, err = %d", ret);
-- 
2.34.1

