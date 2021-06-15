Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004DAC48BE8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 15:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C151661879
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 15:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C151661879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F1B6E3D8;
	Tue, 15 Jun 2021 15:49:01 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8D98994A;
 Tue, 15 Jun 2021 15:49:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C32496162A;
 Tue, 15 Jun 2021 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623772140;
 bh=dH7xJQayrZBIPMfOJf6UdvY+v0w6s/jfGmwldd66918=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fMGe0Yvl0wEH8qas1aBqPugO6rxd8yjXx7rR9mY0MlpONUq9uC8IDdFqnE7ZXle2Q
 j0nv9JJdcYek2QvsvjQKP24BDjq4C0gXmIaChNucV2O3cLG9ntCg2zgJ5mvp7BRnVd
 ZxL4D2f6IQAgMxJEt2PYknp5pPq9rVBpz1w44ffTZ3w8LJzTCO8xMMB4mdPPqnviYX
 fM+gyi5Bubx1i2e23pWmH3WrnhChcztWaaVjGOlBn3Yzo+7C2J8NTYsK6MC99TkUHJ
 93pssYfbCbWU8FywMbTNDxk3Wyv0MyflxsGM96xqwuDLK4dhSGd2M/cXq35mdVNQn8
 d9Cw67yJMIXZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 28/33] radeon: use memcpy_to/fromio for UVD fw
 upload
Date: Tue, 15 Jun 2021 11:48:19 -0400
Message-Id: <20210615154824.62044-28-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615154824.62044-1-sashal@kernel.org>
References: <20210615154824.62044-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Chen Li <chenli@uniontech.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQ2hlbiBMaSA8Y2hlbmxpQHVuaW9udGVjaC5jb20+CgpbIFVwc3RyZWFtIGNvbW1pdCBh
YjgzNjNkMzg3NWE4M2Y0OTAxZWIxY2MwMGNlOGFmZDI0ZGU2Yzg1IF0KCkkgbWV0IGEgZ3B1IGFk
ZHIgYnVnIHJlY2VudGx5IGFuZCB0aGUga2VybmVsIGxvZwp0ZWxscyBtZSB0aGUgcGMgaXMgbWVt
Y3B5L21lbXNldCBhbmQgbGluayByZWdpc3RlciBpcwpyYWRlb25fdXZkX3Jlc3VtZS4KCkFzIHdl
IGtub3csIGluIHNvbWUgYXJjaGl0ZWN0dXJlcywgb3B0aW1pemVkIG1lbWNweS9tZW1zZXQKbWF5
IG5vdCB3b3JrIHdlbGwgb24gZGV2aWNlIG1lbW9yeS4gVHJpdmFsIG1lbWNweV90b2lvL21lbXNl
dF9pbwpjYW4gZml4IHRoaXMgcHJvYmxlbS4KCkJUVywgYW1kZ3B1IGhhcyBhbHJlYWR5IGRvbmUg
aXQgaW46CmNvbW1pdCBiYTBiMjI3NWE2NzggKCJkcm0vYW1kZ3B1OiB1c2UgbWVtY3B5X3RvL2Zy
b21pbyBmb3IgVVZEIGZ3IHVwbG9hZCIpLAp0aGF0J3Mgd2h5IGl0IGhhcyBubyB0aGlzIGlzc3Vl
IG9uIHRoZSBzYW1lIGdwdSBhbmQgcGxhdGZvcm0uCgpTaWduZWQtb2ZmLWJ5OiBDaGVuIExpIDxj
aGVubGlAdW5pb250ZWNoLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtl
cm5lbC5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMgfCA0ICsr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl91dmQuYwppbmRleCBkZmE5ZmRiZTk4ZGEuLjA2YmIyNGQ3YTlm
ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMKQEAgLTI4Niw3ICsyODYsNyBAQCBp
bnQgcmFkZW9uX3V2ZF9yZXN1bWUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCiAJaWYgKHJk
ZXYtPnV2ZC52Y3B1X2JvID09IE5VTEwpCiAJCXJldHVybiAtRUlOVkFMOwogCi0JbWVtY3B5KHJk
ZXYtPnV2ZC5jcHVfYWRkciwgcmRldi0+dXZkX2Z3LT5kYXRhLCByZGV2LT51dmRfZnctPnNpemUp
OworCW1lbWNweV90b2lvKCh2b2lkIF9faW9tZW0gKilyZGV2LT51dmQuY3B1X2FkZHIsIHJkZXYt
PnV2ZF9mdy0+ZGF0YSwgcmRldi0+dXZkX2Z3LT5zaXplKTsKIAogCXNpemUgPSByYWRlb25fYm9f
c2l6ZShyZGV2LT51dmQudmNwdV9ibyk7CiAJc2l6ZSAtPSByZGV2LT51dmRfZnctPnNpemU7CkBA
IC0yOTQsNyArMjk0LDcgQEAgaW50IHJhZGVvbl91dmRfcmVzdW1lKHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2KQogCXB0ciA9IHJkZXYtPnV2ZC5jcHVfYWRkcjsKIAlwdHIgKz0gcmRldi0+dXZk
X2Z3LT5zaXplOwogCi0JbWVtc2V0KHB0ciwgMCwgc2l6ZSk7CisJbWVtc2V0X2lvKCh2b2lkIF9f
aW9tZW0gKilwdHIsIDAsIHNpemUpOwogCiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjMwLjIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
