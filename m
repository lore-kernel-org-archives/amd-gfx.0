Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62336C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 03:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340AB2073B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 03:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQCcC1YX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340AB2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6056E112;
	Wed,  6 May 2020 03:29:37 +0000 (UTC)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C166E112
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 03:29:36 +0000 (UTC)
Received: by mail-lj1-x241.google.com with SMTP id g4so802998ljl.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2020 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=DBpdifwlseKbEzCwMtz3Wa3IWc6MmWSsZNs5VHQzTqI=;
 b=SQCcC1YXB6JkBEyzdtnVQYqvwqtQ5NdqDqVEf1i+ffYIAPwajzbpttkQ5z+MCF3/N5
 ic3mK4nmvTcDKBnqNNI292JhLl4SvSCHELhj6dihDFI7VqCMeyUmILP3eeAYqnoWPYdl
 vKYtlG5ZWFlUBF1/MEVoPZ2YnvPXZj+2+zLLknY7FwnAEUxfCSyXgy8z/pb86k4WY4CX
 NWZHK/r0vBr3ym8yy0J6b15zMZuUplELuNEOtjfFbe55qpbJihaSjNFUmx6D6khDVbJJ
 c4GxkNY1CofDTDPUKsb/u1EgNXTDTiG01sp/Ry8sXObtqMtqFkSf8vQW7mn6000GPDl6
 VVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=DBpdifwlseKbEzCwMtz3Wa3IWc6MmWSsZNs5VHQzTqI=;
 b=lSgeQTjl2fHMHbbFxZtd05CviZDDyva2UXTQauVkQBcq3nBOUU3zfWanPeynXa3tNJ
 NQ0a7zbw2wxlkhwvJoAt2ktw3w+JbW7oDNapU+ps9Z56YeZNOna46ihubQogMTZ0+RIn
 Cm6tnqMFazq/GB6vGG+juU193cDPtQoDh/zKsXyM0g2xPgvqY31m100aYERFvY2mZPgj
 gJBFOtrwhEg4kCMWKYjYfrCyoOL0RBgfHX+09vGLIPeo9TioB5fR58It/T5QaUr4ESVi
 JlNkU/AVp+y0IDnkXcJ9J8ntY5FaYY8Nf5cGd1Mb958wr8rew3RaVCIcrAmzTfCBc3Ui
 vGYQ==
X-Gm-Message-State: AGi0PuYjdbQSFiWSebhedM12yQiLuR2Z43jfvzm1r0irAx2Cn5XzhEr6
 zKXzD7TZ/lgbUgFJmS5NVQvHiOvHBtUN1XNOIJI=
X-Google-Smtp-Source: APiQypJ6OPghTFCVATMXnNggmfYtUOmogdIYqxz1qOa6BwGFsSc3IMYgHR8V5T5Z5OAQwjhc/ybigjYedtLnTiS/8rY=
X-Received: by 2002:a2e:9dcd:: with SMTP id x13mr3385404ljj.120.1588735774719; 
 Tue, 05 May 2020 20:29:34 -0700 (PDT)
MIME-Version: 1.0
From: Aaron Chou <zhoubb.aaron@gmail.com>
Date: Wed, 6 May 2020 11:29:23 +0800
Message-ID: <CAMpQs4+BGDNQVSfBHDO1uctSwCHh67-6PiBWE6BoV-gDfW07bw@mail.gmail.com>
Subject: A curious phenomenon in HDMI hotplug.
To: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, David1.Zhou@amd.com
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

SGkgYWxsOgoKSSdtIGEgbmV3ZXIgYWJvdXQgdGhlIGFtZGdwdSBkcml2ZXIuCkkgaGF2ZSBhIHF1
ZXN0aW9uIGFib3V0IGl0LgpJbiBteSBjb21wYW55LCB0aGVyZSBhcmUgc29tZSBleHBlcmltZW50
cyBhYm91dCBIRE1JIGhvdHBsdWcuCkZpcnN0LCBJIGludHJvZHVjZSB0aGUgbGFiIGVudmlyb25t
ZW50OgpjcHU6IGh1YXdlaSBrdW5wZW5nCm9zOiB1b3MKa2VybmVsOiA0LjE5LjkwCnZpZGVvIGNh
cmQ6IFJhZGVvbiBIRCA3MDAKCnRoZSBsYWIgc3RlcCBpczoKMSwgSSBjb25uZWN0IHRoZSBoZG1p
IGFuZCB2Z2Egd2l0aCB0aGUgZXhwYW5kIG1vZGU7CjIuIEkgZGlzY29ubmVjdCB0aGUgaGRtaSBj
b25uZWN0b3IsIGJ1dCB0aGUgYXBwIGRpc3BsYXkgaW4gdGhlIGhkbWkgaXMKbm90IGJhY2sgdG8g
dmdhLCBhbmQgdGhlIG1vZGUgaXMgc3RpbGwgZXhwYW5kIG1vZGUuCgpJIGZvdW5kIHdoZW4gSSBk
aXNjb25uZWN0IHRoZSBoZG1pIGNvbm5lY3RvciwgdGhlIHN5cyBmaWxlcyBhYm91dCBIRE1JCmFy
ZSBrZWVwIHRoZSBjb25uZWN0aW9uIHN0YXR1cy4KU3VjaCBhcyB0aGUgdmFsdWUgb2YgL3N5cy9j
bGFzcy9kcm0vY2FyZDAtSERNSS1BLTEvc3RhdHVzIGlzCmNvbm5lY3RlZCwgYW5kIEkgY2FuIHJl
YWQgdGhlIGVkaWQgZmlsZSBjb3JyZWN0bHkuCkF0IHRoaXMgbW9tZW50LCBJIHVzZSBJMkMgZHJp
dmVyIHRvIHJlYWQgdGhlIGVkaWQgdmlhIC9kZXYvaTJjLVguIEkKY2FuIG5vdCBnZXQgdGhlIGVk
aWQgdmFsdWUuCgpJbiBrZXJuZWwgc291cmNlICxJIGZvdW5kIHRoZSBzdXNwaWNpb3VzIHBvaW50
cyBpbgphbWRncHVfY29ubmVjdG9yX2R2aV9kZXRlY3QoKSAoYW1kZ3B1X2Nvbm5lY3Rvci5jKQoK
SW4gYW1kZ3B1X2Nvbm5lY3Rvcl9kdmlfZGV0ZWN0KCkgZnVuY3Rpb24sClRoZSBocGQgc3RhdHVz
IHdhcyBjb3JyZWN0bHkgdGhyb3VnaCB0aGUgYW1kZ3B1X2Rpc3BsYXlfaHBkX3NlbmNlKCksCmJ1
dCB0aGUgZGRjIHByb2JlIG9wZXJhdGlvbiBpcyBzdWNjZXNzZWQgdmlhCmFtZGdwdV9kaXNwbGF5
X2RkY19wcm9iZSgpCgpJIGFtIHNvIGNvbmZ1c2VkLgoKSXMgaXQgYSBub3JtYWwgYmVoYXZpb3I/
CgpJIGhhdmUgd3JpdHRlbiBhIHdvcmthcm91bmQgcGF0Y2ggdG8gZml4IHRoaXMgcHJvYmxlbS4K
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY29ubmVjdG9y
cy5jCmIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYwppbmRl
eCBjNzcwZDczMzUyYTcuLjQ4MDljZWI1NmY1ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY29ubmVjdG9ycy5jCkBAIC05NzUsNyArOTc1LDcgQEAgYW1kZ3B1X2Nv
bm5lY3Rvcl9kdmlfZGV0ZWN0KHN0cnVjdCBkcm1fY29ubmVjdG9yCipjb25uZWN0b3IsIGJvb2wg
Zm9yY2UpCiAgICAgICAgY29uc3Qgc3RydWN0IGRybV9lbmNvZGVyX2hlbHBlcl9mdW5jcyAqZW5j
b2Rlcl9mdW5jczsKICAgICAgICBpbnQgcjsKICAgICAgICBlbnVtIGRybV9jb25uZWN0b3Jfc3Rh
dHVzIHJldCA9IGNvbm5lY3Rvcl9zdGF0dXNfZGlzY29ubmVjdGVkOwotICAgICAgIGJvb2wgZHJl
dCA9IGZhbHNlLCBicm9rZW5fZWRpZCA9IGZhbHNlOworICAgICAgIGJvb2wgZHJldCA9IGZhbHNl
LCBicm9rZW5fZWRpZCA9IGZhbHNlLCB1bmtub3duX3N0YXR1cyA9IGZhbHNlOwoKICAgICAgICBp
ZiAoIWRybV9rbXNfaGVscGVyX2lzX3BvbGxfd29ya2VyKCkpIHsKICAgICAgICAgICAgICAgIHIg
PSBwbV9ydW50aW1lX2dldF9zeW5jKGNvbm5lY3Rvci0+ZGV2LT5kZXYpOwpAQCAtOTkwLDcgKzk5
MCwxMSBAQCBhbWRncHVfY29ubmVjdG9yX2R2aV9kZXRlY3Qoc3RydWN0IGRybV9jb25uZWN0b3IK
KmNvbm5lY3RvciwgYm9vbCBmb3JjZSkKCiAgICAgICAgaWYgKGFtZGdwdV9jb25uZWN0b3ItPmRk
Y19idXMpCiAgICAgICAgICAgICAgICBkcmV0ID0gYW1kZ3B1X2Rpc3BsYXlfZGRjX3Byb2JlKGFt
ZGdwdV9jb25uZWN0b3IsIGZhbHNlKTsKLSAgICAgICBpZiAoZHJldCkgeworCisgICAgICAgaWYg
KCFhbWRncHVfZGlzcGxheV9ocGRfc2Vuc2UoYWRldiwgYW1kZ3B1X2Nvbm5lY3Rvci0+aHBkLmhw
ZCkpCisgICAgICAgICAgICAgICB1bmtub3duX3N0YXR1cyA9IHRydWU7CisKKyAgICAgICBpZiAo
ZHJldCAmJiAhdW5rbm93bl9zdGF0dXMpIHsKICAgICAgICAgICAgICAgIGFtZGdwdV9jb25uZWN0
b3ItPmRldGVjdGVkX2J5X2xvYWQgPSBmYWxzZTsKICAgICAgICAgICAgICAgIGFtZGdwdV9jb25u
ZWN0b3JfZnJlZV9lZGlkKGNvbm5lY3Rvcik7CiAgICAgICAgICAgICAgICBhbWRncHVfY29ubmVj
dG9yX2dldF9lZGlkKGNvbm5lY3Rvcik7CgpJcyBpdCBjb3JyZWN0bHkuCgpCZXN0IFdpc2hlc++8
gQoKQWFyb24uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
