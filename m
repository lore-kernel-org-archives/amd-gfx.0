Return-Path: <SRS0=WAQI=GN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE0C433E6
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Jan 2021 02:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0542253A
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Jan 2021 02:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0542253A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A78389BFE;
	Sun, 10 Jan 2021 02:11:18 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F5A89BFE
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Jan 2021 02:11:16 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id t30so12738341wrb.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 Jan 2021 18:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FHh/PotdFl8qKlM9O+/UCzSj0fz6Apt0vpIe4lKp9dE=;
 b=U8nfYp58Zik5lmOVjNNUxUJPZB4niuxBIyalahDX8FWnVOPTkMpynnBs8gjF6BQOBz
 BzU5J6zkZne7BUP6D+1GQiIxK9AnMsEJhy9PVuBV4u/2uJT7hSdyr0FxqCRW4B6caKmu
 A0/Zbj3vHV4O+rnyP1PT+K7LTcn05pxS3dz58WRXMmtsfLDePRIvGSAf+e1XPEyUEcLh
 d4Yg3ta8+BJf8Bzb4X1wqGtA3aLg3/aN2G79TMQeZM5qG1MoJQTau1wM6dHsNWXpmibv
 tQG074M6Jg6pxV8y7l0f7gRgE/28b2ORB6m6jc5eApkfkGdN7izLK/fzyr1nAo5YK/Pt
 5GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FHh/PotdFl8qKlM9O+/UCzSj0fz6Apt0vpIe4lKp9dE=;
 b=rq5VF1Po0e12kDn/a5vqxydpHK15m9NZ3dh0hrAyAj9bxmRfaRhY02X3q9gOtcBsJQ
 ABYEZqJNmU3+JfLEYjIozRYlpz0ubDEPGt0ijw64Rp9sqlO340uVbpadWvCz8GX4/3KY
 wevRFcEGh1NZrQtB1WLvOQOf7H7ww8nNrjH4xaIMQ0GXPIQ5gsJ7Os6Udik6vUNJgBss
 AioT/Y1Kg0ajlp8RTGzzAKlZe7NjlJFF3civnlkv65suQBhqzBjHdXu5qg+RPGLHNKFp
 QHqRQXxlLHgvKXVoJcWk5WNpdzJmRtdWlfu9DicR2+zsfNV02xynL6UoBJChP3voMTMN
 yVvA==
X-Gm-Message-State: AOAM532WSF+HFpMvYD4Hh3UJF9ZUvFbmh943MKVqJDRLJWTDDNTXpYM5
 +X15ZjfWpucB/ieYH+byWT9ujg==
X-Google-Smtp-Source: ABdhPJwEHvvEVEkY22I+tzh63G8yn75NDuGVpSYW3Df/THsItUpV0s3sxgzO3thketw5a1OqiT04Qg==
X-Received: by 2002:adf:e688:: with SMTP id r8mr10040861wrm.20.1610244674869; 
 Sat, 09 Jan 2021 18:11:14 -0800 (PST)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id o124sm17736882wmb.5.2021.01.09.18.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Jan 2021 18:11:14 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm: Check actual format for legacy pageflip.
Date: Sun, 10 Jan 2021 03:11:42 +0100
Message-Id: <20210110021142.28221-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
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
Cc: mario.kleiner.de@gmail.com, daniel.vetter@ffwll.ch,
 intel-gfx@lists.freedesktop.org, zhan.liu@amd.com,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, alexander.deucher@amd.com,
 nicholas.kazlauskas@amd.com, ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2l0aCBtb2RpZmllcnMgb25lIGNhbiBhY3R1YWxseSBoYXZlIGRpZmZlcmVudCBmb3JtYXRfaW5m
byBzdHJ1Y3RzCmZvciB0aGUgc2FtZSBmb3JtYXQsIHdoaWNoIG5vdyBtYXR0ZXJzIGZvciBBTURH
UFUgc2luY2Ugd2UgY29udmVydAppbXBsaWNpdCBtb2RpZmllcnMgdG8gZXhwbGljaXQgbW9kaWZp
ZXJzIHdpdGggbXVsdGlwbGUgcGxhbmVzLgoKSSBjaGVja2VkIG90aGVyIGRyaXZlcnMgYW5kIGl0
IGRvZXNuJ3QgbG9vayBsaWtlIHRoZXkgZW5kIHVwIHRyaWdnZXJpbmcKdGhpcyBjYXNlIHNvIEkg
dGhpbmsgdGhpcyBpcyBzYWZlIHRvIHJlbGF4LgoKU2lnbmVkLW9mZi1ieTogQmFzIE5pZXV3ZW5o
dWl6ZW4gPGJhc0BiYXNuaWV1d2VuaHVpemVuLm5sPgpSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRl
ciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KUmV2aWV3ZWQtYnk6IFpoYW4gTGl1IDx6aGFuLmxp
dUBhbWQuY29tPgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgpGaXhlczogODE2ODUzZjlkYzQwICgiZHJtL2FtZC9kaXNwbGF5OiBTZXQgbmV3IGZvcm1hdCBp
bmZvIGZvciBjb252ZXJ0ZWQgbWV0YWRhdGEuIikKLS0tCiBkcml2ZXJzL2dwdS9kcm0vZHJtX3Bs
YW5lLmMgfCA5ICsrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fcGxhbmUuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fcGxhbmUuYwppbmRleCBlNjIzMTk0N2Y5ODcuLmEwY2I3NDZiY2Iw
YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9wbGFuZS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9kcm1fcGxhbmUuYwpAQCAtMTE2Myw3ICsxMTYzLDE0IEBAIGludCBkcm1fbW9kZV9w
YWdlX2ZsaXBfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKIAlpZiAocmV0KQogCQlnb3Rv
IG91dDsKIAotCWlmIChvbGRfZmItPmZvcm1hdCAhPSBmYi0+Zm9ybWF0KSB7CisJLyoKKwkgKiBP
bmx5IGNoZWNrIHRoZSBGT1VSQ0MgZm9ybWF0IGNvZGUsIGV4Y2x1ZGluZyBtb2RpZmllcnMuIFRo
aXMgaXMKKwkgKiBlbm91Z2ggZm9yIGFsbCBsZWdhY3kgZHJpdmVycy4gQXRvbWljIGRyaXZlcnMg
aGF2ZSB0aGVpciBvd24KKwkgKiBjaGVja3MgaW4gdGhlaXIgLT5hdG9taWNfY2hlY2sgaW1wbGVt
ZW50YXRpb24sIHdoaWNoIHdpbGwKKwkgKiByZXR1cm4gLUVJTlZBTCBpZiBhbnkgaHcgb3IgZHJp
dmVyIGNvbnN0cmFpbnQgaXMgdmlvbGF0ZWQgZHVlCisJICogdG8gbW9kaWZpZXIgY2hhbmdlcy4K
KwkgKi8KKwlpZiAob2xkX2ZiLT5mb3JtYXQtPmZvcm1hdCAhPSBmYi0+Zm9ybWF0LT5mb3JtYXQp
IHsKIAkJRFJNX0RFQlVHX0tNUygiUGFnZSBmbGlwIGlzIG5vdCBhbGxvd2VkIHRvIGNoYW5nZSBm
cmFtZSBidWZmZXIgZm9ybWF0LlxuIik7CiAJCXJldCA9IC1FSU5WQUw7CiAJCWdvdG8gb3V0Owot
LSAKMi4yOS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
