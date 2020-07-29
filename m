Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F3C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 02:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876FD2082E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 02:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876FD2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=woland.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097AE6E849;
	Thu, 30 Jul 2020 02:20:09 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226FC6E7EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 23:11:16 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:2:0])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4BH8Rh3DblzKmhH;
 Thu, 30 Jul 2020 01:11:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
 by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de
 [80.241.56.117]) (amavisd-new, port 10030)
 with ESMTP id FGVxHbffKX1E; Thu, 30 Jul 2020 01:11:09 +0200 (CEST)
Date: Thu, 30 Jul 2020 01:11:06 +0200
From: =?utf-8?B?UGF3ZcWC?= Gronowski <me@woland.xyz>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix regression in adjusting power table/profile
Message-ID: <20200729231106.GA6598@tower>
MIME-Version: 1.0
Content-Disposition: inline
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -2.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: 758091780
X-Rspamd-UID: 50ce95
X-Mailman-Approved-At: Thu, 30 Jul 2020 02:20:08 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmVncmVzc2lvbiB3YXMgaW50cm9kdWNlZCBpbiBjb21taXQgMzhlMGM4OWExOWZkCigiZHJtL2Ft
ZGdwdTogRml4IE5VTEwgZGVyZWZlcmVuY2UgaW4gZHBtIHN5c2ZzIGhhbmRsZXJzIikgd2hpY2gK
bWFkZSB0aGUgc2V0X3BwX29kX2Nsa192b2x0YWdlIGFuZCBzZXRfcHBfcG93ZXJfcHJvZmlsZV9t
b2RlIHJldHVybgotRUlOVkFMIGZvciBwcmV2aW91c2x5IHZhbGlkIGlucHV0LiBUaGlzIHdhcyBj
YXVzZWQgYnkgYW4gZW1wdHkKc3RyaW5nIChzdGFydGluZyBhdCB0aGUgXDAgY2hhcmFjdGVyKSBi
ZWluZyBwYXNzZWQgdG8gdGhlIGtzdHJ0b2wuCgpTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgR3Jvbm93
c2tpIDxtZUB3b2xhbmQueHl6PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wbS5jIHwgOSArKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYwppbmRleCBl
YmI4YTI4ZmYwMDIuLmNiZjYyM2ZmMDNiZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BtLmMKQEAgLTc3OCwxMiArNzc4LDE0IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9zZXRf
cHBfb2RfY2xrX3ZvbHRhZ2Uoc3RydWN0IGRldmljZSAqZGV2LAogCQl0bXBfc3RyKys7CiAJd2hp
bGUgKGlzc3BhY2UoKisrdG1wX3N0cikpOwogCi0Jd2hpbGUgKChzdWJfc3RyID0gc3Ryc2VwKCZ0
bXBfc3RyLCBkZWxpbWl0ZXIpKSAhPSBOVUxMKSB7CisJd2hpbGUgKChzdWJfc3RyID0gc3Ryc2Vw
KCZ0bXBfc3RyLCBkZWxpbWl0ZXIpKSAmJiAqc3ViX3N0cikgewogCQlyZXQgPSBrc3RydG9sKHN1
Yl9zdHIsIDAsICZwYXJhbWV0ZXJbcGFyYW1ldGVyX3NpemVdKTsKIAkJaWYgKHJldCkKIAkJCXJl
dHVybiAtRUlOVkFMOwogCQlwYXJhbWV0ZXJfc2l6ZSsrOwogCisJCWlmICghdG1wX3N0cikKKwkJ
CWJyZWFrOwogCQl3aGlsZSAoaXNzcGFjZSgqdG1wX3N0cikpCiAJCQl0bXBfc3RyKys7CiAJfQpA
QCAtMTYzNSwxMSArMTYzNywxNCBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfc2V0X3BwX3Bvd2Vy
X3Byb2ZpbGVfbW9kZShzdHJ1Y3QgZGV2aWNlICpkZXYsCiAJCQlpKys7CiAJCW1lbWNweShidWZf
Y3B5LCBidWYsIGNvdW50LWkpOwogCQl0bXBfc3RyID0gYnVmX2NweTsKLQkJd2hpbGUgKChzdWJf
c3RyID0gc3Ryc2VwKCZ0bXBfc3RyLCBkZWxpbWl0ZXIpKSAhPSBOVUxMKSB7CisJCXdoaWxlICgo
c3ViX3N0ciA9IHN0cnNlcCgmdG1wX3N0ciwgZGVsaW1pdGVyKSkgJiYgKnN1Yl9zdHIpIHsKIAkJ
CXJldCA9IGtzdHJ0b2woc3ViX3N0ciwgMCwgJnBhcmFtZXRlcltwYXJhbWV0ZXJfc2l6ZV0pOwog
CQkJaWYgKHJldCkKIAkJCQlyZXR1cm4gLUVJTlZBTDsKIAkJCXBhcmFtZXRlcl9zaXplKys7CisK
KwkJCWlmICghdG1wX3N0cikKKwkJCQlicmVhazsKIAkJCXdoaWxlIChpc3NwYWNlKCp0bXBfc3Ry
KSkKIAkJCQl0bXBfc3RyKys7CiAJCX0KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
