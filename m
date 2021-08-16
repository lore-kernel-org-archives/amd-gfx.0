Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B9C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 10:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FED961BA9
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 10:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FED961BA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1ED188C11;
	Mon, 16 Aug 2021 10:35:20 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 92BBA88C11;
 Mon, 16 Aug 2021 10:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 3605F20201B;
 Mon, 16 Aug 2021 12:35:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id wNa0coHE_UJH; Mon, 16 Aug 2021 12:35:08 +0200 (CEST)
Received: from kaveri (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id D7D4C20201A;
 Mon, 16 Aug 2021 12:35:07 +0200 (CEST)
Received: from daenzer by kaveri with local (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1mFZxS-0000ht-QT; Mon, 16 Aug 2021 12:35:06 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/amdgpu: Cancel delayed work when GFXOFF is disabled
Date: Mon, 16 Aug 2021 12:35:06 +0200
Message-Id: <20210816103506.2671-1-michel@daenzer.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813102920.3458-1-michel@daenzer.net>
References: <20210813102920.3458-1-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Michel Dänzer <mdaenzer@redhat.com>

schedule_delayed_work does not push back the work if it was already
scheduled before, so amdgpu_device_delay_enable_gfx_off ran ~100 ms
after the first time GFXOFF was disabled and re-enabled, even if GFXOFF
was disabled and re-enabled again during those 100 ms.

This resulted in frame drops / stutter with the upcoming mutter 41
release on Navi 14, due to constantly enabling GFXOFF in the HW and
disabling it again (for getting the GPU clock counter).

To fix this, call cancel_delayed_work_sync when the disable count
transitions from 0 to 1, and only schedule the delayed work on the
reverse transition, not if the disable count was already 0. This makes
sure the delayed work doesn't run at unexpected times, and allows it to
be lock-free.

v2:
* Use cancel_delayed_work_sync & mutex_trylock instead of
  mod_delayed_work.
v3:
* Make amdgpu_device_delay_enable_gfx_off lock-free (Christian König)

Cc: stable@vger.kernel.org
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 22 +++++++++++++++++-----
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f3fd5ec710b6..f944ed858f3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2777,12 +2777,11 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
 	struct amdgpu_device *adev =
 		container_of(work, struct amdgpu_device, gfx.gfx_off_delay_work.work);
 
-	mutex_lock(&adev->gfx.gfx_off_mutex);
-	if (!adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
-		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))
-			adev->gfx.gfx_off_state = true;
-	}
-	mutex_unlock(&adev->gfx.gfx_off_mutex);
+	WARN_ON_ONCE(adev->gfx.gfx_off_state);
+	WARN_ON_ONCE(adev->gfx.gfx_off_req_count);
+
+	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))
+		adev->gfx.gfx_off_state = true;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a0be0772c8b3..ca91aafcb32b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -563,15 +563,26 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 
 	mutex_lock(&adev->gfx.gfx_off_mutex);
 
-	if (!enable)
-		adev->gfx.gfx_off_req_count++;
-	else if (adev->gfx.gfx_off_req_count > 0)
+	if (enable) {
+		/* If the count is already 0, it means there's an imbalance bug somewhere.
+		 * Note that the bug may be in a different caller than the one which triggers the
+		 * WARN_ON_ONCE.
+		 */
+		if (WARN_ON_ONCE(adev->gfx.gfx_off_req_count == 0))
+			goto unlock;
+
 		adev->gfx.gfx_off_req_count--;
+	} else {
+		adev->gfx.gfx_off_req_count++;
+	}
 
 	if (enable && !adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
 		schedule_delayed_work(&adev->gfx.gfx_off_delay_work, GFX_OFF_DELAY_ENABLE);
-	} else if (!enable && adev->gfx.gfx_off_state) {
-		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false)) {
+	} else if (!enable && adev->gfx.gfx_off_req_count == 1) {
+		cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
+
+		if (adev->gfx.gfx_off_state &&
+		    !amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false)) {
 			adev->gfx.gfx_off_state = false;
 
 			if (adev->gfx.funcs->init_spm_golden) {
@@ -581,6 +592,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 		}
 	}
 
+unlock:
 	mutex_unlock(&adev->gfx.gfx_off_mutex);
 }
 
-- 
2.32.0

