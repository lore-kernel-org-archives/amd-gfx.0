Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2746C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 19:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C347208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 19:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C347208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22F26E4CB;
	Fri, 19 Jun 2020 19:01:06 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493746E430
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (ip5f5af4f7.dynamic.kabel-deutschland.de
 [95.90.244.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id CA01920643C4C;
 Fri, 19 Jun 2020 20:50:25 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/3] drm/amdgpu: Warn about disabled DPM
Date: Fri, 19 Jun 2020 20:50:09 +0200
Message-Id: <20200619185009.12966-3-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619185009.12966-1-pmenzel@molgen.mpg.de>
References: <20200619185009.12966-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 19 Jun 2020 19:01:06 +0000
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, besides there is no explicit message, that DPM is disabled.
The user would need to know, that the missing success line indicates
that.

    [drm] amdgpu: dpm initialized

So, add an explicit message, and make it log level warning, as disabling
dpm is not the default, and device performance will most likely suffer.

Resolves: https://gitlab.freedesktop.org/drm/amd/-/issues/1173
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Use new print helpers, and inform user about effects.

 drivers/gpu/drm/amd/amdgpu/kv_dpm.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
index f054ded902f2..c601587c6d59 100644
--- a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
@@ -3014,8 +3014,10 @@ static int kv_dpm_sw_init(void *handle)
 	adev->pm.current_mclk = adev->clock.default_mclk;
 	adev->pm.int_thermal_type = THERMAL_TYPE_NONE;
 
-	if (amdgpu_dpm == 0)
+	if (amdgpu_dpm == 0) {
+		drm_warn(adev, "amdgpu: dpm disabled per parameter. Your graphics device will run with lower clocks impacting graphics performance.\n");
 		return 0;
+	}
 
 	INIT_WORK(&adev->pm.dpm.thermal.work, amdgpu_dpm_thermal_work_handler);
 	mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index f7edc1d50df4..1f35d5a36300 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -7687,8 +7687,10 @@ static int si_dpm_sw_init(void *handle)
 	adev->pm.current_mclk = adev->clock.default_mclk;
 	adev->pm.int_thermal_type = THERMAL_TYPE_NONE;
 
-	if (amdgpu_dpm == 0)
+	if (amdgpu_dpm == 0) {
+		drm_warn(adev, "amdgpu: dpm disabled per parameter. Your graphics device will run with lower clocks impacting graphics performance.\n");
 		return 0;
+	}
 
 	ret = si_dpm_init_microcode(adev);
 	if (ret)
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
