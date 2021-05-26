Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7EAC47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD9560FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD9560FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16B46ECE4;
	Wed, 26 May 2021 12:57:24 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62E76EC2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:36 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id n4so222927wrw.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lKeBwQNxcs7ocYKzN7a4O8oaRQu8Cp6t2SySVOZEvJc=;
 b=XOJIerymun8QzB6XXP5wNjsVJygRfMn2bCBX9V9gUfDFMpm25kLTV3EO44NAoo2j5i
 3iSfQk+RtozfLSE0bhk6MeGJ4vV9gQUIcIUOnkztB3q+u6z3oOYlQMoiGMHpN5FJN6w+
 FJx6hQchMJlsPYYhAVlbBncVfoyFjoUOMTQPJ8OT7dIVoQidhzO6Ll+gpXM24TD2tcMj
 EnXiVSmwBuz5TtNVx4MQrvi3cETPA8jpmfUKM1fWQGxom9/PgKjui7Y+fL6dEUstAtMg
 YmxmvEkwUJ5ku14LxFPHGLrMrqg3+wzlam2x+s8tVWPneDACFWNYdsAdduDGQ1mqPxMZ
 J7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lKeBwQNxcs7ocYKzN7a4O8oaRQu8Cp6t2SySVOZEvJc=;
 b=PJiVqhxL06IGcN6uYLyvMEcyQJp/aTQbqR2pdA+XApTxIQhMp8nxtjuqFx/vjncnbo
 gzOVZOyD90sxkO8Dtu7dkGCdfozb0e5JINQyX7pjOY/cELuUAhMAYYAOmwtUgo6p2HJZ
 lL6OQDsMXcrKtHp8cgoZN0N7zspgQxfLjiXsOFaeU/PrlJFTHxHQVCmQAGRj2dELdl9K
 0LVZO2C1L1iiEN2PhuQ0GM/x6soV4E0ti5QDjsG+YSaK2jR+32nH1LjH16u1ikhOp/T6
 ZPsFmNmWCrgeJ2wbL/+SAhT4SKv8jDkuE/Glno8yIhbY2lqpEJpKijUi1iYRxwYzxO1c
 P6tw==
X-Gm-Message-State: AOAM5306ugm540gyBviK1rY7mwEsgy6LbbmUTKfAxjipB+fI2J63pGmr
 c7jyaWUrqG2J3Ay57K6eNX3gXXcGP5TKwQ==
X-Google-Smtp-Source: ABdhPJy/h/7qOMA8yJfz6iMHcuzoO5CwW7Hw3FnfBC/SrmnqXEESL7RSx5gJYYaar6l8ipNBfQNyYA==
X-Received: by 2002:a05:6000:1189:: with SMTP id
 g9mr31168739wrx.385.1622018855535; 
 Wed, 26 May 2021 01:47:35 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:35 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 05/34] drm/amd/pm/powerplay/hwmgr/vega12_hwmgr: Provide
 'vega12_init_smc_table()' function name
Date: Wed, 26 May 2021 09:46:57 +0100
Message-Id: <20210526084726.552052-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5j
OjgxMjogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgSW5pdGlhbGl6ZXMgdGhlIFNN
QyB0YWJsZSBhbmQgdXBsb2FkcyBpdCgpLiBQcm90b3R5cGUgd2FzIGZvciB2ZWdhMTJfaW5pdF9z
bWNfdGFibGUoKSBpbnN0ZWFkCgpDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTJfaHdtZ3IuYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9o
d21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3
bWdyLmMKaW5kZXggMWEwOTdlNjA4ODA4ZS4uMjllMGQxZDQwMzVhZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdyLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdyLmMKQEAg
LTgwMyw3ICs4MDMsNyBAQCBzdGF0aWMgaW50IHZlZ2ExMl9zYXZlX2RlZmF1bHRfcG93ZXJfcHJv
ZmlsZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogI2VuZGlmCiAKIC8qKgotICogSW5pdGlhbGl6
ZXMgdGhlIFNNQyB0YWJsZSBhbmQgdXBsb2FkcyBpdAorICogdmVnYTEyX2luaXRfc21jX3RhYmxl
IC0gSW5pdGlhbGl6ZXMgdGhlIFNNQyB0YWJsZSBhbmQgdXBsb2FkcyBpdAogICoKICAqIEBod21n
cjogIHRoZSBhZGRyZXNzIG9mIHRoZSBwb3dlcnBsYXkgaGFyZHdhcmUgbWFuYWdlci4KICAqIHJl
dHVybjogIGFsd2F5cyAwCi0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
