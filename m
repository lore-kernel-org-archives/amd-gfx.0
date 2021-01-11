Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C95CC4332B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0722C22B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0722C22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3280D6E0F8;
	Mon, 11 Jan 2021 19:54:48 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83A889DD5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:35 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id k10so243047wmi.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=deJgdJaEuReRAIxBvvkhhG4KqxPwTjkmLcBm6GGwPgM=;
 b=o1zswORDqJkgQ6gNl7NERNf4reA60BdU2ZMYXgFJFyEsZoX/97G3rNIhIAaBbqA7BW
 wAQihcz7N/lJ858SgzhqbfScg5rKcbAA/eIzLvb5dRZrI5oWl9oyx121Bo6pwxo3zEM8
 D365DRl87k9MBs3ir5b92oiNs+I7Aav0Zo5MWYC3Y/pQ9f3haEh5qjqvyF9PM/vQ5JJ2
 PwIP2HHcyxXUVnX/A9LIda9ej59Za2lBtPLW66k2Eoadbdw1cvSoM2LW3shjsvJup5Ah
 mNuMWNpCTVlLvSYtOynDvicygepHxRd32z39JWjhFv8Ra6ObdMdpgpcAhQNF5mN6Xv2D
 fN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=deJgdJaEuReRAIxBvvkhhG4KqxPwTjkmLcBm6GGwPgM=;
 b=Tp4k1CjoZISYLELtSEcBX0S1u4jkL3plq0moo1/ZbGCCPoHhJN/zQuwEJOZHnPET6W
 Bqboub1BwdoiJry4H/yL8wZl/4cKKyhQ/OGh3iajiHUGHZH6pBBgjFr/ozZids4DCtHp
 ig1BI36qsDe0HmVtuL2cNrS0jtunl9EIgFwPJerWdsqdIWTy+87aiRtgrKudeGkweM0g
 WTLmjg1sHFHrTmN3Hw+2+FH5J8RYdXvYjOinjA2lfXJj5OltXsIrqok/PGbwNYJ+NNEa
 Jw9ohKEIB462GayRKc0vUEwudm/M8RjS7lGCgqpBZ7WFIEXOyaD0qvfz+Feao8Kidv2O
 ALiQ==
X-Gm-Message-State: AOAM533GJ66gKaXNxCrjiYfKlAnhnYtW3clxWWTXSiQxO1zw4eUoBZSY
 wyZ9mCLMZ2wnV77tuCZCFaG8Sg==
X-Google-Smtp-Source: ABdhPJw6Hy4OeG8axIi3/IOG+PL8vkZ/xZ0G/0YFDEQt7hRGcTtISU1wy3hTTbdLWu/pHyITbgpzQQ==
X-Received: by 2002:a1c:b4c4:: with SMTP id d187mr295556wmf.38.1610392774477; 
 Mon, 11 Jan 2021 11:19:34 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:33 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 03/40] drm/amd/display/dc/gpio/hw_ddc: Remove unused variable
 'reg2'
Date: Mon, 11 Jan 2021 19:18:49 +0000
Message-Id: <20210111191926.3688443-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Jan 2021 19:54:43 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9ncGlvL2h3X2RkYy5jOiBJbiBmdW5j
dGlvbiDigJhzZXRfY29uZmln4oCZOgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9kYy9ncGlvL2h3X2RkYy5jOjExMDoxMzogd2FybmluZzogdmFyaWFibGUg4oCYcmVnMuKA
mSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQoKQ2M6IEhhcnJ5
IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxp
QGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlk
IEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZnds
bC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vaHdfZGRj
LmMgfCA3ICsrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8v
aHdfZGRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZ3Bpby9od19kZGMuYwpp
bmRleCAxYWUxNTNlYWIzMWQ3Li43YThjZWMyZDdhOTAyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZ3Bpby9od19kZGMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZ3Bpby9od19kZGMuYwpAQCAtMTA3LDEzICsxMDcsMTIgQEAgc3RhdGlj
IGVudW0gZ3Bpb19yZXN1bHQgc2V0X2NvbmZpZygKIAkJCQkJbXNsZWVwKDMpOwogCQkJfQogCQl9
IGVsc2UgewotCQkJdWludDMyX3QgcmVnMjsKIAkJCXVpbnQzMl90IHNkYV9wZF9kaXMgPSAwOwog
CQkJdWludDMyX3Qgc2NsX3BkX2RpcyA9IDA7CiAKLQkJCXJlZzIgPSBSRUdfR0VUXzIoZ3Bpby5N
QVNLX3JlZywKLQkJCQkJRENfR1BJT19TREFfUERfRElTLCAmc2RhX3BkX2RpcywKLQkJCQkJRENf
R1BJT19TQ0xfUERfRElTLCAmc2NsX3BkX2Rpcyk7CisJCQlSRUdfR0VUXzIoZ3Bpby5NQVNLX3Jl
ZywKKwkJCQkgIERDX0dQSU9fU0RBX1BEX0RJUywgJnNkYV9wZF9kaXMsCisJCQkJICBEQ19HUElP
X1NDTF9QRF9ESVMsICZzY2xfcGRfZGlzKTsKIAogCQkJaWYgKHNkYV9wZF9kaXMpIHsKIAkJCQlS
RUdfU0VUKGdwaW8uTUFTS19yZWcsIHJlZ3ZhbCwKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
