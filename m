Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A85CF58E1
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 07:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5CD10E7CB;
	Fri, 20 Sep 2024 07:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="LFeL2c5J";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4167510E748
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1726770550;
 bh=gsufGAYtIAM8AkakiwxVNuxyvm44kSowZzBK+ouwLxs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=LFeL2c5JC0FlizRr+k0e1HZUmA1E10VmrVXCWiXc9QyUvGZBGrsnM8x2gwEgqW0tB
 zn/Qx4UhRc8ZOf8D8ysfC/OCWEzOqqvWCWZET86+1Izqpq8Qp5tjuGXwLe+pFfxZKl
 /dq5nKDzQw8/lHZtFPA5A3kg7UNnRKQxN0Br43eI=
X-QQ-mid: bizesmtpip3t1726770541tlc1512
X-QQ-Originating-IP: WzUcVFiVE3UagY0mvSWHGPMGplCkVM/luSeXsZy8DV0=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 20 Sep 2024 02:28:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7623271536529475562
From: WangYuli <wangyuli@uniontech.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 vitaly.prosyak@amd.com, yifan1.zhang@amd.com, Tim.Huang@amd.com,
 jesse.zhang@amd.com, Prike.Liang@amd.com, Hawking.Zhang@amd.com,
 kevinyang.wang@amd.com, srinivasan.shanmugam@amd.com, Jiadong.Zhu@amd.com,
 tao.zhou1@amd.com, pavel@ucw.cz, lee@kernel.org, aren@peacevolution.org,
 wangyuli@uniontech.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, le.ma@amd.com,
 Wenhui.Sheng@amd.com, jjhiblot@traphandler.com, guanwentao@uniontech.com,
 zhanjun@uniontech.com
Subject: [PATCH] treewide: Correct the typo 'acccess'
Date: Fri, 20 Sep 2024 02:28:55 +0800
Message-ID: <4AB1F900B5D100C2+20240919182855.85840-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-Mailman-Approved-At: Fri, 20 Sep 2024 07:23:04 +0000
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

There are some spelling mistakes of 'acccess' in comments which
should be instead of 'access'.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 2 +-
 drivers/leds/rgb/leds-group-multicolor.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d3e8be82a172..f847a9fc61e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1894,7 +1894,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
-	   acccess. These should be enabled by FW for target VMIDs. */
+	   access. These should be enabled by FW for target VMIDs. */
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 408e5600bb61..13dca7377f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1248,7 +1248,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
-	   acccess. These should be enabled by FW for target VMIDs. */
+	   access. These should be enabled by FW for target VMIDs. */
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
diff --git a/drivers/leds/rgb/leds-group-multicolor.c b/drivers/leds/rgb/leds-group-multicolor.c
index b6c7679015fd..548c7dd63ba1 100644
--- a/drivers/leds/rgb/leds-group-multicolor.c
+++ b/drivers/leds/rgb/leds-group-multicolor.c
@@ -55,7 +55,7 @@ static void restore_sysfs_write_access(void *data)
 {
 	struct led_classdev *led_cdev = data;
 
-	/* Restore the write acccess to the LED */
+	/* Restore the write access to the LED */
 	mutex_lock(&led_cdev->led_access);
 	led_sysfs_enable(led_cdev);
 	mutex_unlock(&led_cdev->led_access);
-- 
2.43.0

