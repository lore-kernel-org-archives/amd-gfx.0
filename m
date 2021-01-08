Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F1BC43332
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59794239A1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59794239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84AA6E903;
	Fri,  8 Jan 2021 20:24:22 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4291D6E8E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:49 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id i9so10169635wrc.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2YbZqZMpXxFWUfLfazawHX6Ul5l98eF2j1+JdfYq+I0=;
 b=LF0DUdkoHdmvzblDhce37V9TWsLDe1dZxIxHP/4mt1D85NHvxbmxWWFNmay9mC0Anm
 +fH5Rwe0O2yf+zgF/VUlOw9Tmo7+cNs1Jtkf0U8SXp1rRQcDCzePm/cF5MzshIn253wB
 D96pZSPhRi7PfxFyz/KxNaBO5MYrKdpX7nWcyOoMC30hZX/Ze71Rm/b2RJfh+nF5/303
 xZz/GpqBv9yIKyYzQUy5PeKKCvNiD4YcxZiGK4DUpi0C0RPPViCNf0nX3haG7pfr5JXh
 W9DcQGuPGcp4MDnI5hxDlQAL0z37BfAcQjLlnLkJHYIf4jEFDypcBec0Xm5SHbJeiqna
 Wypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2YbZqZMpXxFWUfLfazawHX6Ul5l98eF2j1+JdfYq+I0=;
 b=ZsYr+3NjBeOY4CwpqkaJpm4zs/o66p6KtuS9O0HNgFYDHGcQT+D4kkoQ9B2TTEg20c
 PT4XBI5wJIpqIBA8Dwb9imly0eomSiPSrmxlSXdK4JiEdjgdei7Stc3pgJmxMyyssTJT
 5fzZJN5TUOl7QkfqRMVhnNTynOylhb+MsZZAoijZymg+x/TRF9sUnrS2w1hRw2qHprQu
 /ifcE/uwjESrJRKeUtHolYQEexmCHIAJejWqDLyffugyr73UUpFZGZj7t3AzdTx7SEjH
 9DWL1t/eL+s3vlrMD/kLCb7CEKMCE8+omOun8g4FpwZU8OU2zL1VXl/uCSRrHUDZ1B4T
 v6hA==
X-Gm-Message-State: AOAM533TWWf+7kYqiXAteznfwabMW9+Km+NtQlwHpgzBa7ILvk+Y5CCo
 MhYKM58RF7f7Mqfo4Y0DMOkO8A==
X-Google-Smtp-Source: ABdhPJzgC4LvXvxvGF/K8p/Oa2lLfZfpv3jMcSFJHPBHPBBQyKiZV78VAghxZYT3hqCUTh2xNKO4ew==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr5165454wre.128.1610136947898; 
 Fri, 08 Jan 2021 12:15:47 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:47 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 30/40] drm/amd/display/dc/dce/dce_dmcu: Move
 'abm_gain_stepsize' to only source file it's used in
Date: Fri,  8 Jan 2021 20:14:47 +0000
Message-Id: <20210108201457.3078600-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Jan 2021 20:24:14 +0000
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

QW5kIG9ubHkgZGVjbGFyZSBpdCBpZiBpdCdzIHRvIGJlIHVzZWQuCgpGaXhlcyB0aGUgZm9sbG93
aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfZG1jdS5oOjMyMDoyMzogd2FybmluZzog4oCYYWJt
X2dhaW5fc3RlcHNpemXigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZh
cmlhYmxlPV0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2Rj
ZV9kbWN1Lmg6MzIwOjIzOiB3YXJuaW5nOiDigJhhYm1fZ2Fpbl9zdGVwc2l6ZeKAmSBkZWZpbmVk
IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2RtY3UuaDozMjA6MjM6IHdhcm5pbmc6
IOKAmGFibV9nYWluX3N0ZXBzaXpl4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1j
b25zdC12YXJpYWJsZT1dCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2Rj
L2RjZS9kY2VfZG1jdS5oOjMyMDoyMzogd2FybmluZzog4oCYYWJtX2dhaW5fc3RlcHNpemXigJkg
ZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9kbWN1Lmg6MzIwOjIzOiB3
YXJuaW5nOiDigJhhYm1fZ2Fpbl9zdGVwc2l6ZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1
bnVzZWQtY29uc3QtdmFyaWFibGU9XQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9kYy9kY2UvZGNlX2RtY3UuaDozMjA6MjM6IHdhcm5pbmc6IOKAmGFibV9nYWluX3N0ZXBz
aXpl4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfZG1jdS5oOjMy
MDoyMzogd2FybmluZzog4oCYYWJtX2dhaW5fc3RlcHNpemXigJkgZGVmaW5lZCBidXQgbm90IHVz
ZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnku
d2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7Zu
aWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRA
bGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBNYXVybyBS
b3NzaSA8aXNzb3Iub3J1YW1AZ21haWwuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTog
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlL2RjZV9kbWN1LmMgfCA0ICsrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY2UvZGNlX2RtY3UuaCB8IDIgLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2UvZGNlX2RtY3UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY2UvZGNlX2RtY3UuYwppbmRleCBmYTJiNDdkNDFlZTJmLi4zMDI2NGZjMTUxYTJiIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9kbWN1LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfZG1jdS5jCkBAIC02
NSw2ICs2NSwxMCBAQAogLy9SZWdpc3RlciBhY2Nlc3MgcG9saWN5IHZlcnNpb24KICNkZWZpbmUg
bW1NUDBfU01OX0MyUE1TR185MQkJCQkweDE2MDlCCiAKKyNpZiBkZWZpbmVkKENPTkZJR19EUk1f
QU1EX0RDX0RDTikKK3N0YXRpYyBjb25zdCB1aW50MzJfdCBhYm1fZ2Fpbl9zdGVwc2l6ZSA9IDB4
MDA2MDsKKyNlbmRpZgorCiBzdGF0aWMgYm9vbCBkY2VfZG1jdV9pbml0KHN0cnVjdCBkbWN1ICpk
bWN1KQogewogCS8vIERvIG5vdGhpbmcKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY2UvZGNlX2RtY3UuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2UvZGNlX2RtY3UuaAppbmRleCA5M2U3ZjM0ZDQ3NzVlLi5jZWZiN2Y1YmY0MmNjIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9kbWN1LmgKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfZG1jdS5oCkBAIC0zMTcs
NiArMzE3LDQgQEAgc3RydWN0IGRtY3UgKmRjbjIxX2RtY3VfY3JlYXRlKAogCiB2b2lkIGRjZV9k
bWN1X2Rlc3Ryb3koc3RydWN0IGRtY3UgKipkbWN1KTsKIAotc3RhdGljIGNvbnN0IHVpbnQzMl90
IGFibV9nYWluX3N0ZXBzaXplID0gMHgwMDYwOwotCiAjZW5kaWYgLyogX0RDRV9BQk1fSF8gKi8K
LS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
