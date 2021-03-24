Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CFAC433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 13:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF3B619E5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 13:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF3B619E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E147C6E9F6;
	Wed, 24 Mar 2021 13:05:14 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B7516E994;
 Wed, 24 Mar 2021 09:17:14 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F52cb5wnqzPlhs;
 Wed, 24 Mar 2021 17:14:39 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 17:17:07 +0800
From: Tian Tao <tiantao6@hisilicon.com>
To: <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH drm/amdgpu 1/2] drm/amdgpu: Convert sysfs sprintf/snprintf
 family to sysfs_emit
Date: Wed, 24 Mar 2021 17:17:40 +0800
Message-ID: <1616577461-18556-2-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616577461-18556-1-git-send-email-tiantao6@hisilicon.com>
References: <1616577461-18556-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 24 Mar 2021 13:05:10 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following coccicheck warning:
drivers/gpu//drm/amd/amdgpu/amdgpu_ras.c:434:9-17: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_xgmi.c:220:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_xgmi.c:249:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/df_v3_6.c:208:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_psp.c:2973:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_vram_mgr.c:75:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_vram_mgr.c:112:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_vram_mgr.c:58:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_vram_mgr.c:93:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_vram_mgr.c:125:9-17: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_gtt_mgr.c:52:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_gtt_mgr.c:71:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_device.c:140:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_device.c:164:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_device.c:186:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_device.c:208:8-16: WARNING:
use scnprintf or sprintf
drivers/gpu//drm/amd/amdgpu/amdgpu_atombios.c:1916:8-16: WARNING:
use scnprintf or sprintf

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 32 +++++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c         |  2 +-
 8 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 86add0f..5b04bfcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1947,7 +1947,7 @@ static ssize_t amdgpu_atombios_get_vbios_version(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct atom_context *ctx = adev->mode_info.atom_context;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctx->vbios_version);
+	return sysfs_emit(buf, "%s\n", ctx->vbios_version);
 }
 
 static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_version,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6447cd6..33b6e46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -136,7 +136,7 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	uint64_t cnt = amdgpu_asic_get_pcie_replay_count(adev);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cnt);
+	return sysfs_emit(buf, "%llu\n", cnt);
 }
 
 static DEVICE_ATTR(pcie_replay_count, S_IRUGO,
@@ -160,7 +160,7 @@ static ssize_t amdgpu_device_get_product_name(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", adev->product_name);
+	return sysfs_emit(buf, "%s\n", adev->product_name);
 }
 
 static DEVICE_ATTR(product_name, S_IRUGO,
@@ -182,7 +182,7 @@ static ssize_t amdgpu_device_get_product_number(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", adev->product_number);
+	return sysfs_emit(buf, "%s\n", adev->product_number);
 }
 
 static DEVICE_ATTR(product_number, S_IRUGO,
@@ -204,7 +204,7 @@ static ssize_t amdgpu_device_get_serial_number(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
+	return sysfs_emit(buf, "%s\n", adev->serial);
 }
 
 static DEVICE_ATTR(serial_number, S_IRUGO,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 8980329..540c010 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -49,8 +49,7 @@ static ssize_t amdgpu_mem_info_gtt_total_show(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
-			man->size * PAGE_SIZE);
+	return sysfs_emit(buf, "%llu\n", man->size * PAGE_SIZE);
 }
 
 /**
@@ -68,8 +67,7 @@ static ssize_t amdgpu_mem_info_gtt_used_show(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
-			amdgpu_gtt_mgr_usage(man));
+	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
 }
 
 static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 839917e..65b1df3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2916,7 +2916,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 		return ret;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", fw_ver);
+	return sysfs_emit(buf, "%x\n", fw_ver);
 }
 
 static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1fb2a91..b319b05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -431,15 +431,13 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 	};
 
 	if (!amdgpu_ras_get_error_query_ready(obj->adev))
-		return snprintf(buf, PAGE_SIZE,
-				"Query currently inaccessible\n");
+		return sysfs_emit(buf, "Query currently inaccessible\n");
 
 	if (amdgpu_ras_error_query(obj->adev, &info))
 		return -EINVAL;
 
-	return snprintf(buf, PAGE_SIZE, "%s: %lu\n%s: %lu\n",
-			"ue", info.ue_count,
-			"ce", info.ce_count);
+	return sysfs_emit(buf, "%s: %lu\n%s: %lu\n", "ue", info.ue_count,
+			  "ce", info.ce_count);
 }
 
 /* obj begin */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index c89b66b..ba3b297 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -52,7 +52,7 @@ static ssize_t amdgpu_mem_info_vram_total_show(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", adev->gmc.real_vram_size);
+	return sysfs_emit(buf, "%llu\n", adev->gmc.real_vram_size);
 }
 
 /**
@@ -69,7 +69,7 @@ static ssize_t amdgpu_mem_info_vis_vram_total_show(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", adev->gmc.visible_vram_size);
+	return sysfs_emit(buf, "%llu\n", adev->gmc.visible_vram_size);
 }
 
 /**
@@ -87,8 +87,7 @@ static ssize_t amdgpu_mem_info_vram_used_show(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
-			amdgpu_vram_mgr_usage(man));
+	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_usage(man));
 }
 
 /**
@@ -106,8 +105,7 @@ static ssize_t amdgpu_mem_info_vis_vram_used_show(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
-			amdgpu_vram_mgr_vis_usage(man));
+	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_vis_usage(man));
 }
 
 static ssize_t amdgpu_mem_info_vram_vendor(struct device *dev,
@@ -119,27 +117,27 @@ static ssize_t amdgpu_mem_info_vram_vendor(struct device *dev,
 
 	switch (adev->gmc.vram_vendor) {
 	case SAMSUNG:
-		return snprintf(buf, PAGE_SIZE, "samsung\n");
+		return sysfs_emit(buf, "samsung\n");
 	case INFINEON:
-		return snprintf(buf, PAGE_SIZE, "infineon\n");
+		return sysfs_emit(buf, "infineon\n");
 	case ELPIDA:
-		return snprintf(buf, PAGE_SIZE, "elpida\n");
+		return sysfs_emit(buf, "elpida\n");
 	case ETRON:
-		return snprintf(buf, PAGE_SIZE, "etron\n");
+		return sysfs_emit(buf, "etron\n");
 	case NANYA:
-		return snprintf(buf, PAGE_SIZE, "nanya\n");
+		return sysfs_emit(buf, "nanya\n");
 	case HYNIX:
-		return snprintf(buf, PAGE_SIZE, "hynix\n");
+		return sysfs_emit(buf, "hynix\n");
 	case MOSEL:
-		return snprintf(buf, PAGE_SIZE, "mosel\n");
+		return sysfs_emit(buf, "mosel\n");
 	case WINBOND:
-		return snprintf(buf, PAGE_SIZE, "winbond\n");
+		return sysfs_emit(buf, "winbond\n");
 	case ESMT:
-		return snprintf(buf, PAGE_SIZE, "esmt\n");
+		return sysfs_emit(buf, "esmt\n");
 	case MICRON:
-		return snprintf(buf, PAGE_SIZE, "micron\n");
+		return sysfs_emit(buf, "micron\n");
 	default:
-		return snprintf(buf, PAGE_SIZE, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 659b385..3d77fb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -217,7 +217,7 @@ static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", adev->gmc.xgmi.node_id);
+	return sysfs_emit(buf, "%llu\n", adev->gmc.xgmi.node_id);
 
 }
 
@@ -246,7 +246,7 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 
 	adev->df.funcs->set_fica(adev, ficaa_pie_status_in, 0, 0);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", error_count);
+	return sysfs_emit(buf, "%u\n", error_count);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 6b4b30a..40ef57b 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -205,7 +205,7 @@ static ssize_t df_v3_6_get_df_cntr_avail(struct device *dev,
 			count++;
 	}
 
-	return snprintf(buf, PAGE_SIZE,	"%i\n", count);
+	return sysfs_emit(buf, "%i\n", count);
 }
 
 /* device attr for available perfmon counters */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
