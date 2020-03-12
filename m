Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7081C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 11:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDA22071B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 11:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiSle+rU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDA22071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B056E13D;
	Thu, 12 Mar 2020 11:12:07 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D282D6E13D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 11:12:05 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a5so5640069wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6fV7b2MezeaZCJxEd0TpBoHRatDJ+2AvOuJVipIcAG0=;
 b=jiSle+rUlucxLqTG3nmapaOuBnLybLOBp8g8ujR91SqWwgtZQ7tOKNuaUnAjs+uY5U
 jxck88al2aN7HsMBirzA5kc34zuRTg4B1c77lcBjL8T8nnXrBNAbLcBPLyvh9WWqORsR
 LglG7vArfvMHgr6Idnki/sgksnEiXj3U5JeCoKfu/OLD/u4UgJPT7ui21pz75z97Z1/L
 QhWU4LZP7KQHuVdBzGeI+cq8d1tHXdUITFnGVEfJhLfbZvNqc4GmNS6ZLSc/J0+ysFy7
 9vdSEtY9N19F5HOsjcMsjw0N5PlmmChGA+2GR+naA3cb2snbvzqURlNCCNsBni0AbYMI
 W81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6fV7b2MezeaZCJxEd0TpBoHRatDJ+2AvOuJVipIcAG0=;
 b=CD/1jB+EesAMD4YR2FJZf6w74IarDOYdappbU1DKXo9WgFNBCGU7CGV6j/smshucaR
 Hli6eiSnambRENPIsZq49llx7WU6YQb/rTzIdbV6T772DcICCFkPyV6P189e02CS5ZcG
 7gvWVAp68/0IJND08P5FZ0FCWuZEJEnouM6/ejC/7jegpiIZMkCUUL8uGP26Qbfwyqfg
 /6ZYeQQBgovjQozcsHJiH/ZAeyV8d9m6v/d3iVDVErSiKSpFtkR0A4FIxO/WsJksw3en
 yvuAkIiXv6S0/9aVWJf5EQcwFJncDMFPP7z6KVw2xYdbisqFihLtulQbNc7Zq+fC04xF
 yNBA==
X-Gm-Message-State: ANhLgQ0D6BgFbNALHf1LWdh6Z2nv5J5basETBlmX4rkLngMEMLMMVjg1
 dEe7coYfhNvYm61V4bXyS3vQQDHl
X-Google-Smtp-Source: ADFU+vuELv6FRxK2/r4wTiSDqIbOwAKJzV2Y0RUWuuKv/bH0k8LhnxGDVTnqO9Za2Ntiy2fZGZZocw==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr3036230wmb.93.1584011524451;
 Thu, 12 Mar 2020 04:12:04 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:10d:1a7b:497f:9a16])
 by smtp.gmail.com with ESMTPSA id p10sm10680546wru.4.2020.03.12.04.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 04:12:04 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Xinhui.Pan@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
Date: Thu, 12 Mar 2020 12:12:03 +0100
Message-Id: <20200312111203.81500-1-christian.koenig@amd.com>
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
cmUgYWRkaW5nIHRoZQpzaGFyZWQgY2xlYXIgZmVuY2UuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgNDEgKysrKysrKysrKysrKysrLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwppbmRleCA0Mjc3MTI1YTc5ZWUuLjA3ODIx
NjJmYjVmMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwpAQCAtMTYx
LDEwICsxNjEsMTEgQEAgdm9pZCBhbWRncHVfZ2VtX29iamVjdF9jbG9zZShzdHJ1Y3QgZHJtX2dl
bV9vYmplY3QgKm9iaiwKIAogCXN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeSB2bV9wZDsKIAlz
dHJ1Y3QgbGlzdF9oZWFkIGxpc3QsIGR1cGxpY2F0ZXM7CisJc3RydWN0IGRtYV9mZW5jZSAqZmVu
Y2UgPSBOVUxMOwogCXN0cnVjdCB0dG1fdmFsaWRhdGVfYnVmZmVyIHR2OwogCXN0cnVjdCB3d19h
Y3F1aXJlX2N0eCB0aWNrZXQ7CiAJc3RydWN0IGFtZGdwdV9ib192YSAqYm9fdmE7Ci0JaW50IHI7
CisJbG9uZyByOwogCiAJSU5JVF9MSVNUX0hFQUQoJmxpc3QpOwogCUlOSVRfTElTVF9IRUFEKCZk
dXBsaWNhdGVzKTsKQEAgLTE4MiwyNCArMTgzLDMyIEBAIHZvaWQgYW1kZ3B1X2dlbV9vYmplY3Rf
Y2xvc2Uoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosCiAJCXJldHVybjsKIAl9CiAJYm9fdmEg
PSBhbWRncHVfdm1fYm9fZmluZCh2bSwgYm8pOwotCWlmIChib192YSAmJiAtLWJvX3ZhLT5yZWZf
Y291bnQgPT0gMCkgewotCQlhbWRncHVfdm1fYm9fcm12KGFkZXYsIGJvX3ZhKTsKKwlpZiAoIWJv
X3ZhIHx8IC0tYm9fdmEtPnJlZl9jb3VudCkKKwkJZ290byBvdXRfdW5sb2NrOwogCi0JCWlmIChh
bWRncHVfdm1fcmVhZHkodm0pKSB7Ci0JCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7
CisJYW1kZ3B1X3ZtX2JvX3JtdihhZGV2LCBib192YSk7CisJaWYgKCFhbWRncHVfdm1fcmVhZHko
dm0pKQorCQlnb3RvIG91dF91bmxvY2s7CiAKLQkJCXIgPSBhbWRncHVfdm1fY2xlYXJfZnJlZWQo
YWRldiwgdm0sICZmZW5jZSk7Ci0JCQlpZiAodW5saWtlbHkocikpIHsKLQkJCQlkZXZfZXJyKGFk
ZXYtPmRldiwgImZhaWxlZCB0byBjbGVhciBwYWdlICIKLQkJCQkJInRhYmxlcyBvbiBHRU0gb2Jq
ZWN0IGNsb3NlICglZClcbiIsIHIpOwotCQkJfQogCi0JCQlpZiAoZmVuY2UpIHsKLQkJCQlhbWRn
cHVfYm9fZmVuY2UoYm8sIGZlbmNlLCB0cnVlKTsKLQkJCQlkbWFfZmVuY2VfcHV0KGZlbmNlKTsK
LQkJCX0KLQkJfQotCX0KKwlyID0gYW1kZ3B1X3ZtX2NsZWFyX2ZyZWVkKGFkZXYsIHZtLCAmZmVu
Y2UpOworCWlmIChyIHx8ICFmZW5jZSkKKwkJZ290byBvdXRfdW5sb2NrOworCisJciA9IGRtYV9y
ZXN2X3dhaXRfdGltZW91dF9yY3UoYm8tPnRiby5iYXNlLnJlc3YsIGZhbHNlLCBmYWxzZSwKKwkJ
CQkgICAgICBtc2Vjc190b19qaWZmaWVzKDEwKSk7CisJaWYgKHIgPT0gMCkKKwkJciA9IC1FVElN
RURPVVQ7CisJaWYgKHIpCisJCWdvdG8gb3V0X3VubG9jazsKKworCWFtZGdwdV9ib19mZW5jZShi
bywgZmVuY2UsIHRydWUpOworCWRtYV9mZW5jZV9wdXQoZmVuY2UpOworCitvdXRfdW5sb2NrOgor
CWlmICh1bmxpa2VseShyKSkKKwkJZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY2xlYXIg
cGFnZSAiCisJCQkidGFibGVzIG9uIEdFTSBvYmplY3QgY2xvc2UgKCVkKVxuIiwgcik7CiAJdHRt
X2V1X2JhY2tvZmZfcmVzZXJ2YXRpb24oJnRpY2tldCwgJmxpc3QpOwogfQogCi0tIAoyLjE3LjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
