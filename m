From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Avoid fall-through warning
Date: Mon, 22 Jul 2019 12:47:16 -0500
Message-ID: <20190722174716.GA17037@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Cox@embeddedor, Philip <Philip.Cox@amd.com>, Liu@embeddedor, Shaoyun <Shaoyun.Liu@amd.com>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

In preparation to enabling -Wimplicit-fallthrough, this patch silences
the following warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_mqd_manager_v10.c: In function ‘mqd_manager_init_v10’:
./include/linux/dynamic_debug.h:122:52: warning: this statement may fall through [-Wimplicit-fallthrough=]
 #define __dynamic_func_call(id, fmt, func, ...) do { \
                                                    ^
./include/linux/dynamic_debug.h:143:2: note: in expansion of macro ‘__dynamic_func_call’
  __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:153:2: note: in expansion of macro ‘_dynamic_func_call’
  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:336:2: note: in expansion of macro ‘dynamic_pr_debug’
  dynamic_pr_debug(fmt, ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_mqd_manager_v10.c:432:3: note: in expansion of macro ‘pr_debug’
   pr_debug("%s@%i\n", __func__, __LINE__);
   ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_mqd_manager_v10.c:433:2: note: here
  case KFD_MQD_TYPE_COMPUTE:
  ^~~~

by removing the call to pr_debug() in KFD_MQD_TYPE_CP:

"The mqd init for CP and COMPUTE will have the same  routine." [1]

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

[1] https://lore.kernel.org/lkml/c735a1cc-a545-50fb-44e7-c0ad93ee8ee7@amd.com/

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 4f8a6ffc5775..9cd3eb2d90bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -429,7 +429,6 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 
 	switch (type) {
 	case KFD_MQD_TYPE_CP:
-		pr_debug("%s@%i\n", __func__, __LINE__);
 	case KFD_MQD_TYPE_COMPUTE:
 		pr_debug("%s@%i\n", __func__, __LINE__);
 		mqd->allocate_mqd = allocate_mqd;
-- 
2.22.0
