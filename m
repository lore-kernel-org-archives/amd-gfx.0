Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D132C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 08:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92CD610E9E7;
	Tue,  1 Sep 2026 08:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lp1CDTos";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB8110E3D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 08:41:41 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so4802405e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788252100; x=1788856900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VH693aZWqTFohLEaFlmz+59mfLrTNfzbiznohx60gs0=;
 b=Lp1CDTosNZj4EAz92oGLsORYge8equKs5BR9TyLZnRDywa+utePk4+sBgqDxBoSf9S
 jl+n+FurAekS39EcrozlwhlshCKkqHoypHrhx/ZjFSptnhywPFs5xJQSsganhhir2x9K
 H+5Au+GgBffTRjihYT/jOUwB0/PeKYg0PiTIl6SU/12Vjmu0Acin9TNTEce/oudcV2AH
 MihzbbQQrFHXuNX/DRyneMqKZV2djhRuqDdjX9jZEEVAEjh1EEmd5f20DvOlL7dOf/RE
 s41+RNGNDH3ahzV9NcqxDA2Q5QZymjTT4s4cMNTpJIaSuM4KbNUp5SZWzJ3YdzRs77L4
 7VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788252100; x=1788856900;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VH693aZWqTFohLEaFlmz+59mfLrTNfzbiznohx60gs0=;
 b=K8YfdfW8pCp5hQRsa+WnGXf2lAr8iiFUXcEaLmYy04u+0T6IX29rk1au7vsx0s3nby
 pKLzxJ5DWEFjWL6CEosr55Nd/Ewa+nUfTdFR/GPjVbM3hXq8bCGqoZTkOyUYxesp33d+
 PAqTIrG4vQiMvdZsDMccU3Wc0ikgtmJ6hQJ7J6UeKQi7mBy3RYZPTrSG57T2T4PqeYu2
 s5hmYT080412Y+wIWz0VZMQFWJ3RZTgK468jeWsWdod0qkrvLZaK5TaROkwGgko3MO37
 Ycr00gIPlUGGatNCN5uo5lp9OoEs2eKJsWVBADyqv3stS7i/463VCcKxpRpSCiGuEw4w
 oRsw==
X-Gm-Message-State: AFuF++k7p9pOFzWe8aPqgXE6hNjBBd9KNFX+Fjx+OyyaGlQvAdmPV7Lx
 uhsBNY+Umbp3K49Io1hs9yoSyWDsp5txBFlU3M7TuQU4qGyAb0LMUl14VArmXdgxEzk=
X-Gm-Gg: AR+sD12MHM3lwvd9khuodIxtpvPLizyPIm2mKjzHBG6shlKYw7Hp5S4u6jNbg3d8HU2
 tmaxDiNk0Ft3iFa2E4jOWh0AwYrBxy66EIrmmy640rL6fFvOKI4No4q9oJy0Ux8UcNKbfCTnUsV
 aachAsCywtpTfaAcU9R+gBWPdf4Cy8+nQqfu22E7xtPw0GWiHxIl2czOxsGugW4k9Hc70nV7OTd
 4n6W+0ASuSCWhEJcWUOFsbo9WryLbOJJOir6+0ToGYnAHbzKW/eW5z7qaSbBx/52tFMgMOsWL6C
 NrFj7JFRlBZwZUpvVsgQC0NsRdDrh7gOzbFYwuaS+qUrNacHmypGWgJOUcJ/3IITgc2bX0Ioq/1
 9T57Sz3w5OBmXsIBz2ZPMVAnOyVVUVjpADjcanmTzHVPGMFfY8gDWzIgmdQZG+NLjBSbjHeN1Uw
 bj7T+SlIRv8VbyPll2vG9kS7ZRubRhDWmHs9UKdCmvTPNUj09i/YYjh353dByrGRTq55KmUNseO
 wwCAfn2pW3hjTe64dA95Xs=
X-Received: by 2002:a05:600c:5288:b0:499:84fe:5f3e with SMTP id
 5b1f17b1804b1-49b91c41014mr550312215e9.9.1788252099597; 
 Tue, 01 Sep 2026 01:41:39 -0700 (PDT)
Received: from Timur-Max (athedsl-4457084.home.otenet.gr. [79.129.242.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce08b8esm47139235e9.3.2026.09.01.01.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:41:39 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 8/8] drm/amdgpu/sdma: Use common SDMA legacy queue reset on
 SDMA v4.4.2
Date: Tue,  1 Sep 2026 10:41:15 +0200
Message-ID: <20260901084115.262457-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901084115.262457-1-timur.kristof@gmail.com>
References: <20260901084115.262457-1-timur.kristof@gmail.com>
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

Now, sdma_v4_4_2_reset_queue() does basically the same
as amdgpu_sdma_reset_queue_legacy() so let's use that.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 796ea9f74763..60bb22d0a43b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1574,20 +1574,6 @@ static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
-				   unsigned int vmid,
-				   struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-	u32 id = ring->me;
-	int r;
-
-	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, id);
-	amdgpu_amdkfd_resume(adev, true);
-	return r;
-}
-
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -2031,7 +2017,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-	.reset = sdma_v4_4_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2063,7 +2049,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-	.reset = sdma_v4_4_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.55.0

