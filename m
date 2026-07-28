Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3A2C54F4C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 13:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425BC10E59C;
	Tue, 28 Jul 2026 13:16:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FCJ2pPG9";
	dkim-atps=neutral
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B415210E8F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 13:16:14 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-744e7be8b80so125140137.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 06:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244573; cv=none;
 d=google.com; s=arc-20260327;
 b=XUuumbBzXFT25u7aGK5VxUOiQsuYZlT6hpUtKXm1sX25arhcrEacdBsS/VQmiK4Mys
 JZfSseCzFv2sTLqMRhUbFh5qo0LXPXnnB4z2wxLMBWRDdxl9t7bUVHf8WDoAAMB7kdMT
 MPmWeevmASbB37X7HqTIsTogRqnRaqyu7jDAuhwuWadZT5PqZetVS303EOQyKgA8BgSd
 yjYUJE4SBe/Bb2FB7v6IkqMDM8UD+vYc0Pi4Dt0fmRo3FU9Iigqwb+wmsKSNVXudc486
 NSZEPG8iQVQy92IZD+1vF2EFzOe09Rr51DWi5631VZph0VKywl7piPMnF1X++y1tfdAn
 YRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N+wMACBSaEfqBTHaUE/2bmCOeGWhvGf/4mtYL4kGMBE=;
 fh=fwfR7/OPrelDGfJo9L5x1lERobsU+ZxufwPwPqpoevI=;
 b=ncN1E5LjmfkvkC43pKWjGSrsHYau82k3YRKyVr2gw/yEumt3+3xP2J1EXRs7BSgIAj
 DAtXSYNUbHXbWo1UyPJ1XbmClgqGcinoT48zP3IatLf3Z7oHcVtZqUho0X+2D/9xoP5u
 fTuaG4U2V5dBE5ivFy2lURiiXF4NE3+4QWvJG3vLfATbP5kqzDugFeNKdpjH9Nt8Zur+
 1DCp94d6nY4st0X9ikBzovWX6GbnmIZIn+mT9ZTa64vUEAus1Z4P0okWAFk/GxaR73dc
 VXsXIlyMoraEcVF59V6Pi2QV8CYaugGHAhHxP5Ouw8jL54SKd+SbJ/33ac7bGpECIu19
 jEAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785244573; x=1785849373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N+wMACBSaEfqBTHaUE/2bmCOeGWhvGf/4mtYL4kGMBE=;
 b=FCJ2pPG9uQuSz5Xpo/TxomniNAxgyfidXv67fuwk+V4EzSQ1+L1WsWttfczyfTJZyp
 t7E4PqPljzioxRrVY4wcFGKmhb3y44U10YQ2JTEgQhNI2Pti4LVxzAWzmeZkjOsLz77R
 z/9fx9fW+rLP1A1z3Ay5T580Z/rQ4qskeVuAxQhnhPLbh4ohgt5wbZSaWaGDeROGQH0M
 cynnTq8SrjxcwfxZAPmJ4ByX1qhXT/173zPYH8HUJk2Qd6aIVMy7oHQLeRGhJMT7Urkt
 Zwctu4HN8LIFvT2RMDjAI6IbcEmU5F0mi5piL5Y7xSrl1MubiMZo8oKkEt2fF3CcyHYt
 BuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244573; x=1785849373;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N+wMACBSaEfqBTHaUE/2bmCOeGWhvGf/4mtYL4kGMBE=;
 b=YB08Qe50xNYPbRx2P0ga27ZVSvjIeLP3sCQysReRitae3Cd1IFFJ92B2yOxm4KZ7MX
 X8NGtQnMGt0lYVx9qQnggPCMEvNeSxOJ5c89VO/kPFIp7tyapig93WgJH64w1afdE2wK
 IPgejOXumsEp4Dvnf/+vSKtYAoN4qbfyBZtvcCr/uCDU5rsH33N1ihmDHP3fzveBOV7/
 kB3qSubpE6SCTXkbjDg+2lte6oudSErElE1/rlm93XqIcWbipM0rheU7rNRGamezgZ/j
 ejLBO9xghoHTwYCfExA6awxCdxyPih6NmUTVA5Z/i4XOY7fvqkRWEjyBJ3mGlh1Hcezn
 zhLw==
X-Gm-Message-State: AOJu0Yw3VK+57BZV9TT/pQDwp8cgFd3CS2+izC+ERRrq7Duj81CX4yZF
 m73WpdUhoAKwiwgzjOJcHiii/0wIHa4s8AURn1nocDWs1hzFOFwpBCmfRHrlDiKCKS7JhV1oeI1
 VnOcxCWHl9oYu+luy8LGKtWWWfdIWsT8=
X-Gm-Gg: AR+sD12FASMpIsUiLaxkop2YogK3k8vy9Jw8j1gBSXc4wyiRfjNpb1h+5Cj/cJBvWfI
 JD4rcvp6PTVVDxonm+LKoEHYerczTRvpzKh6nwxvD9xmTX2WAqL+omgUCDCc+h4vkAWeoFmzc+X
 0zVDzqjvlK2w9V1HyoneCohl4BJbs9RlLpna4AIAo2SCb5a/P64VKjW/wwIl7pFaI43/PpO2Mq+
 30RCg3+Bg4UltJj+tms4RF8f9eM/IjyDnSZZIjDIOTSXM8fxuexZPdJEP21lx5SjpP2OvY2DAa5
 +j8OFEdLyOCdPV4yDR/vA06hVRlGfOC7Rc/QHX4QASxRX2E9UYjxrP0cDqSlsDkHdzFFGnHNLX8
 7Q7lbGdFJc4bvms6kTUUtxPc0sxWlCgA=
X-Received: by 2002:a05:6102:4405:b0:745:17b0:10cc with SMTP id
 ada2fe7eead31-754a1eaa48fmr376392137.4.1785244573368; Tue, 28 Jul 2026
 06:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <b911abf7-40df-445a-9c3a-403903c94920@gmail.com>
In-Reply-To: <b911abf7-40df-445a-9c3a-403903c94920@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jul 2026 09:16:00 -0400
X-Gm-Features: AUfX_mxJa_OE17OOC67gJOUfJ46TGvI7WafpRxJWHPSNgBPo2DXy-Aa6Mrj5ax0
Message-ID: <CADnq5_NW=5LFi6Rf9HYg1zgu5B6wEerQs9ErMD_y3m3GWvGS3Q@mail.gmail.com>
Subject: Re: [bug report] amdgpu/TTM: NULL/UAF deref in
 ttm_resource_manager_next
 during hibernation swapout (ttm_device_prepare_hibernation) on Phoenix APU
To: Bernardo <bernardomagri21@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jul 26, 2026 at 8:32=E2=80=AFPM Bernardo <bernardomagri21@gmail.com=
> wrote:
>
> Dear maintainers,
>
> Please find the bug report below. Thanks!
>
> Cheers,
> BM
>
>
> ## Summary
> Intermittent kernel oops (NULL/near-NULL deref) during hibernation *entry=
*, in the
> TTM GPU-memory eviction path invoked by amdgpu's freeze callback
> (ttm_device_prepare_hibernation -> ttm_bo_swapout -> LRU walk ->
> ttm_resource_manager_next). The oops occurs in the device-freeze phase, b=
efore the
> hibernation image is written, so the next boot reports "PM: Image not fou=
nd (code -22)"
> and the session is lost. On my machine oops=3Dpanic is set, so it escalat=
es to a full
> panic+reboot, but the underlying event is the NULL-deref oops shown below=
.

I think you are seeing this issue:
https://gitlab.freedesktop.org/drm/amd/-/work_items/5387
Please follow that ticket for the latest.

Alex

>
> ## Hardware
> - Lenovo ThinkPad T14s Gen 4 (MT 21F8CTO1WW), BIOS R2EET46W 1.27 (2025-09=
-24)
> - CPU/APU: AMD Ryzen 7 PRO 7840U (Phoenix)
> - GPU: integrated Radeon 780M, gfx_v11_0, PCI 1002:15bf (rev dd), subsyst=
em 17aa:50d8
>   - amdgpu reports "VRAM: 1024M ... (1024M used)" =E2=80=94 UMA carve-out=
, no discrete VRAM
> - Storage: NVMe; root on LUKS+BTRFS; hibernation to a BTRFS swapfile (res=
ume_offset set)
>
> ## Kernel
> - 7.1.4 (vanilla upstream; distro build tag "#1-NixOS PREEMPT(lazy)")
> - Taint: G O. The out-of-tree modules loaded are ddcci, ddcci_backlight, =
acpi_call,
>   v4l2loopback =E2=80=94 none appear in the backtrace and none touch TTM;=
 the taint is unrelated.
>
> ## Frequency / trigger
> Intermittent: 2 failures out of 5 hibernation attempts over 5 days (3 cle=
an successes
> with "PM: hibernation: hibernation exit"). Reproduces on both `systemctl =
hibernate` and
> systemd suspend-then-hibernate. Not correlated with a config change =E2=
=80=94 fails and succeeds
> on the same kernel. The intermittency is consistent with a race dependent=
 on GPU buffer
> residency at freeze time (see analysis).
>
> ## Backtrace (from efi-pstore; consoles were already suspended, so this i=
s what was captured)
> PM: hibernation: hibernation entry
> ...
> PM: hibernation: Allocated 12299604 kbytes in 7.45 seconds (1650.95 MB/s)
> Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> printk: Suspending console(s) (use no_console_suspend to debug)
> BUG: kernel NULL pointer dereference, address: 0000000000000268
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 2 UID: 0 PID: 1026678 Comm: kworker/u64:16 Tainted: G           O   =
     7.1.4 #1-NixOS PREEMPT(lazy)
> Hardware name: LENOVO 21F8CTO1WW/21F8CTO1WW, BIOS R2EET46W (1.27 ) 09/24/=
2025
> Workqueue: async async_run_entry_fn
> RIP: 0010:ttm_resource_manager_next+0x94/0x200 [ttm]
> RSP: 0018:ffffd0f08294fba0 EFLAGS: 00010202
> RAX: ffffd0f08294fc40 RBX: ffff8c0846d306a0 RCX: ffffd0f08294fc40
> RDX: ffffd0f08294fc40 RSI: ffffd0f08294fc40 RDI: ffffd0f08294fc40
> RBP: ffffd0f08294fc20 R08: 0000000000000001 R09: 0000000000000000
> R10: ffff8c029c30ed90 R11: ffff8c04001c6880 R12: 0000000000000020
> R13: ffffd0f08294fc40 R14: ffffd0f08294fcc0 R15: 0000000000000260
> CR2: 0000000000000268
> Call Trace:
>  <TASK>
>  __ttm_bo_lru_cursor_next+0x60/0x300 [ttm]
>  ttm_lru_walk_for_evict+0xde/0x1d0 [ttm]
>  ttm_bo_swapout+0x5c/0x80 [ttm]
>  ttm_device_prepare_hibernation+0x71/0xb0 [ttm]
>  amdgpu_device_evict_resources+0x62/0x80 [amdgpu]
>  amdgpu_device_suspend+0x13a/0x230 [amdgpu]
>  amdgpu_pmops_freeze+0x1e/0x70 [amdgpu]
>  pci_pm_freeze+0x5b/0xe0
>  dpm_run_callback+0x51/0x180
>  device_suspend+0x1aa/0x5d0
>  async_suspend+0x21/0x30
>  async_run_entry_fn+0x34/0x150
>  process_one_work+0x199/0x390
>  worker_thread+0x177/0x2e0
>  kthread+0xe2/0x110
>  ret_from_fork+0x251/0x330
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> Kernel panic - not syncing: Fatal exception   (because this host runs wit=
h oops=3Dpanic)
>
> ## Source observations (v7.1.4)
> Reading the faulting path in 7.1.4:
> - The swapout walk __ttm_bo_lru_cursor_next() (drivers/gpu/drm/ttm/ttm_bo=
_util.c)
>   drops the lru_lock (spin_unlock at ~line 1012) and re-acquires it (~lin=
e 1031). Its
>   own comment (~lines 1016-1022) notes that in that window "the resource =
may have been
>   freed and allocated again with a different memory type." On the next it=
eration it calls
>   ttm_resource_manager_next(&curs->res_curs) (~line 994).
> - ttm_resource_manager_next() (drivers/gpu/drm/ttm/ttm_resource.c:690) ha=
s no guard on
>   cursor->man / the LRU state, whereas its sibling ttm_resource_manager_f=
irst() (:673)
>   does (WARN_ON_ONCE(!man)). CR2=3D0x268 with what looks like a valid man=
ager in RBX
>   suggests the cursor walked into a freed/reallocated LRU entry rather th=
an a NULL
>   top-level manager =E2=80=94 i.e. a use-after-free/TOCTOU in the lock-dr=
opped walk.
> - This tree already contains the "move swapped objects off the manager's =
LRU list"
>   rework (ttm_resource_is_swapped(), the `unevictable` list), so that ear=
lier issue is
>   not the cause here.
> (These are just pointers for triage; I have not root-caused the exact fre=
ed object.)
