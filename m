Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF16C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 14:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F15710E49C;
	Wed,  2 Nov 2022 14:58:20 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAEC410E49C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 14:58:14 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id sc25so45939659ejc.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Nov 2022 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ncjN3QzSRY89yzZa3hpInXfswDMonCsCK1qS9vuW1Ag=;
 b=bSyjANx0CTdDXuSnlihZjYJ6jitzII5v7ug6WKGaySw3IqDNhmmhuBEBY7bbbBkOMN
 yQIAD9i/AacFTMUrvG2FwfYOo9CWJ98fqyi7tVIgND1mZMHVfS3MMQCWi9qU55amJrfT
 vgwbbYg4TlTNOXg7VtDbpo9+8ThCR8AMsfv3112wIfdOhZKgjBYkaaC/NUIG+zva6tT4
 QFTNWUdINs35mSefeylkRu3O1UPKBtV1D3AMmJ0psdNJeyLQ2QInTWDzV7F6zgBOxEYk
 APaaXP0ZMftkikE1zebdmwZxkBdUsDUwjFxWstQBVzLAcN8keHGF+Wqbu2SQgtTmEj/l
 wZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ncjN3QzSRY89yzZa3hpInXfswDMonCsCK1qS9vuW1Ag=;
 b=b0jEO0Qc7C8RpkPczeAVlfsNIuj2zAokcXiUlUWMSU3TzFzubw+8hIO+fo5IdStKU4
 +kPmzUShr/RJrTLB72Furww5MMmU4zk8QxPSbOadoexx7nsVFrvRuCa5YbIEU00QLjOW
 fP/r+nE0q1jDeAzI+4xuaIsV1IM87gsEoheB05HfNRw+1/bgTTMLsutsijjieKnR/dWM
 SvTuCjf2On5Hf/DA7Wfovtk5wltGwxzpZLb3m+w8CqyhvIzwD4gq1qE3uKmhFwgUq/Lm
 y+7akNj8kDAxT6Ph6N5MZc2YYGiM48k31/3mY7pW/nxJWwyQidXHg58L2e+Nsn71kC35
 2ZJw==
X-Gm-Message-State: ACrzQf3wzW5hlDqFwI4hH3NXFSMff5RmXyb2sy9Gd8eQYcMCWKMUSFgM
 424NzwoFrBscVHc+ZiJTrPHZ2ayUrnw=
X-Google-Smtp-Source: AMsMyM669PnTW3qIjOf44mocAabBhTeDWWWO3KFr7npvbQDOXDIGcMFalnKNjPjJfHFHMhbmXB3t6w==
X-Received: by 2002:a17:907:6d0f:b0:7ad:c0d5:c7b5 with SMTP id
 sa15-20020a1709076d0f00b007adc0d5c7b5mr20473644ejc.262.1667401093444; 
 Wed, 02 Nov 2022 07:58:13 -0700 (PDT)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 w27-20020a50d79b000000b00461e4498666sm5909211edi.11.2022.11.02.07.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 07:58:12 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: workaround for TLB seq race
Date: Wed,  2 Nov 2022 15:58:11 +0100
Message-Id: <20221102145811.17968-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It can happen that we query the sequence value before the callback
had a chance to run.

Work around that by grabbing the fence lock and releasing it again.
Should be replaced by hw handling soon.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9ecb7f663e19..e51a46c9582b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -485,6 +485,21 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
  */
 static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
 {
+	unsigned long flags;
+	spinlock_t *lock;
+
+	/*
+	 * Work around to stop racing between the fence signaling and handling
+	 * the cb. The lock is static after initially setting it up, just make
+	 * sure that the dma_fence structure isn't freed up.
+	 */
+	rcu_read_lock();
+	lock = vm->last_tlb_flush->lock;
+	rcu_read_unlock();
+
+	spin_lock_irqsave(lock, flags);
+	spin_unlock_irqrestore(lock, flags);
+
 	return atomic64_read(&vm->tlb_seq);
 }
 
-- 
2.34.1

