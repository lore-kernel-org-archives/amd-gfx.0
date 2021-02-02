Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7115BC433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 17:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216F364DDB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 17:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216F364DDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67F06E0D0;
	Tue,  2 Feb 2021 17:17:58 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705E56E0D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 17:17:58 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id a12so20509564qkh.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 09:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+7pWUJidEzuSGfkugZYMEWeHVXvnaEuVN9M1YyhBzgY=;
 b=Hk6gsg+KuwW922S3qKZJZJlWTVoIETwifL8077fisW3qglDQXu9umciDcRuUZ8WdKj
 J3iBekFi3W4aRePeUrizOqbCmNccspLMeg6CEy2zyESQyIcl9HY6tt7/s03HVYDBO5Mi
 aGBaLTZr6M93DCl2lik7OLKdDhFTLMRBn/E6rhpP6srelYjDhAuUWsLyxfsqrHTYAq+Z
 5uzAWQ198exIGCtk43usE0LFmyXj921myGX6+zHQS96xqULZDYkNXw6hneh42RWmiH2m
 Y0NoVomanMDS218WqWGfyWWRirbX/fE0ADkVfqNqGLB2Pq1G12eimLDLUq7D0iu41n8U
 8ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+7pWUJidEzuSGfkugZYMEWeHVXvnaEuVN9M1YyhBzgY=;
 b=gjTXHsAVml59ulx3MSQyUePbGYlb4ev3w5l0IhreqFtD0Ac3oLEi7zRWTelufmrRTm
 4DZJVnPYniFr4TWWya0r7JX4kVTNYY1eCLD89y7odZcymVg6WKVEQfbcL4yvjN56y140
 PTz7G+hDo6jSw/aYjlVpwbG8Z/qNtAelYO/rF/c32ogKMmbCzllv6+uHwBXy/5MU6a0+
 PEDDoETGg/8QrwnjKmW9wJMmg+Pbb454MlRKGnmA55ew3dbNzsU/ln96ixkSR2XsmgbC
 Nj9wGbw2kuOTq7yYflfTniO27N4tcxGN2ME3JU6qI7AyYeoyPY7KpclWNduBEv30ienW
 cYrg==
X-Gm-Message-State: AOAM531akKqsKUz2Ao1s4ZSN6SCiT3bH1MLyaDCP9z5hRY/D4WTHPfhq
 dMlUECxXu0+gA5joGxJqa5AMDojqi7E=
X-Google-Smtp-Source: ABdhPJxIqSSwiALdiAHjMda5y5jQELFfgfeJ+K7snH63qPkjpNYRSADocX/2XStVMwnwLGo891/f9g==
X-Received: by 2002:a05:620a:49:: with SMTP id
 t9mr23267919qkt.231.1612286277505; 
 Tue, 02 Feb 2021 09:17:57 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id q6sm9514981qkq.34.2021.02.02.09.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 09:17:57 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: add a dev_pm_ops prepare callback (v2)
Date: Tue,  2 Feb 2021 12:17:47 -0500
Message-Id: <20210202171748.1062530-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

as per:
https://www.kernel.org/doc/html/latest/driver-api/pm/devices.html

The prepare callback is required to support the DPM_FLAG_SMART_SUSPEND
driver flag.  This allows runtime pm to auto complete when the
system goes into suspend avoiding a wake up on suspend and on resume.
Apply this for hybrid gfx and BOCO systems where d3cold is
provided by the ACPI platform.

v2: check if device is runtime suspended in prepare.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 79608949e8e7..05ed82e4d805 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -36,6 +36,7 @@
 #include <linux/vga_switcheroo.h>
 #include <drm/drm_probe_helper.h>
 #include <linux/mmu_notifier.h>
+#include <linux/suspend.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
@@ -1271,6 +1272,27 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
 
+static int amdgpu_pmops_prepare(struct device *dev)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	/* Return a positive number here so
+	 * DPM_FLAG_SMART_SUSPEND works properly
+	 */
+	if ((amdgpu_device_supports_atpx(drm_dev) &&
+	    amdgpu_is_atpx_hybrid()) ||
+	    amdgpu_device_supports_boco(drm_dev))
+		return pm_runtime_suspended(dev) &&
+			pm_suspend_via_firmware();
+
+	return 0;
+}
+
+static void amdgpu_pmops_complete(struct device *dev)
+{
+	/* nothing to do */
+}
+
 static int amdgpu_pmops_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
@@ -1484,6 +1506,8 @@ long amdgpu_drm_ioctl(struct file *filp,
 }
 
 static const struct dev_pm_ops amdgpu_pm_ops = {
+	.prepare = amdgpu_pmops_prepare,
+	.complete = amdgpu_pmops_complete,
 	.suspend = amdgpu_pmops_suspend,
 	.resume = amdgpu_pmops_resume,
 	.freeze = amdgpu_pmops_freeze,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
