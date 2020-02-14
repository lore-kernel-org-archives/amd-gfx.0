Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09EDC3B19D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788BF222C2
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAQUOYZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788BF222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA376FA28;
	Fri, 14 Feb 2020 16:04:31 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642196FA28;
 Fri, 14 Feb 2020 16:04:30 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7C2E524680;
 Fri, 14 Feb 2020 16:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581696270;
 bh=CgOBLdHrxGOXZAzERnI7Kbvc+MZaRctwhAPR2UygNZk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fAQUOYZOg5E+S3YRR+ecwOcKeAW0J6t4gTIjFDajHZo/9N0wBowy9+ipMU7zT48o3
 RqPd6dlFbf/PVJTcX+QXIw92PQBkvVmO1CsgdyImFmZG823zV1QuY9waHwvfTCYq2c
 qIXuvV/lb7ia91ai0wjni2P6nnwKVcL3+bOir+js=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 121/459] drm/amdgpu: remove set but not used
 variable 'dig'
Date: Fri, 14 Feb 2020 10:56:11 -0500
Message-Id: <20200214160149.11681-121-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
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

RnJvbTogeXUga3VhaSA8eXVrdWFpM0BodWF3ZWkuY29tPgoKWyBVcHN0cmVhbSBjb21taXQgZDFk
MDlkYzQxNzgyNmY1YTk4M2UwZjRmMjEyZjIyN2JlZWI2NWUyOSBdCgpGaXhlcyBnY2MgJy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6Cgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hdG9tYmlvc19kcC5jOiBJbiBmdW5jdGlvbgrigJhhbWRncHVfYXRvbWJpb3NfZHBfbGlua190
cmFpbuKAmToKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZHAuYzo3MTY6MzQ6
IHdhcm5pbmc6IHZhcmlhYmxlIOKAmGRpZ+KAmQpzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1i
dXQtc2V0LXZhcmlhYmxlXQoKRml4ZXM6IGQzOGNlYWY5OWVkMCAoImRybS9hbWRncHU6IGFkZCBj
b3JlIGRyaXZlciAodjQpIikKU2lnbmVkLW9mZi1ieTogeXUga3VhaSA8eXVrdWFpM0BodWF3ZWku
Y29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19kcC5jIHwgMiAtLQogMSBmaWxlIGNo
YW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYXRvbWJpb3NfZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2F0b21iaW9z
X2RwLmMKaW5kZXggOTQyNjUzMDZhYjExZi4uZWE3MDJhNjRmODA3NCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZHAuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hdG9tYmlvc19kcC5jCkBAIC03MTAsNyArNzEwLDYgQEAgdm9pZCBhbWRn
cHVfYXRvbWJpb3NfZHBfbGlua190cmFpbihzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIsCiAJ
c3RydWN0IGRybV9kZXZpY2UgKmRldiA9IGVuY29kZXItPmRldjsKIAlzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7CiAJc3RydWN0IGFtZGdwdV9lbmNvZGVyICph
bWRncHVfZW5jb2RlciA9IHRvX2FtZGdwdV9lbmNvZGVyKGVuY29kZXIpOwotCXN0cnVjdCBhbWRn
cHVfZW5jb2Rlcl9hdG9tX2RpZyAqZGlnOwogCXN0cnVjdCBhbWRncHVfY29ubmVjdG9yICphbWRn
cHVfY29ubmVjdG9yOwogCXN0cnVjdCBhbWRncHVfY29ubmVjdG9yX2F0b21fZGlnICpkaWdfY29u
bmVjdG9yOwogCXN0cnVjdCBhbWRncHVfYXRvbWJpb3NfZHBfbGlua190cmFpbl9pbmZvIGRwX2lu
Zm87CkBAIC03MTgsNyArNzE3LDYgQEAgdm9pZCBhbWRncHVfYXRvbWJpb3NfZHBfbGlua190cmFp
bihzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIsCiAKIAlpZiAoIWFtZGdwdV9lbmNvZGVyLT5l
bmNfcHJpdikKIAkJcmV0dXJuOwotCWRpZyA9IGFtZGdwdV9lbmNvZGVyLT5lbmNfcHJpdjsKIAog
CWFtZGdwdV9jb25uZWN0b3IgPSB0b19hbWRncHVfY29ubmVjdG9yKGNvbm5lY3Rvcik7CiAJaWYg
KCFhbWRncHVfY29ubmVjdG9yLT5jb25fcHJpdikKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
