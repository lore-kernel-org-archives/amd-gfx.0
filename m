From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] drm/radeon: fix a missing-check bug
Date: Thu, 18 Oct 2018 12:13:29 -0500
Message-ID: <1539882809-7189-1-git-send-email-wang6495@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

In radeon_read_bios(), the bios rom is firstly mapped to the IO memory
region 'bios' through pci_map_rom(). Then the first two bytes of 'bios' are
copied to 'val1' and 'val2' respectively through readb(). After that,
'val1' and 'val2' are checked to see whether they have expected values,
i.e., 0x55 and 0xaa, respectively. If yes, the whole data in 'bios' is then
copied to 'rdev->bios' through memcpy_fromio(). Obviously, the first two
bytes in 'bios' are copied twice. More importantly, no check is enforced on
the first two bytes of 'rdev->bios' after memcpy_fromio(). Given that the
IO memory region can also be accessed by the device, it is possible that a
malicious device can race to modify these two bytes between the two copies
and thus after memcpy_fromio(), the first two bytes in 'rdev->bios' can
have unexpected values.  This can cause undefined behavior of the kernel
and introduce potential security risk, if the device can be controlled by
attackers.

This patch rewrites the first two bytes of 'rdev->bios' after
memcpy_fromio() with expected values. Through this way, the above issue can
be avoided.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 04c0ed4..f336719 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -98,6 +98,8 @@ static bool radeon_read_bios(struct radeon_device *rdev)
 		return false;
 	}
 	memcpy_fromio(rdev->bios, bios, size);
+	rdev->bios[0] = val1;
+	rdev->bios[1] = val2;
 	pci_unmap_rom(rdev->pdev, bios);
 	return true;
 }
-- 
2.7.4
