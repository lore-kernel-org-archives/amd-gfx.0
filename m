Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E6CCAC5AC
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 21:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9159610E168;
	Tue, 23 Sep 2025 21:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="b2kdelfI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A0110E168
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l8JgW8AbINCgrm9uWS1dmkqQpaZR6jzTyrO7TNPhkgk=; b=b2kdelfIjPJB8sikdUocFXH4vS
 iU0P3F72gGjnhMb1PJFwS1lrCIZupapYhnYfWAiVBNwbWIMd8/UGD5DRYVc52senpm8QtmtKpuyQL
 pGYbB4yJEPmzGrqWlvrHoJ3m3wXXESujSOcaSHS90jQgUTkToQ4cQP8RwissUI1OOuSeS4qpo/z1s
 Qu6c+N9iEc+8JeGaRTO4KvbYOPElezV4JzJN8Y1pTv1RF6KRJdmu8ub+5gzGk3T4FfvsLb9AvNbm2
 b5bxkKEnTM32/dnk78NgrD/kdalGep1Jk4CdkiMNV/AkP0ASncim6PKhSB3cvxED5LxcYhCxrqGaz
 R3Sb0LxQ==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=debian.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1v1AJJ-00GS1W-5V; Tue, 23 Sep 2025 23:12:29 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is reloaded
Date: Tue, 23 Sep 2025 15:11:06 -0600
Message-ID: <20250923211216.306525-1-siqueira@igalia.com>
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
GPU is reset (mode 2 reset) in the load/unload sequence.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 50e77d9b30af..1964aa37c499 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -543,6 +543,13 @@ static bool nv_need_reset_on_init(struct amdgpu_device *adev)
 {
 	u32 sol_reg;
 
+	/* GFX in the SteamDeck hangs when amdgpu module is reloaded, since the
+	 * firmware is already loaded. To avoid this issue, ensure that the
+	 * device is reset to put the PSP in a good state.
+	 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 1))
+		return true;
+
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
-- 
2.51.0

