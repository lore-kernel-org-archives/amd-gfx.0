Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3E7C33C9E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DE02075A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/iaqDAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DE02075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297266E48D;
	Mon,  6 Jan 2020 15:03:52 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCB96E48C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 15:03:50 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id b6so50014594wrq.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 07:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DHm3aHULvmF0WJiRwdqBVicbVr3vaSMm1k7zP5D/pQU=;
 b=q/iaqDAizPMHJlPX1jblpfpogBTmC7d1kqhEeIoAUaKEItQ+3ErcQNNAmoTMne3pSe
 ta06Gz6dFuER9A2JpPQgMakgdNBuQ5viw50dXAEVMkP5B3voJnXNMPr+Zb8S/eJieAcs
 omCKFhwJYeyDKCUlVuXXYteMJImgj+5X5eYwwkeInX545zMXM57SECWyiROr8saf5gXD
 EKZ5cnbKtMJlM/fEsKO7N5Ki3GA4TdEh2y9RtBQPjAvNk1hqp0HnVE2RCuT3g078PFR6
 ukapy1HGMahB35oDB0RnP1J8zCtoIctF82ogzmlt5O+q5+YbCHpvl8pn7KpMhioWVpcW
 LpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DHm3aHULvmF0WJiRwdqBVicbVr3vaSMm1k7zP5D/pQU=;
 b=PejEuCEdBFxn4j8JVQvfuhmTcW3QmBToAyYjZRL0i2bVfyWTFoaY3pFGocQfr2L+ih
 KdliMHwkjF8/bzswuj2AM84Jhxshn8GAiBnsR5z2NgCuPDNi/X+txM0ia6YX7jJp2wet
 ZByiCId3V2hIxF+5FLbNjmNOxSqQAxFYcV9kcZu7+AP1yNKISzgVSTpWLhTgwNIlr8+h
 mv4f8XmtrM2LdGogkA7q5uML8y4Wxd3o9KXBdMpJlaGaDZOKmLABvy/kbb2UZxtV1fhN
 DJFcXaFQIVA9lOsKqjsUiYrilkrPcssK3Hoef8JgA4Nuh/AfGMmfluNPhxn7XbjOFaQN
 YmiQ==
X-Gm-Message-State: APjAAAWW1U/19P3FweaKdIe39K9jWLhQvYJtd98hdoM/UpMUTqLKLAKl
 6SHTIaDSesQituUDQg9r0pI=
X-Google-Smtp-Source: APXvYqz+erCf8c+G1YABpFTi/fw9jwFey7T0VQ4KY/wRd209vUgxtQ9DkbpZ3Ub6+xon1EjUp8CcdQ==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr102818697wrj.349.1578323029290; 
 Mon, 06 Jan 2020 07:03:49 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:ece2:ff95:11ee:3e72])
 by smtp.gmail.com with ESMTPSA id b17sm70307444wrp.49.2020.01.06.07.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 07:03:48 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alex.Sierra@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/12] drm/amdgpu: make sure to never allocate PDs/PTs for
 invalidations
Date: Mon,  6 Jan 2020 16:03:35 +0100
Message-Id: <20200106150335.1738-13-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106150335.1738-1-christian.koenig@amd.com>
References: <20200106150335.1738-1-christian.koenig@amd.com>
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
bWRncHVfdm0uYwppbmRleCAyMzcyOWZkZDM0ZmIuLjBlOGFiMDkxNjhmYyAxMDA2NDQKLS0tIGEv
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
