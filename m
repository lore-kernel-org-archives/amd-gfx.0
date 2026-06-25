Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCBBCDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1237F10F199;
	Thu, 25 Jun 2026 08:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1SQkV9lY";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E766A10F19D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGcrzXGQYKOA9KDvV3S5G1HzAxZBIj/bqhkmq+LZxzLJ2wfOVj4lWVKssMcYf49kz8oIhqbgf26dJZUYPa4rSvOpceBhZZsv0dqLzxj22Zsmb5sYkPTh7Z4iHA0yy2vZikwP2eVujZwlkT9uyG7xd5F4uRC5tf8gd+PSQ6i2ZwDpE4dcVxclAoR8P0/EXhZ0iaHOjzsgJEAxXv3U3dF2XIHW/RGD6Uw++/CSw8oP8yypfrIev2K4HPEa84zZbvFrO5IVu1lssNeuDQ6cXoK++6ULesEz+7q0YOpCavFtk61gDYuR5pbLsAV8ROIDb7m9QMh3Gf4cABxAhy8EwIdnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mEYjz52CVMzU01Aj4OeLuL1A/DtdpOr4bLc2tyTkXA=;
 b=OI2N6FXUTTJ8LVO6Dg4ueFFfiu2vSH/Bq8rpOTdPOJL3M7i8x4IMbvG7jlzYuDSZU29bsEVTTR4z1qQCe6RNZrw9in5nobO0vlldlqCSVLzlm+UN5WikSXyo3GO5s6ukZjWQf2J7i9cojl9pqTUMAmjrNquLPKkM+GQC7fPpU9sJWfLs3DoabFVparULtGLsR5o9S1rATmooybimDSZHF+UpOgcSk24CZgejGhWwD9uRof1snDFgAz1pPi3nyCzgBVkUcPIEYqta0rButDsMe/oULOhuWd2YIRzZrEgbNmSakXcuxcJYpCjbLJpPtAJWd2jlx4vPntJYUDyZSzm/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mEYjz52CVMzU01Aj4OeLuL1A/DtdpOr4bLc2tyTkXA=;
 b=1SQkV9lY+be+m2mtQIuJ7VzUn7Mj+EKX1lBtl1flS3q8eM/3TDBPfQ3BZsojwHMAv/rATx4OAH9vgt1/WkMNPndYxk+Bv4m4qEzG7g2Lk/swMZSRwkJ3G/uUd9Z2wIZHMp+spMQOPoGwewfVxhzB/FFbdcRrsrIaq5Qvo/UiCRc=
Received: from CYXPR03CA0062.namprd03.prod.outlook.com (2603:10b6:930:d1::14)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 08:21:28 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::18) by CYXPR03CA0062.outlook.office365.com
 (2603:10b6:930:d1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:27 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:24 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 38/44] drm/amdgpu: retire legacy pmfw eeprom support check
Date: Thu, 25 Jun 2026 16:19:31 +0800
Message-ID: <5cc6efdcfb662a877640baf7a431e03570e8e840.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a74a20-8c6c-4378-4b19-08ded292c11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: LLZxtmxVbUFTmSp7NXT1NYS+IeQRJRxBgqh0tdmymBJRx3ru7UZD7QSADXKzze1hyYuimVX4xfI9+Zy+SwhK+YFtvV/8gabQPaj/BMiDtuOPuZU4KyZuuTTn2vl0evGQPH6lx9gRHuFAJvfdn0A+Oiqwk2Z3XEnT12OPWZwRKhqaipy+OEwmIdXK8UAgCabkEUOH5L1ITLJ4afHDdFMRoV70/nf1tNf1Y2hN4XxsbLDw/7I1H75Ss+U5xVNqghRcHHqFEWhwwfFEoM0GTZIWbTxfaBFlljD2tvORXNYr/MQSsI4QZjTHiM5IVaZXpbBdFHsyJTRgxQzcmxR8NOqhVisQoU3NQxIpxz+IRZwP4HGd9LJ8lnn/arZhzpu0tNkeSslP3iaN7SRhT0ztv12wWtMEd4ZYDmt1z8IwjuMfK+0/1o/I0V1jAHgsOTIriA/rjqdY9D+XKGd0PoZgAt7p8ibdnIIjTIqXPszyBZl18BWNG2XXNA3woHJ0pup8SOHTlPtgZ4zoEBYyBDYMY/iIaoXoPkJjEgyR96i6u28FWmxv7tj0yHBx+6LjK5584SkFGWayMXQMispG/fJBBj6hkRxo2FWAOrz9rwopzZV2Yn+kdlWxVDskcZesG+/lAnJDi9firCSGjDGx5FER6eZnD22qIhHjRhZ18WFyga4uoD+j1WTqP09X+rYuAO8Alw1IN7rELUvn2qo1mPw2G1/cYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: akjBJFOWeG3WhlnbEhEbBI49k/pC3kGsR++X4YV0iSbhcSnP3iu04f+m4oYoaS8GCg9unB4IR8Yvmibhb/aYCG7PyELi198dGtW++RpQLPr16MhzdqgVtyrVOTB9TwtEb79vfPAwop0enykfhzja9L0LndYypnt8na2Ch4ktJzp///GFjJE3XNHVchP6mCGgYtXk1x2tj4w/9m0ysSIIFclthT7HakbtFUNSndizrPjknAQwvToFmaDKOAycsyiQK6Q4waowha+aBn5oH+REf4UbZ7W1L23RVFHoPSZnrXlWNj+NFji01I9d4OpCscnLErLFnFpPbgf2+eSF1VeZ6syDnfT6QqkbiQbcpTr/5NgzKAc2mWHwr5Mcl2OfHP64xLGKdchhnD3/AC217xJSKQWwxGe3TyyEfeTSHH8zH0GZzgtVSFTVD/+WC+5JOxtz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:27.9165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a74a20-8c6c-4378-4b19-08ded292c11b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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
index 7f893dd803b0..2fdfc1695a8c 100644
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

