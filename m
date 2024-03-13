Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03E7C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4813310E4E7;
	Wed, 13 Mar 2024 11:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wo1YB/Qm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40B910E4E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 11:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkgoxE//5otzcq3szt5kofwDiXHJEFJutXYCjgfwGmpMdl0pgWHj4YsWlNQRZIrNEZmMVqtR0fEPocivISzIiYt3RdEZG+e5hntzp1B0ySI7eEahXISZC5g1koC60EaV0o/3fuaNC65ZXwXx5u2yZhSCXzPY3RSGnSztvsGx+1gkMqwxKxB3gECzJY3UMM8n7SvOHLhHKeJwpjE+VkcgrQ+M+88kOrMWDbFFWH5lT+GDebl5B0j2HgQaJowqD+8k3CNPx/120wBMpunUXnpgHHLYYWtoCo47YKj2dyhaIsKDBsR3CTPTJjSiq0zO9Fdf5ozAVcD7qsz8seqQGGdSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pPjkZW4h5EEUZB/b3dCUDOC/Uve67mcFTcIN+QlnS0=;
 b=UAQQn9jEHHqIEch8IhLiosuAhNGag30rzDll9kGwC/ggPGy3TFXSvZylt/WqYNjwUrFYwkI1BHjbjkN1Aqhs5Fi9QJgiOMeVYEea+Ifif6syhW3e4mYGjsgUlUnqiPRppYIjA71IPsz8RXTw+AclFukl/haQsP+D6z5PaUovTF9ume8Ojyyy/nBQG9rFQwx/aiNqhih7pldjXrWYb+oUZhrjRhbOv8IUtXUDcPApg0cipsmBjO0Eo7JD+/Rz8rIseZxeXG52aYFYIeoOMJaP+r9aCYITQBuuy4VPR/aXy9vYLNvPHJ40t/foy4dg7Z8eih+Sj8tmm0X8LToT/G6tGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pPjkZW4h5EEUZB/b3dCUDOC/Uve67mcFTcIN+QlnS0=;
 b=wo1YB/QmWywEdk8kI7MvrWqDrBD7ATdpv/a7uWNqSfllDYNc0k5PTOlk2F8dSKRorLoAizhRmSWbimP2G3tv8UEDHSGnAEi3INU5O/TF7OfGyzdXr/p0TridGBkpnk2TEX4sREiRK50lxVvs6ItRdQQo3oElr0YdP9ewiAdlc/Q=
Received: from MN2PR22CA0006.namprd22.prod.outlook.com (2603:10b6:208:238::11)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.39; Wed, 13 Mar
 2024 11:03:23 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::c8) by MN2PR22CA0006.outlook.office365.com
 (2603:10b6:208:238::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 11:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 11:03:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 06:03:20 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH 1/9] drm/amd/pm: Add support for DPM policies
Date: Wed, 13 Mar 2024 16:32:48 +0530
Message-ID: <20240313110256.669474-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 34036b99-8dc3-4441-b235-08dc434d32fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqVI8YZoQZOlMA5WhFTXiv29DtSme6yJ0Aw42oRduikT5+MvGLsIVduwAIzJ35nFvNmcirtJ1uP5iaie9eC3zLNpBfqKxFntvsoA6B4494kJX2bmQjJbX6wOWWDlUBua6JKLgjgfDiEYox8FUlFABJKAUHWZ6ziSV55e9e60bOUyjfitJdMbr93tUgdSb7LfKecYlx6pSEGtOYmiEyHsW9H7I4WlfoDkpt4pMr1dSipY9mYMoK9cMjsUht/nlePXFECCukFnjvi7qKVtT7Sl8Ll4XCf6Kx+LUHMEpZdoOqXO5uHZacuaUA4SmJbg1XQtOzub/jMR4tji/t1Ljtw52JtV+zMz0J7m4YkEnD1agKYmRjXRk9OLnOpFtkBP73aJ6WXY+6n18U5HKtpfwEyQWrI98WvKaXO0ZBR/coHxBLVOGdIKEIvS6HQBJssA6226P0IXM1IhatIuRREi4Hr+wUXfI6S4hXF3MGvJyYP0llvLKRpd2q+LcQWW5v2w4y8Bkg7wD/fOeBYH4TTvvGE0DCfh+OYEkBwauGPDMwaDEF4we8WMMU3RHpcvN/DNpWoJv0s+uqQghc+zRdNb8SX350XAG0Sh3cdANpu5QVHKovq+0IKyC/hI7s1xrfJwYKI+6TE1+5CRcgt1cPj9kkkbFvil+FXTM565+mYlkcqx8g95pFfjK0bmiFQ3SN7FPS6LR3CTFpJiG3XKh9ITfJShdaa4ErRfdF6opA5zhWEerjfg8I39oHTACn+xTUwNcSb0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:03:22.6132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34036b99-8dc3-4441-b235-08dc434d32fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
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

Add support to set/get information about different DPM policies. The
support is only available on SOCs which use swsmu architecture.

A DPM policy type may be defined with different levels. For example, a
policy may be defined to select Pstate preference and then later a
pstate preference may be chosen.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 ++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 29 ++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 92 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 95 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 29 ++++++
 6 files changed, 265 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 32054ecf0b87..e48da7acd7a7 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -272,6 +272,22 @@ enum pp_xgmi_plpd_mode {
 	XGMI_PLPD_COUNT,
 };
 
+enum pp_pm_policy {
+	PP_PM_POLICY_NONE = -1,
+	PP_PM_POLICY_SOC_PSTATE = 0,
+	PP_PM_POLICY_NUM,
+};
+
+enum pp_policy_soc_pstate {
+	SOC_PSTATE_DEFAULT = 0,
+	SOC_PSTATE_0,
+	SOC_PSTATE_1,
+	SOC_PSTATE_2,
+	SOC_PSTAT_COUNT,
+};
+
+#define PP_POLICY_MAX_LEVELS 5
+
 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f84bfed50681..db3addd07120 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -411,6 +411,35 @@ int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device *adev, int mode)
 	return ret;
 }
 
+ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char *buf)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = -EOPNOTSUPP;
+
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		ret = smu_get_pm_policy_info(smu, buf);
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return ret;
+}
+
+int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
+			     int policy_level)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = -EOPNOTSUPP;
+
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		ret = smu_set_pm_policy(smu, policy_type, policy_level);
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
index f09b9d49297e..d8c8eaff3355 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2155,6 +2155,96 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
 	return count;
 }
 
+static ssize_t amdgpu_get_pm_policy(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	return amdgpu_dpm_get_pm_policy_info(adev, buf);
+}
+
+static ssize_t amdgpu_set_pm_policy(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int policy_type, ret, num_params = 0;
+	char delimiter[] = " \n\t";
+	char tmp_buf[128];
+	char *tmp, *param;
+	long val;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	count = min(count, sizeof(tmp_buf));
+	memcpy(tmp_buf, buf, count);
+	tmp_buf[count - 1] = '\0';
+	tmp = tmp_buf;
+
+	tmp = skip_spaces(tmp);
+	if (strncmp(tmp, "soc_pstate", strlen("soc_pstate")) == 0) {
+		policy_type = PP_PM_POLICY_SOC_PSTATE;
+		tmp += strlen("soc_pstate");
+	} else {
+		return -EINVAL;
+	}
+
+	tmp = skip_spaces(tmp);
+	while ((param = strsep(&tmp, delimiter))) {
+		if (!strlen(param)) {
+			tmp = skip_spaces(tmp);
+			continue;
+		}
+		ret = kstrtol(param, 0, &val);
+		if (ret)
+			return -EINVAL;
+		num_params++;
+		if (num_params > 1)
+			return -EINVAL;
+	}
+
+	if (num_params != 1)
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	ret = amdgpu_dpm_set_pm_policy(adev, policy_type, val);
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
+static int amdgpu_pm_policy_attr_update(struct amdgpu_device *adev,
+					 struct amdgpu_device_attr *attr,
+					 uint32_t mask,
+					 enum amdgpu_device_attr_states *states)
+{
+	if (amdgpu_dpm_get_pm_policy_info(adev, NULL) == -EOPNOTSUPP)
+		*states = ATTR_STATE_UNSUPPORTED;
+
+	return 0;
+}
+
+
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2193,6 +2283,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
 			      .attr_update = ss_bias_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pm_policy,				ATTR_FLAG_BASIC,
+			      .attr_update = amdgpu_pm_policy_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(pm_metrics,				ATTR_FLAG_BASIC,
 			      .attr_update = amdgpu_pm_metrics_attr_update),
 };
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 621200e0823f..a98d1bda4430 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -594,4 +594,8 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 						  unsigned int *num_states);
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 				   struct dpm_clocks *clock_table);
+int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
+			     int policy_level);
+ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char *buf);
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 246b211b1e85..1c23e0985377 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3465,6 +3465,101 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 	return 0;
 }
 
+static void smu_print_dpm_policy(struct smu_dpm_policy *policy, char *sysbuf,
+				 size_t *size)
+{
+	size_t offset = *size;
+	int level;
+
+	offset += sysfs_emit_at(sysbuf, offset, "%s \n", policy->desc->name);
+	for_each_set_bit(level, &policy->level_mask, PP_POLICY_MAX_LEVELS) {
+		if (level == policy->current_level)
+			offset += sysfs_emit_at(
+				sysbuf, offset, "%d : %s*\n", level,
+				policy->desc->get_desc(policy, level));
+		else
+			offset += sysfs_emit_at(
+				sysbuf, offset, "%d : %s\n", level,
+				policy->desc->get_desc(policy, level));
+	}
+
+	*size = offset;
+}
+
+ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf)
+{
+	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
+	struct smu_dpm_policy_ctxt *policy_ctxt;
+	struct smu_dpm_policy *dpm_policy;
+	size_t offset = 0;
+	int i;
+
+	policy_ctxt = dpm_ctxt->dpm_policies;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt ||
+	    !policy_ctxt->policy_mask)
+		return -EOPNOTSUPP;
+
+	if (!sysbuf)
+		return -EINVAL;
+
+	for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
+		dpm_policy = &policy_ctxt->policies[i];
+		if (!dpm_policy->level_mask || !dpm_policy->desc)
+			continue;
+		smu_print_dpm_policy(dpm_policy, sysbuf, &offset);
+	}
+
+	return offset;
+}
+
+struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
+					 enum pp_pm_policy p_type)
+{
+	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
+	struct smu_dpm_policy_ctxt *policy_ctxt;
+	int i;
+
+	policy_ctxt = dpm_ctxt->dpm_policies;
+	for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
+		if (policy_ctxt->policies[i].policy_type == p_type)
+			return &policy_ctxt->policies[i];
+	}
+
+	return NULL;
+}
+
+int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
+		      int level)
+{
+	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
+	struct smu_dpm_policy *dpm_policy = NULL;
+	struct smu_dpm_policy_ctxt *policy_ctxt;
+	int ret = -EOPNOTSUPP;
+
+	policy_ctxt = dpm_ctxt->dpm_policies;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt ||
+	    !policy_ctxt->policy_mask)
+		return ret;
+
+	if (level < 0 || level >= PP_POLICY_MAX_LEVELS)
+		return -EINVAL;
+
+	dpm_policy = smu_get_pm_policy(smu, p_type);
+
+	if (!dpm_policy || !dpm_policy->level_mask || !dpm_policy->set_policy)
+		return ret;
+
+	if (dpm_policy->current_level == level)
+		return 0;
+
+	ret = dpm_policy->set_policy(smu, level);
+
+	if (!ret)
+		dpm_policy->current_level = level;
+
+	return ret;
+}
+
 int smu_set_xgmi_plpd_mode(struct smu_context *smu,
 			   enum pp_xgmi_plpd_mode mode)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a870bdd49a4e..39405e4ef590 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -362,6 +362,27 @@ struct smu_table_context {
 	void				*gpu_metrics_table;
 };
 
+struct smu_context;
+struct smu_dpm_policy;
+
+struct smu_dpm_policy_desc {
+	const char *name;
+	char *(*get_desc)(struct smu_dpm_policy *dpm_policy, int level);
+};
+
+struct smu_dpm_policy {
+	struct smu_dpm_policy_desc *desc;
+	enum pp_pm_policy policy_type;
+	unsigned long level_mask;
+	int current_level;
+	int (*set_policy)(struct smu_context *ctxt, int level);
+};
+
+struct smu_dpm_policy_ctxt{
+	struct smu_dpm_policy policies[PP_PM_POLICY_NUM];
+	unsigned long policy_mask;
+};
+
 struct smu_dpm_context {
 	uint32_t dpm_context_size;
 	void *dpm_context;
@@ -372,6 +393,7 @@ struct smu_dpm_context {
 	struct smu_power_state *dpm_request_power_state;
 	struct smu_power_state *dpm_current_power_state;
 	struct mclock_latency_table *mclk_latency_table;
+	struct smu_dpm_policy_ctxt *dpm_policies;
 };
 
 struct smu_power_gate {
@@ -1547,6 +1569,9 @@ typedef struct {
 	uint32_t		MmHubPadding[8];
 } WifiBandEntryTable_t;
 
+struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
+					 enum pp_pm_policy p_type);
+
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_get_power_limit(void *handle,
 			uint32_t *limit,
@@ -1594,5 +1619,9 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 int smu_send_rma_reason(struct smu_context *smu);
+int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
+		      int level);
+ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf);
+
 #endif
 #endif
-- 
2.25.1

