Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FEBC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 14:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2BF20663
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 14:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p60lmwaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2BF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A836FD0D;
	Thu, 23 Jan 2020 14:21:28 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8367E6FD09
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 14:21:27 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id m24so2757095wmc.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 06:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uUsNr7hSPbIdP4nOQj92O1frfybjFcKOB/W9zvBhRyQ=;
 b=p60lmwaOkK7KDOKuue7KPq3sVw5DjGRBK+L7LMh5xIF9pfRwZuMMujetpAY7T3kMyX
 jEN8Hrg62Ssr/o54Iw1eKqUV0omt0OPhG8NPIrAjv17K4kjiDDc9zUxWJ7eMeP5dK/0a
 i7hvW1SpD869yhukxkxhry6mrQFc6Nlv6ETwKl2W7n+4G8Y9jLE+4uy7ggFASj34RG7Q
 vjp6bClbq0JXlKnRwR5D10Vs53hxIuT8nsOzJcsEeynrQnekRvEql4jHhAMLOqTEgTn3
 tX7p5Els6BeYovVWX91digNuvFOpH4oY/AXsOYfw6BuGlND/y3Uk0sn7wp5gPgr7Z4st
 i2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uUsNr7hSPbIdP4nOQj92O1frfybjFcKOB/W9zvBhRyQ=;
 b=WJRxSlazItLAPUzstKG4U70Tl7qb2Vt0yb0/CZYe9IRYLQpdE5NpNlPKn9OgQuDUX2
 F8xDgyJhcABBQgbwxrUyXv1907sc49EER414nilFcyVNN7J8QTN1/HMVTLkvJk+dT56z
 ClZCef/JVooFwFPJRuNl0eFfJis8MSQCQ26Krnu/Pty27v4q5Sg2dA4FfpPZ3tP8Mbh2
 /R73/GkU58/nor9B0B5Yi7g11AWijm2jcZs+VcTDg3MYBw8FFK8Ci2I97zmUyLwjcWWy
 2iYtJuRa9CX6Do4NW+561Eyz4EsOFsIfNuGjGU16JS18IUxMmd+TvdpziNz830YfyVj1
 MNOw==
X-Gm-Message-State: APjAAAVi7KggneHw5bTjuVy3kKF3A06rnRxJvIfl3yNxBuDQtzFsEvyl
 R5GTftwfN4f9J+C70V1yGdo=
X-Google-Smtp-Source: APXvYqw3ILpE3YwC308Tdjrzlzzeq3mEgJJMAVXpFjMyENR751tnL2IGFqF9Jr6uBnAWH7ddcdHr9A==
X-Received: by 2002:a05:600c:21c5:: with SMTP id
 x5mr4603381wmj.72.1579789286208; 
 Thu, 23 Jan 2020 06:21:26 -0800 (PST)
Received: from baker.fritz.box ([2a02:908:1252:fb60:4c9d:da69:4490:b03e])
 by smtp.gmail.com with ESMTPSA id w19sm2713286wmc.22.2020.01.23.06.21.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 06:21:25 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tom.stdenis@amd.com, amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com
Subject: [PATCH 3/4] drm/amdgpu: simplify and fix amdgpu_sync_resv
Date: Thu, 23 Jan 2020 15:21:21 +0100
Message-Id: <20200123142122.4084-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200123142122.4084-1-christian.koenig@amd.com>
References: <20200123142122.4084-1-christian.koenig@amd.com>
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

Tm8gbWF0dGVyIHdoYXQgd2UgYWx3YXlzIG5lZWQgdG8gc3luYyB0byBtb3Zlcy4KClNpZ25lZC1v
ZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jIHwgMTUgKysrKysrKysrKyst
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYwppbmRleCBjMTI0ZjY0ZTdhYWUu
LjlmNDIwMzI2NzZkYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3N5bmMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5j
CkBAIC0yMzIsMTAgKzIzMiwxOSBAQCBpbnQgYW1kZ3B1X3N5bmNfcmVzdihzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9zeW5jICpzeW5jLAogCiAJCWYgPSByY3VfZGVy
ZWZlcmVuY2VfcHJvdGVjdGVkKGZsaXN0LT5zaGFyZWRbaV0sCiAJCQkJCSAgICAgIGRtYV9yZXN2
X2hlbGQocmVzdikpOworCisJCWZlbmNlX293bmVyID0gYW1kZ3B1X3N5bmNfZ2V0X293bmVyKGYp
OworCisJCS8qIEFsd2F5cyBzeW5jIHRvIG1vdmVzLCBubyBtYXR0ZXIgd2hhdCAqLworCQlpZiAo
ZmVuY2Vfb3duZXIgPT0gQU1ER1BVX0ZFTkNFX09XTkVSX1VOREVGSU5FRCkgeworCQkJciA9IGFt
ZGdwdV9zeW5jX2ZlbmNlKHN5bmMsIGYsIGZhbHNlKTsKKwkJCWlmIChyKQorCQkJCWJyZWFrOwor
CQl9CisKIAkJLyogV2Ugb25seSB3YW50IHRvIHRyaWdnZXIgS0ZEIGV2aWN0aW9uIGZlbmNlcyBv
bgogCQkgKiBldmljdCBvciBtb3ZlIGpvYnMuIFNraXAgS0ZEIGZlbmNlcyBvdGhlcndpc2UuCiAJ
CSAqLwotCQlmZW5jZV9vd25lciA9IGFtZGdwdV9zeW5jX2dldF9vd25lcihmKTsKIAkJaWYgKGZl
bmNlX293bmVyID09IEFNREdQVV9GRU5DRV9PV05FUl9LRkQgJiYKIAkJICAgIG93bmVyICE9IEFN
REdQVV9GRU5DRV9PV05FUl9VTkRFRklORUQpCiAJCQljb250aW51ZTsKQEAgLTI2NSw5ICsyNzQs
NyBAQCBpbnQgYW1kZ3B1X3N5bmNfcmVzdihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3Ry
dWN0IGFtZGdwdV9zeW5jICpzeW5jLAogCQkJYnJlYWs7CiAKIAkJY2FzZSBBTURHUFVfU1lOQ19F
WFBMSUNJVDoKLQkJCWlmIChvd25lciAhPSBBTURHUFVfRkVOQ0VfT1dORVJfVU5ERUZJTkVEKQot
CQkJCWNvbnRpbnVlOwotCQkJYnJlYWs7CisJCQljb250aW51ZTsKIAkJfQogCiAJCXIgPSBhbWRn
cHVfc3luY19mZW5jZShzeW5jLCBmLCBmYWxzZSk7Ci0tIAoyLjE0LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
