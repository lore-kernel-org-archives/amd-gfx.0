Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591F1C001DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 17:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A0C10E40D;
	Tue, 11 Jul 2023 17:05:45 +0000 (UTC)
X-Greylist: delayed 306 seconds by postgrey-1.36 at gabe;
 Tue, 11 Jul 2023 16:48:32 UTC
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9FF10E3F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 16:48:32 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1689093803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AOe2sK5corMJVr8s18spKTEHFO7S6COQNSRgsjkc54A=;
 b=HvE3n3cEhL+NyqDPKs/PppZJPBBvkJ6Z4GSVgABYNxQ2TNgTefhpbD3IAngGIGTrb5+KTM
 icD3Y1kKySVnFd4+WbZ+s5x0ORowvdjlmISvzqeRR17HIuhuiCDtQTtAfWl+F7Idw7tj4L
 vMOMD463UkpiH9xDww2GoIrwBEM6k90=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: David Airlie <airlied@gmail.com>
Subject: [PATCH v3 0/9] PCI/VGA: Improve the default VGA device selection
Date: Wed, 12 Jul 2023 00:43:01 +0800
Message-Id: <20230711164310.791756-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 11 Jul 2023 17:05:41 +0000
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
Cc: linux-fbdev@vger.kernel.org, Sui Jingfeng <suijingfeng@loongson.cn>,
 kvm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sui Jingfeng <suijingfeng@loongson.cn>

Currently, the default VGA device selection is not perfect. Potential
problems are:

1) This function is a no-op on non-x86 architectures.
2) It does not take the PCI Bar may get relocated into consideration.
3) It is not effective for the PCI device without a dedicated VRAM Bar.
4) It is device-agnostic, thus it has to waste the effort to iterate all
   of the PCI Bar to find the VRAM aperture.
5) It has invented lots of methods to determine which one is the default
   boot device on a multiple video card coexistence system. But this is
   still a policy because it doesn't give the user a choice to override.

With the observation that device drivers or video aperture helpers may
have better knowledge about which PCI bar contains the firmware FB,

This patch tries to solve the above problems by introducing a function
callback to the vga_client_register() function interface. DRM device
drivers for the PCI device need to register the is_boot_device() function
callback during the driver loading time. Once the driver binds the device
successfully, VRAARB will call back to the driver. This gives the device
drivers a chance to provide accurate boot device identification. Which in
turn unlock the abitration service to non-x86 architectures. A device
driver can also pass a NULL pointer to keep the original behavior.

This series is applied on the drm-tip branch (with a cleanup patch set[1]
applied beforehand)

[1] https://patchwork.freedesktop.org/series/120548/

v2:
	* Add a simple implemment for drm/i915 and drm/ast
	* Pick up all tags (Mario)
v3:
	* Fix a mistake for drm/i915 implement
	* Fix patch can not be applied problem because of drm/amdgpu merged
          other people's patch.

Sui Jingfeng (9):
  video/aperture: Add a helper to detect if an aperture contains
    firmware FB
  video/aperture: Add a helper for determining if an unmoved aperture
    contain FB
  PCI/VGA: Switch to aperture_contain_firmware_fb_nonreloc()
  PCI/VGA: Improve the default VGA device selection
  drm/amdgpu: Implement the is_primary_gpu callback of
    vga_client_register()
  drm/radeon: Add an implement for the is_primary_gpu function callback
  drm/i915: Add an implement for the is_primary_gpu hook
  drm/ast: Register as a vga client to vgaarb by calling
    vga_client_register()
  drm/loongson: Add an implement for the is_primary_gpu function
    callback

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++-
 drivers/gpu/drm/ast/ast_drv.c              | 29 +++++++++
 drivers/gpu/drm/drm_aperture.c             | 16 +++++
 drivers/gpu/drm/i915/display/intel_vga.c   | 31 ++++++++-
 drivers/gpu/drm/loongson/lsdc_drv.c        | 10 ++-
 drivers/gpu/drm/nouveau/nouveau_vga.c      |  2 +-
 drivers/gpu/drm/radeon/radeon_device.c     | 12 +++-
 drivers/pci/vgaarb.c                       | 74 ++++++++++++++++------
 drivers/vfio/pci/vfio_pci_core.c           |  2 +-
 drivers/video/aperture.c                   | 65 +++++++++++++++++++
 include/drm/drm_aperture.h                 |  2 +
 include/linux/aperture.h                   | 14 ++++
 include/linux/vgaarb.h                     |  8 ++-
 13 files changed, 247 insertions(+), 30 deletions(-)

-- 
2.25.1

