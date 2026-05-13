Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A50CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 17:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FBA10EF98;
	Wed, 13 May 2026 17:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g7DbNEMl";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B1610EF95
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 17:08:56 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so118116135e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 10:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778692135; x=1779296935; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIAry4Fl8m3SbuCHBgV0MeE4dNheVsAUzlGChvYeJsM=;
 b=g7DbNEMlVfbuj0R5sOBd0piPy7swWez87QGPBtkeoZd2zHG4MLb0F/ZuPb89MD/Ihb
 dF03Y9X4dx3Bd0fB1FwodbkJmH9pN6bIwIN2FzElewRBSBP9udo5Tuanam3vlzYyZIPY
 yRIPyRGtvk/pSXc2QLRnD5zOLWpROjxyu4cgyxVO8cP9OC7Ox218B8vaOsnUdTiKFe8K
 bMolm/MiwpGNizDFYg0KQ/yGoRkcbnI6cmoJV21gAIfORA0mU4Zw/cYxDe2Lp7r4sRya
 tmQrSLpIJhHDz+CpCPYA1ZigKkQCGsImA07AKHWa24Ylox1ZeQP6V6mlQfHoCo0W6ZfR
 k3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778692135; x=1779296935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lIAry4Fl8m3SbuCHBgV0MeE4dNheVsAUzlGChvYeJsM=;
 b=MuAmZqETPHujxyj3tPbBTNXSLN923xTx8xujJGSt9aTZnz+NB06l2a68W0gr3IjMB8
 7gmmCikzyPw6rbmoKM9YAdfeX1IuOcHb8u/LhNaK1H3QP1fM/D5Y8oLkI/Bb0eUjF4h9
 9Jt6F2WbMyqCbWPcRAOA2S6KBv2CNZI3vKRYrdtB0HisKU3KkpnrJWKMrTW5glBN9Ty5
 3shfmwptukP+6wBJ9LjROeTVuUD+ELU3gTNF1msA593s2WMhhJFi5CLNkQt3dqu8olcV
 hiczEpuA9N/Uydbr5ugIccWn4KJKS8ONHJZEzgZQjEeVzzOo6KKI3/lfST9wBZDiUa1b
 g4Rg==
X-Gm-Message-State: AOJu0Yx435p1JtR5x4lPQwuisKfIzOy4yGnAJagl3u41wubRmUjLraDb
 5T0mS76to7mucOI77r3c8Bw9ZYrxjuOwZ46GL1Ez+UfbhmrF+dyF7wfcGY3hg8Y+
X-Gm-Gg: Acq92OEoRZ486Fy+zsp0c4LcXlzkYsbO+nx5LtNCAqK/HTm+PGn/h+HRkviMF2jVf6K
 8AlL8EpbXlYmeWHfv+aPZK4+XVPk8QAU6KvjGKamtVIBFHZIQZWDHQYiVv0275putqp9lRYI4Ud
 3084kBZej4c5E4TJbDUulCQ34RJQav7SzRUvj/MFyv2DR1ep1u0LTFXei36ypUpOjgPhMKD0qZ6
 penraJVLACComjLk+HKMcstrO2Dt+T24Il7Gm+e7KEQAAClOCVXyagixd+0Ayw04wK2zTzT1+6e
 yEsXhWXoHfMtpwGYAKa9iLTyhYSne63MDmQFa+8r9mxNH8yU1JhnIY4euA4hEqJDKM2c3vLd3G5
 0xsUSr0vQXeePSvG0EfApXS/ZOrZM77+YxFZp1ggiuhKaBbVLJVz8hTIZ7XiqZNPQ7ARgTr5LAJ
 OAsbb+6M6hQWzYZHomVYXVLqiYRsXgjVVusfJRGyYWI83L4sBkZnx7QKPzYw==
X-Received: by 2002:a05:600c:4ed0:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-48fcea12514mr62153495e9.23.1778692135237; 
 Wed, 13 May 2026 10:08:55 -0700 (PDT)
Received: from Timur-Hyperion (540017BE.dsl.pool.telekom.hu. [84.0.23.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64a017esm4339175e9.9.2026.05.13.10.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:08:54 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 amir.shetaia@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amdgpu: Use system unbound workqueue for soft IH ring
Date: Wed, 13 May 2026 19:08:49 +0200
Message-ID: <20260513170849.27061-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513170849.27061-1-timur.kristof@gmail.com>
References: <20260513170849.27061-1-timur.kristof@gmail.com>
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

Allow the kernel to dispatch the soft IH work on other CPUs.

Otherwise it can happen that the soft IH ring fills up
before it actually starts processing anything, which
can easily happen with retry page faults, in which case
the CP repeatedly spams the CPU with a lot of interrupts.

This significantly improves retry page fault handling on
GPUs that don't have the filter CAM and must rely on
software based filtering.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 82bc6d657e5a..515fc32051c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -549,7 +549,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
 			 unsigned int num_dw)
 {
 	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
-	schedule_work(&adev->irq.ih_soft_work);
+	queue_work(system_unbound_wq, &adev->irq.ih_soft_work);
 }
 
 /**
-- 
2.54.0

