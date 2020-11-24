Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F9CC64E75
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267B3208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEXHM1XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267B3208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC63D6E900;
	Wed, 25 Nov 2020 08:23:00 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D0E6E544
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:12 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id x13so80669wmj.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S/LGt8e6L64JAUL4CT/1IK4l3Dhv3BlKAOxBbtF4q2Y=;
 b=MEXHM1XESDogQHFfN3R4bynB0veB0Mi8lFjJtgfaZVWY5T8zvvbNN+2TlP9zYS1vHI
 6ESdKOievxShN8Cu7g04MDj+zHLSuErcwz3GRGoqe8nc0On0bv8drWOofDWVMObj44zn
 N86Zx52vI4kQ0f/LB0c6zQ2AhmPavlAJ8TwbKti0GwoW1hTjD8RgAHVaqRnwkkbF52rd
 +BvbH351Wdbh1h886XoNMPWoWrIKEw13vmaG9CZzvqOmA8LwSl8yJcs5hvKcV+AVmc1m
 0KGpQ0lfL6evjhd0DdKTcGJfqI77zymc/Wj6gNniRR699QG7F9yQdEuNfEuFt1HhoQkY
 GCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S/LGt8e6L64JAUL4CT/1IK4l3Dhv3BlKAOxBbtF4q2Y=;
 b=kq/vhIXdzdVR22G19YBov9G4oPfrk0FV89QIPJ5Gp+s6o2FpGBtdZM0VjqOc4l1BzO
 EJvqiC+IHhnmgLXzqEmYFM3/mDrXqKxFg88HnHxAy6zGCrlA1555DQ2LuZzo7V+NIy4t
 SHqQnv5dNNXMkpJ9hklCU4vuGyCvpj/6lpT3Y0OMtOgO5tvdBu2QlbXPFUykKqNfohfu
 gy862D1F5Qv6CFOlj3PueXcPrlIIibeKLhY+yL9fJRWWiFAatcQssekAWRmmxAnwi6ok
 d5oa3/1xJnhQ3ikglWojFC2KvBo9hutrcjarbln2Byg2hFLrOc0z7g33J7cP7Kohl8nc
 WHxQ==
X-Gm-Message-State: AOAM533fGmS0gd9XYPyKsK2b7HzQmTC4rRyC+vGqPCv5/SiI+lvwJbbL
 yIUG5zWKN/ke3Fu0OKAa0YYLmQ==
X-Google-Smtp-Source: ABdhPJyxOoAxWaCxDE+GYFO65fr1bgljFI1ba7+hik2P3LFmw6uXan361fLLAp0T1omJO2iSZUaVQA==
X-Received: by 2002:a1c:7e4f:: with SMTP id z76mr49811wmc.149.1606247051472;
 Tue, 24 Nov 2020 11:44:11 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:10 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 10/40] drm/amd/amdgpu/navi10_ih: Add descriptions for 'ih' and
 'entry'
Date: Tue, 24 Nov 2020 19:37:54 +0000
Message-Id: <20201124193824.1118741-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Nov 2020 08:22:58 +0000
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
Cc: Alex Sierra <alex.sierra@amd.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmM6NDUzOiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJlZCBpbiAnbmF2aTEwX2loX2dldF93
cHRyJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmM6NTEyOiB3YXJuaW5n
OiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJlZCBpbiAnbmF2
aTEwX2loX2RlY29kZV9pdicKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5j
OjUxMjogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZW50cnknIG5vdCBk
ZXNjcmliZWQgaW4gJ25hdmkxMF9paF9kZWNvZGVfaXYnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9uYXZpMTBfaWguYzo1NTI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1i
ZXIgJ2loJyBub3QgZGVzY3JpYmVkIGluICduYXZpMTBfaWhfaXJxX3JlYXJtJwogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmM6NTg1OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJh
bWV0ZXIgb3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJlZCBpbiAnbmF2aTEwX2loX3NldF9ycHRy
JwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJp
c3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpD
YzogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQt
b2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25h
dmkxMF9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKaW5kZXgg
ODM3NzY5ZmNiMzViNy4uMzMzODA1MmIwODBiNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbmF2aTEwX2loLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bmF2aTEwX2loLmMKQEAgLTQ0Miw2ICs0NDIsNyBAQCBzdGF0aWMgdm9pZCBuYXZpMTBfaWhfaXJx
X2Rpc2FibGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAgKiBuYXZpMTBfaWhfZ2V0X3dw
dHIgLSBnZXQgdGhlIElIIHJpbmcgYnVmZmVyIHdwdHIKICAqCiAgKiBAYWRldjogYW1kZ3B1X2Rl
dmljZSBwb2ludGVyCisgKiBAaWg6IElIIHJpbmcgYnVmZmVyIHRvIGZldGNoIHdwdHIKICAqCiAg
KiBHZXQgdGhlIElIIHJpbmcgYnVmZmVyIHdwdHIgZnJvbSBlaXRoZXIgdGhlIHJlZ2lzdGVyCiAg
KiBvciB0aGUgd3JpdGViYWNrIG1lbW9yeSBidWZmZXIgKE5BVkkxMCkuICBBbHNvIGNoZWNrIGZv
cgpAQCAtNTAyLDYgKzUwMyw4IEBAIHN0YXRpYyB1MzIgbmF2aTEwX2loX2dldF93cHRyKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogICogbmF2aTEwX2loX2RlY29kZV9pdiAtIGRlY29kZSBh
biBpbnRlcnJ1cHQgdmVjdG9yCiAgKgogICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgor
ICogQGloOiBJSCByaW5nIGJ1ZmZlciB0byBkZWNvZGUKKyAqIEBlbnRyeTogSVYgZW50cnkgdG8g
cGxhY2UgZGVjb2RlZCBpbmZvcm1hdGlvbiBpbnRvCiAgKgogICogRGVjb2RlcyB0aGUgaW50ZXJy
dXB0IHZlY3RvciBhdCB0aGUgY3VycmVudCBycHRyCiAgKiBwb3NpdGlvbiBhbmQgYWxzbyBhZHZh
bmNlIHRoZSBwb3NpdGlvbi4KQEAgLTU0NSw2ICs1NDgsNyBAQCBzdGF0aWMgdm9pZCBuYXZpMTBf
aWhfZGVjb2RlX2l2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogICogbmF2aTEwX2loX2ly
cV9yZWFybSAtIHJlYXJtIElSUSBpZiBsb3N0CiAgKgogICogQGFkZXY6IGFtZGdwdV9kZXZpY2Ug
cG9pbnRlcgorICogQGloOiBJSCByaW5nIHRvIG1hdGNoCiAgKgogICovCiBzdGF0aWMgdm9pZCBu
YXZpMTBfaWhfaXJxX3JlYXJtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LApAQCAtNTc4LDYg
KzU4Miw3IEBAIHN0YXRpYyB2b2lkIG5hdmkxMF9paF9pcnFfcmVhcm0oc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCiAgKgogICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgogICoKKyAq
IEBpaDogSUggcmluZyBidWZmZXIgdG8gc2V0IHJwdHIKICAqIFNldCB0aGUgSUggcmluZyBidWZm
ZXIgcnB0ci4KICAqLwogc3RhdGljIHZvaWQgbmF2aTEwX2loX3NldF9ycHRyKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
