Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA7CC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C6C23102
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C6C23102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE9E6E134;
	Wed, 13 Jan 2021 08:24:29 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5976689EA3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:07:58 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id g25so3132269wmh.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3c09B7R1bDDRXGkxc3zYuL5FdMguU7F3ASarhgkkjYk=;
 b=Ke29S0ckRABZRt5qaiIctSaJXdhgxyEOAbb+lrGjHH1heF05KLBmidxzRCinjxGbsl
 yn+acgZowbs+SW5i8xy0YiLb6/vzQHz1FI/FFNsPWlSA8mciP787U5U+rWyGhaPAPTE6
 W3Juay2xlCPWy4fQJdzS9QlgYba9pB5pLOJlc8Gc1cCokpty0a4RMuYjbAxzd97hpPbb
 w5UjdWee4uUdmxsy3ICv8xQFCrN9/9mVfpW8pqq38Lp6VYnmvx/eTyL6kdNRPiOad4mO
 NvbBx80+MSILnDc84d7iW0X1Shhj1GDMhSA5R11IISAKv2baeSscTtfgGU+6123gR2OX
 m56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3c09B7R1bDDRXGkxc3zYuL5FdMguU7F3ASarhgkkjYk=;
 b=YnOHT7jRakM+dtWLq2eAMaJ7lIg/NP4kVG34tS4Wy7ZbU3BrgSpEe5rgzyQjVcIlrl
 51clwoCyLlKiXdEXPiBF9SIc4V77NQfQGvwvEeLFmUM+V0sxMkRiqRmcuqB0MSZEDbB1
 bDCsvaEfpSWl6HX8UKdk/znltOruBCUOr8KBydgdb8/MBnQ5ek7rHLC/43Yb7YE1gjfg
 CnKYmanwy4iuG0VUhfH6S9JBAeb046ynSXdASiZGDpn5ZhsaIHyZoGTP5mfCfW1AXoX0
 gZHBP8aFAG2Scu4MrrcrXpgZArydQZaIkCnhezfgKPJFMlOLvp+EEkxrppOjpRpXtFAT
 +TNA==
X-Gm-Message-State: AOAM532um2+ItN5E4FrYbsGw1lZ0eonlGIeZ67PdaHuB49OTI0PlHC34
 Ae2N/r1xTwzuiXJRBZuJjZpJfg==
X-Google-Smtp-Source: ABdhPJzFZznC3mc+syBSkyi9EiTbDy+X0VVbtJPk+qXMX1WPaf2niMuM9Omp5aPWXqpVk0/5XmSQMA==
X-Received: by 2002:a05:600c:224b:: with SMTP id
 a11mr931054wmm.97.1610525276970; 
 Wed, 13 Jan 2021 00:07:56 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:07:56 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 01/30] drm/amd/display/dc/dc_helper: Include our own header,
 containing prototypes
Date: Wed, 13 Jan 2021 08:07:23 +0000
Message-Id: <20210113080752.1003793-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 13 Jan 2021 08:24:28 +0000
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
Cc: Noah Abradjian <noah.abradjian@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY19oZWxwZXIuYzoyOTk6MTA6IHdh
cm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZ2VuZXJpY19yZWdfZ2V04oCZIFst
V21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3Bs
YXkvZGMvZGNfaGVscGVyLmM6MzA3OjEwOiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUg
Zm9yIOKAmGdlbmVyaWNfcmVnX2dldDLigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY19oZWxwZXIuYzozMTc6MTA6IHdh
cm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZ2VuZXJpY19yZWdfZ2V0M+KAmSBb
LVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNw
bGF5L2RjL2RjX2hlbHBlci5jOjMyOToxMDogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBl
IGZvciDigJhnZW5lcmljX3JlZ19nZXQ04oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNfaGVscGVyLmM6MzQzOjEwOiB3
YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGdlbmVyaWNfcmVnX2dldDXigJkg
Wy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9kYy9kY19oZWxwZXIuYzozNTk6MTA6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlw
ZSBmb3Ig4oCYZ2VuZXJpY19yZWdfZ2V0NuKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjX2hlbHBlci5jOjM3NzoxMDog
d2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhnZW5lcmljX3JlZ19nZXQ34oCZ
IFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rp
c3BsYXkvZGMvZGNfaGVscGVyLmM6Mzk3OjEwOiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5
cGUgZm9yIOKAmGdlbmVyaWNfcmVnX2dldDjigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY19oZWxwZXIuYzo1MDM6Njog
d2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhnZW5lcmljX3dyaXRlX2luZGly
ZWN0X3JlZ+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2RjX2hlbHBlci5jOjUxMToxMDogd2FybmluZzogbm8gcHJldmlv
dXMgcHJvdG90eXBlIGZvciDigJhnZW5lcmljX3JlYWRfaW5kaXJlY3RfcmVn4oCZIFstV21pc3Np
bmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNfaGVscGVyLmM6NTI5OjEwOiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKA
mGdlbmVyaWNfaW5kaXJlY3RfcmVnX2dldOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjX2hlbHBlci5jOjU2MDoxMDog
d2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhnZW5lcmljX2luZGlyZWN0X3Jl
Z191cGRhdGVfZXjigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQoKQ2M6IEhhcnJ5IFdlbnRsYW5k
IDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+
CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8
YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6
IE5vYWggQWJyYWRqaWFuIDxub2FoLmFicmFkamlhbkBhbWQuY29tPgpDYzogUm9kcmlnbyBTaXF1
ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1i
eTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNfaGVscGVyLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19o
ZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19oZWxwZXIuYwppbmRl
eCA1N2VkYjI1ZmMzODEyLi5hNjEyYmE2ZGMzODk4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNfaGVscGVyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjX2hlbHBlci5jCkBAIC0zNCw2ICszNCw3IEBACiAKICNpbmNsdWRlICJkYy5o
IgogI2luY2x1ZGUgImRjX2RtdWJfc3J2LmgiCisjaW5jbHVkZSAicmVnX2hlbHBlci5oIgogCiBz
dGF0aWMgaW5saW5lIHZvaWQgc3VibWl0X2RtdWJfcmVhZF9tb2RpZnlfd3JpdGUoCiAJc3RydWN0
IGRjX3JlZ19oZWxwZXJfc3RhdGUgKm9mZmxvYWQsCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
