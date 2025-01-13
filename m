Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCFEE77188
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 03:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D4910E142;
	Mon, 13 Jan 2025 03:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gBMLhMt+";
	dkim-atps=neutral
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1B010E142
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736739617; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=adwfxpcMmCkuLof16rAvrxJMIgOzifMDc7gkpgeS+LU=;
 b=gBMLhMt+vlKzAv9HZE1cLdL7zuL6TXFQ+Awg+jgHvCccM5doNvalMuhugwLrIkY6XDFBAPSoNXrtJJoaSnK86vEaK+OwV5UNvHxxzCyB1kAurOHFNGL0AX3uFUrGWl7zVvmZo2BA1Mhghw9gcwcR3N5HvDbj+JPRAwWw+EQ/TD0=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNSPYgh_1736739614 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 11:40:15 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, Prike.Liang@amd.com,
 asad.kamal@amd.com, sonjiang@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH 1/1] amdgpu/soc15: enable asic reset for dGPU in case of
 suspend abort
Date: Mon, 13 Jan 2025 11:40:12 +0800
Message-ID: <2462b4b12eb9d025e82525178d568cbaa4c223ff.1736739303.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736739303.git.gerry@linux.alibaba.com>
References: <cover.1736739303.git.gerry@linux.alibaba.com>
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

When GPU suspend is aborted, do the same for dGPU as APU to reset
soc15 asic. Otherwise it may cause following errors:
[  547.229463] amdgpu 0001:81:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)

[  555.126827] amdgpu 0000:0a:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
[  555.126901] [drm:amdgpu_gfx_enable_kcq [amdgpu]] *ERROR* KCQ enable failed
[  555.126957] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <gfx_v9_4_3> failed -110
[  555.126959] amdgpu 0000:0a:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
[  555.126965] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -110
[  555.126966] PM: Device 0000:0a:00.0 failed to resume async: error -110

This fix has been tested on Mi308X.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a59b4c36cad7..0e1daefd1a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -605,12 +605,10 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
 {
 	/* Will reset for the following suspend abort cases.
-	 * 1) Only reset on APU side, dGPU hasn't checked yet.
-	 * 2) S3 suspend aborted in the normal S3 suspend or
-	 *    performing pm core test.
+	 * 1) S3 suspend aborted in the normal S3 suspend
+	 * 2) S3 suspend aborted in performing pm core test.
 	 */
-	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			!pm_resume_via_firmware())
+	if (adev->in_s3 && !pm_resume_via_firmware())
 		return true;
 	else
 		return false;
-- 
2.43.5

