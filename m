Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC43C5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 21:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3A010F3C6;
	Fri, 21 Aug 2026 21:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nd5NG4xq";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2074610F3C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 21:51:15 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-495437bb891so8791515e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787349073; x=1787953873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SLIdIMwtg6hmuElT87snzi5QvoiBB/nJuufhjLBaaBg=;
 b=Nd5NG4xqU4opPqMsarzyIdkqMoIuqtcu1JrLoE8MM+YX7Q/y0zv6kS/NCrHG64b4bc
 mHL8Ydh5QmeW0h4mHp9VXN20V8hNhIdGizP/qXgAbU1qsMg/4+rlOtb5e45F82tedPEg
 fadMvrBNZJKsRNYjaXCfUwOipek1uTlJLKAcnfptE77Rb9bM500qwwaNSInEb0mT5L3R
 K4MrXKzzjK+RLKUzonC+RyTIJrw3C3XSYi8rnA9G7Yi4Gv4lysg7JWOy2MfM4/qtkvoN
 S/yNebfNI0nopvk9A/uLTqFksYDgnwG13xyEEgW9IHzu61kyeVYqAT9NOAo7fMxHiWCX
 vv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787349073; x=1787953873;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SLIdIMwtg6hmuElT87snzi5QvoiBB/nJuufhjLBaaBg=;
 b=ZzA3TcvBVy1QwGxjMI4xcmhJTp192ScelCXpCTHxH0EvnSPBTwPQC/EXag4w+8Zj5O
 4SYxbZ62OC7wjzWcSmvvDWMgocczEdhNWUxpuAlgyzTP7gxjOWrdGdog9CjQZ5UECvwn
 3KYAGWpo82zHtGFBJjmUF1Ct94bVFo6fsEF3/WCJq8GAsZ8cQiRQRu4SydGNeh6p9QWr
 sNlWqRCEbuMPOTcHU0PD3zMnu/ndpfcrMznzMBH+qexLMqv0tUqxVR+8gGV2R3xdKSiN
 ff6/gY1Ue53xYuDfbIDWaVYxHi08zQgvrAhRoJDfD0UB531cFMGFTXUc7xLse3fpI/84
 N4KQ==
X-Gm-Message-State: AFuF++nUZGoqs3K0p/pxTS3w18sAj9AXGn05VOnTz8hgfwMwgLb/y7sd
 3IOHZNBnRVYIxbUJedF8unjajQp8+HwtVjqNOqAm0dOnDF1EoBUni1Glzt6g0k1L
X-Gm-Gg: AR+sD10/+duy8vzkNM9UjAPshmCBkoAed/xVWs8XGh6+Ws7Wvf0J7aeb2rpYiOsk1MQ
 CtZ5vGtK+BmP0OYchAncWxVFaxVtTCE3Lva3pgEOulTkB8MtkepJuBrAURO3XsYiRMLv7tiiIrz
 exNYiRdmcntUs2Db96x4RFATIJ6WAdWNNF/SHEjde5Y4GXAklnly51Z5fD5f2uf0Xqe0ioFjSdo
 Bji2+3dsxhOlxjg6pmtGjVSeBtS0rjf+Wh0LqeqQjY3c82oWgsZh9eY6eqe77C298kiXGawxrFt
 3BmM9xVO13gpxvGBEatNLQewY0r60Ec7p0GP0HV82k+PO1wqMJN3xqoYRZkLi5k5fw9odgN07ZE
 anNi2mD3m3JGnmLfr+M4S7ZY938Uv5+FmD4oJ+p5WVxpyrEU0MG+2zsXPkKUC31DXzTfNfJ/Dp5
 e2327HBAmLKJRYUkj0egKA8dPfxNq+dKY4nDK+ypL0C4ZpPVZ0D3axvSyMzrOvFyLruxTwk2gz8
 D2+J12Tgn3Y4tMbub321WrpxUhqGX3b
X-Received: by 2002:a05:600c:1912:b0:499:8d9b:832c with SMTP id
 5b1f17b1804b1-499b9182141mr84526575e9.4.1787349073407; 
 Fri, 21 Aug 2026 14:51:13 -0700 (PDT)
Received: from Timur-Max (static-133-28-26-46.ipcom.comunitel.net.
 [46.26.28.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c3566d4esm365415e9.8.2026.08.21.14.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 14:51:11 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Melissa Wen <mwen@igalia.com>,
 harry.wentland@amd.com, Leo Li <sunpeng.li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/2] drm/amd/display: Log details when failing to register HPD
 IRQ
Date: Fri, 21 Aug 2026 23:50:59 +0200
Message-ID: <20260821215059.312868-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821215059.312868-1-timur.kristof@gmail.com>
References: <20260821215059.312868-1-timur.kristof@gmail.com>
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

This should help diagnose HPD IRQ related issues in the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 9be63996b062..d0239a3de2e1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1735,7 +1735,9 @@ int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev)
 			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 				int_params.irq_source  < DC_IRQ_SOURCE_HPD1 ||
 				int_params.irq_source  > DC_IRQ_SOURCE_HPD6) {
-				drm_err(adev_to_drm(adev), "Failed to register hpd irq!\n");
+				drm_err(adev_to_drm(adev),
+					"Failed to register hpd irq %u for %s!\n",
+					int_params.irq_source, connector->name);
 				return -EINVAL;
 			}
 
@@ -1753,7 +1755,9 @@ int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev)
 			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 				int_params.irq_source  < DC_IRQ_SOURCE_HPD1RX ||
 				int_params.irq_source  > DC_IRQ_SOURCE_HPD6RX) {
-				drm_err(adev_to_drm(adev), "Failed to register hpd rx irq!\n");
+				drm_err(adev_to_drm(adev),
+					"Failed to register hpd rx irq %u for %s!\n",
+					int_params.irq_source, connector->name);
 				return -EINVAL;
 			}
 
-- 
2.55.0

