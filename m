Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17958C2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E6A20702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMKJZWqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E6A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B6A89E0D;
	Mon, 23 Nov 2020 13:58:01 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85EA89A94
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:19:45 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a3so16859095wmb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L1fDlpcchEE8sJt9jBofLY6dgEAvbjxCo2YFiogOR0A=;
 b=pMKJZWqnGQ4EOGsM3m2PkBJTgPkL3qByu1IMOQ0X/arVLPTbGxxWRx1SJeEo/Ph48O
 vVN2QUHMHY9L5b9Rv/C5Ba4yptENb7hnEe1I/jE4i4Cq6aS4NeC8QCpdTbtz9RAC1WPz
 s8FUUBFETfQI9vuV51nSZ69uOd3k1WSU4j338+SMe1Exv4mLTQRtZDisLhXlftvz9ELl
 3nH/hb2pcU/WElO4+fX5n6PwzZP3Tsf+a68dcWx2p5DY+CHRkWvpfRNEOgXXhXCd7UPy
 1UOO0uiqnYk4FYrHawRONEioF2QOYeJpBxWk5AE3zznY6mfgbWWNvjt2+xPWlJ3Tp7Xx
 XEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L1fDlpcchEE8sJt9jBofLY6dgEAvbjxCo2YFiogOR0A=;
 b=qTEGCgyO08S5ET2WDaQ0jzUSgHTC+7PRJcDGefAeMZv9OaIEkXyM4StMj4ms4rADuF
 mzkaPLF/OCvpIhMQ173fYwyVpRmYOcqSesRkSleBZw2YkuR7cRNd5NFUpvKlzhDWzlzn
 q4n5DCIOhfFz8DTUE9JWenRJKRBr1UkMeFDN93uMGSS2sMATqiTKjFUQSlhf7vgRlv2G
 alsDJ+ouWC18SR/sSacRpJb0v1JW/EF9lp2qFEr5VfovFXmEM9gi8jrCzFb5qyrd6vRg
 5g+VyuskYT1583sr0NdVhWzvdjmQ3vpEPfSJ8h848fQTVepCD0XCabWQIn1xOjOfO2kF
 LrHg==
X-Gm-Message-State: AOAM531tWAFYchG6Db8BVRDDG9wNZMfNqGTj7/fDqahWdUU76HT7Xwcl
 GIT1dAwk28LPzC5/wJwagKnwZg==
X-Google-Smtp-Source: ABdhPJyV/P5H76Wb+5+JAxC5L618gZfe7yTIAvmY7yTdCp7caSJl75guw5MH+E5dslQmHNQXQNPNgg==
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr23088850wmb.39.1606130384390; 
 Mon, 23 Nov 2020 03:19:44 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:19:43 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 17/40] drm/amd/amdgpu/gfx_v6_0: Supply description for
 'gfx_v6_0_ring_test_ib()'s 'timeout' param
Date: Mon, 23 Nov 2020 11:18:56 +0000
Message-Id: <20201123111919.233376-18-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYzoxOTAzOiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICd0aW1lb3V0JyBub3QgZGVzY3JpYmVkIGluICdnZnhfdjZfMF9y
aW5nX3Rlc3RfaWInCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNp
Z0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYyB8IDEg
KwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92Nl8wLmMKaW5kZXggNjcxYzQ2ZWJlY2VkOS4uY2E3NDYzOGRlYzliNyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5jCkBAIC0xODk0LDYgKzE4OTQsNyBAQCBzdGF0aWMg
dm9pZCBnZnhfdjZfMF9yaW5nX2VtaXRfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAogICog
Z2Z4X3Y2XzBfcmluZ190ZXN0X2liIC0gYmFzaWMgcmluZyBJQiB0ZXN0CiAgKgogICogQHJpbmc6
IGFtZGdwdV9yaW5nIHN0cnVjdHVyZSBob2xkaW5nIHJpbmcgaW5mb3JtYXRpb24KKyAqIEB0aW1l
b3V0OiB0aW1lb3V0IHZhbHVlIGluIGppZmZpZXMsIG9yIE1BWF9TQ0hFRFVMRV9USU1FT1VUCiAg
KgogICogQWxsb2NhdGUgYW4gSUIgYW5kIGV4ZWN1dGUgaXQgb24gdGhlIGdmeCByaW5nIChTSSku
CiAgKiBQcm92aWRlcyBhIGJhc2ljIGdmeCByaW5nIHRlc3QgdG8gdmVyaWZ5IHRoYXQgSUJzIGFy
ZSB3b3JraW5nLgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
