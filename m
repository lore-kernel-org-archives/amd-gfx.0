Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC98C83013
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162B120872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GyUSflYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162B120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0C16E96E;
	Wed, 25 Nov 2020 08:23:02 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED03D6E58E
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:48 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id s8so23510564wrw.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZfvfRQ7PcXeWjD8kLGjroSyeWiIdkNR2GVd+kakULXA=;
 b=GyUSflYAhp72ymYdK/TLzXTC6jnA3PL8lz6LGThanbH/oCVxl6fYwFpyukGz69I60t
 DezilZrVxmnNrP9s53T07U8j1EadxyiUhAUlmdVbaHS1roFKfuYZvXrTgtBUdcbcMUgB
 6OJnw+uSvL/4ILJOe8BZfP/YE/UnULd86LklD5mgfYSI5ngdwFDBE28hJwm0ClZJC71o
 xpc00paWjoWJ4v/4dfrZpXnfHsrko2HQFsaV84ZIOx8CMMvauYY4PrQYZww9jyfQfZVv
 qCEwhcqAARpGqb1kLIJoNDW2udIUS/DiqrH4EV/xt/8Sn0f3d2s2igUUP3ofNYBfv0CY
 B1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZfvfRQ7PcXeWjD8kLGjroSyeWiIdkNR2GVd+kakULXA=;
 b=MicMQkPVC5+vjWAQ7bPLwnF5+FRlK8ylrp7p4zIkuzcMpbEF6tQaBtwvgysCCU6nGA
 i6/+4zpIRIY7zn2ZIXVSLVsLqII1Q587bG3EWmSAwg9sYPxqnC9Xiu5wnL1zPAgFHy3j
 QXbUB3GUXqiPhCHRMRw9wq7GFr3BUrPVjQhh4FvNmneBlc++TE6WWIh82DIbNqVxIh7G
 nAppsrspSQhLX6mrD/U7yH0cQxkgB1lgzIwHyd0TnE0dEz61d7DsyNuNIzG7DOQwHVMF
 ym9kd0lmG2QZmDIg7gu+PSuHWXMcB4dkEQmJvW8OmuGwEA74o+eVT7YXxEYuIiA8ZLr9
 SVGg==
X-Gm-Message-State: AOAM532xLqezoI5RDHA1HenUUrzGApKhyTzg4eqYFUpmGCxAO+YGY8Ca
 Poa3podgFXIMYVmzWOgRdX94KH6lDovxLbHm
X-Google-Smtp-Source: ABdhPJyJjV23yZdohN2gtkIsTOcuofWR2WSH8duGcXFhvLfLZcGvGem4By7WDfHpInOfxrtBJiKFMg==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr124603wrr.64.1606247087673;
 Tue, 24 Nov 2020 11:44:47 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:47 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 39/40] drm/amd/pm/powerplay/smumgr/fiji_smumgr: Remove unused
 variable 'result'
Date: Tue, 24 Nov 2020 19:38:23 +0000
Message-Id: <20201124193824.1118741-40-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5j
OiBJbiBmdW5jdGlvbiDigJhmaWppX3BvcHVsYXRlX3NtY19ib290X2xldmVs4oCZOgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5j
OjE2MDM6Njogd2FybmluZzogdmFyaWFibGUg4oCYcmVzdWx04oCZIHNldCBidXQgbm90IHVzZWQg
Wy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1k
LmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
PgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KLS0tCiAuLi4vZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1n
ci5jICAgfCAxMyArKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93
ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dl
cnBsYXkvc211bWdyL2Zpamlfc211bWdyLmMKaW5kZXggZmVmOWQzOTA2ZmNjZC4uZmVhMDA4Y2Mx
ZjI1NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211bWdy
L2Zpamlfc211bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211
bWdyL2Zpamlfc211bWdyLmMKQEAgLTE2MDAsMjAgKzE2MDAsMTkgQEAgc3RhdGljIGludCBmaWpp
X3BvcHVsYXRlX3NtY191dmRfbGV2ZWwoc3RydWN0IHBwX2h3bWdyICpod21nciwKIHN0YXRpYyBp
bnQgZmlqaV9wb3B1bGF0ZV9zbWNfYm9vdF9sZXZlbChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAog
CQlzdHJ1Y3QgU01VNzNfRGlzY3JldGVfRHBtVGFibGUgKnRhYmxlKQogewotCWludCByZXN1bHQg
PSAwOwogCXN0cnVjdCBzbXU3X2h3bWdyICpkYXRhID0gKHN0cnVjdCBzbXU3X2h3bWdyICopKGh3
bWdyLT5iYWNrZW5kKTsKIAogCXRhYmxlLT5HcmFwaGljc0Jvb3RMZXZlbCA9IDA7CiAJdGFibGUt
Pk1lbW9yeUJvb3RMZXZlbCA9IDA7CiAKIAkvKiBmaW5kIGJvb3QgbGV2ZWwgZnJvbSBkcG0gdGFi
bGUgKi8KLQlyZXN1bHQgPSBwaG1fZmluZF9ib290X2xldmVsKCYoZGF0YS0+ZHBtX3RhYmxlLnNj
bGtfdGFibGUpLAotCQkJZGF0YS0+dmJpb3NfYm9vdF9zdGF0ZS5zY2xrX2Jvb3R1cF92YWx1ZSwK
LQkJCSh1aW50MzJfdCAqKSYodGFibGUtPkdyYXBoaWNzQm9vdExldmVsKSk7CisJcGhtX2ZpbmRf
Ym9vdF9sZXZlbCgmKGRhdGEtPmRwbV90YWJsZS5zY2xrX3RhYmxlKSwKKwkJCSAgICBkYXRhLT52
Ymlvc19ib290X3N0YXRlLnNjbGtfYm9vdHVwX3ZhbHVlLAorCQkJICAgICh1aW50MzJfdCAqKSYo
dGFibGUtPkdyYXBoaWNzQm9vdExldmVsKSk7CiAKLQlyZXN1bHQgPSBwaG1fZmluZF9ib290X2xl
dmVsKCYoZGF0YS0+ZHBtX3RhYmxlLm1jbGtfdGFibGUpLAotCQkJZGF0YS0+dmJpb3NfYm9vdF9z
dGF0ZS5tY2xrX2Jvb3R1cF92YWx1ZSwKLQkJCSh1aW50MzJfdCAqKSYodGFibGUtPk1lbW9yeUJv
b3RMZXZlbCkpOworCXBobV9maW5kX2Jvb3RfbGV2ZWwoJihkYXRhLT5kcG1fdGFibGUubWNsa190
YWJsZSksCisJCQkgICAgZGF0YS0+dmJpb3NfYm9vdF9zdGF0ZS5tY2xrX2Jvb3R1cF92YWx1ZSwK
KwkJCSAgICAodWludDMyX3QgKikmKHRhYmxlLT5NZW1vcnlCb290TGV2ZWwpKTsKIAogCXRhYmxl
LT5Cb290VmRkYyAgPSBkYXRhLT52Ymlvc19ib290X3N0YXRlLnZkZGNfYm9vdHVwX3ZhbHVlICoK
IAkJCVZPTFRBR0VfU0NBTEU7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
