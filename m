Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A650F01819
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 08:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEB210EC9C;
	Fri,  6 Mar 2026 08:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iJ6KU0B9";
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAB310E2E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 01:50:39 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-66e3100515dso5165824eaf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 17:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772761839; x=1773366639; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bkFWDNzYpAaNf6nKTX9X2HQLMlJtuGjLEa5TVIf/IA4=;
 b=iJ6KU0B9xpJmpAsnoXuhKqsVAnPEzYjYgty+P0/JMZMxUvgkTOAkk6kUG8Dx+JQaUD
 OthHA9qZiFXu4hXIVQH9U7RLpVHmi/WsCikVQuDwLvJCjgJjiZqMIJZ+Tf8XejENNKrO
 JTKhfcx4bKMclqFOKKiwrG6LdOju3iW9pkv/KwKoQ9lShGZgzU3gep+mG8T6wTCghQqL
 1zrEZ80GgQHIi/GVfccTOUYrQVwm/rUNSjjF5ObN5aoKrrpFsWfsjgj8DbJOpjwKZLsV
 N2zjXz7GpfLcOH865jrEuIJxZsRPYmq9b1w9X57RFzG0hpCGqQOqEKEGlipFTS5l0x9Y
 aToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772761839; x=1773366639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkFWDNzYpAaNf6nKTX9X2HQLMlJtuGjLEa5TVIf/IA4=;
 b=v9IU1DzYgty+AKk1wEIo4pNBEqJhraZa8GwJivOzgNURbKKHdiJmNkq0lvY6HPVAJ3
 3QBcdS/kUZmQLigPl+AJBGI2N/yPTCRxMIW9XbWMCiZaX4uptU5Aq6SEaii5mPx+RxyQ
 2XHnWssEAkwIPlTY97/2geLIU2nMKax+IZl7SkRbdE1AKijPkVBudiJJt1RsaVdkg/Yq
 h5VSHj6TWV0aixy08wGB0Ak4wB8Iay/xtxIyqACgFH5wTA9tFTlBhwYw6rPuOK44pM0E
 niI6579AlXKIcot0FVhbHThCyrsCl5MgGVDl38uD1hw/VMkx0c3+GHepJIPAur2OjyEC
 dQjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf6tVqAODZ4pS3q/Sq5xzSxZF34dGI9zA2kgq0Ava+G1DfndT+ELZhBAWgv/H+GX/uQB7sXxan@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0b2DzWEoWWEczWjToB8jatTt7vACaVH4MQlDPHSRGWZeEgUH+
 yutXyWdzVsffPhmck/qC6yj0/rFWr+5Zz8ppCdYgyengx4XTVTyWtCMp3JGnjg==
X-Gm-Gg: ATEYQzyyAPMo28a1RZD0dXOxELTYGe4xrL/UGAD45uRLd8n/m0YyDjAhdGR457WCyLf
 Gnsrk/okRkIkrD9iQ3OnNdRYIwmMEHcIatlTEqkqd1aNGkPrUP8Wdp0G58PoK+JRmAZwH9/X13u
 4qZ7w/CrvkrNJMtwdo5hqJ4GRKEAOeMzG/HObjxNTrOkoG9J7/Ec6LnBOvl3TFrTSCcVBuocR3L
 NSaLzy6A9KmigtWsjH+oyflz1J0+/zJR2oreKP4CL0MYQnoYO5z+D3eZrTsqeUnb8O8KVhFKEji
 inBxLCmHRrt0ROAbMCUhxDMliFSN6ieEGmHbKP4EtLBjpiushyeJepfgFogBkABIKSBQyvdpGRx
 VdJOPsOY5uqxIdbcYqVH+2pqBLw4Z/ZsEBDfWXPXdr+lNUBAmSqmSK9skQTVGXj4P8UcvflCg7u
 KIxp9YQOxpiWvsOjEuMFQ7i7coHi0kAScr+MSJ9dy3z/xmajhk
X-Received: by 2002:a05:6820:4487:b0:679:96f:3f11 with SMTP id
 006d021491bc7-67b9bd4c44bmr385436eaf.64.1772761838800; 
 Thu, 05 Mar 2026 17:50:38 -0800 (PST)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 006d021491bc7-67b9cc1a627sm115245eaf.6.2026.03.05.17.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 17:50:38 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 0/7] queued static-key API reduces IPIs to 134/16154 in
 dyndbg 
Date: Thu,  5 Mar 2026 18:50:03 -0700
Message-ID: <20260306015022.1940986-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Mar 2026 08:52:54 +0000
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

This patchset formalizes and exposes the internal
architecture-specific arch_jump_label_transform_queue API as a public
kernel interface (static_key_*_queued).

Currently, dynamic_debug toggles static keys individually, which
triggers a machine-wide synchronization (IPI) for every callsite.
This causes $O(N)$ overhead.

By using the new queued API, (which also adds an insert-sort to the
queue) dynamic_debug can now toggle up to 256 sites (x86 queue length)
with a single IPI.

Without the sort, dyndbg saw a far more modest IPI reduction; ~6k/16k.
Ordered descriptors does not insure ordered patch-addresses.
Currently, only x86 has the sort.

I tested on virtme-ng, using:

  echo +p > /proc/dynamic_debug/control
  echo -p > /proc/dynamic_debug/control

With this patch and test, IPIs reduced to 134 from 16154.

Patchset also changes virtio.c to use pr_debug_ratelimited() instead
of pr_debug(), which otherwise flooded my test-setup, obscuring
results.

serial_core.c also gets 1 _ratelimited() change, though I didnt see
them in my setup, and likely missed a few conversion candidates.

Patchset also includes a new query-cmd syntax for dyndbg:

  echo 'module !virtio* +p' > /proc/dynamic_debug/control
  echo -p > /proc/dynamic_debug/control

It further reduced the console output, so might have sufficient
utility for eventual inclusion, despite lacking and/or logic.

The patch hoisting the static_key_apply_queued() out of
ddebug_change() up to ddebug_exec_queries() does nothing in this case,
and would only affect multi-queries:

  echo 'module !virtio* +p ; module serial -p' > /proc/dynamic_debug/control

ISTM such queries are currently rare, but could be leveraged in
classmap-params, to optimize drm.debug=0x1ff, which currently would
get one query-command per bit (12+ IPIs).

DRM is the biggest potential beneficiary of this:

root@drm-misc-fixes-2026-02-26-78-g535e886b182f:/home/jimc/projects/lx/wk-D/b0-dd-drm-all# modprobe i915
[   20.405557] dyndbg:  25 debug prints in module i2c_core
[   20.459373] dyndbg: 340 debug prints in module drm
[   20.459851] ACPI: bus type drm_connector registered
[   20.471366] dyndbg:  89 debug prints in module drm_kms_helper
[   20.482336] dyndbg: 155 debug prints in module drm_display_helper
[   20.496153] dyndbg:   2 debug prints in module ttm
[   21.136619] dyndbg: 1801 debug prints in module i915
root@drm-misc-fixes-2026-02-26-78-g535e886b182f:/home/jimc/projects/lx/wk-D/b0-dd-drm-all# modprobe amdgpu
[   32.907485] dyndbg: 4532 debug prints in module amdgpu


Jim Cromie (7):
  jump_label: expose queueing API for batched static key updates
  virtio: use pr_debug_ratelimited to avoid flooding
  drivers/tty/serial/serial_core: ratelimit uart_wait_until_sent
  dyndbg: use static-key queueing API in dynamic-debug
  dyndbg: hoist static_key_apply_queued up
  lib/dynamic_debug: add negation support to queries
  dyndbg-test: test keyword !value negation

 arch/Kconfig                                  |   3 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/kernel/alternative.c                 |  50 ++++---
 arch/x86/kernel/jump_label.c                  |  13 +-
 drivers/tty/serial/serial_core.c              |   4 +-
 drivers/virtio/virtio_ring.c                  |  12 +-
 include/linux/jump_label.h                    |  24 ++++
 kernel/jump_label.c                           | 125 ++++++++++++++++--
 lib/dynamic_debug.c                           |  88 ++++++++----
 .../dynamic_debug/dyndbg_selftest.sh          |  35 +++++
 10 files changed, 290 insertions(+), 65 deletions(-)

-- 
2.53.0

