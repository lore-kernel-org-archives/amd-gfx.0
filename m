Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE8FC43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 15:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05403206DF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 15:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05403206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B306E91D;
	Wed,  4 Dec 2019 15:38:27 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52216E0CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 15:38:25 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id t14so179979wmi.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2019 07:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dBIa0+TypbOQglogED/HraaZS1i6JdzXDs6+auoa0yQ=;
 b=lhUJNZOnX0YGzQ5GAGGsH0+Aq/pK9aJ1ykvR7y9n+28wEGboABw0d1Nh9Pw8PnCsh5
 ItRyWA/gHBFWh3A36ybN4xeo/YlCfR3srMzWMdzGYMKEOda+nLK/m+e0kEGuS+E4PkL8
 t/jAFJWkRuNpiFsGlqJmRelyFsRqqH2gSLtwoHYKf4BqPTBnj9MM4twWnFmtiIoqZDyC
 RVjq6l7F/CZekT4KsUgHDxPLRPRCIMH+zMXjzvJ7vT5kQZR1Yrl+6Oii6uNnW8HerHaP
 0D+BqEUsrjIJqbsyWJzQArTv6H05+2FLXoFU0L3j8GeSP84ox4Df53hqnm8oSEzyszhY
 9p/w==
X-Gm-Message-State: APjAAAULi6l9lIl7+gSgjc83+ivYCDQ/pi4ZpNc20jHJgg7qYz3oZ2pX
 mfn07qeQPJEd5occ8FQRuQA1DEsH
X-Google-Smtp-Source: APXvYqxvnME39U0OTCAqwHIhVNHyKDePp7g/x4U48APfxCBYIHefajUTiKjJZJc0kVO8uppB4QriVg==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr56938wma.121.1575473904412;
 Wed, 04 Dec 2019 07:38:24 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:b1cc:d5dc:38e4:49b0])
 by smtp.gmail.com with ESMTPSA id k13sm7103710wrx.59.2019.12.04.07.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 07:38:23 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, philip.yang@amd.com
Subject: [PATCH 1/3] drm/amdgpu: move VM eviction decision into amdgpu_vm.c
Date: Wed,  4 Dec 2019 16:38:20 +0100
Message-Id: <20191204153822.2199-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dBIa0+TypbOQglogED/HraaZS1i6JdzXDs6+auoa0yQ=;
 b=JBYi6FM6ETwDS0n2eJ66IJ8hlDMMkGsVdCXyQEMG4rCfG1Ynqh4gBCjZbdwKmt/vKe
 vZjgmUxRIGGT5m76WHxV3dZssnnTUDxQi1eRYECkATN9o9SJ+frvLQOslyd8wixXnCAx
 F1HOW5F1E9VI0AOh8H4/XwSD4kE5VgeUUh00qpmqsCeYxbuMLHzFnxSGA5wwCJ01iNEG
 aEtvo/bb86XkUgRu9phnGFvmRNEdSVdN7HXLiUuRtCvKcFlmYh1Mu9IwQjWNsWwrniMu
 9cugynvlnv9wiRNAC9kUEmWGfR1oiQgDblIHj6K0JRec8PQiPs/HJs87b7eQR3K6k265
 ZL6w==
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

V2hlbiBhIHBhZ2UgdGFibGVzIG5lZWRzIHRvIGJlIGV2aWN0ZWQgdGhlIFZNIGNvZGUgc2hvdWxk
CmRlY2lkZSBpZiB0aGF0IGlzIHBvc3NpYmxlIG9yIG5vdC4KClNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAgNSArLS0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmggIHwgIDEgKwogMyBmaWxlcyBjaGFuZ2Vk
LCAyNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYwppbmRleCAxOWZmZTAwZDkwNzIuLjgxZjY3NjRmMWJhNiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpAQCAtMTQ4OSwxMSArMTQ4OSw4IEBA
IHN0YXRpYyBib29sIGFtZGdwdV90dG1fYm9fZXZpY3Rpb25fdmFsdWFibGUoc3RydWN0IHR0bV9i
dWZmZXJfb2JqZWN0ICpibywKIAlzdHJ1Y3QgZG1hX2ZlbmNlICpmOwogCWludCBpOwogCi0JLyog
RG9uJ3QgZXZpY3QgVk0gcGFnZSB0YWJsZXMgd2hpbGUgdGhleSBhcmUgYnVzeSwgb3RoZXJ3aXNl
IHdlIGNhbid0Ci0JICogY2xlYW5seSBoYW5kbGUgcGFnZSBmYXVsdHMuCi0JICovCiAJaWYgKGJv
LT50eXBlID09IHR0bV9ib190eXBlX2tlcm5lbCAmJgotCSAgICAhZG1hX3Jlc3ZfdGVzdF9zaWdu
YWxlZF9yY3UoYm8tPmJhc2UucmVzdiwgdHJ1ZSkpCisJICAgICFhbWRncHVfdm1fZXZpY3RhYmxl
KHR0bV90b19hbWRncHVfYm8oYm8pKSkKIAkJcmV0dXJuIGZhbHNlOwogCiAJLyogSWYgYm8gaXMg
YSBLRkQgQk8sIGNoZWNrIGlmIHRoZSBibyBiZWxvbmdzIHRvIHRoZSBjdXJyZW50IHByb2Nlc3Mu
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IGE5NGM0ZmFhNWFmMS4u
YTIyYmQ1NzEyOWQxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAt
MjUwMyw2ICsyNTAzLDI4IEBAIHZvaWQgYW1kZ3B1X3ZtX2JvX3JtdihzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKIAlrZnJlZShib192YSk7CiB9CiAKKy8qKgorICogYW1kZ3B1X3ZtX2V2aWN0
YWJsZSAtIGNoZWNrIGlmIHdlIGNhbiBldmljdCBhIFZNCisgKgorICogQGJvOiBBIHBhZ2UgdGFi
bGUgb2YgdGhlIFZNLgorICoKKyAqIENoZWNrIGlmIGl0IGlzIHBvc3NpYmxlIHRvIGV2aWN0IGEg
Vk0uCisgKi8KK2Jvb2wgYW1kZ3B1X3ZtX2V2aWN0YWJsZShzdHJ1Y3QgYW1kZ3B1X2JvICpibykK
K3sKKwlzdHJ1Y3QgYW1kZ3B1X3ZtX2JvX2Jhc2UgKmJvX2Jhc2UgPSBiby0+dm1fYm87CisKKwkv
KiBQYWdlIHRhYmxlcyBvZiBhIGRlc3Ryb3llZCBWTSBjYW4gZ28gYXdheSBpbW1lZGlhdGVseSAq
LworCWlmICghYm9fYmFzZSB8fCAhYm9fYmFzZS0+dm0pCisJCXJldHVybiB0cnVlOworCisJLyog
RG9uJ3QgZXZpY3QgVk0gcGFnZSB0YWJsZXMgd2hpbGUgdGhleSBhcmUgYnVzeSAqLworCWlmICgh
ZG1hX3Jlc3ZfdGVzdF9zaWduYWxlZF9yY3UoYm8tPnRiby5iYXNlLnJlc3YsIHRydWUpKQorCQly
ZXR1cm4gZmFsc2U7CisKKwlyZXR1cm4gdHJ1ZTsKK30KKwogLyoqCiAgKiBhbWRncHVfdm1fYm9f
aW52YWxpZGF0ZSAtIG1hcmsgdGhlIGJvIGFzIGludmFsaWQKICAqCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5oCmluZGV4IDc2ZmNmODUzMDM1Yy4uZGI1NjE3NjU0NTNiIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaApAQCAtMzgxLDYgKzM4MSw3IEBAIGlu
dCBhbWRncHVfdm1faGFuZGxlX21vdmVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogaW50
IGFtZGdwdV92bV9ib191cGRhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQlzdHJ1
Y3QgYW1kZ3B1X2JvX3ZhICpib192YSwKIAkJCWJvb2wgY2xlYXIpOworYm9vbCBhbWRncHVfdm1f
ZXZpY3RhYmxlKHN0cnVjdCBhbWRncHVfYm8gKmJvKTsKIHZvaWQgYW1kZ3B1X3ZtX2JvX2ludmFs
aWRhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkgICAgIHN0cnVjdCBhbWRncHVf
Ym8gKmJvLCBib29sIGV2aWN0ZWQpOwogdWludDY0X3QgYW1kZ3B1X3ZtX21hcF9nYXJ0KGNvbnN0
IGRtYV9hZGRyX3QgKnBhZ2VzX2FkZHIsIHVpbnQ2NF90IGFkZHIpOwotLSAKMi4xNy4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
