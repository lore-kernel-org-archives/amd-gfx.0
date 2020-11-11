Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A41C5517A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7A220659
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwSfZcUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7A220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DBB16E0C8;
	Wed, 11 Nov 2020 18:45:16 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DCA6E0D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 18:35:58 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a3so3234614wmb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 10:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3URZpu7tsjM6Y8F+U84uwe7BiqZoOF3VMCws5wVhmBo=;
 b=NwSfZcUBkZP1B3bjdQpFGUbvYxY2on6Vnsld+oALrNLXef2TBlHsg9YkXO7WHGcLx9
 bGcznb7awz7rQ7aaQR5UX0KF45TaerbkAayc+4dVR5LhAMdv1ILTvGbbBLPii3oga4rz
 532wAYa4d9W06NIt3THXNul+qgEaZOA8jGQ9XNKjwRsjUWof8uq3GZ8p/h3MwP3TebSR
 RlnyfgsYbd3/wDW9TWSGaEjL4q2ACna09McJCVHevo90DxkZh3hqnNbVh2ed2ClFb8hi
 rhtJ8kFUsggqFT8wgGvXYnGhEklNgHV5ahw7FUzJndF+c/JKaMIGqKwfEAU55BsxMUxe
 1Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3URZpu7tsjM6Y8F+U84uwe7BiqZoOF3VMCws5wVhmBo=;
 b=uRr7djP8WOTYsg0Zm26FLXv2lJ4yK8ICBJHchbZdLDlnM5cdSM4Znq9LltpyxIcOo2
 UeOmZfhfN1AnYbUvzeunz9oSj0xjAjgJISkBswzHzqMeCInm1x+fiIaGlVgpVhNvVKVq
 vS0eIs8TynzgfSstsW4dbKxw6Zlh8a9jSZO7zZNDhl25zGidNBU+NSk7C+/24UV97dz4
 j3yiUjozC++dTeJLPvOEIr7eRdke+XL2qW+iCfdgyt9GqKO8m1nC5D9ZBuK65pmFi4sZ
 53Il2Eg+njBc2gy5NXRvVuiXutPZzJn3SRGtSKkeMbgpi+OPB28F0yoGa7jK12OceAjz
 G0Lw==
X-Gm-Message-State: AOAM532mKyihPukJ4CGspRYSQh//6MDVzMG/ZYv3ImHcZQurU0qg4q2h
 xJaDQGajef8/eXgb8icUwEcOAw==
X-Google-Smtp-Source: ABdhPJwmiXHWCPlzC64u5QHSfF1ooLmZ1m+KcXjnM8pPY7ckYvdq1Z9fUR0fYEQtGUA7Xw0zU7S8Tg==
X-Received: by 2002:a1c:1f05:: with SMTP id f5mr5424835wmf.98.1605119756738;
 Wed, 11 Nov 2020 10:35:56 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 10:35:56 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 05/19] drm/radeon/radeon_encoders: Move
 'radeon_atom_backlight_init's prototype to shared header
Date: Wed, 11 Nov 2020 18:35:31 +0000
Message-Id: <20201111183545.1756994-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111183545.1756994-1-lee.jones@linaro.org>
References: <20201111183545.1756994-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Nov 2020 18:45:15 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19lbmNvZGVycy5jOjE4Njo2OiB3YXJuaW5nOiBubyBw
cmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl9hdG9tX2JhY2tsaWdodF9pbml04oCZIFst
V21pc3NpbmctcHJvdG90eXBlc10KIDE4NiB8IHZvaWQgcmFkZW9uX2F0b21fYmFja2xpZ2h0X2lu
aXQoc3RydWN0IHJhZGVvbl9lbmNvZGVyICpyYWRlb25fZW5jb2RlciwKIHwgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6
IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJp
b3MuaCB8IDQgKysrKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZW5jb2RlcnMuYyB8
IDYgKy0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5o
IGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuaAppbmRleCBhODk1YTcw
MDJjM2QzLi5mZDAzNzU1ZTZmYTJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9hdG9tYmlvcy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0
b21iaW9zLmgKQEAgLTI4LDE0ICsyOCwxOCBAQAogI2lmbmRlZiBfX1JBREVPTl9BVE9NQklPU19I
X18KICNkZWZpbmUgX19SQURFT05fQVRPTUJJT1NfSF9fCiAKK3N0cnVjdCBkcm1fY29ubmVjdG9y
Owogc3RydWN0IGRybV9kZXZpY2U7CiBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZTsKIHN0cnVjdCBy
YWRlb25fZGV2aWNlOworc3RydWN0IHJhZGVvbl9lbmNvZGVyOwogCiBib29sIHJhZGVvbl9hdG9t
X2dldF90dl90aW1pbmdzKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgaW5kZXgsCiAJ
CQkJc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKm1vZGUpOwogdm9pZCByYWRlb25fYWRkX2F0b21f
ZW5jb2RlcihzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1aW50MzJfdCBlbmNvZGVyX2VudW0sCiAJ
CQkgICAgIHVpbnQzMl90IHN1cHBvcnRlZF9kZXZpY2UsIHUxNiBjYXBzKTsKK3ZvaWQgcmFkZW9u
X2F0b21fYmFja2xpZ2h0X2luaXQoc3RydWN0IHJhZGVvbl9lbmNvZGVyICpyYWRlb25fZW5jb2Rl
ciwKKwkJCQlzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqZHJtX2Nvbm5lY3Rvcik7CiAKIAogI2VuZGlm
ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIF9fUkFERU9OX0FUT01CSU9TX0hfXyAqLwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZW5jb2RlcnMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2VuY29kZXJzLmMKaW5kZXggYjYwYTM3M2QzZWFkMy4u
NDY1NDlkNTE3OWVlOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
ZW5jb2RlcnMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9lbmNvZGVycy5j
CkBAIC0zMSwxNCArMzEsMTAgQEAKICNpbmNsdWRlIDxkcm0vcmFkZW9uX2RybS5oPgogCiAjaW5j
bHVkZSAicmFkZW9uLmgiCisjaW5jbHVkZSAicmFkZW9uX2F0b21iaW9zLmgiCiAjaW5jbHVkZSAi
cmFkZW9uX2xlZ2FjeV9lbmNvZGVycy5oIgogI2luY2x1ZGUgImF0b20uaCIKIAotZXh0ZXJuIHZv
aWQKLXJhZGVvbl9hdG9tX2JhY2tsaWdodF9pbml0KHN0cnVjdCByYWRlb25fZW5jb2RlciAqcmFk
ZW9uX2VuY29kZXIsCi0JCQkgICBzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqZHJtX2Nvbm5lY3Rvcik7
Ci0KLQogc3RhdGljIHVpbnQzMl90IHJhZGVvbl9lbmNvZGVyX2Nsb25lcyhzdHJ1Y3QgZHJtX2Vu
Y29kZXIgKmVuY29kZXIpCiB7CiAJc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IGVuY29kZXItPmRl
djsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
