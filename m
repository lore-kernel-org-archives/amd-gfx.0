Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02EEC61DD7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B5D10F35B;
	Fri, 28 Aug 2026 11:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YK9eyuYt";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FA110E510
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:22 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c2529b3139fso115746666b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917281; x=1788522081; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/iMR6U04I7CrxZKGnHJPAB7TLCyz3pTI9xaztbhFXZU=;
 b=YK9eyuYtO3tEMhcslQ0RnOC4Z3AfhLcDI15Jftlh/bcvh6idEVnv33nOYT37vfPwz7
 dTUYORYPStLp0BjTiO9vG0AWFYA3jle8WZkS2FX5z7S5jL8DLcm6BZVedk255aQdbEtY
 i0sBRkMlPjZgRULVus18mKrI8O0TkfyMEWvRqipuCkXnAddYcVFlPAOpd7oNCef7gG6T
 RlMk1fqSiaXFQaihUEx6ypxAKaRGfVk8z8WhiuSYzblisouXnm9zAg8VMAPs9V+QSnEE
 WPGTSXf95cdbENy9kyLojW01SXky7ITgHEbLM5P4a0OZGBkyJtj5RDbNhPB3vxjJqRLV
 PejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917281; x=1788522081;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/iMR6U04I7CrxZKGnHJPAB7TLCyz3pTI9xaztbhFXZU=;
 b=Qyf3J1oGJ6jNjfEq/ZYY1TI80ffw0bVdJsFt2pq9MNWC2cCa9SppkdLMUFnSS8lDs8
 JQYnC0p2JQEcMjs1tFJGdtj428GfOeQM06QsjE03leE3wkIsHj5VcaA/VIIZYjvqkM4z
 mgn85BBxPkIphqR4+PLWctvOmEjaJtwfTVAMl137DA3UwwYHliX9rarcf2h2HHQwnhpM
 aZZu4zfN5vC4Hekfs7l7rANPzj6Cla6HW9DnLd9vk+a994o4H4PDXNWPPRvaeApZ/Xyu
 4KrZ1hgVbdwNmZUAGqk/iY1ee02B0m0S/cYLcYUnGO4C4FKVhtaXaRKORYpa2C4HHorH
 5PuA==
X-Gm-Message-State: AFuF++mTIdigcCLS3h2opLTUWRZY/QRfEBVsJqHO0x9z7EW72WvatqMb
 gvz0uQ895uJbeIg4jR+HtU2JGOvSxECv437dfHPW5yvyPMr0RQQmQPH5eIvsDfXB
X-Gm-Gg: AR+sD10S32cxVxvUCkzHKoLh096czqbXGFi1kLUmeBV5+lHn86msXXmhdECQ559mRqi
 QppctONTMmDzGfeRUWtusxW/C4Oqkc1A9tCSzQJI4FVnjzTa8J6uwSoxsBmmOtu0ZFjWjpPIjZG
 hl3Mw5/kLwDtp6wLOF6v2L8lEV/HuYK6bXRZGOw4wxNRtx2FPiY/Cz57ci3rV8EguOO4GJiEzIm
 SzsRRqKklUg31Pq0HDE+M3QCARFc02vIE7gyyN0MJU4aWTS0gMpvIpwWnVxhhl7k43Vc1dF5dtz
 AXl6ih/Sk99T3FLOiv5qjI/OcqjSejcHw1NWjJL+KWeW7Bwo0SWhcEWPWrak5QqL7inmjBaHCB1
 2tJwyjlKLWXTvUl+5/99OTDslHwJsP4ZsHTBISyl7NtOoUEm1GmbufkEuoK4qhPqVkKL8ei9ZXU
 cCmq+tIdDjFJ9CevfX8m4PM7g906FLjjYba1oJsfhCarYWJAvNKL5/XPvKP7V0QYOJ8Q0a94q57
 IdoQBCFq8uDt4faeYKbMjYY
X-Received: by 2002:a17:907:9612:b0:c16:4e5:944a with SMTP id
 a640c23a62f3a-c25574341c1mr384814066b.21.1787917281117; 
 Fri, 28 Aug 2026 04:41:21 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:20 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 03/11] drm/amdgpu/ih: Don't perturb HW registers when
 accessing soft IH ring
Date: Fri, 28 Aug 2026 13:41:05 +0200
Message-ID: <20260828114113.13523-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828114113.13523-1-timur.kristof@gmail.com>
References: <20260828114113.13523-1-timur.kristof@gmail.com>
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
We shouldn't read (or write) any HW registers when accessing it.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c   | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c   | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 4 ++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 512c76d97840..4470df45b7ea 100644
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
index bae86e5fa316..6bbf89d048e7 100644
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
index 6265ee4b0ff1..f271bc8c4859 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -460,6 +460,10 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device *adev,
 	struct amdgpu_ih_regs *ih_regs;
 
 	wptr = le32_to_cpu(*ih->wptr_cpu);
+
+	if (ih == &adev->irq.ih_soft)
+		goto out;
+
 	ih_regs = &ih->ih_regs;
 
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
@@ -530,6 +534,9 @@ static void ih_v7_0_set_rptr(struct amdgpu_device *adev,
 {
 	struct amdgpu_ih_regs *ih_regs;
 
+	if (ih == &adev->irq.ih_soft)
+		return;
+
 	if (ih->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu = ih->rptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 7a167ad93fd0..1dae7df9ee17 100644
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
2.55.0

