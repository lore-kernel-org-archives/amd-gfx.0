Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7987FCD8CA4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 16:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1685510E8C0;
	Thu, 13 Nov 2025 16:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h45MkuuK";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C0D510E8AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 16:33:53 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47721743fd0so6311845e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 08:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763051632; x=1763656432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ecv2KQfgWZYYSt2linzxpkiFINq6tw/SjaJ2OJ03m4Y=;
 b=h45MkuuKKyIUj4/FU0VrCBvQjJ0dSKLbFz0TmmuMHW0wMbw3X0rFjH1hSKnXhY8BS+
 fJghEZA/gOeE+crCJDlfF9bhNjUmD361Sxmqdia1jxmXy/cvyLW0ucFAY7CkAemobjyd
 fqor+0Jh0Cahe8wCHhYlNK8MmuIDeBEHCzn5PxxtnDs29k2RLGT4Q6JaZVJn2vap+q6a
 zncH3BEmq0y0xFeem9fzsgR5i0S3YYoZ2yiHykU9zDEEEH38CGGsY7Irw74M0g9O2H0U
 wdgy5QbMk6sZGBI+Z38cSuV8aoizRixLDfpP5L+0TzvVNvThKQYUWx8cjIIcNdYdLyX6
 5XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763051632; x=1763656432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ecv2KQfgWZYYSt2linzxpkiFINq6tw/SjaJ2OJ03m4Y=;
 b=FpUw0qVfO9Pu5cvJCMEs5cd+tkRNbSp976Ti2vcnFJp2IVs5eacrdrf5J68VXIb5s3
 CZcTlDzr7rcRnBI0H1M/Ms8qBW34KhrbMpb6OgTuU9dTp1SQoJ1XzJNRqKw5AzYxO3Wk
 fNPGdK9B09sEWpp8Dlnqfr+dvYwIQdl/q1ZSumEkWzjiZDrzmBr7SEmJRE0apxTeImXq
 Xr3eU28gwfUkjvDn9nrSk3FX1SQB84qXyKvA5W5UVgLfmmKZiaiROeIYSsPlAsFE3Z0q
 0zq6H0U2z7nWpgfIgJxR7S9Axjxv55qVJEZ1QyukF37L1z4Njpm5ZsnwildvoEuJCEj1
 inZQ==
X-Gm-Message-State: AOJu0YyTZP3PkrkqBYzLeebOv0LlDkRf5vckdZ4cGVJ6zinvqYD0+obA
 J+wO8MDG2ojMut45GS4k1jiUQjzzxaEc8B/qftci+sXh/OrH8FzLeIIymmA7XA==
X-Gm-Gg: ASbGncunZcVlK1kEAhSbLilaQL5FT6XJUT6pnu6EyqtbxT5oJQrYgMbr+YOwaIowWqQ
 NpOBUYH0WGZTCNQd9/hvQymrDNNHUY7PrYc9ogmLn6JPa70HO1hJeAiEStg1HF/2MQYkqEcKnwk
 DnJwyUfCVSv469M/v7uUpMUBDT0Vn5fjCZOnDDwdfoqOfeEXEPDKb7xs+jzqeSmpHeZtR/Vryfo
 Y432ke55DqDrPomrw+Tziv6qcVhHb0GGv0wjNbNzhrd5miEKh/2RuFlqss10FrZWbDsbB6+BxUY
 FWC5H/0533yWYEqw0jU2NPk6ZLZBcS/VRWWQPP2seohEmybka79Kj9/W6/vqxcQFRo+tMwaseqw
 2ZY/5OTwY1fIHiKfHnUdHjBU4k/c1tJWeFp7r2/LCSgLFJPDZS5i2mO9/Q/xVwzlZqBd9Bhd2mP
 2E9SgB/2sku62FUVBqT0rl6iHeAhNBZjuBTAnwkmKewYHrZ2pSqCtqbdQXWZRmLItcrm1pnHYgj
 0QI38dlblRIN20sGB4=
X-Google-Smtp-Source: AGHT+IHRvNuHGbx8bGHuPrZUe1pcBk8Yt8sDI2xGXJob99H4fiNhsSM0dFMxVMdEHEM+eLhN0KcDSA==
X-Received: by 2002:a05:600c:4585:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-4778fea883bmr911305e9.21.1763051631688; 
 Thu, 13 Nov 2025 08:33:51 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00BA2088E69F553967.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ba20:88e6:9f55:3967])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47789ffea1esm76376335e9.13.2025.11.13.08.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:33:51 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Ray.Wu@amd.com, Harry.Wentland@amd.com,
 Alex.Hung@amd.com, Wenjing.Liu@amd.com, Chris.Park@amd.com,
 Yu.Wang4@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 1/4] drm/amd/display: Fix warning for analog stream encoders
Date: Thu, 13 Nov 2025 17:33:45 +0100
Message-ID: <20251113163348.137315-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113163348.137315-1-timur.kristof@gmail.com>
References: <20251113163348.137315-1-timur.kristof@gmail.com>
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

Fixes the following warning that some users are reporting
with some kernel configurations:

"positional initialization of field in 'struct' declared
with 'designated_init' attribute"

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index f8996ee2856b..574618d5d4a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -1568,7 +1568,7 @@ void dce110_stream_encoder_construct(
 	enc110->se_mask = se_mask;
 }
 
-static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {0};
+static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {};
 
 void dce110_analog_stream_encoder_construct(
 	struct dce110_stream_encoder *enc110,
-- 
2.51.1

