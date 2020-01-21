Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7E2C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 13:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01395206A2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 13:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P44stYIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01395206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 126916ECED;
	Tue, 21 Jan 2020 13:22:11 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22CB56ECED
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 13:22:08 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id l7so1331308ybp.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 05:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k9MyrBc/g/LNqmPPmAhBAVKKb7qozlDSwfJCJI7e2Sw=;
 b=P44stYICM6ZQg48MgabPQ3ENFADlno6OcfyJtfvsfmCIWW1xQruxidpA6PqiAoJiBu
 N+CFsW1UcfQa7cZctaI3ZVozz9V6IBgGJvDFIAgeDk7fPMBTlDv891jzw0MW3w6bywMy
 AlyV1ObnlMbPUSwRRJs3WkccOQjlp1wiYajvDWTTFK+sOgSsAHpD8k5SASbaH/qYSUD3
 f+L0o8blqeUL0Ua7kYCDo6/D1dxecAz0DySvifTZkONL53+mgNKNma9ihHeu1B9U0ElT
 mLbfGWiM7eSyKXJBDBQecWxaxXXIpIyYoE9k8lvcyVVUwsbLcPFt00KXxLv1JDQxhsf5
 8fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k9MyrBc/g/LNqmPPmAhBAVKKb7qozlDSwfJCJI7e2Sw=;
 b=MPNTz4doQKOyj3yQoCdxopn6qTFNuD7pmlg7sDPuuLpUhXp/ln+F0OSlxW4QcphzgO
 uGI9OOKZ+RZwft/A0XY51+IeKljk7skAWgRwpvpXAZXNn8fF0vW324tD2lvSxrAnNHkF
 ZOZSlqqdghqlKtY6yANTlAWWk+Gi7E4RpVRsVuhqxUQ1Aldk9ltQkLC4j++Qr+zLlola
 P0aPsOVkS4R19woesSMqw3mfnzpwi6eWy+NuXxWyjHZF1kKqo5Qs3GxI7bQM8MGM4yow
 BtpULsD4iV4duTUTBKhSN5DLKUT4vDJq4uBHWWEQxZyMzx3vw1p7pDUBP3OLAZiTmmIN
 FReg==
X-Gm-Message-State: APjAAAVdx39bhKis3sQ1zp4W1uulXNGVUN318LaJTysmY2rXHpl0n2qU
 nm1KGV/b335gKifP4TtM0Fr9ejwOegozCw==
X-Google-Smtp-Source: APXvYqyM1DG2zHnng2TgeZuk8u1ijlbv9oJwSvkae5jztVLl9DYIsKgxexbYII9BnubjCFp+wPlGxQ==
X-Received: by 2002:a25:c514:: with SMTP id v20mr3750433ybe.293.1579612927046; 
 Tue, 21 Jan 2020 05:22:07 -0800 (PST)
Received: from brihaspati.amd.com
 (p200300C58F2C5700EF9508483D6EB58B.dip0.t-ipconnect.de.
 [2003:c5:8f2c:5700:ef95:848:3d6e:b58b])
 by smtp.gmail.com with ESMTPSA id n3sm17881578ywd.35.2020.01.21.05.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 05:22:06 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: individualize fence allocation per entity
Date: Tue, 21 Jan 2020 14:23:44 +0100
Message-Id: <20200121132344.9040-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.1
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWxsb2NhdGUgZmVuY2VzIGZvciBlYWNoIGVudGl0eSBhbmQgcmVtb3ZlIGN0eC0+ZmVuY2VzIHJl
ZmVyZW5jZSBhcwpmZW5jZXMgc2hvdWxkIGJlIGJvdW5kIHRvIGFtZGdwdV9jdHhfZW50aXR5IGlu
c3RlYWQgYW1kZ3B1X2N0eC4KClNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNA
YW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgfCA0
NCArKysrKysrKysrKysrKystLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfY3R4LmggfCAgMSAtCiAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDE4
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwppbmRl
eCA2NGUyYmFiYmMzNmUuLjA1YzJhZjYxZTdkZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jdHguYwpAQCAtODcsMjQgKzg3LDI0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCW1lbXNldChjdHgsIDAsIHNpemVvZigq
Y3R4KSk7CiAJY3R4LT5hZGV2ID0gYWRldjsKIAotCWN0eC0+ZmVuY2VzID0ga2NhbGxvYyhhbWRn
cHVfc2NoZWRfam9icyAqIG51bV9lbnRpdGllcywKLQkJCSAgICAgIHNpemVvZihzdHJ1Y3QgZG1h
X2ZlbmNlKiksIEdGUF9LRVJORUwpOwotCWlmICghY3R4LT5mZW5jZXMpCi0JCXJldHVybiAtRU5P
TUVNOwogCiAJY3R4LT5lbnRpdGllc1swXSA9IGtjYWxsb2MobnVtX2VudGl0aWVzLAogCQkJCSAg
IHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2N0eF9lbnRpdHkpLAogCQkJCSAgIEdGUF9LRVJORUwpOwot
CWlmICghY3R4LT5lbnRpdGllc1swXSkgewotCQlyID0gLUVOT01FTTsKLQkJZ290byBlcnJvcl9m
cmVlX2ZlbmNlczsKLQl9CisJaWYgKCFjdHgtPmVudGl0aWVzWzBdKQorCQlyZXR1cm4gLUVOT01F
TTsKKwogCiAJZm9yIChpID0gMDsgaSA8IG51bV9lbnRpdGllczsgKytpKSB7CiAJCXN0cnVjdCBh
bWRncHVfY3R4X2VudGl0eSAqZW50aXR5ID0gJmN0eC0+ZW50aXRpZXNbMF1baV07CiAKIAkJZW50
aXR5LT5zZXF1ZW5jZSA9IDE7Ci0JCWVudGl0eS0+ZmVuY2VzID0gJmN0eC0+ZmVuY2VzW2FtZGdw
dV9zY2hlZF9qb2JzICogaV07CisJCWVudGl0eS0+ZmVuY2VzID0ga2NhbGxvYyhhbWRncHVfc2No
ZWRfam9icywKKwkJCQkJIHNpemVvZihzdHJ1Y3QgZG1hX2ZlbmNlKiksIEdGUF9LRVJORUwpOwor
CQlpZiAoIWVudGl0eS0+ZmVuY2VzKSB7CisJCQlyID0gLUVOT01FTTsKKwkJCWdvdG8gZXJyb3Jf
Y2xlYW51cF9tZW1vcnk7CisJCX0KIAl9CiAJZm9yIChpID0gMTsgaSA8IEFNREdQVV9IV19JUF9O
VU07ICsraSkKIAkJY3R4LT5lbnRpdGllc1tpXSA9IGN0eC0+ZW50aXRpZXNbaSAtIDFdICsKQEAg
LTE4MSwxMSArMTgxLDE3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9pbml0KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAogZXJyb3JfY2xlYW51cF9lbnRpdGllczoKIAlmb3IgKGkgPSAwOyBp
IDwgbnVtX2VudGl0aWVzOyArK2kpCiAJCWRybV9zY2hlZF9lbnRpdHlfZGVzdHJveSgmY3R4LT5l
bnRpdGllc1swXVtpXS5lbnRpdHkpOwotCWtmcmVlKGN0eC0+ZW50aXRpZXNbMF0pOwogCi1lcnJv
cl9mcmVlX2ZlbmNlczoKLQlrZnJlZShjdHgtPmZlbmNlcyk7Ci0JY3R4LT5mZW5jZXMgPSBOVUxM
OworZXJyb3JfY2xlYW51cF9tZW1vcnk6CisJZm9yIChpID0gMDsgaSA8IG51bV9lbnRpdGllczsg
KytpKSB7CisJCXN0cnVjdCBhbWRncHVfY3R4X2VudGl0eSAqZW50aXR5ID0gJmN0eC0+ZW50aXRp
ZXNbMF1baV07CisKKwkJa2ZyZWUoZW50aXR5LT5mZW5jZXMpOworCQllbnRpdHktPmZlbmNlcyA9
IE5VTEw7CisJfQorCisJa2ZyZWUoY3R4LT5lbnRpdGllc1swXSk7CisJY3R4LT5lbnRpdGllc1sw
XSA9IE5VTEw7CiAJcmV0dXJuIHI7CiB9CiAKQEAgLTE5OSwxMiArMjA1LDE2IEBAIHN0YXRpYyB2
b2lkIGFtZGdwdV9jdHhfZmluaShzdHJ1Y3Qga3JlZiAqcmVmKQogCWlmICghYWRldikKIAkJcmV0
dXJuOwogCi0JZm9yIChpID0gMDsgaSA8IG51bV9lbnRpdGllczsgKytpKQorCWZvciAoaSA9IDA7
IGkgPCBudW1fZW50aXRpZXM7ICsraSkgeworCQlzdHJ1Y3QgYW1kZ3B1X2N0eF9lbnRpdHkgKmVu
dGl0eSA9ICZjdHgtPmVudGl0aWVzWzBdW2ldOworCiAJCWZvciAoaiA9IDA7IGogPCBhbWRncHVf
c2NoZWRfam9iczsgKytqKQotCQkJZG1hX2ZlbmNlX3B1dChjdHgtPmVudGl0aWVzWzBdW2ldLmZl
bmNlc1tqXSk7Ci0Ja2ZyZWUoY3R4LT5mZW5jZXMpOwotCWtmcmVlKGN0eC0+ZW50aXRpZXNbMF0p
OworCQkJZG1hX2ZlbmNlX3B1dChlbnRpdHktPmZlbmNlc1tqXSk7CiAKKwkJa2ZyZWUoZW50aXR5
LT5mZW5jZXMpOworCX0KKworCWtmcmVlKGN0eC0+ZW50aXRpZXNbMF0pOwogCW11dGV4X2Rlc3Ry
b3koJmN0eC0+bG9jayk7CiAKIAlrZnJlZShjdHgpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2N0eC5oCmluZGV4IDRhZDkwYTQ0ZGMzYy4uYTZjZDlkNGIwNzhjIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmgKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5oCkBAIC00Miw3ICs0Miw2IEBAIHN0cnVjdCBh
bWRncHVfY3R4IHsKIAl1bnNpZ25lZAkJCXJlc2V0X2NvdW50ZXJfcXVlcnk7CiAJdWludDMyX3QJ
CQl2cmFtX2xvc3RfY291bnRlcjsKIAlzcGlubG9ja190CQkJcmluZ19sb2NrOwotCXN0cnVjdCBk
bWFfZmVuY2UJCSoqZmVuY2VzOwogCXN0cnVjdCBhbWRncHVfY3R4X2VudGl0eQkqZW50aXRpZXNb
QU1ER1BVX0hXX0lQX05VTV07CiAJYm9vbAkJCQlwcmVhbWJsZV9wcmVzZW50ZWQ7CiAJZW51bSBk
cm1fc2NoZWRfcHJpb3JpdHkJCWluaXRfcHJpb3JpdHk7Ci0tIAoyLjI0LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
