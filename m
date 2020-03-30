Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6505C2D0EE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBA9206CC
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukD1GMur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBA9206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE156E395;
	Mon, 30 Mar 2020 13:55:43 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B9B6E39C;
 Mon, 30 Mar 2020 13:55:42 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id h9so21715168wrc.8;
 Mon, 30 Mar 2020 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=flGhpt37sp9XD/VKJktequW1z/Op/EL2iIAVEZzSQBY=;
 b=ukD1GMur4S+QTAoLF74CoIO1QIAlOXbes+YwAQgkkrnSRcEsyI3+k4LVHMo6Wf9gO+
 r8ePkc5xHo9Ai+wVWG15g+w7uZhvkhxpoAFKO6Hd0EzcBmnup0sFzPOSXUPpiDIHQ3i7
 OOryRgQa8ncZf683e9LoFy2Zq6/oh9uJYtvkxJgZDkmDs4p1w6Vk3QKMWw7zvuckVSKs
 tGPTT2PofymB/CtXzigsthqMHYEqP3nC1uDRK0JNfoVMYtzl1C7edM5AkcmbwdSS8qvB
 xIs/82L97m9LGJz84/C7G3Vej2rGfmAXziFpheIQ2NdVuGCxjarBCUv88RPJS1Ut5ikC
 B1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=flGhpt37sp9XD/VKJktequW1z/Op/EL2iIAVEZzSQBY=;
 b=imffyoDZ1MA3insYWImDYesSoEK72FflCXhtU1DXc/55Yz+pkKIWE1Ktxgv0ubFobE
 pBaYll2nSl7jIdK4bt2MqvPf0OJAUPen/vCk27d19pMYRbNH1MQ+CLhsMusiaNTj/gap
 VZM5A0Q8Ebwv7WP6vEvMvEOTfwfZjoPVI88ftCVdChdlS3dhY/esAZ74nWCVjlm9e63A
 7Rf0uXy6mI1uNpAfYtOkdsemka9P7HRqWKai73LH0raGbszp9mhevK7CS+8wLm8KpcTD
 ugfdeWBiBHQeRQFadF7+0/mRAUBTsjQ459UDwaW6q9rzEDpXpwvK13oyJPWshtaq6h/Q
 6I9Q==
X-Gm-Message-State: ANhLgQ0oInvMqvJikQg2Bo6KgMojZsVnlP2PWZ/wD3XHTTZc8Udy310w
 56Csdzmtb+DoHlDSB0prJF7QKeyL
X-Google-Smtp-Source: ADFU+vtlYfEqAjI36K3qJBBMU3B5Z7OVQPlDIw+hWEBkANe8Q+PCMFNPsizZ5Ych+K/fj5ik3qzfCQ==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr16350429wra.157.1585576541175; 
 Mon, 30 Mar 2020 06:55:41 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f999:5819:bfe0:10e8])
 by smtp.gmail.com with ESMTPSA id z16sm22267660wrr.56.2020.03.30.06.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:55:40 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch
Subject: [PATCH 6/6] drm/amdgpu: improve amdgpu_gem_info debugfs file
Date: Mon, 30 Mar 2020 15:55:36 +0200
Message-Id: <20200330135536.2997-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330135536.2997-1-christian.koenig@amd.com>
References: <20200330135536.2997-1-christian.koenig@amd.com>
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

Tm90ZSBpZiBhIGJ1ZmZlciB3YXMgaW1wb3J0ZWQgdXNpbmcgcGVlcjJwZWVyLgoKU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDQgKysrLQogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZW0uYwppbmRleCA0Mjc3MTI1YTc5ZWUuLmU0MjYwODExNWM5OSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwpAQCAtMjksNiArMjksNyBAQAog
I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgogI2luY2x1ZGUgPGxpbnV4L3BhZ2VtYXAuaD4KICNp
bmNsdWRlIDxsaW51eC9wY2kuaD4KKyNpbmNsdWRlIDxsaW51eC9kbWEtYnVmLmg+CiAKICNpbmNs
dWRlIDxkcm0vYW1kZ3B1X2RybS5oPgogI2luY2x1ZGUgPGRybS9kcm1fZGVidWdmcy5oPgpAQCAt
ODU0LDcgKzg1NSw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RlYnVnZnNfZ2VtX2JvX2luZm8oaW50
IGlkLCB2b2lkICpwdHIsIHZvaWQgKmRhdGEpCiAJYXR0YWNobWVudCA9IFJFQURfT05DRShiby0+
dGJvLmJhc2UuaW1wb3J0X2F0dGFjaCk7CiAKIAlpZiAoYXR0YWNobWVudCkKLQkJc2VxX3ByaW50
ZihtLCAiIGltcG9ydGVkIGZyb20gJXAiLCBkbWFfYnVmKTsKKwkJc2VxX3ByaW50ZihtLCAiIGlt
cG9ydGVkIGZyb20gJXAlcyIsIGRtYV9idWYsCisJCQkgICBhdHRhY2htZW50LT5wZWVyMnBlZXIg
PyAiIFAyUCIgOiAiIik7CiAJZWxzZSBpZiAoZG1hX2J1ZikKIAkJc2VxX3ByaW50ZihtLCAiIGV4
cG9ydGVkIGFzICVwIiwgZG1hX2J1Zik7CiAKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
