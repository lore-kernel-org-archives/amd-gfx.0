Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B58C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 15:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84EA2166E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 15:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84EA2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 390C36ED9F;
	Wed,  6 Nov 2019 15:21:34 +0000 (UTC)
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
 by gabe.freedesktop.org (Postfix) with ESMTP id E5BE96ECDB;
 Wed,  6 Nov 2019 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [202.112.113.212])
 by smtp5 (Coremail) with SMTP id HdxpCgDnQnkRsMJdNnV9KA--.131S3;
 Wed, 06 Nov 2019 19:35:48 +0800 (CST)
From: Pan Bian <bianpan2016@163.com>
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2] drm/amdgpu: fix double reference dropping
Date: Wed,  6 Nov 2019 19:35:43 +0800
Message-Id: <1573040143-25820-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HdxpCgDnQnkRsMJdNnV9KA--.131S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW8Wry8Kr15Zw48Zw1rtFb_yoW8GFWkpF
 WxGw1UKrWDZF10934UA3W0qF98Kw13XFyrKF47Ca95uan8JF98JF95trWkWFyDCFZ2va92
 v39FyrW3uan8KF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaFAXUUUUU=
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiNhRlclWBhKyp4wAAsD
X-Mailman-Approved-At: Wed, 06 Nov 2019 15:21:34 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=163.com; 
 s=s110527; h=From:Subject:Date:Message-Id; bh=F4q0FT2QSt1liFQffl
 wBI53D3683D+4jI0WVjJIt4Q4=; b=GzL/nCfaJzTBgm6GWc2L91x4ApX8RAJYYH
 N9bX9EhgzwymsNzGnWX/pEhPWn2bg1NfI/Q4HC29oVJcPh+2YUHeh/5G1e0F6LA6
 MEdcQSO5UGGMxc7A9kRfur/9GXqKfK4tOF1gCpg6NnExGbNUZXbm9zIzwDyBqWMh
 2wJKw5Gf0=
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
Cc: Pan Bian <bianpan2016@163.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106113543.dd4GC2ZIBuUeLc5p70m2u-8Ue7Aubs2659EpAjqsOPQ@z>

VGhlIHJlZmVyZW5jZSB0byBvYmplY3QgZmVuY2UgaXMgZHJvcHBlZCBhdCB0aGUgZW5kIG9mIHRo
ZSBsb29wLgpIb3dldmVyLCBpdCBpcyBkcm9wcGVkIGFnYWluIG91dHNpZGUgdGhlIGxvb3AuIFRo
ZSByZWZlcmVuY2UgY2FuIGJlCmRyb3BwZWQgaW1tZWRpYXRlbHkgYWZ0ZXIgY2FsbGluZyBkbWFf
ZmVuY2Vfd2FpdCgpIGluIHRoZSBsb29wIGFuZAp0aHVzIHRoZSBkcm9wcGluZyBvcGVyYXRpb24g
b3V0c2lkZSB0aGUgbG9vcCBjYW4gYmUgcmVtb3ZlZC4KClNpZ25lZC1vZmYtYnk6IFBhbiBCaWFu
IDxiaWFucGFuMjAxNkAxNjMuY29tPgotLS0KdjI6IGZpeCB0aGUgYnVnIGluIGEgbW9yZSBjb25j
aXNlIHdheQotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsu
YyB8IDYgKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iZW5j
aG1hcmsuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsuYwpp
bmRleCA2NDllNjhjNDQ3OWIuLmQxNDk1ZTFjOTI4OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsuYwpAQCAtMzMsNyArMzMsNyBAQCBzdGF0aWMgaW50
IGFtZGdwdV9iZW5jaG1hcmtfZG9fbW92ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5z
aWduZWQgc2l6ZSwKIHsKIAl1bnNpZ25lZCBsb25nIHN0YXJ0X2ppZmZpZXM7CiAJdW5zaWduZWQg
bG9uZyBlbmRfamlmZmllczsKLQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7CisJc3Ry
dWN0IGRtYV9mZW5jZSAqZmVuY2U7CiAJaW50IGksIHI7CiAKIAlzdGFydF9qaWZmaWVzID0gamlm
ZmllczsKQEAgLTQ0LDE2ICs0NCwxNCBAQCBzdGF0aWMgaW50IGFtZGdwdV9iZW5jaG1hcmtfZG9f
bW92ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgc2l6ZSwKIAkJaWYgKHIp
CiAJCQlnb3RvIGV4aXRfZG9fbW92ZTsKIAkJciA9IGRtYV9mZW5jZV93YWl0KGZlbmNlLCBmYWxz
ZSk7CisJCWRtYV9mZW5jZV9wdXQoZmVuY2UpOwogCQlpZiAocikKIAkJCWdvdG8gZXhpdF9kb19t
b3ZlOwotCQlkbWFfZmVuY2VfcHV0KGZlbmNlKTsKIAl9CiAJZW5kX2ppZmZpZXMgPSBqaWZmaWVz
OwogCXIgPSBqaWZmaWVzX3RvX21zZWNzKGVuZF9qaWZmaWVzIC0gc3RhcnRfamlmZmllcyk7CiAK
IGV4aXRfZG9fbW92ZToKLQlpZiAoZmVuY2UpCi0JCWRtYV9mZW5jZV9wdXQoZmVuY2UpOwogCXJl
dHVybiByOwogfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
