Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38830C61DD8
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDEDD20678
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fASKJQ1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEDD20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 910D489CDE;
	Tue, 10 Nov 2020 19:35:53 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF9689BF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:36 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id w24so4331746wmi.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sNPdGWABv4jG6EjCUZH3w6oQTK+ox++FdPmHOUbRD6w=;
 b=fASKJQ1F2LCs/AXSrcItfdLVqsf0CAL2+ISvgcB4CsEelSk6mnK06tXoPNySTK7MHU
 1TEc5IRZOgZd6Q+mBlBBeCLeVUEo7SuJqHyCRR9YXaMmYcLXdhPNTgxIFrRW+Mh/TBVy
 2R0rZoZXmlUx7+E+do7U1FoKSGq6OyO/n8XM74q9QAJN8kiU3gqLtgxe7Twd8VZ0ZQr6
 BzEzhavEf5cCFsfsimr552j4Kqo7jIJ3YNsiNF2ht4DN0WNJJ+eSrIcXid5p/sbfUHdb
 MVorhUAzWurm5GkOqUYzYaThJsDwVkA5gWpGY6HJZZItFJohZ6GAEU17mxG6lF2296+z
 FhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sNPdGWABv4jG6EjCUZH3w6oQTK+ox++FdPmHOUbRD6w=;
 b=kAit8B4oslEemLuuL160X7ugHXyQ+6Fz/bEFlZeBFPrgviMjkDJQlnhIQZiQNwHXa8
 FvasfnkYO2cVeh1ptnuUdM0wN3kP6rwXbvyWemHr1M837teje/Z1bzNBj9Uisrlgq0NB
 7GF1tPC8+LRTIKm6YJtiSnhj7fJS4kWVGO9iDjVFWdBv6VgBa0Bxxl5AiBBkcs+eWs70
 Fev4+RJDLuSohkAFnjmjq4ZXxs2+2bMdz+U6v+0K1rh4/eRQT36KteZPataTwN85aG0Y
 /TCfaA+5hg9fCpztWte53A3SMfcK30HN1BZ2gqzJL7FQm7UDvtpi0k+13tyY+tqQbJpP
 hIjg==
X-Gm-Message-State: AOAM530x2/LnnU20NrAfCjz00im0D6bKebKNVQDEUFUizqIu+NIDb3Ue
 JS2UyHdETIY0mDI2oAoQ2RYfyw==
X-Google-Smtp-Source: ABdhPJwbSyUwCQvxoTz0sM425fPOU7xGkt033a2qrUmzUxTVV2GqCTMp1AIaiNCG/Jfa0ilVVhAaOA==
X-Received: by 2002:a1c:b041:: with SMTP id z62mr713702wme.183.1605036695387; 
 Tue, 10 Nov 2020 11:31:35 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:34 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 15/30] drm/radeon/cik_sdma: Demote vague attempt at kernel-doc
Date: Tue, 10 Nov 2020 19:30:57 +0000
Message-Id: <20201110193112.988999-16-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9jaWtfc2RtYS5jOjk0OTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1l
dGVyIG9yIG1lbWJlciAncmluZycgbm90IGRlc2NyaWJlZCBpbiAnY2lrX2RtYV92bV9mbHVzaCcK
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrX3NkbWEuYzo5NDk6IHdhcm5pbmc6IEZ1bmN0aW9u
IHBhcmFtZXRlciBvciBtZW1iZXIgJ3ZtX2lkJyBub3QgZGVzY3JpYmVkIGluICdjaWtfZG1hX3Zt
X2ZsdXNoJwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWtfc2RtYS5jOjk0OTogd2FybmluZzog
RnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAncGRfYWRkcicgbm90IGRlc2NyaWJlZCBpbiAn
Y2lrX2RtYV92bV9mbHVzaCcKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
Q2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRh
bmllbEBmZndsbC5jaD4KQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+
CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8t
bW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9u
ZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npa19zZG1hLmMgfCA0
ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npa19zZG1hLmMgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL2Npa19zZG1hLmMKaW5kZXggNjg0MDNlNzc3NTZkMy4uM2M3MDllYmU4ZDFh
YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWtfc2RtYS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrX3NkbWEuYwpAQCAtOTM2LDExICs5MzYsOSBAQCB2b2lk
IGNpa19zZG1hX3ZtX3BhZF9pYihzdHJ1Y3QgcmFkZW9uX2liICppYikKIAkJaWItPnB0cltpYi0+
bGVuZ3RoX2R3KytdID0gU0RNQV9QQUNLRVQoU0RNQV9PUENPREVfTk9QLCAwLCAwKTsKIH0KIAot
LyoqCisvKgogICogY2lrX2RtYV92bV9mbHVzaCAtIGNpayB2bSBmbHVzaCB1c2luZyBzRE1BCiAg
KgotICogQHJkZXY6IHJhZGVvbl9kZXZpY2UgcG9pbnRlcgotICoKICAqIFVwZGF0ZSB0aGUgcGFn
ZSB0YWJsZSBiYXNlIGFuZCBmbHVzaCB0aGUgVk0gVExCCiAgKiB1c2luZyBzRE1BIChDSUspLgog
ICovCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
