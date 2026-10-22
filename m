Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B1606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hNQUhxhh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C3310E3D7;
	Thu, 22 Oct 2026 10:54:57 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963121124DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 10:54:51 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso4657125e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792666490; x=1793271290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LVY9RR0ejs52k/gK7nEFk0ODJIAZv1qtVQ02HFOzar0=;
 b=hNQUhxhhPgB0tQKizNOs0VpBlZ7H//lBikcxknylTcVwpOlZnFtl5GcyXCtWwS+DAG
 U2G24NWg05MMsE8pPQa1CQ9IVWsZBGvF1NQ4zdsazM79jPKgR8/QJq8fK3iz4xHwcaHC
 WPDMKOjBUpIGJnsPevDyN97RfiQUBBB4ahuMvd2I0JmnmDyn7EvzTR9BXGITkjwQ1MwX
 0P7+cYA2WnEtHHTZR8PWp5Q0KlsERtT13bNdLKtAs7+4gKKxk1ERM0qjkVzQcflDRLFy
 kMIAb9fLAXjE2UkhuLsxKX0gCR1Mh5lBuaCly1x9J6jbmu83CKK15vU8n/XtLj4h82cQ
 rivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792666490; x=1793271290;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LVY9RR0ejs52k/gK7nEFk0ODJIAZv1qtVQ02HFOzar0=;
 b=yerLzfHuG1fEgrybAGN98LX0m7Lk5KD7OCPZHM3ITap9cxkbLa2VWPgIUSXA/fLUGV
 D6O3I35MiNrPQ6JBsnTm4eyIY5Gg1nFZizwEGuNnkHoHjbqSj+Z/VUtWWns83cJ1TeIj
 h46gOyAV1OBP90VLFbIs7Q8SDheNidIOCz37YjYnDZPpNt273wC5/Zu/+yF7Td82uFJ6
 mS/0jiEAofW0Yt5hz4/A1d2BK70GEHgQF3/Lk8T0aC/leVTv9FfLQ8dHSSOcDohgViof
 cAYbZ0NOeyJDAaNWVoApjf4ytHN6MkXzaSfGD6o/8IMavqpeSf08OtAYQ3TLYfNXnZ9S
 JmUg==
X-Gm-Message-State: AFq9FYJgat8/8IDESauOK8YWz2J9aLISHZ8HWEW8DYir1EEVqbs/xuyP
 3SmqwjfQoNKV3fqcEo0JP+VZgASkj5//0NFhh23AdqGa7CsFriho6Se8el0iDA==
X-Gm-Gg: AYBFou1RJxn5BPzfAdvWlw3Ua9Elg+NA7Fnlm25wWbTZJqpRZ6r8zMfwdKCG/irwvq1
 DvA1uNBFBnZGOZtNsfLoiYylfkhr1EhSGmY5Yx6SHq66qcmxPNsDJImVrdwRP8lb7t9ccR9bo1F
 MWAZSEQy9qpKjJguzRiBBoQ0wlILWrs7JyObO92YImb8hlcmC1s2UYnUwn4XKTLxCSZOvXfnZJl
 F620BV6qDGKewX6ecNUCtzXfX6vfxgFu+/taCwPltF/Wbebe2Fy8JMD7vWWFZq0lVsBWetSvcvu
 acajZ4l1uGtGRL+5B2oTldzDzEymkQygNcruIzXtuEOFBrn9GZphWD5PBB04V8oGQN1r1nGh2Nz
 VN1Lor0ba2hLPEjYau5HP2dglWo64OSWxX9P4BiNRY15WMpj2PhzR9tAhpQjm43BCSPBV7ZFLqF
 7HNCn24JMvuEvgRPVw3L1VT6qu5kDLNP9DFsKinXu7tsETx7H0Z82A5rtd5qhrA3tHUfZE3CQpt
 hFlX8TPmj/8pUF6HX5LR/xKfLSmLh49+ZseH+XebbrTa9wEGVKYMG3PmVGOH+uWF7t05dB8pzj6
 ebe3LAjQcZ4L8SFPWQNq+F7btY/6HhAhD46741wv8cUSVC/8xaHuCrZ7Fm4lu1NDD+BNPgfnpFd
 bOJEXnQ7X7nqC2LQyuByWGh8gE0fO6P60Xf7R+gPb58oKfbVLLZIIJ5sYOtwDRgzOj3XqS13YZq
 yQhmyKmp+UaXjRvUttoOwZ85oY/I1+vc7yXHLfkyRsftVL2GAeEOL882NZ3UwXAYPouvioAJ0S7
 K77LDK4+upf/gwJF/nwEsTOQUwJy4rkMcU=
X-Received: by 2002:a05:600c:4fc9:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4a204b2032cmr42772605e9.12.1792666489719; 
 Thu, 22 Oct 2026 03:54:49 -0700 (PDT)
Received: from localhost.localdomain (188.42.205.77.rev.sfr.net.
 [77.205.42.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0b42bdsm108321235e9.0.2026.10.22.03.54.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 03:54:49 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com,
	felix.kuehling@amd.com
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
Date: Thu, 22 Oct 2026 12:54:43 +0200
Message-ID: <20261022105443.60162-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <a2b9e67d-fd7c-44fe-ad48-ce11a8bae4f9@amd.com>
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

> No, what we need to avoid killing the entity while KFD is still
> using it!
>
> That is basically an use after free what you have here, only that
> the drm_sched can point that out with a warning instead of
> crashing immediately.

The exact "use" we hit is the dying process's own exit fault:
SIGBUS -> coredump -> get_dump_page -> do_swap_page ->
svm_migrate_to_ram() submits the migration job on the process's own
entity after drm_sched_entity_kill() already ran for it.

I think we actually need two complementary things rather than a
choice between them:

b) The scheduler-level guarantee: a job pushed to an entity must
   have its fence complete. drm_sched_rq_add_entity() returning NULL
   for a stopped entity leaves the pushed job stranded on the spsc
   queue forever — that window exists independently of who killed
   the entity when. My patch closes it atomically under
   entity->lock: either the entity is live and the job queues
   normally, or it is stopped and the job goes through
   kill_jobs_work so its fence completes with -ESRCH. This is a
   generic scheduler invariant, not a KFD workaround, and it is the
   only fix demonstrated to prevent the fence-orphan hang.

   It is also required on surprise removal even with perfect entity
   lifetime ordering: a job can be pushed while the entity is still
   live, then the device disappears before the job completes. Fences
   must still signal — which is exactly your "fences *must* always
   signal" requirement.

a) The KFD-side lifetime ordering you want: don't kill the entity
   while KFD can still submit. Worth doing, but the boundary is hard
   to place — the submitter is the dying task's own mm fault path
   (coredump -> do_swap_page), not a KFD-controlled context, and the
   "mm can no longer fault on SVM ranges" point is earlier than
   exit_mmap and not obviously under KFD's teardown control.

So my question: is there an existing KFD ordering point that
guarantees no further SVM migration submission for a process's mm —
for example after MMU-notifier release but before entity kill? If
there is, I'll implement (a) there. If not, I'd like to land (b) as
the scheduler-level guarantee, and then evaluate whether an
additional KFD lifetime ordering is feasible on top.

> drm_dev_unplug() *must* be blocked until all fences are signaled.

Agreed — the drm_dev_enter/exit submit guard and the unbounded wait
stay, and copy_done now propagates dma_fence_error() so a failed
copy can never complete as a successful migration.

Regards,
  Olivier
