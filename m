Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49938C432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 16:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11ED460EE5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 16:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11ED460EE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CD16E17E;
	Wed, 11 Aug 2021 16:52:27 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id A85016E17D;
 Wed, 11 Aug 2021 16:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 6602120201C;
 Wed, 11 Aug 2021 18:52:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id saKEmysyc0p3; Wed, 11 Aug 2021 18:52:12 +0200 (CEST)
Received: from kaveri (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 9B27920201A;
 Wed, 11 Aug 2021 18:52:12 +0200 (CEST)
Received: from daenzer by kaveri with local (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1mDrSd-0001mh-Fc; Wed, 11 Aug 2021 18:52:11 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Use mod_delayed_work in amdgpu_gfx_off_ctrl
Date: Wed, 11 Aug 2021 18:52:10 +0200
Message-Id: <20210811165211.6811-1-michel@daenzer.net>
X-Mailer: git-send-email 2.32.0
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

In contrast to schedule_delayed_work, this pushes back the work if it
was already scheduled before. Specific behaviour change:

Before:

amdgpu_device_delay_enable_gfx_off ran ~100 ms after the first time
GFXOFF was disabled and re-enabled, even if GFXOFF was disabled and
re-enabled again during those 100 ms.

After:

amdgpu_device_delay_enable_gfx_off runs ~100 ms after the last time
GFXOFF is disabled and re-enabled.

The former resulted in frame drops / stutter with the upcoming mutter
41 release on Navi 14, due to constantly enabling GFXOFF in the HW and
disabling it again (for getting the GPU clock counter).

Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a0be0772c8b3..9cfef56b2aee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -569,7 +569,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 		adev->gfx.gfx_off_req_count--;
 
 	if (enable && !adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
-		schedule_delayed_work(&adev->gfx.gfx_off_delay_work, GFX_OFF_DELAY_ENABLE);
+		mod_delayed_work(system_wq, &adev->gfx.gfx_off_delay_work, GFX_OFF_DELAY_ENABLE);
 	} else if (!enable && adev->gfx.gfx_off_state) {
 		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false)) {
 			adev->gfx.gfx_off_state = false;
-- 
2.32.0

