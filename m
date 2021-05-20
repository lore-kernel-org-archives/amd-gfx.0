Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F3DC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E10361001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E10361001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8986F44F;
	Thu, 20 May 2021 12:49:11 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDCCA8929F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:17 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 y184-20020a1ce1c10000b02901769b409001so5075049wmg.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+fmZglR54ll04aap/nnrS1lTMmfuDtfEf2wXqJX6PX0=;
 b=ovUuBIpidetnGOoSyQualmIn8fZ/i0UtYvGw3trII7Y8HUSva2w3aKXILZI3TNQoTq
 cGX973y1nw9iyAPD/T6ZLlSmDs6LUAvNrTbiLiqtEwiWwkegm+qkApuZZqKss6d5oeCz
 8h/YpzebuSZkEhunQpCVEDiE5fm4VjYhzR+4CXlHHGDwWwtDi5VRyt3DHu95k6ufJks3
 Snu0++kd82BETGmIUFSYJkr0kwMzPOs8qagvuxn3Klw10mKm0lW6CwjPlyhi/KHN1RDy
 dftAbTbwEIo5qNGZWjVG5hM//kJX7lDw+n1oU9wYzzfblnJKWdb6h7OhK4+tBxk1otrg
 Rn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+fmZglR54ll04aap/nnrS1lTMmfuDtfEf2wXqJX6PX0=;
 b=hCnaYiIdIsaJL7T4gqp2nWw1BKgBKSpgrNxJCrJASRnwqLnfLdZTMBM54FWjh+goS7
 mdt/NpOJC9qlN4kZbISanuwVXyVD3cfz2f9fsyjDG123rMfKiBPj72Gx8QYRCIgRHDoB
 b000ThZF71Nmm0ohzXIQ2OYLVrXVbWO5fOmj8Q9gqXG2DzWioV3e+zL/JKQNEiEvJAqq
 BS1DXDHlAP1nYhYJSUT3p0/9cUHD67OS6YkzDxWi+7LNkLYqf4V2Ij3tFmLhA1iaB178
 YWwRNiUlzT9SnH8k3SS+auI3uWKSeaGINljd79uxuS3UvGAu7B1pQH9uT+d6y6lRkApA
 RCVg==
X-Gm-Message-State: AOAM530ZtDpSAeVa9vIVUXdZC5Yf5OwrFwrVSDoRFhlynnWlSuJced2s
 O5lBq0E17lPTffcMyt9Lkq/NVA==
X-Google-Smtp-Source: ABdhPJw8kaYI5LLeHaobAMA/X+5SKA38x92KIomeDesCAADoarpEPLvyZ1HDdbjflDFVnFg5Iwu2fw==
X-Received: by 2002:a1c:6503:: with SMTP id z3mr3279429wmb.72.1621512196541;
 Thu, 20 May 2021 05:03:16 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:16 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 24/38] drm/amd/amdgpu/mmhub_v9_4: Fix naming disparity with
 'mmhub_v9_4_set_fault_enable_default()'
Date: Thu, 20 May 2021 13:02:34 +0100
Message-Id: <20210520120248.3464013-25-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jOjQ0Njogd2FybmluZzogZXhwZWN0aW5n
IHByb3RvdHlwZSBmb3IgbW1odWJfdjFfMF9zZXRfZmF1bHRfZW5hYmxlX2RlZmF1bHQoKS4gUHJv
dG90eXBlIHdhcyBmb3IgbW1odWJfdjlfNF9zZXRfZmF1bHRfZW5hYmxlX2RlZmF1bHQoKSBpbnN0
ZWFkCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNo
cmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJs
aWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8u
b3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYyB8IDIgKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYwppbmRleCA0N2M4ZGQ5ZDFjNzhlLi5jNGVmODIy
YmJlOGM1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCkBAIC00MzYs
NyArNDM2LDcgQEAgc3RhdGljIHZvaWQgbW1odWJfdjlfNF9nYXJ0X2Rpc2FibGUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiB9CiAKIC8qKgotICogbW1odWJfdjFfMF9zZXRfZmF1bHRfZW5h
YmxlX2RlZmF1bHQgLSB1cGRhdGUgR0FSVC9WTSBmYXVsdCBoYW5kbGluZworICogbW1odWJfdjlf
NF9zZXRfZmF1bHRfZW5hYmxlX2RlZmF1bHQgLSB1cGRhdGUgR0FSVC9WTSBmYXVsdCBoYW5kbGlu
ZwogICoKICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKICAqIEB2YWx1ZTogdHJ1ZSBy
ZWRpcmVjdHMgVk0gZmF1bHRzIHRvIHRoZSBkZWZhdWx0IHBhZ2UKLS0gCjIuMzEuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
