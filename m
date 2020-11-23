Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901C2C56202
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C02B20729
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uu3PFLsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C02B20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FC489FDE;
	Mon, 23 Nov 2020 13:58:16 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 524FD89683
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:20:14 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id 64so4791496wra.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HOTLquS1a42dGVr9bz1l9EZWYtJ3S+2UXgNiNnLXoLI=;
 b=Uu3PFLsVsi7flain8U5ubOSFOjf9aeein2CRsEPdGjFW3xzqfAueWWaYTJq2EtEAEb
 ENXZIBrA5guueBXUS95e0Imp78fMfwCLoliHzv8We9iHmewbcx4+02Mmpb19cHsagOvq
 9C20GI9WcfOEgnYwQRT0N4yrZP9CPUMedWD0hPbemW3gojXqYe2GelPIMFq6bR4cuuNz
 YYAGcq4Q7bML/Q+wU9YLK2q90I2unSkJle3DIxj0T2sCwO5im/7Kr6A+1AeIYKainpNp
 Sa5sIe1w5PokpQKU/89WPL/Qc+oRr82P6Ma1O7W3FiJufPYDgImWxJ9tsf1VKbXZito9
 2vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HOTLquS1a42dGVr9bz1l9EZWYtJ3S+2UXgNiNnLXoLI=;
 b=fNd6/EbqdpcScOkI3bpXt9vwN18Lf3kqGgs7Z6DKJCBrfWHHk2bdIZ+jeYC/NgOOkF
 jCIFN2G395hcXxBXMbyHaAwjYtJRo2qleGvw3DPOqu0/AXIX7ligIQ6d8BlE+VQUFJQp
 6n6uH4/K+2ag501fgL9b3P2giFWKvffSoWJPUqQbpfdM/Kx4TqlnqjVYw2z/Rjn1cuqL
 njQQal5tpxYLEQsVlHGXW5IZNRWdHusRne/vGYEJPtgz9BTS2H2riTuMyt5hDnWp6qTA
 OHNwvlviPURrE2xaDyJFPgkUBuu65pejMBqxVeJ2d+gxdQ+Db+5y9LzVGFz+mfdDO2YA
 1Wig==
X-Gm-Message-State: AOAM533D8l2kLKbKskQaukgtut32mPzRPqFzshzer/YcszZrF5xtbE3N
 +Erfvs4JQ8omIlk5i5SKuKeMqQ==
X-Google-Smtp-Source: ABdhPJzQqJOwuP10BOXdsN8wGv7anaDO5nCMhFGsDWrNNSRUZ452W4PnBjZ6V9XjfivqiECCkdrOIA==
X-Received: by 2002:adf:f441:: with SMTP id f1mr30643254wrp.225.1606130412831; 
 Mon, 23 Nov 2020 03:20:12 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:20:11 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 36/40] drm/amd/amdgpu/gmc_v7_0: Add some missing kernel-doc
 descriptions
Date: Mon, 23 Nov 2020 11:19:15 +0000
Message-Id: <20201123111919.233376-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYzo0MzM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ2ZsdXNoX3R5cGUnIG5vdCBkZXNjcmliZWQgaW4gJ2dtY192N18w
X2ZsdXNoX2dwdV90bGJfcGFzaWQnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdf
MC5jOjQzMzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYWxsX2h1Yicg
bm90IGRlc2NyaWJlZCBpbiAnZ21jX3Y3XzBfZmx1c2hfZ3B1X3RsYl9wYXNpZCcKIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmM6NDcxOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJh
bWV0ZXIgb3IgbWVtYmVyICd2bWh1Yicgbm90IGRlc2NyaWJlZCBpbiAnZ21jX3Y3XzBfZmx1c2hf
Z3B1X3RsYicKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmM6NDcxOiB3YXJu
aW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdmbHVzaF90eXBlJyBub3QgZGVzY3Jp
YmVkIGluICdnbWNfdjdfMF9mbHVzaF9ncHVfdGxiJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y3XzAuYzo3NzE6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIg
J3Bhc2lkJyBub3QgZGVzY3JpYmVkIGluICdnbWNfdjdfMF92bV9kZWNvZGVfZmF1bHQnCgpDYzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMgfCA3ICsrKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y3XzAuYwppbmRleCA4MGMxNDZkZjMzOGFhLi5mZTcxYzg5ZWNkMjZmIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMKQEAgLTQyNCw2ICs0MjQsOCBAQCBz
dGF0aWMgaW50IGdtY192N18wX21jX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAg
KgogICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgogICogQHBhc2lkOiBwYXNpZCB0byBi
ZSBmbHVzaAorICogQGZsdXNoX3R5cGU6IHVudXNlZAorICogQGFsbF9odWI6IHVudXNlZAogICoK
ICAqIEZsdXNoIHRoZSBUTEIgZm9yIHRoZSByZXF1ZXN0ZWQgcGFzaWQuCiAgKi8KQEAgLTQ2Myw3
ICs0NjUsOSBAQCBzdGF0aWMgaW50IGdtY192N18wX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAgKgogICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRl
cgogICogQHZtaWQ6IHZtIGluc3RhbmNlIHRvIGZsdXNoCi0gKgorICogQHZtaHViOiB1bnVzZWQK
KyAqIEBmbHVzaF90eXBlOiB1bnVzZWQKKyAqICoKICAqIEZsdXNoIHRoZSBUTEIgZm9yIHRoZSBy
ZXF1ZXN0ZWQgcGFnZSB0YWJsZSAoQ0lLKS4KICAqLwogc3RhdGljIHZvaWQgZ21jX3Y3XzBfZmx1
c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKQEAg
LTc2Myw2ICs3NjcsNyBAQCBzdGF0aWMgdm9pZCBnbWNfdjdfMF9nYXJ0X2Rpc2FibGUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAgKiBAc3RhdHVzOiBWTV9DT05URVhUMV9QUk9URUNUSU9O
X0ZBVUxUX1NUQVRVUyByZWdpc3RlciB2YWx1ZQogICogQGFkZHI6IFZNX0NPTlRFWFQxX1BST1RF
Q1RJT05fRkFVTFRfQUREUiByZWdpc3RlciB2YWx1ZQogICogQG1jX2NsaWVudDogVk1fQ09OVEVY
VDFfUFJPVEVDVElPTl9GQVVMVF9NQ0NMSUVOVCByZWdpc3RlciB2YWx1ZQorICogQHBhc2lkOiBk
ZWJ1ZyBsb2dnaW5nIG9ubHkgLSBubyBmdW5jdGlvbmFsIHVzZQogICoKICAqIFByaW50IGh1bWFu
IHJlYWRhYmxlIGZhdWx0IGluZm9ybWF0aW9uIChDSUspLgogICovCi0tIAoyLjI1LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
