Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3594E73161
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 12:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F1910E4BB;
	Mon,  2 Feb 2026 12:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QfEx/2OC";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83F210E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 12:51:53 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso40480295e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 04:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770036712; x=1770641512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eCatf3kZ9R2kEtEw/Wv+LNz85pHjPaNXxk/Iveih3JI=;
 b=QfEx/2OCeOJ+5eMRi5+i9fMkUnWa4k+RqZAl5YAkZMZi8dEU7I+IxLaBeO6bhGzUa4
 ClxHw1XAt3R3MqhpOZ4pjiUGIQBo6A2W/5dUXCiyLJn4lzKTQJ31Vgk0fgRHyfnlyq0E
 n7hGFh3snWOaqpD/TIitAcH1mT1FGr0oDLP8VQGJJJpQLPE2uh67s0+v9Vc+i25iZ5Al
 CpiceNm9dSiVpiMia6Q2E6LjYgogg9Tl7dhp8fo0M+RVWKYqwCKd0IkYfAreDU4rvowL
 0YW1ovKv0clgyixczAvLA00oFUs0c3h+zkFWsLXTwXzsB/BDcNolYgBCiC3TaaihuycQ
 AZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036712; x=1770641512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eCatf3kZ9R2kEtEw/Wv+LNz85pHjPaNXxk/Iveih3JI=;
 b=YkFT7LSErKfTnMsjswPw+FV9/x4E8DfXPatvyLTkq+Upn7LHkoLaLlFgBrba2EWh97
 6Lfk0nzxaobkhEISdzNkRWaZK1KRJeEt1ei9Ud3l+Ku7BJg2lhYEcX4NwD+rucr45s0y
 Iu66HpS1+eU9UXP57HUC9yIldDuXaWWGnDCx0Zcrxs0oQ0Vd0PdLQNajP9b5aYe6uBcl
 GiQDnAnB/O7JgfJaRL1KOJj9GpHrKxVAFU8ZdiDUMDAiA7sGTMmYKVJ4OMFora/3hEot
 JVb8WcoEGqJ20r+xNeHBJmVI5FqNoCjk9j5H1ULDj97b+BD97oizZPINMk3BZ5BXw1pb
 2Jqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVZbriwAGg0Mg0m1qA6FdcxyrMxOoG1bnVo/IA2ptMWXHSMV82yf/axfe/ZxUXKvUoYu4k4hfV@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6NPe1y6ksRITXjfxqCxs5ZQ/BgcTEjk18fsCnOdIulAYQBJXN
 iSRp2niGk7J+n1EnWmPkCOFDwz9JW3DTYoeW2twt/lK9D/L5Sp0kMIwJ
X-Gm-Gg: AZuq6aJsVF/kcOFErHCbFc2KsK9doGD+0PEn0sXPZy0c0igt7JPn3ToKakb44VTCYj1
 VMnuL0tmb8uvRREGpvjEHVBlHkfPeCtfkaahaV4lNO2lQxOtCqtv/mWvknK59vFUW9vFtTiCVzC
 IAkcDJlpohO4jVRm8QvvyHhLX6DB3WH0NtJP5q2rf6lRmdCE+u73aH7GLeMpZ9W3O7ch88VZsPZ
 DF9xwplehnREZp0Ve6n1bYThrcbF+FiODpmSwmyR7CYcz4UIgkzMYZW55hkQoJk7b71etUQQXr2
 WaTXFe8ojEU19ID2vECGE7MPqLh6bIP/e6B5siRwMyNHuPJgRlz+o5sPJqpbIG0iAxEWbkN8TNq
 pxEWmInBV9PqRy8OG/QuEdQMZKYchQ4Unm04owYTtVDVI3ePJJJzoVzcQStvkig8nEzcosmEtZl
 9IVoRVkaSvYqmpRyYTdyWISfNrUKHwLbmrBw==
X-Received: by 2002:a05:600c:8b42:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-482db49728bmr129752225e9.32.1770036712335; 
 Mon, 02 Feb 2026 04:51:52 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1570:8200:7824:9bef:268:2d37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482da6a042csm126165535e9.0.2026.02.02.04.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:51:52 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/9] drm/amdgpu: fix amdgpu_userq_evict
Date: Mon,  2 Feb 2026 13:51:43 +0100
Message-ID: <20260202125149.2067-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202125149.2067-1-christian.koenig@amd.com>
References: <20260202125149.2067-1-christian.koenig@amd.com>
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

Canceling the delayed synchonized can deadlock!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8feeaeea1c36..af3922e9caea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1337,13 +1337,8 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 	/* Signal current eviction fence */
 	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
 
-	if (evf_mgr->fd_closing) {
-		cancel_delayed_work_sync(&uq_mgr->resume_work);
-		return;
-	}
-
-	/* Schedule a resume work */
-	schedule_delayed_work(&uq_mgr->resume_work, 0);
+	if (!evf_mgr->fd_closing)
+		schedule_delayed_work(&uq_mgr->resume_work, 0);
 }
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
-- 
2.43.0

