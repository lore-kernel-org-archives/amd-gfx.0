Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4E5C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C3C10E9D8;
	Fri, 11 Jul 2025 09:08:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="NN7j0jT9";
	dkim-atps=neutral
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6313910E9D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:08:15 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-735b9d558f9so571640a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1752224894; x=1752829694; darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/XXJJhy+U3k5gvxPpccx42pN94/IU5yQe/HPwiapn7A=;
 b=NN7j0jT9NOFmD45Ok9eetFPKc2qAFB/E9zpBmwSi5E1yl+uuh/E7tLhh0IIzwmcPtE
 HK/OP2Wsj8TMycXqH6HZYQzeQ0wS08MnVpVZaiKRjKPsqxTdJe+/dDmjbTXu4CpFqgPD
 FHBrUmAiu8jufXem7lG0s7d/+2iyh62X3sOqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752224894; x=1752829694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XXJJhy+U3k5gvxPpccx42pN94/IU5yQe/HPwiapn7A=;
 b=IQlLuz2U8DRUAIXxG9kz1Z+Mu+phYfuyEzjy7nx4jqf4bl7Z0JzlGr2dblHJ0QC1b8
 0FAhoRag1C08qllP86kkaa9sITAd79AHqiAWgljss4gvwksHVF+CetwzC5ZUlfheNXtJ
 nsSRv6cO218pQyV2cI+7Vnp2jc//FQMyyo2C3adh+iZ5M7upYJgu0QLmB6EzVVk6yMkb
 YtPE7EqHK8DDrAay7eJfw94sgwU5aeZrb5VCOwl4L3MQ1p0N/BAQ5zFmrDji3eelf6qm
 yNdo8L1lYx2OQpA6Qh9sXSb9Z3D/8qpCQDEWfWfAJB4BitAYiHRuItHDxq3EtYXIUgid
 3t6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXncm5HtDx5nZX51i5gBJiVWWc8QReMdSKVl1D+wIvdk6LDFKfnK5LjK6lE0RqvSetZXk49ar4L@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc9TP11oW5RptM5iaW+90pocakgocImC4I/Cbe0jEthEwXQ5vQ
 1HkSKpdQGRuosEOX0SI2MZSVYrG/6phbiKv37uyLjNRdldTvE1nn+yMtCzjL8OJL8K2nXtV+qSz
 oHvgTtFZcRROBjovXAY8PHkLJiR4JBBtHZ0aY2cdR6Q==
X-Gm-Gg: ASbGncu9TuHye1/xgZ96dyO+ufYbW3GgPU24tSfrtCnf+ZeqrADD+9wUwr8b2F1+fRj
 NCi0yuHMy81/Irb9hCNQeUf7kJ6PgDZVhQJqnznop8scFvo794Hco5exO/yL2RUc9hPDcW/Q3qx
 xQY43/ciIjmhOnOHsRbT57mZoLagJRQTDizP+Ydbvfg6nbVParr8+frEQQp4vxuWFDyrxJlIYzj
 wc9wzb9eJfAvba3z07wkuYiTiVWqYoNSbnJJ4mJZYFkBU0=
X-Google-Smtp-Source: AGHT+IFcAouWMXXQM8B7V4KLQu1xy86l+CgTbd5aoZM72dZ/yi5Z4/4mq1o6lT3woytFmkQlDVSULy3tTQmzPTG2yOI=
X-Received: by 2002:a05:6808:16a9:b0:40b:1597:b2d1 with SMTP id
 5614622812f47-4150e31e356mr2108092b6e.17.1752224894172; Fri, 11 Jul 2025
 02:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <0a087cfd-bd4c-48f1-aa2f-4a3b12593935@oss.qualcomm.com>
In-Reply-To: <0a087cfd-bd4c-48f1-aa2f-4a3b12593935@oss.qualcomm.com>
From: Simona Vetter <simona.vetter@ffwll.ch>
Date: Fri, 11 Jul 2025 11:08:03 +0200
X-Gm-Features: Ac12FXy4nqEh1oT4fQDEt08bX866kDDeTYEZ2441A8ZY1XxQ_jSXmu0yOuXQu58
Message-ID: <CAKMK7uH7Hcviwyw2wZK=WVxcb4zBC+EKpsREhb4FHe_AxEi8gg@mail.gmail.com>
Subject: Re: WARNING: possible circular locking dependency detected:
 drm_client_dev_suspend() & radeon_suspend_kms()
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 "Nikula, Jani" <jani.nikula@linux.intel.com>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel <linux-kernel@vger.kernel.org>, 
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jul 10, 2025 at 04:43:02PM -0700, Jeff Johnson wrote:
> I'm trying to debug a hibernation issue with the ath12k driver, but to
> establish a baseline I started with Linus' current tree. I have the following
> enabled in my .config:
>
> CONFIG_PROVE_LOCKING=y
> CONFIG_PROVE_RAW_LOCK_NESTING=y
> CONFIG_PROVE_RCU=y
>
> As part of the baseline I observed the following:

On a very quick guess I'd bet on the drm_client conversion for i915 to
have broken something here. Adding more people.
-Sima


>
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ======================================================
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: WARNING: possible circular locking dependency detected
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 6.16.0-rc5+ #6 Not tainted
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ------------------------------------------------------
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: kworker/u16:13/3787 is trying to acquire lock:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ffff8881113e0308 (&dev->clientlist_mutex){+.+.}-{4:4}, at: drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            but task is already holding lock:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ffffffff8a2e4b80 (console_lock){+.+.}-{0:0}, at: radeon_suspend_kms+0x63b/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            which lock already depends on the new lock.
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            the existing dependency chain (in reverse order) is:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            -> #1 (console_lock){+.+.}-{0:0}:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        console_lock+0x8d/0x130
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_fb_helper_set_suspend_unlocked+0x10e/0x200 [drm_kms_helper]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_fbdev_client_suspend+0x24/0x30 [drm_client_lib]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_client_dev_suspend+0x138/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        i915_drm_suspend.isra.0+0x74/0x260 [i915]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        i915_pm_suspend+0x6b/0x90 [i915]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        pci_pm_suspend+0x1e3/0x4f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        dpm_run_callback+0xa0/0x100
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        device_suspend+0x41e/0xdc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_suspend+0x1d/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_run_entry_fn+0x96/0x3e0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        process_one_work+0x86e/0x14b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        worker_thread+0x5d0/0xfc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        kthread+0x375/0x750
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork+0x215/0x2f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork_asm+0x1a/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            -> #0 (&dev->clientlist_mutex){+.+.}-{4:4}:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        __lock_acquire+0x15b5/0x2ac0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        lock_acquire+0x154/0x2d0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        __mutex_lock+0x15f/0x12c0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        radeon_suspend_kms+0x648/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        pci_pm_suspend+0x1e3/0x4f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        dpm_run_callback+0xa0/0x100
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        device_suspend+0x41e/0xdc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_suspend+0x1d/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_run_entry_fn+0x96/0x3e0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        process_one_work+0x86e/0x14b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        worker_thread+0x5d0/0xfc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        kthread+0x375/0x750
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork+0x215/0x2f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork_asm+0x1a/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            other info that might help us debug this:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  Possible unsafe locking scenario:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        CPU0                    CPU1
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ----                    ----
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:   lock(console_lock);
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:                                lock(&dev->clientlist_mutex);
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:                                lock(console_lock);
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:   lock(&dev->clientlist_mutex);
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                             *** DEADLOCK ***
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 4 locks held by kworker/u16:13/3787:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #0: ffff888100dee148 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0xe97/0x14b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #1: ffff88813f22fd30 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x14b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #2: ffff8881049241b0 (&dev->mutex){....}-{4:4}, at: device_suspend+0x3bd/0xdc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #3: ffffffff8a2e4b80 (console_lock){+.+.}-{0:0}, at: radeon_suspend_kms+0x63b/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
>                                            stack backtrace:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: CPU: 0 UID: 0 PID: 3787 Comm: kworker/u16:13 Not tainted 6.16.0-rc5+ #6 PREEMPT(voluntary)
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Hardware name: Hewlett-Packard HP ZBook 14 G2/2216, BIOS M71 Ver. 01.31 02/24/2020
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Workqueue: async async_run_entry_fn
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Call Trace:
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  <TASK>
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  dump_stack_lvl+0x5b/0x80
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  print_circular_bug.cold+0x178/0x1be
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  check_noncircular+0x130/0x150
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? 0xffffffffc1600000
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? radeon_suspend_kms+0x63b/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  __lock_acquire+0x15b5/0x2ac0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  lock_acquire+0x154/0x2d0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_stack_trace_save+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? acpi_ut_release_mutex+0xba/0x150
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  __mutex_lock+0x15f/0x12c0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? add_lock_to_list+0x2c/0x1b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx___mutex_lock+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? lock_acquire+0x154/0x2d0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? radeon_suspend_kms+0x63b/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  drm_client_dev_suspend+0x37/0x250 [drm]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  radeon_suspend_kms+0x648/0x7d0 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_radeon_pmops_suspend+0x10/0x10 [radeon]
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  pci_pm_suspend+0x1e3/0x4f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_pci_pm_suspend+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  dpm_run_callback+0xa0/0x100
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_dpm_run_callback+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  device_suspend+0x41e/0xdc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_device_suspend+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_async_suspend+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  async_suspend+0x1d/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  async_run_entry_fn+0x96/0x3e0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  process_one_work+0x86e/0x14b0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_process_one_work+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? assign_work+0x16c/0x240
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  worker_thread+0x5d0/0xfc0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_worker_thread+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  kthread+0x375/0x750
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? ret_from_fork+0x1f/0x2f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? lock_release+0xc6/0x2a0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ret_from_fork+0x215/0x2f0
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ret_from_fork_asm+0x1a/0x30
> Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  </TASK>
>
> This doesn't seem to be the cause of the ath12k issue I'm debugging,
> but thought it worth mentioning since I only see one similar report
> on lore, and that didn't have any apparent follow-up:
> https://lore.kernel.org/all/20250202161048.373f89c0@yea/
>
> /jeff

--
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
