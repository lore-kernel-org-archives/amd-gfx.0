Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD35C55ABD
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B2B20678
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vS46JKcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B2B20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C8489C80;
	Tue, 10 Nov 2020 19:35:46 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B86FA89C03
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:31 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p19so2661171wmg.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xLMSTbAF92ExvmzWs2JoLwFgJtHWMDt9gk+mh90YZlk=;
 b=vS46JKcEmSWEQ3jxokyfU3VpP+Kg5LtmqXQcuf/5Lpde1IBpJDp2rXzKHT9D2/Sn5J
 yCgGGCxwdlJNzYtFFtYduZNnDZW8g7uzYAawpyS49TyAd1vEMgQLCnuL7DuH22jt4jmE
 /flXpNq4bfxjgNX0LGd6afTlsweLI1uevM8eoFZSv5F3HHg0BuqX6D262fuEtKnk/n9/
 slWy4R9tVgQaF1FOGG56x8ognPP/x2Grl1EEOyXYILf0zJAIguIzqxePHoQLKZ90QQyN
 BJdcIKLygprzsTLHGs4qnZzfIJUPOjadAD49f8ag10HK38i0fzolUac0mlThHXgdqn4F
 hZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xLMSTbAF92ExvmzWs2JoLwFgJtHWMDt9gk+mh90YZlk=;
 b=uB7y1KjgpkdlRRWYkUTvm2SYyPFgl4zQyvDDoREHhNq6qYl0BiiVYTVZzFRCqLn4ET
 uqJbHVVWT2s7uGL/K8CVa4oVwvX0kK6tsCcU6zuGkgq09nTBvAv3RTChcyAFQLADay81
 NwXzGSsZXH6/Qs3fxnLMdTxMu/tseJkrdx0Ms0kaIn6UvbpWzPomL9tbReXBeJIIE7J8
 33LO/G4HonKVo3CLlSm4fX2xqAI++W/XG3ULsbi6wxIH2mKJppX9tJJLdQbHN8dDMZW7
 IUFr52Lp4kw0ity+rljxWcD81hZ9DZFDoLT+Kp/MCL0QmNl8qmEguDdlcMSOiVZ/yfiE
 In6A==
X-Gm-Message-State: AOAM531wnKIhvqMxHY79f0ftDGZglTC/Ph3Wz4TBIEBpazvevzbqwIb0
 3nhkgEHetMwwdIYOw1aw2X0wkA==
X-Google-Smtp-Source: ABdhPJw/JxxqA18VBzRvlKN0u/UYpIts1gzl/5bw4Z+3TTPyCM+aH12jT763m9MwukJRI3bn6bSaeA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr764766wme.0.1605036690396;
 Tue, 10 Nov 2020 11:31:30 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:29 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 11/30] drm/radeon/radeon_ib: Supply description for
 'radeon_ib_get's get param
Date: Tue, 10 Nov 2020 19:30:53 +0000
Message-Id: <20201110193112.988999-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faWIuYzo2MTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1l
dGVyIG9yIG1lbWJlciAndm0nIG5vdCBkZXNjcmliZWQgaW4gJ3JhZGVvbl9pYl9nZXQnCgpDYzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2liLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2liLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9pYi5jCmluZGV4IDlmZDU1
ZTljNjE2YjAuLmMxZmNhMmJhNDQzYzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX2liLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faWIuYwpA
QCAtNDgsNiArNDgsNyBAQCBzdGF0aWMgaW50IHJhZGVvbl9kZWJ1Z2ZzX3NhX2luaXQoc3RydWN0
IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwogICoKICAqIEByZGV2OiByYWRlb25fZGV2aWNlIHBvaW50
ZXIKICAqIEByaW5nOiByaW5nIGluZGV4IHRoZSBJQiBpcyBhc3NvY2lhdGVkIHdpdGgKKyAqIEB2
bTogcmVxdWVzdGVkIHZtCiAgKiBAaWI6IElCIG9iamVjdCByZXR1cm5lZAogICogQHNpemU6IHJl
cXVlc3RlZCBJQiBzaXplCiAgKgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
