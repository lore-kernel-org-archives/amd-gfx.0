Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8721EC388F7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0950A22243
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVoriO5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0950A22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 145DC6ECB4;
	Tue,  3 Nov 2020 13:58:45 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 683C36ECB1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 13:58:44 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id s25so10290602ejy.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 05:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tfJ5jelk6wVW5vPyGTz4oMWJ+O/11DAid9AG7R9cIXo=;
 b=EVoriO5nw/Kg6U1AOmu9YKGRsN8J2ukG9qGIni7fdxEWMVVs99ARv63i5yU3LIeaIl
 O//r6NQs2pd33Y8pQLmupW8Is8Tz3hypbqozAiGkGwxFMOb+sxK0pDqwd9jGrngX/Ffg
 FVLP+KXs5gGwQS1TP3/kGSdOVk7i6QtpwTxGlYHQawLC3j41bsrRjKhdTjQoLm76yu+s
 xhk5mvGW40Ueriy6MuQWLU5Xbn1pTrTwnpEDizJrBvx3bV1NU4apilOR9kP8kVxIvKHq
 lniPxhkNsMWpJiOVWh1NhxDFPFKzmArRp+YnMuijS7YPC32LEU99+iqpwVSK3kH6nnDk
 8TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tfJ5jelk6wVW5vPyGTz4oMWJ+O/11DAid9AG7R9cIXo=;
 b=RVUxOXrpXmrF5BOZpAl4W/JywthnZBY8w3qLQ7fnweurjMLzh4qDpNFRRwN2LgRIWm
 j/6uJk6WEmmcBfIhXpOVALKxqY9o+DOzjpea8n9/Dl9gAczT61C5aMWbsUHgIe9l/xEc
 eXaz8oyjP7QEmB6K9cNhnWtrdhmbJ14TgbDkFla+5dWP6GgAhIreevrFpOVruOnSreTU
 Oiy69q3mapi0QPNms6QCYavQZh1GxYmGWzibgf246rZJL6bRXL/dAPtTWcZ3awjzCMs3
 FfEhXk2Pelxk81nyisMq0c4hGN6kjUXF6iJ2x4ywzCRbkVJZs7KC0IPeHpl3iPAmTn5w
 c0Uw==
X-Gm-Message-State: AOAM530U4mz6X0rYnc56E5SfIq6+tWLm36qEIovHbi2mJ3OAeIvpkIVk
 sj3lakLFiNzXZEaV2LQuPKMbfTIXiYc=
X-Google-Smtp-Source: ABdhPJxexVOUeABakklvld6djFFgtcTNikdrY9Jv5QVBPtW3uugr70xVIW5GtNePho7uDpyKX9zTXA==
X-Received: by 2002:a17:906:5e45:: with SMTP id
 b5mr8572579eju.46.1604411922835; 
 Tue, 03 Nov 2020 05:58:42 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f3a2:b920:33f3:da11])
 by smtp.gmail.com with ESMTPSA id j6sm7903263edy.87.2020.11.03.05.58.42
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 05:58:42 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: make sure retry faults are handled in a work
 item on Vega
Date: Tue,  3 Nov 2020 14:58:35 +0100
Message-Id: <20201103135837.39693-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103135837.39693-1-christian.koenig@amd.com>
References: <20201103135837.39693-1-christian.koenig@amd.com>
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

TG9va3MgbGlrZSB3ZSBjYW4ndCBlbmFibGVkIHRoZSBJSDEvSUgyIGZlYXR1cmUgZm9yIFZlZ2Ey
MCwgbWFrZSBzdXJlCnJldHJ5IGZhdWx0cyBhcmUgaGFuZGxlZCBvbiBhIHNlcGFyYXRlIHJpbmcg
YW55d2F5LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgfCAz
MSArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5j
CmluZGV4IGU4NmVmMGMzNjU5Ni4uZjhiNGIxY2E5NDczIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192OV8wLmMKQEAgLTUyNCwxNCArNTI0LDI5IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBf
cHJvY2Vzc19pbnRlcnJ1cHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJYWRkciA9ICh1
NjQpZW50cnktPnNyY19kYXRhWzBdIDw8IDEyOwogCWFkZHIgfD0gKCh1NjQpZW50cnktPnNyY19k
YXRhWzFdICYgMHhmKSA8PCA0NDsKIAotCWlmIChyZXRyeV9mYXVsdCAmJiBhbWRncHVfZ21jX2Zp
bHRlcl9mYXVsdHMoYWRldiwgYWRkciwgZW50cnktPnBhc2lkLAotCQkJCQkJICAgIGVudHJ5LT50
aW1lc3RhbXApKQotCQlyZXR1cm4gMTsgLyogVGhpcyBhbHNvIHByZXZlbnRzIHNlbmRpbmcgaXQg
dG8gS0ZEICovCi0KLQkvKiBJZiBpdCdzIHRoZSBmaXJzdCBmYXVsdCBmb3IgdGhpcyBhZGRyZXNz
LCBwcm9jZXNzIGl0IG5vcm1hbGx5ICovCi0JaWYgKHJldHJ5X2ZhdWx0ICYmICFpbl9pbnRlcnJ1
cHQoKSAmJgotCSAgICBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KGFkZXYsIGVudHJ5LT5wYXNpZCwg
YWRkcikpCi0JCXJldHVybiAxOyAvKiBUaGlzIGFsc28gcHJldmVudHMgc2VuZGluZyBpdCB0byBL
RkQgKi8KKwlpZiAocmV0cnlfZmF1bHQpIHsKKwkJLyogUmV0dXJuaW5nIDEgaGVyZSBhbHNvIHBy
ZXZlbnRzIHNlbmRpbmcgdGhlIElWIHRvIHRoZSBLRkQgKi8KKworCQkvKiBQcm9jZXNzIGl0IG9u
eWwgaWYgaXQncyB0aGUgZmlyc3QgZmF1bHQgZm9yIHRoaXMgYWRkcmVzcyAqLworCQlpZiAoZW50
cnktPmloICE9ICZhZGV2LT5pcnEuaWhfc29mdCAmJgorCQkgICAgYW1kZ3B1X2dtY19maWx0ZXJf
ZmF1bHRzKGFkZXYsIGFkZHIsIGVudHJ5LT5wYXNpZCwKKwkJCQkJICAgICBlbnRyeS0+dGltZXN0
YW1wKSkKKwkJCXJldHVybiAxOworCisJCS8qIERlbGVnYXRlIGl0IHRvIGEgZGlmZmVyZW50IHJp
bmcgaWYgdGhlIGhhcmR3YXJlIGhhc24ndAorCQkgKiBhbHJlYWR5IGRvbmUgaXQuCisJCSAqLwor
CQlpZiAoaW5faW50ZXJydXB0KCkpIHsKKwkJCWFtZGdwdV9pcnFfZGVsZWdhdGUoYWRldiwgZW50
cnksIDgpOworCQkJcmV0dXJuIDE7CisJCX0KKworCQkvKiBUcnkgdG8gaGFuZGxlIHRoZSByZWNv
dmVyYWJsZSBwYWdlIGZhdWx0cyBieSBmaWxsaW5nIHBhZ2UKKwkJICogdGFibGVzCisJCSAqLwor
CQlpZiAoYW1kZ3B1X3ZtX2hhbmRsZV9mYXVsdChhZGV2LCBlbnRyeS0+cGFzaWQsIGFkZHIpKQor
CQkJcmV0dXJuIDE7CisJfQogCiAJaWYgKCFwcmludGtfcmF0ZWxpbWl0KCkpCiAJCXJldHVybiAw
OwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
