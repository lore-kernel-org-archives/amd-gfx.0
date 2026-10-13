Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F3CCC6B2F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB4E10FD66;
	Wed, 14 Oct 2026 12:47:43 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D95110E985
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 18:54:00 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso2193495e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791917638; x=1792522438; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=swLy/ATKxMozoJ0Yb5sQKasWlxtfUYR6WgPATBs+RCI=;
 b=LJKqV8HPVuS7AQtDa46+ZrIgKgSrOWfUVw03fBOd2GSFNc6DQbfYHUW72BgHk8HLIS
 4h1BbuQrDgtn5F1VpVKrs0GCxOcahPaHXCfx+xXeEk8Q8NcWvUlHA1+65Y0ytAJaVHAA
 g5XXjiyw6hOWBS+8KQjfutUQFe4/baYGiZJ11btnbFENhqR34AKOR0U+ocKmgU0Ih4Zh
 Mfg9A+yHQug5prble/Mf6eRe0PfOnDOBkZMId0SFK84CHPf7woqPIbHtCZvL9+rOMUSg
 WJGsmJX+1s1dfZMoSE30A5cLIlQO3TPeDEETpLrp9q12zFqQ5gTkdQ4XoMMRxVtH+hKL
 zeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917638; x=1792522438;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=swLy/ATKxMozoJ0Yb5sQKasWlxtfUYR6WgPATBs+RCI=;
 b=VGJ8Ts19giQh8LiWrv7eWHTC/v0rNCFvI6Fl4263/TJm4C3u9cAP/2BJKd3te6LL68
 aarwPwPKAAoNMPRqMJLne0XIPl031b5A5JJyas0AHrkAeIE2Gsls1HMtf+YdFBfpxDGM
 A80LqUGnWH3vFebFxF4wIdFWrixug8mNhp7H1HeHBH8QwnTzhQ4h7We0lwuDUT2QJvhs
 ghFxzveFFkqiNYynGjrDg2IRaRmRAn8G9WyoOCgP6MFxfYspH89IAKUgoZwMAn4aJ9gD
 52Oj0tmsfz5SFhvs5TdwnJVy7RjIgKs5slL8iVEggPtrmZwWKLKmQ+eqeC2BGdszG/S0
 UjiA==
X-Gm-Message-State: AFq9FYJ9p/4G+DZ3mttvl2+EQuhSzXOB5nkZWMW9QyEZdqvG21grEmYA
 xDR8Xa3ooU0M+Wa7XlmNXPEcZ3O1rtSxLoIjDK68seoyQ/uq7VQ7QTORCZPA9g==
X-Gm-Gg: AYBFou331xND+wMj0hSEt1FF9sLiaPIvCX6kBC2n1kifD1r6nIB9isFc1cMlcdpEVSi
 +BMCrVw1eZ0dil8c99suBgc9MjB3RdHBpaMelI27HbXPdUhBNpyjM96lJ/bltsX1rn6WKt1Nn3G
 4GeR1Zjbp71yXAX1EFCnNTNNorI3ZZAGs/n3ger6WFb56G2RbN3AFY0FMq4ZZZj4DdsQUub7w5W
 aeV3+G+ZRBDYqfUbwvmq2kidD4bCBdwlWGjlbXA0IrjZ5TXVyjYBi9VM8TjCuU82XYNY3Du83zP
 yVfMi9fE7LzKPIYi/r4A7aDp4+Mxhi/ZWdqBilltYeHq4i39xUPQbhnY/8GlEn6uDwtIBrJ5lwH
 7YStcNc818Sgtvbg7CUWw2UQSFWDxD4q2S78BRWWmHAR+YuQ5jAuigaa57z6GIkPfWPgOH9Oqi2
 +DQ0wiDnbYKlDWKSj9//xJ/M0P0zhDXTEWPb/FqnnBBszW1smSJJvBisb138cMMHwvsxCFpIVmT
 O4tYjwZqlolXY/Cpf6PkS5nJ7o1rn/iLSFB7gfLMOC8QSu3qHYOjJhRtIEFXP/MPbIs4z92mgfS
 59PRD59agcLgUWYRiLaRv/eU/UbueORYypotqCtviAg6gbX++e4DiWxW84lXB+hK5V63fljY2LJ
 WOXA4V17m5CI5V3jitPjjgRVOhRvtOrrAxz6ScSNK0Qv1iKeLqg7qKSkRDJaIk1ALMQcXwla5Ff
 KSdu2/ckU5jhapPU8=
X-Received: by 2002:a05:600c:699b:b0:4a0:4a8:d444 with SMTP id
 5b1f17b1804b1-4a18e4af334mr276957075e9.33.1791917638329; 
 Tue, 13 Oct 2026 11:53:58 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:412d:e9fb:680d:a947:4b50:d9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd777fsm6269316f8f.57.2026.10.13.11.53.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 11:53:58 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com
Subject: =?UTF-8?q?Re=3A=20=5BBUG=5D=20drm/amdkfd=3A=20SVM=20restore=20worker=20livelocks=20under=20memory=20reclaim=20=E2=80=94=20KFD=20process=20restart=20wedges=20until=20memory=20pressure=20subsides=20=28gfx906=29?=
Date: Tue, 13 Oct 2026 20:53:56 +0200
Message-ID: <20261013185356.34009-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2458421d-2b6b-4b81-b965-5ae6eb67edf6@amd.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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
