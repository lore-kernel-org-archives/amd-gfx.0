Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20653C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E349A60FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E349A60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF34B6ECF2;
	Wed, 26 May 2021 12:57:28 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043506E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:34 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id j14so206839wrq.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h62MLZglSk0AGZD9SfFQbGL1zDMVzymMNWcO9Y1i7ro=;
 b=c+dra2tqymbByrR6z2HiTHLfe9C2WgmOkQAwerg+mh5Ku0VofhpS6ze9r0mRMdT1pk
 YPNN+MYXY5re7Ot54h7F2ty2q32Sv75cj5GX/2/udd1GJAjJTOgt+3/dSe/MLXPMWPl2
 79kgXxCnDF5ZKW1dH0L/lEg9OFx06n3g+u+YjgGfwVTnYE5aIkCM/BJekPtCJwt7TJFf
 UKK+hgv0O3YfuIdIFq4/zxCy+xAxUwKGRUNce7rYim6Bq3v5nE5e594ckrg9YD4zogQb
 8pFVbMQwj1XN42ZhS9sIPolY4RYcrLfJBsZ5HNutOaZhToK4wA5Gj/BH3hoTn+nGoQcd
 g6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h62MLZglSk0AGZD9SfFQbGL1zDMVzymMNWcO9Y1i7ro=;
 b=qLC78uWTHnIWW0N3kBtVR7DN8OlfcPdLM8fZ4V2zno5S0W4CIpmbFjFa3SNZAM4oNb
 J0OukYxSVkrex5pPfKrYg1UAt8ZGfz1N2iPsyTf5kf7mje9bxAR5hYjoj7wDaPQf6pO4
 0ATELgnhlMGY1cw/vnueEo5Xg3xuy8D0kP/6BNJsFBveKrPj/ps90eJX3ivWaKX0/Y0g
 aef80fJSyoi8iWmLUpTG3YKTagMbWBxGkK6sXPxelcONq114z2tRmthWFVCr1Q5pgdII
 17sTxbtOX4u/Fhwp58wxU4k5vjzt3GM0dqXVJvCpYo+WhCFjj0EwNGdPgco4GjtHqhWL
 C96g==
X-Gm-Message-State: AOAM531QkF3sIIvlZVJF54z22jyoq0lBkW1RFeG8b7hET5VAY2vuzztc
 g5TRVIX7wVzz9mVZCBcDsRJ9Mg==
X-Google-Smtp-Source: ABdhPJw+uQTXVXFfDBd2HbpSytC1GfBuCnOmnN40kPlHJDAiFY1wY/yMqneN9R+wdvUhT7IzjT+Vfg==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr31780393wrt.137.1622018852634; 
 Wed, 26 May 2021 01:47:32 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:32 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 02/34] drm/amd/pm/swsmu/smu13/aldebaran_ppt: Remove unused
 variable 'ret'
Date: Wed, 26 May 2021 09:46:54 +0100
Message-Id: <20210526084726.552052-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jOiBJ
biBmdW5jdGlvbiDigJhhbGRlYmFyYW5faXNfZHBtX3J1bm5pbmfigJk6CiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmM6MTI2MDo2OiB3
YXJuaW5nOiB2YXJpYWJsZSDigJhyZXTigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0
LXNldC12YXJpYWJsZV0KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6
IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9h
bGRlYmFyYW5fcHB0LmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTMvYWxkZWJhcmFuX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUx
My9hbGRlYmFyYW5fcHB0LmMKaW5kZXggZDZjZTY2NWJhYWYzYi4uZDA3N2UyMTEwMTdhOSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0
LmMKQEAgLTEzNjgsMTAgKzEzNjgsOSBAQCBzdGF0aWMgaW50IGFsZGViYXJhbl91c3JfZWRpdF9k
cG1fdGFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGVudW0gUFBfT0RfRFBNXwogCiBzdGF0
aWMgYm9vbCBhbGRlYmFyYW5faXNfZHBtX3J1bm5pbmcoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUp
CiB7Ci0JaW50IHJldCA9IDA7CiAJdWludDMyX3QgZmVhdHVyZV9tYXNrWzJdOwogCXVuc2lnbmVk
IGxvbmcgZmVhdHVyZV9lbmFibGVkOwotCXJldCA9IHNtdV9jbW5fZ2V0X2VuYWJsZWRfbWFzayhz
bXUsIGZlYXR1cmVfbWFzaywgMik7CisJc211X2Ntbl9nZXRfZW5hYmxlZF9tYXNrKHNtdSwgZmVh
dHVyZV9tYXNrLCAyKTsKIAlmZWF0dXJlX2VuYWJsZWQgPSAodW5zaWduZWQgbG9uZykoKHVpbnQ2
NF90KWZlYXR1cmVfbWFza1swXSB8CiAJCQkJCSAgKCh1aW50NjRfdClmZWF0dXJlX21hc2tbMV0g
PDwgMzIpKTsKIAlyZXR1cm4gISEoZmVhdHVyZV9lbmFibGVkICYgU01DX0RQTV9GRUFUVVJFKTsK
LS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
