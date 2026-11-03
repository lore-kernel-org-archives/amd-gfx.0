Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE372606D820
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=Tgp8A1P2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C96010F5C9;
	Tue,  3 Nov 2026 14:03:10 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC0010F59A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 13:16:05 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jJpx038SvzMlq7;
 Tue, 03 Nov 2026 14:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793711764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pK5t0q/gxE1Nu6Fm0VfdXEgog8ffotRhenMS/ypUv9s=;
 b=Tgp8A1P2S84PfEtYEHzUvaSgO72Dan/HE0W4pBt0cywS7rO11Ns329gEtglyzTWnkuX0QV
 bvFvjWZNdsxa9OYgCtYonp7D6eZMwBo7VuTFGg9LrIsLZ77nEZMZbSv3c1l+w7z9drM9Eh
 xlDnMyKzmtd3c/gYU1F9l7Q/fU6urV4Fq+1S7FEvgg7jSfjvWs38M30MJDqfBebbYQXJL0
 HQXgTKytLsRYJtshlv+0vhuLiDYkIG/Gzn3JWvRGVzhTw88jawrem/MvwPWCknTACXd89/
 liOf4QZ5vfVtnZtr/hH2QydBQDJDIIP8HpxataK8XoU1LOb4UNBAoysUVDE3aA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: alexander.deucher@amd.com, siqueira@igalia.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com
Subject: [PATCH RFT 3/3] drm/amd/display: Add a KUnit test for the custom
 curve minimum
Date: Tue,  3 Nov 2026 13:15:59 +0000
Message-ID: <20261103-amdgpu-aux-curve-min-v1-3-62119efdcc6d@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es>
References: <20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143; i=hugo@hsal.es;
 h=from:subject:message-id; bh=fwMloafcOCb62tF/mTB0iLUFV8bG+uqiU3emqEw7j9A=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl7ea97/zJmlxP/AzZzTJ1+YhB740LS9g+PAw0Zr/
 VOv/s6os+vtKGVhEONikBVTZNG94cnAMnHyzJyi50tg5rAygQxh4OIUgIlcbGX47zWh/8OKe7sE
 JswJvvtDftr/vs+75/ZP+cHaIS8vcEzwuA4jwxaxdSynCjXnZ3HwTX7u+CNg8mnbq47vj+uyssz
 8Ei9SzAQA4HRPIA==
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jJpx038SvzMlq7
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

Check that convert_brightness_from_user() adds the minimum once with a
custom curve: a request for 0 gives user_min on the AUX and the PWM
range, and half the AUX range matches a value worked out by hand

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
KUnit on UML with PROVE_LOCKING: amdgpu_dm_backlight passes 74 of 74.
Without patch 1 the new test fails with 1998, 131999 and 6023
---
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index f1a558516cd8b..3d00cde8c77bc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -1383,6 +1383,45 @@ static void dm_test_brightness_from_user_midrange(struct kunit *test)
 	KUNIT_EXPECT_LE(test, result, max);
 }
 
+/**
+ * dm_test_brightness_from_user_curve_min - Test Custom curve adds the minimum once
+ * @test: The KUnit test context
+ *
+ * On the AUX range of 1..512 nits with points (50, 20%) and (200, 80%), a
+ * request for 0 must give the 1000 millinit minimum, where adding the
+ * minimum twice gave 1998. Half the scale is signal 128, luminance 51%,
+ * so 51 * 128 / 101 = 65 of 255, which is 1000 + 511000 * 65 / 255 =
+ * 131255. A request for 0 on the PWM range with min_input_signal 12 must
+ * give 12 * 0x101
+ */
+static void dm_test_brightness_from_user_curve_min(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() &
+				    ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+
+	caps.aux_support = true;
+	caps.aux_min_input_signal = 1;
+	caps.aux_max_input_signal = 512;
+	caps.min_input_signal = 12;
+	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	caps.data_points = 2;
+	caps.luminance_data[0].input_signal = 50;
+	caps.luminance_data[0].luminance = 20;
+	caps.luminance_data[1].input_signal = 200;
+	caps.luminance_data[1].luminance = 80;
+
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), 1000U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 256000), 131255U);
+
+	caps.aux_support = false;
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), 12U * 0x101);
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
 /**
  * dm_test_brightness_from_user_with_curve - Test Brightness from user with custom curve active
  * @test: The KUnit test context
@@ -1976,6 +2015,7 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_brightness_to_user_above_max),
 	KUNIT_CASE(dm_test_brightness_from_user_midrange),
 	KUNIT_CASE(dm_test_brightness_from_user_with_curve),
+	KUNIT_CASE(dm_test_brightness_from_user_curve_min),
 	KUNIT_CASE(dm_test_brightness_range_zero_signals),
 	/* amdgpu_dm_backlight_fill_props */
 	KUNIT_CASE(dm_test_backlight_fill_props_ac_linear),

-- 
2.56.0

