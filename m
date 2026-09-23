Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F197C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934CD10E15D;
	Wed, 23 Sep 2026 19:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cy4WlYHq";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B43210E15D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awHw91W192F9IuIq0kRULtH3kXTn3keR6ZpqARIg/tXSCKuJngJp14E5bHV55lBDl5jM5UtHlT+RmMOYz3nZ6QJc95hBtomYGQnx5jrx05LjCE0H8wHUuujVc+PbURJvGua6EeH83sGpyiPNqwNdtIcmP2pf9iLNLWfzJOTFTAbri1MRT+b+3UYuILIil7P21TIVP3mQ2q7R3oFez9UjvXe6EHukmGjv8A7DlYmYuy0nw/M+rcd7hmjZb4lraioQjS+++Yufj3eS0R7keSZ08/fLuZhlCGqcpXAbP+3dXdajH2fWs3zOGYjW0OZD+nNxvRIdnG+apJIQt7KnDAVcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDAd9pt+NpEel3Jrk2902BVn9Ee6PwdvSod1NrW4nDo=;
 b=Z6Cpr5vcs81j2KVEEm+r/yDvoWMaF0ZX3tvOrFhsDrbefomexshulgVHgyOmKXyEfARscTgLxoOTQLvYuytN+fmug49VdLQCGeo4wpv56f4bXZ4Ioi7dJplE0USCKTNnYBVm2WSfmNhseIGNds6QnVTdqWTz89o1U6fnZRFPugkgzPzw3VN/IidK8mBK/nT7kuBOb+QFLRyBuRRblTj9TApINuDJlAaFWAo2/ExhEOfE3wN0NdQBMqcjrQQwb1ghp6ZE4Z55vuCujCOVeoR/J/9z6qj2d4QgOr/s9uRMawq5spdvZJ4cqYSwVJi0s0XFYviVyGcISx3FNmDMf7QuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDAd9pt+NpEel3Jrk2902BVn9Ee6PwdvSod1NrW4nDo=;
 b=Cy4WlYHqCXB/8womz+5Ca0Q+wo/JTVXxP2rpuZD+aU31zNPNKaPBdIS4Q/JDjHEyI8UTrMDkXqgcFDF0ir4ob32NvyJQEKwJkJzbYhJZimr/zIuexQfPotsWeqhNU9J77hBe+tWZIZSEvOIIsOG0rVINAssKrskbju8wMr9pe8U=
Received: from SJ0PR05CA0183.namprd05.prod.outlook.com (2603:10b6:a03:330::8)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 19:15:49 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::1a) by SJ0PR05CA0183.outlook.office365.com
 (2603:10b6:a03:330::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 23
 Sep 2026 19:15:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:15:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:15:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:15:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 14:15:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: use new reset-affected accessors for userspace
 interfaces
Date: Wed, 23 Sep 2026 15:15:39 -0400
Message-ID: <20260923191539.191909-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab7cbae-92f7-4d4c-a666-08df19a713d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: jpV8shqDXHO4p9qlP0JMcrPbOkk8CCfBJTdWifF0TgnInet7kBiQfLATAnuYKuXHvopi/jQHdqA9AMTwbnRJzkp3hpOPGCpuEjUglsD611dYPlbo43/BfQV2WhPQFXgEPyMU7Au7BI1jVWaQEIL+QRaRK5qjCBxUJpjLOSKUpBlt78xaw+d1BfWV7v8xpK3mz3/iCqd50x9zHQtHztq/7iVjOBmr78i80HqXtR2xavZtD1VA/JoHzj19WZ89wvWftx8HoI+9tZzRong8v3D1NZ6H/jkL+h469iQAYzIBwH0cBxMNrcbfUjXO3OxcKfn0v3txI6Nl272Migur5jNiauqdzH7EfRxregF8d5+jf19xpCt/VmqTBKKQRo9qPZ18EjirQclCfopcLy6Q0EzOufjkfJQwlaDVWjHWmUxS7TzELhsGssRqCAcUVeRmIsqee6vjDmnKeMgYXoQxO+Zarb6WN0ePPhCeJbEGXalkjVIzH/JGigRUQrzxQx0V3MnOa0gp0NUbwY6ftOM71bVhywyrdc1KRfr1f3cAkRmoRz4T0FshKaZy0acqub1F89qpZDbsnDzACNOtKx3e8y5B3/IDoLQBUsMeket81cBc6i3Lk3fDwGbQCJAD3eZpbRxFeIQkWhyJn/PR8O3/OUFiLRupQcAzcmcWxXkcKGGu85Z7meytBX9oqXSOo+2h748hZlHGbhApA3y5cqsCWfBKgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QpnZ905+recBsh8VNPXQseHXGLLYY74gvx9qrz2PdpGJ3Lr/E2fU8jNXd1x28pYLfBTs3kbjGyRrVUaHDshG2cUbE1uUoos61rSnY63W3pWKcWFIjLrnVkaL45Qh5UkTSKOoUBImmMk2a3Y9uqoC3hZbzcbDA5WAXoEOcqp4DPYut01yT+wExPHqbmkIBc6Ogj64aWo3pnzwVTr/U/5COnzO8cCaUP+rlGLZmFWGdgwmnAlvqlnQri6BLeTdG32Kyoz9NO4rM7saeOw75+Brai/BDtXzy6wYgdV2WtTN8RROJ8nXlkDneiv6N9yscZasogvQ4Zln9z7YB4zJaHoVJEYzpcom0vaiMb50dZaXq8kcoAwoceypmGYrR8bYyUxYzWb+7BA7fbYkIjgmpV5QRFSP2sfvgOyta2cjpB+ZZbjMmFoX4ChcJ9TmdtoVomMm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:15:49.1612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab7cbae-92f7-4d4c-a666-08df19a713d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

Use the new reset critical section accessors for debugfs, sysfs,
and the INFO IOCTL to provide proper mutual exclusivity
to hardware with respect the GPU resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |   4 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c         | 212 ++++++++++++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c          |   3 +-
 4 files changed, 221 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1b7673d239dbb..ba1f224fb99aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1780,7 +1780,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	r = down_write_killable(&adev->reset_domain->sem);
+	r = amdgpu_reset_domain_access_write_start(adev);
 	if (r) {
 		pm_runtime_put_autosuspend(dev->dev);
 		return r;
@@ -1811,7 +1811,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 		drm_sched_wqueue_start(&ring->sched);
 	}
 
-	up_write(&adev->reset_domain->sem);
+	amdgpu_reset_domain_access_write_end(adev);
 
 	pm_runtime_put_autosuspend(dev->dev);
 
@@ -2043,7 +2043,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		return -ENOMEM;
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	r = down_read_killable(&adev->reset_domain->sem);
+	r = amdgpu_reset_domain_access_read_start(adev);
 	if (r)
 		goto pro_end;
 
@@ -2084,7 +2084,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	/* restart the scheduler */
 	drm_sched_wqueue_start(&ring->sched);
 
-	up_read(&adev->reset_domain->sem);
+	amdgpu_reset_domain_access_read_end(adev);
 
 pro_end:
 	kfree(fences);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f2f179421c4da..a4ed540409ba7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -776,7 +776,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_TIMESTAMP:
+		ret = amdgpu_reset_domain_access_read_start(adev);
+		if (ret)
+			return -EFAULT;
 		ui64 = amdgpu_gfx_get_gpu_clock_counter(adev);
+		amdgpu_reset_domain_access_read_end(adev);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_FW_VERSION: {
 		struct drm_amdgpu_info_firmware fw_info;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index df5bbdab1ea39..88f6afc9c72fa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -31,6 +31,7 @@
 #include "amdgpu_display.h"
 #include "hwmgr.h"
 #include <linux/power_supply.h>
+#include "amdgpu_reset.h"
 #include "amdgpu_smu.h"
 
 #define amdgpu_dpm_notify_ac_dc(adev) \
@@ -46,10 +47,14 @@ int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 	if (!pp_funcs->get_sclk)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return 0;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_sclk((adev)->powerplay.pp_handle,
 				 low);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -62,10 +67,14 @@ int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
 	if (!pp_funcs->get_mclk)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return 0;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_mclk((adev)->powerplay.pp_handle,
 				 low);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -523,12 +532,16 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
 		return -EINVAL;
 
 	if (pp_funcs && pp_funcs->read_sensor) {
+		ret = amdgpu_reset_domain_access_read_start(adev);
+		if (ret)
+			return ret;
 		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->read_sensor(adev->powerplay.pp_handle,
 					    sensor,
 					    data,
 					    size);
 		mutex_unlock(&adev->pm.mutex);
+		amdgpu_reset_domain_access_read_end(adev);
 	}
 
 	return ret;
@@ -1021,7 +1034,10 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
 		goto out;
 	}
 
+	if (amdgpu_reset_domain_access_read_start(adev))
+		goto out;
 	*state = pp_funcs->get_current_power_state(adev->powerplay.pp_handle);
+	amdgpu_reset_domain_access_read_end(adev);
 	if (*state < POWER_STATE_TYPE_DEFAULT ||
 	    *state > POWER_STATE_TYPE_INTERNAL_3DPERF)
 		*state = adev->pm.dpm.user_state;
@@ -1054,12 +1070,15 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
 	if (!pp_funcs)
 		return AMD_DPM_FORCED_LEVEL_AUTO;
 
+	if (amdgpu_reset_domain_access_read_start(adev))
+		return AMD_DPM_FORCED_LEVEL_AUTO;
 	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->get_performance_level)
 		level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
 	else
 		level = adev->pm.dpm.forced_level;
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return level;
 }
@@ -1091,6 +1110,7 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
 					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
 					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
+	int ret;
 
 	if (!pp_funcs || !pp_funcs->force_performance_level)
 		return 0;
@@ -1108,15 +1128,23 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 
 	if (adev->asic_type == CHIP_RAVEN) {
 		if (!(adev->apu_flags & AMD_APU_IS_RAVEN2)) {
+			ret = amdgpu_reset_domain_access_read_start(adev);
+			if (ret)
+				return ret;
 			if (current_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
 			    level == AMD_DPM_FORCED_LEVEL_MANUAL)
 				amdgpu_gfx_off_ctrl(adev, false);
 			else if (current_level == AMD_DPM_FORCED_LEVEL_MANUAL &&
 				 level != AMD_DPM_FORCED_LEVEL_MANUAL)
 				amdgpu_gfx_off_ctrl(adev, true);
+			amdgpu_reset_domain_access_read_end(adev);
 		}
 	}
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
+
 	if (!(current_level & profile_mode_mask) && (level & profile_mode_mask))
 		amdgpu_dpm_enter_umd_state(adev);
 	else if ((current_level & profile_mode_mask) &&
@@ -1142,6 +1170,7 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 	adev->pm.dpm.forced_level = level;
 
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return 0;
 }
@@ -1155,10 +1184,14 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
 	if (!pp_funcs->get_pp_num_states)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_pp_num_states(adev->powerplay.pp_handle,
 					  states);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1173,11 +1206,15 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 	if (!pp_funcs->dispatch_tasks)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->dispatch_tasks(adev->powerplay.pp_handle,
 				       task_id,
 				       user_state);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1203,6 +1240,9 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
 	    !pp_funcs->get_pp_table)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
 				     &pptable);
@@ -1213,6 +1253,7 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
 		memcpy(table, pptable, ret);
 	}
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1228,12 +1269,16 @@ int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
 	if (!pp_funcs->set_fine_grain_clk_vol)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_fine_grain_clk_vol(adev->powerplay.pp_handle,
 					       type,
 					       input,
 					       size);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1249,12 +1294,16 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
 	if (!pp_funcs->odn_edit_dpm_table)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->odn_edit_dpm_table(adev->powerplay.pp_handle,
 					   type,
 					   input,
 					   size);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1270,12 +1319,16 @@ int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
 	if (!pp_funcs->emit_clock_levels)
 		return -ENOENT;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
 					   type,
 					   buf,
 					   offset);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1289,10 +1342,14 @@ int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
 	if (!pp_funcs->set_ppfeature_status)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_ppfeature_status(adev->powerplay.pp_handle,
 					     ppfeature_masks);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1305,10 +1362,14 @@ int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char *buf)
 	if (!pp_funcs->get_ppfeature_status)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_ppfeature_status(adev->powerplay.pp_handle,
 					     buf);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1323,11 +1384,15 @@ int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
 	if (!pp_funcs->force_clock_level)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->force_clock_level(adev->powerplay.pp_handle,
 					  type,
 					  mask);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1340,9 +1405,13 @@ int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
 	if (!pp_funcs->get_sclk_od)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1350,14 +1419,19 @@ int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
 int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret;
 
 	if (is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->set_sclk_od)
 		pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	if (amdgpu_dpm_dispatch_task(adev,
 				     AMD_PP_TASK_READJUST_POWER_STATE,
@@ -1377,9 +1451,13 @@ int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
 	if (!pp_funcs->get_mclk_od)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1387,14 +1465,19 @@ int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
 int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret;
 
 	if (is_support_sw_smu(adev))
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->set_mclk_od)
 		pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	if (amdgpu_dpm_dispatch_task(adev,
 				     AMD_PP_TASK_READJUST_POWER_STATE,
@@ -1415,10 +1498,14 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 	if (!pp_funcs->get_power_profile_mode)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_power_profile_mode(adev->powerplay.pp_handle,
 					       buf);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1432,11 +1519,15 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 	if (!pp_funcs->set_power_profile_mode)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_power_profile_mode(adev->powerplay.pp_handle,
 					       input,
 					       size);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1451,6 +1542,9 @@ ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void *buf,
 	if (!pp_funcs->get_gpu_metrics)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
 					&table);
@@ -1459,6 +1553,7 @@ ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void *buf,
 		memcpy(buf, table, ret);
 	}
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1472,10 +1567,14 @@ ssize_t amdgpu_dpm_get_pm_metrics(struct amdgpu_device *adev, void *pm_metrics,
 	if (!pp_funcs->get_pm_metrics)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_pm_metrics(adev->powerplay.pp_handle, pm_metrics,
 				       size);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1489,10 +1588,14 @@ int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 	if (!pp_funcs->get_fan_control_mode)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
 					     fan_mode);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1506,10 +1609,14 @@ int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
 	if (!pp_funcs->set_fan_speed_pwm)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle,
 					  speed);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1523,10 +1630,14 @@ int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
 	if (!pp_funcs->get_fan_speed_pwm)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle,
 					  speed);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1540,10 +1651,14 @@ int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
 	if (!pp_funcs->get_fan_speed_rpm)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
 					  speed);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1557,10 +1672,14 @@ int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
 	if (!pp_funcs->set_fan_speed_rpm)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
 					  speed);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1574,10 +1693,14 @@ int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
 	if (!pp_funcs->set_fan_control_mode)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
 					     mode);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1593,12 +1716,16 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
 	if (!pp_funcs->get_power_limit)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_power_limit(adev->powerplay.pp_handle,
 					limit,
 					pp_limit_level,
 					power_type);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1613,10 +1740,14 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
 	if (!pp_funcs->set_power_limit)
 		return -EINVAL;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_power_limit(adev->powerplay.pp_handle,
 					limit_type, limit);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1628,9 +1759,12 @@ int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
 	if (!is_support_sw_smu(adev))
 		return false;
 
+	if (amdgpu_reset_domain_access_read_start(adev))
+		return false;
 	mutex_lock(&adev->pm.mutex);
 	cclk_dpm_supported = is_support_cclk_dpm(adev);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return (int)cclk_dpm_supported;
 }
@@ -1639,14 +1773,19 @@ int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *ade
 						       struct seq_file *m)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret;
 
 	if (!pp_funcs->debugfs_print_current_performance_level)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	pp_funcs->debugfs_print_current_performance_level(adev->powerplay.pp_handle,
 							  m);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return 0;
 }
@@ -1661,11 +1800,15 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 	if (!pp_funcs->get_smu_prv_buf_details)
 		return -ENOSYS;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_smu_prv_buf_details(adev->powerplay.pp_handle,
 						addr,
 						size);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1728,11 +1871,15 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 	    !pp_funcs->set_pp_table)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_pp_table(adev->powerplay.pp_handle,
 				     buf,
 				     size);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1764,10 +1911,14 @@ int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
 	if (!pp_funcs->display_configuration_change)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->display_configuration_change(adev->powerplay.pp_handle,
 						     input);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1782,11 +1933,15 @@ int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
 	if (!pp_funcs->get_clock_by_type)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
 					  type,
 					  clocks);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1800,10 +1955,14 @@ int amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device *adev,
 	if (!pp_funcs->get_display_mode_validation_clocks)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_display_mode_validation_clocks(adev->powerplay.pp_handle,
 							   clocks);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1818,11 +1977,15 @@ int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
 	if (!pp_funcs->get_clock_by_type_with_latency)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_clock_by_type_with_latency(adev->powerplay.pp_handle,
 						       type,
 						       clocks);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1837,11 +2000,15 @@ int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
 	if (!pp_funcs->get_clock_by_type_with_voltage)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.pp_handle,
 						       type,
 						       clocks);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1855,10 +2022,14 @@ int amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device *adev,
 	if (!pp_funcs->set_watermarks_for_clocks_ranges)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_watermarks_for_clocks_ranges(adev->powerplay.pp_handle,
 							 clock_ranges);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1872,10 +2043,14 @@ int amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
 	if (!pp_funcs->display_clock_voltage_request)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->display_clock_voltage_request(adev->powerplay.pp_handle,
 						      clock);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1889,10 +2064,14 @@ int amdgpu_dpm_get_current_clocks(struct amdgpu_device *adev,
 	if (!pp_funcs->get_current_clocks)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
 					   clocks);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1904,9 +2083,12 @@ void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
 	if (!pp_funcs->notify_smu_enable_pwe)
 		return;
 
+	if (amdgpu_reset_domain_access_read_start(adev))
+		return;
 	mutex_lock(&adev->pm.mutex);
 	pp_funcs->notify_smu_enable_pwe(adev->powerplay.pp_handle);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 }
 
 int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
@@ -1918,10 +2100,14 @@ int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
 	if (!pp_funcs->set_active_display_count)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_active_display_count(adev->powerplay.pp_handle,
 						 count);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1935,10 +2121,14 @@ int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
 	if (!pp_funcs->set_min_deep_sleep_dcefclk)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_handle,
 						   clock);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1951,10 +2141,13 @@ void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
 	if (!pp_funcs->set_hard_min_dcefclk_by_freq)
 		return;
 
+	if (amdgpu_reset_domain_access_read_start(adev))
+		return;
 	mutex_lock(&adev->pm.mutex);
 	pp_funcs->set_hard_min_dcefclk_by_freq(adev->powerplay.pp_handle,
 					       clock);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 }
 
 void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
@@ -1965,10 +2158,13 @@ void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
 	if (!pp_funcs->set_hard_min_fclk_by_freq)
 		return;
 
+	if (amdgpu_reset_domain_access_read_start(adev))
+		return;
 	mutex_lock(&adev->pm.mutex);
 	pp_funcs->set_hard_min_fclk_by_freq(adev->powerplay.pp_handle,
 					    clock);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 }
 
 int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
@@ -1980,10 +2176,14 @@ int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
 	if (!pp_funcs->display_disable_memory_clock_switch)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return 0;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->display_disable_memory_clock_switch(adev->powerplay.pp_handle,
 							    disable_memory_clock_switch);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1997,10 +2197,14 @@ int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device *adev,
 	if (!pp_funcs->get_max_sustainable_clocks_by_dc)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return 0;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerplay.pp_handle,
 							 max_clocks);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -2015,11 +2219,15 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 	if (!pp_funcs->get_uclk_dpm_states)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return 0;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
 					    clock_values_in_khz,
 					    num_states);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -2033,10 +2241,14 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 	if (!pp_funcs->get_dpm_clock_table)
 		return -EOPNOTSUPP;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return 0;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
 					    clock_table);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 7fee5c88b6736..f16e512e23de3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -27,7 +27,6 @@
 #include "amdgpu_drv.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_dpm.h"
-#include "amdgpu_reset.h"
 #include "atom.h"
 #include <linux/pci.h>
 #include <linux/hwmon.h>
@@ -144,7 +143,7 @@ static int amdgpu_pm_dev_state_check(struct amdgpu_device *adev, bool runpm)
 	bool runpm_check = runpm ? adev->in_runpm : false;
 	bool full_init = (adev->init_lvl->level == AMDGPU_INIT_LEVEL_DEFAULT);
 
-	if (amdgpu_in_reset(adev) || !full_init)
+	if (!full_init)
 		return -EBUSY;
 
 	if (adev->in_suspend && !runpm_check)
-- 
2.55.0

