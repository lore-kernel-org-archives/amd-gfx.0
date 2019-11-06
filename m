Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD7C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 15:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C432166E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 15:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C432166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C216ED9B;
	Wed,  6 Nov 2019 15:21:37 +0000 (UTC)
X-Greylist: delayed 914 seconds by postgrey-1.36 at gabe;
 Wed, 06 Nov 2019 10:08:41 UTC
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
 by gabe.freedesktop.org (Postfix) with ESMTP id 807816ECA9;
 Wed,  6 Nov 2019 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [202.112.113.212])
 by smtp5 (Coremail) with SMTP id HdxpCgC3ag4LmMJdJKR2KA--.242S3;
 Wed, 06 Nov 2019 17:53:17 +0800 (CST)
From: Pan Bian <bianpan2016@163.com>
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] drm/amdgpu: fix double reference dropping
Date: Wed,  6 Nov 2019 17:53:14 +0800
Message-Id: <1573033994-17102-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HdxpCgC3ag4LmMJdJKR2KA--.242S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1DZr18ur4fZF4fuF1xKrg_yoW3KrX_ua
 y8Jr1kXr1ayFnFgr12yrs8Zrn5tFy5ZrZ5Gr13twsYyryUZ3yjy34DZr4rX3Wxu3ZF9asI
 g3W2gF1akwn3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjXdb7UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVA1lclUMK-VKwgAAsB
X-Mailman-Approved-At: Wed, 06 Nov 2019 15:21:34 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=163.com; 
 s=s110527; h=From:Subject:Date:Message-Id; bh=GuSX7DsLSoatQP2nsn
 2ObQ5BXs4qfIxJlA/iMyeHF5Q=; b=n1I8rIIqQQ8aM0wOQQsICihs4L8tOLFpV1
 GSEwHTbgS/85UBfLAcT/LoJ2efWFshsxwNupaWQeLgKHgrGwZQwFYdbbgRuELNum
 Ui1QH7W/3jZPPnrb2AGf3+Xfk+g/tRjZ1b/4yNXrtRPAFlfvwA21+/VBXLMiTb9w
 +dn80pFzo=
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
Message-ID: <20191106095314.14o8n0CginEQU2OysuXOJcJfVRzu86yPP6wDjJNK-C0@z>

QWZ0ZXIgZHJvcHBpbmcgdGhlIHJlZmVyZW5jZSBvZiBvYmplY3QgZmVuY2UgaW4gdGhlIGxvb3As
IGl0IHNob3VsZCBiZQpzZXQgdG8gTlVMTCB0byBwcm90ZWN0aW5nIGRyb3BwaW5nIGl0cyByZWZl
cmVuY2UgYWdhaW4gb3V0c2lkZSB0aGUgbG9vcC4KClNpZ25lZC1vZmYtYnk6IFBhbiBCaWFuIDxi
aWFucGFuMjAxNkAxNjMuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9iZW5jaG1hcmsuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5jCmluZGV4IDY0OWU2
OGM0NDc5Yi4uMzE3NDA5M2YzNWYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYmVuY2htYXJrLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2JlbmNobWFyay5jCkBAIC00Nyw2ICs0Nyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Jl
bmNobWFya19kb19tb3ZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBzaXpl
LAogCQlpZiAocikKIAkJCWdvdG8gZXhpdF9kb19tb3ZlOwogCQlkbWFfZmVuY2VfcHV0KGZlbmNl
KTsKKwkJZmVuY2UgPSBOVUxMOwogCX0KIAllbmRfamlmZmllcyA9IGppZmZpZXM7CiAJciA9IGpp
ZmZpZXNfdG9fbXNlY3MoZW5kX2ppZmZpZXMgLSBzdGFydF9qaWZmaWVzKTsKLS0gCjIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
