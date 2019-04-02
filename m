From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC tip/core/rcu 3/4] drivers/gpu/drm/amd: Dynamically allocate kfd_processes_srcu
Date: Tue,  2 Apr 2019 07:29:32 -0700
Message-ID: <20190402142933.14547-3-paulmck@linux.ibm.com>
References: <20190402142816.GA13084@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402142816.GA13084@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Tejun Heo <tj@kernel.org>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Having DEFINE_SRCU() or DEFINE_STATIC_SRCU() in a loadable module
requires that the size of the reserved region be increased, which is
not something we really want to be doing.  This commit therefore removes
the DEFINE_STATIC_SRCU() from drivers/gpu/drm/amd/amdkfd/kfd_process.c in
favor of defining kfd_processes_srcu as a simple srcu_struct, initializing
it in amdgpu_amdkfd_init(), and cleaning it up in amdgpu_amdkfd_fini().

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: kbuild test robot <lkp@intel.com>
Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Tejun Heo <tj@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>
Cc: <amd-gfx@lists.freedesktop.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index fe1d7368c1e6..eadb20dee867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -28,6 +28,8 @@
 #include <linux/module.h>
 #include <linux/dma-buf.h>
 
+extern struct srcu_struct kfd_processes_srcu;
+
 static const unsigned int compute_vmid_bitmap = 0xFF00;
 
 /* Total memory size in system memory and all GPU VRAM. Used to
@@ -40,6 +42,8 @@ int amdgpu_amdkfd_init(void)
 	struct sysinfo si;
 	int ret;
 
+	ret = init_srcu_struct(&kfd_processes_srcu);
+	WARN_ON(ret);
 	si_meminfo(&si);
 	amdgpu_amdkfd_total_mem_size = si.totalram - si.totalhigh;
 	amdgpu_amdkfd_total_mem_size *= si.mem_unit;
@@ -57,6 +61,7 @@ int amdgpu_amdkfd_init(void)
 void amdgpu_amdkfd_fini(void)
 {
 	kgd2kfd_exit();
+	cleanup_srcu_struct(&kfd_processes_srcu);
 }
 
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 4bdae78bab8e..98b694068b8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -47,7 +47,7 @@ struct mm_struct;
 DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 static DEFINE_MUTEX(kfd_processes_mutex);
 
-DEFINE_SRCU(kfd_processes_srcu);
+struct srcu_struct kfd_processes_srcu;
 
 /* For process termination handling */
 static struct workqueue_struct *kfd_process_wq;
-- 
2.17.1
