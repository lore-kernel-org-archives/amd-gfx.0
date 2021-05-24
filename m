Return-Path: <SRS0=Iydh=KT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044FFC47086
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 14:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C3661435
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 14:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C3661435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7066E865;
	Mon, 24 May 2021 14:48:57 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1794C6E85E;
 Mon, 24 May 2021 14:48:55 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18429613D6;
 Mon, 24 May 2021 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621867734;
 bh=GXf9vQ9Llq8n/FPuLeimMBqesTAk0Y2UMFFqTr2C6zU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KPrPHa7djU7RntuLtv+3o81r2aJoQNXCn9xFl8W/dFuQS0V1FUhJf8+rJanCKu25N
 Z8AbH8gC64UYs5kllbvxqhGslI084zFMUCoEeSzbtzJ8b7N4uhlDTgrJbJFrzxsMIm
 duIaVBP6XvrrOM4DGqnbPCXEKJFnVKzm7POS8oZB2B6r4al2tLVTlXJN0FIOjqBs8+
 QT+bN6H/6qbJBWmd8oyGAYsbuQbnrjvadAIYO/g1D4Rx4+WDtHLuHyTLy1ePBhyx3h
 1ZV4/T62UvDzirP0S1vbZb4p0CINilJySlrY3RZdHY7D1+aHRipf4XPNtUaQw4+K8Z
 USnaxvxF5FWzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 57/62] drm/amdgpu: Fix a use-after-free
Date: Mon, 24 May 2021 10:47:38 -0400
Message-Id: <20210524144744.2497894-57-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524144744.2497894-1-sashal@kernel.org>
References: <20210524144744.2497894-1-sashal@kernel.org>
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
dHRtLmMKaW5kZXggYWI3NzU1YTM4ODVhLi40NWFhNWZjYzIzYzggMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTEzODEsNiArMTM4MSw3IEBAIHN0YXRpYyB2b2lk
IGFtZGdwdV90dG1fdHRfdW5wb3B1bGF0ZShzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldiwgc3Ry
dWN0IHR0bV90dCAqCiAJaWYgKGd0dCAmJiBndHQtPnVzZXJwdHIpIHsKIAkJYW1kZ3B1X3R0bV90
dF9zZXRfdXNlcl9wYWdlcyh0dG0sIE5VTEwpOwogCQlrZnJlZSh0dG0tPnNnKTsKKwkJdHRtLT5z
ZyA9IE5VTEw7CiAJCXR0bS0+cGFnZV9mbGFncyAmPSB+VFRNX1BBR0VfRkxBR19TRzsKIAkJcmV0
dXJuOwogCX0KLS0gCjIuMzAuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
