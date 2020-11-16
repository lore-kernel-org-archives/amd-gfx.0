Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6602C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23ADE2225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kH1BKC//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23ADE2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 306D16EA11;
	Mon, 16 Nov 2020 19:18:14 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948C46E09F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:54 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 10so31281wml.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RFkz09HHg8XjVV8DdlQiV5ZmST/9B9izgfFwLsHrImI=;
 b=kH1BKC//wSZb3AKFDqYNzlpJHp967MUaPmKrCtKH4g9gvuaOhCFOB+bqmmVsBfJp6Y
 IRFKDFJr0NyQzl1AeiqaSKli+a3YmpMGqWEGze33mB487RpiarUWtucYnXzoWoqpwd7A
 qx5TQJV2CDRomdZE8xN48p2tGpBgTnkL7Myt/S49GRT4zyEP2KYH/BnX8zmnLGjZnHeK
 n9uQD8axbidJE2t3gHCmX1lIn++JBHCYOpFyy2kau/q16LLE7DV2v4Ahl/3kMiCJKU76
 i60I5VMbQWJkSXUxtjztOUlRblW0zJ9D5hN7FE9Ht1Xh7QJwe0MrDRErQqC/6CA+M+BP
 u8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RFkz09HHg8XjVV8DdlQiV5ZmST/9B9izgfFwLsHrImI=;
 b=DFt///7E+bD5awOPNvd2Xy50FoI72V2Y5vaYpGN0TpzeOGtfehw6Y9C1Jf/hK3zQra
 KrY082iHh5I5EAI1Ztq2hrhYwcjjJj1SDc5wbtArrmhblPbtRg+ZzKITfJgOCzSGMjWG
 TbFjkx4lS2+a+qxFFWGwpJ5seA58DICca5waHUlfwyZA2y6xiQ/diiAYsWD4T+CZTtqt
 44odkVzljITZs8Hnzi4FFdqp4bsvPOcmglgFbjYicN6gG9Ir98+PFbu6qYL1ysmrexAN
 I9BwywNnb6pRryVHj5v2iD3kuRXzylQK5n+KJURjZPgp95NYq3ydwoDeQ7lgwTppJOXR
 NwTw==
X-Gm-Message-State: AOAM532v5KlHTK4UBDQwBbaeKp/bl5l0p1/YxpU+AZ2QG1+U4BwjFLtj
 SRfL5p0pZAbgPpsnOhmjlgQf+g==
X-Google-Smtp-Source: ABdhPJwC9/+3SUbWpobqPivqrvsp22GrpEgM9PhprEf6eKffR7Y/olS1qwqch2we9TXXEGQQPqTdiQ==
X-Received: by 2002:a1c:c203:: with SMTP id s3mr16953543wmf.77.1605548273156; 
 Mon, 16 Nov 2020 09:37:53 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:52 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 36/43] drm/radeon/evergreen: Move 'cik_*()'s prototypes to
 shared header
Date: Mon, 16 Nov 2020 17:36:53 +0000
Message-Id: <20201116173700.1830487-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9jaWsuYzo2NDEzOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3Rv
dHlwZSBmb3Ig4oCYY2lrX2luaXRfY3BfcGdfdGFibGXigJkgWy1XbWlzc2luZy1wcm90b3R5cGVz
XQogNjQxMyB8IHZvaWQgY2lrX2luaXRfY3BfcGdfdGFibGUoc3RydWN0IHJhZGVvbl9kZXZpY2Ug
KnJkZXYpCiB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+CiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Np
ay5jOjY2NzA6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhjaWtfZ2V0
X2NzYl9zaXpl4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIDY2NzAgfCB1MzIgY2lrX2dldF9j
c2Jfc2l6ZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldikKIHwgXn5+fn5+fn5+fn5+fn5+fgog
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYzo2NzAyOjY6IHdhcm5pbmc6IG5vIHByZXZpb3Vz
IHByb3RvdHlwZSBmb3Ig4oCYY2lrX2dldF9jc2JfYnVmZmVy4oCZIFstV21pc3NpbmctcHJvdG90
eXBlc10KIDY3MDIgfCB2b2lkIGNpa19nZXRfY3NiX2J1ZmZlcihzdHJ1Y3QgcmFkZW9uX2Rldmlj
ZSAqcmRldiwgdm9sYXRpbGUgdTMyICpidWZmZXIpCiB8IF5+fn5+fn5+fn5+fn5+fn5+fgoKQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5oICAgICAgIHwgMyArKysKIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vZXZlcmdyZWVuLmMgfCA1ICstLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL2Npay5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuaAppbmRleCA2NjMwYjlk
YTllN2FhLi40MjAyMDdkMTlkZTUyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L2Npay5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmgKQEAgLTMwLDUgKzMwLDgg
QEAgdm9pZCBjaWtfZXhpdF9ybGNfc2FmZV9tb2RlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2
KTsKIGludCBjaV9tY19sb2FkX21pY3JvY29kZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7
CiB2b2lkIGNpa191cGRhdGVfY2coc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIHUzMiBibG9j
aywgYm9vbCBlbmFibGUpOwogdTMyIGNpa19ncHVfY2hlY2tfc29mdF9yZXNldChzdHJ1Y3QgcmFk
ZW9uX2RldmljZSAqcmRldik7Cit2b2lkIGNpa19pbml0X2NwX3BnX3RhYmxlKHN0cnVjdCByYWRl
b25fZGV2aWNlICpyZGV2KTsKK3UzMiBjaWtfZ2V0X2NzYl9zaXplKHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2KTsKK3ZvaWQgY2lrX2dldF9jc2JfYnVmZmVyKHN0cnVjdCByYWRlb25fZGV2aWNl
ICpyZGV2LCB2b2xhdGlsZSB1MzIgKmJ1ZmZlcik7CiAKICNlbmRpZiAgICAgICAgICAgICAgICAg
ICAgICAgICAvKiBfX0NJS19IX18gKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vZXZlcmdyZWVuLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbi5jCmluZGV4
IDQ1NzVlNDQ4ZTU5ZGYuLjhlOWU4OGJmMWY0M2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vZXZlcmdyZWVuLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3Jl
ZW4uYwpAQCAtMzEsNiArMzEsNyBAQAogCiAjaW5jbHVkZSAiYXRvbS5oIgogI2luY2x1ZGUgImF2
aXZvZC5oIgorI2luY2x1ZGUgImNpay5oIgogI2luY2x1ZGUgIm5pLmgiCiAjaW5jbHVkZSAicnY3
NzAuaCIKICNpbmNsdWRlICJldmVyZ3JlZW4uaCIKQEAgLTIxNywxMCArMjE4LDYgQEAgc3RhdGlj
IHZvaWQgZXZlcmdyZWVuX2dwdV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIHZv
aWQgZXZlcmdyZWVuX2Zpbmkoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwogdm9pZCBldmVy
Z3JlZW5fcGNpZV9nZW4yX2VuYWJsZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiB2b2lk
IGV2ZXJncmVlbl9wcm9ncmFtX2FzcG0oc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwotdm9p
ZCBjaWtfaW5pdF9jcF9wZ190YWJsZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Ci0KLWV4
dGVybiB1MzIgY2lrX2dldF9jc2Jfc2l6ZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Ci1l
eHRlcm4gdm9pZCBjaWtfZ2V0X2NzYl9idWZmZXIoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYs
IHZvbGF0aWxlIHUzMiAqYnVmZmVyKTsKIAogc3RhdGljIGNvbnN0IHUzMiBldmVyZ3JlZW5fZ29s
ZGVuX3JlZ2lzdGVyc1tdID0KIHsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
