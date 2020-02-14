Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E9DC3B1A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016A0222C2
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKbM3PdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016A0222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 774DC6FA29;
	Fri, 14 Feb 2020 16:04:32 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E886FA29;
 Fri, 14 Feb 2020 16:04:31 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7A4D24682;
 Fri, 14 Feb 2020 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581696271;
 bh=6Kpp5XQKnfldJow9/7QSpRHsX4NN+KQgo4uwuk5uwe4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vKbM3PdRgbh7/UMgDw5RTcENmjGZskxzEr7mxldMudvKJCneNOSng2rXQrU2H+fve
 XdV+Osl4L3QudNRtcjsxiHEwitPkevZEyUj1N27LZdfVsJPc40ORedyGj9DpWBC8/6
 0m/6MIBEN2LhDAuJdJF2AFiWPPpMh8q4O85gggVs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 122/459] drm/amdgpu: remove always false
 comparison in 'amdgpu_atombios_i2c_process_i2c_ch'
Date: Fri, 14 Feb 2020 10:56:12 -0500
Message-Id: <20200214160149.11681-122-sashal@kernel.org>
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

RnJvbTogeXUga3VhaSA8eXVrdWFpM0BodWF3ZWkuY29tPgoKWyBVcHN0cmVhbSBjb21taXQgMjIw
YWM4ZDE0NDQwNTRhZGUwN2NlMTQ0OThmY2RhMjY2NDEwZjkwZSBdCgpGaXhlcyBnY2MgJy1XdHlw
ZS1saW1pdHMnIHdhcm5pbmc6Cgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19p
MmMuYzogSW4gZnVuY3Rpb24K4oCYYW1kZ3B1X2F0b21iaW9zX2kyY19wcm9jZXNzX2kyY19jaOKA
mToKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfaTJjLmM6Nzk6MTE6IHdhcm5p
bmc6IGNvbXBhcmlzb24gaXMKYWx3YXlzIGZhbHNlIGR1ZSB0byBsaW1pdGVkIHJhbmdlIG9mIGRh
dGEgdHlwZSBbLVd0eXBlLWxpbWl0c10KCidudW0nIGlzICd1OCcsIHNvIGl0IHdpbGwgbmV2ZXIg
YmUgZ3JlYXRlciB0aGFuICdUT01fTUFYX0hXX0kyQ19SRUFEJywKd2hpY2ggaXMgZGVmaW5lZCBh
cyAyNTUuIFRoZXJlZm9yZSwgdGhlIGNvbXBhcmlzb24gY2FuIGJlIHJlbW92ZWQuCgpGaXhlczog
ZDM4Y2VhZjk5ZWQwICgiZHJtL2FtZGdwdTogYWRkIGNvcmUgZHJpdmVyICh2NCkiKQpTaWduZWQt
b2ZmLWJ5OiB5dSBrdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogU2FzaGEg
TGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2F0b21iaW9zX2kyYy5jIHwgNSAtLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfaTJjLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19pMmMuYwppbmRleCA5ODBjMzYz
YjFhMGFlLi5iNGNjN2M1NWZhMTZmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hdG9tYmlvc19pMmMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9t
Ymlvc19pMmMuYwpAQCAtNzYsMTEgKzc2LDYgQEAgc3RhdGljIGludCBhbWRncHVfYXRvbWJpb3Nf
aTJjX3Byb2Nlc3NfaTJjX2NoKHN0cnVjdCBhbWRncHVfaTJjX2NoYW4gKmNoYW4sCiAJCX0KIAkJ
YXJncy5scEkyQ0RhdGFPdXQgPSBjcHVfdG9fbGUxNihvdXQpOwogCX0gZWxzZSB7Ci0JCWlmIChu
dW0gPiBBVE9NX01BWF9IV19JMkNfUkVBRCkgewotCQkJRFJNX0VSUk9SKCJodyBpMmM6IHRyaWVk
IHRvIHJlYWQgdG9vIG1hbnkgYnl0ZXMgKCVkIHZzIDI1NSlcbiIsIG51bSk7Ci0JCQlyID0gLUVJ
TlZBTDsKLQkJCWdvdG8gZG9uZTsKLQkJfQogCQlhcmdzLnVjUmVnSW5kZXggPSAwOwogCQlhcmdz
LmxwSTJDRGF0YU91dCA9IDA7CiAJfQotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
