Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2E2C6379F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A62420702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrRYYm/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A62420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1D289FF7;
	Mon, 23 Nov 2020 13:58:17 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE476E02E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:20:15 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a3so16860305wmb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P119mFSQ3gSCoSYB/CN9/cMQZuTwsZhoVi6LljBTVvY=;
 b=CrRYYm/KGRuXUUR/ONdnY49DZdCnEJu/XQdHwr44D6hafzYw0j3GaZou7bR45m/YLy
 w7oUaMgSveRI2wSoPDH57G3A7SdpuMQfcEU8p7qd162FJG1Z/nAzhiO7dRC2gnQbC/vm
 PfEmtwcw+HGqx7OB4N24SgMpomvXZtGtwEsyx4SzW6GTRVcwDBTpOLVS8SoCFa22A6sF
 /3gu23WFyO3SC/QrFpSPMePYUsbWOF4Vm6zfw/OUfyR02zvkB1bH7dBVhByeI0X8Hjzb
 53JU2+DIwHKHSvO0tkb8bZu2RemE5bgp9AwkP/sRtts1p1ww7gYv5xbvTNFt6hTems3X
 mR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P119mFSQ3gSCoSYB/CN9/cMQZuTwsZhoVi6LljBTVvY=;
 b=o+k1iA47jAfw+ib5Ej5T44BPjBC4eEblPLjHYjFgSiR1TFfH7l0pc3BhzlYnFQvre8
 gUk/pu2c5NeZBELGQN5Cuz59i/5fMUEoyPSJPYdevB5Uzw5FygpWsQF51QlSU21RdPPP
 55WkpNgOpjHXvh3ocUNwD8KCTuwz45C0sxijIeNwAFp3izfq99yl7rL8KNLKSS7KppK4
 RJv8nR9xFHvAWTQhPLLU2CJ2XJQAt13VWiF3fJpHLB7gnOJ7y9nG8ax6NHD6MQ/RBSCU
 VD+C/LA4Q1H4b3hwB8Jlr5ccaYaMYvBtM0jYnqgLgW3r03YcIbsaiCtlnMLddOwbzckR
 uo/Q==
X-Gm-Message-State: AOAM532Rm5l9bh4auamNEjQGaDQpOtumrwwobL+1aV/71Sw0rS+uJavU
 ojMHHMM6k2s1uEegBonQCLUn/g==
X-Google-Smtp-Source: ABdhPJx6hsFjzM6+Cc5+0sYPcATCIG/Nu0mB09vjfnULq275RahDlgSdUHsy4uAQivbOwg3jDsZZIg==
X-Received: by 2002:a1c:2384:: with SMTP id
 j126mr23898113wmj.116.1606130414120; 
 Mon, 23 Nov 2020 03:20:14 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:20:13 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 37/40] drm/amd/amdgpu/gmc_v8_0: Fix more issues attributed to
 copy/paste
Date: Mon, 23 Nov 2020 11:19:16 +0000
Message-Id: <20201123111919.233376-38-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYzo2MTg6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ2ZsdXNoX3R5cGUnIG5vdCBkZXNjcmliZWQgaW4gJ2dtY192OF8w
X2ZsdXNoX2dwdV90bGJfcGFzaWQnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjhf
MC5jOjYxODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYWxsX2h1Yicg
bm90IGRlc2NyaWJlZCBpbiAnZ21jX3Y4XzBfZmx1c2hfZ3B1X3RsYl9wYXNpZCcKIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmM6NjU3OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJh
bWV0ZXIgb3IgbWVtYmVyICd2bWh1Yicgbm90IGRlc2NyaWJlZCBpbiAnZ21jX3Y4XzBfZmx1c2hf
Z3B1X3RsYicKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmM6NjU3OiB3YXJu
aW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdmbHVzaF90eXBlJyBub3QgZGVzY3Jp
YmVkIGluICdnbWNfdjhfMF9mbHVzaF9ncHVfdGxiJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y4XzAuYzo5OTg6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIg
J3Bhc2lkJyBub3QgZGVzY3JpYmVkIGluICdnbWNfdjhfMF92bV9kZWNvZGVfZmF1bHQnCgpDYzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMgfCA1ICsrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8w
LmMKaW5kZXggMGYzMmE4MDAyYzNkNy4uNDFjMWQ4ZTgxMmI4OCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjhfMC5jCkBAIC02MDksNiArNjA5LDggQEAgc3RhdGljIGludCBnbWNfdjhf
MF9tY19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogICoKICAqIEBhZGV2OiBhbWRn
cHVfZGV2aWNlIHBvaW50ZXIKICAqIEBwYXNpZDogcGFzaWQgdG8gYmUgZmx1c2gKKyAqIEBmbHVz
aF90eXBlOiB1bnVzZWQKKyAqIEBhbGxfaHViOiB1bnVzZWQKICAqCiAgKiBGbHVzaCB0aGUgVExC
IGZvciB0aGUgcmVxdWVzdGVkIHBhc2lkLgogICovCkBAIC02NDksNiArNjUxLDggQEAgc3RhdGlj
IGludCBnbWNfdjhfMF9mbHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAogICoKICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKICAqIEB2bWlkOiB2bSBp
bnN0YW5jZSB0byBmbHVzaAorICogQHZtaHViOiB1bnVzZWQKKyAqIEBmbHVzaF90eXBlOiB1bnVz
ZWQKICAqCiAgKiBGbHVzaCB0aGUgVExCIGZvciB0aGUgcmVxdWVzdGVkIHBhZ2UgdGFibGUgKFZJ
KS4KICAqLwpAQCAtOTkwLDYgKzk5NCw3IEBAIHN0YXRpYyB2b2lkIGdtY192OF8wX2dhcnRfZGlz
YWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKICAqIEBzdGF0dXM6IFZNX0NPTlRFWFQx
X1BST1RFQ1RJT05fRkFVTFRfU1RBVFVTIHJlZ2lzdGVyIHZhbHVlCiAgKiBAYWRkcjogVk1fQ09O
VEVYVDFfUFJPVEVDVElPTl9GQVVMVF9BRERSIHJlZ2lzdGVyIHZhbHVlCiAgKiBAbWNfY2xpZW50
OiBWTV9DT05URVhUMV9QUk9URUNUSU9OX0ZBVUxUX01DQ0xJRU5UIHJlZ2lzdGVyIHZhbHVlCisg
KiBAcGFzaWQ6IGRlYnVnIGxvZ2dpbmcgb25seSAtIG5vIGZ1bmN0aW9uYWwgdXNlCiAgKgogICog
UHJpbnQgaHVtYW4gcmVhZGFibGUgZmF1bHQgaW5mb3JtYXRpb24gKFZJKS4KICAqLwotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
