Return-Path: <SRS0=Iydh=KT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCA4C2B9F7
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 14:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA85613B6
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 14:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA85613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389B96E855;
	Mon, 24 May 2021 14:47:37 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2255C6E857;
 Mon, 24 May 2021 14:47:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 233D7613F8;
 Mon, 24 May 2021 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621867656;
 bh=43Ep8yTKFx8b5Cs4UYEBqADSxw+9vpWN/kaNXflbzXY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=toZemQ1ArI9TGyZ7f2w9bnzpfIPb2gy9rQi61I29ZCUUCIq4naP86FRIEnRRGyAm7
 udNedA0NruoNEjg09gKnMhIn1mdjLntHoKdAKT+hWevLd8YQ9eYxir0j2BwuezN52/
 EFndQmjRCSuqvdQYl+3mbbeh/yVkCjtZAfS+X06X8jwp7c5Suihy0IIpbCKVCt7Taj
 mJ7xDOqI0Brq8mZTLGblvSiDzEah/ANA6cfMk40zHQWjyTYFAG6xea12s64SYYJOvN
 EELAX0iS+Agf50MGot8GxkYuT2hhan4RoTFHMZSfS7Za8PhW1wmDVHEmTi0d/FQyti
 5Us9baE+/t98Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 58/63] drm/amdgpu: Fix a use-after-free
Date: Mon, 24 May 2021 10:46:15 -0400
Message-Id: <20210524144620.2497249-58-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524144620.2497249-1-sashal@kernel.org>
References: <20210524144620.2497249-1-sashal@kernel.org>
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
dHRtLmMKaW5kZXggMzgzYzE3OGNmMDc0Li5iYmM3M2NkZTZiMDQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTEyODcsNiArMTI4Nyw3IEBAIHN0YXRpYyB2b2lk
IGFtZGdwdV90dG1fdHRfdW5wb3B1bGF0ZShzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldiwKIAlp
ZiAoZ3R0ICYmIGd0dC0+dXNlcnB0cikgewogCQlhbWRncHVfdHRtX3R0X3NldF91c2VyX3BhZ2Vz
KHR0bSwgTlVMTCk7CiAJCWtmcmVlKHR0bS0+c2cpOworCQl0dG0tPnNnID0gTlVMTDsKIAkJdHRt
LT5wYWdlX2ZsYWdzICY9IH5UVE1fUEFHRV9GTEFHX1NHOwogCQlyZXR1cm47CiAJfQotLSAKMi4z
MC4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
