Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B17C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 20:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519E420756
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 20:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPn9auil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519E420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D510D6E262;
	Thu, 21 May 2020 20:23:20 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8776E241
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 20:23:19 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id m11so8630745qka.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uhAtqIDWDe4d391UYshe9VyhSLKFnIhIgcGpRgH41PA=;
 b=EPn9auilSrnvd5XW8XbkT4hKp3nKMmIq1ykTj9nRS5vCP6H2VOyK2YTexotosAPrJD
 0SJHU0Zmdzs0iZpfYLU1mrfIq6weFPEsBiLGO33hS/x9PyYCyQxf4zjCM09mpbW7h8eI
 ovEIgqFQEjVEHm55EZ1/weKbGMXKPLy1QmljYUxv0ydxeMnTbG4KNGoX3sSoEfLw+xgm
 xUHq+XapTlcOC0WH+898LgK34cX875uJkYzbFkf4SZb+pmS5Y4lDDmUCOpsdt+jB9y4Y
 QIFK9+JQUzg1Z+qAcWeg21W5vh+lgFIUW+J+e5knf4L49EcRsebD4h7yAecgoD73Z+k/
 TURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uhAtqIDWDe4d391UYshe9VyhSLKFnIhIgcGpRgH41PA=;
 b=YvXuK+RCT3BdD3ZHxOE45aPk6Ggm273S2keps6OsMhYoLf1M02s1A3vw01oHG/dL0Y
 zIQ1mfr42YSyBM0jdOmtLfoYjlBHMs8PlQapEO7n7tdwBD6IqjvBi1ud02G5SqMc4ai9
 tH5ThqC1pNibh6VCmRVPEuDhsDPDe9rwn7pnbpbhUhj6izFc8ChGz20yWrhon7+IvSg1
 xWQwjCTVcYTC6qNIY4aBThHLGIIagc7g92D0OLyaB9ERRskqx+8IeSpTGZLFXuH2jPfY
 OwxR3PQet7hNe8LoZ9ct06aV2G+y3LoVrhgZYPXeaO3oJnZGidJ3IH5wdwdX9ccD/pll
 h1mg==
X-Gm-Message-State: AOAM532C4XwATDnBr5ipIGZ23IpZFLtDSXdiqQhpB/H2XiOs/owQ0sHn
 VselBCiRN/pt5MD8cKMDD1AhGZUF
X-Google-Smtp-Source: ABdhPJyJ4F5JWZHJuHbONglyHJCekRiZuJ2SqoL9YCH4fbh5RTAtKGRyg4ZSoqNuxZXUri7uOcE+Ag==
X-Received: by 2002:a37:9b83:: with SMTP id
 d125mr11307492qke.289.1590092597784; 
 Thu, 21 May 2020 13:23:17 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t130sm5543470qka.14.2020.05.21.13.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 13:23:17 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] Revert "drm/amdgpu: optimize amdgpu device attribute code"
Date: Thu, 21 May 2020 16:23:08 -0400
Message-Id: <20200521202308.1996496-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200521202308.1996496-1-alexander.deucher@amd.com>
References: <20200521202308.1996496-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 3fc62b9b9cfed72fd7acf2f594c9a4930dbc0467.

This breaks multi-GPU.  Since the attribute array is global
whatever gets set for the first device more or less ends up
what gets set all the other GPUs in the system.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 494 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h |  46 ---
 2 files changed, 278 insertions(+), 262 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 63e3e6534913..3c8c56d0dbd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -154,9 +154,9 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
  *
  */
 
-static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
+static ssize_t amdgpu_get_dpm_state(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
@@ -189,10 +189,10 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 			(pm == POWER_STATE_TYPE_BALANCED) ? "balanced" : "performance");
 }
 
-static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf,
-					  size_t count)
+static ssize_t amdgpu_set_dpm_state(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
@@ -294,9 +294,9 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
  *
  */
 
-static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
-							    struct device_attribute *attr,
-							    char *buf)
+static ssize_t amdgpu_get_dpm_forced_performance_level(struct device *dev,
+						struct device_attribute *attr,
+								char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
@@ -332,10 +332,10 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 			"unknown");
 }
 
-static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
-							    struct device_attribute *attr,
-							    const char *buf,
-							    size_t count)
+static ssize_t amdgpu_set_dpm_forced_performance_level(struct device *dev,
+						       struct device_attribute *attr,
+						       const char *buf,
+						       size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
@@ -873,10 +873,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
  * the corresponding bit from original ppfeature masks and input the
  * new ppfeature masks.
  */
-static ssize_t amdgpu_set_pp_features(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf,
-				      size_t count)
+static ssize_t amdgpu_set_pp_feature_status(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
@@ -917,9 +917,9 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	return count;
 }
 
-static ssize_t amdgpu_get_pp_features(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
+static ssize_t amdgpu_get_pp_feature_status(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
@@ -1663,9 +1663,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
  * The SMU firmware computes a percentage of load based on the
  * aggregate activity level in the IP cores.
  */
-static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t amdgpu_get_busy_percent(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
@@ -1699,9 +1699,9 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
  * The SMU firmware computes a percentage of load based on the
  * aggregate activity level in the IP cores.
  */
-static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t amdgpu_get_memory_busy_percent(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
@@ -1796,174 +1796,57 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	return 0;
 }
 
-static struct amdgpu_device_attr amdgpu_device_attrs[] = {
-	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC),
-};
-
-static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-			       uint32_t mask)
-{
-	struct device_attribute *dev_attr = &attr->dev_attr;
-	const char *attr_name = dev_attr->attr.name;
-	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
-	enum amd_asic_type asic_type = adev->asic_type;
-
-	if (!(attr->flags & mask)) {
-		attr->states = ATTR_STATE_UNSUPPORTED;
-		return 0;
-	}
-
-#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
-
-	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
-		if (asic_type <= CHIP_VEGA10)
-			attr->states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-		if (asic_type <= CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
-			attr->states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
-		if (asic_type < CHIP_VEGA20)
-			attr->states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
-		if (asic_type == CHIP_ARCTURUS)
-			attr->states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
-		attr->states = ATTR_STATE_UNSUPPORTED;
-		if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
-		    (!is_support_sw_smu(adev) && hwmgr->od_enabled))
-			attr->states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
-		if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
-			attr->states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pcie_bw)) {
-		/* PCIe Perf counters won't work on APU nodes */
-		if (adev->flags & AMD_IS_APU)
-			attr->states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(unique_id)) {
-		if (!adev->unique_id)
-			attr->states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_features)) {
-		if (adev->flags & AMD_IS_APU || asic_type <= CHIP_VEGA10)
-			attr->states = ATTR_STATE_UNSUPPORTED;
-	}
-
-	if (asic_type == CHIP_ARCTURUS) {
-		/* Arcturus does not support standalone mclk/socclk/fclk level setting */
-		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
-		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
-		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
-			dev_attr->attr.mode &= ~S_IWUGO;
-			dev_attr->store = NULL;
-		}
-	}
-
-#undef DEVICE_ATTR_IS
-
-	return 0;
-}
-
-
-static int amdgpu_device_attr_create(struct amdgpu_device *adev,
-				     struct amdgpu_device_attr *attr,
-				     uint32_t mask)
-{
-	int ret = 0;
-	struct device_attribute *dev_attr = &attr->dev_attr;
-	const char *name = dev_attr->attr.name;
-	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-			   uint32_t mask) = default_attr_update;
-
-	BUG_ON(!attr);
-
-	attr_update = attr->attr_update ? attr_update : default_attr_update;
-
-	ret = attr_update(adev, attr, mask);
-	if (ret) {
-		dev_err(adev->dev, "failed to update device file %s, ret = %d\n",
-			name, ret);
-		return ret;
-	}
-
-	/* the attr->states maybe changed after call attr->attr_update function */
-	if (attr->states == ATTR_STATE_UNSUPPORTED)
-		return 0;
-
-	ret = device_create_file(adev->dev, dev_attr);
-	if (ret) {
-		dev_err(adev->dev, "failed to create device file %s, ret = %d\n",
-			name, ret);
-	}
-
-	attr->states = ATTR_STATE_SUPPORTED;
-
-	return ret;
-}
-
-static void amdgpu_device_attr_remove(struct amdgpu_device *adev, struct amdgpu_device_attr *attr)
-{
-	struct device_attribute *dev_attr = &attr->dev_attr;
-
-	if (attr->states == ATTR_STATE_UNSUPPORTED)
-		return;
-
-	device_remove_file(adev->dev, dev_attr);
-
-	attr->states = ATTR_STATE_UNSUPPORTED;
-}
-
-static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
-					    struct amdgpu_device_attr *attrs,
-					    uint32_t counts,
-					    uint32_t mask)
-{
-	int ret = 0;
-	uint32_t i = 0;
-
-	for (i = 0; i < counts; i++) {
-		ret = amdgpu_device_attr_create(adev, &attrs[i], mask);
-		if (ret)
-			goto failed;
-	}
-
-	return 0;
-
-failed:
-	for (; i > 0; i--) {
-		amdgpu_device_attr_remove(adev, &attrs[i]);
-	}
-
-	return ret;
-}
-
-static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
-					     struct amdgpu_device_attr *attrs,
-					     uint32_t counts)
-{
-	uint32_t i = 0;
-
-	for (i = 0; i < counts; i++)
-		amdgpu_device_attr_remove(adev, &attrs[i]);
-}
+static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR, amdgpu_get_dpm_state, amdgpu_set_dpm_state);
+static DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_IWUSR,
+		   amdgpu_get_dpm_forced_performance_level,
+		   amdgpu_set_dpm_forced_performance_level);
+static DEVICE_ATTR(pp_num_states, S_IRUGO, amdgpu_get_pp_num_states, NULL);
+static DEVICE_ATTR(pp_cur_state, S_IRUGO, amdgpu_get_pp_cur_state, NULL);
+static DEVICE_ATTR(pp_force_state, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_force_state,
+		amdgpu_set_pp_force_state);
+static DEVICE_ATTR(pp_table, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_table,
+		amdgpu_set_pp_table);
+static DEVICE_ATTR(pp_dpm_sclk, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_dpm_sclk,
+		amdgpu_set_pp_dpm_sclk);
+static DEVICE_ATTR(pp_dpm_mclk, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_dpm_mclk,
+		amdgpu_set_pp_dpm_mclk);
+static DEVICE_ATTR(pp_dpm_socclk, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_dpm_socclk,
+		amdgpu_set_pp_dpm_socclk);
+static DEVICE_ATTR(pp_dpm_fclk, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_dpm_fclk,
+		amdgpu_set_pp_dpm_fclk);
+static DEVICE_ATTR(pp_dpm_dcefclk, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_dpm_dcefclk,
+		amdgpu_set_pp_dpm_dcefclk);
+static DEVICE_ATTR(pp_dpm_pcie, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_dpm_pcie,
+		amdgpu_set_pp_dpm_pcie);
+static DEVICE_ATTR(pp_sclk_od, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_sclk_od,
+		amdgpu_set_pp_sclk_od);
+static DEVICE_ATTR(pp_mclk_od, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_mclk_od,
+		amdgpu_set_pp_mclk_od);
+static DEVICE_ATTR(pp_power_profile_mode, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_power_profile_mode,
+		amdgpu_set_pp_power_profile_mode);
+static DEVICE_ATTR(pp_od_clk_voltage, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_od_clk_voltage,
+		amdgpu_set_pp_od_clk_voltage);
+static DEVICE_ATTR(gpu_busy_percent, S_IRUGO,
+		amdgpu_get_busy_percent, NULL);
+static DEVICE_ATTR(mem_busy_percent, S_IRUGO,
+		amdgpu_get_memory_busy_percent, NULL);
+static DEVICE_ATTR(pcie_bw, S_IRUGO, amdgpu_get_pcie_bw, NULL);
+static DEVICE_ATTR(pp_features, S_IRUGO | S_IWUSR,
+		amdgpu_get_pp_feature_status,
+		amdgpu_set_pp_feature_status);
+static DEVICE_ATTR(unique_id, S_IRUGO, amdgpu_get_unique_id, NULL);
 
 static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 				      struct device_attribute *attr,
@@ -3364,8 +3247,8 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 {
+	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 	int ret;
-	uint32_t mask = 0;
 
 	if (adev->pm.sysfs_initialized)
 		return 0;
@@ -3383,25 +3266,168 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		return ret;
 	}
 
-	switch (amdgpu_virt_get_sriov_vf_mode(adev)) {
-	case SRIOV_VF_MODE_ONE_VF:
-		mask = ATTR_FLAG_ONEVF;
-		break;
-	case SRIOV_VF_MODE_MULTI_VF:
-		mask = 0;
-		break;
-	case SRIOV_VF_MODE_BARE_METAL:
-	default:
-		mask = ATTR_FLAG_MASK_ALL;
-		break;
+	ret = device_create_file(adev->dev, &dev_attr_power_dpm_state);
+	if (ret) {
+		DRM_ERROR("failed to create device file for dpm state\n");
+		return ret;
+	}
+	ret = device_create_file(adev->dev, &dev_attr_power_dpm_force_performance_level);
+	if (ret) {
+		DRM_ERROR("failed to create device file for dpm state\n");
+		return ret;
 	}
 
-	ret = amdgpu_device_attr_create_groups(adev,
-					       amdgpu_device_attrs,
-					       ARRAY_SIZE(amdgpu_device_attrs),
-					       mask);
-	if (ret)
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = device_create_file(adev->dev, &dev_attr_pp_num_states);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_num_states\n");
+			return ret;
+		}
+		ret = device_create_file(adev->dev, &dev_attr_pp_cur_state);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_cur_state\n");
+			return ret;
+		}
+		ret = device_create_file(adev->dev, &dev_attr_pp_force_state);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_force_state\n");
+			return ret;
+		}
+		ret = device_create_file(adev->dev, &dev_attr_pp_table);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_table\n");
+			return ret;
+		}
+	}
+
+	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
+	if (ret) {
+		DRM_ERROR("failed to create device file pp_dpm_sclk\n");
 		return ret;
+	}
+
+	/* Arcturus does not support standalone mclk/socclk/fclk level setting */
+	if (adev->asic_type == CHIP_ARCTURUS) {
+		dev_attr_pp_dpm_mclk.attr.mode &= ~S_IWUGO;
+		dev_attr_pp_dpm_mclk.store = NULL;
+
+		dev_attr_pp_dpm_socclk.attr.mode &= ~S_IWUGO;
+		dev_attr_pp_dpm_socclk.store = NULL;
+
+		dev_attr_pp_dpm_fclk.attr.mode &= ~S_IWUGO;
+		dev_attr_pp_dpm_fclk.store = NULL;
+	}
+
+	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_mclk);
+	if (ret) {
+		DRM_ERROR("failed to create device file pp_dpm_mclk\n");
+		return ret;
+	}
+	if (adev->asic_type >= CHIP_VEGA10) {
+		ret = device_create_file(adev->dev, &dev_attr_pp_dpm_socclk);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_dpm_socclk\n");
+			return ret;
+		}
+		if (adev->asic_type != CHIP_ARCTURUS) {
+			ret = device_create_file(adev->dev, &dev_attr_pp_dpm_dcefclk);
+			if (ret) {
+				DRM_ERROR("failed to create device file pp_dpm_dcefclk\n");
+				return ret;
+			}
+		}
+	}
+	if (adev->asic_type >= CHIP_VEGA20) {
+		ret = device_create_file(adev->dev, &dev_attr_pp_dpm_fclk);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_dpm_fclk\n");
+			return ret;
+		}
+	}
+
+	/* the reset are not needed for SRIOV one vf mode */
+	if (amdgpu_sriov_vf(adev)) {
+		adev->pm.sysfs_initialized = true;
+		return ret;
+	}
+
+	if (adev->asic_type != CHIP_ARCTURUS) {
+		ret = device_create_file(adev->dev, &dev_attr_pp_dpm_pcie);
+		if (ret) {
+			DRM_ERROR("failed to create device file pp_dpm_pcie\n");
+			return ret;
+		}
+	}
+	ret = device_create_file(adev->dev, &dev_attr_pp_sclk_od);
+	if (ret) {
+		DRM_ERROR("failed to create device file pp_sclk_od\n");
+		return ret;
+	}
+	ret = device_create_file(adev->dev, &dev_attr_pp_mclk_od);
+	if (ret) {
+		DRM_ERROR("failed to create device file pp_mclk_od\n");
+		return ret;
+	}
+	ret = device_create_file(adev->dev,
+			&dev_attr_pp_power_profile_mode);
+	if (ret) {
+		DRM_ERROR("failed to create device file	"
+				"pp_power_profile_mode\n");
+		return ret;
+	}
+	if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
+	    (!is_support_sw_smu(adev) && hwmgr->od_enabled)) {
+		ret = device_create_file(adev->dev,
+				&dev_attr_pp_od_clk_voltage);
+		if (ret) {
+			DRM_ERROR("failed to create device file	"
+					"pp_od_clk_voltage\n");
+			return ret;
+		}
+	}
+	ret = device_create_file(adev->dev,
+			&dev_attr_gpu_busy_percent);
+	if (ret) {
+		DRM_ERROR("failed to create device file	"
+				"gpu_busy_level\n");
+		return ret;
+	}
+	/* APU does not have its own dedicated memory */
+	if (!(adev->flags & AMD_IS_APU) &&
+	     (adev->asic_type != CHIP_VEGA10)) {
+		ret = device_create_file(adev->dev,
+				&dev_attr_mem_busy_percent);
+		if (ret) {
+			DRM_ERROR("failed to create device file	"
+					"mem_busy_percent\n");
+			return ret;
+		}
+	}
+	/* PCIe Perf counters won't work on APU nodes */
+	if (!(adev->flags & AMD_IS_APU)) {
+		ret = device_create_file(adev->dev, &dev_attr_pcie_bw);
+		if (ret) {
+			DRM_ERROR("failed to create device file pcie_bw\n");
+			return ret;
+		}
+	}
+	if (adev->unique_id)
+		ret = device_create_file(adev->dev, &dev_attr_unique_id);
+	if (ret) {
+		DRM_ERROR("failed to create device file unique_id\n");
+		return ret;
+	}
+
+	if ((adev->asic_type >= CHIP_VEGA10) &&
+	    !(adev->flags & AMD_IS_APU)) {
+		ret = device_create_file(adev->dev,
+				&dev_attr_pp_features);
+		if (ret) {
+			DRM_ERROR("failed to create device file	"
+					"pp_features\n");
+			return ret;
+		}
+	}
 
 	adev->pm.sysfs_initialized = true;
 
@@ -3410,15 +3436,51 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 {
+	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
+
 	if (adev->pm.dpm_enabled == 0)
 		return;
 
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
-
-	amdgpu_device_attr_remove_groups(adev,
-					 amdgpu_device_attrs,
-					 ARRAY_SIZE(amdgpu_device_attrs));
+	device_remove_file(adev->dev, &dev_attr_power_dpm_state);
+	device_remove_file(adev->dev, &dev_attr_power_dpm_force_performance_level);
+
+	device_remove_file(adev->dev, &dev_attr_pp_num_states);
+	device_remove_file(adev->dev, &dev_attr_pp_cur_state);
+	device_remove_file(adev->dev, &dev_attr_pp_force_state);
+	device_remove_file(adev->dev, &dev_attr_pp_table);
+
+	device_remove_file(adev->dev, &dev_attr_pp_dpm_sclk);
+	device_remove_file(adev->dev, &dev_attr_pp_dpm_mclk);
+	if (adev->asic_type >= CHIP_VEGA10) {
+		device_remove_file(adev->dev, &dev_attr_pp_dpm_socclk);
+		if (adev->asic_type != CHIP_ARCTURUS)
+			device_remove_file(adev->dev, &dev_attr_pp_dpm_dcefclk);
+	}
+	if (adev->asic_type != CHIP_ARCTURUS)
+		device_remove_file(adev->dev, &dev_attr_pp_dpm_pcie);
+	if (adev->asic_type >= CHIP_VEGA20)
+		device_remove_file(adev->dev, &dev_attr_pp_dpm_fclk);
+	device_remove_file(adev->dev, &dev_attr_pp_sclk_od);
+	device_remove_file(adev->dev, &dev_attr_pp_mclk_od);
+	device_remove_file(adev->dev,
+			&dev_attr_pp_power_profile_mode);
+	if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
+	    (!is_support_sw_smu(adev) && hwmgr->od_enabled))
+		device_remove_file(adev->dev,
+				&dev_attr_pp_od_clk_voltage);
+	device_remove_file(adev->dev, &dev_attr_gpu_busy_percent);
+	if (!(adev->flags & AMD_IS_APU) &&
+	     (adev->asic_type != CHIP_VEGA10))
+		device_remove_file(adev->dev, &dev_attr_mem_busy_percent);
+	if (!(adev->flags & AMD_IS_APU))
+		device_remove_file(adev->dev, &dev_attr_pcie_bw);
+	if (adev->unique_id)
+		device_remove_file(adev->dev, &dev_attr_unique_id);
+	if ((adev->asic_type >= CHIP_VEGA10) &&
+	    !(adev->flags & AMD_IS_APU))
+		device_remove_file(adev->dev, &dev_attr_pp_features);
 }
 
 void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
index 48e8086baf33..5db0ef86e84c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
@@ -30,52 +30,6 @@ struct cg_flag_name
 	const char *name;
 };
 
-enum amdgpu_device_attr_flags {
-	ATTR_FLAG_BASIC = (1 << 0),
-	ATTR_FLAG_ONEVF = (1 << 16),
-};
-
-#define ATTR_FLAG_TYPE_MASK	(0x0000ffff)
-#define ATTR_FLAG_MODE_MASK	(0xffff0000)
-#define ATTR_FLAG_MASK_ALL	(0xffffffff)
-
-enum amdgpu_device_attr_states {
-	ATTR_STATE_UNSUPPORTED = 0,
-	ATTR_STATE_SUPPORTED,
-};
-
-struct amdgpu_device_attr {
-	struct device_attribute dev_attr;
-	enum amdgpu_device_attr_flags flags;
-	enum amdgpu_device_attr_states states;
-	int (*attr_update)(struct amdgpu_device *adev,
-			   struct amdgpu_device_attr* attr,
-			   uint32_t mask);
-};
-
-#define to_amdgpu_device_attr(_dev_attr) \
-	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
-
-#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
-	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
-	  .flags = _flags,						\
-	  .states = ATTR_STATE_SUPPORTED,					\
-	  ##__VA_ARGS__, }
-
-#define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)			\
-	__AMDGPU_DEVICE_ATTR(_name, _mode,				\
-			     amdgpu_get_##_name, amdgpu_set_##_name,	\
-			     _flags, ##__VA_ARGS__)
-
-#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)			\
-	AMDGPU_DEVICE_ATTR(_name, S_IRUGO | S_IWUSR,			\
-			   _flags, ##__VA_ARGS__)
-
-#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)			\
-	__AMDGPU_DEVICE_ATTR(_name, S_IRUGO,				\
-			     amdgpu_get_##_name, NULL,			\
-			     _flags, ##__VA_ARGS__)
-
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
 int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
