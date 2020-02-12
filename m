Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4BCC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1369206D7
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXCqW/S1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1369206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861136E05F;
	Wed, 12 Feb 2020 15:14:30 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8600F6E05F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 15:14:29 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id k11so2796216wrd.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7qIEDxoA5n+nDZi+aB5r9NMFjIEvfz5d9byZNfVAomY=;
 b=MXCqW/S1lVsrjwcI5nBjnfagUoIulCV0QO2FR4CYZNlOI0PHHy6jkUaQuxcqHoCQLM
 yNCYP1Sb++M+5ncGpuMExMX/YAAPcXpPeJCjgjq5jwDlNKtJ2KzF3pT9lMaGO7MLmHpw
 V4z3qYhRnTGidnPVhZarQIsEDP+V+dXGSaNhePPzplJBf4Ju0p8B07EjM6seFcTaRFjH
 L1T5a94Fo0ztBmBAWFqVdn4113eKyeF2qeV5X2CutoHt5IPOV2CPb6bVrMotruXnmE0V
 pf/g5ew9wcf+OEbmhTgA2l3GZSrHYX31ucwvdKQmvtJojC5jEr42CH9mtJ0XTPlvTlun
 eNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7qIEDxoA5n+nDZi+aB5r9NMFjIEvfz5d9byZNfVAomY=;
 b=lbvBY9kaHuoO4XneUTjJrErmfj+hGD//8xq9b+S1cztG1i0AxVDH8i2jO0w0KtJ0Vj
 lNXXhWEAkj1msg5fzKgQgDUDW5khpY/bH1q3m8H7hEWeilYV8K/vmH8lBHkOi8wy4ZRh
 nB0yYMXtbc+tU4zrqmZKcQCGN7s45z+UFHvnUGtrJJtpeJpSCCl30S7FaPYBTlOufLVw
 rmFdXhGcRFnM+mNMC09omMAFYgji09Kmk3rl4pk9aU3+PpZ1oeA/l5MxEhvQrfP8Fe29
 RJgUq19gvKm4LgmIhpzVaZVFxKKBbOYBzopoS6taFk2BhBoMSYxtBQsGZGFECQUr7aBb
 EWng==
X-Gm-Message-State: APjAAAVGmbRCCzYtTisnfaGaqBOdu723PlmtIMO4MtljlOkOVtzjNK1A
 Ko0YjJqO6cj1dOr4bIU2k2k=
X-Google-Smtp-Source: APXvYqwt1Yb7sx1ss+BSTDbgikzybT9/E4eO+mmAAt7xywyO5lxtaBJ6nUHpxHOCyPGZFJ6JW4O0kw==
X-Received: by 2002:a5d:678f:: with SMTP id v15mr16088058wru.27.1581520468179; 
 Wed, 12 Feb 2020 07:14:28 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:741b:2606:fddf:22a])
 by smtp.gmail.com with ESMTPSA id b10sm937489wrw.61.2020.02.12.07.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 07:14:27 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alex.sierra@amd.com, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: stop allocating PDs/PTs with the eviction lock
 held
Date: Wed, 12 Feb 2020 16:14:26 +0100
Message-Id: <20200212151426.14197-1-christian.koenig@amd.com>
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

V2UgbmVlZCB0byBtYWtlIHN1cmUgdG8gbm90IGFsbG9jYXRlIFBEcy9QVHMgd2hpbGUgaG9sZGlu
Zwp0aGUgZXZpY3Rpb24gbG9jayBvciBvdGhlcndpc2Ugd2Ugd2lsbCBydW4gaW50byBsb2NrIGlu
dmVyc2lvbgppbiB0aGUgTU0gYXMgc29vbiBhcyB3ZSBlbmFibGUgdGhlIE1NVSBub3RpZmllci4K
ClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDMxICsrKysr
KysrKysrKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4
IDc3YzQwMDY3NWI3OS4uZTdhYjBjMWUyNzkzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYwpAQCAtODk3LDI3ICs4OTcsNDIgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxs
b2NfcHRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCXN0cnVjdCBhbWRncHVfdm1fcHQg
KmVudHJ5ID0gY3Vyc29yLT5lbnRyeTsKIAlzdHJ1Y3QgYW1kZ3B1X2JvX3BhcmFtIGJwOwogCXN0
cnVjdCBhbWRncHVfYm8gKnB0OworCWJvb2wgbmVlZF9lbnRyaWVzOwogCWludCByOwogCi0JaWYg
KGN1cnNvci0+bGV2ZWwgPCBBTURHUFVfVk1fUFRCICYmICFlbnRyeS0+ZW50cmllcykgeworCW5l
ZWRfZW50cmllcyA9IGN1cnNvci0+bGV2ZWwgPCBBTURHUFVfVk1fUFRCICYmICFlbnRyeS0+ZW50
cmllczsKKwlpZiAoIW5lZWRfZW50cmllcyAmJiBlbnRyeS0+YmFzZS5ibykKKwkJcmV0dXJuIDA7
CisKKwkvKiBXZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IHdlIGRvbid0IGFsbG9jYXRlIFBEcy9Q
VHMgd2hpbGUgaG9sZGluZyB0aGUKKwkgKiBldmljdGlvbiBsb2NrIG9yIHdlIHJ1biBpbnRvIGxv
Y2sgcmVjdXJzaW9uIGluIHRoZSBNTS4KKwkgKi8KKwlhbWRncHVfdm1fZXZpY3Rpb25fdW5sb2Nr
KHZtKTsKKworCWlmIChuZWVkX2VudHJpZXMpIHsKIAkJdW5zaWduZWQgbnVtX2VudHJpZXM7CiAK
IAkJbnVtX2VudHJpZXMgPSBhbWRncHVfdm1fbnVtX2VudHJpZXMoYWRldiwgY3Vyc29yLT5sZXZl
bCk7CiAJCWVudHJ5LT5lbnRyaWVzID0ga3ZtYWxsb2NfYXJyYXkobnVtX2VudHJpZXMsCiAJCQkJ
CQlzaXplb2YoKmVudHJ5LT5lbnRyaWVzKSwKIAkJCQkJCUdGUF9LRVJORUwgfCBfX0dGUF9aRVJP
KTsKLQkJaWYgKCFlbnRyeS0+ZW50cmllcykKLQkJCXJldHVybiAtRU5PTUVNOworCQlpZiAoIWVu
dHJ5LT5lbnRyaWVzKSB7CisJCQlyID0gLUVOT01FTTsKKwkJCWdvdG8gZXJyb3JfbG9jazsKKwkJ
fQogCX0KIAotCWlmIChlbnRyeS0+YmFzZS5ibykKLQkJcmV0dXJuIDA7CisJaWYgKGVudHJ5LT5i
YXNlLmJvKSB7CisJCXIgPSAwOworCQlnb3RvIGVycm9yX2xvY2s7CisJfQogCiAJYW1kZ3B1X3Zt
X2JvX3BhcmFtKGFkZXYsIHZtLCBjdXJzb3ItPmxldmVsLCBkaXJlY3QsICZicCk7CiAKIAlyID0g
YW1kZ3B1X2JvX2NyZWF0ZShhZGV2LCAmYnAsICZwdCk7CisJYW1kZ3B1X3ZtX2V2aWN0aW9uX2xv
Y2sodm0pOwogCWlmIChyKQotCQlyZXR1cm4gcjsKKwkJZ290byBlcnJvcl9mcmVlX3B0OwogCiAJ
LyogS2VlcCBhIHJlZmVyZW5jZSB0byB0aGUgcm9vdCBkaXJlY3RvcnkgdG8gYXZvaWQKIAkgKiBm
cmVlaW5nIHRoZW0gdXAgaW4gdGhlIHdyb25nIG9yZGVyLgpAQCAtOTM2LDYgKzk1MSwxMCBAQCBz
dGF0aWMgaW50IGFtZGdwdV92bV9hbGxvY19wdHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
CiAJYW1kZ3B1X2JvX3VucmVmKCZwdCk7CiAJZW50cnktPmJhc2UuYm8gPSBOVUxMOwogCXJldHVy
biByOworCitlcnJvcl9sb2NrOgorCWFtZGdwdV92bV9ldmljdGlvbl9sb2NrKHZtKTsKKwlyZXR1
cm4gcjsKIH0KIAogLyoqCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
