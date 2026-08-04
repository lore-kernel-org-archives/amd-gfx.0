Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35C4C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 07:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3FF10ED3D;
	Wed,  5 Aug 2026 07:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QbqQLTXM";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62CA10EA46
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 13:01:05 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cf420670bbso4136535ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2026 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785848465; x=1786453265; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ie4qs54wUs5hkXY3NP+pQ3YALZkJdxyOkPoC9mBubTY=;
 b=QbqQLTXMUMzuZWvqqaLVqvlamJbnKYU/U512d1cCRsN0xBT8Qgaz8NhhnUB9XpL7Sh
 Mh2UdClOpwqtk4+M73hEmjIaOAMaN6xFbDHHT8W7UPYsMSvTJcRh2vxWAbbO7L16vXVR
 k2854OBNOawPrjM1jSELBFvKV066rk/CBgqWGDh4EHQjBP27BYXuT6+FVRQbgt9g34Pb
 dlBghRft6ve8/ohDGMUgEVp5rGRSv7KgvG3+J0F86v1Mt/YFI4A9zlQt264K8K22Eim3
 0QFIf6wPHnR7MpLL0/QctifZmnCHTY09bkPE1L0J83e14rOcvJAEsifkbO+pIyjIw2l5
 dxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848465; x=1786453265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ie4qs54wUs5hkXY3NP+pQ3YALZkJdxyOkPoC9mBubTY=;
 b=XWiD9pWXyjEMrg19UMZN14bH3UcZguwzCd8LNSMiQis/d9uhBk2BVUXFqje/3Fshsi
 U7Lxra1g+RfHkHLt4coibr5GxfZNd/j8Ntzyq3P0tUAlVZY7VnpiW1lgnbj8Q6dCFinT
 EhVkEcmuPyM7HXtVXO0ml7XlI065q3SItjKgn365Q+XrU2q5y3g1hA1esbZgE5XN8reU
 eytrCxXAvssCZJMNk5xT+UWk21utKI0rnlI3rHu0UNS7sUeC69GS6kvf6SbQ6KHZL3EQ
 kUK1OdoBAFrgcn1rTCx0au5yKQ9zYGQ24Yn2cumXCWcydt3XLKnHbWph3e9xb0Qc7vSG
 fLDA==
X-Gm-Message-State: AOJu0Yx7A1o1OKkxawIir6pl3DrQKUDwdgtTGSsdCr9xmRhCoer+Bqs3
 9Ey/Z8kRo5nEFVzAuu2JZiOLl1VRcoNUAi8Fmu1Wuu5Z9KI8bufv3scf
X-Gm-Gg: AR+sD10zlT8hubAI5HIU6PsEce/5ZZhPATZ+5dEiBsCdZQZH+aA0LpVXFrUXkXiB/ag
 rwpjRqnTJD9l2x3uKAwYVmo0coA+TqwmH3ixcqqeWZDu0yCtNUabhM0XPMn062GAdKgxkA6jlTa
 TE5FG4MgtGvn498xUTAmdOU+/SafLkfIHKM0KGXoZRpmNx/v5jwk6DnQlUGDbdmVDqzbhsHjYeS
 +ufczby8Hv77V1ZLF7nlKz60C1MscVx9+/bBwVVhgomPQSrRBZSOX6dn7LGMwjYlkui6m+EDVlE
 8tQNxLvEQmY+PUiDyEpBC9FKe+mwfcLKJHSK/vLI2NbFyJLGsNrL5QifmFAaHKgCClQGPqD7XiA
 GzFn3dOd9mq+xuK80HzDPiy1ha73v93Tf2T1USxxm94ndsRrR+U9enuMODAR1mI9OxF2dFOcL/d
 QoNHQCqbcb7gzR4cfRDqmGzgiouok8Ge4WOdpFxFf1pN850UhMP0IRhQOZ0eoCwpMKa22LIV/eA
 Tr1+A2TLdNmonRkFxOgQlX3JfGm+pZKBQRHmb/YWIu0TFo=
X-Received: by 2002:a17:902:d592:b0:2ca:ecf6:9105 with SMTP id
 d9443c01a7336-2d08b210c0dmr55671255ad.1.1785848464831; 
 Tue, 04 Aug 2026 06:01:04 -0700 (PDT)
Received: from tk-amdgpu-struggle-Lightning-GAT5W..
 (softbank126051218020.bbtec.net. [126.51.218.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9f8fb4bsm7546475ad.5.2026.08.04.06.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 06:01:04 -0700 (PDT)
From: Kenji Takahashi <dken4546@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	Kenji Takahashi <dken4546@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix typo in comment
Date: Tue,  4 Aug 2026 21:52:34 +0900
Message-ID: <20260804125234.14043-1-dken4546@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:25:06 +0000
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

Fix a spelling mistake in a comment.

Signed-off-by: Kenji Takahashi <dken4546@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index b249e7d1af48..d634b91bf81d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -102,7 +102,7 @@ static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u6
 	mutex_lock(&p->svms.lock);
 
 	/*
-	 * range may split to multiple svm pranges aligned to granularity boundaery.
+	 * range may split to multiple svm pranges aligned to granularity boundary.
 	 */
 	while (size) {
 		uint32_t gpuid, gpuidx;
-- 
2.43.0

