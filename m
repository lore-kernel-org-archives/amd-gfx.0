Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7A4CDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E32F10E57D;
	Mon, 22 Jun 2026 08:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dm9zqr8W";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8361610E57D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qy/wReXuSMfYXDd5LX3Ojqe0Ykjo6ASv7DzWS5DOkuy5n62b67wIGeXkHB+lqgfbsXu4ER+/nLbKCX8BGjFAfIdSdgaNObcLDvJNnI215VmFUlo9X+JCBb+FiOpu/9wwRHMlq9ZnWGwiAMc6OVze1pDTKhyCa6DuoZp2ZqF3N3/EGtA5gDBQ/mrwtwPKeoRht2edHLVnQ+yZWNLgj0g6/2nGDOgFPDMFFBahK0n8tHZSNek6T/qUEdtoHjdB49KfdmpEXobnfmVjociO6Yg7ZjNfeuZNU/MIr3zsDdquytahgWQJ116uD67uxwTmAADhjlnIFiWJUl8V83yv+qBRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjfvD9OeVpbEF0cJjzg7aiftdiw7Kgp4Raw6i7mc0b4=;
 b=FMICmvcpVTIuNKQlJCtWkbWe+TSWqFHiMfK7xEoVcncTCSHLjvthkHOfaDy6e8s1kgnVcXAtT4DEOUCI8fMg5cFiWOfc3YEJvAlpM6EureaOqGA7Y3FwGnWrPnYZVTcC4N49lILVp8lSnP24n+wThv9chn/W5uRFxKdwkiHD0iUaQU6xO0OBfKiDacSp6+yoZDbs1joQ9x+2qTA0VaFzL7pHrUxZpa9pZe01/+VDz4biC/FpwzDit0BH+5Mgo7yASuUW7ElRSdhYp8MRF6mtHaVLBjGBIm4c9x8GFo0FG5UOYzphxSDJ3hgLJtcBvCgtErtMjWzqV0eQl/QRlCcGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjfvD9OeVpbEF0cJjzg7aiftdiw7Kgp4Raw6i7mc0b4=;
 b=Dm9zqr8Wd8qxEYjJRfyIOusnP5R/uTK8XcSVrZsITWguhKJizmZMEDy6RU5IZTRfDqTVbIMCaL4oqAhaMna1QTL2VX0VVnyOMNFbzgKgh0l7RMggUJg3gKFYsnInzGeCnOZlY/KsWEF2gnuxwVNXQHZOkh4RmW0TEAv+NJ7dFbw=
Received: from DS7PR06CA0027.namprd06.prod.outlook.com (2603:10b6:8:54::6) by
 DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Mon, 22 Jun 2026 08:46:29 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::41) by DS7PR06CA0027.outlook.office365.com
 (2603:10b6:8:54::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:28 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:26 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 40/48] drm/amdgpu: retire legacy pmfw eeprom support check
Date: Mon, 22 Jun 2026 16:44:42 +0800
Message-ID: <de1ed344c72fe43b878595b2e72c2fcb626ac4d3.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 2975fc1d-31e9-422a-89e4-08ded03ac02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TACaU+RZ2PGGNrJ4ksFANZjZ7XaSj4dkkbTJV4WP/1Jax87GQ0rslqZmFffGWQsT3GK42raF0Yn1Dd2VmjeSLtSmlRYVDvvjr1eyu2RDCOCJ/aELkctVBpfIbmfLLn2NV4xs0PjZwleX8GTbfA9N2hI4nw+5aFfwDOfyYWEmI/44202TYpexdybkV2Uo5o8lroSv0p5KvKgyxQjXhir46QH8Ibn4jp5CjK6cmKNT8Ji4rTQVgt0ycrWIABqJxgyZUjJz9/pojNRcR+qC/orMK93xOGbc2lVmgzUcaP4QaYNKrlvDbGzmpnWRggl0kET+nmASrjMNtEet7iY7+JTVdFRK3YP8curcJQMEkJ5bTvjbWZIt3jb/KGamZ7csUDlAeMRWVSGAWCQg5Pa6pztb0YoCAhMChHMezmlPWRmp1341G98CHVf0jN/e9qyqxS4cUtrbFkoSlM5kn0RNHoLLJQrCWONmwT1+ZkLB5QtjTSzNEcKNPtCcrMeBcd6uiw//WG7rRjj6BytAnh9hNO0XnT1rsw/5QrTkNCRbXYux9IilB9BpjJIRTpbDCHf6b3h39COiTdVF5RieqznRBcQ3dfCF0GgiPEt3fROh+/XdNwfWVY+SVMA5xOos/4H9ZZdYB5aExKkMl0zuIoZ0OX760b6FSqUP3KS9uBGvXjklehwZokL+2DtdKXUy+BXAusER76q5cu2roQRwSHEeghXzuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dVN7Rz4Kl/9o+CXFOpBIMDu+G+XxBb6ldQgt7Zb19OowvUoQGP3/y7I46FoYdSFjfgLO3JsaOe6HPRXnx2F4tKuIe4hVWjNAgv8B4fB48XyCslSeMHV0btynzt8nMvRjkK8k04ps3Lvagu8Fu8SDlEKbRQkzi/3K399Bfjp4dig7vpOLCAIoLOAmhzIVQOb6Sop+tUiCPIkbYNwUriPpFxrobLcdG2r3y7ZH/K+qg945ThcCccVeBEA0NNtoMQVR0AMVUBptT202LNqw0L/DVx5jApcigbH6WEFmTHA/nT+aqjPg1EEWSgzjeHAcHwn++JIt1IAyt8AWMC/7iF3UDhw6ZeO0ZEBksAM/WsMSo0bwJfJT8GiQTNNo3AxRqkNfW7/kkgQVDlnHfNRQvDk/TRHQ7AugHWSYpCicaflHfsTxojyxdXbxISfhSlVaDarO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:28.3080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2975fc1d-31e9-422a-89e4-08ded03ac02b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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

Remove the legacy function to check pmfw eeprom support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 48 +------------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  2 +-
 4 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 996152dadd86..e9583e8f0863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3198,7 +3198,6 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 		return 0;
 
 	control = &con->eeprom_control;
-	con->ras_smu_drv = amdgpu_dpm_get_ras_smu_driver(adev);
 
 	ret = amdgpu_ras_eeprom_init(control);
 	control->is_eeprom_valid = !ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8c398c2e6709..95468b9463fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1156,10 +1156,6 @@ static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
 	int res = -EFAULT;
 	size_t data_len;
 
-	/* pmfw manages eeprom data by itself */
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return 0;
-
 	mutex_lock(&control->ras_tbl_mutex);
 
 	/* We want *pos - data_len > 0, which means there's
@@ -1676,8 +1672,7 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
 	struct amdgpu_ras_eeprom_control *control;
 	int res;
 
-	if (!__is_ras_eeprom_supported(adev) || !ras ||
-	    amdgpu_ras_smu_eeprom_supported(adev))
+	if (!__is_ras_eeprom_supported(adev) || !ras)
 		return;
 	control = &ras->eeprom_control;
 	if (!control->is_eeprom_valid)
@@ -1699,47 +1694,6 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
 	return;
 }
 
-static const struct ras_smu_drv *amdgpu_ras_get_smu_ras_drv(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (!ras)
-		return NULL;
-
-	return ras->ras_smu_drv;
-}
-
-static uint64_t amdgpu_ras_smu_get_feature_flags(struct amdgpu_device *adev)
-{
-	const struct ras_smu_drv *ras_smu_drv = amdgpu_ras_get_smu_ras_drv(adev);
-	uint64_t flags = 0ULL;
-
-	if (!ras_smu_drv)
-		goto out;
-
-	if (ras_smu_drv->ras_smu_feature_flags)
-		ras_smu_drv->ras_smu_feature_flags(adev, &flags);
-
-out:
-	return flags;
-}
-
-bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
-{
-	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
-	uint64_t flags = 0ULL;
-
-	if (!__is_ras_eeprom_supported(adev) || !smu_ras_drv)
-		return false;
-
-	if (!smu_ras_drv->smu_eeprom_funcs)
-		return false;
-
-	flags = amdgpu_ras_smu_get_feature_flags(adev);
-
-	return !!(flags & RAS_SMU_FEATURE_BIT__RAS_EEPROM);
-}
-
 void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 5e5275ae7aab..6e50b9f0569d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -163,8 +163,6 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
 
 void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
 
-bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev);
-
 int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 			struct eeprom_table_record *record, u32 rec_idx,
 			const u32 num);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index eb8aff637eb1..537813482781 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -186,7 +186,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 		if ((amdgpu_bad_page_threshold != 0) &&
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
-				err_data->err_addr_cnt, amdgpu_ras_smu_eeprom_supported(adev));
+				err_data->err_addr_cnt, false);
 			amdgpu_ras_save_bad_pages(adev, &err_count);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev,
-- 
2.34.1

