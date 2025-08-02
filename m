Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AF4C87FC9
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Aug 2025 16:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D0710E05E;
	Sat,  2 Aug 2025 16:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LOfwW6FV";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0361910E05E
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Aug 2025 16:06:08 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45617887276so10907985e9.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Aug 2025 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754150766; x=1754755566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEWg+CESswHXT5k2IDEgCg4s3CWOVSNVF1CEHSsQcUg=;
 b=LOfwW6FVqJl1ZUwsNmI92bc4DWmQyMTVGvrCwapDol+u9lJPMLuWPKg1ZimxTOaoDq
 VaXeEuy4vc0TMkhHf7xpl8X/68jF9dU+xzebvcwTP9rlocltyAuKhoNVyS83nkYRMPik
 EkN/kbBkEsuHAvW2ihN9CF8Cms4KLuz3XKoRiX6Ht0lXG0K11Bt+OCCbhpGg+9RIXdJO
 9S+y+Ds52rhMz610OfWDXskpbzjJNnjRCpk2wNfICa2sQvvkJAXRXGblvmL6PF3NW86W
 fhn4on+v1O6diYEu0q+2Dtv3UTU7Ib5RMMlSkVzVGIfnhLGUmgOUIHwxs6apPUQSJZKB
 lgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754150766; x=1754755566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEWg+CESswHXT5k2IDEgCg4s3CWOVSNVF1CEHSsQcUg=;
 b=h34oBRZcSP+GexM50JQ64oWUvSMa7ncoW7zGYsyBYd5/j5BKE+aq260+Osh5zeWNgJ
 hjhmV9xrmgWJFkpkZjGH1errDbYFXVh4kdvrqklbJkv3aiXZ2Anr2dWojqZFS87EHQ/h
 9A9T7Gw6Dz2IB2TTPOEAdJ8TA/T/tAkys3ZGE3N3EubK9qeGhdsf537L+XyqNRqzuIFt
 EZCtMvhMmUaf69cZoDO8cvkvqbCGPqwWDgOc+pL/tL9F16VN8Kfey7vTE1JdWbMriiVm
 410ufZrtgbaCZEbBKj73szZk2SNgvT9CB35LGiSvc+FF0wehQR6Mjc3F5X/NjdjwfCyV
 5GGQ==
X-Gm-Message-State: AOJu0YxdLLQ9S5jz9/HgIeI/+Zf6P5vJf1TXF82G7hbSnXBUfULZAT+E
 2Y7HWPPuL8OH9JOclpkr7oMNZ9jn6aTz738Xy0JfqVY88GoBHXXBQlXJhzAmxQ==
X-Gm-Gg: ASbGncvRZAhL2+PQz34Izq6FMsBfjW9c166tQDq1zG9CPmV5fFeiO+6juoAdwzdqwcb
 e8z+NrOb5DiCQRTFGGlTZU8MnfjHcemxjC0z1y0X0C6vfKONvMtQOxI+AkmSOpWuiI0vLj3ZQhN
 21AXfpll6IJjoccLyJ8YSK3dF6zZUYEePQdcGsWCm5/rHhBkF1m/RqyI2fS4Ir7+8ScvJInJTKd
 pkOl9s0Bw3UyiG8sEw0DxM/dnuJjqRRG1uX4ZfOEYGMflpEbvEzj91TDfVxas4w1qC3zaBKz04n
 MzBlCcTi9Pd62m/tiHcMQ82o5sjI2GvDCrK/hKWdxdyIkkUaIojisGq5QeJRJvTYo3T8NNMq/Q8
 CXvbWVC47YeOOIZM82ibR5Ps3F8gfwaP9W+nx7P2d/dlZ4ASNIN55jpfV9Rak7PNeAdVZqAv6nP
 lrTBUZ8N9MOlZSdZsKGBA=
X-Google-Smtp-Source: AGHT+IGQWKn6NfziXNvHnniBNdrjB6Q33FDpYRij4k28s28j4xGkw8zxIG4f0eZxRTKEEIOVDh5gxQ==
X-Received: by 2002:a05:600c:1608:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-458b7d12a75mr20052075e9.30.1754150766260; 
 Sat, 02 Aug 2025 09:06:06 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfcc1sm151164245e9.17.2025.08.02.09.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 09:06:05 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amd/display: Disable fastboot on DCE 6 too.
Date: Sat,  2 Aug 2025 18:06:00 +0200
Message-ID: <20250802160602.12698-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802160602.12698-1-timur.kristof@gmail.com>
References: <20250802160602.12698-1-timur.kristof@gmail.com>
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

It already didn't work on DCE 8,
so there is no reason to assume it would on DCE 6.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 153d68375fa3..1d57df7fc948 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1923,10 +1923,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	// Check fastboot support, disable on DCE8 because of blank screens
-	if (edp_num && edp_stream_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_3) {
+	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.50.1

