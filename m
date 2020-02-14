Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2241C3B1A1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3692468D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y93NtHKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3692468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3A96F995;
	Fri, 14 Feb 2020 15:52:00 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8522B6F98E;
 Fri, 14 Feb 2020 15:51:57 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8EFE524689;
 Fri, 14 Feb 2020 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581695517;
 bh=qcz1N3Pxz32hez9lVmIpbu5HIiP8U/84EYKBiKmaBeI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=y93NtHKK+Y2v0+H/QhAz1REXHnP8reZk49hvuYdnfUmHrfR4DQXUunJLYPiyM2tcu
 mlyuM4RxulqvDIR7yojxXWnh3squIT+sG6i2BM/z/IJaAOBeFnh3SsHr5rHnVy8znh
 lEc4hUQY4qlsFh6QT208uBXjgmTJHlPYevI9eeR0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 140/542] drm/amdgpu: remove set but not used
 variable 'dig_connector'
Date: Fri, 14 Feb 2020 10:42:12 -0500
Message-Id: <20200214154854.6746-140-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, yu kuai <yukuai3@huawei.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogeXUga3VhaSA8eXVrdWFpM0BodWF3ZWkuY29tPgoKWyBVcHN0cmVhbSBjb21taXQgNWJl
YTdmZWRiN2ZlNGQ1ZTZkM2JhOWYzODVkZDM2MTlmYjAwNGNlNyBdCgpGaXhlcyBnY2MgJy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6Cgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hdG9tYmlvc19kcC5jOiBJbiBmdW5jdGlvbgrigJhhbWRncHVfYXRvbWJpb3NfZHBfZ2V0X3Bh
bmVsX21vZGXigJk6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2F0b21iaW9zX2RwLmM6MzY0
OjM2OiB3YXJuaW5nOiB2YXJpYWJsZQrigJhkaWdfY29ubmVjdG9y4oCZIHNldCBidXQgbm90IHVz
ZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpJdCBpcyBuZXZlciB1c2VkLCBzbyBjYW4g
YmUgcmVtb3ZlZC4KCkZpeGVzOiBkMzhjZWFmOTllZDAgKCJkcm0vYW1kZ3B1OiBhZGQgY29yZSBk
cml2ZXIgKHY0KSIpClNpZ25lZC1vZmYtYnk6IHl1IGt1YWkgPHl1a3VhaTNAaHVhd2VpLmNvbT4K
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpT
aWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZHAuYyB8IDMgLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hdG9tYmlvc19kcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZHAu
YwppbmRleCA2ODU4Y2RlOWZjNWQzLi45NDI2NTMwNmFiMTFmIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19kcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2F0b21iaW9zX2RwLmMKQEAgLTM2MSw3ICszNjEsNiBAQCBpbnQgYW1kZ3B1X2F0
b21iaW9zX2RwX2dldF9wYW5lbF9tb2RlKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwKIAkJ
CSAgICAgICBzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yKQogewogCXN0cnVjdCBhbWRn
cHVfY29ubmVjdG9yICphbWRncHVfY29ubmVjdG9yID0gdG9fYW1kZ3B1X2Nvbm5lY3Rvcihjb25u
ZWN0b3IpOwotCXN0cnVjdCBhbWRncHVfY29ubmVjdG9yX2F0b21fZGlnICpkaWdfY29ubmVjdG9y
OwogCWludCBwYW5lbF9tb2RlID0gRFBfUEFORUxfTU9ERV9FWFRFUk5BTF9EUF9NT0RFOwogCXUx
NiBkcF9icmlkZ2UgPSBhbWRncHVfY29ubmVjdG9yX2VuY29kZXJfZ2V0X2RwX2JyaWRnZV9lbmNv
ZGVyX2lkKGNvbm5lY3Rvcik7CiAJdTggdG1wOwpAQCAtMzY5LDggKzM2OCw2IEBAIGludCBhbWRn
cHVfYXRvbWJpb3NfZHBfZ2V0X3BhbmVsX21vZGUoc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVy
LAogCWlmICghYW1kZ3B1X2Nvbm5lY3Rvci0+Y29uX3ByaXYpCiAJCXJldHVybiBwYW5lbF9tb2Rl
OwogCi0JZGlnX2Nvbm5lY3RvciA9IGFtZGdwdV9jb25uZWN0b3ItPmNvbl9wcml2OwotCiAJaWYg
KGRwX2JyaWRnZSAhPSBFTkNPREVSX09CSkVDVF9JRF9OT05FKSB7CiAJCS8qIERQIGJyaWRnZSBj
aGlwcyAqLwogCQlpZiAoZHJtX2RwX2RwY2RfcmVhZGIoJmFtZGdwdV9jb25uZWN0b3ItPmRkY19i
dXMtPmF1eCwKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
