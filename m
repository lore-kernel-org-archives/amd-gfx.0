Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7F6C54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 11:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A49410FACF;
	Thu, 14 Mar 2024 11:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EBj9lK+u";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C19910FABF
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 11:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhJekS5Uxv+/HbjzZladnrymZs1gHhrA5/zzcggIjnti7baL+oxzvyjax4A529RluzIv+pfikwc7Ol20n6g+aG1YHcvVtvWQUUUpFvvezyuvBzuRYRSjXBX3sISGhcA0+O9OFdxSIp89kGb5zh5pbS0cInPO6Dq+l4X/6NyuXFi6kfcKp8UAsssFrnsw5ux8VH8vE0fvnG1z7j8WpSHCWBBeIB+Q05vo1juCY2BAzqYs6rw6zqY57ln2KKTAQylprTliZ7+VJuM+3wZjtWeMPhijddE3SAWe3ca2jLYmtbkPTXFrmDFB/TD+GJnHI86C8dJBQ74VXJ0CykYXh78esA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glONHWYavBB3EVd6FPREyZ0SE4c5tOVM5B4/yEO2WEs=;
 b=a4NeDyyQ6bnfXL51iRIQSiGYL1kOIhwPP4g78B063foo/5Ed+hrY67aHXTLL8aF7jWTdvmt9GBKN3x/KNQRWFwu71suYRMW3cOihvsyTtV5tAoUFWvIgQ9iJsXMqk3JPpd8hthyaozxRZ9Y/rdgPB7X/CaQ2CWBAQdJwPKeqUrHAFA6xLjzA1P+TvPFU62Cc5Erke/45omQnvm5Jj7I1r1/skMKqdUn5UAffY8B1ixDNwalyuvfPCsMRVtgzz51N2+ClKfNWEmo+quLqvFG+zsKz93M2XFQjZJoNlic/3pnnrdDduSDg2AkD7O+4LBPES5MTJx2/jG0VSQPJvmpanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glONHWYavBB3EVd6FPREyZ0SE4c5tOVM5B4/yEO2WEs=;
 b=EBj9lK+uC1tLUYeTrpIORmLrXbCo7m+WZA4s+cgCjVumAvJoD0mAu3OHcmrHmpwr/4j7yQzYCMo6PaW460m2QIsMNCKm3ziU454IjDFn0aDNqx0XP0pjfQSApENKxu1XdTJSlrInLhu/3ngqhjIRoAq7w7/aBLsolXi+2CXpK98=
Received: from CH5PR05CA0010.namprd05.prod.outlook.com (2603:10b6:610:1f0::22)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 11:57:18 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::54) by CH5PR05CA0010.outlook.office365.com
 (2603:10b6:610:1f0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.8 via Frontend
 Transport; Thu, 14 Mar 2024 11:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 11:57:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 06:57:16 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH v2 1/9] drm/amd/pm: Add support for DPM policies
Date: Thu, 14 Mar 2024 17:26:22 +0530
Message-ID: <20240314115630.682937-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314115630.682937-1-lijo.lazar@amd.com>
References: <20240314115630.682937-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 30444f93-4dc6-40c2-d7ae-08dc441de5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBcGHiisG/Sty3f2EIZ5O/PEaDyo4678RD1hqXdw58b07ITwFKV6x2oMPRtuon3Z4GgjblkOU+2Zx9k/2idSPJ0/NuMjY6TXglDDrDuie5GZ1gwFXB/LeZOe61xrdHJGTz9mwYjbzUgXBJQVce9lXRqfBvrEDiFfFV3LIaMVpFylXIjD4M6uSri/Mb7zr2Nj7b1TYiMUd+l1PjstNDZZbsp/XWvf01f+Rol8iXKLQxhuHkDIqe1rwV4Kn37PtWJfMLi4bh1vozNFBFOa0DWZMHu3Ay9t3+ACmb/wfWo4UncJx2vHw0zsYrg4Wo3OodFAdnkYdKCvWyAYbARPeSxNfbgylKk5+oo8TYdGK5KaXlcWkYlhWjLFirAErz9jKbupInOi0DXienoc23DeZUpfjGnKDz1W5jJ+N5t90YG6D/3OPGEIZxNUm5HhCQlH08QQzioaIHzHSRrvN/ERQ+bUngxjYfEAsWmYkyeoJ9hFigo8hqpWnzZZypFynB80qMacFVJFVLeYVxQfhO/z4v+8lKu79UOIXe3NeSyqqr6tKj48Du8Jkwc3W2NSJCGPyFaZjU0eHcDWElPRxlKbX9dVcGKarIoIMjExiRulgCQk+NpTwUJ4f7x9S+ICZkxj+UVBeYc1wquhhFT7NNLfL1WYtLJQXUhnO4/AbfxOfxNQr7ifvGSl4Mb00XQ9+SVfqRakqUxGaGbERSEaTeg7ngDD/ecAOUqDY+ruvf+rnUzfI+cfTvzvVRlb3PlGAFcwErjR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:57:18.1689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30444f93-4dc6-40c2-d7ae-08dc441de5f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
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
v2: Add NULL checks before accessing smu_dpm_policy_ctxt
	
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 ++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 29 ++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 92 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 95 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 29 ++++++
 6 files changed, 265 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index afb930b70615..84dd819ccc06 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -273,6 +273,22 @@ enum pp_xgmi_plpd_mode {
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
index efc631bddf4a..7ee11c2e3c61 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2179,6 +2179,96 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
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
@@ -2218,6 +2308,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
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

