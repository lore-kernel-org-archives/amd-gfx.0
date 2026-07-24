Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A9DC5321C
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 00:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7BE810E251;
	Mon, 27 Jul 2026 00:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dN0bWrDM";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B3110E072
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 18:07:50 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so5010375e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784916469; x=1785521269; darn=lists.freedesktop.org;
 h=subject:from:cc:to:content-language:user-agent:mime-version:date
 :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s87tuSaybc7Tx/AOhk/Zot7/9otXE0zqSCjkVZeHwIQ=;
 b=dN0bWrDMchEMl1FhLc/9riTKFjEJnECXMcbqXy1DJORv8SuGyqn5aMl+bUa7XGhF9O
 f3a4+jaa7OCsUB5IWQ6kl8bIWVj/E9l2HUvAmCqhJhIACzui3RSmRGheLiFlGYx+v/Sj
 qvaH6HVXlk2aaE2R0234Jf5mbxesioPN/kKIiouyzUolgLe7AgYxX4c2GvEd1Q7+65Pd
 cQGhx2No4XbccIRNmKoi9bb5uMObsO3kxn4tgz5mRhwVoolUHODnfhiRwqLJd46iJBUe
 AMwmkDCx3hYNp2nwY5OnTe6CnHnzaUjGOKdl46jnI2ujZo8IF8HuVcJfkpjaModn/Yy7
 R8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784916469; x=1785521269;
 h=subject:from:cc:to:content-language:user-agent:mime-version:date
 :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s87tuSaybc7Tx/AOhk/Zot7/9otXE0zqSCjkVZeHwIQ=;
 b=blHu9egB6+sVUIP8ef99bDu9wjFmdLBwbeNMKSAfKcN8mV3rkFMII17EVdEP+fimYA
 1GUzridxB09eQqcLuEqRt4NZWReySIzw0t5+s8nwkmvRSmoJ/s8Jxu247aXoMv17674/
 KRuVVFRyHrlhgqpGNdTXPb8bByU8Odz2Lu/+/hM59EViD10ZxTukVgxuQ0uGhqpxj/zs
 HhkCAgGt7SPhFoSrop13FnFQJ6K8B+XwsHDjAaDhKNIvENsk/V7LTlH5wT7RiTgeXxjd
 AURBqRLtwR3+hgV3EjLoaOf2uAp7zNymcZdX2FsSNfq08BgjKtcI1ctciG6kYk22z6aO
 LXbA==
X-Gm-Message-State: AOJu0YwWRvhGiOOke9skrNK+62iFUfiSD4KrlVxWvoaH7zHQIT/CcZEP
 UKPKGvRgIZtUjYGTiXBye8LnLLZYiKyhDHcFr0920sDB7Cxnwq1iV1zi5H7LEhqgRAk=
X-Gm-Gg: AR+sD13r8CmBbrsBRvFf6XHnURbbnIPKeIyTYs0Gd25GqpdFaWDFv+ny4HJFGcmpI+d
 r9YhMlkJFEFPXvAj1dJ3uQ5KPKbvn4tatOzG/7jXhSJgjC6Hw5azz1sRKj2G+CNrchzyYBgwNng
 0KI/8JT0mIno81b9KVEZcoCeAIZgKNv74mimPQRM2IAgYb1XvXON4oUkF8FRVmcqRrVVaP81qmQ
 mQfO8YTecB3nXE19dWlMTfc8L/tgxBj1LnASr7QZQZjKM4C8FdTRPqqCg0JLu9mrAeFeB8hdX85
 VdCLi4FVDtMp7vWez2th2kFtpMzgyPxdIKxhKLA+k0mUK7sVlTgh1PWgc6TtJtH5TvsFQR58Lbo
 3A/wPzu5uXlr/RlyQW/ATIEK43W5ynnL0lf3wHhPEmAuPgakjXL5GaULiOCQuMu3FmqmHwbh8rn
 /b6onqK6uRJNob
X-Received: by 2002:a05:600c:524f:b0:495:4cb6:71c3 with SMTP id
 5b1f17b1804b1-49573d291d2mr98006425e9.39.1784916468463; 
 Fri, 24 Jul 2026 11:07:48 -0700 (PDT)
Received: from [192.168.1.26] ([88.97.178.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b49a6e17sm7207895e9.13.2026.07.24.11.07.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 11:07:46 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------h6CQ7SgtopYp2vlAXn0Dto5t"
Message-ID: <b911abf7-40df-445a-9c3a-403903c94920@gmail.com>
Date: Fri, 24 Jul 2026 19:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
From: Bernardo <bernardomagri21@gmail.com>
Subject: [bug report] amdgpu/TTM: NULL/UAF deref in ttm_resource_manager_next
 during hibernation swapout (ttm_device_prepare_hibernation) on
 Phoenix APU
X-Mailman-Approved-At: Mon, 27 Jul 2026 00:23:38 +0000
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

This is a multi-part message in MIME format.
--------------h6CQ7SgtopYp2vlAXn0Dto5t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear maintainers,

Please find the bug report below. Thanks!

Cheers,
BM


## Summary
Intermittent kernel oops (NULL/near-NULL deref) during hibernation 
*entry*, in the
TTM GPU-memory eviction path invoked by amdgpu's freeze callback
(ttm_device_prepare_hibernation -> ttm_bo_swapout -> LRU walk ->
ttm_resource_manager_next). The oops occurs in the device-freeze phase, 
before the
hibernation image is written, so the next boot reports "PM: Image not 
found (code -22)"
and the session is lost. On my machine oops=panic is set, so it 
escalates to a full
panic+reboot, but the underlying event is the NULL-deref oops shown below.

## Hardware
- Lenovo ThinkPad T14s Gen 4 (MT 21F8CTO1WW), BIOS R2EET46W 1.27 
(2025-09-24)
- CPU/APU: AMD Ryzen 7 PRO 7840U (Phoenix)
- GPU: integrated Radeon 780M, gfx_v11_0, PCI 1002:15bf (rev dd), 
subsystem 17aa:50d8
   - amdgpu reports "VRAM: 1024M ... (1024M used)" — UMA carve-out, no 
discrete VRAM
- Storage: NVMe; root on LUKS+BTRFS; hibernation to a BTRFS swapfile 
(resume_offset set)

## Kernel
- 7.1.4 (vanilla upstream; distro build tag "#1-NixOS PREEMPT(lazy)")
- Taint: G O. The out-of-tree modules loaded are ddcci, ddcci_backlight, 
acpi_call,
   v4l2loopback — none appear in the backtrace and none touch TTM; the 
taint is unrelated.

## Frequency / trigger
Intermittent: 2 failures out of 5 hibernation attempts over 5 days (3 
clean successes
with "PM: hibernation: hibernation exit"). Reproduces on both `systemctl 
hibernate` and
systemd suspend-then-hibernate. Not correlated with a config change — 
fails and succeeds
on the same kernel. The intermittency is consistent with a race 
dependent on GPU buffer
residency at freeze time (see analysis).

## Backtrace (from efi-pstore; consoles were already suspended, so this 
is what was captured)
PM: hibernation: hibernation entry
...
PM: hibernation: Allocated 12299604 kbytes in 7.45 seconds (1650.95 MB/s)
Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
printk: Suspending console(s) (use no_console_suspend to debug)
BUG: kernel NULL pointer dereference, address: 0000000000000268
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 2 UID: 0 PID: 1026678 Comm: kworker/u64:16 Tainted: G    O        
7.1.4 #1-NixOS PREEMPT(lazy)
Hardware name: LENOVO 21F8CTO1WW/21F8CTO1WW, BIOS R2EET46W (1.27 ) 
09/24/2025
Workqueue: async async_run_entry_fn
RIP: 0010:ttm_resource_manager_next+0x94/0x200 [ttm]
RSP: 0018:ffffd0f08294fba0 EFLAGS: 00010202
RAX: ffffd0f08294fc40 RBX: ffff8c0846d306a0 RCX: ffffd0f08294fc40
RDX: ffffd0f08294fc40 RSI: ffffd0f08294fc40 RDI: ffffd0f08294fc40
RBP: ffffd0f08294fc20 R08: 0000000000000001 R09: 0000000000000000
R10: ffff8c029c30ed90 R11: ffff8c04001c6880 R12: 0000000000000020
R13: ffffd0f08294fc40 R14: ffffd0f08294fcc0 R15: 0000000000000260
CR2: 0000000000000268
Call Trace:
  <TASK>
  __ttm_bo_lru_cursor_next+0x60/0x300 [ttm]
  ttm_lru_walk_for_evict+0xde/0x1d0 [ttm]
  ttm_bo_swapout+0x5c/0x80 [ttm]
  ttm_device_prepare_hibernation+0x71/0xb0 [ttm]
  amdgpu_device_evict_resources+0x62/0x80 [amdgpu]
  amdgpu_device_suspend+0x13a/0x230 [amdgpu]
  amdgpu_pmops_freeze+0x1e/0x70 [amdgpu]
  pci_pm_freeze+0x5b/0xe0
  dpm_run_callback+0x51/0x180
  device_suspend+0x1aa/0x5d0
  async_suspend+0x21/0x30
  async_run_entry_fn+0x34/0x150
  process_one_work+0x199/0x390
  worker_thread+0x177/0x2e0
  kthread+0xe2/0x110
  ret_from_fork+0x251/0x330
  ret_from_fork_asm+0x1a/0x30
  </TASK>
Kernel panic - not syncing: Fatal exception   (because this host runs 
with oops=panic)

## Source observations (v7.1.4)
Reading the faulting path in 7.1.4:
- The swapout walk __ttm_bo_lru_cursor_next() 
(drivers/gpu/drm/ttm/ttm_bo_util.c)
   drops the lru_lock (spin_unlock at ~line 1012) and re-acquires it 
(~line 1031). Its
   own comment (~lines 1016-1022) notes that in that window "the 
resource may have been
   freed and allocated again with a different memory type." On the next 
iteration it calls
   ttm_resource_manager_next(&curs->res_curs) (~line 994).
- ttm_resource_manager_next() (drivers/gpu/drm/ttm/ttm_resource.c:690) 
has no guard on
   cursor->man / the LRU state, whereas its sibling 
ttm_resource_manager_first() (:673)
   does (WARN_ON_ONCE(!man)). CR2=0x268 with what looks like a valid 
manager in RBX
   suggests the cursor walked into a freed/reallocated LRU entry rather 
than a NULL
   top-level manager — i.e. a use-after-free/TOCTOU in the lock-dropped 
walk.
- This tree already contains the "move swapped objects off the manager's 
LRU list"
   rework (ttm_resource_is_swapped(), the `unevictable` list), so that 
earlier issue is
   not the cause here.
(These are just pointers for triage; I have not root-caused the exact 
freed object.)

--------------h6CQ7SgtopYp2vlAXn0Dto5t
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p>Dear maintainers,</p>
    <p>Please find the bug report below. Thanks!</p>
    <p>Cheers,<br>
      BM</p>
    <p><br>
      ## Summary<br>
      Intermittent kernel oops (NULL/near-NULL deref) during hibernation
      *entry*, in the<br>
      TTM GPU-memory eviction path invoked by amdgpu's freeze callback<br>
      (ttm_device_prepare_hibernation -&gt; ttm_bo_swapout -&gt; LRU
      walk -&gt;<br>
      ttm_resource_manager_next). The oops occurs in the device-freeze
      phase, before the<br>
      hibernation image is written, so the next boot reports "PM: Image
      not found (code -22)"<br>
      and the session is lost. On my machine oops=panic is set, so it
      escalates to a full<br>
      panic+reboot, but the underlying event is the NULL-deref oops
      shown below.<br>
      <br>
      ## Hardware<br>
      - Lenovo ThinkPad T14s Gen 4 (MT 21F8CTO1WW), BIOS R2EET46W 1.27
      (2025-09-24)<br>
      - CPU/APU: AMD Ryzen 7 PRO 7840U (Phoenix)<br>
      - GPU: integrated Radeon 780M, gfx_v11_0, PCI 1002:15bf (rev dd),
      subsystem 17aa:50d8<br>
        - amdgpu reports "VRAM: 1024M ... (1024M used)" — UMA carve-out,
      no discrete VRAM<br>
      - Storage: NVMe; root on LUKS+BTRFS; hibernation to a BTRFS
      swapfile (resume_offset set)<br>
      <br>
      ## Kernel<br>
      - 7.1.4 (vanilla upstream; distro build tag "#1-NixOS
      PREEMPT(lazy)")<br>
      - Taint: G O. The out-of-tree modules loaded are ddcci,
      ddcci_backlight, acpi_call,<br>
        v4l2loopback — none appear in the backtrace and none touch TTM;
      the taint is unrelated.<br>
      <br>
      ## Frequency / trigger<br>
      Intermittent: 2 failures out of 5 hibernation attempts over 5 days
      (3 clean successes<br>
      with "PM: hibernation: hibernation exit"). Reproduces on both
      `systemctl hibernate` and<br>
      systemd suspend-then-hibernate. Not correlated with a config
      change — fails and succeeds<br>
      on the same kernel. The intermittency is consistent with a race
      dependent on GPU buffer<br>
      residency at freeze time (see analysis).<br>
      <br>
      ## Backtrace (from efi-pstore; consoles were already suspended, so
      this is what was captured)<br>
      PM: hibernation: hibernation entry<br>
      ...<br>
      PM: hibernation: Allocated 12299604 kbytes in 7.45 seconds
      (1650.95 MB/s)<br>
      Freezing remaining freezable tasks completed (elapsed 0.001
      seconds)<br>
      printk: Suspending console(s) (use no_console_suspend to debug)<br>
      BUG: kernel NULL pointer dereference, address: 0000000000000268<br>
      #PF: supervisor read access in kernel mode<br>
      #PF: error_code(0x0000) - not-present page<br>
      PGD 0 P4D 0<br>
      Oops: 0000 [#1] SMP NOPTI<br>
      CPU: 2 UID: 0 PID: 1026678 Comm: kworker/u64:16 Tainted: G       
         O        7.1.4 #1-NixOS PREEMPT(lazy)<br>
      Hardware name: LENOVO 21F8CTO1WW/21F8CTO1WW, BIOS R2EET46W (1.27 )
      09/24/2025<br>
      Workqueue: async async_run_entry_fn<br>
      RIP: 0010:ttm_resource_manager_next+0x94/0x200 [ttm]<br>
      RSP: 0018:ffffd0f08294fba0 EFLAGS: 00010202<br>
      RAX: ffffd0f08294fc40 RBX: ffff8c0846d306a0 RCX: ffffd0f08294fc40<br>
      RDX: ffffd0f08294fc40 RSI: ffffd0f08294fc40 RDI: ffffd0f08294fc40<br>
      RBP: ffffd0f08294fc20 R08: 0000000000000001 R09: 0000000000000000<br>
      R10: ffff8c029c30ed90 R11: ffff8c04001c6880 R12: 0000000000000020<br>
      R13: ffffd0f08294fc40 R14: ffffd0f08294fcc0 R15: 0000000000000260<br>
      CR2: 0000000000000268<br>
      Call Trace:<br>
       &lt;TASK&gt;<br>
       __ttm_bo_lru_cursor_next+0x60/0x300 [ttm]<br>
       ttm_lru_walk_for_evict+0xde/0x1d0 [ttm]<br>
       ttm_bo_swapout+0x5c/0x80 [ttm]<br>
       ttm_device_prepare_hibernation+0x71/0xb0 [ttm]<br>
       amdgpu_device_evict_resources+0x62/0x80 [amdgpu]<br>
       amdgpu_device_suspend+0x13a/0x230 [amdgpu]<br>
       amdgpu_pmops_freeze+0x1e/0x70 [amdgpu]<br>
       pci_pm_freeze+0x5b/0xe0<br>
       dpm_run_callback+0x51/0x180<br>
       device_suspend+0x1aa/0x5d0<br>
       async_suspend+0x21/0x30<br>
       async_run_entry_fn+0x34/0x150<br>
       process_one_work+0x199/0x390<br>
       worker_thread+0x177/0x2e0<br>
       kthread+0xe2/0x110<br>
       ret_from_fork+0x251/0x330<br>
       ret_from_fork_asm+0x1a/0x30<br>
       &lt;/TASK&gt;<br>
      Kernel panic - not syncing: Fatal exception   (because this host
      runs with oops=panic)<br>
      <br>
      ## Source observations (v7.1.4)<br>
      Reading the faulting path in 7.1.4:<br>
      - The swapout walk __ttm_bo_lru_cursor_next()
      (drivers/gpu/drm/ttm/ttm_bo_util.c)<br>
        drops the lru_lock (spin_unlock at ~line 1012) and re-acquires
      it (~line 1031). Its<br>
        own comment (~lines 1016-1022) notes that in that window "the
      resource may have been<br>
        freed and allocated again with a different memory type." On the
      next iteration it calls<br>
        ttm_resource_manager_next(&amp;curs-&gt;res_curs) (~line 994).<br>
      - ttm_resource_manager_next()
      (drivers/gpu/drm/ttm/ttm_resource.c:690) has no guard on<br>
        cursor-&gt;man / the LRU state, whereas its sibling
      ttm_resource_manager_first() (:673)<br>
        does (WARN_ON_ONCE(!man)). CR2=0x268 with what looks like a
      valid manager in RBX<br>
        suggests the cursor walked into a freed/reallocated LRU entry
      rather than a NULL<br>
        top-level manager — i.e. a use-after-free/TOCTOU in the
      lock-dropped walk.<br>
      - This tree already contains the "move swapped objects off the
      manager's LRU list"<br>
        rework (ttm_resource_is_swapped(), the `unevictable` list), so
      that earlier issue is<br>
        not the cause here.<br>
      (These are just pointers for triage; I have not root-caused the
      exact freed object.)</p>
  </body>
  <lt-container></lt-container>
</html>

--------------h6CQ7SgtopYp2vlAXn0Dto5t--
