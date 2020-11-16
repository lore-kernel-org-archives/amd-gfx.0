Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66134C55ABD
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192A42225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfvsLkNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192A42225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B375A6E0CB;
	Mon, 16 Nov 2020 19:18:13 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC33289FA6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:30:19 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 23so19579212wrc.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oQB5rAR+1+kEveAEir1T88yOeq9CZP66J4NDJ9xsMf8=;
 b=qfvsLkNfBDVcez+mP8sjEQQ2PAy0RRLcrkAePUGE8FPOg5SROKwYV7r3WaEAHsSl8q
 82z1+lEhHRxnJWYkIyDvOV/SBBEbIZ5LXw4FQCkFeL6yTqDc0iJ7p3uHVcgvkWj/1K3p
 llSlffDSlSjk49XcQEMEPFfawSiO6P0lomMGwzZcl6YyrchqtiH15P9BE1jRABqhPS94
 2oJz4PH9Vn3t5KP+9FtHMqRMCa1vPMBe5ituVb9WjxKv4gixjTE4YNYnMDSgRXv5ryhX
 bInIpfnWVcgCL0dV3+zAS9swCq7gx/SrASVAc85BqnKz23zIrOuI4k5cV7JITZ5yyeTo
 +FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oQB5rAR+1+kEveAEir1T88yOeq9CZP66J4NDJ9xsMf8=;
 b=st34+eps2grwwrJaF6p9Op81K2zg7UbZSyiIT7OflN9YE+57KpwAgPgFT/vZIfaoRx
 RD8Ji187saR8D17arKQDmtgswjm3Zx6ACHS/iZvYxEeZt6vBrlf3XwoPKR1W8hk1wXEF
 IzZ0n1XJxUPSV0kCWsFOnb3+cyT6Fm8Wi6FYGpSqEPxMYLvDWjnXTn675mZ15csxWKYx
 DJ8usZ8WwtUKpk1NcxWNnWS0ERu9wQrzD7GKE12Bto7mlX0AmbLjJSCBQhxN7cc7P52I
 acO/FBOqrZ4jYTN19PZF7lptcDkwZYUiX4bvanB+6oF3zPOtWkwv/gtCl/18RBqLirAv
 FHaw==
X-Gm-Message-State: AOAM533TB8Fbl2QKs67cW5zigShrjYC60iPAIZngb5PwDLwrCeZuPo/B
 9L4zm2Xlk2CDrx8lI5RkuEnfWg==
X-Google-Smtp-Source: ABdhPJx67FcvrUuJao/V/YluYnVebJQCRA/5ZbDROAXO4liKX3AvUnuGTXJX2Cwa9GTXjayZxyA4Sw==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr3868933wrt.308.1605547818474; 
 Mon, 16 Nov 2020 09:30:18 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:30:17 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/43] drm/radeon/radeon_legacy_encoders: Move
 'radeon_add_legacy_encoder's prototype to shared location
Date: Mon, 16 Nov 2020 17:29:29 +0000
Message-Id: <20201116173005.1825880-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173005.1825880-1-lee.jones@linaro.org>
References: <20201116173005.1825880-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:12 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fbGVnYWN5X2VuY29kZXJzLmM6MTc0NjoxOiB3YXJuaW5n
OiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl9hZGRfbGVnYWN5X2VuY29kZXLi
gJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogMTc0NiB8IHJhZGVvbl9hZGRfbGVnYWN5X2VuY29k
ZXIoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdWludDMyX3QgZW5jb2Rlcl9lbnVtLCB1aW50MzJf
dCBzdXBwb3J0ZWRfZGV2aWNlKQogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpDYzogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7Zu
aWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRA
bGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBT
ZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1l
ZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYyAgICAgICAgfCA2ICstLS0tLQogZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY29tYmlvcy5jICAgICAgICAgfCA2ICstLS0tLQog
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fbGVnYWN5X2VuY29kZXJzLmggfCAyICsrCiAz
IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmMKaW5kZXggNzFiZjJlZDE3MjY5Ny4uY2M4
MDY1MWIyNTc3MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRv
bWJpb3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5jCkBA
IC0zNSwxNiArMzUsMTIgQEAKICNpbmNsdWRlICJhdG9tLWJpdHMuaCIKICNpbmNsdWRlICJyYWRl
b25fYXNpYy5oIgogI2luY2x1ZGUgInJhZGVvbl9hdG9tYmlvcy5oIgorI2luY2x1ZGUgInJhZGVv
bl9sZWdhY3lfZW5jb2RlcnMuaCIKIAogZXh0ZXJuIHZvaWQKIHJhZGVvbl9hZGRfYXRvbV9lbmNv
ZGVyKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVpbnQzMl90IGVuY29kZXJfZW51bSwKIAkJCXVp
bnQzMl90IHN1cHBvcnRlZF9kZXZpY2UsIHUxNiBjYXBzKTsKIAotLyogZnJvbSByYWRlb25fbGVn
YWN5X2VuY29kZXIuYyAqLwotZXh0ZXJuIHZvaWQKLXJhZGVvbl9hZGRfbGVnYWN5X2VuY29kZXIo
c3RydWN0IGRybV9kZXZpY2UgKmRldiwgdWludDMyX3QgZW5jb2Rlcl9lbnVtLAotCQkJICB1aW50
MzJfdCBzdXBwb3J0ZWRfZGV2aWNlKTsKLQogdW5pb24gYXRvbV9zdXBwb3J0ZWRfZGV2aWNlcyB7
CiAJc3RydWN0IF9BVE9NX1NVUFBPUlRFRF9ERVZJQ0VTX0lORk8gaW5mbzsKIAlzdHJ1Y3QgX0FU
T01fU1VQUE9SVEVEX0RFVklDRVNfSU5GT18yIGluZm9fMjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2NvbWJpb3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX2NvbWJpb3MuYwppbmRleCBkM2MwNGRmN2U3NWQ3Li5mZjIxMzUwNTljMDcxIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jb21iaW9zLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY29tYmlvcy5jCkBAIC0zMSw2ICszMSw3IEBACiAj
aW5jbHVkZSA8ZHJtL3JhZGVvbl9kcm0uaD4KIAogI2luY2x1ZGUgInJhZGVvbi5oIgorI2luY2x1
ZGUgInJhZGVvbl9sZWdhY3lfZW5jb2RlcnMuaCIKICNpbmNsdWRlICJhdG9tLmgiCiAKICNpZmRl
ZiBDT05GSUdfUFBDX1BNQUMKQEAgLTQwLDExICs0MSw2IEBACiAjaW5jbHVkZSA8YXNtL3Byb20u
aD4KICNlbmRpZiAvKiBDT05GSUdfUFBDX1BNQUMgKi8KIAotLyogZnJvbSByYWRlb25fbGVnYWN5
X2VuY29kZXIuYyAqLwotZXh0ZXJuIHZvaWQKLXJhZGVvbl9hZGRfbGVnYWN5X2VuY29kZXIoc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwgdWludDMyX3QgZW5jb2Rlcl9lbnVtLAotCQkJICB1aW50MzJf
dCBzdXBwb3J0ZWRfZGV2aWNlKTsKLQogLyogb2xkIGxlZ2FjeSBBVEkgQklPUyByb3V0aW5lcyAq
LwogCiAvKiBDT01CSU9TIHRhYmxlIG9mZnNldHMgKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2xlZ2FjeV9lbmNvZGVycy5oIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fbGVnYWN5X2VuY29kZXJzLmgKaW5kZXggYTgwYjM4NzU1OWQ0ZC4uZjRjNzQz
MjI2N2U2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fbGVnYWN5
X2VuY29kZXJzLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fbGVnYWN5X2Vu
Y29kZXJzLmgKQEAgLTMwLDUgKzMwLDcgQEAKIAogdm9pZCByYWRlb25fbGVnYWN5X2JhY2tsaWdo
dF9pbml0KHN0cnVjdCByYWRlb25fZW5jb2RlciAqcmFkZW9uX2VuY29kZXIsCiAJCQkJICBzdHJ1
Y3QgZHJtX2Nvbm5lY3RvciAqZHJtX2Nvbm5lY3Rvcik7Cit2b2lkIHJhZGVvbl9hZGRfbGVnYWN5
X2VuY29kZXIoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdWludDMyX3QgZW5jb2Rlcl9lbnVtLAor
CQkJICAgICAgIHVpbnQzMl90IHN1cHBvcnRlZF9kZXZpY2UpOwogCiAjZW5kaWYJCQkJLyogX19S
QURFT05fTEVHQUNZX0VOQ09ERVJTX0hfXyAqLwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
