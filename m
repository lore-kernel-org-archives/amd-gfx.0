Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C4CC27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1129010EC6C;
	Fri, 31 May 2024 06:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rnflqx7p";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E30410EA42
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUGccOqGzO9P+Nm3l5vmPyZZz/qHPMrxx9IANoSOV4b4CB+9y/wUiGxDUiJJ0CoLxXMUVsmQ0s1H23Y+E/ItK1u+MDQXWwNwJTmrpbjjuZ5dBa+/WC6Aq5lHpI/az4KUsnjTTir/kWhlrzzbTDR7eosfZfFMimsx54YNmld12MvDciHCIlX8XawxfSpjtJVL5JoK6JFJwHoRjc15qwqc8LofGUY+NXvtNTBEuiPz0MR7Mo7bBuo4GWUm/qCNqUfQOZJxQouLvyzoLwH3pLz2+F5VMI5Y4xzCWPf9DVc55VUJ2MVyGtcRQZcFALV42D34M44TIjiDB6thQB6ZkmoJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgBr59qYfn1YicyFWuTRR2tnYCLp2sDHeU24ILTR2jY=;
 b=jPeYRMdvNOUtGo6P0+aJ7hl7ZDTkhftWKgascmkID9hEJDRz69mwhq29oRvCyp2tOYLqrmLFkZqyCGRdgPlfNjPevYpjes7oGSCKtecL1pwtbUU/B8ln4koV10GtMt8df3OLjrmXwgZ72MqbzVBV73xamX5Hqz16KEEGNnXHMgm7QW3jvMTMCz6agpFwE/txiEwIF0VCIT8TmTKhY06rm6kqCE1XtJti99zdhbo0m8MIb2rDLiRLgOU8FH6WzNRHAWmuPiXIuGDimzy+8AkbzwjTJdibw7Fz5VEVG47TjILd+CIMnC1imZTqwalEShvcHGAmosoTDqH61Gkr2NGmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgBr59qYfn1YicyFWuTRR2tnYCLp2sDHeU24ILTR2jY=;
 b=rnflqx7psrr+N4qrKi3g6t2LybNOUj8liYHJ9rkdfvM0YyqsUuOmwYLr3DPXS/UzL7FJwtRTl969JwkW8/FX4lLUDskHtsP6R0CMJ7fSIk68GTa1TaRoLkaGtZYDf9nLNtNt5F1kId7JIYneUxYznNoGmWp8KXtU+/PMZ9YCLgc=
Received: from BY5PR17CA0036.namprd17.prod.outlook.com (2603:10b6:a03:1b8::49)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 06:53:08 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a6) by BY5PR17CA0036.outlook.office365.com
 (2603:10b6:a03:1b8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Fri, 31 May 2024 06:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:07 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:05 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 05/18] drm/amdgpu: refine psp firmware loading
Date: Fri, 31 May 2024 14:52:36 +0800
Message-ID: <20240531065249.1746350-5-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 49460a3e-2fe9-4bc6-4b21-08dc813e542d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?32aXsRN4BGKLv8hEdph/JY9WPc7I+rtJWLN61jTRX50XjmRpexgQ0QJ2/STM?=
 =?us-ascii?Q?GGye5HwKQrRO1bL4aA68tTiO4tsPhZJURGkqquXTdjRUZkzQ88hv+MxNdLq/?=
 =?us-ascii?Q?u9OqsbHHTvy8xcKekwNkmLP4OxVt2K0kXc7NfAp4wcQKVOMHNmTqCXaK80rp?=
 =?us-ascii?Q?qALzmnDKpyxHsRIctlGoo2nCBqzVIVS1eYnXLzJIEOvy73I1WdrLNx2OneVK?=
 =?us-ascii?Q?CMaCOxNeQ5sV+2YdLH5nLhJGHam1hjZTaLtZJXfPW6+JGLlX/jYlQw9yFSZB?=
 =?us-ascii?Q?GKMOg6DfNvShi/cQUKHtXuySnrGv+E0XrAmXi1TwGCNBOTsFZKAbdX31bO2m?=
 =?us-ascii?Q?Hoet/+XUeNFrA12EICK9iKZJvLY50K++HEl6kiG0/2bpgmiH3O16639UDi4g?=
 =?us-ascii?Q?xNPKKRRofKo/lNTmPUM67Pj88fds9kjEoOVARCRMAFGhuPgzZ+hqW1fGCSId?=
 =?us-ascii?Q?iJV0tgtbRVZCdHTsq7toG4sW2ANcqPbBCBqf3J9wKyu2qXR5m2ex7xfS2nPi?=
 =?us-ascii?Q?hMshhIFC8k4IOm04DnqIQNYjN783/oi7/rJecj+4WKqMhF1Z7e6KoInOF5MN?=
 =?us-ascii?Q?wdPLuaphpqp3s44E0NP5sWPCiQb4/3f6518OUYqZuNxN3WyeDHVKvZ1nuyAc?=
 =?us-ascii?Q?+DQYHiqDG1NUSborr916diaQHLBY7hH6Luo+XaPekpVH6SnUVB8AGWd1uH9X?=
 =?us-ascii?Q?zwgWEH3mPYIEgz0U9vJyqyOoVkuskuQ//R16mCsghTAY5TxQsbz/ZFtxhk3c?=
 =?us-ascii?Q?bmhPkCaXWe0C5dFeLHpewHnh0zVBGcUD5Ei5IaCj7c+OOhFuvVL7Rrd8dPoI?=
 =?us-ascii?Q?2pSVsJhnVarVhu5iCseo8K2WYqkzTjdrrO6Hly18B8+HgHgeUQvXNrv05V/h?=
 =?us-ascii?Q?713GVpJDpwQPUBydrEAMrkFvjaFU2jDlTx1aJqRQMByHMpFP/hELxQhTZSze?=
 =?us-ascii?Q?oSBrj8/ueeQvEeDSGxlpDoz7+1YKxSeN55NNhTzDt9ZwUedrXy3rwBK9ODS5?=
 =?us-ascii?Q?vK8FjioYcgmYHPDYzO22QN4RKLghU9ZULOq7nVv7r/+GQalFmlxJ43Tz2ice?=
 =?us-ascii?Q?b5jLoV99LG0d3BS5WQ9J4CFlWQM8luQ262fmZ0+vV8cjuI4vA0AqTKV1/U+7?=
 =?us-ascii?Q?0XnmqoFQNIK/TUFYV+fbkf2ruQUCVxNVs7PYesWTpvZnf0EGEKaWUjvK7+mA?=
 =?us-ascii?Q?RbxuX+JsCtMreVwAR1sOYa2i76ZE6Synv3uSl6cEe/bMZtSLQQ6QGi0EAcjG?=
 =?us-ascii?Q?6cdqoTaWKU0ZLJOGRLgGgpmFZiEVIT4VbXMaWq0mgKLu7H8irg8AYnII5d15?=
 =?us-ascii?Q?quuDNdfejpRgnNr/lotTphpaA40qLXiA/N+s0S/Ez6L9xUTVf34EoGzVa0rF?=
 =?us-ascii?Q?vg6PwIY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:07.8727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49460a3e-2fe9-4bc6-4b21-08dc813e542d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
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

