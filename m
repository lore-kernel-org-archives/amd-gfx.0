Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145FFC6379F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1E92225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2v+UQdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1E92225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CF06E0E4;
	Mon, 16 Nov 2020 19:18:52 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055866E038
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:10 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c17so19601549wrc.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=brKpubI9m6t0/lslbRm7JoHNATZX8LOe9ERcjH2dq1I=;
 b=d2v+UQdDsneXlTN6mpwGtQa1JII7loaPK7FtyMdxwBh94nR+RMRJ2sdDSYWiWA4Gdi
 Fsfex/7l3c1d762P+eJfgiwtQweyGf+VyN6BqpR170YJE1cYPNRrZ2c4aQsXcc4rPdZJ
 otnuSbCzU3hogR5xqxla71Y0DxcVOGr3gnwv3HURcr7LQCg51B+f6/qNZ//m5TOu71hA
 gR9IG8kLM7fkPhoX4mWRd0t02ouUlxB7dBZQQN1h8Sc4P4hwG3Px8zuCPyOsPqB5Pz2m
 lsqp/V2hrnhwY7hSpbuRGaQ44N+AU0CUgjVfNQhR9LEgD9IWQYmyikJu0q16dQ81tnF+
 pGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=brKpubI9m6t0/lslbRm7JoHNATZX8LOe9ERcjH2dq1I=;
 b=gc5mtFKcP+4Bs8Pf8GJe2koFbhI9fHIwmvp7G1ji6D6CAlJ9Gky7p9PU5Nf22lOj/I
 HqsMBTrVvGGpx4Lu1HjZyPL/nKyffpTDKT5w2dge8Ro9L6HJ2v5c2mmkcJ72Pr9xcIC1
 AIUjBZyYly/gjoaGaQ9iwiuvfXWwEgZqkW1Sa8dK8phsWAvbabE8jiQd3kKr6HGDxDVz
 EGYlD8Mn3pmUo9b/pZHeLWcY3G4NUJTbdMBuTc9J3GWBIPz5q4EXTZUNDLZ2MRHhojNN
 Azs1dzVLYx/61Zxmfft5NtUQMu7ePTT0rKJAbCQADSdT7kt/eUFCKwk9bbDW6DXgOTqT
 mIZQ==
X-Gm-Message-State: AOAM5326sLCFakFCtEoHQK3oHrsa2Sfx+5dRDd7kraXlQ+e8yerqhbl0
 uZ2qXnwBspB4QAKW7pvcS+Ru9A==
X-Google-Smtp-Source: ABdhPJyHYdBcdf6dmzu+ALix2+ZPddVQAxDPKulZ23x4FWjXmT0ZNsPvLa6uH2tvTXV3+CtTi1fmzA==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr20435374wrq.401.1605548228653; 
 Mon, 16 Nov 2020 09:37:08 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:08 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 04/43] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
Date: Mon, 16 Nov 2020 17:36:21 +0000
Message-Id: <20201116173700.1830487-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6MjI2OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJh
bWV0ZXIgb3IgbWVtYmVyICdkZXYnIG5vdCBkZXNjcmliZWQgaW4gJ3JhZGVvbl9pbmZvX2lvY3Rs
JwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6MjI2OiB3YXJuaW5nOiBFeGNl
c3MgZnVuY3Rpb24gcGFyYW1ldGVyICdyZGV2JyBkZXNjcmlwdGlvbiBpbiAncmFkZW9uX2luZm9f
aW9jdGwnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
IkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9rbXMuYwppbmRleCAwMDE5NDBiY2E5MGE2Li41MGNlZTQ4ODBiYjQ2IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwpAQCAtMjE0LDcgKzIxNCw3IEBAIHN0YXRp
YyB2b2lkIHJhZGVvbl9zZXRfZmlscF9yaWdodHMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKIC8q
KgogICogcmFkZW9uX2luZm9faW9jdGwgLSBhbnN3ZXIgYSBkZXZpY2Ugc3BlY2lmaWMgcmVxdWVz
dC4KICAqCi0gKiBAcmRldjogcmFkZW9uIGRldmljZSBwb2ludGVyCisgKiBAZGV2OiBkcm0gZGV2
aWNlIHBvaW50ZXIKICAqIEBkYXRhOiByZXF1ZXN0IG9iamVjdAogICogQGZpbHA6IGRybSBmaWxw
CiAgKgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
