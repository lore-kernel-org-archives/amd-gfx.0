Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D426C63697
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E426C20665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZZml1jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E426C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD2C89CA2;
	Tue, 10 Nov 2020 19:35:52 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72C589BF0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:22 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id d142so4344581wmd.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=StAAQEcBU7NR52Iv4O4K3Wzt60gqSmLeuRfVm5ltXDE=;
 b=mZZml1jytN4/9i59YihQPrNuAaWkUZdpVAXKmHE+4/4U0iTDxxXftQINnq5G5KzB7G
 YesRLVtr9cgChuzabdGh9KH2EuSxiXVqGIXVcVPQt0PXeGOfgTM5dOjXbabrkCeznPMS
 M/oG817gEvJDwb4E3oJv+VQi0vnLJ71+SwUju8DAErlpIANOm0L3QGER585yKxQzU2Sf
 ebwUEsuVFPKaXemnBJXXnWktrStj7pS8IV4rj3r73hdlRkZN+oQgb3LOacCljFAfP4Mj
 WTSoGT13avpp4RioJ2BY4M491H5h2fw29JW0vttsqLYfbm7NEnYd57MfEAr1ELF2pGoA
 MX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=StAAQEcBU7NR52Iv4O4K3Wzt60gqSmLeuRfVm5ltXDE=;
 b=g9HPQ9wNyk/k6xPRvtarbSJMFmv4Ed3YefDM3R6QMKi8tYf08LyxaDTlzz++A6VkAT
 fNUG/o8m1tihhef24ul62gXnhguO5zmzSnfj9zURJkDCV8i81eacFI8UFEyl4cnuVRlG
 tXtHcQ/wv91O8CSk+Ag9UUyJytryQ1kcVTeaRSSwnykuKBM/7l61xeLeFR3pNNRLB5Np
 +JNApKN4DGz1/IjgsecujqZ0s/S9trWk4uHcLloobFwIzk9Zlpuywx2jY0uxyvwpP0g5
 DeSRLDWEjjytiE81M6jDBAKCNgyLEr0OJL8UkAz0uZL22Squ8Vhl0kdYjX9mVg5Eup4k
 HkDg==
X-Gm-Message-State: AOAM533Iy6PHBX+7JslHLWljI2Ujd0PwuC+UF7Kyt1p4+APAswDnILg3
 XFNGpBFhApngbaDnfzfcsBoqAEUog6W6B2wr
X-Google-Smtp-Source: ABdhPJygMM2wHpSm/z5nOffXXW1qdVFhGsZ9Tt9PjrxCds2cWRaFqtX2RLwd7EtuOhsFgrpLiAq/TQ==
X-Received: by 2002:a1c:7c02:: with SMTP id x2mr717105wmc.64.1605036681441;
 Tue, 10 Nov 2020 11:31:21 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:20 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 04/30] drm/radeon/si: Remove set but unused variable
 'mc_shared_chmap'
Date: Tue, 10 Nov 2020 19:30:46 +0000
Message-Id: <20201110193112.988999-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9zaS5jOiBJbiBmdW5jdGlvbiDigJhzaV9ncHVfaW5pdOKAmToKIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vc2kuYzozMDkwOjY6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmG1j
X3NoYXJlZF9jaG1hcOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlh
YmxlXQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
PgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmMgfCA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9zaS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5jCmlu
ZGV4IGMyN2FmODk3ODVmMzQuLjQ1MDc2YzI3ZDdkZWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vc2kuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmMKQEAgLTMw
ODgsNyArMzA4OCw3IEBAIHN0YXRpYyB2b2lkIHNpX3NldHVwX3JiKHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2LAogc3RhdGljIHZvaWQgc2lfZ3B1X2luaXQoc3RydWN0IHJhZGVvbl9kZXZpY2Ug
KnJkZXYpCiB7CiAJdTMyIGdiX2FkZHJfY29uZmlnID0gMDsKLQl1MzIgbWNfc2hhcmVkX2NobWFw
LCBtY19hcmJfcmFtY2ZnOworCXUzMiBtY19hcmJfcmFtY2ZnOwogCXUzMiBzeF9kZWJ1Z18xOwog
CXUzMiBoZHBfaG9zdF9wYXRoX2NudGw7CiAJdTMyIHRtcDsKQEAgLTMyMDAsNyArMzIwMCw3IEBA
IHN0YXRpYyB2b2lkIHNpX2dwdV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogCiAJ
V1JFRzMyKEJJRl9GQl9FTiwgRkJfUkVBRF9FTiB8IEZCX1dSSVRFX0VOKTsKIAotCW1jX3NoYXJl
ZF9jaG1hcCA9IFJSRUczMihNQ19TSEFSRURfQ0hNQVApOworCVJSRUczMihNQ19TSEFSRURfQ0hN
QVApOwogCW1jX2FyYl9yYW1jZmcgPSBSUkVHMzIoTUNfQVJCX1JBTUNGRyk7CiAKIAlyZGV2LT5j
b25maWcuc2kubnVtX3RpbGVfcGlwZXMgPSByZGV2LT5jb25maWcuc2kubWF4X3RpbGVfcGlwZXM7
Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
