Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F825606A334
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=thundermail.com header.i=@thundermail.com header.a=rsa-sha256 header.s=2025nov03r header.b=LopAVSd+;
	dkim=pass header.d=thundermail.com header.i=@thundermail.com header.a=ed25519-sha256 header.s=2025nov03e header.b=mp0PCWjL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C12112CA0;
	Fri,  6 Nov 2026 09:26:09 +0000 (UTC)
X-Greylist: delayed 431 seconds by postgrey-1.36 at gabe;
 Fri, 06 Nov 2026 01:00:44 UTC
Received: from mail.thundermail.com (smtp000.thundermail.com [5.60.96.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1525610E167
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=2025nov03r; d=thundermail.com;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793926411; bh=hX6fHPoMae6QZG/82DWlelg
 KW5hA95Bl5//zD2ys9vs=; b=LopAVSd+sMROhEuGBDo86V/m73ISX8thnK3XMlXgBeSrimlJ/N
 arceM5C11hC4Cu6H0oS/mzVpkA4UyQDeQ6fWEcickP2iqkfguoc5vef+KRDPhdUn8k4lo5Mp/Ic
 OqoOXKCMH9Iv5ttXgI8sD67xyGm+oo+ZmMxm38sjfYTmnLJ5B0c8yZkx0BSyISdAT15/LxWlu30
 pB1Ehp624dpUkKg2Pa7q+WJIJRcITkhFoTEluS+Uy7mFA+kaQUrclW2ZESBo48+2dlcnGSN0v+z
 nfedizJKlvPS70bOgHZPUouh2lHrFXae21Z1elBuKQKGB56fK5pth9cG7buM0AftaSw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=2025nov03e; d=thundermail.com;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793926411; bh=hX6fHPoMae6QZG/82DWlelg
 KW5hA95Bl5//zD2ys9vs=; b=mp0PCWjL02yfBRNcijl39/3I/i4b944Sqqk2etymkjGgFM6IPw
 AALWBhcvPzY+b13XTwC+ccHbAZOQHJSTN0CQ==;
From: William WOJCIECHOWSKI <w.woj@thundermail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, William WOJCIECHOWSKI <w.woj@thundermail.com>
Subject: [PATCH] drm/amdgpu: enable fence interrupts before KFD init
Date: Fri,  6 Nov 2026 01:53:19 +0100
Message-ID: <20261106005319.17428-1-w.woj@thundermail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:26:02 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Navi 1x, GART TLB flushes go through SDMA once the buffer funcs are
enabled, and amdgpu_gmc_flush_gpu_tlb() waits for the job to finish.
KFD init does two GART allocations, so it waits twice, but the fence
interrupts are only enabled after amdgpu_device_ip_init() returns. Both
waits end on the fallback timer:

  amdgpu 0000:0c:00.0: Fence fallback timer expired on ring sdma0

That's about 1 s lost on every boot.

Enable the fence interrupts right after the buffer funcs, before KFD
init, like amdgpu_device_ip_resume() already does.

Signed-off-by: William WOJCIECHOWSKI <w.woj@thundermail.com>
---

Notes:
    Tested on an RX 5700 XT (Navi 10) with Debian's 7.2.12 and 7.2.15
    kernels: both messages are gone and the probe is about 1 s faster.

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b0e282b2..ce979a1bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2545,6 +2545,11 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (amdgpu_ip_member_of_hwini(adev, AMD_IP_BLOCK_TYPE_SDMA))
 		amdgpu_ttm_enable_buffer_funcs(adev);
 
+	/* KFD init flushes the GART TLB through SDMA on Navi 1x and waits
+	 * for it, so the fence interrupts must already be enabled.
+	 */
+	amdgpu_fence_driver_hw_init(adev);
+
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
 		amdgpu_amdkfd_device_init(adev);
@@ -4135,8 +4140,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		goto release_ras_con;
 	}
 
-	amdgpu_fence_driver_hw_init(adev);
-
 	dev_info(adev->dev,
 		"SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
 			adev->gfx.config.max_shader_engines,
-- 
2.55.0
