Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1A7C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 11:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D2C222B9
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 11:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKXEMdaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D2C222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937446E4CA;
	Mon,  2 Nov 2020 11:33:59 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340B16E4C5
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 11:33:58 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id 33so3386721wrl.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 03:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EPUvZgVvJzJKHx2KJU3H6O2kJaYh6AEziWvTHaqaugg=;
 b=FKXEMdaSPC36Cv8irzk68v/oUjSql/AzdZRSnW5+PmZZcYop15Mz2NOa7bVKfSrPJC
 fauCspHK+VeMmi1HRJPmXqm/Ll81LvOBlEB5XJmf5OvRb/aYK089wuoGmiRBasPMuNnQ
 7O8IDwTPwLVgi8DXCqCrTVNHVNi3Wsbee0HaX6dTtVufUnopPG00JkdqgzRjHn6R0t3q
 pdeORmnk1wLcIJz+dLky0MD89M0Ca3z6AlwwtCKfWxtcYXBU07bb5ob7cCSHNH7Jb4nU
 qg8Q7BVWHWuK1Ak33u3RDsKzbRDMSJ6hebhOghdDKgL7mrMsrr62crGUB/J1HQeYeKLR
 jytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EPUvZgVvJzJKHx2KJU3H6O2kJaYh6AEziWvTHaqaugg=;
 b=bpwm8A0rc2dsGzGAsTjeJ7g9wutAmTePcXx5Li5st6kBv/lGmPgbc0w/puiYWFRTLg
 PnCEZyKvq8iep/cs9lmXzUVJ980ymjjQLiUOV6eXskd9e6Hq1m6iFQhu6p0IUvWJW31o
 qug7fajn5MoJUdzHRRZlmKlnSrW1EdBqpCVFFghKgykbLHDD/ttK75FJzTaXnTV132Nb
 9ZQx4que4LLBJ+8VwJ4hUild0CkbZ2fYMBiUmvvs0owfGcR+bh1yruJ2eIpdbDtWCqsI
 MCKP5DGLamiaNphNtW72WVC67E7KNXspfxglBCBnJx7QNekUImS7DykC1a/AWCICrSzd
 dp6Q==
X-Gm-Message-State: AOAM532mB/f3oQWJxtxcP256ezS3NdlNOEC9okMRh2EQWYkiS3tVuULU
 h4wwrHxJNjc1r21aoSenht2GJjKknF0=
X-Google-Smtp-Source: ABdhPJx30GSSiNbVDRVUOqGzX2JA9pHjWFChiQkcryLSlLOFEVWzhePFRa1cqcxvFFbZEsDKioRv5A==
X-Received: by 2002:a5d:6ca8:: with SMTP id a8mr5464202wra.319.1604316836752; 
 Mon, 02 Nov 2020 03:33:56 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:a78e:a39c:fa5b:5ef5])
 by smtp.gmail.com with ESMTPSA id 205sm15572704wme.38.2020.11.02.03.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 03:33:56 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	felix.kuehling@amd.com
Subject: [PATCH 3/3] drm/amdgpu: make sure retry faults are handled in a work
 item on Vega
Date: Mon,  2 Nov 2020 12:33:53 +0100
Message-Id: <20201102113353.1422-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102113353.1422-1-christian.koenig@amd.com>
References: <20201102113353.1422-1-christian.koenig@amd.com>
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

TG9va3MgbGlrZSB3ZSBjYW4ndCBlbmFibGVkIHRoZSBJSDEvSUgyIGZlYXR1cmUgZm9yIFZlZ2Ey
MCwgbWFrZSBzdXJlCnJldHJ5IGZhdWx0cyBhcmUgaGFuZGxlZCBvbiBhIHNlcGFyYXRlIHJpbmcg
YW55d2F5LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgfCAz
MSArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5j
CmluZGV4IDBjMzQyMWQ1ODdlOC4uMzJhNmMxNWMyZTA4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192OV8wLmMKQEAgLTUyNCwxNCArNTI0LDI5IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBf
cHJvY2Vzc19pbnRlcnJ1cHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJYWRkciA9ICh1
NjQpZW50cnktPnNyY19kYXRhWzBdIDw8IDEyOwogCWFkZHIgfD0gKCh1NjQpZW50cnktPnNyY19k
YXRhWzFdICYgMHhmKSA8PCA0NDsKIAotCWlmIChyZXRyeV9mYXVsdCAmJiBhbWRncHVfZ21jX2Zp
bHRlcl9mYXVsdHMoYWRldiwgYWRkciwgZW50cnktPnBhc2lkLAotCQkJCQkJICAgIGVudHJ5LT50
aW1lc3RhbXApKQotCQlyZXR1cm4gMTsgLyogVGhpcyBhbHNvIHByZXZlbnRzIHNlbmRpbmcgaXQg
dG8gS0ZEICovCi0KLQkvKiBJZiBpdCdzIHRoZSBmaXJzdCBmYXVsdCBmb3IgdGhpcyBhZGRyZXNz
LCBwcm9jZXNzIGl0IG5vcm1hbGx5ICovCi0JaWYgKHJldHJ5X2ZhdWx0ICYmICFpbl9pbnRlcnJ1
cHQoKSAmJgotCSAgICBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KGFkZXYsIGVudHJ5LT5wYXNpZCwg
YWRkcikpCi0JCXJldHVybiAxOyAvKiBUaGlzIGFsc28gcHJldmVudHMgc2VuZGluZyBpdCB0byBL
RkQgKi8KKwlpZiAocmV0cnlfZmF1bHQpIHsKKwkJLyogUmV0dXJuaW5nIDEgaGVyZSBhbHNvIHBy
ZXZlbnRzIHNlbmRpbmcgdGhlIElWIHRvIHRoZSBLRkQgKi8KKworCQkvKiBQcm9jZXNzIGl0IG9u
eWwgaWYgaXQncyB0aGUgZmlyc3QgZmF1bHQgZm9yIHRoaXMgYWRkcmVzcyAqLworCQlpZiAoZW50
cnktPmloICE9ICZhZGV2LT5pcnEuaWhfc29mdCAmJgorCQkgICAgYW1kZ3B1X2dtY19maWx0ZXJf
ZmF1bHRzKGFkZXYsIGFkZHIsIGVudHJ5LT5wYXNpZCwKKwkJCQkJICAgICBlbnRyeS0+dGltZXN0
YW1wKSkKKwkJCXJldHVybiAxOworCisJCS8qIERlbGVnYXRlIGl0IHRvIGEgZGlmZmVyZW50IHJp
bmcgaWYgdGhlIGhhcmR3YXJlIGhhc24ndAorCQkgKiBhbHJlYWR5IGRvbmUgaXQuCisJCSAqLwor
CQlpZiAoaW5faW50ZXJydXB0KCkpIHsKKwkJCWFtZGdwdV9pcnFfZGVsZWdhdGUoYWRldiwgZW50
cnksIDgpOworCQkJcmV0dXJuIDE7CisJCX0KKworCQkvKiBUcnkgdG8gaGFuZGxlIHRoZSByZWNv
dmVyYWJsZSBwYWdlIGZhdWx0cyBieSBmaWxsaW5nIHBhZ2UKKwkJICogdGFibGVzCisJCSAqLwor
CQlpZiAoYW1kZ3B1X3ZtX2hhbmRsZV9mYXVsdChhZGV2LCBlbnRyeS0+cGFzaWQsIGFkZHIpKQor
CQkJcmV0dXJuIDE7CisJfQogCiAJaWYgKCFwcmludGtfcmF0ZWxpbWl0KCkpCiAJCXJldHVybiAw
OwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
