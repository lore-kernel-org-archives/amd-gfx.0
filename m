Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C3FC64E75
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3364120872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYSO/nVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3364120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA9B6E8FA;
	Wed, 25 Nov 2020 08:23:00 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4946E554
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:27 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id 64so10128954wra.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GB6kY4upxQFv24rJ06X4HvdfBkp1xJnyjNfSH8+ifmU=;
 b=gYSO/nVmFciixTFJ8ZqVydxt3ETrnljhtml21uB6O8PC1QhgpWZ06dgSyH4KjrinuJ
 iDlUGLl+ysxrcvtrKWR8gHxcgxhwk792cp/ZUjMKxj88lWvnMA9mpfqh7e21oCtZnhsI
 xziWQg/ze7wmJg8oj2FustOlfqEuy3LxlDUk75pZx2jz7IgRDlQwfa/pUUtvkVOkK5Ei
 hUnmDpvxI8xt4AD4521/sTVwp3Ar2j9aOGeR/LQRrVO6PCcHejb5SGXlzyY4PuKDsJXQ
 YY/2k1rlA6BCsIialIdRJf1Ocac398uulw8nhlphGmB5WId/BPHtX0XafqS8z2W92uVY
 kCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GB6kY4upxQFv24rJ06X4HvdfBkp1xJnyjNfSH8+ifmU=;
 b=eNufQtVfs2ensunBBabVePR1thJfi4D24vQ5bhYdVk9Xb8lopSvDH3TJszgObWwVh9
 9WHfFSLlJWJ/y2ZnIKr5bMDf8An8CqanIdr1jetb3nG20OHtNc88qHHlAc85awGwKmD3
 oI8l9DAKOx7GbpucebhqJhc1/SXUSLX3VxYrvYc0zTx48qkDSvyvGnpVTB8fP6owwQTU
 EZ4OWvnMeDabjCVWiH9oi+tPqWZQkuDnBxl6cZOKbm9ofZrTDH4YfGSZ+7cXEKQsi+jE
 l49+AcCJDGXrd+EHHK8tUWKFRbdsUQxIKILeF1po+Xv+3ndF53GMMaB1aLT3G+b9YUWb
 L6xA==
X-Gm-Message-State: AOAM532IbPu+IK4bULUFJhA5J8CFjzZJ7CS2OBO0x5+RoojNLm/xXEWb
 4VeXcIpNGbPvPFDjyzDgVBKL6Q==
X-Google-Smtp-Source: ABdhPJwiHOsXolfK7RoFeBDciBoIZeZ34wXHdP5DHmDy6yg7Zg4BiP+i4fA7AqCywCu48B/vP+y7JQ==
X-Received: by 2002:adf:f143:: with SMTP id y3mr112155wro.138.1606247066571;
 Tue, 24 Nov 2020 11:44:26 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:25 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 22/40] drm/amd/amdgpu/amdgpu_uvd: Fix some function
 documentation headers
Date: Tue, 24 Nov 2020 19:38:06 +0000
Message-Id: <20201124193824.1118741-23-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jOjk1OiB3YXJuaW5nOiBjYW5ub3QgdW5k
ZXJzdGFuZCBmdW5jdGlvbiBwcm90b3R5cGU6ICdzdHJ1Y3QgYW1kZ3B1X3V2ZF9jc19jdHggJwog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jOjU1NTogd2FybmluZzogRnVu
Y3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYWRldicgbm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1
X3V2ZF9jc19tc2dfZGVjb2RlJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2
ZC5jOjEwMTI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2liX2lkeCcg
bm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X3V2ZF9yaW5nX3BhcnNlX2NzJwogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jOjEyODY6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFt
ZXRlciBvciBtZW1iZXIgJ3RpbWVvdXQnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV91dmRfcmlu
Z190ZXN0X2liJwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
Q2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZm
d2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdA
bGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyB8IDYg
KysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwppbmRleCBmOGJlYmYxOGVlMzYy
Li5mOGYwMzg0YThkOWFkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdXZkLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5j
CkBAIC04Nyw3ICs4Nyw3IEBACiAjZGVmaW5lIFVWRF9OT19PUAkJCQkweDAzZmYKICNkZWZpbmUg
VVZEX0JBU0VfU0kJCQkJMHgzODAwCiAKLS8qKgorLyoKICAqIGFtZGdwdV91dmRfY3NfY3R4IC0g
Q29tbWFuZCBzdWJtaXNzaW9uIHBhcnNlciBjb250ZXh0CiAgKgogICogVXNlZCBmb3IgZW11bGF0
aW5nIHZpcnR1YWwgbWVtb3J5IHN1cHBvcnQgb24gVVZEIDQuMi4KQEAgLTU0NSw4ICs1NDUsOCBA
QCBzdGF0aWMgaW50IGFtZGdwdV91dmRfY3NfcGFzczEoc3RydWN0IGFtZGdwdV91dmRfY3NfY3R4
ICpjdHgpCiAvKioKICAqIGFtZGdwdV91dmRfY3NfbXNnX2RlY29kZSAtIGhhbmRsZSBVVkQgZGVj
b2RlIG1lc3NhZ2UKICAqCisgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCiAgKiBAbXNn
OiBwb2ludGVyIHRvIG1lc3NhZ2Ugc3RydWN0dXJlCi0gKiBAYnVmX3NpemVzOiByZXR1cm5lZCBi
dWZmZXIgc2l6ZXMKICAqCiAgKiBQZWVrIGludG8gdGhlIGRlY29kZSBtZXNzYWdlIGFuZCBjYWxj
dWxhdGUgdGhlIG5lY2Vzc2FyeSBidWZmZXIgc2l6ZXMuCiAgKi8KQEAgLTEwMDUsNiArMTAwNSw3
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3V2ZF9jc19wYWNrZXRzKHN0cnVjdCBhbWRncHVfdXZkX2Nz
X2N0eCAqY3R4LAogICogYW1kZ3B1X3V2ZF9yaW5nX3BhcnNlX2NzIC0gVVZEIGNvbW1hbmQgc3Vi
bWlzc2lvbiBwYXJzZXIKICAqCiAgKiBAcGFyc2VyOiBDb21tYW5kIHN1Ym1pc3Npb24gcGFyc2Vy
IGNvbnRleHQKKyAqIEBpYl9pZHg6IFdoaWNoIGluZGlyZWN0IGJ1ZmZlciB0byB1c2UKICAqCiAg
KiBQYXJzZSB0aGUgY29tbWFuZCBzdHJlYW0sIHBhdGNoIGluIGFkZHJlc3NlcyBhcyBuZWNlc3Nh
cnkuCiAgKi8KQEAgLTEyNzksNiArMTI4MCw3IEBAIHZvaWQgYW1kZ3B1X3V2ZF9yaW5nX2VuZF91
c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogICogYW1kZ3B1X3V2ZF9yaW5nX3Rlc3RfaWIg
LSB0ZXN0IGliIGV4ZWN1dGlvbgogICoKICAqIEByaW5nOiBhbWRncHVfcmluZyBwb2ludGVyCisg
KiBAdGltZW91dDogdGltZW91dCB2YWx1ZSBpbiBqaWZmaWVzLCBvciBNQVhfU0NIRURVTEVfVElN
RU9VVAogICoKICAqIFRlc3QgaWYgd2UgY2FuIHN1Y2Nlc3NmdWxseSBleGVjdXRlIGFuIElCCiAg
Ki8KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
