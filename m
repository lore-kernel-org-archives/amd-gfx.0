Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F1CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Dec 2021 05:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0132895C4;
	Thu, 30 Dec 2021 05:07:03 +0000 (UTC)
X-Greylist: delayed 399 seconds by postgrey-1.36 at gabe;
 Thu, 30 Dec 2021 05:07:02 UTC
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3701E895C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Dec 2021 05:07:02 +0000 (UTC)
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.43])
 by lechuck.jsg.id.au (OpenSMTPD) with ESMTP id c0e69629;
 Thu, 30 Dec 2021 16:00:19 +1100 (AEDT)
Received: from largo.jsg.id.au (localhost [127.0.0.1])
 by largo.jsg.id.au (OpenSMTPD) with ESMTP id b63d5476;
 Thu, 30 Dec 2021 16:00:19 +1100 (AEDT)
From: Jonathan Gray <jsg@jsg.id.au>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Subject: [PATCH] drm/radeon: use kernel is_power_of_2 rather than local version
Date: Thu, 30 Dec 2021 16:00:19 +1100
Message-Id: <20211230050019.18402-1-jsg@jsg.id.au>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: tbullock@comlore.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Follow the amdgpu change made in
7611750784664db46d0db95631e322aeb263dde7
and replace local radeon function with is_power_of_2().

Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
---
 drivers/gpu/drm/radeon/radeon_device.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 4f0fbf667431..15692cb241fc 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1085,19 +1085,6 @@ static unsigned int radeon_vga_set_decode(struct pci_dev *pdev, bool state)
 		return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
 }
 
-/**
- * radeon_check_pot_argument - check that argument is a power of two
- *
- * @arg: value to check
- *
- * Validates that a certain argument is a power of two (all asics).
- * Returns true if argument is valid.
- */
-static bool radeon_check_pot_argument(int arg)
-{
-	return (arg & (arg - 1)) == 0;
-}
-
 /**
  * radeon_gart_size_auto - Determine a sensible default GART size
  *                         according to ASIC family.
@@ -1126,7 +1113,7 @@ static int radeon_gart_size_auto(enum radeon_family family)
 static void radeon_check_arguments(struct radeon_device *rdev)
 {
 	/* vramlimit must be a power of two */
-	if (!radeon_check_pot_argument(radeon_vram_limit)) {
+	if (!is_power_of_2(radeon_vram_limit)) {
 		dev_warn(rdev->dev, "vram limit (%d) must be a power of 2\n",
 				radeon_vram_limit);
 		radeon_vram_limit = 0;
@@ -1140,7 +1127,7 @@ static void radeon_check_arguments(struct radeon_device *rdev)
 		dev_warn(rdev->dev, "gart size (%d) too small\n",
 				radeon_gart_size);
 		radeon_gart_size = radeon_gart_size_auto(rdev->family);
-	} else if (!radeon_check_pot_argument(radeon_gart_size)) {
+	} else if (!is_power_of_2(radeon_gart_size)) {
 		dev_warn(rdev->dev, "gart size (%d) must be a power of 2\n",
 				radeon_gart_size);
 		radeon_gart_size = radeon_gart_size_auto(rdev->family);
@@ -1163,7 +1150,7 @@ static void radeon_check_arguments(struct radeon_device *rdev)
 		break;
 	}
 
-	if (!radeon_check_pot_argument(radeon_vm_size)) {
+	if (!is_power_of_2(radeon_vm_size)) {
 		dev_warn(rdev->dev, "VM size (%d) must be a power of 2\n",
 			 radeon_vm_size);
 		radeon_vm_size = 4;
-- 
2.34.1

