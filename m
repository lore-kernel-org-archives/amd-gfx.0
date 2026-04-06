Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205D5F46C56
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2026 16:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98BF10E229;
	Mon,  6 Apr 2026 16:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u0V9st/A";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D17210E229
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2026 16:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4tqyOucsueQmUJE4Bmj2M+c6FZIIJWPsZWQD/UVeHUno8/yjYlVQ1p++VMZN+MtEoynWnhbW5nGbPAKoCmRBWeJZqwaRZj8TCCXi7iVE5dVTN0BR9cVahGumZbE13agdMZdpfl4lO0W8zRUwoNW1Qw2/XjeeLUQ+kU4mzNM+BpAwJljSuU2DNG9DD4oY0tM1NKUPFrtA5tPqiNApypufS4pfYBZGkTNy9qL3EVWRBRT3DuW35uiljpOyBsOsUGLqSsThq3nL1YXgnHzw7rXmwb5jquVGNLhdVoXqmWD2NCqWikB6+IZrZJMM74vFDEF5W5yVyB0AbAgtctf36A0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuSi2xCGpDNN93xlvQItxtsRANCEOAqLGDWPMP1CGto=;
 b=FZ8x1SVQ0ECZ3dkXoWV/O6x4LktlK05+jtGezhRR3NyMGEejDCVF6amoRDf/TR7UdtnvUOeGvRltpzc/IyUXYSoACI0qDnR08Jw5n5nwkQ5yQRmyAWoD2O5qDN0rGcoNAeJI59PYjp4CmKYYbbGSVhnoXUc9844Yg33Mn99wl6vZnPQnlO2hAcabYF+GyWH1yzWO/fbRKud9yeMnNMaim2t+Xh6XKap7FWhIEp40Jm5UnsMNjgxVWNEODvNdCfLH3atLKgQ+3Tyg0MLS253zqrW39OCsigWPgQdGBve1SrR6l7HbavnjjYfVuLoYoeI45yeT9QBB7lXddiGeidCYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuSi2xCGpDNN93xlvQItxtsRANCEOAqLGDWPMP1CGto=;
 b=u0V9st/Akrc2izM181obxuLVlCR520PyoUDqXAivD9bIoHWQOIDExD/J6yCrmXrUoxM1lyo4sz/ngGp3iXtwhu9JbkZWcvfaWtFw5V/V7UR5WorMxUdJTLL0N4nDPlG0lwi1/wFAcPEhTSPSkIIWlVN6RvnjwYlTvUJBA0yElgo=
Received: from SJ0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:a03:33e::15)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 16:25:57 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::57) by SJ0PR03CA0040.outlook.office365.com
 (2603:10b6:a03:33e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 16:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 16:25:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 11:25:56 -0500
Received: from vm.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Apr 2026 11:25:56 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tom St Denis <tom.stdenis@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH] drm/amd/pm: Change gpu_metrics over to binary with per-reader
 snapshots (v4)
Date: Mon, 6 Apr 2026 12:25:53 -0400
Message-ID: <20260406162553.25281-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d5bb04-73a4-4fe0-3674-08de93f92ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: pKUxscWbPtqTTpJbzhLlxn6eOvt1JyqPXeZG/Jgcsc07MJhH5H78tcCdNPyn1DgEcg3n+zqhOnF2Yi99f1XknqE352yfHegcnSZL6wH3Ov8ZHOQ4rY7PSJ3d0gzSKMVtq2sVgQDBduuUOZGGQr7kCi8+m/nHMnqFqRM56X7o43/0nlTyaxyW6pxcZR5b6atTqzKlU0OKfOcrO8mcMiiNyf2NFizHsESHwdNdb5KJ7QgPcmoU6dSmEkSmVDvnkIf1iFLSqwBA+5vw9+AdyR3NynTlojq0jdOmzhRlH38z6Wp8rGw3Ksm8LEdu3OfyEajp0vODcGQmFf+Qy+/CUMWBIg2/Hx8vMpOZIe9mKYr+U5md4TMDZkYDwXaa8m7O6LFvy0uOZ3Is5dznaGY7CCYMOAfleqRuzF8v5hBhl4mtVnOb7BZKMZRj4fg4C97kXjmSU1/3e48p78zuxnyK48n79EOPPp5mbVehSLaHeRfuKgWqGqj/gN+lrP+4vll3iFevzIks59rtarTR16+ri1cpImWdn102ClhmswcrJqTAikstnbTlCCdhlfGOoqPsMsNvlsM3pithW5EKRRuozXUM9ExgKkz+AZHLme0GjF7HBNuH6Kop27tA42rCeVDd07osf1+cpAH/9UVMr9C/I9FeklqC7dj2JLNbhq5C7mLkCeJb18Qy5SWx3Prq8coLBDr6tOBfbGMbOJBxt9KpLe/XUjkdqYsQFW0V8jB31bNvhu5COajFueWyvsu9w0VlbZQakL/hOJYTMt+ffeqtIOQFBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L7RvfHckY3MVwEo2puXLGT45Gh7CU7AzGnsaPn8Pg+XGW7XZPt4iP2+XLqC00QqkgOheOomC4SE42wGdWsjOwofGDxMmomwhtdVaqdIqPzYvBmLY/ekZ1/x1TMD/TuI9/T9qHQSJ3iTdyFFk9uxSEAq1qDthO9sWEbdtQyxiLrsFLmXkjuvXSCN/ThgKhixkQArXGyw5xK3UICn+Hs/Ydnx4YqpXTYWdJWSJ/EBvGtJ5+C9qUscRYbI0ZrISd9Ef3heZsTvZPRZkt/M6UK+7CrJmo18FK8Kvni6kJcmk/lV8KOBW+p3L8J4FmfZ5ldj3+9WXVY4jmGeBqiivK9fswEY1FT6Hrvhr9TQhEXyIbEQen5IjcQIUZtupo3qrlQHEH1Pw5tG/KXJJWOh9H3WO4/7IoPqeBYG6tP6A/19+2+xEsCTZMwdRR08J+DZbAnLu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 16:25:57.0505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d5bb04-73a4-4fe0-3674-08de93f92ea4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
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

The gpu_metrics sysfs file carries a binary blob but was implemented as
a text device_attribute, which imposes a hard PAGE_SIZE-1 cap and makes
it impossible for userspace to distinguish a successful short read from
a truncated one (stat reports 4 KiB regardless of actual payload size).

Convert gpu_metrics to a bin_attribute.  The declared file size is an
upper bound (128 KiB); the real payload length is the byte count
returned before EOF.

To guarantee that multi-chunk reads (which kernfs splits at PAGE_SIZE
boundaries) return a coherent snapshot, each reader (identified by its
struct file pointer) gets its own cached metrics buffer via an xarray.
When offset is 0, PMFW is sampled and stored in that reader's entry;
subsequent offsets are served from the same snapshot.  The entry is
freed on EOF.  A mutex serialises xarray mutations and PMFW access.

Stale entries from readers that close without reaching EOF (e.g.,
killed processes) are lazily evicted after 30 seconds whenever any
new reader starts.

This per-reader approach avoids the cross-contamination problem of
a single shared cache: concurrent readers each see their own coherent
PMFW snapshot rather than risking one reader's off=0 overwriting the
buffer while another reader is mid-way through a multi-chunk read.

V3: Per-reader snapshot state, so each open fd gets its own cached
    gpu_metrics buffer and all chunks for that reader come from the
    same sample (Vitaly)

V4: Remove the residual PAGE_SIZE cap that v3 still carried over from
    v1. The whole point of the bin_attribute conversion is to
    lift the old PAGE_SIZE-1 limit, but v3 still had:
      - WARN_ON_ONCE(len > PAGE_SIZE) with silent truncation to 4K
      - kzalloc(PAGE_SIZE) for the snapshot buffer (fixed allocation)
      - a separate memcpy from metrics into that fixed buffer
    In v4 the snapshot buffer is allocated with kmemdup() sized to the
    actual payload returned by amdgpu_dpm_get_gpu_metrics(), so payloads
    larger than PAGE_SIZE work correctly.  The only remaining upper bound
    is AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ (128 KiB), which is the
    declared bin_attribute file size and serves as a sanity check —
    exceeding it now returns -EOVERFLOW instead of silently truncating.
    (Tom)

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: Ib4fa233d9a25a396f1cc7d5fcf74f5f6578329f5
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 208 +++++++++++++++++++++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |   4 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h  |   1 -
 3 files changed, 188 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a4d8e667eafb..303a2d643b10 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -34,8 +34,19 @@
 #include <linux/nospec.h>
 #include <linux/pm_runtime.h>
 #include <linux/string_choices.h>
+#include <linux/sysfs.h>
+#include <linux/sizes.h>
+#include <linux/xarray.h>
 #include <asm/processor.h>
 
+/*
+ * Sysfs reports this as the file size (stat/ls); kernfs also uses it to cap
+ * read offsets.  Actual payload length is the return value of
+ * amdgpu_dpm_get_gpu_metrics() and must not exceed this.
+ */
+#define AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ	SZ_128K
+
+
 #define MAX_NUM_OF_FEATURES_PER_SUBSET		8
 #define MAX_NUM_OF_SUBSETS			8
 
@@ -1734,43 +1745,170 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
  * DOC: gpu_metrics
  *
  * The amdgpu driver provides a sysfs API for retrieving current gpu
- * metrics data. The file gpu_metrics is used for this. Reading the
- * file will dump all the current gpu metrics data.
+ * metrics data.  The binary sysfs file gpu_metrics is used for this.
+ * Reading the file returns the raw metrics blob.  The sysfs file size
+ * is an upper bound for inode metadata; the real length is the amount
+ * returned before EOF.
+ *
+ * Metrics are sampled atomically per reader: the first read at offset 0
+ * captures a snapshot into a per-fd cache; subsequent reads at higher
+ * offsets (for payloads that span multiple pages) are served from that
+ * same snapshot.  Concurrent readers each get their own cache.
  *
  * These data include temperature, frequency, engines utilization,
  * power consume, throttler status, fan speed and cpu core statistics(
  * available for APU only). That's it will give a snapshot of all sensors
  * at the same time.
  */
-static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
+
+/* Per-reader snapshot entry, keyed by struct file pointer in the xarray */
+struct gpu_metrics_snap_entry {
+	void    *data;
+	size_t  size;
+	ktime_t timestamp;
+};
+
+/* Evict stale entries from readers that closed without reaching EOF */
+#define GPU_METRICS_SNAP_STALE_NS	(30ULL * NSEC_PER_SEC)
+
+static void gpu_metrics_evict_stale_locked(struct xarray *xa,
+					   unsigned long skip_key)
+{
+	struct gpu_metrics_snap_entry *entry;
+	unsigned long idx;
+	ktime_t cutoff;
+
+	cutoff = ktime_sub(ktime_get(), ns_to_ktime(GPU_METRICS_SNAP_STALE_NS));
+
+	xa_for_each(xa, idx, entry) {
+		if (idx != skip_key && ktime_before(entry->timestamp, cutoff)) {
+			xa_erase(xa, idx);
+			kfree(entry->data);
+			kfree(entry);
+		}
+	}
+}
+
+static void gpu_metrics_free_all(struct xarray *xa)
 {
+	struct gpu_metrics_snap_entry *entry;
+	unsigned long idx;
+
+	xa_for_each(xa, idx, entry) {
+		xa_erase(xa, idx);
+		kfree(entry->data);
+		kfree(entry);
+	}
+	xa_destroy(xa);
+}
+
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
+static ssize_t amdgpu_sysfs_gpu_metrics_read(struct file *f,
+					      struct kobject *kobj,
+					      const struct bin_attribute *attr,
+					      char *buf, loff_t off,
+					      size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	void *gpu_metrics;
-	ssize_t size = 0;
-	int ret;
+	unsigned long key = (unsigned long)f;
+	struct gpu_metrics_snap_entry *entry;
+	ssize_t ret;
 
-	ret = amdgpu_pm_get_access_if_active(adev);
-	if (ret)
-		return ret;
+	mutex_lock(&adev->pm.gpu_metrics_lock);
 
-	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
-	if (size <= 0)
-		goto out;
+	if (off == 0) {
+		void *metrics;
+		void *old;
+		int len;
 
-	if (size >= PAGE_SIZE)
-		size = PAGE_SIZE - 1;
+		/* Evict stale entries from readers that never hit EOF */
+		gpu_metrics_evict_stale_locked(&adev->pm.gpu_metrics_readers,
+					       key);
 
-	memcpy(buf, gpu_metrics, size);
+		ret = amdgpu_pm_get_access(adev);
+		if (ret)
+			goto out_unlock;
 
-out:
-	amdgpu_pm_put_access(adev);
+		len = amdgpu_dpm_get_gpu_metrics(adev, &metrics);
+		amdgpu_pm_put_access(adev);
 
-	return size;
+		if (len <= 0) {
+			ret = len;
+			goto out_unlock;
+		}
+
+		if (WARN_ON_ONCE(len > AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ)) {
+			ret = -EOVERFLOW;
+			goto out_unlock;
+		}
+
+		entry = xa_load(&adev->pm.gpu_metrics_readers, key);
+		if (!entry) {
+			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+			if (!entry) {
+				ret = -ENOMEM;
+				goto out_unlock;
+			}
+			old = xa_store(&adev->pm.gpu_metrics_readers, key,
+				       entry, GFP_KERNEL);
+			if (xa_is_err(old)) {
+				kfree(entry);
+				ret = xa_err(old);
+				goto out_unlock;
+			}
+		}
+
+		/* (Re-)allocate snapshot buffer sized to actual payload */
+		kfree(entry->data);
+		entry->data = kmemdup(metrics, len, GFP_KERNEL);
+		if (!entry->data) {
+			xa_erase(&adev->pm.gpu_metrics_readers, key);
+			kfree(entry);
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+		entry->size = len;
+		entry->timestamp = ktime_get();
+	} else {
+		entry = xa_load(&adev->pm.gpu_metrics_readers, key);
+		if (!entry) {
+			ret = -EIO;
+			goto out_unlock;
+		}
+	}
+
+	if (off >= entry->size) {
+		xa_erase(&adev->pm.gpu_metrics_readers, key);
+		kfree(entry->data);
+		kfree(entry);
+		ret = 0;
+		goto out_unlock;
+	}
+
+	count = min_t(size_t, count, entry->size - off);
+	memcpy(buf, (u8 *)entry->data + off, count);
+	ret = count;
+
+out_unlock:
+	mutex_unlock(&adev->pm.gpu_metrics_lock);
+	return ret;
 }
 
+static const BIN_ATTR(gpu_metrics, 0444, amdgpu_sysfs_gpu_metrics_read, NULL,
+		      AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ);
+
 static int amdgpu_show_powershift_percent(struct device *dev,
 					char *buf, enum amd_pp_sensors sensor)
 {
@@ -2579,7 +2717,6 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(apu_thermal_cap,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,			ATTR_FLAG_BASIC,
 			      .attr_update = ss_power_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,			ATTR_FLAG_BASIC,
@@ -2657,9 +2794,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		     gc_ver != IP_VERSION(9, 4, 3)) ||
 		    gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
-		if (gc_ver < IP_VERSION(9, 1, 0))
-			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
@@ -4755,6 +4889,19 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	if (ret)
 		goto err_out0;
 
+	if (amdgpu_pm_gpu_metrics_bin_visible(adev, mask)) {
+		mutex_init(&adev->pm.gpu_metrics_lock);
+		xa_init(&adev->pm.gpu_metrics_readers);
+		ret = sysfs_create_bin_file(&adev->dev->kobj,
+					    &bin_attr_gpu_metrics);
+		if (ret) {
+			xa_destroy(&adev->pm.gpu_metrics_readers);
+			mutex_destroy(&adev->pm.gpu_metrics_lock);
+			goto err_out1;
+		}
+		adev->pm.gpu_metrics_bin_registered = true;
+	}
+
 	if (amdgpu_dpm_is_overdrive_supported(adev)) {
 		ret = amdgpu_od_set_init(adev);
 		if (ret)
@@ -4806,6 +4953,12 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	return 0;
 
 err_out1:
+	if (adev->pm.gpu_metrics_bin_registered) {
+		sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_gpu_metrics);
+		gpu_metrics_free_all(&adev->pm.gpu_metrics_readers);
+		mutex_destroy(&adev->pm.gpu_metrics_lock);
+		adev->pm.gpu_metrics_bin_registered = false;
+	}
 	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
 err_out0:
 	if (adev->pm.int_hwmon_dev)
@@ -4821,6 +4974,13 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
 
+	if (adev->pm.gpu_metrics_bin_registered) {
+		sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_gpu_metrics);
+		gpu_metrics_free_all(&adev->pm.gpu_metrics_readers);
+		mutex_destroy(&adev->pm.gpu_metrics_lock);
+		adev->pm.gpu_metrics_bin_registered = false;
+	}
+
 	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index aa3f427819a0..3677a4f543fb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -349,6 +349,10 @@ struct amdgpu_pm {
 	/* dpm */
 	bool                    dpm_enabled;
 	bool                    sysfs_initialized;
+	bool                    gpu_metrics_bin_registered;
+	struct mutex            gpu_metrics_lock;
+	/* per-reader snapshot entries, keyed by (unsigned long)struct file * */
+	struct xarray           gpu_metrics_readers;
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

