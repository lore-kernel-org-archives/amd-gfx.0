Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF51C433E9
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 16:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524EB64E35
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 16:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524EB64E35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77A866F481;
	Fri,  5 Feb 2021 16:15:44 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C99F16F481
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 16:15:41 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id t17so5343146qtq.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Feb 2021 08:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hIzvhEX5+B9JAdMDjNIhocCFxbtmzF47+ALBu26I7sQ=;
 b=kd0yYRfcXH85Ha8246MyheDO/sBhD6Ejb8q/Q5ypuHmBeNe/6lfXp/wj0qDUiaIi+I
 GU4OVeRWot2QZOoX9Neha9/Pv3xwpVlVUojxAqDP+ea//q4pEuyB8LgzudPuBdMAlzLc
 2P7Mvqv2d6LfWfQeP4cjodyCLVSr2gwTYbdgSV7b2Z9LZi4LFoFhJieVTaPnP77vgF2H
 Vuw5pTUlaQwMx2RUXV/tuwwAqwg8Flr7WM8LK+R3VWbLj+TZHhH5r5lMykInWvYnOKqy
 fx340OA8aMeiww3iQWQLPLsfmIEcAEWNcj7Bt2io3ZZPsDK45wf+bctf+XxK5dL8CL6V
 S4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hIzvhEX5+B9JAdMDjNIhocCFxbtmzF47+ALBu26I7sQ=;
 b=bxC/MmikZgPlzD8Wb72d/5tfC2bjDlnueScOqJd4UdTk70FY8SMWrEOICpM0xUV7Bf
 HjC49wzX/Lb3btbY/KEc0rEEQn5TSWE+p3yRfEstyBU5LC+fiJg7QDEkhvlrnmelNvLs
 NF/RH2ndoUJdcwq7A3RFvOFX6MjZjCfTc3SNcrZ+dzi+IJbjoEv0hdrLmNc/PudHpyT4
 Osma7iDgFJt6fhmHpD246vA8+SXP6Dn2cSsDnq7I7knoCW+0p3ifiCucgvXBPsTArEf2
 tp0Wy0Xb1rbv8pGPU3JYg/JcHBuOXcmpo3iKdORAbuvLEKVfeKOutNKv8ozmARl2agAB
 6LpA==
X-Gm-Message-State: AOAM5319ORiV1VTaqgsQEUoB6tAvCL7ZThRoDhvaOYNKnnqOCNyROkg1
 G76GRUt+oEOItplXUb1CLgzuI2RjbFk=
X-Google-Smtp-Source: ABdhPJyT7ZWASVCE3czbCqLEksHrIMsorc6Zke5ODLqtLi7ghLKWupC51PgJbkPfiZvDnkY6UzlHJg==
X-Received: by 2002:ac8:3a63:: with SMTP id w90mr1314548qte.300.1612541739646; 
 Fri, 05 Feb 2021 08:15:39 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id o17sm8636947qtl.47.2021.02.05.08.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 08:15:39 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: add a dev_pm_ops prepare callback (v2)
Date: Fri,  5 Feb 2021 11:15:27 -0500
Message-Id: <20210205161528.37055-1-alexander.deucher@amd.com>
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
index 283e93c82b47..b1de139e883b 100644
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
