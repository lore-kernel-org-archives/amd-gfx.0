Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376A2C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AE120659
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzYnXdFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AE120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E1D6E0C1;
	Wed, 11 Nov 2020 18:45:16 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B9088DE5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 18:35:54 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id b8so3528538wrn.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 10:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5TTguyaQuVrd+USo/F+rMhw06NLnXmuljJDk3k933AM=;
 b=uzYnXdFFpGFm/O/yOG8ZnLUAwCXGekg2acMZNKqILkDN5/NpAh6cm4f6K2dqKdkJSn
 C7NRB6cZlnNl8hSwWeBmI36L4kdkOL3H4CmV87xjGW/FpXfExfTEu8a45Q4Y/V243SnO
 qGFS0il8RaTQOfwdfzUBnRXSabA3COE4c7YFG+yDuJ9WBCF9rBWj8yrEzOrUgjnQapnL
 D/WJ/RQQOsJ6t8yAtJBi2DNUPyxK5rCNaUWcRyoqXBo21obVwGHtq5ZrCENObNqe0lN1
 3qjzGG56Gfes7ebdpjzYG1smr2Tp3b5vwvffnIt63DYfsfYCIuVGakNbesczuHou+RCn
 /xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5TTguyaQuVrd+USo/F+rMhw06NLnXmuljJDk3k933AM=;
 b=FmUlw5xZQ0Jlp7uZOOVYwmXAhneUMYZK+elRZCSQOVeXdtdArlc5B54pSYGWZ815Sj
 7sjV7NP3nPZLJbdLcvlVbNZlazZOzGjz7pqSQrP0vYEXL/NKvTtfLDTHRWIhVw7+iWIv
 NbtSQS+zRhs993aeOgikW79iiRTZAf09qtLToqlCfdiW7OXRV04Cr+BK66VICpX9Z1P/
 UKp3+xVoUg46grxJKyrjLQ3yIutA9dQMBGulNKXsPDYMHUILdIzAMYgZghNuwuF9/O69
 QqVYxHgUWSQzZvTid/dkw3tlsGnh8jg/+KbqiRgoSadDVC3tPLuWFzEq4P36HVOlWxdI
 FbAg==
X-Gm-Message-State: AOAM531xlZv1HWBA3iJZPOJPLqhF/hgLE8tjetQVgnm15NH5qK/pE+TY
 fnbNl9Ze0Zuj9RTcfxAO87F5Xw==
X-Google-Smtp-Source: ABdhPJz1U7jH0AHxumlfztYxCgXSd62vSFI+BQvD1c3fi+W9yP8psRSOQGLIgiF1Ay2M34GtNjD27Q==
X-Received: by 2002:a5d:6cc5:: with SMTP id c5mr31747759wrc.301.1605119752670; 
 Wed, 11 Nov 2020 10:35:52 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 10:35:51 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 03/19] drm/radeon/ni_dma: Move
 'cayman_gpu_check_soft_reset()'s prototype to shared header
Date: Wed, 11 Nov 2020 18:35:29 +0000
Message-Id: <20201111183545.1756994-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111183545.1756994-1-lee.jones@linaro.org>
References: <20201111183545.1756994-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Nov 2020 18:45:15 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9uaS5jOjE3MzM6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90
eXBlIGZvciDigJhjYXltYW5fZ3B1X2NoZWNrX3NvZnRfcmVzZXTigJkgWy1XbWlzc2luZy1wcm90
b3R5cGVzXQogMTczMyB8IHUzMiBjYXltYW5fZ3B1X2NoZWNrX3NvZnRfcmVzZXQoc3RydWN0IHJh
ZGVvbl9kZXZpY2UgKnJkZXYpCiB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVk
QGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pLmggICAgIHwgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL25pX2RtYS5jIHwgMyArLS0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vbmkuaCBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vbmkuaAppbmRleCBkNjNiZTFjODhjMGYxLi45YTVmMzFh
MDVlNjhmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pLmgKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9uaS5oCkBAIC0zNCw1ICszNCw2IEBAIHZvaWQgY2F5bWFuX2Nw
X2ludF9jbnRsX3NldHVwKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LAogCQkJICAgICAgaW50
IHJpbmcsIHUzMiBjcF9pbnRfY250bCk7CiB2b2lkIGNheW1hbl92bV9kZWNvZGVfZmF1bHQoc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsCiAJCQkgICAgdTMyIHN0YXR1cywgdTMyIGFkZHIpOwor
dTMyIGNheW1hbl9ncHVfY2hlY2tfc29mdF9yZXNldChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRl
dik7CiAKICNlbmRpZgkJCQkvKiBfX05JX0hfXyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9uaV9kbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vbmlfZG1hLmMKaW5k
ZXggYzU2MTM2ODQ4MzYwZS4uYmQ1MTVhZDRmZTRjYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9uaV9kbWEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pX2RtYS5j
CkBAIC0yNSwxMCArMjUsOSBAQAogI2luY2x1ZGUgInJhZGVvbi5oIgogI2luY2x1ZGUgInJhZGVv
bl9hc2ljLmgiCiAjaW5jbHVkZSAicmFkZW9uX3RyYWNlLmgiCisjaW5jbHVkZSAibmkuaCIKICNp
bmNsdWRlICJuaWQuaCIKIAotdTMyIGNheW1hbl9ncHVfY2hlY2tfc29mdF9yZXNldChzdHJ1Y3Qg
cmFkZW9uX2RldmljZSAqcmRldik7Ci0KIC8qCiAgKiBETUEKICAqIFN0YXJ0aW5nIHdpdGggUjYw
MCwgdGhlIEdQVSBoYXMgYW4gYXN5bmNocm9ub3VzCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
