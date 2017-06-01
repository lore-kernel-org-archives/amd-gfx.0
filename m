From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] drm/amdkfd: Spelling s/apreture/aperture/
Date: Thu,  1 Jun 2017 12:28:38 +0200
Message-ID: <1496312918-27352-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Jiri Kosina <trivial@kernel.org>
Cc: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: amd-gfx.lists.freedesktop.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 84d1ffd1eef95048..a7d273d472107821 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -319,11 +319,11 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	/* init process apertures*/
 	process->is_32bit_user_mode = in_compat_syscall();
 	if (kfd_init_apertures(process) != 0)
-		goto err_init_apretures;
+		goto err_init_apertures;
 
 	return process;
 
-err_init_apretures:
+err_init_apertures:
 	pqm_uninit(&process->pqm);
 err_process_pqm_init:
 	hash_del_rcu(&process->kfd_processes);
-- 
2.7.4
