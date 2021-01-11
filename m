Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D17C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE4B22B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE4B22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A41326E0CF;
	Mon, 11 Jan 2021 19:54:47 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1723289F2A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:20:07 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id y187so6750wmd.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XglR2B7+pPX3eYsluIvPfl6OG4j36ADswhuMOYNo3hg=;
 b=v0kjp3b9BaCSWh+eLTY3X+pT+IYILY46vX6ifaGyGDT4awOaro0c1mcQedYno+827R
 h2JPqlkQdJOPKtsGqOoglgZOGPuy30u57Cqrb+yeSlnNpGlAHVF8hWryXYe++utM/zuB
 oYiWKcEfOaXyiPPEVAVAFQNkBFiFOIZ75IZn6vjnKgTrY1R1vhUrIMfq33GPHSW3keAs
 mOXBVzx5IwmblOpa4CkOoHe/FchcKQuDsp4rN77Duvj4fUia2n5Op5mvjzayQYLh1B5V
 deS7OhtDpRCIyFCXJWMDePGeNg4xcOWPGrdkECr9T0ED9vbDU+yEOTk49KT8TDfvmG7a
 A0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XglR2B7+pPX3eYsluIvPfl6OG4j36ADswhuMOYNo3hg=;
 b=PzAJRXHAVVArXzg7MDhYIYwOcEBqumYrnoPRDzyXOLv/42zKnKxtZRshYkHovQUdFH
 Bx/s6sjuYTbsrTVdXqgnFqlcRiGxD9TTNY+bLV/GflfZkHCJXD6xVOpudev0EI08Q4yN
 SIggSbWqvf8SHTDti5cQYPyos/wvrZOsZwxSdTWltnJMjTFrBFTfBYZkzw+cJBvA2orf
 +QwvvMI5n8Nw6K7oMdIBIGpiVtDBNanFUN7IaPst8P/E01GAdrWUgb5atyxW/JukHCzc
 FulDJcfSpCLXLZrp+IYuukhYUO+hfPmKHV4owWxpLMXc0C6l1GCo+0ibOlAJbJl5Qw2p
 phTQ==
X-Gm-Message-State: AOAM530PTIQwq5CMkKZtD9qJZEOQx/caa/UYkqOpQSodDnjyStX5oQ3p
 Zus0hb62w8RRs1mou6cI+hW+cQ==
X-Google-Smtp-Source: ABdhPJza+Bt3p7uNeVue52RL0qVon565iY4wsEi+8Ie6KVINUcSkhJMOD7w5N8y2JD9mFZI3mRu2hA==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr294573wmj.52.1610392805783;
 Mon, 11 Jan 2021 11:20:05 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:20:05 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 27/40] drm/amd/display/dc/dce110/dce110_compressor: Strip out
 unused function 'controller_id_to_index'
Date: Mon, 11 Jan 2021 19:19:13 +0000
Message-Id: <20210111191926.3688443-28-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2NvbXByZXNz
b3IuYzo0Mjk6MTQ6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYY29udHJv
bGxlcl9pZF90b19pbmRleOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCgpDYzogSGFycnkgV2Vu
dGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1k
LmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
PgpDYzogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25l
ZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogLi4uL2FtZC9k
aXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfY29tcHJlc3Nvci5jIHwgMjUgLS0tLS0tLS0tLS0tLS0t
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDI1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2NvbXByZXNzb3IuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2NvbXByZXNzb3IuYwpp
bmRleCAxOGIwYTY5YjBiMWU4Li40NDU2NGE0NzQyYjUyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9jb21wcmVzc29yLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfY29tcHJlc3Nvci5jCkBA
IC00MjUsMzEgKzQyNSw2IEBAIHZvaWQgZ2V0X21heF9zdXBwb3J0X2ZiY19idWZmZXJzaXplKHVu
c2lnbmVkIGludCAqbWF4X3gsIHVuc2lnbmVkIGludCAqbWF4X3kpCiAJICovCiB9CiAKLQotdW5z
aWduZWQgaW50IGNvbnRyb2xsZXJfaWRfdG9faW5kZXgoZW51bSBjb250cm9sbGVyX2lkIGNvbnRy
b2xsZXJfaWQpCi17Ci0JdW5zaWduZWQgaW50IGluZGV4ID0gMDsKLQotCXN3aXRjaCAoY29udHJv
bGxlcl9pZCkgewotCWNhc2UgQ09OVFJPTExFUl9JRF9EMDoKLQkJaW5kZXggPSAwOwotCQlicmVh
azsKLQljYXNlIENPTlRST0xMRVJfSURfRDE6Ci0JCWluZGV4ID0gMTsKLQkJYnJlYWs7Ci0JY2Fz
ZSBDT05UUk9MTEVSX0lEX0QyOgotCQlpbmRleCA9IDI7Ci0JCWJyZWFrOwotCWNhc2UgQ09OVFJP
TExFUl9JRF9EMzoKLQkJaW5kZXggPSAzOwotCQlicmVhazsKLQlkZWZhdWx0OgotCQlicmVhazsK
LQl9Ci0JcmV0dXJuIGluZGV4OwotfQotCi0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY29tcHJlc3Nv
cl9mdW5jcyBkY2UxMTBfY29tcHJlc3Nvcl9mdW5jcyA9IHsKIAkucG93ZXJfdXBfZmJjID0gZGNl
MTEwX2NvbXByZXNzb3JfcG93ZXJfdXBfZmJjLAogCS5lbmFibGVfZmJjID0gZGNlMTEwX2NvbXBy
ZXNzb3JfZW5hYmxlX2ZiYywKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
