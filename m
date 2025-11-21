Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A02CFC279
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 13:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3A710E8D7;
	Fri, 21 Nov 2025 13:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dKLOaGm4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31D510E8D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qEMVybQPlNezvYU2zJ1rFZRpzQ6bDRScYd8zrC/Rjzk=; b=dKLOaGm4OjE3n+VtujRMQxROu6
 /gHO6jTx5oB7YbuM7e8jBSUuffQFnm2+dM3cf/ZY9O8BRWB2+aGV7bWTvWV03ix+KfzmPwrqx0aDY
 LiZ0zF/LDEehzZu/jsD3FoqEF57P7TM4A99ZD3aLmpWtMkrfOow5sfTN6It46g3ra+Cof+bnxJ4mT
 RvJIG0O6g7X4yxgY4Ez3cq5ExBCx7KxOycBDwAP3woKZdElI4W6VoB0cn7OnBYFd+Zvt+TqBdsbhU
 wQY4moSu8IzwdfidO1nLoLX1pfhndnKyFDHpXAix94tjC+DIrcHv+yLx/YG2SmtLFg5hJitVm1F0Y
 dFd/v2/w==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vMRdR-003gP2-Hc; Fri, 21 Nov 2025 14:57:13 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v5 1/2] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
Date: Fri, 21 Nov 2025 06:55:28 -0700
Message-ID: <20251121135658.459620-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121135658.459620-1-siqueira@igalia.com>
References: <20251121135658.459620-1-siqueira@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 54f7c81f287b..10c9e0044ade 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3682,6 +3682,20 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 				"failed to release exclusive mode on fini\n");
 	}
 
+	/*
+	 * Driver reload on the APU can fail due to firmware validation because
+	 * the PSP is always running, as it is shared across the whole SoC.
+	 * This same issue does not occur on dGPU because it has a mechanism
+	 * that checks whether the PSP is running. A solution for those issues
+	 * in the APU is to trigger a GPU reset, but this should be done during
+	 * the unload phase to avoid adding boot latency and screen flicker.
+	 */
+	if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu) {
+		r = amdgpu_asic_reset(adev);
+		if (r)
+			dev_err(adev->dev, "asic reset on %s failed\n", __func__);
+	}
+
 	return 0;
 }
 
-- 
2.51.0

