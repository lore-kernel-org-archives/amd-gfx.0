Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96210C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 15:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FEF20767
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 15:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXPrxe1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FEF20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DED46E92E;
	Wed,  2 Sep 2020 15:21:05 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317E76E92E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 15:21:04 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id z9so4968557wmk.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QdoQlKAK8H7BjeLKMJQzrMlzHkrKKcADE8B6nLR+c/Q=;
 b=tXPrxe1lPYPEFiiWlgO0qwZP5hlOUQBMOUW8y8E8/+jXEaS9xAaAUs9BXSikChsVIc
 Q624+YSD/uIG0+rWuXMABkD+RYArQZBVcvJvgDVU8i0yXsUSc2x0qaJ9GG5WYg3Fo5cF
 6r4atuC8nql8/XpSSI5TIXrrbDT8mpnT6ICmq0ZACzgcKcIX1lv1aBGjWiVpc5x2OZKb
 NgxQlC+0uZ1BWd/4b4Xiferu2AaGVj64CvhGYBE/Bn1VlYWYzJJlp5K6t+3WIHNwQYAG
 p1gN2/q37MPlhmYgg1unhHWdcSO6dQCyGBdTiJIhsO+Z782K9vZ6OOg29EGMQ2msjG6f
 tRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QdoQlKAK8H7BjeLKMJQzrMlzHkrKKcADE8B6nLR+c/Q=;
 b=ATYYu8BaCdoiZVqEcu47bcWOY4Bu9WPpqwMwMik5gVg5olfVYqClArH0Vhdn8sZqbg
 Q5kR1U6geMN/v9BqEIoh89vr/GAo68MKE7RwlxzO16a4ZRE1KbY+r3uXkryE1kWw3+SJ
 /J9fZO64BR8TVG2c3QChUMutIN7ryDl0oqr3elDBAPLAEFblKGnSJC3swCBEP+flqVXb
 b50yiUyu9I08gCCM/vGoJzbEUN7QuYpPfSCSqp9HpgJBOUoyrelDR3hRX1Lv8iFWO6MI
 B+rcHhFEVbir/TQulTgc0cHkz6SvhZYhNJUKFh8IePXXdSfJD+J+AtExjkwxzkKsTUNe
 5MbQ==
X-Gm-Message-State: AOAM530XUnWlOU7GVcRtlVzAZt6Ys0sLZQpeFGaL2JhvxdKJmDxJGRo0
 TH7v0908krFw0rxsAmiBC7PyPVOmxuU=
X-Google-Smtp-Source: ABdhPJzvkZGK86uhXpyTg9wrhrXRozhp2pBq0vj6C6O6gxJekK4ynVJzUOzdSf4Qi8ZepZQcl1nxqw==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr1256782wml.25.1599060062655; 
 Wed, 02 Sep 2020 08:21:02 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:5c05:cb01:c7d7:658f])
 by smtp.gmail.com with ESMTPSA id 31sm10800wrd.26.2020.09.02.08.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 08:21:02 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Xinhui.Pan@amd.com
Subject: [PATCH] drm/amdgpu: fix max_entries calculation v3
Date: Wed,  2 Sep 2020 17:21:01 +0200
Message-Id: <20200902152101.2280-1-christian.koenig@amd.com>
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

Q2FsY3VsYXRlIHRoZSBjb3JyZWN0IHZhbHVlIGZvciBtYXhfZW50cmllcyBvciB3ZSBtaWdodCBy
dW4gYWZ0ZXIgdGhlCnBhZ2VfYWRkcmVzcyBhcnJheS4KCnYyOiBYaW5odWkgcG9pbnRlZCBvdXQg
d2UgZG9uJ3QgbmVlZCB0aGUgc2hpZnQKdjM6IHVzZSBsb2NhbCBjb3B5IG9mIHN0YXJ0IGFuZCBz
aW1wbGlmeSBzb21lIGNhbGN1bGF0aW9uCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkZpeGVzOiAxZTY5MWUyNDQ0ODcgZHJtL2FtZGdw
dTogc3RvcCBhbGxvY2F0aW5nIGR1bW15IEdUVCBub2RlcwotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKaW5kZXggOGJjMjI1MzkzOWJlLi43Y2JlZTFhN2VjODQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0xNjk3LDcgKzE2OTcsNyBAQCBzdGF0aWMgaW50IGFtZGdw
dV92bV9ib19zcGxpdF9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCUFN
REdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7CiAJCX0gZWxzZSB7CiAJCQlhZGRyID0gMDsKLQkJ
CW1heF9lbnRyaWVzID0gUzY0X01BWDsKKwkJCW1heF9lbnRyaWVzID0gbWFwcGluZy0+bGFzdCAt
IHN0YXJ0ICsgMTsKIAkJfQogCiAJCWlmIChwYWdlc19hZGRyKSB7CkBAIC0xNzI3LDcgKzE3Mjcs
NyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib19zcGxpdF9tYXBwaW5nKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAogCQkJYWRkciArPSBwZm4gPDwgUEFHRV9TSElGVDsKIAkJfQogCi0JCWxh
c3QgPSBtaW4oKHVpbnQ2NF90KW1hcHBpbmctPmxhc3QsIHN0YXJ0ICsgbWF4X2VudHJpZXMgLSAx
KTsKKwkJbGFzdCA9IHN0YXJ0ICsgbWF4X2VudHJpZXMgLSAxOwogCQlyID0gYW1kZ3B1X3ZtX2Jv
X3VwZGF0ZV9tYXBwaW5nKGFkZXYsIHZtLCBmYWxzZSwgZmFsc2UsIHJlc3YsCiAJCQkJCQlzdGFy
dCwgbGFzdCwgZmxhZ3MsIGFkZHIsCiAJCQkJCQlkbWFfYWRkciwgZmVuY2UpOwotLSAKMi4xNy4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
