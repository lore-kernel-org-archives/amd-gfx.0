Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C105EB64DD
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Jul 2023 02:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC15510E0FA;
	Sun,  9 Jul 2023 02:07:10 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B25810E0FA
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Jul 2023 02:07:06 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3143798f542so3489377f8f.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Jul 2023 19:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1688868423; x=1691460423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60o/nWori7rZGRVwTOHCQXMbpCTqRc2BUXr5Z8sBOTc=;
 b=LzO/Wsh+YaIqvU7HVengG6HdPn2I1RaW9XvpLX6+g5HN79WoAy+rAOkv3eyfjTqlZY
 QvEG/AHaYpbyQZlFirXj5azUtldi979nk69O1uW9YI7Ae4+h6GFbCc5KY7hdULjnx4/6
 mRbvpBqEIR6ygcd3Aovq7GO5KP1SqyZX+kW6hH3J2YdRZ92SmDL4AoMI6kod9DtpKm69
 dnp8IugiWg3BUWj72z0Qh6mx957kG3x/fuOSYp+AI47Ogub5U6LnBP7k3WStZPzndjc3
 sHOluFCbjiFZXZ5Eyg6JEbG2p3gHUc+e2b6W0iwsetbI+CykIDR0MPGRR6E44sdyh5uq
 SjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688868423; x=1691460423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=60o/nWori7rZGRVwTOHCQXMbpCTqRc2BUXr5Z8sBOTc=;
 b=IXG46lUL8dtHWD/9Cak31N4uLT9V/bg2Q7EpjicK4JNXbXsLTNBO6lMzsMTdHJ/hW2
 9akKmxyHEgYsYu9hN7zGv1mEJkexlu9CV97rglLQZ2K7Vg4uhMAaeDHYUrRZZ8EwgB1m
 +vLxhbp01AceXVNSyhJfvIPh156tYu50OIXZfl64VYlODdAxxUticLg5e8b+VZn4eooF
 Yj8sSz27d9/1lxoNz3yIV1TWDcDFx5FKzH12zAMiE4qWVmSO5D1liDfhCdtXwgKmR7BB
 JCPBws80HfsCkrDVc9w4rjYKx/FGPkdyM2dYFPw8xnjKE7FU7QttcegeYlb9c1/Uf7P7
 hgig==
X-Gm-Message-State: ABy/qLbNEYmcto3MwD09+TqJPn1xJsy4lEPchD6NmGez1+QzcatM0HD9
 px3hp7SEJTTZeLEm8kOgdIpefJS+/yN/Pk4aMUM=
X-Google-Smtp-Source: APBJJlFItGZoDptTDM9mBVIT+hvAkoHqN567vsDODHYDuDy1Uf1FKTNllHBD5806kvg9U5fWDNDtIQ==
X-Received: by 2002:a5d:504d:0:b0:314:1582:6eb4 with SMTP id
 h13-20020a5d504d000000b0031415826eb4mr6465868wrt.46.1688868422993; 
 Sat, 08 Jul 2023 19:07:02 -0700 (PDT)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a5d4e90000000b0031424f4ef1dsm8120934wru.19.2023.07.08.19.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jul 2023 19:07:02 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/display: Enable 3 plane for DCN 3.01
Date: Sun,  9 Jul 2023 03:06:57 +0100
Message-ID: <20230709020700.3116749-2-joshua@froggi.es>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709020700.3116749-1-joshua@froggi.es>
References: <20230709020700.3116749-1-joshua@froggi.es>
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
Cc: Melissa Wen <mwen@igalia.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <harry.wentland@amd.com>, Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Steam Deck/Gamescope wants to take advantage of more planes which is
possible on VanGogh but was not previously exposed.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 3485fbb1093e..94eefebd4607 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1425,9 +1425,9 @@ static bool dcn301_resource_construct(
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-	dc->caps.max_slave_planes = 1;
-	dc->caps.max_slave_yuv_planes = 1;
-	dc->caps.max_slave_rgb_planes = 1;
+	dc->caps.max_slave_planes = 2;
+	dc->caps.max_slave_yuv_planes = 2;
+	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.is_apu = true;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
-- 
2.41.0

