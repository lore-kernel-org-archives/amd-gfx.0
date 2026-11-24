Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFE606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zLw96XxA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F0810F749;
	Tue, 24 Nov 2026 15:54:46 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF6E10F582
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 13:04:38 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so34746105e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 05:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795525477; x=1796130277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=11BdxToRl7Imu6xTXQXzIEQA7BhXFI0DECquzAmC5WQ=;
 b=zLw96XxAvcd+Imo44vcqq8F7kSWhkuJvnmih3EAleDYu7ZdeIrEya9QxIh3oIxU8/C
 W+vSZIPjhVTBW47N7btox/92DW3y5uovEtw1cBYkqIgg844bPWRElFANWyDOtxlmvUJq
 y5I3c4ZKwEQ2+vadk+N9u3x4KLwayyQSsJJtBFI2cdnLY2uY2qlTBGAhA5mAFZovUDvp
 MDUpNz1B1WjLu8PnJvZyqy7KYhnGAt6ZQoLtUj6v737BuQMMNWSSixY1Zy1cLIIM9vs1
 8zY1pC/Ok0ia1Q/8CMWdN0orfZGBfD3DgDNbxSlOGkEAPmBNXYCwGreDU9YfWzhQK1hy
 AbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795525477; x=1796130277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=11BdxToRl7Imu6xTXQXzIEQA7BhXFI0DECquzAmC5WQ=;
 b=cuyzGrFL2tN0HlH0is5BYfDnXqe0NdW4pmIXq2brtfbJIu3cxpw8QxX7b0JJxxlpCr
 FJ0ydP9NIFeIzYylzai+j3Qm3VOJaubGQH28TWodc3iRA9nejz8fKZg3EbuqAhf5nMpw
 iUSWX/lv8qwNz5vDS5lQN15OeTLvQjSp3WGqMWA3/wK0uYVbIfS07ZtkbkzU7vvTMz5v
 aGnNBhQmMKcBSlb6VuKVoSHGI7gbguy+Sc8lvBk+9UCNfvfbIznSfSA/cK668SwPhvTg
 HFBxzDb+e85nah471/i3Goz8abmu0xjgHBQml+Aq0Q/5MfM5jFnAENeiYSW7KZ9QcIFi
 M2rg==
X-Gm-Message-State: APuU4Z9+sWrJTt4/F56mi6nxtp2aBdNjWUSY+Z4qw1h1CpKlotZQ9gg/
 SVFt0Y1ZW4eWnQ61B7DX0VVu+FyjFDnoFHFKVh2S5n1wVgZZPnc0SuTrPz81thkjAGA=
X-Gm-Gg: AZFdTZfOYMnXCNBKlfrxZjHytH1aqSQQH44OOVnNY0F9GcvlLY3yFByUzg3SXoAwjbK
 Vo29TpElE+44bT46JZafiKCb48hUV9gb/A53dATbAAg6AqGbudgox8Lrx4O3XOrwPKd5x2YlSZt
 LtoGtyaq/MB6aSY1ysxpyj936QeMC+R59GQKjWvNic0Ggfcw8Te2lTtuDiv0dbaUcI5ELBo4tny
 gzqnzp6tXvIcTbIww4fLfVOD3+fsYmgo7MsEjdUiWJovDr3Z9vy0uMFpIGqPcGGiakpUh00AtZF
 3XmtZdkhk9WTIZknCljlXBvwjMJg2m7IPPo8SCzswdSplzwzEfnOoDRRuNCq6mLUHfxGplEWdMh
 BLJLMJqAhwvcbgTco0G3Xt2KgEpKN/Ylqg7Uakmb6bAoK0K7l/IMwOzyECXfoYdH/oQ0GvHKw1Q
 O4mpPIRwX/RkseosJD5yA74nS4/AGZNh1T3n6F+AfeHAweZ7V6blzxR+QO9PQwf2a603U/5EiLl
 bFpor3ZQE8jAeFBGw834zice300tX059bmi27ffkFIPH+Aj8ganiIXM94zLWfainCaoFaw3vmYI
 2NXrgJFJ9oSxlqh879h0DToDvbElIRC7/JAUx8iUb6RRWI9clpm61fCSB+Oz1BhJ/+t7c5evDDg
 I81/h2S1NuxIwPZViKJEwhrW3uQB5py2gQj1CZHAfLye9lQ==
X-Received: by 2002:a05:600c:a086:b0:4af:c210:5b3f with SMTP id
 5b1f17b1804b1-4bb88817ef1mr311670105e9.24.1795525477104; 
 Tue, 24 Nov 2026 05:04:37 -0800 (PST)
Received: from localhost (2001-1ae9-5b-ad10-b3af-f37f-773f-f37e.ip6.tmcz.cz.
 [2001:1ae9:5b:ad10:b3af:f37f:773f:f37e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b3a7sm489437785e9.3.2026.11.24.05.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:04:36 -0800 (PST)
From: Arisa Snowbell <arisa.snowbell@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>,
 Sunil Khatri <Sunil.Khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Arisa Snowbell <arisa.snowbell@gmail.com>
Subject: [PATCH v2] drm/amdgpu/userq: queue the restore worker on a freezable
 workqueue
Date: Tue, 24 Nov 2026 14:02:58 +0100
Message-ID: <20261124130258.1270242-1-arisa.snowbell@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795482456.git.arisa.snowbell@gmail.com>
References: <cover.1795482456.git.arisa.snowbell@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Before system sleep, amdgpu_device_prepare() moves all BOs out of VRAM.
When it evicts a BO of a process with user queues, the eviction fence of
that process signals, and amdgpu_eviction_fence_suspend_worker() queues
the restore worker on system_wq. That workqueue is not frozen, so the
restore worker runs while the eviction is still going on and moves the
BOs back into VRAM, waiting for the page table updates while it holds
their reservations.

On an RX 9070 XT (gfx12) this hung S3 suspend for good after a few hours
of uptime. A restore worker waited forever on a page table update fence
while holding the reservations, and systemd-sleep waited in
ttm_bo_evict_first() for one of them.

Queue the restore worker on system_freezable_wq, like the amdkfd restore
workers. Its work is frozen before dpm_prepare(), so a restore queued
during the eviction stays pending until amdgpu_userq_suspend() cancels
it.

Fixes: 44cfdf368fb7 ("drm/amdgpu: resume gfx userqueues")
Signed-off-by: Arisa Snowbell <arisa.snowbell@gmail.com>
---
v2: drop the restore block flag and the resume changes, only move the
    restore worker to system_freezable_wq (Christian). v1 claimed that
    for hibernation dpm_prepare() runs before freeze_kernel_threads(),
    which is wrong.

 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index f8652fd0525d..18b11d7f457e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -91,7 +91,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	dma_fence_put(ev_fence);
 
 	if (!evf_mgr->shutdown)
-		schedule_delayed_work(&uq_mgr->resume_work, 0);
+		queue_delayed_work(system_freezable_wq, &uq_mgr->resume_work, 0);
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9fc8e9e97595..f52c2096c5b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -456,7 +456,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 		 * Looks like there was no pending resume work,
 		 * add one now to create a valid eviction fence
 		 */
-		schedule_delayed_work(&uq_mgr->resume_work, 0);
+		queue_delayed_work(system_freezable_wq, &uq_mgr->resume_work, 0);
 		goto retry;
 	}
 	dma_fence_put(ev_fence);
-- 
2.56.1

