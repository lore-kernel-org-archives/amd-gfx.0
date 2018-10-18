From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] drm/radeon: fix a missing-check bug
Date: Thu, 18 Oct 2018 11:42:13 -0500
Message-ID: <1539880933-6887-1-git-send-email-wang6495@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

In igp_read_bios_from_vram(), the start of vram is firstly remapped to the
IO memory region 'bios' through ioremap(). Then the size and values of
'bios' are checked. For example, 'bios[0]' is compared against 0x55 and
'bios[1]' is compared against 0xaa. If no error happens during this
checking process, the whole data in 'bios' is then copied to 'rdev->bios'
through memcpy_fromio().  The problem here is that the checks are performed
on 'bios' directly. Given that the IO memory region can also be accessed by
the device, it is possible that a malicious device race to modify 'bios[0]'
and/or 'bios[1]' after the checks but before memcpy_fromio(). This can
cause undefined behavior of the kernel and potentially introduce security
risk, especially when the device can be controlled by attackers.

This patch avoids the above issue by rewriting the first two bytes of
'rdev->bios' after memcpy_fromio() with expected values.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 04c0ed4..d8304fa 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -69,6 +69,8 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 		return false;
 	}
 	memcpy_fromio(rdev->bios, bios, size);
+	rdev->bios[0] = 0x55;
+	rdev->bios[1] = 0xaa;
 	iounmap(bios);
 	return true;
 }
-- 
2.7.4
