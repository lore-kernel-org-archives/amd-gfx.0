Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308B3C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 08:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CAD216F4
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 08:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CAD216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24436E6A5;
	Thu, 28 Nov 2019 08:27:20 +0000 (UTC)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F107A6E6A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 08:27:18 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4BB07AD5D;
 Thu, 28 Nov 2019 08:27:17 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix wrongly passed static prefix
Date: Thu, 28 Nov 2019 09:27:14 +0100
Message-Id: <20191128082714.18609-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
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
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, David Zhou <David1.Zhou@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128082714.bPSx5EkrtsMvRXS2SGtF-Dd-KpfwjL0zS08nABHRr-s@z>

Q3VycmVudGx5LCBnY2Mgc3Bld3MgYSB3YXJuaW5nIGFzOgogIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHViYnViLmM6IEluIGZ1bmN0aW9uIOKA
mGh1YmJ1YjFfdmVyaWZ5X2FsbG93X3BzdGF0ZV9jaGFuZ2VfaGlnaOKAmToKICAuL2luY2x1ZGUv
ZHJtL2RybV9wcmludC5oOjMxNjoyOiB3YXJuaW5nOiDigJhkZWJ1Z19kYXRh4oCZIG1heSBiZSB1
c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVk
XQoKVGhpcyBpcyBiZWNhdXNlIHRoZSBjb2RlIGNoZWNrcyBhZ2FpbnN0IGEgc3RhdGljIHZhbHVl
IGFsdGhvdWdoIGl0J3MKYmFzaWNhbGx5IGEgY29uc3RhbnQgYW5kIGd1YXJhbnRlZWQgdG8gYmUg
c2V0LgoKVGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSB0eXBlIHByZWZpeCBmcm9tIHN0YXRpYyB0byBj
b25zdCBmb3IgYWRkcmVzc2luZwp0aGUgY29tcGlsZSB3YXJuaW5nIGFib3ZlIGFuZCBhbHNvIGZv
ciBsZXR0aW5nIHRoZSBjb21waWxlciBvcHRpbWl6ZQpiZXR0ZXIuCgpGaXhlczogNjJkNTkxYThl
MDBjICgiZHJtL2FtZC9kaXNwbGF5OiBjcmVhdGUgbmV3IGZpbGVzIGZvciBodWJidWIgZnVuY3Rp
b25zIikKU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9odWJidWIuYyB8IDQgKyst
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHViYnVi
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHViYnViLmMK
aW5kZXggYTAyYzEwZTIzZTBkLi5iNWM0NGMzYmRiOTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9odWJidWIuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHViYnViLmMKQEAgLTEyOCw4ICsxMjgs
OCBAQCBib29sIGh1YmJ1YjFfdmVyaWZ5X2FsbG93X3BzdGF0ZV9jaGFuZ2VfaGlnaCgKIAkgKiBw
c3RhdGUgdGFrZXMgYXJvdW5kIH4xMDB1cyBvbiBsaW51eC4gVW5rbm93biBjdXJyZW50bHkgYXMg
dG8KIAkgKiB3aHkgaXQgdGFrZXMgdGhhdCBsb25nIG9uIGxpbnV4CiAJICovCi0Jc3RhdGljIHVu
c2lnbmVkIGludCBwc3RhdGVfd2FpdF90aW1lb3V0X3VzID0gMjAwOwotCXN0YXRpYyB1bnNpZ25l
ZCBpbnQgcHN0YXRlX3dhaXRfZXhwZWN0ZWRfdGltZW91dF91cyA9IDQwOworCWNvbnN0IHVuc2ln
bmVkIGludCBwc3RhdGVfd2FpdF90aW1lb3V0X3VzID0gMjAwOworCWNvbnN0IHVuc2lnbmVkIGlu
dCBwc3RhdGVfd2FpdF9leHBlY3RlZF90aW1lb3V0X3VzID0gNDA7CiAJc3RhdGljIHVuc2lnbmVk
IGludCBtYXhfc2FtcGxlZF9wc3RhdGVfd2FpdF91czsgLyogZGF0YSBjb2xsZWN0aW9uICovCiAJ
c3RhdGljIGJvb2wgZm9yY2VkX3BzdGF0ZV9hbGxvdzsgLyogaGVscCB3aXRoIHJldmVydCB3YSAq
LwogCi0tIAoyLjE2LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
