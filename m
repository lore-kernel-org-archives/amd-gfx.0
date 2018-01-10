From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drm/amdkfd: Fix potential NULL pointer dereferences
Date: Wed, 10 Jan 2018 10:50:08 -0600
Message-ID: <20180110165008.GA10691@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

In case kfd_get_process_device_data returns null, there are some
null pointer dereferences in functions kfd_bind_processes_to_device
and kfd_unbind_processes_from_device.

Fix this by null checking pdd before dereferencing it.

Addresses-Coverity-ID: 1463794 ("Dereference null return value")
Addresses-Coverity-ID: 1463772 ("Dereference null return value")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a22fb071..29d51d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -461,6 +461,13 @@ int kfd_bind_processes_to_device(struct kfd_dev *dev)
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
 		mutex_lock(&p->mutex);
 		pdd = kfd_get_process_device_data(dev, p);
+
+		if (!pdd) {
+			pr_err("Process device data doesn't exist\n");
+			mutex_unlock(&p->mutex);
+			return -EFAULT;
+		}
+
 		if (pdd->bound != PDD_BOUND_SUSPENDED) {
 			mutex_unlock(&p->mutex);
 			continue;
@@ -501,6 +508,11 @@ void kfd_unbind_processes_from_device(struct kfd_dev *dev)
 		mutex_lock(&p->mutex);
 		pdd = kfd_get_process_device_data(dev, p);
 
+		if (!pdd) {
+			mutex_unlock(&p->mutex);
+			return;
+		}
+
 		if (pdd->bound == PDD_BOUND)
 			pdd->bound = PDD_BOUND_SUSPENDED;
 		mutex_unlock(&p->mutex);
-- 
2.7.4
