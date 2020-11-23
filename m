Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42601C6379F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D660520702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mgn5NMLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D660520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FC66E027;
	Mon, 23 Nov 2020 13:58:17 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23FD6E02E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:20:17 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id s8so18166589wrw.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dUeixF4MexcQptzRTHrmHc3KXAc8UlMXol5+btOxzyI=;
 b=Mgn5NMLhJpAl73mAfi6yoe9e8RtL/B1FIcdsGg2VTegVerYl9+T3G23KUJvYn0BDoF
 dlBP/X8WktZxc0ZCu+O1ZljebWw81+gjSvSbLG5Bdk3nGL5OBbiZzNo9YhiQIKSF1lUL
 gOix0w2ugmEjS9JVXUW28BxIQSvVZdpD8jZMgQi92EHVLJHcXDFnYWL43sF4I96SBH7/
 D9sVx3HH7YaHGxybPEAnIA4O5QASV4xoEgRv2q93MKVZfRajp6lsW72rlLbIGxKvetL+
 /YpGoq+Ty/beR9aTF2YRNUaA+MPUlWoK3EMlvY7XVLzZdA6Bc3uv+HsiBmhRl21IeO4j
 TSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dUeixF4MexcQptzRTHrmHc3KXAc8UlMXol5+btOxzyI=;
 b=QDNOydqPABTNTzeoGh9EjG+UY5RNaAzXO6qkRO69To8C5D7sxuqQ3YCsrRwE4UdSun
 K8ut7uTXGyJr1+xWvhO7p1OZBOMkP3ig93P2TgmsdS/ZYfCO/8ZW2NuCIgqJZwiA7hTK
 0vhtNtHcKqoxgTPqRK80zDfqrWV1zjrgbj0ugxMqRoK5ejAGVQ6d07/WyuCVUAfA9bl4
 eHZTWTISNPZcduVt3u50VxkpTSHbQMNk3bhMs2i31TGwoqEoiHeeqeTiE7A7AVddcoH5
 eEDjMGiv2QdQrtb/LOhbAHlIIDPp0LK54ZZMR+ds9o6QhdiQEk59L/O/to0GYuxKsKMq
 +XdQ==
X-Gm-Message-State: AOAM530nbPSawbAjW5t06NS2lEFb6ze0iTT+Wyt8PItin5I+ruubigx3
 Hta4zc8yYEzTrieOxC1jDK5wew==
X-Google-Smtp-Source: ABdhPJwf1MG0nyF0KLJfvrLqdG9CK8RUAZrjaSqIDR0mr7UkahjCOL9jww5T+xSB+9uq9C230bQPuA==
X-Received: by 2002:adf:9d49:: with SMTP id o9mr30393682wre.413.1606130416608; 
 Mon, 23 Nov 2020 03:20:16 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:20:16 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 39/40] drm/amd/amdgpu/gmc_v9_0: Remove unused table
 'ecc_umc_mcumc_status_addrs'
Date: Mon, 23 Nov 2020 11:19:18 +0000
Message-Id: <20201123111919.233376-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYzozODI6MjM6IHdhcm5pbmc6IOKAmGVjY191
bWNfbWN1bWNfc3RhdHVzX2FkZHJz4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1j
b25zdC12YXJpYWJsZT1dCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNj
OiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8w
LmMgfCAzNSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCAwYzM0
MjFkNTg3ZTg3Li5mYmVlNDNiNGJhNjRkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
OV8wLmMKQEAgLTM3OSw0MSArMzc5LDYgQEAgc3RhdGljIGNvbnN0IHVpbnQzMl90IGVjY191bWNf
bWN1bWNfY3RybF9tYXNrX2FkZHJzW10gPSB7CiAJKDB4MDAxZDQzZTAgKyAweDAwMDAxODAwKSwK
IH07CiAKLXN0YXRpYyBjb25zdCB1aW50MzJfdCBlY2NfdW1jX21jdW1jX3N0YXR1c19hZGRyc1td
ID0gewotCSgweDAwMDE0M2MyICsgMHgwMDAwMDAwMCksCi0JKDB4MDAwMTQzYzIgKyAweDAwMDAw
ODAwKSwKLQkoMHgwMDAxNDNjMiArIDB4MDAwMDEwMDApLAotCSgweDAwMDE0M2MyICsgMHgwMDAw
MTgwMCksCi0JKDB4MDAwNTQzYzIgKyAweDAwMDAwMDAwKSwKLQkoMHgwMDA1NDNjMiArIDB4MDAw
MDA4MDApLAotCSgweDAwMDU0M2MyICsgMHgwMDAwMTAwMCksCi0JKDB4MDAwNTQzYzIgKyAweDAw
MDAxODAwKSwKLQkoMHgwMDA5NDNjMiArIDB4MDAwMDAwMDApLAotCSgweDAwMDk0M2MyICsgMHgw
MDAwMDgwMCksCi0JKDB4MDAwOTQzYzIgKyAweDAwMDAxMDAwKSwKLQkoMHgwMDA5NDNjMiArIDB4
MDAwMDE4MDApLAotCSgweDAwMGQ0M2MyICsgMHgwMDAwMDAwMCksCi0JKDB4MDAwZDQzYzIgKyAw
eDAwMDAwODAwKSwKLQkoMHgwMDBkNDNjMiArIDB4MDAwMDEwMDApLAotCSgweDAwMGQ0M2MyICsg
MHgwMDAwMTgwMCksCi0JKDB4MDAxMTQzYzIgKyAweDAwMDAwMDAwKSwKLQkoMHgwMDExNDNjMiAr
IDB4MDAwMDA4MDApLAotCSgweDAwMTE0M2MyICsgMHgwMDAwMTAwMCksCi0JKDB4MDAxMTQzYzIg
KyAweDAwMDAxODAwKSwKLQkoMHgwMDE1NDNjMiArIDB4MDAwMDAwMDApLAotCSgweDAwMTU0M2My
ICsgMHgwMDAwMDgwMCksCi0JKDB4MDAxNTQzYzIgKyAweDAwMDAxMDAwKSwKLQkoMHgwMDE1NDNj
MiArIDB4MDAwMDE4MDApLAotCSgweDAwMTk0M2MyICsgMHgwMDAwMDAwMCksCi0JKDB4MDAxOTQz
YzIgKyAweDAwMDAwODAwKSwKLQkoMHgwMDE5NDNjMiArIDB4MDAwMDEwMDApLAotCSgweDAwMTk0
M2MyICsgMHgwMDAwMTgwMCksCi0JKDB4MDAxZDQzYzIgKyAweDAwMDAwMDAwKSwKLQkoMHgwMDFk
NDNjMiArIDB4MDAwMDA4MDApLAotCSgweDAwMWQ0M2MyICsgMHgwMDAwMTAwMCksCi0JKDB4MDAx
ZDQzYzIgKyAweDAwMDAxODAwKSwKLX07Ci0KIHN0YXRpYyBpbnQgZ21jX3Y5XzBfZWNjX2ludGVy
cnVwdF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJc3RydWN0IGFtZGdwdV9p
cnFfc3JjICpzcmMsCiAJCXVuc2lnbmVkIHR5cGUsCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
