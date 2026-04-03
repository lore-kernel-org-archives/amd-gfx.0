Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ED0E7E35E
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 09:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D3110F485;
	Fri,  3 Apr 2026 09:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PI4BWz3Z";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B5D10E4EE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 08:22:26 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-38be66a9fc0so22434611fa.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775204545; x=1775809345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OoBcZm06Ka/jy/EkbXTQ5nbauHlGfVYOrcx3b8Ix9uY=;
 b=PI4BWz3Z3Hu+pfxfQhFetXFIE1kUlbF6DKDYl1BFe82mVABwtMV3qldHSjcXzsfbJ/
 LEuDAx2NkP/xT0DqAQK0FlOYFHUdavh/mdKqmp2zm4llsOhcIt7ddBP9xzoWw/Ci+THv
 bYw4QPEZb/lAvXnQye0lwgdLj+ZuvgCOFZKZJxTeWkjifI7JOc5iTEHlZo4q6nKmKo5R
 L1d1Zl0JYje5ZeMbMm1dSv0wnMDguSpl6ELebGIczuEyorPYwXtBJcZfJyDFQrC8u1iY
 BmhQGIhWzT/p4h7YIgVieC/uIwuPsUq7NyduOG6OkjjAkMPMJPOcaMvi9Hh5PAEj2Dyk
 /0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775204545; x=1775809345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OoBcZm06Ka/jy/EkbXTQ5nbauHlGfVYOrcx3b8Ix9uY=;
 b=DM3fzVfLO3LEibI6WD3Akx2eVuKBh6cpUkj9GkZU2LyqMgmHQNeGSB7DeDFc4PV8BK
 GEqtVm9Ifdj0CI2eTTwPEg476fDOZuiD3NkHHmB86Ipt/ha57wIq0fMR/GVOhuyQ4ZX/
 hDlE9Qvztj9q5PLQagJA+IOWYDWR3sp9VizqGvWkUuRS0ajf3Fk7aCja1HsMOvlH/5rc
 ntocdPjd69PjHC85nYt6PWm3k5VZsJrVAHC1HLh2tw6zsW9INGl0EenOsUCOYFz4rC+m
 WkoSZeB0RTwEo2MHld1ScPzRH7wS5Z8K/jIR2lRD53Vd5/+MC92+7t3voFt3VXn1eGwJ
 lGNA==
X-Gm-Message-State: AOJu0YzI64+oavzE5JEPj4rx4prtdfF+aSv2+bDl1d3WfUqdLIuX4O0m
 Hq9y177GhUJkEovlZfPsD/dd36fyoXTyvdKJz22/VObgCY9d8R5mixxT
X-Gm-Gg: AeBDievXxK0f7ukIUmFeqk1c19KjhVg6LQ6U0LizbG/ixep3XncLThilCHyvg8qwdin
 G4YSuTP0DRyG0Z8yzCRj1iN8BnWB0vrYn9JhY+1gj9I8BMtwyHYLGTbttAspXX/BxbEbezR+eSl
 Hj4WdZ05kFBHsbBOFRm22Vz4rEQN8B2R2oEG3x6hLO27ALVbii27OCc2Lrsb9blJ7+nL+6AAupv
 ROBRSRYvZbMGM9IjIa4Ehkln2BV6Moicst6WNRuD4BZ7D3OxVqeRP1Fn57Ovn0j7PxX1IHcR9fZ
 WX1RxKLWOhBmPOAuZj2U4LM4Rtwm6Km2uC3UN4IhBxYgeSvLXicyAhxjMLUNLRTr2ey7RhlrtwV
 hcghT86/1CKA+oa1pZEkY37dsNfiEpu26tY3m/hvMVC0pzgbTLNLDvrrwW55S3DZYC6MUGwD8Wb
 tqe0JBWK80p13zOjskJFbs5CUeQ2z+ZHa4YWEAREEQH27WlIjOeDla
X-Received: by 2002:a2e:9a11:0:b0:38b:fd3e:c445 with SMTP id
 38308e7fff4ca-38d8d34c11bmr5680411fa.3.1775204544823; 
 Fri, 03 Apr 2026 01:22:24 -0700 (PDT)
Received: from localhost (94.191.136.33.mobile.tre.se. [94.191.136.33])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd20088a8sm10866661fa.18.2026.04.03.01.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 01:22:24 -0700 (PDT)
From: Linus Probert <linus.probert@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linus Probert <linus.probert@gmail.com>,
 "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH 1/2] drm/amd/display: Replace inline NUM_ELEMENTS macro with
 ARRAY_SIZE
Date: Fri,  3 Apr 2026 10:22:06 +0200
Message-ID: <20260403082207.1533450-2-linus.probert@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403082207.1533450-1-linus.probert@gmail.com>
References: <20260403082207.1533450-1-linus.probert@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 09:29:14 +0000
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

Replaces the use of local NUM_ELEMENTS macro with the ARRAY_SIZE macro
defined in <linux/array_size.h>.

This aligns with existing coccinelle script array_size.cocci which has
been applied to other sources in order to remove inline
sizeof(a)/sizeof(a[0]) patterns from other source files.

Suggested-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Linus Probert <linus.probert@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 5 +++--
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 052d573408c3..d42d7befef42 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -23,6 +23,8 @@
  *
  */
 
+#include <linux/array_size.h>
+
 #include "dm_services.h"
 #include "core_types.h"
 #include "timing_generator.h"
@@ -40,7 +42,6 @@
 #include "dcn10/dcn10_hubbub.h"
 #include "dce/dmub_hw_lock_mgr.h"
 
-#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
 #define MAX_NUM_MCACHE 8
 
 /* used as index in array of black_color_format */
@@ -230,7 +231,7 @@ const uint16_t *find_color_matrix(enum dc_color_space color_space,
 	int i;
 	enum dc_color_space_type type;
 	const uint16_t *val = NULL;
-	int arr_size = NUM_ELEMENTS(output_csc_matrix);
+	int arr_size = ARRAY_SIZE(output_csc_matrix);
 
 	type = get_color_space_type(color_space);
 	for (i = 0; i < arr_size; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 5722be965422..9d043cc35eb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -23,6 +23,8 @@
  *
  */
 
+#include <linux/array_size.h>
+
 #include "dm_services.h"
 
 
@@ -57,8 +59,6 @@
 #define CALC_PLL_CLK_SRC_ERR_TOLERANCE 1
 #define MAX_PLL_CALC_ERROR 0xFFFFFFFF
 
-#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
-
 static const struct spread_spectrum_data *get_ss_data_entry(
 		struct dce110_clk_src *clk_src,
 		enum signal_type signal,
@@ -1267,7 +1267,7 @@ const struct pixel_rate_range_table_entry *look_up_in_video_optimized_rate_tlb(
 {
 	int i;
 
-	for (i = 0; i < NUM_ELEMENTS(video_optimized_pixel_rates); i++) {
+	for (i = 0; i < ARRAY_SIZE(video_optimized_pixel_rates); i++) {
 		const struct pixel_rate_range_table_entry *e = &video_optimized_pixel_rates[i];
 
 		if (e->range_min_khz <= pixel_rate_khz && pixel_rate_khz <= e->range_max_khz) {
-- 
2.53.0

