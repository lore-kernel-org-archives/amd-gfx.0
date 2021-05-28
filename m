Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A551C4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 07:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BF36113D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 07:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BF36113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF6C26E11A;
	Fri, 28 May 2021 07:41:57 +0000 (UTC)
X-Greylist: delayed 925 seconds by postgrey-1.36 at gabe;
 Fri, 28 May 2021 07:18:12 UTC
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EECA6F582;
 Fri, 28 May 2021 07:18:12 +0000 (UTC)
Received: from dggeml758-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FrwYH17c0zYqSB;
 Fri, 28 May 2021 15:00:03 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggeml758-chm.china.huawei.com (10.1.199.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 15:02:43 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 15:02:43 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH -next] drm/radeon/radeon_pm: use DEVICE_ATTR_RW macro
Date: Fri, 28 May 2021 15:02:17 +0800
Message-ID: <20210528070217.9204-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 28 May 2021 07:41:56 +0000
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
Cc: YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use DEVICE_ATTR_RW() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_pm.c | 56 ++++++++++++------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
index 3861c0b98fcf..edf10cc3947e 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -352,9 +352,8 @@ static void radeon_pm_print_states(struct radeon_device *rdev)
 	}
 }
 
-static ssize_t radeon_get_pm_profile(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
+static ssize_t power_profile_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -366,10 +365,8 @@ static ssize_t radeon_get_pm_profile(struct device *dev,
 			  (cp == PM_PROFILE_HIGH) ? "high" : "default");
 }
 
-static ssize_t radeon_set_pm_profile(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t count)
+static ssize_t power_profile_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -406,9 +403,8 @@ static ssize_t radeon_set_pm_profile(struct device *dev,
 	return count;
 }
 
-static ssize_t radeon_get_pm_method(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static ssize_t power_method_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -418,10 +414,9 @@ static ssize_t radeon_get_pm_method(struct device *dev,
 			  (pm == PM_METHOD_PROFILE) ? "profile" : "dpm");
 }
 
-static ssize_t radeon_set_pm_method(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t count)
+static ssize_t power_method_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -462,9 +457,8 @@ static ssize_t radeon_set_pm_method(struct device *dev,
 	return count;
 }
 
-static ssize_t radeon_get_dpm_state(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static ssize_t power_dpm_state_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -475,10 +469,9 @@ static ssize_t radeon_get_dpm_state(struct device *dev,
 			  (pm == POWER_STATE_TYPE_BALANCED) ? "balanced" : "performance");
 }
 
-static ssize_t radeon_set_dpm_state(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t count)
+static ssize_t power_dpm_state_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -506,9 +499,9 @@ static ssize_t radeon_set_dpm_state(struct device *dev,
 	return count;
 }
 
-static ssize_t radeon_get_dpm_forced_performance_level(struct device *dev,
-						       struct device_attribute *attr,
-						       char *buf)
+static ssize_t power_dpm_force_performance_level_show(struct device *dev,
+						      struct device_attribute *attr,
+						      char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -523,10 +516,9 @@ static ssize_t radeon_get_dpm_forced_performance_level(struct device *dev,
 			  (level == RADEON_DPM_FORCED_LEVEL_LOW) ? "low" : "high");
 }
 
-static ssize_t radeon_set_dpm_forced_performance_level(struct device *dev,
+static ssize_t power_dpm_force_performance_level_store(struct device *dev,
 						       struct device_attribute *attr,
-						       const char *buf,
-						       size_t count)
+						       const char *buf, size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct radeon_device *rdev = ddev->dev_private;
@@ -658,12 +650,10 @@ static ssize_t radeon_hwmon_get_pwm1(struct device *dev,
 	return sprintf(buf, "%i\n", speed);
 }
 
-static DEVICE_ATTR(power_profile, S_IRUGO | S_IWUSR, radeon_get_pm_profile, radeon_set_pm_profile);
-static DEVICE_ATTR(power_method, S_IRUGO | S_IWUSR, radeon_get_pm_method, radeon_set_pm_method);
-static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR, radeon_get_dpm_state, radeon_set_dpm_state);
-static DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_IWUSR,
-		   radeon_get_dpm_forced_performance_level,
-		   radeon_set_dpm_forced_performance_level);
+static DEVICE_ATTR_RW(power_profile);
+static DEVICE_ATTR_RW(power_method);
+static DEVICE_ATTR_RW(power_dpm_state);
+static DEVICE_ATTR_RW(power_dpm_force_performance_level);
 
 static ssize_t radeon_hwmon_show_temp(struct device *dev,
 				      struct device_attribute *attr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
