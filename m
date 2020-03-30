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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FEEC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34C72073B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbmcqUGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34C72073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39036E391;
	Mon, 30 Mar 2020 13:55:40 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEF76E37C;
 Mon, 30 Mar 2020 13:55:39 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id m11so15857894wrx.10;
 Mon, 30 Mar 2020 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+BWRnJ8KXZzTygkAEOzwJ4EywuPuBldAaJ/F/uW5F1A=;
 b=hbmcqUGm+bB2hlXT83SV4DAQ20RajSxIDbWAn1LaX6S7HqwTN7HnztA1ytaHNby9O9
 KUPr2A6ZWabxaRt1lC1Y83llYW/F7S9pMBdXeEzs3MA0QxzeEf4nXYLn1yqgSW1LXNsM
 gISl74/0UdfxbjK8Cg0bXnMBYpUe5WS4u/Jc1zUGgFgzRSwcMS3uxvw5TRwBfox+tF68
 L0GAUPfB6pvSlvopEyJuJw4dLRbmIWr4vc2gMSsdGXcQ7CMrvf7C7d0//ovDQ9vw+w50
 jQgg7v/ntMKJ3R/G8elGApK/0clXhh3yyJFDq01PGViG5vklQCgXPUa0LKQgaWvQttyH
 NbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+BWRnJ8KXZzTygkAEOzwJ4EywuPuBldAaJ/F/uW5F1A=;
 b=dFYyuKkmuHEH1JubIHvi2fsakBFlPZcAU75uqHg3srg4BjBrcpEdxUovMU+anW+iqs
 BSExGhZV+QidjdBkaXjJOQjDfRzEXI84+kqW8q5W6bdIS/JFOrOxG8Y2ptDj4gi5F+Kt
 8BBncHKaT1b5pErdTyyygQGT9FqM56ZbgrwSnlS8L+VuvMTawrfu7pBDwK5TY9u7rlay
 UEBd4Jb5IdId1OD1OviQSz30nfWH0K/qG4R2aeUcyDmq8IqzC7/JVoaRnh9jUpRWLxpW
 gRhXulXQgrWIdcJusW2kghIRNCHw1dTi4pe1VQmiyP87V4wPStUwmmTZu7lqd/4atPhO
 WdfA==
X-Gm-Message-State: ANhLgQ0Rw6i4XmIJjyN07VsexIMciXZBRD5KPsdEbzthdVoG1DXQaEzf
 JO5stK/+Dv2n++z2I2tYCnEEKBcJ
X-Google-Smtp-Source: ADFU+vv+IdhZ8SU2SdEAThhT9hm6aiXvpCW6ZI5rDdAN9bBWyuaZ5SURZGHev45NC08PAnbLNB+uAQ==
X-Received: by 2002:adf:dec3:: with SMTP id i3mr15905524wrn.351.1585576537889; 
 Mon, 30 Mar 2020 06:55:37 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f999:5819:bfe0:10e8])
 by smtp.gmail.com with ESMTPSA id z16sm22267660wrr.56.2020.03.30.06.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:55:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch
Subject: [PATCH 2/6] drm/ttm: lock resv object during destruction
Date: Mon, 30 Mar 2020 15:55:32 +0200
Message-Id: <20200330135536.2997-2-christian.koenig@amd.com>
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

Q2FsbGluZyB0dG1fYm9fY2xlYW51cF9tZW10eXBlX3VzZSgpIGRlc3Ryb3lzIHRoZSBUVCBvYmpl
Y3QKd2hpY2ggaW4gdHVybiBjb3VsZCByZXN1bHQgaW4gd2FybmluZ3Mgd2l0aG91dCB0aGlzLgoK
U2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vdHRtL3R0bV9iby5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwppbmRl
eCA5ZTA3YzNmNzUxNTYuLmY3M2I4MWMyNTc2ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fYm8uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCkBAIC01ODgs
NyArNTg4LDggQEAgc3RhdGljIHZvaWQgdHRtX2JvX3JlbGVhc2Uoc3RydWN0IGtyZWYgKmtyZWYp
CiAJCXR0bV9tZW1faW9fdW5sb2NrKG1hbik7CiAJfQogCi0JaWYgKCFkbWFfcmVzdl90ZXN0X3Np
Z25hbGVkX3JjdShiby0+YmFzZS5yZXN2LCB0cnVlKSkgeworCWlmICghZG1hX3Jlc3ZfdGVzdF9z
aWduYWxlZF9yY3UoYm8tPmJhc2UucmVzdiwgdHJ1ZSkgfHwKKwkgICAgIWRtYV9yZXN2X3RyeWxv
Y2soYm8tPmJhc2UucmVzdikpIHsKIAkJLyogVGhlIEJPIGlzIG5vdCBpZGxlLCByZXN1cnJlY3Qg
aXQgZm9yIGRlbGF5ZWQgZGVzdHJveSAqLwogCQl0dG1fYm9fZmx1c2hfYWxsX2ZlbmNlcyhibyk7
CiAJCWJvLT5kZWxldGVkID0gdHJ1ZTsKQEAgLTYyMSw2ICs2MjIsNyBAQCBzdGF0aWMgdm9pZCB0
dG1fYm9fcmVsZWFzZShzdHJ1Y3Qga3JlZiAqa3JlZikKIAlzcGluX3VubG9jaygmdHRtX2JvX2ds
b2IubHJ1X2xvY2spOwogCiAJdHRtX2JvX2NsZWFudXBfbWVtdHlwZV91c2UoYm8pOworCWRtYV9y
ZXN2X3VubG9jayhiby0+YmFzZS5yZXN2KTsKIAogCUJVR19PTihiby0+bWVtLm1tX25vZGUgIT0g
TlVMTCk7CiAJYXRvbWljX2RlYygmdHRtX2JvX2dsb2IuYm9fY291bnQpOwotLSAKMi4xNy4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
