Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD491C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 18:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8546C217D7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 18:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8546C217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 339AC6E260;
	Wed,  6 Nov 2019 18:03:36 +0000 (UTC)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106916E260
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 18:03:35 +0000 (UTC)
Received: by mail-io1-xd43.google.com with SMTP id r144so27963532iod.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2019 10:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UBSs7PM5jpYYxu4tck1UckAz+7iHSE2RxaccmFYbomE=;
 b=YQOVs5xkq6FD3s6z+TjcyGk/jrKqiyDJoF+OxKqgpVZ202QSMRBYTfPaLZvlzJOa3S
 GgMc5S3iB5KxP5ypFLCRfpOQRzxdpo3NZLcEOuBOeJNEy45pg0jum/YpOdtOKNRaSFm7
 i6oXYFANBLOLYYVFv64lic/RUvBKbIFXhs+5zW6y+QXLg2SPjRMgYuthE65n10hnpRds
 8HSseU93OVBAymgYVxNyC0I1DzhB3UinRZuWmQg3X70XVJG9QP9FL7tLSgLOc+976bZS
 f8Xca4RZPR99FXyXwHxQBNfEbn/QzjissSXPh4tZ+4uZ/B+AV35URn0xG4ursd0Ep59G
 IpEQ==
X-Gm-Message-State: APjAAAVU1xMRqEzWlRHBT5iVplFtBNHlqMnOVvEJIi9uzt3THi4hu9Vb
 RXLHgMyCzWhAsS4DyJppYyC1HHlrjw8=
X-Google-Smtp-Source: APXvYqxNF+XlmYjk7skJVf4jV8nOCNBAfZgP0AkgUwuPKszMhzJ9Hy5Tc3A5AA/mEU2lGyszIOYhEg==
X-Received: by 2002:a02:6591:: with SMTP id u139mr66680jab.110.1573063414184; 
 Wed, 06 Nov 2019 10:03:34 -0800 (PST)
Received: from localhost.localdomain ([2602:47:da84:5600:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id
 2sm3467831ilw.50.2019.11.06.10.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 10:03:33 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/navi10: Correctly source TDPODLimit from overdrive
 table
Date: Wed,  6 Nov 2019 11:03:26 -0700
Message-Id: <20191106180326.48535-1-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UBSs7PM5jpYYxu4tck1UckAz+7iHSE2RxaccmFYbomE=;
 b=HXF009+e3NKCNUSofMyaoPYhJErILigtTNIC79i4kluOvZh+FBkhbYcah5z0Fo8qMN
 SwQQyM/aDSIvH+BBPm0p9vGRyjvM7idIWwDJ7vmGbbZC1xo0rvfhAsUu/l4Wb6/8SIzs
 B8g3BnMmL2fKUEIPbH8uie/qRfBGEPj9a+5HqTItzWVPsQQm8TJsphlpStG25VdxiXA/
 BToaxPy+4UaP0nIpvR9estDWn8AEPaopVc9rUEp0Vz8EFahGpKOuk2C/B/RKEOgPmJ4z
 rWIRkCg0sm+rSErszPTgQqHAaX2kiRPAX6ui01dCL2TBTP1/yRQ8mdxHbm3Uq1TcNRuC
 tfOA==
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
Cc: Matt Coffin <mcoffin13@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106180326.FXg7IkBVtXQqLimzK4XMSANmQZQr_3AGNyRrViLFIiw@z>

W1doeV0KQmVmb3JlIHRoaXMgcGF0Y2gsIHRoZSBzbXVfdjExXzAgcG93ZXIgbGltaXQgc2V0dGlu
ZyBmdW5jdGlvbgppbmNvcnJlY3RseSBhbHdheXMgdGhvdWdodCB0aGF0IFREUE9ETGltaXQgd2Fz
IDAgb24gbmF2aTEwIGNhcmRzLiBUaGlzCm1lYW50IHRoYXQgYmV0d2VlbiA1LjMgYW5kIDUuNCwg
d2hlbiB0aGUgcG93ZXIgbGltaXQgc3RhcnRlZCBiZWluZwpvYmV5ZWQsIG9uZSBjb3VsZCBubyBs
b25nZXIgc2V0IGhpZ2hlciBwb3dlciBsaW1pdHMgZm9yIG5hdmkxMC4KCltIb3ddCkp1c3QgYXMg
Zm9yIHZlZ2EyMCwgd2Ugc2V0IHRoZSBwb3dlciBsaW1pdCAoYW5kIFREUE9ETGltaXQpIGZyb20g
dGhlCnBvd2VycGxheSB0YWJsZSB3aGVuIGl0IGlzIHdyaXR0ZW4uIFdlIG5lZWQgdG8gYWxzbyB3
cml0ZQpzbXUtPmRlZmF1bHRfcG93ZXJfbGltaXQsIGFzIGl0IGlzIGNhY2hlZCB0aGUgZmlyc3Qg
dGltZSB0aGUgcG93ZXIgbGltaXQKaXMgZmV0Y2hlZC4gVGhpcyBhbGxvd3Mgd3JpdGluZyAic29m
dCIgcG93ZXJwbGF5IHRhYmxlcyB3aXRoIGhpZ2hlcgpwb3dlciBsaW1pdHMgaW4gdGhlIE92ZXJE
cml2ZTggdGFibGUsIHRoZW4gdXNpbmcgdGhlIGh3bW9uIHN5c2ZzCmludGVyZmFjZSBmb3Igc2V0
dGluZyB0aGUgYWN0dWFsIHBvd2VyIGxpbWl0LgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L25hdmkxMF9wcHQuYyB8IDkgKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9zbXVfdjExXzAuYyAgfCA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9u
YXZpMTBfcHB0LmMKaW5kZXggMGI0NjE0MDRhZjZiLi4zYWMzMWQ0ZjUxN2MgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKQEAgLTQ5Miw2ICs0OTIsNyBAQCBz
dGF0aWMgaW50IG5hdmkxMF9hcHBlbmRfcG93ZXJwbGF5X3RhYmxlKHN0cnVjdCBzbXVfY29udGV4
dCAqc211KQogCiBzdGF0aWMgaW50IG5hdmkxMF9zdG9yZV9wb3dlcnBsYXlfdGFibGUoc3RydWN0
IHNtdV9jb250ZXh0ICpzbXUpCiB7CisJdWludDMyX3QgYmFzZV9wb3dlcl9saW1pdDsKIAlzdHJ1
Y3Qgc211XzExXzBfcG93ZXJwbGF5X3RhYmxlICpwb3dlcnBsYXlfdGFibGUgPSBOVUxMOwogCXN0
cnVjdCBzbXVfdGFibGVfY29udGV4dCAqdGFibGVfY29udGV4dCA9ICZzbXUtPnNtdV90YWJsZTsK
IAlzdHJ1Y3Qgc211X2JhY29fY29udGV4dCAqc211X2JhY28gPSAmc211LT5zbXVfYmFjbzsKQEAg
LTUwNSw2ICs1MDYsMTQgQEAgc3RhdGljIGludCBuYXZpMTBfc3RvcmVfcG93ZXJwbGF5X3RhYmxl
KHN0cnVjdCBzbXVfY29udGV4dCAqc211KQogCSAgICAgICBzaXplb2YoUFBUYWJsZV90KSk7CiAK
IAl0YWJsZV9jb250ZXh0LT50aGVybWFsX2NvbnRyb2xsZXJfdHlwZSA9IHBvd2VycGxheV90YWJs
ZS0+dGhlcm1hbF9jb250cm9sbGVyX3R5cGU7CisJdGFibGVfY29udGV4dC0+VERQT0RMaW1pdCA9
IGxlMzJfdG9fY3B1KHBvd2VycGxheV90YWJsZS0+b3ZlcmRyaXZlX3RhYmxlLm1heFtTTVVfMTFf
MF9PRFNFVFRJTkdfUE9XRVJQRVJDRU5UQUdFXSk7CisJaWYgKHNtdS0+b2RfZW5hYmxlZCkgewor
CQkvLyByZS1jYWxjdWxhdGUgdGhlIGRlZmF1bHQgcG93ZXIgbGltaXQgZnJvbSBuZXcgcHBfdGFi
bGUKKwkJYmFzZV9wb3dlcl9saW1pdCA9IHBvd2VycGxheV90YWJsZS0+c21jX3BwdGFibGUuU29j
a2V0UG93ZXJMaW1pdEFjW1BQVF9USFJPVFRMRVJfUFBUMF07CisJCWJhc2VfcG93ZXJfbGltaXQg
Kj0gKDEwMCArIHRhYmxlX2NvbnRleHQtPlREUE9ETGltaXQpOworCQliYXNlX3Bvd2VyX2xpbWl0
IC89IDEwMDsKKwkJc211LT5kZWZhdWx0X3Bvd2VyX2xpbWl0ID0gYmFzZV9wb3dlcl9saW1pdDsK
Kwl9CiAKIAltdXRleF9sb2NrKCZzbXVfYmFjby0+bXV0ZXgpOwogCWlmIChwb3dlcnBsYXlfdGFi
bGUtPnBsYXRmb3JtX2NhcHMgJiBTTVVfMTFfMF9QUF9QTEFURk9STV9DQVBfQkFDTyB8fApkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYwppbmRleCBjNTI1N2FlMzE4OGEu
LmFiZDM5MTJhMjFjOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
c211X3YxMV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8w
LmMKQEAgLTEwNjgsOCArMTA2OCw4IEBAIHN0YXRpYyBpbnQgc211X3YxMV8wX3NldF9wb3dlcl9s
aW1pdChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgdWludDMyX3QgbikKIAlpbnQgcmV0ID0gMDsK
IAogCWlmIChuID4gc211LT5kZWZhdWx0X3Bvd2VyX2xpbWl0KSB7Ci0JCXByX2VycigiTmV3IHBv
d2VyIGxpbWl0IGlzIG92ZXIgdGhlIG1heCBhbGxvd2VkICVkXG4iLAotCQkJCXNtdS0+ZGVmYXVs
dF9wb3dlcl9saW1pdCk7CisJCXByX2VycigiTmV3IHBvd2VyIGxpbWl0ICglZCkgaXMgb3ZlciB0
aGUgbWF4IGFsbG93ZWQgJWRcbiIsCisJCQkJbiwgc211LT5kZWZhdWx0X3Bvd2VyX2xpbWl0KTsK
IAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCi0tIAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
