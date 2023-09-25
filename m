Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3414CE7A81
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 04:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EDF710E1D3;
	Mon, 25 Sep 2023 04:28:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B2310E1CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 04:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbLac8qKbe7gGATVtbKiValqxytgaWIxdi4ndoR5lV3cM84pn2K4947nnMLzEAtWTABDE4dtkgXZnVXVS99IKgoX6il1nXi1O3grsSU49b6z0aFpSY2r9ACy5fc6br/Y4zgov2ep8gy77VhFckn15C4iQL53T6nvWnBNPrMKnH1MhFwK59YbttV9BnQbv3mRCYb0p9c4Xd4H7laJx/zgMNeMeVqmqmMLGgqrkOrWSr0+y3ldqUAwAtOc64tnf/2GZXoE4U6OhFTHsDKF8cKXB5UmZj5WsHKa11M52YcmJlqebbcoxiO69FZG+Jprn7AqMpffElUngFOcCYf2I+4dwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnPgXSijMslY/53B4AsumgzIooV8iMYfJ5buHwlNkJg=;
 b=VembnYKs0AIa/67PMf/PSc13zhTAmws+PTrPfSBD0lzn8za4pPTWBxUMD3XHvIGYFbQfePk2JHX9z6ljT+mt+m62d/dwBBkkVhgiqB0uF4NKR/xf25oHI2wc3sGQ0EUyZPMU+spkXrv7BEggGoQmGgJWJctJveHo6g8tn/3l7fKu0uWh74U6iSNMwLftDzYxnuftl+KfnTvZciRouT0ODHUKaalM56V0Vgq8p6ETjzdamfH1cd82YF3GrWTu3L4ebf//3nkM3wTSKu9mYzm6Q6XYFaR58Isj5ON3wPfMqSB/hklnQQ2YMcfiUgfkQnFAUAi0dsacMGWpwmuNObYY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnPgXSijMslY/53B4AsumgzIooV8iMYfJ5buHwlNkJg=;
 b=S/e3adxVJbLjWUudi/nyBPrRqv2asUlofHQXDdRi7qLw7vWDlV0Gh2fDwgovz+gQqB49udVcRl6M1G/SsvXgtROUjDwLRJsB26iMfWH8sZxB0XI4Ei31jD3Ivi4FWbJXVg8v4QvCQ7G6ymwfXEpbxNnCO5AfJX2+oum4Q7WPQFo=
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 04:28:48 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::a1) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Mon, 25 Sep 2023 04:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 04:28:48 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 24 Sep
 2023 23:28:45 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amd/pm: add xgmi_plpd_policy sysfs node for user to
 change plpd policy
Date: Mon, 25 Sep 2023 12:27:49 +0800
Message-ID: <20230925042752.3847-4-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230925042752.3847-1-le.ma@amd.com>
References: <20230925042752.3847-1-le.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae72b09-a89e-4540-5549-08dbbd7fe9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suEgwLcre0A3NnNx0FhdfQ9TT8SCOD9OqCnQutRAIi8TZMMo3dcZLvih00pivP4qcH2Z1A46BjXtbsceyvwkYU/d01QGh6Tas1KOZgFjhyGzVMHxRFF9fqvkKmD0kk+E4o5dM1gyIYqdN1JvkRbEkBJhbE+sXFiicUoGng1U3MrwJE8YAltS1lkAj1OQDPy7WrsT2/BK6qpC3BnJ54mH6vogtBOj3SOK4WI6xtec5ShcGQpqoOHk+UJLmPryqs/UiB9yjjvTJ2UiuWVqqqh71c84x0mZXnOTis9ddXww3JiySj3f/3CZCLdWKrrxHgMdCl3iyl1UJp0s9U7+pyc1TeH2407AgKHvyAkqKukFizoeQ7OBu/jvmBBENQp0T94VZvJ+gQuW166yxo5UdvM15My6udm2Q1CL2C5B9ewhc5bumasGfhLx9OEJ9ZhX+BdCxb1V0Z6rHp6x9z5qGu5N48lKHFae1aVbW+C0xKywwENqtYnTsIxP/PaniC/1id6u+gnbqpxKxK5TG50QMYJ5c6pf1GC4iwatXnOtm5BzCi0caWU3rhNfTpHhCttUhqx45Bm53FnuLkreOWMoYbe0sNfrwyzIpHdQ5ZVEi2382sBiNxvE3PwvRsEdKrwzwnRIZaUjZBlrhXdRkMurdrtX9yQar8IosLzEvMacVldx7HZ3dhrN2WBKMYwUe6B13andAhC3c2BcswX8mkeM3vw2uIBF3yOtM5G0UWnDa1ue9LTQ0eP8PDIg4mciIHljmlb2lUVb6Sf+0+bYYUi4NVfrIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(316002)(5660300002)(44832011)(36860700001)(40480700001)(8936002)(4326008)(8676002)(41300700001)(54906003)(6916009)(70206006)(70586007)(2906002)(40460700003)(356005)(81166007)(7696005)(86362001)(2616005)(36756003)(47076005)(478600001)(82740400003)(1076003)(26005)(16526019)(336012)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 04:28:48.0663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae72b09-a89e-4540-5549-08dbbd7fe9ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Asad Kamal <asad.kamal@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add xgmi_plpd_policy sysfs node for users to check and select xgmi
per-link power down policy:
  - arg 0: disallow plpd
  - arg 1: default policy
  - arg 2: optimized policy

v2: split from smu v13.0.6 code and miscellaneous updates
v3: add usage comments around set/get functions

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 43 ++++++++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 68 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  5 ++
 3 files changed, 116 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 078aaaa53162..9a157fe4cbc7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -365,6 +365,49 @@ int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_device *adev, bool en)
 	return ret;
 }
 
+int amdgpu_dpm_get_xgmi_plpd_mode(struct amdgpu_device *adev, char **mode_desc)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int mode = XGMI_PLPD_NONE;
+
+	if (is_support_sw_smu(adev)) {
+		mode = smu->plpd_mode;
+		if (mode_desc == NULL)
+			return mode;
+		switch (smu->plpd_mode) {
+		case XGMI_PLPD_DISALLOW:
+			*mode_desc = "disallow";
+			break;
+		case XGMI_PLPD_DEFAULT:
+			*mode_desc = "default";
+			break;
+		case XGMI_PLPD_OPTIMIZED:
+			*mode_desc = "optimized";
+			break;
+		case XGMI_PLPD_NONE:
+		default:
+			*mode_desc = "none";
+			break;
+		}
+	}
+
+	return mode;
+}
+
+int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device *adev, int mode)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = -EOPNOTSUPP;
+
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		ret = smu_set_xgmi_plpd_mode(smu, mode);
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return ret;
+}
+
 int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
 {
 	void *pp_handle = adev->powerplay.pp_handle;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2807f3bd9ebe..745f5b6a2826 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1991,6 +1991,70 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	return 0;
 }
 
+/* Following items will be read out to indicate current plpd policy:
+ *  - -1: none
+ *  - 0: disallow
+ *  - 1: default
+ *  - 2: optimized
+ */
+static ssize_t amdgpu_get_xgmi_plpd_policy(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	char *mode_desc = "none";
+	int mode;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	mode = amdgpu_dpm_get_xgmi_plpd_mode(adev, &mode_desc);
+
+	return sysfs_emit(buf, "%d: %s\n", mode, mode_desc);
+}
+
+/* Following argument value is expected from user to change plpd policy
+ *  - arg 0: disallow plpd
+ *  - arg 1: default policy
+ *  - arg 2: optimized policy
+ */
+static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int mode, ret;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	ret = kstrtos32(buf, 0, &mode);
+	if (ret)
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	ret = amdgpu_dpm_set_xgmi_plpd_mode(adev, mode);
+
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2026,6 +2090,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 			      .attr_update = ss_power_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
 			      .attr_update = ss_bias_attr_update),
+	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
 };
 
 static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
@@ -2123,6 +2188,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 		else if (gc_ver == IP_VERSION(10, 3, 0) && amdgpu_sriov_vf(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(xgmi_plpd_policy)) {
+		if (amdgpu_dpm_get_xgmi_plpd_mode(adev, NULL) == XGMI_PLPD_NONE)
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (gc_ver) {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 5efdba6e358f..564494f29717 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -426,6 +426,11 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 
 int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_device *adev, bool en);
 
+int amdgpu_dpm_get_xgmi_plpd_mode(struct amdgpu_device *adev,
+				  char **mode);
+
+int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device *adev, int mode);
+
 int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev);
 
 int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
-- 
2.38.1

