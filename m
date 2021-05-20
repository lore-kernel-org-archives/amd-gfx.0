Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96B6C43460
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8635061001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8635061001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17AA96F455;
	Thu, 20 May 2021 12:49:12 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E4936F414
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:05 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id u133so9024615wmg.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X5sw4AF7XegGlkCLbUkHlKVD/9b0ngx4FCn81/fMRTw=;
 b=ksOBWl5tUNwe2AcCRFDXtFTwh3WcnrwIVTy4i2oBgCXno9jjdWp/XD6S8ubPm3p6G8
 egyngHGEAXetidUWukGeEGKRoxrHehVNUujwL5UZaJXJM/ujGV8GWbx+fsWk5zk1yvB7
 FZ7J8mU2JWiDEe6oEXLSL21YmyI9LN+k7Kjkb/11Qy49SEbRUVsKBJ37qENvdOJRZKL2
 BNLlgLJJTf/3kYZkL8yy9GP6Lj8K4Nq3roKE/fjJ7b5LSSkQFEotJBMIx5MBWf15wEnH
 I+MnL828LxfDCMygyT7WpszFes9K6itFg+Gm8fCJsCOpyneL2IezTNfHMizJD+jIPe5j
 UM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X5sw4AF7XegGlkCLbUkHlKVD/9b0ngx4FCn81/fMRTw=;
 b=XVPsuErJe4EFkOzYTSdy99JOMx91RhX3e58xlfxIanNN0gdnwjc1rQJ/+IsF+o/jYq
 0PjMbpdJ/wCFTy4vlHjKPu6gL7fsoyOOhK8avVkycBUh0jVsBB/K+7FEUgbILKJCbLjg
 pZI0MdcVfcBP7D4C68wfBMMo+Ikgr6vy4kUNmDGY2M9jSSi7KnHzYP74fNIWMzUQkjei
 VHT2Pk3mXh/lH8VqW1HuzJcKGk+eZIN3tHdxNKUHbj6UVVqLaHL0w1g3CD+mn+NU6J9h
 RNNZq+f9cEVkLBEhL0jsAYnCUuEBV6pry8IIa4HwP+U39pRhNqggeKYNVTCp8KMK6Mbh
 kGQg==
X-Gm-Message-State: AOAM531v85Jmdq+wdEvwS2NLTt7XqeVpAv5ewcKfUhfSGTCF89afkg8d
 ago8F/ec2z+Kcoa+dJYvkFff5w==
X-Google-Smtp-Source: ABdhPJytwId7vCW32UE4+OALKLTHqn8gKfwODyoIgV/xjaR47aJ4cs0jn84xEkBWDkNWVdXHbHxY0A==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr3314880wmq.138.1621512184229; 
 Thu, 20 May 2021 05:03:04 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:03 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 12/38] drm/amd/amdgpu/amdgpu_gmc: Fix a little naming related
 doc-rot
Date: Thu, 20 May 2021 13:02:22 +0100
Message-Id: <20210520120248.3464013-13-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jOjQ4Nzogd2FybmluZzogZXhwZWN0aW5n
IHByb3RvdHlwZSBmb3IgYW1kZ3B1X3Rtel9zZXQoKS4gUHJvdG90eXBlIHdhcyBmb3IgYW1kZ3B1
X2dtY190bXpfc2V0KCkgaW5zdGVhZAogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dtYy5jOjUzMzogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgYW1kZ3B1X25vcmV0
cnlfc2V0KCkuIFByb3RvdHlwZSB3YXMgZm9yIGFtZGdwdV9nbWNfbm9yZXRyeV9zZXQoKSBpbnN0
ZWFkCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNo
cmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJs
aWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8u
b3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8IDQgKyst
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKaW5kZXggYTEyOWVjYzczODY5My4uNThm
ZWIwYTQyMmMzNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dtYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwpAQCAt
NTI4LDcgKzUyOCw3IEBAIGludCBhbWRncHVfZ21jX2FsbG9jYXRlX3ZtX2ludl9lbmcoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB9CiAKIC8qKgotICogYW1kZ3B1X3Rtel9zZXQgLS0gY2hl
Y2sgYW5kIHNldCBpZiBhIGRldmljZSBzdXBwb3J0cyBUTVoKKyAqIGFtZGdwdV9nbWNfdG16X3Nl
dCAtLSBjaGVjayBhbmQgc2V0IGlmIGEgZGV2aWNlIHN1cHBvcnRzIFRNWgogICogQGFkZXY6IGFt
ZGdwdV9kZXZpY2UgcG9pbnRlcgogICoKICAqIENoZWNrIGFuZCBzZXQgaWYgYW4gdGhlIGRldmlj
ZSBAYWRldiBzdXBwb3J0cyBUcnVzdGVkIE1lbW9yeQpAQCAtNTc0LDcgKzU3NCw3IEBAIHZvaWQg
YW1kZ3B1X2dtY190bXpfc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogfQogCiAvKioK
LSAqIGFtZGdwdV9ub3JldHJ5X3NldCAtLSBzZXQgcGVyIGFzaWMgbm9yZXRyeSBkZWZhdWx0cwor
ICogYW1kZ3B1X2dtY19ub3JldHJ5X3NldCAtLSBzZXQgcGVyIGFzaWMgbm9yZXRyeSBkZWZhdWx0
cwogICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgogICoKICAqIFNldCBhIHBlciBhc2lj
IGRlZmF1bHQgZm9yIHRoZSBuby1yZXRyeSBwYXJhbWV0ZXIuCi0tIAoyLjMxLjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
