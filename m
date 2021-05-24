Return-Path: <SRS0=Iydh=KT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F88AC47085
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 14:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACE6617ED
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 14:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACE6617ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCD86E885;
	Mon, 24 May 2021 14:51:52 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CF486E883;
 Mon, 24 May 2021 14:51:50 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AC806191D;
 Mon, 24 May 2021 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621867910;
 bh=Joz1eCpODLqPQKgdaHCknTXdIpMinnHu/FUByIrYEDg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WEO703QcCjGlbeWYtFxdFQPusQIst0+7Ic/sZFvGXeVuJsYEWEBqwaJityhA9ajUu
 SrRsPdjOa+ZqHiWp+BHqzQyKo5+UWsan7qv6tc6cB/q2RF/QHkGtDXMb2pk3uQ3FqU
 ZPphXAj5k4lwocYLRWVNe1KXJuKFIZ/2oNQApw3uOrDBCpy/HeOk/416X4cKW4uYDx
 fvsXbwvbkM/f6tIflFAcp4UH8+kTVdG4Y5jNoLF9MoTQThJJu5p9nguD+znTOG/O8M
 7IKqLcvPlNWP9aPc65cyZPplD0AQ/diVhWys/Xix3jmlPlYDvr72kmNZd2AVucvULk
 jQgTvbdB0YTsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 16/16] drm/amdgpu: Fix a use-after-free
Date: Mon, 24 May 2021 10:51:30 -0400
Message-Id: <20210524145130.2499829-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524145130.2499829-1-sashal@kernel.org>
References: <20210524145130.2499829-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, xinhui pan <xinhui.pan@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgoKWyBVcHN0cmVhbSBjb21taXQg
MWU1YzM3Mzg1MDk3YzM1OTExYjBmOGEwYzY3ZmZkMTBlZTFhZjlhMiBdCgpsb29rcyBsaWtlIHdl
IGZvcmdldCB0byBzZXQgdHRtLT5zZyB0byBOVUxMLgpIaXQgcGFuaWMgYmVsb3cKClsgMTIzNS44
NDQxMDRdIGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCwgcHJvYmFibHkgZm9yIG5vbi1jYW5vbmlj
YWwgYWRkcmVzcyAweDZiNmI2YjZiNmI2YjdiNGI6IDAwMDAgWyMxXSBTTVAgREVCVUdfUEFHRUFM
TE9DIE5PUFRJClsgMTIzNS45ODkwNzRdIENhbGwgVHJhY2U6ClsgMTIzNS45OTE3NTFdICBzZ19m
cmVlX3RhYmxlKzB4MTcvMHgyMApbIDEyMzUuOTk1NjY3XSAgYW1kZ3B1X3R0bV9iYWNrZW5kX3Vu
YmluZC5jb2xkKzB4NGQvMHhmNyBbYW1kZ3B1XQpbIDEyMzYuMDAyMjg4XSAgYW1kZ3B1X3R0bV9i
YWNrZW5kX2Rlc3Ryb3krMHgyOS8weDEzMCBbYW1kZ3B1XQpbIDEyMzYuMDA4NDY0XSAgdHRtX3R0
X2Rlc3Ryb3krMHgxZS8weDMwIFt0dG1dClsgMTIzNi4wMTMwNjZdICB0dG1fYm9fY2xlYW51cF9t
ZW10eXBlX3VzZSsweDUxLzB4YTAgW3R0bV0KWyAxMjM2LjAxODc4M10gIHR0bV9ib19yZWxlYXNl
KzB4MjYyLzB4YTUwIFt0dG1dClsgMTIzNi4wMjM1NDddICB0dG1fYm9fcHV0KzB4ODIvMHhkMCBb
dHRtXQpbIDEyMzYuMDI3NzY2XSAgYW1kZ3B1X2JvX3VucmVmKzB4MjYvMHg1MCBbYW1kZ3B1XQpb
IDEyMzYuMDMyODA5XSAgYW1kZ3B1X2FtZGtmZF9ncHV2bV9hbGxvY19tZW1vcnlfb2ZfZ3B1KzB4
N2FhLzB4ZDkwIFthbWRncHVdClsgMTIzNi4wNDA0MDBdICBrZmRfaW9jdGxfYWxsb2NfbWVtb3J5
X29mX2dwdSsweGUyLzB4MzMwIFthbWRncHVdClsgMTIzNi4wNDY5MTJdICBrZmRfaW9jdGwrMHg0
NjMvMHg2OTAgW2FtZGdwdV0KClNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5A
YW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMSArCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHRtLmMKaW5kZXggNmJlYjNlNzZlMWM5Li4wMTRiODcxNDM4MzcgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTczNyw2ICs3MzcsNyBAQCBzdGF0aWMgdm9pZCBh
bWRncHVfdHRtX3R0X3VucG9wdWxhdGUoc3RydWN0IHR0bV90dCAqdHRtKQogCiAJaWYgKGd0dCAm
JiBndHQtPnVzZXJwdHIpIHsKIAkJa2ZyZWUodHRtLT5zZyk7CisJCXR0bS0+c2cgPSBOVUxMOwog
CQl0dG0tPnBhZ2VfZmxhZ3MgJj0gflRUTV9QQUdFX0ZMQUdfU0c7CiAJCXJldHVybjsKIAl9Ci0t
IAoyLjMwLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
