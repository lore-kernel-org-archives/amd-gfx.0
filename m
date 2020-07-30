Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5830C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAEC62074B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLmB/Fwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEC62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD8F6E963;
	Thu, 30 Jul 2020 20:04:33 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301276E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:30 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id s23so21295820qtq.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xzxbHOInfKOUHFwNXIurp3LN+fdh1+JLgp6nvb1zq24=;
 b=lLmB/Fwp/N+9rSQk9q4RjVx88ubT7HQyADy5hb7zPgEBO8xqOPtCyp5liZikvBeDJX
 ZRM35ABjNBuqFaa0ztt8HVZJi+212MtIQHr5SEu8NfiKt/XXsHcZErRflimO/kzhelUF
 zMLNk5SrBeYgOMvwL/XcoXHv6+wF9sOSqdOnAeDT0+R0NJ4Qtx3A7Y45JbmT6GYExJ6I
 AiM/4J67zmFY0ZaGiNabMEZFyRSkvwlgjP8ciVXOONGpX8lblWKrZ5mlwTpjtBtNnShN
 qwYGoxwp5O8sXhncBGNVeI175KKf2SQALxziJ4KPfzrLZME/wrkS5HdkSvprRekv/Fe/
 XdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xzxbHOInfKOUHFwNXIurp3LN+fdh1+JLgp6nvb1zq24=;
 b=dFD9UmvkxOLBefFRkUi42+miZotdQZlO+6T5g0GIwWdEt+jmGYBBR5jyEdzfyhI1ks
 y5zHCepGXisHa+qwTiKoZO2B6DIeHG2uqqwDPoV5dX/tr22CqSMw1HqNk1dMZ0OrE44c
 dlrCYO1tRC6mlcUle6GwCRMq7KWgnzFnFLTzX9w2rO75jHYv4Rsxaa+rsLRkCLN7cZv9
 TmmeBJyLjHsNb0v12eRtYgw3T5QT5U7X02Efn66V+dZuCsyK177PcyI6ycMhQJvB5zGT
 7i2XxrZdzaxKXcCSlHOQBl9J146B5XOficQ2uI8V5ipvUFUVC4pdHCiPCNoLPJNQuPpr
 MS+A==
X-Gm-Message-State: AOAM531uRndBmua6cvPQ+ua2fKNvgTkrX/QZHtVr3OIsLDzxK8Zf6S53
 1IucUtXiyLw6qKF8bT0wxD8Hiw8h
X-Google-Smtp-Source: ABdhPJy6ZWTqJno94VxmJij1OVw2g44WzMArlgkY8U3iMWUxxa7MFeKPQAS99+gHUSUSYMztY91EMw==
X-Received: by 2002:aed:3305:: with SMTP id u5mr314063qtd.325.1596139469170;
 Thu, 30 Jul 2020 13:04:29 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:27 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/17] drm/amdgpu: add support for extended stolen vga memory
Date: Thu, 30 Jul 2020 16:04:03 -0400
Message-Id: <20200730200414.40485-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200730200414.40485-1-alexander.deucher@amd.com>
References: <20200730200414.40485-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyB3aWxsIGFsbG93IHVzIHRvIHNwbGl0IHRoZSBhbGxvY2F0aW9uIGZvciBzeXN0ZW1zCndo
ZXJlIHdlIGhhdmUgdG8ga2VlcCB0aGUgc3RvbGVuIG1lbW9yeSBhcm91bmQgdG8gYXZvaWQKUzMg
aXNzdWVzLiAgVGhpcyB3YXkgd2UgZG9uJ3Qgd2FzdGUgYXMgbXVjaCBtZW1vcnkgYW5kCnN0aWxs
IGF2b2lkIGFueSBzY3JlZW4gYXJ0aWZhY3RzIGR1cmluZyB0aGUgYmlvcyB0bwpkcml2ZXIgdHJh
bnNpdGlvbi4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+ClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCB8ICAyICsr
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAxMyArKysrKysrKysr
Ky0tCiAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCmluZGV4IDBjZjE4ZjAxZTY3YS4u
OGY0YWY5NTVkNzJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ21jLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCkBA
IC0yMTUsNiArMjE1LDggQEAgc3RydWN0IGFtZGdwdV9nbWMgewogCWJvb2wJCQlwcnRfd2Fybmlu
ZzsKIAl1aW50NjRfdAkJc3RvbGVuX3ZnYV9zaXplOwogCXN0cnVjdCBhbWRncHVfYm8JKnN0b2xl
bl92Z2FfbWVtb3J5OworCXVpbnQ2NF90CQlzdG9sZW5fZXh0ZW5kZWRfc2l6ZTsKKwlzdHJ1Y3Qg
YW1kZ3B1X2JvCSpzdG9sZW5fZXh0ZW5kZWRfbWVtb3J5OwogCWJvb2wJCQlrZWVwX3N0b2xlbl92
Z2FfbWVtb3J5OwogCXVpbnQzMl90CQlzZHBpZl9yZWdpc3RlcjsKIAkvKiBhcGVydHVyZXMgKi8K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwppbmRleCBmZDYxNzY5MjAyYjMu
LmVjOTc1MjUxYjE3MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpA
QCAtMTkxNSw3ICsxOTE1LDcgQEAgaW50IGFtZGdwdV90dG1faW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAl1aW50NjRfdCBndHRfc2l6ZTsKIAlpbnQgcjsKIAl1NjQgdmlzX3ZyYW1f
bGltaXQ7Ci0Jdm9pZCAqc3RvbGVuX3ZnYV9idWY7CisJdm9pZCAqc3RvbGVuX3ZnYV9idWYsICpz
dG9sZW5fZXh0ZW5kZWRfYnVmOwogCiAJbXV0ZXhfaW5pdCgmYWRldi0+bW1hbi5ndHRfd2luZG93
X2xvY2spOwogCkBAIC0xOTg1LDYgKzE5ODUsMTMgQEAgaW50IGFtZGdwdV90dG1faW5pdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJCQkgICAgICAgJnN0b2xlbl92Z2FfYnVmKTsKIAlp
ZiAocikKIAkJcmV0dXJuIHI7CisJciA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsX2F0KGFkZXYs
IGFkZXYtPmdtYy5zdG9sZW5fdmdhX3NpemUsCisJCQkJICAgICAgIGFkZXYtPmdtYy5zdG9sZW5f
ZXh0ZW5kZWRfc2l6ZSwKKwkJCQkgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSwKKwkJCQkg
ICAgICAgJmFkZXYtPmdtYy5zdG9sZW5fZXh0ZW5kZWRfbWVtb3J5LAorCQkJCSAgICAgICAmc3Rv
bGVuX2V4dGVuZGVkX2J1Zik7CisJaWYgKHIpCisJCXJldHVybiByOwogCiAJRFJNX0lORk8oImFt
ZGdwdTogJXVNIG9mIFZSQU0gbWVtb3J5IHJlYWR5XG4iLAogCQkgKHVuc2lnbmVkKSAoYWRldi0+
Z21jLnJlYWxfdnJhbV9zaXplIC8gKDEwMjQgKiAxMDI0KSkpOwpAQCAtMjA0MSwxMSArMjA0OCwx
MyBAQCBpbnQgYW1kZ3B1X3R0bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogICov
CiB2b2lkIGFtZGdwdV90dG1fbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQog
ewotCXZvaWQgKnN0b2xlbl92Z2FfYnVmOworCXZvaWQgKnN0b2xlbl92Z2FfYnVmLCAqc3RvbGVu
X2V4dGVuZGVkX2J1ZjsKIAogCS8qIHJldHVybiB0aGUgVkdBIHN0b2xlbiBtZW1vcnkgKGlmIGFu
eSkgYmFjayB0byBWUkFNICovCiAJaWYgKCFhZGV2LT5nbWMua2VlcF9zdG9sZW5fdmdhX21lbW9y
eSkKIAkJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5nbWMuc3RvbGVuX3ZnYV9tZW1vcnks
IE5VTEwsICZzdG9sZW5fdmdhX2J1Zik7CisJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5n
bWMuc3RvbGVuX2V4dGVuZGVkX21lbW9yeSwgTlVMTCwKKwkJCSAgICAgICZzdG9sZW5fZXh0ZW5k
ZWRfYnVmKTsKIH0KIAogLyoqCi0tIAoyLjI1LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
