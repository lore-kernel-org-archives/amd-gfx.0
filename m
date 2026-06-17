Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D55ACD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8D310F0CE;
	Wed, 17 Jun 2026 19:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LkvglkBm";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E9210F0CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:48 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4922244f7c7so603575e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723687; x=1782328487; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpd/wwMrXpj03ZBkmR7leZl7qqa3rMp86usexfFyvT8=;
 b=LkvglkBmL5RLSsJSQSZmbDuhhPqxE2zeCVIa0OMsThiqNm82vgIea45DfuXFHswJXU
 uPI6KqAzMLYkbqiIXEC3cQWAwyQttlwYYxoGdPuh9gkJQvGTTVwmwvgcxCdiGaC/uLqu
 UNe2t3zYoPC6DE8dHg1W+iSSocMneCl9BHJ+8gjunSW+34p0fO/fc2svC8KdTAwgUSqe
 9B8+opCNTo6l4fN3nUHWSf3ZQQLGlnd4NkFAThvgm+0XsbULh8U8i7Rtd7K4XuCIpz9A
 pQc6XXXvXIO5uh7xHm7jc86KKchMXARZ87RgCElgvHSmhUJurjPRzCwfNtPlrlrclYkH
 y3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723687; x=1782328487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fpd/wwMrXpj03ZBkmR7leZl7qqa3rMp86usexfFyvT8=;
 b=r6m6QB8v1jbbEX71RELpqgtYDmfexmHw5o38484MnhFiB2eJmqpHj1rf1OY73JN68k
 mO+gTcJjNX9sVEEYz7ApZEZH7tnVsKllZAIkrnW3nu5G/W67oIv+m50hR6E9Jy9F8PRs
 Ihj3CK6WtHqkRYgbDl5I3Py1cJNGT0PH66JwVpEDqvkG3s4+SodMqsrDEfoxdEZGn6xD
 k97KAYRYx/0DjEFrJeMsdOQpRnSI9P+SF8GGU7v4ThGjUe1zNAfpyHG7TolXh++PJW32
 +57EyunK7EPKw0MuNrPflGsEgaXNjh0qUGlNtL2gi6m3ndmM3D2PvH/pd5QDNX+9i5Lt
 RZ7A==
X-Gm-Message-State: AOJu0YxS3EzfJ/rQzaey72SE/YAY89o2n1sjeedNPuu5Pw9HowMx/cCS
 ZTDlVHUtll2eopKNV8N7/lzHKACsUQ45XNG6xCmoDHHNLlcakaAJ+CiEosWv7w==
X-Gm-Gg: Acq92OF1T4zBJqksonR6nfH9Nq4rc+Y3vLuVzfbYtwSjyZ98GV1fqNff4mQ4LfZC/nj
 QLZPJXD3oBF/H+Qy+xQUx2JtGlXERtEqtorAuD0TZiPIlyc4ZfSj6nWFBt7iIETXjRSliTcj+hI
 DvfbQZiR1tKekz3RgOYszS+8DU2UpwU7GQkYFWPWLCet2ZUGUrXSQ5atBduFm1cZ5Pub5N27zjY
 rqxHF/0aKbxwRgx3r5T5vU712UVdzQL6PMbG/Qj4gdK4r/wLZZtmkJAKThA4leESI1Mnvk+VDDO
 l/nkfaaS1iNBkcChk42ETbUj/ulL0g41FQ5govVLXhh66UcVYXQ+R5FZCtLkOteNNwTfu36Ad4a
 BA19T8s6mo05VMU7531PiNo3ynABJOd+dMQQk7NPS35O08qb8OReo0iH/5venFHJ6guwVJWioo6
 tVMByBMvRcu7PILq+1I7T55WzdvjJx0hX6l52xMu+bd3vQOp0kjU4Qug==
X-Received: by 2002:a05:600c:c114:b0:492:37b7:607a with SMTP id
 5b1f17b1804b1-4923822ef66mr9183285e9.31.1781723686985; 
 Wed, 17 Jun 2026 12:14:46 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 13/17] drm/amdgpu/gfx8: Return error when testing all rings
Date: Wed, 17 Jun 2026 21:14:24 +0200
Message-ID: <20260617191428.1784083-14-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
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

The gfx_v8_0_cp_test_all_rings() function should return success
only when all ring tests were successful.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 9fe430e3ae65..6d69d49539ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4703,12 +4703,14 @@ static int gfx_v8_0_cp_test_all_rings(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = 0;
+
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
-		amdgpu_ring_test_helper(ring);
+		r |= amdgpu_ring_test_helper(ring);
 	}
 
-	return 0;
+	return r;
 }
 
 static int gfx_v8_0_cp_resume(struct amdgpu_device *adev)
-- 
2.54.0

