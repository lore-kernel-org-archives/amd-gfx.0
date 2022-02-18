Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5579AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F86D10F128;
	Fri, 18 Feb 2022 15:25:54 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5F010EA96
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 07:57:54 +0000 (UTC)
Received: by mail-pj1-x1049.google.com with SMTP id
 hi22-20020a17090b30d600b001b8b33cf0efso4990330pjb.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 23:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=pzssXhX8riGRjAd4+3metqANF5chmN7DhU3KIG19plk=;
 b=BXYHGO/apr1trZ7ANJF1Lt6pYKglG4Ybyk1oIZRHZKKVSqoKSXgrBXlJ+1OM+32L9t
 MU8n7K+r76s0oXflCxISCV1ICc0UvMWkHQwSTytgu8Evx0a2e982roAPsTJGWM6fb62G
 4xiTSYukPeiMTehnCZ8Ef6urhW9UdAhyCH8qBQH/Z3umLv0xdGv2JPdSLHgNuZnc3YDQ
 m26WTBm81XDNmFpY/glb5MBqUkdfdOBU4PUPqt6iZ2jAhWr3J7itrrkNCi44IwFV8KeU
 S94sCD0t8mfXDphKvuDMvw2otQeqJUpd7l5aT+oeKWADzDv5u6Czmms69AvfX5QGDeUK
 NAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=pzssXhX8riGRjAd4+3metqANF5chmN7DhU3KIG19plk=;
 b=IPMa2hnIxQGVEGEHoS0YuNt1UtXIBt4kx8ZKRm6QNTNMAxBJSrD35magfJjbXFwTY7
 k4lWROg8gtPnuMkZIa0sLu1AMDOfriezXqxHI0LsIY/6y9A0nxOhtbWaqfOf4cLcUK1c
 udRo5VY5OHhgCUFOVRHUeg11d8xQ4fZbbGg2JvZWgBI5vxcxZ6GCHhTqBy4t+HYe2dCp
 ijb49fVssNVCkVKO5dTMRDvcPNAR8+CgyVKL0uHKU4Mc1geVE27LLDBu1tPRcH1V2Ib6
 ksXs0ToS8zfxJkCtJ2aYzyCXoGmWoJP4zxSEkxQZu7SC+9uo0rJ6p2gqpFOb41DR4cZY
 BhAA==
X-Gm-Message-State: AOAM532p2L7OVE7gbeTBsmGE7QN5PhMhYdgx5SsRA6WeDnsNZbLisqss
 37V+JYbkQX0kuBYwEnO1qutw6jZOb6u5cg==
X-Google-Smtp-Source: ABdhPJw0UMsgszZC5yB3naBv5jFWjYWF4uP6hg8QghCa4W6xT10Nwxg2nhu4SD1k1Vghgej18o9lOhbEem5LzA==
X-Received: from slicestar.c.googlers.com
 ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:a50f:b0:1b8:e6ad:f63c with SMTP
 id a15-20020a17090aa50f00b001b8e6adf63cmr333880pjq.1.1645171074073; Thu, 17
 Feb 2022 23:57:54 -0800 (PST)
Date: Fri, 18 Feb 2022 15:57:23 +0800
Message-Id: <20220218075727.2737623-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 0/4] kunit,um: Fix kunit.py build --alltests
From: David Gow <davidgow@google.com>
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Brendan Higgins <brendanhiggins@google.com>,
 Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 18 Feb 2022 15:25:33 +0000
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
Cc: David Gow <davidgow@google.com>, linux-rdma@vger.kernel.org,
 felix.kuehling@amd.com, x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kunit_tool's --alltests option uses UML and make allyesconfig to produce
a configuration which enables as many tests as possible. However, make
ARCH=um allyesconfig is broken for a number of reasons.

Fix a few different UML build breakages, and disable a few config
options in kunit_tool in order to get this kernel compiling again.

Note that the resulting kernel still doesn't run, but having it compile
is the first step to fixing that.

David Gow (3):
  drm/amdgpu: Make smu7_hwmgr build on UML
  IB/qib: Compile under User-Mode Linux
  kunit: tool: Disable broken options for --alltests

Randy Dunlap (1):
  drm/amdgpu: Fix compilation under UML

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c               | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c           | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 drivers/infiniband/hw/qib/qib_wc_x86_64.c           | 4 ++++
 tools/testing/kunit/configs/broken_on_uml.config    | 5 +++++
 5 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.35.1.265.g69c8d7142f-goog

