Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25693C64E7B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CE920872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pv1nAl+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CE920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3096E92E;
	Wed, 25 Nov 2020 08:23:01 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 200BF6E558
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:13 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id l1so23522636wrb.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZMRPM9I1lRNzH88FtoqbWHR6lT2TOJ7GT2PZsC4P/7E=;
 b=Pv1nAl+XofxDOZMywxILqcP4qIfKofxo/gaSMnaL6TNvz2rt53Q/joRSKnqpI7b53o
 +mFQmg+10YbgQAqbu6F/cdCzPBL58XI60OMwNhhOmGOdPuoWXcqr88wOld6btC+12xTf
 vHOZo7K8jnHhrisjkOZOwcL8kDhmTh9ZMP4QGo3QnFq1KxzD84c366EnPZGiWBR1rvXX
 hlQ9n+fPeXMkpACeuYr0J69YEKM3NGMCv/LM9NFvZZ/IzMjhZRGShhD9/7VZmk25Gm2f
 VqeMCMauBULX0332aSWQFCo5DEL0tMUuX4zfbsqua/L0qPD8eIEnuUlEv//H5f+tcSu5
 8v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZMRPM9I1lRNzH88FtoqbWHR6lT2TOJ7GT2PZsC4P/7E=;
 b=UgcCsCy3i2PTj6MPKQEnfpixQlS/Cin8Fp149Et46venNaIX56x8/yAlHOkKSmnWME
 C8NcIXIFTxqfknspYVMOYfL5oEU7Ydme0M2PbYtRG7CyaQ8z3gYSVK1CaUlcH6n+GTzW
 Plh8EBaMy6QulGfsXG82E17tN0h+4j6odYetVK4O705B7etFqPC5E9waxgL1ck8FtHW3
 qA7q419coFizfUVxLVLIFW4GC4SwSphM50lOeZ86iHo4qXyYrpWn4v9YugHaI0hjhamN
 YjYLuAPLJJOrzUvV1yHBUagU9bJNdI0NURWb67F4ZNcqozf90qJRXG2fJFNC8YAAvrJr
 zWFA==
X-Gm-Message-State: AOAM532KLVHgQo+CPCB2yoYJI9oI+v6PXOmAeHmnMruwIwGml1Tv9Xky
 nC3YCgcc7UwGN6htd1WInYhpzg==
X-Google-Smtp-Source: ABdhPJxtPeOQq1Pn1Ae5Xv1UPMN/ILKfgZPrpa0CptICuNWu7dvVV2HkVJwgEEZQcuPZyY8YjfDuGA==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr78636wrq.11.1606247052702;
 Tue, 24 Nov 2020 11:44:12 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:12 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 11/40] drm/amd/amdgpu/psp_v11_0: Make local function
 'psp_v11_0_wait_for_bootloader()' static
Date: Tue, 24 Nov 2020 19:37:55 +0000
Message-Id: <20201124193824.1118741-12-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMV8wLmM6MjIzOjU6IHdhcm5pbmc6IG5vIHByZXZp
b3VzIHByb3RvdHlwZSBmb3Ig4oCYcHNwX3YxMV8wX3dhaXRfZm9yX2Jvb3Rsb2FkZXLigJkgWy1X
bWlzc2luZy1wcm90b3R5cGVzXQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8
ZGFuaWVsQGZmd2xsLmNoPgpDYzogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
PgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYyB8IDIgKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvcHNwX3YxMV8wLmMKaW5kZXggZWRkMmQ2YmQxZDg2YS4uYmQ0MjQ4Yzkz
YzQ5ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMV8wLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMV8wLmMKQEAgLTIyMCw3ICsy
MjAsNyBAQCBzdGF0aWMgaW50IHBzcF92MTFfMF9pbml0X21pY3JvY29kZShzdHJ1Y3QgcHNwX2Nv
bnRleHQgKnBzcCkKIAlyZXR1cm4gZXJyOwogfQogCi1pbnQgcHNwX3YxMV8wX3dhaXRfZm9yX2Jv
b3Rsb2FkZXIoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCitzdGF0aWMgaW50IHBzcF92MTFfMF93
YWl0X2Zvcl9ib290bG9hZGVyKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewogCXN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gcHNwLT5hZGV2OwogCi0tIAoyLjI1LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
