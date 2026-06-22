Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D5DCDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9939210E580;
	Mon, 22 Jun 2026 08:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ig0VCN8j";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0072510E57A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCXg/KwDBOqjVCO/DlVcMlcQrx3xVRKH8t2f6UjVs4gjEfg7meFLT6LTX80Erv9Ct2Uys0ahT7UtD8GGzhPKFVK0Mr9YjDDEo2Zcve1cPy7kmfcBHQYtMvAsejeppRDBxRWUxxU+kGgc2+Q1Ljp2O3sHM8ZGl/z6//7tNlMcjgf50iBpCj3kA9K86TtJKypmkH0oE1uSvrgJbqX9+Mj2jiBC9sffvXtbcGONyu3OF88EylmxCpDDkHxTJr0j4NsoYQQkW+IHIAugmJcR7hs1FkcbbaldmZ3oEK5+dUqYniFHcvnmxsKibP3DjIY4Jih5FMci5JHn5nXroRZkoquNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1BQb31B8d7mblTkiCUIqY8FOwlUHGARDQPVhlJAoAw=;
 b=MbgHStStM9bYVUT2GzOFEr18zW+qRHkMN2WSOR13nt/IVK7OwSEi4iue4raUopXDVyt+z9B5UUOh4psgahUA6kWplzy/e0bbOYXDvMIhc39p47sn5I3mb5ahNnpZsvDwo3vm6xwIFF7nD2LVvcsugMA85WOfM4iA2NvI9ICv/MzLBl1ZWK1dJTpxlRxPCrmAdcaTPDT34VnzCIWtMuqLEPg9yiHf0MznRnMUJg5qPcGGaQhGi9H4bmL0ygqwIqPlthGjN7RJvarQRFY1yNumVt+R0g31ti58BnesAjus6M07Cq7XZN+Bz+Do6tpbnfyVeo+gErP2EkvHGVv22uiXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1BQb31B8d7mblTkiCUIqY8FOwlUHGARDQPVhlJAoAw=;
 b=ig0VCN8jS6hx1X0VbSpHBEywE3nW/wz1+elKCIRlnEMSmaO58+S8QznthZ84/yy2Vyr32/D6unYGIOsKileYj/fxEunvO00n84xbH5o39DksHZR2hAIhWcmSBVQPKAOd8qTGWNrrjSKqnnhgjBjOgAGJh8zqJ5J2vpnoSS+eOxo=
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Mon, 22 Jun 2026 08:46:32 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::13) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:32 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:30 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 42/48] drm/amd/pm: retire legacy ras_smu_drv interface for
 smu v13.0.12
Date: Mon, 22 Jun 2026 16:44:44 +0800
Message-ID: <d06451f57ff20b081b46a5b242c9c701b3c37fe4.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8f95d3-af86-40a4-2b23-08ded03ac267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SsynRJpxV6nVG3/tJfxWSgV74lAjVFtf1PIMuPnz0jXR+LuHvcZhJePjOPkv0BeTe8wzSdzvCu4qj9/zZM12wAA2bHei4ofYPpDkwMdCQdtt8PtZ9Y8pt+rmgvmw3nW53a7v8cDkAWSo8+xl2hWNF5JrmRLQoC4/+9D8Qlb91b+NIpL9t4NR1WHSwdAh76+jWP+KN040GnL194DXQ0Pfq7WlXYZahDRfCTrBmZfZu4imtsKM4C2xL8Uvh/1RQdY+lvgpq6frvEJNNC0Q45NN3e/7+e/W/3HdhgjS7Plq5xgqvH0dYjrq713t9+Ve8ZsIOKPUTspk2F3xUi5Vxb4z3Vlw9JKIq25QD6zc2b04TDBni+VIlkUiAiUNx/wAQC9Vxz5j9UK47ds5h7dqcrI7mHPVI378vaMJCvGdArcpJqBBHoafU7b/wRw2p5XZU7s/u0F05Z6xwfYvsrLp71Z4tfjeeANPZ+ThE1Dst8mQmapbXfY7WSGTwDZeMP44EFFB8hmFJoE+li3XdDPOIjbiQ/1fqw13c2q9lLTkEvpENfmh8l9TT1PbyMMYGw/yqp0pfuXJ1D+ej5xDZtXPHaOe4M3laGxAhqizpkbV/XB4vwmrCPpgW02aVkPlySLUfiSSX5yNmldpkwmwVPJrG9Bb85orLTuvuxKAsep4K1M7CaevOFxkzJXqDItJ8bwtGo/q92cXnNcIIfIxGWJcx8777A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pc3KZiM7HDYINvH0T31psl7ZQwhzoKUVSWRKrWkGZ/InmoQxiwb/R9RscvEa9pFCyNuzqsh/AesTUAyF5lj85SO2+4iGO26pTVcBW3ZDSEZ1IyVnRSgGZJEBjwHBMQ9EawGZkGqez4pLBAlikQLeNtsFReqguoYK+oCAjfakfNL4s4HUHo4p4cMxNztdRIrinil75mq2Lb5Kj75mx4q2XLSW/jztf+awJ5brOMv7gYUUukoUhlf9uxzzdMyGje8imWHkxZ6/n2fBQPAFo1aU6lgZg2McL+iTVloOdp6acpNSDGrrE6i5AlRyeaJJKpdqt8QREAWfiGQvbfgguEji43aM40u8p1G6Wj61HthF8L3HUaIcvBHKjcjBAV0C8T0o2s9+goBTEYOMwtY7t5tcP+7Ftmy6OqTJ0zLVe7sMljbcxIcf6tm436LjZHP+qgGS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:32.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8f95d3-af86-40a4-2b23-08ded03ac267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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

Remove the legacy ras_smu_drv interface implementation for SMU v13.0.12

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  26 ----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 130 ------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   1 -
 3 files changed, 157 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index dfbed18268af..5cd26535dae1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,32 +492,6 @@ struct ras_critical_region {
 	uint64_t size;
 };
 
-struct ras_eeprom_table_version {
-	uint32_t minor    : 16;
-	uint32_t major    : 16;
-};
-
-struct ras_eeprom_smu_funcs {
-	int (*get_ras_table_version)(struct amdgpu_device *adev,
-							uint32_t *table_version);
-	int (*get_badpage_count)(struct amdgpu_device *adev, uint32_t *count, uint32_t timeout);
-	int (*get_badpage_mca_addr)(struct amdgpu_device *adev, uint16_t index, uint64_t *mca_addr);
-	int (*set_timestamp)(struct amdgpu_device *adev, uint64_t timestamp);
-	int (*get_timestamp)(struct amdgpu_device *adev,
-							uint16_t index, uint64_t *timestamp);
-	int (*get_badpage_ipid)(struct amdgpu_device *adev, uint16_t index, uint64_t *ipid);
-	int (*erase_ras_table)(struct amdgpu_device *adev, uint32_t *result);
-};
-
-enum ras_smu_feature_flags {
-	RAS_SMU_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
-};
-
-struct ras_smu_drv {
-	const struct ras_eeprom_smu_funcs *smu_eeprom_funcs;
-	void (*ras_smu_feature_flags)(struct amdgpu_device *adev, uint64_t *flags);
-};
-
 struct amdgpu_ras {
 	void *ras_mgr;
 	/* ras infrastructure */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0098e9414c55..71218909f04d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -1017,133 +1017,3 @@ const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
 	.temp_metrics_is_supported = smu_v13_0_12_is_temp_metrics_supported,
 	.get_temp_metrics = smu_v13_0_12_get_temp_metrics,
 };
-
-static int smu_v13_0_12_get_ras_table_version(struct amdgpu_device *adev,
-					      uint32_t *table_version)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-
-	return smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetRASTableVersion, 0, table_version);
-}
-
-static int smu_v13_0_12_get_badpage_count(struct amdgpu_device *adev, uint32_t *count,
-					  uint32_t timeout)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	uint64_t end, now;
-	int ret = 0;
-
-	now = (uint64_t)ktime_to_ms(ktime_get());
-	end = now + timeout;
-	do {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetBadPageCount, 0, count);
-		/* eeprom is not ready */
-		if (ret != -EBUSY)
-			return ret;
-		usleep_range(10000, 15000);
-		now = (uint64_t)ktime_to_ms(ktime_get());
-	} while (now < end);
-
-	dev_err(adev->dev,
-			 "smu get bad page count timeout!\n");
-	return ret;
-}
-
-static int smu_v13_0_12_set_timestamp(struct amdgpu_device *adev, uint64_t timestamp)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-
-	return smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_SetTimestamp, (uint32_t)timestamp, 0);
-}
-
-static int smu_v13_0_12_get_timestamp(struct amdgpu_device *adev,
-				      uint16_t index, uint64_t *timestamp)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	uint32_t temp;
-	int ret;
-
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetTimestamp, index, &temp);
-	if (!ret)
-		*timestamp = temp;
-
-	return ret;
-}
-
-static int smu_v13_0_12_get_badpage_ipid(struct amdgpu_device *adev,
-					 uint16_t index, uint64_t *ipid)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
-	int ret;
-
-	temp_arg = index | (1 << 16);
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_lo);
-	if (ret)
-		return ret;
-
-	temp_arg = index | (2 << 16);
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_high);
-	if (!ret)
-		*ipid = (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
-	return ret;
-}
-
-static int smu_v13_0_12_erase_ras_table(struct amdgpu_device *adev,
-					uint32_t *result)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-
-	return smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_EraseRasTable, 0, result);
-}
-
-static int smu_v13_0_12_get_badpage_mca_addr(struct amdgpu_device *adev,
-					     uint16_t index, uint64_t *mca_addr)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	uint32_t temp_arg, temp_addr_lo, temp_addr_high;
-	int ret;
-
-	temp_arg = index | (1 << 16);
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
-	if (ret)
-		return ret;
-
-	temp_arg = index | (2 << 16);
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
-	if (!ret)
-		*mca_addr = (uint64_t)temp_addr_high << 32 | temp_addr_lo;
-	return ret;
-}
-
-static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs = {
-	.get_ras_table_version = smu_v13_0_12_get_ras_table_version,
-	.get_badpage_count = smu_v13_0_12_get_badpage_count,
-	.get_badpage_mca_addr = smu_v13_0_12_get_badpage_mca_addr,
-	.set_timestamp = smu_v13_0_12_set_timestamp,
-	.get_timestamp = smu_v13_0_12_get_timestamp,
-	.get_badpage_ipid = smu_v13_0_12_get_badpage_ipid,
-	.erase_ras_table = smu_v13_0_12_erase_ras_table,
-};
-
-static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev, uint64_t *flags)
-{
-	if (!flags)
-		return;
-
-	*flags = 0ULL;
-}
-
-const struct ras_smu_drv smu_v13_0_12_ras_smu_drv = {
-	.smu_eeprom_funcs = &smu_v13_0_12_eeprom_smu_funcs,
-	.ras_smu_feature_flags = smu_v13_0_12_ras_smu_feature_flags,
-};
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index a150fc88902c..a66bf33dbb58 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -117,7 +117,6 @@ int smu_v13_0_12_get_system_power(struct smu_context *smu,
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
-extern const struct ras_smu_drv smu_v13_0_12_ras_smu_drv;
 
 #if defined(SWSMU_CODE_LAYER_L2)
 #include "smu_cmn.h"
-- 
2.34.1

