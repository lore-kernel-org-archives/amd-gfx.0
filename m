Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED8C56202
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAE820702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmCfHxZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAE820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5618B89E32;
	Mon, 23 Nov 2020 13:58:02 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA19C6E09F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:19:25 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id p8so18210369wrx.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yZm3HjDLtuJtZU/XUCLzOUL6uLBwe5Uw6r19LFGVc9A=;
 b=bmCfHxZJ1vAkBYRpM/TJqbpjN3yQIiw6Ll3iX6wkxuI8OSLnT++wMOyhXAGOSa207/
 9dmUzZzcImyF/HxDtNRp2NJrhQErZx/29kkI/jQGOz4eqGgCj5IxH78nRIxI8GLLRvA7
 Xqgljx5855/GXYD9i/gx+o6tTuHJARHSzgqwjIF6Mfru8W2jm8mGAS2XywvDyVEvDIdN
 HuLEtfpKLBl5gXhF/mTVbf/GDxRZB0aWa1LmYe0k+Dw2hcQkRexBQ5viKK6mcu32KzCh
 XDqYcnQowCiNtR9Xm1JT/hOf6PDs4eU3SmxURpKV2V/CY2HYB4beM2egWgC8qFK2SHAl
 k8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yZm3HjDLtuJtZU/XUCLzOUL6uLBwe5Uw6r19LFGVc9A=;
 b=LE2GLtU/mKRcHgzENpuTttxWYMIH7ok0kgh/co5T/5InACnpEeuMBsc9u4jBpcqZWh
 PQXF3+dZ8ocUh4v5mLoA7vYWHfPT6qfACbtTwoieRx7ilXzkRjsLV1WihEQzX+ErW+PI
 Y+1AFE8cp7ZuOw48tGefy/tso3ra4tLWu1zy9Hvbffcn+u2BRBTbGdV9m0IaWILQaXSD
 ma63zQmWGvyi/LV9ZcjzmRs5XKcBz22fP7mSJLDERJWldj1vUqBPNXqAZTEKInhKUWnn
 5lnazsaQhG14Gfpm+xGViNaNML4I0Cgvvdb3WF9s+cgDRr/N0jqp0YJANdsAWg1hce96
 kTNA==
X-Gm-Message-State: AOAM530+UFteWoyeiHVSWlsYJzMJYGXvTuwnJM31k6ISRqOznM2FkvnS
 uFDvTmF7+YiSB7owOmzbHdVFLw==
X-Google-Smtp-Source: ABdhPJxPBCZyllGUhZ7EDFlbon05niAgISM1TfU092j3FBydqizzyNzorBFzF6SxdKtD3NZF4RiAJg==
X-Received: by 2002:adf:fa10:: with SMTP id m16mr29521329wrr.194.1606130364573; 
 Mon, 23 Nov 2020 03:19:24 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:19:23 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 01/40] drm/radeon/radeon_device: Consume our own header where
 the prototypes are located
Date: Mon, 23 Nov 2020 11:18:40 +0000
Message-Id: <20201123111919.233376-2-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNlLmM6NjM3OjY6IHdhcm5pbmc6IG5vIHByZXZp
b3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2RldmljZV9pc192aXJ0dWFs4oCZIFstV21pc3Np
bmctcHJvdG90eXBlc10KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6
IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNl
LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fZGV2aWNlLmMKaW5kZXggN2YzODRmZmU4NDhhNy4uYWQ1NzJmOTY1MTkwYiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNlLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNlLmMKQEAgLTQyLDYgKzQyLDcgQEAK
ICNpbmNsdWRlIDxkcm0vZHJtX3Byb2JlX2hlbHBlci5oPgogI2luY2x1ZGUgPGRybS9yYWRlb25f
ZHJtLmg+CiAKKyNpbmNsdWRlICJyYWRlb25fZGV2aWNlLmgiCiAjaW5jbHVkZSAicmFkZW9uX3Jl
Zy5oIgogI2luY2x1ZGUgInJhZGVvbi5oIgogI2luY2x1ZGUgImF0b20uaCIKLS0gCjIuMjUuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
