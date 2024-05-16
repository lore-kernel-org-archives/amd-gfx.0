Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D65C25B77
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF8010ECD9;
	Thu, 16 May 2024 12:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fy6d3vuD";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6876610ECD7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLNSu+WwUDB3r2UggJKSndagFt6Jy7ISSoL2MRqoQDuM8Bclhup4Ji/sbrMI3wMly5vhUk6xF3TVCE1XuuqO5Se9ctWyyP6gVB/z/hQDP/UtOrzhK/9UUXo2z9ZbSNR1oXPRWxZuyAjmPgw2QSXHOorygz9dDyrCCj0NvHp5F4uJzPDgh4O4g2vAURSIFgAhgByd1+lRJvo2AE5MM+ImJtXv729gFx4ThhjzJVAURGE9PAw1vYClKAJ6V4UvOFKqPJy4FLhirEA2fA9TmnEv7qZ+eqOIG18UrgtCWC20uIcg+rND5GJFKZeHftOmN7a4RBnD/bHi3f9r0JRk/YGGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUr66mZiNmf6cyP/GUB4R9ITiXrkxuxREKvrqoOXHvs=;
 b=dVNQ8iZ/EGCXPrZIgdjhKFSgh0yiILhSs15CGaec+pmKuXPTk65aYq46twth12q+yl6/MJ4QHiaNIMaW4LcLsfYF4C2spU5Jd0vuSGrRd/6xCfOLywyInzZcZp+h10z7+iIKpwVIZ00FEoHHcy6IufQTVdT2pom6Xhaiqddjw8plyRhkLXKUnxx46fGOGC38xYZmHDpUOcTKuw+8JtyLDFZyzqvJj+ZhCrRaQko60Um5YROFSVmHTQ6zj0nOKRSSC+EkGpWXjeOviS4omZYPc5SA6fYwuOdtJZK3GQm56IKdHrN/mScnOPBl/sQr9UiIj26c8wqvYyamJo6vMGHiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUr66mZiNmf6cyP/GUB4R9ITiXrkxuxREKvrqoOXHvs=;
 b=fy6d3vuDjrzsR+lkQwkQUvm4VXfH69WYui7iZK1Z3ecBN03JRa79I5t7b0slU5YSXALJH/Z5EwkNz3N+D10tKH0wEMQPES6l8bUdbAGAI1TJwJ8nyB/xxZC0SUAEcfRcpLDyLDunE7lCFs++KkD9xsqRXO3avK27NAkFx4J1fy4=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.28; Thu, 16 May 2024 12:43:40 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::74) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 12:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:43:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:37 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v5 01/10] drm/amd/pm: Add support for DPM policies
Date: Thu, 16 May 2024 18:13:09 +0530
Message-ID: <20240516124318.508785-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: ac35ce65-8b8b-4f3a-cb31-08dc75a5d051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xN8SNe2DF1T8E+fhtRTXzvaAiq+65APNRQCGz/dieAp9BC6h4o/Duq4VVUai?=
 =?us-ascii?Q?ObvFWF9yNbm5BpC7+NebCNtzzY9wB+7PcbXHiyQa9TVwYhJfvEkieeMcNCs5?=
 =?us-ascii?Q?4uvjYqpx1EEm7wp2TBY92M9sK7OSBjmOv/3DUCWIr4CZL5ihThyhP4/ICsBF?=
 =?us-ascii?Q?xs43b+P0vRSUNu0EssYlX5SCRZZAKm9+XwJV27SbJ+R/TbStv1QCUx6SW4MH?=
 =?us-ascii?Q?D2Bv2+ZwNcBiyiXU9WwAVLZBCoMKHwCeXewOzl0S6CWeuRR1AKGMdpE9ispL?=
 =?us-ascii?Q?h6GPKwMg6rlUC0DVyxmO8qmEAMHH91/pzOKiQ2BuCjH1pUVBKWWeZnh3ZN1A?=
 =?us-ascii?Q?CHp7ZCzEZR6acEuK6Fjl2ibVarMV0mcBIqgz4SMnVYLTXw80nln8APst82xj?=
 =?us-ascii?Q?OmVqFnjw7j0Lkzeos0Q5SVqf/Jkew7ryEYF8YsIf+TylB7WkQyuoX7ycH1Dx?=
 =?us-ascii?Q?MubkU9nXS+d7e+N/GdX1LXMcMQU/zVrice7OfMcMQiaxItksOwP0G6TljP0V?=
 =?us-ascii?Q?pbz8AFFcETvEHbEckhtiGH5zjDSuadU7yG9h0PwaUKYD6g4OhKYoeAmd5EAN?=
 =?us-ascii?Q?pihE2ST3f65GNlFNsEFc4lFb3UEwXX4kYbb/2ZDd2O6kd+di3YXMDVXz2GDp?=
 =?us-ascii?Q?S7FMC+eW0yaajz3x920nBPtoUoLdKmhTea4gEEprlF74bGfuG6zcV5ycOfA2?=
 =?us-ascii?Q?9el9jWFzklUpoXDC6ORRqK9T2fnEi1vuforhBSSt7Bb0IuTGEf3IcQhiBDPY?=
 =?us-ascii?Q?OW4i8CuFvg/af7b6/2/4eRHhJhlHhlyiw4C8f4sWHaaACH1h3tEAdfjjL1e9?=
 =?us-ascii?Q?cxpFAN9gZ7Kr0uk3+QF86nwAxpxxO7nJQZr755e3/K6FejAO63ed+F/tCsOU?=
 =?us-ascii?Q?f5TRdcAeRwMjqxsWx1OWtpYK7cjaGHbeKyBRk1GxA9vqUdSeMwCRx1IpM5Ms?=
 =?us-ascii?Q?ZFLpr1EaZ5ypyKCl8Khk1w9TxZNGulLz7yKRRJDNqtegV1aH3oJZOBYs3L/M?=
 =?us-ascii?Q?xoAh0JUkzNmulWEmsUJsw8jGxkmTsRcLPfQlYQy+n/xVBbXjasJUO0UZDPvi?=
 =?us-ascii?Q?zUvvmE6ckA75z48s0RIHSOK8w9qwE3NthWjAJ1KSDBjGBldN/4OvBcsz6xcQ?=
 =?us-ascii?Q?6YNIj05pzyNA83BicdzScATOwxIxSJYJbhnBr8EQjPUnrWr96RYsXRR67lXw?=
 =?us-ascii?Q?3CU2aMTseIaf6Z2lz7xapFNADqAoi8qtCub0NSAhsqNsERIshxbvwoO/02L+?=
 =?us-ascii?Q?FFoaeNr8ajDlyP+J2jHN/af8CwD7iS83HzDnF9e4SSi9JXJgkUl5iVS11B+W?=
 =?us-ascii?Q?WhSqRZcg99fp50oDYiNYn9nHuHesALqOpmq5RJYWsGLNqZ3ZcYQ8BNBZZg4R?=
 =?us-ascii?Q?DWk/T2t78CqWi5tTBT4k2b/S1rOC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:43:40.3905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac35ce65-8b8b-4f3a-cb31-08dc75a5d051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
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
---
v2: Add NULL checks before accessing smu_dpm_policy_ctxt
v3: Rebase to add device_attr_id__pm_policy
v4: Use macro to define policy type for consistency.
v5: Add pm_policy as directory node and keep policy files separately. 
Fix logic issue in smu_get_pm_policy

 .../gpu/drm/amd/include/kgd_pp_interface.h    |  16 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  30 ++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 133 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   5 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  99 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  32 +++++
 6 files changed, 315 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a0955cfe41ce..4adfe9f0fd92 100644
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
index eee919577b44..9c991362b398 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -411,6 +411,36 @@ int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device *adev, int mode)
 	return ret;
 }
 
+ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
+				      enum pp_pm_policy p_type, char *buf)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = -EOPNOTSUPP;
+
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		ret = smu_get_pm_policy_info(smu, p_type, buf);
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
index 110f2fc31754..f1d3423409b4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2278,6 +2278,131 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
 	return count;
 }
 
+/* pm policy attributes */
+struct amdgpu_pm_policy_attr {
+	struct device_attribute dev_attr;
+	enum pp_pm_policy id;
+};
+
+static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct amdgpu_pm_policy_attr *policy_attr;
+
+	policy_attr =
+		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	return amdgpu_dpm_get_pm_policy_info(adev, policy_attr->id, buf);
+}
+
+static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct amdgpu_pm_policy_attr *policy_attr;
+	int ret, num_params = 0;
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
+	policy_attr =
+		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	ret = amdgpu_dpm_set_pm_policy(adev, policy_attr->id, val);
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
+#define AMDGPU_PM_POLICY_ATTR(_name, _id)                                  \
+	static struct amdgpu_pm_policy_attr pm_policy_attr_##_name = {     \
+		.dev_attr = __ATTR(_name, 0644, amdgpu_get_pm_policy_attr, \
+				   amdgpu_set_pm_policy_attr),             \
+		.id = PP_PM_POLICY_##_id,                                  \
+	};
+
+#define AMDGPU_PM_POLICY_ATTR_PTR(_name) &pm_policy_attr_##_name.dev_attr.attr
+
+AMDGPU_PM_POLICY_ATTR(soc_pstate, SOC_PSTATE)
+
+static struct attribute *pm_policy_attrs[] = {
+	AMDGPU_PM_POLICY_ATTR_PTR(soc_pstate),
+	NULL
+};
+
+static umode_t amdgpu_pm_policy_attr_visible(struct kobject *kobj,
+					     struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct amdgpu_pm_policy_attr *policy_attr;
+
+	policy_attr =
+		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr.attr);
+
+	if (amdgpu_dpm_get_pm_policy_info(adev, policy_attr->id, NULL) ==
+	    -ENOENT)
+		return 0;
+
+	return attr->mode;
+}
+
+const struct attribute_group amdgpu_pm_policy_attr_group = {
+	.name = "pm_policy",
+	.attrs = pm_policy_attrs,
+	.is_visible = amdgpu_pm_policy_attr_visible,
+};
+
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -4419,6 +4544,14 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		dev_info(adev->dev, "overdrive feature is not supported\n");
 	}
 
+	if (amdgpu_dpm_get_pm_policy_info(adev, PP_PM_POLICY_NONE, NULL) !=
+	    -EOPNOTSUPP) {
+		ret = devm_device_add_group(adev->dev,
+					    &amdgpu_pm_policy_attr_group);
+		if (ret)
+			goto err_out0;
+	}
+
 	adev->pm.sysfs_initialized = true;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 501f8c726e8d..c0f4037d2041 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -598,4 +598,9 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 						  unsigned int *num_states);
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 				   struct dpm_clocks *clock_table);
+int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
+			     int policy_level);
+ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
+				      enum pp_pm_policy p_type, char *buf);
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e61aa4418d44..b7bce8c34634 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3498,6 +3498,105 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 	return 0;
 }
 
+static void smu_print_dpm_policy(struct smu_dpm_policy *policy, char *sysbuf,
+				 size_t *size)
+{
+	size_t offset = *size;
+	int level;
+
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
+ssize_t smu_get_pm_policy_info(struct smu_context *smu,
+			       enum pp_pm_policy p_type, char *sysbuf)
+{
+	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
+	struct smu_dpm_policy_ctxt *policy_ctxt;
+	struct smu_dpm_policy *dpm_policy;
+	size_t offset = 0;
+
+	policy_ctxt = dpm_ctxt->dpm_policies;
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt ||
+	    !policy_ctxt->policy_mask)
+		return -EOPNOTSUPP;
+
+	if (p_type == PP_PM_POLICY_NONE)
+		return -EINVAL;
+
+	dpm_policy = smu_get_pm_policy(smu, p_type);
+	if (!dpm_policy || !dpm_policy->level_mask || !dpm_policy->desc)
+		return -ENOENT;
+
+	if (!sysbuf)
+		return -EINVAL;
+
+	smu_print_dpm_policy(dpm_policy, sysbuf, &offset);
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
+	if (!policy_ctxt)
+		return NULL;
+
+	for (i = 0; i < hweight32(policy_ctxt->policy_mask); ++i) {
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
index 0917dec8efe3..a35ffe5d2021 100644
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
+struct smu_dpm_policy_ctxt {
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
@@ -1551,6 +1573,11 @@ typedef struct {
 	uint32_t		MmHubPadding[8];
 } WifiBandEntryTable_t;
 
+#define STR_SOC_PSTATE_POLICY "soc_pstate"
+
+struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
+					 enum pp_pm_policy p_type);
+
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_get_power_limit(void *handle,
 			uint32_t *limit,
@@ -1598,5 +1625,10 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 int smu_send_rma_reason(struct smu_context *smu);
+int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
+		      int level);
+ssize_t smu_get_pm_policy_info(struct smu_context *smu,
+			       enum pp_pm_policy p_type, char *sysbuf);
+
 #endif
 #endif
-- 
2.25.1

