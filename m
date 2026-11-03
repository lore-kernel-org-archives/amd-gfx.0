Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6F606A326
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=kfChmfor
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55D610FB73;
	Wed,  4 Nov 2026 11:12:37 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65B610F705
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 16:31:31 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jJvGV2JW9zKsZk;
 Tue, 03 Nov 2026 17:31:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793723490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibSkVX6FYpPn4JItVfLzH5GGe4yXRPmU4iWn4WAzOAY=;
 b=kfChmforTN5G5oYpP55O3Xn5d9gMexD/FJ8xysQ3hRfiYXHg3pd+2iseVamaLtmdKJpAyV
 lTljLToN24/AKKaE16dcIa/7qZo2KuiZcHUZXcohSaptfSrB1Da7kMwRkcPGNmbBU57WQJ
 ipqu4YsQxY7jtdaNz0zv/PaeBbwqwlqTzlCF14eNrGSE4M5edwxvkkBfo7/Eu26hqLJTu6
 /F3ZOxksbxwhabSYghSPvERLAAEASDrsujb/YqhxXLdVMJC20AuKZLQ328+GRauofo6dgs
 rG4p2DwWOfA80qe39npfrxamCVtjKzDVmMjp+hTYFOSFdqcJz/FMNxX1qZN5/w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: alexander.deucher@amd.com, sunpeng.li@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH RFC RFT 4/8] drm/amd/display: Stop rounding PWM brightness to
 whole percents
Date: Tue,  3 Nov 2026 16:31:18 +0000
Message-ID: <20261103-backlight-curve-rfc-v1-4-6e4813a8f2eb@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
References: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6476; i=hugo@hsal.es;
 h=from:subject:message-id; bh=6Uv5ki6/5lQQciXOXLyDJYcI2VUTZe4awEsZscvRkmo=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl7xRHm+28Cy3VOJTaBRhTVNuKdNIcXKf87aW2fst
 N7+UhD/y9hRysIgxsUgK6bIonvDk4Fl4uSZOUXPl8DMYWUCGcLAxSkAE7mqxPC/nL27J2Hhh0Ir
 0ZV19a7J6sfO6G1dEvomo3HPeYcAgR+TGP4Zfmy3fH8kXV/5Us8Ps13LLm/WFV01RfNU/iS7+Vo
 q2tPZAbzLR88=
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jJvGV2JW9zKsZk
X-Mailman-Approved-At: Wed, 04 Nov 2026 11:12:26 +0000
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

Since commit d422a66847a9 ("drm/amd/display: map PWM brightness through
custom backlight curve"), convert_brightness_to_millipercent() rounds the
16-bit user level to an 8-bit signal and the luminance to a whole
percent, so the power module gets at most 101 levels

Interpolate on the unrounded user level and round once, to millipercent.
The curve and its segments stay the same, and a result over 100% is
still capped

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
On the GV301QH curve, minimum 12 and 49 points, the 62452 levels from
user_min to user_max gave 99 different millipercent values and now give
62112

The curve's first point is 2% at signal 14, and below it the curve is a
line from 0, so the minimum, signal 12, should get 2% * 12 / 14, which
is 1714 millipercent. It now gets exactly that instead of 2000, and
every other level also gets the curve's value instead of the nearest
whole percent

Since patches 2 and 3 the power module's LUT keeps those steps. On
the same curve the levels reach the panel as 57821 different PWM values
instead of 99

backlight_custom_curve_scale() maps 0..user_max to 0..output_max, with
the curve reaching 100% at signal_max. The two weights of the
interpolation can't go negative. A luminance is a u8, so before the cap
the result is at most 2.55 times output_max. The divisor can pass 32
bits, hence mul_u64_add_u64_div_u64()

With no data points the mapping stays linear. Above the last point the
curve still runs to 100% at max_input_signal, and points above
max_input_signal are still interpolated as before. Past a last point
above max_input_signal the curve runs on to 100% at signal 255. Before,
the divisor wrapped there and the level stayed near that point's
luminance. The top level still gives 100% when a point at
max_input_signal claims less

KUnit: the PWM tests from patch 5 fail without this patch and pass
with it
---
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 79 ++++++++++++----------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 3b59699e74287..900c17e0285c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -39,6 +39,7 @@
 #include "modules/inc/mod_power.h"
 
 #include <linux/backlight.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/power_supply.h>
 #include <drm/drm_edid.h>
@@ -128,53 +129,59 @@ static inline u32 scale_fw_to_input(int user_max, u64 input)
 	return DIV_ROUND_CLOSEST_ULL(input * user_max, AMDGPU_MAX_BL_LEVEL);
 }
 
-static u32 backlight_signal_to_luminance(const struct amdgpu_dm_backlight_caps *caps,
-					 u32 signal)
+/*
+ * Map user level 0..user_max to 0..output_max through the custom curve,
+ * which ends at 100% at signal_max, or at AMDGPU_MAX_BL_LEVEL when the
+ * last point lies past signal_max. A point at signal s sits at user
+ * level s * user_max / AMDGPU_MAX_BL_LEVEL, so compare
+ * user * AMDGPU_MAX_BL_LEVEL against s * user_max rather than rounding the
+ * user level to 8 bits
+ */
+static u32 backlight_custom_curve_scale(const struct amdgpu_dm_backlight_caps *caps,
+					u32 user, u32 user_max, u32 signal_max,
+					u32 output_max)
 {
-	u32 lower_signal, upper_signal;
-	u32 lower_lum, upper_lum;
+	u64 x, x0 = 0, x1, num, den;
+	u32 l0 = 0, l1 = 100;
 	int i;
 
+	user = min(user, user_max);
 	if (!caps->data_points)
-		return DIV_ROUND_CLOSEST(signal * 100, AMDGPU_MAX_BL_LEVEL);
-
-	if (signal < caps->luminance_data[0].input_signal) {
-		lower_signal = 0;
-		lower_lum = 0;
-		upper_signal = caps->luminance_data[0].input_signal;
-		upper_lum = caps->luminance_data[0].luminance;
-	} else if (signal >=
-		   caps->luminance_data[caps->data_points - 1].input_signal) {
-		lower_signal = caps->luminance_data[caps->data_points - 1].input_signal;
-		lower_lum = caps->luminance_data[caps->data_points - 1].luminance;
-		upper_signal = caps->max_input_signal;
-		upper_lum = 100;
+		return DIV_ROUND_CLOSEST_ULL((u64)user * output_max, user_max);
+
+	x = (u64)user * AMDGPU_MAX_BL_LEVEL;
+	for (i = 0; i < caps->data_points; i++) {
+		u64 xi = (u64)caps->luminance_data[i].input_signal * user_max;
+
+		if (x < xi)
+			break;
+		x0 = xi;
+		l0 = caps->luminance_data[i].luminance;
+	}
+
+	if (i < caps->data_points) {
+		x1 = (u64)caps->luminance_data[i].input_signal * user_max;
+		l1 = caps->luminance_data[i].luminance;
 	} else {
-		for (i = 1;
-		     i < caps->data_points &&
-		     signal > caps->luminance_data[i].input_signal;
-		     i++)
-			;
-
-		lower_signal = caps->luminance_data[i - 1].input_signal;
-		upper_signal = caps->luminance_data[i].input_signal;
-		lower_lum = caps->luminance_data[i - 1].luminance;
-		upper_lum = caps->luminance_data[i].luminance;
+		x1 = (u64)signal_max * user_max;
+		if (x0 > x1)
+			x1 = (u64)AMDGPU_MAX_BL_LEVEL * user_max;
+		if (x >= x1)
+			return output_max;
 	}
 
-	if (upper_signal == lower_signal)
-		return upper_lum;
+	/* x0 <= x < x1, so neither weight wraps */
+	num = (u64)l0 * (x1 - x) + (u64)l1 * (x - x0);
+	den = 100 * (x1 - x0);
 
-	return lower_lum + DIV_ROUND_CLOSEST((upper_lum - lower_lum) *
-					     (signal - lower_signal),
-					     upper_signal - lower_signal);
+	return min_t(u64, mul_u64_add_u64_div_u64(output_max, num, den / 2, den),
+		     output_max);
 }
 
 static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
 					      u32 user_brightness)
 {
 	unsigned int user_min, user_max;
-	u32 signal, luminance;
 
 	if (!get_brightness_range(caps, &user_min, &user_max))
 		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000,
@@ -184,10 +191,8 @@ static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_c
 	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
 		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000, user_max);
 
-	signal = scale_input_to_fw(user_max, user_brightness);
-	luminance = backlight_signal_to_luminance(caps, signal);
-
-	return min_t(u32, luminance * 1000, 100000);
+	return backlight_custom_curve_scale(caps, user_brightness, user_max,
+					    caps->max_input_signal, 100000);
 }
 
 STATIC_IFN_KUNIT

-- 
2.56.0

