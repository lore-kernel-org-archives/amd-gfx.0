Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E33C54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 09:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A7510E426;
	Thu, 21 Mar 2024 09:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QOCuzrJL";
	dkim-atps=neutral
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8491B10E0C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 18:32:31 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-6e682dbd84bso62093a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710959550; x=1711564350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jvE/YAlLIID+4LJPvrVDJGXOyu18SAUsKjsPMay6KZ4=;
 b=QOCuzrJLGYskHCyozL5w+obIDfg3bJJteO1DXM5waQfN9u7TIjdyC90VlAr/826OCB
 11ihWx4DekWR3nLoQsMuP586rEay+JoY19xS7ue0XurbsJr+SjmAVEXscuSeLjntbve9
 MIywLB7wh3DuHLwqpDY6jf1GXD87NQ5rbkNXsTt/EQSGHNVsgKI/ref+FTwYH+z6jNk0
 +CVIaB+JXnvqJsPBZGM7uQc5hUzQf8ii11ztd71yhqnOUCf4TMQhsAJ/CRB1wP8q3gty
 DqASpzZOiqe2HYgrrf7mdfB08OVMi/R8JSk0/R228zGsLo9hyJ6IznLM7Xc0uQLXw8IB
 bv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710959550; x=1711564350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jvE/YAlLIID+4LJPvrVDJGXOyu18SAUsKjsPMay6KZ4=;
 b=q0wi3jJ8kafl3HgnnpQsY4ZB3aDgMXevvJwbM68In7LyfnpdEPgbJJquyJziCsnpJQ
 8pyzNCz0n/kS6dJz9khApv8fhb2/dr4JQOmR4r35wgh7AFNRyyoEwHigV2HPM/YzRwJr
 GdHxRCx4j8jYHjFG2sC89jc5pP3D79cRgjlbl8Tr7zt9lu908QV6INTdYDrENWQ7Ia+R
 T9zVC6B3V9CizJjq3dU1lvR8t8JeqcaBuXoEoizSQGaeiyZZ+61GgDoPBJ0ggLU5v7DU
 zwIePuS5bvwzDUnCu6jJIjzMG+/quHJ48urbNLca+Y5NDFlmKHBy1Kw4uhCJKIdCAqRN
 Rdow==
X-Gm-Message-State: AOJu0YzIdHcITmR/RXN10pc12V23G+aPaevvj1A+RMJ6YKzz8YuxJ7ne
 p0Xvczc1uLXPI7ODlqZTCx9/5dir2PAqVlz/0hpWd63n/l18jo8Nwpai6mEO
X-Google-Smtp-Source: AGHT+IG4OGiUysOk3I4lMirT0253dGaQZx6iGmF1x7TUZ53J8x5oPjp+NXADlQ8CgtXcqCTdMNvhiA==
X-Received: by 2002:a05:6830:1d70:b0:6e6:8516:4866 with SMTP id
 l16-20020a0568301d7000b006e685164866mr12997829oti.16.1710959550260; 
 Wed, 20 Mar 2024 11:32:30 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:70:f702:9c77:c230:a0ba:a1a1])
 by smtp.gmail.com with ESMTPSA id
 r14-20020a056830448e00b006e67151c396sm2389930otv.33.2024.03.20.11.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 11:32:29 -0700 (PDT)
From: Mario Limonciello <superm1@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Flush GFXOFF requests in prepare stage
Date: Wed, 20 Mar 2024 13:32:21 -0500
Message-ID: <20240320183221.5689-1-superm1@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Mar 2024 09:21:12 +0000
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

From: Mario Limonciello <mario.limonciello@amd.com>

If the system hasn't entered GFXOFF when suspend starts it can cause
hangs accessing GC and RLC during the suspend stage.

Cc: <stable@vger.kernel.org> # 6.1.y: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
Cc: <stable@vger.kernel.org> # 6.1.y: cb11ca3233aa ("drm/amd: Add concept of running prepare_suspend() sequence for IP blocks")
Cc: <stable@vger.kernel.org> # 6.1.y: 2ceec37b0e3d ("drm/amd: Add missing kernel doc for prepare_suspend()")
Cc: <stable@vger.kernel.org> # 6.1.y: 3a9626c816db ("drm/amd: Stop evicting resources on APUs in suspend")
Cc: <stable@vger.kernel.org> # 6.6.y: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
Cc: <stable@vger.kernel.org> # 6.6.y: cb11ca3233aa ("drm/amd: Add concept of running prepare_suspend() sequence for IP blocks")
Cc: <stable@vger.kernel.org> # 6.6.y: 2ceec37b0e3d ("drm/amd: Add missing kernel doc for prepare_suspend()")
Cc: <stable@vger.kernel.org> # 6.6.y: 3a9626c816db ("drm/amd: Stop evicting resources on APUs in suspend")
Cc: <stable@vger.kernel.org> # 6.1+
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3132
Fixes: ab4750332dbe ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 94bdb5fa6ebc..1fbaf7b81d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4524,6 +4524,8 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	if (r)
 		goto unprepare;
 
+	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
+
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
-- 
2.34.1

