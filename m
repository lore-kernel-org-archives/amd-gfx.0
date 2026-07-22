Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8528C44539
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 10:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DEE10ED4A;
	Wed, 22 Jul 2026 10:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qgZiXOSE";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2DE510ED4A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 10:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKcIQvoiBQsRa+/ia5/cQnWKLee7C8Ofag3lRobErVyRrMHz5kBiysaQ8zc+UbqHXixjA5Vv2NGxGfu/eDofz05Ws+3VFoXXD3sz+szAvSB0zx3XrUraa8lQjArG9of7wZNwDQlUGEUAxDifbyveusjOc52PNGmi4RjYWcd8nDvqbC97+BY55qLwJnCPXdd6No1YDoxxTV3qXR/Ym6AZa05AMdVAY4Z+YlRC0JFBSuoTwt5yZrU2k5XOj27xLSrosyJBWW1bacZSUhwF2eRjENnI46nYDtuGxPTtncO+zcbin3AXQd0S6U/bSN6ZMsYav9I6ZZfBO/Mn1TjCEe0/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX0TWoCkMbguTtnFNFvy1P89WJ8al8X2xJOpBoPE8SA=;
 b=LGrPCnmjgKnN8P42dO19rwVeZioU6c/xfVttrLmnyTCCalVzRIHZqrlQpsKf5+0KRdnH0pRsbCSPyLzasnuPj2AAhrXap3A8IvZ+mg4ErCTFH39QvyCMTX52Qwtlil5Q9aHQYupj0jwOCarctdMn6BzKPEo0iN28NvBUqnVqsTkNa+BAogXROPHHi9txv0g4TKRXFjnMTCyPwWVH/oGDIRLO0INbN4mtgP/07Cm0ukL14trWp9w/mTT8AQvLshgECt7Cph2Gt8t0GmN7/TrbJcSGlxhlGokqJj0wybgyWG5BuNis5Q6i2BGRiqb/wZzFZ2HNQqvKNwS8iB0BxodIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX0TWoCkMbguTtnFNFvy1P89WJ8al8X2xJOpBoPE8SA=;
 b=qgZiXOSEuyH+S7omFR7tNLd4PyV+Eeo+O6THay3aY3v5gK/0I5ir49dmsjPWtDzUfGDWMi3c0XQoTbxWUQdnc2FRRa5257c9XoBUmgeORAiWgdVYiYOy7FMbsAPUSU9CsEy20tt435va1juKfKyxUIx6AvshvhlVhUTHzLRH16E=
Received: from CYZPR20CA0008.namprd20.prod.outlook.com (2603:10b6:930:a2::14)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:36:41 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:a2:cafe::21) by CYZPR20CA0008.outlook.office365.com
 (2603:10b6:930:a2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 10:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 10:36:40 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 05:36:38 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: restore perf state after runtime resume
Date: Wed, 22 Jul 2026 18:36:19 +0800
Message-ID: <20260722103619.2737329-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: f51c7db2-9b1e-4487-a57b-08dee7dd1d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: AOTNO32lXFp+n4ql3v4OMDm+KtIJ0gDV2sKjIWGFTZjLvPRHd1esnfu/CEy4w1mYRcMdD06CWUg/VyutBlC5paE2qkbvzKXgZ1nYakbNMYYkb+7zqApWGXr5G29Z1QGvriV9e+kAWDh/AxPbP/trmh3s9KyiaxXOtH9n77L5oMWBHVvj5cFhFwe/lphGbPo58A2NZEoiD53Np2HCI66ToLgUnEgZsGXnzQKaJnxmI3OcxRJjKpaoHQnRJd87IPf+UkKUUK5zXicn65nLtNTW19KC8h7ALTw2Q98LPZhIXHlhrS0bqEJtXZBXbaQaSrHkwzpOCpBOeZDavIK0lKMmeRMrVu64Ys7uQnjeHUkqnKVuUsmNy/9tZbIRRgRrs0nrebQ6nJfC1Ypgh2vrt9IZwyUFeqlH1N6kgyqtT/cOU0ZFVFrCy0c3NkFmhp1OInarPuj7ktlzXr12CBsxvD0z2R9h1+asLqkrCf51bPGty3j/YPykqWxYDJFFbnVOUXCp2MJWXvIg19GqFuF6pRrzB0T+/apsQj1t2vVhmlsTmqV/VXs7VummN+Sjx8beObaAtY4GaAd6Gaq1CA4ylJeUm9z0fE+gccqkwgq48HvJUWt0KxzGKwFwr4UeAYol0DvoBb3Ko1Rwuzy0ZiSB/8tYaAFudrxllSdhNXVWHUFBSeBNACMZxr+OPiFSDOaf/qETjiTMdYUfUSKKrGD9kZVXgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z4Jpk3WywMC9XPMALMTNj8I6o6uU0jsyQ8ql3zIZPEr7lQeaMmZCnSRbvsGxSKQLbFHxutEnCjwY0TrcfjLMtK+L3Tz38workPBe+cznOLWllvxVvXXhiMoh4sAijenJU28pmnrkuW6qHMa6Z+UoRrm9CGt36LGYDR/NUAJEt//S6CW42L58oZMWS5Ak/ts98evo3MpTz/FVBrZCI3Uw29j0j6pEhcnwY5LgCeIOlNwP4pFwuaV7J09uBMPXDABTm5Vv2pcQzEcBIotnktDMMOG6ccwBAiPegxlR/TuwYY4COBLbFUPZVf1NJF4Z/94R4wNku2nh57oFwPdh/tTU/GV8OTHv4/xv3ZFZn3p1HzcSqG0T1n1ZLB520yTvb8BG6OfrQPx7r7Qu7RhOYTOKICjqlx6xzTlXzGAEdGDYnf1lxKLn8RPO6UuYPFrN9QUr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:36:40.0744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51c7db2-9b1e-4487-a57b-08dee7dd1d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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

Runtime suspend runs GFX hw_fini and clears perfmon clock gating while
KFD keeps running, so block perf counters read zero after resume even
though profiling remains enabled in software.

Re-apply UMD stable pstate for profile DPM modes and re-enable KFD
perfcount after a successful runtime resume.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 46 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 17 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  8 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  1 +
 6 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 121282dd30c161..38974beb98ef88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -38,6 +38,7 @@
 #include "amdgpu_reset.h"
 #if IS_ENABLED(CONFIG_HSA_AMD)
 #include "kfd_priv.h"
+#include "kfd_device_queue_manager.h"
 #endif
 
 /* Total memory size in system memory and all GPU VRAM. Used to
@@ -280,6 +281,51 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc)
 	return r;
 }
 
+void amdgpu_amdkfd_restore_profiler_after_runpm(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_HSA_AMD)
+	struct kfd_dev *kfd;
+	struct kfd_process *p;
+	struct kfd_process_device *pdd;
+	struct device_queue_manager *dqm;
+	int i;
+
+	if (!adev->kfd.dev || !adev->kfd.init_complete)
+		return;
+
+	kfd = adev->kfd.dev;
+
+	mutex_lock(&kfd->profiler_lock);
+	p = kfd->profiler_process;
+	if (!p || !kfd->profiler_perfcount_enabled) {
+		mutex_unlock(&kfd->profiler_lock);
+		return;
+	}
+	mutex_unlock(&kfd->profiler_lock);
+
+	mutex_lock(&p->mutex);
+
+	mutex_lock(&kfd->profiler_lock);
+	if (kfd->profiler_process != p || !kfd->profiler_perfcount_enabled) {
+		mutex_unlock(&kfd->profiler_lock);
+		mutex_unlock(&p->mutex);
+		return;
+	}
+	mutex_unlock(&kfd->profiler_lock);
+
+	for (i = 0; i < p->n_pdds; i++) {
+		pdd = p->pdds[i];
+		if (!pdd || !pdd->dev || pdd->dev->kfd != kfd)
+			continue;
+
+		dqm = pdd->dev->dqm;
+		if (dqm && dqm->ops.set_perfcount)
+			dqm->ops.set_perfcount(dqm, 1);
+	}
+	mutex_unlock(&p->mutex);
+#endif
+}
+
 void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev)
 {
 	if (adev->kfd.dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 338412a750edf0..1be9d5ef97d6d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -164,6 +164,7 @@ void amdgpu_amdkfd_teardown_processes(struct amdgpu_device *adev);
 
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc);
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc);
+void amdgpu_amdkfd_restore_profiler_after_runpm(struct amdgpu_device *adev);
 void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev);
 int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5362705143bc75..f7a1064c340692 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2920,6 +2920,21 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static void amdgpu_restore_perf_state_after_runpm(struct amdgpu_device *adev)
+{
+	enum amd_dpm_forced_level level;
+	uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
+		AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
+		AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
+		AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
+
+	level = amdgpu_dpm_get_performance_level(adev);
+	if (level & profile_mode_mask)
+		amdgpu_asic_update_umd_stable_pstate(adev, true);
+
+	amdgpu_amdkfd_restore_profiler_after_runpm(adev);
+}
+
 static int amdgpu_pmops_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2964,6 +2979,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
+
+	amdgpu_restore_perf_state_after_runpm(adev);
 	adev->in_runpm = false;
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 2c1a936459ac87..2a140c40b53f9c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3347,6 +3347,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 	if (op == 1) {
 		if (!kfd->profiler_process) {
 			kfd->profiler_process = p;
+			kfd->profiler_perfcount_enabled = false;
 			status = 0;
 			mutex_unlock(&kfd->profiler_lock);
 			if (ptl->hw_supported) {
@@ -3364,6 +3365,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 		}
 	} else if (op == 0 && kfd->profiler_process == p) {
 		kfd->profiler_process = NULL;
+		kfd->profiler_perfcount_enabled = false;
 		status = 0;
 		mutex_unlock(&kfd->profiler_lock);
 
@@ -3404,6 +3406,12 @@ static inline int kfd_profiler_pmc(struct kfd_process *p,
 	mutex_unlock(&p->mutex);
 
 	dqm->ops.set_perfcount(dqm, args->perfcount_enable);
+
+	mutex_lock(&pdd->dev->kfd->profiler_lock);
+	if (pdd->dev->kfd->profiler_process == p)
+		pdd->dev->kfd->profiler_perfcount_enabled = !!args->perfcount_enable;
+	mutex_unlock(&pdd->dev->kfd->profiler_lock);
+
 	return status;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 88191a4c165796..81055ada4f80b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -389,6 +389,8 @@ struct kfd_dev {
 	struct mutex profiler_lock;
 	/* Process currently holding the lock */
 	struct kfd_process *profiler_process;
+	/* Whether perfcount is enabled for profiler_process */
+	bool profiler_perfcount_enabled;
 };
 
 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index eb508fe3ded780..8b7020fc0577a2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1180,6 +1180,7 @@ static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_proce
 	if (pdd->dev->kfd->profiler_process == p) {
 		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
 		pdd->dev->kfd->profiler_process = NULL;
+		pdd->dev->kfd->profiler_perfcount_enabled = false;
 	}
 	mutex_unlock(&pdd->dev->kfd->profiler_lock);
 }
-- 
2.25.1

