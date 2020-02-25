Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672E5C35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACFC21556
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSGqeE7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACFC21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE016EA94;
	Tue, 25 Feb 2020 11:16:26 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92576EA94
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 11:16:24 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id t23so2570180wmi.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qCqDrTAa7dPoPZKa2pmnUjtkQiPYqZPgGg8PjdDkqYA=;
 b=bSGqeE7SxxeZ0W5U9HuwNA1qJfdYeg33xLa0CtSYhiPTsMokwPZ8cnwqjcMnFnjk8I
 0Nv9SzkLfCxQG+oXgtw9Bdflg+44K0/SW71p0B8IuaX+bNGKFCvDI6/2J3H7H9zPM7Ac
 5lOv/mWyEYpgq+ui2kiz4oWfoxgp93fSNVET66eSPJpIZ+5p3AWBTyZjx0CwU2tjzlOF
 LT01ozsTbAcdkf+eTXHxNA/XNU6WO8Z5u8SLNxkoC1BMmIeXAlCNyIBqxXI5VYynnB21
 M6WLORktPQPaCzO3o7GLIub9uQb8QQZtpehIDtGEu+GXH84RD7H8MTc3mu4Omlf0ePyO
 H22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qCqDrTAa7dPoPZKa2pmnUjtkQiPYqZPgGg8PjdDkqYA=;
 b=GfeYvY06HpRlLQsXrqkwolHF6SvYJgEoLFNfso5B3qXxwC9HNrU3P5aX2QR2BoQybY
 G7soHpe0zGWYiTOlSyiQtViw7EWFIIZujpqJiK7V5zW1VJrjkDPlcQdYv8x0YJii8Ool
 OWC9nxRMbxjGezo4yN45XGvVyfirHZYXdsfNZIylFMQzt1sQ+PvQyeVM9EMUZEKqqZZl
 gswVPbGWtvf940auOjJxbMA/gOi8li4WlIYi5Ol5kRO5T6TFiuv7HhIJixs1Q6WZUPQ6
 lDG5KtxLWWEjCYWomnHeIJKVfHOYkzFK5xW13p8JY01rNfd2ggQwOejqYYH+I5GhklPY
 Sxrw==
X-Gm-Message-State: APjAAAVN+zM9rhpR4/OPAOoCjYY9n4aocxeq9aJ+6pQA4t/aXkeeggAR
 wv9t7dhFyifoo+hqW/zfSKtQSeMhPrjMLA==
X-Google-Smtp-Source: APXvYqxs9xd/NCrKf3VUQ7R6Mok9XkwiESUpuzt9nEs71pkK8+jNjrsCEQY8WGC4sXQzaaGK/2glcA==
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr4947521wmd.91.1582629383146;
 Tue, 25 Feb 2020 03:16:23 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2CDD00254CE01175F766E4.dip0.t-ipconnect.de.
 [2003:c5:8f2c:dd00:254c:e011:75f7:66e4])
 by smtp.gmail.com with ESMTPSA id w22sm3553062wmk.34.2020.02.25.03.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 03:16:22 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: cleanup amdgpu_ring_fini
Date: Tue, 25 Feb 2020 12:19:21 +0100
Message-Id: <20200225111921.14453-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cleanup amdgpu_ring_fini to check the prerequisites before changing ring->sched.ready

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 539be138260e..18e11b0fdc3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -344,12 +344,13 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
  */
 void amdgpu_ring_fini(struct amdgpu_ring *ring)
 {
-	ring->sched.ready = false;
 
 	/* Not to finish a ring which is not initialized */
 	if (!(ring->adev) || !(ring->adev->rings[ring->idx]))
 		return;
 
+	ring->sched.ready = false;
+
 	amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
 	amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
