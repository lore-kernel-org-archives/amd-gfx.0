Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F17C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 12:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554B664F77
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 12:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554B664F77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 021936E19A;
	Fri, 19 Mar 2021 12:25:15 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1338E6E19A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 12:25:13 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id l4so9385082ejc.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KDfrTHVgqIAU6weIR9NiL46b6w2aCeoFIxCS5c381Hk=;
 b=qk4x4ubJ/PlPRh4BL8YS5UeqP1zhwcBNPYpYQdQ2jsTKlAIysi+zvYO9m4j1imrszj
 YWKD05h0u1OR+Eidc01MneWogqsFg8lA0CBtbVzsJxbqZeVdjlJTnrV/lLyynsfrhNAZ
 vUvWh70pmPv9NJnvLtHOUEFbg0QHcgADTcXJ1dnvhSKHtWZGaAP1n6LWLAZ+5JzR05wO
 Vf0if3zcAlqVY0ciWLEQdYJzUOzlslg8D7gPZw7VcSliGRZHtWjDVH4hUpsh7YFpFBH4
 mI6MaQAkQuxpYIV2nPXIexz7AQRCCEhyMxthCsKt3EUHp3J2pzbdOKN69SpCEzWwWsKt
 /chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KDfrTHVgqIAU6weIR9NiL46b6w2aCeoFIxCS5c381Hk=;
 b=RqUp2zbAcPHrj50OcNCVU/Lho9J0Y10RehCjaXdIKP8wHGAsP+eQqMCdAfvQr81Tq7
 7hIGWEbywh625aXdlLGcwsCIgIhqMGAQOhMIUcnNCzQIWAYEmZDd4f3eYOWJCYB/xYw5
 9ZP6qM3zVAf7ms2Ks/8L/xBZVjpV4bZ10m6CCCRtva2l+UJBASaSFub6nY46pdPYhViX
 BvGpXwSKsivJ1Y4ls5sWyXC1SKmKLSdkFuPuDj7+I50cHrI6n///5oRY/Ydqtm1IRnK1
 lTy0zKHGji8tbDay9JkgJwMVDjSeRH1dYWbI+zCJJxWGkcI0jOIXD8gVFlzdPYvTgWYi
 1bOA==
X-Gm-Message-State: AOAM530l5gAF3b2hWA1rZQX3kTBCQRT7BtkT59WrGwifrgvT+Obu+D6h
 VO4whorM8svHyhDoAuHk2RZ/yYqdV9U=
X-Google-Smtp-Source: ABdhPJx8DmJGBNCYMXRThlN2rAy6a9E/7pigwRXwix8QzLWn04haoSRqDADQpVGEd4equCiT/idQrA==
X-Received: by 2002:a17:906:a097:: with SMTP id
 q23mr4099663ejy.353.1616156711819; 
 Fri, 19 Mar 2021 05:25:11 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:64b:678:72a6:d79f])
 by smtp.gmail.com with ESMTPSA id j14sm3930332edr.97.2021.03.19.05.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 05:25:11 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove irq_src->data handling
Date: Fri, 19 Mar 2021 13:25:10 +0100
Message-Id: <20210319122510.24377-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Emily.Deng@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhdCBpcyB1bnVzZWQgZm9yIHF1aXRlIHNvbWUgdGltZSBub3cuCgpTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jIHwgNSAtLS0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2lycS5oIHwgMSAtCiAyIGZpbGVzIGNoYW5nZWQsIDYgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ly
cS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCmluZGV4IGFmMDI2
MTA5NDIxYS4uMDM0MTI1NDM0MjdhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfaXJxLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2lycS5jCkBAIC0zODIsMTEgKzM4Miw2IEBAIHZvaWQgYW1kZ3B1X2lycV9maW5pKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQogCiAJCQlrZnJlZShzcmMtPmVuYWJsZWRfdHlwZXMpOwogCQkJ
c3JjLT5lbmFibGVkX3R5cGVzID0gTlVMTDsKLQkJCWlmIChzcmMtPmRhdGEpIHsKLQkJCQlrZnJl
ZShzcmMtPmRhdGEpOwotCQkJCWtmcmVlKHNyYyk7Ci0JCQkJYWRldi0+aXJxLmNsaWVudFtpXS5z
b3VyY2VzW2pdID0gTlVMTDsKLQkJCX0KIAkJfQogCQlrZnJlZShhZGV2LT5pcnEuY2xpZW50W2ld
LnNvdXJjZXMpOwogCQlhZGV2LT5pcnEuY2xpZW50W2ldLnNvdXJjZXMgPSBOVUxMOwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5oIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5oCmluZGV4IGFjNTI3ZTVkZWFlNi4uY2Y2MTE2
NjQ4MzIyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJx
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5oCkBAIC02Miw3
ICs2Miw2IEBAIHN0cnVjdCBhbWRncHVfaXJxX3NyYyB7CiAJdW5zaWduZWQJCQkJbnVtX3R5cGVz
OwogCWF0b21pY190CQkJCSplbmFibGVkX3R5cGVzOwogCWNvbnN0IHN0cnVjdCBhbWRncHVfaXJx
X3NyY19mdW5jcwkqZnVuY3M7Ci0Jdm9pZCAqZGF0YTsKIH07CiAKIHN0cnVjdCBhbWRncHVfaXJx
X2NsaWVudCB7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
