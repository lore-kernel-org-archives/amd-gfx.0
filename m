Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924E9F0181D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 08:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DAA10ECA4;
	Fri,  6 Mar 2026 08:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OfbcGuQQ";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC63110E2E8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 01:51:09 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-676e5c56fe1so3867937eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 17:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772761869; x=1773366669; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUT8OXayauJDeUXGjkmGNUpTYIk2PPPOV9CpVsGLhj0=;
 b=OfbcGuQQXk7TnXTWL2CayiETbUGRKuAKDLAR3z/uCEMjgD1qBeHy/yzGSMXVupEMGR
 b1I577PMAa+ymRxUfpTRQXdzugWJYIduWvXZrB54JmFZhkXboxKMmFkQ9KQZg7g1tkjw
 TjljFOJJT0AeGdaGlc4mOXCpGrgtDv2ILtydNFZ2xtcSbObXuuOS5mGaHMfL7OGpCd1r
 2mjRq9CV7R4jK6R05IaJjfIE1RYWxBoigAB3fSHA5eaOTd4A9Y0LGKth9zLoFGeVGxit
 JGMZS7rLQEu13s66hLif+27ugwoSsWUzlVvKDwgCcEWtKmmU8i4PSoV+qK0ypcrsi++p
 3nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772761869; x=1773366669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bUT8OXayauJDeUXGjkmGNUpTYIk2PPPOV9CpVsGLhj0=;
 b=IVxGbdcx7XIBsqNijgTWn9GPJ/vNT8QSdQRr5JGuO/mjCZ/TYt3frv0PVd3c490wiB
 Mv2sFBdNRcq2y9A2wbdNs0Q9+dnUx3pwVrqGO48lmvqU2Vky8xRJjo5HcP6w2/UkIejW
 YEbyYEegVbQ7B2YOKn4Am9fQ/xWIBpLySz6QeAiQrXZS5tRxJo6+btL+fJcvZziayj6O
 bg10c+hyWa22Iyh8WURuy2Puv4OGc+WFu7AGMl2KQ5lD4PHyzEQwhac/Dzie5uxSOKXJ
 YNUV61sh2LJWSG8Y2W4U30ZLKjpNoxO7JVdNXNsqXUXU26OAFLgY3JmbYt1Ofsburtg9
 7crA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4LB0CI6kItAkOeYJQdZe9fDoVKB6bwx3Ks0hqEdh7qaTf0IensjgB9/hBFjrWeLR4y2Q9Nb9u@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUsDDG4jPm6byNnqzXkuzVQ9Z/O8u8PLvL3QTDGLcm0K7H6OP7
 DuhrkzeTp0qQ5z84Vq5C9XFvYaiHZ9hiOBvTJWMiGEdUKXnLgLvE2tIb
X-Gm-Gg: ATEYQzxuBzveGCveA4ezCnI8e2Dz1qMarDqhKzrZUjXV8NmEN9arHpdXeHaURZ+bMbF
 yfLj9hUTH0I5IZFAPQD0MVAaMEoN/CjF3v+/NW4ZB3pVC4by7kbIus/lza0FXQ5dLrJ+CcENSTu
 6FWwlwoBN2AIdH7eedGMxeZhM3UQ7vS8/h4T4e217tcl4XQQ42MMieYtmEwJz4ZUcxFIiSf9F0r
 68xoD5yy7H7Wbr62fKOIlR7453y9TJcfAyjzlu4EJBGjqpxOHwefQXtad0HtAs8TCcO/WU4pJB0
 TvP8eewNEw1AoISfJaKWW6Yd+zQpxAMtDxgRKvQ6Hwzo71I75SINdPgwxIt/VYha1Y9gLAlrRjN
 cDy7sUvRql8fGTC70jz4WNeCIXzHGk2CABG4C1u98FXckyCoa6Vm4+suX0wizxxyoroDKrzpbIg
 1hpUhfvNVn1z3/cttIDDsLvcqPrsbN3PGggQIMdmvatvwFlCDy
X-Received: by 2002:a4a:ee14:0:b0:677:3b8f:43a4 with SMTP id
 006d021491bc7-67b9c485db9mr276619eaf.36.1772761868900; 
 Thu, 05 Mar 2026 17:51:08 -0800 (PST)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 006d021491bc7-67b9cc1a627sm115245eaf.6.2026.03.05.17.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 17:51:08 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: Jim Cromie <jim.cromie@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Joseph Tilahun <jtilahun@astranis.com>, linux-serial@vger.kernel.org
Subject: [RFC PATCH 3/7] drivers/tty/serial/serial_core: ratelimit
 uart_wait_until_sent
Date: Thu,  5 Mar 2026 18:50:06 -0700
Message-ID: <20260306015022.1940986-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306015022.1940986-1-jim.cromie@gmail.com>
References: <20260306015022.1940986-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Mar 2026 08:52:54 +0000
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

Ratelimiting these pr_debug()s can reduce the console flood during
bulk dynamic-debug activation, in environments where a serial console
is used.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 487756947a96..6db465619c70 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1790,8 +1790,8 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 
 	expire = jiffies + timeout;
 
-	pr_debug("uart_wait_until_sent(%u), jiffies=%lu, expire=%lu...\n",
-		port->line, jiffies, expire);
+	pr_debug_ratelimited("waiting on (%u) jiffies=%lu, expire=%lu...\n",
+			     port->line, jiffies, expire);
 
 	/*
 	 * Check whether the transmitter is empty every 'char_time'.
-- 
2.53.0

