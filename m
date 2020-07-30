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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA802C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC06F2074B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIV6l9RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC06F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F676E962;
	Thu, 30 Jul 2020 20:04:35 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF266E959
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:34 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id w2so1020054qvh.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=38JRMxtvGewFXwX7b3JairLsQNC45OAvJ5LZNjhQghI=;
 b=dIV6l9REzaHynSaLs2HlAY39BjGUMPsVyjCrEu5XsVFl9qr10m9/UYNU5YfZG/Z5Vq
 AQyLI/cUk6JD9WFJzCij4OKGmLmsagazeQXeDD3Mo7qFrMUL0vC+kS29gRwUOa+I3yC9
 27aOAi7wejfgg9dQ0/v5r6rQXV9wSCMtqyfb8wlGb9q34IYS2oyNTYHAZ4Wi6WN1jG7Z
 +seom339AT6MmJoDa4o2nR8yyG5IgQft38NhBuaADHH0OoG8IE3zb8GL6gR7k34TBAPX
 AOuzzsZhCDJbMgilP9haxv4wsKe89mjw1THOXgTHCwiqPpx9aEbmgx/+zD/jJmxkr44h
 wboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=38JRMxtvGewFXwX7b3JairLsQNC45OAvJ5LZNjhQghI=;
 b=ElprB+oV87+cFuW3uTdmG9WD7qDDIKKhHUD11JPC3xR8hZlvZXAOaT7vAVUeeX1IP+
 6GSMoMLrskkez1g7a1gpvx3q0e/GRrC1bFRHFXNt71EssXnkk+ZO9mbmn9gDmsQ9lzt+
 iMNVLiXRZP8PaX/17E0VsBUYqogpBRqpSCK98WKBloUXoDFkS8EUNPFyfTDL4Xl6elEe
 ju8tPcvp2vDtwL1AQ9FMxlVmjAhsk0FX3KjHjA95VjUmdyCL9nJrDaPILZsNoeuvR8qz
 iD1DI0vkOxvoC96/+8sEpeJUfaO+bCgLE/hrnHYlRPU76D2dJbVkSdnU1A3oIUnzGCEZ
 CibA==
X-Gm-Message-State: AOAM531lorpC8hO9dh9/vPw8whA8BqLk72qRZEIEAZ1Ad8ygURi0p/Ux
 99OoJGIsocTR/MiFNwvgLSsjYlG5
X-Google-Smtp-Source: ABdhPJzonZj9YKs9h4U5SvTCJ/+ymAuT043jy6oG+BwO7+BJvmjkG7AyJ/ltV2C/NBuRLXYulUJWkA==
X-Received: by 2002:a0c:b598:: with SMTP id g24mr794816qve.55.1596139473352;
 Thu, 30 Jul 2020 13:04:33 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:32 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/17] drm/amdgpu/gmc8: switch to using
 amdgpu_gmc_get_vbios_allocations
Date: Thu, 30 Jul 2020 16:04:07 -0400
Message-Id: <20200730200414.40485-11-alexander.deucher@amd.com>
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

VGhlIG5ldyBoZWxwZXIgY2VudHJhbGl6ZXMgdGhlIGxvZ2ljIGluIG9uZSBwbGFjZS4KClJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClJldmll
d2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMgfCA5ICsrKystLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y4XzAuYwppbmRleCA4ZTM3NjNlYzI2OGYuLjlhYjY1Y2E3ZGY3NyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjhfMC5jCkBAIC0xMDk0LDkgKzEwOTQsNyBAQCBzdGF0
aWMgdW5zaWduZWQgZ21jX3Y4XzBfZ2V0X3ZiaW9zX2ZiX3NpemUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCiAJCQlSRUdfR0VUX0ZJRUxEKHZpZXdwb3J0LCBWSUVXUE9SVF9TSVpFLCBWSUVX
UE9SVF9XSURUSCkgKgogCQkJNCk7CiAJfQotCS8qIHJldHVybiAwIGlmIHRoZSBwcmUtT1MgYnVm
ZmVyIHVzZXMgdXAgbW9zdCBvZiB2cmFtICovCi0JaWYgKChhZGV2LT5nbWMucmVhbF92cmFtX3Np
emUgLSBzaXplKSA8ICg4ICogMTAyNCAqIDEwMjQpKQotCQlyZXR1cm4gMDsKKwogCXJldHVybiBz
aXplOwogfQogCkBAIC0xMTYwLDcgKzExNTgsNyBAQCBzdGF0aWMgaW50IGdtY192OF8wX3N3X2lu
aXQodm9pZCAqaGFuZGxlKQogCWlmIChyKQogCQlyZXR1cm4gcjsKIAotCWFkZXYtPmdtYy5zdG9s
ZW5fdmdhX3NpemUgPSBnbWNfdjhfMF9nZXRfdmJpb3NfZmJfc2l6ZShhZGV2KTsKKwlhbWRncHVf
Z21jX2dldF92Ymlvc19hbGxvY2F0aW9ucyhhZGV2KTsKIAogCS8qIE1lbW9yeSBtYW5hZ2VyICov
CiAJciA9IGFtZGdwdV9ib19pbml0KGFkZXYpOwpAQCAtMTczOSw3ICsxNzM3LDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBhbWRncHVfZ21jX2Z1bmNzIGdtY192OF8wX2dtY19mdW5jcyA9IHsKIAku
ZW1pdF9wYXNpZF9tYXBwaW5nID0gZ21jX3Y4XzBfZW1pdF9wYXNpZF9tYXBwaW5nLAogCS5zZXRf
cHJ0ID0gZ21jX3Y4XzBfc2V0X3BydCwKIAkuZ2V0X3ZtX3BkZSA9IGdtY192OF8wX2dldF92bV9w
ZGUsCi0JLmdldF92bV9wdGUgPSBnbWNfdjhfMF9nZXRfdm1fcHRlCisJLmdldF92bV9wdGUgPSBn
bWNfdjhfMF9nZXRfdm1fcHRlLAorCS5nZXRfdmJpb3NfZmJfc2l6ZSA9IGdtY192OF8wX2dldF92
Ymlvc19mYl9zaXplLAogfTsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfaXJxX3NyY19m
dW5jcyBnbWNfdjhfMF9pcnFfZnVuY3MgPSB7Ci0tIAoyLjI1LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
