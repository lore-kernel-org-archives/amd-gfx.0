Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DD3C00140
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 00:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0711B8D1DD;
	Thu, 11 Aug 2022 00:40:40 +0000 (UTC)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EFB796962
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:40:23 +0000 (UTC)
Received: by mail-vk1-xa2f.google.com with SMTP id b81so8283254vkf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 17:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=2O8FhK80OuBpGrtVhmu9G7kEE/fcw6jRNxQh/jsBNM0=;
 b=ZWgwMfnHyaX6onqqu50tiM/x/64k2QEKNui9jigffsTSuhzSSNeGgDp2ISmtIJnPbH
 oBeHt+FfRzci90+5V19DMJK1SxrH4/xG/wtNrvkBPqqzL/wJUZ3b/YF/1cIserrPI2aI
 qoBIf5dRQ0YxY010cQ3dD2o480NK45TBtK15ZCqZyAH5C1DJAM3MAz89xRPIdcBFOst0
 FYp28LY9Be4YJsuPDu2GOeCpmp0aEfnV4zeyEX0z7hYRhg+gnLdoBf9ZDUsAySbqdO+L
 juHIM4D8CgHDHpiEY7JEdmAnPZKCViTNCRV07DuAjIWGSUDSBYC1woNUSd1eDy1KK4yk
 5Hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=2O8FhK80OuBpGrtVhmu9G7kEE/fcw6jRNxQh/jsBNM0=;
 b=C+kFs3os4r9w0IaMJC05PHGZCeifBUfkjRDdjSXQTOrNygidC1Q8QyKzAaDKruSeTe
 72pYz+zy8Okt5bsNp9JWMT8wuJLiAoQyx6MmK5y9t3pXznJAjwOOwu5wn7Y3Zpt3luPl
 j1IhLWUULw93jNdatqYz8Ye9rjv6tez5MRD0x/+NJpD526upvszLYnALZ4vBUz2ssooG
 meb5VRyP3HoUtWpLQ+bwR7qNK2OhyIXX92XlD3sHc482reB9WoRpWUPrf8crqXQbn0Cc
 eKlnrPQnm+s/FJU/4nWFBnFkybKkTxhcBQ+gjQuE0ShpcFpdQG4J+3X/uYHI2Aj4fsdr
 r1Ow==
X-Gm-Message-State: ACgBeo0xJHrKjNf2lqXRpnGOhkbaAFOESxzGkwgN0Ek6CrGAeAxecxqQ
 yzuhS3pHlPw+xTWIVMFVAfs=
X-Google-Smtp-Source: AA6agR4Jx9HBDrvJCd/TNwBMhMJatnJ1sbW+6Da5swLsspOREQ3lbHo8QneXsepEIME+Nqtll0EMTg==
X-Received: by 2002:a1f:bfc4:0:b0:377:aff2:a38b with SMTP id
 p187-20020a1fbfc4000000b00377aff2a38bmr13061585vkf.9.1660178422410; 
 Wed, 10 Aug 2022 17:40:22 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 z188-20020a1fc9c5000000b003791113188csm893072vkf.55.2022.08.10.17.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 17:40:21 -0700 (PDT)
From: Tales Aparecida <tales.aparecida@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 0/8] drm/amd/display: Introduce KUnit to Display Mode Library
Date: Wed, 10 Aug 2022 21:40:02 -0300
Message-Id: <20220811004010.61299-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.0
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
Cc: siqueirajordao@riseup.net, magalilemes00@gmail.com,
 tales.aparecida@gmail.com, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 mairacanal@riseup.net, kunit-dev@googlegroups.com,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

This series is the consolidation of an RFC sent earlier this year [RFC]
bringing unit testing to the AMDPGU driver. [gsoc]

Our main goal is to bring unit testing to the AMD display driver; in
particular, we'll focus on the Display Mode Library (DML) for DCN2.0,
DMUB, and some of the DCE functions. This implementation intends to
help developers to recognize bugs before they are merged into the
mainline and also makes it possible for future code refactors of the
AMD display driver.

For the implementation of the tests, we decided to go with the Kernel
Unit Testing Framework (KUnit). KUnit makes it possible to run test
suites on kernel boot or load the tests as a module. It reports all test
case results through a TAP (Test Anything Protocol) in the kernel log.
Moreover, KUnit unifies the test structure and provides tools to
simplify the testing for developers and CI systems.

In regards to CI pipelines, we believe kunit_tool[kunit_tool] provides
ease of use, but we are also working on integrating KUnit into IGT, for
those already depending on the tool [igt_patch].

We've chosen what we believe to be the simplest approach to integrate
KUnit tests into amdgpu [kunit_static]. We took into consideration that
this driver relies heavily on static functions with complex behavior
which would benefit from unit testing, otherwise, black-box tested
through public functions with dozens of arguments and sometimes high
cyclomatic complexity. Further than that, this approach also helps
beginners by avoiding the need to edit any Makefiles. Other approaches
are available and we would gladly receive feedback on this matter.

The first three patches add KUnit represent what we intend to do on the
rest of the DML modules: systematic testing of the DML functions,
especially mathematically complicated functions. Also, it shows how
simple it is to add new tests to the DML.

Among the tests, we highlight the dcn20_fpu_test, which, had it existed
then, could catch the defects introduced to dcn20_fpu.c by
8861c27a6c [dcn20_bug] later fixed by 9ad5d02c2a [dcn20_fix].

In this series, there's also an example of how unit tests can help avoid
regressions and keeping track of changes in behavior.

Applying this series on top of the amd-staging-drm-next (2305916dca04)
and running its tests will result in a failure in the `dc_dmub_srv`
test, you can verify that with:

$ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
		--kunitconfig=drivers/gpu/drm/amd/display/tests

```
...
[20:19:00] # Subtest: populate_subvp_cmd_drr_info_test
[20:19:00] # populate_subvp_cmd_drr_info_test: pass:0 fail:5 skip:0 total:5
[20:19:00] not ok 1 - populate_subvp_cmd_drr_info_test
[20:19:00] ======== [FAILED] populate_subvp_cmd_drr_info_test =========
[20:19:00] # Subtest: dc_dmub_srv
[20:19:00] 1..1
[20:19:00] # Totals: pass:0 fail:5 skip:0 total:5
[20:19:00] not ok 8 - dc_dmub_srv
[20:19:00] =================== [FAILED] dc_dmub_srv ===================
[20:19:00] ============================================================
[20:19:00] Testing complete. Passed: 59, Failed: 5, Crashed: 0, Skipped: 0, Errors: 0
```
Full output at: https://share.riseup.net/#SOggjANeLfbibdiHu2e_Ug

This is due to a known regression introduced by commit 5da7f4134357
("drm/amd/display: fix 32 bit compilation errors in dc_dmub_srv.c")
[dmub_bug], which resulted in the struct's members being zero.  As an
exercise, you can revert the offending patch and run the tests again,
but that would still result in failure, albeit with a different output.

Full output when reverted: https://share.riseup.net/#EEBgtgXjAmof5vZ_qs7_sg

This regression is currently being worked on [dmub_fix], and this
test-series will result in a success if applied alongside the
fix-series, particularly the patches 1-13/32.

```
[17:48:14] Testing complete. Passed: 64, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
```
Full successful output: https://share.riseup.net/#migyN1Xpy3Gyq1it84HhNw

This series depends on a couple of Kunit patches already merged into
torvalds/master, which themselves depends on older patches:

commit 61695f8c5d51 ("kunit: split resource API from test.h into new resource.h")
commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
commit cfc1d277891e ("module: Move all into module/")
commit cdebea6968fa ("kunit: split resource API impl from test.c into new resource.c")
commit cae56e1740f5 ("kunit: rename print_subtest_{start,end} for clarity (s/subtest/suite)")
commit 1cdba21db2ca ("kunit: add ability to specify suite-level init and exit functions")
commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
commit 3d6e44623841 ("kunit: unify module and builtin suite definitions")
commit a02353f49162 ("kunit: bail out of test filtering logic quicker if OOM")
commit 1b11063d32d7 ("kunit: fix executor OOM error handling logic on non-UML")
commit e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
commit 94681e289bf5 ("kunit: executor: Fix a memory leak on failure in kunit_filter_tests")

You can get a for branch ready for compilation at
https://gitlab.freedesktop.org/isinyaaa/linux/-/tags/introduce-kunit-for-amd-v1

Thanks in advance for your time taking a look and sending any feedback!

Best regards,
Isabella Basso, Magali Lemes, Maíra Canal, and Tales Aparecida

[RFC] https://lore.kernel.org/amd-gfx/20220608010709.272962-1-maira.canal@usp.br/
[gsoc] https://summerofcode.withgoogle.com/programs/2022/organizations/xorg-foundation
[kunit_tool] https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html
[igt_patch] https://lists.freedesktop.org/archives/igt-dev/2022-June/042895.html
[kunit_static] https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functions
[dcn20_bug] https://lore.kernel.org/amd-gfx/20220603185042.3408844-6-Rodrigo.Siqueira@amd.com/
[dcn20_fix] https://lore.kernel.org/amd-gfx/20220608164856.1870594-1-sunpeng.li@amd.com/
[dmub_bug] https://lore.kernel.org/amd-gfx/20220708052650.1029150-1-alexander.deucher@amd.com/
[dmub_fix] https://lore.kernel.org/amd-gfx/20220805175826.2992171-14-chiahsuan.chung@amd.com/T/

Isabella Basso (1):
  drm/amd/display: Introduce Kunit tests to display_rq_dlg_calc_20

Magali Lemes (1):
  drm/amd/display: Introduce KUnit tests for dcn20_fpu

Maíra Canal (5):
  drm/amd/display: Introduce KUnit tests to the bw_fixed library
  drm/amd/display: Introduce KUnit tests to the display_mode_vba library
  drm/amd/display: Introduce KUnit to dcn20/display_mode_vba_20 library
  drm/amd/display: Introduce KUnit tests to dc_dmub_srv library
  Documentation/gpu: Add Display Core Unit Test documentation

Tales Aparecida (1):
  drm/amd/display: Introduce KUnit tests for fixed31_32 library

 .../gpu/amdgpu/display/display-test.rst       |  73 ++
 Documentation/gpu/amdgpu/display/index.rst    |   1 +
 drivers/gpu/drm/amd/display/Kconfig           |  25 +
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   5 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   4 +
 .../drm/amd/display/dc/dml/calcs/bw_fixed.c   |   3 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   4 +
 .../dc/dml/dcn20/display_mode_vba_20.c        |   4 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   4 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   3 +
 .../gpu/drm/amd/display/tests/.kunitconfig    |   7 +
 .../dc/basics/dc_basics_fixpt31_32_test.c     | 232 ++++++
 .../amd/display/tests/dc/dc_dmub_srv_test.c   | 285 +++++++
 .../tests/dc/dml/calcs/bw_fixed_test.c        | 323 ++++++++
 .../tests/dc/dml/dcn20/dcn20_fpu_test.c       | 560 +++++++++++++
 .../dc/dml/dcn20/display_mode_vba_20_test.c   | 227 ++++++
 .../dml/dcn20/display_rq_dlg_calc_20_test.c   | 112 +++
 .../tests/dc/dml/display_mode_vba_test.c      | 741 ++++++++++++++++++
 18 files changed, 2613 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/display/display-test.rst
 create mode 100644 drivers/gpu/drm/amd/display/tests/.kunitconfig
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/basics/dc_basics_fixpt31_32_test.c
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/calcs/bw_fixed_test.c
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/dcn20_fpu_test.c
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_mode_vba_20_test.c
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_rq_dlg_calc_20_test.c
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/display_mode_vba_test.c


base-commit: 2305916dca043ed69bd464f74a886b0216780aa6
prerequisite-patch-id: 83185f6c5da6070e7b0b608bc705a2d3bf295ae6
prerequisite-patch-id: 65407777e3bb20dfe5051f4f4cc7deb6a3c2ed34
prerequisite-patch-id: 60af3dadcfd4a778f10dd09fafbde6061d98528b
prerequisite-patch-id: 92d9259125f2982da5945be995b4ae2af1ca7c32
prerequisite-patch-id: f35acb6c07c0bd5496df919214351399d9aed5b5
prerequisite-patch-id: 8a9637d89966e51adfe11e3fd3d17fcf1328b472
prerequisite-patch-id: ea6f40f1cfb61fddb9d1562111897e184da49bf7
prerequisite-patch-id: ae79651ae7b2e02520b18fc7eded463afea757e5
prerequisite-patch-id: ba795b981f3e94890540f452e658e28408b500d2
prerequisite-patch-id: abd5e51f483a9afb08af468db043e2ebc7ce6867
prerequisite-patch-id: a31028824a461f8b4a6b9244035e246efbee9c71
prerequisite-patch-id: a65dfe200981f8584ba3b1f9813faa4f0022a13e
-- 
2.37.0

