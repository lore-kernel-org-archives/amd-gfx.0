Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A70DCA5FDD
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 06:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D0210E06A;
	Sat,  3 Oct 2026 06:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pokrzuQN";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5A910E06A
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 06:38:21 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so4013375e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791009499; x=1791614299; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gptdl29XQVXUrYC9sOehlbNisyhpwW6ythNDRLL1AJg=;
 b=pokrzuQNQ5WvvwSESgywNZ3novS5KKaeZR87zHe7JDbotH6QWU5Pg7kJu0VFgPzFau
 TPGMNe0y8Bu/rq2o2hlaf5veWsJWVLbcavL2aWEehLQOWKoiuN99cEFN1p8/XOhzQ0BS
 ObwhU8tVTJBb9N+SWhTLhPs7qvCmKBnBPcgxO9d8+e32DStektEyjT0jjq01hHmisedt
 3o/Oc2Ls9w3e8Vd94MZVngfDS8P4mUrj9ro2S6w8P3k9VxuU1h5wOEBroOJe5qweHkmp
 GBFejlt1nvy1zQ9EpubkwXahrWKDaXs2a+0/RsdLLqawoS6QIpVJ+VwtlKl7B/0+LSKe
 /SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791009499; x=1791614299;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gptdl29XQVXUrYC9sOehlbNisyhpwW6ythNDRLL1AJg=;
 b=IC7HRRI3euGeJijceIvpHV5OLiPiPP+ORp0nDGJZ70RcckUeIkvZQ+AceC7WUL7/Ng
 eVIm03JkzYz9Q43dg4ysjKQUxrE3bgtdmI8xKcqcN1zK4eZo0LxR2TeT60QLD94L/N1q
 x28fsh+wWpjqbs6eSHMeVW6ekISOHRQn+9lmK5DSssmqlZBvDLkg8crKWq6Yw0xtuX/0
 8nDGocyp1XnLBWVk55+RNR2xldD+dd4dyRleEvSMbX8D13CzJPDVpvc/f0lrwqVApsk0
 CtytGYXN7Lw2OaJ2wACud0jYzT7qEj4g7uFChvEdGBBIkhzsWFsaWfj4T+HxtmxkAngS
 KW1A==
X-Gm-Message-State: AFuF++k9uJWitUfn4x1uzCYsj5x3vuKFIyWHR7Vx4gpA0wJjcSxoUNxd
 gd2OuKmYIFmM5ksMbsKH3E6sfRz7JfZYEbbWLypvq9DZ3etlm8I8ZaWM36VgWg==
X-Gm-Gg: AYBFou3NIlMpKGkts6nMGMoiFKTVtdJA9WOIyjhEnqygUQWdyHr9mR/uKAorKwocPRl
 mkVzgdpRV1QH276LZ93PUYll3HKBjpOFLHMP3NwWP8MNBSNjYkFJOGaP7oWPkqQs5Hf2CzqWPMX
 seA7dTc+cC3A/WfPwS72CPMD00oKewAbGTVLHXBoB9QQ7jC7gPVSHlEfu9Ia/nJg12Oq+Jkyu4L
 BwgkEdM6FEAF23M4RmIG+ICKKWcyqj+wUs40xk4HpeTpgaXeAJSA6tspu+n5u7JvvoFMknKHjx9
 v4nlOdfwy1o9COzksO2rsGUF+hDBUUvRgRYz4CqOXXGJ+JWsULKnggu9Il5ErzqdhPioDprIEKj
 cp6bpnaxZCxFr9nzv9nyg+MOxx+BUBrjyii6HLy7yVoP+tV0PjXeh1MGQfOZkOuIRHMAO2lzFBO
 upNtyU8X556P1FGrgTaQG9nL+IjLz72SyOhtmSGMQo4s4aPWWw4nCnCHwiLXjCIsxXUNAUKMU6u
 Pn/6e4zRLUhZWW1zJgFZJKKj4aNcmg1QQsu9RFGStXz3lMugralg2CjtDNEmpeJIjnQ5tpsPR57
 qTIwmr84HhEiK35KYv9gI03kHEj2NOxRgS9TWPJW6AawP+biX+7w10Ijh1FY63B++wMotWx36HA
 ACyrwMR8KL2M5bTyqWitpZcTxzuLF6ug2B3+QsfcsyAsoUflFSsdEFla+O4akXQx5m3cWpOMMwZ
 i7Oaw+dSj+law73q4=
X-Received: by 2002:a05:600c:3155:b0:4a0:168f:d962 with SMTP id
 5b1f17b1804b1-4a1680b9cf4mr18906265e9.3.1791009499132; 
 Fri, 02 Oct 2026 23:38:19 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:416e:c95d:c72:8d01:9941:d6d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027735be1sm200215285e9.11.2026.10.02.23.38.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Oct 2026 23:38:18 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, felix.kuehling@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH 0/2] amdkfd: survive PCIe surprise removal with live KFD
 processes
Date: Sat,  3 Oct 2026 08:38:15 +0200
Message-ID: <20261003063817.36606-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Hi,

two small fixes for the KFD teardown path on PCIe surprise removal
(e.g. Thunderbolt eGPU link drop), observed on real hardware: an AMD
Instinct MI50 eGPU (Razer Core X, TB3) behind which a 19 GB ROCm
llama.cpp workload runs 24/7 with several KFD processes live.

Patch 1 fixes a NULL deref + unbounded wait in
kgd2kfd_teardown_processes(): on the disconnect path
amdgpu_amdkfd_device_fini_sw() frees adev->kfd.dev before
amdgpu_device_ip_fini_early() reaches teardown_processes, which then
dereferences adev->kfd.dev->kfd_processes_count. We captured the oops
in EFI pstore: NULL deref at +0x1b4 in the pciehp removal thread,
panic via panic_on_oops. The wait is also unbounded — processes
blocked on dead MMIO may never terminate, which wedges pciehp in
cond_resched() forever and cascades into hung-task/softlockup panics.

Patch 2 stops amdgpu_amdkfd_restore_userptr_worker() from rescheduling
itself forever when the device is gone: the VM update paths already
fail fast with -ENODEV on unplug (existing drm_dev_enter guards in
amdgpu_vm_update_pdes/vm_update_range), but the worker ignores the
error code. Observed: ~11k rescheduled restore cycles before the host
soft-locked up.

Both verified to apply and build against v7.3-rc5; observed and
debugged on 7.2.6 with the identical code shape. Pstore traces and the
full writeup are in our public repo:

  https://codeberg.org/kendoulov/linux-gfx906-kernel-patches
  docs/UPSTREAM-ISSUE-2-unplug-teardown.md

These are independent of the KFD SVM evict/restore work — this is the
hot-unplug ordering path added by the recent kfd hot-unplug support
(6cca686dfce7, d12d05c4bc4c). CCing Xiaogang who has been working in
this area.

Thanks,
Olivier Kaloudoff
