Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115DAC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B533D2225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFTBbu+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B533D2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7556E0E5;
	Mon, 16 Nov 2020 19:18:13 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478B76E071
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:53 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id u12so12420787wrt.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=noNY+SglbM8aEsCCdAF8dY+Y+lbfpcrhUN1CWHwGoPw=;
 b=DFTBbu+5/taBz5pfwjhg2wGKAOcz772ZE8KKWtmmMpONrvSSKnHUEF6FR+5UjXPlQK
 XmlgrM5ohKz9h/HLFZcXQxou2oIiaih5t2afZ7Otfj4eqUJz+ClVii6GJ31QOupottY2
 06K+IiP5G5Tql72mSEUj5Elt4Zonc+FW5cVsOEaMS375Pw0lb25NVw8jn19KABojYTnO
 sIvvQE5jz3fGbJosQodyjtGV4pDXBk4l7CjgB7lbA9PWHD/hGoTrLX7YaUy58OBTdG8n
 uyZSjbl/MOssb5we3fYsnndgw9ANHUUAgPawXlc59hSgBoC/XP5DMqLG24yHn7aduPpK
 h7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=noNY+SglbM8aEsCCdAF8dY+Y+lbfpcrhUN1CWHwGoPw=;
 b=ZfKI+saCzPH+5ZI+XNK8SutgWjx847Et1s4IHqG++yZfa7+/u+PQd5uJwQA+qUw3VQ
 6dUa54MPfHipBa+pTK6b8grA6rQolYXsDpKZywIYaXIGoV2V8j5z0H1YKPkGsjBrUoxn
 GY9E6yfjeeHb8H8uwWGaHKnnwLnZMecC+UvNyf2gvW9dRRRW6je11DFm2idF+GDPvJ6a
 UERxSbhCI/HMInrfV26ZfNIXlxbouNK8/oqNFQTro1u1Vc9xF6ZoszqsyVwyW1poErn9
 0MbmYEdYpsW/vxswlbnxzan9bLxrAsfJYsx1RVB7Uu8gi/iaglbe1WcEzN5Q/Ypw75Jy
 69aA==
X-Gm-Message-State: AOAM5309dTqSENeS276ih2eEeIjJlphk3JKPCQDJZoEHwqQE6pNa34ru
 wD1GxrbCkEB+urdtP20j1fajkQ==
X-Google-Smtp-Source: ABdhPJyZfd0rNWrnYq7A3M2ndx2Eq6U97hpTle2EgGXwsNwTmEA6pUg4LVpVHh3yyTfW4Sn4/lXW8A==
X-Received: by 2002:adf:e48d:: with SMTP id i13mr19977610wrm.387.1605548271964; 
 Mon, 16 Nov 2020 09:37:51 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:51 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 35/43] drm/radeon/cik_sdma: Move
 'amdgpu_cik_gpu_check_soft_reset()'s prototype to shared header
Date: Mon, 16 Nov 2020 17:36:52 +0000
Message-Id: <20201116173700.1830487-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9jaWsuYzo0ODQ1OjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3Rv
dHlwZSBmb3Ig4oCYY2lrX2dwdV9jaGVja19zb2Z0X3Jlc2V04oCZIFstV21pc3NpbmctcHJvdG90
eXBlc10KIDQ4NDUgfCB1MzIgY2lrX2dwdV9jaGVja19zb2Z0X3Jlc2V0KHN0cnVjdCByYWRlb25f
ZGV2aWNlICpyZGV2KQogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KCkNjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5p
ZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25l
ZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9jaWsuaCAgICAgIHwgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Np
a19zZG1hLmMgfCAzICstLQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuaCBiL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmgKaW5kZXggMjk3YjNjMWZmODA0Zi4uNjYzMGI5ZGE5
ZTdhYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuaAorKysgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5oCkBAIC0yOSw1ICsyOSw2IEBAIHZvaWQgY2lrX2VudGVy
X3JsY19zYWZlX21vZGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwogdm9pZCBjaWtfZXhp
dF9ybGNfc2FmZV9tb2RlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIGludCBjaV9tY19s
b2FkX21pY3JvY29kZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiB2b2lkIGNpa191cGRh
dGVfY2coc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIHUzMiBibG9jaywgYm9vbCBlbmFibGUp
OwordTMyIGNpa19ncHVfY2hlY2tfc29mdF9yZXNldChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRl
dik7CiAKICNlbmRpZiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBfX0NJS19IX18gKi8KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrX3NkbWEuYyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vY2lrX3NkbWEuYwppbmRleCAzYzcwOWViZThkMWFiLi45MTliMTQ4NDVjM2M3
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npa19zZG1hLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9jaWtfc2RtYS5jCkBAIC0yNywxNCArMjcsMTMgQEAKICNpbmNs
dWRlICJyYWRlb25fdWNvZGUuaCIKICNpbmNsdWRlICJyYWRlb25fYXNpYy5oIgogI2luY2x1ZGUg
InJhZGVvbl90cmFjZS5oIgorI2luY2x1ZGUgImNpay5oIgogI2luY2x1ZGUgImNpa2QuaCIKIAog
Lyogc2RtYSAqLwogI2RlZmluZSBDSUtfU0RNQV9VQ09ERV9TSVpFIDEwNTAKICNkZWZpbmUgQ0lL
X1NETUFfVUNPREVfVkVSU0lPTiA2NAogCi11MzIgY2lrX2dwdV9jaGVja19zb2Z0X3Jlc2V0KHN0
cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKLQogLyoKICAqIHNETUEgLSBTeXN0ZW0gRE1BCiAg
KiBTdGFydGluZyB3aXRoIENJSywgdGhlIEdQVSBoYXMgbmV3IGFzeW5jaHJvbm91cwotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
