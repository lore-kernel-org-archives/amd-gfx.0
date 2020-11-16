Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFB2C55ABD
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23992225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfgrxMG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23992225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5440D6E0DB;
	Mon, 16 Nov 2020 19:18:14 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE436E064
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:45 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id u12so12420089wrt.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F+vpUFKiF0HcP1zSRTFbAOX8pFoOA6PVK8Wzkj+zQXI=;
 b=sfgrxMG6CmVvxPp4PJ5OjjRHPczlJjKdH29Zymx3hfYfE28kkaxjfDWAx0nuOk+ddu
 ewVWB5vaa58WzoSuaKOe1y49Hirs7sGkZqF336HJXZqwi3+TilGnTvhmW7jNA+MmJVqG
 JQK6/e26iVfnIxjfwdOu4dgSMMxubz6qKpAu+soYAhohpvOFjnUIwxArHRVpuLZSFunx
 Sgee/pS7pRG9DTBsJujcROkhpOINwa00CJ6ZoBCiwcxI3O+iWhzxws4OjIo8XDqeSMSR
 uROJx71BUPkebIoSl/3XMWCrOKn+QNPS3p0MHC7DJqKD9yLppbd8PXwlGPpEP31XSpWa
 9b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F+vpUFKiF0HcP1zSRTFbAOX8pFoOA6PVK8Wzkj+zQXI=;
 b=Vo7BjB0hZv9hHyH1+2yc0oLsZMxRz+yvWduMkY4pUruxXxVvMUWbN5ptAGzT9Vsdng
 lgK0ga3y5ZXLLhGcvFOE17UjKRag98UuZvWT/c35KyAQENUwIWVY7lLY+kGhTaiHWlfV
 hwz/xZqC623RKrfhUqo5pq/WbO3o9TPdUkZ7kpAqLFzEK8DTRVl7VVsLQ4CnkHjDA81t
 xANGjZZw4IX/9yRrkJxcEplyU6X6jitwQO3GUtdaOEeCtz7hgEvvOstmoGr8VDUgaFSw
 RlAUcKXL/IK+YZfmeh0P3gEAXgqwCv8V1kHXi8raW9iFO8uOr0eZepERGTpNDwsUSWWq
 PYww==
X-Gm-Message-State: AOAM531agCLGWkHxqjMyO91y1bIAltu/MTt0MH/3RftX/K/waxOn+HGU
 78YkWWSK1uPFvBLLSm0wH0fKAQ==
X-Google-Smtp-Source: ABdhPJxabV2dqaOH00x783/4blA0QVK+CVrO53x1r1AXui8K5KdtLxjQf5SCZ94kqTgAUzFpUxxw4A==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr21841442wrq.210.1605548264298; 
 Mon, 16 Nov 2020 09:37:44 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:43 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 29/43] drm/radeon/si_dpm: Move 'si_mc_load_microcode()'s
 prototype to shared header
Date: Mon, 16 Nov 2020 17:36:46 +0000
Message-Id: <20201116173700.1830487-30-lee.jones@linaro.org>
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
