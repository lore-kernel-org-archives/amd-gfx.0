Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D768C19F2D
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 20:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E64BA8B855;
	Sat, 13 Aug 2022 20:10:58 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D1AB9D35
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 12:57:55 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 33E6560B89;
 Sat, 13 Aug 2022 12:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3C8C433C1;
 Sat, 13 Aug 2022 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1660395470;
 bh=uqr0vTigjKc2Z2ieU+En4wxNjKZjQ4XnfOuM3QgGGKE=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=1odhmVhdVmfyWkV3NA76DHPJ4Nv9JtRB2Ktclk9LzGIix++W5pBsX7E3qECwX1rO0
 Vg3KvcI7c64koZXpao3TqT2cDWoJCja4/DMAIEVZzht3CVBaIDYCii8cXCvqUuZyVP
 fWb7LY0DJR2wQqfLDCJifMKfVIbwoiKpBQ0ImdAU=
Subject: Patch "drm/amdgpu: fix check in fbdev init" has been added to the
 5.15-stable tree
To: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 gregkh@linuxfoundation.org, hgoffin@amazon.com
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Aug 2022 14:57:13 +0200
In-Reply-To: <20220719185659.2068735-1-alexander.deucher@amd.com>
Message-ID: <166039543315196@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Mailman-Approved-At: Sat, 13 Aug 2022 20:10:15 +0000
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
Cc: stable-commits@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


This is a note to let you know that I've just added the patch titled

    drm/amdgpu: fix check in fbdev init

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amdgpu-fix-check-in-fbdev-init.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From git@z Thu Jan  1 00:00:00 1970
From: Alex Deucher <alexander.deucher@amd.com>
Date: Tue, 19 Jul 2022 14:56:59 -0400
Subject: drm/amdgpu: fix check in fbdev init
To: <stable@vger.kernel.org>
Cc: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, <hgoffin@amazon.com>
Message-ID: <20220719185659.2068735-1-alexander.deucher@amd.com>

From: Alex Deucher <alexander.deucher@amd.com>

The new vkms virtual display code is atomic so there is
no need to call drm_helper_disable_unused_functions()
when it is enabled.  Doing so can result in a segfault.
When the driver switched from the old virtual display code
to the new atomic virtual display code, it was missed that
we enable virtual display unconditionally under SR-IOV
so the checks here missed that case.  Add the missing
check for SR-IOV.

There is no equivalent of this patch for Linus' tree
because the relevant code no longer exists.  This patch
is only relevant to kernels 5.15 and 5.16.

Fixes: 84ec374bd580 ("drm/amdgpu: create amdgpu_vkms (v4)")
Cc: stable@vger.kernel.org # 5.15.x
Cc: hgoffin@amazon.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -341,7 +341,8 @@ int amdgpu_fbdev_init(struct amdgpu_devi
 	}
 
 	/* disable all the possible outputs/crtcs before entering KMS mode */
-	if (!amdgpu_device_has_dc_support(adev) && !amdgpu_virtual_display)
+	if (!amdgpu_device_has_dc_support(adev) && !amdgpu_virtual_display &&
+	    !amdgpu_sriov_vf(adev))
 		drm_helper_disable_unused_functions(adev_to_drm(adev));
 
 	drm_fb_helper_initial_config(&rfbdev->helper, bpp_sel);


Patches currently in stable-queue which might be from alexander.deucher@amd.com are

queue-5.15/drm-amdgpu-fix-check-in-fbdev-init.patch
queue-5.15/drm-amdgpu-check-bo-s-requested-pinning-domains-against-its-preferred_domains.patch
