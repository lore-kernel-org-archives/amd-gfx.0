Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725BFC5517A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BF1206CB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZgL07gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BF1206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD7D89688;
	Mon,  9 Nov 2020 21:21:50 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6649C8955D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:03 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id t67so901415wmt.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MH4JrPJnV93KjKdduQzhuU+LLZMbEyGUifyLAOa0/tA=;
 b=LZgL07ggHJ7R0ptAiCpzHF9zdgd23QxQBllK5tecy3Tb0t8KoVT1vGpK9+6IeZl6Ef
 QoIJBhYsx0LZBTWLDq0577hYyZJNNfKp+3WPEuTdHhOgXWdJt5fegyQFRifigj05BvOy
 20yqpzld/RJwNMLhDNKYqkxNtMyDyaZoqI2T8b7sL5FRdcvW4K8xR6xjT3DLqtGK+/8y
 25EH/0vFCbVKQyOrgk+EDhDJ726xYSE33dZ+NebIY+hwswqauDuUYiNGxQ4ZFGC9sxrZ
 kIA64UzFlAZUGyLWCj6urbm00THq2CnDEDDejjZXcE6t1KYu0ZbV6AgMTzfHPn3FNzd8
 7G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MH4JrPJnV93KjKdduQzhuU+LLZMbEyGUifyLAOa0/tA=;
 b=Yo0Yv5KEKbrfOjFQDCqlPhLhOgNHue8CGR0kEQvHsDXQBySPi3Kgmy5yYFE0v84PuB
 ZhPR7G1kPoX6KWybScuNPkX74hMID35fxMS9cX2wVJjryTYFQCY7Er1k6GdyNfaDcU+x
 DydLYRk2Pw8U2N0wCrzwtx+HpF7MsC4107nnQpY5NFy4fEFdU4/3ZDnEwovnqtpnPu9R
 xVLwVpg5yY1/gdwbICXcd8ly4UupsM2RSpFxdd30pFZyzPDvf91xYlBWFB/bm0Y3Qip9
 XWrEGlPZBIicWlsz+ZZ5nGB7IOgrCzfe9CkeZDE81xoI9uwIQxsttNTNxVEHvVtfKlBb
 PYFA==
X-Gm-Message-State: AOAM532Fxd6I+N1jAyV1rmuUK1yXvG6QyuExKpvKpoZ8EWgmkpVaNbZU
 0H7vAiMOTqKFkt5imSlSgSt+vQ==
X-Google-Smtp-Source: ABdhPJxdSPxtoC36afFGHEwvmULh35smowKhbslHUgo2HOWGKa+63fsjzvMsN+Wp2EpaveQFY8ErUQ==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr1090012wma.75.1604956742114; 
 Mon, 09 Nov 2020 13:19:02 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:01 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 01/20] drm/radeon/radeon_ttm: Place declaration of 'rdev' in
 same clause as its use
Date: Mon,  9 Nov 2020 21:18:36 +0000
Message-Id: <20201109211855.3340030-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:21:41 +0000
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
 amd-gfx@lists.freedesktop.org, Jerome Glisse <glisse@freedesktop.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmM6IEluIGZ1bmN0aW9uIOKAmHJhZGVvbl90dG1f
dHRfY3JlYXRl4oCZOgogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmM6NjExOjI0
OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhyZGV24oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2Vk
LWJ1dC1zZXQtdmFyaWFibGVdCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxk
YW5pZWxAZmZ3bGwuY2g+CkNjOiBKZXJvbWUgR2xpc3NlIDxnbGlzc2VAZnJlZWRlc2t0b3Aub3Jn
PgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYyB8IDggKysrKy0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYwppbmRleCA5NTAzOGFjMzM4MmUyLi5hOGM5MTU5MjAw
NzBmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYwpAQCAtNjA4LDIxICs2MDgsMjEg
QEAgc3RhdGljIHZvaWQgcmFkZW9uX3R0bV9iYWNrZW5kX2Rlc3Ryb3koc3RydWN0IHR0bV9ib19k
ZXZpY2UgKmJkZXYsIHN0cnVjdCB0dG1fdHQKIHN0YXRpYyBzdHJ1Y3QgdHRtX3R0ICpyYWRlb25f
dHRtX3R0X2NyZWF0ZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCQkJCQkgICB1aW50
MzJfdCBwYWdlX2ZsYWdzKQogewotCXN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2OwogCXN0cnVj
dCByYWRlb25fdHRtX3R0ICpndHQ7CiAJZW51bSB0dG1fY2FjaGluZyBjYWNoaW5nOwogCXN0cnVj
dCByYWRlb25fYm8gKnJibzsKLQotCXJibyA9IGNvbnRhaW5lcl9vZihibywgc3RydWN0IHJhZGVv
bl9ibywgdGJvKTsKKyNpZiBJU19FTkFCTEVEKENPTkZJR19BR1ApCisJc3RydWN0IHJhZGVvbl9k
ZXZpY2UgKnJkZXY7CiAKIAlyZGV2ID0gcmFkZW9uX2dldF9yZGV2KGJvLT5iZGV2KTsKLSNpZiBJ
U19FTkFCTEVEKENPTkZJR19BR1ApCiAJaWYgKHJkZXYtPmZsYWdzICYgUkFERU9OX0lTX0FHUCkg
ewogCQlyZXR1cm4gdHRtX2FncF90dF9jcmVhdGUoYm8sIHJkZXYtPmRkZXYtPmFncC0+YnJpZGdl
LAogCQkJCQkgcGFnZV9mbGFncyk7CiAJfQogI2VuZGlmCiAKKwlyYm8gPSBjb250YWluZXJfb2Yo
Ym8sIHN0cnVjdCByYWRlb25fYm8sIHRibyk7CisKIAlndHQgPSBremFsbG9jKHNpemVvZihzdHJ1
Y3QgcmFkZW9uX3R0bV90dCksIEdGUF9LRVJORUwpOwogCWlmIChndHQgPT0gTlVMTCkgewogCQly
ZXR1cm4gTlVMTDsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
