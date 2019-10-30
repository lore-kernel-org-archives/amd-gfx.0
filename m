Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9032BCA9EC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 15:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6019520856
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 15:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6019520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213EC6EA75;
	Wed, 30 Oct 2019 15:53:35 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192FE6EA75;
 Wed, 30 Oct 2019 15:53:33 +0000 (UTC)
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5525720856;
 Wed, 30 Oct 2019 15:53:31 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 56/81] drm/amdgpu: fix error handling in
 amdgpu_bo_list_create
Date: Wed, 30 Oct 2019 11:49:02 -0400
Message-Id: <20191030154928.9432-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1572450813;
 bh=IkLYQnzfqnzRQFMu1Zr8xUgXTKtuTIZGZVf8nzghm+s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WLrBLXGb66JqaW0wDYGVPPuUQQiboUXNoGUfMnkgL0kDSs4tPhV6UeBUdv1GArGbz
 mZ9Mx078Vva6axP9FYXooNjKxW8AqBty11+PnEmXTNUD0Gj79x1MYBq/FGlMTU9rjO
 NPX+TGJin1Wqj+FPMihjw3VepWP15BuYwg3pLZ68=
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
Cc: Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030154902.1jCX2lpAhT4JbpE2x7YI-S6ZYyJ6mJAFNIv8RqD_qJQ@z>

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKWyBVcHN0
cmVhbSBjb21taXQgZGU1MWE1MDE5ZmYzMjk2MDIxOGRhOGZkODk5ZmEzZjM2MWIwMzFlOSBdCgpX
ZSBuZWVkIHRvIGRyb3Agbm9ybWFsIGFuZCB1c2VycHRyIEJPcyBzZXBhcmF0ZWx5LgoKU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpBY2tl
ZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBM
ZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2JvX2xpc3QuYyB8IDcgKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9ib19saXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Ym9fbGlzdC5jCmluZGV4IDdiY2Y4NmM2MTk5OTUuLmQ0YzQ3ODVhYjUyNTYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYwpAQCAtMTQwLDcgKzE0MCwxMiBA
QCBpbnQgYW1kZ3B1X2JvX2xpc3RfY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBz
dHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsCiAJcmV0dXJuIDA7CiAKIGVycm9yX2ZyZWU6Ci0Jd2hpbGUg
KGktLSkgeworCWZvciAoaSA9IDA7IGkgPCBsYXN0X2VudHJ5OyArK2kpIHsKKwkJc3RydWN0IGFt
ZGdwdV9ibyAqYm8gPSB0dG1fdG9fYW1kZ3B1X2JvKGFycmF5W2ldLnR2LmJvKTsKKworCQlhbWRn
cHVfYm9fdW5yZWYoJmJvKTsKKwl9CisJZm9yIChpID0gZmlyc3RfdXNlcnB0cjsgaSA8IG51bV9l
bnRyaWVzOyArK2kpIHsKIAkJc3RydWN0IGFtZGdwdV9ibyAqYm8gPSB0dG1fdG9fYW1kZ3B1X2Jv
KGFycmF5W2ldLnR2LmJvKTsKIAogCQlhbWRncHVfYm9fdW5yZWYoJmJvKTsKLS0gCjIuMjAuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
