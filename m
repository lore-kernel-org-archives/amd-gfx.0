Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7B9E776C2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Dec 2025 15:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE8510FF4C;
	Wed, 24 Dec 2025 15:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="LIkoEetf";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0808C10F91A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Dec 2025 14:47:20 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so3151554f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Dec 2025 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766587638; x=1767192438; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EusSFmSFHvXdK2TABmwbfVXk8QB5nq86ggI4VdbsACk=;
 b=LIkoEetf3TxOI1IAnlQDE05cQAQjZ2qh1QE2nExcYTWLuct8BECzqdFnzDs52poU83
 fCifuRHFBuSupG+f0XdQec5oMBN3Fk8EIHL9YA4LlM93p890e/I1Xx/taGhihmupYlUz
 lKSM7Eub73NpHZEAB7AQuvQiZfOzgypP2M/x7g6B4zJT66ZY3FpZf4hWjg0tWce1FOEg
 lbJeiaoN5iSCOe0PtVlKDNn2GWqxtSsJsj4CeNHcNRJFEM1IWGveHqOUYHtNQ997m+m2
 En8T5DRH7x+VkdiSPYKxNG7X/PJpgd3EiJOgQwTkn+1Hf4jHEGaRiPcL2EQwetsrgkfJ
 ipSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766587638; x=1767192438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EusSFmSFHvXdK2TABmwbfVXk8QB5nq86ggI4VdbsACk=;
 b=kLA4RrK2W8LbvPzBbQqdNg/bhVUMOx7gdHw+JGWVpn2iXYq39JP+fPnFvKrPnWih5p
 XYYQuJl/pEJvHLre42IhLffoG3EHjTPQ/IBBCirgwmQB5f0G30bhS+ysEAZD1lCHTsI2
 wwcVl4o2589ZRRx85jRuMc+4uQQuD5jYlBDSmSJp9CEWksW4PN3gT3oOJMC+NfpBg7Qn
 ltvVDu4kOmKZTxjgInWy/GOQM44d3e9D/IVOYfpiYjeUCyO2X+J2Ry8s/u4RbsC9cuuY
 I8IkXRyhmauTmpj6CTqqG5DhWEA96tttLEvgWG62ghwhoJ/mB+1EFNr6q1SLI1at9BiI
 zJKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnxBsvFPQnwJ6uoxtdw8xVQA7xipM4oBkVc9o29LKgFpKv2QQTahef5PWwEsOFJoQylihFQGAA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaBGri6K/ToDUWQOd+BB4gAqCBeMFrdQBxb91N2VgKRG5j3FX8
 vQdFLbBZb3N/S54VU/MYYWHPNi390uYD022bfvcjNTiFq3+XsvI8iWDS5iu/1Nh+Lxg=
X-Gm-Gg: AY/fxX7+s4G/jcTjZ4VN08o2wwFeg12e64PY3BDOh+9MyVYeDHdRJYgnDRG97T9czeX
 bQcr/SISAJWuyDDJva+kr+2MjVLMhBBP9G8PwIJpX0q+vUH2wH+t4e9UALFEEFicjrwLbl0Gowc
 ZW0QnfQ6PzpQawjasZESFMBppjz8ple33gPda9LyG8XHjBH96ipV0IdKuQ2muW1p3c6nWsDpA8C
 BykSvCq4/r8q+Txm02fOLNau4fbHERMqyncMPBuwQXzKxhMY5Tsrh9RfdJ/H5TiBls/nANrmM7/
 kkGEZ7M+PheU6PZvPu08Dvch7dYNN0OJG4IF72EuSW1EbYtL3+aQnHxtYjt/IKJHEF20cWyG5aM
 QWUN1jZq+3zk8vHvgXJQE+oKDt4Ziz/IsQmjk5dF2YkzRKm61v7tidH7XmM+zdn7Ssqq+mPo420
 TsiGyk9B6LzMMWmryGKqISwHe29Wc5fVUo68k=
X-Google-Smtp-Source: AGHT+IGJt/mwYM0l80VTHl5jzogHkpHFpfjU/vUbSjbHEQ65UEFCA++BEt+L9cJZpI26+VHKaAJNzg==
X-Received: by 2002:a05:6000:220c:b0:42f:b65c:1e4f with SMTP id
 ffacd0b85a97d-4324e4c97ccmr18106758f8f.17.1766587638414; 
 Wed, 24 Dec 2025 06:47:18 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b82a58sm1041109f8f.6.2025.12.24.06.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 06:47:18 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philip Yang <yangp@amd.com>
Subject: [PATCH v3 4/4] drm/radeon: add WQ_PERCPU to alloc_workqueue users
Date: Wed, 24 Dec 2025 15:47:08 +0100
Message-ID: <20251224144708.61167-5-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224144708.61167-1-marco.crivellari@suse.com>
References: <20251224144708.61167-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Dec 2025 15:51:46 +0000
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

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/radeon/radeon_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 35fb99bcd9a7..99a3e4c480c1 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -685,7 +685,8 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	if (radeon_crtc == NULL)
 		return;
 
-	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc",
+						  WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!radeon_crtc->flip_queue) {
 		kfree(radeon_crtc);
 		return;
-- 
2.52.0

