Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB68C388F2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 11:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64C7222B9
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 11:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev1/B8Tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64C7222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77CDE6E4C7;
	Mon,  2 Nov 2020 11:33:59 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 807186E4B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 11:33:57 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id x7so14195261wrl.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 03:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=B0s53oQFZSsuySPKeDO5gBj87CKNFuM3CWXiP0WWHc0=;
 b=ev1/B8TgqYzFH63i0rQ+3Wu08ijsxtUZ1nj9qrqrrOmYK9eBDNBFF5hcCK0PwLY+gm
 JM2g78aJRswcIAD6Ml0atU/zGud/29wmoDGwEtznq+uO4FzTyqDlJvFE1g9nNPwEaXf9
 wH/ts9vEn13FdsVctljlvYCWMQcgUJg/5cyDJQpp6plYuN5s5LIuwXQgg1EYe/JkI6k+
 RE9d+v8lSUFjY0PpVMzdd9lR0dWn/2LbtNNS1ab13MLtESd9hzfEv3GRNcEBR22iqXNU
 cQvgjNMNzbwyPCclGZ5yCz1IIXDP30Nb2XLpYqodnocY64Z73Y1IHYlMJNxnFoJo1Qxl
 75fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B0s53oQFZSsuySPKeDO5gBj87CKNFuM3CWXiP0WWHc0=;
 b=ShTPYufiGH7h3HBspBC601BsPtClNeYGkJVZxjNmvlAMI1AdaH9rI9mdDWUknR2EOQ
 YsKkGB3mL8D1GZSfxw9Wo8qeYq7ld6osF35uwjizIJHI2Qz/Tx9vBSa1yQnILtMuyl2E
 dMkcxIwGASh7h1OEHVgEYVDDhzk6DL3osD1gPtoJlTD2WUv8avCEky8w9K3YPfhqZZRP
 76+qKqrLFPypAToB743HK7nKA5E5SwREGxEJWrFHAgLfiOMLn+hUL7ehN7Hn77c1+kTf
 uSTvqXGnFcvYdoVsIoLQRGvM7RjwqGU2bh8WZmEu04qp4uTzgK9AZEo8Ou0cKxY+qFvM
 ex9g==
X-Gm-Message-State: AOAM530Z84hkfvpq2z+BPprXZiKZZvp2qVYE7f0UPpmCNTNHYgmrXEap
 u1Lz9Eh6CStQjbRyRi6NigtrEaPcEBg=
X-Google-Smtp-Source: ABdhPJzrDkM2eXKCYqsVCpT0p6EUIqGpEbVbsR9Z2td6LsUee/1cmGx3IbghhgzQEoUlpLB5p/tS3g==
X-Received: by 2002:a5d:4747:: with SMTP id o7mr20447779wrs.423.1604316836064; 
 Mon, 02 Nov 2020 03:33:56 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:a78e:a39c:fa5b:5ef5])
 by smtp.gmail.com with ESMTPSA id 205sm15572704wme.38.2020.11.02.03.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 03:33:55 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	felix.kuehling@amd.com
Subject: [PATCH 2/3] drm/amdgpu: enabled software IH ring for Vega
Date: Mon,  2 Nov 2020 12:33:52 +0100
Message-Id: <20201102113353.1422-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102113353.1422-1-christian.koenig@amd.com>
References: <20201102113353.1422-1-christian.koenig@amd.com>
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

U2VlbXMgbGlrZSB3ZSB3b24ndCBnZXQgdGhlIGhhcmR3YXJlIElIMS8yIHJpbmdzIG9uIFZlZ2Ey
MCB3b3JraW5nLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5j
IHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYwppbmRleCA0MDdjNjA5M2MyZWMuLmNlZjYxZGQ0NmEz
NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKQEAgLTkxLDYgKzkxLDkg
QEAgc3RhdGljIHZvaWQgdmVnYTEwX2loX2VuYWJsZV9pbnRlcnJ1cHRzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQogCQl9CiAJCWFkZXYtPmlycS5paDIuZW5hYmxlZCA9IHRydWU7CiAJfQor
CisJaWYgKGFkZXYtPmlycS5paF9zb2Z0LnJpbmdfc2l6ZSkKKwkJYWRldi0+aXJxLmloX3NvZnQu
ZW5hYmxlZCA9IHRydWU7CiB9CiAKIC8qKgpAQCAtNjA2LDYgKzYwOSwxMCBAQCBzdGF0aWMgaW50
IHZlZ2ExMF9paF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIAlhZGV2LT5pcnEuaWgyLnVzZV9kb29y
YmVsbCA9IHRydWU7CiAJYWRldi0+aXJxLmloMi5kb29yYmVsbF9pbmRleCA9IChhZGV2LT5kb29y
YmVsbF9pbmRleC5paCArIDIpIDw8IDE7CiAKKwlyID0gYW1kZ3B1X2loX3JpbmdfaW5pdChhZGV2
LCAmYWRldi0+aXJxLmloX3NvZnQsIFBBR0VfU0laRSwgdHJ1ZSk7CisJaWYgKHIpCisJCXJldHVy
biByOworCiAJciA9IGFtZGdwdV9pcnFfaW5pdChhZGV2KTsKIAogCXJldHVybiByOwotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
