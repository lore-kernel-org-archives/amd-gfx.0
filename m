Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792E9C64E7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18CED20872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROnAYiAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CED20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF5D6E932;
	Wed, 25 Nov 2020 08:23:00 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0C06E536
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:03 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id d142so77286wmd.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HQG7VvhLuLqLIiCO1wDsJUncEyILipv0iifGGhYNwBw=;
 b=ROnAYiAd5qDaRM6zlXai5MEWDhk655E2E+vwaBBQzU3vLw++RLC4/Jub4Bt3Hvy0HW
 pwVKhquuQdg0kk3tR1802CxvCaIcCwMmVQyiRfLJBffRMydYoXbNWu6QKx04FekT+/qp
 qoL59FYT3twrWeZa+Kd9U45wg7C8HeQReGIsbPxd3eF+kBkgnRVKLMICmYUZVZZcSKcB
 i3krnvNltBSKPhTsEx91aoglWLCC8evPXFNZ5CcQoBWLe40kKZ/NpidKAmX1NZFJSC5e
 3429CPqWQ2HYM51EEndQBWcN+40LTgM9aL9qXD4DJTS4i3u5d6Y7QaI4+o6IYnURuma3
 QtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HQG7VvhLuLqLIiCO1wDsJUncEyILipv0iifGGhYNwBw=;
 b=jZzJNHacxh+oT0EwBMWF8amlMrBfWGs2TJG2ruRQWFW1UeILoQPiHyHaUi9edZJe5t
 TSJ4uvNJ3ujzUv9wHJaLfWcLhVLa79VKfH3cv6bq1pFGIDPvFUnCRop7EozsuveK+9Rd
 BkH0fojtSkV06oWHvFC88W7xc+A3VxofM1eZlo7WGz5/w9+xwFSzFmrVizjzcGxbdOGo
 uZZydSHE5kcZXUkX+ADzBFMvnKrhMK2mYE2UnGWSIGWZw5lUOwvVajSji7IKpJdMo7sl
 0yIY/LZCZQecxbpJ10mzYhNn7Kg8xS3cM35h/vTWGrcSLYz6wZMB2GMtALban2RW3uY3
 Qwtw==
X-Gm-Message-State: AOAM530Qfan8xMwUJx6YN/nRmagIltt2im5oh65djNCNf8exd+zHaDb9
 XHLCyOPD/5uoa/Ex7INzcCYquw==
X-Google-Smtp-Source: ABdhPJxABCqmQpKoOyO33AaWgS8+y0qIF8skdrZlNoUJ266NV2fmZqe3GarA3FNS1UObzNFWwWwgCA==
X-Received: by 2002:a1c:4b10:: with SMTP id y16mr22750wma.10.1606247041886;
 Tue, 24 Nov 2020 11:44:01 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:01 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 02/40] drm/amd/amdgpu/gmc_v10_0: Suppy some missing function
 doc descriptions
Date: Tue, 24 Nov 2020 19:37:46 +0000
Message-Id: <20201124193824.1118741-3-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmM6Mjc4OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICd2bWh1Yicgbm90IGRlc2NyaWJlZCBpbiAnZ21jX3YxMF8wX2Zs
dXNoX2dwdV90bGInCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYzoyNzg6
IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2ZsdXNoX3R5cGUnIG5vdCBk
ZXNjcmliZWQgaW4gJ2dtY192MTBfMF9mbHVzaF9ncHVfdGxiJwogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3YxMF8wLmM6MzcxOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Ig
bWVtYmVyICdmbHVzaF90eXBlJyBub3QgZGVzY3JpYmVkIGluICdnbWNfdjEwXzBfZmx1c2hfZ3B1
X3RsYl9wYXNpZCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jOjM3MTog
d2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYWxsX2h1Yicgbm90IGRlc2Ny
aWJlZCBpbiAnZ21jX3YxMF8wX2ZsdXNoX2dwdV90bGJfcGFzaWQnCgpDYzogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+
CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1
bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIu
a2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYt
Ynk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEw
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCmluZGV4IGQ5Mzk5
MzI0YmU0NzQuLjQ4ODdiMGU2NmU5NzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192MTBfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
MTBfMC5jCkBAIC0yNzAsNiArMjcwLDggQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX2ZsdXNoX3Zt
X2h1YihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKICAqCiAgKiBA
YWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCiAgKiBAdm1pZDogdm0gaW5zdGFuY2UgdG8gZmx1
c2gKKyAqIEB2bWh1Yjogdm1odWIgdHlwZQorICogQGZsdXNoX3R5cGU6IHRoZSBmbHVzaCB0eXBl
CiAgKgogICogRmx1c2ggdGhlIFRMQiBmb3IgdGhlIHJlcXVlc3RlZCBwYWdlIHRhYmxlLgogICov
CkBAIC0zNjIsNiArMzY0LDggQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX2ZsdXNoX2dwdV90bGIo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCiAgKgogICogQGFkZXY6
IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgogICogQHBhc2lkOiBwYXNpZCB0byBiZSBmbHVzaAorICog
QGZsdXNoX3R5cGU6IHRoZSBmbHVzaCB0eXBlCisgKiBAYWxsX2h1YjogVXNlZCB3aXRoIFBBQ0tF
VDNfSU5WQUxJREFURV9UTEJTX0FMTF9IVUIoKQogICoKICAqIEZsdXNoIHRoZSBUTEIgZm9yIHRo
ZSByZXF1ZXN0ZWQgcGFzaWQuCiAgKi8KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
