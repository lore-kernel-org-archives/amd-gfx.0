Return-Path: <SRS0=zqFa=A6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CCAC433E1
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jul 2020 16:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EB9208B3
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jul 2020 16:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EB9208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=woland.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A9E6E0BA;
	Sun, 19 Jul 2020 16:22:43 +0000 (UTC)
X-Greylist: delayed 334 seconds by postgrey-1.36 at gabe;
 Sun, 19 Jul 2020 16:00:35 UTC
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 635C16E12F
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jul 2020 16:00:35 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4B8qDx31JZzQlKL;
 Sun, 19 Jul 2020 17:54:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
 by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de
 [80.241.56.122]) (amavisd-new, port 10030)
 with ESMTP id mXv2TB5Cr2yC; Sun, 19 Jul 2020 17:54:55 +0200 (CEST)
Date: Sun, 19 Jul 2020 17:54:53 +0200
From: =?utf-8?B?UGF3ZcWC?= Gronowski <me@woland.xyz>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix NULL dereference in dpm sysfs handlers
Message-ID: <20200719155453.GA16077@tower>
MIME-Version: 1.0
Content-Disposition: inline
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -3.97 / 15.00 / 15.00
X-Rspamd-Queue-Id: 0A4F21780
X-Rspamd-UID: 06e61f
X-Mailman-Approved-At: Sun, 19 Jul 2020 16:22:42 +0000
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

TlVMTCBkZXJlZmVyZW5jZSBvY2N1cnMgd2hlbiBzdHJpbmcgdGhhdCBpcyBub3QgZW5kZWQgd2l0
aCBzcGFjZSBvcgpuZXdsaW5lIGlzIHdyaXR0ZW4gdG8gc29tZSBkcG0gc3lzZnMgaW50ZXJmYWNl
IChmb3IgZXhhbXBsZSBwcF9kcG1fc2NsaykuClRoaXMgaGFwcGVucyBiZWNhdXNlIHN0cnNlcCBy
ZXBsYWNlcyB0aGUgdG1wIHdpdGggTlVMTCBpZiB0aGUgZGVsaW1pdGVyCmlzIG5vdCBwcmVzZW50
IGluIHN0cmluZywgd2hpY2ggaXMgdGhlbiBkZXJlZmVyZW5jZWQgYnkgdG1wWzBdLgoKUmVwcm9k
dWN0aW9uIGV4YW1wbGU6CnN1ZG8gc2ggLWMgJ2VjaG8gLW4gMSA+IC9zeXMvY2xhc3MvZHJtL2Nh
cmQwL2RldmljZS9wcF9kcG1fc2NsaycKClNpZ25lZC1vZmYtYnk6IFBhd2XFgiBHcm9ub3dza2kg
PG1lQHdvbGFuZC54eXo+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bt
LmMgfCA5ICsrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCmluZGV4IDAyZTZm
OGM0ZGRlMC4uZWJiOGEyOGZmMDAyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cG0uYwpAQCAtNzc4LDggKzc3OCw3IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9zZXRfcHBfb2Rf
Y2xrX3ZvbHRhZ2Uoc3RydWN0IGRldmljZSAqZGV2LAogCQl0bXBfc3RyKys7CiAJd2hpbGUgKGlz
c3BhY2UoKisrdG1wX3N0cikpOwogCi0Jd2hpbGUgKHRtcF9zdHJbMF0pIHsKLQkJc3ViX3N0ciA9
IHN0cnNlcCgmdG1wX3N0ciwgZGVsaW1pdGVyKTsKKwl3aGlsZSAoKHN1Yl9zdHIgPSBzdHJzZXAo
JnRtcF9zdHIsIGRlbGltaXRlcikpICE9IE5VTEwpIHsKIAkJcmV0ID0ga3N0cnRvbChzdWJfc3Ry
LCAwLCAmcGFyYW1ldGVyW3BhcmFtZXRlcl9zaXplXSk7CiAJCWlmIChyZXQpCiAJCQlyZXR1cm4g
LUVJTlZBTDsKQEAgLTEwMzksOCArMTAzOCw3IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9yZWFk
X21hc2soY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQsIHVpbnQzMl90ICptYXNrKQogCW1l
bWNweShidWZfY3B5LCBidWYsIGJ5dGVzKTsKIAlidWZfY3B5W2J5dGVzXSA9ICdcMCc7CiAJdG1w
ID0gYnVmX2NweTsKLQl3aGlsZSAodG1wWzBdKSB7Ci0JCXN1Yl9zdHIgPSBzdHJzZXAoJnRtcCwg
ZGVsaW1pdGVyKTsKKwl3aGlsZSAoKHN1Yl9zdHIgPSBzdHJzZXAoJnRtcCwgZGVsaW1pdGVyKSkg
IT0gTlVMTCkgewogCQlpZiAoc3RybGVuKHN1Yl9zdHIpKSB7CiAJCQlyZXQgPSBrc3RydG9sKHN1
Yl9zdHIsIDAsICZsZXZlbCk7CiAJCQlpZiAocmV0KQpAQCAtMTYzNyw4ICsxNjM1LDcgQEAgc3Rh
dGljIHNzaXplX3QgYW1kZ3B1X3NldF9wcF9wb3dlcl9wcm9maWxlX21vZGUoc3RydWN0IGRldmlj
ZSAqZGV2LAogCQkJaSsrOwogCQltZW1jcHkoYnVmX2NweSwgYnVmLCBjb3VudC1pKTsKIAkJdG1w
X3N0ciA9IGJ1Zl9jcHk7Ci0JCXdoaWxlICh0bXBfc3RyWzBdKSB7Ci0JCQlzdWJfc3RyID0gc3Ry
c2VwKCZ0bXBfc3RyLCBkZWxpbWl0ZXIpOworCQl3aGlsZSAoKHN1Yl9zdHIgPSBzdHJzZXAoJnRt
cF9zdHIsIGRlbGltaXRlcikpICE9IE5VTEwpIHsKIAkJCXJldCA9IGtzdHJ0b2woc3ViX3N0ciwg
MCwgJnBhcmFtZXRlcltwYXJhbWV0ZXJfc2l6ZV0pOwogCQkJaWYgKHJldCkKIAkJCQlyZXR1cm4g
LUVJTlZBTDsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
