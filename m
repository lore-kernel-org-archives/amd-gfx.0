Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB8C63777
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DF82222C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIR3eyDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DF82222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A8A6EBA3;
	Fri, 27 Nov 2020 10:14:48 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1246E6E984
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:20 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r3so2215138wrt.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lyYzloTK2PfirZ1Vnz7WwlEZaviGAn+VoMQZs9r0bNo=;
 b=WIR3eyDWyT0TNYDqtte4PXcGFnQ/Bzb+Asak+yqUlKdmVUKM+P8LwCz+pF8EULE5+/
 fZinsvtDeDUkdROR8iwoQhYwsSpfiBSnsb53I/X1vvIN1Ovi2g+yPYoMopGnxjN9F/5W
 UPpITbQrGcPw7TF5WKmjqU7aWG2LUNkXqw+rOumjd+sUPX+oNN1dZqZDXypi2Vq2jrow
 RaZzKKxoYhCq/0w8IziaR/LEYYfT53WrwsrZPhrkhCz0TAwqYXXhH6zt6pnn1UWk8B8T
 BrAWROua9zKbFRYr3mYl4639FFMoyPQbjJhykn44Qtv5NyKrcezEoXpjDYlKciQTk8fh
 bFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lyYzloTK2PfirZ1Vnz7WwlEZaviGAn+VoMQZs9r0bNo=;
 b=tKQj5eFtQBhEa6n8lYFiZWz8t/qcS+z6e43wSo5OF5bX6FOM7ZfWQn32kwtsuEd7jI
 nlxcq/hopfTZmuIZlFpkbOIxRDO+MwiGHnnpr8cH3GkQTH2v/epmFAwIhZredGy7FD7G
 p3bwE5kHUFkQgZDqDUfUswFTkjZl2/VXNSGyDekK0Xw6e0GkGTGtKIR/k7UYTwpbLzD2
 Y9ihLPW57SHPGFjVReC/wAx9Rug+IqC6jx0n436zHdaRwGbYTmBTYgwKkiR2wGfCViNC
 rqMuBptzqgfXiKu9qmuopPj1jyP0Or8xDqYOgstuThTRz8ZjPMSpI3FyR57nsZWIi79f
 p2RA==
X-Gm-Message-State: AOAM532ooFcX6sng50YI/pU9JTWowwYjodKBlLVqEEkqadv1r6k7z2cj
 mWrakTQgdL3XnNC0M7PP2EQVhg==
X-Google-Smtp-Source: ABdhPJw80r7EtghtjN7YeairyQPRFFBj+KIT/no7NYCDyVPWnHmFtcPpdt08ETrsr3m/vYxhfQc+dA==
X-Received: by 2002:a5d:668d:: with SMTP id l13mr3839571wru.279.1606398198653; 
 Thu, 26 Nov 2020 05:43:18 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:17 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 22/40] drm/amd/pm/powerplay/hwmgr/vega10_hwmgr: Remove set but
 unused variable 'result'
Date: Thu, 26 Nov 2020 13:42:22 +0000
Message-Id: <20201126134240.3214176-23-lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5j
OiBJbiBmdW5jdGlvbiDigJh2ZWdhMTBfZ2V0X3BwX3RhYmxlX2VudHJ54oCZOgogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jOjMx
MzU6Njogd2FybmluZzogdmFyaWFibGUg4oCYcmVzdWx04oCZIHNldCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNv
bT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJp
c3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9y
Zz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdt
Z3IuYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Iv
dmVnYTEwX2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92
ZWdhMTBfaHdtZ3IuYwppbmRleCA3ZWFkYTMwOThmZmNjLi5hYzg4ZjU0ODNlZjcwIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3Iu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdt
Z3IuYwpAQCAtMzEzMiwxNCArMzEzMiwxMyBAQCBzdGF0aWMgaW50IHZlZ2ExMF9nZXRfcHBfdGFi
bGVfZW50cnlfY2FsbGJhY2tfZnVuYyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogc3RhdGljIGlu
dCB2ZWdhMTBfZ2V0X3BwX3RhYmxlX2VudHJ5KHN0cnVjdCBwcF9od21nciAqaHdtZ3IsCiAJCXVu
c2lnbmVkIGxvbmcgZW50cnlfaW5kZXgsIHN0cnVjdCBwcF9wb3dlcl9zdGF0ZSAqc3RhdGUpCiB7
Ci0JaW50IHJlc3VsdDsKIAlzdHJ1Y3QgdmVnYTEwX3Bvd2VyX3N0YXRlICpwczsKIAogCXN0YXRl
LT5oYXJkd2FyZS5tYWdpYyA9IFBod1ZlZ2ExMF9NYWdpYzsKIAogCXBzID0gY2FzdF9waHdfdmVn
YTEwX3Bvd2VyX3N0YXRlKCZzdGF0ZS0+aGFyZHdhcmUpOwogCi0JcmVzdWx0ID0gdmVnYTEwX2dl
dF9wb3dlcnBsYXlfdGFibGVfZW50cnkoaHdtZ3IsIGVudHJ5X2luZGV4LCBzdGF0ZSwKKwl2ZWdh
MTBfZ2V0X3Bvd2VycGxheV90YWJsZV9lbnRyeShod21nciwgZW50cnlfaW5kZXgsIHN0YXRlLAog
CQkJdmVnYTEwX2dldF9wcF90YWJsZV9lbnRyeV9jYWxsYmFja19mdW5jKTsKIAogCS8qCi0tIAoy
LjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
