Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15255C25B77
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A092E10ECE6;
	Thu, 16 May 2024 12:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLY2cv+J";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293DF10ECDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWcFDodiFku4bsCorItvc3Nx2eP9kTbrcxWQPHrH+Eqxr8bUYNG1mjKCb9Z1lFASNH33QnDjhTQk5p23wD+0wHQHGzJfix2c0cNIIdao2HCAwp5RDfbrfEhIUpvCHUAcNIpQ+DzDeWqEfA+tyU+0l/gyE1B/+Y8o1bH+FS9k/qyT5fwUY0oEg6ORZdC9TajyaM477Kl81UqiIlMAa/7VbSZoYAiaqokU13IBgj1JmszLzwMAdILz9Z19tiT70u6bpUiZpQ07s1bBYjo1+eFG2AVtgSmhVZMqP1xxsa+o2wQ9dZWMUiqVkrM7Pt+ctsbJ0CFh3YexEDvCQnK+rN214A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcU5+bI03sPfDMTuK13QOPZVTxzRSiyO8mh+LorAzE4=;
 b=X+zCZj2lAseV8NVhE/9JUWzIYARmb9N79lPIRbqKcWEJDc1rR9DQxxupV1YO2u6ByUWpYeaiaOsBEftlFjf5EtUJA1zG7+2xOZ75fOL/0P+IZ5bhiucjoB1FBV+GhGFHpXq6ukEcuwBCtNwWef6inArGUILlZQg8Ur1iGj9E8aGMg/QF4UTURzfKhO9QvjAKy/YvAT34pcP+C6twmp12dPxYx/l/lxwWf5D5bScm48QrB/wsbKtSiFHdVpsIWUJCIEyVaqPjBoL+n7OPibD3mCfw8UlvxzM3zq9NKgTSfRvqK+r875xg9pR9003zu3E2V+S+pZubJLnl3BoGFw5r9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcU5+bI03sPfDMTuK13QOPZVTxzRSiyO8mh+LorAzE4=;
 b=bLY2cv+Joa3ARPDj90I8iZ5CPx7hMHcMOO11GT8yYYCEms6ajkUYtuZH1Wp1qccsNm3JEiSpi/FBfpZ8slZufs3pWwnst/vpVNs/CobhEEYSzks0jawaE0OiU3Uj/tt3LiJ6fAR3DuPsFDmZX6sTv6WjuyFaw+ZZ1EKqVVKURcI=
Received: from CH0PR03CA0416.namprd03.prod.outlook.com (2603:10b6:610:11b::7)
 by PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 12:43:59 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::64) by CH0PR03CA0416.outlook.office365.com
 (2603:10b6:610:11b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 12:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:43:59 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:53 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH v5 08/10] drm/amd/pm: Remove legacy interface for xgmi plpd
Date: Thu, 16 May 2024 18:13:16 +0530
Message-ID: <20240516124318.508785-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516124318.508785-1-lijo.lazar@amd.com>
References: <20240516124318.508785-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a3921b-5580-4cb4-6f95-08dc75a5db93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hHN7VafuDGmUslubeUDW30YjV42BITmXbrYWCYgWtMnr7ZCNeHx9AG0nZhrr?=
 =?us-ascii?Q?okelStibWnamz89m+Oh33BG9D+8kUKCzagJ33bGhLqwMgK0eWj06yDnkEI0R?=
 =?us-ascii?Q?4alUYdiEmzN46MxXNxKp0ZWsh6/AJszNrc/fuZon+dHmbXZ+wlaw0l3FSUrq?=
 =?us-ascii?Q?ophoVB8yORC682XqC+FuceUvmrtueoltToykLSm3Yhg6KiDHXPUpgdeW4OiD?=
 =?us-ascii?Q?roX2nzes9C4mX983B43dcdz6oWhdhxdz7pKd04S+RqUznVXMVfpQTdhIfN4E?=
 =?us-ascii?Q?Vfj0EWdd3rKH6Q0lgsC7DIxIWCDrdpxh6b7eyVO0pS0uPqwvUIXJ+VtcIFyx?=
 =?us-ascii?Q?G+kZ9zLtNf9gnukJlaDAZJB23yz3tVf0Ma+Evp3tlJKtyskUVNVYSwZXs3Eb?=
 =?us-ascii?Q?EyOhy0q7fc+GqihPR8gUru74333N4h8ND0AtwSRx9ppeM8QYWlIaryG86B/m?=
 =?us-ascii?Q?nJAyPgh49jyiZkbnbIzmBu1NZBJ7rqWTsmdVSXqbnAyxUi1OBF6z3HKXHM3G?=
 =?us-ascii?Q?Lbzv7yhlCmsY5mIw3cVffIgyJ87nu2H/jStJSPPtU3iafzbC6oQXDb1oOAAP?=
 =?us-ascii?Q?KCnf8cKRHb/xMw815uSw5jkZedEQjn+XmR1tifXN+YVouQba7Flh26VGLufe?=
 =?us-ascii?Q?KQHTzSfmZSBWYJCG+W0uCJSxN4YdAcUcG23igkLvlVv0aT1gA0/VEQSpQ6VG?=
 =?us-ascii?Q?E3J8FKuQfnMj2AmJEqQnFdxb8suM4fFUrr5cVfcujERsgsXHy9Z1jctx/AuC?=
 =?us-ascii?Q?lx0hc98gwTDUowP7Z8dE20z8VpO5hTNWHfrZMyN/mHZyQEfDfkAkqjTOwJvU?=
 =?us-ascii?Q?Uzs9cYt+bctPgK+6JkTZiUcyXZnePb9Yvf6j6KMkY9Rd3rTpV7T8tzNPQTyC?=
 =?us-ascii?Q?EVaO3T/lT59OcX1cxDpO0tqDDBTopvkQoe8XQakEWkSD0FEIVGGMjmruWVlX?=
 =?us-ascii?Q?ah1GQ669/2SZrcJP7fHuqLH3UUNFG95m9wEJHxrYEA+j1cNz2cAaxSMGD4ld?=
 =?us-ascii?Q?x6k0dtXalsLs0eTr7Fnn5iJra0SN/y/TlDYvNNKmk5FP3bebD6Jma9tjigBM?=
 =?us-ascii?Q?qupuT0W/ZVAuDGZnzgdqk6suFalzIf/7KsUex1HFXfK36UjWxXGVfU884ARx?=
 =?us-ascii?Q?uuQU7Wc8QXGtddN3kcvwJtbs7z27Yt6j4Q/8Sj8dEx+kF1WX6674KjVdCNwB?=
 =?us-ascii?Q?N7SK2OPZXilGXRSi0H1FmqUa6DLybJ2EwndiXgJiqJoV/DeRxSF7pY4yg1Q/?=
 =?us-ascii?Q?hdPXM1dJxeizZKl7G7rqXEx7E8k9o1S+v5a0+WPI3XXqqjkbPsvRomub93bO?=
 =?us-ascii?Q?otpQmTjzkjrNMiUmhZX7yQ8GwgtzmFSpaW6xf/rxvT+/NHQafIbql2ZCSqR1?=
 =?us-ascii?Q?TjsoOK0Wr2xN9MG8vVxyeN/Bn+3z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:43:59.2756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a3921b-5580-4cb4-6f95-08dc75a5db93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187
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
PLPD mode. Also, xgmi_plpd_policy sysfs node is not used by any client.
Remove that as well.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
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
index 9c991362b398..b3b5e7b74c85 100644
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
 ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 				      enum pp_pm_policy p_type, char *buf)
 {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d47a646c680b..5ff7783dfc43 100644
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
 /* pm policy attributes */
 struct amdgpu_pm_policy_attr {
 	struct device_attribute dev_attr;
@@ -2452,7 +2388,6 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 			      .attr_update = ss_power_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
 			      .attr_update = ss_bias_attr_update),
-	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(pm_metrics,				ATTR_FLAG_BASIC,
 			      .attr_update = amdgpu_pm_metrics_attr_update),
 };
@@ -2520,9 +2455,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
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
index c0f4037d2041..f5bf41f21c41 100644
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
index 448ba3a14584..c12ced32f780 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -77,7 +77,6 @@ enum amdgpu_device_attr_id {
 	device_attr_id__smartshift_apu_power,
 	device_attr_id__smartshift_dgpu_power,
 	device_attr_id__smartshift_bias,
-	device_attr_id__xgmi_plpd_policy,
 	device_attr_id__pm_metrics,
 	device_attr_id__count,
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 51f78e6ccf07..dd64cebbab2c 100644
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
@@ -3611,30 +3608,6 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
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
index 84ec4ae3d6c5..7030bc008883 100644
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

