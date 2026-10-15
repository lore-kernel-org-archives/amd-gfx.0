Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A38CCA464
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259C6112461;
	Thu, 15 Oct 2026 19:30:33 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C93112457
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:30:26 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so48274185e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092625; x=1792697425; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=swLy/ATKxMozoJ0Yb5sQKasWlxtfUYR6WgPATBs+RCI=;
 b=iQk90oJ8sTtoWHsWTrY07CR27K9asPrGjXgtgaDsRv6eOCB16i2WiS6M/VpIcwqWl0
 5hqR4VWo1QwzL87SCy24mM/lB6WoXWA6HDj//FPCSuJcVDjqnRzacfeNi5K1skdpGsxe
 T/oOfEYeawe1uOh49SOrpzCZ4Vd69aEWUso1kYU4YkREX9a7nD4vp/s8Ns1YyAzAFZNM
 mFoEY58dHyY6gChCkYZkEI9vrPCM/Ra26WQNKWXKK4d1JU4LQomZFLZ5jg3X5CufJxg+
 pTVNz1u3+rwmqaKltz10wcTG8W4ug0ZvYwV8VU2oWEuuGpsjbUo7bWU1zWHLg0EXfIqz
 HxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092625; x=1792697425;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=swLy/ATKxMozoJ0Yb5sQKasWlxtfUYR6WgPATBs+RCI=;
 b=090MttamrqeusA8Oq4qqYj3CuEv5SyX09nYh9hUxFfOcBtFQA7/hcmGIbnxKTHXqV9
 GIcxQtXjwn3EzfVzbcf8JhR8VwP9blQof1JxG0oiLsKiAYBK4bloQfKxONO0SCOzZw3o
 7z7doffne8vbxGrrUw3Dvy1zbor4f54Vhhe0mmdPCmL6ozUOPAd2/R50fBTu5MVQ4OxX
 xZCxBXrlp38rV9PxHu3ntT64Hsysn0C44rsKfaSNTMxut09PEv4YHEZwO75KjPQGaMGZ
 qpHu8SGSgUV6xxCW73U7hvDSjbtkSmT9M+257IZWiqfW1YkNY1DNjxch1+Zr5pThXFZH
 leww==
X-Gm-Message-State: AFq9FYI8S4KSKDQPuokxrEFyEQIfvLxTmPdxQwA+GxrOHIG7i0JdRB32
 Sc5/2dU3NR9QTFylD9MVhECsB8poEGZq+7IUH2ez0h9c8fN5fbmOeHWTq5q6YQ==
X-Gm-Gg: AYBFou3FJsDptMlVCA6CGdwa4peIZkxNcGSJ55uBHk9UPW2Ho+6VU7FTrpUX1bVsRGO
 ujhg7dDhwwkNlOX7OVJv/vx4+8Hmf0UovhPj/56yCzZDYPYBZpZOP0y/QjM1UFdWyaXq3v8rI3G
 6jjmDinRaspNIhfiEl+CieEsGmWCURrIvgEMLE5k+vmJ4lTS3cL2NEmyAguV5zE32mgeZKIRfhC
 w9N1BPsfkklvlXQL2fcbaV3C6Bp5wUFzxVr9tdXXan6tZQjZD+cdgTpcN1Zd87Vb+Jvqao7zsV/
 bod98C/+Kl7pqy0RMa/W2qXuqA1WbCdlFK3ZLL7otxl1s9ap5Z9MZvZspwlfgG/P2pK4HcarAj6
 ldbnnwjtr7YAQ9nMSdYl5v+vT4DE08ZQUsS33oMdu0/2DtjvEa+rnOJqRSGDATfiMX7RBP2Jw0k
 WMS3c+uQkBp3xohd3W6DkBidVA0AwsAJG800e8H1bM97qeqn4Mgk9N1bSJDvI8jW6ulZyBcwoFD
 c+qMPdedPNolDKUjDFc/Slmy+jBAxwyBIRd/cICEQl9s5rTPKNIUqhRx16Pw4+eD89OGzKkEaWf
 P7V8fTuJzcwGgTi6Ik9BzGqG3kK6egQ8aEdHTYvGGNhOz4HL3FKHuMnp53G3GFea8m2RqmYYmw6
 jMtbToCSvxETzTkxCVjhHR57hNs0SJNcYWv1QwEDg4XpkQmqT7khtzbZGaJzdk0WC1qIG+ZqvSJ
 nQy7mMuQPLk5W/Feo=
X-Received: by 2002:a05:600c:154c:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4a18e4a9b88mr428882185e9.13.1792092624625; 
 Thu, 15 Oct 2026 12:30:24 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:41be:7420:c1d9:bb43:318e:b925])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b303csm89277915e9.8.2026.10.15.12.30.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 12:30:24 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com
Subject: =?UTF-8?q?Re=3A=20=5BBUG=5D=20drm/amdkfd=3A=20SVM=20restore=20worker=20livelocks=20under=20memory=20reclaim=20=E2=80=94=20KFD=20process=20restart=20wedges=20until=20memory=20pressure=20subsides=20=28gfx906=29?=
Date: Thu, 15 Oct 2026 21:30:23 +0200
Message-ID: <20261015193023.86286-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2458421d-2b6b-4b81-b965-5ae6eb67edf6@amd.com>
References: 
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

Hi Felix,

Retest done on the same machine (MI50 gfx906 over TB3, Strix Halo host,
28GB RAM).

Test kernel: 7.3.0-rc5 plus
  - 25f0b322ffb5 (evict SVM BOs synchronously from TTM eviction)
  - ec4d432b     (vm range hole fix)
  - 46109de0     (skip migration when fault window already in VRAM)
  - our local series from the original report (restore convergence,
    non-xnack lock-bounded prefault, unplug/teardown guards), plus two
    migration-error propagation changes still being baked.

Reproducer: llama-server -ngl 99 with ~19GB mmap'd model
(SVM-registered), health-polled while a second allocator saturated the
remaining VRAM, then a managed-memory bounce workload
(hipMallocManaged, 2GB, 20 CPU<->GPU rounds) on ranges that dmesg
reports "over locked budget ... left evictable" — i.e. genuinely
reclaimable and migrated under pressure.

Results, 40 min sustained:

  - ftrace count of svm_range_cpu_invalidate_pagetables: 0 for the
    entire run, including a window where MemAvailable bottomed at
    ~470MB and direct reclaim was hammering the host.
  - llama-server health=200 on every poll; real inference verified.
  - Managed bounce completed all 20 rounds, no migration errors.

Baseline for comparison: on this same hardware at 7.3-rc5 + our series
without 46109de0 + copy-done propagation, the bounce workload under
VRAM eviction panic'd on Oct 3 — BUG_ON(start + size > res->size) at
amdgpu_res_cursor.h:65 inside svm_migrate_copy_to_vram, called from
svm_migrate_ram_to_vram via kfd_ioctl_svm prefetch. (EFI pstore
capture; happy to send the trace.)

So on this stack the storm is gone and the migrate path survives
forced eviction.

One honest caveat: our non-xnack locking makes registered ranges
unevictable up to a lock budget, so "inv=0" is partly by construction —
the over-budget bounce run is the part that exercises the evictable
path, and that's where the Oct-3 BUG_ON used to live.

So I ran the clean A/B: vanilla 7.3.0-rc5 with only your three commits
(25f0b322ffb5, ec4d432b, 46109de0), none of our local SVM changes,
same reclaim-storm reproducer:

  - 94.3M svm_range_cpu_invalidate_pagetables hits in 30 min
    (~4M/min, same rate as baseline)
  - llama-server never converged (health 503, RSS churning, threads
    parked in kfd_wait_on_events)
  - an earlier run went fully dark ~13 min in — no console, no ICMP,
    journal just ends (this run did not reproduce that)

So on vanilla the three commits do not resolve the livelock. 46109de0
only skips migration for windows that are already VRAM-resident; under
reclaim the faulted ranges are genuinely RAM-side, so the residency
check never engages and the evict -> restore -> re-invalidate loop is
unchanged. The failure is restore-worker convergence itself — the
invalid cmpxchg aborts that leave evicted_ranges never draining —
which none of the three commits touch.

The only thing that suppresses the storm here is our restore-worker
locking, which is a workaround with its own tradeoffs, not an
upstreamable fix — but it confirms where the loop lives.

Regards,
  Olivier
