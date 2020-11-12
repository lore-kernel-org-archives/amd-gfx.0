Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA04C55ABD
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EA320825
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uu4xJvWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EA320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568936E40D;
	Thu, 12 Nov 2020 19:56:05 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1017F6E3AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 19:01:18 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id p8so7171487wrx.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 11:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YpyVTU+tqYpOdqYFV7Yyz8eI/R9DV3oM3CFnCgiNLh8=;
 b=Uu4xJvWHcKPPYDjs+hyK5B7d8HMBUj/yTACwflvslo/PKGX4dzLVg8Hm2afZX0yNzn
 IDxJzY8ETvFBci87UC/2BGc2ifN3TWH8lMFAHzZndmdHXJYtrIwDZHJfeo03Y5ve8Zp5
 x+W0zF325jR3ygT6nKBe7p1NieYmy6NrEQJYOBV1zP8RQxGbVKRhZVPXTBZZ4dF/cUx2
 ugbkhIUsvKOdUYuhlxRpfXENXWUsYIDuof1ifFMSBFof/er1k5RLhLM6i+Fr2gfz9nDH
 +QBN2RD5gFdbhcqQRP9+iwAQPFFmt1TJUSDskdxnPH5ilO/6PI7BmUPxEbRVR7r19B/2
 tSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YpyVTU+tqYpOdqYFV7Yyz8eI/R9DV3oM3CFnCgiNLh8=;
 b=q7wu7EgvUqwE3xMo56tyTQHjgsM+qm31CXPx40yN2wjsjVpijeVjSj8Upw0mGaR1Ke
 8G5CO4YyAdO3kDh28wVk4CrPIXcA3zwQc7qRPVzRpTYT7aBG+u/BTZRhMSPsCiPsb5qr
 LF1XukvJPLyuwIJg3P3yZqIr+zWpGP40/Egwt8dWSh9MJkCV1OUssHsuvWOM+u6KsW5q
 8kqXTlvOjwzSXd+Rt1jN5H0jPx4KAhVBjbtyfVEkRT8bSfc8f/WFtvXbGWiLuLERlUY9
 g5Qr3Ux4zB03vSD31AIKeUHULG3QOwhMdC5dqAOqUha9lI1q12XXh0taVWCkNmbG1Qmz
 MKCw==
X-Gm-Message-State: AOAM533xy2hqdSBHvrJXfpUL8RBuKRRPgg9juIFzWQ7zxEBka+2Av4Mq
 9LN+KurePaYsRxiXc/ycl4ZcLA==
X-Google-Smtp-Source: ABdhPJzJ40gK1ueU/SRBTE+WvtebXdGobO4IoV/Z4CnmJ6+QGNkXlX+7zClpejlFtHF5WFI8Pe9XTA==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr1116225wru.216.1605207676690; 
 Thu, 12 Nov 2020 11:01:16 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 11:01:16 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 14/30] drm/amd/amdgpu/amdgpu_ring: Fix a bunch of function
 misdocumentation
Date: Thu, 12 Nov 2020 19:00:23 +0000
Message-Id: <20201112190039.2785914-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 12 Nov 2020 19:56:04 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYzo2Mzogd2FybmluZzogRXhjZXNzIGZ1
bmN0aW9uIHBhcmFtZXRlciAnYWRldicgZGVzY3JpcHRpb24gaW4gJ2FtZGdwdV9yaW5nX2FsbG9j
JwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYzoxMjI6IHdhcm5pbmc6
IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ2FkZXYnIGRlc2NyaXB0aW9uIGluICdhbWRncHVf
cmluZ19jb21taXQnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jOjE2
Nzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbWF4X2R3JyBub3QgZGVz
Y3JpYmVkIGluICdhbWRncHVfcmluZ19pbml0JwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3JpbmcuYzoxNjc6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIg
J2lycV9zcmMnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9yaW5nX2luaXQnCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jOjE2Nzogd2FybmluZzogRnVuY3Rpb24gcGFy
YW1ldGVyIG9yIG1lbWJlciAnaXJxX3R5cGUnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9yaW5n
X2luaXQnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jOjE2Nzogd2Fy
bmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnaHdfcHJpbycgbm90IGRlc2NyaWJl
ZCBpbiAnYW1kZ3B1X3JpbmdfaW5pdCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yaW5nLmM6MTY3OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdtYXhfbmR3
JyBkZXNjcmlwdGlvbiBpbiAnYW1kZ3B1X3JpbmdfaW5pdCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nLmM6MTY3OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1l
dGVyICdub3AnIGRlc2NyaXB0aW9uIGluICdhbWRncHVfcmluZ19pbml0JwogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYzoyODU6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlv
biBwYXJhbWV0ZXIgJ2FkZXYnIGRlc2NyaXB0aW9uIGluICdhbWRncHVfcmluZ19maW5pJwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYzozMjU6IHdhcm5pbmc6IEZ1bmN0
aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3JpbmcnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9y
aW5nX2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0X2hlbHBlcicKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nLmM6MzI1OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1l
dGVyICdhZGV2JyBkZXNjcmlwdGlvbiBpbiAnYW1kZ3B1X3JpbmdfZW1pdF9yZWdfd3JpdGVfcmVn
X3dhaXRfaGVscGVyJwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzog
RGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVs
QGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1z
aWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMg
fCAxMiArKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3JpbmcuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKaW5kZXgg
MjY5N2IyNTBkYzMyNi4uYTIzYjIwNzk2OTZhMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmluZy5jCkBAIC01Miw3ICs1Miw2IEBACiAvKioKICAqIGFtZGdwdV9yaW5nX2Fs
bG9jIC0gYWxsb2NhdGUgc3BhY2Ugb24gdGhlIHJpbmcgYnVmZmVyCiAgKgotICogQGFkZXY6IGFt
ZGdwdV9kZXZpY2UgcG9pbnRlcgogICogQHJpbmc6IGFtZGdwdV9yaW5nIHN0cnVjdHVyZSBob2xk
aW5nIHJpbmcgaW5mb3JtYXRpb24KICAqIEBuZHc6IG51bWJlciBvZiBkd29yZHMgdG8gYWxsb2Nh
dGUgaW4gdGhlIHJpbmcgYnVmZmVyCiAgKgpAQCAtOTUsNyArOTQsOCBAQCB2b2lkIGFtZGdwdV9y
aW5nX2luc2VydF9ub3Aoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1aW50MzJfdCBjb3VudCkK
IAkJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgcmluZy0+ZnVuY3MtPm5vcCk7CiB9CiAKLS8qKiBh
bWRncHVfcmluZ19nZW5lcmljX3BhZF9pYiAtIHBhZCBJQiB3aXRoIE5PUCBwYWNrZXRzCisvKioK
KyAqIGFtZGdwdV9yaW5nX2dlbmVyaWNfcGFkX2liIC0gcGFkIElCIHdpdGggTk9QIHBhY2tldHMK
ICAqCiAgKiBAcmluZzogYW1kZ3B1X3Jpbmcgc3RydWN0dXJlIGhvbGRpbmcgcmluZyBpbmZvcm1h
dGlvbgogICogQGliOiBJQiB0byBhZGQgTk9QIHBhY2tldHMgdG8KQEAgLTExMiw3ICsxMTIsNiBA
QCB2b2lkIGFtZGdwdV9yaW5nX2dlbmVyaWNfcGFkX2liKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
Zywgc3RydWN0IGFtZGdwdV9pYiAqaWIpCiAgKiBhbWRncHVfcmluZ19jb21taXQgLSB0ZWxsIHRo
ZSBHUFUgdG8gZXhlY3V0ZSB0aGUgbmV3CiAgKiBjb21tYW5kcyBvbiB0aGUgcmluZyBidWZmZXIK
ICAqCi0gKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCiAgKiBAcmluZzogYW1kZ3B1X3Jp
bmcgc3RydWN0dXJlIGhvbGRpbmcgcmluZyBpbmZvcm1hdGlvbgogICoKICAqIFVwZGF0ZSB0aGUg
d3B0ciAod3JpdGUgcG9pbnRlcikgdG8gdGVsbCB0aGUgR1BVIHRvCkBAIC0xNTYsNyArMTU1LDkg
QEAgdm9pZCBhbWRncHVfcmluZ191bmRvKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKICAqIEBh
ZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKICAqIEByaW5nOiBhbWRncHVfcmluZyBzdHJ1Y3R1
cmUgaG9sZGluZyByaW5nIGluZm9ybWF0aW9uCiAgKiBAbWF4X25kdzogbWF4aW11bSBudW1iZXIg
b2YgZHcgZm9yIHJpbmcgYWxsb2MKLSAqIEBub3A6IG5vcCBwYWNrZXQgZm9yIHRoaXMgcmluZwor
ICogQGlycV9zcmM6IGludGVycnVwdCBzb3VyY2UgdG8gdXNlIGZvciB0aGlzIHJpbmcKKyAqIEBp
cnFfdHlwZTogaW50ZXJydXB0IHR5cGUgdG8gdXNlIGZvciB0aGlzIHJpbmcKKyAqIEBod19wcmlv
OiByaW5nIHByaW9yaXR5IChOT1JNQUwvSElHSCkKICAqCiAgKiBJbml0aWFsaXplIHRoZSBkcml2
ZXIgaW5mb3JtYXRpb24gZm9yIHRoZSBzZWxlY3RlZCByaW5nIChhbGwgYXNpY3MpLgogICogUmV0
dXJucyAwIG9uIHN1Y2Nlc3MsIGVycm9yIG9uIGZhaWx1cmUuCkBAIC0yNzYsNyArMjc3LDYgQEAg
aW50IGFtZGdwdV9yaW5nX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBh
bWRncHVfcmluZyAqcmluZywKIC8qKgogICogYW1kZ3B1X3JpbmdfZmluaSAtIHRlYXIgZG93biB0
aGUgZHJpdmVyIHJpbmcgc3RydWN0LgogICoKLSAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50
ZXIKICAqIEByaW5nOiBhbWRncHVfcmluZyBzdHJ1Y3R1cmUgaG9sZGluZyByaW5nIGluZm9ybWF0
aW9uCiAgKgogICogVGVhciBkb3duIHRoZSBkcml2ZXIgaW5mb3JtYXRpb24gZm9yIHRoZSBzZWxl
Y3RlZCByaW5nIChhbGwgYXNpY3MpLgpAQCAtMzEwLDcgKzMxMCw3IEBAIHZvaWQgYW1kZ3B1X3Jp
bmdfZmluaShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAvKioKICAqIGFtZGdwdV9yaW5nX2Vt
aXRfcmVnX3dyaXRlX3JlZ193YWl0X2hlbHBlciAtIHJpbmcgaGVscGVyCiAgKgotICogQGFkZXY6
IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgorICogQHJpbmc6IHJpbmcgdG8gd3JpdGUgdG8KICAqIEBy
ZWcwOiByZWdpc3RlciB0byB3cml0ZQogICogQHJlZzE6IHJlZ2lzdGVyIHRvIHdhaXQgb24KICAq
IEByZWY6IHJlZmVyZW5jZSB2YWx1ZSB0byB3cml0ZS93YWl0IG9uCi0tIAoyLjI1LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
