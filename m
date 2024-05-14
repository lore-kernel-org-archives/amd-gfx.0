Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748E1C25B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E457F10E5BD;
	Tue, 14 May 2024 11:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YJE8c7ua";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56EE10E599
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwZ8NUwu3AXFRzJVIIVxBCaNkAh+1XyBK7xRdfnOAO2i6QAFhNVyAdv/REYQ0YgFxKuIjPcU/xZlS97igR9inJMnSZgQL8X0HaZNCi3QGKtpzzBzHec+w2CmDOh4Zaa5UXJ742zUZYF3Pe/PGpYeK/Ht42tPfha/rPdjQYN7NAepHM3G2aqSZ0SBmyI/4p8grlq1maDPta4kv13PAXR6EqgjkSEjPRgQzVAJtPhSTyLBHW2ljuYFaIl13wrLRQ0UDo1HUV8UGhscFUC5+/zwDCn+Bnl8zMjW8+SorsQzHvPmw0j+nuHRJPUdvN8b1BTC6silKPmf9Qt+jnFBkSOwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SAUJmXuLIDR8xtYb4NL7CKqpkgdIEt5CkUhd8BlYJ8=;
 b=FHnqoPSxdrolCpEwncDzmhivtckATZ+XL+NR9NhmUwuEciUJ8VGnIHu4t3Z7ryswCFGFT8a6UT+sJiTU4GsVNFtkgWAumXm/Bx7tE45wGo04wZeCscBBZqF60FzhM4DJo17WPMJf7yG+i4reGka6oGBhuwvfKhNRM1ZhFMgG2t4IaYDghuO9T2kAfj3E5LMDkxV6cbPGIpkCvLhI/lFtjrxQr7+6YpQ+5jUaEv/bFUinU6vs2k0guLJaSaI/26mckO8stLCKf+JQoEWjtmLjl4ydqC9rVVv9YLCTIx0fzBxbLXS0Zi2a2qe8tw2tHaFbl24h2mJzK87aFIsoHbH5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SAUJmXuLIDR8xtYb4NL7CKqpkgdIEt5CkUhd8BlYJ8=;
 b=YJE8c7uaat0S8BtIQe6QeF5sjwZIPz+uotYtGdm/ilYgaIlTjU+Zao5R8XtaybYwG8hxUkRrT+I9BnRv0fd7kmCuhhzen3DIZSMCaANlcvTvNbwpRmhGw11bnqPn/hPOdrdce+FN4yVpSns77JHdCKrT7YB+NKcwrvHZ0ZVWLZ4=
Received: from CH2PR14CA0053.namprd14.prod.outlook.com (2603:10b6:610:56::33)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 11:06:25 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::71) by CH2PR14CA0053.outlook.office365.com
 (2603:10b6:610:56::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 11:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:23 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 01/10] drm/amd/pm: Add support for DPM policies
Date: Tue, 14 May 2024 16:35:57 +0530
Message-ID: <20240514110606.396234-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 613d07eb-5b61-4e0c-20f1-08dc7405e5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zn+tpWj1A2ki8aV8PxVxCURoWdsDaNyCPVVF+PFa6WXZfUBhi1Jw9tpRyl01?=
 =?us-ascii?Q?d3V/AaNjHFdOm2I5+qlhkOrGnt2OmNZGApRbnB0ULqtT+80m6SMDnvJyHlpN?=
 =?us-ascii?Q?S6D7QOKAmLiEIxGj5OxB7c3epg5aPNtx/1IJZM4v7rLewlvxy+RlEBDsFBAv?=
 =?us-ascii?Q?KR8VtoH5aoZeUKLlUbzt6QJRdGgCve6qovv0tUILJvmx7JPMTcfRJDGCwpTi?=
 =?us-ascii?Q?XRlsm4dcb31dLOQlRjXx63mkcH19D7VVoDC5EenbnZBVX49+gkflgTek05Da?=
 =?us-ascii?Q?aTFKox2Yir0UXN9C3SYc4qiLwQALRyZbZxSZy29u7iYnDICsmVBx5fKwcb8g?=
 =?us-ascii?Q?2W8WrL+maTmf+YghhERni+NfhHHFWKtwpZdWTh5dMTW91yYqX2Fro7am3G8y?=
 =?us-ascii?Q?/62suBdWPtJHVRMbwkyZ0YOlVkGD6QIfl7TWhbq5aLqabD5TcSXqLrW+avIV?=
 =?us-ascii?Q?aEjVUacS1t7sKiiXRgXGrpDnLmei/VAimdgIan5DgIN5pybViyTkruXb+Lra?=
 =?us-ascii?Q?BGqrac+/YUI6dWyd875d3yfPVaa3vPbm6CjZJHJvWMCbnfj5BF2FqPFt4LbH?=
 =?us-ascii?Q?U1qexzhpakKYjRX8FP6OKbTjfFH4VRbDyAcaZjPVeJV8hqtYbSBwWqv0sDQU?=
 =?us-ascii?Q?rTzIlH3ML1DLAgQr/UMYxbohLD3+p8J8oT080p5NTyun7qLokQjFcsTfM1W3?=
 =?us-ascii?Q?2CZGBMiArDuPaOYp3YOFuMOg/UOmHZksopv7PzGlKHejhvJHOuj2fLMXYR7E?=
 =?us-ascii?Q?t7TsLrvxZ/QHpKfKwDTkv7DFGS4KCZ9AdDRJXTBHGP/gUfTKb2klZESKNTlq?=
 =?us-ascii?Q?U9KzrAqu3AUIH329quZkUZBKEuSax8YKWXid2O+VSTwiaeINerZUa0T7n1Ua?=
 =?us-ascii?Q?ucf0kjl1Mn3pc2zrAUobXu60+6LODxIQCPc9cv8olUj2wihNJ2TptfTV+Mf3?=
 =?us-ascii?Q?RGrWYaaZGJzmmfsMQ7EmF4i/MRHWc8/jcTV3kVlKqs57JPzmV3vP2AxLQ10q?=
 =?us-ascii?Q?olMVU6ns+ApiuJvhjHl0SxzMkexU38tpUR8zWr6UuNo3Yi4gDh/m6LnAI81e?=
 =?us-ascii?Q?iyxBWISh4qjcExFIbYAvJLw2HWfGDfOKyjwR+akDAu8pS5aYXjd9j0FEttFR?=
 =?us-ascii?Q?Yk4fTjqGLs325ksAJVgWW3BMGHBAzCf1pQLRK25nijfG7wCkgId1gr6ZdIkD?=
 =?us-ascii?Q?07S22P9C4Hul2aEyVMY9IudBA3UXXVYeIoobVBh1Y8SkfvqH1DWVhLaBFdJo?=
 =?us-ascii?Q?eG8Wa1y4xl83FWjFxQ+7tuyv/NNmtzHOxX7MSGxhM0buGffuWXYYQAI+z7cd?=
 =?us-ascii?Q?D33EdHfrJ5s4tZHF7GyNTmJlCNk1D7gnoVCrCjDTVJqZQOYQOkOYImYpl+/3?=
 =?us-ascii?Q?pmOZUJbHMjMAZ/M0ebgEvKNsy1rA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:25.5439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 613d07eb-5b61-4e0c-20f1-08dc7405e5ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
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
v3: Rebase to add device_attr_id__pm_policy
v4: Use macro to define policy type for consistency.

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 29 ++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 94 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 98 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 31 ++++++
 7 files changed, 273 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 805c9d37a2b4..8ed9aa9a990d 100644
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
index eee919577b44..b443906484e7 100644
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
index 110f2fc31754..6dab0b085239 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2278,6 +2278,98 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
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
+#define STR_SOC_PSTATE_POLICY "soc_pstate"
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
+	if (strncmp(tmp, STR_SOC_PSTATE_POLICY, strlen(STR_SOC_PSTATE_POLICY)) == 0) {
+		policy_type = PP_PM_POLICY_SOC_PSTATE;
+		tmp += strlen(STR_SOC_PSTATE_POLICY);
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
@@ -2326,6 +2418,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
 			      .attr_update = ss_bias_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pm_policy,				ATTR_FLAG_BASIC,
+			      .attr_update = amdgpu_pm_policy_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(pm_metrics,				ATTR_FLAG_BASIC,
 			      .attr_update = amdgpu_pm_metrics_attr_update),
 };
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 501f8c726e8d..1455db9c3789 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -598,4 +598,8 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 						  unsigned int *num_states);
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 				   struct dpm_clocks *clock_table);
+int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
+			     int policy_level);
+ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char *buf);
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index 448ba3a14584..6ec9fca045e0 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -79,6 +79,7 @@ enum amdgpu_device_attr_id {
 	device_attr_id__smartshift_bias,
 	device_attr_id__xgmi_plpd_policy,
 	device_attr_id__pm_metrics,
+	device_attr_id__pm_policy,
 	device_attr_id__count,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e61aa4418d44..df9ff377ebfd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3498,6 +3498,104 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
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
+	if (!policy_ctxt)
+		return NULL;
+
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
index 0917dec8efe3..ee5b9701038c 100644
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
@@ -1598,5 +1625,9 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
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

