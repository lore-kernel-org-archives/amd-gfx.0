Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CD3C433E3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 13:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0F120866
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 13:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPrchpkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0F120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE1F6E9E9;
	Fri,  7 Aug 2020 13:37:04 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC23D6E9E9;
 Fri,  7 Aug 2020 13:37:03 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id r4so1702558wrx.9;
 Fri, 07 Aug 2020 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4LVGnEnOhzHJYp7k/0jPrqpIv6dziA/YJ8laLNioGFM=;
 b=vPrchpkKsG/T8AFiA7Yn7M46PLKiPZDNi/VQkH2XagE4mkxFfqePQ0DxXi+WpJ0U+R
 6+Tigj2zd0aonU/AOQBMGGxh/7cj9dH4jhH2VUrWClb3vy1rnD1tCXk42aJL1AHYH9BG
 Q4Uz5H0srLIX9r+VyELVxP9kuxiAsEbUqq9hEoDmU5/crvFK+xwDOtq3mnLgQkLKHdLX
 ZrLAMvRodPLri/9wPmrIwsmz4cFf505+ZmWsdmEO9LLOySAhCm/VB094CFm7/MxkVVh0
 h70Gf9ij6xNTbK0wO3r9fgqqJItuYk3DK8aD5rK/6yo4wsXCG5VGzupDxsUhheb284q4
 WXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4LVGnEnOhzHJYp7k/0jPrqpIv6dziA/YJ8laLNioGFM=;
 b=app3am3td3swYga6JyQU0BbERLak1SP3PV1MQunXL6kpq0Y+LwGRFWDCYVX/O1o0ok
 3BK04QUhIESLoiFce1u+C1KyQfcOzexzGrfvG4tkkfqbHK5cQVLYQE0eg9s/oLITQwDN
 GXaidbGx8K0UgEmHWEi9jRIRdQg/ogOjqqXoaJ659lKsuqmoAQ1gC0gsT1irjYzTGQE2
 7LLM/i5AlAIuBx9jtHmohoddZhx5xYNPd59QcZ1TJPtROh2H4oUdiYqrfj03C+Nur8Gk
 PXw5Z5ANnylbuo9HyY/73fnSCQWr0gnvC9szwYUSOjOHaJXJ+JqYsFg9kCSydHE+R8pq
 F8nA==
X-Gm-Message-State: AOAM531vAkbtVk8P4sM1YmojcqsUngfBKjvBRjB6cTkZqy9fVOne2D9J
 kgabhjxW/eE1khHQVMd0Sx8csQNM
X-Google-Smtp-Source: ABdhPJyy6/1Evq0AWxcj8cS24OPjPyqAVqG2TPNcf52PUYgYZc8VHPTAJXAA/0IWvQkVVjS73ndtbw==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr12856842wru.95.1596807422267; 
 Fri, 07 Aug 2020 06:37:02 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:8a1:e63e:700c:859e])
 by smtp.gmail.com with ESMTPSA id k126sm11084609wme.17.2020.08.07.06.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 06:37:01 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: adjust the pid in the grab_id trace point
Date: Fri,  7 Aug 2020 15:36:58 +0200
Message-Id: <20200807133658.1866-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807133658.1866-1-christian.koenig@amd.com>
References: <20200807133658.1866-1-christian.koenig@amd.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, daniel.vetter@ffwll.ch, Shashank.Sharma@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VHJhY2Ugc29tZXRoaW5nIHVzZWZ1bCBpbnN0ZWFkIG9mIHRoZSBwaWQgb2YgYSBrZXJuZWwgdGhy
ZWFkIGhlcmUuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNl
LmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKaW5kZXggNWRhMjBmYzE2NmQ5Li4wN2Y5OWVmNjlk
OTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5o
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCkBAIC0yMjgs
NiArMjI4LDcgQEAgVFJBQ0VfRVZFTlQoYW1kZ3B1X3ZtX2dyYWJfaWQsCiAJCQkgICAgICksCiAK
IAkgICAgVFBfZmFzdF9hc3NpZ24oCisJCQkgICBfX2VudHJ5LT5lbnQucGlkID0gdm0tPnRhc2tf
aW5mby5waWQ7CiAJCQkgICBfX2VudHJ5LT5wYXNpZCA9IHZtLT5wYXNpZDsKIAkJCSAgIF9fYXNz
aWduX3N0cihyaW5nLCByaW5nLT5uYW1lKQogCQkJICAgX19lbnRyeS0+dm1pZCA9IGpvYi0+dm1p
ZDsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
