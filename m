Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA12606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=acAbAXQw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA49C1124DE;
	Thu, 22 Oct 2026 10:55:08 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D5510E400
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 10:55:01 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1fe9efc0eso19641445e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 03:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792666500; x=1793271300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PLOjklaQ6W0/4q4CjlWXj/KTaFUZKxZGdCsl7wEDlgM=;
 b=acAbAXQw9S2D4motTdrEdAeK/EqoqLIOpWyMmpFXufDGPRkzGsPEArXVbDnBg5wFAU
 SQh2CZbHGZDgCsVNetDcTI8gxwUbCUN9wXL3dxBoIb1O7rb3B2Uzan8FlXf3LuioHbui
 GvkarTIrj0+qsQq7GQEyM0ofPHiGFZf3M0OeQvUFN79CCsbI0P9a/VO4BEh1RUhrRGHz
 nDyyjZv9HMmNzQkAW31q9iMH0phU8e7Pt0+OnxGxbkoGTrPg5fH6iT+hvrssZkY4o0uQ
 2oLECEHk9Zm+dr3wQATzf3mPfoQAGmgsPVmeJk4y5lwXmSJ44bH+zngTiBFOzNJmmy71
 t9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792666500; x=1793271300;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PLOjklaQ6W0/4q4CjlWXj/KTaFUZKxZGdCsl7wEDlgM=;
 b=wFS+wbZbjUuBJWLCvBPNv8MeTB53uZ+adPiYK04M7By7vPe73YMTz16Lu8Oli6iNpE
 9+WEcpmftZudoFYt4pp+CmZrJk4fufOgb+Tuw3rozoJVocaWNknszsmgQ89KFkIf/EIa
 bqGNPa3pbDpTyhSbe3Bin2LATKeRSOCp5GRONCSmp5c4tDaw8qKwDaMEs5oRuFPH1Hmz
 URA4s3K7KYl4cXJy4QfLBGEF5HJOesnYw4BXlkCsNpXQmyMvwNQrndsvJuznac10qR2y
 pM4tzCTh7yfkVPp95dJlaLpZKR0q0TMTt8g4YJY9dqYD/bR6SVy+op4PT01WCIOZDAfZ
 vREw==
X-Gm-Message-State: AFq9FYK60umWG83wNeyPJBh+tzlNYZ4QVOUQEE06wkilG+BCOYVSihXH
 RTxS9gLV0KrLYD9WXf5iez4fl+d95FlAEwYiqcMu5rKfMiMBC3Kx69qk
X-Gm-Gg: AYBFou0QvumS9qUQwRuPPLYAsRIlBLfHF13QxTQ6dWuvnokJ2nNMomXcjnYG6XaXM+h
 PN5JZbM7JnLe3dVAsnN51uVC+bUBwvJMhzl70Y65Kj8ECwG4nxIQc9Ij/EHyiiY6Ui4K9cEvo+I
 ZAe6GXa5OKS0iuPUecue/M4RMaupWXxBsIo43IjBNRpyYgc03gdIl9GpWplOiFVQRXDVWClDNCX
 wmMLdYMqqsN2qKw9s0R2inu3QRVTQc+I3tArXJXS8iSA2TZcGoVCkx9SWW6jMv9UkD/ia/5bWPY
 AuXwFxwkhwSWvBKsd4EXIUo3CMNKHVXDYNuNlrwnYeZ49XFQNbMHwkluesdZhl6FXyfO637lxIu
 s8IGf5px6oCr2Fj8i4YO/Kv1QR5d3SR+L/0sftjLN17rFPq43JNRi8RG1cUMiZoBPZVoKhnmwIP
 mn6MW+Zz3R0iU+CtNM6VZGC6jp6XjCBVRnrLtpqgzwfl/4g9c3sW7rqC8cbheMga3VQSznMIGa0
 /cIa80ruugEdl2gE8kznyD4ILNeDGokMV2FdkYQnkCRDwOhXEFmARPIEvFNmWkySdhFwqa97YKC
 EhSONlCzVCspNK6qdLbXIFBnZaHfXtyI5cGgrDfqqAdFPtkvDpxuIangx/+5qsZ6Jwi54Yx07WL
 TNAMrN1q8a9kgOjKH+TdjTkgb9jWdG3gZNjjTp0rzDhcNzawBrYWgz0MMZyoiFMYe1rcjMUjEIi
 c3puDGQ2AHmEPs5MokkQCQ/CqU2zjuHPVZI3wdtx2UuUAJNecyOuVDIUfXtGhI35nVKp1mj8snH
 OnTVGiDFzFiBw9y3lxm6huxkmKtQ1k9iKA=
X-Received: by 2002:a05:600c:e556:10b0:4a1:a6e0:4ce4 with SMTP id
 5b1f17b1804b1-4a1fdd24476mr64396095e9.33.1792666500162; 
 Thu, 22 Oct 2026 03:55:00 -0700 (PDT)
Received: from localhost.localdomain (188.42.205.77.rev.sfr.net.
 [77.205.42.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a207fd494dsm17565285e9.4.2026.10.22.03.54.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 03:54:59 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 alexander.deucher@amd.com, tvrtko.ursulin@igalia.com, phasta@kernel.org,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH] drm/scheduler: signal fences of jobs pushed to a stopped
 entity
Date: Thu, 22 Oct 2026 12:54:54 +0200
Message-ID: <20261022105454.60267-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_sched_entity_push_job() queues the job on entity->job_queue first,
then drm_sched_rq_add_entity() notices entity->stopped under
entity->lock, prints "Trying to push to a killed entity" and returns
NULL. The scheduler is never woken, the job strands on the spsc queue
forever, and its fences never signal, hanging any task that waits on
them.

One way to hit this is process kill racing a late submission from the
same address space: an amdkfd SVM migration job submitted from the
fault path of a dying process (SIGBUS on device unplug -> coredump ->
get_dump_page -> svm_migrate_to_ram) lands on the process's already
killed entity and is never completed, which then wedges the entire
PCIe hot-unplug removal thread.

Check entity->stopped under entity->lock before queueing; since
drm_sched_entity_kill() only sets ->stopped while holding that same
lock, this cannot race. A job pushed to a stopped entity is never
queued; instead it is run through the normal kill-jobs work so its
finished fence completes with -ESRCH, exactly like the jobs drained by
drm_sched_entity_kill() itself. The sched->score increment is balanced
explicitly since drm_sched_job_done() only decrements it for jobs that
actually run.

An earlier attempt [1] checked ->stopped without holding entity->lock
and was rejected as racy; this performs the check under the lock where
->stopped is written.

Note: Tvrtko Ursulin's entity run-queue consolidation series [2]
moves this code around, making drm_sched_entity_push_job() lockless
and taking entity->lock inside drm_sched_rq_add_entity() instead.
The orphan survives that series unchanged -- the job is queued before
the NULL return and nothing completes it -- so this fix stays needed
whichever lands first; the loser's side just needs a context rebase.

[1] https://lore.kernel.org/dri-devel/20250811072050.3838241-1-Tong.Liu01@amd.com/
[2] https://lists.freedesktop.org/archives/amd-gfx/2026-April/142980.html

Fixes: 62347a33001c ("drm/scheduler: Add stopped flag to drm_sched_entity")
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: "Christian König" <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 21 ++
 1 file changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 673ca9cbf..22ecc9bfd 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -651,6 +651,27 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 	spin_lock(&entity->lock);
 
+	/*
+	 * A stopped entity is never put back on a run queue, so a job
+	 * queued on it would be stranded forever and its fences would
+	 * never signal, hanging any task waiting on them. Don't queue
+	 * the job at all; run the normal kill-jobs work on it so its
+	 * finished fence completes with -ESRCH.
+	 */
+	if (unlikely(entity->stopped)) {
+		spin_unlock(&entity->lock);
+		/*
+		 * Balance the atomic_inc(&sched->score) above; the
+		 * decrement in drm_sched_job_done() only happens when
+		 * the job actually runs on a scheduler.
+		 */
+		atomic_dec(entity->rq->sched->score);
+		DRM_ERROR("Trying to push to a killed entity\n");
+		INIT_WORK(&sched_job->work, drm_sched_entity_kill_jobs_work);
+		schedule_work(&sched_job->work);
+		return;
+	}
+
 	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
 
 	/* first job wakes up scheduler */
-- 
2.39.0
