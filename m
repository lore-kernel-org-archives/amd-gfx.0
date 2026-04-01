Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAA9107637B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 708AB10ECB6;
	Wed,  1 Apr 2026 13:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u8dKc8zn";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E0D10ECB6
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtPSyLz2J6mjwULBBClDZY6BomYpppkIss3VAH5doDIyqD1gbK+nrDK+3mukZbevPnmY7X2LWR8k/YFdwFm/+8k5VvXUlzjuPvVQAozN8L9kAtVLcUdhj/FzmDY0qEZZ44AIHJqPVE+u1VmMFhrBHePqk+G9vGcZRfQAUv92KnjgjYBKvPSGYJfW9krzBmh6FB2vD69POJR5VjcTiWznSqp8JegVwDRoB8m1oKChzvXHgizao98L5yo+AkrZdNEwuq1Xn/bHliv1uA8Uv1tYWZhxxonVdQ9Wt9ERnirejs9BmHaTro61YCtMeErjwlAIdxe5slHE6UHEOsXKG7eYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iW9Thpl0j7W51yqRmSOJJ4h2SuvMgEmOcDoEc/Gs+2w=;
 b=YDKn8G9jg6UwZawu98b9iWzg+G+Yk5NEKDudoU4G8rsI8Vjya/XFu5iCOYsC2mwwW2+46DhuPDGEgY+zFdf9VS9b0X+J+fELNYwgOOM2L5fpZkvKCjcaNlrxfF5Yl1yBgY1KT4mHzGd0raAcApj2gyjTtwgkXm+1WGskeWIQUN+HpAKHDx9zYGx74Bpr1r4Ci1UlXusoiBRze7CytQd777BGJmfKEkxdX8xD9PhmSplS7s76jdbhsBb99acEFuVhZcJ8SIrGfHBmUwUk2ZiaAb8IVZ2JY6L0opYG9eI202aKg5RW4GkAbkphggAwOOJCOQAa0uo/S8jCjG/uFIR3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iW9Thpl0j7W51yqRmSOJJ4h2SuvMgEmOcDoEc/Gs+2w=;
 b=u8dKc8zn8FAbU4lOx40/ovyWB5qAsSqYkhrQAIQZB1lTCz34ah7ucPi2mtuQNimDDnPks0z14xO5tdiimxxncKz81AL/tAE1ykkV/QJ3OHHKhfTLxmcMsV2H/SwBMyErn3JuDWRub8Ox/ygT4LOso5uKZiitBVA9vPEwGlxqjSU=
Received: from BL1PR13CA0333.namprd13.prod.outlook.com (2603:10b6:208:2c6::8)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 13:53:25 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::6c) by BL1PR13CA0333.outlook.office365.com
 (2603:10b6:208:2c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Wed,
 1 Apr 2026 13:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 13:53:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 08:53:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 06:53:24 -0700
Received: from vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 08:53:24 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/pm: Change gpu_metrics over to binary
Date: Wed, 1 Apr 2026 09:53:21 -0400
Message-ID: <20260401135322.541198-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b01736-9537-4e10-898b-08de8ff60ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ou2ztGVEq+IUXdRFjaorXGwURVKkR2FqPvPT3/8mkWKc/QKyPrIHu/eJ4RWN3UiDGemWDHnB2QP4dPscZln7ULyQe4jSE9YwB+HxI3IDcbD5kCc2PziIPLZYmwx+EeBfnYlhwY+Fz9qjmnsXBsg4JjKDCfPfpV898waR9BzLmffGhusyYcPVm8qWqmsfPpFHfD1WXoLdWTzrPx2Q4rRZyrhXpiwlACJ/K1s+xqdjHi28enc870WDJdkm8/uilxsKNyvKV5BT0RjTdZrYWxHyBCgUBJJepy6ZyXmrcy5gPB2NpKz/qg8Db6fOTj2zxi2s8D0qhBVFOYlykD/l1I+Z/wRzk7twR8Z0Xj7aZFDhoWCdthFoJ2ZE8XQ/K+AVvWynNqVppyhr/0UXT5bZWCViQCzJW+Wb6vw/3P0WVEV2vUY/rubqdySaA9GNVVhOkPcy4hGoXzx1ViHo4AQ1E1FzmcmXDNwMVN//GYEyJJXLRt/9Rzm/8hTzXkjZ8RpHGaWde/AYeNg6YyoPdxNvEzRNCjodew7vViEofXAYJ2bpVWpKRYO7p/ioBkmJ56sLze9tCRw5LYT8a/E4ASbj//A87HX6EENSYb8fvzrIqgZ0Ha43DDNrNUtSFefTjLq1e6ZcBE6WOiXsbSH0GhHQAVaVj0yON/FBLGUenADaFNxYOlx1WLfKmTFvmAUI+PVwkYCktuDsEMlNzuHgGVUMOftyxDrS6ZD/Y33MJ4Wbu7KnnH+/L2gUcXDmNjSFu+wRd/mzvpVFUuRomadffYMiBsULhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nK1N3GbE8kny3yc+B71xAYToRZp7+B55RCmZ0ZMdgQPfw1B9j/4sOp0uFrZL2tH7o5da410wVmspKAw8zt7YpFM2X93Hjaoyi72rVogZUJWnLvv8AO0hJ/e0GOrUn/MSw2NQ8az2FpuWos2GrbrP/uVh2BLVAOyKcvvduBk6mbhIGaBz1WHu83mkjikK2aSphjNvFJkGRhIwKYPW5m3nRcjEjAojm+iZlsjtb1GAx6gQlAXsuBftHqbA8eXoDgD6IA/yZPX1t6DeveuwVOs2K9K5Wf6Xrvwzv9juyLdh4y8K3pzEEdmZyUn9Dhbnz7SiHVZIrHvX4K3Wk4MfJoaF3i5+qo0Tn0UV7Q5Whq06younxPWkPZtDFf2SNGPrWsLHQU7ijrb3PmiAw5VPNCo6LIQZUzRx/Mp/398YXfMtiH7sCEopujFir9y5G2+sstdr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:53:25.2740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b01736-9537-4e10-898b-08de8ff60ba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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

The file is binary anyways but also because it reported previously
as a static 4KB block it made correctly reading it hard since
you can't error check on if your read succeeded or not.

Tested on my Navi48.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 106 +++++++++++++++++++-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |   1 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h  |   1 -
 3 files changed, 88 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a4d8e667eafb..7139983705bc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -34,8 +34,17 @@
 #include <linux/nospec.h>
 #include <linux/pm_runtime.h>
 #include <linux/string_choices.h>
+#include <linux/sysfs.h>
+#include <linux/sizes.h>
 #include <asm/processor.h>
 
+/*
+ * Sysfs reports this as the file size (stat/ls); kernfs also uses it to cap
+ * read offsets. Actual payload length is the return value of
+ * amdgpu_dpm_get_gpu_metrics() and must not exceed this.
+ */
+#define AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ	SZ_128K
+
 #define MAX_NUM_OF_FEATURES_PER_SUBSET		8
 #define MAX_NUM_OF_SUBSETS			8
 
@@ -1734,43 +1743,86 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
  * DOC: gpu_metrics
  *
  * The amdgpu driver provides a sysfs API for retrieving current gpu
- * metrics data. The file gpu_metrics is used for this. Reading the
- * file will dump all the current gpu metrics data.
+ * metrics data. The binary sysfs file gpu_metrics is used for this.
+ * Reading the file returns the raw metrics blob; reads may be shorter
+ * than the full structure, so userspace should use read() until EOF
+ * when the buffer may exceed one page. The sysfs file size is an upper
+ * bound for inode metadata; the real length is the amount returned
+ * before EOF on sequential reads.
+ *
+ * Do not use stdio fread(3) as fread(buf, 128*1024, 1, fp): that asks for
+ * one object of 128KiB and returns 0 if the payload is shorter (even when
+ * data was read). Use read(2), or fread(buf, 1, sizeof(buf), fp), or loop
+ * until feof/short read.
  *
  * These data include temperature, frequency, engines utilization,
  * power consume, throttler status, fan speed and cpu core statistics(
  * available for APU only). That's it will give a snapshot of all sensors
  * at the same time.
  */
-static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
+static bool amdgpu_pm_gpu_metrics_bin_visible(struct amdgpu_device *adev,
+					      uint32_t mask)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (!((ATTR_FLAG_BASIC | ATTR_FLAG_ONEVF) & mask))
+		return false;
+
+	return gc_ver >= IP_VERSION(9, 1, 0);
+}
+
+static ssize_t amdgpu_sysfs_gpu_metrics_read(struct file *f, struct kobject *kobj,
+					     const struct bin_attribute *attr,
+					     char *buf, loff_t off, size_t count)
 {
+	struct device *dev = kobj_to_dev(kobj);
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	void *gpu_metrics;
-	ssize_t size = 0;
+	int len;
 	int ret;
 
-	ret = amdgpu_pm_get_access_if_active(adev);
+	(void)f;
+	(void)attr;
+
+	/*
+	 * Kernfs invokes this once per chunk (at most PAGE_SIZE bytes per call)
+	 * for a single userspace read(). Use pm_runtime_resume_and_get via
+	 * amdgpu_pm_get_access so later chunks still succeed after the prior
+	 * chunk's put_autosuspend — get_if_active would return -EPERM once the
+	 * GPU had gone idle between chunks.
+	 */
+	ret = amdgpu_pm_get_access(adev);
 	if (ret)
 		return ret;
 
-	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
-	if (size <= 0)
-		goto out;
+	len = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
+	if (len < 0) {
+		amdgpu_pm_put_access(adev);
+		return len;
+	}
+	if (len == 0) {
+		amdgpu_pm_put_access(adev);
+		return 0;
+	}
 
-	if (size >= PAGE_SIZE)
-		size = PAGE_SIZE - 1;
+	if (off >= len) {
+		amdgpu_pm_put_access(adev);
+		return 0;
+	}
 
-	memcpy(buf, gpu_metrics, size);
+	if (count > (size_t)(len - off))
+		count = len - off;
 
-out:
+	memcpy(buf, (u8 *)gpu_metrics + off, count);
 	amdgpu_pm_put_access(adev);
 
-	return size;
+	return count;
 }
 
+static const BIN_ATTR(gpu_metrics, 0444, amdgpu_sysfs_gpu_metrics_read, NULL,
+		      AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ);
+
 static int amdgpu_show_powershift_percent(struct device *dev,
 					char *buf, enum amd_pp_sensors sensor)
 {
@@ -2579,7 +2631,6 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(apu_thermal_cap,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,			ATTR_FLAG_BASIC,
 			      .attr_update = ss_power_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,			ATTR_FLAG_BASIC,
@@ -2657,9 +2708,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		     gc_ver != IP_VERSION(9, 4, 3)) ||
 		    gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
-		if (gc_ver < IP_VERSION(9, 1, 0))
-			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
@@ -4755,6 +4803,17 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	if (ret)
 		goto err_out0;
 
+	if (amdgpu_pm_gpu_metrics_bin_visible(adev, mask)) {
+		ret = sysfs_create_bin_file(&adev->dev->kobj, &bin_attr_gpu_metrics);
+		if (ret) {
+			dev_err(adev->dev,
+				"failed to create gpu_metrics sysfs bin file, ret = %d\n",
+				ret);
+			goto err_out1;
+		}
+		adev->pm.gpu_metrics_bin_registered = true;
+	}
+
 	if (amdgpu_dpm_is_overdrive_supported(adev)) {
 		ret = amdgpu_od_set_init(adev);
 		if (ret)
@@ -4806,6 +4865,10 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	return 0;
 
 err_out1:
+	if (adev->pm.gpu_metrics_bin_registered) {
+		sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_gpu_metrics);
+		adev->pm.gpu_metrics_bin_registered = false;
+	}
 	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
 err_out0:
 	if (adev->pm.int_hwmon_dev)
@@ -4821,6 +4884,11 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
 
+	if (adev->pm.gpu_metrics_bin_registered) {
+		sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_gpu_metrics);
+		adev->pm.gpu_metrics_bin_registered = false;
+	}
+
 	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index aa3f427819a0..67ff83b2134c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -349,6 +349,7 @@ struct amdgpu_pm {
 	/* dpm */
 	bool                    dpm_enabled;
 	bool                    sysfs_initialized;
+	bool			gpu_metrics_bin_registered;
 	struct amdgpu_dpm       dpm;
 	const struct firmware	*fw;	/* SMC firmware */
 	uint32_t                fw_version;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index c12ced32f780..dc6875871f1d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -73,7 +73,6 @@ enum amdgpu_device_attr_id {
 	device_attr_id__unique_id,
 	device_attr_id__thermal_throttling_logging,
 	device_attr_id__apu_thermal_cap,
-	device_attr_id__gpu_metrics,
 	device_attr_id__smartshift_apu_power,
 	device_attr_id__smartshift_dgpu_power,
 	device_attr_id__smartshift_bias,
-- 
2.51.0

