From: Allen Pais <allen.pais@oracle.com>
Subject: [PATCH] drm/amdkfd: fix a potential NULL pointer dereference
Date: Wed, 18 Sep 2019 22:00:31 +0530
Message-ID: <1568824231-4007-1-git-send-email-allen.pais@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, daniel@ffwll.ch
List-Id: amd-gfx.lists.freedesktop.org

alloc_workqueue is not checked for errors and as a result,
a potential NULL dereference could occur.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index c56ac47..caa82a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -62,6 +62,11 @@ int kfd_interrupt_init(struct kfd_dev *kfd)
 	}
 
 	kfd->ih_wq = alloc_workqueue("KFD IH", WQ_HIGHPRI, 1);
+	if (unlikely(!kfd->ih_wq)) {
+		fifo_free(&kfd->ih_fifo);
+		dev_err(kfd_chardev(), "Failed to allocate KFD IH workqueue\n");
+		return kfd->ih_wq;
+	}
 	spin_lock_init(&kfd->interrupt_lock);
 
 	INIT_WORK(&kfd->interrupt_work, interrupt_wq);
-- 
1.9.1
