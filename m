Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FF5C2D0B1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 14:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8936A21741
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 14:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skLRQPAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8936A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290B66FA6E;
	Thu,  6 Feb 2020 14:30:55 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6ED6EA89
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 14:30:54 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id w12so7490554wrt.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2020 06:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FigsWp9aLV2e3dsbsrGrLz8S3SAr5TAdE7odAgkqaX8=;
 b=skLRQPAycKt9UgTJ5qYM7+QoOtmvOK2ZOSPJJ9hQY3mRH5T1cxLrgjeAC5C3oTW6pQ
 UgJdKHwLEexipDGg7wn6fW5+LtmSs/A2fmSsSBcziDebzg2nE90QAaEJfvrrMrTc8JrS
 K0gOkA7hKSFtcr4JpjDiFWo8YapfZQPaj0c9WcUPy0K1+tEUvhyHnUcXAK71ih5xga5o
 teqoJEd2FU7oW5lcO+XTVjw5AgqwVmDEjDQDUVr/R6u/mzZ8CHciAAQHuHcKD90/dCG7
 QqvH2ur7R+e3KPsO08oDR0cDYGS0YB6gKzxPSannkHd8CIcMVp9Kfwgh+9UdxidpaRdv
 wJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FigsWp9aLV2e3dsbsrGrLz8S3SAr5TAdE7odAgkqaX8=;
 b=DX3EwC4wuQ2WQ/PjOdD5hMsU9ZPhO6fJPbikRlO0ocdwKUsSLAgLQQHEXKyVjEgQE7
 hYWId/jf/OurtoE/+vfF5w6jQuzca9Mqo97B9Y6XX2w7x0yrtz9ZMrsrvqi1euEwF6yH
 4A5DIriTS2VHufa99YSg6ge10e9v0UU6OpC2Ow46eufNtKYOA9ZIwbtNmLCvRARFu68g
 2ACsCRJNmE1a1LestW/TcsZjBIiwxdFhE3jRyrY/8+4knVE3sIGGdSrNgXqxIENRifP4
 zZqn+OhLS/WrZktwNXZb/owmZlrofDe8Ay2uuWWRabxNI5NQgpUNy4nqK6MPWaLsESN9
 mKcQ==
X-Gm-Message-State: APjAAAXfX0FKtUMIhLAa0Z098tv+LdtDgEcOC3OJQeslrnALQIWC8KEw
 754CyjmL9+zqAkUgI69Gm2l4A+Fg
X-Google-Smtp-Source: APXvYqxjl8impRQCEWSgNm/zenNmKw05qH7FXHpV66k1tx2Z46oX6LMRLZyIR9qHp3MfmEyI1OKg2A==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr4084857wrm.24.1580999452667;
 Thu, 06 Feb 2020 06:30:52 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:28f7:e4aa:841b:b35])
 by smtp.gmail.com with ESMTPSA id a198sm3878344wme.12.2020.02.06.06.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 06:30:52 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, Jonathan.Kim@amd.com
Subject: [PATCH 1/4] drm/amdgpu: optimize amdgpu_device_vram_access a bit.
Date: Thu,  6 Feb 2020 15:30:48 +0100
Message-Id: <20200206143051.25809-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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

T25seSB3cml0ZSB0aGUgX0hJIHJlZ2lzdGVyIHdoZW4gbmVjZXNzYXJ5LgoKU2lnbmVkLW9mZi1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpBY2tlZC1ieTogSm9u
YXRoYW4gS2ltIDxKb25hdGhhbi5LaW1AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAxNyArKysrKysrKysrKy0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IGYzM2M0OWVkNGY5NC4uYmU0ZTZjMzNk
N2UzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0x
ODQsMjAgKzE4NCwyNSBAQCBib29sIGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYmFjbyhzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGV2KQogdm9pZCBhbWRncHVfZGV2aWNlX3ZyYW1fYWNjZXNzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBsb2ZmX3QgcG9zLAogCQkJICAgICAgIHVpbnQzMl90ICpidWYs
IHNpemVfdCBzaXplLCBib29sIHdyaXRlKQogewotCXVpbnQ2NF90IGxhc3Q7CiAJdW5zaWduZWQg
bG9uZyBmbGFnczsKKwl1aW50MzJfdCBoaSA9IH4wOworCXVpbnQ2NF90IGxhc3Q7CisKKwlzcGlu
X2xvY2tfaXJxc2F2ZSgmYWRldi0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOworCWZvciAobGFzdCA9
IHBvcyArIHNpemU7IHBvcyA8IGxhc3Q7IHBvcyArPSA0KSB7CisJCXVpbnQzMl90IHRtcCA9IHBv
cyA+PiAzMTsKIAotCWxhc3QgPSBzaXplIC0gNDsKLQlmb3IgKGxhc3QgKz0gcG9zOyBwb3MgPD0g
bGFzdDsgcG9zICs9IDQpIHsKLQkJc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPm1taW9faWR4X2xv
Y2ssIGZsYWdzKTsKIAkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYLCAoKHVpbnQzMl90KXBvcykg
fCAweDgwMDAwMDAwKTsKLQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYX0hJLCBwb3MgPj4gMzEp
OworCQlpZiAodG1wICE9IGhpKSB7CisJCQlXUkVHMzJfTk9fS0lRKG1tTU1fSU5ERVhfSEksIHRt
cCk7CisJCQloaSA9IHRtcDsKKwkJfQogCQlpZiAod3JpdGUpCiAJCQlXUkVHMzJfTk9fS0lRKG1t
TU1fREFUQSwgKmJ1ZisrKTsKIAkJZWxzZQogCQkJKmJ1ZisrID0gUlJFRzMyX05PX0tJUShtbU1N
X0RBVEEpOwotCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhZGV2LT5tbWlvX2lkeF9sb2NrLCBm
bGFncyk7CiAJfQorCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmFkZXYtPm1taW9faWR4X2xvY2ss
IGZsYWdzKTsKIH0KIAogLyoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
