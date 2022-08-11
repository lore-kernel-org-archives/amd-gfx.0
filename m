Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8958C00140
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 00:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F88412B464;
	Thu, 11 Aug 2022 00:41:28 +0000 (UTC)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241498B6BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:41:06 +0000 (UTC)
Received: by mail-vk1-xa31.google.com with SMTP id t64so2266319vkb.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 17:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=Ui1A+YO8XaMfV3Wu9piqXAbScqHCc8fcJSOueheAjRU=;
 b=QnN1Uh5F0Y/K1VG+SJBylkSEc8OHKOTND4DeAl/t6R1OvKj3FXAaHpjoYOD3RNbQfW
 hRkg/RDelbN/KFtpUcIYU6ba4VwkoUdwWiubLZxGOvCWuPb1NvhCCiLfbJEgn69US/ua
 +TwPrD22ktGT7R0VV/kShMyr1VOcsVJ5vZLwQvhRV972QSzjckVqT3130sGc6kGHj41n
 AYwGp5VlBdYII7kL6VAiJGRFZtHlCz6qTyqmVLN+ImiM88MWuHBxp8J1lf0uu7+lP4xU
 V3i9Gt6ZuUCG/NU7sQgaMSkKWoYbkFZdyNZfXmSLjImRZIvCwKSnF7CfdKvKuJH4GtuC
 Zm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=Ui1A+YO8XaMfV3Wu9piqXAbScqHCc8fcJSOueheAjRU=;
 b=evaqtBG2rXjKVXq/Rl80YWOIUSKp/aAXoQdsUuQ1q4JtK0Ata99yNxzp+w6HVcgzai
 9P6SVLhp7QxVgJbRooC8Xc7Kv58NGnDBaXlL/++SJZaAlylvn88NnyM+vFmrvr33LQ3K
 EhceZc3noSvZhdEzif5nklNY4JvlMHpQaiLEZMDTUYGsqcvJ7x8aYpZYi/eqoqbbqgZG
 hcABP92KYlJQvfzus/NNh7xXMYexULu9NPC7YL3MYiyWdqO7JjcJb4V5iprx4WDCVlAt
 Ao8xel0+ipBn2zBSGsKelZh66w0saAXs3ZrnykOUnXpHO4HZdY6Y+dIuS8DvCFsne/oM
 Z7KA==
X-Gm-Message-State: ACgBeo1fuMtnp4ux36eaFPTfiPPIf4Z4RKMv+3UB5iesjMf7AsRWyOAQ
 0bRfe8GU/cfjenEl98G2ibA=
X-Google-Smtp-Source: AA6agR6uSPKvKwjJvTUxrbhTEurVgBYQBNkCheBB8UyUaO4nmhyDTEBfmfOwrCq15g/qGKIvXbcR/A==
X-Received: by 2002:a1f:5ed8:0:b0:377:4b5f:41f1 with SMTP id
 s207-20020a1f5ed8000000b003774b5f41f1mr12656052vkb.35.1660178465827; 
 Wed, 10 Aug 2022 17:41:05 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 z188-20020a1fc9c5000000b003791113188csm893072vkf.55.2022.08.10.17.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 17:41:05 -0700 (PDT)
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
Subject: [PATCH 8/8] Documentation/gpu: Add Display Core Unit Test
 documentation
Date: Wed, 10 Aug 2022 21:40:10 -0300
Message-Id: <20220811004010.61299-9-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220811004010.61299-1-tales.aparecida@gmail.com>
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
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

From: Maíra Canal <mairacanal@riseup.net>

Explain how to run the KUnit tests present in the AMDGPU's Display
Core and clarify which architectures and tools can be used to run
the tests. Moreover, explains how to add new tests to the existing
tests.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 .../gpu/amdgpu/display/display-test.rst       | 73 +++++++++++++++++++
 Documentation/gpu/amdgpu/display/index.rst    |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/display/display-test.rst

diff --git a/Documentation/gpu/amdgpu/display/display-test.rst b/Documentation/gpu/amdgpu/display/display-test.rst
new file mode 100644
index 000000000000..f2eb8e3213ea
--- /dev/null
+++ b/Documentation/gpu/amdgpu/display/display-test.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+========================
+Display Core Unit Tests
+========================
+
+Display core provides a set of unit tests, currently focused on the Display Mode
+Library. The unit tests use KUnit (Kernel Unit Testing Framework), a common
+framework for unit tests within the Linux Kernel.
+
+This section covers the specifics of the tests for the AMDGPU driver. For general
+information about KUnit, please refer to Documentation/dev-tools/kunit/start.rst.
+
+How to run the tests?
+=====================
+
+In order to facilitate running the test suite, a configuration file is present
+in ``drivers/gpu/drm/amd/display/tests/dc/.kunitconfig``. This configuration file
+can be used to run the kunit_tool, a Python script (``tools/testing/kunit/kunit.py``)
+used to configure, build, exec, parse and run tests.
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
+	    --kunitconfig=drivers/gpu/drm/amd/display/tests
+
+Currently, the Display Core Unit Tests are only supported on x86_64.
+
+Moreover, the tests can also be run on real hardware or in other emulation
+environments. To include the Display Core Unit Tests on a deployable kernel,
+you might add the following config options to your ``.config``:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_AMDGPU=m
+	CONFIG_AMD_DC_BASICS_KUNIT_TEST=y
+	CONFIG_DML_KUNIT_TEST=y
+
+Once the kernel is built and installed, you can load the ``amdgpu`` module
+to run all tests available.
+
+Also, the tests can be added to the kernel as built-in modules, by adding the
+following config options to your ``.config``:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_AMDGPU=y
+	CONFIG_AMD_DC_BASICS_KUNIT_TEST=y
+	CONFIG_DML_KUNIT_TEST=y
+
+In order to run specific tests, you can check the filter options from KUnit on
+Documentation/dev-tools/kunit/kunit-tool.rst.
+
+How to add new tests?
+=====================
+
+Tests covering different parts of the Display Core are always welcomed. Adding
+a new test is a simple procedure, that consists in creating a unit test file
+and adding the following guard to the end of the tested file:
+
+.. code-block:: c
+
+	#ifdef CONFIG_MY_KUNIT_TEST
+	#include "my_kunit_test.c"
+	#endif
+
+The ``display/tests`` folder replicates the folder hierarchy of the ``display``
+folder, so this must be considered while adding new tests.
+
+More information on how to write unit tests with the KUnit API can be provided
+on Documentation/dev-tools/kunit/api/test.rst.
diff --git a/Documentation/gpu/amdgpu/display/index.rst b/Documentation/gpu/amdgpu/display/index.rst
index c1fb2fb3c710..4f4e72e3e75f 100644
--- a/Documentation/gpu/amdgpu/display/index.rst
+++ b/Documentation/gpu/amdgpu/display/index.rst
@@ -28,4 +28,5 @@ table of content:
    display-manager.rst
    dc-debug.rst
    dcn-overview.rst
+   display-test.rst
    dc-glossary.rst
-- 
2.37.0

