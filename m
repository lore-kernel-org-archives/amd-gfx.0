Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A44CCD183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 21:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4DD110E361;
	Thu, 16 Oct 2025 21:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WzcOHxcV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489B910E361
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AaA5TreIKIOzfEvRdgxO64fxEsbbJSXkllWkcRp8cDU=; b=WzcOHxcVr1YQZKiZCjZZMCDegj
 0uqSVQb/1IsGcoGOfQDklDRBishAKCcPmHESztUUUczu4EGrak7AiUA96eV9HyqimX/NxL4XJOLRs
 H4BwS39J5HpHPurTYttfaibL1yONxTQnAcD+SnXYMIwGdR0RK5/CMSm3b1KLHAdnKjPFjIvXhVCyk
 8Ptddq3oD4abZljrS54GZFQxVXHi2+wNlmezNxIk0WDj8Y0wh/Mq4Uwf5pLCTw7AQJdM8pijRUFa4
 JwL7MzCpWFRn0Kauq2D77Jut/OdDFGvbuEF/zHbmUHCPPeFfS/yzW5d3kdL1MwGz7FEJP6dwi2JG6
 JMBa5w4A==;
Received: from [104.193.135.201] (helo=debian)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1v9V5L-00AcNT-RT; Thu, 16 Oct 2025 23:00:32 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
Date: Thu, 16 Oct 2025 15:00:06 -0600
Message-ID: <20251016210018.901389-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.51.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When trying to unload amdgpu in the SteamDeck (TTY mode), the following
set of errors happens and the system gets unstable:

[..]
 [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
 amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on gfx_0.0.0 (-110).
 amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
[..]
 amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
 amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
 amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
 amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
[..]

When the driver initializes the GPU, the PSP validates all the firmware
loaded, and after that, it is not possible to load any other firmware
unless the device is reset. What is happening in the load/unload
situation is that PSP halts the GC engine because it suspects that
something is amiss. To address this issue, this commit ensures that the
GPU is reset (mode 2 reset) in the unload sequence.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0d5585bc3b04..78009b93855b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3613,7 +3613,7 @@ static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
 
 static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 {
-	int i, r;
+	int i, r, current_reset_method;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].version->funcs->early_fini)
@@ -3649,6 +3649,17 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 				"failed to release exclusive mode on fini\n");
 	}
 
+	/* Reset the device before entirely removing it to avoid load issues
+	 * caused by firmware validation.
+	 */
+	current_reset_method = amdgpu_reset_method;
+	amdgpu_reset_method = AMD_RESET_METHOD_MODE2;
+	r = amdgpu_asic_reset(adev);
+	if (r)
+		dev_err(adev->dev, "asic reset on %s failed\n", __func__);
+
+	amdgpu_reset_method = current_reset_method;
+
 	return 0;
 }
 
-- 
2.51.0

