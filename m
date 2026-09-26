Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBCBC9832F
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Sep 2026 17:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8499610E070;
	Sat, 26 Sep 2026 17:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LM0iI/6o";
	dkim-atps=neutral
Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com
 [74.125.228.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7266410E070
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 17:54:29 +0000 (UTC)
Received: by mail-ed2-f34.google.com with SMTP id
 4fb4d7f45d1cf-6aaf5e6878fso1895546a12.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 10:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790445268; cv=none;
 d=google.com; s=arc-20260327;
 b=DU1eJzYOTdKAkd13fjCcmRGKupNQF/SSMEfcKBd3RcyEUwj2qgmV34qtpTspuafBJq
 Ee5NRGaPrCKzztT1zQ3J2nxd+VFjwN8AwhbVoRZv7WthFUkWXAFKGdvTjmygi7rfrl1j
 Yd6VjwurCsmaElH7OtZggignJI0eW7vccYXlkTZ6C0ZpnTYvuym366UGia1OH65bAx0p
 YUrFsx828wmMNPw1i9mXq5pfda8+2iGH85+YM4apVbgSmv1U8T74YRXylVbYFlSMGyhI
 +PBSdqa6wjBWRY15s4cDeFb0ii63wdaQwXgxD6xPmxQhO9KQ5fZ4g6MUgAACzg9kNzs+
 vypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=o5H2qyOE9DWXcI4MI29a+zDTMEBymWnlkcqrM+PKBOc=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=mO/CUBlaLF+va42ZiDAtaGXlx5Z+XJ+mNlsL83SApcJmIjjd9nGtxN99s7ziMUtOeh
 lphSB9+RqRsZymaZx299uc6L0efwhptd0zYYaBazcjJnNNLMBLpvqsrkL13VPLG9ZUFM
 KkbnQ/1zh4N0z/oTA2BLUsQimEMs/EWnhMzkXSLSanXcWnEkNrrFcW92sZDANV7wZjNI
 LMjYnogqKBlyPfSapCVQI+LqAd49HR2dAALVkmzX9S4ZmHnqPsEaDHrTSpe9sP6hFrhm
 ZH0cOJHOBa6ndJC3tgli7L0bMzCVKRQCJtrZQUUz6Kyo9k66pluO7RX4/AZoZ9V3X+ka
 FPGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790445268; x=1791050068; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o5H2qyOE9DWXcI4MI29a+zDTMEBymWnlkcqrM+PKBOc=;
 b=LM0iI/6oKlZk7LAwGxWIqYyiNQkM+dXoGXnr4jF6XI/ejtBrXPlgSi9SHbUBsTiNXk
 14GmOx5Q7qUIgY39Pcx2OWZqCRJ7qsrWMBAuSHBgN+ewRfvmldXeDL2JtcMohGly/Ush
 uXdzKq46ELymTTfBh9lrp0+Vrj66JTCr0O19t98dSghpQxbanUcflHqSu2qSZTOq7glK
 pDsjMr6C5s4JV71Kd6h7NeFu8f4S09etvzxVUowBWPta7+v5nGOI4YtOdkpvty7xX6Fq
 X33EZfh36Mq7L7vDRcCN0jChutpUUFarJe/X1wooixtBVOgbsDNTRSWS4X4xmEpDsQ/7
 JQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790445268; x=1791050068;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o5H2qyOE9DWXcI4MI29a+zDTMEBymWnlkcqrM+PKBOc=;
 b=1nzgXMSj4Pmu0mDod5zyFaAnSDz0OMH0hy6lgYeaxZLVr2jBvP3hgoVoef3IRYj52A
 0UhGyY0LDFoEXFktfkoPHzIq+oQC1E+N8CVBKhbR3parJqnJ7ECqULwNBmh5HCXC4BzU
 60j8iV8ZGAdgUwTV3jALu2krCeinf+BKsFrOaeSctMeYBc1PYvEC+IoGrscyrpeLocew
 Z5QpUt5GRPjvh9BwELU6v5pSoOzwnYk1FYhzjCvBAwa65MIq1/jOKKLb1uotp2TgLK5v
 MlFJSOwbV8Rl8Ehgn0O291iY/QLy/DFMex6dL9FN39OdmKRMp6jLZ5mdUMoaaVWpBM7z
 vk6g==
X-Gm-Message-State: AFq9FYLGGPsMPynrtYBN205k9fFbIcg+5Rvny2I+5QAnhYTPYacVgAQ9
 /zsDWJqRWk8NPBrX8No5Evu5KNd0AKA26AHKQXsOUPugf4HHXDWsf81vE9qZ0yI3ph/mI7OKueK
 BRosEmK5Wykd/BM73xZj+/6w4/1OAP6NsiW0z8M0=
X-Gm-Gg: AYBFou3myWtSELYUeC2TXDfVIewFJrSw0qo1UF27633JgJAtjh+Bf9nPre7Whm1/5wB
 3+gC6BOVOroTIMqDOu29g78AK4uOcCvlH4fuPfyiqjFZxR1MkJ9+jC94m0hrv0ILu5F5bTMjfG6
 TkE+gSw7QJe/84stKfHWYJfhvL9Q7pmqa96kqD7A4qJoePUrptzj6HXflBAkRw0MgvPa2uXc14P
 iIqtziejHS8SXyVaiMwwXf1dSRTgglaSHJj/pRkpKKyiviBCdBoSh3fTONr3emwaYA2lJOD0zIe
 FBNDWwwovM+Fz+3YIdn0JVNl6bVpMKwgH/9GqyfmZBI4v3kB9bexm666k1h2UGCuEUbaEJf5pF8
 +YKOXGyizgc+e5odgI1LdcKB/inxy7UNMbgMjMvwtEszY2Q2IV/7mhNcbW9bxQSbXhS8ifjnm4J
 pwiiflQ2PBZrhN/zchSxx+tU/cBWL/KB3hV/SpEOMwbumeP4F1XzM887Vzov8PyYlo2U0y6LEsI
 fUadWK6+h7EhLwkBcs3OpMqQeA=
X-Received: by 2002:a05:6402:27d1:b0:6a9:b519:eb3f with SMTP id
 4fb4d7f45d1cf-6aac8f6afd2mr7438807a12.29.1790445267586; Sat, 26 Sep 2026
 10:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAKLTOU_PzjfpAnnCuGWSb=RWsWhXf84pWGUa=_gvTvKTV=eOnA@mail.gmail.com>
In-Reply-To: <CAKLTOU_PzjfpAnnCuGWSb=RWsWhXf84pWGUa=_gvTvKTV=eOnA@mail.gmail.com>
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Date: Sat, 26 Sep 2026 19:54:16 +0200
X-Gm-Features: AclHuK_eyBNfeUBnEJe7ZNzjZoqq0DSeAlpt-ENjSSsFovZVHTnFhx0dne5loKk
Message-ID: <CAKLTOU_cWvHRJFMMFMxy7StM8LXyakOtRn7uojmae0pHynFQBQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_drm=2Famdkfd=3A_KFD_process_restart_deadlocks_?=
 =?UTF-8?Q?in_svm=5Frange=5Flist=5Flock=5Fand=5Fflush=5Fwork_=E2=80=94_restore_work_flush?=
 =?UTF-8?Q?es_workqueue_it_runs_on_=2F_fence_never_completes_=28gfx906=29?=
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000002a11ed065c668688"
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

--0000000000002a11ed065c668688
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Follow-up with new evidence from the same machine (MI50 gfx906,
Thunderbolt eGPU, 7.2.6-k726 with CONFIG_UBSAN=3Dy). Three distinct
reproductions now =E2=80=94 the original D-state wedge, a TB-hot-unplug
variant, and a clean-restart capture that produced a GPU page fault +
devcoredump.

=3D=3D Reproduction 1: hot-unplug teardown (kernel-side splats) =3D=3D

A Thunderbolt link flap drove PCIe hot-unplug while llama-server was
running; the coredump walked into the SVM path and produced:

    svm_migrate_copy_memory_gart -> amdgpu_copy_buffer ->
    amdgpu_job_submit:
    drm_sched_rq_add_entity: *ERROR* Trying to push to a killed entity
    refcount_t: addition on 0; use-after-free.
    refcount_t: saturated; leaking memory.

i.e. migration submits a job to a drm_sched_entity already killed by
queue eviction =E2=80=94 the job never runs, the fence never signals, defer=
red
work blocks forever, subsequent allocs queue behind it. This supplies
the missing "why the fence never completes" for the alloc-path wedge.

Same boot, UBSAN invalid-loads inside evict_process_queues_cpsch:

    UBSAN: invalid-load kfd_device_queue_manager.c:1373
    UBSAN: invalid-load kfd_device_queue_manager.c:1388
    UBSAN: invalid-load kfd_device_queue_manager.c:1391

reached via svm_migrate_vram_to_ram -> migrate_vma_setup ->
__mmu_notifier_invalidate_range_start ->
svm_range_cpu_invalidate_pagetables -> kgd2kfd_quiesce_mm ->
kfd_process_evict_queues -> evict_process_queues_cpsch
(reading torn/freed queue-manager state mid-eviction).

=3D=3D Reproduction 2: clean restart =E2=80=94 userspace spin + device wedg=
e =3D=3D

A clean stop/start of llama-cpp.service (SIGTERM, no hotplug, link
stable 40Gb/s) wedged differently this time:

- VRAM allocs SUCCEEDED (19.5GB resident) =E2=80=94 the alloc path did not
  block this trial
- the process then spun in userspace at ~90% CPU, zero syscalls, with
  gpu_busy=3D0 forever
- gdb shows the spin inside libhsa-runtime64 (rdtsc wait loop) =E2=80=94
  hsa_signal_wait polling a completion signal that never arrives;
  the submitted GPU work never executes

So the wedge has a second symptom class: allocs pass, queues are dead,
userspace spins on a signal that can never fire.

=3D=3D Reproduction 3: the smoking gun =E2=80=94 stale SVM mapping faults =
=3D=3D

The next auto-restart produced the hardware-level evidence:

    amdgpu 0000:05:00.0: [gfxhub0] no-retry page fault
        (src_id:0 ring:158 vmid:8 pasid:58)
        Process llama-server pid 1356287
        in page starting at address 0x00007bc82af9c000 (UTCL2)
        WALKER_ERROR: 0x6  MAPPING_ERROR: 0x1  PERMISSION_FAULTS: 0x3

    qcm fence wait loop timeout expired
    cp might be in an unrecoverable state due to unsuccessful queues
    preemption
    GPU reset begin!  (BACO)
    VRAM is lost due to GPU reset!
    Fence fallback timer expired on ring comp_1.0.0
    GPU reset(2) succeeded!
    device wedged, but no recovery needed

The GPU's page walker faulted on a VA inside the process's own address
space (0x7bc82af9c000, adjacent to the main thread's stack at
0x7bc82afb1000) =E2=80=94 MAPPING_ERROR+WALKER_ERROR means the walk hit a
bogus/stale PTE, consistent with a torn SVM mapping surviving process
teardown into the next process's restored tables. Fault -> preempt
timeout -> reset -> device wedged; every subsequent instance spins in
hsa_signal_wait until reboot.

After reboot: first start healthy in ~60s (confirming
first-start-works / restart-wedges).

=3D=3D Artifacts =3D=3D

- amdgpu devcoredump captured from /sys/class/drm/card0/device/
  devcoredump/data at the 15:15 reset (3472 lines, ring/reg state)
- full journalctl -k covering both restart attempts
- userspace stacks: main thread spinning in libhsa-runtime64
  (rdtsc loop @ file offset ~0x6a7c5), worker threads in
  kfd_wait_on_events

Happy to send the devcoredump or run further captures =E2=80=94 reproductio=
n
is ~15-20 min per trial on this box.

Olivier

On Fri, 25 Sept 2026 at 14:52, Olivier Kaloudoff <
olivier.kaloudoff@gmail.com> wrote:

> =3D=3D Summary =3D=3D
>
> Restarting a KFD application reliably deadlocks the next instance during
> its initial GPU memory allocations. Two threads block permanently:
>
>   (a) the new userspace process in
>       kfd_ioctl_alloc_memory_of_gpu -> svm_range_list_lock_and_flush_work
>       -> flush_work -> __flush_work   (D state)
>
>   (b) a kworker running
>       svm_range_restore_work -> svm_range_list_lock_and_flush_work
>       -> flush_work -> __flush_work   (D state)
>
> Both wait for svms->deferred_list_work, which never completes. On a
> 7.0.12 kernel the userspace side was instead observed blocked in
> dma_fence_default_wait, suggesting the deferred work item is itself
> waiting on a dma fence that cannot complete (plausibly because it
> requires KFD queue progress while queues are suspended for
> eviction/restore). Once this state is reached, every subsequent
> kfd_ioctl_alloc_memory_of_gpu queues behind the stuck flush; the
> process cannot be killed (uninterruptible sleep) and the device is
> unusable until reboot.
>
> The trigger is a KFD process teardown followed by a fresh KFD process
> doing VRAM allocations =E2=80=94 i.e. simply restarting a ROCm/HIP applic=
ation.
> First start after boot succeeds; a restart wedges with high
> probability (observed ~70-100%).
>
> This does NOT appear to be a regression: reproduced identically on
> 6.17.13, 7.0.12 and 7.2.6 (all Proxmox pve builds plus one custom
> config). Possibly long-standing; likely related to the unresolved
> "svm restore worker stuck" issues discussed on amd-gfx in 2025.
>
> =3D=3D Environment =3D=3D
>
>   GPU:        AMD Radeon Instinct MI50 32GB, gfx906, 0000:05:00.0
>               (Vega 20, PCIe, attached via Thunderbolt 3 eGPU enclosure,
>               hotplug-capable PCI topology =E2=80=94 may be relevant sinc=
e SVM
>               eviction/restore work is tied to hotplug/fault events)
>   Host:       AMD Strix Halo (Ryzen AI Max+ 395), Proxmox VE 9 host
>   Kernels:    6.17.13-13-pve, 7.0.12-1-pve, 7.2.6-k726 (custom config)
>               =E2=80=94 all affected
>   Cmdline:    amdgpu.dc=3D0 modprobe.blacklist=3Damdxdna apparmor=3D0
>   Userspace:  llama.cpp llama-server (HIP/ROCm), hsakmt/ROCm stack;
>               any KFD client restart reproduces it
>   Taint:      512 (U =E2=80=94 unsigned module loaded early at boot; no D=
KMS,
>               no out-of-tree module in the KFD path)
>
> =3D=3D Reproduction =3D=3D
>
>   1. Boot the system with the MI50 bound to amdgpu/KFD.
>   2. Start a KFD application that allocates substantial VRAM
>      (llama-server --model <19GB GGUF> -ngl 99; ROCm offload).
>      Wait for it to finish initializing (serves inference).
>   3. Stop it (SIGTERM/SIGKILL/systemctl stop) and start it again.
>   4. During model VRAM allocation the new process blocks in
>      kfd_ioctl_alloc_memory_of_gpu and never returns.
>
>   Faster reproducer sketch (what llama init does): a fresh process does
>   hsa_init -> acquire gfx906 node -> repeated hsaKmtAllocMemory +
>   hsaKmtMapMemoryToGPU of large (1-4 GB) VRAM blocks. The wedged state
>   is always entered via the first few alloc ioctls after process start.
>
> =3D=3D Observed stacks (kernel 7.2.6, SysRq-w / /proc/<pid>/stack) =3D=3D
>
>   Userspace process (llama-server, D state):
>
>       __flush_work+0x2c4/0x3c0
>       flush_work+0x1c/0x30
>       svm_range_list_lock_and_flush_work+0x2f/0x100 [amdgpu]
>       kfd_ioctl_alloc_memory_of_gpu+0x7c/0x3a0 [amdgpu]
>       kfd_ioctl+0x408/0x640 [amdgpu]
>       __x64_sys_ioctl+0xa5/0x100
>
>   Concurrent kworker (D state, same boot):
>
>       __flush_work+0x2c4/0x3c0
>       flush_work+0x1c/0x30
>       svm_range_list_lock_and_flush_work+0x2f/0x100 [amdgpu]
>       svm_range_restore_work+0x75/0x3a0 [amdgpu]
>       process_one_work+0x1a9/0x390
>       worker_thread+0x1b8/0x360
>
>   On 7.0.12-1-pve the userspace process was observed in:
>
>       dma_fence_default_wait+0x87/0x2a0
>
> =3D=3D Analysis =3D=3D
>
>   svm_range_list_lock_and_flush_work() flushes svms->deferred_list_work
>   then takes mmap_write_lock, retrying while deferred_range_list is
>   non-empty. The observed state has BOTH the alloc path and
>   svm_range_restore_work blocked in flush_work() on the same
>   deferred_list_work =E2=80=94 i.e. the deferred work item can never comp=
lete.
>
>   Likely circular wait: svm_range_restore_work runs while KFD queues
>   are suspended for eviction/restore; a queued deferred work item
>   (migrate/map) needs GPU progress / a dma fence that requires those
>   queues to run; restore_work waits for the deferred item to drain;
>   the alloc path waits behind the same flush.
>
>   Related prior work (this may be a remaining/unfixed variant):
>
>     - CVE-2022-49133 / commit "drm/amdkfd: svm range restore work
>       deadlock when process exit" =E2=80=94 fixed a different restore_wor=
k
>       flush deadlock at process exit.
>     - [PATCH] "drm/amdkfd: Fix the deadlock in svm_range_restore_work"
>       (Emily Deng, amd-gfx, Feb 2025) =E2=80=94 mmap_write_downgrade() fi=
x for
>       restore_work vs svm_range_evict_svm_bo_worker.
>     - [PATCH v2 3/3] "drm/amdkfd: Don't stuck in svm restore worker"
>       (amd-gfx, Oct 2025) =E2=80=94 restore work retrying forever when th=
e VMA
>       is gone; the corresponding !vma unmap path does not appear to be
>       present in current mainline kfd_svm.c.
>
> =3D=3D What was ruled out =3D=3D
>
>   - HSA_XNACK=3D0 does not avoid the deadlock (alloc path always enters
>     svm_range_list_lock_and_flush_work regardless).
>   - Not context-size/alloc-size specific: reproduces with an 8GB
>     instead of 32GB context.
>   - Not specific to the custom kernel: identical deadlock on stock
>     7.0.12-1-pve and 6.17.13-13-pve builds.
>   - kfdtest (ROCT-Thunk-Interface test suite) memory/queue tests all
>     pass while a healthy KFD process holds the device =E2=80=94 the deadl=
ock
>     specifically needs the process-teardown -> fresh-init sequence.
>   - Hardware side: link stable at 40 Gb/s, card healthy =E2=80=94 the wed=
ge
>     reproduces with zero link events in dmesg.
>
> =3D=3D Logs =3D=3D
>
>   Full SysRq-w dumps, both blocked stacks, dmesg and llama-side logs
>   attached / available on request (saved per-trial).
>
> =3D=3D Notes for maintainers =3D=3D
>
>   - The MI50 is attached via Thunderbolt (pciehp hotplug topology).
>     If SVM restore work scheduling is influenced by hotplug-related
>     eviction/fault paths, this setup may expose a timing window that
>     does not exist on fixed PCIe. Happy to test patches =E2=80=94 reprodu=
ction
>     takes ~5 minutes per trial on this machine.
>


--=20

Olivier Kaloudoff
R=C3=A9sidence la source - b=C3=A2timent B
12 all=C3=A9e des Grillons
13 620 Carry le Rouet
06 20 65 71 33

--0000000000002a11ed065c668688
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div>Follow-up with new evidence from the same m=
achine (MI50 gfx906,<br>Thunderbolt eGPU, 7.2.6-k726 with CONFIG_UBSAN=3Dy)=
. Three distinct<br>reproductions now =E2=80=94 the original D-state wedge,=
 a TB-hot-unplug<br>variant, and a clean-restart capture that produced a GP=
U page fault +<br>devcoredump.<br><br>=3D=3D Reproduction 1: hot-unplug tea=
rdown (kernel-side splats) =3D=3D<br><br>A Thunderbolt link flap drove PCIe=
 hot-unplug while llama-server was<br>running; the coredump walked into the=
 SVM path and produced:<br><br>=C2=A0 =C2=A0 svm_migrate_copy_memory_gart -=
&gt; amdgpu_copy_buffer -&gt;<br>=C2=A0 =C2=A0 amdgpu_job_submit:<br>=C2=A0=
 =C2=A0 drm_sched_rq_add_entity: *ERROR* Trying to push to a killed entity<=
br>=C2=A0 =C2=A0 refcount_t: addition on 0; use-after-free.<br>=C2=A0 =C2=
=A0 refcount_t: saturated; leaking memory.<br><br>i.e. migration submits a =
job to a drm_sched_entity already killed by<br>queue eviction =E2=80=94 the=
 job never runs, the fence never signals, deferred<br>work blocks forever, =
subsequent allocs queue behind it. This supplies<br>the missing &quot;why t=
he fence never completes&quot; for the alloc-path wedge.<br><br>Same boot, =
UBSAN invalid-loads inside evict_process_queues_cpsch:<br><br>=C2=A0 =C2=A0=
 UBSAN: invalid-load kfd_device_queue_manager.c:1373<br>=C2=A0 =C2=A0 UBSAN=
: invalid-load kfd_device_queue_manager.c:1388<br>=C2=A0 =C2=A0 UBSAN: inva=
lid-load kfd_device_queue_manager.c:1391<br><br>reached via svm_migrate_vra=
m_to_ram -&gt; migrate_vma_setup -&gt;<br>__mmu_notifier_invalidate_range_s=
tart -&gt;<br>svm_range_cpu_invalidate_pagetables -&gt; kgd2kfd_quiesce_mm =
-&gt;<br>kfd_process_evict_queues -&gt; evict_process_queues_cpsch<br>(read=
ing torn/freed queue-manager state mid-eviction).<br><br>=3D=3D Reproductio=
n 2: clean restart =E2=80=94 userspace spin + device wedge =3D=3D<br><br>A =
clean stop/start of llama-cpp.service (SIGTERM, no hotplug, link<br>stable =
40Gb/s) wedged differently this time:<br><br>- VRAM allocs SUCCEEDED (19.5G=
B resident) =E2=80=94 the alloc path did not<br>=C2=A0 block this trial<br>=
- the process then spun in userspace at ~90% CPU, zero syscalls, with<br>=
=C2=A0 gpu_busy=3D0 forever<br>- gdb shows the spin inside libhsa-runtime64=
 (rdtsc wait loop) =E2=80=94<br>=C2=A0 hsa_signal_wait polling a completion=
 signal that never arrives;<br>=C2=A0 the submitted GPU work never executes=
<br><br>So the wedge has a second symptom class: allocs pass, queues are de=
ad,<br>userspace spins on a signal that can never fire.<br><br>=3D=3D Repro=
duction 3: the smoking gun =E2=80=94 stale SVM mapping faults =3D=3D<br><br=
>The next auto-restart produced the hardware-level evidence:<br><br>=C2=A0 =
=C2=A0 amdgpu 0000:05:00.0: [gfxhub0] no-retry page fault<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (src_id:0 ring:158 vmid:8 pasid:58)<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Process llama-server pid 1356287<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 in p=
age starting at address 0x00007bc82af9c000 (UTCL2)<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 WALKER_ERROR: 0x6 =C2=A0MAPPING_ERROR: 0x1 =C2=A0PERMISSION_FAULTS: =
0x3<br><br>=C2=A0 =C2=A0 qcm fence wait loop timeout expired<br>=C2=A0 =C2=
=A0 cp might be in an unrecoverable state due to unsuccessful queues<br>=C2=
=A0 =C2=A0 preemption<br>=C2=A0 =C2=A0 GPU reset begin! =C2=A0(BACO)<br>=C2=
=A0 =C2=A0 VRAM is lost due to GPU reset!<br>=C2=A0 =C2=A0 Fence fallback t=
imer expired on ring comp_1.0.0<br>=C2=A0 =C2=A0 GPU reset(2) succeeded!<br=
>=C2=A0 =C2=A0 device wedged, but no recovery needed<br><br>The GPU&#39;s p=
age walker faulted on a VA inside the process&#39;s own address<br>space (0=
x7bc82af9c000, adjacent to the main thread&#39;s stack at<br>0x7bc82afb1000=
) =E2=80=94 MAPPING_ERROR+WALKER_ERROR means the walk hit a<br>bogus/stale =
PTE, consistent with a torn SVM mapping surviving process<br>teardown into =
the next process&#39;s restored tables. Fault -&gt; preempt<br>timeout -&gt=
; reset -&gt; device wedged; every subsequent instance spins in<br>hsa_sign=
al_wait until reboot.<br><br>After reboot: first start healthy in ~60s (con=
firming<br>first-start-works / restart-wedges).<br><br>=3D=3D Artifacts =3D=
=3D<br><br>- amdgpu devcoredump captured from /sys/class/drm/card0/device/<=
br>=C2=A0 devcoredump/data at the 15:15 reset (3472 lines, ring/reg state)<=
br>- full journalctl -k covering both restart attempts<br>- userspace stack=
s: main thread spinning in libhsa-runtime64<br>=C2=A0 (rdtsc loop @ file of=
fset ~0x6a7c5), worker threads in<br>=C2=A0 kfd_wait_on_events<br><br>Happy=
 to send the devcoredump or run further captures =E2=80=94 reproduction<br>=
is ~15-20 min per trial on this box.<br><br>Olivier<br></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri, 25 Sept 2026 at 14:52, Olivier Kaloudoff &lt;<a href=3D"mailto:ol=
ivier.kaloudoff@gmail.com">olivier.kaloudoff@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">=3D=
=3D Summary =3D=3D<br><br>Restarting a KFD application reliably deadlocks t=
he next instance during<br>its initial GPU memory allocations. Two threads =
block permanently:<br><br>=C2=A0 (a) the new userspace process in<br>=C2=A0=
 =C2=A0 =C2=A0 kfd_ioctl_alloc_memory_of_gpu -&gt; svm_range_list_lock_and_=
flush_work<br>=C2=A0 =C2=A0 =C2=A0 -&gt; flush_work -&gt; __flush_work =C2=
=A0 (D state)<br><br>=C2=A0 (b) a kworker running<br>=C2=A0 =C2=A0 =C2=A0 s=
vm_range_restore_work -&gt; svm_range_list_lock_and_flush_work<br>=C2=A0 =
=C2=A0 =C2=A0 -&gt; flush_work -&gt; __flush_work =C2=A0 (D state)<br><br>B=
oth wait for svms-&gt;deferred_list_work, which never completes. On a<br>7.=
0.12 kernel the userspace side was instead observed blocked in<br>dma_fence=
_default_wait, suggesting the deferred work item is itself<br>waiting on a =
dma fence that cannot complete (plausibly because it<br>requires KFD queue =
progress while queues are suspended for<br>eviction/restore). Once this sta=
te is reached, every subsequent<br>kfd_ioctl_alloc_memory_of_gpu queues beh=
ind the stuck flush; the<br>process cannot be killed (uninterruptible sleep=
) and the device is<br>unusable until reboot.<br><br>The trigger is a KFD p=
rocess teardown followed by a fresh KFD process<br>doing VRAM allocations =
=E2=80=94 i.e. simply restarting a ROCm/HIP application.<br>First start aft=
er boot succeeds; a restart wedges with high<br>probability (observed ~70-1=
00%).<br><br>This does NOT appear to be a regression: reproduced identicall=
y on<br>6.17.13, 7.0.12 and 7.2.6 (all Proxmox pve builds plus one custom<b=
r>config). Possibly long-standing; likely related to the unresolved<br>&quo=
t;svm restore worker stuck&quot; issues discussed on amd-gfx in 2025.<br><b=
r>=3D=3D Environment =3D=3D<br><br>=C2=A0 GPU: =C2=A0 =C2=A0 =C2=A0 =C2=A0A=
MD Radeon Instinct MI50 32GB, gfx906, 0000:05:00.0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (Vega 20, PCIe, attached via Thunderbolt 3 eGPU=
 enclosure,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hotplug-cap=
able PCI topology =E2=80=94 may be relevant since SVM<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eviction/restore work is tied to hotplug/fa=
ult events)<br>=C2=A0 Host: =C2=A0 =C2=A0 =C2=A0 AMD Strix Halo (Ryzen AI M=
ax+ 395), Proxmox VE 9 host<br>=C2=A0 Kernels: =C2=A0 =C2=A06.17.13-13-pve,=
 7.0.12-1-pve, 7.2.6-k726 (custom config)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =E2=80=94 all affected<br>=C2=A0 Cmdline: =C2=A0 =C2=
=A0amdgpu.dc=3D0 modprobe.blacklist=3Damdxdna apparmor=3D0<br>=C2=A0 Usersp=
ace: =C2=A0llama.cpp llama-server (HIP/ROCm), hsakmt/ROCm stack;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 any KFD client restart reproduces=
 it<br>=C2=A0 Taint: =C2=A0 =C2=A0 =C2=A0512 (U =E2=80=94 unsigned module l=
oaded early at boot; no DKMS,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 no out-of-tree module in the KFD path)<br><br>=3D=3D Reproduction =
=3D=3D<br><br>=C2=A0 1. Boot the system with the MI50 bound to amdgpu/KFD.<=
br>=C2=A0 2. Start a KFD application that allocates substantial VRAM<br>=C2=
=A0 =C2=A0 =C2=A0(llama-server --model &lt;19GB GGUF&gt; -ngl 99; ROCm offl=
oad).<br>=C2=A0 =C2=A0 =C2=A0Wait for it to finish initializing (serves inf=
erence).<br>=C2=A0 3. Stop it (SIGTERM/SIGKILL/systemctl stop) and start it=
 again.<br>=C2=A0 4. During model VRAM allocation the new process blocks in=
<br>=C2=A0 =C2=A0 =C2=A0kfd_ioctl_alloc_memory_of_gpu and never returns.<br=
><br>=C2=A0 Faster reproducer sketch (what llama init does): a fresh proces=
s does<br>=C2=A0 hsa_init -&gt; acquire gfx906 node -&gt; repeated hsaKmtAl=
locMemory +<br>=C2=A0 hsaKmtMapMemoryToGPU of large (1-4 GB) VRAM blocks. T=
he wedged state<br>=C2=A0 is always entered via the first few alloc ioctls =
after process start.<br><br>=3D=3D Observed stacks (kernel 7.2.6, SysRq-w /=
 /proc/&lt;pid&gt;/stack) =3D=3D<br><br>=C2=A0 Userspace process (llama-ser=
ver, D state):<br><br>=C2=A0 =C2=A0 =C2=A0 __flush_work+0x2c4/0x3c0<br>=C2=
=A0 =C2=A0 =C2=A0 flush_work+0x1c/0x30<br>=C2=A0 =C2=A0 =C2=A0 svm_range_li=
st_lock_and_flush_work+0x2f/0x100 [amdgpu]<br>=C2=A0 =C2=A0 =C2=A0 kfd_ioct=
l_alloc_memory_of_gpu+0x7c/0x3a0 [amdgpu]<br>=C2=A0 =C2=A0 =C2=A0 kfd_ioctl=
+0x408/0x640 [amdgpu]<br>=C2=A0 =C2=A0 =C2=A0 __x64_sys_ioctl+0xa5/0x100<br=
><br>=C2=A0 Concurrent kworker (D state, same boot):<br><br>=C2=A0 =C2=A0 =
=C2=A0 __flush_work+0x2c4/0x3c0<br>=C2=A0 =C2=A0 =C2=A0 flush_work+0x1c/0x3=
0<br>=C2=A0 =C2=A0 =C2=A0 svm_range_list_lock_and_flush_work+0x2f/0x100 [am=
dgpu]<br>=C2=A0 =C2=A0 =C2=A0 svm_range_restore_work+0x75/0x3a0 [amdgpu]<br=
>=C2=A0 =C2=A0 =C2=A0 process_one_work+0x1a9/0x390<br>=C2=A0 =C2=A0 =C2=A0 =
worker_thread+0x1b8/0x360<br><br>=C2=A0 On 7.0.12-1-pve the userspace proce=
ss was observed in:<br><br>=C2=A0 =C2=A0 =C2=A0 dma_fence_default_wait+0x87=
/0x2a0<br><br>=3D=3D Analysis =3D=3D<br><br>=C2=A0 svm_range_list_lock_and_=
flush_work() flushes svms-&gt;deferred_list_work<br>=C2=A0 then takes mmap_=
write_lock, retrying while deferred_range_list is<br>=C2=A0 non-empty. The =
observed state has BOTH the alloc path and<br>=C2=A0 svm_range_restore_work=
 blocked in flush_work() on the same<br>=C2=A0 deferred_list_work =E2=80=94=
 i.e. the deferred work item can never complete.<br><br>=C2=A0 Likely circu=
lar wait: svm_range_restore_work runs while KFD queues<br>=C2=A0 are suspen=
ded for eviction/restore; a queued deferred work item<br>=C2=A0 (migrate/ma=
p) needs GPU progress / a dma fence that requires those<br>=C2=A0 queues to=
 run; restore_work waits for the deferred item to drain;<br>=C2=A0 the allo=
c path waits behind the same flush.<br><br>=C2=A0 Related prior work (this =
may be a remaining/unfixed variant):<br><br>=C2=A0 =C2=A0 - CVE-2022-49133 =
/ commit &quot;drm/amdkfd: svm range restore work<br>=C2=A0 =C2=A0 =C2=A0 d=
eadlock when process exit&quot; =E2=80=94 fixed a different restore_work<br=
>=C2=A0 =C2=A0 =C2=A0 flush deadlock at process exit.<br>=C2=A0 =C2=A0 - [P=
ATCH] &quot;drm/amdkfd: Fix the deadlock in svm_range_restore_work&quot;<br=
>=C2=A0 =C2=A0 =C2=A0 (Emily Deng, amd-gfx, Feb 2025) =E2=80=94 mmap_write_=
downgrade() fix for<br>=C2=A0 =C2=A0 =C2=A0 restore_work vs svm_range_evict=
_svm_bo_worker.<br>=C2=A0 =C2=A0 - [PATCH v2 3/3] &quot;drm/amdkfd: Don&#39=
;t stuck in svm restore worker&quot;<br>=C2=A0 =C2=A0 =C2=A0 (amd-gfx, Oct =
2025) =E2=80=94 restore work retrying forever when the VMA<br>=C2=A0 =C2=A0=
 =C2=A0 is gone; the corresponding !vma unmap path does not appear to be<br=
>=C2=A0 =C2=A0 =C2=A0 present in current mainline kfd_svm.c.<br><br>=3D=3D =
What was ruled out =3D=3D<br><br>=C2=A0 - HSA_XNACK=3D0 does not avoid the =
deadlock (alloc path always enters<br>=C2=A0 =C2=A0 svm_range_list_lock_and=
_flush_work regardless).<br>=C2=A0 - Not context-size/alloc-size specific: =
reproduces with an 8GB<br>=C2=A0 =C2=A0 instead of 32GB context.<br>=C2=A0 =
- Not specific to the custom kernel: identical deadlock on stock<br>=C2=A0 =
=C2=A0 7.0.12-1-pve and 6.17.13-13-pve builds.<br>=C2=A0 - kfdtest (ROCT-Th=
unk-Interface test suite) memory/queue tests all<br>=C2=A0 =C2=A0 pass whil=
e a healthy KFD process holds the device =E2=80=94 the deadlock<br>=C2=A0 =
=C2=A0 specifically needs the process-teardown -&gt; fresh-init sequence.<b=
r>=C2=A0 - Hardware side: link stable at 40 Gb/s, card healthy =E2=80=94 th=
e wedge<br>=C2=A0 =C2=A0 reproduces with zero link events in dmesg.<br><br>=
=3D=3D Logs =3D=3D<br><br>=C2=A0 Full SysRq-w dumps, both blocked stacks, d=
mesg and llama-side logs<br>=C2=A0 attached / available on request (saved p=
er-trial).<br><br>=3D=3D Notes for maintainers =3D=3D<br><br>=C2=A0 - The M=
I50 is attached via Thunderbolt (pciehp hotplug topology).<br>=C2=A0 =C2=A0=
 If SVM restore work scheduling is influenced by hotplug-related<br>=C2=A0 =
=C2=A0 eviction/fault paths, this setup may expose a timing window that<br>=
=C2=A0 =C2=A0 does not exist on fixed PCIe. Happy to test patches =E2=80=94=
 reproduction<br>=C2=A0 =C2=A0 takes ~5 minutes per trial on this machine.<=
/div>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><div dir=3D"ltr">Oliv=
ier Kaloudoff<br><div style=3D"color:rgb(34,34,34)">R=C3=A9sidence la sourc=
e - b=C3=A2timent=C2=A0B</div><div style=3D"color:rgb(34,34,34)">12 all=C3=
=A9e des Grillons<br clear=3D"all"><div>13 620 Carry le Rouet</div></div>06=
 20 65 71 33</div></div></div>

--0000000000002a11ed065c668688--
