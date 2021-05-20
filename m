Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9148AC43617
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5718A611AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5718A611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947F96F45B;
	Thu, 20 May 2021 12:49:16 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D276F428
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:38 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id p7so13655062wru.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tJTJtfpMV/J/H+YFu2v39vUwU64txzJ+siPwQcxgUUI=;
 b=mDFB9RE1bc0Vqz3kk4DPBdJ9UZ/aMsd+rUlwA7frOrSPKA4J5EOky+7+ysl+VIeslx
 VnuHUou9Hz0olWToCaUysglK/ryHBbFYTG1zdzpfEsRKX2oKSczKuKDc2NZI/0vROlwG
 nFEFSbfmg6XBybX7YhaVP+Tr/LE1gctAgIP1HLMc0JcMywAitb0spISUg8E4IOPhaaJJ
 Kqq4h1v8Gm03ZOYI1kvz7TzyM67/zNMNzWIRm1646/gx9rl1Tvfm9CQGE6wVv488bsYO
 r6S8oUrYDtO3fYI5BS7HPcNxS2VKfxQLPJABQ3qYCqjXM6uEPjbehPB4X9i5wQ+XUa3x
 o/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tJTJtfpMV/J/H+YFu2v39vUwU64txzJ+siPwQcxgUUI=;
 b=B3hJSLDjcN508qRpFQu+0dcOmVogwr/7ioOJXzlhuuIGLgk8wpQ8jVvVsxq4EqrrDB
 tJXhAvldP2f/wnc0ZHnbAKqr9w23d9Psxct+o6Z1l5wlKCweQBZoF8lsyGdj96qwU2So
 qySmWHPafdFompAvh404bloTbU2D3/Ely4vy3ngJhX5BkVkwuY3/oN4M5ucoBKf44O/Z
 r/AR3gyTbg1wNSuAdIjnxkSCL+6Xku1POKyoZP7pWRc79WXBeqRWqrNZVYRibGNf4GpF
 ctaFABPmTFjfHO2BXbPD/BbqeYq9NlRfLd87DoDq9eWSFZd+DOD0V8fKEUeRtbq7JAuA
 G1nQ==
X-Gm-Message-State: AOAM532Md/wnyScOD3OLeMfw0L8sEJSKC+h5UfYMRnoiKaB652DZ2R54
 jWgNoSId8RONkP/ldoAJ8fYemQ==
X-Google-Smtp-Source: ABdhPJwhOZLLUHKejvhGLkMhKQ561C0i0iSobmuqHgR5qbq460hZZkBpBeFxX4iu+mRWKCqZF6aUVQ==
X-Received: by 2002:adf:e0c6:: with SMTP id m6mr4107882wri.66.1621512217735;
 Thu, 20 May 2021 05:03:37 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:37 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 35/38] drm/amd/amdgpu/sdma_v5_2: Repair typo in function name
Date: Thu, 20 May 2021 13:02:45 +0100
Message-Id: <20210520120248.3464013-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmM6NTAxOiB3YXJuaW5nOiBleHBlY3Rpbmcg
cHJvdG90eXBlIGZvciBzZG1hX3ZfMF9jdHhfc3dpdGNoX2VuYWJsZSgpLiBQcm90b3R5cGUgd2Fz
IGZvciBzZG1hX3Y1XzJfY3R4X3N3aXRjaF9lbmFibGUoKSBpbnN0ZWFkCgpDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwg
PHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZn
ZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1v
ZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3Y1XzIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVf
Mi5jCmluZGV4IGVjYjgyYzM5YjEwNjIuLmRlYjkwN2Y5NjA5MDYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjVfMi5jCkBAIC01MTcsNyArNTE3LDcgQEAgc3RhdGljIHZvaWQgc2Rt
YV92NV8yX3JsY19zdG9wKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogfQogCiAvKioKLSAq
IHNkbWFfdl8wX2N0eF9zd2l0Y2hfZW5hYmxlIC0gc3RvcCB0aGUgYXN5bmMgZG1hIGVuZ2luZXMg
Y29udGV4dCBzd2l0Y2gKKyAqIHNkbWFfdjVfMl9jdHhfc3dpdGNoX2VuYWJsZSAtIHN0b3AgdGhl
IGFzeW5jIGRtYSBlbmdpbmVzIGNvbnRleHQgc3dpdGNoCiAgKgogICogQGFkZXY6IGFtZGdwdV9k
ZXZpY2UgcG9pbnRlcgogICogQGVuYWJsZTogZW5hYmxlL2Rpc2FibGUgdGhlIERNQSBNRXMgY29u
dGV4dCBzd2l0Y2guCi0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
