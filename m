Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6E0ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 16:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852EE10E5E3;
	Mon, 12 Sep 2022 16:01:45 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56BDF10E5DE;
 Mon, 12 Sep 2022 16:01:23 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4MRBD244qQz9sLj;
 Mon, 12 Sep 2022 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1662998482; bh=aIigWzmJjzzZpMl722eFJbNrqRObh5axpco3NvpCdpQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZamYl3AJ4thGrNKVuk6qjlfN0BIC1i0HBi01GSPSFTLeuhVGzJPZtOsRPAto7yWl4
 k5le1OipmZl5MPJEp06Ecj6vOLY6sp5kj8VX27FSi3Dy3mNv6lNrF/GpEQJBX+D9E/
 m/fQ6oU8VPWPmJSi3hTqlaTeZVBbbLW0ygeZSMyU=
X-Riseup-User-ID: 207D9B3F353D68D9D982A1ACD49879983B57DA94DC416EE349C8F6E83CCC7C83
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4MRBCv3gknz5vgp;
 Mon, 12 Sep 2022 16:01:15 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nicholas Choi <nicholas.choi@amd.com>,
 Daniel Latypov <dlatypov@google.com>, David Gow <davidgow@google.com>
Subject: [PATCH v3 8/8] Documentation/gpu: Add Display Core Unit Test
 documentation
Date: Mon, 12 Sep 2022 12:59:19 -0300
Message-Id: <20220912155919.39877-9-mairacanal@riseup.net>
In-Reply-To: <20220912155919.39877-1-mairacanal@riseup.net>
References: <20220912155919.39877-1-mairacanal@riseup.net>
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
Cc: kunit-dev@googlegroups.com, magalilemes00@gmail.com,
 tales.aparecida@gmail.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 dri-devel@lists.freedesktop.org, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Explain how to run the KUnit tests present in the AMDGPU's Display
Core and clarify which architectures and tools can be used to run
the tests. Moreover, explains how to add new tests to the existing
tests.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../gpu/amdgpu/display/display-test.rst       | 88 +++++++++++++++++++
 Documentation/gpu/amdgpu/display/index.rst    |  1 +
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/display/display-test.rst

diff --git a/Documentation/gpu/amdgpu/display/display-test.rst b/Documentation/gpu/amdgpu/display/display-test.rst
new file mode 100644
index 000000000000..a8c136ce87b7
--- /dev/null
+++ b/Documentation/gpu/amdgpu/display/display-test.rst
@@ -0,0 +1,88 @@
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
+	CONFIG_AMD_DC_KUNIT_TEST=y
+	CONFIG_DCE_KUNIT_TEST=y
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
+	CONFIG_AMD_DC_KUNIT_TEST=y
+	CONFIG_DCE_KUNIT_TEST=y
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
+and adding the following guard to the end of the tested file when you are
+testing static functions:
+
+.. code-block:: c
+
+	#ifdef CONFIG_MY_KUNIT_TEST
+	#include "my_kunit_test.c"
+	#endif
+
+If you are not testing static functions, you should use the Makefile placed on
+``display/tests``. In order to add a test to the Makefile, you can just add
+the following entry to the Makefile:
+
+.. code-block:: make
+
+	ifdef CONFIG_MY_KUNIT_TEST
+		DC_TESTS += my_kunit_test.o
+	endif
+
+The ``display/tests`` folder replicates the folder hierarchy of the ``display``
+folder, so this must be considered while adding new tests.
+
+More information on how to write unit tests with the KUnit API can be provided
+on Documentation/dev-tools/kunit/api/test.rst.
diff --git a/Documentation/gpu/amdgpu/display/index.rst b/Documentation/gpu/amdgpu/display/index.rst
index f8a4f53d70d8..9b13f0f3524f 100644
--- a/Documentation/gpu/amdgpu/display/index.rst
+++ b/Documentation/gpu/amdgpu/display/index.rst
@@ -29,4 +29,5 @@ table of content:
    dc-debug.rst
    dcn-overview.rst
    mpo-overview.rst
+   display-test.rst
    dc-glossary.rst
-- 
2.37.3

