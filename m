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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F4C2D0E9
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 10:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4065205ED
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 10:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdq/a5ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4065205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5FE6E22A;
	Mon, 30 Mar 2020 10:50:39 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BBA6E11D
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 10:50:38 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id m11so15122053wrx.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 03:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jUhJdnIxBRqATrGF9T8IZFzo7hMcMEqDBvOt3fBwuJE=;
 b=kdq/a5eaSehu0wXxAMZpZjqKp1MhITjmTh2B4xH12BuWMotGueAjtNO954Hn99u/UI
 7SY5w/o9Ldvj/a5tBBixbelabSL2YpKcwE0V1uGW2MpnDPY3+DhGZsh0Nkn94LcCj7L2
 3V5P3Shcp5D5yopnV8TLbqvh/NUMlhVznwJ+i1uprp20YEYAnAgmZtYuiDJek1EGs1cn
 ryDHvD4ddgkNOgSYUbAWY93Hzn+ygAtyZOSAWUbhc+fpYivIJd3HVJDdu1eCeRnnLR2t
 iAilWNQ23xUGI0ehQM3vp+iu9NeAOMXcf5z5LvnD8LIQdxwogyGqSgWXw4e+46+XROp0
 sTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jUhJdnIxBRqATrGF9T8IZFzo7hMcMEqDBvOt3fBwuJE=;
 b=h0X1qN8Uk5eO4PRRhBpwPwgn8FUjidEevcMjP7/l1Bkr2h0QLL4aYJOxbzhrEzbu/q
 FOuDjDBJIBeRJp6UAWWbnR3LbIcmh8iKY6vpG0N26hmKF3MPZ0NkGt1E1HYr3bA6rUfM
 PcfSVhY2FqloMaGCqZRnPBmqg6ud66iS3nOHVrVmaSu5V46a3f46VCkqCnakvLCecWVL
 x/MjooUORQLchWv14T0pPcM2LIQ9q2OX2SzRbz/ejSl6r2x9AFwSqE3iHStXa4XH3qmt
 lVT5KieK7jq6jhJWlfiiqRtPaT4QTrnj9ian1Tkv/bAuhR0BocdpvivYjCjqNd/piZzJ
 EAyw==
X-Gm-Message-State: ANhLgQ2z7H6xF93/omejDWEUHYCHRRXZu1bzwjV5n2HAOGMiSAe0rZgV
 0F0cLDks1rkox/cVfeFIJeU=
X-Google-Smtp-Source: ADFU+vtdMboXZ7DGzynVU8J4cj+ct/+GVQXFaaJsys4Movse1r1OK4Vr1Nr4tAaRs8JdBQ8GvKNe9w==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr13687266wrn.381.1585565436880; 
 Mon, 30 Mar 2020 03:50:36 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:cdad:b6f9:8132:4b7c])
 by smtp.gmail.com with ESMTPSA id g186sm21665028wmg.36.2020.03.30.03.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 03:50:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Xinhui.Pan@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix and cleanup amdgpu_gem_object_close v2
Date: Mon, 30 Mar 2020 12:50:34 +0200
Message-Id: <20200330105035.105045-1-christian.koenig@amd.com>
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
dXNpdmUgb25lLgoKVG8gZml4IHRoaXMgcmVmYWN0b3IgdGhlIGZ1bmN0aW9uIGFuZCBhbHNvIGFk
ZCB0aGUgZXhjbHVzaXZlCmZlbmNlIGFzIHNoYXJlZCB0byB0aGUgcmVzdiBvYmplY3QuCgp2Mjog
Zml4IHdhcm5pbmcKdjM6IGFkZCBleGNsIGZlbmNlIGFzIHNoYXJlZCBpbnN0ZWFkCgpTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgNDEgKysrKysrKysrKysr
KystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE4IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
ZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwppbmRleCA1YmVj
NjZlNmIxZjguLmEwYmU4MDUxM2U5NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dlbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZW0uYwpAQCAtMTYxLDE2ICsxNjEsMTcgQEAgdm9pZCBhbWRncHVfZ2VtX29iamVjdF9jbG9z
ZShzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwKIAogCXN0cnVjdCBhbWRncHVfYm9fbGlzdF9l
bnRyeSB2bV9wZDsKIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3QsIGR1cGxpY2F0ZXM7CisJc3RydWN0
IGRtYV9mZW5jZSAqZmVuY2UgPSBOVUxMOwogCXN0cnVjdCB0dG1fdmFsaWRhdGVfYnVmZmVyIHR2
OwogCXN0cnVjdCB3d19hY3F1aXJlX2N0eCB0aWNrZXQ7CiAJc3RydWN0IGFtZGdwdV9ib192YSAq
Ym9fdmE7Ci0JaW50IHI7CisJbG9uZyByOwogCiAJSU5JVF9MSVNUX0hFQUQoJmxpc3QpOwogCUlO
SVRfTElTVF9IRUFEKCZkdXBsaWNhdGVzKTsKIAogCXR2LmJvID0gJmJvLT50Ym87Ci0JdHYubnVt
X3NoYXJlZCA9IDE7CisJdHYubnVtX3NoYXJlZCA9IDI7CiAJbGlzdF9hZGQoJnR2LmhlYWQsICZs
aXN0KTsKIAogCWFtZGdwdV92bV9nZXRfcGRfYm8odm0sICZsaXN0LCAmdm1fcGQpOwpAQCAtMTc4
LDI4ICsxNzksMzIgQEAgdm9pZCBhbWRncHVfZ2VtX29iamVjdF9jbG9zZShzdHJ1Y3QgZHJtX2dl
bV9vYmplY3QgKm9iaiwKIAlyID0gdHRtX2V1X3Jlc2VydmVfYnVmZmVycygmdGlja2V0LCAmbGlz
dCwgZmFsc2UsICZkdXBsaWNhdGVzKTsKIAlpZiAocikgewogCQlkZXZfZXJyKGFkZXYtPmRldiwg
ImxlYWtpbmcgYm8gdmEgYmVjYXVzZSAiCi0JCQkid2UgZmFpbCB0byByZXNlcnZlIGJvICglZClc
biIsIHIpOworCQkJIndlIGZhaWwgdG8gcmVzZXJ2ZSBibyAoJWxkKVxuIiwgcik7CiAJCXJldHVy
bjsKIAl9CiAJYm9fdmEgPSBhbWRncHVfdm1fYm9fZmluZCh2bSwgYm8pOwotCWlmIChib192YSAm
JiAtLWJvX3ZhLT5yZWZfY291bnQgPT0gMCkgewotCQlhbWRncHVfdm1fYm9fcm12KGFkZXYsIGJv
X3ZhKTsKKwlpZiAoIWJvX3ZhIHx8IC0tYm9fdmEtPnJlZl9jb3VudCkKKwkJZ290byBvdXRfdW5s
b2NrOwogCi0JCWlmIChhbWRncHVfdm1fcmVhZHkodm0pKSB7Ci0JCQlzdHJ1Y3QgZG1hX2ZlbmNl
ICpmZW5jZSA9IE5VTEw7CisJYW1kZ3B1X3ZtX2JvX3JtdihhZGV2LCBib192YSk7CisJaWYgKCFh
bWRncHVfdm1fcmVhZHkodm0pKQorCQlnb3RvIG91dF91bmxvY2s7CiAKLQkJCXIgPSBhbWRncHVf
dm1fY2xlYXJfZnJlZWQoYWRldiwgdm0sICZmZW5jZSk7Ci0JCQlpZiAodW5saWtlbHkocikpIHsK
LQkJCQlkZXZfZXJyKGFkZXYtPmRldiwgImZhaWxlZCB0byBjbGVhciBwYWdlICIKLQkJCQkJInRh
YmxlcyBvbiBHRU0gb2JqZWN0IGNsb3NlICglZClcbiIsIHIpOwotCQkJfQorCWZlbmNlID0gZG1h
X3Jlc3ZfZ2V0X2V4Y2woYm8tPnRiby5iYXNlLnJlc3YpOworCWFtZGdwdV9ib19mZW5jZShibywg
ZmVuY2UsIHRydWUpOworCWZlbmNlID0gTlVMTDsKIAotCQkJaWYgKGZlbmNlKSB7Ci0JCQkJYW1k
Z3B1X2JvX2ZlbmNlKGJvLCBmZW5jZSwgdHJ1ZSk7Ci0JCQkJZG1hX2ZlbmNlX3B1dChmZW5jZSk7
Ci0JCQl9Ci0JCX0KLQl9CisJciA9IGFtZGdwdV92bV9jbGVhcl9mcmVlZChhZGV2LCB2bSwgJmZl
bmNlKTsKKwlpZiAociB8fCAhZmVuY2UpCisJCWdvdG8gb3V0X3VubG9jazsKKworCWFtZGdwdV9i
b19mZW5jZShibywgZmVuY2UsIHRydWUpOworCWRtYV9mZW5jZV9wdXQoZmVuY2UpOworCitvdXRf
dW5sb2NrOgorCWlmICh1bmxpa2VseShyIDwgMCkpCisJCWRldl9lcnIoYWRldi0+ZGV2LCAiZmFp
bGVkIHRvIGNsZWFyIHBhZ2UgIgorCQkJInRhYmxlcyBvbiBHRU0gb2JqZWN0IGNsb3NlICglbGQp
XG4iLCByKTsKIAl0dG1fZXVfYmFja29mZl9yZXNlcnZhdGlvbigmdGlja2V0LCAmbGlzdCk7CiB9
CiAKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
