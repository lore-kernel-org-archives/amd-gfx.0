Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E524C55ABD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DD6206CB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLNFiHYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DD6206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163DB8967A;
	Mon,  9 Nov 2020 21:21:42 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDA5C89623
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:45 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id t67so903359wmt.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GKEWaGJB8BfGR6ufuyFa6sc9ZYlzJUyj0WhtwnEg+YM=;
 b=yLNFiHYOOshoi44YOcHvCJLLEepPoEefGQL1ft/wS6fsl9FUBhQHLyJ4M4k86v5zCs
 5J5RdBCbgV+7LI5avSvNm9OU0JAbs9DADt00zEd2Ba9Mz4hOjuJn9JFWKURi/7bvIdt1
 xb7UopKkEa8/tRNspkGKQ2Is28Vu5W9N0IieG7NbyaI9fH8PExpFz/fdSK6TKix+0Iwb
 ygndmQg6/vzQvngoclWGooLS0vCOPnLUQucMoGcBAlNeUndHdyfFCWizDCiYwZPTvMDI
 ljKm8/NevMLVASgfqYYYm+5j3vYRMHMEMecOkwxAWvBCEZ2lR1U8SOBYI06Q/nz3j6NV
 BOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GKEWaGJB8BfGR6ufuyFa6sc9ZYlzJUyj0WhtwnEg+YM=;
 b=db+dI3/0DQ9K7bH2P6tDr4xIPygBCrI+4Cci58ngkudCFwy+/gFpP9dRu0d3hbdUf5
 xocf5OE/byNY+bdIOE3iNhyn4O/efsnN39pOeI8f/v3N1qbqbyhOcGeCJbyM2uenQ//i
 z8jkUCPfPXdD9Nx3Os9htEjIFTU369wRQQTV48R1IEEPIAWnmB4Rxhla/BiVMqU1wBor
 xE+Q/dtMG8sGEHtk4djALJzhViJV9WHutIrefBSzmAIlkeVRuTRrSUsD+rLXOXkTWiCb
 Y7C+mXgYfxstSundh35lX651ubARpKVrfRbA15ozbixB7oE3p5evxbWFNDp/lL4KCVyq
 sTtA==
X-Gm-Message-State: AOAM530fWFqHKgv2mpGfIuZjL7kvr89AHhXHFw9pEq+Uzm0QeN8/gUIF
 W2lDEwpVUHapZtZJ4SZQE6Xk0g==
X-Google-Smtp-Source: ABdhPJx/sTwJZZUmZSp3w+fqzVck3NElKnITF1z4pScY50oBvZIPhiTvpoumw7kgMJvCdjWybNkkCg==
X-Received: by 2002:a1c:2ece:: with SMTP id u197mr1180731wmu.58.1604956784455; 
 Mon, 09 Nov 2020 13:19:44 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:43 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 18/20] drm/radeon/radeon_display: Fix function doc formatting
 and missing param issues
Date: Mon,  9 Nov 2020 21:18:53 +0000
Message-Id: <20201109211855.3340030-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:21:41 +0000
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
 report to <xorg-driver-ati@lists.x.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jOjI2NDogd2FybmluZzogRnVuY3Rpb24g
cGFyYW1ldGVyIG9yIG1lbWJlciAnX193b3JrJyBub3QgZGVzY3JpYmVkIGluICdyYWRlb25fdW5w
aW5fd29ya19mdW5jJwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jOjQw
Njogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnX193b3JrJyBub3QgZGVz
Y3JpYmVkIGluICdyYWRlb25fZmxpcF93b3JrX2Z1bmMnCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9kaXNwbGF5LmM6OTU2OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVt
YmVyICdmcmVxJyBub3QgZGVzY3JpYmVkIGluICdyYWRlb25fY29tcHV0ZV9wbGxfYXZpdm8nCiBk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmM6OTU2OiB3YXJuaW5nOiBGdW5j
dGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdmYl9kaXZfcCcgbm90IGRlc2NyaWJlZCBpbiAncmFk
ZW9uX2NvbXB1dGVfcGxsX2F2aXZvJwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlz
cGxheS5jOjk1Njogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZnJhY19m
Yl9kaXZfcCcgbm90IGRlc2NyaWJlZCBpbiAncmFkZW9uX2NvbXB1dGVfcGxsX2F2aXZvJwogZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jOjk1Njogd2FybmluZzogRnVuY3Rp
b24gcGFyYW1ldGVyIG9yIG1lbWJlciAncmVmX2Rpdl9wJyBub3QgZGVzY3JpYmVkIGluICdyYWRl
b25fY29tcHV0ZV9wbGxfYXZpdm8nCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNw
bGF5LmM6OTU2OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdwb3N0X2Rp
dl9wJyBub3QgZGVzY3JpYmVkIGluICdyYWRlb25fY29tcHV0ZV9wbGxfYXZpdm8nCgpDYzogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7Zu
aWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRA
bGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBT
ZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogcmVwb3J0IHRvIDx4b3JnLWRyaXZl
ci1hdGlAbGlzdHMueC5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzog
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogbGludXgtbWVkaWFAdmdlci5rZXJu
ZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKU2lnbmVkLW9mZi1ieTog
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9kaXNwbGF5LmMgfCAxMyArKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2Rpc3BsYXkuYwppbmRleCA3OGZjZWVkZmQ5MjU1Li5lYjBkNGNiOTVmMGE2IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jCkBAIC0yNTYsNyArMjU2LDcgQEAgc3Rh
dGljIHZvaWQgcmFkZW9uX2NydGNfZGVzdHJveShzdHJ1Y3QgZHJtX2NydGMgKmNydGMpCiAvKioK
ICAqIHJhZGVvbl91bnBpbl93b3JrX2Z1bmMgLSB1bnBpbiBvbGQgYnVmZmVyIG9iamVjdAogICoK
LSAqIEBfX3dvcmsgLSBrZXJuZWwgd29yayBpdGVtCisgKiBAX193b3JrOiBrZXJuZWwgd29yayBp
dGVtCiAgKgogICogVW5waW4gdGhlIG9sZCBmcmFtZSBidWZmZXIgb2JqZWN0IG91dHNpZGUgb2Yg
dGhlIGludGVycnVwdCBoYW5kbGVyCiAgKi8KQEAgLTM5OCw3ICszOTgsNyBAQCB2b2lkIHJhZGVv
bl9jcnRjX2hhbmRsZV9mbGlwKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgY3J0Y19p
ZCkKIC8qKgogICogcmFkZW9uX2ZsaXBfd29ya19mdW5jIC0gcGFnZSBmbGlwIGZyYW1lYnVmZmVy
CiAgKgotICogQHdvcmsgLSBrZXJuZWwgd29yayBpdGVtCisgKiBAX193b3JrOiBrZXJuZWwgd29y
ayBpdGVtCiAgKgogICogV2FpdCBmb3IgdGhlIGJ1ZmZlciBvYmplY3QgdG8gYmVjb21lIGlkbGUg
YW5kIGRvIHRoZSBhY3R1YWwgcGFnZSBmbGlwCiAgKi8KQEAgLTkzNywxMSArOTM3LDEyIEBAIHN0
YXRpYyB2b2lkIGF2aXZvX2dldF9mYl9yZWZfZGl2KHVuc2lnbmVkIG5vbSwgdW5zaWduZWQgZGVu
LCB1bnNpZ25lZCBwb3N0X2RpdiwKICAqIHJhZGVvbl9jb21wdXRlX3BsbF9hdml2byAtIGNvbXB1
dGUgUExMIHBhcmFtYXRlcnMKICAqCiAgKiBAcGxsOiBpbmZvcm1hdGlvbiBhYm91dCB0aGUgUExM
CisgKiBAZnJlcTogdGFyZ2V0IGZyZXF1ZW5jeQogICogQGRvdF9jbG9ja19wOiByZXN1bHRpbmcg
cGl4ZWwgY2xvY2sKLSAqIGZiX2Rpdl9wOiByZXN1bHRpbmcgZmVlZGJhY2sgZGl2aWRlcgotICog
ZnJhY19mYl9kaXZfcDogZnJhY3Rpb25hbCBwYXJ0IG9mIHRoZSBmZWVkYmFjayBkaXZpZGVyCi0g
KiByZWZfZGl2X3A6IHJlc3VsdGluZyByZWZlcmVuY2UgZGl2aWRlcgotICogcG9zdF9kaXZfcDog
cmVzdWx0aW5nIHJlZmVyZW5jZSBkaXZpZGVyCisgKiBAZmJfZGl2X3A6IHJlc3VsdGluZyBmZWVk
YmFjayBkaXZpZGVyCisgKiBAZnJhY19mYl9kaXZfcDogZnJhY3Rpb25hbCBwYXJ0IG9mIHRoZSBm
ZWVkYmFjayBkaXZpZGVyCisgKiBAcmVmX2Rpdl9wOiByZXN1bHRpbmcgcmVmZXJlbmNlIGRpdmlk
ZXIKKyAqIEBwb3N0X2Rpdl9wOiByZXN1bHRpbmcgcmVmZXJlbmNlIGRpdmlkZXIKICAqCiAgKiBU
cnkgdG8gY2FsY3VsYXRlIHRoZSBQTEwgcGFyYW1ldGVycyB0byBnZW5lcmF0ZSB0aGUgZ2l2ZW4g
ZnJlcXVlbmN5OgogICogZG90X2Nsb2NrID0gKHJlZl9mcmVxICogZmVlZGJhY2tfZGl2KSAvIChy
ZWZfZGl2ICogcG9zdF9kaXYpCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
