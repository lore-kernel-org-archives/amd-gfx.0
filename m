Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1010C33CAE
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A763920678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipi8+V2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A763920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24776E0E7;
	Mon, 13 Jan 2020 14:41:06 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D23B6E0E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 14:41:04 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id t2so8867602wrr.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 06:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3L33aS2pwAf8uGex5WgoBmSifiFV6QlrcfQ9T8der8U=;
 b=ipi8+V2FVoZtQ6FdFok+Wb6Y3NqGT7mvh0Eqbkve2mTNySdNW9/O7pbtTAM2XsbN4J
 aapa/HEaAXLwM3csRuX26oGqgixH9QdzgEoHvaXVKE9pZAkxFraOSzJbBcOOpAs7d40n
 dwGi8TtIx9a61ZiK/4osjws3X9LYKLSNFSIOaOTDHmMvRiEd0X54RuKIuvZptASkONjT
 3n29WY0o5gB8XbR6PwVMAVgG8M/x48YbuW2+4C6HlVwi03j6peGhuO6MSu4DeOl8D0vi
 T2/rvNAksNgPZEuT504ANIjPx2dOtJ0KebuhQHdO8TOUyrFcp18eq4G6Xic5ed31qVTt
 x8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3L33aS2pwAf8uGex5WgoBmSifiFV6QlrcfQ9T8der8U=;
 b=GhR/e1Q6kjMHHUFooGTaYps99MJYoFjyo01HR9iUMnii6l1FRyC5yrCcL7ilXOYI1w
 mZoIbEFTxcLx0KRDuM+TSnV2vEHl+xHOUMJ0LeD77yO3fNGbv9TaanrpEgKC4Dzo7Flp
 ZCVhzrzE3xCPWWGoBWlV/3KSNmMSEyNo41HVoLoqk04PbDjZAhtgyPn98C1yzFVM1B5G
 GllGoCpxdISHGW2i6kCV3W48B5OaYtjzmnRbrIf1WG5jnSUqTLunm1qZx4NQkKhiJ53u
 wEHTjJ8bI5ZDGKs1TrIHghcBF2kKqGk65wFlfleKYpkA1Jn94p6rU/BEJFp+rOLmLQJd
 maGA==
X-Gm-Message-State: APjAAAWd+33PPl3LtBelmwCgXHhY4Ra0dR26/f9B01O6N4RBbBxJphxf
 3d9f1HdtNGZj8X2K/iiaLwU10+bx
X-Google-Smtp-Source: APXvYqxzbN2ZGZyB3BSufqLq9M6w6+9SN72DG5XO6GQXnqStt/1NL3ciz+Fft8cfdsUHs8qqP4X42Q==
X-Received: by 2002:a5d:670a:: with SMTP id o10mr19630335wru.227.1578926462472; 
 Mon, 13 Jan 2020 06:41:02 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:bd29:349f:9f33:2a26])
 by smtp.gmail.com with ESMTPSA id m10sm15347802wrx.19.2020.01.13.06.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 06:41:02 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex.Sierra@amd.com, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 8/8] drm/amdgpu: make sure to never allocate PDs/PTs for
 invalidations
Date: Mon, 13 Jan 2020 15:40:55 +0100
Message-Id: <20200113144055.3416-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113144055.3416-1-christian.koenig@amd.com>
References: <20200113144055.3416-1-christian.koenig@amd.com>
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

TWFrZSBzdXJlIHRoYXQgd2UgbmV2ZXIgYWxsb2NhdGUgYSBwYWdlIHRhYmxlIGZvciBhbiBpbnZh
bGlkYXRpb24gb3BlcmF0aW9uLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIHwgMjIgKysrKysrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYwppbmRleCA0ZGU5YjMzMDA4NzAuLjlhZjViZGU4ODVhOSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTE0MTYsMTUgKzE0MTYsMTUgQEAgc3RhdGlj
IGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1z
ICpwYXJhbXMsCiAJCXVpbnQ2NF90IGluY3IsIGVudHJ5X2VuZCwgcGVfc3RhcnQ7CiAJCXN0cnVj
dCBhbWRncHVfYm8gKnB0OwogCi0JCS8qIG1ha2Ugc3VyZSB0aGF0IHRoZSBwYWdlIHRhYmxlcyBj
b3ZlcmluZyB0aGUgYWRkcmVzcyByYW5nZSBhcmUKLQkJICogYWN0dWFsbHkgYWxsb2NhdGVkCi0J
CSAqLwotCQlyID0gYW1kZ3B1X3ZtX2FsbG9jX3B0cyhwYXJhbXMtPmFkZXYsIHBhcmFtcy0+dm0s
ICZjdXJzb3IsCi0JCQkJCXBhcmFtcy0+ZGlyZWN0KTsKLQkJaWYgKHIpCi0JCQlyZXR1cm4gcjsK
LQotCQlwdCA9IGN1cnNvci5lbnRyeS0+YmFzZS5ibzsKKwkJaWYgKGZsYWdzICYgQU1ER1BVX1BU
RV9WQUxJRCkgeworCQkJLyogbWFrZSBzdXJlIHRoYXQgdGhlIHBhZ2UgdGFibGVzIGNvdmVyaW5n
IHRoZQorCQkJICogYWRkcmVzcyByYW5nZSBhcmUgYWN0dWFsbHkgYWxsb2NhdGVkCisJCQkgKi8K
KwkJCXIgPSBhbWRncHVfdm1fYWxsb2NfcHRzKHBhcmFtcy0+YWRldiwgcGFyYW1zLT52bSwKKwkJ
CQkJCSZjdXJzb3IsIHBhcmFtcy0+ZGlyZWN0KTsKKwkJCWlmIChyKQorCQkJCXJldHVybiByOwor
CQl9CiAKIAkJc2hpZnQgPSBhbWRncHVfdm1fbGV2ZWxfc2hpZnQoYWRldiwgY3Vyc29yLmxldmVs
KTsKIAkJcGFyZW50X3NoaWZ0ID0gYW1kZ3B1X3ZtX2xldmVsX3NoaWZ0KGFkZXYsIGN1cnNvci5s
ZXZlbCAtIDEpOwpAQCAtMTQ1Myw2ICsxNDUzLDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3Vw
ZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAogCQkJY29u
dGludWU7CiAJCX0KIAorCQlwdCA9IGN1cnNvci5lbnRyeS0+YmFzZS5ibzsKKwkJaWYgKCFwdCkK
KwkJCXJldHVybiAtRU5PRU5UOworCiAJCS8qIExvb2tzIGdvb2Qgc28gZmFyLCBjYWxjdWxhdGUg
cGFyYW1ldGVycyBmb3IgdGhlIHVwZGF0ZSAqLwogCQlpbmNyID0gKHVpbnQ2NF90KUFNREdQVV9H
UFVfUEFHRV9TSVpFIDw8IHNoaWZ0OwogCQltYXNrID0gYW1kZ3B1X3ZtX2VudHJpZXNfbWFzayhh
ZGV2LCBjdXJzb3IubGV2ZWwpOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
