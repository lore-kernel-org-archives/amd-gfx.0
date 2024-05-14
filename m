Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63939C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E9710EA63;
	Tue, 14 May 2024 11:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x5UYybkd";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B7F10EA7D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCedEH5bxGMxByA7iDfuMjmPobhZN+boRZwjwuUe1bDfKCzEZMr7d/T+llX0tVoA2SSyhR3gwosAiXyFc/LdNnPcnVgkNK2Q5Q3DmD3U5AREMqwQ/HCbIeP4b3mcVJ9V0OPAsm3zac0yTpjEvxpgDY41rsIU/DyXJZcutlSww/iiCiX2V/go87yVJ4zhdHwICJTAnUV0qaWeCPREvxP4MdyLcNCt9c9y8oP92zAf/+ocHRCkHSMfHMfwrGhj1Pnoyvk5XY+J7NYnZY1Vr6SdCBoo14nydnFaAElDG+T5XOQGCjRKax8HukMulq8e/ijt/c+IGza59feP0V8TlyAqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yu5sqBQxTQjS99BW8LPEdYvYI5VMqPmhu8JWlb7EkY=;
 b=fQuPdBefEw2QU0z1N6UK0VtCekCPZqYx4u1dsaXddXK+FyjKyC6X7hcJ23SP9Oe7d4j2fqXX+APl09NjRh6p2uQsiQwY//ng/q1/ETC5l/JqGPM4rmkcPeKS8I0yk3ATdhLHyAbU6tpo8vbl1sI/VN1o8uwJm8iuWxt8D0TOtMvcA8C7CBtDt3MvXKr4oGmUdLTOn3YPyPY1k8BlmKE7xVID5NVUd/89N9H76VEDb/cOGpKxsdOfnlHs0W8nwD0zr2sVNHZBhE2cqWTkO0udFdnkTMkzjEaFNxI1MSsdv95GLluToOr4uZ6jjJdK518yaJxZbYBl6wA4KSJ0DjLpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yu5sqBQxTQjS99BW8LPEdYvYI5VMqPmhu8JWlb7EkY=;
 b=x5UYybkdoEtdowyJoIjS4zlys8tGK5yRMzoRfaszGZj1RGcAr4ceuh1CU/BF30VUm21DfVtxg6MxJpVX/QP4r+xm6hB8Mt8CVHGM5EcrxPKtD9IrD8fH66pNKo6spNXfGXsMBn+Fc4FmiWOA5+kapltlbtVPG1ThkauENSwVtBo=
Received: from DM6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:333::20)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 11:06:39 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::1c) by DM6PR03CA0087.outlook.office365.com
 (2603:10b6:5:333::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 11:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:39 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:37 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 08/10] drm/amd/pm: Remove legacy interface for xgmi plpd
Date: Tue, 14 May 2024 16:36:04 +0530
Message-ID: <20240514110606.396234-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514110606.396234-1-lijo.lazar@amd.com>
References: <20240514110606.396234-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e67db6-ec0e-4a83-3b65-08dc7405edce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YAT6SprScub3JmZoNFct3hqyhiRxaBUlXiMyhX333LeLaZ8rjhFuPjglvyTM?=
 =?us-ascii?Q?oSAJo04hEf56Mystr87WhS2aYHwe8Xlj6AEpRC2Sa3hWJukexePLKYoKWZOX?=
 =?us-ascii?Q?7jkM4qIJAvo6njoKf5+xlR9LcHsDlEVEfNo/iVFxMm1nDzqF+jpg3cHX4XDf?=
 =?us-ascii?Q?TF3OTFgLTBPPArKcmFHbQK0oB/r6tX5iW1wh+olo5PsEoketLXmeeZUmac/A?=
 =?us-ascii?Q?AC95Ivst9J1XpQ18WPkof9kAqqUn+UfvXsWfUyPusuQ2jo+ShL+N9F3kxklG?=
 =?us-ascii?Q?OZIEu69qaH8NhxbYVeTBpvLtVC2wMtEVleV27YmyLOmdyDwbWo4upuz1EQb6?=
 =?us-ascii?Q?X94BpSj0bPPPk6Mxfz/8ONaiKSXPYCBvS6XURMHA9WtPZ1lokRwTFzrUOwq2?=
 =?us-ascii?Q?nHCr0Sy098+CEmq2o/rDB6WmJLJVzNv4b+ys5RQGv9EkuH5pDu5o4L8qWKOM?=
 =?us-ascii?Q?RfRY9DMWef1LNEGzB0iX7sZaE4nWFgOp+nyc7fA/GQeaZC9tmws4/8POKk5q?=
 =?us-ascii?Q?ZVJLXWpi0C0OrSb8X48ycG8qnz4//LWgNDzPqgBGCk8dBZEAT2O6loJkggkW?=
 =?us-ascii?Q?31RLdKQydX6IeGSMJ06eWe5MSfxlSGQD4XO0tlls/tut5+WmOTMP/sr+FkqA?=
 =?us-ascii?Q?RAR3Lip5rPXDtMIJbyQgkD4RTUhfACIhVYWtCzmuNBpz20gIRqpc9qKs2QyI?=
 =?us-ascii?Q?fxKUrDZ/CSfg8uDDH6v6oNI3Ww4EAS6qjU48j2r2fXRd0YVkxRvnIKWoQWF4?=
 =?us-ascii?Q?oPhPvELe4TBC3FsLy7PxrJoe1GXQLuFnNdjaUYp0N6/gfGEUg9tZ4fd+R4Cr?=
 =?us-ascii?Q?CpOjhByurQ9LRb9517h70MCYugkn1cahRBdbRMOy9CUlG4P7adIQH35pBzhF?=
 =?us-ascii?Q?FWM2DCkj7GElkeLwSGWtIMCC4qJhlGrxPCwHdWJL1R1mZ5VDumFFUWBtmSaT?=
 =?us-ascii?Q?jRCn0KHMiFCb/adzF1izegs73sO6Qy4YiVO4NPm/8N0mjJ8bJOgtxWMItEfe?=
 =?us-ascii?Q?t3jIMB1osc7t2JJgj5SGH0nBU0LPjqF1ssy3GC9Sb7ZQeKaYxoFDZ+5FmN9v?=
 =?us-ascii?Q?RO1O6INvbikKI2euu62C+0GCnqHb2C/p89Hw0zAIDVkv/evPKpdnLErWVtgS?=
 =?us-ascii?Q?K4/AbQ6gek3qXnpMlyJX48YsobFF/mNGUmQLMgPjvreYewunZgaYK6ntqu1C?=
 =?us-ascii?Q?Yshu06xfNwxIlCHjsY9psrJTuvICewGd61TijpiKPX0O8Ip/sSR2UGNo6FvX?=
 =?us-ascii?Q?AhAHGPzv4uv/rANU1kla/zeVwAGYFUyRwZxMVs97UBE8wt0Ezg4+0qVlT2HF?=
 =?us-ascii?Q?02p3CdU+5jBv+KNhia9WHLoz4hlw+tCLlOZOsH7MkeH75CQ3QynmoORAdf+d?=
 =?us-ascii?Q?/LSlp0RCLq0ELio6wH0d2o1eVgrn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:39.2517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e67db6-ec0e-4a83-3b65-08dc7405edce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
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

Replace the legacy interface with amdgpu_dpm_set_pm_policy to set XGMI
PLPD mode. Also, xgmi_plpd sysfs node is not used by any client. Remove
that as well.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
v2: No change
v3: Rebase to remove device_attr_id__xgmi_plpd_policy

 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 43 ------------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 68 -------------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 --
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |  1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 27 --------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 -
 7 files changed, 2 insertions(+), 148 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 4a14f9c1bfe8..821ba2309dec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1446,7 +1446,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow df cstate");
 
-	ret1 = amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DISALLOW);
+	ret1 = amdgpu_dpm_set_pm_policy(adev, PP_PM_POLICY_XGMI_PLPD, XGMI_PLPD_DISALLOW);
 	if (ret1 && ret1 != -EOPNOTSUPP)
 		dev_warn(adev->dev, "Failed to disallow XGMI power down");
 
@@ -1455,7 +1455,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_ras_intr_triggered())
 		return ret2;
 
-	ret1 = amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DEFAULT);
+	ret1 = amdgpu_dpm_set_pm_policy(adev, PP_PM_POLICY_XGMI_PLPD, XGMI_PLPD_DEFAULT);
 	if (ret1 && ret1 != -EOPNOTSUPP)
 		dev_warn(adev->dev, "Failed to allow XGMI power down");
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index b443906484e7..cd169af35399 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -368,49 +368,6 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_get_xgmi_plpd_mode(struct amdgpu_device *adev, char **mode_desc)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	int mode = XGMI_PLPD_NONE;
-
-	if (is_support_sw_smu(adev)) {
-		mode = smu->plpd_mode;
-		if (mode_desc == NULL)
-			return mode;
-		switch (smu->plpd_mode) {
-		case XGMI_PLPD_DISALLOW:
-			*mode_desc = "disallow";
-			break;
-		case XGMI_PLPD_DEFAULT:
-			*mode_desc = "default";
-			break;
-		case XGMI_PLPD_OPTIMIZED:
-			*mode_desc = "optimized";
-			break;
-		case XGMI_PLPD_NONE:
-		default:
-			*mode_desc = "none";
-			break;
-		}
-	}
-
-	return mode;
-}
-
-int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device *adev, int mode)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = -EOPNOTSUPP;
-
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		ret = smu_set_xgmi_plpd_mode(smu, mode);
-		mutex_unlock(&adev->pm.mutex);
-	}
-
-	return ret;
-}
-
 ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char *buf)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b03c38d198ea..5c92c041d0bc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2214,70 +2214,6 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 	return 0;
 }
 
-/* Following items will be read out to indicate current plpd policy:
- *  - -1: none
- *  - 0: disallow
- *  - 1: default
- *  - 2: optimized
- */
-static ssize_t amdgpu_get_xgmi_plpd_policy(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	char *mode_desc = "none";
-	int mode;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	mode = amdgpu_dpm_get_xgmi_plpd_mode(adev, &mode_desc);
-
-	return sysfs_emit(buf, "%d: %s\n", mode, mode_desc);
-}
-
-/* Following argument value is expected from user to change plpd policy
- *  - arg 0: disallow plpd
- *  - arg 1: default policy
- *  - arg 2: optimized policy
- */
-static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
-					   struct device_attribute *attr,
-					   const char *buf, size_t count)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int mode, ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = kstrtos32(buf, 0, &mode);
-	if (ret)
-		return -EINVAL;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	ret = amdgpu_dpm_set_xgmi_plpd_mode(adev, mode);
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return ret;
-
-	return count;
-}
-
 static ssize_t amdgpu_get_pm_policy(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -2421,7 +2357,6 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 			      .attr_update = ss_power_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
 			      .attr_update = ss_bias_attr_update),
-	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pm_policy,				ATTR_FLAG_BASIC,
 			      .attr_update = amdgpu_pm_policy_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(pm_metrics,				ATTR_FLAG_BASIC,
@@ -2491,9 +2426,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		else if ((gc_ver == IP_VERSION(10, 3, 0) ||
 			  gc_ver == IP_VERSION(11, 0, 3)) && amdgpu_sriov_vf(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(xgmi_plpd_policy)) {
-		if (amdgpu_dpm_get_xgmi_plpd_mode(adev, NULL) == XGMI_PLPD_NONE)
-			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_mclk_od)) {
 		if (amdgpu_dpm_get_mclk_od(adev) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 1455db9c3789..484e7af1c2b4 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -430,11 +430,6 @@ int amdgpu_dpm_baco_enter(struct amdgpu_device *adev);
 int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 			     uint32_t cstate);
 
-int amdgpu_dpm_get_xgmi_plpd_mode(struct amdgpu_device *adev,
-				  char **mode);
-
-int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device *adev, int mode);
-
 int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev);
 
 int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index 6ec9fca045e0..d2075ff9a877 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -77,7 +77,6 @@ enum amdgpu_device_attr_id {
 	device_attr_id__smartshift_apu_power,
 	device_attr_id__smartshift_dgpu_power,
 	device_attr_id__smartshift_bias,
-	device_attr_id__xgmi_plpd_policy,
 	device_attr_id__pm_metrics,
 	device_attr_id__pm_policy,
 	device_attr_id__count,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 48b867f4cf04..451f81099087 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1203,7 +1203,6 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 
 	policy = smu_get_pm_policy(smu, PP_PM_POLICY_XGMI_PLPD);
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 2)) {
-		smu->plpd_mode = XGMI_PLPD_DEFAULT;
 		if (policy)
 			policy->current_level = XGMI_PLPD_DEFAULT;
 		return;
@@ -1212,11 +1211,9 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 	/* PMFW put PLPD into default policy after enabling the feature */
 	if (smu_feature_is_enabled(smu,
 				   SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT)) {
-		smu->plpd_mode = XGMI_PLPD_DEFAULT;
 		if (policy)
 			policy->current_level = XGMI_PLPD_DEFAULT;
 	} else {
-		smu->plpd_mode = XGMI_PLPD_NONE;
 		policy_ctxt = dpm_ctxt->dpm_policies;
 		if (policy_ctxt)
 			policy_ctxt->policy_mask &=
@@ -3610,30 +3607,6 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 	return ret;
 }
 
-int smu_set_xgmi_plpd_mode(struct smu_context *smu,
-			   enum pp_xgmi_plpd_mode mode)
-{
-	int ret = -EOPNOTSUPP;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return ret;
-
-	/* PLPD policy is not supported if it's NONE */
-	if (smu->plpd_mode == XGMI_PLPD_NONE)
-		return ret;
-
-	if (smu->plpd_mode == mode)
-		return 0;
-
-	if (smu->ppt_funcs && smu->ppt_funcs->select_xgmi_plpd_policy)
-		ret = smu->ppt_funcs->select_xgmi_plpd_policy(smu, mode);
-
-	if (!ret)
-		smu->plpd_mode = mode;
-
-	return ret;
-}
-
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
 	.set_fan_control_mode    = smu_set_fan_control_mode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f304071adee1..356231fd976d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -602,8 +602,6 @@ struct smu_context {
 
 	struct delayed_work		swctf_delayed_work;
 
-	enum pp_xgmi_plpd_mode plpd_mode;
-
 	/* data structures for wbrf feature support */
 	bool				wbrf_supported;
 	struct notifier_block		wbrf_notifier;
-- 
2.25.1

