Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D5DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF5C23136
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF5C23136
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F316E14F;
	Wed, 13 Jan 2021 08:24:30 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B14A389F89
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:08:08 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id 91so1060962wrj.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2j2xvlvTKeMvAjdQ03/GzFSNxUFT495xm2EMvSlOnPM=;
 b=fQ5NcLvVmka8WVFVF8DEXHGDlkPDS55e/BwTL1KBk+7FfqF86JcS8D68hU+6tmFN1n
 Gsg9PcDpf7B3zPVrHJ7PVzXs6hq3ruq7R4is9h7lIyQSKqWfBHWm1sVX6EGp3842webt
 ZYyEKUVsd/NOnCsePUQOE6aD5Z9dW2fgHnDK5Nt0q+navMgiIvEF3UWIFnYrFo0jPINu
 qbxP5oOJiTc620W0S2DxUiF7zeCfYNC2M8+8b6qlpWz+Cxtqr1O9N4jrV6Z9p96uF5u0
 YJEWADvfeJ81IfirIzAKTthEivnS04jr68iT2p1Mw5TpoTV2uMiE6b/xPghq/BdJGWQ8
 u1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2j2xvlvTKeMvAjdQ03/GzFSNxUFT495xm2EMvSlOnPM=;
 b=ju1hkhRntdCS35UP4UCkf1jvGWMCj+vQywp/bGPxSJEAVEYxwYeZCztmIb3sm2vhES
 3dhX1sIJTTr8EzjaHlxFw/zVcENuor9kqM+SSQGQq00QlaG/sQIkGligH3/K9WPU1EeL
 dwDm69tjjSoB8zHj4AZIPBYVmhkyqgOGmoxblb1bX2RECmETMwcmK34k2I2iqmgO6aJ8
 ieo1NPxdRSGiPvbFGUkxVieND6I7Fphio94pC00MCelKsMRZDhVxh/lE13zKl+ZwkraR
 iaFciAnLF89byyCWjjSHpva5oGNSzVQrfSlGgwopY60g7iLc/ciWDMCgoWRHT86GDGjY
 KQzw==
X-Gm-Message-State: AOAM531mMnDdOuRmIFdOWBSSQwlCq9xRneVJ1kyySmYs3dxAn8RhKI57
 NTAgGLwJDlb78bqp9SIfHQ1XsQ==
X-Google-Smtp-Source: ABdhPJxnX4w3sgt74f0E69wB49NZREq27p9CdFTOlVg+5VdGuDs9Cn7/6qCnQb9gbEPh2ZGzoJJauA==
X-Received: by 2002:adf:a441:: with SMTP id e1mr1151919wra.385.1610525287440; 
 Wed, 13 Jan 2021 00:08:07 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:08:06 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 09/30] drm/amd/display/dc/dce112/dce112_resource: Include our
 own header file containing prototypes
Date: Wed, 13 Jan 2021 08:07:31 +0000
Message-Id: <20210113080752.1003793-10-lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTIvZGNlMTEyX3Jlc291cmNl
LmM6ODgzOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZGNlMTEyX3Zh
bGlkYXRlX2JhbmR3aWR0aOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTExMi9kY2UxMTJfcmVzb3VyY2UuYzoxMDA4
OjE2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTExMl9hZGRfc3Ry
ZWFtX3RvX2N0eOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTExMi9kY2UxMTJfcmVzb3VyY2UuYzoxNDA3OjIzOiB3
YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTExMl9jcmVhdGVfcmVzb3Vy
Y2VfcG9vbOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCgpDYzogSGFycnkgV2VudGxhbmQgPGhh
cnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogQW50
aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5
OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2UxMTIvZGNlMTEyX3Jlc291cmNlLmMgfCA0ICsrKy0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEyL2RjZTExMl9yZXNvdXJjZS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMi9kY2UxMTJfcmVzb3VyY2UuYwppbmRl
eCBjNjhlNTc2YTIxOTkwLi5lZTU1Y2RhODU0YmY0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEyL2RjZTExMl9yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTIvZGNlMTEyX3Jlc291cmNlLmMKQEAgLTU5LDcg
KzU5LDkgQEAKICNpbmNsdWRlICJkY2UvZGNlXzExXzJfc2hfbWFzay5oIgogCiAjaW5jbHVkZSAi
ZGNlMTAwL2RjZTEwMF9yZXNvdXJjZS5oIgotI2RlZmluZSBEQ19MT0dHRVIgXAorI2luY2x1ZGUg
ImRjZTExMl9yZXNvdXJjZS5oIgorCisjZGVmaW5lIERDX0xPR0dFUgkJCQlcCiAJCWRjLT5jdHgt
PmxvZ2dlcgogCiAjaWZuZGVmIG1tRFBfRFBIWV9JTlRFUk5BTF9DVFJMCi0tIAoyLjI1LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
