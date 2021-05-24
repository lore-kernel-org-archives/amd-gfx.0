Return-Path: <SRS0=Iydh=KT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4BDC47088
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 14:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFECD61407
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 14:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFECD61407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9A16E854;
	Mon, 24 May 2021 14:47:35 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3056E850;
 Mon, 24 May 2021 14:47:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5DFD613F3;
 Mon, 24 May 2021 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621867654;
 bh=sF/LgMQrUi3z4U4HKIyteDD4Zwlh0WG77H/iii+lxyg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P7NVI2S4j9aY+RVZSBuEvuGePOPQx4OXbPLHPWSANw+ePI6FGW0WfIoqgJQTtN2EF
 kv37JjP/OMYYTt0djipB83LkUoyOwPOsxWyD1+FRf4tQ1Efl8yD0QEQhsOgywIgtS7
 svDfe+Hvm1+tWAM8gEZIpeNBKbEt6LzOUNj+4fVV+CHjdasN7wrlAXtdv/XVLpQcIE
 cxkuPdF87y/SN8t9j54u1sq57sOn936v68ZY8hUtVsPIdgtnnVam0RU9uqL0ckmCiv
 sEApmS5l3rF+j0DQ7JxKpOgic/cEyh6y68ZVUCIrjWJ+7OyLWMisk21VO7W3XH9XR3
 uzEIs9v+1q5Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 57/63] drm/amd/amdgpu: fix refcount leak
Date: Mon, 24 May 2021 10:46:14 -0400
Message-Id: <20210524144620.2497249-57-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Jingwen Chen <Jingwen.Chen2@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSmluZ3dlbiBDaGVuIDxKaW5nd2VuLkNoZW4yQGFtZC5jb20+CgpbIFVwc3RyZWFtIGNv
bW1pdCBmYTdlNmFiYzc1ZjNkNDkxYmM1NjE3MzQzMTJkMDY1ZGM5ZGMyYTc3IF0KCltXaHldCnRo
ZSBnZW0gb2JqZWN0IHJmYi0+YmFzZS5vYmpbMF0gaXMgZ2V0IGFjY29yZGluZyB0byBudW1fcGxh
bmVzCmluIGFtZGdwdWZiX2NyZWF0ZSwgYnV0IGlzIG5vdCBwdXQgYWNjb3JkaW5nIHRvIG51bV9w
bGFuZXMKCltIb3ddCnB1dCByZmItPmJhc2Uub2JqWzBdIGluIGFtZGdwdV9mYmRldl9kZXN0cm95
IGFjY29yZGluZyB0byBudW1fcGxhbmVzCgpTaWduZWQtb2ZmLWJ5OiBKaW5nd2VuIENoZW4gPEpp
bmd3ZW4uQ2hlbjJAYW1kLmNvbT4KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5v
cmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMgfCAzICsrKwog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ZiLmMKaW5kZXggMjQwMTBjYWNmN2QwLi44MTNiOTZlMjMzYmEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCkBAIC0yOTAsMTAgKzI5MCwxMyBAQCBzdGF0aWMg
aW50IGFtZGdwdWZiX2NyZWF0ZShzdHJ1Y3QgZHJtX2ZiX2hlbHBlciAqaGVscGVyLAogc3RhdGlj
IGludCBhbWRncHVfZmJkZXZfZGVzdHJveShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3Qg
YW1kZ3B1X2ZiZGV2ICpyZmJkZXYpCiB7CiAJc3RydWN0IGFtZGdwdV9mcmFtZWJ1ZmZlciAqcmZi
ID0gJnJmYmRldi0+cmZiOworCWludCBpOwogCiAJZHJtX2ZiX2hlbHBlcl91bnJlZ2lzdGVyX2Zi
aSgmcmZiZGV2LT5oZWxwZXIpOwogCiAJaWYgKHJmYi0+YmFzZS5vYmpbMF0pIHsKKwkJZm9yIChp
ID0gMDsgaSA8IHJmYi0+YmFzZS5mb3JtYXQtPm51bV9wbGFuZXM7IGkrKykKKwkJCWRybV9nZW1f
b2JqZWN0X3B1dChyZmItPmJhc2Uub2JqWzBdKTsKIAkJYW1kZ3B1ZmJfZGVzdHJveV9waW5uZWRf
b2JqZWN0KHJmYi0+YmFzZS5vYmpbMF0pOwogCQlyZmItPmJhc2Uub2JqWzBdID0gTlVMTDsKIAkJ
ZHJtX2ZyYW1lYnVmZmVyX3VucmVnaXN0ZXJfcHJpdmF0ZSgmcmZiLT5iYXNlKTsKLS0gCjIuMzAu
MgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
