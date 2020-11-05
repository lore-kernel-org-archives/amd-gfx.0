Return-Path: <SRS0=AVpe=EL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37BFC5517A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 15:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFA920782
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 15:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfiAsdlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFA920782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC2E6EDA8;
	Thu,  5 Nov 2020 15:41:06 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470506EDA4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2020 14:52:38 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 33so2090443wrl.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2020 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aFGC0ytSE2C9dt0H5Lm6tpZnXpH56uqHjPZdDctt26w=;
 b=wfiAsdlt6epXo2Z0lyQ2vFG5VIANzrYi7k+Kj7DSPrq0Wlu7lE/C7PyBaDtKnFt5W3
 ss6q9w+fsheDQAj9Qg22QH+HM8yU1kpflALNQwljtfRtDwIlCCGravQG8EHFfj/kpG1Y
 FEzypD0aYD9XfDVxFcUTqvOQu5NR5igeobiejNnTe3Idb/HE8ochjkpI+47Yygo0GaRN
 7aeAWTVLBX8UdQbRzfNLEcs84NSw+tI8FIqPamYKU2xJ2J2QG9/PsJHOthgrZI8DXhnq
 eYE1IUn/Dky5zKBZjcjsHDXk7MpSiXTc/WeaJzAxEQ2MrL3ItGYCnlcRVglXawLV2AxM
 0ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aFGC0ytSE2C9dt0H5Lm6tpZnXpH56uqHjPZdDctt26w=;
 b=baOJ/hblzAK0aQdKWMDvN2ooK2PhlVXB09sXnPgBh83suC99UzyYtCodeZUbLuP42h
 fkcB8nnXiq2n3osdsZfMUbh8DhZIWpdaC1dQ/uGn1AYLR4A9lh03JXRB83ttkK+FB4rc
 k9C9Fe1mqmeNXyywuKKxvoRX501bhCZ2bLQTaVdPMeJFevOTW1CAOM/0Q6qC8QtE2U9i
 s0+8zboU7VkJYX+cuN1tGtQSXROcIcWcENqJwa8Brv+2jSa9JubmGrMtL1R50iEj+EZB
 q1Juo7lD/CpDJaAgEyJ/VpEhizbiCcxnLIpeiATi4qVa+3CLnr+A2ymMrNb0mvAbCyrw
 rNXQ==
X-Gm-Message-State: AOAM532YFNGI5K9qbp+8OBEy3dkGaMyotqYUuxvSwieYPcS1TE5DT3Rt
 dM35DGW9cmuhSoEwU5JY4YOK2w==
X-Google-Smtp-Source: ABdhPJzXmfpypPEGh1sjthrWtYAHtbC+T4FEWZkqUKOyrF6tmldqGj0XtFoQ6I7iSmVwj8o3PG+jxg==
X-Received: by 2002:adf:9150:: with SMTP id j74mr3668000wrj.57.1604587956920; 
 Thu, 05 Nov 2020 06:52:36 -0800 (PST)
Received: from dell.default ([91.110.221.242])
 by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 06:52:36 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 18/19] gpu: drm: amd: amdgpu: amdgpu: Mark global variables as
 __maybe_unused
Date: Thu,  5 Nov 2020 14:45:16 +0000
Message-Id: <20201105144517.1826692-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 05 Nov 2020 15:41:05 +0000
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

VGhlc2UgMyB2YXJpYWJsZXMgYXJlIHVzZWQgaW4gKnNvbWUqIHNvdXJjZWZpbGVzIHdoaWNoIGlu
Y2x1ZGUKYW1kZ3B1LmgsIGJ1dCBub3QgKmFsbCouICBUaGlzIGxlYWRzIHRvIGEgZmx1cnJ5IG9m
IGJ1aWxkIHdhcm5pbmdzLgoKRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6CgogZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaDo2NywK
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oOjE5ODoxOTogd2FybmluZzog4oCY
bm9fc3lzdGVtX21lbV9saW1pdOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29u
c3QtdmFyaWFibGU9XQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1Lmg6MTk3OjE5
OiB3YXJuaW5nOiDigJhkZWJ1Z19ldmljdGlvbnPigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oOjE5NjoxODogd2FybmluZzog4oCYc2NoZWRfcG9saWN54oCZIGRlZmluZWQgYnV0IG5vdCB1
c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCgogTkI6IFJlcGVhdHMgfjY1MCB0aW1lcyAt
IHNuaXBwZWQgZm9yIGJyZXZpdHkuCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVy
IDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8u
b3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGlu
YXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVl
LmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
LmggfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCmluZGV4IDE4M2IwOWQ3MWI2NGEu
LjU5Mzk3NTMwODAwNTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC0xOTMs
OSArMTkzLDkgQEAgZXh0ZXJuIGludCBzY2hlZF9wb2xpY3k7CiBleHRlcm4gYm9vbCBkZWJ1Z19l
dmljdGlvbnM7CiBleHRlcm4gYm9vbCBub19zeXN0ZW1fbWVtX2xpbWl0OwogI2Vsc2UKLXN0YXRp
YyBjb25zdCBpbnQgc2NoZWRfcG9saWN5ID0gS0ZEX1NDSEVEX1BPTElDWV9IV1M7Ci1zdGF0aWMg
Y29uc3QgYm9vbCBkZWJ1Z19ldmljdGlvbnM7IC8qID0gZmFsc2UgKi8KLXN0YXRpYyBjb25zdCBi
b29sIG5vX3N5c3RlbV9tZW1fbGltaXQ7CitzdGF0aWMgY29uc3QgaW50IF9fbWF5YmVfdW51c2Vk
IHNjaGVkX3BvbGljeSA9IEtGRF9TQ0hFRF9QT0xJQ1lfSFdTOworc3RhdGljIGNvbnN0IGJvb2wg
X19tYXliZV91bnVzZWQgZGVidWdfZXZpY3Rpb25zOyAvKiA9IGZhbHNlICovCitzdGF0aWMgY29u
c3QgYm9vbCBfX21heWJlX3VudXNlZCBub19zeXN0ZW1fbWVtX2xpbWl0OwogI2VuZGlmCiAKIGV4
dGVybiBpbnQgYW1kZ3B1X3RtejsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
