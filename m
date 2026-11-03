Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FFA606EE8F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=SMaQue+S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8211310F5CF;
	Tue,  3 Nov 2026 14:03:10 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FD910F595
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 13:16:05 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jJpwz4j4GzMlSH;
 Tue, 03 Nov 2026 14:16:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793711763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61OBeqiFBu30MiaeAKFOZife1aseAGNq84UZZcG7jsA=;
 b=SMaQue+SiFqYGP4UExyOioX2luV+ZmSlGfZ5+W0a3IoBfB3gUWK2mqy0bj+D22Gx5eaOta
 j8ET1RN8MI6fbpPPkwNkKXTclUuM0Qz+E6TqJHBeSdgYXafVfpugP6oXMdKSnv4XrKDiIl
 r0oaIZa4tcV8+igX+DggoE56rnY2bti6LBbGiBBfovcJC3GHu1XriFclsEGFVXrF3jWaQB
 EbZNLfppLNESJi25WHL/8+zEU56+Waach5skT5R+X4YVnoXBhl3nYTyDOIoNq80O30aDhb
 iwNSRFKMqsTqyTMNLmwOR8MmkDOIn9SUePYUwbiqq6pxvuxMrI7OuQbvrmEdqQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: alexander.deucher@amd.com, siqueira@igalia.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com
Subject: [PATCH RFT 2/3] drm/amd/display: Drop the unused min argument of
 convert_custom_brightness()
Date: Tue,  3 Nov 2026 13:15:58 +0000
Message-ID: <20261103-amdgpu-aux-curve-min-v1-2-62119efdcc6d@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es>
References: <20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5639; i=hugo@hsal.es;
 h=from:subject:message-id; bh=/7p+iESSZHE/QMZNc977HAfsEuJmUySb0GH+smRVVSc=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl7ea95e3fo8WzOitj5Tx/awceSFa9V24crZ3Bkhp
 vZx5mnrz3SUsjCIcTHIiimy6N7wZGCZOHlmTtHzJTBzWJlAhjBwcQrARNI5GBn+7VxquGRu7NO8
 k/vWVd67Lvah5KtV46bWtkZN14Wy/348YGT4uqWgu047r/p1q87LZx0Hzl+TnyPl2vbsvdMDiWN
 PrzZxAgCFJU68
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jJpwz4j4GzMlSH
X-Mailman-Approved-At: Tue, 03 Nov 2026 14:03:04 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

convert_custom_brightness() rescales the curve's output to 0..max since
the previous patch and no longer reads min

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c  |  5 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h  |  3 +--
 .../display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c   | 16 ++++++++--------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 8b49cbcde91cd..cef2ad8fea74d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -192,8 +192,7 @@ static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_c
 
 STATIC_IFN_KUNIT
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-			       unsigned int min, unsigned int max,
-			       uint32_t *user_brightness)
+			       unsigned int max, uint32_t *user_brightness)
 {
 	u32 brightness = scale_input_to_fw(max, *user_brightness);
 	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
@@ -265,7 +264,7 @@ u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
 
-	convert_custom_brightness(caps, min, max, &brightness);
+	convert_custom_brightness(caps, max, &brightness);
 
 	/* Rescale 0..max to min..max */
 	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 9ad888d3ae7b2..32ba2f8efb33b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -68,8 +68,7 @@ ssize_t panel_power_savings_store(struct device *device,
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 			 unsigned int *min, unsigned int *max);
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-			       unsigned int min, unsigned int max,
-			       uint32_t *user_brightness);
+			       unsigned int max, uint32_t *user_brightness);
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 				 uint32_t brightness);
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 2d7a07d9ad874..f1a558516cd8b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -1054,7 +1054,7 @@ static void dm_test_custom_brightness_no_data_points(struct kunit *test)
 
 	caps.data_points = 0;
 
-	convert_custom_brightness(&caps, 3084, 65535, &brightness);
+	convert_custom_brightness(&caps, 65535, &brightness);
 
 	/* No data points → no-op */
 	KUNIT_EXPECT_EQ(test, brightness, saved);
@@ -1078,7 +1078,7 @@ static void dm_test_custom_brightness_debug_mask_disables(struct kunit *test)
 	/* Set the disable flag */
 	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
 
-	convert_custom_brightness(&caps, 3084, 65535, &brightness);
+	convert_custom_brightness(&caps, 65535, &brightness);
 
 	/* Should be no-op due to debug mask */
 	KUNIT_EXPECT_EQ(test, brightness, saved);
@@ -1121,7 +1121,7 @@ static void dm_test_custom_brightness_exact_match(struct kunit *test)
 	 */
 	brightness = 32896;
 
-	convert_custom_brightness(&caps, min, max, &brightness);
+	convert_custom_brightness(&caps, max, &brightness);
 
 	/*
 	 * Exact match: lum=50, brightness_scaled=128
@@ -1167,7 +1167,7 @@ static void dm_test_custom_brightness_below_first(struct kunit *test)
 	 */
 	brightness = 12850;
 
-	convert_custom_brightness(&caps, min, max, &brightness);
+	convert_custom_brightness(&caps, max, &brightness);
 
 	/*
 	 * Below first data point: lum = DIV_ROUND_CLOSEST(40 * 50, 100) = 20
@@ -1211,7 +1211,7 @@ static void dm_test_custom_brightness_interpolation(struct kunit *test)
 	 */
 	brightness = 32125;
 
-	convert_custom_brightness(&caps, min, max, &brightness);
+	convert_custom_brightness(&caps, max, &brightness);
 
 	/*
 	 * The function should interpolate between data points and produce
@@ -1254,7 +1254,7 @@ static void dm_test_custom_brightness_above_last(struct kunit *test)
 	 */
 	brightness = 56533;
 
-	convert_custom_brightness(&caps, min, max, &brightness);
+	convert_custom_brightness(&caps, max, &brightness);
 
 	/* Output should differ from input (remapped via curve) */
 	KUNIT_EXPECT_TRUE(test, brightness != 56533);
@@ -1292,7 +1292,7 @@ static void dm_test_custom_brightness_single_data_point(struct kunit *test)
 	 */
 	brightness = 16448;
 
-	convert_custom_brightness(&caps, min, max, &brightness);
+	convert_custom_brightness(&caps, max, &brightness);
 
 	KUNIT_EXPECT_TRUE(test, brightness < 16448);
 
@@ -1330,7 +1330,7 @@ static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
 	 */
 	brightness = 32125;
 
-	convert_custom_brightness(&caps, min, max, &brightness);
+	convert_custom_brightness(&caps, max, &brightness);
 
 	/* Should remap; result should differ from input */
 	KUNIT_EXPECT_TRUE(test, brightness != 32125);

-- 
2.56.0

