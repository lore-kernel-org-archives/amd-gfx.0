Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBD8C83F22
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 02:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F0F10E473;
	Mon, 21 Jul 2025 02:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N8VG72+j";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BD510E10A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 02:14:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1827E5C5862;
 Mon, 21 Jul 2025 02:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75545C4CEF1;
 Mon, 21 Jul 2025 02:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753064090;
 bh=p0+VILemx8TFlzi4oJZvUVu4dWm2QYoZPeYheHiAfxw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N8VG72+jJ8HW6aYAsf1NPmNFvuT/aMRxcdU4JmT3s2xfI/S/nZHQlJZNH3kn3lZjH
 jpJOrAEU6/D/z6nWno5qidC5KLda47VR3ta65mNY6lmJQg1AR5TT9dTVqyfji1NvkC
 qmFFWgurFZmYl2I2ikeAb+uCqDNqbdfkxChm+neAsev+NSxm0ugU0aVxc+PqQPKT4R
 uFYHDNUzuZl0BdFmGXIOqWrVl5UICXKDarMJ2rkUVDZRou1Mij7gJTFDcl7V78zCKj
 7vL4wfC7wiJZ+H/V6oxk95KCR3amAdjxFI4ip11ScHpWSsT+L3dA/W1EWuX7SLAtVy
 XMG/L0lKZ0jVQ==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/3] tests/amdgpu: Add support for testing compositor control
 of ABM
Date: Sun, 20 Jul 2025 21:13:19 -0500
Message-ID: <20250721021320.2346961-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721021320.2346961-1-superm1@kernel.org>
References: <20250721021320.2346961-1-superm1@kernel.org>
MIME-Version: 1.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

The compositor can directly control ABM, but sysfs should be blocked
when this happens.  Ensure that sysfs writes fail at that time.

To avoid potential test failures, ensure that sysfs control is enabled
at the start of all other tests.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tests/amdgpu/amd_abm.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tests/amdgpu/amd_abm.c b/tests/amdgpu/amd_abm.c
index 3c6a7307f..090806d6a 100644
--- a/tests/amdgpu/amd_abm.c
+++ b/tests/amdgpu/amd_abm.c
@@ -107,6 +107,45 @@ static void fbmem_draw_smpte_pattern(uint32_t *fbmem, int width, int height)
 	}
 }
 
+static bool set_abm_level_compositor(data_t *data, igt_output_t *output, const char *level)
+{
+	uint32_t type = DRM_MODE_OBJECT_CONNECTOR;
+	uint32_t output_id = output->id;
+	drmModePropertyPtr prop = NULL;
+	uint64_t abm_prop_value;
+	uint32_t abm_prop_id;
+	bool abm_prop_exists;
+	int i;
+
+	abm_prop_exists = kmstest_get_property(
+		data->drm_fd, output_id, type, "adaptive backlight modulation",
+		&abm_prop_id, &abm_prop_value, &prop);
+
+	/* not supported in this kernel */
+	if (!abm_prop_exists)
+		return false;
+
+	igt_assert(prop->count_enums != 0);
+
+	for (i = 0; i < prop->count_enums; i++) {
+		if (strcmp(prop->enums[i].name, level) == 0) {
+			abm_prop_value = prop->enums[i].value;
+			break;
+		}
+	}
+
+	igt_assert_f(i != prop->count_enums,
+		    "ABM property value '%s' not found in connector %s\n",
+		    level, output->name);
+
+	drmModeFreeProperty(prop);
+
+	igt_assert(drmModeConnectorSetProperty(data->drm_fd, output->id,
+					       abm_prop_id, abm_prop_value) == 0);
+
+	return true;
+}
+
 /* Common test setup. */
 static void test_init(data_t *data)
 {
@@ -160,6 +199,8 @@ static void test_init(data_t *data)
 	fbmem_draw_smpte_pattern(data->fb_mem, data->w, data->h);
 	igt_create_color_fb(data->drm_fd, data->mode->hdisplay,
 		data->mode->vdisplay, DRM_FORMAT_XRGB8888, 0, 0.05, 0.05, 0.05, &data->ref_fb2);
+
+	set_abm_level_compositor(data, data->output, "sysfs");
 }
 
 /* Common test cleanup. */
@@ -449,6 +490,44 @@ static void abm_enabled(data_t *data)
 	}
 }
 
+static void abm_compositor(data_t *data)
+{
+	igt_output_t *output;
+	char buf[PATH_MAX];
+	enum pipe pipe;
+	int fd;
+
+	for_each_valid_output_on_pipe(&data->display, pipe, output) {
+		if (output->config.connector->connector_type != DRM_MODE_CONNECTOR_eDP)
+			continue;
+
+		/* allow sysfs writes */
+		if (!set_abm_level_compositor(data, output, "sysfs"))
+			igt_skip("No ABM property\n");
+
+		/* Set ABM to 4 */
+		set_abm_level_sysfs(data, output, 4);
+
+		/* block sysfs and turn off ABM */
+		set_abm_level_compositor(data, output, "min");
+
+		/* ensure a sysfs write fails */
+		igt_assert(snprintf(buf, PATH_MAX, PANEL_POWER_SAVINGS_PATH,
+			   output->name) < PATH_MAX);
+		fd = open(buf, O_WRONLY);
+		igt_assert_eq(snprintf(buf, sizeof(buf), "%d", 4), 1);
+		igt_assert_eq(write(fd, buf, 1), -1);
+		igt_assert_eq(close(fd), 0);
+		igt_assert_eq(errno, EBUSY);
+
+		/* re-enable sysfs */
+		set_abm_level_compositor(data, output, "sysfs");
+
+		/* Set ABM to 0 with sysfs */
+		set_abm_level_sysfs(data, output, 0);
+	}
+}
+
 static void abm_gradual(data_t *data)
 {
 	int ret, i;
@@ -524,6 +603,8 @@ igt_main
 		abm_enabled(&data);
 	igt_subtest("abm_gradual")
 		abm_gradual(&data);
+	igt_subtest("abm_compositor")
+		abm_compositor(&data);
 
 	igt_fixture {
 		test_fini(&data);
-- 
2.50.1

