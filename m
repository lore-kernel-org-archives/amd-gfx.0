Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57C606A337
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CGC3MGf6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6FB610F366;
	Tue, 24 Nov 2026 08:40:32 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7941010EC71
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 02:33:25 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so37108555e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 18:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795487603; x=1796092403; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zy3mqG55kpY0PC+2xpbtvdORH9tINnqLVmz/lUjRKyM=;
 b=CGC3MGf64tME52bLKt6R/29QVBT7yeWMYgVM7ZDT+CSP6aSb3HBu2/5hB5errhmoZH
 MVSjmQ6V9WFEO/VbaebSenEgwHqZ+iVDsP0aqgqrljnlbPAEsOc65/28CyGoraRA6I0e
 EHLb3x7UREUk4/ea0gbZu6wjawRt4Yxh7IkPQ2KeizqKaXCv6BlBwa7e5RiP+wH7l+iT
 lutEJ7bCog/T3u8fZSDt3O6AUXV9x6cEMNGs5JEl/5DWE4JOxRuZqoa1JY0mtHnt3Vck
 GX8FqYpjV1WoAQ1cEXGYS2GTjeUjkZtBmlBW93E7xGcEXrmL8PRw/4hs8lDu3nJ6iyw6
 H7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795487603; x=1796092403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zy3mqG55kpY0PC+2xpbtvdORH9tINnqLVmz/lUjRKyM=;
 b=B3VTsn15ZFiaoL5mUEGL3BFq/0fyexW4RHFMzQ8hVDcuq+uNVoQdfJ4P3b9hfyigYO
 l4N5HIU5OJ14V/oZT4YNbbVjCkt5dKcSI9NfVhU7Ln1i/QIt+QM5VJvGi0Va6DykU7Bk
 U+9dYmWOr5zXaBhN/yDVO11lDkigHwYnmI9c405A6R5eU9y8dDYHeYKz+9aYATntH7Ng
 sPjw3LFL24bqTzsSzXlU80sSUmcU4PwX9Uxnqw4csAl13P5zG8pR5+qUv2AVO+hXEpH+
 cL/4fCK2BiFy+fRkvyEeXYSnVKt94R2gxxlJQ2CQJnIYoOsJMRdF6QbEzLPnlSiO1cHB
 +eoA==
X-Gm-Message-State: APuU4Z8b9k+VoBhp4DSgftMBObxpcn7Xz5Va02NJ7srLqZKvvN0FqJ+G
 hqy/4LatER8VIxUdgqWCXWjy3KXcYu62TAVBacZfi4YDC7fbPy3uUiHc2ijXZvii
X-Gm-Gg: AZFdTZfBw4uoIRjU9q0fysaK5y3X8QVTVEnsjEt/LLHgduJX3GbLqdXTd81xrLQeF2L
 DL4C688fhW+xwqnmLLoXbJtH+0QgwCTMIfkqIlaEAYBesvxQsWmIUzA/bb8veFhjBK7/XCP3u+G
 qWc1bLuxIs3WmobCt7x4OgpBPG4MS2s9hb/MuFnui4n4028+rYbyhIzF4gl0XrmBZ5tnuewtuXO
 5FjXgJsRGWEHeW2q/K9qiTfib7vK5dmcyRIUtHtLXz39l9ROiEldkUWJKFwx8hA4vdXwfv4fm69
 +sakP61Iqfsl0ii0j6N+6LVSpo8BMp3VwEupQIw3smt00mZwzVsEN1K983KhsfwLt9s9cBdFXCQ
 z39IXWrWPN/M2ZZaNCyV3JD95IyjwBOyWddNJ31bTU0Cuux+/ukxmSu+MSDWmcwiIACkHZGpQvr
 Ja0jaZv8TIO6utsAuBwqVGPwhQUE2mWMuHom1XIsgRL/tW9P3UKw/zKFOwvUhhdL+KO3/LO3+Xs
 4WYZMSNIjnDHVYfv+UVxTLNY0Xlj38eglKIXNkVSL931B68M212qmO7oVa64Ai1utn+sn7yMRyH
 /tcTdBa0ix1M3zWCBn5RJEeiZg5pzN+YMqCr4mJ52MxLuEMwVDYstabKo3zRb75C/xUrOoHKZJs
 FRb+YHqHkeXRcDHN1xqZTt4EX35+uGRbvd/6HXwTJX1Yn9w==
X-Received: by 2002:a05:600c:4585:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4bb8881b8e4mr271832805e9.17.1795487603425; 
 Mon, 23 Nov 2026 18:33:23 -0800 (PST)
Received: from localhost (2001-1ae9-5b-ad10-b3af-f37f-773f-f37e.ip6.tmcz.cz.
 [2001:1ae9:5b:ad10:b3af:f37f:773f:f37e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906635c7sm215637135e9.2.2026.11.23.18.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 18:33:22 -0800 (PST)
From: Arisa Snowbell <arisa.snowbell@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Arisa Snowbell <arisa.snowbell@gmail.com>
Subject: [PATCH 0/1] drm/amdgpu/userq: fix S3 suspend hang with user queues
Date: Tue, 24 Nov 2026 03:32:49 +0100
Message-ID: <cover.1795482456.git.arisa.snowbell@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:40:19 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I've been testing user queues on my RX 9070 XT (amdgpu.user_queue=1,
with AMD_USERQ=1 for everything I run through Steam) and came across a
suspend hang. After a few hours of uptime, S3 suspend sometimes never
finishes, and I have to reboot the machine by hand. What I see depends
on how the suspend started:

- When the screen locks in parallel with the suspend, the machine
  freezes on the lock screen.
- When it locks first, the screens turn off and the suspend starts
  after that, the screens stay off; the machine looks asleep but never
  wakes up.

Either way it never actually sleeps. Short sessions suspend and resume
fine.

In short: while amdgpu_device_prepare() evicts VRAM for suspend, the
user queue restore worker starts and moves the same BOs back. One
restore worker got stuck waiting on a page table update fence while
holding the BO locks, and the suspend waited for those locks forever.

The patch keeps the restore worker out of system sleep; the details are
in its commit message. It builds cleanly with W=1 against v7.4-rc4 and
passes checkpatch. I'm running it now: S3 suspend and resume work, also
with a game on user queues running, which keeps running after resume,
so the restore worker maps the queues again. It hasn't seen enough long
sessions with suspends yet to show that the hang is gone, so I'm sending
it for review first and will report back once I have more runtime on
it.

System:

  GPU:      RX 9070 XT, Navi 48 [1002:7550] rev c0, gfx12, MES fw 0x97
  Kernel:   7.4.0-rc4 (linux-mainline)
  Firmware: linux-firmware-amdgpu 20261019
  Mesa:     mesa-git 27.0.0_devel.234528.a54c80d04d3 (RADV)
  Options:  amdgpu ppfeaturemask=0xfff7ffff user_queue=1 runpm=0

What I saw:

The suspend started about 11 hours after boot and never finished. About
4 hours later I pressed SysRq w, s and c, and efi-pstore kept the dump.
22 tasks were blocked:

- systemd-sleep, in ttm_bo_evict_first() waiting for a BO lock
- 3 amdgpu_userq_restore_worker: one waiting on a page table update
  fence, two waiting for its locks
- 12 amdgpu_tlb_fence_work, waiting on their page table update fences
- 5 ttm_bo_delayed_delete, waiting on BO fences

All the workers except one TLB fence worker have higher PIDs than
systemd-sleep, so they started after the suspend did.

The earlier suspends of that boot worked. The only amdgpu error before
the hang was one "MES(1) failed to respond to msg=INVALIDATE_TLBS"
about 1.5 hours before it; the desktop kept working after it, and I
don't know if it's related.

systemd-sleep:

[31192.858314] task:systemd-sleep   state:D stack:0     pid:466006 tgid:466006 ppid:1      task_flags:0x80400100 flags:0x00080800
[31192.858315] Call Trace:
[31192.858315]  <TASK>
[31192.858315]  __schedule+0x400/0x1770
[31192.858317]  schedule+0x28/0xa0
[31192.858317]  schedule_preempt_disabled+0x16/0x30
[31192.858318]  __ww_mutex_lock.constprop.0+0x7cb/0xd40
[31192.858320]  ttm_bo_evict_first+0x14e/0x240 [ttm]
[31192.858323]  ? __pfx_pci_pm_prepare+0x10/0x10
[31192.858325]  ttm_resource_manager_evict_all+0x55/0x220 [ttm]
[31192.858329]  amdgpu_device_evict_resources+0x32/0x80 [amdgpu]
[31192.858430]  amdgpu_device_prepare+0x2f/0xe0 [amdgpu]
[31192.858532]  ? amdgpu_pmops_prepare+0x5b/0xb0 [amdgpu]
[31192.858632]  pci_pm_prepare+0x33/0x80
[31192.858633]  dpm_prepare+0x187/0x4e0
[31192.858635]  dpm_suspend_start+0x1e/0x60
[31192.858636]  suspend_devices_and_enter+0x131/0x8b0
[31192.858638]  pm_suspend.cold+0x2bc/0x336
[31192.858639]  state_store+0x7f/0xf0
[31192.858640]  kernfs_fop_write_iter+0x16b/0x210
[31192.858642]  vfs_write+0x258/0x540
[31192.858644]  ksys_write+0x7b/0x110
[31192.858645]  do_syscall_64+0xce/0x580
[31192.858647]  ? do_user_addr_fault+0x235/0x760
[31192.858648]  ? do_syscall_64+0x35/0x580
[31192.858649]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[31192.858662]  </TASK>

The stuck restore worker:

[31192.862190] task:kworker/0:12    state:D stack:0     pid:466979 tgid:466979 ppid:2      task_flags:0x4208060 flags:0x00080000
[31192.862191] Workqueue: events amdgpu_userq_restore_worker [amdgpu]
[31192.862307] Call Trace:
[31192.862307]  <TASK>
[31192.862307]  __schedule+0x400/0x1770
[31192.862309]  schedule+0x28/0xa0
[31192.862310]  schedule_timeout+0xce/0x120
[31192.862311]  dma_fence_default_wait+0x19b/0x2f0
[31192.862312]  ? __pfx_dma_fence_default_wait_cb+0x10/0x10
[31192.862313]  dma_fence_wait_timeout+0xee/0x1b0
[31192.862314]  amdgpu_userq_vm_validate_and_restore_queue+0x702/0x990 [amdgpu]
[31192.862432]  amdgpu_userq_restore_worker+0xb3/0x1a0 [amdgpu]
[31192.862547]  process_one_work+0x1d6/0x3b0
[31192.862548]  worker_thread+0x1aa/0x310
[31192.862549]  ? __pfx_worker_thread+0x10/0x10
[31192.862550]  kthread+0xe9/0x120
[31192.862551]  ? __pfx_kthread+0x10/0x10
[31192.862551]  ret_from_fork+0x2a9/0x340
[31192.862552]  ? __pfx_kthread+0x10/0x10
[31192.862552]  ret_from_fork_asm+0x1a/0x30
[31192.862554]  </TASK>

I can send the full pstore dump if it helps; the journal of that boot
has nothing beyond the MES timeout above. I'm also happy to test other
patches or collect more data.

Thanks,
Arisa

Arisa Snowbell (1):
  drm/amdgpu/userq: don't restore user queues during system sleep

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +++-
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 64 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  3 +
 5 files changed, 79 insertions(+), 4 deletions(-)

--
2.56.1

