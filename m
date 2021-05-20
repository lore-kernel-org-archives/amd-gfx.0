Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA1EC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992DC611BD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992DC611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EE56F469;
	Thu, 20 May 2021 12:49:17 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA70B6F41D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:10 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id q5so17383674wrs.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ORngqLW4L2zdTApLGcFRT++FkyS233QJRd+HHJUy1ZY=;
 b=OwZKFXat7QOpuAe9T/E2FnG6IWhBsxkdiaopAfAMhCSo2LU3SbsOU9JO7w72ceqS8C
 FZ9FqBXSiyasTx7FaT/iWnoyItrte5OQjvak4wHoXmVrBLWAxvpjXGgEApRHBZf8lRp0
 4ZlT4hCnoT9e8AiOqOF9Q3KeZ4cK0vIDsybkwg4673URzHQttcm2VMvZp50vWZgmndFx
 C5l9Qt8/ZJp40BVtvzY+QNgg+cQmC/mTbBy/uuZobIV47wGmvv2hzyIUBbKr557KROSa
 1u8i8WJsDmDcXFRHcPNRE27hhBJYy+FqOsVcxTcEMjZS/4o6tGNEBBvg4KjsngghfREV
 3Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ORngqLW4L2zdTApLGcFRT++FkyS233QJRd+HHJUy1ZY=;
 b=aRLwMLxyQVTio9asb4TJiuoMeeJ7O2LgQoJqn+7PA4QYNdRjE9B1Hs5nZD6iK0eruE
 177iSh6+7X3ZZyCMxKTULMMCvGyYc4qnLEK7Eb0Sd+ou7abVPklqn4kOcM8uUwk0eROz
 GC6r6/Qz2vF0CK7VHkiej01bBHXoS0vj4DrBRL/gLjseg99OzNk6v7NVIm7Zt2I2yjUG
 1TJ3IpNvyqnMplIrHHqWW6DOoksfI+asSVyiThzz2xULgZl8bPZjRokLEOZGBrRTfcGd
 HLWfu/eRaOHZMcTSnhuEYUBEiaipvNWK2q19DyvP/9v06j25tuhLqDybf87UC5PiMO+F
 quwA==
X-Gm-Message-State: AOAM533MTIMyqGMm84RU4LENQWKLmy+66336O/QashkVyW1ar6Eq54SS
 ueBcl3toryKmQLzVdW0ChbrwBcSjRfyXzQ==
X-Google-Smtp-Source: ABdhPJywahqmGqUniBXsHiwugmEi2oTc+D0Jdl2htYoDQ3fBFQRtKVzFD9Mqaj8Dp7jr9w/uo3hGqQ==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr3904749wrs.333.1621512189384; 
 Thu, 20 May 2021 05:03:09 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:08 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 17/38] drm/amd/amdgpu/dce_v6_0: Repair function name of
 'si_get_number_of_dram_channels()'
Date: Thu, 20 May 2021 13:02:27 +0100
Message-Id: <20210520120248.3464013-18-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y2XzAuYzo0Njg6IHdhcm5pbmc6IGV4cGVjdGluZyBw
cm90b3R5cGUgZm9yIGNpa19nZXRfbnVtYmVyX29mX2RyYW1fY2hhbm5lbHMoKS4gUHJvdG90eXBl
IHdhcyBmb3Igc2lfZ2V0X251bWJlcl9vZl9kcmFtX2NoYW5uZWxzKCkgaW5zdGVhZAoKQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVk
QGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogTHViZW4g
VHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZGNlX3Y2XzAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2RjZV92Nl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jCmluZGV4
IGRiY2IwOWNmODNlNjMuLmM3ODAzZGMyYjJkNTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2RjZV92Nl8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
ZGNlX3Y2XzAuYwpAQCAtNDU2LDcgKzQ1Niw3IEBAIHN0YXRpYyB2b2lkIGRjZV92Nl8wX3Byb2dy
YW1fZm10KHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlcikKIH0KIAogLyoqCi0gKiBjaWtfZ2V0
X251bWJlcl9vZl9kcmFtX2NoYW5uZWxzIC0gZ2V0IHRoZSBudW1iZXIgb2YgZHJhbSBjaGFubmVs
cworICogc2lfZ2V0X251bWJlcl9vZl9kcmFtX2NoYW5uZWxzIC0gZ2V0IHRoZSBudW1iZXIgb2Yg
ZHJhbSBjaGFubmVscwogICoKICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKICAqCi0t
IAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
