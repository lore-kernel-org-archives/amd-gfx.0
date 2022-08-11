Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1479FC19F2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 20:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF408F027;
	Thu, 11 Aug 2022 20:44:00 +0000 (UTC)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3E88A9D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 20:43:46 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id 66so19472403vse.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=tAr5czlyrtpQZ0Z4eH7d9lX12qOJP5ahY1mGGY4g2qs=;
 b=ItAll9g0jVcozq2krEPLgM8DuEdEsSPs9XGN3lKT1ggUsmBnT+gH3c1mcdPfxRIpON
 4sfGUvAovm9eZXYmp2Q+pzCcLpjPtNq+k8xDYcw8c/RhXS1aXnng70i9W837YqyMO63J
 afpcOoaHGXkziRnGoOhmKDI5BoTFaVCt+GeHE+petgK+XjwZBv1DDNlbrkJdlVdjqTBW
 XFosVTv4ON9QKZcg0mrGptG/c3QZyTmE+egSkLnx+6ngaLzLwzxQ0hC7HiHguzFXYKqK
 MEWvMPlRpWTR051kkk0qQU0HFDAsWLFM/IOzMkFjcck8yRJh/ap27/VUFPBDjXNMU0aq
 y8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=tAr5czlyrtpQZ0Z4eH7d9lX12qOJP5ahY1mGGY4g2qs=;
 b=5LhymggIr7Fz1jHKY1cvuKc9ijNKXnoRxH15LVxtquO5Iu72FUuGWEH4prkZ8Q5hma
 ouQm6VSbCxFzcHpKCXh6id4DUQO01zJBH/JZIMkJcOckOjmkj9LZeJ0hoItOnNPkUlJr
 F6Oe6Gx3++O794DY1nPoJ+O13+gzJgTFyhPrAJIEnXYfzI27rgAb/srymzOth6hHD7T0
 kjWsJpRvtV6C4xqJ/rP33lZ0Y3pfFBf/ro6Vmc+lQkTh+ADS1IUAPsJstfkvS8a/fTyS
 d6a3rZMNjZEZgREXyXW9aG7AcQW/ewrRlX8cxL2LZx/X1H4wvK+f7DExljkCZrboRA7K
 TlbQ==
X-Gm-Message-State: ACgBeo2VIoStxzu5vDsalcyRrY8cp6Y1gak8YaAPv+5bIIsNEUGpCa2N
 V5QiM8wIjeAvFWx/h5mYTcs=
X-Google-Smtp-Source: AA6agR7HVh/yQRS22rWt+dWwMz0LtRTCK7dc0ye63GFdfBJL71zGFPV6NQvpP01FT8KRk79sV7z7og==
X-Received: by 2002:a05:6102:34e4:b0:388:997d:3274 with SMTP id
 bi4-20020a05610234e400b00388997d3274mr396738vsb.0.1660250625900; 
 Thu, 11 Aug 2022 13:43:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a67ee97000000b00388d3be20bfsm226846vsp.28.2022.08.11.13.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 13:43:45 -0700 (PDT)
From: Tales Aparecida <tales.aparecida@gmail.com>
To: davidgow@google.com, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 2/2] drm/amd/display: fix minor codestyle problems
Date: Thu, 11 Aug 2022 17:43:27 -0300
Message-Id: <20220811204327.411709-3-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220811204327.411709-1-tales.aparecida@gmail.com>
References: <20220811204327.411709-1-tales.aparecida@gmail.com>
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
Cc: siqueirajordao@riseup.net, magalilemes00@gmail.com,
 tales.aparecida@gmail.com, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 mairacanal@riseup.net, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes five checkpatch warnings:

CHECK: Please don't use multiple blank lines
+
+

ERROR: Macros with complex values should be enclosed in parentheses
+#define MAX_I64 \
+       (int64_t)((1ULL << 63) - 1)

WARNING: Missing a blank line after declarations
+       struct bw_fixed res;
+       ASSERT(value < BW_FIXED_MAX_I32 && value > BW_FIXED_MIN_I32);

ERROR: that open brace { should be on the previous line
+               do
+               {

ERROR: that open brace { should be on the previous line
+                       if (remainder >= arg2_value)
+                       {

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
index 2d46bc527b21..3aa8dd0acd5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
@@ -25,9 +25,8 @@
 #include "dm_services.h"
 #include "bw_fixed.h"
 
-
 #define MAX_I64 \
-	(int64_t)((1ULL << 63) - 1)
+	((int64_t)((1ULL << 63) - 1))
 
 #define MIN_I64 \
 	(-MAX_I64 - 1)
@@ -49,6 +48,7 @@ static uint64_t abs_i64(int64_t arg)
 struct bw_fixed bw_int_to_fixed_nonconst(int64_t value)
 {
 	struct bw_fixed res;
+
 	ASSERT(value < BW_FIXED_MAX_I32 && value > BW_FIXED_MIN_I32);
 	res.value = value << BW_FIXED_BITS_PER_FRACTIONAL_PART;
 	return res;
@@ -78,14 +78,12 @@ struct bw_fixed bw_frc_to_fixed(int64_t numerator, int64_t denominator)
 	{
 		uint32_t i = BW_FIXED_BITS_PER_FRACTIONAL_PART;
 
-		do
-		{
+		do {
 			remainder <<= 1;
 
 			res_value <<= 1;
 
-			if (remainder >= arg2_value)
-			{
+			if (remainder >= arg2_value) {
 				res_value |= 1;
 				remainder -= arg2_value;
 			}
-- 
2.37.0

