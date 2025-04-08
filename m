Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A5FC369A6
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 02:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B1410E5A0;
	Tue,  8 Apr 2025 02:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vzrf7WKx";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D799910E1FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 02:11:34 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c5675dec99so555625885a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 19:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744078294; x=1744683094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DUzn7fjvVJqyu8tREIvUwjqWhf8w67yKfaORndYqiv8=;
 b=Vzrf7WKxbm8+QfZVY0jUoyjVfcyOVLOPwwD2MIOKwcSQ0myL+sxWWjEXiLgcSPaI5C
 A1nKuFCAv8HN9/spNBNF6a+w48X2wcCjqi7oLuG5CTIh4TM9Z8l+c8Etd09vlqyY3GwS
 pWMsp3bZ9GhM43kiB0K2uENtYNU9W3DcKdJd9Rl3y2Z+UHzXbFjVH67TMo+JoCuh2vbC
 PWhfaKSTA4nS9mYFA7WMhGoKUoRN++12Kd8owmqnbpbp57Ez7H6YtwxSA7l+QjFuRQA1
 j9KG5d5jXCbfJAO8MEFm2k4l5GuBeQN15reaQJBwfB78FWBS/TtLhxQONBubme0oNLcl
 VDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744078294; x=1744683094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUzn7fjvVJqyu8tREIvUwjqWhf8w67yKfaORndYqiv8=;
 b=bJATJhqqISS5RsZpejG74K7alkZGxFuJtyf+evAbxAi2Pi6jWaEmY6Oh3T61pudwAS
 bCqAIzxrN1OeHB5+SmPrwk164xY9Bs6cjIdA1djBIRhNHfQtRV/BHqVbsiiHGWWT8DTp
 7pHTQJ0ZEhas3K5f+bjQT8QPq+4YxUa+mfr8SIvcSi4S7cRd4ZwgiLke5IQZjs2QkDXg
 MeaTTAQEUfr1owMSJtjLE6nSP4W5OLAin/PUdMgqB4LHEfOE0EdeCIgrBQh7XEiiLNtg
 iy1QbhfzcDjVLThB4MX1Ar84KDeFoztFt96sXWNdNqjJyEPPQRcCzEu7dQe7cus8YJUI
 dccA==
X-Gm-Message-State: AOJu0YyQ4YBh3PlkIVwe1VviGPN284Qp9BE8vUq87XIbAFvaGu9X3LPc
 xsBodyOe8DDIshQg4qxWOEYuCHobCZ2PNqcPgClSP6beiQbc8x3Idv/r4A==
X-Gm-Gg: ASbGncv5mCB9yPvHQHpxvE38QDzya8sOkAuu+HZAPrpTtxSjb2RuUYBzpKeB5Tr4E0b
 /P6NuTI4IrwHolOluUD/XEx3QEI8+mdv0HhC+KiGvl7Tqqm3wYj9EXmSVjVlpAAdaNuPnC4uC5I
 pccOw6nHbh8fm9oCczJQGpgYK3/8M81db0hOfsTxt6haahEmkgPS8k2Z22Tl54t4lKSKh/zj8QE
 LvtGVlr7OiWC/2+K1f6gHJOTRBgkzd228u426oRpJnIDn50AfjF9dZdnqmU60YrwQ1mvPP/A0OB
 RvXAxUUombp0Nfcr2U39RBt6u4d3N4nIiXAq6oqYgfLwZax4o2sLapbJ3OvO4ipWADOZ
X-Google-Smtp-Source: AGHT+IEgfTluC9r6HZXHG/a0PIGG3M6lOXYf/ptMXQSgUC9mhETIBD/v+p2vl5MdN+nAkpZZajCpjA==
X-Received: by 2002:a05:620a:178d:b0:7c5:65ab:4ff5 with SMTP id
 af79cd13be357-7c775ae04f2mr2004279885a.45.1744078293626; 
 Mon, 07 Apr 2025 19:11:33 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76ea5992csm687693985a.84.2025.04.07.19.11.32
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 19:11:32 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdgpu: fix typo in bios_parser.c
Date: Mon,  7 Apr 2025 22:11:00 -0400
Message-ID: <20250408021100.5439-7-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
References: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Probably a cut and paste error from using get_integrated_info_v8's comment.
This has to be get_integrated_info_v9

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 3bacf470f7c5..67f08495b7e6 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2384,10 +2384,10 @@ static enum bp_result get_integrated_info_v8(
 }
 
 /*
- * get_integrated_info_v8
+ * get_integrated_info_v9
  *
  * @brief
- * Get V8 integrated BIOS information
+ * Get V9 integrated BIOS information
  *
  * @param
  * bios_parser *bp - [in]BIOS parser handler to get master data table
-- 
2.49.0

