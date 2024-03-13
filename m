Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406BEC54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7646610F4F5;
	Wed, 13 Mar 2024 11:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ghDO/9IC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66DE310F3A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 11:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir+BtQXVgefw8HBT8aF/H9VExspnvPLWi/3EHcrnTJtTy5A+/GrXm+34Z+VyaeMQFSi8G/blTYo+Twr2zNvPH0VkJujNKbzGcJ2KtvJ7JOxtQOgiONGifqVXcpVjN688Wx6VYxw+M0YwA711jpGSVGkD+XgwFZoSsrY8OF8dHffpYKujUzXNgsBs7pBRyVNvbTev9QlhqETz7FedyrSviH3nIEelEMy6eXtgXVMWABQtjgPR+gacgNV1daAYzWRDB2GGtT8o9WXkyGqlVF1xVv2/O7qUUTFva2lXRnEYtDq/KyvoPptIJxVLaXuPjbcS61yY4D7bS0pgbfvSqdZAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYNGknFlHcrMnSppE6p78NvIifPF3uVP1crGjNmXWm0=;
 b=RSYiStmXqwxm2T+oo3zhs+XKxivoz4VJe9jnnC2Ule0nSSZXHoiOAwjOhOM1waNkw/1mvbSRvet4haKToNQpY58MBxOQnBeW2Qj1COR7FGUE2/s080iTA5CxtteYQnuaLnNHyDg8Fxwd+rTMSH6ZX8jQdDYZy3D3LY1y1EyuU2gxSVZNCO4Wrkj8jxzrAJHhdjzLH6FZhxyzZaIl7zLLU4mMzpNf28jQh7c4h01rqS/kHLdWbpwIEbjQ8EM2Rn6XN77u0qO6CfMT2Cy2TocibUMNfxl4/iYSovDq+6krjyt14KFZT27IsxqO/tfvV1LsrVtWJ5Cak+piqw6UnNPbCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYNGknFlHcrMnSppE6p78NvIifPF3uVP1crGjNmXWm0=;
 b=ghDO/9ICkZ2iXZFtXERCiRyNeaDcyrUv2wXBjeZIq95xVPx+q1zkq8oWPHAVSroko4CSzbMvosUKu9pf0ny1tN47cND7AXaqokRxrtwvDBeHkTzrTFoqtu4+don+jCpzPzkWitExfVEVADAiYoJlk0wxT4TzV4t5U6+XL4o268Q=
Received: from BLAPR03CA0032.namprd03.prod.outlook.com (2603:10b6:208:32d::7)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 11:03:34 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::3) by BLAPR03CA0032.outlook.office365.com
 (2603:10b6:208:32d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 11:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 11:03:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 06:03:32 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH 8/9] drm/amd/pm: Remove legacy interface for xgmi plpd
Date: Wed, 13 Mar 2024 16:32:55 +0530
Message-ID: <20240313110256.669474-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313110256.669474-1-lijo.lazar@amd.com>
References: <20240313110256.669474-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ca8a84-a702-4738-ced3-08dc434d3a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpolpeZVLOIes6bKJuoW7rNwgrHsN64j/Lfh1mreqXkO0ikaSDnF9jfEWFvckMdwKmjhbMvOTsejbSte1uaEqwpdeSEMAXB3LnAdp5tY8EERsffqs7TLr5hkbxOgM16LMmWly7AdF791ti+AiMNsvs/ZZhBo2rsBIYLLob3PIQZywsJHsqNw+yzeJsC1EJoJH1QVb0gf3MJhOzsD3x9gmrytJZKe5q3mpi9MOo27gKr57ppbMAY4cGatm4/l5U2aqKNHBE0ztFIwFZML1+s3EEw9m88dAIIJuQQxA5HDOQGfxq/HJn5/NLohfvMKoBUlVHPIYN4wee4E1DNcIbmokBJKhotqEaiijD86woLxjQ2lMv36g2uFzUzag66jAda8Ypp+bIxGtfd/dkVkKIHypOA1/GikJhJw/LSsMr0X+6e3W44at/lrzgM7L6udBlXnS4GstrciXIQfWjpE66TbrEYehm4EELXgXI0Fc0Cx3yK95KYyjWX8MbHWqGoNyhzsjj5ydobNBn+YatlWkLxrbwusaeHn/s3GBNiqHuNFg0dnmuhh1QbkmG5Hhi21Loiw0U64N6H/G8hFe5HQUHdawmx4VipTFZ5tPP5kOnN/68iBqet1Nl0oKVbGfWFTeMLPu6HuqImeXrwpkmJNjY62hOCX3WduO8pw8YquV+fUuwjtmW4d0sDOSltd1HQymtf15R2r3XDJfgXptGnh6O1lO75q4843VrqyGFlf9bHvQvYle7FMiZj+dcaQ5u3wwY/5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:03:34.5677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ca8a84-a702-4738-ced3-08dc434d3a1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 43 ------------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 68 -------------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 --
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 27 --------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 -
 6 files changed, 2 insertions(+), 147 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 20d51f6c9bb8..ecac9607a819 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1429,7 +1429,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow df cstate");
 
-	ret1 = amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DISALLOW);
+	ret1 = amdgpu_dpm_set_pm_policy(adev, PP_PM_POLICY_XGMI_PLPD, XGMI_PLPD_DISALLOW);
 	if (ret1 && ret1 != -EOPNOTSUPP)
 		dev_warn(adev->dev, "Failed to disallow XGMI power down");
 
@@ -1438,7 +1438,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_ras_intr_triggered())
 		return ret2;
 
-	ret1 = amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DEFAULT);
+	ret1 = amdgpu_dpm_set_pm_policy(adev, PP_PM_POLICY_XGMI_PLPD, XGMI_PLPD_DEFAULT);
 	if (ret1 && ret1 != -EOPNOTSUPP)
 		dev_warn(adev->dev, "Failed to allow XGMI power down");
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index db3addd07120..21d05fab20d5 100644
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
index 1d5a8428601d..f7a289440c4c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2091,70 +2091,6 @@ static int pp_dpm_dcefclk_attr_update(struct amdgpu_device *adev, struct amdgpu_
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
@@ -2285,7 +2221,6 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 			      .attr_update = ss_power_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
 			      .attr_update = ss_bias_attr_update),
-	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pm_policy,				ATTR_FLAG_BASIC,
 			      .attr_update = amdgpu_pm_policy_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(pm_metrics,				ATTR_FLAG_BASIC,
@@ -2384,9 +2319,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
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
index a98d1bda4430..645c501649f3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -426,11 +426,6 @@ int amdgpu_dpm_baco_enter(struct amdgpu_device *adev);
 int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 			     uint32_t cstate);
 
-int amdgpu_dpm_get_xgmi_plpd_mode(struct amdgpu_device *adev,
-				  char **mode);
-
-int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device *adev, int mode);
-
 int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev);
 
 int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1c24f2cc5b29..a90d5f842ce7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1196,7 +1196,6 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 
 	policy = smu_get_pm_policy(smu, PP_PM_POLICY_XGMI_PLPD);
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 2)) {
-		smu->plpd_mode = XGMI_PLPD_DEFAULT;
 		if (policy)
 			policy->current_level = XGMI_PLPD_DEFAULT;
 		return;
@@ -1205,11 +1204,9 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 	/* PMFW put PLPD into default policy after enabling the feature */
 	if (smu_feature_is_enabled(smu,
 				   SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT)) {
-		smu->plpd_mode = XGMI_PLPD_DEFAULT;
 		if (policy)
 			policy->current_level = XGMI_PLPD_DEFAULT;
 	} else {
-		smu->plpd_mode = XGMI_PLPD_NONE;
 		policy_ctxt = dpm_ctxt->dpm_policies;
 		policy_ctxt->policy_mask &= ~BIT(PP_PM_POLICY_XGMI_PLPD);
 	}
@@ -3572,30 +3569,6 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
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
index 39405e4ef590..5970b99c8f4e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -600,8 +600,6 @@ struct smu_context {
 
 	struct delayed_work		swctf_delayed_work;
 
-	enum pp_xgmi_plpd_mode plpd_mode;
-
 	/* data structures for wbrf feature support */
 	bool				wbrf_supported;
 	struct notifier_block		wbrf_notifier;
-- 
2.25.1

