Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22C3CA5FA5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 12:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5495A10E97D;
	Mon, 28 Sep 2026 12:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LrQapRHd";
	dkim-atps=neutral
Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com
 [74.125.228.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E78FA10EA3A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 12:03:49 +0000 (UTC)
Received: by mail-ej2-f42.google.com with SMTP id
 a640c23a62f3a-c2da4eea067so207450166b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 05:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597028; cv=none;
 d=google.com; s=arc-20260327;
 b=Qiehz41BSBAZ0e6vv/hpIa5wFLTY8KC4bEwXvBkHXpYAs3fS4fU3J0q8nMDmqMHxPz
 Ycwaz1ePOVVo21csr9jQh+B8ajfoaTifq4nlMmhzozmSCQ4y0EwaD5JQH5LJc+pVmyVS
 mrprh4tVrIZ2NCCtl51Z+PH/65IMLMq8MMn+npqRg9N91LLUwhjcqMlNtmBNcH5pHHwp
 HEVROE2UQu+Bj+5rpPSPWYTHmiLTHJv+oYTxJqGkbUeaPTsEFf4nSFfwkkgm7twICw6Y
 CZvx9y1VBXNT5+AZ8LlQm8ZcQmWIwgk9rFOzGQgA2rv0h4gg/0zd0hRjT8LTrcmw+6lN
 /Fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Y6KxS165PQ5Go1/6WFfvqo2VEcUkbJGuWdkBsDYz6Zs=;
 fh=68ONKAUZ0bvzRQnuJqGaUwNabTKnQWhwO42dynJoBmA=;
 b=ieEE2A0W+AhcUzFLj0Vwj10TrQ00g+C0IijVTjy8XalAnI5hK8uL55TzWGyocuBKxW
 ElDSo3+syF0UkWHXSrQQairCtCalB95udLDl2Q+f/D9i1cltAzJj25CQKbvmv36O6YY7
 WWFTz3ZVpgG8ka4JOBeHjuGat0ICTLfAf5UPv8j/YQjqBrN9JfRCSlYcQEG2zFqKvy7T
 bR9Ty/djc+7fZ2U9ilsOLqE+RbnbYxOys1ZiH9707G8L/Zj3wnDOz9wdeEvoHvDhb6jM
 IOxzgGSbhpnnWZIfflgmPpKILi04SBU2qdgTmLtGSc0WCtRkKJyyCTk0u+YHR6HYcpqs
 95lg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790597028; x=1791201828; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y6KxS165PQ5Go1/6WFfvqo2VEcUkbJGuWdkBsDYz6Zs=;
 b=LrQapRHdLPFjdDcWM7/x9oaDgjKYLrF0Y3lnwTKJ+lxd1i+hSjHAUIfDvhVhMoZf3B
 T9KyDoSBe3NIBWO8JkA+77qxWGUm25fTPNVYxtvK5ZBeVmrS612+skOLhqJ3ZUo29J3r
 sQzwxAXpadTXjPUv//rQTBCzbSeCmydYh+mTRA4HA9r6NpRiiyy/9ExseXU86pK/dOdG
 ByPpnnlbAMddY1hfTCayeCDh/g/ybdJy50yjp1N6CastJJD93pyAiIrXibfkbCf5Y5i7
 4EhSc9xCTV3CRSM4qLlqhC1qNuda/E53mPUJ6CzW3JoBWVnD22rlAISMXBiMWAZXhhVM
 KRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597028; x=1791201828;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y6KxS165PQ5Go1/6WFfvqo2VEcUkbJGuWdkBsDYz6Zs=;
 b=coSB7TVrf2w1XGfb/pYChT5yXciEkkT9dudW80qg0Q4z8Y6+1oil9IjZfzHC+qIofK
 fD6Kj6Lma4r/ry4kaLVYTau+lj9CHrAHXSMTBvFgqgWPGcsEFzUIHsfa0sYsG/lybgW/
 78tgoaLnMDjMm8rHbxa1kfppAoMbBjNb9sCtyxPzQrN4f8TaPUVvMPUXYDGsMrLB9ySE
 zgHiwhO506kJNSPdSMg76lLgzJxgKAK/8uouzwARUO4qhWrkXquANNssV2iHzP4J+Dfl
 lm1yoLr9+WE8c8AHODxCqX0dBKSEfq/XcgbG2oy9Qvsysd/nkLg6cYJkCHpsm2pHYuSh
 kL6g==
X-Gm-Message-State: AFuF++mvIWQ917lsEoKc5piKR68686eG9NuUWBKf6gZEqdp6BDSmPYyS
 NG+as8zqoFFrOiUIS73+iKfwXgx8jrOiF51MSf2RqtDNoi54uhUrW46SubbEAidWrPbHSF3tUCZ
 XgmoZ2hNE+/Pi62+Hy+jRc1LucmdrFEqQ+wUkP9I=
X-Gm-Gg: AYBFou0Pkj8iV5n9dT+RlD5wJauLvqfSrbaZuTNlDcyxY8f8Ra8jJyFwBMzvM8lZdGl
 rfifF7LrWG2yzmvDBi/CwWsTDuhqwX57W9c0PuH4JZw9dDsh5abvDjAnutbjT2WaHCbIH20ty+R
 CdGldAGu0l1fsom+abwnttAQHfTR5RZDzYabAvwlLvkeQN4LgbZ9frAqz2qhq33zh/l9f8/6nfw
 VH9GDedJ4xFoXxSNvz3XE8yoF2zQKPycb+5zQlsjQ+8Z+kgWq+lFCBs93PKgaemK0Us8iWT43fL
 ldj7sTxb6GiOp6DjWtnitxsmhjxh84ciSWX8yTZuB6wb7ifJFhoHG/PaeTU88UOrE0+p7xvcORH
 14HNntDJHSW/Gu6af65gM4qyrUbjC8i82LUQ4hAU53PfQdhK9bA4j3rucsqqglCKj/JXWYU1WeY
 vRzpuZqPwvpgoxELC8hY2zm6HgXl2C6B2rQtVQkp3Rlq7+p0Ispl/9p+ve14RS3dG3pCfNrJZfb
 G+z+xVU1XhD/6VBNxniNy+OxBM=
X-Received: by 2002:a17:907:b046:10b0:c2a:f1e7:d1f8 with SMTP id
 a640c23a62f3a-c2af1e7d8f0mr459998966b.17.1790597027786; Mon, 28 Sep 2026
 05:03:47 -0700 (PDT)
MIME-Version: 1.0
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Date: Mon, 28 Sep 2026 14:03:35 +0200
X-Gm-Features: AclHuK8uBglstwh6pBAfeQbqvjkoymCo77z2ejojG_1J9d2hVz5qWmoimbGNEp4
Message-ID: <CAKLTOU_Rd4Cm8PQZ4Acu8u49rnGwKcTYonMsBggUASrHhaiMoA@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_drm=2Famdkfd=3A_SVM_restore_worker_livelocks_under?=
 =?UTF-8?Q?_memory_reclaim_=E2=80=94_KFD_process_restart_wedges_until_memory_?=
 =?UTF-8?Q?pressure_subsides_=28gfx906=29?=
To: amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com
Content-Type: multipart/mixed; boundary="000000000000c77e31065c89dba4"
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

--000000000000c77e31065c89dba4
Content-Type: multipart/alternative; boundary="000000000000c77e30065c89dba2"

--000000000000c77e30065c89dba2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=3D=3D Summary =3D=3D

Restarting a KFD application reliably wedges the next instance during
initial GPU memory allocations whenever the system is under memory
pressure. The root cause is an invalidation-storm livelock in the SVM
eviction/restore path:

    kswapd / kcompactd reclaim or migrate a page inside the process's
    SVM-registered address space
      -> mmu interval notifier -> svm_range_cpu_invalidate_pagetables
      -> svm_range_evict: prange->invalid++, svms->evicted_ranges++,
         quiesce_mm(), schedule svm_range_restore_work
      -> svm_range_restore_work takes mmap write lock, walks the range
         list, re-faults pages via hmm_vma_fault and remaps them to the
         GPU
      -> those pages are reclaim candidates again immediately; the next
         invalidation lands mid-pass -> per-range cmpxchg on
         prange->invalid fails -> goto out_reschedule aborts the whole
         pass
      -> evicted_ranges never drains to 0 -> kgd2kfd_resume_mm() never
         runs -> KFD queues stay quiesced forever

Because svm_range_evict() increments both counters on EVERY invalidate
callback (even for ranges already marked invalid) and restore_work
aborts the ENTIRE pass on the first re-dirtied range, convergence
requires a perfectly quiet window that does not exist under sustained
reclaim. Observed on the wedged system: ~900 invalidations/sec
(svm_range_cpu_invalidate_pagetables, counted via ftrace), per-range
"inv" counters in the tens of thousands (max seen: 32769), and the
userspace process spinning in the HSA runtime waiting for a queue
signal that never arrives =E2=80=94 or blocked in D state in
svm_range_list_lock_and_flush_work.

Two secondary bugs compound this:

  (a) svm_range_restore_work holds mmap_write_lock for the whole pass;
      concurrent mm walkers (incl. reclaim-side access_remote_vm) stall
      behind it =E2=80=94 Emily Deng's Feb-2025 mmap_write_downgrade fix
      addresses the lock-ordering part and is confirmed missing in the
      tested kernels.

  (b) A !vma range returns -EFAULT and reschedules forever instead of
      unmapping the stale GPU mapping =E2=80=94 Philip Yang's Oct-2025 fix;
      also missing in the tested kernels. On teardown/restart (dead
      VMAs pending restore) this alone can pin the worker.

=3D=3D Environment =3D=3D

  GPU:        AMD Radeon Instinct MI50 32GB, gfx906, 0000:05:00.0
              (Vega 20, PCIe, attached via Thunderbolt 3 eGPU enclosure)
  Host:       AMD Strix Halo (Ryzen AI Max+ 395), 28GB RAM, Proxmox VE 9
  Kernels:    6.17.13-13-pve, 7.0.12-1-pve, 7.2.6-k726 =E2=80=94 all affect=
ed
  Cmdline:    amdgpu.dc=3D0 modprobe.blacklist=3Damdxdna apparmor=3D0
  Userspace:  llama.cpp llama-server (HIP/ROCm), hsakmt; ~19GB model
              mmap'd into the SVM-registered address space
  Taint:      512 (unsigned module; none in the KFD path)

=3D=3D Trigger: memory pressure =3D=3D

The wedge is deterministically controlled by reclaim pressure on the
KFD process's SVM-registered pages:

  * Docker swarm (~95 services) up, ~8-12GB available:
    restart -> invalidation storm, never healthy (health endpoint
    stays 503; process spins in userspace or D-state in the alloc
    ioctl; storm continues even after SIGSTOPping the process =E2=80=94
    17,488 invalidates in 20s with userspace frozen; it is
    kernel-driven).

  * Same machine, swarm scaled to 0, ~24GB available:
    restart -> health=3D200, clean load, real inference OK.

  * Same machine, swarm up, llama-server started with --mlock
    (model pages unevictable):
    restart under pressure -> health=3D200, ftrace count of
    svm_range_cpu_invalidate_pagetables =3D 0. The storm cannot start
    when reclaim cannot touch the pages.

  * ftrace stack traces of svm_range_cpu_invalidate_pagetables during
    the storm: kcompactd -> compact_zone -> migrate_pages ->
    try_to_migrate -> __mmu_notifier_invalidate_range_start, and
    kswapd -> shrink_folio_list -> try_to_unmap -> same path
    (via __rmap_walk_file =E2=80=94 the mmap'd GGUF file pages).

=3D=3D Reproduction =3D=3D

  1. Boot with the MI50 bound to amdgpu/KFD.
  2. Start a KFD app that mmap's ~19GB of file-backed model data into
     its SVM-registered address space (llama-server -ngl 99).
  3. Create sustained memory pressure (busy service stack, or
     anonymous churn so kswapd keeps scanning).
  4. systemctl restart. The new instance wedges during VRAM/SVM
     setup; dmesg (with dyndbg) shows svm_range_restore_work
     rescheduling indefinitely.

=3D=3D Observed stacks (kernel 7.2.6) =3D=3D

  Userspace process (llama-server, D state):

      __flush_work+0x2c4/0x3c0
      flush_work+0x1c/0x30
      svm_range_list_lock_and_flush_work+0x2f/0x100 [amdgpu]
      kfd_ioctl_alloc_memory_of_gpu+0x7c/0x3a0 [amdgpu]

  Concurrent kworker (D state, same boot):

      __flush_work+0x2c4/0x3c0
      flush_work+0x1c/0x30
      svm_range_list_lock_and_flush_work+0x2f/0x100 [amdgpu]
      svm_range_restore_work+0x75/0x3a0 [amdgpu]
      process_one_work+0x1a9/0x390

  With dyndbg enabled the log fills with:
      kfd kfd: [pid N] restore svm ranges
      ... restoring svms ... inv 74 / inv 52 / ... / inv 32769
      kfd kfd: [pid N] reschedule to restore svm ranges
  (~900 lines/sec; journald flooding itself degrades the machine.)

=3D=3D Tested fix =3D=3D

A patch against 7.2.6 combining the two missing upstream fixes plus a
restore-pass convergence fix (attached:
0001-amdkfd-svm-restore-convergence.patch):

  1. Backport Emily Deng's mmap_write_downgrade() in
     svm_range_restore_work (Feb 2025).
  2. Backport Philip Yang's !vma -> svm_range_unmap_from_gpus handling
     (Oct 2025), adapted to this tree's amdgpu_hmm_range_* API; this
     also fixes a latent units bug: the old !VM_READ path compared
     byte-address start/end against page-index prange->start/last, so
     the unmap never fired.
  3. Convergence fix (new): in svm_range_restore_work, do not abort the
     pass on the first range that fails or is re-dirtied mid-restore.
     Restore each dirty range independently; if a range is
     re-invalidated during its own restore or fails to map, mark
     need_retry and continue with the remaining ranges. Reschedule one
     more pass only if anything is still dirty, and still take the
     evicted_ranges snapshot consistency check before resuming queues.
     Each pass now makes monotonic per-range progress instead of
     requiring an all-clean sweep.

=3D=3D Results =3D=3D

  Patched amdgpu.ko on 7.2.6-k726, swarm fully up (original failing
  conditions, swap enabled, default vm tunables), llama WITHOUT mlock:

    restart round 1: invalidations =3D 668  -> health=3D200 @ 176s
    restart round 2: invalidations =3D 898  -> health=3D200 @ 102s
    restart round 3: invalidations =3D 2146 -> health=3D200 @ 125s

  vs unpatched: identical conditions produced a non-converging storm
  (inv counts into the tens of thousands, max 32769 observed on one
  range) and the process never became healthy.

  Inference verified working after each healthy restart.

  Sustained-pressure follow-up (patch 1 installed, cgroup
  MemoryHigh=3D6G on the service during model reload =E2=80=94 continuous
  direct reclaim of the process's own pages):

    invalidations > 156,000 and still climbing when killed
    health=3D503 persisted >15 min, RSS pinned ~13GB
    storm CONTINUED after releasing the cgroup squeeze =E2=80=94
      restore_work's own refaults kept feeding it

  Conclusion: patch 1 fixes convergence under bursty invalidation
  but not the reclaim->invalidate->restore->refault feedback loop
  under sustained reclaim. Restored pages remain reclaim candidates,
  so a clean pass can never complete while pressure continues.

=3D=3D Second fix: make registered ranges unevictable (patch 2) =3D=3D

On non-xnack hardware the GPU cannot fault CPU pages back in, so
every resident page inside a registered SVM interval must stay
resident while the interval exists; reclaiming one is always futile
=E2=80=94 restore_work just faults it straight back in. The bug is not that
restore retries; it is that the VM may take pages the GPU mapping
fundamentally requires.

Two failed mechanisms before the working one:

  - Pinning folios at dma_map time (refcount + PG_mlocked mark):
    insufficient =E2=80=94 a folio only becomes unreclaimable once it is
    moved to the unevictable LRU list, and the primitives that move
    an already-LRU folio (mlock_folio, __mlock_folio, lruvec helpers)
    are not exported to modules. Flagged-but-evictable folios were
    still scanned, still unmapped, still stormed (253k+ observed).

  - VM_LOCKED alone on covering VMAs: try_to_unmap_one() does bail
    on VM_LOCKED before the PTE clear and lazily mlocks the folio =E2=80=94
    but mmu_notifier_invalidate_range_start() fires at the TOP of
    try_to_unmap, before the rmap walk discovers the flag. Every
    reclaim attempt on a not-yet-locked folio still costs one
    invalidation. Bounded per page, but under sustained pressure the
    load only crawled (RSS growth ~1GB/5min, inv into six figures).

Working approach (attached: 0002-amdkfd-nonxnack-lock.patch):

  In svm_range_add_notifier_locked() =E2=80=94 the single funnel where ever=
y
  registered interval is inserted =E2=80=94 when !p->xnack_enabled:

    1. Set VM_LOCKED on all VMAs covering the registered range
       (vma_start_write + vm_flags_set; callers already hold
       mmap_write_lock for mmu_interval_notifier_insert_locked).
    2. Prefault the range with batched get_user_pages_remote(FOLL_GET
       then put_page): pages faulted into a VM_LOCKED vma are placed
       on the unevictable LRU by the normal fault path
       (lru_cache_add_inactive_or_unevictable), so reclaim never
       selects them and the notifier never fires.

  This is exactly what userspace mlock() does (VM_LOCKED + prefault),
  applied at registration to the ranges the GPU may touch =E2=80=94 matchin=
g
  the --mlock measurement (0 invalidations, immune restart).

=3D=3D Results with patch 2 =3D=3D

  Same environment (full swarm, swap enabled, no --mlock):

    cold boot load under swarm pressure: inv =3D 4   -> health=3D200
    restart under live swarm churn, round 1: +694  -> health=3D200 @102s
    restart under live swarm churn, round 2: +83   -> health=3D200 @102s
    restart after repeated cycles:         ~3.3k   -> health=3D200 @195s

  Residual invalidations are one-time lazy-lock transitions on pages
  resident before their VMA was locked plus non-reclaim notifier
  events =E2=80=94 bounded, not self-sustaining. The storm no longer feeds
  on itself: releasing memory pressure once stopped the counter
  dead instead of the storm continuing.

  Note: with a hard cgroup cap below the model footprint
  (MemoryHigh=3D6G vs ~19G needed), locked+prefaulted pages are
  correctly unevictable but the workload cannot fit =E2=80=94 expected, and
  identical to userspace --mlock under the same cap.

  Deployment gotcha worth noting: on this host amdgpu.ko ships in
  the initramfs and loads at ~3s, so /lib/modules replacement alone
  did nothing until update-initramfs -u was run.

=3D=3D What was ruled out =3D=3D

  - HSA_XNACK=3D0 does not avoid it (gfx906 has no xnack anyway).
  - Not alloc-size specific (8GB context reproduces too).
  - Not the custom kernel: identical on stock 6.17.13-13-pve,
    7.0.12-1-pve.
  - Not the model file specifically: --no-mmap still storms (any
    file-backed pages inside the SVM-registered mm are enough).
  - Not a swap-only issue: storm persists with swap disabled while
    other reclaim pressure exists; kcompactd page migration alone
    suffices.
  - kfdtest memory/queue tests pass while a healthy client holds the
    device.

=3D=3D Logs =3D=3D

  SysRq-w dumps, blocked stacks, dyndbg excerpts, ftrace stack samples
  and counters available on request.

=3D=3D Notes for maintainers =3D=3D

  - MI50 is behind Thunderbolt (hotplug PCI topology). If restore
    scheduling interacts with hotplug eviction paths this box may
    expose a wider timing window than fixed-PCIe systems. Happy to
    test patches =E2=80=94 reproduction takes ~5 minutes.
  - The convergence change (3) is a proposal; it preserves the
    "queues resume only when clean" guarantee via the existing
    evicted_ranges consistency check, but review of the
    retry-vs-resume ordering is welcome.

--000000000000c77e30065c89dba2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=3D=3D Summary =3D=3D<br><br>Restarting a KFD application =
reliably wedges the next instance during<br>initial GPU memory allocations =
whenever the system is under memory<br>pressure. The root cause is an inval=
idation-storm livelock in the SVM<br>eviction/restore path:<br><br>=C2=A0 =
=C2=A0 kswapd / kcompactd reclaim or migrate a page inside the process&#39;=
s<br>=C2=A0 =C2=A0 SVM-registered address space<br>=C2=A0 =C2=A0 =C2=A0 -&g=
t; mmu interval notifier -&gt; svm_range_cpu_invalidate_pagetables<br>=C2=
=A0 =C2=A0 =C2=A0 -&gt; svm_range_evict: prange-&gt;invalid++, svms-&gt;evi=
cted_ranges++,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0quiesce_mm(), schedule =
svm_range_restore_work<br>=C2=A0 =C2=A0 =C2=A0 -&gt; svm_range_restore_work=
 takes mmap write lock, walks the range<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0list, re-faults pages via hmm_vma_fault and remaps them to the<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPU<br>=C2=A0 =C2=A0 =C2=A0 -&gt; those pages a=
re reclaim candidates again immediately; the next<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0invalidation lands mid-pass -&gt; per-range cmpxchg on<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prange-&gt;invalid fails -&gt; goto out_resc=
hedule aborts the whole<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>=C2=A0=
 =C2=A0 =C2=A0 -&gt; evicted_ranges never drains to 0 -&gt; kgd2kfd_resume_=
mm() never<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runs -&gt; KFD queues stay =
quiesced forever<br><br>Because svm_range_evict() increments both counters =
on EVERY invalidate<br>callback (even for ranges already marked invalid) an=
d restore_work<br>aborts the ENTIRE pass on the first re-dirtied range, con=
vergence<br>requires a perfectly quiet window that does not exist under sus=
tained<br>reclaim. Observed on the wedged system: ~900 invalidations/sec<br=
>(svm_range_cpu_invalidate_pagetables, counted via ftrace), per-range<br>&q=
uot;inv&quot; counters in the tens of thousands (max seen: 32769), and the<=
br>userspace process spinning in the HSA runtime waiting for a queue<br>sig=
nal that never arrives =E2=80=94 or blocked in D state in<br>svm_range_list=
_lock_and_flush_work.<br><br>Two secondary bugs compound this:<br><br>=C2=
=A0 (a) svm_range_restore_work holds mmap_write_lock for the whole pass;<br=
>=C2=A0 =C2=A0 =C2=A0 concurrent mm walkers (incl. reclaim-side access_remo=
te_vm) stall<br>=C2=A0 =C2=A0 =C2=A0 behind it =E2=80=94 Emily Deng&#39;s F=
eb-2025 mmap_write_downgrade fix<br>=C2=A0 =C2=A0 =C2=A0 addresses the lock=
-ordering part and is confirmed missing in the<br>=C2=A0 =C2=A0 =C2=A0 test=
ed kernels.<br><br>=C2=A0 (b) A !vma range returns -EFAULT and reschedules =
forever instead of<br>=C2=A0 =C2=A0 =C2=A0 unmapping the stale GPU mapping =
=E2=80=94 Philip Yang&#39;s Oct-2025 fix;<br>=C2=A0 =C2=A0 =C2=A0 also miss=
ing in the tested kernels. On teardown/restart (dead<br>=C2=A0 =C2=A0 =C2=
=A0 VMAs pending restore) this alone can pin the worker.<br><br>=3D=3D Envi=
ronment =3D=3D<br><br>=C2=A0 GPU: =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD Radeon Ins=
tinct MI50 32GB, gfx906, 0000:05:00.0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (Vega 20, PCIe, attached via Thunderbolt 3 eGPU enclosure)<b=
r>=C2=A0 Host: =C2=A0 =C2=A0 =C2=A0 AMD Strix Halo (Ryzen AI Max+ 395), 28G=
B RAM, Proxmox VE 9<br>=C2=A0 Kernels: =C2=A0 =C2=A06.17.13-13-pve, 7.0.12-=
1-pve, 7.2.6-k726 =E2=80=94 all affected<br>=C2=A0 Cmdline: =C2=A0 =C2=A0am=
dgpu.dc=3D0 modprobe.blacklist=3Damdxdna apparmor=3D0<br>=C2=A0 Userspace: =
=C2=A0llama.cpp llama-server (HIP/ROCm), hsakmt; ~19GB model<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap&#39;d into the SVM-registered a=
ddress space<br>=C2=A0 Taint: =C2=A0 =C2=A0 =C2=A0512 (unsigned module; non=
e in the KFD path)<br><br>=3D=3D Trigger: memory pressure =3D=3D<br><br>The=
 wedge is deterministically controlled by reclaim pressure on the<br>KFD pr=
ocess&#39;s SVM-registered pages:<br><br>=C2=A0 * Docker swarm (~95 service=
s) up, ~8-12GB available:<br>=C2=A0 =C2=A0 restart -&gt; invalidation storm=
, never healthy (health endpoint<br>=C2=A0 =C2=A0 stays 503; process spins =
in userspace or D-state in the alloc<br>=C2=A0 =C2=A0 ioctl; storm continue=
s even after SIGSTOPping the process =E2=80=94<br>=C2=A0 =C2=A0 17,488 inva=
lidates in 20s with userspace frozen; it is<br>=C2=A0 =C2=A0 kernel-driven)=
.<br><br>=C2=A0 * Same machine, swarm scaled to 0, ~24GB available:<br>=C2=
=A0 =C2=A0 restart -&gt; health=3D200, clean load, real inference OK.<br><b=
r>=C2=A0 * Same machine, swarm up, llama-server started with --mlock<br>=C2=
=A0 =C2=A0 (model pages unevictable):<br>=C2=A0 =C2=A0 restart under pressu=
re -&gt; health=3D200, ftrace count of<br>=C2=A0 =C2=A0 svm_range_cpu_inval=
idate_pagetables =3D 0. The storm cannot start<br>=C2=A0 =C2=A0 when reclai=
m cannot touch the pages.<br><br>=C2=A0 * ftrace stack traces of svm_range_=
cpu_invalidate_pagetables during<br>=C2=A0 =C2=A0 the storm: kcompactd -&gt=
; compact_zone -&gt; migrate_pages -&gt;<br>=C2=A0 =C2=A0 try_to_migrate -&=
gt; __mmu_notifier_invalidate_range_start, and<br>=C2=A0 =C2=A0 kswapd -&gt=
; shrink_folio_list -&gt; try_to_unmap -&gt; same path<br>=C2=A0 =C2=A0 (vi=
a __rmap_walk_file =E2=80=94 the mmap&#39;d GGUF file pages).<br><br>=3D=3D=
 Reproduction =3D=3D<br><br>=C2=A0 1. Boot with the MI50 bound to amdgpu/KF=
D.<br>=C2=A0 2. Start a KFD app that mmap&#39;s ~19GB of file-backed model =
data into<br>=C2=A0 =C2=A0 =C2=A0its SVM-registered address space (llama-se=
rver -ngl 99).<br>=C2=A0 3. Create sustained memory pressure (busy service =
stack, or<br>=C2=A0 =C2=A0 =C2=A0anonymous churn so kswapd keeps scanning).=
<br>=C2=A0 4. systemctl restart. The new instance wedges during VRAM/SVM<br=
>=C2=A0 =C2=A0 =C2=A0setup; dmesg (with dyndbg) shows svm_range_restore_wor=
k<br>=C2=A0 =C2=A0 =C2=A0rescheduling indefinitely.<br><br>=3D=3D Observed =
stacks (kernel 7.2.6) =3D=3D<br><br>=C2=A0 Userspace process (llama-server,=
 D state):<br><br>=C2=A0 =C2=A0 =C2=A0 __flush_work+0x2c4/0x3c0<br>=C2=A0 =
=C2=A0 =C2=A0 flush_work+0x1c/0x30<br>=C2=A0 =C2=A0 =C2=A0 svm_range_list_l=
ock_and_flush_work+0x2f/0x100 [amdgpu]<br>=C2=A0 =C2=A0 =C2=A0 kfd_ioctl_al=
loc_memory_of_gpu+0x7c/0x3a0 [amdgpu]<br><br>=C2=A0 Concurrent kworker (D s=
tate, same boot):<br><br>=C2=A0 =C2=A0 =C2=A0 __flush_work+0x2c4/0x3c0<br>=
=C2=A0 =C2=A0 =C2=A0 flush_work+0x1c/0x30<br>=C2=A0 =C2=A0 =C2=A0 svm_range=
_list_lock_and_flush_work+0x2f/0x100 [amdgpu]<br>=C2=A0 =C2=A0 =C2=A0 svm_r=
ange_restore_work+0x75/0x3a0 [amdgpu]<br>=C2=A0 =C2=A0 =C2=A0 process_one_w=
ork+0x1a9/0x390<br><br>=C2=A0 With dyndbg enabled the log fills with:<br>=
=C2=A0 =C2=A0 =C2=A0 kfd kfd: [pid N] restore svm ranges<br>=C2=A0 =C2=A0 =
=C2=A0 ... restoring svms ... inv 74 / inv 52 / ... / inv 32769<br>=C2=A0 =
=C2=A0 =C2=A0 kfd kfd: [pid N] reschedule to restore svm ranges<br>=C2=A0 (=
~900 lines/sec; journald flooding itself degrades the machine.)<br><br>=3D=
=3D Tested fix =3D=3D<br><br>A patch against 7.2.6 combining the two missin=
g upstream fixes plus a<br>restore-pass convergence fix (attached:<br>0001-=
amdkfd-svm-restore-convergence.patch):<br><br>=C2=A0 1. Backport Emily Deng=
&#39;s mmap_write_downgrade() in<br>=C2=A0 =C2=A0 =C2=A0svm_range_restore_w=
ork (Feb 2025).<br>=C2=A0 2. Backport Philip Yang&#39;s !vma -&gt; svm_rang=
e_unmap_from_gpus handling<br>=C2=A0 =C2=A0 =C2=A0(Oct 2025), adapted to th=
is tree&#39;s amdgpu_hmm_range_* API; this<br>=C2=A0 =C2=A0 =C2=A0also fixe=
s a latent units bug: the old !VM_READ path compared<br>=C2=A0 =C2=A0 =C2=
=A0byte-address start/end against page-index prange-&gt;start/last, so<br>=
=C2=A0 =C2=A0 =C2=A0the unmap never fired.<br>=C2=A0 3. Convergence fix (ne=
w): in svm_range_restore_work, do not abort the<br>=C2=A0 =C2=A0 =C2=A0pass=
 on the first range that fails or is re-dirtied mid-restore.<br>=C2=A0 =C2=
=A0 =C2=A0Restore each dirty range independently; if a range is<br>=C2=A0 =
=C2=A0 =C2=A0re-invalidated during its own restore or fails to map, mark<br=
>=C2=A0 =C2=A0 =C2=A0need_retry and continue with the remaining ranges. Res=
chedule one<br>=C2=A0 =C2=A0 =C2=A0more pass only if anything is still dirt=
y, and still take the<br>=C2=A0 =C2=A0 =C2=A0evicted_ranges snapshot consis=
tency check before resuming queues.<br>=C2=A0 =C2=A0 =C2=A0Each pass now ma=
kes monotonic per-range progress instead of<br>=C2=A0 =C2=A0 =C2=A0requirin=
g an all-clean sweep.<br><br>=3D=3D Results =3D=3D<br><br>=C2=A0 Patched am=
dgpu.ko on 7.2.6-k726, swarm fully up (original failing<br>=C2=A0 condition=
s, swap enabled, default vm tunables), llama WITHOUT mlock:<br><br>=C2=A0 =
=C2=A0 restart round 1: invalidations =3D 668 =C2=A0-&gt; health=3D200 @ 17=
6s<br>=C2=A0 =C2=A0 restart round 2: invalidations =3D 898 =C2=A0-&gt; heal=
th=3D200 @ 102s<br>=C2=A0 =C2=A0 restart round 3: invalidations =3D 2146 -&=
gt; health=3D200 @ 125s<br><br>=C2=A0 vs unpatched: identical conditions pr=
oduced a non-converging storm<br>=C2=A0 (inv counts into the tens of thousa=
nds, max 32769 observed on one<br>=C2=A0 range) and the process never becam=
e healthy.<br><br>=C2=A0 Inference verified working after each healthy rest=
art.<br><br>=C2=A0 Sustained-pressure follow-up (patch 1 installed, cgroup<=
br>=C2=A0 MemoryHigh=3D6G on the service during model reload =E2=80=94 cont=
inuous<br>=C2=A0 direct reclaim of the process&#39;s own pages):<br><br>=C2=
=A0 =C2=A0 invalidations &gt; 156,000 and still climbing when killed<br>=C2=
=A0 =C2=A0 health=3D503 persisted &gt;15 min, RSS pinned ~13GB<br>=C2=A0 =
=C2=A0 storm CONTINUED after releasing the cgroup squeeze =E2=80=94<br>=C2=
=A0 =C2=A0 =C2=A0 restore_work&#39;s own refaults kept feeding it<br><br>=
=C2=A0 Conclusion: patch 1 fixes convergence under bursty invalidation<br>=
=C2=A0 but not the reclaim-&gt;invalidate-&gt;restore-&gt;refault feedback =
loop<br>=C2=A0 under sustained reclaim. Restored pages remain reclaim candi=
dates,<br>=C2=A0 so a clean pass can never complete while pressure continue=
s.<br><br>=3D=3D Second fix: make registered ranges unevictable (patch 2) =
=3D=3D<br><br>On non-xnack hardware the GPU cannot fault CPU pages back in,=
 so<br>every resident page inside a registered SVM interval must stay<br>re=
sident while the interval exists; reclaiming one is always futile<br>=E2=80=
=94 restore_work just faults it straight back in. The bug is not that<br>re=
store retries; it is that the VM may take pages the GPU mapping<br>fundamen=
tally requires.<br><br>Two failed mechanisms before the working one:<br><br=
>=C2=A0 - Pinning folios at dma_map time (refcount + PG_mlocked mark):<br>=
=C2=A0 =C2=A0 insufficient =E2=80=94 a folio only becomes unreclaimable onc=
e it is<br>=C2=A0 =C2=A0 moved to the unevictable LRU list, and the primiti=
ves that move<br>=C2=A0 =C2=A0 an already-LRU folio (mlock_folio, __mlock_f=
olio, lruvec helpers)<br>=C2=A0 =C2=A0 are not exported to modules. Flagged=
-but-evictable folios were<br>=C2=A0 =C2=A0 still scanned, still unmapped, =
still stormed (253k+ observed).<br><br>=C2=A0 - VM_LOCKED alone on covering=
 VMAs: try_to_unmap_one() does bail<br>=C2=A0 =C2=A0 on VM_LOCKED before th=
e PTE clear and lazily mlocks the folio =E2=80=94<br>=C2=A0 =C2=A0 but mmu_=
notifier_invalidate_range_start() fires at the TOP of<br>=C2=A0 =C2=A0 try_=
to_unmap, before the rmap walk discovers the flag. Every<br>=C2=A0 =C2=A0 r=
eclaim attempt on a not-yet-locked folio still costs one<br>=C2=A0 =C2=A0 i=
nvalidation. Bounded per page, but under sustained pressure the<br>=C2=A0 =
=C2=A0 load only crawled (RSS growth ~1GB/5min, inv into six figures).<br><=
br>Working approach (attached: 0002-amdkfd-nonxnack-lock.patch):<br><br>=C2=
=A0 In svm_range_add_notifier_locked() =E2=80=94 the single funnel where ev=
ery<br>=C2=A0 registered interval is inserted =E2=80=94 when !p-&gt;xnack_e=
nabled:<br><br>=C2=A0 =C2=A0 1. Set VM_LOCKED on all VMAs covering the regi=
stered range<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0(vma_start_write + vm_flags_set;=
 callers already hold<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_write_lock for mmu=
_interval_notifier_insert_locked).<br>=C2=A0 =C2=A0 2. Prefault the range w=
ith batched get_user_pages_remote(FOLL_GET<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0th=
en put_page): pages faulted into a VM_LOCKED vma are placed<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0on the unevictable LRU by the normal fault path<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0(lru_cache_add_inactive_or_unevictable), so reclaim nev=
er<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0selects them and the notifier never fires.=
<br><br>=C2=A0 This is exactly what userspace mlock() does (VM_LOCKED + pre=
fault),<br>=C2=A0 applied at registration to the ranges the GPU may touch =
=E2=80=94 matching<br>=C2=A0 the --mlock measurement (0 invalidations, immu=
ne restart).<br><br>=3D=3D Results with patch 2 =3D=3D<br><br>=C2=A0 Same e=
nvironment (full swarm, swap enabled, no --mlock):<br><br>=C2=A0 =C2=A0 col=
d boot load under swarm pressure: inv =3D 4 =C2=A0 -&gt; health=3D200<br>=
=C2=A0 =C2=A0 restart under live swarm churn, round 1: +694 =C2=A0-&gt; hea=
lth=3D200 @102s<br>=C2=A0 =C2=A0 restart under live swarm churn, round 2: +=
83 =C2=A0 -&gt; health=3D200 @102s<br>=C2=A0 =C2=A0 restart after repeated =
cycles: =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~3.3k =C2=A0 -&gt; health=3D200 @195s<b=
r><br>=C2=A0 Residual invalidations are one-time lazy-lock transitions on p=
ages<br>=C2=A0 resident before their VMA was locked plus non-reclaim notifi=
er<br>=C2=A0 events =E2=80=94 bounded, not self-sustaining. The storm no lo=
nger feeds<br>=C2=A0 on itself: releasing memory pressure once stopped the =
counter<br>=C2=A0 dead instead of the storm continuing.<br><br>=C2=A0 Note:=
 with a hard cgroup cap below the model footprint<br>=C2=A0 (MemoryHigh=3D6=
G vs ~19G needed), locked+prefaulted pages are<br>=C2=A0 correctly unevicta=
ble but the workload cannot fit =E2=80=94 expected, and<br>=C2=A0 identical=
 to userspace --mlock under the same cap.<br><br>=C2=A0 Deployment gotcha w=
orth noting: on this host amdgpu.ko ships in<br>=C2=A0 the initramfs and lo=
ads at ~3s, so /lib/modules replacement alone<br>=C2=A0 did nothing until u=
pdate-initramfs -u was run.<br><br>=3D=3D What was ruled out =3D=3D<br><br>=
=C2=A0 - HSA_XNACK=3D0 does not avoid it (gfx906 has no xnack anyway).<br>=
=C2=A0 - Not alloc-size specific (8GB context reproduces too).<br>=C2=A0 - =
Not the custom kernel: identical on stock 6.17.13-13-pve,<br>=C2=A0 =C2=A0 =
7.0.12-1-pve.<br>=C2=A0 - Not the model file specifically: --no-mmap still =
storms (any<br>=C2=A0 =C2=A0 file-backed pages inside the SVM-registered mm=
 are enough).<br>=C2=A0 - Not a swap-only issue: storm persists with swap d=
isabled while<br>=C2=A0 =C2=A0 other reclaim pressure exists; kcompactd pag=
e migration alone<br>=C2=A0 =C2=A0 suffices.<br>=C2=A0 - kfdtest memory/que=
ue tests pass while a healthy client holds the<br>=C2=A0 =C2=A0 device.<br>=
<br>=3D=3D Logs =3D=3D<br><br>=C2=A0 SysRq-w dumps, blocked stacks, dyndbg =
excerpts, ftrace stack samples<br>=C2=A0 and counters available on request.=
<br><br>=3D=3D Notes for maintainers =3D=3D<br><br>=C2=A0 - MI50 is behind =
Thunderbolt (hotplug PCI topology). If restore<br>=C2=A0 =C2=A0 scheduling =
interacts with hotplug eviction paths this box may<br>=C2=A0 =C2=A0 expose =
a wider timing window than fixed-PCIe systems. Happy to<br>=C2=A0 =C2=A0 te=
st patches =E2=80=94 reproduction takes ~5 minutes.<br>=C2=A0 - The converg=
ence change (3) is a proposal; it preserves the<br>=C2=A0 =C2=A0 &quot;queu=
es resume only when clean&quot; guarantee via the existing<br>=C2=A0 =C2=A0=
 evicted_ranges consistency check, but review of the<br>=C2=A0 =C2=A0 retry=
-vs-resume ordering is welcome.<br></div>

--000000000000c77e30065c89dba2--

--000000000000c77e31065c89dba4
Content-Type: application/octet-stream; 
	name="0001-amdkfd-svm-restore-convergence.patch"
Content-Disposition: attachment; 
	filename="0001-amdkfd-svm-restore-convergence.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mul74zuq1>
X-Attachment-Id: f_mul74zuq1

RnJvbToga2Fsb3UgPHJlc2VhcmNoQGJlbGVnYW5qdXIua2Fsb3UubmV0PgpTdWJqZWN0OiBbUEFU
Q0ggMS8yXSBkcm0vYW1ka2ZkOiBTVk0gcmVzdG9yZSBjb252ZXJnZW5jZSB1bmRlciBpbnZhbGlk
YXRpb24gc3Rvcm1zCgpOT1RFOiBmb3IgcmVmZXJlbmNlIC8gdGVzdGVkLWZpeCBpbGx1c3RyYXRp
b24uIFRoaXMgcGF0Y2ggY29tYmluZXMgdHdvCmh1bmtzIGJhY2twb3J0ZWQgZnJvbSB1cHN0cmVh
bSBjb21taXRzIGJ5IEVtaWx5IERlbmcKKG1tYXBfd3JpdGVfZG93bmdyYWRlIGluIHN2bV9yYW5n
ZV9yZXN0b3JlX3dvcmssIEZlYiAyMDI1KSBhbmQgUGhpbGlwCiBZYW5nICghdm1hIC0+IHVubWFw
IHN0YWxlIEdQVSBtYXBwaW5nIGluc3RlYWQgb2YgLUVGQVVMVCByZXRyeSwKT2N0IDIwMjUpLCB3
aGljaCBhcmUgbWlzc2luZyBmcm9tIHRoZSB0ZXN0ZWQga2VybmVscyBhbmQgc2hvdWxkCnByb2Jh
Ymx5IGJlIHBpY2tlZCB1cCBmb3Igc3RhYmxlLCBwbHVzIGEgbmV3IGNvbnZlcmdlbmNlIGNoYW5n
ZToKCnN2bV9yYW5nZV9yZXN0b3JlX3dvcmsgYWJvcnRlZCB0aGUgZW50aXJlIHBhc3Mgb24gdGhl
IGZpcnN0IHJhbmdlIHRoYXQKd2FzIHJlLWRpcnRpZWQgbWlkLXJlc3RvcmUuIFVuZGVyIHJlY2xh
aW0gcHJlc3N1cmUgdGhhdCBtYWtlcyB0aGUKcGVyLXJhbmdlIGludmFsaWRhdGlvbiBhIGdsb2Jh
bCBhYm9ydDogdGhlIHBhc3MgcmVzdGFydHMgZm9yZXZlciBhbmQKZXZpY3RlZF9yYW5nZXMgbmV2
ZXIgZHJhaW5zLCBzbyBLRkQgcXVldWVzIHN0YXkgcXVpZXNjZWQuIFJlc3RvcmUgZWFjaApkaXJ0
eSByYW5nZSBpbmRlcGVuZGVudGx5LCByZW1lbWJlciB0aGF0IGEgcmV0cnkgaXMgbmVlZGVkLCBh
bmQgb25seQpyZXNjaGVkdWxlIG9uY2UgYXQgdGhlIGVuZC4KCldpdGhvdXQgdGhpcywgYnVyc3R5
IGludmFsaWRhdGlvbiB3ZWRnZXMgbGxhbWEtc2VydmVyLXN0eWxlIEtGRApwcm9jZXNzZXMgcGVy
bWFuZW50bHkgKG9ic2VydmVkOiB0ZW5zIG9mIHRob3VzYW5kcyBvZiBpbnZhbGlkYXRpb25zLApu
byByZWNvdmVyeSkuIFdpdGggaXQsIHRocmVlIHJlc3RhcnQgcm91bmRzIHVuZGVyIGxpdmUgc3dh
cm0gY2h1cm4KY29udmVyZ2VkICg2NjgvODk4LzIxNDYgaW52YWxpZGF0aW9ucywgaGVhbHRoeSBp
biB+Mi0zIG1pbikuCgpTaWduZWQtb2ZmLWJ5OiBrYWxvdSA8cmVzZWFyY2hAYmVsZWdhbmp1ci5r
YWxvdS5uZXQ+Ci0tLQoKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYwpAQCAtMTc3Myw0OCAr
MTc2Miw0OCBAQAogCQlib29sIHJlYWRvbmx5OwoKIAkJdm1hID0gdm1hX2xvb2t1cChtbSwgYWRk
cik7Ci0JCWlmICh2bWEpIHsKLQkJCXJlYWRvbmx5ID0gISh2bWEtPnZtX2ZsYWdzICYgVk1fV1JJ
VEUpOworCQluZXh0ID0gdm1hID8gbWluKHZtYS0+dm1fZW5kLCBlbmQpIDogZW5kOworCQlucGFn
ZXMgPSAobmV4dCAtIGFkZHIpID4+IFBBR0VfU0hJRlQ7CgotCQkJbmV4dCA9IG1pbih2bWEtPnZt
X2VuZCwgZW5kKTsKLQkJCW5wYWdlcyA9IChuZXh0IC0gYWRkcikgPj4gUEFHRV9TSElGVDsKKwkJ
aWYgKCF2bWEgfHwgISh2bWEtPnZtX2ZsYWdzICYgVk1fUkVBRCkpIHsKIAkJCS8qIEhNTSByZXF1
aXJlcyBhdCBsZWFzdCBSRUFEIHBlcm1pc3Npb25zLiBJZiBwcm92aWRlZCB3aXRoIFBST1RfTk9O
RSwKIAkJCSAqIHVubWFwIHRoZSBtZW1vcnkuIElmIGl0J3Mgbm90IGFscmVhZHkgbWFwcGVkLCB0
aGlzIGlzIGEgbm8tb3AKIAkJCSAqIElmIFBST1RfV1JJVEUgaXMgcHJvdmlkZWQgd2l0aG91dCBS
RUFELCB3YXJuIGZpcnN0IHRoZW4gdW5tYXAKKwkJCSAqIElmIHZtYSBpcyBub3QgZm91bmQsIGFk
ZHIgaXMgaW52YWxpZCwgdW5tYXAgZnJvbSBHUFVzCiAJCQkgKi8KLQkJCWlmICghKHZtYS0+dm1f
ZmxhZ3MgJiBWTV9SRUFEKSkgewotCQkJCXVuc2lnbmVkIGxvbmcgZSwgczsKLQotCQkJCXN2bV9y
YW5nZV9sb2NrKHByYW5nZSk7Ci0JCQkJaWYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURSkKLQkJ
CQkJcHJfZGVidWcoIlZNX1dSSVRFIHdpdGhvdXQgVk1fUkVBRCBpcyBub3Qgc3VwcG9ydGVkIik7
Ci0JCQkJcyA9IG1heChzdGFydCwgcHJhbmdlLT5zdGFydCk7Ci0JCQkJZSA9IG1pbihlbmQsIHBy
YW5nZS0+bGFzdCk7Ci0JCQkJaWYgKGUgPj0gcykKLQkJCQkJciA9IHN2bV9yYW5nZV91bm1hcF9m
cm9tX2dwdXMocHJhbmdlLCBzLCBlLAotCQkJCQkJICAgICAgIEtGRF9TVk1fVU5NQVBfVFJJR0dF
Ul9VTk1BUF9GUk9NX0NQVSk7Ci0JCQkJc3ZtX3JhbmdlX3VubG9jayhwcmFuZ2UpOwotCQkJCS8q
IElmIHVubWFwIHJldHVybnMgbm9uLXplcm8sIHdlJ2xsIGJhaWwgb24gdGhlIG5leHQgZm9yIGxv
b3AKLQkJCQkgKiBpdGVyYXRpb24sIHNvIGp1c3QgbGVhdmUgciBhbmQgY29udGludWUKLQkJCQkg
Ki8KLQkJCQlhZGRyID0gbmV4dDsKLQkJCQljb250aW51ZTsKLQkJCX0KKwkJCXVuc2lnbmVkIGxv
bmcgZSwgczsKCi0JCQlXUklURV9PTkNFKHAtPnN2bXMuZmF1bHRpbmdfdGFzaywgY3VycmVudCk7
Ci0JCQlyYW5nZSA9IGFtZGdwdV9obW1fcmFuZ2VfYWxsb2MoTlVMTCk7Ci0JCQlpZiAobGlrZWx5
KHJhbmdlKSkKLQkJCQlyID0gYW1kZ3B1X2htbV9yYW5nZV9nZXRfcGFnZXMoJnByYW5nZS0+bm90
aWZpZXIsIGFkZHIsIG5wYWdlcywKLQkJCQkJCQkgICAgICAgcmVhZG9ubHksIG93bmVyLCByYW5n
ZSk7Ci0JCQllbHNlCi0JCQkJciA9IC1FTk9NRU07Ci0JCQlXUklURV9PTkNFKHAtPnN2bXMuZmF1
bHRpbmdfdGFzaywgTlVMTCk7Ci0JCQlpZiAocikKLQkJCQlwcl9kZWJ1ZygiZmFpbGVkICVkIHRv
IGdldCBzdm0gcmFuZ2UgcGFnZXNcbiIsIHIpOwotCQl9IGVsc2UgewotCQkJciA9IC1FRkFVTFQ7
CisJCQlzdm1fcmFuZ2VfbG9jayhwcmFuZ2UpOworCQkJaWYgKCF2bWEpCisJCQkJcHJfZGVidWco
InZtYSBub3QgZm91bmRcbiIpOworCQkJZWxzZSBpZiAodm1hLT52bV9mbGFncyAmIFZNX1dSSVRF
KQorCQkJCXByX2RlYnVnKCJWTV9XUklURSB3aXRob3V0IFZNX1JFQUQgaXMgbm90IHN1cHBvcnRl
ZCIpOworCisJCQlzID0gbWF4KGFkZHIgPj4gUEFHRV9TSElGVCwgcHJhbmdlLT5zdGFydCk7CisJ
CQllID0gbWluKChuZXh0IC0gMSkgPj4gUEFHRV9TSElGVCwgcHJhbmdlLT5sYXN0KTsKKwkJCWlm
IChlID49IHMpCisJCQkJciA9IHN2bV9yYW5nZV91bm1hcF9mcm9tX2dwdXMocHJhbmdlLCBzLCBl
LAorCQkJCQkgICAgICAgS0ZEX1NWTV9VTk1BUF9UUklHR0VSX1VOTUFQX0ZST01fQ1BVKTsKKwkJ
CXN2bV9yYW5nZV91bmxvY2socHJhbmdlKTsKKwkJCS8qIElmIHVubWFwIHJldHVybnMgbm9uLXpl
cm8sIHdlJ2xsIGJhaWwgb24gdGhlIG5leHQgZm9yIGxvb3AKKwkJCSAqIGl0ZXJhdGlvbiwgc28g
anVzdCBsZWF2ZSByIGFuZCBjb250aW51ZQorCQkJICovCisJCQlhZGRyID0gbmV4dDsKKwkJCWNv
bnRpbnVlOwogCQl9CgorCQlyZWFkb25seSA9ICEodm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKTsK
KwkJV1JJVEVfT05DRShwLT5zdm1zLmZhdWx0aW5nX3Rhc2ssIGN1cnJlbnQpOworCQlyYW5nZSA9
IGFtZGdwdV9obW1fcmFuZ2VfYWxsb2MoTlVMTCk7CisJCWlmIChsaWtlbHkocmFuZ2UpKQorCQkJ
ciA9IGFtZGdwdV9obW1fcmFuZ2VfZ2V0X3BhZ2VzKCZwcmFuZ2UtPm5vdGlmaWVyLCBhZGRyLCBu
cGFnZXMsCisJCQkJCQkgICAgICAgcmVhZG9ubHksIG93bmVyLCByYW5nZSk7CisJCWVsc2UKKwkJ
CXIgPSAtRU5PTUVNOworCQlXUklURV9PTkNFKHAtPnN2bXMuZmF1bHRpbmdfdGFzaywgTlVMTCk7
CisJCWlmIChyKQorCQkJcHJfZGVidWcoImZhaWxlZCAlZCB0byBnZXQgc3ZtIHJhbmdlIHBhZ2Vz
XG4iLCByKTsKKwogCQlpZiAoIXIpIHsKIAkJCW9mZnNldCA9IChhZGRyID4+IFBBR0VfU0hJRlQp
IC0gcHJhbmdlLT5zdGFydDsKIAkJCXIgPSBzdm1fcmFuZ2VfZG1hX21hcChwcmFuZ2UsIGN0eC0+
Yml0bWFwLCBvZmZzZXQsIG5wYWdlcywKQEAgLTE5MDMsNiArMTg5Miw3IEBACiAJc3RydWN0IHN2
bV9yYW5nZSAqcHJhbmdlOwogCXN0cnVjdCBrZmRfcHJvY2VzcyAqcDsKIAlzdHJ1Y3QgbW1fc3Ry
dWN0ICptbTsKKwlib29sIHJldHJ5ID0gZmFsc2U7CiAJaW50IGV2aWN0ZWRfcmFuZ2VzOwogCWlu
dCBpbnZhbGlkOwogCWludCByOwpAQCAtMTkyNyw2ICsxOTE3LDcgQEAKIAltdXRleF9sb2NrKCZw
cm9jZXNzX2luZm8tPmxvY2spOwogCXN2bV9yYW5nZV9saXN0X2xvY2tfYW5kX2ZsdXNoX3dvcmso
c3ZtcywgbW0pOwogCW11dGV4X2xvY2soJnN2bXMtPmxvY2spOworCW1tYXBfd3JpdGVfZG93bmdy
YWRlKG1tKTsKCiAJZXZpY3RlZF9yYW5nZXMgPSBhdG9taWNfcmVhZCgmc3Ztcy0+ZXZpY3RlZF9y
YW5nZXMpOwoKQEAgLTE5NTEsMzIgKzE5NDIsNDIgQEAKIAkJCQkgcHJhbmdlLT5zdGFydCk7Cgog
CQltdXRleF91bmxvY2soJnByYW5nZS0+bWlncmF0ZV9tdXRleCk7Ci0JCWlmIChyKQotCQkJZ290
byBvdXRfcmVzY2hlZHVsZTsKKwkJaWYgKHIpIHsKKwkJCXJldHJ5ID0gdHJ1ZTsKKwkJCWNvbnRp
bnVlOworCQl9CgorCQkvKgorCQkgKiBJZiB0aGUgcmFuZ2Ugd2FzIGludmFsaWRhdGVkIGFnYWlu
IHdoaWxlIHdlIHJlc3RvcmVkIGl0LCBpdAorCQkgKiBzdGF5cyBkaXJ0eSBhbmQgaXMgcmV0cmll
ZCBvbiB0aGUgbmV4dCBwYXNzOyBrZWVwIHJlc3RvcmluZworCQkgKiB0aGUgb3RoZXIgcmFuZ2Vz
IGluc3RlYWQgb2YgYWJvcnRpbmcgdGhlIHdob2xlIHBhc3Mgc28gZWFjaAorCQkgKiBwYXNzIG1h
a2VzIGZvcndhcmQgcHJvZ3Jlc3MgdW5kZXIgc3VzdGFpbmVkIGludmFsaWRhdGlvbi4KKwkJICov
CiAJCWlmIChhdG9taWNfY21weGNoZygmcHJhbmdlLT5pbnZhbGlkLCBpbnZhbGlkLCAwKSAhPSBp
bnZhbGlkKQotCQkJZ290byBvdXRfcmVzY2hlZHVsZTsKKwkJCXJldHJ5ID0gdHJ1ZTsKIAl9Cgog
CWlmIChhdG9taWNfY21weGNoZygmc3Ztcy0+ZXZpY3RlZF9yYW5nZXMsIGV2aWN0ZWRfcmFuZ2Vz
LCAwKSAhPQogCSAgICBldmljdGVkX3JhbmdlcykKLQkJZ290byBvdXRfcmVzY2hlZHVsZTsKKwkJ
cmV0cnkgPSB0cnVlOwoKLQlldmljdGVkX3JhbmdlcyA9IDA7CisJaWYgKCFyZXRyeSkgeworCQll
dmljdGVkX3JhbmdlcyA9IDA7CgotCXIgPSBrZ2Qya2ZkX3Jlc3VtZV9tbShtbSk7Ci0JaWYgKHIp
IHsKLQkJLyogTm8gcmVjb3ZlcnkgZnJvbSB0aGlzIGZhaWx1cmUuIFByb2JhYmx5IHRoZSBDUCBp
cwotCQkgKiBoYW5naW5nLiBObyBwb2ludCB0cnlpbmcgYWdhaW4uCi0JCSAqLwotCQlwcl9kZWJ1
ZygiZmFpbGVkICVkIHRvIHJlc3VtZSBLRkRcbiIsIHIpOwotCX0KKwkJciA9IGtnZDJrZmRfcmVz
dW1lX21tKG1tKTsKKwkJaWYgKHIpIHsKKwkJCS8qIE5vIHJlY292ZXJ5IGZyb20gdGhpcyBmYWls
dXJlLiBQcm9iYWJseSB0aGUgQ1AgaXMKKwkJCSAqIGhhbmdpbmcuIE5vIHBvaW50IHRyeWluZyBh
Z2Fpbi4KKwkJCSAqLworCQkJcHJfZGVidWcoImZhaWxlZCAlZCB0byByZXN1bWUgS0ZEXG4iLCBy
KTsKKwkJfQoKLQlwcl9kZWJ1ZygicmVzdG9yZSBzdm0gcmFuZ2VzIHN1Y2Nlc3NmdWxseVxuIik7
CisJCXByX2RlYnVnKCJyZXN0b3JlIHN2bSByYW5nZXMgc3VjY2Vzc2Z1bGx5XG4iKTsKKwl9Cgog
b3V0X3Jlc2NoZWR1bGU6CiAJbXV0ZXhfdW5sb2NrKCZzdm1zLT5sb2NrKTsKLQltbWFwX3dyaXRl
X3VubG9jayhtbSk7CisJbW1hcF9yZWFkX3VubG9jayhtbSk7CiAJbXV0ZXhfdW5sb2NrKCZwcm9j
ZXNzX2luZm8tPmxvY2spOwoKIAkvKiBJZiB2YWxpZGF0aW9uIGZhaWxlZCwgcmVzY2hlZHVsZSBh
bm90aGVyIGF0dGVtcHQgKi8KQEAgLTM2MjUsMzkgKzM2MjYsMzcgQEAKIAlyZXR1cm4gMDsKIH0K
Ci1pbnQgc3ZtX3JhbmdlX3NjaGVkdWxlX2V2aWN0X3N2bV9ibyhzdHJ1Y3QgYW1kZ3B1X2FtZGtm
ZF9mZW5jZSAqZmVuY2UpCi17Ci0JLyogRGVyZWZlcmVuY2luZyBmZW5jZS0+c3ZtX2JvIGlzIHNh
ZmUgaGVyZSBiZWNhdXNlIHRoZSBmZW5jZSBoYXNuJ3QKLQkgKiBzaWduYWxlZCB5ZXQgYW5kIHdl
J3JlIHVuZGVyIHRoZSBwcm90ZWN0aW9uIG9mIHRoZSBmZW5jZS0+bG9jay4KLQkgKiBBZnRlciB0
aGUgZmVuY2UgaXMgc2lnbmFsZWQgaW4gc3ZtX3JhbmdlX2JvX3JlbGVhc2UsIHdlIGNhbm5vdCBn
ZXQKLQkgKiBoZXJlIGFueSBtb3JlLgotCSAqCi0JICogUmVmZXJlbmNlIGlzIGRyb3BwZWQgaW4g
c3ZtX3JhbmdlX2V2aWN0X3N2bV9ib193b3JrZXIuCi0JICovCi0JaWYgKHN2bV9ib19yZWZfdW5s
ZXNzX3plcm8oZmVuY2UtPnN2bV9ibykpIHsKLQkJV1JJVEVfT05DRShmZW5jZS0+c3ZtX2JvLT5l
dmljdGluZywgMSk7Ci0JCXNjaGVkdWxlX3dvcmsoJmZlbmNlLT5zdm1fYm8tPmV2aWN0aW9uX3dv
cmspOwotCX0KLQotCXJldHVybiAwOwotfQotCi1zdGF0aWMgdm9pZCBzdm1fcmFuZ2VfZXZpY3Rf
c3ZtX2JvX3dvcmtlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCitpbnQgc3ZtX3JhbmdlX2V2
aWN0X3N2bV9ibyhzdHJ1Y3QgYW1kZ3B1X2JvICpibykKIHsKLQlzdHJ1Y3Qgc3ZtX3JhbmdlX2Jv
ICpzdm1fYm87CisJc3RydWN0IHN2bV9yYW5nZV9ibyAqc3ZtX2JvID0gdG9fc3ZtX3JhbmdlX2Jv
KGJvKTsKIAlzdHJ1Y3QgbW1fc3RydWN0ICptbTsKIAlpbnQgciA9IDA7CgotCXN2bV9ibyA9IGNv
bnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3Qgc3ZtX3JhbmdlX2JvLCBldmljdGlvbl93b3JrKTsKKwlp
ZiAoIXN2bV9ib19yZWZfdW5sZXNzX3plcm8oc3ZtX2JvKSkKKwkJcmV0dXJuIDA7CgotCWlmICht
bWdldF9ub3RfemVybyhzdm1fYm8tPmV2aWN0aW9uX2ZlbmNlLT5tbSkpIHsKLQkJbW0gPSBzdm1f
Ym8tPmV2aWN0aW9uX2ZlbmNlLT5tbTsKLQl9IGVsc2UgeworCWlmICghbW1nZXRfbm90X3plcm8o
c3ZtX2JvLT5tbSkpIHsKIAkJc3ZtX3JhbmdlX2JvX3VucmVmKHN2bV9ibyk7Ci0JCXJldHVybjsK
KwkJcmV0dXJuIDA7CiAJfQorCW1tID0gc3ZtX2JvLT5tbTsKKworCS8qCisJICogQ2FsbGVkIHdp
dGggdGhlIEJPIHJlc2VydmVkOyBsb2NrIG9yZGVyIGlzIG1tYXBfbG9jayAtPiBCTworCSAqIHJl
c2VydmF0aW9uLiBPbmx5IHRyeWxvY2sgbW1hcCB0byBpbnZlcnQgdGhhdCBvcmRlciBzYWZlbHk6
IGEKKwkgKiB0cnlsb2NrIG5ldmVyIGJsb2Nrcywgc28gaXQgY2Fubm90IGRlYWRsb2NrIGFnYWlu
c3QgdGhlIHJlc2VydmF0aW9uCisJICogYW5kIGxvY2tkZXAgcmVjb3JkcyBubyByZXZlcnNlIGRl
cGVuZGVuY3kuIE9uIGNvbnRlbnRpb24gcmV0dXJuCisJICogLUVCVVNZIHNvIFRUTSBza2lwcyB0
aGlzIEJPLgorCSAqLworCWlmICghbW1hcF9yZWFkX3RyeWxvY2sobW0pKSB7CisJCXByX2RlYnVn
KCJza2lwIGV2aWN0aW9uLCBjb250ZW5kZWQgdG8gdGFrZSBtbWFwX3JlYWQgbG9ja1xuIik7CisJ
CW1tcHV0X2FzeW5jKG1tKTsKKwkJc3ZtX3JhbmdlX2JvX3VucmVmKHN2bV9ibyk7CisJCXJldHVy
biAtRUJVU1k7CisJfQorCisJV1JJVEVfT05DRShzdm1fYm8tPmV2aWN0aW5nLCAxKTsKCi0JbW1h
cF9yZWFkX2xvY2sobW0pOwogCXNwaW5fbG9jaygmc3ZtX2JvLT5saXN0X2xvY2spOwogCXdoaWxl
ICghbGlzdF9lbXB0eSgmc3ZtX2JvLT5yYW5nZV9saXN0KSAmJiAhcikgewogCQlzdHJ1Y3Qgc3Zt
X3JhbmdlICpwcmFuZ2UgPQpAQCAtMzY2NSwxMyArMzY2NCwyNCBAQAogCQkJCQkJc3RydWN0IHN2
bV9yYW5nZSwgc3ZtX2JvX2xpc3QpOwogCQlpbnQgcmV0cmllcyA9IDM7CgorCQkvKgorCQkgKiBU
cnlsb2NrIG1pZ3JhdGVfbXV0ZXggdW5kZXIgbGlzdF9sb2NrLCBiZWZvcmUgdW5saW5raW5nIHRo
ZQorCQkgKiByYW5nZSwgc28gc3ZtX3JhbmdlX2ZyZWUoKSBjYW5ub3QgZnJlZSBpdCB1bmRlciB1
cy4gT24KKwkJICogY29udGVudGlvbiB0aGUgb3duZXIgaXMgbWlncmF0aW5nIHRoaXMgcmFuZ2U7
IHNraXAgdGhlIEJPLgorCQkgKi8KKwkJaWYgKCFtdXRleF90cnlsb2NrKCZwcmFuZ2UtPm1pZ3Jh
dGVfbXV0ZXgpKSB7CisJCQlwcl9kZWJ1Zygic2tpcCBldmljdGlvbiwgY29udGVuZGVkIG1pZ3Jh
dGVfbXV0ZXhcbiIpOworCQkJLyogQ2xlYXIgZXZpY3Rpbmcgc28gdGhlIEJPIGtlZXBzIGJlaW5n
IHJldXNlZC4gKi8KKwkJCVdSSVRFX09OQ0Uoc3ZtX2JvLT5ldmljdGluZywgMCk7CisJCQlyID0g
LUVCVVNZOworCQkJYnJlYWs7CisJCX0KIAkJbGlzdF9kZWxfaW5pdCgmcHJhbmdlLT5zdm1fYm9f
bGlzdCk7CiAJCXNwaW5fdW5sb2NrKCZzdm1fYm8tPmxpc3RfbG9jayk7CgogCQlwcl9kZWJ1Zygi
c3ZtcyAweCVwIFsweCVseCAweCVseF1cbiIsIHByYW5nZS0+c3ZtcywKIAkJCSBwcmFuZ2UtPnN0
YXJ0LCBwcmFuZ2UtPmxhc3QpOwoKLQkJbXV0ZXhfbG9jaygmcHJhbmdlLT5taWdyYXRlX211dGV4
KTsKIAkJZG8gewogCQkJLyogbWlncmF0ZSBhbGwgdnJhbSBwYWdlcyBpbiB0aGlzIHByYW5nZSB0
byBzeXMgcmFtCiAJCQkgKiBhZnRlciB0aGF0IHByYW5nZS0+YWN0dWFsX2xvYyBzaG91bGQgYmUg
emVybwpAQCAtMzY5NSwxNSArMzcwNSwxNiBAQAogCX0KIAlzcGluX3VubG9jaygmc3ZtX2JvLT5s
aXN0X2xvY2spOwogCW1tYXBfcmVhZF91bmxvY2sobW0pOwotCW1tcHV0KG1tKTsKLQotCWRtYV9m
ZW5jZV9zaWduYWwoJnN2bV9iby0+ZXZpY3Rpb25fZmVuY2UtPmJhc2UpOworCS8qIERlZmVyIG1t
cHV0OiBleGl0X21tYXAoKSBtdXN0IG5vdCBydW4gdW5kZXIgdGhlIEJPIHJlc2VydmF0aW9uLiAq
LworCW1tcHV0X2FzeW5jKG1tKTsKCiAJLyogVGhpcyBpcyB0aGUgbGFzdCByZWZlcmVuY2UgdG8g
c3ZtX2JvLCBhZnRlciBzdm1fcmFuZ2VfdnJhbV9ub2RlX2ZyZWUKIAkgKiBoYXMgYmVlbiBjYWxs
ZWQgaW4gc3ZtX21pZ3JhdGVfdnJhbV90b19yYW0KIAkgKi8KIAlXQVJOX09OQ0UoIXIgJiYga3Jl
Zl9yZWFkKCZzdm1fYm8tPmtyZWYpICE9IDEsICJUaGlzIHdhcyBub3QgdGhlIGxhc3QgcmVmZXJl
bmNlXG4iKTsKIAlzdm1fcmFuZ2VfYm9fdW5yZWYoc3ZtX2JvKTsKKworCXJldHVybiByOwogfQoK
IHN0YXRpYyBpbnQK
--000000000000c77e31065c89dba4
Content-Type: application/octet-stream; 
	name="0002-amdkfd-nonxnack-lock.patch"
Content-Disposition: attachment; filename="0002-amdkfd-nonxnack-lock.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mul753472>
X-Attachment-Id: f_mul753472

RnJvbToga2Fsb3UgPHJlc2VhcmNoQGJlbGVnYW5qdXIua2Fsb3UubmV0PgpTdWJqZWN0OiBbUEFU
Q0ggMi8yXSBkcm0vYW1ka2ZkOiBwaW4gU1ZNLXJlZ2lzdGVyZWQgVk1BcyBvbiBub24teG5hY2sg
ZGV2aWNlcwoKT24gbm9uLXhuYWNrIGhhcmR3YXJlIHRoZSBHUFUgY2Fubm90IGZhdWx0IENQVSBw
YWdlcyBiYWNrIGluLCBzbyBldmVyeQpyZXNpZGVudCBwYWdlIGluc2lkZSBhIHJlZ2lzdGVyZWQg
U1ZNIGludGVydmFsIG11c3Qgc3RheSByZXNpZGVudCBmb3IKdGhlIGxpZmV0aW1lIG9mIHRoZSBp
bnRlcnZhbC4gUmVjbGFpbWluZyBvbmUgaXMgZnV0aWxlOiB0aGUgbW11Cm5vdGlmaWVyIGV2aWN0
cyB0aGUgS0ZEIHF1ZXVlcyBhbmQgc3ZtX3JhbmdlX3Jlc3RvcmVfd29yayBmYXVsdHMgdGhlCnBh
Z2Ugc3RyYWlnaHQgYmFjayBpbiwgYW5kIHVuZGVyIHN1c3RhaW5lZCByZWNsYWltIHRoYXQKZXZp
Y3QvcmVzdG9yZS9yZWZhdWx0IGN5Y2xlIHJlcGVhdHMgaW5kZWZpbml0ZWx5IOKAlCBhIG1lYXN1
cmVkIGxpdmVsb2NrCm9mIDE1NmsrIGludmFsaWRhdGlvbnMgd2l0aCB0aGUgcHJvY2VzcyBuZXZl
ciByZWNvdmVyaW5nLgoKIHN2bV9yYW5nZV9hZGRfbm90aWZpZXJfbG9ja2VkKCkgaXMgdGhlIHNp
bmdsZSBmdW5uZWwgdGhhdCBpbnNlcnRzIGV2ZXJ5CnJlZ2lzdGVyZWQgaW50ZXJ2YWwsIHdpdGgg
bW1hcF93cml0ZV9sb2NrIGFscmVhZHkgaGVsZCBmb3IKbW11X2ludGVydmFsX25vdGlmaWVyX2lu
c2VydF9sb2NrZWQoKS4gV2hlbiB0aGUgcHJvY2VzcyBoYXMgbm8geG5hY2sKc3VwcG9ydCwgbWFy
ayB0aGUgY292ZXJpbmcgVk1BcyBWTV9MT0NLRUQgYW5kIHByZWZhdWx0IHRoZSByYW5nZSB3aXRo
CmdldF91c2VyX3BhZ2VzX3JlbW90ZSgpIHNvIGl0cyBwYWdlcyBsYW5kIG9uIHRoZSB1bmV2aWN0
YWJsZSBMUlUgdmlhCnRoZSBub3JtYWwgZmF1bHQgcGF0aC4gVGhpcyBhcHBsaWVzIHRoZSBzYW1l
IGd1YXJhbnRlZSB1c2Vyc3BhY2UKbWxvY2soKSBnaXZlcyAoVk1fTE9DS0VEICsgcHJlZmF1bHQp
IHRvIGV4YWN0bHkgdGhlIHBhZ2VzIHRoZSBHUFUgY2FuCnRvdWNoLCBhbmQgbWFrZXMgdGhlIGlu
dmFsaWRhdGlvbiBzdG9ybSB1bmFibGUgdG8gc3RhcnQuCgpNZWFzdXJlZCBvbiBnZng5MDYgd2l0
aCBhIH4xOUcgU1ZNLXJlZ2lzdGVyZWQgbWFwcGluZyB1bmRlciBzdXN0YWluZWQKc3dhcm0gY2h1
cm46IDQgaW52YWxpZGF0aW9ucyBvbiBjb2xkIGxvYWQgYW5kIGJvdW5kZWQgcmVzaWR1YWxzCig8
MWsvY3ljbGUpIG9uIHJlc3RhcnQgdnMgYW4gdW5ib3VuZGVkIHN0b3JtIGJlZm9yZTsgYXBwbGlj
YXRpb24KY29udmVyZ2VzIHRvIGhlYWx0aHkgZXZlcnkgdGltZS4KClNpZ25lZC1vZmYtYnk6IGth
bG91IDxyZXNlYXJjaEBiZWxlZ2FuanVyLmthbG91Lm5ldD4KLS0tCgotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3N2bS5jCkBAIC0xMDYsMTIgKzEwNSw2NCBAQAogCQlpbnRlcnZhbF90cmVlX3JlbW92
ZSgmcHJhbmdlLT5pdF9ub2RlLCAmcHJhbmdlLT5zdm1zLT5vYmplY3RzKTsKIH0KIAorLyoKKyAq
IE9uIG5vbi14bmFjayBoYXJkd2FyZSB0aGUgR1BVIGNhbm5vdCBmYXVsdCBDUFUgcGFnZXMgYmFj
ayBpbiwgc28gZXZlcnkKKyAqIHJlc2lkZW50IHBhZ2UgaW5zaWRlIGEgcmVnaXN0ZXJlZCBTVk0g
cmFuZ2UgbXVzdCBzdGF5IHJlc2lkZW50IHdoaWxlIHRoZQorICogcmFuZ2UgaXMgcmVnaXN0ZXJl
ZC4gSWYgcmVjbGFpbSBvciBtaWdyYXRpb24gdW5tYXBzIG9uZSwgdGhlIG1tdSBub3RpZmllcgor
ICogZXZpY3RzIHRoZSBLRkQgcXVldWVzIGFuZCByZXN0b3JlX3dvcmsgaW1tZWRpYXRlbHkgZmF1
bHRzIHRoZSBwYWdlIGJhY2sKKyAqIGluOyB1bmRlciBtZW1vcnkgcHJlc3N1cmUgdGhhdCBldmlj
dC9yZXN0b3JlIGN5Y2xlIHJlcGVhdHMgaW5kZWZpbml0ZWx5CisgKiBhbmQgbGl2ZWxvY2tzIHRo
ZSBhcHBsaWNhdGlvbi4KKyAqCisgKiBNYXJrIHRoZSBjb3ZlcmluZyBWTUFzIFZNX0xPQ0tFRCwg
dGhlbiBmYXVsdCB0aGUgcmFuZ2UgaW46IHBhZ2VzIGZhdWx0ZWQKKyAqIGludG8gYSBWTV9MT0NL
RUQgdm1hIGFyZSBwbGFjZWQgb24gdGhlIHVuZXZpY3RhYmxlIExSVSBieSB0aGUgbm9ybWFsCisg
KiBmYXVsdCBwYXRoLCBybWFwIHdhbGtzIChyZWNsYWltLCBtaWdyYXRpb24sIHN3YXApIHJlZnVz
ZSB0byB1bm1hcCB0aGVtLAorICogYW5kIHRoZSBpbnZhbGlkYXRpb24gc3Rvcm0gY2Fubm90IHN0
YXJ0LiBUaGlzIGlzIHdoYXQgdXNlcnNwYWNlIG1sb2NrKCkKKyAqIGRvZXMsIGFwcGxpZWQgdG8g
dGhlIHJlZ2lzdGVyZWQgcmFuZ2UuCisgKi8KK3N0YXRpYyB2b2lkCitzdm1fcmFuZ2VfbG9ja192
bWFzKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nIHN0YXJ0LAorCQkgICAgdW5z
aWduZWQgbG9uZyBsYXN0KQoreworCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hOworCXN0cnVj
dCBwYWdlICpwYWdlc1s2NF07CisJdW5zaWduZWQgbG9uZyBhZGRyLCBubG9ja2VkID0gMDsKKwor
CVZNQV9JVEVSQVRPUih2bWksIG1tLCBzdGFydCk7CisJZm9yX2VhY2hfdm1hX3JhbmdlKHZtaSwg
dm1hLCBsYXN0ICsgMSkgeworCQl2bWFfc3RhcnRfd3JpdGUodm1hKTsKKwkJdm1fZmxhZ3Nfc2V0
KHZtYSwgVk1fTE9DS0VEKTsKKwkJbmxvY2tlZCsrOworCX0KKwlwcl9kZWJ1ZygibG9ja2VkICVs
dSB2bWFzIG92ZXIgWzB4JWx4IDB4JWx4XVxuIiwgbmxvY2tlZCwgc3RhcnQsIGxhc3QpOworCisJ
Zm9yIChhZGRyID0gc3RhcnQ7IGFkZHIgPD0gbGFzdDsgYWRkciArPSBQQUdFX1NJWkUpIHsKKwkJ
bG9uZyBuciA9IG1pbl90KHVuc2lnbmVkIGxvbmcsIEFSUkFZX1NJWkUocGFnZXMpLAorCQkJCShs
YXN0IC0gYWRkciArIDEpIC8gUEFHRV9TSVpFICsgMSk7CisJCWxvbmcgcmV0LCBpOworCisJCXJl
dCA9IGdldF91c2VyX3BhZ2VzX3JlbW90ZShtbSwgYWRkciwgbnIsIDAsIHBhZ2VzLCBOVUxMKTsK
KwkJaWYgKHJldCA8PSAwKQorCQkJY29udGludWU7CisJCWZvciAoaSA9IDA7IGkgPCByZXQ7IGkr
KykKKwkJCXB1dF9wYWdlKHBhZ2VzW2ldKTsKKwkJYWRkciArPSAocmV0IC0gMSkgKiBQQUdFX1NJ
WkU7CisJfQorfQorCiBzdGF0aWMgdm9pZAogc3ZtX3JhbmdlX2FkZF9ub3RpZmllcl9sb2NrZWQo
c3RydWN0IG1tX3N0cnVjdCAqbW0sIHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSkKIHsKKwlzdHJ1
Y3Qga2ZkX3Byb2Nlc3MgKnAgPSBjb250YWluZXJfb2YocHJhbmdlLT5zdm1zLCBzdHJ1Y3Qga2Zk
X3Byb2Nlc3MsCisJCQkJCSAgICAgc3Ztcyk7CisKIAlwcl9kZWJ1Zygic3ZtcyAweCVwIHByYW5n
ZSAweCVwIFsweCVseCAweCVseF1cbiIsIHByYW5nZS0+c3ZtcywKIAkJIHByYW5nZSwgcHJhbmdl
LT5zdGFydCwgcHJhbmdlLT5sYXN0KTsKIAorCWlmICghcC0+eG5hY2tfZW5hYmxlZCkKKwkJc3Zt
X3JhbmdlX2xvY2tfdm1hcyhtbSwgcHJhbmdlLT5zdGFydCA8PCBQQUdFX1NISUZULAorCQkJCSAg
ICAocHJhbmdlLT5sYXN0IDw8IFBBR0VfU0hJRlQpIHwKKwkJCQkgICAgKFBBR0VfU0laRSAtIDEp
KTsKKwogCW1tdV9pbnRlcnZhbF9ub3RpZmllcl9pbnNlcnRfbG9ja2VkKCZwcmFuZ2UtPm5vdGlm
aWVyLCBtbSwKIAkJCQkgICAgIHByYW5nZS0+c3RhcnQgPDwgUEFHRV9TSElGVCwKIAkJCQkgICAg
IHByYW5nZS0+bnBhZ2VzIDw8IFBBR0VfU0hJRlQsCg==
--000000000000c77e31065c89dba4--
