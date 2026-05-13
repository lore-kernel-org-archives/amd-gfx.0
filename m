Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F009CD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 17:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2880210EF95;
	Wed, 13 May 2026 17:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mrU5hqb+";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24A310EF94
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 17:08:55 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so32160835e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778692134; x=1779296934; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6r+YM4OpSJ7DUGmuYqOY51P7Qz9sA0fOAhA0/mb/P4=;
 b=mrU5hqb+XZEOQGY54SptEDH1ZWJMSh9EhYbA/Ti8az9p0oIRoRSbW6ZY0LZeYeIJJn
 wGCUOJHmUrXA4pukkqKdoSZrM5b4zpFuCMVXAyHq4sgw6B5t543sSz3wSCpaCmivog2c
 6/9+Jie0ZmiDfHy+Yd46Yhc4V2kNuGi2czKDtpW+bYhng6fzYU4DHft8vzm7vkfVo44d
 pRP3gLoMdt0sKPGhXciHNrmF5ZERLMaaN1fZehS/XZTPwmJ+WyP8eur5d8sTi+lT00GV
 ZlnFdNXWr+C9RZkLCcpdvrreOrgHvCR04xZSlMGXdN0rdaiITy+kGhUeykgHBRBXsPeP
 EaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778692134; x=1779296934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J6r+YM4OpSJ7DUGmuYqOY51P7Qz9sA0fOAhA0/mb/P4=;
 b=rN6FGQqSaRvTazmnLk1EP2SrX28x5U6biWXqXI87gdq0kGcq19MqSm/JxeDIeoKs7J
 QqLXiovypUscVnybxige9u7OTZHc8/XQYJLv5oe2BkUzJkTwUpPt4vXxBJpX/FXvvPLe
 hJPrrI0+3FjtuogqeDfAuC8JzKdLwDI8fbm3YCMOnwFIN79eTGoFaYxxHIpD/BCSfNbv
 8Y6iFnDysdo1zKp2AR9zoCqdfO9MxGrBLwiTpdWbKKva8zXOta7Q8OXY3OxJ13lHyliH
 uTp8JuGNMO5pW1fpFvrc1G22Q5BRFIzCDaTXGuwvH4DusIBy5W6pxysq2SCBYv3gD5VW
 BvZg==
X-Gm-Message-State: AOJu0YxJWsF/iZP5AJAh7Gej6gdmw+zkZLTwtLUNI+5h/lzB945id5QB
 3JrrT9QrGXjxaAK3Y34hN/paqKOjFNHCLZsTVXRm2lK27xRCrPvZIagXlOu0JLOJ
X-Gm-Gg: Acq92OF2f5xvTIUTdsIH5p5WdI7jQALOhHb/I8A6Jy0BBs4lcKoYc68i5MyRfDSFiID
 goBbAXZgRKrOXm4hC6ELAEN3wnCCNTowpTh6QR8n5sCD+c6Hg4IZcSEE3Yd+m0L1uMeMekCQhkN
 fstNip0Wk5cwZBVIBEZNt0FpyUUw2ElSh1pgpm98Ljtzs4X3wNCmwVcKnButePe18enUpxiSQ5g
 wzeO99V60v0Icn1jz6hTQrU3LtUjhDJ6yQYer5CG/nNmihFlLfv+jqvyQDQ+PR0FaAA4nn4LRps
 VI3vOddar3KqRrbk/sBMJoeXjMqYqXpiqG/vYd6v5lrxMusjNl98oIKzzYpIzB08my5qI6Dui9b
 FhkZeTsIK4qOdLJSJh2U2Xhvs+h4MoaPFf9bJ2KLgyIRiGBXOpO5ZlYIcXcfEBbQ5f4v5vMZrj3
 1KwsOWvz71aDycx0SUefm+UNNyJVHLozgsOvldlcl50eTWYE7FnAl3uEgtXA==
X-Received: by 2002:a05:600c:1d14:b0:48a:54fd:54ea with SMTP id
 5b1f17b1804b1-48fce9c3a2emr57990335e9.12.1778692134159; 
 Wed, 13 May 2026 10:08:54 -0700 (PDT)
Received: from Timur-Hyperion (540017BE.dsl.pool.telekom.hu. [84.0.23.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64a017esm4339175e9.9.2026.05.13.10.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:08:53 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 amir.shetaia@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] amdgpu/ih: Don't perturb HW registers when accessing soft
 IH ring
Date: Wed, 13 May 2026 19:08:48 +0200
Message-ID: <20260513170849.27061-3-timur.kristof@gmail.com>
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

The soft IH ring is implemented entirely in software.
We shouldn't read (or write) and HW registers when accessing it.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c   | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c   | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 4 ++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 333e9c30c091..65e5d21753f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -439,6 +439,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
 	struct amdgpu_ih_regs *ih_regs;
 
 	wptr = le32_to_cpu(*ih->wptr_cpu);
+
+	if (ih == &adev->irq.ih_soft)
+		goto out;
+
 	ih_regs = &ih->ih_regs;
 
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
@@ -514,6 +518,9 @@ static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
 {
 	struct amdgpu_ih_regs *ih_regs;
 
+	if (ih == &adev->irq.ih_soft)
+		return;
+
 	if (ih->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu = ih->rptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 699c274d357e..9dbc20131410 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -410,6 +410,10 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *adev,
 	struct amdgpu_ih_regs *ih_regs;
 
 	wptr = le32_to_cpu(*ih->wptr_cpu);
+
+	if (ih == &adev->irq.ih_soft)
+		goto out;
+
 	ih_regs = &ih->ih_regs;
 
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
@@ -481,6 +485,9 @@ static void ih_v6_1_irq_rearm(struct amdgpu_device *adev,
 static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
 			       struct amdgpu_ih_ring *ih)
 {
+	if (ih == &adev->irq.ih_soft)
+		return;
+
 	struct amdgpu_ih_regs *ih_regs;
 
 	if (ih->use_doorbell) {
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 6de9e87e04e1..bd332e8cc5bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -457,6 +457,10 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device *adev,
 	struct amdgpu_ih_regs *ih_regs;
 
 	wptr = le32_to_cpu(*ih->wptr_cpu);
+
+	if (ih == &adev->irq.ih_soft)
+		goto out;
+
 	ih_regs = &ih->ih_regs;
 
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
@@ -527,6 +531,9 @@ static void ih_v7_0_set_rptr(struct amdgpu_device *adev,
 {
 	struct amdgpu_ih_regs *ih_regs;
 
+	if (ih == &adev->irq.ih_soft)
+		return;
+
 	if (ih->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu = ih->rptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 4cd325149b63..e7ed37bb48e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -417,6 +417,10 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
 		 */
 		wptr = le32_to_cpu(*ih->wptr_cpu);
 
+		if (ih == &adev->irq.ih_soft)
+			goto out;
+
+
 		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 			goto out;
 	}
-- 
2.54.0

