Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B05D2ED08
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6FC710EC89;
	Wed,  1 Apr 2026 13:52:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rsmAOMNq";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37AD710EC89
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1xLl5Gx+bpaSCAmyocfp3B5SqJealN6D+RVjtXPjofHDkWoL3wB8frSq/orSx5VQTvaNLCE+aJu122J/tmJGzZ/YWZ1a2PYYcJkc595EifrLlRC/Vz752LknTpnpkl0/97TmZN8gQVkUSmxbX0TTWejYX2PgBtP6iI6lPRsYOaEYSbXYK8LX/hke+nzn9Emrxou+qisOpil/tAs95zNFPaAMiH9m2LAB0resQAX+cZqOoNavhRfkcagVSB0VBbleCLSHTq49oJizeYl2GAoACIOEbXgZuIdWnxliI9PEfzehr5pdj6YddsmoLa40UsstxKXfslSgnbjvbe55tP+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iW9Thpl0j7W51yqRmSOJJ4h2SuvMgEmOcDoEc/Gs+2w=;
 b=YZg0Y9u438zZ2tkK1D+4oTxTi/BuoYL+QbNsZrLOdm8hdQPbp+SUxPgnjRmSlGb6anICjv8IU45GXf2Fv9kRuF1JXMBwvIm6SzuNxQ6hJcmH1vIAhNPI04fHbRakP/v/ZRCLGOelZdW76YdPj7YN1o4bpPmmQBSIbx7XzAoqtaUzxlshKbNTxNrg8wpr2N55w7oy0xIemOs882V9Z+RXMamp/9q5J1sXf8X7DlNBWBiLPrq8bQ1bMMA2WsHKUPIzEYs9O0kOqZjQAhiAgYT3eKaR+hgjy8fq0DNKjQ38kDNFSIdN5KnpMYrBw3XRJoJac0cXQ6W6oPxN7Z+Pwf+CIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iW9Thpl0j7W51yqRmSOJJ4h2SuvMgEmOcDoEc/Gs+2w=;
 b=rsmAOMNq1DeoKqEG7vILqKCLqlOb0Ny/MPfLzee4ZpRak5igTtM5NtRgVVnbIUVACWY0EvGDwOBiwNbe3Y1IACsc3C5Oawl1q6s3cEECqKCYbZIxz//alPpKLmvQ8Wrz2H7dr4FtkPoeih2zz7ggw1Jl5RNWHCm8mQul+y9jZ+U=
Received: from MN2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:208:1a0::29)
 by IA0PPFACF832414.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 13:52:25 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::8) by MN2PR07CA0019.outlook.office365.com
 (2603:10b6:208:1a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 13:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 13:52:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 08:52:24 -0500
Received: from vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 08:52:24 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/pm: Change gpu_metrics over to binary
Date: Wed, 1 Apr 2026 09:52:12 -0400
Message-ID: <20260401135217.541006-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|IA0PPFACF832414:EE_
X-MS-Office365-Filtering-Correlation-Id: 388025ed-f41a-4e7d-7ffb-08de8ff5e7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: zYX47o8SIizLFhOAqXwxwBTWr9LjRdVJZUa7WWNj83AKE55ihUGV7ci7GjQ83RzTjeZUV5JutGxGIE9e8yVlNRP/VNvV2BFAccVFWSE48JRh9WqQw9byqtVrjPVlkhzo/91DqbfYbmS0BxlDa71Af9CYxXED1M3fQ35TzRejObblthyby8McMrpSnjN3gb8LuHphRErrzmofs1VxxWP3plesbu5mvwu9L1sJQGCgH0I/KchpPk+z/+ylw19B+Ifh1ZOEdzUokFazHImBpcXBprVAwI7Uh495o2EV09/fvUf/FMOMRmsRFchVfGRqs32j5fx3U6fDh0NF72fOCQx4G2j5TM0w46M3RlDer/hoVEVgL1F5WUDaqhq/Ok8CYAyrDOK79ZiFIL5uE7CT9SUeAzD0DGVbIGTmwyt5UBWkdPlEI6r5kDbUuqzX6YJx537gFy6FJ2G5eUSz01vvrmZ6TnPu2Gc7QdoiRfsitGZX6NqBv8S18hmIzce1QiNk/EE1VQE++4qo3vMO6rL1Sw41a5dl+LJOVN1FVpwiqrjHJwj8ZWZ0mvkuTsKZSeTGlSGdV8zbRc6tS0MzQmt5FBwC+qmrzv/zNsAbxIUgiFAjG0T99PIm/+JuP5YX68I5uCjWLuM/Iq4mZ6EEtO2AWfr+5T0pqniYzI0sygTNGdRbEZqeev9dgCKZYcww/zWPUkU/LPhl6tOvmrGhufh/hUyKLO8yzowr00WrzDw2AKnWd3jx5Q++Z2Ij6wl3gVOlS9BOqAEe2QWwdOIMuXZ9h/7rbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DMJh9Uovk7GwaiVtL7fHLZhWBzJdwBi1KBFJamRxoBftvTfP7UiyMPnWTKZV8g8P1/mrLCRlPyOEjqASsX7HnzoV4BzSEGleu4uDQbc6F1NrYPjtFBuZG0ATFwLtrt3vd83Br4ELCNRXL7y8ww2K0yQgybBqNDyXnm7e8xwZjJo1D39TlEugBABdAl0S0upcwI+L25Mru2tNt3BlZK04XVQP241FXOx8c/v658EriauV4qkj8ZBm6ltj5XP/IE1FRrMvst5ywsfjMRkXeG0ExV/AEq991oAsn+qr7ypXZbaLUnOc18jYpzOW0qge0cnEJ9cB9hSlX5couHYf5TNNM032hDcBDz4gLRGvlvStvVzECFcTbKEzLdpozRbtegwQInXLdgvOc220pDhvtxhg+W2wCc+HCrHoa+klzAAlMgnlASEhCfoA9VwTOLVc3M+4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:52:25.4131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388025ed-f41a-4e7d-7ffb-08de8ff5e7f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFACF832414
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

