Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FA0C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D80820665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRjNGtc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D80820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B6BC89C86;
	Tue, 10 Nov 2020 19:35:46 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842B189BF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:30 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id 33so14003433wrl.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BMGz1Go+pEr1OAoO/uoDpgq9jEcR7kKbucOo/rEyug8=;
 b=oRjNGtc4H3+Om+51bGN+MLhDkMLLGJE4P9jCjdCKIl0vqVd9TW09aAjP68FcKpOe2I
 HxP90vSfbxnkJJ6RPe4Tj3qiXJd0s1E3HHlMaNVtDLYm8exe5AfqiCeJdHm9SBer0vJB
 xiVK+DwOIDPZqybrvsBcqJX5B6ANJ5QEM/AoUnIM6pyX9FMbYDuPD/iimPCqRNUX8cbT
 g+4Q+wGcAOdelme77sLR3z8woRPdo1jM//1XQTuSZsGs9gBUcj3W2gVsKohL291vpX9n
 /U9CHZN1HdaoV34HMDyVChxZJ1uDh+aBWSnVp7RAyjuDyxsJFyD/ikfXkF1Q0Ld3gaNy
 PHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BMGz1Go+pEr1OAoO/uoDpgq9jEcR7kKbucOo/rEyug8=;
 b=r7GonDuwweBvIzgIFtBd/ylEAcVXiGCFdhNNXA7BtifKMth92iKAhFednFPP4mI0Fu
 RHTXDtn22yR1F/pva0rdtzFJNgH8MlmVnLj8asXbrtcxvwUyMwLkoVkaXSQCk7NXFEyn
 nLf0dcm9l3nZph82JWpScOqQO9fF+bDkHLJCXx5Pgdu1kCc4L8wPimWffTiiQPSaa9ks
 jvCNJiIvg9f5uOWr6dHmWUT4ujjnmsKOp8G8kTPBwzMrgYHubtJA/vl4S/JuJpcxr3Wl
 8e1I4ks8brm2WDvubnEawom9OLFy/l/ieaiTS/bXt8y8VMwPYUYnSwE9VYzwlONiNhaO
 9lKg==
X-Gm-Message-State: AOAM5302jz46vQsmEGH7vAMwcDwLNHMiJHs+kqhDef3LcB57s6Bpb48L
 s1adn64M8VritSfoiFWf2ifp0Q==
X-Google-Smtp-Source: ABdhPJy7fVlERZR/Ulkk2Dh9kfxZcd/f1xzr/nIa9kuZd3t2A5+rQcsAtINaBuuwQNGJ0fH7Ig2oQw==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr863570wru.112.1605036689143; 
 Tue, 10 Nov 2020 11:31:29 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:28 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 10/30] drm/radeon/radeon_sync: Add description for function
 param 'rdev'
Date: Tue, 10 Nov 2020 19:30:52 +0000
Message-Id: <20201110193112.988999-11-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fc3luYy5jOjkyOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJh
bWV0ZXIgb3IgbWVtYmVyICdyZGV2JyBub3QgZGVzY3JpYmVkIGluICdyYWRlb25fc3luY19yZXN2
JwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJp
c3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpD
YzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNj
OiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGlu
YXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3N5bmMuYyB8IDEgKwogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fc3luYy5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fc3luYy5jCmlu
ZGV4IDU1Y2M3N2E3M2M3YjcuLjVkMzMwMjk0NTA3NmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX3N5bmMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9zeW5jLmMKQEAgLTc5LDYgKzc5LDcgQEAgdm9pZCByYWRlb25fc3luY19mZW5jZShzdHJ1
Y3QgcmFkZW9uX3N5bmMgKnN5bmMsCiAvKioKICAqIHJhZGVvbl9zeW5jX3Jlc3YgLSB1c2UgdGhl
IHNlbWFwaG9yZXMgdG8gc3luYyB0byBhIHJlc2VydmF0aW9uIG9iamVjdAogICoKKyAqIEByZGV2
OiByYWRlb25fZGV2aWNlIHBvaW50ZXIKICAqIEBzeW5jOiBzeW5jIG9iamVjdCB0byBhZGQgZmVu
Y2VzIGZyb20gcmVzZXJ2YXRpb24gb2JqZWN0IHRvCiAgKiBAcmVzdjogcmVzZXJ2YXRpb24gb2Jq
ZWN0IHdpdGggZW1iZWRkZWQgZmVuY2UKICAqIEBzaGFyZWQ6IHRydWUgaWYgd2Ugc2hvdWxkIG9u
bHkgc3luYyB0byB0aGUgZXhjbHVzaXZlIGZlbmNlCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
