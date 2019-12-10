Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1C8C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F51208C3
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEOY8vLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F51208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B826E98A;
	Tue, 10 Dec 2019 21:32:30 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE166E991;
 Tue, 10 Dec 2019 21:32:28 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DA08A21556;
 Tue, 10 Dec 2019 21:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576013548;
 bh=rnAF06ciDbzbqruYIqLqTiLgbm5Tt/iFKd+qYBb1bHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pEOY8vLbeXgtzELfETrcZzO6FzgqXaoL8rF6yS2bbvupOPC2CQRwlr27EFrVJqmz+
 TjGD1KY+UNb9o58Y777yFNqrnhJlL+kOCLR4sZU3iBly1TuLkPcNlP4QGUg45mkuQv
 5e5ozPgyR7RMqyKm/La/qVdStd/U0X2PfAm4108c=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 005/177] drm/amdgpu: grab the id mgr lock while
 accessing passid_mapping
Date: Tue, 10 Dec 2019 16:29:29 -0500
Message-Id: <20191210213221.11921-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Chunming Zhou <david1.zhou@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKWyBVcHN0
cmVhbSBjb21taXQgNjgxN2JmMjgzYjJiODUxMDk1ODI1ZWM3ZjBlOWYxMDM5OGUwOTEyNSBdCgpO
ZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IHdlIGFjdHVhbGx5IGRyb3BwaW5nIHRoZSByaWdodCBmZW5j
ZS4KQ291bGQgYmUgZG9uZSB3aXRoIFJDVSBhcyB3ZWxsLCBidXQgdG8gY29tcGxpY2F0ZWQgZm9y
IGEgZml4LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNv
bT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAxMiArKysrKysrKystLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwppbmRleCA0OWZlNTA4NGM1M2RkLi42OWZiOTBkOWM0
ODU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtNzAwLDEwICs3
MDAsOCBAQCBpbnQgYW1kZ3B1X3ZtX2ZsdXNoKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgc3Ry
dWN0IGFtZGdwdV9qb2IgKmpvYiwgYm9vbCBuZWVkXwogCQlpZC0+b2FfYmFzZSAhPSBqb2ItPm9h
X2Jhc2UgfHwKIAkJaWQtPm9hX3NpemUgIT0gam9iLT5vYV9zaXplKTsKIAlib29sIHZtX2ZsdXNo
X25lZWRlZCA9IGpvYi0+dm1fbmVlZHNfZmx1c2g7Ci0JYm9vbCBwYXNpZF9tYXBwaW5nX25lZWRl
ZCA9IGlkLT5wYXNpZCAhPSBqb2ItPnBhc2lkIHx8Ci0JCSFpZC0+cGFzaWRfbWFwcGluZyB8fAot
CQkhZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGlkLT5wYXNpZF9tYXBwaW5nKTsKIAlzdHJ1Y3QgZG1h
X2ZlbmNlICpmZW5jZSA9IE5VTEw7CisJYm9vbCBwYXNpZF9tYXBwaW5nX25lZWRlZDsKIAl1bnNp
Z25lZCBwYXRjaF9vZmZzZXQgPSAwOwogCWludCByOwogCkBAIC03MTMsNiArNzExLDEyIEBAIGlu
dCBhbWRncHVfdm1fZmx1c2goc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBzdHJ1Y3QgYW1kZ3B1
X2pvYiAqam9iLCBib29sIG5lZWRfCiAJCXBhc2lkX21hcHBpbmdfbmVlZGVkID0gdHJ1ZTsKIAl9
CiAKKwltdXRleF9sb2NrKCZpZF9tZ3ItPmxvY2spOworCWlmIChpZC0+cGFzaWQgIT0gam9iLT5w
YXNpZCB8fCAhaWQtPnBhc2lkX21hcHBpbmcgfHwKKwkgICAgIWRtYV9mZW5jZV9pc19zaWduYWxl
ZChpZC0+cGFzaWRfbWFwcGluZykpCisJCXBhc2lkX21hcHBpbmdfbmVlZGVkID0gdHJ1ZTsKKwlt
dXRleF91bmxvY2soJmlkX21nci0+bG9jayk7CisKIAlnZHNfc3dpdGNoX25lZWRlZCAmPSAhIXJp
bmctPmZ1bmNzLT5lbWl0X2dkc19zd2l0Y2g7CiAJdm1fZmx1c2hfbmVlZGVkICY9ICEhcmluZy0+
ZnVuY3MtPmVtaXRfdm1fZmx1c2ggICYmCiAJCQlqb2ItPnZtX3BkX2FkZHIgIT0gQU1ER1BVX0JP
X0lOVkFMSURfT0ZGU0VUOwpAQCAtNzUyLDkgKzc1NiwxMSBAQCBpbnQgYW1kZ3B1X3ZtX2ZsdXNo
KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgc3RydWN0IGFtZGdwdV9qb2IgKmpvYiwgYm9vbCBu
ZWVkXwogCX0KIAogCWlmIChwYXNpZF9tYXBwaW5nX25lZWRlZCkgeworCQltdXRleF9sb2NrKCZp
ZF9tZ3ItPmxvY2spOwogCQlpZC0+cGFzaWQgPSBqb2ItPnBhc2lkOwogCQlkbWFfZmVuY2VfcHV0
KGlkLT5wYXNpZF9tYXBwaW5nKTsKIAkJaWQtPnBhc2lkX21hcHBpbmcgPSBkbWFfZmVuY2VfZ2V0
KGZlbmNlKTsKKwkJbXV0ZXhfdW5sb2NrKCZpZF9tZ3ItPmxvY2spOwogCX0KIAlkbWFfZmVuY2Vf
cHV0KGZlbmNlKTsKIAotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
