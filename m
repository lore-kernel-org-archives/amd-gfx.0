Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ACBCEBF96
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 08:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7913010E19A;
	Mon, 17 Nov 2025 08:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kzlIpFol";
	dkim-atps=neutral
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C10F10E037
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Nov 2025 17:33:32 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8823dfa84c5so40656416d6.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Nov 2025 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763314411; x=1763919211; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aTNaqpV1M9Ei1511bJGHTwkA7seKFEx3WsZoUY+KXHg=;
 b=kzlIpFolRG5WEcdRLrupDPsZUzE3Dui215ENDl8+Z0yddvYaFGLr6fjFfCcB7dFDUv
 GCkW8lnscQUIcxQrUc9c3q/d0FHeFxiw7bnF8Ekx5YVftVuFe3eYo/R2UgjfO1BV7tV8
 aTQh4aOA2nw0m0vEypBOEklvqiV7dN9P6NHmEc2cO3aRbi7OdAUdpMjFUEuBA9u+LF/S
 3bu0xxXtXThGp/aoW6vT5C8jfqE7FbJzldpPXLGY/mcogTLw6dNVK+N1P81tJebeoZNQ
 DC17xl6HRz1pSXYE/f1G3+W05jYEkXGPhShWOdcAX9lY/l/B9iQets7GWbVh9T2FcBaD
 JaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763314411; x=1763919211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTNaqpV1M9Ei1511bJGHTwkA7seKFEx3WsZoUY+KXHg=;
 b=BsJx39sMlY9IuB2dIE4nfr+dfDEIBiGGgxYOU5apqzGmCXiqMwKN28RlBDyqQbb7O7
 DbzfJSz/DAjVUzg+SzTYewCCpR15+BdiXvccTVILp2OyuwnatjvttoNaZHkXQyI2YScv
 MDJjaPs+40f89jkFfAl4EIHjfFp5g+jahcevN30pElSN6gscTCC5xtg1OD3ZVJX07pVR
 QU1tvxA9fgitU6+A1VOokL0inqnVBRVfbbDjE65IHUrYLM5KTeUCu94MlyAFRhP+Lgre
 4R/qW9pS94lkRBEkDjBanx8xJZbcFu16GkVSbheJDji8b8U1J6Hi7M9jbNdOuwPCFEWq
 VsSA==
X-Gm-Message-State: AOJu0Yy45gKg6WC+qH9Zjfi7T1bBoenotkPqt67p71Y1/ioR8aYykYs7
 J05uX8Cw0bzWQP4PTpYd44uG5CG2GoVjbiehFejQxXlhlTey5kzbf267sXeKrmEc5uU=
X-Gm-Gg: ASbGncuy2xNWHe5g3IXmucyoaeN1IL3K9EBcqbCzlYR/gdclQismiObOESfMbcWLoI3
 rVy4b/w3IJAMRXBBZ/5J9gVBRm5L6BUO/TVvkK1CyaqEX+lRDDnKMCRRiHpgd6N4aveMpp54wF0
 sXKXVxR1W7jbk0/bcgdsomdXVq8JlC0V/d/aD1cddjl7XBH5DRCHG1ngEnWgLJfXKntbbat7kRq
 QgIrtRHersqzSinLeCEkqGvW0+wb26t3sLRXFeZESvR/NJgIsV8SMfWmz59oeOUgP4tk1brh/rH
 p0qWlW33b6yGQggsVmwLXAJnBiQRNO88q3uMnBb/CZC27AkKHk1WdLr/iHBQDIPnsIM6T01OM3/
 CqHV+8FeFR/UKRygf5qbtMSvC2bgCa2b6TP1lfQHKqItlGYeh+8dGJFljU326O0qM6N0z3wlIbB
 6psW+81pcSKVhq9dFelN0gCVF4khnHY7yv5oPzhhx+CZxEJYpKIRPjtSFk1zn2NlL3+NROpVh93
 tIL0iQYL8k1Ww==
X-Google-Smtp-Source: AGHT+IHSnTQS24UuUH9rl7UnvsBNdDPlTMJarcl0yOTKBLb5q+jffZsOwrLpkrusLbtn4nUdL1luew==
X-Received: by 2002:a05:6214:1d2d:b0:882:7571:c012 with SMTP id
 6a1803df08f44-8829273c0c8mr143960626d6.55.1763314410878; 
 Sun, 16 Nov 2025 09:33:30 -0800 (PST)
Received: from namdlewifi.mynetworksettings.com
 (pool-108-18-100-114.washdc.fios.verizon.net. [108.18.100.114])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88286313d85sm73664596d6.23.2025.11.16.09.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 09:33:30 -0800 (PST)
From: Robert McClinton <rbmccav@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Robert McClinton <rbmccav@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Subject: [PATCH] drm/radeon: delete radeon_fence_process in is_signaled,
 no deadlock
Date: Sun, 16 Nov 2025 12:33:21 -0500
Message-ID: <20251116173321.4831-1-rbmccav@gmail.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Nov 2025 08:02:58 +0000
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

Delete the attempt to progress the queue when checking if fence is
signaled. This avoids deadlock.

dma-fence_ops::signaled can be called with the fence lock in unknown
state. For radeon, the fence lock is also the wait queue lock. This can
cause a self deadlock when signaled() tries to make forward progress on
the wait queue. But advancing the queue is unneeded because incorrectly
returning false from signaled() is perfectly acceptable.

Link: https://github.com/brave/brave-browser/issues/49182

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4641

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Robert McClinton <rbmccav@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_fence.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 5b5b54e876d4..167d6f122b8e 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -360,13 +360,6 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
 	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
 		return true;
 
-	if (down_read_trylock(&rdev->exclusive_lock)) {
-		radeon_fence_process(rdev, ring);
-		up_read(&rdev->exclusive_lock);
-
-		if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
-			return true;
-	}
 	return false;
 }
 
-- 
2.51.2

