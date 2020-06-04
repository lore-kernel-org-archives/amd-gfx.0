Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8ADC433E5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 08:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A4D207DA
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 08:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IqxGBAw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A4D207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10E06E2D6;
	Thu,  4 Jun 2020 08:12:40 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D023B6E2CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 08:12:39 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id r15so4610753wmh.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z86jDMPjYosEVmpvz8g87itNg+tEFmiX7DLzwmjjruY=;
 b=IqxGBAw7Ux8mFxKbZqFfhWHBvUThVxHGPJeIMG6V8JAySneDzg1MMfr9dhIgUYw2Fn
 OTAZ0xbCrYCL4eXPkPqfd9hDPavzifvRAdCmfeUmSdOIDkGg1FY43BlyAFoqsAL1182F
 slvaQBsul976QOmZFtX03fE52IJl/0XI4phXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z86jDMPjYosEVmpvz8g87itNg+tEFmiX7DLzwmjjruY=;
 b=i1jZpJb2trBwevqQPn0wSglGA3ZVeYwFafsGtTPT1K9b8nOWm2LopoW9KS+brSsLfe
 5APvzp/mobcsrycvFkcQ5GEWW2BVeoXvgTe/IlZ1eXvyVhRXFyOnHqWJcTMNSwu7RJ7g
 +VBWCn/ekowxNS3Wy5Pjiw6HeDaSWC1sZVFwd7Qh4HeTIhN9hfJmrLUQ3JeHJa0/C+/F
 CdkwFHuhCgutmBFQb6hjv4o1FSmobV16D0x2QE97IMFblcbeTfjWZCGJ6rffwGz9Y4th
 Cb8geBm0JuRLpiowG1gkxabw0QAZKPgRgDNZSUglhlvog2h91wUH7Q9NDtpgMdgxH9JR
 qlEg==
X-Gm-Message-State: AOAM532nz+If9Ecf0Ju0bvGdsjElqE7OOPRqCSF/ek7Qox0bttdToRi2
 hoUBtzzDwR+WXXohXer5X4snBw==
X-Google-Smtp-Source: ABdhPJyKQbuv5baACXqVPivWSRwfBW+Y73i/xXeG533ND6BCj6YxPKujbnsSL0XPuqc9zCvklUc7sg==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr3041108wmj.121.1591258358519; 
 Thu, 04 Jun 2020 01:12:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 01:12:37 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 05/18] drm/vkms: Annotate vblank timer
Date: Thu,  4 Jun 2020 10:12:11 +0200
Message-Id: <20200604081224.863494-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
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
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, linux-rdma@vger.kernel.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, linaro-mm-sig@lists.linaro.org,
 Daniel Vetter <daniel@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBpcyBuZWVkZWQgdG8gc2lnbmFsIHRoZSBmZW5jZXMgZnJvbSBwYWdlIGZsaXBzLCBhbm5v
dGF0ZSBpdAphY2NvcmRpbmdseS4gV2UgbmVlZCB0byBhbm5vdGF0ZSBlbnRpcmUgdGltZXIgY2Fs
bGJhY2sgc2luY2UgaWYgd2UgZ2V0CnN0dWNrIGFueXdoZXJlIGluIHRoZXJlLCB0aGVuIHRoZSB0
aW1lciBzdG9wcywgYW5kIGhlbmNlIGZlbmNlcyBzdG9wLgpKdXN0IGFubm90YXRpbmcgdGhlIHRv
cCBwYXJ0IHRoYXQgZG9lcyB0aGUgdmJsYW5rIGhhbmRsaW5nIGlzbid0CmVub3VnaC4KCkNjOiBs
aW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJv
Lm9yZwpDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCkNjOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBDaHJp
cyBXaWxzb24gPGNocmlzQGNocmlzLXdpbHNvbi5jby51az4KQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0
IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+CkNjOiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IERhbmllbCBWZXR0ZXIg
PGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPgpDYzogUm9kcmlnbyBTaXF1ZWlyYSA8cm9kcmlnb3Np
cXVlaXJhbWVsb0BnbWFpbC5jb20+CkNjOiBIYW5lZW4gTW9oYW1tZWQgPGhhbW9oYW1tZWQuc2FA
Z21haWwuY29tPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS92a21zL3ZrbXNfY3J0Yy5jIHwgOCArKysrKysrLQogMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS92a21zL3ZrbXNfY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL3ZrbXMvdmttc19jcnRjLmMK
aW5kZXggYWM4NWUxNzQyOGY4Li5hNTNhNDA4NDhhNzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS92a21zL3ZrbXNfY3J0Yy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS92a21zL3ZrbXNfY3J0
Yy5jCkBAIC0xLDUgKzEsNyBAQAogLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAr
CiAKKyNpbmNsdWRlIDxsaW51eC9kbWEtZmVuY2UuaD4KKwogI2luY2x1ZGUgPGRybS9kcm1fYXRv
bWljLmg+CiAjaW5jbHVkZSA8ZHJtL2RybV9hdG9taWNfaGVscGVyLmg+CiAjaW5jbHVkZSA8ZHJt
L2RybV9wcm9iZV9oZWxwZXIuaD4KQEAgLTE0LDcgKzE2LDkgQEAgc3RhdGljIGVudW0gaHJ0aW1l
cl9yZXN0YXJ0IHZrbXNfdmJsYW5rX3NpbXVsYXRlKHN0cnVjdCBocnRpbWVyICp0aW1lcikKIAlz
dHJ1Y3QgZHJtX2NydGMgKmNydGMgPSAmb3V0cHV0LT5jcnRjOwogCXN0cnVjdCB2a21zX2NydGNf
c3RhdGUgKnN0YXRlOwogCXU2NCByZXRfb3ZlcnJ1bjsKLQlib29sIHJldDsKKwlib29sIHJldCwg
ZmVuY2VfY29va2llOworCisJZmVuY2VfY29va2llID0gZG1hX2ZlbmNlX2JlZ2luX3NpZ25hbGxp
bmcoKTsKIAogCXJldF9vdmVycnVuID0gaHJ0aW1lcl9mb3J3YXJkX25vdygmb3V0cHV0LT52Ymxh
bmtfaHJ0aW1lciwKIAkJCQkJICBvdXRwdXQtPnBlcmlvZF9ucyk7CkBAIC00OSw2ICs1Myw4IEBA
IHN0YXRpYyBlbnVtIGhydGltZXJfcmVzdGFydCB2a21zX3ZibGFua19zaW11bGF0ZShzdHJ1Y3Qg
aHJ0aW1lciAqdGltZXIpCiAJCQlEUk1fREVCVUdfRFJJVkVSKCJDb21wb3NlciB3b3JrZXIgYWxy
ZWFkeSBxdWV1ZWRcbiIpOwogCX0KIAorCWRtYV9mZW5jZV9lbmRfc2lnbmFsbGluZyhmZW5jZV9j
b29raWUpOworCiAJcmV0dXJuIEhSVElNRVJfUkVTVEFSVDsKIH0KIAotLSAKMi4yNi4yCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
