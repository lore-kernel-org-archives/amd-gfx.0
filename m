Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7CDC6379D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BF520872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ag7rhcl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BF520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2B36E8C7;
	Wed, 25 Nov 2020 08:22:59 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53B76E53C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:06 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 1so91721wme.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qjbxtDMJ2mzJHY8erVLf4gsozStccXbO1UKtGEg99mY=;
 b=Ag7rhcl7/rvzeLuAHjQfgJaFLQTfabEOu2bp+usdtMNvawzlH0cWoeYgVAdlXm/biq
 ZuPZfgyx6m2NUQSEkBnlnJJgAXw7ZL9Gedeo4VS1wjsX5Hosf48qqXr8+c//c3dxeNRX
 v+AvpZmgpG4hKWD+bq6vwgrjIVLgu5N+EzNskBVkez4sbFuZu9H6EpivWUedWLSDWYK1
 mbF9KJ4sS+HvbukWNxWHNN25abdGc9B/vDEwX6zmmqtUntUPPJsgbCRMT85DKyPHbldD
 tc7RQJb0a8JDuMWutpdlsBpUPy5fyXLlIYLwhfDXXgG8vvGVl0QJ1NaL/tEHLpXs9bhj
 gX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qjbxtDMJ2mzJHY8erVLf4gsozStccXbO1UKtGEg99mY=;
 b=DxmgnmLmTNTZNrAlyUGewwEOImoS6z5W9LPzcL5NHpBZ0iAielHRb8nRst4JWwnEPv
 b+kCewRRLW/xORY1uhJQk/J3kZt+zz/3PunyaqWTXK1F5iP3u7Ul6D0UN3wQ7x4efuG4
 Sx4oOWTl7SAO1UlGRwG9lCJTCsn0qREh2l7UBtSKEturqVjDm0nUZBbInO+tlsaNpBzk
 ln/0rct+OKCPhI6ToZcfxIj6DbdFMBCot23mBJ/Xw13ctu2PWy0DkOou59t/mbmDr5ui
 9rNAF5iXCSbY35rS008WM5R28mK9dG7CzDGdc5cxdrIu5NsWg1l9WkL5edQG1HSqCIJ6
 CsrA==
X-Gm-Message-State: AOAM532/JNqbs/odBAK5m55N9ESkTCG+WXV3r8GpTbV3nQpJ6yTbDBgW
 Wl2hbTc2ExfOdbv8a0kvwZThgQ==
X-Google-Smtp-Source: ABdhPJzUd+8fjzWTFYwiB6AmT0yaY7XFSUxHnPxdi5IjlskHBIh47RAs2kkFJmMSWrxtNAGoDb0o6Q==
X-Received: by 2002:a05:600c:2908:: with SMTP id
 i8mr188239wmd.182.1606247045448; 
 Tue, 24 Nov 2020 11:44:05 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:04 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 05/40] drm/amd/amdgpu/tonga_ih: Provide some missing
 descriptions for 'ih' and 'entry'
Date: Tue, 24 Nov 2020 19:37:49 +0000
Message-Id: <20201124193824.1118741-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Nov 2020 08:22:58 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvdG9uZ2FfaWguYzoxOTM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ2loJyBub3QgZGVzY3JpYmVkIGluICd0b25nYV9paF9nZXRfd3B0
cicKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3RvbmdhX2loLmM6MjI1OiB3YXJuaW5nOiBG
dW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJlZCBpbiAndG9uZ2Ff
aWhfZGVjb2RlX2l2JwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdG9uZ2FfaWguYzoyMjU6
IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2VudHJ5JyBub3QgZGVzY3Jp
YmVkIGluICd0b25nYV9paF9kZWNvZGVfaXYnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS90
b25nYV9paC5jOjI1NTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnaWgn
IG5vdCBkZXNjcmliZWQgaW4gJ3RvbmdhX2loX3NldF9ycHRyJwoKQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpD
YzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9m
Zi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS90b25nYV9paC5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdG9uZ2Ff
aWguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3RvbmdhX2loLmMKaW5kZXggZTQwMTQw
YmY2Njk5Yy4uY2UzMzE5OTkzYjRiZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdG9uZ2FfaWguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS90b25nYV9p
aC5jCkBAIC0xODEsNiArMTgxLDcgQEAgc3RhdGljIHZvaWQgdG9uZ2FfaWhfaXJxX2Rpc2FibGUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAgKiB0b25nYV9paF9nZXRfd3B0ciAtIGdldCB0
aGUgSUggcmluZyBidWZmZXIgd3B0cgogICoKICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50
ZXIKKyAqIEBpaDogSUggcmluZyBidWZmZXIgdG8gZmV0Y2ggd3B0cgogICoKICAqIEdldCB0aGUg
SUggcmluZyBidWZmZXIgd3B0ciBmcm9tIGVpdGhlciB0aGUgcmVnaXN0ZXIKICAqIG9yIHRoZSB3
cml0ZWJhY2sgbWVtb3J5IGJ1ZmZlciAoVkkpLiAgQWxzbyBjaGVjayBmb3IKQEAgLTIxNSw2ICsy
MTYsOCBAQCBzdGF0aWMgdTMyIHRvbmdhX2loX2dldF93cHRyKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAogICogdG9uZ2FfaWhfZGVjb2RlX2l2IC0gZGVjb2RlIGFuIGludGVycnVwdCB2ZWN0
b3IKICAqCiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisgKiBAaWg6IElIIHJpbmcg
YnVmZmVyIHRvIGRlY29kZQorICogQGVudHJ5OiBJViBlbnRyeSB0byBwbGFjZSBkZWNvZGVkIGlu
Zm9ybWF0aW9uIGludG8KICAqCiAgKiBEZWNvZGVzIHRoZSBpbnRlcnJ1cHQgdmVjdG9yIGF0IHRo
ZSBjdXJyZW50IHJwdHIKICAqIHBvc2l0aW9uIGFuZCBhbHNvIGFkdmFuY2UgdGhlIHBvc2l0aW9u
LgpAQCAtMjQ3LDYgKzI1MCw3IEBAIHN0YXRpYyB2b2lkIHRvbmdhX2loX2RlY29kZV9pdihzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKICAqIHRvbmdhX2loX3NldF9ycHRyIC0gc2V0IHRoZSBJ
SCByaW5nIGJ1ZmZlciBycHRyCiAgKgogICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgor
ICogQGloOiBJSCByaW5nIGJ1ZmZlciB0byBzZXQgcnB0cgogICoKICAqIFNldCB0aGUgSUggcmlu
ZyBidWZmZXIgcnB0ci4KICAqLwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
