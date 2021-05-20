Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608EAC43600
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2714461184
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2714461184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9859A6F45D;
	Thu, 20 May 2021 12:49:16 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93FF6F420
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:12 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id n2so17468288wrm.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pO5grwrsv4uMOhYf2ygGyZPPYt+9rmeszEZndYds2GE=;
 b=CT/EoTRfYVBMyN8Wzm8oIU6O8z4y0prNiAf2aGwl18sXL6nhs3Qa7lndrhUsKNpDNh
 lCPNbGFn1y4DmrNr28zOZrehZnATaWcMml5I3ocbHsxIkMeGsS2ZekSj2cVrN+8vUzOw
 sSuN90me/VUxRRa8I4hU3JwltTu8JZT90S3shAULwt0mBG7O/wb97drPL8NKXIltu6i1
 xMypzDARp+sAyjtdEKK0npV7sP1RPbELatr9TgObyh9m8es+7Kw3VdkkU6K40xJaPQ+1
 xWb2/INEkfii3jkvbu7kRkEciU+eiCKAPTU1Y2Tw9wyaA2n+N8KCQ/gjqjtc8BKAZsBm
 I3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pO5grwrsv4uMOhYf2ygGyZPPYt+9rmeszEZndYds2GE=;
 b=FqmjFjOkS6ku0dv7iHyFXer6NaibxUcTms+KpI2zLTexdATXdixhGl0nWEZ0k0LNR7
 gTxKmye+qzTkcj84uyLZ7LHE8iPg8pW6GixDKDqi5XSWtkKhlNaDa7kfFdNmNBzgEj17
 XQ/+gyz/3cMOQCvaebD1rI/uWSD3SJBtfm18boFnG2XCl4cLmaR0d5PlUcqJdCkjy/2B
 evfmasltgw3tUx4yX0tnwaVib/G8WjIs4cO/E/1GUYJSlFcOcTQykjVEFHywOFSEUU94
 gXjEyRFzlqYo95HRFgxzMm9TGAmWbkpnjXD2qrdfHQc+agmiSHaFvil/+jK53lnjFVOW
 5tlA==
X-Gm-Message-State: AOAM5324cUJegtN2SN9psCkQ6BgufWxwjA0VoYx658xjdfsdCcMf7ITe
 lz+7DApPEOk7XFC3df+xcLSc0Q==
X-Google-Smtp-Source: ABdhPJyVGLD3pIUwDllaOAyh0KECeEj9Z5MxF/PEDD5PRs/ZcnbIVDDHh9VW+4L3f/5KCoQgYjwlxg==
X-Received: by 2002:adf:e0c6:: with SMTP id m6mr4105302wri.66.1621512191654;
 Thu, 20 May 2021 05:03:11 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:11 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 19/38] drm/radeon/cik: Fix incorrectly named function
 'cik_irq_suspend()'
Date: Thu, 20 May 2021 13:02:29 +0100
Message-Id: <20210520120248.3464013-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9jaWsuYzo3NDUwOiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBl
IGZvciBjaWtfaXJxX2Rpc2FibGUoKS4gUHJvdG90eXBlIHdhcyBmb3IgY2lrX2lycV9zdXNwZW5k
KCkgaW5zdGVhZAoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
Q2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZm
d2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdA
bGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYwpp
bmRleCA0MmE4YWZhODM5Y2JiLi43M2VhNTE4OWRmYjFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL2Npay5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMKQEAg
LTc0MzksNyArNzQzOSw3IEBAIHN0YXRpYyB2b2lkIGNpa19pcnFfZGlzYWJsZShzdHJ1Y3QgcmFk
ZW9uX2RldmljZSAqcmRldikKIH0KIAogLyoqCi0gKiBjaWtfaXJxX2Rpc2FibGUgLSBkaXNhYmxl
IGludGVycnVwdHMgZm9yIHN1c3BlbmQKKyAqIGNpa19pcnFfc3VzcGVuZCAtIGRpc2FibGUgaW50
ZXJydXB0cyBmb3Igc3VzcGVuZAogICoKICAqIEByZGV2OiByYWRlb25fZGV2aWNlIHBvaW50ZXIK
ICAqCi0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
