Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64D0C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 16:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CD42087E
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 16:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwUDirqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CD42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA396E9FA;
	Mon, 20 Jan 2020 16:34:09 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFF96E9FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 16:34:08 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id j42so57810wrj.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 08:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=alDCKDSm84tUszX0Hhp1Jn/30eDOcF14xhV7AXa9Uts=;
 b=EwUDirqfVQ4kyl0Ap6H4bXH0VOCiCNTX2Y2v7yuXQZfvhwjK2N0B0AhMVJ2AmpozgP
 uPzaCXhLsysXCEmoLDTKV5qtEsLUZfDoef0j7PaGH/JSHpyU7o5pii0Ca0m4U+2oIB+h
 7jRkVPmjLw+WQ+lz3rBC3SKg5OnQdWhQu4N9Mm2Fo9pSJLQfRIw9lljvmzfhpgKlJWcd
 DzF+CGrqIVSyYowR1HbOXWDiH8dzxLqjad6YqGEI3h9EM5BG6ixZUwlZGs24FJVT66kj
 ECG2shYz6Hz+MNwhcm1iBcPuWwqm0B2giUzIYy9rIoz0jPMMWFPGuPM3QmEtNYeclfxP
 HiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=alDCKDSm84tUszX0Hhp1Jn/30eDOcF14xhV7AXa9Uts=;
 b=qcMZzTpo/glSSaJ481w0V18dqO4lLxTt7fBZ2VrPUwz7KGhNRO5p1s8phF+/D7g6pS
 gLGLSenM0eWhf9bSH1mDj9FHXeqGP5zuKoP7vd0bUv3z5q9E7S40sRYFp3Y/h80ihmDR
 sf5CO716ps9F4YfGH4MA22G7ou4H/iOdE+rCs6TIsbJc+cA12he2CtU653/jFn318aC5
 v2SwqlBpZZnkIdmiGnhG34NLTXv6oOt1hnaQj6ixFyCafPv2Q8J+wvznqUC/KoTQfX1z
 1bY4tRPCw283cmdPooT3/i0j/m9WvKlUr6AWfIL/2kg9dBnsSOy2FLc9Nr+nZQ5CFge2
 O5IA==
X-Gm-Message-State: APjAAAXa6xJZk9GkJQhfMFkDlCP/ESOc9AyLGGi2QUwPiZl9DnOGN1UZ
 LnzwuKY3dqJQNtAvasXt3dGBV47QFnO08Q==
X-Google-Smtp-Source: APXvYqzKuSlYRK/ocIeWvWfNkP+8cp4dcQTBWEOfvhUOc2QyhIsBzZr1agSfnLbeGDgoGPtdMyeJbg==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr370103wrn.28.1579538046685;
 Mon, 20 Jan 2020 08:34:06 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F25000097A4C6C4F4A6FD0B.dip0.t-ipconnect.de.
 [2003:c5:8f25:0:97a4:c6c4:f4a6:fd0b])
 by smtp.gmail.com with ESMTPSA id f16sm48380158wrm.65.2020.01.20.08.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 08:34:06 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix doc by clarifying sched_list definition
Date: Mon, 20 Jan 2020 17:35:36 +0100
Message-Id: <20200120163536.28801-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, luben.tuikov@amd.com,
 nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

expand sched_list definition for better understanding.
Also fix a typo atleast -> at least

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
 include/drm/gpu_scheduler.h              | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index ec79e8e5ad3c..63bccd201b97 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -45,7 +45,7 @@
  * @guilty: atomic_t set to 1 when a job on this queue
  *          is found to be guilty causing a timeout
  *
- * Note: the sched_list should have atleast one element to schedule
+ * Note: the sched_list should have at least one element to schedule
  *       the entity
  *
  * Returns 0 on success or a negative error code on failure.
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 9e71be129c30..9ebba61db177 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -52,8 +52,9 @@ enum drm_sched_priority {
  * @list: used to append this struct to the list of entities in the
  *        runqueue.
  * @rq: runqueue on which this entity is currently scheduled.
- * @sched_list: a list of drm_gpu_schedulers on which jobs from this entity can
- *              be scheduled
+ * @sched_list: A list of schedulers (drm_gpu_schedulers).
+ *              Jobs from this entity, can be scheduled on any scheduler
+ *              on this list.
  * @num_sched_list: number of drm_gpu_schedulers in the sched_list.
  * @rq_lock: lock to modify the runqueue to which this entity belongs.
  * @job_queue: the list of jobs of this entity.
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
