Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0323C9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 12:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8EA10FA75;
	Fri, 25 Sep 2026 12:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EHSiADmT";
	dkim-atps=neutral
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6F810FA60
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 12:52:24 +0000 (UTC)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so1053201a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 05:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790340743; cv=none;
 d=google.com; s=arc-20260327;
 b=lQnD+mhy7UeBfDfQmTb49MfcyIpzWIAb0S8negHpZf+arIUU23QPY6WGXmuHBRh8hL
 el9R88/G6dxsHl3EtbuEiLMf1xBWVIOhnZ1+AxGnHUSN3LoCURV/cGpoSSQCyBcRvDv6
 W245H4dbBakhg07iHpka9ibUrHNq3oiaH38lcgtcZNXMfLIG4hkmHIAYbIPVhHpdzVoY
 hKqg/6z/gKuqzoQYDTuJtN4A4+3gBYlwsMjYwfet6P2ztLQRZnh7hjayuVWl0MGcCJ3p
 OknrpzztIFzz415/NBh7lMOQxBxFyJlpsDmMyvugfAl42joY4dsgvW8+K1ysnaStK73a
 MlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=GUcnIchCOGH9nSIAHyD4dHmdESVZKjf2mQjIuXPKFVM=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=j4kXXhelVm9BsICIBjzBaejiRp8pyNzFK9eBRKtMLsNzH4S0IZcO7xcn6gSFd0QWlg
 AmPZE+VWjNIf/LDP76LcisKJr4yZo5wdJTmjtm5zNbPKG6XQb/k1Jp2OXMJeCmz32I1l
 h6V/pYQrArr1o2bsNEjedyA11Hk4CkiTdG3WvZ/Byl1eliwHtrC4QAFy7vzD69BZwLKa
 W1QWgqdgIXISNUiauJpu4Bnw+PgxqyVdz8mX1ipFVZyVx7k4J3av0Lc2Fgl1Uat2Xh/u
 R1Uvt1ZcrsqkHlEJMgqfheHcXLktxeQlt0YDIw434+lqdfvaTrkeEWJkaFvrw+OTICPQ
 gbWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790340743; x=1790945543; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GUcnIchCOGH9nSIAHyD4dHmdESVZKjf2mQjIuXPKFVM=;
 b=EHSiADmTlzEGzWPPKKuFcdkiFKTl+IEPaTV6ASVh2QeA3GnQL1oXL4ZXZ2j8wcja2r
 +tzHFWydoYFXnSXHFRuFpLAMHo+acMeL6sG94XyYktcRjwwX5V4SBAo0lG/5he2VAtjD
 qpQE8dGnuxxnEGPZrGmCsS+ar8Xb7yusD864YAgAQG6xYl/FhrGZw6HX8uziT9lwyiqW
 OOOCAiZL94fv9Gq7c0LEBEWXA0BNPZllbTHzoBFvNQNs2gXUinO2jnDp+nfJpVgUuJM1
 Uk2TTjewuvbmnlNhzhFkBSf5J8Zov6+TjdJ78Q/9T5iFnKrwbf6y+eyoQWyO4Cne7Baf
 4uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790340743; x=1790945543;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GUcnIchCOGH9nSIAHyD4dHmdESVZKjf2mQjIuXPKFVM=;
 b=dTTwNH2OtRABxAsCrXTKrkrxEwrVfAbsud6HGx2fKUGV+YYdFRR+2G0UxcmnCKC348
 eBxigISHIsU2cmlDQ2/upA8TU07feHcUJ4pO+JGrzTPScq02xc8Dmx7clkh2rjLHFaze
 4aH84TLUs37ooe6jwZQ/CpOGyV2kJ7gyIj0nmljxxd7b/Qb9hhtFvPnVY3KgBMIm46Ts
 cmWTh8R5+R01hBXq0YniY1gG3LvpWtLqOlprECginNBWQDjkcbJXDSu+Kyq4YViN6dIM
 BaJK3g3XI5kohvPL6o2dyH+dt+VB+/VuKifPm81q+KyHALXY5zgXqBfiBIislR9DwjM4
 93NQ==
X-Gm-Message-State: AFuF++kGTt6Jd2MuWUFvHGV5JbMlDM6JrfAQlz4rk1PyTpx5GfnSIXSV
 E4tb3h409ZBKyh1FRFRPsZl7farAbbFrr5g3ixODz7NKow1uo3kMRJcgaLwnFqWabPNpaZ8AHwV
 6u0/tw4ACrUwijctkt1sQouD0ORSMG92v6zEqpCw=
X-Gm-Gg: AYBFou15Y9yfi/HUJmqrKFCvV3ROLAHQJy8P8PDUxtrWXEUbYbH+4kQfYp+Z1/YW3OA
 pjFdLjl0xMaizRrEZcQDaUZ2xTHTPtza+jEgcDGuWVL3WFWMaPrQQy9BsjCIywIMeklcZKmFgX9
 ZOgcz3bZfAT5DlFcn9CF6HVym2SIGCuBR/ynE7tWOlnI7+Zx4cdFt1iCFbVg9eZygbEsXGCfZMi
 oxnlZRcOtXZedM19/uPr6her/W0KTv9aGjDBTRJJ+6tGFD6XiRcPON6V0vE4Mjj6SlSkNb+r9Yn
 AFmijVdlZHKQFWxCCu042Jsa6FVGEdoC+E1W7aD3tZ+Gp+xMy7PQGuc+FMwgxtqj1HgP6ErghH3
 RAkdiHHmQ4ZpvqXrbZU3vQPHUFEvOaFL9ujeaBzF3T9pPQ62HQUMO/F8ak404gG3dKT9GeZlkvx
 r+9i+74NOlk0LGksAVmqFrs8W2xzs13pG+rjXFOPDX8xwvkyx6yWnmHmAInlZtx1N6tKvl9Mu8b
 cQIL6CRrbQ=
X-Received: by 2002:a05:6402:5111:b0:6aa:734b:1a26 with SMTP id
 4fb4d7f45d1cf-6aac8f64977mr4840331a12.32.1790340742716; Fri, 25 Sep 2026
 05:52:22 -0700 (PDT)
MIME-Version: 1.0
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Date: Fri, 25 Sep 2026 14:52:08 +0200
X-Gm-Features: AclHuK-gDQN_tcv_CEpJ9YVCW1qSgJlO4b1xPGa8RGeEVgIKkoTFvU8tuHx5Cg4
Message-ID: <CAKLTOU_PzjfpAnnCuGWSb=RWsWhXf84pWGUa=_gvTvKTV=eOnA@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_drm=2Famdkfd=3A_KFD_process_restart_deadlocks_in_s?=
 =?UTF-8?Q?vm=5Frange=5Flist=5Flock=5Fand=5Fflush=5Fwork_=E2=80=94_restore_work_flushes_w?=
 =?UTF-8?Q?orkqueue_it_runs_on_=2F_fence_never_completes_=28gfx906=29?=
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000ff2065065c4e2f41"
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

--000000000000ff2065065c4e2f41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=3D=3D Summary =3D=3D

Restarting a KFD application reliably deadlocks the next instance during
its initial GPU memory allocations. Two threads block permanently:

  (a) the new userspace process in
      kfd_ioctl_alloc_memory_of_gpu -> svm_range_list_lock_and_flush_work
      -> flush_work -> __flush_work   (D state)

  (b) a kworker running
      svm_range_restore_work -> svm_range_list_lock_and_flush_work
      -> flush_work -> __flush_work   (D state)

Both wait for svms->deferred_list_work, which never completes. On a
7.0.12 kernel the userspace side was instead observed blocked in
dma_fence_default_wait, suggesting the deferred work item is itself
waiting on a dma fence that cannot complete (plausibly because it
requires KFD queue progress while queues are suspended for
eviction/restore). Once this state is reached, every subsequent
kfd_ioctl_alloc_memory_of_gpu queues behind the stuck flush; the
process cannot be killed (uninterruptible sleep) and the device is
unusable until reboot.

The trigger is a KFD process teardown followed by a fresh KFD process
doing VRAM allocations =E2=80=94 i.e. simply restarting a ROCm/HIP applicat=
ion.
First start after boot succeeds; a restart wedges with high
probability (observed ~70-100%).

This does NOT appear to be a regression: reproduced identically on
6.17.13, 7.0.12 and 7.2.6 (all Proxmox pve builds plus one custom
config). Possibly long-standing; likely related to the unresolved
"svm restore worker stuck" issues discussed on amd-gfx in 2025.

=3D=3D Environment =3D=3D

  GPU:        AMD Radeon Instinct MI50 32GB, gfx906, 0000:05:00.0
              (Vega 20, PCIe, attached via Thunderbolt 3 eGPU enclosure,
              hotplug-capable PCI topology =E2=80=94 may be relevant since =
SVM
              eviction/restore work is tied to hotplug/fault events)
  Host:       AMD Strix Halo (Ryzen AI Max+ 395), Proxmox VE 9 host
  Kernels:    6.17.13-13-pve, 7.0.12-1-pve, 7.2.6-k726 (custom config)
              =E2=80=94 all affected
  Cmdline:    amdgpu.dc=3D0 modprobe.blacklist=3Damdxdna apparmor=3D0
  Userspace:  llama.cpp llama-server (HIP/ROCm), hsakmt/ROCm stack;
              any KFD client restart reproduces it
  Taint:      512 (U =E2=80=94 unsigned module loaded early at boot; no DKM=
S,
              no out-of-tree module in the KFD path)

=3D=3D Reproduction =3D=3D

  1. Boot the system with the MI50 bound to amdgpu/KFD.
  2. Start a KFD application that allocates substantial VRAM
     (llama-server --model <19GB GGUF> -ngl 99; ROCm offload).
     Wait for it to finish initializing (serves inference).
  3. Stop it (SIGTERM/SIGKILL/systemctl stop) and start it again.
  4. During model VRAM allocation the new process blocks in
     kfd_ioctl_alloc_memory_of_gpu and never returns.

  Faster reproducer sketch (what llama init does): a fresh process does
  hsa_init -> acquire gfx906 node -> repeated hsaKmtAllocMemory +
  hsaKmtMapMemoryToGPU of large (1-4 GB) VRAM blocks. The wedged state
  is always entered via the first few alloc ioctls after process start.

=3D=3D Observed stacks (kernel 7.2.6, SysRq-w / /proc/<pid>/stack) =3D=3D

  Userspace process (llama-server, D state):

      __flush_work+0x2c4/0x3c0
      flush_work+0x1c/0x30
      svm_range_list_lock_and_flush_work+0x2f/0x100 [amdgpu]
      kfd_ioctl_alloc_memory_of_gpu+0x7c/0x3a0 [amdgpu]
      kfd_ioctl+0x408/0x640 [amdgpu]
      __x64_sys_ioctl+0xa5/0x100

  Concurrent kworker (D state, same boot):

      __flush_work+0x2c4/0x3c0
      flush_work+0x1c/0x30
      svm_range_list_lock_and_flush_work+0x2f/0x100 [amdgpu]
      svm_range_restore_work+0x75/0x3a0 [amdgpu]
      process_one_work+0x1a9/0x390
      worker_thread+0x1b8/0x360

  On 7.0.12-1-pve the userspace process was observed in:

      dma_fence_default_wait+0x87/0x2a0

=3D=3D Analysis =3D=3D

  svm_range_list_lock_and_flush_work() flushes svms->deferred_list_work
  then takes mmap_write_lock, retrying while deferred_range_list is
  non-empty. The observed state has BOTH the alloc path and
  svm_range_restore_work blocked in flush_work() on the same
  deferred_list_work =E2=80=94 i.e. the deferred work item can never comple=
te.

  Likely circular wait: svm_range_restore_work runs while KFD queues
  are suspended for eviction/restore; a queued deferred work item
  (migrate/map) needs GPU progress / a dma fence that requires those
  queues to run; restore_work waits for the deferred item to drain;
  the alloc path waits behind the same flush.

  Related prior work (this may be a remaining/unfixed variant):

    - CVE-2022-49133 / commit "drm/amdkfd: svm range restore work
      deadlock when process exit" =E2=80=94 fixed a different restore_work
      flush deadlock at process exit.
    - [PATCH] "drm/amdkfd: Fix the deadlock in svm_range_restore_work"
      (Emily Deng, amd-gfx, Feb 2025) =E2=80=94 mmap_write_downgrade() fix =
for
      restore_work vs svm_range_evict_svm_bo_worker.
    - [PATCH v2 3/3] "drm/amdkfd: Don't stuck in svm restore worker"
      (amd-gfx, Oct 2025) =E2=80=94 restore work retrying forever when the =
VMA
      is gone; the corresponding !vma unmap path does not appear to be
      present in current mainline kfd_svm.c.

=3D=3D What was ruled out =3D=3D

  - HSA_XNACK=3D0 does not avoid the deadlock (alloc path always enters
    svm_range_list_lock_and_flush_work regardless).
  - Not context-size/alloc-size specific: reproduces with an 8GB
    instead of 32GB context.
  - Not specific to the custom kernel: identical deadlock on stock
    7.0.12-1-pve and 6.17.13-13-pve builds.
  - kfdtest (ROCT-Thunk-Interface test suite) memory/queue tests all
    pass while a healthy KFD process holds the device =E2=80=94 the deadloc=
k
    specifically needs the process-teardown -> fresh-init sequence.
  - Hardware side: link stable at 40 Gb/s, card healthy =E2=80=94 the wedge
    reproduces with zero link events in dmesg.

=3D=3D Logs =3D=3D

  Full SysRq-w dumps, both blocked stacks, dmesg and llama-side logs
  attached / available on request (saved per-trial).

=3D=3D Notes for maintainers =3D=3D

  - The MI50 is attached via Thunderbolt (pciehp hotplug topology).
    If SVM restore work scheduling is influenced by hotplug-related
    eviction/fault paths, this setup may expose a timing window that
    does not exist on fixed PCIe. Happy to test patches =E2=80=94 reproduct=
ion
    takes ~5 minutes per trial on this machine.

--000000000000ff2065065c4e2f41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=3D=3D Summary =3D=3D<br><br>Restarting a KFD application =
reliably deadlocks the next instance during<br>its initial GPU memory alloc=
ations. Two threads block permanently:<br><br>=C2=A0 (a) the new userspace =
process in<br>=C2=A0 =C2=A0 =C2=A0 kfd_ioctl_alloc_memory_of_gpu -&gt; svm_=
range_list_lock_and_flush_work<br>=C2=A0 =C2=A0 =C2=A0 -&gt; flush_work -&g=
t; __flush_work =C2=A0 (D state)<br><br>=C2=A0 (b) a kworker running<br>=C2=
=A0 =C2=A0 =C2=A0 svm_range_restore_work -&gt; svm_range_list_lock_and_flus=
h_work<br>=C2=A0 =C2=A0 =C2=A0 -&gt; flush_work -&gt; __flush_work =C2=A0 (=
D state)<br><br>Both wait for svms-&gt;deferred_list_work, which never comp=
letes. On a<br>7.0.12 kernel the userspace side was instead observed blocke=
d in<br>dma_fence_default_wait, suggesting the deferred work item is itself=
<br>waiting on a dma fence that cannot complete (plausibly because it<br>re=
quires KFD queue progress while queues are suspended for<br>eviction/restor=
e). Once this state is reached, every subsequent<br>kfd_ioctl_alloc_memory_=
of_gpu queues behind the stuck flush; the<br>process cannot be killed (unin=
terruptible sleep) and the device is<br>unusable until reboot.<br><br>The t=
rigger is a KFD process teardown followed by a fresh KFD process<br>doing V=
RAM allocations =E2=80=94 i.e. simply restarting a ROCm/HIP application.<br=
>First start after boot succeeds; a restart wedges with high<br>probability=
 (observed ~70-100%).<br><br>This does NOT appear to be a regression: repro=
duced identically on<br>6.17.13, 7.0.12 and 7.2.6 (all Proxmox pve builds p=
lus one custom<br>config). Possibly long-standing; likely related to the un=
resolved<br>&quot;svm restore worker stuck&quot; issues discussed on amd-gf=
x in 2025.<br><br>=3D=3D Environment =3D=3D<br><br>=C2=A0 GPU: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0AMD Radeon Instinct MI50 32GB, gfx906, 0000:05:00.0<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Vega 20, PCIe, attached via =
Thunderbolt 3 eGPU enclosure,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 hotplug-capable PCI topology =E2=80=94 may be relevant since SVM<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eviction/restore work is t=
ied to hotplug/fault events)<br>=C2=A0 Host: =C2=A0 =C2=A0 =C2=A0 AMD Strix=
 Halo (Ryzen AI Max+ 395), Proxmox VE 9 host<br>=C2=A0 Kernels: =C2=A0 =C2=
=A06.17.13-13-pve, 7.0.12-1-pve, 7.2.6-k726 (custom config)<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=80=94 all affected<br>=C2=A0 Cmd=
line: =C2=A0 =C2=A0amdgpu.dc=3D0 modprobe.blacklist=3Damdxdna apparmor=3D0<=
br>=C2=A0 Userspace: =C2=A0llama.cpp llama-server (HIP/ROCm), hsakmt/ROCm s=
tack;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 any KFD client re=
start reproduces it<br>=C2=A0 Taint: =C2=A0 =C2=A0 =C2=A0512 (U =E2=80=94 u=
nsigned module loaded early at boot; no DKMS,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 no out-of-tree module in the KFD path)<br><br>=3D=
=3D Reproduction =3D=3D<br><br>=C2=A0 1. Boot the system with the MI50 boun=
d to amdgpu/KFD.<br>=C2=A0 2. Start a KFD application that allocates substa=
ntial VRAM<br>=C2=A0 =C2=A0 =C2=A0(llama-server --model &lt;19GB GGUF&gt; -=
ngl 99; ROCm offload).<br>=C2=A0 =C2=A0 =C2=A0Wait for it to finish initial=
izing (serves inference).<br>=C2=A0 3. Stop it (SIGTERM/SIGKILL/systemctl s=
top) and start it again.<br>=C2=A0 4. During model VRAM allocation the new =
process blocks in<br>=C2=A0 =C2=A0 =C2=A0kfd_ioctl_alloc_memory_of_gpu and =
never returns.<br><br>=C2=A0 Faster reproducer sketch (what llama init does=
): a fresh process does<br>=C2=A0 hsa_init -&gt; acquire gfx906 node -&gt; =
repeated hsaKmtAllocMemory +<br>=C2=A0 hsaKmtMapMemoryToGPU of large (1-4 G=
B) VRAM blocks. The wedged state<br>=C2=A0 is always entered via the first =
few alloc ioctls after process start.<br><br>=3D=3D Observed stacks (kernel=
 7.2.6, SysRq-w / /proc/&lt;pid&gt;/stack) =3D=3D<br><br>=C2=A0 Userspace p=
rocess (llama-server, D state):<br><br>=C2=A0 =C2=A0 =C2=A0 __flush_work+0x=
2c4/0x3c0<br>=C2=A0 =C2=A0 =C2=A0 flush_work+0x1c/0x30<br>=C2=A0 =C2=A0 =C2=
=A0 svm_range_list_lock_and_flush_work+0x2f/0x100 [amdgpu]<br>=C2=A0 =C2=A0=
 =C2=A0 kfd_ioctl_alloc_memory_of_gpu+0x7c/0x3a0 [amdgpu]<br>=C2=A0 =C2=A0 =
=C2=A0 kfd_ioctl+0x408/0x640 [amdgpu]<br>=C2=A0 =C2=A0 =C2=A0 __x64_sys_ioc=
tl+0xa5/0x100<br><br>=C2=A0 Concurrent kworker (D state, same boot):<br><br=
>=C2=A0 =C2=A0 =C2=A0 __flush_work+0x2c4/0x3c0<br>=C2=A0 =C2=A0 =C2=A0 flus=
h_work+0x1c/0x30<br>=C2=A0 =C2=A0 =C2=A0 svm_range_list_lock_and_flush_work=
+0x2f/0x100 [amdgpu]<br>=C2=A0 =C2=A0 =C2=A0 svm_range_restore_work+0x75/0x=
3a0 [amdgpu]<br>=C2=A0 =C2=A0 =C2=A0 process_one_work+0x1a9/0x390<br>=C2=A0=
 =C2=A0 =C2=A0 worker_thread+0x1b8/0x360<br><br>=C2=A0 On 7.0.12-1-pve the =
userspace process was observed in:<br><br>=C2=A0 =C2=A0 =C2=A0 dma_fence_de=
fault_wait+0x87/0x2a0<br><br>=3D=3D Analysis =3D=3D<br><br>=C2=A0 svm_range=
_list_lock_and_flush_work() flushes svms-&gt;deferred_list_work<br>=C2=A0 t=
hen takes mmap_write_lock, retrying while deferred_range_list is<br>=C2=A0 =
non-empty. The observed state has BOTH the alloc path and<br>=C2=A0 svm_ran=
ge_restore_work blocked in flush_work() on the same<br>=C2=A0 deferred_list=
_work =E2=80=94 i.e. the deferred work item can never complete.<br><br>=C2=
=A0 Likely circular wait: svm_range_restore_work runs while KFD queues<br>=
=C2=A0 are suspended for eviction/restore; a queued deferred work item<br>=
=C2=A0 (migrate/map) needs GPU progress / a dma fence that requires those<b=
r>=C2=A0 queues to run; restore_work waits for the deferred item to drain;<=
br>=C2=A0 the alloc path waits behind the same flush.<br><br>=C2=A0 Related=
 prior work (this may be a remaining/unfixed variant):<br><br>=C2=A0 =C2=A0=
 - CVE-2022-49133 / commit &quot;drm/amdkfd: svm range restore work<br>=C2=
=A0 =C2=A0 =C2=A0 deadlock when process exit&quot; =E2=80=94 fixed a differ=
ent restore_work<br>=C2=A0 =C2=A0 =C2=A0 flush deadlock at process exit.<br=
>=C2=A0 =C2=A0 - [PATCH] &quot;drm/amdkfd: Fix the deadlock in svm_range_re=
store_work&quot;<br>=C2=A0 =C2=A0 =C2=A0 (Emily Deng, amd-gfx, Feb 2025) =
=E2=80=94 mmap_write_downgrade() fix for<br>=C2=A0 =C2=A0 =C2=A0 restore_wo=
rk vs svm_range_evict_svm_bo_worker.<br>=C2=A0 =C2=A0 - [PATCH v2 3/3] &quo=
t;drm/amdkfd: Don&#39;t stuck in svm restore worker&quot;<br>=C2=A0 =C2=A0 =
=C2=A0 (amd-gfx, Oct 2025) =E2=80=94 restore work retrying forever when the=
 VMA<br>=C2=A0 =C2=A0 =C2=A0 is gone; the corresponding !vma unmap path doe=
s not appear to be<br>=C2=A0 =C2=A0 =C2=A0 present in current mainline kfd_=
svm.c.<br><br>=3D=3D What was ruled out =3D=3D<br><br>=C2=A0 - HSA_XNACK=3D=
0 does not avoid the deadlock (alloc path always enters<br>=C2=A0 =C2=A0 sv=
m_range_list_lock_and_flush_work regardless).<br>=C2=A0 - Not context-size/=
alloc-size specific: reproduces with an 8GB<br>=C2=A0 =C2=A0 instead of 32G=
B context.<br>=C2=A0 - Not specific to the custom kernel: identical deadloc=
k on stock<br>=C2=A0 =C2=A0 7.0.12-1-pve and 6.17.13-13-pve builds.<br>=C2=
=A0 - kfdtest (ROCT-Thunk-Interface test suite) memory/queue tests all<br>=
=C2=A0 =C2=A0 pass while a healthy KFD process holds the device =E2=80=94 t=
he deadlock<br>=C2=A0 =C2=A0 specifically needs the process-teardown -&gt; =
fresh-init sequence.<br>=C2=A0 - Hardware side: link stable at 40 Gb/s, car=
d healthy =E2=80=94 the wedge<br>=C2=A0 =C2=A0 reproduces with zero link ev=
ents in dmesg.<br><br>=3D=3D Logs =3D=3D<br><br>=C2=A0 Full SysRq-w dumps, =
both blocked stacks, dmesg and llama-side logs<br>=C2=A0 attached / availab=
le on request (saved per-trial).<br><br>=3D=3D Notes for maintainers =3D=3D=
<br><br>=C2=A0 - The MI50 is attached via Thunderbolt (pciehp hotplug topol=
ogy).<br>=C2=A0 =C2=A0 If SVM restore work scheduling is influenced by hotp=
lug-related<br>=C2=A0 =C2=A0 eviction/fault paths, this setup may expose a =
timing window that<br>=C2=A0 =C2=A0 does not exist on fixed PCIe. Happy to =
test patches =E2=80=94 reproduction<br>=C2=A0 =C2=A0 takes ~5 minutes per t=
rial on this machine.</div>

--000000000000ff2065065c4e2f41--
