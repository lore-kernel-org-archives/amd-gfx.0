Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDDDFF886D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00ADE10EB47;
	Tue, 28 Apr 2026 11:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="peeNI/Uf";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF1F10EB35
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:40:51 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso57264455e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777376450; x=1777981250; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+bzWTdKaysA7BbwlM91rZ+tGHY/F6qcGQbIhFEiY4I=;
 b=peeNI/UftCFYS3uCl92A3MbvzRZA/Gn55GNJGKuZKh/28mz7rNUKM2TG2B2fTCN9tb
 T0zJ53MmX2rCxEC6BSoWJLDH2kKyyywyVxXpYxLhpcoxtrQ+ucelIwgpVYDx88Mr0Bpp
 gz+FUBHV0mvLoir4sBWPnGydXUcdbrlID+PWU8KCoij6qtWM6Eh5N9vAqP096tgmsgx6
 g8HL/85C6P8bH6DGKB3sPQ5I7IV7VZjbEpsm0qyI+IEulpyXgOhWDhvB0kqmu+lhfIOc
 0T/6fULcsgRND/enX+EX/+6g+RifXU1z3dwh42qPGRWyOwtXRQ1k5UAVZy8Apf0x2ie9
 6FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376450; x=1777981250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9+bzWTdKaysA7BbwlM91rZ+tGHY/F6qcGQbIhFEiY4I=;
 b=GFMfguumZLnqrBHo/5JPH6esXuugNGboINAj+pQa1h6RU+0QGFPD2I4Z/h3pOpS4Yz
 vFztJj4QWp7+BwGjecdxSg3kWiMtLWHQmiFd59yThWgEo2DJrizqC+0UYucCxqQiGGWS
 sYM/ksZPwUfmmy76rEuWFa/MOWCbWO4Dm4/0VuNSvZqJwB/k7DwkvRK3+q9WjIumlWnx
 RiKsb4E4EPoAJf6thCXw8hPpXcocpfAm07UJeTw+ZmIZsP0M5LZP56F48huIrhn/AufM
 OspH1D/oVEIQezIq+f9PodxqXD9+5ugijwvAcbfndKOXbpUB/68a0ELjUS++e+JZC7Wa
 2OlQ==
X-Gm-Message-State: AOJu0YxvTrvJDRx2iD4Cb83m6NtaC/Flp42KrsCSu0WKM1GE+lDyNgd/
 myXwU+tMxvVxGPNZcgO1ZKjtGM4aoUNXLjtzkqAXlH1QuhprhT/Vxs7EGwjFcjeO
X-Gm-Gg: AeBDies5KbF5JjPuD1mBiBtoOUvubjDT6xxv+Afxzx4KWW3yN1Qp8JLy8LLKvTGwJ/a
 NjAJZcuwm3tGqaqg7QUGI+0wV9eHVIg8TuNzxQTXqE7/+89pmB7sl9kM6sMN57cWuyxcRJzIbYL
 9zYL5SF+z3xZK/9MomQOD11blDCM2teQ5kfDCTeho2viJLfBwjTx9UriRgN9wh/i+t5WCs2rtM5
 ObHIPj4Q+4N/bNS4NoE713u1IiXZQAEHVdIfi2/mXe7ww3pSxoonkkKT6Xll71oQb2Ejjv8fufx
 PEjojoaMO/g81p9OJWJWEAgCb0V+ur0g6ve64NUMMbzG9kKMMd1y2NqjX2LX1NhVl1GI4Kvl1Gz
 m8E29J1J68ouHsVlgo3rE9Zz47V29SDR3Gy5Gnr5NSv2AtDriOP4niUvufNA2m1PDiT74cgko7s
 Zbn8DgmbvrRUTum00VI3NzBiGL+Yg+Lzb74CdBhVrRKP6ys1h4mZhkEhFo2UK5AngBQKR4emz0u
 ToElwXPXeO2OIk=
X-Received: by 2002:a05:600c:630a:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-48a77ae0340mr53064865e9.5.1777376450162; 
 Tue, 28 Apr 2026 04:40:50 -0700 (PDT)
Received: from Timur-Hyperion.home (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775e4bd0sm25048275e9.8.2026.04.28.04.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:40:49 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/6] drm/amd/display: Allow DCE link encoder without AUX
 registers
Date: Tue, 28 Apr 2026 13:40:41 +0200
Message-ID: <20260428114045.40710-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428114045.40710-1-timur.kristof@gmail.com>
References: <20260428114045.40710-1-timur.kristof@gmail.com>
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

Allow constructing the DCE link encoder without DDC,
which means the AUX registers array will be NULL.

This is necessary to support embedded connectors without DDC.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5192
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 5f40ae9e3120f..e15fd1454d3b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1102,7 +1102,9 @@ void dce110_link_encoder_hw_init(
 		ASSERT(result == BP_RESULT_OK);
 
 	}
-	aux_initialize(enc110);
+
+	if (enc110->aux_regs)
+		aux_initialize(enc110);
 
 	/* reinitialize HPD.
 	 * hpd_initialize() will pass DIG_FE id to HW context.
-- 
2.53.0

