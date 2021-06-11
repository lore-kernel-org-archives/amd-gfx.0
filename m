Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB81C48BE5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 12:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7924C613CD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 12:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7924C613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD0D6EE82;
	Fri, 11 Jun 2021 12:03:06 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 391C46EE7D;
 Fri, 11 Jun 2021 12:03:04 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id z8so5790856wrp.12;
 Fri, 11 Jun 2021 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GivG2fWroyBp8LLT2a2aE/3FmiD4JPvufM2qhUiBXy4=;
 b=vE45B+d9vKwrBHdVHxVDcfh3b1uy59v1xKCcWsIiWo3hX9s3460X/UMJ/I5dy8De5y
 bFzIdIvwhZ07zIelT9CGLpIIgBCvdBVQnUfYNj6nbA1n9UY2dfBSeZNPkvUneO6LnCdG
 6T9d6zU5krzaRUhpNyOhneyEL4HtJBgDKfyXReZZDCtaROP7pRUaumkLDECpv25O42QG
 KdQ+J9NeSP9b//W0yT6roeSAYQWdE+IFxBaLwc3Hi64QGhRB3VSNRi6pmSbVrCg8/JFr
 o8QIJ27CIe14qYDV//w56NYNy47KzsRM1w+8RXBKsG/eLThMVltkjrTARKgkxeGNC9l9
 C4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GivG2fWroyBp8LLT2a2aE/3FmiD4JPvufM2qhUiBXy4=;
 b=SWwJFX7igSD6h1pVILybd9MAA3CE44S+COKKVRH440VvBUwr78xe91Jfm/KtzFtD7B
 nIEm0ZkltqWj7DMn8ifK14Sle58yWJdNtYlJwME9w4VRwMxrGMigsPviN0Bw94EV76gz
 nwJDqQahajGKRg4MIg7sVJ1EXlJlVEFd5X2Q0G0j3KzYfSUfcSzb5dXySf7hRsFDeeuy
 UDLEjX056Gh453y7g9DRDoeXYkvwaaanTvSrLxa+4viqjEX28ZcpF2f5nNaa84Hwvkgq
 9mf63xkLO8Y0qFonkkdJ1zMjx1H56z3oKtJbrr5N2alrzl9Q4Y5Lo/h8rc+KBF4G0gTd
 8HIA==
X-Gm-Message-State: AOAM530DbeWugk7ZwOdv3BpVhl9VEOjZdgXRo3rpczHQxNgnMgloJX1+
 3Lq2tPZAmGZyv83QpJ55ufI=
X-Google-Smtp-Source: ABdhPJwMESRc5qVEx0pEipS19Jmxb3fR0cbxs0DdtwrW8SP0RBEQuTannHqqvy0lPiAIyxqd6WHzPg==
X-Received: by 2002:adf:f94c:: with SMTP id q12mr3587996wrr.417.1623412982985; 
 Fri, 11 Jun 2021 05:03:02 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:657d:4ae8:def3:d96a])
 by smtp.gmail.com with ESMTPSA id f13sm6898361wrt.86.2021.06.11.05.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 05:03:02 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] dma-buf: some dma_fence_chain improvements
Date: Fri, 11 Jun 2021 14:02:58 +0200
Message-Id: <20210611120301.10595-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210611120301.10595-1-christian.koenig@amd.com>
References: <20210611120301.10595-1-christian.koenig@amd.com>
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

VGhlIGNhbGxiYWNrIGFuZCB0aGUgaXJxIHdvcmsgYXJlIG5ldmVyIHVzZWQgYXQgdGhlIHNhbWUK
dGltZS4gUHV0dGluZyB0aGVtIGludG8gYW4gdW5pb24gc2F2ZXMgdXMgMjQgYnl0ZXMgYW5kCm1h
a2VzIHRoZSBzdHJ1Y3R1cmUgb25seSAxMjAgYnl0ZXMgaW4gc2l6ZS4KClNpZ25lZC1vZmYtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+Ci0tLQogZHJpdmVycy9kbWEt
YnVmL2RtYS1mZW5jZS1jaGFpbi5jIHwgIDIgKy0KIGluY2x1ZGUvbGludXgvZG1hLWZlbmNlLWNo
YWluLmggICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLQogMiBmaWxlcyBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZG1hLWJ1Zi9kbWEtZmVuY2UtY2hhaW4uYyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2UtY2hh
aW4uYwppbmRleCA3ZDEyOWU2OGFjNzAuLjFiNGNiM2U1Y2VjOSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9kbWEtYnVmL2RtYS1mZW5jZS1jaGFpbi5jCisrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVu
Y2UtY2hhaW4uYwpAQCAtMTM3LDYgKzEzNyw3IEBAIHN0YXRpYyB2b2lkIGRtYV9mZW5jZV9jaGFp
bl9jYihzdHJ1Y3QgZG1hX2ZlbmNlICpmLCBzdHJ1Y3QgZG1hX2ZlbmNlX2NiICpjYikKIAlzdHJ1
Y3QgZG1hX2ZlbmNlX2NoYWluICpjaGFpbjsKIAogCWNoYWluID0gY29udGFpbmVyX29mKGNiLCB0
eXBlb2YoKmNoYWluKSwgY2IpOworCWluaXRfaXJxX3dvcmsoJmNoYWluLT53b3JrLCBkbWFfZmVu
Y2VfY2hhaW5faXJxX3dvcmspOwogCWlycV93b3JrX3F1ZXVlKCZjaGFpbi0+d29yayk7CiAJZG1h
X2ZlbmNlX3B1dChmKTsKIH0KQEAgLTIzOSw3ICsyNDAsNiBAQCB2b2lkIGRtYV9mZW5jZV9jaGFp
bl9pbml0KHN0cnVjdCBkbWFfZmVuY2VfY2hhaW4gKmNoYWluLAogCXJjdV9hc3NpZ25fcG9pbnRl
cihjaGFpbi0+cHJldiwgcHJldik7CiAJY2hhaW4tPmZlbmNlID0gZmVuY2U7CiAJY2hhaW4tPnBy
ZXZfc2Vxbm8gPSAwOwotCWluaXRfaXJxX3dvcmsoJmNoYWluLT53b3JrLCBkbWFfZmVuY2VfY2hh
aW5faXJxX3dvcmspOwogCiAJLyogVHJ5IHRvIHJldXNlIHRoZSBjb250ZXh0IG9mIHRoZSBwcmV2
aW91cyBjaGFpbiBub2RlLiAqLwogCWlmIChwcmV2X2NoYWluICYmIF9fZG1hX2ZlbmNlX2lzX2xh
dGVyKHNlcW5vLCBwcmV2LT5zZXFubywgcHJldi0+b3BzKSkgewpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9kbWEtZmVuY2UtY2hhaW4uaCBiL2luY2x1ZGUvbGludXgvZG1hLWZlbmNlLWNoYWlu
LmgKaW5kZXggMTA0NjJhMDI5ZGEyLi5jNmViM2FhNDU2NjggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
bGludXgvZG1hLWZlbmNlLWNoYWluLmgKKysrIGIvaW5jbHVkZS9saW51eC9kbWEtZmVuY2UtY2hh
aW4uaApAQCAtMTYsMjEgKzE2LDM2IEBACiAvKioKICAqIHN0cnVjdCBkbWFfZmVuY2VfY2hhaW4g
LSBmZW5jZSB0byByZXByZXNlbnQgYW4gbm9kZSBvZiBhIGZlbmNlIGNoYWluCiAgKiBAYmFzZTog
ZmVuY2UgYmFzZSBjbGFzcwotICogQGxvY2s6IHNwaW5sb2NrIGZvciBmZW5jZSBoYW5kbGluZwog
ICogQHByZXY6IHByZXZpb3VzIGZlbmNlIG9mIHRoZSBjaGFpbgogICogQHByZXZfc2Vxbm86IG9y
aWdpbmFsIHByZXZpb3VzIHNlcW5vIGJlZm9yZSBnYXJiYWdlIGNvbGxlY3Rpb24KICAqIEBmZW5j
ZTogZW5jYXBzdWxhdGVkIGZlbmNlCi0gKiBAY2I6IGNhbGxiYWNrIHN0cnVjdHVyZSBmb3Igc2ln
bmFsaW5nCi0gKiBAd29yazogaXJxIHdvcmsgaXRlbSBmb3Igc2lnbmFsaW5nCisgKiBAbG9jazog
c3BpbmxvY2sgZm9yIGZlbmNlIGhhbmRsaW5nCiAgKi8KIHN0cnVjdCBkbWFfZmVuY2VfY2hhaW4g
ewogCXN0cnVjdCBkbWFfZmVuY2UgYmFzZTsKLQlzcGlubG9ja190IGxvY2s7CiAJc3RydWN0IGRt
YV9mZW5jZSBfX3JjdSAqcHJldjsKIAl1NjQgcHJldl9zZXFubzsKIAlzdHJ1Y3QgZG1hX2ZlbmNl
ICpmZW5jZTsKLQlzdHJ1Y3QgZG1hX2ZlbmNlX2NiIGNiOwotCXN0cnVjdCBpcnFfd29yayB3b3Jr
OworCXVuaW9uIHsKKwkJLyoqCisJCSAqIEBjYjogY2FsbGJhY2sgZm9yIHNpZ25hbGluZworCQkg
KgorCQkgKiBUaGlzIGlzIHVzZWQgdG8gYWRkIHRoZSBjYWxsYmFjayBmb3Igc2lnbmFsaW5nIHRo
ZQorCQkgKiBjb21wbGVjdGlvbiBvZiB0aGUgZmVuY2UgY2hhaW4uIE5ldmVyIHVzZWQgYXQgdGhl
IHNhbWUgdGltZQorCQkgKiBhcyB0aGUgaXJxIHdvcmsuCisJCSAqLworCQlzdHJ1Y3QgZG1hX2Zl
bmNlX2NiIGNiOworCisJCS8qKgorCQkgKiBAd29yazogaXJxIHdvcmsgaXRlbSBmb3Igc2lnbmFs
aW5nCisJCSAqCisJCSAqIElycSB3b3JrIHN0cnVjdHVyZSB0byBhbGxvdyB1cyB0byBhZGQgdGhl
IGNhbGxiYWNrIHdpdGhvdXQKKwkJICogcnVubmluZyBpbnRvIGxvY2sgaW52ZXJzaW9uLiBOZXZl
ciB1c2VkIGF0IHRoZSBzYW1lIHRpbWUgYXMKKwkJICogdGhlIGNhbGxiYWNrLgorCQkgKi8KKwkJ
c3RydWN0IGlycV93b3JrIHdvcms7CisJfTsKKwlzcGlubG9ja190IGxvY2s7CiB9OwogCiBleHRl
cm4gY29uc3Qgc3RydWN0IGRtYV9mZW5jZV9vcHMgZG1hX2ZlbmNlX2NoYWluX29wczsKLS0gCjIu
MjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
