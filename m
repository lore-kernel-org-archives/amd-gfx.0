Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B6C433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 09:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130FA20709
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 09:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZr9p3Dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130FA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82FF6E96D;
	Thu,  3 Sep 2020 09:03:20 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FF96E96D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 09:03:19 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id u18so2051318wmc.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2020 02:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p0gc8MD4McCF7oe92BAVGRaIQ15cq8LQnK5YT9VxyNI=;
 b=PZr9p3Dy2NsPSDb7awz7/DthGFRyikw1RkGXznF1W/thPKR/whxiIGsEXEYEpld2SF
 s4bIACGlL4GhDUkzNA/C5R80/QCHDPhTKNUOPOClp3r4jPKvkgOC8u08nrBpIs6Rkaya
 xnepfGUMMFaGGCyN7Ml2XNp5GIY3WEbEq1btUmLLC8wWyD/bhm4bGYc3msMTsBleXxah
 NmGwImDNYaoY1vtkIyIPQbpLPDPx86dx3hOWUZ6GTPlXpsSDDx7ajkWrqgH4rABHoSSs
 PdC7eIm54Xcy6LT/Ow2ndyWhkraWYbPyFcDlqyPcBhlGztfcOD1hX3BqqN0qQ9NPAUco
 f/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p0gc8MD4McCF7oe92BAVGRaIQ15cq8LQnK5YT9VxyNI=;
 b=Kyf4NC6kj/JW2kT2RO+VOWaQiUMfMH3ZM+aYUI002cU/OPgIl2zI1lSTLoFevTC0w4
 czWXshb7SspyUXb/S+AT/NsmxnJgcbd6rQQD6J9zp7jP1bQ3q6UHncICNTLMIcc2xQ/s
 e8AbHrvmCJt68fB1uz9RfyJ4XRIeueKhPo+Icc89REpMfRyRB6MALLWHcUEHlK6sf5F7
 4LAi/N8Mc7+zgg6sWFbHSBZorjBHE6YoHahupFU5diOHX43STT1c9GobvcvJYI3YJCVr
 acr6Zte5XE+V4tHvdvWb5Uu8wLLXrF5mWNUEDuRXT3AsqdpTw1Lng43Em1VnMwU41bjF
 6n3A==
X-Gm-Message-State: AOAM532YVdzIQjnoztFiH+rDwFSyON2WdNnOXJfsLXTzbvXPs9DZuaQ8
 ozJ/rQqHGii9Uv4J9FyF8y0CdudFWKU=
X-Google-Smtp-Source: ABdhPJwRt6zhqv9S2K8c5qH1lxAxfmZerQkf7FqdIIAyFWAxK171/TJIU05R+vVdk6kpqjoHOibveA==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr1015146wmf.20.1599123797986; 
 Thu, 03 Sep 2020 02:03:17 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:51e:b8d1:430:d896])
 by smtp.gmail.com with ESMTPSA id 11sm3191492wmi.14.2020.09.03.02.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 02:03:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Xinhui.Pan@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix max_entries calculation v4
Date: Thu,  3 Sep 2020 11:03:16 +0200
Message-Id: <20200903090316.2123-1-christian.koenig@amd.com>
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

Q2FsY3VsYXRlIHRoZSBjb3JyZWN0IHZhbHVlIGZvciBtYXhfZW50cmllcyBvciB3ZSBtaWdodCBy
dW4gYWZ0ZXIgdGhlCnBhZ2VfYWRkcmVzcyBhcnJheS4KCnYyOiBYaW5odWkgcG9pbnRlZCBvdXQg
d2UgZG9uJ3QgbmVlZCB0aGUgc2hpZnQKdjM6IHVzZSBsb2NhbCBjb3B5IG9mIHN0YXJ0IGFuZCBz
aW1wbGlmeSBzb21lIGNhbGN1bGF0aW9uCnY0OiBmaXggdGhlIGNhc2UgdGhhdCB3ZSBtYXAgbGVz
cyBWQSByYW5nZSB0aGFuIEJPIHNpemUKClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KRml4ZXM6IDFlNjkxZTI0NDQ4NyBkcm0vYW1kZ3B1
OiBzdG9wIGFsbG9jYXRpbmcgZHVtbXkgR1RUIG5vZGVzCi0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKaW5kZXggOGJjMjI1MzkzOWJlLi5kNmRjZDU4YThmMWEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0xNjkxLDEzICsxNjkxLDEzIEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZtX2JvX3NwbGl0X21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJ
CXVpbnQ2NF90IG1heF9lbnRyaWVzOwogCQl1aW50NjRfdCBhZGRyLCBsYXN0OwogCisJCW1heF9l
bnRyaWVzID0gbWFwcGluZy0+bGFzdCAtIHN0YXJ0ICsgMTsKIAkJaWYgKG5vZGVzKSB7CiAJCQlh
ZGRyID0gbm9kZXMtPnN0YXJ0IDw8IFBBR0VfU0hJRlQ7Ci0JCQltYXhfZW50cmllcyA9IChub2Rl
cy0+c2l6ZSAtIHBmbikgKgotCQkJCUFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7CisJCQlt
YXhfZW50cmllcyA9IG1pbigobm9kZXMtPnNpemUgLSBwZm4pICoKKwkJCQlBTURHUFVfR1BVX1BB
R0VTX0lOX0NQVV9QQUdFLCBtYXhfZW50cmllcyk7CiAJCX0gZWxzZSB7CiAJCQlhZGRyID0gMDsK
LQkJCW1heF9lbnRyaWVzID0gUzY0X01BWDsKIAkJfQogCiAJCWlmIChwYWdlc19hZGRyKSB7CkBA
IC0xNzI3LDcgKzE3MjcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib19zcGxpdF9tYXBwaW5n
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJYWRkciArPSBwZm4gPDwgUEFHRV9TSElG
VDsKIAkJfQogCi0JCWxhc3QgPSBtaW4oKHVpbnQ2NF90KW1hcHBpbmctPmxhc3QsIHN0YXJ0ICsg
bWF4X2VudHJpZXMgLSAxKTsKKwkJbGFzdCA9IHN0YXJ0ICsgbWF4X2VudHJpZXMgLSAxOwogCQly
ID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKGFkZXYsIHZtLCBmYWxzZSwgZmFsc2UsIHJl
c3YsCiAJCQkJCQlzdGFydCwgbGFzdCwgZmxhZ3MsIGFkZHIsCiAJCQkJCQlkbWFfYWRkciwgZmVu
Y2UpOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
