Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94883C388F9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6AB22243
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3cTKLla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6AB22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71356ECB1;
	Tue,  3 Nov 2020 13:58:44 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99CF36ECAC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 13:58:43 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id gn41so6936964ejc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 05:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=B0s53oQFZSsuySPKeDO5gBj87CKNFuM3CWXiP0WWHc0=;
 b=t3cTKLla2B9jcS7L8+OP6tyu93SEBP1Wm0WH0qrTl8mFv8RFGKORq2HkgushRK60yL
 cf6+vT/UnWPIYLrVj/kP80H6u/djk1/8WRNUx7KjBoAv7Jp7ivs4wMBMpT/klH+drQ3Q
 EzquHgBkzzHAVlFope4Y2czHtRwn3bUP+683/8X0NpPqNII94byrOyhSjj6vVHizHb2J
 91VtnomfuHOSlZDPk+G8qGb9jmOt+ziKDeTgdch1iJ6s/6jaLVDSzVsi7I0c4zilC+fg
 zrXBkizvIqEx04i9sub+GMbHAwkKRme/zcOTzSBV3j/VXYbLBW6Mg988kmQoVutuFTNs
 O9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B0s53oQFZSsuySPKeDO5gBj87CKNFuM3CWXiP0WWHc0=;
 b=OhaXToswSC+dAYQZ4kcpoFuftTpOFRxrqUABvVtGujEOBhBpa2uHDZeMheLky3G7g+
 DwekFsWfwacrvrFAs9BzvdxwG8cKdqA//6zvgCteihRbo8zq0gn9wQ4pByJQXy+jG0lO
 yl0Tpr8WrysfSFNKoodfOQvVAZP/rIZ9GY0WciCnGESaL+OryKs62HsTHAknZLmRJHYJ
 F+BGA+KPlgkPdnV/lq4bIvEzna4SgdJIHlydyfrY/a6wrEtFf/Q49nAhTSyJptaXuBee
 diJZwSoEPr6S8rlVbMj2tDeyFcq4vxXxr1I9/V9zlBd889wiD2XQ+qQevXEfABoDRzaj
 igyA==
X-Gm-Message-State: AOAM532xVWrrb4DXEOM8PUcQHKH6QolnR/kanTTiF4SNYw3xgPl22+IE
 +22dZmp2TSi2+XDpNWtC5nK3LUtezW4=
X-Google-Smtp-Source: ABdhPJxwsDyxUrky0A9t3bHDSQB88uGi+I2ZW6ZlYlAPUs5er8FPUKeOWXpMEwajIPYqRrlQx5m6VA==
X-Received: by 2002:a17:906:d1ce:: with SMTP id
 bs14mr19667763ejb.548.1604411922078; 
 Tue, 03 Nov 2020 05:58:42 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f3a2:b920:33f3:da11])
 by smtp.gmail.com with ESMTPSA id j6sm7903263edy.87.2020.11.03.05.58.41
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 05:58:41 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu: enabled software IH ring for Vega
Date: Tue,  3 Nov 2020 14:58:34 +0100
Message-Id: <20201103135837.39693-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103135837.39693-1-christian.koenig@amd.com>
References: <20201103135837.39693-1-christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VlbXMgbGlrZSB3ZSB3b24ndCBnZXQgdGhlIGhhcmR3YXJlIElIMS8yIHJpbmdzIG9uIFZlZ2Ey
MCB3b3JraW5nLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5j
IHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYwppbmRleCA0MDdjNjA5M2MyZWMuLmNlZjYxZGQ0NmEz
NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKQEAgLTkxLDYgKzkxLDkg
QEAgc3RhdGljIHZvaWQgdmVnYTEwX2loX2VuYWJsZV9pbnRlcnJ1cHRzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQogCQl9CiAJCWFkZXYtPmlycS5paDIuZW5hYmxlZCA9IHRydWU7CiAJfQor
CisJaWYgKGFkZXYtPmlycS5paF9zb2Z0LnJpbmdfc2l6ZSkKKwkJYWRldi0+aXJxLmloX3NvZnQu
ZW5hYmxlZCA9IHRydWU7CiB9CiAKIC8qKgpAQCAtNjA2LDYgKzYwOSwxMCBAQCBzdGF0aWMgaW50
IHZlZ2ExMF9paF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIAlhZGV2LT5pcnEuaWgyLnVzZV9kb29y
YmVsbCA9IHRydWU7CiAJYWRldi0+aXJxLmloMi5kb29yYmVsbF9pbmRleCA9IChhZGV2LT5kb29y
YmVsbF9pbmRleC5paCArIDIpIDw8IDE7CiAKKwlyID0gYW1kZ3B1X2loX3JpbmdfaW5pdChhZGV2
LCAmYWRldi0+aXJxLmloX3NvZnQsIFBBR0VfU0laRSwgdHJ1ZSk7CisJaWYgKHIpCisJCXJldHVy
biByOworCiAJciA9IGFtZGdwdV9pcnFfaW5pdChhZGV2KTsKIAogCXJldHVybiByOwotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
