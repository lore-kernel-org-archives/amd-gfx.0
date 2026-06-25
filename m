Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6E1CDE006
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B49510F19F;
	Thu, 25 Jun 2026 08:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IIQrs7gU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1495510F199
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG8TgZWSIB4HQZK1fxny37FIdqJPXr+28nlUxb0nJDT4pHndEBtRbFRBfExTx7y5uDBGZ002S2xVnF91vSySDwoJh65Ggb7EjnJ/rr3+omNG5b/9vvLOMX0OAYdTutlsjaRIUl9kjR3PfKiywGsY1f5ae+DG139S0bXwFAGY9wPgKWpxLb3gqG1WajoOuI3Rx4bfbyqVcUV4Knx5fU2YPW1kgDdHdLt2oH0HWi87xa10T2LYbn61Jbznv4sN0OWjWet15uaeYCud5XVRJAHjM5IS/srgokHYGNMQWdcxEsq5UNArUwyiUjywCh5eLykarKJ1fM75UAyQeaD1c7ZPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU3oKxPmMpjeRYJ8yghRPeG+8cE68SiZxnxkGoCUx2M=;
 b=t1nzAibk7naJ9/ZjAUTzR+Q8CdIvcHXiyEdZY40o2RPs4M6TnXv+iNaagVXvs57lPWWc7UW1G5XjO5z3G3VlRSh5Ykk7TfQDgKbgDPaXGuhQTYiuFPizlO0U/q3uRXUA/NWZV5NQffmEu+F/yZEaa5+SMwiOdUNCM4nS6alLUWjVI4UvHKxM9RF4gZgXo8xyTwC19hhuKOXX7FtBMQjwo2QUBAt6UxL6XLgFtLu0P2R8e3Va85//UCWM42binEiaPtzvYnAIyJtwASJjRmVEV+Qw3bvMYrugcw+CIZl2Sa3yy28FExxsAvQ/o22YZsMOoFT8bmG2qDpWrxYKXdFdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU3oKxPmMpjeRYJ8yghRPeG+8cE68SiZxnxkGoCUx2M=;
 b=IIQrs7gUFJcWqBlFKWfHfMB5tC391+oSznJhmLBHPmrhajN8RfyQURl5Tyl8dybihMgX6WMflOIpWDhiMx6vga9e9l9EJdrrSx/pRscuVzUNldqzzAmcHiulbckoRBWufzilYtmN34NSq4X7fKe3eCzqecEZbaEpk1FlrFiLir4=
Received: from CYXPR03CA0059.namprd03.prod.outlook.com (2603:10b6:930:d1::11)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1eb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 08:21:29 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::17) by CYXPR03CA0059.outlook.office365.com
 (2603:10b6:930:d1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:29 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:26 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 39/44] drm/amd/pm: retire legacy smu ras driver framework
Date: Thu, 25 Jun 2026 16:19:32 +0800
Message-ID: <d0b84670c44dc17bf7d3619d4cdd425ea2967030.1782373702.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e64be26-f473-4d94-0ed7-08ded292c1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +RiVUXxT1Ukd6BDLinv1ihpKXrBVuzasp5t0Fjjjah/OEgUlMdCkAECOVcPtkyCJhNfbkRM5YNSjPSbOMOE12JXbFjajpD5dfGlH9A/sqNgHNUHFMtDWRH5OeFxsMP220V4w2bZduNPVcHaAWy4GJlTPQFrMfCt1tmgvnavHEoNHYCM6WL+CQBkviGJ+mO8NkPTcu3vpVtQv7gF3m2wj5jkbyw6o3LueDeknBHAlruKrCF3Mk9D+np+Z0kAsGfx1bgD7IwBYkEg/xN9Q5ou/JgF8RMYhfXAluZ8CNFWbz0+1IFe9bXicZVWbfWXno9w6T5L102jVgDvOkkHdIsomjFcYo2J9aReTNeo7QW/QmOv8iLi/J4tG6HbdD3EX9HF8tCuAQPyCow7+um5vJxueC2iep3EDjxcWncXpwP58OYIPmUjioNA8lEyxrr2/GZu3ayJt5evHPVh9YxqzOxAQGc8LK8NJhHtbhfbPZdX3qETqJfdorWDYEP20ZsKPIoPosiAFP350cwK0UwGji+F8OhJnVU5Xxp9vHe/NFn7fkVLEq/gxptrQdA3RTOvdCfti6HteAwwF0NPFbjnqLGNkKQ9az2d+fhzVpBzw1sj4DuCxztXZwfiLcVP9fea3+nY9QIafI/9Wef5sjUc1YyLD6UR89qMwYczInzyxCI71MfnFot4kCivRlDsJvR/hoGD6sOA2K4KrCR96Oa67rrzFfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YfthOl2tn6vrwjUbqUDDyt+uqkeLo8yq1oYc0Rgaia701OkuH4wJX3mA/6ifIwJEsg3clRgFjfSuxDKzvO54JaNsD3RwRbHVEo7aLJu76PQYvD/H4ZtDJDDALaJekJCxsUZzQKIpJalnu/21DUaE1tZoFTs8eU0jMd0wwFIWcleqQF9nr9I/NXcZtaIGYLWc1IQPS6852wcazPBhkiFocRAC7HXmyGmw1wdgMK8ydzFrHZAFAG5i6zHmhNXeBj4iaDT8kvyNmSI/rjDkl9VRhlRSfGMYWw9rtyOAsAk1K0W/+CY9P8sGvXLvXdOlDp77Qemf2oFqofMYr1ICVd5VJsDbIEmpwQvF86XfZEcm/svqztM569gATRC9mRlnsav03BbXhunGSLG1vMeNJaMpMb9wDpwjCt3bSNVeinNL/16nE1N0UDAF8K61uoD8m7FU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:29.1450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e64be26-f473-4d94-0ed7-08ded292c1d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
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

Remove the legacy smu ras driver framework

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  1 -
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 -------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 11 ----------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 -------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 21 -------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 -
 7 files changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 2608a248dbc7..dfbed18268af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -598,7 +598,6 @@ struct amdgpu_ras {
 
 	/* Disable/Enable uniras switch */
 	bool uniras_enabled;
-	const struct ras_smu_drv *ras_smu_drv;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f76ba6753551..c09c60ad3f38 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2110,10 +2110,3 @@ ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 
 	return ret;
 }
-
-const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev)
-{
-	void *pp_handle = adev->powerplay.pp_handle;
-
-	return smu_get_ras_smu_driver(pp_handle);
-}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index aa3f427819a0..c7ea29385682 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -612,6 +612,5 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
-const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d809487205a4..9908f3d78b93 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2818,17 +2818,6 @@ const struct amdgpu_ip_block_version smu_v15_0_ip_block = {
 	.funcs = &smu_ip_funcs,
 };
 
-const struct ras_smu_drv *smu_get_ras_smu_driver(void *handle)
-{
-	struct smu_context *smu = (struct smu_context *)handle;
-	const struct ras_smu_drv *tmp = NULL;
-	int ret;
-
-	ret = smu_get_ras_smu_drv(smu, &tmp);
-
-	return ret ? NULL : tmp;
-}
-
 static int smu_load_microcode(void *handle)
 {
 	struct smu_context *smu = handle;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index d76e0b005308..efa0b8ba07f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1647,13 +1647,6 @@ struct pptable_funcs {
 	 */
 	int (*ras_send_msg)(struct smu_context *smu,
 			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
-
-
-	/**
-	 * @get_ras_smu_drv: Get RAS smu driver interface
-	 * Return: ras_smu_drv *
-	 */
-	int (*get_ras_smu_drv)(struct smu_context *smu, const struct ras_smu_drv **ras_smu_drv);
 };
 
 typedef enum {
@@ -1995,7 +1988,6 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
 			       enum pp_pm_policy p_type, char *sysbuf);
-const struct ras_smu_drv *smu_get_ras_smu_driver(void *handle);
 
 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
 			    uint32_t param, uint32_t *readarg);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 966b2415d983..7c5e04a1cc94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3273,26 +3273,6 @@ static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
 			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
 }
 
-static int smu_v13_0_6_get_ras_smu_drv(struct smu_context *smu, const struct ras_smu_drv **ras_smu_drv)
-{
-	if (!ras_smu_drv)
-		return -EINVAL;
-
-	if (amdgpu_sriov_vf(smu->adev))
-		return -EOPNOTSUPP;
-
-	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
-	case IP_VERSION(13, 0, 12):
-		*ras_smu_drv = &smu_v13_0_12_ras_smu_drv;
-		break;
-	default:
-		*ras_smu_drv = NULL;
-		break;
-	}
-
-	return 0;
-}
-
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.init_allowed_features = smu_v13_0_6_init_allowed_features,
@@ -3351,7 +3331,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
 	.post_init = smu_v13_0_6_post_init,
 	.ras_send_msg = smu_v13_0_6_ras_send_msg,
-	.get_ras_smu_drv = smu_v13_0_6_get_ras_smu_drv,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 24848da90234..45e3758e9ed8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -98,7 +98,6 @@
 #define smu_is_asic_wbrf_supported(smu)			smu_ppt_funcs(is_asic_wbrf_supported, false, smu)
 #define smu_enable_uclk_shadow(smu, enable)		smu_ppt_funcs(enable_uclk_shadow, 0, smu, enable)
 #define smu_set_wbrf_exclusion_ranges(smu, freq_band_range)		smu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, freq_band_range)
-#define smu_get_ras_smu_drv(smu, ras_smu_drv)			smu_ppt_funcs(get_ras_smu_drv, -EOPNOTSUPP, smu, ras_smu_drv)
 
 #endif
 #endif
-- 
2.34.1

