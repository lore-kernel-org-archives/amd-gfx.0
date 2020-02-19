Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2831EC34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 14:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E799E206ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJc4RRFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E799E206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0716EBFD;
	Wed, 19 Feb 2020 14:20:18 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2956EBFD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 14:20:17 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z7so691187wrl.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 06:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Iz/lBOctzF2na62EEgmGPlgUUUbopXrt/yQBN1t0Qxg=;
 b=RJc4RRFfzNgvPzhW3OlvR9gweq8iDvpcPdks4hs+B8OJdghG6pZHEW5W7kTgmUo/QV
 xXN9nyTOunBT2/LrRbMm4oEnCRwIT4UV4D+qUWM+kxMgb+JZEd9b2AD6GdCeWPUhGVrC
 vMFHrtEMBQNdHbyzF8g5NjoyzWFr4+qM2316JzF4+gh8Gwdgh7Pp94eLDUBTDOjU0wjE
 U9vxmWSTGWblyUXTiMs+mHxZvJPNHUUg6GP4wo8jgLphv7WXEGXv0443rSy/DvoWGRy4
 iHRARVTwbqCQ30L9wNGKZy8m9dhi2ieHXi22wAzE9hg1xa0Or5EUJg4IZldTNVi6boa5
 JXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Iz/lBOctzF2na62EEgmGPlgUUUbopXrt/yQBN1t0Qxg=;
 b=tHHjfxzbG1Az4f0+JZGd5qHL7Wj6l51QKhjVgpSyu2rZ2523HrHYjV9qTYtmYVd9fo
 DqeY9im7kj21eDs3/oSWnuhFmhAQmjreT07rGibFA1fCISYVAXV9TKZ7QqbbzMjweoMI
 cNsj2kht/xeRiK9aMfeidmKJtVVbIyj2GuVkpa1j7FJjUaTEPgbEgmrriAvek1HLamUn
 QDrRLXclMA8pxgomVXUJdQHltyQ7kdf9c9sou084n3X5h2UyICVJaUt9z6UPOUAa3xCx
 ffUPY8v+LGpvVRFsb9r+ix+yG9HRmo0f7U1lah9xqjniy1dFtNb+fRwqpV9w/BU6saAV
 zYZg==
X-Gm-Message-State: APjAAAXnQDXQMQD7oSPFPm4J16qhA5bHkbeOZY8oUbK43riXoieuC5lK
 YY7VLKQ28btvqrQEpRn5p68=
X-Google-Smtp-Source: APXvYqyZoMligX3U+ACbM5ZMsTvz71AcyCA0njvIkCO2XQgcEpuoi6ANv03WkQB/0IJVun6AYNSrsg==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr34972784wrq.176.1582122015738; 
 Wed, 19 Feb 2020 06:20:15 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:4054:9e4d:fa6d:3d9f])
 by smtp.gmail.com with ESMTPSA id q3sm3038072wmj.38.2020.02.19.06.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 06:20:15 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tom.stdenis@amd.com, luben.tuikov@amd.com, Marek.Olsak@amd.com,
 Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add VM update fences back to the root PD
Date: Wed, 19 Feb 2020 15:20:14 +0100
Message-Id: <20200219142014.25386-1-christian.koenig@amd.com>
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

QWRkIHVwZGF0ZSBmZW5jZXMgdG8gdGhlIHJvb3QgUEQgd2hpbGUgbWFwcGluZyBCT3MuCgpPdGhl
cndpc2UgUERzIGZyZWVkIGR1cmluZyB0aGUgbWFwcGluZyB3b24ndCB3YWl0IGZvcgp1cGRhdGVz
IHRvIGZpbmlzaCBhbmQgY2FuIGNhdXNlIGNvcnJ1cHRpb25zLgoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTQgKysrKysrKysrKysrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggZTdhYjBjMWUyNzkzLi5kZDYzY2NkYmFkMmEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCkBAIC01ODUsOCArNTg1LDggQEAg
dm9pZCBhbWRncHVfdm1fZ2V0X3BkX2JvKHN0cnVjdCBhbWRncHVfdm0gKnZtLAogewogCWVudHJ5
LT5wcmlvcml0eSA9IDA7CiAJZW50cnktPnR2LmJvID0gJnZtLT5yb290LmJhc2UuYm8tPnRibzsK
LQkvKiBPbmUgZm9yIFRUTSBhbmQgb25lIGZvciB0aGUgQ1Mgam9iICovCi0JZW50cnktPnR2Lm51
bV9zaGFyZWQgPSAyOworCS8qIFR3byBmb3IgVk0gdXBkYXRlcywgb25lIGZvciBUVE0gYW5kIG9u
ZSBmb3IgdGhlIENTIGpvYiAqLworCWVudHJ5LT50di5udW1fc2hhcmVkID0gNDsKIAllbnRyeS0+
dXNlcl9wYWdlcyA9IE5VTEw7CiAJbGlzdF9hZGQoJmVudHJ5LT50di5oZWFkLCB2YWxpZGF0ZWQp
OwogfQpAQCAtMTYxOSw2ICsxNjE5LDE2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0
ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlnb3RvIGVycm9yX3VubG9j
azsKIAl9CiAKKwlpZiAoZmxhZ3MgJiBBTURHUFVfUFRFX1ZBTElEKSB7CisJCXN0cnVjdCBhbWRn
cHVfYm8gKnJvb3QgPSB2bS0+cm9vdC5iYXNlLmJvOworCisJCWlmICghZG1hX2ZlbmNlX2lzX3Np
Z25hbGVkKHZtLT5sYXN0X2RpcmVjdCkpCisJCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxh
c3RfZGlyZWN0LCB0cnVlKTsKKworCQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFz
dF9kZWxheWVkKSkKKwkJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kZWxheWVkLCB0
cnVlKTsKKwl9CisKIAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCByZXN2
LCBzeW5jX21vZGUpOwogCWlmIChyKQogCQlnb3RvIGVycm9yX3VubG9jazsKLS0gCjIuMTcuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
