Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACCFD15D8F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 13:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E413D10E4F2;
	Mon, 21 Oct 2024 13:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="znAi2JaR";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5495810E428
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 07:33:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 383B75C54AD;
 Mon, 21 Oct 2024 07:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3017C4CEC3;
 Mon, 21 Oct 2024 07:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1729496004;
 bh=rTi0ClV3Jdvwk0fn4DZF+vGIxnIcmEmB6CyxMm0o0sI=;
 h=Subject:To:Cc:From:Date:From;
 b=znAi2JaRAw5CoANKAREOiW320EdmA7OjAzqY5ZkcU6GYzMHwyfLZhy1p8k//cG1QT
 cW/s7KOXID1VwKEZW02tjCRIVmVHoNFvZt3qbjUYs+Rmndt747uhge/ZLcebFUN2SR
 o2VzzjnDZ8kfAohpHeTN/WHAoY4ZJr56UDfmCTUY=
Subject: Patch "drm/radeon: Fix encoder->possible_clones" has been added to
 the 5.10-stable tree
To: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 erhard_f@mailbox.org, gregkh@linuxfoundation.org,
 ville.syrjala@linux.intel.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 09:33:18 +0200
Message-ID: <2024102118-spotter-exile-a6fb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Mailman-Approved-At: Mon, 21 Oct 2024 13:06:33 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


This is a note to let you know that I've just added the patch titled

    drm/radeon: Fix encoder->possible_clones

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-radeon-fix-encoder-possible_clones.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 28127dba64d8ae1a0b737b973d6d029908599611 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Mon, 14 Oct 2024 19:09:36 +0300
Subject: drm/radeon: Fix encoder->possible_clones
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 28127dba64d8ae1a0b737b973d6d029908599611 upstream.

Include the encoder itself in its possible_clones bitmask.
In the past nothing validated that drivers were populating
possible_clones correctly, but that changed in commit
74d2aacbe840 ("drm: Validate encoder->possible_clones").
Looks like radeon never got the memo and is still not
following the rules 100% correctly.

This results in some warnings during driver initialization:
Bogus possible_clones: [ENCODER:46:TV-46] possible_clones=0x4 (full encoder mask=0x7)
WARNING: CPU: 0 PID: 170 at drivers/gpu/drm/drm_mode_config.c:615 drm_mode_config_validate+0x113/0x39c
...

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Fixes: 74d2aacbe840 ("drm: Validate encoder->possible_clones")
Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://lore.kernel.org/dri-devel/20241009000321.418e4294@yea/
Tested-by: Erhard Furtner <erhard_f@mailbox.org>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3b6e7d40649c0d75572039aff9d0911864c689db)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/radeon_encoders.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/radeon_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_encoders.c
@@ -47,7 +47,7 @@ static uint32_t radeon_encoder_clones(st
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
 	struct drm_encoder *clone_encoder;
-	uint32_t index_mask = 0;
+	uint32_t index_mask = drm_encoder_mask(encoder);
 	int count;
 
 	/* DIG routing gets problematic */


Patches currently in stable-queue which might be from ville.syrjala@linux.intel.com are

queue-5.10/drm-radeon-fix-encoder-possible_clones.patch
