Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F048AC3B1A5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C724824689
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEWQXPGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C724824689
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07FAF6F9A8;
	Fri, 14 Feb 2020 15:52:14 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E976F99E;
 Fri, 14 Feb 2020 15:52:06 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7547F24673;
 Fri, 14 Feb 2020 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581695526;
 bh=i0s+C8qHpiEsBD8BAnRqp9HW0tJMGETCCnpdyVGRr4s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oEWQXPGasCZLhq17fQpmk2U84ItmGxENVmh4TGraDJH0KM/x9uKcrtRsWurxKjBOa
 SMbr9rGKaPvYFor9HhdkZnt7l5arMc7JE1NM2pbBUumaSfsXC0cbcW1EV5JysCmhdY
 e0ZFzEnpgoMWR2QCXOV+1d3RONPK6Yl/GIzq2jko=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 147/542] drm/amdgpu: remove set but not used
 variable 'amdgpu_connector'
Date: Fri, 14 Feb 2020 10:42:19 -0500
Message-Id: <20200214154854.6746-147-sashal@kernel.org>
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

RnJvbTogeXUga3VhaSA8eXVrdWFpM0BodWF3ZWkuY29tPgoKWyBVcHN0cmVhbSBjb21taXQgNGYy
OTIyZDEyZDZjNjNkMGY0YWE0ZTg1OWFkOTVhZWU2ZDBkNGVhMCBdCgpGaXhlcyBnY2MgJy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6Cgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGlzcGxheS5jOiBJbiBmdW5jdGlvbgrigJhhbWRncHVfZGlzcGxheV9jcnRjX3Nj
YWxpbmdfbW9kZV9maXh1cOKAmToKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c3BsYXkuYzo2OTM6Mjc6IHdhcm5pbmc6IHZhcmlhYmxlCuKAmGFtZGdwdV9jb25uZWN0b3LigJkg
c2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KCkZpeGVzOiBkMzhj
ZWFmOTllZDAgKCJkcm0vYW1kZ3B1OiBhZGQgY29yZSBkcml2ZXIgKHY0KSIpClNpZ25lZC1vZmYt
Ynk6IHl1IGt1YWkgPHl1a3VhaTNAaHVhd2VpLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZp
biA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rpc3BsYXkuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCmluZGV4IDNjYWRiMGI3
NmYyMjEuLjRlNjk5MDcxZDE0NDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNwbGF5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rpc3BsYXkuYwpAQCAtNjkwLDcgKzY5MCw2IEBAIGJvb2wgYW1kZ3B1X2Rpc3BsYXlfY3J0
Y19zY2FsaW5nX21vZGVfZml4dXAoc3RydWN0IGRybV9jcnRjICpjcnRjLAogCXN0cnVjdCBhbWRn
cHVfY3J0YyAqYW1kZ3B1X2NydGMgPSB0b19hbWRncHVfY3J0YyhjcnRjKTsKIAlzdHJ1Y3QgYW1k
Z3B1X2VuY29kZXIgKmFtZGdwdV9lbmNvZGVyOwogCXN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25u
ZWN0b3I7Ci0Jc3RydWN0IGFtZGdwdV9jb25uZWN0b3IgKmFtZGdwdV9jb25uZWN0b3I7CiAJdTMy
IHNyY192ID0gMSwgZHN0X3YgPSAxOwogCXUzMiBzcmNfaCA9IDEsIGRzdF9oID0gMTsKIApAQCAt
NzAyLDcgKzcwMSw2IEBAIGJvb2wgYW1kZ3B1X2Rpc3BsYXlfY3J0Y19zY2FsaW5nX21vZGVfZml4
dXAoc3RydWN0IGRybV9jcnRjICpjcnRjLAogCQkJY29udGludWU7CiAJCWFtZGdwdV9lbmNvZGVy
ID0gdG9fYW1kZ3B1X2VuY29kZXIoZW5jb2Rlcik7CiAJCWNvbm5lY3RvciA9IGFtZGdwdV9nZXRf
Y29ubmVjdG9yX2Zvcl9lbmNvZGVyKGVuY29kZXIpOwotCQlhbWRncHVfY29ubmVjdG9yID0gdG9f
YW1kZ3B1X2Nvbm5lY3Rvcihjb25uZWN0b3IpOwogCiAJCS8qIHNldCBzY2FsaW5nICovCiAJCWlm
IChhbWRncHVfZW5jb2Rlci0+cm14X3R5cGUgPT0gUk1YX09GRikKLS0gCjIuMjAuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
