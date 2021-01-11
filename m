Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE643C433E9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FE022B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FE022B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083656E0EF;
	Mon, 11 Jan 2021 19:54:48 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0F589E9E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:20:05 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id q75so297216wme.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VihTPCTNoey/JKY1Z4Geihy/+CpWTn44EgwyKVU/So4=;
 b=zm4hqUDYRKWhOH93S0m6OzMUm2UG0kbFx1gdPzIUP19LFjdloPHHu0sy2fhop86XTG
 lMCU33kWxfEz2L2MA9+m4H0OjD6rNFqjxqyf+fTeirC+7Y3E2TazSeF3rksQrfnfUJsd
 N87z5kKXvI2t/VK2m80dg7kK4749/ktGuBUBgpxi65KVqgbhjv1q9D2USLW6HEUY56+h
 zr5Md/jQvtZvIJZlamRiRiCxmqZIVxD5XQT/gbHuAi4gvU9+NeyMewqq1vPRXEODaPDt
 yFdthHeJA9zUM2cvKd25q75bYxtpHj8wkDRxbn6o1JPPDZtZmxaiqLbGNJjvJ7SCcGcP
 r44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VihTPCTNoey/JKY1Z4Geihy/+CpWTn44EgwyKVU/So4=;
 b=KZC1a8XhnWjJi33J9BqHinIipDBu74SzwR8Z52D2fNpMhH7Q53aqKlTGCmkb5ltlDg
 qgyD82uemPqVB8jkHS71AfYAkxX0SmxWegM1t2ogLCueGCZRQUamtAcu9M0pKcLIIWcE
 cfmg/mhOQkbgho3M2qeDwNloKFKiwyczTMjmDgx4Atg5DBcazHnzdtDQbVIN7+Cch6Th
 5rigIjHbKn4pRdZiYBAHDESwCv7aoWnjWFm7X1JifWG6XO4Lowpsn7smIerbvTwBJWVO
 cUyIWUGZzLinuq5ZXPYDtH8PysOFomE9OKTdu9AWkM3F4DXOztLftH4Y1NXOhEYo3Qcw
 Qtzg==
X-Gm-Message-State: AOAM5306ORFLVyxkMG0z2ShkGPzsSsqFdWkLOwSbE91OLS9utGlyGF0g
 T0Sbv1s4SQwq7FXOVPMB9d9AtQ==
X-Google-Smtp-Source: ABdhPJyuY1crJf1/MyIUDIjKfK4vqay/fxwN7aDKwMYf344cjO3m1/QVr+kzefbcgvBB12e1iwilCg==
X-Received: by 2002:a1c:bd56:: with SMTP id n83mr291291wmf.72.1610392802992;
 Mon, 11 Jan 2021 11:20:02 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:20:02 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 25/40] drm/amd/display/dc/dce120/dce120_timing_generator:
 Remove unused function 'dce120_timing_generator_get_position'
Date: Mon, 11 Jan 2021 19:19:11 +0000
Message-Id: <20210111191926.3688443-26-lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3RpbWluZ19n
ZW5lcmF0b3IuYzo2MDI6MTM6IHdhcm5pbmc6IOKAmGRjZTEyMF90aW1pbmdfZ2VuZXJhdG9yX2dl
dF9wb3NpdGlvbuKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dCgpD
YzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1
bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpD
YzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFu
aWVsQGZmd2xsLmNoPgpDYzogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0t
LQogLi4uL2RjL2RjZTEyMC9kY2UxMjBfdGltaW5nX2dlbmVyYXRvci5jICAgICAgIHwgNDMgLS0t
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3RpbWlu
Z19nZW5lcmF0b3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMjAvZGNl
MTIwX3RpbWluZ19nZW5lcmF0b3IuYwppbmRleCBkMDJlY2I5ODNjOWNkLi5iNTdjNDY2MTI0ZTc2
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTIwL2RjZTEy
MF90aW1pbmdfZ2VuZXJhdG9yLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjZTEyMC9kY2UxMjBfdGltaW5nX2dlbmVyYXRvci5jCkBAIC01ODksNDkgKzU4OSw2IEBAIHN0
YXRpYyB2b2lkIGRjZTEyMF90aW1pbmdfZ2VuZXJhdG9yX3NldF9kcnIoCiAJfQogfQogCi0vKgot
ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqCi0gKiAgRnVuY3Rpb246IGRjZTEyMF90aW1pbmdfZ2VuZXJh
dG9yX2dldF9wb3NpdGlvbgotICoKLSAqICBAYnJpZWYKLSAqICAgICBSZXR1cm5zIENSVEMgdmVy
dGljYWwvaG9yaXpvbnRhbCBjb3VudGVycwotICoKLSAqICBAcGFyYW0gW291dF0gcG9zaXRpb24K
LSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKgotICovCi1zdGF0aWMgdm9pZCBkY2UxMjBfdGltaW5nX2dl
bmVyYXRvcl9nZXRfcG9zaXRpb24oc3RydWN0IHRpbWluZ19nZW5lcmF0b3IgKnRnLAotCXN0cnVj
dCBjcnRjX3Bvc2l0aW9uICpwb3NpdGlvbikKLXsKLQl1aW50MzJfdCB2YWx1ZTsKLQlzdHJ1Y3Qg
ZGNlMTEwX3RpbWluZ19nZW5lcmF0b3IgKnRnMTEwID0gRENFMTEwVEdfRlJPTV9URyh0Zyk7Ci0K
LQl2YWx1ZSA9IGRtX3JlYWRfcmVnX3NvYzE1KAotCQkJdGctPmN0eCwKLQkJCW1tQ1JUQzBfQ1JU
Q19TVEFUVVNfUE9TSVRJT04sCi0JCQl0ZzExMC0+b2Zmc2V0cy5jcnRjKTsKLQotCXBvc2l0aW9u
LT5ob3Jpem9udGFsX2NvdW50ID0gZ2V0X3JlZ19maWVsZF92YWx1ZSgKLQkJCXZhbHVlLAotCQkJ
Q1JUQzBfQ1JUQ19TVEFUVVNfUE9TSVRJT04sCi0JCQlDUlRDX0hPUlpfQ09VTlQpOwotCi0JcG9z
aXRpb24tPnZlcnRpY2FsX2NvdW50ID0gZ2V0X3JlZ19maWVsZF92YWx1ZSgKLQkJCXZhbHVlLAot
CQkJQ1JUQzBfQ1JUQ19TVEFUVVNfUE9TSVRJT04sCi0JCQlDUlRDX1ZFUlRfQ09VTlQpOwotCi0J
dmFsdWUgPSBkbV9yZWFkX3JlZ19zb2MxNSgKLQkJCXRnLT5jdHgsCi0JCQltbUNSVEMwX0NSVENf
Tk9NX1ZFUlRfUE9TSVRJT04sCi0JCQl0ZzExMC0+b2Zmc2V0cy5jcnRjKTsKLQotCXBvc2l0aW9u
LT5ub21pbmFsX3Zjb3VudCA9IGdldF9yZWdfZmllbGRfdmFsdWUoCi0JCQl2YWx1ZSwKLQkJCUNS
VEMwX0NSVENfTk9NX1ZFUlRfUE9TSVRJT04sCi0JCQlDUlRDX1ZFUlRfQ09VTlRfTk9NKTsKLX0K
LQotCiBzdGF0aWMgdm9pZCBkY2UxMjBfdGltaW5nX2dlbmVyYXRvcl9nZXRfY3J0Y19zY2Fub3V0
cG9zKAogCXN0cnVjdCB0aW1pbmdfZ2VuZXJhdG9yICp0ZywKIAl1aW50MzJfdCAqdl9ibGFua19z
dGFydCwKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
