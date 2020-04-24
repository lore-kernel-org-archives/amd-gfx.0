Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CE3C54FD0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 11:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027C420728
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 11:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQCIVR3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027C420728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B280C6EAA2;
	Fri, 24 Apr 2020 11:47:37 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E836EAA2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 11:47:37 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id d15so8799084wrx.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=dVhKMvUAP9YCJcitQdGC46Sd5MQcI1ujeLVSwoqswVA=;
 b=mQCIVR3ToGTgNb2KVf/gRIKuqOCkYodWYs6vsw36XJYfXVpBxbDFOmZCYSABcuy+Zw
 u3xsFxyTVVTIWS3E/XhWzHXFwfzEbh+CxUKzPLd22xQ0oBZt/E7Rqkcnzay/Z56EhAK+
 SZfLfJYV4K0A+caSgEMPkMsSsZFO/Qh/Z8fCCwHTgo3yFoYJUnY7M92JuDOXfqGBwWaj
 7TJGZiAyKJ5IkEv8YUYal1tUsR92IEtsb3umaz+MUdTKqLcayb4DUBzFnBDqJpfKAZqd
 Xcpx9RyAg724C/b76LUorB5/B0yRbkS5b2rBNRkmwV5GyuMDOZY2FGJQ+C9w/PtnhXmP
 1XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dVhKMvUAP9YCJcitQdGC46Sd5MQcI1ujeLVSwoqswVA=;
 b=B+xVep0OxzODhDwdTqorQ8sGmNRxeX6zw92takfd0qKrcv18cmWG2Jqbgp0pAcI9EF
 RkA79EiCB3wpRoRBF2xhcyATyUwNA8jZYrJSOMDi/BbgQRP8+83QeT5zbidmtaSt6GE/
 O8o5k1DITiiJb3uFopV2sa64TAVvPsc1YnXKYBkH8vE8WaX7Ca5RMMn70osjrsfv913M
 OD2MJU6kJ0d4etREjDBoGF9hbgFs7UePDGH586vKAmCb6342J/mHzMO4QpvuVvZExJaV
 bL9l+xfHnOJ36vyRImBVS5YqsZwDyFyOaB3Ehn8TrKyCoJe6iWmpRQCkvkH/UkOK02+T
 W2GA==
X-Gm-Message-State: AGi0PuZ5FnISAxIT/NbsEVCdF8Zz5qzcPZ7lxKhE5KnCBPpNso9n1Wlr
 rQ3ZmGWSCz/GwLXTXLxKEUv7J/Bo
X-Google-Smtp-Source: APiQypL5ln1O15vQxB+JRBc3Jsa4N64XKfjMVD/e3LyPeq+EzbK0CFDEtSlAj0fALwszzQdLPAxEvg==
X-Received: by 2002:adf:d087:: with SMTP id y7mr10532980wrh.321.1587728855825; 
 Fri, 24 Apr 2020 04:47:35 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:6d7f:f78:6668:9d37])
 by smtp.gmail.com with ESMTPSA id l9sm7940984wrq.83.2020.04.24.04.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 04:47:35 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Pierre-eric.Pelloux-prayer@amd.com,
 Hawking.Zhang@amd.com, Monk.Liu@amd.com, Jiange.Zhao@amd.com
Subject: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v3
Date: Fri, 24 Apr 2020 13:47:34 +0200
Message-Id: <20200424114734.30584-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Felix.Kuehling@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiange Zhao <Jiange.Zhao@amd.com>

When GPU got timeout, it would notify an interested part
of an opportunity to dump info before actual GPU reset.

A usermode app would open 'autodump' node under debugfs system
and poll() for readable/writable. When a GPU reset is due,
amdgpu would notify usermode app through wait_queue_head and give
it 10 minutes to dump info.

After usermode app has done its work, this 'autodump' node is closed.
On node closure, amdgpu gets to know the dump is done through
the completion that is triggered in release().

There is no write or read callback because necessary info can be
obtained through dmesg and umr. Messages back and forth between
usermode app and amdgpu are unnecessary.

v2: (1) changed 'registered' to 'app_listening'
    (2) add a mutex in open() to prevent race condition

v3 (chk): grab the reset lock to avoid race in autodump_open,
	  rename debugfs file to amdgpu_autodump,
	  provide autodump_read as well,
	  style and code cleanups

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
 4 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bc1e0fd71a09..6f8ef98c4b97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -990,6 +990,8 @@ struct amdgpu_device {
 	char				product_number[16];
 	char				product_name[32];
 	char				serial[16];
+
+	struct amdgpu_autodump		autodump;
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1a4894fa3693..b1029d12a971 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -27,7 +27,7 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
-
+#include <linux/poll.h>
 #include <drm/drm_debugfs.h>
 
 #include "amdgpu.h"
@@ -74,8 +74,96 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	const unsigned long timeout = 600 * HZ;
+	int ret;
+
+	wake_up_interruptible(&adev->autodump.gpu_hang);
+
+	ret = wait_for_completion_interruptible_timeout(&adev->autodump.dumping,
+							timeout);
+	if (ret == 0) {
+		pr_err("autodump: timeout, move on to gpu recovery\n");
+		return -ETIMEDOUT;
+	}
+#endif
+	return 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
+static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
+{
+	struct amdgpu_device *adev = inode->i_private;
+	int ret;
+
+	file->private_data = adev;
+
+	mutex_lock(&adev->lock_reset);
+	if (adev->autodump.dumping.done) {
+		reinit_completion(&adev->autodump.dumping);
+		ret = 0;
+	} else {
+		ret = -EBUSY;
+	}
+	mutex_unlock(&adev->lock_reset);
+
+	return ret;
+}
+
+static int amdgpu_debugfs_autodump_release(struct inode *inode,
+					   struct file *file)
+{
+	struct amdgpu_device *adev = file->private_data;
+
+	complete(&adev->autodump.dumping);
+	return 0;
+}
+
+static ssize_t amdgpu_debugfs_autodump_read(struct file *file, char __user *buf,
+					    size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = file->private_data;
+
+	wait_event_interruptible(adev->autodump.gpu_hang, adev->in_gpu_reset);
+	return 0;
+}
+
+unsigned int amdgpu_debugfs_autodump_poll(struct file *file,
+					  struct poll_table_struct *poll_table)
+{
+	struct amdgpu_device *adev = file->private_data;
+
+	poll_wait(file, &adev->autodump.gpu_hang, poll_table);
+
+	if (adev->in_gpu_reset)
+		return POLLIN | POLLRDNORM | POLLWRNORM;
+
+	return 0;
+}
+
+static const struct file_operations autodump_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = amdgpu_debugfs_autodump_open,
+	.read = amdgpu_debugfs_autodump_read,
+	.poll = amdgpu_debugfs_autodump_poll,
+	.release = amdgpu_debugfs_autodump_release,
+};
+
+static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
+{
+	init_completion(&adev->autodump.dumping);
+	init_waitqueue_head(&adev->autodump.gpu_hang);
+
+	complete(&adev->autodump.dumping);
+
+	debugfs_create_file("amdgpu_autodump", 0600,
+			    adev->ddev->primary->debugfs_root,
+			    adev, &autodump_debug_fops);
+}
+
 /**
  * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
  *
@@ -1434,6 +1522,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_debugfs_create_all(adev);
 
+	amdgpu_debugfs_autodump_init(adev);
+
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index de12d1101526..3504c48e1564 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -31,6 +31,11 @@ struct amdgpu_debugfs {
 	unsigned		num_files;
 };
 
+struct amdgpu_autodump {
+	struct completion	dumping;
+	struct wait_queue_head	gpu_hang;
+};
+
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_fini(struct amdgpu_device *adev);
@@ -40,3 +45,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
+int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3d601d5dd5af..44e54ea7af0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_full_reset  = *need_full_reset_arg;
 
+	amdgpu_debugfs_wait_dump(adev);
+
 	/* block all schedulers and reset given job's ring */
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
