From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] drm/amdgpu: fix a missing-check bug
Date: Sat, 20 Oct 2018 15:57:54 -0500
Message-ID: <1540069075-18358-1-git-send-email-wang6495@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Ken Wang <Ken.Wang@amd.com>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

In amdgpu_read_bios_from_rom(), the header of the VBIOS is firstly copied
to 'header' from an IO memory region through
amdgpu_asic_read_bios_from_rom(). Then the header is checked to see whether
it is a valid header. If yes, the whole VBIOS, including the header, is
then copied to 'adev->bios'. The problem here is that no check is enforced
on the header after the second copy. Given that the device also has the
permission to access the IO memory region, it is possible for a malicious
device controlled by an attacker to modify the header between these two
copies. By doing so, the attacker can supply compromised VBIOS, which can
cause undefined behavior of the kernel and introduce potential security
issues.

This patch rewrites the header in 'adev->bios' using the header acquired in
the first copy.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index a5df80d..ac701f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -181,6 +181,8 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
 	/* read complete BIOS */
 	amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
 
+	memcpy(adev->bios, header, AMD_VBIOS_SIGNATURE_END);
+
 	if (!check_atom_bios(adev->bios, len)) {
 		kfree(adev->bios);
 		return false;
-- 
2.7.4
