From: Yu Zhao <yuzhao@google.com>
Subject: [PATCH 1/3] drm/amd: fix race in page flip job
Date: Thu, 20 Dec 2018 20:10:51 -0700
Message-ID: <20181221031053.240161-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: David Zhou <David1.Zhou@amd.com>, Samuel Li <Samuel.Li@amd.com>, Harry Wentland <harry.wentland@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>, Daniel Stone <daniels@collabora.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
List-Id: amd-gfx.lists.freedesktop.org

Fix race between page flip job submission and completion. We invoke
page_flip callback to submit page flip job to GPU first and then set
pflip_status. If GPU fires page flip done irq in between, its handler
won't see the correct pflip_status thus will refuse to notify the job
completion. The job will eventually times out.

Reverse the order of calling page_flip and setting pflip_status to
fix the race.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 686a26de50f9..e309d26170db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -105,11 +105,11 @@ static void amdgpu_display_flip_work_func(struct work_struct *__work)
 	/* We borrow the event spin lock for protecting flip_status */
 	spin_lock_irqsave(&crtc->dev->event_lock, flags);
 
+	/* Set the flip status */
+	amdgpu_crtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
 	/* Do the flip (mmio) */
 	adev->mode_info.funcs->page_flip(adev, work->crtc_id, work->base, work->async);
 
-	/* Set the flip status */
-	amdgpu_crtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
 	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
 
 
-- 
2.20.1.415.g653613c723-goog
