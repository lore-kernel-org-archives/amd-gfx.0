Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DF2C64E7C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E12206CA
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhdPMGyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E12206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DDD56EBA0;
	Fri, 27 Nov 2020 10:14:35 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 932C66E99F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:44 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z7so2202063wrn.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SMoItuxgDP7ogQHGcYXarl4I2+ROLy8sCFsG16Aywwg=;
 b=OhdPMGyIXHI+TAj6MaIkGlRL9xzZ4qWRyHui4ZR+pMaQ/MzD27wZVVBTfPeDNog00z
 NN3tcAMPCRSSI/h4caCGAL300/4COFpkwzh6agGGfqN6hncmMlw7j3PtU1UxqxkVKqBE
 Kx3u4BG3SofRKVYlqmEaqTRm47XrknFaSfZkn154BEgBa3g0vXg3i9GxIwnJtSkCCz/0
 pGce+BNmaLjB3fcPjyUNY78xB8MCxdDrxEoi5L65AvoElMM8WTdbh9XaC/bhHhuDsllP
 K3czuao4DwqdPvDwxO4w9U/WhJUFgfC5xxn/gW6UHrM8Dmb5UvG/rLxaxLiMBCsgc1e8
 uVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SMoItuxgDP7ogQHGcYXarl4I2+ROLy8sCFsG16Aywwg=;
 b=h+my8DVgRf8IIuDy9Yv/2qkULv+cjPOzkusXSG90C7Dh7pIizYSyZWInqDj9XOQgDu
 oWKBwYG25eeS3yn6fP3eBmV6+ovdDs9XHd5iFuGw3hmExEiDWB6dhtPe7i1s5FISz5Wo
 1CbF+UKKLZVDWojFBBVv2rTkCqmMA0WC6ONk8XnRIYtExaOLaSMS+IDpkAmgQuNwvh3i
 zBvcu6NdLM4xD9pboJu3WZ7s9zhgk/Yxl0CXnwkmswF395eLnHhkE7dplKLM1399wApF
 WMYMuqO7eQXw5zHcu6s4edmurR7V4Y9TQGiXNiFoCmFGqKtFMYE+lUCcx5X7CKUJ22A0
 kwhw==
X-Gm-Message-State: AOAM531jYnLXdD6YcXcn2YgRCXigZJLiFgycAWVTYGGMLy8Q7GxcIAIb
 FELylKE5sp0qrgfRvAQzWn1I5A==
X-Google-Smtp-Source: ABdhPJxxfxoPWMWdyUpDsvOcaHaUFvY3HIue0Wl7PPH2WdJaCaoaw6b0nF5iFH992zGsvfRMtwCqXw==
X-Received: by 2002:adf:fc01:: with SMTP id i1mr4133125wrr.250.1606398223218; 
 Thu, 26 Nov 2020 05:43:43 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:42 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 40/40] drm/amd/display/dc/basics/vector: Make local function
 'dal_vector_presized_costruct' static
Date: Thu, 26 Nov 2020 13:42:40 +0000
Message-Id: <20201126134240.3214176-41-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iYXNpY3MvdmVjdG9yLmM6NTU6Njog
d2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkYWxfdmVjdG9yX3ByZXNpemVk
X2Nvc3RydWN04oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KCkNjOiBIYXJyeSBXZW50bGFuZCA8
aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlh
biBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvdmVjdG9yLmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNzL3ZlY3Rvci5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jhc2ljcy92ZWN0b3IuYwppbmRleCA4ZjkzZDI1
ZjkxZWUyLi43MDZjODAzYzRkM2IwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvYmFzaWNzL3ZlY3Rvci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9iYXNpY3MvdmVjdG9yLmMKQEAgLTUyLDcgKzUyLDcgQEAgYm9vbCBkYWxfdmVjdG9yX2Nv
bnN0cnVjdCgKIAlyZXR1cm4gdHJ1ZTsKIH0KIAotYm9vbCBkYWxfdmVjdG9yX3ByZXNpemVkX2Nv
c3RydWN0KAorc3RhdGljIGJvb2wgZGFsX3ZlY3Rvcl9wcmVzaXplZF9jb3N0cnVjdCgKIAlzdHJ1
Y3QgdmVjdG9yICp2ZWN0b3IsCiAJc3RydWN0IGRjX2NvbnRleHQgKmN0eCwKIAl1aW50MzJfdCBj
b3VudCwKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
