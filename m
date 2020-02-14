Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA5C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840FD247A7
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBCmckpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840FD247A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D0716FB42;
	Fri, 14 Feb 2020 16:25:00 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE946FB3B;
 Fri, 14 Feb 2020 16:24:57 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EFD34247B6;
 Fri, 14 Feb 2020 16:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581697497;
 bh=Yu5GErkoSoCo/cmmcBfRhCwV+dtTT0+BkyMOarjkies=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pBCmckpVUi0NRUtu79rWBj2ln8Zrzfc9iR83SdmqlWRMTwTnTIT2CXSa/CmBJmBMk
 GRoAAg5KigzO8W68Kq2Gt6sP6uc+R/rYuNT2dTg7DR2Ump73Pi76JH++ycULq/4oKO
 MYcxyF/WMlu88kAu94AL/DXc9Sj5rxvVCEny3m1s=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 026/100] drm/amdgpu: remove set but not used
 variable 'amdgpu_connector'
Date: Fri, 14 Feb 2020 11:23:10 -0500
Message-Id: <20200214162425.21071-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
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
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCmluZGV4IGM1NTU3ODE2
ODVlYTguLjhiM2EzM2FlNDRlZDggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNwbGF5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rpc3BsYXkuYwpAQCAtNjkzLDcgKzY5Myw2IEBAIGJvb2wgYW1kZ3B1X2NydGNfc2NhbGlu
Z19tb2RlX2ZpeHVwKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywKIAlzdHJ1Y3QgYW1kZ3B1X2NydGMg
KmFtZGdwdV9jcnRjID0gdG9fYW1kZ3B1X2NydGMoY3J0Yyk7CiAJc3RydWN0IGFtZGdwdV9lbmNv
ZGVyICphbWRncHVfZW5jb2RlcjsKIAlzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yOwot
CXN0cnVjdCBhbWRncHVfY29ubmVjdG9yICphbWRncHVfY29ubmVjdG9yOwogCXUzMiBzcmNfdiA9
IDEsIGRzdF92ID0gMTsKIAl1MzIgc3JjX2ggPSAxLCBkc3RfaCA9IDE7CiAKQEAgLTcwNSw3ICs3
MDQsNiBAQCBib29sIGFtZGdwdV9jcnRjX3NjYWxpbmdfbW9kZV9maXh1cChzdHJ1Y3QgZHJtX2Ny
dGMgKmNydGMsCiAJCQljb250aW51ZTsKIAkJYW1kZ3B1X2VuY29kZXIgPSB0b19hbWRncHVfZW5j
b2RlcihlbmNvZGVyKTsKIAkJY29ubmVjdG9yID0gYW1kZ3B1X2dldF9jb25uZWN0b3JfZm9yX2Vu
Y29kZXIoZW5jb2Rlcik7Ci0JCWFtZGdwdV9jb25uZWN0b3IgPSB0b19hbWRncHVfY29ubmVjdG9y
KGNvbm5lY3Rvcik7CiAKIAkJLyogc2V0IHNjYWxpbmcgKi8KIAkJaWYgKGFtZGdwdV9lbmNvZGVy
LT5ybXhfdHlwZSA9PSBSTVhfT0ZGKQotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
