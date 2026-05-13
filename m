Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1643BCD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 16:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0BB10EF40;
	Wed, 13 May 2026 16:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="luHstAbA";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC2710E5E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 16:30:51 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so47773725e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778689850; x=1779294650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejhL1U4VICHx8A94Ci1FX9fF8v1hc3K0KJRXB+HfGSQ=;
 b=luHstAbAlII8josvyf+vH8VdtFIv09SOxBQpNPakQmeEHHUSCHl7iwCjI0vaOyeVxf
 d+r27k+k9kGsFfVkwA0Fk3uWNSaInzbKInbxjcrC9i1lX0Us3q0yHRwVWgQ/lhgWwB4n
 EOkBh7CCCNTs+KDDPx672ezdpykJD2pLR5RuFFFAZ9iCFYCYpPPzgR14nJ7diDr4F83V
 JZuAVG6QT8hC6ohDSQMnW+ZSJ2oNfQLvEyMXVZ6AKqXpHXCk0Puvq/lMwiKTSz++RWsr
 9e58BeZS0qnrgeivR9OR1xXm/M5DuWKh/nBRUYdcs7VzOWyAMdmJ961+mpua4rcb7ozT
 Ij3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689850; x=1779294650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ejhL1U4VICHx8A94Ci1FX9fF8v1hc3K0KJRXB+HfGSQ=;
 b=BmYlDSM/vqUi9CDvf3KTFzxWAxMnrw3bLsE7iTy0u9AFSCb6/kPR8+uLRDivcc9zC6
 8j++1gB7VA6AQLvRPNoiTzzuGaNd2PlB1rFY1HWIZk+4iZ4uP0GMqb+Q8YfS+KdRCLEQ
 StHlOopnML83UDnqx8puloIDd0skhlXKoQLDDKrX41bN/lavVjW8W5P9K0y6uhSxFaS/
 1LEYy6RFvqvK/76zvXp49oZCW0cpWugEq/1+vZCRdMa6n2q4gldf93E5Yp5qM956LqMW
 53wvgbzJW25nNQhYh3YOZb3MSRQB57S0mdtNXOXoyXLOKxWnIOYfQcM/1oU9mHzkFCY5
 x0Jg==
X-Gm-Message-State: AOJu0YzEBTFMK94tbzcJCurlYrvwhLGylGKRH8j5kYZSNt6DcW/i5SMx
 4ejw4WtR4cBjHbqNOdUIKK6GECy/l3N7idTVoPYVQbpoITiiLgaEEcwiUHyvwQ==
X-Gm-Gg: Acq92OFqJ7GB0aD7ED00AKaH+jtxpBxV30zBJ+qkrnh4uR8S0t62VicmZ2rax4rj9+3
 Dxk2ExI2I3qRpzs/VjUCGIDu3LTuVQ6/qbX89Qk0M/YrL77hRIQ/yQ1rOValipzThl3kyUDnVod
 0//K7jWuIztw/1yGcWsFRdEIKbqHCoG+VOajgNt6Ros4bNHVkuYtqwjLLDXJXYxwBUg4weQk8vc
 FfAiPidSoUqIREgmJ9pHf5qoiaTq0NzUndZ1Y00ffmPRXawAEP96WbEKmXja9kDf2JYuMJ0Us8B
 5d0JgAHN/5D1n2rqLnYTsGwFy0JuG49BCEeISiEN9sdWeySq/jHM0fcNc+XT2no5CN3kKE9yTYI
 +4Z59WzYMpKdR3RU6wEDm56H0j3qA+wbaq7ZmDrzss4QavWeBfUOeST57SNN48mY/L9lKmJd1t9
 eQ6rj/4rTCPHBDoxDXfPAtxxQgTlE+Jb0Pke3Sz5eW4qAmx0184pu1cPO6Zw==
X-Received: by 2002:a05:600c:489a:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48fd6368dc3mr1854955e9.10.1778689849663; 
 Wed, 13 May 2026 09:30:49 -0700 (PDT)
Received: from Timur-Hyperion (540017BE.dsl.pool.telekom.hu. [84.0.23.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64b5271sm1846385e9.14.2026.05.13.09.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:30:49 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/6] drm/amdgpu/gmc: Don't compare page fault timestamps with
 other interrupts
Date: Wed, 13 May 2026 18:30:41 +0200
Message-ID: <20260513163043.8725-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513163043.8725-1-timur.kristof@gmail.com>
References: <20260513163043.8725-1-timur.kristof@gmail.com>
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

Different interrupts may have different timestamp sources,
which shouldn't be compared.

If we compare the timestamps of retry faults to timestamps
of other interrupts, it may result in all retry fault
interrupts being filtered out, because of the different
time stamp source.

This issue was observed on Strix Halo.
Solved by storing the timestamp of the last page fault interrupt.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..52258f1341c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -437,9 +437,12 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
 	uint32_t hash;
 
 	/* Stale retry fault if timestamp goes backward */
-	if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
+	if (timestamp == adev->gmc.processed_fault_timestamp ||
+		amdgpu_ih_ts_after(timestamp, adev->gmc.processed_fault_timestamp))
 		return true;
 
+	adev->gmc.processed_fault_timestamp = MAX(timestamp, adev->gmc.processed_fault_timestamp);
+
 	/* If we don't have space left in the ring buffer return immediately */
 	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
 		AMDGPU_GMC_FAULT_TIMEOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 676e3aaa1f27..77eb15380284 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -361,6 +361,7 @@ struct amdgpu_gmc {
 
 	u64 noretry_flags;
 	u64 init_pte_flags;
+	u64 processed_fault_timestamp;
 
 	bool flush_tlb_needs_extra_type_0;
 	bool flush_tlb_needs_extra_type_2;
-- 
2.54.0

