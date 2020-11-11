Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF539C5517A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426E9206FB
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6woMpmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426E9206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1856E0B9;
	Wed, 11 Nov 2020 18:45:15 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8846E0AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 18:36:02 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id s8so3478280wrw.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c/TaDkB9aPGP5jIvVTMt5uJ/KkWKg3o08L440ECaIrc=;
 b=r6woMpmmXo0Dj5775fZ4Cgbnwo1FcLxbbKcVGettNgkwJ6Cx4wfgTiVzUOZ6yjHa91
 PDuEfCvVpOvcRcswiUXZE4gg4YiSkaO4G+MOIhIJDFTP4KBjBvqLiq0DNNqICzoiFW7K
 vnX1v4/opW7uZuRGmvaWYOCdLTTwraEi8lxRBR8Po9duljYvHQJF46gFiGEtDBUWJwGv
 DrHkoqTr2dLCZEXQhmRMLTOTSwId9FnX25/MW4mzBrabNNErqk3pzrqo+Xd6pXZyl6sE
 2ULcoFWvBt9kwgAkdUKPix1fyjnL3O+cZaEVUSV5Zl0EWldvROjwGOxITtQgijDW3MkZ
 s3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c/TaDkB9aPGP5jIvVTMt5uJ/KkWKg3o08L440ECaIrc=;
 b=BVn6SZVySu/UeR1IDxspUeMY/LZvWOR6nzfDb+Eym94ySp+fSW5Y1Yt1yBv5Mu31in
 tUqHjChLnDqLaJmZ027ZFvtwRMJkmdfl+8Km/C9UVSncvDgCiJ13LeerJXBV7EToWzBV
 cXIqY/ozoi8SQi9+wkkUfhfkEEuk8FnFCPxvsiRJcLxGFlwndaZlYOj0v7CU4UbfR6zN
 ZMWF9ZlTMfn/3aH0ky+FkWeRctjVqb/IU25L5kXBoUsmHwzD/SslApu57qfkRkQCjrE2
 TQBFEVU6SY0rPXchfllZSahfzS9cgX4luvRwdU3EuSLN8mni2J7zaA7abuGb/kJCeo0p
 RP5g==
X-Gm-Message-State: AOAM533iouL382YnuND6X+B2xGuJ/5EuIW5PDHJaQHShMGl/BRQgF1Mm
 rtzw3MCgNcl5onC5KjxUEZ3csFxX+Ob902e+
X-Google-Smtp-Source: ABdhPJyY8o8gKVGXYOjDyRor39+RIHFMv2JbLl6uaiGyTOZu1dzApGW0b1xKClawnwujHmvLLUWJAw==
X-Received: by 2002:adf:e44f:: with SMTP id t15mr28375034wrm.380.1605119761005; 
 Wed, 11 Nov 2020 10:36:01 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 10:36:00 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/19] drm/radeon/si_dma: Move 'si_gpu_check_soft_reset()'s
 prototype to shared header
Date: Wed, 11 Nov 2020 18:35:34 +0000
Message-Id: <20201111183545.1756994-9-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9zaS5jOjM3Njg6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90
eXBlIGZvciDigJhzaV9ncHVfY2hlY2tfc29mdF9yZXNldOKAmSBbLVdtaXNzaW5nLXByb3RvdHlw
ZXNdCiAzNzY4IHwgdTMyIHNpX2dwdV9jaGVja19zb2Z0X3Jlc2V0KHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2KQogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpD
YzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9m
Zi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3NpLmggICAgIHwgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RtYS5j
IHwgMyArLS0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2kuaCBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vc2kuaAppbmRleCAwYTUwMThlZjE2NmUyLi5hMTc1MWFlNTYwZjAyIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmgKKysrIGIvZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9zaS5oCkBAIC0yNyw1ICsyNyw2IEBACiBzdHJ1Y3QgcmFkZW9uX2RldmljZTsKIAog
aW50IHNpX21jX2xvYWRfbWljcm9jb2RlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKK3Uz
MiBzaV9ncHVfY2hlY2tfc29mdF9yZXNldChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiAK
ICNlbmRpZiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBfX1NJX0hfXyAqLwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vc2lfZG1hLmMKaW5kZXggZDJmYTMwMmE1YmU5Zi4uNjQ1ODk3ZDFiZmMzMSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kbWEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3NpX2RtYS5jCkBAIC0yNSwxMCArMjUsOSBAQAogI2luY2x1ZGUgInJhZGVvbi5oIgog
I2luY2x1ZGUgInJhZGVvbl9hc2ljLmgiCiAjaW5jbHVkZSAicmFkZW9uX3RyYWNlLmgiCisjaW5j
bHVkZSAic2kuaCIKICNpbmNsdWRlICJzaWQuaCIKIAotdTMyIHNpX2dwdV9jaGVja19zb2Z0X3Jl
c2V0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKLQogLyoqCiAgKiBzaV9kbWFfaXNfbG9j
a3VwIC0gQ2hlY2sgaWYgdGhlIERNQSBlbmdpbmUgaXMgbG9ja2VkIHVwCiAgKgotLSAKMi4yNS4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
