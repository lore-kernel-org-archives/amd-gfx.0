Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B87C0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B989420575
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjfyHezC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B989420575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763DC8941E;
	Mon, 16 Mar 2020 13:22:40 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FDC18941E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:22:38 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id z12so8841722wmf.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mfq5hfQBAKIX1qP2EFNSuAHyIS19dwtLe6E3kXSR3X0=;
 b=YjfyHezCjn8gDKddUzqQ14qcEvz5xz0kcmzFoRbSGmVN0/1WqXpHHyJlTXAsfxRXr7
 V2poO+QyuYVP60Briak8MggjDxWBnBbyaBhWHhOMIFV2fJyNESgN6T2NK6hYycaoDMG3
 gVQEyxz0DwOkEfRS7mf1ZigUIOGiDnVyO+J9FyIqtyCRN12qzOECZnTMdlIrfjLGXHHK
 gMhcTEoZyaALYaaVuR8QXwdWU5qMAqqounm+hBgM4UNssIKcfrx5F1jS9lncNFvRCVZr
 RdSfUVCQOi2pPvKQnpyIOdRabBS+Hj5TQRgU8dGKkUgFE9FxPpnAdrWKkmepw0IfoyxP
 YNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mfq5hfQBAKIX1qP2EFNSuAHyIS19dwtLe6E3kXSR3X0=;
 b=Lt0qL/Pm82YRjmGQtKZoX5OEJawydgM+I9sgYLx/E6E+xjCnPTrXZUMPEV2xF5ghtx
 zkIcgb2ghxlIRNFj780uVS8Kb+H7VQufpYhJNQK6J8ZR1z4VylMjnhd5QjfjFpRN7Hgt
 /n6CwzvqXm+q0MnzGrPdK20zIQjGtP7h1992d1OeWab7LXQGAbnc8mHvCVX1/j0avr7q
 dEBNe0yLyq8agXKUiWHBx0Gj3EbFbZ1c/ODJdbrtSnaProjUMj5dqTTGM3Dz/Vs998CI
 t85yrCm+tm7BLqrgl4CJj7RQX81Hwrs/FDsloEdwJB6C9OCtqdPak+iks+wvDZuuEdwp
 9Mmw==
X-Gm-Message-State: ANhLgQ2t2hb28XG/fEcbdI1Rw1Cy8If3TOeNqOBo19S65pXnXVUHweCr
 UdofQE6VPZumNnO4cVkwHw4=
X-Google-Smtp-Source: ADFU+vu21AmiphDU/ZD2LJdaOTCO3LVpnUBxbxZRfn+aPKIZ3t8/cJp2XLLOE4CpXZN5vOx1F5y2oA==
X-Received: by 2002:a1c:6387:: with SMTP id x129mr28049564wmb.58.1584364957120; 
 Mon, 16 Mar 2020 06:22:37 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:2c1f:1edc:f578:8c15])
 by smtp.gmail.com with ESMTPSA id d15sm92344015wrp.37.2020.03.16.06.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 06:22:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Xinhui.Pan@amd.com,
	amd-gfx@lists.freedesktop.org,
	Monk.Liu@amd.com
Subject: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close v2
Date: Mon, 16 Mar 2020 14:22:35 +0100
Message-Id: <20200316132235.82022-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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

VGhlIHByb2JsZW0gaXMgdGhhdCB3ZSBjYW4ndCBhZGQgdGhlIGNsZWFyIGZlbmNlIHRvIHRoZSBC
Twp3aGVuIHRoZXJlIGlzIGFuIGV4Y2x1c2l2ZSBmZW5jZSBvbiBpdCBzaW5jZSB3ZSBjYW4ndApn
dWFyYW50ZWUgdGhlIHRoZSBjbGVhciBmZW5jZSB3aWxsIGNvbXBsZXRlIGFmdGVyIHRoZQpleGNs
dXNpdmUgb25lLgoKVG8gZml4IHRoaXMgcmVmYWN0b3IgdGhlIGZ1bmN0aW9uIGFuZCB3YWl0IGZv
ciBhbnkgcG90ZW50aWFsCmV4Y2x1c2l2ZSBmZW5jZSB3aXRoIGEgc21hbGwgdGltZW91dCBiZWZv
cmUgYWRkaW5nIHRoZQpzaGFyZWQgY2xlYXIgZmVuY2UuCgp2MjogZml4IHdhcm5pbmcKClNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCA0MyArKysrKysrKysr
KysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTcgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCmluZGV4IDVi
ZWM2NmU2YjFmOC4uNDljOTFkYWMzNWEwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2VtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dlbS5jCkBAIC0xNjEsMTAgKzE2MSwxMSBAQCB2b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Ns
b3NlKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqLAogCiAJc3RydWN0IGFtZGdwdV9ib19saXN0
X2VudHJ5IHZtX3BkOwogCXN0cnVjdCBsaXN0X2hlYWQgbGlzdCwgZHVwbGljYXRlczsKKwlzdHJ1
Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7CiAJc3RydWN0IHR0bV92YWxpZGF0ZV9idWZmZXIg
dHY7CiAJc3RydWN0IHd3X2FjcXVpcmVfY3R4IHRpY2tldDsKIAlzdHJ1Y3QgYW1kZ3B1X2JvX3Zh
ICpib192YTsKLQlpbnQgcjsKKwlsb25nIHI7CiAKIAlJTklUX0xJU1RfSEVBRCgmbGlzdCk7CiAJ
SU5JVF9MSVNUX0hFQUQoJmR1cGxpY2F0ZXMpOwpAQCAtMTc4LDI4ICsxNzksMzYgQEAgdm9pZCBh
bWRncHVfZ2VtX29iamVjdF9jbG9zZShzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwKIAlyID0g
dHRtX2V1X3Jlc2VydmVfYnVmZmVycygmdGlja2V0LCAmbGlzdCwgZmFsc2UsICZkdXBsaWNhdGVz
KTsKIAlpZiAocikgewogCQlkZXZfZXJyKGFkZXYtPmRldiwgImxlYWtpbmcgYm8gdmEgYmVjYXVz
ZSAiCi0JCQkid2UgZmFpbCB0byByZXNlcnZlIGJvICglZClcbiIsIHIpOworCQkJIndlIGZhaWwg
dG8gcmVzZXJ2ZSBibyAoJWxkKVxuIiwgcik7CiAJCXJldHVybjsKIAl9CiAJYm9fdmEgPSBhbWRn
cHVfdm1fYm9fZmluZCh2bSwgYm8pOwotCWlmIChib192YSAmJiAtLWJvX3ZhLT5yZWZfY291bnQg
PT0gMCkgewotCQlhbWRncHVfdm1fYm9fcm12KGFkZXYsIGJvX3ZhKTsKKwlpZiAoIWJvX3ZhIHx8
IC0tYm9fdmEtPnJlZl9jb3VudCkKKwkJZ290byBvdXRfdW5sb2NrOwogCi0JCWlmIChhbWRncHVf
dm1fcmVhZHkodm0pKSB7Ci0JCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7CisJYW1k
Z3B1X3ZtX2JvX3JtdihhZGV2LCBib192YSk7CisJaWYgKCFhbWRncHVfdm1fcmVhZHkodm0pKQor
CQlnb3RvIG91dF91bmxvY2s7CiAKLQkJCXIgPSBhbWRncHVfdm1fY2xlYXJfZnJlZWQoYWRldiwg
dm0sICZmZW5jZSk7Ci0JCQlpZiAodW5saWtlbHkocikpIHsKLQkJCQlkZXZfZXJyKGFkZXYtPmRl
diwgImZhaWxlZCB0byBjbGVhciBwYWdlICIKLQkJCQkJInRhYmxlcyBvbiBHRU0gb2JqZWN0IGNs
b3NlICglZClcbiIsIHIpOwotCQkJfQogCi0JCQlpZiAoZmVuY2UpIHsKLQkJCQlhbWRncHVfYm9f
ZmVuY2UoYm8sIGZlbmNlLCB0cnVlKTsKLQkJCQlkbWFfZmVuY2VfcHV0KGZlbmNlKTsKLQkJCX0K
LQkJfQotCX0KKwlyID0gYW1kZ3B1X3ZtX2NsZWFyX2ZyZWVkKGFkZXYsIHZtLCAmZmVuY2UpOwor
CWlmIChyIHx8ICFmZW5jZSkKKwkJZ290byBvdXRfdW5sb2NrOworCisJciA9IGRtYV9yZXN2X3dh
aXRfdGltZW91dF9yY3UoYm8tPnRiby5iYXNlLnJlc3YsIGZhbHNlLCBmYWxzZSwKKwkJCQkgICAg
ICBtc2Vjc190b19qaWZmaWVzKDEwKSk7CisJaWYgKHIgPT0gMCkKKwkJciA9IC1FVElNRURPVVQ7
CisJaWYgKHIpCisJCWdvdG8gb3V0X3VubG9jazsKKworCWFtZGdwdV9ib19mZW5jZShibywgZmVu
Y2UsIHRydWUpOworCWRtYV9mZW5jZV9wdXQoZmVuY2UpOworCitvdXRfdW5sb2NrOgorCWlmICh1
bmxpa2VseShyIDwgMCkpCisJCWRldl9lcnIoYWRldi0+ZGV2LCAiZmFpbGVkIHRvIGNsZWFyIHBh
Z2UgIgorCQkJInRhYmxlcyBvbiBHRU0gb2JqZWN0IGNsb3NlICglbGQpXG4iLCByKTsKIAl0dG1f
ZXVfYmFja29mZl9yZXNlcnZhdGlvbigmdGlja2V0LCAmbGlzdCk7CiB9CiAKLS0gCjIuMTcuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
