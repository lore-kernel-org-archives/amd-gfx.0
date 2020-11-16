Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72124C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C2F2225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3XpEpiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C2F2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4E66EA36;
	Mon, 16 Nov 2020 19:18:19 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F226E09F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:39 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id w24so38417wmi.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pyNxvxME2tG4MioZh0DLPpucvuaAdYEDiX4yy0UM7tE=;
 b=U3XpEpiWRsz0j+hMtLDZ8ijrHq2pxzt4Q63ge8BICYDILPrM0Uk4Znt6t3gnNNK6TA
 NlOKoWX3AV2dY6ZopWymRVjS6pKydRf3Qy9yyqC+dsxNtmX1UWDNjK6g1ijj8+MSV1PS
 diXcNe5FtP7YT1fRvskacyGs+kp2Rj2sSYX2lkHzUuwA+ZHhRI4Cll4N/5sRzHkFYVaq
 MkX1VQC13yUvBzlVxq3Hmv3pczoGHnxuBNInJfWzFE11iZ7h0ZMcoMLObo7M9IgVC4/R
 k6amszu3ErtAEjGk8HeP0Ws64DknQnHPnko2q4YWihbQ/WiOE45rttjDJudtgCmsouyQ
 M+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pyNxvxME2tG4MioZh0DLPpucvuaAdYEDiX4yy0UM7tE=;
 b=dhr8Dp2nxJw5gRW5YPw4gVFoYnPtb7YTa8D6c03L0kiExj264NvGqeQAW/FNniVA9Q
 5UmJUDrmGyg0FDxLrQ9cAgi7HVU7A1X3KXJ24O1Fj90QQ6IeaDtnIkm2Kouj3O4jHuK1
 6iV3iKBPIlXuRt7pvlvmV9kDOSjibOEQSIGBxzUUsiukFotcRZiK63eBCDD79tF2QuMF
 0cpYaO0Hd8QrhYYRufMDMdqgK4nyjb97j1UYIofZr0apMxr096Lx3SuFWML08vjDeBqJ
 Ty3/vkvmS0IbWVHG4eHIGEu6DEatt4bFt1Z5XAvCQomQUEWohI5drDioC6aRKHyuHX/J
 wA4Q==
X-Gm-Message-State: AOAM533o36mYxqqNS3Vmr9ccPjy15FfKSKGmjZoxBZtz1cvFEoW0f7Lo
 9jZHoJH3pbiBUoVyYEChyIOLpg==
X-Google-Smtp-Source: ABdhPJxjNzoVEL+7L/X1+qeuAPEwh/Hw3rRmVVjqZSe7TGSI246nAKkLp8ED984/eStmZR1+Gdt8Lg==
X-Received: by 2002:a1c:b0c4:: with SMTP id
 z187mr16321450wme.113.1605548258220; 
 Mon, 16 Nov 2020 09:37:38 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:37 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 24/43] drm/radeon/r600: Move 'evergreen_rlc_resume()'s
 prototype to shared header
Date: Mon, 16 Nov 2020 17:36:41 +0000
Message-Id: <20201116173700.1830487-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYzo0MzgwOjU6IHdhcm5pbmc6IG5vIHByZXZpb3Vz
IHByb3RvdHlwZSBmb3Ig4oCYZXZlcmdyZWVuX3JsY19yZXN1bWXigJkgWy1XbWlzc2luZy1wcm90
b3R5cGVzXQogNDM4MCB8IGludCBldmVyZ3JlZW5fcmxjX3Jlc3VtZShzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldikKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn4KCkNjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6
IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYt
Ynk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9ldmVyZ3JlZW4uaCB8IDEgKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwLmMg
ICAgICB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uaCBiL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuLmgKaW5kZXggZWI0NmFjNzc3Njk1MS4uZjhk
NzcyZTYxMmE0OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4u
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbi5oCkBAIC00OCw1ICs0OCw2
IEBAIHZvaWQgZXZlcmdyZWVuX2dwdV9wY2lfY29uZmlnX3Jlc2V0KHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2KTsKIHUzMiBldmVyZ3JlZW5fZ2V0X251bWJlcl9vZl9kcmFtX2NoYW5uZWxzKHN0
cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIHZvaWQgZXZlcmdyZWVuX3ByaW50X2dwdV9zdGF0
dXNfcmVncyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiB1MzIgZXZlcmdyZWVuX2dwdV9j
aGVja19zb2Z0X3Jlc2V0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKK2ludCBldmVyZ3Jl
ZW5fcmxjX3Jlc3VtZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiAKICNlbmRpZgkJCQkv
KiBfX1JBREVPTl9FVkVSR1JFRU5fSF9fICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3I2MDAuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5jCmluZGV4IDk0ZTg4
MTVlNTA2N2QuLmI0NGUwYzYwN2IxYjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcjYwMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5jCkBAIC0zOSw2ICsz
OSw3IEBACiAKICNpbmNsdWRlICJhdG9tLmgiCiAjaW5jbHVkZSAiYXZpdm9kLmgiCisjaW5jbHVk
ZSAiZXZlcmdyZWVuLmgiCiAjaW5jbHVkZSAicjYwMC5oIgogI2luY2x1ZGUgInI2MDBkLmgiCiAj
aW5jbHVkZSAicnY3NzAuaCIKQEAgLTExMyw3ICsxMTQsNiBAQCBzdGF0aWMgdm9pZCByNjAwX2dw
dV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIHZvaWQgcjYwMF9maW5pKHN0cnVj
dCByYWRlb25fZGV2aWNlICpyZGV2KTsKIHZvaWQgcjYwMF9pcnFfZGlzYWJsZShzdHJ1Y3QgcmFk
ZW9uX2RldmljZSAqcmRldik7CiBzdGF0aWMgdm9pZCByNjAwX3BjaWVfZ2VuMl9lbmFibGUoc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwotZXh0ZXJuIGludCBldmVyZ3JlZW5fcmxjX3Jlc3Vt
ZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiAKIC8qCiAgKiBJbmRpcmVjdCByZWdpc3Rl
cnMgYWNjZXNzb3IKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
