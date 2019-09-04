From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/amdgpu: Delete an unnecessary check before two function
 calls
Date: Wed, 4 Sep 2019 13:00:27 +0200
Message-ID: <a3739125-5fa8-cadb-d2b8-8a9f12e9bacd@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Hawking Zhang <Hawking.Zhang@amd.com>, Jack Xiao <Jack.Xiao@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>, Tom St Denis <tom.stdenis@amd.com>, Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 4 Sep 2019 12:30:23 +0200

The functions =E2=80=9Cdebugfs_remove=E2=80=9D and =E2=80=9Ckfree=E2=80=9D=
 test whether their argument
is NULL and then return immediately.
Thus the tests around the shown calls are not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_debugfs.c
index 5652cc72ed3a..d321c72d63d1 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1076,10 +1076,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u6=
4 val)
 	kthread_unpark(ring->sched.thread);

 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
-
-	if (fences)
-		kfree(fences);
-
+	kfree(fences);
 	return 0;
 }

@@ -1103,8 +1100,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)

 void amdgpu_debugfs_preempt_cleanup(struct amdgpu_device *adev)
 {
-	if (adev->debugfs_preempt)
-		debugfs_remove(adev->debugfs_preempt);
+	debugfs_remove(adev->debugfs_preempt);
 }

 #else
=2D-
2.23.0
