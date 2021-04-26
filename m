Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6F8C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 08:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A208461139
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 08:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A208461139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46C489CBE;
	Mon, 26 Apr 2021 08:54:38 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C4D89CBE
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 08:54:37 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id r20so33511303ejo.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2iGkedcpZPaQyedtsqHwyzSJ7eTJlzYa+zVpe3u3J2I=;
 b=NXLvEsDSWEjo5thjasiLwzJ9k+jjeMB7dWzQ1qpgPWYxrHAHZDVTDmPXXR3j7NoSpn
 8tIeTDimy/I3HRPFg59GOKERWGJ4AOcdEUl+ANAJ+vuz9+1q77JN3Fs9B0BGgobaw6CR
 KaPRdnps2Q1qiotSBbsR+nLEI84dQqGBM0fmBd2l9pmF+9EYA7T/BWaErmrLwSBlbHBT
 SqQzeMu6BkQqiSc1FBXSu6LZ6BD2s7o4hGltGyDW0jev845PRgNrktGQOIuMY3uvtG3E
 gzyDNvaT8i7oO6GSbp+I+KtF9C1BlqWrv7SUT9THzrlphMV7lv98qLUCP3BZY1rYPVHI
 jjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2iGkedcpZPaQyedtsqHwyzSJ7eTJlzYa+zVpe3u3J2I=;
 b=fO8atMayXbtFkMM7GFIubtsEhjGdeVoc7bC3I+k2+9dDEv/2kiTaBox8s1z7akVenI
 8r3iQt5vjSXJnGWew547Lw8QZ51gcs29FgCLZMdj4fBPeiJk1ZkHbI4QcT97daXSYaTl
 rFKnpEA9UCjLFns/JYXQCh7SlT9LaOiPutYVyiNYBBwwkBMapqN68Hz/zMj/jM+fQ+5J
 GVZ8dlh9YrCc8+IA+97NKv+yu/gYdpzFUwvMIzh17RN7+ngYy/tQQRgTsJkCbT1DQULJ
 m3mGLhun6xBHeHHxBW+GMxKvEBOAMZAE9jT7rZXIsRdBNMt9zpcnG2EmSE2OtgOQ0DVh
 WM2g==
X-Gm-Message-State: AOAM531/Hhma1VDFsVyktGhZVoMGmlmCrLNTN3Er4W4B23sJAok0abcm
 J4qqziwqMO/lpvNWxFKh3/K28LyiC2k=
X-Google-Smtp-Source: ABdhPJyKZ3E4ldhb7D4KBlxb/ofaSd3UoLFjukxaZ5DVQmi2p2LH0o0SGGMqyEiKlOOcAGYK5YZVDw==
X-Received: by 2002:a17:906:b85a:: with SMTP id
 ga26mr17461487ejb.366.1619427276194; 
 Mon, 26 Apr 2021 01:54:36 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:43e1:5c2f:d338:2250])
 by smtp.gmail.com with ESMTPSA id z14sm13486945edc.62.2021.04.26.01.54.35
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Apr 2021 01:54:35 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: restructure amdgpu_vram_mgr_new
Date: Mon, 26 Apr 2021 10:54:34 +0200
Message-Id: <20210426085434.2974-1-christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TWVyZ2UgdGhlIHR3byBsb29wcywgbG9vc2VuIHRoZSByZXN0cmljdGlvbiBmb3IgYmlnIGFsbG9j
YXRpb25zLgpUaGlzIHJlZHVjZXMgdGhlIENQVSBvdmVyaGVhZCBpbiB0aGUgZ29vZCBjYXNlLCBi
dXQgaW5jcmVhc2VzCml0IGEgYml0IHVuZGVyIG1lbW9yeSBwcmVzc3VyZS4KClNpZ25lZC1vZmYt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYyB8IDU4ICsrKysrKysrKy0t
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1f
bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwppbmRl
eCA1MjljNWMzMmEyMDUuLmUyY2JlMTk0MDRjMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKQEAgLTM1OCwxMyArMzU4LDEzIEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwKIAkJ
CSAgICAgICBjb25zdCBzdHJ1Y3QgdHRtX3BsYWNlICpwbGFjZSwKIAkJCSAgICAgICBzdHJ1Y3Qg
dHRtX3Jlc291cmNlICptZW0pCiB7CisJdW5zaWduZWQgbG9uZyBscGZuLCBudW1fbm9kZXMsIHBh
Z2VzX3Blcl9ub2RlLCBwYWdlc19sZWZ0LCBwYWdlczsKIAlzdHJ1Y3QgYW1kZ3B1X3ZyYW1fbWdy
ICptZ3IgPSB0b192cmFtX21ncihtYW4pOwogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0g
dG9fYW1kZ3B1X2RldmljZShtZ3IpOworCXVpbnQ2NF90IHZpc191c2FnZSA9IDAsIG1lbV9ieXRl
cywgbWF4X2J5dGVzOwogCXN0cnVjdCBkcm1fbW0gKm1tID0gJm1nci0+bW07Ci0Jc3RydWN0IGRy
bV9tbV9ub2RlICpub2RlczsKIAllbnVtIGRybV9tbV9pbnNlcnRfbW9kZSBtb2RlOwotCXVuc2ln
bmVkIGxvbmcgbHBmbiwgbnVtX25vZGVzLCBwYWdlc19wZXJfbm9kZSwgcGFnZXNfbGVmdDsKLQl1
aW50NjRfdCB2aXNfdXNhZ2UgPSAwLCBtZW1fYnl0ZXMsIG1heF9ieXRlczsKKwlzdHJ1Y3QgZHJt
X21tX25vZGUgKm5vZGVzOwogCXVuc2lnbmVkIGk7CiAJaW50IHI7CiAKQEAgLTM5MSw5ICszOTEs
MTAgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVjdCB0dG1fcmVzb3VyY2Vf
bWFuYWdlciAqbWFuLAogCQlwYWdlc19wZXJfbm9kZSA9IEhQQUdFX1BNRF9OUjsKICNlbHNlCiAJ
CS8qIGRlZmF1bHQgdG8gMk1CICovCi0JCXBhZ2VzX3Blcl9ub2RlID0gKDJVTCA8PCAoMjBVTCAt
IFBBR0VfU0hJRlQpKTsKKwkJcGFnZXNfcGVyX25vZGUgPSAyVUwgPDwgKDIwVUwgLSBQQUdFX1NI
SUZUKTsKICNlbmRpZgotCQlwYWdlc19wZXJfbm9kZSA9IG1heCgodWludDMyX3QpcGFnZXNfcGVy
X25vZGUsIG1lbS0+cGFnZV9hbGlnbm1lbnQpOworCQlwYWdlc19wZXJfbm9kZSA9IG1heF90KHVp
bnQzMl90LCBwYWdlc19wZXJfbm9kZSwKKwkJCQkgICAgICAgbWVtLT5wYWdlX2FsaWdubWVudCk7
CiAJCW51bV9ub2RlcyA9IERJVl9ST1VORF9VUChtZW0tPm51bV9wYWdlcywgcGFnZXNfcGVyX25v
ZGUpOwogCX0KIApAQCAtNDExLDQyICs0MTIsMzcgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9t
Z3JfbmV3KHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuLAogCW1lbS0+c3RhcnQgPSAw
OwogCXBhZ2VzX2xlZnQgPSBtZW0tPm51bV9wYWdlczsKIAotCXNwaW5fbG9jaygmbWdyLT5sb2Nr
KTsKLQlmb3IgKGkgPSAwOyBwYWdlc19sZWZ0ID49IHBhZ2VzX3Blcl9ub2RlOyArK2kpIHsKLQkJ
dW5zaWduZWQgbG9uZyBwYWdlcyA9IHJvdW5kZG93bl9wb3dfb2ZfdHdvKHBhZ2VzX2xlZnQpOwot
Ci0JCS8qIExpbWl0IG1heGltdW0gc2l6ZSB0byAyR0IgZHVlIHRvIFNHIHRhYmxlIGxpbWl0YXRp
b25zICovCi0JCXBhZ2VzID0gbWluKHBhZ2VzLCAoMlVMIDw8ICgzMCAtIFBBR0VfU0hJRlQpKSk7
CisJLyogTGltaXQgbWF4aW11bSBzaXplIHRvIDJHQiBkdWUgdG8gU0cgdGFibGUgbGltaXRhdGlv
bnMgKi8KKwlwYWdlcyA9IG1pbihwYWdlc19sZWZ0LCAyVUwgPDwgKDMwIC0gUEFHRV9TSElGVCkp
OwogCi0JCXIgPSBkcm1fbW1faW5zZXJ0X25vZGVfaW5fcmFuZ2UobW0sICZub2Rlc1tpXSwgcGFn
ZXMsCi0JCQkJCQlwYWdlc19wZXJfbm9kZSwgMCwKLQkJCQkJCXBsYWNlLT5mcGZuLCBscGZuLAot
CQkJCQkJbW9kZSk7Ci0JCWlmICh1bmxpa2VseShyKSkKLQkJCWJyZWFrOwotCi0JCXZpc191c2Fn
ZSArPSBhbWRncHVfdnJhbV9tZ3JfdmlzX3NpemUoYWRldiwgJm5vZGVzW2ldKTsKLQkJYW1kZ3B1
X3ZyYW1fbWdyX3ZpcnRfc3RhcnQobWVtLCAmbm9kZXNbaV0pOwotCQlwYWdlc19sZWZ0IC09IHBh
Z2VzOwotCX0KLQotCWZvciAoOyBwYWdlc19sZWZ0OyArK2kpIHsKLQkJdW5zaWduZWQgbG9uZyBw
YWdlcyA9IG1pbihwYWdlc19sZWZ0LCBwYWdlc19wZXJfbm9kZSk7CisJaSA9IDA7CisJc3Bpbl9s
b2NrKCZtZ3ItPmxvY2spOworCXdoaWxlIChwYWdlc19sZWZ0KSB7CiAJCXVpbnQzMl90IGFsaWdu
bWVudCA9IG1lbS0+cGFnZV9hbGlnbm1lbnQ7CiAKLQkJaWYgKHBhZ2VzID09IHBhZ2VzX3Blcl9u
b2RlKQorCQlpZiAocGFnZXMgPj0gcGFnZXNfcGVyX25vZGUpCiAJCQlhbGlnbm1lbnQgPSBwYWdl
c19wZXJfbm9kZTsKIAotCQlyID0gZHJtX21tX2luc2VydF9ub2RlX2luX3JhbmdlKG1tLCAmbm9k
ZXNbaV0sCi0JCQkJCQlwYWdlcywgYWxpZ25tZW50LCAwLAotCQkJCQkJcGxhY2UtPmZwZm4sIGxw
Zm4sCi0JCQkJCQltb2RlKTsKLQkJaWYgKHVubGlrZWx5KHIpKQorCQlyID0gZHJtX21tX2luc2Vy
dF9ub2RlX2luX3JhbmdlKG1tLCAmbm9kZXNbaV0sIHBhZ2VzLCBhbGlnbm1lbnQsCisJCQkJCQkw
LCBwbGFjZS0+ZnBmbiwgbHBmbiwgbW9kZSk7CisJCWlmICh1bmxpa2VseShyKSkgeworCQkJaWYg
KHBhZ2VzID4gcGFnZXNfcGVyX25vZGUpIHsKKwkJCQlpZiAoaXNfcG93ZXJfb2ZfMihwYWdlcykp
CisJCQkJCXBhZ2VzID0gcGFnZXMgLyAyOworCQkJCWVsc2UKKwkJCQkJcGFnZXMgPSByb3VuZGRv
d25fcG93X29mX3R3byhwYWdlcyk7CisJCQkJY29udGludWU7CisJCQl9CiAJCQlnb3RvIGVycm9y
OworCQl9CiAKIAkJdmlzX3VzYWdlICs9IGFtZGdwdV92cmFtX21ncl92aXNfc2l6ZShhZGV2LCAm
bm9kZXNbaV0pOwogCQlhbWRncHVfdnJhbV9tZ3JfdmlydF9zdGFydChtZW0sICZub2Rlc1tpXSk7
CiAJCXBhZ2VzX2xlZnQgLT0gcGFnZXM7CisJCSsraTsKKworCQlpZiAocGFnZXMgPiBwYWdlc19s
ZWZ0KQorCQkJcGFnZXMgPSBwYWdlc19sZWZ0OwogCX0KIAlzcGluX3VubG9jaygmbWdyLT5sb2Nr
KTsKIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
