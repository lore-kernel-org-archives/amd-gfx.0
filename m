Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD5C43469
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 14:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A0323718
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 14:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPkIsHYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A0323718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926876E397;
	Mon, 21 Sep 2020 14:40:48 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DC46E397;
 Mon, 21 Sep 2020 14:40:47 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 56D0B2220C;
 Mon, 21 Sep 2020 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600699247;
 bh=Y6JoQtbzzygBA+PtwLLeftoDBuRRRju8FF5/VAidqUU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mPkIsHYoZNeiPfKCDFOjrJTkP3qsr3PvEtYtBbl30n+wjNjUoCyE0Zyzkma54y6S1
 o7sYLU4MOlA3eqhkxyfOqU/EsKwszOyPMCorIAHbOB/O7nVfuFuKQ4k62+vD7+hlh8
 VGO9wGAEG2+rvEzgY1E5wU1WO5MULWyJJ3cf6DhA=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 15/20] drm/amdgpu/dc: Require primary plane to be
 enabled whenever the CRTC is
Date: Mon, 21 Sep 2020 10:40:22 -0400
Message-Id: <20200921144027.2135390-15-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921144027.2135390-1-sashal@kernel.org>
References: <20200921144027.2135390-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTWljaGVsIETDpG56ZXIgPG1kYWVuemVyQHJlZGhhdC5jb20+CgpbIFVwc3RyZWFtIGNv
bW1pdCAyZjIyOGFhYjIxYmJjNzRlOTBlMjY3YTcyMTIxNWVjOGJlNTFkYWY3IF0KCkRvbid0IGNo
ZWNrIGRybV9jcnRjX3N0YXRlOjphY3RpdmUgZm9yIHRoaXMgZWl0aGVyLCBwZXIgaXRzCmRvY3Vt
ZW50YXRpb24gaW4gaW5jbHVkZS9kcm0vZHJtX2NydGMuaDoKCiAqIEhlbmNlIGRyaXZlcnMgbXVz
dCBub3QgY29uc3VsdCBAYWN0aXZlIGluIHRoZWlyIHZhcmlvdXMKICogJmRybV9tb2RlX2NvbmZp
Z19mdW5jcy5hdG9taWNfY2hlY2sgY2FsbGJhY2sgdG8gcmVqZWN0IGFuIGF0b21pYwogKiBjb21t
aXQuCgphdG9taWNfcmVtb3ZlX2ZiIGRpc2FibGVzIHRoZSBDUlRDIGFzIG5lZWRlZCBmb3IgZGlz
YWJsaW5nIHRoZSBwcmltYXJ5CnBsYW5lLgoKVGhpcyBwcmV2ZW50cyBhdCBsZWFzdCB0aGUgZm9s
bG93aW5nIHByb2JsZW1zIGlmIHRoZSBwcmltYXJ5IHBsYW5lIGdldHMKZGlzYWJsZWQgKGUuZy4g
ZHVlIHRvIGRlc3Ryb3lpbmcgdGhlIEZCIGFzc2lnbmVkIHRvIHRoZSBwcmltYXJ5IHBsYW5lLAph
cyBoYXBwZW5zIGUuZy4gd2l0aCBtdXR0ZXIgaW4gV2F5bGFuZCBtb2RlKToKCiogVGhlIGxlZ2Fj
eSBjdXJzb3IgaW9jdGwgcmV0dXJuZWQgRUlOVkFMIGZvciBhIG5vbi0wIGN1cnNvciBGQiBJRAog
ICh3aGljaCBlbmFibGVzIHRoZSBjdXJzb3IgcGxhbmUpLgoqIElmIHRoZSBjdXJzb3IgcGxhbmUg
d2FzIGVuYWJsZWQsIGNoYW5naW5nIHRoZSBsZWdhY3kgRFBNUyBwcm9wZXJ0eQogIHZhbHVlIGZy
b20gb2ZmIHRvIG9uIHJldHVybmVkIEVJTlZBTC4KCnYyOgoqIE1pbm9yIGNoYW5nZXMgdG8gY29k
ZSBjb21tZW50IGFuZCBjb21taXQgbG9nLCBwZXIgcmV2aWV3IGZlZWRiYWNrLgoKR2l0TGFiOiBo
dHRwczovL2dpdGxhYi5nbm9tZS5vcmcvR05PTUUvbXV0dGVyLy0vaXNzdWVzLzExMDgKR2l0TGFi
OiBodHRwczovL2dpdGxhYi5nbm9tZS5vcmcvR05PTUUvbXV0dGVyLy0vaXNzdWVzLzExNjUKR2l0
TGFiOiBodHRwczovL2dpdGxhYi5nbm9tZS5vcmcvR05PTUUvbXV0dGVyLy0vaXNzdWVzLzEzNDQK
U3VnZ2VzdGVkLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGZmd2xsLmNoPgpBY2tl
ZC1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KUmV2aWV3ZWQtYnk6
IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4KU2lnbmVk
LW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1kYWVuemVyQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVkLW9mZi1i
eTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIC4uLi9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDMyICsrKysrKy0tLS0tLS0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwppbmRleCAz
ZjdlY2VkOTJjMGM4Li43YzFjYzBiYTMwYTU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTUyNTcsMTkgKzUyNTcsNiBAQCBz
dGF0aWMgdm9pZCBkbV9jcnRjX2hlbHBlcl9kaXNhYmxlKHN0cnVjdCBkcm1fY3J0YyAqY3J0YykK
IHsKIH0KIAotc3RhdGljIGJvb2wgZG9lc19jcnRjX2hhdmVfYWN0aXZlX2N1cnNvcihzdHJ1Y3Qg
ZHJtX2NydGNfc3RhdGUgKm5ld19jcnRjX3N0YXRlKQotewotCXN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYgPSBuZXdfY3J0Y19zdGF0ZS0+Y3J0Yy0+ZGV2OwotCXN0cnVjdCBkcm1fcGxhbmUgKnBsYW5l
OwotCi0JZHJtX2Zvcl9lYWNoX3BsYW5lX21hc2socGxhbmUsIGRldiwgbmV3X2NydGNfc3RhdGUt
PnBsYW5lX21hc2spIHsKLQkJaWYgKHBsYW5lLT50eXBlID09IERSTV9QTEFORV9UWVBFX0NVUlNP
UikKLQkJCXJldHVybiB0cnVlOwotCX0KLQotCXJldHVybiBmYWxzZTsKLX0KLQogc3RhdGljIGlu
dCBjb3VudF9jcnRjX2FjdGl2ZV9wbGFuZXMoc3RydWN0IGRybV9jcnRjX3N0YXRlICpuZXdfY3J0
Y19zdGF0ZSkKIHsKIAlzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUgPSBuZXdfY3J0Y19z
dGF0ZS0+c3RhdGU7CkBAIC01MzQ5LDE5ICs1MzM2LDIwIEBAIHN0YXRpYyBpbnQgZG1fY3J0Y19o
ZWxwZXJfYXRvbWljX2NoZWNrKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywKIAkJcmV0dXJuIHJldDsK
IAl9CiAKLQkvKiBJbiBzb21lIHVzZSBjYXNlcywgbGlrZSByZXNldCwgbm8gc3RyZWFtIGlzIGF0
dGFjaGVkICovCi0JaWYgKCFkbV9jcnRjX3N0YXRlLT5zdHJlYW0pCi0JCXJldHVybiAwOwotCiAJ
LyoKLQkgKiBXZSB3YW50IGF0IGxlYXN0IG9uZSBoYXJkd2FyZSBwbGFuZSBlbmFibGVkIHRvIHVz
ZQotCSAqIHRoZSBzdHJlYW0gd2l0aCBhIGN1cnNvciBlbmFibGVkLgorCSAqIFdlIHJlcXVpcmUg
dGhlIHByaW1hcnkgcGxhbmUgdG8gYmUgZW5hYmxlZCB3aGVuZXZlciB0aGUgQ1JUQyBpcywgb3Ro
ZXJ3aXNlCisJICogZHJtX21vZGVfY3Vyc29yX3VuaXZlcnNhbCBtYXkgZW5kIHVwIHRyeWluZyB0
byBlbmFibGUgdGhlIGN1cnNvciBwbGFuZSB3aGlsZSBhbGwgb3RoZXIKKwkgKiBwbGFuZXMgYXJl
IGRpc2FibGVkLCB3aGljaCBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBoYXJkd2FyZS4gQW5kIHRo
ZXJlIGlzIGxlZ2FjeQorCSAqIHVzZXJzcGFjZSB3aGljaCBzdG9wcyB1c2luZyB0aGUgSFcgY3Vy
c29yIGFsdG9nZXRoZXIgaW4gcmVzcG9uc2UgdG8gdGhlIHJlc3VsdGluZyBFSU5WQUwuCiAJICov
Ci0JaWYgKHN0YXRlLT5lbmFibGUgJiYgc3RhdGUtPmFjdGl2ZSAmJgotCSAgICBkb2VzX2NydGNf
aGF2ZV9hY3RpdmVfY3Vyc29yKHN0YXRlKSAmJgotCSAgICBkbV9jcnRjX3N0YXRlLT5hY3RpdmVf
cGxhbmVzID09IDApCisJaWYgKHN0YXRlLT5lbmFibGUgJiYKKwkgICAgIShzdGF0ZS0+cGxhbmVf
bWFzayAmIGRybV9wbGFuZV9tYXNrKGNydGMtPnByaW1hcnkpKSkKIAkJcmV0dXJuIC1FSU5WQUw7
CiAKKwkvKiBJbiBzb21lIHVzZSBjYXNlcywgbGlrZSByZXNldCwgbm8gc3RyZWFtIGlzIGF0dGFj
aGVkICovCisJaWYgKCFkbV9jcnRjX3N0YXRlLT5zdHJlYW0pCisJCXJldHVybiAwOworCiAJaWYg
KGRjX3ZhbGlkYXRlX3N0cmVhbShkYywgZG1fY3J0Y19zdGF0ZS0+c3RyZWFtKSA9PSBEQ19PSykK
IAkJcmV0dXJuIDA7CiAKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
