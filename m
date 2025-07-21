Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB83C83F22
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 02:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD7E10E243;
	Mon, 21 Jul 2025 02:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LQWcX73m";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D5510E10A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 02:14:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 85F11A527B8;
 Mon, 21 Jul 2025 02:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96D6C4CEE7;
 Mon, 21 Jul 2025 02:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753064090;
 bh=5lRM5AlrWq2k2vqiRlJZNUz1TZlHmbQboTuvW54s61U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LQWcX73mkMarTJPKrVU8l4lVHVTcbbiNnwRJU07Hbzohlcb4gg6O+f0Jfl+buDctb
 p0seq0NALtN5iDU5TaKRLrpzuEv3Ow4Np2Il1kghZNEjkfHDzk+OAxPgP/Q688RG7h
 1XyoEXI/DLERz7O43pWHoALfWyN1G7ly4OkoPr43jnhEbutditNKwSxJwpAyxCPvIJ
 /87XLoC5pZi2xs8n5h2PD3gG+Hdv0gryzZ67s2gMhXcspVnpyhgZhpAAz7mh9nvKOs
 krh1ESthsu+x/2G3W/3+OZeeujCk9X+MRVkdsrXeW20ARMEaXFT0nFCPIGaeLb9fq0
 QBl20ZHNz3Pnw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] tests/amdgpu: Rename set_abm_level to set_abm_level_sysfs
Date: Sun, 20 Jul 2025 21:13:18 -0500
Message-ID: <20250721021320.2346961-3-superm1@kernel.org>
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

The compositor can set the ABM level directly, so rename the function
to clarify which method is being used.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tests/amdgpu/amd_abm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/amdgpu/amd_abm.c b/tests/amdgpu/amd_abm.c
index f55b055f9..3c6a7307f 100644
--- a/tests/amdgpu/amd_abm.c
+++ b/tests/amdgpu/amd_abm.c
@@ -50,7 +50,7 @@ typedef struct data {
 	uint32_t *fb_mem;
 } data_t;
 
-static void set_abm_level(data_t *data, igt_output_t *output, int level);
+static void set_abm_level_sysfs(data_t *data, igt_output_t *output, int level);
 
 static void fbmem_draw_smpte_pattern(uint32_t *fbmem, int width, int height)
 {
@@ -173,7 +173,7 @@ static void test_fini(data_t *data)
 	for_each_valid_output_on_pipe(&data->display, pipe, output) {
 		if (output->config.connector->connector_type != DRM_MODE_CONNECTOR_eDP)
 			continue;
-		set_abm_level(data, output, 0);
+		set_abm_level_sysfs(data, output, 0);
 	}
 
 	igt_display_reset(display);
@@ -247,7 +247,7 @@ static int backlight_write_brightness(int value)
 	return 0;
 }
 
-static void set_abm_level(data_t *data, igt_output_t *output, int level)
+static void set_abm_level_sysfs(data_t *data, igt_output_t *output, int level)
 {
 	char buf[PATH_MAX];
 	int fd;
@@ -334,7 +334,7 @@ static void backlight_dpms_cycle(data_t *data)
 		ret = backlight_read_max_brightness(&max_brightness);
 		igt_assert_eq(ret, 0);
 
-		set_abm_level(data, output, 0);
+		set_abm_level_sysfs(data, output, 0);
 		backlight_write_brightness(max_brightness / 2);
 		usleep(100000);
 		pwm_1 = read_target_backlight_pwm(data->drm_fd, output->name);
@@ -365,7 +365,7 @@ static void backlight_monotonic_basic(data_t *data)
 
 		brightness_step = max_brightness / 10;
 
-		set_abm_level(data, output, 0);
+		set_abm_level_sysfs(data, output, 0);
 		backlight_write_brightness(max_brightness);
 		usleep(100000);
 		prev_pwm = read_target_backlight_pwm(data->drm_fd, output->name);
@@ -399,7 +399,7 @@ static void backlight_monotonic_abm(data_t *data)
 
 		brightness_step = max_brightness / 10;
 		for (i = 1; i < 5; i++) {
-			set_abm_level(data, output, i);
+			set_abm_level_sysfs(data, output, i);
 			backlight_write_brightness(max_brightness);
 			usleep(100000);
 			prev_pwm = read_target_backlight_pwm(data->drm_fd, output->name);
@@ -431,14 +431,14 @@ static void abm_enabled(data_t *data)
 		ret = backlight_read_max_brightness(&max_brightness);
 		igt_assert_eq(ret, 0);
 
-		set_abm_level(data, output, 0);
+		set_abm_level_sysfs(data, output, 0);
 		backlight_write_brightness(max_brightness-max_brightness/10);
 		usleep(100000);
 		prev_pwm = read_target_backlight_pwm(data->drm_fd, output->name);
 		pwm_without_abm = prev_pwm;
 
 		for (i = 1; i < 5; i++) {
-			set_abm_level(data, output, i);
+			set_abm_level_sysfs(data, output, i);
 			usleep(100000);
 			page_flip(data, output, 10);
 			pwm = read_target_backlight_pwm(data->drm_fd, output->name);
@@ -466,7 +466,7 @@ static void abm_gradual(data_t *data)
 
 		igt_assert_eq(ret, 0);
 
-		set_abm_level(data, output, 0);
+		set_abm_level_sysfs(data, output, 0);
 		backlight_write_brightness(max_brightness-max_brightness/10);
 
 		sleep(convergence_delay);
@@ -474,7 +474,7 @@ static void abm_gradual(data_t *data)
 		curr = read_current_backlight_pwm(data->drm_fd, output->name);
 
 		igt_assert_eq(prev_pwm, curr);
-		set_abm_level(data, output, 4);
+		set_abm_level_sysfs(data, output, 4);
 		for (i = 0; i < 10; i++) {
 			usleep(100000);
 			page_flip(data, output, 10);
-- 
2.50.1

