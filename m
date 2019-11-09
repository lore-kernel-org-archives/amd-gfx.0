Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E92C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 08:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CC820818
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 08:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CC820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69BB6E854;
	Mon, 11 Nov 2019 08:09:42 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83B0D6E3F5;
 Sat,  9 Nov 2019 19:49:27 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1iTWjb-00082x-Pg; Sat, 09 Nov 2019 19:49:23 +0000
From: Colin King <colin.king@canonical.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH][next] drm/amd/display: fix spelling mistake "exeuction" ->
 "execution"
Date: Sat,  9 Nov 2019 19:49:23 +0000
Message-Id: <20191109194923.231655-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Nov 2019 08:09:41 +0000
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191109194923.hbHypzpGZGkKmfZeSHkJODFlz3SXOKvLf-EPZFF6S1s@z>

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZXJlIGFy
ZSBzcGVsbGluZyBtaXN0YWtlcyBpbiBhIERDX0VSUk9SIG1lc3NhZ2UgYW5kIGEgY29tbWVudC4K
Rml4IHRoZXNlLgoKU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fu
b25pY2FsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZG11Yl9z
cnYuYyAgICB8IDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXVi
X3Nydi5oIHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2Rt
dWJfc3J2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZG11Yl9zcnYuYwpp
bmRleCA2MWNlZmUwYTM3OTAuLmI2NWI2NjAyNTI2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2RtdWJfc3J2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjX2RtdWJfc3J2LmMKQEAgLTkyLDcgKzkyLDcgQEAgdm9pZCBkY19kbXVi
X3Nydl9jbWRfZXhlY3V0ZShzdHJ1Y3QgZGNfZG11Yl9zcnYgKmRjX2RtdWJfc3J2KQogCiAJc3Rh
dHVzID0gZG11Yl9zcnZfY21kX2V4ZWN1dGUoZG11Yik7CiAJaWYgKHN0YXR1cyAhPSBETVVCX1NU
QVRVU19PSykKLQkJRENfRVJST1IoIkVycm9yIHN0YXJ0aW5nIERNVUIgZXhldWN0aW9uOiBzdGF0
dXM9JWRcbiIsIHN0YXR1cyk7CisJCURDX0VSUk9SKCJFcnJvciBzdGFydGluZyBETVVCIGV4ZWN1
dGlvbjogc3RhdHVzPSVkXG4iLCBzdGF0dXMpOwogfQogCiB2b2lkIGRjX2RtdWJfc3J2X3dhaXRf
aWRsZShzdHJ1Y3QgZGNfZG11Yl9zcnYgKmRjX2RtdWJfc3J2KQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfc3J2LmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZG11Yi9pbmMvZG11Yl9zcnYuaAppbmRleCBhYThmMDM5NjYxNmQuLjQ1
ZTQyN2QxOTUyZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIv
aW5jL2RtdWJfc3J2LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5j
L2RtdWJfc3J2LmgKQEAgLTQxNiw3ICs0MTYsNyBAQCBlbnVtIGRtdWJfc3RhdHVzIGRtdWJfc3J2
X2NtZF9xdWV1ZShzdHJ1Y3QgZG11Yl9zcnYgKmRtdWIsCiAgKiBkbXViX3Nydl9jbWRfZXhlY3V0
ZSgpIC0gRXhlY3V0ZXMgYSBxdWV1ZWQgc2VxdWVuY2UgdG8gdGhlIGRtdWIKICAqIEBkbXViOiB0
aGUgZG11YiBzZXJ2aWNlCiAgKgotICogQmVnaW5zIGV4ZXVjdGlvbiBvZiBxdWV1ZWQgY29tbWFu
ZHMgb24gdGhlIGRtdWIuCisgKiBCZWdpbnMgZXhlY3V0aW9uIG9mIHF1ZXVlZCBjb21tYW5kcyBv
biB0aGUgZG11Yi4KICAqCiAgKiBSZXR1cm46CiAgKiAgIERNVUJfU1RBVFVTX09LIC0gc3VjY2Vz
cwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
