Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C5ECA5FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 18:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C033E10E3BA;
	Tue,  6 Oct 2026 18:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X2ORVOEZ";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698AB10E3B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 18:02:47 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-486e70f2457so1468159f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791309766; x=1791914566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=51cqNJkvvQhB+knnY5xbu/9pUkd+scvU01KRl0tqVok=;
 b=X2ORVOEZzd9Alpuu9+XRtnLVWVFA2bV/hNsQDZ03c48/MN6rQ1mOcnn+fd91+cJLDS
 wVr1XxupjHzDyFy1lFqFn4Zx3ZUgjw1/+FAB6BJZO2595dMJ+NVyzGBRMIWAkQtQ1tuH
 cxb7yDi4+e/kJQ36GWMmSJkgGkiI+1JBPkn/F/adYFbEtOL1Hteu0UFsVno50ri2yV8v
 6PD9NsHqcmSlsYr+ij9deuTMI9i9eSRG+noJIik9QkxZJmiUieHBjX2dCnrJ0cM5nt0Y
 olMN26ZI87ehdZQkaX3sQnGPIhJTZRPRssA8hT9XaLdrOZFlmnf0LR9R76WIn5hUSorx
 v8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791309766; x=1791914566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=51cqNJkvvQhB+knnY5xbu/9pUkd+scvU01KRl0tqVok=;
 b=JxqLKjFtMTGgdVXnK1yptqHjZKOJMzhu1EXNsyNJegN+jtIJ3XTKBlipPR2PrdahXz
 yLeG1qjcB1fZqLsYjqjXzvju0PpJjjUJMP1Ri7+hxwElbq8oYEK4jQC+ktS5LLmDIh64
 9iLiLI+IKZ5Bu+0QCG57mcn6ihnLyQ/UEus6jeJr7MNX8NvM4jk1KtCJo4wtBNopALP5
 Nt0l2eJsVYm/fqZjMdbqr32PYwHpExRA3mgchRFPBCdrNXjQW0NBxHlgP4TG2hbKrqtw
 YO9/1Mxwqv8/pFp4yVTeCbYfGWb4FsgoE19/r7vbwSWu/oKDk3b1pHhoiXVXOy+KDO7e
 0VlA==
X-Gm-Message-State: AFq9FYKIpHYTc8EnVjQ3fTSu2WY+pXmqaUGKjlYwgX/DydSTs6qbFG6n
 A9vgvlMLckEEGqfNecV03ha5onrnH9COl52MLiaMD9azl43Zmu2JRUYvKMrpeg==
X-Gm-Gg: AYBFou1aNiYSwL/W7kmwXw2zRbHZJ353rW5H1um35cJAqjIJbqsiPdpBT66hE+POvQa
 oGC73l+trmvuUgXFgQxhnDTPNP8I0rp0t0MuDuAXIEa+bgKpGQ0UdH4Q2alVOwUrXy6+cudCidb
 PRlg/m1T8ptcgeW3FWVo70iUfqMPt0xLWaQOtEZskDnksF3e1E7LrDwgk3jKswuScvxeHTiHyt9
 ZucgxbbaGzsqLa80GHC92qCf6t8GDWJQC6qsGS1BQNXUn2iMcsljlM41Eq4B+u7yMsrvD7j7Vrk
 wnYhN4VnpRlWvgo59olXlUk9K9cmHwn0hQOR0g37BUzP5S0/llqjhf9CQ9P1C9c7HKzlJCWUlnU
 HQDRjZSIVqAtBKOh9BpGsJnHo0CmRYcjNRZtsZiRroy0WcLEbzU+6eibZe7flND6thGX9niTzWj
 5sKKvsQUqb7XOAPxDwtD+dmVP8EimrQAA1CDQk9Y/IGsn85Prs2sNua7iRX23mAgGJvxsIizu5G
 RZyKMKkrAYFXCoY02skPfrwZWC6sgaGWa17jCLtr/RKWWFzvA8w9TPNtDrK3ltvQpOBDfzyZh34
 viBrbdy0bLArCBDA61jQCNvsUg0erCkGzZmbLzN4GQs5MCecp5wYjaFYgRzCys9sGd15gPmZTAG
 tiXQjHrmF8U+1Je315rFNVXFeNf/kW3v3uuTTZtIMrIR4F+YJSH8+mBjMrq9CSeh4u4BOQldqGZ
 8NSPruIh7zbQJxuIw=
X-Received: by 2002:a05:6000:4308:b0:488:6561:b324 with SMTP id
 ffacd0b85a97d-48c727878e3mr401700f8f.9.1791309765476; 
 Tue, 06 Oct 2026 11:02:45 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:41ef:ba36:bd76:1e3c:1e5:c273])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1f3f7sm813630f8f.32.2026.10.06.11.02.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 11:02:45 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm/amdkfd: teardown processes before freeing kfd.dev
 on surprise removal
Date: Tue,  6 Oct 2026 20:02:40 +0200
Message-ID: <20261006180242.52809-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006180242.52809-1-olivier.kaloudoff@gmail.com>
References: <20261006180242.52809-1-olivier.kaloudoff@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On surprise removal the PCI core runs amdgpu_device_fini_hw(), which
calls amdgpu_amdkfd_device_fini_sw() as soon as pci_dev_is_disconnected()
is set. That frees kfd.dev - including the kfd_processes_count it
embeds - before amdgpu_amdkfd_teardown_processes() in
amdgpu_device_ip_fini_early() ever runs. The unconditional
adev->kfd.dev->kfd_processes_count dereference in the wait loop then
crashes the pciehp removal thread (observed as a +0x1b4 NULL deref on
MI50 Thunderbolt unplug).

Move the process teardown ahead of the early fini_sw() on the
disconnected path so that terminate events are sent and the drain wait
runs while kfd.dev is still valid. Keep a NULL guard in
kgd2kfd_teardown_processes() for the second invocation from
ip_fini_early, where kfd.dev is already NULL.

The wait itself stays unbounded: returning while processes still
reference kfd.dev would just trade the NULL deref for a deferred
use-after-free in kfd_process_remove_pdd() when it decrements
kfd_processes_count on freed memory.

Fixes: 28695ca09d32 ("drm/amd: Clean up kfd node on surprise disconnect")
Fixes: d12d05c4bc4c ("drm/amdkfd: Check if there are kfd porcesses using adev by kfd_processes_count")
Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
Changes in v3:
- drop the 30s bound; the drain wait is unbounded again (CK)
- run teardown before the early fini_sw() on the disconnected path so
  the wait actually observes kfd_processes_count while kfd.dev is
  still valid; NULL guard kept for the second invocation from
  ip_fini_early
- v1 took a bounded-wait approach; v2 of this patch was never posted
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 9 ++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9269e78..bd9d73a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4315,8 +4315,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 * before ip_fini_early to prevent kfd locking refcount issues by calling
 	 * amdgpu_amdkfd_suspend()
 	 */
-	if (pci_dev_is_disconnected(adev->pdev))
+	if (pci_dev_is_disconnected(adev->pdev)) {
+		/* Drain KFD processes while kfd.dev is still valid */
+		amdgpu_amdkfd_teardown_processes(adev);
 		amdgpu_amdkfd_device_fini_sw(adev);
+	}
 
 	amdgpu_coredump_fini(adev);
 	amdgpu_device_ip_fini_early(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 586e640..43029b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1801,7 +1801,14 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 
 	mutex_unlock(&kfd_processes_mutex);
 
-	/* wait all kfd processes use adev terminate */
+	/* kfd.dev may already be freed on surprise removal */
+	if (!adev->kfd.dev)
+		return;
+
+	/*
+	 * Wait for all KFD processes using adev to terminate. Must be
+	 * unbounded: device state is freed once they are gone.
+	 */
 	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
 		cond_resched();
 }
-- 
2.47.3

