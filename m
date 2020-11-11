Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344CEC56201
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AB6206FB
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMr7iJVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AB6206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16C7F6E0E6;
	Wed, 11 Nov 2020 18:45:18 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2286E0C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 18:36:15 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a3so3235489wmb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 10:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tediDzLC047hOPrU32KTbEuOLPsPka6LUr15f9wO3Gk=;
 b=mMr7iJVO6/1xsFbpADaI0KX7kFyobKLggc8W56w7L3MMk2GfW4ljqeSfLeXhfyLEyj
 XjcdV/fGWT4uj/ehcXbaUUedrwdLzRksO/j39a1M/QzL8AVDA8lY6o8ZYh2yf6BNOu3e
 DokwqqpsUUt6tr8S1Kux1Dxrv2cbPTLIvSVIdfRuMbKgQ7Ptr3ZS/s4jeJ8fljJD6sYb
 v9NXlilvlnlZ68adPseWU4ZZM6H2kZQV/8utnv1rtWscJNiwN2k51ux+q5NmB5aAlXKc
 ZmV8EL5mCTwd7VfZihKfsERIoxLWBGqCUVn8V9w6s6As362FXbEMbtxmVL7KIepHs4eL
 rpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tediDzLC047hOPrU32KTbEuOLPsPka6LUr15f9wO3Gk=;
 b=kwQ0Hk+yKyAR0iaM+gXADM9+Wi0sPIq50ugppAQJySOfJ5fwEGRFreESMR2CDWct0B
 0o1DchUelSqM4jHxuNulZxaJo1iohYjEyHPvjs6b6hQFrbx4MDHnKJj//5MjKeq0r7bx
 ztyAV+INsFcD5mzVorABuuMvtEOWSA5b4sXEYFn8PoJPDyaco2VyT7zXtUK5A1bSORO9
 +Gohutl2jfjpjGs5/nOximwcS5uXfyZGtWFy5N3ZTvJezibbcU1b1XVQGZzeUskCdLHS
 7STnuy9R/GiCd6oRpt7EHs+cPbR+NwcZItsCs/R5mF/7eC+aKh8e5vRbh7yboLpuN8u/
 kwVw==
X-Gm-Message-State: AOAM531qsxY/rhyqeqZOtcDANgvpBFSiFUnT2WhUdUKKMyMAJkx4dIef
 psJUQbv1Lf9y7z8RhcvMq6LN9w==
X-Google-Smtp-Source: ABdhPJyn7zxm7zhP+Z5GtcjvgBa5Dzioyj+ILoping9J7cC5ythGDHHgVffVn5idPPNFm6Tk3Kb7kA==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr5981271wmg.68.1605119774423; 
 Wed, 11 Nov 2020 10:36:14 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 10:36:13 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 18/19] drm/radeon/cik: Move 'vce_v2_0_enable_mgcg()'s
 prototype to shared header
Date: Wed, 11 Nov 2020 18:35:44 +0000
Message-Id: <20201111183545.1756994-19-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi92Y2VfdjJfMC5jOjExMTo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBw
cm90b3R5cGUgZm9yIOKAmHZjZV92Ml8wX2VuYWJsZV9tZ2Nn4oCZIFstV21pc3NpbmctcHJvdG90
eXBlc10KIDExMSB8IHZvaWQgdmNlX3YyXzBfZW5hYmxlX21nY2coc3RydWN0IHJhZGVvbl9kZXZp
Y2UgKnJkZXYsIGJvb2wgZW5hYmxlKQogfCBefn5+fn5+fn5+fn5+fn5+fn5+fgoKQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxp
bnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vt
d2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1tZWRp
YUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpTaWdu
ZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vY2lrLmMgICAgICB8IDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
dmNlLmggICAgICB8IDEgKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi92Y2VfdjJfMC5jIHwgMSAr
CiAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL2Npay5jCmluZGV4IDQ1MjBlYzRjN2IyZTIuLmFlMmE1MDdkMTNiYjcgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9jaWsuYwpAQCAtNDEsNiArNDEsNyBAQAogI2luY2x1ZGUgInJhZGVvbl9hdWRpby5oIgogI2lu
Y2x1ZGUgInJhZGVvbl91Y29kZS5oIgogI2luY2x1ZGUgInNpLmgiCisjaW5jbHVkZSAidmNlLmgi
CiAKICNkZWZpbmUgU0hfTUVNX0NPTkZJR19HRlhfREVGQVVMVCBcCiAJQUxJR05NRU5UX01PREUo
U0hfTUVNX0FMSUdOTUVOVF9NT0RFX1VOQUxJR05FRCkKQEAgLTEyOSw3ICsxMzAsNiBAQCBNT0RV
TEVfRklSTVdBUkUoInJhZGVvbi9tdWxsaW5zX3JsYy5iaW4iKTsKIE1PRFVMRV9GSVJNV0FSRSgi
cmFkZW9uL211bGxpbnNfc2RtYS5iaW4iKTsKIAogc3RhdGljIHUzMiBjaWtfZ2V0X2N1X2FjdGl2
ZV9iaXRtYXAoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIHUzMiBzZSwgdTMyIHNoKTsKLWV4
dGVybiB2b2lkIHZjZV92Ml8wX2VuYWJsZV9tZ2NnKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2
LCBib29sIGVuYWJsZSk7CiBzdGF0aWMgdm9pZCBjaWtfcmxjX3N0b3Aoc3RydWN0IHJhZGVvbl9k
ZXZpY2UgKnJkZXYpOwogc3RhdGljIHZvaWQgY2lrX3BjaWVfZ2VuM19lbmFibGUoc3RydWN0IHJh
ZGVvbl9kZXZpY2UgKnJkZXYpOwogc3RhdGljIHZvaWQgY2lrX3Byb2dyYW1fYXNwbShzdHJ1Y3Qg
cmFkZW9uX2RldmljZSAqcmRldik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3ZjZS5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi92Y2UuaAppbmRleCAxZWI0ZjU3MTUyMDJl
Li5jY2M5YzAwZjBkMDJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3ZjZS5o
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNlLmgKQEAgLTMwLDUgKzMwLDYgQEAKIHN0
cnVjdCByYWRlb25fZGV2aWNlOwogCiB2b2lkIHZjZV92MV8wX2VuYWJsZV9tZ2NnKHN0cnVjdCBy
YWRlb25fZGV2aWNlICpyZGV2LCBib29sIGVuYWJsZSk7Cit2b2lkIHZjZV92Ml8wX2VuYWJsZV9t
Z2NnKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBib29sIGVuYWJsZSk7CiAKICNlbmRpZiAg
ICAgICAgICAgICAgICAgICAgICAgICAvKiBfX1ZDRV9IX18gKi8KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9yYWRlb24vdmNlX3YyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNl
X3YyXzAuYwppbmRleCBkNmZkZTM2NTllNjVmLi4xNjNjOWJmYzAzZGE4IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3ZjZV92Ml8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi92Y2VfdjJfMC5jCkBAIC0zMCw2ICszMCw3IEBACiAjaW5jbHVkZSAicmFkZW9uLmgiCiAj
aW5jbHVkZSAicmFkZW9uX2FzaWMuaCIKICNpbmNsdWRlICJjaWtkLmgiCisjaW5jbHVkZSAidmNl
LmgiCiAKICNkZWZpbmUgVkNFX1YyXzBfRldfU0laRQkoMjU2ICogMTAyNCkKICNkZWZpbmUgVkNF
X1YyXzBfU1RBQ0tfU0laRQkoNjQgKiAxMDI0KQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
