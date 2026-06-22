Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BE0CDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741C010E48A;
	Mon, 22 Jun 2026 04:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sCc4PYtB";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549BA10E489
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrmPwMedi2Y7EDaYMGLCJxfc79qGS9+wS67OR7RQCLJGmOLQzMA3ZnzT1kFQrIq1n53UJThbrqjaR5kh+Ws5DKVCHZTxUrHoGdVKfJJelziZnHw8KyUv1DGUGobcEk1mgcXLr+LG7L1krciPFwv3N9LEqloEnT4wjWYhNINel60s5+Y+b65s8JfiLLX7a/EURjRf83KZaxBngPfCMsumoOJxhbPZcwW3QNcbZTDxFpOmbcW/PGY6TRVH3LcBNB3B6jLjzO1QvJ4MPWjttT6rLiNETFBjxeJ6DsyOBzYL3PK8TY0ZuFhclzi/AZzjAsdKLybu1UxTjaqGM2JJNc6aAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1BQb31B8d7mblTkiCUIqY8FOwlUHGARDQPVhlJAoAw=;
 b=TucCeBYgxqRvnN4u2Nk+sHavdSKxUCc4xhW/ZjoRiqEZtpbL8qWy8rxdTofuqx2tKybdMf/+qpVEuZadsfUo6fN4cn60uVDhiccgh5de1FXDEubKw80J7cse+uFZ8OXB0vPCTrLlIKfxpJgdoQOUvpOWiaNDSY41CVtynbiM4GqSptCXTn5wE4a/jLhFil5bC2sRctyLnrsccBr7zCdKcvGdsGV+Z38X0KVCvHagJ+qaNawXXC7CSdLgxwOVL2W6MCnOOl4juTijNKm8sh1nmwjmARCPGwSwKSoQ5jFbvIhBIyLLuc6x5bPEe6IOgW8YQKIgf2mGKLUGArVJBfr6Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1BQb31B8d7mblTkiCUIqY8FOwlUHGARDQPVhlJAoAw=;
 b=sCc4PYtBTuXWc7CrUSjoF3z+Fr3UG0L0TJy9uPQNrdegBpx2kXQ/ftlq+r+xw4d9UrZwU0ZN2GOmA6IfzGswUCP6TE3FsAbgeP601TTZGE02dPAZkNJwP/1Szev+DqBNiJ0Vi4BM2EQlK8xpdcCykYan8ojb0PkT6OG2304pAMo=
Received: from IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::11)
 by DS4PR12MB9588.namprd12.prod.outlook.com (2603:10b6:8:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 04:43:19 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::4) by IA4P220CA0011.outlook.office365.com
 (2603:10b6:208:558::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 04:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:19 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:17 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 42/48] drm/amd/pm: retire legacy ras_smu_drv interface for
 smu v13.0.12
Date: Mon, 22 Jun 2026 12:40:31 +0800
Message-ID: <7db78aeeb41db1d14c16a418151d1862e334ed90.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS4PR12MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4703e5-ca97-45fc-6038-08ded018c87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: v59yKOTG2L1+aiJxV1L/jh0sq42QXX0awxcoOG8rUZiWTGkaJ1v43NZJyxMM2YPfX1UV57JHt+IbdXeD/0qW2MzWrlLPf/ZZQJW5WqpZYUOjEvKSlmcl1DSx6Kug3cwG1doUwijsBVTxxpwUhab8ldA1VbpT3epw2ZYifX33T1drH6gS8YdjQWCa6u/oHOBZa6KOWCQpp65xfymQwt5C83fHw/o8vlFI7AGAJFvPVHgBQoij/Evsa3zSEiNXhECXR22ll1Jan+kqwQ4oZpuy5Nqh7kVsSXarhV7NuBxAxX5Akp6etYluRvyjyCxl2EvYeDaA8ECTvAcP7OqlmiI049HBD7QnXUo0uB/n8QCGaWqYFl6YagoHPxhr5N6+BD5IlVieUtWMY4CmD47mt0xOyeERV3cprUKR6WHvQMriQCbIJsmh8x+i/3xsDiw0Al/FUwxy17dybKy6JhDndhvhRR+W+fN2vTIeLGjWXA1OAw6R+037hJAiHiQOEXaDXriE9ADKjouXHDreSWbAW4XFIq8k6BFb0HTqV/2HptmTnppq0N16yQmzgrnwJ8UcF5qr25Mz5F2Y6sLudlIoQeqnr1kdBJfezbK3h9K1XY5Rz9dNntDbz0BFWr8Y9CegrGNUGtII1wUHeiZIOaSxx7XV6c6XU2HVVG6OUSomu1DvdtxUzGJgG7M8kDgnzl+/1v0Z7emsqJsAY8At1tGdk+tveg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lwi5juIXWhgidQSRUQrlSd2R7wF3j8I6cPVZXaZTNgEXGsVr81i2WKNq6HHYvGLG6PP43keqonxbEOqPgTyFsEmXRv36EOP0E+VHxHDvFsxJckJFQliQwfD6rlvEGygky3aC4nxsUZS24FNMRAG7fVMXOusvIpMJOWkyLsopXoI7fNK1AghvjTeFIZn1Hf750rErKbFCpqxjWpWa3k0249NjRzaKC6+oucZykG69936NLvFfsMc5QcDaB77WINbNlVyvOgz7zHYXGixKf9ruiiU1Sq2FT5a18x15FYPSegxj/qw+IoesB8c95jzc05GSuMaGLAgRbqo6zlO0tDIz3bjuAbq7rBRZOD3+D7QNzOFzy4rZg0scL7loR6uWMWN+4+v+rB6bAVneuWb+cvuh0cH4KJ9y0zPuEmRTINKOKQFuw4CijwVeSygxt3bFz8CW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:19.4020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4703e5-ca97-45fc-6038-08ded018c87a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9588
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

