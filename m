Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3510FC388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA1E20665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsrKOA7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA1E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC5889C69;
	Tue, 10 Nov 2020 19:35:45 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05ED89C07
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:37 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a65so4311362wme.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E+NA4KRLjKd0GRAbHJkCDNT0uCDdmE3g7EFp7CscWp0=;
 b=FsrKOA7++uCL4W3W0ttuyWVPqj3ihLBcI8pDZK10eyMbh5zUSeR/ifrfFkDq46rbJj
 lkIyU0y+cbkMa3eHjnE6JJUOqs+kGLYrr9Hm5jdIqgK5fDbBYb/r6EcU76Xu36UGgfGh
 6bXgjpOoJwEtttmmwz49YImkEslqTJqNxKj3UnGB9LraE1OWO/YUqo9vcg5A/KE42NXv
 Jx8ySu3mhi6eia/XzoH17mq2pfFdw/V2lkDTNH7gwUAjC89+oyOXL2CDNxE9YpGVyyDr
 yYSlAfRUP1C8PsqtJcu9QkEGFSJVLnaQ05Y3wfHCdd+HO61cXxE15+XtLUTAUhlzzJZW
 49SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E+NA4KRLjKd0GRAbHJkCDNT0uCDdmE3g7EFp7CscWp0=;
 b=VpD17xfwi5Uacl2+grpLcpGV4wqqWLANtnJyVk0WdwOE53M2jeeSnSUAZAKnT4ALhZ
 ckbG2Zb5BPyfkQT9+1+IS1KbUYqaeNzURHr3ZZO9NLzlJI3Fz+ag0s8xb80JmbCyzgog
 I+C8Wkc0+D4nWZRBkJlpO9O9/9aba7ZO8f58iJ8O50/J5Cs5p0WfgxDTUMyPeyOPRsvB
 TfBXwKHy2CefcjYvON/B47PlcWoffx/oDT0axxmUaNw7uaw7boHzSyMv450HpVDtCHQp
 m+OCe+6ImRxRv5YKqHBg8RhQkDEh7s7tVp1pZIiyGZn4CJHQrlSWnOomDgTshOqBkEhq
 EjUQ==
X-Gm-Message-State: AOAM531A1Ba+eyX9qIaKLuiJckIffVVh9y+VYHLP/F+d5Ajx0hs8dCA3
 3PoYyB5BZvXPuwWXlxg+hSDP3Q==
X-Google-Smtp-Source: ABdhPJyKq4mKCH/nqgkvIQYhpyL12zgD5LtXKaBkPg4GIUYYBIk9BwqQzypaSJMbpeQi+7UpQmEv3g==
X-Received: by 2002:a05:600c:21cc:: with SMTP id
 x12mr761167wmj.8.1605036696563; 
 Tue, 10 Nov 2020 11:31:36 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:35 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 16/30] drm/radeon/r100: Fix some kernel-doc formatting,
 misnaming and missing issues
Date: Tue, 10 Nov 2020 19:30:58 +0000
Message-Id: <20201110193112.988999-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yMTAwLmM6MTYzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIg
b3IgbWVtYmVyICdhc3luYycgbm90IGRlc2NyaWJlZCBpbiAncjEwMF9wYWdlX2ZsaXAnCiBkcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3IxMDAuYzo4NDg6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRl
ciBvciBtZW1iZXIgJ3JkZXYnIG5vdCBkZXNjcmliZWQgaW4gJ3IxMDBfcmluZ19oZHBfZmx1c2gn
CiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IxMDAuYzo4NDg6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ3JpbmcnIG5vdCBkZXNjcmliZWQgaW4gJ3IxMDBfcmluZ19oZHBf
Zmx1c2gnCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IxMDAuYzoxNDI1OiB3YXJuaW5nOiBGdW5j
dGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdwJyBub3QgZGVzY3JpYmVkIGluICdyMTAwX2NzX3Bh
Y2tldF9wYXJzZV92bGluZScKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjEwMC5jOjE0MjU6IHdh
cm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ3BhcnNlcicgZGVzY3JpcHRpb24gaW4g
J3IxMDBfY3NfcGFja2V0X3BhcnNlX3ZsaW5lJwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVs
IFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxA
bGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcK
Q2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjEw
MC5jIHwgNyArKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjEwMC5jIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yMTAwLmMKaW5kZXggMjRjOGRiNjczOTMxYS4uOTIwNzVkZWRm
MmNiMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMTAwLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yMTAwLmMKQEAgLTE1Myw2ICsxNTMsNyBAQCB2b2lkIHIxMDBf
d2FpdF9mb3JfdmJsYW5rKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgY3J0YykKICAq
IEByZGV2OiByYWRlb25fZGV2aWNlIHBvaW50ZXIKICAqIEBjcnRjX2lkOiBjcnRjIHRvIGNsZWFu
dXAgcGFnZWZsaXAgb24KICAqIEBjcnRjX2Jhc2U6IG5ldyBhZGRyZXNzIG9mIHRoZSBjcnRjIChH
UFUgTUMgYWRkcmVzcykKKyAqIEBhc3luYzogdW51c2VkCiAgKgogICogRG9lcyB0aGUgYWN0dWFs
IHBhZ2VmbGlwIChyMXh4LXI0eHgpLgogICogRHVyaW5nIHZibGFuayB3ZSB0YWtlIHRoZSBjcnRj
IGxvY2sgYW5kIHdhaXQgZm9yIHRoZSB1cGRhdGVfcGVuZGluZwpAQCAtODQxLDggKzg0Miw4IEBA
IHUzMiByMTAwX2dldF92YmxhbmtfY291bnRlcihzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwg
aW50IGNydGMpCiAKIC8qKgogICogcjEwMF9yaW5nX2hkcF9mbHVzaCAtIGZsdXNoIEhvc3QgRGF0
YSBQYXRoIHZpYSB0aGUgcmluZyBidWZmZXIKLSAqIHJkZXY6IHJhZGVvbiBkZXZpY2Ugc3RydWN0
dXJlCi0gKiByaW5nOiByaW5nIGJ1ZmZlciBzdHJ1Y3QgZm9yIGVtaXR0aW5nIHBhY2tldHMKKyAq
IEByZGV2OiByYWRlb24gZGV2aWNlIHN0cnVjdHVyZQorICogQHJpbmc6IHJpbmcgYnVmZmVyIHN0
cnVjdCBmb3IgZW1pdHRpbmcgcGFja2V0cwogICovCiBzdGF0aWMgdm9pZCByMTAwX3JpbmdfaGRw
X2ZsdXNoKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBzdHJ1Y3QgcmFkZW9uX3JpbmcgKnJp
bmcpCiB7CkBAIC0xNDA5LDcgKzE0MTAsNyBAQCBpbnQgcjEwMF9jc19wYXJzZV9wYWNrZXQwKHN0
cnVjdCByYWRlb25fY3NfcGFyc2VyICpwLAogCiAvKioKICAqIHIxMDBfY3NfcGFja2V0X25leHRf
dmxpbmUoKSAtIHBhcnNlIHVzZXJzcGFjZSBWTElORSBwYWNrZXQKLSAqIEBwYXJzZXI6CQlwYXJz
ZXIgc3RydWN0dXJlIGhvbGRpbmcgcGFyc2luZyBjb250ZXh0LgorICogQHA6CQlwYXJzZXIgc3Ry
dWN0dXJlIGhvbGRpbmcgcGFyc2luZyBjb250ZXh0LgogICoKICAqIFVzZXJzcGFjZSBzZW5kcyBh
IHNwZWNpYWwgc2VxdWVuY2UgZm9yIFZMSU5FIHdhaXRzLgogICogUEFDS0VUMCAtIFZMSU5FX1NU
QVJUX0VORCArIHZhbHVlCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
