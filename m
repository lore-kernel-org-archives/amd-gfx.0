Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27A1CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5602010F1A1;
	Thu, 25 Jun 2026 08:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JwWfG9cd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156B910F1A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWgT67A+5f1syMyDvRBlJ4wHeKtz4jzC2P4Ns2LnqsMlPhsKeGeCaBJsEfpvrtVlYzyKSs/lJqXliuH9PS4jn9Ac2o15Mlwqfal2ZvwLhjxekQcYiE7Bcll8/JBNm6K1+22WEDEM02AOfpQEGaLpfQSasbTCB6WRiLUSW8/brPi8ccvvjLaV6LX+NcwnkjDQZHnhrvXkg+XrwdxBhElOfTJ83pWliujnTu652JBaflKDOhJTuidnwLXhYo7KU0tkV+Bk0jm2JVwuG2/GPmk/Su7fJTWwHx4Hv2oEDlWOY2n7Ab59+xFGyA+TDMSdmCMlZTJgJuOlKns4z60N6zT2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1BQb31B8d7mblTkiCUIqY8FOwlUHGARDQPVhlJAoAw=;
 b=Grzuy1yef90ACLJYS2eWLRYrfvfcBIP3eLcAimmZyKCbIpBKQChSjxxZh4/ec35ir1BdS4ZNFD9mCVsHC0KL7M1yk8ESL20sd3P15s1f6H3kj6/g0edlXXGLxj83rTjhUssT39i9cXMZg+ua2LPLQ9dTLifNsX+lRBHTMYPBV8FdI+ayQNuTgAkoEPOz7GEfalsW4evP3TdnbZRQZ+fzlMDdVr2ZEJD+vxqYAOyLKg1d+QSMKPiqOqXT/mC5Afu5L02ZuHDtwzBvn5T1wpJ64ofdXrujH/R3958FzyTtGh9WNzXpUxuIE0dZa7JBgZazBkB5EHsTbFkdCdl1wQoiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1BQb31B8d7mblTkiCUIqY8FOwlUHGARDQPVhlJAoAw=;
 b=JwWfG9cdcuzwwjVu5NqTuUgK9XlXEjLGpAHUZD6uu3yrsRGTiGZqYHnHM463TcUr5BVJ/uAj/NbjaV0azkkQnYKZLdkigkq8vpV4H/apIdye7g6iwU0n+LybpO7dgF0tObEKD05LOeUrFW4D5UR3k+olZNajrWVfESc4sY+J/hM=
Received: from CYXPR03CA0058.namprd03.prod.outlook.com (2603:10b6:930:d1::16)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Thu, 25 Jun
 2026 08:21:33 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::74) by CYXPR03CA0058.outlook.office365.com
 (2603:10b6:930:d1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:33 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:29 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 40/44] drm/amd/pm: retire legacy ras_smu_drv interface for
 smu v13.0.12
Date: Thu, 25 Jun 2026 16:19:33 +0800
Message-ID: <f6ef1a2a3c7d4d70cfe38aef7f6f5c9a63c519a1.1782373702.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 60aff9d8-0309-4d30-8807-08ded292c455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: OahCf3sFjNhX3yMvD8vtq1bHHTqa/tCsjGSDritkyShEzvNaOTePn/Dz1oaCB47tQ0zgnYan7LFjnKwAKEMqrkg39TYoa1pzQLCGV8LXKSPgsPGrGjGePR8vSIHFA1wwSsYARgyQXn281i2qmqegXX7bRpW8o+vyga/UOv12eloYYfQVwXyUKvYsL3UXfeTYYwH7AKp+af8nTCtRdZtryYkGVIjzeplzRemOK0daKsjidEVv7rnmfIzJziOPC79dUeVd7jc/BS8CY8ZbTqQdu/x/uaBU7DAhmLdKYRrluPsgGoRP9yaJZbUYWs68beD7zKlfPtmjHzxSpkG/GtFLmSaI/1P1PONyBivCDtcVYLxjKV1eUwIXkqTU7mT1E8HHN/93tPT+y9/Z5ZpCggs/a2/1wdx0/6wlu2jddl2dpDKkGFYC4mBVc00PN4Wse0OPiRM/0RQiIQIvpTZq7q4issrEUXIVPhalPHJGAGHJ0nxSeDhFNGH7lQYPce0m2u+rHqiGdIEl/TpkaIj7l6xMV8XiVZ6JPvVzviESyE+hFlrWz27gyi9bPi5h2FHMWZw3ZwJccgYaS97z3+Qv78Y59Hz7VQfsjO7UBvVFQ3Vqa7CfFYmmEIeo62odH1bG/6URAZSh49bEr2FcSaTjKm3nf0GBpHHjzzSEftETB17wm5e9OcaqhoWhohFDh1HxxSW2dgtVZAqnHmlP0aIcWRfrWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vlM7Gxju81TVXy90QUPPdWk6H/aRMnWkF83hueFxKyMMpU70xRFnnZhDKqevLFVxdR5Z67ncVAhiaROs/ZeH5LCyE6EWXTgRQeAXwzRRjyHqd4jfg5C1Qz2XprGvdh2uGXzSTwKFZGcWR95VSH7we4sQo2N0dika8EyECkiPjhLdJt0uF5nso687I+k5z0MHAIvntGVPf/eU5V4r3YkY7NWCoMThTTmx5SrcfauCo2GlJteKXlb2nyLaRIgIyeDqpbFMWxTftutFvabVrR57JL2ry7vjASldRQfh8rIFBA5Fuz3q/i/ouUzu1o/C3HaGZOd5GHTZQZgOnV9+gDfM5ajn7rRh/DLRbXz2Sh/HLnp5L5jZsbpADKS+sGTQsNhzNHZsH87Hx+sb2pM2JRsBsj1xD18FeC31t7IY5MNHB8mv03ujyGE15b6l359hqDpy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:33.3307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aff9d8-0309-4d30-8807-08ded292c455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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

