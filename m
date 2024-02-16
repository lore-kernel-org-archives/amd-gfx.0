Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C42CC48BEF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 15:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7584910EAD0;
	Fri, 16 Feb 2024 15:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IEiYHeXi";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A66B10EA13
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 15:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jf2U9/jzU6EHC6/5WmV97Nlh4m7qB50f+eIZIFJW4Y3UwJwsec7qHOHdxXBYL3oV6m/Wc6GZ40ac5UIlSj7kNEzDBA+TfRyTb8vZMwBhRGMg3cshk1DjEtsklRlL5kuHQLveciktxr8SJtc8ccgcpau+cCTGJMJsdihuX5QzOd36ijO40v/snDA4P9Ghe6pWAOJ9QQfN3qFXBw8tE9FR6PSxvwhtZqfLxmjyALMHPagr1fTh1UflyHFb+FuR/N/HT6+PtSFtJXo/HXNYM9is8kZ9ZxUwDQN8otm1iBQ9gEyPJiEUccoPWUp19/5XKrt4YKXncYE0Sa37P/Ox50Z6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10Xi/jDwo2t8d0gZDDpVLCDCsTW5qprx9dzsael1/zU=;
 b=gNu/IFzTqC4z/HLvAKyOm5osnR3shoWiptaO9ADL/UV8WfkemNZ4R95qfRz7/XrPoJmcgRVwNeE3ig/o8OtpTQCQNiyCHLZUfsj33cXN4XHeAl23d+/bsinlQAMVQyVniWkA9lQ9lPebU8wTVn9zWtATeNsPjvPn1qmsZN1azOg0fIIJJelmgavGkP5aO6502+BDp0WmEuJlZy32hxBoApYSJptDjNboP/vsZWIuqmQ7sFlKaQNInmpJxzSS+yqk8Ji8MMUUUn5jrKOuRTuDZB3FbRUeG+WAGPaujb4LXQQ+ZmgVd9rtyMC+VKjILU3TG/RhNWC5cbkDnYnfDgTmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10Xi/jDwo2t8d0gZDDpVLCDCsTW5qprx9dzsael1/zU=;
 b=IEiYHeXi+r5Mji+paq1ZmFm5P+o8NlApV7iYYYh2R57WHd/8zzISJPeUhAcnyXQ8GOFjbpEQcPsabnFbo8oGtZ3d9KsX55HY6siKI3dQNzWHiR5Ps0uIYibamq2uswCTgV9+1GRsRUkBCceY57Vmy7b8BCnI/JQXb2+qFTR81RQ=
Received: from BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::10)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 15:13:37 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::17) by BL1P222CA0005.outlook.office365.com
 (2603:10b6:208:2c7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Fri, 16 Feb 2024 15:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:13:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:13:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: use new reset-affected accessors for
 userspace interfaces
Date: Fri, 16 Feb 2024 10:13:22 -0500
Message-ID: <20240216151322.473527-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240216151322.473527-1-alexander.deucher@amd.com>
References: <20240216151322.473527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: aae715fb-119a-41de-1e39-08dc2f01d97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +u1ewcxc7ljiV7FcSDRTzr0ls9sqNxHmZrPz7TEtosZKik9WDS9Eq+nzWBMU9KavKzjNm53MVX7B1qLaltfzF2z5LhqNvS+Pwe0VWf/qnqhXIBx2KWP+nEgehiy1lHBVDI5cfk9qJ0jbvESqub8KDUMDKBnFPWzUwhBVb4nCPH+AalDPoIKLkWm3DqF7KfTwSThovCjdWOYwkOYLWiHTMFdf7kluHtYV/fwd8GGTCq56ZoFxU0tgrq2VTsTlZflHfyCtk7GDXstiervCcqWirwHJ+mcBlUPC+NrcU2FADk9Zdg7oLMb3q57e76hN7YA4v5S23K4qveH8ksLkA2yBOKmtn5bn2vMSK7i9aBtMXaecHpEEjUVrbO6JdvR9Gs6fdaz5nqabwEbnSji3gwPZf3GOU03FKfFv+PumKBNY7tD1DO5tFsjIXTmbzWDR/TBI7hBnrHRk15INtR2+dFv0vhP3o/0Y82wvhb+4rj9jZyfXucLzvpY5BCT7kn7s/KbpXpjb6+tRrLyIkASNbleAwhcb8NsiP8uEAngYQRv1YJgbu0t0yX4qRVeuzlcBYpP7TtrGBxS54FyKGz+7FdlG8oHgg4Yv86GHkLupHPrW3mh6Wp2ExDAs1pydD/9cyUD01GaVDJnL3DigvERPwPbLO7//8d4EvCLs2Ap5S7LkF7g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(36860700004)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(46966006)(6666004)(316002)(8936002)(8676002)(4326008)(6916009)(2906002)(5660300002)(30864003)(86362001)(7696005)(70206006)(70586007)(478600001)(1076003)(2616005)(41300700001)(36756003)(26005)(83380400001)(82740400003)(81166007)(16526019)(336012)(426003)(356005)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:13:36.9914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aae715fb-119a-41de-1e39-08dc2f01d97f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  10 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c         | 215 ++++++++++++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c          |  91 ---------
 4 files changed, 235 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 72eceb7d6667..d0e4a8729703 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1670,7 +1670,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	r = down_write_killable(&adev->reset_domain->sem);
+	r = amdgpu_reset_domain_access_write_start(adev);
 	if (r)
 		return r;
 
@@ -1699,7 +1699,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 		kthread_unpark(ring->sched.thread);
 	}
 
-	up_write(&adev->reset_domain->sem);
+	amdgpu_reset_domain_access_write_end(adev);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -1929,7 +1929,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		return -ENOMEM;
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	r = down_read_killable(&adev->reset_domain->sem);
+	r = amdgpu_reset_domain_access_read_start(adev);
 	if (r)
 		goto pro_end;
 
@@ -1970,7 +1970,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	/* restart the scheduler */
 	kthread_unpark(ring->sched.thread);
 
-	up_read(&adev->reset_domain->sem);
+	amdgpu_reset_domain_access_read_end(adev);
 
 pro_end:
 	kfree(fences);
@@ -2031,23 +2031,23 @@ static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
 		return 0;
 
 	memset(reg_offset, 0, 12);
-	ret = down_read_killable(&adev->reset_domain->sem);
+	ret = amdgpu_reset_domain_access_read_start(adev);
 	if (ret)
 		return ret;
 
 	for (i = 0; i < adev->reset_info.num_regs; i++) {
 		sprintf(reg_offset, "0x%x\n", adev->reset_info.reset_dump_reg_list[i]);
-		up_read(&adev->reset_domain->sem);
+		amdgpu_reset_domain_access_read_end(adev);
 		if (copy_to_user(buf + len, reg_offset, strlen(reg_offset)))
 			return -EFAULT;
 
 		len += strlen(reg_offset);
-		ret = down_read_killable(&adev->reset_domain->sem);
+		ret = amdgpu_reset_domain_access_read_start(adev);
 		if (ret)
 			return ret;
 	}
 
-	up_read(&adev->reset_domain->sem);
+	amdgpu_reset_domain_access_read_end(adev);
 	*pos += len;
 
 	return len;
@@ -2089,14 +2089,14 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 		ret = -ENOMEM;
 		goto error_free;
 	}
-	ret = down_write_killable(&adev->reset_domain->sem);
+	ret = amdgpu_reset_domain_access_write_start(adev);
 	if (ret)
 		goto error_free;
 
 	swap(adev->reset_info.reset_dump_reg_list, tmp);
 	swap(adev->reset_info.reset_dump_reg_value, new);
 	adev->reset_info.num_regs = i;
-	up_write(&adev->reset_domain->sem);
+	amdgpu_reset_domain_access_write_end(adev);
 	ret = size;
 
 error_free:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a2df3025a754..4efb44a964ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -43,6 +43,7 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "amd_pcie.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
@@ -704,7 +705,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
@@ -831,6 +836,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -ENOMEM;
 		alloc_size = info->read_mmr_reg.count * sizeof(*regs);
 
+		ret = amdgpu_reset_domain_access_read_start(adev);
+		if (ret)
+			return -EFAULT;
 		amdgpu_gfx_off_ctrl(adev, false);
 		for (i = 0; i < info->read_mmr_reg.count; i++) {
 			if (amdgpu_asic_read_register(adev, se_num, sh_num,
@@ -840,10 +848,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					      info->read_mmr_reg.dword_offset + i);
 				kfree(regs);
 				amdgpu_gfx_off_ctrl(adev, true);
+				amdgpu_reset_domain_access_read_end(adev);
 				return -EFAULT;
 			}
 		}
 		amdgpu_gfx_off_ctrl(adev, true);
+		amdgpu_reset_domain_access_read_end(adev);
 		n = copy_to_user(out, regs, min(size, alloc_size));
 		kfree(regs);
 		return n ? -EFAULT : 0;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f84bfed50681..bb698d2c5e01 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -31,6 +31,7 @@
 #include "amdgpu_display.h"
 #include "hwmgr.h"
 #include <linux/power_supply.h>
+#include "amdgpu_reset.h"
 #include "amdgpu_smu.h"
 
 #define amdgpu_dpm_enable_bapm(adev, e) \
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
@@ -493,12 +502,16 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
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
@@ -918,7 +931,10 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
 		goto out;
 	}
 
+	if (amdgpu_reset_domain_access_read_start(adev))
+		goto out;
 	*state = pp_funcs->get_current_power_state(adev->powerplay.pp_handle);
+	amdgpu_reset_domain_access_read_end(adev);
 	if (*state < POWER_STATE_TYPE_DEFAULT ||
 	    *state > POWER_STATE_TYPE_INTERNAL_3DPERF)
 		*state = adev->pm.dpm.user_state;
@@ -951,12 +967,15 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
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
@@ -970,6 +989,7 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
 					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
 					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
+	int ret;
 
 	if (!pp_funcs || !pp_funcs->force_performance_level)
 		return 0;
@@ -983,12 +1003,16 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 
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
 
@@ -996,6 +1020,9 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
 		return -EINVAL;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	if (!(current_level & profile_mode_mask) &&
 	      (level & profile_mode_mask)) {
 		/* enter UMD Pstate */
@@ -1027,6 +1054,7 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 	adev->pm.dpm.forced_level = level;
 
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return 0;
 }
@@ -1040,10 +1068,14 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
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
@@ -1058,11 +1090,15 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
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
@@ -1075,10 +1111,14 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 	if (!pp_funcs->get_pp_table)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
 				     table);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1094,12 +1134,16 @@ int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
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
@@ -1115,12 +1159,16 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
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
@@ -1135,11 +1183,15 @@ int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
 	if (!pp_funcs->print_clock_levels)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->print_clock_levels(adev->powerplay.pp_handle,
 					   type,
 					   buf);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1155,12 +1207,16 @@ int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
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
@@ -1174,10 +1230,14 @@ int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
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
@@ -1190,10 +1250,14 @@ int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char *buf)
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
@@ -1208,11 +1272,15 @@ int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
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
@@ -1225,9 +1293,13 @@ int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
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
@@ -1235,14 +1307,19 @@ int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
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
@@ -1262,9 +1339,13 @@ int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
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
@@ -1272,14 +1353,19 @@ int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
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
@@ -1300,10 +1386,14 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
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
@@ -1317,11 +1407,15 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
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
@@ -1334,10 +1428,14 @@ int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table)
 	if (!pp_funcs->get_gpu_metrics)
 		return 0;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
 					table);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1351,10 +1449,14 @@ ssize_t amdgpu_dpm_get_pm_metrics(struct amdgpu_device *adev, void *pm_metrics,
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
@@ -1368,10 +1470,14 @@ int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
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
@@ -1385,10 +1491,14 @@ int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
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
@@ -1402,10 +1512,14 @@ int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
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
@@ -1419,10 +1533,14 @@ int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
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
@@ -1436,10 +1554,14 @@ int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
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
@@ -1453,10 +1575,14 @@ int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
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
@@ -1472,12 +1598,16 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
 	if (!pp_funcs->get_power_limit)
 		return -ENODATA;
 
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
@@ -1491,10 +1621,14 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
 	if (!pp_funcs->set_power_limit)
 		return -EINVAL;
 
+	ret = amdgpu_reset_domain_access_read_start(adev);
+	if (ret)
+		return ret;
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_power_limit(adev->powerplay.pp_handle,
 					limit);
 	mutex_unlock(&adev->pm.mutex);
+	amdgpu_reset_domain_access_read_end(adev);
 
 	return ret;
 }
@@ -1506,9 +1640,12 @@ int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
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
@@ -1517,14 +1654,19 @@ int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *ade
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
@@ -1539,11 +1681,15 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
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
@@ -1580,11 +1726,15 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 	if (!pp_funcs->set_pp_table)
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
@@ -1616,10 +1766,14 @@ int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
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
@@ -1634,11 +1788,15 @@ int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
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
@@ -1652,10 +1810,14 @@ int amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device *adev,
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
@@ -1670,11 +1832,15 @@ int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
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
@@ -1689,11 +1855,15 @@ int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
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
@@ -1707,10 +1877,14 @@ int amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device *adev,
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
@@ -1724,10 +1898,14 @@ int amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
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
@@ -1741,10 +1919,14 @@ int amdgpu_dpm_get_current_clocks(struct amdgpu_device *adev,
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
@@ -1756,9 +1938,12 @@ void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
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
@@ -1770,10 +1955,14 @@ int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
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
@@ -1787,10 +1976,14 @@ int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
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
@@ -1803,10 +1996,13 @@ void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
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
@@ -1817,10 +2013,13 @@ void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
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
@@ -1832,10 +2031,14 @@ int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
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
@@ -1849,10 +2052,14 @@ int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device *adev,
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
@@ -1867,11 +2074,15 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
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
@@ -1885,10 +2096,14 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
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
index 8d7d6a507d3a..dc9f9c733a2d 100644
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
@@ -139,8 +138,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type pm;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -170,8 +167,6 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -267,8 +262,6 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -306,8 +299,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level;
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -368,8 +359,6 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	uint32_t i;
 	int buf_len, ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -406,8 +395,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -445,8 +432,6 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -468,8 +453,6 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	unsigned long idx;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -538,8 +521,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	char *table = NULL;
 	int size, ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -574,8 +555,6 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -757,8 +736,6 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t type;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -859,8 +836,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	};
 	uint clk_index;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -919,8 +894,6 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	uint64_t featuremask;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -954,8 +927,6 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1023,8 +994,6 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	int size = 0;
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1092,8 +1061,6 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1277,8 +1244,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1306,8 +1271,6 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1339,8 +1302,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1368,8 +1329,6 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1421,8 +1380,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1460,8 +1417,6 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	long int profile_mode = 0;
 	const char delimiter[3] = {' ', '\n', '\0'};
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1514,8 +1469,6 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
 {
 	int r, size = sizeof(uint32_t);
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1603,8 +1556,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	uint64_t count0 = 0, count1 = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1646,8 +1597,6 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1819,8 +1768,6 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
 	ssize_t size = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1860,8 +1807,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	ssize_t size = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -1978,8 +1923,6 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 	int r = 0;
 	int bias = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2050,8 +1993,6 @@ static ssize_t amdgpu_get_xgmi_plpd_policy(struct device *dev,
 	char *mode_desc = "none";
 	int mode;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2073,8 +2014,6 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int mode, ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2530,8 +2469,6 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2561,8 +2498,6 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	int err, ret;
 	int value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2610,8 +2545,6 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2655,8 +2588,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	int err;
 	u32 speed = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2685,8 +2616,6 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	int err;
 	u32 speed = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2749,8 +2678,6 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	int err;
 	u32 rpm = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2780,8 +2707,6 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2824,8 +2749,6 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2856,8 +2779,6 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 	int value;
 	u32 pwm_mode;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -2996,8 +2917,6 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 	ssize_t size;
 	int r;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -3077,8 +2996,6 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 	int err;
 	u32 value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -3531,8 +3448,6 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 	int size = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -3615,8 +3530,6 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 	long parameter[64];
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -4482,8 +4395,6 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 	u64 flags = 0;
 	int r;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
@@ -4527,8 +4438,6 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
 	void *smu_prv_buf;
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-- 
2.42.0

