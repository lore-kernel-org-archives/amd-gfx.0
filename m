Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF102606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aEaX8V8t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 580DE10E408;
	Thu, 22 Oct 2026 10:54:49 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D78710E408
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 10:54:43 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so5210935e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792666481; x=1793271281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PrARJiy7el+rjKnRPy0l4gYQDrWufE3f+CulbX9MY7g=;
 b=aEaX8V8tAQCG9HZais4yrijTe+VuZRaqDS0Nb0DRDg8s8dEaqknUuVGT711SunyTxJ
 ph9oouOYpuSfjHb0ibwEsumhy0sDliiildno17a2sBV1D4XPpsbjh59sQ4UTghMZLJ+j
 +ItFeGyaKodcq78OOl7RuC/ccRf7Mn/ObV5cOjTuUrDODPTxdCVhuBkl+rB1vHvJVtK5
 O6B1H0J/DQ8yA51EfnpIKAOHHV39ItCj/g79/j2WpCkFFTWmO7LtF+nYZP0pW4wlY7BD
 mCL4KkurLOpMgOWtNJwMjMWVbJ5P7drGG6CuzsQpWfSDwQWrQ2TZZwshdxOQJQJWtqrn
 zUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792666481; x=1793271281;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PrARJiy7el+rjKnRPy0l4gYQDrWufE3f+CulbX9MY7g=;
 b=T8Y3l5z00W1UsMLnsBdP83U/3cvcHC83hhg1WQ1ljABNxCUTcmWqRz3PohjWvZtk7X
 KGNB0wrfpbCsoH/+UjKfKOxhFX/CvQKgb17m9PSbt8gFRjLn5tATEoldD8hVjiXNPxOa
 /7jmc/v54AynCPiKFbCIN5l3kSZoTsvN1mCHPO64hjXZf3q8oiK4FTp/pxyoiNu8Myvs
 tNgES+Zq95+eJGcCpGR5PCzEpHdpz3SV6OeP5rxokXo5OCl+/HBS4yNWBdDDzQlAcNaJ
 wBxAWo4yjbrwmLCDzFuD5QxU2REzVzES4Tlnll0OBvZ7fUw2LfIplmUoKN3shsv1ivlq
 avmA==
X-Gm-Message-State: AFq9FYJPquQPFw02gUIW1EOWLFHzEGKJpG50WWrKoJ7tpbDdVztblaJZ
 XGenoxSRoPTHTnFlFnil0Mh1OqDZZgzhzHYvyfpfWrAdMyQ9BnYr+NNCAtcMmg==
X-Gm-Gg: AYBFou3e4nbk+3lnZzkwXzMUcFWbKNa2MbUXjfxupEqprYIhkV5yrQjwbE17aNNXCDU
 fv6yovWMktlIfo/6xpIqLrsI01+qdI3gRVceP1AB35ksCLVgEWBbJcaWd/vtSZn/8bik32a4QQU
 SAH4WsSFkk2+6gRrf244wtoqNsadBgTL2l/bFSJ7Ciugt8VRvzzvx2YTag40mcgLd0COuiI3Gsg
 /zQJBBxezydRS0cx5fFYPLZ31JhZ0F2vvcMy2zJn0kHBUbObVUIVqa2hNB7QdvAJHsRbrtxJXI4
 S0khLx/pwBVyDrgn5heTQGRVLV1yqvJ00i3Vn6mfRLG8QHA0EFfh80chA86th4bqr3KCMoFacKR
 3kDe6nypuokFzhjK2mnYPY9k6rhsR1e66coCG+F3kNuNkHhZyfzXrw8aWYvqJWMr5rrjWLo+0gM
 Vh4bYzn+kRwE6tkrGl8c2NYwJtaLeJ5at5FcTaUz8wnx1+l3zIBsHL8YFmLsdmIZssW/09WcbAC
 Zc1C6UYJF8xkfmvepxlE+QjHxAxvuh5sHcI9PCAxGkfXqOWHRshwqoteM4VPRkdL3TBMfOpkE/6
 FFWijLtio4JEMKscky8FfTPwyiHFX1eWLR10+RdJmTzGPTz1cCKEI7Lr2MWIfM5YTgy7yTBNZAV
 NkP9u6cnkFdEB+OzF1NJE2ZCf87pRwxqLfiqb59zF0jfgkvuUI1DyhjRk8fHRf04uW9qaXwddUT
 IhMPhRjtlggUEULqzw61nQQigiyph68kBEvrwcH11SKlqIIK02DfRin8e9oqL93pSBJDCHlFZ+J
 7nckV5J21m+Qv2EKDr7CoCLbogmCvImxo8=
X-Received: by 2002:a05:600c:3547:b0:4a1:e672:5721 with SMTP id
 5b1f17b1804b1-4a1fdd2f5ecmr102624685e9.13.1792666481138; 
 Thu, 22 Oct 2026 03:54:41 -0700 (PDT)
Received: from localhost.localdomain (188.42.205.77.rev.sfr.net.
 [77.205.42.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203a265afsm72501755e9.7.2026.10.22.03.54.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 03:54:40 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com,
	felix.kuehling@amd.com
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
Date: Thu, 22 Oct 2026 12:54:35 +0200
Message-ID: <20261022105435.60056-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <5028b598-b039-46b3-b4a5-9563ab0a252e@amd.com>
References: 
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

> Yeah and you need to fix the fence orphaning and *NOT* the wait!

Agreed — found the exact orphan site. drm_sched_entity_push_job()
pushes the job onto entity->job_queue first, then
drm_sched_rq_add_entity() sees entity->stopped (under entity->lock)
and returns NULL: the scheduler is never woken, the job strands on
the spsc queue, and its fence never signals. In our repro the dying
process's fault path submits the migration job on its own killed
entity — it's the process-kill race, not a device-unplug race at
all, which is why drm_dev_enter() doesn't cover it.

This is the same failure Tong Liu reported in August 2025 (task
hang after job submission during process kill); that fix was
rejected for checking entity->stopped without the lock. The clean
fix is not to pre-check but to handle the NULL return while still
under entity->lock: drain the queue / schedule the kill-jobs work
so each stranded job's finished fence completes with -ESRCH.

> Blocking for all fences is correct shutdown order.

Agreed. v7 drops the timeout entirely — unbounded wait restored.
With fences guaranteed to signal, the copy_done error path becomes
genuinely reachable via the fence's error status, so the error
propagation and migrate->dst rollback Felix asked for stay — now
on a real error path instead of a timeout.

v7 is now implemented and tested on this machine (7.3.0-rc5 +
p1/p2 teardown+restore-stop, sched orphan fix, KFD fence-error
rework). Hot-unplug test: svmhog2 mid-migration plus a second KFD
process, then Thunderbolt deauthorize. With only the sched fix
the host still wedges — the kill-jobs drain prevents the orphan,
but the unplug path additionally needs the KFD teardown ordering
(processes torn down before device early-fini) and the restore
worker stopping on -ENODEV. With the full stack, across two
unplug/replug cycles and a 60-round kill-under-memory-pressure
soak: fences complete with error instead of orphaning, the KFD
processes get SIGBUS and reap cleanly, device tears down, host
stays alive, and re-authorizing gives a clean re-enumeration.
So your direction was right — the wait was never the bug — but
the orphan fix is necessary rather than sufficient for unplug.

On layering: I'm posting the sched fix standalone to dri-devel
("drm/scheduler: signal fences of jobs pushed to a stopped
entity") since it is drm-misc territory and also fixes the same
hang for any other driver pushing to a killed entity. The KFD
series then just needs the error propagation. Happy to fold it
into this series instead if you prefer.

Regards,
  Olivier
