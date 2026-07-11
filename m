Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66F6C44501
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jul 2026 11:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3394410E12D;
	Sat, 11 Jul 2026 11:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bci10ace";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7003E10E12D
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 11:30:13 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so11825635e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783769412; x=1784374212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j3zaTFD4DmYHtC+mCgns+/CoT/DzymKPOF5vmvmtm7Y=;
 b=bci10aceXNrMmnNC8mbRB3+n3hNG7TOByS0u2gQmn/bT9J/X42NOm5abr35Wi8Jn7g
 EaSrMyMCb9BvbX8/AJy92Tu9wH059Xj/2akkrte5/cYuGqZA2KaBldOe9D8ams9NythH
 FhkInDVcnRvly2coDtaH40NzDxZe6oHtrqnf/VR+NcVFNUu+yiTktKylyZrGuvIhAzwS
 chXM/a0/BBqFzMiMRPVhVGKfW6JVGLPSiGCBzoZJFIDB8nMWKNFgyX2XaK3hCbcdb4Ot
 HqLj/HBJd1C5d6OYjrUCKcwJGg8McxtGms2xDfen4DHZCTUNY8YjO4eTwrsINw6ZkVnh
 Bx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783769412; x=1784374212;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j3zaTFD4DmYHtC+mCgns+/CoT/DzymKPOF5vmvmtm7Y=;
 b=fePQlzzX8s1K2L0zXt/v1DvMyZCAx4OugEkSskJAmY6xkq0CgkeKGE1HBKDhTa9iZ5
 vuW7aPWpnnijyPu65NXMSXKB3jLMsfoJLgXNN3W/K4dygtFpV+ec48sefSyu1eQe3ydj
 oxhO1ZFhzbT5t9qLT75BAzGnoGvGaFQMIqXXR2dypgy1NKXKVhAOpskdWLTYbDBv13OT
 dzeIhJhcLBx4LKf8s0MnmlVlgJJ3XE9zASCS6XjONmqz5OJnXWgei0z+lLCfzLPPds77
 ogq2AWe+XZXld1x2XSWuwJChkRn0dfcqIzkjBgURgVp7naR0KZBULDYf+HW44b0Aa1q5
 XZ6g==
X-Gm-Message-State: AOJu0YwuRkoMr2aBp0OzXjPPq1a0EAVufvdeSy+zSk9jloKnDis5jHp0
 v4I3Hh59HOYoe27zmjlO5ywDZQMN21l5Jfy57Q33RrADyIyErAqMtz6aW/ZqCg==
X-Gm-Gg: AfdE7clwH9MVemjD1JpFPF0srjCtv/3TZ8ri7BUIt4jWWZlufeYJANBgyb2986rrWhy
 cEPeJkn6a0Cy4f91GjZOqF1Ryc8kMeLqBk6IPiDstVgtR/A7CY0TbJ6/iWTbKoHNbVxir3WhGSR
 0kzdUoXeTPK46Oj4qEj7qOAXN7lLHdHLjJX3zdUhXkl9esVTMBZFGpE4VCPjfQlWP4oQgokV6Tc
 /PvKOkMcbKF957L1cdtJztNHS1SGgihfpO5s8sbJTN0r5uPUbkayisGPMXDMFPXMHvAieW5p/YE
 gyFnLoQKtphIHZAo1KemTefabGwxi6jHiz20Qp9xsHn+/SoMMD+scI474fx3xH9PYFqgkbDL+NY
 4WP6RJP0cRZ/PZnKxFHO6s1vaPnbiUdukTg/O1bCmHwg1RlaGTjsPAOnGUPj0hl36fjvlfJvtUc
 I13yplU02cLLXY5CohhcLXO9e1RHx0pcR0Tap/RfxmiCJI5QztYPlS1Q==
X-Received: by 2002:a05:600c:1f91:b0:493:e79e:daa6 with SMTP id
 5b1f17b1804b1-493f8826e69mr21321075e9.33.1783769411747; 
 Sat, 11 Jul 2026 04:30:11 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f373csm349931035e9.14.2026.07.11.04.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 04:30:11 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, mario.limonciello@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/2] drm/amd/display: Shorten name of FRL polling workqueue
Date: Sat, 11 Jul 2026 13:30:08 +0200
Message-ID: <20260711113009.26512-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The current name is too long and triggers a warning.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b97ceabe6173..6299f0e384f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -829,9 +829,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	}
 	if (adev->dm.dc->caps.max_links > 0) {
 		adev->dm.hdmi_frl_status_polling_wq =
-			create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
+			create_singlethread_workqueue("hdmi_frl_status_polling_wq");
 		if (!adev->dm.hdmi_frl_status_polling_wq)
-			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_workqueue\n");
+			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_wq\n");
 	}
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		init_completion(&adev->dm.dmub_aux_transfer_done);
-- 
2.55.0

