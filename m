Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70CCC55ABD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54424206CB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G98UJ0t6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54424206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B73896C4;
	Mon,  9 Nov 2020 21:21:43 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12F78957D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:07 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id r17so6464902wrw.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zaj9PQ1+4jRxFdQPS9IoWMCG22fw+6XqKxYZ9+Me3Xg=;
 b=G98UJ0t6Uf8XyAe1ROYsF/XIMBcEriB62SabFOr3x7XylyO8f9EbS45rVGhEBLXDKc
 hsQWYFs4zJrYc8FmqhCl4m5tFEmUxtb/xdNjP38hGmTM+qJYlf6lSeEtXHgBY1Lxc1SA
 woIBgG5kTOcPnd9oN2qSk/gOYKj/NVFn+xnPT8PufPJK9ISuPMYdystjas8QpGyhxCK+
 WtcpnuN2ItVwsIy5aLglVDP5NcL4TDQ+65zCqarczO7dPo3xQQ7A1fqgdOtMQ8sFQoBt
 TSwqrf1ReLTffFk2GBD4UR3j4VhzU9yKA8Fb0Q9ctsBiVMwkr9lJ2Lss+sSdO0Qjq+Zn
 hz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zaj9PQ1+4jRxFdQPS9IoWMCG22fw+6XqKxYZ9+Me3Xg=;
 b=F48NTV+GKT/AQArDq6aIG2rbHC/9Jfkxcy+ddHo4ggAF3Y9fAANoE7GpUclRJdabmv
 OA3YLCJ3esMpAe/bW3yi7zAoizGz1+Ro8zkPvmZpB3RxefwRuUHfqfHHxb+5dnHC5rFj
 kghUdLV8Wbn3vf0syUG59JfwmDa9KsYvIobfRMP5h6KB/Uoh5T579RWoKT6aHCWJVU2X
 AV2Px7z/Qh70TuZeEJY1Muh28VT1gslbJXoYSP/GPFosqlB3hx7W2eLq5Sr7JkIIaZ4l
 f63eo9CDECHw7paFQINr6+FIFWrO8ommjJlaFFYSuxO88W36M2pXGKg7wOG5+B2DdDwd
 kDLQ==
X-Gm-Message-State: AOAM532tNFW7c0/ETqmmmybVxVNbp+Tm8BlqV/gvEhtZei4DFhT7A7Jv
 moDqyTOqfRAfloZdbR7QjHiTwA==
X-Google-Smtp-Source: ABdhPJwBysRZoAQuR+8rQwerSjF7CGhlBAXduxk3l2+at9VV/7M8Sv74lR+5Ws5WSF+dHOXHmcBybQ==
X-Received: by 2002:a5d:4bc7:: with SMTP id l7mr7212779wrt.105.1604956746318; 
 Mon, 09 Nov 2020 13:19:06 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:05 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 02/20] drm/radeon: Move radeon_ttm{init,
 fini} to shared location
Date: Mon,  9 Nov 2020 21:18:37 +0000
Message-Id: <20201109211855.3340030-3-lee.jones@linaro.org>
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
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmM6IEF0IHRvcCBsZXZlbDoKIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jOjgxNzo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90
b3R5cGUgZm9yIOKAmHJhZGVvbl90dG1faW5pdOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiA4
MTcgfCBpbnQgcmFkZW9uX3R0bV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogfCBe
fn5+fn5+fn5+fn5+fn4KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jOjg3ODo2
OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl90dG1fZmluaeKA
mSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiA4NzggfCB2b2lkIHJhZGVvbl90dG1fZmluaShzdHJ1
Y3QgcmFkZW9uX2RldmljZSAqcmRldikKIHwgXn5+fn5+fn5+fn5+fn5+CgpDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwg
PHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZn
ZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1v
ZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb24uaCAgICAgICAgfCA0ICsrKysKIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX29iamVjdC5jIHwgMiAtLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb24uaCBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmgKaW5kZXggNTNkOTg5OGU5
ODcxZS4uYTBjMjQ5N2NkNGNmNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb24uaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oCkBAIC00NTEsNiAr
NDUxLDEwIEBAIHN0cnVjdCByYWRlb25fc3VyZmFjZV9yZWcgewogLyoKICAqIFRUTS4KICAqLwor
CitpbnQgcmFkZW9uX3R0bV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKK3ZvaWQg
cmFkZW9uX3R0bV9maW5pKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKKwogc3RydWN0IHJh
ZGVvbl9tbWFuIHsKIAlzdHJ1Y3QgdHRtX2JvX2RldmljZQkJYmRldjsKIAlib29sCQkJCWluaXRp
YWxpemVkOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0
LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuYwppbmRleCBhYjgxZTM1
Y2IwNjA2Li4wNDhkODNkMGNhOTk2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9vYmplY3QuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmpl
Y3QuYwpAQCAtNDEsOCArNDEsNiBAQAogI2luY2x1ZGUgInJhZGVvbi5oIgogI2luY2x1ZGUgInJh
ZGVvbl90cmFjZS5oIgogCi1pbnQgcmFkZW9uX3R0bV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNl
ICpyZGV2KTsKLXZvaWQgcmFkZW9uX3R0bV9maW5pKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2
KTsKIHN0YXRpYyB2b2lkIHJhZGVvbl9ib19jbGVhcl9zdXJmYWNlX3JlZyhzdHJ1Y3QgcmFkZW9u
X2JvICpibyk7CiAKIC8qCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
