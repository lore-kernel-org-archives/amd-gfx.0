Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB505C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 18:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3695761936
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 18:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3695761936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mengyan1223.wang
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3ECE6E49D;
	Mon, 29 Mar 2021 18:01:12 +0000 (UTC)
X-Greylist: delayed 350 seconds by postgrey-1.36 at gabe;
 Mon, 29 Mar 2021 18:00:53 UTC
Received: from mengyan1223.wang (mengyan1223.wang [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593466E49D;
 Mon, 29 Mar 2021 18:00:53 +0000 (UTC)
Received: from xry111-X57S1.. (unknown
 [IPv6:240e:35a:1037:8a00:70b2:e35d:833c:af3e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (Client did not present a certificate)
 (Authenticated sender: xry111@mengyan1223.wang)
 by mengyan1223.wang (Postfix) with ESMTPSA id 27C1965B2D;
 Mon, 29 Mar 2021 13:54:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
 s=mail; t=1617040502;
 bh=Zbib90WcD3Bj0OIpXKzlZugk4FNdHitNgQA0jv+MLiU=;
 h=From:To:Cc:Subject:Date:From;
 b=RU+YMOzQvm+gW5FvX3GXZLNVPhBUjDloPV82MoeNw7oievKXs/gIQiWpL5SBftjTW
 d80gOOr+DddPwloNLOzXp0GCnIqS4W/QbxFmYxRJ4hxQM4kiLJuUw2EePkXE0aVs/Y
 uBoJIXzvqR/4zCsmk6uTiAuRooaRityvTiWnlpgtq/jHPAHy1TjtfggLtue9OQWuuN
 4IWWrENjuf1vXeIibEui8gWSZqNaGpIDucg85Hg+Ngyb2oNEdeff6GEQAt5NIz0QZC
 1i2W4g7bEOK+b6d3v+3RGHoKP6ez8+NS8SJVCp+1AiooXOScYkg3zc2OQk3yA+piYk
 ReaBEHE9AvPfQ==
From: =?UTF-8?q?X=E2=84=B9=20Ruoyao?= <xry111@mengyan1223.wang>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix an underflow on non-4KB-page systems
Date: Tue, 30 Mar 2021 01:53:48 +0800
Message-Id: <20210329175348.26859-1-xry111@mengyan1223.wang>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Mar 2021 18:01:11 +0000
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
Cc: David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org,
 =?UTF-8?q?X=E2=84=B9=20Ruoyao?= <xry111@mengyan1223.wang>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SWYgdGhlIGluaXRpYWwgdmFsdWUgb2YgYG51bV9lbnRpcmVzYCAoY2FsY3VsYXRlZCBhdCBsaW5l
IDE2NTQpIGlzIG5vdAphbiBpbnRlZ3JhbCBtdWx0aXBsZSBvZiBgQU1ER1BVX0dQVV9QQUdFU19J
Tl9DUFVfUEFHRWAsIGluIGxpbmUgMTY4MSBhCnZhbHVlIGdyZWF0ZXIgdGhhbiB0aGUgaW5pdGlh
bCB2YWx1ZSB3aWxsIGJlIGFzc2lnbmVkIHRvIGl0LiAgVGhhdCBjYXVzZXMKYHN0YXJ0ID4gbGFz
dCArIDFgIGFmdGVyIGxpbmUgMTcwOC4gIFRoZW4gaW4gdGhlIG5leHQgaXRlcmF0aW9uIGFuCnVu
ZGVyZmxvdyBoYXBwZW5zIGF0IGxpbmUgMTY1NC4gIEl0IGNhdXNlcyBtZXNzYWdlCgogICAgKkVS
Uk9SKiBDb3VsZG4ndCB1cGRhdGUgQk9fVkEgKC0xMikKCnByaW50ZWQgaW4ga2VybmVsIGxvZywg
YW5kIEdQVSBoYW5naW5nLgoKRm9ydGlmeSB0aGUgY3JpdGVyaWEgb2YgdGhlIGxvb3AgdG8gZml4
IHRoaXMgaXNzdWUuCgpCdWdMaW5rOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJt
L2FtZC8tL2lzc3Vlcy8xNTQ5CkZpeGVzOiBhMzlmMmE4ZDcwNjYgKCJkcm0vYW1kZ3B1OiBudWtl
IGFtZGdwdV92bV9ib19zcGxpdF9tYXBwaW5nIHYyIikKUmVwb3J0ZWQtYnk6IFhpIFJ1b3lhbyA8
eHJ5MTExQG1lbmd5YW4xMjIzLndhbmc+ClJlcG9ydGVkLWJ5OiBEYW4gSG9yw6FrIDxkYW5AZGFu
bnkuY3o+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IFhpIFJ1b3lh
byA8eHJ5MTExQG1lbmd5YW4xMjIzLndhbmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IGFk
OTFjMGMzYzQyMy4uY2VlMGNjOWM4MDg1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYwpAQCAtMTcwNyw3ICsxNzA3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBk
YXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCX0KIAkJc3RhcnQgPSB0
bXA7CiAKLQl9IHdoaWxlICh1bmxpa2VseShzdGFydCAhPSBsYXN0ICsgMSkpOworCX0gd2hpbGUg
KHVubGlrZWx5KHN0YXJ0IDwgbGFzdCArIDEpKTsKIAogCXIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5j
b21taXQoJnBhcmFtcywgZmVuY2UpOwogCgpiYXNlLWNvbW1pdDogYTVlMTNjNmRmMGU0MTcwMmQy
YjJjNzdjOGFkNDE2NzdlYmIwNjViMwotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
