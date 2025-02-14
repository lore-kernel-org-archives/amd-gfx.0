Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF4FC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 11:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E2710EC38;
	Fri, 14 Feb 2025 11:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C94uRtvM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4EA10EC38
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 11:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8REwjXlvtBfXuB6E8mhn1YVznnFRXdXcU1O/UtpQin5rkj73FphAumtkJJWaJlKlpvso0YPD9prD8PT+OYR5bvpV6Kv/8bgc+pgiBKUhLCjK//G84ROASlkhrVA/bHuvIiNGOSV60WarDM+3ZyMIm7UGcz8iU7uoS16DZwDbtcUHNns9hsOJmYEo3ewLtMU+T/94aLWkpCaHeSPyUY0h8iYVDOjJU9H9tNbXc3jdykPGkh3WssUZsmWDUTxabcRHVxu6MJLVvlMa9CT58TDQ8omipEpQVaocPefZoxCZh1Di1tF4Y6JU8VLsLClpN3LAcOaieSiOkA/iXD3KEcOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSVNCKIhgVA99J6+9OgjLnz1LQSudxoQocTzw+vPJgs=;
 b=GZo8uO+J04XTUjh479rIx9zdComlVvi/7MWljh2iguu+6ln+cz2q5zIO2dZVKhD1i9PKNRmklh7gsLdqwpMWeOxJFQrPU+CFRyLFi6Om55USotzjz15pzeb2qah/hZ3UiMJu4WL1DvCHgDnqCEAdR6vxPeH4xZarznHr0dr+IrbTOidgoAKZA4V49MCRyhjwJN5Z2YyQ9fwUByGbCDco4OF55DNYGKx2KN14bexY+t4HOIK4s2KCMw2l7svDxbIzR45aitWbn4udyJ+mjxMgQ4Bsu1ZGdWnmz/AKGv84ZN4OK94AvevaPVEu1r9E9DH+BEDNG/PC9GWbjoeJcHHMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSVNCKIhgVA99J6+9OgjLnz1LQSudxoQocTzw+vPJgs=;
 b=C94uRtvMmYy2+TE0OYal/7cwlTAkGueMUT1e/Qh4M6TUFGAWuFN6rTbEmJuhFe3yg8Y3eZMB23R3FmXp1ZJ5jKp9qDUtskGTluibGUk0S8FgLWY5mWingtupFsUUS1jJnYLGTJG/NlIut8sWW62AOrCbcdFGIuO0e1sq4KQLwA4=
Received: from CH0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:610:cc::21)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 11:15:34 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::a5) by CH0PR03CA0076.outlook.office365.com
 (2603:10b6:610:cc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 11:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 11:15:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 05:15:33 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 14 Feb 2025 05:15:32 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: extend the gfxoff delay for compute workload
Date: Fri, 14 Feb 2025 19:15:28 +0800
Message-ID: <20250214111528.361280-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 715f3853-8c1f-4ab9-d805-08dd4ce8e6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YIwH90VTSxWpOw7E2rFTUn8g0Y+cbFCib3XGiBeRcjhZQWnTkMliPgKpmD+m?=
 =?us-ascii?Q?S2Ls0VjlrdHUk+beh6Siq7QET+/KcGBJYRB3c0Js2dOg13mNFWHU8yDt9eF7?=
 =?us-ascii?Q?Di8XdrzQwYOlT5sDkln2OIFWYDFRcU+aVyMCTkunA7Fur03xiB41tc3X3/Fs?=
 =?us-ascii?Q?+3N7xJY2tB9D4ThmXnun+gWu6BAO4sZAXaYR6QSCIVXVVhyInI8Nd+kDPGW5?=
 =?us-ascii?Q?5tX0XuLs12My4bEEDElApRTNcuAzYN442dS6SHU6YanlFr0mEiRdcSCHWIA6?=
 =?us-ascii?Q?oV6ndUa6p7YoAFxuRyzcFWD6nZymKAbHJcfXsxm5nCN9WKXYHEhwvW27/KXZ?=
 =?us-ascii?Q?mTlJH9F5FdpwOamiAoH00EEUGwZGwmXejuA8P+5nuQZEPtn9HQNflTjpzx5j?=
 =?us-ascii?Q?u2RaYPNAS2FCHbwdBcd4HMvBu+DNEdoMX60KrtYO+qyHhwpNWOdOkk+CPZxK?=
 =?us-ascii?Q?J6OMa1iEkzPIqszTs8y95vEEqq2YQQ9vGMaZMEDrXBI71+eMWh9Z4BwC7II3?=
 =?us-ascii?Q?RRWAIiDhmNjKwwKOOiBuR9vT6gEpFnRUOW4UnEHiBUg8v5PTW/02vWjniKGc?=
 =?us-ascii?Q?t+O55U2hefLD1GH1VBEXcIL8n83uWwFqVMFhaa/LxFpW7TNWb0I9E3WYGYjG?=
 =?us-ascii?Q?A9yUqYTsyDOKXSf3ZM5zsg9PaPBevYUDrnWzyEJR0DSsvgu+pCUa7VWjnX03?=
 =?us-ascii?Q?V3Op82BKIMyT5eRQgJKrE0IS2ezSgckM7Vez5/W1aTmBq/1HY9puGNLVReDq?=
 =?us-ascii?Q?URfWOeUr+D4+Avoj5NNKGECGoIl+AHJln78yp0EAQyQ3fECANMR8S6RBGEfJ?=
 =?us-ascii?Q?IUW/jqt1poOwqVrIPypvWOz3OjYuQHC/Ey9xGWf4eXK3Aah2kAf5hOkGDSqc?=
 =?us-ascii?Q?FFEGt0ULBU4xflOM0Z1M8V/6yiq5nI8keQqZpx850TU6n1RNFbf1rZiAzKoD?=
 =?us-ascii?Q?cWbtPHGiQAIXsNVjVSj54XiDOwZFKTlVrFGEJqR8OPqR6fTqCBbtZCpEwP8n?=
 =?us-ascii?Q?Be0HnBredQUTXKVdSJ1unSvbSUxtWAklXh/4KEQiVb9MuSrxMBSLXOAxtGoK?=
 =?us-ascii?Q?3X5Xx5MpgLpZCECd9EbO0NU9O9W/5xdD43g67bTN+BeGh/NjDbA+6yIZdpQc?=
 =?us-ascii?Q?nh/dQ1wTORLXImUP7EtDIWlAW2IbgidlD06fc4+ZtYRVh1zwQI8bFFuyYO64?=
 =?us-ascii?Q?+Rt+EAtUe8z9rtWd37gZ7MAkNS68d11au7gguivELdWo8D2rUDfqWslF2Eie?=
 =?us-ascii?Q?CgI0bCTJ5dSp52LB6WPpBdfn4Br7K2fFV8RnpvkVFvp2h95sPpoE01DJ31qP?=
 =?us-ascii?Q?8lNR4YeARLw/E5yzUQ8exSkbhCbzFGUglHGXj/Y7r9tqPpo6vu2J4gq6In9j?=
 =?us-ascii?Q?gP2AaIa99SlrcBj+CjpcEgECcAUfKzfoyNDx5Ae7jVuF/ZjlfsKP8/brvYWA?=
 =?us-ascii?Q?RUERzDOC4+txpDZZ3Y3Ph0yJEyiMPaONtki8lVg5Rd+zkp1/MKlloQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:15:34.3062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 715f3853-8c1f-4ab9-d805-08dd4ce8e6c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
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

extend the gfxoff delay for compute workload on smu 14.0.2/3
to fix the kfd test issue.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  3 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 14 ++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 5 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b9bd6654f317..4ae6fde6c69c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -776,6 +776,9 @@ static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
 {
 	unsigned long delay = GFX_OFF_DELAY_ENABLE;
 
+	if (amdgpu_dpm_need_extra_gfxoff_delay(adev))
+		delay *= 5;
+
 	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 		return;
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 7a22aef6e59c..87de50b73a0e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -873,6 +873,20 @@ int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
 	return ret;
 }
 
+bool amdgpu_dpm_need_extra_gfxoff_delay(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	bool ret = false;
+
+	if (is_support_sw_smu(adev)) {
+		mutex_lock(&adev->pm.mutex);
+		ret = smu_need_extra_gfxoff_delay(smu);
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return ret;
+}
+
 uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 1f5ac7e0230d..312ad348ce82 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -470,6 +470,7 @@ int amdgpu_dpm_get_residency_gfxoff(struct amdgpu_device *adev, u32 *value);
 int amdgpu_dpm_set_residency_gfxoff(struct amdgpu_device *adev, bool value);
 int amdgpu_dpm_get_entrycount_gfxoff(struct amdgpu_device *adev, u64 *value);
 int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
+bool amdgpu_dpm_need_extra_gfxoff_delay(struct amdgpu_device *adev);
 uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev);
 void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
 				 enum gfx_change_state state);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a1164912f674..61cd170ec30a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -133,6 +133,21 @@ int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value)
 	return 0;
 }
 
+bool smu_need_extra_gfxoff_delay(struct smu_context *smu)
+{
+	bool ret = false;
+
+	if (!smu->pm_enabled)
+		return false;
+
+	if (((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 2)) ||
+	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 3))) &&
+		 smu->workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
+		return true;
+
+	return ret;
+}
+
 int smu_set_soft_freq_range(struct smu_context *smu,
 			    enum smu_clk_type clk_type,
 			    uint32_t min,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3630593bce61..82f06c2a752d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1626,6 +1626,8 @@ int smu_set_residency_gfxoff(struct smu_context *smu, bool value);
 
 int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value);
 
+bool smu_need_extra_gfxoff_delay(struct smu_context *smu);
+
 int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable);
 
 int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
-- 
2.34.1

