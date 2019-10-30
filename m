Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D231ACA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 19:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806DA204FD
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 19:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806DA204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neil.mayhew.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8206EB42;
	Wed, 30 Oct 2019 19:09:02 +0000 (UTC)
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BFC6EB42
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 19:09:00 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
 by mslow2.mail.gandi.net (Postfix) with ESMTP id C5E1D3A936E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 18:59:11 +0000 (UTC)
X-Originating-IP: 184.64.35.96
Received: from gideon.cg.shawcable.net (S0106bc9b6808c827.cg.shawcable.net
 [184.64.35.96]) (Authenticated sender: neil@neil.mayhew.name)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7A2AD1BF204;
 Wed, 30 Oct 2019 18:58:47 +0000 (UTC)
From: neil@neil.mayhew.name
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Show resolution correctly in mode validation
 debug output
Date: Wed, 30 Oct 2019 12:58:37 -0600
Message-Id: <20191030185837.8766-1-neil@neil.mayhew.name>
X-Mailer: git-send-email 2.23.0
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
Cc: Neil Mayhew <neil@neil.mayhew.name>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030185837.9AutqIL4xMnp06F-r6GQ1yCc2mCO74lp3ubuN6Kfx3E@z>

RnJvbTogTmVpbCBNYXloZXcgPG5laWxAbmVpbC5tYXloZXcubmFtZT4KCi0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IGE1MmYwYjEzYTJj
OC4uZjgwMmM3ODRlNmY2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTQxMTQsOCArNDExNCw4IEBAIGVudW0gZHJtX21vZGVf
c3RhdHVzIGFtZGdwdV9kbV9jb25uZWN0b3JfbW9kZV92YWxpZChzdHJ1Y3QgZHJtX2Nvbm5lY3Rv
ciAqY29ubmVjCiAJCXJlc3VsdCA9IE1PREVfT0s7CiAJZWxzZQogCQlEUk1fREVCVUdfS01TKCJN
b2RlICVkeCVkIChjbGsgJWQpIGZhaWxlZCBEQyB2YWxpZGF0aW9uIHdpdGggZXJyb3IgJWRcbiIs
Ci0JCQkgICAgICBtb2RlLT52ZGlzcGxheSwKIAkJCSAgICAgIG1vZGUtPmhkaXNwbGF5LAorCQkJ
ICAgICAgbW9kZS0+dmRpc3BsYXksCiAJCQkgICAgICBtb2RlLT5jbG9jaywKIAkJCSAgICAgIGRj
X3Jlc3VsdCk7CiAKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
