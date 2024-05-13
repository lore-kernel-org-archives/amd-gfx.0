Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88A3C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3869210E5AF;
	Mon, 13 May 2024 09:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p6jZGnNH";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C5110E55B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COUYrcyc+l8/ENBBh7O444ywEpt32GIu6t5HJd5E4Q2V6HgnBBtgduxUAA6wQed2qiJQ4+P9IGNT2LJl2S0ni4695lXEqy8T+50z7TTyYx4tRrc6V3AJCYaPbtwhmgH+lPRdTyZIrxURxc8bKvuvvHzgOmpdFWjl+gq5l9prj19AYQlaasB2cp4iN5go8annIOcy4rKzcXMzBeaFuMZhs3D811Gill+vw6F37E/EZmvhMDRrS943kqh011Wa/gXh5h9k34gBYWnNgQRSMJvzIzZVTV1Bv7D7PEDeUr4gT+odAKudxEszvljjhouXPpAbIiQnHws/BLwi9ZM+3/uc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlV/OPPba2ds2RTJrV8p3yiOGoNCGrJSTc0Wfg4NOp4=;
 b=P6xKs4VgzCGlT6vlYu3pIrrQJFDoipcrm9ZlovpoclgAweM0eW7E8SgvNFdEusmoDeWzgsaP1gjLs285G+Vmib8CbfR0CSV//ITfYJ3Nq1504QGAraxSjHSjHrR5K5Dk65R9PevUDhPfY85LxEB6Ve+ljYFanLMzfPW/wplDFqfXOi1pEygXtua4gHJ1iNWVBftC9KtV2/W69U8ks2SUPuv4/WmSS68DOkD9jZTtSHeINg8lhDd8pvdbTgxAyDpf+jODY3i7YNIIijT8OhtwoeLTHVm6lKXHMnvs0V8YZaTn/7nrFkTQhxgRvEoyalMkuNg9oMq6U4X9G9rTxGH1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlV/OPPba2ds2RTJrV8p3yiOGoNCGrJSTc0Wfg4NOp4=;
 b=p6jZGnNHI6ZXJ6saHnPB4YneZaf93A1JjdDcVh+DV+dBp4QSTd6eVhYB1vUj8NIxo/Jk+fi8DImM0YcmIrbaO1krTDEEOFtFS3yQD2dSRK9RCvT9WZgrC+hvxfMLZGAhJsWeM9Lf5IjiodQeufLLy3K0hRQOG4glAkkT+4Fot+Y=
Received: from DM6PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:100::29)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 13 May
 2024 09:21:30 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::1e) by DM6PR03CA0052.outlook.office365.com
 (2603:10b6:5:100::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 09:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:27 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 01/10] drm/amd/pm: Add support for DPM policies
Date: Mon, 13 May 2024 14:51:02 +0530
Message-ID: <20240513092111.341168-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf220ef-c780-4e9e-0ca4-08dc732e12f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OqD4YQ7YYw83XSoNurTukA9PiGDbjkJ8hqZLxW3M3ZNk5Yehg2GzW6Pomb32?=
 =?us-ascii?Q?lLOCB8vEGzIN2tWnwKFt5HZmTKsyGf7mTHBJS1w9uhe1bOdC308HZcgi0s8c?=
 =?us-ascii?Q?urMhjqXd0KrGp76AzGKlVMyywB2iki0Xfevm+polye29xHVJ+rK/wMr0iape?=
 =?us-ascii?Q?/BnAFZ8VbjWwPys51RUzXr1MfU96/jQ+ThcJGWzA3S9RMq+Qj9degi3C/e8E?=
 =?us-ascii?Q?mV1J1kAwyVJZj8Z+sl5i9Q1JoJBoy2eyP2BKiFQJDZrlxy9tYg488VNUycYQ?=
 =?us-ascii?Q?cDLdSrtM7PWBoyxAwyQleTmuFnLEri46IS+HIrpVL0gSoT9BsK3t86+R7zOv?=
 =?us-ascii?Q?G0KV1CmT0+c1Syr783kvV55jlQcw45LVppz6ynPqUhCxZuO6HUxnOvv+6uo9?=
 =?us-ascii?Q?0l+p42fKaY6wtu6OUuQ11TeKUINS3OcJiv2X6rxrp4vjiMZ4poQd7duGYV1N?=
 =?us-ascii?Q?/6kVxSZ2PSUPxjWSyYNUqp9Yz0CYPrlLgXvfehHpPs2yQey0VPECzl3MNzGi?=
 =?us-ascii?Q?aXhzENigOfLxDM89fPU0yl5AjFHgg7AiHEFbjoDGgE0Fj9yyUZaetg8GteKo?=
 =?us-ascii?Q?f+pwBrAIApMFbsO8+lEJMCz4tJ4cjTYcZsSmY4i7rXhrhNhbWHjG3c8de3ID?=
 =?us-ascii?Q?AYj2pGVEa5OIeMMBmyqclmrXQbht2UB6rZ0E3tENrgo32K2mf3Yjs/IOA1Xl?=
 =?us-ascii?Q?Jgjw3tiih0HTpBHU4lCkNBSMJXfGRIQkz0AUTKsYop60xHqq9fvLS768rRwd?=
 =?us-ascii?Q?cup+cJ7VRph9gxt2KaA6i7DdXn+S17NigUDk3gq6iafLAFOmC8Ivw9in8nfO?=
 =?us-ascii?Q?apqu9u0rKj85Oc8Cw2+CuYCw20Byupo7RQLjC6dqnZahzRaCrD+RlJq1HNQJ?=
 =?us-ascii?Q?9jgRvBFscvWwYgfQio9Ri+tR9kzKqTcBU9bpuilfJKJ2GJPayf64fNVYNZUE?=
 =?us-ascii?Q?5HbeDbTjN2z5ElvE0DjgrIaUbYaREjL6BOXKoP1LFcWLImn8pZf10SzK1n1d?=
 =?us-ascii?Q?GyzxqWKx+8T1Ue+vGwH6tjhCit/u+XH2Gb4w8jXh35khQkDlmWKiXAs+QnOr?=
 =?us-ascii?Q?3Qrv6ybo1SQWHfUyX/sebkjrV7RNPCiu+12zMw6XvA2m0+ENXhvaQyXO82uf?=
 =?us-ascii?Q?5Ds0bNUuWjSarYtFTiQRha1v4CNY103CkRuUWBPnlr3BABsmni1pU0pSejBw?=
 =?us-ascii?Q?73ddsqGW2jHrtRK1bjBRc/GGfUImWBHquOSQxzWUL6wCrK6XDv2GN2N4VNZy?=
 =?us-ascii?Q?2LESSLVyCKPKz1deyRT+xV5EQ0eKOqHwpjQ0UdGqQYw0K6s7BopxqlVin+ty?=
 =?us-ascii?Q?2fnbevc9j1SSYrA5e7nmez5TgvNSNIhIa4cfKnTfjgs4l5efczHBMFWDfkeM?=
 =?us-ascii?Q?+iH2PBHmRRV+zOzNEB3lyUKbrx7F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:30.2725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf220ef-c780-4e9e-0ca4-08dc732e12f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
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
 
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 29 ++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 92 +++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 98 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 29 ++++++
 7 files changed, 269 insertions(+)

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
index 110f2fc31754..d62f1d1d6c84 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2278,6 +2278,96 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
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
@@ -2326,6 +2416,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
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
index 0917dec8efe3..035ed8844401 100644
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
@@ -1551,6 +1573,9 @@ typedef struct {
 	uint32_t		MmHubPadding[8];
 } WifiBandEntryTable_t;
 
+struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
+					 enum pp_pm_policy p_type);
+
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_get_power_limit(void *handle,
 			uint32_t *limit,
@@ -1598,5 +1623,9 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
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

