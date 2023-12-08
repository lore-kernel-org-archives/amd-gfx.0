Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C59C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 12:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEC210E2BD;
	Fri,  8 Dec 2023 12:55:26 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC9310EA9E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 12:55:24 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33349b3f99aso2069028f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 04:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702040123; x=1702644923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TPla4HynVjKmG9t80NxrRJKqTLzxjY+4j/g1Rwm5YJU=;
 b=iSBRAojOHM79+GX7LO3n8ODeJzg9d2M5K6wYNq7lT5DxSxtxLdMsRHSx3v2oGQZSeF
 s0QiN9qqLZZOdZnMo3q70vaCIDGULxBR4Wtk9xL0moLvgSPQFNr+yWCXVaAhqUuNxEtc
 uzxhJyoH+P1kaRcU+PnDlMRU1jq803HozDEjckd50AX/+sY/vZAI0RHxRw7oRwIjuYXP
 9a1B1z4JnGSFyGHs8Nlms37Zw3HjZ0vYno8A43BZeZBGdqCB09rD1XhaHnYhAo5PJnah
 dXTO+YiZosb9NgLyX/2ye/MPqeoLSwEZf21YrCW6p5JlcvVRN2/2N0D4TTr88tTVqKYe
 3Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702040123; x=1702644923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPla4HynVjKmG9t80NxrRJKqTLzxjY+4j/g1Rwm5YJU=;
 b=w9OKj4phvpu2OaSrsd+NfYlbOPseU4HGPYrAK7TttgDg5wBhI7Y1AzT/oLCElC5gkC
 oI0c9VOHGCIzoeOUCS9zLQa6R3z5OucbDpTp7PxtYqMpei7WdJLeeO0jOfcUMNa3ePSz
 rm9CNMxtOApw0SyKP9E2P7hGaNE8R4dGMx5SNvQ95a0z0W/vQVR3vl+8MoY9Uc2Vh0Ua
 FD3fKA4W5PEDBeR/cuEk0pHgI+LaRBQz3PJ2oT4aIkE/VejJfSeGKZG3J1M/y1mJfh7K
 uS9jrdfCmieqnkkUn0C2MkYUKwrCq4XD5F/AZ9ahoMFAxuqgu1pB99/5677HylJ2HXMD
 XoxQ==
X-Gm-Message-State: AOJu0Yx/YRmu/XcwQQ50iv8y0B4yX6ppaIpFqjKc58DFURiJ8akX5Qo2
 rqEnUpqhUBMu0BLeL7W/FLkmNnkdhYM=
X-Google-Smtp-Source: AGHT+IF+RgmjNmCTedRu7diiW9Z3II3ee3XPxV8s0+BP+LTSM01uRoLkllbm+9oR/NKRGe8il2Dzjw==
X-Received: by 2002:a7b:cc8c:0:b0:40c:325a:547a with SMTP id
 p12-20020a7bcc8c000000b0040c325a547amr647082wma.127.1702040122700; 
 Fri, 08 Dec 2023 04:55:22 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:155c:b600:9612:d720:3125:86b])
 by smtp.gmail.com with ESMTPSA id
 ry9-20020a1709068d8900b009adc77fe164sm983174ejc.66.2023.12.08.04.55.21
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 04:55:22 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: warn when there are still mappings when a BO
 is destroyed v2
Date: Fri,  8 Dec 2023 13:55:20 +0100
Message-Id: <20231208125520.2278-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208125520.2278-1-christian.koenig@amd.com>
References: <20231208125520.2278-1-christian.koenig@amd.com>
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

This can only happen when there is a reference counting bug.

v2: fix typo

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cef920a93924..75d86abe15eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1343,6 +1343,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 
 	abo = ttm_to_amdgpu_bo(bo);
 
+	WARN_ON(abo->vm_bo);
+
 	if (abo->kfd_bo)
 		amdgpu_amdkfd_release_notify(abo);
 
-- 
2.34.1

