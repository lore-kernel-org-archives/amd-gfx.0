Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F97CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6A2217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6A2217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC2F6EA9E;
	Mon, 28 Oct 2019 21:43:17 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33A66EA9E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:15 +0000 (UTC)
Received: by mail-yb1-xb44.google.com with SMTP id i6so4643443ybe.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eXNIgNyIpKliPo5bixSq8PM86XlU7yVh3tY4R/mkD0Y=;
 b=UgnP+XsmJ3KCx6M1iJfSn9Ql5WPARK8eK1cScV4CdO1iIK6AvhSLV7h3HAqjRDyZRL
 jWFBJlGGrUhTke925I8TYKeQQu4/+9whNawhVxhM2+IWAplofMqaRMtyVEN/Vj5iMScn
 Ua5fZS5Xc5TkmSovhAZ3lrwO9x39GKh+bhkOpZoe2ivTwxOAYoYkwd2vg6exm25lQOnj
 MppzxBQ2mV9IDoaRDj1zbc6Rr7YIkAB665NJoj0H+P+OIiJdNw4FTcPeWATGir5bRkvi
 DIPMoMcwAjW6BeX8JGcIWDPrV9XFJ3bmw7ySKQ0hYvTsp3u3uO8GXTDYsJ2qN9Mio3J9
 IV+Q==
X-Gm-Message-State: APjAAAWApSp04jeLrz4rcx9Y88tkMJNq9tRoXY/+2ODlIaclwAmywjfh
 8f7QIhy2oLe2llRoN7qN1s2xlQzWbbM=
X-Google-Smtp-Source: APXvYqzNT7GEIPMtaSo6h4t8I/mdhjZDjJNV67RaEbCP5CY5SYQfPt9+Q7xGW8BazMPUyayh6R3RKg==
X-Received: by 2002:a25:ef07:: with SMTP id g7mr15226083ybd.393.1572298994763; 
 Mon, 28 Oct 2019 14:43:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 08/21] drm/amdgpu: add a amdgpu_device_supports_baco helper
Date: Mon, 28 Oct 2019 17:42:03 -0400
Message-Id: <20191028214216.1508370-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eXNIgNyIpKliPo5bixSq8PM86XlU7yVh3tY4R/mkD0Y=;
 b=XK5fSFBfdmb8SL5KSu2rHXfGvpYnW2a8k1+P6yi0MLg27S0AZ8BqUg+o3nUjjRmCvq
 oAQXpImnvXAbetX09xtK6xYpI2sT5UWfCYvMyxHYLwMX83f3GfIqcRBS8CcTCp4e0LCw
 ecHt/KpUDGH018DRYRRfo8iiL2OuzQjlPDK1mlFeHlKeWYueAMCJVxrkGlbwrX1HdGCm
 KTVtJx+3Fr9qziE53Mu3FgOYIhxq6BNWi8n3/C6NMDtlwKJ75WoVGLb1cYgi54uMDlbW
 ZwcbGPdHmuq/KL94utBTap6El9H4BEBI2jOhc3MVez2AzA4NnRzxhIuN47RK6f6nZMIn
 u9aA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028214203.Grer9b9otdeLv-Jccz1MdWipnlMNsNtw13CFjcfxhHQ@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpUbyBjaGVjayBpZiBhIGRldmljZSBzdXBwb3J0
cyBCQUNPIG9yIG5vdC4gIFRoaXMgd2lsbCBiZQp1c2VkIGluIGRldGVybWluaW5nIHdoZW4gdG8g
ZW5hYmxlIHJ1bnRpbWUgcG0uCgpSZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1k
LmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgICB8ICAx
ICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDE1ICsrKysr
KysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaAppbmRleCAwMGNjNDNmNzRiZTEuLjhiZGFmMWM3ODRlNSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKQEAgLTExMzksNiArMTEzOSw3IEBAIHZvaWQg
YW1kZ3B1X2RldmljZV9wcm9ncmFtX3JlZ2lzdGVyX3NlcXVlbmNlKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCQkJCQkgICAgIGNvbnN0IHUzMiBhcnJheV9zaXplKTsKIAogYm9vbCBhbWRn
cHVfZGV2aWNlX2lzX3B4KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpOworYm9vbCBhbWRncHVfZGV2
aWNlX3N1cHBvcnRzX2JhY28oc3RydWN0IGRybV9kZXZpY2UgKmRldik7CiBib29sIGFtZGdwdV9k
ZXZpY2VfaXNfcGVlcl9hY2Nlc3NpYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJ
CSAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICpwZWVyX2FkZXYpOwogCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggNGVlZTQwYjlkMGIwLi44NTM1N2Jk
Mjg2M2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAg
LTE1NCw2ICsxNTQsMjEgQEAgYm9vbCBhbWRncHVfZGV2aWNlX2lzX3B4KHN0cnVjdCBkcm1fZGV2
aWNlICpkZXYpCiAJcmV0dXJuIGZhbHNlOwogfQogCisvKioKKyAqIGFtZGdwdV9kZXZpY2Vfc3Vw
cG9ydHNfYmFjbyAtIERvZXMgdGhlIGRldmljZSBzdXBwb3J0IEJBQ08KKyAqCisgKiBAZGV2OiBk
cm1fZGV2aWNlIHBvaW50ZXIKKyAqCisgKiBSZXR1cm5zIHRydWUgaWYgdGhlIGRldmljZSBzdXBw
b3J0ZSBCQUNPLAorICogb3RoZXJ3aXNlIHJldHVybiBmYWxzZS4KKyAqLworYm9vbCBhbWRncHVf
ZGV2aWNlX3N1cHBvcnRzX2JhY28oc3RydWN0IGRybV9kZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7CisKKwlyZXR1cm4gYW1kZ3B1
X2FzaWNfc3VwcG9ydHNfYmFjbyhhZGV2KTsKK30KKwogLyoqCiAgKiBWUkFNIGFjY2VzcyBoZWxw
ZXIgZnVuY3Rpb25zLgogICoKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
