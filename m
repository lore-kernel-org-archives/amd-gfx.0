Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00980C63777
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FFC20872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+ft6BuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FFC20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED526E925;
	Wed, 25 Nov 2020 08:22:59 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E886E542
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:20 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id t4so10607632wrr.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6BIBjiOdivrzYawdrQqwhLZi7LHNHFFVX0tDFPG1aP4=;
 b=S+ft6BuTv+JtOVsSGQS38Kw5N5F+7HgwyqOwHtI4YmLpPi8myfl9uf/3DTCLKlBmG8
 U/KUA9OBoVwRem49Ansk6PTyOuiFaTFxK5D05JMdRD7lLxS4N3xkpFovqXuy2TQqaVfs
 llG68eAtYZkhHtrj0DvGypS6D7uB0GwhKM0lfgXPgCLQye/PAwFaX277L5GeutR9iNmh
 3abHn1zZaQm+XcmKhu1ZDH9CVjBLpPUHmv40UTGu0vA3rVieMl0msCICGCSRSV8YmCU3
 Ejlgn+3iG7Xh/BB4gBDCEWBaPXBQe4QCQgSdD1+cWLIE9PhTH1syZe5cBsnSIciT4eb5
 rpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6BIBjiOdivrzYawdrQqwhLZi7LHNHFFVX0tDFPG1aP4=;
 b=S2U6PRRh+NO+HP5iz2BE16qdLf/Uj2uUXQtHIH27k+dars+pRUylGY4+8F0JlMmndf
 noGfxky9dWI5kDo7+1wEcHXTeprNFHl3VZb6bXHyTkpoz6wREKLsB4wCH/EUVP3MREKN
 lxgGbt4jC+l1FIXcggNonXKtbYH/scTP/tJO6oPcE+raOvNfTPmUg4SIuAwx6xjiGiFC
 QTsBpMUN2Kt80Ius6ReN/sdAoiI4HgM6PWL4fJQ44onPK4BDJTQb4Wn555gipz/Qv/Um
 /o10ed1bTGD84fIQMV53xGtvi8V+9D8kJsZfcIvyOUPENykQMlyPY8jYQhjlK4+PArrl
 Vhjg==
X-Gm-Message-State: AOAM531JWniJ6+Vcs7Ul+bVm8Ab4a522I13kZ/FVvfBTB4hz/MTfG0cO
 q7vXEvSomOhWAH4S2pRVNl2U2Q==
X-Google-Smtp-Source: ABdhPJxIYo1Qzypys+c2KpL3kCVX7Czyu1/i5hvXZTCGnC8/99RXCscGF1oBsQHzN7Tg9eA66na2nA==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr126337wrn.56.1606247059082;
 Tue, 24 Nov 2020 11:44:19 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:18 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 16/40] drm/amd/amdgpu/gfx_v10_0: Remove a bunch of set but
 unused variables
Date: Tue, 24 Nov 2020 19:38:00 +0000
Message-Id: <20201124193824.1118741-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Nov 2020 08:22:58 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmM6IEluIGZ1bmN0aW9uIOKAmGdmeF92MTBf
cmxjZ193cmVn4oCZOgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmM6MTQx
NjoxODogd2FybmluZzogdmFyaWFibGUg4oCYZ3JibV9pZHjigJkgc2V0IGJ1dCBub3QgdXNlZCBb
LVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jOjE0MTU6MTg6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmGdyYm1fY250bOKAmSBzZXQg
YnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmM6MTQxMzoxNTogd2FybmluZzogdmFyaWFibGUg4oCYc2Ny
YXRjaF9yZWcz4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVd
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYzoxNDEyOjE1OiB3YXJuaW5n
OiB2YXJpYWJsZSDigJhzY3JhdGNoX3JlZzLigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQt
YnV0LXNldC12YXJpYWJsZV0KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
Q2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRh
bmllbEBmZndsbC5jaD4KQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+
CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8t
bW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9u
ZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
YyB8IDkgLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IGE2ZDAzOTMxZjdmYTQuLmQ0NzYwZjRl
MjY5YTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC0xNDA5LDIz
ICsxNDA5LDE0IEBAIHN0YXRpYyB2b2lkIGdmeF92MTBfcmxjZ193cmVnKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCB1MzIgb2Zmc2V0LCB1MzIgdikKIHsKIAlzdGF0aWMgdm9pZCAqc2NyYXRj
aF9yZWcwOwogCXN0YXRpYyB2b2lkICpzY3JhdGNoX3JlZzE7Ci0Jc3RhdGljIHZvaWQgKnNjcmF0
Y2hfcmVnMjsKLQlzdGF0aWMgdm9pZCAqc2NyYXRjaF9yZWczOwogCXN0YXRpYyB2b2lkICpzcGFy
ZV9pbnQ7Ci0Jc3RhdGljIHVpbnQzMl90IGdyYm1fY250bDsKLQlzdGF0aWMgdWludDMyX3QgZ3Ji
bV9pZHg7CiAJdWludDMyX3QgaSA9IDA7CiAJdWludDMyX3QgcmV0cmllcyA9IDUwMDAwOwogCiAJ
c2NyYXRjaF9yZWcwID0gYWRldi0+cm1taW8gKyAoYWRldi0+cmVnX29mZnNldFtHQ19IV0lQXVsw
XVttbVNDUkFUQ0hfUkVHMF9CQVNFX0lEWF0gKyBtbVNDUkFUQ0hfUkVHMCkqNDsKIAlzY3JhdGNo
X3JlZzEgPSBhZGV2LT5ybW1pbyArIChhZGV2LT5yZWdfb2Zmc2V0W0dDX0hXSVBdWzBdW21tU0NS
QVRDSF9SRUcxX0JBU0VfSURYXSArIG1tU0NSQVRDSF9SRUcxKSo0OwotCXNjcmF0Y2hfcmVnMiA9
IGFkZXYtPnJtbWlvICsgKGFkZXYtPnJlZ19vZmZzZXRbR0NfSFdJUF1bMF1bbW1TQ1JBVENIX1JF
RzFfQkFTRV9JRFhdICsgbW1TQ1JBVENIX1JFRzIpKjQ7Ci0Jc2NyYXRjaF9yZWczID0gYWRldi0+
cm1taW8gKyAoYWRldi0+cmVnX29mZnNldFtHQ19IV0lQXVswXVttbVNDUkFUQ0hfUkVHMV9CQVNF
X0lEWF0gKyBtbVNDUkFUQ0hfUkVHMykqNDsKIAlzcGFyZV9pbnQgPSBhZGV2LT5ybW1pbyArIChh
ZGV2LT5yZWdfb2Zmc2V0W0dDX0hXSVBdWzBdW21tUkxDX1NQQVJFX0lOVF9CQVNFX0lEWF0gKyBt
bVJMQ19TUEFSRV9JTlQpKjQ7CiAKLQlncmJtX2NudGwgPSBhZGV2LT5yZWdfb2Zmc2V0W0dDX0hX
SVBdWzBdW21tR1JCTV9HRlhfQ05UTF9CQVNFX0lEWF0gKyBtbUdSQk1fR0ZYX0NOVEw7Ci0JZ3Ji
bV9pZHggPSBhZGV2LT5yZWdfb2Zmc2V0W0dDX0hXSVBdWzBdW21tR1JCTV9HRlhfSU5ERVhfQkFT
RV9JRFhdICsgbW1HUkJNX0dGWF9JTkRFWDsKLQogCWlmIChhbWRncHVfc3Jpb3ZfcnVudGltZShh
ZGV2KSkgewogCQlwcl9lcnIoInNob3VsZG4ndCBjYWxsIHJsY2cgd3JpdGUgcmVnaXN0ZXIgZHVy
aW5nIHJ1bnRpbWVcbiIpOwogCQlyZXR1cm47Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
