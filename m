Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ECECAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 14:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C24910E759;
	Tue,  9 Sep 2025 14:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QAhagrQH";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56EE10E759
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 14:49:50 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-24c7848519bso58058435ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757429390; x=1758034190; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTY/7V+u1Zf1MbiYH6GnmoJBA/B/ZovnZ5bMMwwETXw=;
 b=QAhagrQHtZX0RXTx3uaqh2q/JC7CDzJONVRj8wSmamuqX5ITOE9wgHjnvkAa+Dz48L
 t1uD6KMYiiyEayk1xU0Sf4JJaAMKuMbl5iQYGgbmzv96dMvcWoiX/qtlCt4dk9Vnkrxg
 m+UWjhvrfgPkUdxn8vNoLNRSFW6rnAK6Za7noTzY3FUyiMv9INH6gZv4x7ofPfOlB8Q3
 QF1thW5x9PWGWA5xIJpZkfYIM6vph+qWMPcaiI8LPMk9OxZY12TfT/vu+qmkRNi2X7Cq
 C8Aj4YFcYFK1oiUkAQ6ubXUzotIV1v8HZz1mXC/drnyvC/6hiZ+L6QOF8SqCST8dOPpp
 dIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757429390; x=1758034190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTY/7V+u1Zf1MbiYH6GnmoJBA/B/ZovnZ5bMMwwETXw=;
 b=j72I7k/3baDP9RB0TLCIT9T/zxO959ih1qFR2M4fuPNvDnt+d31mgYymM23Org50ud
 kgOytYGk9T2vvLT1aRl9YkuYvPZwH1O6KFRd3ux/Um+BL9cEi0WtcbZSP8iHtpfsIlXE
 4EpGNn7lrp6DhBoRZgH/vxdHo6tkucOd1csTogEWlVAZSph3TR/R43RpGo9YtmMcp4Bb
 vy4ECwB3JqYsx2yCBVE2cci5myrbTMED7Wh2CNjHkpHk+2EEObmXlF45eDfx9GQv54QU
 gSrStJ5ms+aPLdf9rL10wBlhHy8BhP3Sr9D209AxCzC+wauHXALFxo0iuriqKtF2HHFv
 aEdA==
X-Gm-Message-State: AOJu0YzraQ5iOr4ZiOOJnIMf2I4vV5A1TrjEnh7Z+fE95C2fQaH1dJbI
 2e8nl1NfrPrr8T0a0YgcvVvGRuAcgFxSktOll4NVytJZzqdSHFqEffb3tkOYjQ==
X-Gm-Gg: ASbGncvTB/jjTilxsekPUcnkCgi+PT2BFfQQDycruX45LBVuEvJ8uLtSq294hdqVvtM
 689JQbE3wYlV3I5G5CkAU6Yuotdd3Hro2PBgs4zhgkycjmkE+Pbtff82srbvscQnWDSfBaLoJJE
 ACwKD7h9AGWd2Rkz+8IDBkcaan6kpuyfLii+fntOBCVj9iYdSw3ubNd0J9XkZZPsdR6d1IjU3sy
 fI2bqK0wYRTJ9xh5Fii78GZv8GZKnAYACwZ9gyPl0WT/HLUGvfrN2DwtUo4CEHPSxTKo+RJJl1m
 cSn40/ta/yiBaUHmSQ8R0V0fX+iNO9ZluhmMfhzOlnUBrXjq3SjJsvPEFbXeCfrThoj0uKcvqqh
 7rTlmZculTtKXQ4Rnyykj+aMTxj9DrJUoqy+1sd1DtxxxjLbmOgLfQ+dJpcezsMhVxEPfpNdMNy
 jH1uB52Ex3yUhFsSH7ZvJtSC0/NXc5c40RH2202g==
X-Google-Smtp-Source: AGHT+IEv8lR6hADMZg16/XLUKq5qPbQqlmOmQto0FfMrZpf/eu2oH7U+Fd8yYwISLCXMWIPeM1aaFg==
X-Received: by 2002:a17:903:18b:b0:24d:37fb:6f38 with SMTP id
 d9443c01a7336-25170395983mr164361265ad.20.1757429390224; 
 Tue, 09 Sep 2025 07:49:50 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D7A10085C74347BA908E23.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:85c7:4347:ba90:8e23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25a2a3449f7sm239455ad.88.2025.09.09.07.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:49:49 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
Date: Tue,  9 Sep 2025 16:49:36 +0200
Message-ID: <20250909144937.22452-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909144937.22452-1-timur.kristof@gmail.com>
References: <20250909144937.22452-1-timur.kristof@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA v3-v5 can copy almost 4 MiB in a single copy operation.
Use the	same value as PAL and Mesa for copy_max_bytes.

For reference, see oss2DmaCmdBuffer.cpp	in PAL:
"Due to HW limitation, the maximum count may not be 2^n-1,
can only be 2^n - 1 - start_addr[4:2]"

See also sid.h in Mesa:
"There is apparently an undocumented HW limitation that
prevents the HW from copying the last 255 bytes of (1 << 22) - 1"

Fixes: dfe5c2b76b2a ("drm/amdgpu: Correct bytes limit for SDMA 3.0 copy and fill")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 1c076bd1cf73..9302cf0b5e4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1659,11 +1659,11 @@ static void sdma_v3_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v3_0_buffer_funcs = {
-	.copy_max_bytes = 0x3fffe0, /* not 0x3fffff due to HW limitation */
+	.copy_max_bytes = 0x3fff00, /* not 0x3fffff due to HW limitation */
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v3_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x3fffe0, /* not 0x3fffff due to HW limitation */
+	.fill_max_bytes = 0x3fff00, /* not 0x3fffff due to HW limitation */
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v3_0_emit_fill_buffer,
 };
-- 
2.51.0

