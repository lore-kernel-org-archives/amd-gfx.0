Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9618C4742C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4250B20659
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeGdCa0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4250B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FFA6E0AA;
	Wed, 11 Nov 2020 18:45:15 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 049C56E0AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 18:36:01 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id r17so3534702wrw.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F+vpUFKiF0HcP1zSRTFbAOX8pFoOA6PVK8Wzkj+zQXI=;
 b=jeGdCa0NoNUq3v4IBNq+kFqCX0O6wzIHiSzPq+rxIAFPzZ0c3KttYWZ8Hm79XPkGsR
 TOFT+rRsoYoNK23zhRzpQym2B27iatWLIVg78YGh8V8E6iOGuGvzj2wVfpFcsWEwT8n7
 HOhB3HXwoFsyYEv5nVILuX3r4vRAXkWfe4fiWJrX1RoFr+QdimVEVSOn25GzCXScyT6S
 V5P1JIzy6Gn5WS7kdxE3JqwhIqMsb4tL8gFIi5gEgvpY5v5dicbDdGGcnXSaJWChoCVn
 CHv4e3eMR0jlBUD1/ziqDXiXM2JE4yxki+c+ns6thWLWjdHzL0/n9l983FHIGIAAvbh9
 5wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F+vpUFKiF0HcP1zSRTFbAOX8pFoOA6PVK8Wzkj+zQXI=;
 b=VMrR8mcfQFx38Js07M5RCX2GBsEpWdjT60F4HCHBjblXkx9sP5+K5DasSY3GUsLxhC
 RmGM5RKuTYQ6rQgkAie9+Rc47oef2m4AaSO8vKuUG1SppcgPNQH5nVaYC//U2SevhNSo
 vCAQj4ioqQtrrwMdY7MgZ/cXhW4mhQHDK+IrBJeX3r9UtjMrU0HjtQqQIJTPLGLZyzKI
 APQ3s12eAkKmwGpkOCx0vIawdM3fb5jP866rkqdvklrrPNo9uA/XcDwcoCteVzut8IsX
 LgXLQa1v/WmGQ2+J9uc0fUCiOtf5kXwKJWmEFJvv3gJpoOrMW7aRFp/IeaDM5oyjZbQw
 wUdw==
X-Gm-Message-State: AOAM532CDXsXJFPG/P7MaU8RpVNd9XjNxbrVR3jzXeGUZnfSvKRy+Leh
 cg1RNstpBeqld46bGRrgHPFuvg==
X-Google-Smtp-Source: ABdhPJxuL3j8SAz2c+7zKK78PcV84iIcwyLkjoqpK4Yb0pYDqOIuwBP5Vzr3Sy4M0XLBM8Bn2/NrPA==
X-Received: by 2002:adf:fd0d:: with SMTP id e13mr29324843wrr.85.1605119759656; 
 Wed, 11 Nov 2020 10:35:59 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 10:35:59 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/19] drm/radeon/si_dpm: Move 'si_mc_load_microcode()'s
 prototype to shared header
Date: Wed, 11 Nov 2020 18:35:33 +0000
Message-Id: <20201111183545.1756994-8-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9zaS5jOjE1NzA6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90
eXBlIGZvciDigJhzaV9tY19sb2FkX21pY3JvY29kZeKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNd
CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlz
dGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2kuYyAgICAgfCAgMSArCiBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3NpLmggICAgIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYyB8ICAyICstCiAzIGZpbGVzIGNoYW5n
ZWQsIDMzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3NpLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmMKaW5kZXggZDA0MDcxNDVj
MDdiNS4uODg3MzFiNzljOGY1NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9z
aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2kuYwpAQCAtMzksNiArMzksNyBAQAog
I2luY2x1ZGUgInJhZGVvbl9hdWRpby5oIgogI2luY2x1ZGUgInJhZGVvbl91Y29kZS5oIgogI2lu
Y2x1ZGUgInNpX2JsaXRfc2hhZGVycy5oIgorI2luY2x1ZGUgInNpLmgiCiAjaW5jbHVkZSAic2lk
LmgiCiAKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5oIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9zaS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAw
MDAwMDAuLjBhNTAxOGVmMTY2ZTIKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3NpLmgKQEAgLTAsMCArMSwzMSBAQAorLyogc2kuaCAtLSBQcml2YXRlIGhlYWRlciBm
b3IgcmFkZW9uIGRyaXZlciAtKi0gbGludXgtYyAtKi0KKyAqCisgKiBDb3B5cmlnaHQgMjAxMSBB
ZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuCisgKgorICogUGVybWlzc2lvbiBpcyBoZXJlYnkg
Z3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gb2J0YWluaW5nIGEKKyAqIGNv
cHkgb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIGZpbGVzICh0
aGUgIlNvZnR3YXJlIiksCisgKiB0byBkZWFsIGluIHRoZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3Ry
aWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uCisgKiB0aGUgcmlnaHRzIHRvIHVz
ZSwgY29weSwgbW9kaWZ5LCBtZXJnZSwgcHVibGlzaCwgZGlzdHJpYnV0ZSwgc3VibGljZW5zZSwK
KyAqIGFuZC9vciBzZWxsIGNvcGllcyBvZiB0aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQgcGVy
c29ucyB0byB3aG9tIHRoZQorICogU29mdHdhcmUgaXMgZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJq
ZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoKKyAqCisgKiBUaGUgYWJvdmUgY29weXJp
Z2h0IG5vdGljZSBhbmQgdGhpcyBwZXJtaXNzaW9uIG5vdGljZSBzaGFsbCBiZSBpbmNsdWRlZCBp
bgorICogYWxsIGNvcGllcyBvciBzdWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdhcmUu
CisgKgorICogVEhFIFNPRlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFO
VFkgT0YgQU5ZIEtJTkQsIEVYUFJFU1MgT1IKKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9U
IExJTUlURUQgVE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLAorICogRklUTkVT
UyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5EIE5PTklORlJJTkdFTUVOVC4gIElOIE5PIEVW
RU5UIFNIQUxMCisgKiBUSEUgQ09QWVJJR0hUIEhPTERFUihTKSBPUiBBVVRIT1IoUykgQkUgTElB
QkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1IKKyAqIE9USEVSIExJQUJJTElUWSwgV0hFVEhF
UiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLAorICogQVJJU0lO
RyBGUk9NLCBPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUg
VVNFIE9SCisgKiBPVEhFUiBERUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuCisgKi8KKworI2lmbmRl
ZiBfX1NJX0hfXworI2RlZmluZSBfX1NJX0hfXworCitzdHJ1Y3QgcmFkZW9uX2RldmljZTsKKwor
aW50IHNpX21jX2xvYWRfbWljcm9jb2RlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKKwor
I2VuZGlmICAgICAgICAgICAgICAgICAgICAgICAgIC8qIF9fU0lfSF9fICovCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9zaV9kcG0uYwppbmRleCBjNjhhYjJmYjFhYzIzLi4zMmI2OTc5NjVjMDY0IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vc2lfZHBtLmMKQEAgLTMyLDYgKzMyLDcgQEAKICNpbmNsdWRlICJyYWRlb25fYXNpYy5o
IgogI2luY2x1ZGUgIm5pX2RwbS5oIgogI2luY2x1ZGUgInNpX2RwbS5oIgorI2luY2x1ZGUgInNp
LmgiCiAjaW5jbHVkZSAic2lkLmgiCiAKICNkZWZpbmUgTUNfQ0dfQVJCX0ZSRVFfRjAgICAgICAg
ICAgIDB4MGEKQEAgLTE3MjEsNyArMTcyMiw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2lfcG93
ZXJ0dW5lX2RhdGEgcG93ZXJ0dW5lX2RhdGFfaGFpbmFuID0KIAogc3RydWN0IGV2ZXJncmVlbl9w
b3dlcl9pbmZvICpldmVyZ3JlZW5fZ2V0X3BpKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsK
IAotZXh0ZXJuIGludCBzaV9tY19sb2FkX21pY3JvY29kZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAq
cmRldik7CiBleHRlcm4gdm9pZCB2Y2VfdjFfMF9lbmFibGVfbWdjZyhzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldiwgYm9vbCBlbmFibGUpOwogCiBzdGF0aWMgaW50IHNpX3BvcHVsYXRlX3ZvbHRh
Z2VfdmFsdWUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsCi0tIAoyLjI1LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
