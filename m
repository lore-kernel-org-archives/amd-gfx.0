Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092B6C5517A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EF620659
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZppS/pPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EF620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767446E0D1;
	Wed, 11 Nov 2020 18:45:16 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33976E0C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 18:36:11 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a3so3235332wmb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 10:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wcR9SHA/hLxAo0DjnBJYKl1ZjLgHXt+Q6E2OPcU6TRk=;
 b=ZppS/pPTRTgdttLh54xP750Kj6wz+Skcp0gIoIgehdUbqo2zKnEjGa/yiqC1zsRVT1
 RojNDkdIIOVwEH/cxzrfw4IzVBy+MNQX717cjqzVcQD/DhZ7iqciX6SM6vWljUD9C7vy
 INmw17RivPboOAMS7Evvldk4WAubEVgS4S/nkTyULsmgnbzDLjGxfJfy+SxvxwbIOBkd
 Z8BJJPyj9Xo5ParXgCKw1BIgyM1MPmCqIDQXge0PR3SNWPVIVb1bugXxBYfp9WDf+xld
 Hhidwk+ywKJksPFcW9w+HUDn2U5kjpbYCXXweJoLxXkIhKaCfiQqoIVuzgh6iYP2RRo0
 amRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wcR9SHA/hLxAo0DjnBJYKl1ZjLgHXt+Q6E2OPcU6TRk=;
 b=L+K38nxv4+zSAhQyxDVudlJsliDnMMantpQSMA9AZY0FyGWpzKaoYVs5ccWIIqrmlp
 9RdJ5wtaQW6S8nut47J94nKI0SHsMFaMp1V9f/tGafKfeLoE8o9K4mGi0YajqRrDH/yv
 DDIXW5fzdr1GNXKcaAa6g8qyViTP95US3WQPfY/6LkjKnpnoY0YKwj8ysTWjFnOIf60T
 vAiBnWjGZjG4UgQ2fI63j3tSJMVSm2U1NV6VshldAhSSsXFi0fVQXz0TZVYk7N2M4xVp
 kRM3g3O4CuCt0dIhz396gXwiBz+Cax14CAj1j/ft18X4PLfCU6rkcxzkT2hvaQz4qyRJ
 ldYw==
X-Gm-Message-State: AOAM530yJLHCeAT1Q9yxFR1ZEylJyNvy5EWvvWOEPt927SzQpmst0lSU
 GQt8YO+OXGXOMdOEr4vq9JlVBg==
X-Google-Smtp-Source: ABdhPJwRT4ieJ2l8ug/xaqNwACgL0ytg+jIjEVoXnmY/kQp/b2J6n2NQ7oxNVQnCZou2JirHx9ehsw==
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr2725638wme.113.1605119770340; 
 Wed, 11 Nov 2020 10:36:10 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 10:36:09 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 15/19] drm/radeon/ci_dpm: Move 'si_*()'s prototypes to shared
 header
Date: Wed, 11 Nov 2020 18:35:41 +0000
Message-Id: <20201111183545.1756994-16-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYzozODAyOjQ6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHBy
b3RvdHlwZSBmb3Ig4oCYc2lfZ2V0X2RkcjNfbWNsa19mcmVxdWVuY3lfcmF0aW/igJkgWy1XbWlz
c2luZy1wcm90b3R5cGVzXQogMzgwMiB8IHU4IHNpX2dldF9kZHIzX21jbGtfZnJlcXVlbmN5X3Jh
dGlvKHUzMiBtZW1vcnlfY2xvY2spCiB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
CiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jOjM4MTU6NDogd2FybmluZzogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciDigJhzaV9nZXRfbWNsa19mcmVxdWVuY3lfcmF0aW/igJkgWy1X
bWlzc2luZy1wcm90b3R5cGVzXQogMzgxNSB8IHU4IHNpX2dldF9tY2xrX2ZyZXF1ZW5jeV9yYXRp
byh1MzIgbWVtb3J5X2Nsb2NrLCBib29sIHN0cm9iZV9tb2RlKQogfCBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmM6Mzg5Nzo2OiB3YXJu
aW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHNpX3RyaW1fdm9sdGFnZV90YWJsZV90
b19maXRfc3RhdGVfdGFibGXigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogMzg5NyB8IHZvaWQg
c2lfdHJpbV92b2x0YWdlX3RhYmxlX3RvX2ZpdF9zdGF0ZV90YWJsZShzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldiwKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoK
Q2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3Rp
YW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxh
aXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2NpX2RwbS5jIHwgNiArLS0tLS0KIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vc2lfZHBtLmggfCA1ICsrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL2NpX2RwbS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaV9kcG0uYwppbmRleCBh
OWZjMGE1NTI3MzZjLi4wZGZiMGVkOWFmODlkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL2NpX2RwbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lfZHBtLmMKQEAg
LTMzLDYgKzMzLDcgQEAKICNpbmNsdWRlICJyYWRlb24uaCIKICNpbmNsdWRlICJyYWRlb25fYXNp
Yy5oIgogI2luY2x1ZGUgInJhZGVvbl91Y29kZS5oIgorI2luY2x1ZGUgInNpX2RwbS5oIgogCiAj
ZGVmaW5lIE1DX0NHX0FSQl9GUkVRX0YwICAgICAgICAgICAweDBhCiAjZGVmaW5lIE1DX0NHX0FS
Ql9GUkVRX0YxICAgICAgICAgICAweDBiCkBAIC0xNTMsMTEgKzE1NCw2IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgY2lfcHRfY29uZmlnX3JlZyBkaWR0X2NvbmZpZ19jaVtdID0KIGV4dGVybiB1OCBy
djc3MF9nZXRfbWVtb3J5X21vZHVsZV9pbmRleChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7
CiBleHRlcm4gaW50IG5pX2NvcHlfYW5kX3N3aXRjaF9hcmJfc2V0cyhzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldiwKIAkJCQkgICAgICAgdTMyIGFyYl9mcmVxX3NyYywgdTMyIGFyYl9mcmVxX2Rl
c3QpOwotZXh0ZXJuIHU4IHNpX2dldF9kZHIzX21jbGtfZnJlcXVlbmN5X3JhdGlvKHUzMiBtZW1v
cnlfY2xvY2spOwotZXh0ZXJuIHU4IHNpX2dldF9tY2xrX2ZyZXF1ZW5jeV9yYXRpbyh1MzIgbWVt
b3J5X2Nsb2NrLCBib29sIHN0cm9iZV9tb2RlKTsKLWV4dGVybiB2b2lkIHNpX3RyaW1fdm9sdGFn
ZV90YWJsZV90b19maXRfc3RhdGVfdGFibGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsCi0J
CQkJCQkgICAgIHUzMiBtYXhfdm9sdGFnZV9zdGVwcywKLQkJCQkJCSAgICAgc3RydWN0IGF0b21f
dm9sdGFnZV90YWJsZSAqdm9sdGFnZV90YWJsZSk7CiBzdGF0aWMgaW50IGNpX2dldF9zdGRfdm9s
dGFnZV92YWx1ZV9zaWRkKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LAogCQkJCQkgc3RydWN0
IGF0b21fdm9sdGFnZV90YWJsZV9lbnRyeSAqdm9sdGFnZV90YWJsZSwKIAkJCQkJIHUxNiAqc3Rk
X3ZvbHRhZ2VfaGlfc2lkZCwgdTE2ICpzdGRfdm9sdGFnZV9sb19zaWRkKTsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3NpX2RwbS5oCmluZGV4IDEwMzJhNjhiZTc5MmIuLmFhODU3OTA2ZWY5M2QgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9zaV9kcG0uaApAQCAtMjM0LDUgKzIzNCwxMCBAQCBzdHJ1Y3Qgc2lfcG93ZXJfaW5mbyB7
CiAjZGVmaW5lIFNJU0xBTkRTX0NHVUxWUEFSQU1FVEVSX0RGTFQgICAgICAgICAgICAgICAgICAg
IDB4MDAwNDAwMzUKICNkZWZpbmUgU0lTTEFORFNfQ0dVTFZDT05UUk9MX0RGTFQgICAgICAgICAg
ICAgICAgICAgICAgMHgxZjAwNzU1MAogCit1OCBzaV9nZXRfZGRyM19tY2xrX2ZyZXF1ZW5jeV9y
YXRpbyh1MzIgbWVtb3J5X2Nsb2NrKTsKK3U4IHNpX2dldF9tY2xrX2ZyZXF1ZW5jeV9yYXRpbyh1
MzIgbWVtb3J5X2Nsb2NrLCBib29sIHN0cm9iZV9tb2RlKTsKK3ZvaWQgc2lfdHJpbV92b2x0YWdl
X3RhYmxlX3RvX2ZpdF9zdGF0ZV90YWJsZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKKwkJ
CQkJICAgICAgdTMyIG1heF92b2x0YWdlX3N0ZXBzLAorCQkJCQkgICAgICBzdHJ1Y3QgYXRvbV92
b2x0YWdlX3RhYmxlICp2b2x0YWdlX3RhYmxlKTsKIAogI2VuZGlmCi0tIAoyLjI1LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
