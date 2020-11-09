Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7515C61DD8
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A7F206ED
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDRSOmaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A7F206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956D389725;
	Mon,  9 Nov 2020 21:21:47 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5DB89590
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:20 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a65so922560wme.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mNbwgos7EBbAiIS/whVqYV59kF6ty8MKTbhrWe3Hj/4=;
 b=vDRSOmaOWfnFuTXwEONPBcO8vJz7zF39LmqlgHPib6OIXViysSis7axMfLToI6uzcL
 fflPl+k/7ZFLIGyyXOLQ3TiIrfwGxSkGA9MmRO2uUcGtCt0kGjl+uBPJRp3aPomVX1BF
 EsHIQZXRDK9Vnv4zD/sgKAUuLnYw0kUHMXsav4ieFfUvp3ZnOj++Jot2LssQVDnBcsPx
 39lCcPvgMs9bMyUsvFNk7r5g109XNQaut2J9n314ZUar9st0RyOSYygednECLaUvqshj
 UwCOwCaWkMWuHpYepBA4xCTKSRCE/Z6mWJww+6Zuk694xH4pxg0gQXodu1LbNfYithWA
 sLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mNbwgos7EBbAiIS/whVqYV59kF6ty8MKTbhrWe3Hj/4=;
 b=ZWLwIBH+9txGVpT1qptvZGl+2GX05cuevfjhW0zkE68CaSLnpBEQGQR0yvHvCrsZO8
 Mq5HAiVOe+547XXpkmyXlK7upb9/OLla+Cd4PZC/HJAIMPSWYuGn4rmwCYrA7o+Zrg3P
 9k6CI5xkDc+6oeI3magoqU6qNnZyrPg+NEHrlWYtA7NC61sA/2xp7eMhChsVIK5U2iv/
 BnNMaqsIA0D4ntXt6WVZI9lCo87mpE4yPVpQd1siAeITOaPcGCHztS1WD4ht4dtkie40
 OIxc6haPiDvJq1ofYKYPKZvE8O4XM7oB1u0giZkdbpsbqXFigayyhaRmiacXntKEU5uI
 6uPw==
X-Gm-Message-State: AOAM531a3IhfTCmM0/pWy2UMbxpmEYHEjA066gEWOXcRrGK4UYPhl8bO
 ntj+OLlQwZQlaCRELJ9mXg+qmA==
X-Google-Smtp-Source: ABdhPJwXSIdyefVkSvwIj9A5z6/yqfw7C2R6xM1Kyh7ySdKYokfnHteeebzlBmPFWZibPYCJ4/B5lg==
X-Received: by 2002:a1c:9950:: with SMTP id b77mr1103869wme.123.1604956758642; 
 Mon, 09 Nov 2020 13:19:18 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:18 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 06/20] drm/radeon/radeon_connectors: Strip out set but unused
 variable 'ret'
Date: Mon,  9 Nov 2020 21:18:41 +0000
Message-Id: <20201109211855.3340030-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:21:41 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY29ubmVjdG9ycy5jOiBJbiBmdW5jdGlvbiDigJhyYWRl
b25fc2V0dXBfbXN0X2Nvbm5lY3RvcuKAmToKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X2Nvbm5lY3RvcnMuYzoyNTc0Ojc6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHJldOKAmSBzZXQgYnV0
IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQoKQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpD
YzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9m
Zi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9jb25uZWN0b3JzLmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9jb25uZWN0b3JzLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9jb25uZWN0b3JzLmMKaW5kZXggZTMwODM0NDM0NDQyNS4uNjA3YWQ1NjIwYmQ5OSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY29ubmVjdG9ycy5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Nvbm5lY3RvcnMuYwpAQCAtMjU3MSwxMyAr
MjU3MSwxMSBAQCB2b2lkIHJhZGVvbl9zZXR1cF9tc3RfY29ubmVjdG9yKHN0cnVjdCBkcm1fZGV2
aWNlICpkZXYpCiAJCXJldHVybjsKIAogCWxpc3RfZm9yX2VhY2hfZW50cnkoY29ubmVjdG9yLCAm
ZGV2LT5tb2RlX2NvbmZpZy5jb25uZWN0b3JfbGlzdCwgaGVhZCkgewotCQlpbnQgcmV0OwotCiAJ
CXJhZGVvbl9jb25uZWN0b3IgPSB0b19yYWRlb25fY29ubmVjdG9yKGNvbm5lY3Rvcik7CiAKIAkJ
aWYgKGNvbm5lY3Rvci0+Y29ubmVjdG9yX3R5cGUgIT0gRFJNX01PREVfQ09OTkVDVE9SX0Rpc3Bs
YXlQb3J0KQogCQkJY29udGludWU7CiAKLQkJcmV0ID0gcmFkZW9uX2RwX21zdF9pbml0KHJhZGVv
bl9jb25uZWN0b3IpOworCQlyYWRlb25fZHBfbXN0X2luaXQocmFkZW9uX2Nvbm5lY3Rvcik7CiAJ
fQogfQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
