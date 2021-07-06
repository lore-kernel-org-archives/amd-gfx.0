Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414AC07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483E961E3A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483E961E3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6DDA6E416;
	Tue,  6 Jul 2021 11:23:42 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1956E413;
 Tue,  6 Jul 2021 11:23:41 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03F3361D3F;
 Tue,  6 Jul 2021 11:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570621;
 bh=QY8pEEkS5Zjx/I8JGlZYIXkWO2XqkalzvJBoNKtlX48=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ru05MAC4BUgKv/NrDpf6c5dCDlzAso0tupwoAWgpi3xL2sBKIIRVfKgAQEGHkP2Cm
 a9V1JzUCWyBrFA/eLZ477TpFJbJBqbcrpEjntKJFg73AGlmxsbgddIgHhVNFXppYId
 AK+6GW2xxIClUXDW0Lxx+hPIXjU6XEUkHtgQV22poCe/Z75rjxhfY6wN4axdeI4oq3
 um6hKLVvgLh04aHEXFv1txNRfaTc2eg4GQXI5vdGGbetq2bNIlatD3zSZ5ehRjylP0
 hjQrYOmReDjedlddfbeQGfS7QWyb+1pK468PWpzEOMuqShopfnfn6cq2NyPiaGEdxL
 +C35xBb7ATeFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 075/137] drm/amdkfd: use allowed domain for vmbo
 validation
Date: Tue,  6 Jul 2021 07:21:01 -0400
Message-Id: <20210706112203.2062605-75-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112203.2062605-1-sashal@kernel.org>
References: <20210706112203.2062605-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Nirmoy Das <nirmoy.das@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgoKWyBVcHN0cmVhbSBjb21taXQg
YmMwNTcxNmQ0ZmRkMDY1MDEzNjMzNjAyYzU5NjBhMmJmMTUxMWI5YyBdCgpGaXhlcyBoYW5kbGlu
ZyB3aGVuIHBhZ2UgdGFibGVzIGFyZSBpbiBzeXN0ZW0gbWVtb3J5LgoKdjM6IHJlbW92ZSBzdHJ1
Y3QgYW1kZ3B1X3ZtX3BhcnNlci4KdjI6IHJlbW92ZSB1bndhbnRlZCB2YXJpYWJsZS4KICAgIGNo
YW5nZSBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlIGluc3RlYWQgb2YgYW1kZ3B1X2FtZGtmZF9ib192
YWxpZGF0ZS4KClNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4K
UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
UmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25l
ZC1vZmYtYnk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4KLS0tCiAuLi4vZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyAgfCAyMSArKysrLS0tLS0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKaW5k
ZXggNWRhNDg3YjY0YTY2Li4yNmY4YTIxMzgzNzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKQEAgLTQ4LDEyICs0OCw2IEBAIHN0YXRp
YyBzdHJ1Y3QgewogCXNwaW5sb2NrX3QgbWVtX2xpbWl0X2xvY2s7CiB9IGtmZF9tZW1fbGltaXQ7
CiAKLS8qIFN0cnVjdCB1c2VkIGZvciBhbWRncHVfYW1ka2ZkX2JvX3ZhbGlkYXRlICovCi1zdHJ1
Y3QgYW1kZ3B1X3ZtX3BhcnNlciB7Ci0JdWludDMyX3QgICAgICAgIGRvbWFpbjsKLQlib29sICAg
ICAgICAgICAgd2FpdDsKLX07Ci0KIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgZG9tYWluX2Jp
dF90b19zdHJpbmdbXSA9IHsKIAkJIkNQVSIsCiAJCSJHVFQiLApAQCAtMzM3LDExICszMzEsOSBA
QCBzdGF0aWMgaW50IGFtZGdwdV9hbWRrZmRfYm9fdmFsaWRhdGUoc3RydWN0IGFtZGdwdV9ibyAq
Ym8sIHVpbnQzMl90IGRvbWFpbiwKIAlyZXR1cm4gcmV0OwogfQogCi1zdGF0aWMgaW50IGFtZGdw
dV9hbWRrZmRfdmFsaWRhdGUodm9pZCAqcGFyYW0sIHN0cnVjdCBhbWRncHVfYm8gKmJvKQorc3Rh
dGljIGludCBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlX3ZtX2JvKHZvaWQgKl91bnVzZWQsIHN0cnVj
dCBhbWRncHVfYm8gKmJvKQogewotCXN0cnVjdCBhbWRncHVfdm1fcGFyc2VyICpwID0gcGFyYW07
Ci0KLQlyZXR1cm4gYW1kZ3B1X2FtZGtmZF9ib192YWxpZGF0ZShibywgcC0+ZG9tYWluLCBwLT53
YWl0KTsKKwlyZXR1cm4gYW1kZ3B1X2FtZGtmZF9ib192YWxpZGF0ZShibywgYm8tPmFsbG93ZWRf
ZG9tYWlucywgZmFsc2UpOwogfQogCiAvKiB2bV92YWxpZGF0ZV9wdF9wZF9ib3MgLSBWYWxpZGF0
ZSBwYWdlIHRhYmxlIGFuZCBkaXJlY3RvcnkgQk9zCkBAIC0zNTUsMjAgKzM0NywxNSBAQCBzdGF0
aWMgaW50IHZtX3ZhbGlkYXRlX3B0X3BkX2JvcyhzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkKIHsKIAlz
dHJ1Y3QgYW1kZ3B1X2JvICpwZCA9IHZtLT5yb290LmJhc2UuYm87CiAJc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYocGQtPnRiby5iZGV2KTsKLQlzdHJ1Y3QgYW1k
Z3B1X3ZtX3BhcnNlciBwYXJhbTsKIAlpbnQgcmV0OwogCi0JcGFyYW0uZG9tYWluID0gQU1ER1BV
X0dFTV9ET01BSU5fVlJBTTsKLQlwYXJhbS53YWl0ID0gZmFsc2U7Ci0KLQlyZXQgPSBhbWRncHVf
dm1fdmFsaWRhdGVfcHRfYm9zKGFkZXYsIHZtLCBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlLAotCQkJ
CQkmcGFyYW0pOworCXJldCA9IGFtZGdwdV92bV92YWxpZGF0ZV9wdF9ib3MoYWRldiwgdm0sIGFt
ZGdwdV9hbWRrZmRfdmFsaWRhdGVfdm1fYm8sIE5VTEwpOwogCWlmIChyZXQpIHsKIAkJcHJfZXJy
KCJmYWlsZWQgdG8gdmFsaWRhdGUgUFQgQk9zXG4iKTsKIAkJcmV0dXJuIHJldDsKIAl9CiAKLQly
ZXQgPSBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlKCZwYXJhbSwgcGQpOworCXJldCA9IGFtZGdwdV9h
bWRrZmRfdmFsaWRhdGVfdm1fYm8oTlVMTCwgcGQpOwogCWlmIChyZXQpIHsKIAkJcHJfZXJyKCJm
YWlsZWQgdG8gdmFsaWRhdGUgUERcbiIpOwogCQlyZXR1cm4gcmV0OwotLSAKMi4zMC4yCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
