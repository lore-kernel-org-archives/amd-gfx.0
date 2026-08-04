Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93059C56201
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 07:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D1E10ED5A;
	Wed,  5 Aug 2026 07:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GDVTix/n";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C3010EBF3
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 22:20:15 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84a3323d858so61548b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2026 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785882015; x=1786486815; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ie4qs54wUs5hkXY3NP+pQ3YALZkJdxyOkPoC9mBubTY=;
 b=GDVTix/nHij23YOg9EH78lCw5py/5hdj5JnNJfadjUlkWrGxFwaRLkICXDbElZlL1b
 imv32d4UMkYbAJk+sImYL2jhGxDXI2HA+HQ76UrfQreZaVF3EpeoRdZYjXUNfT90DoFH
 RWXQ2oHyi3KuFxEgUysxcVgoump/Sol4c+wYXFE7Svn5jSvzG/CnM1a8o/DCBqNuC784
 ejlL3dxYNxYlu0BH1o5GluElPhtov9BESGHK69tTlZgmxybhnFBiC5aixcZy9n4ieKju
 3ivPYjxzq01sIvh31PxBDnfOm7e5V2wEpXm7R+IYf6sTNG7qr2AIm8VZL+EH++3RkBEW
 l/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785882015; x=1786486815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ie4qs54wUs5hkXY3NP+pQ3YALZkJdxyOkPoC9mBubTY=;
 b=Uv0gYPW7Mhl2UNDBFpoHElkRefBioP2ADfhGC+4WgEeWF2WAKEt0JoM2tBGicBxWZE
 oK7C4POlVlMUw/H3fCPRyd/yL3RUg5n5eE5wSE26z5OiMQdcl54FgCZ12Ltjy2obYSIQ
 vNhtfZsC1b2D1zeikjVtZXxtwqVePaWibuuRjtwJYLTCah4ijOnmaZ9s7fwqEO+nYq7r
 +rqR+/QCtAVu6quPfq7C3bTPifuFgyIE7HC8+ciaiZoc51Z1vdQMgcWULpZ1iw9axJpC
 rjb5Rc7MVwaizlU43O4ZrSCcp422tYQhY/1JPv9kw2UOO2lKLZum365vGf2+OlVW0+lT
 w5Yw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBhzaVO7Tw+z41JpxoYJCVvEzQuj43ll1xBB4HU+rjGCdlR8VD5UwSQZNHby2aKt8BHT9slo2w@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzK0AViodM4YYnkZDHzInR8iNx6VWW0QqD/YOvHRj6s3T6M85Qx
 V7WemEM80uE7PUmj00nUR+z4QDY6AokOuI3pp6p13k0m4PkeKtxz1eymFomUgK/4sl0=
X-Gm-Gg: AR+sD13z3emisFSFU9dVDGHeedjm6j/sMuOFKyK/Hg98bp740/oRF2JxoqptmWU73O2
 kszLrSDThkmqd+2FY7PoVjtVRHk47IUuf+AOkQNYvkBb9BjYewvQO79IYX5o/KAPnfil1fDdQFp
 PSNzDoZut/4BHaXfl0CIChapt+/BrjmJxxLWaIzA5iKGgKXHxTK/wFoDlCWfcLK43kU+on/mKfA
 xUaIetbSeEOabokaoVgH7XJuZpAFaIofQZs/XkeZBMvf9Bj+vKEm4xJVC8Hs91sU3KgJ2iV5Gva
 Qwyj80l8bQPm/KtNbueWuBdjveTseuuTOXcTD+X7DxxhdbYGz2WWbxW9nU9S6plHkffcGooCjy0
 iKXhwmUhyG2cubeh3yXVNz5FtExw9jinf8o4OqWK+mmXVycAGO7WVTqiR1VfdZ9GYwmZ2mdBtuk
 Ne21onxZJrwtT7Uth2o7Xy0s+ujxBPAjsYTgHEDUnl5iFwuqYxBXEe+F6T/QlZ24JQL0/ckZmm8
 zo665gZSWOeT0BvLuDlzOnslfBx2AigJQ92
X-Received: by 2002:a05:6a20:7291:b0:3c3:8f7a:c0a2 with SMTP id
 adf61e73a8af0-3cb864e1097mr1428864637.4.1785882015270; 
 Tue, 04 Aug 2026 15:20:15 -0700 (PDT)
Received: from tk-amdgpu-struggle-Lightning-GAT5W..
 (softbank126051218020.bbtec.net. [126.51.218.20])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe70902224sm293725a12.25.2026.08.04.15.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 15:20:15 -0700 (PDT)
From: Kenji Takahashi <dken4546@gmail.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: Kenji Takahashi <dken4546@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix typo in comment
Date: Wed,  5 Aug 2026 07:18:59 +0900
Message-ID: <20260804221859.5120-1-dken4546@gmail.com>
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

