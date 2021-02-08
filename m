Return-Path: <SRS0=u850=HL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFCCC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 08:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A959A64EBD
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 08:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A959A64EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95BB6ED6B;
	Tue,  9 Feb 2021 08:03:02 +0000 (UTC)
X-Greylist: delayed 555 seconds by postgrey-1.36 at gabe;
 Mon, 08 Feb 2021 23:40:45 UTC
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F0A6EA5A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 23:40:45 +0000 (UTC)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1612827089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qW/rfNBqb6SK1XEXbpPIWeuc3FX/LJUm19wTvuFCO/w=;
 b=1q7ZnPQog0qZ6EvkUtPUXN4H95iNMqRmN/wCWMpZERl2WBwdqYA8DwRkRKeMNzj+B8TG57
 c8TyjzpQYaZCz//5L9+YzE4vAt4mjlryaQjQyPwpmWrLdfaaT9+FSDBRDxb/kBTl4QTJ4K
 3zi/6uDhEU3de+w5L6GBRDgwjcN4P/xMR0CgJTcIseNiQKY1iaeyeSIf+L6l93/jxjJczj
 5AQDM3eVyFazkeI770mL7+ehGEzj36ERclaEfuDMX4DXLeaFr58OvuWTTf8NQtvwPGy8U3
 zS2AQpWyqvkWkETqxOCL1ZQuH2+IY9Fq85PE6PCyJtFAQnTjL+Yep01l2vedYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1612827089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qW/rfNBqb6SK1XEXbpPIWeuc3FX/LJUm19wTvuFCO/w=;
 b=BzUkbLqY+PBvZWCyytkWWjw+GhFbJ6cm2zbE0VDj1A31jCEURyYCu1dhOVhV/RK1FkaVIx
 o0qaKW4ZAqW7dcBw==
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 1/4] drm/gma500: Remove in_atomic() usage.
Date: Tue,  9 Feb 2021 00:31:16 +0100
Message-Id: <20210208233119.391103-2-bigeasy@linutronix.de>
In-Reply-To: <20210208233119.391103-1-bigeasy@linutronix.de>
References: <20210208233119.391103-1-bigeasy@linutronix.de>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 09 Feb 2021 08:02:59 +0000
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
Cc: David Airlie <airlied@linux.ie>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 amd-gfx@lists.freedesktop.org, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver is using msleep() if it is safe to use based on in_atomic().
This is not needed this macro is only used from
i2c_algorithm::master_xfer() which is always invoked from preemptible
context.

Remove in_atomic() because it is superfluous. Remove wait_for_atomic()
because it has no users.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/gpu/drm/gma500/intel_gmbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/intel_gmbus.c b/drivers/gpu/drm/gma500/intel_gmbus.c
index 370bd6451bd9b..eb0924473a218 100644
--- a/drivers/gpu/drm/gma500/intel_gmbus.c
+++ b/drivers/gpu/drm/gma500/intel_gmbus.c
@@ -44,13 +44,13 @@
 			ret__ = -ETIMEDOUT;				\
 			break;						\
 		}							\
-		if (W && !(in_atomic() || in_dbg_master())) msleep(W);	\
+		if (W && !(in_dbg_master()))				\
+			msleep(W);					\
 	}								\
 	ret__;								\
 })
 
 #define wait_for(COND, MS) _wait_for(COND, MS, 1)
-#define wait_for_atomic(COND, MS) _wait_for(COND, MS, 0)
 
 #define GMBUS_REG_READ(reg) ioread32(dev_priv->gmbus_reg + (reg))
 #define GMBUS_REG_WRITE(reg, val) iowrite32((val), dev_priv->gmbus_reg + (reg))
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
