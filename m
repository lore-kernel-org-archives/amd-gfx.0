Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC0CC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25876206CC
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3+HdNQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25876206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8946D6E39C;
	Mon, 30 Mar 2020 13:55:43 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 404836E391;
 Mon, 30 Mar 2020 13:55:40 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id w10so21805258wrm.4;
 Mon, 30 Mar 2020 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EdSiddoWJSbLr+HoD/rzQuDxDnh96tXalnlSTnjDyNk=;
 b=l3+HdNQM8KOBL4+BQ0/ZA8SPXSICm4rLXynvef3cSzENnkbpooxCU7lzs5/aPaAKTc
 CIy8DhjFXJ2vbi+57h+hCmwrI9iW5Ka0n7rEwgaA5fQk4AXZlCrt5nWyeWITJpYnl/Mr
 /huXAByyWhIgOUxJILXl49ITCm81M3Qh1z4ryvpjgngHx9pKhEuCDHZtuUv5BedgHL+I
 cl0kUGNNOY/tm7/mwipJHasjGqWChbmegoSOY24gJ7BOArzmmGCmcEqOEdiwHXvr0OkW
 E8a9dNKMX5wiRx30Me667daqvhiTjAEu4daLgoJBc5H83ufFl5GpyJ/R3XVWgjBsmu1/
 D5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EdSiddoWJSbLr+HoD/rzQuDxDnh96tXalnlSTnjDyNk=;
 b=hu7ujMwQfOLVAtG6AUOtEP7g97Kfp6IEtRf3n1+3/DTKVAnkkiNUFNoOcU4KmOB8iB
 jRahONRtzZ2hMSvGn4Q7bsCF8f3ZqP+ZkXrKMbdtEV3eyTOBkpzFjS0nElItBZUdNvRR
 D0L6isgGouUgLEikJyr+8oD1kAYDwKlT/4Irh6Hii1cXQUQhbHFSCVzwkINc/81WYya6
 zpfkl5MpRAPaiQpETEMxl0MDfpqLh/H64sBg3tQYSf+R0l1AzmDJAip8lNiWPeJSvpZL
 1LXWu0Cu7t9GyS+1N9fNxGkNcpMACUq0YYBLQiLEdaIBhIOdrmgvv8nL9n+rIZl3Gn5Q
 9c+Q==
X-Gm-Message-State: ANhLgQ0jZURV2R5Aj7j9u0rX+KRI+p95+baG+198NFvYTOS2uo2+wjjj
 h6LIL2lDUpXNQHHCAVQUNs1B8tsZ
X-Google-Smtp-Source: ADFU+vvO0yYRajU2wnE5wh9U/t37IlY1BuHmMDnNO6Yjq6An9UxsoaauhbR9y1pGuUew9w2/V+koBg==
X-Received: by 2002:adf:904a:: with SMTP id h68mr14131311wrh.291.1585576538791; 
 Mon, 30 Mar 2020 06:55:38 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f999:5819:bfe0:10e8])
 by smtp.gmail.com with ESMTPSA id z16sm22267660wrr.56.2020.03.30.06.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:55:38 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch
Subject: [PATCH 3/6] drm/amdgpu: note that we can handle peer2peer DMA-buf
Date: Mon, 30 Mar 2020 15:55:33 +0200
Message-Id: <20200330135536.2997-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330135536.2997-1-christian.koenig@amd.com>
References: <20200330135536.2997-1-christian.koenig@amd.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW1wb3J0aW5nIHNob3VsZCB3b3JrIG91dCBvZiB0aGUgYm94LgoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kbWFfYnVmLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1
Zi5jCmluZGV4IGZmZWIyMGYxMWMwNy4uYWVmMTJlZTJmMWUzIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKQEAgLTUxNCw2ICs1MTQsNyBAQCBhbWRncHVf
ZG1hX2J1Zl9tb3ZlX25vdGlmeShzdHJ1Y3QgZG1hX2J1Zl9hdHRhY2htZW50ICphdHRhY2gpCiB9
CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1hX2J1Zl9hdHRhY2hfb3BzIGFtZGdwdV9kbWFfYnVm
X2F0dGFjaF9vcHMgPSB7CisJLmFsbG93X3BlZXIycGVlciA9IHRydWUsCiAJLm1vdmVfbm90aWZ5
ID0gYW1kZ3B1X2RtYV9idWZfbW92ZV9ub3RpZnkKIH07CiAKLS0gCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
