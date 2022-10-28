Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7274C38A02
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 08:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91BE10E148;
	Mon, 31 Oct 2022 08:14:37 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF5110E8F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 22:48:21 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id p21so2178843plr.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8LWoRkfSMU+CJ60Tm7wanIclajGSfZYvjPsATtyTB9c=;
 b=kEf8pkaqDLyKKPRro1RzlspOqf9bDj9K9tXuJIfimPasVBVuSbh3nXFfHuKj3Ygv/e
 Cb2woLyV/0T4hlBWtL+deoHGD9VfD6aKyLYcAQxvNFDXlnQhUFE87y+LQpwOsBtmz5z0
 nYqVpW7KVwrtYp/ANLZ6FHgmzrBkDHxNW5lig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8LWoRkfSMU+CJ60Tm7wanIclajGSfZYvjPsATtyTB9c=;
 b=AO5PHVl8T+O1SB1WZOFpilXIkjFGo//qtm+tU2/dfB5Mb4PO1JUCYcAX/dRK2E+U3Y
 /CogZ/wdjDlEbh/yH7mc54haBuBtOWb9kc1kCWFH8XqGX+tzkVX2I78mJpGWwyzXQ5GA
 beSdoKE1+1BTy/dK+Iz40w4Lpi9Elc7+PvaStbpXLltZR4xzZcVxbHhlScmbpTsq5+bV
 2ukF4VGPX7dEmdtFXJMyZWpLUdRWeUi1R49LNXVolHKOKCR6whFwH6c54kdajQu8yDPa
 qhi44bmCq9LJEDT65bTj4oN/naMeHVQIpbVduEbp52RHllfL8iiyP4v6kXMTmNuKR6uN
 uv4g==
X-Gm-Message-State: ACrzQf0oZJVpjC2Kcms/ewjlhI+6e76Q+layUwbpP872MbeKSa+moCdd
 ocv+SH+JI5+fKRXdeCkKUCfahw==
X-Google-Smtp-Source: AMsMyM55Sd5sOvrhwfrL/VW2HDZO143InZb28UjVPt6odCwiOqgaUH7lbfeXhLdju9NuiBJ7Ch77ng==
X-Received: by 2002:a17:90a:c78a:b0:212:e56b:2b17 with SMTP id
 gn10-20020a17090ac78a00b00212e56b2b17mr1623176pjb.51.1666997300703; 
 Fri, 28 Oct 2022 15:48:20 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
 by smtp.gmail.com with UTF8SMTPSA id
 1-20020a17090a0e8100b002009db534d1sm3010415pjx.24.2022.10.28.15.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Oct 2022 15:48:20 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui  <Xinhui.Pan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Move racy global PMU list into device
Date: Fri, 28 Oct 2022 15:48:12 -0700
Message-Id: <20221028224813.1466450-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Oct 2022 08:14:28 +0000
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
Cc: Brian Norris <briannorris@chromium.org>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If there are multiple amdgpu devices, this list processing can be racy.

We're really treating this like a per-device list, so make that explicit
and remove the global list.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 12 +++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0e6ddf05c23c..e968b7f2417c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1063,6 +1063,10 @@ struct amdgpu_device {
 	struct work_struct		reset_work;
 
 	bool                            job_hang;
+
+#if IS_ENABLED(CONFIG_PERF_EVENTS)
+	struct list_head pmu_list;
+#endif
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 71ee361d0972..24f2055a2f23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -23,6 +23,7 @@
 
 #include <linux/perf_event.h>
 #include <linux/init.h>
+#include <linux/list.h>
 #include "amdgpu.h"
 #include "amdgpu_pmu.h"
 
@@ -72,9 +73,6 @@ static ssize_t amdgpu_pmu_event_show(struct device *dev,
 			amdgpu_pmu_attr->event_str, amdgpu_pmu_attr->type);
 }
 
-static LIST_HEAD(amdgpu_pmu_list);
-
-
 struct amdgpu_pmu_attr {
 	const char *name;
 	const char *config;
@@ -558,7 +556,7 @@ static int init_pmu_entry_by_type_and_add(struct amdgpu_pmu_entry *pmu_entry,
 		pr_info("Detected AMDGPU %d Perf Events.\n", total_num_events);
 
 
-	list_add_tail(&pmu_entry->entry, &amdgpu_pmu_list);
+	list_add_tail(&pmu_entry->entry, &pmu_entry->adev->pmu_list);
 
 	return 0;
 err_register:
@@ -579,9 +577,7 @@ void amdgpu_pmu_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_pmu_entry *pe, *temp;
 
-	list_for_each_entry_safe(pe, temp, &amdgpu_pmu_list, entry) {
-		if (pe->adev != adev)
-			continue;
+	list_for_each_entry_safe(pe, temp, &adev->pmu_list, entry) {
 		list_del(&pe->entry);
 		perf_pmu_unregister(&pe->pmu);
 		kfree(pe->pmu.attr_groups);
@@ -623,6 +619,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 	int ret = 0;
 	struct amdgpu_pmu_entry *pmu_entry, *pmu_entry_df;
 
+	INIT_LIST_HEAD(&adev->pmu_list);
+
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
 		pmu_entry_df = create_pmu_entry(adev, AMDGPU_PMU_PERF_TYPE_DF,
-- 
2.38.1.273.g43a17bfeac-goog

