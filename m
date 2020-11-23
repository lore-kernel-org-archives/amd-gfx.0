Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFBBC63798
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8340320702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNK83QJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8340320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B2F89F6F;
	Mon, 23 Nov 2020 13:58:03 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D91389F9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:20:10 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id p8so18212670wrx.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x7j4MAG3aMMAv+exH325swHGJEpjCRvoAo6+eP0jclY=;
 b=lNK83QJS2ndVONnSis4ixIX5b3SXdsncFYR912rIshpJ18Ac3nGF4AFjIcTh74QQTU
 WluvQPGONjU4NiFHaL4NTrNzC5IHdE3V0VQdNQ3pNKFyj11k+WjmlKX89yB5dimcFiov
 2f+MUMxY1HN5Z5LEbCTgklsEbN10IyQlYZBnA9RD3eqC9W6IzpjireyMxOiBAt9eA88J
 Zj84a3y/mcHqA778ECrH8x2HuPUV/EFDP3URDRVk9vBqYxtzvTbcm587B2X6oGYOp9FV
 L7vr57zATASuA1lLNskOEsiqrz50jCw1zFOMavSoUnLiKimFhQkVlXh0nOwOOG+ikK8b
 XalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x7j4MAG3aMMAv+exH325swHGJEpjCRvoAo6+eP0jclY=;
 b=EcigFjShz7A9Ij3OZgpyPaywYj/t0CzFJvOszMV3Fne2GZg7Ng3X0CxPe79RnoJDZt
 t/ukMP/b0EJ5SpNg308d/T2p4l9JkmtC4PzzFyZqiqBiKQesPyetBWYOYjGfZUM0PeSt
 W56AhWg42RQds6w513+D2jwJKEwoESNLBuCL0suKDgkqjIL/lJxkDPtlhjb6B/+DVRkG
 QueiI83tC/SlBRahXOeqr0yDjiJfnCl/Q62EqMw7OH0URewaoW8j5y4QFiLpYOuGI5ZK
 NnGj8dFM+KKfnctfW4WdRlFe2UlSQBdZVaC08+rlQzgwIVj9rZqdzx0PaHpPEFPYRsWW
 POpw==
X-Gm-Message-State: AOAM532bsWYqUIk/EKGjeJXVhlnIPCfviCFyXg+gQ/s3ns42aInjrBr6
 UhkSDecTQOBU4abepHlvjHvf9Q==
X-Google-Smtp-Source: ABdhPJzPAspljYVUUQw5F7zFIQt0YEnWI6OkhToahK3/SXM47FmrLku1L0vKnxwWd6+xB4+RbhoiJw==
X-Received: by 2002:a5d:6892:: with SMTP id h18mr30002591wru.49.1606130408851; 
 Mon, 23 Nov 2020 03:20:08 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:20:08 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 33/40] drm/amd/amdgpu/cik_sdma: Add one and remove another
 function param description
Date: Mon, 23 Nov 2020 11:19:12 +0000
Message-Id: <20201123111919.233376-34-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEuYzoyODI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ2ZsYWdzJyBub3QgZGVzY3JpYmVkIGluICdjaWtfc2RtYV9yaW5n
X2VtaXRfZmVuY2UnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWtfc2RtYS5jOjI4Mjog
d2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnZmVuY2UnIGRlc2NyaXB0aW9uIGlu
ICdjaWtfc2RtYV9yaW5nX2VtaXRfZmVuY2UnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBs
aW5hcm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpD
YzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25l
cyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Y2lrX3NkbWEuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWtf
c2RtYS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEuYwppbmRleCBmMWU5
OTY2ZTcyNDRlLi4yOGE2NGRlOGFlMGU2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9jaWtfc2RtYS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa19z
ZG1hLmMKQEAgLTI3MSw3ICsyNzEsNyBAQCBzdGF0aWMgdm9pZCBjaWtfc2RtYV9yaW5nX2VtaXRf
aGRwX2ZsdXNoKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKICAqIEByaW5nOiBhbWRncHUgcmlu
ZyBwb2ludGVyCiAgKiBAYWRkcjogYWRkcmVzcwogICogQHNlcTogc2VxdWVuY2UgbnVtYmVyCi0g
KiBAZmVuY2U6IGFtZGdwdSBmZW5jZSBvYmplY3QKKyAqIEBmbGFnczogZmVuY2UgcmVsYXRlZCBm
bGFncwogICoKICAqIEFkZCBhIERNQSBmZW5jZSBwYWNrZXQgdG8gdGhlIHJpbmcgdG8gd3JpdGUK
ICAqIHRoZSBmZW5jZSBzZXEgbnVtYmVyIGFuZCBETUEgdHJhcCBwYWNrZXQgdG8gZ2VuZXJhdGUK
QEAgLTI3OSw3ICsyNzksNyBAQCBzdGF0aWMgdm9pZCBjaWtfc2RtYV9yaW5nX2VtaXRfaGRwX2Zs
dXNoKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKICAqLwogc3RhdGljIHZvaWQgY2lrX3NkbWFf
cmluZ19lbWl0X2ZlbmNlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdTY0IGFkZHIsIHU2NCBz
ZXEsCiAJCQkJICAgICB1bnNpZ25lZCBmbGFncykKLXsKKyAgewogCWJvb2wgd3JpdGU2NGJpdCA9
IGZsYWdzICYgQU1ER1BVX0ZFTkNFX0ZMQUdfNjRCSVQ7CiAJLyogd3JpdGUgdGhlIGZlbmNlICov
CiAJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgU0RNQV9QQUNLRVQoU0RNQV9PUENPREVfRkVOQ0Us
IDAsIDApKTsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
