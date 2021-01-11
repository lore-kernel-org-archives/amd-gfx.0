Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C98C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F3E22A83
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F3E22A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576B46E098;
	Mon, 11 Jan 2021 19:54:44 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD9A89DEC
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:40 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id m5so903803wrx.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gYAUvWYhLSY+y3POXwzPmF8UOJaTJ9mXjk2V2XniJm0=;
 b=AvjJHTIgB9FSFfzuhd2/xZddg8dZhEgKX/CNFOHHQ7b9yZsOPZNXR49nJuu2Y3EZf6
 nUy0bQnAI1boEBFBEoLLzNZNtykXnh6Nep+/FljRN06bxsfy9XrWoASbuW4gRpXFmeHq
 uw87V0KY+HzEFkFreB0xHPov/rSoFGqymGVJCJKOd5Xj7nLXfnnwmP4Rxeev8YCd/XzN
 eoNsw5lmZJrz9wKkkiTSm9obVvLZuTZuyD09jCcXNJMvvm/FUZRXFn8GSmGRi1njKqMW
 gFM8rEm3OsjmjtxdT9TdiLV56tLbw67SeScy7kFp2Og0E2rZzMC32vhYy9IZbztGz2XX
 y1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gYAUvWYhLSY+y3POXwzPmF8UOJaTJ9mXjk2V2XniJm0=;
 b=VI7VZHPqZo+xXInHxIQVcaCMr992aU5woO32+LVvcwCF4OD/hkhyzXqNyCHl1veU3Y
 cj07Sbe4REl9OtRmaRHRuQY8utPlmn+6CnIUr7WDT03/28GoU4rE38dpUYLInCzq5Ean
 IWyd9T8wtpAxgrezpHihApuUo+QY7nV3u7B91tQJU7mVldsNtlm6h/4eCqODrTYU120A
 VZkl9e8QUH6umK35cHX12NyKnyIVUMonjYwZA6Va74Vf9TIKR5pN9kdvvVbkhVa+xV7R
 dKpvOkP5P1nGNRC9D1lM0aCYtq3mFnOncBUmz7IlUBK4WQgGMj71VO0B2Z+xF7XRBJ59
 zVGQ==
X-Gm-Message-State: AOAM533lNoxypAan2EBah59BCW20Ja5zUzGaFkH7NfkmKWAdA14op6L5
 0QHz2fDRzkdu0A81T/U/Hy9OuQ==
X-Google-Smtp-Source: ABdhPJx4yFMdBRMlt7UNZ0+TK6A3eCANJ4OL+8R9h9mxZjmvYAxD+wT/31ZR77V8KnbfZmyjH+EZVQ==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr613515wrs.284.1610392779552;
 Mon, 11 Jan 2021 11:19:39 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:38 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/40] drm/amd/display/dc/irq/irq_service: Make local function
 static
Date: Mon, 11 Jan 2021 19:18:53 +0000
Message-Id: <20210111191926.3688443-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Jan 2021 19:54:43 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9pcnEvaXJxX3NlcnZpY2UuYzo4Mjoz
MTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhmaW5kX2lycV9zb3VyY2Vf
aW5mb+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCgpDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5
LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVk
QGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogTWF1cm8g
Um9zc2kgPGlzc29yLm9ydWFtQGdtYWlsLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5jCmluZGV4IDZiZjI3YmRlODcyNDAuLjVmMjQ1YmRl
NTRmZjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pcnEvaXJx
X3NlcnZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaXJxL2lycV9z
ZXJ2aWNlLmMKQEAgLTc5LDcgKzc5LDcgQEAgdm9pZCBkYWxfaXJxX3NlcnZpY2VfZGVzdHJveShz
dHJ1Y3QgaXJxX3NlcnZpY2UgKippcnFfc2VydmljZSkKIAkqaXJxX3NlcnZpY2UgPSBOVUxMOwog
fQogCi1jb25zdCBzdHJ1Y3QgaXJxX3NvdXJjZV9pbmZvICpmaW5kX2lycV9zb3VyY2VfaW5mbygK
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgaXJxX3NvdXJjZV9pbmZvICpmaW5kX2lycV9zb3VyY2VfaW5m
bygKIAlzdHJ1Y3QgaXJxX3NlcnZpY2UgKmlycV9zZXJ2aWNlLAogCWVudW0gZGNfaXJxX3NvdXJj
ZSBzb3VyY2UpCiB7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
