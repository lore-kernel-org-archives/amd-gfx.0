Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF5C5517A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0DE206CB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRHbohXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0DE206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B86D89686;
	Mon,  9 Nov 2020 21:21:43 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73ED89590
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:16 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d142so939178wmd.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RmvaQQVqTzYJ/ca4PPIPDIzgTk17HpnAY5XhUH8w95U=;
 b=yRHbohXsw2QICXZKtP8ovBwjdAKlIxFQQZ0rhdvBYM4oJ5nxL/ORcz5DZJWVVZZIzN
 2/DChFnHuAKzp22e7kROw5JKDyNwVhDN23V5qieSGG16WDx6KvMRGkdsZEMniuIP7nk+
 Sb5HW0mH6htetyMcaUGgJnVqniObdZbyJiW3Ik/WG7Q/LVqaY071vIQevKfeYPRrQda/
 h/2lcchdzqK1tzNe6NjIVVe1ICyMPAqusXyXJ/4pAYjNaiAky3LshKFGFmX1HHh2LkZ2
 PSdzhquhWWOMtxj8kR90KE+YOqjwEr684dSRLXPld+Zdv6uH1lJGbb/qRzXwlwPBMggC
 ylAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RmvaQQVqTzYJ/ca4PPIPDIzgTk17HpnAY5XhUH8w95U=;
 b=EiCwLHWgds81r12HEV2tMnDT9l76CLzPScO3AQqa0yLKjPur74tmL93aB58dlE4IXS
 PXtmQMYZrAsbJzgItobttjxf/n/AA2n42TQ+vviYmOE/3T3z9+UDke7SBrQlBf/fYypp
 QiK3yqJxN7yLJNUXUX6jo70cBQI3SKdUHQvCefQm0NsUumPADXGGM+iR9e6QlSyd80pk
 WnLeALmet2QuZ9Bx6GGf+1Iox+aRtMNXG9wAe3qtskEwWvPjPSPACjJz2y7W5t6rbtic
 YFwPzbwx7VCcJ52zVTGeDXTNqfmBA81WMuxI5599s/jiMFAxE6qDAAGx0T+DHSvyTDQw
 fPIA==
X-Gm-Message-State: AOAM532MsK/5yo+V5G2LtR5DE5hWrcZx1GUncV8yBC+K6BSVdrWv+q81
 gryiC2LYv2wPJJ4hhK5VOcc2tQ==
X-Google-Smtp-Source: ABdhPJzpfrNh8azt6gGZ2jBaYLTeFKuZIomUyo4hzEGhYn1lqz7J9cTLXl66eW+SQsjVcl1+o9I3Jw==
X-Received: by 2002:a1c:9e12:: with SMTP id h18mr1132707wme.11.1604956755622; 
 Mon, 09 Nov 2020 13:19:15 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:14 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 05/20] drm/radeon: Move 'radeon_add_legacy_encoder's prototype
 to shared location
Date: Mon,  9 Nov 2020 21:18:40 +0000
Message-Id: <20201109211855.3340030-6-lee.jones@linaro.org>
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgpDYzogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7Zu
aWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRA
bGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBT
ZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1l
ZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb24uaCAgICAgICAgICB8IDIgKysKIGRyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmMgfCA1IC0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9jb21iaW9zLmMgIHwgNSAtLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oCmluZGV4IDBj
YzhmMDgxZTExM2EuLjQyMWY2YjI2NTEyZWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24uaApAQCAt
MjgxOSw2ICsyODE5LDggQEAgZXh0ZXJuIGludCByYWRlb25fY3NfcGFyc2VyX2luaXQoc3RydWN0
IHJhZGVvbl9jc19wYXJzZXIgKnAsIHZvaWQgKmRhdGEpOwogZXh0ZXJuIHZvaWQgcmFkZW9uX2xl
Z2FjeV9zZXRfY2xvY2tfZ2F0aW5nKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgZW5h
YmxlKTsKIGV4dGVybiB2b2lkIHJhZGVvbl9sZWdhY3lfYmFja2xpZ2h0X2luaXQoc3RydWN0IHJh
ZGVvbl9lbmNvZGVyICpyYWRlb25fZW5jb2RlciwKIAkJCQkJIHN0cnVjdCBkcm1fY29ubmVjdG9y
ICpkcm1fY29ubmVjdG9yKTsKK2V4dGVybiB2b2lkIHJhZGVvbl9hZGRfbGVnYWN5X2VuY29kZXIo
c3RydWN0IGRybV9kZXZpY2UgKmRldiwgdWludDMyX3QgZW5jb2Rlcl9lbnVtLAorCQkJCSAgICAg
IHVpbnQzMl90IHN1cHBvcnRlZF9kZXZpY2UpOwogZXh0ZXJuIHZvaWQgcmFkZW9uX2F0b21fc2V0
X2Nsb2NrX2dhdGluZyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgaW50IGVuYWJsZSk7CiBl
eHRlcm4gdm9pZCByYWRlb25fdHRtX3BsYWNlbWVudF9mcm9tX2RvbWFpbihzdHJ1Y3QgcmFkZW9u
X2JvICpyYm8sIHUzMiBkb21haW4pOwogZXh0ZXJuIGJvb2wgcmFkZW9uX3R0bV9ib19pc19yYWRl
b25fYm8oc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibyk7CmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fYXRvbWJpb3MuYwppbmRleCA1ZDI1OTE3MjUxODkyLi41NTc5NjBlM2IyMDRmIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmMKQEAgLTM5LDExICszOSw2
IEBAIGV4dGVybiB2b2lkCiByYWRlb25fYWRkX2F0b21fZW5jb2RlcihzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2LCB1aW50MzJfdCBlbmNvZGVyX2VudW0sCiAJCQl1aW50MzJfdCBzdXBwb3J0ZWRfZGV2
aWNlLCB1MTYgY2Fwcyk7CiAKLS8qIGZyb20gcmFkZW9uX2xlZ2FjeV9lbmNvZGVyLmMgKi8KLWV4
dGVybiB2b2lkCi1yYWRlb25fYWRkX2xlZ2FjeV9lbmNvZGVyKHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsIHVpbnQzMl90IGVuY29kZXJfZW51bSwKLQkJCSAgdWludDMyX3Qgc3VwcG9ydGVkX2Rldmlj
ZSk7Ci0KIHVuaW9uIGF0b21fc3VwcG9ydGVkX2RldmljZXMgewogCXN0cnVjdCBfQVRPTV9TVVBQ
T1JURURfREVWSUNFU19JTkZPIGluZm87CiAJc3RydWN0IF9BVE9NX1NVUFBPUlRFRF9ERVZJQ0VT
X0lORk9fMiBpbmZvXzI7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9jb21iaW9zLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jb21iaW9zLmMKaW5k
ZXggZDNjMDRkZjdlNzVkNy4uYjhjZDM3ZDc2ZDhiZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fY29tYmlvcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX2NvbWJpb3MuYwpAQCAtNDAsMTEgKzQwLDYgQEAKICNpbmNsdWRlIDxhc20vcHJvbS5o
PgogI2VuZGlmIC8qIENPTkZJR19QUENfUE1BQyAqLwogCi0vKiBmcm9tIHJhZGVvbl9sZWdhY3lf
ZW5jb2Rlci5jICovCi1leHRlcm4gdm9pZAotcmFkZW9uX2FkZF9sZWdhY3lfZW5jb2RlcihzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LCB1aW50MzJfdCBlbmNvZGVyX2VudW0sCi0JCQkgIHVpbnQzMl90
IHN1cHBvcnRlZF9kZXZpY2UpOwotCiAvKiBvbGQgbGVnYWN5IEFUSSBCSU9TIHJvdXRpbmVzICov
CiAKIC8qIENPTUJJT1MgdGFibGUgb2Zmc2V0cyAqLwotLSAKMi4yNS4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
