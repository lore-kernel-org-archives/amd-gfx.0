Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02A4C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 13:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB7810EB43;
	Fri,  7 Mar 2025 13:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uhs2QVa2";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6ADC10EB43
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 13:48:18 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-43bc31227ecso10743055e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 05:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741355297; x=1741960097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NE/z3Dh/XvrJQlBMAjoDcVxAoGe91/7EpmqLweUpcfU=;
 b=Uhs2QVa2kUCLY34926TrdPEonLZ4cqQ8NrVkYAqJBuqXCKW77T9Er0OcNsHGW0OexA
 rE6DGxx7Vl0MxifqKEWWqY1SMYp9Iz+3KPkPOLhzhqJdlfEEBOulQsRrV+NGaoZ1s4di
 UTToSTYCdu1q8WS621v+J2y5eHGdYE/39w3aQkfzOLP8U3U5H9FkkdIeX3YMBZRAX6mK
 RiMwsPMzLy6Eq7m/w0GLw3y5bkjC5k/5X/RWxC5DKDFgycQeklqSTKhmOwhryg/inzw8
 4Eq7zyLyAInzd+c6pJpAXSE9vyhqIZhVSRaYjQcLJrqbpgK+7YVujFqJeMS554qe7bSJ
 kd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741355297; x=1741960097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NE/z3Dh/XvrJQlBMAjoDcVxAoGe91/7EpmqLweUpcfU=;
 b=EH+8+2r7f/iTDoIXf1fEUxppqEC2jEV6NdKgJxCU9+WvsO2UTzWu1HSpmVS899rfu3
 uOK9kCaDHwawXqPiYN2OMlqf2GMpwiSgB5rPquGz3lJ8jSW05BwM/SeI/53+kkZWvb6J
 S1kmbjfEcEYMaRpHKRiafs1aKXW38dk4E6giWROD3cgrKS2KXGZkgTgjLiJxEabMtww4
 oLrEOtuRudyHnZa1dDRrvT8a+K7cmcNn9ODreQjzd9Er8tB0TIIzBypn2Ss2s8zwcBP2
 bov3zN489Mz3juqFs5oIeg1CNlSQhNULxSviwBNPuRvbHDiSLMEiQAo5ISuQMf8f6TlN
 dGLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg1+6mlDMkAGl/1NFayfB8UYSswm5TG/Q/6gUrl3ZgxHtZhEWKt4KzA0Ph/DRnGjtuJZrHkWQo@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxtf8q10pWD2U74OT37lJ1GAttzrR/9wP50E5IPu7y5gpq3GJtb
 0sFM0eWiSFntmk9BowZRNQwsZllizzI+tj4Rzitv457B/nCW8JCDCvIAXANp
X-Gm-Gg: ASbGncsJZIL7AnLnGUrreOd24XuXgZVfxnauaTS4rkNBxcocClHXrUGNQj14CQOIf56
 eKwg7UsLFmkDwM8XcrtjPouiP5ergXJG1t1XcjoQV1sXnJrPGBU/VZVr9k/S5ZH19bRX/nVzIuY
 hh0FxxOgsRc1J7pwZFgwVdLqA0q0Xw5Pia5pcvmguKrG17l7fviclJUeX3InjrpBNjfDMVuTnz2
 DACnKdsksD5Y92/pXJujdvnJqiV6KkEf0Hh7khAa66fQHVi3pTShAdGiy6kCbDWyy1F4QoxoIsv
 FRTPRDJUCZ/yVyops273adfjaGhMwiRieUZtYbxdpZRkCU/7pbwhBJA9uw==
X-Google-Smtp-Source: AGHT+IEZfvXMcVcgfdNwTBA1aZhpkSrX02A5XGfu9lQ4HuxQuyQkkQ4dcVnqSyXLy8n5mPyZl3kRcw==
X-Received: by 2002:a05:6000:1867:b0:391:253b:405d with SMTP id
 ffacd0b85a97d-39132d98a1emr2333608f8f.41.1741355297220; 
 Fri, 07 Mar 2025 05:48:17 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:14d3:5e00:ab55:e6a0:3a3d:9571])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd91338cesm70613345e9.7.2025.03.07.05.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 05:48:16 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Subject: [PATCH 1/8] drm/amdgpu: grab an additional reference on the gang
 fence v2
Date: Fri,  7 Mar 2025 14:48:09 +0100
Message-Id: <20250307134816.1422-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

We keep the gang submission fence around in adev, make sure that it
stays alive.

v2: fix memory leak on retry

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 198d29faa754..337543ec615c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6889,18 +6889,26 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 {
 	struct dma_fence *old = NULL;
 
+	dma_fence_get(gang);
 	do {
 		dma_fence_put(old);
 		old = amdgpu_device_get_gang(adev);
 		if (old == gang)
 			break;
 
-		if (!dma_fence_is_signaled(old))
+		if (!dma_fence_is_signaled(old)) {
+			dma_fence_put(gang);
 			return old;
+		}
 
 	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
 			 old, gang) != old);
 
+	/*
+	 * Drop it once for the exchanged reference in adev and once for the
+	 * thread local reference acquired in amdgpu_device_get_gang().
+	 */
+	dma_fence_put(old);
 	dma_fence_put(old);
 	return NULL;
 }
-- 
2.34.1

