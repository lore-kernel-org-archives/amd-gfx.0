Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD6C64E75
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4444520674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDltQRsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4444520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615256EC12;
	Fri, 27 Nov 2020 10:15:08 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A3E36E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:06 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id i2so2193673wrs.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zctwnJbPr/3TheGemqq6daAKnhm6ZrMfRQU0PGJhDOc=;
 b=pDltQRsbWl/HhtFyKynIgVHjgGqhl8RyOCVAoakl6T2/8wQPLspSu3Oa1tiDcnfopy
 e9D3OF04dD82YCqF5viq37JgLD1HapAh5shN7dH6FVZnGYgYbc0Nr9n5wp71x9uyA763
 hyVzYQIDCSKZ3qg7AUYKz2AUUOxhJCBcdKTAPiiEogEBCt6VifYy3y7fiWtoAvYKOqMI
 Tfc9eqOdOIM9Zu537WK38RgCB3nxr4F7F7MLFjrUEbq0WGiUq2ArU1o8ynd243lFu6vm
 Q1F4RwWUGcFs24XS6hUYjYtSpz/1ARAh6nm2izEluG7BUhlkfK9Eh6L/d7/JnUIEHLN2
 FxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zctwnJbPr/3TheGemqq6daAKnhm6ZrMfRQU0PGJhDOc=;
 b=bl6yVwnaRIuGVUnPkimHZbYi5jQt6qXQHYUeemfpki24JaLrR8ZJmFYD0QElI1vvgk
 4ufSJCgoVaDssSDKPjtptfDE8pVefeW/mRKnNyDfItLJIden/X4NdGCZQlESREfHzoWX
 Lt99iCqfVmrsgpjcfTsU6gP4a7mFglPWcTLEa1J2TuwmAwl7FbaqeORHcKD8sDYHB5pm
 FhrF0SS5nqN96hspIrNeOrPBDjEU7avFULrQ2BGP7Y/4vQeLZIL5x5Ci4qr/hww4Lrnf
 O7jL2h44GbCTza4DPkkaIDn+hic/cEQr1LXtOM2RSCkMVdv2fqt7RVM5xyanUbD/WPKg
 Fr2Q==
X-Gm-Message-State: AOAM530A8eWS1RVPsRFSzw+VV1bvHlXICysIzAUatBO3lLmevyk0Jely
 ClEaPO6w8GXznLb+C5GHI+9tHw==
X-Google-Smtp-Source: ABdhPJzkB7cDZV53G5xGq+in92IOfoSg7x6IHx+jwt3Fbh0mdS3Y8K7Tay/v5tcXoBvYZmHGxLlldw==
X-Received: by 2002:adf:ec8a:: with SMTP id z10mr4054719wrn.113.1606398185299; 
 Thu, 26 Nov 2020 05:43:05 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:04 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 13/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move
 'smu7_init_function_pointers()'s prototype to header
Date: Thu, 26 Nov 2020 13:42:13 +0000
Message-Id: <20201126134240.3214176-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYzo1
Njk2OjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYc211N19pbml0X2Z1
bmN0aW9uX3BvaW50ZXJz4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIDU2OTYgfCBpbnQgc211
N19pbml0X2Z1bmN0aW9uX3BvaW50ZXJzKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiB8IF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKQ2M6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+
CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8
YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvaHdtZ3IuaCAgICAgICAgICAgICB8IDEg
KwogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYyB8IDEgLQog
MiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2h3bWdyLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL2luYy9od21nci5oCmluZGV4IDBlMjJjYmEzY2UzYTYuLjM5M2U0ZTc2YTg5NjEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2h3bWdyLmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9pbmMvaHdtZ3IuaApAQCAtODI4LDYgKzgyOCw3IEBAIGludCBod21n
cl9oYW5kbGVfdGFzayhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogCiAjZGVmaW5lIFBITV9FTlRJ
UkVfUkVHSVNURVJfTUFTSyAweEZGRkZGRkZGVQogCitpbnQgc211N19pbml0X2Z1bmN0aW9uX3Bv
aW50ZXJzKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpOwogaW50IHNtdThfaW5pdF9mdW5jdGlvbl9w
b2ludGVycyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKTsKIAogI2VuZGlmIC8qIF9IV01HUl9IXyAq
LwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvaHdt
Z3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMKaW5k
ZXggZWMxN2EzZTYzZWEwMi4uNzk5OTA5MWNjYTE2ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3Bvd2VycGxheS9od21nci9od21nci5jCkBAIC00Niw3ICs0Niw2IEBAIGV4dGVybiBj
b25zdCBzdHJ1Y3QgcHBfc211bWdyX2Z1bmMgdmVnYTEyX3NtdV9mdW5jczsKIGV4dGVybiBjb25z
dCBzdHJ1Y3QgcHBfc211bWdyX2Z1bmMgc211MTBfc211X2Z1bmNzOwogZXh0ZXJuIGNvbnN0IHN0
cnVjdCBwcF9zbXVtZ3JfZnVuYyB2ZWdhMjBfc211X2Z1bmNzOwogCi1leHRlcm4gaW50IHNtdTdf
aW5pdF9mdW5jdGlvbl9wb2ludGVycyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKTsKIGV4dGVybiBp
bnQgdmVnYTEwX2h3bWdyX2luaXQoc3RydWN0IHBwX2h3bWdyICpod21ncik7CiBleHRlcm4gaW50
IHZlZ2ExMl9od21ncl9pbml0KHN0cnVjdCBwcF9od21nciAqaHdtZ3IpOwogZXh0ZXJuIGludCB2
ZWdhMjBfaHdtZ3JfaW5pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKTsKLS0gCjIuMjUuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
