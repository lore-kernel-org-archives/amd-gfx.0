Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F10C6379D
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A7020702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7aG4NUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A7020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A26789F73;
	Mon, 23 Nov 2020 13:58:03 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C2889D8A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:19:55 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id w24so16875304wmi.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dt3qGeaR7mDkGDOtCiBYSSJ0FSX/4GBqlT4FsqhW3aU=;
 b=A7aG4NUk01QTYOgfaJYXiLRsQmxZSN2RZbte2BKCTWb7GV74h+fgN95VPh8F+EWuHa
 ZwehXJ9Gp9hSTDJO0D6lO5a1PodY3r/JCC30/5lOfGZBR47e6USHjp4tlQ5FPr3WXGeq
 JIyXY0TKeYAtUVV5rTxyT/XUhbnbWDN2sVGU9IZ36KXptQ75GggISLQEwO/Ai/GpDXlC
 8QwJICGLpEy/GYJomAU2bCtyEqLPVpIh+LAstN5RbeKJg4yXPLuC+gYD1EYhlkJbexPE
 Zg5/3luMgUlZMF0HEVjFxIa3rQvyNcIsXwEikhJINH3R+7McVWPCMDJ0FBI8h4gCcRin
 tocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dt3qGeaR7mDkGDOtCiBYSSJ0FSX/4GBqlT4FsqhW3aU=;
 b=kZjOT0TBdUUPFFlrHN3L/yYnd4hmjCgreUQH4zFkUCOxWATP3ugLONA/pkrPS32VUs
 sUOzxqVyKQ3nPmk8TSciaKrn8Lvka7iGoXdN0G5fd86ctXDwTorprnw1wP4HV0uMynpq
 rDC7P2/rZERnkwP1Bu6nhSRVfOSBqmPUXRGG0tTvL397vYtspUYW8+VEbh9BcGhU7yOt
 kMt71SWLCkOJhX2C6LA9BxxSIj1/JJpVHht9iEdc6cbthlA5lMkxeFLGKt0AW9BLqe6N
 rmxyF6m/run/z3y7dt8238P13hevvTqRhXOeMzdBdZErOCcZ+ARDaSrzD1yVMLBtyRsS
 V5ZA==
X-Gm-Message-State: AOAM530QFeZPmGPYJKfcdKVGhxnisyMS9EwXia4G0UavppAJ9vHTuRzh
 XTGr/LLkfwub45oF6wyUoHt8GA==
X-Google-Smtp-Source: ABdhPJx4JMSzWkbKceWi1SW5fvksRYsrwwvS0sk1EeQb+wukDZgTmz/qJ1SYCh17VozYRM5jUgtzIg==
X-Received: by 2002:a1c:2384:: with SMTP id
 j126mr23896282wmj.116.1606130394092; 
 Mon, 23 Nov 2020 03:19:54 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:19:53 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 25/40] drm/amd/include/arct_ip_offset: Mark top-level IP_BASE
 definition as __maybe_unused
Date: Mon, 23 Nov 2020 11:19:04 +0000
Message-Id: <20201123111919.233376-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FyY3RfcmVnX2luaXQu
YzoyNzoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYXJjdF9pcF9vZmZz
ZXQuaDoyMjc6Mjk6IHdhcm5pbmc6IOKAmERCR1VfSU9fQkFTReKAmSBkZWZpbmVkIGJ1dCBub3Qg
dXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQogMjI3IHwgc3RhdGljIGNvbnN0IHN0cnVj
dCBJUF9CQVNFIERCR1VfSU9fQkFTRSA9eyB7IHsgeyAweDAwMDAwMUUwLCAweDAwMDEyNUEwLCAw
eDAwNDBCNDAwLCAwLCAwLCAwIH0gfSwKIHwgXn5+fn5+fn5+fn5+CiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FyY3RfaXBfb2Zmc2V0Lmg6MTI3OjI5OiB3YXJuaW5nOiDi
gJhQQ0lFMF9CQVNF4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJp
YWJsZT1dCiAxMjcgfCBzdGF0aWMgY29uc3Qgc3RydWN0IElQX0JBU0UgUENJRTBfQkFTRSA9eyB7
IHsgeyAweDAwMDEyOEMwLCAweDAwNDExODAwLCAweDA0NDQwMDAwLCAwLCAwLCAwIH0gfSwKIHwg
Xn5+fn5+fn5+fgogSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FyY3RfcmVnX2luaXQuYzoyNzoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2lu
Y2x1ZGUvYXJjdF9pcF9vZmZzZXQuaDo2MzoyOTogd2FybmluZzog4oCYRlVTRV9CQVNF4oCZIGRl
ZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCiA2MyB8IHN0YXRp
YyBjb25zdCBzdHJ1Y3QgSVBfQkFTRSBGVVNFX0JBU0UgPXsgeyB7IHsgMHgwMDAxMjBBMCwgMHgw
MDAxNzQwMCwgMHgwMDQwMTQwMCwgMCwgMCwgMCB9IH0sCiB8IF5+fn5+fn5+fgoKQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxp
bnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
U2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXJjdF9pcF9vZmZzZXQuaCB8IDQgKystLQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXJjdF9pcF9vZmZzZXQuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvaW5jbHVkZS9hcmN0X2lwX29mZnNldC5oCmluZGV4IGE3NzkxYTllMWY5MDUuLmFm
MWM0Njk5MTQyOWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hcmN0
X2lwX29mZnNldC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hcmN0X2lwX29m
ZnNldC5oCkBAIC0yOCwxMiArMjgsMTIgQEAKIHN0cnVjdCBJUF9CQVNFX0lOU1RBTkNFCiB7CiAg
ICAgdW5zaWduZWQgaW50IHNlZ21lbnRbTUFYX1NFR01FTlRdOwotfTsKK30gX19tYXliZV91bnVz
ZWQ7CiAKIHN0cnVjdCBJUF9CQVNFCiB7CiAgICAgc3RydWN0IElQX0JBU0VfSU5TVEFOQ0UgaW5z
dGFuY2VbTUFYX0lOU1RBTkNFXTsKLX07Cit9IF9fbWF5YmVfdW51c2VkOwogCiAKIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgSVBfQkFTRSBBVEhVQl9CQVNFICAgICAgICAgICAgPXsgeyB7IHsgMHgwMDAw
MEMyMCwgMHgwMDAxMjQ2MCwgMHgwMDQwOEMwMCwgMCwgMCwgMCB9IH0sCi0tIAoyLjI1LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
