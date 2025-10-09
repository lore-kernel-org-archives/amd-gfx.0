Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDDECCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2A310EB75;
	Fri, 10 Oct 2025 08:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l6sQtRmv";
	dkim-atps=neutral
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com
 [209.85.166.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80C010EACC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:58:41 +0000 (UTC)
Received: by mail-il1-f175.google.com with SMTP id
 e9e14a558f8ab-42d8bf52325so6005585ab.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032721; x=1760637521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lGMv5lHdrhywBVTV/PqaJfnG7AITk86FOlf4SxNuZNA=;
 b=l6sQtRmv94EsGBYuU6nf+cuWeMkVmgK18fvYwM2KWjmMSZ5W2KWHpRjs8xQEmQk77R
 byOLFUWOCHHETnfZeqUnU9fRCvfcClEbRph7hHcEUc7L5iMj3FAG0db1XAIKYa1Xf9l4
 Wiui+y9i3ONeSs/NFAPv8cdeZDv9BFN+7BWF6K247hEmBVAid/eD7Ase/OREgOYR3zsO
 urFsCGyvAaNqY2c8OeXsPvV2fI9m4YjEi1DjplMQt8Kk1v/D7MqOBZVHBKhbhmS+PieB
 Yj/hCDDRoP4MMngDy+6jvtWKAXgc5NSWr1ITHMjygPwDX4Jxr4YPYsSDCpjzG54dk9q0
 GA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032721; x=1760637521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lGMv5lHdrhywBVTV/PqaJfnG7AITk86FOlf4SxNuZNA=;
 b=u9ZDyfbRd5b+L/0LTR64e82FBDaCKCMfTw/7hTbpTX6JBAaaY94to6Tpns68z5GlQe
 mZ9OAlZ0bpns9sXk1lZjL2SXwNyMbb6JXLb5OXdQJYzNqmWCKeAZzYQ/StxW8Np35yY4
 Ds1QByGq1gyN/AeIYN9Y4v9PyR9qthIm04ph7JyHold2Q9bOwGJeZtvuT8R/0b7nXVRN
 PaNg7RvPZ3rF334r9rwNqKNk5Tdv6pIMWH59F6/uIV60Qo2pbmMO2vLNRWAPiSOI/n+L
 c5zg4vENJjeu+qMvNeCGzJ1wIryUV88z+rMQE37kXLOQQLrJTKquGcsK2Vqeg64Jd+wh
 WcCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzC2arxI5R00zCtJ0ITxm/zLYG7jYk27c+vRRfuTkU8h35/ChiXJSws5Ountaj8A/9AH3dKdwZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwoDTxZD3QDgxLSEwNYA5IBQI1n5Q214DCuraZXj0XKgQ8ugb05
 c6BZRva07UKN4Y/GG6BPK9QS5rcToacMEk4XUAIsVDkRdr59BQK60+IP
X-Gm-Gg: ASbGncsyzL35P9LrMufktg2Xu5E5GcAlLLqGVg7RxpAjSyNIwMjZYjceohP0V+vcif1
 rYz5QHHz9DcGaQhVNYYaDGt5yWpXUYt8Ol3Lai0vX8YIH14dGrYxPg1i1Z/UEPVwC/v3U1u5OdY
 8pgUrdRV+ibjAMxBZlmvtDUPHBfYpwwzEzxwMDUE9RZGXtqI7WNdjWdUi+RQZfrtYeildGKvsfl
 kf3B6uAOAvZGJ3yBcmVYAd6MBedoS07F+Fv3Tk2jWZleizuRXNsbjzMQiJlRgR/c/HXKKdPV9Nm
 h5TzrHBY/1tFh9f32QmeStTWvOBAGFU1b0cVIgdryIcLzs0ohl4qjA9ZPI4PH4Yr5SEUDGSGViC
 fPWn+I7BAfoM3pgoBtkH1uQv9Mmt10tmfpiyU0Qsrqy7AGhDNoG9Tc+FA+P2lJVw7tsetK1QMsk
 oCrM9+BlmJryUbZH9ib+Rtlnw440hqOFr1NnnaMmzf+/cubZV5
X-Google-Smtp-Source: AGHT+IH0kP4+vfxD+O9Wz2DP4UBxSThOXmUadGnkvBABGnXzdVOZ2Hbq3wUFuypfAQx9EkxOwcXsnQ==
X-Received: by 2002:a05:6e02:3783:b0:42e:712e:52a0 with SMTP id
 e9e14a558f8ab-42f873540b2mr82406535ab.6.1760032720604; 
 Thu, 09 Oct 2025 10:58:40 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:58:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>,
 andrewjballance@gmail.com
Subject: [PATCH v5 00/30] Fix DYNAMIC_DEBUG classmaps for DRM
Date: Thu,  9 Oct 2025 11:58:04 -0600
Message-ID: <20251009175834.1024308-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Oct 2025 08:03:12 +0000
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

DYNAMIC_DEBUG classmaps is BROKEN for its 1st user: DRM. Lets Fix it.

The DECLARE_DYNDBG_CLASSMAP macro muddled the distinction between
definition and reference; in use it failed K&R define once, refer many.

Replace it with:
. DYNAMIC_DEBUG_CLASSMAP_DEFINE		for drm.ko
. DYNAMIC_DEBUG_CLASSMAP_USE		for drivers etc

Enhance test-dynamic-debug{,-submod}.ko to recapitulate DRM's 2+ module
boss-workers failure scenario, and to selftest against them.  This allows
dropping the DRM patches, formerly included to prove functionality.

The latest (unversioned) rev:
. I inexplicably fiddled with the patch subject
. dropped DRM as OT for lib/
https://lore.kernel.org/lkml/20250911213823.374806-1-jim.cromie@gmail.com/

v1-4 saw significant review, thanks Louis Chauvet <louis.chauvet@bootlin.com>

v4: https://lore.kernel.org/lkml/20250803035816.603405-1-jim.cromie@gmail.com/
v3: https://lore.kernel.org/lkml/20250402174156.1246171-1-jim.cromie@gmail.com/#t
v2: https://lore.kernel.org/lkml/20250320185238.447458-1-jim.cromie@gmail.com/
v1: https://lore.kernel.org/lkml/20250125064619.8305-1-jim.cromie@gmail.com/
v0: prehistoric versions are linked from v1,v2

Jim Cromie (30):
  docs/dyndbg: update examples \012 to \n
  docs/dyndbg: explain flags parse 1st
  test-dyndbg: fixup CLASSMAP usage error
  dyndbg: reword "class unknown," to "class:_UNKNOWN_"
  dyndbg: make ddebug_class_param union members same size
  dyndbg: drop NUM_TYPE_ARRAY
  dyndbg: tweak pr_fmt to avoid expansion conflicts
  dyndbg: reduce verbose/debug clutter
  dyndbg: refactor param_set_dyndbg_classes and below
  dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
  dyndbg: replace classmap list with a vector
  dyndbg: macrofy a 2-index for-loop pattern
  dyndbg: DECLARE_DYNDBG_CLASSMAP needs stub defn
  dyndbg,module: make proper substructs in _ddebug_info
  dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
  dyndbg: move mod_name from ddebug_table down to _ddebug_info
  dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
  selftests-dyndbg: add a dynamic_debug run_tests target
  dyndbg: change __dynamic_func_call_cls* macros into expressions
  dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
  dyndbg: detect class_id reservation conflicts
  dyndbg: check DYNAMIC_DEBUG_CLASSMAP_DEFINE args at compile-time
  dyndbg-test: change do_prints testpoint to accept a loopct
  dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM to API
  dyndbg: treat comma as a token separator
  dyndbg: split multi-query strings with %
  selftests-dyndbg: add test_mod_submod
  dyndbg: resolve "protection" of class'd pr_debugs
  dyndbg: add DYNAMIC_DEBUG_CLASSMAP_USE_(clname,_base)
  docs/dyndbg: add classmap info to howto

CC: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: ukaszb@chromium.org
cc: andrewjballance@gmail.com

 .../admin-guide/dynamic-debug-howto.rst       | 179 ++++-
 MAINTAINERS                                   |   3 +-
 include/asm-generic/vmlinux.lds.h             |   5 +-
 include/linux/dynamic_debug.h                 | 304 ++++++--
 kernel/module/main.c                          |  15 +-
 lib/Kconfig.debug                             |  24 +-
 lib/Makefile                                  |   5 +
 lib/dynamic_debug.c                           | 678 +++++++++++-------
 lib/test_dynamic_debug.c                      | 198 +++--
 lib/test_dynamic_debug_submod.c               |  21 +
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   7 +
 .../dynamic_debug/dyndbg_selftest.sh          | 373 ++++++++++
 14 files changed, 1393 insertions(+), 429 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

-- 
2.51.0

