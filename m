Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C874CC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C122206F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6sYOWR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C122206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600DA6E2F8;
	Tue, 21 Jul 2020 18:09:12 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B7A8892D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:09:10 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id t11so9761792qvk.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/UrB7RJKkE+GqomEqpNLE/sQtmAP8IYOHTwch51bVxY=;
 b=O6sYOWR4upQfMRlmXlj4qweZN7C1xVXo4leZo8UTqbeaRLutVJsLZcRxxGGeG4QQiX
 xRC5UUN/4R77+AfaYeXWX+nx41AklNXMMXIIu3boDulnN3wSJLuxUdtXvFWfRr+KqZcH
 siDAXhJacQ1Mfyl0AqAX/0LltbPK0SNm/63KVCw7CHE4gdkVDm6Bqnr0wfVY0oOZCDWc
 +icVN4bWoyv3NNnl2BtPlOwksfsXcDcUD1g9n+Jpv0tPlQzJmCUUn9dUk2EASPo4JSY6
 S5b29Dkh+XIEXUQa1Yo26qNm7owVYrQeSyfABh2ZHwn6+DPDHjelfOegz1XRT8Pqfe1i
 XbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/UrB7RJKkE+GqomEqpNLE/sQtmAP8IYOHTwch51bVxY=;
 b=HQyVvQGw6vHQv31pkzkzMF4/bvuFc14Dr3FOx8sT4VnhiWTICpu32QZz1geQP1Q+oy
 JNdfDvA+Anp++jPI5fQXZtwJkmBXPEXo1jghHx7MaVwsbLVCE4tsn/rWywPcfyn+iT3X
 UTYlL9T4myc80C/nxDcSQbiOuC+RPL1jhCb9ejNwr5paAtlZXuV/rKrWY/HqqzqYnvxI
 CG2b3U5MqxLChDk47WW+4alcKhP8m1e+r463zkQFbNWlDi542YvXpVQmL696wc7VWuLn
 AQMKV/djVXFK1Yol7F75ciF0J0bOhQO8oldEyDofkUSVdcF1cLQuvBTI3L1kdreZfdvF
 B+zg==
X-Gm-Message-State: AOAM530qQSpIeFZP/0iVui9kpRzh1lsHVpnk/Kc9nqea2IVxlBIxrtiT
 dwucfq1kp2Uwl4C6RTa4zW6lp12E
X-Google-Smtp-Source: ABdhPJwiustCYdudPAwTi7uWNV2t6Dp4TvdDwUXEolhtKmqdx9iZNrrpn78OVumQW9G8vmqccjF9JA==
X-Received: by 2002:a0c:e5cc:: with SMTP id u12mr27861335qvm.54.1595354945620; 
 Tue, 21 Jul 2020 11:09:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t65sm2957284qkf.119.2020.07.21.11.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 11:09:05 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu: move i2c bus lock out of ras structure
Date: Tue, 21 Jul 2020 14:08:45 -0400
Message-Id: <20200721180850.813406-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not really ras related.  It's just a lock for the
bus in general.  This removes the ras dependency from
the smu i2c bus.

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  1 -
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c     | 10 +++-------
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index 7f3cd7185650..aa27fe65cdfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -425,6 +425,7 @@ struct amdgpu_pm {
 	u32                     default_sclk;
 	u32                     default_mclk;
 	struct amdgpu_i2c_chan *i2c_bus;
+	bool                    bus_locked;
 	/* internal thermal controller on rv6xx+ */
 	enum amdgpu_int_thermal_type int_thermal_type;
 	struct device	        *int_hwmon_dev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 7e8647a05df7..9e7d640920fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -47,7 +47,6 @@ struct amdgpu_ras_eeprom_control {
 	uint32_t next_addr;
 	unsigned int num_recs;
 	struct mutex tbl_mutex;
-	bool bus_locked;
 	uint32_t tbl_byte_sum;
 	uint16_t i2c_address; // 8-bit represented address
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 9bffbab35041..f3d0324c4a7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -32,7 +32,6 @@
 #include "amdgpu_amdkfd.h"
 #include <linux/i2c.h>
 #include <linux/pci.h>
-#include "amdgpu_ras.h"
 
 /* error codes */
 #define I2C_OK                0
@@ -592,14 +591,13 @@ static uint32_t smu_v11_0_i2c_eeprom_write_data(struct i2c_adapter *control,
 static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c);
-	struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
 
 	if (!smu_v11_0_i2c_bus_lock(i2c)) {
 		DRM_ERROR("Failed to lock the bus from SMU");
 		return;
 	}
 
-	control->bus_locked = true;
+	adev->pm.bus_locked = true;
 }
 
 static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
@@ -611,14 +609,13 @@ static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
 static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c);
-	struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
 
 	if (!smu_v11_0_i2c_bus_unlock(i2c)) {
 		DRM_ERROR("Failed to unlock the bus from SMU");
 		return;
 	}
 
-	control->bus_locked = false;
+	adev->pm.bus_locked = false;
 }
 
 static const struct i2c_lock_operations smu_v11_0_i2c_i2c_lock_ops = {
@@ -632,9 +629,8 @@ static int smu_v11_0_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
 {
 	int i, ret;
 	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
-	struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
 
-	if (!control->bus_locked) {
+	if (!adev->pm.bus_locked) {
 		DRM_ERROR("I2C bus unlocked, stopping transaction!");
 		return -EIO;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
