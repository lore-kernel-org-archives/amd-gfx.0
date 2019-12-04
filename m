Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3269DC43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 15:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CD7206DF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 15:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CD7206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B63A16E91E;
	Wed,  4 Dec 2019 15:38:31 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C7A6E0CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 15:38:26 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id y23so5132766wma.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2019 07:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0x3zKbvnAjIKZdNwA6f7/N9USALObGS1m6uExFl4ucY=;
 b=k4iPJYrpT2EcrwuJyfmjpyJqzMmJF7HxQqoD+jVE1nmWwPSPF52+RHXSIgOCHSFYlG
 Uq4EW3lZOj+A6LcNuUwu5kJQ3EOJZ+5Y7eYRIwe3zdNqTZrAF/PynRNJtFZqVDt+Sy7n
 /3I1Gj7jmi7X2jTphZBxbW5XTTI+BeJ/vPENSAekI3Bv/S4lJ9TRH9KREwSdpSk77ZY5
 IkBJfXFb4ZE61dFyNf4/Q76sNpd/qBOj4KsKeHzEz7VP6usnuq7mWgpGyPb9VPlCso7Z
 XGzs9Qp8RTDk9AfPjypsRLv+uWZN4oedx/gVQV4u+3d+2rbEMVIuto/5yzaI1Om+qayo
 bh+g==
X-Gm-Message-State: APjAAAXswoDwHJtmfNQBdsUZBG+p/XHEmvS7jQkKom+RDbE3jV8NCisf
 9mKUWdIumRHyPMJbfgPzR+cSGgVM
X-Google-Smtp-Source: APXvYqw5d96qS/Z+I0HwbLWpNg2eJm5GHjBvsSCbeBZRdKZfCuSJq3iSDIrYO6pniM38IeQfk7GKFQ==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr236072wmj.20.1575473905115;
 Wed, 04 Dec 2019 07:38:25 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:b1cc:d5dc:38e4:49b0])
 by smtp.gmail.com with ESMTPSA id k13sm7103710wrx.59.2019.12.04.07.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 07:38:24 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, philip.yang@amd.com
Subject: [PATCH 2/3] drm/amdgpu: explicitely sync to VM updates
Date: Wed,  4 Dec 2019 16:38:21 +0100
Message-Id: <20191204153822.2199-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191204153822.2199-1-christian.koenig@amd.com>
References: <20191204153822.2199-1-christian.koenig@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0x3zKbvnAjIKZdNwA6f7/N9USALObGS1m6uExFl4ucY=;
 b=UTYNYBfdTfESz2HNBbUtTO2I8OCNwsb5Me9ks2BlN+592CE/sezgxiVisR2vSelFui
 lt2RFLe3ntQMBau3lDVNHmLipddwzJsm/QAv8kFceKEjCBbvBtZLfY3n72Ia8xi+wA42
 ByxtZ9ywLggfIBb17HY+O/TR7JTVIgrtlu8Uq89Q5R/ayQdC91zhG1fC3laAmGl7Jf/x
 ClzMPZndGCk2A30JBNfEM53xQ5z/ed2fUE9iGywtyb8TsZSYU9syJHxc6Hr7M0/JVjWS
 pxY4XVXNgTGik2x+pXjI8T55HfUVAI01upvy6CULerUhJuVs7jCx4NIJvnNRPJDBqcgM
 GI5A==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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

QWxsb3dzIHVzIHRvIHJlZHVjZSB0aGUgb3ZlcmhlYWQgd2hpbGUgc3luY2luZyB0byBmZW5jZXMg
YSBiaXQuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgICB8
IDE4ICsrKysrKystLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3N5bmMuYyB8IDIyICsrKysrKysrKysrKysrKysrKystLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9zeW5jLmggfCAgMiArKwogMyBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRp
b25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9j
cy5jCmluZGV4IDllMGM5OTc2MDM2Ny4uZjIxNDc1MzUyYjg4IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3MuYwpAQCAtNzk5LDI5ICs3OTksMjUgQEAgc3RhdGljIGludCBhbWRn
cHVfY3Nfdm1faGFuZGxpbmcoc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnApCiAJaWYgKHIpCiAJ
CXJldHVybiByOwogCi0JciA9IGFtZGdwdV9zeW5jX2ZlbmNlKGFkZXYsICZwLT5qb2ItPnN5bmMs
Ci0JCQkgICAgICBmcHJpdi0+cHJ0X3ZhLT5sYXN0X3B0X3VwZGF0ZSwgZmFsc2UpOworCXIgPSBh
bWRncHVfc3luY192bV9mZW5jZShhZGV2LCAmcC0+am9iLT5zeW5jLAorCQkJCSBmcHJpdi0+cHJ0
X3ZhLT5sYXN0X3B0X3VwZGF0ZSk7CiAJaWYgKHIpCiAJCXJldHVybiByOwogCiAJaWYgKGFtZGdw
dV9tY2JwIHx8IGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgewotCQlzdHJ1Y3QgZG1hX2ZlbmNlICpm
OwotCiAJCWJvX3ZhID0gZnByaXYtPmNzYV92YTsKIAkJQlVHX09OKCFib192YSk7CiAJCXIgPSBh
bWRncHVfdm1fYm9fdXBkYXRlKGFkZXYsIGJvX3ZhLCBmYWxzZSk7CiAJCWlmIChyKQogCQkJcmV0
dXJuIHI7CiAKLQkJZiA9IGJvX3ZhLT5sYXN0X3B0X3VwZGF0ZTsKLQkJciA9IGFtZGdwdV9zeW5j
X2ZlbmNlKGFkZXYsICZwLT5qb2ItPnN5bmMsIGYsIGZhbHNlKTsKKwkJciA9IGFtZGdwdV9zeW5j
X3ZtX2ZlbmNlKGFkZXYsICZwLT5qb2ItPnN5bmMsCisJCQkJCSBib192YS0+bGFzdF9wdF91cGRh
dGUpOwogCQlpZiAocikKIAkJCXJldHVybiByOwogCX0KIAogCWFtZGdwdV9ib19saXN0X2Zvcl9l
YWNoX2VudHJ5KGUsIHAtPmJvX2xpc3QpIHsKLQkJc3RydWN0IGRtYV9mZW5jZSAqZjsKLQogCQkv
KiBpZ25vcmUgZHVwbGljYXRlcyAqLwogCQlibyA9IHR0bV90b19hbWRncHVfYm8oZS0+dHYuYm8p
OwogCQlpZiAoIWJvKQpAQCAtODM1LDggKzgzMSw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3Zt
X2hhbmRsaW5nKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwKQogCQlpZiAocikKIAkJCXJldHVy
biByOwogCi0JCWYgPSBib192YS0+bGFzdF9wdF91cGRhdGU7Ci0JCXIgPSBhbWRncHVfc3luY19m
ZW5jZShhZGV2LCAmcC0+am9iLT5zeW5jLCBmLCBmYWxzZSk7CisJCXIgPSBhbWRncHVfc3luY192
bV9mZW5jZShhZGV2LCAmcC0+am9iLT5zeW5jLAorCQkJCQkgYm9fdmEtPmxhc3RfcHRfdXBkYXRl
KTsKIAkJaWYgKHIpCiAJCQlyZXR1cm4gcjsKIAl9CkBAIC04NDksNyArODQ1LDcgQEAgc3RhdGlj
IGludCBhbWRncHVfY3Nfdm1faGFuZGxpbmcoc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnApCiAJ
aWYgKHIpCiAJCXJldHVybiByOwogCi0JciA9IGFtZGdwdV9zeW5jX2ZlbmNlKGFkZXYsICZwLT5q
b2ItPnN5bmMsIHZtLT5sYXN0X3VwZGF0ZSwgZmFsc2UpOworCXIgPSBhbWRncHVfc3luY192bV9m
ZW5jZShhZGV2LCAmcC0+am9iLT5zeW5jLCB2bS0+bGFzdF91cGRhdGUpOwogCWlmIChyKQogCQly
ZXR1cm4gcjsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3N5bmMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMKaW5kZXgg
OTVlNWU5M2VkZDE4Li45YjI4YzFlYjVmNDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3N5bmMuYwpAQCAtMTYxLDkgKzE2MSw2IEBAIGludCBhbWRncHVfc3luY19mZW5jZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9zeW5jICpzeW5jLAogCiAJ
aWYgKCFmKQogCQlyZXR1cm4gMDsKLQlpZiAoYW1kZ3B1X3N5bmNfc2FtZV9kZXYoYWRldiwgZikg
JiYKLQkgICAgYW1kZ3B1X3N5bmNfZ2V0X293bmVyKGYpID09IEFNREdQVV9GRU5DRV9PV05FUl9W
TSkKLQkJYW1kZ3B1X3N5bmNfa2VlcF9sYXRlcigmc3luYy0+bGFzdF92bV91cGRhdGUsIGYpOwog
CiAJaWYgKGFtZGdwdV9zeW5jX2FkZF9sYXRlcihzeW5jLCBmLCBleHBsaWNpdCkpCiAJCXJldHVy
biAwOwpAQCAtMTc5LDYgKzE3NiwyNSBAQCBpbnQgYW1kZ3B1X3N5bmNfZmVuY2Uoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywKIAlyZXR1cm4gMDsK
IH0KIAorLyoqCisgKiBhbWRncHVfc3luY192bV9mZW5jZSAtIHJlbWVtYmVyIHRvIHN5bmMgdG8g
dGhpcyBWTSBmZW5jZQorICoKKyAqIEBhZGV2OiBhbWRncHUgZGV2aWNlCisgKiBAc3luYzogc3lu
YyBvYmplY3QgdG8gYWRkIGZlbmNlIHRvCisgKiBAZmVuY2U6IHRoZSBWTSBmZW5jZSB0byBhZGQK
KyAqCisgKiBBZGQgdGhlIGZlbmNlIHRvIHRoZSBzeW5jIG9iamVjdCBhbmQgcmVtZW1iZXIgaXQg
YXMgVk0gdXBkYXRlLgorICovCitpbnQgYW1kZ3B1X3N5bmNfdm1fZmVuY2Uoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywKKwkJCSBzdHJ1Y3QgZG1h
X2ZlbmNlICpmZW5jZSkKK3sKKwlpZiAoIWZlbmNlKQorCQlyZXR1cm4gMDsKKworCWFtZGdwdV9z
eW5jX2tlZXBfbGF0ZXIoJnN5bmMtPmxhc3Rfdm1fdXBkYXRlLCBmZW5jZSk7CisJcmV0dXJuIGFt
ZGdwdV9zeW5jX2ZlbmNlKGFkZXYsIHN5bmMsIGZlbmNlLCBmYWxzZSk7Cit9CisKIC8qKgogICog
YW1kZ3B1X3N5bmNfcmVzdiAtIHN5bmMgdG8gYSByZXNlcnZhdGlvbiBvYmplY3QKICAqCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuaAppbmRleCBiNWYxNzc4YTIzMTkuLmFj
MjEwZGQzNDM3MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3N5bmMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5oCkBA
IC00Miw2ICs0Miw4IEBAIHN0cnVjdCBhbWRncHVfc3luYyB7CiB2b2lkIGFtZGdwdV9zeW5jX2Ny
ZWF0ZShzdHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMpOwogaW50IGFtZGdwdV9zeW5jX2ZlbmNlKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3N5bmMgKnN5bmMsCiAJCSAg
ICAgIHN0cnVjdCBkbWFfZmVuY2UgKmYsIGJvb2wgZXhwbGljaXQpOworaW50IGFtZGdwdV9zeW5j
X3ZtX2ZlbmNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3N5bmMg
KnN5bmMsCisJCQkgc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UpOwogaW50IGFtZGdwdV9zeW5jX3Jl
c3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCSAgICAgc3RydWN0IGFtZGdwdV9zeW5j
ICpzeW5jLAogCQkgICAgIHN0cnVjdCBkbWFfcmVzdiAqcmVzdiwKLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
