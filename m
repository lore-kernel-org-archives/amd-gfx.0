Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C41C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3746610E582;
	Mon, 13 May 2024 09:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hu14p3+7";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87F510E582
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xunm5piCCD+vZ7TelzxP7qyntR/hsu42rhvrr2YfrSudgNbQLKYvhnSvtuRVB5Z5VHaAOwY665snP6y72bwqQ2iUL4G00uUV8UpBMQOUVXaYe737SoEg3ODiM6n9jfuKrDsNOWd5WlsPjUruN/eKMOaCMYfrerOOlEYU9cEDkCP8r5fhsnSkJZjU7lBLqiT+bFfIa40CfQKy7Y9BMd1yi4ovC5oiggrt0r/4pfYU0PYyyj2WGc+bORs6dn0Lq+MBCDESs4qyyzZex3+zwUW7eIkY9mBcqNfbDTHjHxTLxLe8tGealjQLH8yPDl6JmPph2D55ECfNSb8J7IZ9aCfVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olf4UQ4loZneVtDFXjGALZsSSEeofOsSvPUZ785igF4=;
 b=d3+XqQqLSgkryp9PX5/e0ptasLLa6L48L4IqM2Z1fj9F4yRt9CDMikOSwPq7Woy/7fFW/dbgsgk7KluK8fZjc8X0Vrsnl8cfUQ5ShHhbST+Rbg5k3MKVhS07Qs5hELL0ruiVNiNjmArYoY8LyZrxqkmYRHUeVDrMngR+fUwmP9/60rLbUiYS2XOMNF6r8STCqY+RtrfQw+kTV3b5adZ8SEACpUjpxKa9PWwUF50OPQBFBNlv9iRCl4GaVBoBS5J4aq28fNOnmhlG6BzBh8VR39dmyyS+/DxHCTyO14IBBj+G/kEhLW8IoLOtjO3Slwl32CS6Qofcoo1Hc78ZrBjzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olf4UQ4loZneVtDFXjGALZsSSEeofOsSvPUZ785igF4=;
 b=Hu14p3+7PQUNpJfOrn8A4wmJPeOO8QTD4WsogBa9NYrgIFF3GIZdLr7rJx1WwXtNWI0Q6p22JF1yxhI+7CN9bltx/q8xaz5/pkksR8YzprOCQunFmYo1400G8BHXBhPn4TnqeGqJ4FLo/FZpLgZJCOMMtJhWvK3S5V37e6jgmZU=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:21:44 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::4) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 09:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:41 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 08/10] drm/amd/pm: Remove legacy interface for xgmi plpd
Date: Mon, 13 May 2024 14:51:09 +0530
Message-ID: <20240513092111.341168-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513092111.341168-1-lijo.lazar@amd.com>
References: <20240513092111.341168-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc2d121-5167-4ea0-f5c8-08dc732e1b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SrfdT3hBOq8ETx9Awusa1NHktpWZb+Dmuy11sXWhSG4Jc1P37CwXllUFAM8Y?=
 =?us-ascii?Q?7C1231EeDNrB47DmnYqJigqv41R7JbP/6vfViEYre67GcEkfcKlwq3rrEsiy?=
 =?us-ascii?Q?PW9gOI6Y6C1alhmZU6fgmqy22sldDYlCiTpPg4QBQJ+AGxjkPWTC1Gj71YmN?=
 =?us-ascii?Q?yrL/R7kfA1IYhSUhoSIb5pMP2qlWu5j1HwRWm9kT/UnabY3n/W+wePQKHROA?=
 =?us-ascii?Q?kkxjTq1PtNNGy8p69MgeQstFA5ZPMyLMC2lNxJwUHs7hSQxjLzEq9l/uV+FL?=
 =?us-ascii?Q?6grivQkw8+WIwbb1WwQiZnkgs0k277mx/xU6oegAxTPCGCCMBTLY+vnTEfQq?=
 =?us-ascii?Q?cS2LNwZ37e5LuLCFB5b4NYjAHeRLaPF5dENyluZx7AQl/zwrjz+z2mvuCOQM?=
 =?us-ascii?Q?bdMPb/RX2TnEw0w+9u+T79xlYm/D+t+OVQa/quZ3IxxzBJtmJdIyFnCv/P8/?=
 =?us-ascii?Q?UJFOQHjkiwXKhFE8RPw/Spk178SOjpUN/FhVw+VGBZwjE0mQmCkGqXsmZ35t?=
 =?us-ascii?Q?q+NPoqDaEiT2svCwblpQpM+ps4q5Gxgpb1ZCFipYz5hnB4StXOSDiEaskEPF?=
 =?us-ascii?Q?fZ+pVYPCmQABdduWtVj1B/xyYTLRdoSvDs9N3EiLnm9XEpEFbBcuMLZy1DzU?=
 =?us-ascii?Q?bU65FuvCXxqCfEukcEthqJSPFp1gZLOUpEd0ovSwALHHbI7Ewi7O+YOfbgww?=
 =?us-ascii?Q?yvzuBomUexT6mhbfv3pD8E0KCBedoG+X8Ymx7uxmNa+sNKf4Mg3WF0dilKfH?=
 =?us-ascii?Q?Srg3b48llesQoYdD/mEClb5c9KjGJbI3e6aLZqjOfrn6TFqq0Y2DCJOnChMV?=
 =?us-ascii?Q?2PKpEEx7KY+anmGf9bN1bgZZxqRQ4sDre3WwGTKx/8vh5kd7/JkxNZDbbbfI?=
 =?us-ascii?Q?4OzIxd+gdeMJfflImE6E/v+dRd7mUVjLhLpBd5bdwa1jC3cYbWNg35fJJreQ?=
 =?us-ascii?Q?H3rM0jmBap+cQEY+Jpgli74zJbgi2PyhhNZW3yWJzSpdN8X4mJMBMOtZM1Fc?=
 =?us-ascii?Q?zEnGnprmqbL5TRYH6EypyA7IWiDe+hZBQhdYIx/xE81O08w/CsnOJcdiE/Nu?=
 =?us-ascii?Q?bXnFlu7VCqU7Fm5J5mF/dKtnTGpNOyB6vJblJM7VJkagW8l5iaXolMu9D4wx?=
 =?us-ascii?Q?AOdWGUUkbn2UX8IpR0gWRq+Ep17qodMsPz6j1Fc74wzuRml38AfQVwgA/CD6?=
 =?us-ascii?Q?YMaOKV0ONMRjnCJU3GNo85ahdmZkbu1zEuL8FwTWw+l3pOoOgsZmcQhdifNs?=
 =?us-ascii?Q?p6qbZWDkC34XiFqwJLJ7r9r4B+4b+1lm4pRnBR189u1avZ5N6jfAN5+oqDHp?=
 =?us-ascii?Q?9dQSrpZ2wbzpd1m4kA4/JZ6N2N6wg4tOxMypPneTAMsCRM7qNRKtIfrIMCLn?=
 =?us-ascii?Q?1EjGOTggA6IS6+dQ3RnWO9Mv9vvt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:44.0411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc2d121-5167-4ea0-f5c8-08dc732e1b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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
index 48da662da005..9cca4716ec43 100644
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
@@ -2418,7 +2354,6 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 			      .attr_update = ss_power_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
 			      .attr_update = ss_bias_attr_update),
-	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pm_policy,				ATTR_FLAG_BASIC,
 			      .attr_update = amdgpu_pm_policy_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(pm_metrics,				ATTR_FLAG_BASIC,
@@ -2488,9 +2423,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
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
index a395967905d2..9dcd9c7f04ac 100644
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
index 035ed8844401..e460fa9aaf23 100644
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

