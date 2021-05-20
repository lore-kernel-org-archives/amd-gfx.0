Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4BCC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABDF61184
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABDF61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D613B6F46C;
	Thu, 20 May 2021 12:49:17 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275606F41B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:34 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 z137-20020a1c7e8f0000b02901774f2a7dc4so4960685wmc.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zlibc4LyGipvg4obFAlhywPDGkR/RwOwB7qJgTWpEQk=;
 b=UA59QABmfviBFeZfpaAPoiLqz5qey6xTmF0t9hqA5QLsmKpXnUkVTCnx0qvs0zKJ8C
 z2bJ3m2Fw2kqMgDcGlAR5byvIHNNEz6vSBKq7OD8aL/kH5wFAaL7lQv3F/Ofen/BzpNu
 m6x/RTaH8fT5BM81ukjIZ2TODrhhdl9y6fuVJ/wf5dhUZwmo0v4gSn3cxh0XIOpdG59f
 aFYlwPkIfxVZZWi3DL/vzZCK0Y9G2Xn50Yecd7IskuY7X8P33ypXjiNExPQGdnISLlAS
 3j+DHnslT2hE+iZiS305JG439KEM8SnpG0/Mzb4KMi3RNvyxItyN73kDYJJBFipMjXhc
 BEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zlibc4LyGipvg4obFAlhywPDGkR/RwOwB7qJgTWpEQk=;
 b=WlplewH/KDFjP2DlWkUgRHvzERRJbbsKdI9KXb8fTUmsVdSmJnVSRTnVLlnEYDCwm2
 YB0yR8nNPdyw4J4JKnk9jMO9jUzh6/7sfmvHnFGzWsFoLbDgHOAk9O1Ha823mGO36mjl
 qTtRJY5RKi0gr9I/4bs5ZUXy0dJVetszMlKaHRYIPb3dynELd0begM1CZq5FNc/YOc6D
 eIUNX/PBeUTGvp0OCXcZkxO8pHhX27SsqcuoNNGemdgkzMxNIqGZ8Pql3ueBloX1xMSR
 yvp5agm7/+3oyNeVtKzqvcDqZYs6b59/+fE5acQS5iYNc8x/BHdAt0IssqmKBXbUejC9
 AGWw==
X-Gm-Message-State: AOAM532+cCOrpJzw6V9MTaitYgGPXn+5G623wFEXX6VjuSNd2Pd/Ut8R
 CYu1kZ0OHetbqwc8DDMm2s5B+Q==
X-Google-Smtp-Source: ABdhPJxZvMmhAPb64IZvUSM2V4g4sPvzwvUnAl0rdZIN85Pd0pFiszmlO95w7yWHvYH/+prqI7Rtkg==
X-Received: by 2002:a1c:5582:: with SMTP id j124mr3405666wmb.0.1621512202682; 
 Thu, 20 May 2021 05:03:22 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:22 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 30/38] drm/amd/amdgpu/gfx_v9_4_2: Mark functions called by
 reference as static
Date: Thu, 20 May 2021 13:02:40 +0100
Message-Id: <20210520120248.3464013-31-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRfMi5jOjEwMDg6NTogd2FybmluZzogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciDigJhnZnhfdjlfNF8yX3F1ZXJ5X3Jhc19lcnJvcl9jb3VudOKA
mSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfNF8yLmM6MTA1NDo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGdm
eF92OV80XzJfcmVzZXRfcmFzX2Vycm9yX2NvdW504oCZIFstV21pc3NpbmctcHJvdG90eXBlc10K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzIuYzoxMDYzOjU6IHdhcm5pbmc6
IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZ2Z4X3Y5XzRfMl9yYXNfZXJyb3JfaW5qZWN0
4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OV80XzIuYzoxMTMzOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCY
Z2Z4X3Y5XzRfMl9xdWVyeV9yYXNfZXJyb3Jfc3RhdHVz4oCZIFstV21pc3NpbmctcHJvdG90eXBl
c10KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzIuYzoxMTQzOjY6IHdhcm5p
bmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZ2Z4X3Y5XzRfMl9yZXNldF9yYXNfZXJy
b3Jfc3RhdHVz4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV80XzIuYzoxMTUzOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlw
ZSBmb3Ig4oCYZ2Z4X3Y5XzRfMl9lbmFibGVfd2F0Y2hkb2dfdGltZXLigJkgWy1XbWlzc2luZy1w
cm90b3R5cGVzXQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
Q2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZm
d2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNA
bGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8yLmMg
fCAxNCArKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfNF8yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8yLmMKaW5kZXgg
ZGJhZDllZjAwMmQ1OS4uODdlYzk2YTE4YTVkZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzRfMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV80XzIuYwpAQCAtMTY0MSw4ICsxNjQxLDggQEAgc3RhdGljIGludCBnZnhfdjlfNF8y
X3F1ZXJ5X3V0Y19lZGNfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJcmV0dXJu
IDA7CiB9CiAKLWludCBnZnhfdjlfNF8yX3F1ZXJ5X3Jhc19lcnJvcl9jb3VudChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKLQkJCQkgICB2b2lkICpyYXNfZXJyb3Jfc3RhdHVzKQorc3RhdGlj
IGludCBnZnhfdjlfNF8yX3F1ZXJ5X3Jhc19lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKKwkJCQkJICAgIHZvaWQgKnJhc19lcnJvcl9zdGF0dXMpCiB7CiAJc3RydWN0IHJh
c19lcnJfZGF0YSAqZXJyX2RhdGEgPSAoc3RydWN0IHJhc19lcnJfZGF0YSAqKXJhc19lcnJvcl9z
dGF0dXM7CiAJdWludDMyX3Qgc2VjX2NvdW50ID0gMCwgZGVkX2NvdW50ID0gMDsKQEAgLTE2OTAs
NyArMTY5MCw3IEBAIHN0YXRpYyB2b2lkIGdmeF92OV80XzJfcmVzZXRfZWFfZXJyX3N0YXR1cyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAltdXRleF91bmxvY2soJmFkZXYtPmdyYm1faWR4
X211dGV4KTsKIH0KIAotdm9pZCBnZnhfdjlfNF8yX3Jlc2V0X3Jhc19lcnJvcl9jb3VudChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK3N0YXRpYyB2b2lkIGdmeF92OV80XzJfcmVzZXRfcmFz
X2Vycm9yX2NvdW50KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCWlmICghYW1kZ3B1
X3Jhc19pc19zdXBwb3J0ZWQoYWRldiwgQU1ER1BVX1JBU19CTE9DS19fR0ZYKSkKIAkJcmV0dXJu
OwpAQCAtMTY5OSw3ICsxNjk5LDcgQEAgdm9pZCBnZnhfdjlfNF8yX3Jlc2V0X3Jhc19lcnJvcl9j
b3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlnZnhfdjlfNF8yX3F1ZXJ5X3V0Y19l
ZGNfY291bnQoYWRldiwgTlVMTCwgTlVMTCk7CiB9CiAKLWludCBnZnhfdjlfNF8yX3Jhc19lcnJv
cl9pbmplY3Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHZvaWQgKmluamVjdF9pZikKK3N0
YXRpYyBpbnQgZ2Z4X3Y5XzRfMl9yYXNfZXJyb3JfaW5qZWN0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCB2b2lkICppbmplY3RfaWYpCiB7CiAJc3RydWN0IHJhc19pbmplY3RfaWYgKmluZm8g
PSAoc3RydWN0IHJhc19pbmplY3RfaWYgKilpbmplY3RfaWY7CiAJaW50IHJldDsKQEAgLTE3NzIs
NyArMTc3Miw3IEBAIHN0YXRpYyB2b2lkIGdmeF92OV80XzJfcXVlcnlfdXRjX2Vycl9zdGF0dXMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJfQogfQogCi12b2lkIGdmeF92OV80XzJfcXVl
cnlfcmFzX2Vycm9yX3N0YXR1cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK3N0YXRpYyB2
b2lkIGdmeF92OV80XzJfcXVlcnlfcmFzX2Vycm9yX3N0YXR1cyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKIHsKIAlpZiAoIWFtZGdwdV9yYXNfaXNfc3VwcG9ydGVkKGFkZXYsIEFNREdQVV9S
QVNfQkxPQ0tfX0dGWCkpCiAJCXJldHVybjsKQEAgLTE3ODIsNyArMTc4Miw3IEBAIHZvaWQgZ2Z4
X3Y5XzRfMl9xdWVyeV9yYXNfZXJyb3Jfc3RhdHVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCWdmeF92OV80XzJfcXVlcnlfc3FfdGltZW91dF9zdGF0dXMoYWRldik7CiB9CiAKLXZvaWQg
Z2Z4X3Y5XzRfMl9yZXNldF9yYXNfZXJyb3Jfc3RhdHVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQorc3RhdGljIHZvaWQgZ2Z4X3Y5XzRfMl9yZXNldF9yYXNfZXJyb3Jfc3RhdHVzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCWlmICghYW1kZ3B1X3Jhc19pc19zdXBwb3J0ZWQo
YWRldiwgQU1ER1BVX1JBU19CTE9DS19fR0ZYKSkKIAkJcmV0dXJuOwpAQCAtMTc5Miw3ICsxNzky
LDcgQEAgdm9pZCBnZnhfdjlfNF8yX3Jlc2V0X3Jhc19lcnJvcl9zdGF0dXMoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiAJZ2Z4X3Y5XzRfMl9yZXNldF9zcV90aW1lb3V0X3N0YXR1cyhhZGV2
KTsKIH0KIAotdm9pZCBnZnhfdjlfNF8yX2VuYWJsZV93YXRjaGRvZ190aW1lcihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKK3N0YXRpYyB2b2lkIGdmeF92OV80XzJfZW5hYmxlX3dhdGNoZG9n
X3RpbWVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCXVpbnQzMl90IGk7CiAJdWlu
dDMyX3QgZGF0YTsKLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
